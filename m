Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262314;
	b=FTiQxptmjCjAKUFs0qSM3bPVHU1ykcCRWLgnhrbDs+rswMk3WrhmmkhzM6TQt7CyfO7A
	 qFGwN/X3aNLQ1B+8ErAqtXum0hfJvh874FuHEfFieAfz3Relnh2FRlkAQf8Owdo32wD3t
	 zypg+2beaOTjPW0LjVHkGZ/StODPiwN4uIiL/KGkell9ri/IP87MjNNh0nOAR0GnTuIAo
	 xozR6WvEQQKcvFKJdMtHSB1t8h7BVwXMuJYKl92k7W3KuqVuTUmTlxNsw+SktJ14Hb6OI
	 ohOeG1fx9zi7p5rWVTuGE0I1vjpotcFZBPlvAOpHW71yXEatJ2nTwQHDAaz0EkQ5Hig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262314;
	h=DMARC-Filter:DKIM-Signature:X-Lms-Return-Path:To:Cc:From:Subject:
	 X-Mailer:Content-Transfer-Encoding:Message-Id:Received:Date:
	 Mime-Version:X-Original-From:Content-Type;
	bh=sDSw+quj48/Sv4K0BAesVEV8uBVWYkpg2NZQSvi+LvE=;
	b=OghAR0toCPmILCueNOPrL/wBuDPPlthCXSjM+/iyf2S1gmUf+Y/WNh3mPOr65fo9yqZS
	 cNaAO9bSBTkdCn2oIze+wsT5teL+K5QZTjevdgB1/f3DhRuGUqtdsjhViMOMHKpTYOMDt
	 P1reBo65s2EoOCfl5w/LCUVlZteWT+W+plK7MyB4YWr3BdweaBgSB48sCmB/4y0hNlmnL
	 w9QvLi2IM0+ouv14yXAoDTbbJzZGxOEOqvyFOqmH+p7muDKA7XKf5OGZYSGYwUJRBFUhZ
	 ZJ1MqZwONazK7J+W0t5StR0nNLflVa3hwm4pApZOmoT0+M/o+dKw8QnH2rciOt0YCHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=cjj1Rrte;
	arc=none smtp.remote-ip=209.127.231.35
Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E9606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 08:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=cjj1Rrte
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1793262307;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sDSw+quj48/Sv4K0BAesVEV8uBVWYkpg2NZQSvi+LvE=;
 b=cjj1Rrteu7g9BBTuYp+/eEn96lTrJ4mIGH9s18T8Vc8vbQoj/Jjy1ln+epszOtNLHROjFR
 jFjAUtLmNrs2KiPpu2RrZ1WAtEQ0TTcq/1REmqOl+n87ZkDg+987O3nsH2/lHt40mMEPUw
 O4GZn8j6UuudfhgMyOHKjGbeoJ5dkqbw+c+4mreN231rtmygpHtb+G67Cviv4mnbhshHgC
 Hjk7JXPrMkqWuEEDWccoiK8HOZtlHaLBO0p9Wm2pkOCvnlQdxukOiejfua5SmNujPe+SwQ
 fXn/jiT0gCO59wFnR+lqpzZAiNmSzD3zSbjo+pEul1qhGk5Ybp6UnNJ88n0F7w==
X-Lms-Return-Path: <lba+26ae302e1+11ff5d+vger.kernel.org+xiangwencheng@lanxincomputing.com>
To: <anup@brainfault.org>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Subject: [PATCH v2] riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029082426.706302-1-xiangwencheng@lanxincomputing.com>
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn with ESMTP; Thu, 29 Oct 2026 16:25:04 +0800
Date: Thu, 29 Oct 2026 16:24:26 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8

Replace linear searches over all vCPUs in MSI injection paths with a
hart_index -> vCPU xarray lookup table. This avoids O(n) scans on
every injected interrupt and improves performance when the number of
vCPUs is large.

Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
now use the table instead of iterating over the vCPU list.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
Changes in v2:
- Use xarray instead of normal array to handle incontiguous hart_index.
- Link to v1:
  https://lore.kernel.org/kvm-riscv/20260730093614.983508-1-xiangwencheng@lanxincomputing.com/
---
 arch/riscv/include/asm/kvm_aia.h |  3 ++
 arch/riscv/kvm/aia_device.c      | 50 +++++++++++++++++---------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index ab03f853e507..3b075f18e1d6 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -12,6 +12,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/kvm_types.h>
