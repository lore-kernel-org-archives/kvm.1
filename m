Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200233938F
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320255; cv=none; b=msub7D8GYztJv40bQMHPklFBGQIZdEJR5El/OxJcgNDVNDLcXRavNS7mFh9T3jnEaM9/qDAf+dZlPi2rC5tmBhM/q0oKShFBYDFvsP8ZmtmyBERrLhrlKWXR/uP5cmBGyUemjDC+aTtnMoO5Qw61+3Unx2vfQAryL9JR2QEG2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320255; c=relaxed/simple;
	bh=bXZax6a7DYYPU0H2jxG9hpA0ueCdMF4YETCx1u2mP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihXVFoHB/21iHYCRwAvLqQSHmP7ZHQ5q+35eN083U7TXIJxElmP1itc+8rBbsTpZhQxqTHdbj8h207XCm0WKvMJbs4IAFsXln64oExOG0SQKZsSD0F3xzdJGNDI18Z+ZM41rYjKHwOwpIjPv7udosqSvCD4XocJVnb3EAoVLlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCfrsRcM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCfrsRcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787320251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A506wxtg8RERB6RKAxGkZx92SknR0OPGwLagqbwuhmQ=;
	b=QCfrsRcMy9D7U0+NLR/4hXuOXauh+8qWGITwU8jUyR9smhEUKvDplSGfw24DwquDvUJObp
	YgUT9GHCD6qQ6Klii1EpgUmv8HfmLIm2lMBmsxNTagzo/WBVoDpUaBbINjfqV+yctAEhrV
	YGHvjpJbDKm60ken73rMkgsMbeVfBks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-133CBa9BOseKUyhCqUCwnw-1; Fri,
 21 Aug 2026 09:50:43 -0400
X-MC-Unique: 133CBa9BOseKUyhCqUCwnw-1
X-Mimecast-MFC-AGG-ID: 133CBa9BOseKUyhCqUCwnw_1787320242
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58A6D1955DBF;
	Fri, 21 Aug 2026 13:50:42 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52F917D6;
	Fri, 21 Aug 2026 13:50:39 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Albert Esteve <aesteve@redhat.com>
Subject: [PATCH] linux-headers: Update to Linux v7.3-rc1
Date: Fri, 21 Aug 2026 15:50:38 +0200
Message-ID: <20260821135038.2676679-1-aesteve@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Update headers with update-linux-headers.sh against Linux v7.3-rc1,
mainly for VIRTIO_ID_MEDIA.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/standard-headers/linux/const.h      |  4 +-
 include/standard-headers/linux/ethtool.h    |  6 +++
 include/standard-headers/linux/virtio_ids.h |  1 +
 linux-headers/asm-arm64/unistd_64.h         |  1 +
 linux-headers/asm-generic/unistd.h          |  6 ++-
 linux-headers/asm-loongarch/unistd_64.h     |  1 +
 linux-headers/asm-mips/unistd_n32.h         |  1 +
 linux-headers/asm-mips/unistd_n64.h         |  1 +
 linux-headers/asm-mips/unistd_o32.h         |  1 +
 linux-headers/asm-powerpc/kvm.h             | 18 +++++++
 linux-headers/asm-powerpc/unistd_32.h       |  1 +
 linux-headers/asm-powerpc/unistd_64.h       |  1 +
 linux-headers/asm-riscv/unistd_32.h         |  1 +
 linux-headers/asm-riscv/unistd_64.h         |  1 +
 linux-headers/asm-s390/unistd_64.h          |  1 +
 linux-headers/asm-x86/unistd_32.h           |  1 +
 linux-headers/asm-x86/unistd_64.h           |  1 +
 linux-headers/asm-x86/unistd_x32.h          |  1 +
 linux-headers/linux/const.h                 |  4 +-
 linux-headers/linux/iommufd.h               | 45 +++++++++++++++--
 linux-headers/linux/kvm.h                   |  3 ++
 linux-headers/linux/userfaultfd.h           | 54 +++++++++++++++++++--
 linux-headers/linux/vduse.h                 | 28 +++++++++++
 linux-headers/linux/vfio.h                  | 21 ++++++++
 linux-headers/linux/vfio_zdev.h             |  2 +
 25 files changed, 193 insertions(+), 12 deletions(-)

diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
index c6a9d0c983..92635cec4a 100644
--- a/include/standard-headers/linux/const.h
+++ b/include/standard-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 55f608c3a7..622d634d04 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2015,7 +2015,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT	= 39,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT		= 40,
 	ETHTOOL_LINK_MODE_1000baseX_Full_BIT	= 41,
+
+	/* Despite the "baseCR" in 10000baseCR, this is not an IEEE 802.3 baseCR
+	 * It represents SFF-8431 Appendix-E SFP+ Direct Attach (10G-SFI-DA).
+	 * The name is kept as-is for uAPI backward compatibility.
+	 */
 	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT	= 42,
