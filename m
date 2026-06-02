Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE643B6C13
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437370; cv=none; b=aRN/Ds9P+j+0xXfw/+0QpY8U8eBXlXjTlGQUhtC+h7y2AIY1klvA3RGhCcLfz2YiIJSjo8/eJv3wuK4k5UUwt+3iDFKAr5XCXw291/+EZZbO3tIzl0J+Z4vJnBZyqaDRLB10uQtsG/BEmyCpP+bIOIAeYySHkjVQYmC23J0jawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437370; c=relaxed/simple;
	bh=L7ogU8losQ0qpIb9WkPmejB/jf99wccvfK1O3XZC+fU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JZgbKQuU2gcZkKU73Bcun/aGx2znllxQ8j0wpe7bwCS83WtxQKwdk7IBhrJCxF+7GgKArONElR0WCvzU3WvXV1yAcyx6mkp+JSlS5gMvq14we6JDIzHQSKJCDXUn2JOqNt4J8vJYC7fKAPtUPbDhyCZG1gU7KZQuNUFXvfG1GC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxxzu1v6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxxzu1v6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84256bee9a9so1606769b3a.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437369; x=1781042169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KByQd5D9+h5QFxoMWwNO5RLzWEY8UhS0HfK4sny+Tpg=;
        b=vxxzu1v663FMgvFjCiQBorScJe/yEJXg5NbwGXQdAcAeBPRlu+Iq98ee1ZNKWAav+X
         Ge83OV+lbvJdS/LJbGwOdVDTYYHW1ylNLBHRknwZ4rYGhZtbHWBcLU4cN0DqBrzgmvAW
         f+gZqHWw7yr4rLcr4D40+HmTQCxduto6HceHcR6NGbvshUuP1tPEUvCfE08/gqjPDDkd
         bHRWd21JxC9/UO7UDgVZJbkmyXuDrOMTk0A6eaFHuJFsBXcW/csQx2qsiYCvQJ6D7pVi
         uMZoYo+G05nr3+/cdoWwX+ZlRN5dKXYky1r06MVG5gCraQWUybyK97qG/yK4VRcmJLiC
         mY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437369; x=1781042169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KByQd5D9+h5QFxoMWwNO5RLzWEY8UhS0HfK4sny+Tpg=;
        b=I33d0aYlUyZdp+jLxgq5gAO3eAL522QYdZfFnEJCS4PwjtH4PplfjagLDtKguCWwIV
         iHBwnLVZ33WdMYtabYF4/vS77F4LG2WPynKnSqPKoH9CFea5enSGsUf8HYEtGQEoEZoI
         TZe8+mterpUCxQvPXRMmxP2HbOjn5IHgK43foecnvZFN/EHdL8w7a9DpCyupi62AYyjD
         MUfMF0hjPoHorK7i0tEh9CYmRPZf67ho88F8eRuAgd7UEA/1+QFhtvmaY1mwwfxDjaAB
         ylwP6nWeRxX7pRomL/hnB/nFEqTNzHLbJCggVDK81FNlzquYt0TDGSH4+evIepnEyii2
         5XYQ==
X-Forwarded-Encrypted: i=1; AFNElJ906hnRHAB+7eHy2vFbNdza0f5vY8dBT5kQ0tLz8M6IJfuF+4I9D7SxBROh9XufwVABSLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbZKRkDWH9E6oKhvbqLIgixEuTOB9aYd1f/nVkRU6axcqkRNB
	VySxXFsR9x0VXjMySWhCrd9R49qpg+ARIxmJIgdZIEyReeR6cKdS/Qf0lhxdvcIeWDwY5RDx+ih
	hNaJ7mQ==
X-Received: from pfde1.prod.google.com ([2002:aa7:8c41:0:b0:83f:2c4a:9b48])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e88:b0:842:1ffc:55b4
 with SMTP id d2e1a72fcca58-84284fbcdc1mr620204b3a.36.1780437368298; Tue, 02
 Jun 2026 14:56:08 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:44 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=1543;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=L7ogU8losQ0qpIb9WkPmejB/jf99wccvfK1O3XZC+fU=; b=mJlrN/uELijxS3oSODYirh2cPSOXjWPWaEt54M4JmmDGGXz9+ycPvbHqL2O2MpPVcM6A3OFJ6
 Nb+TJ/2LXYfArqbI0EbK+iXy8Yktn8BPbCJxnp/bU2rKdKwJHdiTrWI
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-4-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 4/7] mm: memory_failure: Generalize extra_pins handling to
 all MF_DELAYED cases
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

Generalize extra_pins handling to all MF_DELAYED cases not only
shmem_mapping.

If MF_DELAYED is returned, the filemap continues to hold refcounts on the
folio. Hence, take that into account when checking for extra refcounts.

As clarified in an earlier patch, a return value of MF_DELAYED implies that
the page still has elevated refcounts. Hence, set extra_pins to true if the
return value is MF_DELAYED. This is aligned with the implementation in
me_swapcache_dirty(), where, if a folio is still in the swap cache, ret is
set to MF_DELAYED and extra_pins is set to true.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/memory-failure.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3aff0c981fcd..dcc56bedcb28 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1052,18 +1052,14 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
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
2.54.0.1013.g208068f2d8-goog

