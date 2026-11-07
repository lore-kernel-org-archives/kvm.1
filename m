Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011840;
	b=e8EnSHyJew14zEHzEvt32uR/4zO1aYBHzgLEJvWLnoUTOAUNdikbvdu9ksTAWpd92dH9
	 qr4Z3zYBCFI74xuLqHYdOKWagOGVshtj6qcUx4k+hGpigABJOq3cJ31VhI2bTo0T2Zk+P
	 D1sGL5Kaa5h/qkwo66vx8Os6dTRlepTKAKmJOkqqTJR5PmrQh7Ok/FOKhK/pTRpsD9fNe
	 Ij2R9TEYOsLC9R1NIGXzLs1UBiQEMJqkVxPLL++GOM9t9qrQXD4N4Z9aqLFdYqYpqSLck
	 dG8XH5v+ZqQZgUiVOQALMoHkh731xmVZR8mczwpnsCF0J6sXrCTcoTHrFezBz69wZ3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KSzCvt8WQqpzBuP3J/NQntpezWM4rdwAQRra0I/Idek=;
	b=Yw0CjrUtpQr0oCdsDY8rxGMU+4yuEUJyU5bvpbLy5KftrBqRtQYZcflOfd0zaQtyQ5Ae
	 59N5jmz2xVRNhDxRYXYlXU3c6nsOnv7IB6UVk6d+CoR2cZz4uSTcq9+9I3dv++/4OctDC
	 j9iCRMES/iwjSr6UamGv9a+cVNBYYEAjMaBO5FOrEhEqrU0llPtuVNagvApA68KuG7eRd
	 OfT/SSFsJe8xlRLBCGO4QY7Px1i3Y2tQWBO1uGpUi/b8IcbYkHFLtL0L91O14O/3qrZxH
	 /X7mQ23rvb5KYTgJfiQEZGGNRDECiXXLq0zaqCbOhsvHcShE57lixO2LMifPf3bOmZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnYQ3Z5r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A026082BC5;
	Sat,  7 Nov 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnYQ3Z5r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011839;
	b=KrAYrNLBi7d1PD7L5Q1JOQKJfxAGkuDDQ03hvYRyuH/dYwMdSlr2F9zYbVF/gtm33URB
	 7KkQp/Yqn6yTJ9YFap5Jf0/VQTH78MxLLknvwRnLzuQxXF4InMkl3szTmrgJU8hfBrrYJ
	 v7l4i5JaKMLgcgbHBff1rkmtgRw0jkzBBJGWpvP9YiggLQb2j+M2KtfIFtlJYDymI40gf
	 zeOVsPunl5RPQmAH9jBqB4qvZ9yy81ILv1Y2QSRiFP0gkBvZPlkV3f1FDji2j3ssEguaF
	 pg7WJuAHsUBH632GjLJm48bL28mOzICxYlVRnsRxDHhvrS7+p6oFpFGebHNrt8tz6Ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KSzCvt8WQqpzBuP3J/NQntpezWM4rdwAQRra0I/Idek=;
	b=xcLkA3wwlqpaKCyRxPJNMfvK/gkCVUQk6hE0f6nFBFq2b5fUmkbV+I99/LrxQLUg00uV
	 opRfzVKJQDZv4/1VO8s6dUazNshPLGbNRZyB64/B4d+i/eH0tb3nPlrRdOI+6gdOBVgV6
	 e/RHHphClAeMhZoBJElJXC/VYZ+cnRsMG4x5TzwCiUCk3+y2Y1oFpCPJKgpAGqz1GYsoM
	 VVGA6Oede0nTXwsaIm7d/AAqTEkSNvxtHfACjGRK7L0irVANKDWssnhuuapjpGmM3EbLl
	 nJJtWpMABkhLWcVIx0ybqhzypd9wa9mVQXZOnQeZu04A+naE4tF/Bx28AQ4eTRIdc/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 069831F008A2;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011839;
	bh=KSzCvt8WQqpzBuP3J/NQntpezWM4rdwAQRra0I/Idek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MnYQ3Z5rSfWFp59+l0g1SybbhKh9PRW9YHbrIppFTWa/HkXHtR3wvQjIEqPXdrjOs
	 AIs+CKHU5Z0XotS3FubdL6TpFaLONpq/yRrmrCrfu+9I/LlQOtQP2RYKicNgoUPREy
	 061mphxTa9LqIN0g2dhnHNxgBQCFjC9+cajEtxnlkyhwgpvtxCqX0YW+2H/LvcjnzT
	 JQc2IiCSrEXf+juyUlTkkWEJnGlMcCu9UEyrtiMvNSUUQqjsUL6UwK0Smtbl1tY3fa
	 qr1nEXNOjtmov2gh7hce6aNilqD01WW2q4Bcd2/B3/bkJNxtGx5sQzik9X3usSsPx5
	 qA+7MTlEmn1dw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9DFD347A24;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:44 -0800
