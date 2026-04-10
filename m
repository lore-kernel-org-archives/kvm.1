Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29344332601
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797739; cv=none; b=H6NV6/RnxDLj8ZEu8AwS8J3VDKM+BpFvTarFy/iB/QuAkOQgJMa9QBN2fynjQpKR2fPg8sb+lmnWetVxaX7REOHXDBHVUg88yB+azbrvq/MI+9630TtQRHjN7Axn2nobOqykb2nuPVFL5RrTs/qTK8zynx1hBkN2yYnsTABHXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797739; c=relaxed/simple;
	bh=ikoQiR0H0XvLgCP6keWgEHMGdSg+/hl3C5JY6OUSHIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AlnmR4JzZhGYvdNQBQzD8y8PsYeCt1IYkUPZILvth5XXYajJ48Hlzldd6wga4vrYRUdia/EpuQep/vTXzd+oAZ1+xtLCI7cJmKeXf+RLiX9fqXJIMLQ9G2S693qY3m9Mb4twUfUIcnN7hFcV211mObtmrPeC1yUQZ9W7e3s6cRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbbkjJX4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbbkjJX4"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a1e1817db6so13938366d6.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775797736; x=1776402536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6/QHXQbomLfsVwk8NhS+h+5+49x45iiS2ZC9fgOlbA=;
        b=dbbkjJX4fWseZ2bhdyXyx9vmbPMuFVyHX8m7hzUPZD6bVuXvidmWMGnICzL0xsJMFc
         wmdXKK//hAipWnKH61OLWYoPURGxXiUTn/zTMgHtI1x/+e1z7tYeoUAAIbG4ZcxawXoQ
         uKf4GOmMudiM1IMH4yAtqXQPQSALGOS9OmdoVfZGMie07VF1UNs9R969aI4c+HCzIPC6
         tCYz0DDWfwMM1PrwOOKJ8QmsKuILRSPpohFfn5n4TNr9RSdiDDk9F8XOvbWMWLO/CMWM
         YPw5/xXKBK6sQi3XatSG4pYkOOi55pnjrHZM+9jbkkEjEKJ2dyjtvUGa3IOZ2QLqxlvs
         ZJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775797736; x=1776402536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6/QHXQbomLfsVwk8NhS+h+5+49x45iiS2ZC9fgOlbA=;
        b=nTYuHTERUBQ+u6fNBVTyKKraYW5Il4QgHIPp6OHa4WgMu1cUoXmFTrKyfVdKVZqAf8
         WGvyShDE51byEpQdGKGZIP/NXe7D7gi8jMYeeP5Fi/6awwUrIRFDG39e5NBPrQRtWV6u
         fB5tQ/Z6u7n/ocOH7OMAw/Bmd2ZAk5b+wRU5cI9gg+JNJewxj/jhv28K/fFJ7uWJD/A+
         YFRMTZG7cRhKxqPSUBTojzJXbJHio+EAlBkxl22t7eaPuFgbvkrNVMuXRcY3n4TaJSfj
         dzVj/DKl0/mKr7yzCoUwIO7DkY3tG5xr9JsXuvPlcXmPn1Vc/7SvHnRTLdH498WCmY/B
         2BNQ==
X-Gm-Message-State: AOJu0Yyc/qzxPnhYFAzTVvEW0yF0RqZ2ANCMZrjTyy6BxayfHGM4szPO
	lMgdWeLSZlYjgh8A8Z9gUp3jYyZ3llykMC8ZUlidfSlCxqtGiisPT1q2
X-Gm-Gg: AeBDies/ircp3EaXd141T+7q8hTU9o7E0yOts1PaNTUVXnUzk/zrlVifQdQ+ZbI7uVu
	HAiUAH1vjDOPuhvrqMquJGcM3GDh3RNdI3j8hUzBHF9Ns7fUFROSjEdNBaCBXcCDWH41FtyOaE0
	YtlfyMF+nQXqOCY4/3mFI37qzuD7ZskZwgoAa12K1j9ATXWtVo8F8UlLGKnjDlPs1FymzgFpP3s
	dndvUypFB448+ogc3QqKcNIvuRYcEjqhNb/8stKPlF9yyBS61OdQdtbM0SlBmWUDwSAVNhuytwb
	RAh7/aZZTiODZwK0si4elFjr5ox3MaTu4jwn2Gb3hDYb+wvruhl1rs95CtFKEAIehr9MJTFQqMe
	LLysJxr8KsHE4YUIOpvdxi47ibw8BCjhud2wXrl6DYcWXaT6+O/4pddwYA4VhvIfYRXFinlTA4t
	oLGZikEP0I+8cgNCIhayiqSg1okQ+9obv6IUtVMo73YOgx7u4TWkp1aQZbPm9oWyUCKOT7Cf3Tu
	rgA0pNwSDawZmqFPn/mpLFj4Jii
X-Received: by 2002:a0c:e00d:0:b0:899:f95a:acdf with SMTP id 6a1803df08f44-8ac8628f293mr19881756d6.32.1775797736012;
        Thu, 09 Apr 2026 22:08:56 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c44236sm17740986d6.27.2026.04.09.22.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:08:55 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
Date: Fri, 10 Apr 2026 05:08:54 +0000
Message-Id: <20260410050854.2463447-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sev_dbg_crypt(), the per-iteration transfer length is bounded by
the source page offset (PAGE_SIZE - s_off) but not by the destination
page offset (PAGE_SIZE - d_off).  When d_off > s_off, the encrypt
path (__sev_dbg_encrypt_user) performs a read-modify-write using a
single-page intermediate buffer (dst_tpage):

  1. __sev_dbg_decrypt() expands the size to round_up(len + (d_off & 15), 16)
     before issuing the PSP command.  If len + (d_off & 15) > PAGE_SIZE,
     the PSP writes beyond the end of the 4096-byte dst_tpage allocation.

  2. The subsequent memcpy()/copy_from_user() into
     page_address(dst_tpage) + (d_off & 15) of 'len' bytes overflows
     by up to 15 bytes under the same condition.

Trigger example: s_off = 0, d_off = 1, debug.len = PAGE_SIZE -
the PSP is instructed to write round_up(4097, 16) = 4112 bytes to
a 4096-byte buffer.

Fix by also bounding len by (PAGE_SIZE - d_off), the same check that
sev_send_update_data() already performs for its single-page guest
region.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39..a7eb24179 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1340,6 +1340,7 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 		s_off = vaddr & ~PAGE_MASK;
 		d_off = dst_vaddr & ~PAGE_MASK;
 		len = min_t(size_t, (PAGE_SIZE - s_off), size);
+		len = min_t(size_t, len, PAGE_SIZE - d_off);
 
 		if (dec)
 			ret = __sev_dbg_decrypt_user(kvm,
-- 
2.34.1

