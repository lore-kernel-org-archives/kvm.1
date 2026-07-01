Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE2379C3C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878489; cv=none; b=GBtKEjFfpFh6y3spskQ3ZJvZ6uf3H8q5+a6l0KmVLVfzLXK9rzhCwOsjNFcffYiJh3MhVC3NNK0fKIfTdHRAL0GZdkS6vxPKny/0rZPbY8L9aYLN2+PaPHvsIeQ3+ET4HD8D+Wv70ceiF54drUAe/Lf7x2vwgxwA6ZQ8Em+k1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878489; c=relaxed/simple;
	bh=PRI0mFWu7c0lbMzkBlN8wfFM98sHT+hJCWxDK6jTPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbZKY4ePbeCmcDzu0WwsFlAjqJD/KJUtb8Z7CRi63GnAYXVpnLZCjOWuvCcdEjKIEb091PwY2ju2iB1knHhTqf7JZ4zzxpFHfTbIUKTCTKM2XPXp3mXtR3rWH4kINpEpErmlbNVOpdMmVVuH4dqveQtQoS8Dp0MSAU9qPo44NO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=emXxSYfu; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="emXxSYfu"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c944aacbaso378976eec.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878480; x=1783483280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwx/vaLTjb7GROGFhRcYHmobCEksaNrQHxJqVkC3GAI=;
        b=emXxSYfu5/N0J+GMlcwfX9tSxfapGlFd7cyjrh34qQ7mEKTd2EDKOxH93IBaz0KJSC
         n8Wk4i+/qDpX1uyAuJgonNOiICHAPfPloioXGymV+6+a/rUxLXIurEzcrfA121VGZUTA
         RdQYmlm8wq6yknoC3rHwTmZ2qR9jqGG3EbRyy2bsw7qGvXrGRzE2GD7OpKSgVZOj02Io
         QS7XGwX6cLyDhF+KUzawS+vQF8Jw/ZDntGkBdQwrdL8awKbbQrb5KZwLQQYWC0mQyvtv
         FfoW6D65PFZ91/y3RHN2Umtz9v2xq/JzQ+KW1XpnaG8QINFlaIWFS7s9ECBaG7m3Rc5/
         bQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878480; x=1783483280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zwx/vaLTjb7GROGFhRcYHmobCEksaNrQHxJqVkC3GAI=;
        b=CdAGrN2qEFtMzzQsgrm51hKuMHbLjriFJzEH0dGFtpR8FcQGEvQc1Z3jahoVqltUJG
         jNdxVBk6mX/Rp/ZsMEfDI1HTWSySdaXToNO7IIAd86PPpOUnUYGjerPE9jXAr0rXbd2O
         2h/XbljQFFLJ9dp4/LJYb0NOhHVUoJPeHkn3CeUpotnj/LXZYNY3PRMCkOYlYjBCTGIu
         zRIzXAV2D8T1Y8/KukWG4KQpBTHDL5EDYdIOHiCMYXv1nOrpXxJkpiVjHLRWfnwog44A
         To0yj7wjXlD8Hj7uH6GL0oQn51LFQ5h+ANM0HrBFfVTJG3KV7UJL0mY4atxo/4TNI/Tp
         H++A==
X-Forwarded-Encrypted: i=1; AHgh+Rpg9R8cjTKJI/ES0zV5OPfzdjvE7y/9cJsa/yg0Ww+CFmC4/R4WivKdVJJ8Hs5Ad7UcdO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkG10x4sYOEqzkHIwGQFB+rT6Djp+HnOqkC/YplaUX59UVxYL
	tWa4W9y7/I2EhKca6PSdfPqO+twqyQnIrUDbsi3so0NHjdxGmZsPBT3Xw6YY46QLHJI=
