Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979123;
	b=ZQG7ENDF4fyydSN6ULu7vMcuBJ/ihbeC2U1msw7IyyH283pyf6G5hZfhtf5HR6eHmmWR
	 vNJEBtfT8Y8d6LVZLhvgxfyqd4sloHO2HWpbqfxv1hVQJ4jpwkXpvuy15hF37Q5szZyp1
	 5tfHhIQfRYzjAm0gOCsyRr6XhEBZBSrWxryLKMczrXXW9LIygzs4xRGdsA7GcwtMtj4YX
	 MJrTE73nefy8JCTnUlC/1VaD6fC5gnrFTx2uXk40mkBjOMeNCLNhH73szieh0e0ildN/Q
	 1GZRfEpnZH+RH+/0hg/SJKw1NxdLfsSeuYXaeuEzY0zPtbHl7tSjN4CTLRhXWB+qsyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979123;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=McD/94Qfb8FbdIRAdUd++77esqMBZsPQyz03PBXRHL4=;
	b=QjkMdcQWY8NIUh1ZkrX6OVzkXEWPENyEcAtgZ+baZREpZGTH50AllxPzEoZm1xuiVWCE
	 3727v2BRMDU/a91bpcGSjgD2hrqsBDpzN2aZN38F6oAOXz+mvlfqWToCUQabeGh0Vdq/G
	 K41MFIlErHmqKOoPzPangJC3GZ/FXbg9OEmsZZDc3NXJh12YxtfM/xVICvgK1oX7jVQgd
	 k6mCftNe8swscOqG2TULMFlYUvyI6ZBHXUY8mxFXGei3FrJOv13dcdUwgdh3WVk7iBPe2
	 bke+Zg/Qf2ck37fYeG71JWkPpkHsiSmDEvqkcZwbHgZqqkjqUHUuG4LF+VRPHMQvdXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="ocVt/e7D";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF37606A326;
	Fri,  6 Nov 2026 15:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF37606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ocVt/e7D
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEKLJ2656486;
	Fri, 6 Nov 2026 15:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=McD/94Qfb8FbdIRAdUd++77esqMBZsPQyz03PBXRH
	L4=; b=ocVt/e7DlaQj1viqr5vF57rEPMme49JZ49QSzeQqOf81Wt9SCWIWZcaRw
	MnrCQNkQuMFwkHmi049Wj3GsA9RsmjXwUjCvzfcjx74kBb8JKtuOSSqSLe+ykrMu
	c2aP2LnR+ZjbHiIPNIrXp/HJ579eZsews7lxsy99KAepNIlaDCmROZpBm8EVbeei
	RAU2IzlVDHmWQop0Eu42aJsdrGFpS9NZK3h9h7YhQsKkE4E5zo/FRVdo1zAHWeOa
	WgMTF3uozW+DyEDnAmaCwmlWkXTGmqOeZVeiG/SmY0Bzwdbc2SglnSiYE1IWUx3r
	uOP9d7viJwyh6Hl+opsqgjxNc2SnQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc565t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK94o3577951;
	Fri, 6 Nov 2026 15:31:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v7yc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:31:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FVgAr56033718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:31:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 861F020063;
	Fri,  6 Nov 2026 15:31:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155E02005A;
	Fri,  6 Nov 2026 15:31:40 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.29.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:31:39 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        atrajeev@linux.ibm.com, tshah@linux.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] powerpc/perf: Fix vpa-pmu driver to report correct numbers
Date: Fri,  6 Nov 2026 21:01:31 +0530
Message-ID: <20261106153136.330165-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX6ZVdLCTgEOnB
 7a2ZhXbxKLpCkVdy/WIGqsneso5V6xU0tYeUVKbVCzS0/eSMtxqe9WOc58GpTntZ7mwkO3S6rlE
 cYE4WG3aNsI+WrmUpAbft7Sx84ITejI=
X-Proofpoint-GUID: ZXkr24dVxlue3lFuDPzDe9GJ_698cUWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX9Sfk1KWupinf
 g2dpgDk76q20uQKIL9un4fjYguFvdZcCk9aPDqE3fo0ZHpXUeEeoD47i9y18So8Z08kYYU7yhOU
 689hiwJft57CsGOKJbkZ54UHAWuHL1jHZ5ahYcrapA2NdYzgmROMdq4F13ZQ+iKP6Szhe8eAWiQ
 FMiJHFP75LNuQTfbzxT9tiHNTq5B+YGywMRGXnggPzjl8vme/KSN1nkHI1ljTjqcEmttHxpf8nr
 x25NiU6d2jhbo680b85YGeMx4nL+WmJoWvpRbswdS3WME8Nk1l9K5T2qAokk8R3n02eNB73db9Y
 WOayU4O3rQuz84DdvPUkF2cYdbF16GJEiNSc1sCNWfVL2W32EXaX89xXwt/yBmIkuRcqKru6kPL
 SdMtG0aOpUIgNBKEiWav/86Dzo1SaNS2pPfyKzX3rOMLHW/y3WdJZ0R+ZQ8A/yVVes1WbYTkyhL
 R7HAEkWlpHRGLpdyhag==
X-Proofpoint-ORIG-GUID: TYM7-z7ONl445plmQtla8OWbCb5rRkUg
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedf2e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=aSoOVV5oyB5p4QsdXGgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

The vpa-pmu driver can sometimes report incorrect context switch latency
numbers:

$ perf stat -e vpa_pmu/l1_to_l2_lat/  --tid=2061  -I 1000
           time             counts unit events
     1.001022517 18,446,744,073,708,177,408      vpa_pmu/l1_to_l2_lat/
     2.002120674            345,092      vpa_pmu/l1_to_l2_lat/
     3.003171582            406,342      vpa_pmu/l1_to_l2_lat/
     4.004234838            340,836      vpa_pmu/l1_to_l2_lat/

These invalid numbers are observed because of 2 issues:

1. The PACA never points to the correct vCPU running on a host vCPU when
vpa_pmu_add() is called.

2. When get_counter_data() reads the PACA counter values, it does not
update the event->hw.prev_count.


Changes in V3:
1. Drop the usage of the PACA's vCPU pointer.
2. Introduce a new patch to fix an issue seen when a tracepoint and vpa-pmu
driver concurrently enable/disable access to latency counters in VPA.


Gautam Menghani (3):
  Revert "powerpc/perf: Add per-task/process monitoring to vpa_pmu
    driver"
  powerpc/perf: Update prev_count of event to get accurate values
  KVM: PPC: Book3s HV: Ensure reliable usage of latency counters

 arch/powerpc/include/asm/kvm_book3s_64.h |  3 --
 arch/powerpc/kvm/book3s_hv.c             | 54 +++---------------------
 arch/powerpc/perf/vpa-pmu.c              | 16 ++-----
 3 files changed, 11 insertions(+), 62 deletions(-)

-- 
2.56.0

