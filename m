Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC2F7F01
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677915; cv=none; b=U4BQ8DeULKWhxfva0Phlgv+JgX29HbNj/U23PP115u73OTQi3jPI158Zp2TZcZx19ZZbyLusphvRf2atKohY5CS+5UptNULwdzOrAKeHOWtsdkB+s1LziCtJwd26L5TNY9X5rG1QuZn93clX+5JHfH40qMcLug3wbO4WtrDhe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677915; c=relaxed/simple;
	bh=y+kljbprzv16FEW0R5LMRlVvQbhp1uI0L+ucmxjcblI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L3TaG9ANRmTfgc2OsVuuy88b4G7WQPDgcagbv5lu3jjBsNBigTU0rFtm0bZS0w0QvHsV9Ig2D78vs3xkZ2WGx3UqANMUKs8OF46pM+7ZL106UNzIF+PsNoEbraGBMODXSIcul7f+4ddSmb37iTHf2d0R9ZE/LSjJS4yjvHKBt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMl2ghSw; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMl2ghSw"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc2229450b4so1123394a12.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789677911; x=1790282711; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGFXLYLaJ+InCA49wUVYw7NUJomlNkAd8fgmCjgGvRw=;
        b=YMl2ghSwaOA4xL0aTxd1LZunMvWLWGqI6CICXrrkbfw6/t2vmnR0lRoSKEIeSR55kI
         k6gg6+TxBLtlX12bxWuO/JaUmnQ8kRvAbojANjoLkoEegz0NBa1jUI2Wunn0f2yF1dnO
         uLLjuBfNmygxJBe0KIVbOtQJxPyE/tMRUQQdxTXlxixAm9eVPvWsktwXf0c1Wt0cALj9
         Fs6xe2/99xkxO+1BfbMUfIdfgyYbE0R7+1akl6Hzw0ZesGVYodPU4s424SFcphK6GUJU
         D04lTvXRWVLg4WnEfa0Guvcyzg3b4EBFltCTwFENKnFfVBiST23wVvWsi824r9iblR8X
         UCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677911; x=1790282711;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGFXLYLaJ+InCA49wUVYw7NUJomlNkAd8fgmCjgGvRw=;
        b=El7FCEPj9171x71QnRMk5aPvSvgtckfuoPMScIlu4WsAsmffkaesZJxPYtGv1/XN0V
         tOv+LHx1QH7lize/j+XvYTsSwqFSGP+pW0oKasyDWq9r37N6qgsWaBddZGoaizvJcPBL
         X4jUorZNS5SVPwqxuVBahi9YM5n8Va51s1rFNrN7LB/ZuwbNfx6rOh5cnwz11CZSqKkC
         KQtqge74tcMRNVgo9SYVP6awOKJy1v/yo72QMFpNilxJperWla0Rm7pN3WRYK+1JJTqm
         ABOQ77e3CzoxHYxcBMxOpewfSG98QXThs87qQoZ9Y+1/iLEKeqXq7w0U7oHsajQg65ko
         Yf1Q==
X-Forwarded-Encrypted: i=1; AKwUvBy0XzyFHHiMkL3+PFexNQB1yU7OcovLLe78P9Ytq+SiIAzTRi8esXRha7YrpKN5f4ZproQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lX6sy57D2nBDW6w9JajMp3TfSwPZ1N2pqcrE6X+a6KKmoSgMEm
	sN1DEq4pabRSvQkH/2JYRcPknXUk1RW9s+qbA0hARUfHvCCaXziDzlRjaJ0h8N2PzbCTdM0D3fk
	q5hJOug==
X-Received: from pgby18-n1.prod.google.com ([2002:a05:6a02:6512:10b0:cc4:b427:4edc])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2586:b0:3dd:85aa:452a
 with SMTP id adf61e73a8af0-3dd8c53aa87mr322161637.37.1789677911269; Thu, 17
 Sep 2026 13:45:11 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:43:50 +0000
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789677906; l=1694;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=y+kljbprzv16FEW0R5LMRlVvQbhp1uI0L+ucmxjcblI=; b=dGqQYjedOERCKiCjnJKisYhsTZMBcs8c13M3JPpg6A9i4it98kymjesDKoJjNEGSRfSyI5HCc
 ODtrd4OL3p8AnfgcbvoGkMFMPXtlua/Nkbp4d/SrhzytfRXP5wu1rg0
X-Mailer: b4 0.14.3
Message-ID: <20260917-memory-failure-mf-delayed-fix-v6-4-4b00856b5364@google.com>
Subject: [PATCH v6 4/5] mm: memory_failure: Generalize extra_pins handling to
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
2.55.0.1082.g2b9226bbc0-goog

