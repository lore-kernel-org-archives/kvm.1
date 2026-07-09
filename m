Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com [115.124.28.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DA3E3C76
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582286; cv=none; b=Mwy7+qVQJa60/lA7TlUMH2aEkVTd+TN3fyAdHJjYdHmt0hrocnY4+d4V+2/RDh6AC3oZ3Vo9Z+LHYrJcVCygrmSo3+oZuMqETqcwHUrOsdkCz0wqx+JBIzlejGW2wy7VWpaKvp17ibWq6mpHoXnULdFQiwUq4hLe4BCu0GH5h0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582286; c=relaxed/simple;
	bh=cwQqJYo6xx14oXIl33rHltMXeR6G3ZzMBFe0IyfB0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCAsz4MIRAxj890ejqe6gcHM4KSHV0kDXpFAg1qY6qAbTx7VW1f0ozcppCpIr97J5zW2wqoXA9VZT6M3Gvi8/KpQf8jv7SEr62CaeVoiJKdprSFci3ye39kNSPpnSCX+jCzA7HB9ZIQxllvMnsrSbf+7Mi2MqVOX6NkSOUCtmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09312803|-1;BR=01201311R931S64rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.10621-5.53476e-05-0.893735;FP=5476165066316203243|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=jerry.lyu@open-hieco.net;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.iH80GSd_1783581960;
Received: from bogon(mailfrom:jerry.lyu@open-hieco.net fp:SMTPD_---.iH80GSd_1783581960 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 15:26:01 +0800
Date: Thu, 9 Jul 2026 15:26:00 +0800
From: Jerry Lyu <jerry.lyu@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, joerg.roedel@amd.com, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: Do not warn on IGNNE MSR write
Message-ID: <ak9NCAtRATK_5sWz@bogon>
References: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
 <ak5VuvKjr8JqFOPf@google.com>
 <ak78MvlryP8vSPVe@zlvmac.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak78MvlryP8vSPVe@zlvmac.local>

On Thu, Jul 09, 2026 at 09:41:06AM +0800, Jerry Lyu wrote:
> Thanks Sean for the prompt feedback!
> 

[trim]

> > 
> > Well, yeah, that's what KVM is doing, ignoring the write.  But KVM is also logging
> > that the guest attempted to write an MSR that KVM doesn't support, i.e. this is
> > more or less working as intended.
> > 
> > That said, KVM does effectively support the case where #IGGNE is not asserted, so
> > I think we can simply do this to avoid the useless logging?
> 
> Yeah, that can work for the current case. However, if another guest
> initializes the IGNNE MSR with different value meanwhile never enables
> the IGNNE emulation, kvm will again print uselsss logging. How about
> adding warning in HW_CR like below?

Did more testing and found that windows did set the
HWCR.IgnneEm (bit-8). The conditonal branch needs to be below to avoid
the warning:

+               if (data & BIT_ULL(8)) {
+                       /* ignore ignne emulation enable with a warning */
+                       if (!(vcpu->arch.cr0 & X86_CR0_NE))
+                               kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+                       data &= ~(u64)0x100;
+               }

This is also not complete as it only checks the current vcpu's cr0 while
the MSR is global, and it cannot capture the case where people enable
IgnneEm before clearing CR0.NE.

I now tend to go with Sean's initial suggestion which is simple and
address the windows issue. Thanks!

Regards,
-Jerry

> 
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c230b18d87e3..cbb743c41276 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -1564,12 +1564,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 u64 valid = BIT_ULL(18) | BIT_ULL(24);
>  
>                 data &= ~(u64)0x40;     /* ignore flush filter disable */
> -               data &= ~(u64)0x100;    /* ignore ignne emulation enable */
>                 data &= ~(u64)0x8;      /* ignore TLB cache disable */
>  
>                 if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
>                         valid |= MSR_K7_HWCR_CPUID_USER_DIS;
>  
> +               if (data & BIT_ULL(8)) {
> +                       /* ignore ignne emulation enable with a warning */
> +                       data &= ~(u64)0x100;
> +                       kvm_pr_unimpl_wrmsr(vcpu, msr, data);
> +               }
> +
>                 if (data & ~valid) {
>                         kvm_pr_unimpl_wrmsr(vcpu, msr, data);
>                         return 1;
> 
> Then the IGNNE write can be silently ignored no matter what value to
> write. The kvm selftest of hwcr_msr_test.c can keep unchanged. What's
> your opinion? Thanks again!
> 
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e755f43f4376..a7efac3241c2 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3205,7 +3205,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> >         case MSR_VM_CR:
> >                 return svm_set_vm_cr(vcpu, data);
> >         case MSR_VM_IGNNE:
> > -               kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
> > +               if (data)
> > +                       kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
> >                 break;
> >         case MSR_AMD64_DE_CFG: {
> >                 u64 supported_de_cfg;
