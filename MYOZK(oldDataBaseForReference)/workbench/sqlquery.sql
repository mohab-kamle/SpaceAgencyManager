-- 1-list telescope types and id
SELECT equip_ID, type AS 'telescope type'
FROM   equipment
WHERE  equip_type = 'telescope'
ORDER  BY type;

-- 2-list mexican equipment
SELECT equip_id, name, equip_type
FROM   equipment
WHERE  origin_country = 'Mexico';
    
-- 3-list active missions details
SELECT *
FROM mission
WHERE status = 'active';
    
-- 4-retrieve the available types of hardness in material
SELECT DISTINCT hardness
FROM material;
    
-- 5-calculate the experience of each crew
SELECT c.name,
	   DATEDIFF(CURDATE(), c.start_date) / 365 AS Experience
FROM crew c;
    
-- 6-list each equipment with its operator
SELECT p.name AS 'operator partner', e.name AS 'operated equipment'
FROM   partner p,
       equipment e
WHERE  e.partner_org_code = p.org_code;
    
-- 7-retrieve each partner and supplied machines including equipment and spacecraft 
SELECT p.name AS 'supplier', e.name AS 'machines'
FROM
    partner p,
    supplies s,
    equipment e
WHERE   s.partner_org_code = p.org_code
	    AND e.machinery_id = s.machinery_id 
UNION 
SELECT p.name, sc.name
FROM
    partner p,
    supplies s,
    spacecraft sc
WHERE   s.partner_org_code = p.org_code
        AND sc.machinery_id = s.machinery_id;
        
-- 8-list crew name with their missions'name
SELECT 
       c.name AS 'crew name',
       c.status AS 'status',
	   m.name AS 'mission name'
FROM
       crew c,
	   mission m,
       takes_off t
WHERE t.crew_ID = c.crew_ID
      AND t.mission_ID = m.mission_ID;

-- 9-retrieve each planet with its materials ordered acsendingly
SELECT p.name AS 'planet', m.name AS 'material'
FROM
       planet p,
       contains c,
       material m
WHERE  p.planet_id = c.planet_id
	   AND c.material_id = m.material_id
ORDER  BY p.name , m.name;

-- 10-give details of satellite including operator company 
-- of inspectors with the following cins 
-- ('38-7726916','01-8223240','53-1327041')

SELECT 
    CONCAT(s.fname, ' ', s.mname, ' ', s.lname) AS 'inspector full name',
    eqt.name AS 'Satellite name',
    opr.name 'operator Company',
    cs.orbit_type AS 'orbit type',
    cs.purpose
FROM
    EQUIPMENT eqt,
    PARTNER opr,
    COMMUNICATION_Satellite cs,
    STAFF s,
    INSPECTOR i
WHERE
        i.STAFF_CIN = s.CIN
        AND i.C_SAT_ID = cs.EQUIP_ID
        AND cs.EQUIP_ID = eqt.EQUIP_ID
        AND eqt.partner_org_code = opr.org_code
        AND i.STAFF_CIN IN ('38-7726916' , '01-8223240', '53-1327041');

-- 11-list maximum salary in each job_type
SELECT job_type AS 'job type', MAX(salary) AS 'maximum salary'
FROM   staff
GROUP  BY job_type;

-- 12-retrieve the name of astronaut with maximum fitness in each crew
SELECT 
      s.fname AS 'first name',
      MAX(a.physical_fitness) AS 'maximum fitness',
      c.name AS 'crew name'
FROM
      staff s,
      astronaut a,
      crew c
WHERE s.cin = a.staff_cin
	  AND a.crew_id = c.crew_id
GROUP BY c.name;

-- 13-list the astronaut with maximum fitness in each university
SELECT 
      a.staff_cin,
      s.fname,
      a.education,
      MAX(a.physical_fitness) AS 'physical fitness'
FROM  astronaut a INNER JOIN staff s ON s.cin = a.staff_cin
WHERE experience >= 7
GROUP BY a.education
ORDER BY 'physical fitness' DESC;

-- 14-list number of scientists for each speciality
SELECT s.specialty, COUNT(s.STAFF_CIN) AS 'number of scientists'
FROM
       SCIENTISTS s,
       staff st
WHERE  s.STAFF_CIN = st.CIN
GROUP  BY s.specialty;

-- 15-list number of staff in each category of job_type
SELECT job_type, COUNT(cin) AS 'number of staff'
FROM   staff
GROUP  BY job_type;

-- 16-show which mission has gone to planet with material of medium flexibility
SELECT m.name AS 'mission name', p.name AS 'planet name', mat.name
FROM
    (((mission m JOIN planet p ON m.planet_ID = p.planet_ID)
        JOIN contains c ON p.planet_ID = c.planet_ID)
	    JOIN material mat ON c.material_ID = mat.material_ID)
