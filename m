Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78223EA84
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361988; cv=none; b=V5BKLDNfrg0l9W1sBOKwlB4jFNpBMOlHFITKqWucVW+iqjF0leNNPbhnievRydy3SMG5RbXr5whkSbpDTNRbbVYiL48BBkD87MMsHjngnKHI20yDQgNV6ATGxDsJzQZuDBokRON1otOocxG6Ar2AevJIeh8yXegIsOrBZ0nkVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361988; c=relaxed/simple;
	bh=SNqwYxgD9MGCPwM0Dfkv+5erZ1X5wiJpDLSKV7XA9M0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pCqVvcfa577e6tgs1orrfM0kJoRMzJRDRVv3Am6Yl08cJg1cKK2LiOjr9ZIEg30WIPuuVDJglk1zhq/mgc7qyygtJhCxHzKXRZQDF1khyhyFzHLn+kkZnWFuwuTeyxIwzDiytyL0yNKyTS4WJkzOqNAuDoQPefQvaEvCsYXCBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kh99InrD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kh99InrD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso9606109a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773361986; x=1773966786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mPkCvx2pnFym8JsephJmvr2CxcigT4hd7pOFhKXxM5k=;
        b=kh99InrDZIb4hxYiMp2OnQhfLWE3/+WAa13xcqn6YeN4JPS5uIIyRR6oZvVgrhAe0M
         3dxDe7F7jdad43gaSNV5gU79Hi6e+5E8q3iVR2Husw+8dG1IpEH4tMfdIzEJMuMWYIOI
         swGP/5Q6R1gBTEzOkcaVcIwvIoX47ynudqeL8iuMnx+D8w7eE/ed5rQnVnQh45gplEqO
         WBDXc51FhAZ0uMV0kVp8CAxy2JE2+aPnD61zum4oou9fKzVJrLOASnFtpQBcvr737lsD
         tgeMcVpQ15vgaO5bktBgk4S4Gd7YzFZ95lBMpkP+KUg8c7l3stSQOhSeT8dNi9aiyTn5
         Uxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361986; x=1773966786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPkCvx2pnFym8JsephJmvr2CxcigT4hd7pOFhKXxM5k=;
        b=rETxdnwCk1Q1sidpbml3EagNpYjL8BuEbCOJPC7duN7yP4Z/4uxXEP/AgZhaIqsuDM
         hxEjVpK/rnsre8W8TL3+PZyw4NtOzvgwhj+PMcJydODRXxm5OCEOJvHE+tO29VaJuQUV
         qjqLAXZ0foV9ctvv6TEFPrsJmK9oCc9f5u7IkguxEXmHGb0FThYsEJo7OZJMqw3O6RhW
         8CGkXHjhzaRAxkzh/9/4XqCf8KNnMz85+zrjghKV6m1VO+Sn7o4qZew+0n/3NVScPGnH
         WhRw1A22snL4bqkTHQcgRGKqcOXjcCvrKRGXlEwHdgbITDTGOzlypJBmnUK/70x0c15y
         1GXg==
X-Gm-Message-State: AOJu0YzFc2e8oVoypEFGLKSmZRHXlY2Qjw26shPaRYigY2PZpO8DNzmf
	bgWyuYQJuW196WZXLX7tjzQb320jbjzjVnldWIxZ1D8QFJsD3PikSYVxXcyjyDAKsa+NhFIVFfP
	isXSSjw==
X-Received: from pgac13.prod.google.com ([2002:a05:6a02:294d:b0:c70:ab5b:1dbf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:354:c600:1a1
 with SMTP id 98e67ed59e1d1-35a21fdd4e4mr1269621a91.19.1773361986375; Thu, 12
 Mar 2026 17:33:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:32:58 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Drop the WARN in sev_pin_memory() on npages overflowing an int, as the
WARN is comically trivially to trigger from userspace, e.g. by doing:

  struct kvm_enc_region range = {
          .addr = 0,
          .size = -1ul,
  };

  __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);

Note, the checks in sev_mem_enc_register_region() that presumably exist to
verify the incoming address+size are completely worthless, as both "addr"
and "size" are u64s and SEV is 64-bit only, i.e. they _can't_ be greater
than ULONG_MAX.  That wart will be cleaned up in the near future.

	if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
		return -EINVAL;

Opportunistically add a comment to explain why the code calculates the
number of pages the "hard" way, e.g. instead of just shifting @ulen.

Fixes: 78824fabc72e ("KVM: SVM: fix svn_pin_memory()'s use of get_user_pages_fast()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b1aa85a6ca5a..23a383f2e43d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -690,10 +690,16 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (ulen == 0 || uaddr + ulen < uaddr)
 		return ERR_PTR(-EINVAL);
 
-	/* Calculate number of pages. */
+	/*
+	 * Calculate the number of pages that need to be pinned to cover the
+	 * entire range.  Note!  This isn't simply ulen >> PAGE_SHIFT, as KVM
+	 * doesn't require the incoming address+size to be page aligned!
+	 */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
 	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
 	npages = (last - first + 1);
+	if (npages > INT_MAX)
+		return ERR_PTR(-EINVAL);
 
 	locked = sev->pages_locked + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -702,9 +708,6 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (WARN_ON_ONCE(npages > INT_MAX))
-		return ERR_PTR(-EINVAL);
-
 	/* Avoid using vmalloc for smaller buffers. */
 	size = npages * sizeof(struct page *);
 	if (size > PAGE_SIZE)
-- 
2.53.0.851.ga537e3e6e9-goog

