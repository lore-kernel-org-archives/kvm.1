Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E10356775
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472564; cv=none; b=Tk/yiKzvYMDk7Oz9mJhCrRAGit0lvmqd/PWyqGWyNQr8opbHaGyGhiXE30phoOgMM+1kUKLYpqn9bgJ7ryEoUvBrrfRIpqaMKEIIv1BpT2Sc+s86M7hohJi4OCNTKTdOfwLCJbO3/GZWNlWuGJR67fW5U9qf3+y6ziE8odm03cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472564; c=relaxed/simple;
	bh=ySkm+c/RnCUhdOak3/cI4t14CyRz1vctOucMO4Ihu/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iTgsNIrH3Q96UznMW8CuqzT4nO8YHRfQQht6rU1oBpOgrb+QNvEJx9te6MfeKGIjvdY9cqqsBlGKg8EUu+wNbaCISqysZPHJ+dFBW0VCIgIhuon9wv0xJbGu5VBx9rzxZPNGOe35cGQQEHyElSbrmZSsbTBXWBha1y89RTn9a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpWQvwp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpWQvwp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9064B1F000E9;
	Fri, 22 May 2026 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472562;
	bh=gPs7eF+SdYhtsrJ2Zsac6sGwzNwDx3dLIY5J1Hl3YS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpWQvwp6MjQlC6gE6xb3bEpS7s7sprYXo2A0/2b0goUjchOCTUD4ohPLDkwgC0nA0
	 8bkqPNGbVkGywOPAL16ce2mvOLSod2uvv48I+nLhIKMsGqwg/k9r/gpkgX8kYORnsF
	 ma0XbmCkPIOQDFFI9jMD2GxSN23RyO/BwQRGPwpbcD1uw99Vg6rzXorUtzTwbr6NPj
	 BUjcQC+VFVFU4Kts1GohSV0JqxftHVBz51KGPmFEqMSH5z+yrF5MtaClSxUROzC+k3
	 sXQLHBgglN/Um1GXvFRlZVOthm/m/YiXNFxfq4Z8u0K1eH2Bc8+pEBwXiqLI4dYNu2
	 dCawEubTLSgnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522152744.55251-6-amachhiw@linux.ibm.com>
References: <20260522152744.55251-6-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:56:02 +0000
Message-Id: <20260522175602.9064B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Macros referenced in the user-facing API documentation are missi=
ng from UAPI headers.
- [Medium] The documentation uses ambiguous and non-standard bit numbering =
(MSB-0), likely causing userspace to check the wrong bits.
- [Low] The new documentation section breaks the existing `.. _kvm_run:` re=
StructuredText anchor target.
- [Low] The documented return values omit multiple valid error codes native=
ly returned by the ioctl (-EINVAL, -ENOTTY).

Pre-existing issues:
- [High] kvmppc_map_compat_capabilities under-reports supported compatibili=
ty modes on APIv1 platforms.
--

commit 72ed781761ff2f69a81eff7405946f0c54c590e0
Author: Amit Machhiwal <amachhiw@linux.ibm.com>
KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl

This commit adds documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the
KVM API documentation. It describes the compatibility modes supported for
nested KVM guests on PowerPC systems.

Link: https://lore.kernel.org/oe-kbuild-all/202605140717.W1StD3Ke-lkp@intel=
.com/

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 52bbbb553ce10..d11e054e6665c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
> =20
>  .. _kvm_run:
> =20
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------

[Severity: Low]
Does inserting the new section here break the rST anchor target?

By placing the new section directly after the .. _kvm_run: anchor, cross
references to the kvm_run anchor throughout the documentation will jump
to this new 4.145 section instead of section 5.

> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)
> +:Returns:
> +	0 on successful completion,
> +	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written

[Severity: Low]
Should this documentation also include -EINVAL and -ENOTTY?

The kernel implementation explicitly returns -ENOTTY if the underlying
architecture callback is unsupported, and returns -EINVAL if capabilities
cannot be mapped or the CPU version cannot be parsed.

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

[Severity: High]
This isn't a bug introduced by this patch, but does the APIv1 implementation
of kvmppc_map_compat_capabilities under-report supported compatibility mode=
s?

The underlying implementation for APIv1 nested KVM uses a switch statement
with breaks that only sets a single bit matching the host's native generati=
on.

Because backward compatibility modes are missed, QEMU might erroneously
conclude the host does not support older guests.

> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	flags;			/* Reserved for future use */
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
> +  H_GUEST_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mo=
de
> +  H_GUEST_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor m=
ode
> +  H_GUEST_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor m=
ode

[Severity: Medium]
Are these macros exported to include/uapi/linux/kvm.h?

The documentation directs userspace to interpret the bitmask using macros
like H_GUEST_CAP_POWER9. However, these are defined exclusively in the
kernel-internal header arch/powerpc/include/asm/hvcall.h. This forces
userspace to hardcode internal kernel values.

[Severity: Medium]
Will the bit numbering here mislead userspace developers?

The documentation specifies capabilities as (bit 1), (bit 2), etc., which
implies standard LSB-0 numbering. However, the KVM implementation uses IBM's
MSB-0 bit numbering, where H_GUEST_CAP_POWER9 is defined as (1UL << (63 - 1=
)).

>  5. The kvm_run structure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522152744.5525=
1-1-amachhiw@linux.ibm.com?part=3D5
