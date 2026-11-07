Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011829;
	b=kDTBFOcP0Yh4YiBWSpx3INE1Q2FM1gTks9kzd7SPjIJJJJq4LCnvnbkMGs38tPDQ6EJF
	 wF//VfqIVf7KGqtEdtHzNbSkOA9AQgg5fLpVJCNEDs8fn4QmI28W/P+r3TZLITT9GBSRn
	 3hX5eq/tlgZoozpr47BztDzFU7dvFYaFZi0HeECnItbjvxscmCc6yw+SrNpfDKpns3BaT
	 DopbRxtgZ7mGBi2FyGDg8tPM0TTPn57MsUswwTwMjYcYxIaQH6d1kNy0P6ckdKLnIsdgl
	 0Uuy8bOT4S+lYsgwWjAHGglFZxFHs1iTwyagnYTstoX0CvYzaCF29BNNOVarlJSue7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011829;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T+0034Q+vLhSxIDkPck3Phww0JG3mGk6pxdft35/zyg=;
	b=lBDd39IG4h0G3feUlu6/ZdlBj3D9ToMfxXYqnLj6wmj0u0Z9G4wZ9sgwG/Vr4BmfCIFZ
	 K/mbzpg8fc+zq43TjyKgORdDIuIoUtt8av8kU0XA0uaFNIfmaTX8zkuySgaqC7mhh6LmA
	 RWgEw2WJHSvmBV+DniKbvVR7gQ1UGS1oqzifzLVCKBaKuKkM8seJyJXcNCF+GIPUFtlHe
	 RZwBH6t3oWLW0yWiY/Y69jCXQCbI6mnDVYYDzixuUt11jdlOgLMtYQYha+t20oe8unOLz
	 DgoTcN0shx/1cos3Gt7Efwk1FXhdAZErSu6eBJpznL0GWIiPzaipxy9RdC6B86FGfVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgoKy4Tv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2FD606EEA3;
	Sat,  7 Nov 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgoKy4Tv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011829;
	b=AEnw2vN+ixrlNHhD/37JaPq52CbWVOy9bDN+XmV3GrxatcwNthnh7xmQpJCovHW5PEwY
	 Gek/p/c92LtqrQjYfD05HWrhUb/DRy4Cn4TT6Q9d3F49Ccnl6sUJADryaYSjELE0KMYWr
	 /woz4GiAuaXl8aOzv7ku+4AOvsqCR/g7V9nbs+sKY5da42iBwAYZ4rxUZUJ+2LO1tfGW3
	 5B+K14/wg1RekVJxqYeQawiCnZ33XimSV5RX077buDLJnUhv5mbF8z8BPn2H+e5G3qY6A
	 sqh2dITtVG34eJzflMaWiQ3kNXOFWw33Gk4mUQWiM15jKNMuItaRLhYlHabgZj4ieng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011829;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T+0034Q+vLhSxIDkPck3Phww0JG3mGk6pxdft35/zyg=;
	b=DIWmCa4OF6hSLaffpyGcMnEbGOQNIEMzXyYUY+ADaQWuTmginD4ANC11gvaNWoe33cea
	 hJq/sCh2M4TEN+xt0SKHeuEs7PZNcD2r6Sq2N2R630n7/1t7Y9h11qs7hk4I5gpDQ+5i2
	 RMz1jYDLt1+6KEmjT53yu0tHOcT5xbDX7zgXrSMSRaqD02GzBUNamjJfaojYbHf5dn/Ni
	 NkNVEAiVOB2Wq9p+TAq8FaVNEfx30U0dyXUDF7db2GEQ4Fspcd9I+Gd5i+givK+jttkU8
	 TaN15vcT4HRCLxMiljAKVDzO04Ghgkt71sWLM+XNqiJdAc7UqL/JSvEswIg3jJz8f7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BAB1C1F00926;
	Sat,  7 Nov 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011829;
	bh=T+0034Q+vLhSxIDkPck3Phww0JG3mGk6pxdft35/zyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fgoKy4TvITffAazAX04eGNnTcVLhQ7ea6jCXz4324GrD7aPY2bOPHCHOtn5HlKPw0
	 3VVOSIe5RoUad97uaWXMiLxFe2RW6ZbB+RvKQtxVF0KMxHBGnbD12JEk+y8+XwRBzb
	 MbhYbt/dRUot+Ieyl8s+xeM5bjfmpbDRCGohlSm1uh6FufLbu8lUz5JCV/cJNdtm8J
	 htLZMkOC+zS+7QCEVOGECmoZIRjyF79umhyJv5v3DTkLSTrFtaCUA0y/CjKMmxg9Hz
	 lyqSjOWAQj64Zdk4drvCT98nFoTSgiM39D1XCeuZ2TItsDzRHbrwN//UYX7eqiGGqr
	 FgM4Y83/FhAMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99172479AD;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:13 -0800
