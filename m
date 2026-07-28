Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E78474243
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266846; cv=none; b=C5cdTLxMot0SYwHC9zrJWBSGoX+ZtekZ5CEekeg/EGgAIZoaXho4cEjjtUnm0eqdU62M1PJMmL2RW22Vecl61ilRmMtrTEv664Q3qkXgiMeSAKfXeJ6cgqdlts2oVA/PQcKc6xZnt2gGwaw8ma1+g0a1YtYsz471ArmRdL4Dy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266846; c=relaxed/simple;
	bh=raMsDaYNdJirhs5aEJmf/QNzzXxHGIZgMckH+xgNqvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrmrWaAzfdzUB2TTC1Z1UUAzERUBNuJKqc5Zlbsweq5bOUhqmbtT8qgn74nwDMXvz4XqBzCZN7LpGj6yBW3OtK5HobCqyx8L8sT5G/afNi01TjxSDHvXlS/nbST5UExk1qyAbJjKIuwB4xisktL4roRp+TZR37ZFr2VPj20iuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x+bLbo5K; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+bLbo5K"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so201663a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266844; x=1785871644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=x+bLbo5Kgr7Q5vV6W54hTvpr7Nc7fUcK4e1aogQkiV3dIPN3M6UflQn5DKbOlObNTZ
         rmxIbLRGKEKsY6aJzsTV3fq8uGZejxshfkXGYXNuHXCXFDhP2oPgkwZvjbfaoi5Ni/cL
         1YNaxURDJUaDDaIKAf4tbXhXgXBDgeieqmXn6QG7opz6HXmG4G4ov1o+MN0F1iEGCIqC
         wzI3Zn5L7q4aWG+0ESp30giTWIRma0YiI6kb8DdGz28sh5dZMhwxmTABEVLoiedAPzTy
         T/s3r63tU0Sq1OZkYkUDMmBT0jsKnlxEjcG+B/2P/xJqNdFf57rfiPPy03tvlOaZDnMo
         RKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266844; x=1785871644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=a7AXCP804pYgeHO7VvpnkoAa9Fp8WEK581JeswkxaSGLJHvbGZTep69PODR3HxBsUM
         1icKx7I3HqZCCtOQcZESneImyXMh4S3ICWNP2TclVt9P+Z78Zc5hxplhNtNI1QT/n3Ol
         +LAfzUTx4/craZE/DjkNpvPoJbJzUTs+i+Qzx8kzgfbh7kPYNJjdsYLbysH75UUOtGq/
         gSSRRDAqdSYyfWaWUVuQeDzuezQTzJIkyKCbuLJy/Rsqe8T7sEp3hrS5fueR+VEa3FvA
         IKCGTCPiQt4XHHUyT8VC4LszV9hIbxnEGkh93N7Kb07FbVLAaPiPiGRX5SjRDSQ/1Jhl
         nHiw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Ss//ocdXr3rnJXfVU1LnfEFzVVVgU4tHnVWuBJ/pWaByOZG2MWAORW2V6At9ri25J/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjyRESp1/COi7TFYET8Avyvi9rHeAo9QoG/WbgXo78VstER4v
	HTpDcjfMeejjLhr8lQOzkl9AeXZTT4rWWhzEkBWy0M1ALpc76nH+ThFWSNItWDJIvnE=
X-Gm-Gg: AR+sD12pmXx75lsKWalvbL/Sxue100OvJY9ZWmdbp/jy2cFLZ/3+zARqAv9Vwc5hsvw
	B2CoygZfd+tv75Y7tl+xV2pbsi5VM/5ind2SWFHt19maFRztMiludir0VKttK26dD2JRYSb4gZr
	y7QRBVa03RMuxCZVK2LqHZZBhB5fCNdDN9TZLtZiRLbrPH/SJ0IqxkqF+wiZeqEIiOMJO2l8v0N
	xugQsqqF7umIB00F94ClcgTcdXxa4jXEsI11tXwOaW+phjLbLb9yjNIPiAI3+DAYwule53hEtJ1
	TSTHzCMKN1KrKPG0VXsScShWIL1NnynCmrkkiPIkRtNWRM8uA8VD+FnoAb6N0gjDcdaQB3tzH89
	Gx3OA9Lpd6GVx6DV7rdHhhScrbw0Em37JYWpZPQiUGrkkqId9js+hdrubLmAJ6Y0XBTQOp+uHA/
	63pN1LDKilsgIezDjj5dD1M86EXweeBnJYg9/ufbi5Jelgql9/xtQh3Uz8wug20cBoVU/dAX5He
	PJYKGqn2avSsD8=
X-Received: by 2002:a17:90b:5864:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-38f6a1becc7mr3877953a91.0.1785266844304;
        Tue, 28 Jul 2026 12:27:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:23 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 23/24] hw/arm/boot: Load DTB as is for confidential VMs
Date: Tue, 28 Jul 2026 13:26:29 -0600
Message-ID: <20260728192630.240375-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

