Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31573389116
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069253; cv=none; b=s6IpL9krlU+VAYA874YHL0DrQHuJLmo+KXO+W/wABC0sgDr2U8NUsna5D3E6zeXjw69ke1YpZrviAlpgQu++A22YQ9j2t6edLJTghAvY6JWhRghScPNX8WEq/KXP9r8MKkAKa+tde/uUCftfaYXT1LhI11xZq3F269bqWZtq5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069253; c=relaxed/simple;
	bh=zG3Q0U8cvN7b9t8qLr227x18Prw5kxPtqBXdi1Hk9/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOVf/DJG+BNhsvINCC4/JDYhq9+3J401IWBknNkRG4VRYA5bAiD9ypErqASf5QmWTXpHBYXTs+t+APJe2zESXW5BdBmTd3bU8zj+GXOEFr0jtISw1Vq18SvjhRhwWdMcDTL+hqaDmFJYfbIDT9SlMM34XHUo5TmqBdEY3GJ6meA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWra+ngk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWra+ngk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBLM2062816;
	Fri, 3 Jul 2026 09:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KlM7Ol
	LQT0tap9tnqmgcb3rQilov9Ye0U55H10UHF9w=; b=EWra+ngkGwD+pX9N94juyI
	NJ5EG7GGdkV80N0gzHsKKokP0SKtKfK8zat6zcT779i+6Zjqcs/p0/KqOqd0nKim
	6XzMogKeS5ZfQItaHgbMvY2vJUlSIXOuZFM/fa15ruI9pFEVO3gAlH1ioQbX5cXC
	U6LVRU3oeplcqCwn6pVcEe1+qf670BwzQ+sUm7hX/fXBm216cWIHFFJwxIGWUeNi
	mgcddko2s8El3kGhyLvKM+D4MHUYmvue7KFVi2MogCatOSnzTH0iJEWCWWTC9o0e
	7liLY4ycFsYfOPoUnZ4vQjCFRFgHGg8GNRVA15MKOVFzos9L4t3Y/OmSLorA4Rhw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgeawt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638nd8X009234;
	Fri, 3 Jul 2026 09:00:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyqsj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 09:00:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66390Yv016450032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 09:00:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDB8C2004B;
	Fri,  3 Jul 2026 09:00:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33EB920043;
	Fri,  3 Jul 2026 09:00:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.212.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 09:00:27 +0000 (GMT)
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
Subject: [PATCH v4 RESEND 4/8] tests/functional: Use default powernv machine instead of power10
Date: Fri,  3 Jul 2026 14:29:51 +0530
Message-ID: <20260703085955.2318600-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703085955.2318600-1-adityag@linux.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a477a38 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=eWnuL_-zVtQAWhTB1ZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX0JOs8Fk+UJVG
 7dZRQcc5tWevD/PNRb9FMgzutYtOW9VqbiWH3Yy8oA1hlSylfkEdhfLolrEOI42JWUqUVq2NAwo
 8an189l086FZfXxJtGiSJVxZTBMgsuI=
X-Proofpoint-GUID: KntOgUjSifna7usT_PHVAFvmdYARjKrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MyBTYWx0ZWRfX29mRZW+t3gkD
 L675QUlMBdaxHwha6IyFPs2ODjZ2jD57qs1RLZv0Ie7S9ZCTDkPFSqEHJoCDe+zfiKhh85xqHep
 LZja6IsjWmXK/zczY/sYUd1gbgfla1LfYhm1msT+cGoajT2X9f35NVfW2etN3hw+CIqBdHBwseJ
 PV9jRqZbBmrUBjM0SeabFrytOES8Sejxg3HGNhkbBlnyIDMIyQMBjtDCTKJ4SlAxwsJ8WTRHgyR
 1rNzphGmQVpMLM3My0mZUxEPLOwcxsst/mt+anzVCfKbSDdB1iNzrjEFqT4TQFBonH1rWPHE2Zg
 sJlwzH+As563JtyJhXy1qhgd3J0wTQlUsx6ZoDMy570J5G8ITAWpbljOAGGqFFvPUpmKDkNoclp
 rgQlnJIA591Rl4SMDnyuEX/D0w1TFTGIaaOEyAyPRT+sPezLx4KTAZUuK6WzqL3RZtysAA+75qW
 pNIvOEujEqLVzcjed+Q==
X-Proofpoint-ORIG-GUID: DQ1ByFkhXe46jaBXOphdB88cVu3sude5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030083

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
2.55.0

