Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D340435AB9;
	Wed,  8 Jul 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509272; cv=none; b=HN9UXIN0Sc7V2oBdO7AhzXCQtSqBFGM1Nt17EK70lqVgUKIMt5vQl+QUTG1zHp37DjtTPlhkLnWnmInQja5R9bTYr4Q03UzMuqkPlbcxlkab71+bBo9T4qUfPEA8kTxx26fBA95uqmVryfUabx85I6FdZpjKuXUesZ6vO6V3odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509272; c=relaxed/simple;
	bh=D5blKixSKUjIZNvba/4Oy8tOCO45xeMNpOCPKdg62lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnmufVxzhqF0bKvA4Re8Ly6eeFWjNvDLDwDdNpecfqOJjfK+/vaw6w5TP2Uv3Ygu2UpQJm8WLibyG60iX376V4ouqCK3MfBS/em9jYgzZwhoXHms3kp1m0hRPip7h/HHcUwJNRi0lU7mbmrSDcTirAmH8PoEJeZXsRABmg3Ttz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=A4+wb7rC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IonbHU3W; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="A4+wb7rC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IonbHU3W"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E18BE1D00128;
	Wed,  8 Jul 2026 07:14:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783509269; x=
	1783595669; bh=KHWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=A
	4+wb7rCn/35uZe1LOC31HNCxrSmlDZa1pEMLJvp5kBKjMRKc2V6bzdgRQYZNEQQj
	IWLIMrAW/el+aVWiSDnGC6tKiSxxyuQ/T4vISRLtGdaNZiGbme8SY4TA4942Gnml
	zGDh0i8GK0Gke7Ct4RjOZZEkR2qM5pSvE42b6UQMZ76UG9CXv5rnfOhS/SV2kMgy
	2U7htMr3yC1zySUMVk8QuVMYmxQiDqF17/XNmSMqbjeRu0WyTXzdTcgrqceVIuL1
	HeXE32u5kHNXwI6GR+eqqt5Tjfv7tBkQ6ruz35Tcuck/mwDpkHX/ttPeY0eGS9/1
	/frAl/L0YWnAGjiNMGcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783509269; x=1783595669; bh=K
	HWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=IonbHU3WuIu3RNgS6
	hXINaWGxmcZzjlpRJ8ReqS5LyISBfc84Ftji2N7ANyoarnARqQfaH5fAaEMaAHq8
	7EQ9op02tQIeXMAOdgN3s6V7HrUK30tTfOUpYkn6OxzRStGQxZ+uWwH1mnxw4k9T
	ExPxu+zAxa7ZEJKXoNhaXRQOW5htcOHe3hdloS02cfoPhgpq5ZU5/CNOdyexPO77
	DnAS4ZL2G0SoMYeIzRq5gYDcj2g0OyG6+ETfgeEgBFH23n/dgG/dpxPmbznMa4YH
	Uo8/OVVHGe+EPUqdGxnx2ag1G0s6wQk+jw7W5oSDm7JDVD8ZA+9HfxVVDO4f8wgA
	OcAMA==
X-ME-Sender: <xms:FTFOalKhKgQKzjwTORA8yRywQUBZpkUefoLUHTaOWGI-335Atbc34A>
    <xme:FTFOalGj2LQwOwjVCnVMJwM6krkIH4o0G_TZcJhsCsIDw2s_665KCtH07WgOsBDfh
    Lu8NAvVLSzCMvK37-IF9aMW0WATToK-z3TUz-SMVMGGFAwvhKU1TXnZ>
