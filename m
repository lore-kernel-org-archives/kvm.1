Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BF3A8737
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085119; cv=none; b=hX0xOeTKfsYbU1expQgNKwmsFy2Ohlt3dGpjimc8CLvg62Th7VHyPk1KO3/ZpLB1Jp3r0H9Og/XOz3BaXaQ2wUlH3axwnmalpLfSiUTWWXwF5ahRdJM6yLXfRQQlSE8T8TLIINtzYbjqxztO9vAnJ0DGwXOwXt10Y0dqxTv+r/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085119; c=relaxed/simple;
	bh=YRvOHpXsmCrEMm+kSTF+j6/D+gOxA+mUv89utwi3aT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oh8VSQzcemqrl6bXnIBmpg4zjmhtcVL9ZJxm/7xP3D2vG8+H5kcBbqsI+Inejl7TRKkzT2bSu3DtbwKHovbYTIRZbqm8N5YmOZ3Q935ZMa33T18kyBOEAlCscaw5oaboB+/tw3vOVBUg4KjDD2rB/mKGmjF2AwM6s4OqrLFtudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XypSRmsX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XypSRmsX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-841f09a96ecso1625543b3a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780085117; x=1780689917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTSbW6FvUqvuaNYx1PVBd1vrsjDa/4Yb+rd2TVAoZBA=;
        b=XypSRmsXbYaTshz5l8L4YhasbMAefd/zN+yNgHt2Vori7N/t6/6lnKa32syVgmn7gl
         hS3oQKFfGpnbcK0/CgVbLAeagGfncNWvYv9lhQew0bwmibJbE13lV0d+cf2Xevo1uFg7
         R/k/OBTzH39sVfG0KpiL1hogBxGkTu/L1SoMvTQatJcN5umhLcHVypOkZ0DJydMOrXRT
         Po0sCi4KalMuwJjFy6bcwIb6dcJywjfl0EGJe9wLM+c6hq6XrEhXMG/Qdu30J5To6RJQ
         GmqmtyuxSQPozyiOLnK8uG3+h3iRywQD1cFPgJgYtNv7hnDwHunDj3bCFj3Fp++Ii935
         +0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085117; x=1780689917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTSbW6FvUqvuaNYx1PVBd1vrsjDa/4Yb+rd2TVAoZBA=;
        b=KVHmifgp0pyJypleRSA7ikyx60QnZtmGmxAr1JHBw7/jhak2Iz0cKdQZKS5xISJJlZ
         7OLFi48hRjVJld/udo2OeKy5wK10tpBTNUQmFvscjet2fdrRNL7kVXNmUgVdb88obJdB
         Ewrq5UL1iGxtqfCidpCj9DqSeblmf2fHoi/SgQB5db750cnx6biq3OZZ+gwcHzvLE1Kw
         pvGh7JejYFrNwgTNJxMn1a+tJT8mKOllB+690+6xN2tkerMbxE8OgVpIU5+lsKECNUie
         M2ms7h8DHVjU3I6BZwQ63hX8vRe7vj87VjJYabjOVU3p/5QJIY3gbzFO92HRzr7U1wa6
         KssQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wx8d2iSonpiHmjKXEX5zBQivmPvZhhvXbapbaXqFUKls5RfsO3X3eHsLLwH+gxS/u0wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlm8NvDLhCeM6qc/s3f+Qt2oSoDm5ISYxKeBCjX3SJ9ZUpSe5
	WojQ/TIypF6io9PJrFsgm/O1HXYJuLrJJY7kXpcAa1+WsF6j/5yuWOOonaEJSKr6LTB460Qp3ZJ
	c13TC8Q==
X-Received: from pfwy7.prod.google.com ([2002:a05:6a00:1c87:b0:842:bb5:c63a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2886:b0:841:edb9:4ea2
 with SMTP id d2e1a72fcca58-84225446416mr893870b3a.32.1780085117162; Fri, 29
 May 2026 13:05:17 -0700 (PDT)
Date: Fri, 29 May 2026 13:05:16 -0700
In-Reply-To: <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com> <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net> <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
Message-ID: <ahnxfACTGeVFbJMk@google.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 09:32:14PM +0200, Peter Zijlstra wrote:
> > On Fri, May 29, 2026 at 09:50:55AM -0700, Sean Christopherson wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > 
> > > __rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
> > > which unconditionally disables and re-enables interrupts. When
> > > read_unlock() is called from hardirq context (e.g. after a successful
> > > read_trylock() in a timer callback), the raw_spin_unlock_irq()
> > > incorrectly re-enables interrupts within the hardirq handler.
> > > 
> > > This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
> > > context) and can lead to IRQ state corruption.
> > > 
> > > Using read_trylock() in hardirq context on PREEMPT_RT is safe because
> > > it does not record the lock owner. The read_unlock() acquires the
> > > wait_lock which is hardirq safe. This change additionally allows
> > > rwlock_t during early boot.
> 
> Forgot to reply to this; it is safe with this implementation. If we were
> to ever do reader owner tracking this goes sideways real fast.
> 
> I really think this is a very bad approach.
> 
> > > Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
> > > preserve the caller's IRQ state.
> > > 
> > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > We have very specifically not supported the: trylock+unlock from hardirq
> > (although typically this comes up for mutex). Specifically with PI this
> > can lead to trying to boost the idle thread.
> > 
> > Consider doing this from an interrupt that hits idle, then idle becomes
> > the 'owner' of a successful acquisition. This is absolutely broken.

I assume the only alternative is to implement raw versions of rwlock?  Or do I
understand all of this even less than I thought? :-)
