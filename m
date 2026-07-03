Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B178377EC5;
	Fri,  3 Jul 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065195; cv=none; b=hSslieA3CRV6gxpOyxAgg4KaP6PbgFOtG+yn9BWawf/h4DKlus2W1S7womyrNr6wRjSksWgZ6/TTnLTDbkhp/6YaudHygzqoiNNctAXKuWHVO75JWDbAMebcz5+bg3w3KFtfwSSr5ezv8GHmis7DeRJQnF8Cg7R6R+DpuRitJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065195; c=relaxed/simple;
	bh=6hcR6rxhfV8mR4d5RSSixF8VNTOqBgE3fiWOJbKLs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg0k1tekNVg42jNflEpYq6BlJYuCBpS7R+4dCmfKahZpzMWingGXnr7aXRQmEnsfibyMaR773Eerfq8NfW198nbNuiZNbvanK0wc1RgfamS5p+Y8EWP3StNwSPOp+J9hxgm1gjF3aal4rbUh+qwQeCp6nCv65c0pDcsTAN9CKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WVgyeNM/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WVgyeNM/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IP3G1930856;
	Fri, 3 Jul 2026 07:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I7Y3Woh3tKuoRQ5hL
	hRkCn9dZf5pYuIqEePUpOFeMZQ=; b=WVgyeNM/zN/DPmxBBIhL0Ybb5GICj6hS/
	aBdUTg2csPcnJq0GsZUEtgFUB8VjC/asPlPjSXgs6vpor0f6SVisV4nf+m0Wcz4Y
	Tssk7BfliUwjHJcztwFj0H5ti6ZcOetaRoDsFERYXYPus8KCSe1e0bJhDIfji9UW
	nyAyG8q/M7bdIo8d6sQoIlClK92g2zpQKg53Rdl5Nw6Q7DL9hPU977l8jKhU8TTb
	LpMb+i3DEdvsrNuDSzdNA/EQ3Dk9J1fEuCHijJrQui6tadwZeTWUj1vPQS0y7bve
	DVeRygXt/jSmTbw6ucSab/KcMpF9aJTKWuLQ2e6i6iKEoA//RLnvw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pee5cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637nhWx013476;
	Fri, 3 Jul 2026 07:53:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhqr1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637r3ju51380482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:53:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB9220043;
	Fri,  3 Jul 2026 07:53:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2680920040;
	Fri,  3 Jul 2026 07:53:01 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:53:00 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 6/6] selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le
Date: Thu,  2 Jul 2026 23:28:06 -0400
Message-ID: <20260703032806.40946-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lvcM85ve-xNv7vsAljHFZyB6zlGePq5C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX+gLwxknHAeNf
 RM0cNFGA4X5WDNZcNS8zriXJTA6rFoq54f0RTZCbJA7WGev9K+6hImefvEv6weJB71zly9S92mu
 wUdKBU5faczzlJtI4LIIEvBeEZQSffM=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a476a65 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=BurfphQ9xWFPD4vpCWgA:9
 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX8UjyBIanIwwS
 43mCyfKlMbMDVRI5lCFslpl2f+7ONluDy1yH1GFIRmJ6BhW7uwOvhf3y+JwvylCaACCnW4w9aXU
 wy9OVcOcXWK6XmRezARc6oVJB0vMEcQeonHxR8ckLuuttQoEtSmYK3v51Eu7Wiiy9vW35dk3PPj
 5OA1NjEJLhfz6iUXLToOpfklEpwMlJr+xZ8HqYQdo48y4JigXDGGOBkeFtFEeKtjswGHfNbkFcJ
 1LadQpToxGMdZS8k/wiTZKbhY0IvO8jnVyagVWS1jFUaueEewv5LQp7ltIc5PxZ6o52j3rsEkXb
 0pbGYOtlMESLURlHGRqj4lEJsfAweO9nC4N0s68tKElMHSpbJ/9Who0nXZ1zFqkQaprFkDuPhTz
 vIW8FI17a8aZoZ806alk5MIMVb3As9muZEOeHAgGiZd6rV+D5hbARDzlwWqON3oYlqrhOjIBkz4
 AToG0uSuoYaQnMM9RGw==
X-Proofpoint-ORIG-GUID: NI_L_SANqrAWzQ7luHyZiVThhI8OG7_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Enable VFIO selftests to build on ppc64 and ppc64le made the changes to
Makefile to include ppc64 and ppc64le.

With sPAPR TCE v2 support added to the VFIO selftest library, PowerPC
systems can run the DMA mapping tests against the legacy VFIO container
backend.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..8fd6afd334e5 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 ppc64 ppc64le))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
-- 
2.51.1

