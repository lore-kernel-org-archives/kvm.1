Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE620463B6E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516258; cv=none; b=fCW68x+XBIwAvtH4o5s9HpTPDkprQzKMJVKue5/vZe4YkKyrfO5AbixrtRinIj9pyLxkuVv7FeHSK0nwI/ZScz7ttrTlFtepsDulNP55VmXl6FA+VJfVQfBOL4V7Ncuhp8NaWaJeMqjmle8m3DZK6BDg8BD/O/nm7XWoQ9o/qjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516258; c=relaxed/simple;
	bh=A45rtVuI2v+Zs4TW0iC+h2We1+nvtl6ZE/yluKW9Tsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhIqroQRO7+DUcD4a2U0fqHzZ+EVwGlDRsQM+Q8NthzY0soko4J+dii1xEwr0dyXl890PahVs0QOi1zxPFVuwLihHhOBIFVVPiGLLM9zE5YhikKiUvFO3TJEp6l+fwuhXYUcJ2LD94giW3ZdDGj6ahA8GJbB9P+gBTiuwkb/zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLt7C4Nz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j4ju4uv0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLt7C4Nz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j4ju4uv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKIuXVAQxBinLsqe2l2r/I0mxnjKp1xskcVhmjIrGQo=;
	b=BLt7C4NzalwgQrAguhDuAEzVAcrhjzL/qSnt0rwQiihat5dQyGk5TV1cKhhTa/NrdVV6HQ
	el+EBWA6lElGu6/91efVox9VKcJ6QrZQKRPhGK/3wfSejAAeI45TlR36ePiWJvCLUAloSO
	9FBH/OFYXJmZveVvKGAVrEKFBdpLlQU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-AP7zVQB2MFGgx28RbOlxPw-1; Fri, 31 Jul 2026 12:43:53 -0400
X-MC-Unique: AP7zVQB2MFGgx28RbOlxPw-1
X-Mimecast-MFC-AGG-ID: AP7zVQB2MFGgx28RbOlxPw_1785516233
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698af52daa4so1346303a12.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516232; x=1786121032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rKIuXVAQxBinLsqe2l2r/I0mxnjKp1xskcVhmjIrGQo=;
        b=j4ju4uv06S0SXfdfmqtNhx/sgFmj1KnD1fKFOT++ls4tatWMhyFyHEIS+qrR7RFu3r
         v7hZLLFfjlz6mV97dr7tQPLBUx5eOcWNbGjx3JDpqf8tpSSy2/zqiF7pz93jSbr0LSc7
         ar7uODyjw2cOZkkmeFV6aCABH/19L95QLDG3L9LnN3op23y8pMX78eACHVuYv5iJkUKM
         6ihyU1W16uIJlOxeZ9VwDRc7mYPnnvi0NUof+jPyxYODhGdR/olNVD+JHKaB49QdrXWb
         S+JOu3U+NMyCHJFUsudAutNUtbgVkHWzEXxJ8ADrEafdXGQQA3FhvFhZMqLPwhV3APe9
         UDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516232; x=1786121032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rKIuXVAQxBinLsqe2l2r/I0mxnjKp1xskcVhmjIrGQo=;
        b=MaNjxjdzNvuLOlzL7zx1tRbUdixKwQwwn2dGy5A95DHLuHOx38K8zfVdVj+Kce2IJB
         pq74zxN3jGdjotnBmne4hGIC9fdCtQUvy4myywI/AAWb5exnIVuaWFiqEt9OQ4a04LMU
         MMJXl9vAfiCgZG9xh5EMgE1Z/DDUaW1mHp9pE+NRjoPB/5E0t60BOnlX9u6inn6WmoAk
         tTCngazOZoMWY/R5kxqD6rnigZXAn8OLqjYgJcvji4RxdCSlxpmk2PktnTsB5Ask2pxT
         +viojXmc26E5GTcf1T/vS6/RGDsowKT8hHPFnEVdLhzmlh3nf+wF652ARW+N5DDZ7ZNX
         Bm/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKPJ2LnzqmxcXYhRtz8EK67qrmns9O5evEFdl1jnAxNqSV1q6VXq28aM134VVvcQEP6Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy597LCXNsdnhhxgOyJD4YLQ2AZLR6iz48Ctc1uPzjF27/vfCcr
	ANxMKllm+oIuLhmuyL/0Olmh2LxMiAV+LnWaPtoPjeVNy2EXC0X2Q8/bLAvacAKHQrWGDJ8Aev3
	U4KFYYYCT6tJDtJ7PWpljMa74nWSSnSgo1XjPxIBBkl+QMl3bSMVEBA==
