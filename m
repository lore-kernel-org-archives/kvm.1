Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B968472F7C
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266832; cv=none; b=l9NX71ypntcPdoX8kX/c1lZ2ozYEP4xEAR3OeeCnaV/6ADEHTuhi8AjzH+N9AMy8iwmoaLsccGyG5JvTsm/n4uF6rq1oBgvl74Cgq1+pzte63HZml/P9rwE//Pg1FcxuhfgTz8S1rNOMtLaS0X+NxgzgSjaHn2ochfgeq7ljLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266832; c=relaxed/simple;
	bh=sHw1tSrB1z8tsdZ4RH8uhIOkIZR3CWxIVXoIUySiGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvGARuZoRJKl0/nG+w89LqpmIqlfr8Ir21OZLp/2kokp7t/82+6zhHHBHM/pZVY1HQm1IJEfEW51fMQtNnS1uQijUoE7M9Hapwrboorb5WaU6gYIdB7ZfLg3wsM0e701ZgmKkv5yW1LRmY2PDBafLoiugW+QWq5YNRGdVv/yY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B6TODVIW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6TODVIW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e347638adso231659a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266827; x=1785871627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKkplhtluFWmCm3zdoFzjKyPXsLnGiTn/fxUme5nI1g=;
        b=B6TODVIWIqxtExRoLiktA1KzSQKlTFZZk1HNLEFjNTqsVqMmC8KuW5h4C1/j/YBg9u
         q/aNpipd6L3bE8oY20JeyoY3gPRG3meD3sKR6T+kCG7tcKTOzg8eAAuYcMpTngNFK1dV
         4UTbaWTOlLAdLM2+bTRjHspGyNqxW2pG4MXNkmZbGWq9z9v8uzQxBbstH1zMDJ6Im8Sl
         6lyS1GVOFcJ4081a/Afs0lUO+zb+iD2YfO1lARpYLg0TF6vUSkKqrGRfMMgnwM8mQJ2+
         +8pO/Bo7IVuxP3KhR3nsTmujR/XY7wl9Y2SEZGrwX/nEaud5PSQpXzleth0qcxkJJW+E
         JsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266827; x=1785871627;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKkplhtluFWmCm3zdoFzjKyPXsLnGiTn/fxUme5nI1g=;
        b=n8IIbVfiUYOqoMt3pI2k5K/BB0OvSHI7W+0YgXoJ5vEyyahIVKUqkyaJqVSVE4/0lh
         JIez8N6JRTcsqnnNR6vLLOAFGWFExj5tnJfBoHMEVVPtb9N65wdIYzCxc1BoJIAizBZG
         PL5suqrUT8C858q0Ywjyi4/4MaxQ+6xvWRECzslOphdRoL1SPPQDMZg4e92obHqkdwJe
         cVAGT3Xd8VI2eC5yHBNhJm5bUuxj+0tT/2q801fxZ1zcRtbmj5zYXgTO3VGuXH+gMVL4
         eMDdfNRi01Y1531zzzAAodHsfPIhnRT/uEphWtvI8yOhCobMx81p7kqGDoV55ybef4Pz
         MpKw==
X-Forwarded-Encrypted: i=1; AHgh+RpndqKNgcf0vRF8IK0vl5bpSPajq8OXlOR3whdJU34iZOY8V89TXG8/YW7c8vwkW2r8LoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hnAgpbnh0tq3TnFwWWpJp9BAwOK9FiF4Vir4ALsrh3agZh1l
	EyEzVsTMvjg3zlJ8YzR4yoWd4fQkd+kwAX2ssY8bLkEM1TUu07tiTJa5Fu1345UHqgA=
X-Gm-Gg: AR+sD13CzA6cHV02XIuUxAf1P9vWWq7ztbrwhfBS854mW+6F6sdz9we+apkCD2/WbXe
	0qdraol77YFnHJd1LSg+ysQo6LduGWUCZMcVe4pqkJemtV8I88/SPWuYywAmjtBwopfc5QHsUHn
	xC7kFyUDa4k+lXrs/qn1Bu0LOJtS2fy4af+kAeae0cVT+zpSZ3sD4PCKeutp6PMWBZLZZURV/5Q
	pPvdEl1FglAXZY8TYd4lIbMXwK3tjeXhGRC0eCBJ0J+1TF6+R0kMYJ3yks+P0Iy4HP8eF7leBw7
	3wQR0tcaM1FUjx7Zw2GThmvhW60odvdwPlkO/oR7biGYOXTPM0AuKc57B2Wpwihs01MWzvXLdms
	7nBITNWQh7HYtU/93mboT1uboO+xrLdDS3LBBPvjktB9s3bAWyM/y6av+uNHt2Mig+OCsCnI/j8
	MVYh1HysevsUsjELp8ZKRob3iG1nPBnMV3mHcD7gs=
X-Received: by 2002:a17:90b:4f91:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-38f6a51c0c3mr3700949a91.21.1785266826646;
        Tue, 28 Jul 2026 12:27:06 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:06 -0700 (PDT)
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
Subject: [RFC v2 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Tue, 28 Jul 2026 13:26:21 -0600
Message-ID: <20260728192630.240375-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
index 219597cabd0b..27bed9755320 100644
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

