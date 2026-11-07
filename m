Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011838;
	b=QGi6H0g+U/4ndEJur6fBi2JFM3bR4vnf6SBPdZjkj8hk60ZGoEsJdZ6E7R5F8tcpoKWa
	 /tyRyLaNiu7n6LtBJN6rGibnLjQqKP++PBj/yRn4520lpzM0jFjxwOOo00il0SDvZDx1k
	 4o2YckKjDd/sntJ+qEDFeyKH279WY6Yt6/EgrVYq7LwFyJmaHbIjFxoL/X+o5HUAQBkj2
	 Hiekc/FjpdMk3LBtPsF6RyLCpMqAD7n7royyf6k3ipuNYeme5uL9LUw/bw0jlUHrcUaSg
	 Sgb1c3yp9Bk9h8Wbz9Y6RE4ofU8+/a8BEVXJhJZo1iUdJ1upbsNL5zzaVMcHeQ9JXQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011838;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Zs1J/x6nfmV3dx/eHdCEN/mRYv0Hi+QZwL/OVF2OHBE=;
	b=H2WnPd+umYoHbjRMV6obuW7KmB8mNlgqZ0ne2ilo0a5yUoILtPdvruMtqvisJqsqlKwT
	 ubYXx6iyHNnOgjnnjbvY/ohAWvGocizxORqwFVQYHZbbd8WKVebwRpA9S0mz3hfFuab16
	 C2zeOlU7cw985h9FzeDG3TYE/iIlxGexPNk16TSawjVGLRWy8iCkR6DuV5c+K5rBieM1I
	 L8Lgxme6rOh9e9/wQgTBb3420qpUiH/JMCxbSW5RM/n5Ml8Z/1XwR/SwQUYPwrCt226I+
	 Xp9PNHkg1+m1X2OTaPouV7wAeVX08AgQUs1fOtKB6yO2fpmNQIhz1/Wf1V65ZApRBsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieb+P2xG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BE606A822;
	Sat,  7 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieb+P2xG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011838;
	b=g4hSPArBDnT/jney67n0J1t/Fbtz1sIexhNHL4FA/ltR+N1eazRRuuUxGVKnvNKFKE5Q
	 hNDoB9kp0LaQcALLfEmwXi7mZ/qIMZ+1k+u8VsQYAdKZHqMa1VE8F4tcqEBsTU/I/tlec
	 RZtzXwD/trH8VlFbVEAVvIKCHCwTbrSPrMNcFJwkIFkGeJ/7hX3iEMY30p/lCS3KSQmZP
	 maq1I9OklQh/Tjv4Vl8SEcI1hCzVNKuB2Kn8BA1JVNh04fnzlZMT7hEhVmnugD9TNtfYI
	 OVFGZBrG+qqpwD+OneiZx5Mi8+VuNlPoKsXkPVy2Mr+IWbQfTsVOiplV68lk5G8DJpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Zs1J/x6nfmV3dx/eHdCEN/mRYv0Hi+QZwL/OVF2OHBE=;
	b=wUgxTJ7VW22WQ1KjJxU8xv8sYXDlQbWKTd59+MFCPYMmhcQiOaWNy+mVpqvnhPJrjoin
	 xaOtNY6MG0T1A+8m7g9wRRwlPiBDlIClFjAFLZGjMyiuFXoXdA3dvBVg9kNYO5ejT8T9g
	 y0WWdDQ5U2k5ikt6ybpknIxhOnsd4k+SVTIlhB1itYGviIdc78hLxjsH1l3+LBHPPkfgT
	 Xq5smajz4qco+fPQpxqESnMm0T7+cRo52kSlaJOQn/NGwO7dX61+E1mR8Oo3ow0+MdwZ2
	 wxeclurOeWODUsfpYF15CszyxTip1EKg/F6SyM8aOvkkScjB9Y2FFSnSnV0/0SYBPtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E3C221F008BC;
	Sat,  7 Nov 2026 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011838;
	bh=Zs1J/x6nfmV3dx/eHdCEN/mRYv0Hi+QZwL/OVF2OHBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ieb+P2xGQ6kamYKd4+tenquqlrTGuaSLKQlY4uw6J8rckIGGLk5ey3IKena50A7jJ
	 A0e2nux8/sTNf0jZorwFGKdAy8YVWGhWc4N2wvjdyZtoZgaktWwjBFXVEzFv3qR9dN
	 1fh2oJ90229fD92r5zPH3D92IYcdrqI6gb66u7wQRBnVD1yIw3EfjjlL18eCTsqajO
	 dQ9qfzpMYgITlEJ/NKsQkpKfgeqKKUmmw6BFvy1KnC5WfxHBCjKiQ9cJmcoIME/GMK
	 JQyaVUOBl/636TUTgWCF2pFfzD+cC2yWhxa90hK58oo6Jazwx0+lMOXNhRFpxOsBRX
	 J1P4ZJPVmqTxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4E83147A10;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:39 -0800
