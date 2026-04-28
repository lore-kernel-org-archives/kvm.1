Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE738B135;
	Tue, 28 Apr 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365960; cv=none; b=OrploAVBf5tSEEx5e2SKtN8ServPc5gIzuF4DmkAWo2iayvHHMlI7tXEJZlxOoRo979nbgMSrqjG6OaqGeN8mVg6IBlhPAo7p+EI8BAcumY3NzeAB+mb2HWRNlonEsHK0IFM/q5VDBwkcnLZ+0B4u/2U0au6nW6TCI0KUJQ3kIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365960; c=relaxed/simple;
	bh=+x8VFvKHNANBfKWrQINkGF41dP799tccJPZccINN00s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niw4cgjf/1ebmFWsh+WCnOiorzBtCGQc2ZTPTZLS6pzZ6lJaziMbSqCsaTlb5CkKF1u3o9ggpAEhi9JOpNZjx27aXKcp9/deNuDHkwuuJhncSRZaQeoroTKdLebd9rfGumhyN2DPAcurGz5Nh+jeamvocz7+APDyomWlqaZbX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2mLWQrx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2mLWQrx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6cRlH3060766;
	Tue, 28 Apr 2026 08:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2oM9ZUK8Yw9T0FTGW9SPFwR/OUqAGn0tAJHGRHZ4m
	IY=; b=s2mLWQrxvYSp90wbsZbLQrxyd2RtnKwrWcmLalOU/xB6YvlG/5qo6dHEg
	2nOGZmtVc1s9bgH0XT0gS0wT+8RMHeKu123aIO8axfPBuUVotQrdiYEyEzaY9VgS
	Cyg9WXi/rVLqjUzn66/1syEh/qzB16u4x7jSGFrS+gXxXM2jMtnqrsPfFki/DpBR
	FLXveHHBv1x5tSUmPrZP7SqH0z7Ld4Y0XO4lIS6cldpoisKVWAqtrYMOH7BQ+/1I
	mT4NKle4hcYf+HCnsh9PglJBfCElu0ecx5OdfMkLMfabEa1/H2ActKUG1m2AzeeD
	Zc36dpU85hUyp0MrdKgSo/24NstNA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r4hrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:45:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S8cwxp028537;
	Tue, 28 Apr 2026 08:45:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk0w1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:45:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8jd9i47120676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:45:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC6E20049;
	Tue, 28 Apr 2026 08:45:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8307A20040;
	Tue, 28 Apr 2026 08:45:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.36.19])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:45:37 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for tracing exits
Date: Tue, 28 Apr 2026 14:15:33 +0530
Message-ID: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
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
X-Proofpoint-GUID: Qow9ZXYMgiiZmAeXIL36goCJmfQgFKS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3NiBTYWx0ZWRfXxCqLGLxKdCn/
 tBi7hLt3YR8B3PDSpCE3QTYNaa3a88x0ndo7lSFzAoD8YO1oeVc2/hKDrbkn2knv6yrc9gjumtW
 aDTgtbeixvgXnxiyLlJdmMpXmhO/M3veC6UrBU1elj56jEoztO0afqOWXUoEuALA6D1LFjrAIOE
 0QXy9n1+6w5z78GZ4zc3rB+S44nBqClFA6HZQCHilffKsbUoPqjOAQ8BZfJGiKxxJM2FoKzxPpM
 5ylp9lslUH+35lUF3I+TNUZ8l50rsZ8csC4qLaDTFdp3yjZintTCl76XP0n8WtNXRmE9QrQXR+/
 d9aRWbqnSawByR9MAo9D0gKh/fNEME+sDGfD+51eIYSyF4T6dNbqGYBnyjqYYZscYA9jKuTERg6
 PWXkekVO0xGWVbXZ/C4mogEHTrLYU6oEq7PN/uKwEigSzJ7jiQF27jevdRVrsj7Wedx77HRCAeV
 Nm3R8p5QXHKzeV1UHmA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f073b8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=HaZPnmESgsJLTL5AR_AA:9
X-Proofpoint-ORIG-GUID: cMAJkuGQsHnZrBxSyViz107S60p7Mqxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280076

From: Gautam Menghani <gautam@linux.ibm.com>

The macro kvm_trace_symbol_exit is used for providing the mappings
for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
trap reason is displayed as string instead of a vector number when using
the kvm_guest_exit tracepoint.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Remove the trailing comma after last element

 arch/powerpc/kvm/trace_book3s.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index 9260ddbd557f..5d272c115331 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -28,6 +28,7 @@
 	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.52.0

