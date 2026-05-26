Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB43D9035;
	Tue, 26 May 2026 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790913; cv=none; b=ucyIa10apFgSNk4MsI5La+0TBQZB0/eKaj20nOXgwkQM3Y1UUu+YxLXh7tZzoUhpvFYu/p5H4J5mOdczHhtWCP3aIZQDcNwZraJ8TFj0vhmU2Zr3hoqivszqruK9HAeaqoRD/Jm5GC7LZaYMZdBR/l7PJ9UXOt9ZfVZ4FiwYmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790913; c=relaxed/simple;
	bh=v11F9I2n4dPBsiYPTqdp5x5Lp67b/eoEAPp+hZ4cwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok6g2oKP3AtnD56QhHEhQQ0g9YjlFtKfSP4PMuordJLOjxew4W7c4B/tabEjIhtH8Ekbw2FZO3TgOwcmniHjE1S+ypwRCik5sIhXpwH3FZv9xV9jjux+s6cFGfVQik77uwBo7nUWrmoyS1XVrWtXO4mgxUXVz6XHVWijUgJ+7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OYyvoCnx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYyvoCnx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rGl2Kz4YKjz+rFSJKhTux3ecNUx9X0V8lVGsVFF2gww=; b=OYyvoCnxIlwv7zUrPEUDxyhc19
	DjKSZcZQGm2G9EQJ/w1k35SI32W92JPSAqFOm1e0PkKQXOwfTL2etn18Ix2a7OveRZVHSock10sXD
	Lc01TKmMKHrhCNjJdzHc4zXHCN7OPKnIg+5TKLP7MCXDrl7fb2urxKgj7PyX2Sq5GWq8KeDZzpuEt
	9bezLs6yDzm5WDLp0+hGoogIGgaWzDEdmkp3j5WDKsGZ5SSb1gyWw4/x/Xetb0NUnVotwYhldg+o3
	NbFY80DSxOe4uyLdNs6L8LKA+bxSkbwQWJevT5g2KIBbBYSxgvKsGY7uqzmIci+sR4ehY8dO9OE1y
	M5Expozw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRout-00000000vY9-2ozV;
	Tue, 26 May 2026 10:21:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2962A300324; Tue, 26 May 2026 12:21:43 +0200 (CEST)
Date: Tue, 26 May 2026 12:21:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "tglx@kernel.org" <tglx@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"binbin.wu@intel.com" <binbin.wu@intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"bonzini@redhat.com" <bonzini@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260526102143.GD4149641@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
 <6ae24df3f3a62957ca997c6788926fd212f074b3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ae24df3f3a62957ca997c6788926fd212f074b3.camel@siemens.com>

On Tue, May 26, 2026 at 10:01:41AM +0000, Bezdeka, Florian wrote:

> > +#if IS_ENABLED(CONFIG_KVM_INTEL)
> > +/*
> > + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledged by hardware as
> > + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> > + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> > + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> > + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> > + * the VM-Exit is held pending until it's unblocked in the host.
> > + */
> > +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
> > +{
> > +	if (event_type == EVENT_TYPE_EXTINT) {
> > +#ifdef CONFIG_X86_64
> > +		/*
> > +		 * Use FRED dispatch, even when running IDT. The dispatch
> > +		 * tables are kept in sync between FRED and IDT, and the FRED
> > +		 * dispatch works well with CFI.
> > +		 */
> > +		fred_entry_from_kvm(event_type, vector);
> 
> Seems this landed in 7.1-rc5.
> 
> I'm seeing a build failure here:
> 
> arch/x86/entry/common.c: In function ‘x86_entry_from_kvm’:
> arch/x86/entry/common.c:27:17: error: implicit declaration of function ‘fred_entry_from_kvm’; did you mean ‘idt_entry_from_kvm’? [-Wimplicit-function-declaration]
>    27 |                 fred_entry_from_kvm(event_type, vector);
>       |                 ^~~~~~~~~~~~~~~~~~~
>       |                 idt_entry_from_kvm
> arch/x86/entry/common.c:50:24: error: ‘return’ with a value, in function returning void [-Wreturn-mismatch]
>    50 |                 return fred_entry_from_kvm(event_type, vector);
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/entry/common.c:18:14: note: declared here
>    18 | noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
>       |              ^~~~~~~~~~~~~~~~~~
> 
> 
> 
> > +#else
> > +		idt_entry_from_kvm(vector);
> > +#endif
> > +		return;
> > +	}
> > +
> > +	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);
> > +
> > +#ifdef CONFIG_X86_64
> > +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> > +		return fred_entry_from_kvm(event_type, vector);
> > +#endif
> > +
> > +	/*
> > +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> > +	 * The FRED NMI context is significantly different and will not work
> > +	 * right (speficially FRED fixed the NMI recursion issue).
> > +	 */
> > +	idt_entry_from_kvm(vector);
> > +}
> > +EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
> > +#endif
> > 
> 
> [snip]
> 
> > --- a/arch/x86/include/asm/entry-common.h
> > +++ b/arch/x86/include/asm/entry-common.h
> > @@ -97,4 +97,6 @@ static __always_inline void arch_exit_to
> >  }
> >  #define arch_exit_to_user_mode arch_exit_to_user_mode
> >  
> > +extern void x86_entry_from_kvm(unsigned int entry_type, unsigned int vector);
> > +
> >  #endif
> > --- a/arch/x86/include/asm/fred.h
> > +++ b/arch/x86/include/asm/fred.h
> > @@ -110,7 +110,6 @@ static __always_inline unsigned long fre
> >  static inline void cpu_init_fred_exceptions(void) { }
> >  static inline void cpu_init_fred_rsps(void) { }
> >  static inline void fred_complete_exception_setup(void) { }
> > -static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
> 
> That seems still necessary for the !CONFIG_X86_FRED case.

The thing is, KVM_INTEL should force X86_FRED, I'm not sure how you can
have both KVM_INTEL and !X86_FRED, that should be an invalid config.
