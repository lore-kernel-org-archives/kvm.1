Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF533315D53
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953324; cv=none; b=cfWkzwgEFVW8s9JEF17tDcvol/FtzUTDf4mYMt5t7uR+37+rEVfk/tt0sWmThF/AR7y3CUvUNyrk0OaWCepxtOzJxg/E77ivtxEfgJPVUwpCCBcB7jrMxYl8rJv2Qh7mpXKxz+5/VSOz5kas5YhenZMHDTWX9n8evX/axpZNyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953324; c=relaxed/simple;
	bh=HAAcuTZah9AFCo/cbSobY04EowY8FfFFdtRH4EpAUs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JRph9O+YJ5HJ0bp0Wjg7zS7tZdgVK6umO5X6ukSt392mh3pdT5UZc1nHgvrBr2OUMRTlVB8IbeY/S44Ok2c4kRqFaRzGYgJQgzj3tweyqSFDFTxjzGWvGCQBUtBWQ70o4wW44gxMIJyqyh5NIID3AfczmJSE9KnxgMGw/wed7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKdurXrT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKdurXrT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9aa52c92so6958586b3a.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953321; x=1777558121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PwFbfJ2PZ5ODAqbR6kNliZRtbznaquS7x/WL4idTvrA=;
        b=UKdurXrT/Ml/6Tkly4rZ0ZoZkZ+VJyvUWbkRcd4N9MSy5UiPnUxAIRmAUX3YNeMlUQ
         IW7uqIW0zY+YLBep+AKEsKbJ0Oh1rajBdgQlqoui/Y5KSxazj4axVyscTMZiz2BDKgeZ
         W3lV+nNRuSCS1mCfKRcouv8KMAUvRHMZasLTKc5ml+6Ic2NA5z6gKx6C/tLpDTP0pgZf
         OE8b7I9CsoZLIGQCUoUHbxXterVWOrZJdulNBKyJWpmGdyTGFbYCbKQl6f/AGfv+SoLY
         qCikkaRJvi5m6i8Ivxp6lNq2knqRllNqfJMJ/1h05Sy2xOU5Hn7EfyQdO6IQRrbAJyv2
         Xo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953321; x=1777558121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwFbfJ2PZ5ODAqbR6kNliZRtbznaquS7x/WL4idTvrA=;
        b=iZwJ3oCa5AIkY+Q6LjxMJ2ggmU4qXe7JErrxy41kmPNN6gWKAkzr4jKxYs0wFpMtti
         Gz5dr31YnyZxmkbtSt7Vd39EaeE5M8qd7M1F7rhLrOUdjcVS+9M1ekijVo3bULQuVRKW
         f/h9JhkA0qR1GxzTSZXB8rNAf/89y8V8DXAL7Qn7Y+HxTGLaxnZV0m7JbwClxck4ms/B
         Nah9otj9w+3n3tGySZW1QFyof4MyGrriWPY6CEqmkoI7/Sfw9SmpQZ4dvp5yQVTh7mfw
         87xOENwIrFjnwGKZqsrAdWYw5LDf+eS8Se3kWQf4GUC1aNn/ImS/NT5DJ7AYs0tSCVUU
         pE3A==
X-Gm-Message-State: AOJu0YykuoWn7yY3iTb2v2STpCmqWCKuPg9oWNvCZ76+ev39cuCx+tTd
	uRdZlA7rwJMoAuDxmvsEGxdZJmkZ+r7iquVlHm5f/r3W16lwIe6j/C56zPaw7NZZxzrHbKXnxql
	hCqKzcg==
X-Received: from pfl7.prod.google.com ([2002:a05:6a00:707:b0:82f:7d56:a149])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:189b:b0:82f:9407:d167
 with SMTP id d2e1a72fcca58-83181424395mr7125b3a.38.1776953320978; Thu, 23 Apr
 2026 07:08:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 07:08:30 -0700
In-Reply-To: <20260423140833.439512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423140833.439512-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423140833.439512-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb_flush_fifo()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check for a NULL Hyper-V object in kvm_hv_get_tlb_flush_fifo() instead of
relying on the caller to do so.  This will allow fixing a cross-vCPU race
where KVM can access a vCPU's FIFO before it's fully initialized, without
having to jump through too many cognitive hoops to reason about the
correctness of the logic.

Ignoring changes in ordering that only affect the aforementioned race, no
functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 11 +++++------
 arch/x86/kvm/hyperv.h |  7 ++++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3b7e860bd8d4..3cf8b3cdfc1c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1934,13 +1934,11 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
 				 bool is_guest_mode)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 flush_all_entry = KVM_HV_TLB_FLUSHALL_ENTRY;
 
-	if (!hv_vcpu)
-		return;
-
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode);
+	if (!tlb_flush_fifo)
+		return;
 
 	spin_lock(&tlb_flush_fifo->write_lock);
 
@@ -1967,15 +1965,16 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
 	int i, j, count;
 	gva_t gva;
 
-	if (!tdp_enabled || !hv_vcpu)
+	if (!tdp_enabled)
 		return -EINVAL;
 
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (!tlb_flush_fifo)
+		return -EINVAL;
 
 	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 6301f79fcbae..53534e1004bb 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -201,6 +201,9 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
 				HV_L1_TLB_FLUSH_FIFO;
 
+	if (!hv_vcpu)
+		return NULL;
+
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
@@ -208,10 +211,12 @@ static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 
-	if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
 	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	if (!tlb_flush_fifo)
+		return;
 
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
-- 
2.54.0.545.g6539524ca2-goog

