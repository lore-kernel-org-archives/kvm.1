Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEB390610
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473264; cv=none; b=rx2XkYjupqd9EKn5lQu1NH6qfYCYdIScGm4cEZ27wU69Ieec4pe8yzID+0C/RrH6TkAFf+vNbWFUP1gt5ewhznajCsJ9TUyv5wSmCOkcO5X41dV0qiPygjPYHkwgIYzPuZ/b2UhsAHEUDXezy+qSD3bwF0oohSPBgcA+I2pVfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473264; c=relaxed/simple;
	bh=rZ3RL6uNoZqJDN5TDmNqkaIPJM9KLQI6PGBxAHKtTjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOaSx8ZNVSqWxfjnu7Kw9azIBKOOf2qR7L7KO9LbPCCgQGIMaY6MUIkE/5tQnIwTaciHSDcxFG+tdtnOsO3/JGl5GfsMl5x/Xcmxwzmiw1MV6avKRD24EEhB3kYi8o5EtR12GV3+ceeprkK7UjCdNrK8QFoitlJISPrYyBQwiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3dy943j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYpKApPa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3dy943j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYpKApPa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BHsZEf1919966
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=; b=U3dy943jr3Pgm/E8
	OFEojGQ40w2tepuviwnFCOR6ZhOondu3iD8WOsY0jDAdHUiHSNzrCIFPUhURw0RB
	GH6TwooSJMwjj5h+aFRebD1pee0XAl46V8LBHVhcsBWaRhcIP4u08ISVNMJ1+GdB
	yelCy6ifuSF8SBaLdtGvwgNTURlGR1MX2g44s6QSA8W9msEN5jSHzilD4KLm7Yyc
	3kqmqJlgivlgvUicoYd8I1llYiJFSf6LVY0W0A3kPlPhcJqzYgkDynHRYU6brRSq
	zOWClrAf0O1hgIoPHbgR4bDJlwstsymxRCejnooKXhHMa+IOfmmQCGqvN9UMBp+v
	MOlCAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5g5gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso3063801cf.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473261; x=1787078061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=;
        b=OYpKApPaH4Q+X/IDycbA3JNuQVRlNK/kNMZx+qecbHDwU+HP6359kkefePGhdSo/RP
         4AYawEdU+rRsB/FWjYYpWmYVSQvI0ESkf0kjIYasjnTYV3Hokk7v6h7LHTIUWDGcwJ7E
         79v9Zz31o9kk22Dh66eM8AtBpKvzCXGW7K6HSALRCqk9aJDX/tXKjpBMbYfF7Liys2Vj
         Z45CHM2xzFyIJzO1SrOXI25xz4mK1eT6Iy5nHxyNkxeKSXRkr30RsMgZFo2ql/YFIFQS
         9p+LM3xT9eB8g0YO9F0Ry6cxqYDxnq518hicqPCLjxmK3b7MzXGJ+lGaDfZo3WZD6V1I
         pcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473261; x=1787078061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LahR4PsoDsUon8zyy/2/dQlNlZenYbz4hKFiVvKYPs=;
        b=dO/HE0LgsxeAGag0pnafJIN/Q23lmCaguuIVuaaSroRTgX+LPQ5FUUgnF2Zm13HB3Z
         9z/JbUS890pja1TVUO1WLQ0Nw9t5UdGMg3pkU3+HHlSLduIE3vrHMkvDKzPKaL0WJQyw
         K5sOBKwDMAIpzIAyOPGYb4BVaTAlO+uICBuduCAzudoSWcVQiOLg6Ciqvc7wLB0JMc56
         +08YDQdvGtfNUm2xKs72MunWXyfKEMCtc+0NGctwjwORcXC4NOgj8OoNL+Phz7NZB+rs
         cJfkKdtv+UbZKUwy+F5Pm0OHVyMLBQbhCPAwFAJxov0BOXnAtBS4PZvbov9WDYY9FLcm
         KgAA==
X-Forwarded-Encrypted: i=1; AHgh+RqLgQhs9dpQq2AmqeerIWKbf5ccV7NT3Waxp/z8anpNxmLPeWbuGTV4cMKgP9zwrnS1cHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkXymmCCNnjFf3Dp9mIXFuggYznEENCqoHkYstn0DI8UYF4Mh
	LDBpDosNNRXOd24uQMXxvp9vUYrHVEj/Mbgr2UPKkQL2vtwXShiBKi2VceTFqIuQTRsI3xGknNw
	W06/BmJD6koHgWfC9cngvtX8+7in5RkD0Yn/MY9fXXAyoKwIp/qv5+GA=
