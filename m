Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AB2D5C7A
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783820; cv=none; b=CLrHybx3j/HkVdAHjxyMfYu5sWsIb+3dKZQHgCHDk2gWuBj5v6CIj138YtuItTCq/SM0DXqAetjjqVIGbQHzJ1B6baXwJhojsdwiCz8bZmIowxliCVoEYpgnu4eZ+bxAThwJLC7IP3lOjtzQc5BOZHHtgsThM0zyA6QqFi2ym6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783820; c=relaxed/simple;
	bh=vQwsCxT+Dcg67tKMHeYEoFGDHvzyeWT3wuZzpong/lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OkAK3KN4ECVVfkl273fn0DhwbYK5740TlfBDBiipN261WoZsaMgJGXf5DzKCVhkNAFkYNREYCA9zzQKZ8nACFbHIYY/W/3bCbXPlkY0RgET2dz4R65DiIVZu4dEkW7fABq92EBqIjMJ8Taj/t5plCQ7ii7Rgfa4xoMaw3uzq9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTU5MU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTU5MU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101271F000E9;
	Tue, 26 May 2026 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779783819;
	bh=bh6uhT6A9sTQphHICJeYEAy7n9Yj31J+Ju7kgYoABSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjTU5MU99mEPXVjzgyglYks04/5sD9TfiVNYaU2t838wKNIJDWIiTwznXf+ZD0QRN
	 2lepoAflE5V8NJkCshCQKOpKcDB9aLPtf/lG1YxF3ZEe00sOqVWMXnLBOy8OrCVGug
	 eNTno4PDlaXON19A/u2y95ydKMvCAS8SjyjzFDKQamr3kW7kp/Mvt73jYtst6ltLAs
	 29vGnaR6+9gtldL9oS8yrqHqm6dUhxPa/gzX2iXjck2yOKXvHu0OINsZ3zHk8yR9jU
	 SYxEQ0pfcNVqY52wKKLmUpnnLdpmx1GsnE6ZrdpiQ0CS34hxfw71jSBOrNkww72ZtV
	 COMgUvnoUz8gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix timer state restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Ma" <maqianga@uniontech.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526075544.796396-1-maqianga@uniontech.com>
References: <20260526075544.796396-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 08:23:36 +0000
Message-Id: <20260526082339.101271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a strict UAPI register restoration ordering d=
ependency, causing the timer to permanently stall if `state` is restored be=
fore `compare`.

Pre-existing issues:
- [Critical] Timer teardown uses a state flag for synchronization instead o=
f unconditionally canceling the hrtimer, leading to a use-after-free on VCP=
U destruction.
- [High] Restoring the timer state to OFF fails with `-EINVAL` if the timer=
 is already OFF, aborting live migration. This is exacerbated by SSTC incor=
rectly reporting its state.
--

commit 12ffaa755d54118c3c86ae260e5df5a3b6b59454
Author: Qiang Ma <maqianga@uniontech.com>

RISC-V: KVM: Fix timer state restore

This commit changes the timer state restoration logic in the one-reg interf=
ace
to re-arm the timer using the restored compare value (t->next_cycles) inste=
ad
of using the state value itself.

> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -229,7 +229,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcp=
u,
>  		break;
>  	case KVM_REG_RISCV_TIMER_REG(state):
>  		if (reg_val =3D=3D KVM_RISCV_TIMER_STATE_ON)
> -			ret =3D kvm_riscv_vcpu_timer_next_event(vcpu, reg_val);
> +			ret =3D kvm_riscv_vcpu_timer_next_event(vcpu, t->next_cycles);

[Severity: High]
Does this change introduce a strict ordering dependency for userspace regis=
ter
restoration?

If a VMM restores the state register to ON before restoring the compare
register, it appears this will arm the timer using an uninitialized or stale
t->next_cycles value.

If the compare register is restored later via KVM_SET_ONE_REG:

	case KVM_REG_RISCV_TIMER_REG(compare):
		t->next_cycles =3D reg_val;
		break;

This only updates memory and doesn't seem to re-arm the running hrtimer. Wi=
ll
this cause the virtual timer to stall indefinitely?

Before this patch, using 1 armed the timer for immediate expiration, and the
subsequent callback would asynchronously pick up the restored compare value.

>  		else
>  			ret =3D kvm_riscv_vcpu_timer_cancel(t);

[Severity: High]
This isn't a bug introduced by this patch, but does restoring the timer sta=
te
to OFF fail and abort live migration if the timer is already OFF?

If kvm_riscv_vcpu_timer_cancel() is called when restoring an OFF state:

static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
{
	if (!t->init_done || !t->next_set)
		return -EINVAL;
        ...
}

On the migration destination, a newly created VCPU has t->next_set =3D=3D f=
alse, so
restoring an OFF state returns -EINVAL.

Additionally, when the SSTC extension is enabled, the timer is programmed
directly via CSRs and t->next_set is not set to true for a running timer. W=
ill
this cause KVM_GET_ONE_REG to incorrectly report the state as OFF for active
VMs, which then fails during restoration on the destination?

[Severity: Critical]
This is a pre-existing issue, but does using the t->next_set flag for
synchronization during teardown lead to a use-after-free?

Looking at kvm_riscv_vcpu_timer_cancel(), it skips canceling the hrtimer if
the flag is false:

static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
{
	if (!t->init_done || !t->next_set)
		return -EINVAL;

	hrtimer_cancel(&t->hrt);
	t->next_set =3D false;
...

If the hrtimer callback clears t->next_set before it finishes executing, and
the VCPU is destroyed concurrently, the teardown path will see
t->next_set =3D=3D false and skip hrtimer_cancel().

Will the still-executing callback then dereference the freed VCPU memory?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526075544.7963=
96-1-maqianga@uniontech.com?part=3D1
