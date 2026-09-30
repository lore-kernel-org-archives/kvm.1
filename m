Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FE2D7DD7
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809575; cv=fail; b=d8LObD4ZI3+4NF+0WkKZrsljZn/hAFXFP5TZKk0BUugQco5Tlwto+mRQP+AM1XAurVk5MKnFGWyqmRKeWkqym9QB7LwlCAbXohhD8FT8pRfdyJHdV7bLkmuy9EY1eFO3GuNWdzPHp7ffPdax0ghEUGJwEUOykyojcIfs+ogb6V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809575; c=relaxed/simple;
	bh=4ErTDGU2J/hhDHD8RD0LGWHoXgF9GqDJISDPu4In89U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cwB9BPDL1sERXjNA8u06Exw4OGtyZxcvfPvsccDmOBY97ux7wyTLUGcnAaLO4g7YKzuexNo+aAK8EU5o/QiuM8z2GWn/iNVzm31V8VC/FkoTgQrrj386mSP8nfBzYNvX5+OSCk8UkBq8HEwLKPbk+i0BUc6502T4aQyzmkx7JQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGAu4GSF; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGAu4GSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdjDdStWagFxPYZDxTY8GXv1n2fdBq1SzMfklwaDRkTeMprhyztI645lfWuVm2z6VBrE6bmj+YA09xmbRKCfGGtRneMBwdQPaOX/J1zZwTrahSPqlEcGKqpfhNoMfUKbfjLEV73pIdNcXM0Ndgc6izwH1VtUBDaQ8ZgOncrehpnsQ//IRRsI5DrrOBrmUC6BdFgdWUdO8aUEpcAHEwI9kB05DkqQ6oc81Fa1AAs7UoNkcO/l0oxKLiBADrGIA5kBCLsLi+FJKGSdAiPX80FYj+os71tQulJ89FND0SLkOkd4s895uLbEY+INNvtRy3pEFr0WLdgm4SCZCdaXce07Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUK73szPdgzJ2jekr81NBFQEiCVLnusGUgEpwB8XoIw=;
 b=xVd3M6YfQARH4GNmVYXA2GbLL6XWzNmBSGLBrItJTMl9uxpwRO+NhZEaDAD5ETZvzcmhurfBRKGa8H0Vz60MwmjxoerlzY8Z/94vG0Y+zZyPzYXE6xvC6omvob7nM0yE4t0uMtkME9QNsD7r3ryr8JCWbs0BQguH/NNnkrI6ZUAWjcOip7gl6hHtDv82fECjVPBs1uaJl9BrRnssrBDsVKqHb4qlzjYMPJKcJj4r+vYZ18rCgKVcCgOd7HLwsnUARVnmRiOehjyySDnA/ljFQxLbnJI/qxetMuM5SBJ7UhDXE9vkdjC3nPATEYiSlRNfRibAXdgERT8VuHfSpEJYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUK73szPdgzJ2jekr81NBFQEiCVLnusGUgEpwB8XoIw=;
 b=CGAu4GSFyvYkyhL1/zPNxK89cXx/LNJGoIrBV9yUClSjKg3MckRRYOtZR+3CcsCm/SssmQMtRpCQWnj2OEa6MRc28Rt10G/rlN5EsfW9m6IebMlMVtMcIDORgLjALWIh8tHqmfqaVk803k/P+HcX3P7z6gvNkCm6pTOuT4qeGUk=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 23:06:06 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::72) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Wed,
 30 Sep 2026 23:06:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 23:06:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 18:06:03 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 18:06:00 -0500
