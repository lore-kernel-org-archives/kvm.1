Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF03DD87F
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331238; cv=none; b=hggD761FCwdiwMhglEHBtrU+o7QnpmmXDIXiTRJa6ZX/S/HjWrYuz1dWPXiVRhlRsjff+rwlsJx+nlqZWdTosTwlkDNRqrHJUJnkvuSQYRJBxt3Fz2ogKgviBVxEsxh49W7bNjyHLntaUxkhfnjO6rwItjw4llNVd0gkQrbso8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331238; c=relaxed/simple;
	bh=Kv+1NHl42ymfK/+f+/4S/PNGkuHoaavwrp22ie7F4+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEeC32qdzrV7nKelDzjqG+RAYRMBr8WdArfkTTCufh4yPWjoQF6p1nr+7SWchw37tOljOpiTo/IZEn6cQ/rOOMjYd8lwey50qE79cHccmns6VjWjV9R30YGkXwYuROxVkf4hqsJibJYUVKmW8XtCixiv5OkkLG0vpJtAPpVrRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W2dEsZEb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W2dEsZEb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmOB91996115;
	Wed, 24 Jun 2026 20:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LGNgZMw1UEgMoxoYi
	supKjhdJLZKr9GILaxiozmZ6es=; b=W2dEsZEbGCdz5xtarYIobraun54quXAfj
	kF+zR05+PHcoHiEGPCsh9ENA0vovLAEG2xBTCLpDboZbO8j6ZUxvcJddVaijUHxy
	PK5SBsnAxdEW/C3AvNDrg5j6lW3VE6xCREC9fxRen2IZyi97pdXDAebU6tyezKeB
	VfDymOFd32psAclckOaFQP8TCg5jJj+7eM7XB4uB5kmEPn3Zo4tcdlLNVKdCwHXQ
	QScX4ISASBEAD2CMhe9+yX6Hnu+ispaDgpgwHP5VIx92pADjQZXvO1bD2hL+XPIU
	ILBcFxCu9ZpS0RqAWFX919LvN79sZ9rKvP9JCGvvOrsCZfHBYDymg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4p883-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJnxI7015172;
	Wed, 24 Jun 2026 20:00:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qjr61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OK0CLt49873202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 20:00:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F4ED20040;
	Wed, 24 Jun 2026 20:00:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2066720043;
	Wed, 24 Jun 2026 20:00:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.20.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 20:00:04 +0000 (GMT)
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
Subject: [PATCH v2 4/8] tests/functional: Use default powernv machine instead of power10
Date: Thu, 25 Jun 2026 01:29:20 +0530
Message-ID: <20260624195924.1422821-5-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfXxv87nPtQRv7R
 lO1zGUaWMozXwZlqQFxM9J4foGJ/QrAHYsHLC3sTOYFtw45gzLYOtCfTmUpSWwvrsFFCLQ//JRQ
 pJH9vGnswYv3Oy4eKS41md2KlsUUfx4=
X-Proofpoint-ORIG-GUID: 8VkoNBec-9E40k3G5aQtcm53aqIfPvN_
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3c3751 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MGuuq5ZBRx0t7b6k6EIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX3sR7MPMGiUDd
 n073VvJBiYUs3EIJxWoKsEvuPvG8zi64QtW9hHhdfiIeTViEF2OAdOQZTiu3JDQ2o9Kl7XjYAmB
 PlUZGgdodWQDFeffylI1Y/CmFPjB8j1omy15AVpXuvJmvGVlUQE77tCOzJjYzYOSauBLsOt/NZw
 2WY48IcctAmlVSn3Vid8WP2Vnj/gAiycYGHkoJyxfBMnR/YRa3bWhW2+Xaa1EUrlR+6I7674liX
 iRalk0Z0+My4hJIBfbqpxRaGOd9RV+pqyguBd7LRG6i1WI1dXDuTpm4t9/lu4xiZs7KW5iuqodw
 P/Xc4EC89FoCGMVE+4rpK7Euq/KgVq8w7RYvZv1kE/XSA+C0avcL+pwCUYYvxCCLf1YW2ierHIs
 QqKUOT4a6UhoKGXZTJUlOCYFlUWIgJwb68lPELossQ/a8tUdGnZZw9YiRF7PMme1kE13bVtRGw3
 HmNuxG38SnDUNgBuS6w==
X-Proofpoint-GUID: zicWHFkl4wqKgqTKnd7OuHeyxRl4bYaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240166

The default powernv machine has been recently changed to powernv11,
though fadump functional test used powernv10

Change it to use default 'powernv' machine for the tests instead of
being fixed to powernv10

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_fadump.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index 7ea65974e0ea..c75095076b52 100755
--- a/tests/functional/ppc64/test_fadump.py
+++ b/tests/functional/ppc64/test_fadump.py
@@ -53,7 +53,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
             self.require_accelerator("tcg")
 
         if is_powernv:
-            self.set_machine("powernv10")
+            self.set_machine("powernv")
         else:
             # SLOF takes upto >20s in startup time, use VOF
             self.set_machine("pseries")
-- 
2.54.0

