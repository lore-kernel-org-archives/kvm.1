Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EA472782
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723902; cv=none; b=DzNxTnQcdOJ6563fIxruLhNvrn26y+QrvLqiX/wsXkmOIKCoPSP5TrLqC7K5UT3Q4Jp/gudNbvi1Fo4EwbC40NKCrDHuvO1IKFAX+jcyhTVpnhjKqYUB1W21yFekDIsJLFZ31ifoWwiL7QZN57BPzxqz+Skh2LtcuYymCe/phw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723902; c=relaxed/simple;
	bh=zec9Bn6B1wmg9c8Qo8oD/pbZR6VpiOSIiT/CmRsxMu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J73ia3rUTLKdgvb2RGZd2cluID/sJt20nSpd+oG7GYoOmtVyA2NLoe6mj/14dk1R/YULt5Hc3lyWzriY/NMeJZmPx+SuyAeoCkSENWVslOENfewL6DKAzK2+M0CEfGzwLbZlYo/cxu7+2aN/LkKmbjOQyMarsJbRQmcJYM/qmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VErEhOnC; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VErEhOnC"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8488ac68185so2205211b3a.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723895; x=1787328695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FnW9wsBSO7OxZHDCPddc5vJtLigKE2XL3AEM5oSheVQ=;
        b=VErEhOnCRGn4ExQ/g4eAyOTHN6A4fVrVGlsNOmC5JsOKG8KKZ02kf2/PQ8+hPES+Ay
         DI1jcboE7UALlJuCJ81YW4aERXF6EfDHNnR1fr8gUsVV+W5pRTX/AFE4fj0+BH2FYpAh
         sBPW1Rz1bNWNP20Gf2IINsH2VdoaltjBHIDjz0gVeFfX46/shpcAFNE7HBdVOnsW5TjF
         Z779BWWQQe5UUjq3iZktg6DuwNJPiF+Ny0zlI5C/vT38YmL1rebOShK54qqXVCkrDJUr
         53PWmqK3uiklX0uBcNigPK0lCzdB1yUQvy9cPjnCOeAS78tCs2bxAvxfYeftaSrlrjbG
         +9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723895; x=1787328695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FnW9wsBSO7OxZHDCPddc5vJtLigKE2XL3AEM5oSheVQ=;
        b=nfzpjCg4xi5ja34h6gLLbGByONiNimnDRJEXmfIVcw9vhrS+FaU4Iyr0sQcR9S5OSv
         0Yz9dHZY/UM/aaRa/2a04ZmyHbR564CljuF0eVvyizb5/S449wxQMndLTV9FZzNbGSpz
         xrNzUciL7k+9NN4EZXsjyFc+zFtNWo91u4ShQovaQ8NNYkqIA3U24d47r7CDD3PsmUHd
         2PpUxeG7+Xjg6UJH7xe8O/5k+zz7gNPNmojZDTVYA0Pmv2VO6Z1odbJN4wleeDb9lbiT
         URIomvUVYs0sNeZrkzVknXveHU/Stq/oyRXNnhpmqSNS+D7OfWJ6gqyng0FAmlQR7gBZ
         OeTg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5rNpIqZcIeg65Cpvxr9KK+uwbpMC/6UyfrzDRjb5HKr1l2ofDHiQvbS1Or/B6QKeYLIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuZv7Jzba4UnVwhkLlafAGDTSsx6m1xBhfQjfU+kJrDOJ+96R
	5H/rPcB1JLSggQzSGjIrX+cC2AWfWcxBzHHC2R4rw787np/OLz7mj1vA+KWsFWh9Q8KawRnyo6L
	T1gi3ug==
X-Received: from pfbgp12.prod.google.com ([2002:a05:6a00:3b8c:b0:84b:4480:8b65])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4193:b0:848:56ff:6ced
 with SMTP id d2e1a72fcca58-84fde11d751mr8247332b3a.8.1786723894753; Fri, 14
 Aug 2026 09:11:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Aug 2026 09:11:29 -0700
