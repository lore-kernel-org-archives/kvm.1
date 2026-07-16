Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AC34574B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184879; cv=none; b=QuLdbQygLERmZLUBA5lnER5oZVFExEUcFzhc2c1kdygwJNhXAJHmBieXVUoOCE8u+u2iR8BBxEU+bjO4PkRrrUELRunyn3y+Mm6FHIVMDhbrd85+DhG910KCjcQP7jSLocBjRjn9wCEGmhw7SZNHFjt5CfAESKTPtEQVQ1XDVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184879; c=relaxed/simple;
	bh=uqW1ISkemJR21Z0Tg35aXogGY1XrzMFnDRlJRoZZCEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=goHFpSSRoYxiAqYrGEB90WxRCiyWQmmRF2EFJcXJOkDO2L8rHFEr4V8zaU2iHYN4j93vxgbCyHoj4vy9Wn4ZDF36a+qxXTicWv7q0/2JgJXAvHKeqcnr2br3m6nDQAQ3w0eCbYMmMWfVGRHCSrLdezhBvqW1e/DYwyFZzu1neWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4QTCJie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4QTCJie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDCB1F000E9;
	Thu, 16 Jul 2026 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784184877;
	bh=sAFAgWFPEdA5XzbFyA3CHpMglJ/pZDKGKSKbacbE1Vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4QTCJieSCJ3km4fOTmJbUPrwMOSeOmoys2ffOkfr6HvhtDEhNB5bf6kMEb3J5fhS
	 Js0jYR7sDdMF37CELSP0rQ21SqJZegYkbGjImFIy1Slrt58RyYYK6JvkAzZQjzPDZa
	 TUdAs2hMe8LimAr7ckFM23gJNI7QmzH3YI+7ueB9tuyFSipbYEdUaiy9q0vWGj/G6i
	 lCGIrd0+sz/S8eblZkFfcGtk1ZuyEVJdDFGVv/ZXwZygbM97HSeLqE3C7UIcpYrtuS
	 26q2LrldxYRFeUeZdpAn1YQEXR2/HilSRhsieBN5bKEq/zBTejGz7U6yEYTfYQLhex
	 zrVWdl35QPYtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Account VM-scoped allocations to the VM
 cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: yhchen312@gmail.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716064112.2387938-1-yhchen312@gmail.com>
References: <20260716064112.2387938-1-yhchen312@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 06:54:37 +0000
Message-Id: <20260716065437.ADDCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `kvpmu->sdata` allocation uses `GFP_ATOMIC | __GFP_ACCOUNT` =
in a context that can safely sleep, draining atomic reserves and causing sp=
urious memcg allocation failures.

Pre-existing issues:
- [High] Unconditional memory allocation for the PMU snapshot area leads to=
 a memory leak if the guest repeatedly configures the snapshot.
--

--- Patch [1]: [PATCH] RISC-V: KVM: Account VM-scoped allocations to the VM=
 cgroup ---
commit 7f2fdf55e4a9227b8c7e4853c498204f0c3f9d48
Author: Yuhang.chen <yhchen312@gmail.com>

RISC-V: KVM: Account VM-scoped allocations to the VM cgroup

Charge the per-VM and per-vCPU allocations (stage-2 PGD, APLIC state,
IMSIC context, vector context, FWFT config, PMU snapshot) to the
allocating process's memory cgroup via GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24da..e5018784779d5 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -452,7 +452,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_=
vcpu *vcpu, unsigned long s
>  		}
>  	}
> =20
> -	kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> +	kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT=
);

[Severity: High]
This isn't a bug introduced by this patch, but does this leak memory if the
guest repeatedly configures the snapshot?

If a guest makes multiple SBI_EXT_PMU_SNAPSHOT_SET_SHMEM calls, it looks
like this unconditionally allocates and overwrites kvpmu->sdata without
freeing the previous allocation.

[Severity: Medium]
Is it necessary to use GFP_ATOMIC here?

Since the immediate next call is kvm_vcpu_write_guest(), which can sleep:

	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does =
it internally */
	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
		kfree(kvpmu->sdata);
		kvpmu->sdata =3D NULL;
		sbiret =3D SBI_ERR_INVALID_ADDRESS;
		goto out;
	}

it seems this allocation could safely use GFP_KERNEL_ACCOUNT instead.

Combining __GFP_ACCOUNT with GFP_ATOMIC prevents the allocation from sleepi=
ng
to perform direct reclaim, which might cause spurious memcg allocation
failures when the cgroup is under pressure.

>  	if (!kvpmu->sdata) {
>  		sbiret =3D SBI_ERR_FAILURE;
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716064112.2387=
938-1-yhchen312@gmail.com?part=3D1