X-Gm-Gg: AfdE7clItXcEKriBAU6JAr9XGGgmttHdLWavBlxIJH6hFv0ZpIHojIZBdCzolCtoCqR
	Q5+Hr4YFwUGCqMlOCmF49Av5RXmTxXlBosQoOvaQxAe842JhZ3A3IqSsqJw35FShfn6JN0mlau7
	nt4BuqkMiUFQsr7jYfezMl7PVOetTeRbCl2zLTGNiAFf5kxmK8BTGSmUJ9NtIWpreTHfZzWE3HA
	1ELmc3yHVN1LttqzlOK7U5mkaw3HYcxbpHhajRoct4JngLhQyR4MPtH5/hTU6pJ78T/9AIAJi4M
	5M820VAH2oVGKTSebAqNAWA28bbQrReN0PWIICphWx+k/bOUYyWxaJcKABz65EqsK71ozVfVliU
	XIcXjScF4djx445GHN+jWRU/DCmOU49BAFKqDRjtl30/Ljk8ufBbLPsJ1PBiN0hO0mw7tJX9x5B
	hr0kw6KHfGUPiDeHnKonBxOJ2kUh9hFiWLLcif12fshdnWAYv9b6WNHW9pLdKYYWPKfDgCfZxZp
	SA=
X-Received: by 2002:a05:7300:2325:b0:30c:ab4d:3835 with SMTP id 5a478bee46e88-30ee150c708mr5808915eec.44.1782878480101;
        Tue, 30 Jun 2026 21:01:20 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.01.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:01:18 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [RFC PATCH 3/3] RISC-V: KVM: Identify MRIF notices from irqfd snapshots
Date: Wed,  1 Jul 2026 12:00:16 +0800
Message-ID: <20260701040017.42707-4-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
 <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MRIF notice handling must skip the normal software IMSIC EIP update only
for the physical IRQ that was retargeted as a MRIF notice MSI. The
existing code infers that case by comparing the injected guest IID with
cached host MSI data values.

That value comparison is not a reliable source discriminator. Normal
guest MSI injection also reaches kvm_riscv_vcpu_aia_imsic_inject(), and
its guest IID can collide with a cached host MSI data value. When that
happens, KVM treats a normal guest interrupt as a MRIF notice and drops
the software IMSIC update before the guest observes the interrupt.

Identify MRIF notices from the irqfd route snapshot instead.
irqfd_wakeup() copies irqfd->irq_entry under irq_entry_sc before
injecting the MSI, so keep the RISC-V MRIF notice target in that same
snapshot. Userspace MSI injection passes no irqfd snapshot and therefore
always follows the normal software IMSIC path.

Update the snapshot only while holding kvm->irqfds.lock, including
irq-bypass producer attach and detach callbacks, because irq_entry_sc is
associated with that lock. Record MRIF metadata only after a successful
MRIF retarget; VS-file retargets and unsupported/error paths clear the
metadata so later ordinary irqfd injections cannot be misclassified as
MRIF notices.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 arch/riscv/include/asm/kvm_aia.h |   7 +-
 arch/riscv/kvm/aia_device.c      |   9 +-
 arch/riscv/kvm/aia_imsic.c       | 154 +++++++++++++++++++++++--------
 arch/riscv/kvm/vm.c              |   9 +-
 4 files changed, 139 insertions(+), 40 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index b04ecdd1a860..ab3613b96b7c 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -14,6 +14,8 @@
 #include <linux/kvm_types.h>
 #include <asm/csr.h>
 
+struct kvm_kernel_irq_routing_entry;
+
 struct kvm_aia {
 	/* In-kernel irqchip created */
 	bool		in_kernel;
@@ -103,6 +105,8 @@ int kvm_riscv_aia_imsic_has_attr(struct kvm *kvm, unsigned long type);
 void kvm_riscv_vcpu_aia_imsic_reset(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 				    u32 guest_index, u32 offset, u32 iid);
+bool kvm_riscv_vcpu_aia_imsic_mrif_notice(struct kvm_vcpu *vcpu,
+					  struct kvm_kernel_irq_routing_entry *irq);
 int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_aia_imsic_cleanup(struct kvm_vcpu *vcpu);
 
@@ -155,7 +159,8 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu);
 
 int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
 				   u32 guest_index, u32 iid);
