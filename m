Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046239B97B
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957799; cv=none; b=DId20iX1aT5xET5RbLP42Y34O9ub5zC/UYgE+LA2PL5o1N8ZUV1NQaIhB1T68lKS5tFpCYWP1kU/msipBBvb9IdtaCwB7lxSNaiCba8AWWYkqo1y1+lJasnkNsa7Nlxc62Lw1/sbqQfkE9EBviZ75xsdEC+X1qA8SIhPTi1PCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957799; c=relaxed/simple;
	bh=MpK0Qm7+J2WMp5Hj0ykvwccPlciIs/DeSmAc4KByY/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAQISQQVvPqOv2T1OV6uNuLyBOIUGJBcb1U+QPlPK/FR40bdySemVy+c04LOWHeNs5I6ZG0SowTT0r6QNX5UdZKF07QeqGb02KGJw3u0x5W8Z3XpwJ5GtR+o60eHgqNL8XyoniiphFTirqF5I/9D3dMT9VVLl4P/X/hE5bWnYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K2m+19cx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2m+19cx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JDVh1/I6YdTmSYOg0iF27pU8Jte7zxoIJJ4f1FtZl2Q=; b=K2m+19cxaD5IUM7S4VFDHKwKTi
	N0HzVaHfNpPTLi1Y9Dc3NWmmXzVUnp+QJhqlfTqkmWkCp6lYNCrQ39QENZ/FGiFCv6rbep7fiZt0y
	NEDW4LGboj18ZJkxqLEpla+U/4xJUO4eneaUgPxW58/5ddd3VCLpquW8C2wEV0JqAlg2oEoGUvIUA
	DrvPbnWBiOX/P10Ef+zoaG3ZDjAeJ9DGJDosg7rXO/NFANKW+k3LZ8cwPbtcT+IDSZb6A1IghtBb0
	/QRm7F65gz1EYYwsxvp6KswbtnkaXD2icd96X6JfRIF+TrOGBCUuG3C8Wl+zMcVWFYN61FTg3e+q3
	x8FQia6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFvtY-0000000DepP-3JaM;
	Thu, 23 Apr 2026 15:23:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BAC93008E2; Thu, 23 Apr 2026 17:23:12 +0200 (CEST)
Date: Thu, 23 Apr 2026 17:23:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260423152312.GI1064669@noisy.programming.kicks-ass.net>
References: <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com>
 <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
 <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
 <87o6ja1u36.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6ja1u36.ffs@tglx>

On Thu, Apr 23, 2026 at 12:57:49AM +0200, Thomas Gleixner wrote:
> On Wed, Apr 22 2026 at 09:46, Peter Zijlstra wrote:
> > On Wed, Apr 22, 2026 at 08:55:42AM +0200, Peter Zijlstra wrote:
> >> On Tue, Apr 21, 2026 at 02:42:46PM -0700, Sean Christopherson wrote:
> >> > On Tue, Apr 21, 2026, Peter Zijlstra wrote:
> >> > > On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
> >> > > > This as delta? (I had typed this all up before Peter posted a new verison, so
> >> > > > dammit I'm sending it!)
> >> > > 
> >> > > :-)
> >> > > 
> >> > > I'll go stare at it in the morning, I'm about to go crash out.
> >> > 
> >> > New delta against your effective v2, builds all of my configs (which isn't _that_
> >> > many, but I think they cover most of the weirder ways to include KVM (or not)).
> >> > 
> >> > I'll start testing the full thing to try and get early signal on the health.
> >> 
> >> Oh, re-reading commit 28d11e4548b7, I think this wrecks NMIs. The patch
> >> will also use the FRED NMI path and that's not good when running IDT.
> >> 
> >> I'll go fix that and stick in a few more comments to clarify this magic.
> >
> > This should probably we at least two patches, one moving the code into
> > the x86 core and one adding that hrtimer fix on top. But kept as one for
> > now.
> >
> > Irrespective of the hrtimer fix, I think the initial move into x86 core
> > part is a sane move.
> 
> I agree.
> 
> > +#if IS_ENABLED(CONFIG_KVM_INTEL)
> > +/*
> > + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
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
> > +#else
> > +		idt_entry_from_kvm(vector);
> > +#endif
> > +		/*
> > +		 * Strictly speaking, only the NMI path requires noinstr.
> > +		 */
> > +		instrumentation_begin();
> > +		/*
> > +		 * KVM/VMX will dispatch from IRQ-disabled but for a context
> > +		 * that will have IRQs-enabled. This confuses the entry code
> > +		 * and it will not have reprogrammed the timer (or do
> > +		 * preemption). Minimal fixup for now.
> 
> It's sadly the final fixup.
> 
> There is no way that KVM can benefit from the deferred rearm mechanism
> in case that NEED_RESCHED is set.
> 
> That's actually independent of the VMX specific handle_exit_irqoff()
> situation, which obviously cannot reschedule.
> 
> The other early local_irq_enable/disable dance, which caused you to buy
> a new WTF'o'meter, happens with preemption disabled, so the irq exit
> code will do the rearm right there.
> 
> So be it ....

OK, I'll go make this two patches, fix up that comment and post it
proper.
