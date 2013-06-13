#Technical Test

This repo contains a coding response to a test set in 2013 by Evgeny Shadchnev at Makers Academy in London. The code contained in this repository was produced by Neil Atkinson and Liz Candler as part of a paired programming exercise at Makers Academy.


##Test Details

Graphical editors allow users to edit images in the same way text editors let us modify documents. Images are represented as an M x N array of pixels with each pixel given a colour.

Produce a program that simulates interactive graphical editor.

###Input

The input consists of a line contianing a sequence of commands. Each command is represented by a single letter at the start of the line. Arguments to the comman are separated by spaces and follow the command character.

Pixel co-ordinated are represented by a pair of integers: 1) a column number between 1 and M, and 2) a row number between 1 and N. Where 1 <= M <= 250 and 1 <= N <= 250. The origin sits in the upper-left of the table. Colours are specified by capital letters.

###Commands

The editor supports 7 commands:
  1.  **I M N**. Create a new M x N image with all pixels coloured white (O)

  2.  **C**. Clears the table, setting all pixels to white (O)

  3.  **L X Y C**. Colours the pixel (X, Y) with colour C.

  4.  **V X Y1 Y2 C**. Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).

  5.  **H X1 X2 Y C**. Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).

  6.  **F X Y C**. Fill the region R with colour C. R is defined as: Pixel (X, Y) belongs to R. Any other pixel which is the same colour as (X, Y) and shares a common side with any pixel in R also belongs to this region.

  7.  **S**. Show the contents of the current image.

  8.  **X**. Terminate the session.


###Example

In the example below, > denotes input, => denotes program output.

    > I 5 6
    > L 2 3 A
    > S

    =>
    00000
    00000
    0A000
    00000
    00000
    00000

    > F 3 3 J
    > V 2 3 4 W
    > H 3 4 2 Z
    > S

    =>
    JJJJJ
    JJZZJ
    JWJJJ
    JWJJJ
    JJJJJ
    JJJJJ

