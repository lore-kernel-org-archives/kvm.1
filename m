Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D02D780E;
	Tue, 16 Jun 2026 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570548; cv=none; b=BI5fcSArDL6b5hP3m17SUFkKZc3i8fQIuFrAeycE5n9EjAh8SL4QP/Lhn6AG+JdgDpBP4w3Vym7UOeL0d52FZn8T8l+d3Nfnij6d5DtLm2KMEXrzpYR7cE4QvlkuaCsX/iH+1fiY/spSa5j7DICKHLm6EnNpnl5Z5RvuUWS+XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570548; c=relaxed/simple;
	bh=ll159o3ameauuhgIwIpUZoMFlZ23GbSv0qNxOeLTm5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyIbN3RbP3xchI1fY9YBKWuQJEnRHVSu/tvrXetwhTpc21khUO6/krOlfKQQHnqrAoIQQjHfeImvOVtZ49VmWm3x7ylsQ1IM4wibMi65Xyj25d4LhF1wUzy7BNhZYdG8hbRqt0MEr3OF+4W3YftdKImznCaeQl/8Bx91dj5o160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmuPJdVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmuPJdVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF331F00A3F;
	Tue, 16 Jun 2026 00:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570547;
	bh=cYV2o1g2x8iVKAX+1mmKnGvtA3E+2J6VhWcpzNcgytw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmuPJdVhwcQezeR57xzPBqzpzPliKCELA8AfPGe28tn+b4RvAIQrKmq4sHPmEO1I9
	 jjh2EU/seFfq8hOrN/ZtryLELsoZtEBwVcYAeZgGOuiddTA1xl1e2bWaZZRoLiiOaK
	 a6vOQ0lNC2x0wrw5FzlFp7urpBXwmBuPLEhBbMNwUUuqseOPcx4uY0CnhbSZUnVwCm
	 7Q6rTWizI3d77yID2AhYaBQPrj8cKTgjD64bQKgK6cmYI0La9FLCg9+LZ2hvJ4gaxG
	 h9vAUB4BZsG3gCj2+bAwS1Vd6HN8fvlevbdl3W+GBRfbpP7laswVoR5/JAVAPttn3T
	 h0ME3Td1vR9Sw==
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
Subject: [RFC PATCH v2 11/25] KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
Date: Tue, 16 Jun 2026 00:41:40 +0000
Message-ID: <20260616004155.1435766-12-yosry@kernel.org>
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

Rename kvm_hv_vcpu_purge_flush_tlb() to kvm_hv_purge_tlb_flush_fifo() to
clarify that it purges the TLB flush FIFO, not purge *and* flush the
TLB.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/hyperv.h  | 4 ++--
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/x86.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 65e89ed653497..a5c52e4b24b2a 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -204,7 +204,7 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 
@@ -286,7 +286,7 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	return HV_STATUS_ACCESS_DENIED;
 }
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fae5cb7102010..dac3d0098bb77 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4173,7 +4173,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
 	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 
 	/*
 	 * Flush only the current ASID even if the TLB flush was invoked via
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf122b8c32103..e67cdca8cc48f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3690,7 +3690,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
 	 * grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 }
 
 
-- 
2.54.0.1136.gdb2ca164c4-goog

