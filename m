Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299415;
	b=BUJs8XzSfQQTmOnIGU2RiREufuYFVj5a/yg3C6ZOw/6kOs4Lok80Lh8EQuk9DQN0FxTn
	 D4x6VpaQ0PPcj8k2KwyfsvIfH35fGYXhyNShSQyFRfBKFzzWRwuIBVeOcPatGsreebaMD
	 gNFODCFaHPaC7gIT7Ylai1nKONhANUtDlKLGXIHXIPwHheOVjan+U9UTvhUaxHpiZUO/U
	 ISFboQ4bW2P7Jo1ZjlVdyJ9jCbSWULRMylUCDxo0l62tbrSbdBbgwfIRmox0ozbMKlF1H
	 6Q49rq4jyPEa4ibNXTeSPt9sUHoWx3Hdo5fokc/NCcKmKvDpwwP17hylVosPdx/uTHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299415;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YrifWyEk7c+CVOJBRNVi1knvEaGV83v75Jq1KvwsXvI=;
	b=dRFofNgqoGnW3pJaHpSLOxDDFEW1//ipB28e85eJcombYCK7HXhrSW2y/viKTgt74M+N
	 f7n2x/cqXcHiqtRK4ZWyzJrOWjajllOaxLmpZ0BnxrSgSQe0rJdwic2O0r0q3habiJvjy
	 P1wQxw4fh9SqiTO12UO4r0Y5FyUTduU4yD7PirEh6rDdnozxd2qGz1FrLqvaj/ErV91vj
	 YlwSshKDrIC8G+qfyrSU0tVE/JulOmpqYdDn/1zqC40kd8Ing/ZJvwCyTOOq4BcARVD9a
	 CsuLRtJafp0jF+nPQ5vAg8tUtg4pvcG8W0J5T4th5XN6DJ3PZfcUDYXgpF/ZdCBcqbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A+NwF+oR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.0
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96368606A9B1;
	Tue, 10 Nov 2026 08:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96368606A9B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A+NwF+oR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0DQbJzyW+Hf3iB7VmQrYxGget4Hoj191jVaebkm0iGHlHiKo0bS5vSHDlMjaMZOxILIdtWbabgmnu/0SBBbb/PIV1Y6maC7K89nl7tZUk1yPhOIsUcW27JGRr+bnqDo9WaZTuMY3QCLTX1lpJabrEZTeLhFMT5K314NddApVok+seR+cJZMXbtPwl5RxSXfiUA4KgQLa8RF19F0dqo8sZ7e5nTz0FCqHhMyEeQ/+Dw4NxskiobXhNnxC/bRt3FIQO/K3R0H1eHfFcvms0kYsA6Ft1+UKy7vxGmySDkuRTAhx+JLEqLe1mRYP/44sE4ddDHfa+8gjkrDCgKR2d8ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrifWyEk7c+CVOJBRNVi1knvEaGV83v75Jq1KvwsXvI=;
 b=v5gD231TuzciBFkRfiX0lXAKamda1ZCwCHGMz8qY+umdDgl2WGyYC8Ni5RdyyfV+amKxCibGh87rkQN+wPe1rjUDvO3M3J5CTtpVcKkj9CfSXvrhW+kRV7zdsZSTH0Cwe58lXCDSwg71+IMUe89+umYME24k8WJ/WD3oW9efN0NblmIsZuo1XWR0N9sMH4JPRDh8se+IdCGfWDDkjBZTraYE08gRXYqgvEErwlS6PZYa/2YRW5MWBlV3xJx/CHNn9G9qEfVXN7bTFd3vl7pAbCwfZja8kKM0u3Hy+2mid29cHw52xJPN5K0Sxfh38a23Lajt+N1ROgO01GTVSsmVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrifWyEk7c+CVOJBRNVi1knvEaGV83v75Jq1KvwsXvI=;
 b=A+NwF+oR2Zj6fUUTxyTblzAQ+3zjLzTqwig4gGuNGZfV0g1Mbm3PTfqVcPwD4SOzQ+1pH5cdCBQP0G4UsgaEFpkkTX6/uUkY9ikwP2g8yC/+LK3QAhWYCItybZIq0SXuyLgTXR7cwOhKtQXVEbH+s59YQ9gW9RCwQlXLHwyzIZA=
Received: from CH0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:610:11a::10)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:30:10 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::63) by CH0PR03CA0338.outlook.office365.com
 (2603:10b6:610:11a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 08:30:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:30:09 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:30:08 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  5/9] KVM: SVM: Bypass lapic for VMPL1-3 guest with Alternate Injection enabled
