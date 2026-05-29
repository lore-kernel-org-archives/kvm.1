Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6A38D41F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076212; cv=none; b=l4+WtK16lxWyPR8fCl/UNXy9afpJd1TWxudHbZvy51K0ToDad8sIMdmafD78IXIkRQ+39rnbQOIJ8i8Idgxjk5AyH/mgCsLIo1GR+kRLx5MovL7e+0z7gweVgnwS0qH7ziTxo6wXLZAMcLBMYi+PvzFiAyM3qTQSvqTOypKJ7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076212; c=relaxed/simple;
	bh=bD7AS2di8IgRkOe05+BuEEoBqGIyDcJ+SpszXpyAaZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leqa8ystTpWygquucwZLdHd0AeNlWwkHN8rvcF3iyDEMr6LTxGk6WxVQyjZbp1E9KUMB652+L3hqbOFv+TWmSjQ1KNKB6Qr7trD6ceALXKOKXsh2D9DvK3tnH1u3Fqw9qo70v6HoVZHTD+cD8nMrR+Qc9OXwQP/kqOemj76Ikho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft1AcJPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft1AcJPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F136A1F00893;
	Fri, 29 May 2026 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076211;
	bh=x0+35Z+y5Jg5x9Eejwxq+KXeoDpBCfdD3gnsz/BAlgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ft1AcJPdgkp/WNIjK/UGTY5WHjV5MxUCuWu5T4JL0XgOyi48KkIY8jhf1UA32Gp7h
	 16BIH5vvdtTPs6CEMg1qLjejp+6VBBgfVOj/YSwy7egLEef0yv+GmXwIhLsnLgvc17
	 qiS7fMrpd3v+NXQT7U7qrn8xQgsOPlDR+jXC7Fc8bn0B9q4IH/Z92DJtBHKrzUSUpo
	 t+O+GzPeGX8vJPyRDlN/raH7sFFlWabk1UUUkse+FhyqG2/KaY4ERcWn0ZqLvCHrG0
	 ZrDQd1fDFpcBynz9kTzNlLCXw6ZHHgqO9oqKjXQqt8aPI1t3Uf7XXtXIb1rcvnu16r
	 Ipn2EbN7z2q3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/20] KVM: x86/xen: Remove unnecessary irqsave from
 GPC lock usage in xen.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-4-seanjc@google.com>
References: <20260529165114.748639-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:36:50 +0000
Message-Id: <20260529173650.F136A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling read_unlock() on an rwlock_t inside kvm_sched_out() can ca=
use deadlocks on PREEMPT_RT because waking a waiting writer requires acquir=
ing runqueue locks while the current runqueue lock is already held.
--

commit 625a2fc07daa67a8fcafaa64daaf9791f5012ecd
Author: David Woodhouse <dwmw@amazon.co.uk>
Subject: KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xe=
n.c

This commit converts read_lock_irqsave() and read_unlock_irqrestore()=20
calls to plain read_lock() and read_unlock() for gpc->lock in several=20
xen.c functions, as the hardirq path now safely uses read_trylock().

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -421,16 +419,14 @@ static void kvm_xen_update_runstate_guest(struct kv=
m_vcpu *v, bool atomic)
>  	 * gfn_to_pfn caches that cover the region.
>  	 */
>  	if (atomic) {
> -		local_irq_save(flags);
>  		if (!read_trylock(&gpc1->lock)) {
> -			local_irq_restore(flags);
>  			return;
>  		}
>  	} else {
> -		read_lock_irqsave(&gpc1->lock, flags);
> +		read_lock(&gpc1->lock);
>  	}
>  	while (!kvm_gpc_check(gpc1, user_len1)) {
> -		read_unlock_irqrestore(&gpc1->lock, flags);
> +		read_unlock(&gpc1->lock);

[Severity: High]
This is a pre-existing issue, but can calling read_unlock() here lead to a
deadlock on PREEMPT_RT?

kvm_xen_update_runstate_guest() is called with atomic=3Dtrue from
kvm_sched_out(), which is invoked via preempt notifiers while holding the
runqueue lock for the current CPU.

On CONFIG_PREEMPT_RT, rwlock_t is mapped to an rt_rwlock. If a writer is
waiting (for example, from a concurrent kvm_gpc_deactivate()),
read_unlock() calls __rwbase_read_unlock() to wake the blocked writer.

__rwbase_read_unlock() observes the waiting writer and calls
rt_mutex_wake_up_q(), which synchronously calls try_to_wake_up().

try_to_wake_up() will then attempt to acquire the pi_lock and the target
task's rq_lock. Since the current CPU's runqueue lock is already held by
the scheduler, acquiring another rq_lock without double_rq_lock() violates
lock ordering and can cause an ABBA deadlock.

Is there a plan to handle this rt_rwlock wake-up behavior from the preempt
notifier context?

> =20
>  		/* When invoked from kvm_sched_out() we cannot sleep */
>  		if (atomic)
> @@ -439,7 +435,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_=
vcpu *v, bool atomic)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D3
