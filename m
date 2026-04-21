Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86F1B4F09
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773136; cv=none; b=rCyL3kJQEMuZ08NLM5X2FxOFmQcRgcCIK4Ip1hW37yDOIGUwbr1IAg+bBZMfTVBduJ3diCNjeAtnKldlTi4UcIM384mqTw9AicfMTmOD+wK0/MQAGvQtmEMzB4Yt3Q0cKmTJeFO9y6cIGMrpZNHmJinAs5D55D7A+nBzVpWc+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773136; c=relaxed/simple;
	bh=IM8HrNsAatZ4GVqnl9LXg5J9m9rFVMXNI/u9y6FM1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAY4wITJ3bIAQ5kS4M9f9jI/7YfEk+9KxMFqqXV6P497zguO8sFSpTy0NNKy8hp8GSCOCLPGJAxnL5YwBAHMP7QacVPDacyfjiq4V5ts5sRDPhB4MdkzS2HXBHtxvNaoqDAfAKnDz98a5kvxKGKtP2zPsLkHPcctcRVTVo7wKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bQ9O+BNV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bQ9O+BNV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IYA8JR0kpQcb4QKegVkuDZ0K93vk+Q/Oia3h8mC+n+k=; b=bQ9O+BNVGzIWHP9ZrBgECLeo2+
	TwTL5NWHOwFeVMgzHbBEGlqZoSRn486uf7G5jW7jKJnzGgDwk3xruR+5LUXUkRVwX2J6vNdKwDTDp
	T/Pta4cAVBC7HS2xlWOrY2quQfN2+Bau2SXTVNtoCWDdL+jyD9yB+vT0RZx6cwuhaJyO/LlvCh7RS
	JNzPJzw7hooMksFpBhT6rfLFKXyx85kutQSKMiyJaqV57iyQgwybdpyvWkJN71NGqx/vftgLiGziY
	ky166EGRjO70QLIh8V6iET7Wvv4mR+kt5NvJFy2ZjI/LDu79dcp1RZcjeAzathw15fqdN8F4SIulO
	JaoMDpgg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF9rA-00000009gto-0fzG;
	Tue, 21 Apr 2026 12:05:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF916300BD2; Tue, 21 Apr 2026 14:05:31 +0200 (CEST)
Date: Tue, 21 Apr 2026 14:05:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260421120531.GF3102924@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>

On Tue, Apr 21, 2026 at 01:49:40PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 21, 2026 at 01:32:12PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 21, 2026 at 01:18:58PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Apr 21, 2026 at 09:39:14AM +0200, Thomas Gleixner wrote:
> > > > 
> > > > > ---
> > > > > Subject: entry: Enforce hrtimer rearming in the irqentry_exit path
> > > > > From: Thomas Gleixner <tglx@kernel.org>
> > > > > Date: Tue, 21 Apr 2026 09:00:52 +0200
> > > > > 
> > > > > irqentry_exit_to_kernel_mode_after_preempt() invokes
> > > > > hrtimer_rearm_deferred() only when the interrupted context had interrupts
> > > > > enabled. That's a correct decision because the timer interrupt can only be
> > > > > delivered in interrupt enabled contexts. The interrupt disabled path is
> > > > > used by exceptions and traps which never touch the hrtimer mechanics.
> > > > > 
> > > > > So much for the theory, but then there is VIRT which ruins everything.
> > > > > 
> > > > > KVM invokes regular interrupts with pt_regs which have interrupts
> > > > > disabled. That's correct from the KVM point of view, but completely
> > > > > violates the obviously correct expectations of the interrupt entry/exit
> > > > > code.
> > > > 
> > > > Mooo :-(
> > 
> > Also, is this a x86/KVM 'special' or is this true for all arch/KVM that
> > use GENERIC_ENTRY?
> 
> Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix IF
> on the fake frame instead? We know it will enable IRQs after doing
> handle_exit_irqoff() in vcpu_enter_guest().

Moo, you can't do that either, because it will ERETS/IRET and fuck up
the state :/
