Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F58382294;
	Fri, 24 Apr 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022783; cv=none; b=VJH1SSA7u3hWbk3gScjFgz1Dral5JePIqMk9hrt3XhZINRaBH7aLkoh4tCZvAuMgl5vQgEHsk+EuezeHtbtCG2udnaInJHj5rUiC6YRg5AWgOs+G8U2guEG45kzug+CMTmncZ5ff7yzGM1oalpvMP4PO8HxDI+SSbMCOl//Whiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022783; c=relaxed/simple;
	bh=UkWOnzOJzGLS6+u60ANqi0O9bbmW5PSJKCXiBcLN4/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl2Lcsmk2aBfkE9fLAY3IHS3yUB+ZHp+3SsC++LVTvMkWI989lNe3yNs53Nn7pRKU/YtL3fgO1irT8/YH6MGCRk75vl29OKLTF8Mcbh4JpA20veF1cxon9Iot6WvrhLLTASv/+xiOsG+sCtwh2qzGIsqvi53eu4YirOgSOuQGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=idxy5bdW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="idxy5bdW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NJ4qcc3514965;
	Fri, 24 Apr 2026 09:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5Z+IcA+wgQgfLjrABjUdZIUTQa/L6I9t9shLlrmRc
	lA=; b=idxy5bdWMC+9p2E+Sdv2+9tP3/aTxR3UwikISKb8MvTsO2wsg5/b/kFKE
	ZyyrwR3hEfkyXORuJTTVCiLdTfmzmjoaPbK9JR/FJuVdeMtbGiv4cNGoV/4ef6RA
	0isaksGSHYpBHgOUGiHbg+B2h+tFGItaZ/O7ScsF3P5ZvnpphQgx3iY91rn5AsIt
	w/gF27aVOyTsccElWEYXlYjGa2WITVp3sqKFXEc8nHxuE+pK8MzxXN9Htg0A5GMj
	dum3OaqvUk1N2ntP0NC/dFYOcWvlYTRdUboylRiMlxW2P+Q6aCFtqPlVxdkHWX+R
	NOdvXKOYk6ceHW/gmTECmUBlCQ0iQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2d3t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 09:26:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O9KMm7005825;
	Fri, 24 Apr 2026 09:26:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky26kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 09:26:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O9Q4JJ52429208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 09:26:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998BA2004D;
	Fri, 24 Apr 2026 09:26:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5967720040;
	Fri, 24 Apr 2026 09:26:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.77.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 09:26:02 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for tracing exits
Date: Fri, 24 Apr 2026 14:55:55 +0530
Message-ID: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NiBTYWx0ZWRfX/8u8Wq8WJHyV
 2M2XPrpWTJRReyRDzVgmBt0TTsUyb39hfiSMqeSWzNNZZ4dlUcuEUDHq2u69k0gXKBsGg4AqKvs
 8laECAH0iux1Dbwmj/pNuG0Mkm2vSq7qkdnh/EwgxPhgRfHXgIpCj1r7l9IO4tmN6V7HV5bjylu
 iLk3XESM3+HfOVJtIjG1qpGRT0bTfURNtjsQlynGsQyIoqe5rH8zq+/yowrnKtLt5YYaHUZ6LjW
 IvyqZvnwgRZ5D3KE1M1Eljqqj/NVhQjnt92qPAiYZDFl1CuzsmpZf6YZZ2CAAkvoPaT0WUp+kaM
 ECjmNECvFOhBMpq1PXLlfIruX51pBTys8mmXFBDeYogOv18iO4C3rlnmruZ4I3NrnTRxihxXYpD
 MB0lnZZQQFm+6GOsAohd+JRqhcNOPiPJ+lmOBVf7ysZeQzp6ysWQGNYRNbaKX6zToGwTHqQIjli
 8RjX5LPsDIGWFOSJnFg==
X-Proofpoint-ORIG-GUID: o7uEaCyfViQqFKy7o4knqUKzxo38Z72Q
X-Proofpoint-GUID: cBRmFAgo3auae0Kg-O3dNlC0_UqYGQdj
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eb3731 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HaZPnmESgsJLTL5AR_AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240086

From: Gautam Menghani <gautam@linux.ibm.com>

The macro kvm_trace_symbol_exit is used for providing the mappings
for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
trap reason is displayed as string instead of a vector number when using
the kvm_guest_exit tracepoint.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/trace_book3s.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index 9260ddbd557f..eafbaeb5a9db 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -28,6 +28,7 @@
 	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"},
 
 #endif
-- 
2.52.0

