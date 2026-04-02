Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF093F0A86;
	Thu,  2 Apr 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155440; cv=fail; b=HlLhI33zmjXbdmxH3pp47EULk0DTNMIJ1ULopy3e264GuGqIShrDcI/e7jSf1KODwQ2tuvqS9xATehDxv7gJzf2c4NmlhFZbl9niMfY77CufPUiujdN1QXtD0fD93bYTS+gz7hLfWAnH5hUsJUb3yNrO4TyxEwPlyiaiQBIEk/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155440; c=relaxed/simple;
	bh=dl9pewzvvi3SEDxJOWRnmhvonnb+49tXUbN5ow7z1IA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9DRZMcIDINzN5xSgYmb6x7Fl1NPukTMi2h1PExoEpbOfterg4JCXgE0skm7YDZPl2FXC6NvB2yQqGzkHh9pK/0JgnUNzW67SWp2le3VJfWnRmvUmkL3QdX6gr17YE2FEwQxM/1nutBZggLfO0Vvfhn2IeY6hhvj7RZgHdjxvzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=khSU9QNi; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khSU9QNi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INp2apaeA6ydXUuOLoRTwk3nPu2U2j56BFR8xWNwJgtNyFj395VsnQSY8h1S0w4/Wj4jO5qjfp/zU3RuKyXbH5xt0n8o7R8EheUzhgEuiBcZ24N6uSIJnnA7imIQjBXSgr6tQ1apAYfgcDq1rgXXY6qkqhEwC3cEJXB82qFRzYncVfh9pjmkb9wxC+0tMRmbPtcX+3svMwhXEvwRZp4lm1bhnVACFBFbzhx+ApDPCggCS2nITijUO7aCBKYGEjwa+/T3chm58cjrRS9AXeMhIuStZJJeLSao8rHjwCnZRrFSxHisE+wokWEO8xgsP6XsB2ExKVHCypi+ccTQek1LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8fuVve8UsR25zwf/Gj7s8cmj7jyUYug6LV9+blx6zA=;
 b=jmSB/5Eiv25yHTenNOVFKhgY6esWI49H+bsdrLkwxB7N60VyN61WyJ/XTnYDVbrtl0+yL93PDDZZBFt2NkDdsvAI8VyW4wn8lq2UTgwK9DiMRxFgWbyuxfGOhR7M21zs9+cO9ZfzC7OXGRGV75zLUsdviSi6r+MbENx3ZxR4v9QepPpmbTciwbBFSVWVwJcmVS4tZcLQ423lsvFskthEzatJskbIZkb9LTKG8VXTrucFXtWn5gjKBAStAV66Krwyq7hFps0fTwcZu/Q77AhJX+fh5OCk8CRr6rImlguIr0zzdMA0bC1SNlVdnd8D5suiixJPaT9lgp+QQmevo0jmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8fuVve8UsR25zwf/Gj7s8cmj7jyUYug6LV9+blx6zA=;
 b=khSU9QNiURPS6V9mSPBYcQLH4FrRzOjOeGhQ2PFVjckKpINRDZ0sOERL6VhEDO88kLpgiKKjJc2TfUrZjJZ7RqNjF+43ksNtpw8Pfn58FnWjL7T4tjuMc5JFa8q3//BLc34VCGRGUVeZ1rjdH9kmzVMmkkZWtheyfmTzIrIkPuk=
Received: from BL0PR0102CA0050.prod.exchangelabs.com (2603:10b6:208:25::27) by
 SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:43:52 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::1d) by BL0PR0102CA0050.outlook.office365.com
 (2603:10b6:208:25::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:43:52 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:43:48 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 3/7] KVM: SVM: Save restore FRED_RSP0 for FRED supported guests
