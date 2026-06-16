Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CD367B94;
	Tue, 16 Jun 2026 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570555; cv=none; b=h87P+3b/QscUP5w6cGz7BPcpEDZrbv3fk6/3FUyWkMqXcrGOCjY5Yn56XHmPRZrMQJx4KVuMPO3WyCTxHycSLBtWYyXIu4pI1l6rD/7Pn6g5vWBmE/D0Cjdq4KzX0yKR3CgakOWBYigd/Df5oFPiGUWIdq8om5KKlIjgz3JP8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570555; c=relaxed/simple;
	bh=3SSnsvZLuScG0inPg3ePlDObQHRUEvS37WGRh5Mcr8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpycj67OThKKmNyg3RpRQbSszqJR3Bdh3r0NY+Ui1Dbhges+pUqHXFgsFmYwk5NwCKoXey+LxX/pzliJMOYWfDMkRgDPDFoYOeuOnid5GbzFApU6EISWyVoSZ0fMZfuu6ndqA9/VFnBeTTgL8y5K3fRcF44VfKEGi6QZ4hKna+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHAX4mu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHAX4mu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7691F00A3A;
	Tue, 16 Jun 2026 00:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570554;
	bh=bKt/Myl5MhLybRtn3l/dy6/OWOfCD2HEaJke+mG4OEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AHAX4mu1U6aIPCHKHgsjM7CMBQTQ/vWpokRBQY8l3UxHqxw7pmKXpof52UZZY83XR
	 A51DkaVIB0RmT7Qingf89COWuSUmlPGosPiz3oaCl6qy9JcYP1YqXPNYucfSaCtMTa
	 D7HdauUXK0caLEOgiqAyrSYAgqePboKDMg3Is9wlXLhSw4aIWMHBwsC3CgPxD17KC/
	 FgZ2YaydFq4hD7Xke4eYh24nmBVYGeipUQb6NC5hjZ6QP3gKQkKx8ipWcTyYzfJoNR
	 CkjhpKUEcY+fqsihEdRq7UW+UmlUwENzNwGlGLYaakLX2fCIy2UIkTz7epR7y2flX3
	 dBzp0DsKZvMpA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 25/25] DO NOT MERGE: Add nested_tlb_force_flush
Date: Tue, 16 Jun 2026 00:41:54 +0000
Message-ID: <20260616004155.1435766-26-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Purely for testing only, add a knob that brings back unconditional force
flushes (and resync) on nested transitions.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 56b769b603ca9..210240a0e051a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -32,6 +32,9 @@
 #include "hyperv.h"
 #include "pmu.h"
 
+static bool nested_tlb_force_flush;
+module_param(nested_tlb_force_flush, bool, 0644);
+
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
@@ -691,6 +694,12 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	if (nested_tlb_force_flush) {
+		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+		return;
+	}
+
 	if (svm->nested.ctl.asid != svm->nested.last_asid) {
 		svm->nested.last_asid = svm->nested.ctl.asid;
 		new_asid = true;
@@ -726,6 +735,12 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	if (nested_tlb_force_flush) {
+		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+		return;
+	}
+
 	/* Flush L1's own ASID if it request a *full* TLB flush on VMRUN */
 	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
-- 
2.54.0.1136.gdb2ca164c4-goog

