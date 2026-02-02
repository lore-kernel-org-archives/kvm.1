Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715A36BCEC;
	Mon,  2 Feb 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041260; cv=none; b=s2P0ELhcLebIAutzpk7w0wyLVp/XjOb0DMM0F8yrLaz/egczoOYwLoPY6PJRa/MEaXP8RxH2cM6dC/BRaeA1HCjfzzPjcH3WL0xQodRtqkFvYWRd4q4nL6a1jgKmYYU/ftUqmDICS5v/lF3Ov3DjJUoex+LVm3Mh/lGauiTXAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041260; c=relaxed/simple;
	bh=XmYkQ7WfGEbpX/FN8hJ5LnmjTLonS4st0vQTVylpd3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVxw++eRQNA1GXroUkHxRZlCm8FQ6CYj6wL+ngMxIBwMR1tRQxmqp2QPwy25J5w9/8L04MnypkkbRCm6Ftts5+mxHAlmhjDSd+Sf7B3IA426kdCAANKkJtVurYJYpZSou4nMG0IWJcUX5yYY1FEwz3OYPkHxYjM9R4EhQuj+o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uUpwPozC; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uUpwPozC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770041256; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PAERw8ES7Sz4+PGBE81cd9YgH/6t6yHMKmA8nztW3dg=;
	b=uUpwPozCR1jOQd+gGwJSeOw7f4dqKNOvZZMh8z4lZ9a5+mjz1K6Psq93YeTQUxaYwf2/3KpBkARj+OdNcZsPfeFflLsSNzWV9/xGXGh/SfNN27t3vCEa+vE0VHf5LQggjXpxHQyE9qnyldqJjQb+tvCQ+nR2J39rHydRFGFTFIc=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyO62Vn_1770041252 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 22:07:34 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: guoren@kernel.org,
	ajones@ventanamicro.com,
	rkrcmar@ventanamicro.com,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v4 2/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes
Date: Mon,  2 Feb 2026 22:07:14 +0800
Message-Id: <20260202140716.34323-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260202140716.34323-1-fangyu.yu@linux.alibaba.com>
References: <20260202140716.34323-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
supported by the host and record them in a bitmask. Keep tracking the
maximum supported G-stage page table level for existing internal users.

Also provide lightweight helpers to retrieve the supported-mode bitmask
and validate a requested HGATP.MODE against it.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kvm_gstage.h | 37 +++++++++++++++++++++++++++
 arch/riscv/kvm/gstage.c             | 39 ++++++++++++++++-------------
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index b12605fbca44..c0c5a8b99056 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -30,6 +30,7 @@ struct kvm_gstage_mapping {
 #endif
 
 extern unsigned long kvm_riscv_gstage_max_pgd_levels;
+extern u32 kvm_riscv_gstage_mode_mask;
 
 #define kvm_riscv_gstage_pgd_xbits	2
 #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
@@ -75,4 +76,40 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 
 void kvm_riscv_gstage_mode_detect(void);
 
+enum kvm_riscv_hgatp_mode_bit {
+	HGATP_MODE_SV39X4_BIT = 0,
+	HGATP_MODE_SV48X4_BIT = 1,
+	HGATP_MODE_SV57X4_BIT = 2,
+};
+
+static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
+{
+	return kvm_riscv_gstage_mode_mask;
+}
+
+static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
+{
+#ifdef CONFIG_64BIT
+	u32 bit;
+
+	switch (mode) {
+	case HGATP_MODE_SV39X4:
+		bit = HGATP_MODE_SV39X4_BIT;
+		break;
+	case HGATP_MODE_SV48X4:
+		bit = HGATP_MODE_SV48X4_BIT;
+		break;
+	case HGATP_MODE_SV57X4:
+		bit = HGATP_MODE_SV57X4_BIT;
+		break;
+	default:
+		return false;
+	}
+
+	return kvm_riscv_gstage_mode_mask & BIT(bit);
+#else
+	return false;
+#endif
+}
+
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 2d0045f502d1..edbabdac57d8 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
 #else
 unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
 #endif
+/* Bitmask of supported HGATP.MODE (see HGATP_MODE_*_BIT). */
+u32 kvm_riscv_gstage_mode_mask __ro_after_init;
 
 #define gstage_pte_leaf(__ptep)	\
 	(pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
@@ -315,42 +317,43 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 	}
 }
 
+static bool __init kvm_riscv_hgatp_mode_supported(unsigned long mode)
+{
+	csr_write(CSR_HGATP, mode << HGATP_MODE_SHIFT);
+	return ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == mode);
+}
+
 void __init kvm_riscv_gstage_mode_detect(void)
 {
+	kvm_riscv_gstage_mode_mask = 0;
+	kvm_riscv_gstage_max_pgd_levels = 0;
+
 #ifdef CONFIG_64BIT
-	/* Try Sv57x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
-		kvm_riscv_gstage_max_pgd_levels = 5;
-		goto done;
+	/* Try Sv39x4 G-stage mode */
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV39X4)) {
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV39X4_BIT);
+		kvm_riscv_gstage_max_pgd_levels = 3;
 	}
 
 	/* Try Sv48x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV48X4_BIT);
 		kvm_riscv_gstage_max_pgd_levels = 4;
-		goto done;
 	}
 
-	/* Try Sv39x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV39X4) {
-		kvm_riscv_gstage_max_pgd_levels = 3;
-		goto done;
+	/* Try Sv57x4 G-stage mode */
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV57X4)) {
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV57X4_BIT);
+		kvm_riscv_gstage_max_pgd_levels = 5;
 	}
 #else /* CONFIG_32BIT */
 	/* Try Sv32x4 G-stage mode */
 	csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
 		kvm_riscv_gstage_max_pgd_levels = 2;
-		goto done;
 	}
 #endif
 
-	/* KVM depends on !HGATP_MODE_OFF */
-	kvm_riscv_gstage_max_pgd_levels = 0;
-
-done:
 	csr_write(CSR_HGATP, 0);
 	kvm_riscv_local_hfence_gvma_all();
 }
-- 
2.50.1

