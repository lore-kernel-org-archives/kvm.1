Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D13CF94B
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670701; cv=none; b=F6NBfu3VSaImzw6obAxvM4TL0E/EIH4TsZ3jMPR5IP1R8038ut0NEsSEP9wsFe/tH+9ZArfBbA4/UAt94oeKHy2C8H89tceKBJqjLbXBen9BlREvWZ3KgYmooP97vR5/P+Eg8RS3eRHL8aejunIF+fqqhwnZWNlexARNtfrcIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670701; c=relaxed/simple;
	bh=F8PNezLEgYJ7+kDCDrAr6I8ct4CFJXG+QrReBKHuVds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ip95UIVda/Ap3g3GrMXVpgz5RGowpf84Oq+o5bhlp7yS2okvxZGEyRSdaCpQCVGgjBjYq66nnbXWDjbHlbIDysCPHy47tYH/veAihCI+g74xlKkqBXz+V4ofXWCdk69jhzV9Qw+9L4YUaiUwfvuFSaD490QBLStlzAkuDOtpnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbO0DMBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbO0DMBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C938E1F00893;
	Fri,  5 Jun 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670698;
	bh=ZjCJ+DzH1OX8cWwoeEtcbTEKmY3DPBQFGOsi5RnZdSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbO0DMBoAYQhmOWFY2BR0axI0OnUOWP01hLst+Cne3MxWqXq9hM/Ww3sbKVrDovtJ
	 QP5/kMEZiAW6butnOjaHzAfCLIzY4CZLv9VDeoxW2iorurIqwcIqbn5X/vKi+FR0q/
	 9eLRsVHHyUwY1lsDKNsePT5AzyOe6xR+M6rOxmZNY5o/oWs0iU3nicM81W79N72pw0
	 QqMI16PqfMojuJgsHr+YFOViMSio0hEFZEAn4rClq8lSZ9Qt90qRkUxCKAgneuUmkj
	 NfnueRKcJGqPjG6iX7TFpHaiM0gaLA+ltsa+nBMOJZG9RY5nDv6DajhoT0ahrFMxZo
	 zXzXyY3Sl70vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] KVM: x86/xen: Enforce alignment of vcpu_info
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605143034.3603-7-dwmw2@infradead.org>
References: <20260605143034.3603-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:44:58 +0000
Message-Id: <20260605144458.C938E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Enforcing hypercall-time alignment checks inside KVM_XEN_VCPU_SET_=
ATTR breaks live migration for guests that registered a 4-byte aligned vcpu=
_info in 32-bit mode and subsequently switched to 64-bit mode.
--

commit cfaeaf400a74663fc7a7498659d4e3aee30b0640
Author: David Woodhouse <dwmw@amazon.co.uk>
Subject: KVM: x86/xen: Enforce alignment of vcpu_info registration

This commit enforces that the vcpu_info GPA and HVA are aligned to the size
of a xen_ulong_t based on the guest's bitness. It returns -ENXIO for
requests that do not meet the alignment requirements.

Link: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.o=
rg/

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 40b98e70c2dfe..9a6bb094a44f4 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -926,6 +926,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, str=
uct kvm_xen_vcpu_attr *data)
>  				break;
>  			}
> =20
> +			r =3D -ENXIO;
> +			if (!IS_ALIGNED(data->u.gpa,
> +					kvm_xen_has_64bit_shinfo(vcpu->kvm) ?
> +					sizeof(unsigned long) : sizeof(u32)))
> +				break;
> +

[Severity: High]
The commit message mentions that a guest can validly register a vcpu_info at
a 4-byte aligned address while in 32-bit mode and then switch to 64-bit mod=
e.

If a VM does this, what happens during live migration?

If the VMM restores the VM-wide LONG_MODE state before restoring the vCPU
state via kvm_xen_vcpu_set_attr(), kvm_xen_has_64bit_shinfo() will evaluate=
 to
true.=20

Could this cause KVM to incorrectly enforce 8-byte alignment and reject
the valid 4-byte aligned GPA with -ENXIO, breaking the migration?

>  			r =3D kvm_gpc_activate(&vcpu->arch.xen.vcpu_info_cache,
>  					     data->u.gpa, sizeof(struct vcpu_info));
>  		} else {
> @@ -935,6 +941,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, str=
uct kvm_xen_vcpu_attr *data)
>  				break;
>  			}
> =20
> +			r =3D -ENXIO;
> +			if (!IS_ALIGNED(data->u.hva,
> +					kvm_xen_has_64bit_shinfo(vcpu->kvm) ?
> +					sizeof(unsigned long) : sizeof(u32)))
> +				break;
> +

[Severity: High]
Does this HVA alignment check suffer from the same state restoration orderi=
ng
issue during live migration?

>  			r =3D kvm_gpc_activate_hva(&vcpu->arch.xen.vcpu_info_cache,
>  						 data->u.hva, sizeof(struct vcpu_info));
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605143034.3603=
-1-dwmw2@infradead.org?part=3D6
