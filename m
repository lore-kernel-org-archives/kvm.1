Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF0246784
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151842; cv=fail; b=R/q9plwnlOWiESWjjrGQmMoNBaJk9qQW6XDg65vvm5dcZRF6/bYun/raNqwJcDVieotkxS9pHNiLzvcdyL6hsk+b8wtewonKbNwSZoGknQRSQ1IcbaMlIph0xEGHfZOVz01ket8FjN/cZa+1vvmqLx+ItWFtIXhuZIZh9p1Lg0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151842; c=relaxed/simple;
	bh=HWqyc9BJM3oy9Po0otwZLCKxfOMqkuUDq7yL8Gw3q18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jxPNDXrEkuHwWQ3+3KeEcmA4GVVjBJabeh2ZiIUygzilNEkfAF/wXEPZNFW66t5S1fRmGjdlinbw1fNfIVdNhTTdTV/DVNNkLMit4PvCTD6UaFP+VmiLyXenoKugfKbwi8o0NmuqgzvOiQXhXQsUjafGCRETM7f1YkGgveKRd+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EDSlNdAz; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EDSlNdAz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7uqgmxMTL1gOtbcWyK0Guq4E0D0jlcpZlIdZO+bFzm5T5lDlFzOhyydbkAjV7w7niLzkT6cQDjILvW6xpxpSsxzYg34AmkaISHVWzPG+xoirktiGAthPfJ7JpG7qOuu2tRnukAlauA7aDE2P2xWgge6iyEY4XG/ak5f53nhVbn+FALBD+Suinh4ZlocMgq1RpGISSOAst8Z6+KhEY3G/is5c49GfyVdaCt1sq0sx5+LGzRBeUQGHcmiPMfOn5Eav+moV5sAeGONXoiRKdAaVWW3aqtarUfHUNf4+VKTBmbLJ8H64PW0ih3Jxt/F/bzbGNqMSt9qqf0IrOxZgpmRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIZGPkG4RXcRJ2+h93iVccUMGXaKflqw2HzjYtj/agg=;
 b=vqmDgYClF9kXczHMaHtPRXfvNm2lc+RHsfKi50bRzGHOjDTuK2b+sT8l4kr3NwwLtjRvHpz7qcwNlPuw//qyTKujLGrtZLtPYecOKnsGUgA3AH6HCrZ6C2WwEDnImiI5JdCVaV6h1CW7PsejI4wZ8LjAV2f8fyB+b1qEVES74CyS0aW6B7hYCKVMa3DHRO12aJdfXX9vY7J5xnr48em5R/EQqu0hHU//8Tt+Tifn+QdaZvHpdCl6N/tKdvu1rn3Rw30KYmC8feB7vCG5+UT/2mhZIxqdl3lQghjW2YkXl42IXGMqBm9tCvxZRPqTzwl0lHp3VnqEQfE8MwALGjFrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIZGPkG4RXcRJ2+h93iVccUMGXaKflqw2HzjYtj/agg=;
 b=EDSlNdAzrsM8GS3YDygfJl7YY+w1/8f4w7UX13km8TXRBZ5r4AEiCSnHdlhssgHarTWVde7+DwfMcYMaRJ8RYiBEB9Xbrn0+UCBkzTpFk1HRXTppFnMo1UnVSVL5wkI63gRyKU5Bd9uzNRx5C8RWSN1SlD9mRCaLP1a7F5SleAA=
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 11:57:18 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::85) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 11:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 11:57:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 06:57:11 -0500
Received: from [192.168.0.102] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 06:57:08 -0500
Message-ID: <6fb08d0f-11a1-43af-9fb5-3c556b1ae351@amd.com>
Date: Fri, 16 Oct 2026 17:27:07 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] KVM: nSVM: Add nested PML emulation
To: Yosry Ahmed <yosry@kernel.org>
CC: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-3-nikunj@amd.com>
 <CAO9r8zPCetZ0S-Ve193gKKX3_TmHFeTEzuNvB-6qwie22a3n8Q@mail.gmail.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAO9r8zPCetZ0S-Ve193gKKX3_TmHFeTEzuNvB-6qwie22a3n8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b2609d-035b-4b52-ac2f-08df2b7ca08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	783kRqXiGyfhPlSgA/8pt6oAbNqBhH8+wme6YnUgnoRHgzm+KIzxrphtPuMDAP0NBiqYt+F8zfkWp9fyk17OtCqrCtSuZppN1/1Ucc5B794XTRlG+Kmzb1DP78ViJK6GsUUjJeNs25vgvwqbMjzvG7z044srAa8rQMUgMx/dVELGLtc4cx3esP8VQKwgOyLJySmBkbX6klYhmltBwj2aIRn+6pZb+Uzfd3nbWttmrrKUWFzAbHGgT6kxrGhZdzPVYk/Pi30T4dY3x5S9Ddi75tCHum5fa/I12aB63ACFht3Pek2Ik+guZhXlhgm97zBg7f3l5Mrmzg59xwgQ9VtaLPD72NLj1iJIY7m5XdC4ynOzvm4IjqvnLPHqP0tfyrHeF0MyJEHtEtPZ0Be+YbEWoBBNDQcNmgCwyHrU48cGWziriGJzEEK4PmspYgqdXmY4rl0ivO8hAW8BM+qOXNmlL6W/vp1RUUTep6vtf/9Z2fkqnjx8sDKROzB/EesgjnsbDuaSDFq+2UaVxK+554VpAK/khVfpNJeGzSDvjc/HPmtnTa6jvsQPje5n4zywUY9MozMjJdbJytXcOKQZro3Hi8dCTqROKwejaC8HtkLvI8H+6b4Lu2wU4AX6C09TVfSDy78gAZkDdq5+8Mq9nNx8wNSGYIOXrw/g8cxrejHWsadc+T6cvKMIqStkSi+uta28pvAeOSGG9FJ2MX/JGYJLGQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TdbafiV9oJCJRYIL953l4DgHy4xbQl0oYWveuxmkw3OTVkKgXj477ta/1RUH3/BOVJI5q+eRZzir18bhDPIAL33MnuFyKTQD/ybywo5Msch2mCGOwhmU37Qp9FYeDiVl5hGGKUR7iCxIJZZl8IcuatjiJt/6X2dSymsu8tPAB1y4rJHBIOEKurIm1SqjCuYBEpogIxTXSQAx1e9bLBKCZ7QYFuJou76QV8OdKyNdGWDwdp1UdF2kiRNmpIG9w82XKpqmdLqSIL7DTzU07FxvqlwpMEtRfR91v6oN/svxxWF6X33yDLouWn6dxJt7T5fNcuy1MHLhHKV636cBCmgpv9ASGyRpMoO0M+jz/4HxjrfGeqQY2e7Od4X7TbwmIjuCt5rc1BqGEi0Grw65OiLiSfi/TrxJEEswvXFZ3OwDpVyJ/3oRlaaV8q0NCD3Pr5Bw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:57:17.8945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b2609d-035b-4b52-ac2f-08df2b7ca08b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802



