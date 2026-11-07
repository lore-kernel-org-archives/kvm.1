Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011830;
	b=GX5UylhXksemnJzzyIHevGtyqVuFzE3Oi0ZiFTTFxhupqENYISWY0mzFygox4wooKP7z
	 jX+bonvDZUySAUXqjdgyoVO22Q6hbzaGQNwRFmr3MI711yRNayc3SF6yaf+7Z4X9XqWFQ
	 BMQKn4zLrlk03y2BEFKhT++eNGu1pxvjpEWXBFlAsWgW0wWfMXtKPVbhIP46IWZmx1Lpy
	 aRPvSE3pEw2tVWOIuPjizTgK4V7y6lsBWglrhipf4qdiOdNcMnQ5q1V0O+OXYR4sa2/sG
	 w9ia6tqKoeYFPpQi6y+WL72OXYpa4Z7ieOppQhDKQG5H9aEWbUuTNt4I/LNjtwdSQvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011830;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rjLzWWInJ1U8TF2fz62aIx2q5tPYbfDDORJx558RE2k=;
	b=QJGk1sTd8Icd0+qPuCfGJKtzplRZPZ+h3dMnJzsu3PsEkjAYSHGrZCQL5MR5sTLmtSu/
	 6PDxWBfubyaiC3wrDcgNugVDhmN7PqHlQu4f6ZffgdB6r/t36sBNsiTnkRs55G1BFQqb6
	 v46ESxmEN5GgLRbTWTWqQTb8cbpC4vibqhFHCyIresYL71nxI+nhjcLyyMmjLo1GCdM1B
	 bU/1gxQ28/3T05GSmkaGg+NS32zJHY/Lk1KfkT0OxjF/L8Xx5mbg7N4ZJoRQ8hVR25GIe
	 2mBr2ZjjmNjSJvCKGxdCNLCwGerLir7j03W1i6sfOVP/dgSiIyvgLWQCA/0KzJSqJMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx06axuW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289360A3810;
	Sat,  7 Nov 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx06axuW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011829;
	b=C7FKsclwLFM9aSowd7WCRg9uUQ8OlzDJSCZ+8hcWhGxtz8+6s3UlwwoXrRoTh9tOIeAQ
	 MifTiHkqT2O8vxcCqNbeFPENQDJb4ItbqZAtxv72HLkJgT+t1S9m6k0dfvnG+jlPQiMyU
	 fKCATjBT+jzTmY2OlibvJBBlMZPMN9anG9emKILJ0EzduxSQFKO1uNA7nugCtmejBg1pz
	 2lBWIaFgWZj5yvOhrMXFin0BY0nE1uqA1I47F9Bai+qZzObXtIC0Gl3WITqm+0YVDw7dR
	 2V+XasMHWxk0UEkKs4TnKITP60I44Z3i0ztxmLZeg3oNaxYmjzE5tcbt8qVBKhrscRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011829;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rjLzWWInJ1U8TF2fz62aIx2q5tPYbfDDORJx558RE2k=;
	b=PHsERMKdHCFmd1dYkEZkIasBKG5//gYUa0QCk/t/+MK2LWKI6GQDMkBPcYyZdPn4UFTT
	 x1kjn3mcIDXAlK4EqPNQ29qOdyLlyl4GG22ZoRynHQGXM3zmVjbHc1KC00r96eDvQDCcM
	 ppc5DZSgOB7Jp2c5F1UJPixI+3ynzUX/GsO1Y0OchHc0XYd30/vSjqMapqjgg03mqUvHC
	 2AkZ2u+aqOxufTgFPJ3m9Nm+MJtzrgqr2bkn2KqNtnShvf74eNm8csQEqLjuIFQ5gZ0ZL
	 SwBtjqlyPVyqdnCToDNlbsBBc0fo9f0RSIQTCuzrB/sEUFKpzj0b8UUhrY8lk8QYwtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 356881F00931;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011829;
	bh=rjLzWWInJ1U8TF2fz62aIx2q5tPYbfDDORJx558RE2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Dx06axuWVvBjwQWD01wbLuyvrByIQitj3VdDqMBCQJlUOmOOBDshjdOV/Dl/4AUWA
	 517ZH+xnY7Smv/DoCuNqqTO6qQREAYpsDVXO8pnpp1hK1hQmGLAQulLKCWIxTAVotA
	 qQyhRx8Q4547lpdI4ng4vm/j+GP6rkBwEkKkIdwxcoafpzLTxZO/9GDZypvRSlHh0h
	 riv4kWS40QkDdBbazqqVOYmAu6swLCw8YtxwTPDWCrc8UaTTHFTOU9Lr0n4RncDR2x
	 vrDyUtiEEe31+80WhTlTD/JBfSruQiT86q2E5PmhDgCpsVDv+9eocLAGiDVAOBkjuk
	 MMCLzvq/AOHBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E761B47986;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:03 -0800
