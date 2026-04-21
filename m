Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F6274B46
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805328; cv=none; b=b/8G7InKT5iAS37MKCgW0YH2wpDoJjSAoOcZzBaO1xzuDjRfrXlUVNqQR1Usl9e6hHPj1/3m+mzqekcS6hOL/9i8opiDRFOB+RDVwVAG7fgNUto9YVbYjyjC/y1zDV7FSCP6dYRsGRWcUFMXx6WDVI4zquPxEba6V19/2T1bZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805328; c=relaxed/simple;
	bh=3AJTPgVR0HkA2vSv/eFHYIEsDFIAsNGE+MJhtRDJI7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNLFtWpsF9R405hDK2N5Lu0dAVEtzAWA1QTltxOayFMaO+OU9yK1yN6V28EaRm+oJJcGX44M4KRuDE/+cBJX1LzGK1+z3FRD04MaQVMPoIBnwtlD0A8ZD3GoN8ZkTO4npSsb/b9u3JIY0r6xd3b+k5uiP5mXYqSiSI6nrr8TMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n+BL71hR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+BL71hR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rXJtMmeBuaPyydi014A/gkDAH6He2sHslNbbcy6+Ek8=; b=n+BL71hRDTGOYjoVSXubt+7WxE
	P86hW4BRiqk4KA3agvJok1FkTIMhPyD6vOVjwzSCeRJnWEd3adGL97Kh2dkQoRiqYezMsVaC4YO+Z
	ICkJW0tLFR+r7njRbFoHgasOou6f8tOR/vnOXTHriHlf1H1rPpGVUeJXJ+P4httR5t7LXhUygufHd
	wAwgOWyZn+CW4dicuOPRMSux1diqqWvXKdI2MwEIPVnwj1KXNlyNMU10zgFbvBsh40QBEogsxm+ML
	rY6Xj2ric8wpojACMWJ5tJM2MBrKX9CGmizJ8n/TZ1IOm57mHB1JS5D3jlm/KkSNfeNmcB9JOoV3y
	jF1BdbYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFIEM-0000000Ai80-1YEg;
	Tue, 21 Apr 2026 21:02:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D23213008E2; Tue, 21 Apr 2026 23:02:01 +0200 (CEST)
Date: Tue, 21 Apr 2026 23:02:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
References: <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefktNLiS3ur10yD@google.com>

On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:

> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > new file mode 100644
> > index 000000000000..4b0171abb083
> > --- /dev/null
> > +++ b/arch/x86/entry/common.c
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <linux/kvm_types.h>
> > +#include <linux/hrtimer_rearm.h>
> 
> For CONFIG_X86_FRED=n, which is possible on x86-64 if CONFIG_KVM_INTEL=n, this
> 
> #include <linux/sched/task_stack.h>
> 
> is needed so that task_pt_regs() can find task_stack_page() (and including
> task_stack.h in processor.h would create cyclical includes).
> 
> > +#include <asm/entry-common.h>

This wanted to be linux/entry-common.h, otherwise I could not get 32bit
to build. And that sorts that same include issue you pointed out. My
x86_64 build didn't seem to care...

> > +#include <asm/fred.h>
> > +#include <asm/desc.h>
> > +
> 
> Related to CONFIG_X86_FRED=n, I vote to wrap this API with #if IS_ENABLED(CONFIG_KVM_INTEL)
> and then delete the fred_entry_from_kvm() stub so that a goof results in a build
> failure.  That'd also be a good place for a comment to explain some of the usage.

Yeah, it definitely wants a few comments. I'll do the KVM_INTEL thing,
I'd forgotten we'd made the FRED=y thing conditinoal on that, I thought
we'd had it unconditionally =y for 64bit.


> This as delta? (I had typed this all up before Peter posted a new verison, so
> dammit I'm sending it!)

:-)

I'll go stare at it in the morning, I'm about to go crash out.
