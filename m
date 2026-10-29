Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256624;
	b=m1f+jmCNXRxGLKpSLPYW3dKiHK7ByqFf31QJhT39DR3IkoGNmBRQ/AzRk99NafBqoViA
	 k+0o9tUdIXT7pi3Dp7p4slHYJfK6lvOfl6Ox+Z0C/btXjqdsK0zhkG7i9cIVuwIZ2mxr4
	 BSmpGDjrectZxFQH9DYPUR9/WjaOViiqcw1H155iOhsC0BoPkAYeLWTcJVxb9yEgrTh4B
	 +v/d2fge2yT2hb+lubUQV6rjJvXbev2wC9etzbk3xtAUUcKag1ZnKP3hRrc4v5uT+1zqd
	 VxrJw0G3UR3YiGENQ/mtNHz81Aa1lOzri3FdOoxH0yO+Ata5+UT79bHRjOcTlQQTruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S+AA41CcPrRtISqNqsOtZVznUL2ETOpJGmG402BCSu8=;
	b=bAjd1CUL6g4Ky42tEW+Og0cIbhXoEzUtAhUWqXuhDsMLD5gC1QvWnCJNTJwZ6wiX0PfV
	 m9h7kRcdBDqYR9Dv8nvAk958L/rdq8mMBmFuzAbyJlurkeNKY2DfPNjnibO1vi3G44QNb
	 qFUtz/VJXUWtXszWZUOOFZ/VCIwFBsgmDQk+RVMPxIlWnsL0sxU7jZFYzaflP3Sj+pkt5
	 LbKDScjl/CbpYtxQ8MFdeZZield2XxS78Z4FFae4tmRBZRXVRKXbNRaHQCpFCfcmsi3Cw
	 De+1WrEBqPNQKXn9lohIYMkFJfb+vmsoImkq0zCJ6CD5i0H9gXIkfVkONj8kXoYT96g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae65+yTh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38059606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ae65+yTh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47A51F01825;
	Thu, 29 Oct 2026 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256623;
	bh=S+AA41CcPrRtISqNqsOtZVznUL2ETOpJGmG402BCSu8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ae65+yTh6P5/WMIWJLP/8YCRXDpsacSVvnghr9nMUT6ShyVSczpOZ3S5PJmK/RDBT
	 Ok+2a6FTZePrnKNxZvMYgSprm2aii84GZs1b6Sl8Ggum90vNg/XjdsXSpzGxk5/M8S
	 dCjql7wwesp6PoasS0sCpv4hs6CirvBaDeEEKfDGpALsaaIoX/E4TLfABGzIP+ZwoY
	 oRC2RAcwOAjEDX/8YtB6sZrIJV7xnrmNLSeaePnly4X/UmUiOSycHH5S+Om5txrC1Z
	 Wiwgut8/fHVaJ29uIB1j84Yi3WV4xFE+/1tzsqxPtTNlJOvUf1eR3Fii3VHKIWVB/u
	 B5o8c1Go/MScQ==
Message-ID: <sashiko-outbox-188828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC ISR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongli Zhang" <dongli.zhang@oracle.com>, kvm@vger.kernel.org
In-Reply-To: <20261029063112.203893-1-dongli.zhang@oracle.com>
References: <20261029063112.203893-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:50:23 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/irq/i8259: unconditional APIC access in apic_eoi_8259A() crash=
es on boot
--

commit da80aa20e6beda6754faf006bd9626316c6d5e1d
Author: Dongli Zhang <dongli.zhang@oracle.com>

x86/irq/i8259: Ack PIC vectors in the LAPIC ISR

This commit adds apic_eoi_8259A() to check the local APIC ISR bit for the
handled ISA IRQ vector and issue an APIC EOI if set, covering both normal
and auto-EOI 8259A modes to prevent LAPIC ISR stalls.

> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index f7a86b94a0dd5..73939edb8c2b3 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -144,6 +144,16 @@ static inline int i8259A_irq_real(unsigned int irq)
>  	return value;
>  }
> =20
> +static void apic_eoi_8259A(unsigned int irq)
> +{
> +	unsigned int vector =3D ISA_IRQ_VECTOR(irq);
> +	u32 isr;
> +
> +	isr =3D apic_read(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(vector));
> +	if (isr & BIT(APIC_VECTOR_TO_BIT_NUMBER(vector)))
> +		apic_eoi();
> +}

[Severity: High]
Is it safe for apic_eoi_8259A() in arch/x86/kernel/i8259.c to call
apic_read() and apic_eoi() unconditionally on every 8259A PIC interrupt
without verifying that the local APIC is enabled, mapped, and initialized?

There appear to be several boot paths where an 8259A interrupt (such as
IRQ0 unmasked in hpet_time_init() -> setup_default_timer_irq(), or a
delayed kexec/kdump interrupt) can fire while apic_read() points to an
unmapped fixmap address, an invalid MSR, or an unallocated per-CPU pointer:

1. Booting with nolapic (or acpi_mps_check() disabling the LAPIC) when
x2APIC was pre-enabled by firmware or left enabled in MSR_IA32_APICBASE by
the crashing kernel before kexec/kdump:

setup_arch() -> apic_setup_apic_calls() initializes the APIC read callback
to apic_physflat.read (native_apic_mem_read), which dereferences
APIC_BASE (fix_to_virt(FIX_APIC_BASE)).

setup_nolapic() sets apic_is_disabled =3D true and clears X86_FEATURE_APIC,
but does not clear X86_FEATURE_X2APIC. check_x2apic() in
arch/x86/kernel/apic/apic.c then sees x2apic_enabled() and sets
x2apic_mode =3D 1:

