Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011837;
	b=qflSdclqIY41vRb6gSvhlXy23ah7NIudBwkKA/FaVYhE6nwYWcle8o/xsnyra8KLsUeg
	 XttDGIchKWFOa6+R7UOTweKXaG4e5AoWXx+nAXsOKhdQFnKQ3e5sd6uNzO0oTwlgEn/L6
	 yLqdX5fyAuIjEb5gF2cmsnHN4gzPMG3w2Lbw3Xs3g7FVrjXDGJgLYsRZFCfOhMmUOBnD+
	 N/3IFDlOAX+RVKFRIMeOqMXJnO14nKQ3W6obvpNzbABH0J8JnBuj6aFizaVgyEtMIYVDN
	 1VLqIWOYASXQx78tcQ6GeNQrzoaaEDUOOyfP83RW0ij2bY36km8vTe3x2xpDnPFGnZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TL9FInk1lsYTO6u3AurrE+L/R7/5SJZwcNTYD3x07NY=;
	b=Os/KgAg5KwRey06MtFU2i8SG4V4oqJvh3w27rWw30nKxSFBOa4Qv39y/uyc/f7OUIVq0
	 o7I6fArSrljmrdcUvm0QcHX5oCLlFm7/KmuM3hQz3Dmbr6FStIggcKl8Kk32ptO8rrRgy
	 sFIWttm7KjNYToUbfACFJy5n5dN+oAAWBKKK4LSDERBciv/n1zsmDDsJQ8XLh5qOyFRfI
	 oCERfojmzi5m0bh8AhxsZIbX3f9X3ogeq9WBnucxzQ2mnZMhBggje/gZmSW0eTJx/h5FX
	 eMKCmjzQTr7lY2iNRJmz6OqStnigWWBWDJ1mpF0twLJQfyCdDa2jz80SGAsXM+MO6jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dThzy8Ic;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2731606BFFF;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dThzy8Ic
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011836;
	b=ZP1GUijFtEzbidW4eUgaqyLm5ucNpqMmUOJi7TCzBnZ39BeWVOSUDXUp/Jg7JS73FB7v
	 01idXuvKrzOnpjHIBH62F7OSbk2xtq1V4PmfhVLwphSmAsHXCzsSBWyqCliwf7fm04a83
	 Zh/Y55J8y2W5XGCyM+epft25mxeUk8lrI5MexXU9uLJgm+8oBX0ILLSzu07Dv+9iMeIeS
	 hPEWN/RfRI8YPuu2d102Ur5QipyXsKdorsjzsB8HRHaTjgxJSWIyU4OkVHGuT0Cd0W/AT
	 yV34TKgSKcMZV9PKgS+2jhPJVwry+cIX0LQKiJfDtHj9AgDyHqgp/MaCo3UvwuCvBYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TL9FInk1lsYTO6u3AurrE+L/R7/5SJZwcNTYD3x07NY=;
	b=W8K+THvjvbAqseMWBodDs8O0KgiTQCp7BNoV/H7binfzHUha4ybLFZ2C30m1+pNR2Duq
	 9o/rCvmU1/AEhZFOIsnH4QVTNLvc07MzrL+2NHqGP/xRtzNvSbrIE+ajKRbmsUv92UHhT
	 oqU+ywMVHN0sVXT5YK9aSykQsqpgYQ3Ll8pzCxE0xGxHJNUe7ZVD2hAkr78No1vEST4Eq
	 DbKPk28kc/wUMLjjPvw6Rc4td7HbEec37/EozrYbV/xJLRfo39kYf3OxvpSLvIXelBv//
	 VnRkbyZ+FsXDftB8tWbTbkkvR2NyyvIKS/2sMBR61gua3qm5+qZKhOIgxGeFpmMoCgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7ED001F00A06;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011836;
	bh=TL9FInk1lsYTO6u3AurrE+L/R7/5SJZwcNTYD3x07NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dThzy8IcI6ehayDyxI0zAuDMyzNm9+BOR8wBcfTFFrYX5cZw5H1ZBdV4h5dRpJcy/
	 YIwfWJE+OlTgLbzy3AZiR3UqB97qWvBB8GW74sedi/d6ZOUYKY+liPVngLYubO5xzr
	 r512JhuuORdUSLqKGIYZPWxYNCGEkuut4E/mVqEtj7fVTlwQ6k7MEJ+bK6JJeXCRVA
	 gVjYTv+0a2i82UvSjxm0X0kuTVDibo7foo744UjUxt+xmwdttWSiOwyA0IdGVvtpbO
	 xeyO3dsNDrmaa3V+eY1dt4xXjgUVRegswkDkqwQDulMBw9IO7XBqaYIlHAZDNrStce
	 poGxkKI/lkKrg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E06447A18;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:41 -0800
