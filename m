Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792421997;
	b=yoFnfSjQZwTynkeBmSIrAQwul2QxCmkwJx3L1JK0el0Tsta7O7icJt5H2A3q3dEj3Ncf
	 ry19R2dkxFYPSt6v6IdHS08S/Gha4TTSX4shYd6QLkFt2YwBxtk8vI8dU54DFIV+XhaXQ
	 t4VgNYb6GMEwMr6Uk51/KIh04tjoEK678rfh8bbAxJeI1OmrcemPOe8ascF/pkqRBGdyc
	 /TBQuH6lXAAaXmXNoLTBZP8ZuijI4yhxEJhbHbvn+iuGD3J7mcIC8JeUjdQnHgDSiZaEa
	 qOpz4JM8/qVmHXACGrbXUNATLzBJ6qTYP19M0cKeYpPoRu8sMQTqfGPXHAxVuaOgSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Meq30BGUrGHp6xcOF0w5JprFYd5g2Y2UtUcpUpaVjGQ=;
	b=wbZtxssEzBj3GeVJn878mVW8tphQFbqnR4fYOAuP7IlPYkinRgfgzrMoNNGHuQhdFfgp
	 tclk7tgyiqN5CWd5EJJXaUB/DywXrjdDdFrCDLhYfFHPJRMbE6WXw52lmmYw+4WzxtETp
	 t+NFp+liGiyw8ZYhUQeMmaBrtfb6Sme1uF/rl2FdhqVARxU8jcFbrzkWwPL2gkSUFJUpe
	 CHHOUJGRnevS45AXvQWnnJblr5xv2SVyZJ6UoZzj/Wf77EHNBCWcZczqwmaajYxgTWUIH
	 3mrI4Fpw+3EuWw9X6UtcmDCbDBots96AJ4gR5/+7Tuth3OpA2///KNDMEpH0WQHCbww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gWoq6qaI;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08B607886C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 14:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F08B607886C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gWoq6qaI
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02e6b40so1359284f8f.3
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792421995; x=1793026795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Meq30BGUrGHp6xcOF0w5JprFYd5g2Y2UtUcpUpaVjGQ=;
        b=gWoq6qaIRRhPS7ZJ8zuEYoMMw4FIP6l1QkNJ+z0IZuZZhMO4ZRKK0gw/vkvJjehUuS
         rzG4RMZfwzOsOsjWhie03KCHMaK/ZlvaNMd0Y0dLsXid1efdVy9xrF+HmJgXmnQ1EyxP
         lTASUERTguy2hotQWY+bEk8OyfX7Ma1X1IVq64j+uEfYze+kYH8z7KvrNlqQdoSeRIXL
         qqAloxLG/UrALaRwAMD14hiSzeDX7JkyB1Q1/vCfkKreYmF6RXif+qKbFy3DP3/fZFoZ
         gFuEYZmRYsqeX6uQcGsUoxwG8oKz8FFTzNwNmMoyZWUzdcdeehIOdJs1w4ggzqi/10q9
         VbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421995; x=1793026795;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Meq30BGUrGHp6xcOF0w5JprFYd5g2Y2UtUcpUpaVjGQ=;
        b=Y+saBZOZSIrphjp7aMrg9Xe6o7XmqfakO2zIgKNOO+8gCAMj7wIY9vErjBDYcQPHNQ
         c7+UPhrQPtDyNE+cms3tDre848AlX2tZhxtSnUZM0zmUhZi2WHTKWcUl+qKKSjjanPN+
         J6FxPquKI4WGPzx67wHDvms4i5jE3jg5ZMScovA/t6P7t2bKDqXVyWcvlcs+UfACkmX7
         OUCbvbTBI7TaTaml4LyuBNmA7Yaf/2kgF0Ncx/Ajs0ROt0I4IFRHkegO6z8yOYCBADzR
         6/gOXwhhmGhDPbXPTkcn6c4GRJ0hb2tPdKXZ9C65bMPZ1mtu6K0YTn0hRsB7Anak2VTU
         ILNw==
X-Gm-Message-State: AFq9FYKD2ZSiZFfmZyzeQ1z8ivcmTw642jLfg0nvq8cirntZCLqxfj4+
	g679xN59O/bONVKK0mZgItH42V28RnUPLNxRqujNHweG+ivbIK5vIdzIx1gF2UrIWxVsdpd66RN
	LponZlvJnZFwvy/8w6K3Gvw==
X-Received: from wrus7.prod.google.com ([2002:a5d:6a87:0:b0:48e:1449:1f6c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:60cc:0:b0:48d:f14a:9177 with SMTP id ffacd0b85a97d-48e07fb9180mr11409788f8f.56.1792421995213;
 Mon, 19 Oct 2026 07:59:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:59:49 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019145949.1922019-1-vdonnefort@google.com>
Subject: [PATCH kvmtool] arm64: THPs for systems with pages bigger than 4K
From: Vincent Donnefort <vdonnefort@google.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, maz@kernel.org, oliver.upton@linux.dev, 
	suzuki.poulose@arm.com, alexandru.elisei@arm.com, andre.przywara@arm.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The THP support imposes an alignment of the memslot userspace address to
the size of a THP (PMD_SIZE). To do so, kvmtool overallocates the RAM
size and aligns it. However it assumes PMD_SIZE is 2MiB, which is only
true on 4KiB page systems.

Use a huge-page size, based on the system page size. This value can be
massive for a 64KiB page system, so skip the alignment if we couldn't
even install one THP.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arm64/kvm.c b/arm64/kvm.c
index 36b3284e4a92..2c01dc32fa9a 100644
--- a/arm64/kvm.c
+++ b/arm64/kvm.c
@@ -18,6 +18,8 @@
 
 #include <asm/image.h>
 
+#define HUGEPAGE_SIZE (PAGE_SIZE * (PAGE_SIZE / 8UL))
+
 static struct arm64_image_header *kernel_header;
 
 struct kvm_ext kvm_req_ext[] = {
@@ -35,20 +37,23 @@ bool kvm__arch_cpu_supports_vm(void)
 
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
@@ -63,7 +68,7 @@ void kvm__init_ram(struct kvm *kvm)
 		    kvm->arch.ram_alloc_size, errno);
 
 	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-					SZ_2M);
+					ram_alloc_align);
 
 	if (!kvm->cfg.arch.guest_memfd) {
 		madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,

base-commit: f67bc0bdae9433a9cfd05e65ea2c1bb6102566d9
-- 
2.56.0.176.g3575e65682-goog

