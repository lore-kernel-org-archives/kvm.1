Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196738E133
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805760; cv=none; b=hQD8jJUYpq4O2l1NWKlu9o+7fWDcqSupjafMQucLA+4GdwKGLoraYcCyKwvMseBxsLII4Hqr/UgluY+dNZQXSiKcAeGauwMw2fEJaiqcmTmrApjyWdDyX78Le7JMkzGlL/ZOuftNRp+CBiP7dh4ZwldpqP4yllHb7+gyttCvoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805760; c=relaxed/simple;
	bh=y8f3MvZGTGVu8W2ARcgIr5C30UatorQ81Y4tWSzmzcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NeNgg5KdD+pgVNafNIU3JEW7VkNS1XeJt4VSM3qrPhqm6g9G7Xduui6LIPxSBrfYakIOCyILx3wiQGGjlYGDwXFxPaLS3iUuNsUUlvLN2IOPSluoB7KoVin8tiPjzFwhZ5N7FlJxQ214fZ3q1qPnLq8NqJrk1QjPYD7bafQZYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0XdYPC3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0XdYPC3"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66184f62c28so1859121a12.2
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772805755; x=1773410555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gF/1dYRQW+uqbPLKzRe8y1L6gtybgCjS8ZQI7GMo3BA=;
        b=j0XdYPC3V7Gin6Z5JUmOvt7kf9VgPpSLCkmNoHJlngLpAmvpgIjI3o7y7unLO75/ey
         H5eJPeYa5oSEZEZ7wvGd88WiB48DuOo/3DHGSXngVzc6SplCQQ59b1TLes4Lf6sVQc56
         N3CenSkz1gSUh3RtJPqUwd+Cw5i0mJIwSFA+36mjf9Y4G3uGXR51R55wMxLtfsFfg+et
         qTYNJk4QKfEQSYfAiuLYy9blbRr15HBV+GHOW7B+vGimu3m5+5aViDzUdkY4HL4aEthp
         pm3MXWxwcS7cDzbM5LkNZuJh1vptSjCaJ8IK6nKe2gVlzqGT1MKwWQ83VjJlKsqinzNn
         fr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805755; x=1773410555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gF/1dYRQW+uqbPLKzRe8y1L6gtybgCjS8ZQI7GMo3BA=;
        b=PhHJATwfQ2dlfvrb1MY9YUz3o4mQbsRb4Z5bNSOoY63kkjCY+b7wqrf4ckxd+0/ZcJ
         Y4PZcqErpNSeJXbWW7L2JNLonCjTb9cKxBLnrwD2vKB1k5uEVmArCFpQHyAxYw9W7Fh4
         AeSsbp069rAkZBP0guo56fxpRwxu3Vt3WtNtm5jtKH/1I1SOStQ5xolvV/GDbmojZIkY
         d3kHVhb1+pXBcQJ51KrNAM3lBaReU675izUDPlhPzcFU6dhPEU3yaGvFF7XDU/FXD2dk
         MNyggUUJuWaUdB04EqWO3+gHxggmDbY1ZZGMt5mTTQh1F2ZlrgYYiIB1JHZPd1DSZF9C
         P6Sw==
X-Gm-Message-State: AOJu0YyOD0bMjTgb2I9wNqpyKMv1/4bhh0bhao6JDW2jRxmRM8jDl1Ku
	wbRGPQwcYx0Q2SnMk76U4gsE3vQ9Yh1AqnKSnWV6jOD/BADYtAglYqWQKDG9CH5q045ez863+PJ
	bEMl6Q5PeA1XYc1buE93afVdJ84H+Kp1XCEJ4VGsJugRSXZk/xhcfNpIrFk3zkrstScMA8qLpOM
	pyHlyMv39Yj8stDtvQU++FR+DLs+Q=
X-Received: from edge19-n1.prod.google.com ([2002:a05:6402:a553:10b0:661:1c9f:b877])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3990:b0:659:3ff1:58fa
 with SMTP id 4fb4d7f45d1cf-6619d5205camr821175a12.29.1772805754847; Fri, 06
 Mar 2026 06:02:34 -0800 (PST)
Date: Fri,  6 Mar 2026 14:02:20 +0000
In-Reply-To: <20260306140232.2193802-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306140232.2193802-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306140232.2193802-2-tabba@google.com>
Subject: [PATCH v1 01/13] KVM: arm64: Extract VMA size resolution in user_mem_abort()
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, qperret@google.com, vdonnefort@google.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

As part of an effort to refactor user_mem_abort() into smaller, more
focused helper functions, extract the logic responsible for determining
the VMA shift and page size into a new static helper,
kvm_s2_resolve_vma_size().

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/mmu.c | 130 ++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 17d64a1e11e5..f8064b2d3204 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1639,6 +1639,77 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	return ret != -EAGAIN ? ret : 0;
 }
 
