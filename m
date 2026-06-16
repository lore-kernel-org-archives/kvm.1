Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4713382DC
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614063; cv=none; b=WGD3VYZtReQdDFlNTdD+x2MoS4+ZZqSLV93sh/MMhMUIxlSWuRp+n5u+Id1JCAXzvWUZy/eMoZU9ZcUi3mYOOfQT6qpEvmg2fEdmAeUOXlChJxnvgwQtM0jycDTQHRN3Zm/zdRKG/KAOqhVIlHf5CToOatxojn1mZn1kpRGB8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614063; c=relaxed/simple;
	bh=An/2vYQWuyVxL6EHaMgl/1jdJHhVufr2DjKTxF3a1UQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccrJyZzNMSSzv+wWO44Xov75Qq9vk4yLBTANIRvPKyy9MfR1XtxtiEWl2sSpu2HSlrS8yUqC2gPmuKXbzhTfP+bTQTC2AKur1WRWtN1yF270AKwbKZ677xjTwe7wXgMzVimPqf5/i16wfV+SGett2axPksz9sKQfCoBiCJQ2A+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2Ibif5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2Ibif5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF581F000E9;
	Tue, 16 Jun 2026 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614062;
	bh=J+dpuuxaEGapRb57kCSVLcSI3sFF7hYZQp8PIF47N1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2Ibif5sqn1PcVEoA+Xde74ZBgY4yI4erS2cYVJrLZ3LvtjwL176X1sQimSip6JBG
	 /z2s8BszkZaXbhG+395CIqUZZvuYBWmsLO8L8DjkxRGsFN2cqSa77a1qvPQw9FUDnz
	 3bR0saDv1DwlnMB6Csg7MnVvCphj6HiWFFcUPXobZikA33PCo5Ls0T9K4oojvSvRLn
	 xQeU3RKDVnPZ7dWWk+F9gc0j3vz1gNmH8Hsy5XHqAxBs+3VL7n73XnBFLr1UGu5/nC
	 sVU4cj7IusndBDG2z7LwA1Ud1HzMd1SQX3liwWOInnxar/ddftuyv/wPawZpzDMU9u
	 hfax2mV5UGhOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616123314.82721-4-amachhiw@linux.ibm.com>
References: <20260616123314.82721-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 12:47:41 +0000
Message-Id: <20260616124742.3CF581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing `of_node_put()` causes an OF node reference count leak whe=
n breaking out of `for_each_node_by_type()`.
- [High] Incomplete capability reporting due to missing `fallthrough` in `k=
vmppc_map_compat_capabilities`.
- [High] Hypercall H_ error codes are leaked directly to userspace as stand=
ard Linux errnos.
- [Medium] KVM_PPC_GET_COMPAT_CAPS is defined as _IOR but expects input fro=
m userspace.
- [Low] Endianness type mismatch for `cpu_version` between caller and calle=
e violates sparse typing.
--

commit 2d0f9bcccc58cf2776556c592aad6db1adf0c8aa
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

    KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on=
 PowerNV

    Extend host CPU compatibility capability reporting to support nested
    virtualization on PowerNV systems. For nested API v1, derive the
    capabilities from the L1 guest via the "cpu-version" device tree proper=
ty
    and map them to KVM_PPC_COMPAT_CAP bits.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..dd0f4d487a770 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
[ ... ]
> @@ -6510,6 +6510,57 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
> =20
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)

[Severity: Low]
Does this parameter type violate sparse typing rules?

The caller kvmppc_get_compat_caps() passes a host-endian u32 value that was
converted via be32_to_cpup(). If cpu_version is annotated as __be32, might
this trigger a static analyzer warning?

> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |=3D KVM_PPC_COMPAT_CAP_POWER11;
> +		break;
> +	case PVR_ARCH_31:
> +		*capabilities |=3D KVM_PPC_COMPAT_CAP_POWER10;
> +		break;
> +	case PVR_ARCH_300:
> +		*capabilities |=3D KVM_PPC_COMPAT_CAP_POWER9;
> +		break;

[Severity: High]
Could this switch statement be missing fallthroughs?

Host CPU compatibility modes are typically cumulative. For example, a POWER=
10
CPU would support both POWER10 and POWER9 compatibility modes. With these
breaks, only a single highest capability bit is set. Is there a risk QEMU
might incorrectly conclude that older nested guests are unsupported?

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	struct device_node *np;
> +	unsigned long capabilities =3D 0;
> +	const __be32 *prop =3D NULL;
> +	long rc =3D -EINVAL;
> +	u32 cpu_version;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2()) {
> +			rc =3D plpar_guest_get_capabilities(0, &capabilities);

[Severity: High]
Are hypercall error codes being leaked directly to userspace here?

If plpar_guest_get_capabilities() fails, it returns a hypervisor error code
like H_PARAMETER (-4). This value is directly assigned to rc and returned to
the ioctl handler. Since -4 corresponds to -EINTR in Linux, would userspace
misinterpret the error as an interrupted system call and infinitely retry t=
he
ioctl?

> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				prop =3D of_get_property(np, "cpu-version", NULL);
> +				if (prop) {
> +					cpu_version =3D be32_to_cpup(prop);
> +					break;

[Severity: High]
Does this early break leak the OF node reference?

The for_each_node_by_type() macro drops the reference to the previous node
and acquires a reference to the current node. By breaking out of the loop
without calling of_node_put(np), the reference count appears to be leaked.

> +				}
> +			}
> +			if (!prop)
> +				return -EINVAL;
> +			rc =3D kvmppc_map_compat_capabilities(cpu_version,
> +								&capabilities);
> +		}
> +		host_caps->compat_capabilities =3D capabilities &
> +							KVM_PPC_COMPAT_BITMASK;
> +	}
> +
> +	return rc;
> +}
[ ... ]
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf3..1788a00686626 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> =20
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat=
_caps)

[Severity: Medium]
Could this ioctl definition cause issues with wrapper libraries?

The KVM_PPC_GET_COMPAT_CAPS ioctl handler in kvm_arch_vm_ioctl() uses
copy_from_user() to read the size field from the userspace structure.
Since it reads input data from userspace, should this be defined as _IOWR?
Using _IOR might cause unexpected behavior with tools that assume the
parameter is purely an output buffer.

> +
>  /*
>   * ioctls for vcpu fds
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616123314.8272=
1-1-amachhiw@linux.ibm.com?part=3D3
