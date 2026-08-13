Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F93546DF
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645087; cv=none; b=rSfxnRKwyBm2x1LiFH55gENTUjZmnhk9sYkDCEfNNpc5VrsEMHLHutMfGUw0BqJzeDA8n4KZKTvM5r5aJiI+Z5yDxy7E7NDWy6e1IdWbjCzvnsk3QHFF3juW3yLPEjIposaHZT55Y0Ipm0zTuVlYzGRGaWPPW+8QxrFGBkITkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645087; c=relaxed/simple;
	bh=5WJWd8IkgK1fVfF6PYYsauzy4/+HhxmWv/I+tP2h0Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yfm0J4XFSsBNQwgM5im7cimNH0ZyYQ2XQcHtZ0/l6OAsHiEalQr4y1DNa6Ydnmhl615QemtyoZixpsYFJws22NBCGBO7oN1Bn/11Bah9Sp2gK/eaHwr8C5S4loBx7dinh6dEICK3vTVO0srPPRFxRvp0hknQUSudAwECz0YSBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c97tR2dd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d2GXTiFw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c97tR2dd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d2GXTiFw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DH8fPc304600
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=; b=c97tR2ddpDb5+1FW
	RxPrsNF3AsjCNIfxMfYWE2Pwq/0+hiX/05ArbaOF1Ahk8675cJspq3vwy04hO+Tp
	sHYj6jnHEzSGfZLJWwk52EImY6corNunFtH5s33gbvkXovncmGLdHbTzozMLWWKE
	EJAUGzWAEBOI158QPMv9xejpkJPxVWN8ny/4w5jm4FQ726rVkWwGV8p1A9NVmqi/
	Lo8RyntVD8836HcC0Sc7teFsit88wsju9TR+3Iz/sMfJgwBTsr7/7pi6+TydxoXk
	2GB5DXcRgVPXvzB7ch18uRhGcNn/0Qg/eVMCRHr0N/fRTQSVlwYiXIxL2U/kRky7
	QdN9gg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2ng9x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0408254aso20255701cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645084; x=1787249884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=;
        b=d2GXTiFwarOnpghMuDyg9Cwcu4/11CSJ2DUJIVo3Kpyp7hvrfbbC1uh1LMb53X0kFw
         ZIw+2f4uo3s9RY6AZmAp3Dh/KTrkms5J6M6svKQ9/MI48lNZZBZHOt2KfGLwX487X8Pw
         L37KuTwqggIdfYv/WuQypBikY/cjdNrm1vPW6wIPTe/bR7rRnc/+9yhX4FnRPjI865wq
         ORHdjxWHQfFJA3KxeB4Ba2azLnP+84+mx7g3dguzJvW0gHfa9KvSUWrEJU85sNYDESAt
         YPY65ZGWRufnwgpq2ROKX4nZbeekwfnpC+W1c1lgUybn9D/QsHVq8PdIeHYCFAl/A2bO
         Kuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645084; x=1787249884;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=;
        b=T+tx3T/dEN2O99usq0EJw/ZfQrNMJ2mcb88GQTEB6BN47o/RU1+i0aceQxFGL7Wjrs
         UEdzIgIJRKpjpbpbESTN9ue91HLbqfVLpqDk/ixS170KxndAsgs+hx3U2ZoEgDJcNOPC
         DeCaNIZ2SkYC6xYZoupNBRYp62+xFa8QnORMSUPemZbe3gB1WXLfFw3owA/icAAeqxXy
         P7hje9NJRsb/tW9lcXWw3MjFywr28QVr5Ej4SLaSEohqNAi/BBYfThY0yrn4rk1nTw1c
         J0ScT4Q5hk7wz5bRCJ4JtIjeR58r3hRCFrZXJwwNx6oYkaEa9HlX5AHXVJFAMZ2vdAZE
         gJEA==
X-Forwarded-Encrypted: i=1; AHgh+RoutGk3s0pfyvnrVjg3MdNHh7DKKpIQluJK8ax/bRzRF1B+yU8MHUQkE7uTpH0h2Mgiwrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa1EuLAVY3DSGt1yhyAZsnnhzNduSxT1ZlWUiViL4wbNW/LC5
	xVCWeSoBc3vBdbKWQcPhMRj3RIJEF2pNwhVFkN12ZRWoHoXnhut3h2GMUyMhKDQ7KcgvtcUo6+N
	kmgI44gwhH1r1+cJ0AIEVcpSr1U39TJ8dz9C9SK15kd8X+5M2W56jkK4=
