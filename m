Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB163D75D8;
	Mon,  9 Mar 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069573; cv=none; b=umlSadiTvzfiSVkis/Fu/6XLUBQWXYwICrqOb8c72+N+GSqPKr7zKMiVCb1+VD03WhsBT5rQDdnRknIisblGVRN8qln//ba4fHXhVG4H0dKYn7aaRGYwn2VL67zoUNvwAYTbp3/mztnp9kKYy1vDi/8XoTItPGz7R8aRJDKKuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069573; c=relaxed/simple;
	bh=1Tpg8dpXogI43ldKvRVlXnwzZdDW6L9YkP34QCbqGtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxZRi0g26/XX6VbeCUrgn59oxD4JNThGCgGJ6WKyLPPi5yhK29bOmOsuxOv/yQKe82EbCrRG7gjZy700wJMbSeMDWBNTOhvVVoDKC8amakovdBzcvZlLDeO+ORmv2dljRw/65R44w/ad0gtX5GAdg9LtEXLjVhuVfKmuUcSbgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8TGSaQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8TGSaQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70011C4CEF7;
	Mon,  9 Mar 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069573;
	bh=1Tpg8dpXogI43ldKvRVlXnwzZdDW6L9YkP34QCbqGtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8TGSaQ09iR0FrKwfQh/wBeA8JtXPa5xh1Ijd5GD24HH22yWtc+WRIYBBREe/zHoX
	 mim+0F4xyogg6j27YYr6oJKdiXjqBE929wUafl3JTo8XBlu9GK0F3BawY08nMnNnN5
	 +dZqqJk/DQlH12qhxFlRweFgExjYT5kIvUesROaZ4jsW99zDPzXaNBzmbx0Z9pzSya
	 FVcCIb3miryqet2ggbFgd0dGu1BmqGwHdYr/EJT5KzwbLnzwxP6bklbZHFaXUh5xdO
	 wano4BfHvih62oU0ZcLBupR6QdJQT1Qvl6hD0050OGIcjN1HThoOUCGOUqmWope7ZF
	 BXIeXML+1yMnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 3/4] KVM: remove hugetlb.h inclusion
Date: Mon,  9 Mar 2026 16:19:00 +0100
Message-ID: <20260309151901.123947-4-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151901.123947-1-david@kernel.org>
References: <20260309151901.123947-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
to mm.h.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 virt/kvm/kvm_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 22f8a672e1fd..58059648b881 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -41,7 +41,6 @@
 #include <linux/spinlock.h>
 #include <linux/compat.h>
 #include <linux/srcu.h>
-#include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/bsearch.h>
-- 
2.43.0

