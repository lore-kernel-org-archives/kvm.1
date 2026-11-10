Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286928;
	b=xeIXSbBNyoKxDJhvkd+mn51MQ+TrLfxIptKU22MdStNmS/GuYFGsIpftqEm3GX2Ml8vg
	 arSwx9XBjAtijurB+JCAPu5/l/z9zpWXb39zveHjN7gcP5KJXcs0HH3N0ra6rd7rsmP4A
	 xQ/lau3ryIF/qkgmsPopq6N5Q2XvN6tyN41hZM5vU1jMYVu4VRJqg0EXE49J+2+UelyQO
	 KX5j88EH8TM+xzRHCSAF6tsausTLQ2N/fk5RkuvIrJBUSYgKtb55yTJ+c9+b/ZjXPHs7S
	 J1QzI5+1x/fuMxFNKhnnqJS7S+KqpXgUzwukhSDFsKPaasOj+p8Wc1vg2dyDVzTnhMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
	b=HxpziuHguDltB/HhN0nsP4TrobV//XO2bvkR7L80cFem6Aq+P68OJPgr4Vm6YhgD5Sja
	 KaB3KLoFiGg2Vg5NXo3wRkKoFHM9PVRH+LE8huDelTmqPnrHPGyqg5fe6fOnD0dDgZ9ZT
	 CL5ziU0cLrG1nm45pZp+L7OkTugygtk4j7Kw38j+Dm60KT0SHidzIacQQ5ilU5BOhx61+
	 F2lXxXO0cbogZG2qMsJ9y1lHZ3Ya7NDzDCpnt728bNlggzCThdBxj1JuQjW2hf/SBhETU
	 8gcSbEw3A8UAiPnTCRmFy2r9hZd4zKIMHO4Fykn5n5uY+WSFI76YpBCUJpoHZZwUz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DAEo2dMx;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D9606A338
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227D9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DAEo2dMx
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4322d31021so170409966b.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 21:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286926; x=1794891726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
        b=DAEo2dMxobhuiy+BPkZF78KBY8AZ3oG6vG1FJ0FSRekwxR92kAiVOHr8toAvgzqrPg
         9seh1cIoK/EUOBiYwAqphF52K+OaWWcHy9U0OmiD2/pxWGLF97msZ9+ohaFlKABy7suR
         CrzvVla47LRVqPLw0uLBX/OUXdisY2cclo29hk/vRQLpxcWCvdAEKR4E8t1o5vD+ZO7u
         OsoLTt2HhKL2VqBsFkqw/CUcRiVqIil+kpdtGCXL/2npw4DXy8c1gzFohJBZoXuJKrat
         hwF8FaYMniFneqTcmuTpTo3f7+K791eyhYrEzbV1Ha+N33LMtS/irMZjBEYmKw5EgwK4
         uNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286926; x=1794891726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vxLVeArTOU555NjIGXbAokcuidpkXwhlCffjRLrr3o=;
        b=OeuU2KTcKjHmKi8jF1E6/44p3ybUdoCTq1QWlDGf22x2Xu1QI93Nk+AGSxYfvYjzYF
         Ku7/kZMPetuKu1vr84Ot708Vqt/2GrkFhklwUDOLnT94gLX+4wDPv6kagTbJLPJjWvVu
         0EZ5m/psosjbfM0Z5cWcHkVUn760/JaU9sbWvsespsylcQr/U20b6P9MhQlMaW60QBxf
         UFnket0jpV/reY3vw/lEH9iFh1EHI3+BW1Ecq7ZE9hnBdHvwecAQInlkblBArNkJnsI9
         U6OEJ6+vOQOSSKF6muzSgVMd+0ANADwejsM0VIOpJZHkygHBRl+HUoF9K1zif8pukCC/
         O2/Q==
X-Forwarded-Encrypted: i=1; AL+hErHNNhnUT5rCbifP1+117WFEFpKRiT2ea7uWudcr3fc9W9UTj6uzrHT183ooOhAliDlCdHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/V7Sb4rWBB64OHzaEtPdsEImwVQupq3WkmSPaBPnhV18kf1UL
	cTZ2oi0QOkmqRebVWIymSq7rgjjTwiZsSRkw0z87o3Yq+n/O5mORUdp+Spr7vzVe3KWlrN1jx1v
	TsPOdDcIhE55CzDPXzA==
