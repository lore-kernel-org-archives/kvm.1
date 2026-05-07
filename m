Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFB3F7A99
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164834; cv=none; b=f8CBwJLcga3wSjMXpXVWZlud+mtIXyem70+G2ynXlTLUkQs9ASdNz8BatMMB+3oexei7hORI9f2BSLneXCJVrqdH4MhA7lxLYD4X/6j4Y0qu6dgqwnh8d2p52VuUF3nWxR1J6iwOJKI4cL1S02rcECExTwVFPbyznSaKvc8NUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164834; c=relaxed/simple;
	bh=Cn5JYFt+re2uIrrew2b1uNvLy9dnU0v0AiT84U5uVjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMNYEYk2gCrfK3ThnphMbc7Kj+8P9BKF9/CvCicD5AxmmbZPiYkAvpV3Hmy0yYXmczFpTTlhoDSASoqFyrNUwFoBoxHJrCDKImXWouB/ykPB4s2XIuEN6PL1n8XHNS1x2oXP56e30Qxaue1f2fIJpP2aSdJ+ew4AWQoDzuuwV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9nFZ09e; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9nFZ09e"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so653942b3a.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778164832; x=1778769632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=geAlAIqy7GyIFv6P4BbXpEe4TxhfkgYP5jfPUWU5/oE=;
        b=C9nFZ09e18x1arQjbszamZNXxAkPZFJ9PCoPM44SPMp3QzToUnHx+a8fSjDR9/fFL7
         cJ/HvXVa+0c7u2fEiSQ1BoTlurVBVHdKfHE11SbfApRKAdZIAmFSKuY785+XGEFs8esA
         FdBUqd/g5nnMQsVBbxA/S1oSbS3R46TNebiUqvv6MxEszTUxhznOyXsyDCUHrpOiXAEE
         9gtWZFEuQh4vARXAzQOz6NjFAwE1on/WEDT6wh/aIK/mZlpYksCTDd0v0D21BfrTuFVx
         CJW8D/8WUmvUW46gxPMqrqJe8g64+XlQ23lWdHq/nhCYupIl5rJns1eFF9yy6+vt5aNQ
         5EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164832; x=1778769632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geAlAIqy7GyIFv6P4BbXpEe4TxhfkgYP5jfPUWU5/oE=;
        b=nIbv5gKYxz7+Q5gw5scwUWtDNZHQZndtZZsXhOPeRyeG2nDXBBZcB+XgQhGtX8G3Rn
         Xkmlgjqpe0gdUatJ8MLiXS5xYEr8GxkVDneGIWLDSReudSOi/TF/QoIcj0uKXFkbFfcA
         90ffavuicXNO4yjRkENZ0jbrh3oYFmxpMpqbaqIjBI4OKJ23IKjdIOtb9Izb68mA4a+H
         pxC3eAuHTfmXrAa8ID6Q57Zd3tiP7U3gI57TNxsp78MUuvUJZY6JMXFKfH0CB1nal1nx
         9m8+6v5gKmyeiUo0pVOewVfwYS6Tf3w6CjHq+jCYKHOwjtR2ibNyjGRGRThlUFsNeHGT
         VsnQ==
X-Forwarded-Encrypted: i=1; AFNElJ83XmqZyndDBuK0OacFWTZz260HctDnMO6FmH3aewfnoc+j5axzAlP3SNlPgBTWanug18c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUtAYxa3EJlDirZhamc1yBjIyX9uwWq6dvqmkoWvT2hSNRTrm
	RAPmQjGxrLDdOosAwBtLrwjNHZWUN+3w5wmcOUe5GaXz2KFBP4mE0jYOBZIiIsA1QQDTsGHzzfI
	4hCQXQw==
X-Received: from pfbmu6.prod.google.com ([2002:a05:6a00:6e86:b0:837:f337:257c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f03:b0:838:c01a:7a46
 with SMTP id d2e1a72fcca58-83a5d6810bcmr7828556b3a.26.1778164831887; Thu, 07
 May 2026 07:40:31 -0700 (PDT)
Date: Thu, 7 May 2026 07:40:31 -0700
In-Reply-To: <20260505195226.563317-16-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <20260505195226.563317-16-pbonzini@redhat.com>
Message-ID: <afykX-a6xxCZh6GK@google.com>
Subject: Re: [PATCH 15/28] KVM: VMX: enable use of MBEC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, Paolo Bonzini wrote:
> @@ -7823,6 +7830,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>  	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
>  }
>  
> +bool vmx_tdp_has_smep(struct kvm *kvm)
> +{
> +	return enable_mbec;
> +}
> +
>  static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u32 new_ctl)
>  {
>  	/*
> @@ -8622,6 +8634,8 @@ __init int vmx_hardware_setup(void)
>  
>  	if (!cpu_has_vmx_ept_ad_bits() || !enable_ept)
>  		enable_ept_ad_bits = 0;
> +	if (!cpu_has_ept_mbec() || !enable_ept)
> +		enable_mbec = 0;
>  
>  	if (!cpu_has_vmx_unrestricted_guest() || !enable_ept)
>  		enable_unrestricted_guest = 0;
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index db84e8001da5..0a4e263c4095 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -567,6 +567,7 @@ static inline u8 vmx_get_rvi(void)
>  	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
>  	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
>  	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
> +	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
>  	 SECONDARY_EXEC_ENCLS_EXITING |					\
>  	 SECONDARY_EXEC_EPT_VIOLATION_VE)
>  
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index d09abeac2b56..69cf276be88e 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -103,6 +103,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
>  int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
>  int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
>  u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
> +bool vmx_tdp_has_smep(struct kvm *kvm);

As suggested in v5, can we do this?

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 60dd1b5e9520..cc14a6b96681 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7839,11 +7839,6 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
        return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
 }
 
-bool vmx_tdp_has_smep(struct kvm *kvm)
-{
-       return enable_mbec;
-}
-
 static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u32 new_ctl)
 {
        /*
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 69cf276be88e..409858074246 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -4,6 +4,7 @@
 
 #include <linux/kvm_host.h>
 
+#include "capabilities.h"
 #include "x86.h"
 
 __init int vmx_hardware_setup(void);
@@ -103,7 +104,11 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
 int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
 u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
-bool vmx_tdp_has_smep(struct kvm *kvm);
+
+static inline bool vmx_tdp_has_smep(struct kvm *kvm)
+{
+       return enable_mbec;
+}
 
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
                       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
