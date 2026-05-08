Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E82DCBF8;
	Fri,  8 May 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230448; cv=none; b=iLhIVmXA5YvrKhcfJsUD1bkbgIg/p9ji00HFTiExNfcPUCbS/IIyyj09nEJYvKcdLwKuw5md6n/mmS6v9VnzzoyvSrPMXyqotlECmRcfetZ3lkZ8ZgQcmJarATryKUTP6/P1XzYJpY5ED9gr4KIk0JaEWb642nZ/yys7Jlzx4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230448; c=relaxed/simple;
	bh=ovDZlYGAMeruohaX3ZwvwoRJPW80jja6zWE8G1vFvj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC/qMNxfwyFC66oVqTSzvAQpUlnSIpSQa9NsG8tQhFojimS5vhFXyKOS2E/AJIdBTyicy+KhX4MdHQeBt/daHDlvTKGMR1HPdYwC1XsIHw5vWPYRfnd3hdn27WvT20UI3xWoa29oEQ+wptiXpsZRnQ3Foni92uFoQbRr1GaKZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3fuGnob; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3fuGnob"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EJCY+gKU5V6COdRSdVJ86/z5KyjJZip/+esR4t7XrPE=; b=N3fuGnobec3OIx2/cwTqSns0PL
	liiAlgddu9QWosTxNR6u5Uf5mJo7pZsJFWbMzcfCUpJeXD2uiROXSnd3V2Y5khMe8BAU/6Sxcq8Ky
	ivFil2cbf3cl/JkHP4Km89eSuY2SqApuFuD2cdJl4KhYdf0pyuAjxzCoPj9aLr8EBeEIkOpth+nEk
	UeLKTvAkEbG377sxE4mFEcFs7Uch6HY2cgWceGYimOSEpcn542wchOtrXojYdr0EApV4vdmv8YK29
	w8IFweYRnT8Zasi7tMJ7vHpa/HozzocVz/+qu9W1P/Tg6FnC+3wVy4dGpp9N3FOB8yeyV3necLYzc
	gbtb+QTQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGy3-00000003z3z-3ERG;
	Fri, 08 May 2026 08:53:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A22F301C52; Fri, 08 May 2026 10:53:54 +0200 (CEST)
Date: Fri, 8 May 2026 10:53:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260508085354.GM3126523@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
 <719c6275-c4b9-49f1-877e-05dd079b984e@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719c6275-c4b9-49f1-877e-05dd079b984e@linux.intel.com>

On Fri, May 08, 2026 at 02:09:09PM +0800, Binbin Wu wrote:
> On 5/2/2026 4:37 AM, Peter Zijlstra wrote:

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
> > +#else
> > +		idt_entry_from_kvm(vector);
> > +#endif
> > +		return;
> > +	}
> > +
> > +	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);
> 
> Not sure if it's OK to use WARN_ON_ONCE() here.
> If the warning is triggered, it could unblock NMI due to handling of #UD.

If that ever triggers you've got bigger problems.

> > --- a/arch/x86/include/asm/desc.h
> > +++ b/arch/x86/include/asm/desc.h
> > @@ -438,6 +438,10 @@ extern void idt_setup_traps(void);
> >  extern void idt_setup_apic_and_irq_gates(void);
> >  extern bool idt_is_f00f_address(unsigned long address);
> >  
> > +extern void idt_do_interrupt_irqoff(unsigned int vector);
> 
> In idt_entry_from_kvm() below, gate_offset() returns 'unsigned long', but here
> it uses 'unsigned int'. It's not safe since there is no guarantee that the
> address is within 32 bits for x86_64.
> 

Right you are, 'unsigned long address' it is.
