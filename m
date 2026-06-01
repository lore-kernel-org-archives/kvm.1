Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C05364024
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341254; cv=pass; b=ZimhCQFuK603odJ/eTaXjF3bvIDWC08JYnQPf5X6J87EcLvAcZkMv9BU69oUsxqLf6eND7AxLeGuxQfExPFY7ZSzjb0yjIR61wyRhwRKdaNsl1LNfXpYWqSH2rm0TXLYb/J1ajSLzlO37bY8KsBNWUvjYZJE02NLV+3e//4o+4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341254; c=relaxed/simple;
	bh=UNKcK2enDt3jC65DDXUqCzLzvisBRwbhO3vlWFeN/uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMlf44x7ke5sZbbdQlN3l5zEWg28AcgAePW6v6N62NvDOSly+OAYIDmAGc520v8eHfPrBBSYS6FFoQe7pn7GmXbciQk4JLbXMstnpvvDJ0WIdZjV+HWEXIu40rYNZVIqsMWNq6PClilDUT5HexLtiVmszUraWa9FtgE9mbD+jZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3TDAM+E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGQ+6Age; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3TDAM+E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGQ+6Age"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780341252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEKNvAsba0SJLtrb9a8gYF0KmbXHuHrgrDPG3w5Eya8=;
	b=O3TDAM+EqClM1/cs//RgDrECcjq0btyeGU7winw6yZy1dAP2Uu5g/bNGyE1JzwkwvW9mK7
	7VmTdEFmHkyBfaTa6RJUa2hjDHmOlee9qiZzsAmnFBKy6PZqAGRNtYK9jBCodQZCaErL4w
	cCA8H0Tbb/jBAe/l4MW84M83QXgpjXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0UPiyB2BOU6UmgXA809Zog-1; Mon, 01 Jun 2026 15:14:10 -0400
X-MC-Unique: 0UPiyB2BOU6UmgXA809Zog-1
X-Mimecast-MFC-AGG-ID: 0UPiyB2BOU6UmgXA809Zog_1780341249
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45efa7755faso1067557f8f.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 12:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341249; cv=none;
        d=google.com; s=arc-20240605;
        b=eni5R2/CWSynNRE2virpuoofi69wOWHelxJ6repE9OCY5AftKbtEb/sSsGuPXukXEh
         RaESvBdxZgHcgBkjgEjwUj0iIZasFbtBwqfEMhPNhK2JGsp7mjicNy9sfFOfIzNVZe8o
         ID2phtTEAM/6H6wjt11n3UAR6dGUswDjz7G0Tyq9Ybk2b6kGA076G9hhsX7IMBCtwDR7
         stw5aqCv7RHN3yDbtkBXunOoLAZdsJn5O11tJ6KKt8w3VEmvUY4O1VprV7OhHsQCqFHO
         M/H3lzWuK2s4cc675cbfvOvQearNse+ME6QQF4Q2jJYhw5frgTWkog5ZAWvCdfquz90W
         3vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fEKNvAsba0SJLtrb9a8gYF0KmbXHuHrgrDPG3w5Eya8=;
        fh=kvvzu4IoFYKGzhWf4WN4rhrFiQ6wR7YyytogOZLWPpM=;
        b=evlGMKpJWD7lwFiem1D2mydxxLv1OhtP7v1To9mY1gf17F9J39Sb+GdOt8jWbP0qjJ
         TCLiUh5yk23PVgcxXErk9x7Ica5v+tYqMSKratW0RBXXeRS2zyT/QNEGWC3y/mqZ22wt
         VX9cWfkhXCzLGpHNb9uPb7Z72Xx19E0V+tvTqMCU98yNMgiy938+ko/1QPNdtm4Wnbkq
         rymS6PfgfTUDPX+wAEX78OxeQeK0taS0y5TN1KJo3THNw0ZxznjTYQKS90VtRcBAn5Lf
         i+JYhsAcdPOf/6wqkYidxgRq4ZD/smkB9BNnGC1AkOP6iaEtK7qAoW6OmW1r1dZz1YEw
         0OpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780341249; x=1780946049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEKNvAsba0SJLtrb9a8gYF0KmbXHuHrgrDPG3w5Eya8=;
        b=SGQ+6Age1/PI6bFSkFMYwM8py6xxMsIIxWWZYpxCIp/8P/b2a/RQtIsjxK4Ln6nQiP
         jM+QpxOu3WnLgDGpMzrn1PoTMUEphZF4P9fL0QK5XmvqgYKCjz+OrhCg0bvgOA/7sx4x
         BGQfyZfcgk+dBUcaLTT4Gn40NEbK7aNXBTuzxocbJriPE47Zf82tZfqa2Ca7KNXFJiaq
         0HdZyAGw9l0Z2Dxd5DI8taYI3gnzTKVphTFEHpjRWImYEHNqXkB5clLcM9iw1OiX26FT
         IltHhEBmRymtsaVSXr0c3cVrrGCKx3evOTk/nFRB4JOj5cWluBJdjzJ2Yhnd/m4+R1Hz
         OJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341249; x=1780946049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEKNvAsba0SJLtrb9a8gYF0KmbXHuHrgrDPG3w5Eya8=;
        b=YnlJL9M/ZIAONRA1JYfD84FkbkRuyCXJOhAAGR2NtbD6YGz6QeD7nrhpUjtXj5FniZ
         EryagGjcRfTMDezLkLhKGEwiT+ZUVlUwmOlgbNYal2BhzbzbUfqvsE5UcSyiAyRL9QKy
         QNWRyEpr4Ykpo88NBF1ySobJ7hsdgPoq0EZkpd8E8cKg1xmFSkh+w0SSot04ARrNfR09
         SnD9tZwSuwqyRQ8YB5jDQAFMfXAZa8B5/jvLnPRt44ckdWAv+92jQMY3LhXM1CNe2AQM
         ZOw2lkaEjM+pk/BM4vQtA2FpiJ2bRyYSXG9A90emqIT/HbavvNtoff8Zr0haN1IM4WNY
         oaIw==
