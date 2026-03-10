Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5F31714B
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167749; cv=none; b=RGMEmtEGfh6GYTBskRIepMTGoKBjNIwwkGyFmNcbqizK+9bSerWgXYib99Ox8h/NxcEWL9VdQ8U/OoSzQ5YAkwxnE94HMSf8hzKXkCoou46QqTbzcVqp9gYw8oPn70COr5l5ZhfUBTiPFgBs64Up0wwZPkfPHP70Omsj/xgpEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167749; c=relaxed/simple;
	bh=p07bGoSJp/3R8scxFTy3n7KW0vlkOxH9d+YGi8txE3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZIoQzdAB/i7dT652uzALZTVAOrDnMT5gR7f25HQqQQHsezeBoCELKT2s+fwAMZofWOwovLLge9zIlznVgpY25ngtiEvAcV4mY19+xeABmuEM+HfFzN3rbvz4VRt3mH4qePkFpr0/s5KHQHatBXyFO4ClBTGWSNBF6GLXJCcSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iR1MCYRm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iR1MCYRm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae3e462daeso52448325ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773167747; x=1773772547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfTR7SOyttNQka6EYoAXlvlW8tJI1oDrp8f/Qn+Tpes=;
        b=iR1MCYRmt4opy/KXb4T8d4LEDqKa+ROvC5C9wtRfxezUivrBnC0MkTxgt/heGcWnjk
         2NIY8zm8FMRRlMdqREx5E3v3z3bX5Ib/rXDBZUeoswTPjURzMPluHpCO07YWHuxhGjHr
         QYxy6ySbfkNZ80ycw/F71sNsG2jVZachaSafliHJ93+3xxOmgdfEUJTLcdiTkOojXvA9
         EL97EmdAs4A35e6mMQ2Q3M2zaO0hzV8UYwkv3vA+kXsgEEKOaZxVwpSZ357wEgqJCIvJ
         vnfSZNuwcz3n0VbuyQYXaoWWJb8UlhJ7mPPAHqFEu+sET2Idc3VkepxcCVtwjOkFxkih
         MwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167747; x=1773772547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfTR7SOyttNQka6EYoAXlvlW8tJI1oDrp8f/Qn+Tpes=;
        b=TRuclhfNwlvNAYMnQh1eKyD9ab5Wv9mayG8WmoB9AQLGVrlVi65MLn/bG04710t+OW
         n6rwOF2+EGC29ApPV7wmU21RvGh4ubo396sue/0LUhUrYvGd1Ud9HU6trTepHDA8Cz1F
         8gqj6jeoQXfywI/8+79GVuIm7trBIE5e1wIaroUfO+rgd6Ngka9soIum3foE+vWUzyKc
         5REwe8eA5LGkDFaHbv5Ria9BA45be+8CfUm86Bc0ErZ9BHEEpFE12eMUqIFi5T5hMyGd
         PL2Gkzy7PZm+l5ab31i2tYnxTpTwh2yguO/KE4JW5DyP/KEcPvm2QIZehfGfHNbe8kTy
         5Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCXH5LBM7aa6jDXsBQsQj9cfKErZ5sRVRKMk6TbVZU2/vQaRYNLbBWeF8U7LfbBkMlyYk6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/hocriJolx5y0fGjEYq5bBn4PbG17R69eNLoMMYWUKd+UzTU
	/eSlEBH6m4g1Dj6nS4PVgsuXlHLNMWQIexKjn0eNpoDuoHCfpGjjCvpcZqq4npW0QCZ9j3PrHLT
	5fLpY2Q==
X-Received: from plge15.prod.google.com ([2002:a17:902:cf4f:b0:2a8:71ec:6799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1105:b0:2ae:4800:141a
 with SMTP id d9443c01a7336-2ae824dd98fmr167704355ad.32.1773167746578; Tue, 10
 Mar 2026 11:35:46 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:35:45 -0700
In-Reply-To: <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203190711.458413-1-seanjc@google.com> <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com> <abBYiODdL4405KbB@blrnaveerao1>
 <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com>
Message-ID: <abBkgY9W4_PD1uef@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Tom Lendacky wrote:
> On 3/10/26 12:48, Naveen N Rao wrote:
> > On Tue, Mar 10, 2026 at 12:36:09PM -0500, Tom Lendacky wrote:
> >> On 3/10/26 12:17, Sean Christopherson wrote:
> >>> On Tue, Mar 10, 2026, Srikanth Aithal wrote:
> >>>>
> >>>> Hello Sean,
> >>>>
> >>>> From next-20260304 onwards [1], including recent next kernel next-20260309,
> >>>> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
> >>>> failing. However, on EPYC Milan, the SEV-ES guest boots fine.
> >>>
> >>> ...
> >>>
> >>>> Bisecting shows that this commit is the first bad one. When I revert it, I
> >>>> am able to boot the SEV-ES guest successfully on both Turin and Genoa
> >>>> platforms:
> >>>>
> >>>> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
> >>>> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
> >>>> Author: Sean Christopherson <seanjc@google.com>
> >>>> Date:   Tue Feb 3 11:07:10 2026 -0800
> >>>
> >>> Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
> >>> blame the architecture for not simply making CR{0,4,8} intercept trap-like.
> >>> Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
> >>> huge gaping security flaw, especially for SNP+.
> >>>
> >>> Anyways, this should fix the immediate problem.
> >>>
> >>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> >>> index 33172f0e986b..b6072872b785 100644
> >>> --- a/arch/x86/kvm/svm/avic.c
> >>> +++ b/arch/x86/kvm/svm/avic.c
> >>> @@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
> >>>         vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
> >>>         vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
> >>>  
> >>> -       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> >>> +       if (!sev_es_guest(svm->vcpu.kvm))
> >>> +               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> >>>  
> >>>         /*
> >>>          * If running nested and the guest uses its own MSR bitmap, there
> >>>
> >>> Argh!  The more I look at this code, the more frustrated I get.  The unconditional
> >>> setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't
> >>
> >> AVIC is disabled for SEV guests (see __sev_guest_init() and the
> >> kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV) call at the end of
> >> the function).
> > 
> > AVIC gets inhibited globally, but continues to be enabled on 
> > vcpu_create() opportunistically -- see kvm_create_lapic(). It only gets 
> > disabled later during vcpu setup via 
> > vcpu_reset()->svm_vcpu_reset()->init_vmcb()->avic_init_vmcb()
> 
> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
> that CR8 writes shouldn't be trapped.

Yeah, I forgot that (obviously).

But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.
