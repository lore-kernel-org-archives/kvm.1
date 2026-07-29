Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D54219E7
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309920; cv=none; b=gyf31Shp3hps1mPtqFXi9jLyIzY9Bq4DVgEbllSuH0ZUX9T9eXv1ez9oyFiFX9ndvCV70aK5t4CjT5pTeCTJIaWrVyT1rZtrRkv8USEkPLfuEpU/PCUi6u3PX9Kb9DlIqX7v7CmoTdCbnz8hkFdWiw+4SBhr80KM77rYAs5+WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309920; c=relaxed/simple;
	bh=4yMr1WNrxCKeMQRKePT2vZ4YmbMQ7ccyNmsSbhlbMiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ybv6Xfi5KB47jKyA/dihAexoD6I4UQh6bGuOLlvzS+Wgw0SCU6tsOt5Fv8w8tl/8dlxa4fxU9ROFon+dYsb+t0UmjSZ1YN0M2QLswYFDa6WA7mxMvzSkLW7aAnGO5uiLrTO78mPJa3fWiZ9QWc0btrmz0WUCS125Grd4kQSAVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jc97VujL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc97VujL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75291F00A3D;
	Wed, 29 Jul 2026 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785309911;
	bh=ZFQPR1HGlpU8OKhu9CPYQle6gFUF4l+UhmvMvEYk7Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jc97VujLd1o+Kxqojf1wWRlf5jZP8JiYa6un0OdDUJBsw7WpZvD5ekrAFQThRU00X
	 7sWawP2q5deqmvLFbHpqNxQkqvTJ5nEfwK7n6yBNevVJW8zkGw92R+xoCO1XkBE7L4
	 kzypupSb39ZjBpRTntdtAcCfjABLw6+aYWadREwAwzQ1kvzfFe34xCZsjo+r6K87gy
	 cA7iCku2KxYsrv+g8YHXIa14v9KAXJ3C1aa8ESB98JkqhXCbmaUPTR/uCGzxU6VoDS
	 j5p9+9mamHh75BeR21gNIqBS/kCyUvD2zbtCiWV9tI9jknUBO9hyGxQu7dGgg7c60G
	 s+N43cAoxu4Zg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] RISC-V: KVM: Enable KVM_MEM_USERFAULT support
Reply-To: sashiko-reviews@lists.linux.dev
To: Bingyu.Xian <shanbeeyoo@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729070843.730578-1-shanbeeyoo@gmail.com>
References: <20260729070843.730578-1-shanbeeyoo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 07:25:10 +0000
Message-Id: <20260729072510.D75291F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gstage_page_fault() returns 0 instead of -EFAULT when preparing KV=
M_EXIT_MEMORY_FAULT, causing ioctl(KVM_RUN) to return 0.
- [High] kvm_prepare_memory_fault_exit() is called with an unaligned guest =
physical address alongside a PAGE_SIZE length.
- [Low] Mixed declaration and code when declaring the `userfault` variable.
--

--- Patch [1]: [RFC PATCH] RISC-V: KVM: Enable KVM_MEM_USERFAULT support ---
commit 087f35f3e3961e5845e830a76559e809fe2e2d57
Author: Bingyu.Xian <shanbeeyoo@gmail.com>

RISC-V: KVM: Enable KVM_MEM_USERFAULT support

This commit adds support for KVM_MEM_USERFAULT on RISC-V to handle post-copy
live migration via userfaultfd. It forces PAGE_SIZE mappings and checks the
userfault bitmap in gstage_page_fault().

Link: https://lore.kernel.org/kvm/20260618205753.2600064-1-jthoughton@googl=
e.com/

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..766f820c27a73 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -583,7 +583,9 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>  	else
>  		vma_pageshift =3D PAGE_SHIFT;
>  	vma_pagesize =3D 1ULL << vma_pageshift;
> -	if (logging || (vma->vm_flags & VM_PFNMAP))
> +	bool userfault =3D !!(memslot->flags & KVM_MEM_USERFAULT);
> +

[Severity: Low]
Is there a mixed declaration and code warning introduced here?

In kvm_riscv_mmu_map(), placing the declaration of userfault after the
executable statement vma_pagesize =3D 1ULL << vma_pageshift; violates the
standard kernel coding style.

Could we move the declaration to the beginning of the block?

>  	if (logging || userfault || (vma->vm_flags & VM_PFNMAP))
>  		vma_pagesize =3D PAGE_SIZE;

[ ... ]

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29ed..31fb0b937afcc 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -62,6 +62,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, st=
ruct kvm_run *run,
>  		};
>  	}
> =20
> +	if (kvm_slot_userfault_fault(memslot, gfn)) {
> +		kvm_prepare_memory_fault_exit(vcpu, fault_addr, PAGE_SIZE,

[Severity: High]
Are we passing an unaligned guest physical address to
kvm_prepare_memory_fault_exit() here?

The KVM ABI defines the memory fault payload as a region [gpa, gpa + size)
that requires userspace resolution. The fault_addr variable is derived from
the stval register and may be an unaligned byte-granular address.

If fault_addr is unaligned (e.g., 0x1004) and paired with PAGE_SIZE, does it
cause the reported range [0x1004, 0x2004) to erroneously span across two
separate guest pages?

Could this cause the VMM to attempt out-of-bounds or redundant page
resolutions for the adjacent page, leading to migration failures?

> +					trap->scause =3D=3D EXC_STORE_GUEST_PAGE_FAULT,
> +					trap->scause =3D=3D EXC_INST_GUEST_PAGE_FAULT, false);
> +		return 0;

[Severity: High]
Should this path return -EFAULT instead of 0?

KVM API documentation requires that KVM_EXIT_MEMORY_FAULT be accompanied by=
 a
-1 return code from the KVM_RUN ioctl, with errno set to EFAULT (or
EHWPOISON).

By returning 0 here in gstage_page_fault(), does kvm_riscv_vcpu_exit()
propagate 0 (success) back to the ioctl handler, and ultimately to userspac=
e?

If the ioctl returns 0, will userspace VMMs like QEMU fail to recognize the
memory fault exit, fall through to the default unhandled exit handler, and
abort the VM?

> +	}
> +
>  	ret =3D kvm_riscv_mmu_map(vcpu, memslot, fault_addr, hva,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729070843.7305=
78-1-shanbeeyoo@gmail.com?part=3D1
