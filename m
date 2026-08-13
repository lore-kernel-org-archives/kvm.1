Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA352F4A05
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645036; cv=none; b=fbB93jLfzAkhM6jJp+v5nMhi5Cja7877dzpbkVCh6TkUfc/WncFKZsXUAdwA3zCwj4dt586/ytYhPCC6fVjaTvnIeLLqTJIWuG9r3rqmVBtPiKKDtccVeVAt4VXufkK94MvenGPD7ODzpBEQcGlcta+QnnIxYv6UvKc/nXwaya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645036; c=relaxed/simple;
	bh=0ANc+mjD76iTo8ZkDJLIJy8AQTGxeg4nskOHVfykLAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4nHBPDVtXMM9TWyMHvO0bKAyzd4oE9bDT3N+BQqAHMCVu52x2zYSWEMa2UcICtSbvicwaAfjPi1+B4ABtAi23dV/7s8soHAjjdEsRZUuBkojDhJxQCP5KEga4QWh2b8e2u/EVUpybPeCzFMv4gsK31SqHJk19M2lvd+USJ0R/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnUQhFoV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D0E9XWZS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnUQhFoV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D0E9XWZS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DGV0e92076866
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=; b=pnUQhFoVW11HG5T/
	+qFN91c4WEKaLfjB5+LNkNFCF6vStDtgEgoh0EU3j8U0k0yi/4Z4IvkaYUhYCGXW
	ctvpTjdYAFCIO7uL++oSHHC3Ms2k+iB+SVUXxpHjfwaiTk/YGQHl+O+n7/RgBdjJ
	iGuFiqRlwn3tn6OQ4GT2IFHt82wMNMM53ScXjA0pWA+5pZ3I4z3ou+UMCvYEDw8w
	HW0Z10PC4LMkzTrHQbs81l3Fj3/M4KW5TjPMmlmH7chIn56rASSlLo3E42fzyVng
	TW5Q9f59L59gb/2tD5s8enCOZ7eJfR7bqAQhoTt9s3FSGw5JLPd/TyJDR8DlSYxU
	dS/GNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy0f57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso20240261cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645033; x=1787249833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=;
        b=D0E9XWZSJIGNuA+ALGunk3CpljVFG+CPVH9ZJrfPa9rMK14iAS9Zj0QhzY5UbvCbvU
         /o3vzBDw8ymREo5uSbJk3hzyuz0fut2e/hZ9dU3lmQo4EgN4dFfnWmvSyRu/6c5MtsNg
         UQwxUlYqmo4iZYymZhuavjqUpb3Aao3SOLsA2XWDAUcQjPJHInRcKfAdi0KDoIIZPrnD
         0RCswiahmBTejkRiHYSpPSPq1kyx4ML/uwyn50iaT4EZv90uBx7O3EWOe5tXVLP7ZpeQ
         hd4p4GkpJeuzM6kYjS8lZ2qqPj9DJUXH3PoE/Z9bacxqx/1WurztjG+5RH7jlewUncDG
         V5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645033; x=1787249833;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KExF4MwbTUUQ/1tzwHuPXSMnN5BfvbjHcIrr3pOpFSs=;
        b=EQHYT3InZhiwBFb+9ByPpmA8J7qEpiL344SBMFqcyzoVkFF4YSflKo1fF/HsYp0M4+
         LTQWT2L2225j1ZBFRFy4ZYZERhwLeYP0xR+CUMhK5060rCN5FYQiXKrGaH+8mNMVBD9I
         V7gdHT3vU2/nZ5DeJnxRw9YtdLoDsh8LfJT6jjhEpOchelqs0/gz4WMCfLMxvuCwSgMb
         PZf+2z/F4Isiy7GvpXocGu9c8LFL8v58cLF6o8GHeJgnN14hy2qDl7gn3w09yxe0SbC5
         7HWd5Q8hHYSSTLpZ+MCfHidsJfqY5earh61tH+Zg/o48tzDin4yQMJk5UjeTBg645qWs
         CFWg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ6iVMcnqWENK9wczdOoQgA8wiGdErN6q+9F6/rofb/0P8q8GEDnwvgHuHOo5xXk4fV+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKV/wb6yHU+zJ8g0j/+bA9y59ESMPQQ3398kSLZ3MXDOZOMh/
	0WDsMAneJW9E7r2eHH068c9jLp9upBP/zqeNWH4cew5+EoQS2gu20ysWPJAaaqUBP9b05aJ2425
	klFUSn+Bb/nxqxsT/EspwLaT/Oj6AorgnQ+NmIl+vc8/EXKKcMv17VnA=
