Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702F3A7858
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575599; cv=fail; b=jQZ+HtqboL/QbIW4TV8HSGBquI6RY9s5CSn7kQUObCZD1Q9vYVSI3KdGOFSPvU613CsEV9TkhV4rsKpfHAXkgjk0E8hGnDu1640IMFBcys3bqV7JYfEX8bmN+i9ZrYoqOl8qrcopM1XV6z6j2dNm3UQROA+h3K5Uo9sSUhf6ffw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575599; c=relaxed/simple;
	bh=Rb8w8JhUsmlpCIUdCqV8Kuj27CjSb9Gzr5W/edHSiEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGk/3o5dVTTVFl1bBvVcJx7Nm4/Im56BdXvVnUNjkpQbZyud4M/zdg0U8rKtECmIv067TaRBR3532bW4fx3V5eWtjwmAoz7W0xZPrm2OFbf863PgZo1JZClMaWMplK7pNnLLzbttBg1mLJigRiMM20DKY6zk+8tHBoZ8rA1Cn/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afFIHXNR; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afFIHXNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAl+1c8EPPT4rrpnvriPtlJo1vMzZKveOQRDWnkYEz6kZJViFRuAehA6DurPTWb1I64Ebby/dIvDV/xzFmSVlnMKPrXfU+lNvjNzkgjEF37e3Yw+k96nEvnJo2dyTyFWWzmeLWsJTJPqSqUdArUnQRlFSPluD9IOx3RfS10kARpmlE31HqQ7TdqjcT/wLJ7TfryiWPD//xPYjzrJQTqjwVVvY6R+RIWcleJ+ZGX+wzz0YLQ+z2+fQwe+rojn/vKkIkvowYFgSUrGYlm9b5j4dvTiYGzHm29A4L+8NtGGnNOUfqZDF1KMnQRfMVCYZyXzmicZdl8L5OWk8d1MvB5mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r437EJproUofuzLQiPJNsr8mVGggmPqud5mvYcygOA=;
 b=QWDmP7mNf54sFkRNOBA2M4NuVFBvBVzBwPvLC7DUYnf7YDqyUAjkCmg3cHPIbCa+mhOH4xdZFPJfswQJgvqmVuESytqyP0BXhWKda5+T5p2t4Bx8NKw6mqkpcovGlP748h25B53HFCy7RfJydno2EI02pCWDeq0S4ygkY6r//1e8T1gzuGVY5svtgMynxyA1F3UtTa531co2GqMojZjIH1zBl+8IEvGqO6q2BmL9FmTsmEQsn6g7VjkHpd5pfGpd0/cPLkOMaehqcwZWgSFQ4jQe3s3gWsrayiG9WQwD0fk68JNVx+b8SNaBdo7Ccap68rmVZc/pwNrF6RNd7t6zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r437EJproUofuzLQiPJNsr8mVGggmPqud5mvYcygOA=;
 b=afFIHXNRUck0CYEEaoWv/wOJTTZiRwQ1CPoTIPgZJltF1gobCk2wISShILtDfu/o0BtIrvyCdX77s9sdNmiNcqMfJAcID3oKa0chir7DhMH7B7VyEOKKJ33M0V0cH9uet48nwaOWgQ4R1UrTkVvVsjr1YGzYzK+iBc5n1ECwkdw=
