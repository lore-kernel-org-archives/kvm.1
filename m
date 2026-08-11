Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D81383325
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473257; cv=none; b=eGmDawmypvAoP9on4B8w3UncVYOa6DVeYgT9gYTvsQi84B6vnNhamXBmjz0WelWjxPL4WN3XH03bcpl4usz0y9Q+e4rerqIayLVDV92XiPCXoi7rr/uFkyel20WlckkITS6mUeBmBja6DrVure1sNO/OmrqBfPpnA1T7OWrsTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473257; c=relaxed/simple;
	bh=KIwP7pxNSWbMM+9W2urGHN+ZQj2PEson3oU56OenJzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lrl/FKZ+U+WqsDBh9A467T+mAA4CtYR3AqHyUF7edRRmJXGWhArB8GKI+eN86Pq4Kvd892z/mMcIbK6vol1lG36Yv0RbAgcFK4NEcjmgq3gN2BnsJTnVQpUGSTmQfReFAFLPq4SKGmnSscvk7IFom/Jr6qkzCo751UT9jcDHOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHrm0Fxq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kk7tAVM+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHrm0Fxq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kk7tAVM+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGO5411169712
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U6nPqz+NgDGjy5XjtQPM0M
	8BR2zWCmNRHfhDxymV9N8=; b=nHrm0FxqIvYYdyKPIvXOiW5a6jVbfn4zjQHXO5
	oWjOHW9yJNLxKamQ2ZYGKps574GCFomXL9rqgMS56IGt3cmwMwd2+6M5l57uAyUp
	XelcxwwkFFFzv4VmAnKCBQ3D/vHWXsLlrUUpOD+7Itc2/fshCFo/QPHT+cwNRUEt
	KdyEclD1EQaQW9cKq2jSQMq4DDMQa2xH8QncYqNO1k4rJcNEafq3RCybb98ejlYd
	qpCBlBU3p1qe1JI0eQfCa5NNWmhSbo4rATpnsDe1AOTnpqP9bRkv/ZYsXAz93mSr
	E7RaKoADrp/5GWUOn98dPsFael98tSrm7BuLKJYPCM0DsEhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc23ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8b0a08d2so2169681cf.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473254; x=1787078054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6nPqz+NgDGjy5XjtQPM0M8BR2zWCmNRHfhDxymV9N8=;
        b=kk7tAVM+J/4y3xDXJTeqgoOs7NtakTFtAcrA1VWnBcnV1pihd8B5cRUrYnDcxxkCW0
         tMsz63YchyDVJdH2EnSq3WOx9bpPUK5aJJ00HWl+5/HnIkQ93BBzVkoOOMn0sg68zNan
         gbL2TaI59mKyPROkmchHkMoJi+c/K+HSWyKmyBPHof1NGZOEIu8NMqz99R1Qcl4th7xx
         wrhGDYBMcnEVCWa9Ql1GzrR/+D/rIo8wxDIHOSnK6LfayxZrCFE5bVt3QFd6VMmx91H5
         qdr6/CMSwobEMU9dzHNE7dsAjzFtUIaSVtEstv5oqB3pCWhNY12XOp+XX08/bObiA1Ff
         SXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473254; x=1787078054;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6nPqz+NgDGjy5XjtQPM0M8BR2zWCmNRHfhDxymV9N8=;
        b=JOQuwDHenX+PItZNGIXKEEbvLz/KhnsyywCedJZIMEJmHH6hDCosBQzKCEjted2Osl
         l+SUVfhcllkCwy9mroeyOCdiNVXbrO/beMo3LvvQV/M9J2QRlcmiottgdpc1KlHZ1gH3
         4eO8B1UDV3kJlkNyNoctrTN8L7ZUCC1fOWGIe9XjgUP40AfbX2iHFRFP5ohg0xA1Vaim
         uphxFuyyPfpCC7hNrm3s8lQFZXH2po2vwXtI6xDmbE3pdTJEXHvpz455rS2c2tKJezm+
         U232oerkZvkxDAFTAVtngZXrgofgLBY7t89Udsg9oh1Gu1qBe6bAZaz418AcZe3TePqX
         /WuA==
X-Forwarded-Encrypted: i=1; AHgh+RoK45Nb3yZWWZ6KcygOxWmZd7GpSZju24SlweGOv9ftAVLtzPS9jC0nnZDVr/9xMhkxNgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsjIInv6EN2Rd7pPkqrgtqg8fBJ579uvPTh12mW1o67xPm0XO
	F2ESyj5v1GzGs7cvnAylY+2So+C2RD1uDTAlMLC3orOiMDnYHqVwFFf+4y1wa3g6O1Zo8slLUIv
	1MWRCtk018z9yWeNZXexzalTbf4t0RV8iCTGtuO19/euggW/KG8E7Odg=
