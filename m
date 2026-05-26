Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE73F9F38;
	Tue, 26 May 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799840; cv=none; b=ORFSGeU6+HrDCz6icW92aW3YtSNl1pGw//TrYySUIgARdp+LTvlSWbDSwwZQr087RrETcb8R2AUd9Ql93gr/u/QzRVqYfid5gKPhjzyiHWmVa+r9E0nv2qVdz0EUgnokdKi5NnTXt6XTeVUeiLKwx4C0R9ci4kojzeHX8G/sAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799840; c=relaxed/simple;
	bh=6ApyXTA7g7W4J4BFFiv3aCiDu7w7MZ22v/2VG7XNi5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFcidP9ESXPPvpWC8wxv9usKWui3znqGd+75bYqcMP6a6OQlXy532gkd9eIfkt4whfo8w43Wgo1oR9YiqRkwa5KxjOcNaUSr2x00e+zgBngQ1JyeVQtJwrnG2hktoBBzvuUXGxX0onFC6gGeegt6F7Zw/uG6SGZhN+A8AZMqzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a5PUtPn8; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a5PUtPn8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799827; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CG77WpWSVnm3Eju7kwY3q1qRZqr7VASAGJnhObRcxEo=;
	b=a5PUtPn8EksWgzRsQ0O4kfVN6xO5Ah3UbDuYQvM6V5Mp78NomgjN20i9Cz1EYL1mcXZobIkV4t5xk6n/hzcT3ktOilOjBTAecxMC779P4J+WknReV8A+nT5kw8VmnlZVBGzdOr5zwXBd7NPeIf3wIbkS+70itg7nzJGPpz8l3O4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNMZ_1779799822;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNMZ_1779799822 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:23 +0800
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
Subject: [PATCH v2 6/7] riscv: kexec: Add the relocate-trampoline wrapper
Date: Tue, 26 May 2026 20:50:08 +0800
Message-Id: <20260526125009.2404-7-fangyu.yu@linux.alibaba.com>
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

Add riscv_kexec_relocate_entry to .kexec.tramp.text and the two
asm-visible globals (riscv_kexec_relocate_entry_pa and
riscv_kexec_cc_buffer_pa) that the wrapper consumes.

The wrapper performs the same two-step transition used by the crash
path: switch to the trampoline pgd, jump to the PA of self, then drop
the MMU with PC already on a PA. It finally jumps to the PA of
control_code_buffer.

machine_kexec_prepare() publishes the wrapper PA and the
control_code_buffer PA via WRITE_ONCE for non-crash images.
Nothing routes to the wrapper yet; the switchover happens in the
follow-up patch.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kexec.h     |  1 +
 arch/riscv/kernel/kexec_relocate.S | 37 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c  |  7 ++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 6466c1f00d41..b75cab959e53 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -53,6 +53,7 @@ typedef void (*riscv_kexec_method)(unsigned long first_ind_entry,
 				   unsigned long va_pa_off);
 
 extern riscv_kexec_method riscv_kexec_norelocate;
+extern riscv_kexec_method riscv_kexec_relocate_entry;
 
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops elf_kexec_ops;
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index 2b9892bf04f2..1baadad1b546 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -231,6 +231,43 @@ SYM_CODE_START(riscv_kexec_norelocate)
 
 SYM_CODE_END(riscv_kexec_norelocate)
 
+.extern riscv_kexec_relocate_entry_pa
+.extern riscv_kexec_cc_buffer_pa
+.section ".kexec.tramp.text", "ax"
+SYM_CODE_START(riscv_kexec_relocate_entry)
+	/*
+	 * Two-pass entry, identical in shape to riscv_kexec_norelocate:
+	 *   - 1st entry: t3 == 0 (initialized by machine_kexec()).
+	 *   - 2nd entry: t3 == PA of riscv_kexec_relocate_entry, so auipc
+	 *                matches t3 and we fall through to label 1.
+	 * Args a0..a4 are passed through unchanged to riscv_kexec_relocate.
+	 */
+	auipc	t0, 0
+	beq	t0, t3, 1f
+
+	la	t0, riscv_kexec_relocate_entry_pa
+	REG_L	t3, 0(t0)
+	la	t0, kexec_tramp_satp
+	REG_L	t1, 0(t0)
+	csrw	CSR_SATP, t1
+	sfence.vma x0, x0
+
+	jr	t3
+1:
+	/*
+	 * Now executing at the PA of this wrapper with the trampoline pgd
+	 * installed (identity-mapped). Drop the MMU; PC stays valid because
+	 * it is already a PA.
+	 */
+	csrw	CSR_SATP, zero
+	sfence.vma x0, x0
+
+	/* Jump to the PA of control_code_buffer to run the relocate body. */
+	la	t0, riscv_kexec_cc_buffer_pa
+	REG_L	t0, 0(t0)
+	jr	t0
+SYM_CODE_END(riscv_kexec_relocate_entry)
+
 .section ".rodata"
 SYM_DATA(riscv_kexec_relocate_size,
 	.long riscv_kexec_relocate_end - riscv_kexec_relocate)
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 556b76bcf96e..e3eb1e71920a 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -20,6 +20,8 @@
 
 unsigned long kexec_tramp_satp;
 unsigned long riscv_kexec_norelocate_pa;
+unsigned long riscv_kexec_relocate_entry_pa;
+unsigned long riscv_kexec_cc_buffer_pa;
 static pgd_t kexec_tramp_pgd[PTRS_PER_PGD] __aligned(PAGE_SIZE);
 static p4d_t kexec_tramp_p4d[PTRS_PER_P4D] __aligned(PAGE_SIZE);
 static pud_t kexec_tramp_pud[PTRS_PER_PUD] __aligned(PAGE_SIZE);
@@ -144,6 +146,11 @@ machine_kexec_prepare(struct kimage *image)
 
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
+
+		WRITE_ONCE(riscv_kexec_relocate_entry_pa,
+			   __pa_symbol(&riscv_kexec_relocate_entry));
+		WRITE_ONCE(riscv_kexec_cc_buffer_pa,
+			   __pa(control_code_buffer));
 	} else {
 		WRITE_ONCE(riscv_kexec_norelocate_pa,
 			   __pa_symbol(&riscv_kexec_norelocate));
-- 
2.50.1

