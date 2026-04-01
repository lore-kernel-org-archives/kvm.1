Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E465382F07
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036106; cv=pass; b=QZ3nIWvw40WJBiC3I2tT6m9LafKjfSw2IlDxqydhmXAoegVUXc6Sy/JNZTWF/ylRR4EjOjo4X4KmXXqLNaamNPItvHAJKySm327QDwcD09GhrI3eUHLkcyIFZvhgy8NKPZPyNXH6snGMhwidWEiAbW9bG3BTMgWwj3+NZCLdfPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036106; c=relaxed/simple;
	bh=XZlv7MnwOp6vRn2EbQrRxzgFCNQ84kBj7dOoPqCCMvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chnomdc+/6Iks6Nl5hSsma3jzuFg/GOHfJEXskWCWXlysiPxL9tDw/2ipTr9P7qfkhlQRJtjvYv8L6k1F5SLYWA+K8OJa1zA1KLw4b/P7O85j9yH53nxR6GeZgq1+LXNF/x8jSQ6YuR2J0PfFPx0RSMppq6Qzngl+GhZt730044=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka7iIH+H; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka7iIH+H"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7f09aa39fso8168991a34.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 02:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775036101; cv=none;
        d=google.com; s=arc-20240605;
        b=XzDYuVMadknQO/lT9hOmlFr/OvsHEKFUbnAE9FhezbcG2/z2k+dV354pzS9Syizhjg
         4Xyvahq2NH41ydKq4q4xRD4xGU1d7BbSReNOxwpwbpbvtI5NnPOUzgOVf09TskCbtYKY
         iGFYZd9K06NdJIFyByKd5jzfz4ByH7CvOftBbc3NJ/KQYR3iFuI9aGbrNBWoMdtR4DLp
         KdX6XPMAa2huygIqebfz58rd5qiewUMRYfAi+gmzL1TaaMsNRUxpcMO8b7xp8DHHp/6o
         2vFjTwDC7Nv3IejZUES8snazc/yivGhNJz75t7Rz8eSKwmqjjAaIwtv9IgdhKpVrPlE8
         8MiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhzuBq7MfC77RRlJbaTyGJxc0HYg1QTtopFsxliF8qE=;
        fh=kM314GbovqhmIJApF5K60fxZAZwMA3xqhXzOWSfVfr4=;
        b=SxJMH0AQHcF5GQm5wT5Fa9d5wO8P4TBnfrqY6BkwSO+qBAdoo7Khjnk1hsVQk7hwMr
         QyMx/xGhDto3qTcRauKZGqUiLP+o8GghYIgCfAOZBkjYgc1VSvkCIi4KsHe31arBMo2b
         ZadepWvGeK6zeexKD/FU4OQ0E/noeV/jaWQJJ/2zxtMU3v6GTbxhaS+WXnCs50d8Q8F5
         qh2yN/uuWc6VbccGVO1VPZJWdqZfMa0EI04HAUEdHcCx0SUejO0doubInHl0bydNdjY9
         61rgXpzDrPTrYNqYrEfGQnfa+nTDgb+0IaFj8+lzm7bcsgkXstKBdKSJscNzqb9WwLaN
         o7lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775036101; x=1775640901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhzuBq7MfC77RRlJbaTyGJxc0HYg1QTtopFsxliF8qE=;
        b=ka7iIH+HHVEsm7s7Q42d5oNraLtRY14j/+CTYNB/dN82VFxuID5Lqt2VOrJFLWWIHj
         1hU3IL+BfTXoqrEnbFGIFo/Dfarg8VHuEZo/6o3G8Euh3baPQCTM9DqM7xBXYjL5Ymks
         qKgZFNOiMonkf6YiXvDZzkHartBM/l6lRWhwWXSkeQiFoIpXTskGC3iupE/rt6sEdwUU
         e2P1DvhCPVGKRUyq8r9Mwuo+q8TWmWIjLXQ28VXRmusCD4T3uZ22XV+4yupOTqo2vMnM
         xj1y3e3z74QkSQrGBaNoGDOgH/A9RrC1Mr9IKHMl8Uf7L7kp8MruMsbMJZ/m4/9hpsp3
         2XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036101; x=1775640901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhzuBq7MfC77RRlJbaTyGJxc0HYg1QTtopFsxliF8qE=;
        b=d0YUVGzKbg7U4ULuzm+K0J8wD8skKd+0jvhInAOx3WRIV4UjrPJdB/2ohxXj6CZKmz
         2mIJM/xiX9XUSLtfe+uMk9orOx1i7C4eglPxkwEQybdwt+hsDV/HoqI6Z/pbtJ+fHiFb
         StW6pee9nUciYEqNu+QP7O7uR4Lvs+d3LnHQl0uqJE7VkB8i4N91JYIJiFCmuTUnVEag
         8WpYsM+fYLmte3cEXAgb4ttrUpPVReiS9MJK6cFAvXOos5CJwoytI4+36bAMJSuDoRj/
         ftTDm5XfxxN2m4/I9+rzuyuhjUIBEpFJH4XjTCyujfpjutQooWDu0t9KeKKEPnNK2mfw
         SOvg==
