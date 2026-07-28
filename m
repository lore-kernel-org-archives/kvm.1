Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA23B2AA
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198211; cv=none; b=BVgrPvcQBwuk3U6DDTTMFWWj+o7MweQNXbPAoiQT0ajQSLtcWdQl62aNRROKlhgRlZZHQLCvepTi5cC8xGcJ9JWXnDH2QCdq2bZru//bLBvhQpULIt4UD3XyYqLiiV2ay5hm4RwoM9C6Zi3qQkZBX4t56e8jI9kQhC9jV+DFJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198211; c=relaxed/simple;
	bh=4k5lqp0Ssz0g0JJAhcYF+x6PRTjbzOKXolhiNiF6Av8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L71JFBLOsitsi3OFzhE3cmqNqtz6I5xmesaoOgWSTugUSh1p8r0EuEbZDB1mhW+zwQheME5/9VNz20B14WLZ4UmO9E7hJRc3J6xZXsXKSAC85C0OfJ3Gj8u8xQEwGexEgc/xOMBTs8NVdO9CFdHDBIt7jsHS5BG1bvkRyVFed00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BrFnugi9; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrFnugi9"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso56993475ad.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198210; x=1785803010; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GacNQhbkPFXeQK9D4HbIHLsdEz0B8t00uEMqwXE2mPc=;
        b=BrFnugi9pNWQTLlCcXOqmwMZNEoeFt1XdfVMWU79qjrnKFJy9ThrHSwXbCEMDbSLmY
         3ulurlzbEsXttwi3t4t/YBa/OFm7nyuJ+V9Q+Gw8BT+kL+lUD4cy1F7a70X6opDyPSdy
         T3kHuhq6ffK60jAWaoqnyTAUlxX+GpsMltTan++mhpiw11xIC6KXV3WfMnukJ6/0ivnH
         IBIMsa2+BRNAYJW6c/nP87AGICF2TV59wn5oKPMftk4Jn+Cvx67TPW0e4/RhkTZzEHdX
         EM1Oz8jsEuICeIPyWplpjXMrAwZygTDh/knANxVunivTyzUR6p/tABwk/YlR5ZCrlblB
         TO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198210; x=1785803010;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GacNQhbkPFXeQK9D4HbIHLsdEz0B8t00uEMqwXE2mPc=;
        b=kYWxU1HiwgneodmcrsvgXEao/kDZzfhTb3EX75cyRtRTlsxvgxHngRSFNgV7r4xdur
         BmbWAr0dGI9HNYZ7gExXqQ7gedPAlWa2i78A9tUpHhQltCCwZb1jkB9JMpzgvZC4ZahL
         9RNatKz4Gya0c6OHbzbeX1iL+1BiIh+IT7KEqovwqhSnolIg5hmLAQwFJLV6xWyC+E3M
         CIu4oqHsy1iBboKfrkkQPEgn+V/9eMwbrtV0R1VKKWcdRqAbpKKNsQTA54hYCUKmhy9x
         eLu077jdQGyCskiWGb05eU6vEtwuGLT9mDGFFl1pe437fp49cjZq5pa4+lXrUf41+vjA
         DNZA==
X-Gm-Message-State: AOJu0YzTXJJasduh3ZsR0bXU8cWSGhR0J1cEf19ETYfoaypbD9OGParE
	cttnyeV3HSY57nJbiq5vuJuX2qsP2xiprDEGo1kN5PU9fs3qDyBU4hgWOVIz5u4sBuA2v0r66Qs
	ASEJnMg==
