
SHELL := /bin/bash

TARGET := dark.bin

# ==================== WARNA ====================
RED    := \033[91m
GREEN  := \033[92m
BLUE   := \033[94m
RESET  := \033[0m

# ==================== DEPENDENSI ====================
REQUIRED_PACKAGES := requests phonenumbers rich

.PHONY: install check run help

# ==================== INSTALL ====================

install:
	@echo -e "$(BLUE)[+] Menginstall dependency...$(RESET)"
	@pip install --upgrade pip
	@pip install $(REQUIRED_PACKAGES)
	@echo -e "$(GREEN)[✓] Install selesai!$(RESET)"

# ==================== CHECK ====================

check:
	@echo -e "$(BLUE)[+] Mengecek dependency...$(RESET)"
	@for pkg in $(REQUIRED_PACKAGES); do \
		if python -c "import $$pkg" >/dev/null 2>&1; then \
			echo -e "$(GREEN)[✓] $$pkg$(RESET)"; \
		else \
			echo -e "$(RED)[✗] $$pkg belum terpasang$(RESET)"; \
		fi; \
	done

# ==================== RUN ====================

run: install check
	@clear
	@echo -e "$(BLUE)[+] Mengupdate repository...$(RESET)"
	@git pull --ff-only || true
	@echo -e "$(GREEN)[+] Menjalankan $(TARGET)...$(RESET)"
	@if [ ! -f "$(TARGET)" ]; then \
		echo -e "$(RED)[!] File $(TARGET) tidak ditemukan$(RESET)"; \
		exit 1; \
	fi
	@chmod +x $(TARGET)
	@./$(TARGET)

# ==================== HELP ====================

help:
	@echo "Perintah yang tersedia:"
	@echo "  make install  - Install dependency"
	@echo "  make check    - Cek dependency"
	@echo "  make run      - Git pull lalu jalankan dark.bin"