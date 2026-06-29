Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0833366DA5
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731125; cv=none; b=dewcxFo7a6pDz/J7rBpIs3Gz8EnwNk702L97DXMryGccR8MAWkRn7HiZLqOVER72aC8/IXSMga4TrVEZhlbXUcY+RyFfO3mc0deGw8NDDXMABK/YzUxAsLM6OXwHAhv1kkoY+0K81gAf0CBX8aplpO4COqqWpYUzrBQ4K5F2KIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731125; c=relaxed/simple;
	bh=M9gDDUwXr+SNxLjRQXTAXWHH2onkp3B6SLiVgBSg2UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKqtL4DJQ4kgBLkut68kmE0G3dDhy7cZ/ZTvd5q0BCKU1/0p7wIdiQlthOkOIvJoCAsOS2zbZq7V3zS64chJeIqAu7oss30JyiL3V1W4pabDzd3z5AepOa56In++B9yTOwEo358wwQvdAwbJjNiPZv2fErSNH/mPJZ1heUgMYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C0HhzFBj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C0HhzFBj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmYFE2986788;
	Mon, 29 Jun 2026 11:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OqKfuC
	P/F9xbRu2yulSdzf0YNA69psCEgKh69ftAGlw=; b=C0HhzFBjH8yA6v0xVtaGtZ
	O7vxfhHjFnhDwHd7iE7I2wBb2qD7b6ihXzAwzY4E3pyQNaSXKjjNxDOW9o6EXJEI
	1S3+mkGohW7+sMxLdwRsF+9LbRgpznsPX3oFns/wFfmij1RqIm8GRqc4SZ0F0E0q
	DU8JdKREoWKb62xnVwaf27NKPHBVjJ4V9Z6e1m9EAK1Isadv5ob1EzBWfgvOqP49
	o0QymcOIOXPIqoPwNdAHmzcr6ealH8Fpqb0XcMjjyU2TSkk54Zi4KAABuN7KH36C
	ttyLktD2SGPtXZkHbQZr0IMnQ6Mp/Id+hIafr10G34Ql3lkbb1FBCqcw7JR9ol2A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5gx5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4fEJ029033;
	Mon, 29 Jun 2026 11:05:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g4wd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB57ZV26345922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:05:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C7F2004B;
	Mon, 29 Jun 2026 11:05:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317D920040;
	Mon, 29 Jun 2026 11:05:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:05:02 +0000 (GMT)
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
Subject: [PATCH v3 4/8] tests/functional: Use default powernv machine instead of power10
Date: Mon, 29 Jun 2026 16:34:07 +0530
Message-ID: <20260629110411.3051274-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629110411.3051274-1-adityag@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXzsZus53y8zg3
 dPC8sLkaN/WDATc/WajfPLVB/WOuM5rQlZwac6iFdnX1wWqVLfRyoq1U5woJ1Ws+/po95DZhRiC
 WwLFoKBTcXkM9u+amzjaxJ9oUZ1bs3fFyESbaDlLFYWs7hFL3uep6TmnVPLtxTAQRjvdRpGtiv6
 0suG3g6xY4x4EzX8nrVVmrdwtEy6Ake/rWN8zlRBbiHbV5HhHk0/LgGRzEq/1P392B3OhZfJapJ
 OAV7GRIX/HNXbTwAM8zAT6oi3Tgx+1hA/HAG34rM7kpeSCSmSI7hHgEsDDfUL0p82QEN/LUJEMK
 MeNy9ZhN6tWAXv0HrxiQXlbJd+RZYdYH2BmbyAVyWWri8X4kau3r6Plx/DNLNUbpWXn+4RnFNr5
 40EakPyaCS/3lZnBzRcPLJFt4HCvWNrUuDJfpgBpxoN2ylv70YXDraEnXjJ71IOj4zp1Q+S/GK1
 ukSbXMmmEN5os8oU14w==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a425169 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=MGuuq5ZBRx0t7b6k6EIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KY97kdKlK-_jLTczkjf_taG0afKhrsNC
X-Proofpoint-GUID: cFAAWuKheeiDdlJveFlJV6jBNsSboZB-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfXxeLtOlNL0IkE
 QfbPmtOBVRd9Np7v72U6ryQ36AtNHCSj3yDXKWfRGoiMnZ0pY9u/nS8FpKILmW1u6IBtTkFei72
 SfQvPAd+RHKdd4rjNBq32Iw23o1jnzI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088

The default powernv machine has been recently changed to powernv11,
though fadump functional test used powernv10

Change it to use default 'powernv' machine for the tests instead of
being fixed to powernv10

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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

