Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7739C64C
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511715; cv=pass; b=Ogu2oklJ9l9DPox6BjM4nZ3unGh63JIAQmDMalr5QSbpqQDF864nHwRz6vFKttrIfKF1gEdfzHI1InNYNQJsgy2WFl2hmH97yL5oP5knQ3C+lfWg1ZTKAfO+6TnGeYt/fG9qi4IxDflAhSZ2nMe5fbkqcrkuc5H7ZssgCVhLwOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511715; c=relaxed/simple;
	bh=LqeWjRAjleQEgVlvFe8IGD4Aykcb3VyJFHWIx7meAD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3MqcllZ2ZfxsX+hin3QZkSXkHYg4G0o7RqyiWi3bmABjdmekFPbHY7l4D8Hgv8ve0BxnUirJZcfVnRCFJIbgd0Fzmmlk9Q6JjB9hKFQwc0XSjkjynvLGLO9rZWByXPoDlJV7l8cGgWx6E3WrqjesSws24z+hY//E+GpB1/DdtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcWDexsr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyHOb1xP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcWDexsr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyHOb1xP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775511712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eoWSSC8sEj5p74YK+Y0Flq8SEgfEahb8YNR6rLS40LU=;
	b=HcWDexsruaCK0XTgFGzs21EbTzPCEAHRksmILyNKXKhthz11G81mPTWkCfUWyvGi5BP+J6
	6xDXHNXc2NpSOar3FUQTks36upN1JifL/47vkCPC1AGkUtSetg4Rd1jfKJPFjf8cGaIiim
	XHdwZifjKCWptHbqYHf8sr5ZDB3wwF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-Xj6wn5XLNp6KvgBzUfL8VA-1; Mon, 06 Apr 2026 17:41:51 -0400
X-MC-Unique: Xj6wn5XLNp6KvgBzUfL8VA-1
X-Mimecast-MFC-AGG-ID: Xj6wn5XLNp6KvgBzUfL8VA_1775511710
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so5975481f8f.3
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 14:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775511710; cv=none;
        d=google.com; s=arc-20240605;
        b=FFzSFtyY5NJutRhF9Ef8S3MnpFS1Vx8OzL9gTO4Gw+JYzOUC1+DB5e/3N6zBp6q4fL
         WWKuycT1LQ8JAyF2SzM1919NYOiIBnxaZPv35ssQncWaxIKl28ElW4PQjfNL6c5NqQD6
         x3LsAvWJQn6Rh/1P4PlpOfpljA5BVK4YVkgRZFvMvC9PaRoRSZj6Mr06XOvVDt0/Q+i8
         NV+0SUrI0D2w+y9YJsYYfsi6u1dgPkn7/sVRRa+9dyXcL7sXZ2QJpZfmiI0FLcuQ4fTG
         3MDNYcVgFLfbeQQ21HW+u2/Ky9p15Y+EfQn6NfMmMIgUYWIWaCqktxoNvxD0ccVOmB59
         Xmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eoWSSC8sEj5p74YK+Y0Flq8SEgfEahb8YNR6rLS40LU=;
        fh=+EOT5S0ie4ifhp/cExgOGqCeGCXttDi6FgpQqEsjdj8=;
        b=U/O/kPcLkEoKeRW4bCpelDAMTi9meoP3CVeuOcVRSzhJI7eq+y/9MPDS5hL+3mUITu
         x+12HRyLFah8x6YZ3ftzBWSFqS/UVNioG8jhL7orUjP+X6vlJvxoCfAGWeQOvsf4/DFn
         JpmhnQ8Z7h3SpRja6E2PU3r4a7WOSIZFDW41bYgTZyVGzlPn0XcR7kVeEv23oeG/zj0I
         Z0hHh4osijQEfDy/FrHM572vIB4/VSka/11fU1DRV6A0HG0tH551dUimvrVsw/XCDBOm
         5NPfudVSyQBtc8VfebcFPPUv7aVwOhNIlzxU+goBkUrnSCGpgsuQ8DSXYnjmV5/de5Eu
         WU7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775511710; x=1776116510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eoWSSC8sEj5p74YK+Y0Flq8SEgfEahb8YNR6rLS40LU=;
        b=dyHOb1xPfUE9VvDDNgvYHWmxB6wwXbfmYxU7jaM0b2Gz7s0X6+4iSU+yYEbmu9yeSl
         hEJwrDMYoIcI60+ZQAA33P68+Xctlt4mfSRunkPjuNYryL0AW6QSr71zYd7uNoFUzfiQ
         jwdQ3ZcxT2zCZDRYhnHIlB0NG8qCfW7bxWeh6cjfn/hiCfkKASXaiJBx1uQbuSX5Mx8/
         l5CijEPuhydY6loYB5bmAoNaKPc7bi+/MkTyLoHHVFa6EZL2XS8m/BAMMBod6GQSEMZE
         1dnFc9WqtPfJ+H0+cfTtQO8tMs4CDnz/j2Yu6RRyJ5Dtz9NKAtyIqwl+HVsKqiuMeRjv
         oXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775511710; x=1776116510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoWSSC8sEj5p74YK+Y0Flq8SEgfEahb8YNR6rLS40LU=;
        b=E04/NW2SkF1HAa1St4PujN4VoygOqIqVE8luU484oqQVeMwuPK6RVGvIsUZiGTpuPY
         OzOsyvQIpWwcM7pd5xiirbVZrI3ULn7q/XdqkXZq2TWhr43Qlgx/3X1PhRj96cwER5u4
         JgkH4TBnLMlKUAxCIRXNVsLS+x9JlchOcuhSb3qzhhrCSyz+i2eP3exVtm9C9RDAiEZG
         pX0x4chIk8hVTFQgZN/xLloOHh0Ws3MModyQZGPe4xrTVkeraUlA77V8wQLM/mYPpSYB
         pM8oRHvr7bRFxlpbXTroKLe7YfQeOc48GO81JNNB2mFYgntpQihkpa6mVAk1LSdYhqtC
         zPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeC4hr0KyW/ccfnstAfIxoJx8p1+OCn4XcFkCgYs4rOXxgqvR3LYStl75KLeRzGwEb6h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CWeezKvvj96zgB/aV3TqK/LoSPMOWqU87poISGt+WUaJL364
	sOeRFEv0qFYtZg8qIq8dhjLJG278VfF2niv3F3aVu1KRUXfAq9oUN0rg36xcJQZViuTAhvWcFd3
	9nhSM7nxqrEGzQRDSRckxYXPsU4r2aA01h0Jgt4OfLioGX3DXiobnIc0WsVRipR56ubSRWt8XEY
	kThaB2tyPYWM9SN9CokC+DfTtxXuk8
