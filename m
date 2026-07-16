Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4833A70A
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226843; cv=none; b=ik4Ndldc1OSb95GNx5EMAZA5FmpnONUJvVjBkNaZS1Znftr9Z1OjImMxha0Nl/dWw+pGlfbo4TlQnx2Ay9463QkqzbWVOEgbT4rjb5dNKaavkS5onN79DVpReglLgEDI0Kmc3NbTjsFu+YeUoAxemDSmhWMKzxuQCOHocftM2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226843; c=relaxed/simple;
	bh=FFpMG/rDCidIRN055/Rtf8V6gtQ0YZKP9niJYH43lfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sUNqScFv3NR9DG5f7fqNUYnsll1n686AM5nhIfx449AJqPej862sEP/jJkr51XQpa5r/IYGrGYZJmRPIwGeeEHgG7NRBlAveH82+N78jc5UZuIH/7wOZt8IOLNEQmpIIPylxa74KhEP6kuqL7o5lsajTd8qS0etF2PVluLsIeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQVGDdW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQVGDdW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44011F000E9;
	Thu, 16 Jul 2026 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226842;
	bh=E+INEKnz3odl2ONEc6vVvAkmCv0cDbhHusxV0O2MM1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQVGDdW118/zUYjSX8W21IeTnwV90pg+BI8uuGvrwyqJQCKK5XqcITKH2h+A2q2cf
	 Iy1z6NOjDtzSVy5bvQFbzxrpisD+KfOUnZAEkyTAHcSjU5eg6U6t4R6SyfhlXTq+VH
	 LtSdF7irkwFDTrqreMzHYi5KWiAh8TU1eKzUFRbip3ZgRqciFGTY0npCx8r1xLUNtp
	 VbuuIB+O6sRpeOlu+9DATOMttMXJFvHx7/pM2HjR2gGlNPumaC47PilHcMRniOjg3n
	 ONI1PJ57a7QGmyjf2bh8KZqGIY7Ge7P/ERjRrj7olVuExDZyuBIz4U1Tl1kNBJbooZ
	 4HvTseuL+0qbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/24] KVM: Define and communicate KVM_EXIT_MEMORY_FAULT
 RWX flags to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-3-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:34:01 +0000
Message-Id: <20260716183401.D44011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly introduced KVM_MEMORY_EXIT_FLAG_* UAPI flags are not sync=
ed to the tools/ directory.

Pre-existing issues:
- [High] ARM64 page fault handlers incorrectly report guest_memfd memory fa=
ults as shared by passing `is_private=3Dfalse` to `kvm_prepare_memory_fault=
_exit`.
--

--- Patch [2]: [PATCH 02/24] KVM: Define and communicate KVM_EXIT_MEMORY_FA=
ULT RWX flags to userspace ---
commit 2373c31f86321f944cc2fad5b744fcd833b349a9
Author: Anish Moorthy <amoorthy@google.com>

KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace

kvm_prepare_memory_fault_exit() already takes parameters describing the
RWX-ness of the relevant access but doesn't actually do anything with
them. Define and use the flags necessary to pass this information on to
userspace.

Link: https://lore.kernel.org/kvm/ZR4N8cwzTMDanPUY@google.com/

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ab8cfaec82d31..2278b17f2f289 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -2519,8 +2519,15 @@ static inline void kvm_prepare_memory_fault_exit(s=
truct kvm_vcpu *vcpu,
>  	vcpu->run->memory_fault.gpa =3D gpa;
>  	vcpu->run->memory_fault.size =3D size;
> =20
> -	/* RWX flags are not (yet) defined or communicated to userspace. */
>  	vcpu->run->memory_fault.flags =3D 0;
> +
> +	if (is_write)
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_WRITE;
> +	else if (is_exec)
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_EXEC;
> +	else
> +		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_READ;
> +
>  	if (is_private)
>  		vcpu->run->memory_fault.flags |=3D KVM_MEMORY_EXIT_FLAG_PRIVATE;

[Severity: High]
This isn't a regression introduced by this patch, but does the ARM64 code
pass the incorrect is_private value for guest_memfd faults?

Looking at arch/arm64/kvm/mmu.c:gmem_abort(), KVM calls this with false for
a failure originating from kvm_gmem_get_pfn() on a private memory slot:

		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
					      write_fault, exec_fault, false);

Similarly in arch/arm64/kvm/nested.c:kvm_translate_vncr():

			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
					      write_fault, false, false);

Will this cause userspace to receive a KVM_EXIT_MEMORY_FAULT for a private
memory access with the KVM_MEMORY_EXIT_FLAG_PRIVATE bit incorrectly cleared?

>  }
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8e..720b1ffe880b2 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -457,6 +457,9 @@ struct kvm_run {
>  		} notify;
>  		/* KVM_EXIT_MEMORY_FAULT */
>  		struct {
> +#define KVM_MEMORY_EXIT_FLAG_READ       (1ULL << 0)
> +#define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
> +#define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)

[Severity: Low]
Are these new flags missing from tools/include/uapi/linux/kvm.h?

Could this regression cause compilation errors or missing macros for tools
that rely on the in-tree tools/ copy of the UAPI headers?

>  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
>  			__u64 flags;
>  			__u64 gpa;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D2
