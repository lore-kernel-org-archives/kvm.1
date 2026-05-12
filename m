Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5A360ECD;
	Tue, 12 May 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587078; cv=none; b=XoqzeI0HLNjfVoRCmuMbyDHEUmNK9sarG1Z/tMBxGXa4gGBR7QBhZ55NPeRxToyhI0A6aZcdX/tBXBP/4fYPDa6SQ6AC7bwV1vYmqcdF8uMV6ScwpjyLsiQdUEiI/cqBKQt7Q/eU/5sl0wJCigJQ0wNdzFpbFBqV+j45kmq0qmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587078; c=relaxed/simple;
	bh=m4IInpJUY2vS0JYvKQQ4wHMmbIKFyNQXyGwz0G+hPks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJsdjrOpWq7Oa+TCE1tdB1VTVIwUZw4KI2HtrSFvCvCQkA7aemWNyiJxy9fGYgjwIyea+EtVq9DM4ZRRv6r6h7gD6TFDSblClaM/Z0mMjs+PRpw7g8AL209/VwQ29dPT0sDi5Ld3BXGG3nSRzCO2oO9rRhF5sd/94qR+wvztAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NEmYxGRz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NEmYxGRz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7I0A3775829;
	Tue, 12 May 2026 11:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jn0Ex3hGuYGLoizWFQHUBB1PfFzdzYTIkAWRpisqv
	TE=; b=NEmYxGRzDmM9Uty0imaNRelwQ6Br0sgJ6NuzXFN6Rio4hjiDjuDJWd8lx
	ana2pzX5NY0JgB9sD947NI4siLNIR4zDxJv56wJRt+KkVh7Bd467IOc2THRCa4NX
	e1EVqck+qdkmMgj+kLfaWZePjj196mnGhp6vgHDxRGkYOcZh/jIMpWDE0S6VwiIX
	a8g9Lyn1Jpb8iWjuHQotBhFtORq7GlHHs9sawvOcL6LipGqZW7H9u8NX7dT5+RR7
	PFU2d2i7rP3Wr3vkfLgfQ9a8FGzhl9HrNGOUaskIVEv9JmNp28gjthHnjGrZj/9O
	aRojP/eNfNXmZymxUer8N1oyDj4eQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jqar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 11:57:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CBsUv5021224;
	Tue, 12 May 2026 11:57:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgk01s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 11:57:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CBvcH746006560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 11:57:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5455620043;
	Tue, 12 May 2026 11:57:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F128B20040;
	Tue, 12 May 2026 11:57:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.72.48])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 11:57:35 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        "Vaibhav Jain (IBM)" <vaibhav@linux.ibm.com>
Subject: [PATCH v3]  KVM: PPC: Book3S HV: Add missing mappings for tracing exits
Date: Tue, 12 May 2026 17:27:24 +0530
Message-ID: <20260512115724.59299-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0315b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=xmqxItbY3JyJ2VEz8ywA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMCBTYWx0ZWRfX19OlzG8a5wmU
 zCMlsmHj+T5nMRLXlwMTxcU35P/4rPXgrQQ3zdeolV0PbExvMMesNpKuM6epiNzsVH23c7Xdct2
 JDhS5FXj8xyaXz9ld9iwDEBy3SE6d7ftEadETVZcWSpY4s7d+qdMNrMIVsaU7mnVxx4G2jDAeHR
 3MD7Lp29BN5S8sq6EuuGqz3OpZGmecvV1NucAMgC7GNmIqvxWPODc8prR3zaW35s/bfQb7SYsT8
 t9Cw2byBTbec7KeBjmJls6gUrGIFi4VxlfUIZhZbBN/72Dh2X1CUHyDS1oCak+IekdpohVktmAd
 onY6eW+gFfyo27AFJAQXzsOM/ZefYEiy+eaWc3u76LKY8pGyy/6aEFAZ3Lmo/VBnd0BOCPxCgt1
 5a08IEYKEl6flnu0LrEc485Up9dCk9I1973p1KESXr/X2fm/zaiYiCj2YYulJFIi1HZEclO3LIJ
 QSPuH0mkLnj46NaF5vQ==
X-Proofpoint-GUID: UBJ75RrSkKtQ9p1kcyvx6dqEZWGPd48S
X-Proofpoint-ORIG-GUID: q17DBdulbzxBw15UHCo0O4d-4c5IpvB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120120

The macro kvm_trace_symbol_exit is used for providing the mappings
for the trap vectors and their names. Add mappings for H_FAC_UNAVAIL and
RETURN_TO_HOST so that trap reasons are displayed as string instead of
vector numbers when using the kvm_guest_exit tracepoint.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Vaibhav Jain (IBM) <vaibhav@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Remove the trailing comma after last element

v3:
1. Add the mapping for 0x0

 arch/powerpc/kvm/trace_book3s.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
index 9260ddbd557f..4ee35c6d01aa 100644
--- a/arch/powerpc/kvm/trace_book3s.h
+++ b/arch/powerpc/kvm/trace_book3s.h
@@ -7,6 +7,7 @@
  */
 
 #define kvm_trace_symbol_exit \
+	{0x0, "RETURN_TO_HOST"}, \
 	{0x100, "SYSTEM_RESET"}, \
 	{0x200, "MACHINE_CHECK"}, \
 	{0x300, "DATA_STORAGE"}, \
@@ -28,6 +29,7 @@
 	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.53.0

