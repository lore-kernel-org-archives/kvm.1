Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF564963CC
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994511; cv=none; b=JPcGllApk4hY+GfIN46Tncs7htHNQO+hKvS+TaYlQL1ln2X7xsysMaw6tqJFCgiPIfiELLoFowBkEd4l9UdjLdkVOAzUKtEPYabCDR7EGyJGhFQ+rKG3SPudB8PbmShRPQT+mxCQ4gWktpa9gm2ByrWIhE1/so93rp0Y9lP8zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994511; c=relaxed/simple;
	bh=jblObbLC3FrNXx+T/lLSD1ZVsmQc5YFNAIcAj+09rmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=of0A2VXCutfzjLDp/rEmW5n20SescOH0JQgaN2CnagAVtltxI3TAT8KFW/U9yGzCFbX60+gXI3Up61Hv5bQVZWVFMgGOSFpkDw8bPaj1zslusIF+XE0MIYm2A0qQfeSaNpmgStZ1UONLT+dv1pIDbhsMBIJ/8iFD8D7z3khY2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ3wIxZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ3wIxZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7521F000FF;
	Mon, 21 Sep 2026 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994509;
	bh=lA9Q61OLra3+9VXlYL2Kmh3aAU5zUG+8C67x0zqyZf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJ3wIxZF93H+rsvLnJr7eTA/kBiRa4o2xicW2YbOEuwGstJjBW5yc8qWUCBgwkUkT
	 eMvtThenEy2XLj2XpjP1XjIRZoy6JNh7SFlbwHZkX/Qslki/2U7ZBGHrO6qNCty/iX
	 Hbs5/xa5/dShsDwpocc4S9Nq0qa93pUmHChQXw69TaM+Z1EpgoJ7GjJtvLdI/AIauR
	 YPIe/DkuIgL4PDBvY34CUnVmb/gFIip5jvWPHRsOYX0SzqV5Jl8sZ8hGRsZRsr/S5o
	 hm5bDZWmLKcApeNLookKQGy5JI57v36BcBa2WCI6S0iYtJQEwTp7518TGYVbCaahmP
	 KGwIqn7TCIVJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 2/4] RISC-V: paravirt: Add pvqspinlock frontend
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R1VPIFJlbiAoWHVhblRpZSk=?= <guoren@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921-pvqspinlock-v4-2-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
 <20260921-pvqspinlock-v4-2-409a22aed6ef@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:41:49 +0000
Message-Id: <20260921124149.BA7521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: out-of-line static_call in queued_spin_unlock() degrades pe=
rformance
- [High] riscv: missing headers in qspinlock_paravirt cause build failures
--

commit c07167cc8d5368121bd2aa429e157f2496f5c63f
Author: GUO Ren (XuanTie) <guoren@kernel.org>

RISC-V: paravirt: Add pvqspinlock frontend

Add a virtualization-friendly unfair qspinlock frontend that halts the
virtual CPU instead of spinning.

> diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/=
qspinlock.h
> new file mode 100644
> index 0000000000000..330b714edc447
> --- /dev/null
> +++ b/arch/riscv/include/asm/qspinlock.h

[ ... ]

> +#define queued_spin_unlock	queued_spin_unlock
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	static_call(pv_queued_spin_unlock)(lock);
> +}

[Severity: High]
Does replacing the inline smp_store_release() with a static_call() regress
native bare-metal performance?

Because RISC-V does not yet support inline static calls, this change replac=
es
the fast path native smp_store_release() instruction with an out-of-line
function call or indirect branch across the kernel for every spin_unlock
operation when CONFIG_PARAVIRT_SPINLOCKS is enabled.

> diff --git a/arch/riscv/include/asm/qspinlock_paravirt.h b/arch/riscv/inc=
lude/asm/qspinlock_paravirt.h
> new file mode 100644
> index 0000000000000..7261cd9b13b2e
> --- /dev/null
> +++ b/arch/riscv/include/asm/qspinlock_paravirt.h

[ ... ]

> +void dummy_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +void dummy_queued_spin_unlock(struct qspinlock *lock);
> +
> +DECLARE_STATIC_CALL(pv_queued_spin_lock_slowpath, dummy_queued_spin_lock=
_slowpath);

[Severity: High]
Can this cause a build failure due to an undefined macro?

DECLARE_STATIC_CALL requires <linux/static_call_types.h>, which does not
appear to be included in this file.

> +DECLARE_STATIC_CALL(pv_queued_spin_unlock, dummy_queued_spin_unlock);

[ ... ]

> diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/q=
spinlock_paravirt.c
> new file mode 100644
> index 0000000000000..c534447437fec
> --- /dev/null
> +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 GUO Ren (XuanTie) <guoren@kernel.org>
> + */
> +
> +#include <linux/static_call.h>
> +#include <asm/qspinlock_paravirt.h>
> +#include <asm/sbi.h>
> +
> +void pv_kick(int cpu)
> +{
> +	sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
> +		  cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);

[Severity: High]
Will this cause an implicit declaration error when compiling?

The cpuid_to_hartid_map() function requires <asm/smp.h>, which is missing
from the includes in this file.

> +}

[ ... ]

> +static void native_queued_spin_unlock(struct qspinlock *lock)
> +{
> +	/*
> +	 * unlock() needs release semantics:
> +	 */
> +	smp_store_release(&lock->locked, 0);
> +}

[Severity: High]
By forcing this into an out-of-line static function, does this prevent the
compiler from inlining the native fast path entirely?

> +
> +DEFINE_STATIC_CALL(pv_queued_spin_lock_slowpath, native_queued_spin_lock=
_slowpath);

[Severity: High]
Will this result in an undeclared identifier error for
native_queued_spin_lock_slowpath?

The native_queued_spin_lock_slowpath symbol requires <asm/qspinlock.h>,
which is missing from the includes in this file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-pvqspinloc=
k-v4-0-409a22aed6ef@kernel.org?part=3D2
