Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306233998
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711929; cv=none; b=lndX+rJ2sJX1PIDfkrrladGI/Y+VykPIMFtm2HyXdGzUXH7fJuFxlzLvs72zR15jZamp2zfvkvRqP/1OUrN8eahUyD+dvjoHBrU9igYyUOQm4Ch/EiMo0Bgmxkp2zjQzvB8cd6uJL1KrqooRkrqiDM/Q+zyeS3idZTIIfWXl0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711929; c=relaxed/simple;
	bh=J7EuI7AXOb05t5irAu1+dj7gfsKp2XltqGAdhbSbv38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OZSbSHRiWQTcO8V8Xn6jeD0cCWFpRxdhKo6o8V+O8IV7SDvqyXFiFxlkwGPqNjzgTbEqYplH4USQ88P/QJwC6Ta2+8VMJWRVSt7u8J3azhtSPkzV0Mg8a5kH4mT2CwGg5eTbItYx91siyuSpNTWn2JXfqLdsKu36+UPaDz3Fx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDbq23mI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDbq23mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F501F000E9;
	Fri, 14 Aug 2026 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711925;
	bh=5oDqbTRdpt7aq0AOlapv4saH1UrwJcCy5AVyBgsn5fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDbq23mIywMngFJseR9ab3Y4OSO9nq9rQvUdxIjgk7B/RZuTYA00PnPEu0k2E6MF8
	 zdbRK3x99BYe4LH12QuQzE+g6nLaahudaxO9/pVfA1S8RyNWS8UHIgi+b9SdQ20cmx
	 Wj0NIfoOJzljZLPyRAnlUiYLXvi9NV86gLA5/UD/gLftTinEROFMsV7ITX/pxU06+T
	 KBw2WnY+Ewnvz15alcRbUCn65ZBf+t7eGVSCVRFV9ft8Eje68yk+BOAB4tSAsEUuCb
	 kvhaVd4s9VwdRuSXHXItS/zY9fWQBflPHcM31cQQeOsPpxK3VV+yE6DO6N8sGhY0Fl
	 3WpJvcZSGr8QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Avoid redundant interrupt check for pending
 timers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814123541.593613-1-jinyu.tang@linux.dev>
References: <20260814123541.593613-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:52:05 +0000
Message-Id: <20260814125205.82F501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Masked timer interrupts cause an infinite loop of spurious WFI wak=
eups, leading to 100% CPU usage for idle guests.
- [High] The hrtimer cancellation during vCPU teardown can be bypassed, lea=
ding to a Use-After-Free if the timer callback executes concurrently.
- [High] Restoring KVM_REG_RISCV_TIMER_REG(state) via the ONE_REG interface=
 overwrites the timer's compare value with the state flag (1).
--

--- Patch [1]: [PATCH] KVM: riscv: Avoid redundant interrupt check for pend=
ing timers ---
commit 91f0cac16b524c91a61fc14d9cc9aaf56d289c69
Author: Jinyu Tang <jinyu.tang@linux.dev>

KVM: riscv: Avoid redundant interrupt check for pending timers
   =20
kvm_vcpu_check_block() calls kvm_arch_vcpu_runnable() before
checking whether a timer is pending. On RISC-V, kvm_arch_vcpu_runnable()
already checks all pending guest interrupts through
kvm_riscv_vcpu_has_interrupts(vcpu, -1UL), including IRQ_VS_TIMER.

Drop the repeated IRQ_VS_TIMER pending-interrupt check from
kvm_riscv_vcpu_timer_pending() and keep the helper focused on the timer
deadline state. If the timer becomes pending after the runnable check,
the timer path still injects IRQ_VS_TIMER and kicks the vCPU through the
normal wakeup path.

> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index 85a7262115e13..f6919048a584b 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -130,11 +130,7 @@ bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *v=
cpu)
>  	struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
>  	struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
> =20
> -	if (!kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t) ||
> -	    kvm_riscv_vcpu_has_interrupts(vcpu, 1UL << IRQ_VS_TIMER))
> -		return true;
> -	else
> -		return false;
> +	return !kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t);

[Severity: High]
This is a pre-existing issue, but this function returns true when the timer
has expired without checking if the timer interrupt is actually unmasked by
the guest.

Can this cause an infinite loop of spurious WFI wakeups? If a guest OS masks
the timer interrupt (vsie.STIE =3D 0), leaves the timer comparator in the p=
ast,
and executes the WFI instruction, kvm_arch_vcpu_runnable() correctly returns
false.

However, kvm_cpu_has_pending_timer() might use this helper and return true,
ignoring the mask. KVM would then break out of kvm_vcpu_block() and resume
the guest. The guest would re-execute WFI, immediately trapping again.

Could this lead to 100% host CPU usage for idle guests?

>  }
> =20
>  static void kvm_riscv_vcpu_timer_blocking(struct kvm_vcpu *vcpu)

[Severity: High]
This isn't a bug introduced by this patch, but can hrtimer cancellation
during vCPU teardown be bypassed, leading to a Use-After-Free?

Looking at kvm_riscv_vcpu_hrtimer_expired() in arch/riscv/kvm/vcpu_timer.c:

	t->next_set =3D false;
	kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_TIMER);

And in kvm_riscv_vcpu_timer_cancel():

	if (!t->init_done || !t->next_set)
		return -EINVAL;

	hrtimer_cancel(&t->hrt);

Since t->next_set is cleared locklessly in kvm_riscv_vcpu_hrtimer_expired()
before it finishes accessing the vcpu structure, what happens if VM teardown
races with this callback?

If kvm_riscv_vcpu_timer_deinit() calls kvm_riscv_vcpu_timer_cancel() and se=
es
t->next_set as false, it skips hrtimer_cancel(). Does this allow teardown to
free the vcpu while the callback is still actively using it?

[Severity: High]
This is a pre-existing issue, but is the timer's compare value overwritten
when restoring KVM_REG_RISCV_TIMER_REG(state) via the ONE_REG interface?

In arch/riscv/kvm/vcpu_timer.c:kvm_riscv_vcpu_set_reg_timer():

	case KVM_REG_RISCV_TIMER_REG(state):
		if (reg_val =3D=3D KVM_RISCV_TIMER_STATE_ON)
			ret =3D kvm_riscv_vcpu_timer_next_event(vcpu, reg_val);
		else
			ret =3D kvm_riscv_vcpu_timer_cancel(t);
		break;

When userspace restores the VM state during live migration, restoring state
with KVM_RISCV_TIMER_STATE_ON (1) incorrectly passes reg_val (1) as the tar=
get
cycles deadline to kvm_riscv_vcpu_timer_next_event().

Would this overwrite t->next_cycles with 1, permanently losing the actual
restored timer comparator value and causing immediate spurious interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814123541.5936=
13-1-jinyu.tang@linux.dev?part=3D1
