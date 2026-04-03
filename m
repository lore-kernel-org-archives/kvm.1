Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044E3D5236
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237991; cv=none; b=e07WxxGnIh+PDImhwkge+BN2LH2wu0ZcaY2mVOSULSRLUOBbmDp4qLYre9jMS9uQhAgMzsrQn/de7//WJYvSzTyjGIDpJEr8Lp1FTriOWrDjAsvjuIrWuZqcHFO3gNjuprdP+rVTvWxyYq9m7p+DKTZpxJwzBG8epipVWtgqhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237991; c=relaxed/simple;
	bh=Jy4rfj1/KxJ8LJwCt44iynD9eO2mSp4vklm/C58wTNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qtPZyFWOD65mKoeftt3y88hnMkpr+cOIw3zimtYuigwo5zk9esfzhUqufuHiGAHq8eJHdvdhz4YtPfzVT4KTwQpQSUfHxkvjS4C5YBJW+UYT4RV1fuEcmwjJNJVWxvAZCME07toX7GGXbI9LPY2EuiqQqMCjEYYpcFARGZF9F3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prUa61PS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prUa61PS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so1480720b3a.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775237988; x=1775842788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOEqOx7BmoFYS8gE1J9R8bgbNcRFQ8KaX5aD52jo+zc=;
        b=prUa61PSGd5RzzFNERG3WfTmZkF+2x+1h/mYIwWq7yKU9G9/hfraTUWby8sGfd4n/x
         i4Y7KX6wgFIKDe/E9HyYOY5rohRzCwKHQqsQKDVFa1hk2C3B4c6G1fNozxplamtr2zow
         3rBdxcWmjgcVrBpBYgx0JA8yrzUOhA0lSPzDRLyLeluHeA+JFThRjNwbSwWIuf/NBa4D
         W4wJYBSWC/aCS6czHJ1+dZLJWD7d8MxjjWe+uiv2Mtnxi2y5dVKgRa1BVqdsqgbtqHiG
         zoapgQlyoxOKKb2AFevu754AkiS7vOlAXR6DNrENHbl2w6u2jolSunGH/zMHaczMIuEm
         eYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237988; x=1775842788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOEqOx7BmoFYS8gE1J9R8bgbNcRFQ8KaX5aD52jo+zc=;
        b=SOrvOg/j49hcA/Jrn13LainM1Dxx/nVLJeuc5aiivIWwHsJlI7TL58R6j4FmxvHHZY
         zR41KU9RR8p3GVthFsiCCntQR/S8O7ktd2DS7esAymUBu2YxucpfqNhxFf7a5yp0iCtC
         JEQpJzf+Tap53IN1SR8R11lRpvad8Fu3nO6NxT4NLkAcnZ8EE3KPcDLUmLXx7VwKsGhW
         adbwl9D4J2uYQ8BpQl/7rbEh4KuzbdSv++C+OElvpq+2zSVgIGWFXqgY/+RAuu964BDV
         ixefXI2NfxRbqCcl5SanxNf4HPpRKxyGxgU9sL/3Tam2dUOIS4CQhh2/ZyvjIqsbq6BS
         gWfA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGp+5z/Mx6mP/hgOiuHa3dbFev7BxCpeKWUfkgNGs1cZc9NS0aYqd/+AkGzI33MYJqNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBmNv3+pHFb7sKGYpnJ8TlG3vrx7oR4pU7hW7qymX7Zbtqj0a
	lEvOwLqZB7Ab/kY5PoGjfa/g3R3YJljAxvrSaVOSKtSf8eDcMJ6Eg5nZCYlUfxgXLSia/r8s9jB
	FwE7MFA==
X-Received: from pfqf9.prod.google.com ([2002:aa7:9d89:0:b0:82c:ed07:26b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d10:b0:829:9f46:280d
 with SMTP id d2e1a72fcca58-82d0da345b2mr3710999b3a.1.1775237987747; Fri, 03
 Apr 2026 10:39:47 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:39:46 -0700
In-Reply-To: <20260316202732.3164936-4-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-4-yosry@kernel.org>
Message-ID: <ac_7Yg-Ma4UR2nIz@google.com>
Subject: Re: [PATCH v4 3/9] KVM: SVM: Properly check RAX on #GP intercept of
 SVM instructions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> Replace the PAGE_MASK check with page_address_valid(), which checks both
> page-alignment as well as the legality of the GPA based on the vCPU's
> MAXPHYADDR. Use kvm_register_read() to read RAX to avoid
> page_address_valid() failing on 32-bit due to garbage in the higher
> bits.

Nit, not "on" 32-bit, correct?  I think you actually mean "to avoid false positives
when the vCPU is in 32-bit mode, in the unlikely case the vCPU transitioned from
64-bit back to 32-bit, without writing EAX".  Because regs[] is an unsigned long,
so the upper bits of save.rax will be cleared by svm_vcpu_run() on every VM-Entry,
and it should be impossible for a purely 32-bit guest to get a non-zero value in
RAX[63:32].

And even for a 64-bit host with a 32-bit guest, the only way to get a non-zero
value in RAX[63:32] while in 32-bit mode would be to transition from 64-bit mode,
back to 32-bit mode, without writing EAX.

> Note that this is currently only a problem if KVM is running an L2 guest
> and ends up synthesizing a #VMEXIT to L1, as the RAX check takes
> precedence over the intercept. Otherwise, if KVM emulates the
> instruction, kvm_vcpu_map() should fail on illegal GPAs and inject a #GP
> anyway. However, following patches will change the failure behavior of
> kvm_vcpu_map(), so make sure the #GP interception handler does this
> appropriately.
> 
> Opportunistically drop a teaser FIXME about the SVM instructions
> handling on #GP belonging in the emulator.
> 
> Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
> Fixes: d1cba6c92237 ("KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/svm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 392a5088f20bf..3122a98745ab7 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2277,10 +2277,12 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>  	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
>  		goto reinject;
>  
> +	/* FIXME: Handle SVM instructions through the emulator */
>  	svm_exit_code = svm_instr_exit_code(vcpu);
>  	if (svm_exit_code) {
> -		/* All SVM instructions expect page aligned RAX */
> -		if (svm->vmcb->save.rax & ~PAGE_MASK)
> +		unsigned long rax = kvm_register_read(vcpu, VCPU_REGS_RAX);
> +
> +		if (!page_address_valid(vcpu, rax))

Eh, let it poke out, i.e.

		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))
			goto reinject;

>  			goto reinject;
>  
>  		if (is_guest_mode(vcpu)) {
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 
