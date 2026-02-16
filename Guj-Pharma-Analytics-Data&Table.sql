
-- GUJARAT PHARMACEUTICAL COMPANIES ANALYTICS DATABASE


CREATE DATABASE GujaratPharmaAnalytics;
GO

USE GujaratPharmaAnalytics;
GO


-- TABLE 1: COMPANY MASTER
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName VARCHAR(200) NOT NULL,
    EstablishmentYear INT,
    HeadquarterCity VARCHAR(100),
    CompanyType VARCHAR(50), 
    EmployeeCount INT,
    AnnualRevenueCrore DECIMAL(15,2),
    ExportCapability BIT,
    WHOGMPCertified BIT,
    ISOCertified BIT,
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Website VARCHAR(200),
    RegistrationDate DATE DEFAULT GETDATE()
);

-- TABLE 2: MANUFACTURING FACILITIES
CREATE TABLE ManufacturingFacilities (
    FacilityID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    FacilityName VARCHAR(200),
    City VARCHAR(100),
    District VARCHAR(100),
    FacilityType VARCHAR(100), 
    ProductionCapacityPerMonth DECIMAL(15,2),
    OperationalStatus VARCHAR(50), 
    Area_SqFt INT,
    NumberOfProductionLines INT
);

-- TABLE 3: PRODUCTS
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    ProductName VARCHAR(200) NOT NULL,
    GenericName VARCHAR(200),
    TherapeuticCategory VARCHAR(100), 
    DosageForm VARCHAR(50),
    Strength VARCHAR(50),
    PackSize VARCHAR(50),
    MRP DECIMAL(10,2),
    LaunchDate DATE,
    IsPatented BIT,
    PrescriptionRequired BIT
);

-- TABLE 4: SALES DATA
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    SaleDate DATE NOT NULL,
    QuantitySold INT,
    SaleAmount DECIMAL(15,2),
    SaleRegion VARCHAR(100), 
    CustomerType VARCHAR(50),
    DiscountPercent DECIMAL(5,2)
);

-- TABLE 5: RESEARCH & DEVELOPMENT
CREATE TABLE RnD (
    RnDID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    ProjectName VARCHAR(200),
    TherapeuticArea VARCHAR(100),
    StartDate DATE,
    ExpectedCompletionDate DATE,
    BudgetCrore DECIMAL(12,2),
    CurrentStage VARCHAR(100), 
    NumberOfResearchers INT,
    CollaborationPartner VARCHAR(200)
);

-- TABLE 6: REGULATORY COMPLIANCE
CREATE TABLE RegulatoryCompliance (
    ComplianceID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    CertificationType VARCHAR(100), 
    CertificationDate DATE,
    ExpiryDate DATE,
    IssuingAuthority VARCHAR(200),
    ComplianceStatus VARCHAR(50) 
);

-- TABLE 7: EXPORTS
CREATE TABLE Exports (
    ExportID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    ExportDate DATE,
    DestinationCountry VARCHAR(100),
    DestinationRegion VARCHAR(100),
    QuantityExported INT,
    ExportValueUSD DECIMAL(15,2),
    ShippingMode VARCHAR(50) 
);

-- TABLE 8: QUALITY CONTROL
CREATE TABLE QualityControl (
    QC_ID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    FacilityID INT FOREIGN KEY REFERENCES ManufacturingFacilities(FacilityID),
    InspectionDate DATE,
    InspectionType VARCHAR(100),
    InspectorName VARCHAR(100),
    OverallRating VARCHAR(50),
    DefectsFound INT,
    ComplianceScore DECIMAL(5,2), 
    FollowUpRequired BIT
);

-- TABLE 9: SUPPLIERS
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName VARCHAR(200),
    SupplierType VARCHAR(100), 
    State VARCHAR(100),
    Country VARCHAR(100),
    ReliabilityRating DECIMAL(3,2), 
    YearsInBusiness INT
);

-- TABLE 10: PROCUREMENT
CREATE TABLE Procurement (
    ProcurementID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    MaterialType VARCHAR(100),
    ProcurementDate DATE,
    Quantity DECIMAL(15,2),
    UnitPrice DECIMAL(12,2),
    TotalCost DECIMAL(15,2),
    PaymentTerms VARCHAR(100)
);


-- TABLE 11: EMPLOYEES
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    EmployeeName VARCHAR(200),
    Department VARCHAR(100), 
    Designation VARCHAR(100),
    JoiningDate DATE,
    Salary DECIMAL(12,2),
    Experience INT, -- in years
    Qualification VARCHAR(100)
);

-- TABLE 12: FINANCIAL PERFORMANCE
CREATE TABLE FinancialPerformance (
    FinancialID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    FinancialYear INT,
    Quarter INT,
    RevenueCrore DECIMAL(15,2),
    ProfitCrore DECIMAL(15,2),
    EBITDA_Crore DECIMAL(15,2),
    RnD_InvestmentCrore DECIMAL(12,2),
    MarketingExpenseCrore DECIMAL(12,2),
    NetProfitMargin DECIMAL(5,2)
);


-- TABLE 13: MARKET SHARE
CREATE TABLE MarketShare (
    MarketShareID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    TherapeuticSegment VARCHAR(100),
    Year INT,
    Quarter INT,
    MarketSharePercent DECIMAL(5,2),
    Rank INT,
    TotalMarketSizeCrore DECIMAL(15,2)
);

-- TABLE 14: CLINICAL TRIALS
CREATE TABLE ClinicalTrials (
    TrialID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    TrialName VARCHAR(200),
    DrugName VARCHAR(200),
    TrialPhase VARCHAR(50), 
    StartDate DATE,
    EstimatedEndDate DATE,
    NumberOfParticipants INT,
    TrialLocation VARCHAR(200),
    TrialStatus VARCHAR(50), 
    PrincipalInvestigator VARCHAR(200)
);

