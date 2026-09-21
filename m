Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337B3515E8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968218; cv=fail; b=m7VAqRYoAbLllnhK4qkdxN27Sls2Qn4n9PzGuhkqR938RXJYrUeTG1sd/JrQcbPRhcs0TfQRlf5LWPHU0PtLs7jKPbcoYmZ8ZbToUL/vpb+9Yr/1tg7cwoZVKqIW56QUfwmK/s1ABrA3aq5Cgj+SmzT4pUBqBIO+kH5SwHHt6l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968218; c=relaxed/simple;
	bh=aSPmoKRXvgfwimCFQJCLoE1ytEpSa1CLLPZkKCNXjuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fqerdvU1dYml8gBCmz1vZV1DTp2richKd6mNANpw7SK/HmHUIiR1aot8KEpkVTTCQJ82rCZtoXBH6gFPnuTbyPf6prc70OGXnbrFr8140jA9LqD3Xd0q5qh8dankYVyq+/5grMzGbntniFlOOfvRncbWTfLXjHvP6U49++bP1yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIITNGEs; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIITNGEs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4JBAE61Q9g0HuZBQtZuFzTQMg4/OYn2B4gEFtlNS9jAR8KBs6O5rIcYC/sksx3wEzoJGhDs3t8CysEqFBd0uLqGKaF14RmyfXNHxTNmGPSxyVgkxD0hUGzfWBXP/gYLzpF4Fk5AUgc4UN3DJxeQrAEQ9256CcsjsstQWoI+BXZb2BC0fo6dUG6BLM11J2SdKtuSygOj8wqwwlC4KUdOrJSlYomfimdFUWOlB4AybT0A0uY0UYbGT+/Vqwon35eDe5lkYLwNgWh2d+iVclX6QuC3yIzvxuVwvQt8yhHqu5AiKonD2t9R86ePfg/i8RkGYk/AcF1Wgfn2KcXQb1B28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCvMYOmsGQxqYkB1FcPpd/Z0gGrLkf6JCFMQL2IfnlM=;
 b=D3gRd9C74R20p2N2kNagdRMUUt7F9aUPIsa8CavLTQEXE4DH6jbaYj/q3qWmKR0NzfPYQxC/oSZiMxeX+rvY0YpSORvukrsaMle0pwa0cYUPqVcul3IC73Gn72mRaaTEh2qAMkdnYazM+qRqeDzQMPUYpvDlvbCDvSS7JClO6jBjEuY0+1FrjRV4hbk4LirXFqrNGmIXVgjFMkaZRtUEkT5cQtWMTuTTxgMn6DOEiSXJjCJb7RqF1MiscriCcpOiixV8yYhhjoLht7/xxYSboqnRTbv9OUqyJYBOwrs1aEk5HOGiZvkYusQUrQUgohAk3wfTyGQ2nBMvCmssuR/wGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCvMYOmsGQxqYkB1FcPpd/Z0gGrLkf6JCFMQL2IfnlM=;
 b=JIITNGEsvdTl7YzmhWlBHY9Eq6CHcAY/UCwylIYRbHnXE19QtqqxX63cEdE3v+usXZUojQX8a9STGqkrG7xkisz7ZKhPCdQzDaZ1v+faR4H1tTbXCJnaquv7SXigSK9FC/OUZYCUE/nquZS+TO5c52rQ/3nCam6QXzpWQhnf9/E=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 05:23:33 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::4f) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 05:23:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 05:23:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 00:23:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 00:23:33 -0500
