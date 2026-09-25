Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A408481AA5;
	Fri, 25 Sep 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336681; cv=fail; b=UQ8/lHz5zoLSCSqgJ6TvjiwS/LMCISrq12/+BJR0P7a0y/RFnOGskBHYXsR7ZPNZWWOmCt23ADMKfmSy2qvDrlQJ3XM/01TIx6o6E9p2OABQh2K4JKQQiR1quoIPypypAz0ErxyPhGDcDBoOQM24bLEeB1y1agfP9AD2x2PBvko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336681; c=relaxed/simple;
	bh=mEATwXhwOa6MOtrhF7Yfq4N+uuTi/lV9gSZTZFpzu+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6/U6tcQDZ7XT0EeSmRuHx0Vvv2o0ZCQeSFbO14yyjTubfoaC6vsizCj8hfb1Kw8iUliVWZLTdLaIM1fCX5vMlR/zZvtsQgKruILRAr5Vk8qoaBXv36fhT9m7RzjDS/9JXa5WFDCRsUJHbgqAU1KMDIPAOfdfoNNCiTJbTcazSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yTJC82A1; arc=fail smtp.client-ip=40.107.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yTJC82A1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8Ps7KzseRSIrq+41kwGbp/Ln2BQfqw0zZ8SWZOOLQAZxzBaF9aWN6prw79d4UBGM2PpGMyR8VMh0cH3D7QvLLLFosUIh2FrkjPDA8NfBGLo14HqNZwYc53DEmZ1PCQJrObw+mKOPqGPBWGmPxXLWEHdXL4wpVmkZFibVIFQyA2x3V8Oq4dpQ0Qr+joEmjFJXuQdkHacmiUAqmvWV6emhfZs3h2VIqHe2U07Hih6PMrEZc+Gx/gRnu2X09TCdCRvQTzh4Cr7chPAqew/xWN+SLqy/mLI5yGG9Omc8ANElhO9n3hLUycXVSuKpoze/7MsP+IQW34e6IhnVqScE7KaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJqj2tPT7SFzP2oOE0Ho88URA06xoDp4/gcKcmqKCaE=;
 b=b4m72DGYOzs0u8zvW0oNqTb7WrchDe+c1wXED2XKfd2U7L1uxe0YkCltJbnXLHBmLOj5sTY/kRuLJSgSkHG1e1dtqB5pz5DABqzJ6/O222R/dcj0brmFMC7UG/G9bupbTy8lWbF+KEP7lpeAh/behJn11zQdANteQMxSaYWTC6HKXNeQOziPEC2K43Bl5V7iu7FzXGmc/R7roNiJF6FJ4WHWKim0kOzK0T7jRU7qyIfM9yc25v6rftwCZhMN35xshMYQMerWqyE9dkNQiXE529XFo36u+XYULI+Kk1AX+ABG7RQ4xdmhjIqheZ05WsrTmmqSJdCep6yjY/Kin23fKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJqj2tPT7SFzP2oOE0Ho88URA06xoDp4/gcKcmqKCaE=;
 b=yTJC82A1CX0yjskOm8cWJqO5hcRjqLlzzeV0QwYriXwV4nxP5SNnBqKP4eUDw63Lpheq+7JPza98bAj2ECRmBOgqjSMuaGX2V9y6Os2jd8KoEVRhAdz8o94lKiiONYW4IvBj5NV790c145ax0iHVXmNP+r/Wpraeb9l2XHwr+xM=
Received: from BN9PR03CA0677.namprd03.prod.outlook.com (2603:10b6:408:10e::22)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:44:31 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::30) by BN9PR03CA0677.outlook.office365.com
 (2603:10b6:408:10e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 11:44:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:44:31 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:44:26 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 6/9] KVM: SVM: Support FRED nested exception injection
