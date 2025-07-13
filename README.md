From start to end, I have taken the following lecture as my reference.
1. Steve Brunton: Control Bootcamp
   https://www.youtube.com/watch?v=Pi7l8mMjYVE&list=PLMrJAkhIeNNR20Mz-VpzgfQs5zrYi085m
2. Brianno Coller: Classic Inverted Pendulum - Equations of Motion
   https://www.youtube.com/watch?v=5qJY-ZaKSic
These references will let you know the mathematical modelling of the inverted pendulum, and understand the  concept of control, like pole placement,
LQR, Kalman filter (state estimation), etc.

One important thing I understood while working on this project is that we first derive the nonlinear equations and then linearize the system around a fixed point (upright, in this case) 
to construct the A and B matrices based on the linear model. So, if you apply an initial disturbance that is far from the fixed point, the linear controller will not be effective in 
stabilizing the nonlinear system. Even if the disturbance is near the linearization point, there may still be a small offset from the reference state where you want the system to stabilize, 
though it will be nearly negligible.

That said, the linearized dynamics using the A and B matrices work perfectly to stabilize the pendulum around its upright position when the initial disturbance is small. If you want to 
understand how this works, follow the full lecture, try to write the code yourself (or seek assistance when needed), and make sure you will understand what you're doing — you’ll learn a lot.



