Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDA3A9626
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437367; cv=none; b=MGfuv6UW63DHHL7XFGw1o/HJ0K7vTqPrpqb9ad6tDK4l/NHtM3AMsjtKeucfz8neeD1AvSzpQ4rnONTfgTbaMRifPqjlPQMoCuYjD75yid6FTWuIWQ+MSMuvkw3Q0kHo/pll5ripoWXfGmFdQFef5ynR2A1pWTmdRMleykhZC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437367; c=relaxed/simple;
	bh=eDCJmE+ukj/QmiRfjhh4tiNP2lmAkBpX7X42rYIjVPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEPcWhbAa5mJBPpk0zDCIK32xQr1suEXwd1LtEZXTNz+zQKBN9mdFq23QSTcQNk/4c1asCTJHBodZGmrnNkV4qbkMVL0orlMbbwSRgHP7/jnNAPxGUFaZBmlf6aOVN6WoflVc17z4OrrlaHgZY7yhpUoVTe/eB5okvkQL0Ee+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVHMQ5mt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVHMQ5mt"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0bfcd629eso38844285ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437365; x=1781042165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IodJjZi5r7h0hIvWeeU29JYBpcZRZhnAZAUBtd3riDg=;
        b=FVHMQ5mtmSeIfohMz54I3zBYQVu3f5WT9tNk/XSE71azpt9WW6ygJyBSzNZoCe2lGn
         hjIpwezmgVBFVDT0ZwKAEMpR9aZTpYyRr6mWUJlaqzAOQWsPSiarUQxqbavAeWEH/XVQ
         1M1OVPkIqXrnBkbWGIaxQWKRsisaEB8bVn5BYCmLjsyuYXbvjJKMCSkoe1nOH2D3ncZb
         /MTAL7D+qNvKVxhSXfmiw2drSCtCZS+/c1XCyo+J/U042S4aTKfhmC6KwHqORczLwlfj
         DOCdm7w4WDAErrt5UgwtXI3B97iU2u6qUlayiiODKGzxeMm4CUmCr4biV4W3DMdjaoHS
         IvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437365; x=1781042165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IodJjZi5r7h0hIvWeeU29JYBpcZRZhnAZAUBtd3riDg=;
        b=WG4Rban/l+cC5vfU0mpWXM2UuQM83Y9m4iEBvqa+5qLtwIntAE7nQfnUYSZFwxnEyz
         HnUYhWwIFmzgTjqDW71oAMrdmT5fvGXDwPylFJxw41M0EGVE50ZkiF7dqQTrHZnOE3pp
         i3OOPCjMVQrbIc6NuC+ypmsQEBdlSp0UzrNJx1l7+gJo5CbxLNR4O7j3i+hJx+3pm2kM
         Oesm/htxyTrnqbJlSYEi7u6uLfshmXAPJX9NzqmB1NUhrEzapafHlXWB2Ygfx8hDzmTE
         7Q6eVEU6yOGLLOoOOksi6yWxryuIEdC2a7UN/E8GzE+V+R22OQPdqzgBAcXPeBzNjYRc
         /9uw==
X-Forwarded-Encrypted: i=1; AFNElJ9W16U5ydr4+ehf3LNjV78L+6Pu8hbB5Sd9KaONAjaslHb3q6DWsA8ZtMV9MYXVY4RwBK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUX4N50xyMBqyixBu5LBUjn+5+vzvq1WWqN/7GaBHxuoOMtn4f
	1Wgpsgvr2AwJgcH90z/lEdQIFY9YPrtqkXNbdzkRPrqtJ8aUBXVE6tQoa1JYKWBjC6VAuDdQXrH
	ULhUCqA==
X-Received: from pljf15.prod.google.com ([2002:a17:902:ff0f:b0:2bd:e92a:169b])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b8d:b0:2c0:cbd8:5ff9
 with SMTP id d9443c01a7336-2c163fa8268mr4999375ad.21.1780437365088; Tue, 02
 Jun 2026 14:56:05 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:41 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=2390;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=eDCJmE+ukj/QmiRfjhh4tiNP2lmAkBpX7X42rYIjVPg=; b=qlOZ4DnpysCVCE4RR3aGPdX4Di/mOUwwaTmtW26PG+ejDM/9AkmX+V6nOEdYaPJYt6sl8ORav
 5QxNZfYotzjAiPo92LoZAmJK1I57WL8Zcm0X9kR0EJD3OR5c59Nwoco
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-1-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

This patch clarifies the definition of MF_DELAYED to represent cases
where a folio's removal is initiated but not immediately completed
(e.g., due to remaining metadata references).

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..2e53b3024391 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -849,24 +849,25 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 }
 
 /*
- * MF_IGNORED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * MF_IGNORED - The m-f() handler marks the page as PG_hwpoison'ed.
  * But it could not do more to isolate the page from being accessed again,
  * nor does it kill the process. This is extremely rare and one of the
  * potential causes is that the page state has been changed due to
  * underlying race condition. This is the most severe outcomes.
  *
- * MF_FAILED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * MF_FAILED - The m-f() handler marks the page as PG_hwpoison'ed.
  * It should have killed the process, but it can't isolate the page,
  * due to conditions such as extra pin, unmap failure, etc. Accessing
  * the page again may trigger another MCE and the process will be killed
  * by the m-f() handler immediately.
  *
- * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
- * The page is unmapped, and is removed from the LRU or file mapping.
- * An attempt to access the page again will trigger page fault and the
- * PF handler will kill the process.
+ * MF_DELAYED - The m-f() handler marks the page as PG_hwpoison'ed.
+ * It means the page was unmapped and partially isolated (e.g. removed from
+ * file mapping or the LRU) but full cleanup is deferred (e.g. the metadata
+ * for the memory, as in struct page/folio, is still referenced). Any
+ * further access to the page will result in the process being killed.
  *
- * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
+ * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoison'ed.
  * The page has been completely isolated, that is, unmapped, taken out of
  * the buddy system, or hole-punched out of the file mapping.
  */

-- 
2.54.0.1013.g208068f2d8-goog

