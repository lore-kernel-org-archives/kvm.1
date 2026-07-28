Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CF1DCB24;
	Tue, 28 Jul 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198971; cv=none; b=nKsCjJfnM8q9DJu7o/vn1gNBNAY7AGl7F0zCWd+n/vBd+b1dyJ+nmfdnyhAq1DyQZYskhB8UlsRhzYLTifhc//4zSa/99mcAWmOixmcWwWAaK5SAYp0rhjYGm2itPHD3hbFJQrKQUDvH+el5bzoecRusUSwmULqGXE23cLW4FAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198971; c=relaxed/simple;
	bh=fVNfngVKaGMwmDjH9/dIUFZbm/iVsjHfRwGjSypNXpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzJHi8M5k21tatdlT1lkz0+QKYqo/uDkIwj/Ekzg2jP3E1h5Ke0qmfWMqahIyJ0uS7djx/rPSh4lCW2xUhEYWTEvZfZExMNBsZOpHPaIyy3RUQC7z0xci8sVGBnWOzOvujeQ1QjFQ3HQQsd/+jnKI6zWMB7UaXU8CygTmhsmdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCev5/qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCev5/qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460B1F00A3A;
	Tue, 28 Jul 2026 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198970;
	bh=CLIl5bIZ5AzTEuFcTIrLxRwyd55/jvC5PQKQsZK2T9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCev5/qa3ahyk0jvll97+i1MwbrpEwto3bm1FQjE797lA9s5ltx5scFZyA3xBMK+r
	 WkGYMb/PGW6Vl1O2apoepF3962hRk0yG0wXkQ1t3E87AmDau3+3aI16zILfzHn+/ep
	 K9okvIktY+xK5Tirxdta8vPhL1C2yd11VAgmHOTLuI+2xFWT3CbkL6cdkkcB9RnnA9
	 kj/7GcGFRvGJmRYVk0MzbkRCeDDbt96Tc6F64H0xOqDi2jQ/19iTHZKaxzBGXJneOg
	 4EAk6FeulaOKy194hvDNskVUqxl4uJx5tErBEPGXm/qPip1zYDtm+bqtLc4ynEIrb0
	 aQjWThh0YhnaQ==
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
Subject: [PATCH v1 13/28] KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
Date: Tue, 28 Jul 2026 00:35:42 +0000
Message-ID: <20260728003557.1136583-14-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
index 30a295785c68a..991171df83486 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4195,7 +4195,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
 	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 
 	/*
 	 * Flush only the current ASID even if the TLB flush was invoked via
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f1a829032c06..6de69ef21d9be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2019,7 +2019,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
 	 * grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_purge_tlb_flush_fifo(vcpu);
 }
 
 
-- 
2.55.0.229.g6434b31f56-goog