Subject: [PATCH RFC v3 39/88] KVM: guest_memfd: Support put_pfn_range
 provider op in PFN mode
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
Message-Id: <20261106-gmem-alternative-providers-v3-39-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3807;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=4/hbHbxMiZ7tJ/EDsUOTijR3o3N5MOrwP4iwQrovXOg=;
 b=wEgX7S15CuxNocEJ8imeNb1DKOtdXWIeo5BKhw7JB1HIucbwA5tWqkgNHuEBrNHN9EmXUaOGf
 qC33A9oFGreC5TF8gaEGBO+NelsJof7bFPo9Hm4/kvO1bco1qCxhRPQ
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When punching holes or destroying guest_memfd files in folio mode,
folios are truncated and freed, allowing the backing filesystem to free
or reset memory.

In PFN mode, memory is not backed by page cache folios. To inform the
provider that a physical range has been released by guest_memfd,
introduce the .put_pfn_range callback to struct
guest_memfd_provider_operations.

Invoke .put_pfn_range() after kvm_gmem_pfn_reclaim() during both hole
punching and inode destruction, passing the file index and page count.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/guest_memfd.h |  7 +++++++
 virt/kvm/guest_memfd.c      | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index e965aeca061a6..697f8f8c9b0ae 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -44,6 +44,12 @@ struct mempolicy;
  *                    starting from @index that have no entry. Return a negative
  *                    error code on other failure. The provider must define
  *                    @get_pfn when @lookup_pfn_range is defined.
+ * @put_pfn_range: Release a range of PFNs previously obtained for a given
+ *                 index. Called with the exclusive filemap invalidate lock held.
+ *                 This indicates to the provider that guest_memfd is no longer
+ *                 using the memory range. The provider does not need to ensure
+ *                 that backing memory is present; if backing memory is not
+ *                 available, the provider should skip the unbacked range.
  *
  * Used by filesystems and device drivers that provide memory for guest_memfd.
  */
@@ -57,6 +63,7 @@ struct guest_memfd_provider_operations {
 		       int *max_order, u64 *pfn_attrs);
 	int (*lookup_pfn_range)(void *provider, pgoff_t index,
 				unsigned long *pfn, size_t *nr_pages);
+	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
 };
 
 #endif /* _LINUX_GUEST_MEMFD_H */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b46907b480138..501c3e250fc98 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -177,6 +177,13 @@ static void gmem_provider_invalidate_folio(struct gmem_inode *gi,
 		gi->provider_ops->invalidate_folio(gi->provider, folio);
 }
 
+static void gmem_provider_put_pfn_range(struct gmem_inode *gi, pgoff_t index,
+					size_t nr_pages)
+{
+	if (gi->provider_ops && gi->provider_ops->put_pfn_range)
+		gi->provider_ops->put_pfn_range(gi->provider, index, nr_pages);
+}
+
 static void gmem_provider_release(struct gmem_inode *gi)
 {
 	if (gi->provider_ops && gi->provider_ops->release)
@@ -438,6 +445,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (kvm_gmem_is_pfn_mode(GMEM_I(inode))) {
 		unmap_mapping_range(inode->i_mapping, offset, len, 0);
 		kvm_gmem_pfn_reclaim(GMEM_I(inode), start, end);
+		gmem_provider_put_pfn_range(GMEM_I(inode), start, end - start);
 	} else {
 		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
 	}
@@ -1730,8 +1738,12 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 	 * Skip if the provider was not yet set up, as iput() can reach this on
 	 * error paths before provider_ops is initialized.
 	 */
-	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi))
-		kvm_gmem_pfn_reclaim(gi, 0, i_size_read(inode) >> PAGE_SHIFT);
+	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi)) {
+		pgoff_t nr_pages = i_size_read(inode) >> PAGE_SHIFT;
+
+		kvm_gmem_pfn_reclaim(gi, 0, nr_pages);
+		gmem_provider_put_pfn_range(gi, 0, nr_pages);
+	}
 
 	gmem_provider_release(gi);
 

-- 
2.56.0.455.g6c5a503b38-goog


