Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7542316B
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770191; cv=none; b=f5w61KmC/x0pEWaauBQewN7rV3fxRZyrnPm9aeyJN7A+keGVVvK7MpDbq8/YQJ/6EMvFCuNDmX5g/B8NhKbUnpg1w+eVfZwAtv/47WFJ+sX6GrcEXASxxmiSI+3JrN6OAwVppNXCnVhDcvGIAD/WCA+VF0V5Xun+oKm/fiR7kVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770191; c=relaxed/simple;
	bh=YCL/VHQ90LyUyRjdeHCENY4SvRDHXBXlF0yxW4LxsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNk3N7FUlqNzfR+H4Z0r87nkdKWwpxDzuWTbBoKe9zoL4OkkaRtZDsxpWckhATJF32oEQAjzLwkRlefzT6MkOqQr4OgcMIs50Mwo5XQ6LnQCwbkFOqpR4QAOCSnURDAEscUqOd4Se0nJ3D9WwFZcDBCQFUnZhHKGyjoT/2xneHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+46fwj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+46fwj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15338C2BCB3;
	Thu, 14 May 2026 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770190;
	bh=YCL/VHQ90LyUyRjdeHCENY4SvRDHXBXlF0yxW4LxsLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+46fwj0/3KepJ3IvcNLxsruDcOxb/yyT//NlR14Stzk6yfx4+GiZbOgzUuBRywf6
	 faLv9weL+BS08nK2Tn5LEfX5lYBORl5YkAJKIKKA93Lr05RoxqtvsyncY02vOoAxFA
	 4qLgNhaiR4LZQORy5YWYmPunK4w2xO2dsckiRBswluQxO+glHi2Ykl6WSJ+BWk5gNS
	 krTF+ENf+40+NP0vLTwgdBlLEWth1EZrC2/W5DUZ6T16TpXlrw4dG+TH4xbtjZy/nO
	 AJlMrxIVm+aDat8YlJzyjLvzSwGkpeWdbs7Yd2Lqcr7mZvIKgrn64Ek7cML82vNw6h
	 JWfII+VXghf/Q==
Date: Thu, 14 May 2026 20:11:09 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 6/9] KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for
 extended APIC
Message-ID: <agXeBPq5nTUxuxcS@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-7-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-7-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:49AM +0000, Manali Shukla wrote:
> Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 ioctls to save and restore APIC
> state using a 4KB buffer (kvm_lapic_state2).  The larger buffer allows
> saving additional APIC registers beyond the standard APIC registers
> supported by the existing 1KB KVM_GET/SET_LAPIC ioctls.
> 
> The 4KB buffer size matches the LAPIC2 capability, which enables the
> full APIC register page including extended APIC registers for AMD
> processors.
> 
> KVM_GET/SET_LAPIC continue to work as before for backward compatibility.
> Document the new ioctls in Documentation/virt/kvm/api.rst.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  Documentation/virt/kvm/api.rst  | 45 +++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/kvm.h |  5 +++
>  arch/x86/kvm/x86.c              | 59 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |  2 ++
>  4 files changed, 111 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 71b4d24f009a..c49cf3104b2c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6517,6 +6517,51 @@ the capability to be present.
>  
>  `flags` must currently be zero.
>  
> +4.144 KVM_GET_LAPIC2
> +----------------------
> +
> +:Capability: KVM_CAP_LAPIC2
> +:Architectures: x86
> +:Type: vcpu ioctl
> +:Parameters: struct kvm_lapic_state2 (out)
> +:Returns: 0 on success, negative on failure
> +
> +Reads the extended Local APIC registers, including both the standard APIC
> +register space (offsets 0h-3FFh) and the extended APIC register space (offsets
> +400h-500h and beyond).
> +
> +This ioctl is similar to KVM_GET_LAPIC but operates on a 4KB APIC
> +register space that includes extended LVT registers available on AMD processors
> +with the ExtApicSpace feature.
> +
> +::
> +
> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
> +  struct kvm_lapic_state2 {
> +      char regs[KVM_APIC_EXT_REG_SIZE];
> +  };
> +
> +4.145 KVM_SET_LAPIC2
> +----------------------
> +
> +:Capability: KVM_CAP_LAPIC2
> +:Architectures: x86
> +:Type: vcpu ioctl
> +:Parameters: struct kvm_lapic_state2 (in)
> +:Returns: 0 on success, negative on failure
> +
> +Sets the extended Local APIC registers, including both the standard APIC
> +register space and the extended APIC register space.
> +
> +This ioctl is similar to KVM_SET_LAPIC but operates on a 4KB APIC register space
> +that includes extended LVT registers for AMD processors.
> +
> +::
> +
> +  #define KVM_APIC_EXT_REG_SIZE 0x1000
> +  struct kvm_lapic_stat2 {
> +      char regs[KVM_APIC_EXT_REG_SIZE];
> +  };
>  
>  .. _kvm_run:
>  
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 7ceff6583652..516d4a0be25a 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -129,6 +129,11 @@ struct kvm_lapic_state {
>  	char regs[KVM_APIC_REG_SIZE];
>  };
>  
> +#define KVM_APIC_EXT_REG_SIZE 0x1000
> +struct kvm_lapic_state2 {
> +	char regs[KVM_APIC_EXT_REG_SIZE];
> +};
> +
>  struct kvm_segment {
>  	__u64 base;
>  	__u32 limit;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 669c894f1061..ccd16bdff56a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5331,6 +5331,17 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
>  	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
>  }
>  
> +static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
> +				    struct kvm_lapic_state2 *s)
> +{
> +	if (vcpu->arch.apic->guest_apic_protected)
> +		return -EINVAL;
> +
> +	kvm_x86_call(sync_pir_to_irr)(vcpu);
> +
> +	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
> +}
> +

