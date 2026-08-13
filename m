Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298242F531B
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645109; cv=none; b=jsEeTVI+btHjPwGcbTkG3ImnMBKjsJXO0VaSTX0HCm6rO3Ei7mIynFaECjey4tGWCjlQO81CTPl71+tFw+hqvVSrU1U08ZbwxvckAGdmWW5wIGEoFsjB8/QivCwlarDf6AOtZN/ZFWDM32QoVLBJsrWN9KPLV9D5CjMuu5z4NwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645109; c=relaxed/simple;
	bh=RLiYxWq1N38LjHiS9xTxQTQNt2vWnETKSnJAFEv4r68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF4TjnHuvJJniVHM2qT26PJrEHsHtASQk4L2zBaWq0VWkJIWiVsaRJkQbwI1so0MN4VbQTSDwAWvVhmC8qbzu+a2U7JFsY0OGsGrakjjmggLinlhg6dJDi7VzvD7PYbCuIV1Kx/N6x18Rd60zzoYdM5wFScV87d85Grc4GpsfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQBuqPuj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwJiCXbf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQBuqPuj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwJiCXbf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTKxJ2778274
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=; b=hQBuqPujzsXhPNrS
	uAWc9ffvY5FWr5MT45GSB+SH5TWqtHiKgCTMt6ZSI4ThqcuefaLdsLMoHYwltHmw
	cBl+H6mky0H7pf22b72/ipbpsibziJ3AHjAfA3Mbjr0+m3znb6E+57sFnSuAd0AS
	5EHRT7nY6aFCiUwHbRRHRUWxfRa8utRK7ChqbLqrCkg92BdtkM3p2uJHUlAPm2r1
	tTb3rVNECxDIcg057QwM9Bjxbtsz/o9ZDwsCWIKBMW37aVxaFKYLEhkUew73phCQ
	9cCFIJgtVjvMVYAmtJYnyebQUnty87t7SoSIiuKBPGelDhT4DTV+YfeYE+zFpZx9
	ljmTCw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1cb5j2ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so3051361cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645106; x=1787249906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=;
        b=CwJiCXbfprSYav13MS91GwftOAJkxoWqQMP9017PvPfDQf2os2PN6aMN+u1bCMVnkM
         ysIiQj42F45k77+hK1aBb/MmP+bL9r7ECJXECbMDSuEu5O3xm3W5NNqI6g+S1CSIvgOi
         EagGxJIeY50WRTP4FFraPqDs/R1MlwpaJWuloz1mFfaYkIgmQe3Ts6i0efX1nWzH3B3+
         tuhw1ZJ99ECz0/pioPYWmtzFpIw4OY8hUeUGnNT60+jw/kvr3POUW+jHVWfnbgldajnd
         INFB7ee8Do6kDox0IzGON7k5eAwITIoiaphGqoilUn2rulV0mwFw7WdAhEvXpBW4ZR3P
         HIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645106; x=1787249906;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCWTqwclBlLHkStMtx+d8TC5Wvr713M4u6l2TBYeh3s=;
        b=ibMBGnfERf/ra8n4qEzsil2wYBsuhgx6bc/AmGDnK9ELMZ1itQ/XzPU9zn1ECH31e3
         gj3K0dkT0mctt3oZkT0fOPAhYhL7HC3z68DVqTWvnYNk1pWcu6PYtqV8xcFDEf+7GL8a
         SYvvSKEnL/awTJNNn2EGrbHZ/oPlfKxg0yhysyiIqRZEvEUBzUQV4l7yCkGc4pCof+QD
         KzvgsU2MfFoW32hUqfYkAqQBkajMgRO5hQOtx7G2GRAJKJ3Q4vA+l7MuLg08vJFHIOqe
         YK/Wvq0qy0k/xzHL9nAR3Kbo//7zgUXL49hbYh1WHQ0GVBLGiIOtKdr86Qett/AT8a9F
         tlyg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7ZAkFX5d9K9Pri9zCAQuWy32kp7T9sq//ZQR0b52dayCqmC4NJhFW8/Ur7fRTiLf+wx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUuIiXjMKda8zT3qPSFG0xyo23AFE/rItxvXyZi0i4qppvTzZ
	vPOGqPF+k6uj7QljswXFDpeAm8n/NiHJe6/Pz19FJTCUIvtfqz0nzwbUC5aB4yPDucl07Os0idQ
	quDtHZ8BtRTLmS5ugFPlstNR+hBIBA4Yy3btF5cEbkkrEIAuvgT/iwg0=
