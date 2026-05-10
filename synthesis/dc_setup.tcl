# ==========================================
# Design Compiler Setup
# ==========================================

set_app_var search_path [list \
    ../rtl/common \
    ../rtl/core \
    ../rtl/pipeline \
    ../rtl/l1_cache \
    ../rtl/l2_cache \
    ../rtl/coherency \
    ../rtl/interconnect \
    ../rtl/axi \
    ../rtl/prefetch \
    ../rtl/memory \
    ../rtl/top \
]

# ==========================================
# Target Libraries
# ==========================================

set_app_var target_library "typical.db"

set_app_var link_library "* typical.db"

# ==========================================
# HDL Variables
# ==========================================

set hdlin_auto_save_templates true

# ==========================================
# Top Design
# ==========================================

set TOP gpu_cache_system_top