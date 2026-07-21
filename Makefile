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
	@pip install -q $(REQUIRED_PACKAGES)
	@echo -e "$(GREEN)[✓] Install selesai!$(RESET)"

# ==================== CHECK ====================

check:
	@echo -e "$(BLUE)[+] Mengecek dependency...$(RESET)"
	@for pkg in $(REQUIRED_PACKAGES); do \
		if python -c "import $$pkg" >/dev/null 2>&1; then \
			echo -e "$(GREEN)[✓] $$pkg$(RESET)"; \
		else \
			echo -e "$(RED)[✗] $$pkg belum terpasang, menginstall...$(RESET)"; \
			pip install -q $$pkg; \
		fi; \
	done

# ==================== RUN ====================

run: install check
	@clear
	@echo -e "$(BLUE)[+] Mengupdate repository...$(RESET)"
	@git stash push --include-untracked -m "auto-stash" >/dev/null 2>&1 || true
	@git pull --rebase --autostash || true
	@git stash pop >/dev/null 2>&1 || true
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
	@echo "  make run      - Update repository lalu jalankan dark.bin"