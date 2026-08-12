Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7629B781
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507056; cv=none; b=p4HCsqfHSX72trq/c844PJfcFmc8+TOZb4IcFE5sUgLd+OSpLjRWuLuQ1MKvJBONZQQZgoUGtrRXtPBRcBUrgD0gLkWw4nHzwoKdaO8aEbF8GtEticrC6/I1QjcIjiv1CngpsYrA7Y+D97ha1nWRAKeb6a8PXJfjFcZPw2bMsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507056; c=relaxed/simple;
	bh=fHWwQGYOnir0mNoM/J071rAlA+YI1Lc0Fvi9vT36zbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vgm9I8fGb410MtgjEJSLa6eVhFTJmZL6np5RBjQt+xUqxBppiOQ/EjL7Qquzp0LzebAPTyPOKshSWsjFUUHOB5gCLyd4OxHY4fZUCqlLY0tZ7jxZHDzXeON7cU6ev9TfOC6cP9KMajgRlpvNHsaFg2LXM3PIuY9zoY+LkEm90jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3lgg8m0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3lgg8m0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD4C1F000E9;
	Wed, 12 Aug 2026 03:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786507054;
	bh=NvyuFg1dLuj2Dy15F3S18EnBTkhfupqr3cqJ52ltCUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3lgg8m07ee488wnA23lBxBE3U2ORcu5r4Owo3mXGD/pVZ97Aeqc+zfj1gQ1DQSOO
	 66kbwLsb1m1eRgls9xUMS7AN2cW/YpsJGj//HGysvlzsnQOfQwsSmJoSLS3W0NbqPB
	 EdO7bOm47kl/pFHOYvNPXuBbEkWVGoYaim+9fAoVkERJUXWwDLikLdmJ6xAT72dj62
	 k3guFc8jCfxZjf1F1q0FxkZU+3fjXbWzRc7fFyH20mSvnXugSMT/HJIDBjd5YpbmKK
	 jsRFF1yef1Zc+m4vSgkLpwBuaDIZyfQB7yiC52zzJuwBk00zUyayvxZvsU8kCJ6YjN
	 bHmCpv94jCuqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Don't drop pending doorbell
 across L2 entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
References: <20260812034628.1122115-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 03:57:34 +0000
Message-Id: <20260812035734.6BD4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] KVM_SET_ONE_REG ioctl for KVM_REG_PPC_DPDES unconditionally increm=
ents doorbell_request, ignoring the userspace-provided value.
- [High] Changing DPDES doorbell tracking from a boolean state to a countin=
g semaphore violates PowerISA semantics, causing spurious interrupts and le=
aking internal state.
- [High] Emulating the MSGCLRP instruction unconditionally decrements doorb=
ell_request, allowing it to underflow to negative values and permanently ma=
sk future doorbells or fake pending ones.
- [High] TOCTOU race in nestedv2 entry/exit path silently drops concurrent =
doorbells that arrive while the L2 guest is running.
- [Medium] Unbounded queuing of doorbells via MSGSNDP allows an integer ove=
rflow that disables doorbells for sibling vCPUs.
--

--- Patch [1]: [PATCH v2] KVM: PPC: Book3S HV: Don't drop pending doorbell =
across L2 entry ---
commit 08c6169713a748bce823e2d3e8086fb958a9b53f
Author: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: KVM: PPC: Book3S HV: Don't drop pending doorbell across L2 entry

This commit converts the doorbell_request tracking to an atomic_t to
prevent the L1 from losing pending doorbells when an L2 exits without
handling them. It also updates APIv1 and Bare-Metal KVM infrastructure
on PPC64 to use atomic_t helpers.

