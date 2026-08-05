Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FE392806
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909998; cv=none; b=r/jD4MKAKYBSPqIvvFwX/n0V8+07uVFKv2ML3UiKw5LPE9cmO7miONMbGlOIHpQl7ShUpKcTbcNcq1kZW3q/GTOli5ZrRa2rIwr297JqTbk7OYsYEot2ztwvLV573A2pxIo5GqjD/+Q6p2yhyixZaOpStzvd88YgGmCCRdq6RiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909998; c=relaxed/simple;
	bh=3GXcnlNHdbzVM0skL2v+PYc4ksRDG5RrhUjeJc9pbRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VRkLxEXdgnIbagL/15/kIkRYWB4HIThJqAVy8542Id0tLdl2yRcGy6sViiuEVgfooeenOJdh96GhqGCwO3R71cf18xZxI071PPP8YN19TfLFbRJBV2LpO46HmV8vWRsTIQZJnviLQ/N7TBcpcvkt+vdAyyq+tV68RXn7e8MXZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsOspUUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsOspUUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB11F000E9;
	Wed,  5 Aug 2026 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785909996;
	bh=hzLGyHPZOa8JigCsSos3tG4HiHa3iDxTVfElWwUPBbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XsOspUUvB2fRzJHgYy6oBpUyEpny3Loylhrq12YihIu4fc0a51eGhTNICG3r4Fx2+
	 VQZHOFmObx2dDvkqRTENpBuieqCSjcBulwbDizLzwnVAwMtNnLSDHoB6yYxpWOFQvh
	 7y9wDyvPfbGUI3CSbmvU+RvhpXir1lJHIbbFnA4FYtCwsmLG2VmKY7jVa5XfWFkikK
	 H6OdrMZLq6cZg10L4cTNfLPbjq5KtLl3DSc2sFZOvZb2X3LbcQj4CogP6Oc3igucrX
	 +m2n+S0SRZUfbcEGIILscKiXfCsZzXFErDQY6zuBhSwLDN44/L5ccyi/PdSvYoU2+q
	 T4saQPkv1oAwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805054549.287648-1-cui.tao@linux.dev>
References: <20260805054549.287648-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:06:36 +0000
Message-Id: <20260805060636.A0FB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The unsafe user-access macros (`unsafe_put_user()` and `unsafe_get=
_user()`) are used without the required `user_access_begin()` and `user_acc=
ess_end()` guards, violating the kernel API contract.
- [High] A lockless read-modify-write on the shared VM state `kvm->arch.pv_=
features` allows userspace to bypass the validation check that requires all=
 vCPUs to share identical PV features.
--

--- Patch [1]: [PATCH v2] LoongArch: KVM: Advertise already-supported capab=
ilities ---
commit 91e3758510b96f271c2589373d1340c246fab45a
Author: Tao Cui <cui.tao@linux.dev>

LoongArch: KVM: Advertise already-supported capabilities
   =20
This commit advertises KVM_CAP_STEAL_TIME and KVM_CAP_VCPU_ATTRIBUTES on
LoongArch, making existing features discoverable to userspace.

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896a..0a51931d6f6e0 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_MP_STATE:
>  	case KVM_CAP_SET_GUEST_DEBUG:
> +	case KVM_CAP_VCPU_ATTRIBUTES:

[Severity: High]
This is a pre-existing issue, but does advertising KVM_CAP_VCPU_ATTRIBUTES
expose a data race in kvm_loongarch_cpucfg_set_attr()?

Looking at arch/loongarch/kvm/vcpu.c, there is a lockless read-modify-write
sequence on the shared VM state:

arch/loongarch/kvm/vcpu.c:kvm_loongarch_cpucfg_set_attr() {
...
	/* All vCPUs need set the same PV features */
	if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
			&& ((kvm->arch.pv_features & valid) !=3D val))
		return -EINVAL;
	kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED;
...
}

If multiple threads concurrently call KVM_SET_DEVICE_ATTR on different vCPU=
s,
can they bypass this validation check by both reading before either writes,
resulting in divergent configurations being silently applied globally inste=
ad
of returning -EINVAL?

>  		r =3D 1;
>  		break;
>  	case KVM_CAP_NR_VCPUS:

[ ... ]

> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  	case KVM_CAP_NR_MEMSLOTS:
>  		r =3D KVM_USER_MEM_SLOTS;
>  		break;
> +	case KVM_CAP_STEAL_TIME:

[Severity: High]
This isn't a bug introduced by this patch, but does advertising
KVM_CAP_STEAL_TIME expose an issue with unsafe memory accesses?

In arch/loongarch/kvm/vcpu.c, unsafe_put_user() is used without the required
user_access_begin() and user_access_end() guards:

arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
...
	unsafe_put_user(0, &st->preempted, out);
...
}

And similarly in kvm_vcpu_set_pv_preempted():

arch/loongarch/kvm/vcpu.c:kvm_vcpu_set_pv_preempted() {
...
	unsafe_put_user(KVM_VCPU_PREEMPTED, &st->preempted, out);
...
}

Since omitting user_access_begin() skips the access_ok() check at the access
site, could this cause a kernel fault if hardware-enforced user access
protections are introduced?

> +		r =3D kvm_pvtime_supported();
> +		break;
>  	default:
>  		r =3D 0;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805054549.2876=
48-1-cui.tao@linux.dev?part=3D1
