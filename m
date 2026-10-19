Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65430567F
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417637; cv=none; b=SfYluJOHZelCNCIv6ZUiDYbG9cvlId1dgN4xXUbasWm1aBQ7BQlxpR5c/xBCXr0pLFFbifW0zZsN4pHGWtvIaLWW5y1enGnEGVOJ9/CYqk7Z9dkt42JpqPTih3txvCnWieP/RA2DSQKVAmruV907Td8/BYR9yI7QbhzPWPdbWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417637; c=relaxed/simple;
	bh=/qaWoZI/YGAqceCwDucx/imq3smJTVtLSwTEScGWq70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekSawYebtibGKZG+lQyz6jyq70OR1rveEOqAz4PNt5E47d9BK/AhzvHYnJF1k1NR+/uYi9OhrK7ujlikrDpUeZWxHGfwmJs8Ht1ts6Q7S15oPLLRx8p7zYxhIwjc6YldL6v6X3nVcHVGGMOSrzfAqsfFiMm0YkDl2H0qNXy1AYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lNb6ba9b; arc=none smtp.client-ip=91.218.175.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lNb6ba9b"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/qaWoZI/YGAqceCwDucx/imq3smJTVtLSwTEScGWq70=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792417633; v=1; x=1793022433;
 b=lNb6ba9bmT8idF2PNhbo07YN+szjH79RwQTeTMMaqL3Aj2Ll3UKNHunejiX4C4brXaTZBeki
 Gvnv47F6yXX7bZIEueY4UWUlJ8qtnK+lgH2MhKfSJLis6GxYnWi0hRcHttl8l8K8nDSqMNFXpKE
 rKiD1cj8s7F+KK9A1EJtDfP4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5640194636ea6c18;
	Mon, 19 Oct 2026 13:47:13 +0000
X-Mizu-Trace-ID: 5640194636ea6c18
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm-riscv@lists.infradead.org
Cc: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock
Date: Mon, 19 Oct 2026 15:47:09 +0200
Message-ID: <20261019134709.2610129-1-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_vcpu_aia_imsic_put() runs from the scheduler preemption
notifier with the raw runqueue lock held, so it must not take
vsfile_lock, an rwlock_t, which sleeps on PREEMPT_RT. All vsfile_lock
critical sections are short, so a raw spinlock is fine.

Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization")
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
v2:
 - Convert vsfile_lock to raw_spinlock_t instead of adding a separate
   hgei_lock [Anup]
---
 arch/riscv/kvm/aia_imsic.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index f17dc559a709..bad0ce20edc1 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -47,7 +47,7 @@ struct imsic {
 	 */
 
 	/* IMSIC VS-file */
-	rwlock_t vsfile_lock;
+	raw_spinlock_t vsfile_lock;
 	int vsfile_cpu;
 	int vsfile_hgei;
 	void __iomem *vsfile_va;
@@ -593,13 +593,13 @@ static void imsic_vsfile_cleanup(struct imsic *imsic)
 	 * VCPU is being destroyed.
 	 */
 
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
 	imsic->vsfile_cpu = imsic->vsfile_hgei = -1;
 	imsic->vsfile_va = NULL;
 	imsic->vsfile_pa = 0;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	memset(imsic->swfile, 0, sizeof(*imsic->swfile));
 
@@ -687,7 +687,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 	 * only check for interrupt when IMSIC VS-file is being used.
 	 */
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	if (imsic->vsfile_cpu > -1) {
 		/*
 		 * This function is typically called from kvm_vcpu_block() via
@@ -702,7 +702,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 		else
 			ret = !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfile_hgei));
 	}
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	return ret;
 }
@@ -727,10 +727,10 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vcpu)
 	if (!kvm_vcpu_is_blocking(vcpu))
 		return;
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	if (imsic->vsfile_cpu > -1)
 		csr_set(CSR_HGEIE, BIT(imsic->vsfile_hgei));
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 }
 
 void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
@@ -744,13 +744,13 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 		return;
 
 	/* Read and clear IMSIC VS-file details */
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
 	imsic->vsfile_cpu = imsic->vsfile_hgei = -1;
 	imsic->vsfile_va = NULL;
 	imsic->vsfile_pa = 0;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/* Do nothing, if no IMSIC VS-file to release */
 	if (old_vsfile_cpu < 0)
@@ -807,10 +807,10 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Read old IMSIC VS-file details */
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/* Do nothing if we are continuing on same CPU */
 	if (old_vsfile_cpu == vcpu->cpu)
@@ -860,12 +860,12 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 	/* TODO: Update the IOMMU mapping ??? */
 
 	/* Update new IMSIC VS-file details in IMSIC context */
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	imsic->vsfile_hgei = new_vsfile_hgei;
 	imsic->vsfile_cpu = vcpu->cpu;
 	imsic->vsfile_va = new_vsfile_va;
 	imsic->vsfile_pa = new_vsfile_pa;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/*
 	 * At this point, all interrupt producers have been moved
@@ -975,7 +975,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	}
 	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	rc = 0;
 	vsfile_hgei = imsic->vsfile_hgei;
@@ -990,7 +990,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 					    isel, val, 0, 0);
 	}
 
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	if (!rc && vsfile_cpu >= 0)
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
@@ -1052,7 +1052,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->nr_msis <= iid)
 		return -EINVAL;
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	if (imsic->vsfile_cpu >= 0) {
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
@@ -1062,7 +1062,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 		imsic_swfile_extirq_update(vcpu);
 	}
 
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	return 0;
 }
@@ -1118,7 +1118,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 
 	/* Setup IMSIC context  */
 	imsic->nr_msis = kvm->arch.aia.nr_ids + 1;
-	rwlock_init(&imsic->vsfile_lock);
+	raw_spin_lock_init(&imsic->vsfile_lock);
 	imsic->nr_eix = BITS_TO_U64(imsic->nr_msis);
 	imsic->nr_hw_eix = BITS_TO_U64(kvm_riscv_aia_max_ids);
 	imsic->vsfile_hgei = imsic->vsfile_cpu = -1;
-- 
2.56.0

