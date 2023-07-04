
require 'uri'
require 'net/http'
require 'csv'
class LeagueController < ApplicationController
    
    def index
    end
    def search
        name = find_name(params[:summoner])
        unless name.size!=1
            flash[:alert]="summoner name not found"
            return render action: :index;
        end
        @rank= find_rank(name['id'])
        if(@rank[0])
        @wr = @rank[0]['wins'].fdiv(@rank[0]['losses'])
        end
        matchIDS = find_matches(name['puuid'])
        matchList = Array.new(10);
        winlist = Array.new(10);
        @Ids = matchIDS
        mostplayed = Array.new(10);
        
        for i in 0..matchList.size-1 do
        matchList[i]=find_match(matchIDS[i])
            if  matchList[i]['info']
            for j in 0..matchList[i]['info']['participants'].size-1 do 
                player = matchList[i]['info']['participants'][j]['summonerName']
                
                if(player==name['name'])
                    mostplayed[i]=matchList[i]['info']['participants'][j]['championName']
                    teamId = matchList[i]['info']['participants'][j]['teamId']
                    
                    if(teamId ==matchList[i]['info']['teams'][0]['teamId'] )
                        win = matchList[i]['info']['teams'][0]['win']
                   
                    else
                        win = matchList[i]['info']['teams'][1]['win']
                    end
                    if(win==true)
                    winlist[i]="victory"
                    else
                        winlist[i]="defeat"
                    end
                end
            end
            end
        end
        @mp = samefreq(mostplayed).sort 
        @mplayed = mostplayed

        @wins = winlist
        @sum = name
        @matches = matchList        
        
    end
    def champion
        @selection = params[:selected]
        data = File.read("C:/Users/jackr/LEAGUERP/10.10.3224670/data/en_US/champion.json")
        @data_hash = JSON.parse(data)
        dh = JSON.parse(data)
        require 'algolia'

        # Connect and authenticate with your Algolia app
        client = Algolia::Search::Client.create('ANX2HGV4XV', '0fc723ec61ef5d70b9297755888a5e33')

        # Create a new index and add a record
        index = client.init_index('contacts')
        dh['data'].each do |val|
           
        record = { 'objectID': val[0], 'name': val[0], 'image': val[1]['image']['full']}
        index.save_object(record)
        end
        index.set_settings({
            searchableAttributes: [
              'name',
              'image'
            ]}
          )
          champinfo();

        # Search the index and print the results
    end
    def champinfo()
        @h = Hash.new("name")
        CSV.foreach("C:/Users/jackr/leaguebp/app/champinfo.csv",) do |row|
            @h[row[0]]={win:row[1].to_i,loss:row[2].to_i,perk:row[3].to_i,rune2:row[4].to_i,winrate:row[8].to_i,games:row[9].to_i}
        end
    end
    def select
        @selected = params[:selected]
    end
    def summonerId()
        id = params[:id]
        data = File.read("../../../10.10.3224670/data/en_US/summoner.json")
        data_hash = JSON.parse(data)
        summonerspell = data_hash['data'].each{|sums|
        if(sums[id]==id)
            value = sums['image']['full']
        end
        }
        value
        # return the value of the image in json file
    end
    private
    def request_api(u)
        url = URI(u)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
     
        response = http.request(request)
        body = JSON.parse(response.body)
        
    end
    def find_rank(id)
        request_api(
            "https://na1.api.riotgames.com/lol/league/v4/entries/by-summoner/#{URI.encode_uri_component(id)}?api_key=#{Rails.application.credentials[:api_key]}"
        )
    end
    def find_name(name)
      request_api(
        "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{URI.encode_uri_component(name)}?api_key=#{Rails.application.credentials[:api_key]}"
      )
    end
    def find_matches(match)
        request_api(
            "https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/#{URI.encode_uri_component(match)}/ids?start=0&count=20&api_key=#{Rails.application.credentials[:api_key]}"
        )
    end
    def find_match(id)
        request_api(
            "https://americas.api.riotgames.com/lol/match/v5/matches/#{URI.encode_uri_component(id)}?api_key=#{Rails.application.credentials[:api_key]}"
        )
    end
    def samefreq(array)
        mp = Hash.new(0)
        array.each{|key| mp[key] += 1}
        mp
    end

end
