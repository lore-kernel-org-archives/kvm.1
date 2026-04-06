Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06F30EF7B
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775512806; cv=none; b=dVidlnDTa7Ibhv1rRMSUMujJnskXnGMd0BOO8FuhDw+x2gZ8VLAOgqoxejIhQss9rh/hgy5jCAWGIuEBe69BA0pVA8qd+MEsQnuIT2B85Zd+Vy/pDbWAL2XbGeoTZ+dxvRPZa1vkmNlK+uhGNDh9WQ33Rdm2gYeZRkoS/JWTO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775512806; c=relaxed/simple;
	bh=I8WHx1Pkevx0nIQltAJP8POzcUzeekGHeKLYpatBhrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfJJtVMv+POHYR36eMgCouzdf0vetEWb46OkwyLuJUtToupdatR93K/FGekeByQty2sHePAc5nMnp5CJVF0mFSVMO5XkGViu+2toXuBzp+J0utlfkiXOP1f+SeRoQDpatoJ0oo3mI6/ZViwr8cs08+/RlGG5k2lqRpTl1Z5BqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YF24ORbi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YF24ORbi"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c9364612fso6490677b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775512803; x=1776117603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9nky+GX6oW67ek6Zkv50pIvflG8tKm+1nG7p13qNMk=;
        b=YF24ORbibymXeXosJnUbsepe7c8OMgNj7bJCYy1nzGwgHyr+/6MdhMvvcRNNHadg/8
         IMLoPTfqN6rvccjBu4acTHB2WrkwqKbdzgBZvpRnMLl9wK1tZ6XRludqKOq6+Y5ZyxHW
         lIHc+LtGvS23L7ZrTpT6oWmQ7gtsefeHHaNWrC4aj0iBYNv2pWO+4jQ8dGp2eanUrIpr
         lQy9gEM4aQ8g1T/GwFTR+GfdGFbxYSLt6gorltQ3NUgXm0pTKKaNh5QVcOX6gcdXJP5j
         Yiugu48z+w3LzOUFgbk5X6a8ChHHHG+pqpOx7Tm5uwnk5KD/GEkO1c4Ky9IAYkqgnYP4
         scuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775512803; x=1776117603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9nky+GX6oW67ek6Zkv50pIvflG8tKm+1nG7p13qNMk=;
        b=V1Q5pK//o0mFwssZLurPDgkinOKL+3EAmE/MvW0PPWbieh3oDUqqfwmDloQfWHFrIG
         K7YZyCMwxZs9q4LAi/NyMWEW7zJABUzs1NAPsVMRX1Oq89B2BEk5ytYgxWYdeSkJCSq9
         DyM+jTN/ga2HYN/eLca1/Jx9iDnH2o8rOp5Jz/L8w70Fm2I2TiWgehdypz5Xjbw4MajQ
         rH15SCRWKhxeLU2wIxpHvqSdeiY8v4rNhDlL77IL+DVoatkJlI1eVmFZeqxTfY26Kptp
         BHAB54BleEbwQxIDRu3Iv5gS9GuaRmJrt0qm+VzoYLjyaaPle6Fc2Nx1ZF0Zju1R906T
         D50A==
X-Forwarded-Encrypted: i=1; AJvYcCWa49QSiA9nf+jQoG5NUG1KQv0b7e5swEATYSxFAAO7rC5Ymy9+hGrQbD1E8oBXvt4n1iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6neXSbgIZidX1PwILUIexYxUFU6wJcZ9khACLEXrNeU7Ojn36
	Ft/QPrExj0N+2Ecd+phkXqVulQjzwgDAkbAB3KF75z6LwBd33QUvVj4LfcXdTrW3fKSd5sUI3ms
	/+pEc0w==
X-Received: from pfar12.prod.google.com ([2002:a05:6a00:a90c:b0:823:b9a:9230])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fd6:b0:82c:df25:fbc4
 with SMTP id d2e1a72fcca58-82d0dbcce73mr15006700b3a.52.1775512802481; Mon, 06
 Apr 2026 15:00:02 -0700 (PDT)
