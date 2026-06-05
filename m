Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007E3806B6
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681584; cv=none; b=iOT2JByPf1F45XyEJz+jbx/769QJuVNnzH9a8IPkNarqXwT8vZRtl7VwyqqJOA/igHYD+Sjn0U6P93/Hie5wQRYtXxvAJz0DG+4BL0jcaYPAtPsMo6yn+Ht+SMkskGFeWuDEZ5R4omi/hvM8QgH/7rdS9VDwIbeUh2iCBwcVqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681584; c=relaxed/simple;
	bh=MaGp98SPP5pLqA/SgDcjONweIRAww8zV/cITU0dzni4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=js8+NPu3pBgyIQ1FzolJKh4L7wZ5BxwtaXUn0z2cH9uDhQDrkkreOwTkS8IlJShzrLpvFGhbodz6p+i/H/YP0KNfkxli9yUTeNGfzAOHjXhYAxCAhIQlQJilMdvWEZLmT3hknyg/AS6APInLmaeu8qn3TmsH3Z1vYFE8s8JuvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLPmjcrO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLPmjcrO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0532a6588so21373465ad.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780681576; x=1781286376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eJAya2rWHdwTV/i2f+Er10bBIZ9X+EeemiuR2u/Ktcg=;
        b=hLPmjcrOLQv8Fk/0+sIz7aqsAOcUWtQcMMs/gUMdknHrZFmtmVZ6LNSPN9kXZo/wNq
         1G/ETn8Ck/4N8P2BNWh1QY+Z7MWlGJlxtUsFg3zS0tHtjZAU/G6wVws8nqsG1BUD6/PR
         fpLZGmVOYK3DRFOHie3R10z821mlxUZQvrP7SuQiKpgtNytDQNJb99tLgB5ha6BDrphE
         ezNbK8PdG9R5xu2xS2AMbpHc2bP4uecZkBMpsftqiB8QeG/hCkSJWwFNBzvQyn/bVG+9
         HaUmfP+Fyjw4SXHwjBCcPwdoMx9FhnLsnVwJfGjbCtg/84e3xM0g917Nm2UkaXihU8P4
         mP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681576; x=1781286376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJAya2rWHdwTV/i2f+Er10bBIZ9X+EeemiuR2u/Ktcg=;
        b=PUQ/cMChuAIPwIG3nVa9UoArvoV75Mh/EjpGW2usuNcNpyPwwfinDHcV4u0zWG5QAi
         wgc5I0iap+ie+BDPvq4tXfWdsFucJuNQR8fi6efE2agIV1bvNCg17f0rFJT7TSp9v7dn
         IgYrGdjV2+f48rrFj9SwULNC3XB9nMb6NUCy5hAPEU2pWsRMnhjxGe/zJXosAdVip72E
         3SBN45HE4Fgby9p3ntA8wNJmVo/k0nY8skIcmbWWmWA0NQQk0A6sTh4kLLAKJrcYdtEj
         gB3HNWnFlvx0Bnjz3d4EnBgCWJOoF1oE1wB407ZOIFTaHBO0AlclNMQn5aN4b2plnabb
         07kg==
X-Gm-Message-State: AOJu0YxMgsUnfKQdRE2YhrQK0A3RVyRZwvenwfpDzQ+fNg+cqp6RyHmr
	8rgNIQL1oJpCJOybnSl7DvGypVJRmEuIihYRM2Q/KWheQG5ACy7HO3oJEmnit1RRmVxxPN5qdav
	imzyjMQ==
