Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8A400994
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645014; cv=none; b=UYMyN6Cidy9T1trOo7FLMfcPl/EIjsxR98KY4Ev5575Ym1byY404oJa/SmFpa7bVnsjTNw/IBGTPH0J4rkq5YawbS0Aypt7b7FxuyLHvykE2a0/W4UMeBR4C67qOw/SFl94faD0enbY2swI1X/bddOBCLCO6jDKJpVlVrPssMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645014; c=relaxed/simple;
	bh=syNKVzNrlp1y/rj0gbIZ+wX9cDcFluSDxUvLLsD/Ba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFouWiH6AbJkl59Ce7BngXkmlaMzTc2ZFsq2wW0t31bucCDxh+ayzW3Cswv3PLlwAhsN4Q9/NWi5j4Q7pOClTItuZQkWiwCP5hUANflgFznpZoK9sd0QyVSRYvOU93gbAROF/bEv+IhtVjINzsA3lOO3rYlupoCZXtBkQqYYrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANdea7Q7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEEKzifo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANdea7Q7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEEKzifo"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTjKq3049629
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	If9D7G1AX8bwDN7nlcPuG21QsgSh5nNyafUcgJBgDj8=; b=ANdea7Q7Zh4mt7eL
	3lMOeJuXOtA0ua3yxADRhT+amAjuVzB+khJGoST9pX7AFfQ7M0PPl6hD02KLNinM
	9EyKPhB7tCguxnHp+tGwaoKbnQpikt0jZhsY4T5xCCI7Zs72xA7iqGgB3qB369cs
	567L17gyoMj+8NX5/TE6oCIYN8At0e57BpvKm0Nil4pw204xFvcuP+Z8xVfVVIOY
	iVRIPsR2BmeD4yxczdVaIIVsbBsqIDiYYoKPBpcdqpyPHgKK/UCyswVTRZ36NCpx
	ibSxr8D6W0/M7O/SBqcuqmYH2lyctnSOmr4wyfm3Lr8IBnKfnENwMc2z1a4NPwd0
	0oHmeA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1fg3s6kb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07f25de2so1979701cf.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645011; x=1787249811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=If9D7G1AX8bwDN7nlcPuG21QsgSh5nNyafUcgJBgDj8=;
        b=IEEKzifoD13dB9p5Qj4XmNRkKNCWssN9iRSMjHGFDlfTUg/Nb32bbfjAjhnJnJa3Mq
         xR9b39XSpdn3BkZHC42/FlG4d3Bq2o5P5t7alVxVEmy7rzNfYJHvRFNscjtKC21pUFp8
         gKiQH1RRO+AQ5a8kV40a75blK4BfcB6nXZL2Wo5mI6cU20h/qdXrvj33yOB9/O81l6Gg
         fAAh7HHf3S6shpDg8CLRN2ME18JvI5Tqeh2B9JIIvi5sKIIYCLUJ851/mI5oVzacuT6Y
         fttF3ubdPOSRwzrIc401J9Zp6F6/S3EgyvysRo+w8yJA85JC0Xt1wNimJqQ3AVleZJyj
         7gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645011; x=1787249811;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=If9D7G1AX8bwDN7nlcPuG21QsgSh5nNyafUcgJBgDj8=;
        b=hFSQEsfisAGchJpMruyKXTZJVz4q4OytuBN5wfGPc8+kbtV00/w+k8o3jZhHuglQ2g
         LLlqHOtnRERCiCzT/f6x/rcdiM7HE62D0A6RYent8eNGhZg3zuoT5IY0wS0w+Q6F6Ke/
         s7RZ1rwyJjl+17PriSZlqn84NdrZ+aQI05h9VyPNYhxYsB4L5wL+r1uQOVpM+JmtKr7S
         fyX5HOS9z3mX/NNJA+i0i+Uo67S0SCjpxxFzkvpJgdRm70vqIVNXJeHy5EpFwmDmOytF
         ACKvQNtnD8x0kBZS/TzWvWa76bV/FmzlPhpyArkOhA58c4FWLtaUqcBq+ScFs9CqTUMV
         viZw==
