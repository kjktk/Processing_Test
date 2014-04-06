PImage mapImage;
Table locationTable;
int rowCount;

Table dataTable;
//初期値
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

void setup() {
  size(640, 400);
  mapImage = loadImage("map.png");
  locationTable = new Table("locations.tsv");
  //行数はグローバルに保存しておく
  rowCount = locationTable.getRowCount();
  
  dataTable = new Table("random.tsv");
  
  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if (value > dataMax) {
      dataMax = value;
    }
    if (value < dataMin) {
      dataMin = value;
    }
  }
  
  PFont font = loadFont("Verdana-12.vlw");
  textFont(font);

}

void draw() {
  background(0);
  image(mapImage, 0, 0);
  smooth();
  fill(192, 0, 0);
  noStroke();
  //位置ファイルの行をループして取得
  for (int row = 0; row < rowCount; row++) {
    String abbrev = dataTable.getRowName(row);
    float x = locationTable.getFloat(abbrev, 1);
    float y = locationTable.getFloat(abbrev, 2);
    drawData(x, y, abbrev);
  }
}

void drawData(float x,float y, String abbrev) {
  float value = dataTable.getFloat(abbrev, 1);
  float diameter = 0;
  if (value >= 0) {
    float a = map(value, 0, dataMax, 0, 255);
    diameter = map(value, 0, dataMax, 3, 30);
    fill(#333366, a);
  } else {
    float a = map(value, 0, dataMax, 0, 255);
    diameter = map(value, 0, dataMin, 3, 30);
    fill(#EC5166, a);
  }
  ellipse(x, y, diameter, diameter);
}

