Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608F37F31F
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179117; cv=pass; b=g/6lkjXfsJXfeTLiTWBClqvoRNoiqRiWshyg4iwNijcBoGlkWOEzvj2/zy+88G+42j9Ey4uaHxyYL24J9nO+sW1sumMJIj5k21BC6EhN1CEwbSxrwIo0WwzUjLh+IZweUkPtNFGxTuPzN6iQ/5NYL5wHLqzIwXgPJLwedKqCzlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179117; c=relaxed/simple;
	bh=+BZjU+5sABFAo+aPUsrzZJGuFADNIS4wC9vOaaJtusY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF3wV9bUToUdnF7gEGHKqWMKIKkrIy10JMjflsJ44J0wEd/Zld46mAiGO1gxkzvLgwPBiFfXh4LVwdFfPvqbArYK7dsvX0Jo6R2Zf2yx6Nx3pgc1p1Qu/FAw7d/OClgdVQptUDQ0VF0dKFbbo7H/NJFYrZRTh6L75GXCyDHNxgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwiJitI5; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwiJitI5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so6798305e9.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179113; cv=none;
        d=google.com; s=arc-20260327;
        b=Gvdyb8YCORvEdOYpp/uF+PaGMro+Tts0is5QuYvlxSwVOudIYCch2CoIcaBp7HuE8y
         lpXfEk5Wwf+T50HOE06M/7/J4f/TxfPm13YhlJKDHZK9PB6JNTM7Zb7aSn/z1hzebD+b
         6QYaIDDSReHSBFIBIMKG3GqKEI2AAdGxjGZUVZyood28n5IQG4Th26VXVdKuKQ08frF4
         /REOprIv7KDid4QqO1NJo9xOTlp+xrFOEu5mxltlCMgly9nBs8RtuSQCobYxtNyEOEGp
         OEioBi1n9YgycaAVjY1VF6T2or2W+BIdgTPs8xTQkjui1acF44lHTFwOVmMGZPHXirNG
         4QAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        fh=zzJOfGRijyGYdwXOURCHJRq4oXgzRyahSmM0vYT+qOE=;
        b=lY9iQdxVyfi3WzTAVcDSinPSE0nXJ1yVCwBTzTHgiBNnk9wx8vUuYu4SDAUQNH4Y/Y
         ORSY95lRscJnQvo28yA9s8QyfpmFXdbZuS8n0PFrRY58p6ErVqoShJ7VEgf1ZPd+8jCU
         DdpKC1m1wXVScgFm58tFgshtU1jFUiZjxrf5+THLxy06VxB1W0PR/1+0BzsNu1wsDc6N
         ekIyBxw1nEdCQw3OhtgLOhNZ82vkgyNhGQRu/Ay8MehfShcK+6/OYyXoWBFYivb2i8Aw
         wNyxehkuUCTzKRq1QfJc64691o1zNSF9RADBFIoub55DCw9b390gDn9XQxLBAu7F3gM4
         Dxcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790179113; x=1790783913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        b=GwiJitI5ERcABqLA8malg1cUHFc0a+PfRcWxaoxerrMxh8C1YYJWaIlO9nTJo9aFsO
         qt9lLJYZf0ZWqlZQNFbZ6wTiQKB+Q958h6cOvY6llPH4tc/Cx/Ypz7AdlSLvBm4CHHwn
         WBfX0GwUTLd4vhajB9llQpD4aZTkAskn4DvHwoyv66xGv+gmSVP6Ra0qfaEhxZdPN3qp
         JF+fCvuBeJQ22HacZc6xgv8FNFYV0lxeM+dIVk+K0z77E6RUOOGUbIqxF5oursRIr4+1
         RtvH4H6e7rbzWOnqiAgHYEyxPm3SnPsP9ey9VuRqNXJrONE+tIl6k+pNuHcw8CjTYBBf
         W+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179113; x=1790783913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        b=EzpG/vcakMwK5cVgaAXExM0vCqUb2D/WBpO+ii8SzjKv5pe3Qg8y+HssPiU/Xk5enh
         5a0snwsw407EKrlOp61zWhDT9fjnooG4ilgI15ynWkYAv2YDiz8pQV3i6L8pgZCMkmqO
         yzGhDGLyXsPl7i4Yxb0z37XwP+17DlNDJVhRMHVVne5/RYbTA1e64TL9txDlHB7pq+3j
         p0A7MP/rmg+drc+Jmq6ugdNaGf+FwD16SAozry9lFtmEg0YjiUYu5C04Jfd1GtCImOVZ
         RAUU9UkzkrAd5RSArH4Oz/KX9rSGMP6+yW9757MHz9kOg8UNscI3SlGDcUaz1hweYGer
         FmqQ==
