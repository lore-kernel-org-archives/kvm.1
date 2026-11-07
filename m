Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011839;
	b=ueX71D0Ko4B9pL2+GwR4k3SMJJAXzkTHPAtfCkiLXxrPG30J5KjR04k3SFAAh4amM0Iv
	 ga6lTNdEReHBxcZbrlBQjPw7DuNXwbxZVLeIyirttXLRpxLALQ1tlUvdxOLJKyrxQqxx2
	 qJIGhc8+LSwz+qJBVJyrQ1Zynd+CGQAm6zblLqaKFGnDb3Ii5YijTz/mtzilECS7vsrxb
	 EAZG2jRIyzyoGK8hjZAY9aEsg/BwQb15o7fomUelcUFQmsi9rPuXhxFO37XrVL55Qoewf
	 3YQb61UbY+YNx2hCoTP6EGnPad7e5OnyQnnXlnjpjwRi0vyRBwpSCI9d+WTH/FPx16g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011839;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4XBnuXdKMW0BYZDb6pFvErPk/W2H/V3bFHID2+HkR8c=;
	b=SB8DiER8OZlkYopcFM1G0JtlSphea5emGJG+iMgpMSDPTM+dn3R2+WMcIn+ZhOcV79p2
	 qZ4vNWbBtQhXfuJh4LiTQnEvjAIyaBtVk/64g9UrcU4w2PlgHFRf8XG+Z46x/pY82MmKG
	 j+QZGPN0jBDOvrWSlMkgSiHlPy+3PoV3/Ukm9tlpvld3TmJDeTZOAikDqNGSA4j7ZqO7S
	 SJRs+r4aNJgPrt0dFddqKXVccIWYoMu0pscBjxE/0JrXKYtdrrIEEb5femrzuaU4dGRSe
	 BzjmMAfSwsXtUnI4nYApW+msI6WyCqgWWnddN/0hbaHJ786MdTP8VKl1ywhqABF8XKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EA70c6TG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED1606AF80;
	Sat,  7 Nov 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EA70c6TG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011839;
	b=DlFrmn9xrhJ3Psd38lHuPANkdJD3oyuOLN1JkX0mPmWobT0fifbIgtg3bBygJyQUTtnk
	 wld8bal7KL5yOX5TQKe9LDezbONQhdct6Yh20/rAnb8BBdCddq5CmU2S9bjUjjf1B/RuT
	 Z6QLuY2rOu8e2rQtvdwr38s9RREKFk3tG3EWdg3lzaYenHGmvWQd9ofOop9wDXyzzCqlv
	 aSQI+GCMHxfom4OlQT49WodFppHRpsGY4J+XgOWd7/ypKTVY6nzl2N23Z+zEhO8xS/haf
	 baONDRICRzrGXd7wh2R3ZH22P45C9+NNEkZQVghZbr/CEElSQHr0SP1fKfUS6QGHnuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4XBnuXdKMW0BYZDb6pFvErPk/W2H/V3bFHID2+HkR8c=;
	b=aMzF1Z6MizPSsHA3dwdXn2Lq3e439cV3XqciZjGJwMtf7Sf8Pu8yE5gZZR+UwZiWq71W
	 7E820UtK8Ieyxv0/QrLcN34cBlnEiiXqg9kCWW5uGED7fbkiEd2dGqzdoB88W4MH8lH+i
	 /qNG1vARsEu5enaA7Q6RiH4yeTyXBo2oq8nh6lCeg6ClCHnjb0AVY3VVXMJuTF7+NRoT5
	 8qApZawYuK7PcI2lu7pozfZPliH94x3JfC34C8u/jmjBkHBtMm+MfwvHcp11IMni6NO6u
	 BjzrbmgU3Vzeb67BghMz3mkYu85ymRwRHgdXmdgq05bnOfAE20ZFFydSFC7OAevWHQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 359C11F00907;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011839;
	bh=4XBnuXdKMW0BYZDb6pFvErPk/W2H/V3bFHID2+HkR8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EA70c6TGizHUa25U7KFl5CVYLjU89Pnisxm9GO1YPcFfQnDXRiTKpidZcecGw1Ab0
	 SZJsQWh9f7mE3KaPkvJGrY7qej3Pzh3XP+cZGn6e2n6wqsIRpz2YqaGsgWGHCxf+yU
	 vHyvRdxgICbgld4AayNeizEcyHt76jL0/d2DAjt7v8x1nqMXjt0iYcqQmk5sTpJNsK
	 GkQfYC6HYKCdxJnl0nxd9grxG5IdQFW5lKD1mFAySzXLvasQDj6DnWs8hnsXBs6iVz
	 fCfq7aZ0ju6bGB6wCHdnCJMRcScYpwr9DF/hdToXYaBPmu8XfptveNhmvZerDvi5A6
	 gqoz5AOM11aJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AEFCE47A28;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:45 -0800
