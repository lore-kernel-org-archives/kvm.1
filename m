Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5F471415
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932412; cv=none; b=V85OH6oRn012Y6OHbJuT5ChH/EwE5RTlaHAlLKy1cYXzww1+RO6PUol/4GSzY3E1kcITkl85Fy4w5durTqgp7V9fft0E4VI3Z0eslfat8uUDeEoG05VsuQIMLiLV9RSsFzljXKp9/dzKE4G0zaAL8MYSE1LHdA88bJaFLUUm890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932412; c=relaxed/simple;
	bh=cnM+w8gLvHu0g4da1jumvItWc+d7iBUlA3qESZkhL3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/IVwoMHKWVUJ8yqM7OuHCWaVQ+9Xf/ch87HUYqEkm1cSLhwum6XPlib4NLN9CtjsmzPOFsUo6vCRhR9ByskkbiqTAmeYijPHgMRRngUex/oE9ZruzWsZ/QlE58COmvvl/o++3suwKLxjxn44q8lEPPAz5VT1RBnkDSShIa6D38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1P9ud/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1P9ud/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1148B1F000FF;
	Fri,  2 Oct 2026 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932411;
	bh=KbxjCyyrvhrHHbkR8qXHd4YdedjXxAR6+ri8CjbBo18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L1P9ud/hmnPiV3rtxf896ArCxu79qN38Yed47587I8fk++e6ilKT9EDhCIXoaiw9B
	 klMk3qewdxyQSrhy7gZhMpFX+GIqIGPNG9wY4Dqz+nrq8a0dC8m49KPhoC/02xAMr2
	 8FMaxh7Z1+Vm8sBc5epDg0otLenA/uSc6KtZryi/pcYRMXE/BVMO4rxp+2Et162Iap
	 mYVunVWMhbhXEZx5PBK6Xc1z4FXra6Hx8SEz5nJlnf99GMi+I+guSCOkMqtQPm3oTz
	 9RlhEGAJC03jBp37foiCWDB2I9Kqc4ggoYxzqtP0WFG3sHgIMLNSTWZEuTC58mdUCk
	 R7GHPymO2x8dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/23] KVM: selftests: Initialize the TDX VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-3-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:30 +0000
Message-Id: <20261002091331.1148B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/kvm: uninitialized padding causes KVM_TDX_INIT_VM fail=
ure
- [Medium] selftests/kvm: data race on static tdx_cap in tdx_read_capabilit=
ies()
--

commit 3680cc9e7726e14977411713d50e23fbb8635ddc
Author: Sagi Shahar <sagis@google.com>

KVM: selftests: Initialize the TDX VM

Add tdx_init_vm() to handle the mandatory VM-level initialization
sequence required for Intel TDX. For TDX, the VM's CPUID configuration
must be "sealed" during KVM_TDX_INIT_VM before any vCPUs are created.
This commit masks the host-supported CPUID against the configurable
bits reported by KVM_TDX_CAPABILITIES.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/t=
esting/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 0000000000000..3a8900ff25404
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "processor.h"
> +#include "tdx/tdx_util.h"
> +
> +static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct k=
vm_vm *vm)
> +{
> +	static struct kvm_tdx_capabilities *tdx_cap;
> +	int nr_cpuid_configs =3D 4;
> +	int rc =3D -1;
> +	int i;
> +
> +	if (tdx_cap)
> +		return tdx_cap;
> +
> +	do {
> +		nr_cpuid_configs *=3D 2;
> +
> +		tdx_cap =3D realloc(tdx_cap, sizeof(*tdx_cap) +
> +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));

[Severity: Medium]
Could this realloc() cause a data race if multiple threads attempt to
create TDX VMs concurrently?

If tdx_read_capabilities() checks and reallocates the static pointer
tdx_cap without locking, concurrent calls might race on the realloc(),
potentially leading to memory corruption, a double free, or a
use-after-free during test execution.

[ ... ]
> +void tdx_init_vm(struct kvm_vm *vm)
> +{
> +	struct kvm_tdx_init_vm *init_vm;
> +	const struct kvm_cpuid2 *tmp;
> +	struct kvm_cpuid2 *cpuid;
> +
> +	tmp =3D kvm_get_supported_cpuid();
> +
> +	cpuid =3D allocate_kvm_cpuid2(tmp->nent);
> +	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
> +	tdx_filter_cpuid(vm, cpuid);
> +
> +	init_vm =3D calloc(1, sizeof(*init_vm) +
> +			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
> +	TEST_ASSERT(init_vm, "init_vm allocation failed");
> +
> +	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));

[Severity: Medium]
Does this memcpy() copy uninitialized padding into the ioctl payload?

Since allocate_kvm_cpuid2() allocates struct kvm_cpuid2 using malloc(),
the padding field can be left uninitialized. The kernel's
KVM_GET_SUPPORTED_CPUID ioctl does not clear this padding, and it is
subsequently copied into init_vm->cpuid here.

Because the KVM_TDX_INIT_VM ioctl strictly validates that cpuid.padding
is zero, could this cause KVM_TDX_INIT_VM to fail with -EINVAL if the
padding contains garbage?

> +	free(cpuid);
> +
> +	init_vm->attributes =3D 0;
> +	init_vm->xfam =3D 0;
> +
> +	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
> +
> +	free(init_vm);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D3