X-Gm-Gg: AeBDieuTt3tYS8FpVYxBqwnzHZJP+QWCGCDbjhBbpUvGWcutRy2NhUTJ59Ye0LpBCaz
	joc/v8xBpHegNY7XBGrohD8yGJfs5V2yP3PGCnxnX5Vn4UeCrAZFxiVtnjp6xW0p81s9n7fwBXv
	mUEHr5LdYntw/kz3ZhGcFs6bqKy4sezyRyzq05xhf4XXspwiBQ19kpvcMU9Wt6/zPwHrZohRlQi
	sL4uTaJ5yTxl98mrg+A/ZKRpBgcdTye5biaQo3//39bkOl3zEKt4nJSVddqKTaGs5VLoYPGOIbj
	tV00
X-Received: by 2002:a05:6000:26c2:b0:43d:32a:8595 with SMTP id ffacd0b85a97d-43d29294c00mr19903992f8f.20.1775511710181;
        Mon, 06 Apr 2026 14:41:50 -0700 (PDT)
X-Received: by 2002:a05:6000:26c2:b0:43d:32a:8595 with SMTP id
 ffacd0b85a97d-43d29294c00mr19903969f8f.20.1775511709729; Mon, 06 Apr 2026
 14:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com> <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
 <adPRA4ZhnvbaXSn0@google.com>
In-Reply-To: <adPRA4ZhnvbaXSn0@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 Apr 2026 23:41:37 +0200
X-Gm-Features: AQROBzARX7cm2pOzcONamsrvF9MI0sPk77RETM76_dTtAevKjRTQ49z83c779Dw
Message-ID: <CABgObfbLm3FR4f_nv5EyYJx4jwfeBaVgTLhr7P++hmhCP98e3Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Kiryl Shutsemau <kas@kernel.org>, kvm <kvm@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-coco@lists.linux.dev, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"

