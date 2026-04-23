Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71A310784
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953860; cv=none; b=oz0rtqNgOUPCIoPV7643Gl467uhulM7TuU+HkHTaiJMqLX81xi1rX1N62ZZfM6Q6r6JBhcl8CCNVMvQVLAbX6+L8hCQzYTF7C7QlcSt43fHvkMN8HXM6lGZpLlcA95O4rDv2cT157XYrVNWoFsBmySWugOQqk9lLMnD4K9sls1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953860; c=relaxed/simple;
	bh=kNJryzg1V/09YdNU6azS7n+B52B3K4mqY1TJXW8pFg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6fac0Z46oRYCaBeUSvDK29jkvKi6f9lQ7yfD3FMi5XLdx5V0mxSUk+pQ8SmTZv/5Gw9N+EEzOGisynuuJzlIiOTWjMPnz7C9HKUvnMY/vn2fp1SxH2M7ZGd7XpnFgLOVKwOB3b7/Fm4M5tEHCdWETnPlV88XeUs8TSXjLN2KoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQ/VpuKm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQ/VpuKm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6hWXR3292170;
	Thu, 23 Apr 2026 14:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OvDXuK
	MULws7KDD+sPKdR+vkyTcN59TCGF240/q3KaU=; b=CQ/VpuKmCrUffHfoXyDQ8z
	SyQElnZryO3qQpYR7578VSI9rqwMhk13t76LxrXJkG+GJ4KxEpInEJK3nZGqt2g/
	JgcaKneC3WUwOgooWBjlvf5+TolBq9nel9RyxO88xIi2waKdiRMvGBfDIbZYlhTW
	bcAifayPkP5P2lNb/jqpgMp5flNpT0l/FgA/PI9dU49GvxARoG2lbg+ue5IRU2cS
	xzIGLmxXmxVzLSxwSHwmIW99VV0MRBD/Dsgv7A4FQPX8ooJ+p6y9eSdyXOdoN9vY
	2ZzXLcoIsS8Er7gaQfeJK4SJkvsWxepn94kfgQtkBb/1qtPD3K6KQdDk5KRWkpTQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrgehk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5YTd005854;
	Thu, 23 Apr 2026 14:17:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky6ws6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NEHI1T48693706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:17:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A64020049;
	Thu, 23 Apr 2026 14:17:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5694C2004D;
	Thu, 23 Apr 2026 14:17:18 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:17:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:16:52 +0200
Subject: [kvm-unit-tests PATCH 3/3] scripts/get_maintainer.pl: Ignore
 --nogit-chief-penguins option
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-b4-cmdline-v1-3-f72ad0020d42@linux.ibm.com>
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
In-Reply-To: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=kNJryzg1V/09YdNU6azS7n+B52B3K4mqY1TJXW8pFg4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvNN8W8O0X89umxRrte9JUb93NH5O6v/MrTWPaqHHY7
 qaq2cbbHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzEdS4jwwt/lqVRpyUPr5ip
 lKmu+7Sc9+v3mUuWTf6ZGDxPw/L4vkKGfypi/068Engj2rfw0JG4A/NVzsw8I8MessJ92qY57EZ
 HdZgA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jaEF8TI-shu5v9wqYgKYYQpKp8QOiV5c
X-Proofpoint-ORIG-GUID: 1fTilSWYC-SpJGfO0lmAQVahte8Jy7I-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX+2ToFZsh9RgI
 AnMGD9OU7e9lx8IyslMABiNnxePYtHyFxwB+kBwofjLeOG9E6QuKT4E5YvuK/1L+KO1Gg66tP27
 RSpbrGrG1dDZ2cJbgI4905f1tm/SyA8x7NJjnO3QyrW7BZcpqSB9w+Q/kkmEXzTIDruP1heii8m
 u4OkVsF9ctW4aQ+SQmKSpbZtIfk0IdnlugNdTyEX8qvCkA3vABB3cdJpaGl8u7ZBfgTnO6gKRcY
 NDTtLRs0RXSLss4/UKKvqK64WpZr0QnfededKz2fBf1M4TtlXwFBY5UvBAcsEp8t4yZTS54ukmR
 kV/7IxMHl+DhJ9oPHSD2qQx0rs9xbpMUjYqQVub6c7z1ss2Og6PrKPnyznP6ABkNNzcJcRYyEIB
 drzVjlpbrrQVH/HsPcWGCXj6KMoSweft45PBr5XaM0A5EZgEqjQnd6h3yETKb4Gl7e433n5q/MJ
 GL/w1hMxkvAdHAmQIiw==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69ea29f4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=lxj2BVOkSjtvKpCaR2wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230142

b4 by default calls the get_maintainer.pl script with the
'--nogit-chief-penguins' option letting the 'b4 prep --auto-to-cc' fail.

Adding parsing of that option without any related functionality to allow
simple usage of b4 in the development workflow.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

---

Sorry, I am not too versed with perl, so if there are better ways to fix
this please comment.
---
 scripts/get_maintainer.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 117b69145f0e..9b99f6218467 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -31,6 +31,7 @@ my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
+my $email_git_chief_penguins = 0;
 my $email_git = 0;
 my $email_git_all_signature_types = 0;
 my $email_git_blame = 0;
@@ -228,6 +229,7 @@ if (!GetOptions(
 		'git-blame!' => \$email_git_blame,
 		'git-blame-signatures!' => \$email_git_blame_signatures,
 		'git-fallback!' => \$email_git_fallback,
+		'git-chief-penguins!' => \$email_git_chief_penguins,
 		'git-min-signatures=i' => \$email_git_min_signatures,
 		'git-max-maintainers=i' => \$email_git_max_maintainers,
 		'git-min-percent=i' => \$email_git_min_percent,

-- 
2.53.0

