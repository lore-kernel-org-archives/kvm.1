Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC303F8231
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404202; cv=none; b=oVDRyGbbY/XJGzPlefViVdLF8dExE/j8HM6iMba4jIX94krpDB3NAeOLuPBjwDBrB4Rnt0iuR5WbysQ9V6WGnotlbdl9ffTgL5xZaQonbNzJMHphqFF1cgJBINOfFowJtQer2jXHBcVfW7OdlDPZYZdKpPD+j5+YQN3KNFCJC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404202; c=relaxed/simple;
	bh=rNJPPRAN+amlJi4CXJrTCcu6eQBmqpiXF/hqI95xo90=;
	h=To:Message-Id:Mime-Version:From:Subject:Cc:Date:Content-Type; b=QBeDZvANuK9NNUIMFNP+wBrhuBPrxCWaHAy23wQTAe3LN33XWOeUyU/p6oEkaNcJdJMJjcCbU9Wx12iaQSeBNMrjuLstzUCizF+0BS6CjgOUOWDAutJSeY2NcwJbkrdvLLClmmAkVGzlya2oaX3HdFWUl0SMQACjuVYRJsjkrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=XfP99j6I; arc=none smtp.client-ip=209.127.231.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="XfP99j6I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1785404187;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bN7RFHsa0lOlR0S7CzP3PJMMnicWDiS8G1yRtLup2oQ=;
 b=XfP99j6IYupWVtM58ve71L1Oecbs6/gteir5Z119TgLunremC/3oauWTNKnlHVEtKlQF+f
 a4RdhIGG22NFu5oWz3sN2WLPdhTHLdCflZGznIwA92ChxhmeXrPSOgdM+NvsdZlUwLNlDB
 YU/19ajL3bX4VlYGf0mLQZ6fmhA2R6XoiHPKLgaMbqxEtItf5TGm4AGcvNf0qXpu/T50Qv
 rBRf460uLu2tKJAts33mhdddOzv2Krbm+/rUVbtdSnpiBIrL92pLQTMQGCZQ1TXljUyVhp
 ea7Z1Pm33cvbH4uOnPK9tMzuy5RGikYGug9+DPIiA7LvKkPiXWGv6OVlRQjwcQ==
X-Mailer: git-send-email 2.53.0
To: <anup@brainfault.org>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Message-Id: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn with ESMTP; Thu, 30 Jul 2026 17:36:25 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Subject: [PATCH] riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection
X-Lms-Return-Path: <lba+26a6b1b19+7e589f+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jul 2026 17:36:14 +0800
Content-Type: text/plain; charset=UTF-8

Replace linear searches over all vCPUs in MSI injection paths with a
direct hart_index -> vCPU lookup table. This avoids O(n) scans on
every injected interrupt and improves performance when the number of
vCPUs is large.

Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
now use the table instead of iterating over the vCPU list.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 arch/riscv/include/asm/kvm_aia.h |  2 +
 arch/riscv/kvm/aia_device.c      | 67 +++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index c67ec5ac0..71240b0a2 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -47,6 +47,8 @@ struct kvm_aia {
 
 	/* Internal state of APLIC */
 	void		*aplic_state;
+
+	struct kvm_vcpu **hart_to_vcpu;
 };
 
 struct kvm_vcpu_aia_csr {
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index be83c2d5f..595553817 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -253,6 +253,14 @@ static int aia_init(struct kvm *kvm)
 	if (ret)
 		return ret;
 
+	aia->hart_to_vcpu = kcalloc(kvm->created_vcpus,
+					sizeof(struct kvm_vcpu*),
+					GFP_KERNEL);
+	if (!aia->hart_to_vcpu) {
+		ret = -ENOMEM;
+		goto fail_cleanup_aplic;
+	}
+
 	/* Iterate over each VCPU */
 	kvm_for_each_vcpu(idx, vcpu, kvm) {
 		vaia = &vcpu->arch.aia_context;
@@ -274,6 +282,12 @@ static int aia_init(struct kvm *kvm)
 		/* Update HART index of the IMSIC based on IMSIC base */
 		vaia->hart_index = aia_imsic_hart_index(aia,
 							vaia->imsic_addr);
+		
+		if (aia->hart_to_vcpu[vaia->hart_index]) {
+			ret = -EINVAL;
+			goto fail_cleanup_imsics;
+		}
+		aia->hart_to_vcpu[vaia->hart_index] = vcpu;
 
 		/* Initialize IMSIC for this VCPU */
 		ret = kvm_riscv_vcpu_aia_imsic_init(vcpu);
@@ -293,6 +307,9 @@ static int aia_init(struct kvm *kvm)
 			continue;
 		kvm_riscv_vcpu_aia_imsic_cleanup(vcpu);
 	}
+	kfree(aia->hart_to_vcpu);
+	aia->hart_to_vcpu = NULL;
+fail_cleanup_aplic:
 	kvm_riscv_aia_aplic_cleanup(kvm);
 	return ret;
 }
@@ -551,30 +568,28 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
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
+	if (!aia->hart_to_vcpu || hart_index >= kvm->created_vcpus)
+		return 0;
 
-	return 0;
+	vcpu = aia->hart_to_vcpu[hart_index];
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
 
@@ -589,18 +604,22 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
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
+	if (!aia->hart_to_vcpu)
+		return 0;
 
-	return 0;
+	hart_index = aia_imsic_hart_index(aia, target);
+	if(hart_index >= kvm->created_vcpus)
+		return 0;
+	
+	vcpu = aia->hart_to_vcpu[hart_index];
+	if (!vcpu)
+		return 0;
+
+	ippn = vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SHIFT;
+	if (ippn != tppn)
+		return 0;
+	toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
+	return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,	toff, iid);
 }
 
 int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool level)
@@ -641,10 +660,14 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
 
 void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
 {
+	struct kvm_aia *aia = &kvm->arch.aia;
 	/* Proceed only if AIA was initialized successfully */
 	if (!kvm_riscv_aia_initialized(kvm))
 		return;
 
+	kfree(aia->hart_to_vcpu);
+	aia->hart_to_vcpu = NULL;
+
 	/* Cleanup APLIC context */
 	kvm_riscv_aia_aplic_cleanup(kvm);
 }
-- 
2.53.0
