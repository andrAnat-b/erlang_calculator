# Ihor Horobets
```
1>  c(calculator).
{ok,calculator}
2> calculator:start(1,2).
{ok,<0.93.0>}
3> calculator:get_history().
[]
4> calculator:get_history().
[]
5> calculator:compute({plus,5,5}).
{{plus,5,5},10}
6> calculator:compute({plus,5,5}).
{{plus,5,5},10}
7> calculator:get_history().
[{{plus,5,5},10},{{plus,5,5},10}]
8> calculator:compute({plus,5,5}).
{{plus,5,5},10}
9> calculator:get_history().
[{{plus,5,5},10},{{plus,5,5},10},{{plus,5,5},10}]
10>
```