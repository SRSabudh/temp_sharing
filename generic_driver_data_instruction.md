# Assignment: K-Means Clustering for Driver Grouping

## Objective
Use K-Means clustering to group drivers based on their driving patterns, enabling the company to incentivize or charge drivers accordingly.

## Dataset
You are provided a dataset with 4,000 records (`generic-driver-data.csv`). Key fields include:
1. `id`: Unique driver ID
2. `mean_dist_day`: Average daily driving distance
3. `mean_over_speed_perc`: Average percentage of time over-speeding (>5 mph above the limit)

## Steps to Follow
1. **Data Exploration**:
   - Understand the structure and summary of the dataset.
   - Identify patterns or anomalies (if any).

2. **Clustering Model**:
   - Implement the K-Means clustering algorithm.
   - Decide the optimal number of clusters using methods like the elbow method or silhouette score.
   - Assign drivers to clusters based on the model.

3. **Analysis and Visualization**:
   - Visualize the clusters (e.g., scatter plot with clusters).
   - Describe the characteristics of each cluster (e.g., high average distance vs. low over-speed percentage).

4. **Business Recommendations**:
   - Based on the clusters, suggest strategies for recomend drivers to optimize customer satisfaction and vehical life.

## Deliverables
- Python notebook/script with the complete workflow.
- A short report summarizing cluster findings and business recommendations.