X-Received: from plkh14.prod.google.com ([2002:a17:903:19ee:b0:2cc:8e87:df3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94d:b0:2c9:97a8:8c1b
 with SMTP id d9443c01a7336-2d015ee611amr850275ad.46.1785198209462; Mon, 27
 Jul 2026 17:23:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:22:35 -0700
In-Reply-To: <20260728002236.869865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728002236.869865-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in
 TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Use LOCK CMPXCHG instead of LOCK AND to clear the Accessed bit when aging
SPTEs in the TDP MMU, as doing a LOCK AND can corrupt a FROZEN SPTE and
allow a third CPU to effectively overwrite the FROZEN SPTE.  As pointed
out by AI of some kind, because the magic FROZEN_SPTE value is a "full"
SPTE, not a single bit, and includes the Accessed bit, clearing the
Accessed bit in a FROZEN SPTE will result in is_frozen_spte() getting a
false negative.

E.g. if CPU0 freezes an SPTE, and CPU1 clears the Accessed bitin the frozen
SPTE, then CPU2 could come along and overwrite the frozen SPTE with a
shadow-present SPTE.

Thankfully, the false negative is largely benign, because outside of TDX,
which doesn't support aging, KVM only freezes leaf SPTEs when removing an
upper level shadow page.  So while KVM could clobber a frozen SPTE back to
a shadow-present SPTE, and could even use the new SPTE, the subsequent TLB
flush will make the orphaned, shadow-present SPTE unreachable.  Failure to
ever zap the orphaned leaf SPTE would show up in KVM's stats, but otherwise
is benign (because KVM no longer keeps an elevated refcount for leaf SPTEs).

Opportunistically add a comment to warn future developers away from using
kvm_tdp_mmu_write_spte_atomic() and tdp_mmu_clear_spte_bits_atomic(), as
they are generally unsafe.  Keep the helpers, e.g. instead of open-coding
the atomic64_fetch_and() in tdp_mmu_clear_spte_bits(), as scary warnings
usually are more effective deterrent against recidivism than removal of the
dangerous code.

Alternatively, KVM could use different bits for the magic FROZEN_SPTE value,
e.g. setting the Dirty bits (with effective IPAT and Global aliases) would
likely be "ok", as IPAT/Global are extremely unlikely to be cleared without
doing a full SPTE write, and KVM's clearing of Dirty bits shares logic with
Write-Protection, which must do a full SPTE write (via cmpxchg64() in the
TDP MMU) to ensure KVM isn't clobbering state.  But there is zero reason to
carry that risk (beyond stubbornness in wanting to preserve a "cute" idea),
as the cost of LOCK CMPXCHG and LOCK AND are within 1-2 uops of each other
on modern hardware.

Fixes: b146a9b34aed ("KVM: x86/mmu: Age TDP MMU SPTEs without holding mmu_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h |  7 +++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 20 +++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 364c5da6c499..f898d8d0d93c 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -19,6 +19,13 @@ static inline u64 kvm_tdp_mmu_read_spte(tdp_ptep_t sptep)
 	return READ_ONCE(*rcu_dereference(sptep));
 }
 
+/*
+ * WARNING!  mmu_lock must be held for write when using the "write atomic" or
+ * "clear bits atomic" APIs, otherwise KVM could overwrite the "wrong" old SPTE
+ * value, i.e. clobber an update from a different CPU.  The only exception is
+ * when KVM is freezing a leaf SPTE for removal, in which case KVM doesn't care
+ * about the exact old SPTE value (KVM will react to the actual old value).
+ */
 static inline u64 kvm_tdp_mmu_write_spte_atomic(tdp_ptep_t sptep, u64 new_spte)
 {
 	KVM_MMU_WARN_ON(is_ept_ve_possible(new_spte));
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ce3f2efadb05..44dad106fad1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1335,19 +1335,17 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm, struct tdp_iter *iter)
 	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
 		return;
 
-	if (spte_ad_enabled(iter->old_spte)) {
-		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
-								shadow_accessed_mask);
+	if (spte_ad_enabled(iter->old_spte))
 		new_spte = iter->old_spte & ~shadow_accessed_mask;
-	} else {
+	else
 		new_spte = mark_spte_for_access_track(iter->old_spte);
-		/*
-		 * It is safe for the following cmpxchg to fail. Leave the
-		 * Accessed bit set, as the spte is most likely young anyway.
-		 */
-		if (__tdp_mmu_set_spte_atomic(kvm, iter, new_spte))
-			return;
-	}
+
+	/*
+	 * Don't bother retrying if another CPU modified the SPTE, the SPTE is
+	 * either being zapped or is likely still in-use, i.e. is still young.
+	 */
+	if (__tdp_mmu_set_spte_atomic(kvm, iter, new_spte))
+		return;
 
 	trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->level,
 				       iter->old_spte, new_spte);
-- 
2.55.0.229.g6434b31f56-goog

