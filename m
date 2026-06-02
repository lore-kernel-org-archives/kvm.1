Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E633C3443
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388056; cv=none; b=ceN3gEi9HsNbvEx9TBD52y37nJqyRo54wUHPvOZjMrqjn0BI3tBnxgnXUDYUJ986PChsEWYDXHXmGbP2a2eYEDNVEpC2PK1oqOPgss2zJsTVkWW6Cil0eVrY4HdbexRyjqvVpy4NclXJ/rlU2MgaAWCa+7zVCwTayz/IIrCdAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388056; c=relaxed/simple;
	bh=FhwZnFlDa1HGz0u29n/qM1s3rVIMC6jItTvlAh1u5Og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TmSoLR6WNolCeyIfinq37qEKbqW7a/i2KofN+w+65qSWTSl9UiyehmJarNKmnVJ657NJZt4NdIHl/Lv7WBQwxge5iwffn+KpXyPoRIjPmCrtHoyASo/q8gEB11phF6QLeYektSbU0bfb39oY19Cvq9lfWlwnNt92eaZtPHFLdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO7Emr6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO7Emr6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335A81F00893;
	Tue,  2 Jun 2026 08:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388055;
	bh=sK0v2i9NkTHns4/AO3AV5Wp7WOtlRphL+FjoZ86nkm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KO7Emr6WP4iXis2BwRXieceH40Yy587ysZ+R+LSek32MDdA8L9+4fxQeAwLL965BR
	 Mup8BZpNEt2qATPw/DpKul127GYF5rgBb9b4zAsRIVWPXbrJkwj7S8f/hFjEt6pbho
	 bu+Eb9aLIloTggOQ+BZeUC6l8RJWo3jiS+K2CClVLYmKhTe04DPOTP4ugO+kG3bUO9
	 dsBDuCuxnaThcXaTwxF8bqnqWHwDzy1VH3e6YvLpIenxkauS/VNzlcl9g8bjo3FZvS
	 gIxRcRhiFN/FrBtVOSQ6/0vUWc1Onw/2hosnr9HkKhALjSllA957V+xVVoKZ49ryTC
	 Ja9D5EhM9VMGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] LoongArch: KVM: Enable FPU with max VM supported
 FPU type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602074316.1647373-3-maobibo@loongson.cn>
References: <20260602074316.1647373-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 08:14:14 +0000
Message-Id: <20260602081415.335A81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Guest FPU state corruption during KVM_GET_FPU and KVM_SET_FPU =
ioctls due to incorrect memcpy size.
--

commit b7cc21c20eb234e9b61a20543d60e2cc92754208
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Enable FPU with max VM supported FPU type

This commit modifies the KVM LoongArch FPU handling to enable the FPU using
the maximum type supported by the VM. This avoids unnecessary FPU exceptions
that occur when applications mix different FPU types.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index c28aa37f37a98..7f55875d8b3bb 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed a potential
truncation issue in the FPU ioctls in arch/loongarch/kvm/vcpu.c.

In kvm_arch_vcpu_ioctl_get_fpu():

	for (i =3D 0; i < NUM_FPU_REGS; i++)
		memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDTH / 64);

Since FPU_REG_WIDTH is 256, FPU_REG_WIDTH / 64 evaluates to 4. Because
memcpy() takes a size in bytes, this copies only 4 bytes per register
instead of the full 32 bytes (256 bits).

Does this memcpy() size argument truncate the FPU state?

This could cause silent data corruption of the guest's FPU state upon resto=
re
via kvm_arch_vcpu_ioctl_set_fpu(), which has the same memcpy() length:

	for (i =3D 0; i < NUM_FPU_REGS; i++)
		memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], FPU_REG_WIDTH / 64);

Is this copying only a fraction of the registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602074316.1647=
373-1-maobibo@loongson.cn?part=3D2
