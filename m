Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DE3C1961
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473305; cv=none; b=N+4kHCeHcNubGL5ZThn5ZxZ445m2PRYb5TqBHt6WAU7P7Yfk8boguWSA4NXk4fxV7er4c7lj2YgXYQq5e8oqDHduPkmLEodgWG0Deu0f17Zz94JhDAx6n6s4wG17BG1vDtt9XtWxyGFKB3R5Cr0rZAXPAfnr+ov8kQgCEKc0T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473305; c=relaxed/simple;
	bh=Hf0azrdtS7XjRLDABzfYd5M1Axt9BEip49Q+FZEMdWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGl6YuPRWcqI0zaNWJ0kdnhyZB3uaJ461wzO9OrXyapqBJsA4Ly74gYQvdSE9iKgIytHaywUqvmDLNhfbpE8IYyZQaKJa0OYGt6GQoNkFAudtsyG2DtfES09mIwHxXLhFbPfQY6t2Obbzm+8mg+SObwUMWfDUcXY6SnYf/pEd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DelrVk38; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pz4a1UfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DelrVk38";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pz4a1UfO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGOMZA1165239
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=; b=DelrVk38tz8OQPkw
	hIN3iyMJZdKKV4ZWDO0CiO/L1/LbBKFv3Sf7C6UY/5BD0eL4wwZh0giVIWDp0y+I
	v3cvo48k2KycEaELWYAYJ+9fKMaHNpq6DZsWgkNJobqvgNZ6ojHCsBmukNDDUg1U
	/W4+CzW9BC27JUxo6PVWHqLdnSsrd72U3+mgM1upUe7jS6r7bQ6DCzihZRFXW8mw
	dOP8xWO+vvq4ANVT4j+RpHHuJD+xeWkhliWxOjsVWXlvNiYuld//00U734LQCUzR
	wRQJFZ4uW+wtoQMGd/oc+eyatJaas7/GpQWb12tpAMIEnlMdynXxFwKyh7gVOQnM
	xZaMDg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01q123yw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d137a68so3983251cf.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473298; x=1787078098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=;
        b=Pz4a1UfOajSXP3iEPL9NQrktOfxmPENwUs0WkniLjMnSTbZqA9XYL4t64rjIjF/7Iz
         kMCEaM/WYKIlYvrg42CJtmRXnYxW4IwHC+RwZ2kb5B84OrU/HfBoVcwF87BNiJvtz0Oe
         22fCCDewUOwUT1cB293zX8KSfECAuHUrkwFVaQq7jwcmasGBzaJLnq0LVCh/HPZrmlII
         t2fQXNFS8fECS8iMHRJtw3rBjCUCOCi7vjRUP+i68sRLr8b3dw3/aeiPTIj6PRPjqxNA
         ezTqaDCx6T34lGg5ihBdX/oY6AkbS2nDEOWCQNI1X+1+rcZlxWtHqjm0dtt8pdytjfTF
         msCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473298; x=1787078098;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrfE7e/OO/Q4kyhaEr9Sc92fr3TG41A1jbOfCVVmhYI=;
        b=G8DAVz32lsp1Sdx71C2ncpF3HzXOcOlFBCsMJdJxZRc9t5hnU9Q+j/IcSIFBsVeM9K
         o1+VfWEQnpqUiizWFWxDZ1h+PBJD/13a99sog/Rz36Yyj8du8pXeUDPXPuA6p2VQhg4u
         wkbNAaZu0g01BrDXrVtlXWIkPefc6Iqbm+7Y1Rr/IZ64/+fwk9v7xgur5z6TPWMMYguJ
         6DoytF3++eQzO0QhJdxMBV6xWmtzAu3P41mJws67NXrrXdPmJruOU3LhUO5AUB/KSd9g
         PDuL7Zlb+XfyM6RRmCKfpIDVPO6Bf6dp1OrudIOxiCxcp08j57FD4ohF3O1Xal1dRdOM
         qpvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/FL7eaQJGi3jaH4oLxF2dbf4xkigGdRNV7HiEOjfP6f4WM/DDmIqo5PMEGRfUdYEgxZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQv11F7/HQgRbc8hzBDkqgIJKh6j3cEPz5NPEsdVW/UYAbx9R
	9XFHQz8MFWnk7p+A3KgFRDtDwQlEYn+VNC9VFXW4vDZpZ9hOxnTNgkSxdNy2AedNbJASZB8P0qh
	t00D4k6PEK6bHwch6Y/tM7fxL0SF2JdcoDtkbpPzyCjIAQq+Sidv3BteVzRLd4GI=
