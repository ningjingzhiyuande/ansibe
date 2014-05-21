namespace :user do
	
   desc 'import user' 
   task :import => :environment do 
   	    
    	#puts  "导入用户的文件地址(绝对的地址)\n"
    	#file =  STDIN.gets.chomp
    	file = "/Users/sgd/Downloads/users.rtf"
    	content = File.open(file).read 
    	content.split(",").each do |line|
        	puts line.to_s
        end

   end
end