Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F361391E4E
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473296; cv=none; b=J33taaHk4FTsxBSe8KvhArfexszxBvvH5gx0r9smWm571BsPP174C9zOEjdfd4uCwwKweKKPhXXhIS8kTP92YxU06ZNJoq1QLxomAuhhSBg+boDPXZRjYxkMCeNpIoAEW5Usu3oiZC6S/DyhxIty4wA3LNZqrQqWtkjv7siNsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473296; c=relaxed/simple;
	bh=Oj/Svxk7+7I3YDN+4/CTOiAa9UEyg6BPGtyszVeQFm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjnqOT+edSjs5mGYejSppD0mdRTfDc+er336O+lL6eGsZZeWSUrKHerPFqAa+JO1qliYiVjDYRjH6Dy40NJWqiV9d0FU0KnN1Mx5lPIpO9KzFMLiodzak00n9jxBIfwYhZAv0A1+ZFuSoIS/wBUbFM3pG9daukRTzJmvjUzSPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BAItJ/rk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N+B8hj5j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BAItJ/rk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+B8hj5j"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGObgD1094508
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=; b=BAItJ/rkJoC3tO2Z
	RQ4sLUo2IKcJ/WricJz/XlLXB6gHPJ5DmKBgt0/wstMbNYFg0scuUMpPc4Xee/hu
	oQFVBnHmoT3/EaUiB8LM8ir25GnS6DrbJBjAPFWmZ7Go3RdtiCGyG7I8GAKXi8Y0
	ZyNj/WaLcGZg+6Ogs90awsL5d2BStxuwK1rSJUGya9sqaiGfRjkz7fksbNMCseIF
	NRiqAovN+vHab9/YkAs11ZiEO13DO/o1FtKa/X2xGxHx2TrhH5rCSMt3zAGd5/0s
	vtPhvlndsNu24yzY5OHr44LgtaWh0Y1Yc5hOBSoEVVUI4tArz4O43x5pU15foEHM
	q5t8hA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gsj7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso3235721cf.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473291; x=1787078091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=;
        b=N+B8hj5jtTXxM1hmUmkrhnmXCsGFtt8I2+QeENZ7wjKFnIDfSfckxe8s2ETFH6CUtX
         736ms1pPDk4wjGGp3u6z1oi4z5WffZ+s+080+Xh2JTLLLTCeelk8wZKFwkXyPYYdrk3b
         VYiEggiod6HEMfufTazTjW/RjPUMNIRGVKk0ulhhbHtPm3eGszQTkaxVg2CzF+nJTzIJ
         EmJIq9ll5CQUKkH6ber99MtEQE96YU/2CZq3q1iDl5TXYdI+OeQGk9L2T76XQSWcHwjH
         LNthc7yy4/0wjEWac/nUF0+cbuVQyPAN6KqfzjnbGfx3w+dZA0Va0YkSS7LYrAoH7/lS
         LJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473291; x=1787078091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h3eobnHT1X8C7Hj3fqDLl59b1w5d8j9Pcc2IV1gHOo=;
        b=mv/wU8On6KDHv754X9A2E1BZN9u3z7yVoSeaiJBvt9SFi/ik7MJR/WLqx4ykfnVoax
         PAqSW0cavcbUb35hzpdIyQQlp27naeVxBf4A2YZV1fmO31LtgYXc6LAZsk77i0zNaP+r
         cgKwPymG0I+UqOboTIK/6hLlVsbVJuMglX0GsA77Yg0JNXkBoI2AwupLFB7A/V9H5kkL
         nxL5q8ZfXjy+76Lkte3MXKKHk8F3lAOjSEv0OYIN2eyKlFAHYfr0LaFaG9+iQrZ7b1bM
         q7FRp1fI22KlMz1hF3tA7nMYiyAscIAyxgF6pZf0vE6fS4N+xOtd4BYNqZDTEIvuxvU2
         2LBQ==
X-Forwarded-Encrypted: i=1; AHgh+RplfSQrF0N2t+oFBCSoTmhd23xsvY+HWIszZUCrh/cwWvjSiZYf4LNbcFvJFvr4MN985Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZE9eektQtmrF+VipeGhPCd7kZ4j9uDP2tcVYYVVzmCxOqtDSb
	xUwqm2cDbZtefSCPKCo3X6GY7cvP8DIdwMuU6jI+wDMeWn5uGudLlhS1qxxzhgRx3UjG/C8mPyU
	aRaL45NiOKqItKZtE8oDccwGEX0QpdozcA1SwefIcc9kiZ3nUcsrcD3A=