X-Gm-Gg: AR+sD13q9AT4OGpviZ8YTg3mkSFjATYB1AQ9s5vJzHTVUu3RAgJvnx8SGUxqcsvHcKC
	mEU1OTV5AYspbj2TFPqclHgtLfUsJCatClXTKh89qQtfxeCoRiw0kPoOa7s//x+oCCuZ5tM6XGG
	OGJtT9XciWE6loORy9JHElNRo188rRQKcvUP4yuEoJttI5c0V14TwhU1gpvT/bsQk3F3HjeogA3
	ZEnynziIDfFhf1h2Ulzj0AbTUGY7p6bo4D6rFdr8chKhd7ThqLHXGIkOTaZsdjrTD+vVkRz1J1Z
	l/yFehpZAleudxJ/nFO1kIdZJNqtp5tSrC6BLYGXKYqxRRHHXxXmsIbNssTdPhnL/GdjZbMPO6e
	eLxkGOQpb4R/Xoi45cE1EeScNzE3J4JWIvgB3TW/Jjg==
X-Received: by 2002:ac8:590a:0:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52d600f6953mr25081181cf.18.1786473253839;
        Tue, 11 Aug 2026 11:34:13 -0700 (PDT)
X-Received: by 2002:ac8:590a:0:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52d600f6953mr25080621cf.18.1786473253369;
        Tue, 11 Aug 2026 11:34:13 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aabab7asm10382785e9.6.2026.08.11.11.34.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 0/8] hw/cpu: Slightly sanitize CPU API
Date: Tue, 11 Aug 2026 20:34:02 +0200
Message-ID: <20260811183410.22428-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX71ZaEdQwdY8Z
 g4qnMHhfXZkz6AzZGnsi9MmxFDAqITKRlpnTZeGkTp/bhlhJKJwBLTGUsBPqra8XbnTPjRsBDIz
 zbtY6i6mE1vnjspEMN0gtIUT7vuETyM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX7k+nhK/Bp1EQ
 GW18NVuhEpquNPBJe9wh+VTzaxs2kkVS+4o6U21GB619hGUB0MJSh4GnfmHUtrLQE4rWkYRbGy4
 1Y+i6FZBS0dPPnPqZgDjFD5e0wH3KNu2YLppi/u3+vQP9C2oLeT97SKZ3OYAOoL6ofi5Wv/bjV2
 AGBOlc6YFJJf9zKiRCtHMO1r5/MrEXtPtPn+OlQ/zmjo2aO/QVsO/ho7myG38IuYqI0SI88W/X2
 Dl8yNlHwQqt1O6K7wi0Lfu+EFS0ODyhmRpqxQpzlqRbp/urYyEx6OVvl6RYRIEKe199d2Zh8vct
 prF7H3BzoQGOsRXSiX9/QLia6UxKJO2RtYcgX+0vkuTOqEyzyBMiRStq9vZLvN2q2+B+U3uGuO/
 cluJYhuEcPwZP9hftrwJcL/MmZSk4bYJ4uZ9w1gIYMz2TpGMYwCAIIylEGMRt/Wgpx2E479UP9q
 95Y2hRLTvPvfGOAjGzw==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b6b26 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=l5eZHeLn_C_0ZvgPWV8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 2UQiwa-VSotXx4FgfKjg2-aPRjzduMkd
X-Proofpoint-GUID: 2UQiwa-VSotXx4FgfKjg2-aPRjzduMkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

API cleanups, mostly removing system-specific code out of
cpu-common.c. Code churn renaming functions, in the hope
to make things a bit simpler to understand.

Small patch set extracted from a series clarifying CPU /
accel synchronization, itself a preliminary work to introduce
split acceleration, eventually.

Philippe Mathieu-Daudé (8):
  hw/cpu: Correct CPU_GET_CLASS() comment
  hw/cpu: Include missing 'qemu/accel.h' header
  hw/cpu: Move internal declarations to new 'cpu-internal.h' header
  hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
  hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
  hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
  hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
  hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c

 hw/core/cpu-internal.h     | 23 +++++++++++++++++++++++
 include/hw/core/cpu.h      | 15 ++++++---------
 hw/core/cpu-common.c       | 32 +++++++-------------------------
 hw/core/cpu-system.c       | 29 ++++++++++++++++++++++++++++-
 hw/core/cpu-user.c         |  8 +++++++-
 target/alpha/cpu.c         |  2 +-
 target/arm/cpu.c           |  2 +-
 target/avr/cpu.c           |  2 +-
 target/hexagon/cpu.c       |  2 +-
 target/hppa/cpu.c          |  2 +-
 target/i386/cpu.c          | 10 +++++-----
 target/i386/kvm/kvm-cpu.c  |  4 ++--
 target/loongarch/cpu.c     |  2 +-
 target/m68k/cpu.c          |  2 +-
 target/microblaze/cpu.c    |  2 +-
 target/mips/cpu.c          |  2 +-
 target/or1k/cpu.c          |  2 +-
 target/ppc/cpu_init.c      |  4 ++--
 target/riscv/cpu.c         |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/riscv/tcg/tcg-cpu.c |  2 +-
 target/rx/cpu.c            |  2 +-
 target/s390x/cpu.c         |  2 +-
 target/sh4/cpu.c           |  2 +-
 target/sparc/cpu.c         |  2 +-
 target/tricore/cpu.c       |  2 +-
 target/xtensa/cpu.c        |  2 +-
 27 files changed, 99 insertions(+), 64 deletions(-)
 create mode 100644 hw/core/cpu-internal.h

-- 
2.53.0

