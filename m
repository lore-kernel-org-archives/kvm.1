Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29226ED41;
	Mon, 24 Aug 2026 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535478; cv=none; b=krKsmVmwKtOn9hppQUqAnwmO8dT8ZsGTU4qnl6w02Rt+TYsa0SJuYNpWH+oEcsNq4iB/Hw+T+/rMrSUXEgmWlNU0LbYzptOMVVppoZLLePQjE3SK/X/VVzvHvLW6w2froeCcrCCsmflpSTrlpfjEFfVUflpTXuEvTRxR7/kKSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535478; c=relaxed/simple;
	bh=xYk3G5n3q7HUXpL8T9+x/Ddjslxw8flt7jYNR6jZH0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz40O6N+mEsQSgAT12HFBLm42Aqmmz+0W1ppRkbXHLV/9Bz5IZ0hRQOp4aMvnt4sXHbAOMu5MK57+UQ9GHGfrLHmUSIr1O/zJRTNbz35M9emu2587fadoR8S8gPtflMgyUIi5V11sO03L6i4pbVroRFpxNCvFRAlVXK6Wa+Ugd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UGswGmTe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UGswGmTe"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O002fK4065363;
	Mon, 24 Aug 2026 01:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Ln1PN
	JEgaFgPv0EWZjy3H7QVOvoVxTYd/wN3smUWm38=; b=UGswGmTex8DG3GOR0JV0g
	muzgyEhmSTTGTzvKxbSESjhVCjiMJaaU0iOoCp58twKW+o97mN4ZeHnXK9pPZR46
	q7CClQeihteLKYqe0XaBFqjPqOB7BjWeJC58gvH6orIMk3+SJser90zvmhN+PSBX
	dtVSJJxngnqs3MCXIQPM5aox7lk6UUQ1JQ/AF3+vdx6d4fUwymU9gO4WUle/7zk+
	qzQi2fM05bBe2Rr4eiA+8Olho1jZIUnUwBFkhkGOYVcrbMX+1dGrKZQeolCVqIAU
	l+xJPYj6HkSbwjGZKuxpBh7wY7V/WO95Ux5rKeFuTqh0J6zQN5M8G+BHR+sEQU7Z
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72j1sdqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67O1PTFS036807;
	Mon, 24 Aug 2026 01:32:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g84kh751c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:46 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1Wgn5010282;
	Mon, 24 Aug 2026 01:32:45 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4g84kh7504-3;
	Mon, 24 Aug 2026 01:32:45 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH RFC 2/2] sched/core: Defer preempted remote vCPU task clock updates
Date: Sun, 23 Aug 2026 18:26:26 -0700
Message-ID: <20260824012716.753022-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260824012716.753022-1-dongli.zhang@oracle.com>
References: <20260824012716.753022-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240010
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfX+jO7vn5pWmHP
 XSRSBbh2fLierY2DhUr8yIxip8oYuVe5acZsuE0jWGtXtRsaZ3ufFVP+GuBpFMnwSVTR9+gncax
 A7jsZmwCfPRk8FpxErue/Z6QEP0tfaor1mOKOijcGzJvwoOy5VQ/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfX946IGNcRgsJm
 O6maGifenmp9t23/2Mus90biwhVLT/jr7QZGDAlmpRA1gMGTLRZsallJCZI3ioZAiqg0SXJzdxv
 VifkPrgJYEBrtiQ+2PPgSH0EWX0DK+zICNzNjKBOX3EdFFzdvmyGgcnfaUqIHNLF7I8BAFMdtyF
 +oBXN/CZJLdh8i2j/eTUFIxqX1Wkp8IPAunxbNapXE4sFBy/0ytauQ+PVpD5dPrDYYnoq/I+524
 dEXaHU2fXbmWs3+YdB8cixzasWjxUCEYsB8xfDOJ0NGFndubpqrQQQT5O7MJKgrvXihklXqT9lo
 1uTviD25fsk2juKLBLHiXjbO0VYIeJJ7bkmirobyqH3x37velVxOz4Sv9eYgCeHhSZkC8+LhTJq
 ixzWdnzWC3duDID5UInzIlHuVx3H/09or765gOvVWex3Pmedy2a94ECdAUVrWasP0dTI+ZwEu+0
 6HgtURh6NZZwNtdtcBpi+SExj3TwyATD2Rs1X/NE=
X-Proofpoint-GUID: Wd_m6mv8r9seKVD9tv9_LILeFdTdhQTF
X-Authority-Analysis: v=2.4 cv=Wek8rUhX c=1 sm=1 tr=0 ts=6a8b9f3e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=ayYQXfPqRRTaTnvsy0wA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: Wd_m6mv8r9seKVD9tv9_LILeFdTdhQTF

A remote update of a runqueue can advance rq->clock while the owner
vCPU is still preempted by the host. KVM publishes the matching stealtime
when the vCPU is about to re-enter the guest, so the remote CPU can
otherwise charge the stolen interval to rq->clock_task.

Defer clock_task updates made by a remote CPU while the owner vCPU is
reported preempted. Fold the deferred delta back into the next update
that can proceed so IRQ and steal accounting process it together.

This requires the hypervisor to publish up-to-date stealtime before
clearing the preempted data.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/sched/core.c  | 24 ++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f78275192036..56aa439182c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -816,6 +816,30 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  */
 	s64 __maybe_unused steal = 0, irq_delta = 0;
 
+#ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
+	if (static_key_false((&paravirt_steal_rq_enabled))) {
+		int rq_cpu = cpu_of(rq);
+
+		/*
+		 * A remote CPU can update this rq before the owner vCPU
+		 * has re-entered the guest and refreshed its stealtime
+		 * state. Do not charge that elapsed time to the current
+		 * task until stealtime can be sampled after the vCPU is
+		 * no longer preempted.
+		 */
+		if (rq_cpu != raw_smp_processor_id() &&
+		    vcpu_is_preempted(rq_cpu)) {
+			rq->deferred_clock_task += delta;
+			return;
+		}
+
+		if (rq->deferred_clock_task) {
+			delta += rq->deferred_clock_task;
+			rq->deferred_clock_task = 0;
+		}
+	}
+#endif
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	if (irqtime_enabled()) {
 		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..4fd00228afef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1325,6 +1325,7 @@ struct rq {
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	u64			prev_steal_time_rq;
+	u64			deferred_clock_task;
 #endif
 
 	/* calc_load related fields */
-- 
2.43.5

