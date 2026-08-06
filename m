Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D42BD0B
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984466; cv=none; b=Dl50mcnziz55Na4xLumPFY8KHXkyptt4TtCXc6RHJjBgkSPUc9ydojaxxptkiaI19AvuSov6Ty1Mf2HGdR8QXJ2+KbJvZwzS6NzPtDAvYjIhqR3edOFl8rBC41nC0GSIZnxow7urnW/U/P+CzrIOd/GFkNqb/HyL9lk1dUK/6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984466; c=relaxed/simple;
	bh=/MYo7I/BCfx6dPSCKIpXoaGm3M5vi+j6tyXVZP0S2cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HRTBocPOPM1mt2cRiEDs1ezoRZ8AwZPfSu+HI7giQL8GWqdQnlX11xNraFJ25xB2rYK5aIItOjt9/940sphk89uE8vIT7aHQ5vFZ4OnAdYbvLDF7H9/QNXwMW0SjsjWoubYUWJrzkXuZgvUBiiz/nrstfafIjEevIUvcLV0mqNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmZ9XkmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmZ9XkmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A651F000E9;
	Thu,  6 Aug 2026 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984465;
	bh=tqc+RXPYXuEb0i0Xsk+EEOQBr4gMC8dEgtq/HbyZHRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmZ9XkmAnFP/p6UVICEvL2ugZVwG2+e7o+3H33616osPZgywtJBKwPgIe6eIPAQ7B
	 tt/tN8Oy1VFYZW26ZODbxL/YvxCvKoKQgf59000uW9ZvG6uO1+Rjc2W233+z0q9A6o
	 J/+3HT+dEJm+KStRW8Cy9feezSsLZWdQsHv1NWmGVUZ+/+mAAh41nmI6XDiNuRXFtu
	 mhEIoUpSPd9Oi2rtPzbisdkPDufgpn78DWg5VPkVZnwq0+2oyooSVDr+JjKajTOa5I
	 ELnGgkMZDqRpW8nyYZ21bumIKhiQ5P7yXMvDDyf6sajqwUeQaB++LF/zDzpJ9BBLmi
	 HgZM+UhGVwvYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806020739.2149268-6-maobibo@loongson.cn>
References: <20260806020739.2149268-1-maobibo@loongson.cn>
 <20260806020739.2149268-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:47:44 +0000
Message-Id: <20260806024745.44A651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `CSR_GTLBC_USEVMID` bit is not cleared when virtualization i=
s disabled, leaking guest TLB hardware state into the host execution enviro=
nment.
--

--- Patch [5]: [PATCH v2 5/5] LoongArch: KVM: Enable separate vmid feature =
---
commit 3bea8b9a7dbd607efeb389e6233ef3a1a4c29bf9
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Enable separate vmid feature

This commit enables the separate VMID feature on LoongArch KVM if
cpu_has_guestid is true when LVZ is enabled and the LVZ version is 2.
It updates cpu-probe to set LOONGARCH_CPU_GUESTID and modifies
kvm_arch_enable_virtualization_cpu() to configure the new bit.

[ ... ]

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 72c1d23156e50..712b078db0d54 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -359,7 +359,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>  	write_csr_gcfg(0);
>  	write_csr_gstat(0);
>  	write_csr_gintc(0);
> -	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
> +	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);

[Severity: Medium]
Should CSR_GTLBC_USEVMID also be cleared when virtualization is disabled?

When KVM is unloaded or a CPU is brought offline, the hardware virtualizati=
on
state is supposed to be fully restored. While this patch updates
kvm_arch_enable_virtualization_cpu() to clear CSR_GTLBC_USEVMID during
initialization, the corresponding disable function seems to miss it:

arch/loongarch/kvm/main.c:kvm_arch_disable_virtualization_cpu() {
	write_csr_gcfg(0);
	write_csr_gstat(0);
	write_csr_gintc(0);
	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
	...
}

Does this cause the USEVMID configuration to leak into the host execution
environment?

Although the host operates in root mode (VMID 0), leaving hypervisor
hardware features enabled could potentially interfere with kexec or
secondary hypervisor setups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806020739.2149=
268-1-maobibo@loongson.cn?part=3D5
