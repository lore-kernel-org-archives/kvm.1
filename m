Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB828504F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427859; cv=none; b=G7pQgtzbofC0YM/3DLFShwbxOVJo7gc0Fg3QooHTmbcCQYuI+yyEY2CilNkHZZyhj5RR4GgAycLrRtKXANYd4o0jY9hDEfpF/JmLFgSTyNkVglJEDCNOUFty6DpdcHmmT935hsd1jQFjN4v2uzUvVH8LAC1TJ9Uxd8EZPxcZIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427859; c=relaxed/simple;
	bh=kMY+ODh7t4yuTTdWuBKgpeqYHxgY2aHc26+whao4E7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMbvtlpeozwRXjbMJrWYb9xgiFSFa4l/uKI6a5w8RQOfqk2ilnjCl1BW26UStbM+pC1HqFY+92fNA0jfXqakW4YjZ3/s49i+3QSvmzJ/vp4tl4DTOt/WYDjKBWtIzzeXl6PbEZ8BpKOeq8MNiH/TBeiVrublg2ucuI0aW7NBHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD/gO8UU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD/gO8UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477381F000E9;
	Thu, 25 Jun 2026 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427858;
	bh=i3PFLUur9zhpiBoD5nrkICX3Gk8zLm4ZIHazUS9aTOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UD/gO8UUeEn6G974X11wfwNXAmI828LV1EkViayQO/JXPXKSjWnD+dsrkamzSJmgJ
	 P2/s8TWHu2kvI14+A+ZcMA2Koc0zBbACzwZEY29wmA1xJ7cQp+/WjMBtn6808wFW/F
	 LvJyeW1VN5mx+CK77FD94EKpS/D5OhrvpAsYD9GsKmMzDbalCvwcOlk+XHG9Yan157
	 m2AzQ0lhRXtYAUK/ItOl8twi0nCC6AvZlwlRHUwlqDfvf828IksWGa/eJp1a08Pxyc
	 fig07btCMjdS6ym40c69zAb8taKYDKJM14GH6f3U8P+eaWWocWr2PAk8HoUB76ZodQ
	 ladNiFoUpkHjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625223623.3376478-5-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
 <20260625223623.3376478-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:50:57 +0000
Message-Id: <20260625225058.477381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM returns an un-restorable value for KVM_XEN_VCPU_ATTR_TYPE_VCPU=
_ID when the Xen vCPU ID is not set, breaking live migration.
- [Medium] kvm_xen_hcall_set_timer_op() handles single-shot timer hypercall=
s in the kernel even when the Xen vCPU ID is invalid, contradicting the com=
mit's intent.
--

commit 02813e860ee3ca993ca34adffcb813bb2bcccc96
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID isn'=
t set

Explicitly invalidate KVM's internal Xen vCPU ID during vCPU creation
instead of *trying* to set the Xen ID to the vCPU index by default, and
forward singleshot timer hypercalls to userspace if the VMM hasn't set the
Xen ID via KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID.  Using the vCPU's index as its
default Xen ID is reasonable in concept, but in practice is horribly flawed
as the index is left as '0' until after vCPU initialization completes, i.e.
every vCPU gets a Xen ID of '0' by default.

Link: https://lore.kernel.org/all/20260612233017.1F9771F000E9@smtp.kernel.o=
rg

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 694b31c1fcc9a..27c1aeeab8afb 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
[ ... ]
> @@ -1610,6 +1611,9 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *=
vcpu, bool longmode, int cmd,
>  	if (!kvm_xen_timer_enabled(vcpu))
>  		return false;
> =20
> +	if (vcpu->arch.xen.vcpu_id =3D=3D XEN_VCPU_ID_INVALID)
> +		return false;
> +

[Severity: Medium]
Does this bypass the userspace punting rule for the __HYPERVISOR_set_timer_=
op
hypercall?

While this correctly punts for kvm_xen_hcall_vcpu_op(), the older hypercall=
 is
still handled natively without the check:

arch/x86/kvm/xen.c:kvm_xen_hcall_set_timer_op() {
    if (!kvm_xen_timer_enabled(vcpu))
        return false;

    if (timeout)
        kvm_xen_start_timer(vcpu, timeout, true);
    else
        kvm_xen_stop_timer(vcpu);

    *r =3D 0;
    return true;
}

If a Xen guest issues __HYPERVISOR_set_timer_op on a vCPU where the VMM has=
n't
configured the ID, it is still handled in the kernel.

Will this create an inconsistent ABI where one single-shot timer hypercall
variant is punted, while the other is handled natively?

>  	switch (cmd) {
>  	case VCPUOP_set_singleshot_timer:
>  		if (vcpu->arch.xen.vcpu_id !=3D vcpu_id) {
[ ... ]
> @@ -2299,7 +2303,7 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vc=
pu *vcpu, u64 param, u64 *r)
> =20
>  void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
>  {
> -	vcpu->arch.xen.vcpu_id =3D vcpu->vcpu_idx;
> +	vcpu->arch.xen.vcpu_id =3D XEN_VCPU_ID_INVALID;

[Severity: High]
Does this initialization break live migration when the ID isn't configured?

When userspace calls KVM_GET_XEN_VCPU_ATTR, it retrieves the uninitialized =
ID
as XEN_VCPU_ID_INVALID (which is U32_MAX).

On the destination host, attempting to restore this state fails because
kvm_xen_vcpu_set_attr() explicitly rejects values >=3D KVM_MAX_VCPUS:

arch/x86/kvm/xen.c:kvm_xen_vcpu_set_attr() {
    ...
    case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
        if (data->u.vcpu_id >=3D KVM_MAX_VCPUS)
            r =3D -EINVAL;
        else {
    ...
}

Will this cause KVM to unconditionally reject the valid state returned by
GET_ATTR and return -EINVAL during live migration?

>  	vcpu->arch.xen.poll_evtchn =3D 0;
> =20
>  	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.3376=
478-1-seanjc@google.com?part=3D4