Il lun 6 apr 2026, 17:28 Sean Christopherson <seanjc@google.com> ha scritto:
> > You're right about fast paths...
>
> Ya, potential fastpath usage is why I wanted to just context switch around
> entry/exit.
>
> > so something like the attached patch.
> > It is not too bad to translate into assembly, where it could use
> > alternatives (in the same way as
> > RESTORE_GUEST_SPEC_CTRL/RESTORE_GUEST_SPEC_CTRL_BODY) in place of
> > static_cpu_has(). Maybe it's best to bite the bullet and do it
> > already...
>
> My strong vote is to context switch in assembly, but _conditionally_ context
> switch R16-R31.
>
> But that second paragraph isn't quite correct, at least not for KVM.  Specifically,
> "need a branch prior to regaining speculative safety" isn't correct, as that holds
> true if and only if "regaining speculative safety" requires executing code that
> might access R16-R31.  If we massage __vmx_vcpu_run() to restore SPEC_CTRL in
> assembly, same as __svm_vcpu_run(), then __{svm,vmx}_vcpu_run() can simply context
> switch R16-R31 if and only if APX is enabled in XCR0.

I might even have patches for that lying around (the SPEC_CTRL part).

> KVM always intercepts XCR0 writes (when XCR0 isn't context switched by "hardware",
> i.e. ignoring SEV-ES+ and TDX guests), and IIUC all access to R16-R31 is gated on
> XCR0.APX=1

Right, fortunately.

> .  So unless I'm missing something (or hardware is flawed and lets the
> guest speculative consume R16-R31, which would be sad), it's perfectly safe to
> run the guest with host state in R16-R31.
>
> That would avoid pointlessly context switching 16 registers when APX is not being
> used by the guest, and would avoid having to write XCR0 in the fastpath.

For now yes, but once/if the kernel starts using the registers there's
no way out of writing XCR0 for APX-disabled guests in the fast path.

If we ignore that, we can keep guest XCR0 all the time for now, and
that would be:
- move SPEC_CTRL to assembly
- not changing XCR0 handling at all
- use XCR0 in addition to just static_cpu_has(X86_FEATURE_APX) to make
r16-r31 swap conditional

> > -     if (vcpu->arch.xcr0 != kvm_host.xcr0)
> > +     /*
> > +      * Do not load the definitive XCR0 yet; vcpu->arch.early_xcr0 keeps
> > +      * APX enabled so that the kernel can move to and from r16...r31.
> > +      */
> > +     if (vcpu->arch.early_xcr0 != kvm_host.xcr0)
> >               xsetbv(XCR_XFEATURE_ENABLED_MASK,
> > -                    load_guest ? vcpu->arch.xcr0 : kvm_host.xcr0);
> > +                    load_guest ? vcpu->arch.early_xcr0 : kvm_host.xcr0);
>
> Even _if_ we want to play XCR0 games,

(which depends on whether we want to be ready for kernel usage of APX, right?)

> tracking early_xcr0 is unnecessary.  This can be:
>
>         /*
>          * XCR0 is context switched around VM-Enter/VM-Exit if APX is enabled
>          * in the host but not in the guest.
>          */
>         if (vcpu->arch.xcr0 != kvm_host.xcr0 &&
>             (!cpu_feature_enabled(X86_FEATURE_APX) ||
>              vcpu->arch.xcr0 & XFEATURE_MASK_APX))
>                 xsetbv(XCR_XFEATURE_ENABLED_MASK,
>                        load_guest ? vcpu->arch.xcr0 : kvm_host.xcr0);

This is a bit more complex however, because in the end early_xcr0 is
precomputing the same conditions and optimizations. For example...

> > +void __kvm_load_guest_apx(struct kvm_vcpu *vcpu)
> > +{
> > +     if (vcpu->arch.early_xcr0 != vcpu->arch.xcr0)
> > +             xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
>
> This is wrong.  The "real" xcr0 needs to be loaded *after* accessing R16+.

... this is actually the same optimization you mention above: the real
xcr0 only needs to be loaded if APX is off in the guest, and in that
case you don't need to load r16-r31. So you can load xcr0 first, and
then any components (for now only APX) that need to be swapped.

> > +     if (!(vcpu->arch.xcr0 & XFEATURE_MASK_APX))
> > +             return;

... Because the loads are conditional on APX being enabled in the real xcr0.

Paolo

> > +
> > +     WARN_ON_ONCE(!irqs_disabled());
> > +
> > +     asm("mov %[r16], %%r16\n"
> > +         "mov %[r17], %%r17\n" // ...
> > +         : : [r16] "m" (vcpu->arch.regs[16]),
> > +             [r17] "m" (vcpu->arch.regs[17]));
> > +}
>

