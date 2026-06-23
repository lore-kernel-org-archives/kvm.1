Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F1363C64
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224505; cv=none; b=lvMo1iBnrOXFJ7vadCfrE3zYJRGMQJFWDBXXwTnZBVWkSRggzt3QoFgILZQDSH0FF6Jq1EqmXJdwVG4VbD1WPM/0KyoSR3+i+XN0EEmF3aWBWKFHddG1dvXX9Xp/dDEmYjptLQwJMCldxonTLdSvZJCZFYdMTmbi6uvaPUtXGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224505; c=relaxed/simple;
	bh=o2qY6oIvMX0PVv00Esk7UIXzjO2vsALow8AYrZ2BxE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv4OKClMhrhpt816b358KTfrDeTSYFW7i2SuyimxwDitPh7DH+GM95ZxY1jPxgMF+knbFrUgMRmCCbJPjcJnTyHYjFiBGb7LgIoSlqkSP4hrUi+SWxYeQg7aac9C84/5J1FC4O2QEuiaKaeE6p/BvRcNOMbBtWtphI4GSonPPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MxsqKRpZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MxsqKRpZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmlHO1858081;
	Tue, 23 Jun 2026 14:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Q5lITYwff7C+vA6y
	WF3u7xIjdqUjtMgNUMvHZ6T6G8=; b=MxsqKRpZR6lFzWERxH1JPXT7eOezvCksK
	70R3dZiO68uErO+NHJnwPuUhBjXpgIyZ1nU5EvdNUWFfipZXYURY1KzwkSAxaZWF
	ftTLlSDfyqVtH4DWy6cX1kWyCsg7g1/O77OhPmIK53Vb1Tm+r5iSWXSvzrgJCN+u
	A5cU5xmXUU2yPjuzXPu26mKLdXtiRFRJ6NsMBPkMygF4t8JVh7fXMdGHmcge/UV1
	jNvb/605BPc5rxe0dELgv/rjTtkANYVH6Y6pVLXBXcioaR0oJncvifbfnkrolDfE
	umI2yLrq5QLci9aguhGLY7/JLdgePoyHBAyvzdDZxm83+ABuSVwUw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJexw005046;
	Tue, 23 Jun 2026 14:21:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykbkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NELTlE27853312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:21:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7039A20040;
	Tue, 23 Jun 2026 14:21:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 270522004B;
	Tue, 23 Jun 2026 14:21:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:21:19 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
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
Subject: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Tue, 23 Jun 2026 19:49:33 +0530
Message-ID: <20260623141933.577981-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KMWi70rAGIbYUS1g8iCXQw3Eg2u-osBu
X-Proofpoint-GUID: dGMcB4qe3UsTZ1E1dY1Zz_LOvrIsfTME
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a966e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX7UznYGksmktc
 +NV6bkB8xKUAoVbglGrxOMJsgmEjxNGo5w54llZ8Le/0zTDddCEByA+3Zk8V6Eud2OCyLyBZaMd
 Ivpvdg4Uk79KyqnshNXA4gaUGGgmp9TLoly/CnwADB7jFmD6y2Rrve0BG5b0/JorAyX/+rEq9y3
 6YtC8yFh5/ALvYEcJCH0k+zI4TXIcSVunx3n7v2lmhfyWeh+gZJWj0at1qpAh/PdE8f5e+eqkK+
 4ENgg7+VcBRJCn5rQxOhIYspTy7XEKFfIIDpM2XULabesxTSw8XNIYeVPBfYuTG6PiA/OtqnzHp
 k57YmJ1R9UKVDW51PmxmC7ddNE8bViVdKEmoWj9+5JiLYirc21n3fHav27o0CwKDkEcxEvBg/Be
 lhQgum8xPo9bgakq+BCmgDQAm9i31av7FJrAvT/mEMyqjZ/rlQ+cN8rl/+Ya5PuUSLkOjWzIlFk
 G3n/yTSAn/u7eVoVx3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX6nwz2R7F5uYh
 kKKqdZCH5/p7vAWJ+jaDlIUjbUj33kd5k4DgWyCar3w1kbPtugnxRQt5gdSJGKqhue1PEglodKa
 qUr9QjUa0BFZf6/h5mCK1ZBT2IHgdpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f63..67f65bff3913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
+G: @adi-g15-ibm
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.54.0

