Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B7390986
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948995; cv=none; b=p+lkXv2pC5It7dclkyy9JpN/dmWw92CZLZFJC+dtEPCBdOZ6fdM4Iy+8BGTCkopk06ibnhUexc/cidoKoTU5HChSYypZvIHTzws4jWUA+bJtaQPnYRMfqYDtzK4iT10S8rSPQBxHSjGmQ4w2sqBXjyi3cw6UD/0ChW6ThkVJIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948995; c=relaxed/simple;
	bh=ldwX9IaVrWaWJ+ykPPt7Nlm1aCVmDCK2Kdd3SJEvh5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dYx/tAs06cNK1ZIMJkiEGsxpWRrEMYicx3pcZ6rpMDIU7pM7DI0csEFNQ50tE1FayX0GEiwAHhX9kgOGv7jCPR5JVq3Pp8kY3PkDL4FAohqnHCgAXx1pFdwXO2lKbOgavFZ0zsRLrhGtn7pBT7/g8Tjyu2dCIUAQVMURmoH5/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejoYUyL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejoYUyL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7171F00893;
	Mon,  8 Jun 2026 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780948993;
	bh=gHlUAiBtNNcE96BDm2olKsRGYNtritEgNKTkUIdHtds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejoYUyL1iykrgFGh3dPxh2iezg70bAomS7V8EZxqUmcZwidZtzlXbTQOMT87uQb5G
	 89cZYoMNq1l1JiaSfEAH2SzzWpMzcn99wvWbpCBMUTA+SNqZ/GszjKd5cFtZXmamht
	 8XjjOpO5w01J8VJGv0t5MifI672VPypG9bSDEN0Im16v1rPirzJk58M+CkPuscsfdA
	 Gdez4HfaUjb0Ik0oTtF9YDNy9BD2ai9E3RNofgF1PBsE6D2qki+rh9Y1qs5EZNW3+4
	 z2xDMdAaicZ7yJ81JR6ufpcx3Q/l6vSW0SdZ5NiC1HmN/Xl9ztjdAU180mHhhX1CHo
	 a0ZBIcMGQcPtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 42/60] kvm: x86: Make local APIC code aware of planes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-43-joro@8bytes.org>
References: <20260608144252.351443-43-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:03:12 +0000
Message-Id: <20260608200313.0F7171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Uninitialized stack variable leads to out-of-bounds array read=
 and NULL pointer dereference in KVM_SIGNAL_MSI.
- [High] kvm_pi_update_irte() unconditionally hardcodes plane 0, breaking p=
osted interrupts for MSIs targeted at other planes.
- [Medium] kvm_sched_yield() operates on the global VM APIC map, violating =
plane isolation and potentially yielding to the wrong vCPU.
--

commit 06af524f9c5368917a9b156f85c8c35815e2a5e4
Author: Paolo Bonzini <pbonzini@redhat.com>

Make the local apic code aware of planes and only operate on APICs
within the same plane level.

This patch updates KVM's local APIC, IOAPIC, and MSI handling to operate
within isolated planes rather than treating all APICs as a single global po=
ol.
By using the newly introduced plane structures, APIC delivery and lookup
operations now restrict themselves to the APIC map and vCPUs associated
with a specific plane level.

> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index bc748a4b7cbd..3bf2ecfd9cb4 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -226,6 +226,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *=
e,
>  		struct kvm *kvm, int irq_source_id, int level, bool line_status)
>  {
>  	struct kvm_lapic_irq irq;
> +	struct kvm_plane *plane;
> =20
>  	if (kvm_msi_route_invalid(kvm, e))
>  		return -EINVAL;
> @@ -234,8 +235,9 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *=
e,
>  		return -1;
> =20
>  	kvm_msi_to_lapic_irq(kvm, e, &irq);
> +	plane =3D kvm->planes[e->msi.plane_level];
> =20
> -	return kvm_irq_delivery_to_apic(kvm, NULL, &irq);
> +	return kvm_irq_delivery_to_apic(plane, NULL, &irq);
>  }

[Severity: Critical]
Could this lead to an out-of-bounds array read and a subsequent NULL pointer
dereference?

In virt/kvm/irqchip.c:kvm_send_userspace_msi(), the route structure is
allocated on the stack but not fully zero-initialized:

struct kvm_kernel_irq_routing_entry route;
...
return kvm_set_msi(&route, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1, false);

If route.msi.plane_level contains uninitialized stack garbage, we might acc=
ess
an out-of-bounds index in the kvm->planes array here, and potentially pass a
NULL plane to kvm_irq_delivery_to_apic(). Is there a bounds check missing?

[ ... ]

> @@ -453,7 +455,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd=
 *irqfd,
>  		 * if they have a single CPU as the destination, e.g. only if
>  		 * the guest has affined the interrupt to a single vCPU.
>  		 */
> -		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
> +		if (!kvm_intr_is_single_vcpu(kvm->planes[0], &irq, &vcpu) ||
>  		    !kvm_irq_is_postable(&irq))
>  			vcpu =3D NULL;
>  	}

[Severity: High]
Will hardcoding kvm->planes[0] here break posted interrupts for MSIs target=
ed
at other planes?

Since kvm_set_msi() was updated to route dynamically based on
entry->msi.plane_level, using plane 0 unconditionally here seems like it co=
uld
cause posted interrupts to be disabled (if the target APIC ID doesn't exist=
 on
plane 0) or misrouted (if the APIC ID overlaps with one on plane 0).

Should this be using entry->msi.plane_level as well?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 070f87ae23eb..7fc08df245bd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -10515,7 +10515,7 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vc=
pu, int cpl,
>  		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_UNHALT))
>  			break;
> =20
> -		kvm_pv_kick_cpu_op(vcpu->kvm, a1);
> +		kvm_pv_kick_cpu_op(vcpu->plane, a1);
>  		kvm_sched_yield(vcpu, a1);
>  		ret =3D 0;
>  		break;

[Severity: Medium]
Does kvm_sched_yield() need to be updated to be plane-aware?

While kvm_pv_kick_cpu_op() is updated here to operate within the context of
vcpu->plane, kvm_sched_yield() still resolves the destination APIC ID again=
st
the global VM APIC map:

arch/x86/kvm/x86.c:kvm_sched_yield() {
    ...
    map =3D rcu_dereference(vcpu->kvm->arch.apic_map);
    ...
}

Since APIC maps and IDs are now plane-specific, could this cause KVM to yie=
ld
the CPU to the wrong vCPU if APIC IDs overlap between planes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D42
