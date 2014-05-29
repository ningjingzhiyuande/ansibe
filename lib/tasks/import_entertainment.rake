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
            begin
              u = Entretain.new
              u.title =  Entretain.titles_value(content.cell("B",i)) #content.cell("B",i)
              u.num=content.cell("O",i).to_i
              u.content=content.cell("C",i)  #.to_s+"@cnpe.cc"
              u.location=Entretain.locations_value(content.cell("D",i)) #content.cell("D",i)
              u.created_at=content.cell("G",i)
              u.updated_at=content.cell("M",i)
              u.user_id=User.find_by(name: content.cell("E",i)).try(:id)
              u.reporter_id= User.find_by(name: content.cell("H",i)).try(:id)  #content.cell("H",i).to_s[-6,6]
              u.last_reporter_id= User.find_by(name: content.cell("K",i)).try(:id)  #content.cell("H",i).to_s[-6,6]
              u.save
            rescue
            	next
            end
          # end
    	end
    	
   end
end