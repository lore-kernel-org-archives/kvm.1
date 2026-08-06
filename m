Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6643446CB
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037385; cv=none; b=NvWlKiSmmdsbGcvlD5PtSObdRwi4HdtTCWkFFQXwo7Zq4P+wmybkJfiT80z8Ik+Y+Rb+Iqw66Upy7A87ivWkGjlYHVqqmDfKfou8NQY1KY5D6ca22SJTbnCXurQ6qmaZlEDm3FOI3TZLbrqYCykl5+uiCFT8q3kJXmc5CDk7U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037385; c=relaxed/simple;
	bh=bF9sJ/scfDSFKzGKCxaC/GppQpw6FVUjUn4CA2O+gtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dS7OXDQpnfi62BHi/gqWyYS05PoiWPf21eYsYhX+r5wipdvcXfkLga2kJzttjcEwWSQu9Wrt2+QuJ9iX5JgykjJ8mZsTs0FyNeitvDQF6ICO/SunhzkkxakOS7M5JwaC41IivOsaAftVAQkeQcks11aZ7TTDSBQhPPIcKjEoK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdRoYMnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdRoYMnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB6E1F000E9;
	Thu,  6 Aug 2026 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037383;
	bh=9NZkJzWyVmWjwCGlU/sfG4/G518IhOXLW3bl3TNugg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdRoYMnHdyRU+PBN0p02O897Ebiwcb8PFq+cpWHneEBigEEqJVY5UuAz/BEtuQHPX
	 bP3yKo4pFAkoHDYE0Y91QRGiAfiyfE2mM8jVbPmYICjzq7dA365YVfl8iFSC2T21TE
	 GXHJxd2mHqZAkCsRcbTY0K0+UrFmKbjXr3/eHZVENk5UdceLbAVydazMIdqTvBIeYm
	 dBWrcesY+HHoJ1qNC/W6ZAlVpzkGIFmVOY+4ui7OtnPo+Rihc1bbM9Dx78HVXqbIvV
	 U5+RHkOy7ZOpf/hQ23entCYGsXErcbs30OTTGN6RsH+fWBzgQDG46DhDUBhl/hsht4
	 W4BARpAob5KLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806170645.11892-5-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
 <20260806170645.11892-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:29:42 +0000
Message-Id: <20260806172943.4FB6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The KVM_PPC_GET_COMPAT_CAPS ioctl overwrites the user-provided siz=
e field with the kernel's struct size on a successful call, which creates a=
 buffer overflow vulnerability in user space if the struct is reused.
--

--- Patch [4]: [PATCH v7 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS io=
ctl ---
commit eb0bad8f47d2ffecff727c5b9aabfa2d83d1f6de
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

This commit adds documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl, which
exposes host processor compatibility modes for nested KVM guests on PowerPC
systems. The documentation describes the structure, error codes, and the
extensible versioning mechanism using the size field.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index e3003a241d5b0..22fedb0aa34b4 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
[ ... ]
> +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> +to support extensible versioning: if userspace passes a struct smaller
> +than the current kernel version (``size >=3D KVM_PPC_COMPAT_CAPS_SIZE_VE=
R0``),
> +the kernel zero-pads unknown trailing fields. If userspace passes a larg=
er
> +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> +allowing userspace to discover the kernel's struct size and retry.
> +``KVM_PPC_COMPAT_CAPS_SIZE_VER0`` (24) is a frozen constant marking the
> +size of the initial struct version.

[Severity: High]
Does the implementation of this extensible versioning in kvm_arch_vm_ioctl()
introduce a potential buffer overflow when userspace passes a smaller struc=
t?

Looking at the code in arch/powerpc/kvm/powerpc.c:kvm_arch_vm_ioctl():

		host_caps.size =3D sizeof(host_caps);
		r =3D copy_struct_to_user(argp, usize, &host_caps,
					sizeof(host_caps), NULL);

If a userspace process compiled with an older, smaller version of the struct
(e.g., 24 bytes) calls the ioctl on a newer kernel where the struct has gro=
wn
to 32 bytes, copy_struct_to_user() will copy up to the user-provided usize
(24 bytes).

Because the kernel explicitly executes host_caps.size =3D sizeof(host_caps)
before copying, the first 8 bytes of the user's buffer are overwritten with
the kernel's larger size (32).

If userspace reuses this struct for another ioctl call, it would unknowingly
pass usize =3D 32. The kernel would trust this size and write 32 bytes to t=
he
24-byte user buffer, causing an out-of-bounds write in userspace.

Should the kernel only write back its struct size when returning -E2BIG,
rather than on the successful path when the user's struct is smaller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806170645.1189=
2-1-amachhiw@linux.ibm.com?part=3D4
