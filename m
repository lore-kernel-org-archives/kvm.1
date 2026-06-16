Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AA280A58;
	Tue, 16 Jun 2026 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570549; cv=none; b=chFPe3zt6xth8S3ku9aJcJqQ+bg7nGKeRITbT4ryHU4+dDoJ1n5n714Cjn9O0OACd/gI++Nb1bISgks9ZPmOg/qdpGuZiJ6XI9O3XQzQIw1g95T793cCWHD0H8VrcgtgQXAWY9Ar/FFSe0WTd1oW6fSI6ORtHN5weuLo0NLTG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570549; c=relaxed/simple;
	bh=s3ZqvcwiPCzrZ+GC17qqLMT4QBZZr8NpysRUC/GjZOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJLZxxTL+VCGMNZBGHzDhc1tludZ4AruW6Tl8SqmNva1gZgj5/8PAE7lYTp4ZqZHwG8KR7MiUKWKMIdEtYNo7HRthjlzUfnxV8/n2MnVvf7N/8v6NvybmZHtbjNc49+9cWwGOPc9QjN0niFiN5GeMzQw1z4jaMc7JdomNGISHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqbDTU/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqbDTU/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9561F00A3A;
	Tue, 16 Jun 2026 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570548;
	bh=vRZwbJ/6/FxzFNxxGga1LbN5ISYvyapL4p9QWIS4N1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aqbDTU/jRBvbgSuJiYdXTM7Bl+GO3h4e9Ga0gDhalX5I75LzT+aHZDIoaG37yHoWN
	 NGprxOypr9Mp/7q4MPhH0C2qInmanMV8/SUYEYdzbiBanaRwXlzSHNeOeZowjHmaVI
	 mpH0GFlHpFyYcN/XM/Lgj70TaW3Z6EUVr3elAQDrqAf8CAo5zrn8KNeH27zXVFBbX9
	 RybQ1t8ZhBKwjcroj1FJi4FpcXDpVX4SaariPlJhUFZecJfGZ/BN/nDU3PafbR/mu6
	 z+/7t774+8jiG7e24yp9u4lSQ/jKNjp0503IH/PAfX5bmjIeVsiX+RukboFh27v/jQ
	 eXZroFQmt+mrg==
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
Subject: [RFC PATCH v2 13/25] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
Date: Tue, 16 Jun 2026 00:41:42 +0000
Message-ID: <20260616004155.1435766-14-yosry@kernel.org>
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

Flush both L1 and L2 ASIDs in svm_flush_tlb_all() to appropriately
handle KVM_REQ_TLB_FLUSH by flushing all TLB entries in all contexts
(e.g. for kvm_flush_remote_tlbs()). Since both L1 and L2 currently share
an ASID, this is effectively a noop, but it won't be once L2 has a
separate ASID.

Purge all Hyper-V TLB FIFOs (for both L1 and L2), since both ASIDs are
flushed, and an ASID flush is a superset of Hyper-V's fine-grained
flushing (see comment in svm_flush_tlb_asid()).

Note that if one TLB flush FIFO is purged (e.g. as a result of
KVM_REQ_TLB_FLUSH_CURRENT), it will consume KVM_REQ_HV_TLB_FLUSH, and a
subsequent KVM_REQ_TLB_FLUSH will not flush the other FIFO. This is
alright as flushing both FIFOs is a (newly introduced) optimization
anyway. The other FIFO will be checked after a nested transition, as
KVM_REQ_HV_TLB_FLUSH is always set on nested transitions.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/hyperv.h     | 6 ++++++
 arch/x86/kvm/svm/nested.c | 1 -
 arch/x86/kvm/svm/svm.c    | 8 +++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 0f64038408072..6f212d5fc8d50 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -231,6 +231,11 @@ static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu)
 	__kvm_hv_purge_tlb_flush_fifo(vcpu, fifo);
 }
 
+static inline void kvm_hv_purge_all_tlb_flush_fifos(struct kvm_vcpu *vcpu)
+{
+	__kvm_hv_purge_tlb_flush_fifo(vcpu, NULL);
+}
+
 static inline bool guest_hv_cpuid_has_l2_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -302,6 +307,7 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	return HV_STATUS_ACCESS_DENIED;
 }
 static inline void kvm_hv_purge_tlb_flush_fifo(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_purge_all_tlb_flush_fifos(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bc8c466a1f821..eb56c2fbf2832 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -694,7 +694,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Flush TLBs for both L1 and L2 remote TLB flush
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dac3d0098bb77..4f13c3456a5d7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4203,6 +4203,8 @@ static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
 
 static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/*
 	 * When running on Hyper-V with EnlightenedNptTlb enabled, remote TLB
 	 * flushes should be routed to hv_flush_remote_tlbs() without requesting
@@ -4213,7 +4215,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
 		hv_flush_remote_tlbs(vcpu->kvm);
 
-	svm_flush_tlb_asid(vcpu);
+	kvm_hv_purge_all_tlb_flush_fifos(vcpu);
+
+	vmcb_set_flush_asid(svm->vmcb01.ptr);
+	if (svm->nested.vmcb02.ptr)
+		vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
 }
 
 static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
-- 
2.54.0.1136.gdb2ca164c4-goog

