(define (domain elevators-PIN)
    (:requirements :typing :strips :durative-actions :fluents :duration-inequalities)

    (:types person floor - object
            boarded-passengers - object ;; the number of passengers possible in an elevator, not represents people actually inside
            elevator - object
            slow-elevator fast-elevator - elevator
    )

    (:predicates
        (elevator-at ?elevator - elevator ?floor - floor)
        (person-at ?person - person ?floor - floor)
        (passengers-inside ?elevator - elevator ?i - boarded-passengers)
        (boarded ?person - person ?elevator - elevator)
        (above ?floor1 - floor ?floor2 - floor)
        (next ?i1 - boarded-passengers ?i2 - boarded-passengers)
        (elevator-capacity ?elevator - elevator ?i - boarded-passengers)
        (reachable-floor ?elevator - elevator ?floor - floor)
    )

    (:functions
        (distance-slow ?f1 - floor ?f2 - floor)
        (time-distance-fast ?f1 - floor ?f2 - floor)
        (recharge-rate)
        (total-energy-used)
        (battery-capacity ?e - elevator)
        (battery-level ?e - elevator)
    )

    (:durative-action get-inside ;;?i0 passengers before the last getting inside
        :parameters (?elevator - elevator ?person - person ?floor - floor ?i0 - boarded-passengers ?i1 - boarded-passengers)
        :duration (= ?duration 2)
        :condition (and 
            (over all (elevator-at ?elevator ?floor))
            (at start (person-at ?person ?floor))
            (over all (next ?i0 ?i1)) 
            (at start (passengers-inside ?elevator ?i0)) 
            (over all (elevator-capacity ?elevator ?i1)))
        :effect (and 
            (at end ( not (person-at ?person ?floor)))
            (at end (boarded ?person ?elevator))
            (at end ( not (passengers-inside ?elevator ?i0)))
            (at end (passengers-inside ?elevator ?i1)))
    )

    (:durative-action get-outside ;;?i0 passengers before the last getting outside, in this case i0 > i1
        :parameters (?elevator - elevator ?person - person ?floor - floor ?i0 - boarded-passengers ?i1 - boarded-passengers)
        :duration (= ?duration 2)
        :condition (and 
            (over all (elevator-at ?elevator ?floor))
            (at start (boarded ?person ?elevator))
            (over all (next ?i1 ?i0))
            (at start (passengers-inside ?elevator ?i0))
            (over all (elevator-capacity ?elevator ?i1)))
        :effect (and 
            (at end (person-at ?person ?floor))
            (at end ( not (boarded ?person ?elevator)))
            (at end ( not (passengers-inside ?elevator ?i0)))
            (at end (passengers-inside ?elevator ?i1)))
    )

    (:durative-action move-down-fast ;; f1 > f2
        :parameters (?elevator - fast-elevator ?f1 - floor ?f2 - floor)
        :duration (= ?duration (time-distance-fast ?f2 ?f1))
        :condition (and 
            ;;(at start (>= 1 (battery-level ?elevator)))
            (at start (> (battery-level ?elevator) (/ 1 (time-distance-fast ?f2 ?f1))) )
            (at start (elevator-at ?elevator ?f1))
            (over all (above ?f2 ?f1))
            (over all (reachable-floor ?elevator ?f2)))
        :effect (and 
            (at start ( not (elevator-at ?elevator ?f1)) )
            (at end (elevator-at ?elevator ?f2))
            (at end (increase (total-energy-used) 
                (/ 1 (time-distance-fast ?f2 ?f1))) )
            ;;(at end (decrease (battery-level ?elevator) 1 ))
            (at end (decrease (battery-level ?elevator) (/ 1 (time-distance-fast ?f2 ?f1))) ) 
            )
    )

    (:durative-action move-up-fast ;; f2 > f1
        :parameters (?elevator - fast-elevator ?f1 - floor ?f2 - floor)
        :duration (= ?duration (+ 1 (time-distance-fast ?f1 ?f2)))
        :condition (and 
            ;;(at start (>= 1 (battery-level ?elevator)))
            (at start (> (battery-level ?elevator) (/ 1 (+ 1 (time-distance-fast ?f1 ?f2))) ))
            (at start (elevator-at ?elevator ?f1))
            (over all (above ?f1 ?f2))
            (over all (reachable-floor ?elevator ?f2)))
        :effect (and 
            (at start ( not (elevator-at ?elevator ?f1)))
            (at end (elevator-at ?elevator ?f2))
            (at end (increase (total-energy-used) 
                (/ 1 (+ 1 (time-distance-fast ?f1 ?f2))) ))
            ;;(at end (decrease (battery-level ?elevator) 1 ))
            (at end (decrease (battery-level ?elevator) (/ 1 (+ 1 (time-distance-fast ?f1 ?f2))) ))
            )
    )

    (:durative-action move-down-slow ;; f1 > f2
        :parameters (?elevator - slow-elevator ?f1 - floor ?f2 - floor)
        :duration (= ?duration (distance-slow ?f2 ?f1))
        :condition (and 
            (at start (> (battery-level ?elevator) (/ 1 (distance-slow ?f2 ?f1)))) 
            (at start (elevator-at ?elevator ?f1))
            (over all (above ?f2 ?f1))
            (over all (reachable-floor ?elevator ?f2)))
        :effect (and 
            (at start ( not (elevator-at ?elevator ?f1)))
            (at end (elevator-at ?elevator ?f2))
            (at end (increase (total-energy-used) 
                (/ 1 (distance-slow ?f2 ?f1) )))
            (at end (decrease (battery-level ?elevator) (/ 1 (distance-slow ?f2 ?f1) )))
        )
    )

    (:durative-action move-up-slow ;; f2 > f1
        :parameters (?elevator - slow-elevator ?f1 - floor ?f2 - floor)
        :duration (= ?duration (distance-slow ?f1 ?f2))
        :condition (and 
            ;;(at start (<= 1 (battery-level ?elevator)))
            (at start (> (battery-level ?elevator) (/ 1 (distance-slow ?f1 ?f2)))) 
            (at start (elevator-at ?elevator ?f1))
            (over all (above ?f1 ?f2))
            (over all (reachable-floor ?elevator ?f2)))
        :effect (and 
            (at start ( not (elevator-at ?elevator ?f1)))
            (at end (elevator-at ?elevator ?f2))
            (at end (increase (total-energy-used) 
                (/ 1 (distance-slow ?f1 ?f2) )))
            ;;(at end (decrease (battery-level ?elevator) 1 ))
            (at end (decrease (battery-level ?elevator) (/ 1 (distance-slow ?f1 ?f2) )))
        )     
    )

    (:durative-action recharge-elevator
        :parameters (?elevator - elevator ?floor - floor)
        :duration (= ?duration (/ (- (battery-capacity ?elevator) (battery-level ?elevator)) (recharge-rate)))
        :condition (and 
            (over all (elevator-at ?elevator ?floor))
            (at start (> (battery-capacity ?elevator) (battery-level ?elevator)))
        )
        :effect (at end (assign (battery-level ?elevator) (battery-capacity ?elevator)))
    )
)