In-Reply-To: <20260814161129.2177118-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814161129.2177118-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename all common posted interrupt APIs that use a "vmx" prefix to instead
use a "vt" prefix to capture that they are used for both VMX and TDX vCPUs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/main.c        |  4 ++--
 arch/x86/kvm/vmx/posted_intr.c | 16 ++++++++--------
 arch/x86/kvm/vmx/posted_intr.h |  8 ++++----
 arch/x86/kvm/vmx/tdx.c         |  4 ++--
 arch/x86/kvm/vmx/vmx.c         |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 95d89d809c19..9a113613a1f9 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1075,8 +1075,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.update_cpu_dirty_logging = vt_op(update_cpu_dirty_logging),
 
-	.pi_update_irte = vmx_pi_update_irte,
-	.pi_start_bypass = vmx_pi_start_bypass,
+	.pi_update_irte = vt_pi_update_irte,
+	.pi_start_bypass = vt_pi_start_bypass,
 
 #ifdef CONFIG_X86_64
 	.set_hv_timer = vt_op(set_hv_timer),
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 24221ba553be..7a6a44587044 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -56,7 +56,7 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 	return 0;
 }
 
-void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 	struct vcpu_vt *vt = to_vt(vcpu);
@@ -146,7 +146,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
-static bool vmx_can_use_vtd_pi(struct kvm *kvm)
+static bool vt_can_use_vtd_pi(struct kvm *kvm)
 {
 	/*
 	 * Note, reading the number of possible bypass IRQs can race with a
@@ -219,10 +219,10 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vcpu)
 	 * back to the pi_wakeup_handler() function.
 	 */
 	return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
-		vmx_can_use_vtd_pi(vcpu->kvm);
+		vt_can_use_vtd_pi(vcpu->kvm);
 }
 
-void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
+void vt_vcpu_pi_put(struct kvm_vcpu *vcpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 
@@ -294,17 +294,17 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
 /*
  * Kick all vCPUs when the first possible bypass IRQ is attached to a VM, as
  * blocking vCPUs may scheduled out without reconfiguring PID.NV to the wakeup
- * vector, i.e. if the bypass IRQ came along after vmx_vcpu_pi_put().
+ * vector, i.e. if the bypass IRQ came along after vt_vcpu_pi_put().
  */
-void vmx_pi_start_bypass(struct kvm *kvm)
+void vt_pi_start_bypass(struct kvm *kvm)
 {
-	if (WARN_ON_ONCE(!vmx_can_use_vtd_pi(kvm)))
+	if (WARN_ON_ONCE(!vt_can_use_vtd_pi(kvm)))
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
 }
 
-int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+int vt_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_vcpu *vcpu, u32 vector)
 {
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a4af39948cf0..c5860ea828ae 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -8,16 +8,16 @@
 
 #include <asm/posted_intr.h>
 
-void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
-void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
+void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
-int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+int vt_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_vcpu *vcpu, u32 vector);
-void vmx_pi_start_bypass(struct kvm *kvm);
+void vt_pi_start_bypass(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..6e7a2acb3f92 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -716,7 +716,7 @@ void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
-	vmx_vcpu_pi_load(vcpu, cpu);
+	vt_vcpu_pi_load(vcpu, cpu);
 	if (vcpu->cpu == cpu || !is_hkid_assigned(to_kvm_tdx(vcpu->kvm)))
 		return;
 
@@ -826,7 +826,7 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 
 void tdx_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	vmx_vcpu_pi_put(vcpu);
+	vt_vcpu_pi_put(vcpu);
 	tdx_prepare_switch_to_host(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa0098723976..40bae81bc041 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1577,12 +1577,12 @@ void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	vmx_vcpu_load_vmcs(vcpu, cpu);
 
-	vmx_vcpu_pi_load(vcpu, cpu);
+	vt_vcpu_pi_load(vcpu, cpu);
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	vmx_vcpu_pi_put(vcpu);
+	vt_vcpu_pi_put(vcpu);
 
 	vmx_prepare_switch_to_host(to_vmx(vcpu));
 }
-- 
2.55.0.691.gc56d675ccc-goog

