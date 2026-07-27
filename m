Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1A42E8C6
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172648; cv=none; b=NrBzir2Yc41gPx4NGvLihzrj9WfUHMngZpCGoAIeitIgiQVYWZD4nV3r1gLfNkDXfuVfnxY97LZKtUH9xbq+pOspkYKrIqBZZHnU1iwzJFr7D7o+1cY+1N6ScQiSGpbvTKHwUPxFd5D5if5a5f4GNm7WFmDh1QgSaGk4ek7DR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172648; c=relaxed/simple;
	bh=xkU4Zt6ATXYkY8dm3MbXNFOSCCUbM2X84ZQv7MTQcsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L6jaBIurTFEo97RC+M+iSAAFpavz0bw2A620TUygQzvtHU0kYRezMSmMCnMpsEBLmAqkLTaShZljNmb4N0cRezx+Fs7dfLua6aXYjEdFczxh4tfUb6os0IodC0HXE0atdKENtZzOPL4MhYvytuW0WWxvsqk8fS1xXWAMUSSsn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK/tQqM9; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK/tQqM9"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1136043a91.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785172642; x=1785777442; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8v0Gk6M5BD13gnwCJhR08TmfqcOr6CBc1UQ2ExJhfY=;
        b=AK/tQqM961sXBBSJyjNE4BimxvlicBysqZiOv6bjdvRjZB9TKwM5BhZBxenhALum8f
         sVa9dCPQTjhabvzRrdyS/fZ7JP2gqkMPqS9zn+x55Cs/b1H15oRa2nsVRuyW47kMBva6
         22F/ttSHDZbAMA4VdKPQg+3Ze19nYJsxXCOa4JBlle4r1MKZBqBpPRM37gIaTtTO8QJa
         dN/1U1cQgHquBBXbGxqx/eR/EhTk63ALGY7PZYUflkMrrPqxCa4xaF5RNj1uEZOg1lpN
         pW4m8THru0o6S1NSDYMOikhOqmofJ4sBEWlDlT83GnvYZZQIC/1q7zuvNZBNdSVLwTqr
         bWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172642; x=1785777442;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G8v0Gk6M5BD13gnwCJhR08TmfqcOr6CBc1UQ2ExJhfY=;
        b=fxGjH38BIJMDpW6SE6IMLnB/2hwvxXR1No1BcL50Er4l6djl1JtlVpVFSg7pkAUbQf
         8KwKKEiOn1lx3w+5cfSU8K64eG5tp/dhxQQ19bpNPVUAQZszi+ZVCCOmNHOFW/3BrBCy
         G4z8dhKEdhdcM/KNX8m3vNJrv28iym/Qfz3ui8XmpaoIJD4Ut1GTCD3xn4JoaJn8HTT8
         8ymkeEX+dl+d8CTj8PlNIdO+5YtJfi/21y4p0Npf+QxunOEwl6+LB+NWLEp0LK3ov356
         EHci9OXhHPJJ/RTd7dJjDWo9d8XCkK85wCSL2Vj9sia4ajYK+zMESoKbBoBGf5s1gU1v
         2qIQ==
X-Gm-Message-State: AOJu0Yz1lIIhBSyc+o9kwE1gr80eiQVSfrtW7zE7yZkWtCyi858baON0
	oacHvFWBMVk6mn/YFZIP/S5oDMdVW2gJMxceZTSSnP4n/UT26vFjt8hr7Te6M83n06NPw1YmEwj
	hIu/WnQ==
