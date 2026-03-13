Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204C282F03
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361993; cv=none; b=bHhqpzyG1Xg3Efq4su81smf48wNzYsa2kmgBcFrcUDcd/2lcWuBuDlhQGOPxyktLPLlr3yXaVyfqzX/CIj0pZNSjIz9qFRGjMS3zbBhVWx6GNeRB+0KNs8xIxb8tnluF23c5qT+DNm/ogNJVtNLpqR6M1y2ZRTqF5v0fstwLSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361993; c=relaxed/simple;
	bh=KUPKNTDRVZ/QfetP6CHMafZgrCFxAJkTY0y1vHbaZjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qv6uBNag1PAydM4rhMWeIMszvt9arLKzqH7s2rKByS4qC3T0P0fnhIizLLClArM6f2TxpxjpDhf8QUkCaA5YJcKzfi/sQYq3ZXSmoDaHFiOWGPBNQdBv7vTeWhzLYECOZiQW1lWTOnbV4mzO0aY84TNKBlw1F0YpnjzXdNxP6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1Fs+JdH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1Fs+JdH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7385a1476aso883099a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773361992; x=1773966792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AqRK5iKJVJvsAdFdvM1kG/PPXB8Ro1UYz8Z7jtmY8dE=;
        b=q1Fs+JdHqSaOfGyIafRn9jkkxm/lYbJxUii5C1/ioEIZmISxklg5WQbIDfYz+XDzHU
         OZ8SrkswjNRSOBElsVRUd35biytJxrpCLzTvJIBs2Cug2anUYsCm0FBIrFdwfJoazM0o
         uZU702ww4AUZz9zLmXJteR6FDqugBWOd03f+J5geeraQtGd7lGlGOf9lzLiNrMDuMNLt
         ngXuLC2e9jXoPZ4SH833YnYFA0V/xTVnKRnZbyU+ueTXF0z2hf0INObYA4IV8h3LpNO2
         NEmjnj8bPQyq5Vsfu6OttGhjbH+cZ4zKB0h0EWGr/7ins4OwODStFkebBcK7xS9kEFOv
         R8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361992; x=1773966792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqRK5iKJVJvsAdFdvM1kG/PPXB8Ro1UYz8Z7jtmY8dE=;
        b=fAATg7r6uoWpuwQ0tyCQfNKgyN8JQ6gLcnmfx/JUfMi4Lr5ky0+1g3TK6hZ/sIAz0w
         NHU1M7I3UnUyOutOzEot5Kf++hQmYnDxvErKKTUCF6P4GJy10dOdRjMDRH76HqavyYYO
         +RI1lY5NzyDy6wzW2+RmEG6m15RNvb2D288mAZhXeHkQjKcczQmW03MM8zp5JHDBmFIJ
         7WdvU4jN/dTBEelXYtRx5qjFhGi0LZsKxCQT6PiU3PcZS0R/F2/AYT9wWjkq2vIwDLCN
         HSWY09KcFHpzkVZezdUSgfJQZKmIMlS364mTl6kmbLrNANbrg6+JRaTIw27/JRhTTOnJ
         JRJQ==
X-Gm-Message-State: AOJu0YwAXLZ8IcZbMNxKWvJ3vXMzdDF3PJcHsB9dkn6pkdQmkKP/jdjV
	VcQDsLKBiObfLQUUCpE8kPDBaPVaQvXF/squG7K1s9IR1Db6zuu3CbyrRC+DwA/lb+h76zO8uqb
	S/VZYog==
X-Received: from pglf22.prod.google.com ([2002:a63:1016:0:b0:c73:8240:7190])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:700d:b0:398:8e97:ea7a
 with SMTP id adf61e73a8af0-398ecdaa227mr962922637.60.1773361991488; Thu, 12
 Mar 2026 17:33:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:33:01 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: SEV: Use PFN_DOWN() to simplify "number of pages"
 math when pinning memory
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Use PFN_DOWN() instead of open coded equivalents in sev_pin_memory() to
simplify the code and make it easier to read.

No functional change intended (verified before and after versions of the
generated code are identical).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bd94c64a9783..ae5b370db9ed 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -682,7 +682,6 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	int npinned;
 	unsigned long total_npages, lock_limit;
 	struct page **pages;
-	unsigned long first, last;
 	int ret;
 
 	lockdep_assert_held(&kvm->lock);
@@ -692,12 +691,10 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 
 	/*
 	 * Calculate the number of pages that need to be pinned to cover the
-	 * entire range.  Note!  This isn't simply ulen >> PAGE_SHIFT, as KVM
+	 * entire range.  Note!  This isn't simply PFN_DOWN(ulen), as KVM
 	 * doesn't require the incoming address+size to be page aligned!
 	 */
-	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
-	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
-	npages = (last - first + 1);
+	npages = PFN_DOWN(uaddr + ulen - 1) - PFN_DOWN(uaddr) + 1;
 	if (npages > INT_MAX)
 		return ERR_PTR(-EINVAL);
 
-- 
2.53.0.851.ga537e3e6e9-goog

