Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E53793AB;
	Mon,  9 Mar 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069579; cv=none; b=q3vzSC7hRAhqHD7W3Z5yyf4YCOarMCysVGUcBDYnC0iD4gRX8YYhe8nNwv0iYF8vR5ptmZDEDI9to4xMQ0RQi2m1XHbyJXrlF9mb8JNMvSj+WGWpUAfaicsKGCDhgsWRZ6IdadBGef8A+bZHafuFxKTutJDiIvCya28NjqdcQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069579; c=relaxed/simple;
	bh=q/OK9MenvejDughLrSZOznakkVUTLmx28+Vi6bUHGJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwg8yfoO42r6AG0kWeOKxYTGJ4JKTrh87zD2MGC3zQg0MuVWTUa/13wf2A0GFLGyUKrHC24kOOfJNHCVo8w/m6vNCtiEK/IzoTk0NrRGVLcYCXcQhSGtjEKxrPZCh9wHE9exNpbK7JnYCnjd2HnWWJ9YPlQhlQisL4T2nT4rJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ADz3X4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ADz3X4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68A3C2BC86;
	Mon,  9 Mar 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069579;
	bh=q/OK9MenvejDughLrSZOznakkVUTLmx28+Vi6bUHGJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5ADz3X4fdfGQ+QEhi4NobrQcvdh+sIqHuN1lR9eH1IXLKh4ehimkDrH425UOshs6
	 cvqoazVhrxU+UDeYiyGlmsmBOHdE/Gqhy1joKiUvwHgZOeKu3MIbzsRI3rNSFZ0pOp
	 0X985TzMHB6ViaeHWx2+Stsi4ao7uIV1Fx09Hz3kQCklf53GBAm6F+oQIcmqY05hR6
	 w7rzTfbsry5MDrFfNLgFpeT0QH0ZSWVceRoG9a1pDHeUkO2cUruTyZ7lxIAA3UuZ7U
	 cNb2r8U+cFd3WnW1Tn+i6azBCX+almkPPgh4gl4k0F7UXbmkov6JCACpkkg5tOQtHp
	 v9hC3syVh165g==
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
Subject: [PATCH v2 4/4] KVM: PPC: remove hugetlb.h inclusion
Date: Mon,  9 Mar 2026 16:19:01 +0100
Message-ID: <20260309151901.123947-5-david@kernel.org>
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
 arch/powerpc/kvm/book3s_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 08e5816fdd61..61dbeea317f3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -36,7 +36,6 @@
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
-#include <linux/hugetlb.h>
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
 #include <linux/module.h>
-- 
2.43.0

