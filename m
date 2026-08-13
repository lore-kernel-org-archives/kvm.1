Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D3319617
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645058; cv=none; b=P3gOeTQvxcWTeYyA7lMPlFDgGELZjNlqz1Vzdvvstuq5I+lGLO8nRnyz6qdRlw5w4pyB57RMOUXUdi5Tkuv2kHJlgwIzIDXGDLcICYnToGy0oHEDlq/xIgHm4LzVq++0AKcDuLetdcz/FZUxSQVjJWb9ijzFsC9D5E8SjtWrr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645058; c=relaxed/simple;
	bh=vB0fkJg5/a+8g7ROMfhjRBIJMeiFKvFPb0q07XD1n44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jd/9yc4/Ura7gpnoEC1Szwh2iVf9km9c+jR/Sci5splhgCDcSOguzwIgQjRst0Z7yJjEb2fdyZ6N7L8DM0lbx7csZPdKk/YfOO2aEmMsY69ngJhy12eayrkGlsMAxi4oEKiTDKvyCScX2QNOurViNG/8PT4COFrP8Vl9pIEyGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LO5+V9GJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b1gQRQG7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LO5+V9GJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b1gQRQG7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFU35m2375641
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sfQPhzstlT3wFstnUDQR+/OGDWmf4BOlIE5Yj0Rzf9I=; b=LO5+V9GJKwL/u3SB
	hiqHpTZea6BHhcnTuECZnXdPEBPwkMxXVqE66wlDc63j40rvFePmhDw9iKJPRbOn
	Z+eo324Sinad8WjGYvFfxTsM50BDrXkiW+hBndrbJVl/IAuVMzivZlWMbeSOAiEP
	53Cljg/2GsoWxzwBX/HDmJ0+ZSb5+Vb7HtNQUNSIdpN0sb2nj93KI7Lbq8C4wE8M
	s3uGYqWqx/g2v4i89w5JZmfWzwHW355aTfA7yGu/SM4ePQ42xf7I93MtUrLzuh4y
	GhJzU9JKIi/7e/HJSW47KAzi21N6pJLR6TKh0hG5MDWjccNAN++IJhEltP/U+st8
	HVm5+A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14sykxks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1a97644aso2645181cf.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645056; x=1787249856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sfQPhzstlT3wFstnUDQR+/OGDWmf4BOlIE5Yj0Rzf9I=;
        b=b1gQRQG7O8qyE4wUill18XQDyU5JfxVC2jMiWvYZ8P7vZD/RAuRMzDk18zBcums13i
         7tzgI9vTameVLEuOxdtP9EZ9FFS/0etsRw/WtvXOz2ml3AG1pg5MeXNitS6SlZjR++U3
         hhmO7j+4SyTwXIh/PjFIIvTVC8uG/UAMNl4K6x3fahjtJQ7KsrwQwzPBU9+5CIgN3yaY
         MNBo0kl7zD/vXwl3kZEjNAj19uHZSgJPpp6+qkGw67EqU8rjJf7kHSWOYA6wsn9/+s0r
         RDi7pz+4OTMZ/iOqYxw8URv5TApepBv7kKhIKQiaaIMCNBdMrCfZbT/Eg5qdsa23EENU
         PeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645056; x=1787249856;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfQPhzstlT3wFstnUDQR+/OGDWmf4BOlIE5Yj0Rzf9I=;
        b=XeNqa4G5kbbA+DceFkrjfMyoxBeGDvvSsKb7rZCL97JvYEsjUO0pdShzxj2RAGpScz
         GS2QV0emWzYjJebZ/+NRKfeQzrFscNtE4VnVnVoNnspx+5qAvJ+CypMiiImW1XB+W5ks
         91wnt/p+Ta25AYpLDB9Lm3Uc9SzAKTKQJsnlUaG+OBH0bYlTgj5PgFcOunagpEKWgEN6
         wGDMRNRQaniKsoLAYiLjvGXS8Y+umEp8KTuWRExn609xUQnV1SYkbLuVxYZIogp7bp9n
         T0nMxchfWiiHJLnWijbcnuGm0gYvUICRocb1X4wTyEeX+hMtWBbswFSWwISJVlzUgm6L
         1ZwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8v34IxdV8oBqDLumGOovYSrbF80u4NUjaXdOT6k9rA1SZaaTVuP2P1J0HpvvMbw2G0X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcokxZhZ43kX+JrPlF7xws17eNduCtoIveUzYCzaZshaTVbSJ
	Qm7PotdohZa+t/gfdb3W+k+E0VkXtsig1pe01hhpqxd8kYW4cvbHeawJabI928ffKxlxM5kUQIA
	EWO/rDwFKeWlQQ/R27ewNiVxgUQfkZRuDplQU1kw485QvJG+uIpmU5Mg=
