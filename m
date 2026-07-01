Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE98F49
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899809; cv=none; b=RwKBQ90BAEgrruiBD/nKcfB39WU3QriD+7F7Aw+iBYQ1ADg1rSEbcvnDu/4WZzUA/xe8vdOjd/kVT1qqWnMGkBVBBKS2OeALhb2DWYqhNZubAw+FH2yH/w6xyNUK61PrMBiO55FP35OU3j3QWPH6dDzt2KvGCkeqDX53LIR2O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899809; c=relaxed/simple;
	bh=hjlk6F/ENVxeTJ7tsWIVn9I32JWLalQ+7uvkTpX+4Bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X71wEKKOqFt7lbdptqsDiNc0ifsN5L6Y1U61YcTqW8q9GnhQe6CfJlNhR0GUb+OOkq6HLFSNa+iMbKiRKNz60SLKdZ2CuPvHesGBX53G3pzLum2dzXJaJfM9GRM0Dma5i8IYdnb5kxlpplTkTjwZPxzmdk0kRvE1rz5NdL167Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxInm7ON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxInm7ON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A4A1F00A3A;
	Wed,  1 Jul 2026 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899808;
	bh=PD5kNh4PajoAJBaKz0dYS4VVk8ufD2TlRLoOPZENiY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxInm7ONVA/8KC3oAn8U9I0ehkR+t30y3UryXQMbhyLKNi1pkVpeWgOl/MzA0go4O
	 M2suwXcK5ge7aO1i6Ap6juGOU+yVyr9XLxWdBZ6nSK7gixpuCZ+t7FRHtfURQbkzN0
	 tFC1WQdU4oEHJVtB47vSKV2goNtA5YO06wasj3ql9S8AtOe38jwjDiuTBHnZy7ASb/
	 kfPm5c8KXQkttqwL/YEI7ApYBHYhbe5Hpqo7xCLopoDyMUo0AxoCkLSQnkUlOX0WUR
	 c3IToJ1Bdg0+Em55xlHQpB3kXE3nvGHpSqxPX+UkGvNi0mPfbd8MgwyA8zXbv7Y0Us
	 AoqF101d8d24A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] RISC-V: KVM: Add SBI FWFT validation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701094731.1022163-3-inochiama@gmail.com>
References: <20260701094731.1022163-1-inochiama@gmail.com>
 <20260701094731.1022163-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:56:47 +0000
Message-Id: <20260701095648.37A4A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL pointer check on the explicitly optional `feature->=
supported` callback leads to a potential kernel panic.
--

commit 0a44921a7fcd1601c393c31f9c36440ef03d03b8
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add SBI FWFT validation support

This commit adds SBI extension parameters validation for the SBI FWFT suppo=
rt=20
in KVM, bringing it in line with other SBI extensions.

> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd8..14701a130fd56 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c

[ ... ]

> @@ -420,6 +420,30 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *=
vcpu)
>  	}
>  }
> =20
> +static void kvm_sbi_ext_fwft_validate(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +	const struct kvm_sbi_fwft_feature *feature;
> +	struct kvm_sbi_fwft_config *conf;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(features); i++) {
> +		feature =3D &features[i];
> +		conf =3D &fwft->configs[i];
> +		if (!conf->supported)
> +			continue;
> +
> +		if (feature->supported(vcpu))

[Severity: Medium]
The struct kvm_sbi_fwft_feature documentation defines the supported callbac=
k=20
as explicitly optional. If a future feature is added that omits this callba=
ck,=20
could this lead to a null pointer dereference here since it is invoked=20
without prior verification?

Other functions in this file, such as kvm_sbi_ext_fwft_get_reg_count, verif=
y=20
the callback exists by checking if (feature->supported) before calling it.=
=20
Would it be safer to include a similar check in kvm_sbi_ext_fwft_validate?

> +			continue;
> +
> +		conf->enabled =3D false;
> +		conf->flags =3D 0;
> +
> +		if (feature->reset)
> +			feature->reset(vcpu);
> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701094731.1022=
163-1-inochiama@gmail.com?part=3D2