+#include <linux/xarray.h>
 #include <asm/csr.h>
 
 struct kvm_aia {
@@ -47,6 +48,8 @@ struct kvm_aia {
 
 	/* Internal state of APLIC */
 	void		*aplic_state;
+
+	struct xarray hart_to_vcpu;
 };
 
 struct kvm_vcpu_aia_csr {
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index efc7c0bcfba9..a415a8c10967 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -259,6 +259,8 @@ static int aia_init(struct kvm *kvm)
 	if (ret)
 		return ret;
 
+	xa_init(&aia->hart_to_vcpu);
+
 	/* Iterate over each VCPU */
 	kvm_for_each_vcpu(idx, vcpu, kvm) {
 		vaia = &vcpu->arch.aia_context;
@@ -280,6 +282,11 @@ static int aia_init(struct kvm *kvm)
 		/* Update HART index of the IMSIC based on IMSIC base */
 		vaia->hart_index = aia_imsic_hart_index(aia,
 							vaia->imsic_addr);
+		
+		ret = xa_insert(&aia->hart_to_vcpu, vaia->hart_index, vcpu, GFP_KERNEL);
+		if (ret) { 
+			goto fail_cleanup_imsics;
+		}
 
 		/* Initialize IMSIC for this VCPU */
 		ret = kvm_riscv_vcpu_aia_imsic_init(vcpu);
@@ -299,6 +306,7 @@ static int aia_init(struct kvm *kvm)
 			continue;
 		kvm_riscv_vcpu_aia_imsic_cleanup(vcpu);
 	}
+	xa_destroy(&aia->hart_to_vcpu);
 	kvm_riscv_aia_aplic_cleanup(kvm);
 	return ret;
 }
@@ -557,30 +565,25 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
 int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
 				   u32 guest_index, u32 iid)
 {
-	unsigned long idx;
 	struct kvm_vcpu *vcpu;
+	struct kvm_aia *aia = &kvm->arch.aia;
 
 	/* Proceed only if AIA was initialized successfully */
 	if (!kvm_riscv_aia_initialized(kvm))
 		return -EBUSY;
 
-	/* Inject MSI to matching VCPU */
-	kvm_for_each_vcpu(idx, vcpu, kvm) {
-		if (vcpu->arch.aia_context.hart_index == hart_index)
-			return kvm_riscv_vcpu_aia_imsic_inject(vcpu,
-							       guest_index,
-							       0, iid);
-	}
-
-	return 0;
+	vcpu = xa_load(&aia->hart_to_vcpu, hart_index);
+	if (!vcpu)
+		return 0;
+	
+	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_index, 0, iid);
 }
 
 int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 {
 	gpa_t tppn, ippn;
-	unsigned long idx;
 	struct kvm_vcpu *vcpu;
-	u32 g, toff, iid = msi->data;
+	u32 g, toff, iid = msi->data, hart_index;
 	struct kvm_aia *aia = &kvm->arch.aia;
 	gpa_t target = (((gpa_t)msi->address_hi) << 32) | msi->address_lo;
 
@@ -595,18 +598,16 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 	g = tppn & (BIT(aia->nr_guest_bits) - 1);
 	tppn &= ~((gpa_t)(BIT(aia->nr_guest_bits) - 1));
 
-	/* Inject MSI to matching VCPU */
-	kvm_for_each_vcpu(idx, vcpu, kvm) {
-		ippn = vcpu->arch.aia_context.imsic_addr >>
-					IMSIC_MMIO_PAGE_SHIFT;
-		if (ippn == tppn) {
-			toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
-			return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
-							       toff, iid);
-		}
-	}
+	hart_index = aia_imsic_hart_index(aia, target);
+	vcpu = xa_load(&aia->hart_to_vcpu, hart_index);
+	if (!vcpu)
+		return 0;
 
-	return 0;
+	ippn = vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SHIFT;
+	if (ippn != tppn)
+		return 0;
+	toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
+	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,	toff, iid);
 }
 
 int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool level)
@@ -647,9 +648,12 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
 
 void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
 {
+	struct kvm_aia *aia = &kvm->arch.aia;
 	/* Proceed only if AIA was initialized successfully */
 	if (!kvm_riscv_aia_initialized(kvm))
 		return;
+	
+	xa_destroy(&aia->hart_to_vcpu);
 
 	/* Cleanup APLIC context */
 	kvm_riscv_aia_aplic_cleanup(kvm);
-- 
2.53.0