+
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT	= 43,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT	= 44,
 	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT	= 45,
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6c12db16fa..f9056af0c6 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 70b3754a42..4329a2ad54 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -328,6 +328,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index a627acc8fb..5b7e77a7c7 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -863,8 +863,12 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+/* fs/open.c */
+#define __NR_fchroot 472
+__SYSCALL(__NR_fchroot, sys_fchroot)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 3a29d86e1d..b525f2d7b8 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -325,6 +325,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 5fa1ee0cb4..f883da76c9 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -400,5 +400,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index e1f873d83a..59837eb866 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -376,5 +376,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 8207e9ca4f..485872076e 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -446,5 +446,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f5..913a64b901 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,24 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 1f63360120..2677c54903 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -453,6 +453,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 87439c53c1..6fc19ccccd 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -425,6 +425,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 828f3c2b9d..1039bdc6cf 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -319,6 +319,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index 8fa59835a3..72040a5498 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -329,6 +329,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 01f674c1bc..3d3747e3ca 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -391,6 +391,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index e945468829..7f298247f8 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -462,6 +462,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 3c49b00ed1..fbddeb4bc3 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -386,6 +386,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index bd2af9ad08..629770ed4b 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -339,6 +339,7 @@
 #define __NR_file_setattr (__X32_SYSCALL_BIT + 469)
 #define __NR_listns (__X32_SYSCALL_BIT + 470)
 #define __NR_rseq_slice_yield (__X32_SYSCALL_BIT + 471)
