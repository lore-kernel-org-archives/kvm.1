Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183161D416C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637226; cv=none; b=P3YTO4ewj7c2if58CX4lLUn1MShakIhHJCEgIAedInjgldHkHcuV32pHtmtPxWI+4njGQpqR/AwU27EU9YpY0H1vnYMUXF6YVTH8kewnuWzURjZNX1h4iJLXbu3rKbiEvwmgafqu7PVISDNSkNzm45Mv+XUBC5HumRzKL/BLRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637226; c=relaxed/simple;
	bh=y1PQ2K0BBa0SVYeF9PKtA/syyoeHis8uGajo/RZnZjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hef5k4DpHLlbCyUCfdStqPpdKE3cbb32/bhe0pxKTDLj6Qq+lCgBSseIftMmZpls3GuRgQEsD2o6myecHbTx4umWXngrU9xK4DujR6iMhjmMZ+FoZ7gLRv8GW2KczbKkJw+4IzI55cj/yxWwPXjZOOBHyYnD2fVb9Osc2ZTIJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQcTJRtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQcTJRtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88E31F000E9;
	Tue, 21 Jul 2026 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637224;
	bh=LYNaJfs7WxfuIuaLsHXIxCMtwT8qCgh6Layv1csAWdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQcTJRtlidQX6rjkekICBbGIZa7iGRebn0wPX6HLuWkvxy0vKXqHItBKYn4in1y04
	 Fd4uuDmLxbPXZM5bYe2P/H4eh4q+ghfBXav6bSFj8w9Zot5t4tNwhQ5lK23mwcjjbi
	 aR/bBFJYzhIm1+3ujZX5iQT4K0dERQnnZ9IDj72d4lexqj8r5dmjLSmUwh7GtiquYo
	 q55GXOZtHwvQo3pkUqw4LuZbn5Kic9GDSxw6bdgiAwmwJimloN7a1kkTiSOJ54+lF3
	 JKNg8Ydf81O7gQ8/v57+v/6jqKT3t8Tq6Qygv+ZGqrLc6arefUIInF4d2RtQwny0F9
	 o9UdGvWeRDFiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <2D686C2069E3C0F9+20260721122442.351865-1-jinrui@haiwei.tech>
References: <20260721115558.341592-1-jinrui@haiwei.tech>
 <2D686C2069E3C0F9+20260721122442.351865-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 12:33:44 +0000
Message-Id: <20260721123344.A88E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The V-extension lazy enablement tracking (`v_epc`, `v_vcpu`, `v_=
available`) is incorrectly stored in the VM-global `struct handlers`, causi=
ng state overwrite, uninitialized variables, and infinite loops in multi-vC=
PU tests.
--

--- Patch [1]: [PATCH v5] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit b63a1da7a96089b977620f2f971a89f3c48484ee
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit adds lazy V (vector) extension enablement for RISC-V guests in =
KVM=20
selftests. It modifies exception handling to detect EXC_INST_ILLEGAL except=
ions
and enables the vector extension in the guest if available.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..03a3223a0466f 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
[ ... ]
> @@ -348,8 +340,34 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,=
 u32 vcpu_id)
[ ... ]
> +	/*
> +	 * Record V extension availability in the handlers struct so that
> +	 * route_exception() (called from Guest context) can check it
> +	 * without relying on a host-side global variable.
> +	 */
> +	{
> +		struct handlers *h =3D addr_gva2hva(vm, vm->handlers);
> +
> +		h->v_available =3D __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);
> +		h->v_vcpu =3D -1;

[Severity: Medium]
Since struct handlers is allocated once per VM, won't this clobber
v_available for the entire VM every time a new vCPU is added? It also
appears that v_epc is left uninitialized during this setup.

> +	}
> =20
>  	return vcpu;
>  }
[ ... ]
> @@ -415,6 +434,9 @@ void assert_on_unhandled_exception(struct kvm_vcpu *v=
cpu)
> =20
>  struct handlers {
>  	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
> +	bool v_available;
> +	unsigned long v_epc;
> +	int v_vcpu;

[Severity: Medium]
Could adding these tracking fields to struct handlers cause unintended state
sharing? Because this struct is shared globally across the VM, these fields
will not be per-vCPU.

>  };
> =20
>  void route_exception(struct pt_regs *regs)
> @@ -432,6 +454,46 @@ void route_exception(struct pt_regs *regs)
[ ... ]
> +		/*
> +		 * Compare (epc, vcpu_id) against the last attempted
> +		 * enablement to avoid an infinite loop when V is available
> +		 * but the test later disabled it or the hardware rejects
> +		 * the VS change.
> +		 */
> +		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
> +			int vcpu_id =3D 0;
> +
> +			asm volatile("csrr %0, sscratch" : "=3Dr" (vcpu_id));
> +			if (handlers->v_epc !=3D regs->epc ||
> +			    handlers->v_vcpu !=3D vcpu_id) {
> +				handlers->v_epc =3D regs->epc;
> +				handlers->v_vcpu =3D vcpu_id;
> +				regs->status |=3D SR_VS_INITIAL;
> +				return;
> +			}
> +		}

[Severity: Medium]
If multiple vCPUs trap concurrently, might they locklessly overwrite
handlers->v_vcpu and handlers->v_epc?

This could cause the loop-prevention check to constantly succeed for all vC=
PUs,
preventing the fallback to the registered handler and resulting in an infin=
ite
trap loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2D686C2069E3C0F9+20=
260721122442.351865-1-jinrui@haiwei.tech?part=3D1
