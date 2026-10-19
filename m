Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA556B196
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418270; cv=none; b=nnu1wx98LT5APdE1np1AG2UajPJYwcOj4B3SO/5W8w0wBlLCsHeddrUIsqewn1YG8GwBuNMv+AaMYSyHGngpx5ukPnOtNECIf4lTMDPEKO0Lf512quCJhm77AyrxQgYflHuurx1UsPXlsVzuPYi/Yo55lIyFGeba4hxY2cP+V7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418270; c=relaxed/simple;
	bh=jBQn6MkByVxnTerj5tdnDfJahhTI9yLcTWXOa1H1o8k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aE8TOTiDz8CgX8H/SQLIlCeY4sPeVfjzuwq07Y1oc7HPC5OUoa+svnbB85uQ2OsGtNbQKZtUBxH7VKxJt/vPp9KSSem5c/+zTYyk7F/sXxgxcxF5DQsp4iiW+M0aMazFyVYRW6IwMMzqWNlt1Y+Lh8AWoJ6qlNjeiVpUKpz/a/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNTra6b/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNTra6b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD101F000C4;
	Mon, 19 Oct 2026 13:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418269;
	bh=3uODrP+a5BAO0yvKwNqHmPcsKljPCSBSqxtXG5oe0QY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNTra6b/H6GsX+5uszJPCxfWB3kKfRAgW2GPOSptzt7jf4N50KjL7w1Z4QP27LU/f
	 4ZyIv7H726G4F58Yb4wnlV4ByUJgRH8tW3EAq53acCQhnyfvl2ON4YnjtVAfRkVx6u
	 uJPJ3js/SPvnvAixOPxHRHx0+7uqw2m9SAroPpO2KdsECubY//zPYHKY7KyUIac/wj
	 TKicXZkgASKeWV1mjJUdvVT6OjKBqHg1khX8QDnYtIIJcyFqiPlDMTGlurqDnukgqN
	 PY6lB12yAfQWc0ht1I0D+FwyCCiTj9vXGr0Mxt5LDSB3JMXNEfB012Fwz/EtfZXtIW
	 lKbD3YDffSLPA==
Message-ID: <sashiko-outbox-177242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw
 spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Jones" <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019134709.2610129-1-andrew.jones@linux.dev>
References: <20261019134709.2610129-1-andrew.jones@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:57:48 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] RISC-V: KVM: ABBA deadlock on vsfile_lock in kvm_riscv_vcpu_aia_im=
sic_put()
--

commit 87fb1e91c477214da3458429ee5e7b7ff86ac173
Author: Andrew Jones <andrew.jones@linux.dev>

RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock

This commit converts imsic->vsfile_lock from rwlock_t to raw_spinlock_t
so that kvm_riscv_vcpu_aia_imsic_put() does not sleep while holding the
scheduler runqueue lock on PREEMPT_RT.

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index f17dc559a7092..bad0ce20edc11 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c

[ ... ]

> @@ -727,10 +727,10 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *=
vcpu)
>  	if (!kvm_vcpu_is_blocking(vcpu))
>  		return;
> =20
> -	read_lock_irqsave(&imsic->vsfile_lock, flags);
> +	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
>  	if (imsic->vsfile_cpu > -1)
>  		csr_set(CSR_HGEIE, BIT(imsic->vsfile_hgei));
> -	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
>  }

[ ... ]

> @@ -975,7 +975,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsi=
gned long type,
>  	}
>  	isel =3D KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
> =20
> -	read_lock_irqsave(&imsic->vsfile_lock, flags);
> +	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
> =20
>  	rc =3D 0;
>  	vsfile_hgei =3D imsic->vsfile_hgei;
> @@ -990,7 +990,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsi=
gned long type,
>  					    isel, val, 0, 0);
>  	}
> =20
> -	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
> =20
>  	if (!rc && vsfile_cpu >=3D 0)
>  		rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
> @@ -1052,7 +1052,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu=
 *vcpu,
>  	if (imsic->nr_msis <=3D iid)
>  		return -EINVAL;
> =20
> -	read_lock_irqsave(&imsic->vsfile_lock, flags);
> +	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
> =20
>  	if (imsic->vsfile_cpu >=3D 0) {
>  		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> @@ -1062,7 +1062,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu=
 *vcpu,
>  		imsic_swfile_extirq_update(vcpu);
>  	}
> =20
> -	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
> =20
>  	return 0;
>  }

[Severity: High]
Can converting vsfile_lock from rwlock_t to an exclusive raw_spinlock_t
cause an ABBA deadlock between rq->__lock and imsic->vsfile_lock when
imsic->vsfile_cpu < 0 (such as in KVM_DEV_RISCV_AIA_MODE_EMUL, in
KVM_DEV_RISCV_AIA_MODE_AUTO when HGEI lines are exhausted, or after
kvm_riscv_vcpu_aia_imsic_release())?

When a vCPU blocks in kvm_vcpu_block(), prepare_to_rcuwait() sets the
rcuwait task before schedule() is called, making kvm_vcpu_is_blocking()
return true. During the context switch out on CPU 0, rq->__lock is held
and prev->on_cpu is still 1 when the preempt notifier runs:

CPU 0:
__schedule() [holds rq->__lock, prev->on_cpu =3D=3D 1]
  -> context_switch()
    -> prepare_task_switch()
      -> fire_sched_out_preempt_notifiers()
        -> kvm_sched_out()
          -> kvm_arch_vcpu_put()
            -> kvm_riscv_vcpu_aia_put()
              -> kvm_riscv_vcpu_aia_imsic_put()
                -> raw_spin_lock_irqsave(&imsic->vsfile_lock, flags)

This establishes the lock ordering rq->__lock -> imsic->vsfile_lock.

Concurrently on CPU 1, kvm_riscv_vcpu_aia_imsic_inject() or
kvm_riscv_aia_imsic_rw_attr() acquires imsic->vsfile_lock and, when
imsic->vsfile_cpu < 0, calls imsic_swfile_extirq_update() while still
holding imsic->vsfile_lock:

CPU 1:
kvm_riscv_vcpu_aia_imsic_inject() / kvm_riscv_aia_imsic_rw_attr()
  -> raw_spin_lock_irqsave(&imsic->vsfile_lock, flags)
  -> imsic_swfile_extirq_update()
    -> kvm_riscv_vcpu_set_interrupt()
      -> kvm_vcpu_kick()
        -> kvm_vcpu_wake_up()
          -> rcuwait_wake_up()
            -> wake_up_process()
              -> try_to_wake_up()

Inside try_to_wake_up(), CPU 1 acquires p->pi_lock and either spins
waiting for CPU 0's rq->__lock (for example in ttwu_runnable() when
delayed dequeue keeps p->on_rq set, or if preempted after
prepare_to_rcuwait()) or spins in smp_cond_load_acquire(&p->on_cpu, !VAL)
waiting for CPU 0 to finish switching out the vCPU task. Meanwhile, CPU 0
is spinning on imsic->vsfile_lock in prepare_task_switch() before
finish_task() can clear p->on_cpu or release rq->__lock.

Previously, both paths took read_lock_irqsave(&imsic->vsfile_lock, flags)
and did not block each other unless a writer was active (and writers run
with vcpu->mutex held outside schedule()). With raw_spinlock_t, these two
paths now serialize against each other and can deadlock.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019134709.2610=
129-1-andrew.jones@linux.dev?part=3D1
