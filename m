Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109930F803;
	Wed, 14 Oct 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004267; cv=none; b=fd2Tem/DEjNU0Em5GYaJkMTZ2iOF0AwB4x1eTJC/jTQ7uJBfHiCkapyj0NaF9Z+rdmUJY7z3HJNFWe9uARkE/dEN9aXmS6peZI5oTpWyHWzFBbGPaBIpyJFPRlxMv8i5hjapg8aZDlGL9ro89sgyXdgpjFnH0yG0njRv8VtJN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004267; c=relaxed/simple;
	bh=2ky2JEHkf5oo9nqbXUOOwx5CR5R9dikAiDNnQyDS/x0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Iek3LnyV6FlispRq4vEXLX+cVX77LKxkWjUgk2f0JnJXjUN8oPKvDDpi3NN12QjZKsmfRGq9iIOEYHdJWkSt60nseqTfE81iz3OorjWb0Xg6SDTGuDncN+kdEQD3YHUuNaMDzJnj2ZFD8ls16Vf/TzselV0O4cOusu1Iw3YKS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=davidbq.me; spf=pass smtp.mailfrom=davidbq.me; dkim=pass (2048-bit key) header.d=davidbq.me header.i=@davidbq.me header.b=G9ozIUeQ; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=davidbq.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidbq.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidbq.me header.i=@davidbq.me header.b="G9ozIUeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidbq.me;
	s=protonmail; t=1792004256; x=1792263456;
	bh=9cPE8sJgvAuIuDlgjPyOglvFdNvaO2sHV9bRLSkaJc8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G9ozIUeQiW0+5rgkhEKi2pyjKpWNm1SAkTCW2sSOjTfqSlAF5YOz8l7fkCQ/dQHGI
	 68+syymC0Qeqr87Gyk4p3TG0gDd/rswW93f715odCqCvLSU4/rAuFs3sYyzikw2z4L
	 DjWBQJCzAQmrRI0Y9GjZQoKdyg+QNmMraPxkQQCdSjmLXd0ZjIGkDTP/m+2uix1jHM
	 pGxSUeiptcPr30QZbbNNiXEeRPJe77dYcvaI4wg9bmhUlrOVjGdhUZ9b0s03Q6xtMa
	 JDT6uUt98LFkE1Vfcsu0yPKqUyzu+/6Snw8eGATazgdro7nHHQMdu9ZWmJY1OHdC7j
	 dhAZvertO7gGA==
Date: Wed, 14 Oct 2026 18:57:25 +0000
To: Sean Christopherson <seanjc@google.com>
From: David Ballesteros <linux@davidbq.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: KVM: ioapic RTC EOI tracking wedges on non-FIXED delivery modes
Message-ID: <20261014185709.58592-1-linux@davidbq.me>
Feedback-ID: 221125243:user:proton
X-Pm-Message-ID: 3a57efbd88323e4def158ee51814ed7c258edcf1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sean, Paolo,

