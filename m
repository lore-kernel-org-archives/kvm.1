Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76153612FE
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128926; cv=none; b=TCOIimN2zQwls5bXl5GwyaRA6okfR1Lxx/zV5QW436+rfslvFp6URak2tmFag94FlWN4Sgzkx0QRaPOhZxffDMTNrZ7FsowBbLONF3nTKK3t+DAe/DsTJz+8B32VJ5U3Pc5l4InG16hJgvLtiUstOsxk7sV8QLkXrXo3QKH4Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128926; c=relaxed/simple;
	bh=k6veVcbdMYtnCTYSPsQo4dfEkHOtd7/pm7jM7tctsp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDSddYFGsqZ5wGdxaEUBbx4a4+BS36s/+pRYomy8qlU+SV/RuN+gRSn8iHjPeZPjAzcXraNtZ6XNIkY/7ozo/POKxtrKxnunDvPGeOh9z2FdXjtmU+D+JSr2U+5569219VIgcEZCBhFxcst6BZLqDlEGAgWCXDffpXF3vYOqh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6bqKiHN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6bqKiHN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13493085e9.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128923; x=1787733723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fje4etQPnJMZ273NClwRY+zJPLBaH6wZ2nXYH67K/58=;
        b=K6bqKiHNTDajHLW/1lYQFdK5Ru5RBKYLKTKABZoapz7eGSW5C56BzQoMXO5B8GUOwb
         yxWpvb+e6FC52opXFZdH50usesGxY5VF/MwIPPfoDaU7Tj0LEdvTfT+PscJjCkUUyPOI
         mGZJDD4gH7z2oAbq0zqLqFRrIN8W6lry2VdXXWkA+Zr/q7JB9YXeYT/pfxP3mDEI9i5t
         Oi3oR3gi3dmWGcVijeupp/rW3UxFny+ufOQH2heWp8SJxpfspbDwhymomUqYwLAEM+TO
         KDXkZcwHYw4Av6LSd0/POXT+Tt6mpdz84l0cN7q2vrSwyz4fypAmQn4yBOTi70SqKeaw
         yYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128923; x=1787733723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fje4etQPnJMZ273NClwRY+zJPLBaH6wZ2nXYH67K/58=;
        b=Xak4tl1RwTbrel2lXzj0keIbPxPpH9Z39M4fhwpICHJ2WiVRk3h7kmVfQatqEw2bLS
         N449qjT/xvKD9aAqdf7/cIPYunQsd5+j70eXozETEJDxfYRy/YOMANxge6FXj3rpe82z
         Nx7v3t91PiNcAN8uqth4IGsM9oskCJB1ESkfARdtE3hX3w7BfQ2ir5KZpruIQ+fGXnbQ
         mykMBlN3TEMHuisuP71nIdx6Pzq+oILByzGSmR3gA3R6VlbNgjwnjBblPn1j1PYO+W3f
         BfSmW5K3D89iuVrgFC23M6gL5yJwhMiet1QOkvhPGV/WN7wzo9v2iRmtcZdKOCPU3xqp
         /aEQ==
X-Gm-Message-State: AOJu0YxoeWEALIpS6Ff5LNlH2eAGGYk00A7xXILdopaSble0wX20Ugtk
	NyqaEW9B99Dn1IKGzer/v20NQqRmYNzHL/lrvx4KSulYmfrqo/9ViSSzVPLtrMOX
X-Gm-Gg: AR+sD13sxQIyjVnxFLch2SYRu9/zxsmql0ISGhaYiw4WwTZjxzt/ilhFT/E4ZPWkyYA
	7uq7nfEOAKXQrtG/zIvVMY04TspA/YQD8EiNwonMgtx/Azw2/Je7R2QbG/JT5MzgIagED6cQhVY
	bsja0eYeF1XEeoaZuhFFcp4NumSaCa+ALAO7Vl+ddwz+IMFkroSjMNYPmYoCdSxV2+C0eChqM8O
	rKVNfp/MGj/36xZxQ8CXC50+CfPON7EEM19WtzD+TGrro9VeyBJiYWh0ljurRb94NfCLBYBna4H
	pFBq0mhatmelWs9OOl+e00R+ZpyGZeQuW3czMEM9hUzFbQI9P0NncIgFcilksa74W1q0SraLRYD
	Xl0tRb5sYil1hMWRkRGcCnlQPDAC2Bv0IQqkGNaEERMmsdMhMkWHkcLPgQZ9cnPfHgJ6gpQkHI/
	J15+Yt5QQBjb0yYLnPHtAxLYei9fXWcKEfe+1ndZ9TILUPFFZUA0r1Axq0TicL5JfyR/uov+Q3l
	1/91NeGiBVnsoNuWEs=
X-Received: by 2002:a05:600c:528b:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499aa0e816bmr51270105e9.4.1787128922808;
        Wed, 19 Aug 2026 01:42:02 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm64921775e9.3.2026.08.19.01.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:42:02 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com
Subject: [PATCH] vfio/platform: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:41:59 +0300
Message-ID: <20260819084159.1509-1-suruurism@gmail.com>
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
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions the platform marks read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: de49fc0d99e6a ("vfio/platform: initial skeleton of VFIO support for platform devices")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
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
