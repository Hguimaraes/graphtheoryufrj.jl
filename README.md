[![Build Status](https://travis-ci.org/Hguimaraes/graphtheoryufrj.jl.svg?branch=master)](https://travis-ci.org/Hguimaraes/graphtheoryufrj.jl)

## graphtheoryufrj.jl

A Julia package with graph algorithms for the course <i>"Graph Theory" (COS242)</i> at UFRJ.

## How to use it

```Julia
    Pkg.clone("https://github.com/Hguimaraes/graphtheoryufrj.jl.git")
    using graphtheoryufrj
```

## Dependencies
 All the dependencies are in the REQUIRE file and will be download when you clone the package. But in order to run the "graph_coloring.jl" you need to install the Gurobi Solver and the package associated by:

 ```Julia
     Pkg.add("Gurobi")
```

## Performance test