WHERE c.material_ID IN (SELECT material_ID
						FROM   material
                        WHERE  flexibility = 'medium')
GROUP BY mat.name;

-- 17-retrieve number of researches participated by partners
SELECT 
    p.org_code,
    p.name,
    COUNT(c.research_ID) AS number_of_research
FROM
    partcipate c,
    partner p
WHERE
    p.org_code = c.partner_org_code
GROUP BY p.org_code
ORDER BY p.name , p.org_code ASC;

-- 18-list staff'name from each job_type that takes salary higher than the avg of his job_type
SELECT 
    Job_type, fname, salary
FROM
    staff
WHERE
    salary > ALL (SELECT 
            AVG(salary)
        FROM
            staff
        GROUP BY job_type)
GROUP BY Job_type;

-- 19-retrieve each research assigned to mission
SELECT 
    r.name AS 'research name', m.name AS 'mission name'
FROM
    research r,
    mission m,
    assigned_to a
WHERE
    r.research_ID = a.research_ID
        AND m.mission_ID = a.mission_ID;

-- 20-view the cin ,name ,age and address of each male person in staff   
SELECT 
    cin,
    fname,
    mname,
    lname,
    CONCAT(build_no,
            ' ',
            street_name,
            ' ',
            postal_code,
            ' ',
            city,
            ' ',
            state,
            ' ',
            country) AS address,
    YEAR(CURDATE()) - YEAR(birth_date) AS age
FROM
    staff
WHERE
    gender = 'm';

-- 21-which telescope launched on spacecraft between 2016 and 2021  
SELECT 
    S.equip_ID AS 'space_telescope',
    SC.name AS 'spacecraft name'
FROM
    space_telescope S
        NATURAL JOIN
    spacecraft SC
WHERE
    launch_date BETWEEN '2016-1-1' AND '2021-12-31';

-- 22-show all spacecrafts with the space telescope launche on it (if exist)
SELECT 
    SC.name 'spacecraft name', S.equip_ID AS 'space_telescope'
FROM
    spacecraft SC
        LEFT OUTER JOIN
    space_telescope S ON S.spacecraft_ID = SC.spacecraft_ID;

-- 23-show spacecraft details that has space telescope launched on it 
-- without the one with minimum focal_length
SELECT 
    sc.name, sc.type, sc.launch_pad
FROM
    spacecraft SC,
    space_telescope S
WHERE
    S.spacecraft_ID = SC.spacecraft_ID
        AND S.diameter > (SELECT 
            MIN(focal_length) AS 'min focal length'
        FROM
            space_telescope);

-- 24-list connections between spacecrafts and communication satellites
SELECT 
    s.name AS 'name of spacecraft',
    e.name AS 'communication sat'
FROM
    spacecraft s,
    equipment e
WHERE
    e.type = 'communication'
        AND s.C_Sat_ID = e.equip_ID;

-- 25-retrieve number of active missions for each planet
SELECT 
    p.name, COUNT(m.mission_id) AS number_of_active_missions
FROM
    planet p,
    mission m
WHERE
    m.planet_ID IN (SELECT 
            p.planet_ID
        FROM
            planet)
        AND m.status = 'active'
GROUP BY p.name;

-- 26-List the names of the astronauts who have a physical fitness score above the average
SELECT 
    s.fname, a.physical_fitness
FROM
    astronaut a
        INNER JOIN
    staff s ON s.cin = a.staff_cin
WHERE
    a.physical_fitness > (SELECT 
            AVG(physical_fitness)
        FROM
            astronaut);

-- 27-show spacecrafts whose name has the second letter 'a' details
SELECT 
    *
FROM
    spacecraft s
WHERE
    s.name LIKE '_a%';

-- 28-show all researches with their scientist names done without equipment
SELECT 
    staff.fname, r.*
FROM
    research r,
    conduct c,
    scientists s,
    staff
WHERE
    r.research_ID = c.research_ID
        AND c.scientist_STAFF_CIN = s.STAFF_CIN
        AND s.STAFF_CIN = staff.cin
        AND c.equip_id = '';

-- 29-list the details of people with more than 3 phone numbers
SELECT 
    s.cin,
    s.fname,
    s.city,
    s.job_type,
    COUNT(p.phone_no) AS 'number of phones'
FROM
    staff s
        JOIN
    phone_number p ON p.staff_cin = s.cin
GROUP BY s.cin
HAVING COUNT(p.phone_no) > 3;

-- 30-retrieve planets with rings
SELECT *
FROM planet
WHERE has_rings = 1;

 