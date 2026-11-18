Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966310;
	b=nIpU6sF6VfU6cYxaWKq2RXcaTHmuC7gaEThleY0x0sFV8E39OvC2JWLxRNJ6zTGD6p9o
	 I5ESUqUwJhLIDFfNN8jzvp1e2s/FCCP1cXH+Fx8HS5g6Lw4nApuX3gH4LZQAgruKCCD58
	 VZGAK6XaP2zkQQ4QUydCPbHHgfJCk/IMn8ktuGZqBlrG1stZttw7LQwbo6RhRUDuvxsOm
	 C5viSHeGjnWHVK5FFS4ucs5ivhEbRy3QpmhdKvbT6OgIqshxzWdTzPQJp9hxBQtqcVNas
	 UqjnJQhbyV6O/BYGS2LHtvvd3HlWq64ftrFFD8JpxQ3HBPjWok8PK1vK0JjkTWh8Ldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966310;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wBd3abtayDCX1/scCG//Fqe+VkHX8eEt4tUfkgwFGdg=;
	b=WG5l5H9cSPgIivH7zraAsGtz9DxXqW9ekHKx1IhfEvVKy5EYsUKo6jCfeeAWLzDo+Kwj
	 zZ9N9uOFZVzq2sKCMXDbuHJg6st3MytixpFqSLdJ+sLJvERaMGpQfjad99/S0oAHtcyP0
	 FbPmNpsXKQkdv0ekvFtm4HqT/q3fflr7LrZagbx0NkBum+299hZaFbM4obH2Ky6T1Btss
	 O+/4i8HA0mcSoEF6JKnJ2tZmEuTcH/PH6cb2pj7ziENWPQysr98pU86pWnCMLa74jvIig
	 cvBjzB/r22BOFA0R/EFgsaqbvAYdknIM6+cE57P84JXgK6UWmh894TBfFyuvHrpge1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlpmpBsg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D6606A325;
	Wed, 18 Nov 2026 01:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 540D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SlpmpBsg
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMvDSa3659438;
	Wed, 18 Nov 2026 01:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wBd3ab
	tayDCX1/scCG//Fqe+VkHX8eEt4tUfkgwFGdg=; b=SlpmpBsg/gInCg02C37n6B
	miSaDp44za3T0lTDZ4oCrZDaKcAAM9hlXeLAIEqBQSPTxFR9mVL5z97iFnxkTQan
	y3g0U/fv35QKpMu+xtf197CPjDmnZlLAqaK+njQmcMrq8wmfqLmeHx8tfbV2mtb4
	LC535umW7wCO9gCo2Yj49FdK8Sk8fNRH7+qeLWB/XW22ubkEZdqf9wpeftw8810R
	ioNAu07LGSyJZ/rUP4iZZ5i5CSGrZAuNt3cu/JlyTFBgSxOdVUUDynqP5V6ZMrpB
	oI2tlFwKOYgnYpBsxhegiNeBiaZf93T/aBA6jk8AcWNpxxUw3K+aGX82G+99agpA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vgcun-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMnxQJ1188940;
	Wed, 18 Nov 2026 01:44:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dffbp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1ipRK49611238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96172004B;
	Wed, 18 Nov 2026 01:44:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD73020040;
	Wed, 18 Nov 2026 01:44:48 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:48 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        sshegde@linux.ibm.com, amachhiw@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Fixes for KVM HV around synchronization and initializations
Date: Wed, 18 Nov 2026 07:14:47 +0530
Message-ID: <179496619897.633156.4329278378485966847.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1IopNUmBuvQVeVZide_RQgkxDjw0FsYq
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd0318 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=lk0zUodt4WDNUAK1QE4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: SzGNbwTHxbfT4gIPHJi6y05jDKmhSnmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX8ji+SSuEbngW
 3YVGTquMp+d2dn3dVz55WZUXlM0OEJ4e4CvKapJMXAEgrMOfPfdVJIRKF5IpBDn0a3X9BKp32TT
 EBKA76acqerEIjDV66GD/m4qOUHwqyCzJdDekCOZq/5JQM2+1Cx+XOCDaQFf0dssOTQx8bvUt/j
 JezHs4B4mmZBjwi2pKOl6zRDszsOdjSBBuDjsTR6Fsbt26ktT7YPmxu5k4BB1n5F7fhu1sxYdt0
 tKQzp2T7KZ/6BhMvlf1cxOsH01wjEkUutsMG6J2+6ayxvdlAJv0M6kzRfyy4vHz9P5xwjffwrkN
 n2E2W6QMHc13rIkypiHAt1H8NHXyJbVE9ej7vc8JoBhezt2/avwYL8rAt3NfhAHq/05uRQEjjSn
 RYPeZTDMbPXk0xqB6QTkJm2MmCHA/N/g8msJ1B13V8+bgL7mv7RHJaFYNuVQyDB49KkpUS2iSMD
 V5qBpk3HnKJUA9OdOhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX7wnjgTJvWwyr
 Kc5pDIfcixMjXrq/HpvKLjm4gVDqWvUAhWTBiiJ7mSd9t6rtTGq7yCRhQTr//or8ngnwPR6vlzV
 A+CCP0pob9HThS+EsxhGI2gr2K5NQXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005

On Mon, 12 Oct 2026 13:59:16 +0530, Gautam Menghani wrote:
> This series contains the fixes for synchronization and initializations
> bugs in the KVM HV code.
> 
> Patch 1: Fix for concurrent calls to idr_alloc
> 
> Patch 2: Initialize the arch.irq_type correctly for cleanup to work
> 
> [...]

Applied to powerpc/fixes.

[1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
      https://git.kernel.org/powerpc/c/d8c6ab0aeeca7cc2adfcf0ce1f796c6a86314ec0
[2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
      https://git.kernel.org/powerpc/c/b9d9a8741752c5b42c65b1c8dffba867889b74e5
[3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
      https://git.kernel.org/powerpc/c/7279692d70f3e399b3dd2d07ffa365e9f533761f
[4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
      https://git.kernel.org/powerpc/c/b04be22bf6ea06b92bff7850328a8057b8d964ae

cheers
