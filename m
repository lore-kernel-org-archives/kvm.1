Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422643E4C94
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503151; cv=none; b=WOUXX4uGEvdvnjO823Gr27m53iudFntxgw6ylD8Gdh2dWQgmdKP/5fs1PiSfU+0DIRR947yjXwd4+5p82zEWmr7G/1W4wlBVtRvKq5I0fhB1GixPMLuNRrbltU1es6hxguF85FDHNUr9kQOn7giTbzKR1LVu6yK3NWWZH0/dccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503151; c=relaxed/simple;
	bh=UKMadZTeXR6X4PFdmPBXZMPWXBdJK5i4EZnvFcVBhDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCGwODth5zEFqfN9r/1VwBAzeOa+F+Tr0WSN9hE6G9N3EQIJknjULu6NW5xtxbVhgsjaNSty4rIt8ICmQbZ10PAD7sqPKRjLEuEO1YouBbG3ZizfxFGOcSeL9YrKLIe1dTSqW+QylAsy76k/FJUs+Zqzy/a433w4S8ZtA1YBmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+jVTUCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+jVTUCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA351F00893;
	Wed,  3 Jun 2026 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503146;
	bh=2QwzhxXZ9Zkv+Vw3Qz28T0aV4mSHehT3WGldMdHex3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+jVTUCUNS/9y/OXrEP87uo4HhK0Kq+GLD88yHWqGxRKqwquaDxwARJaMzky5V0jF
	 ElOv7oCsC65Y1c395SY/JB2zu2hg/kGqGMBtz+nynHCLGKZsC/gIjcSJpWmz4x/bNV
	 NUFDUt17wJA1mNZ6Y5Oh2H/W87GOoz31JQYUcf1n54LM9j8lJK56iH89r2bJXW6AZQ
	 NNk5M1lO/hKILrX22sYLBnbTMq+x8+5BnaUQ7+29lKqHU+TfXilDHYU+Kt8rbXk5Wd
	 Kkpnasnd3qFI+1ZCjXnshG5MIo+5t4qdNbX8A/QyDQdIJI48RviA9frgidFNNqQbKD
	 S86HriJAfhgPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] KVM: s390: Add capability to support 2G
 hugepages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603154758.234768-3-imbrenda@linux.ibm.com>
References: <20260603154758.234768-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:12:26 +0000
Message-Id: <20260603161226.8EA351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The new capability KVM_CAP_S390_HPAGE_2G is completely undocumented=
 in the KVM API documentation.
- [Low] The new KVM capability is missing from the tools/ UAPI header.

Pre-existing issues:
- [High] Userspace can bypass the mutual exclusivity between CMMA and hugep=
ages by enabling CMMA after hugepages have been enabled.
- [High] Userspace can bypass the architectural restriction that Protected =
VMs (PV) must use 4K pages by enabling hugepages after the VM is already in=
 protected mode.
--

commit 43482c954e0933d74bf56361955e125830f3a3fe
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Add capability to support 2G hugepages
   =20
This patch adds the KVM_CAP_S390_HPAGE_2G capability to allow 2G hugepages
to back the guest. It enables the GMAP_FLAG_ALLOW_HPAGE_2G flag for the=20
guest gmap and propagates it appropriately.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 801a622691b6a..616d1db7c0d9e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -901,6 +906,27 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
>  		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE %s",
>  			 r ? "(not available)" : "(success)");
>  		break;
> +	case KVM_CAP_S390_HPAGE_2G:
> +		mutex_lock(&kvm->lock);
> +		if (kvm->created_vcpus) {
> +			r =3D -EBUSY;
> +		} else if (!hpage_2g || kvm->arch.use_cmma || kvm_is_ucontrol(kvm)) {

[Severity: High]
This is a pre-existing issue, but while this capability enablement checks=20
if VCPUs are created, could userspace bypass the Protected VM restriction
by enabling PV first and then enabling hugepages before creating VCPUs?

In kvm_s390_pv_init_vm(), the flags are cleared:

    clear_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
    clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);

Since !kvm_s390_pv_is_protected(kvm) is not checked during the capability=20
enablement, does this allow KVM to map unsupported 1M/2G hugepages into=20
a Protected VM's address space?

[Severity: High]
This is also a pre-existing issue, but while the hugepage enablement
checks kvm->arch.use_cmma to enforce mutual exclusivity, does the CMMA
enablement handler lack the reciprocal check?

In kvm_s390_set_mem_control():

    kvm->arch.use_cmma =3D 1;
    /* Not compatible with cmma. */
    kvm->arch.use_pfmfi =3D 0;
    ret =3D 0;

Could userspace enable hugepages first, and then enable CMMA, causing
CMMA dirty tracking operations to silently skip huge pages since they
are not handled by the dat_walk_ops .pte_entry?

> +			r =3D -EINVAL;
> +		} else {
> +			r =3D 0;
> +			set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
[ ... ]
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf3..419011097fa8e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_S390_HPAGE_2G 249

[Severity: Low]
Should this new capability be documented in Documentation/virt/kvm/api.rst
to explain its usage, side effects, and mutual exclusivity with CMMA and=20
ucontrol VMs?

[Severity: Low]
Does this capability addition also need to be synchronized to=20
tools/include/uapi/linux/kvm.h so that userspace tools and selftests
compiled from the kernel tree have the definition available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603154758.2347=
68-1-imbrenda@linux.ibm.com?part=3D2
