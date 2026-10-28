Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219175;
	b=eDSASzUfrVwXz14CSbyF4BxLKWwnuS1UKGH/D1lnDc9iIxH3Ol5lr23lsngrTR/kZX9Q
	 KI8DFekUZMcm3FkBZAwnsiVTrm4nViz3X3aRrAKu2gIjUS3QVwq5WJnkV0DX0I3B65E/3
	 i0mCuKLeD/fqq8Mf8k3IEd9zYKIxPaf+Lo6gESqY+/8Yjs36fb/a/BWkLx/fy8BotQJ6l
	 EzsSMqGTkW7P1XAhUuSPKjx9snH7P1u3x5DIJNIu86hGS6VTfN75AxYRZdrDe8Z8dtlbz
	 pRF/S5b6Fkv1AoGnRI6GjdSRIcjCRx0SNkF1ZqsJF9cB40QeBoSg8HFBSqYrm0W2Uzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9C07IryRGsBVGXruGSb5dwHcNUfmVbbFhhcLmi6Efy8=;
	b=OPm2+XAK2AK1HJmVr2NuLHDv/211D9QmAmc4andekSyo9bFpTJQBoG8OrKs175uMaT1K
	 9HZYH3QvpRmdEV/XLUPLzNGoagrvJusSE/x4ryqSizd4GQ2rF7fs2+iLGcjNKO08Soa9i
	 T4DWTLQ5C/3pPEYEB1dZ4wJ0JSrFN+Pm4Yf2eGjaT9SEZ7jH0jePLdCPXcbOrbn/kavj+
	 thYhJbS4EXnoXdTSLpmzw5QIQUgEyTfjh8RK+LO7rDn6H4QVroM0O8VGLGJUoI+qG6+fb
	 ClYHekVw6mAbJeu/WDJ9OhoiGKmXyhRIGg+dYMsCKKr2aU4LKhcoCWV4RaQR1Q3J09w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1Mq68K;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C72606A33F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C72606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AV1Mq68K
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so37556a91.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793219174; x=1793823974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9C07IryRGsBVGXruGSb5dwHcNUfmVbbFhhcLmi6Efy8=;
        b=AV1Mq68KBQnEakbG0NpZwoWnnbXnne3bM2VR2Ndfo12crYRAF3BM0DnalYN15wu62z
         T3mZqmvnRERBut7JxPNIr3qUzn2eK1CGjLocByU3ozzVnJOAnqfiB1wtapOY9xU9SYyC
         rlZCVXShNLtE2VR3AywqX3ccIK2l+kRNRWwY0FBF6WoXui14aepMQpXJKUt2Eo0m66wG
         bL1oKWtGNW30ZnVl6qUxPyhw3dFmd+XzlVeifKgliok5SLtTNhpf5rxBQX8C9WhNDahz
         1LpFueHCmlrpZIaiCP7PfIKem3BPPj9KxDegZhdR0Ax/FtW6cn7dXm0jFZ9i/1Y86O8H
         KxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219174; x=1793823974;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9C07IryRGsBVGXruGSb5dwHcNUfmVbbFhhcLmi6Efy8=;
        b=pOIfFbonGcqZqmv4EP2LlllQ36tT0x1kEvn4mZdOM0TcqRdM0YGPZCe//v7VoQNy4+
         6FSJOa1FZ0wjnXSJdpBzxHzRhS19MMIxxw4qmbsP8/eeZZe2H06FDhi9enl4SyLnGiE3
         TFSRaHtXTE5Uh1R5pZ3+IWkDTqkNVCk38nw5XKA1Y8ZJZd42OnuYJLlzDbSCu7TqNhm3
         Hza2KEIfe/RvQsfIkd6yeR7aTxNgxRB/qe7HMINyX/iCtopVslXeoyzNQih0Hwd72my0
         +sHJFcux5yFWNbLADHtXHZsEJdGv7k6BnR1OwgQ3fUR3BDi8ICTfANwUtgQrAwrHwLCS
         ZJuA==
X-Gm-Message-State: AFq9FYJmM04stFuojJLJQFQ+cG6A8YxaR77lbrGhoScJTzzIUQHTOsyK
	NGW5o0heiCb9ZY+QER5++HuzWJUOoIurXsCb9JHSVgC36QQ41Q0hMIpWV/LLRNEx3GC1liHslxO
	Dmfx42Q==