X-Gm-Gg: AR+sD13NhvFDiKf+DT0wfV91MVteLu5slvS4zjEYVATYV8rj6RaEYzRX6VCsz1KogYm
	4fLspZuqK97I+pjhDNuPDaMkZOJ6ambLmwXVsIK2RyYLnOVMkYrg03fvjWZqFLJjwAmdNcMgh58
	TLIrVf3hpDcRemJ/VAdTOURJqUsyucX+058x88PZssKcsb1yFu8kHku2uXXzh4Ef+qh3BLcsA7m
	/0hgw5YJvDOK86yqbCtl/571+qC6GRPHf08G8BKtkgkBPEPogyJEhP6ymKFQhBSqOcMpdq+EYZt
	UDoqDNVYw3WtYrbCvZxl22QaSE67szFEad3Borwet8oWIabdfHHaKew4/8ZDxgcJW79PjIPqKgy
	Ekxss1IPc6To1Jxi3QQ33QtQLjEsILt47BDOoXC0tm0y7DtLcOMccUpSn22b3FOcGBKHRzTk27Q
	0qEiw=
X-Received: by 2002:a05:6402:548a:b0:6a0:923a:cfe7 with SMTP id 4fb4d7f45d1cf-6a0a7cf5cf6mr192242a12.37.1785516232547;
        Fri, 31 Jul 2026 09:43:52 -0700 (PDT)
X-Received: by 2002:a05:6402:548a:b0:6a0:923a:cfe7 with SMTP id 4fb4d7f45d1cf-6a0a7cf5cf6mr192219a12.37.1785516232159;
        Fri, 31 Jul 2026 09:43:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a0556sm2582577a12.5.2026.07.31.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:43:51 -0700 (PDT)
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
Subject: [PATCH RFT 3/3] drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in use
Date: Fri, 31 Jul 2026 18:43:41 +0200
Message-ID: <20260731164341.1109827-4-pbonzini@redhat.com>
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

This ensures that fixup_user_fault() users see a writable PTE when
they request one.  The flip side is that vmw_bo_vm_fault() now has
to record by hand the write fault, because .pfn_mkwrite() is
not invoked.

Prefaulting works as before because only the first entry comes
out writable, while the following ones still end up executing
the .pfn_mkwrite() callback.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..ef27a2d7afc0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -263,7 +263,8 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
-		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		ret = __vmf_insert_pfn_prot(vma, address, pfn, prot,
+					    i == 0 && !!(vmf->flags & FAULT_FLAG_WRITE));
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..2cc490e7d758 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -398,15 +398,33 @@ void vmw_bo_dirty_clear_res(struct vmw_resource *res)
 		dirty->end = res_start;
 }
 
+static vm_fault_t vmw_bo_dirty_mkwrite(struct vm_fault *vmf, struct ttm_buffer_object *bo)
+{
+	unsigned long page_offset;
+	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
+
+	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
+	if (unlikely(page_offset >= PFN_UP(bo->resource->size)))
+		return VM_FAULT_SIGBUS;
+
+	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
+	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
+		struct vmw_bo_dirty *dirty = vbo->dirty;
+
+		__set_bit(page_offset, &dirty->bitmap[0]);
+		dirty->start = min(dirty->start, page_offset);
+		dirty->end = max(dirty->end, page_offset + 1);
+	}
+	return 0;
+}
+
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	vm_fault_t ret;
-	unsigned long page_offset;
 	unsigned int save_flags;
-	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
 
 	/*
 	 * mkwrite() doesn't handle the VM_FAULT_RETRY return value correctly.
@@ -419,22 +437,7 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
-	if (unlikely(page_offset >= PFN_UP(bo->resource->size))) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
-
-	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
-	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
-		struct vmw_bo_dirty *dirty = vbo->dirty;
-
-		__set_bit(page_offset, &dirty->bitmap[0]);
-		dirty->start = min(dirty->start, page_offset);
-		dirty->end = max(dirty->end, page_offset + 1);
-	}
-
-out_unlock:
+	ret = vmw_bo_dirty_mkwrite(vmf, bo);
 	dma_resv_unlock(bo->base.resv);
 	return ret;
 }
@@ -484,6 +487,9 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 		prot = vm_get_page_prot(vma->vm_flags);
 
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
+	if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
+		WARN_ON_ONCE(vmw_bo_dirty_mkwrite(vmf, bo));
+
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
-- 
2.55.0

