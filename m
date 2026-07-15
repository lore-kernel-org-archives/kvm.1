Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A53C2BBA
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101369; cv=none; b=R0hDxVBd/lWTR6Q84zk+nEFv2Q7t1K4ZVN2PAmAtonVmQA7GP5pPhtOG1gFfqQUO6zRkTZFjlbmNg2vOv+6PN0+Is1w9/AsBwVZ1BanFeI1v5WDXdQLmiC4ImhIgZQAjmrYeqlFQdyeui/A1C1rFjls/C1zM0FASUS654DyqTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101369; c=relaxed/simple;
	bh=dl5hrc1CrRPyE7slN20IyizMjIjploeT96l+5tgrKqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UzZvi+m20Dus97ZwxBDKrH1q/M6vO7QjulSN5mrSsGfy0/+1NRKmvf1fU6WvA7e9E4p2jRTZiwAf/xafO/gSAnEdoRvepzCmO4ytK2lQW/2FQ5zS8NvQLllm1zozpT4y6Q3F2d4PV6IMTmjbviXXNtO0mamwwGVKhqSwwwaR6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erq6AJHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erq6AJHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7311F000E9;
	Wed, 15 Jul 2026 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784101367;
	bh=8eU6lAQ+eRP5xrGiMmyuuUmXjv5xyenXqls2/EC0eas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Erq6AJHycSlSEtG+E+NAkf69mwbBA7Z69bJ8aemrl2pU8RprZRFNOOJp0Pw6C3Wqz
	 NDZvZhwDE8n1yQqGyvHIYYjUxny5SqceTDBNEH+c1IP4v0XXCRisWTgA8fSpcAnKIr
	 /lTdthreUPt2Q5wdkePnDA2BP913ZIwL5JPPPD96CAvgoCzFPTNtCyVXWA2HENCwnt
	 72bZLTkaZGbG/IkwQtVHrzZvjYKGjdPd+VLUloCi+uGUF2L/1fz0WY9SKMjjpHCpbM
	 CpNtXiFY7ADo6F9b6yYH2B4jr3kkfeB+IZ9xHTvK+JKq1EPQdflwvqC8LySJxmBB9U
	 pHFOxkbxbtI4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Reload one-shot TVAL on migration
 destination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260715072952.1433171-1-cui.tao@linux.dev>
References: <20260715072952.1433171-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 07:42:46 +0000
Message-Id: <20260715074247.4F7311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Redundant ktime_get() call introduces a race condition and non-d=
eterministic timer inflation.

Pre-existing issues:
- [High] Unvalidated guest-controlled timer period leads to a division by z=
ero and host kernel panic.
--

--- Patch [1]: [PATCH v2] LoongArch: KVM: Reload one-shot TVAL on migration=
 destination ---
commit 76bdf1c5f64a97f768f72eb78cf6f70484cc8af9
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Reload one-shot TVAL on migration destination

This commit handles restoring one-shot timers on migration destinations whe=
re
vcpu->arch.expire is uninitialized. It calculates the remaining countdown
using the migrated TVAL.

> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
> index 3829f35a4070b..08359a612bdee 100644
> --- a/arch/loongarch/kvm/timer.c
> +++ b/arch/loongarch/kvm/timer.c

[ ... ]

> @@ -119,6 +119,17 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>  	delta =3D 0;
>  	now =3D ktime_get();
>  	expire =3D vcpu->arch.expire;
> +	if (!expire) {
> +		/*
> +		 * vcpu->arch.expire is host-internal and is not migrated,
> +		 * so it is 0 after migration. Reload the remaining countdown
> +		 * from the migrated TVAL.
> +		 */
> +		if (ticks < cfg)
> +			delta =3D tick_to_ns(vcpu, ticks);
> +		expire =3D ktime_add_ns(ktime_get(), delta);

[Severity: Medium]
Is it intentional to call ktime_get() again here instead of reusing the 'no=
w'
timestamp captured just above?

If the host thread is preempted or delayed between capturing 'now' and
evaluating this second ktime_get(), the execution delay is effectively added
to the remaining timer duration.

For an already expired one-shot timer, could this cause the code to program
a small positive tick value instead of 0, delaying the interrupt injection?

> +	}
> +
>  	if (ktime_before(now, expire))
>  		delta =3D ktime_to_tick(vcpu, ktime_sub(expire, now));
>  	else if (cfg & CSR_TCFG_PERIOD) {
> 		period =3D cfg & CSR_TCFG_VAL;
> 		delta =3D ktime_to_tick(vcpu, ktime_sub(now, expire));
> 		delta =3D period - (delta % period);

[Severity: High]
This isn't a bug introduced by this patch, but does this code allow a guest
to trigger a host kernel panic?

If a malicious guest writes to LOONGARCH_CSR_TCFG, setting the CSR_TCFG_PER=
IOD
bit but leaving the CSR_TCFG_VAL bits as 0, 'period' will evaluate to 0.

When the vCPU is scheduled out and later restored, this branch executes
because the timer is past its expiration, resulting in a modulo by zero
operation.

Could this division by zero in the host kernel be prevented by validating t=
he
guest-controlled timer period?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715072952.1433=
171-1-cui.tao@linux.dev?part=3D1
