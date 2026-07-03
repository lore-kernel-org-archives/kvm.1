Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0938A702
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069261; cv=none; b=uCe9+clTGN6R/PWETk7pZAB7/p0uD26SfymehJzn5zk3iAXz7vebcPuijwTTuMfhMMkJiylVQgopd6F9qw+LXLh/Sq+vaQcbC+N3HvjRKFJI+0OwU9QFYvEWA5sKuLQtC9GfXIYjiVNdizGK/hSZBdoKh758pQto2LTnNaDlYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069261; c=relaxed/simple;
	bh=6pxAIp/2xfjmF/yhuLiifDUhHHTonbnnH4UKmmcafMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpXUAvmDINKDutb6TRlspSe1xqcUNoP2LKjl1CH1VaCgSRo14U1sC2sv6Hj3PCwrBj3tm7LrqV+WyVhU6XahRG+mzkECd+OakxcXhVx61EpUjluXITwP8Nb2iG/xOjqNUaf7K8EqRJl6slYFxIqEVMWRDotVRqIzUZn/4Yeiq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nXnuodWS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nXnuodWS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IGfu1813607;
	Fri, 3 Jul 2026 09:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KYZwpNmcw8+uQPb5K
	E+78L+llq3P5yeDVsMQLdWw4H4=; b=nXnuodWS1G+7QDoHFwpkIwLufZjoLHR1t
	C7zurfIioLuiGpbgaFgJRcxCDhFI2F/FeoRAQvOlan9JrNHENHReO7YpT5nyRd0K
	v5LDE5NQ4OZMmDHiKF01mEO1CBB4e5gjyoOsF1oaFs6iFhTRa0p95Ow6TXkmvIuz
	BJC/WeenKZHUjXxVjXioByhK/W4z4T758DS/a28blMGchWPGtM35tJkpECfwyHCb
	i7ni67/PhCCfg1OPaJd4qDoqUNPzAbvgEBERmlVqHBMeOHf0t+fFsMDpufKPq80t
	ZGI2atCKw2KGcdGLVr9nECpAFZAa/19rtlsZr3O6y5KdpZYlZtcdg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfds2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638nclk011870;
	Fri, 3 Jul 2026 09:00:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhqy4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66390hjQ62325130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:00:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322912004E;
	Fri,  3 Jul 2026 09:00:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECE620040;
	Fri,  3 Jul 2026 09:00:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:00:35 +0000 (GMT)
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
Subject: [PATCH v4 RESEND 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Fri,  3 Jul 2026 14:29:52 +0530
Message-ID: <20260703085955.2318600-6-adityag@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a477a40 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4vOvNoFDifOwbC3DQlcA:9
X-Proofpoint-ORIG-GUID: UyHMu5enlEGmX251b70UI_QRfO8QHp_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfXy9G+CfAqAgLW
 ciiH5ivy8Tk8Je0hcOkHW/nBWpRV7cYkpZX+X7v3sJ5nHxwp2e0dHYIqcfGJuYR6bQTIEeGD2q4
 7erkZG/WMTqyN/39NM7Lea3W2vmz3kq3L4sGvIFNz+wbWMM9Ak8ZokAz1fD+Opd+WUd9yVXkbeW
 lN1FHTLP0bUvROvH7NLR9G46269GgeeeYF99Nd9++aynbJzecWUm1IkV2ihY1RAb0BI/+aFFBRi
 dLek9kdJwKBX2/dTAbuZ+wmniiNrQX2UCrUV6hnKXmY8VcdkD7LZDRddMK0EE3WmRrlgYAmpoL6
 kX0hNjT/0CjNmPjN3uYU3iRr7/NfykEprCZH4J16ytVGXjUrKta+6KWBEM4gAMo3hf3aPl/jDTK
 2A+ZqI78JWcgKsqY1I0Eus7vJ/ucodwcbMwNoKPzsZdjyzE/U1mw92BS9z3SoJQKA43aKxAVl4g
 etgErpTNoKmaSkrZEKQ==
X-Proofpoint-GUID: JCdJU1rNzqN1shVFMLECvA1lnQflwyhQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX7cE3ZyLhJ5NF
 ZwfnWf903OAOjyJZUQ76quQ+1CoJblQhVJbwEjgzGqrsMQTKLu0GTcmBXybA/O3sl2TxRx56B1+
 JrrGLTUlHQkuHwZIEwJFbISS0Wvlcm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

As Power8E chip is removed in future commits, remove the use of Power8E
chip for use with the none machine test, and replace with Power11 for
ppc64 test coverage for the test

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/machine-none-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index bafd7d660ec7..3205df190f35 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64el", "I6500" },
     { "or1k", "or1200" },
     { "ppc", "604" },
-    { "ppc64", "power8e_v2.1" },
+    { "ppc64", "power11_v2.0" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
-- 
2.55.0

