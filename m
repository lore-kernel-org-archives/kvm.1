Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682696;
	b=pMZrsd+s7z33CvdhyxYaif6i1ObR2CcVLBrJcfuJzjyGGsgOizYWWocOpswa/9DLxbi3
	 Ja8A6uf8XA4xUCpst4IOqWlj5xht5fqa3hT0Oj0Fk3sSBlHjH4trzn5m6e/kbz2x17Zg1
	 vubrpus5ZdPNjIiyiQdil1pUduiDJU22R544vocjwZu2K4OqAmNsLTfOD7s7JDKguRLgD
	 9b9NTryxLUotGXN0LKTy6bhbN1qZRnllxFnxjj9uWQCavU70tp9/6b77W0f+njNNehQkc
	 eiAO2zhe2i4kb9LQz1d1MC1+LWO85yEeoDBSZ+djAGyZaKeEenrQoLZLgy+BMA2lm/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682696;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cbifB8fuc30PkqRHHmUwpEMqOf54sxwJdMhH+DVQhi4=;
	b=E1mCpOtEM310joa5090OgC+hEGQm/tH/cjTK/oSJjkdBwAP/ckAIp/wJ9d+jJwooffsy
	 BKotxsIes34sYe9aTx4CtkKjOlhQphwU3s3s2cJnhxwaCrBAylJ9Gj4K8Bz1LUkVgJ1d5
	 xPRQ4ihyAW1640TdLPUUwP92Zvx5fdN0e2YG8P9axvLD7tEvLxFO24mtnfD1+06U4aYFR
	 h+4cXT8tlB3eKdxt4GRFRmcj8Xnk5ws0wW0xaevjACKWPA0ZQhEZqPir3qecbDwUQu074
	 S/LJbjSspbmXrj9X6HeXdO9adGGJRy/r7W8lqzVF19SIzoTgThNVHxZWf2LVMN1b1cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvgzvCWI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A651606A31C;
	Thu, 26 Nov 2026 08:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A651606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvgzvCWI
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YsN13849127;
	Thu, 26 Nov 2026 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cbifB8fuc30PkqRHHmUwpEMqOf54sxwJdMhH+DVQh
	i4=; b=DvgzvCWIqZ/Yvxl1QJ2TgCWjKPjICSW46ncV9fPhjyxiMsDAm+k1GkerU
	LFMIm20b2qy3CZP3X+cimKKptRaxy76xbOLZk9JfHPLrGFbmD1WmGI0BLovFkyoX
	6Gj5ESGp0CsSTcFSl9rNhnDxtNzcE/SpXqTAHYT4YqtbT3uEx2FOcXllVAdQz+W+
	/PnKJqlCodMzAatGPWdWgsFovyln0QMSFb/bX2mEZenIUW85u4+8G+4FhZM9ejU4
	QmeFtI7X8iPv+PLHBVotsVD2Il35kuiA1iXJGSLuQwAChedqSYTfqRVrqLF96f5B
	tqtzLtRhQCVRTV2RYGWoAVi7yDSgQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fagh21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:44:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JSq61900574;
	Thu, 26 Nov 2026 08:44:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axky8nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:44:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8iPmv29426272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:44:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E91D2004D;
	Thu, 26 Nov 2026 08:44:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF13420040;
	Thu, 26 Nov 2026 08:44:22 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:44:22 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        linux-kernel@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v2 0/3] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
Date: Thu, 26 Nov 2026 14:13:52 +0530
Message-ID: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX+Gqu5TIvmIHq
 wYmpX5QaczZ4nQPKNhtaI5wSL5eTrsGIEtq8T4nKZN5VtLV6GMSSTrPNsNx6G8TwEsCKal6V6vj
 e7D/JBsyP7+hD0DgZ2fJwTPmRWF8jXhKyLobr034+xZmncMNDbhYhtHR4U2JBxIywapWKXm6K8/
 ySqlcGMpsWiH7mLr5Z4RXjhUtRFlQIusFbfH6pTAbSIa6tqlhu52JCZNUrBXPgdxAGdTRLrr7K6
 UfltGHbzlT2UCkGW33fEJ1aooZSflwZD2KhJcLBMBJleD8eZfk4qPDrVmZ+zSe8Q/sSu8TyzSkH
 YWzdVEeRRjBIFhfuEhDsuLZutlI7G/Q3POO/ZmE8NlL6cdhhNZK4oNa6ow1z+czuIgcIA3MFDao
 oR94N7W+ura0DsPxk4tsgy4sKj+3cQTyK9g931F2Pma63ICl/Vf8wuFo140cdv6XVN4/7sMn93M
 GXZvrWqtCrNVUd9zrQA==
X-Proofpoint-ORIG-GUID: uNuE4I_lUnExa2iZYZi38qLpH2BNBbTt
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b07f16e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1MgcrAwz64_Jl8qLJtcA:9
X-Proofpoint-GUID: 4EmihsMDuGt5CGMz5zXcXUnD7skmR9eB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX4n+Q2jaG4HQb
 z5Zk8TY9R1eHMyh3z2hvkYEj4crjnPf/TExA/bCjR8JPrI9OPdVIHJvfW8QB6PpPUg2yRhHPRZq
 PCzWj6PVv+H3nH9LpfCyIzjd6+lDK8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260033

The sPAPR TCE hypercalls run in preemptible virtual mode and may race
with concurrent TCE table fd release or VFIO IOMMU group detachment.

This series addresses the parent TCE table lifetime, synchronizes IOMMU
table access with detach, and ensures safe child-table reclamation.

Changes log:
v1:
  - Revisited the Fixes tag for IOMMU table traversal and 
    used 121f80ba68f1.(Ritesh Harjani) 
  - Added parent TCE table reference counting and SRCU
    synchronization with fd release.
  - Added SRCU-protected child-table traversal and synchronization
    with VFIO detach.
  - Added SRCU-aware reclamation to prevent child-table
    use-after-free.
  - The partial IOMMU mapping rollback issue will be addressed
    in a separate follow-up patch.(Sashiko Review)

Narayana Murty N (3):
  KVM: PPC: Book3S: Hold a reference to sPAPR TCE tables during hcalls
  KVM: PPC: Book3S: Synchronize TCE hcalls with IOMMU table detach
  KVM: PPC: Book3S: Free child IOMMU tables after an SRCU grace period

 arch/powerpc/include/asm/kvm_host.h |   2 +
 arch/powerpc/kvm/book3s_64_vio.c    | 179 +++++++++++++++++++++-------
 2 files changed, 141 insertions(+), 40 deletions(-)

-- 
2.54.0

