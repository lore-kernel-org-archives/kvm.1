Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BF31326A
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143286; cv=fail; b=KPcO57KX/a9FUNQL8eb64nG1bPEl/I1IRz1QMLcWNPcJig9s53a81Nss8lmnc9NkAX5nJI2qGhjmLCGMBm6jY9lqwoW0joFTRF9cOZyfxiu6CMz3fa6Y39bN9aTSXMeCtiNQlY+ncfEqvwCroUAmlSOJ9ZK2SXRb5nFQRz4w9VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143286; c=relaxed/simple;
	bh=CJXsS5/wPrLaOjyzZA6GSs4i9Nn50ebcR1LLcXz2MZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E91Xmr1thTPiazLJ1hqCFCErb4kFuJpgH2Frk15w9YL0Q0dX8OLh6NDcE4/vkAVa6VeA3ZhPjMTbfrKjAjjzzQlwTP/GupcBBnhAw5Ii1yS3iOn1EytSxxp62OMPmNaU+p7yOsy3AGawLsN1MXtSbhl65iQlM0RckESOEp8cSi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WjSLPkIs; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WjSLPkIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW0m3nyfLPadb19KfQa9l/LDLD2b6VXf14muC/3G+Nd+vG3mJM02Og9OGmn8jFkeK5na07vJ9Ya7afN+Nlh/QRs7UEPHmrYSaDgNI8WIlj4JVPtS8mazdU3o+5OpGmuDfE6YVFbwjXZy0VrCCl95fSlCBT8Labwi/VaC7Pyr8kmEIEDGgMjXbmxLn1a4QSVyuV8QBA0CBBcTENvU1CVOXqYB2v43E3QnG/cFP3zeRiwk3LrTjZFhOqVQfarV+5EMcSsETVIws8070EwsNEab6YUhJNdxSHPUlL9OqAQTb9nSzSLMudYKE5F6uirxrWpv23BpwYfgxZMyebcw+1SdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBi5Owu+8HXopF+neRddm1RHiGhObuOTA8AT+sas2U4=;
 b=wddrrK1wDGDWCWYIdaRsSKJBARn1mkCh947lA0FO95EKanJ8EKkeAtiqWQqr8jIrOWmmN80v+SNQWXZIPvhKwpqpW+cgeJl5g56+ByZJTGQ49XeVKXTBAjS6hElZZ1Mk6WGwepY4V0j/XsxRwe0pw+1jqn/xvKa0m/UPDu83lfW2+7ulYQLDr4TXOreAYtv5BmMAlL0uNemlEiyARgVkQ2bqYfRo6wDa1tW72xokjMZZCa+upB2a1xkWOJYVDynzpmuxfjhqR97+FO7jt4Rj1WNBnkKCbJ+KU7U5DhlERFCPxPDatM9AARoRZCoIeWBEci+dSohQpft0fU7ie+Rc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBi5Owu+8HXopF+neRddm1RHiGhObuOTA8AT+sas2U4=;
 b=WjSLPkIswPoz413mmiCx9C8RUJVIsYyqRulqpHSAaBLVTkey5es41IlAcy/zizGQWNoVk5+PXlqDWESJ/Bqsi3oMxEeZvF57lpQgd7SJR6JnemUIQwq8m7iRYvrl/OkgL1gk0IJsjnZWa359zjxOD4kfgCswbLrZdoN+qY1RwDo=
Received: from PH8P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::25)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:34:39 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::72) by PH8P222CA0012.outlook.office365.com
 (2603:10b6:510:2d7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:34:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:34:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:34:32 -0500
Received: from [192.168.0.102] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:34:30 -0500
Message-ID: <078ea4f3-f0fe-4c91-9b63-a0a822a1aee5@amd.com>
Date: Fri, 16 Oct 2026 15:04:29 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] KVM: x86/mmu: Log dirty GPAs only for the nested
 GPA walk