-int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi);
+int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi,
+			     struct kvm_kernel_irq_routing_entry *irq);
 int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool level);
 
 void kvm_riscv_aia_init_vm(struct kvm *kvm);
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index b195a93add1c..644376abaa34 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -559,7 +559,8 @@ int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
 	return 0;
 }
 
-int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
+int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi,
+			     struct kvm_kernel_irq_routing_entry *irq)
 {
 	gpa_t tppn, ippn;
 	unsigned long idx;
@@ -585,6 +586,12 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
 					IMSIC_MMIO_PAGE_SHIFT;
 		if (ippn == tppn) {
 			toff = target & (IMSIC_MMIO_PAGE_SZ - 1);
+			/*
+			 * MRIF notices are identified by irqfd routing state,
+			 * not MSI value.
+			 */
+			if (kvm_riscv_vcpu_aia_imsic_mrif_notice(vcpu, irq))
+				return 0;
 			return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
 							       toff, iid);
 		}
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index b496953e0c4d..6cb5fc832efb 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -817,6 +817,28 @@ static int kvm_arch_update_irqfd_unset(struct kvm *kvm, unsigned int host_irq)
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
+static void kvm_arch_update_irqfd_mrif_target(struct kvm_kernel_irqfd *irqfd,
+					      struct kvm_vcpu *vcpu,
+					      struct imsic *imsic)
+{
+	lockdep_assert_held(&irqfd->kvm->irqfds.lock);
+
+	write_seqcount_begin(&irqfd->irq_entry_sc);
+	irqfd->irq_entry.irqfd_arch_vcpu = vcpu;
+	irqfd->irq_entry.irqfd_arch_data = imsic;
+	write_seqcount_end(&irqfd->irq_entry_sc);
+}
+
+static void kvm_arch_clear_irqfd_mrif_target(struct kvm_kernel_irqfd *irqfd)
+{
+	lockdep_assert_held(&irqfd->kvm->irqfds.lock);
+
+	write_seqcount_begin(&irqfd->irq_entry_sc);
+	irqfd->irq_entry.irqfd_arch_vcpu = NULL;
+	irqfd->irq_entry.irqfd_arch_data = NULL;
+	write_seqcount_end(&irqfd->irq_entry_sc);
+}
+
 static struct msi_msg *kvm_arch_update_irqfd_hostirq(struct imsic *imsic,
 						     unsigned int host_irq, int *ret,
 						     struct kvm_kernel_irq_routing_entry *e)
