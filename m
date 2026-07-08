Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88B3E5A08;
	Wed,  8 Jul 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492524; cv=none; b=mq0Sb/p2FMaB40MgubDCt1q3UqeMDIf+avp8PESY73Usj5vx7HvpGemVPLwAwkwCdzuiRyZyBRlZaOv/G8mT+vj/svQfd4wdcLUEKej9pCAKmBoHJEcRFIUW1elQqalDNnqXxLWCVYzOz8JE7qrX4Eu1/JalXv3y/K2qH6lZ6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492524; c=relaxed/simple;
	bh=/vf3PHAsAJNIwazR4I94i0mmBVjV6ott2obs3DZdHPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXGB7P4HGRBIB81EN+irvmptEfvHFejztRpTyhqPbrqJZkW8hC38nni8GYL2eVyiObLw8YHeQJbYTka72+Fwy1Ubm6obm6rk/fhL1PkqllMgvpiN/WBVYG+skZXUgp+f6y/V1GapSlysoWB6cOQy3ES3cv8UUzKap2FlM0WiAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0/VproR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0/VproR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CB1F000E9;
	Wed,  8 Jul 2026 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492523;
	bh=qLXaOxMG5EtdrXdiERP6+jVoD9Oa54aOv7zG3W4ctzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0/VproRQJX5Tkk/Ts3U+xsZK+f9rpXMOkctUZ03Nyqe6HJoZ00famVppCBdyuCVR
	 imMgXm0KTz9Kjxhq0N0wEqx7ej5Fbkn+A9pdL6NpM+BvV3D3/DGPFrks3zI1Fyzk6A
	 iAGnrmjMpg6febXfAErcL+aPGvOAOMUOB/Ne3dnOWb4xTXzGFG/oTaEbBXBWG7u7pq
	 o/sD+X4lR6TSczpr07Jo97ObEf6/dGgqAqXPY49qQBVXzZ/pJ4RUjOlxWeej0ai9Q+
	 hUHLVeUcoju2tbe9mHoMzAXNd/Rj9uvE79ZgwkYjcvmHksoJ1LqGcngEKDN04gvr76
	 oQXMQwHJ8lxGw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 08/27] kvm: irqfd: Have kvm_arch_has_irq_bypass() take struct kvm pointer
Date: Wed,  8 Jul 2026 12:02:06 +0530
Message-ID: <92937a19d41943a75d8fa1643f3a4c6b8d02cba9.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for having kvm_arch_has_irq_bypass() take the guest
configuration into account, have the helper take struct kvm pointer as
an argument.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/x86/include/asm/kvm_host.h   | 2 +-
 include/linux/kvm_host.h          | 2 +-
 arch/powerpc/kvm/powerpc.c        | 2 +-
 arch/x86/kvm/irq.c                | 2 +-
 arch/x86/kvm/vmx/posted_intr.c    | 2 +-
 virt/kvm/eventfd.c                | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cb5ef7e6c2fe..1eee05003ea1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1669,7 +1669,7 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_sctlr2(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
 
-static inline bool kvm_arch_has_irq_bypass(void)
+static inline bool kvm_arch_has_irq_bypass(struct kvm *kvm)
 {
 	return true;
 }
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d8700eb848b4..d81179b43199 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2064,7 +2064,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 	kvm_x86_call(vcpu_unblocking)(vcpu);
 }
 
-static inline bool kvm_arch_has_irq_bypass(void)
+static inline bool kvm_arch_has_irq_bypass(struct kvm *kvm)
 {
 	return enable_device_posted_irqs;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..b3b80196f4dc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2421,7 +2421,7 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 struct kvm_kernel_irqfd;
 
-bool kvm_arch_has_irq_bypass(void);
+bool kvm_arch_has_irq_bypass(struct kvm *kvm);
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..f536813b1680 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -843,7 +843,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
  * irq_bypass_stop and irq_bypass_start are not needed and so
  * kvm_ops are not defined for them.
  */
-bool kvm_arch_has_irq_bypass(void)
+bool kvm_arch_has_irq_bypass(struct kvm *kvm)
 {
 	return ((kvmppc_hv_ops && kvmppc_hv_ops->irq_bypass_add_producer) ||
 		(kvmppc_pr_ops && kvmppc_pr_ops->irq_bypass_add_producer));
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 727245a6ab34..dd776449731f 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -439,7 +439,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (WARN_ON_ONCE(!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass()))
+	if (WARN_ON_ONCE(!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass(kvm)))
 		return -EINVAL;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da23..b0b0b1d5c2cb 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -151,7 +151,7 @@ static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 	 * bypass IRQ being attached to the VM.  vmx_pi_start_bypass() ensures
 	 * blockng vCPUs will see an elevated count or get KVM_REQ_UNBLOCK.
 	 */
-	return irqchip_in_kernel(kvm) && kvm_arch_has_irq_bypass() &&
+	return irqchip_in_kernel(kvm) && kvm_arch_has_irq_bypass(kvm) &&
 	       READ_ONCE(kvm->arch.nr_possible_bypass_irqs);
 }
 
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 93ad2ebc963f..b170b37fdee2 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -488,7 +488,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 		schedule_work(&irqfd->inject);
 
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
-	if (kvm_arch_has_irq_bypass()) {
+	if (kvm_arch_has_irq_bypass(irqfd->kvm)) {
 		irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
 		irqfd->consumer.del_producer = kvm_arch_irq_bypass_del_producer;
 		irqfd->consumer.stop = kvm_arch_irq_bypass_stop;
-- 
2.54.0

