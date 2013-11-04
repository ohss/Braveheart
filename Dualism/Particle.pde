/** Based on:
*        http://processing.datasingularity.com/sketches/ParticlePhysicsTutorial_6/applet/ParticlePhysicsTutorial_6.pde
*        
**/

public class Particle {

        PVector location;
        PVector velocity;
        PVector acceleration;
        PVector gravLocation;
        float mass;
        float gravMass = 1000;
        float friction = 0.9;
        float strength = 500;
        float minDistance = 500;
        float minDistanceToMouse = 100;
        int drawSize = 1;

        public Particle (float x, float y) {
                location = new PVector(x,y);
                velocity = new PVector(0,0);
                acceleration = new PVector(0,0);
                gravLocation = new PVector(x, y);
                mass = 10;
                
        }

        //repel mouse and gravitate towards gravTo point
        public void update() {
                applyMouseRejectForce();
                applyDissipativeForce();
                applyAttractiveForce();
                velocity.add(acceleration);
                location.add(velocity);
                acceleration.mult(0);
        }

        private int newColor() {
        	float w = random(0.3, 1.5);
                float ww = random(-1,1);
                return(color(44*(w+1), 117*(ww+1), 255));
        }

        void applyMouseRejectForce() {
                PVector mouseLocation = new PVector(mouseX, mouseY);
                PVector dir = PVector.sub(mouseLocation, location); //vector between particle and mouse
                float d = dir.mag(); //magnitude of the vector (lenght)
                if (d < minDistanceToMouse) {
                        dir.normalize();
                        float force = (strength * mass * mass) / (d * d);
                        dir.mult(force);
                        dir.mult(-1);
                        applyForce(dir);
                }
        }

        void applyDissipativeForce() {
                PVector f = PVector.mult(velocity, -friction);
                applyForce(f);
        }

        void applyAttractiveForce() {
                PVector dir = PVector.sub(gravLocation, location); //vector between particle and gravitation point
                float d = dir.mag(); //magnitude of the vector (lenght)
                if (d < minDistance) d = minDistance;
                dir.normalize();
                float force = (strength * mass * gravMass) / (d * d);
                dir.mult(force);
                applyForce(dir);
        }

        private void applyForce(PVector force) {
                acceleration.add(PVector.div(force, mass));
        }

        public void draw() {
                update();
                stroke(newColor());
                noFill();
                ellipse(location.x, location.y, drawSize, drawSize);
        }
}