Subject: [PATCH RFC v3 67/88] vfio/pci: Implement lookup_pfn_range provider
 op for guest_memfd
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
Message-Id: <20261106-gmem-alternative-providers-v3-67-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=4149;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=kj53wX6TjCo3Ls7iAf/tE3qQ5I1YbpBFtjSmhsKoAw8=;
 b=UGqcrAcsVv3SrllNwFHYRvuMS7F/yXTwffU/cd078QBJ78/flhmGFZuIuSDz1BkYLHrR2J02l
 9Cn3sq8yzYtAYcXlJUg+cZzJjY4YvshyegR2hh6MuqaBiUkKqmjR6Fn
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Mappable PCI BARs are placed at sparse 40-bit VFIO region offsets
spanning 1 TiB per region slot, while unpopulated BARs and non-BAR
regions past the standard BAR namespace have no backing pages in
guest_memfd. Without reporting contiguous backed and unbacked extent
lengths, guest_memfd conversion and reclaim loops across sparse region
offsets would step one page at a time across multi-TiB holes.

Decode the 40-bit VFIO region offset to report contiguous extents:
- When the offset falls within a mappable standard PCI BAR, report the
  starting physical frame number and the remaining page count in that
  BAR.
- Otherwise, report the hole length up to the next mappable standard
  BAR, or to the end of the page-offset space when no further mappable
  BARs exist, so scan and reclaim loops skip multi-TiB gaps and
  trailing non-BAR regions in bulk.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci.c      |  1 +
 drivers/vfio/pci/vfio_pci_core.c | 42 ++++++++++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f42422c1b7bc5..6f28f1ffbad0e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -172,6 +172,7 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.gmem_attach		= vfio_pci_core_gmem_attach,
 	.gmem_release		= vfio_pci_core_gmem_release,
 	.gmem_get_pfn		= vfio_pci_core_gmem_get_pfn,
+	.gmem_lookup_pfn_range	= vfio_pci_core_gmem_lookup_pfn_range,
 	.gmem_check_set_attributes = vfio_pci_core_gmem_check_set_attributes,
 #endif
 };
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 2b29d0ec6a0c9..a9274d95e9066 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2829,6 +2829,48 @@ int vfio_pci_core_gmem_check_set_attributes(struct vfio_device *core_vdev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_check_set_attributes);
+
+int vfio_pci_core_gmem_lookup_pfn_range(struct vfio_device *core_vdev,
+					pgoff_t index, unsigned long *pfn,
+					size_t *nr_pages)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = vdev->pdev;
+	u64 pgoff, bar_pages;
+	unsigned long bar;
+
+	bar = index >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	pgoff = index & ((1ULL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (bar < PCI_STD_NUM_BARS) {
+		bar_pages = pci_resource_len(pdev, bar) >> PAGE_SHIFT;
+		if (vdev->bar_mmap_supported[bar] && pgoff < bar_pages) {
+			*pfn = (pci_resource_start(pdev, bar) >> PAGE_SHIFT) +
+			       pgoff;
+			*nr_pages = bar_pages - pgoff;
+			return 0;
+		}
+
+		for (bar++; bar < PCI_STD_NUM_BARS; bar++) {
+			pgoff_t next_start;
+
+			if (!vdev->bar_mmap_supported[bar] ||
+			    !(pci_resource_len(pdev, bar) >> PAGE_SHIFT))
+				continue;
+
+			next_start = VFIO_PCI_INDEX_TO_OFFSET(bar) >>
+				     PAGE_SHIFT;
+			*nr_pages = next_start - index;
+			return -ENOENT;
+		}
+	}
+
+	/* No backed standard BARs remain at or above @index */
+	*nr_pages = max_t(size_t, ULONG_MAX - index, 1);
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_lookup_pfn_range);
 #endif
 
 module_init(vfio_pci_core_init);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index af74766d7c90a..b6e2fb93f9500 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -178,6 +178,9 @@ int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t index,
 int vfio_pci_core_gmem_check_set_attributes(struct vfio_device *core_vdev,
 					    pgoff_t index, size_t nr_pages,
 					    u64 attributes);
+int vfio_pci_core_gmem_lookup_pfn_range(struct vfio_device *core_vdev,
+					pgoff_t index, unsigned long *pfn,
+					size_t *nr_pages);
 static inline void vfio_pci_set_bars_available(struct vfio_pci_core_device *vdev,
 					       bool available)
 {

-- 
2.56.0.455.g6c5a503b38-goog


