Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE249391850;
	Mon,  1 Jun 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303254; cv=none; b=YdTyos64zP1L5Kk+BDl0gfKshCnwskkAJl1SxZ9Fdy3/3P36srEV/+tvwN5DWR4nyIvLBzJlOkeQAGrO6jyUPazMCoyLbzLqtidFK7eDG//4CkV/mEKRpWy8TxRa8Wsz1VHJtc2UxuWoCzzotvIrXfQwrFX6Z+qYrUtqZld3uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303254; c=relaxed/simple;
	bh=Wdw3L6mWkmDIyF326gFtICmdPeTeOWGp9Uuhgf16Aj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnF0fcFCwn2jbtJKGrOvZJRlC6Eh4lRysfc/XSwrVFlxd1YIPh6XKiQjr9xyhiXzgf7teT55G9bFGMDmCKXf6wGmzchaX1Q+GNOfo/Nc3DWGKdUz8MAZSLJ3jpxWFhbimhkuAU+eynauYOJ19S62sPV8yvl8PgjKt038HmP6DqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mCm1NwsF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCm1NwsF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OVgy/3SEwwpQRJhKmU+vMLYbIXm/mUcVt2kvDFtXzdk=; b=mCm1NwsFpu2m0ZHZgNbTKbU6vf
	pCh2wCi7OSxx1n50b7pH0mfJKJUNCxc93OzNREEXnoTfMcNzFtc5LKfJjd6KTZWEKMt/+VMiUE1fQ
	TZPyrm2mAwc42TQhsUvIB4Kg3DRhHcj5SHDBQ3zUw5tfwcThQmRvgSqAghrLQWbzIOa0CTR3oCYAx
	ZAd7snNa+V+8RsGn/ugsNi8uTp2mQ0z5ABHwYjYfJeDu+hdPs61J7Q5oy0IhUWexTI7QZ8QHopGww
	vguSUv2FpY1lzsZlDaa7ejbCURkaXnfOvA9GQLKRXe8XR3pdjwz8xi30FmW2D62BXbMOlgef7YJCz
	O8PHI/ug==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTyCU-0000000662l-2aZ2;
	Mon, 01 Jun 2026 08:40:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A271C300454; Mon, 01 Jun 2026 10:40:45 +0200 (CEST)
Date: Mon, 1 Jun 2026 10:40:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260601084045.GL3102624@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>

On Sat, May 30, 2026 at 12:26:20PM +0200, Paolo Bonzini wrote:

> From f2c604a94cdea9bb96bb21c8a29288eae6cbac67 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Sat, 30 May 2026 10:54:36 +0200
> Subject: [PATCH] seqcount: allow raw_seqcount_try_begin in atomic context
> 
> When raw_seqcount_try_begin() is used, the typical action when
> the seqcount is busy is to take the same lock that the writer uses.
> Another possibility, found in kernel/events/uprobes.c, is to delay
> the work to a safe point using RCU.  Either way there is no need
> to guarantee progress of the writer under CONFIG_PREEMPT_RT,
> because the caller is not going to call raw_seqcount_try_begin() in a loop.
> 
> However, raw_seqcount_try_begin() currently uses seqprop_sequence()
> via raw_read_seqcount(), and therefore does a lock/unlock of the
> write-side lock on PREEMPT_RT kernel.  This prevents it from being
> used in atomic context.  Use __seqprop_sequence() instead of
> raw_read_seqcount() to allow it.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/linux/seqlock.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5a40252b8334..9adbf5d9667c 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -338,7 +338,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>   */
>  #define raw_seqcount_try_begin(s, start)				\
>  ({									\
> -	start = raw_read_seqcount(s);					\
> +	start = __seqprop_sequence(s);					\
> +									\
> +	if (!(start & 1))						\
> +		kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);		\
>  	!(start & 1);							\
>  })

Yeah, I think this makes sense. Thanks!
