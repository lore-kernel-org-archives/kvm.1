Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113692580F3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179127; cv=fail; b=NFyB0epoInteIndpT60phXD5dwcD1bLqgTI/wXUBWS4NFLpUUzKx7m5zhzAAhMRTklMMwF6W92o8eZ/OxtlZkHA3PcbzN01xuZMN5zA9+Vo4H2Zx2B6wvh+oSfOJhyGFY4F2z0ctUoEjjOix8/4UD/NtXudvKSo8HBqPCN6C7dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179127; c=relaxed/simple;
	bh=3aKaQ0fSdbqzxg9jCc2NAGY5FhkGiHmeRJYHje+f5eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bzk2L186SasDthSWay75+TEsvfRlaLesTCPWYpFbYpn2+Klkvg20OQskXDuSz52vU54FEJqZFVi8YusJoERo2TtTybwEg7dRbK+I6j0blzQeMCs/vBKrQS5EERZB2XCy6Ji4aIIF4PMzTHGBkWUGZy5h+rkqL2YFdSczgIm/EAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hdZPVM77; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hdZPVM77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV0enp1FWPujr5w3Rk4p9rhffVUXF3XBw2R+qhpZTLASoQk++JVbC3KJ2p2BsnDPCOSM1FRlEDVoLgwO6uErLQNqGALnDLnqQJsAhyaHroZ8EJUnAzWNseKdQpNWFTPqqDAtBiSO298LRsqW7AmJXX2rIWPxrmC14w0DVljTT3xrPWhxYOxqhyKpp3y0ND3aSaRUc1VBwjY9k8xm697bVXc8D7+9OHQ/HRCiub7a4x/KnHvsyBco279F6A4Bg0PMPeKeTbW7B3oe/3cCkXT8d7xigaQ+HGbmm5gUUcNyS+Odcfv+A9Tu/VAPqSJoSXbMEbRRPs2yqZkL1gd5A4/vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tylu7PyJC4jYloMGwCiqM3M5GyBhaRDSq6Uv51rDH0c=;
 b=o3zaxRbyZZn6VLRFzaAbvKkFhAFTYOL30Ff5Qd7TAi99XVjYo+t1kK/+jmLL9nQOi7ST0AMoI09VWhV3WENNCRe6RpQTwz+JLdRn87rSe45HgrNdktBRchmCBJjMa9JFL3xNNYzm+q37rQo7TDJOxLn530VIiwcUZqQNzq0gnj4+CVpkvx/CqUKOE6MQz+uJbuCIRiEbyXOoVqyihANcJi3oxZk3TiVlpQJdEkN2gLTlRmUnqXYOEdZpkzZDhdXkfXFHGs1VJUk64YpONX80Kpy1Rh9sosat8yEIE5E9GvWyTbPkcYoLqzby/toPTbUNDfMEGuPdoTjfdU0dNvlLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tylu7PyJC4jYloMGwCiqM3M5GyBhaRDSq6Uv51rDH0c=;
 b=hdZPVM775CqqAR3WN1xD4zPkmhuv6/zwq2bwaBLn2FX9TtlkWveDDiLkltS+daWLygXe5TeGddvcuAze9cHn8SiaMMAqRV3aIBfmKaXJsz3lGFeWfwjgbU2YIdLWtR54hS6kmK4LuZ28IFklh6Q6x05b+e6aG0NCPVEj4ONzRo8=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 05:18:41 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::2c) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Thu,
 16 Jul 2026 05:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 05:18:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 00:18:38 -0500
Received: from [172.31.178.83] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 00:18:36 -0500
Message-ID: <d43b969e-beca-4dc8-a9e6-d236294e734a@amd.com>
Date: Thu, 16 Jul 2026 10:48:35 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Bump asid_generation on CPU online to avoid
 ASID collision after hotplug
To: Naveen N Rao <naveen@kernel.org>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <yosry@kernel.org>,
	Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>, Srikanth Aithal
	<Srikanth.Aithal@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
