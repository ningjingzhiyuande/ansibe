require 'spreadsheet'
namespace :entertainment do
	
   desc 'import entertainment' 
   task :import => :environment do 

    	puts  "/home/yang/Desktop/tb_yanqing.xls\n"
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
              hash["user_id"]=User.find_by(name: content.cell("E",i).to_i).try(:id)
              hash["reporter_id"]= User.find_by(name: content.cell("H",i).to_i).try(:id)  #content.cell("H",i).to_s[-6,6]
              hash["last_reporter_id"]= User.find_by(name: content.cell("K",i).to_i).try(:id)  #content.cell("H",i).to_s[-6,6]
              puts hash.inspect


            u = Entretain.new(hash)
            u.title = content.cell("B",i).to_i
            u.location = content.cell("D",i).to_i

            u.save
          # end
    	end
    	
   end
end