Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EB42A792
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577264; cv=none; b=kEhIwyU1CBlnI5U2SsrLfnI5VLiNShvW3M7W7GtmJ9dR+rvchz5DgTlvanR0rcsx6omcMi4MtLcyCG0jzwPCL3+Ir3knYxXPCjfoSlEt6IjMGKqhgb+nHebcazZ2vlBnyRNy3rFxQGCIv8uBaCVVx0dmpdb0seXs6boyCne8jRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577264; c=relaxed/simple;
	bh=tYCpqhBZlCUc6Tog6SiC3lObFUSK5RXby6sqyW07168=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eyz19D0vloyxsdcH/m824PfNHOgvR8oyJbAhCQGt01D2tvOH75iflTVuC/+WZzuXEphfcD2IoSvF/Q1SPHfIDMhC45YdlQ3bvPPuhem6nSoqPLb955GKdbiO/ESP1oGPun+INykFFea8AVt4jd3hqSSpApZyGUvx9xZtCD7S3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTY01kF8; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTY01kF8"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cceabd70f5so40203185ad.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577262; x=1787182062; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjHq3xrElL8l+jG2YiN+k2y4tw8Htmrb5cfreR/fqHk=;
        b=WTY01kF88yzwraHRVUoYvu+NouK/pdiEcdQIZ/OkIU03CLX8xPRO7z9Qg189yjJc2T
         JnEXoZj/jc+PcZ37XuUB86Y/T/2x8Jc4M2rAq0jjMiTrny3a+JRuGjfAMI+lLCXNRF3Y
         d9PIRziE87dyEeOJXy6QczUVAhOY02R+TT3SqszTwzUGyzjT2vJHjSGX5KaM5Bc3zjFH
         lHEswvO7BVWMSJhOuO6A5STYfbQ2IbXiJE46OfUcKa/AMpf/E+hlyB/Lws44VRytJr3P
         k20Ek878Br5oI/CZI0ZA1AYVXkCd4WMUHKy+TdJL4lj9NT5ng0cKimYWibztoAdmgU97
         +Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577262; x=1787182062;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjHq3xrElL8l+jG2YiN+k2y4tw8Htmrb5cfreR/fqHk=;
        b=ZVgpA3bFJ4XsDc/Hpcxfc6Z7w0vS8Vc/vfMp0IRADoX3+aLZDWarqUtrCV0Yid2IJp
         pVvMDABgy34dTmuS+Wqw4XPEiTDDwFzzJ+o3by+tUlS5glamVmXYlvkYOWIKBrQ9hE3i
         B4JVTB3UusA44SZuElZ9IX4bQm554AGFQobOc/rQm5P8NpJMymf5FhwHP5RIRjWnHS3S
         fU5hXi9fLhxIA1pCP2ZPLCrCUZjERtTkXeoTCu+SbEl4YUYWIwUj2STWv8lJIGaB/Nfw
         XU9J7bNfAS2/5D4xtpiyoaH5DsyKFHrnRqVFYTlloQCICTBQN8CY0xIfBqsbTwbGOMo0
         sILw==
X-Forwarded-Encrypted: i=1; AHgh+RrY4rubhH2J9ZUrrjC3dC/scw0HlDNlVxJeXBOv1Sz9WKwuh4Y2seM386Yn7/AnPSVgPRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAieEeKIjNU/SZVpkIRSCCu41Gsq+oQa3+GqMbthepkEvCAT+n
	JCubKrPnboyDH/OLa3ceCuPK8/BHjpSZzA9cLDXxiP3EEhAweXhLwijFU3Ai2aAtDxB4C7HlCfy
	IUxCoBA==
X-Received: from plly4.prod.google.com ([2002:a17:902:7c84:b0:2d1:1cee:1611])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80f:b0:2c9:ceb9:865b
 with SMTP id d9443c01a7336-2d37ebccf8amr15331195ad.21.1786577262140; Wed, 12
 Aug 2026 16:27:42 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:27:41 -0700
In-Reply-To: <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com> <aauJ80pZrw_SfF31@google.com>
 <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
Message-ID: <an0BbcxUNRKqnUSJ@google.com>
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

+Nikunj

On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
> On 07-03-26 07:44, Sean Christopherson wrote:
> > On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
> >> Set the FRED_VIRT_ENABLE bit (bit 4) in the VIRT_EXT field of VMCB to enable
> >> FRED Virtualization for the guest. This enables automatic save/restore of
> >> FRED MSRs. Also toggle this bit when setting CPUIDs, to support booting of
> >> secure guests.
> >>
> >> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> >> ---
> >>  arch/x86/kvm/svm/svm.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >> index 954df4eae90e..24579c149937 100644
> >> --- a/arch/x86/kvm/svm/svm.c
> >> +++ b/arch/x86/kvm/svm/svm.c
> >> @@ -1144,6 +1144,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
> >>  	save->fred_ssp3 = 0;
> >>  	save->fred_config = 0;
> >>  
> >> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
> >> +		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
> > 
> > This is completely unnecessary, no?  CPUID is empty at vCPU creation and so FRED
> > _can't_ be enabled before going through svm_vcpu_after_set_cpuid().
> 
> Hi Sean,
> 
> You're right for vCPU creation, CPUID is empty there and the hunk does
> nothing, so I dropped it in v2. While preparing v3 I hit a case that does
> need it though, a triple fault:
> 
>  1. The guest enumerates FRED, so the FRED MSRs are passed through and
>     FRED_VIRT_ENABLE is set in virt_ext.
> 
>  2. The guest triple faults and KVM intercepts SHUTDOWN.
> 
>  3. shutdown_interception() does clear_page(svm->vmcb), which wipes
>     virt_ext along with the rest of the VMCB, and then INITs the vCPU.
> 
>  4. init_vmcb() runs, but svm_vcpu_after_set_cpuid() does not.
> 
>  5. CPUID still enumerates FRED, so the intercept recalc puts the FRED
>     MSRs back into passthrough.
> 
>  6. Nothing restores FRED_VIRT_ENABLE, as only svm_vcpu_after_set_cpuid()
>     ever sets it.
> 
> 
> So the guest ends up with direct access to the FRED MSRs while hardware is
> no longer context switching them, i.e. it can clobber the host's FRED state.
> 
> Setting the bit in init_vmcb() is the smallest fix I came up with, so I'd
> like to add the hunk back in v3.
> 
> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
> while setting intercepts? Or is there a better way to deal with this?

Take a hard dependency on an upcoming APM update that states the control area
is valid after shutdown, and rework KVM to not clobber control fields on shutdown
interception.

Nikunj, I was actually expecting that to come with the PML series.  But looking
back, I see that you proposed a targeted fix for PML[*].  That's probably fine?
Rewriting shutdown interception just to avoid a one-liner is a bit ridiculous,
but on the other hand, we really should do that sooner than later, because PML
obviously isn't the only thing affected by KVM's conservative read of the old APM
wording.

[*] https://lore.kernel.org/all/2f86d83c-e727-4be0-82ee-9a76e77c4ab6@amd.com