Subject: [PATCH RFC v3 65/88] vfio/pci: Revoke guest_memfd memory on BAR
 invalidation and reset
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
Message-Id: <20261106-gmem-alternative-providers-v3-65-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=7771;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=g3NkV0PMjIPnPGwhZsAlobRqGmDhxygV0Omg1VEgfl4=;
 b=x0AjF2T9NT+QEEiAao5ICbuevp1PlS++gYajfqkdep24IiXXDURbfHVED4DDFk2qgccq23/84
 Hl46rCqEmiJD0groeAVC0Rygr97P5L8AyZHy2WA1gx7BSh3dr38vIwq
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When PCI hardware events occur (such as clearing PCI_COMMAND_MEMORY,
entering low-power D3, bus resets, or function-level resets), physical
BAR access is invalidated.

In vfio_pci_zap_bars(), if guest_memfd memory was marked available,
mark the BARs unavailable and invoke vfio_device_gmem_revoke() for each
mappable standard PCI BAR to revoke host userspace mappings and guest
stage-2 SPTEs before hardware state is modified.

When memory decoding is subsequently re-enabled and power state is
restored to D0 under the device memory lock, mark BARs available again
so future guest_memfd faults can proceed.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 16 ++++++++++----
 drivers/vfio/pci/vfio_pci_core.c   | 44 ++++++++++++++++++++++++++++++--------
 include/linux/vfio_pci_core.h      | 22 +++++++++++++++++++
 3 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69aef..fae3980fb8d9c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -630,8 +630,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		*virt_cmd &= cpu_to_le16(~mask);
 		*virt_cmd |= cpu_to_le16(new_cmd & mask);
 
-		if (__vfio_pci_memory_enabled(vdev))
+		if (__vfio_pci_memory_enabled(vdev)) {
 			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_set_bars_available(vdev, true);
+		}
 		up_write(&vdev->memory_lock);
 	}
 
@@ -720,8 +722,10 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 	}
 
 	vfio_pci_set_power_state(vdev, state);
-	if (__vfio_pci_memory_enabled(vdev))
+	if (__vfio_pci_memory_enabled(vdev)) {
 		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_set_bars_available(vdev, true);
+	}
 	up_write(&vdev->memory_lock);
 }
 
@@ -911,8 +915,10 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
 			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
+			if (__vfio_pci_memory_enabled(vdev)) {
 				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_set_bars_available(vdev, true);
+			}
 			up_write(&vdev->memory_lock);
 		}
 	}
@@ -996,8 +1002,10 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
 			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
+			if (__vfio_pci_memory_enabled(vdev)) {
 				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_set_bars_available(vdev, true);
+			}
 			up_write(&vdev->memory_lock);
 		}
 	}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 894b1332f8a0c..2b29d0ec6a0c9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -464,8 +464,10 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
 	 */
 	down_write(&vdev->memory_lock);
 	__vfio_pci_runtime_pm_exit(vdev);
-	if (__vfio_pci_memory_enabled(vdev))
+	if (__vfio_pci_memory_enabled(vdev)) {
 		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_set_bars_available(vdev, true);
+	}
 	up_write(&vdev->memory_lock);
 }
 
