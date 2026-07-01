Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D1125AA;
	Wed,  1 Jul 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914039; cv=none; b=G8Kebb8UjY5n3UIsniA2jV+Sc9qc72I7TucGAbLrzUZNoH5b6u9HsE0gXX6xWg/tBhwVIy+GxwSmyzpMm4rjmxyBXu2Dd4g8q2vwtm0Iow+EMao8QM/mVgeuHe939EqhGxuDCxuWZCaLxLLDZMp3gF6y26PDJa7pC+A6bTrkrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914039; c=relaxed/simple;
	bh=k7hhghhQCCr5+P0V75toB9zQuyOKGTvbO69r8w5IP0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dLEuoYWwhBQx2qz1GvJI+kSz4mlMmpG4oUCHSdDPmO+F5CqTYVw3S9ecpYrgPQDGkm5Ge6hvXyFsAHhJxc17xPcrtPCjVTVbv7BtR4SLOZ+0qkDHtQGM8cOh5M/NFRt02d3G1c562pen2r2R1cJjw+pucbI21C06c8bcHUtx6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnkG3Fyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnkG3Fyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE91F00A3A;
	Wed,  1 Jul 2026 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914038;
	bh=HbDXdgaUeBgOJU7aFzlWMhXoQzp5l+xfZDaTm/LuWa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BnkG3Fyy6fZzt+p2ZQ+JpFrk1rAgpxAwN4msIPAoaF8HqGrs/49YFnrV/c6OPTE4C
	 bf1Wo8Enf6ejekLmquVV+5g2yU30+8IBhJ/tUR5gv509bVo4GR4dEnivqIIjAODC6a
	 cBsKXobbs1hunvRh9Gf/nclop41DvxAI/CtDyf3Eo+2+y9jLHuCCqhGri8A5rp4z4r
	 jUB2F4jKssaBrhzUorK238ylBnqef0gJ5vb/CpEg7DYj92or6DHji1Q5425Xajf7Yn
	 e661JLzesy++MQFDnWU7Gl4fB+pJ1QngWt/7ZAEM08dLYgRSe6Zpa6eCbXfw/vJbdQ
	 Nkk9oLWBL8Y3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] riscv: Add Zic64b to cpufeature and hwprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: kvm@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-10-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-10-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:53:57 +0000
Message-Id: <20260701135357.E8CE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The Zic64b extension is exported to userspace via hwprobe but la=
cks corresponding KVM support, preventing VMMs from discovering and exposin=
g it to guests.
--

commit 071fffe45b5cfa38ee92c48f5063587d8cccb183
Author: Qingwei Hu <qingwei.hu@bytedance.com>
riscv: Add Zic64b to cpufeature and hwprobe

This commit adds support for the Zic64b extension to cpufeature and hwprobe.
It introduces a validation callback to ensure consistent CBO block sizes and
exports the capability to userspace.

Link: https://lists.riscv.org/g/tech-unprivileged/topic/question_about_zic6=
4b_and/119631059

> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 430dc49a82863..36ec8ab470423 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -122,6 +122,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZICCRSE	(1ULL << 4)
>  #define		RISCV_HWPROBE_EXT_ZA64RS	(1ULL << 5)
>  #define		RISCV_HWPROBE_EXT_B		(1ULL << 6)
> +#define		RISCV_HWPROBE_EXT_ZIC64B	(1ULL << 7)

[Severity: Medium]
Since Zic64b is being exported to userspace via hwprobe here, should it also
be added to the KVM UAPI?

Without corresponding KVM support in enum KVM_RISCV_ISA_EXT_ID in
arch/riscv/include/uapi/asm/kvm.h and kvm_isa_ext_arr in arch/riscv/kvm/isa=
.c,
VMMs will be unable to negotiate and expose this capability to guests.

Does this patch need parallel KVM API plumbing to ensure virtualization
parity for this mandatory extension?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D10
