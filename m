Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154148C8AA
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630138; cv=none; b=SAlF3ESfPTU3dqViuaLFeZlnTeMazAV+KFKKyAnC1ndSS+fwrHk9gzS1rtytXxkjtjjmjyw3nYNP/HdgQiOi6nQU8imN/rD/VW4WUq+x27u8Kwhr4ankxA4PCFMhM7Zc6ao6iXRaAPO3Ptx03wYwv7LChbk58zqSF/oB39eslF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630138; c=relaxed/simple;
	bh=P4KaCyidpJ+KrhrI8crT36+kmGtOpJrHs7dj1bFXusI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6rQiGPB4BmqsMrohQM6UToDiCoiBw6D2yIvTnh4YjTR+HL9AKbtNrfDi3oKsTIspJdFomINWJaezk0mpBSZ5uaqjiMmbxfk7Qe8A7Ns15gZFLTFDyV+hyNqT5VUQ3JhN/M5/o+aatilHsFr9nrRxEryXj9fLKRELG7c48bllzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFYoxv2R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFYoxv2R"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so24199125ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630137; x=1785234937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtZKBcBFnGPQ7JWiOze8zVf2sEShewULwmU/poxZWO8=;
        b=qFYoxv2RRI43ewi8eobUt8BWLqLV8J6klMbcltJIccVLXJztHQJmIbXBSy8eohUR7a
         wyjMoOEVwCXcOvgVxG7Ru6+MnhrfBwiFZCIaXQW7NMk4FtM6CxhZ9Q9K15w9lRNxQYMV
         RXExbtdLwe4wmwVmLZuFCrOxeUkKv5/J/reLQSLlGQQebY0y3j8AK4k8tfDAvWX9He2p
         TbJCBTguCcYvG99EFnr6YKI0m6Ha9igUw5nP52yPldde5TvCMNlwYd00k4qiqYdABYm+
         wKLAOmWhCgd1QEWLXtXTgG1xMbfqBLpmDzTK/8YvKE/f+W9Q93FSomDdeJVipoor089a
         fwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630137; x=1785234937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtZKBcBFnGPQ7JWiOze8zVf2sEShewULwmU/poxZWO8=;
        b=RnyO1cYvSaMrLwsK3MJZ5Bqd5qQzHm8Cm7Ggd7dcFQJfBRXiDcS6SAyPs5pMFShewM
         Uehr2Rmv/18kVwXJj7POQ4WD7aZ+Iu1igASbz4mT+AMHakdd6mOf/tZ5g0d9brdRR/NH
         vikW+D2c/4sT00v6/Lnt5JN34S5Jeug5UQ2kn1mANwNRN9udZkZ9/D4QGI1qLaFjp811
         tfnR982R7cRXc5bkllbPMPve2c1L8dfvUJvmvMmRl862MMxLGD9GqWurpmxStOzW9pmJ
         aJbuUMf1pbMVluyCuBE3CQu+NBQAC7KNJYodgTeTTcf1Sa7a6qBgR6nrdRyQSwYYyQ9L
         sBeg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/hyfCqWaeKBJBOW/WFTsD6JMLRICBLcXRBgqDOW8VP9mTgCbUmZnxaWZPCZNQ4LhcXb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1aFdhr3M5EKgp7jlaMhZbhN7nsdDWvkd1c3PVLE5CJZGPGYy
	6bex0W1SZaxMPwUJNCi2aN1GvyT7W9gFNoXwEf+MXu1UBVmlxlDsskji
X-Gm-Gg: AR+sD13sNEH85Hqclm4vxmMehxp4aFOfYRacYgjahNZazMYU0dgoetkRwhKqDICkiz+
	ch+Mbv/WTqRoIoEXXsf27ycDh6vMKAQI8BWAoNI0dtnLh65H1lpo4gkCl1ptg9xk6FQ7Y6xMqQY
	yp/EVsjoAEoZ9b1VDJG4CnHj9YJfg6G/ubbnqWeQM9FubtL1esX3kakdUzwb8he/AZKYD1xsG5K
	BKgIY2rN2AZYteDjaIB42/pluV1Z66IhOIgKmprN/k08d260Xt//deN5eEbtza2/oD9ci9qJO1S
	b+sGQA3gAC+c4bLv3yPMEPSS7ERHBXCy5DCm3dePzoy6k7Fj9DQ/K/cW7ZKg55MGEsdPm/cWimx
	tqUmpaHjZO8yGAcwo2sHbApd3XGexlPezZwY6yOHEbdAbKJwPVh/uNbOoIjuTMDdRY9sXoY1ZiF
	WhbbbZ1AIDKv2XiPdtWaN9QA==
X-Received: by 2002:a17:903:24f:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2cf3494af9fmr198445645ad.26.1784630136491;
        Tue, 21 Jul 2026 03:35:36 -0700 (PDT)
Received: from localhost.localdomain ([124.194.218.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476ba24sm72240715ad.75.2026.07.21.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:35:36 -0700 (PDT)
From: Jinu Kim <kimjw04271234@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: x86/mmu: Check write tracking in all address spaces
Date: Tue, 21 Jul 2026 19:35:11 +0900
Message-ID: <20260721103512.2136240-2-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721103512.2136240-1-kimjw04271234@gmail.com>
References: <20260721103512.2136240-1-kimjw04271234@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_gfn_is_write_tracked() checks only the supplied memslot, but page
tracking is per-address-space and shadow pages are shared across all
address spaces.  With SMM, a GFN can therefore be write-tracked in one
address space and appear untracked through the other.

Check the supplied slot first, then the slot for the other address space.
This ensures all callers honor write tracking regardless of the active
address space.  In particular, it prevents mmu_try_to_unsync_pages() from
marking an upper-level shadow page unsync and eventually triggering the
BUG in pte_list_remove().

Fixes: 699023e23965 ("KVM: x86: add SMM to the MMU role, support SMRAM address space")
Assisted-by: Codex:GPT-5
Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
---
 arch/x86/kvm/mmu/page_track.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1b17b12393a8c..ff93591be1adb 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -133,10 +133,22 @@ void __kvm_write_track_remove_gfn(struct kvm *kvm,
 /*
  * check if the corresponding access on the specified guest page is tracked.
  */
+static bool __kvm_gfn_is_write_tracked(const struct kvm_memory_slot *slot,
+				       gfn_t gfn)
+{
+	int index;
+
+	if (!slot)
+		return false;
+
+	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
+	return !!READ_ONCE(slot->arch.gfn_write_track[index]);
+}
+
 bool kvm_gfn_is_write_tracked(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	int index;
+	const struct kvm_memory_slot *other_slot;
 
 	if (!slot)
 		return false;
@@ -144,8 +156,16 @@ bool kvm_gfn_is_write_tracked(struct kvm *kvm,
 	if (!kvm_page_track_write_tracking_enabled(kvm))
 		return false;
 
-	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
-	return !!READ_ONCE(slot->arch.gfn_write_track[index]);
+	BUILD_BUG_ON(KVM_MAX_NR_ADDRESS_SPACES > 2);
+
+	if (__kvm_gfn_is_write_tracked(slot, gfn))
+		return true;
+
+	if (kvm_arch_nr_memslot_as_ids(kvm) == 1)
+		return false;
+
+	other_slot = __gfn_to_memslot(__kvm_memslots(kvm, slot->as_id ^ 1), gfn);
+	return __kvm_gfn_is_write_tracked(other_slot, gfn);
 }
 
 #ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING

base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.43.0