X-Received: from pgam25.prod.google.com ([2002:a05:6a02:2b59:b0:c80:26d4:20ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:514:b0:3b4:b6d7:a992
 with SMTP id adf61e73a8af0-3b4ccd1e2a2mr5750363637.8.1780681575824; Fri, 05
 Jun 2026 10:46:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Jun 2026 10:46:11 -0700
In-Reply-To: <20260605174611.2222504-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605174611.2222504-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605174611.2222504-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86/mmu: Expose number of shadow MMU shadow pages as
 a stat
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Turn arch.n_used_mmu_pages into a stat, mmu_shadow_pages, as the number of
live shadow pages is arguably _the_ most critical datapoint when it comes
to analyzing the shadow MMU.  Before the TDP MMU came along, i.e. when the
shadow MMU was the only MMU, explicitly tracking the number of shadow pages
wasn't as interesting, because the same information could more or less be
gleaned from the pages_{1g,2m,4k} stats.  But with the TDP MMU, where the
shadow MMU is only used for nested TDP, it becomes extremely difficult, if
not impossible, to determine which SPTEs are coming from the TDP MMU, and
which are coming from the shadow MMU.

E.g. when triaging/debugging shadow MMU performance issues due to "too many
shadow pages", being able to observe that 99%+ of all shadow pages are
unsync is critical to being able to deduce that KVM is effectively leaking
shadow pages.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 14 +++++++-------
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/x86.c              |  1 +
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a5..be84e4d2405e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1701,6 +1701,7 @@ struct kvm_vm_stat {
 	u64 mmu_recycled;
 	u64 mmu_cache_miss;
 	u64 mmu_unsync;
+	u64 mmu_shadow_pages;
 	union {
 		struct {
 			atomic64_t pages_4k;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9368a71336fe..3839aef6819b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1801,13 +1801,13 @@ static void kvm_mmu_check_sptes_at_free(struct kvm_mmu_page *sp)
 
 static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	kvm->arch.n_used_mmu_pages++;
+	kvm->stat.mmu_shadow_pages++;
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
 }
 
 static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	kvm->arch.n_used_mmu_pages--;
+	kvm->stat.mmu_shadow_pages--;
 	kvm_account_pgtable_pages((void *)sp->spt, -1);
 }
 
@@ -2833,9 +2833,9 @@ static unsigned long kvm_mmu_zap_oldest_mmu_pages(struct kvm *kvm,
 
 static inline unsigned long kvm_mmu_available_pages(struct kvm *kvm)
 {
-	if (kvm->arch.n_max_mmu_pages > kvm->arch.n_used_mmu_pages)
+	if (kvm->arch.n_max_mmu_pages > kvm->stat.mmu_shadow_pages)
 		return kvm->arch.n_max_mmu_pages -
-			kvm->arch.n_used_mmu_pages;
+			kvm->stat.mmu_shadow_pages;
 
 	return 0;
 }
@@ -2871,11 +2871,11 @@ void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long goal_nr_mmu_pages)
 {
 	write_lock(&kvm->mmu_lock);
 
-	if (kvm->arch.n_used_mmu_pages > goal_nr_mmu_pages) {
-		kvm_mmu_zap_oldest_mmu_pages(kvm, kvm->arch.n_used_mmu_pages -
+	if (kvm->stat.mmu_shadow_pages > goal_nr_mmu_pages) {
+		kvm_mmu_zap_oldest_mmu_pages(kvm, kvm->stat.mmu_shadow_pages -
 						  goal_nr_mmu_pages);
 
-		goal_nr_mmu_pages = kvm->arch.n_used_mmu_pages;
+		goal_nr_mmu_pages = kvm->stat.mmu_shadow_pages;
 	}
 
 	kvm->arch.n_max_mmu_pages = goal_nr_mmu_pages;
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index fa01719baf8d..8354d9f39777 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -303,7 +303,7 @@ TRACE_EVENT(
 
 	TP_fast_assign(
 		__entry->mmu_valid_gen = kvm->arch.mmu_valid_gen;
-		__entry->mmu_used_pages = kvm->arch.n_used_mmu_pages;
+		__entry->mmu_used_pages = kvm->stat.mmu_shadow_pages;
 	),
 
 	TP_printk("kvm-mmu-valid-gen %u used_pages %x",
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd68a5bad0c6..e4cbecaa105d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -244,6 +244,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, mmu_recycled),
 	STATS_DESC_COUNTER(VM, mmu_cache_miss),
 	STATS_DESC_ICOUNTER(VM, mmu_unsync),
+	STATS_DESC_ICOUNTER(VM, mmu_shadow_pages),
 	STATS_DESC_ICOUNTER(VM, pages_4k),
 	STATS_DESC_ICOUNTER(VM, pages_2m),
 	STATS_DESC_ICOUNTER(VM, pages_1g),
-- 
2.54.0.1032.g2f8565e1d1-goog

