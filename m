Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C633DA5A9;
	Fri,  3 Jul 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085790; cv=none; b=R6k4JA+70T7zYNiVWpwVHlAcVQMVSK97RSDl8L76+mo+1zGkTy28bSCX9H7UiYEOKn7nC86j6FV1b1xuVO49JddRRJPnVpIuvWn38Ejv9R2Et6yPw5urhlroPko0vGeHV9iukrQkdnvENzk0nlYcu/Ix6oFQ5+uiBMuEZu1mF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085790; c=relaxed/simple;
	bh=D5blKixSKUjIZNvba/4Oy8tOCO45xeMNpOCPKdg62lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRPtXPF3GsBQ8+aR4sVbuijjj/iHnQESSFKAd0KKRFcmSjdKVLgTAGN6zIM8tmGkSvZOLieDz0FYAmKTZ/ibhxh0mtTQulEk72jw7cMuupEjrcA2YbE0X/CQcS+91MfV96yFbXbamUoiZVY83vBz4gFWMOYVfuJC9Ngo7xm0w9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=MHG8Ay+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rWqDEXuq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="MHG8Ay+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rWqDEXuq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 65F3D1D0008F;
	Fri,  3 Jul 2026 09:36:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 09:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783085787; x=
	1783172187; bh=KHWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=M
	HG8Ay+Qks+uAN4YWnGVQypkPkpba8hY4zn2qBGcqoWwNvDjV9bGdPax9Gu1GZtAA
	AR7zJV/9CQViysTWqeuSTOZFcBPiIu+OASmZ+/2d+5kiPv5QfKTZHU3OplPWDe8P
	CzGMJoV0fm8OtTtSTfpE7z7eb1GmxGw0m0FZNeWpc2APg2HhDMj3wVNNQ38DlHGp
	T+/2swdoDa9tMV3JPnryOm1qv3w1sC20YkbvlwsAkmlsjbnmY/9ong1KBsx4p4x5
	9RKIv/YRl7JYzDoJ/XzI+f7ON2ENVUDz9tzpezk5UdUR6F7LuFC5P0Trdj6hEXZH
	XsriPM/7datB1Hwy6Vx5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783085787; x=1783172187; bh=K
	HWPH1BueoLrKJ2AnlWZbvIzikefHXu8fHT5GFP5/Qw=; b=rWqDEXuq0XjOhUDst
	CY6oQvgrvmNxfCZbrCi0taFetQWguJMCzTS8ogrvoeQ8rsus2rhlpwP70ixbp4vO
	zFhXrbh04F5LQaCgIIc22/DmkDFF4LkECFHnxHcZMEMG7FXOKQ1Se2g6+zeytijh
	iBOdsOwxoWNCWFbYQwSm+CAFJE+omq0llTm/dIDJe4+BXL8GYT8a1im8QlQo6+Qj
	x39WHW0+0I9gEF/VDVYkMwZ3h8gyoZs9V9ujSiEJm0eakhB5uF37VuCJxo98ADnW
	7f7hTHjQVrhpIaOsd5/m0ZJ3dnnZ/qll0rNXlNiGNOasPjxS4bKh8KJMauUX3dcI
	Qr2eQ==
X-ME-Sender: <xms:27pHan7JRlV1gNKzWbpDVGW0DEWCer4aaBUpX5j0ZVKBS0qzLyNCug>
    <xme:27pHag1Gfbrtv78kK03PcbA9qVgN-3VRl6uej8WZOROiHmoMsh3GGUKWSJAZeof-K
    e-277HAwBMHqmpiJCcEPRD_EBOr8WDRu8dh81Lp_eLyEC40cL9_bQ>
X-ME-Received: <xmr:27pHam_B_xZgG53ZfehgXjuAoJ5rUU_UVB3kOZZUHoCJDWhzYPgmbfmPzCHPtQ>
X-ME-Proxy-Cause: dmFkZTFObHtmDrEiOrTAooOaqm6z7haasp/DWQQxlKuCoy/ufJ3arR423SUx8KwajdRAx/
    x0jPezqhC2sfr+GT8jp0q5YshlDTqzRRtEcPa6we+rqnGsfCS52ASTIDLyRO3E+8Tw4Gkd
    hUYHAtthSIAZ0n/QBAQDdRZKW6Ycha11d7X1KClqXgbrby1IrGiAakMxQ1tKTVdk1Z1U2Y
    qaozPC9bPprAHNQSJYBq6ybm39ut+Xfo+PDjx6Fm6+BBWKCrbmDUn/uVEkD58GhSYrCfJV
    yqyM77j1SMH6pl73i1/aHZ7qpC77EiRuuqTw1xYDw27obDrQCQCJYR+4WK7HlJzcEtYQaT
    dJf4pk1iinRLlhGNiNT7+ECw+6k+oWLF2eyThkvJjv/kSscSbcEdvaj2JzVK4jG3XTDhsY
    3SD4yjvmunE1bGbQ87xxX8xVabpo53MEIXpayAkRhtsbZbL3sKjAjDo2HqLPxHNJpbtuzy
    poj1xl53R7g4P7GncFaiw1//qATVkwmBOG0ZGXwFdS7Cf6ikCcff3zPPzEYKMLpzHElVJa
    TArsXXV8lt7PPh9mBi1RPWLTp7m7bW44mi1n9YkBROts5z5jm1ovdenZZz4oKkqtfxIwRF
    1D4l6/7YaC4xvDkw9VMs9xJRyyC6sSmmrNNLLd+C+TAwjWuk3DdF4jIAzslw
X-ME-Proxy: <xmx:27pHahsn35gqfgMI5pNCNOWMTFYzs7vz_xHX3TgAH_ud4BXrms_5jw>
    <xmx:27pHaio70tkXiwPUSGRH7cV6R5jTQGy64ogoCe_cvb4Icby4CsY52w>
    <xmx:27pHasH-q5Vu0VR-VYRFgVDmIt_iK-M_ZzdGd3l_uVUmwanKRUKWoQ>
    <xmx:27pHal4E-shUiMQcSjHHdPE6Y8XG7WJpSAvnRm_fqlBOl3vjzCqZmQ>
    <xmx:27pHaq6xDX_V7ZfTw9LCztxJ0j9hn58Fs5Ux97DkfaEtCa9u7ysotvuu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 09:36:26 -0400 (EDT)
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
Subject: [PATCH v8 04/15] userfaultfd: test uffd VMA flags through the vma_flags_t API
Date: Fri,  3 Jul 2026 14:36:03 +0100
Message-ID: <20260703133615.1039465-5-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703133615.1039465-1-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
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

