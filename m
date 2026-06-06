Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDD3815D6
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751572; cv=none; b=qV61Ybv1i0WU4YooWC32SERVFbsOugeC+2Dut+VeN3vwqUr2SY7jK+ucYOmbPVSQqIcF5HltLRFGNB6LPlEnWGpq+z0sz35EOtDkPq6VjtwyETybd6hwMq+V5W8ZDgSzi2lgczbJc3cgpcMHo+DVGfeaOveOZY+7uuc8tc98j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751572; c=relaxed/simple;
	bh=Sygk1r7Y2dknz31ACDUamM3lG3Xxo5PW7M/8hd8OPso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llPkbvhsFoeQW7V4E3cdXOX7dBJJdziArzxuBRASapZgUOnKejCsQmvdyUHTFu+m7KWky+8+tU0wXZs5WnqhK94d1PcYgBBHKcDuCgZJAcqiEM2Zy0Mh11sylDhL8BRD1TBzF5Jy3Mjgyf1ZosyAHI77fhulNrxsPM8L2wLNucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wqb0jOXz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqfF83ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wqb0jOXz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqfF83ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780751569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V80wvF8vxU2CQDBfRyi7sOYU5seBk2mV2XipnHLs6ZY=;
	b=Wqb0jOXzh/taGmWzdFCaTK07d33MM8TltKkyJ040I5UywzLR/hMwnO6DweDnMNA2ATQqtZ
	laMUSVCL+fyk6h3X89pkYNqWwXwuDkGGMZ8Iq/BEOe5RaR93L7lX8CYXJITZ10oaHeOEGj
	dhWqT607lbxv9MvnyUbZmNTmvoM9A/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-nC7DgCpVN26qo_VxfzSOIw-1; Sat, 06 Jun 2026 09:12:48 -0400
X-MC-Unique: nC7DgCpVN26qo_VxfzSOIw-1
X-Mimecast-MFC-AGG-ID: nC7DgCpVN26qo_VxfzSOIw_1780751567
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46016bedbaaso604294f8f.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780751567; x=1781356367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V80wvF8vxU2CQDBfRyi7sOYU5seBk2mV2XipnHLs6ZY=;
        b=VqfF83ky9MvYmQJNMYAVltuCV6KRHR+AkcEiYBOur2p4fZHOPYeCaXwSCU6YDKzBlp
         lPCp5jN8rVWTofI4hWXCZXF4mnn8Bu0NHeuQi+5QHDNfsqTWA+F1D78q/vjLelxBJePt
         ncI9JevSzRkhZNxRDZ5p77FUynTt64qL1toiOoT6eUs41CziRDWFTgYtz/3stZlRmfxD
         EzLPzQLOjOdiQWQMtskQwPwTizLfgqmS2u5o3y5oGX6Q/46Eos3ynEIC5QojclrRVdv8
         Pait64XWDS7pphQW3lLBL0Lf6MXK7ogbzC6yIHjGJPwwMdIhuP4RIdmKEduujKOCROCb
         wTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780751567; x=1781356367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V80wvF8vxU2CQDBfRyi7sOYU5seBk2mV2XipnHLs6ZY=;
        b=L3ReOlEwIw4qEECT9764+rqsrAEmKIY+2fmDRhDtDPKnRAnHkJ5FKRHAkmqX8/ph8v
         SswKDbCV32qSju+WKG3MkiH89BY2K9vbZ1t2h/c9SYk9NY8fshGGwVic9IjUhmZ4/Nae
         5LDfwfWmzpqbMm65zXquWkCsv9oBQ27lvwJvfGTY0DwYG9jyJZOXfI8T2x+WAFqa1iL7
         YNBUJ+U1JRCOwr8WaCzln9BVa/YedgrickhIhl0hCNiZEiYykkGhpKGbGPw0lNlAlt/R
         uoKuMQPlbnSfnC477nw1MMVQ5qAwsdt3PIdNhrK3A8qDtsgLfQX2Ver3x/XsRpTwuhvs
         NOyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jWrulSzcf1em3k9bXHUN/NHou0cptrKnfut+Hafx4MaMmmACcKp1c+PxB+mq1Ed9qkgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWRnSPwpuWr171F5pcqH/0UXwFMj7Qwzpn5Bnt56onZgssX6d
	74uhIf8w3UiMnQzZCCpjaNXbQLIDj5fiJu5nTdw0mdch/d6kEDbtqsrlpy3k3z2oYCfD4+1mEWr
	jvAqSXSEsbbD2N6RgXYIpuuXYhYgfCkb68z0+RznKlgiEPvmRbrNFsw==
