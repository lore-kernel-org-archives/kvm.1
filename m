Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37E45D5EF
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016112; cv=none; b=p981Xw5PI0eK4Nz4feLZovXBlF6H44FxJpabP1yFt4tMB4zZ77HbmESYkdHdO9Kaw+FSdxxZrFsIpW3b54Fl+2uZipwNB7nfPcQ5fitJEz+3cQUUETIRE8o0gHC0CQBrjgEjTKTTN/u1nI2QXIfNuQ91705r2dWY0kZkeggLB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016112; c=relaxed/simple;
	bh=v3WfVg4M0RY3V1Kdu8OslCpRhOwwDxOqCj3ROEaqDoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HA13CN2dnY4aoan9T9uWTOveE1dQR0GRs6ChtNzQz54xwPT4J2KMDVXVZ23xHMhNnXMcwkeursPMLA/X5BjHrdroZpJhY8/JkUujQ7q4UUr8FobJzGEc065GJRgidGXKgiIcUeQ/vuHzJKeOIzfaf27u3d6sONmZeRvgAcqlcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIew12vT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIew12vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F28C1F000E9;
	Thu,  6 Aug 2026 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016101;
	bh=q38gUW7Tkdq+B4MYqELGBvDzzGexRChLq/nkwqSlEYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIew12vT/dHqYc43jZWq56scfk8fCLI69x/0eke1KBB+gSpDbMESD4iUKP50Mkn8i
	 SMKrQWmad4NBZFw6TV3CJzKvkXSbhuRUjb7RkYnd4sxNeiBre3PIKGVHv59tLIaxT+
	 prTCW7lvCmhsVtF1Glnj97q8T+kZJEY4ozrx0tkyV2dApFcXzdYw785077qq7tqyN7
	 WRCQUm/zO3bgtHEjOxmlAj6TsCrW4sTGcTw47o0Sjf6kKKAPLl8NDDY/eb+dv7HfpQ
	 EdyPFr3UG/aZaA6o8J/9QWDvacDsxpGiobcGyTGMunzpDcEgFCJiLDsTIgrvbTYFYI
	 OFoCe7wQGILXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_EXIT
 when !kvm_caps.has_bus_lock_exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806111923.1990562-3-xiaoyao.li@intel.com>
References: <20260806111923.1990562-1-xiaoyao.li@intel.com>
 <20260806111923.1990562-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:35:00 +0000
Message-Id: <20260806113501.3F28C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying the VM-wide state `kvm->arch.bus_lock_detection_enabled`=
 lacks protection from `kvm->lock` and does not verify that no vCPUs have b=
een created yet.
--

--- Patch [2]: [PATCH 2/3] KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_E=
XIT when !kvm_caps.has_bus_lock_exit ---
commit e0edfcdc943c7835281cad8477ff3399dfe81a05
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_EXIT when !kvm_caps.has_bus_=
lock_exit

This commit returns -EINVAL to reject enabling KVM_CAP_X86_BUS_LOCK_EXIT
or KVM_BUS_LOCK_DETECTION_OFF from userspace when kvm_caps.has_bus_lock_exit
is false. It aims to keep the API behavior consistent when KVM does not
support bus lock exit.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index afcac1042947a..91895a3d6f857 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6835,8 +6835,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		    (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT))
>  			break;
> =20
> -		if (kvm_caps.has_bus_lock_exit &&
> -		    cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
> +		if (!kvm_caps.has_bus_lock_exit)
> +			break;
> +
> +		if (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
>  			kvm->arch.bus_lock_detection_enabled =3D true;

[Severity: High]
This is a pre-existing issue, but does setting the VM-wide flag
bus_lock_detection_enabled here in kvm_vm_ioctl_enable_cap() require
kvm->lock protection and a check for !kvm->created_vcpus?

If userspace calls KVM_ENABLE_CAP for KVM_CAP_X86_BUS_LOCK_EXIT concurrently
with or after KVM_CREATE_VCPU, existing vCPUs might miss the update. This
could lead to an inconsistent state where some vCPUs mitigate bus lock DoS
and others do not, leaving the host vulnerable.

>  		r =3D 0;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806111923.1990=
562-1-xiaoyao.li@intel.com?part=3D2