Received: from SA0PR11CA0146.namprd11.prod.outlook.com (2603:10b6:806:131::31)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 05:39:54 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::27) by SA0PR11CA0146.outlook.office365.com
 (2603:10b6:806:131::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 05:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 05:39:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 00:39:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 22:39:53 -0700
Received: from volcano9b0c-hostos.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 9 Jul 2026 00:39:52 -0500
From: suryasaimadhu <SaiMadhu.KoyyalaHariVenkata@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, sai madhu
	<suryasaimadhu369@gmail.com>
Subject: [PATCH] KVM: x86: Preserve KVM_EXIT_DEBUG on emulated HLT with single-step
Date: Thu, 9 Jul 2026 05:39:49 +0000
Message-ID: <20260709053949.211165-1-SaiMadhu.KoyyalaHariVenkata@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 57da5b83-3a80-42b5-43be-08dedd7c8131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|11063799006|56012099006|6133799003|3023799007|43062017;
X-Microsoft-Antispam-Message-Info:
	Kad7G87vEZCGle9tzP7yueVwYJtfkgTab1JObRGC6oC5nVpn7pxl3cvfn5IpHMz00k70xzrreiIOesSqdG+dr0UIqtfwn+IbnbFkos1FpjJ/rC9TLddA5NMrjae17X9SOlXSUJKb5NWrX/XJcIPsJ4o4epTESLmqgsb8bIjDuA20t2B/RMpOm0aV2qmR7zhztwn42EmywR5hS8iGayE4tG+y0EYwMvoeReJqO5O65G1NZgiCkhjnddb116/YhCs3AmUGb0J6etaLGIHrA7smMXn5iRdUKlZwk+Z7ojvCBSr6yHoQ2V7p+mijmyUOSOA3UdO43J6Zof7hIF3JFePZR+Kc1xL3lzCECE3Bggc2ToIrxZ0o6R1TfVMc4nKgcwmVfbpKcDqFNGytG6QUsU80BmFVKcFQ3xF0jr2m4xiZxEd4UtVxcwN1WNmHZwGBiOoKHy+EHeY4hSw8hFrDkURj6WU25EO3tW1e54lIuMWB2rg77buljn4fL89i7veKyulCl5RjI0X2JN5B4YM96/YN/avnOK3v+ONAAoUVRlqgDAAFU16MkUvrQLYxgMtwtfPy8gwN9J0VQ3m6EY9uW4V6oVZv7k98CMoK1joMKBmoObjxJ64E1/tCIzGOdkTcYNeyf4LoNg7SOBPnBv6U/FAMZ58fuzftWMLUgUiKi/mlkwNKmNVq2XVeMUK6bl0d2NMqF7TMH3OdUNuHpVX8ii8b4X8w7t6IC2Oac/qZG4W/fbsS1dcbLhJ0r8ogKbYxtIs8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T6pby9p9uKSh8lbnliSa1rD60Bp+m/Qu+BXaoPGk40z2o3DGRj9oLAPbE3q942dF72sdMCCJjiZtXpOnq9U+9qHX5lFnkJBm3/B0cEmRO2C7lCt/V+YUEVZ3vTdWBuJf7JJvafOIM6eFuT8MytpvGcqY6ldYkjeLSTCvCGcUJdlFFzXwoKkqk56LVdDVkESlsSrmorglPccG0bAFYZ1mcDHrzfnR9YDpXEpN2/w4l7AattS4ka3t6IicV39nQNRF5gamIvZ7iCvAnKLzWZtACj+OzBDyzQ+CK/bOye0dF7z5oFFaozS+BZIewKEsKgFuWR8ptr38gliwT5upOcZmP0T9B5jfAsp6K5NpVBZhP6roYwAw7P9+7DmDfftcYhWvmqTJfDFQfZgDauIu7prXyNz95SZ5jVOf0jUGy71N3nTWVUVvSfEMe6b8s8nipg/t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:39:54.5696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57da5b83-3a80-42b5-43be-08dedd7c8131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

From: sai madhu <suryasaimadhu369@gmail.com>

kvm_emulate_halt() calls kvm_skip_emulated_instruction() before
kvm_emulate_halt_noskip(). When single-step debugging is active,
the skip path can trigger a debug exception and set exit_reason to
KVM_EXIT_DEBUG, but halt emulation then overwrites it with
KVM_EXIT_HLT on the userspace LAPIC path. Return immediately when
a debug exit is already pending so userspace debuggers receive the
correct event.

Signed-off-by: sai madhu <suryasaimadhu369@gmail.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..2fd6ad49050c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8658,10 +8658,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_halt_noskip);
 int kvm_emulate_halt(struct kvm_vcpu *vcpu)
 {
 	int ret = kvm_skip_emulated_instruction(vcpu);
+
 	/*
-	 * TODO: we might be squashing a GUESTDBG_SINGLESTEP-triggered
-	 * KVM_EXIT_DEBUG here.
+	 * If kvm_skip_emulated_instruction() triggered a singlestep
+	 * debug exception, return to userspace immediately so the
+	 * debugger can process the event. Do not let halt emulation
+	 * overwrite the KVM_EXIT_DEBUG exit reason.
 	 */
+	if (vcpu->run->exit_reason == KVM_EXIT_DEBUG)
+		return ret;
+
 	return kvm_emulate_halt_noskip(vcpu) && ret;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_halt);
-- 
2.43.0

