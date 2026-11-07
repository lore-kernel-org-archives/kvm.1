Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011847;
	b=ul25MY9Q+Tum4kXRZFnyX7ZsT0WdhbkzhzwU3DwPFt5R9qo7nulfsd15vyctbBnYQ8uz
	 PRfBASmE5L8RJBlvfUOJFgq/RSQPC4L+51P25UHdMYTP/SRUQV3MI1QAV8//cigG0xPYB
	 QiYbWU8x71Pz/LA54tC+JiyZRQ62yV/RmMwPS9reZBS2hqoQbDNFawCtaqKEdw8CJB7k6
	 IaxxNDNX2T4btdiRffHQrTQk6ceBUVOVFSVQPjnf9XfiKo/2a6b0A0XIVgBwSF1NBEwJ6
	 OV5/qsAvDcPtp+8Twf5oOri7U3csPC+do5XA1qcYojQAXPjhMhN5liYwiXzGPWNJXPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011847;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KBhGX9yahIbsDDFoJ77ldQTuDbT5tg0ODdJhu+0F5YI=;
	b=QkRMyEaGz+pfjFLaXAospl8PkpiLuc3It/d8MqVfseQ60S3oxYd2mG4VL03ZzxH4BwWT
	 +Rnp0QGiMelatT6ByjPf/+tYB4sydxQ5Gnb5TV14VK4izvRl6X6cS37DLJM3qc2K5cztS
	 cmNN5gDY2X/y1IJG94XTcyf11x7PKssJDu2MqW4Fq+hjVsWWB6Gp8q6ZggxKJsKLe1OEy
	 3xXOulhcCV60fxX/57RYWjZ8OLSl/0LNnOs+fFNWHd7wriCwwS3Reyz5Qcq82U07Zh51L
	 rdgGX8odWz/jpFkDplpG/pH5Ys43OzYCjBgU7lY11ZTbf5ET7QW4C5DhWJnsJPgIPjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJfRbRBs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349C606B761;
	Sat,  7 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJfRbRBs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011841;
	b=IC5lsvDwnO2pljiQ8KRSVTp+eYwcw0v648FfwXl3Cz9Q2ibruvVi9ivr8QOqCsPaMjM6
	 hrb8EFaGVv0h8oanUHMbbvs3ojPRoGqSYFF+9qqo1qZmJiaZghj3jZhRfGGVy6wAt7P52
	 ftOTMfNBqS3rMhZtvCmLPHgBCHE5jNyedeoqePB+DrwJmVRS8f75/kJUaAK2tsCJlOODy
	 HO74dA8K4Jsh54juIFKgszuG+4hD+73kXvG+DH1b8tNlM9HfFS1ZMdUoq6Lt8pwRTZ1PJ
	 59t1yPpTeanny8x5cGOGkXDID5aeAME1jTVFKn5lALF52KbdoGyNuqgpRx4WaaYF1Hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011841;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KBhGX9yahIbsDDFoJ77ldQTuDbT5tg0ODdJhu+0F5YI=;
	b=g7e/2ed0nT/KRKyjNgSB4IgD69SQO87AmMBpcMFwZSC77+RyS0PVDkf3gHUwt43MtAv9
	 rkzRszeTiYVG9HV8DLWlv8xXZVVqtIsrjCt6+i24cQwIjcp/rofUsyXzCa5g7lSLjViR2
	 FRGvMZT1nz2ZVwQf3txqvJgPoV6h/D9+WF8gJt3dpGwkN4PT4XSB3xP+VLoT6hWqDys+w
	 Hn1tJIuv9AQZHTaVIUEAekBpOs5Ce28SoIRnT7TBUjJpOtlF0UPyZLsCzcvCKRX3jr63q
	 QG1iTt1qtL5FCWIfWlrU+F42hiWhWlf7xUUGxguuRX8pQg1CmLtqQdo4g4l5I+3MZVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B46E31F008A5;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011841;
	bh=KBhGX9yahIbsDDFoJ77ldQTuDbT5tg0ODdJhu+0F5YI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PJfRbRBsq/zArvX5SSV+AJJfmzGv9LuvVropQ9uVhaGW2UaZraSUeBXfQXme3+Vbi
	 QkUVozbzOKTFF+eAMYVXS6RufAEJjovCp22DfqPvN0nu+2L0CVG7Fv9gDXHN2lRoJg
	 gQ/AUjNegaeg053dDeR5AfM4WDhqVLrYDdNL3ldZILB0L16zLo7+PU+nrT0g71QIiZ
	 8CiEhzow2gzKcPG2jJ3+XSnFwMG79BrvP0XpK8+a/G9VJqOrDhzXsMxv1qsSq8gr0C
	 lfCKfa55VYwYhjPVFr0P7aPAKC1+JXKvEcHPLzy556276iptGc3iO62jeh1a4aKx6y
	 3blMeeEHP0KHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7D8DF47A1C;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:42 -0800
