Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377950EBEA
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464196; cv=none; b=c7XE7+yzFONMVRvNg/DZcBAVgfUkRZJNAY1NO+/3HCtQdmgz9I7Icseclh7QJ86tCDOMGSOasiUuvw1cC0wE4E3/XyfMf8SdMa/N7SC3SssK/8Pdyptu4Spi0EbC+CKc8iedqoypI5OehGHPHqKLTZCDHhDY4crRLjxLqiwQc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464196; c=relaxed/simple;
	bh=OSzq2kDFqevjhWgUvCxECrei4QM0G45rXxCF9eZ32Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXcrY1qELcAlQXibOS607XTuXBSTfoP0MRhMefr//Gkpte2zyKLTuEIXsnkkYm0+FrQhd1nGNKuAwEk0wMY7wTC/mRw8KQo2XaqAVfRy/CmWb2DoJqaPSN+ep+vEJ0P9ZlFXvkSV7v68hJc6YTtpL0F9SOHiPQbt42JyvYwTIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dp24sbWL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp24sbWL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so225494a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464182; x=1789068982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
        b=Dp24sbWLR9necqnXUHJAzhcZDnfyjx2uA8t7Pa2E6AzCCeg+omUcicsVOnL6xolRRV
         1uk/tq0HRXw2hRYhPckXXi1hJz1XwvrQyZDOUSMpQycplOMCOnuQbAuDjyoPwVSK4DAw
         Og84D1KXD+v0UrA8nFg31HGB8wZKMIWq7dt/fhEmbcae8EJsK63w1VZiILuiw3n4xA+O
         wDJpTY6enabJnYEfrA8Rr7VPdYLSs1QhuIeYhWSrrinxP0EBfmvWccDRcm+I8UrScJys
         g+ZhzfohqdjL7M2rcl1w+f7Vmkw9BtbMeALY8DqArWYFs97px705QSi8aitPODXHzRLy
         xSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464182; x=1789068982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
        b=EsyHktKF7eQE4Id2CTRlxk9MSVNZnEHgOGnZ6SxHMO14YPDmUQw6wL8VKjJD65lmQ+
         tvEqB8CdRf1pYRfnNkztG2Kw1wE1G/UomcWNo5iF3/byLW7vljUfIpA36W+S/p46vTiq
         zwEWO1xGI3EMZJCKLp4wqrFqSzq1nMxB4T1gwo6cVv2iPCy1hpLn5BxOjQyR8LAAC8Ap
         0xbszFe4HNRplMkjFvOxAfiThJWZGeilJxxE2Z28UNAOfiKzStPVK2mGl6YroHKHs3XY
         0j+kwBV6qSQATu/PoSenB598b9LP5WGkOX3E7IA68t7Mi8G7ZQU2LEZUNGrnGiInCDfN
         xLhg==
X-Forwarded-Encrypted: i=1; AKwUvBx5XYZSOxzs7y+G5UMHVFSzVX/WHFLhkjVO542x+5wEbKz/J2mp6+yfeAxWTCEd9B2ytn8=@vger.kernel.org
X-Gm-Message-State: AFuF++npxiB2QeG9uYGGBYIy7NVTorgJPQ4vB8ALYcFg4u23dywE+p1n
	rVVt4Ozu2Ofq485GwTkGqRMcRij3IYoglKrdKWBWqOG76nXQca/z4Q+LAvlgqNLXrwjBOuKknu6
	lWsho
X-Gm-Gg: AYBFou2qUneBemEYOOMRaTEf3XKOyJnNraRCMr/l2hIIhM+ygiVzLJZ4kCJewxiXjca
	J32RUBQ2/rVqPi6y1NLRSF3U5uptWoWb+VZTGwZtsWUPvrhrZP50Nvm93Vs5KjSnC3K1obQ+5dN
	NCWWlBdDy7Co8x1ss10oeLP0y0ZAhQsxymmiVcDIynl2FOLDJgcRQYghjAU9kGOb491Fuo6EhC5
	lf2f69sLMdBhW+qxTjJNywxuz3QSZiWIDjPp+MG4taTlz01ytyLnJjHLbAZKttcAoaHKjcBzJ2B
	Zc5SZ5pK9AD0YVKCZnojSu4663joU7U+qceKgY0c34TGZr1nnYsIBCWBcoXqjBsvb1z+/mDqydO
	DiCf2CoXcYUFkdaVUAAQ194n+qAM2AkM6rlpaWp220PO9yd6FX/6dVDbqyqLATYdetgCTGY7Uab
	O8beoyfXuiNKVzV0nuveMekYXM2a8yxPbACfNY/DhLjSYYD3ezqDtv/vFQUU6pAsgiIVw7Ar0D3
	jMz4WZYkzk8PYU=
X-Received: by 2002:a17:90b:2542:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39b26101402mr1172680a91.5.1788464182044;
        Thu, 03 Sep 2026 12:36:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
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
Subject: [RFC v4 05/24] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Thu,  3 Sep 2026 13:35:52 -0600
Message-ID: <20260903193611.1058589-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 401a6f669cbb..33c3763aebfa 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2169,7 +2169,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2272,6 +2272,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2354,7 +2367,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2457,6 +2470,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0