+static short kvm_s2_resolve_vma_size(struct vm_area_struct *vma,
+				     unsigned long hva,
+				     struct kvm_memory_slot *memslot,
+				     struct kvm_s2_trans *nested,
+				     bool *force_pte, phys_addr_t *ipa)
+{
+	short vma_shift;
+	long vma_pagesize;
+
+	if (*force_pte)
+		vma_shift = PAGE_SHIFT;
+	else
+		vma_shift = get_vma_page_shift(vma, hva);
+
+	switch (vma_shift) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+			break;
+		fallthrough;
+#endif
+	case CONT_PMD_SHIFT:
+		vma_shift = PMD_SHIFT;
+		fallthrough;
+	case PMD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
+			break;
+		fallthrough;
+	case CONT_PTE_SHIFT:
+		vma_shift = PAGE_SHIFT;
+		*force_pte = true;
+		fallthrough;
+	case PAGE_SHIFT:
+		break;
+	default:
+		WARN_ONCE(1, "Unknown vma_shift %d", vma_shift);
+	}
+
+	vma_pagesize = 1UL << vma_shift;
+
+	if (nested) {
+		unsigned long max_map_size;
+
+		max_map_size = *force_pte ? PAGE_SIZE : PUD_SIZE;
+
+		*ipa = kvm_s2_trans_output(nested);
+
+		/*
+		 * If we're about to create a shadow stage 2 entry, then we
+		 * can only create a block mapping if the guest stage 2 page
+		 * table uses at least as big a mapping.
+		 */
+		max_map_size = min(kvm_s2_trans_size(nested), max_map_size);
+
+		/*
+		 * Be careful that if the mapping size falls between
+		 * two host sizes, take the smallest of the two.
+		 */
+		if (max_map_size >= PMD_SIZE && max_map_size < PUD_SIZE)
+			max_map_size = PMD_SIZE;
+		else if (max_map_size >= PAGE_SIZE && max_map_size < PMD_SIZE)
+			max_map_size = PAGE_SIZE;
+
+		*force_pte = (max_map_size == PAGE_SIZE);
+		vma_pagesize = min_t(long, vma_pagesize, max_map_size);
+		vma_shift = __ffs(vma_pagesize);
+	}
+
+	return vma_shift;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_s2_trans *nested,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
@@ -1695,65 +1766,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (force_pte)
-		vma_shift = PAGE_SHIFT;
-	else
-		vma_shift = get_vma_page_shift(vma, hva);
-
-	switch (vma_shift) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
-			break;
-		fallthrough;
-#endif
-	case CONT_PMD_SHIFT:
-		vma_shift = PMD_SHIFT;
-		fallthrough;
-	case PMD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
-			break;
-		fallthrough;
-	case CONT_PTE_SHIFT:
-		vma_shift = PAGE_SHIFT;
-		force_pte = true;
-		fallthrough;
-	case PAGE_SHIFT:
-		break;
-	default:
-		WARN_ONCE(1, "Unknown vma_shift %d", vma_shift);
-	}
-
+	vma_shift = kvm_s2_resolve_vma_size(vma, hva, memslot, nested,
+					    &force_pte, &ipa);
 	vma_pagesize = 1UL << vma_shift;
 
-	if (nested) {
-		unsigned long max_map_size;
-
-		max_map_size = force_pte ? PAGE_SIZE : PUD_SIZE;
-
-		ipa = kvm_s2_trans_output(nested);
-
-		/*
-		 * If we're about to create a shadow stage 2 entry, then we
-		 * can only create a block mapping if the guest stage 2 page
-		 * table uses at least as big a mapping.
-		 */
-		max_map_size = min(kvm_s2_trans_size(nested), max_map_size);
-
-		/*
-		 * Be careful that if the mapping size falls between
-		 * two host sizes, take the smallest of the two.
-		 */
-		if (max_map_size >= PMD_SIZE && max_map_size < PUD_SIZE)
-			max_map_size = PMD_SIZE;
-		else if (max_map_size >= PAGE_SIZE && max_map_size < PMD_SIZE)
-			max_map_size = PAGE_SIZE;
-
-		force_pte = (max_map_size == PAGE_SIZE);
-		vma_pagesize = min_t(long, vma_pagesize, max_map_size);
-		vma_shift = __ffs(vma_pagesize);
-	}
-
 	/*
 	 * Both the canonical IPA and fault IPA must be aligned to the
 	 * mapping size to ensure we find the right PFN and lay down the
-- 
2.53.0.473.g4a7958ca14-goog

