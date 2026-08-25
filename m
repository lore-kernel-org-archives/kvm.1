Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D993DF000
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647220; cv=fail; b=E6MvBwTdRJbIrhJgp2h37uaJlfMBqOYBznX/HkZz5sDksFFK/98mECCQlwdDbW+SGoUXbk5xZeBFzHoAoTclPd+XbxEdoW05ZlHyHql0idkvnHUDKa6TV/Ugxzp0s3cRhhz614nToTxOsmIZKwqljvvSY1fAUHFMqTKU+hR0jao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647220; c=relaxed/simple;
	bh=GmXjqDoPTBgdbfPicOYMHRHM8DC3jLsMGME47VcoHks=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mGRQFkB8JTrYofoT9dDXGIzSpW0mailceEBEJCOvyMTHqR986Y1buqSB3QT6ir+77RrP6tLrVaiWZ7SPzWrg2euAUKdFC4xLyMK9a03ucAWS4q7vcHlpavBM09RChXKmKWBWsmbrz/M1vnfaU96TxFPRwMxJsy57kPWRzdd41h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KTrYcgG7; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KTrYcgG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP1Cs5TI9NpxbPh9W+ILik0Mv2TeWtqTRybFpTPZIcjc1r+0MQCQC8L17ysDSQ+2ymANcg3IbOn/uPQ0EyRbmd4BKDQAEo1CZb6ibTcRa3Cm6qJxShjlGQ+16WE913Zkp6GK2CjXs9CwOzoLbvDvS88PbMSMb/MjUc0DcrzX/v/NAzgvVTv9PkUvY8GwTfOn4Z6hBhohx8p3/spf2UJYk2QiPhueGuoeDyduqbfXM97N37VQsQ45/GOpJHtak7gORFAi5UEQE8HjzCnGhdbvKBOtQyMYTzCZTa/uIm+MjqO76a8+hpOQpnN5e3BSeTZVSt9jfzj2LedVxWdH9NF0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxbTZ0R9PtZ8P942pgh6heQAGMxEIZbQQn9JJKO6FBk=;
 b=rmfuoR9wdIM04n9sHEP+OEcA7AWBT/yvr7Y7nodAeaDvnqT5ZTUV3pdFTbKU7xgB8ODwE95BmqmXi/8tchuHLUKauXoW7M1Or6wu1WbT5+pGl2yz5CVh6H1CLde1n+nWhUUuYG/QXi9SWwQJawy5tWrIl5aVO5Ewudzdlrk6sfeIZqJuJngv+H3rT9qoSaPJpkvNjstH+C84gKjIZqs22XZ30k8e1yDYLfwnO2M9kYJXrHgdnUYxGm/urAeI0W8uyiJYeItv1mQTOy+PM0zPRvMhOjO5GDeMb21wY8/+OM+Q3/XUHU6uBlnTzr15UfVz3KgMFHJxmSO90xhRhX2jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxbTZ0R9PtZ8P942pgh6heQAGMxEIZbQQn9JJKO6FBk=;
 b=KTrYcgG76C7EGh9Y91kBJfsTKCXRn+54m+3hx5Nxms/0GZ8n06xEBn1oBMMWtB99MqsuLiTwE6vhnr+kB+N6T/+rOR2TFqV8r/xCVjJxLIPO7ROq10vZ8MIPMZf6sgvU6c6gC76+ElAjpxS/PK7jxqgeVVx0ZoH4Gfwpx7SA2iY=
