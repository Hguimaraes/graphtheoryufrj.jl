include("graphtheoryufrj.jl")
g = graphtheoryufrj

#compilation run
a = g.simpleGraph("as_graph.txt")
g.bfs(a.Graph)
a = 0

#generate the timings for the report
#as_graph

outfile = open("as_graph_report.txt", "w")
as_graph_list = g.simpleGraph("as_graph.txt")
as_graph_matrix = g.simpleGraph("as_graph.txt", format = "adjmatrix")

write(outfile, string("adjacency list size ", sizeof(as_graph_list.Graph),"\n"))
write(outfile, string("adjacency matrix size ", sizeof(as_graph_matrix.Graph),"\n"))

close(outfile)

outfile = open("subdblp_report.txt", "w")
subdblp_list = g.simpleGraph("subdblp.txt")
subdblp_matrix = g.simpleGraph("subdblp.txt", format = "adjmatrix")

write(outfile, string("adjacency list size ", sizeof(subdblp_list.Graph),"\n"))
write(outfile, string("adjacency matrix size ", sizeof(subdblp_matrix.Graph),"\n"))

close(outfile)

outfile = open("dblp_report.txt", "w")
dblp_list = g.simpleGraph("dblp.txt")
#as_graph_matrix = g.simpleGraph("as_graph.txt", format = "adjmatrix")

write(outfile, string("adjacency list size ", sizeof(dblp_list.Graph),"\n"))
#write(outfile, string("adjacency matrix size ", sizeof(as_graph_matrix.Graph),"\n"))

close(outfile)
