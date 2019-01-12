require 'ruby2d'
puts "Anthill"

class Board 
    def initialize(w, h, n)
        @@width = w
        @@height = h
        @@name = n
    end

    def getWidth
        @@width
    end

    def getHeight
        @@height
    end
    def getName
        @@name
    end
    def self.info()
        puts "Boardgame (w: #@@width, h: #@@height )"
    end
end


class Ant < Sprite

    def self.info()
    end
    def setXCord(x, w, value)
        if x <= w and x > 0
            @@x = Random.new().rand(x - value...x + value)
        else
            @@x = Random.new().rand(x - 2*value...(x-value).abs)
        end
    end   
    def setYCord(y, h, value)
        if y <= h and y > 0
	    #yyy = Random.new(value...y)
            @@y = Random.new().rand(y- value...y + value)
        else
            @@y = Random.new().rand(y - 2*value...(y - value).abs)
        end
    end
    def getXCord
	@@x
    end
    def getYCord
	@@y
    end
    def colision(j, antA, ary)
        for i in 0..ary.length-1
            if (antA.x == ary[i].x && antA.y == ary[i].y )
#                && j != i
                return true
            else
                return false
            end
        end
    end 
    def crash(j, x, y, ary, toDelete)
	stringg = "ecrash: j= #{j} j.x = #{x} j.y #{y}"
	puts stringg
	for i in 0..ary.length-1
		if i == j
			puts 'to oryginalna mrowka'
		end
		if (i != j && x == ary[i].x && y == ary[i].y)
			#ary.delete_at(j)
			puts 'HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALOOOOOOOOOOOOOOOOOOOOO'
			puts "do usuniecia mrowka o pozycji #{j}"
			toDelete.push(j)
			#ary[j].remove
		end
	end
    end

end

ary = Array.new 
toDelete = Array.new
$i = 1
$howManyAnts = 100
tick = 0

board = Board.new(600,600, "Boardgame")
Board.info()
set title: board.getName
set background: '#00B200'
set resizable: false
set diagonostics: true
set width: board.getWidth
set height: board.getHeight

while $i <= $howManyAnts do
    ary.push(Ant.new('art.png',x: Random.new().rand(board.getWidth), y: Random.new().rand(board.getHeight), w: 10, h: 10, z: 20))
    Ant.info()
    $i += 1
end





update do
  if tick % 10 == 0
      puts " ARRY LENGTH: #{ary.length} !!!!!!!!!!!!!!!!!!!!!!!"
      #sleep(2)
      for j in 0..ary.length-1 
	           
          ary[j].remove
          ary[j].x = ary[j].setXCord(ary[j].x, board.getWidth, 10)
          ary[j].y = ary[j].setYCord(ary[j].y, board.getHeight, 10)
          ary[j].add
          
	  puts "j: #{j} :: x: #{ary[j].getXCord} i y: #{ary[j].getYCord}"

	  ary[j].crash(j,ary[j].getXCord, ary[j].getYCord,ary,toDelete)
		

          j += 1
          
      end
	
      if toDelete.length != 0
	  puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          for i in 0..toDelete.length-1
	   puts "jest #{toDelete.length} mrowek do usuniecia"
	   index = toDelete.pop
	   ary[index].remove
	   ary.delete_at(index)
	   puts "mrowka #{index} usnieta"
          end
      end
  end
  

  tick += 1
end
show
