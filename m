Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161B28504D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883703; cv=none; b=lkDhW4SljAN0ttPU1jrEwNbFlVVi811rXiiwfOhVmQy4lBCqZhPRX8h/EKj5z90wnUxq4B66P68zlzqspw8WF+qlXyKKMMEcGRPBc9148KRp/1cOX19KT20aP9r65KkcBFTJPxK4BRuT3lInUFWY8IlCt633VM7tpq9p9pwDSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883703; c=relaxed/simple;
	bh=ItTocOQpka7cJj1iPl/4p0yOzFa4iIXhIUHeFksxqfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7NUibzPX7O0L3e5tv0RHZ3KOvy+u4Pz2GBcQOOUhzBA9mu2UCSPUSE78MMA4PlI+TBJRMPwBdX2ilkAR9X4W+At2T2HDLOCMdzAjBvxq1/h1iQgEKCKapCTqbkEQkhQxaqxtlVOjChZKob7mIYqnDY9lIHZ7C9hj4gzA391Owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7d+My6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7d+My6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95641F000E9;
	Wed,  1 Jul 2026 05:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782883701;
	bh=pyjl4SOjgI2WyiLfCDzEkXwMMMcHfeNoKHN+33gTieU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7d+My6NrGqJ9UTkM4e5cINhct3uLg38gugv52Cs3frmY16dqYEWN4iJSP/rOJ18T
	 eLQHJezvksYpR2zRceIBmL1O6ykjbWX02iXX1YDsvYEBhou+V1ODMfOf7h1q8wV7+M
	 6ifrFydYyJMyxfeyWnJHs0dFEdJcxcMX4k6b3z5212JvOzL1KDdRVrWXXPGXXQpJur
	 Ylhl0nOfGE0KZdlwRq5bjQ1WSHRovnd/WUcpRp1RHKelHCPGQefUewuA8YEcPrHAEI
	 bVRWeSObEU/lO3ErVIySxcBLolmjW9+/itBsBOWVX494uzV5EfcsEuZwYBGOGn8SQS
	 a6gwsQmh0uJ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701051409.51820-5-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
 <20260701051409.51820-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:28:20 +0000
Message-Id: <20260701052821.A95641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The documentation specifies the ioctl returns `-ENOTTY` on non-p=
series platforms, but the code returns `-EINVAL`.
- [Low] The ioctl parameter is documented as an `(out)` parameter, but it i=
s actually an `(in/out)` parameter.

Pre-existing issues:
- [High] The UAPI unconditionally overwrites the user's `size` field with t=
he kernel's struct size on success, leading to future user-space buffer ove=
rflows.
--

commit 2c871fad53b6cd5636eeb954745af1ef601fd441
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation. The ioctl exposes host processor compatibility modes support=
ed
for nested KVM guests on PowerPC systems.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index a5f9ee92f43e8..43810c451317f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
> =20
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)

[Severity: Low]
Since userspace must set the size and flags fields before calling
the ioctl, should this parameter be designated as (in/out) rather than
just (out)?

> +:Returns: 0 on success, negative value on failure
> +
> +Errors include:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> +           written to userspace
> +  EINVAL   if the ``size`` field is smaller than
> +           ``KVM_PPC_COMPAT_CAPS_SIZE_VER0``, if the ``flags`` field
> +           is non-zero, or if the backend fails to retrieve or map
> +           CPU compatibility capabilities
> +  E2BIG    if ``size`` is larger than the kernel's struct size
> +           (new userspace on old kernel); the kernel writes back its
> +           own struct size into the ``size`` field so userspace can
> +           retry with the correct size
> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-pseries platforms or when the
> +           required KVM operations are not available)

[Severity: Medium]
Is this error code accurate for non-pseries platforms?

Looking at kvmppc_get_compat_caps() in arch/powerpc/kvm/book3s_hv.c,
it appears to return -EINVAL instead:

arch/powerpc/kvm/book3s_hv.c:kvmppc_get_compat_caps() {
    long rc =3D -EINVAL;

    if (kvmhv_on_pseries()) {
        ...
    }

    if (rc < 0)
        return rc;
}

> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +IBM POWER system server-based processors provide a compatibility mode fe=
ature
> +where an Nth generation processor can operate in modes consistent with e=
arlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibili=
ty modes
> +supported by the current host processor for booting the nested KVM guest=
s on
> +KVM on PowerNV (nested API v1) and KVM on PowerVM (nested API v2) platfo=
rms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use, must be 0 */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +  };
> +
> +Before calling this ioctl, userspace must set the ``size`` field to
> +``sizeof(struct kvm_ppc_compat_caps)`` and zero the ``flags`` field.
> +The kernel rejects non-zero ``flags`` with ``-EINVAL`` to prevent
> +uninitialized stack values from being silently accepted, keeping the
> +field available for future use without ABI ambiguity.
> +
> +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> +to support extensible versioning: if userspace passes a struct smaller
> +than the current kernel version (``size >=3D KVM_PPC_COMPAT_CAPS_SIZE_VE=
R0``),
> +the kernel zero-pads unknown trailing fields.

[Severity: High]
This isn't a bug introduced by this patch, but while documenting the extens=
ible
versioning, does the existing code in kvm_arch_vm_ioctl() handle successful
calls correctly for smaller user structs?

arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl() {
    ...
        host_caps.size =3D sizeof(host_caps);
        r =3D copy_struct_to_user(argp, usize, &host_caps,
                                sizeof(host_caps), NULL);
    ...
}

By unconditionally overwriting host_caps.size with the kernel's struct size
on success, if the kernel struct is extended in the future (e.g., from 24 to
32 bytes), a userspace application passing size =3D 24 will get a success r=
eturn
but have its size field overwritten with 32.

If userspace then reuses this struct for a subsequent ioctl call without
reinitializing the size field, it will pass size =3D 32. Will the kernel th=
en read
and write 32 bytes to the user's 24-byte buffer, potentially corrupting mem=
ory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701051409.5182=
0-1-amachhiw@linux.ibm.com?part=3D4
