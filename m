Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D449B454;
	Fri, 25 Sep 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336740; cv=fail; b=CnE/ryU+5vAaNUaiYUOohgRXGZFHrJuRRUac+dBaw5aU8sBDepodpAYjRIeVv7PFOlUCR75omK2aj2aUG/2SEkJDfjaDbkB0DYUVmh7dwUukfFbjL1q23Gco/eYVvxo8rgNRmBWGV0418t30jAPg+7EGZQp4HOZDS8lqDSkk3bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336740; c=relaxed/simple;
	bh=TkD05dfftwWsYDlBOJbWsjUp23V0FAcbDySKcF0I1TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBpb+s6oiG2Ijxddu9GrXtY4JPq1MeXDPPigR7Q7NJ8xKKt72EW2HDsSme+UwcXzC05LlulhLnGrjp7K46Qku6EYZ5MzMv4Iu8jq4uxYYcGBKim1KYMMQT0q4Zmrezedy3iBhhwDoiW1OnLpIX10x/UOHZI2PgaHEwwbuo/7cIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j+wNf5Bn; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j+wNf5Bn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5xImpMuzCL+5MhSHc04lbM6d7wEqKPJZVh8tHBBvqNBbeAmzlrpeDPpRdrUSGBIYDRU3deK7y4NafgBaXq0lW2EnKlEpGaxIvvlJH0wk2gowOlsCv6j4wUgcOHWzjP2s1/rD9Alw8XvPPpDYJwNjajpyiKQsg6kyLmqQ72FqKT9t0BxT+wZzurmrDxyXcoYPX7J29I2UDKK/lwqaA8d4zadgEf8eW2pc+2/tuTLEbg/Rar/B46r5D6+xXNyOOcme7YH0B8aC6Ar4Di63dKVvI5SUYyP4tbZlKbf22TxqNK+5+SLzrq7sWoZnTXijuN0oeCPDJgU53VRSPXF60SSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0lhODxMKoku4R9cz4xA83cS5qN3eXdN2aRNmL8LSvw=;
 b=FkLhfDyMoXQXlj1TNk3GktHbztzsBGIUvCUlmTrtrwOToxz15BYfofLVQ/7hGw0GcpyPbJkozZ1V927XZS7vkm9QjKIioCxrtbQ9V5zjptvoMCKbEX+F3eHiHdUxw7lyhEIS0Zo8VDcyYfcRgDADQz0YigYMCHXIRNIf5CeZ8PD7P7R70Td05GLtVhWGy4qcoNSHSEdpxrVndJzQRbmM+SqJ2eLqAS15n28Oq95vj9x+EwNmY46xKrhH9xCNQxfk6Xakxx9XtOKZlLCbhAubf4lRRVqIP+8UyPzUQ4k6j/ij99d/kA3p3DX89b9dQtdaCizMXMF8+Mx4kkCesGteXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0lhODxMKoku4R9cz4xA83cS5qN3eXdN2aRNmL8LSvw=;
 b=j+wNf5BnpzTLfwmjeeMIlUS03NISKVxYVFOCg2LQTJhQmRrnjBlh9eVmHfX/DrFwfsKJVMQQzZGG+esnvQ588QgE/sEXtsrxnkQ80lxVwi/WCoJvz64GrpTfQVM9EiRO9obLHGOpaa9ZvxbYzSY6JyLwjHhntM3NmzIR3nNxAG8=
Received: from BN0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:e8::28)
 by DS6PR12MB381293.namprd12.prod.outlook.com (2603:10b6:8:414::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:45:34 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::2c) by BN0PR04CA0053.outlook.office365.com
 (2603:10b6:408:e8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:45:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:45:34 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:45:28 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 9/9] KVM: SVM: Don't intercept ICEBP while the guest has FRED enabled
