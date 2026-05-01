Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877735F610;
	Fri,  1 May 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667525; cv=none; b=f/wPqyMtQ67STanUnZAdZLyWnaVHMlhD5EMIrC1jefpr/qiU0pukCCOFrJB52byQWkylt0XabaDjuPROrli2LIkMtfTc0zbqfchjxjWSgLjCiWwlQ/V1YXAiG6gWo4ZSsFdMZNLXvGmQt6ysQb4LUEvTQnsu6cT+eJXr3Yo6seE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667525; c=relaxed/simple;
	bh=c7MmscP++YUgFYzjA/ykwHxhnEJ2bamX+8YPXQaEtQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJRN9Vpi2FK6duUe5dkWtME9f2zsjT68TqoOIcgLUjdPK18xKA66mUNjYP9ebpsqPXRB5OwRsXH43lR/3IyxoBp+bbrEc1g8va4E+sJgLIqot/xEWqhPYEPwpqFUpSF2cLtTtNEIO9V4FzQkzHwUpOsgnnSX5nk/35gVZg/5FkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WZFMJ5l3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WZFMJ5l3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UTPiOjrUYcq0prPteEqGmDJ21zoEzEBDXmOnjCIfwlg=; b=WZFMJ5l35SyRAnS2yEVIjamMwA
	nPc7eMnkx59q0ZVrk740CDyXl7PWWoslKQKH4teLiQlG4X9rZfqlJqyAOnn3ti/9fpGU0GaBuvOMP
	pZOK7EtvE5E2xLgpIKVIydiuA4dG7g4BgP1Pe4Lmhc7zUfqb3cMoVu+9Twlb8WV4fBwYPSQ/BVDw6
	k+AbNAch0X4iXzMgFX/AWQfoHaq9/OW8e7BHl5SmWUqJoubPezPfPWDxDZbDD1Txi/z2v0VwYm6VS
	jniGIZAyTX7wxggfs9AoXR2MvP4nSysHXbiC6v1JC92HPAMbwGTfSUf2SIeh+crcun6jfXQob6ei7
	LsbTqc4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIuWb-00000009OsW-2Oex;
	Fri, 01 May 2026 20:31:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 397A43008E2; Fri, 01 May 2026 22:31:48 +0200 (CEST)
Date: Fri, 1 May 2026 22:31:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86
 core
Message-ID: <20260501203148.GG1026330@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <e47f29d5-17f1-47ce-b80e-bfa543f9a712@linux.intel.com>
 <1aaf6b2d-85da-400e-b8ad-d611fdaa015f@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aaf6b2d-85da-400e-b8ad-d611fdaa015f@redhat.com>

On Tue, Apr 28, 2026 at 01:25:58PM +0200, Paolo Bonzini wrote:

> > > +#if IS_ENABLED(CONFIG_KVM_INTEL)
> > > +/*
> > > + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
> > 
> > s/acknowledge/acknowledged
> > > + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> > > + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> > > + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> > > + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> > > + * the VM-Exit is held pending until it's unblocked in the host.
> > > + */
> > 
> > [...]
> > 
> > > -
> > > -#if IS_ENABLED(CONFIG_KVM_INTEL)
> > > -/*
> > > - * Special entry point for VMX which invokes this on the kernel stack, even for
> > > - * 64-bit, i.e. without using an IST.  asm_exc_nmi() requires an IST to work
> > 
> > Although it's being removed, I guess what it says is still true?
> > 
> > It says asm_exc_nmi() requires an IST to work correctly, and the new path for
> > handling NMI when FRED is disabled.
> > 
> > idt_entry_from_kvm
> >      idt_do_nmi_irqoff
> >          IDT_DO_EVENT_IRQOFF call asm_exc_nmi
> >              ...
> >              call asm_exc_nmi
> > 
> > It seems the stack before calling asm_exc_nmi is not an IST?
> > Does it matter?
> 
> I think it does, the IST is needed because of all the stuff to detect
> recursive NMIs.  So asm_exc_nmi_kvm_vmx needs to remain.
> 
> By the way, here:
> 
> > +	/*
> > +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> > +	 * The FRED NMI context is significantly different and will not work
> > +	 * right (speficially FRED fixed the NMI recursion issue).
> > +	 */
> 
> It's even more important to note that NMIs need an IRET in order to unblock
> further NMIs.  This is even more important than the recursion issue, which
> does not affect KVM's non-IST entry into the NMI handler, and is the real
> reason to use IDT_DO_EVENT_IRQOFF to build the interrupt stack frame for
> NMIs.

Durr, I missed that: DECLARE_IDTENTRY_NMI != DECLARE_IDTENTRY_RAW

Let me go rectify that.
