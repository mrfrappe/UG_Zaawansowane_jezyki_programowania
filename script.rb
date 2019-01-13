require 'ruby2d'
require 'ascii_charts'

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

class Counter < Text
    def setText(text)
        @@text = text
    end
end

class Ant < Sprite
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
			#puts "do usuniecia mrowka o pozycji #{i}"
			#if we find another ant, we push them into toDelete array
			toDelete.push(i)
		end
	end
    end

end

startTime = Time.new
$i = 1
$howManyAnts = 100
$antWidth = 10
$antHeight = 10
ary = Array.new 
toDelete = Array.new
time = Array.new
tick = 0
song = Music.new('sound.mp3')

board = Board.new(600,600, "Boardgame")
Board.info()
set title: board.getName
set background: '#00B200'
set resizable: false
set diagonostics: true
set width: board.getWidth
set height: board.getHeight


counter = Counter.new( text: $howManyAnts, x: board.getWidth - 40, y: board.getHeight - 35, font: 'vera.ttf', size: 30, color: 'red', rotate: 0, z: 100)

while $i <= $howManyAnts do
    ary.push(Ant.new('art.png',x: Random.new().rand(board.getWidth), y: Random.new().rand(board.getHeight), w: $antWidth, h: $antHeight, z: 20))
    $i += 1
end

update do
  if tick % 10 == 0
      # this puth should display in board
      #puts " ARRY LENGTH: #{ary.length}"
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
	  #puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          for i in 0..toDelete.length-1
	   #puts "jest #{toDelete.length} mrowek do usuniecia"
	   index = toDelete.shift
        endTime = Time.now
        song.play
	   ary[index].remove
        time.push([ary.length, (endTime-startTime)])
        counter.remove
	   ary.delete_at(index)
        counter= Counter.new(text: ary.length, x: board.getWidth - 40, y: board.getHeight - 35, font: 'vera.ttf', size: 30, color: 'red', rotate: 0, z: 100)
	   #puts "mrowka #{index} usnieta"
          end
      end
  end
    ## data must be a pre-sorted array of x,y pairs
    chart = AsciiCharts::Cartesian.new((time), :title => 'Time/Population').draw
    puts "\e[H\e[2J"
    puts chart
  tick += 1
    # Close the window after 1 ant left
  if ary.length == 1 then close end
end
show
