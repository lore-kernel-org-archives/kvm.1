Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE293B583D
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779767810; cv=none; b=jW2LlaB5cmDD5NScdnYqJdmlYvOR88pIDr7Hu/4tGcr2ypGOki5uyHhSX67G/cAACe5u21BD0vKxNM+THh67zj7UxKtxyke0D2i42kG8WAIbnjW3ea06+NToQjHv3Y/8czYobDynPXTSzmg82CX5kQZa2bB8BWOHXCqe+W+EDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779767810; c=relaxed/simple;
	bh=m70jUs0EUuD55VlrN/xQpTjHkJgkfiuyh5a3sZMP7rw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NpnPekJUmXDe5MgELOPvkONGVjawjI6tqLgpgllKUm55Q6YiH/fpALXahK4IiR9GJKmBnpuQeImhDWPLzKVZHVtQN7sjjiWjPRflWE0/5vD9w1cBpYO2HoOzdg4ypDockUSur6OFWXRSaGyyP9A9Hjl2kK7S7ubbxGIg38s+3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0SHUKHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0SHUKHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010291F000E9;
	Tue, 26 May 2026 03:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779767809;
	bh=j8hwI2zjWJV1tpLJJmAnmwERQEfyFWst2ZvSTCalvvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f0SHUKHESwkNVOAAVpnrXkl68ImVc1qKpRhIoFKCZm4BhNY2Eq6U9fUb0ncvc+H1H
	 LxdYCoPLYe5o5NxNIkChFowsFZc9nrUOroyQpulKRdBdSTRcmQPSEufHc5DO/e2jXC
	 KlpUhaEdHi6NS1FjXCoRYBhVdOSHek0Psb+hgNLWzu5DfjrvPidhOAs4qcIZVSH0w6
	 drxAXGdgyHiFp/KAhbYDURz8BlPR6Um7qMisLp8PsPP/r5cvC5vIsey4/qvbreomtu
	 TLyXY1x4+RJJ8YydTLA2f2puGfDXIqXITnRLkGrrtH8+sCoSWxD8evflKImxX8R15k
	 CCKcjOzEJorKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiakai Xu" <xujiakai2025@iscas.ac.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
References: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:56:48 +0000
Message-Id: <20260526035649.010291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix for VCPU creation after AIA initialization leav=
es multiple NULL pointer dereferences
- [High] Acquiring rwlock_t in preempt notifier context causes 'sleeping wh=
ile atomic' panic on PREEMPT_RT
--

commit 1dfd448f59b0d23fa69ed899c4ce00ac3e71eeaa
Author: Jiakai Xu <xujiakai2025@iscas.ac.cn>

RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions

This commit fixes a NULL pointer dereference in the AIA IMSIC functions
by adding NULL pointer guards to kvm_riscv_vcpu_aia_imsic_put(), release(),
and has_interrupt(). The issue occurs when a VCPU is created after the AIA
device is initialized, which leaves its imsic_state NULL.

> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index fda0346f0ea1f..e29cf9feb1ba3 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
[ ... ]
> @@ -710,6 +713,9 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vc=
pu)
>  	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>  	unsigned long flags;
> =20
> +	if (!imsic)
> +		return;
> +
>  	if (!kvm_vcpu_is_blocking(vcpu))
>  		return;
> =20

[Severity: High]
This is a pre-existing issue, but is it safe to acquire an rwlock_t inside
kvm_riscv_vcpu_aia_imsic_put()?

This function eventually calls read_lock_irqsave(&imsic->vsfile_lock, flags)
and is called from the preempt notifier context:

context_switch()
  prepare_task_switch()
    fire_sched_out_preempt_notifiers()
      kvm_sched_out()
        kvm_arch_vcpu_put()
          kvm_riscv_vcpu_aia_put()
            kvm_riscv_vcpu_aia_imsic_put()

The preempt notifiers execute with the runqueue raw_spinlock_t held and
hardware interrupts disabled.

On PREEMPT_RT kernels, rwlock_t is mapped to a sleepable lock. Attempting
to acquire a sleepable lock while holding a raw spinlock causes a
scheduling while atomic kernel panic on any VCPU thread preemption.

[ ... ]
> @@ -726,6 +732,9 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu=
 *vcpu)
>  	int old_vsfile_hgei, old_vsfile_cpu;
>  	struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> =20
> +	if (!imsic)
> +		return;
> +
>  	/* Read and clear IMSIC VS-file details */
>  	write_lock_irqsave(&imsic->vsfile_lock, flags);
>  	old_vsfile_hgei =3D imsic->vsfile_hgei;

[Severity: Critical]
This is a pre-existing issue, but does this incomplete fix leave other paths
vulnerable to the exact same NULL pointer dereference?

The commit message notes that creating a VCPU after AIA initialization
leaves imsic_state NULL. While this patch protects the put, release, and
has_interrupt paths, other functions in the same file still unconditionally
dereference imsic_state under the same conditions.

For example, kvm_riscv_vcpu_aia_imsic_update() (called during the KVM_RUN
ioctl), kvm_riscv_vcpu_aia_imsic_rmw() (called during guest CSR access
traps), and kvm_riscv_aia_imsic_rw_attr() / kvm_riscv_aia_imsic_has_attr()
(called via KVM device ioctls).

Could a userspace program trigger a host kernel panic by initializing the
AIA device, creating a late VCPU, and then invoking KVM_RUN or
KVM_HAS_DEVICE_ATTR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526031517.1166=
025-1-xujiakai2025@iscas.ac.cn?part=3D1
