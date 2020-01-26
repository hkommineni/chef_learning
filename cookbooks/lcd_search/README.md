# lcd_search



Search
	What data is indexed and searchable?
	Why you would search in a recipe?
	Search criteria syntax?
	How to invoke a search from command line?
	How to invoke a search from within a recipe?
	

	Using search allows you to facilitate more dynamic configurations by asking questions about aspects of your infrastructure.
	
	It helps to keep data and configurations (code) seperate.
	
	Search works on one of the following indexes:
		client
		environment
		node
		role
		data bag name

Knife Search
	The knife-search command is the ChefDl tool which can be used to search from command line
	
	Searches contain the index to be searched and a key with a pattern to search. INDEX will be the client, environment, node, role, or name ofa data bag.
	When the index is not specified, the default is to search the node index.
	
		knife search INDEX SEARCH_QUERY
		
	The SEARCH_QUERY component is comprised of a key and pattern. Where key is a field name that is found in the JSON description of an indexable object on the Chef server (a role, node, client, environment or data bag).
	And search_pattern defines what will be searcged for, suing one of the following search patterns: exact, wildcard, range or fuzzy matching.
	
	The data being searched can be a nested JSON data structure which can be multiple layers deep. These nested fields become flattened for search. That means the nexted elements become valida keys for search:
		knife search node "mtu:1500"
	Opearators are also allowed in search quesries AND, OR and NOT can be used to create inclusions or exclusions in your search pattern. You can also use basic wildcards like * to glob and ? to replace a single character in a search:
		knife search admins "gid:developers AND id:j*"
		
	The ability to search nested attributes is available via the -a switch, and the main and nested attribute value:
		knife search node <query_to_run> -a <main_attribute>.<nested_attribute>
		knife search role "*:*" -a override_attributes.haproxy.app_servers_role
	
	
Using search in Recipes
	Since the data bags are a kind of index that can be searched, they can also be used with the recipe DSL search method. Items returned by a search can be used as if they were a hash.
	
		admins = []
		search(:admins, "gid:administrators").each do |admin|
			group admin['gid']
			login = admin["id"]
			admins << login
			home = "/home/#{login}
			
			user(login) do
				uid admin['uid']
				gid admin['gid']
				shell admin['shell']
				comment admin['shell']
				home home
				manage_home true
			end
		end
