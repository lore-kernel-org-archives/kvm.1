Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDD3F39D8
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379559; cv=fail; b=OScx1D5YwYoMR5p9pWmQbvztqwNhS93lXTj93OyLn5mxd+dAiKo7K7LgXPd4NEGm+jO5C8N/Gdy6O7qhIbjTUW5r2krWzExO/YfunPgEd8jiUmIgJOEZ3GH/10GWatJ7/Q92GvZQoyu95mK8T1qEun9/oq8SWhplzB0Pg2VenMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379559; c=relaxed/simple;
	bh=2AvU1nromrjo+EzODDOCd/c1YLwKCJUCwdLW56JaSfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n2zVuJ+QhMb1jnUaf7i1SlZNzYh6+qkBcanyf0udkvMRNcGHgeRaBiIlXY5vyfdiBJzSmbzhD01q2jHU9S8YWyozRXkGUAfc9k9binTaFOzTgvn9agiZKxD/t99kS4ruzY8o0EOV2ImAlpTYp8xkjhBe8Ho7ulZ96dHZ7yDfs4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9Hg4fKV; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9Hg4fKV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlNb3TTgxqt8lH+bEJjd8zQDxQ5p1aepWzl1clR1ekNHS4PKzTBzs/T0DXMUEtu1FVwzu3pdMdYyslwLGf74QGCnE3aVNyeaNuODLTQpWirLJ3s1ihLjH7fmJezUZXtcnqgxLVP2ovkBxjcGDWlx5KdJ7+cY4v9h0GMjVWdIq7iOPmCOTnQRZGrXki3t3MaVbCcSR+jaI3GCE2wJGqAPtYMcgGMjAsvM7m/VPde/ka7mltxeHKlKHGqt3shcI1BEZSqS6u4xt5G2ZqUvzIdD/cFB/TDDbKElWwWmKR/FNgCS2czBs0tEzGfVhJFJopxRlAZYOnU3JkkoB3RqIor/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IJ/AcJF0PWBzN8rvkhrePL/VHSHp/nX6WvxCxCDvls=;
 b=y/7jNcw1XtoSZ3UVNImkvl+rFWJMUkZD1UWwyVSiow4BLkizoMRnkVT0EN5MMWMEvHoxFQyxXGkyUmh6v1t0anFw3pAIVfDfbTQ+nZa2KJwTWsEDP4JtGhstRpKq6vhOA0Qd3cU9HGy874wayvzAhvoKw6ODaYyzvmmXkRTWjUPNdA9rRxFcEooUEtQquFedY0D7QOc09TsCjLgFH6fUcPU6h7L36RZ9IJg7bTnerhMdokTYZjgFCUCbDjxEsAGemXVJZfzfLwko9oyTXbsG7OfdgWbH/20RumoTUFXe3fvhn1CT0i8SIz66JSKpXQto6sQzquj6eANgCLE24emKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IJ/AcJF0PWBzN8rvkhrePL/VHSHp/nX6WvxCxCDvls=;
 b=a9Hg4fKV+3uTJBPzDBOjss9wxPd3erkuzRrJziPtdEVHJzSUnSSr9HFFM5MzzgvVbPM7mqK0aFkhQm2QkTWwaxJBdTJ9YqCp5MWE89V6lEkn9LwVGTOB7dOJ+GdwKz/DC8ilWkM59aGg4/sGUsetgWon8i/WDM5tea7tCOcIyUI=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 03:12:29 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::35) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 03:12:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 03:12:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 22:12:21 -0500
