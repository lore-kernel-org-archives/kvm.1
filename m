Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187F3AEF4F
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514076; cv=none; b=XCEZh8SiIZGw/2Ivc01+AlKRJkH1EltAu11a2R3EDCFFnGCA5hP4rueYLkZ8M0PttFAa8wCCzkLWW1JlSluTOHS/3lHHxGR7KhVClpTdxRCYqofExLU+p1DBlsITdFL8BItPYcGQJYx/DuJVDpTkpm0nd/Ldga8VqL6WH+0fY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514076; c=relaxed/simple;
	bh=vCHjJBFQNgP1MdM2vs0H0cX8vGGek8P/ghWBajkazgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PT7Up/Nx/2O6HdMJ/4oKABQ9ZMuqxRTCmfYgNFj/bll27buG8MHo3YBimMhkrsg+uHUhPBu7r0dYZDU59ms/AixB9nCUqivK+c722t5YS8d/HaSxMxwyCWXtq2lhaSyi/OC72qSWkDn/UaMVetqNoqDUaPv52yfuNc+4WRUkU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQqm+fLb; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQqm+fLb"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce14a21faso37119075ad.0
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514074; x=1788118874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PLLVRLXNNRd7Ed/uUOsyNVCmInoOvgLdAuldbbtEw8=;
        b=bQqm+fLbhhKyuldFic2GLo4TcZ6T0KskLKy1Mu+JCqzxwIHpZKJFyAoF00tQiWZV6P
         NihoYzk3Et8CfI9h4t8ewVqrDXqfFIKffyzSQKUeHKCMbk7w6hsKFEge2uTXdCMOJ7p0
         bR/e7OU/lbfr7mlwNrDoXWJinYD3QCrX861rUuKqjJtSvTKEXsT3/Nf/j+FS3Up5/5nW
         J9fQTPnKhV4h1PRjTUzyKbCD5DMwcrpDDa0Vk/efhNKMf1gShEv3EDBp+qzmOoXtx5wj
         /OJ/u/2rwBcHNQKxpgsQnRIGkodTQRvDVmlKcjYSo7Ds8zjTji9A6W6Oj19fYPOL14t/
         rvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514074; x=1788118874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PLLVRLXNNRd7Ed/uUOsyNVCmInoOvgLdAuldbbtEw8=;
        b=a24qInJah8s0I7l1Qypdecp/RlcbrgL+sFFM0uxB7srzC1xY7yy74fPtGaC/lCFRls
         7cKodmJ3YTxO/lqdkynkIoewzwiy3awEeg3EaXEjG15b61ClFOLqBfmFvj0bC9MBY+wk
         zPmQ2v9eEd/kBqRUSE8eZnOmSQgQRCE5CH0bY9K4kcytSZQnFxuvLFQsZ7f9LdxQCB1D
         Fbh+Ns6ezQBi99X9GqLOjm3Nw9BfIJgSRkZwpYK+L96eKBYuRNa+Bvrw/T8gOosxO/+N
         Q7G2FFJRCOLD+pK73/8vHo2NC6hWp9P7nqu2ya4cTMlvXePoqeQ65CsyvwRyishJ0psM
         +61w==
X-Forwarded-Encrypted: i=1; AHgh+Rqjeis/bwmbrWltoC+U6Qj8AGh2Yaa4KqGwNorPhL/Fuwl8LLpDTutIIupsVHIZzFZs3nU=@vger.kernel.org
X-Gm-Message-State: AFuF++lb3odw/9/pkzPBI2oHsRFIZHDtIgLnGh3dzfdWsnbAvodPN9/d
	bez/pwWnxun1K3vL4wqFttMSJwvS0DmfAqIWUovPEv99DLkkzHum9VKPjPSWft89iHGHVEGhvnm
	nCRuKmw==
X-Received: from plgu17.prod.google.com ([2002:a17:902:e811:b0:2cf:e9e8:7776])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c8:b0:2bc:e299:4b3f
 with SMTP id d9443c01a7336-2d6501d2265mr232088365ad.10.1787514074179; Sun, 23
 Aug 2026 12:41:14 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:54 +0000
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=2540;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=vCHjJBFQNgP1MdM2vs0H0cX8vGGek8P/ghWBajkazgE=; b=2sOGcjZM07dUbENkG7ka8LU+3w8x7MPjDTsuM6RqhzWcVud3VEqIB1Z/Pld7tKcRttGXPnsFr
 /62srT92oGsA7CVfqsivq5aDykS/C493DC4/WQwo3KfT2kM0654yUZf
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-1-d97a5703e45a@google.com>
Subject: [PATCH v5 1/5] mm: memory_failure: Clarify the MF_DELAYED definition
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

This patch clarifies the definition of MF_DELAYED to represent cases
where a folio's removal is initiated but not immediately completed
(e.g., due to remaining metadata references).

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaf14608b30e..e698d0e9711d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -847,24 +847,25 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
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
2.55.0.766.g2966f0265a-goog

