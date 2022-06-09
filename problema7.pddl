(define (problem Recolectar)
    (:domain ejer7)
    (:objects
        VCE1 VCE2 VCE3 Marine1 Marine2 Soldado1 - Unidades
        CentroDeMando1 Extractor1 Barracones1 - Edificios
        Minerales1 Minerales2 Gas1 - Recursos
        LOC44 LOC43 LOC42 LOC41 - Localizacion
        LOC34 LOC33 LOC32 LOC31 - Localizacion
        LOC24 LOC23 LOC22 LOC21 - Localizacion
        LOC14 LOC13 LOC12 LOC11 - Localizacion

    )
    (:init
        ;;Valores iniciales
        (= (almacenado Mineral ) 0 )
        (= (almacenado Gas ) 0 )
        (= (maxAlmacenado Gas ) 60 )
        (= (maxAlmacenado Mineral ) 60 )
        (= (unidadesAsignadas Mineral) 0)
        (= (unidadesAsignadas Gas) 0)
        (= (coste plan) 0 )
        (= (costeMinimo esperado) 44)
        ;; (= (costeMinimo esperado) 43) ;; Empty at ?¿?¿
        ;; Posiciones
        (edificioEn CentroDeMando1 LOC11)
        (unidadeEn VCE1 LOC11)

        (recursoEn Minerales1 LOC22)
        (recursoEn Minerales2 LOC32)
        (recursoEn Gas1 LOC44)

        ;; Tipos de Unidades
        (esUnidad VCE1 VCE)
        (esUnidad VCE2 VCE)
        (esUnidad VCE3 VCE)
        (esUnidad Marine1 Marines)
        (esUnidad Marine2 Marines)
        (esUnidad Soldado1 Soldados)


        ;; Tipo de Recurso
        (esRecurso Minerales1 Mineral)
        (esRecurso Minerales2 Mineral)
        (esRecurso Gas1 Gas)

        ;; Tipo de Edificio
        (esEdificio Extractor1 Extractor)
        (esEdificio CentroDeMando1 CentroDeMando)
        (esEdificio Barracones1 Barracones)
        ;; Recurso utiliza edificio
        (utiliza Gas Extractor)

        ;; Necesidades
        (necesita Extractor Mineral)
        (necesita Barracones Mineral)
        (necesita Barracones Gas)
        (requiere VCE Mineral)
        (requiere Marines Mineral)
        (requiere Marines Gas)
        (requiere Soldados Mineral)
        (requiere Soldados Gas)

        ;; Cantidad
        (= (comprar Barracones Mineral) 30)
        (= (comprar Barracones Gas) 10)
        (= (comprar Extractor Mineral) 10)
        (= (fabricar VCE Mineral) 5)
        (= (fabricar Marines Mineral) 10)
        (= (fabricar Marines Gas) 15)
        (= (fabricar Soldados Mineral) 30)
        (= (fabricar Soldados Gas) 30 )

        ;; GeneradoEn
        (generadoEn VCE CentroDeMando)
        (generadoEn Marines Barracones)
        (generadoEn Soldados Barracones)

        ;; Conexiones verticales y sus simétricos
        (caminoEntre LOC11 LOC21)
        (caminoEntre LOC21 LOC11)
        (caminoEntre LOC21 LOC31)
        (caminoEntre LOC31 LOC21)

        (caminoEntre LOC12 LOC22)
        (caminoEntre LOC22 LOC12)
        (caminoEntre LOC22 LOC32)
        (caminoEntre LOC32 LOC22)

        (caminoEntre LOC13 LOC23)
        (caminoEntre LOC23 LOC13)
        (caminoEntre LOC23 LOC33)
        (caminoEntre LOC33 LOC23)
        ;; Últimas Conexiones Verticales y sus simétricos
        (caminoEntre LOC14 LOC24)
        (caminoEntre LOC24 LOC14)
        (caminoEntre LOC24 LOC34)
        (caminoEntre LOC34 LOC24)
        (caminoEntre LOC34 LOC44)
        (caminoEntre LOC44 LOC34)
        ;;Conexiones horizontales Centro
        (caminoEntre LOC22 LOC23)
        (caminoEntre LOC23 LOC22)
        ;; Conexiones horizontales arriba
        (caminoEntre LOC11 LOC12)
        (caminoEntre LOC12 LOC11)
        (caminoEntre LOC13 LOC14)
        (caminoEntre LOC14 LOC13)
        ;; Conexiones Horizontales abajo
        (caminoEntre LOC31 LOC32)
        (caminoEntre LOC32 LOC31)
        (caminoEntre LOC33 LOC34)
        (caminoEntre LOC34 LOC33)

    )
    (:goal
        (and
            ;;(= (almacenado Mineral) 10)
            ;;(= (almacenado Gas) 10)
            ;;(edificioEn Extractor1 LOC44)
            ;;(Asignada VCE2 Gas1)
            ;;(= (almacenado Mineral) 10)
            ;;(= (almacenado Gas) 10)
            (edificioEn Barracones1 LOC32)
            (unidadeEn Marine1 LOC31)
            (unidadeEn Marine2 LOC24)
            (unidadeEn Soldado1 LOC12)
        )
    )
    ;;(:metric minimize (coste plan) )
)
