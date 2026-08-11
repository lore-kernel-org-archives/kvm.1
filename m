Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054A445AD3;
	Tue, 11 Aug 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457033; cv=none; b=MQE4r5wLyRY7la8TgZICprH75fSYYIDhyBGW9sCR+pUpoV2qm/QuPdY5xFNYpwiJAA902Nt9aBn+miCGg/MnwOCQ1JpOFTOAAKcrLnE9Yp9WHNlN83UvMWGa1h5Hylv6aoaIsj202WRiXLCNqD18g3CYxw+WZjZZ2iMct81eY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457033; c=relaxed/simple;
	bh=moVLitlI5BOWzY5urGe765jYhLB49OyNW2lMcKp3YAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK3spE2FiQT41bok1KzIkDa4NTsinSkKZwT3D/lU3Bw8PDXPqxa+FiNjE5P5duf/FGNReEYAwREtuORx3YRzlGDqE6rcj9W7r3Nw8fPd744F0dIyG0nR+yT2Dc3HN5BNZ/MXODP7DIYuUj2EvS1Ju3bsHgacDcw2hfTgmo/3iOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLqU6OUk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLqU6OUk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWSAq492273;
	Tue, 11 Aug 2026 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VmybN1WfXfiCuAnGG
	rvYNknnExBzVX5Li+2hHIaUUZY=; b=aLqU6OUkXWZq+qf3IdlJbEb5Vf3sHictC
	fL3SsBTLuQ8C+hqsh/oGFhhfHGkfdlaDyd4rHYswbQkHsjsUil91gie6x25dcnTO
	W5yzFq1WcebhwqnRY8qp84ujdAXd4G8Q0XTNx70ZyymUQLFQnn4qkvW66ZQkwlx9
	YBkQbqFP0Os1u85PaiucP84YVFHQKORKOl8+BsqrMo/5wbKge+tWLagAqF99Ybw5
	GuSiLKnO9LWCCkb/3oJ0MnW95YuNUvIo8MchObyN9y9JeiVYQz4tVEHD70l+W2PR
	izPWq4Tmyk5bTWEKmeBxx2/Wkdz/tY33TAN224j1XWr26QjRe8NIA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9d82j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuS3w015709;
	Tue, 11 Aug 2026 14:03:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjs77n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3aK635521004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C3B12004B;
	Tue, 11 Aug 2026 14:03:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D6D20040;
	Tue, 11 Aug 2026 14:03:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:33 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc/perf: Use the aggregate context switch values from vcpu struct
Date: Tue, 11 Aug 2026 19:33:08 +0530
Message-ID: <20260811140313.15397-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811140313.15397-1-gautam@linux.ibm.com>
References: <20260811140313.15397-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZOsXnLa6Nxx_Rgu6PEfNL9GbbOC5s8lK
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b2bbd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=77216UCIGRllsWULn3kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXxF+9ditkf+WX
 muqmAhwPaIu6cn07RaWHC7Zi1BcQeCnUI3o5l9GpoFos0JchsTzO5Bo1XlsQ7qtKEALNZd9gFfL
 MrTnzp1x7WrCHPpaY6L+e4LL6nvVuceKAta4M6tqOso2syZr+IFbj9COaJMHR98b1GVZ5xJR/GO
 JHJYtFb9ttSJiDr4NoKyL6cE7sDnxjjOYyRC7s3/exfn77/dywDCM9Bhlf3r3BGtDB0uuxogF9c
 uWw39YIdL5yiRmitRTMml68qP5mWFIYZGcobBMaW/3JgqTlN3SfcByAH5a49AZu4G8Znj3IANZ+
 swXTFJ0hUHMsDDdgRs3X1JS60GFDlJPnFJfkvkF7s7OgFRF9T74638CjfhPfwN47TafYsY2k0BZ
 HXKgOrsL3ZTm+wlmjUwh5Ii+/4dvdOQosmhdIBD/5yw4LCnMVuItc7EhotEKbzc7as2F/kSv4bB
 4EhHCisYyQZkmzddwxQ==
X-Proofpoint-ORIG-GUID: co_g_qcu_BstO8maNbb2rZXG7kOdS7yV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX3H4ahDK6Jd43
 8BEnwsqFMfaBganjj51jun71zQTv7P//JUsyxJcbCiEjf8Affr3+yJv2MAJNrQQSwa0g6xJ7eR6
 TTbtYlrZgB7smxlRFI1M0kBrKOj2nOs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110117

The vpa-pmu driver reports incorrect numbers in 2 scenarios:

1. The vCPU process gets rescheduled to a different host cpu
    - Incorrect numbers are observed here because the PACA is per-host cpu
      resource, and the KVM vCPUs can be rescheduled to different
      host cpus. This causes the vpa-pmu driver to subtract wrong values
      when vCPUs are rescheduled.

2. The vCPU is not running when vpa_pmu_read() is called.
    - In this case get_counter_data() returns 0, and this can result in
      negative numbers getting reported.

