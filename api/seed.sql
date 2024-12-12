INSERT INTO `users` (`username`, `email`, `hashed_password`, `remember_token`, `created_at`, `updated_at`, `is_active`)
VALUES ('interviewer1', 'interviewer1@example.com', 'hashedpassword123', NULL, NOW(), NOW(), 1);


INSERT INTO `interviewees` (`name`, `gender`, `email`, `is_interviewed`, `created_at`, `updated_at`)
VALUES
('John Doe', 'male', 'john.doe1@example.com', TRUE, NOW(), NOW()),
('Jane Smith', 'female', 'jane.smith@example.com', TRUE, NOW(), NOW()),
('Alex Johnson', 'male', 'alex.johnson@example.com', TRUE, NOW(), NOW()),
('Emily Brown', 'female', 'emily.brown@example.com', TRUE, NOW(), NOW()),
('Chris Davis', 'male', 'chris.davis@example.com', TRUE, NOW(), NOW()),
('Sophia Martinez', 'female', 'sophia.martinez@example.com', FALSE, NOW(), NOW()),
('Michael Wilson', 'male', 'michael.wilson@example.com', FALSE, NOW(), NOW()),
('Olivia Garcia', 'female', 'olivia.garcia@example.com', FALSE, NOW(), NOW()),
('Daniel Lee', 'male', 'daniel.lee@example.com', FALSE, NOW(), NOW()),
('Isabella Hernandez', 'female', 'isabella.hernandez@example.com', FALSE, NOW(), NOW()),
('Ethan Clark', 'male', 'ethan.clark@example.com', FALSE, NOW(), NOW()),
('Mia Lewis', 'female', 'mia.lewis@example.com', FALSE, NOW(), NOW()),
('Aiden Walker', 'male', 'aiden.walker@example.com', FALSE, NOW(), NOW()),
('Charlotte Hall', 'female', 'charlotte.hall@example.com', FALSE, NOW(), NOW()),
('Logan Allen', 'male', 'logan.allen@example.com', FALSE, NOW(), NOW()),
('Harper Young', 'female', 'harper.young@example.com', FALSE, NOW(), NOW()),
('Lucas King', 'male', 'lucas.king@example.com', FALSE, NOW(), NOW()),
('Amelia Wright', 'female', 'amelia.wright@example.com', FALSE, NOW(), NOW()),
('Jacob Scott', 'male', 'jacob.scott@example.com', FALSE, NOW(), NOW()),
('Evelyn Green', 'female', 'evelyn.green@example.com', FALSE, NOW(), NOW());

INSERT INTO `expressions` (`interviewee_id`, `interviewer_id`, `sad`, `disgust`, `surprise`, `angry`, `fear`, `happy`, `neutral`, `created_at`, `updated_at`)
VALUES
(1, 1, 5, 3, 7, 2, 1, 9, 4, NOW(), NOW()),
(2, 1, 2, 0, 4, 5, 3, 8, 1, NOW(), NOW()),
(3, 1, 3, 1, 5, 0, 2, 7, 6, NOW(), NOW()),
(4, 1, 1, 4, 3, 2, 5, 6, 2, NOW(), NOW()),
(5, 1, 4, 2, 1, 3, 6, 5, 0, NOW(), NOW());