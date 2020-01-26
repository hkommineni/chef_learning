# lcd_compvconv

compile vs converge
  Compile: Each resource in the recipes are loaded from the recipes mentioned in run_list. 
  All cookbooks are loaded, recipes are built and resources are collected. 
  Pure ruby code is executed like variables, array iterations and conditions get evaluated
  Converge(execution) phase: Based on the order of resources collected are executed to achive the desired state
  
  Chef DSL, code in the ruby_blocks are excuted, guards like if, only_if are evaluated adn lazy evaluation are executed

