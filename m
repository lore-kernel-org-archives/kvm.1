Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5A49D59E;
	Fri,  9 Oct 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549067; cv=none; b=hOcNP4IeFbFYkEx2885/u2rWwOspTAEGQLUjJl3OgyNea4eaYK9hj5xJCWAeC8zzWx3IEL3QFnl91ZzPzM49n1miHqPGK6BsgBlN31zuzCExVSPDXgPVfkdIFBOo8Ei9DsUFl0lZx7lTgMWGE1w8BF7AO+3ahyF/DyLZAZoL6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549067; c=relaxed/simple;
	bh=qmo1pdq1msZ7h0FHlQk9nYSbAoOmzuftagN6+2GMrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlxp9npMSQ9qrOGmA/Dro3ESaUNB3v5PLyaaHap0+H1Z901OpU11KsFXIZZdRYyYbl2L3uNOTF9aVAkqYBRNw2YV9Zie6mMfUrxgy2/O7dP7EG5xqU6JhGmguTs0XO2jix5lbqENOE9xCcmzx++VNfMj2T4TDADoEezgeAhhUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AASq1Mtb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AASq1Mtb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZUbv3666265;
	Fri, 9 Oct 2026 12:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=se1fv/0zrPyOXWXtWvXAy03KKez6Xd0Xw9Bw4k4HA
	jQ=; b=AASq1Mtb6RgpATjFFdBz4HoQ7WJEDkrCpfKcOuOky8UJzTG2ap829znVc
	OFprN0fs+/YTR7DmnYwbaGEQtLrad/XiWNoaeE+m4CEG3LmaqNEoJOyppUODD8P7
	QElUmLGmFveZ8vihjcNJ99KiZt27iw8h3gPptzGE+kuV2x0J55GkXFpnu/Y5fMMy
	a9rz+4AEi07Akqgi3LF3kLJVJYabkl7/Z3WQ6DHp1f1M6S8Fur2PP5G6k6kU0OmD
	/tqP6e/8UvtJf4sDcZRK0Hk9yYNdxLUSkxTEKA274RZj+/FUTIbMa76IYH8kJvQ8
	8DpaWPNZxDzGUYZw5o9IFsqld9SUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw9wx0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999sSlQ724275;
	Fri, 9 Oct 2026 12:30:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y8gpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CUhGm17826052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:30:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0A920040;
	Fri,  9 Oct 2026 12:30:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 851DE2004B;
	Fri,  9 Oct 2026 12:30:40 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:30:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Fixes for KVM HV around synchronization and initializations
Date: Fri,  9 Oct 2026 18:00:29 +0530
Message-ID: <20261009123035.157770-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX2BAg0WJBSOSp
 /b9G67FepRJqpKcnUOzQgnBVS2jDliPMZiNTVM81PBNsf+JtzH9BnswhJ+QvqBR1LJ5qJOq78YC
 LU+99sV0R89eybH7FDIdvu8hybx/zi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX53FcjSiun0+W
 ai/sA29Wu5JXp9fF11pgR5I5z/OL/dHQbxEST0MvXGF81Wu7lNBNfhsb2Vrt1zGn3fY450hEkdQ
 xXgYtTLkYncqYO3Ft5l2C39bvZUyt9adWATwffKtDCH6bCTD4mTgYmcxgPMgDwCcqeID50bZT+m
 NVtQ+qnkbDCssNF7s+Ov8vguIbrmY6w5MQOEBmC77V2jaY1Iz1/FhPbYP7dpZGIXQ6ybFVvxIKe
 nivQOmX1b4PjPt6eJY8ALP7uRnYyEoDio8BLRhGL6Y/n3ri1bhu3KV1Yi/Cn34ATVCdpRrIlAYB
 1WkFckIp3GVu9d3517QEw5wHpdEtH2x/f3Kd2/rNIaEPZgYrJiu1S+eAFH2PbT7yVE3ePgJlCsY
 euFADd+u9p4r9gBe4A/uKBO8c2dEsETcpxn4tfdUgxq/0sxwf3CMritHyBW9K0OEPpxdhyuKWBP
 nBp0H2D/TAhd8zuZNwA==
X-Proofpoint-GUID: s7n4stqpeOyKnC2vdPMLbwJgZwd-PuZ6
X-Proofpoint-ORIG-GUID: 5vPQOMual2lPFAUoaZ60g1h8UxgOaoes
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac8de7a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3shF3zVF4xkQSgwXEr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090048

This series contains the fixes for synchronization and initializations
bugs in the KVM HV code.

Patch 1: Fix for concurrent calls to idr_alloc

Patch 2: Initialize the arch.irq_type correctly for cleanup to work

Patch 3: In the cleanup function, add a check to avoid NULL ptr
dereference.

Patch 4: Add a srcu lock to fix "suspicious usage of
         rcu_dereference_check" usage.

v1 -> v2:
1. Avoid NULL pointer dereference when calling
kvmppc_xive_cleanup_vcpu(). Split this in a separate patch (patch 3)

Gautam Menghani (4):
  KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
  KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
  KVM: PPC: Book3S HV: XICS: Avoid masking VP IPI on init failure
  KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init()
    call

 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 arch/powerpc/kvm/book3s_xive.c      |  5 +++--
 3 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.55.0