Received: from PH8PR05CA0024.namprd05.prod.outlook.com (2603:10b6:510:2cc::12)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:40:15 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::1d) by PH8PR05CA0024.outlook.office365.com
 (2603:10b6:510:2cc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 08:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 08:40:14 +0000
Received: from [10.85.33.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 03:40:13 -0500
Message-ID: <327c7769-8ef6-40c3-869a-93c29ec9fa9f@amd.com>
Date: Tue, 25 Aug 2026 14:10:10 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <sashiko-reviews@lists.linux.dev>,
	<kvm@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260706063035.1139-1-sarunkod@amd.com>
 <20260706063035.1139-2-sarunkod@amd.com>
 <20260706065212.CCD741F000E9@smtp.kernel.org>
 <84113ba5-ddb8-47aa-abe0-c6968feb3fea@amd.com> <anpsjpCQHjJCH7TU@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <anpsjpCQHjJCH7TU@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: b18c58e3-cfa0-4c2b-f0b7-08df02847c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|3023799007|22082099003|11063799006|4143699003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	W20uM9au7iSFRsxlv4QNk6VXO0HBHRZtDPQhDJc91vOKMgQfkO/ucSRV3PWfXQAtfd9JjW6mat9WxJPLU2nq4hJNtGerksLogAfTFLWI5357YLiKchPqrdZp0fjE+7G5CfiZJC+yHQ8WVQAZJcHZdN1gphIIe34Zvo0wLbD2e0w6gpdgIohlSrOQ88M/Mn6RJLgfZlnNBVv4rBrnUamZCK5Wv/DLzBXvDH9AIpJ+rsiu9DXYgXYamsmKLRqBRG5BzgzXMgk+HZwaY02XmdhJocRtMJ/DJKbvF/jRjp+Lhevt+Al3DThH1HIMluV76xypCDqa8ImdGQ0ooOIQ+SeiD/ZEWRT47kAKTZSIXgexlfPoRRMZFWzrox5C0wrwXWK7m7NIzF7SyH+j2Jz7pgvhV9ItVrQfZgnGMB66eOqQB2ggKFnSvJmSC1hZ+ospVcf5ZCFNbPSUGsLoy50aQyj22dyxKIQrfTIcd5CJmsrHznHI8icYbex6eGOwghTZU7xFw6sxOc18gPZ5bvoiUgVYAmO/ypNEuzF60Zbb4zPIx6jiYcx6t26iyhVYheQSWveHmQnTwlZYNsP1XCSE201WIu1+tnixMJjJ9hl6MNwCpD7kLmXq1uLFTmEE6aPllwQjV3ZjrkXT7PcTNANmhkZ3aA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(22082099003)(11063799006)(4143699003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ZwRxFa7oZVgn+k6yZXZNuLzwElx0ngVDVf+nkT1iaU8sb3DZ5q8iRe5ODbDYbyLj6luNrP2Czvl4nO8FVcYIkywiTuyXRL6qbn4ZGJsIz6Kh/3/eP4iZqh1EkowVxaZkAtsfVMD+1kqwBqBf/XUGFhbWn6wZC3YnNxi8iqeagAWltTF3eMrBIxPgEw+oCMP7LNmFTf1YVFr3SuyuuO8RhwgfHw+yfGz9m1YbURWm4sXgi3z993RElTUSVmSXDhLo825i2S93aQv684bKX3qUUiMDiX28qKFiuE5decDJapsrOucyAOK+fBu6xuuUVTqHAwI+vNySbm6vkzEuIlf8X9YDD9up2Jm3pNL1eBWnJvKXaooImAk5/KmmpTzfhQBj7yWSf9EHZ9ce3yp7lcCXHY2OiJ1CplL4KEjTWUg9vE733xXboYYRt6RNJ7Fuzlz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:40:14.9481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c58e3-cfa0-4c2b-f0b7-08df02847c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415



On 8/11/2026 5:57 AM, Sean Christopherson wrote:
> On Mon, Jul 06, 2026, Sairaj Kodilkar wrote:
>> On 7/6/2026 12:22 PM, sashiko-bot@kernel.org wrote:
>>>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>>>> index 367297b188c39..123755d471099 100644
>>>> --- a/arch/x86/include/asm/uaccess.h
>>>> +++ b/arch/x86/include/asm/uaccess.h
>>> [ ... ]
>>>
>>>> @@ -551,11 +594,18 @@ do {                                                                            \
>>>>
>>>>   extern void __try_cmpxchg_user_wrong_size(void);
>>>>
>>>> -#ifndef CONFIG_X86_32
>>>> +#ifdef CONFIG_X86_32
>>>> +/* Always fail on 32 bit arch as it do not support 128 cmpxchg (i.e. cmpxchg16b
>>>> + * instruction).
>>>> + */
>>>> +#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label) (1)
>>> [Severity: Medium]
>>> Does this 32-bit stub correctly signal failure?
>>>
>>> Since this macro evaluates to 1, won't the surrounding unsafe_try_cmpxchg_user
>>> macro treat this as success (true) rather than failure (false)?
>>>
>>> This could cause the wrapper to negate the value and return 0 (success) to the
>>> caller, falsely signaling a successful memory exchange without actually
>>> updating memory or the old value. Even though there are no current 32-bit
>>> callers using a 16-byte operand, should this evaluate to 0 instead of 1 to
>>> ensure theoretical future callers don't encounter a silent atomicity break?
>>>
>>> --
>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260706063035.1139-1-sarunkod@amd.com?part=1
>> Hi,
>>
>> Right, It should return 0 instead of 1, will rectify this in the next patch.
> 
> Is it possible to fail the build instead?  Attempting to generate CMPXCHG16B on
> 32-bit should straigt up fail.

Hi Sean,

A compile-time failure in __try_cmpxchg128_user_asm would unfortunately
break i386 builds even for callers that never use a 16-byte operand.

unsafe_try_cmpxchg_user dispatches on sizeof(*(_ptr)) via a switch, and
the 128-bit path is one of those cases. As noted in the comment above
the macro, Clang/LLVM tends to compile all switch arms when expanding
this macro, and only discards unused paths afterward.

One way to solve this is to create two different macros of
unsafe_try_cmpxchg_user for 32 and 64 bit, right now I am in favour of
returning failure. Let me know what do you think about it.

Thanks
Sairaj