-- TABLE 15: ADVERSE EVENTS
CREATE TABLE AdverseEvents (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    CompanyID INT FOREIGN KEY REFERENCES Companies(CompanyID),
    ReportDate DATE,
    EventDescription TEXT,
    SeverityLevel VARCHAR(50), 
    PatientAge INT,
    PatientGender VARCHAR(10),
    OutcomeStatus VARCHAR(100), 
    ActionTaken VARCHAR(200)
);

GO

-- INSERT COMPANIES (100+ Companies)
INSERT INTO Companies (CompanyName, EstablishmentYear, HeadquarterCity, CompanyType, EmployeeCount, AnnualRevenueCrore, ExportCapability, WHOGMPCertified, ISOCertified, ContactEmail, ContactPhone, Website) VALUES
('Cadila Pharmaceuticals', 1952, 'Ahmedabad', 'Manufacturer', 8500, 5200.00, 1, 1, 1, 'info@cadilapharma.com', '+91-79-26858888', 'www.cadilapharma.com'),
('Zydus Lifesciences', 1995, 'Ahmedabad', 'Manufacturer', 25000, 18500.00, 1, 1, 1, 'contact@zyduslife.com', '+91-79-26858888', 'www.zyduslife.com'),
('Torrent Pharmaceuticals', 1959, 'Ahmedabad', 'Manufacturer', 12000, 8900.00, 1, 1, 1, 'info@torrentpharma.com', '+91-79-26898888', 'www.torrentpharma.com'),
('Intas Pharmaceuticals', 1977, 'Ahmedabad', 'Manufacturer', 15000, 10200.00, 1, 1, 1, 'contact@intaspharma.com', '+91-79-66766888', 'www.intaspharma.com'),
('Alembic Pharmaceuticals', 1907, 'Vadodara', 'Manufacturer', 9000, 6800.00, 1, 1, 1, 'info@alembic.com', '+91-265-2280550', 'www.alembic.com'),
('Sun Pharma Gujarat Unit', 2000, 'Vadodara', 'Manufacturer', 5500, 4200.00, 1, 1, 1, 'gujarat@sunpharma.com', '+91-265-6668888', 'www.sunpharma.com'),
('Dishman Carbogen Amcis', 1983, 'Ahmedabad', 'Manufacturer', 3500, 2800.00, 1, 1, 1, 'info@dishman.com', '+91-79-39871000', 'www.dishman.com'),
('Astron Research', 2002, 'Ahmedabad', 'Research', 450, 380.00, 1, 1, 1, 'research@astronltd.com', '+91-79-26858900', 'www.astronresearch.com'),
('Sarabhai Chemicals', 1947, 'Vadodara', 'Manufacturer', 1200, 950.00, 1, 1, 1, 'info@sarabhaichem.com', '+91-265-2334567', 'www.sarabhaichem.com'),
('Troikaa Pharmaceuticals', 1983, 'Ahmedabad', 'Manufacturer', 4200, 3100.00, 1, 1, 1, 'contact@troikaapharma.com', '+91-79-30012000', 'www.troikaapharma.com'),
('Amneal Pharmaceuticals Gujarat', 2003, 'Ahmedabad', 'Manufacturer', 2800, 2200.00, 1, 1, 1, 'gujarat@amneal.com', '+91-79-48946000', 'www.amneal.com'),
('Claris Lifesciences', 2001, 'Ahmedabad', 'Manufacturer', 3200, 2650.00, 1, 1, 1, 'info@clarislifesciences.com', '+91-79-66217100', 'www.clarislifesciences.com'),
('FDC Limited Gujarat', 1936, 'Ahmedabad', 'Manufacturer', 1800, 1400.00, 1, 1, 1, 'gujarat@fdcindia.com', '+91-79-26857000', 'www.fdcindia.com'),
('Ipca Laboratories Gujarat', 2005, 'Vadodara', 'Manufacturer', 2200, 1850.00, 1, 1, 1, 'gujarat@ipca.com', '+91-265-2281000', 'www.ipcalabs.com'),
('Aarti Drugs', 1984, 'Vadodara', 'Manufacturer', 1500, 1250.00, 1, 1, 1, 'info@aartidrugs.com', '+91-265-2281234', 'www.aartidrugs.com'),
('Megafine Pharma', 1997, 'Surat', 'Manufacturer', 950, 720.00, 1, 1, 1, 'contact@megafine.in', '+91-261-2463000', 'www.megafine.in'),
('Parabolic Drugs', 1985, 'Ahmedabad', 'Manufacturer', 850, 680.00, 1, 1, 1, 'info@parabolicdrugs.com', '+91-79-26851234', 'www.parabolicdrugs.com'),
('Savita Pharma', 1988, 'Rajkot', 'Manufacturer', 680, 540.00, 1, 1, 1, 'contact@savitapharma.com', '+91-281-2345678', 'www.savitapharma.com'),
('Sterling Biotech', 1993, 'Vapi', 'Manufacturer', 1200, 950.00, 1, 1, 1, 'info@sterlingbiotech.com', '+91-260-2401234', 'www.sterlingbiotech.com'),
('Vital Healthcare', 1995, 'Ahmedabad', 'Distributor', 320, 280.00, 0, 0, 1, 'contact@vitalhealthcare.in', '+91-79-26852345', 'www.vitalhealthcare.in'),
('Pharma Distributors Gujarat', 2001, 'Surat', 'Distributor', 450, 380.00, 0, 0, 1, 'info@pdgujarat.com', '+91-261-2464567', 'www.pdgujarat.com'),
('Marksans Pharma Gujarat', 2000, 'Vapi', 'Manufacturer', 1800, 1450.00, 1, 1, 1, 'gujarat@marksanspharma.com', '+91-260-2402000', 'www.marksanspharma.com'),
('Shilpa Medicare Gujarat', 2010, 'Ankleshwar', 'Manufacturer', 950, 750.00, 1, 1, 1, 'gujarat@shilpamedicare.com', '+91-2646-223456', 'www.shilpamedicare.com'),
('Venus Remedies Gujarat', 2008, 'Vadodara', 'Manufacturer', 680, 520.00, 1, 1, 1, 'gujarat@venusremedies.com', '+91-265-2282345', 'www.venusremedies.com'),
('Emcure Pharmaceuticals Gujarat', 2012, 'Ahmedabad', 'Manufacturer', 1200, 980.00, 1, 1, 1, 'gujarat@emcure.co.in', '+91-79-66213000', 'www.emcure.co.in'),
('Glenmark Pharmaceuticals Gujarat', 2015, 'Ankleshwar', 'Manufacturer', 2200, 1850.00, 1, 1, 1, 'gujarat@glenmarkpharma.com', '+91-2646-224567', 'www.glenmarkpharma.com'),
('Lupin Gujarat Unit', 2008, 'Vadodara', 'Manufacturer', 1500, 1250.00, 1, 1, 1, 'gujarat@lupin.com', '+91-265-2283456', 'www.lupin.com'),
('Dr. Reddys Gujarat Facility', 2010, 'Ahmedabad', 'Manufacturer', 1800, 1500.00, 1, 1, 1, 'gujarat@drreddys.com', '+91-79-66214000', 'www.drreddys.com'),
('Mankind Pharma Gujarat', 2018, 'Surat', 'Distributor', 580, 480.00, 0, 0, 1, 'gujarat@mankindpharma.com', '+91-261-2465678', 'www.mankindpharma.com'),
('Biocon Gujarat Operations', 2016, 'Ahmedabad', 'Manufacturer', 950, 820.00, 1, 1, 1, 'gujarat@biocon.com', '+91-79-66215000', 'www.biocon.com'),
('Natco Pharma Gujarat', 2014, 'Vadodara', 'Manufacturer', 780, 650.00, 1, 1, 1, 'gujarat@natcopharma.com', '+91-265-2284567', 'www.natcopharma.com'),
('Strides Pharma Gujarat', 2011, 'Ahmedabad', 'Manufacturer', 1100, 920.00, 1, 1, 1, 'gujarat@strides.com', '+91-79-66216000', 'www.strides.com'),
('Granules India Gujarat', 2013, 'Ankleshwar', 'Manufacturer', 850, 720.00, 1, 1, 1, 'gujarat@granulesindia.com', '+91-2646-225678', 'www.granulesindia.com'),
('Ajanta Pharma Gujarat', 2009, 'Vadodara', 'Manufacturer', 920, 780.00, 1, 1, 1, 'gujarat@ajantapharma.com', '+91-265-2285678', 'www.ajantapharma.com'),
('Aurobindo Pharma Gujarat', 2007, 'Ahmedabad', 'Manufacturer', 1650, 1380.00, 1, 1, 1, 'gujarat@aurobindo.com', '+91-79-66217000', 'www.aurobindo.com'),
('Jubilant Life Sciences Gujarat', 2012, 'Vapi', 'Manufacturer', 1250, 1050.00, 1, 1, 1, 'gujarat@jubl.com', '+91-260-2403456', 'www.jubl.com'),
('Hetero Drugs Gujarat', 2015, 'Ankleshwar', 'Manufacturer', 980, 820.00, 1, 1, 1, 'gujarat@heteroworld.com', '+91-2646-226789', 'www.heterodrugs.com'),
('Piramal Pharma Gujarat', 2005, 'Ahmedabad', 'Manufacturer', 1450, 1200.00, 1, 1, 1, 'gujarat@piramal.com', '+91-79-66218000', 'www.piramal.com'),
('Sanofi Gujarat Unit', 2000, 'Vadodara', 'Manufacturer', 1150, 950.00, 1, 1, 1, 'gujarat@sanofi.com', '+91-265-2286789', 'www.sanofi.in'),
('Abbott Gujarat Operations', 1998, 'Ahmedabad', 'Manufacturer', 1580, 1320.00, 1, 1, 1, 'gujarat@abbott.com', '+91-79-66219000', 'www.abbott.co.in'),
('Pfizer Gujarat Plant', 2002, 'Vadodara', 'Manufacturer', 1380, 1150.00, 1, 1, 1, 'gujarat@pfizer.com', '+91-265-2287890', 'www.pfizer.co.in'),
('Novartis Gujarat Facility', 2004, 'Ahmedabad', 'Manufacturer', 1250, 1050.00, 1, 1, 1, 'gujarat@novartis.com', '+91-79-66220000', 'www.novartis.in'),
('GSK Gujarat Unit', 1999, 'Vadodara', 'Manufacturer', 1480, 1250.00, 1, 1, 1, 'gujarat@gsk.com', '+91-265-2288901', 'www.gsk.in'),
('Cipla Gujarat Division', 2003, 'Ahmedabad', 'Manufacturer', 2100, 1750.00, 1, 1, 1, 'gujarat@cipla.com', '+91-79-66221000', 'www.cipla.com'),
('Ranbaxy Gujarat (Sun Pharma)', 2001, 'Vadodara', 'Manufacturer', 980, 820.00, 1, 1, 1, 'gujarat@ranbaxy.com', '+91-265-2289012', 'www.ranbaxy.com'),
('Wockhardt Gujarat Plant', 2006, 'Ankleshwar', 'Manufacturer', 1150, 950.00, 1, 1, 1, 'gujarat@wockhardt.com', '+91-2646-227890', 'www.wockhardt.com'),
('Divi''s Laboratories Gujarat', 2014, 'Vapi', 'Manufacturer', 880, 720.00, 1, 1, 1, 'gujarat@divislabs.com', '+91-260-2404567', 'www.divislabs.com'),
('Laurus Labs Gujarat', 2017, 'Ahmedabad', 'Manufacturer', 750, 620.00, 1, 1, 1, 'gujarat@lauruslabs.com', '+91-79-66222000', 'www.lauruslabs.com'),
('Syngene Gujarat Unit', 2019, 'Vadodara', 'Research', 420, 350.00, 1, 1, 1, 'gujarat@syngeneintl.com', '+91-265-2290123', 'www.syngeneintl.com'),
('Suven Pharma Gujarat', 2016, 'Ahmedabad', 'Manufacturer', 680, 560.00, 1, 1, 1, 'gujarat@suven.com', '+91-79-66223000', 'www.suven.com'),
('Sequent Scientific Gujarat', 2011, 'Vapi', 'Manufacturer', 920, 750.00, 1, 1, 1, 'gujarat@sequent.in', '+91-260-2405678', 'www.sequent.in'),
('Neuland Labs Gujarat', 2015, 'Ankleshwar', 'Manufacturer', 580, 480.00, 1, 1, 1, 'gujarat@neulandlabs.com', '+91-2646-228901', 'www.neulandlabs.com'),
('Hikal Gujarat Plant', 2008, 'Vadodara', 'Manufacturer', 780, 650.00, 1, 1, 1, 'gujarat@hikal.com', '+91-265-2291234', 'www.hikal.com'),
('Fermenta Biotech Gujarat', 2010, 'Ahmedabad', 'Manufacturer', 520, 430.00, 1, 1, 1, 'gujarat@fermentabiotech.com', '+91-79-66224000', 'www.fermentabiotech.com'),
('Nectar Lifesciences Gujarat', 2013, 'Vapi', 'Manufacturer', 680, 560.00, 1, 1, 1, 'gujarat@nectarlifesciences.com', '+91-260-2406789', 'www.nectarlifesciences.com'),
('Morepen Labs Gujarat', 2009, 'Vadodara', 'Manufacturer', 550, 450.00, 1, 1, 1, 'gujarat@morepen.com', '+91-265-2292345', 'www.morepen.com'),
('Ind-Swift Labs Gujarat', 2012, 'Ahmedabad', 'Manufacturer', 480, 390.00, 1, 1, 1, 'gujarat@indswiftlabs.com', '+91-79-66225000', 'www.indswiftlabs.com'),
('Solara Active Pharma Gujarat', 2018, 'Ankleshwar', 'Manufacturer', 620, 510.00, 1, 1, 1, 'gujarat@solara.co.in', '+91-2646-229012', 'www.solara.co.in'),
('SMS Pharmaceuticals Gujarat', 2014, 'Vapi', 'Manufacturer', 550, 450.00, 1, 1, 1, 'gujarat@smspharma.com', '+91-260-2407890', 'www.smspharma.com'),
('Supriya Lifescience Gujarat', 2016, 'Vadodara', 'Manufacturer', 420, 350.00, 1, 1, 1, 'gujarat@supriyalifescience.com', '+91-265-2293456', 'www.supriyalifescience.com'),
('Caplin Point Labs Gujarat', 2015, 'Ahmedabad', 'Manufacturer', 380, 310.00, 1, 1, 1, 'gujarat@caplinpoint.com', '+91-79-66226000', 'www.caplinpoint.com'),
('Ami Lifesciences', 2005, 'Vadodara', 'Manufacturer', 650, 520.00, 1, 1, 1, 'info@amilifesciences.com', '+91-265-2294567', 'www.amilifesciences.com'),
('Nirma Pharmaceutical', 2000, 'Ahmedabad', 'Manufacturer', 580, 470.00, 1, 1, 1, 'pharma@nirma.co.in', '+91-79-66227000', 'www.nirma.co.in'),
('Adani Pharma Chem', 2008, 'Mundra', 'Manufacturer', 480, 390.00, 1, 1, 1, 'contact@adanipharmachem.com', '+91-2838-256789', 'www.adanipharmachem.com'),
('Gujarat Terce Labs', 2003, 'Vadodara', 'Research', 220, 180.00, 0, 1, 1, 'info@gujarattercelabs.com', '+91-265-2295678', 'www.gujarattercelabs.com'),
('Veeda Clinical Research', 2005, 'Ahmedabad', 'Research', 380, 310.00, 1, 1, 1, 'contact@veedacr.com', '+91-79-66228000', 'www.veedacr.com'),
('Lambda Therapeutic Research', 2002, 'Ahmedabad', 'Research', 280, 230.00, 1, 1, 1, 'info@lambda-cro.com', '+91-79-26853456', 'www.lambda-cro.com'),
('Cliantha Research', 2001, 'Ahmedabad', 'Research', 320, 260.00, 1, 1, 1, 'contact@cliantha.com', '+91-79-40324000', 'www.cliantha.com'),
('Accutest Research Labs', 2008, 'Ahmedabad', 'Research', 180, 150.00, 0, 1, 1, 'info@accutest.com', '+91-79-26854567', 'www.accutest.com'),
('Synchron Research Services', 2004, 'Ahmedabad', 'Research', 240, 195.00, 1, 1, 1, 'contact@synchronrr.com', '+91-79-66229000', 'www.synchronrr.com'),
('Bioneeds India Clinical', 2010, 'Ahmedabad', 'Research', 150, 125.00, 0, 1, 1, 'info@bioneeds.in', '+91-79-26855678', 'www.bioneeds.in'),
('Cenduit Pharma Research', 2007, 'Vadodara', 'Research', 195, 160.00, 1, 1, 1, 'contact@cenduit.com', '+91-265-2296789', 'www.cenduit.com'),
('Siro Clinpharm', 1999, 'Ahmedabad', 'Research', 420, 340.00, 1, 1, 1, 'info@siroclinpharm.com', '+91-79-40328000', 'www.siroclinpharm.com'),
('Axis Clinicals', 2012, 'Ahmedabad', 'Research', 260, 210.00, 1, 1, 1, 'contact@axisclinicals.com', '+91-79-66230000', 'www.axisclinicals.com'),
('Bioanalytical Research Corporation', 2006, 'Ahmedabad', 'Research', 180, 145.00, 0, 1, 1, 'info@brcworld.com', '+91-79-26856789', 'www.brcworld.com'),
('Gujarat Enterprise Pharma', 2011, 'Rajkot', 'Manufacturer', 380, 310.00, 1, 1, 1, 'info@gepharma.com', '+91-281-2346789', 'www.gepharma.com'),
('Saurashtra Pharma', 2009, 'Rajkot', 'Manufacturer', 420, 340.00, 1, 1, 1, 'contact@saurashtrapharma.com', '+91-281-2347890', 'www.saurashtrapharma.com'),
('Bhavnagar Medicaments', 2005, 'Bhavnagar', 'Manufacturer', 320, 260.00, 1, 1, 1, 'info@bhavnagarmedi.com', '+91-278-2456789', 'www.bhavnagarmedi.com'),
('Jamnagar Pharmaceuticals', 2008, 'Jamnagar', 'Manufacturer', 280, 230.00, 1, 1, 1, 'contact@jamnagarpharm.com', '+91-288-2567890', 'www.jamnagarpharm.com'),
('Kutch Pharma Industries', 2013, 'Gandhidham', 'Manufacturer', 220, 180.00, 1, 1, 1, 'info@kutchpharma.com', '+91-2836-234567', 'www.kutchpharma.com'),
('Mehsana Drug Company', 2007, 'Mehsana', 'Manufacturer', 350, 280.00, 1, 1, 1, 'contact@mehsanadrug.com', '+91-2762-245678', 'www.mehsanadrug.com'),
('Patan Pharmaceuticals', 2010, 'Patan', 'Manufacturer', 280, 230.00, 1, 1, 1, 'info@patanpharma.com', '+91-2766-234567', 'www.patanpharma.com'),
('Sabarkantha Medicorp', 2012, 'Himatnagar', 'Manufacturer', 240, 195.00, 1, 1, 1, 'contact@sabarkanthamedi.com', '+91-2772-234567', 'www.sabarkanthamedi.com'),
('Banaskantha Biotech', 2014, 'Palanpur', 'Manufacturer', 195, 160.00, 1, 1, 1, 'info@banaskanthabio.com', '+91-2742-223456', 'www.banaskanthabio.com'),
('Navsari Pharma Labs', 2009, 'Navsari', 'Manufacturer', 280, 230.00, 1, 1, 1, 'contact@navsaripharma.com', '+91-2637-234567', 'www.navsaripharma.com'),
('Valsad Medichem', 2011, 'Valsad', 'Manufacturer', 320, 260.00, 1, 1, 1, 'info@valsadmedichem.com', '+91-2632-245678', 'www.valsadmedichem.com'),
('Bharuch Pharmaceuticals', 2008, 'Bharuch', 'Manufacturer', 420, 340.00, 1, 1, 1, 'contact@bharuchpharma.com', '+91-2642-234567', 'www.bharuchpharma.com'),
('Narmada Biotech', 2013, 'Rajpipla', 'Manufacturer', 180, 145.00, 1, 1, 1, 'info@narmadabiotech.com', '+91-2640-223456', 'www.narmadabiotech.com'),
('Dahod Drug Industries', 2015, 'Dahod', 'Manufacturer', 220, 180.00, 1, 1, 1, 'contact@dahoddrug.com', '+91-2673-234567', 'www.dahoddrug.com'),
('Panchmahals Pharma', 2010, 'Godhra', 'Manufacturer', 280, 230.00, 1, 1, 1, 'info@panchmahalspharma.com', '+91-2672-245678', 'www.panchmahalspharma.com'),
('Kheda Medicaments', 2011, 'Nadiad', 'Manufacturer', 350, 280.00, 1, 1, 1, 'contact@khedamedi.com', '+91-268-2567890', 'www.khedamedi.com'),
('Anand Pharma Corp', 2009, 'Anand', 'Manufacturer', 420, 340.00, 1, 1, 1, 'info@anandpharmacorp.com', '+91-2692-234567', 'www.anandpharmacorp.com'),
('Amreli Drugs Ltd', 2012, 'Amreli', 'Manufacturer', 260, 210.00, 1, 1, 1, 'contact@amrelidrugs.com', '+91-2792-234567', 'www.amrelidrugs.com'),
('Junagadh Medicorp', 2014, 'Junagadh', 'Manufacturer', 320, 260.00, 1, 1, 1, 'info@junagadhmedi.com', '+91-285-2678901', 'www.junagadhmedi.com'),
('Porbandar Pharma', 2010, 'Porbandar', 'Manufacturer', 220, 180.00, 1, 1, 1, 'contact@porbandarpharma.com', '+91-286-2234567', 'www.porbandarpharma.com'),
('Surendranagar Biotech', 2013, 'Surendranagar', 'Manufacturer', 280, 230.00, 1, 1, 1, 'info@surendranagarbio.com', '+91-2752-234567', 'www.surendranagarbio.com'),
('Morbi Drug Company', 2015, 'Morbi', 'Manufacturer', 240, 195.00, 1, 1, 1, 'contact@morbidrug.com', '+91-2822-234567', 'www.morbidrug.com'),
('Botad Pharmaceuticals', 2016, 'Botad', 'Manufacturer', 180, 145.00, 1, 1, 1, 'info@botadpharma.com', '+91-2849-234567', 'www.botadpharma.com'),
('Devbhoomi Pharma', 2017, 'Dwarka', 'Manufacturer', 195, 160.00, 1, 1, 1, 'contact@devbhoomipharma.com', '+91-2892-234567', 'www.devbhoomipharma.com');