Subject: [PATCH RFC v3 68/88] vfio/pci: Use iov_iter for MMIO read and
 write
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
Message-Id: <20261106-gmem-alternative-providers-v3-68-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=6301;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=c4VDLuT5yqC8DJ1fpMzzzVy4zLcf9cySQYtbQA4hk74=;
 b=L5BjRew5q1svkShxrjXUHUJtKZ/8fmvjKLgv7L6S7iOvEcrS/PClvlilzhXkLk+16KWEMf/Ny
 1dJMQc+3f77BIvFJT8Dpz/JuqAKav6jhjhEryI/df80j9npQPqOyeF+
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Refactor the internal MMIO read and write helpers in vfio_pci_rdwr to
operate on struct iov_iter rather than directly calling copy_to_user
and copy_from_user with user pointers.

Keep the existing vfio_pci_core_do_io_rw interface unchanged by
importing user buffers into an iov_iter via import_ubuf before calling
the internal implementation. The overhead of initializing the iov_iter
on userspace accesses is negligible compared to PCIe bus cycle latency.

This decouples low-level PCI MMIO access from userspace copy semantics,
allowing in-kernel callers to service I/O using kernel buffers (such
as ITER_KVEC) without user copy overhead or page fault recursion.

For delegation of read/write() to guest_memfd, this helps avoid AB-BA
deadlocks between mapping.invalidate_lock and mm->mmap_lock when MMIO read
and write operations are invoked under filemap invalidation locks.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 107 ++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index e5f1f60513709..cc64722d1ab9a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -91,34 +91,34 @@ VFIO_IOREAD(32)
 VFIO_IOREAD(64)
 
 #define VFIO_IORDWR(size)						\
-static int vfio_pci_iordwr##size(struct vfio_pci_core_device *vdev,\
-				bool iswrite, bool test_mem,		\
-				void __iomem *io, char __user *buf,	\
-				loff_t off, size_t *filled)		\
-{									\
-	u##size val;							\
-	int ret;							\
-									\
-	if (iswrite) {							\
-		if (copy_from_user(&val, buf, sizeof(val)))		\
-			return -EFAULT;					\
-									\
-		ret = vfio_pci_core_iowrite##size(vdev, test_mem,	\
-						  val, io + off);	\
-		if (ret)						\
-			return ret;					\
-	} else {							\
-		ret = vfio_pci_core_ioread##size(vdev, test_mem,	\
-						 &val, io + off);	\
-		if (ret)						\
-			return ret;					\
-									\
-		if (copy_to_user(buf, &val, sizeof(val)))		\
-			return -EFAULT;					\
-	}								\
-									\
-	*filled = sizeof(val);						\
-	return 0;							\
+static int vfio_pci_iordwr##size(struct vfio_pci_core_device *vdev,		\
+				bool iswrite, bool test_mem,			\
+				void __iomem *io, struct iov_iter *iter,	\
+				loff_t off, size_t *filled)			\
+{										\
+	u##size val;								\
+	int ret;								\
+										\
+	if (iswrite) {								\
+		if (!copy_from_iter_full(&val, sizeof(val), iter))		\
+			return -EFAULT;						\
+										\
+		ret = vfio_pci_core_iowrite##size(vdev, test_mem,		\
+						  val, io + off);		\
+		if (ret)							\
+			return ret;						\
+	} else {								\
+		ret = vfio_pci_core_ioread##size(vdev, test_mem,		\
+						 &val, io + off);		\
+		if (ret)							\
+			return ret;						\
+										\
+		if (!copy_to_iter_full(&val, sizeof(val), iter))		\
+			return -EFAULT;						\
+	}									\
+										\
+	*filled = sizeof(val);							\
+	return 0;								\
 }									\
 
 VFIO_IORDWR(8)
