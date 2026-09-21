Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765B4718E9
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994465; cv=none; b=cOrspasBp4hvW8fxFcezPLXDnklP/VSPjTqM+zsRNQxw61WQVXWLrw1J/LryxhcxG7yesY+0c72uy4BcXY47FXycdEZg19hYnSHFryJHVVRvHekboOJSHm6CVbkpJ1wceuyK/rRWSqCozAcVYNPSbhulK4LZYJSaiePd2kd2qFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994465; c=relaxed/simple;
	bh=wC+RHOd1ZO+acZyNdMc4nixxkFHeQCKagC1jN6kIIUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMFyicOJ7AfsnaBCykwE0pWyWV11paNIl2wUfObmKGxE65V4MxNscFgtCXvRbE114hhWODpSlL7Rv2W7ItecenoltguZnrX0z2xFa3zn4WJ48lRr+XB2Cnv5BCyIou3dXtyfck2IXu3gDJlaZSgy5w7M1yq7Ms7jpy4uSF6vqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmDvlqIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmDvlqIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63431F00893;
	Mon, 21 Sep 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994464;
	bh=YF76HCOaJspUCnBwz4JYfTHQwSaOCzEJQNJwWHeb8ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmDvlqIQhN+Kyi/4/CeMMH4UMqgLV7baTOrjoKzyXXCrL2iDJkuJ9qNPVK33zHOWO
	 MmR5YvBUSFiyG/KsUBYRRtc8OB/+hfu/K9C5dQx4N1dOva0hyU1hfnty4MwDuADM00
	 4EN1LKs2UWw6iq1ph5nc7B9ChiLV7t/F64JqQUNTSHOPRX5HNHPzIx0DNXgrwzSaR3
	 bjcBfX6ibPkVehmPCcm5Moubl3TapnZHG0pM+3RF326KsBPMyqUQxuQnHeD9040jpw
	 k18JW1QCCK2U3F9UyblWMJPJkZTQRqsseTa1SNXi/JzXYBMhrv5q7b9rzJENfIif/U
	 omGE7XiVMklNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 4/4] RISC-V: paravirt: Support nopvspin to
 disable PARAVIRT_SPINLOCKS
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R1VPIFJlbiAoWHVhblRpZSk=?= <guoren@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921-pvqspinlock-v4-4-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
 <20260921-pvqspinlock-v4-4-409a22aed6ef@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:41:03 +0000
Message-Id: <20260921124103.E63431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] build: unresolved virt_spin_lock_key when PARAVIRT_SPINLOCKS is di=
sabled
- [High] locking/pv: inverted nopvspin semantics disables TAS fallback on u=
naccelerated VMs
- [High] locking/pv: skipping ZICCRSE extension check exposes guest to LR/S=
C livelock
- [Low] locking/pv: casting atomic_t to raw pointer in smp_cond_load_relaxed
- [Low] locking/pv: static_branch_likely pessimizes native spinlock fastpath
--

commit 51ef25d6df1335ba98379605c62c0034ca0b9dfe
Author: GUO Ren (XuanTie) <guoren@kernel.org>

RISC-V: paravirt: Support nopvspin to disable PARAVIRT_SPINLOCKS

VM guests should fall back to a Test-and-Set spinlock when
PARAVIRT_SPINLOCKS is disabled, because fair locks suffer from severe
lock-holder preemption issues. The virt_spin_lock_key shortcuts
queued_spin_lock_slowpath(), allowing virt_spin_lock() to hijack it.

> diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/=
qspinlock.h
> index 330b714edc447..9c7108baa40a1 100644
> --- a/arch/riscv/include/asm/qspinlock.h
> +++ b/arch/riscv/include/asm/qspinlock.h
[ ... ]
> @@ -29,5 +31,27 @@ static inline void queued_spin_unlock(struct qspinlock=
 *lock)
>  #endif /* CONFIG_PARAVIRT_SPINLOCKS */
> =20
>  #include <asm-generic/qspinlock.h>
> +#include <asm/jump_label.h>
> +
> +/*
> + * KVM guests fall back to a Test-and-Set spinlock because fair locks su=
ffer
> + * from severe lock-holder-preemption issues. When virt_spin_lock_key is
> + * enabled, virt_spin_lock() shortcuts queued_spin_lock_slowpath() and h=
ijacks
> + * the lock acquisition.
> + */
> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);

[Severity: High]
Is it possible for the kernel to fail to link due to an undefined symbol he=
re?

virt_spin_lock_key is unconditionally declared and used by the inline funct=
ion
rv_virt_spin_lock(). However, its definition resides in
arch/riscv/kernel/qspinlock_paravirt.c, which is only compiled when
CONFIG_PARAVIRT_SPINLOCKS is enabled. Does this break the build when
CONFIG_QUEUED_SPINLOCKS=3Dy but CONFIG_PARAVIRT_SPINLOCKS=3Dn?

> +
> +#define virt_spin_lock rv_virt_spin_lock
> +static inline bool rv_virt_spin_lock(struct qspinlock *lock)
> +{
> +	if (!static_branch_likely(&virt_spin_lock_key))
> +		return false;

[Severity: Low]
Does using likely() here force the compiler to treat the bare-metal default
path (when the key is disabled) as out-of-line?

Since virt_spin_lock_key is false by default on bare-metal systems, wouldn't
static_branch_likely() require an unconditional jump in the native queued
spinlock fastpath, degrading performance? Should this be
static_branch_unlikely() instead?

> +
> +	do {
> +		smp_cond_load_relaxed((s32 *)&lock->val, VAL =3D=3D 0);

[Severity: Low]
Is it safe to cast &lock->val (an atomic_t) to a raw pointer like (s32 *)?

This bypasses the atomic_t abstraction. Should atomic_cond_read_relaxed()
be used here instead?

> +	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) !=3D 0);
> +
> +	return true;
> +}
> =20
>  #endif /* _ASM_RISCV_QSPINLOCK_H */
> diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/q=
spinlock_paravirt.c
> index 04b13994e971c..28c6c78d7e84c 100644
> --- a/arch/riscv/kernel/qspinlock_paravirt.c
> +++ b/arch/riscv/kernel/qspinlock_paravirt.c
[ ... ]
> @@ -58,6 +60,12 @@ bool __init pv_qspinlock_init(void)
>  	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
>  		return false;
> =20
> +	if (nopvspin) {
> +		static_branch_enable(&virt_spin_lock_key);
> +		pr_info("virt_spin_lock enabled by nopvspin\n");
> +		return true;
> +	}

[Severity: High]
Do the nopvspin semantics here invert the expected behavior?

If an unaccelerated VM boots without SBI_EXT_PVLOCK, pv_qspinlock_init()
returns early before enabling virt_spin_lock_key, defeating the TAS fallbac=
k.

Furthermore, if nopvspin is passed, it statically enables the key, whereas =
on
x86, nopvspin explicitly disables PV optimizations and forces native queued
spinlocks.

[Severity: High]
Can this early return expose guests to LR/SC livelocks?

If a VM uses nopvspin, returning true here causes riscv_spinlock_init() in
arch/riscv/kernel/setup.c to completely bypass the hardware extension checks
like ZABHA, ZACAS, or ZICCRSE.

Because rv_virt_spin_lock() relies on an LR/SC atomic_cmpxchg loop, will it
livelock under heavy contention if the underlying hardware lacks the ZICCRSE
extension, which provides forward progress guarantees?

> +
>  	pr_info("PV qspinlocks enabled\n");
>  	__pv_init_lock_hash();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-pvqspinloc=
k-v4-0-409a22aed6ef@kernel.org?part=3D4
