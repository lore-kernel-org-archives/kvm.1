Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CE335BBB;
	Thu,  7 May 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165858; cv=none; b=IqqmGRiyiBQ6pMgoi+BiSX51ej5Xdg2DmuoARJtFsxdlRoPY5ZzosWHtyE11O7azezZBt89aybZ5f6DaTTuZ9dsJc/8npWx2a/hvSjzlmU9WcvxGtLr+O5s2Hj0txbdxVrm69Ez3x+4DXetoQU1h6RXbjMHCNVqevovPqC1sBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165858; c=relaxed/simple;
	bh=UYl1Ob6n/jKEn5r7KoQs8MgsoZ1gcmZPU/hVb45pgKo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bDvgu3E6Z2LjFIsEFZVGiBpW2Ge9oIQsshSPFHiEd6nUkQ7kHsW7jFByRrPnp8LUceF5Th69hrRobVtlNIDfuLuE5l9PoNeA75T8dcxsToS+Kq6SFr3CuVq1X9U2wJNC8kfYPYreXnDxNTCkn+504RegeKMiw7b9CORk2x4hLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V2ayP/Ie; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V2ayP/Ie"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=czk/1r5wAU+devrUPgH7l9mK+JM2nxAq3Kx5j/xE4y4=; b=V2ayP/IeVGBHYX9RYgKmy1zTEa
	lNDVfxy7H/VjRLgaTV8TCk7lFtOmVQi60bVN+nXCNyjaXgOD0MjGRZzhtbVC17bALksOb/QkK1mDl
	XjfaX0s/s2SjhbOtTJW+6UDJ/zghF6re5pC9aXCcazBRWNJsNKjSFsdeGUO3IwvZEDsKq06d7K/JC
	JUO/zAwGDSR/9w5MzYN7E/9d7ND3Pt13G6PRwdenYh691v6HEtBCEvYWA4arQH0JeRKn4qMRmWv11
	yIk+O7hWQuEKkzK9dhLplgrfQgDi1vdXyeFX1aZ14cbQLa9otUDD3U3DHR4F7WiZpLPBXZiuRLIp5
	x0C0mxAA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wL09v-007S0I-J2; Thu, 07 May 2026 16:57:02 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1wL09s-000ImX-DE; Thu, 07 May 2026 16:57:02 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1wL09r-00000004MGy-388N;
	Thu, 07 May 2026 16:57:00 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 May 2026 11:56:59 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kernel-dev@igalia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
In-Reply-To: <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
Message-ID: <e23df9d183c2c421946ea73b8053e4c4@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8
X-Spam-Score: -21
X-Spam-Bar: --

On 2026-05-07 03:58, David Woodhouse wrote:
> On Wed, 2026-05-06 at 23:36 -0300, Mauricio Faria de Oliveira wrote:
>> kvm_xen_set_evtchn_fast() calls read_lock_irqsave(), which might block
>> on PREEMPT_RT, but that is invalid in IRQ context, as when it's called
>> by xen_timer_callback() (even on PREEMPT_RT per HRTIMER_MODE_ABS_HARD).
>> 
>> Check for that case, and bail out early.
>> 
>> Note: there is previous work and discussion on this [1] (~2 years ago),
>> which involved continuing to execute the function with changes, but it
>> was not merged. That was a different, more complex approach.
>> 
>> [1] https://lore.kernel.org/lkml/ZdPQVP7eejq3eFjc@google.com/
> 
> ...
> 
>> +	/* Bail in IRQ context on PREEMPT_RT; read_lock_irqsave() might block */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq())
>> +		goto out;
> 
> 
> The approach in Paul's earlier patch was better; we absolutely *want*
> to deliver the interrupt to the guest immediately whenever we can, and
> only fall back to the workqueue in the rare case that the shared info
> page has been invalidated.

Certainly, that was better. This was a simple workaround, but with this
clarification, it indeed doesn't fit.

> We should switch to plain read_trylock(), *without* the
> local_irq_save(). And since this was the *only* case where the GPC lock
> was ever taken under IRQ¹, all the GPC locking can drop the _irq part.

Ok, I can take a look. Or do you plan to work on it yourself (as you
hit the issue with read_unlock later in this thread)?

> Sean's concern was:
> 
>>> I am not comfortable applying this patch.  As shown by the need for the next patch
>>> to optimize unrelated invalidations, switching to read_trylock() is more subtle
>>> than it seems at first glance.  Specifically, there are no fairness guarantees.
> 
> I'm OK with that in this case. Because kvm_xen_set_evtchn_fast(), as
> with *everything* called from kvm_arch_set_irq_inatomic(), is
> explicitly designed to be a 'best effort' and allowed to return
> -EWOULDBLOCK when it's too hard.
> 
> And the write lock being held here should a *rare* case, as the GPC for
> the shared_info and vcpu_info pages should basically *never* get
> invalidated while the guest is running.
> 
> I've taken the same read_trylock() approach in
> https://lore.kernel.org/all/1d6712ed413ea66ef376d1410811997c3b416e99.camel@infradead.org/

Thanks for the pointers.

-- 
Mauricio
