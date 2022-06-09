(define (problem ExtraerGas)
    (:domain ejer3)
    (:objects
        VCE1 VCE2 VCE3 - Unidades
        CentroDeMando1 Extractor1 Barracones1 - Edificios
        Minerales Minerales2 Gas1 - Recursos
        LOC44 LOC43 LOC42 LOC41 - Localizacion
        LOC34 LOC33 LOC32 LOC31 - Localizacion
        LOC24 LOC23 LOC22 LOC21 - Localizacion
        LOC14 LOC13 LOC12 LOC11 - Localizacion
    )
    (:init
        (edificioEn CentroDeMando1 LOC11)
        (construido CentroDeMando1)
        (unidadeEn VCE1 LOC11)
        (unidadeEn VCE2 LOC11)
        (unidadeEn VCE3 LOC11)
        (recursoEn Minerales LOC22)
        (recursoEn Minerales2 LOC32)
        (recursoEn Gas1 LOC44)
        ;; Tipos
        (esUnidad VCE1 VCE)
        (esUnidad VCE2 VCE)
        (esUnidad VCE3 VCE)
        (esRecurso Minerales Mineral)
        (esRecurso Minerales2 Mineral)
        (esRecurso Gas1 Gas)
        (esEdificio Extractor1 Extractor)
        (esEdificio CentroDeMando1 CentroDeMando)
        (esEdificio Barracones1 Barracones)
        ;; Necesidades
        (necesita Extractor Mineral)
        (necesita Barracones Mineral)
        (necesita Barracones Gas)
        ;; Edificios que utiliza los recursos
        (utiliza Gas Extractor)
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
            (edificioEn Barracones1 LOC33)
        )
    )
)
