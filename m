Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD376BB5B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271451; cv=none; b=G93Stra3dj9lwetPoMr2N+hg79R8pLK9VfELytgD59n59yb7RlOmO68qMSDpPpKiAyzpQnm87wCkjKSIcHW/LzSICsgQT/iCMZF36kbFZctR2rDroNxNY5s1yK+mW8pY9HCecl+mVGQKJ3HUXyydgfe0YjGEuLLiRpnX+NYjyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271451; c=relaxed/simple;
	bh=TJ50PwBAfuABED22863kivK320tuLglF5DIXcDN8CR4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EJAX6PMzHRfBaDEBAq+XCRGtpeKkdK7wkQPZzrLJOx11Kj8WP2PrnA2QB0UjlAuGff9bZIvd6pr4aiUlYTIFen79euWlHCcXRBgYAgjqMqZaTpA2ni+k+k3TS8OfV8igip/0o5ii4AQDG0TXBIx6OfyHaiz0evr0MgVxp2dZz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOj5eLMs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOj5eLMs"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso1240914a91.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781271449; x=1781876249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPOJWxYYWDWDnJINU6K8lAt52NscNTk4Ebm3y3at6hM=;
        b=GOj5eLMsjgduBepur+ueOVeu8WKCup6npR0mf5VyIh4CVedcFHPop8gQw6lzg+Zjb3
         lmQrVUfSxJxNHGlKIr1gGcf+vEepc4nZhIXKJybDRQ7RmlO2upRQIl/YtBADIzH65lyy
         69qWVtagcW/IpoSjuS7XY2ABTuJsEvBph5ApMlYJYcXoTNERYT7Mk3rWZCsvnwmUqt0+
         xKrFQTA2MfiIjetquLzyKqR/Dv17o2WfKHKY/Mf6If+mWzMCnZMTbSyW4e+QP/eNuQzw
         TlPDfXfp/vqh1eNpOg9kLGT4p+7OR9zBLrFR8s7xEqV04aURgpV5h9P22xHlxTLDWbWV
         tGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271449; x=1781876249;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPOJWxYYWDWDnJINU6K8lAt52NscNTk4Ebm3y3at6hM=;
        b=XOPyQzUEmI5HyLUPXkQ8suxSKOxV01cAQEWnwpHmvQbCOw+tVrN/j+riz2PbJs4XKj
         k4Tz8YGPZkJ4LxNWfRFtz4luG1orv8RgV7dJsQC9Ad2VgUNBJi4PijuZC9T7JlaZKYvk
         Hte32McW+1V2TWdcBoIF54TGRtessEVmm9xdwFummzn10oFIdZZEspSOl28tq1LDlF+d
         pEQenUXf3A7osIkgALBYL5UroE/sPwTVfYtr+TIrKXpUn0MgZ3Zhw0Vb1tjR79RrAx6v
         sc2CccjEs8qSkJ6Hu09Ow+H6aVCJuq05QYwTt/34420U5X5vG0fbj1XXm5uL/F49e6tO
         Gs+g==
X-Gm-Message-State: AOJu0YytUoqBKTEEYgPVBznfftBnMTgMERVN/VRVX/iRtwpOy4VKuqYT
	NgxRr9V2xyufT2oNyfhDTNv7Om04GPI8+UtHAQ1gDHk8H3EuFAdap/bnYJQXZTpuQelbu1CA4wW
	3b+C04A==
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:369:2b54:e186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:35f:b987:4dac
 with SMTP id 98e67ed59e1d1-37a038e1f1fmr3171494a91.12.1781271449147; Fri, 12
 Jun 2026 06:37:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 06:37:27 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612133727.411902-1-seanjc@google.com>
Subject: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages as
 a stat
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

v2: Drop the definition of n_used_mmu_pages. [Sashiko]

v1: https://lore.kernel.org/all/20260605174611.2222504-3-seanjc@google.com
 
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 14 +++++++-------
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/x86.c              |  1 +
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a5..c2b86b1420d1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1435,7 +1435,6 @@ enum kvm_mmu_type {
 };
 
 struct kvm_arch {
-	unsigned long n_used_mmu_pages;
 	unsigned long n_requested_mmu_pages;
 	unsigned long n_max_mmu_pages;
 	unsigned int indirect_shadow_pages;
@@ -1701,6 +1700,7 @@ struct kvm_vm_stat {
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
index cf122b8c3210..9d43e476707e 100644
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

base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.54.0.1136.gdb2ca164c4-goog

