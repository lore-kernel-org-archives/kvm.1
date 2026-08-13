Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842A2EEE80
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645117; cv=none; b=rU4AhnxxUbSOhjTh9vEFDZpqqNuQ/mJDcSTqnpwYLg6oXkP582ufsgJXrDQ0et6FPVGsimUwACqyVsoIL9ROvbnVOKz55cLcjBsUH5TPWnoQVJIHV3SFgMg04ANnbfWuNerJVNBF0yCgsfz4hvKw3HL2hkNUrnrlCNrGJaNqGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645117; c=relaxed/simple;
	bh=laxDdHcTzDFEoRKWy8SyIhWzXnfxMmNEa/CHyuaJx7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbzNRPhnzg7C3O8g6/MOwDwc2BcE+zRiVz+AzI/s+qWe2lJU3cs0STSj7UP5oyCfJW4YHKlXWkXtdwGCfyk4J6r64OQbTT1sY3h1mkBFDceC1T7jTyc82VEske/f8p669d7TEwiuh86YXbmo8hWCajZGZH9toXI2BlCvnIme2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNc26D0g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kErK+uxD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNc26D0g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kErK+uxD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DH8fK0304604
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=; b=QNc26D0gQLRHqQAn
	38oRtw3lbi0D02btV1plIuqbbRNmhBEOMsT+vr+5lD6EE/OS1nqiGg3v6XG2AZcq
	oy0RxoqrFL25TP1TpD28jw8KqWQ/bN6EiriQ64EZUOl1LXrpXd+pW+9Yugnb1T58
	JNOqxjWP4U5KiBQaYu1sqy1bu/Enl0u9PSz42o0D96OPMzdt0rxNf8ovRGqDZWnB
	hDOEbMDekOGhHdIVUa/jWqa1zFc4VYWnC0TJ9zZkP6LdcOYFGH3IMuGa/O7i6R9y
	ZG4dIIbP/aDlBOyTs6544uyh4SVGI1dwDckJNR3LsgnJN4Y8uAUvwuDDORNyU2wX
	K/fCDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2nga0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso3346341cf.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645114; x=1787249914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=;
        b=kErK+uxDN9mwRokj4TsHDKUhZ4GNoXdyCDK0NCaqxJcRVCbmMRPA+TR6GOk0RO5J7j
         rZ00fNh9pFqOhutBWCInMVyc2oPP6a8OH0uylcsLFegBkYRVJDpzZi41IhGqk4rcaaQq
         KQdLRH7OC/8RAUzkDr5UPhtZIbellmUaMXdJj/R7TSXWWRYMyaGgY0WDzO/tyPk4KCzs
         bvVRHEl+h9eF5Pw0FUPZXI8vqlpqA7G+edXYE4FomQ5BVc8IRkMcsbnmJZRx51N4jI7M
         5Pb76yhUTfOVfs6TRkOhbYzwYlT+FVmVFNbcjTJFNinhe4nugDrCGooEya5Rcll2gOem
         5XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645114; x=1787249914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkLF8awV/bRgmolBst9AuOseYgP5YAXlCZ5MmoxHNDQ=;
        b=KDdKbt65orZgwjiKrCLdgfPacCIsgm6bgvB5ofxqr7DRV6ezTxeKqBSwGQsUFl8jDK
         BUpSndUg1w7eUJHSP6nApARyqV/bxcC+kS/BJgsIM4R5f+u8IsdCKuTlm1KyA9cOMZbm
         Tx4lzpTleeFrvWcNXO6qbhq2a8l683INX2M/8l59OuYsP2iTMkRu9Pq5d7G8nsuqGKu/
         yrKmC/j0MEc9d951UMG2xeTif1nA375Ggle8zCx2IL07VUq4eWcw5sSYyeOOCUL7Eno5
         vyXfHWB0fKmPByMQqD92WSz5/z6S8Hz7EhhJnsiurYAxb9uqDnNcKUmSo5Q1NHB9fEWp
         QQ0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ros3PfbDJLTKfZZ87A3xIPYeET7UjTJ8fjRKP8W0KPhNP0rQN1Aloy5NW9rVZb7m0atEz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CRknnHryXaBUCWiM1hqLfPG1FWNhUWAtA9osxzXCe7WOykZP
	6u8GMsCQePXp44uM1hObBA3e3/CWM9pbU6T0vnY/GReZ8xhL/Sx55hIF+W2glyOHTLsIolCVOVD
	lIUUO/l3Vk4tluujszpOOvJHYUBojtRE8YAKvFV7bmbDQB/lCJZMjZNE=
