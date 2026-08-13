Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6A3FDC18
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615386; cv=none; b=Vcn3rdGLEfkFe0Vod8wjImTkN2foji9/43HuzdmHb6oofpLuzF5+re+TACjqQt7WC1JD+xn+EiA6ydThq2CcQ0u9toPw5nwr4oMYP5YmpHgne0THyPXIBfeoIFVcPHUX5JZvnaHsVzztXDLZa9Q0mpShL36qfPs8b7MvkRw1uKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615386; c=relaxed/simple;
	bh=3EFTB40/tjnJYr2saDHNvQFwnvxyUzB59gImaiZ1zjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2sjChCKRG6uvZeunm3KX7Ho0k+KGjxi2s/Es+vEbKV6M2/8PAljtIkyDP0cdmT0b4jPBT7tsW6TLolloUVYy6uYOIEMZp2RnriYuUplD5m+JA+YwPDDSp4+ITX8ggtM0xFxnn44IyOj5HT7sLObWlZSDk0c/NUPaC7olWvmqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvDhWOIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvDhWOIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426951F000E9;
	Thu, 13 Aug 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615385;
	bh=wj9TRtvTqqCoAuWezavRO2qgDG0HB/oBvtD3B8U8rYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvDhWOIR819BlqFLTrh3qjuR7VHdvoo9m1sSVD4FtkQOGWHHmeNOpYbcA1PGf98Sl
	 uihfbM9gcXBtRqg8PdaNOXValtowE6Bg1RuXslEVrG2RoiiZd2qaFbN37vlkiGjLm6
	 QdnqC+3w1BwEuA++Mi+1JOjqzAx6sP1ZDB8/+E+DMP8F4XWHfEJ6AhydpMPhJy/kXn
	 +YDD4CfmBl3bR/4Jwg0D/tdPWg/WEzA0WRkyAslv4p2egnjiw3zpTPCPxHa7+gurnM
	 PkdTgpZiu4VujV+mfVjUZ6vt9/i7zmN+taf0EYHe4ACJur0AHfOnNBdAlk5YL4XTWK
	 l9faeXymub23Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] KVM: PPC: Book3S HV: Maintain aggregate context
 switch values for vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260813094535.10083-2-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-2-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:03:04 +0000
Message-Id: <20260813100305.426951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch breaks task-bound VPA PMU events by subtracting independ=
ent VCPU aggregates, leading to severe underflows.

Pre-existing issues:
- [Critical] Pre-existing Use-After-Free (UAF) and cross-VM data leak via s=
tale `kvm_hstate.kvm_vcpu` pointer in VPA PMU callbacks.
--

--- Patch [1]: [PATCH v2 1/3] KVM: PPC: Book3S HV: Maintain aggregate conte=
xt switch values for vCPUs ---
commit b8e49dde6d70a4c423cf40d03275e97149e3916e
Author: Gautam Menghani <gautam@linux.ibm.com>

KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs

This commit changes the vCPU context switch latency variables in vcpu->arch
to store aggregate values rather than the latest snapshots read from PACA.
The goal is to provide each vCPU with its own record of total context
switch latencies for the vpa-pmu driver.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..342168b8bfc86 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4163,12 +4163,12 @@ static void do_trace_nested_cs_time(struct kvm_vc=
pu *vcpu)
>  	trace_kvmppc_vcpu_stats(vcpu, l1_to_l2_ns - *l1_to_l2_cs_ptr,
>  					l2_to_l1_ns - *l2_to_l1_cs_ptr,
>  					l2_runtime_ns - *l2_runtime_agg_ptr);
> +	vcpu->arch.l1_to_l2_cs +=3D (l1_to_l2_ns - *l1_to_l2_cs_ptr);
> +	vcpu->arch.l2_to_l1_cs +=3D (l2_to_l1_ns - *l2_to_l1_cs_ptr);
> +	vcpu->arch.l2_runtime_agg +=3D (l2_runtime_ns - *l2_runtime_agg_ptr);

[Severity: Critical]
This is a pre-existing issue, but does relying on kvm_hstate.kvm_vcpu expose
a use-after-free and cross-VM data leak here?

When a task-bound VPA PMU event schedules in, vpa_pmu_add() calls into KVM
which reads the vCPU from the physical CPU's PACA:

arch/powerpc/kvm/book3s_hv.c:kvmhv_get_l1_to_l2_cs_time_vcpu() {
    ...
    vcpu =3D local_paca->kvm_hstate.kvm_vcpu;
    if (vcpu) {
        arch =3D &vcpu->arch;
        return arch->l1_to_l2_cs;
    ...
}

Since local_paca->kvm_hstate.kvm_vcpu is set during guest entry in
kvmhv_run_single_vcpu() but never cleared on exit, it remains pointing to
the last vCPU that executed on this physical CPU.

If that vCPU belonged to a different VM, its context switch data is leaked.
If the VM was destroyed, wouldn't this dereference a freed vCPU pointer?

[Severity: High]
Will changing these fields to accumulate independent aggregates cause massi=
ve
underflows in the PMU driver?

Before this patch, these fields stored a snapshot of the global monotonic
timer. Now they store independent per-vCPU aggregates.

Because of the stale local_paca pointer issue mentioned above, vpa_pmu_add()
records the previous vCPU's aggregate as the starting baseline:

arch/powerpc/perf/vpa-pmu.c:vpa_pmu_add() {
    ...
    data =3D get_counter_data(event);
    local64_set(&event->hw.prev_count, data);
    ...
}

Later, vpa_pmu_read() subtracts this from the current vCPU's aggregate:

arch/powerpc/perf/vpa-pmu.c:vpa_pmu_read() {
    ...
    final_data =3D new_data - prev_data;
    local64_add(final_data, &event->count);
}

Since new_data and prev_data are now completely unrelated aggregates from
different vCPUs rather than two points on a shared global timeline, won't
this subtraction produce garbage values and severe underflows?

>  	*l1_to_l2_cs_ptr =3D l1_to_l2_ns;
>  	*l2_to_l1_cs_ptr =3D l2_to_l1_ns;
>  	*l2_runtime_agg_ptr =3D l2_runtime_ns;
> -	vcpu->arch.l1_to_l2_cs =3D l1_to_l2_ns;
> -	vcpu->arch.l2_to_l1_cs =3D l2_to_l1_ns;
> -	vcpu->arch.l2_runtime_agg =3D l2_runtime_ns;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813094535.1008=
3-1-gautam@linux.ibm.com?part=3D1
