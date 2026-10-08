Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437731E85E;
	Thu,  8 Oct 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418487; cv=none; b=rcTK6ogNtTS4AtNN9CDYKhe3MIcvSIEtUXKYwQ8ImmSsRmo/jZSpU4yP/vZxkXgoXbz1EgcBaCcgfGC1jyQbGyFkaJV5Q7BDnx+ChJr7t9gsTquPFm8lO+cOwJfGM+LYFneSXyGV2VgyE7Re/DUV7ZhVLpMJuHr23PJW4U11dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418487; c=relaxed/simple;
	bh=kqqmSS9YluUzE11M4fFaNJGpzuLlzKEvBd4nX3NAQTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGruM8V1mMH/Yd4/krV4xyP0qguRwh4lqSafMZI2Gszocl0P+O3EQwneHGEM3WOxDn+CUSArD6IEYDbwzMqDPeXqk9y7jaiuD553lgaH2T6dmnHgv5HRAgeRiZXRAzk6yC3Jkr42iNMJUqOxlRMA0XRGfaA9VY2spfVopSQ4lL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBL8tYon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBL8tYon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6E51F00893;
	Thu,  8 Oct 2026 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418486;
	bh=DuIuJ9PY/IZEH3Q/NmP5QisX8xAgoAFOwmLxTxytH/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBL8tYonhVdcdtXs8WYqIxVeAmYbMHjaiyRw/SNzI+6MEIJsRpr/4bpkMatBES6Kr
	 DLSs0d1Sq8SrMrO5mlFmXD35GKd7mjlBWT57WbCXxZ/fVVd/B+Zuz4rc8SM3zqJC4U
	 HTSPfe5aFZxny3dMMBBAz5gDp44ESiHd16sBksv/WsO7q1lmWWWIc5YFfmJAicumG3
	 xpPfitBxcUeoXHjHqWN/CIX5Fb8f4gK+PgVf3XzUrYSg97S0961DIJvGZQqeUoC+9U
	 M9cxbqhEq7OtqKykNTlU5rClf7ps4j4T3Da/PgicqWk5npIipdKiqpbIZIv+7aIDm3
	 Bj9IJLA+TXYEw==
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
Subject: [PATCH v2 14/29] KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
Date: Thu,  8 Oct 2026 00:14:10 +0000
Message-ID: <20261008001425.2458927-15-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
index 0dbb1962d32b6..51b3ea3d5acfe 100644
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
2.56.0.360.g66cac248cb-goog