GO

-- INSERT MANUFACTURING FACILITIES (Sample Data)
INSERT INTO ManufacturingFacilities (CompanyID, FacilityName, City, District, FacilityType, ProductionCapacityPerMonth, OperationalStatus, EstablishmentYear, Area_SqFt, NumberOfProductionLines) VALUES
(1, 'Cadila Tablets Unit 1', 'Ahmedabad', 'Ahmedabad', 'Tablets', 50000000, 'Active', 1995, 125000, 8),
(1, 'Cadila Injectables Unit', 'Ahmedabad', 'Ahmedabad', 'Injectables', 10000000, 'Active', 2005, 85000, 4),
(2, 'Zydus Formulation Unit', 'Ahmedabad', 'Ahmedabad', 'Tablets', 80000000, 'Active', 2000, 200000, 12),
(2, 'Zydus Biotech Plant', 'Ahmedabad', 'Ahmedabad', 'Biologics', 5000000, 'Active', 2010, 150000, 3),
(3, 'Torrent Capsules Facility', 'Ahmedabad', 'Ahmedabad', 'Capsules', 45000000, 'Active', 2008, 110000, 6),
(4, 'Intas Sterile Unit', 'Ahmedabad', 'Ahmedabad', 'Injectables', 15000000, 'Active', 2012, 95000, 5),
(5, 'Alembic API Manufacturing', 'Vadodara', 'Vadodara', 'API', 3000000, 'Active', 1990, 180000, 7),
(5, 'Alembic Oral Solids', 'Vadodara', 'Vadodara', 'Tablets', 60000000, 'Active', 2005, 145000, 10),
(6, 'Sun Pharma Vadodara Unit', 'Vadodara', 'Vadodara', 'Tablets', 40000000, 'Active', 2003, 98000, 7),
(7, 'Dishman CRAMS Facility', 'Ahmedabad', 'Ahmedabad', 'API', 2500000, 'Active', 1998, 120000, 4);

