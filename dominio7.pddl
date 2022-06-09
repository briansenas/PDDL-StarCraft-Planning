(define (domain ejer7)
    (:requirements :adl :strips :typing :quantified-preconditions :conditional-effects
    )
    (:types
        Numerico Entidad Recursos Edificios tipoUnidad tipoEdificio tipoRecurso - objeto
        Unidades Edificios - Entidad
        Localizacion - movible
    )
    (:constants
        Marines Soldados VCE - tipoUnidad
        CentroDeMando Barracones Extractor - tipoEdificio
        Mineral Gas - tipoRecurso
        plan esperado - Numerico
    )
    ;; Ahora tenemos múltiples funciones con las cuales ir controlando los valores
    (:functions
        ;; Cantidad almacenada de un tipo de recurso y su valor máximo
        (almacenado ?x - tipoRecurso) (maxAlmacenado ?y - tipoRecurso)
        ;; Coste del plan actual y del mínimo esperado;
        (coste ?plan - Numerico )  (costeMinimo ?esperado - Numerico )
        ;; Cuánto cuesta comprar un edificio
        (comprar ?x - tipoEdificio ?b - tipoRecurso)
        ;; Cuánto cuesta fabricar una unidad
        (fabricar ?x - tipoUnidad ?b - tipoRecurso)
        ;; Cuántas unidades asignadas a minerales
        (unidadesAsignadas ?tr - tipoRecurso)
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
        ;; Indicar que un tipo de Recurso utiliza un tipo de edificio
        (utiliza ?x - tipoRecurso ?x - tipoEdificio)
        ;; Indica que tipo de recurso requiere una unidad para ser reclutada
        (requiere ?x - tipoUnidad ?y - tipoRecurso)
        ;; Indica que tipo de unidad es generada en un edificio en concreto.
        (generadoEn ?x - tipoUnidad ?y - tipoEdificio)
    )

    ;; La idea es verificar si ambas localizaciones están conectadas y
    ;; La unidad está en una de las localizaciones.
    ;; El efecto es un cambio de posicion de la unidad
    (:action Navegar
        :parameters (?u - Unidades ?x ?y - Localizacion)
        :precondition
            (and
                (not (exists (?r - tipoRecurso) (Extrayendo ?u ?r) ) )
                (< (coste plan) (costeMinimo esperado) )
                (unidadeEn ?u ?x)
                (caminoEntre ?x ?y)
            )
        :effect
            (and
                (not (unidadeEn ?u ?x) )
                (unidadeEn ?u ?y)
                (increase (coste plan) 1)
            )
    )

    ;; Verificamos que es una unidad de tipo VCE
    ;; A continuación verificamos que estamos en la localización del recurso
    ;; He realizado cambios para que tenga en cuenta cualquier tipo de edificio necesario
    ;; En vez de imponer el caso extractor directamente. Sería más eficiente si realizamos
    ;; Una división entre tipos de edificios para guerra, para minar, para reclutar...
    ;; Los efectos son asignar la unidad y empezar a extraer ese tipo de mineral
    (:action Asignar
        :parameters (?u - Unidades ?x - Localizacion ?t - Recursos)
        :vars (?tr - tipoRecurso)
        :precondition
            (and
                (< (coste plan) (costeMinimo esperado) )
                (esUnidad ?u VCE)
                (unidadeEn ?u ?x)
                (recursoEn ?t ?x)
                (esRecurso ?t ?tr)
                (not (exists (?rec - tipoRecurso) (Extrayendo ?u ?rec) ) )
                (forall (?ed - tipoEdificio)
                    (exists (?e - Edificios)
                        (and
                            (esEdificio ?e ?ed)
                            (imply (utiliza ?tr ?ed)
                                (and
                                    (edificioEn ?e ?x)
                                )
                            )
                        )
                    )
                )
            )
        :effect
            (and
                (Asignada ?u ?t)
                (Extrayendo ?u ?tr)
                (increase (unidadesAsignadas ?tr) 1)
                (increase (coste plan) 1)
            )
    )

    ;; La idea es verificar si la unidad es de tipo VCE
    ;; Luego que este en la misma posición en la que se va construir
    ;; Un bucle para que si el edificio necesita un recurso tenemos alguien asignado a ese recurso
    ;; tal que la cantidad almacenada sea mayor o igual a la contidad necesaria para comprarlo.
    (:action Construir
        :parameters (?u - Unidades ?e - Edificios ?x - Localizacion)
        :vars (?ed - tipoEdificio)
        :precondition
            (and
                (< (coste plan) (costeMinimo esperado) )
                (esUnidad ?u VCE)
                (unidadeEn ?u ?x)
                (not (exists (?c - Edificios) (edificioEn ?c ?x) ) )
                (not (exists (?r - tipoRecurso) (Extrayendo ?u ?r) ) )
                (not (exists (?y - Localizacion) (edificioEn ?e ?y) ) )
                (esEdificio ?e ?ed)
                (forall (?r - tipoRecurso)
                    (and
                        (imply (necesita ?ed ?r)
                            (>= (almacenado ?r) (comprar ?ed ?r) )
                        )
                    )
                )
            )
        :effect
            (and
                (edificioEn ?e ?x)
                (construido ?e)
                (increase (coste plan) 1)
                (forall (?tr - tipoRecurso )
                    (when (necesita ?ed ?tr)
                        (decrease (almacenado ?tr) (comprar ?ed ?tr) )
                    )
                )
            )
    )

    ;; La idea es verificar que la unidad en concreto no existe
    ;; Luego vemos que existe el edificio en concreto.
    ;; Obtenemos el tipo de unidad a reclutar y el tipo de edificio a construir
    ;; Luego para todo tipo de recurso, verificamos si la unidad requiere de ese recurso
    ;; Dado que si lo requiere, necesitamos verificar que lo estamos extrayendo
    ;; y la cantidad almacenada es mayor o igual que el coste de fabricación
    (:action Reclutar
        :parameters (?e - Edificios ?u - Unidades ?x - Localizacion)
        :vars (?ut - tipoUnidad ?ed - tipoEdificio)
        :precondition
            (and
                (not (exists (?y - Localizacion ) (unidadeEn ?u ?y) ) )
                (< (coste plan) (costeMinimo esperado) )
                (edificioEn ?e ?x)
                (esUnidad ?u ?ut)
                (esEdificio ?e ?ed)
                (generadoEn ?ut ?ed)
                (forall (?r - tipoRecurso)
                    (and
                        (imply (requiere ?ut ?r)
                            (>= (almacenado ?r) (fabricar ?ut ?r) )
                        )
                    )
                )
            )
        :effect
            (and
                (unidadeEn ?u ?x)
                (increase (coste plan) 1)
                (forall (?tr - tipoRecurso )
                    (when (requiere ?ut ?tr)
                        (decrease (almacenado ?tr) (fabricar ?ut ?tr) )
                    )
                )
            )
    )

    ;; La idea es mirar que el recurso está en la localización indicada,
    ;; Luego miramos si hay alguna unidad en esa posición y que además
    ;; esa misma unidad está asignada a ese recurso;
    (:action Recolectar
        :parameters ( ?r - Recursos ?x - Localizacion)
        :vars (?tr - tipoRecurso ?u - Unidades)
        :precondition
            (and
                (< (coste plan) (costeMinimo esperado) )
                (esRecurso ?r ?tr)
                (<= (almacenado ?tr) (maxAlmacenado ?tr ) )
                (recursoEn ?r ?x )
                (unidadeEn ?u ?x)
                (Asignada ?u ?r)
            )
        :effect
            (and
                (increase (almacenado ?tr) (* 10 (unidadesAsignadas ?tr)) )
                (increase (coste plan) 1 )
            )
    )
)
