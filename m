Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D53FD159;
	Thu,  9 Jul 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589027; cv=none; b=LE6uFxFhUMJiPBrmeBdqf4RSSecDl8eaPzcheA6Kq7O9dflSjuIL9I+464vj+IBm+W981x4iTrS/9wMjtO2+JMp/incOzeohNt50zC35Ozi0jFicdHjsVkPzC9qZgxtA03jxY7zbwdeKdDhWT4vGZ22EcK/iV/GnGuJIumiItY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589027; c=relaxed/simple;
	bh=uGARIkyd5nWocVaiCAyU1yMKm+SrL70rVifA3v71IYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYHIxW7f6D53Bc+7qiMZnAK9TBoTerCIO2IAuJeJPGLUGkqrl1R7xsvDvEebqZlrVaqbw0aJndVKpk1ukrs3+LMKZhvy2qtR1lnHx5801ApIyBxQc8+V60WQhGs6PN/pQmj91RNecu4jWJg+E4Knyn/77BWq9pLE27S4m42fbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NHLHNnbv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NHLHNnbv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696J3EB755146;
	Thu, 9 Jul 2026 09:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XHDyqvIeZnVBrHvWr
	l/7yzFTr89ncdycj/HVWubaQnY=; b=NHLHNnbv09Q+NruwZ19LthdmqCGAYTp1M
	ZTDk348qXbFn+9/WRSPwsCJidZW50NHVysyIvrv7C/lz9oQdD/Tr9r4OhEt8So7V
	DoM/2Ky/e41rqLNYF3ciRhNkx0NNjNSUDuAOltGPN8WrTPAvQioLyGuh0KdYPBd1
	3FTXMLL1Mj4CP/oJAzbcBi87Rya+38ikIwyXaco1XbtCT69BrY6VZuWvcE2f4CAt
	uKXGKUfecyX7vHrGCInwADmEYMCHAzyhBx61roCOG4UUEl13EMfURKuPda7ijes+
	O4lKUmq2Wq/x1fVMWx8bXUxvZZNtbopuiwaPbSWTrlXHsQMzB3Ypw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke1bmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:23:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699JcEA005264;
	Thu, 9 Jul 2026 09:23:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yc50s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:23:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699NQ3f8847750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:23:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D2A32004B;
	Thu,  9 Jul 2026 09:23:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 720E920043;
	Thu,  9 Jul 2026 09:23:23 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:23:23 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4 2/2] powerpc: enable to run posix cpu timers in task context
Date: Thu,  9 Jul 2026 14:51:41 +0530
Message-ID: <20260709092140.1753715-5-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709092140.1753715-2-vishalc@linux.ibm.com>
References: <20260709092140.1753715-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4f6893 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rh6EaQSAbPCCfu5Ue3wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX9M65HO9bk9Kv
 QeayrZIWlipXBM7aFTqIk2Pnn8h10lmdbgwYTwb+70CxS7S3/mC9YratLVEKxKYK+nNISPxxp2M
 Juz3/VGkdI3lQxglVFX3NF7gpGSh8W8UroGbgtMdiJAm6B4cxO48LefseIOHZgRM5fLojT/0nBG
 uN/Gfodcg9JPMVMXAvenQvRUwvJ++C1ZH2cR8NF3E/br5qNNaPCB3DbmERQXXC0R3Ot4dNuF5b/
 T0DduoA8SzMthjI/khl32pNcAasvcgZfIrBvAKtjl7OnUkXZz1sIhfRzktvPjj9fxp8md9SIHUy
 wGgWzQMsjNNs93Vss1pYfxlCiqdILW7Q3apq0pTxXGSMzvALZE3AsnEka0N+0A+DPbUUc7BaQoc
 jE1NtXMz/8sBzIuCXQ6JsMnG69YI5Od0Q4075ORZhR91isd0BP4Kc6VX9WJ3oa0uWBDbhoZbFzD
 C4k02wEBlFS0pKIatbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX/g4j9G8pbr4T
 Ruj1pZuzLuhLornNrxyotlzUx0BcfGIXIv9aBcJOwV3sEIhazvxtvx6EyDA8/MpQQ6KjL0wHn1M
 lGVk3Y4GSfJ6CrxXTCG+tz50Ks/2bDY=
X-Proofpoint-GUID: TyHz6_bMei78SoGxcoI5LkCdRo8rmwdq
X-Proofpoint-ORIG-GUID: E3fzBmofM45xj8x8tuMYtUdFv-h6VKrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089

From: Shrikanth Hegde <sshegde@linux.ibm.com>

Now that all kvm entry to guest paths handle the task work
using the generic framework, enable HAVE_POSIX_CPU_TIMERS_TASK_WORK
which allows running posix cpu timers in task context instead of running
them in hardirq. This would is a necessary step towards enabling
PREEMPT_RT on powerNV systems.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7ce5fff81f0..51555a0b1a26 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -281,6 +281,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_RETHOOK			if KPROBES
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
-- 
2.54.0

