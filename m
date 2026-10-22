Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711670;
	b=LZOdUeS01OaB+HkMiQfFhYYAdq15SsCpii5uCzSlwTnLOuPTZdEnjVYEOSnwzbwlQacl
	 w3ZMwBpf4XFaKVIqfwk56X98cJvsUbpcDw8dTKBFkcs/Aurwf/TjGRJppsjitNK7bB2oX
	 qPthla3QGd1eGCMtjxYMFXmQUx3J5L61lrdcmTkW/zligzHjD4l7R2+kt7esipumtUnwp
	 kMUZ+FXR7NMfcEIl4ZMuwe24B/mGfE05E0vbDXb9ojiHSXXD3T0Hx8Mt/KDYAHyJVGOi0
	 z98SkW2rpeJs5b3ZU4A7I9j596T2EYkLNScdQTWGEDfqQWFSrjHmviv62D0hRG4pXnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711670;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c/PcMTlVSiDoElKibJKXS/wLSV8AGDaIx0CeSsAhKHo=;
	b=VcXEGWxcbVG9vLRjck+3wUvjw2VTZ2wPvOROFi4j0ThuEnSzaV8ruJKATRLv5I8wpzxZ
	 Re+mvh2zDUXg5yuPdW1uCDlrhaYrWM0BWJ3O2Zjwn2YMLkvf0XzrJECMaIFtf+I+MFlUt
	 olsx1sGziRGXHCAKrAdTUf1kOgGnOr1yNWCx1q817GsYLeImeSsK6AonE7k29IVMz/MLU
	 8+pey3NIbz/WpD4lOpneVhETKQn2C/5t24AZ+Z8K+S6c9en73sRgfIaygsnbK7+OmEoyO
	 ljxiyZKY8B2cumhnJiWDk+zUARkKWMufoXhzkbYmRitvgTbXmgrIKnczi1eyqh9r4Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQSKULeX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B3606A31A;
	Thu, 22 Oct 2026 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQSKULeX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711669;
	b=OdDnDGzY56DvWwp1T7EniCdmw5xdvE7vJTuSKosrNSp/5AWscd91/7h+sEnwRSj+xTG2
	 a7bCfY4/zjzPnz9SKB9rnpjBDbqAXEf2bj3FeoEC5jj78POiBHpkDTOhVSE2c/5bx1Ou+
	 FvOWuCZ0Pp1ONg0cKVLOQeZ1ZYfdolPZyfWxzFMFOIMkhkFfbW7EHbOTtgMdOtLbWgpBV
	 FEOSSzdVs7TV9vq5uPmMts48HdWOkzMQayTzgwrofTGWrf3Sc8wqumAsStnszzZm2cnLX
	 Uze+yd72D/Cdeyjuj8p1HAjttumFPyB1mmqRAs193fEp2/JG2GWYJ83WzfJHlljjtAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711669;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c/PcMTlVSiDoElKibJKXS/wLSV8AGDaIx0CeSsAhKHo=;
	b=vazLOo4FNvuZeDEN3cla2JHMcyVdZ6JD+Y+Tin39CdAOvsOqAP/LEkYyWBdJDw26TIOL
	 hHDWaTWuRrfEwy3ZXnrLa1wWmDXT4WiSQp8+9kxVw0sxvyNFNrAaqk6+3Q6ocNpfm3gBI
	 yh3Cc3APB7WZTsbFKN/XmiGlwWfK5IFFfp0+EpWAGmUVWKJaP34riVASSgZyoE88UJKfB
	 kp6/8iEM5J0rXOP723hFqFIKJrmOBQSxI9GviW5uoego432m7wKnwN/GEwsFe+jeykCZu
	 29n0m2cDQa0PWZkct19DZ1vazhOD6TmnKxW067AckI4BOesP55OsFtPUc9s7HoSUNjw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D8D641F031E1;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711669;
	bh=c/PcMTlVSiDoElKibJKXS/wLSV8AGDaIx0CeSsAhKHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZQSKULeXnXScbq7el8zdVZpkJ4TsdFH28e0FrTRaOeA5cfWnmSS3QuwU98oDrZxKr
	 FnwxemLVFmqsHggH/zit2cS6iMXxsfeqoX/IUltqaTbPtCWiJKJdbalR93Iu2ps2pv
	 +mrBKDVyE85rlBQhbKd+zp/dzKzlQzjYF7V6DfOEsy4sKR6KCCSpiFOKZi89PTcE2r
	 UpW2/p8pFA5DUxGHo7LO7KWvX24MGBFsESXz7ah8CYy/Y23M0lI5gEPUN+KZu4whjb
	 rNupZnuwugqT1wkU5rYDz773icp7ZX7J6SAzxvxD4h2a4yadhHBEu2B7I4Jau4Q96N
	 edrYiTZY1O0tQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 41C5041FDA;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:33 -0700
Subject: [PATCH RFC v2 01/50] KVM: guest_memfd: Split folio allocation and
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
Message-Id: <20261022-gmem-alternative-providers-v2-1-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711664; l=2189;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=GfiMpI8weIzEfe3dYmoSriDA9qkD3c7kHqz6/C+y+ss=;
 b=hnkT7p+18c3Sr3N7f/u3g+FKFjdGy3FOvIKfYK/1YmHBg8FczOXDkZtiTAqtDKGFzJtjTl5qg
 X9gbb0h7mF2AhytYyzNbn1jwp69oDXywATpu4DdnG1D0luF/0cv4Pae
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
2.56.0.257.gf7497c7d27-goog


