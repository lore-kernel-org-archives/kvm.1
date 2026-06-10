Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA93563FA
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082556; cv=none; b=iTIMOdpqupkBJTPGifeWeRlbPXGfFu3Uia6bsBQuBlzXWJNHI+1Oc0ZQdEBw2P4V/Fh2UpsRa2AqQmOKTrxWZ66X3qW4O68gkodbYq2F8zY/hU79j8gk1BCqO3qKnlV7vgE6XDvNfQibxKjDJvSZbQ63oA0QicxyQ6uAG51sQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082556; c=relaxed/simple;
	bh=qAcrNXzZbVn3K9cJZYYBwgVQs1KXqgOwwd8bn7/LG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oidH50BkX2f6fZmp44eqv7vnxkAGeFq1CMatm2yz6ZZapTwvGks3TTQOXejJ4mYCTg2qJppA7vJZlNDwwMomX4qpQIoIDr95Ro8PoXpi42pOL4UO/COrDX9AWJffTkXtBSTYn+5k+nyVbZkB9fRfjbqU7r5mV+fA9wJnfcNlvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J2/7mSqJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J2/7mSqJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7m0Z03513101;
	Wed, 10 Jun 2026 09:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAO9gO1hKSWmDVv3T
	C2aVGl7+UytZCZu6nN0cvXymbw=; b=J2/7mSqJFCakjloF6PmiAKbap7rWo/LIo
	cJ9affnhYmephcaRU7L7naTjQHcV0ZEhLi+pTG1wUdq874mF7hN5URZIUGUB+I9t
	J4DU2Sldc7MloK7wvoX/KvdeD7Zn50B2a1Xth99co+eKlvBIvPpQsC6xzCXHPnUT
	xhyEXgdhFfaBrCJ5s8S2QDoPh3xhnisPbZflPU7b0tMJ9YxorbIH4bzRikfbQOWb
	7hJcFakwITWLN8IxzovN6xTv8K3WkQrZ60TTgT+UhPYkc/GwZ3I5+MvN41ZX/tKY
	oZRT+2n+XoBuj/8lkUampH/GAZAK0zktacsgrBq0k9o9o8afm0KqA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb240dj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94bUU021052;
	Wed, 10 Jun 2026 09:08:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w62sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A98gGg39780764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38B412004B;
	Wed, 10 Jun 2026 09:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF8D20043;
	Wed, 10 Jun 2026 09:08:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.29.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:08:37 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
Date: Wed, 10 Jun 2026 14:38:00 +0530
Message-ID: <20260610090800.3672832-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090800.3672832-1-adityag@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2929a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Wu8VgyIhYT4XZz0aUjsA:9
X-Proofpoint-ORIG-GUID: IgiFaFSVZyCEBOd-9QYUjy9etMX2hEzz
X-Proofpoint-GUID: -egbwWIFnz4aigFFpyMvPK7QVXt_ACDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX0HznTcaZZ6Nx
 F9PC5NMz1YyZoFQCrEhvjQYzlFaPzaW5sYdLIlg5LmGNmqugb/1GvIGmT1LNLHqcjMSplFjNh7/
 bdgZgi+OgAuf7a90G5fwFwzOFl9rn7d63k0VysRvbbmBn1volpsIUOnvsAlzNPGDwCB2E7ftZWp
 fU/G8eHLAH570fR3jwNy5q23Ne8efRj6kBbBMrIK4ygh+9coK9TVzkcElhQBwdcmDM1cXqV3cem
 ZA/s+8aXiDXG3X0aJxi/x1tVMeg2g9QTWVYeR5iXraYMBC77isxLmM6ABY3wfVwp3nHt8wdxajR
 tIqqTcsRhxaXOQ028rab13Tu7pctXHzmoK8YPdHDwclte1LN3mIKy6+nFJmpG4P4dQ4GvwWrKuJ
 lXomnqX4rKO/ol3ac78eIsMYgKrrHip3kkF4H48CISu6Nva8mvOFFZwDCrPZ0eTB0Shcrf9Zz9o
 lJJeAQUCkhXQDsFLKiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
CPU definitions for the cores

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/about/deprecated.rst | 9 ---------
 target/ppc/cpu-models.c   | 6 ------
 target/ppc/cpu-models.h   | 4 ----
 target/ppc/cpu_init.c     | 6 ------
 target/ppc/kvm.c          | 4 +---
 5 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 97750f5edc91..3930ef08ed4b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
 is theoretically possible to use QEMU to model them. Let's keep the
 CPU implementation for a while before removing all support.
 
-Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The Power8E and Power8NVL variants of Power8 are not really useful anymore
-in qemu, and are old and unmaintained now.
-
-The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
-be considered deprecated.
-
 System emulator machines
 ------------------------
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 26b6debcfc96..aa13654e83e8 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -734,12 +734,8 @@
                 "POWER7 v2.3")
     POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
                 "POWER7+ v2.1")
-    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
-                "POWER8E v2.1", "CPU is unmaintained.")
     POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
                 "POWER8 v2.0")
-    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
-                "POWER8NVL v1.0", "CPU is unmaintained.")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
     POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
@@ -918,9 +914,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power7", "power7_v2.3" },
     { "power7+", "power7p_v2.1" },
     { "power7+_v2.1", "power7p_v2.1" },
-    { "power8e", "power8e_v2.1" },
     { "power8", "power8_v2.0" },
-    { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
     { "power11", "power11_v2.0" },
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index a439eb37ee41..ef019cdb1f3c 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -341,12 +341,8 @@ enum {
     CPU_POWERPC_POWER7_v23         = 0x003F0203,
     CPU_POWERPC_POWER7P_BASE       = 0x004A0000,
     CPU_POWERPC_POWER7P_v21        = 0x004A0201,
-    CPU_POWERPC_POWER8E_BASE       = 0x004B0000,
-    CPU_POWERPC_POWER8E_v21        = 0x004B0201,
     CPU_POWERPC_POWER8_BASE        = 0x004D0000,
     CPU_POWERPC_POWER8_v20         = 0x004D0200,
-    CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
-    CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E1100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d25f69f13ba5..87186ec32179 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6310,12 +6310,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
         if (base == CPU_POWERPC_POWER8_BASE) {
             return true;
         }
-        if (base == CPU_POWERPC_POWER8E_BASE) {
-            return true;
-        }
-        if (base == CPU_POWERPC_POWER8NVL_BASE) {
-            return true;
-        }
     }
     if (base != pcc_base) {
         return false;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07f..78a1c4a8393e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2437,9 +2437,7 @@ static bool kvmppc_power8_host(void)
 #ifdef TARGET_PPC64
     {
         uint32_t base_pvr = CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
-        ret = (base_pvr == CPU_POWERPC_POWER8E_BASE) ||
-              (base_pvr == CPU_POWERPC_POWER8NVL_BASE) ||
-              (base_pvr == CPU_POWERPC_POWER8_BASE);
+        ret = (base_pvr == CPU_POWERPC_POWER8_BASE);
     }
 #endif /* TARGET_PPC64 */
     return ret;
-- 
2.54.0

