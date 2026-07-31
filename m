Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1C45FFB6
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516241; cv=none; b=RgaIWz13yBnikYrSI9VAVJ8qtNPhjjhFhCjpDzCUnAPO94XFF6qRyuLoXcvgRWQUm2GcSFh8S+4Lxfxqc8topNV68nY4ObL/h5ZsumenbqFu6a4WSkiMNQ0BJ4GTJJg9lVH2LOhmtE2LkRCTy4hJRIgXSmnixEevw6oUz+80vtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516241; c=relaxed/simple;
	bh=dDHSTOzfodwH41AG8mWGo0E+iIXJYN7gqzY27YFcp3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjY90bG8gpdNsDIVUGZsn1jtt6Cgf0zDggxggLAKTHd8g7dBXopKHKwMVOIZASv6PEFAS/c2l7o/q3pL502T/LwjWaMwC56mEp/kLj38usDAVcAaC3UMopMDSm/XI0WmzlyXUWQ67wncJanaOv6tV+6g1qeVZWXoCjABm0N0JUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aa4lAZF+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWPeVabh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aa4lAZF+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWPeVabh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ltyqZW5ZfqrwkkeZqLpjTnozgkU+0DHxMfwj6ZzMkA=;
	b=Aa4lAZF+46vKM/qdz8tkj3ZNHdWoQ/RH7R4rhvgA0u2uxJsU4hBiuqJlmAuwUCSS1qIuAN
	qsY8oFzk/fGkTkjZk04PjUa2b54wVSkWV5ePRl1P0jEarp4hJigJaoFuSyucSKMkoD25UO
	6XUZi2PrpLoumUSyDjf8H0s0IwsJy9Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-5Yt1wAGnNjOdO0bHIVnssQ-1; Fri, 31 Jul 2026 12:43:52 -0400
X-MC-Unique: 5Yt1wAGnNjOdO0bHIVnssQ-1
X-Mimecast-MFC-AGG-ID: 5Yt1wAGnNjOdO0bHIVnssQ_1785516230
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso135006966b.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516230; x=1786121030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ltyqZW5ZfqrwkkeZqLpjTnozgkU+0DHxMfwj6ZzMkA=;
        b=NWPeVabh4o/ZBbeqqe1VfwQY5p+QG7tqA9FXu3C4MG76tLS5E0IbAyJ3bgVBa1BYul
         b89f2fMNAf3PE8WGkge3ZWXoF5me46XeG3EaGIA/w6ozDdM3wT8Fi6N2ow6VHSG5/ip/
         IJbIbJ2pEqVdMSJ6nFe/amiVrY1U7TgV4g+1Af+JntNDo3oMV5zHFQ9QrBqmNVBQOFgQ
         honBL7v0+dmsVXUOTUDLi3jLdS1id+rMDWhIrkiedDdnnbVN8i4pTr8W+Dc5IptCv9Eo
         WQpeA5FvfPso4N4/o1QOFGu2NaBellySCRVBufhKhDLHr2jb+IrNwyb+GqF7C4ulB7/6
         57gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516230; x=1786121030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ltyqZW5ZfqrwkkeZqLpjTnozgkU+0DHxMfwj6ZzMkA=;
        b=ZWyLZl+B0sujT5Fs2YSekrToikpUhe/9RZTosnOWE11NlsR9DzUGC4FH80ohlguffw
         6KewYpCCwJz5AM48LYFF659eY5yRKI5DfcsVMXUPMlEMRYpnUiSuDncA+xg/vO28BP3I
         eYGGp9wi8HedMruu2sE86MKVpD+awJUpxyGgIWZDy31y4RLt18Pxs4fUkKzkgz0SL0xA
         i4ebJODxZ5boYmLbIx1CQ+4N7VU6cpU5fXTenQ88R5PuOVN2Gqlcw0E8pJ0jzX2iaKea
         ZSuoxM4V34iXYVY6jmHtzzjnAfCNfEsU++qeitfimF02PfNWOvL0i2u9N6T+YMl0vIt4
         xLnw==
X-Forwarded-Encrypted: i=1; AHgh+RoVBA6EkCn0qetfCgxfbwa2dO93FBDbBus3PlbyLskJ9RFYBMCS00CUchYTZHlsM6VYjIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8+SYLxm43BnQ1VL18HSYAmfmf1vZXyRoORIZzO3Nt8RGLeif
	oCKfDwH9ZBbRykVHs7bo9GvYdnh9eVdWRiu/IPYMvM4HXvX742wMZ3oToWPYinCjThSQTCtU26k
	COL4U/00tFtmHK+BUZCQHLwi2vnlxzfd6uz7qCt7Xht/pPcmrbbwxmA==
