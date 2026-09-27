Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BA3BFAF2
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495598; cv=none; b=bLB999QWY04aRclgVnjKGV6Wj7P8HYc0X1y0VJsCy3NurcMWCBlwYXxRQ8lx6gVrKLnvb5SvdzMLK/dvnVf6wYuj4nahpCeNzNBs/CPgxwPxt3AZx9kWHato4ixlgv3OiCP8Q7BAdRZcnQMQUYBJRSpkDX4prgZp1sm/QQZmxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495598; c=relaxed/simple;
	bh=SgGBdIl0sNzZTxbr7Q83ezBUwf/jOYde7rHdEiCx7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geZIepiaklNBZ5A69kTTWjenYS8RcFyftuw9VnSWqNmurAhg1sRCgc3AHXrkY8+NXSoCs4fuPzoWf1o6o1x+3SyTGKDMSXrhWaIBmy3qr1rrSJZUlIniyiYs4jhW5wLqHQCbtjQ7UkocV4FqCZJToFyE2HnhBPU8QrwXW9zEWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M+czcoV4; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M+czcoV4"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SgGBdIl0sNzZTxbr7Q83ezBUwf/jOYde7rHdEiCx7G0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790495590; v=1; x=1791100390;
 b=M+czcoV45QvU58In3xbUt0G2A0/rYWVIIHBZ7zMAFCEyBlRh1p0ex4Eae3kbsQrBWpTAPXVW
 2URom0xrUYGIu9YJpnStjH2rIND81XpvyTz84TrkFwdeqV5yHk+RCxzD56qKBxHff9/tGVvykcB
 z2OWZTew0vQFf2qiKff/oofU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 62deaf7238de186e;
	Sun, 27 Sep 2026 07:53:10 +0000
X-Mizu-Trace-ID: 62deaf7238de186e
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/6] LoongArch: KVM: Guard against NULL irqchip in irq injection
Date: Sun, 27 Sep 2026 15:52:36 +0800
Message-ID: <20260927075240.3007947-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927075240.3007947-1-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The irqfd injection path dispatches through the irq routing table
without the kvm_arch_irqchip_in_kernel() gate that protects
KVM_IRQ_LINE: kvm_set_pic_irq() and kvm_arch_set_irq_inatomic() call
pch_pic_set_irq(kvm->arch.pch_pic, ...) and pch_msi_set_irq() calls
eiointc_set_irq(kvm->arch.eiointc, ...) directly, so a routing entry
that outlives the corresponding in-kernel irqchip dereferences a NULL
(or, before the previous patch, a freed) device.

Make pch_pic_set_irq(), eiointc_set_irq() and dmsintc_set_irq()
tolerate a NULL device.

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 3 +++
 arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
 arch/loongarch/kvm/intc/pch_pic.c | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 63072595c01b..e27f448bb54f 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -70,6 +70,9 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data, int level)
 	unsigned int irq, cpu;
 	struct kvm_vcpu *vcpu;
 
+	if (!kvm->arch.dmsintc)
+		return -EINVAL;
+
 	irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
 	cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
 	if (cpu >= KVM_MAX_VCPUS)
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index fe0a1918f26f..c68f9033638a 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -112,8 +112,11 @@ static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
 void eiointc_set_irq(struct loongarch_eiointc *s, int irq, int level)
 {
 	unsigned long flags;
-	unsigned long *isr = (unsigned long *)s->isr;
+	unsigned long *isr;
 
+	if (!s)
+		return;
+	isr = (unsigned long *)s->isr;
 	spin_lock_irqsave(&s->lock, flags);
 	level ? __set_bit(irq, isr) : __clear_bit(irq, isr);
 	eiointc_update_irq(s, irq, level);
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 62c09b5f3937..88666425d800 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -48,6 +48,9 @@ void pch_pic_set_irq(struct loongarch_pch_pic *s, int irq, int level)
 {
 	u64 mask = BIT(irq);
 
+	if (!s)
+		return;
+
 	spin_lock(&s->lock);
 	if (level)
 		s->irr |= mask; /* set irr */
-- 
2.43.0

