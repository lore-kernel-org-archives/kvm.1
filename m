Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C613B7AE
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779643998; cv=none; b=kZThpK2JriTKaf1fDQhFJ1cwdtsTPvVT2Nf+qa8MmVUE3Hgw0o0gNnjLgtl4cruDQvDq0M547VdHHuG+YY62WO7ZfESAbTd2kk1WOFC1y8pSCqHWbv+9MQq3o1vWgW7tjx7IrBBtUcKtJEXcx29trXNcK6nb3IAm3mcjUBnH01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779643998; c=relaxed/simple;
	bh=BLAO65E5sUHD3oMYset0eVZSG5zNY86O8cnJAzi0+rI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQOyclwI3yhOWoBX5/KtmHUgx+dJvK8lnKChkiTGCRV4pW3sco2REuZn49PVT8yltgKA3n3lKEwzIuDCStv2sIX3c9ZtlO+IGJ/1UW66eHVN+a8TH5SfpkJSw1LFd4U353Be83JLRNfEoRExqwGKm1q/XMFztuia4XJyucR4Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX2gV4te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX2gV4te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FA1F000E9;
	Sun, 24 May 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779643997;
	bh=1uiSYGYQm+x3bonDtzeLrQAN5D5FTgrMKvYOJi5hSNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MX2gV4teLGwkXlZ6gdOwv1aXJf8OKvkiDPJqyX9f2Q1gmuQ/GkZ9QVMQq5Aru4tgJ
	 AnLxAZIqjFaDWet0VRS/VLI7CUEDp8HKwODNS0sSh8YOJOH156CBRnI3Uvgr/ckCjv
	 OOLWhvhhh8L8fdH+0QYiq9XsZfsxH5CdE51WwQ9SKzX3RooVltj/vPsmKDKHYBvzGN
	 tHO0IzHlIQrNPe7GtdnfCHXAvruXu9BskzqCR+LWe5T67dToTicgPG4V1eDMEmCgq4
	 FeAPMiGFlz7bC8ubZXjYrrFAqzwtrx1sk5tlhPhbLM2NuRx/oJ7xefl9hSDZGdQuij
	 sYSpdxsPQcpsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] RISC-V: KVM: AIA: Make HGEI number management
 fully per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260524162009.2602535-3-anup.patel@oss.qualcomm.com>
References: <20260524162009.2602535-3-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 17:33:16 +0000
Message-Id: <20260524173317.5F8FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The global `kvm_riscv_aia_nr_hgei` fails to compute the minimum nu=
mber of HGEI lines across all HARTs as claimed, leading to potential VM cra=
shes on heterogeneous systems.
- [High] Dynamic re-initialization of `hgctrl->lock` and `free_bitmap` in `=
kvm_riscv_aia_enable()` introduces lock corruption and resource races durin=
g CPU hotplug.
--

commit 9793b8a8f6852f288109f4a89da48941361d7e97
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

This commit transitions the KVM AIA Hypervisor Guest External Interrupt (HG=
EI)
number management from a global variable to a per-CPU field. It aims to bet=
ter
support heterogeneous RISC-V SoCs where different cores might expose differ=
ent
HGEIE CSR widths. The per-CPU supported HGEI count is probed in
kvm_riscv_aia_enable() during CPU enablement.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555d..a7a102ad9c16a 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c

[ ... ]

> @@ -529,25 +513,48 @@ static int aia_hgei_init(void)
>  void kvm_riscv_aia_enable(void)
>  {
> +	const struct imsic_global_config *gc;
> +	const struct imsic_local_config *lc;
> +	struct aia_hgei_control *hgctrl;
> +
>  	if (!kvm_riscv_aia_available())
>  		return;
> =20
> +	gc =3D imsic_get_global_config();
> +	lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
> +	hgctrl =3D this_cpu_ptr(&aia_hgei);
> +
> +	/* Figure-out number of bits in HGEIE */
> +	csr_write(CSR_HGEIE, -1UL);
> +	hgctrl->nr_hgei =3D fls_long(csr_read(CSR_HGEIE));
> +	csr_write(CSR_HGEIE, 0);
> +	if (hgctrl->nr_hgei)
> +		hgctrl->nr_hgei--;
> +
> +	/*
> +	 * Number of usable per-HART HGEI lines should be minimum of
> +	 * per-HART IMSIC guest files and number of bits in HGEIE.
> +	 */
> +	if (lc)
> +		hgctrl->nr_hgei =3D min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
> +	else
> +		hgctrl->nr_hgei =3D 0;
> +
> +	hgctrl->free_bitmap =3D (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hgei=
, 1) : 0;
> +
> +	raw_spin_lock_init(&hgctrl->lock);

[Severity: High]
Does dynamically re-initializing hgctrl->lock and free_bitmap here risk lock
corruption and resource races during CPU hotplug?

Since kvm_riscv_aia_enable() is invoked dynamically during CPU hotplug via
KVM's hardware_enable callback, it blindly calls raw_spin_lock_init() and
overwrites the free_bitmap.

If a CPU is offlined, a migrating VCPU retains its HGEI assignment and may
concurrently call kvm_riscv_aia_free_hgei() to release it on the offlined C=
PU.

If the offlined CPU comes online simultaneously, it will re-initialize the
active spinlock, causing lock corruption.

Also, since hgctrl->owners is not cleared during CPU offline, resetting
free_bitmap while old VCPUs are still registered prevents
kvm_riscv_aia_free_hgei() from setting owners[hgei] =3D NULL.

Could this lead to use-after-free vulnerabilities when kvm_riscv_aia_disabl=
e()
later iterates over the stale pointers?

[ ... ]

> @@ -634,14 +641,8 @@ int kvm_riscv_aia_init(void)
>  	csr_write(CSR_HGEIE, 0);
>  	if (kvm_riscv_aia_nr_hgei)
>  		kvm_riscv_aia_nr_hgei--;
> -
> -	/*
> -	 * Number of usable HGEI lines should be minimum of per-HART
> -	 * IMSIC guest files and number of bits in HGEIE
> -	 */
>  	if (gc)
> -		kvm_riscv_aia_nr_hgei =3D min((ulong)kvm_riscv_aia_nr_hgei,
> -					    gc->nr_guest_files);
> +		kvm_riscv_aia_nr_hgei =3D min(kvm_riscv_aia_nr_hgei, gc->nr_guest_file=
s);
>  	else
>  		kvm_riscv_aia_nr_hgei =3D 0;

[Severity: High]
The commit message claims that kvm_riscv_aia_nr_hgei represents the minimum
number of HGEI lines across all HARTs. Is this actually the case?

In kvm_riscv_aia_init(), the CSR_HGEIE register is only probed on the single
CPU executing the initialization routine.

If KVM initializes on a 'big' core with HGEI lines, it advertises hardware
acceleration capabilities globally.

If a VCPU is later scheduled on a 'little' core with 0 HGEI lines, will
kvm_riscv_aia_alloc_hgei() fail with -ENOENT and result in an unrecoverable=
 VM
crash (KVM_EXIT_FAIL_ENTRY_NO_VSFILE)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524162009.2602=
535-1-anup.patel@oss.qualcomm.com?part=3D2
