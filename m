Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60D3546DF
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645022; cv=none; b=By1Fzft80ZTk5yzasouQ5Di5EwmrbCr1/XgBq6TkJrDV4MUo9yxLzLGRamcBPusunxfZkm/pNF+74vN5QaLW1FAmcIW+UNsiVRhq0uPN4Kf29oL8dWm6fBA2cB+2WAz1eIf8JsOge4WS2ft7gIuEQ4TFygd9RczBOY0tD6VjGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645022; c=relaxed/simple;
	bh=Y9Rt94bVeJ2HOEFABAJ1KBZ5iKDzm7YPm5YWErqp9Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+0zTWAUBpgk+4sOVVZYpY/c8UDj3VesRzsUTk36CzPeuwfZZcOewuIWY6vfNQyrCsMXHmxIf91NByOUVO0WOo6ly8JrBo4ePRaPl3011etdTlQ9NXXZKV+R9j/5/SArJrV0ckcDpzWDrm7SgmEBjV7PdU/kpGz0ZTHk9K2py6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jkdX+580; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RqVAP+AW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jkdX+580";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RqVAP+AW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFwgsH3248789
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	je+h48SSHuNHSOcK2Vh76kGO2HaV1LztKcGPEWVgCLI=; b=jkdX+5805XeSZ65F
	zyAqHNN1EEGu0GEpXMbYVx3QNeEPTzKVMg98z9wcqTXSD05Hblpjfqx8B4MIPHBx
	Ueano/1EY+PeKVNFXQ7H36tK41VWvzN3FhV+34Rxf8OloQOqmP3J9KiuaNLEa1Yn
	pO2rg7KNryLSUsiPo6BPNaqjT22SHZoQ7Ao047A8Whzn/Lql7MQpU6Qo+iuP+exf
	fl7859Edx9BtEpteHeNzPS9m3TeuGsPCnABevyj1ly6OQaR73islKYR7GwhhMvaU
	BTBq4auXdtqJXCaPWi7mDzV9zME2TBzYuQaNpxZBzkFUavyXiUHpJvxO9IebqRY5
	eVEWZQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1urp7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso3574971cf.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645019; x=1787249819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=je+h48SSHuNHSOcK2Vh76kGO2HaV1LztKcGPEWVgCLI=;
        b=RqVAP+AWPmP+skQZXKus8NE5SOamyD94SNe5vh3dJnSybSbIhQHk56R3k18FXJaX6r
         iCMIV4dF/igz5nHFVlqNTX6ESa5GmCLqCp2h/Cmu+SDbhNM2m/Mz8crYqQJ3r+6zW4tx
         Y595FTVNLj8lhlK/RTuAhfTBbkT9C4JGHAkCaqQUXiWIf8fogiQLKl8CKodmKeuKchck
         D2Ughtr9d0PSH+yCErc8//Rbp0rThPlUe4rXgO/8+JfbMfY9DJGRHpxA6sVQgvA2kaMD
         HSUfnQXK5NZomVLyRzmeG+Ra7NQdm+c4CWA+fePA6a0n9Xzen/CDE/0OHO/M8eBJuoiD
         9vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645019; x=1787249819;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=je+h48SSHuNHSOcK2Vh76kGO2HaV1LztKcGPEWVgCLI=;
        b=JRB2L7HGzKKFjTdivQw5IIaWf14IB8NEtDCsOIMfIUhE+q9rn5NSCBqDIbhe3jXRF3
         YlYTPWjr/3O/vbkoaLWPJv21cmpZELusYx4MfOXeLly9jiUrpI5DcoFBgMVKFHvXJjhL
         bulMjgnptN/+L5K/Q9bqTrslXlNuN0tHAG/WoyhE1thtm6wczUSZL83SZCWvNODR+Oqq
         EqLXasyQiPnMnfyKLZcFpqaHTUniFAaOS2km+1yFoePUOk1Qb2hrgBxUMOelVA5AUn+d
         Er6gH7jiJCgkqTrqDrSxr66JLIxK5f8oAIw9Q59b9rln8pxHMueTRzsGg7/z3CWtqN6Y
         KDHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8q2bJzUI8B1Gib7Gsxc/deLBBpbXiRGtDWJZW+468PJLjT89FBk/bNDCy3zK6lUdooYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqr8L9MzzTgEzZctW76HYupL15uEgeZkvlUDiwrNRGkPpSiIn
	gtdGFkHk8QUU7M+NUGxo8zrAFGE8x1cNm3E5Nn67AvqAH53g4SqkprYBqcDoM/a81sq1tgo9Bsc
	b8iJrmsektvyIRi4PQikclU4C/qJDo1cLIsLeGi4/S11SIEi5h1C2dbU=
