Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D43ED5DC
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654554; cv=none; b=UjoDQ3puAuincWMFs8LHV2JY2HKTo2r4g5tznQOe25iP2tiv2kplAmi/csSabzwT4lg3DHHzmbLR+Y5yGavqo7UVgLitT/LBqfbVHL2AQv05WTPy5JIAM6xrn672MbLZJY5+NgkqdbiNExq7jWM/DW/dPg7E3oTm6p0l6txmKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654554; c=relaxed/simple;
	bh=7d9zOZUlrWn3ydcH3NtiZU9q3aKpDIlUkIfXUALB1Ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoXJB2nLyj6Q12up1RpwOOt9rXmcXwJXQ3qasC1uNdS+lN2a0yzfqsR54IXfE+sC02+Zf2sTJhP3QcF0cbQ53IMno25Dh4MYiMRntWF7Z2yNVdHAnmK07nbBOt9BNEIMvy+lNWlHEeS+fwzRO38zSGEpaNkWlAv1OJzhD8XWZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0dM2qKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0dM2qKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A391F00893;
	Fri,  5 Jun 2026 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654553;
	bh=ZMXZQgI7/cc50pK1K50FNbMO5SKfvgyNmPm+cWBHzbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0dM2qKttGok3fEtBESM+EkqbYWCbBk6Wj/Ygef2eSx8xTo6PnW29T5EWQHb6af7v
	 4ETNNsh48boiO3n6D7MRknUCVUhuKf2LR8q27CcxC7/aMeK8BcSrxu5PgFhqijWQ36
	 iLRE9hL8yn8O4lG+/bhX76yBhdgbizoRgfrhcxO//IAGjX6eEM4PcsrsGf5e4jgQ2J
	 W9QYRGBnDQWMOOkcD4XryOD5LpkEQkPtw/ozbui5x/YYbgEnmFDNwDebuvzYLRzAlk
	 OiN4uOMJ6qoLiEB3wCrlSlzsNwZPIW3TXdfQOO2LCHOzcuCZrXG2MJ/TEb0Dr9E/ur
	 a3ovBfNtYX+YA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] KVM: x86: forward LAPIC ICR writes to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605100031.834938-3-muliang.shou@sjtu.edu.cn>
References: <20260605100031.834938-3-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:15:52 +0000
Message-Id: <20260605101553.40A391F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Unconditional KVM exit reason `KVM_EXIT_DSM_SEND_IRQ` breaks e=
xisting userspace VMMs.
- [High] DSM IPI forwarding completely bypasses x2APIC MSR writes and conta=
ins unreachable dead code.
- [High] DSM IPI forwarding is completely bypassed when hardware APIC virtu=
alization (APICv/AVIC) is enabled.
- [High] Redundant and potentially broken user-space exits on `APIC_ICR2` w=
rites.
- [Medium] Double delivery of IPI due to handling in-kernel before forwardi=
ng to userspace.
- [Low] Redundant state variable `dsm_irq_forward_pending` is written but n=
ever read.
--

commit bdf02d4ca756633b7da489c2909a4855a29cb345
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: forward LAPIC ICR writes to userspace