X-Received: from ejcuu11-n1.prod.google.com ([2002:a17:907:c60b:10b0:c3f:fb8f:67f3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9694:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c5049525569mr113201966b.21.1794286926296;
 Mon, 09 Nov 2026 21:02:06 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:44 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-2-tarunsahu@google.com>
Subject: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO and
 memfd ABI structures
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

All structures in include/linux/kho/abi/block.h (struct
kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
struct luo_flb_header_ser, struct luo_flb_ser) and
include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
with no padding holes between fields or tail padding. Assert both the
structure size and 8-byte alignment under CONFIG_64BIT at compile time.
Any future unaligned field addition should come with reserved field to
keep the structure aligned.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/block.h | 10 +++++++--
 include/linux/kho/abi/luo.h   | 38 +++++++++++++++++++++++++++++------
 include/linux/kho/abi/memfd.h | 16 ++++++++++++---
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
index d06d64b963be..36bdbaf9b3b8 100644
--- a/include/linux/kho/abi/block.h
+++ b/include/linux/kho/abi/block.h
@@ -12,7 +12,7 @@
  * pre-update kernel to a post-update kernel.
  *
  * This interface is a contract. Any modification to the structure fields,
- * compatible strings, or the layout of the `__packed` serialization
+ * compatible strings, or the layout of the serialization
  * structures defined here constitutes a breaking change. Such changes require
  * incrementing the version number in the `KHO_FDT_COMPATIBLE` string to
  * prevent a new kernel from misinterpreting data from an old kernel.
@@ -26,6 +26,8 @@
 #define _LINUX_KHO_ABI_BLOCK_H
 
 #include <asm/page.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
 /**
@@ -49,6 +51,10 @@
 struct kho_block_header_ser {
 	u64 next;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct kho_block_header_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct kho_block_header_ser) == 8);
 
 #endif /* _LINUX_KHO_ABI_BLOCK_H */
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 288076de6d4a..721949374fa1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -58,6 +58,8 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
@@ -82,7 +84,11 @@ struct luo_ser {
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_ser) == 32);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_ser) == 8);
 
 #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
 
@@ -98,7 +104,11 @@ struct luo_file_ser {
 	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
 	u64 data;
 	u64 token;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_ser) == 64);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_file_ser) == 8);
 
 /**
  * struct luo_file_set_ser - Represents the serialized metadata for file set
@@ -113,7 +123,11 @@ struct luo_file_ser {
 struct luo_file_set_ser {
 	u64 files;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_file_set_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_file_set_ser) == 8);
 
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
@@ -131,7 +145,11 @@ struct luo_file_set_ser {
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct luo_file_set_ser file_set_ser;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_session_ser) == 80);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_session_ser) == 8);
 
 /* The max size is set so it can be reliably used during in serialization */
 #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
@@ -152,7 +170,11 @@ struct luo_session_ser {
 struct luo_flb_header_ser {
 	u64 pgcnt;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_header_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_flb_header_ser) == 8);
 
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
@@ -175,7 +197,11 @@ struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
 	u64 data;
 	u64 count;
-} __packed;
+};
+
+static_assert(sizeof(struct luo_flb_ser) == 64);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct luo_flb_ser) == 8);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 08b10fea2afc..376a724a1d8c 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -11,6 +11,8 @@
 #ifndef _LINUX_KHO_ABI_MEMFD_H
 #define _LINUX_KHO_ABI_MEMFD_H
 
+#include <linux/build_bug.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
 #include <linux/kho/abi/kexec_handover.h>
 
@@ -20,7 +22,7 @@
  * memfd uses the ABI defined below for preserving its state across a kexec
  * reboot using the LUO.
  *
- * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * The state is serialized into `struct memfd_luo_ser`
  * which is handed over to the next kernel via the KHO mechanism.
  *
  * This interface is a contract. Any modification to the structure layout
@@ -54,7 +56,11 @@ struct memfd_luo_folio_ser {
 	u64 pfn:52;
 	u64 flags:12;
 	u64 index;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct memfd_luo_folio_ser) == 8);
 
 /*
  * The set of seals this version supports preserving. If support for any new
@@ -85,7 +91,11 @@ struct memfd_luo_ser {
 	u32 flags;
 	u64 nr_folios;
 	struct kho_vmalloc folios;
-} __packed;
+};
+
+static_assert(sizeof(struct memfd_luo_ser) == 48);
+static_assert(!IS_ENABLED(CONFIG_64BIT) ||
+	      __alignof__(struct memfd_luo_ser) == 8);
 
 /* The compatibility string for memfd file handler */
 #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
-- 
2.56.0.506.g506a7eabc5-goog

