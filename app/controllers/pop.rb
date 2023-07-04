require 'csv'
table = CSV.parse(File.read('C:\Users\jackr\leaguebp\app\app\assets\data\leaguenames.csv'))
    table.each do |row|
        # row[0] gives each name
      name = find_name(row[0])
      matchIDS = find_matches(name['puuid'])
      matchIDS.each do |matchID|
        match = find_match(matchID)
        match['info']['participants'].each do |val|
            champ = val['championName']
            winrate = val['wins']
            rune1 = val['perks']['styles'][0]['selections']['perk']
            var1 = val['perks']['styles'][0]['selections']['var1']
            var2 = val['perks']['styles'][0]['selections']['var2']
            var3 = val['perks']['styles'][0]['selections']['var3']
            c = Champion.create(champ, winrate, rune1, var1, var2, var3)
        end
      
      end
    end
    puts table.length