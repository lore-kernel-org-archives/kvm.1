Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF825A655;
	Tue, 26 May 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799832; cv=none; b=rNxbqPBvCmguuwKU4pg7xdPzTDQHeCZotmR1PFT5wbZbgLmJYWphton229LKii2gyT9NeNFYsDMTAz7ieT5O2dxa1P/swns791MLdt/uq6dP/kusUO0njHgC7wvLF1srM7cZz16zpWS6RNy2p4TqKw7fSEsxIpbL/pB5auJmLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799832; c=relaxed/simple;
	bh=G3iEzS5T+XgFJEdLgTUJOHg963K1PioJf0ckKQFuV3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UU4UoNBTQyWq0VTKDXOiRMuKOOGffzdPaNpv+BJo8+1hwJyv1VwfKLqyqqxBOqOplNu7T9E6KxiqoN9jpxxFHJEINHqoxcXEp7Yi3YvYlrrmifxvpugxzyZzqrm6PWVzFVDTfCx6qTD97QnJC1AdnNM0wrY7ZGg+sc3CqcTQzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XkIhN/s3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XkIhN/s3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799822; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SuvbXy8tCKoaaEmxKOJd/JDFjbPQ2Ub/UQ4G8mPM/Dg=;
	b=XkIhN/s3V7zYQNb279RKMiC5TT6iKCuEA4EpsbF9dKI5QgXvk5ZwTVYR2kxRoI4ehEqIwE8pKlgawNvKPJB2vvHtvQhYHe1puK6D6pPdwU/pMWpUKDq6KGViqz9MTYhdVhrxn3vEFAlZvPMEQQENJbsyfNGM8RWBnJQjTJ9OP1k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNLM_1779799819;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNLM_1779799819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:20 +0800
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
Subject: [PATCH v2 4/7] riscv: kexec: Switch to trampoline page table before norelocate
Date: Tue, 26 May 2026 20:50:06 +0800
Message-Id: <20260526125009.2404-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Make riscv_kexec_norelocate a two-pass trampoline so it can
drop the kernel page tables while still executing from a
mapped address.

On the first entry, t3 is initialized to 0 by machine_kexec().
Loads the physical address of riscv_kexec_norelocate and the
trampoline SATP value, switches to the trampoline page table,
and jumps to the trampoline VA(=PA).

On the second entry, t3 contains the physical address of
riscv_kexec_norelocate, so the PC comparison matches and
execution continues under trampoline VA(=PA).

Since the trampoline page table is already active, replace the
previous stvec-based handoff with a direct jump to the target
entry (jr a2).

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/kexec_relocate.S | 32 ++++++++++++++++++----
 arch/riscv/kernel/machine_kexec.c  | 44 +++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index af6b99f5b0fd..2b9892bf04f2 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -147,13 +147,35 @@ riscv_kexec_relocate_end:
 
 
 /* Used for jumping to crashkernel */
+.extern kexec_tramp_satp
+.extern riscv_kexec_norelocate_pa
 .section ".kexec.tramp.text", "ax"
 SYM_CODE_START(riscv_kexec_norelocate)
+	/*
+	 * Two-pass entry:
+	 *   - 1st entry: t3 == 0 (initialized by machine_kexec()).
+	 *
+	 *   - 2nd entry: t3 holds the physical address of
+	 *     riscv_kexec_norelocate, so auipc matches t3 and we fall through
+	 *     to label 1 to continue execution under trampoline VA(=PA).
+	 */
+	auipc   t0, 0
+	beq     t0, t3, 1f
+
+	la      t0, riscv_kexec_norelocate_pa
+	REG_L   t3, 0(t0)
+	la      t0, kexec_tramp_satp
+	REG_L   t1, 0(t0)
+	csrw	CSR_SATP, t1
+	sfence.vma x0, x0
+
+	jr      t3
 	/*
 	 * s0: (const) Phys address to jump to
 	 * s1: (const) Phys address of the FDT image
 	 * s2: (const) The hartid of the current hart
 	 */
+1:
 	mv	s0, a1
 	mv	s1, a2
 	mv	s2, a3
@@ -199,13 +221,13 @@ SYM_CODE_START(riscv_kexec_norelocate)
 	csrw	CSR_SSCRATCH, zero
 
 	/*
-	 * Switch to physical addressing
-	 * This will also trigger a jump to CSR_STVEC
-	 * which in this case is the address of the new
-	 * kernel.
+	 * We are already executing from the trampoline VA with the trampoline
+	 * page table installed, so there is no need to rely on the old flow
+	 * of programming stvec and taking the implicit trap on SATP switch.
+	 * Jump directly to the target entry instead.
 	 */
-	csrw	CSR_STVEC, a2
 	csrw	CSR_SATP, zero
+	jr	a2
 
 SYM_CODE_END(riscv_kexec_norelocate)
 
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 9b4b495e7c15..00fdc42d650d 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,6 +18,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+unsigned long kexec_tramp_satp;
+unsigned long riscv_kexec_norelocate_pa;
 static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
 static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
 static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
@@ -135,11 +137,17 @@ machine_kexec_prepare(struct kimage *image)
 	} else {
 		/*
 		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
-		 * Pre-build the trampoline page tables here so the panic
-		 * path only has to switch satp and jump.
+		 * Pre-build the trampoline page tables and capture the
+		 * trampoline SATP value plus the physical address of
+		 * riscv_kexec_norelocate so that the panic path only has
+		 * to switch satp and jump.
 		 */
 		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
 					__pa_symbol(__kexec_tramp_text_start));
+		WRITE_ONCE(riscv_kexec_norelocate_pa,
+			   __pa_symbol(&riscv_kexec_norelocate));
+		WRITE_ONCE(kexec_tramp_satp,
+			   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
 	}
 
 	return 0;
@@ -243,7 +251,35 @@ machine_kexec(struct kimage *image)
 
 	/* Jump to the relocation code */
 	pr_notice("Bye...\n");
-	kexec_method(first_ind_entry, jump_addr, fdt_addr,
-		     this_hart_id, kernel_map.va_pa_offset);
+	/*
+	 * Hand off to the trampoline. For KEXEC_TYPE_CRASH we go into
+	 * riscv_kexec_norelocate, which uses t3 as the 1st/2nd-pass
+	 * discriminator (must be 0 on first entry). A bare
+	 *   asm volatile ("li t3, 0" ::: "t3")
+	 * before the C call only declares t3 *modified*; the compiler is
+	 * free to use t3 as scratch when materialising args. Pin t3 = 0
+	 * (and the args) via local register variables and perform the
+	 * indirect jump inside the same inline asm so t3 == 0 is
+	 * guaranteed at the moment control leaves machine_kexec().
+	 */
+	{
+		register unsigned long a0_val asm("a0") = first_ind_entry;
+		register unsigned long a1_val asm("a1") = jump_addr;
+		register unsigned long a2_val asm("a2") = fdt_addr;
+		register unsigned long a3_val asm("a3") = this_hart_id;
+		register unsigned long a4_val asm("a4") = kernel_map.va_pa_offset;
+		register unsigned long t3_zero asm("t3") = 0;
+		register riscv_kexec_method m asm("t6") = kexec_method;
+
+		asm volatile (
+			"jr %[m]"
+			:
+			: "r" (a0_val), "r" (a1_val), "r" (a2_val),
+			  "r" (a3_val), "r" (a4_val),
+			  "r" (t3_zero),
+			  [m] "r" (m)
+			: "memory"
+		);
+	}
 	unreachable();
 }
-- 
2.50.1

