Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0D2652A2;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383851; cv=none; b=s4Sqt48ec1WUkRIxKFxzGqEhzwpICbj1/Hisifyq5TRQK4thyO5Qr5zBoXRp1eWTo12V7OaUE2aPx2TrOEucxLX1N430NEXMtpX6dS1uHy3UnZeqBW19S6Uwg3LRH6Hv+HGFqNWW/izbOwD7rvcX7gFv2MglqJcTTLUou6V2Mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383851; c=relaxed/simple;
	bh=QZuGgIfedRt6E2ddYyTGPhayZrDoNOZ8hXwJcvPCbUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wa73HQ6iAhBQ0UBQjFE1esE2HSSIg60ruhdl//1s8fpTpObZausAWI+NBCbgTr178t44OzUxC5PQJgWgw0apil+H8Cdre/fsbfEjG1HoTsZ0HpeeagE5h6D/eNYr+RFZMx1qEzxgM3Van/EhjFjQtmoZpgJlkKSk7S0RWoGMTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL4wWBaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL4wWBaL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62F1CC2BCFB;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383851;
	bh=QZuGgIfedRt6E2ddYyTGPhayZrDoNOZ8hXwJcvPCbUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SL4wWBaL0A1NCCKm2k6XsrkSbrdgIbmexUyMwPhGGQMRwe6vPntwE56QPfUbwnh/B
	 ExCh7c/0XGy5dEnoIIb4HCLSF0azYMFTvvNadXW4wMHj44imX8TUUu/mrF9iiOrcSW
	 3pYxIpiizcU9xtyVnS0CsLsi0ETuDadTPWeCbYlaHUDDSnFhTrxpQQwTeGd09QPhcT
	 1tEKSF9YjCaXhwNtNgIS8Q9qMYGGWhmn08/fzjY/0UqeqvB2YiAyOINVwq9BAcGh6F
	 JDcqrfeBCKxFfU38exIy06kH7sKDi1YN2cjZzC7Xo+IfytRWOjSiNaZBbxvG1veCAe
	 pAZTGzjAWkqyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E83C9830E;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:50:49 -0700
Subject: [PATCH RFC 02/17] KVM: guest_memfd: Support provider folio
 allocation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-2-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>, 
 vannapurve@google.com, erdemaktas@google.com, jxgao@google.com, 
 rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
 tarunsahu@google.com, pratyush@kernel.org, fuad.tabba@linux.dev, 
 Gregory Price <gourry@gourry.net>, David Woodhouse <dwmw2@infradead.org>, 
 yan.y.zhao@intel.com, michael.roth@amd.com, suzuki.poulose@arm.com, 
 Christian Brauner <brauner@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Nicolin Chen <nicolinc@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 aik@amd.com, aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>
Cc: kernel-team@android.com, kernel-team@meta.com, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=4521;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=k2wJag3xpkJiPwETrEDU9zeAf8p9w5PDeeJUkL2Wy30=;
 b=owZKCzvSRlsk4pNWUHrAac7TjSqV4V9OZ2vm5pyo4kxj3zk6HBlqYl6Pp0x4cTb4Dcq5IAsvj
 UN0BwPL00V3AdOv5deqq4zfA+D0roElHz1GSsNK5j/d5HO5QLYV9Gc7
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

If this guest_memfd was created with a provider, use the provider to
allocate a folio. For folio-based providers, using guest_memfd's filemap is
better because folio->mapping would be guest_memfd's mapping, and so
guest_memfd can handle anything that makes decisions based off
folio->mapping, like memory_failure().

Going along these lines of using gmem's filemap, passing gmem's filemap for
the provider to insert into seems awkward. At least for tmpfs, the
insertion function does a lot of stuff and assumes stuff about the filemap
being a tmpfs one (completely fair). I think it's better to use gmem's
filemap and do charging (memcg) and inode accounting according to
guest_memfd's rules though, hence insertion is done within gmem, in a gmem
filemap.

Going back to folio->mapping pointing to the gmem filemap, we could have
special memory failure handling for guest_memfd folios too, if there's some
kind of central registry of all PFNs belonging to guest_memfd? There are
other usages of folio->mapping, but gmem doesn't participate in those since
gmem doesn't do swap, etc now.

For non-folio-based providers, here's my suggestion: Don't provide
.alloc_folio(), provide some equivalent callback for pfns, track pfns in
gmem. The provider can force gmem to return the folios anytime, the
.attach() can be bidirectional.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index a13445c26d9d6..5ac2d558c8dd8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -3,6 +3,7 @@
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
 #include <linux/fs.h>
+#include <linux/guest_memfd.h>
 #include <linux/kvm_host.h>
 #include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
@@ -35,6 +36,9 @@ struct gmem_inode {
 	struct inode vfs_inode;
 	struct list_head gmem_file_list;
 
+	void *provider;
+	const struct guest_memfd_provider_operations *provider_ops;
+
 	u64 flags;
 	/*
 	 * Every index in this inode, whether memory is populated or
@@ -50,6 +54,16 @@ static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
 	return container_of(inode, struct gmem_inode, vfs_inode);
 }
 
+static inline struct folio *gmem_provider_alloc_folio(struct gmem_inode *gi,
+						      pgoff_t index,
+						      struct mempolicy *mpol)
+{
+	if (!gi->provider_ops || !gi->provider_ops->alloc_folio)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return gi->provider_ops->alloc_folio(gi->provider, index, mpol);
+}
+
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
 
@@ -128,6 +142,7 @@ static bool kvm_gmem_range_has_attributes(struct inode *inode,
  */
 static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
+	struct gmem_inode *gi = GMEM_I(inode);
 	/* TODO: Support huge pages. */
 	struct mempolicy *policy;
 	struct folio *folio;
@@ -140,10 +155,29 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	if (!IS_ERR(folio))
 		return folio;
 
-	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
-	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
-					 FGP_LOCK | FGP_CREAT,
-					 mapping_gfp_mask(inode->i_mapping), policy);
+	policy = mpol_shared_policy_lookup(&gi->policy, index);
+	/*
+	 * TODO: Refactor the internal PAGE_SIZE gmem could be an internal
+	 * provider with internal provider_ops.
+	 */
+	if (gi->provider_ops) {
+		folio = gmem_provider_alloc_folio(gi, index, policy);
+		if (!IS_ERR(folio)) {
+			int r = filemap_add_folio(inode->i_mapping, folio,
+						  index, GFP_KERNEL);
+			if (r) {
+				folio_put(folio);
+				folio = ERR_PTR(r);
+			} else {
+				folio_mark_accessed(folio);
+			}
+		}
+	} else {
+		folio = __filemap_get_folio_mpol(inode->i_mapping, index,
+						 FGP_LOCK | FGP_CREAT,
+						 mapping_gfp_mask(inode->i_mapping),
+						 policy);
+	}
 	mpol_cond_put(policy);
 
 	/*
@@ -1334,6 +1368,8 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN | MT_FLAGS_USE_RCU);
 
 	gi->flags = 0;
+	gi->provider = NULL;
+	gi->provider_ops = NULL;
 	INIT_LIST_HEAD(&gi->gmem_file_list);
 	return &gi->vfs_inode;
 }

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