@@ -824,7 +846,7 @@ static struct msi_msg *kvm_arch_update_irqfd_hostirq(struct imsic *imsic,
 	struct msi_msg *priv_msg = xa_load(&imsic->hostirq_array, host_irq);
 
 	if (!priv_msg) {
-		priv_msg = kzalloc(sizeof(*priv_msg), GFP_KERNEL);
+		priv_msg = kzalloc(sizeof(*priv_msg), GFP_ATOMIC);
 		if (!priv_msg) {
 			*ret = -ENOMEM;
 			goto out;
@@ -855,22 +877,44 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 	struct riscv_iommu_ir_vcpu_info vcpu_info;
 	struct kvm *kvm = irqfd->kvm;
 	struct kvm_aia *aia = &kvm->arch.aia;
-	int host_irq = irqfd->producer->irq;
-	struct irq_data *irqdata = irq_get_irq_data(host_irq);
+	struct irq_data *irqdata;
 	unsigned long tmp, flags;
-	struct kvm_vcpu *vcpu;
+	struct irq_chip *chip;
+	struct kvm_vcpu *vcpu = NULL;
 	struct imsic *imsic;
 	struct msi_msg msg;
 	u64 msi_addr_mask;
 	gpa_t target;
-	int ret;
+	int host_irq, ret;
 
+	lockdep_assert_held(&kvm->irqfds.lock);
+
+	if (!irqfd->producer) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
+		return;
+	}
+
+	/*
+	 * Keep the MRIF notice target in the irqfd route snapshot. Successful
+	 * retargeting updates this snapshot, same-MSI updates reuse the
+	 * previous snapshot, and unroute clears it.
+	 */
 	if (old && old->type == KVM_IRQ_ROUTING_MSI &&
 	    new && new->type == KVM_IRQ_ROUTING_MSI &&
-	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
+	    !memcmp(&old->msi, &new->msi, sizeof(new->msi))) {
+		write_seqcount_begin(&irqfd->irq_entry_sc);
+		irqfd->irq_entry.irqfd_arch_vcpu = old->irqfd_arch_vcpu;
+		irqfd->irq_entry.irqfd_arch_data = old->irqfd_arch_data;
+		write_seqcount_end(&irqfd->irq_entry_sc);
 		return;
+	}
+
+	host_irq = irqfd->producer->irq;
+	irqdata = irq_get_irq_data(host_irq);
+	chip = irqdata ? irq_data_get_irq_chip(irqdata) : NULL;
 
 	if (!new) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 		if (!WARN_ON_ONCE(!old) && old->type == KVM_IRQ_ROUTING_MSI) {
 			ret = kvm_arch_update_irqfd_unset(kvm, host_irq);
 			WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
@@ -878,12 +922,21 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 		return;
 	}
 
-	if (new->type != KVM_IRQ_ROUTING_MSI)
+	if (new->type != KVM_IRQ_ROUTING_MSI) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
+		return;
+	}
+
+	if (!chip || !chip->irq_write_msi_msg) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 		return;
+	}
 
 	target = ((gpa_t)new->msi.address_hi << 32) | new->msi.address_lo;
-	if (WARN_ON_ONCE(target & (IMSIC_MMIO_PAGE_SZ - 1)))
+	if (WARN_ON_ONCE(target & (IMSIC_MMIO_PAGE_SZ - 1))) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 		return;
+	}
 
 	msg = (struct msi_msg){
 		.address_hi = new->msi.address_hi,
@@ -895,8 +948,10 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 		if (target == vcpu->arch.aia_context.imsic_addr)
 			break;
 	}
-	if (!vcpu)
+	if (!vcpu) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 		return;
+	}
 
 	imsic = vcpu->arch.aia_context.imsic_state;
 
@@ -910,8 +965,10 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 		.host_irq = host_irq,
 		.host_msg = kvm_arch_update_irqfd_hostirq(imsic, host_irq, &ret, new),
 	};
-	if (ret)
+	if (ret) {
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 		return;
+	}
 
 	read_lock_irqsave(&imsic->vsfile_lock, flags);
 
@@ -924,19 +981,27 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 	}
 
 	ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-	WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
-	if (ret) {
-		if (ret == -ENODEV) {
-			imsic->mrif_support = false;
-			ret = 0;
-		}
+	if (ret == -ENODEV) {
+		imsic->mrif_support = false;
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
+		ret = 0;
 		goto out;
 	}
+	WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
+	if (ret)
+		goto out;
+
 	if (imsic->mrif_support)
-		irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata, &msg);
+		chip->irq_write_msi_msg(irqdata, &msg);
+	if (vcpu_info.mrif)
+		kvm_arch_update_irqfd_mrif_target(irqfd, vcpu, imsic);
+	else
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 
 out:
 	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	if (ret)
+		kvm_arch_clear_irqfd_mrif_target(irqfd);
 }
 
 static void kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu)
@@ -988,13 +1053,21 @@ static void kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu)
 			vcpu_info.mrif = false;
 		}
 		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
 		if (ret == -ENODEV) {
 			imsic->mrif_support = false;
-			ret = 0;
+			kvm_arch_clear_irqfd_mrif_target(irqfd);
+			continue;
 		} else if (ret == -EOPNOTSUPP) {
-			break;
+			kvm_arch_clear_irqfd_mrif_target(irqfd);
+			continue;
 		}