Link: https://lore.kernel.org/linuxppc-dev/20260803034426.44249-1-vaibhav@l=
inux.ibm.com/T/#u

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..fb80c13dbb298 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -1557,17 +1558,16 @@ static int kvmppc_emulate_doorbell_instr(struct k=
vm_vcpu *vcpu)
>  		tvcpu =3D kvmppc_find_vcpu(kvm, vcpu->vcpu_id - thr + arg);
>  		if (!tvcpu)
>  			break;
> -		if (!tvcpu->arch.doorbell_request) {
> -			tvcpu->arch.doorbell_request =3D 1;
> +		if (atomic_inc_return(&tvcpu->arch.doorbell_request) >=3D 1)

[Severity: High]
PowerISA defines DPDES as a single-bit state. Does queuing doorbells by
allowing doorbell_request to increment beyond 1 violate these architectural
semantics?=20

If multiple MSGSNDP instructions are executed, the count increases above 1,
which means a single MSGCLRP (which decrements by 1) might fail to clear the
pending state.

[Severity: Medium]
Also, is there anything preventing a guest from executing MSGSNDP repeatedly
to overflow this counter to a negative value, thereby disabling future
doorbells for a sibling vCPU?

>  			kvmppc_fast_vcpu_kick_hv(tvcpu);
> -		}
>  		break;
>  	case OP_31_XOP_MSGCLRP:
>  		arg =3D kvmppc_get_gpr(vcpu, rb);
>  		if (((arg >> 27) & 0x1f) !=3D PPC_DBELL_SERVER)
>  			break;
> -		vcpu->arch.vcore->dpdes =3D 0;
> -		vcpu->arch.doorbell_request =3D 0;
> +
> +		if (atomic_dec_return(&vcpu->arch.doorbell_request) <=3D 0)
> +			vcpu->arch.vcore->dpdes =3D 0;

[Severity: High]
If a guest executes MSGCLRP when no doorbell is pending, does this
unconditional decrement allow doorbell_request to underflow to a negative
value?

If it drops below zero, kvmppc_doorbell_pending() will evaluate the negative
value as true:

kvmppc_doorbell_pending() {
    if (atomic_read(&vcpu->arch.doorbell_request))
        return true;
    ...
}

Could this permanently mask future doorbells or fake a pending doorbell,
preventing the vCPU from halting?

>  		break;
>  	case OP_31_XOP_MFSPR:

[ ... ]

> @@ -2313,7 +2313,7 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *v=
cpu, u64 id,
>  		 * On POWER8, doorbell_request is 0.
>  		 */
>  		if (cpu_has_feature(CPU_FTR_ARCH_300))
> -			*val =3D get_reg_val(id, vcpu->arch.doorbell_request);
> +			*val =3D get_reg_val(id, atomic_read(&vcpu->arch.doorbell_request));

[Severity: High]
Since doorbell_request can now exceed 1 due to the atomic_inc_return() abov=
e,
does this leak the internal integer counter to userspace? Userspace typical=
ly
expects a 1-bit boolean flag for KVM_REG_PPC_DPDES.

>  		else
>  			*val =3D get_reg_val(id, vcpu->arch.vcore->dpdes);
>  		break;

[ ... ]

> @@ -2565,7 +2565,7 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *v=
cpu, u64 id,
>  		break;
>  	case KVM_REG_PPC_DPDES:
>  		if (cpu_has_feature(CPU_FTR_ARCH_300))
> -			vcpu->arch.doorbell_request =3D set_reg_val(id, *val) & 1;
> +			atomic_inc(&vcpu->arch.doorbell_request);

[Severity: High]
Does this ignore the userspace-provided value (*val) completely and
unconditionally increment the counter?

If a userspace VMM like QEMU calls KVM_SET_ONE_REG with val=3D0 to restore
an idle vCPU, it looks like a phantom doorbell would be injected instead.

>  		else
>  			vcpu->arch.vcore->dpdes =3D set_reg_val(id, *val);
>  		break;

[ ... ]

> @@ -4298,6 +4298,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vc=
pu *vcpu, u64 time_limit,
> =20
>  	timer_rearm_host_dec(*tb);
> =20
> +	/* Check if privileged door bell was requested and handled */
> +	if (atomic_read(&vcpu->arch.doorbell_request) > 0) {
> +		/* In case PHYP doesn't return updated dpdes in output gsb */
> +		if (vcpu->arch.vcore->dpdes)
> +			kvmhv_nestedv2_cached_reload(vcpu,
> +						     KVMPPC_GSID_DPDES);
> +		/* if dpdes was handled then reduce the doorbell count */
> +		if (!vcpu->arch.vcore->dpdes)
> +			atomic_dec(&vcpu->arch.doorbell_request);
> +	}

[Severity: High]
Is there a race condition here that drops newly arrived doorbells?

If the L2 guest is running and a concurrent vCPU sends a doorbell via
MSGSNDP, doorbell_request will be incremented. When the L2 guest exits,
this post-exit logic might observe doorbell_request > 0 and=20
vcore->dpdes =3D=3D 0, and erroneously decrement doorbell_request.

Does this permanently drop the doorbell that arrived concurrently while the
L2 guest was running?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812034628.1122=
115-1-vaibhav@linux.ibm.com?part=3D1