X-Forwarded-Encrypted: i=1; AJvYcCUShAkE1xN5wFgZvrqld9qCLBevn0ZqY1SEN+F6YheGqhf1mbOJDYmKUSA1KLo0CL6bDYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBE5hyILag8HAgJb2P05vTHF0wEUsUZrAEQQlch/VmcKS9BLKG
	AdthFamUJ/gjYXpNpT7JGTM/bH7qsZU2IkOHOMPoLXN5VE+vojPjhwtF/1gOmjTvQWc8j23xU9b
	omOzsL2ewZy4tC4jnfIGXgxQtdpL2CHo=
X-Gm-Gg: ATEYQzzgonsvBmJ/EUZSqewuSLc7B/+droZOtiKy1RKLTX0nWBVawzyODGeoyy4EaIh
	JkZCV7J1aAoZ9Hn3ladE0Osj5HQNdQ0YuoaM5S1eNwb6H8D/ZFHuQeZrV4ev1N+DPr7IDvygNVh
	woi8zmrxd1KKsK0+70Ks4JfXZIrS6AU9BxrFkVBrJ10Oc+BtMy/YqNUNENidnPJvNXyQVIT5MOn
	kxDY/s02lwijI4ebj/ebkAHGkM9xrDZPTywyk6H+6oRhKppNtbNKYYfdIRt2r9JBA+ov3h5Me7C
	sSWS0s+1
X-Received: by 2002:a05:6820:188b:b0:67b:aca0:3d96 with SMTP id
 006d021491bc7-67fabd0c096mr1515505eaf.65.1775036100549; Wed, 01 Apr 2026
 02:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219035334.39790-1-kernellwp@gmail.com> <9a8c1bd7-5d95-4d79-aae2-fc06c448b9a3@linux.ibm.com>