X-Received: from pjph15.prod.google.com ([2002:a17:90a:9c0f:b0:3ac:92a7:e8d8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc1:b0:3ac:9ed8:f301
 with SMTP id 98e67ed59e1d1-3ae6ed6bd58mr284625a91.30.1793219173927; Wed, 28
 Oct 2026 13:26:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 13:26:05 -0700
In-Reply-To: <20261028202607.1844883-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028202607.1844883-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: x86/mmu: Differentiate between manual and automatic prefetching
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Marangoni <mamarang@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Differentiate between "manual" and "automatic" prefetching, where automatic
means the prefetch is initiated by KVM without any corresponding userspace
request/command (KVM_PRE_FAULT_MEMORY) or guest access (async #PF).
Tracking auto-prefetch "faults" will allow implementing prefetching in the
TDP MMU using the standard page fault path, without breaking existing
prefetching rules in the shadow MMU, e.g. don't auto-prefetch if the slot
is being dirty logged.

Arguably, async #PFs could be considered automatic, not manual, but they
_are_ initiated in response to an explicit guest access, and unlike true
automatic prefetching, KVM generally wants to put more effort into handling
async #PFs, e.g. wants to punch through dirty logging or wait for I/O,
precisely because there was a prior guest access and so giving up likely
means a vCPU task will end up paying the cost.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 26 ++++++++++++++++++--------
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 393feeaddfb1..3bd0d921778d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5031,9 +5031,15 @@ static int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *faul
 	return direct_page_fault(vcpu, fault);
 }
 
+enum kvm_prefetch_type {
+	KVM_PREFETCH_NONE,
+	KVM_PREFETCH_MANUAL,
+	KVM_PREFETCH_AUTO,
+};
+
 static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-				 u64 err, bool prefetch, int *emulation_type,
-				 u8 *level)
+				 u64 err, enum kvm_prefetch_type prefetch,
+				 int *emulation_type, u8 *level)
 {
 	struct kvm_page_fault fault = {
 		.addr = cr2_or_gpa,
@@ -5043,7 +5049,8 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.present = err & PFERR_PRESENT_MASK,
 		.rsvd = err & PFERR_RSVD_MASK,
 		.user = err & PFERR_USER_MASK,
-		.prefetch = prefetch,
+		.prefetch = prefetch != KVM_PREFETCH_NONE,
+		.auto_prefetch = prefetch == KVM_PREFETCH_AUTO,
 		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
 		.nx_huge_page_workaround_enabled =
 			is_nx_huge_page_enabled(vcpu->kvm),
@@ -5097,7 +5104,8 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 
 static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
-				 u64 error_code, u8 *level)
+				 u64 error_code,
+				 enum kvm_prefetch_type prefetch, u8 *level)
 {
 	int r;
 
@@ -5120,7 +5128,7 @@ static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 			return r;
 
 		cond_resched();
-		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
+		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, prefetch, NULL, level);
 	} while (r == RET_PF_RETRY);
 
 	if (r < 0)
@@ -5175,7 +5183,8 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	 * Shadow paging uses GVA for kvm page fault, so restrict to
 	 * two-dimensional paging.
 	 */
-	r = kvm_tdp_page_prefault(vcpu, range->gpa | direct_bits, error_code, &level);
+	r = kvm_tdp_page_prefault(vcpu, range->gpa | direct_bits, error_code,
+				  KVM_PREFETCH_MANUAL, &level);
 	if (r < 0)
 		return r;
 
@@ -5207,7 +5216,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
-				  true, NULL, NULL);
+				  KVM_PREFETCH_MANUAL, NULL, NULL);
 
 	/*
 	 * Account fixed page faults, otherwise they'll never be counted, but
@@ -6681,7 +6690,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (r == RET_PF_INVALID) {
 		vcpu->stat.pf_taken++;
 
-		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
+		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code,
+					  KVM_PREFETCH_NONE,
 					  &emulation_type, NULL);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index c29002c60126..b02cdacd3e42 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -228,6 +228,7 @@ struct kvm_page_fault {
 	const gpa_t addr;
 	const u64 error_code;
 	const bool prefetch;
+	const bool auto_prefetch;
 
 	/* Derived from error_code.  */
 	const bool exec;
-- 
2.56.0.313.g2479322e68-goog

