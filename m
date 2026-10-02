Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE6471CF8
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932419; cv=none; b=I0kXfpaMoqE6QaZE9zP7gMPwCOvWwqsVpoDV3bKNl8IV50q/VXq/VVLl1+SMeghEEVAWfUJkWyYlh0PYhFUy0iXZ/zbgDtfhODZnlK58UcyIHc6GTogfQNHdnuma8tGMco4FQp78H3PRLW/O3zf+j9DBvc9aoy3x2+3T/EoA0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932419; c=relaxed/simple;
	bh=8focTyJf6IFtPJn2RNRXh/L5uvb18yCnPuwmgHpUHy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCX9vmhmxq34IO4xKHiQ4tf/7Al1yBhbddMlE523iSD5oE5/D2U/Zs8zIt05a4pZDeKrXSRFvte0q/34lQUQ4Lbwi6Kk2RS0YeqccFJQyNsbgmwjKt7r+ciR1WIBAchT+uT32vlf55fDU27lsRmFQerdpsgjWRd0YiaEZWg8pZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWrqHVt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWrqHVt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA00B1F00899;
	Fri,  2 Oct 2026 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932417;
	bh=sXGU5xfEGQ5BGHBiIXGsFbAMgH7pulVUWw9qa6B/X5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWrqHVt7UH3U2jM0gCHZPNY91k5B7SzjwC6yn9lBNJcngIfWB522fuptgDkK5AHVc
	 gpBbwUXsPmu/XnwvDlcGDs9irATVDMSGw+TGSWm4UBwbziODOMQdlJjfivID4F94tg
	 tFqIOGjGveF+5/1i4bavKxGiS2FG+iC6nugwHINPqMr6gkrRUf9OxF1Z7BgDAt1Y1+
	 /GQX55Q1TXjZq5StQpujCoyaKE/gowFbySKZ/ZBdhS3TMOUo0llWofwt/qJEYeZ3Cw
	 AqQmJ3x4ZMSC1F7hmuXHaeiHqflHaBWW/UhLLSuCh/9F368IDRLw07KhlVvXMw2/0x
	 ncHWyOkS2i8Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 16/23] KVM: selftests: Load per-vCPU guest stack in
 TDX boot parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-16-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-16-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:36 +0000
Message-Id: <20261002091336.EA00B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: selftests: OOB array access in tdx_vcpu_load_boot_parameter=
s()
- [Medium] kvm: selftests: silent integer truncation bypasses bounds check =
in tdx_vcpu_load_boot_parameters()
--

commit cc6d621273aee216e856ad9b309ad6da83f69649
Author: Sagi Shahar <sagis@google.com>

KVM: selftests: Load per-vCPU guest stack in TDX boot parameters

This commit allocates a guest stack for each vCPU and records its GVA in
the TDX boot parameters region. This allows proper vCPU initialization.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/t=
esting/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 40ee9b1951c28..270a4ee1b7ebc 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
[ ... ]
> @@ -90,6 +90,18 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm =
*vm)
>  		    "gdt must be within 32-bit address space for 32-bit boot code");
>  }
> =20
> +void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *v=
cpu)
> +{
> +	struct td_boot_parameters *params =3D
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params =3D
> +		&params->per_vcpu[vcpu->id];

[Severity: Medium]
Will this lead to an out-of-bounds array access in
tdx_vcpu_load_boot_parameters() if a test uses a sparse vcpu->id?

The boot parameters region appears to allocate memory for exactly
nr_runnable_vcpus instances of struct td_per_vcpu_parameters in
tdx_vm_setup_boot_parameters_region():

    size_t boot_params_size =3D sizeof(struct td_boot_parameters) +
        nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);

Since vcpu->id represents the KVM vCPU ID (which can be the APIC ID on x86)
and can be larger than or equal to nr_runnable_vcpus, could this write beyo=
nd
the allocated bounds and corrupt adjacent host memory and guest physical pa=
ges?

This could be triggered if a selftest creating a TDX VM specifies a sparse
vcpu->id that is larger than or equal to the total number of runnable vCPUs
passed to vm_create().

> +
> +	vcpu_params->esp_gva =3D kvm_allocate_vcpu_stack(vm);
> +	TEST_ASSERT(vcpu_params->esp_gva < (1ULL << 32),
> +		    "ESP GVA must be within 32-bit address space for 32-bit boot code"=
);

[Severity: Medium]
Does this bounds check in tdx_vcpu_load_boot_parameters() actually work, or=
 is
the value silently truncated before the check?

Because kvm_allocate_vcpu_stack() returns a 64-bit gva_t, assigning it
to vcpu_params->esp_gva truncates the value to 32 bits since esp_gva is
declared as a u32.

The TEST_ASSERT then evaluates the already truncated 32-bit value against
(1ULL << 32), which will always be true. Could this bypass the intended
safety check and cause silent stack corruption and test failures instead of
an explicit assertion failure?

This could be triggered if a selftest allocates enough memory such that the
guest stack virtual address exceeds 4GB.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D16
