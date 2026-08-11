Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A63B7B99
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473308; cv=none; b=h03gDgpreTyfInhuRodKTWegafD/WdSjn5b+fMGOnewwwqvAB5UC31NbriDikHzTVWYaqmfh87dgYBUbB10J7ZJsleD+koxZpyKFHoKtWuy64T6ZYJM5LEvOhhwwPOtuNCRVDGzNvIDgZt1QBsO8B4mDCere+Nw/0a+6ydC4YPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473308; c=relaxed/simple;
	bh=wmBtAt+ebNpjKV50uqEyTv5HCvrWDrxO8+G/N22AkYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD8Iqj/Hu5BvFDiqpkUr85AHdSaTcQtrY/KnFOCyLZAH7XakG/FDR9GizznKipi7+Gd4GmyAVmHQWQoF76/QMTzxHkHTDHlTzm/1QvnAiNvVVqBacp1CEo9s52XPL7wnT+47VRHOvHBH6KkZGF8pVNrdWN5Sgr7vF1Pa81DB7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxOcmhNY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHWQd1j3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxOcmhNY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHWQd1j3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGOG0D1094015
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6PMGt4n5YI3CyMrkjq/xqLMZCyo+mWskjfZ5KgT8eQ=; b=dxOcmhNYZn3IivWD
	6kxxx6a5XS2wSZWcHJ8uTt+2C0P5oLXOLReF0SawRTaidsR8qna4djDyvlTbnUXb
	anJnJpoBt8oSh5024afIswOzHTVXPT/vsvpwmXJxIBC/CDOmQYC/pwwbTzLVY5pI
	w4BsQgO6yI0DQBq0imc/B9zvS/3L7ui8CfoZO6ZqrETpZJydJMLhcTXAanXd2fG7
	Jy3OJ9ed2KiaMaVKW2MEe2EukP0DvK4BkPs9fS4qEkhJkNj5IZvCOx/XvnasTlZh
	fPpfBfa856o7jg/Bl+9tOuBcyNWwkVgM84HZT+cRYxNkb07/2+4iP+bNmWx8JYeo
	8dZ/Iw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gsj8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0408254aso17650951cf.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473305; x=1787078105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x6PMGt4n5YI3CyMrkjq/xqLMZCyo+mWskjfZ5KgT8eQ=;
        b=FHWQd1j3wasWf1bdeVU7XaeVVc1tepUmys0wKhE9YMD5MmP4NXqeIBGDHdbt/sayy7
         eYEt7jyzE/taua5QEAZ3cnbxJE7Nb+5z1c6dcR1HoBlkYTBOJwNYG53WhvVcQeAwPSH6
         dnjJJCF1rj79e2Js25Wmc3L2BCU+sk9RHtxCNmF86e5ZWdbzrEwd/1tnawPlGHjyIi7e
         Hji1jU4eTxRXSype6UA6p+muDy/AFsZyyQMeBQEdUjLijN9mJ8/fmeTZMwJDtZKKL912
         oMXsH9wWGFEIiFUxOMC0SVJccPUcwRFx5wlg8i4nKlYl3txRR9tjjXuMO3DaFIfFZpwa
         ECMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473305; x=1787078105;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6PMGt4n5YI3CyMrkjq/xqLMZCyo+mWskjfZ5KgT8eQ=;
        b=PaHiLN/Sj9dH3n4talP6HkQK/ENj+X5zmo2X2fJLf6XZsUM2rVfZfkSpzKEmW87NdW
         WjZRF2j0uOvz5uUsIMj1ajzU5PkwZI/Mlipi/hwmVpZ61L3cYKQg5nE9tYogSCrbBPx6
         s9sobZ00QPnUbuKiiSWXMl6oStJnYREZnidmBxDhFlhP1OORmbqbWUJ7PDYPIO6yg/ap
         YFgAARcsVQKIkWKmKJjssGf92M2Ued9dNHSuyZ3gEgYjscGHynUaO6Ee1yuur2trzUnz
         huVz2YjhIOfUT1aqvwmA6aarjDElRXsMRdG7Xrkz1C1X3jF7Zrq69D++lHkCIZZs//pf
         6c9w==
X-Forwarded-Encrypted: i=1; AHgh+Rp2gF7K66bCswFwYgAxtNEdr4NFAokBzXengV9BqUoJ0K4ffvCJRM8chr8yZyziLrHA+uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oX7yximDQe6viDrVGDwY3bdptYDLhH+cotIdrykDpBhU0zdh
	MjiTG85ndmDb6MWQEe7DewPhUfRWcU49289bIstBSEraTsm3fEcQiiYQqQh0IfO+dJSlxKncnP4
	aEo68hdO917FkzRprNB9xYpVXDKmdArLHr+j5x4FdsqpoWxqCfHMOlF0=