X-Gm-Gg: AR+sD10ZmcafvvufROS2gSHwkZUtE+f9Y+Ddj5gXy5Uzq+qbLJbM9vzAqWOHpYo4lwp
	M6ND52wTUZXZtDqeV++iIuJe92DlddjEqPpiCZOWECUygc/l6IwZvu9oy6T50lL/B3df88XSihz
	BSF0CFa7K2VCYz9VqCTrBrDyKhUcbvkSTJouQZRBzdSd7sKxIdT+NOPJbP3A5ijYXT1FBCs/qMh
	OcqDjvdmxhn4k8MdlfwvQ/sld4e5H8OrcvMOi6n7LVwLIak0CpMctnRcGMz21HZqPW9KYqSGAO6
	GJ+Je+kuArPJJv6yRMJU16srW9urub07+QJvyPtGkMHukJ19D4b3jvF+KkO+VshKblFUuQJy007
	CarGQOSxiU6cjiuSpjFbfg6O9LwmIXCO0CLwTT0v8FzmakQPlqyOApm4hsp9z/V76n5HVak+nNR
	pTTmI=
X-Received: by 2002:a17:907:d1f:b0:c1f:17f6:2a74 with SMTP id a640c23a62f3a-c1fe7fc540fmr36348766b.9.1785516229926;
        Fri, 31 Jul 2026 09:43:49 -0700 (PDT)
X-Received: by 2002:a17:907:d1f:b0:c1f:17f6:2a74 with SMTP id a640c23a62f3a-c1fe7fc540fmr36346066b.9.1785516229473;
        Fri, 31 Jul 2026 09:43:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537761sm215223766b.52.2026.07.31.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:43:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Sergio Lopez <slp@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Subject: [PATCH RFT 2/3] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Date: Fri, 31 Jul 2026 18:43:40 +0200
Message-ID: <20260731164341.1109827-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that KVM or VFIO correctly see a writable PTE when
they request one.  Otherwise, a guest write to an unpopulated
PTE from a mapping backed by a DRM GEM BO triggers a VM exit
with EFAULT.

The code actually is simpler, because the same logic already
applied to the hugepage mapping case using vmf_insert_pfn_pmd().

Reported-by: Sergio Lopez <slp@redhat.com>
Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..33a14f558276 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
 	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
 }
 
+/*
+ * Because the vm_ops have a .pfn_mkwrite() callback, vma_set_page_prot()
+ * has cleared the write bit from vma->vm_page_prot.  vmf_insert_pfn()
+ * would install a read-only entry even for a write fault, relying on a
+ * second fault to reach .pfn_mkwrite() and upgrade it, but that second
+ * fault never happens for fixup_user_fault() callers that directly
+ * walk the page tables with follow_pfnmap_start().  To ensure that
+ * they don't see the read-only entry, pass FAULT_FLAG_WRITE info down
+ * to install a writable entry right away.  Because .pfn_mkwrite() is
+ * not invoked, record the write afterwards.
+ */
 static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
 	if (!order) {
-		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
@@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 
 		if (aligned &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
-			vm_fault_t ret;
-
 			pfn &= PMD_MASK >> PAGE_SHIFT;
-
-			/* Unlike PTEs which are automatically upgraded to
-			 * writeable entries, the PMD upgrades go through
-			 * .huge_fault(). Make sure we pass the "write" info
-			 * along in that case.
-			 * This also means we have to record the write fault
-			 * here, instead of in .pfn_mkwrite().
-			 */
-			ret = vmf_insert_pfn_pmd(vmf, pfn,
-						 vmf->flags & FAULT_FLAG_WRITE);
-			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
-				drm_gem_shmem_record_mkwrite(vmf);
-
-			return ret;
+			ret = vmf_insert_pfn_pmd(vmf, pfn, write);
 		}
 #endif
 	}
-	return VM_FAULT_FALLBACK;
+
+	if (ret == VM_FAULT_NOPAGE && write)
+		drm_gem_shmem_record_mkwrite(vmf);
+	return ret;
 }
 
 static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int order)
-- 
2.55.0

