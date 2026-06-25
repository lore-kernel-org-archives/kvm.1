Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC33B8130
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426988; cv=none; b=s8witDvVwzAKUO04NrQjKXw5Eit0JIZ/2aVTTohJ8tVeTfCtD0JdeoJixwcKcEKzp51l4oc6oalMIAvnl9bWwSkvbV2GOg60Odq8GqcERwStQetBXw724LrAf43zzFlO1Q9wmXtwW1mLaKIiRPGiNhom1zOj9YHUov/fCe+xCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426988; c=relaxed/simple;
	bh=0CM4ePGrPZDbJxSN9h7MAZNG0E49a/KUPt6qkQPaDvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJCsvGzAJERdGxtszAqPbvfdoMCBxGbqJexp957wsNKsQzyUIqPoNkjm57KNqGwGZL4kMrswFE0b8oj4IXeT7YmwU2JAQvar+lhXmGWdNyJ9sygQagnSG5l7oS9p5qhJr2V2pS8++1a48C1vAam1JD7gYZgI3m+/oCvUlWw9i0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSKdQeb7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSKdQeb7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894391f000so394737a12.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426987; x=1783031787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GL6Sp7UYjthNgGFEIsiMs4rd/O8JQzBIV/+1R5lvlM8=;
        b=fSKdQeb7ZmFUKXu42w9xZNUNyecQXgCJSxaiFo4BG/ZL6fD3lggZsdtwEo3svTNA3n
         bquIwr5iaxVdCrmly9Z2KO9Mqb1mWk+sZB0bRaJ7L5DB1qRW8A98ZLKSA/Jsv6rVGzoT
         GKMfKteT2/sj1Z8qxPr54g67hL2h0MldKTzurVTeNfNR16KbVM5tuuTvLW4oOXUwproj
         RR/73fZoekL2MbLqdBxjFgYHscbpDx7e46X0eYg2O0niiCte7TsepFjWYQof53MERbBN
         t4gGPyz1QkH8U7Qb3OkhAVsRL2TO3C+17bGlJYnO93oLtgE7cwakk69T0Q7dNvA4dUuH
         GJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426987; x=1783031787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL6Sp7UYjthNgGFEIsiMs4rd/O8JQzBIV/+1R5lvlM8=;
        b=EKx02dwvdh92+z5S0gm8wT/NuNGFZs11csBn52Cr0oaXqSh9o7YaSXY58S4msC5/ah
         5uYiERo6qjsyxYlnnXtHQRn+j22LkWxT0lHL3Dnw0UxqLo7BSpKuyUqNw/R5CPyAKQgZ
         em03ShzJ9Bp5G83k2GYX8K59PMAiuooGyFCaaPzwb0Oq56FCsE13tbG3aQoUh9chVIbJ
         t82bj1JIIOZfDXcKUTpt8yDIWESD+SN5Fq6KBGZQjXogv4sD6pZMchqg6ibQNLubLy7G
         023Dh7w73q5cPMb6LCcNDfKHNlFvPIXeFJrLNqmRXyRmJNyo7n08ELAKbrDsMLMmWuJX
         jKNg==
X-Gm-Message-State: AOJu0YwIcTk7IIDFFqBO02fPi5Vcdt9o+hL2c5cA+TxFrJTQ5sas99v2
	3fg2MSiUOEsSA7DxbWtfeiu//XH7jyl9HyeY16s5Nzqz6IDZ/POVeAju3lwr4puGS8PfPpDyXN9
	yGkhblQ==
X-Received: from pgng24.prod.google.com ([2002:a63:3758:0:b0:c93:a359:cea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db92:b0:3b4:7aae:1ef4
 with SMTP id adf61e73a8af0-3bd4ac275f7mr5820096637.9.1782426986603; Thu, 25
 Jun 2026 15:36:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:15 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-3-seanjc@google.com>
Subject: [PATCH v3 02/10] KVM: x86/hyperv: Check for NULL vCPU Hyper-V object
 in kvm_hv_get_tlb_flush_fifo()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
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