X-Gm-Gg: AR+sD10bwJnkliriS6lKgLKv01mxFa6r2KouzsX78lrno0JMANo1GQsOrjfPicvrwDT
	IPyThJnr8J70RHbRh6mnBXJAvDdjcvsovr4RscIPx4qZ/ZMN2IKCl7+kRTT/c7/WgmTKm93ujY9
	cn3LdzwvRX47j87LL0il8ygglDGA2iQZcj7N6aQRmYib140O2T+dHFrqIRnxHpAT+2TXHFBSOgk
	bxXpNK9zQ+VZsvHTYlb2vKlvU8VsrbcMknqoUvgQVFy+DB7I1hWNKYk5jis6eitYM3z12Xg+fUf
	SGTe3EDbDBkMKfea8P7IinWELctloK9gqTI52Zh3XThRogMWrJslgACn1exxrlp488N89MyhUea
	HT5larEHA70YY87Owzcc5r3rh4da7N1Sa6NSdB3vg+A==
X-Received: by 2002:a05:622a:1a8a:b0:528:3471:937f with SMTP id d75a77b69052e-52d73d3724dmr92390261cf.29.1786645055498;
        Thu, 13 Aug 2026 11:17:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8a:b0:528:3471:937f with SMTP id d75a77b69052e-52d73d3724dmr92388851cf.29.1786645054663;
        Thu, 13 Aug 2026 11:17:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f4afsm97444205e9.5.2026.08.13.11.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:33 -0700 (PDT)
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
Subject: [PATCH 07/16] cpus: Document process_queued_cpu_work*() runs on current vCPU
Date: Thu, 13 Aug 2026 20:16:30 +0200
Message-ID: <20260813181640.6537-8-philmd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7e0a40 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=--_MrfCweEvJdlqdJWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX5tKPwuTtSo23
 qLD1p1x79GYApfR6kH24PPjQHtSrWZUlLREwDIvt85sLBCrhaHZ242YiOy9w8AYvJax7jit8c+h
 4wynFTYQpz0/Has1D9C0g15316DADP13pAicKtMhTpd87l9GDg3nkDL7nI+ycwFxTgXS0dmRpgE
 Y6lqNoEAAAnC5TYkPPhjxH211AqTQQgkRVamWRkmkIFSNHMwjlWHg8FKNCjoko4815hQHEK3Xi8
 Bb7cDbTD7Gdcg7GRr2RobHB8p+bUCst4/v9qu3vMM39YlETcFtfGo75tuKdL+R8U77kwL7VLc3c
 3YBCNnoKX6PIGxLzPz5krSzyDBxlA32at/28LauwweNtzSDCuVjAZvyYrxodHjm+hJUOJmYMOax
 jA858si2xD7Pr3uG/BzklbdvYcSSTcZWq9PRwRPKxRHriag53xrSbqPNr4D3b07xowxn8a9ziTq
 07Uicq+qZ8AkArAEXgQ==
X-Proofpoint-ORIG-GUID: YR4exeE-4N6mN-P3iMDq7eMzTYhuyE1s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9CxfGphU4E+7
 mLKrsIO2U/LSLFfgeWS5GKGm1tfYiH6079GFjmqYMF+6i7cXx8mLaZ6BOSEaLsrae0pGYbDi5rE
 24GJc9G62WcIojD159u5T4F/VQ7Vu/Y=
X-Proofpoint-GUID: YR4exeE-4N6mN-P3iMDq7eMzTYhuyE1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Mention process_queued_cpu_work*() functions must run on
a vCPU thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 4 ++++
 include/system/cpus.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7da81f3ee85..183ef9f4ef2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1081,6 +1081,8 @@ void free_queued_cpu_work(CPUState *cpu);
 /**
  * process_queued_cpu_work() - process all items on CPU work queue
  * @cpu: The CPU which work queue to process.
+ *
+ * Must be called from within the vCPU thread itself.
  */
 void process_queued_cpu_work(CPUState *cpu);
 
@@ -1179,6 +1181,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  *
  * Perform accelerator-independent work after the CPU has left
  * the inner execution loop.
+ *
+ * Must be called from within the vCPU thread itself.
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 2365c7c4597..0bdb231b996 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -17,6 +17,7 @@ bool cpu_work_list_empty(CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
 bool cpu_can_run(CPUState *cpu);
+/* Must be called from within the vCPU thread itself */
 void qemu_process_cpu_events_common(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
-- 
2.53.0

