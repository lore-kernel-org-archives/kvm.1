Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43504317D
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633207; cv=none; b=WVwf2TPEsdBJRU1axOVyw4XqpTDjnnH7pZydsCedLuKkcI5cplusJEYIdMNod/J5fNIvNxEt8i7ISCAo0FAvQUg/7RteQdeIj6JdX9EOhCJIBo6DurP8gutpKNt4fLd9zlW4FejmpFRIjCbjOJFtr49szndKjm3Uf4gwy7PSORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633207; c=relaxed/simple;
	bh=fCcQC1pF/MYIRIGO5FeHG77d62cm4zUn8ZM5s8iYKTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptmja2/p0rXwgtSsFv4h/FnCZ5dOhQcykkxXYWNHONMImngs50OGo/fL5DRHAjMV7GsVhOh6dsjL6n/EHnTVsnnIh8le6KXyL2xw9FZ0foLtiTKi+yB7DtCmziKXJ/KS0wQR0Dqz/U3a/jzt02iynjH2wCTluwP9btal2lFGb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU8pVebo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU8pVebo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077481F000E9;
	Sun, 24 May 2026 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779633205;
	bh=IXdWPUPYfcaQW2LatvkgCySSvtD5CxRJvp0wjFs0j5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NU8pVebohDl72Ngo+2oK0u4A2Sa2TfgCoKksC0FnPVlLDDT3LhKQNSpfBpE8dK+N/
	 iR5PtqJm9h7V8KSIlNO1o72G492suFhygsxxMVi1fxNtDKuRjoYNB4z+r2tkYtrX4k
	 Holl1i/zxGcTpl42elLRpt29R8U45mjS1hG3QPaDA+NgaiUSyGSlF3BxKBqwNVE7mt
	 9T/jdV97bjJT8dajkz2eS1d6rJZwjFshrM2H4dPu+HQnIy+1dUlXMUrs/6qBRT8fkI
	 Rx/jcZtSWvoCLafobZ0+0raMj2T1C5/YG7ClMV6wnaCO+wXatyUC5UsevO5B00STr2
	 j7LIWrCvoFpXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: AIA: Make HGEI number management
 fully per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260524132057.2425034-3-anup.patel@oss.qualcomm.com>
References: <20260524132057.2425034-3-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 14:33:24 +0000
Message-Id: <20260524143325.077481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Concurrent, lockless modification of the global `kvm_riscv_aia_nr_=
hgei` variable causes data races and state inconsistency.
- [High] AIA initialization relies solely on the boot CPU, breaking big.LIT=
TLE compatibility and causing unhandled interrupt storms.
- [Medium] The per-CPU SGEI interrupt is leaked upon KVM module unload if a=
 heterogeneous CPU without HGEI support was hotplugged.

Pre-existing issues:
- [Critical] Lock-dropping Use-After-Free during CPU offline in `kvm_riscv_=
aia_disable()`.
- [High] Out-of-bounds bitwise shift when evaluating `BIT(hgctrl->nr_hgei +=
 1)` leads to undefined behavior.
--

commit 740226878ac66c1346a97582634147bb166edc46
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

Previously, the number of Hypervisor Guest External Interrupt (HGEI)
lines was stored in a single global variable kvm_riscv_aia_nr_hgei
and assumed to be the same for all HARTs. This patch makes HGEI
management fully per-CPU to support heterogeneous RISC-V SoCs where
different cores may expose different HGEIE CSR widths.

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288555d..c289d8999aaf6 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c

[ ... ]

> @@ -545,9 +533,48 @@ static void aia_hgei_exit(void)
> =20
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
> +	/*
> +	 * The global number of usable HGEI lines should be minimum
> +	 * across all HARTs.
> +	 */
> +	kvm_riscv_aia_nr_hgei =3D min(kvm_riscv_aia_nr_hgei, hgctrl->nr_hgei);

[Severity: High]
Since kvm_riscv_aia_enable() is executed concurrently on all CPUs during KVM
hardware enablement via on_each_cpu(), does this read and write of the glob=
al
kvm_riscv_aia_nr_hgei variable create a data race?

Additionally, if this global value dynamically shrinks after KVM initializa=
tion,
can it cause state inconsistencies? Global properties like kvm_riscv_aia_ma=
x_ids
are computed only once during boot based on the initial value. If the global
variable drops to 0, newer VMs might incorrectly fall back to
KVM_DEV_RISCV_AIA_MODE_EMUL, while already-created VMs incorrectly retain
hardware-accelerated modes (AUTO), leading to divergent VM states.

