Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BE3D1CC6;
	Thu,  9 Jul 2026 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578757; cv=none; b=WXiz+pL7ZMXo0ThxLT8YJhzOAVL4GyzxsCSrNREZzRFnAJovIJQ7+iB2Ru2P2rQJQ2LaUUVIGmH/bfQnoHjOPrhuX2MOziDvfuw+W09otq28TZDlVLoAsNZvtCFI8VrO6gskxzn9Gnl0cMOxt0D4/jy2VUgdLR23BpmwI4A/9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578757; c=relaxed/simple;
	bh=gFj0lZxz0+KvL+hXk8k0/B1N9WpW2Xhf7px/BBriW70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2PiczAyERHElNp7PNvNFOsZKI5NiPEK+z6OTq9hOnf3yW49Y34Tlb/a3jGXRVdHjWB3QmasrVQ3xEGqX7ogBuQcxU9tiV09VrfJndLZf7RJAujlH0UCjKjCggqT8NCw6FeelvMBJV2PzbE04DngqUo2ldDyaT8aVH0FaHTeago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALcypx62; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALcypx62"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IJKJ1391145;
	Thu, 9 Jul 2026 06:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/3KzE70mepYLO1ZdH/Nl4xg7M6YW
	24rDh4sn1CRR60w=; b=ALcypx62GQXlayvuaYKrKCnAgnBch45Dm1GMMU/QlzIo
	Macj9AzwqEj4WYefh0Hocmafo0BnIndJGCRKYddK0m/4sv6ie3srqeqkFcAY0NL9
	Y2qfAWpY3HIaiu3xyMXfedBXkcXPj2Q9TsUxjI0gi7lCjPc4kl0/ewR+nFCNbo2X
	PFqL4JmT7v+1ieFId47Q8BYIQ0ijjx5IqD6/gkGRiav9m/ZKQilui0+E9CAkGUBZ
	8vlxB/VaUOtNI6SRmmpGX3HFRWVlm5oY74WD7upsY+x+bFE/2sw/dEQ7f49nK6wl
	quwyHk/rsXGK2qmBY1hz2tpPkoNNDigPTIWpEcOmcg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp40e3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:32:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6696JfF5023208;
	Thu, 9 Jul 2026 06:32:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwc2jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:32:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6696WD6r31654554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 06:32:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2B020043;
	Thu,  9 Jul 2026 06:32:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7339720040;
	Thu,  9 Jul 2026 06:32:09 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 06:32:09 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH v3 0/2] KVM: powerpc: Use generic xfer to guest work function
Date: Thu,  9 Jul 2026 11:59:38 +0530
Message-ID: <20260709062940.1679427-2-vishalc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4f4073 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jw6u57ldlTClQ2ORz0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX+rSookY8iGix
 1k2gPkBqVo0rrfUqX6uN0qNoNThUYbLuobkDMbYL8XSZqM5HrnjzkA9SqsNxn29jYajFR57v2G6
 Kf6d7mZqyrJzFBgiEzBSMYsAc98AspM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NyBTYWx0ZWRfX6ZwxHYmiEvNa
 RAwNkYK694ikSLA6yupyXvCQfWoMa1BSOpa5YyUHEjck1bQfgLpKLu3j0WkIxfK09uK5t7uqjT9
 c3qYHwnfXDJ9H+2w9SkvBIX4nPM6GYhGB8le1g5flY6jqBJHWJzplr94DgjiWcl073lUtwRS1lp
 iKRq9GBM3dGXmhc10JQYI4Zpbxd5GRzWJ+6D+3lfA3y7wuaFh7ajmfoqPHXtSS2YIkghTp+/gR7
 xTX7Xug+FEPfPKndEjQNPtfCADNKxft7UkZAiQCHaCWrocmx9sE1+EnZ7J6WmximePTakMhzf+s
 zsnFSoabEqIZ2UjbRvZuYDNsxWMVDRv0B8RW6QfgJgifnkajzv0zfUNjsueMgz6bQk/9ARNZ2GF
 D3EJCkCGiCkZvp4ubsTHdvIXZgf8ZCc98c4iyVRSw4Cq7iwB6gByKe8ZQcXgCuE9AAarhtrZ4LH
 lH3o962gCwEy+PjkLdw==
X-Proofpoint-ORIG-GUID: Ci8qxUh5SbIloHvk_KXReJtwF9V5u1V2
X-Proofpoint-GUID: ZglRqUAIeQ92BdjX3vm9U0nYSUQZyp-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090057

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

== Changes from v2 ==
- Add xfer_to_guest_mode_prepare() check for pending rcuog wakeup before
  entering guest
- While at it patch all exit points for kvmhv_run_single_vcpu() via
  done label matching the corresponding trace_kvmppc_run_vcpu_enter()
  with trace_kvmppc_run_vcpu_exit() tracepoint.
- Include posix cpu timer enablement patch by Shrikanth as part of this
  series

== Changes from v1 ==

- Extend the fix beyond Book3S HV to the shared powerpc KVM entry path:
  also convert the common kvmppc_prepare_to_enter() used by Book3S PR
  and BookE. (Shrikanth Shegde)
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
 arch/powerpc/kvm/powerpc.c   | 37 +++++++++++++++++++++++++---------
 4 files changed, 55 insertions(+), 23 deletions(-)

-- 
2.54.0

