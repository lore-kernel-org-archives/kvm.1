Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3ED4E36FF
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677914; cv=none; b=jl4p1uT7tjV9VvNS4tjOLfbFfH265YmEsOZkoyVbvTy3wKkcPvlTkcZRIdU+uN1Gw1LYZsFrwa2sHcBhxQM178ehFAWD9DQEz5HXNBJmyRwDcKgCQ1A1NNqZVZ/8eaRGIzcMMxGnCft0riscpszPR8se+7rtFzEUIJ+hSGnSyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677914; c=relaxed/simple;
	bh=VByVeEjI4LUQrNUSvfcdQ/qkaw2W/Fj0TZtQKNhauZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSTnEyWRBEUKV7EJUQmEHTnuBBsWM2I82+M0+f0S8prt76tvWFSYuXWsyZO0KIGihzd3kph9Edp8Uyg7dXm6OcpAY83LZGvI7s6ALNCU2z2miraqZd0a2QSxkCHKezuft4qo04U3WzeiCCJGGO2qzi+1HZ0vQGh5s6qXRvIvYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRqonI+n; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRqonI+n"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so110297a91.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789677909; x=1790282709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxlCNYOwsW45BnQIn3JTG+O/SEl/6G4eXS+I5oaCDnU=;
        b=MRqonI+nHeywoLMhrBjnzBL3OVdhM5yIzLFh7gn568V6uex2cDxSGywudR31v3ApUG
         Vcr6lmKCoHul00MV+iRxo8IhueDX4NjW428DUTv+VsqhA7W9/tr/9N0XpWQ/JXrdoehP
         boEswlQrPr5jdhI+h/c/Jzq7/BjU1cxex2I4l+RsBXO3kg7zQxYNtBczOZB7vKB5t6/f
         2Ba+U6rup/kxnLQPDzPl50OGsn1OJq/2XbFfnXyGyIiwJTSUTWICFH4s2i2nUlqr+9EG
         d/+TcmzJl/U0JA1ifPAXhiLDdF3ZfyT+ZJIFlYffTuKZkTu0+zzsY49+4ZVdwhgupqzS
         z7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677909; x=1790282709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxlCNYOwsW45BnQIn3JTG+O/SEl/6G4eXS+I5oaCDnU=;
        b=PBvNEMUl82J27mI70hfcG/WZc+m1AbW7p5YGaWAmMvMjVq62873OpJrx8pFwIkwcGH
         WooBxizWFMMcEY1+8J4Mil+2k/XaOavuKb8OPa9uiSOuhDSIPo1RXjS14IQYJuEM9DDJ
         cyFFEvCNfo784r6+9xzKUzY9m6hpyqVkRAiu9/LxJjO3Q0zlcYdDiRVZQv4H4OKTe22c
         froSCrE+bKzr3GxpzsD9VBn32SeSkK2qyPccq15FdXS2rO9le08qF8N0Qc8ZZX3zp592
         dGm6yIMsoTiQVSvM+GX+AejfU7clhnIdRMFBUTScjCb4KJMVS8i2B9iYSK9dnZr2YCcP
         3JAw==
X-Forwarded-Encrypted: i=1; AKwUvBw7WQBs6OKGDejbpdOlD+28B/NOp8mN7MvqrXxrM2dnNjVF9J97q2mJso8iJAxNanRSmeg=@vger.kernel.org
X-Gm-Message-State: AFuF++m986yv+XaZ5aGJFR2uKK3FoLNn/gbqGA6d1J41fA4ny01Scu0s
	MyO+gFGTyOubent1Bl9yqUlkiPYpR0pXQthN6IeO4MD49JzDNYKF/iFUJulz2d0VvJ+LVNrMpfS
	pNyYuww==
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:39e:4bdd:a2c8])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8b:b0:39e:410b:bec4
 with SMTP id 98e67ed59e1d1-39e54dca306mr707986a91.11.1789677908717; Thu, 17
 Sep 2026 13:45:08 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:43:47 +0000
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789677906; l=2541;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=VByVeEjI4LUQrNUSvfcdQ/qkaw2W/Fj0TZtQKNhauZ4=; b=26Q9nOB/cKS3IbZahb3B67Qv7bStXKlTukEhrVZ3ZTwAxnSeS1vUPLqyUMVeJYRB0EYtlJR7z
 gJoC/MAIdDNALDdHkcigEox0KlId9ndvnjep7WAdkFOdJ368ZU4Ehy+
X-Mailer: b4 0.14.3
Message-ID: <20260917-memory-failure-mf-delayed-fix-v6-1-4b00856b5364@google.com>
Subject: [PATCH v6 1/5] mm: memory_failure: Clarify the MF_DELAYED definition
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
2.55.0.1082.g2b9226bbc0-goog

