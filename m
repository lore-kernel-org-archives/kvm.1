Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3651589D
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972458; cv=none; b=hWDdGRCLttB0BbjoWaBuu6dVwlwRXNaDwRHH6i3e9mtasdznM4EmdQ8vVaSd7QC8sa59J+ED9pWz3ivxx2T7aXcIVUIJSQq1Gkszm9dRMxTovO5qhvtfABFqiTW5ufBJ/42RT32NYQwhIWCiBua83GWr/EIHrYj8aMN6bHIWFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972458; c=relaxed/simple;
	bh=tVuSTGmPjVcRD1KZHJSnH250B7r46QSNADF9OIZqOHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/xJ6xBzMdjKElM08ntiH6kcIHeKxe2m9IVWYk1E7hUBIkybJNZ27iWujEeTG4HPs55cAEfy4ztsxnRj8wibZZgDsUip4SVGUdMAxGoyf843uwlpYHsVcE9ZnMeq0c+6DqRe1Ccorfh/1LIsrEQgFYi03hVBwwZnISVioe71qcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zO5jLjP5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zO5jLjP5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e4a341d177so1692725ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972456; x=1791577256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZF8fC0jHy96GLAa6nYvC5U705z1kSHOy/j/N3xBALMk=;
        b=zO5jLjP5OpNtw75+aR8XaFbEaBMD1gD+UK63t7nXYTy4NUFjA7T1Mkch+74DBlyI37
         dB9w3gYGoPSCfZ7hgCM9xAlGbIxVymCTxYOEzEpIRYjMy3zZbAC6nwz4sb/FGXUcxWfh
         l9JggbBugGySnTp8NHuRtZGmbkjoV9Rz0G3r1x9CD4ZrLedYvny2ImtH52857ZPIZvs/
         QU//YH+yooEFQg7WmxOc5nmItTFDp8twRLOgUg23BWJPlE0sPZSKxbSIZCSnxEvn/39i
         wVNDnQu3UwiJATfT0Fvgrevf46UMk39loDXjDRZzdrUTwfUu8Cpw+0uxdNR7ZA8MLapu
         q52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972456; x=1791577256;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZF8fC0jHy96GLAa6nYvC5U705z1kSHOy/j/N3xBALMk=;
        b=UQN3XyopRFbJQkvoMgskNu0s7MIspJGG3DsiuNHGng4NUqmveY7dR9i7s8Txb0KREt
         z+QkXyhG+CUBlMhPIblxRMqBeZlZ6MyAXurK1rD6N69Ln7dkdDuG1gWQUrUib33MuiAd
         VV25q3/0fxE5i/zME7iyvEO7H9qZQTrIDosyz70c24uwzFvHTxq6w9aUzwdJa906H81O
         hI68G9kGv7rM3VvDu+ooNlYVqPUlJIP2df5Yp4yzdH202jo5bVaaBWbX/H5r0MMIQg9+
         89RWhU+Qiq4xJaXK9jztRlsGWnkotF9xqAbLwuV11vumfW/pveLdp8dH+RTFQxG4Tip9
         EnDg==
X-Forwarded-Encrypted: i=1; AKwUvBzNxEkId2HS3i3V4xmUKfkXx1p0zA/F3tdoI8Gx1iCy0sLkURkR4fuhySU7Wr70d4PexIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGD/A87TJLQIjpkrHCscwkTm0Bo6/D7DwSzJqJ3QVHZ8/n1CgQ
	WBYtdQxOJZjqnKUkiuYuUIKDUqayTTuey33K5dRuiu4hBJqNm1UI0kpXoV5HA9ZRqzE=
X-Gm-Gg: AYBFou0Jsin9yP+6T7BFtLQwskJnetAD0K+2aSNEcE47PfM8PuyYtC0X4Bsg84cBb2L
	c89z8spfiMYjEMa7veO41dewl/P7PsZV7vm3iJnZEbfOxDm0icxGGXUifh6mPhgq/IOT3T2XnQ2
	jF7gtlPFVR7yggkbpUqvkcK1SNRw0aCN3OA32M00m8loJJbcD/ZShQAx6pE4kUYqS5irNXxl6ve
	GzuEJvQI3aPmsvNBqweF6RIMFbEw/MpqjyETFes+fDtzLPpqr6W1Jadyq1r9ZN8WxXFgCw3ma0+
	CW2g2v259EciPs0FK31gdFeneNyi0tN9NpWbAyXeQOXZyh+SB5Bv2v8FRrIHisYrYvu4c71gaK6
	OszbG4XdBvjvzAUfV0sscc9X0YMFhC/uGe629NrTvvqE2Ira+Ji/efTceu5qseAnYOapHYm4Xoj
	wHPfenAIth9sYM/6L81xn/CzRPg7/pH69QcqmpAZOB2O0ltFkUNuU1u9DJ60MRTz7uVI6ORj80v
	4qvmV2fJkoq8mnlOi90mteNSBfQ8u0SjQU=
X-Received: by 2002:a17:902:c947:b0:2dd:c053:e0f8 with SMTP id d9443c01a7336-2e5106142d1mr5307805ad.39.1790972452627;
        Fri, 02 Oct 2026 13:20:52 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:52 -0700 (PDT)
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
Subject: [RFC v5 13/22] hw/arm/virt: Set proper conduit method for Realms
Date: Fri,  2 Oct 2026 14:20:17 -0600
Message-ID: <20261002202026.1204110-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bdac33a1de86..5ab4bb23ef2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -272,6 +272,11 @@ static const int a15irqmap[] = {
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
@@ -2945,10 +2950,11 @@ static void machvirt_init(MachineState *machine)
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

