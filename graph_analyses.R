#########################
# In this R file we take the cosine similarity matrix generated in python and turn it into graphs
# we will output the clustering results and go back to python for sensemaking
#########################

#initialisation
library(igraph)
#chose one
cosine_sim_matrix <- read.csv('data/cosine_sim_matrix.csv')[,-1]
cosine_sim_matrix <- read.csv('data/phrasic_sim_matrix.csv')[,-1]

#create graph
cosine_sim_matrix <- data.matrix(cosine_sim_matrix)
sim_graph <- graph_from_adjacency_matrix(
    cosine_sim_matrix, 
    mode = 'undirected',
    weighted = TRUE,
    diag = FALSE
    )

#trim graph by weights
cosine_sim_edges <- as_data_frame(sim_graph)
summary(cosine_sim_edges$weight)

weight_cutoff <- 0.05
cosine_sim_edges <- cosine_sim_edges[cosine_sim_edges$weight > weight_cutoff,]
kept_nodes <- unique(c(cosine_sim_edges$from, cosine_sim_edges$to))
length(kept_nodes) #number of nodes left after trimming
nrow(cosine_sim_edges)/((length(kept_nodes)^2)/2) #an inituitive density
sim_graph <- graph_from_data_frame(cosine_sim_edges, vertices = kept_nodes, directed = F)

#set attributes
V(sim_graph)$size <- 2
V(sim_graph)$label <- NA
E(sim_graph)$width <- (E(sim_graph)$weight * 100)**(1/100) / 3 #change this equation to adjust visuals

#create cluster - try to change to cutoffs to make sure about consistencies
c <- cluster_label_prop(sim_graph)
table(c$membership)

#colour graph by membership
graph_coloured <- sim_graph
V(graph_coloured)$color <- c$membership

l <- layout_with_lgl(sim_graph)

pdf(width = 9, height = 9, 'results/cosine_results.pdf')
plot(sim_graph, layout = l, vertex_label = NULL)
plot(graph_coloured, layout = l, vertex_label = NULL)
dev.off()

#run this if there are clusters
cluster_results <- data.frame(
    user_id = c$names,
    membership = c$membership,
    modularity = c$modularity
)
write.csv(cluster_results, 'results/cosine_clusters.csv')
