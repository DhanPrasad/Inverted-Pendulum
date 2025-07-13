For start to end I have taken the following lecture as mmy reference.
1. Steve Brunton:: Contorl Bootcamp
   https://www.youtube.com/watch?v=Pi7l8mMjYVE&list=PLMrJAkhIeNNR20Mz-VpzgfQs5zrYi085m
2. Brianno Coller:: Classic Inverted Pendulum - Equations of Motion
   https://www.youtube.com/watch?v=5qJY-ZaKSic
These reference will let you know the mathematical modelling of inverted pendulum, and understand concept of control like pole placement,
LQR, Kalman filter (state estimation) etc.

One important I understood while working on this project is, we derive non-linear equation and at some fixed point (upright in this case)
linearize the system and construct A and B matrix on the basis of linear model. So, if you are feeding the initial disturbance far from 
your fixed point, non-linear dynamics won't work to stabilize. Even if the disturbance is near to the linearization point, there would 
still be small offset from reference you want your system to be stabilized at, however it will be nearly negligible. 
Beside that, linearized dynamics with the liearized A and B matrix works perfectly to stabilized pendulum in its upright position. So, 
if you really want to understand, follow the whole lecture and try to code on your own (or take assistance) and understand what you are
doing, you will learn so much.
