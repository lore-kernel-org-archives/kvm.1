Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE1384CCB
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224499; cv=none; b=mQIuYVrbFXj/NStK3gxUy6ZLzHarNwj7O/HaLOGz8C0pcOUj2M0W9NQ26uBZTVnPT+BW0CWwNaveUfZAqApgL5ZLxZPkQ1xHwayGmI05r9+Dlj08HtlQOCGwINSjuDE2hBQ1z8QE5av01O64zBzhK1icYwkEyf6STcbv3DzZcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224499; c=relaxed/simple;
	bh=zbQ529Yb9yntqUpAsXX8GP17KL/hgNuK2CaMdol3psE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyCthB6cFX9NqedQxohe9pHOXzEolV+dMNzw8cBc/tMLAc54J3okUXvpIy8GuYWnRthSyZeXfXIm2mUGZi701EG7QkE63B64wzvwpNKyWckCgAmbaM1p59lYkBG8DcTPpwPGQGxANQQr+axy+xSazjKffGoSN2opEYGBkmCqRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEsrgeh5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEsrgeh5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmPjq2135857;
	Tue, 23 Jun 2026 14:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P4uDls
	zY5DX+rc7NlGrEgGeK9D2NIhXkj4pQ7n1DL6U=; b=QEsrgeh5GyA8xoT/PLz4e5
	MFESBIepPvovh82l5SUiwNKh2Bl6Zwuh89iClr8/pxkoggkMlZr2Jlg29HHaNYQd
	vjjR/K35XB8Ldu7nYoQtc+ff5Aa8JW/7jzeNvCCJekTSTAXgCTHnQzHc1z7X8FGE
	tCi9A0g6pVRnlSpylisXeU44PUZD7HgiK7b3U5dXJjH6+qqk8OEr92WjI22Ram1V
	8M6pgFvap8OiEVY2x0jjy1pkstCHJlCjb4wIWVP7cmwqxkLO9pd1eNE65PUkCcJS
	AGbuGzj2WyT/MsLAz5qpYEPXN2MBIZb2P314iOSVuULJ93thxSSH3+n+AdLNPA+g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqpxka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJbT4005012;
	Tue, 23 Jun 2026 14:21:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykbjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NELJYK53543168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:21:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73AA42004D;
	Tue, 23 Jun 2026 14:21:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B185D2004B;
	Tue, 23 Jun 2026 14:21:10 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:21:10 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
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
Subject: [PATCH 7/8] ppc/pnv: Remove Power8E and Power8NVL CPUs
Date: Tue, 23 Jun 2026 19:49:32 +0530
Message-ID: <20260623141933.577981-8-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3a9664 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=9o66lyqVio6zCVhO5FUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX3DdXbRN6e0DR
 9OjkHDilz4qPVGcpkRhQLGwNwDpDMDSFt2mIUC3VOaNC8Xqzj71grN2ws/fxump77/eDHB8FlB3
 o9Hr3xpUpx9I0UyIPRNBbBK3Piq8Hh6130ncL6qMtclzqUxHy8RKGLRN1T3ZGSP85DWvwEoYdz+
 tHZdiByzykx5KVZfl4nfYdeaU8+ebBRxdMAzqfWmTUbEw+nq4yVZL6sCZlTPu01OH5/R7QtSOAC
 p71MaPMDOeamCUqBVZ61dpUS9Wnlm19oDwue2dCPIDyjA2374sFsScbdpBHBP83+/zz8Wx32rG2
 vBTeOxyIdkvw78AVJDZzGezbYsbSi0wjomKQSI9AQLT38XJrumTjZJ66wNvpKYfKuhvU2WNnvAG
 0l5wvRji022ONwM/FPvSgNE44XYu+NG+YJ1GU80HDBR6bSk+xffmjiBTG9G/to3sktY6oyE0zNY
 kfiYPBYMfPqT/hiMM5A==
X-Proofpoint-GUID: hFOx6T0ZNEEx92IFXN5Z92Xa6yT5u6Hf
X-Proofpoint-ORIG-GUID: -zUnO8SWr6Kmkh_GKb7MrKDsHLUvpT8M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX57CGyZRuf5eR
 8vbIg9w/he0a0EwmErGsIXlEKLK4ZJak9kLqoD5I27iD6t9BEwhTcvdYfY7bgPLy83Hi4C/YELD
 R0ldph4/7a8ZUwvdCGbieB5hvX11x7A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230117

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries

Also, with no use of 8E and 8NVL, in powernv chips or spapr cores,
remove the CPU definitions for the cores

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/about/deprecated.rst       | 9 ---------
 docs/about/removed-features.rst | 8 ++++++++
 docs/system/ppc/pseries.rst     | 2 +-
 hw/ppc/spapr_cpu_core.c         | 2 --
 target/ppc/cpu-models.c         | 6 ------
 target/ppc/cpu-models.h         | 4 ----
 target/ppc/cpu_init.c           | 6 ------
 target/ppc/kvm.c                | 4 +---
 8 files changed, 10 insertions(+), 31 deletions(-)

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
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index d1bea4d75bb4..f7a2aa326dec 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1038,6 +1038,14 @@ initial RISC-V QEMU port. Its usage was always been unclear: users don't know
 what to expect from a CPU called 'any', and in fact the CPU does not do anything
 special that isn't already done by the default CPUs rv32/rv64.
 
+Power8E and Power8NVL CPUs (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''''''
+
+The Power8E and Power8NVL variants of Power8 are not really useful anymore
+in qemu, and are old and unmaintained.
+Hence, the CPUs as well as corresponding Power8NVL and Power8E PnvChips have
+been removed
+
 System accelerators
 -------------------
 
diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index bbc51aa7fcdb..1477028bc5ea 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -16,7 +16,7 @@ Supported devices
 
  * Multi processor support for many Power processors generations:
    - POWER7, POWER7+
-   - POWER8, POWER8NVL
+   - POWER8
    - POWER9
    - Power10
    - Power11
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 41e37103c043..9a9351991c95 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -408,8 +408,6 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
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
index a02187ce5afb..96daa7e2ab0b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6311,12 +6311,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
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

