Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AA3C2BAF
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181452; cv=none; b=BhkWtSatyPPkTJjr7tocIoqwp6A6yOouInZkXxTh66G6vvatHcoIpSNIOjioMDL39JyNjOfLr4gPFM0ginZlCjFgrJCi5HW20lt3CEhxyAXLxS2C9o31/dtGzxZhNV6fo2gyunI4I3FZ/SM1rNQ3cJAt7DShJZIgJPIDeu4I+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181452; c=relaxed/simple;
	bh=zTOUcaCt240nb92PTX7QIIcvMN9v3Cdh/XmoPJBK/5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxI1nRIlf/6g1afqxrquKaNLJtluHHnIicwatgSGg5KH7rieZLXbNyxkEmaxTxia6lACwClvyhuH2BF1n5M2E28ukifqjL54CB22q1vDzBa7wDIk0EqwuZkdFGJgxRj9am1muz4autXHZQ3HNwzStbDJsrpma32a7yMAEpqKJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHVv2pIS; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHVv2pIS"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso879847a91.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790181445; x=1790786245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bYrIdvD8zMWPuhUgl0XksfWM3W3WC1TXZ4H6c8j0l2g=;
        b=kHVv2pISNriAyJYddBzpbO0gw4Zt2JgA/Lh3Sr7crkofeXDyOT3Yk1zBWu5jE1hyQI
         9lUEuNQBFJwHWmwbppTFZQmM6WJ6WrjS1TEfqDjS7/+oLNkhtuLyYJon9JSDL5g6MPfE
         h/1XjseFnLqt0BiU0laWOzcjpKTiciHOmcqEwe6665PMvq6pFPZFkBYsJMaMywkJsZP1
         WU5JSPdJz2NF+ktUO8bKN0NljSJGMkNdrxHE+i7fmvb+jBMAh4yLKTNrbEa5e57e5cha
         eD3I6ugMBdXuOSR+L51YX0Y3XXH0+BAcUDHyO6r2jVvJldAXR8QsrhQExxjDezFdtoLI
         LIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181445; x=1790786245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYrIdvD8zMWPuhUgl0XksfWM3W3WC1TXZ4H6c8j0l2g=;
        b=f6tBMXucEXZo9lS+LNigJ4DxAWeqA2CBQlrnBJCAPyEkRS2PIZc82NiVFQ6kY7xcBu
         WxBs8R9Ymy2B3Wp9/BfQT4Bv3hObqvZbDqnx8TabQkS5hq6qqVeaYnQcAcmLlyMj24Xa
         r+oxy8c6YkzDZnxH9OsLiMMr+3fEpXyt0qOVBRq3A5P7ekTRQ/mfGGkMvt/ixQ0Y5wp4
         mw56mI+9f/qYuTxUg8tycXGy13qaG4t7ieCPBDwt+1FZoJbF8yaiSLEjTf1+7hpWkMVp
         4zkVTk4tPRO3FdgyETCIRnYrUsxl3SZIYUSSJ4Dfx/L0SNQBXBt6DOjB6LHWarZC71/r
         QULQ==
X-Gm-Message-State: AFuF++nRJ8W+8UzZrdY+/LBEBh7/0p4sI670DJjDwmzuduRTO7C946l4
	hggtQdCGaJ1OrGm1txND9/uAstCFBS8nEB0uteP4vk5dMQ22GS66OfVJCQas6vZufAzsSu4xoNn
	E4TvUJA==
X-Received: from pjbkx13.prod.google.com ([2002:a17:90b:228d:b0:3a0:669a:2710])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fce:b0:3a0:3881:eabe
 with SMTP id 98e67ed59e1d1-3a07e4ee868mr2664097a91.5.1790181445180; Wed, 23
 Sep 2026 09:37:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:37:21 -0700
In-Reply-To: <20260923163721.1584779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923163721.1584779-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923163721.1584779-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SEV: Do cache maintenance on the source VM during
 intra-host migration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Manually perform cache maintenance on the source VM during intra-host
migration to ensure no stale data is left in CPU caches after the VM is
destroyed.  Because the source VM is "converted" to a non-SEV VM, KVM's
memory reclaim flows won't trigger cache maintenance, e.g. when all guest
memory is reclaimed in response to detaching from the mmu_notifier.

Note, relying on the destination VM to do cache maintenance isn't an option
as KVM doesn't require identical guest memory configurations, i.e. the
source VM may have access to memory that the destination VM does not.
Enforcing equivalent memory configurations is infeasible, as it would
require a *deep* comparison of memslots, e.g. to verify that not only are
the memslot identical, but what the memslots point at is also identical.

Fixes: b56639318bb2 ("KVM: SEV: Add support for SEV intra host migration")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c9242c936a40..71923cb72d1d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2048,6 +2048,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	src->pages_locked = 0;
 	src->es_active = false;
 
+	/*
+	 * Do cache maintenance on the source VM as it is no longer an SEV VM,
+	 * i.e. memory reclaim flows won't trigger cache maintenance on the VM.
+	 */
+	sev_writeback_caches(src_kvm);
+
 	list_cut_before(&dst->regions_list, &src->regions_list, &src->regions_list);
 
 	mutex_lock(&sev_mirror_lock);
@@ -2187,6 +2193,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * the set of CPUs from the source.  If a CPU was used to run a vCPU in
 	 * the source VM but is never used for the destination VM, then the CPU
 	 * can only have cached memory that was accessible to the source VM.
+	 * Furthermore, KVM *must* perform cache maintenance on the source VM,
+	 * as the source VM may have access to memory that the destination VM
+	 * does not, i.e. KVM could skip flushes if memory is reclaimed from
+	 * the old VM but not the new VM.
 	 */
 	if (!zalloc_cpumask_var(&dst_sev->have_run_cpus, GFP_KERNEL_ACCOUNT)) {
 		ret = -ENOMEM;
-- 
2.55.0.1082.g2b9226bbc0-goog

