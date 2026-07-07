Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA3481A9A
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464238; cv=none; b=FccKFxb3ZBKYSwG9UoGtafz3lr/9FNTslbZyF3sgYbnKOwjkwC7UP46MiafoS1ep/1olwQ5Ef8X6Ki9vDtf+L0i0tU9sFexXLPIc8eTLWGlmbRQfXS6ssa/2vlAwIfG0jNYeug6Lrsp3sQgxcMWbOlRdXZ7RZu1iBJIrlk3VkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464238; c=relaxed/simple;
	bh=xan1p8gxZ/Xzpw4NJI82wKacTFlwttw2dpQ0l5u69D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShpIHooOc0330QbYVEuLjYWcryM41cnBNp3Bso7weRPJlw8EXK8uMETM8EmK32vGW1dTezZbkoSHXMiRT2r+3vSDbsJhhXYqTm+my1l9JHtayA5Ol7+5nyuuCCk9xDd8ZaEbrrDutqGo1Gy+9uN24WtA3VXEW0bvnj770loGhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLmeLFq3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLmeLFq3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so1336815ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464236; x=1784069036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEMAHfk6jaAbYfFhNuqQUXCY3WLt4ZsLh5ZzvB9z/oI=;
        b=wLmeLFq3pJpVUirO4dhxxlSsDBaejNo7S1QnU8T2c2S/JQBRa5CzxPxR4LG2v6eHVj
         JaFx1s54XHIOF2HcqMNfuWqLj32EvP5QVKe5poG80QsVxNv/Zk4P982GJG/85HxdNtvM
         cM18fHTseuIiRCqwFAD7wgkhx6Iu6Nq29c0gnqgky15k7LMBtBZNaM6kWGrvjLFnytxx
         XkWko5cGyyDoCfsE8LveGBJJf0fkX/o/LSrKh9QPsAGue1Liq2i8E97/54ZCOULy0LDW
         NjtMT+m/u5E7CxLDY0V//xyfvmPYscMOKDm8LlgkxzAi2cQd5OTky5QEWqbywj6djE+Z
         LNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464236; x=1784069036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEMAHfk6jaAbYfFhNuqQUXCY3WLt4ZsLh5ZzvB9z/oI=;
        b=HJ47kEdCGiBPMShdO0zAQhmPSfZSO1RDyA6D7sV3SNzuGLTKg8+udO0mnnJmlwTloX
         umtY3JBnGBGDZGcAnnOUXNuUCKUNsCnbbWylSfGnXu/oKAUZtTFmP4g3fQrmCkcXBavu
         /uMaR3MWARPozIJyly9V/OYzoO9Ellr/FovbiszxTkxk+PbR8jqA06rvTD81yxuvWJ/V
         r6k2cFnfVKIe6309SdKDpXjuClwk8XjBVJWCmUMiNNcY1V4Tw7CW3DHAmkTkGAuDczU+
         zxxJs+P2tR5ZiuouXOg24+YS78I2EmS0tcaoPl8v9OPy9/YsG9ePCQ+ZNOYvp+ZmQ02q
         4BIA==
X-Forwarded-Encrypted: i=1; AHgh+RotXuLKNCicUPSVDim8Z+W6ojMSyD4jV8Ag64kH8KpA1ApegIgTg97qDqi7Opxewvcu6uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1fiuaxj1ZXiMNyfO23hTIQed6iRlsIiv5YZMxyjZCvy/Tl6q
	fjinbDVn1pFD2VBmzQ41RjCCS3YWc1gkyPGIDFMpGTGVqsGOqBzq76x62iOKyRv1LNQ=
X-Gm-Gg: AfdE7cmEsJL80JMCRQHXjzT7IWtLTxSGhnd0eeA7zU7RAXpLrj/WpmSVi5mjFreIesh
	MrUX1q/yw3F0bHAcQxClzKz9wvFWpwLINH2fZVwFjfRIsb+UtAW8XgZtT9viubq7WdbhsTXwzXU
	QELLZyA8jhT3qrSh3c0CkniG+9uQWi3zTh59+yGlS8ysscn75z7NbNSwMHVEP17Su3qjb3U07zY
	V6trlbHcn3ecJqaLaF7Syt3wgHLL1UwhE6ZMcq/0DGuWY9zOlP16EdyR3z/1tyyww38c6962FLE
	zfcFPwWGLx+NhOCznDmI50jIzXkDAk/gr/X6HrjIUziahb6LL7s52KqfUkWcmDx3W5KP0SveLmA
	0YfweNfgQYhgWLiNVVxW0P/npUwqdvEUH5eX5nzltzrFmYThsyWwNrTDDJqgMu/0MQvDTCz0jP0
	7Nr/ymc7VjmnZFXmqPq/ipFM6i8/x8p0R1p/ZTpSQ=
X-Received: by 2002:a17:902:ea03:b0:2cc:76fd:6537 with SMTP id d9443c01a7336-2ccbe50cf7dmr65254525ad.2.1783464236344;
        Tue, 07 Jul 2026 15:43:56 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:55 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 24/25] hw/arm/boot: Load DTB as is for confidential VMs
Date: Tue,  7 Jul 2026 16:43:05 -0600
Message-ID: <20260707224306.1202330-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
index aea044fbed9a..aae77870a5c4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -478,7 +478,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
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

