Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB33624CE
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614861; cv=none; b=H65NIobHIQEF+yS2F4daEAMlE7ERRKM1o1IL/XWh3WVn0KcE5f0SowP2hTUhalJ5mb3854wu5t21L/pHyVk1D5eqDfpKdrnHckxc/AEA+yRczA30uKlhWQnSNrzHrwVNklyA9gixAROiGUTs6ZeHSusM9hFo05jKL62fZ0TovsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614861; c=relaxed/simple;
	bh=uPvjEUpi3dU/emLMt2edC8woWUTFcP6gzykx3RPcQWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FsC/Ha5/d52s8TkZ7pJ8ZeCVQJ8YjpWlQhukkAYqrccmnKpsdyNAMeVubADtg3Up9Y7jfFbInRflVf75bzAi8JMyNO7df0JtSGhvJDXr3Sqcbnv/jIs5Tcq1+oa2AM23DP1HYomy5SpKBWwDeM3r9w1a/7rX4CeL2F8Fh8WnPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcIw4xJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcIw4xJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9DF1F00A3A;
	Tue, 16 Jun 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614859;
	bh=kbK81xtfzqH3XBXMqSKHMp+cbXgqnLuYTPwhCMLyjAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcIw4xJAeQfLGbpAoq/76fKCWZ4Thyjf7u2/lniirNzQhTJIxILYArymQIhiIQqEo
	 zB2YUUZrmqdjScXeunt0Z81qerKmmZZoja6pSs1dx7Z7+sLR1gmYGea+woAO8jTvPs
	 hTBmUXdbFzhwXfqYJn2M/2gLtJke0EIsA2n0jXpe4FJDEmsxD2QJ6FLvVT5ZrEi7AV
	 +1MYDn9P1udt+dJf0vHTDjC9Uh282B/ztLRtwKssBO1QZp4z/anqWPuB+0Ht9dlpvg
	 Vqp323D57NuE7/nsy89I/Dn1y1kDxHdoU8C666PCwLHy9rYMFZygBzm4LIV2zuiWHC
	 iF+GwyxDXl4/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616123314.82721-3-amachhiw@linux.ibm.com>
References: <20260616123314.82721-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:00:58 +0000
Message-Id: <20260616130059.5C9DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Strict size validation of the extensible `struct kvm_ppc_compat_ca=
ps` prevents future extensions without breaking backward compatibility.
- [High] Raw hypervisor `H_*` error codes are directly leaked to userspace =
as POSIX error numbers, causing incorrect system call mapping and potential=
 infinite loops.
- [High] The ioctl incorrectly queries raw L0 hypervisor capabilities inste=
ad of the capabilities actually negotiated by the L1 KVM host.
- [Medium] Device tree node reference leak in `for_each_node_by_type` loop.
--

commit c079a1c0671cc47d6e2767d0d012a074b48a3edf
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on P=
owerVM

On POWER systems, the host CPU may run in a compatibility mode (e.g., a
Power11 processor operating in Power10 compatibility mode). In such
cases, the effective CPU level exposed to guests differs from the
physical processor generation.

[ ... ]

> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 8a38be6c3b03b..7304886814435 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -443,7 +443,16 @@ struct kvm_ppc_compat_caps {
>  	__u64	size;			/* Size of this structure */
>  	__u64	compat_capabilities;	/* Capabilities supported by the host */
>  };

[Severity: High]
The KVM_PPC_GET_COMPAT_CAPS ioctl is defined using
_IOR(KVMIO, 0xe4, struct kvm_ppc_compat_caps). Since _IOR embeds the
structure size in the ioctl number, if fields are added to this
structure in the future, the ioctl number will change.

Additionally, the explicit size validation in kvm_arch_vm_ioctl() rejects
requests where user_size < sizeof(host_caps), returning -EINVAL:

arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl() {
    ...
		/* Validate size - must be at least the current structure size */
		r =3D -EINVAL;
		if (user_size < sizeof(host_caps))
			goto out;
    ...
}

Does this prevent extending the structure in the future without breaking
backward UAPI compatibility for older userspace binaries?

> +/*
> + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> + * These bits indicate which processor compatibility modes are supported.
> + */
> +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)

[ ... ]

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..5ef6713343bed 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6510,6 +6510,22 @@ static bool kvmppc_hash_v3_possible(void)

[ ... ]

> +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	unsigned long capabilities =3D 0;
> +	long rc =3D -EINVAL;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2())
> +			rc =3D plpar_guest_get_capabilities(0, &capabilities);

[Severity: High]
Are we returning a raw hypervisor error code directly to userspace here?

Negative codes like H_PARAMETER (-4) could be incorrectly interpreted as
standard POSIX errors (e.g., -EINTR). Standard userspace libraries might
handle EINTR by automatically retrying the ioctl, which could lead to an
infinite loop.

Positive codes like H_NOT_AVAILABLE (3) will be returned directly to the
userspace caller, skipping the copy_to_user logic in kvm_arch_vm_ioctl()
while still appearing as a success to userspace.

Should we map these raw hypervisor status codes to standard POSIX errors
before returning?

[Severity: High]
Does this query the raw L0 hypervisor capabilities instead of the capabilit=
ies
actively negotiated by the L1 KVM host?

According to the PAPR nested virtualization specification, this hypercall
retrieves unmodified L0 capabilities. However, KVM limits its nested guest
capabilities based on nested_capabilities negotiated during initialization:

arch/powerpc/kvm/book3s_hv_nested.c:kvmhv_nestedv2_init() {
    ...
		nested_capabilities =3D capabilities & host_capabilities;
		rc =3D plpar_guest_set_capabilities(0, nested_capabilities);
    ...
}

If QEMU receives raw L0 capabilities, could it attempt to use CPU modes that
KVM will subsequently reject during vCPU initialization, leading to guest
boot failures?

Should we return the negotiated nested_capabilities instead?

> +		host_caps->compat_capabilities =3D capabilities &
> +							KVM_PPC_COMPAT_BITMASK;
> +	}
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616123314.8272=
1-1-amachhiw@linux.ibm.com?part=3D2