@@ -1337,8 +1339,10 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
-	if (__vfio_pci_memory_enabled(vdev))
+	if (__vfio_pci_memory_enabled(vdev)) {
 		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_set_bars_available(vdev, true);
+	}
 	up_write(&vdev->memory_lock);
 
 	return ret;
@@ -1727,8 +1731,31 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
 	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
 	loff_t len = end - start;
+	int i;
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+
+#ifdef CONFIG_KVM_GUEST_MEMFD
+	if (vfio_pci_get_bars_available(vdev)) {
+		vfio_pci_set_bars_available(vdev, false);
+
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+			pgoff_t gmem_start;
+			unsigned long pfn;
+			size_t nr_pages;
+
+			if (!vdev->bar_mmap_supported[i])
+				continue;
+
+			gmem_start = VFIO_PCI_INDEX_TO_OFFSET(i) >> PAGE_SHIFT;
+			nr_pages = pci_resource_len(vdev->pdev, i) >> PAGE_SHIFT;
+			pfn = pci_resource_start(vdev->pdev, i) >> PAGE_SHIFT;
+
+			vfio_device_gmem_revoke(&vdev->vdev, gmem_start,
+						nr_pages, &pfn);
+		}
+	}
+#endif
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
@@ -2621,8 +2648,10 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 err_undo:
 	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
 					 vdev.dev_set_list) {
-		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
+		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev)) {
 			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_set_bars_available(vdev, true);
+		}
 		up_write(&vdev->memory_lock);
 	}
 
@@ -2709,9 +2738,7 @@ int vfio_pci_core_gmem_attach(struct vfio_device *core_vdev)
 
 	bars_available = __vfio_pci_memory_enabled(vdev) &&
 			 !vdev->pm_runtime_engaged;
-
-	/* Pairs with smp_load_acquire() in provider operations */
-	smp_store_release(&vdev->bars_available, bars_available);
+	vfio_pci_set_bars_available(vdev, bars_available);
 
 	up_write(&vdev->memory_lock);
 
@@ -2726,8 +2753,7 @@ void vfio_pci_core_gmem_release(struct vfio_device *core_vdev)
 
 	down_write(&vdev->memory_lock);
 
-	/* Pairs with smp_load_acquire() in provider operations */
-	smp_store_release(&vdev->bars_available, false);
+	vfio_pci_set_bars_available(vdev, false);
 
 	up_write(&vdev->memory_lock);
 }
@@ -2747,7 +2773,7 @@ int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t index,
 	 * Lockless check: if memory decoding is disabled or the device is in
 	 * low-power D3, fail immediately without blocking on memory_lock.
 	 */
-	if (!smp_load_acquire(&vdev->bars_available))
+	if (!vfio_pci_get_bars_available(vdev))
 		return -EFAULT;
 
 	bar = index >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 6ff67e38eaf84..af74766d7c90a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -178,6 +178,28 @@ int vfio_pci_core_gmem_get_pfn(struct vfio_device *core_vdev, pgoff_t index,
 int vfio_pci_core_gmem_check_set_attributes(struct vfio_device *core_vdev,
 					    pgoff_t index, size_t nr_pages,
 					    u64 attributes);
+static inline void vfio_pci_set_bars_available(struct vfio_pci_core_device *vdev,
+					       bool available)
+{
+	/* Pairs with smp_load_acquire() in provider operations */
+	smp_store_release(&vdev->bars_available, available);
+}
+
+static inline bool vfio_pci_get_bars_available(struct vfio_pci_core_device *vdev)
+{
+	/* Pairs with smp_store_release() under memory_lock */
+	return smp_load_acquire(&vdev->bars_available);
+}
+#else
+static inline void vfio_pci_set_bars_available(struct vfio_pci_core_device *vdev,
+					       bool available)
+{
+}
+
+static inline bool vfio_pci_get_bars_available(struct vfio_pci_core_device *vdev)
+{
+	return false;
+}
 #endif
 extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,

-- 
2.56.0.455.g6c5a503b38-goog


