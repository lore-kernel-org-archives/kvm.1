Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630113803E9
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489287; cv=none; b=Nb2zR44+weSB+62bZXj5In81vBdvVBo4g8bemRx5f1uLK9uujkxzg2wnhFY239pxVdH2p2BdSgvVA+ASDQxF+S4uyPIMCHTN1/c+Z7RgvwWRwDJGYId7TkYv78wG7ellL4sfzXTJxv1E7uRduaxxs8zHGHZdDZWJFOLqT5KBC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489287; c=relaxed/simple;
	bh=6LCgBNgKj6hIuQM0MBfpWJ8Gv1PrS0Ny0OnBP+DkHs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9B8OSS2PDDaVv5V2LJYHBD8XpYCXKZvTDh17gOc0307U7oCNVLH5jgDwdO2TYXP0uwTYoyIsMFD+YTanJ+rt+njnTcJ3n6dJ+RwMgObfSOGnai6uENJ3+kFuFGKRfACBYX1td2TtnKgY5VUEqvnYjpk/AE3hr6Nn0xB+LGV2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOJQgJCW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOJQgJCW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso1513623a12.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775489285; x=1776094085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEHfg1OZfS+Y9HeFZv48ajvxZYCSphKNKK/6SLJOTyE=;
        b=aOJQgJCWbMnQpNlZ9tCyd9jLSN/6FfmSuIBUFm5k3ENa6605ATsceWPMizvv0SNOMv
         bISID4avngRO6uaMexZ9LHi2FOai2elCSYUhonhhRZ/+hRN6ascqxdDxh5JOPgMicgnK
         zV5EyHuqNhi61KvOQ/EJFy3BlOBBFr9Zw2QTDlFIAlivcsNqh5XigxkaTsIDt3/WOLKM
         WPAhDkvWBVelG4EthIEprfH1RCOU1p6xETQZORksCytT9/Jnrsh+20Kc1ho9g/Lk1fXs
         v9SKDTddtKHjo/gx/23/akp2D1g9voPxsIeI31tniaXPt7Ep7FTQmtGGMXkNLwhrtBsq
         onWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775489285; x=1776094085;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sEHfg1OZfS+Y9HeFZv48ajvxZYCSphKNKK/6SLJOTyE=;
        b=TEhlHWMUxMlkYOl7EMUws4WSDuRkabQnBHMbpu71KWdsRdgw9mhMusm1oT1341hPoU
         xRn/24JEA4h61Ae3Pao+Qd7XCg6z0xTOpR261CuxBxyg87AN8AnSS0EzBZ4pzfFSHRRD
         8javAsdOdlVLyOmpjsknASpvmCBfKjgf5u4/i8CuNOGhv9C0dKz4ma59ZgdISaZGraDa
         L7zV92aJxxoyBTPUjEtjGsdcAxLopYi2/J/dNHSXe+GdIoGf/RMp2mT/I77GrkV3JoQ9
         9eIVyHZ2vXbKQExiA/PPhzC/N8c1qk+XBPaR6HIsKI1SCvgI2593d2EQKGhgLUm5uZIr
         pO0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ7GEOzKkW93fKg4TNu6NXUnZI96Uj6pL99iZ53JdwScufApU20rhJa0OYbu62ZMbLNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMhZ9uvnZ8N0K7HZKW2h2oJ79esXL4H/lSk9fua3nWuvc5pIO
	PzffNNFpkgc1/eJZ0eTpWCHferGBeUuyB4KoeEwyC+1QTus/sOMgfDCbwuddKCqH2bSutiqn7U/
	s0xjJmw==
