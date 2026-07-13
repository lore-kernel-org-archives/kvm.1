Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BA361DDC
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923183; cv=fail; b=jNnRWHMKujf0I89aS9d1OpYL9zmf8ec9UHQR3pPR0P1/3MjFgK0v3TQe112ZkRt1hCCByWeMJ+jEXVuMB+EcJqML3Tvnht7vDKXzWCw9e9UNL898bFpNuauidvU2eIzJjysfxY0l4VWgnG266cAiCKKDPE/w6YmbIrRMEgJpv8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923183; c=relaxed/simple;
	bh=KzyRKNc8EbGAAhI8q4TzyALHF4aSGIjfGaJNmIBUpzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UjAatqCLul7aUMNyB4llo6bFLgRXBXfDZXX6RQC93ahlt704ZyM2CqsenUiKfr/PHa4y2WkX4KtwjLsqN/kX3T78hJL5S4iX087c6al2qelpuACdT1puXDv2S+L4f4s9pfRW+ICEbD5S6TfovyDALC6ZmxsilUXRFvPjALHiwnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yz4vWA/J; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yz4vWA/J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxG6/qOsWs5kt/qnl8vn7vZu0+issbkF37DZetMvM4/F3BQw1VlJ5qTMzXuMG2qtqCfeskgNzQuV9CKeXGGEaW1Frnc1E0/wRgG1LMmPV3eQdvjcU/Ru3BPGn4+TBo4zRwPjCcwaZ76ok9HCerrjiVcSJ4rJyC7l4oEiIJ21dl+nWeGvOt0aqKA2rE/fPe2DH7gfbVz5UTWMbT5VUH8otazywEWcXUPoovbGTPsqw1co2yqkLOXNj+1h/p1fgUH5odMBHf8AWcD0JYv+MqssL709lcPY6gwx4llo1FwqdnN5YLHZUmX0AWbIati0TmSzkaAn6BFMGxyTUH33Vl9cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXLTgl7NHTiYGgQeRSjZc+BEo/IMhdCNHv36V0Z+1kE=;
 b=a/V2MV4ZJtXYJUyMjhrgEy/vfEY8vYXNqUgwOHw0Il0WYRTmqzk4Nfl91zEGvYCp53vBqaB4nhJVh/I0tgL+PLqz7sJ4EKVQd3o3i4a0X0YopZ0YSWcUCCr3BCqSjX8sGJzoufmmSEmag8+ElhcradoQ9Vb7PDxgkCs/O6P5L92/bZ9yBLj1Y7zeCVqMqVjpAb1UeY+RPOIIoahTrGyD2b9bbERVY+4q+XnAMvN5dRe2LgVofkeGaqLIJg3U0dQvrv+ltZcWDC1TH6RA86RFEqv4lZkNM/lq2aI3o7/KephPS2IRrjjSGexc1oHNRf7Lnuq14+b1Rn0am624sFUVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXLTgl7NHTiYGgQeRSjZc+BEo/IMhdCNHv36V0Z+1kE=;
 b=Yz4vWA/JsW2s7F8GgE5RoTGblD8D0GM26p7bznLAcp4zZpGbert2K12jRtx14GdyoHpTiDoxSHuN1mxgQ5g23TkyZrYvfO+hySlAl3OITFqNap6/nC+ss5TY7By83mk5jbaPoa5lrXVpZYJjlnKG6qteP7JuqfEnulYjuOfC2vE=
