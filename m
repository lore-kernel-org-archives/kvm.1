Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128D3F4DD0
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327886; cv=none; b=iP9FkbNp35EGjBi6NveLd+jr63BkxXs7qmvsKVNpoYmbLxT1QdWlSv8GN42FDNC5d5+vFvIgKsV2ibELt3DoMgCDdDQvUnhIevCAILxlGJF0W5GlQw83o171nGVEnw8qAxG4T7LIHscx5oz9iAFFuNX7N9A73X2r2mgW+W90aS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327886; c=relaxed/simple;
	bh=IUJjD1wnjjOE/gRY70pmn3Gqd+J1ug2gRJozUV49Yg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwBXxgz/NglMQNMWv38DFBEQgzewGPuWtAMh9J7LAW29HxchKTNBRepFbpfLLoy67/YLwgc6ctxAnxEnDQWyPuoD1HuAr8NGSgllPmI75APqisFx1mW2qoqmATYmnQaM6pmq+EnQQxXQoTEIjQaq1+XQuPcuhYxsFi0dLHI0DeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n56RBnDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n56RBnDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638F01F00A3A;
	Mon,  6 Jul 2026 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327877;
	bh=YpyFjbWqMqGk+aB3VDPTaa7zPKLlcnjmyJYUA8itKsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n56RBnDs5aXuYWTCNvrbdAA7WEiaTEFuzsQqRs+dQfMxV/MiyDf/IWQzKAFoqkYQQ
	 GLaBhddlmZC70D9QMkXObdsARYbH/p92bAMoM/pGXt7vqjtjzrdxIThdcEvkdO0Qb1
	 Ucr9fLzv9dIvuyN1Up8cI2fWRAEuaeKkH9jYqjIHBNKUGdfcAv4DeyeB0KDU9u4O1D
	 ojRp5CF7oCabI/cqk+R6wTgh+/5z56P+rF1Omr7YO8gf+c0CSbNsH5KfeAwAEDaTZM
	 2HbBevyb3LHi+OPb4AXlX80nGpUOyU+/LwWWtsUpfuFCbDDSWKhMN8uArja42DA7NB
	 4jlS9VYBnLzuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Zicbo[m|z|p] block sizes should be
 always present in ONE_REG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706083850.1425228-1-anup.patel@oss.qualcomm.com>
References: <20260706083850.1425228-1-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 08:51:16 +0000
Message-Id: <20260706085117.638F01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Silently ignoring writes to Zicbo block size registers when the ex=
tension is disabled allows userspace to bypass hardware block size validati=
on, leading to guest memory corruption.
- [High] Unconditionally exposing Zicbo block sizes in KVM_GET_REG_LIST and=
 validating them against current VCPU ISA state breaks VM migration from no=
n-Zicbo hosts.
--

commit ae62f61922ea3db59d443a539b06f94dce05e2f4
Author: Anup Patel <anup.patel@oss.qualcomm.com>

RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG

This commit removes the host ISA extension checks for Zicbo[m|z|p] block si=
ze
registers in the ONE_REG interface. It changes the register set logic to
validate the block size only if the extension is currently enabled on the
VCPU, and unconditionally exposes these registers in KVM_GET_REG_LIST.

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..a8333441192c5 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c

[ ... ]

> @@ -144,21 +138,18 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm=
_vcpu *vcpu,
>  		}
>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOM))
> -			return -ENOENT;
> -		if (reg_val !=3D riscv_cbom_block_size)
> +		if (riscv_isa_extension_available(vcpu->arch.isa, ZICBOM) &&
> +		    reg_val !=3D riscv_cbom_block_size)
>  			return -EINVAL;

[Severity: High]
Could this logic silently ignore writes and bypass validation?

If userspace temporarily disables the Zicbom extension on the VCPU and then
writes an unsupported block size to this register, the evaluation of:

    riscv_isa_extension_available(vcpu->arch.isa, ZICBOM)

will be false. KVM will then return 0 (success) instead of -EINVAL,
effectively ignoring the write.

If userspace later re-enables the extension, it might incorrectly believe
the unsupported block size was successfully configured and advertise it to
the guest. Since kvm_riscv_vcpu_get_reg_config() unconditionally returns
riscv_cbom_block_size, wouldn't this read/write asymmetry result in the
guest using an incorrect cache block size and potentially corrupting memory?

Additionally, could this temporal dependency on the VCPU ISA state break
VM migration?

When migrating from a host without Zicbo extensions (where block size is 0)
to a host with them, Zicbom might be enabled by default on the new VCPUs.
Userspace typically restores CONFIG registers before ISA_EXT registers.
If userspace attempts to restore zicbom_block_size as 0 while the extension
is enabled on the destination VCPU, this check will return -EINVAL and
abort the migration.

>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOZ))
> -			return -ENOENT;
> -		if (reg_val !=3D riscv_cboz_block_size)
> +		if (riscv_isa_extension_available(vcpu->arch.isa, ZICBOZ) &&
> +		    reg_val !=3D riscv_cboz_block_size)
>  			return -EINVAL;

[ ... ]

> @@ -614,20 +605,6 @@ static int copy_config_reg_indices(const struct kvm_=
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

[Severity: High]
By removing this host ISA check, won't the register be unconditionally
exposed to KVM_GET_REG_LIST even on hosts that do not support the extension?

If a host lacks Zicbom, riscv_cbom_block_size will be 0. Exposing this=20
register will cause userspace to serialize the value 0 during migration.
As noted above, attempting to restore this 0 value on a destination host
that supports Zicbom will then trigger an -EINVAL during restoration in
kvm_riscv_vcpu_set_reg_config().

> -		else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicboz_block_size) &&
> -			 kvm_riscv_isa_check_host(ZICBOZ))
> -			continue;
> -		else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicbop_block_size) &&
> -			 kvm_riscv_isa_check_host(ZICBOP))
> -			continue;
> -
>  		size =3D IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U6=
4;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706083850.1425=
228-1-anup.patel@oss.qualcomm.com?part=3D1
