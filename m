Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B848097B
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464224; cv=none; b=cYxpSrP43GYQTMNxr+kDyB82DLcZg901spO5Z+meaO/De2XAHil1/7HoFRnCZvjz97AKWKLjzWN27srb1cjYHlaEvbkQysTG+xV9pdG4/bzWJi8X/wrQFA8gGOQmM8NCM1m6d3+ChIVYmP4AyB6b8UUcaKL33JzqaGavED+ZSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464224; c=relaxed/simple;
	bh=zjYyDPUCOaxpNOOEp3cc8MAqQ/KxpN9/YdTwn55NjQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbluaTmGzC95oTNPpXdcmaKRFO9NnNKLWB1T+eg5tm5lHgWj9jLLktn7UxPg1MlPg729UFiwimNUIdndSzrcpkI76bVDgyU0Hudg507SlpPY37Wivw6jYhAaUWixLyr8q/aD1MagZVtleleqPkD0FUGs7NEtKLcMSE/e6oTWdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfvouazF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfvouazF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so825845ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464223; x=1784069023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYpy9moJ1+tY6k9a9oX2AsYalmyatmE1LDfnjIQQLE0=;
        b=ZfvouazFpWgNzAnRjINTKqBJxFZMsTqO1KkFsTCES8jCyMa1hNOuP4VehxQPn6bCjD
         w4/2KkURKsHAZJEy8uHtMpPmDrUn5XCpxAGxHkp7C/Ah1wT6SpIDbdNjxmHCsh9LymcG
         E1QlVyulMFcFNSHXKEZDLseLdL5Kj+bVEurQwzDIETSqAAZOnXNlFpFUT1s80kr9Vfk9
         XYGjYkGWND+1kRPCewE1zkm6TVF8zR6eTnGabeM4O0scrrdC+GkLDvdragSsgs9yzkoo
         W39LVgYQB7nMSaKsrtDCmSlwlKyCgYSOH/iqLF/P/xQbTLiLdLApXhqYW2WrH/+/R/7v
         ycWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464223; x=1784069023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYpy9moJ1+tY6k9a9oX2AsYalmyatmE1LDfnjIQQLE0=;
        b=oAql5cmmsP+PfZcdU8CTf47ZjZuQvZ5uMX+5F3iWadsjG4etIncAkDvCT3lHXTqpwu
         xnK9sD4kftiwYbVWOCjgPSwS5uX5gSDD0GxqrtSQAsRK/Ga1glKdkq7l2Nd7PXZ5m1iO
         jGH170K5QqF9sRTLhcUAAnDAXxAhkglrKa5H1aZitkueVG6B3XJg/7BS0n7T0CiW/z3E
         oRptmbI1TJAJ4RkRnEXLKcoCq5tzza0B1RivTRCKB9OW6h2m1q69VvHGxvP+FroqP2To
         zd49xO1wXXu28Dejkob+xs0z2fqJB2G6XkLmfyeVBNvgfUcM52+m5/smihz3e1xc71gK
         EdXw==
X-Forwarded-Encrypted: i=1; AHgh+Rqf8Rjl0zE3jxbP1IVlFNmJeo1w2Rqq+0rLgrvhh3MmSqY13tgEQyC7Gw3j0/Zces5G0l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBpaSMTAvFcLEiDKh7lgNRPTj6g/k14tq5JoApL8hTuVW/CNe
	HNcqSldaONsPrwVwmHQdsIS4Q7gJYyrYZJSDfp0S63SEr0eUQGGeb62CX+iDT0oOBog=
X-Gm-Gg: AfdE7cmq0ct0wTAbqMIJlxUT7l25WVJZUZcKyzRWh0Poi/VoAKGJYg3A49o9KBA3uSF
	3fTixywWJKh/1H3XnbNGTGMdwJjJJaEpi4IACI75R8MUMXUNCBjVRiJs4aYJV4tlg2z8ZyvaR8p
	hq5JUunKB06Vpnu7pt3eP91z1faMC3S3ZCoINKpmYNcCZSSAgFz7SteTSBud3uvmwKxno02h6pL
	mcxv0DFYjPzY6opjxNm0uzIdLb98CWL6Ux7Au390B1TH4/2k9Xo1TcIRHL6823N8U3BBseoMslW
	yBhe1Yx64mxmu4OuCk9XYHbcyOKiuYwacWx9SEBVa/EfVenQAwubJ6iHhHIItvy0SSCKsKU4b54
	hyhNSNQTowjA/zBOX96kH6dCH4zLOSPeemEnTuIHc2gUDtyE/jXqw8d8PFCgll17+dfwTq9XEw9
	UYd5v35+Pdf/LnSmzzBLqWoJU0+hCBXztfkTgPl44=
X-Received: by 2002:a17:902:ce82:b0:2cc:89ce:2ef8 with SMTP id d9443c01a7336-2ccbf05bd36mr68310485ad.40.1783464222672;
        Tue, 07 Jul 2026 15:43:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:42 -0700 (PDT)
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
Subject: [RFC v1 16/25] hw/arm/virt: Set proper conduit method for Realms
Date: Tue,  7 Jul 2026 16:42:57 -0600
Message-ID: <20260707224306.1202330-17-mathieu.poirier@linaro.org>
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

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6a3c69ba8f90..317816f942de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -274,6 +274,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2952,10 +2957,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
-- 
2.43.0

