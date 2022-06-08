(define (domain elevators-PIN)
    (:requirements :typing :strips)

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

    (:action get-inside ;;?i0 passengers before the last getting inside
        :parameters (?elevator - elevator ?person - person ?floor - floor ?i0 - boarded-passengers ?i1 - boarded-passengers)
        :precondition (and (elevator-at ?elevator ?floor) (person-at ?person ?floor) (next ?i0 ?i1) (passengers-inside ?elevator ?i0) (elevator-capacity ?elevator ?i1))
        :effect (and ( not (person-at ?person ?floor)) (boarded ?person ?elevator) ( not (passengers-inside ?elevator ?i0)) (passengers-inside ?elevator ?i1))
    )

    (:action get-outside ;;?i0 passengers before the last getting outside, in this case i0 > i1
        :parameters (?elevator - elevator ?person - person ?floor - floor ?i0 - boarded-passengers ?i1 - boarded-passengers)
        :precondition (and (elevator-at ?elevator ?floor) (boarded ?person ?elevator) (next ?i1 ?i0) (passengers-inside ?elevator ?i0) (elevator-capacity ?elevator ?i1))
        :effect (and (person-at ?person ?floor) ( not (boarded ?person ?elevator)) ( not (passengers-inside ?elevator ?i0)) (passengers-inside ?elevator ?i1))
    )

    (:action move-down-fast ;; f1 > f2
        :parameters (?elevator - fast-elevator ?f1 - floor ?f2 - floor)
        :precondition (and (elevator-at ?elevator ?f1) (above ?f2 ?f1) (reachable-floor ?elevator ?f2))
        :effect (and ( not (elevator-at ?elevator ?f1)) (elevator-at ?elevator ?f2))
    )

    (:action move-up-fast ;; f2 > f1
        :parameters (?elevator - fast-elevator ?f1 - floor ?f2 - floor)
        :precondition (and (elevator-at ?elevator ?f1) (above ?f1 ?f2) (reachable-floor ?elevator ?f2))
        :effect (and ( not (elevator-at ?elevator ?f1)) (elevator-at ?elevator ?f2))
    )

    (:action move-down-slow ;; f1 > f2
        :parameters (?elevator - slow-elevator ?f1 - floor ?f2 - floor)
        :precondition (and (elevator-at ?elevator ?f1) (above ?f2 ?f1) (reachable-floor ?elevator ?f2))
        :effect (and ( not (elevator-at ?elevator ?f1)) (elevator-at ?elevator ?f2))
    )

    (:action move-up-slow ;; f2 > f1
        :parameters (?elevator - slow-elevator ?f1 - floor ?f2 - floor)
        :precondition (and (elevator-at ?elevator ?f1) (above ?f1 ?f2) (reachable-floor ?elevator ?f2))
        :effect (and ( not (elevator-at ?elevator ?f1)) (elevator-at ?elevator ?f2))
    )
)