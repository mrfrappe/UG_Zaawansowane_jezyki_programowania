require 'ruby2d'
require 'ascii_charts'


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
    def upDateC(newText, width, height)
	$counter.remove
	$counter = Counter.new(text: newText, x: width - 40, y: height - 35, font: 'vera.ttf', size: 30, color: 'red', rotate: 0, z: 100)
    end
end

class Ant < Sprite
    def setXCord(x, w)
       @@x = rand(x - $antWidth...x + $antWidth)
    end   
    def setYCord(y, h)
        @@y = rand(y- $antHeight...y + $antHeight)
    end
    def getXCord
	@@x
    end
    def getYCord
	@@y
    end
def changeCords(ary,j,board)
ary[j].x = ary[j].setXCord(ary[j].x, board.getWidth)
ary[j].y = ary[j].setYCord(ary[j].y, board.getHeight)
end


    def updatePosition(ary,j, board)

	ary[j].remove
changeCords(ary,j,board)

          
          
          ary[j].add
          
	  crash(j,ary,$toDelete)

    end
    
    def crash(j, ary, toDelete)
	x = ary[j].getXCord
	y = ary[j].getYCord
	antWidth = $antWidth/2
	antHeight = $antHeight/2
	for i in 0..ary.length-1
		if (i!= j && (x-antWidth...x+antWidth).include?(ary[i].x) && (y-antHeight...y+antHeight).include?(ary[i].y))
			$toDelete.push(i)
		end
	end
    end

end

$startTime = Time.new

$howManyAnts = 100
$antWidth, $antHeight = 10,10
ary = Array.new 
$toDelete = Array.new
$time = Array.new
tick = 0


board = Board.new(600,600, "Boardgame")
Board.info()
set title: board.getName,background: '#00B200', resizable: false, diagonostics: true, width: board.getWidth, height: board.getHeight


$counter = Counter.new( text: $howManyAnts, x: board.getWidth - 40, y: board.getHeight - 35, font: 'vera.ttf', size: 30, color: 'red', rotate: 0, z: 100)



def drawChart()
    chart = AsciiCharts::Cartesian.new(($time), :title => 'Time/Population').draw
    puts "\e[H\e[2J"
    puts chart
end
def playSong()
    music = Music.new('sound.mp3')
	music.play
end
def removeAnts(index,ary)
	ary[index].remove
	ary.delete_at(index)
end
def updateTimeArry(ary)
 	endTime = Time.now
	$time.push([ary.length, (endTime-$startTime)])
end
def updateBoardView(ary,board)
	for i in 0..$toDelete.length-1
	    index = $toDelete.shift
	updateTimeArry(ary)
            
            playSong
	removeAnts(index,ary)

            $counter.upDateC(ary.length,board.getWidth,board.getHeight)
        end
end
def insertAnts(ary,board)
	i = 1
	while i <= $howManyAnts do
    ary.push(Ant.new('art.png',x: rand(board.getWidth), y: rand(board.getHeight), w: $antWidth, h: $antHeight, z: 20))
    i += 1
end
end

insertAnts(ary,board)
update do
  if tick % 10 == 0
      for j in 0..ary.length-1 
	  ary[j].updatePosition(ary,j,board)        
      end
      
      if $toDelete.length != 0
	updateBoardView(ary,board) 
      end
  end
  drawChart
  tick += 1
  if ary.length == 1 then close end
end
show
