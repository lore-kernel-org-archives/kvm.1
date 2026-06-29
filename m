Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97F314B6E
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731145; cv=none; b=fNJTayJj3X0j8UB8QaYXdyNsjNgVkDkt/YgCZFOFUEik9GR5PRJ1W3al9LJCfUWvYyYNbXASxq2uhrfc78ir8kEc+luYBRT9/NNLNa/3u3BxOiHFAnnuEo/sWVZS+wnmKWkeVamSPGo1m8400K1zdw888hmkJ8JYNJiVa8aUpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731145; c=relaxed/simple;
	bh=6CRBJdP6VhCsoSJUAJzmggkzSOPTtRUZjqe9Eiv5yzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8OGjm5bBENP6AgRWGwJ5vm0FblEqFie/3rlezv3V6u6mhd6aoj4mv1eCi7mYQnmVcoN6SkG3Ho0DFdr6NWjRufL/G8sOPa8MWgwwuFi1S9kofuV+S+lQw29vIG3vs3vjN5tfY7LaAsLWm1HR2dWG/YLwZBX8ytITg+hrDhBMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z+XbukOP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z+XbukOP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmGBB3030086;
	Mon, 29 Jun 2026 11:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8Pt6EOcW6zid/avhX
	6PNPBuLp9sltZp2v7VzJy8dh1k=; b=Z+XbukOPRsVrpXH+bliivbvel1rUpIr6z
	I2HqLjZ7VYrq7aOsXM80arAsUScm1UeBfMNtVm7XkvWPqZ07p0Ii4EO5ckSAcJxr
	s5m9ZOG0Soe0FdRJI81TExowhd6FISJ3Og1HrhQaeETC7Mtmc1mVhGNHQ2i1N1g3
	AwA2Xh54Fx5NfNFOwXKG35y5UNq1YTcrjKjDz3vYQJBpKVDTU76lsRTvoms5ONZH
	w/DDRWG71OOecg3pM6GiB/x56+QwyI+wHb4Tzwa8kw75hqz/b20vw63tvBwgsaXd
	zXQeD8k8WGxXGe35NbcX6YXjm227dRRGuBaC4K6h13nAAqZ2ByiLg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdrxb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4hnD027576;
	Mon, 29 Jun 2026 11:05:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy4tpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB5Rhv20578888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:05:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80082004E;
	Mon, 29 Jun 2026 11:05:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B88620040;
	Mon, 29 Jun 2026 11:05:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:05:23 +0000 (GMT)
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
Subject: [PATCH v3 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Date: Mon, 29 Jun 2026 16:34:11 +0530
Message-ID: <20260629110411.3051274-9-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629110411.3051274-1-adityag@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JEy4H6iut8AvurYko0pnNmLmTel5xExA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX4ExpgEZtzuNH
 qkIxDVyV6hMzKppT+vX6jEELP+EarGEK4BK9plPlwAUuFH9vbXY/ZWTnIO8IAswKMNJs9nURk4Y
 x1O2EU+QL1FSzgUoZ2/gpRlgoMlmSvg=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a42517d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=LxXt4eSeZzJWShDyzMIA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX0Lyxo+PuLESo
 AmIISKH+deAIGeLeAJ/eZLKcGgGoHUYVj7vO3zsaNY8ilRslyCd3tzTgzwz08uytt+HnHSNUdTB
 VepprW3eqLNHsUv5JPquebi9dsC96Z6+x2u8vgoRrdojP2Th/VYLMjrOZyL+0yZHKzOOcJb3+Cm
 +w/R8kjphhI2j66B+mAyms5ohJIz2JzeZuFkGSGeYaMsrsfLmO1IYdp55LUESFXPAEpICsvHLcJ
 f6k1ESIAmym3lvvucI69qzllwxFI45A8+ccKoUsnQ2xBXrkp9sn/4r0XQUml21hRyei+l9fEFRz
 KKNkeySRq+3cAyo5oaiN/DnAxhMHa77XDBVdeIbx2Caf4B3YD5BA3yJfwOwEo7wVuEeIkWpT+RD
 je8UVe6KaG1ZRycdj1bH3/nSvjaooXQg6HO4+tEKYkVPTQFijSXo/35ECFoI6XintK7RbP/S83E
 frxBztf8IqkZ1YYmLGg==
X-Proofpoint-ORIG-GUID: 9_UCmvIKciktPWB5Md4-0l-vd7-_3rsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088

Add myself as maintainer for PowerNV machine, and remove the
reviewer entry

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72357df7c4b7..f063a115a0f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,7 +1647,7 @@ F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Aditya Gupta <adityag@linux.ibm.com>
+M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.54.0