arch/x86/kernel/apic/apic.c:check_x2apic() {
	if (x2apic_enabled()) {
		pr_info("x2apic: enabled by BIOS, switching to x2apic ops\n");
		x2apic_mode =3D 1;

Because X86_FEATURE_APIC is clear, acpi_parse_madt() in
arch/x86/kernel/acpi/boot.c returns -EINVAL before
default_acpi_madt_oem_check() can switch the APIC driver from apic_physflat
to an x2APIC driver:

arch/x86/kernel/acpi/boot.c:acpi_parse_madt() {
	if (!boot_cpu_has(X86_FEATURE_APIC))
		return -EINVAL;

Later, both register_lapic_address() and init_apic_mappings() in
arch/x86/kernel/apic/apic.c check x2apic_mode, skipping both
apic_set_fixmap() and apic_disable() (which would otherwise install
apic_noop):

arch/x86/kernel/apic/apic.c:init_apic_mappings() {
	if (x2apic_mode)
		return;

	if (!smp_found_config) {
		if (!detect_init_APIC()) {
			pr_info("APIC: disable apic facility\n");
			apic_disable();
		}
	}
}

apic_intr_mode_init() in arch/x86/kernel/apic/apic.c then returns early on
APIC_PIC without calling x86_64_probe_apic(). On the first 8259A interrupt,
apic_eoi_8259A() calls native_apic_mem_read(), causing an unhandled page
fault on the unmapped FIX_APIC_BASE address.

2. Early boot with pre-enabled x2APIC before x86_64_probe_apic() runs:

When x2APIC is pre-enabled and ACPI MADT is disabled or absent (such as
with acpi=3Doff or acpi=3Dnoirq), apic_call_read remains native_apic_mem_re=
ad
with FIX_APIC_BASE unmapped until x86_64_probe_apic() runs inside
apic_intr_mode_init(). However, start_kernel() calls local_irq_enable() and
x86_late_time_init() -> hpet_time_init() (which unmasks PIC IRQ0) before
apic_intr_mode_init(), so a PIC interrupt in this window will page fault on
APIC_BASE.

Conversely, if BIOS pre-enabled x2APIC is disabled in
enable_IR_x2apic() -> try_to_enable_x2apic() -> x2apic_disable() (for
example, when interrupt remapping is unavailable or disabled),
enable_IR_x2apic() in arch/x86/kernel/apic/apic.c unmasks the PIC and
restores interrupts before x86_64_probe_apic() switches the driver back
from x2APIC MSR ops to apic_physflat:

arch/x86/kernel/apic/apic.c:enable_IR_x2apic() {
	try_to_enable_x2apic(ir_stat);

	if (ir_stat < 0)
		restore_ioapic_entries();
	legacy_pic->restore_mask();
	local_irq_restore(flags);
}

Any pending PIC interrupt firing upon local_irq_restore(flags) will invoke
native_apic_msr_read() while x2APIC is disabled in MSR_IA32_APICBASE,
triggering a #GP fault on rdmsr.

3. Hyper-V with nolapic in xAPIC mode:

init_hypervisor_platform() -> hyperv_init() -> hv_apic_init() registers
hv_apic_read in __x86_apic_override.read. With nolapic, FIX_APIC_BASE is
not mapped during MADT parsing, and when init_apic_mappings() calls
apic_disable() -> apic_install_driver(&apic_noop) ->
restore_override_callbacks(), apic_noop.read is overwritten with
hv_apic_read(). For APIC_ISR, hv_apic_read() falls back to
native_apic_mem_read(), faulting on the unmapped APIC_BASE address on the
first PIC interrupt.

4. AMD SEV-SNP Secure AVIC before savic_probe():

During early_acpi_boot_init(), default_acpi_madt_oem_check() installs
apic_x2apic_savic, whose read callback is savic_read() in
arch/x86/kernel/apic/x2apic_savic.c:

arch/x86/kernel/apic/x2apic_savic.c:savic_read() {
	void *ap =3D this_cpu_ptr(savic_page);

savic_page is not allocated until x86_late_time_init() ->
apic_intr_mode_init() -> x86_64_probe_apic() -> savic_probe(). A PIC
interrupt arriving after local_irq_enable() / hpet_time_init() and before
savic_probe() will evaluate this_cpu_ptr(savic_page) with savic_page =3D=3D=
 NULL
and read from unrelated per-CPU memory.

5. Disabled LAPIC with an MP table present or on 32-bit UP systems:

When mpparse_find_mptable() sets smp_found_config =3D 1 while the LAPIC is
disabled (via nolapic, acpi_mps_check(), or hardware-disabled APIC),
init_apic_mappings() skips detect_init_APIC() and apic_disable(), leaving
native_apic_mem_read active. apic_eoi_8259A() will then perform MMIO reads
from disabled LAPIC physical space (and if 0xffffffff is returned, issue
spurious MMIO EOI writes via apic_eoi()) on every PIC interrupt. In
addition, on 32-bit UP systems where detect_init_APIC() jumps to no_apic
and installs apic_noop while X86_FEATURE_APIC is still set and
apic_is_disabled is false, apic_eoi_8259A() will trigger the WARN_ON_ONCE()
in noop_apic_read().

Should apic_eoi_8259A() guard the APIC access to ensure the local APIC is
actually enabled and initialized before calling apic_read()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029063112.2038=
93-1-dongli.zhang@oracle.com?part=3D1
