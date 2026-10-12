Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614C37206B
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803414; cv=fail; b=TGGq+SS9x4cCDIsvJqja50GQefXUe4rGolWrY/9WLjd5wCmzD4R4xx0rQNXOzHCQb0V/VsSf5hyKuBqDWJbW+xtPCH2WVyFHcNuvN4K2buwiU4Op1bp8r0pF3MZIzB3s3UDy3r6jGE2mQlVO7YvPZsrtlnprS0afgw9vfSWjGYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803414; c=relaxed/simple;
	bh=WiomK08UfiTWbQ4byKS+8BkHoL7+KAbc5JVf/s7mEj4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UubeeIsfK7QwvJMJPgrSw3Cs3baBQeHVw1n4+xRBpChOLpQrktDOEXJK451HyeXWXBAAUfVVicdoRXMpjUDNmvWs9/mUPHZ4xk8qjcjlip+3XPq85P1wHZqXSNwWbIaorvHdPnw8Svh6Ja/xAZ/RBaLw9l07g6cuhdkBaNOyJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KWbylUao; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KWbylUao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChQNj4EdGdMv1ddyGyardemD57+aWihgZPjL3Pu1z4XIjOOxwwg07E92bLzScQY+FdsFk6xv4l/6XbMbIUzabBDvWZCBUlWgw9ZG4xbTE/1aICxaT+QtDWKz+1cuCTPK/zytVT4CQgbAIkxadIaPww8dhy4yOvdGSdoaoWtm6v49Mv4aDJrkRCC5TyeH1jyTCHLlcJg7qprcWoL2YCuyLttNIAgvQMqJZzid5d91yosctoB0prRQPQLWxXjOEOMsCj1P/J/KHc4gBWLyZK7ZghvXLgLfJwWvCYinjBTdYLCu5i7sxIkJ1ZMdZ4H/hcAQ1QgyIR2IAf/VMAbe2yzR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObGmyymNZ4U6QgqTMeyWMz14ynVLZ4cDvdnmdu83gVE=;
 b=gIj2cYms8UyrGcqKpUzCqkDNuiGqyFzefkSbYzL8xcKOzx4KuwjzEmJFUBkXBTTG82eZWIkdoZFDiktSCJ+DjUg00CTUc9U+8z6QT3FSMA7z8RJQ3Pl1EmazMOq3xiD69p00tjmpwLLkj2HhUhiOgU/lc291f9/XJXcc4ek9pioqfupFsVq7IRFojD4dWcn4s0CYWOYPdz603Rma2OgahxFFiPy/N/Y5YDfaCSV69IxhBXPNd6lV0b16j00rtqbjctqARBtufZ0ugCocnmy0OyPwi6xnCDQRM2Kp5asxpe5ArMu6cXorzYJIKW3sFYSEoua31hn/DziBADwgdHDT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObGmyymNZ4U6QgqTMeyWMz14ynVLZ4cDvdnmdu83gVE=;
 b=KWbylUaoOtQcnWN5r7yGxGeXgwkdSoY6Cud0PXGNJEL/XcD022NidV0s4VRHz52uavrGuf4hiftI2MfZag2WvJ3uUCf7zxi2JbDp/L84lQCbdGBiVs85//IWu3njjnJ/OvZ32wN1u5hFLorKx3pUZnxcVz3NFOalCXb1BMImqzE=
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 11:10:10 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::1d) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 11:10:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 11:10:09 +0000
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 06:10:02 -0500
Message-ID: <8685c8b9-620a-46a5-b06c-a3eec6635c5e@amd.com>
Date: Mon, 12 Oct 2026 16:39:54 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
To: <sashiko-reviews@lists.linux.dev>
References: <20260908074739.10748-1-sarunkod@amd.com>
 <20260908074739.10748-2-sarunkod@amd.com>
 <20260908081928.2D7D21F00A3A@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <20260908081928.2D7D21F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d0f2be-b5cc-4028-e851-08df2851613d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6sB59jSYDOhn8prW1z1jx5V3uU6fa10tfworbCTuxpxaoySDyaFrCAIg6TDiFF9tq9nEXPV9RGdWNWNGX7fXt5PpWng0AxtM1GImxYJXINE3mCYoE5dTOn9cLM2qybao0AzheUogfxK8T6sszYpdoBqcg4nzpsNC+Lpr6psstIo5OiBpaCSm+qOTu6esycjNujl10zfcmFwIbmGkzsjiM+lYVUWWniVv2Hh2LK+cDSMkZdkPCyphQ2RQNeXtdCB0vLI6eIHUgXnYsBUynwRkJd0t9nujdSLsmrQNzHwSLoejLd8oazww9Wc3JtNc6jq8FOvsph8MUw4KL+WwjI6bTpEXwmk2PCEs/cP2xLB/d5yGRiwNl798e00VqKshftH2GbiCCAIYQYp19N1WvvSlI5Re4D9aH4o/R8iOS8C/bHHN0Y89FF610gDEtbV6AKMK8gUUkOK+xO1FblVd27zIs3aj+FGK/PcbbiDVxiPxaaZhM9p57sPKtVLQ2ZnK0226+XzCNolnlTt3V19eA4bnYE4mpBu/9tkDs8L5BcziL3O5jrnpf7W6/VUmhpQyOngWyUkCqAUrpkK3PXeddPC2D4oAdJlCmaq4ArfVzR1NivK0OD6voLrba1kw2f8ChHwidINDnQwsinC1RR1aXPa7VaokWi9F8tSuzdY4HRpIS+Bnnwe9YNzx01vfPsl6Zih1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vJMkAWro3e+jmfk5s7AWIs9f99eBuz53VcwZq/17O4bfNncSb3WMwe7U2hyMn5OcZepkPklnWmz/hkpriiGOhK/Bl+iNPSS0HAO46/1fFdgHp1MxLM0ZnMjujTC/YMIYilLbGkYOiIuvn3oIcf9KXfEzkcen3fo7du8Y4Eqiw4jFV1US2bSZpKqZJtlIUIDtjvYXDEdWPpDf3mCFmoH1CgYtiRAChwZz0Map0Tg6Wo1THNnfX7rEVHo54OjyMmJxzMGp6d9tWs1cd7HnZx6hZItGuVnyo2v8CTc1gkAx+VqcQX08jt+EykkL0mTItfT/x1b7I+yxNvfJZccDSbzax7DYbEu3vQ943i+EYWIguBnXN3p0SW7gXgv7DFhgwMC8DuOkWPdnTwCAGFsp2+qtRxJ+GHO3h8UxCr7cn2Rhi6AkgX+PglGnNbDL52ln8k9z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 11:10:09.8125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d0f2be-b5cc-4028-e851-08df2851613d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335



