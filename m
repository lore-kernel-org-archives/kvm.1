Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6F426D0A
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427755; cv=none; b=iJZKHuNOM2kKwbPsw/kYxTovzN8uL+11Xc2LdDFQjc5G+iohVFcCSZ8eUzNv1BMIcgoNlvsAIf84QMsZsGSmtgWieGvHL33winvxXh6OD7QSMXkwq2DBHsXkS2IZiT5iM1HfIhLoWeRG9VS++AMdzwQM5dMgnqS3uAS/3cPjCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427755; c=relaxed/simple;
	bh=1rdZid1OqnapaKpKLZfZL9nN/IIgE3XM/IxZCu4Yxls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5nduscKL5CuDHfJoF0fOqlJgF0DTJiWoGG7gCS+xWAopKHnSrjjIAf5ai40oeuOaDTuwuV5sKrW34kc+dxPt8R8H7SQY+CyaX7EVvql4CX0rjyckctcu66IVCrY7SCXsjaOIJbO1g8+mM1GUyKcAhlSHYhroncdWUXkGrARW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i132Wc60; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i132Wc60"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485852d03a4so33116f8f.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427752; x=1789032552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2r6oyYeWRA4NkJB59FMsCMrpSy0tWrSaFIZX5RFlVq4=;
        b=i132Wc60B/bOGIxUCn1v5aDeyd1THYMsjMQ+KLLWRESdKuGgwllc8zgzSYL6PWo/js
         3gY43z9EBtFKdfgc0Df56dlYKjCgu6O1EV86wvsmkzOGv8Eq3HwU3IF5FZHvU0alOFnq
         1/lmV4ugH3bJLvGYZyJBZNBmQPrB/43yF0aoDEVzGYxSdpOGwgokkZUSurfoY1U1ROlc
         3dl1UqxWrrwjxKRxwtnaNjtfSMxEuzTXmMBMBQ8enzsr62pdjRikthfuG7v62F8QIAyo
         7bCKr6ekZwr9TtFqnCc9YykY7D0wfNfFR1Fp5cIFUml2P1rE3dCk9i3QCCqBhsDd+yga
         c6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427752; x=1789032552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2r6oyYeWRA4NkJB59FMsCMrpSy0tWrSaFIZX5RFlVq4=;
        b=NhYQ6MX6DUzkICkZin4el9Dqtz0/W+BDR2i3sIyqJ8qjc8ufu+7sMia5jvxDinBPIu
         9gRvXIA26Ac5Rmx2fgJpWd5ioX6gPSZkBVt//hdhIwaYXOUFNGJ/Ixc5izNtFvjF12yd
         FhllnmTd6PmkD3SzVdUnAFOXh+J4EH+ag8Fh2yPKYvYgigoKkxzC0o6+tDBF22AsZYig
         6eS/HkU4Yv/dC+f9rqB4i+Q4WjMjbNcAUdrC5ZtEDrB4cVIu3gBmY5NPEvXjbqKhCb02
         piyqMX/rAskD1ogibhTdhJ4VbTQkmN5NVWOrAYX/AfhSUGs28WEfipOoVwQSIKR9VZJB
         jtHw==
X-Gm-Message-State: AFuF++mRvQhCfyvVTPxLqEPomkLQJHdq1yYG1klDyi4QodPxV2xPxo7K
	EsQPs5kh0vIN9Xiwh4+WelrU1TF7D4nI+OGEhpQuFaUT2AxriCMBtBs3jv8G8w==
X-Gm-Gg: AYBFou1T9T5jnHJbbrhUJm2qlDuGinjwtBViLLp64H3J+Amc0Gph051soCvFqK0wQVR
	OiFxNC9nUo2mDyMj3RduHaG2srj+JnXm3Z6EBxdUfAxaV2WWSwUuV+i9fS22KSg0dax00IWiwGD
	Dcwf0Ny8h/tyY9zvhCvum8pW6lm/of32HcOOcXuvjuBP54Je8NZ9ZYDgE/86Q/pawElAZ96Jxlz
	qnwiX+jukAxu8qp1M6sAhf5Jxr17PTczCAyyUQ5eqY8KU7fj1sDxUocRfCZKcGk+usa/F0MVFzz
	A0dbfDhjQFv83dOTzniG8UcTsuDcbOBO2SeDpSeDLb2lJvPOpWUytMJ8K4QrQ8UyHARc8Uwti0Q
	ln3gtHR8sp0WqkoFJG4WS4yQ1hIROaEq+B6R9Ewspc0CLx+2Tp9kYk1IAHp6OMG/4bn/y37lQoE
	+zRgbsGMdc5yn3AnJ1m9R5oMVabTwP7ZYSraZhk+Gt1WN5o6puNaVLhKz0TtZmX1/u4YY=
X-Received: by 2002:adf:e196:0:b0:482:e451:6810 with SMTP id ffacd0b85a97d-48488dee050mr23124500f8f.1.1788427751448;
        Thu, 03 Sep 2026 02:29:11 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm12579032f8f.9.2026.09.03.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:29:11 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH v3] vfio/platform: prevent read-only region mappings from becoming writable
Date: Thu,  3 Sep 2026 12:29:07 +0300
Message-ID: <20260903092907.419-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_platform_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: no in-tree platform driver currently
publishes a region without the WRITE flag.  The guard costs nothing and
keeps the mmap() interface honest if a read-only region ever appears.

Fixes: fad4d5b1f042 ("vfio/platform: support MMAP of MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
v2: commit log now states plainly that the read-only path is
unreachable in practice, per Alex's review; dropped Cc: stable as
there is no reachable issue to backport.
v3: use 'commit <sha> ("<title>")' style for the vmclock reference
and point Fixes at the MMAP support commit, per Mostafa's review.

--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -594,7 +594,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = vdev;

 	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
 		return vfio_platform_mmap_mmio(vdev->regions[index], vma);
