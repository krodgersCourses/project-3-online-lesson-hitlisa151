let numRects = 1;
let a = -1;
let b = 1;
let yMax = 1.5;

function setup() {
  createCanvas(800, 600);
  textAlign(LEFT, TOP);
}

function draw() {
  background(255);

  drawAxes();
  drawFunction();
  let approxArea = drawRectangles(numRects);

  fill(0);
  textSize(16);
  text("Number of Rectangles: " + numRects, 20, 20);
  text("Approximate Area: " + approxArea.toFixed(5), 20, 45);
  text("Exact Area: 1.33333", 20, 70);
  text("Error: " + Math.abs(approxArea - 4 / 3).toFixed(5), 20, 95);
}

function drawAxes() {
  stroke(150);
  let xZero = map(0, a, b, 0, width);
  let yZero = map(0, 0, yMax, height, 0);
  line(0, yZero, width, yZero); // x-axis
  line(xZero, 0, xZero, height); // y-axis
}

function drawFunction() {
  stroke(0);
  noFill();
  beginShape();
  for (let px = 0; px <= width; px++) {
    let x = map(px, 0, width, a, b);
    let y = func(x);
    let screenY = map(y, 0, yMax, height, 0);  // flip y
    vertex(px, screenY);
  }
  endShape();
}

function drawRectangles(n) {
  let dx = (b - a) / n;
  let area = 0;
  for (let i = 0; i < n; i++) {
    let xMid = a + (i + 0.5) * dx;
    let heightVal = func(xMid);
    area += heightVal * dx;

    let rectX = map(xMid - dx / 2, a, b, 0, width);
    let rectW = dx * (width / (b - a));
    let rectY = map(heightVal, 0, yMax, height, 0);
    let rectH = height - rectY;

    fill(100, 100, 255, 100);
    noStroke();
    rect(rectX, rectY, rectW, height - rectY);
  }
  return area;
}

function func(x) {
  return -x * x + 1;
}

function mousePressed() {
  numRects++;
}
