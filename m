Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E778F4A;
	Tue,  5 May 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941180; cv=none; b=T3djpDxvU/q4BMsyM9+IqR4Mmm5H+q8V4S8B8CiSrCyaggQpuyS9TOumUQ+wI5s0QdgOQok5rWrNYbpRxbr+HaOBDk/GSH/50a7KInspJ6N4ntDNLJ/80arJFmnBpf5zahzmIsxKZ1a2F0mDr+pFJ6D2PYtzbvBLK8hj4D8wIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941180; c=relaxed/simple;
	bh=UDusgEp0ml0WwtZkuy6T2abTYWGkA8sO0XZm+60+Wjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaCNTLkLJ+apyPoZMFNfuYbrfGuODz38jOtTv7gAJV3I7uFzM4j3L5Y34vo8X1qxd/o+nDyFIUsdNZ3mlOppfvo7BEytImr1uNi6J0YnTD3pWTAKft7GjlCM2FBQZ8nWR9Zu2g7GK5FXzggkP7784PQx2hpUSmCV73dzQnQ7XpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JpzGzpt7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JpzGzpt7"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644IK26O1405055;
	Tue, 5 May 2026 00:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Ycy3v
	45H5/lO50tJU2PYnO8jRnwOCn3MU7E6p8gUv+g=; b=JpzGzpt7ZpGLobvQz+uTf
	11pGr5wZTZIR4C6dAmhKNZyL3bIjceWRQ5927aA6N1iqLBDcG6Ai5IWCN73NPH4B
	zxtOgHR8zGgr6LRZfB7C7M/Xy13zBPVXAKOnkmR5Ddh8RRKPUVlYEk1xIoH9uyEQ
	lYXbpv/RPTWCXXT1Qv7tZBWCTHuDwnKsaH7Na5zda8hrF9XOlALLFvhgFnJsxu3l
	bqfxF4XSa9AOjihxqFVtHrc2QE481IxttNOYuDv36EOlFuujJMc2yV59/RPxMT/b
	QPg/1YScSMh9ZSJGw2Erm1lBLY3nc4aQkduO/5JB5dEI0d5hylPPdICRUDnEukK1
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9epuy7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VG9E007015;
	Tue, 5 May 2026 00:32:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:29 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5b001260;
	Tue, 5 May 2026 00:32:29 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-4;
	Tue, 05 May 2026 00:32:29 +0000 (GMT)
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
Subject: [PATCH 3/5] KVM: x86: account KVM_SET_CLOCK downtime in steal time
Date: Mon,  4 May 2026 17:30:16 -0700
Message-ID: <20260505003044.78693-4-dongli.zhang@oracle.com>
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
X-Proofpoint-ORIG-GUID: V9sbreCY7n_-ivAUEQILdNBIak7p7IIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX7hd151W+wg3C
 BeO9jbrBN/TZ0+Xy1YE+HRSLWlCS+OA+EuJBah5De1sWhg6Aqw8UWfliMSKn43uVFMZSEgn91df
 iGiE0+InNo4oBikivoz/Ks5ym3SIGJTLvQLFgGIIfsnkQx38vanJ3YkOXF4OZWWik8oA3ENAraD
 Bi6iS74Uxb/dVRPzvUl6odx861rzZvnIDp9sp4W85bI/MCW6KbonTA78E2S61tNr1AP5aRyRScd
 86/taZYYv4AsehXsQ8GyyK3dPl/RtfUJ2MydVSPXc0JRxGJI6rLCu8eP5L4Y55tlwlWiFHHvb5O
 DPiYeyPUkzKt6sr5d6aQhe//mzB4i7Z3khb01mD1yDNxFORcxmLjWwtt3xI7m05AdaRzCQf+a7A
 CDlx/JbbLbMXqxcRmlxmYeBrtDAwh86kXYDBFzN3+k2XbCUwrcpcqwAqRASClaS529z4eWAaM4Y
 I7Pj5tzRTozRgzkeGLw==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69f93a9e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=WxiHPqxzqn99l1sN-H0A:9
X-Proofpoint-GUID: V9sbreCY7n_-ivAUEQILdNBIak7p7IIK

The KVM_CLOCK_REALTIME has been introduced to help track the downtime of
live migration. KVM uses that realtime value to advance guest clock, but
the same blackout is not reflected in KVM steal time.

Account that same delta in steal time directly in kvm_vm_ioctl_set_clock(),
only when KVM_CLOCK_REALTIME is used. This keeps the KVM-only solution
self-contained and avoids adding a new KVM ioctl or requiring additional
userspace changes (i.e. QEMU).

Record the per-VM downtime delta when KVM_SET_CLOCK receives
KVM_CLOCK_REALTIME, and fold it into the existing x86 steal accounting
path. Initialize each vCPU's local cursor
(vcpu->arch.st.last_downtime_steal) when the guest enables
MSR_KVM_STEAL_TIME so previously accumulated blackout is not charged.

Note that this means a vCPU may observe additional steal time after
blackout even if the host side contribution from current->sched_info
did not increase during that interval.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/x86.c              | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1f1f29128c5d..920441b1abf0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -959,6 +959,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
+		u64 last_downtime_steal;
 		struct gfn_to_hva_cache cache;
 		bool need_reset;
 	} st;
@@ -1506,6 +1507,8 @@ struct kvm_arch {
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 
+	atomic64_t downtime_steal;
+
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eec578894ad5..452293fc0505 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3751,6 +3751,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	struct kvm_steal_time __user *st;
 	struct kvm_memslots *slots;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	u64 downtime_steal;
 	u64 steal;
 	u32 version;
 
@@ -3838,6 +3839,11 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+
+	downtime_steal = atomic64_read(&vcpu->kvm->arch.downtime_steal);
+	steal += downtime_steal - vcpu->arch.st.last_downtime_steal;
+	vcpu->arch.st.last_downtime_steal = downtime_steal;
+
 	unsafe_put_user(steal, &st->steal, out);
 
 	version += 1;
@@ -4185,6 +4191,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			break;
 
 		vcpu->arch.st.need_reset = true;
+		vcpu->arch.st.last_downtime_steal =
+			atomic64_read(&vcpu->kvm->arch.downtime_steal);
+
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
 		break;
@@ -7250,8 +7259,18 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
 		/*
 		 * Avoid stepping the kvmclock backwards.
 		 */
-		if (now_real_ns > data.realtime)
-			data.clock += now_real_ns - data.realtime;
+		if (now_real_ns > data.realtime) {
+			u64 downtime_ns = now_real_ns - data.realtime;
+
+			data.clock += downtime_ns;
+
+			if (sched_info_on()) {
+				atomic64_add(downtime_ns,
+					     &kvm->arch.downtime_steal);
+				kvm_make_all_cpus_request(kvm,
+							  KVM_REQ_STEAL_UPDATE);
+			}
+		}
 	}
 
 	if (ka->use_master_clock)
@@ -13389,6 +13408,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
+	atomic64_set(&kvm->arch.downtime_steal, 0);
+
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
 	kvm_xen_init_vm(kvm);
-- 
2.39.3