-- INSERT PRODUCTS (Sample Data)
INSERT INTO Products (CompanyID, ProductName, GenericName, TherapeuticCategory, DosageForm, Strength, PackSize, MRP, LaunchDate, IsPatented, PrescriptionRequired) VALUES
-- Cadila Products
(1, 'Lipaglyn', 'Saroglitazar', 'Cardiovascular', 'Tablet', '4mg', '30 Tablets', 450.00, '2013-06-01', 1, 1),
(1, 'Oxemia', 'Oxycodone', 'Analgesic', 'Tablet', '10mg', '10 Tablets', 180.00, '2018-03-15', 0, 1),
(1, 'Doxotel', 'Doxorubicin', 'Oncology', 'Injection', '50mg', '1 Vial', 2800.00, '2010-08-20', 0, 1),

-- Zydus Products
(2, 'Lipirex', 'Atorvastatin', 'Cardiovascular', 'Tablet', '10mg', '10 Tablets', 85.00, '2015-01-10', 0, 1),
(2, 'Glykind', 'Glimepiride', 'Antidiabetic', 'Tablet', '2mg', '15 Tablets', 95.00, '2016-05-12', 0, 1),
(2, 'Exemptia', 'Adalimumab', 'Immunology', 'Injection', '40mg', '1 Prefilled Syringe', 13500.00, '2014-09-22', 1, 1),

