Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138392D3A69
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116227; cv=none; b=bEMtCBONypM9ZZ1DGo8lamdxUAd1SMOh1L07r1BYjQ/0fyjpkUY4e0R8/ALbQ6MkoP9eHCzJuMZ4WE4bqY2vNegmLTRw6qKW19c8o5DimaMWhJqAsqC4fs+46Mfo0qMoTXO15Li3PZTMwz6SEPKeHhHuHXDHAriCI0sCLkO/IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116227; c=relaxed/simple;
	bh=Elnvu9furEu/ztS9zq0SkNzxVGd9cQg43KQVGcjOhxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxdpAIGQxfceJM8j6ijoQPug1qvQFeTePGAybYOf33Z4FzNImfdN2W8D0Zg2MZmaDnK7OTE/zUXzCMVw/q4oW/hwOGzMEd4G8JyvxlQUECuxq+CK8C6mYuQVSS+MktuH1P4Mptkcf8KMzzaOEVkcPOrsClOSE189z9APoJje2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/ICZ2Ll; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/ICZ2Ll"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso1204643a12.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779116225; x=1779721025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05QvXESHzht6SKwXdB2TnOLmDlNSI2T5bkeQbYxEoOQ=;
        b=l/ICZ2Ll4C02SU5GntHOVlmG6zOJsuQJ+ZruXMy8p+DBh6smcA668AAEzPuY3fsYQU
         HIjIDAghPi9HyYDx5HaZbjliZXW7RLwpB7MDYrSUosRB8kwWLn5R6XM4W7Y/Gk4/LYAn
         y0HS8tftO+POyQCjlXU4+kWSrMERtkXqNh0VH5zPkDh61YIaHOhqZ6XAxkLIVpxRWuAE
         ksMUzYqkvmUFSPB6fxJKIzTgaTT5YcA2FPjT2QwFKDaHwyLH319Nb0mkrrVJzjekwE04
         EUXNbt/2XPn69QZprsH3jCNAYdFLfpZ0Xhwo+r5x4cYey/FIj3iobPZLskYOfk/S+vCE
         asiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116225; x=1779721025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05QvXESHzht6SKwXdB2TnOLmDlNSI2T5bkeQbYxEoOQ=;
        b=HR9d1x12WbYBVcsc0ctzy5Vy3n4Zw1RaxmyfTygnaFZmk81n1iEm9tNMTOXLKkJ6yO
         mk8TuQpy42ihgtoR9qwIU+96eD50ZOEPzKPs5Wo07+NZ7G5NMc5WBg/rnpSXFXKNMtLk
         KK7Q4sCbXh5XP5KKCs9AxEAQz81zvl9q80kZQ7a3f6B62uqyMPvGR2KCzt+tbEbXG2VN
         P/vHlLb+Y4n8ZZBCg4efqrxROmpanK/I0m7m2JTy+rmQY1I/TNjNSeRTwmLOgdjlW1KL
         tSsNdv8tuh/Bs1kQZYfHYYkM2Qtwjg7rEtD2kb7Mmob0FSDwc210h/8vV9Fo9ZHycXQr
         N6hw==
X-Forwarded-Encrypted: i=1; AFNElJ9sOfiqSOGy+AG/SSXlyrf0ldINq/Pi/8sCdzfOYbe65L9EG/TB7XEYX4ipniVx258xopQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiukYGmPLOh692/USWsubFHJTUPrfrTi6nDMAWWswf2iFi8Ub
	RHMe2tfYRDxyR04JSXln+gYCYahYMt4hpSFwFf+K50EhF/RkQ/k2bGEL5Yy0AOIVl1lYIWSy6cX
	gd2873g==
X-Received: from pfob24.prod.google.com ([2002:aa7:8718:0:b0:83e:f637:eeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3992:b0:82f:de7:d29
 with SMTP id d2e1a72fcca58-83f33c60b33mr16095263b3a.31.1779116225096; Mon, 18
 May 2026 07:57:05 -0700 (PDT)
Date: Mon, 18 May 2026 07:57:04 -0700
In-Reply-To: <ccae4c1b-719c-4bbd-9f2c-251364fa4fb3@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251226062741.4014391-1-yanfei.xu@bytedance.com>
 <agdrZMRR7oDKZNDK@google.com> <ccae4c1b-719c-4bbd-9f2c-251364fa4fb3@gmail.com>
Message-ID: <agsowFVyWElj7zMM@google.com>
Subject: Re: [PATCH v2] KVM: irqchip: KVM: Reduce allocation overhead in kvm_set_irq_routing()
From: Sean Christopherson <seanjc@google.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	caixiangfeng@bytedance.com, fangying.tommy@bytedance.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Yanfei Xu wrote:
> On 2026/5/16 02:52, Sean Christopherson wrote:
> > On Fri, Dec 26, 2025, Yanfei Xu wrote:
> > And if we're going to allocate one massive array, then we definitely should get
> > rid of:
> > 
> > 	/*
> > 	 * Array indexed by gsi. Each entry contains list of irq chips
> > 	 * the gsi is connected to.
> > 	 */
> > 	struct hlist_head map[];
> > 
> > and kvm_kernel_irq_routing_entry.list.  It'd be easier and faster to have
> > setup_routing_entry() simply iterate over the array.
> 
> if we get rid of these, we need to add a new field to record the offset of
> entries belonging to the same GSI. Compared to the hlist-based lookup, I am
> not sure this would yield a clear gain. Seems hlist feels more
> straightforward?

Gah, right, I was thinking the array was indexed by GSI, but it's indexed by the
arbitrary order provided by userspace.  And even ignoring the case where a GSI
has multiple routes, indexing by GSI would massively over-allocate if the routing
table is sparsely populated.

> > Something we should look at (on top of this), is caching the previous routing
> > table.  I.e. instead of freeing the old table, keep it around, and try to reuse
> > the old table on the next update.  That would allow eliding the alloc+free
> > entirely when userspace is changing routing, but not adding or removing entries.
> 
> In our live-upgrade scenario, userspace incrementally adds entries via a
> large number of KVM_SET_GSI_ROUTING ioctls, so the cost is dominated by the
> cumulative overhead across tens of thousands of alloc/free pairs.

Yes, but your live-upgrade scenario isn't the only thing KVM supports :-)

> Per my observation, the per-call alloc/free overhead is fine; it's the
> cumulative cost that hurts.

That might change with vmalloc'd memory, where tearing down the mappings requires
TLB shutdowns.  And as above, even if it's not a problem for _your_ scenario, the
overhead might be meaningful for other setups.  If we can cheaply/easily provide
meaningful performance benefits for such setups, then why not...
