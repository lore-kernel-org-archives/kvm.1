Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4547ECD3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093411; cv=none; b=q1uWdormuEIMf1BfCYnKT+wNAAUMYAqzsTKi5jeFz0Qz6zt0vhbKQ/0YpPjHyPDJEbQs6awkckfawfZxHMsNAY8W0F2zJhk1wOiqknYxUOj2i39ctlJD3nXLGsR50VsQq1vdTFpB81qkI16W19oBC4piXldXGlCCZSaXmlpn5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093411; c=relaxed/simple;
	bh=6wkYDhTrv2mLr2QDxNjAG/d6sB8lrG23VG9S3UDHwwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NTwBPkjYmkfr8I3ySfPFp3dmV+Co6cQCJL9UTI5D8Eo1lR0LNtT1XYXmugdmu/lwV1SX69XnKgh+yWG9Uxx6dLm/6LZ6Qv2EgC2UUfC8muTP9UJmX5uHA5RLccVpQl7jcVkPuYJ+P81N2kpySn5Dj9+xQXTFbUfTQfB9bwJpgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ReEWxTh/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ReEWxTh/"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c829366cf25so18244984a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093409; x=1780698209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=C5xIBF4dxThLK3TpNNRniIv9BT/2RVg6EsLkvI68oaI=;
        b=ReEWxTh/V2OZt66YIMn9VfbsVJOjO5Z6ON4u/k2KVfd81QdJ0Zx2QfyacdQGr6TfDY
         Z9yZPBFWOeMBBAXJ/hyFNC4rmQ1CSEt5kOoTnXgCDiehO47k1mKWEAHmHLDydnqt7gdU
         F/aEjeRyYfujegKoUppMpHIK1KkYbBxLHRUlwZ2AhJ1MAL6M/xOvHdPmw7ILZxy4HL+5
         CQ9fKY7pX9GIOVqezIUIlYFrwZoedNakGwLXoUowXYw96A7zQV5a6kqYYRxL3KLJR9K5
         EquF+hZnl+qm1h05YsfOwrGzzYD1qVROJmEdLsZ4gCidMK041A2K56e8g4nAS6+cV5Hw
         KbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093409; x=1780698209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5xIBF4dxThLK3TpNNRniIv9BT/2RVg6EsLkvI68oaI=;
        b=RRZvImlgSeEmJPcqulpz10svanXFQsTIZM2kNo2+BHBbUi+XKT6iHL8UmoC8QjTm6b
         7bIwQS1IW7bEdiK0sDmj4B3W7sRqfLWj4mYtJxb4lRjIrk+Ns07rtz3lG8NwsD1/x4IV
         ZaPJty/Y8uKd+auctgy2AR2lqsIr9GpBGmJ5mQhOH9yWxItybeem9FQwOChL2PrzsQHW
         BDpSvSpFn72u16oedyM5aWmqP3tr1JX/Bz7CpUV/Lb3awesFM0pU+FvHKwv9Eun3vcCv
         KuGabXc/oAyPeicrLLfI03tIhyshVMQoKv7VtvpdNP13uQ4sdRzV+R6bgN/+iYOhjvig
         iPXw==
X-Gm-Message-State: AOJu0Yzgippl8PbD6qOX/dTZMlydnJTp2ZjunziJSejbFdNEC39snRcR
	OqS7CS0KWYbdOEdc2zZkPUYJHiBjRWuCjYQpb1B3oeGn6NAqSvXxuFxYZeQ4nKby7nxLiPybKt9
	UhzaQSg==
X-Received: from pgum19.prod.google.com ([2002:a65:6a13:0:b0:c79:61dd:3232])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7105:b0:3a8:9dd:75d5
 with SMTP id adf61e73a8af0-3b4281d6c58mr1272726637.24.1780093408888; Fri, 29
 May 2026 15:23:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:21 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-39-seanjc@google.com>
Subject: [PATCH v3 38/40] KVM: x86/mmu: Move kvm_arch_async_page_ready() below kvm_tdp_page_fault()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the implementation of kvm_arch_async_page_ready() "down" in mmu.c so
that it lives below kvm_tdp_page_fault().  This will allow moving
kvm_mmu_do_page_fault() into mmu.c without needing a forward declaration.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4d971d42f0e..f217e71c3af0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4571,37 +4571,6 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
 }
 
-void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
-{
-	int r;
-
-	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
-		return;
-
-	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
-	      work->wakeup_all)
-		return;
-
-	r = kvm_mmu_reload(vcpu);
-	if (unlikely(r))
-		return;
-
-	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
-		return;
-
-	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
-				  true, NULL, NULL);
-
-	/*
-	 * Account fixed page faults, otherwise they'll never be counted, but
-	 * ignore stats for all other return times.  Page-ready "faults" aren't
-	 * truly spurious and never trigger emulation
-	 */
-	if (r == RET_PF_FIXED)
-		vcpu->stat.pf_fixed++;
-}
-
 static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
@@ -5058,6 +5027,37 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	return min(range->size, end - range->gpa);
 }
 
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
+{
+	int r;
+
+	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
+		return;
+
+	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
+	      work->wakeup_all)
+		return;
+
+	r = kvm_mmu_reload(vcpu);
+	if (unlikely(r))
+		return;
+
+	if (!vcpu->arch.mmu->root_role.direct &&
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
+		return;
+
+	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+				  true, NULL, NULL);
+
+	/*
+	 * Account fixed page faults, otherwise they'll never be counted, but
+	 * ignore stats for all other return times.  Page-ready "faults" aren't
+	 * truly spurious and never trigger emulation
+	 */
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 static void kvm_assert_gmem_invalidate_lock_held(struct kvm_memory_slot *slot)
 {
-- 
2.54.0.823.g6e5bcc1fc9-goog

