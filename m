Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68F472F6E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266805; cv=none; b=LbNrvjdRZOdVdeJGBca2KobKsiJsTqXjZXW7WkIQEMTR1QzTj2uT5cmQFkTsRqNWS+50nFx5uU5UE/Am2gJbWrOTGbbd0xZQOO4OI3Yj8sTfSMqfw4Fp3zgLiCPiGLCxXR8Yyk6Tx5Bv5DgBv0zXP2xT7uUoF324TAgb/6uOWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266805; c=relaxed/simple;
	bh=OSzq2kDFqevjhWgUvCxECrei4QM0G45rXxCF9eZ32Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR1CQDiCTSA/XkTvnDm9UoPzR3HwRECotH3ypSp6ZxyEmZ4ju2InLyJaoRfyGPM6EuMq5pyZgA1Pk42wtxMjSDqzb4FXQf6swrPhkg0A9Mb4djQ7yiI2ayW/YeiUC5dsTR8X3kKNTvQ5wNmnM03LqatZd7HMxLwXgOzVHyVGvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJsfGlYh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJsfGlYh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so201077a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266803; x=1785871603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
        b=IJsfGlYhO9YJcb324j2oHma7uSRHuBAGMmeIT0P7uUfFmkpaYnqUrge1A8C1iL2Ilh
         zmhzwdIo9qS8PK3xeHxTJyGBjofj9dmOzOGOMv3vVMbHj8op72PfayXNKiZglPzyahnA
         n0N1bduvBoXJUAA/9CNMrzhS5pBwb+sAhS2759Z5evgVzQYXypCUSMC89KrCrU+JL8vF
         GcweAfmosPZcfkZEWrwDXvWlV6CpggG9Ry+n1tUObIGGXwTCHmCaCCba8blrVHSzGTYJ
         41YlburJAg1JhnStr8OOVLMjtyAqmehs4ZUi9PDJDc7Cp5BhotimW3bO/xlPH1YKQf8E
         /Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266803; x=1785871603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
        b=TdYgnr3seozJ53arx93T1jcGdm9jWlqG6z9pythrp9t8qQ9pTJYQNvs6aFpFzuKlny
         2XlsiRN5/jKnFMvogNpHSoV4OkvuZJiNjTrFVUoKrOzqA9dtZpJbYZ/Bz4VZe700rCJ/
         6N/MkKoF8mGbfhmeDiAty3+gMGrIUORyMqH9Rugiu/pSRzSCzvh6ucKvCY67EQ2i0AbL
         WgSTfG23xD3uoeV+fijh4H1RT1hG8KCnGiXpttQD3B4tazFlYK3oMMLrw20f+jQ6i+nG
         ru0igG19GlZIP4rBPeOagwHbJON25YMhG7EoeWwmCHEUtbGmj7/Eg9cZb+kIHBXKrLjg
         y67A==
X-Forwarded-Encrypted: i=1; AHgh+RqCRQSvLxJ/Y5QpPxnbNglPuE6YuaNlS0tzUlYVswDIt9nf3M1mM1nHpn7+W+BWv9je1PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4MMJIUSOqAccUFoU3OxU5xiqXRlx/TgYH7OjqYnVwl2ywoVN
	Wn4vL+frE48JUIIqPRzB2BQgSkMAdDeG7DLQyHczhc6xHNT4B0WL0wca3wLNsupIvUw=
X-Gm-Gg: AR+sD13N6QOKLoIb7Rbk0lBr+NsL1DSyfCmf5ci5efT6mx/w0F78iBZTMx3cB5SXgjH
	kbjHL3R//ve1eMO0Jm/W7nnOnAAmJjfufYvxevFV3RvT4Xm8nTnvukV5InRoh0Mv3Q/XAwdr5a7
	6Qe/dKw1/EEoyl/nSAUwv9ai//ZqNCOANPbU/NvXxh8xnGgI+DhEzS5XJMBCzgii88oGURl/h6u
	Io6ZSJyAJN1qYfiSJ5YGV916SnVcrYXSvgItY8HuN+brPX4SoumEn1pfWDoh6gimSZjwLxbOuY4
	pp/1U6G7UQXLONAtM/st0UlBGboWjIRkPSA9HwTaqZCf2gii3nIL/9NDomu7D0ROlrw2OOsaXpT
	SMz5wIoQKByWB2lP+qgdpE6Ov04GvTBd1vxgkSgpHAn6lYqbl2nEY4Br1TG53hZcEw2x2R2BFbP
	ErJQ1/kpzB+rGsOqrR3iu6uD2Fw4gvfd++kPUA/vY=
X-Received: by 2002:a17:90b:3802:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-38f6a34e1edmr3788843a91.4.1785266803143;
        Tue, 28 Jul 2026 12:26:43 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:42 -0700 (PDT)
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
Subject: [RFC v2 05/24] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Tue, 28 Jul 2026 13:26:11 -0600
Message-ID: <20260728192630.240375-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

