Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B4392C2A
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695318; cv=none; b=U35WnwDuE6VPYPmyfBPZ0ssK16EhGWxHv/OE2WTNAPUBoQiIwjHgTyHy/Kv4gH335NjFbR/L+5CH6m0AUQ9lQOsPhdp2kUobRjXFmapbvH7gU+lD2xCPg15wzwo67461Ip/nZUE/RDZySEhGoUsH4HniOsORZlw90Suk5ouXZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695318; c=relaxed/simple;
	bh=uRJAqWCMy4TAwpXhIaD5UnqtRSrJNRLqpBGRjVM+pxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st7TsNozcUzPPUQzdmMG/dxnHhr2U71nmA9c+3jrmF8PAcc7RiobF8jRw9bYCWGxBziVbb0sKMCfVZhTOgLnkZjk0QJAaU7iAUsMuvktPuoSG3ddSoVw/jeAtJ84IuOmRiwT+ymmm20/9O5BNEdCO2K8urk8SfYWvmukCNFA4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvTdNox9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvTdNox9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e58034d05so380137a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695314; x=1788300114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjUwK0GJ0a5oiNGFlwfIXujzN/1nEJAAx2xEhAB3eLA=;
        b=pvTdNox9hN04vfO8NCWSfkDaNg4/XIztICdRC33VYi3LKFXuIHTOqbq6EJ7cAVvR9p
         swKMJLjU+JESV7vCAW36FDevXRD02jAEhKeeLt8O5GEil4HqWZbzOG8d1cDdNIMQZTDv
         gb+C2weqf6INMxeEx/+/NNrt6pFW3PD3DKJEt6iH+IKphxkYW6G1sMA3c0l3PwLpzsDK
         0OCrmZUkTbGljwe5h6TvsIqQLzN0YwrIgjCcf7k/tOFlP4X5r6LP4jis88C9KqmwCxCs
         66RrIm88Ld0538Aw0YY6cSoofFluitEe5OSE9kUr21Hg7h2HJUZMOcgBwLoXvwvOXPHy
         5OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695314; x=1788300114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjUwK0GJ0a5oiNGFlwfIXujzN/1nEJAAx2xEhAB3eLA=;
        b=LcpiANifrQteA8Cj3cWTtaPPanQFYvQbIgR8ievbgLKa+UywqOgYt+i7Y1eOpYdrwQ
         mGsaQvRF+K75VaWp2sOdyBvnrtCUd2Al6Xdgk4O8dUfrdzXELah5KuHDY5YfzT7hUzs7
         JT5yXaFsL6Clr9peHU8plXIuf0SNjcdj+frXOaOqBjEpkeVSDJAGqYJk62+vLXBDwGXr
         qzqyq56IM1dLWYytgW13nvX4mUK4WMf2awM/sot2AZhV2UymJKNvKmsd2oq2aEw1eDOs
         O4WSMXsCRHZk1JOIEe5QvACM2WgCTbg5PpgFAY2Yns50XJCFnWJjku3UBTSQm9yprzFK
         j7NA==
X-Forwarded-Encrypted: i=1; AHgh+RqEZAcHL3JkrUTCbz/gGt9csFuAp2YOQtJo0IB4s/26nta7TwawduCBqPnNH0qAHQNQvkA=@vger.kernel.org
X-Gm-Message-State: AFuF++lNytkkYv2FuHYyEK7a23DUHpz/i63kqNS8vcIfpIafwbG4IQEX
	AVNy3sYsSVvoCuLyu9csALPSa+c8eyHLpB41kqpzFTkDmCHfA0Bo7NJPX0edPeUJ3yM=
X-Gm-Gg: AR+sD1132wazWCiZNkvHhh7eULabQHG7y8AJryixbyJeiCAK5hp7IkcXxriajBxNT4S
	19haYKn9MCQV0GwSKURCZCbUDUkWoeQ65uLO0XxztABt+3CqAFuJUdbNw7gR2Hg6dCQCie90oUm
	RWmaS69iDChqlK+JsBG9wkER1uKcvC93Gm0QNW9qQ5qnqKBoWCUQ3/Eh5KZKdMSakVLAnNXwwVh
	n3HHA6SygJhC9bB2I09EfZ++VkVHPIl5NIy5eV8GRPgHTjFX3ZV5b6sCyKhIuZ46Yv85lg9Q8kH
	5Uduj0a7kAHcmIMKWQjuYn8fgU/YmFVbiQwsnu4tjNqvSydoSL3Bv9Q1xDerwgcIpz8/3i0FByI
	9ZUnLwsjQ2otsEIlNSKCvWZce/rI4fRYyTWwKmfJx81KMEhxpM8agPIbmlbQyoH2mSt/+ewxGAg
	qUglLorGeqHIr/pROyvEZMgK9Qlo+Gmxp4/MIEKJGLp2wV8UylnMYG4Pu3v/8pq+GvxpQot84yB
	hf1XyMOwyDGdP0=
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3966d002fffmr4328291a91.0.1787695313671;
        Tue, 25 Aug 2026 15:01:53 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:53 -0700 (PDT)
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
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 23/24] hw/arm/boot: Load DTB as is for confidential VMs
Date: Tue, 25 Aug 2026 16:01:00 -0600
Message-ID: <20260825220101.3443954-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index 5e85be2bb462..ad588121452a 100644
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

