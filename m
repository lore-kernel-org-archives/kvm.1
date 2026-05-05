Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743AEEBB;
	Tue,  5 May 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941179; cv=none; b=BxlET/UjG9GTDWP/RAeYFlABttoH+cdXdFWd99yz2WFCqdlJeu+Bd7fvQ+w0301eSkOiJjBYzAgDdkoaSeaBKHs1H+BYhk4Cbq9EVpD/ZwWghcNurlCPUNTICCAyzLZf95BuvYt6ondForMJVu8cPzFUE7l/XJehZcy4JUQqYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941179; c=relaxed/simple;
	bh=KPBQIZB0MM2O4amuoqpSTUhWnhGEz5ixYsVmvyDCMZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZsIdiyFdcOXLUM4krx1kEUGVwQ6oUpCaMq0d1nR8A/meH/GttIF+H5wRlW2TbaeBUi+O30giVeJuP7r6G+NhNTj9bZ1KA2cxZDtNwwO7u0seckPQp8UO8nVeFN829tsSAafegpHFsiPbHgqH14SQzx/9NBGEM/j2mDWVaFa7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nffAvrzk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nffAvrzk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644IcEpx2134319;
	Tue, 5 May 2026 00:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8iRk5oK9TL9vll3HarsCLFCChpY6n
	GOthUWyLqkdcG0=; b=nffAvrzkQKGWiAZmc1ievttoTf3h47dn0R3/OL71GwDqN
	TQ3oV/wDQaelaaEPwEDgsp2ZbZrPXGK5W5OPdRC5oYnlzK5T66PumFjnBDd2a/Gz
	ugwzmOI51BjC35rPwp8VALA9wObneJtUD/twjL72IZxTFLD8QyOtdrKHBtiPP1UX
	kMvqkSZy+NDe+hlcAor+QbwnvnEaU7xwPrsWbVVprjJWYHWeRqqheMmtLsKt3nuu
	FvJEltq9BvHf3TPxMo1f2ZJjdMInQplW3dFqv1Mgb2xcWvgio14+kCU01CuvbvUZ
	kEgVWcqwXE2CC5284cttpn+AN27gOEOilw31szE2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9dguvxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VF5a006936;
	Tue, 5 May 2026 00:32:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:25 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5V001260;
	Tue, 5 May 2026 00:32:25 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-1;
	Tue, 05 May 2026 00:32:24 +0000 (GMT)
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
Subject: [PATCH 0/5] Fix and enhance KVM steal accounting for both guest and host
Date: Mon,  4 May 2026 17:30:13 -0700
Message-ID: <20260505003044.78693-1-dongli.zhang@oracle.com>
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
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605050003
X-Proofpoint-GUID: 7PVlGbH6Qj_FSc6N740yUCbKkl6Bijsy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX8XR9t8UGlzdJ
 u5H0aJRUIwIGF0z7YQQIkOnx+GetQMgSx5bCQNKPheaiyojC7kA4RVxhJPADjdF4FquQ3QvF83d
 lmbdwLnkQHEiGotDgWzyCuKE//HhMX2DUXmO2GdoM7Kr4vXvw3fQ+GUqxWq5JNK9dmiASC0de5Y
 D4w0tJyliD7bQjEnZzoJM9k35IBM5ohQ0pFSUpG99UCo6ylB8hGWZikU1frxAnvprddNoMn+jAu
 i7tTenJeeMnpqmnCRdTcJyT7OwKpwQjoVWreSzZLHLrW5JpQLWmfGsS5hTTDFUfPWFSJDLVfXpo
 SMOJSWT2H6AOfvd43ecWLCddD7Mwf8X6lqE5FSA+WNdAbvMTfqgJwV+KFGfmV7Y4iOyYElT8v70
 ZJOErkV7KLwLLPLcLaSZ/QyJNrwTJFs47yqeKZEf7O/gM8Bjkur+tHIvVAOvaCmEmLR00j4k9B9
 2PMIx5Y3v09GceBTM0Q==
X-Proofpoint-ORIG-GUID: 7PVlGbH6Qj_FSc6N740yUCbKkl6Bijsy
X-Authority-Analysis: v=2.4 cv=HZckiCE8 c=1 sm=1 tr=0 ts=69f93a9a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=nm8xYOCaj8weQRiawgYA:9