X-Forwarded-Encrypted: i=1; AHgh+RpD2SdGlo9QAo988T/zVG0v4WJNQ9vop10Lec7YQxeuB7SugvYHLY2bNC93qHHhvELjp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXPq1eRQSa8beYqIoR4naH+FmuYi5yWViZkZfLI6PXgUvTvht
	KT7P9kMG77eET3R2w47SONB3uUyoPpt4yzUJwN+uX1vy3Y6UFqueN21+lvWotlrpgoFJDGJuOs+
	f7UZixkuCaLYfNHnSWWl+weGM3hdasIKSIGN1uCD7IkM+NoQEuL2cVhM=
X-Gm-Gg: AR+sD12cWWXnGIdpa2i4/uuVp+l08g3f5yAXJwkhNFsuvH0OoZN+Bm7mBVYPI9Cu0XS
	DGgkQo3N3PWgpXQThUt+YJDRQxhEzKZIfyzjDEVfinbgCXFEpdOg/trE+XbMynwbwPUQ4qhA/iS
	Xh1ew4GnUAGrsVTv5VPSuD3xj27Es9ihg6mE3PIaYh50l/FHGnPT0pNU1qITyuf/hW+0BGBZuip
	HvgcImTAlVtgsXAhgawvCIqmg5RhSLaL98xTLpketlYGNDbg1yre9m6s8LL0Z37f+8ZhkKYIFRV
	9K6pVfFVkhnpTOCOPvCclQxcBIkU5bKPTn4PAjzwTYzxaLIVQPI+6rCB8SeMCS9ImoDybG56ARt
	otxhTPs1hC14UdDTAy75HmoJ2w7rB9fweavK13j5EAQ==
X-Received: by 2002:a05:622a:e0c1:20b0:52d:771a:231f with SMTP id d75a77b69052e-52d771a25e6mr48080631cf.12.1786645011140;
        Thu, 13 Aug 2026 11:16:51 -0700 (PDT)
X-Received: by 2002:a05:622a:e0c1:20b0:52d:771a:231f with SMTP id d75a77b69052e-52d771a25e6mr48079961cf.12.1786645010616;
        Thu, 13 Aug 2026 11:16:50 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm1038781f8f.26.2026.08.13.11.16.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:16:49 -0700 (PDT)
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
        Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH 01/16] accel: Label outer / inner vCPU execution loops
Date: Thu, 13 Aug 2026 20:16:24 +0200
Message-ID: <20260813181640.6537-2-philmd@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NsfhtcdJ c=1 sm=1 tr=0 ts=6a7e0a13 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IxD3LLwSwie1VK6kbxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXyql4zzwwvZ1o
 TfIfFyHo2qdROuUezZqAOxwHN01OXTnHYv89K5EByPGCRvvG7WfNamVFPKq1ASvZgmKjW51u2g3
 S+GWqwpugXtPgvAnsgJZfD1KLadUgK2CuKi6NuBZv7ReDoEiycnmEl02ArTXGcEsfePzHBnQTjz
 d2urazyGZtXKGqYpzNQmyfs5u7YU273TKW/K+9cmkj2cMpSxDOGgqanTzNCK5ONTYnewriAKPMP
 tQbC8dqOZpk+KDLvG/ex1mhSxhsBAHv/b9iCD5+tdB7GZZVyGzAEcFSyPjCsqHTl7Z950IDjyxa
 o6jwwuhln5P52L0iFm+fQxxNeFQh6VUQppfw3OonfGx3Cc7k2MbFgPKZ6CETkI7XgyVIMw/tPHX
 zE46Vlkur21el/edLW9NjTNqXKcA6CAiFbVQ961DIl6bYYezr4qp6o29TRarCtsl/muOe2SdNhz
 yl+XQkY119XPItxDoVg==
