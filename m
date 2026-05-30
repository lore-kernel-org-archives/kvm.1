Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9622F6591
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102455; cv=none; b=onOTqcyjfaogtV3RTKF6QvciJhKDZeyjk9pNFYLyph1Igxu6yTkhqWsOZxOH07/MCd2ng+4v7vdExf6Cm9XP2Sl1DMHjqzK3+S0j3b+kaTf9/YrthdcHd4365D1T5Y5Y9U8GivwLLZghHZ5xO/n77Z+zoL10GfArhj81LzjqCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102455; c=relaxed/simple;
	bh=Uyf2v9i5Bgh3K6vN/tQBOUzmr7rOxXaZN1R07Nkp9KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJKc/lWgh4nvolZYEFc62ouVBNc2yfxfvhTCiKvnbmdzxndm/++TzITIowO3FASxxNgeKBi14nbcyKqUFKeElgENr4SWUhtrWWlrc4rlIuNFJSAexQ2eGMO2soAPz4vI4x6T4sqLDVSY9C2DTOKG+4CR/9gaitG4zMnYCP6Aqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbfTSDY7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbfTSDY7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf160f7191so10066335ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780102452; x=1780707252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EimLeomyuHa/Isl8CJDHQMGSGuAmKMQVOAnH/aluLug=;
        b=bbfTSDY77ZsqjV5p6yeqTVOcMsKMM4zAkPnYbXE4efH35y+48iZ1p61TQ9IadUFafa
         89+PmQeN4DglVo1cEATRG2i78gzxRDs05czqJJyJY3LO9mCpep1VCdzZoazKenK+GV+F
         bfk7UV6Ywy5h2R8DsLrjePNuUL/Ofw/ZWOI9VEPk90Fnn+T6t9SMo11GG8obAPq5k89Q
         4iUNF2wecF98a1iMHJOJHaLALwev81XMSzVWigMsoi0v9J9mL8sgu/+6AgtOyDMBZHAq
         HgzElFfAP5G1j+Hj26YpPDOxT16D+hc/85pBKPHN/nH1evflZgaI0G0tQlU03GDIfnjL
         2hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780102452; x=1780707252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EimLeomyuHa/Isl8CJDHQMGSGuAmKMQVOAnH/aluLug=;
        b=stYFAfIcNavKfxy5nvdjYjwomraD31cubhjnhkR9yrFguj1iqgsRKCqokuIl/tMpyA
         +dsi28o5bXtQPv/ZgTzuagLhEoW2twtZdmjohUleVK6bnVbL23Vt9UuG7MFv/fWn2nXO
         ELkbYGIV8n4LA8kVDODz1+vdsPZ01eEFz9qtOCARfCffwtte4eBYz3ifpoMeapt4obPJ
         7nOUDCl9T6VSMYKT2ZCNrmcHnJzP6Ma2W0aRx3i2N+m4BZXBwtflbLLxEJRLHBxP82ua
         o2GDMDBAdSQo+qYmpF2mDzqDreguz6DTLFLrFLkSPhlc8D4gFK6PzU9REj4/TJh0lTcL
         lumQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oy7C7WoEWNI644MSoZPBAqX39URghVCQB5jTsUk4RbVV8X21laQek1bwzOcs13gW2ibY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiy5alWasll+WGvDlSFweBMr9S3Nt/P+ZMTTjtBct4s0IpfjU
	pcjw75DK5EA+S0KdZV56GmHXARfNpBlpVmT2iucOm+B00xWnBbGHsahbXxGvExNh4aoS8iB8QZo
	cW8BZNQ==
X-Received: from ploo20.prod.google.com ([2002:a17:902:e014:b0:2ba:41dd:4a8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f651:b0:2b2:5314:e96a
 with SMTP id d9443c01a7336-2bf3688ab6dmr23721265ad.34.1780102452411; Fri, 29
 May 2026 17:54:12 -0700 (PDT)
Date: Fri, 29 May 2026 17:54:11 -0700
In-Reply-To: <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com> <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com> <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
Message-ID: <aho1M7fvK1Qzmiai@google.com>
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
> On Fri, May 29, 2026 at 10:13:35PM +0200, Peter Zijlstra wrote:
> 
> > It is somewhat possible to do an RT aware read-write spinlock thing, but
> > it is definitely non-trivial and this would be the only user.
> 
> Furthermore, it is fundamentally one of the worst possible lock types.
> 
> It really isn't something you *want* to have -- arguably even for !RT.
> 
> They scale like ass; per them being a spinlock type, the critical
> sections must be short, but this means there is nothing to amortize the
> cost of bouncing the shared lock around -- which is the 'saving' grace
> of the rwsem.
> 
> For short sections the cost of the shared access will dominate. I'm sure
> Paul has a bunch of graphs to illustrate this point :-)

Hrm.  We might be able to do an SRCU-based implementation.  Full RCU would be
too unpredictable on the update side.

The big hiccup is when KVM needs to reclaim memory in response to mmu_notifier
events from the OOM killer, which don't allow sleeping.  I'll stare at this a
bit next week.  I'm not exactly thrilled about the idea of ripping apart this
code, but there's a known performance bottleneck with mmu_notifier events,
maybe we can kill two birds with one stone.

Thanks for the input!
