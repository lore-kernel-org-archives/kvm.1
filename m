Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498D380FC8
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473288; cv=none; b=FWI1bfR33gySAnOu0huqJ0xg/FtJctustCO1NqMqVDjXVQHPilVxUaFsRf1t9U0h831uWdjAQDwGawKzXgZRU/KD2A+vuOY7O2yOqLLY4iGmsgzHqEfO744WFQTNL54Bl5cdnyFq4ISfzOAcPibayz3OryLCd2sPvHHwLmOiDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473288; c=relaxed/simple;
	bh=bDOtLPqQliRMZlA5VUiYARhGR7Ynqm9Jf1mDl5jHHi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2gl/k+zt/EsMXbc+2zicxBv6BJRNMfpQxx7FlYEqgSZX1o1ti3VGZev8aN7lNBFx7enh/9K2x229Yo90yBe2cEk7n2vsEfudbtREjM/0oc0kZkJ56dd2+8Fx2eVQDuaPijmUjpz8nWdD+M5GD7WdaD6tifo+PYAT4qe1IVAAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tz8u2WDk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xg5c1QWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tz8u2WDk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xg5c1QWL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGO5421169712
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=; b=Tz8u2WDkxr3uN8qi
	GOewG40Oie4BM6+9iR35R94uCboF6wDBSnuSWEgNXPufnIVQKs7VIlWCngHlw7Sn
	qkJMhwIWzEYDtpHXWnNmSFlD+52LHtguiZ6XCrs6J3ra2vVKSQQzsSTXpRTddr+F
	qOzqbc6gg54YpQmBG9TziC2Ztz7d4xuR0RYL1zCspg9PWwzqi2zY119SKilC1rsq
	i0HO6uXiFqd/niT1Kbfhv0mrgI9f+Sz6NYVrs8SK4TfhWqhlAZjJj1Wf4MTNgtux
	m4oo78gd6DktIPw0k/9W4t3lgU+/90XGdapiHwRauRR6OOgRwaEoWtbYz+42ZyLz
	ibf7lA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc23fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0f45415cfso1371086d6.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473283; x=1787078083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=;
        b=Xg5c1QWL3MnFow+Fcl/UXKnwriYSd5mkmanZEOWtGmHfANHWw22wtIX+vQ2/wHhAgH
         QxQMVe5u8PL+7ThZGsn8HthKh9pe9lHIi5OgTWJVbp5RdEJlHEYlvLJ+veSu8SvQKcvK
         LslCKTZ9gu8ZxCI7ZO2iuEcYzqyZ2Hu6cSQRVPWjEEhVoLG7u4p2xuySFiAxObJt0g1Z
         6oitys2Wv/sSzaRkyaOfyglEjp4rGZ6jtBh9I0F4of1wKi2GjOx9Ys7t8uhh97wzF9p4
         cY538PzI6Ngpx2vHWMMcOLVdoTVo32B7ajGNeslcFbPF/8mNESIXdIe3B5U+nm404sJv
         1N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473283; x=1787078083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0idV0Y0FQ0rdA79Ll+RTIzajE1tmGZqrGlMbn9c++Vw=;
        b=dxnOeFBjse+ZvJSXlUWp+r5ERR2hQWDQVR9PkQhiISzXDc2ny3Y29cxTEVdPHzjiHW
         TVQhz6xPvHWYImCP8oakJKc4teFVW4YOY/BsQD4lEIC4sPrMDiolXz+BeQzFeWwM3nU6
         /ZKmDQ0FVFZ6KG9qh2WbEKLiwxqHjV1S3UEb6cCjlAFFm4YyoItVUS6SQvZXeXsigtPE
         6Xa0IrqTXPs8kYR2DI6GlgK2j/UFmoYCh8/23iPz7XkK7FvLq9VjDD+jQ1E5hI4ITfag
         xYpX82JgQpJs6iXcNgm/9NvGzyG7l4owu/qKZW5P7C/qOSN1wF0zcHehsN+10ltLDO2K
         n5Kw==
X-Forwarded-Encrypted: i=1; AHgh+RoiUArhVgzh02G8PlbyUffSb7ml8Do2nk8pJfQv+UZ8j3fNRv2krURlxSnnXz3RqclFIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVesVyoyln5FKUHf/8O9kJSpxrvcUgzfSjjqa+johRoqmDu0M
	Yi10glNIaeE2NCvc5iGOR8YBnVvmy1oSSRtNIbbFg7F1cItiFJpOr6NfRneWWpb120fy6AdYi+o
	lgRhg8ayfew0SCvGLR5NZ3BeOfW9z1eKVWldGRPjTzB088SGjMKluw0c=
