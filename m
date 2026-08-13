Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFF331203
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645124; cv=none; b=lYfiVf769bzSFckGSp8rSuCac6xb2qBzfzF690BQ6eOkaCK0aZQJ8XOi4CcEaeLBZjHztpb53Q2bK7yY3iUVOJdvQvR3cHy3sojbSZ4/Z00qftjuK5OV+yCKHXw2B87aiaoQSHfHKnwWLJwX2sVeW1WvXnzH/lG7gUMbrmAmuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645124; c=relaxed/simple;
	bh=tGV/EkZIHxIoY84I8trJVmO4qn2f9Tw/c3yJ8v3p79A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chgTJY5NeC74bZHXHIDh9GBe9gG2Sq6Jfbl/w0y155SrugQGVTpX2cqi4OUUeK4UHFVZxETLhdGwV7/eAtE5X10K6bqDFKX8JPTN9dT3nMj+8iEvu3XvkOdonETtOPuxHe9he0E/Hv4OLUjDJRm/8zG8g8P7AMqi+lBe/s1Qfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zf/LpJWy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YSZGBjK6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zf/LpJWy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YSZGBjK6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTFpd3177078
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=; b=Zf/LpJWyOil0GNtz
	GRXsvvUH9b6DPhWH8Su/QEP2fUsUChulGo7bBXRQ9026kAMnrHuvNj6t6MI+Jb1w
	21zVNxSX8kjkWRW3IRFRzP4cvXZukRrrWAosh/pYdmlMxbZhc0Zzi3nzkW+zOD9A
	hG6/U5SXBpzBIT7Y3ibo5Ptz4e1NKViVUTJZ2bKTPE7NLKqXMOTZbnhQXDcfBxXE
	cbAEdqtFP5o7jecRctFwW08J9etnwAoi3Hz7xSEWJYO813aQPbbmImIb8r7fPRiq
	mwa7KRf8kumLiH96qsR2ojg9YoehPXV74ib8m/t7kR7YfRXxnn2G+8RfHpQj1EJ0
	Ts6P1g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1f94h9ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52cd0374265so4358471cf.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645122; x=1787249922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=;
        b=YSZGBjK6fxJyXgTfL12RPvdFhUcilFvTu/Lf68fTJ1KdmCXYVaD5WLcXmFdnAi6xeb
         V3fBemNb7J6/Te7mrvo1SZMPNdj5mY7mgHk6tyXYyhrlsDJ4Mb40wUVPi7UpVnwLr6S0
         sRG1YOkgoeL5i5kmbjCt50j/8vrmsRNVVZosjSsARTiKP0UTnUh/hoBKbfaiqe0haP0O
         mnu2FbfWTK3rFPDCkXb4sLRuugQbHJkU9vaLfv/jTdoCayzPOrochbxDzviWl1TNs2QI
         9KG2EgJxBwAKijjXimCj6ntZz0IIb3/Yd7MM42rGssb18Lfb9S+GgpsV7vABkdbwiGyF
         vZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645122; x=1787249922;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=;
        b=qsRYwnaAs3rmRJ9CoWcGM6aQQlBTAfb/B8wN0vVKY55DYTMzcd/Ma1nLT7AEz5bX7m
         WePClZ+pbFPjVA57OoBREKsecyv1WAxZkJSoPJL22u3+KWirUnKKf8VpmGmyCNCb6eoU
         /EHue1El8uWKd0RzVdw9YWPSkdkIffEk/ggD15QLYjv0AvxiUHgaizzcNmpJZIlzIjiJ
         XiLEzm6ZXnzxpShtBQKlBm4a9kK1d+c58RBIi+4Zmg6zWSoH7bmDHIACnNDwwOKLGbN+
         hsPyG7/ONUz2fqEE1fmQZDgSLitbCJMJ9Apkz7xQWVZVt7qm9VQxHvbT+QfJxBvbxE5a
         Vx6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrg3FYA8kyBtIpyE1N5Pp6wAQFZtCoQDiQJax1tKzOU6zS6EMQ1TXz84Wr5BLfOYl9hiLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzt0t3X9Svh2VM1A6Mzbi1nYMlU95+yZYR7aXYQ9i+4GPsI0u3
	2P1KaI6dJh28KyROUl4S/aQkLsKtuea2Bchnh83091AXYGFr59sCGeN1T6Y/v6cGJ0oQA4Agsb2
	8L/EdjREe93HDtu5iAUhZ6+Xz9vMFv/TlFxAOjVH2934SoOmOTmAXkgw=
