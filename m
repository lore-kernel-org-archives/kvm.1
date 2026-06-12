Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A828E0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228962; cv=none; b=cEejDAjeXEtHjk0pCjzKdTcsbIdzGNMSbnvNmHaBQoqr7Aum72zf5Ob2Ul3ml3ABxuTBzQmeFCZ8Cu2tlaos0AAXVn9y7iIHQwyp6zZAsDkj0H4gxunucOZLZPLbyYmen4rfoIMmEnlvk5kuGOgDNGlwVO6h09Gj69FR2fyYg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228962; c=relaxed/simple;
	bh=rkrHU7niOP+PLb2Nkfpi3jP/mVYvUS4mbvmRr6rNeuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyewy+ojr5fIscs/kVm/GvJaPIdjfs266jF8IncHYxo/sLJP5cgr0MlmxtlR+4rFvaISTu85JLArAUDpdJROei3fj5sRkda6dd8gVgX4X0zCKyobCwbO4CyL0hMEBBzepuFNl+kFQiyYr1yB8PKhTwXcpIK7b0Rj4f9PL+XM1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPJbzmZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPJbzmZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311A41F00A3A;
	Fri, 12 Jun 2026 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781228961;
	bh=UgyywYZgGnk1VO7aZCinJXvwfdhjEfOP+fPhBgKUOrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPJbzmZ2+VUmKepwKmS2CSR/E3lCJMVPZpUo6IL3+P9CiuD/lPZuhHgK612ctKyR1
	 bT93Z6tAkmOojra2FQbM348Ry2scAtMxQkkHngREje7F9V6HTbuyooeQUVEd+sUX6M
	 pusk2r6xlQscbRS+Vt6bcBFRgJa3MZxUYMET2XNkLBnyoGlzCW5nAX+fsvLoAF8rIL
	 wsLlr1YdW+CHD6VCaZeWD/mgMBFvxKTlsMWa/hENIzTi0IfFY99yj1zTTCxQrZQPZy
	 i7xvJaTcMsLNrD7Qrh4o3ZKqlRa4nkXGg78DD3dbJzND+uvNwnxAjEOnZy69w21ISe
	 Y7bWSBYej3z6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] sched/fair: Add EEVDF lag credit primitive for
 nominated next-buddy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-2-kernellwp@gmail.com>
References: <20260612013355.59231-2-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:49:20 +0000
Message-Id: <20260612014921.311A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] eevdf_credit_entity_vlag() inadvertently revives expired slice pro=
tection for the current task because it only shifts vprot when protect_slic=
e is true.
--

commit d8a18d46db47fd7df4dc661550f9788e6c195ed7
Author: Wanpeng Li <wanpengli@tencent.com>

sched/fair: Add EEVDF lag credit primitive for nominated next-buddy

This commit adds eevdf_credit_entity_vlag() to allow yield_to() targets
to receive bounded lag credit, enabling pick_eevdf() to honor buddy hints
even for targets with a negative vlag. The helper updates cfs_rq->curr in
place by shifting its vruntime, deadline, and optionally vprot backwards.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3ebec186f9823..e7f5ea25fdae3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -9341,6 +9341,54 @@ static void put_prev_task_fair(struct rq *rq, stru=
ct task_struct *prev, struct t
> +
> +	if (cfs_rq->curr =3D=3D se) {
> +		/* curr is off-tree: in-place shift, carrying any vprot window. */
> +		if (protect_slice(se))
> +			se->vprot -=3D credit;
> +		se->vruntime -=3D credit;
> +		se->deadline -=3D credit;

[Severity: High]
Could conditionally updating se->vprot unintentionally revive expired slice
protection?

If protect_slice(se) is currently false (meaning the protected slice has
already expired and se->vprot <=3D se->vruntime), se->vprot is not shifted.

Since se->vruntime is unconditionally shifted backward by credit, couldn't
se->vruntime fall behind the unmodified se->vprot?

This would cause protect_slice(se) to suddenly evaluate to true again,
inappropriately shielding the task from preemption in update_curr().

> +		return;
> +	}
> +
> +	/* Queued entities are left unchanged by this helper path. */
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D1
