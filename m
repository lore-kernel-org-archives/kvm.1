Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A9445AD3;
	Tue, 11 Aug 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457027; cv=none; b=e1kxug4k/Az2+yYu3fRbnHNKe1qs+wrJBbJbfbdnmlp6/dpKOjBfHAXtKt//+IcRXWKINGWXSzAg3tpcs0FMZncLCpxFbf7WeJ4zp2rtZ5lqpmMfQzqya/SqmpNS5GMYk/3nae2usvCLhQpgrZftpzqGmbytcOHbuCWjvoP5aNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457027; c=relaxed/simple;
	bh=AkI5PIvNMijPqD80ONSRCsi77Pd+04EdJQ8RHPgUgkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB/zWHMFS1STxzqerQgdSYhgOIdPGWZX10fm6nR5bIqbfZrF8qHAeEpBolEMpaiuFZNceDSy669z5nEI4CuKJV9iCiaB7qus0XdllUAXNPglxJCKrb6QFa0ek7TT0plo8mmD+yNOPE+SZj04Tqd13EowmWh3TLII5HPfbpw+rcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FcCXUEwx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FcCXUEwx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXAIk569992;
	Tue, 11 Aug 2026 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z6IXOIpdpQznsNPd+
	qftb3KOHokP0NhoXlYJAhh6GXs=; b=FcCXUEwx2f6NvdDKLNEUIXWqHqAX0W2eM
	v4pbo/14FIEiIvoCr0RrgKF86bWEPhQULr5Hh0cPq5z4ZgE75eiccqofcGYErzRr
	61qwpsSuFtJ/ZtzbmKg1m04+PT7LU70xhT1T0sBrP0m+Uk0I0Jk+JUwid0PzAjWh
	Xbo5qE85CD5ufpZWmWyrJ6J32t3B6omYNQRm5VW4a7GTYLPXKvuiXM3yvP7LlzTG
	sJqwBSXq3NaLAZIE6ivcoUliTEMIfUeMCl8LuOowDZ8aL7I4YZtI87p1iC2Qzzfd
	d7S3qHA+rfKqQb5ZSn2pM0riOvjXt3NDR1NRdnKFvmxQ8t7g3ymkw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4kt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuHfn012719;
	Tue, 11 Aug 2026 14:03:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g92by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3TuX36831504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26162004D;
	Tue, 11 Aug 2026 14:03:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A599B2004B;
	Tue, 11 Aug 2026 14:03:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:27 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs
Date: Tue, 11 Aug 2026 19:33:07 +0530
Message-ID: <20260811140313.15397-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811140313.15397-1-gautam@linux.ibm.com>
References: <20260811140313.15397-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2bb6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8UmGTkYCL32R6Bbc0TMA:9
X-Proofpoint-GUID: D-nJeyP14wjrQolOxb6Gm6rNb85ea8-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXwjtu/Jxl3SZe
 gfncvTXW13LD3/Yh7DlgBd1CB9k+BVPFmI/msxF3ZZSgdt4AroCDradbNWMvcdO+5Av7lJiy9an
 DS0QLYA9iOaFvaArYLh+8k/9wgTTKT23i5DTj9JdKvyZajslHEusQUakNGBeP70NwrGuX91uRUQ
 Hu5owhFRMd5rMteWJkyIMY6vHX32GXYBKaikeJvZK6yOR2BKcrj2f3+fIa2i2qWALy/3/hirvAk
 +Iid5D0pE8qQNYTaqLx6St44cU7boOTFXfz8w1mF/KNWhAdIMHVzHN3RMkF0qIKtMed2Z5qgP2t
 ygBoVTIo/54CbgFhoPW9jOdB70EMj+SezY2ARpUFUmcnuhtwcPV18IQ5Eg4tJXeahv4ELxrX+So
 Tb3Ghmdutv3issEb0XXgUMcqNYJJ1cGhZj48cNZhnmLfdcMcp7arombPoU4TdD4RcCqcHeyhTOD
 258QwRsQkBBfmpSQYWg==
X-Proofpoint-ORIG-GUID: vZ27zggUO2WVRtHJwx-Z47FiDl59PRE-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXxPZtrC0ErRhc
 FuTj1s14RIW0KtwBkh1TrEKiXpuztzl+1Ui9MPDuyVfhIWSiKVaGnbMIYMqaQzQVdyxV5eJnm9o
 3uCSQVjzdeU0EAIy0AnwmVLBZH89Pm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110117

The variables in vcpu->arch currently store the latest values read from
PACA when the vCPU exits. Change this to instead store aggregate values
so that every vCPU has its own record of total context switch latencies
it has accumulated. This is essential for the vpa-pmu driver to report
correct numbers.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3cfe9a7be9c6..0e8a959122a8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4164,12 +4164,12 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
 	trace_kvmppc_vcpu_stats(vcpu, l1_to_l2_ns - *l1_to_l2_cs_ptr,
 					l2_to_l1_ns - *l2_to_l1_cs_ptr,
 					l2_runtime_ns - *l2_runtime_agg_ptr);
+	vcpu->arch.l1_to_l2_cs += (l1_to_l2_ns - *l1_to_l2_cs_ptr);
+	vcpu->arch.l2_to_l1_cs += (l2_to_l1_ns - *l2_to_l1_cs_ptr);
+	vcpu->arch.l2_runtime_agg += (l2_runtime_ns - *l2_runtime_agg_ptr);
 	*l1_to_l2_cs_ptr = l1_to_l2_ns;
 	*l2_to_l1_cs_ptr = l2_to_l1_ns;
 	*l2_runtime_agg_ptr = l2_runtime_ns;
-	vcpu->arch.l1_to_l2_cs = l1_to_l2_ns;
-	vcpu->arch.l2_to_l1_cs = l2_to_l1_ns;
-	vcpu->arch.l2_runtime_agg = l2_runtime_ns;
 }
 
 u64 kvmhv_get_l1_to_l2_cs_time(void)
-- 
2.54.0

