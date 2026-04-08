Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8F3D7D77
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669173; cv=none; b=h2vYDvNkbcbV6RQtBIAS5H1oayWmJ52RyRix7ZfHMME5jTwXMMOEs9xHKW6KboYxAKu4FjAo1GDG7Eo5bXlJLWokYaxnBrkWS1EHupupRdkSm6QYP9u470Jskr32/nXhVxHXHniiEanh+w/y2gAWaXtsRO5rhRZzzl+AygQQ8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669173; c=relaxed/simple;
	bh=tCUAER8XAOCDEwqKOePrak2HLKwWUrDfij0Iac7Dp58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKBbfjJOgwUBZnd5TUpsORniiSJafiLi2nfjmeEVmprPWJE8usVviw8mpzfOTiK+U9j1Eu6+eCiBhn9l4p9m2c0l7TpuHM2iIA9gK7l1i+KxrVtaio+E3d+Dq7k+u1HzYqeKqRi+rO4bwAScgI5L4CdMjjpJ3In3ONFK5+D8WX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXzzrlOB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXzzrlOB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so25360b3a.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669171; x=1776273971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i55NDozws+Qi2zC4BPESxJxfrP5x0dQcJH7CMgcHTvw=;
        b=GXzzrlOBkBKi2Fkrvfxbn4IUUV1j3G+8+tfLRE7Mz1LP2PCVgByg9v6S6h9EKK1nIO
         B8uaRqGhcn0Lur1eu6WM70vBWN5t85w5djkltLdHpyD8Er5ut1p8sKJ/iRI55r9l8BlA
         SQiCYY2blS8cfjbHSZ0vDk9pbbm9TxWGLgMTC3+OaPz80WnT9x0LexLv9/JbX+QvBwF5
         FTL31niw8r5GTdZisfXIVlEVUwqKshzUZHBdz0RjN5LcGsgOKIw4UMyDqt4pmPqjqz+r
         sFAe9pTBO7D07zSwUeiKT6wHIoAJAme8CTLyW4UWr5bzwSCdvXs15L1HuiOl+czg0YSt
         96wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669171; x=1776273971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i55NDozws+Qi2zC4BPESxJxfrP5x0dQcJH7CMgcHTvw=;
        b=mHdtLBz1SKOABCEMWu2LqYW4Zy25IsS4yLECgYS8AHjs1qtsx8po6IgztAURuB/WvN
         87KZsj5mFqGl6tGkzcVvZwel8FdDRgt7bXbxZ0ISAUb77PQSdZfZwnMBT0XKgwEKQ4id
         JKZOXsTqiOQ7XiHn+EAZYruDEwJX8pDg7McBeTxcJHWUtbYANaHAYq23ohYe7XZBD22M
         nDSvs3+gmRpi42auuXPXkLZtMzfc7oKYta9ydDmqF2hlZHYub9/rLbhdF+vQow47WGER
         MzmOtHJ2kT40m+d9FkM1OkbHL/ERRdF6HqC2QAC4weF8I67fYfROJ1WVcm8aEgephNFL
         Lp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxSz2VeX9yJtoeR1QoA87BzDocLKiCk9cT0zlyI3+207G3uq2BWOXkclmvZC9SfOE58/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JuuJ7i21uCTxmj6x9ZpHSyv31BZH2ACeQdlkviVlY/Fav1tx
	pgCnBXU01mc2FyP6F1gVMU6irb/zRmHm30HmGRmCAjbAHmlRlkOKtLjYkIJ/G2ZH1yWzhHYFr/C
	cMcPvcQ==
X-Received: from pfx30.prod.google.com ([2002:a05:6a00:a45e:b0:82a:6bbe:c0dd])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c9e:b0:821:81ef:5de8
 with SMTP id d2e1a72fcca58-82d0da4680bmr20598726b3a.12.1775669171123; Wed, 08
 Apr 2026 10:26:11 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:42 +0000
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=2390;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=tCUAER8XAOCDEwqKOePrak2HLKwWUrDfij0Iac7Dp58=; b=buXgD0W2k9Th2g3W9/TO/6Ez7VzKspI14jx1Q91h6/d29lN7r5B3H1yOm0SeG+gIqR4hNTHhQ
 1k5jFUJpx39BlVEg10kkWolRIctuvMivfofoisa1Uv7IEef0KJmZW7e
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-1-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
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
2.53.0.1213.gd9a14994de-goog