X-Received: from pfbde20.prod.google.com ([2002:a05:6a00:4694:b0:82c:6e7c:ac6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8018:b0:82c:215d:5e9d
 with SMTP id d2e1a72fcca58-82d0db6bfc5mr12524946b3a.32.1775489285334; Mon, 06
 Apr 2026 08:28:05 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:28:03 -0700
In-Reply-To: <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com> <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
Message-ID: <adPRA4ZhnvbaXSn0@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Andrew

On Sat, Apr 04, 2026, Paolo Bonzini wrote:
> On Sat, Apr 4, 2026 at 12:05=E2=80=AFAM Chang S. Bae <chang.seok.bae@inte=
l.com> wrote:
> >
> > On 4/3/2026 9:03 AM, Paolo Bonzini wrote:
> > >
> > > But until the kernel starts using APX, I would do the save/restore ne=
ar
> > > kvm_load_xfeatures(), because __vmx_vcpu_run()/__svm_vcpu_run() would
> > > have to check whether xcr0.apx is set or not.
> > Right, I'd much prefer this. Then, it requires to audit whether any
> > fast-path handler could access EGPRs.
> >
> > But there are cases with the new {RD|WR}MSR (MSR_IMM) instructions that
> > appear to access GPRs. Because of this, the EGPR saving/restoring needs
> > to happen earlier.
>=20
> You're right about fast paths...

Ya, potential fastpath usage is why I wanted to just context switch around
entry/exit.

> so something like the attached patch.
> It is not too bad to translate into assembly, where it could use
> alternatives (in the same way as
> RESTORE_GUEST_SPEC_CTRL/RESTORE_GUEST_SPEC_CTRL_BODY) in place of
> static_cpu_has(). Maybe it's best to bite the bullet and do it
> already...

My strong vote is to context switch in assembly, but _conditionally_ contex=
t
switch R16-R31.  All of this started from Andrew's comment:

 : You can't unconditionally use PUSH2/POP2 in the VMExit, because at that
 : point in time it's the guest's XCR0 in context.  If the guest has APX
 : disabled, PUSH2 in the VMExit path will #UD.
 :=20
 : You either need two VMExit handlers, one APX and one non-APX and choose
 : based on the guest XCR0 value, or you need a branch prior to regaining
 : speculative safety, or you need to save/restore XCR0 as the first
 : action.  It's horrible any way you look at it.

But that second paragraph isn't quite correct, at least not for KVM.  Speci=
fically,
"need a branch prior to regaining speculative safety" isn't correct, as tha=
t holds
true if and only if "regaining speculative safety" requires executing code =
that
might access R16-R31.  If we massage __vmx_vcpu_run() to restore SPEC_CTRL =
in
assembly, same as __svm_vcpu_run(), then __{svm,vmx}_vcpu_run() can simply =
context
switch R16-R31 if and only if APX is enabled in XCR0.

KVM always intercepts XCR0 writes (when XCR0 isn't context switched by "har=
ware",
i.e. ignoring SEV-ES+ and TDX guests), and IIUC all access to R16-R31 is ga=
ted on
XCR0.APX=3D1.  So unless I'm missing something (or hardware is flawed and l=
ets the
guest speculative consume R16-R31, which would be sad), it's perfectly safe=
 to
run the guest with host state in R16-R31.

That would avoid pointlessly context switching 16 registers when APX is not=
 being
used by the guest, and would avoid having to write XCR0 in the fastpath.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 959fcc01ee0f..9a1766037b6f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -887,6 +887,7 @@ struct kvm_vcpu_arch {
>  	struct fpu_guest guest_fpu;
> =20
>  	u64 xcr0;
> +	u64 early_xcr0;

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0757b93e528d..69abfdd946dd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1220,9 +1220,13 @@ static void kvm_load_xfeatures(struct kvm_vcpu *vc=
pu, bool load_guest)
>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE))
>  		return;
> =20
> -	if (vcpu->arch.xcr0 !=3D kvm_host.xcr0)
> +	/*
> +	 * Do not load the definitive XCR0 yet; vcpu->arch.early_xcr0 keeps
> +	 * APX enabled so that the kernel can move to and from r16...r31.
> +	 */
> +	if (vcpu->arch.early_xcr0 !=3D kvm_host.xcr0)
>  		xsetbv(XCR_XFEATURE_ENABLED_MASK,
> -		       load_guest ? vcpu->arch.xcr0 : kvm_host.xcr0);
> +		       load_guest ? vcpu->arch.early_xcr0 : kvm_host.xcr0);

Even _if_ we want to play XCR0 games, tracking early_xcr0 is unnecessary.  =
This
can be:

	/*
	 * XCR0 is context switched around VM-Enter/VM-Exit if APX is enabled
	 * in the host but not in the guest.
	 */
	if (vcpu->arch.xcr0 !=3D kvm_host.xcr0 &&
	    (!cpu_feature_enabled(X86_FEATURE_APX) ||
	     vcpu->arch.xcr0 & XFEATURE_MASK_APX))
		xsetbv(XCR_XFEATURE_ENABLED_MASK,
		       load_guest ? vcpu->arch.xcr0 : kvm_host.xcr0);

And then __kvm_load_guest_apx()

	<context switch R16-R31>

	if (cpu_feature_enabled(X86_FEATURE_APX) &&
	    !(vcpu->arch.xcr0 & & XFEATURE_MASK_APX))
		xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);

And __kvm_save_guest_apx() would reverse the order of __kvm_load_guest_apx(=
).

> @@ -11056,6 +11061,49 @@ static void kvm_vcpu_reload_apic_access_page(str=
uct kvm_vcpu *vcpu)
>  	kvm_x86_call(set_apic_access_page_addr)(vcpu);
>  }
> =20
> +/*
> + * Assuming the kernel does not use APX for now.  When
> + * the kernel starts using APX this needs to move into
> + * assembly, and KVM_GET/SET_XSAVE needs to fill in
> + * EGPRs from vcpu->arch.regs.
> + */
> +void __kvm_load_guest_apx(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->arch.early_xcr0 !=3D vcpu->arch.xcr0)
> +		xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);

This is wrong.  The "real" xcr0 needs to be loaded *after* accessing R16+.

> +	if (!(vcpu->arch.xcr0 & XFEATURE_MASK_APX))
> +		return;
> +
> +	WARN_ON_ONCE(!irqs_disabled());
> +
> +	asm("mov %[r16], %%r16\n"
> +	    "mov %[r17], %%r17\n" // ...
> +	    : : [r16] "m" (vcpu->arch.regs[16]),
> +	        [r17] "m" (vcpu->arch.regs[17]));
> +}
