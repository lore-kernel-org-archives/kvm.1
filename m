Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C642DF6F4
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361992; cv=none; b=o+4sKJqNU3cYJE2eaKEaT8520IfJYQ9GtJZB9WSshS0VoJJSiASCrVWomPyMVJRIu8SlHtHgs8R5+Bnmayo2sbdu+gi9J8AqhkG/e0rgakCag9bN3KN33d9S46qx/+ZJD9CP4zVSAIQJLfnoG5k1J2BUpSze54GiZri7IzR6sWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361992; c=relaxed/simple;
	bh=ncwO479Ti98I8zSlwhrWIMZzmBm9etfHe57WTf4Gajo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FncgTXjgm8bW9e56bWhtLBfu8yJVnMpHxrK9zr9iPeAJkjbF9NWz2fEQZ+lEqrm3DBhPqz2GjUnl6eC37xItZ5KkJx1vEYRlHKvpVGodYtjUCX+f1U04ai7OzDAlvThezQ/qtq8Ecuu3ayJAE3l4HFwQZ0uJlxDBGXLH8+2Nzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDBrSqpL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDBrSqpL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aea7747aeeso17709765ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773361990; x=1773966790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gb1zr6ZxdKV2CmAeJFzlikcGZHx46idh5fE52X1mFZ4=;
        b=KDBrSqpLB6eJq0WkUuVDvBM9FT0UcKGQVyz3Q/vQrUnf2wJN223UgoblIIsUMC0xUC
         M8nSSgv4sIFJSRO0jCmFD5W/XmfPu3QS8TKikdpFqfv4AJYva+X2BnbW72fdVC9axcRL
         aySyYGl6aHpUu87FmOHYkYjHMTB6tkPiulNRm+haD7eKVxueYbs0iGaPM5RgJpW4jQAa
         QpSKg2oNtj9H90DQD/HhMZrxZrd6vkqO7KkeIB2p9kN2JnYpognkJP0oswdRk3hYfmWj
         mDWmq+uoNJ9M5N6kKCeutk2b1Nidoa0mBOMVO0NOARLcH/BKjhNXbZ4188Tkz52RB/5z
         ePYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361990; x=1773966790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gb1zr6ZxdKV2CmAeJFzlikcGZHx46idh5fE52X1mFZ4=;
        b=VV+ECv5vfKkgUslvMCHgf4loDZlG1vKW1eeczxiQbPkxyfYFt8VoUQnvLLLYf06HOj
         RYgjmxL8iTXp3wAwWoxGnwXH8qsI616VUVihcLLjjwFHvdcqzDu9q0dmfofIZz4MBAq3
         KbHRGJdhdeelcodg1sXHjxYAq6RmGFb0CP501mlUUxjM4HhXbeYzBGmlActt5cy0eyfU
         KWfrs6V7tZ26CgvXNdNyicd3IwzJ6FS/0yksgnYeiaCyl/Hn2YwjunrnXsGzUEo8tO5K
         pNb/LHoihaFg9DxDSS3i2odjgJ9JDCnmQiTaHPQpZuCPlBdkPBX4vUF/hk08lWr4ka5z
         ohSg==
X-Gm-Message-State: AOJu0Yzqn68wK+vmUbMWO3sri7ich2/EeMe1vU/bqTPdQw26E8yw/cT5
	/ENdkpsBAYJjQ4XcRZjbMmlmJmQyzCoYrkDcWWpkzIZT7bdUrCH9CPYDiLB/pWyiFEbhGAx5k63
	gGJ/tWg==
X-Received: from plzu6.prod.google.com ([2002:a17:902:82c6:b0:2ae:3d74:7993])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce08:b0:2ae:69d3:5b9f
 with SMTP id d9443c01a7336-2aecac3d018mr12176195ad.52.1773361989553; Thu, 12
 Mar 2026 17:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:33:00 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-4-seanjc@google.com>
Subject: [PATCH 3/5] KVM: SEV: Disallow pinning more pages than exist in the system
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly disallow pinning more pages for an SEV VM than exist in the
system to defend against absurd userspace requests without relying on
somewhat arbitrary kernel functionality to prevent truly stupid KVM
behavior.  E.g. even with the INT_MAX check, userspace can request that
KVM pin nearly 8TiB of memory, regardless of how much RAM exists in the
system.

Opportunistically rename "locked" to a more descriptive "total_npages".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 857771586f16..bd94c64a9783 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -680,7 +680,7 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	unsigned long npages, size;
 	int npinned;
-	unsigned long locked, lock_limit;
+	unsigned long total_npages, lock_limit;
 	struct page **pages;
 	unsigned long first, last;
 	int ret;
@@ -701,10 +701,14 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (npages > INT_MAX)
 		return ERR_PTR(-EINVAL);
 
-	locked = sev->pages_locked + npages;
+	total_npages = sev->pages_locked + npages;
+	if (total_npages > totalram_pages())
+		return ERR_PTR(-EINVAL);
+
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
-		pr_err("SEV: %lu locked pages exceed the lock limit of %lu.\n", locked, lock_limit);
+	if (total_npages > lock_limit && !capable(CAP_IPC_LOCK)) {
+		pr_err("SEV: %lu total pages would exceed the lock limit of %lu.\n",
+		       total_npages, lock_limit);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -727,7 +731,7 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	}
 
 	*n = npages;
-	sev->pages_locked = locked;
+	sev->pages_locked = total_npages;
 
 	return pages;
 
-- 
2.53.0.851.ga537e3e6e9-goog

