
SHELL := /bin/bash

TARGET := dark.bin
RED    := \033[91m
GREEN  := \033[92m
BLUE   := \033[94m
RESET  := \033[0m
REQUIRED_PACKAGES := requests phonenumbers rich

.PHONY: install check run

install:
        @echo -e "$(BLUE)[+] Install dependency...$(RESET)"
        @pip install --upgrade pip
        @pip install $(REQUIRED_PACKAGES)
        @echo -e "$(GREEN)[✓] Selesai!$(RESET)"
check:
        @echo -e "$(BLUE)[+] Mengecek dependency...$(RESET)"
        @for pkg in $(REQUIRED_PACKAGES); do \
                if python -c "import $$pkg" >/dev/null 2>&1; then \
                        echo -e "$(GREEN)[✓] $$pkg$(RESET)"; \
                else \
                        echo -e "$(RED)[✗] $$pkg belum terpasang$(RESET)"; \
                fi; \
        done



run: check
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