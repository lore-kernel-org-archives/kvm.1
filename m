Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823A2F1FDE;
	Fri,  3 Jul 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097000; cv=none; b=Aofgo8iZqVM5XiK6FQlU/7LpQSzCZo/Krf/rVeopVx6M0azFWzBWU+v9BaZgceUOlikcULZB6avdegQhv20ZC7A0L679wLfG10r+ev3VThvJgSnLPhsUm5YQ6Z9ynf63XZK/V8qSsGZntkfekPuJ/DIz4caa6b0MR8OJXFqDZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097000; c=relaxed/simple;
	bh=WBab9+njAD5aiCXcAouVi7TeyY4y7/wl56ZyGFZBq1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4DkY8yx7qQeXHsYPJCBPjz0mOrGyVrqcG24V+qEp8q7SOQy4cHrL11EnHbDWFnLKSfD3v4NSHg+E9s3ELiP+9X1s1jmLYxnNgOO13BRl3ZVm2HkImOzznpIbZrH+ntSjDXVX2VvW7SUAe8O5VLhRKcM7vwYVVGisHn1NwZ8sC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQgODdQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQgODdQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7901F00AC4;
	Fri,  3 Jul 2026 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096999;
	bh=wmiike0RMf4GUZzG60cV6tKCpPnHn3sgz+92qG8ZSFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oQgODdQcQOZJ6UkIoTHpSPAR+xm0LbTzqhxtul4thXzJ1L4k1xRCB5Jfy9i79GdKy
	 AqZzrmO9bPCWxh1+UKQeckEA8xfE1ALRrFgdtPWO8vjwNCunLuPHT3DQY412txfRXM
	 IcPirEckZNvCksYf7oe2J9e7Gb5Koo01YZfFnIEDWVb2ZH6ACzGBQOnmSqTdpxJG/p
	 jE9g1J1K8wCvGiZ6t6teTZjFTfq4KjVtxn3YEXBVakSfpQy5fogPPdyjHcKdGbkX9Y
	 rkoOLSm0x9pfqRwQbmndrfkrHk4CW6WfefyPzMPDnrR/5D2l0WpKn8AHdQbcbcwD0f
	 t+0ZKGm4Ihgmw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id A9FACF4006C;
	Fri,  3 Jul 2026 12:43:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 12:43:17 -0400
X-ME-Sender: <xms:peZHagMAZzcYl7CmGJIRQXcADJfppBSUDgNGnKdXW7-27IhwjKYNSA>
    <xme:peZHav94GBW2fS7CSPjP7dXckGLtKDruvWFJgoRhS21FxCl5eSniepVxlnmADCm2k
    ot3CcE2nTZxy-aoG3P9nlnbLnnddED08kNQfUr4Ghc-QSpAM3BUGVc>
X-ME-Received: <xmr:peZHag-yEVwy1cFKNkUnw1mA7mzH_ik4hwH_tdr4YTNR-JuUxfNtBQ6LD3-XvA>
X-ME-Proxy-Cause: dmFkZTEhXLrG7RRgWewl6PxPi2xh+8RsvhIU1msTLaJArxEAHB6uY996MYxuxeHg0YK91y
    R0wyJcP7nTPMFDWO2Q8TpgpNyNZ42owgYwLWubaXjtExEZhofOlvlDvWLcia4Prx0zY45R
    Fw38UnVt/frpIxZIsiAA6MUvzEARpnKuokCRNpn3gJzH0DP6jNc6FvmZdyr5G4Z2yyeA3e
    A0pTNJ/xcW6DuOeNSIJ8JAKYtZNQGLKSOSu8G1RdEMTK0KDrunlklY8omtJiDqkZaS+9Im
    xxzBCx16mviGsn1Gf931m+HMap5B6fYLxqAeP9gaObnEeRSCHAQmpkENZV8SepZp8HRAVS
    D0mw8Lk+gVKD1CORE7bPyI2GJGmG4myt9165rJWgPoq8dT6ush6hA9t45mkxQ+OTjL+AIS
    p+s9Ya+POW2qVpOGRTM3mU/duDR8ZK8HmdXoz87Dnj93jS1kPgVfUmo+5sGgF1rAvYNw17
    jjw7+Tv7Y9MATgSPzv+Oq5FeWwGbeqjXX/0q+uGinBX/WSOsXB0IeMiSnOhwNfCGQJLE0k
    Bld2Zc9VVIRr9ZuB3HegwP27DOKH9IzcWyGPzpgQVWOiR308qAcGNSuLpMCF4ffgkhfCf7
    XsttxQzyy66CukTnb565g5n2L6u6r1LVYxt905mN7so2p6LQ4vyLwep8Ryiw