This patchset resolves two issue releted to KVM steal time accounting.

1. KVM does not support vCPU hotplug. When a vCPU is removed, its
corresponding data structures are not freed by KVM. Instead, QEMU destroys
only the userspace state and the vCPU thread, while the KVM vCPU fd remains
open and parked in QEMU.

As a result, vcpu->arch.st.last_steal is not reset. If the same vCPU is
later re-created by QEMU, last_steal retains its old value, while
current->sched_info.run_delay starts from zero since a new vCPU thread is
created. This causes current->sched_info.run_delay - vcpu->arch.st.last_steal
to produce a large, bogus value.

For instance, current->sched_info.run_delay can become smaller than
vcpu->arch.st.last_steal (see line 3832) if a QEMU vCPU is re-added after
it has previously been removed.

As a result, st->steal restarts from a very small value, close to
current->sched_info.run_delay.

3748 static void record_steal_time(struct kvm_vcpu *vcpu)
3749 {
3831         unsafe_get_user(steal, &st->steal, out);
3832         steal += current->sched_info.run_delay -
3833                 vcpu->arch.st.last_steal;
3834         vcpu->arch.st.last_steal = current->sched_info.run_delay;
3835         unsafe_put_user(steal, &st->steal, out);

This means that, from the guest VM, paravirt_steal_clock() for a newly added
vCPU starts from a very small value.

Since this_rq()->prev_steal_time is not reset during vCPU hotplug, it may
exceed paravirt_steal_clock(). This results in a negative delta (interpreted as
a large u64) being accounted to cpustat[CPUTIME_STEAL], causing it to appear
either very small or to start from a large u64 value (as line 275).

268 static __always_inline u64 steal_account_process_time(u64 maxtime)
269 {
270 #ifdef CONFIG_PARAVIRT
271         if (static_key_false(&paravirt_steal_enabled)) {
272                 u64 steal;
273
274                 steal = paravirt_steal_clock(smp_processor_id());
275                 steal -= this_rq()->prev_steal_time;
276                 steal = min(steal, maxtime);
277                 account_steal_time(steal);
278                 this_rq()->prev_steal_time += steal;
279
280                 return steal;
281         }
282 #endif /* CONFIG_PARAVIRT */
283         return 0;
284 }

This patchset fixes the issue on both the KVM guest and host sides by resetting
prev_steal_time/prev_steal_time_rq and vcpu->arch.st.last_steal when KVM steal
time is enabled.


2. The KVM_CLOCK_REALTIME has been introduced to help track the downtime of
live migration. KVM uses that realtime value to advance guest clock, but
the same blackout is not reflected in KVM steal time.

Account that same delta in steal time directly in kvm_vm_ioctl_set_clock(),
only when KVM_CLOCK_REALTIME is used. This keeps the KVM-only solution
self-contained and avoids adding a new KVM ioctl or requiring additional
userspace changes (i.e. QEMU).


I have also created two KVM selftests.


Dongli Zhang (5):
  x86/kvm: Reset prev_steal_time and prev_steal_time_rq when enabling steal time
  KVM: x86: Reset vcpu->arch.st.last_steal when enabling steal time
  KVM: x86: account KVM_SET_CLOCK downtime in steal time
  KVM: selftests: Test steal time when re-adding a vCPU on a new thread
  KVM: selftests: Test KVM_SET_CLOCK downtime in steal time

 arch/x86/include/asm/kvm_host.h                 |   4 +
 arch/x86/kernel/kvm.c                           |  40 +++---
 arch/x86/kvm/x86.c                              |  32 ++++-
 include/linux/sched/cputime.h                   |   2 +
 kernel/sched/cputime.c                          |  10 ++
 tools/testing/selftests/kvm/Makefile.kvm        |   1 +
 .../testing/selftests/kvm/x86/kvm_clock_test.c  |  42 ++++--
 .../selftests/kvm/x86/steal_time_reset_test.c   | 144 +++++++++++++++++++
 8 files changed, 248 insertions(+), 27 deletions(-)

Thank you very much!

Dongli Zhang

