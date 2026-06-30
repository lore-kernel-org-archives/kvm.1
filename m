Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD933374F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860934; cv=none; b=I0giVAlkZ8BvJXlrxXIZUfLI7RPPcEqWsrfJklYeR+k8zS3ji5ggNkBIXDUWy/rNZJJakqWpS7nQFYiHYP96gsKUipZZEMM2J0w/aKzw/4DmSQYNkfCCWuuZSAedhOlNN0rRAkw/m6GALcuLM6+aOrJt9Nf6O1YyacmsMfuhsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860934; c=relaxed/simple;
	bh=wshvdllqEfkvoYxIj2v+2kgDt/1iHE9xpTWJpYJpjRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=er70h0X5Q88yH60O8gCXP0Sjo+BkgQ7owJJJz3A0Y0s4ysRycuYB3mYpkIe9k/IPZ7cACDmwi8peFKW5nwfQOiQ2yKsKeguk3bZqq+S6/4f5FbYk1tbCcT7QjvvUc+aQ/mVsBs0ysjDzX6XJrmRkyrE1FWkZ8tpcm6UvrT1sj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA2f6NpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA2f6NpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE9B1F000E9;
	Tue, 30 Jun 2026 23:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860933;
	bh=y4r85KAU1t6lbkWTspgitqTdtw5LjllMZGEj8vi6Jus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JA2f6NpFVc0ocPkuI950VItzBKnP0zW4JpESaoTsIfpJgtABWEekN4bj2jupY+aO2
	 hGJxEmu09F5j2rgqQl0/qElc/tkwpi/7T6OFgrXN9Cwu8Uv7D6EeklCXQAiXVZv1Zo
	 tU9tjy11o0fqhcIFJYrbN5R7H/GqWTerfe5gSKyy7/QZ4RqoCjx4jjTsBkxhlOjM50
	 iki7uqmyWO0aATCw4aI3UEvavEP0BHWBOYP7lOGSNMV+bQiYQMWDS1aaHB5lR9O4Jd
	 VZpME6nLXpTCNYQpFu50Syhg1CU2ktvTw75oiZJ/dXECN4vUIvaXyEeGxdh7i8Iwgg
	 3ZA74+o/uAZmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630225619.511632-7-seanjc@google.com>
References: <20260630225619.511632-1-seanjc@google.com>
 <20260630225619.511632-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:08:52 +0000
Message-Id: <20260630230852.DCE9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM_XEN_VCPU_SET_ATTR unconditionally rejects the uninitialized st=
ate (XEN_VCPU_ID_INVALID) returned by KVM_XEN_VCPU_GET_ATTR, breaking live =
migration.
--

commit a0e30df39328c44b4229534da902c6e3bed5d228
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID isn'=
t set

This commit explicitly invalidates the Xen vCPU ID at creation instead of
trying to default it to the vCPU index. It also forwards singleshot timer
hypercalls to userspace if the VMM hasn't explicitly set the Xen vCPU ID.

Link: https://lore.kernel.org/all/20260612233017.1F9771F000E9@smtp.kernel.o=
rg

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1103,6 +1104,8 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, st=
ruct kvm_xen_vcpu_attr *data)
>  		break;
> =20
>  	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
> +		BUILD_BUG_ON(XEN_VCPU_ID_INVALID < KVM_MAX_VCPUS);
> +
>  		if (data->u.vcpu_id >=3D KVM_MAX_VCPUS)
>  			r =3D -EINVAL;
>  		else {

[Severity: High]
Will this break live migration by making GET and SET operations asymmetric?

Since kvm_xen_init_vcpu() now initializes the vCPU ID to XEN_VCPU_ID_INVALI=
D:

kvm_xen_init_vcpu()
   vcpu->arch.xen.vcpu_id =3D XEN_VCPU_ID_INVALID;

During live migration, if the VMM hasn't explicitly configured the ID, the
source VMM will read this initial state via kvm_xen_vcpu_get_attr(), receiv=
ing
the U32_MAX value.

When the destination VMM attempts to restore this exact state using
kvm_xen_vcpu_set_attr(), it appears it will be unconditionally rejected here
because U32_MAX is >=3D KVM_MAX_VCPUS, returning -EINVAL.

Should kvm_xen_vcpu_set_attr() be updated to explicitly allow restoring
XEN_VCPU_ID_INVALID to preserve standard save and restore loops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630225619.5116=
32-1-seanjc@google.com?part=3D6