[Severity: Medium]
If a heterogeneous core without HGEI support is hotplugged, shrinking this
global variable to 0 can also leak the per-CPU SGEI interrupt.

During KVM module unload, aia_hgei_exit() checks:

	if (!kvm_riscv_aia_nr_hgei)
		return;

Will this early return skip the call to free_percpu_irq() and leak the
previously allocated per-CPU IRQ mapping?

> +
> +	if (hgctrl->nr_hgei) {
> +		hgctrl->free_bitmap =3D BIT(hgctrl->nr_hgei + 1) - 1;

[Severity: High]
This is a pre-existing issue, but does this lead to undefined behavior when
hgctrl->nr_hgei is 63?

The RISC-V AIA specification allows up to 63 guest external interrupts per =
HART.
The expression BIT(hgctrl->nr_hgei + 1) evaluates to BIT(64), and shifting a
64-bit integer by 64 is undefined behavior in C. Architecturally on RISC-V,=
 this
shift amount is masked by 63, turning 1UL << 64 into 1UL << 0 (1). The
subsequent subtraction 1 - 1 evaluates to 0, which incorrectly sets free_bi=
tmap
to 0.

Would using GENMASK_ULL(hgctrl->nr_hgei, 1) be a safer alternative?

> +		hgctrl->free_bitmap &=3D ~BIT(0);
> +	} else {
> +		hgctrl->free_bitmap =3D 0;
> +	}
> +
> +	raw_spin_lock_init(&hgctrl->lock);
> +
>  	csr_write(CSR_HVICTL, aia_hvictl_value(false));

[ ... ]

> @@ -588,7 +615,7 @@ void kvm_riscv_aia_disable(void)
> =20
>  	raw_spin_lock_irqsave(&hgctrl->lock, flags);
> =20
> -	for (i =3D 0; i <=3D kvm_riscv_aia_nr_hgei; i++) {
> +	for (i =3D 0; i <=3D hgctrl->nr_hgei; i++) {
>  		vcpu =3D hgctrl->owners[i];
>  		if (!vcpu)
>  			continue;
> =20
>  		/*
>  		 * We release hgctrl->lock before notifying IMSIC
>  		 * so that we don't have lock ordering issues.
>  		 */
>  		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
> =20
>  		/* Notify IMSIC */
>  		kvm_riscv_vcpu_aia_imsic_release(vcpu);

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free risk when the l=
ock
is dropped here?

Since the vcpu pointer is retrieved from the per-CPU hgctrl->owners[i] array
under hgctrl->lock, dropping the lock and calling
kvm_riscv_vcpu_aia_imsic_release(vcpu) without holding a reference count on=
 the
vcpu or its parent KVM instance seems problematic.

Because CPU offline operations (kvm_offline_cpu) execute asynchronously to =
VM
destruction, could a concurrent kvm_destroy_vm synchronously free the vcpu
memory while hgctrl->lock is dropped?

[ ... ]

> @@ -634,14 +661,8 @@ int kvm_riscv_aia_init(void)
>  	csr_write(CSR_HGEIE, 0);
>  	if (kvm_riscv_aia_nr_hgei)
>  		kvm_riscv_aia_nr_hgei--;
>  	if (gc)
> -		kvm_riscv_aia_nr_hgei =3D min((ulong)kvm_riscv_aia_nr_hgei,
> -					    gc->nr_guest_files);
> +		kvm_riscv_aia_nr_hgei =3D min(kvm_riscv_aia_nr_hgei, gc->nr_guest_file=
s);
>  	else
>  		kvm_riscv_aia_nr_hgei =3D 0;

[Severity: High]
Does sampling CSR_HGEIE only on the boot CPU break big.LITTLE compatibility?

If the boot CPU is a LITTLE core (0 HGEIs), aia_hgei_init() will skip mappi=
ng
the SGEI IRQ, leaving hgei_parent_irq as 0.

When a big core (HGEI > 0) later executes kvm_riscv_aia_enable(), it will t=
ry
to call enable_percpu_irq(0, ...), but no interrupt handler will be registe=
red
for IRQ_S_GEXT.

Since the big core still enables hardware acceleration (free_bitmap > 0) and
assigns HGEIs to VMs, what happens when a VM triggers an HGEI? It traps to =
the
host kernel, but with no registered handler to clear the external interrupt,
will the core immediately re-trap upon exit, causing an unhandled interrupt
storm that hangs the CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524132057.2425=
034-1-anup.patel@oss.qualcomm.com?part=3D2
