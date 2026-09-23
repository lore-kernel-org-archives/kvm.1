Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6A47F3D2
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157295; cv=none; b=kjJBAbbooPAhHQsZ8Iuh+ENsJgLHADVEJYTiU1NnSIdtwYDpoFdVU1Oyby2buUxsqkiIfsiuSpWHFkBIwFN/Kl1v99XUML9By9BzNXj3OBfasmBNpHat3QUjW6KY0ohiO99589GYKuf9Ks9SZjvCMYiyBrr/GpWszBu8FIO75Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157295; c=relaxed/simple;
	bh=ORWzwlnjPxIPXwwIl71ibZqlgxSHR3cDOmeid8ApVjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pupV2mUaFYFg1aHbzyty7KjFRTGhxePitiltrb+puvgHqNXJkpjh3V+uKYzf6BwKjM2tGeTbbNYH0pkbVuI1EBPDdmjfIIa7NZ7wN9IPsrrh3DC9Kw1Pir5xhrqWBW773F5YBE3nqCk/JwrBVOS4zezAF85DDn1uP28vFu+qPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFCwYKrB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFCwYKrB"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so557672a91.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790157291; x=1790762091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/p+TOshpoie9dAYVqfiIsQZZYf+Pgovp0T9es4CnLs=;
        b=LFCwYKrBB4mHn/nk1nuU63ZkQAuECsBU3jvaEOWmoGKY6SrYbkhMlCLr2dPAIm878e
         UnJa9Llxg24VKLiyBTKUtHxEyssLjBEfFcUnlcn2O4ZXQRuFDur4QPk7pmSBVpbeiGFZ
         XJmUsyTPwY3QpzcKKAnEF3RPPvDgomwUycTaIaMcdz22jpJDeXpkvuX2eLuHxoQ+LhYS
         wNr75Yhw7s4h51YTsiIYH92NsIeTcCkx5OSpoKwdIaQpjEX8HdUXzsin3poSheHxcvxW
         Y/kd9mkm6jKANhNS5V1r5dMlxqPDngTGisX3vAd1KrF2zilYWLXfkz86wb7WodSpVA0z
         n/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157291; x=1790762091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/p+TOshpoie9dAYVqfiIsQZZYf+Pgovp0T9es4CnLs=;
        b=WF4fZmCimgPBXtTFzRDCslrOENoxXYUScdt6WklJnF/dGSl6umytBP6Q73CVGtuvjq
         hDDiKGkkPXQUY+07q1t2xaefH6bbQyz0ayY3bGzVnPrQsvgP21gDitAzV/c5ahT5i8yP
         KlGoWSyahuAMgVS1p7esm4+e/Xb/DNEd+A2kejRZQmi7buBjVYHWUCAktXAGdDRdtvA5
         00d38Kme45BS8nV57KGUyx9d9dtgvYtNlwg1HodKVKiT9FrBu5hpk/ssPoUdq/TQpnPW
         mNba7nnnk7/jQSovRiGLhBl8WuZ083IMGJ2AvDBOwB8cAi/QM4+qvrotrE0RTmoDN/UT
         r8dA==
X-Forwarded-Encrypted: i=1; AKwUvBw2GzsSNBYTF1hj8sxXx66QTNrtvqdZeDRl/thMDgtsktQcqZShGXvsJ4PbvzfybSppM6c=@vger.kernel.org
X-Gm-Message-State: AFuF++lJB+0RrdFEN+RI+dOcmWQYMfBvkjG8P1wX7tStaRnE1Z+V3lph
	i5IWjsQyXwYMs2IA5QXxlOgGco9KZrc4eflt+apowb9uG5aHJmEQ4Fr2
X-Gm-Gg: AYBFou2SFrm5E8+vt/Y1DHvm5mlyg8u2C+uDLGGNJoNH+Qx8Ve51qaL6l1qJMOwLWIx
	3g8cViFc8+07cg7ImXzB/BvwPV8de+bLYv3hj8aDWpn0ngeW0jzPTkBMninFnd2GpDwX9MXv7Ly
	kdSmo2Jy9Fm8nMvEKRULUYihQzXKfaXN2aHzIRuXxsxWYSqUevTt0DNYNKJAd4L0kqQ/gXRc54/
	5tfyYZXcHj43UPwuUHuWhIWYkarBs4RMJv0qON2KROmjY8/JFKY1wQN2jeqGZn1B/ftWToGMeYS
	LqXw04jptfJ03hCYLTWHJLXdlobbTcBbUwwqdhRDmJA3LLoeMSTACre6ewTtQomagnHYyfCAfKi
	l96hlm9io9mSsy/jqv/RLkIXf+29r2GHzSlDJ4ebKLTx38t5ZO64NjCVzI00hAiX1Ljr2vTYuWC
	/675xKmmKtMKe+7e3QDCpDnlaeRZtAucgRUdWbfWi2eN451ioUAZiQeoOkMwNvQQ29vEGmiXB6W
	bp2rkhW