X-Gm-Gg: AR+sD13kXDniowkk0iJ6Gr145GJcUn/t2zJC9/X5qP/lbTkkcaVMXpT89yXcYe5yMUI
	oUSiD2zxbCvMHDYHqb/FIWsunQe+OX+l57MKfOPVkzmF15Ga4+mmY5q1GT8n0+f6j/jDPfskJH6
	tPImVwE8q+WTHo6ntBBRZM4zMR20IeppjpXqjzCjA7MjFSpAoJHCe3Cq6gKSfPlg1I+/9PLRIHs
	KI/UgrOurMrObPv1Sh5oteHPS6N5dQ0yLa8kj5mkF5I3QfsKmToKOENCmnmpIGi2fiuAhJlshC2
	HNbbv6KVBtvYx52nIx1aun36sSFf+FF9OhoRiZ4D+Mc1Ct3tUY60eRv2tpicISpuzr4VVtzJgqV
	jhJTPiRifGcfF7ei0nSPLuDZ+vHWsFIm5MDuwwoOnDQ==
X-Received: by 2002:ac8:5d06:0:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d58670614mr49692351cf.33.1786473297908;
        Tue, 11 Aug 2026 11:34:57 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d58670614mr49691831cf.33.1786473297432;
        Tue, 11 Aug 2026 11:34:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e675sm344795f8f.23.2026.08.11.11.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 6/8] hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
Date: Tue, 11 Aug 2026 20:34:08 +0200
Message-ID: <20260811183410.22428-7-philmd@oss.qualcomm.com>
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
X-Proofpoint-GUID: NV2feHRSvo4YIuaqxJbk8dYYBqP1Ambc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXxsBwYC5VRU+g
 9JQivAmV1LfMn+Q7IEv0pRd5hzGtrh7LXuLQa3YpDdx5XnML2LHHhsdqzmjDmM4MWJOlgn/hi+P
 KMnt4nC5LV3oYelOHdrhcZ8LqNakqlPX+Oa9VJRJErFrOBMCrfC0qYemXzGzaaNTxRxTo47V9Vq
 zHl0F1baay+ihRbxhYfBUvFjQCGAEqodxhRgvC7lC63D1wNorVbQNWr7z29xh75DgPTvupHwvcq
 p918PO5q2Xz+6hTlCZ/K5pmytjwaSMNk2cJ995uuoT47QARYguH0OcXS12VOYJH8i//62MyVZdQ
 eDPhQ8ml1oycK5w3jF/hYDAJSG0dIclrisgQYIvSDFctv+FW1g39Bp5OwlibjZkWftI/wAK3xqF
 HfuDDMKgtX4R9OwEm8XksxJNOfcP6AU5sgootIjzPeT5tmCtQakZG3b3hRYQlLPBUEhROv37VU/
 0mf4vjRxmHk/339R1gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXwtC9E1wZ/7Op
 EnZ3ZdQe6799g07hx4AvtBe6IUisMtu7KZ+zNjEqXpgNryjW/rAqwIX8mC7wk9ozys3I7uI9m4v
 xlGR52mfL9sAabhMK9S7/QhW6e7GRTA=
X-Proofpoint-ORIG-GUID: NV2feHRSvo4YIuaqxJbk8dYYBqP1Ambc
X-Authority-Analysis: v=2.4 cv=brt8wkai c=1 sm=1 tr=0 ts=6a7b6b52 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=--_MrfCweEvJdlqdJWAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 4 +++-
 hw/core/cpu-common.c  | 4 ++--
 target/ppc/cpu_init.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b7cf330cde..81af7b9ee1a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1180,7 +1180,9 @@ void qemu_process_cpu_events(CPUState *cpu);
 
 /** cpu_common_realize: CPU DeviceRealize common handler */
 bool cpu_common_realize(CPUState *cpu, Error **errp);
-void cpu_exec_unrealizefn(CPUState *cpu);
+/** cpu_common_realize: CPU DeviceUnrealize common handler */
+void cpu_common_unrealize(CPUState *cpu);
+
 void cpu_exec_reset_hold(CPUState *cpu);
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 732e32fade2..59cd489b713 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -284,10 +284,10 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 #endif
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
-    cpu_exec_unrealizefn(cpu);
+    cpu_common_unrealize(cpu);
 }
 
-void cpu_exec_unrealizefn(CPUState *cpu)
+void cpu_common_unrealize(CPUState *cpu)
 {
     cpu_vmstate_unregister(cpu);
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b07e9c3ff9c..e3a1075aad3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6956,7 +6956,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     return;
 
 unrealize:
-    cpu_exec_unrealizefn(cs);
+    cpu_common_unrealize(cs);
 }
 
 static void ppc_cpu_unrealize(DeviceState *dev)
-- 
2.53.0

