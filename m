Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066B4014AA;
	Thu,  9 Jul 2026 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588974; cv=none; b=NsHfFMs/fgUeRc0MGiyvjZ89EKG9EhC/jKhizAhPFeSXijuCeWfJ7h09YmnBh/fdgZ+vdVIxJX6UHhe1CHZJvic0J40CWn3GCPYXxH93WbDKTi6eTGcfPirsDedVsp/fSO6MsbfqQhSPYTLT2cUflqjrKMDsNRleR/fdMAxdLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588974; c=relaxed/simple;
	bh=DovFRHnCJmlUIV1T+I8K3kVXDlc37zRWpHkHjkGBTgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cn/2JgOOPY0p5OHUgYrrqj+tol3N8RRPaUaG8i6vZlP7iya5Ouny1JtyZ10T/jNjjN5jh0ZFYmx7phbWPLjgIVt1g3k4AYFUMYz5GighpdBuVAcgzFCHKFh1Vi0A0GA9k1NZEh5pDrpPCiOPdMXqeObCgPWXHIHdQPgO9vaeQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tSqABjlT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tSqABjlT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IJUM479889;
	Thu, 9 Jul 2026 09:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NeGSAqmHSFJGag8Wz2XVtFVnQa6V
	cSKrL4Vi7h0zPaY=; b=tSqABjlTAXZBBFwukegP6Lnv/DdI72k8FW+HcN4QwJSZ
	MMUYTP4HNU5tKn006a2YtwxrZshgw84PjXMQcCM9fcH5twqQeA94DTVz95XHasqd
	v1+JGrjTxOLW+x4l2k/VfadINIwKDMLnALVX1QsQNI45Ob8dLqWCbbEH98PBT52R
	hEMcOE4+kMNbZbDcvKFCT18mdnGzBovUWFJCfhkU6PLUs5iAd4iAugXAd3f9RXGw
	1SX4urAx7QzC656phE3lKX4IKBkJKyFk+zrqGhgPY2t8dUaeWN77ylYI3yBtSpAh
	vUWsjMii54A6lxJYlyEqyCzAnoZ2VfgU/kNVvL0uSg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt18qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:22:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699JcB9005126;
	Thu, 9 Jul 2026 09:22:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqcp63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:22:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699MQub56033772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:22:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C198E2004D;
	Thu,  9 Jul 2026 09:22:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002C820040;
	Thu,  9 Jul 2026 09:22:22 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:22:22 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v4 0/2] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  9 Jul 2026 14:51:38 +0530
Message-ID: <20260709092140.1753715-2-vishalc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: c5QV_cyQGKsdlNi-IjG1_4omYRWjXuKq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX4UCUFG+KiNsw
 nz8fglEGzjRu/1OiMufAkircPFLm3HkQXQirMgknzEhbB+cwwfrHLFyqKr2QNxkzIvO8mm59t1Q
 cl+itvYMewr9SMwpVrhZk/qgAAQeYHw=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4f6857 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mPUdJBykSDeI_Y7d1aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RNeLL5rzdFstpBDJ_3NNbXXOc5fgknlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfXwI4gTRrwQrcf
 IQqhav6Fhm8EwVyhexyM2izqjw07d07j4xK4pIdiRan/HgT+/r0cNUE43QS8iFlR3Z3T7IUbGrv
 vgNrQUVQo2WNABC7gXH2z/sCxi/4ANKJfSaLQqA2HpYTz5m19soSs7PvZ+kcZ01u/gNK+5jnkq9
 sDVv6YoNYxKncsll+nqHDt3sYf1dD1PraSWNu0umCOR/sfDzm22OGxWzliiXMtAXXlfkdn0clKT
 UrZjngevaZ2909gA/J5uZTtrxwqxmhN/rfHBk6JkjxNZk1eIBou7+4SUvGABd5bznupieJZBGbr
 rfm/CQVMJ+jzde8y/KIl+qCYnhmnHyB6d1hprwn16dnANhvBspP3QqydQvLblyugHy6iPJ2uO+B
 a8jPhUXa282dgnmhSi8qXCIATxuLpMHgUj5iyZVRYkR4NIBaxtl+kfiY2j9wH7jwlCu8833xuCF
 UUhsq+Vp27M6wdddISQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090089

