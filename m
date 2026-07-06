Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62107213254
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316887; cv=none; b=Qi9C172xMzunFsXUHeXUBmuuFPebjGnMhAvuzCbqckwW0lVPEPJFo4tOI63mrc1Qz2m3tzXOG0r0IVtgqln7DL9ZW/ZdbUJhRUspDt9HbRyzK/Mwu5h2n6XXcDD7OZqtVOpDMGnvDXyU/Sr94jKQXWZJ1rXawH4i+GCCqow3j9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316887; c=relaxed/simple;
	bh=bBD47grz2Y8DD5ul58x6Wp5sGcAMpIlZ7j2YeVjfzLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sU7LxCVUds8aPv5M2Wz3/dIJ95Y3bbvJ8wvSRUVnPtnFEkvqBY7dyiz/HIs3IWh+GR2e0LYZ+bi2yD429caFFqvHdzJJZcd4NjPJkWmZ3/i4pF3CHwUsstVwFkziN03qfQYE4DQGjcdXY+IhWCP81QHJZrIqSY7mDFMadyPRuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoZj3ktk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoZj3ktk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDAB1F000E9;
	Mon,  6 Jul 2026 05:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783316886;
	bh=xdUoHCB2p6WHjeOECR/yDvqg7/7vRYV3IxTD7ZeVxPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoZj3ktkEj9bahjA0k8B5UMTYGUJXE3NlhosF0BD2TzD0mE04FFnpaVGQqQ3+yWgn
	 vw5snHM0C3+LjiXl6mdyMZohNnjMcz2qMjbbfpRvwmukY5ddt+umWPrzMQa2Fdl7wo
	 7XdA0QsQW6HjWd/78aJli+kP0BuXUB+K0E4sn6FvEdpjdDxe4tMop5JGrykHok+8rQ
	 r2OE3Imh63/T4TiQzbOsiByC4uwFSFhB1alCBncNRKjzq2xIcUdZAZ9WIRFR91rFBq
	 +XBildaTYDQo4KH/kMFz/J34OL4AawVP5I+qkFLeHvafcKVIz2VYG8UzKMkwBSihSX
	 iGHyecuYsYQFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Zicbo[m|z|p] block sizes should be always
 present in ONE_REG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706054002.1089394-1-anup.patel@oss.qualcomm.com>
References: <20260706054002.1089394-1-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:48:05 +0000
Message-Id: <20260706054805.BEDAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally exposing Zicbo[m|z|p] block size registers breaks =
cross-host live migration from hosts without these extensions to hosts with=
 them.
--

commit 1377d7b8ff798dd58124162657e04db537839784
Author: Anup Patel <anup.patel@oss.qualcomm.com>

RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG

This commit drops the ISA extension checks for the Zicbo[m|z|p] block size
config registers in the KVM RISC-V ONE_REG interface. This makes these
registers unconditionally available to KVM user-space.

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..26d78987f2c23 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c

[ ... ]

> @@ -144,20 +138,14 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm=
_vcpu *vcpu,
>  		}
>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOM))
> -			return -ENOENT;
>  		if (reg_val !=3D riscv_cbom_block_size)
>  			return -EINVAL;
>  		break;

[Severity: High]
Does removing this extension check break live migration from a host without
the extension to a host with the extension?

If a VM is migrated from a source host lacking the Zicbo* extensions, the
block size saved by userspace will be 0. When restoring this VM on a
destination host that has the extension (where riscv_cbom_block_size > 0),
userspace will call KVM_SET_ONE_REG with 0.=20

Because the host extension check is now removed, KVM will unconditionally
execute the equality check and return -EINVAL since 0 does not match the
destination's block size, causing the migration to fatally fail.

>  	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOZ))
> -			return -ENOENT;
>  		if (reg_val !=3D riscv_cboz_block_size)
>  			return -EINVAL;
>  		break;

[ ... ]

> @@ -614,20 +602,6 @@ static int copy_config_reg_indices(const struct kvm_=
vcpu *vcpu,
>  		u64 size;
>  		u64 reg;
> =20
> -		/*
> -		 * Avoid reporting config reg if the corresponding extension
> -		 * was not available.
> -		 */
> -		if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicbom_block_size) &&
> -		    kvm_riscv_isa_check_host(ZICBOM))
> -			continue;
> -		else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicboz_block_size) &&
> -			 kvm_riscv_isa_check_host(ZICBOZ))
> -			continue;
> -		else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicbop_block_size) &&
> -			 kvm_riscv_isa_check_host(ZICBOP))
> -			continue;
> -
>  		size =3D IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U6=
4;
>  		reg =3D KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;

[Severity: High]
Does unconditionally including these registers here force userspace to alwa=
ys
read and migrate them?

By always reporting these registers, userspace on a host without the
extensions will now read their value as 0 and migrate that value to the new
host, triggering the -EINVAL failure in kvm_riscv_vcpu_set_reg_config()
mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706054002.1089=
394-1-anup.patel@oss.qualcomm.com?part=3D1
