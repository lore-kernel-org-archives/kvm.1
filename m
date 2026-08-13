Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567E319617
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645094; cv=none; b=WLAEEZwkqGNx+u5igR65UVvRsKj3PUR1/gQQHNHbNE8gP+luWOym6HazryIEOBzMCLDZXfno2H2Sf5Flk9lelZiqxC1vxbD5dpWy98rtuEDAxHyoADmzvkzJ2/cABUlPlu0YXiXndin9BX0fiHewsHPEhu8Y6k1mXecE+EK81vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645094; c=relaxed/simple;
	bh=+tXF+1mYXy8+w8sYJlUjC8fI/dT1hcq0YwUzNxzy9IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg4GL3GX/GOuT9qZeQsJYinxHwOzD+emea6arq/FcwuscydSK1J4d5cE3lz26UMstfjbcS4FhUSbIeox0eDf0mfTLu0hAE6ROtUJSVDec8t9b6khiyy0MEQILQkQsxUs7htIYOQcyP2obLX5iaFhptE7kQx7OENFZqOQm/9Ve7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUWs89iL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b7SgJxfi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUWs89iL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b7SgJxfi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFqvII3181084
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=; b=oUWs89iLelCmwkJ/
	Mvy/9ND+MihY70Nc6KbUpVGUUH9SZanld6qEdOQpJfUiGQtpvgJXsY97kAahP9U7
	T3WWqw1+UizKvIh2yYs2Iws+/BuiD9XBdPi+afda9TrNUZB4e+YkX0oNIgwHNW77
	mS7javzGCJevOC5tK8v9B5UrBBHwlYwcWC91pEqAhoxGROveyGYnuXZWuajxpKVv
	+2HCK70OJSYgWWC/3W9/XpardUkR7hPmgN51vo+Ve24lW2eWHPFSpGdX7x9zHy9W
	RGQq8tm2/ultltdt5+qNZghqsn4uQq5TjqTqjHaYGC2iE6+yHoavzZYsM7B5p+ME
	T2CBkw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4rp10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:18:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52827090cc5so1487191cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645091; x=1787249891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=;
        b=b7SgJxfiNr3hhaICpJNLTNPAS8eCFHpSA1hJheqpx+3bogxxbUyUHVTo7n7VIHlX2F
         OdERClUh6/TnbMPWWb5P1ZjkGUMR418HnZoL3fyypTpQF9YAbaxF19DSL6j+I1pr3wo0
         jU/JZosbzkV1c9wt/GCPaNCXrJyYxntTH6Dg5QvnMrmQh1+rmp5AvnROo0sutn+dqwaE
         qOWstHgQR4EpsiPa+u3zDMhMvebbM005RosKmRoc8WSWisGJ4Pd8UbPWWqUod5b1OlCI
         qEhkSSxCB/AXWi+WQWvbU7UgWYwcow1rMDSbZZLTwBTAx+gJbuEKHrUHrxy2bFHFeF6x
         /wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645091; x=1787249891;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=;
        b=E/xmYpo65ECV2R4WN3cV32XkrIuBsxbWu3Aku43Wd/17DIQkQMY2lKmOOs9JDsRn+s
         mv/4P4SjPF46GAAdNtsYExSSpUEtNDQ+rkcBpevjIVrXoshQ9fpKVum5FoVYCzUMWudV
         WxdzKKMvVYQdXenGuH85+15AgoYV9GfNykEzx3LKIJi9ZWITuNQohnHru6z+/tJHBIRm
         OW2lXCXzPFkSIdwx91TxTAlLLRtF9FlleWBUyQPuVpcLF7iaSoQnAWOtWK9YvT1DyRV0
         ECzmF9vbfGGzZ3PEXD451WqR/Uqhm2gsk6C98Qgilq6BaXFX0dhaIVvCeCMJZsCdaHoj
         MgDg==
X-Forwarded-Encrypted: i=1; AHgh+RoaZNglq0hPOVmIkz/hDW4RPZsq4b5jLBYndUPvlXTvysFQ6VDedtAeEbz3GelRkqmQFHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcf2DvjvRRurwp06gDhEhW4uFJP7IXasL1ku0GkhPejggtN8t
	omK01IC5XDPHQSv+R2JjfA+KqVqzjAmSTLOLEolZEo260rHXGrHT5gzXyk76IsWNYuh++PNgiDK
	ZHII4VQNwoDesTVAgIfoBMQfwzT2dyxJFpytIeR4UYrjEOw5M0l/ir5k=
