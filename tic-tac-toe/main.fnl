;; title:   game title
;; author:  game developer, email, etc.
;; desc:    short description
;; site:    website link
;; license: MIT License (change this to your license of choice)
;; version: 0.1
;; script:  fennel
;; strict:  true

(var t 0)
(var x 96)
(var y 24)

(fn _G.TIC []
  (when (btn 0) (set y (- y 1)))
  (when (btn 1) (set y (+ y 1)))
  (when (btn 2) (set x (- x 1)))
  (when (btn 3) (set x (+ x 1)))
  (cls 0)
  (spr (+ 1 (* (// (% t 60) 30) 2))
       x y 14 3 0 0 2 2)
  (print "HELLO WORLD!" 84 84)
  (set t (+ t 1)))

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
