Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CFC3FFAC0
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645007; cv=none; b=agomdqRbrtbvVWRmoItWyCTFEKzHXytOErmX35LVNYi/qMWnhPABanR3UpbGSF28xVUUcLVygvMAlPvBIU5OkG5gurvbU6X1Wi+WXybJavXQvtVH7NPmmkcbFsKQZRKhiu12RK3FA0g04RtN2h0QFFXKkxW4E7CMx5lpwJLgs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645007; c=relaxed/simple;
	bh=LyMCcp0iNVotA6Fwq4VdJNgmae8Ly3U2+rUVEcDJuLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QmS8NkIucbI0+7CPxpkq2aHqv2RbPLENijMJck3yQ8OyzM53o/fXzTtxng+LSJCP07YUAqaaKqxA1Owz6+oiZIOovBCg1sZZIFzKDagQyj39L+YuhljGrxvDbp1AusDV2WAud9u76XGR3vfoWAJhCtWkWshKkog2tVi2CeNzTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9P0McYt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YsQI9/WY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9P0McYt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YsQI9/WY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFU6w23500759
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PWFJKPjiUmt2MzQeVSdtz6
	+I6h5J0GJ1E7SS22Bc2ZU=; b=i9P0McYtdYz9t6lpEeQncewevRg0h4yiVxMWJA
	j4+P8d2tQh8v2ko3emcxDUNqhIAfjATjE3ACGbrPeYI0esHXNFUpawWGkgnfZGM/
	8OZwqM6xSmfrM1jQdBQY/BuF0uioEpRLvK45/zZJu1NXOU4l0b0evFMV1jvS5uAS
	wx/qVUPglsQpFvhlgsnRy7PxHFd859NbDtSD64AuUad0Fgealp83JknpV4zo5Ju0
	efRb5T6dtc/KYptsebrqpFcV9P/Myud+22XetzMFC+LRvEMVhfC6zCTviVi/EjZ3
	/FtI3drB1uXd9nzEaL3qGvTAW26ltBud2hRTvVz19JUqHVcA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g181836px-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:16:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c26012cd0so2346391cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645004; x=1787249804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWFJKPjiUmt2MzQeVSdtz6+I6h5J0GJ1E7SS22Bc2ZU=;
        b=YsQI9/WYItLc61moUFlUZwo89vup2t2hjCTatvSnFCe9P6OIYnEH4Eets/dza8QGgx
         pLBqjF0hE/X2z0+g07ugaE7Dhky+usSmp1Uwq/ngGqFGMN/5PGqgymJDc85XY/zGYigb
         dzE71FcFNI6EI6gI0XQaysMBrSrLv1RbwDkRbNQc1ob0ry/0V5KT7u5ZsxVlqdaOg6aw
         JncT+7o3HenvnXpUav+5beSVzSGT6rZ7TeblaGxEkpPQD18rhmGS5eXE//dqfbGDynLO
         2yMZaSy2SVdzLx6uI+OloFTR4Wt0k3A339ImlOUHKHaKJGImEGIYTEQJ6J86IVMewb/2
         EbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645004; x=1787249804;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWFJKPjiUmt2MzQeVSdtz6+I6h5J0GJ1E7SS22Bc2ZU=;
        b=FhE3NtaJMJ9zR4w6QD/a6/KMSZEh2P8HrelNiCHYgnVSQb3sBxVtnPKSdjdtJ0li52
         +qcRf01MZ6M15S17zXj1DUYne9rcnUjOCKoirV9dMVwefyLSY/cDSkRBwTQVr0xQlvcK
         rl2+ny0Vf5nJDUBIER+ujdbUcjQUnDTTrrx6JJOyXqnaW0j8/7s08pAuds66d6cgvSAA
         Ct1ZNLEBCgHzyvNNbw5swEoyMGQBOvqz25599A6LIIZnCsI65pT5m7j9DYNAjQ76ayPY
         qbb/0FDqJy1PtbMabeM6hlPfUiS4+dlycFntn1j/USQ38y64rFW5mlRvQhiXws3FM0pt
         8baQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrc0OzC4/JORTv5PRqP2832iNklhTMloGnMCgZz31MdN73d+Qh/kvQSDfYEY5Wy6+eNgJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJsXNDevyLJB0DlONeY35xXNkMQ54giAZltFR1VdYDHcmSurf
	33ZG/4HyNmsBeF1CNp4ElISl8wUxJ1rwpoTENLYDL5c6UNihXnUPkn4N0U9NnwuvJu8QjTCzgmf
	cBt2DxUdaZsthfTU2wqVitNQfyxUkzY732XE/dftZgTPuTjp3PQqKplwkkg+UheU=
X-Gm-Gg: AR+sD10ZJYkfYplx0AD0OF7gJCNbgfZNQCDSLrofUCfePK8Lkn7io4ItjoucHqdpa70
	IZ89G8tOpUIWE90IzgUeIE93cWLPOaG4Kyf2w/zVS1sTzOLaMsKi13RZe6F7pUbESZYul8J2cz1
	+u7wkVmPVj4KXwmbY7iCTaGrD9hq8kol1aVdaSsYV/AqYF+75wWFSyl7HeuOPGxu03HqC8JjuNx
	v8kT0ChO99rtGVsojlcw82UOkuWw0All7r3BZzMxkJ70fxlrqpkSGnRpicpUSSAbWTwFRJkmUyu
	ryjfhMTebVwoVzuOuNCIkmXZuShhfm3IWdWSkZw92U5+o/3/k5S1DhG4jgGCeCKzZg/j0Z4JUVw
	uEnQljkHBSTc7j++P3MIIZEmlCc7Zuy71WBI5kfot+Q==
