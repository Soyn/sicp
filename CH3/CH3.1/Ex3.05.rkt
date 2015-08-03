#lang racket

;; Ex3.05
;; Created by Soyn. 3/8/15.
;; @Brief:Monte Carlo integration is a method of estimating definite integrals by means of Monte
;; Carlo simulation. Consider computing the area of a region of space described by a predicate P(x, y) that is
;; true for points (x, y) in the region and false for points not in the region. For example, the region contained
;; within a circle of radius 3 centered at (5, 7) is described by the predicate that tests whether (x - 5) 2 + (y -
;; 7) 2 < 3 2 . To estimate the area of the region described by such a predicate, begin by choosing a rectangle
;; that contains the region. For example, a rectangle with diagonally opposite corners at (2, 4) and (8, 10)
;; contains the circle above. The desired integral is the area of that portion of the rectangle that lies in the
;; region. We can estimate the integral by picking, at random, points (x,y) that lie in the rectangle, and testing
;; P(x, y) for each point to determine whether the point lies in the region. If we try this with many points,
;; then the fraction of points that fall in the region should give an estimate of the proportion of the rectangle
;; that lies in the region. Hence, multiplying this fraction by the area of the entire rectangle should produce
;; an estimate of the integral.
;; Implement Monte Carlo integration as a procedure estimate-integral that takes as arguments a
;; predicate P, upper and lower bounds x1, x2, y1, and y2 for the rectangle, and the number of trials to
;; perform in order to produce the estimate. Your procedure should use the same monte-carlo procedure
;; that was used above to estimate . Use your estimate-integral to produce an estimate of by
;; measuring the area of a unit circle.
;; You will find it useful to have a procedure that returns a number chosen at random from a given range.
;; The following random-in-range procedure implements this in terms of the random procedure used
;; in section 1.2.6, which returns a nonnegative number less than its input.
;;     (define (random-in-range low high)
;;         (let ((range (- high low)))
;;             (+ low (random range))))


;;----------Help Function------------------------------------------------

( define (monte-carlo trials experiment)
   ( define ( iter trials-remaining trials-passed)
      ( cond ( ( = trials-remaining 0)
               ( / trials-passed trials))   ;; if finshed we return the probability
            ( ( experiment)   ;; This is bool, if true we increase the trials-passed and minus the trials.
              ( iter ( - trials-remaining 1) ( + trials-passed 1)))
            ( else
              ( iter ( - trials-remaining 1) trials-passed))))
   ( iter trials 0))

( define ( random-in-range low high)
   ( let ( ( range ( - high low)))
      ( + low ( * ( random) range))))
;;-------------------------------------------------------------------------------

( define ( P x y)
   ( < ( + ( expt ( - x 5) 2)
          ( expt ( - y 7) 2))
      ( expt 3 2)))

( define ( estimate-integral P x1 x2 y1 y2 trials)
   ( define ( experiment)
      ( P ( random-in-range x1 x2)
         ( random-in-range y1 y2)))
   ( monte-carlo trials experiment))

;; test
;; Note: the retangle area is 36, PI = (Monter Carlo results * rectangle) / r^2
( define PI-approx
   ( / ( * ( estimate-integral P 2.0 8.0 4.0 10.0 10000) 36)
      9.0))

PI-approx