X-Gm-Gg: AR+sD10s80EsZqQXq1DFUJEaxd2q/lWdVYYL2j7KytTCGh5UNSx/LLsZElHklXbZCaL
	Iv8c9jtd8uA408SYVJjVaTTkDOuLOv4OL7WWL1yjnwrDpKd3+CqQSorDTc/6kijMbVMexPmsg8v
	3cb2AMglXKaL+ReuT4KfDvLC9v953iUPaMLWsidU0KsnN98kTgEPQUq+XfzxmuNEjFKMcgc7dh4
	wjHyaSu/Sh3faFb8/1hCR0wpDZJHoZh8mbnvYaaZnIE4cB8ADNbbO/3Shv6Tb9ZBwNjIt/gLrHd
	duz20WQszWmoeSk5dW4DTj9+JZzx+JmvkE4BBorojnpN6PMpLFixZ1DVL/Xcw8oSGlafEFaH8rX
	XV0AfNOoCcgTmxIyMPmWp5rz9MwFpWNmUC1/Io8FzbQ==
X-Received: by 2002:a05:622a:579a:b0:51c:ace:de6a with SMTP id d75a77b69052e-52d5852c5efmr57869931cf.18.1786473290430;
        Tue, 11 Aug 2026 11:34:50 -0700 (PDT)
X-Received: by 2002:a05:622a:579a:b0:51c:ace:de6a with SMTP id d75a77b69052e-52d5852c5efmr57869311cf.18.1786473289936;
        Tue, 11 Aug 2026 11:34:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150c08982sm346738f8f.14.2026.08.11.11.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 5/8] hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
Date: Tue, 11 Aug 2026 20:34:07 +0200
Message-ID: <20260811183410.22428-6-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXz6WcXY8mhTaN
 rrH210xqDZ1uMMXl6pzYdWUn6WTKk0AFhj57vpsPqHXDtf1StVF8DYxyF5si6px3kEsxSySVl/K
 kDzuSQKjkiYLGiDnJH8CGxVNp0CkIzc=
X-Proofpoint-ORIG-GUID: 1KX-AGTr1gGPoG3vkTKvbQluDoyhE-4A
X-Proofpoint-GUID: 1KX-AGTr1gGPoG3vkTKvbQluDoyhE-4A
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b6b4b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V_ZmIUVNQuF7PYEw5wMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX+dN/XNjXeahL
 eAswvTM1mqqOXIytDqGGtryFHiOtcfIHUrPXIQXm8MgkIVlixX8es3YRH4GtNFGvjiTPgICHEJ9
 NT4GTxpM1aq7eYFKi5sTEW/FoU3x8tRr1OW6ly3L6pSo0fx0+tuEwZkOQ8XckQR5xzG2P17V0OV
 kklAaYCOVOw+ELjQFbE6bUc/09EcoGOGwd1NsH1a8fOgx/x15rxnTQOwKWf03Jsb2xLGKU4ESmD
 VGN1/pRhg/7OaKagHhmLT7zrvEmhsqUg5/53aOlaYjYXbNjYm0XY6i8SiPeEXwpznKk5JwYVLvF
 4KwzlFZWFYtQUn7cQ6O4g4Xuwa/FgnvPrYWKoUG1UHV/uA6UE8xXCQt5zf1QuXtx60WCBQukjCR
 MkSZ9oVljukysDrFNKhAoY6pIw/352u3RtGCZHekY7uNMeKXydfO/D8afFfUA+qKtgnQA94PSrA
 Y5Jn9MdfBLHJD0acW/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h      |  3 ++-
 hw/core/cpu-common.c       |  2 +-
 target/alpha/cpu.c         |  2 +-
 target/arm/cpu.c           |  2 +-
 target/avr/cpu.c           |  2 +-
 target/hexagon/cpu.c       |  2 +-
 target/hppa/cpu.c          |  2 +-
 target/i386/cpu.c          | 10 +++++-----
 target/i386/kvm/kvm-cpu.c  |  2 +-
 target/loongarch/cpu.c     |  2 +-
 target/m68k/cpu.c          |  2 +-
 target/microblaze/cpu.c    |  2 +-
 target/mips/cpu.c          |  2 +-
 target/or1k/cpu.c          |  2 +-
 target/ppc/cpu_init.c      |  2 +-
 target/riscv/cpu.c         |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/riscv/tcg/tcg-cpu.c |  2 +-
 target/rx/cpu.c            |  2 +-
 target/s390x/cpu.c         |  2 +-
 target/sh4/cpu.c           |  2 +-
 target/sparc/cpu.c         |  2 +-
 target/tricore/cpu.c       |  2 +-
 target/xtensa/cpu.c        |  2 +-
 24 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6490fb070f2..7b7cf330cde 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,7 +1178,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