X-Gm-Gg: Acq92OE4bhbrixUKy3bkeqejzIGI89hcI1p6FTOeS69Cop++drkn0UIgKwfmeOY7XmN
	KgAOSJOtCVr+gPfdYjBV3cBZDNJKMGscf4z8t18WhG/B4mZnrwGUv2w4txfo7Ij/YTnZZOZwrJA
	NZT9i+kZxc4rknIAKrpFMZPz7eNaQt5KT+5+Q/hISqQoniX6hDcQABIWvTzwzA7Gvxnmu9MwHJJ
	Di6st3XaJj/Q9kkLgOhObejgerSAEiSiZ1bwMvmTVGAS2bFE+4bc40DdZ6WGqHC6gHUppvHE5x6
	sDgRaKcnQp64AZU2hdFdId4+pa3BPzeCASFeR1Z7NZ12I6dADXdA/WnyEOAky0tRhOtNL6TUCj6
	So8t4Rkh2iYuuuS4lWGO8JHI=
X-Received: by 2002:adf:f30c:0:b0:45e:ec17:430a with SMTP id ffacd0b85a97d-460304f9ff6mr11053187f8f.11.1780751566667;
        Sat, 06 Jun 2026 06:12:46 -0700 (PDT)
X-Received: by 2002:adf:f30c:0:b0:45e:ec17:430a with SMTP id ffacd0b85a97d-460304f9ff6mr11053144f8f.11.1780751566090;
        Sat, 06 Jun 2026 06:12:46 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm32317924f8f.22.2026.06.06.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:12:45 -0700 (PDT)
Date: Sat, 6 Jun 2026 09:12:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
Message-ID: <20260606091121-mutt-send-email-mst@kernel.org>
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>
 <20260604194613-mutt-send-email-mst@kernel.org>
 <42c42370-2cf1-4b98-8d6a-8d7cd62f95f4@amd.com>
 <20260605105455-mutt-send-email-mst@kernel.org>
 <b680f308-2dfa-47a2-9ff4-05669259a09c@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b680f308-2dfa-47a2-9ff4-05669259a09c@amd.com>

