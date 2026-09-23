Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214ED2BDC2A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147199; cv=none; b=utK86pbLSRljx/mWd7AWoCA3olv+B2YkV0z7VLL9UTFPkpD0/oMt2Gfulhr3iPBw1CINOK0+JlXOmFkFY5fAV5nQWJMZdCI4NXV51OSovGEZOjxGTzNhe8O9WTM/2qk4SaEKY4M3doJlVJ9ppYMo7rBEZpHiWGjiLRWRIY50KuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147199; c=relaxed/simple;
	bh=IZcFXzKAcjAKi7rkJPkZAqcnKaAoBZJQUwd6ItCp7GQ=;
	h=Date:Content-Type:Cc:To:From:Mime-Version:Subject:Message-Id; b=Pk5v5EL7LwcfV7NDxzBpdtypyBuNzcmHa7Rt5lx1+SRsn8OLk1J2dqc3msMalXRS+GnCsJBjIHJ2ti5xfZ9KJ0LGV5sGQ8GtWVC3+r9CiE2kPpYBbseUafaalr7Mun3pUbzRsBvNOfYonmjR7zE4oRxgJmkLds4mlN4VX/5oU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=m2k8U9SD; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="m2k8U9SD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1790147189;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IozOCfZjbTL104g9rR2zsGuXkky764uBWGPbuf9IUio=;
 b=m2k8U9SD8LI7x/66sdsnXRezYqplwELqxk9wnOJpYWWPLwWitIcBFnh1gy8DepyT2d1WDj
 HWaA+GZ4aoEsz7wiMK7UqfM83uMxFeB7r97CWG8y7tGjQEWGhOZ4Enyk5/cBMLucih9R8t
 q5Bko8eLhLfF8i1ItLJPhT81du3rFL2FqW63Yz6vUosKX+jXjlJPqy2nabTgdG88M8vaZ8
 X4UmleQXY+1uQSZTOxN9xGhWSShDWKEyZvHEIr2+XMS97Iq9jVYmxORcE1+E97iuJt8pPr
 VUA4annBn+rJUUsMGr+kUyyKRsli70HuOQvQnYcS/6VowmhupcpjBWG+vofYiw==
Date: Wed, 23 Sep 2026 15:03:32 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <xb@ultrarisc.com>, <atish.patra@linux.dev>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<pbonzini@redhat.com>, <graf@amazon.com>, 
	<kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn with ESMTP; Wed, 23 Sep 2026 15:06:26 +0800
To: <anup@brainfault.org>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0
Subject: [PATCH] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operation
Message-Id: <20260923070332.1376132-1-xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+26ab37a73+0b75fb+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit

The TOPEI read-and-clear must be atomic with respect to
interrupt injection (set_bit in EIP). Otherwise an
interrupt injected between the topei read and the
clear_bit could be silently dropped.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 arch/riscv/kvm/aia_imsic.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index c1af23e79ae0..1a936b39076d 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -607,26 +607,25 @@ static void imsic_vsfile_cleanup(struct imsic *imsic)
 		kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
 }
 
-static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
+static void __imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
 {
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
 	struct imsic_mrif *mrif = imsic->swfile;
-	unsigned long flags;
-
-	/*
-	 * The critical section is necessary during external interrupt
-	 * updates to avoid the risk of losing interrupts due to potential
-	 * interruptions between reading topei and updating pending status.
-	 */
-
-	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
 
 	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
 	    imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
 		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
 	else
 		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
+}
+
+static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
+{
+	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	unsigned long flags;
 
+	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
+	__imsic_swfile_extirq_update(vcpu);
 	raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
 }
 
@@ -912,12 +911,21 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
 	struct imsic_mrif_eix *eix;
 	int r, rc = KVM_INSN_CONTINUE_NEXT_SEPC;
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	unsigned long flags;
 
 	/* If IMSIC vCPU state not initialized then forward to user space */
 	if (!imsic)
 		return KVM_INSN_EXIT_TO_USER_SPACE;
 
 	if (isel == KVM_RISCV_AIA_IMSIC_TOPEI) {
+		raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
+
 		/* Read pending and enabled interrupt with highest priority */
 		topei = imsic_mrif_topei(imsic->swfile, imsic->nr_eix,
 					 imsic->nr_msis);
@@ -934,16 +942,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
 					  eix->eip);
 			}
 		}
+		if (wr_mask)
+			__imsic_swfile_extirq_update(vcpu);
+
+		raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, eflags);
 	} else {
 		r = imsic_mrif_rmw(imsic->swfile, imsic->nr_eix, isel,
 				   val, new_val, wr_mask);
 		/* Forward unknown IMSIC register to user-space */
 		if (r)
 			rc = (r == -ENOENT) ? 0 : KVM_INSN_ILLEGAL_TRAP;
-	}
 
-	if (wr_mask)
-		imsic_swfile_extirq_update(vcpu);
+		if (wr_mask)
+			imsic_swfile_extirq_update(vcpu);
+	}
 
 	return rc;
 }
@@ -1050,9 +1062,17 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->vsfile_cpu >= 0) {
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
 	} else {
+		/*
+		 * Serialize the EIP set + external-irq update against the
+		 * TOPEI read-and-clear path so that an injected interrupt
+		 * cannot be silently lost when the guest acknowledges a
+		 * different (or the same) interrupt concurrently.
+		 */
+		raw_spin_lock(&imsic->swfile_extirq_lock);
 		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
 		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
-		imsic_swfile_extirq_update(vcpu);
+		__imsic_swfile_extirq_update(vcpu);
+		raw_spin_unlock(&imsic->swfile_extirq_lock);
 	}
 
 	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
-- 
2.53.0