X-Received: by 2002:ac8:574a:0:b0:516:d781:589a with SMTP id d75a77b69052e-52d73d93483mr80959881cf.22.1786645003603;
        Thu, 13 Aug 2026 11:16:43 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:516:d781:589a with SMTP id d75a77b69052e-52d73d93483mr80959031cf.22.1786645003075;
        Thu, 13 Aug 2026 11:16:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c07d2sm1220943f8f.30.2026.08.13.11.16.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:16:42 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/16] cpus: Improvements around BQL locking, improving docstring
Date: Thu, 13 Aug 2026 20:16:23 +0200
Message-ID: <20260813181640.6537-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX/CxsKx4OtF2Q
 TWYyqJrIfnb1UALhefI2440cnE0S88sySpwUTIff8D025yn3zcI2KIpyrf8XiNXh3774qo9R93T
 j1NuEdv3jMS2TDg1mij4Ihnjb9b6+FE=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7e0a0c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=2yYdEO9dI-2tQnahI7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: u-JiL2rQMDGymtUDx_KZ_2WQI95XmdyW
X-Proofpoint-ORIG-GUID: u-JiL2rQMDGymtUDx_KZ_2WQI95XmdyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXziFJuOwQcunM
 5+L7q9MHT9tn7C9e8k6C/KvrJobBPG03W9LFa9vxhC4Y7v+4a8wA324QbP32l9krKGj5iP0XrXy
 Yqe6dxqC8kGNGHQZHQYt/HWaR8xSzrlEybX0Pjos4/oBLskNR8e0pvOwLyqwXugs5Jnh/mUxBJc
 KNRw1XvyRIyAvf/Jkr0loTc6XvkoXcIZKJAWDwBvfjDsA+HPSpGt65H0Z13i89K4d4dALmT4xcl
 dxnD63yn3W5qdLY51UKz7ZEDHMZ7FsY9Xd+P57hY0qSmxLs1ieIrulh7OjJkJXscuo4roO9Kq3K
 b1WjAbmC9nhKfCmDpW3wkI4+aOkZvKtZ9N0flnZuuul4dfRRMD4373DC9KwHdrhh9XmJCNdhWki
 0HwY3MQQps5xiF1T+hcITqjcrf/McTjdUmK0SY7/vZd2fYitALc2mfpjefKlXq6EW5lS9RG5mkj
 6o7ER3yG4Q+rWLyL/Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Hi,

While working on the hybrid-accelerator, I had to debug issues
with vCPU scheduling and BQL. This series contains patches I
wrote mostly as note for myself to better understand what was
going on. Please review carefully as I'm way out of my confort
zone...

Thanks,

Phil.

Philippe Mathieu-Daudé (16):
  accel: Label outer / inner vCPU execution loops
  cpus: Improve qemu_cpu_kick_self() docstring
  cpus: Rename cpu_stop_current() -> qemu_cpu_stop_self()
  cpus: Rename qemu_cpu_stop() to qemu_cpu_ack_stop_request()
  cpus: Improve cpu_pause() docstring
  cpus: Improve cpu_exit() docstring
  cpus: Document process_queued_cpu_work*() runs on current vCPU
  cpus: Slightly improve *run_on_cpu() docstrings
  accel/tcg: Use RUN_ON_CPU_NULL for tcg_commit() callbacks
  accel/kvm: Clarify use of @r variable in vcpu thread loop
  accel/kvm: Consistently return CPU halt state from
    process_async_events
  target/arm/hvf: Move flush_cpu_state() into the inner vCPU loop
  target/arm/hvf: Lock BQL outside of the vCPU inner execution loop
  target/i386/hvf: Lock BQL outside of the vCPU inner execution loop
  target/arm/powerctl: Move BQL assertions to async work context
  target/arm/whpx: Fix argument order typo in memory access error
    message

 include/hw/core/cpu.h             | 54 +++++++++++++++++++------------
 include/system/cpus.h             | 19 +++++++++--
 accel/dummy-cpus.c                |  1 +
 accel/hvf/hvf-accel-ops.c         |  1 +
 accel/kvm/kvm-accel-ops.c         | 10 +++---
 accel/kvm/kvm-all.c               |  1 +
 accel/mshv/mshv-all.c             |  2 ++
 accel/tcg/tcg-accel-ops-mttcg.c   |  1 +
 accel/whpx/whpx-accel-ops.c       |  1 +
 hw/ppc/spapr_rtas.c               |  2 +-
 system/cpus.c                     |  9 +++---
 system/physmem.c                  |  4 +--
 system/runstate.c                 |  6 ++--
 target/arm/arm-powerctl.c         |  9 +-----
 target/arm/hvf/hvf.c              | 16 +++++----
 target/arm/kvm.c                  |  2 +-
 target/arm/whpx/whpx-all.c        | 10 +++---
 target/i386/hvf/hvf.c             | 20 +++++++-----
 target/i386/nvmm/nvmm-accel-ops.c |  1 +
 target/i386/whpx/whpx-all.c       |  1 +
 target/riscv/kvm/kvm-cpu.c        |  2 +-
 21 files changed, 106 insertions(+), 66 deletions(-)

-- 
2.53.0

