(define (domain ejer1)
    (:requirements :adl :strips :typing :quantified-preconditions :conditional-effects
    )
    (:types
        Entidad Recursos Edificios tipoUnidad tipoEdificio tipoRecurso - objeto
        Unidades Edificios - Entidad
        Localizacion - movible
    )
    (:constants
        VCE - tipoUnidad
        CentroDeMando Barracones - tipoEdificio
        Mineral Gas - tipoRecurso
    )
    (:predicates
        ;; Verificar que un edificio está en una posicion)
        (edificioEn ?x - Edificios ?y - Localizacion)
        ;; Verificar que existe camino entre dos localizaciones
        (caminoEntre ?x ?y - Localizacion)
        ;; Verificar posicion de un recurso
        (recursoEn ?x - Recursos ?y - Localizacion)
        ;; Verificar asignación de una unidad a un recurso
        (Asignada ?u - Unidades ?y - Recursos )
        ;; Verificar asignación de una unidad a un tipo de recurso
        (Extrayendo ?u - Unidades ?y - tipoRecurso )
        ;; Verificar posicion de la unidad
        (unidadeEn ?x - Unidades ?y - Localizacion)
        ;; Verificar tipos entre variables
        (esEdificio ?a - Edificios ?b - tipoEdificio)
        (esUnidad ?a - Unidades ?b - tipoUnidad)
        (esRecurso ?a - Recursos ?b - tipoRecurso)
    )

    ;; La idea es verificar si ambas localizaciones están conectadas y
    ;; La unidad está en una de las localizaciones.
    ;; El efecto es un cambio de posicion de la unidad
    (:action Navegar
        :parameters (?u - Unidades ?x ?y - Localizacion)
        :precondition
            (and
                (not (exists (?r - tipoRecurso) (Extrayendo ?u ?r) ) )
                (unidadeEn ?u ?x)
                (caminoEntre ?x ?y)
            )
        :effect
            (and
                (not (unidadeEn ?u ?x) )
                (unidadeEn ?u ?y)
            )
    )

    ;; Verificamos que es una unidad de tipo VCE
    ;; A continuación verificamos que estamos en la localización del recurso
    ;; Por último verificamos si no estamos extrayendo con esa unidad algún recurso
    ;; Los efectos son asignar la unidad y empezar a extraer ese tipo de mineral
    (:action Asignar
        :parameters (?u - Unidades ?x - Localizacion ?t - Recursos)
        :vars (?tr - tipoRecurso)
        :precondition
            (and
                (esUnidad ?u VCE)
                (unidadeEn ?u ?x)
                (recursoEn ?t ?x)
                (esRecurso ?t ?tr)
                (not (exists (?rec - tipoRecurso) (Extrayendo ?u ?rec) ) )
            )
        :effect
            (and
                (Asignada ?u ?t)
                (Extrayendo ?u ?tr)
            )
    )

)
