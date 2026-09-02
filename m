Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70568239E60
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333661; cv=none; b=EP75QdxIRjRRVSEVxm1bZoaMH8UFKxdHHDy+Kjhjdg8FriaYQAjHfF7FrazKQ6dYAKxuQ2CyhLh9wTu6BAhjBhCZz4MbqCjqy2YA7ZXdcXJi2914pX56jahZrBiJAZcl0J7ibleRKPTtQ06crixOyVcOf1Ga+3vvZhxaJ+5kYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333661; c=relaxed/simple;
	bh=4VRB0zvQSk9hDeP3S+y9pPZX9GoSN8EAHFordGT2+1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tV73vpSO3+7bvDhI7Mcg5cFrZEyBSO2sAemoFJWczitikkH3tTIQBjafnh8AZHQ/PgQLZtCPUpmKJXgBwpAM81XUtPwgOF9cQkW3AvI8Y4pN4RH/1RIDbabOelF8GEhuX09a93SLlRRVkIGZkLz700adFno5GNmR2ht0RbjebKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izgusj9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izgusj9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ADC1F000E9;
	Wed,  2 Sep 2026 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333659;
	bh=jslCaen+CpB9El0H+7GPtnAF8Ir802150hQPctmmqhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Izgusj9EQN3MARAmjF8P6AFyxZvEpqxuCkOkqRc6C8SL2QMHaoxaQLQec5myf7P3U
	 kmYsGulSYnTsrpPzbLU1f/Yrp28azjSFtGpt7+OiJjRnh32YyF/A9sswF4xfjhgCP8
	 3uzFWno5cjkHW0kR2pg8CKqjjMx+DQQnds+h5qySFLbrioUfC8tmrJmRz3iMIrTrbk
	 +vSm8bPTKjB0qPWv4fl0Bk9HZ9rk5yumjnqyHZODnimJ60pLRhZkDzd0qi/1ZPo40a
	 PlBaHsWkl+4pw5lflLTTKUfv/toPb1ULDyOUsDIJxK2bxIFoNtjIDX6UqPBV6Xlci5
	 PqQFXKlgEE46w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] LoongArch: KVM: Fix resource leak in
 kvm_loongarch_env_init() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaithanya Lagisetty" <nagachaithanya9911@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902070724.3459457-3-nagachaithanya9911@gmail.com>
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
 <20260902070724.3459457-1-nagachaithanya9911@gmail.com>
 <20260902070724.3459457-3-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:20:59 +0000
Message-Id: <20260902072059.90ADC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resources allocated by kvm_loongarch_env_init() are leaked and lea=
d to a Use-After-Free if kvm_init() fails in kvm_loongarch_init().
--

commit 694694d624a3a8bfec5f756c533d743cd130b9fa
Author: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>

LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init() error path

This commit fixes a resource leak in the error path of kvm_loongarch_env_in=
it().
It ensures that previously acquired resources and device registrations are
unwound in reverse order if any subsequent registration fails.

Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4bd..c9cb3fc2e5605 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
[ ... ]
> @@ -385,27 +385,51 @@ static int kvm_loongarch_env_init(void)
>  	/* Register LoongArch IPI interrupt controller interface. */
>  	ret =3D kvm_loongarch_register_ipi_device();
>  	if (ret)
> -		return ret;
> +		goto err_env;
> =20
>  	/* Register LoongArch EIOINTC interrupt controller interface. */
>  	ret =3D kvm_loongarch_register_eiointc_device();
>  	if (ret)
> -		return ret;
> +		goto err_ipi;
> =20
>  	/* Register LoongArch PCH-PIC interrupt controller interface. */
>  	ret =3D kvm_loongarch_register_pch_pic_device();
>  	if (ret)
> -		return ret;
> +		goto err_eiointc;
> =20
>  	/* Register LoongArch DMSINTC interrupt contrroller interface */
> -	if (cpu_has_msgint)
> +	if (cpu_has_msgint) {
>  		ret =3D kvm_loongarch_register_dmsintc_device();
> +		if (ret)
> +			goto err_pch_pic;
> +	}
> +
> +	return 0;
> +
> +err_pch_pic:
> +	kvm_loongarch_unregister_pch_pic_device();
> +err_eiointc:
> +	kvm_loongarch_unregister_eiointc_device();
> +err_ipi:
> +	kvm_loongarch_unregister_ipi_device();
> +err_env:
> +	kvm_unregister_perf_callbacks();
> +	kfree(kvm_loongarch_ops);
> +	kvm_loongarch_ops =3D NULL;
> +	free_percpu(vmcs);
> +	vmcs =3D NULL;
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does this leak the vmcs, kvm_loongarch_op=
s,
and device registrations when kvm_init() fails in kvm_loongarch_init()?

arch/loongarch/kvm/main.c:kvm_loongarch_init() {
    ...
	r =3D kvm_loongarch_env_init();
	if (r)
		return r;

	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
}

If kvm_init() fails, kvm_loongarch_init() returns the error directly without
calling kvm_loongarch_env_exit() to clean up the successful
kvm_loongarch_env_init() setup.

Could this leave dangling function pointers in the perf core that lead to a
kernel panic upon the next performance counter event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902070724.3459=
457-1-nagachaithanya9911@gmail.com?part=3D2
