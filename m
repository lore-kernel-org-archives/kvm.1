Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E58387581
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473271; cv=none; b=psv5vQSrtCXaJi+oibhtuZRqFe7MKIVnukT05KMRgKCvQ1LLE7/DL7W6ctEdENxnb7xUwABhr6xTcySp8nVqLsZB72k/ULMdPgKEgiC2bYj1cbt5ZvUd0isLmbq8A5oEcP1j99uJbpCO2UIuy/3x9KnPITBs9Vkeskt0AxZU7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473271; c=relaxed/simple;
	bh=qxBG/x71NMgTT30J/jyFNM1lVwlHxMFEQVLbS4VPnYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6odgbjLL7iwjlVEGaW8hlXNm3fhq0spj13cExygeR27nlbH4wrLSRbmpa6Rn2WjzjpiZW4Qz43ah3KRtrtwevVKlGX7GgOHBPypZUhA7ohVTKpy2VZesqYSxKlvhGU/DUumL8cZBwM34e5mp+m0AL0elXtkwM5RYXFWe4LWYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bs/fYvUY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=We5N2Bmy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bs/fYvUY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="We5N2Bmy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGORFU1170169
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=; b=Bs/fYvUYJ4ogkZtE
	wkqQrJJOcv5GO7HBEKrp3uVlGoEJmSmTfrnXawG5qvg2EnlmUVnG9w02PGM9pIH7
	E2tYKKqNVlIS5S5fam1glsvs/fM85wPw5rjYQIVgzcrzgS0YQEf0FRlvCEjuWkIM
	bzYJA35x/HHMHneRFGUASfhf3Bq8RcF+YizVVYWcTen3qQnUZ1wr+83lJe8vgFTc
	EqpiKd7CdWAMk/cV1T+UQbRioOiC6sA0FCTDLTRKFTBK6MIb5NFUcXFuzgX5Lev4
	+Btx/JjCYBNp4QcPzCinCDcfC/euDCAZvP3x0IzpkGjt1ZsK92xWwTYwErmucEPF
	pZt3og==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc23ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-526da7e3c9dso2196301cf.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473268; x=1787078068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=;
        b=We5N2Bmy51BxlgB7S9b6z4Q32EntvoRGdc1+ztDqfSFYv5eM0FE2OYmWc8ZpAzuJIo
         C6xJv1IbTSxGNoVWDZRbQOg2rcJzmG6Hswv1lgGv5a1GhQJl57o5zF8Gkmql4PczJWfZ
         ZDMIA/lVqVvr4e5+pTSjGnm5N0G1LHCK2A7vt2Feg7Icl4usw/7/9gJCfB1cWj3JFw5r
         CWtEbF68gIPs/9wHzQu4yEjKJZDqOIg7QgtJUKCGGSLEvQwwE5gfZBBJzotYXuIadDgi
         mfDu8/cqwIBjJujo/xARAzGk02/15pgNTvwUYEcjg8+r/FbWTXPdkwBPoJZ+sdBHBP7s
         aFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473268; x=1787078068;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=;
        b=EGWCUfvZ6Xp17LQYzJr0lKTrtXUsTgLIG9xCR9MqfYSUQLYL1qYHpLxXOkcQn7p2pP
         ZPTwHMqpE8KQvDqyYCp9NSJ6ZCNU4zMXOs15Nt7zMwxtrR8gFruGvxMxQiIAEdObqL84
         G/rV/NPMZmUNxZTT+GdRguOHJKWxADpDMMw/kFZDPreS9V/G6+Be+x+RP8/SIzGVFvv3
         5lP7S/0weLvlpRtXUltU11XrvJw1hOH9ox53ckxPU3O7qC2H7g+ScG733cIpHljDdND/
         M94Znw6zu9S7i/I60AAir+ls++J3FFJXr8EIqrRsgNZHp2jS5xYRBUVuB47slV97JS/x
         xeKw==
X-Forwarded-Encrypted: i=1; AHgh+RpyE4GEuayXKjUziWU/EKHp+5BB1/4UtrW+uEbufXHQgzKXTP6iu4a+5x+1BIRoH19SU8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+AmGR59FhqV/UQuarEUmtwz5+WtlupRLFewGXDb9hpc9FU1f
	p1nzINFj4P7CKn199O3Jle0BnOUt4OrxBSKAbZNd3mXM8+3c5j4f6l+QxHiqRXSvqfL+T6OCOvO
	oC3DSOvB1uuczDsAz5ovY2qo3+48+FmIsfkLs19Ul7O8hx56aoV4LsTQ=