-- Torrent Products
(3, 'Aztor', 'Atorvastatin', 'Cardiovascular', 'Tablet', '20mg', '10 Tablets', 110.00, '2012-02-14', 0, 1),
(3, 'Rosulip', 'Rosuvastatin', 'Cardiovascular', 'Tablet', '10mg', '10 Tablets', 125.00, '2013-07-08', 0, 1),
(3, 'Pantocid', 'Pantoprazole', 'Gastrointestinal', 'Tablet', '40mg', '15 Tablets', 78.00, '2011-11-20', 0, 1),

-- Intas Products
(4, 'Imatinib', 'Imatinib', 'Oncology', 'Tablet', '400mg', '10 Tablets', 4200.00, '2016-03-25', 0, 1),
(4, 'Trastuzumab', 'Trastuzumab', 'Oncology', 'Injection', '440mg', '1 Vial', 52000.00, '2019-06-10', 0, 1),
(4, 'Albendazole', 'Albendazole', 'Antiparasitic', 'Tablet', '400mg', '1 Tablet', 12.00, '2008-04-15', 0, 0),

-- Alembic Products
(5, 'Azithromycin', 'Azithromycin', 'Antibiotic', 'Tablet', '500mg', '3 Tablets', 95.00, '2010-09-12', 0, 1),
(5, 'Ciprofloxacin', 'Ciprofloxacin', 'Antibiotic', 'Tablet', '500mg', '10 Tablets', 68.00, '2009-05-08', 0, 1),
(5, 'Metformin', 'Metformin', 'Antidiabetic', 'Tablet', '500mg', '20 Tablets', 42.00, '2007-02-20', 0, 1);


