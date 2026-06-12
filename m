Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C162673B0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229340; cv=none; b=WBIKkkGQTqKW/nkYwmAjwyrS8g1rQ87I8PipjeGcXhSwfFptz0U4LsdckPLidXYrTk9XEl6bGxbR/Z6PTt2jNwkaXVfEPidcNMioXUB5KPILoYfegC+prEWuuNlGV6+Vq5cZ491iOZcPBmSNxQdE/f0qUzJhdqEKZtItU5QcLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229340; c=relaxed/simple;
	bh=PHgtqbknL9lUcbopZwp38mL/gKI5rHY0hiajlOxqJ6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BH3Rem3tX0gZpIA3OcY0F/i8+Nx6YwAYrvFSaoNsXALFo5JNiBhNdzOU1L+UU5mUUAgRn2Cc/DucYp1gCg7l2zRd0zHN/9NIDogMpUgWSkTMzp7whSJdtVpfM6rCGfRtnJZtdMocz66WXD8b3sOXVUpgnlDU0Lw9VNTRzrZU5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4+W8xgF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4+W8xgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D351F000E9;
	Fri, 12 Jun 2026 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781229339;
	bh=C8P0B0IfDuGHWMJSC3tWjL8Ywk2pS3SZH3bfVEkdNVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4+W8xgFzRClOfvEjIWzpAu+/+ZLQw7Lo0fmZDHL0UCQmOZK0o+aUn5aqZymeb+F1
	 av8mpB3ZPpXMMJVDgj/neZR92gqsPrvWF9sCiR0eEKQX70vlB4IElQELSYLAGjz0+I
	 ior1QaVJ8W6nerg3j2smcmDZgvgOEFhzAID6j4ZOYSv84EQ4D8UnMBz1LXjnoUuvoE
	 mvE1usMAwVDOI3AmeagpesWBfD6QmKfkQYXCQJfKZyYVU6K2qZ2/muEUcBEyNtVASN
	 1uhqMZjPuq2MjokoxonCBN3aOljNqbtkytvGDygG1sP6L9Sprvdb3FxzQRnGExOy6P
	 nfBI+W913O7hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] sched/fair: Credit queued next-buddy via
 canonical requeue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-4-kernellwp@gmail.com>
References: <20260612013355.59231-4-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:55:39 +0000
Message-Id: <20260612015539.93D351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional setting of `se->rel_deadline =3D 1` ignores `sched_f=
eat(PLACE_REL_DEADLINE)`, leaking relative deadline flags and corrupting ab=
solute deadlines on reweighting.

Pre-existing issues:
- [High] `__enqueue_entity` fails to reset `se->max_slice =3D se->slice`, c=
ausing stale subtree maximums to incorrectly inflate the augmented rbtree.
--

commit 61176c863b2b0bee3f465f1148e81251b1cf5bda
Author: Wanpeng Li <wanpengli@tencent.com>

sched/fair: Credit queued next-buddy via canonical requeue

This commit extends eevdf_credit_entity_vlag() to handle a queued
entity. It uses the canonical requeue pattern to keep sum_w_vruntime
consistent with entity_key(), preserving the slice and shifting the
deadline.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -9422,7 +9424,22 @@ eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se)
>  		return;
>  	}
> =20
> -	/* Queued entities are left unchanged by this helper path. */
> +	/*
> +	 * Canonical place_entity()-paired requeue: see dequeue_entity() and
> +	 * requeue_delayed_entity(). place_entity() restores the deadline via
> +	 * "se->deadline +=3D se->vruntime", so make the deadline relative to
> +	 * se->vruntime here (not avg_vruntime). This preserves the slice and
> +	 * shifts the deadline by exactly -credit, mirroring the curr branch
> +	 * and keeping deadline > vruntime.
> +	 */
> +	se->vlag =3D vlag + (s64)credit;
> +	se->deadline -=3D se->vruntime;
> +	se->rel_deadline =3D 1;

[Severity: High]
Does setting the relative deadline flag unconditionally here cause an issue
if the PLACE_REL_DEADLINE feature is disabled?

Looking at place_entity(), the flag is only cleared if the feature is enabl=
ed:

place_entity() {
	...
	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
		se->deadline +=3D se->vruntime;
		se->rel_deadline =3D 0;
		return;
	}
	...
	se->deadline =3D se->vruntime + vslice;
}

If the feature is disabled, place_entity() computes an absolute deadline but
leaves se->rel_deadline set to 1. If the task then sleeps and its nice value
changes, rescale_entity() checks se->rel_deadline and will incorrectly apply
relative scaling to the absolute deadline:

rescale_entity() {
	...
	if (se->rel_deadline)
		se->deadline =3D div64_long(se->deadline * old_weight, weight);
	...
}

Could this arithmetic overflow and corrupt the deadline, potentially breaki=
ng
the rbtree priority ordering?

> +	cfs_rq->nr_queued--;
> +	__dequeue_entity(cfs_rq, se);
> +	place_entity(cfs_rq, se, 0);
> +	__enqueue_entity(cfs_rq, se);

[Severity: High]
This is a pre-existing issue, but does the call to __enqueue_entity()
expose a stale max_slice issue in the augmented rbtree?

When an entity is inserted as a leaf node, __enqueue_entity() resets the
min_vruntime and min_slice, but appears to leave max_slice untouched:

__enqueue_entity() {
	sum_w_vruntime_add(cfs_rq, se);
	se->min_vruntime =3D se->vruntime;
	se->min_slice =3D se->slice;
	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
				__entity_less, &min_vruntime_cb);
}

If the task previously had a large max_slice (for instance, when it was a
parent of tasks with large slices), does that stale max_slice propagate up
the tree during rb_add_augmented_cached()?

Could this artificially inflate cfs_rq_max_slice(cfs_rq) and circumvent the
lag clamping bounds in entity_lag(), allowing tasks to hoard excessive lag?

> +	cfs_rq->nr_queued++;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D3
