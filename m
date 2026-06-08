Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB4353EF3
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957947; cv=none; b=WkJffD3aKGIsA8ywZqDNwIHSNbIRE0T5zsoFWs7sUWWF//90NfzFi7w+1VnZNEmGAqPXNnXIJMnVrUvyhhwrbTbO+2H3CKMSmpnDNfQuCCCsdgtey6FGO/thIRbx99iFuhuZG+r/0KJ9DOMcH1AvBlhSQfZvXCKFOq4cuEQiYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957947; c=relaxed/simple;
	bh=QknG9VD0Id2vFEVniTI1ZsfPRSwHgmKqmqeQgMHU6XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPt9YdR8S+VoiPSo3BqGjz6PPx7i/Imxg7dX/TmI1OmnGeM/f5VqyFXTpleeA7HZQszA0Pgw4X87e7XkJs6GXfJQL8HdJ6KRVDCnnbMa4eqhMqRekb55kEIMjrP2/q2+Sl4IQWRnBuomRcEMI1YAx9Pe+P91TCUdBmOcOOdprHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjI1caaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjI1caaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3801F00893;
	Mon,  8 Jun 2026 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780957946;
	bh=QhXRWl0RGOE6nm/8Fq0ZqIW5vXZORqN+KwIIWBhUhs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjI1caaMFamZ+6+Jh7OADBN3I4Np4fjGcFHuZ865Zt9dgRiMe6ZXGxot1aZwop2b7
	 IO9ziHmN7RvthTNcrdZRh2dO7iFj/1SBlHpEovKes5HeSZC08OqDisjiECLlXbF9IH
	 CWxFHKbMH20MMVWuoF6U+OMugMOU8UwN8N8CRdVhqDiB9//1y+csd4AMoEl9Kjh9la
	 k9nh5eLY2a1vn3LYOpx4D850sHVFAGNajRY9gXIA25Jr4aS0K8IVHLHP9rsK8ylmEr
	 HY2cwQm+SPQBvN4z6LBgbxzinAmnJ7IXpmKxLOPNA4yCBKtxnNDeZ7etXNRQsqBZ0f
	 eZfuIgwGB9FoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 54/60] kvm: x86: Restrict KVM planes support to
 KVM_IRQCHIP_SPLIT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-55-joro@8bytes.org>
References: <20260608144252.351443-55-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:32:25 +0000
Message-Id: <20260608223226.0D3801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Redundant and mathematically unreachable `kvm->has_planes` checks i=
n KVM ioctls.

Pre-existing issues:
- [Critical] Dangling pointer in `kvm->planes[id]` upon `anon_inode_getfile=
` failure leading to a Use-After-Free and Double Free.
--

commit b876ab94af3e1c6ebb40fe49338194bf465b5ec6
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: x86: Restrict KVM planes support to KVM_IRQCHIP_SPLIT

The code right now only supports plane-aware IOAPIC IRQ routing for
IRQ-chip in split mode. Enforce that restriction in the KVM x86 code.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c6910356b0619..0b9fa10594812 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -6833,7 +6837,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		if (cap->args[0] > KVM_MAX_IRQ_ROUTES)
>  			goto split_irqchip_unlock;
>  		r =3D -EEXIST;
> -		if (irqchip_in_kernel(kvm))
> +		if (irqchip_in_kernel(kvm) || kvm->has_planes)

[Severity: Low]
Is this kvm->has_planes check redundant? Since kvm->has_planes is only
set to true in kvm_vm_ioctl_create_plane() which requires
kvm_arch_irqchip_in_kernel(kvm) to already be true, wouldn't
irqchip_in_kernel(kvm) always evaluate to true if has_planes is set?

>  			goto split_irqchip_unlock;
>  		if (kvm->created_vcpus)
>  			goto split_irqchip_unlock;

[ ... ]

> @@ -7398,7 +7402,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>  			goto create_irqchip_unlock;
> =20
>  		r =3D -EINVAL;
> -		if (kvm->created_vcpus)
> +		if (kvm->created_vcpus || kvm->has_planes)

[Severity: Low]
Is the kvm->has_planes check unreachable here? A few lines earlier in
this same function (inside the KVM_CREATE_IRQCHIP case), there is an
early exit:

    if (irqchip_in_kernel(kvm))
        goto create_irqchip_unlock;

Because kvm->has_planes can only be set when the irqchip is in-kernel,
wouldn't we always exit at the first check before ever reaching this
second condition?

>  			goto create_irqchip_unlock;
> =20
>  		r =3D kvm_pic_init(kvm);

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 09fc74fe9d848..690858be8ef5b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -5497,6 +5501,7 @@ static int kvm_vm_ioctl_create_plane(struct kvm *kv=
m, unsigned id)
>  		goto put_kvm;
>  	}
> =20
> +	kvm->has_planes =3D true;

[Severity: Critical]
This is a pre-existing issue, but can the error path above this line leave
a dangling pointer in kvm->planes[id]?

If anon_inode_getfile() fails, the code jumps to put_kvm and calls
kvm_destroy_one_plane(plane). However, kvm_create_plane() already
saved the pointer into the array:

virt/kvm/kvm_main.c:kvm_create_plane() {
    ...
    kvm->planes[plane_level] =3D plane;
    ...
}

Since kvm->planes[id] is never cleared on this error path, will a
subsequent call to kvm_destroy_planes() during VM destruction trigger
a double-free or use-after-free on this dangling pointer?

>  	fd_install(fd, file);
>  	return fd;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D54
