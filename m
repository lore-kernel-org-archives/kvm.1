Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9465283CB1;
	Thu,  2 Apr 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155510; cv=fail; b=giB+YK1D72j4oWWV7kp7iVsuiH3OzxewAedz4/9GL6GgSc7SZSDnSaXLX9wiPbYWMgemwiA8m+kZqcpaxH/l+aoFUco8yNSlr2zzeOoUrkAoSWTorDEIB7zVCOotYBltrVLc7PALczISQB9qsD1k4IZ4Q/RR5cMRFEuQ5FVcZoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155510; c=relaxed/simple;
	bh=xg4+NIWE9p7jc84SYtJY3vFdH39kccmNrLVXJaWTXJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPVd3rB5430gamXJEL13wzmi6GgdzSHJfmXsL87/KR9lz8H2tmbwBK4IL0+S3tJvZXOEqtKpZSnxxx6GaxJRCs6AmxkvrKeGiYM14HiTqQ3kaPvgWFrIiUxkCLDI1pOMJ8blT/MiioXD+hXwHm/L8k9h3Jj2braAhQ+ArOH0C4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X4qE9/yj; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X4qE9/yj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvmm3PNdgbXcb73QGbYdxYauQeNTlhI5t+bRnrQfCRouLZ23ex4URoe9TJkoUaVuTxjpshcLYfQ5aEjpXHpsz39Cje+yf87lLa8B6U5LL0fOMJC/oy1bd3gUOpSoKW0a+Ql0GzoYcd6sG8FoSJc3KX7CVgNt9fXJKapCsb63bANDn69LGw67g0bZuLGNq5y6/6C5IHmNRHhIg9pPT5QYPKbP06inVeHBO4soL8HH/xbLLNQVSkM1i9PkbYmesp75AU9lInciFMBa+UlR0a/F07WTtlGujwxRLpd1Kwz6yT3lICw/PzTnElFJwaaR0XKuGddt7KNn177/83Y9U2brrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thVQ29lz++egn7IjwArk6Vo+Eh2Z/cwBuUW+A/5RA3A=;
 b=f7qHKWfrAOa+SufYsJUfT0/UjWkQI0P5LcKwFsd2h3feopixIQlk+UNmQBbQV0UVYGOpyxSYbrax9aWuLxN4xBBbFZUZhAVbnKHHHguVz1jeklch23Qd0kFxNcwLgPsUkE9MOo0obRWA8To13R6v7UO5pTTWp2jj9Da9crHdhYyA2qSvqU5cjY0oAcqhc9J89Lz8o7N+YrCJ+Bia9fHPyr0YC7m/K9kuEnvFmqChvfQcuDcgfbWRfZTrlL7WsbgRmDIcNdFGF+x+SwI/0lX6PJjS6YsRJlQZfDhwgJfxiMvm8gSf++3qphPMxea/tYcUuyUUnkiQoBbP8C48AD/SJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thVQ29lz++egn7IjwArk6Vo+Eh2Z/cwBuUW+A/5RA3A=;
 b=X4qE9/yjhqQUBVNpKUfcU61+WVcPcRQ1zwPQ4sgnDwCitdbRz6361teOjLmG+4mmOKWxGF5hh82daR++oq4DTl8jtMI/GYQMql1OuA086TzXn8QOkroNv3xgd42HsRoeYUAT1A9OkET1er1Q6a1viL55BiY42jTFDhYN5CzHUGM=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:45:03 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::61) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:45:03 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:44:59 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 7/7] KVM: SVM: Enable FRED virtualization
