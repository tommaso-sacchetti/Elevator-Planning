(define (problem elevators)
(:domain elevators-PIN)


    ;;        boarded-passengers - object
    ;;        person elevator - locatable
    ;;        slow-elevator fast-elevator - elevator

    (:objects
        slow10 slow20 slow21 slow30 - slow-elevator
        fast0 fast1 - fast-elevator
        p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 - person
        i0 i1 i2 i3 i4 i5 - boarded-passengers
        f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 - floor
    )    
    
    (:init 
        (next i0 i1) (next i1 i2) (next i2 i3) (next i3 i4) (next i4 i5)

        (above f0 f1) (above f0 f2) (above f0 f3) (above f0 f4) (above f0 f5) (above f0 f6) (above f0 f7) (above f0 f8) (above f0 f9) (above f0 f10) (above f0 f11) (above f0 f12) 

        (above f1 f2) (above f1 f3) (above f1 f4) (above f1 f5) (above f1 f6) (above f1 f7) (above f1 f8) (above f1 f9) (above f1 f10) (above f1 f11) (above f1 f12) 

        (above f2 f3) (above f2 f4) (above f2 f5) (above f2 f6) (above f2 f7) (above f2 f8) (above f2 f9) (above f2 f10) (above f2 f11) (above f2 f12) 

        (above f3 f4) (above f3 f5) (above f3 f6) (above f3 f7) (above f3 f8) (above f3 f9) (above f3 f10) (above f3 f11) (above f3 f12) 

        (above f4 f5) (above f4 f6) (above f4 f7) (above f4 f8) (above f4 f9) (above f4 f10) (above f4 f11) (above f4 f12) 

        (above f5 f6) (above f5 f7) (above f5 f8) (above f5 f9) (above f5 f10) (above f5 f11) (above f5 f12) 

        (above f6 f7) (above f6 f8) (above f6 f9) (above f6 f10) (above f6 f11) (above f6 f12) 

        (above f7 f8) (above f7 f9) (above f7 f10) (above f7 f11) (above f7 f12) 

        (above f8 f9) (above f8 f10) (above f8 f11) (above f8 f12) 

        (above f9 f10) (above f9 f11) (above f9 f12) 

        (above f10 f11) (above f10 f12) 

        (above f11 f12)

        (elevator-at slow10 f0)
        (passengers-inside slow10 i0)
        (elevator-capacity slow10 i0)(elevator-capacity slow10 i1)(elevator-capacity slow10 i2)(elevator-capacity slow10 i3) (elevator-capacity slow10 i4)
        (reachable-floor slow10 f0)(reachable-floor slow10 f1)(reachable-floor slow10 f2)(reachable-floor slow10 f3)(reachable-floor slow10 f4)

        (elevator-at slow20 f4)
        (passengers-inside slow20 i0)
        (elevator-capacity slow20 i0)(elevator-capacity slow20 i1)(elevator-capacity slow20 i2)(elevator-capacity slow20 i3)
        (elevator-capacity slow20 i4)
        (reachable-floor slow20 f4)(reachable-floor slow20 f5)(reachable-floor slow20 f6)(reachable-floor slow20 f7)(reachable-floor slow20 f8)

        (elevator-at slow30 f8)
        (passengers-inside slow30 i0)
        (elevator-capacity slow30 i0)(elevator-capacity slow30 i1)(elevator-capacity slow30 i2)(elevator-capacity slow30 i3)
        (elevator-capacity slow30 i4)
        (reachable-floor slow30 f8)(reachable-floor slow30 f9)(reachable-floor slow30 f10)(reachable-floor slow30 f11)(reachable-floor slow30 f12)

        (elevator-at fast0 f0)
        (passengers-inside fast0 i0)
        (elevator-capacity fast0 i0)(elevator-capacity fast0 i1)(elevator-capacity fast0 i2)(elevator-capacity fast0 i3)
        (elevator-capacity fast0 i4)(elevator-capacity fast0 i5)
        (reachable-floor fast0 f0)(reachable-floor fast0 f2)(reachable-floor fast0 f4)(reachable-floor fast0 f6)(reachable-floor fast0 f8)(reachable-floor fast0 f10)(reachable-floor fast0 f12)

        (elevator-at fast1 f0)
        (passengers-inside fast1 i0)
        (elevator-capacity fast1 i0)(elevator-capacity fast1 i1)(elevator-capacity fast1 i2)(elevator-capacity fast1 i3)
        (elevator-capacity fast1 i4)(elevator-capacity fast1 i5)
        (reachable-floor fast1 f0)(reachable-floor fast1 f2)(reachable-floor fast1 f4)(reachable-floor fast1 f6)(reachable-floor fast1 f8)(reachable-floor fast1 f10)(reachable-floor fast1 f12)


        (person-at p0 f2)
        (person-at p1 f4)
        (person-at p2 f1)
        (person-at p3 f8)
        (person-at p4 f3)
        (person-at p5 f7)
        (person-at p6 f9)
        (person-at p7 f12)
        (person-at p8 f6)
        (person-at p9 f0)
        (person-at p10 f5)
        (person-at p11 f11)
    )

    (:goal 
        ( and 
            (person-at p0 f7)
            (person-at p1 f11)
            (person-at p2 f12)
            (person-at p3 f1)
            (person-at p4 f0)
            (person-at p5 f10)
            (person-at p6 f9)
            (person-at p7 f2)
            (person-at p8 f1)
            (person-at p9 f3)
            (person-at p10 f7)
            (person-at p11 f5)
        )
    )   
)