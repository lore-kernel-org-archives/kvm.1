Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201593921C8
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868040; cv=none; b=KgCdr+JnjTzBKeMimuq2eErQn3Oj1UIYcQ7gWI/ysj8XqXk49KQSbKqS0GhW/iSxKDtzzbWCqqEyczVMtWDH5fvxOyWPXnNrxyOR7H1tdVwId8X0PrR4iJPPQrIbEeSlcB2O5uCZYzQsDCyJYwBU7sGRarLT/CPJDoHWTJdgiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868040; c=relaxed/simple;
	bh=J724T6pliVeIZWHUsw8ax96JvsE7np7/EWWGi9Q1kkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9AdF7b/XiR84YOHZsTOjxsZyKKnTcDqkC2RzO1o6cz7MHQDO0jZXv3etXI4lnmTnjWxyW93S+RKT6pPfUGoxGMJCrHF9MR7P9UJQWu6irGTzCxq9+YnqoWWZ1Mo6hjHCCge2PJ0kuHhc/LyvdGZQdVbIyIHbKh/ghex4QZINfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7auca2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7auca2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3B01F00A3A;
	Tue,  4 Aug 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868039;
	bh=iRNuQT2eOwMIYCfLcUUjZGQZUcqLSQhAiqk6C2TOIjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M7auca2RdJZKxOT4dxG8wRvRB8421K/3yY6D5GYS8DyZigPLg86c/rMUV94W0n8HM
	 CNXI3wcs+MfyaDxtkIgGGQ4YE/NP7BMO/AFDWXJJuQvZrwzM6i/tb10AiSSaOg5Rxn
	 0JppR4bZQby7h4RbS2H7IXMNSo+WPB4/NPr6gS63yIrG/cj/9er/8+cmq0Rf2boVpW
	 TRD4RtiXcFEqgTZrFu6oIxxi/Tlnq4fvJNes5BPibRGZvZh//Oa4sz+0uu3KR4vBg9
	 ChBglT+QAjspY2hmBh5knVHSd3U8f63Sikk4Hh+jZk0qb3/NR5FwaBW4t6TII/Ojcn
	 o58hVi3y8jiWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804180705.59160-5-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:27:18 +0000
Message-Id: <20260804182718.DB3B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional rejection of larger structs breaks the forward compa=
tibility mechanism of copy_struct_from_user().
- [High] Overwriting the userspace size field with the kernel's struct size=
 creates dangerous ambiguities on success.
--

--- Patch [4]: [PATCH v6 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS io=
ctl ---
commit 5d4e2edcf1688edc6d21e5f2463ef8b58bd3d0a7
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
   =20
Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation. The documentation covers error code descriptions including
E2BIG for forward compatibility and the extensible size-based versioning
contract.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index e3003a241d5b0..22fedb0aa34b4 100644
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
> +:Parameters: struct kvm_ppc_compat_caps (in/out)
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

[Severity: High]
Does explicitly rejecting a larger struct size with -E2BIG break the standa=
rd
forward compatibility mechanism of copy_struct_from_user()?

Extensible struct UAPIs are designed to allow newer userspace to run seamle=
ssly
on older kernels as long as new fields are zeroed.=20

Looking at arch/powerpc/kvm/powerpc.c in kvm_arch_vm_ioctl(), the code
short-circuits the native trailing-zero check in copy_struct_from_user():

		if (usize > sizeof(host_caps)) {
			host_caps.size =3D sizeof(host_caps);
			r =3D -EFAULT;
			if (put_user(host_caps.size, (__u64 __user *)argp))
				goto out;
			r =3D -E2BIG;
			goto out;
		}

This forces userspace to implement fallback retry loops instead of relying =
on
the kernel's native UAPI extensibility.

[ ... ]

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
> +the kernel zero-pads unknown trailing fields. If userspace passes a larg=
er
> +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> +allowing userspace to discover the kernel's struct size and retry.

[Severity: High]
Can overwriting the userspace size field with the kernel's struct size crea=
te
dangerous ambiguities on success?

If userspace passes a smaller struct (e.g., 24 bytes) and the kernel uses a
larger struct (e.g., 32 bytes), the kernel updates host_caps.size to 32 and
copies 24 bytes back to userspace.

Looking at arch/powerpc/kvm/powerpc.c in kvm_arch_vm_ioctl():

		host_caps.size =3D sizeof(host_caps);
		r =3D copy_struct_to_user(argp, usize, &host_caps,
					sizeof(host_caps), NULL);

Userspace would receive a success code (0) but its size field is now 32. Th=
is
falsely indicates to userspace that the kernel provided 32 bytes of valid d=
ata,
which can lead to out-of-bounds reads if userspace trusts the returned size
field to determine valid data bounds within its buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804180705.5916=
0-1-amachhiw@linux.ibm.com?part=3D4
