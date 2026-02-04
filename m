Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D515ECCC;
	Wed,  4 Feb 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212728; cv=none; b=eqXQP/dgy4QaxScKmrQCpVY//3Uyymas9iigmrikRKq0ruR6cm7naQwpRyCjQ/KDG9JjDPlTBHAS9rhqfMnt0TLrhmGTNJ5XOcg/8YTysTOueHVKB2EpkU+SZNp2IsQx7f1EFKK8tN758FCBtUtHx9b0RljIZy4bYue9pnetpqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212728; c=relaxed/simple;
	bh=87LIlEktxosYN3tpXjpSdcBf0foNHMP4J/TIDkS36u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDD/r1+UHeiI8uWax+SjzqzOvrJXlQAZYo9dNYGJJJiifb1z1HQ16gDCnV0pxjJ+2qDsOawiLPxB0LiLwnpbvlJfxhedVzPHICfvtDwBSau3j17mb8waGZCoCrjmGtiROTKfJQwtyvCJl61woFkUTE0vucq0IpGAOl8JkR57yWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SuvUr+FR; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SuvUr+FR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770212722; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yciz5NKAtbksgmsOTnGqD+95AQXuV0o1EGcHqIl5HB4=;
	b=SuvUr+FRZSFWmBPtdpd+I/J2gt1dSzIJmqebiF+u/YO0mHJYIL8x4YHdmwQWARtFKEz1W7V6SXpjQ/ANugJ3mvGI1U32XGI3JggIsXCQrBztvaQIJf6gm+jUfLg2xJC3d1PcxgRWQAds3V+3MgFiAkzmnwqxVDBXgtunhaLymj0=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyXBz9k_1770212719 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 21:45:20 +0800
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
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v5 2/3] RISC-V: KVM: Detect and expose supported HGATP G-stage modes
Date: Wed,  4 Feb 2026 21:45:06 +0800
Message-Id: <20260204134507.33912-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260204134507.33912-1-fangyu.yu@linux.alibaba.com>
References: <20260204134507.33912-1-fangyu.yu@linux.alibaba.com>
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
 arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
 arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index b12605fbca44..76c37b5dc02d 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -30,6 +30,7 @@ struct kvm_gstage_mapping {
 #endif
 
 extern unsigned long kvm_riscv_gstage_max_pgd_levels;
+extern u32 kvm_riscv_gstage_mode_mask;
 
 #define kvm_riscv_gstage_pgd_xbits	2
 #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
@@ -75,4 +76,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 
 void kvm_riscv_gstage_mode_detect(void);
 
+static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
+{
+	return kvm_riscv_gstage_mode_mask;
+}
+
+static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
+{
+	return kvm_riscv_gstage_mode_mask & BIT(mode);
+}
+
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 2d0045f502d1..328d4138f162 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
 #else
 unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
 #endif
+/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
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
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV39X4);
+		kvm_riscv_gstage_max_pgd_levels = 3;
 	}
 
 	/* Try Sv48x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV48X4);
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
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV57X4);
+		kvm_riscv_gstage_max_pgd_levels = 5;
 	}
 #else /* CONFIG_32BIT */
 	/* Try Sv32x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
+		kvm_riscv_gstage_mode_mask |= BIT(HGATP_MODE_SV32X4);
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

