Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3B3B05B9
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514081; cv=none; b=cbC1mUG68CNKOlfI1Ih2/+QwcYw8DF6nHrqKVZ6Gqwier5nh3QhPXjm7S0JdX0J/z7ww7D4FOPpMnlMmV4qmN8pInfuI8OB9v4DnZkLjiE8AB7VoKTPhz5E7XTPxmUSNPCEGd1RfPoI8YZ+BIjBCmacN1twrWHdZI4GWfTuuOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514081; c=relaxed/simple;
	bh=M2qr6lCxGvnWbypTSRZIOkbIWHxFsLVgiK9mM+E8odY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNTF6GB82QOQ+VfupVAFnajjBlEjFdt5MSJU1HbqZvpXjFcjDZL8v4HNKWOcJa3PVkjiPtpyHDswohNoVAV7liuaJxX98bzVzcU2Z191UHbxYQyy6GXnFEzj4vlmmgotzwUaCCi2nv5QgYN9jm7QEei/UBhCPb0BTnqkWVSrQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eACy3+TL; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eACy3+TL"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso2632891b3a.0
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514078; x=1788118878; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vW4yOfIAs8YLh9FZCJuAriQaRtqPfpKolhm3EvkTWjA=;
        b=eACy3+TL/HyNscfvyopbIjS/rOc3aPM4/y2zLiIosHg8sJ2ulGRyd/FYF2X0bzb12G
         l/FUXOeieVYjzo/HP+Xof/mIY4N25i6tNMz7JyESxVa42WvMXCQMCNVajujTN4BuVkK/
         pNEjwPKgSG9HArCv58tIWqUDpocyTs926Trin2xu2bYWc0d3JcvxKdwxqMjVswN9YWR+
         guHwooer4wmE5hdvTfoTRl5sVoUeho0ZUGBZtZs6jvWGrbX94riTuv9+Yc1tNIAn8KO8
         Gl0sid0OXngvsnCfGk2ZctS1S/F7fzVpGm4UooynCaMYFqg5SMtcHflzAXDIguwlyvpn
         hx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514078; x=1788118878;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vW4yOfIAs8YLh9FZCJuAriQaRtqPfpKolhm3EvkTWjA=;
        b=qLkJdJtLgzgcVbZa9LDGSC5QG49i3RBqWrZNp4+yAqYDdoXTnKRvi++7owZ/fvDl+n
         u2C9xkN3nCDifm4WzV/2WJzi5qgqXnk8faTy+WL3GsW7ZdU0/X4t0eAQ1IRRLBA/KaIk
         i3O+5b0YEcwbQTkBKbn38uC8mQyJVHLtPnNJcpke1EaX00wAsHK7qW6HCqZ8ms9JloY2
         Mt51wiLQ5z5h++FnNd+GP9NjxBp2ebaomVoTbAvDAuNT1dF4R5/mi8tYWI/qYSR9Jbxq
         cWs9IPVMQPjYvxFgTja0EsRzr66emG0zQQDyU+vFteQQYve7lRnS3DZzKYnTJr4JRUJM
         Aw6g==
X-Forwarded-Encrypted: i=1; AHgh+RrtXGPGrit0esa585PFxEPTKZxKbSzkvUGrTHuA6ineJtIiF7pA7C3vPI5eayQHyHsTqts=@vger.kernel.org
X-Gm-Message-State: AFuF++moADz9y5iAP5p0q1IUMjHpEq/N8TONQNHbLpptuJgoIOJFFQDn
	qyUETNdfvA8StX6/cL7Tt3ag36H9t5FCkljYmidlT3RlHtRLXC21g8JPjLkiYsecfQ19VtCCq9W
	Sfa6Syg==
X-Received: from pgby19-n1.prod.google.com ([2002:a05:6a02:6513:10b0:cc1:960c:15b1])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d28:b0:845:e8b5:8c49
 with SMTP id d2e1a72fcca58-851f9f39cd1mr32509544b3a.10.1787514078336; Sun, 23
 Aug 2026 12:41:18 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:57 +0000
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=1693;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=M2qr6lCxGvnWbypTSRZIOkbIWHxFsLVgiK9mM+E8odY=; b=bd+N1aGdqQ3cc8pEFS9Y7bF9mKDfVbYMU2k/ThMMa54u9kS1Z3odwN1SSgUef8uc2QmPWF/Sl
 WVWnSzs0S3YCNF3JkKpTzl9HEIlQBvjr3CCKD4lyyX1EO4Ea75pfji3
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-4-d97a5703e45a@google.com>
Subject: [PATCH v5 4/5] mm: memory_failure: Generalize extra_pins handling to
 all MF_DELAYED cases
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

Generalize extra_pins handling to all MF_DELAYED cases not only
shmem_mapping.

If MF_DELAYED is returned, the filemap continues to hold refcounts on the
folio. Hence, take that into account when checking for extra refcounts.

As clarified in an earlier patch, a return value of MF_DELAYED implies that
the page still has elevated refcounts. Hence, set extra_pins to true if the
return value is MF_DELAYED. This is aligned with the implementation in
me_swapcache_dirty(), where, if a folio is still in the swap cache, ret is
set to MF_DELAYED and extra_pins is set to true.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 37ea23489b75..c7a00c7be368 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1039,18 +1039,14 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
-	/*
-	 * The shmem page is kept in page cache instead of truncating
-	 * so is expected to have an extra refcount after error-handling.
-	 */
-	extra_pins = shmem_mapping(mapping);
-
 	/*
 	 * Truncation is a bit tricky. Enable it per file system for now.
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
 	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
+
+	extra_pins = ret == MF_DELAYED;
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 

-- 
2.55.0.766.g2966f0265a-goog

