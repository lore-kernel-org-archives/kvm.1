Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4D331ECF
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860185; cv=none; b=E8FY6EoZ8ZJCCPumHdcFTwkdOjCUyduJ4VJZjcVmDoIBYSGkzMvs/yOfadlnCYaalNBqm9lAgay/K+N81Bu7i3TwNdG+4mlDh8p/FESzlQvZzOGh+u9yMqvnhluPGt3Q6lIRDRNpdgPnWeuZX6xE0Cqs1/ASnnBafO2bGlv7qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860185; c=relaxed/simple;
	bh=0CM4ePGrPZDbJxSN9h7MAZNG0E49a/KUPt6qkQPaDvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UKMxIjjR1ZclFJZxbDVpcvWolxKW+ar0xJp6u+g755NW1Eq1h7tRd9PmDzXD30ZrDtLvetjZkLKOhX0+dOh/qjd2R5Nih4ZzMrtbZxx3brVJ75j04YzIca0c71J4Wfhf43hY9rS8aTA3sED0SKXt7GlqkAyCkaqwMKfNuRVbbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NewHNh4X; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NewHNh4X"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37fb9d7b524so35054a91.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860183; x=1783464983; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GL6Sp7UYjthNgGFEIsiMs4rd/O8JQzBIV/+1R5lvlM8=;
        b=NewHNh4XYYeCjbkL4rb1nqAhFWfMgZc+4vXKbAwrO4D1WiILvD1IPS3yzachnRodm8
         iArJ8406WF1LGcZ+tTU7nJn9Moh2YkYWDdu+6rzN3tJV5gKZOmreneD+1lXyeXC4Yc05
         oLnUk/YCr+8vIwYB/q/BnjubMQjJMOOcQlOcxoy3Pnenh5XGdxKadiTzByffUd8Qh/WR
         Fx7KFHy4RpC3rl6AVgweMX4qy8qjbv0FYRv0qvrn09PCP8VwkpUYF7kXUEKsLqYBg++B
         YONNtuyVrmD05LxzJRSF84o7ksBu22cu9ZQ2SuXkPauO3wp/r315p3kkLRQTqQQxiU/n
         I1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860183; x=1783464983;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GL6Sp7UYjthNgGFEIsiMs4rd/O8JQzBIV/+1R5lvlM8=;
        b=FOglMYhKXLMTsZCGjj0NWZdsgS8CauAiBI95VZ6C97ThoVjekzEN3akNoFvqstWl8g
         pjsl5vLsr6b4P2X+aDrPTJ/Jyo5bypSI4jP/9leMONZKe9bCXinab7mE0de0KYvclZPp
         rXA+uFTOncPZlSGaTsvVOUa3twi8sFbhM6c0HwjW5pUbjvdrZ5r2LKiOcHY1nBcNJY0u
         SIaSiSmGKSw0IHm9D2JjMUeqiR4cKOBHchivtwPJpXj6e3ucMuzEy6kEpYkxTRhyu8UH
         takT45d/7t8WPrFEYW9CQyYNpMCp6XIGGtxZ+JBw2E3WI7+jYVQkcQdQP4epy/agBb5I
         dInQ==
X-Gm-Message-State: AOJu0Yw/upIeAdYmwuYAWAb9hkPRjA4+9PBd1lDJXfEqC9IRPpry+0Qr
	k9YzM2yTsLukeVA/lw7cQ24tnIwB39U5TdZlllUSikcjJADlAwqmosS0Sqmm3ZsJKKFrfFBfAWM
	64j7DgA==
X-Received: from pjbmu10.prod.google.com ([2002:a17:90b:388a:b0:380:83fc:3480])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a91:b0:37f:9ce1:7360
 with SMTP id 98e67ed59e1d1-380527ad756mr4405486a91.33.1782860182969; Tue, 30
 Jun 2026 15:56:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:09 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-3-seanjc@google.com>
Subject: [PATCH v4 02/11] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object
 in kvm_hv_get_tlb_flush_fifo()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
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
index 2dc3e64b3f2f..49b1154366ce 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1939,13 +1939,11 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
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
 
@@ -1972,15 +1970,16 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
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
index 1c8f7aaab063..2da11b967c41 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -202,6 +202,9 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
 				HV_L1_TLB_FLUSH_FIFO;
 
+	if (!hv_vcpu)
+		return NULL;
+
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
@@ -209,10 +212,12 @@ static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
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
2.55.0.rc0.799.gd6f94ed593-goog

