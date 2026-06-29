Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDC3FF1D8;
	Mon, 29 Jun 2026 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734883; cv=none; b=iSMgy14MOHNIj2KboydoUcKa/ylCUUQ18nQ8oXng3lgv5Arp2j0nNz+b64t0JJPfbFH5t3sJfMTZQZ9wipyp06vz7CKEV/QmVlvBEu3CuMvk2Q0TCvCMD2f7jBGliZzSnbSnnCbu1KAek3MzDMORVh/z0m+uc/UkLvDkWN0S1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734883; c=relaxed/simple;
	bh=D5blKixSKUjIZNvba/4Oy8tOCO45xeMNpOCPKdg62lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlzds0te/p+tz81+Jki14mF5LS2GRxstHGQBgn6yS851O2OhUamhJh2q6vA1x3pB7AuoL7eV98CZfIPWD2r1mllYNMDM26kco3l9AFn7+pp/Hcku05inQMFvWntopN4k9DyaAu+E8Jwo1KC33DVRdmSxzsjsONctE1nj0cPwVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=XEudZq5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NomMl8P8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="XEudZq5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NomMl8P8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DF0AFEC0143;
	Mon, 29 Jun 2026 08:07:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 08:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782734879; x=
	1782821279; bh=KHWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=X
	EudZq5APAcY9x0i5JcynwLKfmVnZTidKKxEBlHIIlkxHfc179qH46b49gjwuhwwz
	0C9mGWcwKw43YioI9o916ub2OqjJowMgNb3/qfwkm79mAMpo4mp1I1DPMTTeqD4U
	q8UOudfsQ0xIlAdE/w9y0drOyC9CQ7OjKmVaXGPyIFj91i+zOFVNRe/BM+HkBlw8
	gF0KLG7rEmFy+To5AYFcdLQq1FahameygMODqviUUgIztGRZnTwZqiqOEi3Gstvw
	KT1OlSgCsiXX0kOQ4G/FegAdqRSsDCim3860eQZhKE6CnR1YxhIJHtuiILQSdvNe
	YtgX4KGbHMovGdA9xJ0aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782734879; x=1782821279; bh=K
	HWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=NomMl8P88b+n98yd2
	qDtv7bnmi4iYNquDZsQ8TiUCsL5zNgowlGj/eEGg+RdyiJqaSXgPN39oiimNJyN5
	h2JTm/KRQ2zWOgUjEtXqci6LlU/IOHSWgwu/T4Igy33mPsjhmy9ETQ5hiz9Gr0wN
	4t6flaq4TyHsD9KMWMRRDHigLD5LZYDN1icPDIRi0EsC6dNk2GblsVr8n8iyS6HB
	l0O0xapHrPoqecQa5cl7nhuLKRqlruy0cn4SfUm7R0gpDfte6Tr5PoXMg8gbBTXc
	KSfHrNGo2vQt1v7qQXri0izrjUtGSiktzNFgzSYS4PBQrWY5P27DnaYQjtYnrUtM
	TvpMA==
X-ME-Sender: <xms:H2BCasc1oX0PSNUjnjrqTLZ1yIoS-S_IkBOJFBe92PYjf8fF258Fbg>
    <xme:H2BCaiL3kkfdKymIuwVx6xBmHvhvB-bYptIPeUl0hHIhxYwr-EfjVTf6JFJZMgteW
    atCyrTVkVZYT75DiLdIxwniWgZAe_XkpHtrrD0ucSdBuZT1LBXNCio>
X-ME-Received: <xmr:H2BCamAFsRspgtl7er3uYKoqgemU2oUXsFf887WsGb74Ih1Cc4YswfAFvj0Xkw>
X-ME-Proxy-Cause: dmFkZTFY6shGePvmxOMh2n7JXpRvMYayhSPkReA/qp2Kk9FFh7qIwqznFdabTWQQmbT6np
    orb7nZimraCt1e9FjxE+D963WQ5XDZfLTwLobafoyB3i66gOkO3z85tAcKnmI3RB25+PVB
    EZ98eAuca1GkEm7XR3L2jnIB5DGE7Gq/dUpvQ2A9oIHx8hwh4f84uT4y/OhQorrh2fKXDR
    UYo9Jps0lppZOy2xiKorTonIMZqLK9GUCnCQcdTCD/z+aL3OihCctiT9iWAjf4SCGuOWH6
    0ORm+HxXgzRDvylsCh2WOkVei6ivCiAy/pOXBTW6wB8gDyVJ0wFaPNiIhLc7QTSUTVd0VI
    ej824Sgbwq2ofA/Ioj1fDQ7At6PANE5RJuIvat9cKb5nmKkgUcjM9JaWNnTZdbKavz4Mfc
    4Kx308YeGgSYgc/E0WAutMluVqrSUUQi+GIT8Cj5Jie2BrL4wnI6MO7mtXZGyYdBsdFxuw
    h7i5keIGR15n8ZnAwW3iQp/typHz9T690ycFYUeM6mzb+Z8cSnYDpIReqXcQ9ZnB2TWZP9
    7msMuc16hHHN8SKxxpjuyv8dGVe500dXtf1XzR7h/iCNWsgI9cqYwu2I5DIALaUsUBBg7D
    bwSThjgASdsBBy/qDbNBBnzdJkfoEaViWN5hpdJ1wHXRaUGUgPw3gZjxnEwg
X-ME-Proxy: <xmx:H2BCariaj3u7xWw_Rzf7fE_zXNQDCzTPE_IJBOfS65NgfyZ_J8t7ug>
    <xmx:H2BCagODjqEbvTv5kJd7u81JVLczPA8bXVV7e4n5znV5WsFIL4Zhbg>
    <xmx:H2BCaiaMbzP6Axw1X8OEvzfuJ0OIV7qOtwnx7aRLxQibBIoC3dXRLQ>
    <xmx:H2BCal_2YZUFrmAYIy84iWkdZoRrd79uEOJGyhxWFCXCl_nwHwjTtw>
    <xmx:H2BCaq_e6e9vHYyJSQaamtRDFheOWr3DCzj834rXqVILNqcBjljtUWKN>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 08:07:59 -0400 (EDT)
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
Subject: [PATCH v7 04/15] userfaultfd: test uffd VMA flags through the vma_flags_t API
Date: Mon, 29 Jun 2026 13:07:35 +0100
Message-ID: <20260629120749.566063-5-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629120749.566063-1-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
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

