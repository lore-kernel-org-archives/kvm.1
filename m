Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3F471415
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932418; cv=none; b=hC6wW+9IJmy9euIiTl/4+OQVXeworAMPqZVuEr5eFZc/uEnYp3axeDnvRCh1HNOBmGkTiNWXbO3n83sD3Aaq6EPEhUoK0Q5gG8tKSQIzYOGUFd7XPFEXsT2i839OLLIwdEZmlHAjaxmGLSfKCi1OZfLncyTdb2fjx4ENMNtvH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932418; c=relaxed/simple;
	bh=EAyz3YU51OxD/L/22746YkExtpnjTQWpnuJUL0/UK+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5EBT2g50nDLLSCQPy5Jzs7piEdnqSULgaC1GFSe68ZqAz8EjLqjltG8RR06Hx8ZzOZcBfwJp+hkTJTAQ+blI9F2TE8ZWoUYqLnkQwpf3hfqDlaWbbk3zLeocmEI72FSvuu08IGXt9OEijtu3f8vnRTRkv4XzU1Jhx9hwxxbjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuEH5EGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuEH5EGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4245D1F00893;
	Fri,  2 Oct 2026 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932416;
	bh=/HG8aYl2h5dMJECB3wt14EScZQ0UzcUc1YlIcFlVD90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LuEH5EGaK0RRcVeyJ4UNlMQah3CsztXx5uQQyC4Hlh9FU9YBmN1r20xKVANcEyJyR
	 v7N2MZarksq0zyeF4HBvBBSCG2Fd34WbDLVMbYqkvtsZxFoEPW7kMQn0StxIxEI5PL
	 30JLZzASQaaRBgodIvQ2VebZGrOAblRBrsXOOtHcp0Mownw38srVwo6tfHXGKezwOt
	 1i+L5vxs0RtN9lMGN7d6d8Wzrng1YRqeMdwpyWaL+EbHqS57noE7V7pw35LHy/8jrL
	 5RLsfBkfk6ZIdW2sUk2Lgv31jWJLhUYZUNldMxG2l/5W4kKwP4C14bJI/3va/ycOsD
	 g0fRfyraCN3Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 17/23] KVM: selftests: Set entry point for TDX guest
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-17-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-17-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:35 +0000
Message-Id: <20261002091336.4245D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/tdx: out-of-bounds write via unvalidated vcpu->id in b=
oot parameters
--

commit 5aefdec609eb9d20918c0aee05259719b0c3c0d2
Author: Sagi Shahar <sagis@google.com>

KVM: selftests: Set entry point for TDX guest code

This commit introduces a mechanism to set the guest entry point for TDX VMs=
, as
the rip register is inaccessible. It accomplishes this by writing the guest
code address to a predefined location in the guest memory, which is then lo=
aded
into rip during the TDX boot process.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/t=
esting/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 270a4ee1b7ebc..5f10a7c1455d8 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -102,6 +102,16 @@ void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm=
, struct kvm_vcpu *vcpu)
>  		    "ESP GVA must be within 32-bit address space for 32-bit boot code"=
);
>  }
> =20
> +void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
> +{
> +	struct td_boot_parameters *params =3D
> +		addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params =3D
> +		&params->per_vcpu[vcpu->id];

[Severity: Medium]
Does this out-of-bounds array access risk memory corruption?

If a test creates a TDX VM with a sparse or high vcpu->id (which is common =
for
topology testing), could this index into params->per_vcpu exceed the memory
allocated by tdx_vm_setup_boot_parameters_region()?

For context, tdx_vm_setup_boot_parameters_region() allocates memory strictly
bounded by nr_runnable_vcpus rather than KVM_MAX_VCPUS:

tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c:tdx_vm_setup_boot_parame=
ters_region() {
    ...
	size_t boot_params_size =3D sizeof(struct td_boot_parameters) +
		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
    ...
}

> +
> +	vcpu_params->guest_code =3D (u64)guest_code;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D17
