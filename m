Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B63C09F2
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821788; cv=none; b=CTa4MzXRU+Rru98dj6kmsc4MmmKnbLEWxVKIjoGENL9CrD4C6NX57I/qK2JYo2fWlTwW7WfNehnG3asP50wub+YiENLnVZNYwp9EStFG7M1Ar8vUxgJR/ls1m9ez1SZsZobnYa94xTVE8iq1APtJmElDEZfObj1NGEl28LJqbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821788; c=relaxed/simple;
	bh=6dnsZQ1XSVo4t7qdOov7kk5fAPwumTfWbLmkoyUrYIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/DTyOT8UibkfYEHdvDHwGE9bIdocxY6ip/66MGTe0PN2gZKhF6KHUviZyk4BkiyJV70nwGnME5n43ruTnXe/VQxMShNM6kej851rlrapgOwQ+bqqshB/7aowqsw3Q+Qc0Nu5nmkAhdBi6njntfkiw3m7jcpXNKeYpUPDbVJ13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnkdfDf3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnkdfDf3"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso7833238a12.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779821787; x=1780426587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9whSHDcnpOlsME/5pU2ZoWhg08t7imgsHqG/h56Yeo=;
        b=JnkdfDf3Z/UaasyV2Nz4rtSKQ8jG2pw8FDuTauj/F/p60wTMdx77dgJoKMle+oZdO/
         nEd3IDEaza+xN2grC9CKxm2fd/xLa0Zfv0kHqerXPmKlDnul4zf8E1ihYB2zNPARrqzM
         dIWqQ91H9V1te5gyxrjATd8OgCsyehzuAs371Bb3uVcg0PbInZagpLZ5F2OXjvaRRsxx
         AAWyawZToCyTYqmoB8lApmgTlFOMS+dNe+VDtndtSQES7bfvzBP+xSpvI8c2M8IN3fmd
         C3E2ngu2jMYH41tFNaESXVXR61hp6z4ke4xNMVDx6s797D7iGekuIyfN4g28ALZzh8/4
         X9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821787; x=1780426587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9whSHDcnpOlsME/5pU2ZoWhg08t7imgsHqG/h56Yeo=;
        b=KiijlhOAqsIhQ4dd4GAwN0uasqraf0wSNo1YORUgs7Z9wWlV3lPQSfcBVbql4puuT/
         qX9d6cZyVaw4uQt5JprZXMtNeySzFiVzFN/eSZ9dZ7fLo6ExUi9KrRsPMK5dk9dDkAnA
         tOIa07JMIoomEyOaoEmTWOuw0ZmOC2bPcsOP2GGnlyEcj8+uwseOsP0xY4iO2r8Lus5Q
         wyl78f3l6tVnGQExa9RRJQUElOV3rBwxfys82i0Z89Lv/A4UXu/xeDIxY5K3boyBnQtb
         +DCawgD3mKjo8xKfwtsuIVmdAVctEvFGX60ArFKHUSKOb5qNEpEGqkVKYcDgQqTgVNjD
         f3Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+GXpeJuRyyg0XX2kuC1Xz7w3iFPkDOS1IyZHb9OunT33/0bGeC17py4ryVXDoHzizlA4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnInOI0oXHvWHuN9r07XYCmnKqUSSBeMMi7VV1+IaAABzVthj
	e2vxCNma43N0VguXS0DJavBOdXFdP6/lohlpByfCJ7KJ+4XRyXmGEqqJw5/lV8zv3jO/HKQA2q8
	0ZrlsxQ==
