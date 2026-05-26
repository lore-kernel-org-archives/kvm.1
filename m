Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C737EFF3;
	Tue, 26 May 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799835; cv=none; b=K436f5WQg1SI1i2jkDnY3itfcJ9rja0avwi/Jy41F9tdBn9yW1bCHh2Q6ukVey3mN7HrFqdOzp3A0HHgB1CJOc+5tKcDTGiaGXIFrlD8NcsbeaREwYEAciB9u7vE7hOucQlpxbmuSUPOsZP4No0WPNpeW6VAzI72sygZgyXAClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799835; c=relaxed/simple;
	bh=VCUjDrsjVspkhuBEKcRPcCLnj7lk4umSF2Zo04XjNoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OVAHixQGMbna5hcnvz8ErGLu0iFxC8ut+mUOp7xUl3Ju0r/DOCEcO1R+rSVRFNVti5DAUdROZEMlGlghSuhL5TfOLrnKvFZ/22woIyaqw3qoQ9l5EA0MxQbBnsctLId41hbkBejpSLRel7DdkO7tTFdWC0wwkdp2dzOITC42wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WNWXyrAR; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WNWXyrAR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799824; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RmDJAqGKM/ksShAqBTWgLgvF5EBn9yG49TTpjD3uJ+Y=;
	b=WNWXyrARQsdBBg47jHy6N6xd+VIUzNOdSF8TFlE1pF7cc5Xq4+pF3bvnk97vnA7xjNYCZNyN2wWBfGClp9ls+6/qmnIvbNkS2Z/ZgYB+DXSXAmggeGOpKJRG2RT2K3Okzh214qiJMXRcO9VIJJZw1ic5gnbI/9Fc1XViVs5EZF8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNLy_1779799821;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNLy_1779799821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:22 +0800
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
Subject: [PATCH v2 5/7] riscv: kexec: Always build the trampoline page table
Date: Tue, 26 May 2026 20:50:07 +0800
Message-Id: <20260526125009.2404-6-fangyu.yu@linux.alibaba.com>
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
index 00fdc42d650d..556b76bcf96e 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -119,6 +119,16 @@ machine_kexec_prepare(struct kimage *image)
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
@@ -135,19 +145,8 @@ machine_kexec_prepare(struct kimage *image)
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

