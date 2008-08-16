CREATE TABLE contexts ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" varchar(255) DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE schema_info (version integer);
CREATE TABLE tasks ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "label" varchar(255) DEFAULT NULL, "context_id" integer DEFAULT NULL, "completed_at" datetime DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
INSERT INTO schema_info (version) VALUES (2)