Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798745;
	b=cZi2gaLGtAa5jAGMsbQYzHjt300mdZnYCvHGTUA/EQ01pBAcBNSVVi+KBSpk7o97oRrS
	 S6N+3WHNUGdXvaCN8X3rtucoSjzvru5VJjDOjSO4V7YhPB/gMEYmFtL0AhxHb4KwfrFNb
	 6C7lsbjNW6XtzUZ1FT8fewmbfcqXkJNJ8gjn1LMgwPnxp8AiTxDhE51O775QNzWCQzc1i
	 fRqTYmRA13hAKGNKcvRwbx2Rp1mfZ22j6ZhdUUdftqj433zybsQ9cUiWf9H3wnZa/mVGz
	 R0KjBbdXafGGwWx22RwfiuIciqbD1gqQRS0zrj/Fa547gCrsvZhTUUtllPf15wEafBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9ZXEacqR3rbcMgUrTgI8rcS8c5nOk1mz2EbR1FK4c64=;
	b=c1BipLo9oSmoxGuFCqc7aCFWSUlgTNZ3Hz11vsxSD40XdySh3i/oLAquc18z7NwrsLoO
	 fChTUGXt0fKL60kNFez05BdW5H4rvwz5VD57LgYyt+BKqP0eofAbXTt+4IXo1RcvA8xoi
	 XmWRcnnQpl3CWFoUhWfzyPDKYa6Yp2ej+aVDyXfkHhb0ayg9YSlEtoetXmBmgiRLw9vwU
	 HRgT41i/Ofivazxg5gH5ZEYgQWsOtzguNrC1RBo33dxZar5hsukyiOXk0yh4qNSaIH/FP
	 Q3M1tKecljveOAlkcXE/mwF1G/vwMJp3truAw5Oc2k7AzaYRRwS54JGRUZrn/AlgV3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a2fjzuS+;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C0606A335
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 16:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5C0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a2fjzuS+
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so68151075e9.2
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795798744; x=1796403544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZXEacqR3rbcMgUrTgI8rcS8c5nOk1mz2EbR1FK4c64=;
        b=a2fjzuS+8Y9uuJ6LMFeCARzy6P1tM6jopUAxpF75CwFn8IIIFElpEMsuMWGJrScBgS
         dSV8zpfDhGL8pHbBsNlTuB5IH4lb+s1a2b60/9iMBrZzl+t2eXCKH+JHMrUmheymyytR
         0iTDqRZf7UZLqYpWADp8G3pqLN7xp2/TqDw0YLvLvXkskphM5ndaqLtLDe3u9zQCuyWf
         uJomOVSMnByakpBXiuDmBvE1aOj5L9AZIlvTp68JBYMrJUoyaAZ9CjB/ZWkElDvszDHW
         SYOSRwDv6RNpY6hqPUJUFNa8faGdnCF5gOVpw3W5++gjb/ZMh9JAcVuAbPO2INVkDkEQ
         2JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798744; x=1796403544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ZXEacqR3rbcMgUrTgI8rcS8c5nOk1mz2EbR1FK4c64=;
        b=00fGp9FKDn7HqQv9DronpACgIJagdUH67fV7q4hTl8jGR7w11sBxEO8BdafIta08NF
         1y+pFF84uRd7NZa/vl9MGwrhJfCH0VBrz8aK3a9Q+wmyO7ooH5bpvseD+v7PtSayjcU/
         k7cUzsIaThosa5kJ7daxtEE+XQfIYzOIl4EaM2MH7L4w6DkXo78AKzRgEtBE0EMQ3Xb3
         unDw/fIhbTS0Gl5fGMOB3lh42ioQqgpRa2Rz0TznVM9RwpeY5IKMCcN1Fz+Zswjv9Vx0
         WerkPSzkGfDsQoFCyaybTPmTcussO1ZIhrlFEYJjrzSfoQqh5BJkE0BBAV3Svs2HKPHe
         xoIA==
