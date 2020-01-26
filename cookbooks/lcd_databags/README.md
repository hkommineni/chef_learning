# lcd_databags

Databags: Data bags are containers for information about your infrastructure that are not associated with a node. They provide and external source of information to be used in recipes and search the functionality.
  
  A data basg is a global varible stored as JSON data, and is accessibe via a Chef Server. Because the data bag is on the chef server, it acts as shared resource which chef clients can reference
  
  In addition to general purpose usage, data bags can also be used to encrypt sesitive information with a shared key to keep secret off of nodes
  
  
  ** DATA BAG COMMANDS **
knife data bag create BAG [ITEM] (options)
knife data bag delete BAG [ITEM] (options)
knife data bag edit BAG ITEM (options)
knife data bag from file BAG FILE|FOLDER [FILE|FOLDER..] (options)
knife data bag list (options)
knife data bag show BAG [ITEM] (options)

How to Create Data Bags

	A data bag can be created with knife or manually as a json file.
	
	when using knife to create a data bag, you can use the command below. In it, admins is the name of the data bag being create, and harish is the name of the item within the admins data bag. 
		knife data bag create admins harish
  
	A data bag can be created with knife, or manually as a JSON file. If you have source data, it can be loaded from a file:
		knife data bag from file admins <path to file>/harish.json
  
	As an example, the harish.json could look as follows:
		{
			"id": "Harish"
			"uid": "1001"
			"gid": "developers"
			"shell": "/bin/bash"
			"comment": "Harish"
		}
  
	When using a knife to edit a data bag you can use the command:
		knife data bag edit admins harish
		
	When using the knife to delete a data bag you can use the following command:
		knife data bag delete admins kommineni
		
	You will be prompted before deleting the item as a confirmation.
	
	You can also delete the entire data bag and everything in it by not specifying an element ID, like this:
		knife data bag delete admins
		
	Use the list sub-command to get the listing of the names of all the data bagas available:
		knife data bag list
	
	Use the show sub-command to list availble items within a bag. The example below shows admins, as the name of the data bag:
		knife data bag show admins
		
	Use the show sub-command along with an item name to output that item within a bag.This example has the admins as the name of a data bag and joe as the name of an item within that bag:
		knife data bag show admins harish
	
	Searching the data bags can be accomplished with knife search. It opeartes on a index when searching a data bag. The name of the bag is the index you are searching.
	
	Search contains both key and a pattern to search.
		knife search admins "id:harish"
	You can also include operators to include or exclude results:
		knife search admins "NOT id:tom"
		knife search admins "gid:developers OR gid:administrators"
		
	Wildcards are also an option:
		knife search admins "*:*"
		knife serach admins "gid:admin*"
		
Using Data Bags in Recipes
	The recipe DSL (Domain Specific Language) provides methods to interact with data bags called data_bag and data_bag_item. Listed below is an example of usage for each method:
	
		data_bag('admins')
		data_bag_item('admins','joe')
	
	These can be assigned as variables within recipe to consume in resources:
	
		admins = data_bag('admins')
		
		admins.each do |login|
			admin = data_bag_item('admins', login)
			group admin['gid']
		end
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

 
 
 What is Chef Vault?
 
	Vault allows the secure distribution of secrets as an alternative to encryoted data bags. Valut allows limiting which users and nodes have access to secrets
	
	Vault creates a data bag which is symmetrically encrypted using a random secret. A vault has a lits of administrative users and clients. 
	
	Vault is used when enchanced controls for managing secrets are needed
	
	It comes with the chef DK and is invoked with the knife vault command.
	
	It can be used on a per-user and per-node basis
	
	

