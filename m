Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897745DF60
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516233; cv=none; b=eR3tX3EViep+ocZ5l3e4iMyq2RVQrs5Uxw3JN3pZslvOW2J85qtCOfTJwY+7Ah8CWajvDz/Wo/LiBm9ImSevmxvFP8yOCbZn0KbKbkAl8jCoc1VUdn+A4ztn2Rwf6sFttzyekQDGmF9f6yPwRymHdWGWgjqA7uJ7M5ohfMv0gl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516233; c=relaxed/simple;
	bh=04S1gzKFN2BK4RzlrOHQobVEGSqWLyPeu4/lGaAgilE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnvguSbTtmWtZyLwJ+KWz4DEtjFyUSSfUhXOr3DSituVe/MATgzoZu7leuyTxcAq7aP+xVktMM/KLIZRzCIsaR6CjfhiBDNcfNqWDp44+FEbO15DTXOSyrB4kYdlgqDWs11y/+TvUcFHiKRh7b5ZVIjTBxJSP1o5eiega7/D7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NA98n57C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+FaFEU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA98n57C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+FaFEU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBHFLJxPt4apj6AE6jTX9tz6JkNc6fSnqMXU7ny6bKM=;
	b=NA98n57Cu7jCoy/+HuhhYrPw4NqudDZ/d8/JEL5jxqOM/3aO34TYG3kfngBNN00HVwwIuF
	IdUIfazSWeBZvELzzut0omAar9zCV0XBdFtnBFVzzJmkZIo/iT6X/Qtg3M/cpu8gLPq213
	YAQC+twk2G/JXxWnsZNTMXRN1Ah3Tpg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-nBhkXf5dMxGkVh4lgXYfvg-1; Fri, 31 Jul 2026 12:43:48 -0400
X-MC-Unique: nBhkXf5dMxGkVh4lgXYfvg-1
X-Mimecast-MFC-AGG-ID: nBhkXf5dMxGkVh4lgXYfvg_1785516227
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698aa8bd688so1362461a12.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516227; x=1786121027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VBHFLJxPt4apj6AE6jTX9tz6JkNc6fSnqMXU7ny6bKM=;
        b=Z+FaFEU93OqDL/AhvReT9Neyl2KZ7ZMDSanAz5yDXvljd+We7QmdxdUu/wei6WmNgT
         wnopHr9jk6G17VktXHQp6/eYwhEv8ogdV4GCczzYuZRUaryhbgGnGjDVV40IVkwoT7Oj
         sMS0wKS1QHLCY7mY3XIP2I3zy2QZ2OuvFBZHGwLnwqDa6qPdnt2uMoD2qQy0Q6JocMXJ
         sfDZmwXX59PbYiMmDWdD6+Tn5EwXKf75YYRNtUkvvftGdumXC5PrAr1v7bVDKYIi3A4R
         qHA2lhNNtymh3QnrVxhcCHHFpwYl4yY6EbRRWJn3ow6SBGFjntSYtOf/+/LoD6IPczZQ
         bVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516227; x=1786121027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VBHFLJxPt4apj6AE6jTX9tz6JkNc6fSnqMXU7ny6bKM=;
        b=lROUi6nXUIMXp6Mf9G68uE5ZoZ2d/h7gP7zGlI1sKIFvsLvsQrTkgrFO+j7n3iKUca
         EU08E3Vv3wCDgl+ZDAkbzZOa50XQBrdeoMvuVmmukf5vduqAQ2BFOVDDBV2/E5+yJ/a8
         h5HbQ94kSb0OFsvN/DjW0dG7zxf1favxh3qnUVVDCPyz1wHSXN+TU6YVNXFB6QSFfUiT
         5s8FGYmQF+SLCxUMBq5n4caiWn04rplDuR1/AMNljlm5T1cBvUqMdrYXHleyG+yyU9fd
         jzzs8StZqFAph+NainfecXHGv5u/JlJf1zqnqxpciLnK3CvhQnWUMjtJKsv6/ZFiFor3
         91kg==
X-Forwarded-Encrypted: i=1; AHgh+RosR/+cVlPWteSpCkkCcrdIOJ/bqlbdMc0qdljkHbhqXFCWP1IMdphf1SlJMbskYt0yyaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw365AYe8Hb+OYdYVloC7AlbknXps2kwyMSNAdDxA/27RqVEte4
	UzYq4roAoFhS08UHLMhol3PBRHg0KHhmNAuT9tMCcxkn5jeowzROPf3bwAd25yjxkhb0pZcj6lQ
	GQIoIc8JDSgOvpNCVImp4FI1hL/Z8gv/YoM6WkmFKVgwRzL+qrVRcGA==
