Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3D13D539
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179238; cv=none; b=ZD1c3ZRx6Htl6gEXzrkiTjbraFpyLcvQ9Zj/+Sp2ZDdSMDO06YO2tZoMjCXkP+vnHTTyTI5eKOl9S7rnQvozTEv8X+ddc1P6mOQqcz5ZXyHNeuy3oXqpjoLhLex8Xc0nUvNIfuRc3zmJNfO0rqiLrgmu73Ae1q5hJBHaiCRX2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179238; c=relaxed/simple;
	bh=P67FYLXAJXpU1JgIrkarwLwNT0d7c7oo7LGWh9f3zc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ap/fxc1+/mApAh5mlJMCTmUaX0lzehfHxJuMI+heCsJFredahcMyj1BOLSxZ58SOxt93EOGs/g8ZQPND7x3wNLeRI+lZkQG1e+oNjQG1wlOFN3Zr9IaNG0wZ13tpx4LGSzrjEAbWbpkRpD6qfZ5BO4F/M7QBPvFS+h3ZGJ2wFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQwl40vH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQwl40vH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c648d3ca8so3310029a91.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782179236; x=1782784036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXrOsG0sOKwQxPybxGcKKGAUN4JOfTPB1ofkSmrXZc0=;
        b=fQwl40vHxvthLYSBWx2PwM1bsxXrQQZoOr26H/tyGnPwNKDxn8YS1dMR///rmsPsHb
         tLvwGBEZ3nCoO65M3RAT1JZ4P1ss92cLRHCq41GftTl5AgRFOX2T2mBITVl+8ToLH2vE
         lWW4d1K4pNnPsRe54azNPOIWFeesKUyzismtzzIcB98lOv9fRG/MH1BQOwR32PrvvIDR
         g2r3Jrvou1j17PUaqfrdwMiBlAY6u+YT0+rYv5JWi2/edYTp18TghkBvvMgZ1TIApBS/
         2ERvS/oYKpQEKvwVwu7tNo/EnBRLRiHVhs7vQehC1h/C4DZH2PHG1CAbqawGplWv9OdX
         U3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179236; x=1782784036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXrOsG0sOKwQxPybxGcKKGAUN4JOfTPB1ofkSmrXZc0=;
        b=cbPydNm2JskOS5SGIZw5KGbAu6N40J7l5/byTOO8fYCpqdTMdOUnUXZPkuqFFbTLcY
         vHHcgswuMqm/S6seDOAHKsdLsbfzuJlx6mmYqg/Djm/S6lZXQzFzw5ngpVH7wXwwxk4W
         Brice7V88IQdk4cLxR+ELQir8+M8x5ltlLqWTZ86yVanQYm0uc8Udb7PqeK3+ArxzIfe
         DWBAc6JkoV2E81V3Y+shZ/wdIVjG1RIUVU2PpkvmX/nhhCM+flHdOit7vsnt5IBHFbAq
         1XwSKMDQTMI1fQWU5cW1wt+Pfonjbte9vxqCS0oyDI+KTwFkjLrNNWZ0o0J8pD1e16/7
         XWgQ==
X-Forwarded-Encrypted: i=1; AHgh+Roq2y760FuiFt6m0xR1tDgUcpRQmSNAXw0geYSI6WzcvWXo1bMZekbyFbC7tsGgrtFJIHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zJRzvFk4eLS4UHyTd7S5V2/QJu0u46KP+NsXkqesey3WByKN
	hixIHRutYot9rQA0V3W9qTAqkamCjmP3ZhhygKy7jrrK4izsrahzl4ONn1j2NZ0KkxgIdxw3/3R
	D7JaGNg==
X-Received: from pjzr16.prod.google.com ([2002:a17:90b:510:b0:37c:64eb:faf7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3809:b0:369:1dcf:4a46
 with SMTP id 98e67ed59e1d1-37d162c3d15mr16740820a91.25.1782179236220; Mon, 22
 Jun 2026 18:47:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:47:15 -0700
In-Reply-To: <20260619204642.F1A691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
 <20260619203107.2752678-2-main.kalliope@gmail.com> <20260619204642.F1A691F000E9@smtp.kernel.org>
Message-ID: <ajnlo3vf-Qcai0jz@google.com>
Subject: Re: [PATCH v2 6.1.y 1/3] KVM: nVMX: Add a helper to get highest
 pending from Posted Interrupt vector
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Nicholas Dudar <main.kalliope@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index bdc462944cb08..7d8e18dbe8531 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> [ ... ]
> > @@ -3818,8 +3819,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
> >  	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
> >  		return 0;
> >  
> > -	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
> > -	if (max_irr != 256) {
> > +	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
> > +	if (max_irr > 0) {
> 
> [Severity: Medium]
> Does this condition inadvertently skip vector 0?

No, it deliberately skips vector 0.

> The commit message states that pi_find_highest_vector() returns -1 to indicate
> no interrupt pending, so max_irr can be -1 or 0-255. By checking max_irr > 0,
> the code skips processing if vector 0 is the highest pending interrupt.
> 
> While vector 0 is an invalid APIC interrupt that hardware typically ignores,
> skipping it here means KVM does not call __kvm_apic_update_irr(). As a result,
> vector 0 could remain stuck in the PIR array instead of being cleared, which
> diverges from the lockless PIR/ON protocol.
> 
> Should this condition check for max_irr >= 0 or max_irr != -1 instead?

Nah, because vmcs.GUEST_INTR_STATUS's RVI will never satisfy:

  RVI[7:4] > VPPR[7:4]

and so the interrupt (that shouldn't/can't exist) will never be delivered, even
if the KVM check were "fixed".  If anything KVM could do "max_irr > 15", probably
with a #define of some kind instead of an open coded literally.

Regardless, that's something to tweak in upstream, not in LTS backports.