X-ME-Proxy: <xmx:peZHavqZomUiomjVpT4A2daHUPpDZbqZLOGRjBjZpiGyVhDSfJNukg>
    <xmx:peZHarJH0dyQxR4lrQGZ9IqAUJctIzzPAFEoPd5G-ISbH1gMNpzZSA>
    <xmx:peZHak0BtjTmrFjtRwV9bkHngywyLii-Ma5udRkPh5Dbtkh4e9qQ0g>
    <xmx:peZHak7O_jSu-q03beVgwlBiHYK8VGPqx_4AvW4Ujhd0wQ8X3DYjUw>
    <xmx:peZHaiMlQJmsOlLT50fzJ4z4SqiiflrE1QXy9udNZWRfsTPEdZJWvGeB>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 12:43:17 -0400 (EDT)
Date: Fri, 3 Jul 2026 17:43:15 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Addressing Sashiko AI review
Message-ID: <akfmUXjqaBQnxqYX@thinkstation>
References: <20260703133615.1039465-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703133615.1039465-1-kirill@shutemov.name>

I looked through Sashiko review and queued changes for v9 (see incremental
diff below). The v9 branch is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/v9

- 05/15: uffd_disable_fault_around() did not cover RWP, so one
  missing-page fault on shmem pre-installed up to 15 cached neighbours
  as accessible ptes and PAGEMAP_SCAN reported them as
  PAGE_IS_ACCESSED. Fault-around is now disabled for RWP.

- 06/15: change_huge_pud() rejects MM_CP_UFFD_RWP_ALL next to the
  existing MM_CP_UFFD_WP_ALL check. Defensive only.

- 09/15: the PROT_NONE accessibility check lived in
  vma_can_userfault(), which unregister also calls, so RWP register ->
  mprotect(PROT_NONE) -> UFFDIO_UNREGISTER failed with EINVAL. The
  check is now register-time only.

- 13/15: userfaultfd_register() read ctx->features with a plain load,
  racing the WRITE_ONCE() in userfaultfd_set_mode(). Benign (the
  tested bit is not toggleable), now uses userfaultfd_features().

- 15/15: the documentation wrongly claimed UFFDIO_API returns the
  supported feature bitmask on EINVAL; the kernel returns the
  structure zeroed. Corrected.

The finding against 03/15 is a pre-existing bug that the rename only
made visible: copy_hugetlb_page_range() clears the uffd-wp bit of
hwpoison/migration entries with the present-pte accessor, corrupting
the swap offset. Fix posted separately:

  https://lore.kernel.org/all/20260703161833.57416-1-kirill@shutemov.name/

I believe the remaining findings are either pre-existing or false
positives. Ping me if you think something is worth discussing.

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 69836e39aa0b..783d969f0e28 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -348,9 +348,9 @@ without ``CONFIG_USERFAULTFD_RWP``, and architectures whose ptes cannot
 carry the uffd bit at runtime (e.g. riscv without the ``SVRSW60T59B``
 extension). Requesting an unsupported feature in
 ``uffdio_api.features`` makes ``UFFDIO_API`` fail with ``EINVAL`` and
