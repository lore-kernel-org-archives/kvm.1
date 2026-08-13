Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB72F531B
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645101; cv=none; b=sjxp45U/XococrZElj+U2SQ/FtCSVFKTHtsrs8Pqd3Eu55rDc9x23cr+D+mlZMm4/dJV0XWQB5KzeMLnxR6Hvx8gbJLg2Hs2OU3DKBpcc8zKL995Q1Uq2teV9/kiayarUw16oOFCEaIMOOrjUpwAwCK18tS6cigGbCpypHk6NyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645101; c=relaxed/simple;
	bh=HuBT/wT4YM0oVtQejTcb0rO7Ev/1aEGo+p0/NwD4+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn3WD7fPCNjXR0B3fMUvwBzTgb5z2E70iIZ+fCgrN70VaGX27C4bGGTVZWmOLtxhAyQXvt4GVH3qiIziqdKdnAaLb2U7KCglsXh4RaTTl8P22W+E9PeposY2m3mY4UzXsrlJRdL1AzJakFJMYWmK+09JStteBlv4wxpWNJ21S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4ShfWpv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnKqYSIC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4ShfWpv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnKqYSIC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DGUtco2076784
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=; b=K4ShfWpvQbhhvufj
	8t/5NMf0CpYEEoRHoYloXGQt3OB4BRFdi1CWOEZseiPgULp6nL/HLmP1VgNLeNDA
	3Q8Qw3T3K3Ov+oBU+2GmNRI+pYcU+KxxWrV83QEPtw/vxP3dEN44ZsGozWGNeh9u
	0G6aG4sOZzqgyAAnzZb2DHLlZk4Twl2kQVJ8QJ3mD+/43iNcXSaEHtfbkPqQp4eN
	6kMmMxF6zu3JZUPSt6nTbP2F61n4dTRUFccn4E9RVjqnx1vo4Yomm/cNcp8q1RMy
	pGud0v+8ArXD5IHSq1LRVwTDa+QrKPg8uOid70ZnUuP9+Gu+bZcs3BUVLdufiNQq
	7DnBNw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy0ff6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d8243f1bcso3729271cf.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645099; x=1787249899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=;
        b=ZnKqYSICD84Ac/RgVlDuogoXMCKwQWFrJo9jxZr2SBGoycqlYla3/i7TE3Ht3XY7c8
         QDYTVFiTKvZ5ih8QDDBrN6qs6GQZRIElrcCnMwKLlgzAVhVjPHgR1+rEUY85umoi2/U1
         Uc85qVS2pi4aQF+4mWqVRcZKzo9/BsrMmJudwK/8gl4Ax9sgz8LRS2Adlf8lh+RWveHT
         gvoKZ1ohVRztSCO5y8wT2Kes4LzCW+eZzSkE/jjB2NryZt7v0ooywvM8NKwFSc3AKO9z
         GHetVTILe2GENTpf1Bgg9edhniv3wMjPSLr9zJ2E9XmOCXGr5EhtWOEm5RM/5wBnuGTo
         m2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645099; x=1787249899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=;
        b=psajx5NJTW41//c6Pp60C6Ilq8CAmtZNOfMYP6II9PfWwRWm+DcNp7ORnNxvUlT3Il
         2sbTrfslUZoTlr4u3pnUFph+kL6hPgx3FahmlQJvqIvvEHdoC8SreO3S3AMdrma/AncJ
         vyPjn7ahwjZy7vDrZgWBEjQ5SYLbB+K7aBfHZqS0XhX99a3X2pQcMwWU2lrm/rThxfhz
         EyT/pzWpRsNxLNMAjDKOv1ToIp40QI7AOZjasqz7JGYc6pHFjDAGPr3N8yKzt5waw/3Q
         5jx4jNHKfVaRFLSBGt0y9bqRLPpVKfo7V0lE2//K1UBnv08zex42InmEEsXCzzYiQ26j
         /qhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqHEIXG/fhAtd1yJoTqoIKewbuuXf5y/59FpP3q0CJpCll+CZ8EcC0jHTDjCRtdz1b9XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2U0/3vVbLgNWLm+JnkMXayVvpY0VZaFsBfs64pOtwcBIlwUYf
	scOem2rt4IoZWena28tfY/p75M3PMO7olFRtcjsdeIfdzsZ+fOYMRRaXEbeBRJwNK2XyCOChv8K
	k6dcmd+QLVItlFTqPuSV6N9I8jDD/NaTIJBDwGKS2F9/88ekFb9ojMMg=
