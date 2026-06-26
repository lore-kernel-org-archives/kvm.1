Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC71A3160
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471357; cv=none; b=aV5dDwcxwD0UKOhKRktEpRo2AaSQ41a8ZmIpevisdgFb4hmR8jZz/SuWuHGWYbFkFLr+6dzN6/UarhIR0SKRaBPTbnVEHAYa9IQ8GkyvUVJOU7C4XZg4RjOALDMcwAYA0g1NCJWE2qCXv/Lxqc1DgJXoWMuACXzA7RapvprTTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471357; c=relaxed/simple;
	bh=rILfz+d+xu/Y6iBQBBBs9lU3q4KKGFv3n3r8Cc8zOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VV5A9tsIFCBjHwNoqyhpRfQpirL0ojdGLdRq+jK2WLJaU9kylrAbi0CFFwl4xvxG7/SxAi3hMFEsITDsxLniydW+ESwrOCU5IIafeEOy8r5i5sZwJsC55YTuclqjqb3X7MT3JkZ4Hvz/xlQVwHlkDQIH5+/8wVH0X7rWSegmXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fc5As4kn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fc5As4kn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIfMr2609129;
	Fri, 26 Jun 2026 10:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=uZbj6Q5+/dZDlEE8RPaEDX+yAk3N
	8DBmxL4lCeBiq6Y=; b=fc5As4kn24L4srhseERfdmW7AuXAxt09fUPOYRR+XVDB
	PWJ3xtzoiGVVGKSDrYDZxe72hmsDXxiuSonOoXPXPIcZBnrq0zNkNWnTlIuk1Kvb
	kIku5tXzJeDhfwTg1dImjbeoszzw11NnsCi7qGx5VOb4Hcv2fgZRhejYJRAM7Ib0
	60JdTP/iIqD5ki1qSgYEYdsdtXD51PZXQZy1pI4NOHpmK81hFcfYsXo5YZpAZSBZ
	DfQeri1q297l+MbbVLzbZo1IrmmC//TGPp7XpUb+GxxYnFvhsbhW19L6YkX8k5nB
	IcVlob3X2oGCL/OmEAHYXq/p3q/Rfuf43wkDYiCEVw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt635w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 10:55:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QAnpt4008468;
	Fri, 26 Jun 2026 10:55:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w02dm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 10:55:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QAtMnJ49021186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 10:55:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4ACC20049;
	Fri, 26 Jun 2026 10:55:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7657B20040;
	Fri, 26 Jun 2026 10:55:19 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 10:55:19 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        gautam@linux.ibm.com, bigeasy@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 0/1] KVM: powerpc/book3s_hv: Handle deferred CFS bandwidth throttle on guest re-entry
Date: Fri, 26 Jun 2026 16:22:59 +0530
Message-ID: <20260626105449.2897924-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA4NyBTYWx0ZWRfXyS+HUVsFi4df
 1OsiXfF0ivIzZxe9PJf3uz9Sv3zdpeQlpSoXKoa9rRcc9X7i7G6n6ocBAvELN901Bv+b3XItIQh
 3l2jJ+nwOLQo56KPKXRX8stsPC67mAvglVMu2a5XMUwwGL7/Otf5fbaCkqrkGnWBEBkg/WwLAuC
 VkFsd/Bux1A5OCiQ8aEYscZojP1kaseTrnwL2pOFC1JlcLzwUlaGskPQhzqvj0mWQqmTMsx2MR9
 jcUQYkjdK4UcCGryImK1V8rTKvriZ93VIHwRzXFxMZgkbaM6Aygu81tDC9ivxg8lzzIFChdSi8U
 O89fADtYWmhwEWEaAKJ7yzK14IHkXkuGs5bN8AbWWZ0hJ0yUdZNB4pRi20Gj8+u1mdSP298LN4T
 Rzu2JvosI7+k4tX54NMw1Tk4Y5khC53C6gl9uF3lQiLcv/oRlOPZO8CUuoSjGfUMf583Pbqj2mo
 skU2p9kBEdoyVsgvm5A==
X-Proofpoint-GUID: BuSO_lQ285eC-ojADLn0EDcifdGFPWnL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA4NyBTYWx0ZWRfX7Up/Dz29RoOF
 15mhEM/F3dnap4HLign/fAV/Il18IQ8BIDObaSZc8PurUWR8i2bEJ9grhP9nL6fENiPAjNqroje
 KTDdlN/0Ie2a1SXz4jAHjBLWrAC90Q8=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3e5a9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Rt15ptPvXg_wHEq7oy0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NVovGK4Mm89IPpgOeIXL97p5GvfuA9BJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260087

