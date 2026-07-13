Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FF377EC3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956273; cv=none; b=fsb7hOeWps+xR/kflUkh4xu0CgH6OotjfRu6GLJ1k02hXwlRMAthM+cPuS5rQis4zP6czXRnPAsqZyr/GhDmu5hcEu21JJ3N856B/6z0aKJ/+GVitp5nNthmJcoAdkcpu+T/6fNDG80vps369DrClCL4maN3E+LvpdBaQ5igN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956273; c=relaxed/simple;
	bh=+1XKZ6Yr9JlCMllA+NImG98btLHrcW7FVO+apGXC9I0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRCAVqCh/VHhiF864fmZG/9BV2sGRialIl0CDDLXPlMIfd5eySASCixs8XqliPMYQsGvBxAW5zuqa8DGUOOJwm7bN2p0Z2Zik9UirlVocGOTzHcRs6fltXrLKBGZA7NISzOI56pyiUXyh0iu1kALKjJGlIw4sGI5ZvT7Py6U0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=jEljqi4j; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="jEljqi4j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=R6nyOirOMrUvxGiFRMeI3IlJWFVUN8eQGkCu68Fmu4s=; b=jEljqi4jhYJ3frqlemAAhOPaXp
	c9BxD+xH9CzvrPesbphfqVOopj1R1IWHq551vWCObxDxG9Y6GqRQ3kRJ8G6X9u9spi/9TUI5R56XR
	iFQIevye8++Sh45InRYft0GTNeP9kLtas+eRmxVw+qZSU5v7rvCNmA+SMDjKAiTGpDQzxqCHBdYnH
	YI/DGh36Ich0ldR0F8AEZYota7Fqz1pCXDHGcqcpe9nEmIAFr3hi/YJJB3S542XKt3cgw3ICebNyJ
	MshEE6vdSa12UfMye3HbIzlh30A4svTP/pShcsCHsGlBinB50qyDOlf0HLF+YgsZ0uHbbJ5pXd9ZJ
	4iRGO/RQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:43383)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wjHva-009aXD-0k;
	Mon, 13 Jul 2026 16:46:38 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wjHva-0005oM-0c;
	Mon, 13 Jul 2026 16:46:38 +0200
Received: from eftekhar-ubuntu.customer.ask4.lan (10.250.9.200) by
 mbx19-gwd-01.um.gwdg.de (10.108.142.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 16:46:37 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <rossow@cispa.de>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: nVMX: store L2's TSC frame in the VM-exit IA32_TSC MSR-store list
Date: Mon, 13 Jul 2026 16:46:05 +0200
Message-ID: <20260713144605.2773845-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-GWD-07.um.gwdg.de (10.108.142.60) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

When L1 lists IA32_TSC (0x10) in vmcs12's VM-exit MSR-store area, the
value KVM auto-stores on a nested VM-exit is computed with
kvm_read_l1_tsc(), which evaluates the TSC in L1's frame
(l1_tsc_offset + host_tsc scaled by l1_tsc_scaling_ratio).  But the
guest that just exited is L2, and RDMSR(IA32_TSC) in L2 returns L2's
frame, (host_tsc scaled by the composed ratio) + the composed offset
(SDM Vol 3C 27.4).  The stored value is therefore short by exactly the
L2 offset O2 (more under scaling), so an L1 that uses this list to bound
the highest TSC L2 could have observed gets a bound that is too low.  A
subsequent L1 re-base can then legitimately place L2's TSC below a value
L2 already read, i.e. drive L2's clock backward -- the exact hazard the
feature added in commit 662f1d1d1931 ("KVM: nVMX: Add support for
capturing highest observable L2 TSC") was meant to prevent.

The bug is wrong by single-level equivalence: a non-nested hypervisor
running a guest with offset O that lists IA32_TSC in its VM-exit
MSR-store area receives the guest's frame; the nested emulation of the
identical setup must produce the identical value.

nested_vmx_vmexit() restores the composed TSC state to L1's before the
MSR-store list is processed, which is why the code reached for
kvm_read_l1_tsc() -- whose contract is genuinely raw input everywhere
else it's called (lapic.c and x86.c's pvclock path both pass it
straight from rdtsc()), consistent with treating the autostored value
the same way.  It just stops one step short: O2/M2 remain readable
from vmcs12 via the vmx_get_l2_tsc_* accessors, so recompose L2's
frame there.  Export kvm_scale_tsc() so nested.c can scale the host
TSC by the composed ratio.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/nested.c | 20 +++++++++++++++++++-
 arch/x86/kvm/x86.c        |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6957bb6f5cf7..610b58933d6b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1111,8 +1111,26 @@ static bool nested_vmx_get_vmexit_msr_value(struct kvm_vcpu *vcpu,
 	if (msr_index == MSR_IA32_TSC && vmx->nested.tsc_autostore_slot >= 0) {
 		int slot = vmx->nested.tsc_autostore_slot;
 		u64 host_tsc = vmx->msr_autostore.val[slot].value;
+		u64 l2_multiplier = vmx_get_l2_tsc_multiplier(vcpu);
+		u64 l2_offset, l2_ratio;
 
-		*data = kvm_read_l1_tsc(vcpu, host_tsc);
+		/*
+		 * The guest that just exited is L2, so the value auto-stored on
+		 * its behalf must be L2's frame: RDMSR(IA32_TSC) in L2 reads
+		 * (host_tsc scaled by the composed ratio) + the composed offset
+		 * (SDM Vol 3C 27.4).  nested_vmx_vmexit() has already restored
+		 * the composed TSC state to L1's by the time the MSR-store list
+		 * is processed, so recompose L2's frame from L1 state and the
+		 * vmcs12 TSC controls.  kvm_read_l1_tsc() would instead record
+		 * L1's frame, dropping L2's offset (and scaling) entirely.
+		 */
+		l2_offset = kvm_calc_nested_tsc_offset(vcpu->arch.l1_tsc_offset,
+						       vmx_get_l2_tsc_offset(vcpu),
+						       l2_multiplier);
+		l2_ratio = kvm_calc_nested_tsc_multiplier(vcpu->arch.l1_tsc_scaling_ratio,
+							  l2_multiplier);
+
+		*data = kvm_scale_tsc(host_tsc, l2_ratio) + l2_offset;
 		return true;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..0ce0d30e8825 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2641,6 +2641,7 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 
 	return _tsc;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_scale_tsc);
 
 static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 {
-- 
2.34.1

