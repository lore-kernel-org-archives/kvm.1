Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E662175A85;
	Tue,  5 May 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941180; cv=none; b=avryZ/TddFBtpw6eLEv7ZyAJi0BWQVavLTOIRWV7I/fDq2Yu6KMRiuCKprW3eWId+TM0twMOv5eW+cdhNJ2vSOwXiq0dzx3lZPYFicVG2HVAHKkJVpDGE0xorJAv/EASto7qG/xYp1lEq9m+KDS0izEQt84oIqFQ2ZryQbGyLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941180; c=relaxed/simple;
	bh=myaxIaX9bf6fqa9uiEURUxFFJn2fzZDsH5/vz4GBWCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS50ckqShr48auqYLWWiB5QaHXvcQ1FoAMAvjWi93Hypt8dW8xfy9WoLjXP0GxC1/Q1siElFqAOcx3kD+J5heVvQpivekDO5vqbyxech8c/Gt0iLxbpvxRfRteu2BOlTzFxeRTew51XTxzYCANOC7gi/+R6rRGVviWm3gcKfSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hb119nYA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hb119nYA"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644I3vHo250500;
	Tue, 5 May 2026 00:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gKOm5
	SvWyJeeJorwvHnm6f1ncnArZCwFOibmWIZF/pE=; b=hb119nYA/c+ypeHQUiz8n
	4ZpDs5TjzZbD1o6dr38uJG3+laL81CP1FrSui1NagzFYXTsDja8xnNDnns2ZcHwD
	HaogofoaAmLsChNQ7UcCACGgoyMUimv8DdsisRW7AY8A1sb4L2/9B9/KTdyXk+Us
	pSCrCXFdctmFDzZEjku8nrp7NNwwgnw8e1l/7CjtoYGCLx938HITaFuQm8ULWMk5
	LrimQN1cqC34c5UJ9WVUymOIFMx7wILafoxqvaXtsyMfhuprWmabnriCeHssOiCN
	pxPWjJWdFH8L+W2ra5LBTXcldBfsx69xrN2avAYFUxMnIKAvCTWQIWti/8AlYqpR
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e1c06p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VGel007014;
	Tue, 5 May 2026 00:32:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:27 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5X001260;
	Tue, 5 May 2026 00:32:26 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-2;
	Tue, 05 May 2026 00:32:26 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, hpa@zytor.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, jgross@suse.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH 1/5] x86/kvm: Reset prev_steal_time and prev_steal_time_rq when enabling steal time
Date: Mon,  4 May 2026 17:30:14 -0700
Message-ID: <20260505003044.78693-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260505003044.78693-1-dongli.zhang@oracle.com>
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605050003
X-Proofpoint-ORIG-GUID: dSfiiVMfveQ2965z7auX2ZEBNd8A2mKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX4zIa8eA9yyRM
 6J4EfwaxcJnRhcgioMit4Y6YR7j7Le6/HpqPheuLV7DVINo2ZSxyYba34dQUwKfnig64gG1RU2D
 KXOvYwiKtrF1WLAvJN7YR0FEe85frYZahuQ/l/WbYpFllgmJMGs+MDleTgZ2MYCQxMrDs4Tiwys
 WYRRe77TNL3EPv5uS+3baXZHrdAavBrxOZI+BDt8fCShNELUSsaBaxwwln57kLfG9yzl6TlvndW
 eLxgqz91YcJG5Mwx3WgEBBBKsZsJHR6jsLLelpou7nP+UuWZ0zJIQN9ZZX4xsjq2xEmBlotBCHg
 Bqi0q9nziLKKvvIv90CkPKovrarLe8S0/0CeFDiM8BJUARUlMez/REoIPVANnVzQeulbbroHPMC
 CyKscSuUA7fX7wqbO3RoF5CQPLOu4oD2XDJ4s16rgwSF2VTJ/fuBReTNdvC6XJ88o3HnjMUlDzy
 +QzXovfZWGvivR6dkBw==
X-Proofpoint-GUID: dSfiiVMfveQ2965z7auX2ZEBNd8A2mKI
X-Authority-Analysis: v=2.4 cv=OPAXGyaB c=1 sm=1 tr=0 ts=69f93a9c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=-G8wzUU2UffRpiCYI1EA:9

kvm_steal_clock() is not guaranteed to be monotonic, especially during vCPU
hotplug, and may restart from a small value due to a KVM bug.

Since per-vCPU prev_steal_time and prev_steal_time_rq are not reset on vCPU
hotplug, they can become larger than the value returned by
paravirt_steal_clock(), leading to incorrect accounting.

Reset both prev_steal_time and prev_steal_time_rq when enabling KVM steal
time paravirtualization to avoid this issue.

A fix for the underlying KVM hypervisor steal time accounting bug will be
addressed in a subsequent patch.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kernel/kvm.c         | 40 ++++++++++++++++++++---------------
 include/linux/sched/cputime.h |  2 ++
 kernel/sched/cputime.c        | 10 +++++++++
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 29226d112029..819abd3a9a26 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -328,6 +328,23 @@ static void __init paravirt_ops_setup(void)
 #endif
 }
 
+static u64 kvm_steal_clock(int cpu)
+{
+	u64 steal;
+	struct kvm_steal_time *src;
+	int version;
+
+	src = &per_cpu(steal_time, cpu);
+	do {
+		version = src->version;
+		virt_rmb();
+		steal = src->steal;
+		virt_rmb();
+	} while ((version & 1) || (version != src->version));
+
+	return steal;
+}
+
 static void kvm_register_steal_time(void)
 {
 	int cpu = smp_processor_id();
@@ -337,6 +354,12 @@ static void kvm_register_steal_time(void)
 		return;
 
 	wrmsrq(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
+
+	/*
+	 * This CPU is not ready to be scheduled yet.
+	 */
+	sched_steal_time_cpu_init(cpu, kvm_steal_clock(cpu));
+
 	pr_debug("stealtime: cpu %d, msr %llx\n", cpu,
 		(unsigned long long) slow_virt_to_phys(st));
 }
@@ -411,23 +434,6 @@ static void kvm_disable_steal_time(void)
 	wrmsrq(MSR_KVM_STEAL_TIME, 0);
 }
 
-static u64 kvm_steal_clock(int cpu)
-{
-	u64 steal;
-	struct kvm_steal_time *src;
-	int version;
-
-	src = &per_cpu(steal_time, cpu);
-	do {
-		version = src->version;
-		virt_rmb();
-		steal = src->steal;
-		virt_rmb();
-	} while ((version & 1) || (version != src->version));
-
-	return steal;
-}
-
 static inline __init void __set_percpu_decrypted(void *ptr, unsigned long size)
 {
 	early_set_memory_decrypted((unsigned long) ptr, size);
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index e90efaf6d26e..7a0313bd053a 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -186,6 +186,8 @@ struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
+void sched_steal_time_cpu_init(int cpu, u64 steal);
+
 #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
 u64 dummy_steal_clock(int cpu);
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index fbf31db0d2f3..1490d1bcf3b4 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -255,6 +255,16 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
 #ifdef CONFIG_PARAVIRT
 struct static_key paravirt_steal_enabled;
 
+void sched_steal_time_cpu_init(int cpu, u64 steal)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	rq->prev_steal_time = steal;
+#ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
+	rq->prev_steal_time_rq = steal;
+#endif
+}
+
 #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
 static u64 native_steal_clock(int cpu)
 {
-- 
2.39.3

