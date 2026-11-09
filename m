Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263504;
	b=0AP4uTdbpjHtzrbCFEDyAMhJBpx/YlJQkvAXj3Uiohs7/cpt9vA4hMVTiwNyStzkhiLd
	 mCpGQe5Qd0jpp/YJ80zP3DDlYSeDW0Y/Bamw7MztUHQjZORz7sWy/JbLFD3Prqo0JRO2D
	 85YmrrdBS8SzYc8+KW0TqAIGubx7vzwcVgGrqoZCP3XTfCvyDXlw0oATOnKUnIXF99V7X
	 CFLPknKOrVuwvr7iqhEfm+JG4CB07A2sHH7P+cawkaCdAcXIiSAH3j29AGRPcEZNgHnB2
	 MBKvs6KRru9681w/CfSPjnaohYwOSXPqFPRb+NYCy3lPK1wIa0layo8bl6t4krmR73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kH8pQhkREIU74SHtQ57ILotvinGHdRLLkwynIXqi/JI=;
	b=nENs6OhvY43TugxmmcS8hFat0fvhfpdPOFj3TA8/qDD4vmMWN3doSh6YlA0ul6yk5emu
	 otmeK2DOqyBMmrvJEBtczUVP6WPeEJDbi8jrn5tMo7MhnNlSEKyksTjqcsShGjU7Mrgne
	 AW3ejQiNvCv84YxHNEUJFkhW9Z6OgOeLxIomunE1QAstJav7VtudCwNM6qlXMC1TrYD0w
	 A7mce+/8zYMUawukX3Y69dHocb9VBt/QCuW88CyDoxdIynXOo5TvsXVPM+D7aXYX3Xsal
	 HZgHObV4WjejMOX2Suyp0IaUc3Pkh8UZkNy3E4Y6mPde5e1hApNQDDuq58VuRL891pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H6LvlmrR;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9FF606A339
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B9FF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H6LvlmrR
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a070755c8cso694113b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263503; x=1794868303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kH8pQhkREIU74SHtQ57ILotvinGHdRLLkwynIXqi/JI=;
        b=H6LvlmrRGCEB+5TStgbaaSxyJ9F2C6k9S/9g+MQ8uJ/bMfWH5xLl21c7hNCef935kc
         kKQSD2qD2Uo6lVcAmhAhqB5fOej79zXrmOcyquxaShf63MjZeQdeCnSGpS5vksGJRe+2
         QKYW3gpHtQul7CBKdkn4u57O+egfhG1ph2LI9kiKYRUGKXe5oLcUOeDMBDIkG82rHFqf
         RLIdeW+fQV2bFMA8uXLxZKFss87k+/1A+m4znrCFiDEsN2ZQgw2hOT3+zAWiWAy09ydH
         rbDisnkDKN2GwKbTCEQObHqcfZo+FB0bHenJRFU9GNLehq+YNjbhyf5GqzKbjvgOChio
         QO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263503; x=1794868303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kH8pQhkREIU74SHtQ57ILotvinGHdRLLkwynIXqi/JI=;
        b=CB5SAuA2bE3/Yo/4X18o1wwvGEhQCf1O+JA7TdpnK1VBo+5IhABZ4mvbcH0DhwdIAO
         qYzcn9dqcPNl63PslPT6W8sRlFQjFA+lZTA2euNc192l4pQXw1C8TwU2fhrBZR32EHJx
         4dZvh1riEUwn7sr8YqKWX57bCjoc9O+so444aY/jLY0AMLuw5ki6eIwdOnae5J2sA/V7
         fljq6QJVGxeyDqqPWMEJiaRZlOzsauTer/b7dk8T+A+BhsFIK7bhNUQYJMezOLkD+mLt
         pDwALSXyVgVIa4JU4kvpCe4xewH05ar7m9es2B9YYneu0pZr7XlBJABBiYMRHMgOaI94
         bK2Q==
X-Forwarded-Encrypted: i=1; AL+hErHiKLZiql4tAEag22jZ9iyZ8FAqvLBW+qmknhVQKFS2vKDsoWXtv6NvIpxelj3zkLTZ0c8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L+QDCm8wFKj5YTp31FjDyw1HFpIBcFK+7rFlWEl2xKkES+rLF
	CJR/GXHxwtgnCzJJIVXiRnBaaWBAWHDpfFllJb5EGJisZogdi/g1I8Y6JwVPZy/R6Ok=
X-Gm-Gg: AYBFou1U/zTofBqO6SMKjl4Dx5hQHDE5CEWD5jlWKbXJZ31C/2fAMW3JqxJnF0pMuTP
	x50eEr1EQn8pERjqEZRbispHs90u9ooa9mU7zpFewFFtBspNegNBl3qYR70o57Qd8AMLes/ImwE
	Yf/XINLM0+oLn69vc6VhRSihuQayT56UaZ2MRo246QpydJlpfDjsA6S7qtmS+JmTQnas1djGXcT
	XqjWX9R4Ke5gquTEDfZfskPoS/RIdj9V7QihGixOZBLHFoJaUJ8KMbfc3fnYJmIz/wYpFo3JQGa
	sxzOYKW5uZOqkYnLA04WTlZZDj7PGdUBOqy0AR3vQmh6xBKfq0P9QGT2+Fcs1Okhec9DKzQDmVC
	qcx7Et2OJp8Ng28g6XSuO2IMX4R+DirC4zPM4yw9sietQqJsHpBb0Uo0I3ek+A0ZQ0TeUvgBXei
	R0ZBTwUuIUdkTFqz32rYt+/AKvBghNpcnI5Wyfh9e0VzWUEiqCUoV3m/SXYuK2kIz8UZCwwtPkx
	5YEAl9tGv4/933UO61nAuQjhkMxQHwZunyTgrGphTRBr7EmnhsL8obGl1jacNh0gq+iNcE2wxKr
	NRH+wMXJL1n7lSuDHh8dS6k6pofvEMLO625iDmPgF6NG8N1l/CuaYw==
X-Received: by 2002:a05:6a21:828c:b0:3e1:1eca:2214 with SMTP id adf61e73a8af0-3f18f2ae577mr556848637.49.1794263503236;
        Mon, 09 Nov 2026 14:31:43 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:42 -0800 (PST)
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
Subject: [PATCH v6 16/23] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Mon,  9 Nov 2026 16:31:03 -0600
Message-ID: <20261109223110.1619504-17-mathieu.poirier@linaro.org>
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 349257f53f2d..9dd89f39a044 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4062,14 +4062,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (vm_type == KVM_VM_TYPE_ARM_REALM) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4078,11 +4088,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.53.0

