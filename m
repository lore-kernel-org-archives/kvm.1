Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69713515DC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645044; cv=none; b=LKzapOvvwkRgZzAFT0wiutClGfsCbmQyav2b41Y82RjemhO72YC3ecNH/p0oeR3AE/lyhwndGIPClk152m8dRWeK+5dNmDRLGN2vt00j6A0T8rwcn9cUq167zW8W5CJwETlwE4ZtpD8XBZp2AQJyGo4GUGvVK6Q37z7h1NT5tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645044; c=relaxed/simple;
	bh=tTf+6+TV7IIf7/r4tPrxXt0eTCeBzd0wsLSUXmupP90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpe3xGXE4Z6eBLiBBn2GDyp5hIMzqFuWYOBNr7PICGqM3SwKBrvySQ2qQc4DDh/988IVyLYXmDybYyFDRi3Uq9BgCxsgdwM5cD+3bu477AJcIpRx/IRmQKXyUx3xd9Qj2kVxB9kF50YTuEFy37y1Q9wVDXh+PNUBWOM6wNLqJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WI1UgVgg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j0bus3n/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WI1UgVgg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0bus3n/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTbja3706099
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=; b=WI1UgVggeB3fo8UY
	OksCgZXZKBBXCdAFPg+/lf2DY/8samU/TVsE26g52tngSb5+7ZscGo+eHrwLLxtJ
	zkefDwJCn4cQjALIW1QYwMS0/5sMoGpuOaJkuKl4QR2cqYUI3KAvaDHS3Ch5h6e4
	GSQzrVoYcxzSH+xnokvAjjwDqK6HDTTm+hnhCQt0Z8fyv44xRd8/3MnebzUW/4cx
	4bAqk87QQWbJUUjZLea1NhxpFzVRKRkrx2rEU5H73gQKC/khXqBWgOiCO05EmlqM
	l/kF+E9QgdlWmYvfOrd0FOGZ3bB6QxvrI3uno8criy6uKS3eCmrAySarwHx+juxB
	h4jy5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18c5k6f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52769fc3f2eso2910991cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645041; x=1787249841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=;
        b=j0bus3n/pspq6quXRazjynZUnks7R5xKEPxBa7b75DKT2GwJlvfoncJL5BRpf1IrXE
         VunpL0987EnBmLhCSPJQZOSrXl6g3YV6hZoLgGeKg2aT0X7zdMzVLrVNxzquCmwdn6tN
         rnCKkBSRSKPOcQbpnK55gKeo3Y9JGiPfTA+AMPvRTSOGfChmOA1hkA0LKpZGpoe1UNXG
         1cDvxlAs4TSW8Q6UzztZI3Au394Y7muYwNUPnTDCloZ0aHJBqUZ+ioRTvlWfvqHgqjVz
         3OfM5caQz1fUvEXTca9vECrhyUMPwQ5RWFO14bLxVjZ0/WP8ixJsimukSbDespU+w2x8
         1OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645041; x=1787249841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBblWYEu3w/qqK9BTavVOzUlUmt3HTlRxSdIPsShG/4=;
        b=hvKBusfx0w2KHzAt3qvBE8RAK7fS60wqg7RWdma6iB0ooGQ8/90wwRsof5KgRCYn1c
         tscGCTbroKmloIq+yL0agJ9JpDysXMsrPMcYHglwMvALC3T9e4XQ3fduybRJtwxdDiCi
         3NzqClu6C96vQG4LGPY05swnICADgXl8ss0SFe01M7n+irbyAl1AYfn//zsjlRD662n/
         uCixtLClBZDSpeu5R7dR5MfHuyxPPhq2HvCBgEPnJJ+O9dNxIlO15jCWerD2F4aicWAU
         n1c00ZWyJazYFzbP4b8gcYTGJ151TZYKTbhGVhOavwg7KJMdEF6Y5fOs/YOVGScHNKZv
         9RVg==
X-Forwarded-Encrypted: i=1; AHgh+RqhC/Dfv+Kp7ugfNcLd1SRINVq1RV8rrGhf/XReJlrtbvSJH2kSEAS33ynz0E9tQOrU0sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmDQOg3iU+Ykzf7XSOE06IqdnT5gMl137xVp/Smqtv7zmrsrm
	hJ+yje2hsar9RDmzG05kVr38rf1EJa60Utp4GDAd49eq5NzzTcEUy4bDLXW4fYBQH95yWEuPMpS
	psAT1BhjOzoP1UUtebyBEwCLVdvPv6PmN7w0E4lFLLuYluzu+khzJ2mY=