To: Yosry Ahmed <yosry@kernel.org>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<mlevitsk@redhat.com>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-2-nikunj@amd.com>
 <CAO9r8zOV6Js2GgjPXGcjs4ZG4CkqBivRnas0GR1Dd=22O89-AA@mail.gmail.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAO9r8zOV6Js2GgjPXGcjs4ZG4CkqBivRnas0GR1Dd=22O89-AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: b119f51d-ff1b-468a-9e38-08df2b68b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CGJl8ljcWirKu0PQI8XqKmfTuRCtlDTkCyPmrZsiRKV7kFvp+bTOph0rEBZlrXE/ui+t1wK6YoVrYyyOlFSKfwVAv3jyh9sCWNEHWVsBmQZxriEfVD8T6GRTlbN5/mfTiKJiQmDTAOAcYeR9jQJAd+rgUFsMWc9EX9FrGZYGNr74q+J0l76mhKw+9dq1ieBytANIb/GfVJm5Smk7z4cNK1KHt1GtJ99KkkPo7vNBa+xudxr+ebeRvgWsfOLOe8tcRAU4nSVgNdXKS3/waB+zNtPU8DHSW+fqOTa4p+B7TT6YR73UJwKvGnHKJ0OPyyEyzbdAG/yT90f0gsyYMxNFMA18Z7jvHtZngayYf1mi4ltvKbi56GidBaQnJY0sN66/nFaPISPrJnarpaienq98LDME51gjKNzURV3GIZlBTaZd7/ll3ySwu022GSCmsy7Cp40bDOQVqxo0INk4LzsN7uGeHjJ5AqZDneMbvoLcQWBhQpw6osTsVAuMSQlQ/1a6Vrvg3u9enbdL6UQWx4qxbAJaZSkiHcCygrw9OvD2/UKVnzysKjZ3dAaTAYy6ub3tIAofATouG79Bpsz+NeSbQhfPvdBUdAy1k8wV3L3lyNSa6znYPeu1Gdv3DR5OzbmXJvAiwWZABvYDJyvTxWgs+gf1PMcrtZ8FyNNvFS6EXsEaThMPEh1A7W1VzNiefYkt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1w7rE9x9fJmtVhLPNz9N4H2eSWZNh/xJbU8AX0FqSFPMkcr9rHJxZyDC2p09sdM6nydQDhK+KQiBFr4VkSm3H8jqJEj66HgHOOWfEpy1NPKeuTC1jpy6KzQXPro00ZKrvaySxnrG3u8VGEXnW7ITMLQODZDZPtkKASqM+/ljfMlfnreT8kCpbI3scpIYujEotrm1G4+b7dCdr7aNhmOPQP3BTjUqu2+FdFP/6RUjgomFp+r01hoyVSvq5OTD+wAC6xbuFex1p6gO/3NWpo+mMAG2TiUvr+IT7wycwr0m40DHWKfcb40OeavkQ0gSzwqYghTf56rxIC4LPXiiIgqL6uVvNH39NacY61P5JX5Ba/qOspFPzWzFhnlCexaRwPEo8SQ5FYT41A2FN5UdQ77nC9zE7bIqUu9rbIlgSlMdzQfbfMxbrxfAjTaXnqYTxwTF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:34:39.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b119f51d-ff1b-468a-9e38-08df2b68b339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317



On 10/15/2026 8:51 PM, Yosry Ahmed wrote:
> On Thu, Oct 15, 2026 at 3:40 AM Nikunj A Dadhania <nikunj@amd.com> wrote:
>>
>> Gate PML logging on the walk being the nested GPA walk, as only that walk
>> yields an L2 GPA.
>>
>> No functional change intended, as the EPT template only backs the nested
>> GPA walk.  The upcoming nested SVM PML support runs this code for PTTYPE
>> 64, which other walks reach too.
>>
>> Assisted-by: LLM
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>  arch/x86/kvm/mmu/paging_tmpl.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
>> index 8e350095508c..043d0ec02b27 100644
>> --- a/arch/x86/kvm/mmu/paging_tmpl.h
>> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
>> @@ -235,7 +235,9 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
>>                                 !(pte & PT_GUEST_DIRTY_MASK)) {
>>                         trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
>>  #if PTTYPE == PTTYPE_EPT
> 
> Do we still need this?

For correctness, no, the ngpa_walk check is sufficient on its own.

But dropping the #if also widens this to PTTYPE 32, i.e. a non-PAE L1
that uses NPT.  With KVM as L1 this cannot happen: a non-PAE build
disables NPT, so L1 never sets NP, which PML requires.

      if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
              npt_enabled = false;

That leaves a path I have no way to exercise, so that is why the #if is
still there.

No strong preference though, so I'll go with whatever you and Sean prefer
for v2.

Regards,
Nikunj

> 
>> -                       if (kvm_nested_call(write_log_dirty)(vcpu, addr))
>> +                       /* Only the nested GPA walk yields an L2 GPA to log. */
>> +                       if (w == &vcpu->arch.ngpa_walk &&
>> +                           kvm_nested_call(write_log_dirty)(vcpu, addr))
>>                                 return -EINVAL;
>>  #endif
>>                         pte |= PT_GUEST_DIRTY_MASK;