X-Gm-Gg: AR+sD13aXYZZxACBkNWXJUxpWibbT64pNsVPO3zOhTSnLcABggcHi1BOB54iv3iPZM9
	VeW1IkAB7iSXLQac4s3MEfyRuSvjj6OE6cCubKzjSiMY2uRQyGbyxqZxHT53dMs0ocShCrIGHaL
	CrxowoYkuDcVRxbH1WQFisR2CwfMcJWZaY9zmk+pianHo/IHUW1yPjx1bQ4bipvqQRfiZKQdMNs
	4tHHFF6fg6PTblPX9Woy0mL1zQ4509K0LLDGd2pppqM1yxS3z6BEHMcaw22qw02L/WbBL1H37V7
	UYFb56h9OxCQ4nSxzw14SLsxgAIWTSKNhJ5/TvQq1oD4G38NFHK6b/vMWD5dFC7rtcRJuSBfCKK
	JuQU577Q9VPBndi8isJcem2H50UkDoK0EZstUDIbz5Us1f+OlTwcZqc9zYA6/ML3p9i+eXnujIo
	DLHKU=
X-Received: by 2002:a05:6402:4491:b0:6a0:47:71a3 with SMTP id 4fb4d7f45d1cf-6a0a7d09735mr241958a12.20.1785516226690;
        Fri, 31 Jul 2026 09:43:46 -0700 (PDT)
X-Received: by 2002:a05:6402:4491:b0:6a0:47:71a3 with SMTP id 4fb4d7f45d1cf-6a0a7d09735mr241946a12.20.1785516226373;
        Fri, 31 Jul 2026 09:43:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c655626sm2907232a12.22.2026.07.31.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:43:45 -0700 (PDT)
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
Subject: [PATCH RFT 1/3] mm: export variants of vmf_insert_pfn* for use with pfn_mkwrite()
Date: Fri, 31 Jul 2026 18:43:39 +0200
Message-ID: <20260731164341.1109827-2-pbonzini@redhat.com>
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

Right now, users of .pfn_mkwrite() have no way to create a PTE
that has gone through maybe_mkwrite().  Because vma_set_page_prot()
will have cleared the writable PTE bit, users of fixup_user_fault()
will see a read-only PTE and have no clue that the page needs
a *second* fault to reach its final status.

Handling this in fixup_user_fault() is problematic: the information
about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
which is an opaque pgprot_t, therefore only follow_pfnmap_start()
knows how to retrieve it.

There are actually some preexisting functions that suggest how this
is supposed to be handled, namely vmf_insert_page_mkwrite() and
vmf_insert_pfn_pmd().  Adjust mm/memory.c to export two more
functions: vmf_insert_pfn_mkwrite() for the common case where
vma->vm_page_prot is okay, and __vmf_insert_pfn_prot() when
really all parameters are needed.  This makes it possible
to fix drivers that use .pfn_mkwrite together with
vmf_insert_pfn() and vmf_insert_pfn_prot().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/mm.h |  4 +++
 mm/huge_memory.c   |  2 +-
 mm/memory.c        | 75 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34c79b5fcb9b..33c7de36b214 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4551,6 +4551,10 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, bool write);
+vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot, bool mkwrite);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..2f4dcaa819b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1615,7 +1615,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
  * @pfn: pfn to insert
  * @write: whether it's a write fault
  *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
+ * Insert a pmd size pfn. See vmf_insert_pfn_mkwrite() for additional info.
  *
  * Return: vm_fault_t value.
  */
diff --git a/mm/memory.c b/mm/memory.c
index 40997a26846f..7b950be8f511 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2718,6 +2718,34 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+			bool mkwrite)
+{
+	/*
+	 * Technically, architectures with pte_special can avoid all these
+	 * restrictions (same for remap_pfn_range).  However we would like
+	 * consistency in testing and feature parity among all, so we should
+	 * try to keep these invariants in place for everybody.
+	 */
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
+	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
+						(VM_PFNMAP|VM_MIXEDMAP));
+	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
+
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+}
+EXPORT_SYMBOL(__vmf_insert_pfn_prot);
+
 /**
  * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
@@ -2754,27 +2782,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
-	/*
-	 * Technically, architectures with pte_special can avoid all these
-	 * restrictions (same for remap_pfn_range).  However we would like
-	 * consistency in testing and feature parity among all, so we should
-	 * try to keep these invariants in place for everybody.
-	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	if (!pfn_modify_allowed(pfn, pgprot))
-		return VM_FAULT_SIGBUS;
-
-	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
-
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return __vmf_insert_pfn_prot(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2805,6 +2813,31 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, possibly writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @write: whether the PTE should be installed writable
+ *
+ * Like vmf_insert_pfn(), except that @write allows installing a writable
+ * PTE even when @vma is under write notification, i.e. when it has a
+ * .page_mkwrite() or .pfn_mkwrite() callback and vma_set_page_prot() has
+ * therefore cleared the write bit from @vma->vm_page_prot.
+ *
+ * Note that neither of these callbacks is invoked, so the caller must
+ * itself do whatever they would have done if @write is true.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, bool write)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot, write);
+}
+EXPORT_SYMBOL(vmf_insert_pfn_mkwrite);
+
 static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
 			bool mkwrite)
 {
-- 
2.55.0

