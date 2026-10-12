Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4493E5EF7;
	Mon, 12 Oct 2026 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848215; cv=none; b=uQMSRW9XfkrSiZK/rlDduNuVXH/se8GQN7eXxhbpPrsZoqrkT4AfoM1utdtdtZYHQ+wKKN68s4SASOBTyvP8EixRVNYntVM0yHPH7YAXBS52z3mhSd1smS8DYBOgSP0FgxJpSf8xvcrTVStzPRNClvPzqBwffOH3UUAyibhfuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848215; c=relaxed/simple;
	bh=peuFvnFGDHRrV+79ZsimfOt3L+v7AD6jY54mSo2bNdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9jRGwRGK0Okl3GyqxelLcVEqX+ePGYeMRO+j6/BFtZrWSr4va5wfo0HDhSH2m/Ah704tJFEZGwQ238FSHTEgeeTkN4rXM3ysXRWwpGs+RjNyp8HwgI+hiHaRfskpFlIMQH41f9m0QEfawLkZxyL+pPqzYR89N4GU35LJKwI0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrlRAwwR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrlRAwwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEB61F008A4;
	Mon, 12 Oct 2026 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848213;
	bh=Y9GGi4nOL/Q1/PzR2IfVeFYW4wMWpOzwDBQsg72EhhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrlRAwwR++Sv5O4bBIU7fR4vAY12QGVbWtmOt8hgDHLCq0mgg8E+wT99eS6KGWBVf
	 RF3w1JmAOcwXkLZupLRy/Kke/RFVEm9aN/YezcGV6BlKcRUkSWMYHMmFUYZlmfySgb
	 1JHmZsgmAmApBCz0tJ0kw9r8tzm/e+LqjduiFH3+j5/rVMCjnV61LPHYoJppUTX2wQ
	 JYJRDu4hajlPbpJEYU6iSgvj3xxeMrEj01YIuNkh2dgFTou+3oP0N0mDTDKoZFE1D2
	 TUsrc9dpvFRxB07Q4F2jakczMbc3q/bUPo/Wi4qqHFmP+W3qeMNkukZgjtgoTJmtNO
	 JjubRDENwkfwQ==
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
Subject: [PATCH v3 14/27] KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
Date: Mon, 12 Oct 2026 23:36:25 +0000
Message-ID: <20261012233638.2546339-15-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
index 622a6553e9ac2..03cc65f8cc52d 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -312,7 +312,7 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 
@@ -396,7 +396,7 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	return HV_STATUS_ACCESS_DENIED;
 }
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 65d6b6fa35b21..851db95dc3f95 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4308,7 +4308,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
 	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 
 	/*
 	 * Flush only the current ASID even if the TLB flush was invoked via
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..12eaeaea51633 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2030,7 +2030,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
 	 * grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 }
 
 
-- 
2.56.0.385.gd3acb90ef8-goog

