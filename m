Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45C20E334
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242832; cv=none; b=IKzdS671HnUP6/CLdkYNltLh/nvmJor7SFmc3+cXtldNp1dDz1neNaXujXr9b/S5noXUq/pIkQnWed50jJW42Mkul9fvNFPL0nhwmDsrK9UKbqdx6rBjAgrRYXsZJ+UC5X8oG0555qqeVv2Vworl1uTXsza9OOL62XhnmgIatxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242832; c=relaxed/simple;
	bh=l862pD+7NkjA7LQ+56wep4XBVYr2X6qzTRFTjQig/eA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mk9yMoPFbsIy9EFRcC41SWSmziE1cS+TBEkPp/EGtHe4YmroNm8NZ2OJy2t9zRZfvh2dVK9KP78Gnxw6A8Be2rSkCcjrk/FnYSCRnaS1czrUgb9v//DCfbICdZpIOL+BpZs4hJa8XTpWYkzqF3J4QQOsiqcCzVF5NegEi2igOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dL7qk/2r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL7qk/2r"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da86144daso1971850a91.3
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775242829; x=1775847629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knlN+W0CzK/CyNZz3pOxkwtQ+Qid0Ab36uDhW/RYs4c=;
        b=dL7qk/2rtow6oOStcw5cvuByVezQh+8RYxNIdDT5vswclkBSR8/igoadByGK0OUAFV
         hThqLmSCw2DaySj/rOjIkszccBRulzN+uzCyYRCSdAafxqXUfcGFucqYBweCbFsXiwAI
         OV46AZWXkRbImvNXk5rPuwkuiTf6QxAyF0PXw5pPLHZNYer8RiAHGt6B65B0kHjvSad0
         aoeUPdijMawS2V0i3SEdgODpVynB6/UXXuEf0iA8iEJz5UH/qMdbuUSCsVTA8iC/7uf4
         XEt2O+waZ0Ytg4ca028zXlb1W6fULQ098XtlsWJFSSXsyy3dC5hcGPbbSsxxqHl8R7Lr
         5Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242829; x=1775847629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knlN+W0CzK/CyNZz3pOxkwtQ+Qid0Ab36uDhW/RYs4c=;
        b=K6eaqE/6BqUZS1Abn+PB6yzZvgf9Wfdzv0qOMzGG7JKUXNDqz8xk41Pq2PlW7DY9qP
         oWPeib3/cT3xfIuTsN6YtNd4ZuITEoG7sINc5lLX3r1pUGZOn7B8tfzYlEC7xu1y2Sqz
         pTbewpShm+sA49nTVbci8HZonwbUm7F84cJ30EtkVtOZVJdNgzIhuulMl9WuEQDmKP3D
         JNG+O5vADmMTOxRYU4chSkVpltpcJU2REhO1pMerBy9AVqv9HH4H4NfN1tXxSWZ8O5pY
         SxYgd0ByxTKkeQtwSOXYCRgaSFNtzWB9bLTBhwXNvAX4+NYseLRsktqpJQ0SMw2/GEoN
         HvSw==
X-Forwarded-Encrypted: i=1; AJvYcCX9q3WgqdsL3CSut+LPD9WGgt9+srFYVNPttV2UT4eInD6Mxj/oBgT6JyUthYJn1qIj8j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNEnEOTT8zfTcGQip/HEz8yatVe9kq/1hoBrjgSMg8+zxOT6H
	0ofewlUJPy9/Tsx7A7e1k1TgpYlkqPLwh5ixnhTfynx+6C4y6RLZa/trMZJrc2GjKJG4zBlENMP
	WmLmhlQ==
X-Received: from pgea29.prod.google.com ([2002:a05:6a02:539d:b0:c73:fb05:a2e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2447:b0:395:7fb:9362
 with SMTP id adf61e73a8af0-39f2ee0183amr4000505637.19.1775242829259; Fri, 03
 Apr 2026 12:00:29 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:00:27 -0700
In-Reply-To: <ac_7Yg-Ma4UR2nIz@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-4-yosry@kernel.org>
 <ac_7Yg-Ma4UR2nIz@google.com>
Message-ID: <adAOS-dKq72VClS_@google.com>
Subject: Re: [PATCH v4 3/9] KVM: SVM: Properly check RAX on #GP intercept of
 SVM instructions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 03, 2026, Sean Christopherson wrote:
> On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> > Replace the PAGE_MASK check with page_address_valid(), which checks both
> > page-alignment as well as the legality of the GPA based on the vCPU's
> > MAXPHYADDR. Use kvm_register_read() to read RAX to avoid
> > page_address_valid() failing on 32-bit due to garbage in the higher
> > bits.
> 
> Nit, not "on" 32-bit, correct?  I think you actually mean "to avoid false positives
> when the vCPU is in 32-bit mode, in the unlikely case the vCPU transitioned from
> 64-bit back to 32-bit, without writing EAX".  Because regs[] is an unsigned long,
> so the upper bits of save.rax will be cleared by svm_vcpu_run() on every VM-Entry,
> and it should be impossible for a purely 32-bit guest to get a non-zero value in
> RAX[63:32].
> 
> And even for a 64-bit host with a 32-bit guest, the only way to get a non-zero
> value in RAX[63:32] while in 32-bit mode would be to transition from 64-bit mode,
> back to 32-bit mode, without writing EAX.
> 
> > Note that this is currently only a problem if KVM is running an L2 guest
> > and ends up synthesizing a #VMEXIT to L1, as the RAX check takes
> > precedence over the intercept. Otherwise, if KVM emulates the
> > instruction, kvm_vcpu_map() should fail on illegal GPAs and inject a #GP
> > anyway. However, following patches will change the failure behavior of
> > kvm_vcpu_map(), so make sure the #GP interception handler does this
> > appropriately.
> > 
> > Opportunistically drop a teaser FIXME about the SVM instructions
> > handling on #GP belonging in the emulator.
> > 
> > Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")
> > Fixes: d1cba6c92237 ("KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround")
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/svm.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 392a5088f20bf..3122a98745ab7 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2277,10 +2277,12 @@ static int gp_interception(struct kvm_vcpu *vcpu)
> >  	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
> >  		goto reinject;
> >  
> > +	/* FIXME: Handle SVM instructions through the emulator */
> >  	svm_exit_code = svm_instr_exit_code(vcpu);
> >  	if (svm_exit_code) {
> > -		/* All SVM instructions expect page aligned RAX */
> > -		if (svm->vmcb->save.rax & ~PAGE_MASK)
> > +		unsigned long rax = kvm_register_read(vcpu, VCPU_REGS_RAX);
> > +
> > +		if (!page_address_valid(vcpu, rax))
> 
> Eh, let it poke out, i.e.
> 
> 		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))

Argh, looking at the rest of this series, and at KVM's existing code, having to
use kvm_register_read() is awful.  This really should be able to use kvm_rax_read(),
but that won't handle the truncation.

There are only a handful of likely-benign goofs due to this mess, but there is a
pile of manual truncation and casting going on.  In addition to _raw() variants,
and mode-aware defaults, add "e" versions would be helpful, as many of the
explicit truncation flows are cases where e.g. EAX, ECX, and EDX are architecturally
accessed.

I'll put together patches, and think more on how to handle this series (the
dependencies aren't terrible, but they certainly are annoying).  I'm tempted
to squeeze this into 7.1 to make future life easier...

> 			goto reinject;
> 
> >  			goto reinject;
> >  
> >  		if (is_guest_mode(vcpu)) {
> > -- 
> > 2.53.0.851.ga537e3e6e9-goog
> > 
