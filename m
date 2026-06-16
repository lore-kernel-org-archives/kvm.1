Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FA22D7A1
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577566; cv=none; b=Pow9r8Xge8ZWAaWelNEmXcV7aBOSEFNvUTm1zALluFZzuqPFU77GGpjyMtO2lHv4vrKQlYZnyETzqaCtUiS+z6JRbSGRCkWUazkDN939nS+rmy0HBBfdz6T3P1h3WLM/l68cbyD9lvh1lDkoEiJ4wd15pxXB1Yy1uA8HzaDQMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577566; c=relaxed/simple;
	bh=McMAlHF2Qm6DKal5OBk9JO1IR07jXKBLQIeZSZuInjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hutP8vbZU5eidvkW+Kai2LH2W+6TfcKidV9W2uPfg+I2OSdcplHlZHdNV38VwXy1FTNpx3X8H4ZPx5Qbzz/i4GEjgsHTfl8Uvk5PZIGExHf7rMJXnL93PlY+WAqzWi56yPzXU4nYBYSazccTyyTzxdntI9/8wZgQJh3G5thgc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGSBC31/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGSBC31/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785621F000E9;
	Tue, 16 Jun 2026 02:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577565;
	bh=BPnciLmVyOi99MR4Z1fA+8GAZefJC+vqn/zXTl+lgFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGSBC31/lkQneNLqF+MdUmgoc5mWMVhN1JSuDKsQ50qV+MVijhvCxcEOtfGKVW126
	 vYLn2ajrGqtYTV1GK0l+vsGmJgtEAfsoKO1j4BqjX3t2eu+D52oqa7T3CfV/kUKNpw
	 h4tyVy6SUOQIINTPivjda79WZ9XTtQe9XDYl8gbbqvumUWC/Q5EbnsHzyN4b5HFtc+
	 dmPD2QlHnZKk0c0bLNZgRqdnipVGTK8+RcdVu7NLqJoDk4m39wpFPlBLOjqU31pgzh
	 FMQA3jfV8fNzFpW5g8d2dR+6JmpOueKPZO63Omknc0YdUtsQrHLoGhkYCOqcH1n++3
	 LyEfiYwTpGwIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KVM: LoongArch: selftests: Enable LASX feature
 by auto detect method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616022615.2141072-2-maobibo@loongson.cn>
References: <20260616022615.2141072-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:39:24 +0000
Message-Id: <20260616023925.785621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoding the base CPUCFG2 value silently clears FPU version, L=
LFTP revision, and other default KVM features.
--

commit 7ccc915fb84c033373faa2df43f4b5551f11c4d3
Author: Bibo Mao <maobibo@loongson.cn>

KVM: LoongArch: selftests: Enable LASX feature by auto detect method

This commit enables LSX and LASX features for LoongArch KVM selftests when
the host machine supports them.

> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tool=
s/testing/selftests/kvm/lib/loongarch/processor.c
> index 64d91fb76522d..e7fb54d746f45 100644
> --- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
[ ... ]
> @@ -292,6 +292,16 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>  		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
>  	}
> =20
> +	/* Enable LSX/LASX feature by detecting host capability */
> +	cfg =3D CPUCFG2_FP | CPUCFG2_FPSP | CPUCFG2_FPDP | CPUCFG2_LLFTP;
> +	ret =3D __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_L=
OONGARCH_VM_FEAT_LSX);
> +	if (!ret)
> +		cfg |=3D CPUCFG2_LSX;
> +
> +	ret =3D __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_L=
OONGARCH_VM_FEAT_LASX);
> +	if (!ret)
> +		cfg |=3D CPUCFG2_LASX;
> +	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG2, cfg);

[Severity: Medium]
Does hardcoding the base CPUCFG2 value here inadvertently clear other defau=
lt
KVM features?

Since KVM populates CPUCFG2 with defaults like CPUCFG2_FPVERS (FPU version)
and CPUCFG2_LLFTPREV (LLFTP revision) during vCPU creation, overwriting the
entire register with this bitmask might cause issues for tests or guests
relying on these standard properties.

Would it be better to read the existing KVM-provided value via vcpu_get_reg=
(),
bitwise-OR the detected LSX and LASX bits, and then write it back?

>  	cfg =3D read_cpucfg(LOONGARCH_CPUCFG6);
>  	loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022615.2141=
072-1-maobibo@loongson.cn?part=3D1
