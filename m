Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0235294E
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124239; cv=none; b=UiVjAQ+BiteZ34MmB/RbIv2M4Ve5qedJfh1o0hjquSyJNoM76geqYEHS6s/TzCxBLBTRTS0/v5Wq7PCHGq4MeKuu1zDRO/rwalv7s2MgzGqNWcrziPLN6MJmeDmUnjk3Itj+kTp8WLx9lW/ImJsgehqTlj8nqwk+7YdItn1005U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124239; c=relaxed/simple;
	bh=ULQeaLufQgxqkSz7ewcdaZni9MJ4SxCe2ZOSZs1HtxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZpi08UboARF/+8d9w7saScFmz7H1juoF0x1QPDKZvDsT7hoy/OcGXp9t5EPVbQei+0dfjhXa/ggcAVmCUqUOsOrfhwIIfXYYeLmomCCyzLq4uuj8qGTu+C4jqesGqzMgvnIHboevOIzN3aHr88OFhhQYlwsnVjLvWAb2ozA+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8zuExwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8zuExwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030851F000E9;
	Fri,  7 Aug 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786124236;
	bh=08ERzwSUH+k0qx11lAumPX8b4Nici6UHgNBxXWkEPt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8zuExwJaZDcPWuBQtkRJxYpR4xUUkINd0sJHZrMr9F53LAd6t/XyqxnoB7Xhn829
	 dlqE14PEsawSB3oaGhG/dDp1CngL7I7BDH78U6kyO70lImPZuMY8JKLuHvyMNovWTO
	 rP+Z2iQBehjHTmrnF9SPjY+NiOiSH/RPY0ciYO1LFP9YqTE6AELnpAhGx3FZb5ZLu3
	 hJs0WDOKx432m5mgT0BTSjNh2sSxJMcRem97ky0sWwu+mYi5+cAoJ5G6+QE6gxKhs7
	 Wvb1vuIW0K77zC+/BWPmbqgP9j/p6gXZn/p7zOEB3797ZkLgfZyfsurg+r8+Mp4pqY
	 TGD6jwYS8/dlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807172433.82045-5-amachhiw@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
 <20260807172433.82045-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 17:37:15 +0000
Message-Id: <20260807173716.030851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The documentation inaccurately describes how the extensible stru=
ct versioning handles trailing fields and truncation.

Pre-existing issues:
- [High] A userspace-reachable WARN_ON_ONCE in kvmppc_get_compat_caps allow=
s unprivileged users to panic the host if panic_on_warn is set.
--

--- Patch [4]: [PATCH v8 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS io=
ctl ---
commit 991bf5faa645caad474f6369b275de7617351fd0
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
documentation. The ioctl exposes host processor compatibility modes support=
ed
for nested KVM guests on PowerPC systems. The documentation covers error
code descriptions including E2BIG for forward compatibility.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index e3003a241d5b0..e656d117cd0b1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,95 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
> =20
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------

[Severity: High]
This is a pre-existing issue, but does this ioctl handler allow unprivileged
users to panic the host?

Looking at kvmppc_get_compat_caps() in arch/powerpc/kvm/book3s_hv.c:

arch/powerpc/kvm/book3s_hv.c:kvmppc_get_compat_caps() {
	if (kvmhv_on_pseries()) {
		if (kvmhv_is_nestedv2()) {
			WARN_ON_ONCE(!nested_capabilities);
			capabilities =3D nested_capabilities;
			[ ... ]
}

An unprivileged user with access to /dev/kvm can open a VM file descriptor
and call the KVM_PPC_GET_COMPAT_CAPS ioctl. If the system is a nested guest
(kvmhv_is_nestedv2() is true) but the parent hypervisor advertised no
capabilities (nested_capabilities is 0), the ioctl handler directly triggers
a WARN_ON_ONCE(!nested_capabilities).

This can occur naturally if plpar_guest_set_capabilities(0, 0) succeeds
during kvmhv_nested_init(). This directly violates the KVM subsystem
guidelines which explicitly forbid userspace-reachable WARN_ON assertions,
as it can cause a host kernel panic (Denial of Service) if panic_on_warn is
set.

[ ... ]

> +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> +to support extensible versioning across three cases:
> +
> +- If ``size`` is smaller than the kernel's struct size (old userspace,
> +  new kernel), the kernel zero-pads the unknown trailing fields before
> +  returning, and writes back ``size`` unchanged so userspace knows how
> +  many bytes were filled.

[Severity: Medium]
Does this documentation accurately reflect the UAPI contract for struct pad=
ding
and truncation on the return path?

The documentation incorrectly states that if the userspace struct is smalle=
r,
the kernel "zero-pads the unknown trailing fields before returning". This
misleadingly implies it pads the userspace buffer (which would be a buffer
overflow). In reality, the kernel strictly truncates trailing fields on out=
put
to userspace using copy_struct_to_user().

Additionally, it fails to document that when userspace provides a larger
struct with zeroed trailing bytes, the kernel actively mutates the userspace
'size' field on success (via host_caps.size =3D min_t(...)) to reflect the
kernel's smaller struct size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807172433.8204=
5-1-amachhiw@linux.ibm.com?part=3D4
