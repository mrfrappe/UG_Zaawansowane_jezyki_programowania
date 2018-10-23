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


class Snail < Sprite
    def self.info()
    end
    def setXCord(x, w, value)
        if x <= w and x > 0
            x = Random.new().rand(x - value...x + value)
        else
            x = x+10
        end
#        puts "X: #@x"
    end   
    def setYCord(y, h, value)
        if y <= h and y > 0
            y = Random.new().rand(y - value... y+ value)
        else
            y = y+10
        end
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
$howManySnails = 100
tick = 0

board = Board.new(500,500, "Boardgame")
Board.info()
set title: board.getName
set background: '#00B200'
set resizable: false
set diagonostics: true
set width: board.getWidth
set height: board.getHeight

while $i <= $howManySnails do
    ary.push(Snail.new('art.png',x: Random.new().rand(board.getWidth), y: Random.new().rand(board.getHeight), width: 10, height: 10, z: 20))
    Snail.info()
    $i += 1
end
update do
  if tick % 10 == 0
      for j in 0..ary.length-1 
          ary[j].remove
          ary[j].x = ary[j].setXCord(ary[j].x, board.getWidth, 10)
          ary[j].y = ary[j].setYCord(ary[j].y, board.getHeight, 10)
          ary[j].add
          j += 1
      end

  end
  tick += 1
end
show