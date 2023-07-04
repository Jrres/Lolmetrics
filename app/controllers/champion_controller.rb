# require 'csv'
# class ChampionController < LeagueController
#   def index
#     populateTable()
#   end
#   def populateTable
# table = CSV.parse(File.read('C:\Users\jackr\leaguebp\app\app\assets\data\leaguenames.csv'))
#     table.each do |row|
#         # row[0] gives each name
#       name = find_name(row[0])
#       unless name.size!=1
#         flash[:alert]="summoner name not found"
#         return render action: :index;
#     end
#     puts name
#       matchIDS = find_matches(name['puuid'])
#       matchIDS.each do |matchID|
#         match = find_match(matchID)
#         match['info']['participants'].each do |val|
          
#             champ = val['championName']
#             win = val['win']
#             rune1 = val['perks']['styles'][0]['selections'][0]['perk']
#             var1 = val['perks']['styles'][0]['selections'][0]['var1']
#             var2 = val['perks']['styles'][0]['selections'][0]['var2']
#             var3 = val['perks']['styles'][0]['selections'][0]['var3']
#             won = 1
#             loss = 1
#             puts champ, win, rune1, var1, var2, var3
#             if(win)
#               loss=0
#             else
#               won = 0
#             end
#             CSV.open("champdatawithruneandwinloss.csv", "a+") do |csv|
#               csv << [champ, won, loss, rune1,var1,var2,var3]
#               csv << [""]
#             end
#         end
      
#       end
#     end

#   end
#   def create(name,win,loss,first,second,third,fourth)
#     @champ = Champion.new(name:name,win:win,loss:loss,firstrune:first,secondrune:second,thirdrune:third,fourthrune:fourth)
#     puts Champion.all
#     @champ.save
#   end
#   def new 
#     @champ=Champion.new
#   end
#   def all
#     @champ = Champion.all
#   end 
# end
