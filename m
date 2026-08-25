Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155C392C2A
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695271; cv=none; b=b92gT0ijZ7NR/rwcKjWhZgWhq6J5Hr2wkc5qeTYke76SJmbMZvbtRLfrZ6tTHIlfgAQ1bPwHRvChvSlUrKlL4pJAqpOYc8LOdtrRqVtYDnvOJWQrYd/eR7seIrdjOQZG0+8z0Ap8CJTooytZVQHCvPmE3FCpuorwm4PYr8vYQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695271; c=relaxed/simple;
	bh=BHj8DSdJ49t4H6rdHTQB8r8xMwozD/cZdw7JSh4dRPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dryY2u0rOYZD5ssdYybGqxJsx7oWeOHrN3HbJD4+ruLY/Hi4P6DrXqYNAKBDyF+NsAxChtuxQPA+S/W5SAzq9CPGwyHWbUCddns0t/kBtYxMpsh+bxfWg5H3aXkaiA6DF1NDnYOh6ZyYlLLfQZWbF3P/+8JtsTR9uDt68h85j5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvNnAbDD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvNnAbDD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso433376a91.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695269; x=1788300069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzyHU9mpmLRwtQLq0gW2o+D00lhdgYVo2at04MRhk8M=;
        b=yvNnAbDDInxqcpdWovIeOrWjKIxC4LsaFKT/l+7/NpfEJwZGotbltZ4KxmMS0bmq7x
         WnyRKzbR46aOU1RcaLab3PcZ0E1UELnvt9iDdHJkpiXSbXDrImcqTEtJY1UF0ziEsjsC
         3Oguet0pwJJZZxQ7mkKS1LTtumQjAOoQ6SYzzoPXgRy35O6OiyShA5YHyOk6qKbaA7Ll
         2TA8Y2f3FIo/oxPrdjwOtdqv/ckfF0pByXEaBc3XSr43zTSlB3rYIkPBHrdDBi2epltj
         ocYlaerSzWICtKH6z5vb4roSbjcdPol0KpD/HqGilgcR2Et56s0b+ApQYYRLIpT1z9t+
         5rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695269; x=1788300069;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzyHU9mpmLRwtQLq0gW2o+D00lhdgYVo2at04MRhk8M=;
        b=ikEyJVskKElt/3GRAWNOEMmZQocfvBMTAc9mPwN1HP1EcqLOGxCgHTGtxNrwzMqt5E
         ee1Gh/NVMcqLP6d6o525RIe7yPIqbxsdaWoTO7PEXPRHxpdzhTzN1GVJAd8/bGBBCxl9
         eGSs98bvIrxrHq310MUpaCrKZo2ON2hnnfdDf2mVxz0+CHzLXhNfKF1zEON9wpVTiDUh
         hqC9uxLuvEy2h9qk3arluOA4bbgRVbsMa3fA62vd4jS2cPQX0K8gE/T2hsp7jPiwUrF3
         QmkeXVw7iiCkwQevJoSaOfq9E/xWbMvv2r2gdfYUPbh2c3E314uDRn6P5oSagmqPx1nK
         3Cgw==
X-Forwarded-Encrypted: i=1; AHgh+RrDD6SOjAXAl6rYeSu6QrLCF98hm69FWLFApRrsP0efVopxx3pxj1zQky26HZayipKj/U4=@vger.kernel.org
X-Gm-Message-State: AFuF++m91El14Af1gqobb2HA6+JWCekWm2/yg0H4PEUSFN3+J6q/8AHN
	+RFT8aUjKd8YlfSuPhHA89a/J2wkVeMH+gwek4i5E7tvlGTF16fU1IXCsLVZ7dTZ+1w=
X-Gm-Gg: AR+sD11OxGZ/fuXrYWkFYO6hicbabZPMlzLaZ7oYvhRtxgEAQYc+gPSwJHUYL3xVklN
	VJ0YXCJrmDZah5BuFT4aVyIu17eOhAGkbaPDZviHRPjL4VBvg6nadTMvYyJPBLzDEbHuiSekvfv
	TlhucFpuPVHB4Uy5uAhRQSAG13y2V/6I7sPJEwKJ9kHe8KWK8in2bl3EZqswVbpup7bVf3knxhM
	F1OSgKo95wsVlvE9A7KfctBOwV+jalV+683XywfFktVCoRHlLBqfokvntXbRIcNhPI8kxea/Zea
	lGfeuQk6ioB5N5nQ5KPVf1ZW3DRcz6vOXN81eYojJ4KxjmddiNQpQ4JLAY1AGlATumLr0AAJU4V
	v2/JhFbv0TGwgwjDJmMuioHs+L3gLYh+XgR2bTSWeDjLTh1YAaBlkhmZrt1eD1YWpOiR6GYu7o9
	9o9nNyXX+HxOANrY494Aia/Of7yQAYCk+chzUn1qPDkUJdH5xe8H+U+Qiz8powJSQTuq+kLfk5
X-Received: by 2002:a17:90b:3d81:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-3966ce035e2mr5067715a91.0.1787695268545;
        Tue, 25 Aug 2026 15:01:08 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:07 -0700 (PDT)
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
Subject: [RFC v3 02/24] target/arm/kvm: Return immediately on error in kvm_arch_init()
Date: Tue, 25 Aug 2026 16:00:39 -0600
Message-ID: <20260825220101.3443954-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112b1..20b39d10b766 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0

