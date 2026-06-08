Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DC33F8D6
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947458; cv=none; b=lVlwJ1RWrPfIc/754o33u6SH9i6Fryyhde+dgOoLCm/knwPgBqE1cbWsy/acXL/0vBdbDyyAgXqC2bqr3ELlLCuvfxWAmyciEgnwqaCBUOIs/k3tQEmcpvLVPqCKS2CMnP0CvoCznqTFfNTw1WJ6YVKb0sT+ji/0J6ENmt7gTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947458; c=relaxed/simple;
	bh=mAvkyYfikavM2M8rHcnl74TBtlHsH6G/Vss4liZ6XR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDr8Dr/lOemHc06YdAkV6+1ouGyPDToVc58BK2xIjSM7QYBSTjpWqf4G9wEJrtpTRs1Mw+DBbdRZsSELpfzmWe1cJrp+8vwwA35TkcLjn2a1PZNgC13kVsBGJHpBQjvdiq9EphoQ+Bx4k8/g/OHaCA1TU3OOaKquJXeB+jebgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFn56jfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFn56jfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740881F00893;
	Mon,  8 Jun 2026 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780947457;
	bh=wbqeZhRFQWnlaJ6yhTQkp2actqmB0E54hJwhwNg5Vik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFn56jfbaBljwvWDHuP5T5nErSHbS49VhrWqFAMLPpGHcZOrNAP0orz9Qvm1ES1XK
	 M63Itjz9HvzjLtvkUKYQRRoZveJUlQ36Exps2axOeywCO4/ggtmSRSPO/+VKD7qh7T
	 k+hTdfhwZKQ2nWhoUNtAxHJkro34nLlJPo06d0xh+t+wDNLh2LUUmZ8i8Dj+s4ZR2c
	 rz1n0IF8S0g3e2yS7XgOuqWfn92eM5ntVgdwvUaDNZL2piZbEPSpDNmFp7YVLUNIbm
	 BvIJKUke8h5CdQ2eAllzQPhldp/dBcdH6mfSlqtTwYg4+8JRD6452q90DTTZfGBqfO
	 tW28RPufDxrNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 40/60] kvm: x86: Handle IOAPIC EOIs per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-41-joro@8bytes.org>
References: <20260608144252.351443-41-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:37:37 +0000
Message-Id: <20260608193737.740881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Iterating over all planes to call `vcpu_scan_ioapic(v)` corrup=
ts the currently loaded hardware state (VMCS/VMCB) with inactive vCPU data.
- [High] `KVM_REQ_LOAD_EOI_EXITMAP` remains a common request, causing inact=
ive planes to miss VMCS EOI exit map updates.
--

commit 2a25d5d833d92ddca988e436caa4350576bfb94b
Author: Joerg Roedel <joerg.roedel@amd.com>

Make sure the handling of IOAPIC EOIs is aware of planes.

This commit updates the IOAPIC EOI handling to filter routes by plane level.
It also modifies the KVM_REQ_SCAN_IOAPIC handling in vcpu_enter_guest() to
scan the IOAPIC for all vCPUs across planes instead of just the active one.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 623838885753..a158740a6fc1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11336,8 +11336,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcp=
u)
>  				goto out;
>  			}
>  		}
> -		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
> -			vcpu_scan_ioapic(vcpu);
> +		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu)) {
> +			struct kvm_vcpu *v;
> +			unsigned i;
> +
> +			vcpu_for_each_plane(vcpu->common, i, v) {
> +				vcpu_scan_ioapic(v);
> +			}

[Severity: Critical]
Can iterating over all inactive planes here cause a regression in hardware
state?

When vcpu_scan_ioapic() is called for the inactive plane, it invokes
kvm_x86_call(sync_pir_to_irr)(v). In VMX, this architecture-specific sync
function executes vmread and vmwrite operations.

These instructions implicitly operate on the VMCS currently loaded on the
local physical CPU. Because the vCPU "v" is an inactive plane and does not
have its own VMCS loaded, could this result in the inactive plane's
interrupt data overwriting the currently active plane's VMCS, leading to
missed interrupts?

> +		}
>  		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
>  			vcpu_load_eoi_exitmap(vcpu);

[Severity: High]
Since KVM_REQ_LOAD_EOI_EXITMAP is not defined as a plane request, will
inactive planes miss VMCS EOI exit map updates?

Because KVM_REQ_LOAD_EOI_EXITMAP remains defined as KVM_ARCH_REQ(), it
is shared across the entire core/plane group. The first active plane to run
kvm_check_request() will clear this shared bit globally but only execute
vcpu_load_eoi_exitmap(vcpu) for itself.

When inactive planes subsequently run vcpu_enter_guest(), they will see the
shared request bit already cleared and skip their own updates, potentially
causing a regression in EOI intercept behavior.

Should KVM_REQ_LOAD_EOI_EXITMAP be converted to KVM_ARCH_PLANE_REQ?

>  		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D40
