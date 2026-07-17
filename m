Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E05A79B
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308541; cv=none; b=bGnTbQEdXzsk+/8b6EK4QYQqNv7g3hDJJb5g9nJkDxcYw60LuZ8HSWEvI53whU/EPIl+1KB9kSsd+a5fc9FoZXdowEtd21l6L4xMWue/SDmrW+Nv2V1p/dKiZ35qnYduPAoxsLEOlU6LVzAeD2XqD4GFCeRWfg/7l7mmwkSMRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308541; c=relaxed/simple;
	bh=w9PQRxeLnqPvtRcMJKO+x3ZqhwT+AoY46Rl/Sgb4MZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRx38JCQ6/BSByU6YOGxeiL4NBL/WYXbhnKH9s/Gbr0ta/jM8ld2kHKa8tAJcQeDnDa8fwrQEYxM8GOB2/sgqOyg2392qgaDHXpw5pl2O2W8oSTPhM6QQCiMIsRDsA2FV/xOjE1zngWGGTM/hq806knt5JIBb8u3u5rBWBv5JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhe2fh9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhe2fh9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944671F000E9;
	Fri, 17 Jul 2026 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308539;
	bh=3XSBEf88fUjHeiXL6nHNlZFvQCTwbZuHxJdbcMXLJRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhe2fh9tNheMPX+ZB1WDPGRNgtqubrl0H6LD0X0c79KQOe5QiS65TEwy7YbcOX9hm
	 EcNZi/BdriLQtneABS+E7u2hBjhzt+eBm1vu6JUexxhhXDCV6kW7TgnOSBiH/+66sH
	 IXY2ASNmYw2J90YQ6D8uRczARjyEA+WWyiFdIxthB9+gvOZQ0Tb4N6CxDmXvdK1EJ0
	 WqwHiGxSR/vYaxwgcaGn+dRDC1C56A6FVKiPkqNl+u4srUKTlpqniKwBBrdTnnSx6u
	 Wv029A1Efp0DUWY+nPT4sBrRQmE8M4T6yBijWekwhnydSPqZxOBQUT4PN/YyKRI+NL
	 hv+taJEmOIYxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Initialize vector array in
 dmsintc_inject_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <178430657065.19695.6391637564764566917@digiscrypt.com>
References: <178430657065.19695.6391637564764566917@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:15:39 +0000
Message-Id: <20260717171539.944671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Undefined behavior from passing a negative/underflowed `high` inde=
x to `GENMASK`.
- [High] Missing memory barriers between writing/reading interrupt data and=
 the pending flag causes lost MSIs.
- [High] TOCTOU race in KVM_SET_DEVICE_ATTR ioctl handler allows duplicate =
or inconsistent device configuration.
--

--- Patch [1]: [PATCH] LoongArch: KVM: Initialize vector array in dmsintc_i=
nject_irq() ---
commit 83b5de435c7563536835859a673b789e3b32120a
Author: Naveed Khan <naveed@digiscrypt.com>

LoongArch: KVM: Initialize vector array in dmsintc_inject_irq()

This commit initializes the vector array in dmsintc_inject_irq() to prevent
uninitialized stack data from being written to guest-visible ISR registers.
Previously, vector elements were left uninitialized when their corresponding
vector_map word was zero, which could leak kernel stack data or inject spur=
ious
interrupts.

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> index de25735ce0394..ef6c064e52f18 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -11,7 +11,7 @@
>  void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
>  {
>  	unsigned int i;
> -	unsigned long vector[4], old;
> +	unsigned long vector[4] =3D {}, old;
>  	struct dmsintc_state *ds =3D &vcpu->arch.dmsintc_state;
> =20
>  	if (!ds)

While reviewing this, I noticed a few pre-existing issues in the KVM interr=
upt
handling code.

arch/loongarch/kvm/intc/dmsintc.c:kvm_dmsintc_ctrl_access() {
...
                if (is_write) {
                        if (copy_from_user(&val, data, sizeof(s->msg_addr_b=
ase)))
                                return -EFAULT;
                        if (s->msg_addr_base)
                                return -EFAULT; /* Duplicate setting are no=
t allowed. */
                        if ((val & (BIT(AVEC_CPU_SHIFT) - 1)) !=3D 0)
                                return -EINVAL;
                        s->msg_addr_base =3D val;
...

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use r=
ace
here?

Device attributes like msg_addr_base are updated without holding a lock. If
multiple VMM threads concurrently configure the device, couldn't they both
pass the if (s->msg_addr_base) check before either thread writes to it?

Would this bypass the duplicate setting check, and could interleaved writes
lead to a corrupted device state where msg_addr_base and cpu_mask become
inconsistent?

...
                        s->msg_addr_base =3D val;
                        cpu_bit =3D find_first_bit((unsigned long *)&(s->ms=
g_addr_base), 64) - AVEC_CPU_SHIFT;
                        cpu_bit =3D min(cpu_bit, AVEC_CPU_BIT);
                        s->cpu_mask =3D GENMASK(cpu_bit - 1, 0) & AVEC_CPU_=
MASK;
...

[Severity: High]
This is a pre-existing issue, but does this code risk undefined behavior?

If userspace configures the device with a msg_addr_base where the first set
bit is exactly at AVEC_CPU_SHIFT, find_first_bit() would cause cpu_bit to
become 0.

The macro GENMASK(cpu_bit - 1, 0) would then evaluate to
GENMASK(ULONG_MAX, 0).

Doesn't this shift by the width of the type, causing undefined behavior
that could set s->cpu_mask to AVEC_CPU_MASK instead of 0?


I also noticed a potential issue in the interrupt delivery paths:

arch/loongarch/kvm/intc/dmsintc.c:dmsintc_deliver_msi_to_vcpu() {
...
        set_bit(vector, (unsigned long *)&ds->vector_map);
        kvm_vcpu_ioctl_interrupt(vcpu, &vcpu_irq);
        kvm_vcpu_kick(vcpu);
...
}

arch/loongarch/kvm/interrupt.c:kvm_deliver_intr() {
...
        mask =3D READ_ONCE(vcpu->arch.irq_pending);
        if (mask) {
                mask =3D xchg_relaxed(&vcpu->arch.irq_pending, 0);
                kvm_irq_deliver(vcpu, mask);
        }
...
}

[Severity: High]
This is a pre-existing issue, but are memory barriers needed here?

The sender (dmsintc_deliver_msi_to_vcpu) signals an interrupt by setting a
bit in ds->vector_map and then sets irq_pending via
kvm_vcpu_ioctl_interrupt(). Since both use set_bit(), which provides no
memory ordering, the writes could be reordered.

The receiver (kvm_deliver_intr) reads irq_pending, clears it, and then
reads vector_map.

Without memory barriers (like smp_wmb() on the sender and smp_rmb() on the
receiver), could the receiver see irq_pending set but read a stale 0 from
vector_map, causing it to clear the pending flag without injecting the
vector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178430657065.19695.=
6391637564764566917@digiscrypt.com?part=3D1
