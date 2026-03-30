Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2171FF1C7;
	Mon, 30 Mar 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872354; cv=none; b=O9Y0whAOXZslVCFxqp9cJPo6IH0T21biA0KyW6XU+oxkIzEslOOSrtTQ0ZdSbBeSOaTksDCWIUJTdWDZ1HG3EXHQ+n1y5fdZiveq9/h/6k1EBsnf/JTqbwWFkgbVY391nhA2HHXUtBLs4CYzhQtW51D54aET2ut/h7Fn1L6QUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872354; c=relaxed/simple;
	bh=Aw4/6GTC33E3nohwhjO1rwCzwL1QoiCSz9gADQIh6vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVp8vC2+O3wFwIM1J9bt0UIq5N4ztHpT1FyrOin24huI8C7psNA4ImBulr/5z1I871mJ1M8wKaS2M0iu+p0doX54QSyjzvB8kzNPu057Vsj36D2mH0rqpLjUvV9N/RKx4C2y4e4mcfknzXwL5wy8P4pGgg46eNHM2g9ttSauOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h9/BG9NV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9/BG9NV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XT7DDdcu9TCOpFufgFtBI3CAPidDcLyS+uT97Og4GM8=; b=h9/BG9NVFf2jivF6wJyVzMZIwE
	1y8kIub1x9619oJDYz14DHTa9ngCMDwZhw2KHvJZI7nFJBf7+gdmve1f57eDb492B0BIOSmyiKhd7
	gxI8wSWQyB8GYps67I/HCiy1Q1aYAQlJFZZbGjja3yMPCq53s7bKvDvQhIL+5zBkZCR5242506NEq
	UJF5XKuzBgRMtEmneJcwxYoexqj5uUKtrJDPEAYtncxUzIhPod9RKGjAe/SQPi+bx4AN5T4tA2WNE
	RFOuoiix80ft5or+vVonNY+9dSF12J+LjLOOkL4dEaLMysyf3XLR8qxrqgQJgur7p2jQp/2M6F72M
	9r2f+OOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7BND-00000006crG-27hi;
	Mon, 30 Mar 2026 12:05:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CF5B301BDE; Mon, 30 Mar 2026 14:05:38 +0200 (CEST)
Date: Mon, 30 Mar 2026 14:05:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	Shashank Balaji <shashankbalaji02@gmail.com>,
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>,
	"francesco@valla.it" <francesco@valla.it>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Sean Christopherson <seanjc@google.com>, KVM <kvm@vger.kernel.org>
Subject: Re: [PATCH v3] printk: fix zero-valued printk timestamps in early
 boot
Message-ID: <20260330120538.GM3738010@noisy.programming.kicks-ass.net>
References: <39b09edb-8998-4ebd-a564-7d594434a981@bird.org>
 <20260210234741.3262320-1-tim.bird@sony.com>
 <87zf3ud92r.ffs@tglx>
 <MW5PR13MB5632FC91EE0EF8754331400DFD57A@MW5PR13MB5632.namprd13.prod.outlook.com>
 <87jyuvboo2.ffs@tglx>
 <87fr5ib6ks.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr5ib6ks.ffs@tglx>

On Mon, Mar 30, 2026 at 12:42:59AM +0200, Thomas Gleixner wrote:
> Quite the contrary, I'm going to get rid of technical debt:
> 
>   The get_cycles() related changes in tsc.h are going to end up in a
>   obviously revised formal patch tomorrow as there is exactly _zero_
>   requirement to provide this as a functional interface.
> 
>   1) The default implementation in asm-generic returns 0
> 
>      Ergo any code depending on a functional implementation is broken
>      by definition.
> 
>   2) The ops/cycles metrics are as bogus as the infamous BogoMIPS metrics
>   
>      The "cycle" counter runs on almost all contemporary CPUs at a fixed
>      frequency, which is completely unrelated to the actual CPU
>      frequency and therefore to the actual CPU cycles.
> 
>      The only realistic metric is ops/sec and nothing else and that can
>      be trivially achieved by using the generic time getter interfaces.
> 
>      Those might end up resulting in bogus benchmark results too if the
>      underlying clocksource is jiffies, but that's again a matter of
>      accepting reality.
> 
>      If people really mandate that ops/bogo_cycles is required for the
>      very wrong reasons, then I'm happy to bring it back with a global
>      name change from get_cycles() to get_bogo_cycles() which excludes
>      it from any serious usage including printk.
> 
> Thanks,
> 
>         tglx
> ---
>  arch/x86/include/asm/tsc.h        |   11 ++--
>  arch/x86/kernel/platform-quirks.c |    2 
>  arch/x86/kernel/tsc.c             |   96 ++++++++++++++++++++++++++++++--------
>  3 files changed, 85 insertions(+), 24 deletions(-)
> 
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -76,10 +76,7 @@ extern void disable_TSC(void);
>  
>  static inline cycles_t get_cycles(void)
>  {
> -	if (!IS_ENABLED(CONFIG_X86_TSC) &&
> -	    !cpu_feature_enabled(X86_FEATURE_TSC))
> -		return 0;
> -	return rdtsc();
> +	return 0;
>  }
>  #define get_cycles get_cycles
>  

So this is probably going to break a bunch of generic stuff. There is a
fair amount of 'get_cycles' usage out in the tree.

Mostly it appears to be various test code.

But I do agree that get_cycles() is terrible and should go away.