Fix the above issues by using the aggregate values from the vcpu
structure to capture and report the difference in counter values.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  6 ---
 arch/powerpc/kvm/book3s_hv.c             | 63 ----------------------
 arch/powerpc/perf/vpa-pmu.c              | 69 ++++++++++++------------
 3 files changed, 35 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index b936e174eefd..11065313d4c1 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -688,12 +688,6 @@ int kvmhv_counters_tracepoint_regfunc(void);
 void kvmhv_counters_tracepoint_unregfunc(void);
 int kvmhv_get_l2_counters_status(void);
 void kvmhv_set_l2_counters_status(int cpu, bool status);
-u64 kvmhv_get_l1_to_l2_cs_time(void);
-u64 kvmhv_get_l2_to_l1_cs_time(void);
-u64 kvmhv_get_l2_runtime_agg(void);
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void);
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void);
-u64 kvmhv_get_l2_runtime_agg_vcpu(void);
 
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0e8a959122a8..b315a959d2a1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4172,69 +4172,6 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
 	*l2_runtime_agg_ptr = l2_runtime_ns;
 }
 
-u64 kvmhv_get_l1_to_l2_cs_time(void)
-{
-	return tb_to_ns(be64_to_cpu(get_lppaca()->l1_to_l2_cs_tb));
-}
-EXPORT_SYMBOL(kvmhv_get_l1_to_l2_cs_time);
-
-u64 kvmhv_get_l2_to_l1_cs_time(void)
-{
-	return tb_to_ns(be64_to_cpu(get_lppaca()->l2_to_l1_cs_tb));
-}
-EXPORT_SYMBOL(kvmhv_get_l2_to_l1_cs_time);
-
-u64 kvmhv_get_l2_runtime_agg(void)
-{
-	return tb_to_ns(be64_to_cpu(get_lppaca()->l2_runtime_tb));
-}
-EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg);
-
-u64 kvmhv_get_l1_to_l2_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l1_to_l2_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l1_to_l2_cs_time_vcpu);
-
-u64 kvmhv_get_l2_to_l1_cs_time_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_to_l1_cs;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_to_l1_cs_time_vcpu);
-
-u64 kvmhv_get_l2_runtime_agg_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-	struct kvm_vcpu_arch *arch;
-
-	vcpu = local_paca->kvm_hstate.kvm_vcpu;
-	if (vcpu) {
-		arch = &vcpu->arch;
-		return arch->l2_runtime_agg;
-	} else {
-		return 0;
-	}
-}
-EXPORT_SYMBOL(kvmhv_get_l2_runtime_agg_vcpu);
-
 #else
 int kvmhv_get_l2_counters_status(void)
 {
diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index bff4cfab7b94..334ef7719db9 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -71,6 +71,28 @@ static const struct attribute_group *vpa_pmu_attr_groups[] = {
 	NULL
 };
 
+static u64 get_vcpu_data(struct kvm_vcpu *vcpu, u64 config)
+{
+	u64 new_data;
+
+	if (!vcpu)
+		return 0;
+
+	switch (config) {
+	case L1_TO_L2_CS_LAT:
+		new_data = vcpu->arch.l1_to_l2_cs;
+		break;
+	case L2_TO_L1_CS_LAT:
+		new_data = vcpu->arch.l2_to_l1_cs;
+		break;
+	case L2_RUNTIME_AGG:
+		new_data = vcpu->arch.l2_runtime_agg;
+		break;
+	}
+
+	return new_data;
+}
+
 static int vpa_pmu_event_init(struct perf_event *event)
 {
 	if (event->attr.type != event->pmu->type)
@@ -91,56 +113,35 @@ static int vpa_pmu_event_init(struct perf_event *event)
 	return 0;
 }
 
-static unsigned long get_counter_data(struct perf_event *event)
-{
-	unsigned int config = event->attr.config;
-	u64 data;
-
-	switch (config) {
-	case L1_TO_L2_CS_LAT:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l1_to_l2_cs_time_vcpu();
-		else
-			data = kvmhv_get_l1_to_l2_cs_time();
-		break;
-	case L2_TO_L1_CS_LAT:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_to_l1_cs_time_vcpu();
-		else
-			data = kvmhv_get_l2_to_l1_cs_time();
-		break;
-	case L2_RUNTIME_AGG:
-		if (event->attach_state & PERF_ATTACH_TASK)
-			data = kvmhv_get_l2_runtime_agg_vcpu();
-		else
-			data = kvmhv_get_l2_runtime_agg();
-		break;
-	default:
-		data = 0;
-		break;
-	}
-
-	return data;
-}
-
 static int vpa_pmu_add(struct perf_event *event, int flags)
 {
 	u64 data;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = local_paca->kvm_hstate.kvm_vcpu;
+	if (!vcpu)
+		goto out;
 
+	event->pmu_private = vcpu;
 	kvmhv_set_l2_counters_status(smp_processor_id(), true);
 
-	data = get_counter_data(event);
+	data = get_vcpu_data(vcpu, event->attr.config);
 	local64_set(&event->hw.prev_count, data);
 
+out:
 	return 0;
 }
 
 static void vpa_pmu_read(struct perf_event *event)
 {
 	u64 prev_data, new_data, final_data;
+	struct kvm_vcpu *vcpu;
 
+	vcpu = (struct kvm_vcpu *) event->pmu_private;
+	if (!vcpu)
+		return;
 	prev_data = local64_read(&event->hw.prev_count);
-	new_data = get_counter_data(event);
+	new_data = get_vcpu_data(vcpu, event->attr.config);
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
-- 
2.54.0