+/** cpu_common_realize: CPU DeviceRealize common handler */
+bool cpu_common_realize(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 33e349d4402..732e32fade2 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -230,7 +230,7 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
+bool cpu_common_realize(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 0c35067b202..12e86021663 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -117,7 +117,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 787e4dc7ab2..77aa78f00e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1891,7 +1891,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 35912192126..f8409f32ab9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -131,7 +131,7 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 12d27ce1381..8e3b900e8d9 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -450,7 +450,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index a68152f9682..07b49e51326 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -181,7 +181,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92..9b2aa178062 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10164,7 +10164,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * These may be set by the accel-specific code,
      * and the results are subsequently checked / assumed in this function.
      */
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
@@ -10179,7 +10179,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->guest_phys_bits == -1) {
         /*
          * If it was not set by the user, or by the accelerator via
-         * cpu_exec_realizefn, clear.
+         * cpu_common_realize, clear.
          */
         cpu->guest_phys_bits = 0;
     }
@@ -10188,7 +10188,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         /*
          * The default is the same as KVM's. Note that this check
          * needs to happen after the evenual setting of ucode_rev in
-         * accel-specific code in cpu_exec_realizefn.
+         * accel-specific code in cpu_common_realize.
          */
         if (IS_AMD_CPU(env)) {
             cpu->ucode_rev = 0x01000065;
@@ -10201,7 +10201,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * mwait extended info: needed for Core compatibility
      * We always wake on interrupt even if host does not have the capability.
      *
-     * requires the accel-specific code in cpu_exec_realizefn to
+     * requires the accel-specific code in cpu_common_realize to
      * have already acquired the CPUID data into cpu->mwait.
      */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -10230,7 +10230,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Note that this code assumes features expansion has already been done
      * (as it checks for CPUID_EXT2_LM), and also assumes that potential
      * phys_bits adjustments to match the host have been already done in
-     * accel-specific code in cpu_exec_realizefn.
+     * accel-specific code in cpu_common_realize.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
         if (cpu->phys_bits && cpu->phys_bits < 32) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index e164cef2036..da8d77ade06 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -57,7 +57,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *
      * x86_cpu_realizefn():
      *   x86_cpu_expand_features()
-     *   cpu_exec_realizefn():
+     *   cpu_common_realize():
      *      accel_cpu_common_realize()
      *        kvm_cpu_realizefn()
      *          host_cpu_realizefn()
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa8..cb07f15110f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -704,7 +704,7 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9ad3057d91c..ce2707dee5a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -389,7 +389,7 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_m68k_insns(&cpu->env);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a97c92a7b68..389a5124b12 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -251,7 +251,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     int i = 0;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d72044aef61..669c7d99bb7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -544,7 +544,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     mips_cp0_period_set(cpu);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index ea29b2e01fa..66c00c0930c 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -170,7 +170,7 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f404c7e549d..b07e9c3ff9c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6921,7 +6921,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..23b5023dd37 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1226,7 +1226,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 495cb42dc89..97069bf597a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2006,7 +2006,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool kvm_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c731..9e3cc87f8a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1304,7 +1304,7 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> tcg_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 20b188c24cd..9b8473d71cf 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -147,7 +147,7 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     RXCPUClass *rcc = RX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c074e12ba2d..641ea96c8ea 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -249,7 +249,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &err);
+    cpu_common_realize(cs, &err);
     if (err != NULL) {
         goto out;
     }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 763424695c6..ad2ec28c1b7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -250,7 +250,7 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 13ebb122a38..1bc14b586bb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -892,7 +892,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     /* Default NaN value: sign bit clear, all frac bits set */
     set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 472c24ae32d..96e2817dee7 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -99,7 +99,7 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUTriCoreState *env = &cpu->env;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2015a4e3d0d..7c25b9ab707 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -257,7 +257,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
-- 
2.53.0