X-Gm-Gg: AR+sD13QSq0r6G/XsIgJR1ehNj3oBPYPkfGvxMRadXRMh1S/MHHSSQYALDZxldNr4RQ
	VskBlA6rkRGdXNHRtLsUTC1QfHjxKQwqkZwYOh+EYkBj3l4QlOUeGFqUpRBaq2WRFTEQ3liduEN
	V7VkIP97psQHVOK2LzHGf8STalhwBY7HLrttKrNlkTTReruLMzB+3mJ3so/pTsZxkCem+RZPyRB
	doPRiVYYV/L6rZNwhAbSAKiFQxtqR7/iNprC1V8/0MjvVIIErW5ZRPA6eR3wgJteNU5YixpW2nU
	EeOkOwKtY6oPP3K7rWPP8PLY9UGZ8YWKUupnIwr9ISi6E5eyNOxXICA9+GnQImvsitJIA5P+knA
	/gah8wrAFdgU8qz6e6zXHakxspYSqbwOYUduDmhMosg==
X-Received: by 2002:a05:622a:5812:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52d748bf7c0mr76996001cf.0.1786645091505;
        Thu, 13 Aug 2026 11:18:11 -0700 (PDT)
X-Received: by 2002:a05:622a:5812:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52d748bf7c0mr76995381cf.0.1786645091089;
        Thu, 13 Aug 2026 11:18:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1fff25sm1953402f8f.3.2026.08.13.11.18.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:18:10 -0700 (PDT)
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
Subject: [PATCH 12/16] target/arm/hvf: Move flush_cpu_state() into the inner vCPU loop
Date: Thu, 13 Aug 2026 20:16:35 +0200
Message-ID: <20260813181640.6537-13-philmd@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 2tfTSm3O9tM9-R6TE-UZu5um8oY2a2Ek
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7e0a64 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xMUYw9VpK-qeDZ3ugSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX2WrxyaTOw4Ol
 Oo79r63xKz38I7mYHMkTrb1VIORYHR/KpPoqlr26pClEkfc0LIoTHEYXBT30th212aW6Pu4hpOI
 y2VV0KtfNtuyMs2ef3foSRWd136I5PU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX50lOzriGKh1t
 YOjo/sKDctfucKKsEzAvUFKS7bzeMuAhUEs1DOVTVkQNUH8rY0sob69HzRMFPIhUYfsDc0SYAzZ
 2W5Mkv1/Hbjnb+//K/ijywj1lMXUEyvjAdrNV3nWEuljRDwKFLm5QhnFgtR6XJpXyxpUxizxCXy
 eigwzzkV4antWNqm81FbELx3NATi4ShW9CEHcJmUbvWYmDDTFnzZleixhJQP2OmbqLoEOxWCzfz
 Vci+wkfWX5p1TVIxRSXMsfp+YU1AWyx2ssEqQwHpObwUof4lNoPSWIMw6Jr6R3bhl4pZj+ybU4o
 bjtDG05cmYox2G4Oa2sPmgdMgXpKF0xTEEeBVLp1HiYyjBAaiUbN08mIg6yBuEpYfZixhJnPQ8K
 oCJIeTOlkZj5adEEpSQs4LBriIUcVny2jdr78cYYDHKepRyzxHtXEXniBlgEtoAb8S/ASA+4Dwz
 3A34IessaZJ/oSQl0Xw==
X-Proofpoint-GUID: 2tfTSm3O9tM9-R6TE-UZu5um8oY2a2Ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

To ensure the vCPU state is flushed on each inner loop iteration,
move the flush_cpu_state() inside it, right after the interrupt
injection check (catching any interrupt changes from previous loop).

Since flush_cpu_state() uses CPUState::vcpu_dirty field as a lazy
synchronization mechanism, there is no performance penalty if the
cache is clean.

This got missed while refactoring the inner loop in commit 93ac76507.

Fixes: 93ac765076a ("target/arm/hvf: Keep calling hv_vcpu_run() in loop")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3eeb9f70de4..c14ea54a67f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2598,8 +2598,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     }
 
-    flush_cpu_state(cpu);
-
     /* Inner vCPU loop */
     do {
         if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
@@ -2607,6 +2605,8 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_INTERRUPT;
         }
 
+        flush_cpu_state(cpu);
+
         bql_unlock();
         cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
-- 
2.53.0