-- INSERT R&D PROJECTS (Sample Data)
INSERT INTO RnD (CompanyID, ProjectName, TherapeuticArea, StartDate, ExpectedCompletionDate, BudgetCrore, CurrentStage, NumberOfResearchers, CollaborationPartner) VALUES
(1, 'Novel Diabetes Drug', 'Endocrinology', '2023-01-15', '2026-12-31', 450.00, 'Phase II', 45, 'Johns Hopkins University'),
(2, 'Biosimilar Cancer Treatment', 'Oncology', '2022-06-01', '2025-11-30', 780.00, 'Phase III', 62, 'MD Anderson Cancer Center'),
(3, 'Cardiovascular Combination', 'Cardiology', '2024-03-10', '2027-06-30', 320.00, 'Phase I', 28, NULL),
(4, 'Orphan Drug Development', 'Rare Diseases', '2023-09-20', '2026-08-31', 520.00, 'Phase II', 38, 'NIH'),
(5, 'Antibiotic Resistance Study', 'Infectious Disease', '2024-01-05', '2027-12-31', 280.00, 'Preclinical', 25, 'CDC');


-- INSERT REGULATORY COMPLIANCE (Sample Data)
INSERT INTO RegulatoryCompliance (CompanyID, CertificationType, CertificationDate, ExpiryDate, IssuingAuthority, ComplianceStatus) VALUES
(1, 'WHO-GMP', '2020-03-15', '2025-03-14', 'World Health Organization', 'Active'),
(1, 'ISO 9001:2015', '2019-06-20', '2025-06-19', 'ISO', 'Active'),
(1, 'USFDA', '2021-01-10', '2026-01-09', 'US Food & Drug Administration', 'Active'),
(2, 'WHO-GMP', '2019-08-12', '2024-08-11', 'World Health Organization', 'Active'),
(2, 'ISO 14001:2015', '2020-02-28', '2025-02-27', 'ISO', 'Active'),
(2, 'UK MHRA', '2021-05-15', '2026-05-14', 'UK MHRA', 'Active'),
(3, 'WHO-GMP', '2020-11-20', '2025-11-19', 'World Health Organization', 'Active'),
(3, 'ISO 9001:2015', '2019-09-10', '2024-09-09', 'ISO', 'Expired'),
(4, 'WHO-GMP', '2021-04-05', '2026-04-04', 'World Health Organization', 'Active'),
(5, 'ISO 9001:2015', '2020-07-18', '2025-07-17', 'ISO', 'Active');


