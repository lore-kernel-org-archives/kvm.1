Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263482;
	b=s5boE4R9OZZpgpLgF6hMJMOe+UFD45G+QbymCCEYHYFS/IjkcJbk4nsgeKQ+cfE9xdpU
	 nODxhuInUQHvzmq9jupIpAB5I9utMhyULGs6sdDG+zPErbNvhNhIFc800mJzrqMSanuT2
	 WMb6m3DCIso8XwYfvhS/+0jTXJeynLi04B70p3vuFR4s3bKNUmhh5bVD2Sf/qrXxhGM9+
	 ZGpGq7E/VyuT5yM41k64LGCFOBZgHVQspKBQw8QrUA7HNWHM0NpiGY0vwyFlR5msVmMr+
	 7+ASEnPCWaDNgrHQ3UC++0KKksFP3ebG7+p3XKrMMBC/qBkV9repTBGry3G+aPmbeLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R6shKTPJO2OMKOtP1Scv42yaR7N4lg4logstoB5OC0Q=;
	b=2Ajr0MlHGi6ZKrWYAecnrz2w4eGjs++d1KkEp7ow+zMHsxSZKJuZDXXknt3COinXQAd4
	 m4WqZOe0rHXpWS1wGvt/2SPwG8urCR/HWqqCJS1oe6h58OKDL1F8xpTRh0dLR0Uq2fCgi
	 j/nQFeX/5m7RE2YDpM3OjfMusO+eNrqKNwSNrb/RZuP6yjAAa26hRhQY0Q1ADR0gdfFm4
	 VOk2GOboFin901LBsiNWQUctw3MwW/IU0nAo4y6tr9yT1s0xl1HsQXCohgmxcvUIYN3UX
	 klcuOBiUI1vTE9iM26lljDtWZh+oilyimL7fWFZ0VhZMXm+9sva8r8jL/LU7dz9ENGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QCRPzeyB;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19412606A33C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19412606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QCRPzeyB
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a070781f63so603096b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263481; x=1794868281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6shKTPJO2OMKOtP1Scv42yaR7N4lg4logstoB5OC0Q=;
        b=QCRPzeyBbMwRqM5cbGkqFVy0ywZXtTWToCpSTK//4sqya5bGhT+n/iYIv40NxH40Vn
         4JvxVYaHqMOi0SjnI78f6+ReaxXdfHtc4vjDYPaRLnnlOxgMwLhEcpQNCVsI80GijeAm
         WLH+gR5vf5G2kx+PwWM8E4h4vkgS1bmKX+gMgKhT8VvrMB6Pc4Ot0Qw1pekIMrJZ/qfo
         7tEarp5BMZqO3WyDLEnd09+yrbR7A/d84cFSmfT618BYMxwEO418cpGTB1HSWyqZeN2s
         mOa2sKs/X1nl8DV8+8D2T8FViu+BjNcawE6Upyquh5QDD3WiUvMsemUCbDXnBVbvNIVh
         wltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263481; x=1794868281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6shKTPJO2OMKOtP1Scv42yaR7N4lg4logstoB5OC0Q=;
        b=b5txwi2W5l9vrSF5mT9VH//QATO0GjtV2Jv5cZGZLJm36ZWFy0D46eohLZXIcVIMtE
         rP8vkw+UbDoJAvkayXL+pLRyJ4hWKNGjWWZOcoPCzD/orZXg8uzGURCXUoNeZFgubt8c
         DYldXyyfEYvBZEoHeeyeBi39z5djpbPoTZtPMPSCaH4hvp3VGxP5joQLOgAXwJAeus1d
         EPoX8z3ZdlSOn9g/Jc4TxPwIxzW/dxtZteIOOQ5KxGg4wVIeAUdw7Nm0mIuv3R2Sa4yF
         SU8hCp9I6RyZH/ROb3y9YWMbkPauTmGXcKotARece1h4K/+uX2N4sUc9rGG3bciPIGDq
         rkIw==
X-Forwarded-Encrypted: i=1; AL+hErG5vfMDhzZywWPKSLgTijH3RAWwmYTGwcRV4uDX6jug6f6j5uagrcRs//KQHFNXbdP9ruU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N312tA7cc05bjDpYnBV1FmQBLQL3o9w6TbRhuBmgwSXLBVYd6
	pkhWYCBnZrog3V5NgRFKTvIHj+XPleGRpVQsHpsBuZa/4bGlsCyzQxzAnhUntlRMo8w=
X-Gm-Gg: AYBFou3O/4bqNg0iJdaEmTeJ9wbp0pWbGAvRNQ1OJO6buPi6f2M8Mo8Z1VbXKrJZZLh
	K3orzs7rJfCPDFV59Nhb4Qfu32uVmzE9f56q0qJChRSsRowto8efxsGZwiktmq+3Y0lCw8eofCF
	XEqQ4MvjZhM1126hHFDxO39v/SCqjVBak5xwprtqhLzs+WKAx6l3FO+a9wYyC/DE2WwyLrO2GDt
	MvCjtcuO9NP8d7Zz4GvcRrJzX1zlGbfKHmvpOb0GwrzcqH+xig2O1foybh1BzNSNqSxYTNBr6Du
	7HraGwY5HDafrZuaWhsEUYRnCT/6yRRy4E4ykCJswEgzjnW86Zd1dPOmYhNUlK0BOq9kICDP1uk
	pqKRZHhuQotBYKCbdcNpV1Dl442gfSsQ79hGrQ5b6zGILDlGVUWDZVljU+/cXmdX0hC5RqM8u1l
	8Sw/tErHenEsi4epUUJ4gHCRGt8oLDJO+juEVpoYpOg9cedzAz11UG1eHL5DpuK9dlAXPk/I9g4
	N00B/Ziv/QP+DblTxK1PJbk1BWO72xceBy1SbmCzvM5AsP/dO/ESNWblKJHBAru4JcyVtBPcPXR
	BQBxSWL5Ck3GVHUgxNqs2Tlz8v3yZhoFVDrB66Q3jvfesrwWvl+nPA==
X-Received: by 2002:a05:6a21:62c4:b0:3e2:86b6:9bf4 with SMTP id adf61e73a8af0-3f18ebb3200mr480367637.14.1794263481319;
        Mon, 09 Nov 2026 14:31:21 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:20 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 04/23] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Mon,  9 Nov 2026 16:30:51 -0600
Message-ID: <20261109223110.1619504-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 04dd85ee2776..5f40b665cb7d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2257,7 +2257,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2360,6 +2360,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2442,7 +2455,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2545,6 +2558,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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
2.53.0

