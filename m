Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F538D
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161035; cv=none; b=VqalOxK2IQ8ZhMJ4f2vrAKeE94YJQFbk5n8ge8fGLZ+2DA5j/B5oa3qnMwIQ8sBwQuJ8ClHkdRoAX1u72APKGVnqgTG7b+XmBSFJcLpZER3dHpux/hQ+6NHmuqfkDHiDzIpC42G4fceVLiVE3OlR3/69jdqilFl3CYFQxOg0IXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161035; c=relaxed/simple;
	bh=cne46p9KNiy2fP7pRH1IGsvhQTB8YZdA2DoHBluxkMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F+Du5eyrdlQGKeahF3UabkKtZdvDngR4WOxNi/LdeXnKxeFZz5IxwEbUkANppewBzbAOZSxg5DkWL7XrwIqYX9IW8++6mrtijqi2EWl9mlA9LfXcTScnOK6ORF/htoFQSHXdDTSFuyeUfeOtxgElRN6yRcP1KsSNoScEvBTGwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOQlLs1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOQlLs1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FED1F000E9;
	Mon, 31 Aug 2026 07:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161034;
	bh=knz5Iue3YPw7APzCd2YOA8GHwHJq4HssDFELReMN/es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOQlLs1um9RyjlGMzhZLjZJ+6dNj7/A/CtXTIhjrRVFfwxbnimH4e92mHAme2jJmx
	 4h5UkvjtrsdgSFTGwgnfsdUDHJMr12Wfo73CyqcJy6+SWvWshqNCZiXD9HTwNvADod
	 v/3uQ7e9mslSWuPi7wI0pPR8JL+/nBL1eE2QJ0VG8UhEElHzxoAm+keTXqWJzGkQ+/
	 9xGtwpiSIwb0oKivCRUNvjWtLAxprg5BtK/IWRr4sE7mT3emuJKPWLKFzcvjilBDTD
	 9O/8xw+eDAU15AMXoEMdMmwku69A580+9PcW6Z7Z3wiF58buznSGm3QtFvDITyrnLh
	 GHkKO7ydNFqWg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: Add optional KVM_EXPORT_VCPU and
 KVM_IMPORT_VCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Lindgren" <tony.lindgren@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831071304.762939-5-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-5-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:23:53 +0000
Message-Id: <20260831072353.D1FED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation of the flags field in UAPI struct kvm_vcpu_tran=
sfer breaks forward compatibility.
--

commit 4d7dccde0750ca7fd34158829ad4120d967ac2c3
Author: Tony Lindgren <tony.lindgren@linux.intel.com>

KVM: x86: Add optional KVM_EXPORT_VCPU and KVM_IMPORT_VCPU

This commit adds support to export and import a VCPU for cases where the
VCPU state is only accessible to the guest. It introduces the new
KVM_EXPORT_VCPU and KVM_IMPORT_VCPU ioctls, along with the required
kvm_vcpu_transfer structure.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8a99c665008a3..e8385326894b1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -6189,6 +6189,38 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
> =20
> +static int kvm_vcpu_ioctl_transfer_vcpu(struct kvm_vcpu *vcpu, bool impo=
rt,
> +					void __user *argp)
> +{
> +	struct kvm_vcpu_transfer vcpu_state;
> +	struct kvm *kvm =3D vcpu->kvm;
> +	int r;

[ ... ]

> +	if (copy_from_user(&vcpu_state, argp, sizeof(vcpu_state)))
> +		return -EFAULT;
> +
> +	if (vcpu_state.reserved || vcpu_state.buf.reserved)
> +		return -EINVAL;

[Severity: High]
Should we also validate the flags field here to ensure forward compatibilit=
y?

The new kvm_vcpu_transfer structure introduces a flags field, but this
validation step only explicitly rejects non-zero reserved fields.

If the kernel silently ignores non-zero flags, userspace might
inadvertently pass uninitialized or arbitrary values without receiving
an error. If KVM later assigns meaning to these flags, old userspace
programs that have been unknowingly passing garbage could unexpectedly
trigger new behaviors or break.

Would it be appropriate to require that vcpu_state.flags is zero for now?

> +
> +	if (import)
> +		r =3D kvm_x86_call(import_vcpu)(vcpu, &vcpu_state);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831071304.7629=
39-1-tony.lindgren@linux.intel.com?part=3D4
