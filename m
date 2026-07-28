Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FA6FC5
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198212; cv=none; b=o4PAr5zl8be6dx0L23L8MaANacHO7S60NMw4cf3BG0AQON7MUqz4QvjJfUkfGgWE2pNaoM5nQQHjEyb5oovpq4iKhRKHGtlWFhuehYO6jBzHysDE9sypwBzkbiaLUvcrK6/dwXGNKBTHGV93gAEwAoKhq0de+VkBNPWJM3HILwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198212; c=relaxed/simple;
	bh=bmouPw2YcCX2TJilsOaheT9gm3E7YUI9a0DMClF1a1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qj+z26dC1xAAhxvIMyTjWHeg7beMx39szqCn4tfwoL9RfeqdQqX91j4GVO09E0+WTyvW+ychRqU/CjlwMo5okzul/kpsdrfixFw8D91KdEOo1sGcwE0/yiJRTWpb7meBrDgdEm3b5kW+bvb1YHlg90pQmxjECp4xF3p5tO9nIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kob0T2Vh; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kob0T2Vh"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso44687535ad.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198211; x=1785803011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oxngIn4iftEseWLY0wyG/D5gLEEPwcj0xQ+XgFLkB2g=;
        b=kob0T2Vh9BfjxwBVQudcW/D+yL0/jU5wKL/0sYEOGnZXfyrHt8DM9x+I7FUhZ8k9So
         8TBVcp7ugC/nrVQcACMd/SLUJ4rgkv+lJOt9ux1I7OvMVqrtMW97YFdyfWmdPiFlg8ee
         QXyCWNWJIjFR35lpqHA4+j9VRY6h+TgEEO3sbDnggvay7SqSB5/APKe/5aew4hPhno3P
         FVX2t4tzdDS3YqADI9m6DqQ6Tpja4Og4Hz2Rhj1c9F1iRt7H6OvoSENy47/9E+dUHF1N
         fPMlD9X/mNAAGVta4thcdCpZFLX3zCukkResw5PjjoGNQX7uCNm8mlF169Lb+mIoHQnn
         U0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198211; x=1785803011;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxngIn4iftEseWLY0wyG/D5gLEEPwcj0xQ+XgFLkB2g=;
        b=NEIZh0wuns/RPplsdvgpa/TciusQmIosTbJlWXZH5hk2vBy5dAqF57UODRcL0C+g+N
         uzC9EIQ0I/n1u2ycl6v5DVSweyLoUSMJnAjOq6uwF16CzKPulGmHWx7E76n8JYxEZQMO
         X9qT1qGHYgmA5kUy+SB/t0G+QasWtd2y2SMm5lD9jXqAogiPc3I8Yk1PmiBuU97Luch2
         K17axDKnGC3Zmh4DIjasoHmv4mueieQYz85R2lodnYU0j2QUtQRrrz7ZEYiqOC+GMWAB
         mA4PHwzX4f2OExJ46/kv984RiyGKsGETa+vptm/mjkyfBPp70G7yvA+JoCJVM0K64MM3
         ZMuw==
X-Gm-Message-State: AOJu0YySE43/tFLktzA2XDtY7EQE9SUwJEr+TealNLYG9YhuaqVNawzY
	sQexwop6QPNdSK+vuQBdEODsP01UFMR5rT/HFwPnOAUrrnd8Z0nfyZtYAYs6X1dPncmrdrMwX++
	NLmS7yQ==
X-Received: from pldu12.prod.google.com ([2002:a17:903:108c:b0:2ce:fc90:1592])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8e:b0:2cf:b23a:3e6e
 with SMTP id d9443c01a7336-2d015d9d24emr1072205ad.40.1785198210463; Mon, 27
 Jul 2026 17:23:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:22:36 -0700
In-Reply-To: <20260728002236.869865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728002236.869865-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in
 the shadow MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use CMPXCHG instead of clear_bit(), which currently emits a LOCK BTR since
the to-be-cleared bit isn't a compiled-time constant, when aging SPTEs in
the shadow MMU to align with the approach taken by the TDP MMU, and because
using CMPXCHG is far more robust against bugs in KVM.  E.g. if the SPTE is
somehow no longer an SPTE due to a KVM bug, CMPXCHG will fail gracefully,
whereas clear_bit() would potentially corrupt/clobber memory.

Clearing the Accessed bit without atomically ensuring the SPTE is still the
old SPTE is "fine", as holding the rmap's lock ensures zapping the old SPTE
can't fully complete, which in turn ensures a new, different SPTE can't be
installed.  But that chain of logic isn't exactly obvious, and there's zero
reason to avoid CMPXCHG as its cost on modern hardware is within ~1-2 uops
of LOCK BTR (and may even be cheaper on some microarchitectures).  Doing a
64-bit CMPXCHG on 32-bit kernels does requires a more expensive CMPXCHG8B,
but 32-bit KVM is all but dead at this point.

Cc: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ecf9e39aed5a..c519e8e8d646 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1719,11 +1719,11 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	struct kvm_rmap_head *rmap_head;
 	struct rmap_iterator iter;
 	unsigned long rmap_val;
+	u64 old_spte, new_spte;
 	bool young = false;
 	u64 *sptep;
 	gfn_t gfn;
 	int level;
-	u64 spte;
 
 	for (level = PG_LEVEL_4K; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
 		for (gfn = range->start; gfn < range->end;
@@ -1731,8 +1731,8 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 			rmap_head = gfn_to_rmap(gfn, level, range->slot);
 			rmap_val = kvm_rmap_lock_readonly(rmap_head);
 
-			for_each_rmap_spte_lockless(rmap_val, &iter, sptep, spte) {
-				if (!is_accessed_spte(spte))
+			for_each_rmap_spte_lockless(rmap_val, &iter, sptep, old_spte) {
+				if (!is_accessed_spte(old_spte))
 					continue;
 
 				if (test_only) {
@@ -1740,17 +1740,18 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 					return true;
 				}
 
-				if (spte_ad_enabled(spte))
-					clear_bit((ffs(shadow_accessed_mask) - 1),
-						  (unsigned long *)sptep);
+				if (spte_ad_enabled(old_spte))
+					new_spte = old_spte & ~shadow_accessed_mask;
 				else
-					/*
-					 * If the following cmpxchg fails, the
-					 * spte is being concurrently modified
-					 * and should most likely stay young.
-					 */
-					cmpxchg64(sptep, spte,
-					      mark_spte_for_access_track(spte));
+					new_spte = mark_spte_for_access_track(old_spte);
+
+				/*
+				 * Don't bother retrying if the CMPXCHG fails,
+				 * i.e. if another CPU modified the SPTE.  The
+				 * SPTE is either being zapped or is likely
+				 * still in-use, i.e. is still young.
+				 */
+				cmpxchg64(sptep, old_spte, new_spte);
 				young = true;
 			}
 
-- 
2.55.0.229.g6434b31f56-goog

