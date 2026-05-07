Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD06382F10;
	Thu,  7 May 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165667; cv=none; b=lIjmVtQpT+CUi7BO23IRWdJ6Ea3o+k58wsactsv2LoYoOaXnucE6cht3N4+qDYSNC0qVoH1FhCS8mNfnffJNtL6v4pgAJtC3HmlSSuHWOxjNQu9jXiRZfoagPlC9KO9OkQW1MbZPkhTk5ZKmrSyryBX/4/qv6J5wSPtDeb5WCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165667; c=relaxed/simple;
	bh=5XfS55EN4bj5QPY46V6t4BYAo27rzcuYqURs6dSESCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBlUolkbxW/AoMyWNsXJH1jyvVq+y9xVOMR/fLUpKw96EYMMhqowNyiIMS01nojI7Nf4JkS8CQEMhAdoImkKfLXP2m8SGjEzxpzV/SjIRGu6XzkBi7pTo/v3/aEZTTLap9uIx7RsPfFKxqhdtE/zT53hSXjlycjw/ahHTS37F8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nB2eI3+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvM0Voub; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nB2eI3+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvM0Voub"
Date: Thu, 7 May 2026 16:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778165658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VqblXCRKNyHMLImrYpvFEMT1rA3y4jTKAga3t+zUXo=;
	b=1nB2eI3+qiu8j9YmpTCDVRTbPlZ51QhAvP3f5+t3HkbYLisL0ElREzuEyjh0IS9X//d2q8
	IrICM2NhTxJoPfpVIlYnFTJX8fX/LXtke8Yv/+Eko+Qf6OHc9shfG50db+riN9Ir3bca+a
	97XCh0dpKvG5WzaR2+ecGC4bGBWBExWPSvAFf1WdAlptV/RjfcnVFB2ZqNFuAlO9bjs20o
	IL7qdACrARROx0cAYLpzo+nndwcIn9e8TEZ0RCQUtKDloJYBjd+Wh94+r+Ug8gUK+ZGhbI
	b/VrarlPbMTPJDeM+BCYh6a2H4LznFwd35W8CdtrIGtAH+GwkLM0WpEG38Gs7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778165658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VqblXCRKNyHMLImrYpvFEMT1rA3y4jTKAga3t+zUXo=;
	b=YvM0VoubD8doF3g4uqGlJStfDKllP4Ks9G2jZRmF9svFmHiBK6qSBsGal4puY+/sJtyTys
	SHXYWlmREO43PMDw==
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
Message-ID: <20260507145416.55hJZOWT@linutronix.de>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
 <20260507071235.rdb4aGeE@linutronix.de>
 <f0f447dea6c8f2deb7f153f745add15d3ecadd19.camel@infradead.org>
 <20260507132115.w1nOBvlS@linutronix.de>
 <e082f19aecf2d2acd30782ea9220aedac3d3f990.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e082f19aecf2d2acd30782ea9220aedac3d3f990.camel@infradead.org>

On 2026-05-07 14:43:20 [+0100], David Woodhouse wrote:
> Thanks. Something like this?

Yes. If you could stuff the below into the patch so it does not look
like fixing symptoms.

> From 7199173d543d25333418537bcf07d6b2fce18ff1 Mon Sep 17 00:00:00 2001
> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Thu, 7 May 2026 14:39:22 +0100
> Subject: [PATCH] locking/rt: Use raw_spin_lock_irqsave() in
>  __rwbase_read_unlock()
> 
> __rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
> which unconditionally disables and re-enables interrupts. When
> read_unlock() is called from hardirq context (e.g. after a successful
> read_trylock() in a timer callback), the raw_spin_unlock_irq()
> incorrectly re-enables interrupts within the hardirq handler.
> 
> This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
> context) and can lead to IRQ state corruption.

Using read_trylock() in hardirq context on PREEMPT_RT is safe because it
does not record the lock owner. The read_unlock() acquires the wait_lock
which is hardirq safe. This change additionally allows rwlock_t during
early boot.

> 
> Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
> preserve the caller's IRQ state, matching the pattern already used
> for rt_spin_lock/unlock.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