X-Received: by 2002:a17:90b:1c09:b0:39e:237c:50e0 with SMTP id 98e67ed59e1d1-3a07e4a2554mr1921438a91.13.1790157290738;
        Wed, 23 Sep 2026 02:54:50 -0700 (PDT)
Received: from gmail.com ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a982esm8000105ad.22.2026.09.23.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:54:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	paul@xen.org,
	paulmck@kernel.org,
	kunwu.chan@linux.dev,
	nh-open-source@amazon.com
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache, reinstate guest mode for x86 nesting
Date: Wed, 23 Sep 2026 17:54:33 +0800
Message-ID: <20260923095435.591542-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <84e1f6c28becdf94ccb72f5c64c0001768167fc2.camel@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 12:37:43 +0200 David Woodhouse <dwmw2@infradead.org> wrote:

> On Tue, 2026-09-22 at 11:16 +0800, KunWu Chan wrote:
> > Do you happen to have any numbers comparing the GPC invalidation
> > latency with regular SRCU vs. `synchronize_srcu_atomic()`? If there
> > are also numbers with the reader-free fastpath, that would be useful
> > for understanding its impact as well.
> 
> Yeah, I built some latency tests and was posting results in the earlier
> thread¹, on a few different test hosts.
> 
> I compared against the existing rwlock, as well as SRCU both with and
> without the try_synchronize_srcu() fast path. Mostly looking at the
> invalidation latency, since that was Sean's stated concern with the
> original RCU-based proof of concept.
> 
> All from the same test: 12 concurrent guest-memory invalidation
> reproducers hammering the Xen shinfo/vcpu_info caches, 300 second
> windows, measuring the invalidation drain end-to-end.
> 
> 192-way Granite Rapids, PREEMPT_RT production config:
> 
>   rwlock (before this series)              avg  4.4µs   max 3.85ms
>   synchronize_srcu_expedited() drain       avg  8.6µs   max 810µs
>   synchronize_srcu_atomic() + fastpath     avg  ~3µs    max 801µs
> 
> The A/B numbers I have for the reader-free fast path were on different
> hardware (128-way Ice Lake, production-like config):
> 
>   synchronize_srcu_atomic(), no fastpath   avg 8.0µs   max 6.0ms
>   with the inline no-readers proof         avg 3.6µs   max 326µs
> 
> If you want, it isn't much effort for me to tell my friend to redo any
> of the measurements.
> 
> ¹ https://lore.kernel.org/all/0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org/
> 

Hi David,

Thanks, this is very helpful. I've put the results together below.

KVM GPC invalidation drain latency

128-way Ice Lake:
┌──────────────────────────────────┬──────────────┬──────────────┐
│ Implementation                   │ Avg          │ Max          │
├──────────────────────────────────┼──────────────┼──────────────┤
│ Baseline (rwlock)                │ not provided │ not provided │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_expedited()     │ not provided │ not provided │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_atomic()        │ 8.0us        │ 6.0ms        │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_atomic() +      │ 3.6us        │ 326us        │
│   reader-free fastpath           │              │              │
└──────────────────────────────────┴──────────────┴──────────────┘

192-way Granite Rapids:
┌──────────────────────────────────┬──────────────┬──────────────┐
│ Implementation                   │ Avg          │ Max          │
├──────────────────────────────────┼──────────────┼──────────────┤
│ Baseline (rwlock)                │ 4.4us        │ 3.85ms       │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_expedited()     │ 8.6us        │ 810us        │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_atomic()        │ not provided │ not provided │
├──────────────────────────────────┼──────────────┼──────────────┤
│ synchronize_srcu_atomic() +      │ ~3us         │ 801us        │
│   reader-free fastpath           │              │              │
└──────────────────────────────────┴──────────────┴──────────────┘
Note: Avg / Max are the average and maximum end-to-end invalidation drain latency.
The measurements use 12 concurrent guest-memory invalidation reproducers 
hammering the Xen shinfo/vcpu_info caches over 300-second windows.

On the 128-way Ice Lake system, the reader-free fastpath reduces the
average latency from 8.0us to 3.6us, and the maximum from 6.0ms to
326us.

The 192-way Granite Rapids result is from a separate hardware
configuration, so I kept it separate from the 128-way A/B comparison.

The only missing comparison is the 192-way Granite Rapids result for
synchronize_srcu_atomic() without the reader-free fastpath. If you
already have that result, it would be useful to add it. No need to
rerun the measurement just for this table if you don't have it.

Could you please confirm that I transcribed the numbers correctly?

Thanks,
Kunwu

