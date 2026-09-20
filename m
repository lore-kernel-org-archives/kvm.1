Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169163E315C;
	Sun, 20 Sep 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941233; cv=none; b=KU3SGz6vy1OJc7Ts4J3Eid7z1WPeD6oomgdKojx7RGq8tFai10wo71a37NvuU9CQdaalf3tY+wG9gAp5IAPFe+UStEh46T2mCW0ISKnzNTaMXPVTVs6f+bWLuyYLSqyDAZ6SoU1iXL2ztifYlMmK/5ZY0+RZ24fqTh3+kIJEs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941233; c=relaxed/simple;
	bh=1JI93aOY+0Z3KJ2KqC6JEk866CLwvJdDmA/UZSQGnqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SK0ot/yOyk/iIYVudWwgMdSjsFiz0/xEH000TaH6wIZnekAxAn71eXzX8yZVYrUsIrOytoCBaSmFfsYG5MOihevRNUaXRouGRAfu/nS1jMDgmxUF9KTtr84QNy/XJ9Id26f5YyqGqfE8WdFWMwpYDJAd+P1+eJUlqqJhJiE97NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHophiJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHophiJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE91F000FF;
	Sun, 20 Sep 2026 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941221;
	bh=cNrKoxn5/sUwf6I8R8ZsgjultvEkbUmh5HM+MkSS7Ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHophiJxbULeenCGEv8L1Mv3RYYX/CKb/6/jFU2pQGqO5EPKfsAE4/qtDtLpsaw90
	 EEzCX8Liv6rRdMjtG9vXJR6xRJXAL1eJS192LBS8zj2asjgNGaxgjZzPKzFWAhOxXI
	 DglCiuz7qfoEfg4cVYnHcU0BRj2aSLpeU7pTbiAzTflWQ04OMT2Ud9xNBWTIauG6DQ
	 2IKQ/Po3UH3sBWRSSNM8SuMOhP51yv7VDRoqneyVq1iJYZLlz6CrA0HnjP1atkKqdp
	 cjQHsswOlJVFjmHZrkL2x7ihLG0I3aJ0UJjY3DeuYFIdw3NPmiJx2RmII1j6wAaoXd
	 G6yaK7T/F58DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/17] KVM: pfncache: Return -EAGAIN for a lookup which
 hits an invalid memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-rt-devel@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260920211920.928306-9-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:53:40 +0000
Message-Id: <20260920215341.5ECE91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: ABBA deadlock in kvm_xen_set_evtchn() against memslot updates
--

commit d08948c3f01d34b213b2379e1b128830ccb5f086
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot

This commit modifies the pfncache lookup to return -EAGAIN when a memslot
is marked KVM_MEMSLOT_INVALID. It also updates kvm_xen_set_evtchn() to
indefinitely retry the refresh on -EAGAIN instead of failing.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index b6643b889320d..0b49eb67d06c0 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -2026,7 +2026,17 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtch=
n *xe, struct kvm *kvm)
>  		idx =3D srcu_read_lock(&kvm->srcu);
>  		rc =3D kvm_gpc_refresh(gpc, PAGE_SIZE);
>  		srcu_read_unlock(&kvm->srcu, idx);
> -	} while(!rc);
> +
> +		/*
> +		 * A refresh which raced with a concurrent memslot update
> +		 * (-EAGAIN: the slot exists but is mid-DELETE/MOVE) will
> +		 * succeed once the update completes or reverts; giving up
> +		 * instead would drop the event. Only a genuinely unbacked
> +		 * gfn (-EFAULT etc.) is fatal.
> +		 */
> +		if (rc =3D=3D -EAGAIN)
> +			cond_resched();
> +	} while (!rc || rc =3D=3D -EAGAIN);

[Severity: High]
Does this create an ABBA deadlock against memslot updates when called from
the vcpu_run() path?

A guest VM issuing an EVTCHNOP_send hypercall operates inside vcpu_run(),
which holds the outer kvm->srcu read lock. If this races with a VMM memslot
update (e.g., KVM_SET_USER_MEMORY_REGION), kvm_xen_set_evtchn() will encoun=
ter
-EAGAIN and loop here waiting for the update to complete.

However, cond_resched() does not drop the outer kvm->srcu lock. The thread
performing the memslot update is blocked in synchronize_srcu(&kvm->srcu)
waiting for all existing readers (including this vCPU thread) to drop their
locks.

This results in an unbreakable deadlock where the vCPU thread waits for the
memslot update, while the update waits for the vCPU thread to drop kvm->src=
u.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D8
