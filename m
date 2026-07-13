Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60A24113D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928836; cv=none; b=H53s3eMM98pr8r7mjsukQngYpI8ztOg0HJ2BnXXAzU9TVa7q+W+bEFX0GBVnBkIJ8uJ+tTJ7j6MMBKW6aesq5Io522mDdrCE46VG/zcnTZkG00M/R8ZpalH43u5cq7P4OopPPTZvCxk77MLxRY53xd2dshxEdBN2KADGzUpvEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928836; c=relaxed/simple;
	bh=JC5emDKxCnJnP/sjdhTfm6gfdwJ0u0EKER3uGG1FYoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNt1IAK7IHh9T3jc5+c3nUqW1fJORnyKqyoZYPdju7azb/3e05eFg+QveZx/KEga/CW17xYmaAAWo7om0fDFGMqfF6PApoQaxxEL1lH3blcKqGou+PyokPn/GXW4kRdsNaHrLzirH6fn3gFeUC3xCp12nsdHj4SsGZ5+4zvW/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkmqipWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkmqipWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DA51F000E9;
	Mon, 13 Jul 2026 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783928834;
	bh=COvQeEhyq/+zY1HXCbE8sbonk/WCd1mUJw/uGv7VwXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkmqipWNzSb+ImWH+fswR8U5llvv+IY4sVkPGf5tniDq/IceI9mt6zt9kLY1kcXZs
	 /3L22vHcOtyVNLA0WGE2+ObckMxOPeahJY3Hxa9D5LseNOrXCPIQT+6SuA+dRpo5dY
	 u1Lh1Kg34/xX9BHa9VTJXjTaL5EqeSv0KC5NYoxWUWbI1y8frufbQFDKtwojRFUtAT
	 dhr++VW35NWJP1RtSSmVtkYg7GDgFU3u74XJv0bejtHbjENNeKgMpF0TviNrAyLV7+
	 xkK7cNcOxvsPre2TiU9GIImwQvOgJZZ1k4tywuY5HM2g7NKoHUrbvVDwjfW9NmNXp0
	 ZIMI0B7N4LQdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending
 state updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Bo" <xb@ultrarisc.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713073346.1293408-2-xb@ultrarisc.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com>
 <20260713073346.1293408-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 07:47:14 +0000
Message-Id: <20260713074714.80DA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Restoring guest `sip` (or `siph`) CSR via KVM_SET_ONE_REG drops pe=
nding interrupts from KVM's internal `irqs_pending` tracker, causing a vCPU=
 stall if the guest executes WFI.
--

--- Patch [1]: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending =
state updates ---
commit 445393d6bd22386cd7da7af1c9dd4c9d3be703a4
Author: Xie Bo <xb@ultrarisc.com>

RISC-V: KVM: Serialize virtual interrupt pending state updates

RISC-V KVM tracks guest interrupt state with two bitmaps: irqs_pending and
irqs_pending_mask. This commit serializes all updates to these bitmaps
with a per-vCPU raw spinlock to fix a race condition where injected
interrupts could be lost.

> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..cba3682944b69 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
[ ... ]
> @@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kv=
m_vcpu *vcpu,
>  		reg_val <<=3D VSIP_TO_HVIP_SHIFT;
>  	}
> =20
> -	((unsigned long *)csr)[reg_num] =3D reg_val;
> -
> -	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +		raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +		vcpu->arch.irqs_pending_mask[0] =3D 0;

[Severity: High]
This is a pre-existing issue, but does restoring the guest sip (or siph)
CSR via KVM_SET_ONE_REG drop pending interrupts from KVM's internal
irqs_pending tracker?

If userspace (e.g., QEMU) migrating a VM writes to KVM_REG_RISCV_CSR_REG(si=
p),
csr->hvip is updated and irqs_pending_mask[0] is cleared. However,
irqs_pending[0] is not updated with the restored state.

Later, if the guest executes WFI with interrupts locally disabled but
globally expected to wake it, kvm_riscv_vcpu_has_interrupts() will return
false because it solely checks irqs_pending:

arch/riscv/kvm/vcpu.c:kvm_riscv_vcpu_has_interrupts() {
    ...
	ret =3D vcpu->arch.irqs_pending[0] & ie;
    ...
}

Could this cause a VM hang or stalled vCPU after live migration if it enters
WFI?

> +		raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> +	} else {
> +		((unsigned long *)csr)[reg_num] =3D reg_val;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713073346.1293=
408-2-xb@ultrarisc.com?part=3D1
