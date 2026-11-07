Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011835;
	b=TVF80RXfXq+MCgZFiLA/In78B5EAW3xjLXTOzfvgXq87a109JeIsX4581qUR1jmG0Lsi
	 fh8RsSIBYYZs4uyCp2AEhhlBL29PgpfCdB7cqnyCcc99a4Z+8UyimeAtfAs0nT4SBxgll
	 Jt7iACRpXBNUVF9fhEG3B/4UGbpksKzXF42Quh5JJOoPeb+Ei2Dj1T1Q5gDtrhri9ggC4
	 tMzdkqa6HXCsNrmUSgehlZtyX7oybVNV45kkraJwl2VYOvmSW9PBx7lRphv2ef+zFNzP8
	 wfJvaU7xctZ5ppahqH53A25pxfmHLieTVs6Tgfy++kvtRVyn7dQc/WPh71AL8nREEgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011835;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zJY7JgmUY6kTEuouX8pOKywnDwfciguXt0q9Bu2Yilg=;
	b=hIDsB8eaVAJrwrIf+GtLQsLWUIZbnReNB6t5KToplfRPkPAHbUG0y3+NGRLe2uG90o98
	 Jf0RaHj1Z3PRV6xDe5mi3I3rAYCMK6BHQ/r7/9U5x0HU7LaDtfXGmj+6c290aplzs4A1f
	 S5sgAYHk/2FxHY3ous9Nb4bO/l5lwKLtTjSFZsUl9WsxPTGA5t4w0cVRj0hBBsD3Ahty8
	 bZ/SHIPlPuoyzsqx0HFjRd6Fi5fZtlev2BcCCSfq3pmOE7NZGZ9FgiJLpuw2wL+4cqe+F
	 0ut/41kBh5WLIbjQy0k5rM7KBcyu5YGyfmAJm0NGUKCekut5iVBXhXLfqfwVU7PsC3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4UFVrbJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18260A6F5F;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4UFVrbJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011834;
	b=Lzwke8rtQkHzmfm2D5TO1chfrpon9r2wqYJ4RpcLcWqQIcjYD4ckTllnKUEqLVhssww2
	 qeZBBnKDbRV2detZ4sFdoueoFk7+0YW/ugR7RzfyetI7waF8daDXRAr2Ix2EyA3q7vWU9
	 Rm1pzypGp0FI3q4KTSzhOTYFIchqP8hjwyCqqi9GSbwfqfxgpYGw+QgBSjlG6YBAJjOXL
	 vIU8uD7COxakrLlPjfu2wEV9nxWFDSNQH7OyiMQMUwbysVax5E+Y3eaerSkUPfp/MQAwL
	 SZSLvzuXTzHyxXC36wGNEu9JOsUjPtXBGVkbFx5qSf6dE/ABMECJ4KBz2g1Gk7khcYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011834;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zJY7JgmUY6kTEuouX8pOKywnDwfciguXt0q9Bu2Yilg=;
	b=LnEcD9eWp8XVYgQHdK9N4yXq15wtQQah8yS6d86M6W2ib3G3F0NW8qiu2lbCAR2kOQ66
	 jKY5eXKtMIrOriq5XcZgxTZ1VUcGoe8Ns2ra6jmd9RRQTrgXLdvprOnTNWcnMZ24NTb14
	 7eGj0pLiatnLQUq9gS4s4wj33rgOZ/Hb5nuTvG1PRHC9fEZcjdnrqCnvxIxOBoneK2vFc
	 RT21LREcGJCQWb28hCmiLssyFtOYibMmyaFkSTy61vD7DauP7tYzDe5IkkwUa0Ab3CXVy
	 avhcL6rUafzrVe3losZZQW0X19KGMjtTvobEM7XlYsjpgOvAoVlw42vw8O+HqEzfXng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 019C51F00900;
	Sat,  7 Nov 2026 00:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011834;
	bh=zJY7JgmUY6kTEuouX8pOKywnDwfciguXt0q9Bu2Yilg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=B4UFVrbJvOUKkjPwh59GQzYlHcNAletngx9/LR6/42Ddc87G/AMlfoEjh9/9Lrcob
	 vEj6ePlHz4BzkKPNq46KjizXlxN8tHHbTZ3jjn+6N8KcxPfW1vviujTxBuV6N6G5tO
	 6r4BIZeAOp2Gc3zWAm2MtJ/8cK7mXxEWtffCjZpjVJ8Uty/pZA/u2X+tf7hX6hiZ0D
	 HCpYmRfNKRT167vCF2O47xTaBCs0NMdhLer6GUyC6FHqrj3gRO4syHuEkIAhkp0I28
	 U7jLkVdpf6Kf8UGrEgRqpc9CYqa81NCCpvUxg031q7LVKto77++JivIRpGiCNTbNsy
	 DeVRMZUqNZPLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00941479FC;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:34 -0800
