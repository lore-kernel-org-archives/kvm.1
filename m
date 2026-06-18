Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7F3E2752
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809004; cv=none; b=Wfd3Jb/J8T3HCaX6W6o4ePJE7LOyUZzOyzsIQwHE1LE7pGYYBRBzhWsEhOmWHDdqcH3in+Zqhhlbqa4DYbWiDrnWhD7pDMXUGHHNVn7EIYLevz5UO/QfaH29T4wBPJUor0oA9ylmr4+bdWEFoviom4Hlt35BgEJkOLS9tmeFudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809004; c=relaxed/simple;
	bh=k7pEB1TrJXrtJVXWHb/y4s/VECamhLF0DoS0yfjjuPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jpowEWGPiS/CnGdNptM0ej1XinH0vRrW7m6ixOPNI9GCJzrgzp0/ynY0zxlHiJRA56CorF/N2zP6mVV0nswUt8AAYytvnydozvVgOFFMHtdPCTMle5rfwnFeMT1cUN8w88ZAhHJew0wTXJGVXK2yKpSOI7nnkxFjPp5rCeKP8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9LcPU4a; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9LcPU4a"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so780054b3a.2
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781809003; x=1782413803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpZX4un/aVSFnNpO1jcVNhucJmMh4JR8uc7m+5+/1dQ=;
        b=R9LcPU4aqSCHDVzPew1wF1FZ2pJJl7v/ynnmL5xWKcmFbooPtmOnABf6O2ZTujiXOr
         zNRlmnXqyLR14c1gX57TX+Z1pLMEaMSbNpIWNHu4ecaS2MpjjZ6vlCp7WSFczgt+PzZ8
         IQpHTCrRD4258NttHYjeDKd7P3MPJPBtUKbkHv1QflB0ujx0hfMr2GVTQJoW8lL5Lnfv
         LlJ4esVURaBXemibuIwKalXIwYPVExBJPZLf0e4iiFhaa00lm/r4L6vuq5HEPJUxgVRD
         Jaa1t2ffNHQVskS365eQ3UlkLrnxhBGypSSOPmDu4QnIQMRTIn0Ayt/jK/OhMk16Yq5W
         /oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781809003; x=1782413803;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpZX4un/aVSFnNpO1jcVNhucJmMh4JR8uc7m+5+/1dQ=;
        b=jkRBwBGMDhPTIiwGjdDiJIxrPg8xBKKGmDtqZQj50PRSxuPr9wwkcwJUYRsUQM8AR/
         vyitLc5ebBd8ak9jIa0Jqd9XpbJ533HXVACXsj7Bzr2x8ULkftKkhZTwOn2fr9tWTIp9
         gYtLaHkEjyArkldnU5/jFaxQtavuvmflSCtLviGhcqUhAoxmLm85EzO8EZbYXS1zm6rh
         781gYvdR7gZn19X6PgI5mozN7A++taDMAMLMJFKzGHBKYhKUTSvbgH+5eg/lYma+O2nU
         2qkCKzYqBliil7Cg4nWMlj6Nf0xc1PsfHcqZhZLHHARHaU9itXjhGk5Hj3XoimHgTDrs
         Wj5w==
X-Gm-Message-State: AOJu0YwI02cXIiUd0xgt51qF8/CHAOTyVxENwFMH6tWNkiwktbTjBv+2
	NLPs79bibhrSSYqYGyjJvqb3mszGCn/+ewSsHfMYhervypJQZk7/AOg2tSKY1qcACrqQwP+d9km
	V8mGILg==
X-Received: from pfob8.prod.google.com ([2002:aa7:8708:0:b0:842:47f8:d51d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1916:b0:842:5b63:610f
 with SMTP id d2e1a72fcca58-845507a9ea7mr165386b3a.4.1781809002646; Thu, 18
 Jun 2026 11:56:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 11:56:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618185641.2022368-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Bug the VM, not the host kernel, if KVM
 write-protects upper SPTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

WARN and terminate the VM if KVM attempts to write-protect non-leaf SPTEs
instead of bugging the host kernel, as there is no reason to bring down the
entire host.  Even termininating the VM is likely overkill, but in theory a
missed write could corrupt guest memory, so play it safe.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5b3041138301..c1cbae65d239 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1410,9 +1410,10 @@ static bool wrprot_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 	u64 new_spte;
 	bool spte_set = false;
 
-	rcu_read_lock();
+	if (KVM_BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL, kvm))
+		return false;
 
-	BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL);
+	rcu_read_lock();
 
 	for_each_tdp_pte_min_level(iter, kvm, root, min_level, start, end) {
 retry:
@@ -1844,7 +1845,8 @@ static bool write_protect_gfn(struct kvm *kvm, struct kvm_mmu_page *root,
 	u64 new_spte;
 	bool spte_set = false;
 
-	BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL);
+	if (KVM_BUG_ON(min_level > KVM_MAX_HUGEPAGE_LEVEL, kvm))
+		return false;
 
 	rcu_read_lock();
 

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

