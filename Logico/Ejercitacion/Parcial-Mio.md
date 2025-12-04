# Nota

La consigna esta subida al DRIVE como parcial mio

# Base de conocimientos

% doctor(Nombre)
doctor(ali).
doctor(nazli).
doctor(ferman).
doctor(karen).

% especialidad(Doctor, Especialidad)
% Las especialidades son functores
% - asistente(mentor, horasAsistidas)
% - Cirugia(Organo)
% - mentor

especialidad(ali, asistente(ferman, 200)).
especialidad(ali, cirugia(corazon)).
especialidad(nazli, cirugia(corazon)).
especialidad(ferman, cirugia(cerebro)).
especialidad(ferman, mentor).

% esPacienteDe(Paciente, Doctor)
esPacienteDe(tini, ali).
esPacienteDe(duki, karen).
esPacienteDe(ali, ferman).
esPacienteDe(ferman, ali).

# 1 

```prolog
confianzaEntreDoctores(Doctor, OtroDoctor):-
    esPacienteDe(Doctor, OtroDoctor),
    esPacienteDe(OtroDoctor, Doctor),
    Doctor \= OtroDoctor.

```
# 2 

```prolog
reconocimiento(mentor, 105).

% Asi lo hice yo
reconocimiento(asistente, Reconocimiento):-
    especialidad(_ , asistente(_ , Reconocimiento)).

% Gemini
reconocimiento(asistente(_, Horas), Horas).

% Asi lo hice yo
reconocimiento(cirugia, 500):-
    especialidad(_ , cirugia(cerebro)).

% Gemini
reconocimiento(cirugia(cerebro), 500).

% Asi lo hice yo
reconocimiento(cirguia, 0):-
    especialidad(_ , cirugia(OtroOrgano)),
    OtroOrgano \= cerebro

% Gemini
reconocimiento(cirugia(Organo), 0):-
    Organo \= cerebro.

```

# 3

```prolog
reconocimientoTotal(Doctor, Total):-
    doctor(Doctor), % Generamos el doctor para que sea inversible
    findall(Reconocimiento, (especialidad(Doctor, Especialidad), reconocimiento(Especialidad, Reconocimiento)) , Reconocimientos),
    sum_list(Reconocimientos, Total).
```

# 4

```prolog
esGroso(Doctor):-
    reconocimientoTotal(Doctor, Total),
    Total > 500.

bienCuidado(Paciente):-
    esPacienteDe(Paciente, _),  % 1. Generador: Aseguramos que sea un paciente del sistema
    forall(
        esPacienteDe(Paciente, Doctor), % Para todo Doctor de este Paciente...
        esGroso(Doctor)                 % ... ese Doctor debe ser Groso.
    ).

% El forall no liga variables hacia "afuera" (no devuelve el paciente). Primero necesitamos un generador previo para que Paciente tenga valor.
```

# 5 

```prolog
estaComplicado(Paciente):-
    esPacienteDe(Paciente, _),
    not(bienCuidado(Paciente)).

estaComplicado(Paciente):-
    esPacienteDe(Paciente, Doctor),       % 1. Existe un doctor de este paciente...
    not(confianzaEntreDoctores(_, Doctor)). % 2. ...tal que NO existe confianza con nadie.
```

# 6

```prolog
esImportante(Doctor):-
    esGroso(Doctor).

esImportante(Doctor):-
    especialidad(Doctor, asistente(DoctorImportante, _ )),
    esImportante(DoctorImportante).
    

doctorMilagro(Doctor):-
    doctor(Doctor),

    reconocimientoTotal(Doctor, Total),
    forall(reconocimientoTotal(_ , Reconocimiento), Total >= Reconocimiento), % Mayor o igual porque en algun punto se evalua con el mismo y si no romperia

    forall(confianzaEntreDoctores(Doctor, OtroDoctor), esImportante(OtroDoctor)).
```