Received: from DS7PR05CA0034.namprd05.prod.outlook.com (2603:10b6:8:2f::35) by
 SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:12:50 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::a2) by DS7PR05CA0034.outlook.office365.com
 (2603:10b6:8:2f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 06:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 06:12:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 01:12:49 -0500
Received: from [10.85.44.160] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 01:12:47 -0500
Message-ID: <b5f2e0a4-09c1-43d7-b700-c8760d70b195@amd.com>
Date: Mon, 13 Jul 2026 11:42:41 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1] KVM: SVM: Add Page modification logging support
To: <pbonzini@redhat.com>, <seanjc@google.com>
CC: <bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <thomas.lendacky@amd.com>, <yosry@kernel.org>
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
 <20260529063833.1660791-1-nikunj@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260529063833.1660791-1-nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beb8724-dd11-477a-6ff9-08dee0a5c452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a4zNK/SeeJOauJsnasUkurHioLiix4dW9lsnNFkug7d9UXN/ZV9A1S8wwyOMr1pl3lSDL17FbDM8G+WuRnMfdGN5RWH92LeRwgM5luQKa90djxv+Ko8VQUwNK9PQliaeBO0enqGpXcbwDvW5YcVmVLtKwXdxiBwmmfMFdavO6I8ASAosC16XTfh0UushRWL7hP3Yvl7aza31363VXfZsCnMsYYpFMztdb2ppxQloyG1EtViZ1sAd2oqVARb9dVDydZ/0a0YYaxKc0UWy4a3CgNHf726C5TfMB4mUXmuOto4qlF7DHn0O1JmXTvTZcMGYYQaKUzgUrW78F55VJZPNltvAxo7L0ruB2DiE64/NITbnqx3h3wzc/DDuUAX7nupsn1Bf7lKSPo6/oOqTXmEKMEQ/ot/FuuVeocuMu388Es+/6/RNSaLhQmqRcrmzgTBJBf11ElYPyQFpidzHAaQvXZhg6nMDvZVctUyhL/qEI0NLPrEe2x4uwd3WTiZQwuc2oFqMrmiqUu7EtCNFEVWGOl/ibTgp/RC7VRCKN4+XPd/yWoM4A+i8/D2XMYCiYQ1jp1/Yo2rxTfUOBbXZYfiTt1GFNVdEbyxfXnXz+soPr8F1lgE0vjhb5CRFfpeH01n4J62NMj1HZkUpKmwhJKEjyOQKXrEJ9RmPVVCsrmqZDCOtu3QtsLsrwq7p2S3y38mUblmpKioL+1bvTnmeVEV0LQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GcJtBOZuz1TGonaOAGH6x1jqenk4Y5dbY6U1M7sVEOrdhoXXPttbmzn2Mz0zwYa4hSzVufbOj6YJpK9mOORdzEXWsMHmTgCBUIszUl6zr9Vl9Pr82WHcBGvKatI1W0wkqz8cuRMAW7weHlf84MTyUtOWbzxFBMrZsL6svcq84aVVH35+ccuDtKAViI1emGsZ0WKc9P8YmGF9wUDcb+WkgXXEJoW7NLuTVSBtqnOz50WC04nFzJ61oDxg2jf1yqTUDg2gvTDjbrQrg9IMmvvmdEKKxYO/bdS8EOa9NSTMRG4V0HTkAz7kCTokTiKFkXRUI3ktB7QsAZNLS3MA1/snPIUxRrqhHjyW5PW53+tGPSlhDkVRo4pIYCd3HmJi1KPyCww5IQZc9/rW952xE0iv8iGZKDztOt3LIn1Qf3tYUOjer7gbqXShfuStMBisnuG3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:12:50.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beb8724-dd11-477a-6ff9-08dee0a5c452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198



On 5/29/2026 12:08 PM, Nikunj A Dadhania wrote:
> Currently, dirty logging relies on write protecting guest memory and
> marking dirty GFNs during subsequent write faults. This method works but
> incurs overhead due to additional write faults for each dirty GFN.
> 
> Implement support for the Page Modification Logging (PML) feature, a
> hardware-assisted method for efficient dirty logging. PML automatically
> logs dirty GPA[51:12] to a 4K buffer when the CPU sets NPT D-bits. Two new
> VMCB fields are utilized: PML_ADDR and PML_INDEX. The PML_INDEX is
> initialized to 511 (8 bytes per GPA entry), and the CPU decreases the
> PML_INDEX after logging each GPA. When the PML buffer is full, a
> VMEXIT(PML_FULL) with exit code 0x407 is generated.
> 
> Since PML_INDEX in the VMCB control area remains valid after an intercepted
> SHUTDOWN, only initialize it on reset and leave it unchanged on INIT to
> avoid discarding already-logged entries that haven't been flushed.
> 
> PML operates on guest physical addresses at the NPT level, tracking D-bit
> updates in page tables rather than memory content. This allows it to work
> identically for normal and confidential computing guests
> (SEV/SEV-ES/SEV-SNP), enabling cpu_dirty_log_size to be set uniformly for
> all AMD VMs without special-casing encrypted guests.
> 
> Use vmcb01 directly when updating PML controls to ensure L1's state
> remains correct, as svm->vmcb points to vmcb02 when L2 is active.
> 
> PML is not enabled in hardware for nested guests; treat PML_FULL as
> unexpected exits.
> 
> Add a new module parameter to enable/disable PML, and enable it by default
> when supported.
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
> 
> Sending updated 7/7 patch here, rather than reposting the full series.
> 
> Sean, any remaining comments? Happy to send v8 if needed.

A gentle reminder

> v7 -> v7.1:
> * Drop redundant pml_addr=0 in nested_vmcb02_prepare_control() (Yosry)
> * Fix misleading comment, pml_index=-1 is hardening not stale-data cleanup (Yosry, Sean)
> * Route nested SVM_EXIT_PML_FULL to KVM and treat it as unexpected exit (Sean)

Regards,
Nikunj