This series fixes a KVM scheduling bug on Book3S HV (POWER8/POWER9/POWER10)
where a guest VM under a cpu.max bandwidth limit can run arbitrarily past its
quota and then appear completely frozen for minutes afterwards.

== Background ==

Commit 2cd571245b43 ("sched/fair: Add related data structure for task based
throttle"), merged in v6.18, changed how CFS bandwidth throttling enforces
its limit. Previously, throttle_cfs_rq() dequeued tasks directly. Under the
new scheme it queues a task_work item via task_work_add(..., TWA_RESUME),
sets TIF_NOTIFY_RESUME, and relies on that work running on the kernel return
path to actually dequeue the task.

For KVM guests this means the work must be drained before each guest entry,
not just on the normal syscall return path. commit 935ace2fb5cc ("entry:
Provide infrastructure for work before transitioning to guest mode")
introduced kvm_xfer_to_guest_mode_handle_work() for exactly this purpose.
x86 (commit 72c3c0fe54a3), arm64 (commit 6caa5812e2d1), riscv, s390, and
loongarch all adopted it. Book3S HV did not. [1]

== Root Cause ==

Book3S HV's vCPU run loops — kvmhv_run_single_vcpu() for POWER9+ and
kvmppc_run_vcpu() for pre-POWER9 — only test TIF_SIGPENDING and
TIF_NEED_RESCHED before re-entering the guest. TIF_NOTIFY_RESUME is never
checked, and the deferred throttle task_work therefore never runs while a
vCPU is inside the run loop.

For a CPU-bound guest that generates few KVM exits back to QEMU user space
(e.g. a compute-heavy or busy-looping workload), the vCPU thread never
returns to user mode. throttle_cfs_rq() sets cfs_rq->throttled = 1 and
queues the task_work, but the guest continues to run unchecked.
cfs_rq->runtime_remaining goes increasingly negative with every scheduling
period while the throttle flag sits ignored.

The only mechanism recovering that debt is the periodic bandwidth timer
replenishment: 30 ms of quota is added per 100 ms period. When
runtime_remaining has drifted hundreds of seconds negative, recovering to
zero at 300 ms/s takes minutes — during which the cgroup is legitimately
throttled and the VM is completely frozen once it finally exits to user
space.

== Debugging ==

vCPU was placed in a cgroup where CPU bandwidth limits were set.
quota = 30ms
period = 100ms

The bug was diagnosed using a bpftrace script probing throttle_cfs_rq()
and unthrottle_cfs_rq() and sampling cfs_rq->runtime_remaining every
second. The trace shows the debt accumulation phase, the slow recovery
phase, and the immediate re-throttle on resumption:

  Debt accumulation (vCPU in guest, no exits):
    +1471 s  runtime_remaining=-209702865115 ns  throttled=1
    +1472 s  runtime_remaining=-210402866357 ns  throttled=1
    ...                                    # ~-700 ms/s (growing debt)
    +1477 s  runtime_remaining=-213902833931 ns  throttled=1

  Recovery (vCPU exits to QEMU user space; bandwidth timer replenishes):
    +1478 s  runtime_remaining=-213617443453 ns  throttled=1
    +1479 s  runtime_remaining=-213317443453 ns  throttled=1
    ...                                    # ~+300 ms/s (30ms quota/100ms)

  After ~710 seconds of recovery, debt reaches zero:
    ──── unthrottle_cfs_rq @ cpu=768  +2190.029568131 s ────
      runtime_remaining = 1 ns            # just crossed zero

  The vCPU immediately re-enters the guest and over-runs its quota again:
    ──── throttle_cfs_rq @ cpu=768  +2190.055327252 s ────
      runtime_remaining = -5667293 ns     # 26 ms of debt already

  The cycle then repeats identically from a fresh -700 ms/s accumulation.

cpu.stat confirms the pathology — 100% throttle rate and virtually all
CPU time accumulated in kernel (KVM) mode:

  nr_periods   = 117457
  nr_throttled = 117457     # every single period
  system_usec  = 4334782636 # >99.99% kernel time (QEMU in KVM_RUN)

strace of the QEMU vCPU thread confirms long stretches where
ioctl(KVM_RUN) does not return — the vCPU is running in guest mode
with no VM-exits reaching user space.

== Fix Summary ==

Opt Book3S HV into VIRT_XFER_TO_GUEST_WORK and drain pending guest-mode
work (including the deferred CFS throttle task_work) on every guest
re-entry in both run loops. The changes are supersets of the existing
need_resched() checks and do not alter the signal or exit accounting.

[1] https://lore.kernel.org/all/20250421102837.78515-2-sshegde@linux.ibm.com/

Vishal Chourasia (1):
  KVM: powerpc/book3s_hv: Use generic xfer to guest work function

 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 58 +++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.54.0