+		if (ret)
+			kvm_arch_clear_irqfd_mrif_target(irqfd);
+		else if (vcpu_info.mrif)
+			kvm_arch_update_irqfd_mrif_target(irqfd, vcpu, imsic);
+		else
+			kvm_arch_clear_irqfd_mrif_target(irqfd);
+		WARN_ON_ONCE(ret);
 	}
 
 	spin_unlock_irq(&kvm->irqfds.lock);
@@ -1254,24 +1327,9 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->vsfile_cpu >= 0) {
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
 	} else {
-		if (imsic->mrif_support) {
-			struct msi_msg *msg;
-			unsigned long idx;
-
-			/* In MRIF mode, the noticed MSI irq handler will call here to
-			 * determine whether the MRIF has been updated.Since the IOMMU
-			 * hardware has updated the MRIF,the software does not need to
-			 * update the MRIF file again.
-			 */
-			xa_for_each(&imsic->hostirq_array, idx, msg) {
-				if (msg->data == iid)
-					goto skip_update_swfile;
-			}
-		}
 		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
 		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
 
-skip_update_swfile:
 		imsic_swfile_extirq_update(vcpu);
 	}
 
@@ -1280,6 +1338,30 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+bool kvm_riscv_vcpu_aia_imsic_mrif_notice(struct kvm_vcpu *vcpu,
+					  struct kvm_kernel_irq_routing_entry *irq)
+{
+	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	unsigned long flags;
+	bool handled = false;
+
+	if (!imsic || !irq ||
+	    irq->irqfd_arch_vcpu != vcpu ||
+	    irq->irqfd_arch_data != imsic)
+		return false;
+
+	read_lock_irqsave(&imsic->vsfile_lock, flags);
+
+	if (imsic->mrif_support && imsic->vsfile_cpu < 0) {
+		imsic_swfile_extirq_update(vcpu);
+		handled = true;
+	}
+
+	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+
+	return handled;
+}
+
 static int imsic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 			   gpa_t addr, int len, void *val)
 {
@@ -1302,7 +1384,7 @@ static int imsic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 	msi.address_hi = addr >> 32;
 	msi.address_lo = (u32)addr;
 	msi.data = *((const u32 *)val);
-	kvm_riscv_aia_inject_msi(vcpu->kvm, &msi);
+	kvm_riscv_aia_inject_msi(vcpu->kvm, &msi, NULL);
 
 	return 0;
 };
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 1d33cff73e00..354036434b5e 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -68,9 +68,12 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	unsigned long flags;
 
+	spin_lock_irqsave(&irqfd->kvm->irqfds.lock, flags);
 	irqfd->producer = prod;
 	kvm_arch_update_irqfd_routing(irqfd, NULL, &irqfd->irq_entry);
+	spin_unlock_irqrestore(&irqfd->kvm->irqfds.lock, flags);
 
 	return 0;
 }
@@ -80,11 +83,13 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	unsigned long flags;
 
+	spin_lock_irqsave(&irqfd->kvm->irqfds.lock, flags);
 	WARN_ON(irqfd->producer != prod);
-
 	kvm_arch_update_irqfd_routing(irqfd, &irqfd->irq_entry, NULL);
 	irqfd->producer = NULL;
+	spin_unlock_irqrestore(&irqfd->kvm->irqfds.lock, flags);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
@@ -111,7 +116,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 	msi.flags = e->msi.flags;
 	msi.devid = e->msi.devid;
 
-	return kvm_riscv_aia_inject_msi(kvm, &msi);
+	return kvm_riscv_aia_inject_msi(kvm, &msi, e);
 }
 
 static int kvm_riscv_set_irq(struct kvm_kernel_irq_routing_entry *e,
-- 
2.50.1 (Apple Git-155)

