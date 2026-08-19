Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E4427F8D
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128938; cv=none; b=jORNmLa89IWFMofoBHso0RbS2gbuLdlMiWjsM5sEQnUdBF8nR7V74bhsp1ZS3PM0zevBccqwa0WNchcpHS+y8Aj6Lc86YQ/lrg3Ucc59j52ZNTEZVhHVBgZWc2o5SDn1Xw/sOB0BANy1X44hVTlf0wXFbJ8TlDdTKlZSA0KOaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128938; c=relaxed/simple;
	bh=UmLSjR5vN/pqFUICwJ0uRR2Xb4U0t7SCQgme0ppWNls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7VJInamDzfP0iEY+zsIaWFA7p/NIyaWdgV5yLiGeSV/Tr5MmhgUXBwj7Sz9b3xlcoDKEkTLch6gK4q6O91EBq8oBbh5wKHatf0enp59msXSOvZrkrpeaUB6dlE759M8RcsNpSLK8G/DpR7XjE/64HMVREzL8cNUDfjgFbNY47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpWA3ep7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpWA3ep7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6624695e9.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128933; x=1787733733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCAXhmh1ysx49XvDb1i6Lpx6/sN5RWuZrnkbED6pwZs=;
        b=fpWA3ep7KVINvy55WUWloy9VljM9oUrDxqO5VvnHaywLrgsxQqderEsZR/mWJTJZuo
         Phj2Rd02KHOmnceLRxajUjNutns5JFP1w3BHxUNpuUlZIoDn85kar0GjXBMkp9BNVxPE
         qLoewrmXeKxVVJz3P7ncWgd9EiMnc3xinvkq8jkb49zugV/X6o21bKXlCNilSMHe0Xvo
         /Xxa7TWA+rErQ54zbiGAjnFnb36B1+hU+DKpIkihDNoPiG62XNIpawKplNFvBQkZV8QQ
         SdLFLR5/MzK6U1LU7wWUSkC+T5bj2IhiZ6JbU2GBvUPU57sirXe94YEg0Buh1u3Fwbpn
         zoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128933; x=1787733733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCAXhmh1ysx49XvDb1i6Lpx6/sN5RWuZrnkbED6pwZs=;
        b=MZ8VinBrUk9Dxschyk4XCL5rRHwhODZuOsIVJV4zHaW+L7dHK70m71rRevL39qrewI
         s7EvUhF1/ASSWB1bOPKiT+0BcxR8beepMy9VNtTPXhcNXoDWlvDq+QBVPQlvMh5Tt5U5
         mMZ/Zf4cx21c3qu4uumF9owjSoiSH8IsCoMGBmuck1mmEGY7QKvYSVGd7RB6hkQeNrlC
         6bO2llVNdmQVjbi/NQAfAp16jbdiQDymOc2h2kQYMlP195YB7UpG9lGX2wYUS5EdN6il
         KOTZCQO84oZXahXK66g1Gq584M31uji6ZGoYnM2DBZnvRwSWWXPnEYF495p7tlOsKfwu
         aQ5A==
X-Gm-Message-State: AOJu0Yyc8NOmOz6/zSfIM7EIHPzWFljkGZPEE+2i0Fh0bazHJ6TM/fHp
	l56fYU5Vv1wq/p1dhbKmHi45V0QUh2pfrKyaP1Rwgz6VNcqMUUWkYOmf/FJeA07Q
X-Gm-Gg: AR+sD13ed+nHue7la2PBRZykgM04SRWOASyt9GLGOqXALasC7jvuGy0gxgG2Ka/fvyt
	due5y82rrzgyV8nPNRQ9qz4gDOtoiEsqf12WDq5AQJftDR/52pLPu5TIls+G6ZZQHfh1H+okEoP
	YShYI5OjHWEpnhvhaQ4H68S5+Dv0FzV2GX6NAEI1mtXmQpV/opbS9+DuOkqhKd2101K1xoDkIi+
	TYDDZk/zawo+xhbIl9vDIdRj4/v5nzmcE2M9oo11Y+Y2L26U9GLlCUsN42PjeTHFPHZVqyzev9y
	YmUGypE+m8SO75t1aoYFFM81Tc6bSNzY3eFpfhmDzJNK9ZLkapX0X5+hmUN1wlF18govtWyYwot
	HzHd4dNPF6H+0bpVFEVUNhsGWSfBijoslJaoaVKCgSy7xiAzeVQJJQj45RMDPq9DM/L7VsaHues
	7xaF15z+/HQzZbYUhOxgrNYs3F6iUu4fRGHQ3c5JN0K+5n2daVmVnl7FYPoU6WLzl6NxoADLN1D
	zcb0oI=
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-499aa1c7bafmr53853455e9.15.1787128932584;
        Wed, 19 Aug 2026 01:42:12 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1947c6sm41093775e9.15.2026.08.19.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:42:12 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com
Subject: [PATCH] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:42:09 +0300
Message-ID: <20260819084209.1543-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions (e.g. response portals) the device marks
read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: fb1ff4c194157 ("vfio/fsl-mc: Add VFIO framework skeleton for fsl-mc devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -406,7 +406,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = mc_dev;

 	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
 }
