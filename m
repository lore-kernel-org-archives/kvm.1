Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A143B14D4
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806670; cv=fail; b=aHACWj+7uHR0mMKIbAEu1CLn0yOH2PNby6iaLSDy9cbX40dfEPtz9mNtP3QN5d47HRlvHRO5y79e/ifFZKPHsgYi1Aux5YtFF9mC+PO0gW/nvUL5X7WFbP6KwNfyYvOuoiFMo1vftKScYZyPbo6La+cjmYHb2ERojGpSKcGRPKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806670; c=relaxed/simple;
	bh=qSNhHEHnuEXOMnsuIGf+VLM8ZoUbWZ5AXUwnKwzmUMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhZ4DKL2lWnWes0GjJVbbmEiApXND+qJpeBl+z043AJhVLG9PnhHBBCZ3xPusUW76vSC9WpCw+DyMfb/2ALauHzk2jIosK/MaDEal1t4jJiLV0ma57IICpgLPvyHS0jDtQgY+P5v/GtZ+uDyR+PjjCKHkvV1LNXSvDf32nKRdQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tARvhY+2; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tARvhY+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS6xL9za9uufQ0Zf04NyMGN5ZyjDFRLjpwzo4pdnFaiz01BJzUZGHyWcFP5PcJzyisIrNNH0OlmDS3h3mN95gX+4VhkxjC5AGbaXpwwrF5UgmqXRktLQafIRcQfapDNkJ2aGjRS6qWl1Fkn4bgD75Ts6xkRKYUXm0TZBHhTqSBa9sJ9wnHsDsd029ghgW7bTFr3PKh0/I+dKLBi/Yqwf9U6jAEUIw+gPFi4VsVVQZP6A23Q/6CyRQVDLc8GODJkceGhnmSobWVd/4meSUlDZeZCk/SboQjsMOjlSlumvh+hEmlGz2jAlC6ImViHmkL66vpjIDAp/Z6TBllMr5m5ySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5akNuM8zUjpM1IC3YRoFDo8YTvQwncMIvEpB3rDg7c=;
 b=r4VYKlD5362r8KmeOtLZ9gy8+qdrbcEJVqgN1cKlr69b5GqnngYJLMV0wHCOe8LIgUd4foWTbjL+s4uZZw0nzqDJtJSqwFGx2sYUYwpOfor2ZDAb4PD9wq4D4+nMDW/zIwrpzr+dtGg4pDYWYDW3xao2uDE+2a9ZFq+Ur23bvjzRn65ynvYbZ5i0qIXx8JtbqVowGgRRZVS9J0IV2hZGGOSEtSckz34qohVV7Miu+Ahgidlo1w6Tci8emvXEpy4+3Tvyd67B+LFlIV98T0HVDvl/tUMd7TOakH+u1TevcgMSX8FwucX0+TUEv57/hDehuYoRPBByYgfHTj078prvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5akNuM8zUjpM1IC3YRoFDo8YTvQwncMIvEpB3rDg7c=;
 b=tARvhY+2v4HfcJf/6i/sSCDqaLdIBGxUTRDE8UzeQuaF58mbbHYQbYMYVDNLS0LKB9ViD4gzMVTatW6n5KMR1YrEun5u+6DHDvHLAolu0toEEofDgci4KAmBJOPk1MKg5uwamjgcgdPxmFlFAXUtgxwjif5GEy37No312PPua04=
