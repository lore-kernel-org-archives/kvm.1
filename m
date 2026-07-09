Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CCB3D3310;
	Thu,  9 Jul 2026 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578801; cv=none; b=ZQQj0r2QeL3BsS38fHsX9ILSxe1dmCYu0Rbu7Vg7b0jwrUs0m6l7gN7bZziq8Z/RTXvDk79EVIoueh8O39GZS0dV1EliGUnaUGPAuTQQOC12HnkYwJExv+kzU9xoJbPKqD6rw0U6fy0oFBCRGWVNAVB+pX4V34ldP2YP6hZ6Qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578801; c=relaxed/simple;
	bh=KfRs0zVnLsyF0lGYhzcOLfpMjZAYz1dDW7ZOOWp9bls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwDI3FpNYzjlIP6SeGlGgGBPi+fwkRsioVxGoGsvxdzhArdJmI+wwg3GjiOwatI1gT//o0WL1KuI2a6umnNQT0UBK6MHc/KfRXhEne5MjgjCDlEITeDnGuf1Q4DCvRfsPVDh5gX3qd04D61vvLbhXQ4mFyMQ/Co0HtETYQqSKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZnzT25Re; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZnzT25Re"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696ILfs1897187;
	Thu, 9 Jul 2026 06:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sqL3q7hIixuKVwjG7
	GithS2vRWS1tvYVOKDRgb0HbuI=; b=ZnzT25Reys2P3Snj5i8wf/3r1XOUVKQDA
	OO5vf4+JXBjY5BT5ecoXpRtY+2hd+CFud8YU7EyVlihUbXB6nidGYfXBqpGYmxRq
	qsPU6iyt5Qfc2Bbg0LA3og52VR4S84Hh3upmDzE4m2tQGYmq7YeeOjKDQI2ejtPH
	hUv5cP5AXfrEt+Wa0AJXT6EKWQFzAihwtvaPh5tUpzZVyFcrlS5q4ahlTkc00VDl
	ykYagUpCHBXDxhUXKFomsNshovBfPJYfrkyVbR5DQjBc2zsUVjGEw4kJxSFLoIWQ
	gLuxZnPjR+zJy1qVbgnvRpoPLlRk2RpCL2XTLJ+bh40zc4oSOiNpg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0316-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696Jbhs007590;
	Thu, 9 Jul 2026 06:33:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgbpbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:33:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696X2hf13697376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:33:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 662CE2004B;
	Thu,  9 Jul 2026 06:33:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8F720043;
	Thu,  9 Jul 2026 06:32:58 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:32:58 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3 2/2] powerpc: enable to run posix cpu timers in task context
Date: Thu,  9 Jul 2026 11:59:42 +0530
Message-ID: <20260709062940.1679427-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709062940.1679427-2-vishalc@linux.ibm.com>
References: <20260709062940.1679427-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX6/pcE0+XHUDp
 RKbkdGKB4FHI4WW9mX+I9netXDaqlheSU5yLHM7aeXnlwgKunbEW5FS4O16r5YIx/vGL2TrZStY
 TTetPjzP3xMO9ppr0PwEnWewEjOMQnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX4JQMFtcNs+Hz
 QzJ0l85vOqQj9/1608slUzf/r+/oWOv5eqjYpVqQqlTaI1XIV2dqSuYkgBi2sqCOWCDK6Eg99r1
 XL6AIk3PLvfgiRGe1Y2xRwqQYZguJM6cKuEwoQ18aEK0z9xrUw2VXjvoeRy6rgsjTN1h3dFsKx7
 ClBkPluK95B5wocuRLtTzTt7oVzkBIrMcRWZ9lechNGdzqX+9OyJPEYHXlnmd8T9RB41wb9Hdf+
 zi7NQO35KjQtCwMe5sbft+jZ3aRintLusnNHBLpMxNQu1lzF8RJn5EpmTaFwH75QurnAFBfEYMa
 xj1HqxUSfUM3ksE6OD8gR3LWxISqZM/A8EMlFqqlvD1nQVbfEaqZsoz8J+IYhE213iK14tKp7QL
 C9eRuIHyKKayFTP3G/s+t+PRkuVkPte3e4JpN+JnyxXUxVIJ2QAtBN90vt/CKF1HJ+x7g+Hp7VN
 ugtBs4Jke6O/YAaY/RQ==
X-Proofpoint-GUID: yEIgEwfQtYazhRWS5Z5rWyY5OXhjMPHs
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f40a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7mPU114Ar3IJ09b1OIsA:9
X-Proofpoint-ORIG-GUID: DUoshtoKsdss-swwmIVeHa4UdgpkqwAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090057

From: Shrikanth Hegde <sshegde@linux.ibm.com>

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

