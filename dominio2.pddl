(define (domain ejer2)
    (:requirements :adl :strips :typing :quantified-preconditions :conditional-effects
    )
    (:types
        Entidad Recursos Edificios tipoUnidad tipoEdificio tipoRecurso - objeto
        Unidades Edificios - Entidad
        Localizacion - movible
    )
    (:constants
        VCE - tipoUnidad
        CentroDeMando Barracones Extractor - tipoEdificio
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
        ;; Verificar la construcción de un edificio
        (construido ?x - Edificios)
        ;; Verificar la necesidad de recurso de un tipo de edificio
        (necesita ?x - tipoEdificio ?y - tipoRecurso)
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
    ;; Pero hay que verificar para el caso del gas si existe el extractor en esa posicion
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
                (imply
                    (esRecurso ?t Gas)
                    (and
                        (exists (?ext - Edificios)
                            (and
                                (esEdificio ?ext Extractor)
                                (edificioEn ?ext ?x)
                                (construido ?ext)
                            )
                        )
                    )
                 )
            )
        :effect
            (and
                (Asignada ?u ?t)
                (Extrayendo ?u ?tr)
            )
    )

    ;; La idea es verificar si la unidad es de tipo VCE
    ;; Luego que este en la misma posición en la que se va construir
    ;; Si el edificio necesita un recurso tenemos alguien asignado a ese recurso
    ;; El efecto es el edificio en la posición indicada y que está construido
    (:action Construir
        :parameters (?u - Unidades ?e - Edificios ?x - Localizacion ?r - Recursos)
        :vars (?ed - tipoEdificio)
        :precondition
            (and
                (esUnidad ?u VCE)
                (unidadeEn ?u ?x)
                (not (exists (?tr - tipoRecurso) (Extrayendo ?u ?tr) ) )
                (imply (esEdificio ?e Extractor)
                    (and
                        (imply (necesita Extractor Mineral)
                            (exists (?a - Unidades)(Extrayendo ?a Mineral) )
                        )
                    )
                )
            )
        :effect
            (and
                (edificioEn ?e ?x)
                (construido ?e)
            )
    )
)
