1️⃣ **Guía técnica (TASM, TLINK y ejecución)**
2️⃣ **Introducción formal de tu simulacro de parcial**

---

# 🧾 README - Trabajo Práctico Final SPD

### Simulacro de Parcial: *“Juego de Adivinanzas del CPU”*

---

## ⚙️ 1️⃣ INSTRUCCIONES DE COMPILACIÓN Y EJECUCIÓN

Este proyecto fue desarrollado en **Lenguaje Ensamblador (8086)** y se compila bajo **MS-DOS / DOSBox** utilizando las herramientas **TASM** (Turbo Assembler) y **TLINK** (Turbo Linker).

---

### 📦 Estructura del proyecto

El trabajo se compone de múltiples módulos (librerías externas):

```
TP.ASM               → Programa principal (menú SPD)
IMP.ASM → Rutina genérica para mostrar texto
carga.ASM     → Entrada de texto del usuario
opc.ASM → Menú principal
mus.ASM / error.ASM → Efectos sonoros
alu.ASM        → Juego sobre Unidad Aritmético-Lógica
mem.ASM        → Juego sobre Memoria Principal
int.ASM        → Juego sobre Interrupciones
trol.ASM         → Juego sobre Unidad de Control
ea.ASM         → Juego sobre Entradas/Salidas
color.ASM            → Cambio de color en pantalla
r22a.asm  → convertidor de regto ascuii
```

---

### 🧩 Compilación paso a paso

1️⃣ **Abrir DOSBox y montar la carpeta del proyecto:**

```dos
mount c c:\tp_spd
c:
```

2️⃣ **Compilar cada archivo fuente:**

```dos
tasm tp.asm
tasm imp.asm
tasm leer_opcion_menu.asm
tasm sonido_presentacion.asm
tasm sonido_error.asm
tasm jugar_mem.asm
tasm jugar_alu.asm
tasm jugar_int.asm
tasm jugar_uc.asm
tasm jugar_io.asm
tasm color.asm
tasm r22a.asm
```

Cada uno debe generar su respectivo `.OBJ` sin errores.

3️⃣ **Enlazar todo el programa principal:**

```dos
tlink tp.obj imp.obj leer_opcion_menu.obj sonido_presentacion.obj sonido_error.obj jugar_mem.obj jugar_alu.obj jugar_int.obj jugar_uc.obj jugar_io.obj color.obj r22a.obj
```

Esto produce el ejecutable:

```
TP.EXE
```

4️⃣ **(Opcional) Crear la intro en formato `.COM`:**

```dos
tasm intro.com.asm
tlink /t intro.com.obj
```

Esto genera `INTRO.COM`.

---

### ▶️ Ejecución del juego

Podés hacerlo directamente:

```dos
tp.exe
```

O bien, si usás la intro animada:

```dos
intro.com
tp.exe
```

---

### 💡 Tip: automatizar con un archivo .BAT

Podés crear un script `TP.BAT` con:

```bat
@echo off
intro.com
tp.exe
```

Así, con solo escribir `TP`, se ejecuta la intro y el juego completo.

---

## 🧠 2️⃣ INTRODUCCIÓN DEL PROYECTO

**Trabajo Práctico Final – Simulacro de Parcial SPD (Sistemas con Procesamiento de Datos)**
**Universidad Nacional de San Martín (UNSAM)**
**Cátedra: SPD - Microprocesadores y Periféricos**

---

### 📖 Descripción

El presente trabajo práctico tiene como objetivo **simular un examen interactivo de repaso sobre la arquitectura del CPU y sus componentes internos**, utilizando **lenguaje ensamblador del procesador Intel 8086**.

El programa está dividido en **cinco módulos principales**, cada uno representando una unidad del CPU:

1. **Unidad Aritmético-Lógica (ALU)**
2. **Memoria Principal (RAM)**
3. **Interrupciones (INT)**
4. **Unidad de Control (UC)**
5. **Entradas / Salidas (E/S)**

Cada módulo presenta al usuario una serie de **preguntas de opción múltiple (A/B/C)**, simulando la lógica de un **parcial real**, pero con un entorno interactivo, sonoro y visual.

---

### 🎮 Dinámica del Juego

* El jugador selecciona una de las 5 unidades.
* Cada unidad contiene **5 preguntas técnicas**.
* Se responde con las letras **A, B o C** (validadas por la función `leer_caracter_abc`).
* Si el usuario responde correctamente, avanza a la siguiente pregunta.
* Si se equivoca, el sistema reproduce un sonido de error y muestra una pista.
* Al finalizar todas las unidades, se muestra un mensaje final de agradecimiento.

---

### 🔊 Funcionalidades destacadas

✅ **Sonidos** tipo arcade mediante el altavoz del sistema (puerto `42h`).
✅ **Colores retro** en modo texto (BIOS `int 10h`).
✅ **Librerías externas** organizadas modularmente.
✅ **Compatibilidad total con TASM/TLINK y DOSBox**.
✅ **Posibilidad de extensión a modo gráfico (13h)** para mostrar imágenes `.BMP` al ganar o perder.

---

### 💾 Conclusión

Este trabajo combina conceptos de **programación estructurada en ASM**, **manejo de periféricos**, **interrupciones del BIOS/DOS**, **control de flujo y estructuras lógicas**, y **diseño modular**, demostrando el dominio de la arquitectura del **procesador Intel 8086** y su aplicación práctica en un entorno didáctico interactivo.

---

¿Querés que ahora te prepare el README también en formato **.TXT para incluir en la entrega (listo para DOS)** con formato 80x25 y salto de línea DOS (`0Dh,0Ah`)? Puedo generarlo directamente.
