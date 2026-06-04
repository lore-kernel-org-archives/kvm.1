Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE247DD6F;
	Thu,  4 Jun 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579482; cv=none; b=H7VBuBvYKtC9nqo/yZKymvBkgIazv6PBftIaeuHF/pYeclFrRFeo3OwbSw5lrQhjfeup5q7Q4GbbdtIRjwjfIrh9Tch+zCSoZAKxat+jHN8G+RfoiqORiR7b4SwlRjk9mIknB5azVr7GnTSIjyGBk7RrJdbLXwMyZ4h59XaOH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579482; c=relaxed/simple;
	bh=u48pwSZNIjqAN1SfzirfvnQWMwy9RjHrinB0ySP9r6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gi9dLQRdfAYSIR6ZstyLU3I9iBdTOvx64rEITK5kPpz8Kj6NmtUuBIgyEJUylk8QnyTBQ+jN28OaFRYNkkypSElzrklCzH64PtrU6E7aDcbSQWsVeuNVwfugLr+la4i56IQWN2pwYH6wk/1BHN4PLWXIwT/P3MmEwD0B+YA3hdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cuLVNW+Y; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cuLVNW+Y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579475; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ty4UCAjaMaaFpW8tBxA2htrUnTdUo90caPb79emu5xY=;
	b=cuLVNW+YByY/txgJulUVZNv71Nmwnvq1nq4IIzu3DLNPa/gqQjH88JKn1Ro+LxmzlqxyX8MPSeU+LqvGJPcYdpNrsG2eUo+kKrvI5qq3CpiGmwrJG/kaPY21Ig6p0B2CrDYzrLt3E+z0vNYHgiENnsKG4m5Or1cXir/W35vvqTs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnZm_1780579472;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnZm_1780579472 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:33 +0800
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
Subject: [PATCH v3 7/9] riscv: kexec: Always build the trampoline page table
Date: Thu,  4 Jun 2026 21:24:16 +0800
Message-Id: <20260604132418.15725-8-fangyu.yu@linux.alibaba.com>
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

The trampoline page table and the kexec_tramp_satp value are
currently built only on the crash path. A follow-up patch needs
the same infrastructure for the normal kexec path.

Pull the trampoline build and the WRITE_ONCE() that publishes the
SATP value out of the crash-only else branch in
machine_kexec_prepare(). The crash path keeps recording its own
riscv_kexec_norelocate_pa; the normal path keeps its existing
control_code_buffer copy.

No functional change.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 72817bba5d3b..d82f45fb44b6 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -139,6 +139,16 @@ machine_kexec_prepare(struct kimage *image)
 		return -EINVAL;
 	}
 
+	/*
+	 * Build the trampoline page table and capture its SATP value.
+	 * The crash path consumes it today; the non-crash kexec path
+	 * will use the same setup as well.
+	 */
+	riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
+				__pa_symbol(__kexec_tramp_text_start));
+	WRITE_ONCE(kexec_tramp_satp,
+		   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
+
 	/* Copy the assembler code for relocation to the control page */
 	if (image->type != KEXEC_TYPE_CRASH) {
 		control_code_buffer = page_address(image->control_code_page);
@@ -155,19 +165,8 @@ machine_kexec_prepare(struct kimage *image)
 		/* Mark the control page executable */
 		set_memory_x((unsigned long) control_code_buffer, 1);
 	} else {
-		/*
-		 * Crash kexec uses riscv_kexec_norelocate as a trampoline.
-		 * Pre-build the trampoline page tables and capture the
-		 * trampoline SATP value plus the physical address of
-		 * riscv_kexec_norelocate so that the panic path only has
-		 * to switch satp and jump.
-		 */
-		riscv_kexec_build_tramp((unsigned long)__kexec_tramp_text_start,
-					__pa_symbol(__kexec_tramp_text_start));
 		WRITE_ONCE(riscv_kexec_norelocate_pa,
 			   __pa_symbol(&riscv_kexec_norelocate));
-		WRITE_ONCE(kexec_tramp_satp,
-			   PFN_DOWN(__pa_symbol(kexec_tramp_pgd)) | satp_mode);
 	}
 
 	return 0;
-- 
2.50.1