It was your tripwire in cc3d0e1afd10 ("KVM: x86: WARN (once) if RTC pending
EOI tracking goes off the rails") that led me here. While auditing the
ioapic RTC EOI tracking logic with its arithmetic invariants in mind, I
found that the check cannot fire for the failure mode it was hunting for.
It turns out there's a third desync state, silent and permanent, where
rtc_status.pending_eoi > 0 while rtc_status.map is empty.

With in-kernel irqchip, a guest-kernel source that performs two MMIO writes
to the guest IOAPIC (0xFEC00000; reachable only from guest kernel mode) to
write a non-FIXED delivery mode into the RTE of the RTC GSI permanently
wedges the tracking. Every later RTC IRQ of that VM is then silently
dropped, and the VM loses its timer. To be fair though, no host boundary is
crossed since a guest can only freeze its own VM, so I'm reporting this as
a correctness bug on the normal channel.

The root cause lies in an asymmetry: ioapic_service() counts any accepted
delivery into pending_eoi (arch/x86/kvm/ioapic.c:491), but
__apic_accept_irq() only sets map bits for FIXED/LOWEST modes
(lapic.c:1433-1438). As a result, modes like NMI, INIT, STARTUP, SMI, and
EXTINT return result > 0 without touching rtc_status at all. By design none
of these receive an EOI, so no ISR bit is ever established for the paired
decrement.

When RTE 8 (RTC) has delivery_mode !=3D FIXED/LOWEST, the next tick causes
ioapic_service() to count N accepted deliveries into pending_eoi while the
map stays empty. Both sides of the invariant hold from each side's own
bookkeeping; the system is simply counting two different things. Then every
later tick gets discarded in ioapic_set_irq() before ioapic_service() even
runs (ioapic.c:225-229: gate on rtc_irq_check_coalesced()), so pending_eoi
never gets re-assigned. The WARN_ON_ONCE sits inside the RTC branch, one
call below that gate, which means it can only fire if ioapic_service()
actually reaches pin 8 with a stale count. In the stuck state, the gate
closes the signal before the WARN can evaluate it.

I verified this statically on mainline 0fcb05b72344, v6.1.74, and a
hardened 7.2-rc5 build (the git history confirms no commit since cc3d0e1
touches this logic). Dynamically, the same reproducer showed the identical
stuck state (pending_eoi =3D 1, map =3D 0x0 observed live with kprobes) on =
both
hardened 7.2-rc5 and upstream v6.1.74. On the hardened build carrying
cc3d0e1, the warning never fired across 6 runs with clean dmesg. To keep
the claims straight on the other two trees: that observation is
dynamic-only on the hardened build, since that is the only tree carrying
cc3d0e1afd10 I could run on; on mainline it follows statically from the
gate analysis above (the WARN is unreachable in the stuck state), and
v6.1.74 predates the commit, so there is no WARN there. Rewriting the RTE
back to fixed-mode does not recover the timer. A same-harness run with a
fixed-mode RTE delivers 100/100 ticks normally. Causality closed when a
build with the fix delta made the same reproducer behave correctly (ticks
flow, no coalescing).

I'm keeping the reproducer off-list; the tarball is packaged and ready, so
I can send it in a single reply. All run hashes and a pre-registered
prediction record are available on request, and I can also re-run on an
upstream mainline build on request.

The fix I believe is right is to count into rtc_status only deliveries
that participate in EOI pairing. Concretely, in ioapic_service(), take the
RTC branch (and its pending_eoi =3D ret assignment) only when the RTE's
delivery_mode is FIXED or LOWEST. This preserves the current gate
semantics without forcing __apic_accept_irq() to populate the map for modes
that architecturally won't receive an EOI the kernel can associate back. I
validated it on the same rig: 3/3 runs post-fix show every tick delivered,
coalesced =3D 0, and the observed rtc_status stays consistent (map populate=
d
whenever pending_eoi is armed). Normal fixed/lowest path remains
unaffected (100/100 delivered, EOIs paired).

Separately, the tripwire itself could be extended to catch this class
directly (WARN if pending_eoi !=3D hweight(map)), though I left it as-is in
the patch.

The minimal patch with explanatory comments is inlined below. If this
direction works, I'll send it through the normal patch flow. It carries
Fixes: 2c2bf0113697 ("KVM: Use eoi to track RTC interrupt delivery status",
Yang Zhang, 2013-04-11). The coalescing gate, the pending_eoi =3D ret
assignment, and the paired decrement all trace back to that commit, so the
fixed/lowest-only asymmetry is as old as the tracking itself. I haven't
found any historical change that validated delivery_mode on this pin.

Thanks,
David

-- ----[ fix patch ]---- --

KVM: ioapic: only track RTC IRQs that can receive an EOI

Only count RTC IRQs into the RTC EOI tracking when they can actually
receive an EOI, i.e. those with the FIXED and LOWEST delivery modes;
treat every other delivery mode on the RTC GSI as a plain IRQ with no
RTC book-keeping.

The tracking counts every accepted IRQ into rtc_status.pending_eoi,
but __apic_accept_irq() populates rtc_status.map only for FIXED and
LOWEST delivery.  Any other mode (NMI, SMI, INIT, STARTUP, ExtINT)
accepts the IRQ without establishing an ISR bit, so no later EOI can
pair with the count armed at that moment.  A guest can trigger this
by writing a non-fixed delivery mode into the RTE of the RTC GSI
through MMIO; the tracking then wedges (pending_eoi > 0 with an empty
map) and every later RTC IRQ of the VM is coalesced, until the ioapic
is reset or the irqchip is reloaded.

Fixes: 2c2bf0113697 ("KVM: Use eoi to track RTC interrupt delivery status")
Assisted-by: Claude-Code:GLM-5.3-flash KASAN kprobes
Signed-off-by: David Ballesteros <linux@davidbq.me>
---
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -477,7 +477,23 @@
 =09if (irqe.trig_mode =3D=3D IOAPIC_EDGE_TRIG)
 =09=09ioapic->irr_delivered |=3D 1 << irq;
=20
-=09if (irq =3D=3D RTC_GSI && line_status) {
+=09if (irq =3D=3D RTC_GSI && line_status &&
+=09    (irqe.delivery_mode =3D=3D APIC_DM_FIXED ||
+=09     irqe.delivery_mode =3D=3D APIC_DM_LOWEST)) {
+=09=09/*
+=09=09 * Track only RTC IRQs that can actually receive an EOI.
+=09=09 * The EOI tracking in __apic_accept_irq() sets a map bit
+=09=09 * and a vector for FIXED and LOWEST delivery only; every
+=09=09 * other delivery mode (NMI, SMI, INIT, STARTUP, ExtINT)
+=09=09 * accepts the IRQ without establishing an ISR bit for the
+=09=09 * vector, so no EOI can ever pair with the count armed
+=09=09 * here.  Counting those accepted IRQs into pending_eoi
+=09=09 * wedges the RTC status: pending_eoi stays > 0 with an
+=09=09 * empty map, rtc_irq_check_coalesced() suppresses every
+=09=09 * subsequent RTC IRQ, and rewriting the RTE back to fixed
+=09=09 * delivery does not recover (restore_all runs only at
+=09=09 * inject-all/reset/restore time, not on RTE rewrite).
+=09=09 */
 =09=09/*
 =09=09 * pending_eoi cannot ever become negative (see
 =09=09 * rtc_status_pending_eoi_check_valid) and the caller

-- ----[ end of fix patch ]---- --


