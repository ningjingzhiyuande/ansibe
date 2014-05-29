require 'spreadsheet'
namespace :entertainments do
	
   desc 'import entertainments' 
   task :import => :environment do 

    	puts  "导入用户的文件地址(绝对的地址)\n"
    	file =  STDIN.gets.chomp
    	#file = "/home/yang/Sites/ansibe/CGBPDetail.xls"
    	content = Roo::Spreadsheet.open(file)
    	#binding.pry
    	(1..155).to_a.each do |i|
           hash={}
          # ["A","B","C","H"].each do |col|
              hash["title"]=content.cell("B",i)
              hash["num"]=content.cell("O",i)
              hash["content"]=content.cell("C",i)  #.to_s+"@cnpe.cc"
              hash["location"]=content.cell("D",i)
              hash["created_at"]=content.cell("G",i)
              hash["updated_at"]=content.cell("M",i)
              hash["user"]=User.find_by(name: content.cell("E",i).to_i)
              hash["reporter"]= User.find_by(name: content.cell("H",i).to_i)  #content.cell("H",i).to_s[-6,6]
              hash["last_reporter"]= User.find_by(name: content.cell("k",i).to_i)  #content.cell("H",i).to_s[-6,6]
              puts hash.inspect


            u = User.new(hash)
            u.department = content.cell("C",i).to_i
            u.save
          # end
    	end
    	
   end
end