X-Gm-Gg: AR+sD11IYPCXV7pAhgZaMk6vvj1JHLyKfOsb7MLPLTFsln09tTQ80RwFR4Qgf1qbtu6
	JknAtWMACoLts5I+kWwDC/6plZ8nXp4HXoZxKMved/9Bk0YfMSYxUsxTnsHpYydcChTmDc7/bLm
	RjKQ94gcjwEEfx0SvgQsKd1fqPjjgJigjUSEINLeC8mcGyLNajLzjByo9bQWKHAJF0V0u4hXDvI
	1dXH6TQN8YcGFBm1m2daxIAEtMjqa8xvzWrdlNMTuoWqwI/9gzruuYdDrcCgMcz+jhPOqRzli4Z
	c19gD+56yZa+n9jViaJLdBk/0MB3XxEXuiCa9WuENnSzgJEWUrWk+iEqFRH8J3+oCRzJlZfzfzY
	P5kt6ZWQ7vlrvUfSHz/heV1732OMpADMgPmI8VBNuXA==
X-Received: by 2002:ac8:594d:0:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52d74ba523bmr65865071cf.21.1786645084276;
        Thu, 13 Aug 2026 11:18:04 -0700 (PDT)
X-Received: by 2002:ac8:594d:0:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52d74ba523bmr65864691cf.21.1786645083884;
        Thu, 13 Aug 2026 11:18:03 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm1099831f8f.24.2026.08.13.11.18.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:03 -0700 (PDT)
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
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from process_async_events
Date: Thu, 13 Aug 2026 20:16:34 +0200
Message-ID: <20260813181640.6537-12-philmd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7e0a5d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GGjvRDhnLmMstqdV9EAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Owr0QcqkGrecufOgRWUFz7uj_97zlCoH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9EMm2yYg4FnL
 puiVghlVj8/hDy7FwAB0zEOB7ASVxNu+AoSNdt1rmZt7n5iluM2Fz/A7nuJtuqfjlWkdRi9yWON
 8JNMcd4hGQC5BXe9OJf1CvAKsxuLAwA=
X-Proofpoint-GUID: Owr0QcqkGrecufOgRWUFz7uj_97zlCoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX7fDk7AkeZxRh
 TBtwx4vzeM+4Ae/Wlk6/ynNYvUBykP50ZsKVtZ4KVq0djkop7u9Qglm9deXD1yvgrZOsqlKA19t
 InxVkGR+q6boeG5AGtalM3g4sEZY1g0moHAVzinJm6VYRZ0ruqCSSC380+VWvVrbWeAn4Q97KpX
 XdjOaA59Dobl9IN3Ty94H+RrhLgF/s790y0MeftEQbkRBiSMaZlmJRkESKZQgMhmE7fHKwH2GM+
 xn3H4gQUrbYFjHVduYV9JgzNOGYsuFMPdWkwXghRH6b8I0tG2ZRTBYlljzxxvDePjS4zjvJ8bSd
 3DQNHhTu1ZuNG3QEj/AOHG8bP9nrx5Z+OBwH4g0KyK6GWrcD8Ph56PuG/JGlXmb+x8y4WDaV2Pm
 aT1vlmhL1f9dZAKOvyZMDmd0TW/WIAKJO8pP0Z0N6MZU+8Y4w0g50XkbhHR8lc8dajmREVmF7ws
 NpwZAhzpUpiX/XYWI0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

When comparing the KVM implementations, RISCV and ARM differ
from S390x / PPC and LoongArch. The caller expects a non-zero
value to return pausing execution with the EXCP_HLT exception:

  3427 int kvm_cpu_exec(CPUState *cpu)
  3428 {
  ...
  3434     if (kvm_arch_process_async_events(cpu)) {
  3435         return EXCP_HLT;
  3436     }
  3437
  3438     bql_unlock();
  3439     cpu_exec_start(cpu);
  3440
  3441     /* Inner vCPU loop */
  3442     do {
  ...

Change ARM and RISC-V to return cs->halted for consistent behavior.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/kvm.c           | 2 +-
 target/riscv/kvm/kvm-cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a98591..5caabfab63f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1575,7 +1575,7 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return 0;
+    return cs->halted;
 }
 
 /**
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 97069bf597a..1a61cd5ef37 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1568,7 +1568,7 @@ int kvm_arch_irqchip_create(KVMState *s)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return 0;
+    return cs->halted;
 }
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-- 
2.53.0

