Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807D360EC7
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069282; cv=none; b=i6UFlUh8XcElI+8Rf/59fPK5LfQkoHRa3+b8O94YvJ1NQpvtuFol5qRI+6NgH6OkN8F84rQShvs0ih7SEFd6zZR3Xqlk3zEqLGrCOPNP8Ahh53w9IJ1foiTXjsppp6o8SPSU/4X35WgILz7S7oXw7HDEQ1VaRPSZ9XMl/eXE3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069282; c=relaxed/simple;
	bh=ZGefpsQvVVkwzTuqpU+ZrsGbkEpUkRKJ+t8VkPBbSfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+tIANvxaPtOPwG73zzQXQEW1FMiw1et2F0iwtHjy6HDcNikr1C5/LhfP6k/yNYN4agfcM0i6pzTo2f0Y/Za/Ba9xgDDPkq2dDBd+KNqceji1MYv9QUlofB0PHDD550zWOg7cd42d3sckKwM3/zjm0fygyaTKDnMsK8F4H6c7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=axp1B4Qz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="axp1B4Qz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636ISf91761147;
	Fri, 3 Jul 2026 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xiiSZZC3xrwNxKmcB
	bGt8MQheo7KODvs7aC/xlgItzI=; b=axp1B4QzqtGoqeOYnpHK8OOkrjCnTuuEz
	lx40ykj3JWshRRVD5263gMwDnRDoHoBzgX8tuv2AjvO+IP+/1IHeY6zY8cF2mNBD
	8MAVo7sD049QHrOWL2CIeE11TKXBmpWJH6eDuTTSVKsMjRRkqY9gn54zG0BjENI3
	VGE7Xuq33uAKSgAtpOlhOdUDiE8Qj8Eg6HoY6JfPhLC4s28yZ7ZbSihnzMjGtxO8
	QCR5/0Eaw2pZ57F7KGFwGmTBb4rA3Ls96M06LhRFYGyB6O4eBObvv3Vqslce+1/Z
	18r5a7fj9Xt9n7+YxvZa/NlWsluU/sRCfuhVUr6xb1B9joj03OLgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5w5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:01:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638ncci009229;
	Fri, 3 Jul 2026 09:01:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyqsmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:01:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663913i242664394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:01:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D20720043;
	Fri,  3 Jul 2026 09:01:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2789920040;
	Fri,  3 Jul 2026 09:00:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:00:56 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 RESEND 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Fri,  3 Jul 2026 14:29:55 +0530
Message-ID: <20260703085955.2318600-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703085955.2318600-1-adityag@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX35Sp9MeBYcnx
 EdMPufUZ1fS2yzuRW6GmigVqp2xNANVCeVA8WdYfhNCg2IynfXyBT5p980+3VsH3JiCh9I8YfAp
 Xklo1A/lXrDjb5di8bw7SIJRrsFYPqGrYtyMVunbXf2GyCmlORNq5vAi/XdGjrDyI3I6IQoO1LM
 uaM1RJywdcld27uAdnO2TMoOUzws2NUsT8IIj7V4aM5820aPIKf4PXIaODsgl5c0qVz6Yav+A7L
 dQUcFcmYHuJOaf4jR7vqupgjxUyR3ygWCBaPxQIYW4fVxMJgYIN1ZTRv6ehcBeaElpzN5XncraY
 bbnHj/UWUVbI6nhJF3vwsdNFLfrnderLLg9YWtFhP8Mu5ZeNOh3dvH5QgjUYDxNipXqlE7n4SQS
 S6Zh1fIZewXibrJA4GUIhxapxebkrt20oVYKjo7Wc0PvL92Lx/+wjEunf+pUG0BDuZmPdGiZy55
 +Or/TTapmuD72CZWm0A==
X-Proofpoint-GUID: VHJ6FKEB83rwZ0Ec5WBWYTGRlaekagNU
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a477a54 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX7lcQlUBzbiM3
 wx5Ekv/Ql1aTdW+E+w9rc4EzTHAFT0zjihxr8RQyl8lh8bxW4O5BEjeJKQoNKqeELMkkIrmE7xo
 to9LLUoQacvQbU5RsWnzZ9A+kK9Pcos=
X-Proofpoint-ORIG-GUID: UgboorAGuOacQs7AUsk4D_ruekwqJneU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded61..537b5cd895a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,7 +1663,7 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.55.0