X-Gm-Gg: AR+sD11eZGfUXplP1VcydGU1FLioVHRUCk2+SK8wtHAFfvxaiTqxBJmgm1Gnh/TWfth
	oJb9YVFfPBsG8mP01a20c7l4683HNsu6gH9YMoPHtMaUp5c99v9edBeofjJQRHRoSkBsE2T1RO0
	Bbowx4rYD+gc8lI9A7e1b94h5PDfmY8ereV8FrhM/DpVGvQiv+6STKJWwZ7tQL+aOqVfjcYBguu
	HR+/A1g73QQrwaXLBgDjNJWYTPE/nNqeMUudWsy5KVtGZlEJFh/Wp7JS2hH9Ph40oCOAFY81S8J
	ZT6WivMpNcfIrAFpup7ltGAphFIgemFVp2IFMZ5LhPM/GiHFPokjkWuckm7biNNa6K7MYgEid9t
	l+/LblPRkQkwThSXTOf/h63daO1S1DChMPvZ7SeVREQ==
X-Received: by 2002:ac8:588d:0:b0:51c:103:fb56 with SMTP id d75a77b69052e-52d73c6fae8mr83158251cf.15.1786645121321;
        Thu, 13 Aug 2026 11:18:41 -0700 (PDT)
X-Received: by 2002:ac8:588d:0:b0:51c:103:fb56 with SMTP id d75a77b69052e-52d73c6fae8mr83156831cf.15.1786645120303;
        Thu, 13 Aug 2026 11:18:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49982129643sm73839635e9.4.2026.08.13.11.18.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:39 -0700 (PDT)
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
        Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 16/16] target/arm/whpx: Fix argument order typo in memory access error message
Date: Thu, 13 Aug 2026 20:16:39 +0200
Message-ID: <20260813181640.6537-17-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX77F/tKlMtQ10
 ut+Dv6nOY3KkP+DG26wGC/9RXMJUuRJuCKNhhveO0oCx0uai9gWXZVGZV4NzTsSSNgIYtcfIURr
 e0vO6D46AqYRLCfgHGjVJ5KnHoQKxkI=
X-Authority-Analysis: v=2.4 cv=VYDH+lp9 c=1 sm=1 tr=0 ts=6a7e0a82 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=CJsRysG5a4fyhNKOOSkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: NUX3u4-K8bEyPyry-Yaef_0GmnV2nZhF
X-Proofpoint-ORIG-GUID: NUX3u4-K8bEyPyry-Yaef_0GmnV2nZhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/0/QV+ov088Q
 CQyQnI9yzxN/RiXXs9/u/0A0t6WTWnRq86IAE9jhMNAB1Mh2qzol89TZhrNDcpaiDVjcgSFfgEP
 loivHAsI1piHeS/T9w99HKsRXeZwdIikaQEPCrc5UUxS6wenrstrK+tCOqhwJtsxSS1kPiGJBQs
 bUxj5jLv/FEEhiNDUKJ/PoMdFXs8S19Q7xm0YPYjLqlHNjuHCNqaOMM7NbU4wkg1+P62G4Wlv3t
 /eh5eQ/Y0y8q2EiI2QkyUfoSbwlx3IKNeHOxatQRUy9jgLSQGDEcgIUDzqvZKzwrdrMlXD1UO4O
 vlVgdiXQzJodw3UQDad0tbKXX+Ca2a8bvIJDMfmmyi2A2+HIMCEaz2qQfGLRtxe3DnlyZi9nPds
 gZF18wEf4er5dEehR8Pd+rrqQ49N+PBpll1PRMy7nRgOLmWjW6r6QStiH34i5i5nldl+kHWRIbk
 OlUsJUjbzdqC1MS+y9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

The format string expects "Gva = ... Gpa = ..." but we provide
these addresses swapped, causing confusing misaligned debug output.
Re-order by swapping back.

Fixes: 59432082cef ("whpx: add arm64 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 5e4c25bb7d5..e59580d54ee 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -442,8 +442,8 @@ int whpx_vcpu_run(CPUState *cpu)
                 error_report("WHPX: cached access to unmapped memory"
                 "Pc = 0x%llx Gva = 0x%llx Gpa = 0x%llx",
                 vcpu->exit_ctx.MemoryAccess.Header.Pc,
-                vcpu->exit_ctx.MemoryAccess.Gpa,
-                vcpu->exit_ctx.MemoryAccess.Gva);
+                vcpu->exit_ctx.MemoryAccess.Gva,
+                vcpu->exit_ctx.MemoryAccess.Gpa);
                 break;
             }
 
-- 
2.53.0

