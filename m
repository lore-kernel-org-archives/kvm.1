Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03995366DC1
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614261; cv=none; b=PGosDZZOLCDwatGIgMWfZHjNOiYgGfTCTGW0yEirZb8sEBxHLF71DdpmzDPDkZrVdWwdxg5id2a5WQc4QuxzSDUrnSItaQOYkE+mrbYJ2JRHsWe0dn9SDdim74hqsBvosoZGtBOY1DalE460REQXuKFZwbwadbfO9wnC8EfyaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614261; c=relaxed/simple;
	bh=3nkkxQVrQOWMbvcpiSi5z5gl88Ce0YPCPnSSfZ8hkTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rAGGdsfW36xwLhXgYqFCPY0atlmwPkRo+A9XDuYeitzgnBuuUapYOk4IdjIXoF+IrJ1JFp2iMCblhp/uCwvWN72KSBdT3K5H3XJSSi5fAxffyNCwBhvs3HVF8er8mLkLXMNDgqr2ApYoPYrKfXKChyx3T18+mQ9uBceOLnifCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfF3kQki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfF3kQki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934E11F000E9;
	Tue, 16 Jun 2026 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614259;
	bh=ivuh2NUVQEtm7FGh67yzs04ObCSwUixDoX2GlULIgcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WfF3kQkiA9zAMjOD4ItcI0fKK4lLVje3PTV8Dj6NEnUzwrN2Tkmgt5w3YQIRaxSq8
	 4edIMzzQo3pQCXa1EvsH6Os1TrCiPwmvM9XftXPurXGcLoUs/AXzq0pSdXx+mxYmtK
	 HabSsR/UjM1Fe7t5Sj7TZoUzqPHk9H0IBp20GADEX+C84BgAqsmrrNuoGuzD2acwpw
	 Rq3CNSazmU+89RKdrnTLxWXEjhVLo/Q29tGYB5cjyvHdmZom6MtFf52lzlVF9xCkyy
	 +jmPwfUjpziWAtVqKBxmucxLTulE1b2+GRdS9ExUk9OPoQCTmvG/ESvjxafzr3VNzk
	 6L3ft8jJEkVEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616123314.82721-5-amachhiw@linux.ibm.com>
References: <20260616123314.82721-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 12:50:58 +0000
Message-Id: <20260616125059.934E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] UAPI backwards compatibility breakage due to invalid struct size v=
alidation.
- [High] Reserved `flags` field is not checked for zero, rendering it perma=
nently unusable for future input.
- [High] Capability mapping logic lacks `fallthrough`, artificially restric=
ting nested guests.
- [High] Resource leak of `device_node` refcount in `kvmppc_get_compat_caps=
()`.
- [Medium] Misleading documentation causing userspace to pass uninitialized=
 memory to the kernel.
- [Medium] UAPI misconfiguration: IOCTL direction is `_IOR` but kernel read=
s from userspace.
- [Medium] Inconsistent error return code on non-pseries platforms contradi=
cts documentation.
--

commit 8e3e8114a54d0e9097662db3db8e0e1e2ee2506b
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

This commit adds documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl in the
KVM API. It details the capabilities, structure fields, and expected error
codes.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 52bbbb553ce10..ba6feba74d7d9 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6553,6 +6553,53 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
> =20
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)

[Severity: Medium]
Is this parameter accurately described as strictly output-only?

Looking at the existing implementation, the kernel reads the size field from
userspace:

arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl() {
...
        if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
             __user *)argp)->size, sizeof(user_size))) {
...
}

If userspace leaves the struct uninitialized based on this documentation, t=
he
kernel will read random memory for size, leading to -EINVAL failures. Should
the documentation indicate this is an input/output parameter?


[Severity: Medium]
This isn't a bug introduced by this patch, but should the ioctl direction be
updated?

The IOCTL is currently defined as read-only:

include/uapi/linux/kvm.h:
#define KVM_PPC_GET_COMPAT_CAPS _IOR(KVMIO,  0xe4, struct kvm_ppc_compat_ca=
ps)

