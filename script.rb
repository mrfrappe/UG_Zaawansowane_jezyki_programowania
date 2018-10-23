require 'ruby2d'
puts "Plantacja ślimaków"

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
        # draw board
        puts "Boardgame (w: #@@width, h: #@@height )"
    end
end


class Snail < Rectangle
    def self.info()
    end
    def getXCord
        @x
    end
    def getYCord
        @y
    end
    def setXCord(value)
        xRand = Random.new()
        @x = xRand.rand(@x- value...@x + value)
        puts "X: #@x"
    end   
    def setYCord(value)
        yRand = Random.new()
        @y = yRand.rand(@y- value... @y+ value)
       puts "Y: #@y"
    end
    def eat 
        #eat fun
    end
    def copulation
        #copulation
    end
end

ary = Array.new 
$i = 1
$howManySnails = 10
tick = 0

board = Board.new(500,500, "Boardgame")
Board.info()
set title: board.getName
set background: 'green'
set resizable: false
set diagonostics: true
set width: board.getWidth
set height: board.getHeight

while $i <= $howManySnails do
    xRand = Random.new()
    yRand = Random.new()
    snail=Snail.new(x: xRand.rand(board.getWidth), y: yRand.rand(board.getHeight), width: 10,height:10,color: 'red',z:20)
    ary.push(snail)
    Snail.info()
    $i += 1
end


update do
  if tick % 10 == 0
      $j = 0
      while $j <= ary.length do
          puts $j
      snail.remove
      snail.setXCord(1)
      snail.setYCord(1)
      snail.add
        $j += 1
      end

  end
  tick += 1
end
puts ary
show