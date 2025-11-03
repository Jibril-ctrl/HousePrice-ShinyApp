# 🏡 Interactive House Price Analytics using Shiny and Kaggle Data

### Author: **Jibril Anifowoshe**
**Cybersecurity & Data Science Professional**  
University of Missouri–St. Louis | INFSYS 6830 Project  
📅 *Developed: April 2024 | Updated: November 2025*  
🔗 [Live App on ShinyApps.io](https://jibrilanifowoshe.shinyapps.io/Jibril_Anifowoshe_ShinyApp/)

---

## 📘 Overview

This project is an **interactive R Shiny web application** designed to explore, visualize, and analyze **house price data** from Kaggle’s *“Advanced Regression Techniques”* dataset.  

The app provides users with an intuitive dashboard to generate visualizations, view statistical summaries, and gain insights into how different housing attributes influence pricing. It demonstrates applied skills in **data preprocessing**, **secure analytical workflows**, and **interactive deployment** — merging **cybersecurity discipline** with **data science exploration**.

---

## 🧠 Key Objectives

- Transform raw Kaggle datasets into structured, analysis-ready data using **Jupyter Notebook preprocessing**.  
- Build a fully interactive **R Shiny dashboard** supporting customizable visualization types.  
- Enable both technical and non-technical users to derive insights from structured data.  
- Demonstrate reproducibility and security-conscious data handling in academic and professional contexts.

---

## ⚙️ Technical Details

| Category | Description |
|-----------|--------------|
| **Framework** | R Shiny |
| **Language(s)** | R (data visualization), Python (data cleaning in Jupyter Notebook) |
| **Dataset Source** | Kaggle — *House Prices: Advanced Regression Techniques* |
| **Visualization Tools** | ggplot2, Plotly, dplyr, readr, GGally, shinythemes |
| **Security Focus** | Secure data provenance, reproducibility, automated dependency handling |
| **Deployment Platform** | [ShinyApps.io](https://www.shinyapps.io/) |
| **Original Date of Development** | April 8th, 2024 |

---

## 🚀 Features

- Interactive user interface for plot generation  
- Support for multiple plot types:
  - Histogram, Density Plot, Bar Plot, Scatter Plot, Box Plot
  - Line Chart, Area Chart, Heat Map, Frequency Polygon  
- Customizable axes and input options  
- Automatic package installation for missing dependencies  
- Dataset summary statistics with formatted output  
- Clean UI using `shinythemes`  

---

## 🔒 Data Integrity and Cybersecurity Lens

While this project focuses on analytics, it integrates **secure data science practices** throughout:
- **Controlled dataset provenance** via Kaggle source verification  
- **Sanitized preprocessing** in Jupyter Notebook prior to import  
- **Dynamic dependency management** in R for secure reproducibility  
- **Version-controlled deployment** ensuring full traceability  

These controls reflect the same principles applied in professional **cyber risk and data governance frameworks**.

---

## 🧰 Installation & Usage

### Requirements
You’ll need **R (≥ 4.0)** and the following packages:
`shiny`, `ggplot2`, `dplyr`, `readr`, `plotly`, `shinythemes`, `GGally`, `forcats`, `reshape2`

### Quick Start

```bash
# Clone this repository
git clone https://github.com/jibrilanifowoshe/HousePrice-ShinyApp.git
cd HousePrice-ShinyApp

# Run the R Shiny App
Rscript JA_ShinyAppProject_Final_Pub.R
```

The app will automatically open in your default browser. Missing packages will install automatically.

---

## 📂 Repository Structure

```
HousePrice-ShinyApp/
│
├── JA_ShinyAppProject_Final_Pub.R        # Final R Shiny app script
├── train.csv                             # Processed Kaggle dataset
├── JA_ShinyAPP_Dev_Report.pdf            # Full technical and academic report
├── data_prep.ipynb                       # (Optional) Jupyter preprocessing notebook
├── README.md                             # Documentation (this file)
├── LICENSE                               # MIT License
└── .gitignore                            # R and Jupyter ignore settings
```

---

## 📈 Future Enhancements

- Integration with **Machine Learning models** for predictive insights (Random Forest / Gradient Boosting).  
- Implementation of **secure API endpoints** for validated data input.  
- Improved UI using **ShinyDashboard** for enterprise visual presentation.  
- Dockerized deployment for containerized reproducibility.  

---

## 🧾 References

- Otto, M. & Fong, A. (2013). *House Prices – Advanced Regression Techniques.* Kaggle.  
- Wickham, H. (2024). *ggplot2: Elegant Graphics for Data Analysis.*  
- Plotly Technologies Inc. (2024). *Plotly R Open-Source Graphing Library.*  
- RStudio Community (2024). *RStudio Resources and Tutorials.*  

---

## 👤 Author

**Jibril Anifowoshe**  
[LinkedIn Profile](https://www.linkedin.com/in/jibril-anifowoshe)  

If you found this project insightful, please ⭐ the repository or share it with others in the data science community.

---

### 🏷 License
This project is licensed under the [MIT License](./LICENSE) — you are free to use, modify, and distribute with attribution.
