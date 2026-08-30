# ---- Base image: a small, official Python image ----
FROM python:3.12-slim

# ---- Set the working folder inside the container ----
WORKDIR /app

# ---- Copy only the requirements first (faster rebuilds) ----
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Copy the rest of the app code ----
COPY app/ .

# ---- Tell Docker which port the app listens on ----
EXPOSE 5000

# ---- Command that runs when the container starts ----
CMD ["python", "app.py"]