X-Gm-Gg: AR+sD13mxhYYOPJWckhMILSkoTurynVgq6H97pgRP/B54oVJaYilUbXMh38KePxu19V
	45DpsynQDTdLGN9w10tRAv+oHmMPmZmSKKwv/gnABlTbu6Jak9eHVPCX+eeUvednRPg0pTEYj13
	we5j9gDU+4+/aoukM2E1SGPg3bmpd8s2nEOyFTSM0u39AfGId74hh940MWjetzY8jUHg5fZQSY4
	tP7Cg5tD0yKt0iua/GwfVKe/Vyzz3krpo16SNiRTpXtXZ27m8ym95uffsj/HOWFS0PUYUx5ZzxS
	vlwKTjnHwOhl1ERhHzuErUruBoGxzYnv2VZw6+k7b1gkFiB3gIkj6WAOQ+qV5CIZq6HAkkHAreL
	WX9VbHsJ8kLwU9jT+Nn6Nrhf7Dh57pT42r27NT7BW/A==
X-Received: by 2002:a05:622a:1b02:b0:51b:fc67:c738 with SMTP id d75a77b69052e-52d5866ceacmr52372141cf.29.1786473261121;
        Tue, 11 Aug 2026 11:34:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1b02:b0:51b:fc67:c738 with SMTP id d75a77b69052e-52d5866ceacmr52371671cf.29.1786473260652;
        Tue, 11 Aug 2026 11:34:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf5c5fsm390300f8f.3.2026.08.11.11.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 1/8] hw/cpu: Correct CPU_GET_CLASS() comment
Date: Tue, 11 Aug 2026 20:34:03 +0200
Message-ID: <20260811183410.22428-2-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX3K7MhKVFjZTk
 CapoSbg3w2MCqdjy9oAhRyABjDdwzOFktKTvIfoj83tCDerTEivLOqGgjQVWuOZRCxD3b2T/6Q+
 1Yox9M2cQqWbaCtiXdIf6EQfE9dEXr0=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7b6b2e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uwI2kk57myJ7FXLdqBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: xgxHmI-ZKKra3rc6MZd4jAG7CJ0D_uzl
X-Proofpoint-ORIG-GUID: xgxHmI-ZKKra3rc6MZd4jAG7CJ0D_uzl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX0ZMkxJhEGhfI
 jGRChZjBBC0uFB+RRzF+Y0poImYug/c+hGUzeCgxeCeD7Yqau3Za02Xt+Wx5xRL2J1aWgXdbwuz
 +VICh0DBRIff06AnPF1h8A05DUswWrvH3AQmxrVFwd6KmYKl8swFS1cdde+DnOrOJrsKpRo/MzT
 VydrxfS0nEWHjf33AjlT5O1dnnj0wTGBZe9Y0EXIeGTnoH/hQgZc6AW3kDTt1s2rFfwjyUrhN9S
 ByRkbjnJBUcaozOreYMEIqEwkb7F6Dut95Px9zKt9EYhy1Ura1ZR8pUjhqOLO+84cpbRWDgChpE
 c4qhomY4Efkas7NadA5EMVBO0+5YmnXY1g7hIeZpxMyvqeXOIODK5Rkieiz72MpXgrgwfQAILja
 9Dfb6AgLqQPkRt0oupT0ahE8nROSs3HOBnMj6KgTMZJ4x/EpTnDtg0AfX990r4xAFLFGFy7Bi7M
 VIWnriyfgKqQR5mAh7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

commit 0e86d7a71e8 ("cpus: Cache CPUClass early in instance_init()
handler") renamed cpu_exec_realizefn() -> cpu_common_initfn();
update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b54035fb13b..c5064a5449b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -60,7 +60,7 @@ typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
  * expensive given the eventual call to
  * object_class_dynamic_cast_assert(). Because of this the CPUState
  * has a cached value for the class in cs->cc which is set up in
- * cpu_exec_realizefn() for use in hot code paths.
+ * cpu_common_initfn() for use in hot code paths.
  */
 typedef struct CPUClass CPUClass;
 DECLARE_CLASS_CHECKERS(CPUClass, CPU,
-- 
2.53.0