X-Gm-Gg: AR+sD13v2pek4fzkng7G/bDnKKzxxfuqYLYqxj0+n9rWDO/VcY9D6wUj5xtGvlfJ8wP
	yoo+zBpFSJiCz5rbirdEujPyo+AoO3qU5FzbPx5qrQnkbBYXb2BSmgkWt5MY550XAqsUNHI6Rh2
	DZa4Yn0hOkOEDZ2E9R3fgip5O9tG0AjG3w+7ygNN4tNy5zPVbEiK1Y2jvRp+DlprCk7RBqIls0N
	+AgRuhkQ8tGPlc0yUWRoNZdx/oL38zkBX8DclEuexun5zZCgNhs3WOm9AxorTntD/mY91VLnpyS
	qVGLXqbkoyLvOUwDFSt9UEzbV44B2hYrKB3BS5ziew2X9op0Jl94fZ2TrxichnpRf83yIUGKfA+
	h8hrSiMHgo4MJKluBfRpe/WW8/JDMlOrd0Rs9HYq9sA==
X-Received: by 2002:ac8:5c8a:0:b0:52c:dde9:5cc9 with SMTP id d75a77b69052e-52d73d2abf2mr94409741cf.22.1786645019042;
        Thu, 13 Aug 2026 11:16:59 -0700 (PDT)
X-Received: by 2002:ac8:5c8a:0:b0:52c:dde9:5cc9 with SMTP id d75a77b69052e-52d73d2abf2mr94408651cf.22.1786645018552;
        Thu, 13 Aug 2026 11:16:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777a4bdsm4564815e9.0.2026.08.13.11.16.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:16:57 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 02/16] cpus: Improve qemu_cpu_kick_self() docstring
Date: Thu, 13 Aug 2026 20:16:25 +0200
Message-ID: <20260813181640.6537-3-philmd@oss.qualcomm.com>
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
X-Proofpoint-GUID: ujgqfsVfGfryd21eabDBHoiJhwYLhMpP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/VSzIecm6pgn
 mC2nSh4SRxVed4O7jKmbT/iKrPT15xQaQjkAqL9f4WVfiZGSy0lEQvffBhJdMyi1qOPiTU0aYaB
 i4JGq2/PyXxDMo1RIj3y/Fk2sjnzSOCiFwoh16TYutb4O7A6QT2gPNBfmax2iyc8JzR7Toc5MX4
 4qw2c7rNseZu5/Wwa+nfK30BygskTnd4e+QrRpoIXRgxolkj3qc0DDJcMOJBHW4h52VREOf6vp8
 4t4DWwUCnVz02M1NdzLLB9xcDLj7VGk1z337Qhn5tDCogMkfveDGEfWK0ecsVKniWiRyp0GgS/V
 hHkY9R3Flx7uLapFnEQEnXckV6TmfL5z+sZD5yH3FDVlopqd5V+kgIfEgGOTdToi2ZmM51nf9T/
 nxpxGi4N1nY/YDHmsb6QulOCJHmCtuVLKhMhlchNaxOLzJ567RetmSIPwAo1wSXX2XDTA/wJnK/
 VfgmX+exWAfrVJOuqFg==
X-Proofpoint-ORIG-GUID: ujgqfsVfGfryd21eabDBHoiJhwYLhMpP
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7e0a1b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sTtMEC-yLAECRKQ91SoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXySCxzuAi2IOZ
 IuwS3tCG4hqfePehp2yhp+ZUgp/eAmlFK4Rx6+7IC6NmScnm2ALiUC8iaz4Ej/AcsPYxjPKE20L
 dT+EAfYMUQTZXTXDeZPI0OS+dG+7KRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Be a bit more descriptive than "Unblock cpu" :)

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/cpus.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index 508444ccf1c..ade13e068eb 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -30,7 +30,15 @@ void resume_all_vcpus(void);
 void pause_all_vcpus(void);
 void cpu_stop_current(void);
 
-/* Unblock cpu */
+/**
+ * qemu_cpu_kick_self - Force vCPU to re-enter to its inner main loop
+ *
+ * Signal the current vCPU thread to exit any blocking operations and
+ * re-enter its inner execution loop to process pending requests,
+ * possibly returning to its outer execution loop.
+ *
+ * Must be called from within the vCPU thread itself.
+ */
 void qemu_cpu_kick_self(void);
 
 bool cpus_are_resettable(void);
-- 
2.53.0

