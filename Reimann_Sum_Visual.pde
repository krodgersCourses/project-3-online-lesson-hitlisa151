int numRects = 1;  // Starting number of rectangles
float a = -1;      // Interval start
float b = 1;       // Interval end
float yMax = 1.5;

void setup() {
  size(800, 600);
  textAlign(LEFT, TOP);
  surface.setResizable(true);
}

void draw() {
  background(255);
  translate(width/2, height/2);  // Origin at center
  scale(1, -1);                  // Flip y-axis

  drawAxes();
  drawFunction();
  float approxArea = drawRectangles(numRects);  // ✅ This is where the rectangles are drawn

  // Flip back for text display
  scale(1, -1);
  translate(-width/2, -height/2);

  fill(0);
  textSize(16);
  text("Number of Rectangles: " + numRects, 20, 20);
  text("Approximate Area: " + nf(approxArea, 1, 5), 20, 45);
  text("Exact Area: 1.33333", 20, 70);
  text("Error: " + nf(abs(approxArea - 4.0/3.0), 1, 5), 20, 95);
}

void drawAxes() {
  stroke(150);
  line(-width/2, 0, width/2, 0); // x-axis
  line(0, -height/2, 0, height/2); // y-axis
}

void drawFunction() {
  stroke(0);
  noFill();
  beginShape();
  for (float x = -width/2; x < width/2; x += 1) {
    float fx = func(screenToMathX(x));
    vertex(x, mathToScreenY(fx));
  }
  endShape();
}

// ✅ This is the rectangle-drawing function
float drawRectangles(int n) {
  float dx = (b - a) / n;
  float area = 0;
  for (int i = 0; i < n; i++) {
    float xLeft = a + i * dx;
    float height = func(xLeft);
    area += height * dx;

    float rectX = mathToScreenX(xLeft);
    float rectY = mathToScreenY(height);
    float rectWidth = dx * (width / (b - a));
    

    fill(100, 100, 255, 100);
    noStroke();
    rect(rectX, 0, rectWidth, rectY);  // rect(x, y, width, height) — flipped y handled by scale()
  }
  return area;
}

// ✅ Your upside-down parabola function
float func(float x) {
  return -x * x + 1;
}

// Math-to-screen conversion helpers
float screenToMathX(float x) {
  return map(x, -width/2, width/2, a, b);
}

float mathToScreenX(float x) {
  return map(x, a, b, -width/2, width/2);
}

float mathToScreenY(float y) {
  return map(y, 0, yMax, 0, height/2);
}

void mousePressed() {
  numRects++;
}