X-Gm-Message-State: AFuF++l/AJTeXK0KemlGKkkiMit04B3X4E20YKM7yNpIUvLXEGgaDrXX
	VqHJc3PWkKfhGauNTut6qo0aHBVjllvFnYWNKMaBEju4RzU1Wn7Qh32T5WfPP6CDNafIdLGp3Cf
	d14C/B5aW//mitsw9ulTAh+KEw2uXr/A=
X-Gm-Gg: AYBFou3ESYbbDm0Gb5PbY0iLYQRP3RLSvA4RBrQKzAWMPV/eFXMrmRdmUeCRDtJwP0N
	WoghtoprlkDLS9EqwKbXPgrSMFsfYg7Po+IUt5YybK9TgBQXPtdaVdNPSLJxkyiGFK4bHckY6dr
	knKVG/yYl1NQgQt0B4+s6KFaPDbHhp5aWo2ca9b6GqiiFktK5W/K9XKDmhQkVRyn6PYwphU6HoW
	Jyu/HZoaPGCkXDKg9Qm7IGViUj+6V30ooSGzzpWD1KjoHymk5uibBP8Uc6FzSPiq+JRRqgtvcHy
	MQ42a0loquA33c9nUit2z8zvmR3DjXND9kFkZq79nUCr9FW6CZCqEzC6vn6mQx1RrPMHRiQ8ApW
	F598VlvnIT5LcMXkgbG/bL0NG
X-Received: by 2002:a05:600c:34c1:b0:49f:bd3c:bc1f with SMTP id
 5b1f17b1804b1-49fdf14d3bamr45188315e9.26.1790179113201; Wed, 23 Sep 2026
 08:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
In-Reply-To: <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 23 Sep 2026 23:58:16 +0800
X-Gm-Features: AclHuK-JmV4yqSDsdpWSQDzp1TbngEWAsztj3vbr93WLLF9_cem1MLtrY6_DvNs
Message-ID: <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:05=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Wed, 2026-09-23 at 17:54 +0800, Kunwu Chan wrote:
> > Thanks, this is very helpful. I've put the results together below.
>
> That looks correct. I had my friend dig out the missing parts from runs
> I haven't posted, and do the runs it hadn't run.
>
> 128-way Ice Lake, PREEMPT_DYNAMIC production-like config:
>
>   rwlock                                   avg 0.59=C2=B5s   max  330=C2=
=B5s
>   synchronize_srcu_expedited() drain       avg 3.65=C2=B5s   max 4383=C2=
=B5s
>   synchronize_srcu_atomic(), no fastpath   avg 8.04=C2=B5s   max 6034=C2=
=B5s
>   synchronize_srcu_atomic() + fastpath     avg 3.59=C2=B5s   max  326=C2=
=B5s
>
> 192-way Granite Rapids, PREEMPT_RT production config:
>
>   rwlock                                   avg  4.4=C2=B5s   max 3854=C2=
=B5s
>   synchronize_srcu_expedited() drain       avg  8.6=C2=B5s   max  810=C2=
=B5s
>   synchronize_srcu_atomic(), no fastpath   avg 12.0=C2=B5s   max  620=C2=
=B5s
>   synchronize_srcu_atomic() + fastpath     avg  ~3=C2=B5s    max  801=C2=
=B5s
>
> The max values here are noisy and can vary by 2x per (300s) run. The
> averages are fairly clean, and I think I have per-bucket breakdowns for
> all of them if you really want to dig into it.
>
> Astute readers will note that rwlock actually wins on average on the
> "production-like" config, that the max is in the same ballpark as the
> srcu_atomic+fastpath too, and wonder why we bothered... the point is
> not just that rwlocks are the wrong thing to use for PREEMPT_RT, but
> also that all we're benchmarking in the above tables is the
> *invalidation* not the read side, which scales a *lot* better in the
> SRCU model and doesn't bounce cache lines around.

Hi David,

Thanks again to you and your friend for digging out the missing results
and running the additional measurements. I really appreciate the effort.
These real-workload results are very valuable for understanding how the
different approaches behave in a KVM workload.

The results also make the effect of the reader-free fastpath much clearer.
In the measurements on both systems, it substantially reduces the average
invalidation latency of synchronize_srcu_atomic() compared with the same
implementation without the fastpath.

You mentioned that the SRCU read side scales a lot better and avoids
cacheline bouncing. If you happen to have any existing measurements of
the reader side, such as throughput or reader-side latency, I would be
very interested in seeing them. That would be useful for understanding
the reader-side benefit you mentioned.

Of course, no need to rerun anything just for this. I was mainly
wondering whether you already had such data from the existing testing.

Thanks again for all the help. If you notice anything else in this
workload that would be interesting to look at, I'd be very happy to
dig into it.

Thanks,
Kunwu
