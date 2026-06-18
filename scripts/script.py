# Imports
import kagglehub
import mysql.connector
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Step 1: Download latest version
path = kagglehub.dataset_download("jessemostipak/hotel-booking-demand")

print("Path to dataset files:", path)

# Step 2:  Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root1234",
    database="hotel_booking"
)

# Step 3: Load Data (sample 20k rows for speed)
query = "SELECT * FROM hotel_bookings LIMIT 20000;"
df = pd.read_sql(query, conn)

# Step 4: Quick Overview
print("Shape:", df.shape)
print(df.head())
print(df.info())
print(df.describe())

# Step 5: Missing Values
print("Missing values:\n", df.isnull().sum())

# Step 6: Key Metrics
print("Cancellation Rate (%):", df['is_canceled'].mean() * 100)
print("Average ADR by Hotel:\n", df.groupby('hotel')['adr'].mean())
print("Lead Time Summary:\n", df['lead_time'].describe())
print("Top 10 Countries:\n", df['country'].value_counts().head(10))

# Step 7: Visualizations
sns.histplot(df['adr'], bins=50)
plt.title("ADR Distribution")
plt.show()

sns.countplot(x='hotel', hue='is_canceled', data=df)
plt.title("Cancellations by Hotel Type")
plt.show()

sns.boxplot(x='hotel', y='adr', data=df)
plt.title("ADR by Hotel Type")
plt.show()

sns.barplot(x='arrival_date_month', y='is_canceled', data=df,
            estimator=lambda x: sum(x)/len(x))
plt.title("Cancellation % by Month")
plt.show()

sns.histplot(data=df, x='lead_time', hue='is_canceled', bins=50, multiple='stack')
plt.title("Lead Time Distribution by Cancellation")
plt.show()

sns.barplot(x='total_of_special_requests', y='is_canceled', data=df,
            estimator=lambda x: sum(x)/len(x))
plt.title("Cancellation % by Special Requests")
plt.show()

# Step 8: Data Cleaning
df['country'] = df['country'].fillna('Unknown')
df['agent'] = df['agent'].fillna(0).astype(int)
df['company'] = df['company'].fillna(0).astype(int)

# Optional: drop redundant columns
df = df.drop(columns=['reservation_status', 'reservation_status_date'])

# Step 9: Export Cleaned CSV
df.to_csv("hotel_bookings_clean.csv", index=False)
print("Cleaned dataset exported as hotel_bookings_clean.csv")