X-Gm-Gg: AR+sD10skT2rs1bbZGXAFIlaMTiWKq1nhDzIRkYa/b/9H+tuGfQPhKSCnu7yF9F+Xat
	FpZRSwZ5jGkbaLa4g0p3QN1GexgFbYJhRTD61lVlg+my6305/V8OSacIW/Z91hvmkEdrVECWS7M
	LpCupTxT+2nFpf4C6LKt2TLudvPfuUiTGwEHPZlEg+gR6h5zhuV0RviDP8xnbJ3o9MKPRI1qFcF
	h9oRJW8dmjn31xZYWurw/xGiEfy6UtLJ+W+bjdzg/qh9BDSm7C9/j0lqfVYEwbzB+qKag6QmePz
	117t/SEXc2h9feFsrIqqTCEajiRQeNrqclNRx6O9Mrf1GX9be3vfSXXZF4O2l94egnYvV3hEV+i
	+I6mABnkrM5gTQN+8A+UpZeGkAGvq7WJ7harDrjyZLQ==
X-Received: by 2002:a05:622a:2611:b0:527:69dd:5413 with SMTP id d75a77b69052e-52d584ac3d2mr48841601cf.5.1786473268436;
        Tue, 11 Aug 2026 11:34:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:527:69dd:5413 with SMTP id d75a77b69052e-52d584ac3d2mr48841211cf.5.1786473267917;
        Tue, 11 Aug 2026 11:34:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aac6e85sm10692135e9.14.2026.08.11.11.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 2/8] hw/cpu: Include missing 'qemu/accel.h' header
Date: Tue, 11 Aug 2026 20:34:04 +0200
Message-ID: <20260811183410.22428-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXwaCROxT+7XIP
 ko/fF8J0DpWkAWT7CgbU3oIPXUfQFnmjLRm1oWu96dYqP3NLAYy8Udbky+/yV77oGOXJnhEcW+8
 TdxPDfcv4GkjG1j25FW3VgKZNN4r1dM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXzV8CPD5Cfb7e
 AR1M1hzIE7JPmVTUPrnPJBE451Qd/2zcypvrEsMKDuYR9daalUrv4LvRDPzQpGNbv1hovjW5Wti
 FN4bdDVlLpjG4w+WwLxQat3IV+wnXH25RwcKGoSfbyiIT27X7ZRpJEKvkDAVV7853zP9F7b0h8b
 AqtQSbP1fnnC2+lM1uB/lz3hPGlW5340oNo/dTf+hDd3g9unxh5uO2gzzj71jguaGNrfW17E4lt
 1h2OL94uuvMVMHgjzl/oivPuPksv+VVQY2fVfv8zqyIk+IGQvB8GIzLSw6fof8ZCGAzxxJG/kg4
 4gIwgdsXWR1H+XnsBvD/htl0lTPGBrW5PMqdpIvryEKAhhwmRwIJKTJUY8TGVE+SMeJHjgDy3hB
 d/SoP0nceRXuNxDh1T6wAf7puu4MLRGUmeJ3a1BjHEAQFaGvNuQW+EWR8EUWpEdGuHPxWHn6tUl
 XvooPWyoEeFcMuTklUw==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b6b35 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=z_YzvCJ9eykze7sI9H8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oRw1Ns1gjp5Nt56is5BGtUP6_AAulsOe
X-Proofpoint-GUID: oRw1Ns1gjp5Nt56is5BGtUP6_AAulsOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_common_realize() calls accel_cpu_common_realize(),
itself declared in "qemu/accel.h". Include the latter,
otherwise we get when refactoring unrelated headers:

  hw/core/cpu-common.c:233:10: error: implicit declaration of function ‘accel_cpu_common_realize’
    233 |     if (!accel_cpu_common_realize(cpu, errp)) {
        |          ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f84..8c9ff25e04a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "system/hw_accel.h"
+#include "qemu/accel.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
-- 
2.53.0

