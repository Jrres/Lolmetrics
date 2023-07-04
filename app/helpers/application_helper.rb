module ApplicationHelper
    def summonerId(id)
    
        data = File.read("C:/Users/jackr/LEAGUERP/10.10.3224670/data/en_US/summoner.json")
        data_hash = JSON.parse(data)
        value=''
        data_hash['data'].each{|sums|
         
        if(Integer(sums[1]['key'],'')==id)
            value = sums[1]['image']['full']
        end
        }
        value
        # return the value of the image in json file
    end
    def runeId(id,hash)

        data = File.read("C:/Users/jackr/LEAGUERP/10.10.3224670/data/en_US/runesReforged.json")
        data_hash = JSON.parse(data)
        value=''
        
        data_hash.each{|runes|
            
            runes['slots'].each{|r|
                r['runes'].each{|key|
                 
                    if(key['id']==hash || key['id']==id )
                        return key['icon']
                    end 
                }
            }
      
        }
        return "perk-images/Styles/Precision/LethalTempo/LethalTempoTemp.png"
    end
    def maxKd(ad,arr)
        arr.each{|a|
            if(ad<a['kills'])
                return false
            end
        }
       return true
    end
    def getMax(arr)
        val=0
        arr.each{|a|
            val=[val,a['totalDamageDealt']].max
        }
       return val
    end
end
