Received: from out28-109.mail.aliyun.com (out28-109.mail.aliyun.com [115.124.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E329430
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561589; cv=none; b=V9e4rEUV7UyF+vyin1eymK+TyCHBD0kmYXHrXbSKSJ3/uWyzmaz3/JD4JnxwhL8xXGUaFXki1yaKFUuL7yHResPKcVK2W5SOPnSsfRciR5LeIKCIAp+m6ZQTP62Tw18HlOS9pP3Z6OIa+CuCvR2cU9A4xcIZEnYksSjg9GuEJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561589; c=relaxed/simple;
	bh=XDx6hiRPlLRB1nt6RQ0T+WMR1rDClk5dqyNKqgw556Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVQ0YBa0eVjUXvrN71ZpGZqRJH0jEDHtfJrmeBYnCcwO751dHHj/OPtioC7CdSYdwNZoVcvW1J7bcqY+DhmKXTUei4MH1Bs5f1L+5+Nj3RqA2rvykeI7nM9eXkbMFbSLVMXYR8xqd/lBg3c2/rLSYgk3KHt2GVPMYZdSdJ1xWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07974804|-1;BR=01201311R181S42rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0207919-2.97758e-05-0.979178;FP=286593328519996490|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=jerry.lyu@open-hieco.net;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.iGoAblQ_1783561266;
Received: from zlvmac.local(mailfrom:jerry.lyu@open-hieco.net fp:SMTPD_---.iGoAblQ_1783561266 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 09:41:07 +0800
Date: Thu, 9 Jul 2026 09:41:06 +0800
From: Jerry Lyu <jerry.lyu@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, joerg.roedel@amd.com, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: Do not warn on IGNNE MSR write
Message-ID: <ak78MvlryP8vSPVe@zlvmac.local>
References: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
 <ak5VuvKjr8JqFOPf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5VuvKjr8JqFOPf@google.com>

Thanks Sean for the prompt feedback!

On Wed, Jul 08, 2026 at 06:50:50AM -0700, Sean Christopherson wrote:
> On Wed, Jul 08, 2026, Jerry Lyu wrote:
> > Booting windows server 2025 on top of Linux KVM results in host kernel
> > warning logs of "Unhandled WRMSR(0xc0010115) = 0x0", which is due to
> > "IGNNE MSR" write in guest hyper-v. According to AMD APM volume 2,
> > section 15.30.2, the MSR is "only useful if IGNNE emulation has been
> > enabled in the HW_CR MSR", while currently KVM has prevented guests from
> > enabling it. So change the warning to a stronger check.
> 
> Except the APM doesn't say anything about the ordering, and in typical APM

Indeed. I did some experiment on bare metal system to write IGNNE MSR
with it disabled and then write HW_CR to enable it, the written value is
still there. It can be in any order.

> fashion, nor does it actually say what happens if IGNNE emulation is disabled.

Right. I did not find that as well. Since IGNNE MSR and IGNNE emulation
is an incremental feature, it would be reasonable to guess that hardware
will fall back to the IGNNE pin usage relying on external sources to
assert/de-assert it. If the IGNNE pin is not available in hardware,
CR0.NE must not be 0 to use the legacy mode.

> 
> > IGNNE is used in the legacy MS-DOS compatibility sub-mode of X87 FPU
> > exception handling. Intel SDM volume 1, section 8,7.2 describes the
> > details of this mode which applies to AMD CPU as well. The CPU selects
> > this mode when CR0.NE bit is 0, and will rely on two pins (FERR# and
> > IGNNE#) for exception handling. AMD later introduced IGNNE MSR to "set
> > the state of the processor-internal IGNNE signal directly" in order to
> > support the legacy mode without the dependency on IGNNE# pin.
> > 
> > The current KVM implementation does not emulate this feature, not sound
> > necessary as well. The commit 82494028dff648c29e3a ("KVM: SVM: Ignore
> > write of hwcr.ignne") clears the bit-8 value in the guest HWCR MSR
> > write, making such field always zero, then the write to guest IGNNE MSR
> > can always be safely ignored.
> 
> Well, yeah, that's what KVM is doing, ignoring the write.  But KVM is also logging
> that the guest attempted to write an MSR that KVM doesn't support, i.e. this is
> more or less working as intended.
> 
> That said, KVM does effectively support the case where #IGGNE is not asserted, so
> I think we can simply do this to avoid the useless logging?

Yeah, that can work for the current case. However, if another guest
initializes the IGNNE MSR with different value meanwhile never enables
the IGNNE emulation, kvm will again print uselsss logging. How about
adding warning in HW_CR like below?

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e3..cbb743c41276 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1564,12 +1564,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                u64 valid = BIT_ULL(18) | BIT_ULL(24);
 
                data &= ~(u64)0x40;     /* ignore flush filter disable */
-               data &= ~(u64)0x100;    /* ignore ignne emulation enable */
                data &= ~(u64)0x8;      /* ignore TLB cache disable */
 
                if (guest_cpu_cap_has(vcpu, X86_FEATURE_GP_ON_USER_CPUID))
                        valid |= MSR_K7_HWCR_CPUID_USER_DIS;
 
+               if (data & ~BIT_ULL(8)) {
+                       /* ignore ignne emulation enable with a warning */
+                       data &= ~(u64)0x100;
+                       kvm_pr_unimpl_wrmsr(vcpu, msr, data);
+               }
+
                if (data & ~valid) {
                        kvm_pr_unimpl_wrmsr(vcpu, msr, data);
                        return 1;

Then the IGNNE write can be silently ignored no matter what value to
write. The kvm selftest of hwcr_msr_test.c can keep unchanged. What's
your opinion? Thanks again!

> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e755f43f4376..a7efac3241c2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3205,7 +3205,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>         case MSR_VM_CR:
>                 return svm_set_vm_cr(vcpu, data);
>         case MSR_VM_IGNNE:
> -               kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
> +               if (data)
> +                       kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
>                 break;
>         case MSR_AMD64_DE_CFG: {
>                 u64 supported_de_cfg;
