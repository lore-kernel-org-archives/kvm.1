Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DC175A7D
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961546; cv=none; b=tWtSRWZfKPOXDZ2bPMVcdSf5WRvVHMItr2NilR/R625z0VMvs5Or0V654Z6qTaYE9XLmYnVhMscO3Ogq/JQrXqnJKp6r/S0VxxXa2kJ3UBQ2Ony5m+Jj7X4PlNHbp814yT8UWxhAY+9Ed/xwRyMs0RjndM76AUbI+Z3wB3Zc7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961546; c=relaxed/simple;
	bh=VBZwqciWMNWwAbBjlanJpy7A768A24/BLS04ZLWw6Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGpeCcHlMEh+DFmSJRKzOaezoaQGfzZFAbj0/2IYSK8udteOra9MV2gJUUoitfDeBogABEn8tJi/REOpXQUXJrQO290Uz8P/WYHO0Hwx3ScJq0Kl34nQVIPDp6frhCD7q/3y660Rs62h4VFnAykA/ZIjhymYxYiH75beQfRU/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c47IZny3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c47IZny3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4629051c946so65687f8f.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 20:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782961544; x=1783566344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftPCUxA6Cux0mzU9qrlo7eK7xG8fUg3zJ+4KXq7SPJQ=;
        b=c47IZny3ElQv5zHmYNpgYudBAgDvuzC1O9WRRHNBg5pNWRJDbo7XfjyH1QSiEAN+oM
         LT5exGZzhrG86o2GeWwj6xA3N3xUX1AirzAGWH/tysYuVXAMro0HJ5wGPeb/dFB3zj47
         NtcA18ITdtBkiH068wj9iG3LEB29YGxTXSP5rIha8XLn/xmMnd8PHEhz9U3hBLqwcsqT
         HwTJlt+LR2G0HBObnB1BeIUSOzYWc6lIkxCuSMeG7kvpsP+2ZZaoFBvdhe/BiLs4R3bs
         sPvxuySBnbQkkHmaOEQUi6h86XII0PomBrlkt7Y5YC8qtW3v1ThS6lb9fyWNJWjJJA15
         9UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782961544; x=1783566344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftPCUxA6Cux0mzU9qrlo7eK7xG8fUg3zJ+4KXq7SPJQ=;
        b=XZbcs7x7Zm2vUw6WLnq33y02fAAcETuOn4u3djD48tM/hkeK+WoUUWDS4mOBHEQ4dv
         ukFuejdyXC9Pil5ClIxA1Di98rtsq67zX+6eX3xyP7HJDBfrj+NMMkzEpP/U06l0N/wP
         yHs2AwRCpPdX8PnWwY/zzid3goXqzU3QRFhaHS4EObul7RPHft+EA55NI4glU+Lnxo4B
         NdLy5YXJbqlt71evrdPCrB9H47PRWMuFy2Ef8CbGxpfRPOflXA3v8tcl2fXvix1ZFd+C
         PNNvjo01gJe8LJZKV3m+4tfN4n14Ox7iZRxzRuu/yZUlsnDnGRFHdfvKj7pajQDmz11L
         Pdqw==
X-Forwarded-Encrypted: i=1; AHgh+RpizT8gRIQUj1vrfYDBpggTGa70j2knz9kse99iJt1H2c1uJOWVNYtjawxl1Nts6tQrTgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFNzdjx9rFwbKFIpvBayISTq++GVn2Jfty4rCAypnBwVvJX8V
	qbkfCNFmz5ZeiWg/FEO5X5LHjln/NDq1tX02X4yjl5u1p7Py5bRKiCFb
X-Gm-Gg: AfdE7ckatF7yc5/TBd88DU15qOSemV/q3j+dzaU7WXHZh1+Da5EDaGBoCJAR7lB4w8Z
	5v9/m90liYfS7doizwPwF67uKAVehCHPbYc+U1C+Ue9Vc3SufxmNds/yJu3Xy8acFFpI1H/w7fY
	IE7DWodnOAZpR33wnF/OleZMA4YaGQL51N0M09vOxurVUk06mNUz+cF4ukuGS3ywd328hTVQWl5
	/N8xq53/MxGMlb7RnQEaYL6j2elcZR6rMY+Qo4x0+XO/R0VDd589ruPvSJXdTW6y+i0LhAgc5tX
	6yiEc0/8sb3BKWnzjMgS5lBIFe40u81Kjyyfi9o36IwMJ4mfp5dC17sMMubpPsWmXDwp+Is3Vfv
	FHhxxjw1BJDReW8XxfgKsKs5G/DecGimeqSbBaiXPwzfOnig3BzIgPbTvfNIePOSVqoQP5ROVNY
	Uw7tA1Km2KyyuVlM+r1z0gzT+SCpo6yFjSON7b9Nv6MxzaPKGG0ERVZSlkQQ9TNeWd8QvmxnTBz
	uDfv93ypSzN7WlHDSWypOytXctRvTQmbST8GFa1k0JcOW8NjUc9/7+kHRvLtORJJ/X2p5iGxuci
	Z8yUJk/xbUxty4A=
X-Received: by 2002:adf:e18e:0:b0:460:d18:865c with SMTP id ffacd0b85a97d-475de07c91bmr15871082f8f.1.1782961543762;
        Wed, 01 Jul 2026 20:05:43 -0700 (PDT)
Received: from z16 ([101.53.234.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd53fsm4550868f8f.37.2026.07.01.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:05:43 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salman Farooq <salman.farooq3310@gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  2 Jul 2026 08:03:44 +0500
Message-ID: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two instances of a misspelled word in comments.

Signed-off-by: Salman Farooq <salman.farooq3310@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..6ac8364a7639 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -163,7 +163,7 @@ static DEFINE_SPINLOCK(kvmppc_uvmem_bitmap_lock);
  *  All its GFNs are moved to Normal-GFNs.
  *
  *  UV_TERMINATE transitions the secure-VM back to normal-VM. All
- *  the secure-GFN and shared-GFNs are tranistioned to normal-GFN
+ *  the secure-GFN and shared-GFNs are transitioned to normal-GFN
  *  Note: The contents of the normal-GFN is undefined at this point.
  *
  * GFN state implementation:
@@ -1010,7 +1010,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
 /*
  * Release the device PFN back to the pool
  *
- * Gets called when secure GFN tranistions from a secure-PFN
+ * Gets called when secure GFN transitions from a secure-PFN
  * to a normal PFN during H_SVM_PAGE_OUT.
  * Gets called with kvm->arch.uvmem_lock held.
  */
-- 
2.55.0

