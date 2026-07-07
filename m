Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148948AE3D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464226; cv=none; b=p2sNbyO28U0quJ/VnuLmrkWa5Ei8XS6LO0ycTmE196n8DO+jQ+wyf3snr1afsryBLQEUr5OnLD1v7QzIzphnVahqJKSX0lHvoYbe/VFePD+z/S3hIfCVbUBYIHdSOoE05rg2C0jSmgJlb5ODAoRXEDkdkgOJ7XV2okQMTZlN8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464226; c=relaxed/simple;
	bh=EqCYY92meysvdKHNQ8XMBzHtbVpeX8QyJLsFqlDslk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyBzzx/Dqp1ErqX7W9w/gsGO0ntk4FM6OWeMZx8wN7BdFX2rtVw6AkHcah3OmZWrxLDVSNTSLXrApsRnLpV81uux0HEKX5Qd+2WZXVmKwhx/WzqFJHZO7y8ZfPgXcYFVwWuRnZREOo3DizCtMuYD8h4s6rICxm62N+vNfltKuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmic0aR7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmic0aR7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so17180465ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464225; x=1784069025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hHH9KSwA+9uIb01eHUjZNIVZ+Ljwq30s0vXxHn37II=;
        b=nmic0aR7Cbmv+gT4RcpfKWpm8M17/zE6Xn1tGKdz0RFXh88lKI6FArmf3P+bopRTC/
         vbfhuQji7y8G4vECF4Lk3hklFmz35d7wTJ0UccpLNLs8wb364oS7nqE5d/5eZaMuqUAH
         mSP1gozSFF/SwtYCknoot9Quh3RnGGsaZyVCPojewwpuSX8bXyVRVssWsyIDOdrKhd+A
         nmH9XBCTrE4T7sActBc5COIxuzaIFwdlhKUxZ7MrTMtHwNdtjODsRMspWqXQBZk59SBw
         2Zg2NVZ2QFc6xiY+/0cu/3tqznQTH5UaQmiZVJ/gogaI4ELETVyGNMnIaW/sVF38npt5
         +O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464225; x=1784069025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hHH9KSwA+9uIb01eHUjZNIVZ+Ljwq30s0vXxHn37II=;
        b=gGIdwh07W72odVzeeTZV9Qixk0gneT8QWueoGkHXxbSXlL8QSgt5iuXcHBpqwXwttE
         d7RkCgbGnBZBd5DP4y00y5yzbeoy7H2GZpjAkIF1QXmV015pknY606gLBgR9IYFsbEjN
         09wPF72bu9n5xD4xpYodQ9eN7xTCzuAUSdx0vwVBw59WRp9XrF9iD67Go/5Nac0oEVIf
         q/79mI7C3oZXOE/wySbVN2mBIY13zWUNaOh9kOgtoYmrtCyOvGA174DpOl7e+2z/WuuA
         iYaunqa6qV2hVbuKWpwwVvEo3OS5C3i17XHCQD8YjVgs3/yIld0TOy2n7GvgWqQtDhAp
         Hs8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoIs15h1WHil00aaoDq7BVlpvRIfJyT9e9ZnrkB5PWUajrd7lB6r8h4p42Ft0AeIjJcD2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujI/VoVpwP89XS7kn9M0F0Bw4rCcFKQxRK8OZZMlpcNgvTeN9
	PZCoCx1DnxtPWF2gR3SmTDLkrjRS9t6JFYbO5F/kU6i7p5w53y3WXM+hvC4JhvGT4m4=
X-Gm-Gg: AfdE7cmEzZm2kMGfjjTYH58VZ9VAEaUTB+rZWYFEwcNKdWgpQO5KeWOPyFTKhbA5u7z
	6H032rjw7PA2FWpuqDR5eREbNSaMqscydZsgrVOIzuOLXWGyrTn+DO8ZEH29+KtU0j8Ddj5favA
	LBdRgjgGvdPYHieaaB++rTKIykSk//tJkXdhEuZ5Oc9NVAfZoa36/zr36SIWRzbiz2+jLiXVthG
	t0wsT/XlQxLAnWEDLdmQxx2x5oRTqUj5Hdf6uEQMGqqIT1FwRDmldCKV2+3sdJI6XrSHYYWvdDJ
	aoM56jczAzOfmxNsdzp5nd77nHVg9hVLpOeqh0BYjN/iy/u5ZcxNEH8Y8h4mNKedOxvCymRll+A
	+mASpVE1mpv57B38vIf9I6DaScTYT30t17VXymycsiOE1RG6zTtf7wEI49NuuCsUu2iZFAOcRY5
	pwkE99dZrccIZ1FsuTrNU3NFLZHWPY9ik0zmWqzNc=
X-Received: by 2002:a17:902:f788:b0:2ca:f417:396b with SMTP id d9443c01a7336-2ccca8c80b8mr42177635ad.3.1783464224666;
        Tue, 07 Jul 2026 15:43:44 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:44 -0700 (PDT)
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
Subject: [RFC v1 17/25] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue,  7 Jul 2026 16:42:58 -0600
Message-ID: <20260707224306.1202330-18-mathieu.poirier@linaro.org>
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

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 317816f942de..ac16290b442d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4051,6 +4051,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int rme_vm_type = kvm_arm_rme_vm_type();
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -4080,7 +4081,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | rme_vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0

