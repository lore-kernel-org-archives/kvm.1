Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BD40E8D7
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763181; cv=fail; b=INf2QXOoVN17XtxgjdcPGgoSi8FUcFODAP2jyqhpoQOnEG3kXtH2gvh1J0W/htAEqkfNWM5BfaHj5QLmcB3JOXsslxxi1+hj5wtMYMjZj87VbGv558lNj4/JJE4AvQfz4JXU3RQicKdwKMmt2bEOSP8uC6/ngehgkLT1DiDer94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763181; c=relaxed/simple;
	bh=HL0NgaC3m7UyZzmKct9uArXbYRWdaRRoL8b1Ickw1F0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MksvsQgC45qjouPhq0FpPS1YFnfwykAhNCDRjw9vOyaWDivE5dPYICKSTt5YdYv21hHD5YmnRH3i4GRvXz809sHpMpd5FbB0VSMwSKa2KTdi+w9fJTusgLs2aM6ugIqWP4PHxkMITHO4pxtpeE1q4FvKmi6eTsVTn70L4fM14mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qCi3Fftr; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qCi3Fftr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9Fynt20kkEFF40ACvM/cpfno/Jde6b5xjlpBUvYAXGvTplo03I3+bxgy4tUUB5Af0jNxuw1/ejA+T8Xxz335ilvD7uvyIia9j2QUQa3OctMAGzs7wyM37kWunbjG30/ZhWypKmpFM0iklVjsldBAaBos9jD3XPrKceMDNRcIW28WGtHmfbVkNQrSCXGGOv82dfIvbylOt3Jm/6qokh4M03tmUPRHiOK6FQ4PqZjKXUVyQJ9dtYE+X6uNqRqSKrtC2bzpkOnChqIPVPvjml6UsVbIA+99u6xA1UXjQzb9oveVFFE/AK7NVLGcBmkazyc1ow1Z3deXww8bENo+L5tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM5K4+CzeiubV17NpSETVQsF0gBHACs9ZO7dMiq1L5M=;
 b=ajiPY2uS66bzglslZHGhYuasrWohRZ0KHPZngoyfwLqTdewMgT1RaXP2Mz+XWdAjLlnRX4M17apOtoq8Df/Ym8Cl3VQSeEyPIzsAoz0MZ57BRNYCyAUxuAftF18PhH3g43K9ouqPxEdDxGl9H63rFvGddHnbpagRTzDmOOAAgzG+eAQUnsSXoIbd5a1N+uOl6TjSTPaQpXZ0qqiIcFsaGKc0zRYhVkBsSjP1ex+zNQlkSZNIoJVDscsNqji97/+b+HHAdmgfRNbsSk54ZllgffSPqEeAoY0rKOJlg15J2aVEh/+AwbvZzjihbMOVH0j3LrXDu1dzRCCt2cay87O5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM5K4+CzeiubV17NpSETVQsF0gBHACs9ZO7dMiq1L5M=;
 b=qCi3FftrkeKpIhNQAR8jnE8qQunlNbIHnwbdvBO1kmGDkDe1fac4/TcABElL/xlgw+AguFKNhHHdLKM4+0aVIpUP+ITw5CD8JbxMUtQH8I2w4GOBcK32IWzmJUoJo9uMJpgNYQLDciq5xXjm+0kD30K2VDsnuq6nrYl774nwqIY=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:37 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::83) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 06:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:37 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:34 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>, Pankaj Gupta
	<pankaj.gupta@amd.com>
Subject: [PATCH v8 4/8] KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
Date: Mon, 7 Sep 2026 06:39:02 +0000
Message-ID: <20260907063906.1964557-5-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: bc822f28-04bf-480b-7b1c-08df0caac98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	g/bpkO8qMobPKctJyouhuVsv8WFwNPWpU9bFZvDZzHF4+BOZKDAcPXoIBzmP4o8BoCXreMNjGtib5BZuX5Ii6TTXEyyCKu/tj7HJizMZSwj1lVcbNJ1YiZSsMYhzOuIPP3i06SXgCgXYY9zjhio1L4sKS3E+Vli6LQajmIel2HVFXAM1E+nIll4+/WZ4ft+/U5U6nlff4ilWvJZK8bLLGpea2qgA7ZAHb/yM0/9MtRw/0XmK/gz6YZfqls6WdvWoky/b/kLzblA5Cpy8wBLwCWyyGzm//7Tf1ZEL/51vaeyFoXH/NYXF3IidkBOhjn1Xn9eWfbE0pEoUQHCf7BjZTRQhzqjTHtfbtCVaD4kdfioyQnZzQoqduYgBwR5O2qO8XlPcWyq7GVlOkm697re4WPC7+aaZoOB8JHGpvKH1BHKImNmx3fU/QzizzoyFld4oeQNDwbQQUdeUOXEM+tStwcnc53pPfxTz1yiKemILvgJF4nyJK3s/sTS3zvW+JP2U7Rxab/CT/voOYdsH5Hprr3Vx8aecbQ97GaRxCx6wDlpIUzCAWb8WtXN6aGh+aGWSpxLd5GXD+RGdOP1EGgze9NI5PY7eq/EIIKLQwQ5n5uxWmptRKxHgNBt4fXGvhjfibP8kRQ/g9r6zgsegHErecBfUW6TWazB2JZWb84Elknyg9zSbT0gXfPuyRk6TFFwLvFNpVQhuq87IzcR98WX1Sg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6x237ysDdjG8TMuI85HnCvbys1JFzWHolG757T5sYSED+ucGZbDQOhhOexHnXMTaXjKk90zyjt6d3MjmeMr3K/5Oj9fk5smZMx6Xhu1CQYkJickfmlaGx6jLCPYpCdjqTObFHD5uw0yLcjw60DM460LgN5qC0EB4dx4YfggSCMzj0KmNAZczW16AM8q9/sNvKkss73dpfNTJs3v4UL14osouH4rG4Yspy3nUYadZwtXEkuvdt2ViFDCVN25SLuBo9O7yCKghcjv/bzSn8e2eWKgHc92yabc56NHPaUocAZk9HK1tkbf9XV5l4fQ+x1OF93JGM94FsP2AYm/6JuqnURDsr/FG7xgaQ2FaF2e+ESvRincjOMvXkaR40Lu0+QYj+40qMVTFOjYWZ996toZ7tZVIKy+BqHP22beQaaWns9h707lXs3O7p4X3kLtF8ciN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:37.4405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc822f28-04bf-480b-7b1c-08df0caac98e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

Replace the enable_pml check with cpu_dirty_log_size in VMX PML code
to determine whether PML is enabled on a per-VM basis. The enable_pml
module parameter is a global setting that doesn't reflect per-VM
capabilities, whereas cpu_dirty_log_size accurately indicates whether
a specific VM has PML enabled.

For example, TDX VMs don't yet support PML. Using cpu_dirty_log_size
ensures the check correctly reflects this, while enable_pml would
incorrectly indicate PML is available.

This also improves consistency with kvm_mmu_update_cpu_dirty_logging(),
which already uses cpu_dirty_log_size to determine PML enablement.

Suggested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8baf570dd456..d944ea9ed273 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8422,7 +8422,7 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (WARN_ON_ONCE(!enable_pml))
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
 		return;
 
 	guard(vmx_vmcs01)(vcpu);
-- 
2.48.1