Date: Tue, 10 Nov 2026 08:28:50 +0000
Message-ID: <944ca1618940a8fd530bdacb3a113cb430bfa919.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269bd80-d621-4f20-2ab1-08df3f04d4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FOVo4SGex6cHmjvRoJ51jivM3s01IAjIt/pK3bsNvA2aqrNaiUWtVhcSFXI8efPZGnde6jS2pq3tpGhZaWQObgHbn5ox9M7saWdOgDy09ERXXAERnLSvgcEcC0CubFxwQWsQo87gIvH6N2/xK+JKsWxwKgnLA0L1yRlfeU9ulBZGVVzJ4Z0ySZPIsGNFcWRlPvW98Ku3KA1G4ihuMG2v1xUacqBy3JYHbh2L86Kvp5IX4BT0xuazPYk5Ww7PVwg4+FBBEj8u8TpznZI6kL4WRWNEQ1kI/tNzIynwOHRA023kJpmdXukxa47+Eh21+sJJgZYVVHjPlfveL1EqzRuHscfaqWfmTGQ9+bkiTqPOhWQFwym9wOb5zo0wqSgQdq4i4zAb/F+hGkBJmJhEG10W/vhyVT1on78D/7PJ4aF7eJ+SG9sRo3ahj26B/RVTjueCJX3RLpIGA9qQIHEzcMkOs4fffa4yxJO5o+xFNm+cshrvFQMc7PporovVRmIgqUYaCjZiIK1/8KkN2q/P6D7f3xxK36D7lsvr4d5PLJ+Q6h1OgsFfJzysrQCG7jT5FVoADnLRVosSspqzQpdG+4HITOyOm95BryKxtKfCYK9bmZnYkjj0GHIux4pQFW2JpLstzFrcxLdOqZMd17+FqnrYDlkr6VZ+JYUAtISR6S/hW9LgVRSSivYYllfaaEdl5eq3VltUVhBoIhrkvdVI1l3/3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x/TwZ8JbT2VPlr/W1CUrh32SgvBTeSpj5F3tjrpv8Fiq1I0WuwLF67fcf5ABTt344RP0dH37OF3OVPjT9cyJ8k6BQeo+aP9i6Xum+mwEnWl1fXwHTAUeTda5jvwidy6OEveIijmcM+MNHkKFiMToWXja/d/C5aDegBB++CTjCGwNTVsXDnCxyIlRAM79rn1ibx7Q3OHPUKTu0rnclW0RWAxon9PrnhQnoHVYGWJ3w8j0/X0hbCVzsL3QqOh7friefd1DFHau6xN0DQBdv9G8fj0wN3QsyIRYUWD56eQwcw+TdK70DRUEhftO6yyOXRXkxvJTat2qjs8F4VhzmDExQfNez3/oqWAAuX6m8y4S2m8NVH3arj+Ii2ZuMfyza2H4sYg7WbZ8u+ej/75R6k9QiJv2il3Te8osM4jjBV6quJ/fEeWqW0+zpaEY+89OJy88
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:09.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269bd80-d621-4f20-2ab1-08df3f04d4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

The interrupts for VMPL1-3 are handled in the SVSM by its APIC emulation
so bypass the KVM's APIC layer and queue them into the doorbell page.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 1 +
 arch/x86/include/asm/kvm_host.h    | 1 +
 arch/x86/kvm/lapic.c               | 7 +++++--
 arch/x86/kvm/svm/svm.c             | 6 ++++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 16da6d1678e5..dfd38f9408cc 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -96,6 +96,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP_OPTIONAL_RET0(has_interrupt)
+KVM_X86_OP_OPTIONAL_RET0(is_bypass_apic_active)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL(link_external_spt)
 KVM_X86_OP_OPTIONAL(set_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 985d7f4d7140..60c102db1003 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1874,6 +1874,7 @@ struct kvm_x86_ops {
 	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
 				unsigned char *hypercall_addr);
 	int (*has_interrupt)(struct kvm_vcpu *vcpu);
+	bool (*is_bypass_apic_active)(struct kvm_vcpu *vcpu);
 	void (*inject_irq)(struct kvm_vcpu *vcpu, bool reinjected);
 	void (*inject_nmi)(struct kvm_vcpu *vcpu);
 	void (*inject_exception)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9ebae1052f64..952b6cc92ede 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3189,8 +3189,11 @@ void kvm_apic_ack_interrupt(struct kvm_vcpu *vcpu, int vector)
 		 * a concurrent interrupt injection, but that would have
 		 * triggered KVM_REQ_EVENT already.
 		 */
-		apic_set_isr(vector, apic);
-		__apic_update_ppr(apic, &ppr);
+		if (!kvm_x86_call(is_bypass_apic_active)(vcpu)) {
+			apic_set_isr(vector, apic);
+			__apic_update_ppr(apic, &ppr);
+		}
+
 	}
 
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7c4b3d05ae88..756b11bebb5a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4111,6 +4111,11 @@ static int svm_has_interrupt(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static bool svm_is_bypass_apic_active(struct kvm_vcpu *vcpu)
+{
+	return sev_snp_is_ai_active(vcpu);
+}
+
 static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5446,6 +5451,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.get_interrupt_shadow = svm_get_interrupt_shadow,
 	.patch_hypercall = svm_patch_hypercall,
 	.has_interrupt = svm_has_interrupt,
+	.is_bypass_apic_active = svm_is_bypass_apic_active,
 	.inject_irq = svm_inject_irq,
 	.inject_nmi = svm_inject_nmi,
 	.is_vnmi_pending = svm_is_vnmi_pending,
-- 
2.43.0

