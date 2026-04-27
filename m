Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10239A052
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287502; cv=none; b=CujdJ0F1TMA4GNXoRVIinVNuO135HTmVboMBM9rBawHOK4icuqhOjgFpncE+qKLG6+bq3JaIDEnbc1pSwg9qP0OooAjhUSJgpsKg6e48ay4zGqdr4cZ9R6qd3U3J402JgAMyjiDBkbuNALGCHpjUauCN5cG7JTnqVRC/pNXrFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287502; c=relaxed/simple;
	bh=dyPAr09lWlR/RQ4fkkDMb+zOF+584aQzExR/1zdUeaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9hP3kXmnXzcCILsYYI728aH29Qzkem5+42KUFJrP5PsLvEP5S00WM9622mUwhoQHKpbwiQKhpX2wrm16MHYBhKLzxPeNoiUeI19HdS9i7vLaPa314YusCPBhSq0Pw7OaW9eAH9/EsEhdFi2bLGKlzOc0Hpme+RUf6sVdAn2K7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPPqc3An; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1s8Xz9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPPqc3An";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1s8Xz9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777287500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wclsbCz45VsM77RlQTKKMaoJPnWAhWJRZZhkjEMod8Q=;
	b=EPPqc3AnigT7UCBxJ17m75aAZvxluYFPJaMRI+t14RfAoB4x5en/qOc+S12Zo88NLCyZUx
	dqQCYlhRKH01EokRHlpcrDVYPChe1PS6nrWY3DfhAFyM0fVmMjHpylVRnjGGBmOs9uzPp6
	E1p4aqR5jx8vlFEh/plNigugaSMFN+Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-DRnGJRbhNxi62s8rnDM5EA-1; Mon, 27 Apr 2026 06:58:16 -0400
X-MC-Unique: DRnGJRbhNxi62s8rnDM5EA-1
X-Mimecast-MFC-AGG-ID: DRnGJRbhNxi62s8rnDM5EA_1777287496
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8e8c47a3so269560231cf.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777287496; x=1777892296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wclsbCz45VsM77RlQTKKMaoJPnWAhWJRZZhkjEMod8Q=;
        b=D1s8Xz9x0iQEukKt8sQruQ54592rdG6R/iRx+F5Hby/KcQlWaMton+911Z740S5Jtb
         SqCizu1NFviFekUpAdvWwA4XShc2fokY+CG5kMt+sFGttChTIDT4A4TvyzxTc+CP91Pg
         Ex7ePLT9LCWbuimzp57Mb0qihzXKMGJ/yQICGPhtE54URE1LRiWxo3oufSMAfGhhXrcN
         YEO0XBqCGtqSXQ8VDugZUWA9P9CGE6w5kFn6++pYZWaNeqE3MMCIjcOzOFx4AoPAvi0J
         KHnT7r/hCD/gySMZOvjO6DF1p5hh6lW49dUlmCt99m40CYO2YnaB9HEfO6TsreqHbBoQ
         Jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777287496; x=1777892296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wclsbCz45VsM77RlQTKKMaoJPnWAhWJRZZhkjEMod8Q=;
        b=C9VaTQ7/+grm/bS9XYiW8hYjwyjE7saits0UDnXoI6ypM5DkQ8p7eSa4iArgk2cXIi
         SISkg/oC3w9SA5hAyAL5hu6sUz1ol0ATl41ABxIZPNlrXfxUDQbfBlhNaUyKrtI2VuNS
         CS26qdkeLBHe2JhvaNTKWlyfuF0sN5x1zukqlTSefhx8qaKJmMZ4W1+U/APoSjnPrE0+
         E1MTMFIVkh4H28pFtVRy5JfDx2sJn/t4BWlobEM/cEqbAwmTojQ+CNiiMJVRRlE3tL6i
         ofQ62yL53X5uUf8u9EwWOwit8W1hxFDrIwI51+pbH1oxRqCySezZmF+R1yl29Ff4/a8d
         KzoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xD62ZanUWRfQnMVJmHHwluag+OK7awvG574mCKZ6KyAls+6JYAYbfsREliKbvzBMeQ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9ACJubh3kOBMtLBZnRRFle409eHCb+I17BsP7H92r5HRNGED
	fViQfNcxgHLF+4ONDaZy/tyAxPwE6uj3xhYGeJcPpwlQAGfpVSBw1AJdym+zrAQ0skcS4MMaucc
	8eujsX7L84s6n6GPMnyGQytzZhIlzp6y9hFlHaHQNwlEGOyWRjN329A==