X-Received: from pgj186.prod.google.com ([2002:a63:9c3:0:b0:c73:9a1a:387d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a108:b0:39f:a42:9247
 with SMTP id adf61e73a8af0-3b328f56208mr20478877637.37.1779821786683; Tue, 26
 May 2026 11:56:26 -0700 (PDT)
Date: Tue, 26 May 2026 11:56:26 -0700
In-Reply-To: <tencent_744B87186CA59CFD106992329A6510F7F60A@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_744B87186CA59CFD106992329A6510F7F60A@qq.com>
Message-ID: <ahXs2mVqtahs7iG7@google.com>
Subject: Re: [PATCH] KVM: VMX: Use _safe MSR accessors in LBR handler
From: Sean Christopherson <seanjc@google.com>
To: xuanqingshi <1356292400@qq.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, xuanqingshi wrote:
> From: Xuanqing Shi <1356292400@qq.com>
> 
> intel_pmu_handle_lbr_msrs_access() uses rdmsrq()/wrmsrq() to directly
> access LBR-related MSRs on the physical CPU. If the guest provides an
> out-of-range or otherwise invalid MSR index,

The fault isn't due to an invalid index, it's due to setting reserved bits.

> the unchecked access
> triggers a #GP fault, resulting in an "unchecked MSR access error"
> warning and a host crash when panic_on_warn is enabled.
> 
> The crash was observed in a nested virtualization setup where a
> VMCS-targeted fuzzer triggered
 
Please stop describing this as a fuzzer.  Pulling in information from an off-list
discussion:

 : The fuzzer works by patching the L1 KVM exit dispatch path via a kernel
 : module. Before KVM dispatches to the handler, the module replaces the
 : EXIT_REASON field in the VMCS with a target value (e.g.,
 : EXIT_REASON_TPR_BELOW_THRESHOLD). The L1 vCPU was created without calling
 : KVM_CREATE_IRQCHIP, so vcpu->arch.apic is NULL. When the injected exit reason
 : steers execution into the TPR handler, the NULL dereference occurs.

That's not a fuzzer, that's "fault" injection, where even that doesn't match the
kernel's typical terminology for "fault injection".  Kernel usage of "fault
injection" is to inject _legitimate_ faults in paths where a "fault" is unlikely
to occur inpractice, e.g. an -ENOMEM due to OOM on an order-0 allocation.

The faults being injected here _can't_ happen absent a buggy (virtual) CPU.  And
if the (virtual) CPU is buggy, we _want_ the WARNs.

That's not relevant to this bug though, this is a pretty straightforward KVM goof.

> a WRMSR to MSR 0x1c8 (LBR_SELECT) that propagated through the PMU emulation
> path to the physical host:
> 
>   unchecked MSR access error: WRMSR to 0x1c8
>   (tried to write 0x0000000000004000)
                                  ^^^^
                                  |
                                  -- This is the culprit.

E.g. it's trivially easy to reproduce with:

diff --git tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
index d004108dbdc6..9e9362e1a0a5 100644
--- tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
+++ tools/testing/selftests/kvm/x86/vmx_pmu_caps_test.c
@@ -201,6 +201,7 @@ KVM_ONE_VCPU_TEST(vmx_pmu_caps, lbr_perf_capabilities, guest_code)
 
        vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
        vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);
+       vcpu_set_msr(vcpu, MSR_LBR_SELECT, 0x4000);
 
        vcpu_clear_cpuid_entry(vcpu, X86_PROPERTY_PMU_VERSION.function);
 
>   Call Trace:
>    ? native_write_msr+0x4/0x30
>    ? intel_pmu_handle_lbr_msrs_access+0xff/0x120 [kvm_intel]
>    intel_pmu_set_msr+0x4e0/0x7f0 [kvm_intel]
>    kvm_pmu_set_msr+0x17e/0x1c0 [kvm]
>    kvm_set_msr_common+0xc76/0x1440 [kvm]
>    vmx_set_msr+0x5e6/0x1570 [kvm_intel]
>    kvm_emulate_wrmsr+0x54/0x1d0 [kvm]
>    vmx_handle_exit+0x7fc/0x970 [kvm_intel]
> 
> Replace rdmsrq()/wrmsrq() with their _safe variants so that invalid
> MSR accesses are caught gracefully and reported back to the guest as
> errors instead of crashing the host.
> 
> Found by a VMCS-targeted fuzzer based on syzkaller.
> 
> Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
> Signed-off-by: Xuanqing Shi <1356292400@qq.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 27eb76e6b6a0..94d2cbffcff4 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -293,6 +293,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  {
>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
>  	u32 index = msr_info->index;
> +	int err;
>  
>  	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
>  		return false;
> @@ -309,12 +310,12 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  	local_irq_disable();
>  	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
>  		if (read)
> -			rdmsrq(index, msr_info->data);
> +			err = rdmsrq_safe(index, &msr_info->data);
>  		else
> -			wrmsrq(index, msr_info->data);
> +			err = wrmsrq_safe(index, msr_info->data);

I don't love throwing a value at hardware to see what sticks, but given that KVM
disables interception of these MSRs, it's not like there's a better option.

No need for a v2, I'll rewrite the changelog when applying.
