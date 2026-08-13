Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA5319617
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645051; cv=none; b=Bp68y0cTOr3yrfYSHYGqwP8/hPOu8+Y0qQjuvjJUJQmkMOBcIAKZj5fmqMup/eT3Qi8GHF4Rk7JScHfFq+/WULZjwUTV5obsTnxrGBLaJx7MmUA3RJRtdtPG7a4O82UdCE6M/WYp+uBRIc4HP7nsWk6wdWX/kHUz1ijubDKL1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645051; c=relaxed/simple;
	bh=ZVQuBnJFsXENT6WsIC67FSJSaM5pXaBDpUOMn3D8+Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6FDZBppmKDr0EhOOYptC7boY6L6TxI0UNHkqChHrzldZKRlLPPvICefIn5hFzKmL9czFMHYhpsL9yV0TiYuC/hhUwvmz0/FeT8ZmDR7S8Qh4SesH/EssyrzRfMlYHspldU3z+OYPevRJTt+mVZ6+TxG/J4ZOgVIZ88d3tiuDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiWQEn/G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z8rlpwVV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LiWQEn/G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8rlpwVV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTSDQ3177706
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QUpkBT3vzMLzNP9l26VILjfTLo8RAThxlfT2F7nsTu0=; b=LiWQEn/GpDtpTz4W
	PvmQNnbfd3vyKQ4ejomX6bI1pChD74UDsrbe6/CWizDvW/rfn3P25M2G9glx6G3j
	GevnmALo2UA3A/cK/9AtGW1BnLvYPns32UJP4lTjUSUxEqEGDdIQVHQ0/0mtU97I
	cQrO5a5MUaC/OOJ6CrkAjZA8OBiVOE/sD0nkyKJV/X6U6zLfgx2nad5hDuAb7tJH
	oVGoVmfU9MQ4PjFb43K0KjGZPcXah8Wta2f7/xEJHZI6/1fw2nLr99adYj7NFndR
	97UvxYAyHT9+K5P993ogOD9jA94/vHAj5kMxL9D1crWgVx3udsm1urUDBXeENoTo
	ml6dlg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1f94h9n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so2524041cf.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645048; x=1787249848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QUpkBT3vzMLzNP9l26VILjfTLo8RAThxlfT2F7nsTu0=;
        b=Z8rlpwVVoV6Wktnk5HkGd06gCSvBB0823Rjq1s1vWsMLT41ND3JvHuwRCXaV6xybFo
         LYQflFl72e99Zk0d1Vrd/QYP12bmrKLEQalaj+uQ/JyFXWW2jpr+wUHZfgn94gaeHHR8
         i+GmMoIkL1bxS8I6KPni3rB8JIBKVkXKVpx5OcuVD6KF5hWub9j5SVKseTcjXEcSeEsx
         QnLZ1yJWjQQbQyct0preUuVSYeE1+4b4WjEQTmmYUu/JwmXG+ltQos+KNaMvkNmwI4vr
         TX17zD/whtGZlknn8hH45OmV7oxh9LyCpllDzH2GNCG6U7PopGMJFGVAKJJ0he8B4dTU
         NOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645048; x=1787249848;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUpkBT3vzMLzNP9l26VILjfTLo8RAThxlfT2F7nsTu0=;
        b=XoKrU23gvwgTH3PMAYjFUoBo6CkKgYuyy/U+PsxO7z74L/SvyHrF/FqsTfLgpsnwGm
         eFGEF5TQ5AX29PfgR4dh2b0Vx2TROHFTZcoxSk4Xk/7j0MNIPVc+7zHYiNHP+jl1L9GF
         KqyC0LdNMv9LqfGxtAoYJrwQkYKUJ+gv4JPqHiQzi8W+zBP/udl7Ff4xbhqtrpqfQhAj
         ET56aae6IP+1GJdViwZv1kQDGOGwSjYBRvXGQRpx2iTMVymin/RHb20xWpJl2Sv+KtHB
         oWyRWSSkMr/9v68hx3FynzB+0g73X3D19HP+dqn5Zz77Le9AUE09CSFWNUxenWM0C6os
         m4Ug==
X-Forwarded-Encrypted: i=1; AHgh+RrkT3TKF+YfoPumVCis9c9aL1dYyWyLogmqI/btRaCNK+uuKk/LswdlSJ/D02sO69xosgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfYWx7EocokjklsDisRgGJlPN+stogpF6E5QAmSB0UrCOiLub
	clMxXV0ktJFPzs/yLjlFobE2nGAck/vpf4nPGiPJl7BxI+4P9cuGF6a01OTUtxT9JeshYAECsif
	ssXnmznkBJnHdkCIx3p5SSK22358KmixWLuUJVW7SLle5s0pg/z1Cnok=
