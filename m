Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB92E8DEB;
	Sat, 17 Oct 2026 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197240; cv=none; b=YfGSM5qMe3YCLuInSKOqnMfIGRBCeOaWsKbadkONOZesA1KYDX1cnHsw5jWjX6Cex8iYf3KrOyyq4xrAgDrKHZIQq/6mpGZ1SkNnJ2fs1LKqyQRqiWdFhttUxPQkR2RQltRk3IEXyxHE7xC+scmefCly8J/rHw7RoOgtdFV70Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197240; c=relaxed/simple;
	bh=KWfKjbXXEsM81mRwHqp0ugonEVRvuXhw52M0YUEzi4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsBfJVn0sttsbnkF6IjMvbzY8nCeO+NFSmxotnDl8VaAkYcOMl6nsRfxk/tQhdaAE7tH0EaK9PHKbtLtoqx+y3MfrM2mRZYHP/XK/+6wD6PFgtse7dCuw1Cw+rvvljXEaAaM/FK81EZcp8dAcc2ZSWJ935n0MY7CjUq29w9reiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=pdAsG7/K; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="pdAsG7/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NK1tJ59gAHuGiWaoA3Mbm9B+nQ+iOVyJjiL3yzfb2cA=; b=pdAsG7/KXv2Ir4nNv2ujGJpF6l
	QoPBXduS86YVZVoGx5KEBMKn7hs9bk6EN2LFzxLUuSKuNTWIXGbnD+6Q7wWuKMLF9smFKbx3mTp97
	HSxnAhVfMGc1J0VYhm08b7jrT0OExi/qNuXA36grfxQF3XPDUpElswtjK4VsZ875qkUCCD+3FY6ib
	cjXCcv/SpA35EYeJGMGefLg9rgEELKcUU608w+RNXQWiGZ/7jrmCy72V/MoTMkh+TUEIvDFeDdiPX
	OcC16th8c0pZ1rXnQT8grHUNSZqrallX5kHcoffU2DVJcqYOjLIZOQUbgDJtjLACVs+TDMkA/pcdh
	i9PjUZ4g==;
Received: from mailer.gwdg.de ([134.76.10.26]:40275)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjM-00B5eY-0c;
	Sat, 17 Oct 2026 01:52:55 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjK-000D3R-2f;
	Sat, 17 Oct 2026 01:52:54 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 01:52:53 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] KVM: x86: __set_regs() silently drops a pending nested exception destined to VM-exit to L1
Date: Sat, 17 Oct 2026 01:52:21 +0200
Message-ID: <20261016235221.33726-5-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-sub-01.um.gwdg.de (10.108.142.54) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

__set_regs() (arch/x86/kvm/regs.c:102) unconditionally clears both pending
exception queues:

	vcpu->arch.exception.pending        = false;	/* regs.c:129 */
	vcpu->arch.exception_vmexit.pending = false;	/* regs.c:130 */

Neither clear is gated by is_guest_mode(), and neither is visible to
KVM_GET/SET_VCPU_EVENTS. exception_vmexit is the queued exception KVM will turn
into a nested VM-exit to L1 (the vector L1 intercepts via the VMX
EXCEPTION_BITMAP / #PF error-code match, or SVM intercept_exceptions). When L2
is active and that reflection is pending, a KVM_SET_REGS the VMM issues for an
unrelated reason silently discards the reflection L1 configured, so L2 evades an
exception interception L1 relies on. __set_regs() is reached by
ioctl(KVM_SET_REGS) and by the KVM_SYNC_X86_REGS dirty-regs path
(kvm_run->s.regs, regs.c:728).

Class: a KVM ABI-level correctness bug (edge E3 -- L2 escapes an L1-intended
interception). It is NOT host corruption: the drop is clear-only, so it cannot
violate the requeue/injection WARNs (kvm_clear_exception_queue runs first in
*_complete_interrupts, so the drop cannot create dual-pending, set TRIPLE_FAULT,
or leave pending while !is_guest_mode), the SMM/#DF morph early-returns before
the #DF logic, and exception_vmexit is a software queue never written to
vmcs02/vmcb02 VM_ENTRY_INTR_INFO, so there is no stale hardware injection. All
PoC runs are dmesg-clean under KASAN. It is also not memory-safety and not a host
DoS.

Not reachable through stock QEMU: the apparent guest trigger (L2 IN 0x5658 ->
cpu_synchronize_state -> KVM_SET_REGS) does not drop anything, because QEMU's
put order is kvm_put_vcpu_events after KVM_SET_REGS in the same
kvm_arch_put_registers (it re-stuffs exception.pending, and the entry-morph
re-creates exception_vmexit), and QEMU x86 does not use KVM_SYNC_X86_REGS. So
this needs a custom/buggy VMM, or a direct /dev/kvm user issuing SET_REGS
without a paired events-put while in guest mode.

Secondary (H4): __set_regs() leaves exception_from_userspace and
exception.vector intact, so a pure-userspace KVM_SET_VCPU_EVENTS(pending=V) ->
KVM_SET_REGS with no KVM_RUN between makes the entry-morph fire a spurious
reflection of V that userspace believed it cleared. Real, self-cleaning,
VMM-userspace-only, and not QEMU-reachable (QEMU's put order is SET_REGS before
SET_VCPU_EVENTS).

Suggested direction (for your call): either do not clear exception_vmexit in
__set_regs() (leave the nested reflection to GET/SET_VCPU_EVENTS, which already
round-trips it correctly), or gate the clears appropriately and also clear
exception_from_userspace/vector so the H4 spurious-reflection path cannot fire.
I did not want to pick an ABI semantics here without your input.

Demonstrations (both dmesg-clean, deterministic, Intel 7.3-rc3): a standalone
KVM selftest that uses immediate_exit to hold exception_vmexit.pending across a
KVM_RUN return, then shows KVM_SET_REGS drops it while a GET/SET_VCPU_EVENTS
round-trip preserves it. It is small and I can post it alongside a patch once
the intended fix is agreed.

Thanks,
Amirmohammad

