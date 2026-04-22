Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F553EAC71
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866919; cv=none; b=oNZFqn16LrCg2ESy+h4rrpHlNq1QUjRbz+JgK8oFpgeOe1PN6lRF6ME1HNN5V3yD8IknO4SHrOaXLjlcpRFuz9bW8RHNHsrM0SWXKw1E10TDLqGL4E+OkzA0i80KvZo0u9qk9mM5/pMpTIj0cglyTfys4o979h0DHSsx42ASu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866919; c=relaxed/simple;
	bh=gY20hbhn6yWj7akQr/WLg/M7bDxCJCqPK0irQ+nbSvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byOyXm3uOLO9pfmoFnWTRjZ5yOP/30Sf7Nk1GjN7RlWUOjBG840FzcvgauUncZq0KVQwy2qXjkpurl4ZKkPt93RkMoHFgQYNini6ay6vLmYWmnwUSKFWmKVXI8eHCMrpMKHLYnHkWCHprfW4OHGwRzwcpnGiNwAOupxqU3BQJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQKKJGe4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQKKJGe4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ui/JFntIC1ZJ6utgvHuguEuv2ieLgGraYI5iU5jNyHU=; b=EQKKJGe4uv8mUuYrAldT7ueTcu
	d510FDXmevHrDza3IhOUL27540umg5oIIynTGVQLvH3sdksGSZ8Ucn0AEkBPBdSDizwWiCqvoQ0lf
	/nQT/kTV13XNHRof840dpor6+jEAknKCOmVqlwvZWIA/73NrmqC9OqfLVq0n7gAqrM8seCw/YQ8d7
	JJL5lGsR+e12UrWIeBvDctDfI/wS6di/LQbTD/FvuyStwPSAn/oTI+WDAYEDsXP6Tu5neiw7IQLkf
	YPRibiWI8Er0tf9pMzgsK20oAGDCqYmTj81tPAtfdzQfZTod0iM7ydnQIC+I3YokRYlEW2tjPeoy8
	eH+pmw2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFYFl-0000000BXRd-0Ecg;
	Wed, 22 Apr 2026 14:08:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80A5E300BD2; Wed, 22 Apr 2026 16:08:31 +0200 (CEST)
Date: Wed, 22 Apr 2026 16:08:31 +0200
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
Message-ID: <20260422140831.GR3102624@noisy.programming.kicks-ass.net>
References: <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com>
 <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
 <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422074646.GO3126523@noisy.programming.kicks-ass.net>

On Wed, Apr 22, 2026 at 09:46:46AM +0200, Peter Zijlstra wrote:
> +		instrumentation_begin();
> +		/*
> +		 * KVM/VMX will dispatch from IRQ-disabled but for a context
> +		 * that will have IRQs-enabled. This confuses the entry code
> +		 * and it will not have reprogrammed the timer (or do
> +		 * preemption). Minimal fixup for now.
> +		 */
> +		hrtimer_rearm_deferred();
> +		instrumentation_end();

So I've been looking at this preemption thing. After having gotten my
head in a twist a few times around, I think this is done by
vcpu_enter_guest() like:

	preempt_disable();
	local_irq_disable();
	...
	kvm_x86_call(handle_exit_irqoff)(vcpu); <--- all of this VMX nonsense
	...
	local_irq_enable();
				<--- WTF goes here :-)
	++vcpu->stat.exits;
	local_irq_disable();
	...
	local_irq_enable();
	preempt_enable(); <--- here we finally preempt

This earlier IRQ-enable makes my head hurt and I had to go buy a new
WTF'o'meter (again!).