Subject: [PATCH RFC v3 29/88] KVM: guest_memfd: Support getting PFNs for
 stage 2 from providers
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
Message-Id: <20261106-gmem-alternative-providers-v3-29-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=6509;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=fBoz/iURxFiaKiHW6o3O0tV3AmdW7PZkurH7roA66NM=;
 b=vyybW3i/i/YD21sQasMRae7xaExnN65vieEEWqw+lJ/p1p1+n4r85mEQOgsCqmwu8N8q5YxZN
 OoOAe27vstgDcTsfzYcMc4r1aVEhlQpEzraWba6skMkFCPdg8LQ7Bzw
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add .get_pfn callback to struct guest_memfd_provider_operations to
support physical memory providers (e.g. devices, DAX, or pre-allocated
ranges) that supply PFNs directly without folio allocation or page cache
insertion.

Define GUEST_MEMFD_FLAG_PFN_MODE in uapi/linux/kvm.h and define
kvm_gmem_is_pfn_mode() to check for this flag in gi->flags.

In __kvm_gmem_get_pfn(), query .get_pfn() directly when in PFN mode
and return NULL on success (instead of a struct folio *).

Note that .alloc_folio is still required by kvm_gmem_attach_resource() and
GUEST_MEMFD_FLAG_PFN_MODE is not yet enabled for userspace.  Subsequent
patches will update the rest of guest_memfd (e.g. mmap, fallocate,
truncation, and attributes) to support PFN mode before enabling the flag
and allowing external PFN-backed providers to be attached.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/guest_memfd.h | 11 +++++++++++
 include/uapi/linux/kvm.h    |  1 +
 virt/kvm/guest_memfd.c      | 48 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index df2db2a0bae6e..9fdc0bd1a7190 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -20,6 +20,15 @@ struct mempolicy;
  *               Must return a pointer to a struct folio on success, or an
  *               ERR_PTR() error code on failure. Must never return NULL.
  * @invalidate_folio: Notify provider that a folio has been invalidated.
+ * @get_pfn: Obtain a PFN for a given index. The provider must ensure backing
+ *           memory is present and is responsible for its contents, such as
+ *           zeroing if necessary. On success, return 0 with the physical frame
+ *           number in @pfn and, if non-NULL, the PFN attributes in @pfn_attrs
+ *           and the maximum page order of contiguous backing memory containing
+ *           @pfn with uniform @pfn_attrs in @max_order. Once @get_pfn succeeds,
+ *           the provider must keep the @index-to-@pfn mapping and @pfn_attrs
+ *           constant, and the memory accessible, until guest_memfd stops using
+ *           this page. Returns a negative error code on failure.
  *
  * Used by filesystems and device drivers that provide memory for guest_memfd.
  */
