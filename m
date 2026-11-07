Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011814;
	b=VMKXJJ2qLgYpZoZExD+Iy2TcnduRyqi0Dn8BML+xNPs7P8UCf/fq5eozpKleiVTgzIyr
	 VIIZRWPTeGfmdLq5CWzB0jKfDMDU23tqS8H85QNATzi4mtU+Fn/SPcAFINFw4YOByQ+ij
	 Wfrtb+AMtJqazbdSItd0Sw6pKzEdQSt7aKsl3fKTF+9S4lCSbZQly9E7HDWxLgkrKbqC8
	 hcCBrT26UnFOgSLJ9fjvHuJzN/ftQ5ThDZaA5vQuJpLD5KG0b4j6onQ8ZvcRkVLsCNw/d
	 HTaUITMardj9TT1bQA4PmwIwepadZ1Ex3iEO1pqE6bYV4eLAyn64K860kr4j+Qcw00A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011814;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LNwul7zJGFsHKwWZpPtjRY0cIC8DT7VRwlkbbh/D6mg=;
	b=CrASbvb5DYb084M6T9k6sNajDEWSZSqV01/rDvRZA6901qYsV2NElgdOCvNlf3ifwdBA
	 ftw8HfNKJ2NihPx2EiH5JtHvcNMiSgiYnsiFUTuRrVD4JPtDgTKwFtrDyjd97YRB69Do0
	 8OIFOAYhbNpLKEjJrveJvUT99Dm8GLIJy8vOFEsB8QatPT90zuef6a99mdWnvglYMTc8u
	 mvetgSja5W9TxXTUC+o2KuQ75JVRlfmIhJlXhlXG0RAkHktudHqoJSqrNJHGAb591sX+I
	 hlF0wpyVF4OdP8hkKxrzcPb4+q6WFFHfnoYASlBFRijLhJ6QHtxRcNVhTu+WJ2RPuyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsK7Pw9l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626D606A32C;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsK7Pw9l
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011814;
	b=Big+S11Te8xov+xmYlWTXp7PJetY3k1BSWJCbvOIfCUbZqmPMB7HGqOhrSEV9LVrJw/P
	 9hnb0ce22piYHsXM823BeGFKpxJRzSrB3kjNaA3K0e+3+LU+Z7gX4TohF7eD2JTOPEzkm
	 Fp15skEMYQ/2lttfXlx/BNauSrN/vX6nmYMSgB508ijNL8Q4XN3fFLtnyYPYVdvOtleX+
	 VpvYF7FWdJT6jLdAG0/i/DDUMII+hdUTjOQhTW/rNMtqxn/kN3EBXniSctOnHsZL0HmLW
	 HjOcHnIkUFLOvyhydBFDUUZDqx+1+5XP3dxB8MfCncBMO+kxgZrIKF5f7WKxsip5RBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011814;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LNwul7zJGFsHKwWZpPtjRY0cIC8DT7VRwlkbbh/D6mg=;
	b=jJ5VuJc5bSU9iLHbyLa7m8IeOxwMYTgC0WDx0Hp7GqRfzoQvtwr0d3bKLBO+tM7DILQ0
	 IxRC334GfEc/UzWbybDXAEU8LeexzAnpOZ2bMDIboG43jfIGZEET4FpWgzY1UhLbbeHNo
	 k/jU9jB31L2sDPttu7nIJlWaPOz858Ml4NQw9HEBDvzYgejMBsq29pun+pDPA25ZnWtfS
	 LLS3Eel/edGath6rJv6VNClJXAnnCRPFaq0fnfFg3eiKn7EptnrnVfbgg/XPA0xgHeXgB
	 h6oXRY95vKJWoLbr92CHNul/Ai/bxSlVTOsSXaiafz9/gS8j22ffP6mubAdCN/Qzrgw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 54DA31F0089F;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011814;
	bh=LNwul7zJGFsHKwWZpPtjRY0cIC8DT7VRwlkbbh/D6mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DsK7Pw9lfCuc6GlTfLe0AW30dYomSQ45g8VkRcyLIlW5ESJDtt9JHYfJsxY5nK3MT
	 0GIgpC/2u1B4O1jh3WhE6zVlBGmkka1ea2Bux6CNz96r6hsEtjUNqmjpUboDw7dnRl
	 qwNxSDP6NMSYET8iYA5UsUiQ1scFHjGp2/6UCHl+jJwKzoBPb16AwECoA8FFlDE2YQ
	 T3piPyAIlhCHUmlvCi9QPDBMi7PA/wmQhUhvEqoHbDiiazSNy8uhxwO2BK6Z8dqxun
	 VdfKr9iHBMS/waqWy0ERnCSPjZYja5rmFi2Tlqi9D9zFLks/oXLkbOxJvIE5/HfcyC
	 rnVneKQfxH1Mg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BD8D44790F;
	Sat,  7 Nov 2026 00:36:52 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:35 -0800
Subject: [PATCH RFC v3 01/88] KVM: guest_memfd: Split folio allocation and
 insertion in kvm_gmem_get_folio
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-1-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2189;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=o3ab3dp1L8d6gPAYkDQmoexjLd9lqXL7N+1eNWmNlKs=;
 b=XgrUtCJ/aWRVJB5VTE6gkAa9uuRn419O1xaO9zrTU5VolBTKlyZwWbNUC8vSaC1I22UUI+y/I
 lnN+VrNouelC2/BHQOpFwyUaGjqOIQU9E0vaik0bSRmm2KnM3CY6qQj
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Separate __filemap_get_folio_mpol() call in kvm_gmem_get_folio() into two
distinct steps:

1. Allocating a folio via filemap_alloc_folio() with the NUMA policy.
2. Inserting the allocated folio into the inode filemap.

Handle -EEXIST from filemap_add_folio() by retrying filemap_lock_folio()
safely to manage concurrent insertions.

Decouple folio allocation from filemap insertion to prepare for supporting
other memory providers.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 93f3d29d5751a..f865fa0e46840 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -131,7 +131,9 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	/* TODO: Support huge pages. */
 	struct mempolicy *policy;
 	struct folio *folio;
+	int r;
 
+retry:
 	/*
 	 * Fast-path: See if folio is already present in mapping to avoid
 	 * policy_lookup.
@@ -141,10 +143,19 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 		return folio;
 
 	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
-	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
-					 FGP_LOCK | FGP_CREAT,
-					 mapping_gfp_mask(inode->i_mapping), policy);
+	folio = filemap_alloc_folio(mapping_gfp_mask(inode->i_mapping), 0,
+				    policy);
 	mpol_cond_put(policy);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	r = filemap_add_folio(inode->i_mapping, folio, index, GFP_KERNEL);
+	if (r) {
+		folio_put(folio);
+		if (r == -EEXIST)
+			goto retry;
+		return ERR_PTR(r);
+	}
 
 	/*
 	 * External interfaces like kvm_gmem_get_pfn() support dealing
@@ -153,7 +164,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	 * to be updated for anything otherwise (e.g. page-clearing
 	 * operations).
 	 */
-	WARN_ON_ONCE(!IS_ERR(folio) && folio_order(folio));
+	WARN_ON_ONCE(folio_order(folio));
 
 	return folio;
 }

-- 
2.56.0.455.g6c5a503b38-goog


