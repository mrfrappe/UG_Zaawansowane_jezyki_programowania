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

    def crash(j, x, y, ary, toDelete)
	stringg = "ecrash: j= #{j} j.x = #{x} j.y #{y}"
	#puts stringg
	for i in 0..ary.length-1
	# i!= j because the position of "j" ant is passed and we looking for another ants and which affects the ants j.
		if (i!= j && (x-$antWidth/2...x+$antWidth/2).include?(ary[i].x) && (y-$antHeight/2...y+$antHeight/2).include?(ary[i].y))
			puts "do usuniecia mrowka o pozycji #{i}"
			#if we find another ant, we push them into toDelete array
			toDelete.push(i)
		end
	end
    end

end


$i = 1
$howManyAnts = 100
$antWidth = 10
$antHeight = 10
ary = Array.new 
toDelete = Array.new
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
    ary.push(Ant.new('art.png',x: Random.new().rand(board.getWidth), y: Random.new().rand(board.getHeight), w: $antWidth, h: $antHeight, z: 20))
    Ant.info()
    $i += 1
end


update do
  if tick % 10 == 0
      # this puth should display in board
      puts " ARRY LENGTH: #{ary.length}"
      #sleep(2)
      for j in 0..ary.length-1 
	           
          ary[j].remove
          ary[j].x = ary[j].setXCord(ary[j].x, board.getWidth, 10)
          ary[j].y = ary[j].setYCord(ary[j].y, board.getHeight, 10)
          ary[j].add
          
	  #puts "j: #{j} :: x: #{ary[j].getXCord} i y: #{ary[j].getYCord}"

	  ary[j].crash(j,ary[j].getXCord, ary[j].getYCord,ary,toDelete)

          j += 1
          
      end
	
      if toDelete.length != 0
	  puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          for i in 0..toDelete.length-1
	   puts "jest #{toDelete.length} mrowek do usuniecia"
	   index = toDelete.shift
	   ary[index].remove
	   ary.delete_at(index)
	   puts "mrowka #{index} usnieta"
          end
      end
  end
  

  tick += 1
end
show
