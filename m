Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6463BFE34
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368354; cv=none; b=DcmKxWwGbU14qPft3L9GMaVO6Fgv2YAsfbfhw55ze7zG8KKBDb9jR5WVkYjSL53TdHi/WntwBXnpnk3/bRoMsp/roxgYQ7NVuRhoneGN4rfAokwB5b/5xLoBZ7LLJS3dtpULXubEE3SbuDh5bug/0n8wEanRbY+3+wXHfByFC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368354; c=relaxed/simple;
	bh=CWevDlRVGGa+F9TVFxW5yFVcx6NegzKrVzoPEms0Ij4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RcOyqu12khk9XA70RaaLUO+nhLdtDJ5sk7Imqgyrp2NIDZLS+KHVeeSu0V93HKXuUvg3ZCx21+jCe2PCay/hNN+UTlf6MyDA2NJQ6GDhlqg+5j/AoTcsgY5aSq/1wCLNU7RyH35u2GYbgmfQFQAeijEFEb5WFSG+om7J/D0dUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAJllbox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAJllbox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347AE1F000E9;
	Wed, 29 Jul 2026 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785368352;
	bh=TnNyo7NNO7PVIpgmfdqqCsbnDWmE89oiY49S29N7BoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAJllboxpd9Bfa+VTIpWua034UeX5zPJwr3sjhTJJt6uG8D71zIXasuMg1aNwGwVQ
	 hFX/5ElZUynpyySOTfKULq0moiURn2OE+h4/aCn/O6kClvK2pF0O/zPOWYVqbKw/zj
	 Nyl37kkx2qstbNAbIrXdoEYYFWZdjaHxFMMbwY3YbF2Os2y+1oLuRRQIGAVoVVfPnQ
	 CcaYTrY5MqYL+XpK7lNRVqVZlm9BNJSx39ySrZ0sgR+3CnuxoCH14t/2MZ7LHLFnxK
	 cBdqwLbqzKKhUKv+8N3WHg5LABNM3lQMFgLHig3lPvMF5PR1o/lSEsDRsOg+Y0FR/0
	 oA1kPi/rmgyBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] RISC-V: KVM: Add SBI extension validate callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729232527.139183-2-inochiama@gmail.com>
References: <20260729232527.139183-1-inochiama@gmail.com>
 <20260729232527.139183-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 23:39:11 +0000
Message-Id: <20260729233912.347AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The validate callback is skipped for disabled extensions, defeatin=
g its stated purpose of cleaning up state.
- [High] The FWFT extension completely lacks the implementation of the new =
validate callback.
--

--- Patch [1]: [PATCH v3 1/4] RISC-V: KVM: Add SBI extension validate callb=
ack ---
commit 3b3c6bd10bd24fef09cd0cfc1f43717873d6c992
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add SBI extension validate callback

This commit adds a generic SBI extension validate callback to allow extensi=
ons
to correct their parameters before the first run. It is specifically intend=
ed
to fix an issue where vCPU state remains broken if the FWFT extension is
disabled after its features have been configured.

> Add the generic SBI extension validate callback so the FWFT
> extension can fix its parameters before the first run.

[Severity: High]
Is the actual implementation of the validate callback for the FWFT extensio=
n=20
missing from this patch?=20

The generic framework is added here, but the validate function pointer=20
assignment for vcpu_sbi_ext_fwft in arch/riscv/kvm/vcpu_sbi_fwft.c appears=
=20
to be absent.=20

Without implementing this callback in the FWFT extension itself, the=20
parameters will not actually be fixed when the extension is disabled.

> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 46ab7b989432b..b737e9a7a12a2 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c

[ ... ]

> @@ -723,3 +723,26 @@ void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
>  		ext->reset(vcpu);
>  	}
>  }
> +
> +void kvm_riscv_vcpu_sbi_validate(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context;
> +	const struct kvm_riscv_sbi_extension_entry *entry;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	int idx, i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +		entry =3D &sbi_ext[i];
> +		ext =3D entry->ext_ptr;
> +		idx =3D entry->ext_idx;
> +
> +		if (idx < 0 || idx >=3D ARRAY_SIZE(scontext->ext_status))
> +			continue;
> +
> +		if (scontext->ext_status[idx] !=3D KVM_RISCV_SBI_EXT_STATUS_ENABLED ||
> +		    !ext->validate)
> +			continue;

[Severity: High]
Will this condition prevent disabled extensions from cleaning up their stat=
e?

The commit message notes this callback is needed to fix the vCPU state when=
 a=20
user disables the FWFT extension after setting a value.=20

However, kvm_riscv_vcpu_sbi_validate() explicitly skips extensions unless=20
their status is KVM_RISCV_SBI_EXT_STATUS_ENABLED.=20

Does this mean a disabled extension will not have its validate callback=20
invoked at all, leaving the vCPU in an inconsistent state?

> +
> +		ext->validate(vcpu);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729232527.1391=
83-1-inochiama@gmail.com?part=3D1