Subject: [PATCH RFC v3 71/88] vfio/pci: Implement read and write provider
 ops for guest_memfd
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
Message-Id: <20261106-gmem-alternative-providers-v3-71-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=4013;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=m9SP1CpmTKvsGoq5eZAgHyb5OpuOEc1QM5jrgJzQxmI=;
 b=IoPXFGcHpHdx3UkOvEWFEMm1Dzaeclszns6ukrwhiM363noCrao70iL5dIJrsqo9NYK4Q0Ok3
 ibey69WXBPFDkrp/2bbZlPPA3FGFWxadq6loOgMcqBRLY3Q25uA+Ycy
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the .gmem_read and .gmem_write provider operations in
vfio-pci to service read and write accesses forwarded by guest_memfd.

When guest_memfd delegates BAR access, it already holds the shared
filemap invalidation lock and serializes against memory attribute
conversions and hardware revocations.

Restrict guest_memfd reads and writes strictly to mappable MMIO BARs
(indices < PCI_STD_NUM_BARS with bar_mmap_supported[index] set),
rejecting all other regions with -EINVAL.

Verify locklessly that BARs are available via bars_available before
accessing MMIO space. Forward to vfio_pci_bar_rw_kbuf with test_mem
set to false to skip acquiring memory_lock and runtime PM, preventing
AB-BA deadlocks against concurrent revocations during resets, power
state transitions, or memory decoding disablement.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci.c      |  2 ++
 drivers/vfio/pci/vfio_pci_core.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6f28f1ffbad0e..e5e2dbca152ec 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -174,6 +174,8 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.gmem_get_pfn		= vfio_pci_core_gmem_get_pfn,
 	.gmem_lookup_pfn_range	= vfio_pci_core_gmem_lookup_pfn_range,
 	.gmem_check_set_attributes = vfio_pci_core_gmem_check_set_attributes,
+	.gmem_read		= vfio_pci_core_gmem_read,
+	.gmem_write		= vfio_pci_core_gmem_write,
 #endif
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a9274d95e9066..c976574782663 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2871,6 +2871,42 @@ int vfio_pci_core_gmem_lookup_pfn_range(struct vfio_device *core_vdev,
 	return -ENOENT;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_lookup_pfn_range);
+
+static ssize_t vfio_pci_core_gmem_rw(struct vfio_device *core_vdev,
+				     void *kbuf, size_t count,
+				     loff_t *ppos, bool iswrite)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+
+	if (!count)
+		return 0;
+
+	if (index >= PCI_STD_NUM_BARS || !vdev->bar_mmap_supported[index])
+		return -EINVAL;
+
+	/* Lockless check on availability of BARs. */
+	if (!vfio_pci_get_bars_available(vdev))
+		return -EIO;
+
+	return vfio_pci_bar_rw_kbuf(vdev, kbuf, count, ppos, iswrite, false);
+}
+
+ssize_t vfio_pci_core_gmem_read(struct vfio_device *core_vdev, void *buf,
+				size_t count, loff_t *ppos)
+{
+	return vfio_pci_core_gmem_rw(core_vdev, buf, count, ppos, false);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_read);
+
+ssize_t vfio_pci_core_gmem_write(struct vfio_device *core_vdev,
+				 const void *buf, size_t count,
+				 loff_t *ppos)
+{
+	return vfio_pci_core_gmem_rw(core_vdev, (void *)buf, count, ppos, true);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_write);
 #endif
 
 module_init(vfio_pci_core_init);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index b6e2fb93f9500..03cb0b41855dd 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -181,6 +181,11 @@ int vfio_pci_core_gmem_check_set_attributes(struct vfio_device *core_vdev,
 int vfio_pci_core_gmem_lookup_pfn_range(struct vfio_device *core_vdev,
 					pgoff_t index, unsigned long *pfn,
 					size_t *nr_pages);
+ssize_t vfio_pci_core_gmem_read(struct vfio_device *core_vdev, void *buf,
+				size_t count, loff_t *ppos);
+ssize_t vfio_pci_core_gmem_write(struct vfio_device *core_vdev,
+				 const void *buf, size_t count,
+				 loff_t *ppos);
 static inline void vfio_pci_set_bars_available(struct vfio_pci_core_device *vdev,
 					       bool available)
 {

-- 
2.56.0.455.g6c5a503b38-goog