Message-ID: <f57233c4-8a29-4da1-8034-390fd9eb0bdc@amd.com>
Date: Thu, 1 Oct 2026 04:35:59 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor
 LBRV
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <arazNV7Y93gnflU2@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <arazNV7Y93gnflU2@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 21030bc1-6a69-4731-c318-08df1f4767c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ST2BTSeez7AJ5bdEBgZxHi39UbAR3HSPk3fC/t5GMjlfzf9VcvM3bc8u/WtbVNigk8Oi52D2G9SKf2k6uzC9vZtGoSo2+4DIq0Swt4Z2H/cQCd+ptaUsmHCR413RUcUNoJRGp61grnhIDTp8QKQFflchOuYu6wdOEW1hHxvOza8IRbay9D6E7h2AppxD9NC2q5D4KbhkAVoOS2N5c+ePwQ74YcPo/eETJK+ltn+WPDJFdV8PisrJTKAQnGfG8WdfNepkNK7HD672sfPOgdNu9K+Wy1P1ieWlYtaSc7Nih8OpnduukUvv/u9Cl6IX8UGSFdA3FDyi92HqW6StmrzmfaDGblj8LqxubmTsK7ple4Dqp9F8dZUUWJX+LLzs77rcTDOmYSSDUvcUMcZPkFN4dvkijz77YghOmEoU5IYs3VDPAnKLY9TqYEQ1gI8SspWPzCoQufZpD6Q3xjL0oFlfJMxFyVKoue/Dj6DrrNSQG4DMJaFxLKAumdiVeUXhKgmNnsfD370tKfqrOTjZdYVwaJ0DSxB8Pn0F9ZJbRFqVYUVNfXmSrYCmahl/Q/J2lII3gRCcOXTnJikl3pnCZXiEIHzrChUe6+gw5InEJy0VapYCI4Jj/Au5Ho2SMgsrX7r2x65SjNAKHpoNbIPHDhC6rwW8u7ef0H1jsXgCbPERaZDFaEBbQ01dlQcwIAwoIU+Q50fhDieC5t6Wr0ADRDwWiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kbVQZtgmpIh+wvvMquPKHbPxIylwrn5uJw9Z6GiLWkKDj1oXp2dpmL7/fk9Y2h0AVyQVUJwARdYaAY7TW41lVied3VrAZ7/q+wfVd+5ldiqziAF0BilNtDmuvr9+dwe6EPIF6GPEv9LUy9NN8duIioK9v5kde0UuzOegJi1epBPLPWt4849dRAd+38Hs+EgeELi4fEtGvpgtMuMVvRO3APi38CTizgGY1MvBfWLbYjup9LNNO3qfV7ub95PEXozyi72vtsY3DpmDn9UTyo21VzKhcKKGLtI1mx4jkqKoEZKeDgwNY0Pchv+izFKGE76rRihqfOhg9/uJMG3/ceLl9J4bSwC+UNJ5n+6RfKPJYlF+6k3eewDmuhDRy17QuzJ2VRz1ifFBDxmzGK//A9luyJHzomk4PcRoZrwbxkx88eMGIPkB4w0nGMnxZGtg/jpR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:06:05.3637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21030bc1-6a69-4731-c318-08df1f4767c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860



On 25-09-26 23:15, Sean Christopherson wrote:
> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>> Shivansh Dhiman (5):
>>   KVM: SVM: Refactor svm_update_lbrv()
>>   KVM: nSVM: Disable LBRV in nested control cache when unsupported
>>   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
>>   KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
>>   KVM: SVM: Add Bus Lock Detect support
> 
> I'll send a v5 as I have variety of changes (I already responded to each patch),
> and I'm not in the mood to deal with another version as I'm quite grumpy that no
> one bothered to follow up on Sashiko's bug report, or to write tests.

Thanks for taking this over, and sorry for missing Sashiko's report. Ravi had
posted a KUT fix for the default DR6 value [1]. I just hadn't rebased and
resent it yet and your KUT tests cover that as well.

I ran them with v5 on AMD hardware and they all pass. I also reproduced
Sashiko's issue and confirmed that v5 fixes it.

[1] https://lore.kernel.org/all/20250224112601.6504-1-ravi.bangoria@amd.com

Regards,
Shivansh

> 
> I'll also post a KUT testcase, which I created to verify the bug Sashiko pointed
> out as well as the fix. 
> 
>>  arch/x86/kvm/regs.c       |  3 ++-
>>  arch/x86/kvm/regs.h       |  1 +
>>  arch/x86/kvm/svm/nested.c | 26 ++++++++++++++------------
>>  arch/x86/kvm/svm/svm.c    | 28 ++++++++++++++++++++--------
>>  arch/x86/kvm/svm/svm.h    | 13 +++++++++++--
>>  5 files changed, 48 insertions(+), 23 deletions(-)