Received: from BY3PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:39b::34)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 30 Sep
 2026 22:16:54 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::3e) by BY3PR05CA0059.outlook.office365.com
 (2603:10b6:a03:39b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:16:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:16:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 17:16:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 17:16:50 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 17:16:47 -0500
Message-ID: <b3360430-c402-443d-892c-20d72a01851e@amd.com>
Date: Thu, 1 Oct 2026 03:46:46 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-4-shivansh.dhiman@amd.com>
 <arax0JmdoGYoSpGw@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <arax0JmdoGYoSpGw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 312c93f6-3469-48fe-1c7c-08df1f40876c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	f2apx7H7ugyo6bJWDuYNYVHCv58mOBSS8kXCm/e/FO2w3Z667ZjUflc2GWfJ/eEmzWqQ6POtZRbukOcHUETxDA5OCn4/6t7irFKcufZ39nKckcZlO1NcYeNqbI8jU3dKClghiDkpJSCohbyS//ATC5GxyG/j0kiwSIDjZmaOaLWpYEDxYxiS8bTbDkc15Ijv9gIYXZlR3UZFoHi8CbhkAy1RtrWstBsg2UbMUkk70dkOhFjieNm9x7VVnYeKemiuUBIRof7duTDxhGyS4/g7ZpyfzdjleRzX5LEV4cTS1weDE+wfnUvoSkpNdkiJe+kQ2ArtEx3P49Y7w14bME3sgrBQdoGRDUhYeCtvA0SEboPwjQ7dI8l9/UJYmIJURCl+4yJm91PMZUQco8W2xX1XC9igl/ZE9nsykz/2Zzc2S54VDnj6RJyxIlJDYIr4HVMN8QNkmv/6Fp5azNDIh8Pp6WDT/8mtGom1ysHZouEMdUfLuxhHzlQQnPKos5GlU7Rw3iqkhIOslOxoY5YiuwKAHWtviyB/2TevyuCMRNgUT0PXFd5whqBb3Nkeh7Zmqezu8+LCpLxdPCAYVEEYMPw3Rxz62fS3RZF/v8+19lhMVXLmcYBgiKZaEpWjwIYbit4+N+rdapDVOikoCBcXkTShbCC0tRG8Jqfg124H+V0+UJDGpcUyh5hnvM3m/MKdFnMVoafx1Em5g+2URPWAbrSnHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v8KiL2Rvy/Wo1E/2hPQRaz3o4NbMDsz2bJlgOLRRlfM5EIQNj8ogs/UO0Auk9Cdst6nASfjU8lIvW0qRw3ybu2zUnw5HoTAZfKMYa6SX5FCg2YbMWpiX6CGofo66WyrKXFqzFvI1Mfw2pAUL5FD5F1Z4U4rZ3cfYdqLlt82YxU//TR/kxW/fCMUa+hXqh6+pvyRJoj5ouO79/pfp//TCWBSn8b5OO+OER+sa25rIpBts0SCrJTZHAb+mb5ifUkl3OKr/5HsKiqE8Q7sv/Z0U8yEOe9sUOU2Vv1/U3Oy9MLs3N6FDXZJpvy0tFnXzHJFCx9lVGICE3YwdIen1nq/S5i9idcKAXewCHm3ePLSo+ryUFRLn+wfbxRWnm9HbPbJznR3GqwK1u75GYKXAhLP8YjPZbEk2jMHVoj4wlfI+iLonpbrNTbJ8iAeoua0sHZPJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:16:51.8928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312c93f6-3469-48fe-1c7c-08df1f40876c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213



On 25-09-26 23:09, Sean Christopherson wrote:
> The shortlog is again not precise enough.  With this:>
>   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed
> 
> the reader doesn't actually know what behavior is being modified.  It's also way
> too literal; the shortlog+changelog should strive to describe the change in human-
> friendly words, e.g. in conversational language, not be a play-by-play of the code
> change.  And that matters in this case, because the poorly named kvm_dr6_fixed()
> makes it even hard to understand what is actually happening.
> 
>   KVM: nSVM: Don't assume all active-low bits DR6 are fixed-1

That reads better. I'll keep this mind when posting any new series.

> 
> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>> When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
>> guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
>> (DR6_BUS_LOCK) to 1 unconditionally.
>>
>> DR6_BUS_LOCK is active-low (the CPU clears it to 0 to report a bus lock), so
>> forcing it to 1 unconditionally would prevent an L2 from ever observing a
>> bus lock (DR6.BLD == 0) across a nested VMRUN.
>>
>> Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on
> 
> We should kill off DR6_FIXED_1 and rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1()
> as prep patches.
> 
> As above, the changelog is too much of a play-by-play.  The names of the macros
> don't matter, and knowing the exact bit position isn't necessary to describe and
> understand the change.
> 
>   When preparing vmcb02 for nested VMRUN, force only the actual fixed-1 bits
>   instead of setting all active-low bits.  The flaw is currently benign, as
>   the only active-low bits supported by KVM are RTM (Restricted Transactional
>   Memory) and BLD (Bus Lock Detect), neither of which is currently supported
>   on SVM, but that's about to change.  I.e. this will break upcoming Bus Lock
>   Detect support as the guest will never see DR6.BLD=0.

Thanks for the reword.

-Shivansh

> 
>> the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
>> to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
>> Detect.