Received: from [10.85.36.197] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 22:12:20 -0500
Message-ID: <2669477e-20ef-430c-9224-cfcb4ca42acc@amd.com>
Date: Mon, 19 Oct 2026 08:42:19 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] KVM: selftests: nVMX: Add nested PML coverage to
 nested_dirty_log_test
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-5-nikunj@amd.com> <sashiko-outbox-172712@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <sashiko-outbox-172712@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: d39d5e77-a856-4e3b-4ea8-08df2d8ecf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|13003099007|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OsxuGnBfyG/7VLUiZ0h0DMnNOd13SFPQHd9jfwU/pYSD3aQbIa3jhq7aYNFC6f4J0t3whBMkOGH3Cl5n4NuFuQ9BiYCODvxjTi24dX7mZVAA8ie7UiwNIjV7LDz4ISSrshsMapeD7HATIARoHJH5qALhpnOjnI6LX423Q4BufnnhEO7r9Hj7+pcQbxQlTNlua6KpuwmnrLGZbltwCo6i3VKryW/JY5M5gtF+i1Z000yFXcFTbz4V8gdfVP1le0rAAjuCTzWlAlwnceBrsPFnt9ag3N+caU2WUs5BaPMQrCQh8c7cOXQYi07pmb2iybaRyxo2UKxysmRijw00hjx+Zi0r/wOyhwoTlg/N1EjWFVVX6RhbZW3eJyf3TXk2Ocs8EAs1gHJ53AhS2antSHMSxf/Hb10CW2AHfmx9PGq7OhmCzXGEJOzECRbvsDuN7WEduKXTDS/LXiY+SpUGRt+1ovZ25AkgfW/aAeYaVejWXlT2G2FAEY9WaRca2nRCgImuRzhXpcdnDs55PYj5c6EKmGtYlv+zOCQinMKIRxNqD3M9W+s2VYN3lj+Yp7eNThI9XlW4oQBxuTR2yYrcm5gVwqVC6MsbFAI/VmU6UjaVJWFYP1xc4zyI28VjujdnG+nonz/6U4XEmZIbBEmx21TM/oRtT4hecp9iuqnMJq62WV4DZK2cK/Yt3EX5mqlhQHNf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hM86HJbNUDMYPyOpIAV3glTA7+s6NwVJeGPGPBsQRaF6hnnMKDFmViTF+MjEHV6bDN9h168kf0UTGV7A9/Kz6fW6uObsWdply+8MyB08Vnk4BzGNQrvOi/+GcrEC6v2gOCBA2M+KzN6GCFsRpa2tRW5LJAgWFAC7HxpS5B+EeuweNLRhBLqJeczGDrJn1c83f7sdAbLPa+fd3X/Ajqe6+Dr8t1+UQDJoqyesZmkox5xuRS+9fEYNllDb1UVs5fYj5wab7/RdFnUMxRriJUjUQvFUbq00dqs5ccIRwrx+wDyAzMOlN5dUSoga/EWYCo1wzEhdhLzWbF+Bsb0wHa13ydlc+0u4ka7iU8NB1gnod66O5j3YsyHgsn4H516gxam32b1Pi61ZQYZG9vQh7YUcWNzqxuJj5q2NLB3coYpBvql320vld6RcTg9HgjiSIIgF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:12:29.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d5e77-a856-4e3b-4ea8-08df2d8ecf2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085



On 10/15/2026 4:34 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests: kvm: nVMX test asserts on invalid guest PML index
> --
> 
> commit 88c8168ec493a327cfe182178b11f281733406e7
> Author: Nikunj A Dadhania <nikunj@amd.com>
> 
> KVM: selftests: nVMX: Add nested PML coverage to nested_dirty_log_test
> 
> This patch adds coverage for nested PML to nested_dirty_log_test. It
> verifies that L1 takes a PML_FULL exit when the buffer fills, can drain it,
> and can resume L2 without losing entries.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
>> index 7e5f9ae1cb00a..b1008724f46dc 100644
>> --- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
> 
> [ ... ]
> 
>> @@ -192,6 +192,149 @@ static void test_handle_ucall_sync(struct kvm_vm *vm, u64 arg,
>>       }
>>  }
>>
>> +#define PML_LOG_NR_ENTRIES   512
>> +#define PML_HEAD_INDEX               (PML_LOG_NR_ENTRIES - 1)
>> +
>> +#define PML_FULL_MAX_EXITS   64
> 
> [ ... ]
> 
>> +static void l1_pml_vmx_code(struct vmx_pages *vmx)
>> +{
>> +     int nr_pml_full = 0;
>> +
>> +     GUEST_ASSERT(vmx->vmcs_gpa);
>> +     prepare_for_vmx_operation(vmx);
>> +     load_vmcs(vmx);
>> +
>> +     /* PML requires EPT. */
>> +     GUEST_ASSERT(vmx->eptp_gpa);
>> +
>> +     prepare_vmcs(vmx, l2_pml_guest_code);
>> +
>> +     vmwrite(PML_ADDRESS, vmx->pml_gpa);
>> +     vmwrite(GUEST_PML_INDEX, PML_LOG_NR_ENTRIES);
>> +     vmwrite(SECONDARY_VM_EXEC_CONTROL,
>> +             vmread(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_ENABLE_PML);
>> +
>> +     vmlaunch();
>> +
>> +     for (;;) {
>> +             u64 reason = vmread(VM_EXIT_REASON);
>> +
>> +             if (reason == EXIT_REASON_VMCALL)
>> +                     break;
>> +
>> +             GUEST_ASSERT_EQ(reason, EXIT_REASON_PML_FULL);
> 
> [Severity: Medium]
> Since the test intentionally sets GUEST_PML_INDEX to 512, shouldn't this
> result in a VM-entry failure instead of a successful entry followed by a
> PML_FULL exit?

It does not, and the test works as intended on both vendors.  KVM does not
check guest_pml_index at VM-entry; it is only consumed in
nested_vmx_write_pml_buffer().

The seed is deliberate: on AMD the APM defines an index outside the valid
range as the trigger for a PML Full exit, and the test uses the same setup
for both vendors to get one deterministic PML_FULL.

Regards,
Nikunj
