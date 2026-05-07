Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C9343D63;
	Thu,  7 May 2026 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137960; cv=none; b=Yld3sK9VEAHcrC46+OZmuL7xr48UbqMM8zsWBPtOd0OwH/4IcXv2LbgkmobkkzA5Ap39lv2OD0JArIemBFzyyaxgzVrnNHeByxB+mQfrtiu/74iXXg1v0tD7fNF953bpjVIpANVgwdNzMt8GitOTGzMdeBkpQA+vNXoSoxh/5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137960; c=relaxed/simple;
	bh=eGJRO1hjR7tbRMTlX76r2mTDeARKRlV/ca0KyJEW0R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj+vnU7o1TSlodws0rrbQiZCQFq+PKYY3LSDiXodj3YiEA/7bM7/BNMw8r6K6xUWsY737e4IsuL+lyC5wan1U+YwI4U7V/YXSnM4WDBCZuvXz/nkc/cI9MkD+UP1/IU0kdCx3RdtFGbN+bEwJIVq37fb4e7P1/2FbHkz6BjYmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/EG84rs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IMHLkbqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/EG84rs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IMHLkbqT"
Date: Thu, 7 May 2026 09:12:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778137956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG5ynD673DXdYRYJ0K5lwTKSQPut8bbO44tT8oDu4Qs=;
	b=w/EG84rsuW1bRvUNb8a3TastPh84ZH707XgorjrBLpnenKnKDURt2XLSdkiKGiTcJWHFnk
	HxiSLL2YFoP4iJ0RP6CBAEyUMbd2oTmiBXtB4JG9rMqNyNity5IKXr6mLyXCvjpxOxArWf
	4Uflv9tg0vTtsUnNvQWL+CVQQAkeN9NQYJX2ED1TKbLBNJRgxeGsPsJlIG2Zl6ChA87ZX3
	jV3ECezfBTx/dX0BA7oTK4Gp7lRcAGIYmvrGTIqFjfMbhOe0s2UKwuAR6Pg7KjnSZA67ZE
	QQInP37jye/9Ucm4ZfhV88TVs96hy+zRHemnxbpUI1C1qMfrrTMcUIzNY81/wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778137956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG5ynD673DXdYRYJ0K5lwTKSQPut8bbO44tT8oDu4Qs=;
	b=IMHLkbqTu0tVTN4BEv0FqQPuuBk4VYvUpyHzJFhHav3JsF9jPNXmWxldF9EVhdo0jDPEWT
	rowOBhMsJxTPLwCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kernel-dev@igalia.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
Message-ID: <20260507071235.rdb4aGeE@linutronix.de>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>

On 2026-05-07 07:58:00 [+0100], David Woodhouse wrote:
> >> I am not comfortable applying this patch.  As shown by the need for the next patch
> >> to optimize unrelated invalidations, switching to read_trylock() is more subtle
> >> than it seems at first glance.  Specifically, there are no fairness guarantees.
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

So the cited patch does not look bad. That read-trylock should be fine
on RT (as in I don't see anything wrong with it). What did happen to it?

Sebastian