Subject: [PATCH RFC v3 70/88] vfio/pci: Introduce vfio_pci_bar_rw_kbuf for
 kernel buffer MMIO access
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
Message-Id: <20261106-gmem-alternative-providers-v3-70-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3928;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=UIlkF+Cr22G3+Xr2iBhEh8LcRpc3sGqQkL185U7r+lA=;
 b=+kFt+aQv22Fzn/rAHsafa1OuVqSafNgWyqhLjRHbRfa9pHHNKcUImie1vu/kp7shzbDEOq5Ui
 o/cvz/JgZIMB7fndBfMPCP9FpzvLu83/5upSc1Qy9/oaTWLV4373+Kc
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Refactor BAR read and write handling to separate the core MMIO logic
from the buffer source.

Extract the core BAR read and write implementation into a static helper
that operates on an iov_iter and accepts a test_mem parameter controlling
whether memory decoding and power state should be validated under
memory_lock. Retain the userspace interface, importing the user buffer
into an iov_iter with test_mem enabled.

Introduce a counterpart helper taking a kernel buffer and setting up
an ITER_KVEC iov_iter, allowing callers with kernel buffers to read
and write to PCI BARs without userspace pointer conversion or copy
overhead, and to specify whether memory testing is required.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  3 +++
 drivers/vfio/pci/vfio_pci_rdwr.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 607a33270aca1..48a068e68aab8 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -53,6 +53,9 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
+ssize_t vfio_pci_bar_rw_kbuf(struct vfio_pci_core_device *vdev, void *kbuf,
+			     size_t count, loff_t *ppos, bool iswrite,
+			     bool test_mem);
 
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index cc64722d1ab9a..c44c78e48e6aa 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -221,8 +221,9 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
-			size_t count, loff_t *ppos, bool iswrite)
+static ssize_t __vfio_pci_bar_rw(struct vfio_pci_core_device *vdev,
+				 struct iov_iter *iter, size_t count,
+				 loff_t *ppos, bool iswrite, bool test_mem)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
@@ -284,8 +285,9 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
 
-	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite, max_width);
+	done = __vfio_pci_core_do_io_rw(vdev, test_mem && (res->flags & IORESOURCE_MEM),
+					io, iter, pos, count, x_start, x_end,
+					iswrite, max_width);
 
 	if (done >= 0)
 		*ppos += done;
@@ -301,6 +303,30 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	return done;
 }
 
+ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			size_t count, loff_t *ppos, bool iswrite)
+{
+	struct iov_iter iter;
+	int ret;
+
+	ret = import_ubuf(iswrite ? ITER_SOURCE : ITER_DEST, buf, count, &iter);
+	if (ret)
+		return ret;
+
+	return __vfio_pci_bar_rw(vdev, &iter, count, ppos, iswrite, true);
+}
+
+ssize_t vfio_pci_bar_rw_kbuf(struct vfio_pci_core_device *vdev, void *kbuf,
+			     size_t count, loff_t *ppos, bool iswrite,
+			     bool test_mem)
+{
+	struct kvec kvec = { .iov_base = kbuf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, iswrite ? ITER_SOURCE : ITER_DEST, &kvec, 1, count);
+	return __vfio_pci_bar_rw(vdev, &iter, count, ppos, iswrite, test_mem);
+}
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			       size_t count, loff_t *ppos, bool iswrite)

-- 
2.56.0.455.g6c5a503b38-goog


