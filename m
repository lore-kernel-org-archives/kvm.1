Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C512E541E
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361995; cv=none; b=JteZg335jW4QcchUPsVxNfjALjWmgES9uovcxjfUmzN/6IIeAHi1EeDm6NL+/axycBFInNdAQ62rKpCvamVNSfLECIRlfRNsDGNxboJ2rudpq8QRpukG68HdMZPXVa1xeuF9mJp0GtuPK18CATaBM3Y3T2tPzZj3V1ZZS442vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361995; c=relaxed/simple;
	bh=WpScRbMBDqAkQTX9pKjjHvsZHNQmjSLgOiqTCexwbcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJTxnN3O0d4jYTYyjFUALk7EwSPz28qYMN9Cd72M/YR+vmw97ebCYPyS9xIgO37yeuwoLZq9Y97rZuE9gc1uQorhcIjueJMqmYUkWPYPm90pE5iOJBzmC4JvubQqU4Nw8IQDy8g2lOPs2uTgUlUmmFweJW8VyQ9yRc6IVuOOhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A69zCeLN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A69zCeLN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e9577ceso113497565ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773361993; x=1773966793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l7XObWvGBTdVwmSkFItE9kmFO92BHNR0Spc7XRnM3nI=;
        b=A69zCeLNadIm6F6gU2RJzsj81wAEnwHYiRJDC2YbSfL+bJ5XISVmvOO1ya6icIMQqA
         GZA4SRruhdaqHzBqKkBFlcgX/UBzYue8vEwc09LiKLWlTfRNwkDm8204MwbXkzUxBQ/a
         IXsI+W8rb6dgVqnPHWu03nNzwu9hufUWSR00bcJNYD3Qu2vTZ5IyixEpqmgEZscDvdN7
         T/oBAgf0iSK1RqhndCywkzn420jwVAL6ghCRUh61Iwu+kJoGtPlev2K0NF5d2cith1pi
         3URIsj9glE2tEbwIjF3d4hEjNsPH3ZRHFq5Z43YioLO0BoLRP5wu/S+T7+4y9aBKvQKx
         ZjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361993; x=1773966793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7XObWvGBTdVwmSkFItE9kmFO92BHNR0Spc7XRnM3nI=;
        b=b9IzL8fSVTwzEbZZ9v8aWLleBAvwQI6d/GIbhvi+Kx/rqs+ZdU0dR5R8v2u4qyLVSG
         2aYRntsm+bNGQroZuIEcgm4JoeDyVbQagxZ47+468YpUWQyDfMenPK5f4tgr2v3nPowE
         0FPsujtl+rb14/3VL4KBPrbi1S/FdUjUOcHrrUGhkCBdONpcalxWYS49pdr32GSl9CAE
         UFBTak5BRKcui7CDK0TYuVOVfbsZ566eaxWWgRjPOEJemjYueUFWMH6OGnIclz7DpxM2
         whTRilBDMPXeHLpOtsRmXylE1eNgfiBlkFLAv+g81EPVT8kL9LOVRTOyvRqMvD9FYZP9
         EayA==
X-Gm-Message-State: AOJu0Yxb4z9HAFAmIyjqGAMQKOuQ9hNDPk/41oXIDVXEsKlddb+40Oom
	jSUez3bknTBVHvoPT/QChIJ33xI2LVUzIQpnqItZd/TOlxTho8eiPv9kgwwij0N21rPg3fyr8aa
	W5pSKUw==
X-Received: from plwg11.prod.google.com ([2002:a17:902:f74b:b0:2ae:c871:d739])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e3:b0:2ae:aa16:ad13
 with SMTP id d9443c01a7336-2aecab2f6c1mr11486895ad.45.1773361993347; Thu, 12
 Mar 2026 17:33:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:33:02 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: SEV: Use kvzalloc_objs() when pinning userpages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Use kvzalloc_objs() instead of sev_pin_memory()'s open coded (rough)
equivalent to harden the code and

Note!  This sanity check in __kvmalloc_node_noprof()

  /* Don't even allow crazy sizes */
  if (unlikely(size > INT_MAX)) {
          WARN_ON_ONCE(!(flags & __GFP_NOWARN));
          return NULL;
  }

will artificially limit the maximum size of any single pinned region to
just under 1TiB.  While there do appear to be providers that support SEV
VMs with more than 1TiB of _total_ memory, it's unlikely any KVM-based
providers pin 1TiB in a single request.

Allocate with NOWARN so that fuzzers can't trip the WARN_ON_ONCE() when
they inevitably run on systems with copious amounts of RAM, i.e. when they
can get by KVM's "total_npages > totalram_pages()" restriction.

Note #2, KVM's usage of vmalloc()+kmalloc() instead of kvmalloc() predates
commit 7661809d493b ("mm: don't allow oversized kvmalloc() calls") by 4+
years (see commit 89c505809052 ("KVM: SVM: Add support for
KVM_SEV_LAUNCH_UPDATE_DATA command").  I.e. the open coded behavior wasn't
intended to avoid the aforementioned sanity check.  The implementation
appears to be pure oversight at the time the code was written, as it showed
up in v3[1] of the early RFCs, whereas as v2[2] simply used kmalloc().

Cc: Liam Merwick <liam.merwick@oracle.com>
Link: https://lore.kernel.org/all/20170724200303.12197-17-brijesh.singh@amd.com [1]
Link: https://lore.kernel.org/all/148846786714.2349.17724971671841396908.stgit__25299.4950431914$1488470940$gmane$org@brijesh-build-machine [2]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ae5b370db9ed..4e4adab8d309 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -678,11 +678,9 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 				    unsigned int flags)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
-	unsigned long npages, size;
-	int npinned;
-	unsigned long total_npages, lock_limit;
+	unsigned long npages, total_npages, lock_limit;
 	struct page **pages;
-	int ret;
+	int npinned, ret;
 
 	lockdep_assert_held(&kvm->lock);
 
@@ -709,13 +707,13 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Avoid using vmalloc for smaller buffers. */
-	size = npages * sizeof(struct page *);
-	if (size > PAGE_SIZE)
-		pages = __vmalloc(size, GFP_KERNEL_ACCOUNT);
-	else
-		pages = kmalloc(size, GFP_KERNEL_ACCOUNT);
-
+	/*
+	 * Don't WARN if the kernel (rightly) thinks the total size is absurd,
+	 * i.e. rely on the kernel to reject outrageous range sizes.  The above
+	 * check on the number of pages is purely to avoid truncation as
+	 * pin_user_pages_fast() takes the number of pages as a 32-bit int.
+	 */
+	pages = kvzalloc_objs(*pages, npages, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.53.0.851.ga537e3e6e9-goog

