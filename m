Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB182DCBFA
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047955; cv=none; b=dZxsSvApoGP6++XnDw4e9bet+f5S1fAMnXhasssRpKAoY5b+vHCMSnOcqAQt/zTzd3qz5rkeCEduBTB2uAXXomlv0x2piwewZPVelPvsMQ4CDBS4yS2zSd2w1GoqPRDYLAzO+eM4m5jwXz88fI3t6vPuNUP1pN3RvF3ShqZy4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047955; c=relaxed/simple;
	bh=yxEe/yg72SiY39VdiQF9CD6J7eFwUUZlrBTTTBTidIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K00wE4zs262iwdL17aEAK6qyCZfdFTQJ6zwDKpMvZBn8ltlHxpxpbqfVVTC/GwkdV1xMxHrVqqXbo7++OE/xmv8MQ8cUjja2Hsc4olZJvNg4KqXelX8VZpZovfAQ3UN35aOvTKT1NGn9E3ZXINPrpSvvxKLG2StpCAt0Wwhjn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrTjhKNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrTjhKNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A41F000FF;
	Thu, 10 Sep 2026 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047954;
	bh=zTFE8sXrAVhcR0uoUrXomQMFgqmyL57P6ohx43ngYxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GrTjhKNG5gBkE53GWO5kvzwkw7U1fX+VGUmA6hxD4mFCI4rqFploSsoODtKPsb1yS
	 ZGvslqojcdKCgIK8NvLefHzjTa08Qc0/Tlk0ObQjPQUCGGGx0W9KcCpf4jByE5NdAF
	 BRxwpZO6HKSY5JVxBsOw5BqNwwz32BPcDdvukMpBT1F/NlHpl8muo/C26V9vOTfSVZ
	 ZoXOBHtpHY7bOQfVe5ZaEJ4F2wpOV0XXbeBG+gvcksPoXtYoT29FhMR6J2kr9c9DGZ
	 CvIyo5inFsZI2qDLSkpjsB3BSbeeAmkT7HyXp8lveAsJ45bmAF/lOJVPR/bHywkU/K
	 0bj8RGUAfeYkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Avoid synchronous IPIs on VMID rollover
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenlong Li" <wenlongli486@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910133300.956555-1-wenlongli486@gmail.com>
References: <20260910133300.956555-1-wenlongli486@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:45:53 +0000
Message-Id: <20260910134554.257A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Packing generation and VMID into `atomic_long_t` truncates the=
 generation counter on 32-bit platforms, introducing a rapid ABA vulnerabil=
ity.

Pre-existing issues:
- [Critical] VMID generation counter wraparound to 0 causes new VMs to shar=
e reserved hardware VMID 0, breaking cross-VM isolation.
--

commit 41c24296ddc6bb7cc33a83183e982b0c76bf449d
Author: Wenlong Li <wenlongli486@gmail.com>

RISC-V: KVM: Avoid synchronous IPIs on VMID rollover

Make VMID rollover lazy to remove cross-CPU synchronization and avoid
synchronous IPIs. Track active and reserved software VMIDs for each possible
CPU, preserving hardware VMIDs with stale translations, and deferring TLB
flushes until the CPU next activates a VMID.

> diff --git a/arch/riscv/include/asm/kvm_vmid.h b/arch/riscv/include/asm/k=
vm_vmid.h
> index db61b0525a8d0..78811ab7dba07 100644
> --- a/arch/riscv/include/asm/kvm_vmid.h
> +++ b/arch/riscv/include/asm/kvm_vmid.h
> @@ -6,21 +6,39 @@
>  #ifndef __RISCV_KVM_VMID_H_
>  #define __RISCV_KVM_VMID_H_
> =20
> +#include <linux/atomic.h>
>  #include <linux/kvm_types.h>
> =20
>  struct kvm_vmid {
>  	/*
> -	 * Writes to vmid_version and vmid happen with vmid_lock held
> -	 * whereas reads happen without any lock held.
> +	 * Software VMID:
> +	 *
> +	 *   [ generation | hardware VMID ]
> +	 *
> +	 * Only the low hardware VMID bits may be written to HGATP
> +	 * or used as a hardware fence VMID.
>  	 */
> -	unsigned long vmid_version;
> -	unsigned long vmid;
> +	atomic_long_t id;
>  };

[Severity: Critical]
Does packing the generation and VMID into a single atomic_long_t truncate
the generation counter on 32-bit platforms, causing a rapid ABA regression?

On RV32 platforms, atomic_long_t is only 32 bits. Reserving the lower bits
for the hardware VMID restricts the available bits for the generation
counter significantly.

Can a dormant VM sleep while an unprivileged guest forces rapid VMID
rollovers, causing the counter to wrap in roughly an hour? If the dormant
VM wakes up with a perfectly matching old generation, it could bypass
allocation and reuse its old hardware VMID that might already belong to
another active VM.

Should this use atomic64_t to prevent this rapid wraparound?

> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index c15bdb1dd8bef..05819e4f7cb57 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
[ ... ]
>  int kvm_riscv_gstage_vmid_init(struct kvm *kvm)
>  {
> -	/* Mark the initial VMID and VMID version invalid */
> -	kvm->arch.vmid.vmid_version =3D 0;
> -	kvm->arch.vmid.vmid =3D 0;
> +	atomic_long_set(&kvm->arch.vmid.id, 0);
> =20
>  	return 0;
>  }

[Severity: Critical]
This is a pre-existing issue, but does initializing the VM id to 0 in
kvm_riscv_gstage_vmid_init() cause collisions when the global generation
counter eventually wraps around to exactly 0?

When vmid_generation wraps to 0 in new_vmid_locked():

    generation =3D atomic_long_add_return(VMID_FIRST_VERSION,
                                        &vmid_generation);

The vmid_gen_match() check will evaluate to true for any newly created VM
because its id was initialized to 0:

    static bool vmid_gen_match(unsigned long vmid)
    {
        return !((vmid ^ atomic_long_read(&vmid_generation)) >> vmid_bits);
    }

This causes kvm_riscv_gstage_vmid_update() to skip the slow path allocation:

    if (!vmid_gen_match(vmid)) {
        vmid =3D new_vmid_locked(kvm_vmid);
        atomic_long_set(&kvm_vmid->id, vmid);
        vmid_changed =3D true;
    }

Will this result in multiple new VMs sharing the reserved hardware VMID 0
and inadvertently bypassing Stage-2 memory isolation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910133300.9565=
55-1-wenlongli486@gmail.com?part=3D1