On Sat, Jun 06, 2026 at 06:32:04PM +0530, Garg, Shivank wrote:
> 
> 
> On 6/5/2026 8:25 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2026 at 06:31:51PM +0530, Garg, Shivank wrote:
> >>
> >>
> >> On 6/5/2026 5:16 AM, Michael S. Tsirkin wrote:
> >>> [You don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> On Thu, Jun 04, 2026 at 12:21:15AM +0530, Garg, Shivank wrote:
> >>>>
> >>>>
> >>>> On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
> >>>>> kvm_gmem_get_policy() sets *ilx to the full page offset
> >>>>> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> >>>>> offset on top of *ilx, so the offset is counted twice.  This
> >>>>> causes NUMA interleaving to skip nodes: for order-0 pages the
> >>>>> effective index jumps by 2 for each consecutive page.
> >>>>>
> >>>>> The get_policy vm_op should return only a per-file bias in *ilx
> >>>>> (like shmem_get_policy does with inode->i_ino), letting
> >>>>> get_vma_policy() add the page-offset component.
> >>>>>
> >>>>> Fix by setting *ilx to inode->i_ino instead of the full page
> >>>>> offset.  The page offset is computed by get_vma_policy() in
> >>>>> mm/mempolicy.c. The full offset is still computed
> >>>>> in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
> >>>>> shmem_get_policy() follows the same pattern.
> >>>>>
> >>>>> Found by Sashiko (sashiko.dev) AI code review.
> >>>>>
> >>>>> Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
> >>>>> Cc: Sean Christopherson <seanjc@google.com>
> >>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>>>> Assisted-by: Claude:claude-opus-4-6
> >>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>> ---
> >>>>>  virt/kvm/guest_memfd.c | 7 ++++---
> >>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >>>>> index 69c9d6d546b2..0bcf6fc08e2d 100644
> >>>>> --- a/virt/kvm/guest_memfd.c
> >>>>> +++ b/virt/kvm/guest_memfd.c
> >>>>> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
> >>>>>  }
> >>>>>
> >>>>>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >>>>> -                                            unsigned long addr, pgoff_t *pgoff)
> >>>>> +                                            unsigned long addr, pgoff_t *ilx)
> >>>>>  {
> >>>>>         struct inode *inode = file_inode(vma->vm_file);
> >>>>> +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> >>>>>
> >>>>> -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> >>>>> +       *ilx = inode->i_ino;
> >>>>>
> >>>>>         /*
> >>>>>          * Return the memory policy for this index, or NULL if none is set.
> >>>>> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> >>>>>          * can then replace NULL with the default memory policy instead of the
> >>>>>          * current task's memory policy.
> >>>>>          */
> >>>>> -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> >>>>> +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
> >>>>>  }
> >>>>>  #endif /* CONFIG_NUMA */
> >>>>>
> >>>>> --
> >>>>> MST
> >>>>>
> >>>>
> >>>> Thanks for fixing this. LGTM!
> >>>>
> >>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
> >>>
> >>>
> >>> Can u actually test it though pls?
> >>> Because I think another patch I sent in response so Sashiko
> >>> is also needed.
> >>
> >> Hi Michael,
> >>
> >> Yes, I tested this.
> >>
> >> I used kretprobes to read *ilx on each kvm_gmem_get_policy(), while calling
> >> get_mempolicy(MPOL_F_ADDR) on consecutive offsets(0..7) of guest_memfd mapping:
> >>
> >> BEFORE:
> >> page offset:  0   1   2   3   4   5   6   7
> >> *ilx:         0   1   2   3   4   5   6   7
> >>   
> >> get_vma_policy() again add the page offset on top. so, it will increase by stride 2.
> >>
> >> AFTER Fix:
> >> page offset:  0       1       2       3      ...  7
> >> *ilx:         128376  128376  128376  128376 ...  128376
> >>
> >> It store i_no, so after get_vma_policy(), it will increase by just 1.
> >>
> >> It's hard to show any wrong allocation with the bug because this index value is not
> >> used by allocation path, which uses NO_INTERLEAVE_INDEX.
> >>
> >> Tested-by: Shivank Garg <shivankg@amd.com>
> >>
> >> Thanks,
> >> Shivank
> >>
> > 
> > 
> > So for this to be useful at all
> > we do need the patch I sent in response to sashiko, right?
> > Mind trying out that one?
> > 
> 
> I could not find the other patch from you.
> Are you talking about this response
> https://lore.kernel.org/all/20260604034539-mutt-send-email-mst@kernel.org?
> 
> If you send any separate patch to test elsewhere, please point me.

I could swear I sent it, but you are right. Inline, because untested:
-->

mm: filemap: pass interleave index through filemap_alloc_folio

filemap_alloc_folio_noprof() hardcodes NO_INTERLEAVE_INDEX when
calling folio_alloc_mpol_noprof() for NUMA policy-based allocations.
This causes MPOL_INTERLEAVE to fall back to the task's global
il_prev counter instead of using the file offset for deterministic
page placement.