Intercept LAPIC ICR/ICR2 MMIO writes, record the forwarding payload, and
return to userspace with KVM_EXIT_DSM_SEND_IRQ when the pending request is
processed.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca667..2485d50b45647 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
[ ... ]
> @@ -2583,6 +2587,32 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, =
struct kvm_io_device *this,
> =20
>  	val =3D *(u32*)data;
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +	reg =3D offset & 0xff0;
> +	if (reg =3D=3D APIC_ICR || reg =3D=3D APIC_ICR2) {

[Severity: High]
Does this completely miss IPIs when hardware APIC virtualization (APICv or
AVIC) is enabled?=20

Memory-mapped writes to the LAPIC ICR on APICv/AVIC hardware trigger an
APIC-write VM-exit, which KVM natively handles via kvm_apic_write_nodecode(=
).
Since that bypasses apic_mmio_write(), guests might bypass this interception
entirely.

[Severity: High]
Should writing APIC_ICR2 queue a request and exit to userspace?

In standard xAPIC mode, writing to APIC_ICR2 only sets the destination ID a=
nd
doesn't dispatch the IPI until APIC_ICR is subsequently written. Triggering=
 a
VM-exit on ICR2 might force userspace to handle incomplete IPIs and double =
the
exit overhead.

> +		kvm_lapic_reg_write(apic, reg, val);

[Severity: Medium]
Will calling kvm_lapic_reg_write() here process the IPI inside the kernel
before exiting to userspace?=20

For APIC_ICR, this internally calls kvm_apic_send_ipi() which delivers the
interrupt to local vCPUs. If userspace is also expected to manage IPI
delivery, might this result in duplicate interrupt delivery?

> +		if (reg =3D=3D APIC_ICR) {
> +			if (apic_x2apic_mode(apic)) {
> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +			} else {

[Severity: High]
Is the x2APIC branch here reachable?

Earlier in apic_mmio_write(), the function returns early if
apic_x2apic_mode() is true:

	if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
		if (!kvm_check_has_quirk(vcpu->kvm,
					 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
			return -EOPNOTSUPP;
        ...

This means guests could potentially bypass this forwarding mechanism by
enabling x2APIC mode, as it natively uses MSRs instead of MMIO.

> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +				dest_id =3D GET_XAPIC_DEST_FIELD(dest_id);
> +			}
> +		} else {
> +			dest_id =3D GET_XAPIC_DEST_FIELD(val);
> +		}
> +
> +		vcpu->arch.dsm_irq_forward_pending =3D true;

[Severity: Low]
Is dsm_irq_forward_pending actually required? It appears to be written to
here and cleared in vcpu_enter_guest(), but is never read to make control
flow decisions.

> +		vcpu->arch.dsm_irq_forward_reg =3D reg;
> +		vcpu->arch.dsm_irq_forward_val =3D val;
> +		vcpu->arch.dsm_irq_forward_dest_id =3D dest_id;
> +
> +		kvm_make_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu);

[Severity: Critical]
Could unconditionally queueing this request cause a host-side denial of
service or VM abort?

According to KVM ABI rules, new guest-visible behaviors and exit reasons mu=
st
be disabled by default. If a legacy userspace VMM receives an unrecognized
KVM_EXIT_DSM_SEND_IRQ exit reason, it may crash. Does this need to be gated
by a capability check (e.g., KVM_CAP_*)?

> +
> +		return 0;
> +	}
> +#endif
> +
>  	kvm_lapic_reg_write(apic, offset & 0xff0, val);
> =20
>  	return 0;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a5e09bf431cee..8e484a7230bdf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -11324,6 +11324,20 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcp=
u)
>  				goto out;
>  			}
>  		}
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +		if (kvm_check_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu)) {
> +			vcpu->run->exit_reason =3D KVM_EXIT_DSM_SEND_IRQ;

[Severity: Critical]
Are we safely gating this new exit reason? Setting KVM_EXIT_DSM_SEND_IRQ
unconditionally without a capability negotiation breaks ABI for existing
userspace implementations.

> +			vcpu->run->lapic_irq.id =3D vcpu->vcpu_id;
> +			vcpu->run->lapic_irq.val =3D vcpu->arch.dsm_irq_forward_reg;
> +			vcpu->run->lapic_irq.val2 =3D vcpu->arch.dsm_irq_forward_val;
> +			vcpu->run->lapic_irq.dest_id =3D vcpu->arch.dsm_irq_forward_dest_id;
> +
> +			vcpu->arch.dsm_irq_forward_pending =3D false;
> +
> +			r =3D 0;
> +			goto out;
> +		}
> +#endif
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605100031.8349=
38-1-muliang.shou@sjtu.edu.cn?part=3D2