@@ -132,11 +132,12 @@ VFIO_IORDWR(64)
  * reads with -1.  This is intended for handling MSI-X vector tables and
  * leftover space for ROM BARs.
  */
-ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
-			       void __iomem *io, char __user *buf,
-			       loff_t off, size_t count, size_t x_start,
-			       size_t x_end, bool iswrite,
-			       enum vfio_pci_io_width max_width)
+static ssize_t __vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev,
+					bool test_mem, void __iomem *io,
+					struct iov_iter *iter, loff_t off,
+					size_t count, size_t x_start,
+					size_t x_end, bool iswrite,
+					enum vfio_pci_io_width max_width)
 {
 	ssize_t done = 0;
 	int ret;
@@ -153,25 +154,25 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 
 		if (fillable >= 8 && !(off % 8) && max_width >= 8) {
 			ret = vfio_pci_iordwr64(vdev, iswrite, test_mem,
-						io, buf, off, &filled);
+						io, iter, off, &filled);
 			if (ret)
 				return ret;
 
 		} else if (fillable >= 4 && !(off % 4) && max_width >= 4) {
 			ret = vfio_pci_iordwr32(vdev, iswrite, test_mem,
-						io, buf, off, &filled);
+						io, iter, off, &filled);
 			if (ret)
 				return ret;
 
 		} else if (fillable >= 2 && !(off % 2) && max_width >= 2) {
 			ret = vfio_pci_iordwr16(vdev, iswrite, test_mem,
-						io, buf, off, &filled);
+						io, iter, off, &filled);
 			if (ret)
 				return ret;
 
 		} else if (fillable) {
 			ret = vfio_pci_iordwr8(vdev, iswrite, test_mem,
-					       io, buf, off, &filled);
+					       io, iter, off, &filled);
 			if (ret)
 				return ret;
 
@@ -179,23 +180,45 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			/* Fill reads with -1, drop writes */
 			filled = min(count, (size_t)(x_end - off));
 			if (!iswrite) {
-				u8 val = 0xFF;
-				size_t i;
+				static const u8 ff_buf[64] = { [0 ... 63] = 0xFF };
+				size_t cur = filled;
+
+				while (cur) {
+					size_t step = min(cur, sizeof(ff_buf));
 
-				for (i = 0; i < filled; i++)
-					if (copy_to_user(buf + i, &val, 1))
+					if (!copy_to_iter_full(ff_buf, step, iter))
 						return -EFAULT;
+					cur -= step;
+				}
+			} else {
+				iov_iter_advance(iter, filled);
 			}
 		}
 
 		count -= filled;
 		done += filled;
 		off += filled;
-		buf += filled;
 	}
 
 	return done;
 }
+
+ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
+			       void __iomem *io, char __user *buf,
+			       loff_t off, size_t count, size_t x_start,
+			       size_t x_end, bool iswrite,
+			       enum vfio_pci_io_width max_width)
+{
+	struct iov_iter iter;
+	int ret;
+
+	ret = import_ubuf(iswrite ? ITER_SOURCE : ITER_DEST, buf, count, &iter);
+	if (ret)
+		return ret;
+
+	return __vfio_pci_core_do_io_rw(vdev, test_mem, io, &iter, off, count,
+					x_start, x_end, iswrite, max_width);
+}
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,

-- 
2.56.0.455.g6c5a503b38-goog


