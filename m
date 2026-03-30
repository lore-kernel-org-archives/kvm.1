Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7293B8D48;
	Mon, 30 Mar 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865561; cv=none; b=a1kCXz6LO1UWEidXAPUSDcrmn3tn/FFr5JdQlbhCNaulKOjF/+8WCbRqwCFVulKexPi9mFAikDqSQWK7fbqMPdNezCVxgC9H/mc3rutsLhs/RJY2HZzXgjRB8VYI14LVqEnGGrd5bYBLyp1ZGC9O8S58RFEpwZsV8eZvahKrOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865561; c=relaxed/simple;
	bh=5vaQGQBc3neyldkli11Rg6Y+SDtyLj7BMfixF4/GPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2BNAbgaWuQWrUmUc44iMqrZo7y1a2beLcY4dCEp0U4utBJf7sZaEM+hS/LL2/NGJ0tsp8fHsE/nOjBMtUYIhx+d8qIJn2F3inTYMrKA+GmQWDuPl4NZv0rdB1Qw9Pr3uF0HmWFnO/limTbiXBsnhrBa23e9owsYk0GaGlrOnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz5P/Ehl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz5P/Ehl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C3C2BCB2;
	Mon, 30 Mar 2026 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865560;
	bh=5vaQGQBc3neyldkli11Rg6Y+SDtyLj7BMfixF4/GPSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vz5P/EhlcbGrf+EmyrZRJlmlJMQol7XOzQNEor1Xg8Btoz8JyeEVcJwg+zd3jjia9
	 79uY/smDhLCPcI2vi/sG50tuN1FQiIJ5GJEFQZFBRzB/UNYlGVAxij9dSHQvV3kn16
	 UrQNH9lW2NvzWOT4w/05YnP6ez3HMLGLcwuNdxcv8+SXpC4Tt7TPIf6aUcQR+L25Wk
	 z02GZvjWjqt/TTkKbwfaurOmdXFBzGou6+Y4yglTGV6i/CqRIqc37p4nniK0sH/Ytw
	 6mGvTJTgBidX783DjCgVKlho/aslUpIMMPjjG2rFpGM3akpXKXCB1ht1u/v3+8bRPO
	 BpF9ymuGtg1bw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 11/15] userfaultfd: mfill_atomic(): remove retry logic
Date: Mon, 30 Mar 2026 13:11:12 +0300
Message-ID: <20260330101116.1117699-12-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330101116.1117699-1-rppt@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Since __mfill_atomic_pte() handles the retry for both anonymous and shmem,
there is no need to retry copying the date from the userspace in the loop
in mfill_atomic().

Drop the retry logic from mfill_atomic().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e672a9e45d0c..935a3f6ebeed 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -29,7 +29,6 @@ struct mfill_state {
 	struct vm_area_struct *vma;
 	unsigned long src_addr;
 	unsigned long dst_addr;
-	struct folio *folio;
 	pmd_t *pmd;
 };
 
@@ -899,7 +898,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	VM_WARN_ON_ONCE(src_start + len <= src_start);
 	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
-retry:
 	err = mfill_get_vma(&state);
 	if (err)
 		goto out;
@@ -926,26 +924,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		err = mfill_atomic_pte(&state);
 		cond_resched();
 
-		if (unlikely(err == -ENOENT)) {
-			void *kaddr;
-
-			mfill_put_vma(&state);
-			VM_WARN_ON_ONCE(!state.folio);
-
-			kaddr = kmap_local_folio(state.folio, 0);
-			err = copy_from_user(kaddr,
-					     (const void __user *)state.src_addr,
-					     PAGE_SIZE);
-			kunmap_local(kaddr);
-			if (unlikely(err)) {
-				err = -EFAULT;
-				goto out;
-			}
-			flush_dcache_folio(state.folio);
-			goto retry;
-		} else
-			VM_WARN_ON_ONCE(state.folio);
-
 		if (!err) {
 			state.dst_addr += PAGE_SIZE;
 			state.src_addr += PAGE_SIZE;
@@ -960,8 +938,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 	mfill_put_vma(&state);
 out:
-	if (state.folio)
-		folio_put(state.folio);
 	VM_WARN_ON_ONCE(copied < 0);
 	VM_WARN_ON_ONCE(err > 0);
 	VM_WARN_ON_ONCE(!copied && !err);
-- 
2.53.0

