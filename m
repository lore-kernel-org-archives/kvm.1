Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BD3C585B
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792742; cv=none; b=WGsMiMn2Sb5eiDY/XA1eEG7esYHVhupTT3wy6A3BbTKCRPgUBDuLGIyHhPMBEBMcrSFsU4F60PuDdj1Pj811IqJrWtZhwh88FBwzEZ6Qway3QGnSUlpTu8Rm/xcBR8vMe+EfcaCZ7tmb/DehDA6F28SLtxxmowFsDUUZ2FlIvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792742; c=relaxed/simple;
	bh=s4n8vBZ4XvyxzlHykn5542i7ZbBE0TsJQargpYPyE3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGpoOTT0OWFmterNo3cCjn1CTrDcfn5MuSXkYRl2gKcPXtta8Elxs1CKLmrSfi71uFlJA7vwPil6JAMXjVIQZma/M83KW+LueFoWyhQ3RGJgZdWiWzAfGrSt0sM7AT24l8VySG12DbzFYzMJn7OfRmcwEqg5//pFIRMJPZe1HpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=f60fiL6p; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="f60fiL6p"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026052610420647c68aaac600020792
        for <kvm@vger.kernel.org>;
        Tue, 26 May 2026 12:42:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tu10SLeQtGXiNIvQIpiU5JlZSSy1zBAuQxH0RcFN7H0=;
 b=f60fiL6pxD23w0g00sjo1K1mPYk/OxZon4mLE5l+AusNJ/Yr9jaM+7+ZpSKreQOx9dCa4U
 Q2UB1wukaxqQ6sLRX0HeVKCq3y+xVyW1ow11y8EZpRmd5OyQOC+QW0ADJkvmo1S88LOJoR2i
 hZt6HEPKGeuXojBgGHZdD6CuO8dJejS9ZDTJz4TtOMLG5fSKD9aYlMGSSJ6PBzzqoGfbgV5K
 P1HzKQrrU5RgYo3MRmaaUAvBVBKG8NRFua4ls8Pm61DxS+1I6vRwvFgFqA91W1p2uH+Pwegx
 AgOvJ9kjW+O0kvsubkOdKbehlZQ23Wn2DXkKjVU8digQgCnp8U19BosQ==;
Message-ID: <ac25be04d3044ce2af574ba3dcdcb1cf156e7d95.camel@siemens.com>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "tglx@kernel.org" <tglx@kernel.org>, "jmattson@google.com"	
 <jmattson@google.com>, "rick.p.edgecombe@intel.com"
 <rick.p.edgecombe@intel.com>,  "binbin.wu@intel.com"	
 <binbin.wu@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
 "binbin.wu@linux.intel.com"	 <binbin.wu@linux.intel.com>,
 "bonzini@redhat.com" <bonzini@redhat.com>,  "x86@kernel.org"	
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "vishal.l.verma@intel.com"	
 <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
Date: Tue, 26 May 2026 12:42:04 +0200
In-Reply-To: <20260526102143.GD4149641@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
	 <20260423155936.843498069@infradead.org>
	 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
	 <6ae24df3f3a62957ca997c6788926fd212f074b3.camel@siemens.com>
	 <20260526102143.GD4149641@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-05-26 at 12:21 +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 10:01:41AM +0000, Bezdeka, Florian wrote:
>=20
> > > +#if IS_ENABLED(CONFIG_KVM_INTEL)
> > > +/*
> > > + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledged by =
hardware as
> > > + * part of the VM-Exit, i.e. the event itself is consumed as part th=
e VM-Exit.
> > > + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMI=
s and IRQs
> > > + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-=
Exit is
> > > + * purely a signal that an NMI/IRQ is pending, i.e. the event that t=
riggered
> > > + * the VM-Exit is held pending until it's unblocked in the host.
> > > + */
> > > +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned in=
t vector)
> > > +{
> > > +	if (event_type =3D=3D EVENT_TYPE_EXTINT) {
> > > +#ifdef CONFIG_X86_64
> > > +		/*
> > > +		 * Use FRED dispatch, even when running IDT. The dispatch
> > > +		 * tables are kept in sync between FRED and IDT, and the FRED
> > > +		 * dispatch works well with CFI.
> > > +		 */
> > > +		fred_entry_from_kvm(event_type, vector);
> >=20
> > Seems this landed in 7.1-rc5.
> >=20
> > I'm seeing a build failure here:
> >=20
> > arch/x86/entry/common.c: In function =E2=80=98x86_entry_from_kvm=E2=80=
=99:
> > arch/x86/entry/common.c:27:17: error: implicit declaration of function =
=E2=80=98fred_entry_from_kvm=E2=80=99; did you mean =E2=80=98idt_entry_from=
_kvm=E2=80=99? [-Wimplicit-function-declaration]
> >    27 |                 fred_entry_from_kvm(event_type, vector);
> >       |                 ^~~~~~~~~~~~~~~~~~~
> >       |                 idt_entry_from_kvm
> > arch/x86/entry/common.c:50:24: error: =E2=80=98return=E2=80=99 with a v=
alue, in function returning void [-Wreturn-mismatch]
> >    50 |                 return fred_entry_from_kvm(event_type, vector);
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > arch/x86/entry/common.c:18:14: note: declared here
> >    18 | noinstr void x86_entry_from_kvm(unsigned int event_type, unsign=
ed int vector)
> >       |              ^~~~~~~~~~~~~~~~~~
> >=20
> >=20
> >=20
> > > +#else
> > > +		idt_entry_from_kvm(vector);
> > > +#endif
> > > +		return;
> > > +	}
> > > +
> > > +	WARN_ON_ONCE(event_type !=3D EVENT_TYPE_NMI);
> > > +
> > > +#ifdef CONFIG_X86_64
> > > +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> > > +		return fred_entry_from_kvm(event_type, vector);
> > > +#endif
> > > +
> > > +	/*
> > > +	 * Notably, we must use IDT dispatch for NMI when running in IDT mo=
de.
> > > +	 * The FRED NMI context is significantly different and will not wor=
k
> > > +	 * right (speficially FRED fixed the NMI recursion issue).
> > > +	 */
> > > +	idt_entry_from_kvm(vector);
> > > +}
> > > +EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
> > > +#endif
> > >=20
> >=20
> > [snip]
> >=20
> > > --- a/arch/x86/include/asm/entry-common.h
> > > +++ b/arch/x86/include/asm/entry-common.h
> > > @@ -97,4 +97,6 @@ static __always_inline void arch_exit_to
> > >  }
> > >  #define arch_exit_to_user_mode arch_exit_to_user_mode
> > > =20
> > > +extern void x86_entry_from_kvm(unsigned int entry_type, unsigned int=
 vector);
> > > +
> > >  #endif
> > > --- a/arch/x86/include/asm/fred.h
> > > +++ b/arch/x86/include/asm/fred.h
> > > @@ -110,7 +110,6 @@ static __always_inline unsigned long fre
> > >  static inline void cpu_init_fred_exceptions(void) { }
> > >  static inline void cpu_init_fred_rsps(void) { }
> > >  static inline void fred_complete_exception_setup(void) { }
> > > -static inline void fred_entry_from_kvm(unsigned int type, unsigned i=
nt vector) { }
> >=20
> > That seems still necessary for the !CONFIG_X86_FRED case.
>=20
> The thing is, KVM_INTEL should force X86_FRED, I'm not sure how you can
> have both KVM_INTEL and !X86_FRED, that should be an invalid config.

Right. Thanks for the super fast response. Let me double check what is
going on here...
