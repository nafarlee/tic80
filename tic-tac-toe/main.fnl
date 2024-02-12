;; title:   tic-tac-toe
;; author:  @nafarlee
;; license: MIT License
;; script:  fennel
;; strict:  true

(local fennel (require :fennel))

(local HEIGHT 135)
(local WIDTH 240)
(local EMPTY "")
(local X :X)
(local O :O)
(local GRID_THICKNESS 4)
(local CELL_WIDTH (/ (- WIDTH (* 2 GRID_THICKNESS)) 3))
(local CELL_HEIGHT (/ (- HEIGHT (* 2 GRID_THICKNESS)) 3))

(fn make-board []
  [[EMPTY EMPTY EMPTY]
   [EMPTY EMPTY EMPTY]
   [EMPTY EMPTY EMPTY]])

(fn draw-vertical-gridline [x]
  (rect x 0 GRID_THICKNESS HEIGHT 8))

(fn draw-horizontal-gridline [y]
  (rect 0 y WIDTH GRID_THICKNESS 8))

(fn draw-grid []
  (draw-horizontal-gridline CELL_HEIGHT)
  (draw-horizontal-gridline (+ CELL_HEIGHT GRID_THICKNESS CELL_HEIGHT))
  (draw-vertical-gridline CELL_WIDTH)
  (draw-vertical-gridline (+ CELL_WIDTH GRID_THICKNESS CELL_WIDTH)))

(fn draw-o [x y]
  (circb x y 3 1)
  (circb x y 4 2))

(fn draw-x [x y]
  (line (- x 3) (- y 3) (+ x 3) (+ y 3) 10)
  (line (- x 3) (+ y 3) (+ x 3) (- y 3) 9))

(fn draw-marks [board]
  (each [r row (ipairs board)]
    (each [c mark (ipairs row)]
      (let [x-step (/ WIDTH 6)
            x (+ x-step (* 2 x-step (- r 1)))
            y-step (/ HEIGHT 6)
            y (+ y-step (* 2 y-step (- c 1)))]
        (match mark
          EMPTY nil
          O     (draw-o x y)
          X     (draw-x x y))))))

(fn draw [state]
  (cls)
  (print (.. "Turn: " state.turn))
  (draw-grid)
  (draw-marks state.board))

(fn flip-turn! [state]
  (set state.turn (match state.turn
                    X O
                    O X)))

(fn position->cell [x y]
  (let [r (math.ceil (/ x (+ CELL_WIDTH GRID_THICKNESS)))
        c (math.ceil (/ y (+ CELL_HEIGHT GRID_THICKNESS)))]
    (when (and (<= 1 r 3) (<= 1 c 3))
      [r c])))

(fn place-marker! [inputs state]
  (local cell (position->cell inputs.x inputs.y))
  (if (and cell inputs.pressed)
    (let [(r c) (table.unpack cell)]
      (tset state.board r c state.turn))
    (let [(inputs state) (coroutine.yield)]
      (place-marker! inputs state))))

(fn update! [inputs state]
  (while true
    (place-marker! inputs state)
    (flip-turn! state)))

(fn make-state []
  {:board  (make-board)
   :turn   X
   :update! (coroutine.wrap update!)})

(var state nil)

(fn _G.BOOT []
  (set state (make-state)))

(fn _G.TIC []
  (if (keyp 18)
    (reset)
    (let [pressed (keyp)
          (x y)   (mouse)
          inputs  {: x : y : pressed}]
      (state.update! inputs state)
      (draw state)
      (print (fennel.view inputs) 0 (- HEIGHT 6)))))

;; <TILES>
;; </TILES>

;; <WAVES>
;; </WAVES>

;; <SFX>
;; </SFX>

;; <TRACKS>
;; </TRACKS>

;; <PALETTE>
;; 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
;; </PALETTE>
