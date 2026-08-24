Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC38329C48;
	Mon, 24 Aug 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787535479; cv=none; b=hvNr7zM67qMUmcq6FHjNVQQJW/Cidtw0zdEKEBujELEFKbKM85JqxFQ9A8Og01GHLf8FmK7VXCHW0dYo0/QbF1/YEuNK3tpTmC/IpCspZV3yEba7bQeU2eiFkGAjg6MfCmJm710AmUc/M7ootQ/uqM8UglqxQVsnQ+3kfJLvkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787535479; c=relaxed/simple;
	bh=BdyXgcqP4UT0Nvy6YZMngGsfc4X0wGM2CB4QODXqVQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ+JB3wA97sMUdYULwULJyQxZ/ojlAYQPoRk8dj3P2qb0OzxapQc9+hhWDgu38fkZC1pbsmv7T/ZFCCxuysABLl9SRNeknpnp0yCx2fSTRlwuZW8EGhDzVeINo8PwalrfO112Hk2yVXSy+E5ciDIhnO0tQ+6R9r7aoScfhMw+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ONjs1LZT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONjs1LZT"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NNVRGC4028287;
	Mon, 24 Aug 2026 01:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=AM1Cf
	wJ8g05SV7IdUa82tGBN4xGZcLFUEGyyk/09Iqw=; b=ONjs1LZT85rRWpHgCW626
	v/kPOEcUtsev7KZEQl9pQ8aLewdDGpfwNm9T6KDokGfCZLdSOCigjXi+A31LDOD2
	iPJ4TM573XQxCyY6V8y6m/bmiM4sZj/nhEcP7H+TSLvgT6lceaT5I0JuEtrz2FaI
	HBY9mwYMBsQVZhBLAgYPs0YyG5/dHUELiSnjBKIqghxQ1NMwuQ2U3MBElxseyWIe
	Ods5kXhcWZw/OW7Y8a/+f4kzs9wv7FwCrxFtFDLU12ByEDLm/eIlnFSMt67UP5EJ
	ru4NDQUyESoYPSRykDvTkZhzJjEf+7SdJdwc4QoipdVbePJ4pakQX0YmNDNxfZrd
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73csscv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67O1PSb9036711;
	Mon, 24 Aug 2026 01:32:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g84kh750x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 01:32:44 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1Wgn3010282;
	Mon, 24 Aug 2026 01:32:43 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4g84kh7504-2;
	Mon, 24 Aug 2026 01:32:43 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        dwmw2@infradead.org, joe.jin@oracle.com
Subject: [PATCH RFC 1/2] KVM: x86: Update stealtime before clearing preempted state
Date: Sun, 23 Aug 2026 18:26:25 -0700
Message-ID: <20260824012716.753022-2-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=D+h37PRj c=1 sm=1 tr=0 ts=6a8b9f3d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=cD1_jheChcHno68YmwQA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfXwNovBrfga5r8
 X3Kq2z+IHrjESB55W93H7FgfqkiNIV3kMmFiEoXtX4bVm3ilRULuBErWc/gSflXLjBdiYgpRwHb
 LlYGDpiq4+2aOu8xDCLNgNjVdUeTIxutjOCFTOvWEgDnOfgrVO7i
X-Proofpoint-ORIG-GUID: mtIS0-21H4It3hCK6_GiUyNTsWsxC7pk
X-Proofpoint-GUID: mtIS0-21H4It3hCK6_GiUyNTsWsxC7pk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAxMiBTYWx0ZWRfX2QYoUwGeTgn1
 axlAnN6F/3lypRbVW4UhX8xCKAStodjKly/BfW8ZBGlEiNFdZlaz2b6zupK3Pmhy26CkSmZ5d5o
 H7GlJDwupzS/6ut/ToY8AfEQVUjTY8dsOq9bwQUqum6jcYjCatVc5AxrLGuFFueZnzv5HRWaDAt
 oJjcmROxZUwuqLSk6N/5ypXEkfFmhgtUzG19+T0R9vpD/D6HUaK0FP5f9qPCwck3bNfKcnrtgEH
 GvIJxiScvM7HbeyYqvtZhKdvrRnKAC2984UyVXSdApNRADt9O+hCIosEwbvOWRrr6OHoi4/sI1s
 9LLaD+SlrAs/NN1zLQ8ektHPcmOVDvNsbYfcodb/dvsxhIiPWqhhZ2LeOxpznG0/V0yRB/MCKxn
 DPHeOkZ8O727fBRB4ApuT2xl1/UoJrMKAz0G8P7WBGZq8M9QFDY3RpKEcCTYwwCuZMKb20zKOjj
 w7KJpy1STluTmrBdsLizjNAcdcetNHd7/BOMXCWA=

The guest Linux scheduler may rely on KVM stealtime to determine whether
elapsed time should be deducted from task runtime.

However, when vCPU A reads vCPU B's stealtime for scheduler accounting,
the value may not be up to date. KVM updates stealtime only when the vCPU
is about to enter the guest.

Update stealtime before clearing the preempted state, so a remote vCPU that
observes vcpu_is_preempted() as false also observes the new stealtime.

Otherwise, reading a vCPU's stealtime from another vCPU is not reliable.
The remote vCPU should wait until vcpu_is_preempted() returns false for the
target vCPU.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kvm/x86.c | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69469bbdc84a..525a1448195e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3751,6 +3751,35 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	}
 
 	st = (struct kvm_steal_time __user *)ghc->hva;
+
+	if (!user_access_begin(st, sizeof(*st)))
+		return;
+
+	unsafe_get_user(version, &st->version, out);
+	if (version & 1)
+		version += 1;  /* first time write, random junk */
+
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
+
+	/* Pairs with the guest side virt_rmb() in kvm_steal_clock(). */
+	smp_wmb();
+
+	unsafe_get_user(steal, &st->steal, out);
+	steal += current->sched_info.run_delay -
+		vcpu->arch.st.last_steal;
+	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	unsafe_put_user(steal, &st->steal, out);
+
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
+
+	/*
+	 * Publish the stealtime before making the vCPU look runnable to
+	 * the guest.
+	 */
+	smp_wmb();
+
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
@@ -3759,9 +3788,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		u8 st_preempted = 0;
 		int err = -EFAULT;
 
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
 		asm volatile("1: xchgb %0, %2\n"
 			     "xor %1, %1\n"
 			     "2:\n"
@@ -3781,37 +3807,17 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_vcpu_flush_tlb_guest(vcpu);
 
-		if (!user_access_begin(st, sizeof(*st)))
-			goto dirty;
 	} else {
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
 		unsafe_put_user(0, &st->preempted, out);
 		vcpu->arch.st.preempted = 0;
+		user_access_end();
 	}
 
-	unsafe_get_user(version, &st->version, out);
-	if (version & 1)
-		version += 1;  /* first time write, random junk */
-
-	version += 1;
-	unsafe_put_user(version, &st->version, out);
-
-	smp_wmb();
-
-	unsafe_get_user(steal, &st->steal, out);
-	steal += current->sched_info.run_delay -
-		vcpu->arch.st.last_steal;
-	vcpu->arch.st.last_steal = current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
-
-	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	return;
 
  out:
 	user_access_end();
- dirty:
 	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
-- 
2.43.5

