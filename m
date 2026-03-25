Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777378F7D
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774404817; cv=none; b=F2tp/UaiB9pS0nsmTHLwoW5ixuyoWDj31tppNiHtKKjo1QGcmuNLR1OiksBIryoZhgc3bXpjUVi7bsWHCWgLBTrXeL+MiIu232/wcyK+dHTxg/8GIOaDPiqAjVi8/zRTqkQ2UvzbtG/Mr4VBhjf4C/IonG4A3w2mLLyimdyqS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774404817; c=relaxed/simple;
	bh=FYQLu7BzlJy47i1B2l1Nu4k7xGFkXTBh/XeWXUyqaEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmM8R6n6RbLtj9TUQk5WlnX1Yf0S/808okPUWEZMPEbZ8HW8vT3NrdEBFjqV6rl1FEuG++2oFz4bMPqq7nMkSDxTy7VeVOsJTj7/Hg929YXfiX+vSTichakcJOXHof4pekhBSic7oYhMoQttQCnHmUTSlMFiluXn+vV2eLF9kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IRBm6sJV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IRBm6sJV"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OMBoep2196018;
	Wed, 25 Mar 2026 02:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=LYrFKJz+q9bEfB6XK5DOHNwDk5Yff
	tXOt1uk0Wsg9SU=; b=IRBm6sJV6reDJxgcrz11gnIF5E2NgP9NvxO6w4CHP12mr
	nB4R6s6vCCd+Wu56dVFZCoZXOV88Eej+oTKDm8lzu27C2Uv9gBDILCubn6U0Qz0j
	bEC+J4wGHK+Jr2NJi38rxRDsDNNDJK+I+E/iobmYhubaE6cKzQk9vWAusP88YrZr
	oO8UUgGjvQxfLWOmwovf+W62K583StxI96uUpSkLbc/vhie4v5I8Jf4vom0wxidA
	AJBhbWc5YXK40j5Y9UfZdauVbnGPYVEZRWeAUu+hLFDdd6g7MxwTdmbBG4REB4mI
	PvwsoJhnvKG247+Dzexms9duo/pyDXrnpd9Lahovw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfnfp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 02:13:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ON6BPm012401;
	Wed, 25 Mar 2026 02:13:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsgt0uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 02:13:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62P2DNwA037166;
	Wed, 25 Mar 2026 02:13:23 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsgt0n9-1;
	Wed, 25 Mar 2026 02:13:23 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
        dapeng1.mi@linux.intel.com, zhao1.liu@intel.com, sandipan.das@amd.com,
        zide.chen@intel.com, joe.jin@oracle.com
Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU getter
Date: Tue, 24 Mar 2026 19:12:36 -0700
Message-ID: <20260325021236.14574-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603250015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNCBTYWx0ZWRfX7kzJb5azxOc0
 6o0KQeqE5bzdytkBiWYa/SvUiZOYzRhr0d5hfVeh5IVyr+fJ/JlXt77xaW/rQQNp9hupPqfb7ZB
 Vp3z+zfsS3kuH3en260EaCNbXuF64p/RTLy++B5+/7seGd9PYz2+0ZR0qogBhQp19mU55wv/3IQ
 NRxasQj9TobOqMpTU1ZgfXZtNAELi5Jyjh3HN77N6bnmxqxv0tBhtoPZneM+5O00t7Ruv9EPIbT
 Tadc6xsJNP9Yh/M/GDgxENDRujdGGFvZFSLh29aZT/oCqBKb7TlqCmzlNdQ6jPcujhAgOWZ/rLz
 0sg9gjBAdvskLccjq01Jpme/ku+o6BPuZ9847K+smeNqwQEj+hG8EK87yiHd2hBF2XFs98tIeMR
 t60rUZW9aDmHCRVJlaJd20o9QDhptZ6FwSTAhitY8n/QAXNAywLfqy/ViYxAI8QYgi+KIxWaMLu
 +aLQI+NSFYKslRaiEzNHtif2K2AC7YdC1gvLi1pY=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c344c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=1y-OzW91WTj5pHlFRr8A:9 cc=ntf
 awl=host:12272
X-Proofpoint-ORIG-GUID: unwITvswENtPoXWq45Zl40YYPNS7rLKl
X-Proofpoint-GUID: unwITvswENtPoXWq45Zl40YYPNS7rLKl

For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
behaves the same way when PerfCore is unavailable.

However, once PerfCore is present, AMD PMU switches to an interleaved
layout in which selector and counter MSRs share a single alternating range.

MSR_F15H_PERF_CTL0 = 0xc0010200
MSR_F15H_PERF_CTR0 = 0xc0010201
... ...
... ...
MSR_F15H_PERF_CTL5 = 0xc001020a
MSR_F15H_PERF_CTR5 = 0xc001020b

The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
reset") added the getter/putter pair for AMD PMU MSRs to clear them on
reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
addresses for selectors and counters. env->msr_gp_counters[] holds the raw
counts and env->msr_gp_evtsel[] holds the selectors, so with the
interleaved layout we must translate the MSR address back to the logical
counter index instead of treating the interleaved slot as the array index.

The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
the end. And in the reset path QEMU simply zeroes everything, so that use
case still works.

However, the live migration is broken. The PMU state is stored at the
wrong indices, so the destination VM reloads mismatched selector/counter
pairs. Fix the getter to use the logical counter index rather than the raw
interleaved offset.

Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 target/i386/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..b4e549c62b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5239,9 +5239,9 @@ static int kvm_get_msrs(X86CPU *cpu)
              MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
             index = index - MSR_F15H_PERF_CTL0;
             if (index & 0x1) {
-                env->msr_gp_counters[index] = msrs[i].data;
+                env->msr_gp_counters[index >> 1] = msrs[i].data;
             } else {
-                env->msr_gp_evtsel[index] = msrs[i].data;
+                env->msr_gp_evtsel[index >> 1] = msrs[i].data;
             }
             break;
         case HV_X64_MSR_HYPERCALL:
-- 
2.39.3

