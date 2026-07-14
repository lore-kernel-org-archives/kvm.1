Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1C37268B
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070634; cv=none; b=ph0DvMjk3hXooApIV4bGGHAg/dXw56ZeWbO2FnhfcQMcGYOMg02D7mmi6I0G9pBWOoprgFnVsysF5tKtEl9whQTXG7XbAfgWHnezQy9t1iQdPODthrb3O1cqrAcvAyuuc51bwBXvNdHetcn9CIYxirpfO2LtN9+ZXZFPqvq1WuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070634; c=relaxed/simple;
	bh=tz5b/wi/KYGTi5Nu6+p4FjHc5VJHE+aDIvXJoyYFA78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W+OkynQ8CX3P24eYQAK0ifYgY7lN/krojPUQV7ZkggjW7S9lU2DR2uudWTEr4VDpRe2v22T9NWE6ZHiB8IUAOknD7nHzRLjoysZ7jf+ti5u89m+cNAHd2XH7hG5M+qY9u6ttE8EVhV3SN1m0KzKBrC3u9LJAROdrJCGsG6Xa44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syEZm4cj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syEZm4cj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso574249a91.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070627; x=1784675427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RrCeiUHQV6TkQ4lj9oPcaTCYumTpjVqI/CaCzGV8zm8=;
        b=syEZm4cj1wpnrpTkwgTvby+yEH4TdJgm8vM8mAFk5D87JZqs4KjFVVdjgi+RcCfGgZ
         iYIWYHq9O4mFkDwmLcdfJSsOpjPYH75hnlNzA1OuU/Br2nWh97zX6OvzuaMuIH4z9AFC
         s67b/UpSRi/8wNfN5Y8xFAUWJlcBUh2/atDE3WgA02B3pOmNCgzLbhd0NMTQMNzKjlow
         k+2K4nQtie+7FVSHgEJd4kjYr924QBPiMfgbve5sSJgbkKmLJMAE67jIMJ61rgX7eNba
         KJz0t4rAGhLbc3tTfcjs90e6cNYYTL8JH9AQ5LdPBLWZCC0cI63wab/5t4SZ4exjPh73
         tR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070627; x=1784675427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RrCeiUHQV6TkQ4lj9oPcaTCYumTpjVqI/CaCzGV8zm8=;
        b=cKeRbqzQlWlYQl+uVnuAFlzn0QI2Irns2BRIEDbNPao+KxMBWIwtmu9YGRAqrSTzQm
         sFSuy4v/1kXRXsh5Tqo5xA3bKxZ8Yia9BNQW7f7b2S/dxPfEQKjySOa3jxKxo44n0Iv8
         POkFyprhp1Ti0OlYWH5al/Za4iGYSwE3R9UWQztWHN5k/UFacD3nz+Qlq4oRcRgkc1yW
         vx+c7/65YoH1mlhU2bPjQV3HWRx7Hgo6ubJohG77jNngi4YN19dxGOFusNWxXuvr1sph
         gH3J5IUvUO0D9FA3vIOYSAiPT6sAmBJNps4ejsyo9jf6+LpGG3bJXVmsNgYDL8Oq4fmy
         Q7Sg==
X-Gm-Message-State: AOJu0YwDGwOSiTVeia6qvcAuw3mlFn+yINDf6Cu7G/BRXppeQDSHvBj6
	AToIMChqu0Yz/QRXedIP4HHJYsQ7+ctJDKYWYFXr5dSzqjy3ipwTKR6YbYw6FT5dm1vjFi1a92B
	zDAOwvQ==
X-Received: from pjbgb7.prod.google.com ([2002:a17:90b:607:b0:380:6618:e058])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cc:b0:381:22d6:f7a3
 with SMTP id 98e67ed59e1d1-38e2a030362mr523926a91.18.1784070617847; Tue, 14
 Jul 2026 16:10:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:09 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-2-seanjc@google.com>
Subject: [PATCH v5 1/7] KVM: guest_memfd: Plumb the number of pages and max
 order into .invalidate()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Plumb the number of pages to "invalidate", i.e. reclaim, along with the max
order with which the pages can be mapped.  This will allow x86 to combine
its vendor-specific implementations for conversion and reclaim, a.k.a.
preparation and invalidation, into a single hook.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       | 4 ++--
 include/linux/kvm_host.h | 2 +-
 virt/kvm/guest_memfd.c   | 7 ++-----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f5dc685f049..a2cbf6fae118 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
 {
-	kvm_x86_call(gmem_invalidate)(start, end);
+	kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
 }
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9db6eb4023c4..996b39ebdb68 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2614,7 +2614,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 171a9da1b685..99c070bfd446 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -530,11 +530,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
-
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio),
+				 folio_order(folio));
 }
 #endif
 
-- 
2.55.0.141.g00534a21ce-goog