Date: Fri, 25 Sep 2026 11:40:14 +0000
Message-ID: <20260925114017.2208531-7-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ff011c-576d-474f-91a4-08df1afa5d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rcYa1j+NZ9ulaP+LtJEkP+fuWcr0VzyYrKt92W9/hQ5XhfqcVe57o8/7TzkNzcbzZiY2/ZFfFIhnlFzYZI8Oib/9ZpqfE9p2Fd/cX8gAiAdqEjI4fyh4+aTybmzfqtf/r+/pdQeWAIHCzPaulzicegAnzLXaOB6buYislP0H6OL5HIk+jV2SigBoj1SJF60NOWM7UTBYKLg/eWk4UyR7LuejYVjjizwYXDpVKgAd2JhpYW5B9puOT2Vbv2zQAjZ1+GKjO03Le6jK6kVLYQbT4C14pKpnhF6oniAG5fsk4C8RwKdLUA6U4AF3yzdmow2sDMGQLMsu+uq1Ttoov73DgSityn/AHCdIgn4Xw5ViPfx6PPRCqCbXowjWYfzdhuTYxHpJXXPc+RgrKCt0yNcrYyhc9spb4IqDzB6XbvKsM6hesbM3gmeqHpz5LVT7sog1PNiE0KBoW5KVfZdp+tmh74wnvIQrItZ/kwha7vDNq8mKWuC3U444qsThZVYZs0BSMOExTpWA4AEMRGT6LpE8G4mwDf0KAOnSxiCcvHj6jm9ARKxbvYMm482u27Wd90oYR7POaf2tXp7qHZvVhxEBVTbB5CqKaYf+1MTgXtAZQNyvRp32lgVwMqVR1tPTTxvk3kyc0GmWA8L04iTN2A6KgjB3AYv8xZntokvtzFkYV9czqiXzpXye8dVt5MRbPc54a5TV7yzRyzFNJlDbvXIdZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y1bzpo05RsPOIBCz4ElIUhot4M9/JvFl2f7y2EXfeXFkPt6KPSqCWpcbklH48ncfWWvCnR55FStIa6xIJyfACFJsdTj3TIyWU6jgOWK7yGMJnJfw+1V1bgWr77LBvjcTYeOVr8NW/358dfbbn2tQH3io/rDQPBpNYJctbIVGNmUBU8EtwpuRHYuqy9DgwnER/Lx0zDB7MtapGqiPBLCviNadbIX79irSmvMTR5L4hGNyNJuJK8A6kh6J9j/ZmqjC8iGtLNONvCbPZTR0tyfs/1pWEQunUVbDOE1s9A4wxKCDqMjN5rObp8awf2BlguJYsrcV9ctuE/f7mbRm2QELSnDQPRAvOOT6s5WyWHUGbLsv3Yz8F4C4hX/DYRo96rBTV3wuycrmbZ0aUQwxfLgax00N4uxi2LUVR8oUCXd0iLbHlQMBVJ+WfTB4Iw9Tm2ea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:44:31.7587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ff011c-576d-474f-91a4-08df1afa5d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Set the SVM nested exception bit in EVENT_INJECTION_CTL when
injecting a nested exception using FRED event delivery to
ensure:
  1) A nested exception is injected on a correct stack level.
  2) The nested bit defined in FRED stack frame is set.

The event stack level used by FRED event delivery depends on whether
the event was a nested exception encountered during delivery of an
earlier event, because a nested exception is "regarded" as happening
on ring 0.  E.g., when #PF is configured to use stack level 1 in
IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on the stack pointed by FRED_RSP1
    MSR when encountered in ring 3 and ring 0.
  - normal #PF will be delivered on the stack pointed by FRED_RSP0
    MSR when encountered in ring 3.

The SVM nested-exception support ensures a correct event stack level is
chosen when a VM entry injects a nested exception.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---

Changes in v3:
* Use ex->is_nested to check for nested exceptions.

Changes in v2:
* Replace variable 'nested' with 'is_nested' (Sean Christopherson).
* Formatted variables in reverse fir-tree order (Sean Christopherson).

---
 arch/x86/include/asm/svm.h | 1 +
 arch/x86/kvm/svm/svm.c     | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 0570581e251a..1a6d4509b05b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -664,6 +664,7 @@ static inline void __unused_size_checks(void)
 
 #define SVM_EVTINJ_VALID (1 << 31)
 #define SVM_EVTINJ_VALID_ERR (1 << 11)
+#define SVM_EVTINJ_NESTED_EXCEPTION    (1 << 13)
 
 #define SVM_EVTINJ_RESERVED_BITS ~(SVM_EVTINJ_VEC_MASK | SVM_EVTINJ_TYPE_MASK | \
 				   SVM_EVTINJ_VALID_ERR | SVM_EVTINJ_VALID)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6c15e8480d25..fb6b94405f88 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -389,6 +389,7 @@ static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu, u8 vector)
 static void svm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
+	bool is_nested = is_fred_enabled(vcpu) && ex->is_nested;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	kvm_deliver_exception_payload(vcpu, ex);
@@ -400,6 +401,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	svm->vmcb->control.event_inj = ex->vector
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
+		| (is_nested ? SVM_EVTINJ_NESTED_EXCEPTION : 0)
 		| SVM_EVTINJ_TYPE_EXEPT;
 
 	if (is_fred_enabled(vcpu))
@@ -4502,7 +4504,8 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, false, event_data);
+				      error_code, exitintinfo & SVM_EVTINJ_NESTED_EXCEPTION,
+				      event_data);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
-- 
2.43.0