X-Gm-Gg: AR+sD11AKVV5+C1Z+fjy6pCZPMXoT8ysWDO9AfOm+KzxfEix6Oo3kuhbgRRjYISZyQV
	CZHqjn/j8N38ploYAM57yOGaC39OaHk50bnop8diOwIEaX7iXuqIDjMp/owujCYLASx+UIqF0jp
	M2Sa/MC5S4/4hFHYxwK+WT2Nra79MQA1OTGDrtXccA/EG0CBn00dz3Z7168RYgKwCmkK2pCffqi
	grifrYTw5cjSk2l0g9zbYpHDUSa/9yurNDhV6owDcEfGPTkd+Uzbb+buo2EpcDp9UPH7MHyXeVg
	oCj2lVF7Bw2u+08BC1/cDatv4onW6D/Fq4QbzwFVUBKsXAHH15+dSCFa/670Bh38BG9sAjZoS2N
	UMVp0qrg7MibfTIhiGEbCmVf6AqIv7TBGuA97Qfhy8A==
X-Received: by 2002:a05:622a:2505:b0:51b:f992:9e18 with SMTP id d75a77b69052e-52d601b392cmr30485471cf.2.1786473305001;
        Tue, 11 Aug 2026 11:35:05 -0700 (PDT)
X-Received: by 2002:a05:622a:2505:b0:51b:f992:9e18 with SMTP id d75a77b69052e-52d601b392cmr30484861cf.2.1786473304627;
        Tue, 11 Aug 2026 11:35:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d5dfadsm333703f8f.29.2026.08.11.11.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:35:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 7/8] hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
Date: Tue, 11 Aug 2026 20:34:09 +0200
Message-ID: <20260811183410.22428-8-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9XfbCZrR+kWp
 5m5SW+QEATcZzs4hyc9ODe7+3ZFJt/qXXk4kGEWrETpCAUEuDJlATTVoDkYD6rn3n7oyFOHuj6Y
 JFeN1J/GKZXmjKOccF7Ym6fu6XRlYbU=
X-Proofpoint-ORIG-GUID: iEr4kGU3XLah6k_iKfFNVDTOWP7kAep_
X-Proofpoint-GUID: iEr4kGU3XLah6k_iKfFNVDTOWP7kAep_
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7b6b59 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3ZqzEhZVOs4yraokUgkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXyPePTt6Cdi7H
 2Rn2Uy/+G7/ygtfAbtcIQPoJCNjYWhOYAfzFDShsKbx2Boue93FtlU1ERbpnHBWElhOK9XlLFRS
 atjqR/elJ8v1lSYr2tk1ehCMCl9iM3G1Q1vCepGExQ71GE/yRGnhGHENskSy9EiLeA3mV/LTh7w
 2SBuAFvJabw/pDO84PSHUyF48e30/yACYy7FxifPK4lYpnwaA1VGOvmsyl9/Jk/vRW8M7NvCXiI
 Q6Mmr/EeFhFqVh+sheLRRef7iUXHCidiLK8J+eHsNjP/zWCEOJUAXQ3eEFzzhEimjxv8sJhC6bI
 HNGrgaSyn3srgWQHX8r/FHhE2M9nRWuZbEfdHt+0GrWNjgLFpPei2XW3FsxB0M2tUprY21TtqM3
 Z6j7pM8uPTJvHwjXl1dSK8lLOkMgs1k+e4taho6/m/+oEQ0U85M3ZbQLTqOQIVoJlQ01daWEhHo
 tgutcCbycRzHH25xSlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

cpu_common_realizefn() contains code only used by system mode
emulation. Extract it to a new cpu_exec_realize() helper. In
the next commit this helper will be moved to cpu-system.c where
it belongs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 59cd489b713..cd7c8763cf5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -246,9 +246,8 @@ bool cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_exec_realize(DeviceState *dev, Error **errp)
+static void cpu_exec_realize(CPUState *cpu, Error **errp)
 {
-    CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
 
     /* qdev_get_machine() can return something that's not TYPE_MACHINE
@@ -264,10 +263,15 @@ static void cpu_exec_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (dev->hotplugged) {
+    if (DEVICE(cpu)->hotplugged) {
         cpu_synchronize_post_init(cpu);
         cpu_resume(cpu);
     }
+}
+
+static void cpu_common_realizefn(DeviceState *dev, Error **errp)
+{
+    cpu_exec_realize(CPU(dev), errp);
 
     /* NOTE: latest generic point where the cpu is fully realized */
 }
@@ -379,7 +383,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_exec_realize;
+    dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     rc->phases.exit = cpu_common_reset_exit;
-- 
2.53.0

