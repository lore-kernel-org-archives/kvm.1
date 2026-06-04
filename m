Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4647DD47;
	Thu,  4 Jun 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579480; cv=none; b=E6RfTiza2lO4t3XbZddm8gcCO90S8ma2YWyR2Q8+Lzh+xcTpfiTOHgxBLEMy6BcU1IO2V9juRv/mRo2w5ZLyPcvFI7GMZEUYQfzlwcJPWs7NWoIUfGN5JpJJNVnVJ9hnHCJlQ4GIYfugjdoS1b7OvnRKiRKxpyqnNtgEqwmQvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579480; c=relaxed/simple;
	bh=1/68anwHwJcr/r4neQJTEVtQ22cYwpuKahuDCH+4RVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtHadFNkZrWPUcxUzxbeYcqiGXgob6RgUCHBBtYsV7HON4m4jUQZsW6kC6PzJxZBUSSFz/orAferoZSKaFEYQ4dN+IYLbMy6M6XgweLDxqeneQ0bRc114TlRYqB52SChF/bKls45eSvfBd4awT+QduLEDAfFkypqKm7k9nYDbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=au/XwxPd; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="au/XwxPd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579472; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vVBcY3pGKXN86VwrQOSMTZKS6zJWPeD7faRkNJrB9t8=;
	b=au/XwxPdWdKXzkgD6Eoi2HOous1L76Pe0ybtfl9cAn7YUiABPg9tBKErNBif1Kl3luCvDE5jq13gqyRibSp2UWH2EIYBIXZBe6XXFJP44SZs+jz//llmoERLGTTnWFdddCBsCdQTOwf9lsc8kLzyd1l2xNBJ5ILvLsTANNBnBU4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnYU_1780579469;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnYU_1780579469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:30 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 5/9] riscv: kexec: Build trampoline page tables for crash kernel entry
Date: Thu,  4 Jun 2026 21:24:14 +0800
Message-Id: <20260604132418.15725-6-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Crash kexec uses riscv_kexec_norelocate as a trampoline to jump into
the crashkernel. Pre-build dedicated 4 KB page tables in
machine_kexec_prepare() that map the trampoline page as executable,
so the panic path only has to switch satp and jump.

Two mappings are installed into a shared pgd:
  - VA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)
  - PA(__kexec_tramp_text_start) -> PA(__kexec_tramp_text_start)

The lower-level tables (p4d/pud/pmd/pte) are shared between both
mappings; map_tramp_page() walks the existing tree and only
populates entries that are still zero, so the two installs coexist
even when their indices happen to collide at any level.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index e6e179cffc44..1947b7bdf5c4 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,6 +18,85 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+/*
+ * Trampoline page tables. Both the VA(trampoline)->PA and the
+ * PA(trampoline)->PA identity mapping are installed in this single
+ * pgd; the lower-level tables are shared so the two mappings can
+ * coexist even if they happen to collide at any level (the walker
+ * only populates entries that are still zero).
+ *
+ * Pre-allocate for the largest paging mode (Sv57). Levels that the
+ * runtime mode does not use simply waste a page or two of BSS, in
+ * exchange for a builder that is infallible and safe to run from
+ * the panic path.
+ */
+static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
+#ifdef CONFIG_64BIT
+static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
+static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
+static pmd_t kexec_tramp_pmd[PTRS_PER_PMD] __aligned(PAGE_SIZE);
+#endif
+static pte_t kexec_tramp_pte[PTRS_PER_PTE] __aligned(PAGE_SIZE);
+
+static void map_tramp_page(unsigned long va, unsigned long pa)
+{
+	pgd_t *pgd = kexec_tramp_pgd + pgd_index(va);
+
+#ifdef CONFIG_64BIT
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (pgtable_l5_enabled) {
+		if (pgd_val(*pgd) == 0)
+			set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(kexec_tramp_p4d)),
+					     PAGE_TABLE));
+		p4d = kexec_tramp_p4d + p4d_index(va);
+	} else {
+		p4d = (p4d_t *)pgd;
+	}
+
+	if (pgtable_l4_enabled) {
+		if (p4d_val(*p4d) == 0)
+			set_p4d(p4d, pfn_p4d(PFN_DOWN(__pa_symbol(kexec_tramp_pud)),
+					     PAGE_TABLE));
+		pud = kexec_tramp_pud + pud_index(va);
+	} else {
+		pud = (pud_t *)p4d;
+	}
+
+	if (pud_val(*pud) == 0)
+		set_pud(pud, pfn_pud(PFN_DOWN(__pa_symbol(kexec_tramp_pmd)),
+				     PAGE_TABLE));
+	pmd = kexec_tramp_pmd + pmd_index(va);
+
+	if (pmd_val(*pmd) == 0)
+		set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa_symbol(kexec_tramp_pte)),
+				     PAGE_TABLE));
+#else
+	/* Sv32: PGD points directly to the PTE table. */
+	if (pgd_val(*pgd) == 0)
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(kexec_tramp_pte)),
+				     PAGE_TABLE));
+#endif
+
+	set_pte(kexec_tramp_pte + pte_index(va),
+		pfn_pte(PFN_DOWN(pa), PAGE_KERNEL_EXEC));
+}
+
+static void riscv_kexec_build_tramp(unsigned long va, unsigned long pa)
+{
+	/* VA -> PA: map the trampoline page via its kernel VA. */
+	map_tramp_page(va, pa);
+
+	/*
+	 * PA -> PA: identity-map the same page so the second-pass code
+	 * can keep executing after the kernel VA mapping is dropped.
+	 */
+	map_tramp_page(pa, pa);
+}
+
+
 /*
  * machine_kexec_prepare - Initialize kexec
  *
@@ -73,6 +152,14 @@ machine_kexec_prepare(struct kimage *image)
 
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
+	} else {
+		/*
+		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
+		 * Pre-build the trampoline page tables here so the panic
+		 * path only has to switch satp and jump.
+		 */
+		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
+					__pa_symbol(__kexec_tramp_text_start));
 	}
 
 	return 0;
-- 
2.50.1