Date: Thu, 2 Apr 2026 18:42:40 +0000
Message-ID: <20260402184240.1939480-8-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: cf013d3a-7256-4acf-4d56-08de90e7f3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ls9G1zmnj5WJYlgH617ZkGXNFmR0i2lHz7InhKbE6ACimpXZB05G5suuDdvjykzvHFLh2mPc17zS/FstLL21ofaW9Q7ZZTFbstdyJpJKTcokIloEE0Qf2fh5DacOdEHj21F0IWP30vke91GDN66VwIcEKF0Wmn1x8hikqvC4PXU6yWa5ly0ZKMZRekRECLK1/SwZO46NM4q1wKm05UNvT5Pd/OqBTxvrQH3ssMOl60UKPMt6tkpW1oKCIAN0uc5HfjHDaGp0nw96riF6GU2zHHaqodvA6lto8uUWLPUC3o6HPmhJwKgP/q3EBWdWbdGQ3nkY9QHFVVFj2ZqswzSYE01HOE14AD5v8zeZeW++pDOJB0HNeSLyrIy5jzw0YG2kONaTwk4O/OCLT0yFz/I9BfAymVFa2+vu/O6HHD5ee0slEwsY3UcA2FG7b7EZHZygW8s3rorZdSUXQVy8hnqB7GEvfAo2RGGmhyvxoRzyBJRnAxUSsxkEep1rc4USaQ5XVoXJ2aWWR1XVJWWtTPRI6wb8dRRCnaXrpYqgtAxOaxCCiVjEQ8YODDKIr1xZmkdnyBLGwPdISKGCpZkgdUBX2vwXqqK45SFJvjpcgRqdr/MsWPyHLYNCasuw+yTO9OXTTfSZj31E+ns6L8fhgy6ga+Urwo/N7Yfkq9dqBQ+ZVJQ3xe+jam+t2pTFRif7g/KFZ8qsvdviNh5ozEFe0IUCE6QLymgLYP3Fr527MUNrhLU1TRUfwMvjeybERntEspEjNHBR4Wj026tkxg9OOCqYKQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hIP0wA0Pw9uEWBcTj620stLU1ZarXzYE1SYFJwsuWi3G62urxExhYGpKGEcoJH2eiBR74+JMceCxftQJdTYK9omCNG73lEyo+vK0H49jGTe6yhzBwQlc0tfW1F7/P+qnA6FF5aW1rYDgr2xvNNDuU06vgzEehyNF8szI0ltW+4SYHwIf2GULmeH42cE6frCU0OAWwvMb2xe401H2NgjN2JH42iUaOew/l0mX55h1RHtuJnOyq22hQO6LjHGBe6TLtkn0ajlGHhVN6w1SvnheY9Z77OblEauuiKG1guqedFuu5o/vk4j/Pd4iaxIcBPD3DP/1mCN/f5VWHzXX3NctOpRtfy3+isd8l0ZM8tpqBKagwBlo+bJ508E1+62wuQLfJ3Tm0ZI3q7V5fU9SN/eCjvREWVFjANxyzPPOF5ZKsSgpiksZfc2VmwY6CD85WJ3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:45:03.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf013d3a-7256-4acf-4d56-08de90e7f3c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826

Set the FRED_VIRT_ENABLE bit (bit 4) in the VIRT_EXT field of VMCB to enable
FRED Virtualization for the guest. This enables automatic save/restore of
FRED MSRs.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
- Confined the enabling of vFRED to svm_vcpu_after_set_cpuid() only
  (Sean Christopherson).

---
 arch/x86/include/asm/svm.h | 1 +
 arch/x86/kvm/svm/svm.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index c0f6523e2b2d..f4a9781c1d6c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -224,6 +224,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define LBR_CTL_ENABLE_MASK BIT_ULL(0)
 #define VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK BIT_ULL(1)
+#define FRED_VIRT_ENABLE_MASK BIT_ULL(4)
 
 #define SVM_INTERRUPT_SHADOW_MASK	BIT_ULL(0)
 #define SVM_GUEST_INTERRUPT_MASK	BIT_ULL(1)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d411df3dd78..4b270490b2fd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4540,6 +4540,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);

+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
+	else
+		svm->vmcb->control.virt_ext &= ~FRED_VIRT_ENABLE_MASK;
+
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
 }
-- 
2.43.0