In-Reply-To: <9a8c1bd7-5d95-4d79-aae2-fc06c448b9a3@linux.ibm.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 1 Apr 2026 17:34:48 +0800
X-Gm-Features: AQROBzAPn1l9DLp3qCVg-LiEg_mdmLEVCxUrsFJYoqAcEPFC96RDITTqj3-T4FI
Message-ID: <CANRm+Cz8Lh+AdsLSSy-u-KQhOpOqBOOAfC1-N7eTO_UM46f6Uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>, richie@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
On Thu, 26 Mar 2026 at 22:42, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Am 19.12.25 um 04:53 schrieb Wanpeng Li:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > This series addresses long-standing yield_to() inefficiencies in
> > virtualized environments through two complementary mechanisms: a vCPU
> > debooster in the scheduler and IPI-aware directed yield in KVM.
> >
> > Problem Statement
> > -----------------
> >
> > In overcommitted virtualization scenarios, vCPUs frequently spin on loc=
ks
> > held by other vCPUs that are not currently running. The kernel's
> > paravirtual spinlock support detects these situations and calls yield_t=
o()
> > to boost the lock holder, allowing it to run and release the lock.
> >
> > However, the current implementation has two critical limitations:
> >
> > 1. Scheduler-side limitation:
> >
> >     yield_to_task_fair() relies solely on set_next_buddy() to provide
> >     preference to the target vCPU. This buddy mechanism only offers
> >     immediate, transient preference. Once the buddy hint expires (typic=
ally
> >     after one scheduling decision), the yielding vCPU may preempt the t=
arget
> >     again, especially in nested cgroup hierarchies where vruntime domai=
ns
> >     differ.
> >
> >     This creates a ping-pong effect: the lock holder runs briefly, gets
> >     preempted before completing critical sections, and the yielding vCP=
U
> >     spins again, triggering another futile yield_to() cycle. The overhe=
ad
> >     accumulates rapidly in workloads with high lock contention.
>
> Wanpeng,
>
> late but not forgotten.
>
> So Richie Buturla gave this a try on s390 with some variations but still
> without cgroup support (next step).
> The numbers look very promising (diag 9c is our yieldto hypercall). With
> super high overcommitment the benefit shrinks again, but results are stil=
l
> positive. We are probably running into other limits.
>
> 2:1 Overcommit Ratio:
> diag9c calls:                       225,804,073 =E2=86=92  213,913,266  (=
-5.3%)
> Dbench thrpt (per-run mean):        +1.3%
> Dbench thrpt (per-run median):      +0.8%
> Dbench thrpt (total across runs):   +1.3%
> Dbench thrpt (avg/VM):              +1.3%
>
> 4:1:
> diag9c calls:                       833,455,152 =E2=86=92  556,597,627 (-=
33.2%)
> Dbench thrpt (per-run mean):        +7.2%
> Dbench thrpt (per-run median):      +8.5%
> Dbench thrpt (total across runs):   +7.2%
> Dbench thrpt (avg/VM):              +7.2%
>
>
> 6:1:
> diag9c calls:                       967,501,378 =E2=86=92  737,178,419 (-=
23.8%)
> Dbench thrpt (per-run mean):        +5.1%
> Dbench thrpt (per-run median):      +4.8%
> Dbench thrpt (total across runs):   +5.1%
> Dbench thrpt (avg/VM):              +5.1%
>
>
>
> 8:1:
> diag9c calls:                       872,165,596 =E2=86=92 653,481,530 (-2=
5.1%)
> Dbench thrpt (per-run mean):        +11.5%
> Dbench thrpt (per-run median):      +11.4%
> Dbench thrpt (total across runs):   +11.5%
> Dbench thrpt (avg/VM):              +11.5%
>
> 9:1:
> diag9c calls:                       809,384,976  =E2=86=92 587,597,163 (-=
27.4%)
> Dbench thrpt (per-run mean):        +4.5%
> Dbench thrpt (per-run median):      +4.0%
> Dbench thrpt (total across runs):   +4.5%
> Dbench thrpt (avg/VM):              +4.5%
>
>
> 10:1:
> diag9c calls:                       711,772,971 =E2=86=92 477,448,374 (-3=
2.9%)
> Dbench thrpt (per-run mean):        +3.6%
> Dbench thrpt (per-run median):      +1.6%
> Dbench thrpt (total across runs):   +3.6%
> Dbench thrpt (avg/VM):              +3.6%

Thanks Christian, and thanks to Richie for running this on s390. :)

This is very valuable independent data. A few things stand out to me:

- The consistent reduction in diag9c calls across all overcommit
ratios (up to -33.2% at 4:1) confirms that the directed yield
improvements are effective at reducing unnecessary yield-to
hypercalls, not just on x86 but across architectures.
- The fact that these results are without cgroup support is actually
informative: it tells us the core yield improvement carries its weight
on its own, which helps me scope the next revision more tightly.
- The diminishing-but-still-positive returns at very high overcommit
(9:1, 10:1) match what I see on x86 as well =E2=80=94 other bottlenecks sta=
rt
dominating but the mechanism does not regress.

Btw, which kernel version were these results collected on?

Regards,
Wanpeng