Date: Mon, 6 Apr 2026 15:00:00 -0700
In-Reply-To: <CABgObfbLm3FR4f_nv5EyYJx4jwfeBaVgTLhr7P++hmhCP98e3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com> <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
 <adPRA4ZhnvbaXSn0@google.com> <CABgObfbLm3FR4f_nv5EyYJx4jwfeBaVgTLhr7P++hmhCP98e3Q@mail.gmail.com>
Message-ID: <adQs4LQgy3mS2t89@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Kiryl Shutsemau <kas@kernel.org>, kvm <kvm@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-coco@lists.linux.dev, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 06, 2026, Paolo Bonzini wrote:
> Il lun 6 apr 2026, 17:28 Sean Christopherson <seanjc@google.com> ha scritto:
> > > You're right about fast paths...
> >
> > Ya, potential fastpath usage is why I wanted to just context switch around
> > entry/exit.
> >
> > > so something like the attached patch.
> > > It is not too bad to translate into assembly, where it could use
> > > alternatives (in the same way as
> > > RESTORE_GUEST_SPEC_CTRL/RESTORE_GUEST_SPEC_CTRL_BODY) in place of
> > > static_cpu_has(). Maybe it's best to bite the bullet and do it
> > > already...
> >
> > My strong vote is to context switch in assembly, but _conditionally_ context
> > switch R16-R31.
> >
> > But that second paragraph isn't quite correct, at least not for KVM.  Specifically,
> > "need a branch prior to regaining speculative safety" isn't correct, as that holds
> > true if and only if "regaining speculative safety" requires executing code that
> > might access R16-R31.  If we massage __vmx_vcpu_run() to restore SPEC_CTRL in
> > assembly, same as __svm_vcpu_run(), then __{svm,vmx}_vcpu_run() can simply context
> > switch R16-R31 if and only if APX is enabled in XCR0.
> 
> I might even have patches for that lying around (the SPEC_CTRL part).
> 
> > KVM always intercepts XCR0 writes (when XCR0 isn't context switched by "hardware",
> > i.e. ignoring SEV-ES+ and TDX guests), and IIUC all access to R16-R31 is gated on
> > XCR0.APX=1
> 
> Right, fortunately.
> 
> > .  So unless I'm missing something (or hardware is flawed and lets the
> > guest speculative consume R16-R31, which would be sad), it's perfectly safe to
> > run the guest with host state in R16-R31.
> >
> > That would avoid pointlessly context switching 16 registers when APX is not being
> > used by the guest, and would avoid having to write XCR0 in the fastpath.
> 
> For now yes, but once/if the kernel starts using the registers there's
> no way out of writing XCR0 for APX-disabled guests in the fast path.

Why's that?  So long as KVM uses vcpu->arch.regs[R16-R31] as the source of truth
when emulating anything, there's no danger of taking a #UD in the host due to
accessing R16-R31 with XCR0.APX=0.  There's not even any danger of consuming stale
guest state, e.g. in case KVM screws up accesses R16-R31 instead of generating #UD,
as the value in regs[] will still be the guest's last written value.

If we wanted be paranoid, we could add sanity checks to ensure R16-R31 don't show
up in hardware-provided informational fields, but to some extent that's orthogonal
to how KVM maintains guest values.

> If we ignore that, we can keep guest XCR0 all the time for now, and
> that would be:
> - move SPEC_CTRL to assembly
> - not changing XCR0 handling at all
> - use XCR0 in addition to just static_cpu_has(X86_FEATURE_APX) to make
> r16-r31 swap conditional
> 
> > > -     if (vcpu->arch.xcr0 != kvm_host.xcr0)
> > > +     /*
> > > +      * Do not load the definitive XCR0 yet; vcpu->arch.early_xcr0 keeps
> > > +      * APX enabled so that the kernel can move to and from r16...r31.
> > > +      */
> > > +     if (vcpu->arch.early_xcr0 != kvm_host.xcr0)
> > >               xsetbv(XCR_XFEATURE_ENABLED_MASK,
> > > -                    load_guest ? vcpu->arch.xcr0 : kvm_host.xcr0);
> > > +                    load_guest ? vcpu->arch.early_xcr0 : kvm_host.xcr0);
> >
> > Even _if_ we want to play XCR0 games,
> 
> (which depends on whether we want to be ready for kernel usage of APX, right?)

No?
