Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C22F9D82;
	Thu,  2 Apr 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136212; cv=none; b=p2orhLMonMcVrz632BJv0S47pEB6D6JSYtCg0zMBAJtHJXK4iQe3cSuXpHcORtGpvhjKpRFcZaWWDphwbSC8pY5SNSrnoQpyy0W/KiLRJEj7O8CnCrcK8NtX6nL5RQXTqToCs9WHbP4+EUpD5musSDKV+XbdmEslbmuUBEkkVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136212; c=relaxed/simple;
	bh=/ZWpuqGhtwoErDC+r6pfGSg4YsOtPfcARXnTw8fWwrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KACeLBahXJEJR0AlDOaEt2bYn+8S6vJHC+RqytCjcPlyUhA7wlItKKPLzx0cVC7lAN8TkfYsxorin7fk3kORMuqV/igtzwPESlqQslK1hbg1JFsYsmSvKsLS5hhkZAb/5uAl3dWCq2lH4AEGdjl9IpjsmG3mtGkaXx06XPOOp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rNTwyPKE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rNTwyPKE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775136207; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7ELOJE3JZXFjIllqNR+stpZ1VHthBWOJOaGpIGYae10=;
	b=rNTwyPKEO2dCY5Ks6gPWCREB+37aEP7xc58pV3n0wuUff4V0sZ3TuDK2qGwjT2gj/j7Ja86oxelKPYLUopBnOFDi04Us1+a/IZ+FGCzFncOxsGLGpAzJzL/JfzfutG9yypUsefGyuKsXZRHoJBqbiIVu7O26qqw49fk3/kBAKjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0HNDEh_1775136205;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0HNDEh_1775136205 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 21:23:25 +0800
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
Subject: [PATCH v7 3/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes
Date: Thu,  2 Apr 2026 21:23:02 +0800
Message-Id: <20260402132303.6252-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com>
References: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Extend kvm_riscv_gstage_mode_detect() to record HGATP.MODE values in a
bitmask. Keep tracking the maximum supported G-stage page table level
for existing internal users.

Also provide lightweight helpers to retrieve the supported-mode bitmask
and validate a requested HGATP.MODE against it.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/kvm_gstage.h | 11 +++++++++++
 arch/riscv/kvm/gstage.c             | 15 ++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index 7c4c34bc191b..9204e6427d2d 100644
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
@@ -317,11 +319,17 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 
 void __init kvm_riscv_gstage_mode_detect(void)
 {
+	kvm_riscv_gstage_supported_mode_mask = 0;
+	kvm_riscv_gstage_max_pgd_levels = 0;
+
 #ifdef CONFIG_64BIT
 	/* Try Sv57x4 G-stage mode */
 	csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
 		kvm_riscv_gstage_max_pgd_levels = 5;
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV57X4) |
+							BIT(HGATP_MODE_SV48X4) |
+							BIT(HGATP_MODE_SV39X4);
 		goto done;
 	}
 
@@ -329,6 +337,8 @@ void __init kvm_riscv_gstage_mode_detect(void)
 	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
 		kvm_riscv_gstage_max_pgd_levels = 4;
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV48X4) |
+							BIT(HGATP_MODE_SV39X4);
 		goto done;
 	}
 
@@ -336,6 +346,7 @@ void __init kvm_riscv_gstage_mode_detect(void)
 	csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV39X4) {
 		kvm_riscv_gstage_max_pgd_levels = 3;
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV39X4);
 		goto done;
 	}
 #else /* CONFIG_32BIT */
@@ -343,13 +354,11 @@ void __init kvm_riscv_gstage_mode_detect(void)
 	csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV32X4) {
 		kvm_riscv_gstage_max_pgd_levels = 2;
+		kvm_riscv_gstage_supported_mode_mask |= BIT(HGATP_MODE_SV32X4);
 		goto done;
 	}
 #endif
 
-	/* KVM depends on !HGATP_MODE_OFF */
-	kvm_riscv_gstage_max_pgd_levels = 0;
-
 done:
 	csr_write(CSR_HGATP, 0);
 	kvm_riscv_local_hfence_gvma_all();
-- 
2.50.1

