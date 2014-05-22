require 'spreadsheet'
namespace :user do
	
   desc 'import user' 
   task :import => :environment do 

    	#puts  "导入用户的文件地址(绝对的地址)\n"
    	#file =  STDIN.gets.chomp
    	file = "/Users/sgd/Downloads/CGBPDetail.xls"
    	content = Roo::Spreadsheet.open(file)
    	#binding.pry
    	(2..481).to_a.each do |i|
           hash={}
          # ["A","B","C","H"].each do |col|
              hash["name"]=content.cell("A",i)
              hash["email"]=content.cell("B",i).to_s+"@cnpe.cc"
              hash["username"]=content.cell("B",i)
              hash["department"]=content.cell("C",i).to_i
              hash["password"]= "123456"  #content.cell("H",i).to_s[-6,6]
              puts hash.inspect
           User.create(hash)
          # end
    	end
    	
   end
end