Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767417E105
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311462; cv=none; b=D/Us5vo6trmZXJ9kUZcwG8zpTHCkk3Nm0NELtq//sKWXRrgoLf9uqA581D9PEkMdP23xEEjFb6hK6i++6hznLSzTlF3tO2D3IMgBWD2D8I0g2fXHeSOcHlEdiuVHemPj37rZzcBwq81HPp9PEk2TeL9NcJCRVzt5TqDbLhyW/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311462; c=relaxed/simple;
	bh=ANS5SKD/65k+mVrkDedze1kiYPyKDLNlIHEYxqFB4MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XClisQNSbETm5AybFPL6Hy42+TJBxcqW5dFOQvpEU0xoqxLeFSowS/EhnYZ0FBvS+vFI2aoQHZpdWfRwLQNwLEBP3i9+KLFqqgZbKVAFn4/ZzYvtWTwonU9GLAa2ybjdbdT+Orbb0xyJji5K7wYeeDRSd/2mGcGvykunFkEfkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Spbwv1Um; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Spbwv1Um"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RER3KI3403831;
	Mon, 27 Apr 2026 17:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PTOrQO
	Jsrn+KVoiS5Hffu6mHiv0Lfyv67IOJdpFRk/g=; b=Spbwv1UmCTAg6lmEZIFmam
	tWm1IvWJrx3NUFcR4CIk/mhjJR5YGmANQvmMeVY1TKesa/Q/SmkbYPhcdW2E2r6z
	/nb89WjWJlJw9Z2XyTBNM+SkZSoD8RRrsNFCTOxBdHm8Hg8MEwPbsOHEgDy5vsTv
	S6fPbfAVxFXgP+8MrZ7AAorhGsiozcreacI2HxEMWu9g5pGIVH7+jBtKfCM+p6tq
	Yufu/x5XFXz6CUAC0FHxPg7MejwfoWTNwYZyyWqoxrgpNuo8XrjWL/k1qvafo5Hv
	yhL9QAUnV9CHP25GEYCsAWrd6LG3YCa9bPaJKyBjEJFsAxKJHbdb48Gdegh5tRMw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1drxe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RHNikh008312;
	Mon, 27 Apr 2026 17:37:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh66ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RHbKxN22544686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 17:37:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A676D20043;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AC120040;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.47.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 27 Apr 2026 19:36:43 +0200
Subject: [kvm-unit-tests PATCH v2 1/4] scripts/checkpatch.pl: Add empty
 codespell and const_structs configs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-b4-cmdline-v2-1-0fea2a50a9d0@linux.ibm.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
In-Reply-To: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ANS5SKD/65k+mVrkDedze1kiYPyKDLNlIHEYxqFB4MA=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnv552/9Cs8ftfsJdH/tDsrD6mdFFY45Dxb6rXFYZc6i
 7BCA+1pHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzE4CPDf9/WqZIfc8PPFCg1
 v3hpIWLKWWmb9bGF063UWvDSReEtGgz/1P88VH/+dUcyj9xKpeb/OnwLFU8nmV9uEHq63Pnv7ON
 +rAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ylLgytEoQ_vNePRotWY0yfseDPn3ngTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfX9FbOIwHR93NJ
 CnBqTp0kRti8F3VO8+qaVmZ/PuRSngsDv4lChn3kTv1Tc7a5YfXrV7paWAxlOzmRqXE7bXivhZV
 r5MC3CXwe3OCJ7b3bjjPYhRnNOWilR/1rtf2vtK1WXrNI2K84mIuSRAp30Q35JGq34VBhCBAnZW
 bJr5KXai5mBIX3SOt9V4Gv+Y44ius6ezHBkavjaMp7baNOiCELS+6vZuUQrckgASbKn9z44M2Sb
 dyOvIyXtqt/F/xQOduF/tgN2rwIpjdBzCSz4xCTC/jXJONynbWnZICLtXk/lCqajzB3r8s/bYc3
 YDKqWAX9jViW7qPkTZSws1pQPhws6otA6k95Hz4lyEV84KPImw/L1JsSTSN4KK+4bRgTKfRRZwn
 RsvxKUZTQFqbRKeCKRvxTGFxvLnFwz/CEpia8Ed3eJaWogjUZSfbppNdUPkOUuYpbtMoq72rfWV
 rGokyA0Zc9Is0HGsOcA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69ef9ed5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=7PIkpXOR5HpayDouYfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F8HAr3iNA0gSvVpTyKPng3oXm8f1HwQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270184

Without these files each patch is flagged with these errors providing no
value and swamping actually found warnings and errors:

● xxxxxxxxxxxx: commit title
  ● checkpatch.pl: No typos will be found - file '.../kvm-unit-tests/scripts/spelling.txt': No such file or directory
  ● checkpatch.pl: No structs that should be const will be found - file '.../kvm-unit-tests/scripts/const_structs.checkpatch': No such file or directory

Fixes: 846737f068d9 ("checkpatch support")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
new file mode 100644
index 000000000000..6d9ce1d891bc
--- /dev/null
+++ b/scripts/const_structs.checkpatch
@@ -0,0 +1 @@
+virtio_config_ops

-- 
2.53.0

