Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E4388893;
	Fri, 29 May 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075682; cv=none; b=hnaxfbwvDxb0PuRY65lABTAtfxSWTUNFcEqDLxkIwt7yEozXHl+aaX967Re050gMwg03rdtfxAx1q/AN2A9unZLDboC9GhaZ0Flg8Q8UKd2aNIOMkmtqhdAL7+zuhTX4EikNAI9/G1jVC8VkKmXaLA5VUm9PMEhcxOnfHA2EyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075682; c=relaxed/simple;
	bh=pweU6E6V5UxZMVhZ2AP8UStKS+cHPSOB9FOU44WKrf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZXhpRXMugHDSo+kByWZI4AjCM86N20lbC54roo99mmhO8trdALu3tdBqBC5RBZ3gSp8n6zCMvupqWGfHYx/CiovlZ0SGlj51QLmI1fQDsRHod9ZRKUfn5aUJbO6kFUyrZsESsGlhbHf4lNFqNb5FKqs77u3Bt4PWksK7LrHgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nec8atXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nec8atXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4AC1F0089B;
	Fri, 29 May 2026 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075673;
	bh=SQ1nDTsRLGDl2EAMFRNs5j0bNOh8Bj7CANx4ag7x/sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nec8atXGkJujJy7W2x4RHeh46PyG43lwX17Al4yfDKD2PJi9hzW+FGqt0/jfwtaxv
	 8Iz8IXxQt2kesi3AVnRMvmM7gQtKPiuw/755WryrO0nCG5ESZ42N4YTj0TTgANSpH5
	 Dn8STpqqEFEj93dlVLHoCOacVswN4P8LSw6nwdZOvjM768/1s3adgceTMnkqn0f8v2
	 mkX0T0NjgYuWFQiHh1R7QLORYC/4HxgqrNOhcZuR23mgXBXK5aIB9Wqj7A2fHTiMuX
	 MhxhXkrLCzfBEkjGKrj1NuGymRZkdd4wiErdmHAjdQfWxf7y8Z9Ya72AnUnfFRmPk0
	 iLz9Sda5XClWg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 13B7DF40070;
	Fri, 29 May 2026 13:27:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 13:27:52 -0400
X-ME-Sender: <xms:mMwZataQBwkAuGSzsJdlgqbFu4hB7fOQSLqO9IHHZZqKkX8BpoZfVA>
    <xme:mMwZaoU2y4sOdXm4hc57giUEm2IYFv2CZ9Lvi6vSutUbz4qplttYbsjeTt8VusIxH
    k7PAJ5o7mPv-XOQmBjJgCHI8zxS_LSLBKoOw5Cppss1H4TDTyEl3s0>
X-ME-Received: <xmr:mMwZaof02vmZPAh9NSuJoRC5idaSuS5pyUWuqWG4HoPkbGU7N6GVluko3zZefw>
X-ME-Proxy-Cause: dmFkZTEUyOwNbDmHa1KNnZhhp0sknwyB5iYBikO499ls5PXcb2OBGZ+LtCI75nkUeooCiF
    UzrXo04XJ8+Ua/uZDk13qfrbBwlZ5p9xJmobKJQlMbnj7l7Wa1HVN1RPiFo+pMeAxt22yi
    61vTsKtOSGFbPiuQJwzf8kDMk7i9oYKVPojpqHuO0mt23+5gFs2X9nq4e5eFTuainOibKw
    /PjyCpBsVGYk6ilHJDmI324wGNqP1tQqUfnSbHSEKXH/CNKWAMLzoIWnryvyvz0mzyGoSH
    2C2M5+XUQ3GxwG6CgDLP16c5lhscyjq12y5muGouPR8MZ3kTeYPrBARrvcwg6KATek/ZWq
    +dP0D1rsZmQ1VFiNA+xyuNFvJNCjaMNMPCLtlNpIj6q9b06VrZoOfLYh6a5mPwNib0hkRL
    c+ZWzy8ciJA0v6d/VtEpjxVHWwAipQCSTrc9sxdVPlecEW53mOgLz+tV1zJ7JLvKwfawMO
    qVXArPzUPOoTGowwQnDvJrO7egZwJGKJkwMQDaQbsj+yUcxyiVKnn/amGJ9qd5HJ9Sp4sO
    7gte4/4huMO65wclA1C+VepBODWBRI0A5r+98PASSCy+d7rtf8X9OJnFiQibhGontdXFK3
    qWaGg4A2UenLkAl7DzOZU688UcpGeTPHuTKZu/nwkn6RY9O7b2wuki171pbQ
X-ME-Proxy: <xmx:mMwZalN4OwoS9J1r7c6qSZ2cRpNcVkaIEM_T5vYZyWev-4WYa2I77g>
    <xmx:mMwZagIguX5ExgrFreFQuALWRzdHd8OdnqhslN_tEma2KIBe4wHRgQ>
    <xmx:mMwZarl-tYRoGhZPOhI6mAG3iKJZNU0I2B5ZHliu1Z4BUWkICTB23A>
    <xmx:mMwZavZQniFpJBej5AJGO1IDL2mZtuovV2zk9fCECmydqdLvle9Odw>
    <xmx:mMwZaqirj9zWG3hh1xGvkPz3mckosWYd0VlCrqCCYal2WJeHbzvM3_qP>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:27:51 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
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
Subject: [PATCH v6 04/15] userfaultfd: test uffd VMA flags through the vma_flags_t API
Date: Fri, 29 May 2026 18:26:33 +0100
Message-ID: <20260529172716.357179-5-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172716.357179-1-kas@kernel.org>
References: <20260529172716.357179-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

