Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB72673B0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229060; cv=none; b=MkbvnnWxbKMcMyYquC97DsTpg/ti9JDQXQyH2xDuZERSNP7/WXLZFPxN3wrBzlZ+KPo+yI+Nvqdy1t00VAqJjPgWZbsThNOZ0P3+mUjg4aQUconV0B1RVVrBD3wfXeeBUCBzlPip0JvL0EojryC9kHyGPsct4I0b9Z8x97Jo/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229060; c=relaxed/simple;
	bh=ljQ1YWoZyNqG2Eu8ldXR7iO1+PbAfyknyyUamVEGQ1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lrASIYUaraJCYAJajoQWM9qu/c6nVgsXnoWNpLJSSsRUxTr3B8e1quBqI7JJOIxVa46Mc133Y17BQCciQoD3e4vbFgeQZsewLl9b3gd3NYeV5qf4bC6xrk2bgmSZRq3vvcPjs/Oaz1YS7zBpgOJ1OU4Z//qfrVItqxZlyFZrjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZW6fKjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZW6fKjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAC11F000E9;
	Fri, 12 Jun 2026 01:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781229059;
	bh=t5aOQD7LQX7+cQ10GkWatYHMdzaxYWoXZ72XeGXrPFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZW6fKjXOtkCtmy2Fjnc2i/iP0k3S2slPdfUuL3wIHWDatQTANT7vMSh71pCdeTsJ
	 Lqm+knIiRZoU2BxLPnCa2B/iSrOz22in20XSRKmwJxCSIC1oxNhKQvj1+pX3J8VWaa
	 Cx0TFF/Q9hryNMDz72o1zszN6+H99/fg0OLar1eELlK7uxt5eJ/gZxYGUY0njMNjyv
	 J4yTSZLPu/SV+hEke9qHW9LoHQ9LZZcvpdN8SlVxXRnOaKcdgo5ZKBMSQMdOLHo6dN
	 Rfsw2kIoaDFvgp3lgfE7B/cmdRW0gs1a1Av2e7D44TEhXB7XNnxQyttbm++q+mjg7z
	 fEIKkNEW5WH2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] sched/fair: Force a local resched on
 yield_to() so the buddy is picked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-6-kernellwp@gmail.com>
References: <20260612013355.59231-6-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:50:58 +0000
Message-Id: <20260612015058.DEAC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double clock update triggers WARN_DOUBLE_CLOCK on the local runq=
ueue in yield_to_task_fair().
--

commit fb0067f31069bbf43450f383db09dc5489957b42
Author: Wanpeng Li <wanpengli@tencent.com>

sched/fair: Force a local resched on yield_to() so the buddy is picked

This commit modifies yield_to_task_fair() to force a local reschedule when
applying lag credit, cancelling slice protection and calling resched_curr()
on the local runqueue. The forced preemption is rate-limited to at most
once per 6ms per rq.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48f65a4f19230..e9c5265cf0fa9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
[ ... ]
> @@ -9485,6 +9485,83 @@ static void yield_task_fair(struct rq *rq)
[ ... ]
> +static void yield_to_local_force_resched(struct rq *rq)
> +{
> +	struct sched_entity *yse =3D &rq->donor->se;
> +
> +	yield_task_fair(rq);
[ ... ]
> @@ -9504,21 +9581,22 @@ static bool yield_to_task_fair(struct rq *rq, str=
uct task_struct *p)
[ ... ]
> -	if (rq !=3D p_rq)
> +	update_rq_clock(rq);
> +	if (p_rq !=3D rq)
>  		update_rq_clock(p_rq);
> =20
>  	for_each_sched_entity(se) {
[ ... ]
> -	yield_task_fair(rq);
> +	/*
> +	 * Force the local CPU to reschedule so the credited buddy can be
> +	 * selected instead of the protected yielder;
> +	 * yield_to_local_force_resched() also does the leaf forfeit.
> +	 */
> +	yield_to_local_force_resched(rq);

[Severity: Medium]
Will this sequence trigger WARN_DOUBLE_CLOCK on the local runqueue?

The patch comments note this redundant update is only warned about under
the default-off WARN_DOUBLE_CLOCK.

However, update_rq_clock(rq) is called in yield_to_task_fair() setting
RQCF_UPDATED. Then yield_to_local_force_resched(rq) calls yield_task_fair()
which calls update_rq_clock(rq) a second time.

Since the flag isn't cleared between these calls, this will trigger:
WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED)

Is it okay to knowingly leave this double clock update, or could it cause
spurious stack traces for developers actively debugging scheduler clock
issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D5
