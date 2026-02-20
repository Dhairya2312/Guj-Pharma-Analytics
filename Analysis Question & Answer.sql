--|---------------------------------------------------|
--      1. BASIC SELECT & FILTERING (1-15)
--|---------------------------------------------------|
select * from Companies

-- Q1: List all pharmaceutical companies headquartered in Ahmedabad
select CompanyName, EstablishmentYear, EmployeeCount, AnnualRevenueCrore
from Companies
where HeadquarterCity ='ahmedabad' 
order by AnnualRevenueCrore desc;

-- Q2: Find companies established before 1960
select CompanyName, EstablishmentYear,CompanyType, HeadquarterCity
from Companies
where  EstablishmentYear < 1960
order by EstablishmentYear;


-- Q3: Show companies with more than 10,000 employees
select CompanyName,EstablishmentYear,CompanyType,HeadquarterCity,EmployeeCount,AnnualRevenueCrore
from Companies
where EmployeeCount >10000
order by EmployeeCount desc;


-- Q4: List all WHO-GMP certified companies
select CompanyName,WHOGMPCertified,EstablishmentYear,CompanyType,HeadquarterCity,AnnualRevenueCrore
from Companies
where WHOGMPCertified = 1
order by CompanyName;


-- Q5: Display companies with annual revenue greater than 5000 crore
select CompanyName,EstablishmentYear,CompanyType,HeadquarterCity,AnnualRevenueCrore
from Companies
where AnnualRevenueCrore > 5000
order by AnnualRevenueCrore desc;


-- Q6: Find all manufacturing companies (exclude distributors and research)
select CompanyName, CompanyType,EstablishmentYear, EmployeeCount, AnnualRevenueCrore
from Companies
where CompanyType = 'Manufacturer'
order by AnnualRevenueCrore desc;


-- Q7: Show companies that have export capability
select CompanyName,ExportCapability,EstablishmentYear,CompanyType,HeadquarterCity,AnnualRevenueCrore
from Companies
where ExportCapability = 1
order by AnnualRevenueCrore desc;


-- Q8: List companies with both ISO and WHO-GMP certification
select CompanyName,ISOCertified,WHOGMPCertified,EstablishmentYear,AnnualRevenueCrore
from Companies
where ISOCertified = 1 and WHOGMPCertified = 1 
order by CompanyName;


-- Q9: Find all companies in Vadodara with revenue > 1000 crore
select CompanyName,HeadquarterCity,AnnualRevenueCrore
from Companies
where HeadquarterCity = 'vadodara' and AnnualRevenueCrore > 1000


-- Q10: Display companies established in the last 10 years (2015 onwards)
SELECT CompanyName, EstablishmentYear, HeadquarterCity, CompanyType
FROM Companies
WHERE EstablishmentYear >= 2015
ORDER BY EstablishmentYear DESC;


-- Q11: Show top 10 companies by employee count
select top 10 EmployeeCount,CompanyName, EstablishmentYear, HeadquarterCity, CompanyType
from Companies
where EmployeeCount


-- Q12: List all research-focused companies in Gujarat
select CompanyName,CompanyType,HeadquarterCity,AnnualRevenueCrore 
from Companies
where CompanyType = 'Research'


-- Q13: Find companies with 'Pharma' in their name
select * from Companies
where CompanyName like '%Pharma%'


-- Q14: Display companies without export capability
select CompanyName,EstablishmentYear,ExportCapability
from Companies
where ExportCapability = '0'


-- Q15: Show companies headquartered in Surat or Rajkot
select *
from Companies
where HeadquarterCity in ('surat','rajkot')