-- INSERT EXPORTS (Sample Data)
INSERT INTO Exports (CompanyID, ProductID, ExportDate, DestinationCountry, DestinationRegion, QuantityExported, ExportValueUSD, ShippingMode) VALUES
(1, 1, '2025-01-15', 'United States', 'Americas', 50000, 1250000, 'Air'),
(1, 2, '2025-01-20', 'United Kingdom', 'Europe', 30000, 650000, 'Sea'),
(2, 4, '2025-02-05', 'Germany', 'Europe', 45000, 980000, 'Air'),
(2, 5, '2025-02-10', 'Australia', 'Oceania', 25000, 520000, 'Sea'),
(3, 7, '2025-01-25', 'Canada', 'Americas', 40000, 850000, 'Air'),
(3, 8, '2025-02-15', 'France', 'Europe', 35000, 720000, 'Sea'),
(4, 10, '2025-03-01', 'Brazil', 'Americas', 20000, 1800000, 'Air'),
(4, 11, '2025-03-10', 'South Africa', 'Africa', 15000, 1500000, 'Sea'),
(5, 13, '2025-01-30', 'UAE', 'Asia', 60000, 380000, 'Air'),
(5, 14, '2025-02-20', 'Saudi Arabia', 'Asia', 55000, 420000, 'Sea');


-- INSERT QUALITY CONTROL (Sample Data)
INSERT INTO QualityControl (CompanyID, FacilityID, InspectionDate, InspectionType, InspectorName, OverallRating, DefectsFound, ComplianceScore, FollowUpRequired) VALUES
(1, 1, '2025-01-10', 'Routine', 'Dr. Rajesh Patel', 'Excellent', 0, 98.5, 0),
(1, 2, '2025-02-15', 'Surprise', 'Dr. Priya Shah', 'Good', 2, 87.3, 1),
(2, 3, '2025-01-20', 'Routine', 'Dr. Amit Desai', 'Excellent', 1, 95.8, 0),
(2, 4, '2025-03-05', 'Post-Complaint', 'Dr. Sneha Mehta', 'Satisfactory', 5, 72.4, 1),
(3, 5, '2025-02-01', 'Routine', 'Dr. Kiran Kumar', 'Excellent', 0, 96.2, 0),
(4, 6, '2025-01-25', 'Surprise', 'Dr. Neha Gupta', 'Good', 3, 84.7, 1),
(5, 7, '2025-02-10', 'Routine', 'Dr. Vivek Sharma', 'Excellent', 1, 93.5, 0),
(5, 8, '2025-03-01', 'Routine', 'Dr. Anjali Reddy', 'Good', 2, 88.9, 0);


-- INSERT SUPPLIERS (Sample Data)
INSERT INTO Suppliers (SupplierName, SupplierType, City, State, Country, ReliabilityRating, YearsInBusiness) VALUES
('Gujarat API Suppliers Ltd', 'API Supplier', 'Vadodara', 'Gujarat', 'India', 4.5, 15),
('PackMaster Industries', 'Packaging Material', 'Ahmedabad', 'Gujarat', 'India', 4.8, 22),
('BioEquip Solutions', 'Equipment', 'Mumbai', 'Maharashtra', 'India', 4.2, 18),
('ChemSource International', 'API Supplier', 'Shanghai', NULL, 'China', 4.6, 12),
('PharmaGrade Excipients', 'Excipients', 'Hyderabad', 'Telangana', 'India', 4.7, 20),
('GlobalPack Co', 'Packaging Material', 'Singapore', NULL, 'Singapore', 4.9, 25),
('TechPharma Equipment', 'Equipment', 'Ahmedabad', 'Gujarat', 'India', 4.4, 10),
('ActiveAPI Traders', 'API Supplier', 'Bangalore', 'Karnataka', 'India', 4.3, 14),
('QualityExcipients Inc', 'Excipients', 'New Jersey', NULL, 'USA', 4.8, 30),
('IndoPack Materials', 'Packaging Material', 'Vapi', 'Gujarat', 'India', 4.1, 8);


-- INSERT PROCUREMENT (Sample Data)
INSERT INTO Procurement (CompanyID, SupplierID, MaterialType, ProcurementDate, Quantity, UnitPrice, TotalCost, PaymentTerms) VALUES
(1, 1, 'API - Saroglitazar', '2025-01-05', 5000, 8500.00, 42500000, 'Net 60 days'),
(1, 2, 'Blister Packaging', '2025-01-10', 100000, 2.50, 250000, 'Net 30 days'),
(2, 4, 'API - Adalimumab', '2025-01-15', 1000, 125000.00, 125000000, 'Net 90 days'),
(2, 6, 'Pharmaceutical Bottles', '2025-01-20', 50000, 15.00, 750000, 'Net 45 days'),
(3, 1, 'API - Atorvastatin', '2025-02-01', 10000, 2800.00, 28000000, 'Net 60 days'),
(3, 2, 'Cartons', '2025-02-05', 25000, 8.00, 200000, 'Net 30 days'),
(4, 8, 'API - Imatinib', '2025-02-10', 2000, 45000.00, 90000000, 'Net 60 days'),
(5, 1, 'API - Azithromycin', '2025-02-15', 15000, 1200.00, 18000000, 'Net 45 days');

