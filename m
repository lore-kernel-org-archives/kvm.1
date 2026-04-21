Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468A231832
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770347; cv=none; b=PIn7DL5INVuok5M3aTDslZa1/hagHuPndbMEbqm5Jv2ILIdW8LFWsinXy1fsnk05XinLDCyLkD1+X178nrM74JMsSGwWRPtLB9dH7dIP6czOcbFglj8aGGIBEJV2AMs8r384rOsh7+WUrkiiuNsgnF9Qj87dKXPBh51vMVa902g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770347; c=relaxed/simple;
	bh=BYG43dvcdrs38O8r0699oyHRu9QLVTtlF00I22aGEP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYNUHBnhkNyfsF2UEC8LsuPExpLEaSGRxo5ku9WP61raaS68Ah4FF/zNrAoXYNmnyohp8IqwXkkah6dlQI3gq5rfbWUVs06sPgeANoR1dVNJslpXWkK+wuj93MoZdc/y2CW3pJNFMwY2N5+aIB9pk1+xxYneo5xWdEQq6GfdA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G2Z5immx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2Z5immx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pCRunEybbQFqFpO1VzKOkoYAaKIC60X8y0uvIR5pPXw=; b=G2Z5immxoPRneO3D2XOf3a/xKl
	rqQN0/taXdg56Y46T1dsTik5mZ701LBbmjE2wAvW43tKi5DO1XkJQSYnbQY0z+5hTgA69hW9wfmuF
	4rVqMGEo6c8rVurDWhBxTavs2WwQsgsZ3xyuJxa0rUfkN39blqFrH1L2KcchcWoe3ll53i9vAJeVO
	SRaxKo6unwAx0dxlj5IejN83jrQzrB5hzUVSExsnI53Nv/0jXMzlv5PIrlCGcsbUPxWLKcj1mh6vW
	KQ9ZNEJmv7SoFYYL9QkDeUclBGDd39JKMu2O1xqbrBkhZH3SBESi52xEDyNk3Kbqw22VxradnyEJM
	aQ2+TfVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF988-00000009dWW-0XxL;
	Tue, 21 Apr 2026 11:19:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48767300BD2; Tue, 21 Apr 2026 13:18:58 +0200 (CEST)
Date: Tue, 21 Apr 2026 13:18:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eck8daot.ffs@tglx>

On Tue, Apr 21, 2026 at 09:39:14AM +0200, Thomas Gleixner wrote:

> ---
> Subject: entry: Enforce hrtimer rearming in the irqentry_exit path
> From: Thomas Gleixner <tglx@kernel.org>
> Date: Tue, 21 Apr 2026 09:00:52 +0200
> 
> irqentry_exit_to_kernel_mode_after_preempt() invokes
> hrtimer_rearm_deferred() only when the interrupted context had interrupts
> enabled. That's a correct decision because the timer interrupt can only be
> delivered in interrupt enabled contexts. The interrupt disabled path is
> used by exceptions and traps which never touch the hrtimer mechanics.
> 
> So much for the theory, but then there is VIRT which ruins everything.
> 
> KVM invokes regular interrupts with pt_regs which have interrupts
> disabled. That's correct from the KVM point of view, but completely
> violates the obviously correct expectations of the interrupt entry/exit
> code.

Mooo :-(

That also complicates the comment that goes with
hrtimer_rearm_deferred(). Not sure how to 'fix' that.

> Cure this by adding a hrtimer_rearm_deferred() invocation into the
> interrupted context has interrupt disabled path of
> irqentry_exit_to_kernel_mode_after_preempt().
> 
> That's unfortunate when there is an actual reschedule pending, but it can't
> be avoided because KVM invokes a lot of code and also reenables interrupts
> _before_ reaching the point where the reschedule condition is handled. That
> can delay the rearming significantly, which in turn can cause artificial
> latencies.

Yeah, this is a trainwreck. If they want it better, KVM needs to get
'fixed' to not play silly games like this.

> Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
> Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Closes: https://lore.kernel.org/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/irq-entry-common.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -516,6 +516,14 @@ irqentry_exit_to_kernel_mode_after_preem
>  		instrumentation_end();
>  	} else {
>  		/*
> +		 * This is sadly required due to KVM, which invokes regular
> +		 * interrupt handlers with interrupt disabled state in @regs.
> +		 */
> +		instrumentation_begin();
> +		hrtimer_rearm_deferred();
> +		instrumentation_end();
> +
> +		/*
>  		 * IRQ flags state is correct already. Just tell RCU if it
>  		 * was not watching on entry.
>  		 */