On 9/8/2026 1:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] When the host CPU lacks CX16 support, the 16-byte fallback returns a mismatch without updating the old value pointer, violating the cmpxchg API contract and causing infinite retry loops.
> --
> 
> commit 5f4dae7c1efaa8622accc402392f8d8a532481b4
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
> 
> This commit extends the user CMPXCHG helpers to support 16-byte operands
> on x86-64 using cmpxchg16b. KVM uses this to atomically emulate guest
> cmpxchg16b on guest RAM mapped via userspace addresses.
> 
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
> [ ... ]
>> @@ -580,6 +634,14 @@ extern void __try_cmpxchg_user_wrong_size(void);
>>  	case 8:	__ret = __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_oldp),\
>>  						 (_nval), _label);		\
>>  		break;								\
>> +	case 16:								\
>> +		if (boot_cpu_has(X86_FEATURE_CX16))				\
>> +			__ret = __try_cmpxchg128_user_asm(			\
>> +					(__force u128 *)(_ptr),			\
>> +					(_oldp), (_nval), _label);		\
>> +		else								\
>> +			__ret = 0;						\
> 
> [Severity: High]
> Does setting __ret to 0 here on hardware without CX16 support violate the
> cmpxchg API contract?
> 
> When boot_cpu_has(X86_FEATURE_CX16) is false, it returns 0 (mismatch) but
> fails to fetch the actual memory value and write it into _oldp.
> 
> If a guest executes cmpxchg16b on an MMIO address (forcing KVM emulation),
> KVM's emulator decodes it and invokes unsafe_try_cmpxchg_user. Because
> it returns 0 without updating the pointer, x86_emulate_insn skips
> writeback_registers() and returns EMULATION_OK. 
> 
> The guest registers remain unchanged while EFLAGS shows failure (ZF=0).
> 
> Can this cause a denial of service where the guest endlessly retries the
> instruction with the same stale registers?
> 
> Should this instead use goto _label; to cleanly abort the unsupported
> operation, which would cause KVM to properly abort the emulation?
> 

The caller __try_cmpxchg_user() flips the return value, so 0 means
failure from unsafe_try_cmpxchg_user(). Hence writeback_registers() will
fail with X86EMUL_CMPXCHG_FAILED which will halt the guest.

Thanks
Sairaj

>> +		break;								\
>>  	default: __try_cmpxchg_user_wrong_size();				\
>>  	}									\
>>  	__ret;						})
> 

