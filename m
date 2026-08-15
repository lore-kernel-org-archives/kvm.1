Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE92344DAE
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790878; cv=none; b=HappX3F3vqvJ6Vykd6/EzS7NMTlabTvm6lx9Jj+1POzZjOePbuyK/u5hZTRiS5WJ3vIY0VjeMjz2qIyxpyTKV+WXwSOLzeSh+vVbg79aNwUsW1YIj7qr+HQwY1A0zstTQ3Eh2r68ZYer/H7SeMCqM8bJewtLfDWV3fp7N29/aeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790878; c=relaxed/simple;
	bh=R6BkbsKdbaHGyXpefGsoTLw3B9uAplpLhs+InXr//KQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rFvX8Qw5m0rZhhQEjWC11S0FkcWaHg6NX9IODy0vY537HYT8sHBUiYuGTZ3srCPQaamuv+qjHax7g/iXDqsYDfIX3MsL63zcVzxPH4EclQrQrI6FS7U3iKIxzdjRN2TPMf6ibBM2JcUMu1YDRcN3HvPcI4FZ1SxYdJmXUHd5gQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRvlB+WA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRvlB+WA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E821F000E9;
	Sat, 15 Aug 2026 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786790877;
	bh=ROYC5NvxBdOnCuknqgzfKV+iunS8XkLuD9NR20BskSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRvlB+WAWhIk3FeBYusgVGLENC8wfLUb0HC6WvkGbjkYmo+o4Nkm39swoBheCNi3V
	 Olq3CrFRoBz0/fC7eQQFJoB+zEPt/dXCKHtGRVPM3Kaw6DhPbMthQ08EV3vvNse8Jp
	 /vaz4QT7Wc1j+F7/71cKSWoETToI+urMoJwCN6iueY9Mum+zIbHa/yxaPMTBOnwyYt
	 Ny0l3eR3fyQcYK6GvFRmLd0ub6fKl7bSg5Eat1EvaVQtG51C72SAVA1nJUX6XA4gql
	 ZSkP8CwWpAX4y7Dlb5i+xKNOf0pK/6kcw30rDLJ19Evzod09G5jaozZr6Kru4n11a2
	 y863xASbRHPcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] KVM: riscv: Implement
 KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260815103341.865013-1-jinyu.tang@linux.dev>
References: <20260815102833.864330-1-jinyu.tang@linux.dev>
 <20260815103341.865013-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 10:47:56 +0000
Message-Id: <20260815104756.D9E821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Modifying the HWPOISON path in `kvm_riscv_mmu_map()` to return=
 `-EFAULT` breaks standard `KVM_RUN` memory error handling.
- [High] Incorrect address and boundary calculation for `out_map.addr` caus=
es KVM to skip pre-faulting requested memory or underflow range calculation=
s.
--

--- Patch [3]: [PATCH v4 RESEND 3/5] KVM: riscv: Implement KVM_PRE_FAULT_ME=
MORY ---
commit 28eceecf0e650b3722970e6824e30848edb82b44
Author: Jinyu Tang <jinyu.tang@linux.dev>

KVM: riscv: Implement KVM_PRE_FAULT_MEMORY

The generic KVM_PRE_FAULT_MEMORY ioctl lets userspace populate KVM page
tables before running a vCPU over a GPA range. This commit implements the
arch hook for RISC-V and reuses the G-stage fault mapping path.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 54d45addf18f9..dff315dfd24ed 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -286,6 +286,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>  						    out_map->level, true);
>  		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) =
=3D=3D hpa) {
>  			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
> +			out_map->addr =3D ALIGN_DOWN(gpa, page_size);
> +			out_map->level =3D ptep_level;

[Severity: High]
When pre-faulting a range backed by THP, could aligning out_map->addr to the
huge page size while setting out_map->level to the existing leaf size (e.g.,
4KB) cause an underflow later?

If out_map->addr is aligned to a 2MB boundary in kvm_riscv_gstage_map_page(=
),
but the map_size is calculated using the 4KB level in=20
kvm_arch_vcpu_pre_fault_memory():

    map_size =3D PAGE_SIZE << (out_map.level * kvm_riscv_gstage_index_bits);
    end =3D out_map.addr + map_size;

The calculated end might be less than range->gpa. For example, if range->gpa
is (2MB_aligned_gpa + 8KB), then (end - range->gpa) would underflow to a
massive unsigned value, causing the ioctl to silently return range->size and
terminate early without actually pre-faulting the requested memory.

> +			out_map->pte =3D ptep_get(ptep);
>  			return 0;
>  		}
>  	}

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2fabcd4099919..f6ca86da53eb8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -717,7 +717,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>  	if (hfn =3D=3D KVM_PFN_ERR_HWPOISON) {
>  		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
>  				vma_pageshift, current);
> -		return 0;
> +		return -EFAULT;

[Severity: Critical]
Does returning -EFAULT here break the standard KVM_RUN memory error handlin=
g?

By returning -EFAULT instead of 0 for KVM_PFN_ERR_HWPOISON, KVM_RUN will ex=
it
to userspace with -EFAULT. Userspace VMMs (like QEMU) typically treat an
-EFAULT from KVM_RUN as an unrecoverable hypervisor error and will abruptly
terminate the VM.

Returning 0 allows the run loop to exit cleanly with -EINTR, ensuring the V=
MM
can handle the queued SIGBUS (via send_sig_mceerr()), isolate the poisoned
page, and inject a Machine Check Exception into the guest.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815102833.8643=
30-1-jinyu.tang@linux.dev?part=3D3
