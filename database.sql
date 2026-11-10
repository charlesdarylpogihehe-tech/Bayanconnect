CREATE DATABASE IF NOT EXISTS bayanconnect CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bayanconnect;

CREATE TABLE IF NOT EXISTS admins (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS services (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  requirements TEXT NULL,
  office VARCHAR(150) NULL,
  contact VARCHAR(100) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_services_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS announcements (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_announcements_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS residents (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NULL,
  phone VARCHAR(50) NULL,
  address VARCHAR(255) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_residents_name (full_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS service_requests (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  resident_name VARCHAR(150) NOT NULL,
  contact VARCHAR(100) NULL,
  service_id INT UNSIGNED NOT NULL,
  purpose TEXT NOT NULL,
  status ENUM('Pending','Processing','Completed','Rejected') NOT NULL DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_requests_status (status),
  INDEX idx_requests_created (created_at),
  CONSTRAINT fk_requests_service FOREIGN KEY (service_id)
    REFERENCES services(id) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- The starter administrator uses a bcrypt password hash for "admin123".
INSERT INTO admins (name, username, password)
VALUES ('System Administrator', 'admin', '$2y$12$G3a2Ww6IIolo./RQ9AiIpeIIojam6CFAFwQvjSCZzccEu7QOxgiV2')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  password = VALUES(password);

INSERT INTO services (name, description, requirements, office, contact)
SELECT 'Barangay Clearance', 'Request a barangay clearance for employment, school, business, and other official purposes.', 'Valid government-issued ID; proof of residency if required.', 'Barangay Office', 'Contact the Barangay Office'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE name='Barangay Clearance');

INSERT INTO services (name, description, requirements, office, contact)
SELECT 'Certificate of Residency', 'Obtain an official certificate confirming residency within the community.', 'Valid government-issued ID.', 'Barangay Office', 'Contact the Barangay Office'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE name='Certificate of Residency');

INSERT INTO services (name, description, requirements, office, contact)
SELECT 'Community Assistance', 'Submit a request for available community assistance and support programs.', 'Valid ID and supporting documents, when applicable.', 'Community Services Desk', 'Contact the Community Services Desk'
WHERE NOT EXISTS (SELECT 1 FROM services WHERE name='Community Assistance');

INSERT INTO announcements (title, content)
SELECT 'Welcome to BayanConnect', 'BayanConnect provides community information and available services in one convenient place.'
WHERE NOT EXISTS (SELECT 1 FROM announcements WHERE title='Welcome to BayanConnect');
