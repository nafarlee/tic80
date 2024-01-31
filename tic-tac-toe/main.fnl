;; title:   game title
;; author:  game developer, email, etc.
;; desc:    short description
;; site:    website link
;; license: MIT License (change this to your license of choice)
;; version: 0.1
;; script:  fennel
;; strict:  true
(local fennel (require :fennel))

(local HEIGHT 135)
(local WIDTH 240)
(local EMPTY "")
(local X :X)
(local O :O)

(var board nil)

(fn center [start size end]
  (-> (- end start size)
      (// 2)
      (+ start)))

(fn make-board []
  [[EMPTY EMPTY EMPTY]
   [EMPTY EMPTY EMPTY]
   [EMPTY EMPTY EMPTY]])

(fn draw-grid []
  (local thic 2)
  (local half-thic (// thic 2))
  (rect 0 (-> HEIGHT (// 3) (- half-thic)) WIDTH thic 8)
  (rect 0 (-> HEIGHT (// 3) (* 2) (- half-thic)) WIDTH thic 8)
  (rect (-> WIDTH (// 3) (- half-thic)) 0 thic HEIGHT 8)
  (rect (-> WIDTH (// 3) (* 2) (- half-thic)) 0 thic HEIGHT 8))

(fn _G.BOOT []
  (set board (make-board)))

(fn _G.TIC []
  (local text-board (fennel.view board))
  (local width (print text-board 0 -6))
  (cls)
  (print text-board (center 0 width WIDTH) (center 0 6 HEIGHT))
  (draw-grid))

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