X-Proofpoint-ORIG-GUID: 8cuSrYiFCRbUxqNTbRa2tvXIz23FYCub
X-Proofpoint-GUID: 8cuSrYiFCRbUxqNTbRa2tvXIz23FYCub
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX1nW0V7chG+CY
 zspyIsAN2GcnuxUDjzbWvjc2pjeg2gG25d3VNFglCWCoNsv+kQESvOlEq56KPgVM2SVxhrD2RFU
 BuFmsCD0KTh6E3LhjwnsJsdhutPUJpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130132

Distinguish between the 2 levels of vCPU execution loops:

 - "Outer vCPU loop" handles CPU events in vCPU thread
 - "Inner vCPU loop" handles actual vCPU execution

This helps following the same pattern between all our accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/dummy-cpus.c                | 1 +
 accel/hvf/hvf-accel-ops.c         | 1 +
 accel/kvm/kvm-accel-ops.c         | 1 +
 accel/kvm/kvm-all.c               | 1 +
 accel/mshv/mshv-all.c             | 2 ++
 accel/tcg/tcg-accel-ops-mttcg.c   | 1 +
 accel/whpx/whpx-accel-ops.c       | 1 +
 target/arm/hvf/hvf.c              | 1 +
 target/arm/whpx/whpx-all.c        | 6 +++---
 target/i386/hvf/hvf.c             | 1 +
 target/i386/nvmm/nvmm-accel-ops.c | 1 +
 target/i386/whpx/whpx-all.c       | 1 +
 12 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 5752f6302c8..f9a8d5fff07 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -42,6 +42,7 @@ static void *dummy_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
         bql_unlock();
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d2276d8513e..d8fc7be707f 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -172,6 +172,7 @@ static void *hvf_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c8e7aa38709..73ff93aab67 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -47,6 +47,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a84..b74c7f96866 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3438,6 +3438,7 @@ int kvm_cpu_exec(CPUState *cpu)
     bql_unlock();
     cpu_exec_start(cpu);
 
+    /* Inner vCPU loop */
     do {
         MemTxAttrs attrs;
 
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 72721d0f0de..af172a8ee34 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -616,6 +616,7 @@ static int mshv_cpu_exec(CPUState *cpu)
     bql_unlock();
     cpu_exec_start(cpu);
 
+    /* Inner vCPU loop */
     do {
         if (cpu->vcpu_dirty) {
             ret = mshv_arch_store_vcpu_state(cpu);
@@ -705,6 +706,7 @@ static void *mshv_vcpu_thread(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 69560fdb9d8..e33e35dab3d 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -86,6 +86,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
 
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index ca5a119521a..535667061b3 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -42,6 +42,7 @@ static void *whpx_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index da3ec521fc7..3eeb9f70de4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2600,6 +2600,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
 
     flush_cpu_state(cpu);
 
+    /* Inner vCPU loop */
     do {
         if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 00a5de8cdc1..5e4c25bb7d5 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -407,9 +407,9 @@ int whpx_vcpu_run(CPUState *cpu)
     }
 
     bql_unlock();
-
-
     cpu_exec_start(cpu);
+
+    /* Inner vCPU loop */
     do {
         bool advance_pc = false;
         if (cpu->vcpu_dirty) {
@@ -495,8 +495,8 @@ int whpx_vcpu_run(CPUState *cpu)
     } while (!ret);
 
     cpu_exec_end(cpu);
-
     bql_lock();
+
     current_cpu = cpu;
 
     if (--whpx->running_cpus == 0) {
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 150598418e2..0ffa3658dc5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1009,6 +1009,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
+    /* Inner vCPU loop */
     do {
         if (cpu->vcpu_dirty) {
             hvf_arch_put_registers(cpu);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index dd5d5428b1c..da28fbe3de8 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -41,6 +41,7 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
+    /* Outer vCPU loop */
     do {
         qemu_process_cpu_events(cpu);
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d5428219..b4f499905a7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2251,6 +2251,7 @@ int whpx_vcpu_run(CPUState *cpu)
         cpu_exec_start(cpu);
     }
 
+    /* Inner vCPU loop */
     do {
         if (cpu->vcpu_dirty) {
             whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
-- 
2.53.0