X-Gm-Gg: AR+sD10GiEzqJAE2GpUGPWG4P7yJc9KSO1jpmMNb8b06i0i6C/aEfjn3JF8PGr7uxxE
	GtK8gJbtVtIIYlTFbzrNzW00fTZRHolUihntravyaaBDXNzwKfWhzinIg4t1qzyJPwDLoaCAUut
	PMuS8iecg7t05TEypY/pf4Nn52b66zUE2wFFtYv1XwgG8M6CRIhAWtk0kXEavCvqb4lwK1yvxMG
	YEKQBm3QmOqrMkXEdr9gHOuVV7e8LnCsUKN6QLnEBkhitaabjQdBi4YeP6wJjzMl2ldBVMHrsMT
	s94MPEt3wKnI9yh4CsNo5IeMJq+C3pmsdTttLgOF/ViGY8yyg+E9kNNEuDmQ52FExidnKlFqyNX
	sFgpV8AhePB6CLiVxgMDHMs78GLKtXcQCq/Xr2zEF4Q==
X-Received: by 2002:ac8:5f95:0:b0:52d:6f91:86e with SMTP id d75a77b69052e-52d74b6c8c2mr77157061cf.15.1786645098738;
        Thu, 13 Aug 2026 11:18:18 -0700 (PDT)
X-Received: by 2002:ac8:5f95:0:b0:52d:6f91:86e with SMTP id d75a77b69052e-52d74b6c8c2mr77156511cf.15.1786645098222;
        Thu, 13 Aug 2026 11:18:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm1289151f8f.6.2026.08.13.11.18.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:17 -0700 (PDT)
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
Subject: [PATCH 13/16] target/arm/hvf: Lock BQL outside of the vCPU inner execution loop
Date: Thu, 13 Aug 2026 20:16:36 +0200
Message-ID: <20260813181640.6537-14-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX0byvbjKg4Ogs
 x/BQBGF0SfQe5rKah/mnqmCV8kqu9IK6Rgq+802XEIY8JCpxQyDFNQ7f2NLOHgOeVcdNaV1xy2q
 JUdUhoNZJLJum3CSpHCdhBZQcLj1WRura74h2OXo0AzvwrLMFxl6vjWj5UfOmyU/1ExfeuaHnlk
 IbYkzVy5SyQdixfyTR3SfOaadg/Etx/8EMbHBRvoZWKd6ioJ5h1V3AmfdTIQA9AC/Vx6WDyKopb
 KAFSxUDcVyz+eipq8UryIpL3dGHpRuPSruZxnsWiiHpV/rr6nhG+ghorhZW89T+CaHF2/bfDt0J
 uILTUoGcHGOAHn9YdNIorCvhk+YVpAZD0M3i2OJebA3rBMGB+FsYiMuXnmNzGyCC5ZK0SWWjJNd
 3Csi7rVoOCR6+IagJOggHXMP4u91FqKCziNxNz+v2M52mTykBfr2V7nc32UESWWbWa67cD2b2aj
 hggqu5Y5FpYjHHRrFpw==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e0a6b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WxR_XFPUuro4_54D_dQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: SaruvqMw7d7yPQ47utCVsYdbdz2ZFChA
X-Proofpoint-GUID: SaruvqMw7d7yPQ47utCVsYdbdz2ZFChA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXxNHYt67Lw3AJ
 N240xR8ypZA26bolJi409b8WxZvDmJ0028OmnJXf4eXMPE/lPIIBohpMfP4MDrG/Pj3JZrl4wub
 VZzi2TSkfUmD+ejGMXcVpG/+rWchQvQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Reduce lock contention by acquiring / releasing the BQL
outside of the entire vCPU inner loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c14ea54a67f..9c6408d2e25 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2598,20 +2598,20 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     }
 
+    bql_unlock();
+    cpu_exec_start(cpu);
+
     /* Inner vCPU loop */
     do {
         if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
-            return EXCP_INTERRUPT;
+            ret = EXCP_INTERRUPT;
+            break;
         }
 
         flush_cpu_state(cpu);
 
-        bql_unlock();
-        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
-        cpu_exec_end(cpu);
-        bql_lock();
         switch (r) {
         case HV_SUCCESS:
             ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
@@ -2624,6 +2624,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
+    bql_lock();
+
     return ret;
 }
 
-- 
2.53.0