Instead of introducing additional functions/helpers, I think we should 
unify handling of the existing and the new IOCTLs.

Along with a change to revert the previous patch, how about the below on 
top of your series (completely untested, so likely buggy but should 
hopefully give a sense of the approach):

diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 552d416e5fc6..c7a9687bdd7f 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -136,8 +136,8 @@ static inline int kvm_irq_delivery_to_apic(struct kvm *kvm,
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 
 int kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value, bool host_initiated);
-int kvm_apic_get_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size);
-int kvm_apic_set_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size);
+int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state2 *s);
+int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state2 *s, bool is_lapic2);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
 
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ed20e0b21be7..434607374423 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3236,12 +3236,12 @@ void kvm_apic_ack_interrupt(struct kvm_vcpu *vcpu, int vector)
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_apic_ack_interrupt);
 
 static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
-		void *regs, bool set)
+		struct kvm_lapic_state2 *s, bool set)
 {
 	if (apic_x2apic_mode(vcpu->arch.apic)) {
 		u32 x2apic_id = kvm_x2apic_id(vcpu->arch.apic);
-		u32 *id = (u32 *)(regs + APIC_ID);
-		u32 *ldr = (u32 *)(regs + APIC_LDR);
+		u32 *id = (u32 *)(s->regs + APIC_ID);
+		u32 *ldr = (u32 *)(s->regs + APIC_LDR);
 		u64 icr;
 
 		if (vcpu->kvm->arch.x2apic_format) {
@@ -3274,12 +3274,12 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 
 		if (!kvm_x86_ops.x2apic_icr_is_split) {
 			if (set) {
-				icr = apic_get_reg(regs, APIC_ICR) |
-				      (u64)apic_get_reg(regs, APIC_ICR2) << 32;
-				apic_set_reg64(regs, APIC_ICR, icr);
+				icr = apic_get_reg(s->regs, APIC_ICR) |
+				      (u64)apic_get_reg(s->regs, APIC_ICR2) << 32;
+				apic_set_reg64(s->regs, APIC_ICR, icr);
 			} else {
-				icr = apic_get_reg64(regs, APIC_ICR);
-				apic_set_reg(regs, APIC_ICR2, icr >> 32);
+				icr = apic_get_reg64(s->regs, APIC_ICR);
+				apic_set_reg(s->regs, APIC_ICR2, icr >> 32);
 			}
 		}
 	}
@@ -3287,20 +3287,20 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvm_apic_get_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
+int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state2 *s)
 {
-	memcpy(regs, vcpu->arch.apic->regs, size);
+	memcpy(s->regs, vcpu->arch.apic->regs, sizeof(*s));
 
 	/*
 	 * Get calculated timer current count for remaining timer period (if
 	 * any) and store it in the returned register set.
 	 */
-	apic_set_reg(regs, APIC_TMCCT, __apic_read(vcpu->arch.apic, APIC_TMCCT));
+	apic_set_reg(s->regs, APIC_TMCCT, __apic_read(vcpu->arch.apic, APIC_TMCCT));
 
-	return kvm_apic_state_fixup(vcpu, regs, false);
+	return kvm_apic_state_fixup(vcpu, s, false);
 }
 
-int kvm_apic_set_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
+int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state2 *s, bool is_lapic2)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	int r;
@@ -3308,14 +3308,16 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, void *regs, unsigned int size)
 	kvm_x86_call(apicv_pre_state_restore)(vcpu);
 
 	/* set SPIV separately to get count of SW disabled APICs right */
-	apic_set_spiv(apic, *((u32 *)(regs + APIC_SPIV)));
+	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
 
-	r = kvm_apic_state_fixup(vcpu, regs, true);
+	r = kvm_apic_state_fixup(vcpu, s, true);
 	if (r) {
 		kvm_recalculate_apic_map(vcpu->kvm);
 		return r;
 	}
