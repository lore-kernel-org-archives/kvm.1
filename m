Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84F1A9F82
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631210; cv=none; b=oPqlVMI47CAA36fz4BZ+rixD6hnl0xjAJ+FWt8qcvdEDDI6YbIN6qRd6M/vHqcQgNtk7mNio4YQ4KOcEpqMWIPJLE3TAhQy+eIV635vaT1Zki4ABgxLlQmcfd72NpU2qahHx5lhn/3GsGhUFhqcyaKKuDgcc4iK2P5yAwi0XtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631210; c=relaxed/simple;
	bh=3pHkL/GdIWvwS4oMBti5jeZZlQbQ42DFIOyt3+ryHiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIBMVds6URt5F0c7HxSgLZxLgrW0xtKoXgDLN9AqCXrxQFJsxHsObNjk2iTEwu7zeHBjwP/RQ9uK5Rh5voNtOiiupqw/Kf95+5g+wMrLrnRBeL+eyAXQYkTfjlj6WX+1pp7P/8u1eygMVoIjRVU1XN6yUW9xKgk2s3Zijq4eNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWDrg7iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWDrg7iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98481F000E9;
	Thu,  9 Jul 2026 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631208;
	bh=V494gd/2/FvIuYq5Sg4/oSG1X/eD7Pu7GnD9ePZm7Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWDrg7iVMEQahKCpPG+XMhmhOz3IFSCYb2TnDYplBizULIBL75sLUUAMYrvhNXLqJ
	 srTx7tNfn+LUC6laNFBY077jlF5tmhYpw977/El1hpEYaBMJI7FgaiZvDKO5SyTZiR
	 H92btWRcXF1wdxjErrd2pT3gwzkm92IeldI8tePJ/wN4pXdLpDAENxBKVHM8sAPi9x
	 dWNxmR9LahqCipLKGlGJ4YgpAWxtkaUixZdBedzSPf9PHPOGrpzTDg7TThfWkb2WJH
	 MYn+F2T5il5qcltVcxXqm3xfN/NwPL3ZGOAGfu+N7GoGK3/YqvYDuFCZO7ID/uPzuJ
	 ZVTHx7hNk9N6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/18] KVM: SEV: Forcefully invalidate SNP VMSA if
 its backing gmem page is zapped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-11-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:06:47 +0000
Message-Id: <20260709210648.B98481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The guest_memfd invalidation flow fails to synchronously wait =
for vCPUs to exit guest mode before allowing the host to free the VMSA page=
, resulting in RMPUPDATE FAIL_INUSE hardware errors and a host kernel panic.
--

--- Patch [10]: [PATCH v4 10/18] KVM: SEV: Forcefully invalidate SNP VMSA i=
f its backing gmem page is zapped ---
commit ceb579c141d8889038624fb707ecde51b8427194
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped

This commit wires up a gmem_invalidate_range() call for SNP VMs, forcing
vCPUs to reload their VMSA if the backing guest_memfd page is invalidated
(e.g., via PUNCH_HOLE).

Link: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_=
file *f, pgoff_t start,
>  		}
> =20
>  		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> +#endif
>  	}
> =20
>  	if (flush)

[Severity: Critical]
Does this invalidation path need a way to guarantee a synchronous wait befo=
re
returning?

Since VMSA pages typically do not have TDP MMU SPTEs,
kvm_mmu_unmap_gfn_range() will return false, leaving flush as false.

Because flush remains false, the subsequent kvm_flush_remote_tlbs(kvm) call
is skipped.

Meanwhile, sev_gmem_invalidate_range() relies on KVM_REQ_VMSA_PAGE_RELOAD
and kvm_make_request_and_kick() to send an asynchronous IPI to the vCPU:

arch/x86/kvm/svm/sev.c:sev_gmem_invalidate_range() {
    ...
    kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
    ...
}

Because the IPI is asynchronous and the TLB flush (which would otherwise
provide a synchronous wait) is skipped, the host could proceed to free the
VMSA page before the vCPU actually drops it and exits guest mode.

Could this lead to the very RMPUPDATE FAIL_INUSE hardware error and host
kernel panic that the commit is trying to resolve, if a host userspace
process issues fallocate(PUNCH_HOLE) on the guest_memfd region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D10