Since the kernel reads the size field from userspace, this violates
conventions and can cause issues with tracing tools. Should it be defined
with _IOWR?

> +:Returns: 0 on success, negative value on failure
> +
> +Errors include:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> +           written to userspace
> +  EINVAL   if the ``size`` field is smaller than the current structure
> +           size, or if the backend implementation fails to retrieve or
> +           map CPU compatibility capabilities

[Severity: High]
This isn't a bug introduced by this patch, but could the current size
validation break backwards compatibility?

The existing implementation in arch/powerpc/kvm/powerpc.c rejects requests =
if
the size is smaller than the host structure:

arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl() {
...
    if (user_size < sizeof(host_caps))
        goto out;
...
}

If struct kvm_ppc_compat_caps is ever extended, older userspace binaries
passing the old, smaller structure size will be unconditionally rejected.

> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-pseries platforms or when the
> +           required KVM operations are not available)
> +  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Medium]
Will the existing implementation return -ENOTTY as documented here?

Looking at kvmppc_get_compat_caps(), it returns -EINVAL on non-pseries
platforms:

arch/powerpc/kvm/book3s_hv.c:kvmppc_get_compat_caps() {
    int rc =3D -EINVAL;
    ...
    if (kvmhv_on_pseries()) { ... }
    return rc;
}

This could confuse userspace into thinking it passed an invalid argument si=
ze.
Should the documentation or the code be adjusted?

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
> +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	flags;			/* Reserved for future use */

[Severity: High]
This isn't a bug introduced by this patch, but is the reserved flags field
permanently unusable for future input?

The existing implementation skips copying and validating the flags field:

arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl() {
...
    if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
         __user *)argp)->size, sizeof(user_size))) {
...
}

Because the parameter is documented as (out) and the kernel ignores any
uninitialized data in flags, a future kernel will not be able to safely
repurpose flags for input. Should this validate that flags is zero?

> +	__u64	size;			/* Size of this structure */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +  };
> +
> +The ``compat_capabilities`` bit field describes the processor compatibil=
ity
> +modes supported by the host. For example, the following bits indicate su=
pport
> +for specific processor modes.
> +
> +::
> +
> +  KVM_PPC_COMPAT_CAP_POWER9  (bit 1): KVM guests can run in Power9 proce=
ssor mode
> +  KVM_PPC_COMPAT_CAP_POWER10 (bit 2): KVM guests can run in Power10 proc=
essor mode
> +  KVM_PPC_COMPAT_CAP_POWER11 (bit 3): KVM guests can run in Power11 proc=
essor mode

[Severity: High]
This isn't a bug introduced by this patch, but can the capability mapping
logic falsely restrict nested guests?

The switch statement lacks fallthrough annotations:

arch/powerpc/kvm/book3s_hv.c:kvmppc_map_compat_capabilities() {
    ...
    case PVR_ARCH_31_P11:
        *capabilities |=3D KVM_PPC_COMPAT_CAP_POWER11;
        break;
    ...
}

This causes the host to report a capability mask with only a single bit,
indicating it cannot run nested guests in older compatibility modes.


[Severity: High]
This is a pre-existing issue, but are we missing a reference count cleanup
here?

In the compatibility capabilities retrieval:

arch/powerpc/kvm/book3s_hv.c:kvmppc_get_compat_caps() {
    ...
    for_each_node_by_type(np, "cpu") {
        prop =3D of_get_property(np, "cpu-version", NULL);
        if (prop) {
            cpu_version =3D be32_to_cpup(prop);
            break;
        }
    }
    ...
}

The for_each_node_by_type macro takes a reference count on the device node.
Exiting the loop early via break requires manually dropping the reference v=
ia
of_node_put(np). Does this leak a reference on every ioctl call?

>  .. _kvm_run:
> =20
>  5. The kvm_run structure

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616123314.8272=
1-1-amachhiw@linux.ibm.com?part=3D4
