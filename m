Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDC49A3C3
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994150; cv=none; b=oYGzGJ+5Ab+W5F0M+2/eWVZv/hk8z9HNQUnDnhGSS4nQdB+J8wHJO15s/FrFNyntGy8U3LHOuvlhcZCPtgBdleA1kgmnd4/gECndNCRtHxrjINTaq6qLqHezDoSJVzr02rub/GCcWMNz337TNMTnLuaRPLwFloZO0f3u+NsxhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994150; c=relaxed/simple;
	bh=1KvxwuS25EF/no5Z1pi9py0qFAxICp2dtM3rPiWavlo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mNHH5Q09v/1srde8pbyGRVnedpJ3s7aLZvGW4aG2hCKsur/nQwhZZaNg+jA19belC0Oxatz3VAdppB0xLj21toXaQUP6p/+EwV9Hj2Rz98OYc96lk8x5ud2NWO9RTp30/ncrzYdNet9qMYbicjRUV2vdbpLQhbOAqCeQ3peCdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcpp9gmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcpp9gmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BC71F000FF;
	Mon, 21 Sep 2026 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994144;
	bh=iq3gn4TNcPDE4jh+Ou5pfKzJP4f+ZQ0NOW1KANzi6lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcpp9gmMkBZ7TPiGQM/fPJ74PC9+QIL0C31rq0xYnMAOBivDTVYtyOs7dxCSCTEPD
	 x/v3YRVZYPk5RPtgU8Ho2fA6EaNfMArHrorGxTGZCdJHegB8E+Riugc3YPrMQqwqq1
	 oiVMJbEDH4+wEpNmH5A8gTfw0QqBJ8MUCIAv83yTdU5qIdsz9jhepL2icG0c7bV+J6
	 KSZVo0XixdYWdF/cOcsTmJljOfB+ZmRKHrp8ZEWvqfeQFdqqP12ZAH2bV+QVvgh+zz
	 b4Hxc1BKzVmrDQdxw4/ln01ZlQrPM0/+fEw0pxE+yzSub39NrwEIXCcF+OLgJvEiiu
	 dUkHjCskqYCqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 1/4] RISC-V: paravirt: Add pvqspinlock KVM
 backend
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R1VPIFJlbiAoWHVhblRpZSk=?= <guoren@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921-pvqspinlock-v4-1-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
 <20260921-pvqspinlock-v4-1-409a22aed6ef@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 12:35:44 +0000
Message-Id: <20260921123544.A1BC71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: new SBI_EXT_PVLOCK extension is enabled by default breaki=
ng migration
--

commit f1e45d3725cd5aab3846041669bc52a712a0d928
Author: GUO Ren (XuanTie) <guoren@kernel.org>

RISC-V: paravirt: Add pvqspinlock KVM backend

Add the KVM backend for the SBI PVLOCK (paravirt qspinlock kick_cpu)
extension. kvm_sbi_ext_pvlock_kick_cpu() kicks the target vCPU out of
the halted state via kvm_vcpu_kick(), and yields to it with
kvm_vcpu_yield_to() when the target is already runnable.

> diff --git a/arch/riscv/kvm/vcpu_sbi_pvlock.c b/arch/riscv/kvm/vcpu_sbi_p=
vlock.c
> new file mode 100644
> index 0000000000000..728e59f3f18fb
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_pvlock.c
[ ... ]
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pvlock =3D {
> +	.extid_start =3D SBI_EXT_PVLOCK,
> +	.extid_end =3D SBI_EXT_PVLOCK,
> +	.handler =3D kvm_sbi_ext_pvlock_handler,
> +};

[Severity: Critical]
Does this extension need to be disabled by default to prevent ABI breakage?

Since vcpu_sbi_ext_pvlock omits .default_disabled, it evaluates to false,
causing KVM to default the extension to KVM_RISCV_SBI_EXT_STATUS_ENABLED
during VM initialization.

Silently enabling new guest-visible KVM features breaks live migration.
Migrating the VM to an older host kernel without this feature will cause
the guest to crash when it attempts to use the extension.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-pvqspinloc=
k-v4-0-409a22aed6ef@kernel.org?part=3D1
