Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A5194C96;
	Tue,  5 May 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941180; cv=none; b=hB08GLqiEa0Vj5dKMDqjngHXbcaGzNjnyhe9gobeiSDJgTt3u2bFrc7uJnd2jgXq7B5vTV5mkHaZOHLqjHk7ts5Aj4jfpq4D2IhJU8D5m9lbOrW9EYI4c79H5nDJ3VBZdNWB+FZ0qjwCa52oDeudRX4/fwxaUiWihE8ftrCV1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941180; c=relaxed/simple;
	bh=HTZJruZrLVfjzwmV+Fpao4C8KDTVQZqPL3XZ2gwpw/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIiNtZMsHPWz4MLCdjowSUrcE+BHO17A3D8jdwzyarxonWFJePnD2CglZkhjWvre+R1weKfxwvYT4oWnUufXqPommFu3Uh2O5rv6if5cBZjwafA+M4LzlZRAcREtFItM/KEKnaZDtHCllJY4HmXqFq6NK05C3YPDWh13awdvwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIUssoa8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIUssoa8"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644NtpN82267979;
	Tue, 5 May 2026 00:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mZ0Sj
	oudm3VNC1X0v0Tu//XpoM4YLEfLtZKc+hce+Ms=; b=mIUssoa84ccxEgaq7ZbLt
	JpdxqQxr1yo1brTTuXOMvKbHh1O9EV+KX51pN5gH4zZ2P/DkwHMxGngPJVdcCIRW
	VNs2rpK5r+UAqYLIMyB72ll9pmy2w39jxtT1lSvJ4BT6ukTBl3XGUkPlGtmE2TjC
	Ntn5UiIEjEBrBoztfVSXYadda/exWV+31+I2DK86I0LciDNWKsYPV5dEVb4LNiTQ
	GW96aTi3zsuLIok+ccY91hCT1X5WRzJ4SO0Vx7nQVH6HWUmhJhmZaH856CqyDecu
	qa9ljtsHAqoCxexYDj++OsUWHfENRF0Ofo02Zo5W6STWGnGPSWX2oCPLqSwykc17
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxkwx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6450VFk0006963;
	Tue, 5 May 2026 00:32:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5e9yjhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 May 2026 00:32:28 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6450Tr5Z001260;
	Tue, 5 May 2026 00:32:27 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx5e9yjfe-3;
	Tue, 05 May 2026 00:32:27 +0000 (GMT)
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
Subject: [PATCH 2/5] KVM: x86: Reset vcpu->arch.st.last_steal when enabling steal time
Date: Mon,  4 May 2026 17:30:15 -0700
Message-ID: <20260505003044.78693-3-dongli.zhang@oracle.com>
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
X-Proofpoint-ORIG-GUID: rpZJiLSJjLiFWhfL1-KxJ7McEUJ5QvLZ
X-Proofpoint-GUID: rpZJiLSJjLiFWhfL1-KxJ7McEUJ5QvLZ
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f93a9d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=NcxoaAi5ngG3oE4jXLMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX9gaLxKBRHtvh
 LBE3Bip4XBDl90GfVe34v/iGsyUWVKKagRYXrA/SLms5o8t8fgq30LNczoBENCekVCHCRSwwTPo
 jmNCJFq/Td009TaFr8IFzQfftbDsH1FRvoGOj47B9XQ42H6tRBbWZD5F4+1MnswKVfVH5z4i6dZ
 cf0pVf5nUxG7G+bmHl2QjpTwoRD8aBfbAMcx4j511oWf/pzYShCov56TtbIvoxmbyDA3vYo+YoV
 yoACDuzMaAPduLzPHLNP03IrNsFmTf0FD6EKv4Ucimr+CSklcYgzOUpuUZJhhCILvJOKFNBHPBT
 hBbsaFk1BiCk9b6HPejtVoK3a5dCjW6lqq43fK/BhN6BIdOKyyFjN0t9hx8nBeppufnNqm94n/j
 rk73LFcZkYnFZV9ecZc+sa86yFsw9FgvtYgeL65d0YNabpQZE7xgf8RUPpiCCtIPyR0q+bcKvz9
 uKIQOTjoj+9LrukUWig==

KVM does not support vCPU hotplug. When a vCPU is removed, its
corresponding data structures are not freed by KVM. Instead, QEMU destroys
only the userspace state and the vCPU thread, while the KVM vCPU fd remains
open and parked in QEMU.

As a result, vcpu->arch.st.last_steal is not reset.

If the same vCPU is later re-created by QEMU, last_steal retains its old
value, while current->sched_info.run_delay starts from zero since a new
vCPU thread is created. This causes
current->sched_info.run_delay - vcpu->arch.st.last_steal to produce a
large, bogus value.

Fix this by resetting vcpu->arch.st.last_steal to
current->sched_info.run_delay when KVM steal time is enabled.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..1f1f29128c5d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -960,6 +960,7 @@ struct kvm_vcpu_arch {
 		u64 msr_val;
 		u64 last_steal;
 		struct gfn_to_hva_cache cache;
+		bool need_reset;
 	} st;
 
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..eec578894ad5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3829,6 +3829,12 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	smp_wmb();
 
 	unsafe_get_user(steal, &st->steal, out);
+
+	if (vcpu->arch.st.need_reset) {
+		vcpu->arch.st.need_reset = false;
+		vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	}
+
 	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
@@ -4178,6 +4184,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!(data & KVM_MSR_ENABLED))
 			break;
 
+		vcpu->arch.st.need_reset = true;
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
 		break;
-- 
2.39.3

