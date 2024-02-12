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

(fn center [start size end]
  (-> (- end start size)
      (/ 2)
      (+ start)))

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
  (local x-step (/ WIDTH 6))
  (local y-step (/ HEIGHT 6))
  (each [r row (ipairs board)]
    (each [c mark (ipairs row)]
      (local x (+ x-step (* 2 x-step (- r 1))))
      (local y (+ y-step (* 2 y-step (- c 1))))
      (match mark
        EMPTY nil
        O     (draw-o x y)
        X     (draw-x x y)))))

(fn draw [state]
  (cls)
  (print (.. "Turn: " state.turn))
  (draw-grid)
  (draw-marks state.board))

(fn within? [[rx ry width height] x y]
  (and (> x rx)
       (< x (+ rx width))
       (> y ry)
       (< y (+ ry height))))

(fn flip-turn! [state]
  (set state.turn (match state.turn
                    X O
                    O X)))

(fn coordinates->hitbox [r c]
  [(* (- r 1) (+ CELL_WIDTH GRID_THICKNESS))
   (* (- c 1) (+ CELL_HEIGHT GRID_THICKNESS))
   CELL_WIDTH
   CELL_HEIGHT])

(fn position->cell [x y]
  (local r (math.ceil (/ x (+ CELL_WIDTH GRID_THICKNESS))))
  (local c (math.ceil (/ y (+ CELL_HEIGHT GRID_THICKNESS))))
  (when (< r 4) (< c 4)
    [r c]))

(fn place-marker [inputs state]
  (local cell (position->cell inputs.x inputs.y))
  (if (and cell inputs.pressed)
    (let [(r c) (table.unpack cell)]
      (tset state.board r c state.turn))
    (place-marker (coroutine.yield))))

(fn update [inputs state]
  (while true
    (place-marker inputs state)
    (flip-turn! state)))

(fn make-state []
  {:board  (make-board)
   :turn   X
   :update (coroutine.wrap update)})

(var state nil)

(fn _G.BOOT []
  (set state (make-state)))

(fn _G.TIC []
  (local (x y) (mouse))
  (local pressed (keyp))
  (each [r row (ipairs state.board)]
    (each [c _ (ipairs row)]
      (when (and pressed (within? (coordinates->hitbox r c) x y))
        (tset state.board r c state.turn)
        (flip-turn! state))))
  (draw state)
  (print (fennel.view {: x : y : pressed}) 0 (- HEIGHT 6)))

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