References: <20260715063506.672432-1-nikunj@amd.com>
 <aldBh9GummZYUayT@blrnaveerao1>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <aldBh9GummZYUayT@blrnaveerao1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9fba67-e204-4e4c-0a21-08dee2f9b1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|4143699003|3023799007|11063799006|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ax4IJsBS07stM/H322oJgZ0KaMXSS5tBIxj5STHgqKyjxtHvpOEoTeQd6AvZvHIYxqtMzbbF5dMa3a/g/aizdFEF+ZOc8IL3uLRA5MGidhKBE/yC5R0OLcLS8/9I5grB/AB5R+Lbtf5zBWva3/Ne1B8n4g4mDiJvaX2mbxLdogOQk6lykigTUhZA3gldCxczEpQ2z70azaUia5FebyF1ravwPBONYOH6VTbmNrlN8nOe1tXFKaJd88UsoUFbGS6akMfNYCj8vLYDwtYFMPNC12gCj3Jh0FSguLiufl1Ls9kNr1dM0XY7s3Yx3Vv8hyIB4ElTZroiH0ahJ7IJ1/Ct+AJ2eEG/DTY9zxdU0FEKaEPcOGbuWKa2nFn/NPGmepy5ZQR2ZDa8R3wcbNdOcMABHu6bmP/mjXDGOSF0e1CM6JKmQZbZC0cxOLsI6DdOJ5gIpuzW83cI1TaknCJgTDKy2enPb3kPKEb4DQtaOmOM6NhreQZq5sv1DNIjhtvEwhd9BX3vpq2U1AecOTVEKFcPximf2csvKE2ZgpEc5X5tzmguYrOC8RGLHJYEOnUPVfuiSYRArfNkil+Zjw75wI2UaYmmjI+n6e+SmBnQ8Dyo1W7+XvjAlA1oZ5bFrXMXrOfiOQxViF1n6QJ2Mjs/L1aZHRqaLxxN0sVP89PscS1iZWSuOX/EX7GiHYyIDLbIioXWaDrfwHJ8zUSyI454gfff+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(4143699003)(3023799007)(11063799006)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kFJfRIkA0xaYLUboLNKvFMYqVE9GePUPiKUYOPtyTWdigjd3HZH/TFbLk48LUeSCiYo3unDAsdmfaYPIafoJ2okKOSIl51op1o+d9meQufgpq8xQPc/gtL7ALrltnXCR0jMIF1GGscU04RjrF7Zc9ju5KsSHjyzVQGizsFHTjAhn9UH1dWxm3gtZWJxr0zalw4u122r1Zg+Q8k00JZwBcofbwAnmXF8UCBySgXkWWaJXw2EJva+hVQf+wquufNs9BT0SsSRho4uJGwzWUoSdM8dPA97EcoWysPL0OQlh48KDzmwnfS/hcs8G646WxOsDQQFeEo+gpB7MJ9aj+kPwMCbkaHw0/6/qhRY/wXDGsTz5Yq5t/4arIVw3rFHk3WOC5Fb2LWGLeGpf/Mg89IY13Te/CjQ6XUHUnqWeOimki/N1C/n/k7BeWlZNIH5yul1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:18:39.0154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9fba67-e204-4e4c-0a21-08dee2f9b1c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712



On 7/15/2026 1:46 PM, Naveen N Rao wrote:
> On Wed, Jul 15, 2026 at 06:35:06AM +0000, Nikunj A Dadhania wrote:
>> If a vCPU stays scheduled out (or blocked) while the last pCPU it ran
>> on goes through a hotplug cycle (online->offline->online), and the vCPU
>> then resumes execution on the same pCPU, then it is possible for it to
>> run with an ASID that has now been assigned to a different vCPU,
>> resulting in stale TLB translations being used.
>>
>> svm_enable_virtualization_cpu() resets asid_generation to 1 and sets
>> next_asid to max_asid + 1 on every CPU online event, including hotplug
>> cycles.  Because next_asid starts beyond the pool boundary, the first
>> call to new_asid() after an online event always wraps the pool,
>> incrementing asid_generation to 2 and assigning ASIDs starting from
>> min_asid.
>>
>> Consider two vCPUs from different VMs, vCPU-A pinned to CPU-X holding
>> asid_generation=2 and ASID=N from before the hotplug event:
>>
>>   1. CPU-X goes offline and back online: asid_generation resets to 1,
>>      next_asid = max_asid + 1.
>>
>>   2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
>>      the pool and consuming ASIDs starting from min_asid.  Eventually
>>      vCPU-B from a different VM is assigned asid_generation=2, ASID=N
>>      — the same ASID that vCPU-A held before the hotplug.
>>
>>   3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
>>      unchanged so the migration branch is skipped.  Its saved
>>      asid_generation=2 matches sd->asid_generation=2, so the generation
>>      check silently passes and vCPU-A continues running with ASID=N —
>>      the same ASID just freshly assigned to vCPU-B.
>>
>> Both vCPUs from different VMs now run on CPU-X with the same ASID,
>> causing them to share NPT TLB entries and producing stale translations.
>>
>> The collision manifests as a KVM internal error (Suberror: 1, emulation
>> failure).  The NPT page fault reports a faulting GPA far outside the
>> VM's physical memory range — a sign of stale TLB translations being
>> used.  KVM falls back to instruction emulation, which fails on
>> FPU/XSave instructions (XRSTOR, STMXCSR) that the emulator does not
>> implement.
>>
>> Fix this by incrementing asid_generation instead of resetting it to 1
>> in svm_enable_virtualization_cpu().  On module load, asid_generation
>> starts at 0 (memset) and the increment produces 1, identical to the
>> old behaviour.  On subsequent hotplug cycles the generation advances
>> beyond any value a vCPU previously observed on this CPU, so the
>> generation check in pre_svm_run() reliably forces new_asid() on every
>> vCPU after every hotplug cycle.
>>
>> Fixes: 774c47f1d78e ("[PATCH] KVM: cpu hotplug support")
>> Reported-by: Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>
>> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>  arch/x86/kvm/svm/svm.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>

Thanks for the review!

On the Cc: stable@ — if a v2 becomes necessary I will add it.
Otherwise, Sean, could you please add it when applying?

Regards,
Nikunj
