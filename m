Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C82E7397;
	Tue, 16 Jun 2026 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570549; cv=none; b=LGIVCHvwmTmZtD2XNK1pFjJKNo/NFxUgEBK6BWxhgFRyRJA99URpdU3eL3pn7IKZmYqIRsfm483k5TZ9Iyrul5+SuNqTFH8OUHIKn0z7Z63c1AeBavnb2YdnCPlo/mYoHFXEQMt91DRSijTifTgylotbJ/wztlNyfcl7YV2ONLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570549; c=relaxed/simple;
	bh=cpnzB6em9hkoc8fVPlK0WTcCtiCSpFE17rlnnHYPepI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSTQy0d0yD0l2+RuQsA5y0jwLwkh9CWtjqe298cAn3wOFKqCDsVFvjjPu8P+iQkj03o/TmtM6nmFYCj063lgl1l9HYQfvcELTuauZ8N8L6cjMB0bne0g/AgzbjQ+o1ZOuTHvC6E4iJJW3qKwmgrDz2mRPnjEi2u2HqiOCNErfus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOoC0usd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOoC0usd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D71F00AC4;
	Tue, 16 Jun 2026 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570547;
	bh=0ToFxKvKNmqvqbUJvC8dX209MPPcS8Izga3COfzvZrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOoC0usdajbRquDYXxo/TdIpFpY8Xq25oz6HWAXnKz/ugUNEsU4KnP9NTvpI4r2Ev
	 CCJmmjBKMHNUBy8zyP5YvPuObP1CJD8Ymlb/wscdjb/8vSybdC/PI4KAnSA1XShHvp
	 pQ9GgIxcSmdmaHgX6z6fPU5PaZnMY8WF/N0BR+PKUNYzZ8xpTfIyI5ijQn3pq9nOKa
	 qqgYBvSGtw5cLOyWYLymrab5XduHTttQtej0XNVzBOg+TqWqgKFxo1XFIz+3akRVS3
	 a8T7HW1SzBrs6x7+PfbORfZKbIukYs2ZES1QpAJJkVKgpKlT9GedOjfqSzmSLUX2Mf
	 3cVC3ZZ3swG/Q==
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
Subject: [RFC PATCH v2 12/25] KVM: x86: hyper-v: Allow puring all TLB flush FIFOs
Date: Tue, 16 Jun 2026 00:41:41 +0000
Message-ID: <20260616004155.1435766-13-yosry@kernel.org>
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
 arch/x86/kvm/hyperv.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index a5c52e4b24b2a..0f64038408072 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -204,16 +204,31 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
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
 
-	if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
-	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	for (i = 0; i < ARRAY_SIZE(hv_vcpu->tlb_flush_fifo); i++) {
+		if (!fifo || fifo == &hv_vcpu->tlb_flush_fifo[i])
+			kfifo_reset_out(&hv_vcpu->tlb_flush_fifo[i].entries);
+	}
+}
+
+static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
+
+	if (!to_hv_vcpu(vcpu))
+		return;
 
-	kfifo_reset_out(&tlb_flush_fifo->entries);
+	fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
 }
 
 static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
-- 
2.54.0.1136.gdb2ca164c4-goog

