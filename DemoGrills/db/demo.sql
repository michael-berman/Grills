CREATE TABLE projects (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);

CREATE TABLE steps (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  project_id INTEGER,

  FOREIGN KEY(project_id) REFERENCES step(id)
);

CREATE TABLE photos (
  id INTEGER PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  step_id INTEGER

  FOREIGN KEY(step_id) REFERENCES step(id)
);


INSERT INTO
  projects (id, title)
VALUES
  (1, "How to build your own BBQ Barrel"),
  (2, "Inverted Bookshelf");

INSERT INTO
  steps (id, title, description, project_id)
VALUES
  (1, "The Prep",
     "First, I had to empty out all the excess honey and clean the
     inside (not exciting enough for a photo). Then I borrowed a grinder
     from a friend and cut the opening.", 1),
  (2, "Constructing the Stand",
     "I had to make a base and the only things around were some old
     chain-link fence posts that I'd never taken to the dump and some
     scrap plywood I'd demoed out of a creepy room in my basement.", 1),
  (3, "Attaching the Lid & Grill Grates",
     "I added brackets to hold the grills and to keep the lid from
     falling inside, as well as a lower rack to hold the coals and
     allow for air circulation.", 1),
  (4, "Finishing Touches",
     "Last steps in the construction were to add a handle
     (plain wooden dowel from the hardware store), air vents, and a
     temperature gauge. I also decided to spray the barrel with a high
     heat resistant pant. Besides customizing the color a little, the
     paint helps prevent rust on the barrel. The only thing left was
     to test it in a real-life BBQ situation.", 1),
   (5, "Materials",
      "In addition to the basic materials for a shelf of wood and
      brackets, you will also need elastic webbing and a staple gun.
      The elastic that I'm using here can stretch beyond 200% of its
      original size and is certainly strong enough to hold the books
      here.", 2),
   (6, "Measure it out",
      "The key things you need to figure out are how wide your books
      are and what length of elastic is good enough to support all of
      the books against the board without crushing them against
      it.", 2),
   (7, "Staple the Elastic to the Board",
      "Start each piece of elastic with the excess facing in. Staple
      this in place and fold the elastic back over to start running it
      down the board. Measure out 14 inches, staple it one inch farther
      and repeat until you get to the other end and fold the excess
      back inside again before stapling it.", 2),
   (8, "Insert Books to Test",
      "I slid the books in and even the heaviest book was perfectly
      snug. It turned out that two straps was too much for the smaller
      books and started to compress them, so I only used the front strap
      and squished the other strap behind it.", 2),
   (9, "Add Brackets and Attach to Wall",
      "Now that you know that the shelf itself is stable, add a couple
      of brackets to the other side of the board. Then simply screw it
      into the wall.", 2)

INSERT INTO
  photos (id, url, step_id)
VALUES
  (1, "https://i.imgur.com/afbtn6i.jpg", 1),
  (2, "https://i.imgur.com/dpRWyzG.jpg", 2),
  (3, "https://i.imgur.com/h5fD5YI.jpg", 3),
  (4, "https://i.imgur.com/NBUod94.jpg", 4),
  (5, "https://i.imgur.com/lUVGZYl.jpg", 5),
  (6, "https://i.imgur.com/8HP32g6.jpg", 6),
  (7, "https://i.imgur.com/RZJTeaB.jpg", 7),
  (8, "https://i.imgur.com/sMrPdZQ.jpg", 8),
  (9, "https://i.imgur.com/kE09d93.jpg", 9),