Received: from [10.85.39.204] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 00:23:31 -0500
Message-ID: <4b931b35-0890-466f-9ee3-09b4bb9ca4b7@amd.com>
Date: Mon, 21 Sep 2026 10:53:30 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>
CC: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <20260907063906.1964557-9-nikunj@amd.com>
 <20260907070024.4A7E11F00A3D@smtp.kernel.org>
 <9a5552de-0f36-41c6-8bb6-16cbba5425b6@amd.com> <aqH4SpA_567soglf@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <aqH4SpA_567soglf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 254bef79-3a0b-4537-3792-08df17a07b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9IaFaTXNB/cpswfbsNntXaC3VaGJV/yzuP9UvRJ+Jf5CYmZ4AdygX3JutU+aiHYyG66ff0sNtzC6JeEaPdrp63uUf2sibgLfo+ZzK/lVRKLlEvb/By1V2xcBlflbDa4sB1a76xXvyOovAMZ6YWIOTbdfAUsr2QPLYdjbmeK7wCxht326UflNhSegFsunxb+nxy4eoNz83NbfOCoJQ9zcp4hY/6F6MGCJy60h3bRMyIgy/wpoD73fu/np9dvoG4nPDGRb79WVRE7ExWYXt6FZ7N46dONeqFEzHqidBhhZVkThMuvFZNXngq+PEWMAoU3MaQ+6n8jHFmotl8fpc78SrTqPXPN4FM3iHXfOzAJ7zdv3pxoUII5oNLutOosOzG/+C11pC4LQs4y/Ekp47MDeP4dCppgd89XP58ZuN4L2Hkv60CSRzM5/P0sVqC4LIlXcIu4l1OgzGQ874iRtbxx/FHoO5eXoB4II5g2xENaRqGVkyINtrsGQVjJ9V0W4dPWArqyZkKQybJ+8bP015FVq5bL52d3Omv4WvXkR8qRTSuySw9WXN0G7dlePwqcQ+7cFW0ePjuc8j1juiicddqsJYcQdEpHvDwlekXS2Iohg2/N8ahsDSq4hl159LSNrp9aUxuod3tIxnrjFVZL3tE39uBa0SK00dthXRpyLicLjxQovduM5Suuln/htxGxzw3vd/DwV6O9xmB4QwzAhXdkwWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QCNxYO+3ar+OdAFWstkqq7pB8WrOejZyVm9hV5VWosGnCqVq1s7kdyKJSsKcgnQYMCvPMqf9hTn2ClU85VqXHp3olkqdhLyaQ1MQlfzIsUngIQ96lvB+lb574/mg8qd2fG8dIgBkMYSy9rIC1LYag+6OkDDRzz7c2rEKe4nLdrA5K2NHl6JICH0TdemlxvSBw7Y/CUpqeatEluCD9vNa4lh7xKr/Oh06wOGLXBZAub+akjf5xNaWUuv+nkaWJ8oCFO7w7dhXr+TPpDLeIxo4TIDqzj/0wzIZiPlRZmueQ/60/uMrhVVM9H9qDTStM2KevRsdQ9BqdfaNsZZd1zrDa/sdtoPx8EdPBDxYkRv+PWnEJX1HXO4eRj/oQjj6EbKU5IIl6MimRbE5Lw7jpPVf3ng9BjewFBGpcsdWkOsBsFR45Q07llzd0ut1d3S6rl7D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:23:33.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254bef79-3a0b-4537-3792-08df17a07b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426


On 9/10/2026 5:52 AM, Sean Christopherson wrote:
> On Tue, Sep 08, 2026, Nikunj A. Dadhania wrote:
>>
>>
>> On 9/7/2026 12:30 PM, sashiko-bot@kernel.org wrote:
>>
>>>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>>>> index 73f37b050d0a0..da417c4c59154 100644
>>>> --- a/arch/x86/kvm/svm/nested.c
>>>> +++ b/arch/x86/kvm/svm/nested.c
>>>> @@ -901,6 +901,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>>>>       vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>>>>       vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
>>>>
>>>> +     /*
>>>> +      * PML is never enabled in hardware for L2.  Make sure that an
>>>> +      * unexpected PML write would trigger a PML_FULL VM-Exit.
>>>> +      */
>>>> +     if (pml)
>>>> +             vmcb02->control.pml_index = -1;
>>>
>>> [Severity: Critical]
>>> By intentionally leaving hardware PML disabled for nested L2 guests in
>>> nested_vmcb02_prepare_control without informing the KVM MMU, doesn't this
>>> cause all memory dirtied by L2 to be silently lost?
>>
>> No, kvm_mmu_page_ad_need_write_protect() returns true when
>> cpu_dirty_log_size is set and the shadow page is in guest_mode,
>> which forces write-protection on L2 SPTEs instead of relying on
>> hardware PML. L2 dirty pages are tracked via write faults, not PML.
>> This is the same approach VMX uses for nested guests.
> 
> And FWIW, because Sashiko's hallucinations made me double check, this series
> doesn't advertise PML to L1, i.e. doesn't need to implement and wire up
> kvm_x86_nested_ops.write_log_dirty() for SVM.

Yes, SVM nested PML is on my radar, I have been working on it along with
selftest coverage in nested_dirty_log_test.  The test covers nVMX as well
-- dirty_log_perf_test -n runs an L2, but never enables PML for it, so
KVM's existing nVMX PML emulation doesn't appear to be exercised today.
Will post it once it's ready for review.

Regards,
Nikunj