This series fixes a KVM scheduling bug on Book3S HV where a guest VM
under a cpu.max bandwidth limit can run arbitrarily past its quota and
then appear frozen for minutes afterwards. 

== Problem ==

Since commit 2cd571245b43 ("sched/fair: Add related data structure for
task based throttle"), merged in v6.18, CFS bandwidth throttling no
longer dequeues a task directly. Instead it queues a task_work item via
task_work_add(..., TWA_RESUME), sets TIF_NOTIFY_RESUME, and relies on
that work running on the return path to actually dequeue the task.

The powerpc KVM run loops only test TIF_SIGPENDING and TIF_NEED_RESCHED
before re-entering the guest; TIF_NOTIFY_RESUME is never checked. For a
CPU-bound guest that generates few KVM exits back to userspace, the vCPU
thread never returns to user mode, so the deferred throttle task_work
never runs. The guest keeps running unchecked while its
runtime_remaining goes increasingly negative, and once it finally does
exit to userspace it is legitimately throttled for minutes while the
accrued debt is repaid at the bandwidth-timer replenishment rate.

The generic xfer-to-guest-mode infrastructure (commit 935ace2fb5cc,
"entry: Provide infrastructure for work before transitioning to guest
mode") exists precisely to handle this kind of work before each guest
entry. A full trace-backed root-cause analysis was posted with v1 [2].

== Fix ==

Opt powerpc KVM into VIRT_XFER_TO_GUEST_WORK and use the generic
xfer_to_guest_mode helpers to check for and handle pending guest-mode
work (reschedule, signals, and TIF_NOTIFY_RESUME task_work such as the
deferred CFS throttle) on every guest re-entry:

- Book3S HV: both run loops — kvmhv_run_single_vcpu() for POWER9+ and
  kvmppc_run_vcpu() for pre-POWER9.
- Book3S PR and BookE: the common kvmppc_prepare_to_enter(), which
  likewise only checked need_resched()/signal_pending().

== Changes from v3 ==
- BookE: add local_irq_disable() before hard_irq_disable() on the emulated
  MTMSR[WE] path so lockdep's irq-tracing state is resynced, fixing a
  lockdep_assert_irqs_disabled() splat in the following
  xfer_to_guest_mode_prepare(). (Reported by Sashiko AI review)

== Changes from v2 ==
- Add xfer_to_guest_mode_prepare() check for pending rcuog wakeup before
  entering guest
- While at it patch all exit points for kvmhv_run_single_vcpu() via
  done label matching the corresponding trace_kvmppc_run_vcpu_enter()
  with trace_kvmppc_run_vcpu_exit() tracepoint. (Reported by Sashiko AI
  review)
- Include posix cpu timer enablement patch by Shrikanth as part of this
  series

== Changes from v1 ==
- Extend the fix beyond Book3S HV to the shared powerpc KVM entry path:
  also convert the common kvmppc_prepare_to_enter() used by Book3S PR
  and BookE. (Shrikanth Hegde)
- Move "select VIRT_XFER_TO_GUEST_WORK" from KVM_BOOK3S_64_HV up to the
  common "config KVM" so every powerpc KVM variant gets the
  infrastructure.
- Drop the redundant signal_pending() recheck and its sigpend label in
  kvmhv_run_single_vcpu(); xfer_to_guest_mode_work_pending() is a
  superset of it.
- Preserve the E500 CONFIG_KVM_EXIT_TIMING histogram on the signal path
  via an explicit kvmppc_set_exit_type(SIGNAL_EXITS).

[1] https://lore.kernel.org/all/20250421102837.78515-2-sshegde@linux.ibm.com/
[2] https://lore.kernel.org/all/20260626105449.2897924-2-vishalc@linux.ibm.com/

Shrikanth Hegde (1):
  powerpc: enable to run posix cpu timers in task context

Vishal Chourasia (1):
  KVM: powerpc: Use generic xfer to guest work function

 arch/powerpc/Kconfig         |  1 +
 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 39 +++++++++++++++++++++++-------------
 arch/powerpc/kvm/booke.c     |  1 +
 arch/powerpc/kvm/powerpc.c   | 37 +++++++++++++++++++++++++---------
 5 files changed, 56 insertions(+), 23 deletions(-)

-- 
2.54.0