X-Received: from pjbqi14.prod.google.com ([2002:a17:90b:274e:b0:38e:7f2c:2c4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8e:b0:37f:df85:272f
 with SMTP id 98e67ed59e1d1-38f295273demr9208139a91.19.1785172642087; Mon, 27
 Jul 2026 10:17:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 10:17:18 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260727171718.543491-1-seanjc@google.com>
Subject: [PATCH v3] KVM: x86: Cancel delayed I/O APIC EOI handling before
 destroying vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zdi-disclosures@trendmicro.com, Zhong Wang <wangzhong.c0ss4ck@bytedance.com>, 
	Xuanqing Shi <shixuanqing.11@bytedance.com>, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Weiming Shi <bestswngs@gmail.com>

Cancel (and flush) the I/O APIC's delayed EOI handling work during the
"pre VM destroy" phase, before vCPUs are destroyed, as processing the EOI
broadcast will inject another IRQ if the line is asserted, i.e. will try
to deliver an IRQ to the target vCPU(s).  Canceling the work after vCPUs
are destroyed leads to UAF if the delayed work is processed after vCPUs are
destroyed.

  BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
  Read of size 8 at addr ffff8880499abea0 by task kworker/1:2/1218

  CPU: 1 UID: 0 PID: 1218 Comm: kworker/1:2 Not tainted 7.1.0-rc7 #5 PREEMPT(lazy)
  Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: events kvm_ioapic_eoi_inject_work
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94
   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378
   print_report+0x139/0x4ad mm/kasan/report.c:482
   kasan_report+0xe4/0x1d0 mm/kasan/report.c:595
   __kvm_irq_delivery_to_apic_fast+0x9bf/0xa20 arch/x86/kvm/lapic.c:1250
   __kvm_irq_delivery_to_apic+0xd8/0xbf0 arch/x86/kvm/lapic.c:1345
   kvm_irq_delivery_to_apic arch/x86/kvm/lapic.h:129
   ioapic_service+0x308/0x590 arch/x86/kvm/ioapic.c:492
   kvm_ioapic_eoi_inject_work+0x13c/0x190 arch/x86/kvm/ioapic.c:532
   process_one_work+0xa59/0x19a0 kernel/workqueue.c:3314
   process_scheduled_works kernel/workqueue.c:3397
   worker_thread+0x5eb/0xe50 kernel/workqueue.c:3478
   kthread+0x370/0x450 kernel/kthread.c:436
   ret_from_fork+0x72b/0xd30 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Note, the VM is unreachable once kvm_destroy_vm() starts, and scheduling
new work via kvm_ioapic_send_eoi() can only be done via KVM_RUN, i.e.
requires a live vCPU.

Alternatively, KVM could simply destroy the I/O APIC during the "pre" phase
of VM destruction, but that gets more than a bit sketchy as KVM expects the
I/O APIC to exist if ioapic_in_kernel() is true, and nested virtualization
in particular has a bad habit of touching VM-scope state during vCPU
destruction.  E.g. attempting to free the PIC during the pre phase would
lead to a NULL pointer dereference in kvm_cpu_has_extint(), and it's not
hard to imagine the I/O APIC having a similar flaw.

Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
Reported-by: <zdi-disclosures@trendmicro.com>
Reported-by: Zhong Wang <wangzhong.c0ss4ck@bytedance.com>
Reported-by: Xuanqing Shi <shixuanqing.11@bytedance.com>
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v3:
 - Go back to v1, sans the helper (x86.c already has an #ifdef). [Sean, syzbot]
 - Expand the block comment to call out the the PIC and I/O APIC must not be
   destroyed/free. [Kai]

v2:
 - https://lore.kernel.org/all/20260706180025.2735341-3-bestswngs@gmail.com
 - Per Kai's suggestion, instead of adding a kvm_ioapic_pre_destroy()
   helper that only cancels the eoi_inject work, move
   kvm_pic_destroy()/kvm_ioapic_destroy() as a whole into
   kvm_arch_pre_destroy_vm().  This also fixes the stale
   kvm_io_bus_unregister_dev() Kai pointed out.

v1: https://lore.kernel.org/all/20260705050443.1331662-1-bestswngs@gmail.com

 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..2b8474812303 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9939,9 +9939,15 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 * iterating over vCPUs in a different task while vCPUs are being freed
 	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
 	 * be stopped before IRQ routing is freed.
+	 *
+	 * Do NOT free the in-kernel PIC or I/O APIC here (but as above, make
+	 * sure to flush any background work), as KVM expects interrupt routing
+	 * structures to be valid until vCPUs are destroyed.
 	 */
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
+	if (kvm->arch.vioapic)
+		cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
 #endif
 
 	kvm_mmu_pre_destroy_vm(kvm);

base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.229.g6434b31f56-goog