-	memcpy(vcpu->arch.apic->regs, regs, size);
+	memcpy(vcpu->arch.apic->regs, s->regs, is_lapic2 ?
+					       sizeof(struct kvm_lapic_state2) :
+					       sizeof(struct kvm_lapic_state));
 
 	atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
 	kvm_recalculate_apic_map(vcpu->kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f8a115f50f8e..2e66a1bc94a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5326,17 +5326,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
-				    struct kvm_lapic_state *s)
-{
-	if (vcpu->arch.apic->guest_apic_protected)
-		return -EINVAL;
-
-	kvm_x86_call(sync_pir_to_irr)(vcpu);
-
-	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
-}
-
-static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state2 *s)
 {
 	if (vcpu->arch.apic->guest_apic_protected)
@@ -5344,34 +5333,19 @@ static int kvm_vcpu_ioctl_get_lapic2(struct kvm_vcpu *vcpu,
 
 	kvm_x86_call(sync_pir_to_irr)(vcpu);
 
-	return kvm_apic_get_state(vcpu, s->regs, sizeof(*s));
+	return kvm_apic_get_state(vcpu, s);
 }
 
 static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
-				    struct kvm_lapic_state *s)
+				    struct kvm_lapic_state2 *s,
+				    bool is_lapic2)
 {
 	int r;
 
 	if (vcpu->arch.apic->guest_apic_protected)
 		return -EINVAL;
 
-	r = kvm_apic_set_state(vcpu, s->regs, sizeof(*s));
-	if (r)
-		return r;
-	update_cr8_intercept(vcpu);
-
-	return 0;
-}
-
-static int kvm_vcpu_ioctl_set_lapic2(struct kvm_vcpu *vcpu,
-				    struct kvm_lapic_state2 *s)
-{
-	int r;
-
-	if (vcpu->arch.apic->guest_apic_protected)
-		return -EINVAL;
-
-	r = kvm_apic_set_state(vcpu, s->regs, sizeof(*s));
+	r = kvm_apic_set_state(vcpu, s, is_lapic2);
 	if (r)
 		return r;
 	update_cr8_intercept(vcpu);
@@ -6251,7 +6225,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	int r;
 	union {
 		struct kvm_sregs2 *sregs2;
-		struct kvm_lapic_state *lapic;
 		struct kvm_lapic_state2 *lapic2;
 		struct kvm_xsave *xsave;
 		struct kvm_xcrs *xcrs;
@@ -6262,37 +6235,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 	u.buffer = NULL;
 	switch (ioctl) {
-	case KVM_GET_LAPIC: {
-		r = -EINVAL;
-		if (!lapic_in_kernel(vcpu))
-			goto out;
-		u.lapic = kzalloc_obj(struct kvm_lapic_state);
-
-		r = -ENOMEM;
-		if (!u.lapic)
-			goto out;
-		r = kvm_vcpu_ioctl_get_lapic(vcpu, u.lapic);
-		if (r)
-			goto out;
-		r = -EFAULT;
-		if (copy_to_user(argp, u.lapic, sizeof(struct kvm_lapic_state)))
-			goto out;
-		r = 0;
-		break;
-	}
-	case KVM_SET_LAPIC: {
-		r = -EINVAL;
-		if (!lapic_in_kernel(vcpu))
-			goto out;
-		u.lapic = memdup_user(argp, sizeof(*u.lapic));
-		if (IS_ERR(u.lapic)) {
-			r = PTR_ERR(u.lapic);
-			goto out_nofree;
-		}
-
-		r = kvm_vcpu_ioctl_set_lapic(vcpu, u.lapic);
-		break;
-	}
+	case KVM_GET_LAPIC:
 	case KVM_GET_LAPIC2: {
 		r = -EINVAL;
 		if (!lapic_in_kernel(vcpu))
@@ -6302,26 +6245,33 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!u.lapic2)
 			goto out;
-		r = kvm_vcpu_ioctl_get_lapic2(vcpu, u.lapic2);
+		r = kvm_vcpu_ioctl_get_lapic(vcpu, u.lapic2);
 		if (r)
 			goto out;
 		r = -EFAULT;
-		if (copy_to_user(argp, u.lapic2, sizeof(struct kvm_lapic_state2)))
+		if (copy_to_user(argp, u.lapic2, ioctl == KVM_GET_LAPIC2 ?
+						 sizeof(struct kvm_lapic_state2) :
+						 sizeof(struct kvm_lapic_state)))
 			goto out;
 		r = 0;
 		break;
 	}
+	case KVM_SET_LAPIC:
 	case KVM_SET_LAPIC2: {
 		r = -EINVAL;
 		if (!lapic_in_kernel(vcpu))
 			goto out;
-		u.lapic2 = memdup_user(argp, sizeof(*u.lapic2));
-		if (IS_ERR(u.lapic2)) {
-			r = PTR_ERR(u.lapic2);
-			goto out_nofree;
-		}
+		u.lapic2 = kzalloc(sizeof(struct kvm_lapic_state2), GFP_KERNEL);
+		r = -ENOMEM;
+		if (!u.lapic2)
+			goto out;
+		r = -EINVAL;
+		if (copy_from_user(u.lapic2, argp, ioctl == KVM_SET_LAPIC2 ?
+						   sizeof(struct kvm_lapic_state2) :
+						   sizeof(struct kvm_lapic_state)))
+			goto out;
 
-		r = kvm_vcpu_ioctl_set_lapic2(vcpu, u.lapic2);
+		r = kvm_vcpu_ioctl_set_lapic(vcpu, u.lapic2, ioctl == KVM_SET_LAPIC2);
 		break;
 	}
 	case KVM_INTERRUPT: {


- Naveen