+#define __NR_fchroot (__X32_SYSCALL_BIT + 472)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
index c6a9d0c983..92635cec4a 100644
--- a/linux-headers/linux/const.h
+++ b/linux-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 10c600d71e..3c61caadbf 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
 };
 
 /**
@@ -219,6 +220,33 @@ struct iommu_ioas_map {
 };
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
+/**
+ * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
+ * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
+ * @flags: Reserved, must be 0 for now
+ * @ioas_id: IOAS ID to query IOVA to PA mapping from
+ * @__reserved: Must be 0
+ * @iova: IOVA to query
+ * @length: On input, non-zero maximum number of bytes to query starting from
+ *          @iova. On output, number of physically contiguous bytes starting
+ *          from @out_phys, capped by the input length.
+ * @out_phys: Output physical address the IOVA maps to
+ *
+ * Query the physical address backing an IOVA range. The beginning of the
+ * range must be mapped already and length must be non-zero. For noiommu
+ * devices doing unsafe DMA only.
+ */
+struct iommu_ioas_noiommu_get_pa {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 __reserved;
+	__aligned_u64 iova;
+	__aligned_u64 length;
+	__aligned_u64 out_phys;
+};
+#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
+
 /**
  * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
  * @size: sizeof(struct iommu_ioas_map_file)
@@ -574,11 +602,22 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI:
+ *    If set, user space must issue TLBI/CFGI+SYNC commands twice due to
+ *    hardware erratum T264-SMMU-3. See the description at
+ *    arm_smmu_erratum_repeat_tlbi_cfgi_key.
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
  * @__reserved: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
@@ -594,7 +633,7 @@ struct iommu_hw_info_vtd {
  * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
  * idr[1]: SIDSIZE, SSIDSIZE
  * idr[3]: BBML, RIL
- * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS
  *
  * - S1P should be assumed to be true if a NESTED HWPT can be created
  * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
@@ -602,7 +641,7 @@ struct iommu_hw_info_vtd {
  * - ATS is a per-device property. If the VMM describes any devices as ATS
  *   capable in ACPI/DT it should set the corresponding idr.
  *
- * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128 etc). It is
  * important that VMMs do not read bits outside the list to allow for
  * compatibility with future kernels. Several features in the SMMUv3
  * architecture are not currently supported by the kernel for nesting: HTTU,
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65b..aea4ab5c69 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,6 +986,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 4283de22d5..c8e99df952 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -25,7 +25,8 @@
 #define UFFD_API ((__u64)0xAA)
 #define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
 				 UFFDIO_REGISTER_MODE_WP |	\
-				 UFFDIO_REGISTER_MODE_MINOR)
+				 UFFDIO_REGISTER_MODE_MINOR |	\
+				 UFFDIO_REGISTER_MODE_RWP)
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
@@ -42,10 +43,13 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_RWP |			\
+			   UFFD_FEATURE_RWP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
+	 (__u64)1 << _UFFDIO_SET_MODE |		\
 	 (__u64)1 << _UFFDIO_API)
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
@@ -54,13 +58,15 @@
 	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -79,6 +85,8 @@
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
+#define _UFFDIO_RWPROTECT		(0x09)
+#define _UFFDIO_SET_MODE		(0x0A)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -103,6 +111,10 @@
 				      struct uffdio_continue)
 #define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
 				      struct uffdio_poison)
+#define UFFDIO_RWPROTECT	_IOWR(UFFDIO, _UFFDIO_RWPROTECT,	\
+				      struct uffdio_rwprotect)
+#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
+				     struct uffdio_set_mode)
 
 /* read() structure */
 struct uffd_msg {
@@ -158,6 +170,7 @@ struct uffd_msg {
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
 #define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
 #define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
+#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is VM_UFFD_RWP */
 
 struct uffdio_api {
 	/* userland asks for an API number and the features to enable */
@@ -230,6 +243,18 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
 	 * existing page contents from userspace.
+	 *
+	 * UFFD_FEATURE_RWP indicates that the kernel supports
+	 * UFFDIO_REGISTER_MODE_RWP for read-write protection tracking.
+	 * Pages are made inaccessible via UFFDIO_RWPROTECT and faults
+	 * are delivered when the pages are re-accessed.
+	 *
+	 * UFFD_FEATURE_RWP_ASYNC indicates asynchronous mode for
+	 * UFFDIO_REGISTER_MODE_RWP.  When set, faults on read-write
+	 * protected pages are auto-resolved by the kernel (PTE
+	 * permissions restored immediately) without delivering a message
+	 * to the userfaultfd handler.  Use PAGEMAP_SCAN with inverted
+	 * PAGE_IS_ACCESSED to find pages that were not re-accessed.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -248,6 +273,8 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_RWP			(1<<17)
+#define UFFD_FEATURE_RWP_ASYNC			(1<<18)
 	__u64 features;
 
 	__u64 ioctls;
@@ -263,6 +290,7 @@ struct uffdio_register {
 #define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
 #define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
 #define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+#define UFFDIO_REGISTER_MODE_RWP	((__u64)1<<3)
 	__u64 mode;
 
 	/*
@@ -356,6 +384,14 @@ struct uffdio_poison {
 	__s64 updated;
 };
 
+struct uffdio_rwprotect {
+	struct uffdio_range range;
+	/* !RWP means undo RWP-protection */
+#define UFFDIO_RWPROTECT_MODE_RWP		((__u64)1<<0)
+#define UFFDIO_RWPROTECT_MODE_DONTWAKE		((__u64)1<<1)
+	__u64 mode;
+};
+
 struct uffdio_move {
 	__u64 dst;
 	__u64 src;
@@ -374,6 +410,16 @@ struct uffdio_move {
 	__s64 move;
 };
 
+struct uffdio_set_mode {
+	/*
+	 * Toggle async mode for features at runtime.
+	 * Supported: UFFD_FEATURE_RWP_ASYNC.
+	 * Setting a bit in both enable and disable is invalid.
+	 */
+	__u64 enable;
+	__u64 disable;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/linux-headers/linux/vduse.h b/linux-headers/linux/vduse.h
index e19b3c0f51..bab47129db 100644
--- a/linux-headers/linux/vduse.h
+++ b/linux-headers/linux/vduse.h
@@ -14,6 +14,12 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -63,6 +69,12 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
+/* Set the VDUSE features */
+#define VDUSE_SET_FEATURES	_IOW(VDUSE_BASE, 0x05, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
@@ -325,6 +337,8 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
@@ -372,6 +386,15 @@ struct vduse_iova_range_v2 {
 	__u32 padding;
 };
 
+/**
+ * struct vduse_vq_ready - Virtqueue ready request message
+ * @num: Virtqueue number
+ */
+struct vduse_vq_ready {
+	__u32 num;
+	__u32 ready;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -382,6 +405,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -399,6 +423,10 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+
+		/* Only if VDUSE_F_QUEUE_READY is negotiated */
+		struct vduse_vq_ready vq_ready;
+
 		__u32 padding[32];
 	};
 };
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index f3282b8e86..c85dcbfe30 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1534,6 +1534,27 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390. On s390, PCI error recovery
+ * involves platform firmware and notification to operating systems is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device.
+ *
+ * Userspace provides an opaque buffer of fixed length, and the kernel
+ * fills it with the zpci_ccdf_err data structure. The length of
+ * zpci_ccdf_err is provided to userspace via the
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
+ *
+ * The ioctl returns -ENOMSG if there are no pending PCI errors.
+ */
+struct vfio_device_feature_zpci_err {
+	__aligned_u64 data;
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
index 77f2aff1f2..d6c1175c88 100644
--- a/linux-headers/linux/vfio_zdev.h
+++ b/linux-headers/linux/vfio_zdev.h
@@ -32,6 +32,8 @@ struct vfio_device_info_cap_zpci_base {
 	/* End of version 1 */
 	__u32 fh;		/* PCI function handle */
 	/* End of version 2 */
+	__u32 ccdf_err_length;	/* PCI CCDF length */
+	/* End of version 3 */
 };
 
 /**
-- 
2.55.0

