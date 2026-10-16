Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB713C3449
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147148; cv=fail; b=doSUkzjHiAD8iFWy8MYs6tmvQ9ftWhYk4GnETrIJk+SbpCVx6UEwrZT1HCFazwCBJwPIsng/HRo4gzDVYHeM1Qqxggz4P2yQguXtE2U9RHlm92CpDINtjx0OXdVfxzU040MkBz1goUOe5xRjKAinkrkufEpOvia7sXQNA/vJZIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147148; c=relaxed/simple;
	bh=F5EcBaoXU4Sd4YO6VQ8IdbY79b0qIpnlEUE5AUCP+ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nqzz9+w48jnN/xogKIsBCQrJlJSSFrIMey10raD8KGixlE0apxWntY7us0pAV0cnFHHfPqtSp3nE7KFb2SVT/5lZFCL9PGMQEtsKZ+pkBO5dgtobmP9l3fH3pXloI9WuOTyrQ0sKmo+TdWpBqH25T3bsvlwepZlSwdzO4XXBBm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFt5bsVK; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFt5bsVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI6MU3x0gchxGIGtX+QiSoHNpFmnab9eVamMKy8wiIGX9YEpZEBuX1jnm+e/U2svfkIJBIkX4kyByCoh/YKMO6o1756aI8NlNery+wxzAJKuhNF3gs+salVCedWKaww+BWSGRW5vsbKqy9Fn5uLIfsYb7L79tJbeEXNk8Rm0VhVLw+YyZguTiwLSY6IKWV+4ujtJCJZnqgkktkcA2CoZTV5C9KzjiB3huVgLghx78/Zpji0arWZxgsBzHBgrxDZJFajfxo29QbIiLHtllBbpSMFZTLDHGDdc61/Bq6GSq8o7il8XZzeIvvzOpYBetceQczZ4LpSXkcwewLRUGZSNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEbaut86T+lGsmrmBvx8bdufd+jsfFMDnk8KkDJXnPA=;
 b=KkQqX9k/Dj8AwRMh3oWLNmL/VTLIQgbYD5Hr13s6XfEzET6ls6CHYTp4pfuGgA5WadHtNsFn67KzbiG/dfM8CBPO3DOQMTphPPqR8oZ7Gjmw57HTDQPaDcRiUeKATuxY7SZsFwTeItBqEpISsuwnQIY9PovymUhJ8tVLJTKDkJ7ReMA9qvlA89JkVBTsNDdyYIapGzOZsRwxhi+V8M3/G1Wp/fechXFsyIKRUWEl50gm0xBIadyGvucsgEHimPuTfzDf7GgOfoWJ1wQt4/MXeHkwxy/pm8xBYGclwr9lILCJ4E+8MVJnSBR743Lwhkm/AUf1NLgMbvhnOR18DeE11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEbaut86T+lGsmrmBvx8bdufd+jsfFMDnk8KkDJXnPA=;
 b=nFt5bsVK59M/bwIps2365VVVouFRF5MStzP3lvKMOCoqPIVsdaJbUNJVdiJZOmEonVsyy2HTHRsJuJg9kKlxcoyrXYV8XJKcwZtvNNJoKvhausx8/WansxObyJNnhkkJPvGn8Clva11e/wh0YFYLOz1kaUIPjyhpE/rg1O8q/kw=
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 10:39:00 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::81) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 10:38:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 10:38:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 05:38:53 -0500
Received: from [192.168.0.102] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 05:38:52 -0500
Message-ID: <bfb2c3e7-cd80-498e-a4aa-7b46b56b3363@amd.com>
Date: Fri, 16 Oct 2026 16:08:51 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] KVM: x86/mmu: Log dirty GPAs only for the nested
 GPA walk
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-2-nikunj@amd.com> <sashiko-outbox-172691@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <sashiko-outbox-172691@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 36921a5e-963e-4ea3-88b0-08df2b71b059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|18002099003|22082099003|10067099003|13003099007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	G059h7ZAbKJy9SqvT4v9fU0WXa4mzRhwSDksBrEMLGaLRTKps+ypt7BEsL8Y3d6IX3yyrjsR2lAImPQlY6/9iSu5TBxLJ5qWGTRDdeGHwihUmoKZul8HXybLDkWvRa1xO5oSdQr2QxuLbFNDQFhbEH/QK4vf9i8MOD3nT5Au6JUu+ULfdUN641UbEMoRtOI7StUYo4Ab67XkKWu2mSqycX6bGkXKGu6vK8AqPy6cdaKQp2an2f/I5MexXuwvfej9Jp554ciEwwo9oJuwTqSx1+tidac7iZQAzjwFrp59kfUogUIgqFNO1vvIusAqSwDKo7figmIAYL9UNlVPbPocNYCZWm3jwHRSk9v+qtqneV8bPGzRKREUMWoaiIYOssDHX0vU58gY6qrehzRoXKK+uZbbGRsJTymfxjEl4v6Xd0AOwECvviawF4K+caqub2TimvSl/zpmsntjlo9J8L5zE85XqIIjXyDgxefQ6mnTwFUrgsEAqrldfYlNNXMA2AipbpdPA3sNLzhv11EmwAvhR9bjnbLHsIYvcFiqEKtY97N6/uDS576REoa+MVt9cv9UjMgnAtXziBu3ycPgnr58Jr0WGr8+6xZwSCNubhyc3Ca/CPjshhsuIO2m7tlWDx3eJXXrjQ0glYkJoDY8yYvVef5bBvB03Aoh/t79j7GoecCMTTsLXp/c9PVh11mO9TxQZZPilFmMaBbAhY2xkPQFYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(13003099007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xdZvsBvBLEsJFWMRmZiDYJwuIhKmtR0RIxPIx7IoYGJLUD/z14sODISFqJZKugh4tdcyhl/Xj4YtpCgPowrsHDufJPMABcu+jfzsPe/Y7y+jianlBsdmGWgTcYrfjbdR/SSxRE0lUbfZgAUU56q3sC/ypyicnxa73yjsbVNvttpmVOH1Zr4lhFN4BNWlKS9O2U8X5Rc9MUr3f3+zSUiBs+nGeL1GMuspUm2MfS3qZXOkequlW5X7VbItxP9mHhqe2+BCnaY/5I8gUsHMP3tLP5Tj+jsOY+FsultRH37OgqA3rPd2reA4S8NExfN6A/ci/yBR0lm+PF0VTf00bvjLmcmrGMc73nTw7054U9tM1ubDqXpJq7UGpQODtg13D+j2SfXqtdwgI1CAuAHTOYzZnNd0iWF7ZsHtrz8B2jegQrWzqO5MFuxr+4NmdIHNQk30
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:38:59.9408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36921a5e-963e-4ea3-88b0-08df2b71b059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347



On 10/15/2026 4:25 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: x86/mmu: L2 GFN type confusion and missed PML logs for L2 page tables
> --
> 
> commit 39018b0fb43ef6b337e5d8b61b880163828654c8
> Author: Nikunj A Dadhania <nikunj@amd.com>
> 
> KVM: x86/mmu: Log dirty GPAs only for the nested GPA walk
> 
> This patch gates PML logging on the walk being the nested GPA walk, assuming
> only that walk yields an L2 GPA. No functional change is intended as the EPT
> template only backs the nested GPA walk.
> 
>> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
>> index 8e350095508c5..043d0ec02b272 100644
>> --- a/arch/x86/kvm/mmu/paging_tmpl.h
>> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
>> @@ -235,7 +235,9 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
>>                               !(pte & PT_GUEST_DIRTY_MASK)) {
>>                       trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
>>  #if PTTYPE == PTTYPE_EPT
>> -                     if (kvm_nested_call(write_log_dirty)(vcpu, addr))
>> +                     /* Only the nested GPA walk yields an L2 GPA to log. */
>> +                     if (w == &vcpu->arch.ngpa_walk &&
>> +                         kvm_nested_call(write_log_dirty)(vcpu, addr))
> 
> [Severity: High]
> Does this change miss PML logs for L2 page table modifications that occur
> during an L2 gva_walk?

No, those are logged, just not from the gva_walk.  Walking L2's page
tables translates each page-table page through the nested walk, as a
write:

      walk_addr_generic(w = gva_walk)
        nested_access = (have_ad ? PFERR_WRITE_MASK : 0) | PFERR_USER_MASK;
        kvm_translate_gpa(gva_walk, gfn_to_gpa(table_gfn), nested_access | ...)
          svm_translate_nested_gpa()           /* switches w to ngpa_walk */
            walk_addr_generic(w = ngpa_walk)   /* write_fault is set */
              update_accessed_dirty_bits()
                write_log_dirty(vcpu, addr)    /* L2 GPA of the page table */

Logging from the gva_walk would be wrong rather than extra: 'addr' there
is an L2 GVA, not a GPA.

> 
> When KVM emulates setting A/D bits in an L2 page table (during an L2
> gva_walk), it is writing to an L2 GPA. Hardware logs page table updates
> to the PML buffer, so it seems KVM must do the same.
> 
> By ignoring gva_walk, does this fail to log L2 page table modifications
> to L1's PML buffer, breaking L1's dirty page tracking?

Regards,
Nikunj

