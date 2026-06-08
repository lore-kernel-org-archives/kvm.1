Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B73401A38
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932546; cv=none; b=C0IpYVWUPkCUkULPXRB3TgxdCoWgigiOEgnuQ4W6TVQ89AlNOGzdIStxw/aWU5Z2pv4x9z/V1wtPHgwBrAxCHfEwF/4lVWYC3lFK6ih2BIOxBl+MbM8d30UAdevjxwOJtwXKbcBiFFjgM03KAMDFyf2AdmjPYMd8YfB7lRAoPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932546; c=relaxed/simple;
	bh=0KrvFL3PsvxU7X44gXw91tvXcjO4gAJAf/UJfi3J80g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pw4ILcOLilerVvO/TNegfLcAWGtWJrxyk0KEQQtNtckCp084JoBAHl4cjYKsYzM9K1IzAXC15LfJYoL/yxWJZ0UNzPNso2M1QRa1HH5eXSNyPUDBrZjbpWFXgjzvA1Zzp8WTiHNb509QeTzzx53WiHRKooLeK/0MmI5uzmmQSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDBc8NXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDBc8NXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147701F00893;
	Mon,  8 Jun 2026 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932545;
	bh=XIgv0R2KVbwH+yWyYmu8SMLJS4Sn3QA5IhA+UtNuy0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDBc8NXyfUKp2US3lHSc9r8zY1ov5MCKuwptBRkmieY4PKwhYGYgq3x5MQ0JBt2t/
	 Q+X0rG/4w6tIt2EaPbinHFvLxXAfWNWJYNehjr88AslOLM/P3I4yANq2XGyUtDqabl
	 mXw9n5k1ShmwQu4aqeBMh0rK/7W9a6SVcBZ3/a7l5GPy1XL0FqLy/MfDhEV2EzW8VL
	 vGcx73OQPtKTtNwjPZ7YDOkHt5HJ5RuQ5qP6/03bSHMcLYT18CttHfufnM0k6gXW9Q
	 5vZBPNdyNARYlRIsd+aMYNDfhIs908mGO9nMhCUSc+PI6Bgh0lw+InRkCyjLe/u5Ts
	 9htKmUg6P8IFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/60] Documentation: kvm: introduce "VM plane" concept
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-9-joro@8bytes.org>
References: <20260608144252.351443-9-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:29:04 +0000
Message-Id: <20260608152905.147701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The documented API for VM planes directly contradicts the restri=
ctions claimed in the commit message.
- [Medium] Implicit 'last caller wins' global state in KVM_SET_GSI_ROUTING =
for planes prevents concurrent routing to multiple planes.
- [Low] Missing word 'with' in KVM_CREATE_VCPU plane constraints.
--

commit 1a4c73ae992840db0208f48635c236bd7636131e
Author: Paolo Bonzini <pbonzini@redhat.com>

Documentation: kvm: introduce "VM plane" concept

This commit introduces the concept of "VM planes" to represent virtual
privilege levels (like AMD VMPLs, Intel TDX, and Arm CCA planes). It
documents how these planes and their restricted subset of KVM APIs are
exposed to userspace through separate file descriptors.

> In fact for
> the vm file descriptor it is only three ioctls: KVM_CHECK_EXTENSION,
> KVM_SIGNAL_MSI, KVM_SET_MEMORY_ATTRIBUTES.  For vCPUs it is basically
> KVM_GET/SET_*.

[Severity: Medium]
Does the documentation in api.rst diverge from this commit message?

The commit message states that only three ioctls are supported on the VM
file descriptor for planes other than 0. However, the documentation
changes below mark both KVM_CREATE_VCPU and KVM_SET_GSI_ROUTING as
"vm ioctl (all planes)".

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 52bbbb553ce10..d90b4a406454c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
[ ... ]
> @@ -350,6 +367,8 @@ machines, the resulting vcpu fd can be memory mapped =
at page offset
>  KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map of the virtual
>  cpu's hardware control block.
> =20
> +VCPUs for non-zero planes can only be created if the VCPU the same index=
 has
> +already been created for plane zero.

[Severity: Low]
This isn't a bug, but should "the VCPU the same index has" be "the VCPU
with the same index has"?

[ ... ]
> @@ -1886,11 +1905,14 @@ The flags bitmap is defined as::
> =20
>  :Capability: KVM_CAP_IRQ_ROUTING
>  :Architectures: x86 s390 arm64
> -:Type: vm ioctl
> +:Type: vm ioctl (all planes)
>  :Parameters: struct kvm_irq_routing (in)
>  :Returns: 0 on success, -1 on error
> =20
>  Sets the GSI routing table entries, overwriting any previously set entri=
es.
> +Note that the kernel maintains only one GSI routing table for all planes=
. The
> +plane for which the GSI routing table was set last will receive all inte=
rrupts
> +signaled through GSI pins.

[Severity: Medium]
Does this implicit "last caller wins" global state prevent concurrent routi=
ng
to multiple planes?

Since KVM_SET_GSI_ROUTING replaces the entire routing table at once, it
appears a call on one plane's VM fd will hijack all GSI interrupts for that
plane, overwriting any previous plane's configuration. Is there a way to
concurrently route different GSIs to different planes under this UAPI
design?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D8
