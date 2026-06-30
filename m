Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62976296BCC
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853499; cv=none; b=gZe+pgDGGoe+M6TAkpDnUqjqgXPWRFutEDI1PQncteLYw5mJpfY+iXQVZeXZGYB3jNfpcCe+XeCPLsKebQgVCtO02ptFnZyAK9qRxsMFKXHym1vJ3ABhaM9i1/QTbFL3F5rTY5+SpKfxH9siHDlN7N07NVUZBZoD7K+Nm/Fa56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853499; c=relaxed/simple;
	bh=VTecHj4cMALobJic9as+SLEMi9eZnL8ichLvQuI9EyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gd5L1rsjpipzNNlEpMVXDZlpRYLlq7Qae5p1Tt4t4uK9e5D5k35axnhev6MOEudcLdFJ7DjtKajoqeRnOI9fpFOH4fizp+oneZTsM5aOTsWi0RB6stP2BTtgU98TciOxudd2OB1KfBws3zivVPTZwGVdQuNnc1nCCswGpqyrFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MWLpYHFV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MWLpYHFV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIhC92842938;
	Tue, 30 Jun 2026 21:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Ip9c1
	ArEU6Is3iLI1amXPDH/v9Bmcz1oAWdKO7ZTEE=; b=MWLpYHFVoHCpt8Wr4iLUNR
	WO3O3yciH0ymMurdh7QtC5uLqPdKNeIJo9OMHQ1bDr8rKN3aeK4LQMFjoPIIqWgO
	kaERaeAxqnE09tKL06fiS4f7+FAiPk8kt0Ht+QDjoXUgy/2wRbzy7D8cOEPxWmEb
	xSyIM3Oije0aeDWskB2kNI/hvcZzx96+bFg++99Bwbq9j7c/NPVQsknIagDOp+Xk
	N7tdeVZjK7mjym4CX7WffDFq0gpqbg/xIU80faM+LOTNjnohgDYyM87XEwjkncRR
	QhyYSFuj7ih44e0PNTpojDv8T3J5dzgaZntwNJltDhKkq+LwxMNr4r97tTIFo3Cg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf0syu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4jtA029939;
	Tue, 30 Jun 2026 21:04:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhc6ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL4foJ52101536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B661420043;
	Tue, 30 Jun 2026 21:04:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7C220040;
	Tue, 30 Jun 2026 21:04:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:04:33 +0000 (GMT)
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
Subject: [PATCH v4 4/8] tests/functional: Use default powernv machine instead of power10
Date: Wed,  1 Jul 2026 02:33:51 +0530
Message-ID: <20260630210355.789109-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a442f6e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=eWnuL_-zVtQAWhTB1ZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FQ3HW9-SS5C1pvfS_BmgmuN762G0XCCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX47pdHWJIvOSh
 /6/47To3qid+OI9LSgvuqmE8IVX3uD8FBV49Kmte49wX8Q2NlHgcjO5d75qRokN02O/hijdqvJk
 thnH20yXMBA+v/gJXWJW6CYZuqBwyXWYsnOsPZRW48yhE5qJqKEL5BC56Yk4Sla4Z0s79JFMBjd
 ulTi5uOhWWq9UxYD431kQTTAiBYFm8js4hcsbeu8P9A4v4C0ztv6BHX82fjsHGK38IESGI22A5X
 JW148+r/kE52uza/vjND1XWaEY12EWKcyyXxcEH1ileVZh13FQjX8AFrQanGC6gwkE8uKXEbQ/U
 zIMurcQZ3OoEng9uVsRJSlFGJBgllXPsN1qgqxq+rDI11Jc7KtKx04n32Y/jfSvtkRxNvR+HLBN
 FyHKqyqzhPLxBjzYd4RMGu50QaSXmtmaCLFtcTuIiRo9anUKw3i/+eYQg3uRYEI5f9j00xBJGog
 1Y9oyVdzg2VQcZtB4EQ==
X-Proofpoint-GUID: C9qQ2iwoIVU3xfukX7vqNuI6xLkGF5ZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX6tDEK7AsdneY
 bi0NvI/ndbhbtZrsjoHcAwXFuER/+SMScXBzgmwTFSCSEFIIjmcZJeFdtKEOASVMLwJ0V67XHr4
 eGSXv9ePN5oGRL+1leHdo6yruyA3kCE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

The default powernv machine has been recently changed to powernv11,
though fadump functional test used powernv10

Change it to use default 'powernv' machine for the tests instead of
being fixed to powernv10

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
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

