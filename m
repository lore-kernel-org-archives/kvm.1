Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58404AB3C1
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357496; cv=none; b=tMn8lpt2v0WAR5W/EvxhHYMB8gMpZPq92Is2KzllWzSf+6FXLL8yzOKPMVuGSEkkEE+UTjRUOBYndnlfLfx3MbWDppHQKJBeSrzdoNTg+5GP/uPx1T/a11kD27YTCLhCqV6SHV4JHqdyMJvJ+hVXmtsTQlMUnZ/XL/DovuazR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357496; c=relaxed/simple;
	bh=4DoFX/YBpRy7JF49hbwfc/peTk/uuTMAY2oZkVM5mWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSNjGwijqPq/eh+0E9CN/vEZ5lbkwLXMKG90Y1GyNJkkbeFbgSKo4vVgzTm0xeCvpPQYDIsTPM4vl9zQ7eRPvGT/eyAmw1bAaW1AldkESuhXcLPudMbYNvlp+lICUkxhQWTvB12gYzyt7jQinRkgl48Fzxtwl6+pM9MfZ9i58gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivLuFr+4; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivLuFr+4"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso967719a91.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790357494; x=1790962294; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tiH0o0CKyETGieh/W9nxysiE6dokq2oy//rDmGSPlXI=;
        b=ivLuFr+48p7jvnL7Kng42kdOq83ZUGPyPbOHpqRd0cw32GUuEX7EwDaHHQUraSK6N0
         2/HvhjOJhJIveTj+ddzP27YwuzGmPwho6HrP7RxBsctAIJxiSAupJQs2JP4lYXb2UX8K
         PDxMwYIMfP6UhTK96NNtIEEnVwvjHLiDmwpgEoK1Y+EYMJexWtFZrjCAkv4FhsOP4ZK5
         X9oO+cMLXji7GQ1FWS/yRq2W7q8hvCzm/sYxHEbPegG/w80BuB9XJiUv5XJ0H3cdfS6B
         oZ81ErKERfm4pXeYNGL58+gAF/xye850RLNkDLEWcgEMIejY0C1cH4ScP1C4hzvVA5Q/
         +ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357494; x=1790962294;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tiH0o0CKyETGieh/W9nxysiE6dokq2oy//rDmGSPlXI=;
        b=GdyAk8aCtv47KzAE9S3FRPp/MNCJzR1mQIoeT/JgfBozIV9tRPhq2KechUlS5kYcPm
         KcAxrXd1BoZyDnulf4IL9nB8mTqrS1sWFwDVxfcVMWbLNrUcT3YbXflUR1TmlZTQor74
         qPXbrXsGMdXoX230dfu1kqKk6pxu2fF1a/cTv07nikBojknTwmyQc5WXGtSqq/Df3nNP
         kB1wWQKlSwogVTDLnBpLxdFZt8mVESXl0JfRpzIXiazEcEzL3LbzAOmxF8djXqLdaLO7
         q+PRi78Yt0AwhWCRhLK2+huNYmlnY/v6qn+zplCmzvV4DQf+loaDqkEV55qOJKwAdhlz
         e5/g==
X-Forwarded-Encrypted: i=1; AKwUvBwnXC09lcMc8CzW2l/DdxQr5W6SQLi8YsRCjJA/2KObqgyBKWIra7mwmLjxNbb+es8yooY=@vger.kernel.org
X-Gm-Message-State: AFuF++nJvs6XVJKFqpB4WuiD2hFyZSVIg91tzhQxL/klBMsuUyLP3NFN
	BSoAgzWLf4tEXjtoR8oWQljR0I+1VYJ2Qypxh+EekWwc1M0futEJ9TzOJRHDI3kubh/zq0b5d3O
	1j8j+JQ==
X-Received: from pjbrt18.prod.google.com ([2002:a17:90b:5092:b0:3a0:7480:2e85])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384b:b0:3a0:c360:a562
 with SMTP id 98e67ed59e1d1-3a0c360bd58mr1587941a91.14.1790357493852; Fri, 25
 Sep 2026 10:31:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:31:33 -0700
In-Reply-To: <20260721050600.87268-2-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com> <20260721050600.87268-2-shivansh.dhiman@amd.com>
Message-ID: <arav9aN48nEZTv7V@google.com>
Subject: Re: [PATCH v4 1/5] KVM: SVM: Refactor svm_update_lbrv()
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

The shortlog is effectively "do work".  Be more precise.

On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
> 'if' statements. Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled(),
> expose it, and use it instead of open-coding the nested LBRV check.

This is super duper obviously two separate and *barely* related patches.

> No functional change intended.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> ---
> Changelog:
> v3 -> v4:
>  * Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled() (Yosry).

I don't like this change.  Unlike nested_vgif_enabled(), this is *only* checking
the effective vmcb12.  Once the guest_cpu_cap_has() code is moved elsewhere, I
don't see any point in keeping the helper.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..e9f2456982d4 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -880,9 +880,13 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
> -	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
> -			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> -			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
> +	bool enable_lbrv = false;
> +
> +	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
> +		enable_lbrv = true;
> +
> +	if (is_guest_mode(vcpu) && nested_lbrv_enabled(vcpu))
> +		enable_lbrv = true;

This is begging for short-circuit logic (which was kinda the point of the existing
code).  An if-elif is silly, and I agree that squeezing everything into variable
initialization is hard to read, so I think we should do:

static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
{
	struct vcpu_svm *svm = to_svm(vcpu);

	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
		return true;

	return is_guest_mode(vcpu) &&
	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
}


		bool enable_lbrv = svm_need_lbr_virtualization(vcpu);