X-Gm-Gg: AeBDieugDHxsh0hFcGXMJfMYuDC2P3GMNXVEtS42mkwgHneuJ9g4ebPlUrt+eCPXTFG
	b76XNWyaB078FDFfAp/xk+bGsv30pXi/8Lf2kMdXdXP9EAIKJrxoWqTSO0+5VvKovvCX+jhyTmP
	CZ1sksiUET7ZMtWkCgbjly/y3A2K8wdFKsHU2AjUs8FOUWyhzRBbvwmZ2Di+P9WaS2m7wfRhDz7
	WQXxjjH5b5v9Kn5unGeNnU/E6loYjso99xc0vZ/i1RwPCNJozChIOCeEONUBSibt1UDRa+jBoPu
	bPLBHtqMCJ3qCi2Zl1tSzODwLkihnjjzNEVGrHhylupqadztgofRKZg7hsckmHvXDMcwhtOUkoB
	KUn6u1UrhsW3+CLAgNXkcMidbpJsSDY6oF+AdtGzr7IIXqP9nxhQDtpebbpr/wYBHJ4OMo+gkkF
	8I0+wsWr+NHR7PNsmZXl4YcAwYqb/Y99nHnuM=
X-Received: by 2002:ac8:7d56:0:b0:50e:ca38:e219 with SMTP id d75a77b69052e-50eca390557mr474867671cf.45.1777287495887;
        Mon, 27 Apr 2026 03:58:15 -0700 (PDT)
X-Received: by 2002:ac8:7d56:0:b0:50e:ca38:e219 with SMTP id d75a77b69052e-50eca390557mr474867401cf.45.1777287495453;
        Mon, 27 Apr 2026 03:58:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39495192sm263471871cf.27.2026.04.27.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:58:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-m68k@lists.linux-m68k.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mm_types: remove references to s390 gmap
Date: Mon, 27 Apr 2026 12:58:10 +0200
Message-ID: <20260427105810.23761-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s390 does not anymore use special struct page for its shadow page tables.
The honor of giving a special meaning to pt_index is now m68k's, so
rename the fields and adjust them for the desired type.

Cc: linux-mm@kvack.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Compile-tested only.

 arch/m68k/mm/motorola.c  |  2 +-
 include/linux/mm_types.h | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index b30aa69a73a6..67e8a2cf4c41 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -105,7 +105,7 @@ static struct list_head ptable_list[3] = {
 
 #define PD_PTABLE(ptdesc) ((ptable_desc *)&(virt_to_ptdesc((void *)(ptdesc))->pt_list))
 #define PD_PTDESC(ptable) (list_entry(ptable, struct ptdesc, pt_list))
-#define PD_MARKBITS(dp) (*(unsigned int *)&PD_PTDESC(dp)->pt_index)
+#define PD_MARKBITS(dp)   (PD_PTDESC(dp)->pt_markbits)
 
 static const int ptable_shift[3] = {
 	7+2, /* PGD */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b82..9e4dbcddaf33 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -550,13 +550,12 @@ FOLIO_MATCH(compound_info, _head_3);
  * struct ptdesc -    Memory descriptor for page tables.
  * @pt_flags: enum pt_flags plus zone/node/section.
  * @pt_rcu_head:      For freeing page table pages.
- * @pt_list:          List of used page tables. Used for s390 gmap shadow pages
- *                    (which are not linked into the user page tables) and x86
- *                    pgds.
+ * @pt_list:          List of used page tables. Used by m68k pointer tables
+ *                    and x86 pgds.
  * @_pt_pad_1:        Padding that aliases with page's compound head.
  * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
  * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
- * @pt_index:         Used for s390 gmap.
+ * @pt_markbits:      Used for m68k pointer tables.
  * @pt_mm:            Used for x86 pgds.
  * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
  * @pt_share_count:   Used for HugeTLB PMD page table share count.
@@ -583,7 +582,7 @@ struct ptdesc {
 	unsigned long __page_mapping;
 
 	union {
-		pgoff_t pt_index;
+		unsigned int pt_markbits;
 		struct mm_struct *pt_mm;
 		atomic_t pt_frag_refcount;
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
@@ -612,7 +611,7 @@ TABLE_MATCH(flags, pt_flags);
 TABLE_MATCH(compound_info, pt_list);
 TABLE_MATCH(compound_info, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
-TABLE_MATCH(__folio_index, pt_index);
+TABLE_MATCH(__folio_index, pt_markbits);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, __page_refcount);
-- 
2.53.0