Date: Fri, 25 Sep 2026 11:40:17 +0000
Message-ID: <20260925114017.2208531-10-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|DS6PR12MB381293:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b80a9b-37d4-4994-e83a-08df1afa8273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	y0Zaf0JqtICf48kwktuXdD3Cf3JMHcjN6wuy4+l67OnF9J920aAdrE9bKdZ24AElSgeA+nP8JXKXSSE5HFTe+KNCaYPG15D5HJbrwUNFnEWvldCj1tejan/aJi6HIBHScvjkfEOtXcjTSB0AiLg2cq9XFlveDIABPsJ32xurmFzk9Y0cYYxbTqMgKIBJsjec3gE4ugesHUaZ+eDdf0H6NlFyHPe5FseKQPIjTknuUK1JEC03jGC7coyCyflDFxCzrjM7PCWVJMeH64fUdlXM4SY/wwllqQSsilECfZtGwpDTOa3fkCXTz8BJeC0VeTBWl8shUO8cdGWcf9oSbjFrRs1FEcTsFlWv0fMoC7OZzB0NnjpnfwBmcSOT6hd5Y+bKWahkWc/ldrjvFFLNMqlmXvutScsF/N71lFrG3QPxt5wEpjGpRhIRbrswPT0/pqThxGf78E1y209v9xAuxbYJK+LSt9AUpM/GEIzGMNx0uqWhfRUM21y8Aie3KpamAs/T+YBwKQQxh6lb3oA9KmaBWAcm9WbgmmUf/Ov2x1XY5V49aLnHy7ELfFmuF1wN7L2hW/Mgks1TURI3nhUNuIHlJvGAOzVsLC673DzU6jDG9WXtmYiRz8N7UKHodR42gHaggKk5TVzFPr3tpTa8SkYyuFgOXDXDpSUNoAQE5vMYOGB05sfQupMAwNUmod93Fww9WV6O/7iYyjouY+td/Bevtg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZUXu8rjG2DF+BST6c1EgaqRW54WPWV2ewESVtwsqy7ujQ9ya79hGVxWsERvGyVnE2m3Mf/MaRpFvoXYoaD7v26SgZ5bZDbGSu1N9afCQD/RgA6JGyAbIlBRkToy8FmG1SXfRQSrjSlNB9ntNvFPHFiZbVpSKlEPa5IlgfmQGJQFwdTQsGxCue3LJh0HKAdyGdqS8e/rfPXuIJ47pdM7Pq6YDzxiILW1tqvuFPgD/9zPS4eLPSesAD2OmlfZwLSRB1ODD/xv74KsyCec50XKchiElJtmeS3nrzyjF5ne1D6CU0rOPBgZRAES7woz72G59NYW8/g8ia81BpYbszWz+0rQUBS5dr98f9lPRxVVXm86ROMnj/bg3fBeU6YaaSB/i/s3mb6yD2UYtI6OnrQP85A3QREsuRogukHw14GW+nIzMHOnDd6yBuHEh5D1mf2Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:45:34.2260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b80a9b-37d4-4994-e83a-08df1afa8273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB381293

Commit ec9a16c6aeba ("KVM: SVM: Always intercept ICEBP to workaround AMD
ICEBP+TASK_SWITCH flaws") makes KVM intercept ICEBP and inject the
resulting #DB as a hardware exception. A FRED guest therefore sees INT1
as event type 3 instead of 5. FRED has no task gates, so the workaround
isn't needed while CR4.FRED is set.

Stop intercepting ICEBP while CR4.FRED is set, and recalculate the
intercepts whenever svm_set_cr4() changes CR4.FRED.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* New patch.

---
 arch/x86/kvm/svm/svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 25dd379725d4..9b2cab844823 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1137,6 +1137,11 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_RDPMC);
 	else
 		svm_clr_intercept(svm, INTERCEPT_RDPMC);
+
+	if (is_fred_enabled(vcpu))
+		svm_clr_intercept(svm, INTERCEPT_ICEBP);
+	else
+		svm_set_intercept(svm, INTERCEPT_ICEBP);
 }
 
 static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
@@ -1911,6 +1916,9 @@ void svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 	if ((cr4 ^ old_cr4) & (X86_CR4_OSXSAVE | X86_CR4_PKE))
 		vcpu->arch.cpuid_dynamic_bits_dirty = true;
+
+	if ((cr4 ^ old_cr4) & X86_CR4_FRED)
+		kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 }
 
 static void svm_set_segment(struct kvm_vcpu *vcpu,
-- 
2.43.0

