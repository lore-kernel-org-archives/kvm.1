Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4966518142
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972470; cv=none; b=HN2BN5Gbl9i61TkzDo1kwsKHcgJx/zuvp/LJDT53XrlaCXy4PLyYhNOYegOmRermy2oeZ+tEJxqF/p2Bj/8WEDev0DFGoGsFW/9M2bpfxgVJFt2ZQunSkpuUH1MQ7Yp9YDD81Hy/LODWuP7ia1tQ43WUjeGNZZI8cnFWtS0QGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972470; c=relaxed/simple;
	bh=raMsDaYNdJirhs5aEJmf/QNzzXxHGIZgMckH+xgNqvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joaVLlHoyM0h9dUnsU60ZtKzJaqoHSyFJN7yne7egLC2S62uP8Iaq8wiJAvz9kTc00t9A3Qhcnsb008yCIm22NnD6TP1RnzFRUUspWHXA/RU/d0Ds85GEfbkiW1WrneYXch/ExI6rZvFlHeBCBhY0iGB4QCgKD2kKkLare+dC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmMzXHkI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmMzXHkI"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so453a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972468; x=1791577268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=AmMzXHkI73/nzGTUXI6wbQR5YBqaIhMD5ebaltC/f2bguLd9gdhqP8a/j15lTQjr8J
         lOS7NT3k6yox9IPViZeOqeN2Un+9kar3Jj2QoWbFMhTDnjO7sefXnUaXt5TrykGREMJf
         7VZgehE7+JAwnm6eyMPvkv3cw4uDNWL7S+ULW3nC9xiwFVLiA4p6ibxJp3Zljnpk2fEA
         qmuSxA3yIbrvYT335gwMSS255NpkupaTmGsgAHCP2cVDe+U4c3vHJQTTGyUERbpN1dPU
         BFzubr91NZu27lFrp9cFOOiK8UknRTyfpMuHJ+7oDm3LHpMbjOK+WiLysB3rRMRY5ByT
         fAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972468; x=1791577268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=JUU/lkD3IJ+/+xn0htmnvNTIZN3BXSMnkBbIt6JgobGRNEUFeuZXqnQQfhAWUsIpVJ
         TLsytfJ9zE2MpUJCxgjGarY6fFlOT9SkW2uaqj3zzG9RmxIHDH7ntI2sON4pn/RrwH4c
         H+JK/8qMALznppNtK7Sg0bGts7te7vG5wDbEg2daMZrcoLEtebZ0gihJgX4e9lUknwTT
         6xaTFPuPn6bOutcFSfA43cb4IAePOlttgu3wE7/73ngX6MRQXNpzn0Pgz7umWBS9wJdj
         c64XWB3g3Kpb3tqFW1jZSQBR7o4qYfZtgN1B6AKnhRhasaz4zYoqx+r4db7tKfm4yayV
         G3cg==
X-Forwarded-Encrypted: i=1; AKwUvBz+e0n9TJAo6pV1Sct0ihL73opl3we7Gwh0cPG1+eCnIQNR29UZSTLq+JfhT+Z8D62pwz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGEqcU+VmaNG1hwK9bEQHAYZTde6zoYoPkHHSAVlFlTZ6jBIDr
	gBdW8u/tKf2pcA/85vDt8PeyRbmOC5e/ubVgESmvNX/lp+fUrHv0bNGpxC4SXYe5kYI=
X-Gm-Gg: AYBFou0c0SQv7n+oSkyOxkcj2xVZVxObqcSdkG22AEnL1Exo/IjM8PBc/djPi5jejwj
	N7H1r9FrQG/hGoVeFFBM7lBi3WnLp7cz4jvCv/7I9c7s+YRHR54gcKIs2h4ka+9GEo4G21ZvBNN
	QrN3QSz3S4Isl4tNXaR+aKX6oxbDHeAykE6CQDYbUiVGnF3FuZy9HIYMFt/SIQ3FCIB/EO5FIX3
	eWPP+HYwyxec0vdn6zWQYbxKd9l/aGPqNp1Wordsd5uxdlGWLSmUa+kLZ3keM0En+5BbtUUbRNi
	s7v4Wg5c3y3LD63BDFi9UAO0BYyVgrDv+j1t3O7W47oCOYB7cmkOHnouLW3oVw47i1+XG5Rzref
	Zezpf7nNSGEdrfRhW5l3kLQcx33vuOD9y+pqQ4x2OfQpVGW789yjNQ9tivBUxgsdKVisZl4XoEc
	oJVYpjBRbxeR/Bn+6Kr+M8ZXM6nh9+2W5EWhN8hHiGo0DJNHLfVV8Jt4QfUNvEKJjda2JWofOnE
	20rp6WkOXWFQ2+xyirkVzlUlA==
X-Received: by 2002:a17:903:1a2c:b0:2e5:3451:56f with SMTP id d9443c01a7336-2e5345107c4mr705995ad.47.1790972467740;
        Fri, 02 Oct 2026 13:21:07 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:21:07 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 21/22] hw/arm/boot: Load DTB as is for confidential VMs
Date: Fri,  2 Oct 2026 14:20:25 -0600
Message-ID: <20261002202026.1204110-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e8efada209f..9b3d3558bcbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.43.0

