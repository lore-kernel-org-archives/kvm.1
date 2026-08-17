Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8739DBE5
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968571; cv=none; b=WCbOKYwTxoBI7GtGXlBPvt1b5QtxU9cvvWUFII4N2hLK/s7QywTx/1u1QGgFxAAX7feskiOjjn1nJXEL6exIRSzmnVRo+7R7tg+bB1h9UyBLjEdCoaGD9HBWw1EDVkAwWNyygOatKZ9j0VeogFCD4QdqR+8yLHZoMbLXp0S5JHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968571; c=relaxed/simple;
	bh=FSL6WrfsF2R7Nkf3zKate4sxFjAhKIFlkZGTeX3W2B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Koy8537QmhG7Yb9zwoF61VqidmK8SmdAHqINgTTvYX4AWb/g3jAGQox5g0jGGFtaRNwF4ansWWg6XGkUPkwecZKo0Ztd1eq6Me0pLUC76qoCUyDWxYi+xLdm05DzB4MXN1JMYdKk71YvFqjGjnQUUuKTiMbbY64fwvXwt6T2yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvwV6lib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvwV6lib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D557D1F000E9;
	Mon, 17 Aug 2026 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968570;
	bh=gISeScrvM6srS+hueu8pt4GHYvChfK2b/KLS6q0sxdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvwV6libNEhszUqCrrSnjT5KsWj25QsZ4BFEXaNXoO1EOKChGgB+opeyrMLu6XcJ3
	 sBVDjp8okMKfxLt8kHoZBClsLgvaspJFbvHqVVrkySBdVneNiE99fAWytTLMpyD2vN
	 n/FH4ci55Zoxr90wgWYpm2sFi/oobyVZCQCCM0MFB9gim3IcusYU8ocM6H6L50nqlw
	 fkXlFVfXivGf1rRthC1/Yc0qXgxMPFpLcO1znGihe+qocl50hwVNJDR2/Q9itWsyQg
	 aLjuTDSzu/aCMJMK2VR5Wa2Nz3LDygDppRzerMGqQsV6zFzAoa8tDDto/kmx86miRH
	 7/Jt3tLvtSRHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Fix memory leak in
 kvm_loongarch_env_init() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaithanya Lagisetty" <nagachaithanya9911@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 12:09:29 +0000
Message-Id: <20260817120929.D557D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `kvm_init()` fails inside `kvm_loongarch_init()`, the resources=
 successfully allocated by `kvm_loongarch_env_init()` are never cleaned up,=
 resulting in memory leaks and a Use-After-Free vulnerability in the `perf`=
 subsystem.
--

--- Patch [1]: [PATCH] LoongArch: KVM: Fix memory leak in kvm_loongarch_env=
_init() error path ---
commit 3316df872b1f0235601822bdf17b8099f74a1eed
Author: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>

LoongArch: KVM: Fix memory leak in kvm_loongarch_env_init() error path

kvm_loongarch_env_init() allocates the per-CPU kvm_context (vmcs) and
kvm_loongarch_ops, and registers the perf callbacks, before registering
the IPI/EIOINTC/PCH-PIC/DMSINTC KVM devices. If any of those device
registrations fails, the function returned the error directly without
freeing vmcs and kvm_loongarch_ops or unregistering the perf callbacks.
kvm_loongarch_init() propagates the error without calling
kvm_loongarch_env_exit(), so these resources are leaked.

Unwind the already-acquired resources on the error path, mirroring
kvm_loongarch_env_exit().

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index f105a86143f5b..f003a91b227c2 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -384,22 +384,33 @@ static int kvm_loongarch_env_init(void)

[ ... ]

> +err:
> +	kvm_unregister_perf_callbacks();
> +	kfree(kvm_loongarch_ops);
> +	kvm_loongarch_ops =3D NULL;
> +	free_percpu(vmcs);
> +	vmcs =3D NULL;
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but since we are fixing leaks in this area,
what happens if kvm_loongarch_env_init() succeeds but kvm_init() fails?

Looking at the caller kvm_loongarch_init():

static int kvm_loongarch_init(void)
{
	...
	r =3D kvm_loongarch_env_init();
	if (r)
		return r;

	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
}

If kvm_init() fails, its error is propagated directly without calling
kvm_loongarch_env_exit() to unwind the environment.

Does this mean the resources allocated by kvm_loongarch_env_init()
are still leaked in that error path?

If the perf callbacks remain registered when the module load fails, could
this result in a use-after-free in the perf core since the module memory
will be freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817115847.2705=
791-1-nagachaithanya9911@gmail.com?part=3D1
