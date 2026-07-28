Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A72D061C;
	Tue, 28 Jul 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204007; cv=none; b=IT4gAF5RSXyVgd9U1EIro8w/T02eluRChFthfugbsML5k0DXVe5OCzB6XG2ZHdogkttiD4y1m7NarMEOGZA8cbAxIOYW0QCqgTiDwQ5UWnTPHyZbl037eYSd1OHBp/5qyXWTw6VyCfse6WOyJNLoI1gmE3Up5lqAOmUgIfvspnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204007; c=relaxed/simple;
	bh=fePWmtK9tZu2gh6X0NLBQhets24U3RmqzvIDmocbDKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKuxbgIeDuS+Zawn0JlZbW+rvwM+e4tobWtX7mEWZlcpNd4L7H0ot50ihDguVNjdBNQN1/YwJCaGhg8a0OBGxaVJCybjej2i1kVGM+0VYkp1JQ7zTln8JU9RjAQ229dbUPELQjNLXjARmvY6VWPiCQzgOSroDHLBUTw4U53LqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id A623323371;
	Tue, 28 Jul 2026 04:54:17 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH] KVM: x86: Re-pend NMI in vNMI hardware when injection is blocked
Date: Tue, 28 Jul 2026 04:54:16 +0300
Message-Id: <20260728015416.1371404-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With two NMIs pending and vNMI enabled, process_nmi() hands one NMI to
hardware via kvm_x86_ops.set_vnmi_pending() and leaves the other in
vcpu->arch.nmi_pending for injection via .inject_nmi(). If that injection
is blocked - here by an interrupt shadow set through KVM_SET_VCPU_EVENTS -
kvm_check_and_inject_events() calls .enable_nmi_window() to single-step
the shadow. On the next VMRUN hardware delivers the NMI it was holding and
sets NMI-blocking itself, so svm_get_nmi_mask() becomes true. KVM_REQ_NMI
is not pending on the re-entry, so process_nmi() does not re-run and the
leftover NMI is still queued; .enable_nmi_window() is called again with
NMIs now masked, and svm_enable_nmi_window() hits WARN_ON_ONCE() - which
asserts KVM never opens an NMI window while NMIs are masked under vNMI.
With panic_on_warn this is a host DoS.

WARNING: CPU: 3 PID: 1450 at arch/x86/kvm/svm/svm.c:4004 svm_enable_nmi_window+0x716/0x8f0 [kvm_amd]
CPU: 3 UID: 0 PID: 1450 Comm: syz.1.86 Not tainted 6.12.85+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:svm_enable_nmi_window+0x716/0x8f0 arch/x86/kvm/svm/svm.c:4004 [kvm_amd]
Call Trace:
 <TASK>
 kvm_check_and_inject_events+0x117a/0x1520 arch/x86/kvm/x86.c:10486 [kvm]
 vcpu_enter_guest.constprop.0+0x56f/0x40c0 arch/x86/kvm/x86.c:10946 [kvm]
 vcpu_run arch/x86/kvm/x86.c:11344 [inline] [kvm]
 kvm_arch_vcpu_ioctl_run+0x5dc/0x2560 arch/x86/kvm/x86.c:11671 [kvm]
 kvm_vcpu_ioctl+0x459/0x1510 virt/kvm/kvm_main.c:4492 [kvm]
 __x64_sys_ioctl+0x190/0x220 fs/ioctl.c:893
 do_syscall_64+0xf5/0x220 arch/x86/entry/common.c:78
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Before falling back to a window, retry .set_vnmi_pending() as process_nmi()
does. Hardware has already delivered the NMI it was holding, so the retry
succeeds, nmi_pending drops to zero, and no window is requested; hardware
delivers the re-pended NMI once the guest IRETs. On the first pass hardware
still holds the earlier NMI, so the retry fails and single-stepping is
unchanged. Without vNMI .set_vnmi_pending is NULL and the branch is a nop.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: fa4c027a7956 ("KVM: x86: Add support for SVM's Virtual NMI")
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
The splat above is from syzkaller fuzzing on 6.12; the bug also reproduces
on kvm-x86/next with the syzkaller reproducer in a KVM guest on an
AMD EPYC 9754 (Zen 4c) with vNMI enabled; the WARN no longer fires with
this patch applied.

 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 960ff7fcd8db..d35f5fd3cb16 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7724,6 +7724,9 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			can_inject = false;
 			WARN_ON(kvm_x86_call(nmi_allowed)(vcpu, true) < 0);
 		}
+		if (vcpu->arch.nmi_pending &&
+		    (kvm_x86_call(set_vnmi_pending)(vcpu)))
+			vcpu->arch.nmi_pending--;
 		if (vcpu->arch.nmi_pending)
 			kvm_x86_call(enable_nmi_window)(vcpu);
 	}
-- 
2.50.1

