-- Create the table with the records that have been identified as outliers
DROP TABLE IF EXISTS qc_outliers;
CREATE TABLE qc_outliers
(
job_number text, the_geom text, address text, address_house text, address_street text, latitude text, longitude text, ycoord text, xcoord text, bin text, bbl text, boro text, block text, lot text, dob_type text, dcp_dev_category text, dcp_occ_category text, dcp_occ_init text, dcp_occ_prop text, dob_occ_init text, dob_occ_prop text, dcp_status text, status_latest text, status_date text, status_a text, status_d text, status_p text, status_q text, status_r text, status_x text, dob_bldg_type text, far_prop text, stories_init text, stories_prop text, zoningarea_init text, zoningarea_prop text, u_init text, u_prop text, u_net text, u_net_complete text, u_net_incomplete text, c_date_earliest text, c_date_latest text, c_type_latest text, c_u_latest text, u_2007_existtotal text, u_2008_existtotal text, u_2009_existtotal text, u_2010pre_existtotal text, u_2010post_existtotal text, u_2011_existtotal text, u_2012_existtotal text, u_2013_existtotal text, u_2014_existtotal text, u_2015_existtotal text, u_2016_existtotal text, u_2017_existtotal text, u_2007_increm text, u_2008_increm text, u_2009_increm text, u_2010pre_increm text, u_2010post_increm text, u_2011_increm text, u_2012_increm text, u_2013_increm text, u_2014_increm text, u_2015_increm text, u_2016_increm text, u_2017_increm text, u_2007_netcomplete text, u_2008_netcomplete text, u_2009_netcomplete text, u_2010pre_netcomplete text, u_2010post_netcomplete text, u_2011_netcomplete text, u_2012_netcomplete text, u_2013_netcomplete text, u_2014_netcomplete text, u_2015_netcomplete text, u_2016_netcomplete text, u_2017_netcomplete text, geo_cd text, geo_ntacode text, geo_ntaname text, geo_censusblock text, geo_csd text, geo_subdistrict text, geo_pszone201718 text, geo_mszone201718 text, f_firms2007_100yr text, f_pfirms2015_100yr text, f_2050s_100yr text, f_2050s_hightide text, x_dup_flag text, x_dup_id text, x_geomsource text, x_occsource text, x_inactive text, x_outlier text, x_dup_maxstatusdate text, x_dup_maxcofodate text
);

COPY qc_outliers
FROM '/prod/db-housing/housing_build/output/qc_outliers.csv' DELIMITER ',' CSV HEADER;

-- Flag potential outliers in housing DB
UPDATE housing
SET x_outlier = TRUE
WHERE job_number IN
	(SELECT DISTINCT job_number
		FROM qc_outliers);

-- Remove the data table
DROP TABLE IF EXISTS qc_outliers;