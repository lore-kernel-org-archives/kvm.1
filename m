Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC993B637C
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478133; cv=none; b=AmqDR2nTuSRtMk8em+VAZP+eLXYvtFFCPjjvG7Yn5YS/S5PQYEOIkcl01XnMvWEV6OOFgfKbIZD9Y8xztHTMAlDinwTe4vnd84/hSOTnLLYSWdJgvPa8SpKbH/rpmVu/FFg7U80LgLhnYBlWTyIg3gE4Jp9eXaM54A8NoJTVZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478133; c=relaxed/simple;
	bh=6pFCkt3f8UtUM3ks9pij/fOXqV0Rt8vuE936ZAzgbNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pl8AkXg3xH2EytUaljTz+GzqBroFphjM56RqAmtTqdWIOqehAQkyewg7U700I1iiTkthM3fcaWb7WqxRul+OsGecdvG7APtjyyD/l7ZPgjks3KuTRJ44mIZuFnLSAeND6m1KXOVjhN1DPE5xtYICjgPrzZWeqdmqWbov944R4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhDMc8Oh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhDMc8Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825361F000E9;
	Wed,  8 Jul 2026 02:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478131;
	bh=Yh4Mia/Uxj/L96ssIBjiaVLCkEiOqOxdzng+Lhj80MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhDMc8Ohe5s2sLRLTHiSXRSPmY4ri7Q5+DAKn+96O1WAcNSKArh5Sau9U+2kZnr1i
	 QRPmJJ+9raDnkLVa+NuB9CBns2wMeyt62eFYyjYfXBYHv5E2zuw4e3qybuTY3ywdBP
	 rPg1hoeo3F7c2YYC3HcL0l3pGV5vaPkrtHpw4ltIAlW01TlBC0ta7WhzvSvjdQ09uf
	 hS5dU3vNy3+LTI4amDLSIUAJ/I2xzOHTbnoeygmzyv/i7xIyax2CWAJqFSp4H330wH
	 ifxoTSl7DsPsP8BjtqGr79GBUB+o4o0Axz8c73setsHOLvH19NEdKezLRvDmhk0JVP
	 bgMYk5+tTsaZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Wu" <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:35:31 +0000
Message-Id: <20260708023531.825361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lock inversion and deadlock risk: `cpus_read_lock()` is acquired w=
hile holding `kvm->lock`, `vcpu->mutex`, and `kvm->slots_lock`, violating t=
he KVM lock ordering hierarchy.
--

--- Patch [1]: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for T=
D init ---
commit 60173e3dd2d8767ff9b1708338f63d8f3d6d8481
Author: Binbin Wu <binbin.wu@linux.intel.com>

KVM: x86: TDX: Use validated CPUID entry count for TD init

This commit ensures KVM_TDX_INIT_VM uses the validated CPUID entry count=20
when parsing CPUID data. This prevents issues if userspace modifies the=20
input count concurrently during setup.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c59..b658b03e77508 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm=
_tdx_cmd *cmd)
>  	if (IS_ERR(init_vm))
>  		return PTR_ERR(init_vm);
> =20
> +	/*
> +	 * Use the validated entry count, as user_data->cpuid.nent may have
> +	 * changed.
> +	 */
> +	init_vm->cpuid.nent =3D nr_user_entries;
> +
>  	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
>  		ret =3D -EINVAL;
>  		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but does the KVM_TDX_INIT_VM
initialization path have a lock inversion?

Looking at the call chain triggered by the KVM_TDX_INIT_VM ioctl,=20
tdx_vm_ioctl() first acquires the inner KVM locks via=20
tdx_acquire_vm_state_locks():

arch/x86/kvm/vmx/tdx.c:tdx_vm_ioctl() {
    ...
    CLASS(tdx_vm_state_guard, guard)(kvm);
    ...
    r =3D tdx_td_init(kvm, &tdx_cmd);
    ...
}

The tdx_vm_state_guard acquires kvm->lock, all vcpu->mutex locks, and=20
kvm->slots_lock.=20

Then tdx_td_init() continues and calls __tdx_td_init(), where=20
cpus_read_lock() is acquired directly:

arch/x86/kvm/vmx/tdx.c:__tdx_td_init() {
    ...
    cpus_read_lock();
    ...
}

Since KVM locking rules require cpus_read_lock() to be the outermost lock,
does acquiring it while holding kvm->lock and the other inner locks create
a deadlock risk against CPU hotplug or other paths that acquire these locks
in the correct order?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708022937.2465=
796-1-binbin.wu@linux.intel.com?part=3D1
