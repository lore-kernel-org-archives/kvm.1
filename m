Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815652D238A
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277371; cv=none; b=hB88LfimIMttRM+zwADqv7CcbRH+85rR7miQ+PxwBLHZ2OCMBmBelKRCnBxgjZ3XmKksnUYN8dCmWlbBrWiFPLWWWnld0ktc8P9lIS8RYIXFWygbk+A0JwAiu7Q/qWvG75RcCTWUTbvGO/zv5vsxIcIO7R5gUW5q1E+hLP6L3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277371; c=relaxed/simple;
	bh=0B7ZpdbFXInVHcb76ovi+urMzfR6FQUPne/JYbw2GpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=meGLTPbAim1ipBNXc3O/Zc48KZQICH646kEhr+QpwWeXzEYdopmRot0OzV77l3+UjwLB612XbKX08kqCJ3fcWzjI5rEgSt7PnGdpLZzgzDPtakOd1KxFe2JE4lp/flvcz+UkA4IJb2/zsHBK3D5auTwYVOxXwJ6eCwviKrG5FMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ85J0MQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ85J0MQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E81F000E9;
	Fri, 12 Jun 2026 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277370;
	bh=ctNfcuT/vyxFO2dZ8SBIBNiJGOrZnDK1jfkc92WOQ1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQ85J0MQJCcWP9VSkjpBMvUcytKZmhTcvV+i9+sJrw1IY/ZBiOMWMs7FjlW2LKrE8
	 YyZ3S4crlCmK4/BbWIN/uErWTiZCR1TzJsuMt26NEj02NYg1Llocegld4+h/sQopK6
	 mWZavb5DjKmVhMGhSZ6B4yZyaNZK6ojSjIqR8hEYFGIyIIGb5u/FLu4mveFmFd/DgC
	 Ap50CnwQ6sm8E4avxG2rK0GPkiAanhy15mWmYG5+9UUggU3vPvBRtTUTqgw0Hm7pWm
	 VvbAuYxiQtrZPrZ2yMXi2bjkImXjh6f7sWRBerEL5T6I0TaWrESdiejQjsOiXLBXa1
	 U0NI5s9TqtzCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: nVMX: Don't use vmcs01.GUEST_CR3 to
 snapshot L1's CR3 when EPT is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612145642.452392-3-seanjc@google.com>
References: <20260612145642.452392-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 15:16:09 +0000
Message-Id: <20260612151610.125E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `pre_vmenter_cr3` field is not serialized during live migratio=
n, causing L1's CR3 to be permanently lost and corrupted if a late VM-Fail =
occurs on the destination.
--

commit 2c3bbd56634c27ee75bdd6af8c48278025e7dcb4
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is disa=
bled

Add a dedicated field in "struct nested_vmx" to track L1's pre-VM-Enter CR3
instead of using vmcs01.GUEST_CR3.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 199b866072c0f..7a2251061bfa7 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -3669,19 +3669,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
>  				    &vmx->nested.pre_vmenter_ssp_tbl);
> =20
>  	/*
> -	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled.  In the
> -	 * event of a "late" VM-Fail, i.e. a VM-Fail detected by hardware but
> -	 * not KVM, KVM must unwind its software model to the pre-VM-Entry host
> -	 * state.  When EPT is disabled, GUEST_CR3 holds KVM's shadow CR3, not
> -	 * L1's "real" CR3, which causes nested_vmx_restore_host_state() to
> -	 * corrupt vcpu->arch.cr3.  Stuffing vmcs01.GUEST_CR3 results in the
> -	 * unwind naturally setting arch.cr3 to the correct value.  Smashing
> -	 * vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
> -	 * reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be
> -	 * overwritten with a shadow CR3 prior to re-entering L1.
> +	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
> +	 * VM-Fail detected by hardware but not KVM, KVM can unwind its
> +	 * software model to the pre-VM-Entry host state.  When EPT is
> +	 * disabled, GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3,
> +	 * and so simply restoring from vmcs01.GUEST_CR3 would corrupt
> +	 * vcpu->arch.cr3.
>  	 */
> -	if (!enable_ept)
> -		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
> +	vmx->nested.pre_vmenter_cr3 =3D kvm_read_cr3(vcpu);

[Severity: High]
This is a pre-existing issue, but could this corrupt L1's CR3 during live
migration if a late VM-Fail occurs on the destination?

When migrating a nested VM that is currently in L2 (or has a pending nested
run), KVM_SET_NESTED_STATE calls nested_vmx_enter_non_root_mode() with
from_vmentry=3Dfalse.

At this point, kvm_read_cr3() either holds L2's CR3 (if KVM_SET_SREGS
was already called by userspace) or the default initial CR3, but not L1's C=
R3.

[ ... ]
> @@ -4993,7 +4988,7 @@ static void nested_vmx_restore_host_state(struct kv=
m_vcpu *vcpu)
>  	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
> =20
>  	nested_ept_uninit_mmu_context(vcpu);
> -	vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
> +	vcpu->arch.cr3 =3D vmx->nested.pre_vmenter_cr3;
>  	kvm_register_mark_available(vcpu, VCPU_REG_CR3);

If a late hardware VM-Fail then occurs when KVM attempts to enter the guest
on the destination, nested_vmx_restore_host_state() will unwind L1's state
by setting vcpu->arch.cr3 to the value stashed above.

Since pre_vmenter_cr3 is not serialized as part of the nested state, doesn't
this clobber L1's CR3 with L2's CR3 or zero, potentially leading to memory
corruption or a kernel panic in L1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612145642.4523=
92-1-seanjc@google.com?part=3D2
