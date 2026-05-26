Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C325A655;
	Tue, 26 May 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799838; cv=none; b=eIhHyd6u3TBFZpEGquPicBmmhAwuxFW/N53zbWi2+3eNa+4bBG7Af7YHh6b7VCgJwM9hhUyoXdRzJmR07EkV8qnOY6PQTg6+c0peWfONACHfn9joU2sw5qYEjJi6T2o/ufXydSAuZF7BNUsS6w23NPMNOz3T6FUj3Yryys4LveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799838; c=relaxed/simple;
	bh=BjtBSBWyy5bnHkYzlCFqD9QFWKPcMRF5SKsAmW9n+2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/Ejdhiz3fkndQpyd+VYkiHJwps28eNpIdgEYwraYe2NFjzAvhzPctr8mYXY/ZBhe1yR0KyZsMDcqF9tuOHXE5t1PDpC0WTs4PGFid97sajH7Uwj/Tb4kZAyJYI7shI+GsaOOK+G98NWrUmWTCn2DOJHH17OjViywmSviN1f2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CdQ86Ywa; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CdQ86Ywa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799828; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4O/AJryMQ9T9OTSkYrEaZ42+vviQ81VgiXQiB0NE6IU=;
	b=CdQ86YwaSU+AotWxqnMqwTnqmpcZMyt1F2tBSf3Aat5CrageH/xgGUajE36dn5Aih3AezrZpOJh92QKmTaElZTQda29i+u2Wyo9YdrpJsypQWpVTfWSP3CrU2YZmtYmXOXSW7t29NtKq/CQ+XOmk/CdDAPco3KjAiqXhtWuV0nA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNMu_1779799824;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNMu_1779799824 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:25 +0800
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
Subject: [PATCH v2 7/7] riscv: kexec: Route normal kexec through the trampoline page table
Date: Tue, 26 May 2026 20:50:09 +0800
Message-Id: <20260526125009.2404-8-fangyu.yu@linux.alibaba.com>
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

riscv_kexec_relocate (copied into control_code_buffer) uses an stvec
trick to drop the MMU and land on the PA of the next loop label.
Under VS-mode KVM cannot emulate this single-step transition and the
VCPU dies with "kvm run failed Operation not supported".

Route normal kexec through riscv_kexec_relocate_entry, the trampoline
wrapper added in the previous patch. It drops SATP with PC already on
a PA, then hands off to control_code_buffer where the relocate body
runs with SATP=0.

Drop the stvec trick from the relocate body and pass first_ind_entry
as a physical address since the body now starts with SATP=0. The
".align 2" plus filler "nop" that ensured the PA of the loop top was
4-byte aligned -- required because the legacy stvec trick wrote that
PA into stvec.BASE, whose low two bits are MODE and are discarded by
the hardware -- is no longer load-bearing and is removed as well.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/kexec_relocate.S | 26 ++++++--------------------
 arch/riscv/kernel/machine_kexec.c  | 10 +++++++---
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 1baadad1b546..29392f457f42 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -34,27 +34,13 @@ SYM_CODE_START(riscv_kexec_relocate)
 	csrw	CSR_SIP, zero
 
 	/*
-	 * When we switch SATP.MODE to "Bare" we'll only
-	 * play with physical addresses. However the first time
-	 * we try to jump somewhere, the offset on the jump
-	 * will be relative to pc which will still be on VA. To
-	 * deal with this we set stvec to the physical address at
-	 * the start of the loop below so that we jump there in
-	 * any case.
+	 * The trampoline wrapper (riscv_kexec_relocate_entry) has already
+	 * dropped the MMU and handed control to us at this PA copy of the
+	 * relocate code. From here on the entire loop runs with SATP=0 and
+	 * every address (s0, s5, source/dest pointers) is a physical one.
 	 */
-	la	s6, 1f
-	sub	s6, s6, s4
-	csrw	CSR_STVEC, s6
-
-	/*
-	 * With C-extension, here we get 42 Bytes and the next
-	 * .align directive would pad zeros here up to 44 Bytes.
-	 * So manually put a nop here to avoid zeros padding.
-	*/
-	nop
 
 	/* Process entries in a loop */
-.align 2
 1:
 	REG_L	t0, 0(s0)		/* t0 = *image->entry */
 	addi	s0, s0, RISCV_SZPTR	/* image->entry++ */
@@ -70,8 +56,8 @@ SYM_CODE_START(riscv_kexec_relocate)
 	andi	t1, t0, 0x2
 	beqz	t1, 2f
 	andi	s0, t0, ~0x2
-	csrw	CSR_SATP, zero
-	jr	s6
+	/* MMU is already off; the entry wrapper handled the transition. */
+	j	1b
 
 2:
 	/* IND_DONE entry ? -> jump to done label */
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index e3eb1e71920a..99cc251f971c 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -231,11 +231,15 @@ machine_kexec(struct kimage *image)
 {
 	struct kimage_arch *internal = &image->arch;
 	unsigned long jump_addr = (unsigned long) image->start;
-	unsigned long first_ind_entry = (unsigned long) &image->head;
+	/*
+	 * The relocate body runs entirely with the MMU off (the wrapper
+	 * drops SATP before jumping into control_code_buffer), so the very
+	 * first entry must be a physical address.
+	 */
+	unsigned long first_ind_entry = __pa(&image->head);
 	unsigned long this_cpu_id = __smp_processor_id();
 	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
 	unsigned long fdt_addr = internal->fdt_addr;
-	void *control_code_buffer = page_address(image->control_code_page);
 	riscv_kexec_method kexec_method = NULL;
 
 #ifdef CONFIG_SMP
@@ -244,7 +248,7 @@ machine_kexec(struct kimage *image)
 #endif
 
 	if (image->type != KEXEC_TYPE_CRASH)
-		kexec_method = control_code_buffer;
+		kexec_method = (riscv_kexec_method) &riscv_kexec_relocate_entry;
 	else
 		kexec_method = (riscv_kexec_method) &riscv_kexec_norelocate;
 
-- 
2.50.1

