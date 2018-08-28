INSERT INTO `jobs` (`name`, `label`) VALUES
('Salvage', 'Bergung');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('Salvage', 0, 'interim', 'Bergungstrupp', 80, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('contrat', 'Bergungsgut', 15, 0, 1);
