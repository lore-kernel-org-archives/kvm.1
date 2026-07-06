Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC84436BEB
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362315; cv=none; b=S+SedE0TRkJxzjdzM73yIPPRhRBWQqJVop4pZPR+YN7lDx6RMSCs5v4dcrGq5TyYXcJ5v+Jd5N6i0pmPWdiPz09ML56ZLfYCxw788aTa5FPGyM/Xd8ySeDgtYmuu3AgYlgNcealD9OlqBvaG5SyM2xmTLoQjbdW4g0HsxBIMtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362315; c=relaxed/simple;
	bh=guXvyxJ0r2GALUPGYl3JjQFYeMIrKFkBYjBdSsFwvUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MbQu0wDHl/kmFsQL8GczmWnmM8uMexqKcgZ0eOLZSg29nafUkkR6cFW80szpUizaNvVoOf8xmZaXzdL/iQ0HXvF6wq7D6gUjgSdiaGbeVMMfo4gq/zVi8YMjiIDJVsefW1dZe34XZrXcLOap1rhmGmAJDvZc4MEXIp/lhPHeYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSAsjjyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSAsjjyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125F91F000E9;
	Mon,  6 Jul 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362314;
	bh=g4C5QvPJfMmkMGoSflJEnmcfRNQ3MRfykOV3/8OG/5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSAsjjyvNddmthTstQPtKF/x2D4+/nVxQ04yO05Loiet0VT4Ll6wfQNl7Y85R8V0V
	 tBuoCZCAGJqEt7GIfFep9377l9RnxCssiH0YO2f+3SelUtJdAs/2Klpv/dtXuKT6O+
	 7qdghvUKHjUXiSfHtLu7nISt3u9Dpew/ZtgR2KjP28x3GI68r53c+c75yN5y05J6i8
	 vTs/mMebRacHBmrVR2c6KO2c+DQX8XHxZWbWxdrNaDsMmFy/ssxHnCr4JPXuVSaLR8
	 iuVCW8URiJ0J0SY9RfFW+YxOy3mOvIpD5PCV6qJTMPPwV+tQfioloC2SA6Kj+Xoy09
	 oVsMVPFNj6BRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] RISC-V: KVM: Zicbo[m|z|p] block sizes should be
 always present in ONE_REG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706181522.2003922-1-anup.patel@oss.qualcomm.com>
References: <20260706181522.2003922-1-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:25:13 +0000
Message-Id: <20260706182514.125F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The Zicbo block size ONE_REG interface breaks the get/set symmetry=
 contract by silently discarding written values, leading to multi-hop migra=
tion failures.
--

commit d84da4691ff077e1c79d8bbd1343deea4485ef7b
Author: Anup Patel <anup.patel@oss.qualcomm.com>

RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG

This commit modifies the KVM RISC-V one_reg interface to ensure the Zicbo
block size config registers are always available, regardless of whether the
host supports the corresponding ISA extensions. It drops the host ISA
extension checks from the get, set, and index copy functions.

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..61988382570fe 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -50,19 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_v=
cpu *vcpu,
>  		reg_val =3D vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOM))
> -			return -ENOENT;
> -		reg_val =3D riscv_cbom_block_size;
> +		reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : riscv_cbom_block_=
size;
>  		break;

[ ... ]

> @@ -144,21 +138,15 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm=
_vcpu *vcpu,
>  		}
>  		break;
>  	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -		if (kvm_riscv_isa_check_host(ZICBOM))
> -			return -ENOENT;
> -		if (reg_val !=3D riscv_cbom_block_size)
> +		if (reg_val && reg_val !=3D riscv_cbom_block_size)
>  			return -EINVAL;
>  		break;

[Severity: High]
Does this break the kvm_one_reg get/set symmetry contract?

If userspace writes a value of 0 to the zicbom_block_size register, the new
conditional check allows the write to succeed, but KVM discards the value
without saving it to the vCPU state.

If userspace subsequently reads the same register from
kvm_riscv_vcpu_get_reg_config(), KVM unconditionally returns the host's nat=
ive
block size (when the extension is present) instead of the 0 that was
successfully written.

Could this silent discard of the written value cause migration failures acr=
oss
heterogeneous hosts, such as migrating from a host without Zicbo to a host
with Zicbo, and then back to one without it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706181522.2003=
922-1-anup.patel@oss.qualcomm.com?part=3D1
