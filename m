Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC04908A9
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138597; cv=none; b=nRNMBPzJmDYSbVAPjQgmsN7uY2CkB3b4uJYZQ9jdKtgzxtwwsyOe3q/QLjtSPSfrPA3IXu+HK0Dtym18E3foPGmd+dxVXk5RdfiqmH9RnMrVtIXeiEFcoj5I5TopJZ4dYckpWDEsHMkw+6E6YZWqr99XV32XYRw3byZUnTfB9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138597; c=relaxed/simple;
	bh=bXqRf01d1qBunNswvRHQORWoyQF0ofZSD2nIqr0sA68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gHo4s8DYYFVcNOz+5rNt6EiSz5ydEdaUZku5hfSJh2qvuXV87drb39EvrsDGToPv/z9QVF70UGV4I9cgdNiIGk0grK7CKO8fjEsNeoAxsjYaB98IGZNUKpKRs4MXxvbIN8HHQvwFtlNRgd7A0GS2W0k1yyTvumVKYV8d3Ly0YFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL43JO7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL43JO7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F71F000E9;
	Mon, 27 Jul 2026 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138596;
	bh=b0nQn65C1gDt51W74SuKpmnADLZR8uPrgli6LIzwB7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL43JO7ZHHp3yBGNOv2KdeTntxtr2eUGyYLhjU/yFtVMr8lkNMlQKrtojs1TXg/eq
	 VoMMnPa3tehM5G7IJH6yp8pWe8T8aqTZx576mbo4deI1ET9FRImQnstDXNKjEzpBSB
	 iTclhmpKJiTPOEedqqRFooFnhEzKYmm0HNvU2Q035IwGNfbsuywW4gWSBALlDFEOin
	 69g0ky639lST5oECLaPXbeiWIzMMQfyvQQfZGMNIusEEBo3JByCBcppAj/ppz/IYHP
	 T8kriL0oTw9NQ+1/5tWzSSANBjr/ZHXMnpnoFhhgnnZS1K+NChhr6XuwSjxxB2f0Ih
	 GcPcQf+qtvNCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] LoongArch: KVM: implement vmid updating logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727072109.2151675-5-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 07:49:55 +0000
Message-Id: <20260727074956.488F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The separation of VMID from VPID for hardware with `cpu_has_gu=
estid` breaks the handling of `KVM_REQ_TLB_FLUSH` for Stage-2 TLBs.
- [High] `kvm_check_vmid` prematurely clears the deferred `KVM_REQ_TLB_FLUS=
H_GPA` request when a vCPU allocates a new VMID on a single physical CPU, l=
eading to stale TLB entries if the vCPU migrates.

Pre-existing issues:
- [High] Error paths in `kvm_loongarch_env_init()` and `kvm_loongarch_init(=
)` fail to clean up dynamically allocated memory and unregister callbacks/d=
evices.
--

--- Patch [4]: [PATCH 4/6] LoongArch: KVM: implement vmid updating logic ---
commit e654984b1077924ffa92adca677721884f2ab85a
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: implement vmid updating logic
   =20
This commit separates the VMID calculation from the VPID logic for LoongArc=
h KVM.
It implements a per-physical-CPU VMID array for VMs to handle hardware with
cpu_has_guestid, and introduces functions to manage VMID allocation and wra=
pping.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3df46e02594f4..7b3661da89587 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
[ ... ]
> @@ -281,9 +281,33 @@ static void kvm_check_vcpuid(struct kvm_vcpu *vcpu)
>  	}
>  }
> =20
> -static void kvm_check_vmid(struct kvm_vcpu *vcpu)
> +static void kvm_update_vmid(struct kvm_vcpu *vcpu, int cpu)
[ ... ]
> +static void kvm_check_vmid(struct kvm_vcpu *vcpu)
> +{
> +	int cpu;
> +	unsigned long ver, old, vmid;
> +	struct kvm_context *context;
[ ... ]
> +	cpu =3D smp_processor_id();
> +	context =3D per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
> +
> +	/*
> +	 * Check if our vmid is of an older version
> +	 */
> +	ver =3D vcpu->kvm->arch.vmid[cpu] & ~vpid_mask;
> +	old =3D context->vmid_cache & ~vpid_mask;
> +	if (ver !=3D old) {
> +		kvm_update_vmid(vcpu, cpu);
> +		kvm_clear_request(KVM_REQ_TLB_FLUSH_GPA, vcpu);
> +	}

[Severity: Critical]
Does separating VMID from VPID break the KVM_REQ_TLB_FLUSH handling?

When the KVM core issues a remote TLB flush via kvm_flush_remote_tlbs(),
kvm_check_requests() handles this by setting vcpu->arch.vpid =3D 0 to force=
 a
new VPID.=20

However, this new logic only evaluates the VM's per-physical-CPU VMID array
(vcpu->kvm->arch.vmid[cpu]). Without checking if the VPID was cleared or
resetting the per-cpu VMID state, does this mean KVM will fail to refresh
the VMID and miss flushing the Stage-2 TLB when requested by the core?
This could allow guests to retain access to unmapped or repurposed host
memory during reclaim.

[Severity: High]
Is it safe to clear KVM_REQ_TLB_FLUSH_GPA based purely on a local
per-physical-CPU VMID update?

If a vCPU sets KVM_REQ_TLB_FLUSH_GPA on CPU A and gets preempted, it could
migrate to CPU B. This block would detect an older version, allocate a new
VMID on CPU B, and blindly clear the global per-vCPU KVM_REQ_TLB_FLUSH_GPA
request.

If the vCPU later migrates back to CPU A and reuses its valid old VMID
(since the VMID on CPU A hasn't wrapped), wouldn't the required GPA flush
on CPU A be missed because the request flag was already prematurely cleared
on CPU B?

> +
> +	vcpu->arch.vmid =3D vcpu->kvm->arch.vmid[cpu] & vpid_mask;
>  }
> =20
>  void kvm_check_vpid(struct kvm_vcpu *vcpu)
> @@ -400,6 +439,7 @@ static int kvm_loongarch_env_init(void)
>  	for_each_possible_cpu(cpu) {
>  		context =3D per_cpu_ptr(vmcs, cpu);
>  		context->vpid_cache =3D vpid_mask + 1;
> +		context->vmid_cache =3D vpid_mask + 1;
>  		context->last_vcpu =3D NULL;
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed that error paths during
initialization do not seem to clean up allocated structures or unregister
callbacks.

arch/loongarch/kvm/main.c:kvm_loongarch_env_init() {
    ...
    ret =3D kvm_loongarch_register_ipi_device();
    if (ret)
        return ret;
    ...
}

If a function like kvm_loongarch_register_ipi_device() returns an error,
the function returns directly without freeing vmcs or kvm_loongarch_ops,
and without calling kvm_unregister_perf_callbacks().

If the module load is aborted, does this leave perf_guest_cbs pointing to
unmapped memory, potentially causing a use-after-free kernel panic on the
next perf interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727072109.2151=
675-1-maobibo@loongson.cn?part=3D4
