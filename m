Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9983FF8B9
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805806; cv=none; b=tg52DdpEOkO4n9zYdyqiZ60WmFXSx27Rgy7Lk8za0Fbtto4LjvTeNpo+ljFnB01dQZoVzmcrJMTrn2ldkEP/nIa8e20Bsu1QzIsankLuhEzCPwIV9gjLislxyJuolGrXzJ0r6B0ElDv1u836k51HL4FmCRXZNoxaA2adbeIuVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805806; c=relaxed/simple;
	bh=YhgJdcYHqt3q1NQcFs0IKz+MjKG2AaaQjJl35HJ+Urc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e9qC3JW4k7Cey3WZqbExPfKcBxxZGb7bri/Rtpr3a5zCaeztyTQnEkOEvNhefiOE+476G0Ac6sMG0HTa6PcnZXziyCbejPbyvriWhy703g8ZMh+VywBT9ibM51mB6veed3PPP+/elx+ktnPNsvqU1CeR/4/GXLtRCbSmS5YJcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfb65XYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfb65XYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1EF1F00A3A;
	Tue, 26 May 2026 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805805;
	bh=er45Ws/9wIIh61VDuolK5Xc9kgenMTXmI9FoDVzxv90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nfb65XYfsnwTkXP9LiqF92xsAD1NchKV3yDhgCx3S2lLYaH+doSQ91rUWmT/cWrMf
	 xcyZ6HxZFCDkHsQ3bvvcatkG/Z/iGTIkSj/dDhVivSZdpb5mjQ2OhqwSj2I9cRvI0P
	 D8ZQGEoEqVAf4dRG3Dw5biyolIFW1V7ltBNs6DUVxzgVn2er6IcBsQ+UkQ/jLHcKwZ
	 +DvcMv1xAU2i9D1gyaB7L2D9nRGMf8lXv6o8Q1t/oK9jRybqdNB5AnWtincpI97wIk
	 gr1vz5Yl2IAT+543sfCsG+4VHraWYkZrwYZEnzEQdelEmBbKTYNAxBtV4wxo6OKYL+
	 bN8B0yz8Vl6kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] riscv: kexec: Build trampoline page tables for
 crash kernel entry
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526125009.2404-4-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-4-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:30:04 +0000
Message-Id: <20260526143004.CC1EF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Hardware Page Table Layout Violation on Sv32 (32-bit RISC-V)
- [High] Page Table Overwrite / Collision in riscv_kexec_build_tramp()

Pre-existing issues:
- [High] Privilege Escalation / W^X Protection Bypass via Missing Cleanup
--

commit 2f8fd9ee19b545626c02a8751eacf676c55f551a
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Build trampoline page tables for crash kernel entry

Crash kexec uses riscv_kexec_norelocate as a trampoline to jump into
the crashkernel. Add a small helper to build dedicated 4KB page tables
that map the trampoline page as executable.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 2306ce3e5f229..9b4b495e7c155 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -18,6 +18,65 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>

[ ... ]

> +static void map_tramp_page(p4d_t *p4ds, pud_t *puds, pmd_t *pmds, pte_t =
*ptes,
> +			   unsigned long va, unsigned long pa)
> +{
> +	pgd_t *pgd =3D (pgd_t *)kexec_tramp_pgd + pgd_index(va);
> +	pmd_t *pmd;
> +
> +	if (pgtable_l5_enabled) {

[ ... ]

> +	} else {
> +		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa_symbol(puds)), PAGE_TABLE));
> +	}
> +
> +	if (pgtable_l4_enabled) {

[ ... ]

> +	} else {
> +		pmd =3D (pmd_t *)puds + pmd_index(va);
> +	}
> +	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa_symbol(ptes)), PAGE_TABLE));
> +
> +	set_pte((pte_t *)ptes + pte_index(va),
> +		pfn_pte(PFN_DOWN(pa), PAGE_KERNEL_EXEC));
> +}

[Severity: Critical]
Does this construct an invalid 3-level page table hierarchy on 32-bit RISC-=
V?

On Sv32, the hardware MMU strictly expects a 2-level hierarchy (PGD -> PTE).
Because both pgtable_l5_enabled and pgtable_l4_enabled are false on 32-bit,
this code will set the PGD entry to point to puds, set puds[0] to point to
ptes, and finally populate ptes.

When the Sv32 hardware MMU walks this table, it expects the table pointed to
by PGD to be the leaf PTE table. If it reads puds[0], it will find a non-le=
af
PAGE_TABLE entry (RWX=3D0), which the hardware considers invalid, resulting=
 in
a fatal page fault.

> +static void riscv_kexec_build_tramp(unsigned long va, unsigned long pa)
> +{
> +	/* VA -> PA: map the trampoline page via its kernel VA. */
> +	map_tramp_page(kexec_tramp_p4d,  kexec_tramp_pud,
> +		       kexec_tramp_pmd,  kexec_tramp_pte,  va, pa);
> +
> +	/*
> +	 * PA -> PA: identity-map the same page so the second-pass code
> +	 * can keep executing after the kernel VA mapping is dropped.
> +	 */
> +	map_tramp_page(kexec_tramp_p4d2, kexec_tramp_pud2,
> +		       kexec_tramp_pmd2, kexec_tramp_pte2, pa, pa);
> +}

[Severity: High]
Can the second call to map_tramp_page() overwrite the PGD entry created by
the first call?

Both calls use the shared kexec_tramp_pgd root table. If va and pa happen
to share the same PGD index (for example, on Sv39 if pa >> 30 & 511 matches
va >> 30 & 511), the second call will replace the pointer to va's lower-lev=
el
tables with a pointer to the identity-map's lower-level tables.

Since the identity-map tables only contain valid entries for pa's indices,
attempting to execute from va after switching satp would result in a fatal
instruction page fault.

> @@ -73,6 +132,14 @@ machine_kexec_prepare(struct kimage *image)
> =20
>  		/* Mark the control page executable */
>  		set_memory_x((unsigned long) control_code_buffer, 1);

[Severity: High]
This is a pre-existing issue, but does this leak an executable page back to
the system allocator if the kexec load fails or is unloaded?

When preparing a non-crash kexec image, the control code page is marked
executable using set_memory_x(). However, if the user unloads the kexec
image via kexec -u, or if the load fails later, kimage_free() returns
this page to the buddy allocator.

Since machine_kexec_cleanup() is empty, the permissions are never reverted,
violating W^X protections and leaving a window for privilege escalation whe=
re
allocated memory can be executable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526125009.2404=
-1-fangyu.yu@linux.alibaba.com?part=3D3
