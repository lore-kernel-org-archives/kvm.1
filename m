Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCB2C3255
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229261; cv=none; b=keALNkR3xTe50zoCPffwSbOGgQT27VHyrwnwcMFgBvHoFVIhr8nXckDiCiOxhP0UvbgN8apM8RSoBkdd1TgWNQRuTbhTBA5ziLavpJV2P8OSRNtw1Tj9sW1ilXLZAAWmUQrITj+ZsQg3/VrgYdavvZNs9w4r4/1DWREmFGR4woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229261; c=relaxed/simple;
	bh=vyLiZcVswNMXLOpPsaYtQmG7OFvcWQi9v5dWmwxh1j0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JSSQI2nhcZThCivs2KsGDrj6dL47CIn6FIS2X5uB+3fCMKi2s+wsDQCgjjXhe5p3rbFcfuTtEXsx2m2FWFR7r5E80wnWuPUTqd2pvP7oD4wkNuBOZ6NzNhvjRFGa+uWBpLdcXwruNbpyX7AxkS21J38bje36RdipFoH6cTSHZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU9QnzhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU9QnzhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967501F00A3E;
	Fri, 12 Jun 2026 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781229260;
	bh=SqRmUzWUa++K8j99fkMXYzvy/RWZbR+eog5CZ6DO8mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XU9QnzhJY2jmWO04yW8yKi2m9mTGowBfbcP5nWXcRLr76ra/onFgnFWm1cLK8hoO1
	 t202/QOUFFGzU1Rtj0miokji1EdNrke9UaB5R+AZ0Pt1mxdwQHN9og4Iu/mOH5iArP
	 uhMhdphkD3LXNvslDbJPdScAyiuuw1GdtuRXlgew1jM/ajrHbLx/b5wryVMVmYNPYI
	 mEKT3Ux33aXz0vd/09mldklE+FMBI5JFoj3268KS7AhEKlwTN0cusWom81WOO2pea0
	 sz3cydwJdQmHax/eTJ/CQ6BRZdn8FoOFCn4+QsXi3gqAYKceNS/wZlEN+9QoGbeQ0z
	 PYADRhRJxGVGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] sched/fair: Credit nominated next-buddy in
 yield_to_task_fair()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-5-kernellwp@gmail.com>
References: <20260612013355.59231-5-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:54:19 +0000
Message-Id: <20260612015419.967501F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping `update_rq_clock()` for the same-runqueue case in `yield_=
to_task_fair()` unconditionally triggers a `WARN_ON_ONCE` in `assert_clock_=
updated()` via `update_curr()`.
--

commit 18fe3f24f01f55a4b16680e6b460846c6d5e6260
Author: Wanpeng Li <wanpengli@tencent.com>

sched/fair: Credit nominated next-buddy in yield_to_task_fair()

This patch credits bounded EEVDF lag to nominated targets during
yield_to(). It walks the sched_entity hierarchy to provide the credit,
avoiding forfeiture of the yield hint when a group entity isn't yet
eligible.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c28682fedb362..48f65a4f19230 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -9496,6 +9497,43 @@ static bool yield_to_task_fair(struct rq *rq, stru=
ct task_struct *p)
>  	/* Tell the scheduler that we'd really like se to run next. */
>  	set_next_buddy(se);
> =20
> +	/* Without lag credit, keep the existing forfeit-based yield. */
> +	if (!sched_feat(YIELD_TO_LAG_CREDIT)) {
> +		yield_task_fair(rq);
> +		return true;
> +	}
> +
> +	/*
> +	 * Walk the ancestor chain set_next_buddy() just nominated and credit
> +	 * bounded lag to each not-yet-eligible level so pick_eevdf() returns
> +	 * it. yield_to() holds both rq locks via double_rq_lock(), so touching
> +	 * p's cfs_rqs (possibly on another CPU) is safe; the primitive is
> +	 * idempotent, so no rate limiting is needed.
> +	 *
> +	 * Only refresh p_rq's clock when it differs from the local rq. A
> +	 * remote p_rq must be refreshed so the per-level update_curr() is
> +	 * accurate. In the same-rq case we skip it: the credit is a
> +	 * best-effort hint and the rq clock is recent enough, while the
> +	 * trailing yield_task_fair() would otherwise make this a second
> +	 * update_rq_clock() on the same rq and trip
> +	 * SCHED_WARN_ON(WARN_DOUBLE_CLOCK).
> +	 */
> +	if (rq !=3D p_rq)
> +		update_rq_clock(p_rq);
> +
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> +
> +		if (cfs_rq->next !=3D se)
> +			break;
> +		if (se->sched_delayed)
> +			break;
> +		if (throttled_hierarchy(cfs_rq))
> +			break;
> +
> +		eevdf_credit_entity_vlag(cfs_rq, se);

[Severity: High]
Does skipping update_rq_clock() here trigger a WARN_ON_ONCE() when the targ=
et
task is on the same runqueue?

Since yield_to() acquires locks via double_rq_lock(), the clock update flag
is cleared. By skipping update_rq_clock(p_rq) for local tasks, the call to
eevdf_credit_entity_vlag() will invoke update_curr() with an un-updated clo=
ck:

eevdf_credit_entity_vlag()
  update_curr()
    update_se()
      rq_clock_task()
        assert_clock_updated() -> WARN_ON_ONCE(rq->clock_update_flags < RQC=
F_ACT_SKIP)

Can this reliably trigger a warning when yield_to() targets a task on the
same CPU (for instance, via KVM vCPU yielding)?

> +	}
> =20
>  	yield_task_fair(rq);
> =20
>  	return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D4
