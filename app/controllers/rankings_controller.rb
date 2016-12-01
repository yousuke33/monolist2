class RankingsController < ApplicationController
    before_action :logged_in_user ,only: [:have, :want]
    
    def have
        @items = sort("Have")
    end
    def want
        @items = sort("Want")
    end
    
    private
    def sort(type)
        items = []
        item = Ownership.where(type: type)
        list = item.group(:item_id).count(:item_id).sort_by{|key,val| -val}
        list = list.slice(0,10)
        list.length.times do |i|
            index = list[i][0]
            items.push(Item.find_by(id: index))
        end
        return items
    end
end
