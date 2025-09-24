# Invoke-TopologicalSort

`Invoke-TopologicalSort` is a PowerShell function that performs a topological sort on a directed acyclic graph (DAG) represented as a hashtable of adjacency lists. It returns an ordered list of nodes such that for every directed edge `U -> V`, node `U` comes before `V` in the output. Optionally, you can reverse the sorted order.

This can be useful for dependency resolution, build pipelines, task ordering, or any scenario where you need to process nodes in a sequence that respects their dependencies.
