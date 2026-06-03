Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AC39D3D0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502260; cv=none; b=POIg2I9SoqD4mH5KOSxIParMFz9SLH4xyj98AmDX/F79JhFOdUjE4K8DrRlDtjAwVxk1/utjqFJYCKfwhCt1TD6nQs9ma226YtkK/g/+Vrn/GpN0/q442GXxWgFp8vQiELAtlrTEadfvdVyA4WxqDYqAgCMXgxAM1gh6O9YaX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502260; c=relaxed/simple;
	bh=WAQIoHTlBxVyYdvIJffoAQe2UY6zSxiBxLZAcK8bklo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q0ub6PLvM8xDtY4V6b6j1O3q9Uf0CVKThFFj17PEgq+q4Zvcf+vvzv3jpTJKsP8RhVM5ocnwW1B3K/gstiHt4fjaE40BirJUTZeYWS7l4Y4qKhqKFOyjwYZzXMxgeubj/ql4o74OOyIXdiBHYqglQCGYnSRLq4U0nYrhv8VozNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBH5nb02; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+LvN6/t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBH5nb02";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+LvN6/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780502258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4ZnRxCrKTQBkdfnD3QSjhYT6bOKjFB8zBJmcLTyHQjQ=;
	b=VBH5nb02RYVszE6TorDY1+1a5QxNhwkemFJR7qzkp3nlAI3TOvucu+nVTNj8r6og/VZyIj
	cptcIA9kuZ9eGgptljxySCUnR8hgjnlzJXfvqukj3Y6h+RtgTsGpg8Z0Rh6HnjYSItwHp4
	HIbt91m5V24dR6IVdOhhP5UBsVKIEHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-tYfcl-RQP-Of3KPF0JGxTQ-1; Wed, 03 Jun 2026 11:57:37 -0400
X-MC-Unique: tYfcl-RQP-Of3KPF0JGxTQ-1
X-Mimecast-MFC-AGG-ID: tYfcl-RQP-Of3KPF0JGxTQ_1780502256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso15135815e9.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780502256; x=1781107056; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZnRxCrKTQBkdfnD3QSjhYT6bOKjFB8zBJmcLTyHQjQ=;
        b=c+LvN6/tWa/IZXhBy4jYdYW7t2zfffdSiHdDusXkNe6WNf6DnZrSEZB01m/Bva286d
         wtQd8oTsd73O1jPGzdAekMbY9xCqq0JukH7b7eX7agcI2lCOs4UgmuuVaBR15Se7EM11
         dDkdKgzQwIUgwn77AEOFG6W+jPCdG/VXDharvomNrvEFOfI8AI4cdH0D57Ljl4Ouj2S3
         jzRHTPAAyDF5/zPOd/ik5PSrpWytHTI1P36GOjo+HMAkzh/d3ZPK8GZFh1hi0mTg/k5u
         qnaocZUttG3roJchNSt9EFHWXE9xCL4ycTqh50DDJgDv3jD1ZhpfRYd2fty5nf2R8EXS
         oSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502256; x=1781107056;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZnRxCrKTQBkdfnD3QSjhYT6bOKjFB8zBJmcLTyHQjQ=;
        b=PWEFO8jET21QxhHRtdjOmNUn0dVX6wEjFyba/kQiOcUR3wm2yVeEdWx52Att/aQYqV
         Vv98K7MV8q6elV4hx68mYJrLm11S9VgBe+5RIXziXq7gn4uROcSZkEhEGI9StyYJRJ8F
         ttOzzbBsdMiG1375QB74dYWdgAc5+xcarfTT6mld8E7ydpYpR88TKQDQCNZHUcfHRVtp
         /TD1GHvtcuXk+iHuUoZs+AyB3E+u9GPBU6lgdmFkyMoELMBCxA5ACTaIrdH0Jjv5Hfis
         5x2lFx3ns1sMbMFI8xBdnDYxU/mureSh5PnTSbB+ptNyXPu/BEUr86QQKX81VyYzV9Jy
         FCdg==
X-Forwarded-Encrypted: i=1; AFNElJ8BbBL0LAfzkbsbaOsPPsvwxEfAgS26dJ7r5Ih/EmLy8NfXVcdgmfUwWX2w3dUU/4Uil08=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEJZTSnMaxJ5LLmvjWBIrPKXJyzEabwJtV9cjOyw0omvcwa1P
	4FRmo6S2aKeiZncCyjItR/45IW/ipwjqrny89pPTwYzmdK0uwqk6Zn4T/x2+9q3hBQFzDgdTtRM
	8X3Y4BoxLnMxMSHNk9WqIcjNObVQ2Z7t1hLvhCRATzfWxGXFWpLRDGQ==
X-Gm-Gg: Acq92OH3Zt9Oucjo8j2yaNoCOohz7RowNsHhhOJhVS+0Iv+3W23HvIey13K5ilC28UK
	FnT29KcF8pm4IdFxr6iBIpyDKh96cR8nKveP+FuVw31pPR1xMcJ94BZnkB3HNny7QSaZk/12u3/
	UrRFsewf5ZNcJ8ze5PyUzSyyrdZg/HTNmEkBT32iE0LfDbsVjU+t/OzMcDSaq8ptihYAYftQf/L
	hVbx5hyYYsooxdnqvBC8oERMpS8vyM1qa5aY2cUmWIVpvJCZ7Tie4O9DA8/xHIXGkI6mu0YbnJR
	W7Y4N8SnkJ40xmnsD87Jf9vptRAn4iCHxtFwVNdtb57JEvkQlGukFVSj4qoIEHnZwszWxV7oJvT
	So2AEUConrnrE70OthZ4YhJ4JM5StbyNuOnsoZXG7adJ4ZcPrR0aNPQ==
X-Received: by 2002:a05:600c:5288:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490b5ecb911mr69751135e9.11.1780502255821;
        Wed, 03 Jun 2026 08:57:35 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490b5ecb911mr69750425e9.11.1780502255297;
        Wed, 03 Jun 2026 08:57:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm1066685e9.10.2026.06.03.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:57:34 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:57:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shivank Garg <shivankg@amd.com>, kvm@vger.kernel.org
Subject: [PATCH] KVM: guest_memfd: fix NUMA interleave index double-counting
Message-ID: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

kvm_gmem_get_policy() sets *ilx to the full page offset
(vm_pgoff + vma offset).  But get_vma_policy() adds the page
offset on top of *ilx, so the offset is counted twice.  This
causes NUMA interleaving to skip nodes: for order-0 pages the
effective index jumps by 2 for each consecutive page.

The get_policy vm_op should return only a per-file bias in *ilx
(like shmem_get_policy does with inode->i_ino), letting
get_vma_policy() add the page-offset component.

Fix by setting *ilx to inode->i_ino instead of the full page
offset.  The page offset is computed by get_vma_policy() in
mm/mempolicy.c. The full offset is still computed
in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
shmem_get_policy() follows the same pattern.

Found by Sashiko (sashiko.dev) AI code review.

Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virt/kvm/guest_memfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..0bcf6fc08e2d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
 }
 
 static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
-					     unsigned long addr, pgoff_t *pgoff)
+					     unsigned long addr, pgoff_t *ilx)
 {
 	struct inode *inode = file_inode(vma->vm_file);
+	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
 
-	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	*ilx = inode->i_ino;
 
 	/*
 	 * Return the memory policy for this index, or NULL if none is set.
@@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
 	 * can then replace NULL with the default memory policy instead of the
 	 * current task's memory policy.
 	 */
-	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
+	return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
 }
 #endif /* CONFIG_NUMA */
 
-- 
MST

