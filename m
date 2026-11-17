Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794901630;
	b=tAFopFjN59S5s18jeOhqDAkb+zGlwHJZXf5+CSxgWPGp4Gb04zeJWQLRMExgJ8M3wWGe
	 HaZHNJ8yoCsd8WJnRbzU0LtOf23k2QQQj6UuR4qx7G1T/fSp8aDZjY2rsVgrP6sagQ/2N
	 sNFypQJEwhqP+rL7OpSzc//9ZNI6Wxzm/Tf4V7ZskRFOdoJeIxkXm/VukZRxeHgYZ+yME
	 JTHbTmDFnXcLA444GQGx5ZR5GADqOC3ZkqkLBW9Rd5XGtxE8/KnuW/AsELXRj5xVXo4KS
	 iyI/IZWR0ZWS0sNTYwAX69zfwTLBGolhwCl0+WnBfYwudRacVzcdX2K4++ruWDwyDug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901630;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=c/sO5xp6XQ6ObYktzOOKQJFwNx7/Y9YcCidaCWOFrqo=;
	b=DH09cCGobGSbzH+gO0g4jhAGEJ1fBAlue0+V4YI/DZnVpuS4TOik9zWXI2Xi3/31WiBQ
	 y9ymDbxHcHSqoBY3ToVhsRI0n1RV3HGkttPgMYkNyHUtiFRRl32wFJHASV1AYVtj+8yZr
	 9tzN+pIPdUt6gZNoyRzz73FSrpAq6VIeOYuDt8UhoguC70zWJaqEAo1C3GKBJhpdoK6+D
	 x5w5x3L3LeCeJYjOUhItVmGMRcDu/4yeB+dPWuTQ//eAA51I+dGfS4Yq94YjhciWWp+XR
	 owRL/wyGNcjbaEA2aUyHhtA+bCBSvNuzLX2YFO65KyQfzSSBrYxqIhYdvrOe7NnQuBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wyslcYjn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.65
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C017606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 07:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C017606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wyslcYjn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6MBaZyPfizHoCb60gCzLaU+FnpnTmRpfASoHXYqN0HFwDdRgjmpPjcEiJ5/tAM+To1pz3SXytXwXC1uRcEPhkjIbiXFLEUQnWu88RhACNcC15AiYdL4D3f4caooMlnT4GmxtpU+QOabX06pL/+CltfrH9xi+8876yB8usIVdAs20ohKG9c6PP30axGI3S8zJqsBBP9eKK1kosm7JGbETLquEPBSgvBS1chXaNJa5fD99wuFKy3EHUiL311cXnw0pKk8PcE1EWmsJJiT3WrJD4bQlRCapvHrcD4SWFERK/3LFlOdfQKDwmGSKZ2BZeH4pCh19RmQnCq5CPwOWtTybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/sO5xp6XQ6ObYktzOOKQJFwNx7/Y9YcCidaCWOFrqo=;
 b=jfDFS5CCyComVWbDTP3OgkrsN2RUmhEuxU9MsvS8LWSRBhHvcz9zauRlCOJRN8Qy+32WzUmutxe7gGXTN2BUhaVxcIV2sg04qPAaCNU1UfrRMqEG5d9ZkvQwTxqFHWYaSWRvc1ZduM8XI57mwbqrpaYvqBW/FbTsPuP9nW8lK+z6ADnB9mp7KNH1xh9TMCrFouyDdHmocI0nTsOhsfWChDG+grE+O2idYNGMzXJeIpC7ZKPt70CDtAvykN/1b4L9TO+VHqjj3K8ydwBUiSrxDjfuhg5udAjZ3908dNkeqN1kTN2ppSDRoyG2D1BuxaIp0Y4sIauk5pdV3o7CVk0WpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/sO5xp6XQ6ObYktzOOKQJFwNx7/Y9YcCidaCWOFrqo=;
 b=wyslcYjnpFa9kKaQHTDER/BdgjyCyJ1ftBwH1LbxU3vs1FbbiPiXPwGW4RVpqS5UAS15gacKzGTqAwEUES9MzSwAUHf1Cz5Mso3dmXwW6ydPEJKoIE2fJ9mvxxQ6DSZD6iWVmxiER9sXB3bX50eDjzPSW+TEvnPPseRNRZUBTQc=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 07:47:03 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::a5) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 07:47:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:47:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:46:57 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 01:46:54 -0600