On 10/15/2026 8:49 PM, Yosry Ahmed wrote:
> On Thu, Oct 15, 2026 at 3:40 AM Nikunj A Dadhania <nikunj@amd.com> wrote:

>> @@ -2169,6 +2200,47 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
>>         return w->gva_to_gpa(vcpu, w, gpa, access, exception);
>>  }
>>
>> +static int nested_svm_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
>> +{
>> +       struct vcpu_svm *svm = to_svm(vcpu);
>> +       u16 index;
>> +       gpa_t dst;
>> +
>> +       if (WARN_ON_ONCE(!is_guest_mode(vcpu)) || !nested_pml_enabled(svm))
>> +               return 0;
>> +
>> +       /* The flag can be set here if the fault that raised it was discarded. */
>> +       if (svm->nested.pml_full)
>> +               return 1;
>> +
>> +       index = svm->nested.ctl.pml_index;
>> +       if (index >= PML_LOG_NR_ENTRIES) {
>> +               svm->nested.pml_full = true;
>> +               return 1;
>> +       }
>> +
>> +       gpa &= ~0xFFFULL;
>> +       dst = svm->nested.ctl.pml_addr + sizeof(u64) * index;
>> +
>> +       /*
>> +        * Drop the entry if the write fails.  VMRUN only verifies that L1's
>> +        * buffer address is a legal GPA, not that it is backed, so a failure
>> +        * here means L1 has pointed PML at memory it does not have, and only
>> +        * L1's own dirty tracking suffers.
>> +        */
>> +       if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
>> +                                offset_in_page(dst), sizeof(gpa)))
>> +               return 0;
>> +
>> +       /*
>> +        * Decrement PML_INDEX after logging the GPA (buffer fills backwards
>> +        * from index 511 to 0)
>> +        */
>> +       svm->nested.ctl.pml_index = index - 1;
>> +
>> +       return 0;
>> +}
> 
> This implementation is essentially the same as Intel, with the main
> difference being where the data (pml_full, pml_address, pml_index)
> live. I wonder if there's a way to share the implementation. 

I did look at this.  The genuinely common part is just the range check,
the write and the decrement, ~10 lines; the enabled check, the full flag
and the exit synthesis all differ.

> I don't> have good ideas to be honest. One of them is getting pointers to these
> vendor-specific variables at the top of a vendor-neutral function and
> use them (ew?), or maybe have copies in vcpu->arch and sync them back
> to the vmcb12/vmcs12 at some point (less ew?).

I would steer away from copies in vcpu->arch though: svm->nested.ctl is
already a copy of vmcb12 that gets synced back, while vmcs12 is written
in place, so the copies would sit at different depths per vendor.

> I always fail at predicting what Sean will think, but I think I am 90%
> sure he won't like either of these ideas, so hopefully he will come up
> with something better!

It feels like more churn than it is worth, but I am open to it. Let us
see what Sean thinks.

Regards
Nikunj
