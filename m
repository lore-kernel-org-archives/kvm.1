Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1F1DED49
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108603; cv=none; b=mPvch5ofeLP0Hwq7YQM2niimTOX43boafCRVqCihNcl3oxdCNXZvArUJXVOzew5lCNwWCDnSD4lt38KpvnLNw72HyHAVOmXZBrb87w1GGvTUVRoJoJvA4WNbY/eg3075mfOuu3QEZmRiuKCcO6XJ76bcxr7jZLWKzSzbPYByfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108603; c=relaxed/simple;
	bh=VNxfBgyhhcJhgYTz6hIZBlcSOrC/yeI6J1R8tkZxqPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X9cy9CC7H1Rx0PI61Ime6+WowSnXNb+l7eec0Zg6R7cRZc4HDJUzZ7Vzs+73eM4YKO9YEixvcxEmFjzESWljjW7TeaJZjQVa2klACCqQYrPfqeIBEZxnH3iopXllcG56A/ysP24nEeOdA+WTYvkDEUOvK+T7+8KQaQ6VXQQxEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCJtUFWy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCJtUFWy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-364c0e269e5so185601a91.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 16:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778108601; x=1778713401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjdZ46/ygQCH5IQWi9QBL1MI+gtxSTH/XY5A82t72Og=;
        b=dCJtUFWy4IgDMiKkPKVFsky3nTDL55g/fzopPZWU3z9dbafLqT6Mf+pQM/thMWQVBF
         TIeT8yWQ2EPkQcRQA8ExG6Yh3Pqzt/BMECuXjtVYUoUWvlCMoEpYsecFH5prlzi/O3HD
         Ztlpg54Xy3p1u+8JSKt+w53UWFbtiS+L/4PK/xY+qWb+XQcIc5vfcx6goc+ZfBNlom2o
         7oyVxoAb6RkbQ4cAVJPxVz+CoYqKyUUrvmKabV2cKdDs8C4CqZZF3+8HqohtkEhe9Mvx
         DFP2I0YJK6Q5CwbFYT9ra22DyL+I56E5LtVEzo2Gth2jeuL2nG4zPMmrsD+x1CHXVt46
         RgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778108601; x=1778713401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjdZ46/ygQCH5IQWi9QBL1MI+gtxSTH/XY5A82t72Og=;
        b=J69tatR2dEoP9+9BQBNnLAMZVPLC5/BI1oS2xpaCNnMy6Dwq9WHxVHWQRfz9H1L6XQ
         EHBXj5qcUI5FfD6KI9UC54C3nBKlG1q1LYufRDKtEtRWLqOjX0W0+Jw3XS2vFvSJM1+J
         IapdaGH3VbOZgSx8wr31oFnmHbcuYGG2RBpTxV+9jBviTfIryXO1Lch49scCpzOgG8NA
         YEpGZk0P8atYYpXEtBT/wvZH4svEV6+ADHlj17GK03NGeZkUYwggA2tNi1WILXfLfH/B
         RzcT+zM8CJk0aBWUtE1ginfqOTc/5x/j+iAp/d95tRxuVak1LEMuCfZgGna5gN0fpShF
         W5UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xo73wmI6/Ym/ym+O/aAbakY1e5yElzG8slV8+mE3dHVtlTf+oEAskLS8MmXZJ/l6ZgGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHk8QHXegqzXUgHYUgcb0CswGNd0mxaPOL0Tnw2JHnSVHZzG7
	a22vsW791V3aGyLTm61qU3yqBuK5ftWgsirEv3WDnE/+U9qGSNXGOPmC3z0//Bb7kVe+TBVVWcM
	aIseQ2Q==
X-Received: from pjbms19.prod.google.com ([2002:a17:90b:2353:b0:35f:b2b5:7b06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548d:b0:35f:b647:d98a
 with SMTP id 98e67ed59e1d1-365ab9b8c53mr4761378a91.5.1778108601198; Wed, 06
 May 2026 16:03:21 -0700 (PDT)
Date: Wed, 6 May 2026 16:03:20 -0700
In-Reply-To: <20260505014118.3783476-3-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com> <20260505014118.3783476-3-vannapurve@google.com>
Message-ID: <afvIuEuSYuktmtA2@google.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: FirstName LastName <vannapurve@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, FirstName LastName wrote:
> From: Vishal Annapurve <vannapurve@google.com>
> 
> TDX module virtualizes PMU for TDX VMs[1]. Host has following
> toggles to control the PMU functionality exposed to TDX VMs:
> 1) Configure TD_PARAMS to allow guests to use performance monitoring.
> 2) Restrict the TD to a subset of the PEBS counters if supported.
> 3) Limit the TD to setup a certain perfmon events using basic/enhanced
>    event filtering.
> 
> KVM will need to be enlightened to support these toggles. Explicitly
> disable PMU virtualization for TDX VMs by default until such a support lands.
> 
> [1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 1e47c194af53..01498c25942d 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
>  	kvm->arch.has_private_mem = true;
>  	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
>  
> +	/*
> +	 * PMU support is provide by the TDX-Module (if enabled for the VM).
> +	 * From KVM's perspective, the VM doesn't have a virtual PMU.
> +	 */
> +	kvm->arch.enable_pmu = false;

Gah, I forgot that KVM_CAP_PMU_CAPABILITY allows re-enabling PMU support (which
is really quite annoying).  Unless we want to risk breaking userspace, the best
idea I can come up with is to add a has_protected_pmu flag, and then disallow
KVM_CAP_PMU_CAPABILITY.

The question then becomes, do we keep patch 1 and also clear enable_pmu in tdx.c,
or do we keep the ordering and have kvm_arch_init_vm() consume has_protected_pmu?
Neither one is particularly awesome :-/

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..8371dcaaed1a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1422,6 +1422,7 @@ struct kvm_arch {
        bool has_private_mem;
        bool has_protected_state;
        bool has_protected_eoi;
+       bool has_protected_pmu;
        bool pre_fault_allowed;
        struct hlist_head *mmu_page_hash;
        struct list_head active_mmu_pages;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..3ba295bd44f8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -635,6 +635,7 @@ int tdx_vm_init(struct kvm *kvm)
         * i.e. all EOIs are accelerated and never trigger exits.
         */
        kvm->arch.has_protected_eoi = true;
+       kvm->arch.has_protected_pmu = true;
        kvm->arch.has_private_mem = true;
        kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..57d78255c80c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
                        break;
 
                mutex_lock(&kvm->lock);
-               if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
+               if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu &&
+                   !kvm->arch.has_protected_pmu) {
                        kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
                        r = 0;
                }