X-Gm-Gg: AR+sD11mASwtuHeRmEV8Aer9r7yZx4gRuCnL5J348zbgefsz1QYjlBaxK+xvlJj4Aoj
	IsitUpfA9M/3E47vsI/c9CSKSdu7yXNpM7PvkiJT/jOJmKzwOiJoecuQ6mQrR9LQaajb1gCBinL
	uhscKd8lZfYvD8gIAmgLsav69WivcFL61IXbgEkChAnuewm/ozNd8SrS1+ZYHjUiZNVn7IZMQBL
	QhXQI+6TBrrXt2MiVb1VH54pp3z54cQ3b0hutWwr52X6cgzo0oHic+FEPjages5MgENS8BnTpmH
	/iwksi7Aia130JeMijhaUHXk9XFq4rEQMG/tY8g/8yjw/U9Ga8t+ozLzRlX436FeKR93qItpJPt
	qUVkNr1WxpOD+iXMPyNxQhFTQrbYgxjrC+Sut6BpSpg==
X-Received: by 2002:a05:622a:1355:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52d73df4d17mr78565271cf.39.1786645114205;
        Thu, 13 Aug 2026 11:18:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1355:b0:51c:f3e:7819 with SMTP id d75a77b69052e-52d73df4d17mr78563731cf.39.1786645112979;
        Thu, 13 Aug 2026 11:18:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f21a068sm1190899f8f.12.2026.08.13.11.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
        qemu-riscv@nongnu.org, kvm@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
        Magnus Kulke <magnuskulke@linux.microsoft.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 15/16] target/arm/powerctl: Move BQL assertions to async work context
Date: Thu, 13 Aug 2026 20:16:38 +0200
Message-ID: <20260813181640.6537-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7e0a7b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LLcwgxkfhdatqMbCiJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Ca_-xdfm2YVbyUK9QiiF4jyv52ANDaja
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9lETdO0rMu7b
 6HqjPXBxqopjmNoPrKKwWeVEuZ59ne9mutD6M6f8TLEkbSJYsiXAqmbQBahwa3p4m9vLUoSnTSQ
 HF95Ttfi+mLfRhRGVY8xRJIAlDhIFN4=
X-Proofpoint-GUID: Ca_-xdfm2YVbyUK9QiiF4jyv52ANDaja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9OR0Ze8pMIvu
 jjwf+ghMrdrSPPOVynn9QwFMVeIO+e9fj64/8Q5DdYReQW6T0mcYLIdw8wa+bhBPbJZZrWS3+W6
 SwK2LEa7pPDUqbjo6yj1FVOf69ICAlxoUIFSesGGyPRhnAMzbdib8qS1Sl+giSwxDYGPU4xKgZo
 XwWNlCMUNf5P0NPo70R1VGplTNQVaUK5239JFUJHuwF8cDhbF2uijPlh15EOd2Gg/Lk0ioG5GRX
 rHGvP1rPFXQz87k0Gg73aVVBZN8Fa0QDbJWj7rLUBYDHIsoKlGaW0YLCP4ERldl1mi0gmkNCGKB
 xybkJf9LSVlMqvWc8DE9JMZGDaqT5izt0dHDjbImm9Z9td869Q6mVYlgfA+4z8vj4gKWdnWox+Q
 Kk6Dl11jy3IDVCAgkCfge6WT0/4EyoHooozLkGQEe/YzJJJjF8txDrN1rtXV1a29NRQzWuX/QZr
 4PHnmlO0eRgHheQHC6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

We can not guarantees the callers of the following public API
functions hold the BQL:

 - arm_set_cpu_on()
 - arm_set_cpu_on_and_reset()
 - arm_set_cpu_off()

Move the assertion to arm_reset_cpu_async_work() where the async
context guarantees the BQL is held.

Fixes: 062ba099e01 ("target-arm/powerctl: defer cpu reset work to CPU context")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a06be5cc997..a938b30943c 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -88,8 +88,6 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     ARMCPU *target_cpu;
     struct CpuOnInfo *info;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_on(cpuid, target_el,
                                   target_aa64 ? "aarch64" : "aarch32",
                                   entry, context_id);
@@ -194,8 +192,6 @@ int arm_set_cpu_on_and_reset(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_on_and_reset(cpuid);
 
     /* Retrieve the cpu we are powering up */
@@ -249,8 +245,6 @@ int arm_set_cpu_off(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are powering up */
@@ -276,6 +270,7 @@ int arm_set_cpu_off(uint64_t cpuid)
 static void arm_reset_cpu_async_work(CPUState *target_cpu_state,
                                      run_on_cpu_data data)
 {
+    assert(bql_locked());
     /* Reset the cpu */
     cpu_reset(target_cpu_state);
 }
@@ -285,8 +280,6 @@ int arm_reset_cpu(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(bql_locked());
-
     trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are resetting */
-- 
2.53.0