X-Forwarded-Encrypted: i=1; AFNElJ/vrSA1UTDqgnujZrWHWAvie3nmdpkrjb055abxA1vMUwoyBOpbYnbdEzK42lTKFCpEV/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyy1SBrueavoDfYTc6sBlEmdalAfL5fJ/4m6hi1fUmyvGXOmfZ
	nzg9VNA/gf+frwER5UGmlvuLRdf903878Zw7OoAjlEmhwwGRGPIDdCfJEf2C53i/OBdH6YNYIVG
	zln2bltFBpI67SmV5PInBT3ImCzywJuSOZd75fr6GEXLInTABbdEGnlh/pn02eSxsDczNd6HEDK
	PfZInihZKJPT9lfIsBOMQBGVTtOniK
X-Gm-Gg: Acq92OFkavIdxakCt/R7TbXvZIRlHjHEreyMCg61NJ8kNGRMomelqYiKtkHKFkrj5eD
	ltCm9vnqcpRJImBRC4E6aFPdp7xCn0EUA4tmzYXZk3SW50dKc5DDV/Eyc9g59hIQfgXKn2/+bIB
	s/lGsAWGd/897UhexKHQjUi1+vZFFQbaJOEqREXUkREkATRUbYKjgQRrnzKKrvR66ui7qs9tkC7
	3a3hvT2LJ6GT7xO1FExGKXwe5qY/TrAiT0msV1NSYuaVJyv+pII6hLe1s0DvDqHWiENumRhlOU+
	22jU31POocyF5e81Fg==
X-Received: by 2002:a5d:624e:0:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-45ef6b836a9mr18687188f8f.33.1780341249351;
        Mon, 01 Jun 2026 12:14:09 -0700 (PDT)
X-Received: by 2002:a5d:624e:0:b0:45d:3aa3:7f76 with SMTP id
 ffacd0b85a97d-45ef6b836a9mr18687146f8f.33.1780341248979; Mon, 01 Jun 2026
 12:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com> <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com> <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com> <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <20260601084045.GL3102624@noisy.programming.kicks-ass.net> <20260601111109.r5gExfB1@linutronix.de>
In-Reply-To: <20260601111109.r5gExfB1@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jun 2026 21:13:56 +0200
X-Gm-Features: AVHnY4JzM-S8NeQWY13Kkb4jUkr8kZy4SoNBK-bPIujgrxYd175jxRAMyQ9Zxuo
Message-ID: <CABgObfY8_J4D5C8CHMSuoa7c4-PnVxY6CCVgGO+yq9E_5NYtxg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Il lun 1 giu 2026, 13:11 Sebastian Andrzej Siewior
<bigeasy@linutronix.de> ha scritto:
> On 2026-06-01 10:40:45 [+0200], Peter Zijlstra wrote:
> > > When raw_seqcount_try_begin() is used, the typical action when
> > > the seqcount is busy is to take the same lock that the writer uses.
> > > Another possibility, found in kernel/events/uprobes.c, is to delay
> > > the work to a safe point using RCU.  Either way there is no need
> > > to guarantee progress of the writer under CONFIG_PREEMPT_RT,
> > > because the caller is not going to call raw_seqcount_try_begin() in a loop.
>
> This does not happen. It only happens if the associated lock is
> preemptible. This is not the case for uprobes.c so there is no lock/
> unlock.

The uprobes reference is just an example of a different try_begin
pattern, that does not involve taking a lock but also doesn't need to
guarantee progress of the writer. uprobes uses it without a lock but
that doesn't have to be the case. I thought the commit message was
reasonably clear but perhaps I was wrong?

> > > However, raw_seqcount_try_begin() currently uses seqprop_sequence()
> > > via raw_read_seqcount(), and therefore does a lock/unlock of the
> > > write-side lock on PREEMPT_RT kernel.  This prevents it from being
> > > used in atomic context.  Use __seqprop_sequence() instead of
> > > raw_read_seqcount() to allow it.
>
> So it would work if there is no lock associated or it is something like
> raw_spinlock_t.

Yes, in which case the patch is a no-op. But in the KVM case that we
are thinking about in this thread, raw spinlocks are not needed
because the atomic-context read side would just punt if try_begin()
fails; and unlike the uprobes case, there would be a lock involved.
Since it'd be possible to use a regular spinlock, this patch would
help.

> > Yeah, I think this makes sense. Thanks!
>
> Do I make sense or do I miss something obvious? On the other it would
> make sense to have this even for spinlock_t assuming the try_begin
> version does not try spin and expect to make progress (which it does not
> for the current users).

That was my point. The lock/unlock is not causing any current bug in
the kernel, other than maybe some minor inefficiencies, but it makes
try_begin() subtly different for PREEMPT_RT kernels and the "obviously
correct" way to do it isn't the right one. Having to use &s->seqcount
is yucky.

The docs for try_begin() don't say it super explicitly, but still they
heavily imply you're not meant to spin on it. At that point it's not a
"try" anymore.

Thanks,

Paolo

>
> Sebastian
>

