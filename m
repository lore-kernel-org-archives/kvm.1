Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56017DFE7
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331284; cv=none; b=DtDt4R83mtXFYuBuEG2Te3i1ySjCMKjybazKsyjK390qjy8yDzUE4gK7yZsVAyZRbi4EZeoLShVAU3UB5U4CvL7XZ11eqjRA3Tnmc6r+OLT7+Q2HlPke3LMgNjDtNMRDqmwoVTnFkQlgZvThzLT3nfbfGKmxw3PelmSUXqwychQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331284; c=relaxed/simple;
	bh=anjC5YPqeMIM8QG0W71R5B8c1T+6vdn1q9ywPyHqFKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeSqZFix3ZbboBp+JlFbRaR4q4F+pE5RHVkJTkz7RbHdR4d8ai7WXlF/jTndxl66ZQK6UyivCAKjIn6r7leDuMWH651pXgFmP/uQBvWMwq7eAcn/Yf5cyCNcMwKxbvoN7FALHyTTq1/+vAeEF7wxEkis6YZkkM5HlVXjoNdBoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X/dbDc/R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X/dbDc/R"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmHve2205941;
	Wed, 24 Jun 2026 20:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s6WlORJYVYHHQ7R3w
	RMPn4PNsTwuPA9cmF8IlG+FSAc=; b=X/dbDc/RUOL9otWtfHrkBIon8gs20GESe
	sMXe6P13cqQI/CKPo8Ql+Ijdq7MDNBmDmW4Vf49j/qzorPcg+t+nBCMw1VdWTPug
	XH/sh0bY0+Vh4z+UPRY+plBM5AYHin/Wo9uZWAOvSSanUg4Q05OcwgmsXy3DT96D
	5wbPGm8pa2p274Q+GAAV479VQdO+bsj5N2uMlWvhFJoLrtkmMhk0uvDHGyj/KCsQ
	qA8ccUBU15M6xt6nO8oQy5xusFVJWaE82W8SUsWqC8xjim6sfla7Vs/WFNid58J+
	gUUUTCrezRM4iJicKyMPM0ZTDKTtzsyLH8bTPrSfso1+6l0pXXbMQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqx5dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJo3mI013295;
	Wed, 24 Jun 2026 20:00:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwjnbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OK0s8D49283362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 20:00:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 935352004B;
	Wed, 24 Jun 2026 20:00:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A2F420040;
	Wed, 24 Jun 2026 20:00:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.20.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 20:00:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Thu, 25 Jun 2026 01:29:24 +0530
Message-ID: <20260624195924.1422821-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624195924.1422821-1-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3c377c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX8Qse/Tk2o475
 bMasiUYNcbl0oCuEShjPvMl/37wQOV+uhhJzDiXD0ykyn4/oMbydSiFIpzo/H5+ZC9uJezoBsCC
 EzSppfzrO314Xat9OzwvoM6WrCZRFM6Xvu+knSZ6s+EblCBSMq0K2Yxy86x21oCoNLiDCqWNwqN
 JJczb2cokVAWeMb9EYRowUOV4Lr98cmTPCRk/AWpziZx/HEObaJZKYwEhEILntXzqn4ppKzK2T2
 wc0V7skeu2i4zRXKcXn2Sb+WZTYPjA18b2pEHqisYCJPZbQ0GHSna/qDLsGKmnq3wsIFu4bJy+w
 BhcNDntYVBrNPGmHeL8to2ejpdHyB61xdb3uDIVf++WR4UTIpQCrT/lrdQcyZGr4FwwtzhGCTOb
 wsddUE+bnNUFddHKkWW3XK8L23XzXZDgdPjzVsq04mWwUfKrNWToBjoSWK9IiHqH5ZWjYAdhEc2
 oQAfEOMXg/iIS2FuV4g==
X-Proofpoint-GUID: yWYvhwsprWXvZ-3vWRf74wo-jFQiXiQT
X-Proofpoint-ORIG-GUID: OcD-AaurB38nYnjALB7ghOP9oWaZ3Jbv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfXz9JGvF6rEfFG
 Am2tpaCsIuMLNhR1YPGSnt7NwqPvSw/JX2ReitL8RpV59fXaa9B1j4V8SA350eCPkKARBaQL0JK
 efTxxStlcfxwDCn7i2gbuSWN9B+jv58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240166

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f63..b56f2efb6794 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,7 +1646,7 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.54.0