@@ -29,6 +38,8 @@ struct guest_memfd_provider_operations {
 	struct folio *(*alloc_folio)(void *provider, pgoff_t index,
 				     struct mempolicy *mpol);
 	void (*invalidate_folio)(void *provider, struct folio *folio);
+	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
+		       int *max_order, u64 *pfn_attrs);
 };
 
 #endif /* _LINUX_GUEST_MEMFD_H */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f4108bf7e3192..6798056f50e32 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1675,6 +1675,7 @@ struct kvm_memory_attributes2 {
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
 #define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
+#define GUEST_MEMFD_FLAG_PFN_MODE	(1ULL << 3)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f0bd90fd9c986..eedf03df12c55 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -54,6 +54,11 @@ static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
 	return container_of(inode, struct gmem_inode, vfs_inode);
 }
 
+static bool kvm_gmem_is_pfn_mode(struct gmem_inode *gi)
+{
+	return gi->flags & GUEST_MEMFD_FLAG_PFN_MODE;
+}
+
 static void *gmem_native_attach(struct inode *gmem_inode,
 				struct file *resource_file)
 {
@@ -124,6 +129,26 @@ static struct folio *gmem_provider_alloc_folio(struct gmem_inode *gi,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static int gmem_provider_get_pfn(struct gmem_inode *gi, pgoff_t index,
+				 kvm_pfn_t *pfn, int *max_order,
+				 u64 *pfn_attrs)
+{
+	unsigned long raw_pfn;
+	u64 __attrs = 0;
+	int r;
+
+	pfn_attrs = pfn_attrs ?: &__attrs;
+	*pfn_attrs = 0;
+
+	r = gi->provider_ops->get_pfn(gi->provider, index, &raw_pfn, max_order,
+				      pfn_attrs);
+	if (r)
+		return r;
+
+	*pfn = raw_pfn;
+	return 0;
+}
+
 static void gmem_provider_invalidate_folio(struct gmem_inode *gi,
 					   struct folio *folio)
 {
@@ -1270,15 +1295,17 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	filemap_invalidate_unlock(file->f_mapping);
 }
 
-/* Returns a locked folio on success.  */
+/* On success, return a locked folio in folio mode and NULL in PFN mode. */
 static struct folio *__kvm_gmem_get_pfn(struct file *file,
 					struct kvm_memory_slot *slot,
 					pgoff_t index, kvm_pfn_t *pfn,
 					int *max_order, u64 *pfn_attrs)
 {
 	struct file *slot_file = READ_ONCE(slot->gmem.file);
+	struct gmem_inode *gi = GMEM_I(file_inode(file));
 	struct gmem_file *f = file->private_data;
 	struct folio *folio;
+	int r;
 
 	if (file != slot_file) {
 		WARN_ON_ONCE(slot_file);
@@ -1290,6 +1317,13 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 		return ERR_PTR(-EIO);
 	}
 
+	if (kvm_gmem_is_pfn_mode(gi)) {
+		r = gmem_provider_get_pfn(gi, index, pfn, max_order, pfn_attrs);
+		if (r)
+			return ERR_PTR(r);
+		return NULL;
+	}
+
 	folio = kvm_gmem_get_folio(file_inode(file), index);
 	if (IS_ERR(folio))
 		return folio;
@@ -1355,8 +1389,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 					       (kvm_pfn_t)1 << *max_order);
 
 out_put_folio:
-	folio_unlock(folio);
-	folio_put(folio);
+	if (folio) {
+		folio_unlock(folio);
+		folio_put(folio);
+	}
 
 out:
 	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
@@ -1384,7 +1420,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto out_unlock;
 	}
 
-	folio_unlock(folio);
+	if (folio)
+		folio_unlock(folio);
 
 	/* Populating pages initializes private memory, which cannot be read-only. */
 	if (pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY) {
@@ -1400,7 +1437,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
 
 out_put_folio:
-	folio_put(folio);
+	if (folio)
+		folio_put(folio);
 out_unlock:
 	filemap_invalidate_unlock(file->f_mapping);
 	return ret;

-- 
2.56.0.455.g6c5a503b38-goog