X-ME-Received: <xmr:FTFOamOPYbiHFQBVVkUCRSVoWj07junKbvgluAQKX6wxsr3lEc55QD9ATopXHQ>
X-ME-Proxy-Cause: dmFkZTFrgK+JlrVaprEdMCCT9jL+WeqlR41PWLlswNzN7Q+R9eHi8slIfq82AsY5fCzbDR
    FF2c6/38vqfy5yn0mfN1Q1IuR0w/6jjhcBlbbYbwVeHRfHyttYIq8Oj6v9pP51nLVeKVF5
    08J2hQde+dVWeXYQH682oaYmn32K1d4rnz4RgIn1j8hjtXUL5IxvtXbrp9YKRUv370bN2m
    UN+Zd+JxmqGqLZtvxlNtOAXgPcUE/BQPZ7oqAykND9BbS/e5r3R+8nAwQL3YfeXzdQzT7u
    8EidJ7yOHxiJJbRHrAGeZIH1+iybwcJ1viiDHX7PYKqYv0VVB7VVolJezAJqTlXxgJaxRM
    3ThiLxApzLqbqqYrfIhpjK6gEBmC/k4qXCx8v2AGxu/dBZDG4cm2k7SSljLRv/d06xaQkH
    O6HdyEwpDT9bpMasaSEfONz8qeJLMIDgQv24qrEIiTFLtNOTXdmJu8iDJSRFYRp4bR3F0o
    A1+ylmxjF3E0/9b50RHOsOcqEL4hsWe6wUc9GznweCniRfcxVGWKU9JUA0uEqpMcCxuzX+
    N9/zNLSpu1SPpvZW4SHUhLfktWRpl8uMd45JV+TwzbkPvSxxok3m1sQVDvcoK/XiIyDau+
    YVhqKRxOA47Dnjlwn325FlfP0Q/eCX/PrmaYv5lFO3x9VU/CwSalbmZ2yeqg
X-ME-Proxy: <xmx:FTFOav8PfaPEYAHn8foyMsSx1HJbseg2ZNyzCkDRj5RhBztw6uGnLQ>
    <xmx:FTFOaj48e6h-zeuQyHOBe4MCNs8fln4wwSjCGuyOZ7vYpBK3uKkFcg>
    <xmx:FTFOakVsCcEZ0isz4qL1K_BXu-2kpPkNEP5AJnhcA9NQag_1W4zJMw>
    <xmx:FTFOapI91p2uHJ-k-g87Wd5mnCmw1-XoqXmgEEEF2VJ6w9Qx5pA1gg>
    <xmx:FTFOauLmcFJYYgUuCFXJvSYB0vpUQ1UQJ28c_SA8CX1I3xtN_c1Db7kp>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 07:14:29 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	kas@kernel.org
Subject: [PATCH v10 04/15] userfaultfd: test uffd VMA flags through the vma_flags_t API
Date: Wed,  8 Jul 2026 12:14:05 +0100
Message-ID: <20260708111417.173443-5-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708111417.173443-1-kirill@shutemov.name>
References: <20260708111417.173443-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

The uffd VMA-flag helpers read vma->vm_flags directly. Now that
config-gated per-mode masks exist, switch them to the vma_flags_t
accessor vma_test_any_mask(), which is the going-forward API and keeps a
single place (the VMA_UFFD_* masks) that knows which modes are available
on the current build.

No functional change: vma_flags_t is in union with vm_flags, so the same
bits are read, and the masks fold to the same code the open-coded
vm_flags tests produced -- verified identical on gcc and clang, 32- and
64-bit.

Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-8
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/userfaultfd_k.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 658740df2978..c4f2cc6dfcf0 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -178,7 +178,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+	return vma_test_any_mask(vma,
+		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
 }
 
 /*
@@ -190,22 +191,23 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
  */
 static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+	return vma_test_any_mask(vma,
+		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_MISSING;
+	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
 }
 
 static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma_test_any_mask(vma, VMA_UFFD_WP);
 }
 
 static inline bool userfaultfd_minor(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_MINOR;
+	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
@@ -222,7 +224,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
 
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & __VM_UFFD_FLAGS;
+	return vma_test_any_mask(vma, __VMA_UFFD_FLAGS);
 }
 
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
-- 
2.54.0

