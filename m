Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4284195C0;
	Mon, 12 Oct 2026 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848216; cv=none; b=Z1mVJWJc7EVzP80/KlKbta2FIxpd2mNA+Jpr955rrXlxWIQ30vSyfH51Pk4qaB02bxD6Z9bVhSDr7t4gCq/iumvOg7PbEoPJKY2Cxfmtv14JMCFoHnu8zT3GjtKCpt0AkD/CrY6qzr68UeAn2qfEomc+QgmEf0rQSUXbc6lwKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848216; c=relaxed/simple;
	bh=B3M6sBhSuJ38X/GVD+bBd/0cEfNfkoYUamc/1n4rnm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6ecmdmicnMEO0Wtt3U69q1KecmGGEC6iQhiXcDFOJGXkjATZ5Ns7Tk++bFk/Y7+iBYKyj1sWos8mumNCvSrcHLj5GO7hN1F8kpfziIEotry48bLTBQqtkKsFC14++9SznR7l/dwJYE5y1aDW8RLb4JBjeId0U9zyiWxIMUJJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1mjrbwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1mjrbwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E231F008A1;
	Mon, 12 Oct 2026 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848213;
	bh=iWlpmJb19Q98A9Q8EYwGU7BhFarTvnZRla1IID/Lhw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1mjrbwAMc+AtRVVxhFuk+bVpA02wyQcDN5565UgqeYK2Kj2RBUEac3zrGoaLM85I
	 vjyHxHfUp5QAc6ONt5xUCP2PyxT9M2UzbiP0CSHz7nTe+pbiSBCoQUqk0NFa31emxj
	 tVj8AxsBBOYsWqZnP29JEPGlAkdV3MqMwHFCGYdZPla5DnaClhj4m4dY0tD/7tddBE
	 PPqz4tdIVipkV/IWuYeb7ShcTk/gCmMHXEMRUcC+Q0dx/bnHQJVflbAPdEZYG9lKxS
	 4xXx8LN+b4cfawM5trNRTz2zob8ynXKP0+ogzTohPqAjibiQbFEOdS5d2iEt+Wqsni
	 Gq91R8dqp1XpA==
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
Subject: [PATCH v3 15/27] KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
Date: Mon, 12 Oct 2026 23:36:26 +0000
Message-ID: <20261012233638.2546339-16-yosry@kernel.org>
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

Refactor kvm_hv_purge_tlb_flush_fifo() to introduce an inner helper,
__kvm_hv_purge_tlb_flush_fifo(), parameterized by an optional FIFO. If a
FIFO is not passed in, all FIFOs are purged.

Note that KVM_REQ_HV_TLB_FLUSH is consumed by
__kvm_hv_purge_tlb_flush_fifo(), so a selective purge on one FIFO will
render any subsequent non-selective purge useless. This is not a problem
because purging TLB flush FIFOs is an optimization (and there are
currently no users of the non-selective purges).

No functional change intended as a FIFO is always being passed in now.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/hyperv.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 03cc65f8cc52d..a23ef05c1075c 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -312,18 +312,29 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
-static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
+/* Purge pending TLB flushes in @fifo, or in all FIFOs if @fifo is NULL */
+static inline void __kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu,
+						 struct kvm_vcpu_hv_tlb_flush_fifo *fifo)
 {
-	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	int i;
 
-	if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
-	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
-	if (!tlb_flush_fifo)
-		return;
+	for (i = 0; i < ARRAY_SIZE(hv_vcpu->tlb_flush_fifo); i++) {
+		if (!fifo || fifo == &hv_vcpu->tlb_flush_fifo[i])
+			kfifo_reset_out(&hv_vcpu->tlb_flush_fifo[i].entries);
+	}
+}
+
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
 
-	kfifo_reset_out(&tlb_flush_fifo->entries);
+	fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (fifo)
+		__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
 }
 
 static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
-- 
2.56.0.385.gd3acb90ef8-goog