X-Gm-Gg: AR+sD126hG34/tdGw5Tkodspen7IOmD0TosyqZiHNwMgc6WC8ltf72rvs2N51PNZgRD
	jvCFgLSGKM+ghowRlnSacEwVtD45F0divEud/NV6Y8vbBbvkVF2o4PouyvnCN5u4gB8RB7BSyhm
	GDFVgZVz5EDKwk8ACAXL/zmAq3bg0pX6sGtix9lXirKWZoOjNSo11zX6id82e7ZfUUpqUoMKXKo
	ntQ1TEfVe7BDz9m89fLgKJ7nAc4HEial67MNModvebO3CtobBuvJ8IEPBVDoYUeE45+1RObCWZl
	wEPUfQUhE0Fq/D8IAJVBxcy460XGIDXslKa1ji/gQSjV9Y6sCeBa6dDAkjS4aiE1fKzIKJ4kbAf
	vB9WvnHi9mxqJt1K4eoqPoRQdgIMENjmdWRYULms9ow==
X-Received: by 2002:a05:622a:5517:b0:51b:f640:2a4f with SMTP id d75a77b69052e-52d584a8c47mr53649941cf.4.1786473282769;
        Tue, 11 Aug 2026 11:34:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5517:b0:51b:f640:2a4f with SMTP id d75a77b69052e-52d584a8c47mr53649221cf.4.1786473282237;
        Tue, 11 Aug 2026 11:34:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d5ecbasm299929f8f.28.2026.08.11.11.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 4/8] hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
Date: Tue, 11 Aug 2026 20:34:06 +0200
Message-ID: <20260811183410.22428-5-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX/dyWvZz6omjH
 iLMEaXrqeAPfC+q+MHGygfDQtL1gDwdqUU4QTdEdgrZn1vanuHgb8ILV+vs0/MwJVdVSzKEHmKZ
 m2EyXBCO+8hHqyrKbD/O/fj9mPeiXd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9IV26CvSVVSZ
 LufS2bnR0SjqEFvIasYUYcRlQuGWgCkVdwNKKJNeG9ui2gupOrAHd0Capdz3MvaUJkZVpHVr+1U
 tgtNepVN96YkkCkcYUAvGf4iEMGQqPjPSr8X4O4i0dq4fZKOKRfzAwsu26ygQnahuetfDOPjDSs
 iGcjkcAufn4w7BG3Qiwr8tZcwCfKXlT3Uc9GukrleldxE42wSUWtKxRN+Hu5PLn2Di6OhSYoyhI
 91HsAfyFY1g1ydImjr6GQbQfW/fuboG8SxZa3TSeyn4kY4/28yzp64fXyt2qr8yIG/wmboedkk4
 1ERKumESO8yRBwBDHMtHrLZKcqGpvSAswcNXaV14fssA0WOxkgRaMIEaay/mU1egSngU9JIc3lD
 uCuQv42U2DKCmCm+MYGbr7+OOJAg3x5cvU9wc79lvVheUn0EvbUu41NCdLj4JPmE43yXaQHUa1Q
 WMnmmESz0ccOlo26wNg==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b6b43 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_LLhLsGey2oFb-bfptwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: P0RRZMRJueNQ4pVDe7UWshS1Z94-DMzU
X-Proofpoint-GUID: P0RRZMRJueNQ4pVDe7UWshS1Z94-DMzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c      | 4 ++--
 target/i386/kvm/kvm-cpu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 17d76580930..33e349d4402 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -246,7 +246,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_common_realizefn(DeviceState *dev, Error **errp)
+static void cpu_exec_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
@@ -379,7 +379,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_common_realizefn;
+    dc->realize = cpu_exec_realize;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     rc->phases.exit = cpu_common_reset_exit;
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index c34d9f15c7e..e164cef2036 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -63,7 +63,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *          host_cpu_realizefn()
      *          kvm_set_guest_phys_bits()
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
-     *   cpu_common_realizefn() (via xcc->parent_realize)
+     *   cpu_exec_realize() (via xcc->parent_realize)
      */
     if (xcc->max_features) {
         if (enable_cpu_pm) {
-- 
2.53.0