The only current user passing a non-NULL policy is
__filemap_get_folio_mpol(), called by KVM guest_memfd.  The page
index is already available at that call site but was never threaded
down to the allocator.

Add a pgoff_t ilx parameter to filemap_alloc_folio_noprof() and
pass it through to folio_alloc_mpol_noprof().  Update
__filemap_get_folio_mpol() to forward its index argument, and all
other callers (which pass NULL policy and never hit the mpol path)
to pass 0.

Fixes: 7f3779a3ac3e ("mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a02b62e0a8f3..efdec0ac1482 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -452,7 +452,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		masked_constraint_gfp = mapping_gfp_constraint(mapping, constraint_gfp);
 		masked_constraint_gfp |= __GFP_NOWARN;
 
-		folio = filemap_alloc_folio(masked_constraint_gfp, 0, NULL);
+		folio = filemap_alloc_folio(masked_constraint_gfp, 0, NULL, 0);
 		if (!folio)
 			break;
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 0062b3a55781..148fa0bcc974 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -731,7 +731,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	}
 
 	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
-				    0, NULL);
+				    0, NULL, 0);
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 27ab7bd844ec..f4416b57f480 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -563,7 +563,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 			 * Allocate a managed folio for cached I/O, or it may be
 			 * then filled with a file-backed folio for in-place I/O
 			 */
-			newfolio = filemap_alloc_folio(gfp, 0, NULL);
+			newfolio = filemap_alloc_folio(gfp, 0, NULL, 0);
 			if (!newfolio)
 				continue;
 			newfolio->private = Z_EROFS_PREALLOCATED_FOLIO;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 881e76158b96..7494a94338e4 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1954,7 +1954,7 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
+	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL, 0);
 	if (!cfolio)
 		return;
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..e2aea0800815 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -652,10 +652,10 @@ static inline void *detach_page_private(struct page *page)
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *policy);
+		struct mempolicy *policy, pgoff_t ilx);
 #else
 static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *policy)
+		struct mempolicy *policy, pgoff_t ilx)
 {
 	return folio_alloc_noprof(gfp, order);
 }
@@ -666,7 +666,7 @@ static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int o
 
 static inline struct page *__page_cache_alloc(gfp_t gfp)
 {
-	return &filemap_alloc_folio(gfp, 0, NULL)->page;
+	return &filemap_alloc_folio(gfp, 0, NULL, 0)->page;
 }
 
 static inline gfp_t readahead_gfp_mask(struct address_space *x)
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..2fccd9afa4d4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -992,14 +992,14 @@ EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *policy)
+		struct mempolicy *policy, pgoff_t ilx)
 {
 	int n;
 	struct folio *folio;
 
 	if (policy)
 		return folio_alloc_mpol_noprof(gfp, order, policy,
-				NO_INTERLEAVE_INDEX, numa_node_id());
+				ilx, numa_node_id());
 
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
@@ -2009,7 +2009,7 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, policy);
+			folio = filemap_alloc_folio(alloc_gfp, order, policy, index);
 			if (!folio)
 				continue;
 
@@ -2609,7 +2609,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 		return -EAGAIN;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL, 0);
 	if (!folio)
 		return -ENOMEM;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
@@ -4067,7 +4067,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, mapping_min_folio_order(mapping), NULL);
+		folio = filemap_alloc_folio(gfp, mapping_min_folio_order(mapping), NULL, 0);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		index = mapping_align_index(mapping, index);
diff --git a/mm/readahead.c b/mm/readahead.c
index 7b05082c89ea..c435aee43e07 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -186,7 +186,7 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 {
 	struct folio *folio;
 
-	folio = filemap_alloc_folio(gfp_mask, order, NULL);
+	folio = filemap_alloc_folio(gfp_mask, order, NULL, 0);
 	if (folio && ractl->dropbehind)
 		__folio_set_dropbehind(folio);
 