Subject: [PATCH RFC v3 60/88] vfio/pci: Implement get_pfn provider op for
 guest_memfd
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
Message-Id: <20261106-gmem-alternative-providers-v3-60-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3886;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=csbHfwVQmJAIvOL3JkXMdnFfqy9AUj2CCzhFEzRs5Ek=;
 b=WOkAJg7cFMQRQZBPquFwhsiqfmQ+MJXo+8XyVeu5y9SUxzhSHcejH5/SogBd1YAcut6NsIkjq
 Wb9r8OuGmI2CKiK9HL0TQjRmrP6IA+Y54RW+x0R/lWeRZxEsEgvr07e
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the .get_pfn provider operation in the generic PCI VFIO bus
driver to translate guest_memfd page offsets to physical BAR frames.

Check the BAR availability flag locklessly via smp_load_acquire() to
avoid acquiring the device memory lock on the fault path, returning
-EFAULT if memory decoding is disabled or the device is in low-power D3.

Decode the 40-bit VFIO region offset to identify the targeted BAR and
offset within the BAR, validating that the BAR is a standard memory BAR,
supports memory mapping, and the offset falls within the resource size.

Compute the physical frame number from the PCI resource start address
and report GUEST_MEMFD_PFN_ATTRS_CACHE_UC_ALLOW_WC as the frame's
caching attribute so stage-2 mappings permit guest write-combining while
host userspace mappings remain uncached.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci.c      |  1 +
 drivers/vfio/pci/vfio_pci_core.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 96f438671db29..9bc8009a9e766 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -171,6 +171,7 @@ static const struct vfio_device_ops vfio_pci_ops = {
 #ifdef CONFIG_KVM_GUEST_MEMFD
 	.gmem_attach	= vfio_pci_core_gmem_attach,
 	.gmem_release	= vfio_pci_core_gmem_release,
+	.gmem_get_pfn	= vfio_pci_core_gmem_get_pfn,
 #endif
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c7b67fbce4cae..9551a067b5689 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2731,6 +2731,44 @@ void vfio_pci_core_gmem_release(struct vfio_device *core_vdev)
 	up_write(&vdev->memory_lock);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_release);
+
+int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t index,
+			       unsigned long *pfn, int *max_order,
+			       u64 *pfn_attrs)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned int bar;
+	u64 pgoff;
+
+	/*
+	 * Lockless check: if memory decoding is disabled or the device is in
+	 * low-power D3, fail immediately without blocking on memory_lock.
+	 */
+	if (!smp_load_acquire(&vdev->bars_available))
+		return -EFAULT;
+
+	bar = index >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	pgoff = index & ((1ULL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	if (bar >= PCI_STD_NUM_BARS || !vdev->bar_mmap_supported[bar])
+		return -EINVAL;
+
+	if (pgoff >= (pci_resource_len(pdev, bar) >> PAGE_SHIFT))
+		return -EINVAL;
+
+	*pfn = (pci_resource_start(pdev, bar) >> PAGE_SHIFT) + pgoff;
+
+	if (max_order)
+		*max_order = 0;
+
+	if (pfn_attrs)
+		*pfn_attrs = GUEST_MEMFD_PFN_ATTRS_CACHE_UC_ALLOW_WC;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_get_pfn);
 #endif
 
 module_init(vfio_pci_core_init);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index c3c16459e14f4..3a6d039454472 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -172,6 +172,9 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int vfio_pci_core_gmem_attach(struct vfio_device *core_vdev);
 void vfio_pci_core_gmem_release(struct vfio_device *core_vdev);
+int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t index,
+			       unsigned long *pfn, int *max_order,
+			       u64 *pfn_attrs);
 #endif
 extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,

-- 
2.56.0.455.g6c5a503b38-goog


