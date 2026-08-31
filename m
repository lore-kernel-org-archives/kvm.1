Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351243C3F56
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160857; cv=none; b=IQUMt1vO0Z5IpslC7kWLEG+C+amgaM8juJsvqYhjbm6EpU08QJSsAQ1Ik5ophcAy8RI7js6T24edhqcTE3Q8dymVsc/1/BMvlZTaeq9vfWUWFDLwHA6cjgfqiLk0IQhfnECpW3wGWW+6Wslirz6MGNnp4xTkwnWSi9zik7Sp9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160857; c=relaxed/simple;
	bh=C0CyRJh+50tKIVWqMqn1Eh917n45FpqQoree5Ilp6o4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhMSJmRqmLNR+idHORRekbzlxM5ja4dLnLxJpqtdQcyNT1krq3ml7VFwiEREb5ubc+tBmCJ/3uLN7e5oZI2WpP2ni+NwlYBtBmdlehfJo7aT+byEThjZt4aLmIU+YEiGmEgzr4D6HakewdN9CCxdvhF0HcoJfLrmaIdEiXhl214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaLVrHzJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaLVrHzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0551F000E9;
	Mon, 31 Aug 2026 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160855;
	bh=sFQ3+2kshAnr3KZHolO/iS+S+F9KoGoQKXQ2KPndqLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oaLVrHzJexCAtk/ZkJq/dDvaVVxAH7GmpI9iIuFo5UOVqN33N7owTLZHq/RfG3AiL
	 oyishWC9fYt6CE1EZg8sIbwjeiaW7J4MLZqss2bUb6f6aiDs1meDbcsdy5HXjXsBMg
	 V4eDjXlb1vasvicLwy1xQ8RbtXfI4Ser2KBbnnus7geMDS2Xz0HaSw8umkE57O5Uiz
	 /Ic5pEZeKBzz+zZoJdqbYF1kkJQtxir4CdBaW8+6k+mW9gpEIoH2mgP4I/wC21HPod
	 XumjuoetPh/xm4qiDz4dzakSH/BNzUukMVKJned9/tHMxXh5qj4KQXF8DN7OemLjKY
	 prU+rFIAk2hGA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API
 for confidential guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Lindgren" <tony.lindgren@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831071304.762939-2-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:20:55 +0000
Message-Id: <20260831072055.AD0551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added documentation for the KVM live migration API contai=
ns architectural contradictions, backwards numbering, self-referencing link=
s, and typographical errors.
--

commit 3a6c0c9c47ef3277e964b009e8dd06e7aeab932d
Author: Tony Lindgren <tony.lindgren@linux.intel.com>

Documentation: KVM: Add live migration API for confidential guests

For CoCo VMs, the guest memory and vCPU states are not accessible to the
userspace or KVM for live migration. The memory and vCPU states need to be
extracted into encrypted blobs on the source, and decrypted on the
destination. Before live migration, an encryption key needs to be
negotiated between the source and destination.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index a5f9ee92f43e8..9d546d288af5f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
[ ... ]
> +The transfer buffer size is vendor specific.
> +
> +For the transfer buffer, seeo :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.

[Severity: Low]
Is this "seeo" a typo for "see"?

> +
> +For memory import, see also :ref:`KVM_IMPORT_MEMORY <KVM_IMPORT_MEMORY>`.
> +
> +
> +.. _KVM_IMPORT_MEMORY:
> +
> +4.147 KVM_IMPORT_MEMORY
> +-----------------------
[ ... ]
> +The transfer buffer size is vendor specific.
> +
> +For kvm_memory_transfer, see :ref:`KVM_EXPORT_MEMORY <KVM_EXPORT_MEMORY>=
`.
> +
> +For the transfer buffer, seeo :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.

[Severity: Low]
Is there another "seeo" typo here?

> +
> +.. _KVM_EXPORT_VCPU:
> +
> +4.149 KVM_EXPORT_VCPU
> +---------------------
> +:Capability: KVM_CAP_LIVE_MIGRATION
> +:Architectures: arm64, x86

[Severity: Low]
Is it intentional that KVM_EXPORT_VCPU is numbered 4.149 before
KVM_IMPORT_VCPU which is numbered 4.148?

Also, KVM_EXPORT_VCPU lists arm64 as a supported architecture, but relies on
KVM_CAP_LIVE_MIGRATION which is documented as x86 only below. Should arm64 =
be
removed here, or added to the capability documentation?

> +:Type: vcpu ioctl
> +:Parameters: struct kvm_vcpu_transfer (in/out)
> +:Returns: 0 on success, < 0 on error
[ ... ]
> +.. _KVM_IMPORT_VCPU:
> +
> +4.148 KVM_IMPORT_VCPU
> +---------------------
> +
> +:Capability: KVM_CAP_LIVE_MIGRATION
> +:Architectures: arm64, x86
> +:Type: vcpu ioctl
> +:Parameters: struct kvm_vcpu_transfer (in/out)
> +:Returns: 0 on success, < 0 on error
> +
> +Allows userspace to request the host to import a VCPU state from a users=
pace
> +buffer.
> +
> +The VCPU state may not be directly accessible to KVM because of encrypti=
on. For
> +confidential computing, the VCPU state is encrypted and only accessible =
to the
> +guest.
> +
> +For vcpu_transfer and vCPU import, see :ref:`KVM_IMPORT_VCPU <KVM_IMPORT=
_VCPU>`.

[Severity: Low]
Does this circular reference point to itself? Should this point to
KVM_EXPORT_VCPU instead to help the reader find the struct kvm_vcpu_transfer
definition?

> +
> +For the transfer buffer, see also :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD=
>`.
> +
>  .. _kvm_run:
> =20
>  5. The kvm_run structure
> @@ -9493,6 +9687,17 @@ take care to differentiate between these cases.
>  The presence of this capability indicates that the nested KVM guest can
>  start in ESA mode.
> =20
> +8.48 KVM_CAP_LIVE_MIGRATION
> +---------------------------
> +
> +:Architectures: x86
> +:Target: VM
> +:Parameters: None

[Severity: Low]
The KVM_CAP_LIVE_MIGRATION capability is documented here as x86 only, but
KVM_EXPORT_VCPU and KVM_IMPORT_VCPU state they are for arm64 and x86. Is
this capability intended to support arm64 as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831071304.7629=
39-1-tony.lindgren@linux.intel.com?part=3D1