-- INSERT EMPLOYEES (Sample Data)
INSERT INTO Employees (CompanyID, EmployeeName, Department, Designation, JoiningDate, Salary, Experience, Qualification) VALUES
(1, 'Dr. Rajesh Kumar', 'R&D', 'Senior Research Scientist', '2015-03-15', 2500000, 15, 'PhD in Pharmaceutical Sciences'),
(1, 'Priya Patel', 'Production', 'Production Manager', '2018-06-20', 1800000, 10, 'M.Pharm'),
(1, 'Amit Shah', 'Quality Control', 'QC Manager', '2016-09-10', 2000000, 12, 'M.Sc in Chemistry'),
(2, 'Dr. Sneha Mehta', 'R&D', 'Director of Research', '2012-01-05', 4500000, 20, 'PhD in Biotechnology'),
(2, 'Kiran Desai', 'Sales', 'Regional Sales Manager', '2019-04-12', 1500000, 8, 'MBA'),
(3, 'Neha Gupta', 'Finance', 'Financial Controller', '2017-08-25', 2200000, 11, 'CA'),
(4, 'Vivek Sharma', 'Production', 'Plant Manager', '2014-11-30', 2800000, 14, 'B.Tech Chemical Engineering'),
(5, 'Anjali Reddy', 'HR', 'HR Head', '2020-02-15', 1600000, 7, 'MBA in HR');


-- INSERT FINANCIAL PERFORMANCE (Sample Data)
INSERT INTO FinancialPerformance (CompanyID, FinancialYear, Quarter, RevenueCrore, ProfitCrore, EBITDA_Crore, RnD_InvestmentCrore, MarketingExpenseCrore, NetProfitMargin) VALUES
-- 2024 Data
(1, 2024, 1, 1250.00, 175.00, 220.00, 45.00, 85.00, 14.0),
(1, 2024, 2, 1320.00, 190.00, 235.00, 48.00, 92.00, 14.4),
(1, 2024, 3, 1280.00, 180.00, 225.00, 46.00, 88.00, 14.1),
(1, 2024, 4, 1350.00, 195.00, 240.00, 50.00, 95.00, 14.4),
(2, 2024, 1, 4500.00, 680.00, 850.00, 180.00, 320.00, 15.1),
(2, 2024, 2, 4650.00, 710.00, 880.00, 185.00, 335.00, 15.3),
(2, 2024, 3, 4550.00, 690.00, 860.00, 182.00, 328.00, 15.2),
(2, 2024, 4, 4800.00, 740.00, 910.00, 195.00, 348.00, 15.4),
(3, 2024, 1, 2150.00, 295.00, 370.00, 72.00, 155.00, 13.7),
(3, 2024, 2, 2250.00, 315.00, 390.00, 75.00, 165.00, 14.0),
(3, 2024, 3, 2180.00, 305.00, 380.00, 73.00, 158.00, 14.0),
(3, 2024, 4, 2320.00, 330.00, 405.00, 78.00, 172.00, 14.2);


-- INSERT MARKET SHARE (Sample Data)
INSERT INTO MarketShare (CompanyID, TherapeuticSegment, Year, Quarter, MarketSharePercent, Rank, TotalMarketSizeCrore) VALUES
(1, 'Cardiovascular', 2024, 1, 8.5, 5, 25000),
(1, 'Cardiovascular', 2024, 2, 8.7, 5, 26000),
(2, 'Cardiovascular', 2024, 1, 15.2, 2, 25000),
(2, 'Cardiovascular', 2024, 2, 15.5, 2, 26000),
(3, 'Cardiovascular', 2024, 1, 12.3, 3, 25000),
(3, 'Cardiovascular', 2024, 2, 12.6, 3, 26000),
(4, 'Oncology', 2024, 1, 18.5, 1, 18000),
(4, 'Oncology', 2024, 2, 19.2, 1, 19000),
(5, 'Antibiotic', 2024, 1, 14.8, 2, 15000),
(5, 'Antibiotic', 2024, 2, 15.1, 2, 15500);


-- INSERT CLINICAL TRIALS (Sample Data)
INSERT INTO ClinicalTrials (CompanyID, TrialName, DrugName, TrialPhase, StartDate, EstimatedEndDate, NumberOfParticipants, TrialLocation, TrialStatus, PrincipalInvestigator) VALUES
(1, 'LIPAGLYN-DIABETES-2023', 'Saroglitazar', 'Phase III', '2023-03-01', '2025-12-31', 500, 'Multiple sites in Gujarat', 'Active', 'Dr. Ramesh Patel'),
(2, 'BIOSIMILAR-CANCER-2022', 'Adalimumab Biosimilar', 'Phase III', '2022-06-15', '2025-06-14', 800, 'Pan India', 'Active', 'Dr. Suresh Kumar'),
(3, 'CARDIO-COMBO-2024', 'CV Combination Drug', 'Phase I', '2024-01-10', '2025-12-31', 120, 'Ahmedabad', 'Recruiting', 'Dr. Priya Mehta'),
(4, 'ORPHAN-DRUG-2023', 'Rare Disease Treatment', 'Phase II', '2023-09-01', '2026-08-31', 200, 'Multi-center', 'Active', 'Dr. Amit Shah');


-- INSERT ADVERSE EVENTS (Sample Data)
INSERT INTO AdverseEvents (ProductID, CompanyID, ReportDate, EventDescription, SeverityLevel, PatientAge, PatientGender, OutcomeStatus, ActionTaken) VALUES
(1, 1, '2025-01-15', 'Mild gastrointestinal discomfort', 'Mild', 52, 'Male', 'Recovered', 'Symptomatic treatment advised'),
(4, 2, '2025-01-20', 'Injection site reaction', 'Mild', 48, 'Female', 'Recovered', 'Ice pack application recommended'),
(7, 3, '2025-02-05', 'Mild headache and dizziness', 'Mild', 61, 'Male', 'Recovered', 'Dose adjustment'),
(10, 4, '2025-02-10', 'Severe allergic reaction', 'Severe', 45, 'Female', 'Hospitalized', 'Emergency treatment, drug discontinued'),
(13, 5, '2025-02-15', 'Nausea and vomiting', 'Moderate', 38, 'Male', 'Recovered', 'Anti-emetic prescribed');

GO

