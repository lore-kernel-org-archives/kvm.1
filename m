Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521F37CD57;
	Mon, 30 Mar 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873597; cv=none; b=a6NEoNA8fPL3rmULtJj4TtfQ+9fLjzLlW1gp3daCKG9Gm+NiXtsQbVeq2SjNIznQkrryN8fvUprAR3Ow7MX+5085VCl8hZkujblWCQ1oKsDJmXyX9UGm3/AQw8IYDybn37X7sJ1Evtz/bdwWVrhkvCEiCn/cTa1CE5hmsqVg4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873597; c=relaxed/simple;
	bh=Xn/WZtZyMpPye9m8abp212wYw38KSOoY3nIsJV0J4GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JojDiDFyvSEUjGM8vaGRz8JghZGX+recLLM2FkCJcLQ22rEUJc5ULtPmUBLoB33ncZPJYNYCo8HqHS4efUyy91vgdvu2ZNgy/UjTJRNiTpa5NOLlCf5ZLqbkzt6AHrmrQnqMm0eAuRxyt55C4iTLw/iRmiKfjiz5z/jkmd8NQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jfzrhjxl; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jfzrhjxl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774873593; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PT+yx01BbG86omMromavfHwf6ELYE5YcV+gpW/gZMbk=;
	b=Jfzrhjxl6h90Y2n4R7N8OpzN2M8yrMIIEFmfAby5Ur791EvlDJZelFZZRY5VABVQsr83GXDbFhtWDQ4QyXOpKWWCtwzeGCu9krIVpBVas8Vg/LGzDv7erhOYZHPMW07zUfjdiNCZyFnpxYtiPxfZVXjhgsueBwpG2BtklrFWyc8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.zfcJ9_1774873591;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X.zfcJ9_1774873591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 20:26:32 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	skhan@linuxfoundation.org
Cc: guoren@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v6 3/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes
Date: Mon, 30 Mar 2026 20:26:00 +0800
Message-Id: <20260330122601.22140-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
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
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_gstage.h | 11 ++++++++
 arch/riscv/kvm/gstage.c             | 43 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 70d9d483365e..bbf8f45c6563 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -31,6 +31,7 @@ struct kvm_gstage_mapping {
 #endif
 
 extern unsigned long kvm_riscv_gstage_max_pgd_levels;
+extern u32 kvm_riscv_gstage_supported_mode_mask;
 
 #define kvm_riscv_gstage_pgd_xbits	2
 #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
@@ -102,4 +103,14 @@ static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *
 	gstage->pgd_levels = kvm->arch.pgd_levels;
 }
 
+static inline u32 kvm_riscv_get_hgatp_mode_mask(void)
+{
+	return kvm_riscv_gstage_supported_mode_mask;
+}
+
+static inline bool kvm_riscv_hgatp_mode_is_valid(unsigned long mode)
+{
+	return kvm_riscv_gstage_supported_mode_mask & BIT(mode);
+}
+
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 7c4c34bc191b..459041255c14 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -16,6 +16,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
 #else
 unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
 #endif
+/* Bitmask of supported HGATP.MODE encodings (BIT(HGATP_MODE_*)). */
+u32 kvm_riscv_gstage_supported_mode_mask __ro_after_init;
 
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
+	kvm_riscv_gstage_supported_mode_mask = 0;
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
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV39X4);
+		kvm_riscv_gstage_max_pgd_levels = 3;
 	}
 
 	/* Try Sv48x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV48X4)) {
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV48X4);
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
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV57X4);
+		kvm_riscv_gstage_max_pgd_levels = 5;
 	}
 #else /* CONFIG_32BIT */
 	/* Try Sv32x4 G-stage mode */
-	csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
-	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
+	if (kvm_riscv_hgatp_mode_supported(HGATP_MODE_SV32X4)) {
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV32X4);
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