X-Gm-Gg: AR+sD117wCf0kuk7zmG9CE9w1WgRGHuvkhj+hUm9z2HEySK2UiR0DIwviT/CnuhM/2u
	qpcD82M2w2vhmWogdDTHNsyD5x+4Thb0o4fu9m3SvPcvUZrpHjXn7kcKAZyD9P+sWTs44ahf23a
	KyGLK+LcWoIZMVZGBYGXw5BW8Zhxs4ZRv+hievMLvlqHTWB8hiyhYxqTlREXcrEMKJ1NNQINOLR
	7Fw6y13d0ITfnG1BVLCxRSTl57u9yf5QM0TlPLAoayIDTtsBwjh9uYKeMe4k7Njscu/iKpKRY4s
	OyK5a8zZAcunONcQb3i+1KX6+oGt3ZZwgAE7cl3pmkrcXraluiU4XjGOpCwrFbIkDhjCnuYJ7TM
	USJZ2/u3sBu62EUoa0Om2Bh6pXHPADNVZ+lK+Kcjjig==
X-Received: by 2002:a05:622a:1a82:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52d73c107c8mr83566041cf.12.1786645040737;
        Thu, 13 Aug 2026 11:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1a82:b0:51a:bec0:1040 with SMTP id d75a77b69052e-52d73c107c8mr83565161cf.12.1786645039982;
        Thu, 13 Aug 2026 11:17:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49982165351sm77726135e9.10.2026.08.13.11.17.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:19 -0700 (PDT)
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
Subject: [PATCH 05/16] cpus: Improve cpu_pause() docstring
Date: Thu, 13 Aug 2026 20:16:28 +0200
Message-ID: <20260813181640.6537-6-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/z6u8ISWJXIm
 TbpOE7N4IQi9LL1/8Az73wbdD2m72WhmdHFHNe54SJGOnUoI4EPtca3/tGkJ0ikNDEyTc3UIE9X
 +HTS7cQXO1n4zG/rqcCtJA3wpAazEz4=
X-Proofpoint-GUID: VVMSLYTS2VxWDClBQiiFWfaRKQ2sOAEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/Vx7trWZLxjH
 lcS+ykStKX6rD9CBakcW+MUsOKhwrgBsVcoOzgNlDSDNLPHq/9Y5z8W7081fzEIK6Ut+rq8jcwk
 DvM1FDaInLgeW8Jtzlge6ZCwI23WaoyytZckP6HlOxe1aRNcI44VeNiT9mLVyLuYCV0BwHqa1sm
 qSN2Ny5WdLvxzBUpmV4yPhFWqjE1orvfmRbF7n29IxZu6jdYGT0Zf4m8gICdNlNjoL/s27ZL/8P
 tUeymiH80zndREcpquboakH1n0KGt6ARkXgDoGjZflDTuZVAo9lEwzzqbn3asOggl756XHy9PsA
 EbzVxAxHqiPhhxzuE2S/tqIOThq9rPCULXwAxZ9+slWQF37jMSNULRiGOaEj+cT+iQqw01U6gP4
 4U957cHpioqS1YGYtIiFov7A8m3LLSsdoEAn4WxUzoYCOUg5RPZCjrbigfV0tBjotL82GTghNon
 kqiec4QFCezi+31qZRQ==
X-Proofpoint-ORIG-GUID: VVMSLYTS2VxWDClBQiiFWfaRKQ2sOAEp
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a7e0a31 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TUGipdnbivDJOOLMS8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130132

Mention cpu_pause() might not be immediately fullfilled: when the
requested vCPU is not the current one, the request is asynchroneous.

Mention the method goes in pair with cpu_resume().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 81af7b9ee1a..f1ac492714e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1045,10 +1045,13 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
 void cpu_exit(CPUState *cpu);
 
 /**
- * cpu_pause:
+ * cpu_pause - Request the CPU to pause execution
  * @cpu: The CPU to pause.
  *
- * Pauses CPU, i.e. puts CPU into stopped state.
+ * If @cpu is the current thread, immediately pause its execution;
+ * otherwise asynchronously request it to pause.
+ *
+ * Note: Use cpu_resume() to restart execution.
  */
 void cpu_pause(CPUState *cpu);
 
-- 
2.53.0