X-Gm-Gg: AR+sD10OY15tBJVDjYWqqerJhzr/+LgSlRp+zSzKwu4ZSYGJZI8BO/maw2bWAMFwB9k
	VGjvh9clW3ocYj0W7H+0iUj+m8eYPoonCdSIpJR9mmkxj6cx9kY1akztd1JGoNJi/H+iPpj8y8d
	xVydvqcn0mrbbP3UqhdKF7eH0kTj2rHmu5yElmVjtZOurRI+P6CbrVNnwKjhHxAywRooeC6pRnx
	kWz2XUhTcoxftPc2srQ6fmLR/fLKXX54e8wc3IdClrA+YB9l8Hgvm0AMSlhq8a6uYWdk/f9CPFz
	YyexLicdpvo3uGSeJb3g/DD6LKzhEDEsUVmz78OtHme3XSxJvxLtGjFWLUit3XbrWeTLFBgN8jg
	OWFHv9v19rj7LeNj09ZvnJ39Rh/0TGk0mrjk7pQv1zg==
X-Received: by 2002:a05:622a:1a81:b0:516:35fe:5524 with SMTP id d75a77b69052e-52d74a3546cmr70162081cf.5.1786645033365;
        Thu, 13 Aug 2026 11:17:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:516:35fe:5524 with SMTP id d75a77b69052e-52d74a3546cmr70161411cf.5.1786645032819;
        Thu, 13 Aug 2026 11:17:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499877d20fdsm5607615e9.1.2026.08.13.11.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:12 -0700 (PDT)
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
Subject: [PATCH 04/16] cpus: Rename qemu_cpu_stop() to qemu_cpu_ack_stop_request()
Date: Thu, 13 Aug 2026 20:16:27 +0200
Message-ID: <20260813181640.6537-5-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX5bITwXEgI7e/
 USqQKgKq8V72qchUN9bwAmYO350j07WBlw6spgMre40Fqkc/5cl0dkwIo2qdS7cNB+9SI+Dy+gA
 noIloOlIPzYICOFty0cqWwJomQeblbJbOXF5S14QGCQICbyNthKLvsS3mtWocDR43OI6IZWH5Vy
 Rz0E16dSxF121jou/PfmqGBq7bsClrTFTtOu/bAITiE/CIjPMV60GvJrZaM+VD9YmZyAAX++kSl
 sfmDZ3E6hHZ1jffPKj6F/Dmy6Je3E5EofHkBWBGoJ3pHX2JQgiq3xOUUidarEsVyrfqEUevQxm3
 0vwzLxRmYFB19fUShRIxHYwBWKnvw+q7KzWh0clBK4LNymISEnmixEd68ROT9+7zNaRk+OSMSDI
 Nidrc2FtlVDIiE2GlABoSww0KFRtNeGmvviZawwbT69AboDoKyjjhUg+mKKd8TV4mtUMwQva1E8
 DFxUP36MblZIdre6osQ==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e0a2a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=oALTtu6IgWlc6orpIWcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Pdkxo3FDyexeX44s7ugAdBgvsm2eUZKd
X-Proofpoint-GUID: Pdkxo3FDyexeX44s7ugAdBgvsm2eUZKd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX5e161lMKwQyR
 bt9FI/fFbhj57qQOqE5hN0jWQn6LlxHv+yZEAEYyPX1mC5p+HAwNavCXQq8S7OQx711IBzoNdf7
 ko5BFJvVkpajxw+AwuYdCrkmMTgOgLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Stopping a vCPU is not a simple state transition: an asynchronous
request (CPUState::stop flag) is acknowledged (CPUState::stopped
flag). Use a better name to clarify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/cpus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 1a6fd286a81..f69558c760c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -382,7 +382,8 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     do_run_on_cpu(cpu, func, data, &bql);
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+/* Must be called by the owning thread */
+static void qemu_cpu_ack_stop_request(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
@@ -397,7 +398,7 @@ void qemu_process_cpu_events_common(CPUState *cpu)
 {
     qatomic_set_mb(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_ack_stop_request(cpu, false);
     }
     process_queued_cpu_work(cpu);
 }
@@ -555,7 +556,7 @@ void cpu_thread_signal_destroyed(CPUState *cpu)
 void cpu_pause(CPUState *cpu)
 {
     if (qemu_cpu_is_self(cpu)) {
-        qemu_cpu_stop(cpu, true);
+        qemu_cpu_ack_stop_request(cpu, true);
     } else {
         cpu->stop = true;
         cpu_exit(cpu);
-- 
2.53.0