Message-ID: <dc198cf8-beab-4db7-8ec5-0bb9c0bfa210@amd.com>
Date: Tue, 17 Nov 2026 13:16:47 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] KVM: SVM: Add VMCB fields for LBR v2 virtualization
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
 <20260724195040.630468-2-shivansh.dhiman@amd.com>
 <20260724200819.9D22F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260724200819.9D22F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 47852c57-05ae-409e-d7a3-08df447ef7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|4143699003|56012099006|11063799006|10067099003|260925021311599003|260925022911599003|260925021911599003|22082099003|18002099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	W0/Rg3T+byGEWs5XN0lt3fXrhNK2/qkJcseMzSppjzxfkZ1czHZb3NAszpVGWpcBgdX6LxFNN0Ux13em2hwB88Mk8sPq47YBro8Fnlt0HZQ3TmEeWmgKtkEV6WC1YmVPPNJH11pyBRuQAHymMnXIRRmr9uMMz6DWCv7gP0HFyD5i7ttnjzP24GrkP5c80ICT/u6VUrvF4mSPSRhAVNEBkexh1bibwSGm9aaniU9IwxN+LKbEbVr88mH6q1GIJe9GidVFQrxRQO45gBMjnleTO1ULoxizTsD1ZG5BNvMGO7S0Mb292VclL87Tq8qq2MwUph6jnri7bDRWct54DVGByDxTy9uPyzBRhNR+s2pAifhnbCy5Ukkjq0UEJoM3M/kQ0GqkophrN0sG2K0x4fIW59xKDM7FTnqWkBTkzRG+xZLcGhE9L5fUCibkQgIJk0/ErwZJaYD6SSaIgj3xM1lYFKzAGqUeMThJLCFbI5vvuQ7cRbRmjboWUVHya1F+lveUYt8cgUaO7fWcxGoN5s9jfIdL9QpO9t3ZZVCdbxDBFo94TulBICCP4k8lpX4MRbANV4Rl3Lk+uR03NnB+6JkCX07eEmktdWJNFirCSeQJceekzIBcMjlOF3f7eLBl8uIpWHfrBa1U4wy+/fnFaq6z23FiXlHqElkQl2TdQI658UU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(22082099003)(18002099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eG875nZQq/9co4icDW+MOWcqquDmTaEuNVRwymvI8vJs+KBM9lsVK9I4jnSTwAWmrVLsariNI1z8nqFRn3L+ukKvFskdwPzU3V2KXw+ZnQdfkdlWhQy1j/Uq00ccyY9tUyZ+I4QhUSwD41TfMObX9wN828k4cVY1JKee3o389Csa0mJBDH9tmU9UzYoY4WfEafy5zC/1Q7yh0iL0rjQoRkiM5iH1NWOSrJwweEHa2D9X2J4ZoEa3z0c4gSwRTMa+xHjVqyemHE6lfhIoV4NNxVWs6fkSEXogt5t9rK73btLCMswlIuk8z3CVbYaErvFSZocAOAZB/por0PS8hXkCGWgObMvr/sFfqU84VGqEijEVcNwPFgIpoPHHMTadD3+vtgqULZ/cNg3j5Cc0ZsdZTXSS/a2zZma9eYolUhpQxpVGSYLoa78+ANQZPhaGmPB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:47:02.0928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47852c57-05ae-409e-d7a3-08df447ef7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790



On 25-07-26 01:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `svm_get_nested_state` function writes out-of-bounds to userspace memory if `user_data_size` is exactly `sizeof(struct kvm_nested_state)`.
> --
> 
> --- Patch [1]: [PATCH 1/7] KVM: SVM: Add VMCB fields for LBR v2 virtualization ---
> commit 91df21ca3dd4f3f8277b9ddd8eb84059e0bca6d1
> Author: Sandipan Das <sandipan.das@amd.com>
> 
> KVM: SVM: Add VMCB fields for LBR v2 virtualization
> 
> Define the new VMCB fields that will be used to save and restore the
> state of the Last Branch Record Extension Version 2 (LbrExtV2) related
> MSRs.
> 
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index aa63431ba92c3..fbcf6c4dbb92a 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -552,7 +559,7 @@ struct vmcb {
>>  	};
>>  } __packed;
>>  
>> -#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
>> +#define EXPECTED_VMCB_SAVE_AREA_SIZE		1912
>>  #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
>>  #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but can svm_get_nested_state() write
> out-of-bounds to userspace memory if user_data_size is exactly
> sizeof(struct kvm_nested_state)?
> 
> When user_data_size == kvm_state.size, this initial check evaluates to false:
> 
> arch/x86/kvm/svm/nested.c:svm_get_nested_state() {
>     ...
> 	if (user_data_size < kvm_state.size)
> 		goto out;
>     ...
> }
> 
> The function then proceeds, expanding kvm_state.size, but never re-checks if
> the user-provided buffer is large enough before clearing the memory:
> 
> arch/x86/kvm/svm/nested.c:svm_get_nested_state() {
>     ...
> 	if (clear_user(user_vmcb, KVM_STATE_NESTED_SVM_VMCB_SIZE))
> 		return -EFAULT;
>     ...
> }
> 
> Can this corrupt the VMM's memory by writing 4096 bytes past the end of the
> user's 120-byte allocation if a VMM dynamically probes the required size?
> 

This is a reply to v1 patchset. This bug is being fixed by the following patch.

https://lore.kernel.org/all/75b8ccd5e278ce8f13bedeceb196f5b4ee9c5256.1794545500.git.priyankamani2100@gmail.com/

-Shivansh

