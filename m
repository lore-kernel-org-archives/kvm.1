Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612D38B122
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305480; cv=none; b=Fyb4qxrZTMHmR4NAUZykEqLPT0eukLz398dULveT1o910E+rqBnu0Sh9HdiGxGvFlTiZKC2nQP+HXcQQMngiQCGdkbyT1wm4o5GLtmQjs/vpTmYaJtODlOijFSh7DmGzZvw7ZHsERhbNIaD8rCNeCJzcBQU6B9AQdEFigZSmsaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305480; c=relaxed/simple;
	bh=EsNE1V3dUKZFN0fIp1R/q60j2qE+gElMpYyWtEerpY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hh9ZwfHARUxv7fFM3KgKWkDSM4aUzAI+KxRpcB0WBPPb1H9mTxIaAAI1M9SUxlPiBcsQG3IDCe1OXRqahGPVP4QMLD+kMLB2af8I7Ixs9OL9CU1APS7hUzIKdfDBrqpgLva18x8gnc/WV1W0PgkKR/p8BPr6xiwhAK1wYQrIu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi7zNbE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi7zNbE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EDC1F00893;
	Mon,  1 Jun 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780305478;
	bh=V+WuR9bKYi9PKJOXEUfi753AkAWl8rRN5o6R470o0no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qi7zNbE72zfmabxIZdwsswSufAKYSlwlasvO7h4LShQSGbZhz4MQ6OFkxqhEndrVc
	 n5ZmtJ5g83UCuExLVy+5Ixjvt2W7ceI5otaJgWZGMdIaCHqDztyNqvugFHFeLdVTA0
	 fsUw+QvxmS3EorrqhABb7bErCDGdPEaI12+S7Z6AwyxNKbSa4DmfcxshmxeeUrwGkH
	 ecHlhBpe7zsb5Aeay/vhvo+555A2bfCY882gLl8M2PidbBaJO5IEYNB0lcVTEul3FJ
	 9gNJHwFTTcl/Qjj7ehXkBqRkqoNjUEu4GGm+xAsqdy/+5zwkLtmY78BAR1Q8e9g8gq
	 HGqYXvECJ4whg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] KVM: riscv: selftests: add Svadu FWFT extension
 to get-reg-list test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-3-inochiama@gmail.com>
References: <20260601084336.2601675-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:17:58 +0000
Message-Id: <20260601091758.C0EDC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional selftest failure in get-reg-list due to dynamicall=
y-omitted registers in the blessed list.
--

commit 6df4c1234104e4c676015802e2b610d953076f46
Author: Inochi Amaoto <inochiama@gmail.com>

KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
   =20
This commit adds the Svadu FWFT extension registers to the get-reg-list
selftest's expected register list.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8d6fdb5d38b89..d88edef77ccfd 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
[ ... ]
> @@ -905,6 +908,9 @@ static __u64 sbi_fwft_regs[] =3D {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
>  };

[Severity: Medium]
Will this cause an unconditional selftest failure when the SVADU extension
is disabled?

The RISC-V get-reg-list selftest disables all ISA extensions (including SVA=
DU)
by default to ensure a clean baseline. The KVM implementation conditionally
exposes these pte_ad_hw_updating registers only if the SVADU ISA extension =
is
enabled on the vCPU.

Because the registers are added unconditionally to the expected list here,
and RISC-V does not override check_supported_reg() to conditionally filter
them out, KVM omitting these registers from KVM_GET_REG_LIST will cause the
test framework to fail with a missing registers assertion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D2