X-Gm-Message-State: APuU4Z+uUVJrQYxV8371mRwYlt6o+IIkfh2xIYW1XimcH7CndVgbdq0x
	v9plID7WAXsTV1BdHwX9c1Iiy1hTQH6kSph2Brd55W1Z5jk7FPrpTnzYxB6PS2kweGgffwN2sRO
	TNFyeP2gUU4e3xp8Wb3kdLw==
X-Received: from wmbz10.prod.google.com ([2002:a05:600c:c08a:b0:4a1:8bbb:59bd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb8882948dmr520359785e9.18.1795798743614;
 Fri, 27 Nov 2026 08:59:03 -0800 (PST)
Date: Fri, 27 Nov 2026 16:58:42 +0000
In-Reply-To: <20261127165843.709034-1-vdonnefort@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261127165843.709034-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127165843.709034-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] arm64: THPs for systems with pages bigger than 4K
From: Vincent Donnefort <vdonnefort@google.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, maz@kernel.org, oliver.upton@linux.dev, 
	suzuki.poulose@arm.com, alexandru.elisei@arm.com, andre.przywara@arm.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The THP support imposes guest RAM over-allocation to align the memslot
userspace address to PMD_SIZE. However the alignment is currently
hardcoded to 2MiB, which only works with 4K page systems.

Instead, derive the hugepage size from PAGE_SIZE and skip the alignment
if the guest RAM size can't even contain a single hugepage.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arm64/kvm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arm64/kvm.c b/arm64/kvm.c
index 35aa6f260dd1..02cd519a5cbb 100644
--- a/arm64/kvm.c
+++ b/arm64/kvm.c
@@ -17,6 +17,8 @@
 
 #include <asm/image.h>
 
+#define HUGEPAGE_SIZE (PAGE_SIZE * (PAGE_SIZE / 8UL))
+
 static struct arm64_image_header *kernel_header;
 
 struct kvm_ext kvm_req_ext[] = {
@@ -34,20 +36,23 @@ bool kvm__arch_cpu_supports_vm(void)
 
 void kvm__init_ram(struct kvm *kvm)
 {
-	u64 phys_start, phys_size;
+	u64 phys_start, phys_size, ram_alloc_align = SZ_64K;
 	void *host_mem;
 	int err;
 
 	/*
-	 * Allocate guest memory. We must align our buffer to 64K to
-	 * correlate with the maximum guest page size for virtio-mmio.
-	 * If using THP, then our minimal alignment becomes 2M.
-	 * 2M trumps 64K, so let's go with that.
+	 * Allocate guest memory. We must align our buffer to 64K to correlate
+	 * with the maximum guest page size for virtio-mmio. If using THP, then
+	 * our minimal alignment trumps 64K, so let's go with that.
 	 */
 	kvm->ram_size = kvm->cfg.ram_size;
 	kvm->arch.ram_alloc_size = kvm->ram_size;
-	if (!kvm->cfg.hugetlbfs_path)
-		kvm->arch.ram_alloc_size += SZ_2M;
+	if (!kvm->cfg.hugetlbfs_path) {
+		if (kvm->ram_size >= HUGEPAGE_SIZE)
+			ram_alloc_align = HUGEPAGE_SIZE;
+
+		kvm->arch.ram_alloc_size += ram_alloc_align;
+	}
 
 	if (kvm->cfg.arch.guest_memfd)
 		kvm->arch.ram_alloc_start = mmap_guest_memfd(kvm,
@@ -62,7 +67,7 @@ void kvm__init_ram(struct kvm *kvm)
 		    kvm->arch.ram_alloc_size, errno);
 
 	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-					SZ_2M);
+					ram_alloc_align);
 
 	if (!kvm->cfg.arch.guest_memfd) {
 		madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
-- 
2.56.1.839.g22a8290db9-goog

