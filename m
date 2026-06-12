Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EC2673B0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229229; cv=none; b=iCAQqgmtqWdXjs1r0XSQ+AK6Lyth9+v8YoC16nNY7B8dpDW8Kh23GqjRVus5qTH953ayFzxsNfWyjga5vuyX4C+ySKVXYF7IPbmFELvNIURdUoueFtpnZn3YwKHHvrhEQZ4lMRdebnQJd4T9LvuI9vvS0R8mGWyFn+aEQmfbMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229229; c=relaxed/simple;
	bh=gtggslKuDNfQnlQGIezbZJlRXLChlt6KicvlEeSocN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dd5LQAeTRGaWoZ5wwtHCkeoDXRUv5mHBplF9Qz0ed680Z+IXUNr71OQP7G+ELNtuuHIQZVjZqb7drfSkV1ke27v9/1WezLJQZUSAwK3cD8gP9p0/Ns6W7DVyzyrUfOZYflVH7kobafgJfuOmBsbn8qGoGz0dSgnjlfGGJTbd2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2Na0nZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2Na0nZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13311F000E9;
	Fri, 12 Jun 2026 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781229227;
	bh=eE2ujfI971in9D0Zii1AQa7exK+zhfZKLRJ/QPFQk18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2Na0nZ4lnUOH0ZTE9Bexe18NZozAIZ3NWWFNIMH1teMfmKJ7XohoKHAsGV74s0bK
	 yGZk1qNnU4gr26t5asoVfGTfenoUp8khOakzI9CqFCj7QQBxK5b9xBjpk1JazCiJoK
	 XspQjD6ZSXrJhN8uxBLkJli5gEOffOQk5j9k6ousaOkak98Ot9n9nGPNRhx9CGNBXe
	 rt485qTY1V+AmwvnYbGyuRvH0pySx1Q7vVQuyhQLZHC4DKNHigxj1XMhggEPwWHn7y
	 aKutLgAYTmvA8SZ9RFxm12V6KL0hzI95RwXjJBPSAIzKyUoLAheFJUCYS5IpHE2rWT
	 6KK4E07F6p1rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] sched/fair: Credit a persistent,
 queue-depth-scaled vlag margin
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-3-kernellwp@gmail.com>
References: <20260612013355.59231-3-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:53:47 +0000
Message-Id: <20260612015347.B13311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] __enqueue_entity() fails to initialize se->max_slice before adding=
 the entity to the augmented RB-tree, poisoning the tree's max_slice.
--

commit c9a9a8b18145d7a6a58148e991409677da519193
Author: Wanpeng Li <wanpengli@tencent.com>

sched/fair: Credit a persistent, queue-depth-scaled vlag margin

This commit replaces the credit-to-zero buddy system with a bounded
positive-vlag margin. The margin scales with runqueue depth to preserve
the buddy's eligibility across multiple scheduling decisions without
exceeding EEVDF fairness bounds.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e7f5ea25fdae3..c6502db62cd3e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
[ ... ]
> @@ -9371,11 +9395,23 @@ eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, s=
truct sched_entity *se)
>  	avruntime =3D avg_vruntime(cfs_rq);
>  	vlag =3D entity_lag(cfs_rq, se, avruntime);
> =20
> -	/* Already eligible: nothing to do. */
> -	if (vlag >=3D 0)
> -		return;
> +	/* Clamp the margin to entity_lag()'s bound so place_entity() keeps it.=
 */
> +	max_slice =3D cfs_rq_max_slice(cfs_rq) + TICK_NSEC;

[Severity: High]
This isn't a bug introduced by this patch, but does the tree's max_slice
contain poisoned data here?

When an entity is dequeued, rb_erase_augmented_cached() removes the node
but does not clear se->max_slice. When enqueued again, __enqueue_entity()
initializes se->min_vruntime and se->min_slice, but misses se->max_slice:

kernel/sched/fair.c:__enqueue_entity() {
	sum_w_vruntime_add(cfs_rq, se);
	se->min_vruntime =3D se->vruntime;
	se->min_slice =3D se->slice;
	// Missing se->max_slice =3D se->slice; here?
	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
				__entity_less, &min_vruntime_cb);
}

Won't the new leaf node propagate a potentially large, stale max_slice from=
 its
previous subtree up to the root? This would artificially inflate
cfs_rq_max_slice() and corrupt the lag_limit calculated here, potentially
allowing tasks to accumulate massive lag while sleeping and breaking EEVDF
fairness bounds.

> +	lag_limit =3D calc_delta_fair(max_slice, se);
> +	margin =3D eevdf_persistent_margin(cfs_rq, se);
> +	if (lag_limit && margin > lag_limit)
> +		margin =3D lag_limit;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D2