X-Gm-Gg: AR+sD11iDWKDh64k3iJ3sI+kjoy/efLaxKOgn3LUIlo+lDT6ko1dH3tcblbtepANRBU
	5dzb0WvYCHf1+ncLkg+JYgOqcrhk+FHta9MxrWiDzujg3Nst7CSiqCG365wbEavzV1+MwOaibT9
	4dNFl5RbdCTeGbyUrUKjtSaqflMQxC1ZFSao6fCwLDfgbPrVBqGcxC5VYX4wNqdDFfigpwKXXC/
	82XVnoRgavaQjOO6eZ0qjbD0+poev88cbEIkBhjU0UkBCBAhQi/veo3jUEFg0WSih2RZSj/r8O/
	eEoGLYoS/D9d/UIAuo4fwxNxsSuR84BZ9fuSWNN3YzkfdoJiLI0+UKsBaAbdXqpWwFD57912Aiz
	HJQzU5JovzI++vhcu8KhLqwt+vZ+wgnWEwXcOFRt62w==
X-Received: by 2002:a05:622a:13c9:b0:52b:4f1a:5ff0 with SMTP id d75a77b69052e-52d73c9a46emr78212061cf.19.1786645106377;
        Thu, 13 Aug 2026 11:18:26 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:52b:4f1a:5ff0 with SMTP id d75a77b69052e-52d73c9a46emr78211021cf.19.1786645105711;
        Thu, 13 Aug 2026 11:18:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f200752sm1254325f8f.1.2026.08.13.11.18.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:25 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 14/16] target/i386/hvf: Lock BQL outside of the vCPU inner execution loop
Date: Thu, 13 Aug 2026 20:16:37 +0200
Message-ID: <20260813181640.6537-15-philmd@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Yt2xjzBDyGJKe-L2xgb0YX1GGa6Bz2Go
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX8h9yPhn+2pK5
 jdze5At0yjxkcBBz98KwUDCVTwrbyFXi/gJuMOrJNMz6Qv9Z55GiftTpgZWYD8JwnGUsrCfAZdg
 DU14w//3uJpR298GDbxE0MFMoqejHi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9zM6dOzQjsOG
 y3RbRuPf1ctVT21+7Zl46hVfBzqjAPudA/ZJkSz9WzBlwRWWgl3M+6VrFri8RAn/gw+5jMgc/i7
 l4gAGSiMF5L+B2JOTIGArmUmr1fzd2nczsgK8OkSh5hGhJzta7Gvb0FI7ZtXdUVZtBdlVEREJIx
 Wv4XPMuFWue4qN2CWK/n7UrXVncuw+cmqmyWcR7VxRMhsdMXgMteQ/yFAEqqLeTY31VwtXmc55T
 Q9YCI29pe9GJ1Mj+M6n05wmK8VQ5YTc2h/ffmTh+y6dOrQsg3Ch/qoeJxJMqaVKtEAVK9Aqk2f7
 1Mkebnrdpq0iZKPI28BJabbO/uGaD/hLau+7aL3BYIkEb8F5eb84G4UnKcTayVQUHHlHSIteBjW
 ajypIDglBosx4swOX2ZJdrux9Uww/O+Eq+gdmQ5/8/HseX0HBgfBZKQxgxR0Lb2T83nlObBXGm4
 uLJgyoL4dktRljgHVtw==
X-Authority-Analysis: v=2.4 cv=GoNyPE1C c=1 sm=1 tr=0 ts=6a7e0a73 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=k2pNA5m5VJBtx192dGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Yt2xjzBDyGJKe-L2xgb0YX1GGa6Bz2Go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Reduce lock contention by acquiring / releasing the BQL
outside of the entire vCPU inner loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/hvf/hvf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0ffa3658dc5..f8bc01d38d3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1009,6 +1009,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
+    bql_unlock();
+    cpu_exec_start(cpu);
+
     /* Inner vCPU loop */
     do {
         if (cpu->vcpu_dirty) {
@@ -1017,26 +1020,26 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
 
         if (hvf_inject_interrupts(cpu)) {
-            return EXCP_INTERRUPT;
+            ret = EXCP_INTERRUPT;
+            break;
         }
+
         vmx_update_tpr(cpu);
 
-        bql_unlock();
         if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
-            bql_lock();
-            return EXCP_HLT;
+            ret = EXCP_HLT;
+            break;
         }
 
-        cpu_exec_start(cpu);
-
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
-        cpu_exec_end(cpu);
-
         ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
+    bql_lock();
+
     return ret;
 }
 
-- 
2.53.0