X-Gm-Gg: AR+sD12Y+/dGddh35TGehc8yiqv1z33dGdUo6tuG/LzYDMfKJcYn5IJqYzPKs/GGiEt
	2U0MQBvqoOon2jNN4bAxYTjIkwTuh8tcsVRSlSFbL7LbK8tZHizgFbNr46ooKMFORm3pGXqRafO
	iychx6qxjPmvbiJQbFxzdksMlWavwlHQQXGZq4YknddFD1Oc1fNFR0nNe+x+AAwC2xAOn/2U2LC
	HS7v83rYqjyHetdCEY+nNyQRAO0tY/KQ+X/JnmcGHaMqfsUmcB6PMjBBQd4A2IDvIfx65hzSLQT
	PbFcTQC4CRyeV73NLd7Le8EmDi/WTNCtJyMUoEY9OVA77b0asqciy/+kz7/XVMPjBvNZ0v1+MpQ
	YBDkxG9HuKRBEgkbzqtaQUc3wwVy4GXC1tmUjWqQVNg==
X-Received: by 2002:a05:622a:4c8e:b0:516:dda7:51e0 with SMTP id d75a77b69052e-52d73c8c646mr95096031cf.17.1786645048016;
        Thu, 13 Aug 2026 11:17:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8e:b0:516:dda7:51e0 with SMTP id d75a77b69052e-52d73c8c646mr95094951cf.17.1786645047369;
        Thu, 13 Aug 2026 11:17:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm1283256f8f.6.2026.08.13.11.17.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:26 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/16] cpus: Improve cpu_exit() docstring
Date: Thu, 13 Aug 2026 20:16:29 +0200
Message-ID: <20260813181640.6537-7-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/UzlsGACU893
 jbkaTUJEkSC8tkxa0+MPf1YvumYNfvuD51HBNZDrHLzKFJH4yyJxdVCHCfDgENH+JQjVv9ropZ6
 DDhGjEOGnH8f4HBX+qm4PiE2h3BN6Pw=
X-Authority-Analysis: v=2.4 cv=VYDH+lp9 c=1 sm=1 tr=0 ts=6a7e0a39 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2BIhYVGhW6Jtnc0Cf5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: -TJFcIAfIr2pU-Dnv2sz_04Bhd_Vlkwz
X-Proofpoint-ORIG-GUID: -TJFcIAfIr2pU-Dnv2sz_04Bhd_Vlkwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXyHdeMsNLywub
 L90X3EuGwZrOD4OwXe/MBbFqibFW1FOcqoCYbkfVhZyQx9LaCrYAdJR13UAI4Mt8HErnVQu005P
 NbDpUqL/QtkH6iYiDLG7OMcj8goD6vjH9ptec7epytbIuqCG0aMJVEhLoiNVdPLqCnLy2xvofS8
 opd5d6sNT77Ns7LXpPTGNBMV3YtUZyD93INiFt5bIvUuzIkWm3tO75kDCpnBHL7/nVmmPFYUCbY
 3s63g2V+1gh5gMumQ/m7J4yDTVzGskuk/oRoT/sXibiS8Y0rFpdljw7XIGQc24PBEYFgTnr5Kd2
 qfN5OKj9Z4iyYK7jd+OoIy0TcZjLCIXtzHyNgvO7SCr/3XSoUAIZqA46IJUTrK8W9H03AONIoKk
 S9PFeevVaab7EK57PYhAUKJtLjFGmdfS0SKCPVdtXhwowOVLgXYu16GtSxVJs2347CDE0V/mCby
 /6VkN1YImM3wdimcTgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Mention that what the vCPU exits is the execution loop :)
Mention some of the reasons for calling cpu_exit().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f1ac492714e..7da81f3ee85 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1037,10 +1037,11 @@ static inline void cpu_set_pc(CPUState *cpu, vaddr addr)
 void cpu_reset_interrupt(CPUState *cpu, int mask);
 
 /**
- * cpu_exit:
- * @cpu: The CPU to exit.
+ * cpu_exit - Request the CPU to exit its execution loop
+ * @cpu: The CPU to interrupt.
  *
- * Requests the CPU @cpu to exit execution.
+ * Request an immediate exit from the CPU execution loop to process
+ * pending work such as interrupts, timers, or other async requests.
  */
 void cpu_exit(CPUState *cpu);
 
-- 
2.53.0