Date: Thu, 2 Apr 2026 18:42:36 +0000
Message-ID: <20260402184240.1939480-4-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7e00a8-fbb0-4154-3e87-08de90e7c976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UJdHQlYMmZkmhTpmX6ai1NQeIS9sVsftbhcZjFmJu3zPHSFZjt4FYsQiqcxJkSLsdQTo7Yc9CbioVZvZVPP8Y4bzq3i58px5I7OOBX2sd1JVWLDMyKBnRTt9b3Otn9gRy5LQLkDLa518Ra7LLw2/LYEimFoWI4kUr32W8SbdMng7yuq7HcCSYGSSQMAu5F642GcIuQS1K9bDfRQ2ESnd/E0wYmNOly+nHfvv+lt5ZzZgUQDhcebexcoHpgF5do3ilxwechYdY7fkyznsbRh4gtUgZswelF1eqQizQl3WG4HEnfDJw6RZai6vORsWOxJBwv69H+FpzPe8aROXcZqYa2HcdZFZaiWCb21ud/lPRlQrRrmij1mk6tzX7ley0dLesi1xlhUXr9nyjhGVs+VuAQhESaE3tU7DiL+WBe3s/fnNG0/nqwb9L7xgO/0U9XIQ9CYhAwnY6CYPjTwquiHlLXRboLp6MmsMbfZLijmP88FMiI/TddyTJrnBwaV9iN+hzC+H/7D5/TfekAmfd+4Z649l9VY4Rn7HTLgER8o+ccM/4YmHiSw/fnU1aG1LOep8ye8NYQBLobjIZm47a9friGbeHG+/ThK40bQg3n2NuFO1/L76KYLl1wYH0mTeE6/ZyXLIV1+VuMvrjzpoCqiIcWjkFfQiHl/TjevvziKhzbHSHAT0r5BV3aMriE5zsLIqN/Z7C9nhQQGbSyfapofMzDq14bpXiVUpA+4QxgfzWkmeE1/3kj1/fYmk0MGetv3CncxhGZK/ZqSQSN5OFQvyHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pqpR/Bpdm+b6UOnU82tSSK6uGU9VzyzM1J5615sI8EzruRs3FEMq9E3Ko+VOFtZXOsQh45jL9CykoiZ9zujd3Um+hmD4PmXAD8VTw0Xk7/OITeD9jvtE+p+dFR2krAuVqyDvQuyxIReAe3EH8U0FiWcdUFiG4gbHdTbcpalc68ohC9oVdVr4aD1pUimRQyNrBLiiQ6tmgHg+F+tmem2Lcha7LC+aUGoKsuD/ddt+efz62ksxNAm8+1e4BpblHIiwrd92XTKoZ2hGF2s9Z+wRW8Isn+1dI18ftE3+FwKREW1cOZtb6MMa6WwPNBDiaNKgfp/1c4REzMQT6l7TvPoHcHm7vSW69x+Vok8h4fduxC4kgQbwBzFoosLbMCfrLx2ZklXqDOdil4+DI2Y//qwAyiA2DNFFvHcr8Owsy8afoKaC1EZw7K0sdCgtoOAhAu5V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:43:52.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7e00a8-fbb0-4154-3e87-08de90e7c976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests. Save it
in svm_prepare_host_switch() and restore it in svm_prepare_switch_to_guest()
so that the correct physical CPU state is updated.

Also, synchronize the current value of MSR_IA32_FRED_RSP0 in hardware to the
kernel's local cache. Note that the desired host's RSP0 will be set when the
CPU exits to userspace for servicing vCPU tasks.

Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
- Moved FRED MSRs save/restore logic from svm_vcpu_enter_exit() to 
  svm_prepare_[host_switch/switch_to_guest]() to reduce some MSR accesses.
- While switching to host, added a safety check on guest_state_loaded.

---
arch/x86/kvm/svm/svm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5e85b2853ad6..3f7f8fb0dfac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1383,12 +1383,34 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 		sd->bp_spec_reduce_set = true;
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 	}
+
+	/*
+	 * Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests.
+	 */
+	if (!sev_es_guest(vcpu->kvm) && guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+		wrmsrq(MSR_IA32_FRED_RSP0, svm->vmcb->save.fred_rsp0);
+
 	svm->guest_state_loaded = true;
 }
 
 static void svm_prepare_host_switch(struct kvm_vcpu *vcpu)
 {
-	to_svm(vcpu)->guest_state_loaded = false;
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!svm->guest_state_loaded)
+		return;
+
+	/*
+	 * Hardware does not save/restore FRED_RSP0 for Non-SEV-ES guests.
+	 * Also, sync hardware MSR value to per-CPU cache. This helps in
+	 * restoring Host RSP0 when exiting to userspace in fred_update_rsp0().
+	 */
+	if (!sev_es_guest(vcpu->kvm) && guest_cpu_cap_has(vcpu, X86_FEATURE_FRED)) {
+		rdmsrq(MSR_IA32_FRED_RSP0, svm->vmcb->save.fred_rsp0);
+		fred_sync_rsp0(svm->vmcb->save.fred_rsp0);
+	}
+
+	svm->guest_state_loaded = false;
 }
 
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.43.0

