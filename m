Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073F1E4AF
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853533; cv=none; b=WhWuhagNKUWaHDXilYcI3+YnPS6AyAf9Bu3Vh65DH5E8vnuHT9u5iafX+/DhgZkkAZccPBlho0465uLWgIjA6ypsPITkciPvrxpSJR0gU0Qz6Sj3ZX/FjZ1bQy1HRbdCZxDHXiGH+WcVNIcqQrZ968ErC9B9fQh+xS/zDEX3aB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853533; c=relaxed/simple;
	bh=0cUhj5/oF4xof2rGCDyPXfrmVzYwRBFCeC/UxUpMeGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoBhCshhsnbjE0dHAZ79hhUTtLOe6jBQVyhQAEn0IUvaC7S24tBeD5lCetxcMQxLAl4RQC7fPVX6CBeDRmi2X1b0hPhvEGVUMJWMOPyBSH8SljB2gew8bLY/mAG0bhZfio84G5vMAD6wkuvRbIIIvT0a6YjestHxVdnJSkNkt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SYPoSOLT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SYPoSOLT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJIK6O2957112;
	Tue, 30 Jun 2026 21:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mT4M4ru3iY2hxyyhH
	I6u9rQHkrlyQ6aoAClwnlnZSy4=; b=SYPoSOLTeHOATYiHS4BK/i+bhX8QB7qLL
	Y81HlYXUnwMoTGSUy+yZhH06xTwK0AyaKWemhPXYHC3Elk45+OzntazDHR4i+J1C
	vcZbFSOSkmSA+okkNJfUfWpoqDNpZzgc+attFm/+hLF/i3zJXwMulRGlkmXgu1oK
	BMMa+ir6eSkOGiTxRvZW0BtqKF/rg5CBSlMVyvJxCnIaKfpr6uLDRQq6B1QpCItq
	/dnYu51le28sknEWmwpeJ+E7x82FlO8KXcYW3e92ARRuzNE/h3yKjoz5QUetBQjW
	E2p1fL4TndkgRGFPcD3FzCbTZg/pcxGpcqasJw1D5xbGvm5NDKqGg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe15bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:05:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4kKA013904;
	Tue, 30 Jun 2026 21:05:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqcerc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:05:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL5EhG29164142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:05:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4CFB2004B;
	Tue, 30 Jun 2026 21:05:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C7A20040;
	Tue, 30 Jun 2026 21:05:06 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:05:06 +0000 (GMT)
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
Subject: [PATCH v4 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Wed,  1 Jul 2026 02:33:55 +0530
Message-ID: <20260630210355.789109-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FU0iW7blH-E345CcgUU6Jq6GxpN6PGQm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX41wqH2tumVqA
 YoZKncJ3nfFFVXAxcTDf+3AckmPwg5Vr1pRS+QQHg4kaNhXGa5sLYC4VRls3jMq5R0fyVaz+yVO
 B/+AA2waSqtNqP8mKHl+fL3b+aNRGpo=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a442f90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX0AQXfTGKvooP
 CflNwn9P2dD+CeewLLRvgA1jWI49WBBtpGnTeOruvCqTLGcPQ4Ck8nTkgjv/DGDjt8N0KDb1pUI
 cpYGfXPo87Lg1/MGFjBu4m/9+OETLqXvLgL6i71ERZOQ7Ok0K+fVgu6Dbwp+zFuqduVWhPybVPl
 SGxyhuh5XjP4SqEJ8aoQrL61ygZb/+6jzPA9v8nVY/tsC0nLL6tQ6ylfy6VyHNUI15KJjVoOLn4
 CRYYJc3ClwrcqHbtvF2iNeU88LqvAC/xcCyND4budJ1yp/hy8exHCEIz/EWdHPCRtUuo9luKfuY
 muS2E4cCP3ADJxthp1hgFqzhr5XnoHSCB6rP+hWCxiEYplgie+x7Ysagd68dYZVbHeWIl67+oAu
 7Qh1WmiXpNGYBj4eA3JhCRkMIi7laRIz0msXNKAz5gFZ3oHNyHp88j653WJ+NF/mg2uh8mukHqV
 B3dxd9K/ayOScVr2Ctg==
X-Proofpoint-ORIG-GUID: AZeVXzLW6377qezqCborLSi-g7t84tkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecfd7159dbf..8ec88340fadd 100644
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
2.54.0