-leaves the userfaultfd context uninitialized; the bitmask returned in
-``uffdio_api.features`` then advertises the features the kernel does
-support. The recommended probe sequence is therefore to open a
+leaves the userfaultfd context uninitialized; the structure is returned
+zeroed, so the error path cannot be used to discover what the kernel
+supports. The recommended probe sequence is therefore to open a
 throwaway userfaultfd, call ``UFFDIO_API`` once with ``features = 0``,
 inspect the returned bitmask, close that fd, then open the real one
 and call ``UFFDIO_API`` again with only the supported features set.
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ca718e8590c5..bfbd6a59909f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -171,7 +171,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 /*
  * Never enable huge pmd sharing on some uffd registered vmas:
  *
- * - VM_UFFD_WP VMAs, because write protect information is per pgtable entry.
+ * - VM_UFFD_WP and VM_UFFD_RWP VMAs, because the write protect / access
+ *   tracking information is per pgtable entry.
  *
  * - VM_UFFD_MINOR VMAs, because otherwise we would never get minor faults for
  *   VMAs which share huge pmds. (If you have two mappings to the same
@@ -182,21 +183,25 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma,
-		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR,
-					VMA_UFFD_RWP));
+		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
+					VMA_UFFD_MINOR));
 }
 
 /*
- * Don't do fault around for either WP or MINOR registered uffd range.  For
+ * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
  * MINOR registered range, fault around will be a total disaster and ptes can
  * be installed without notifications; for WP it should mostly be fine as long
  * as the fault around checks for pte_none() before the installation, however
- * to be super safe we just forbid it.
+ * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
+ * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
+ * and pollute the tracked working set, so each page must be populated by its
+ * own fault.
  */
 static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 {
 	return vma_test_any_mask(vma,
-		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
+		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
+					VMA_UFFD_MINOR));
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c67261f04731..4150f1bdea0c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2766,10 +2766,10 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		return 1;
 
 	/*
-	 * Huge entries on userfault-wp only works with anonymous, while we
-	 * don't have anonymous PUDs yet.
+	 * Huge entries on userfault-wp or userfault-rwp only work with
+	 * anonymous, while we don't have anonymous PUDs yet.
 	 */
-	if (WARN_ON_ONCE(cp_flags & MM_CP_UFFD_WP_ALL))
+	if (WARN_ON_ONCE(cp_flags & (MM_CP_UFFD_WP_ALL | MM_CP_UFFD_RWP_ALL)))
 		return 1;
 
 	ptl = __pud_trans_huge_lock(pudp, vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a7659b0a1147..c96cfe0871dd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2221,15 +2221,6 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	    !vma_is_anonymous(vma))
 		return false;
 
-	/*
-	 * RWP uses protnone as an access-tracking marker. PROT_NONE VMAs
-	 * have vm_page_prot == PAGE_NONE, so RWP resolution can't make a
-	 * page accessible -- the next access would fault again. Reject up
-	 * front instead of letting FOLL_FORCE loop on protnone+uffd PTEs.
-	 */
-	if ((vm_flags & VM_UFFD_RWP) && !vma_is_accessible(vma))
-		return false;
-
 	return ops->can_userfault(vma, vm_flags);
 }
 
@@ -3758,7 +3749,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_RWP) {
 		if (!pgtable_supports_uffd() || VM_UFFD_RWP == VM_NONE)
 			goto out;
-		if (!(ctx->features & UFFD_FEATURE_RWP))
+		if (!(userfaultfd_features(ctx) & UFFD_FEATURE_RWP))
 			goto out;
 		vm_flags |= VM_UFFD_RWP;
 	}
@@ -3825,6 +3816,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
 
+		/*
+		 * RWP uses protnone as an access-tracking marker. PROT_NONE
+		 * VMAs have vm_page_prot == PAGE_NONE, so RWP resolution
+		 * cannot make a page accessible again. Reject at register
+		 * time only: a VMA that later becomes inaccessible via
+		 * mprotect() must still be unregisterable, so this is not
+		 * part of vma_can_userfault().
+		 */
+		if ((vm_flags & VM_UFFD_RWP) && !vma_is_accessible(cur))
+			goto out_unlock;
+
 		/*
 		 * UFFDIO_COPY will fill file holes even without
 		 * PROT_WRITE. This check enforces that if this is a
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
