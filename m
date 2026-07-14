Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2648BD3E
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044355; cv=fail; b=YE9WL+Y35Wls9sJldBZzNfP/v1YXM7rXTy4ttx7hj1NXT3NS8xkd/7iq7QCpukAEAbludD8zBR0VUCyGuy8pkxBQTAOc+Qy/yZArbkH1zVI+IuqRd1recCHk/NMW50EP9OItzaMK02yOw50ABWfIEgAIB0dr2RiIoAsdyfnl4A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044355; c=relaxed/simple;
	bh=X1M4oY74rYUwC/zmhtMA0zTbEhjuzJ4fz+jh82aPNUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hgGtBHCNyp2n5czKa8wPjbPx0oKjmnI0Ejufy5SXiyYisIb+pS7m9c/Vh8ez4Ri5inGZPhvDBVJURz+D4doA1R+0OWZARYo3yhnOnJi0utcsnqQ/rxe4HNDupRop83pP3YSk86Rt3gX6Vi0dVeA8Eh2fKd6niKZQzVfEuSSkufg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FtunMA17; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FtunMA17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoZRoI+/jHNrlujQNR6fD6p9dyi1gl5LJKde47bqiArAVQJW6DWgre5he5DabXxgqp+kCqwJEjsQOtcljCdEP0UfQLMGhpyTg2giZcwBXl4RHaSHTwqedJGVS6Eo5F3CklwfhT59+N+k/28nJOlOCS7IAhK7xTTiep7uRfSlmWFjCuJbzXIPQ74/+LPHAb8H2wYsLaJuRh35gw8MMPwI/15edHxV/U721EjVpfooBzwa6u8dwQO/atilHVQL0swYK4vIgxzbvAVFeey+Ez5S6KYclhnGc2IdBN4kba4QbRgAM8qorASV5afMiUkdk+dBx4IRlFwGgEHIudFSpedN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhWqrdfvN1pfV+D8MRfWfx6znRCarh2bL/A0jA25Q98=;
 b=coWCXlg0MjfRSjlmKUEFRCStrO8liQbMRd7MP8B+RE8yA0hskT1mJnfaLSwEigpapPyy8FoFgypNN33nCoPOMtJQ4Qu/T6JKgTFJFL2k/7Eeh17KC1iL9KJ+Y/SSxyAcllv9HwUxW2Chi7iMSnidfNqfn8patu8/pqy6DHRKc3fWhQhLbu6D8l1pb7APhGVjFJMIKfJ1hrmTyC7UGOb/ZqfURx700KZlKPCyREccpZ9pOzgykPdVcmUwOiflExjiazVtzuz1ovefXfUciEw55a+mZ4yM/ufwFVtTIpD2FnC9fIS5MRZ+gve4YTlajuUKue7efbxcPSrMcunK2aMiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhWqrdfvN1pfV+D8MRfWfx6znRCarh2bL/A0jA25Q98=;
 b=FtunMA17Ol/Btjy0dlpdmcapoZWwWXbGU7VFf5XBhXFABY2Xqy6qo0vOs9Q11lNaMoHQrKcNMnlnINPL+xzLdpgCCvYvzdmCJ/1xEQqlHWSAauV8J8jUaU3Ha5tzzGdwCZorHdC+mF5eYqWwc4Z4V2aoBACHsgMewE6D3EwV/6Q=
Received: from PH7PR10CA0006.namprd10.prod.outlook.com (2603:10b6:510:23d::25)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:52:23 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:23d:cafe::1d) by PH7PR10CA0006.outlook.office365.com
 (2603:10b6:510:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 15:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 15:52:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 10:52:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 10:52:20 -0500
Received: from [10.252.195.157] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 10:52:16 -0500
Message-ID: <7e35fcf9-9d87-4274-a189-fb1af4033e59@amd.com>
Date: Tue, 14 Jul 2026 21:22:16 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] KVM: nSVM: Sanitize nested DR6 using
 kvm_dr6_fixed()
To: "Nikunj A. Dadhania" <nikunj@amd.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-4-shivansh.dhiman@amd.com>
 <1532d3dd-3165-4209-81c8-c09c7049f537@amd.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <1532d3dd-3165-4209-81c8-c09c7049f537@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc71382-5923-43df-2e72-08dee1bfe4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	o5U8YPRU1QkYf+wd0Y7kOrb5M3WjjkXvSxLPlBEafaLiRtQQ7zxEd9Q4L3Q63tjAG7/Ee+WXcW9bKDliABIiIAdCXakLw0WrwrSCiKq96yImXzK6R1rx/5gaxD0PbZo495yRhgmau4XWUyYjXWptp/9Nwf544wrRI95oIy/oFHskOcpHrSVI2M4TEhgF8aBOP41Xczt5fPvF2mfqo3LC4RUFp2SMnQ5yP9Gask1KNlpYV9UQX2bgBIFbVD9pjddZh7nDQqebJg0hGOAAU+TGZ/0QKrmFhp88PdfzYBTZtN/nCX4UmwJ2RqfOUhFdOtQpHljsqGJI2RbM+gibsyCHYOL3rDTqlukr7P58PcCfinQi+nVueajpkJmr0XSSiUr7ZhAy7Lwh5u6+NlADVTc/J2Y7HMMYkjEqDy0CFkGbJOfetPWHP6xoXDAOcjuADxJNpoiDQWwnMCT+LGI8bHiF32TGayE6kZTq+D/N6hhfoBsJBN7HuwGaPBsEN+Q6/0RGkxHOpnsKJr7VAwESxbJ4jTQFjHtxuEyxwOHSWBHtT+G1VXqM/FEf2/OmT9O6ZNgqJXSx6cyNApoiu46qYsqPpiVae3blQ5pTEzsIuX77c1ZCpqJUJG/i94Aid0/kJIj1bIFlKScugD1gGzQg5qad707BejmgS791CrNAPvXFE6tGZj5dZRqzxtcZRfvO6OJZzqT3rKOAbCdLdLaoXiROWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jFEinrkh58oHdDFVuXq2YtuD7SsHxeRJPoTb/cAJh+BK/D6YWMOdL1Mdb5o/i8T49c43oS2cjADjTCzSWPf725PqxP18uuzeY7/msy+SAdhVWiaGDelPosLsiRy8OYrgx1D7sHGeoq256EyNDwilt6zGTSVMBCMdh1JbMxqI7W5MFnukJCCvcrnf2UX2YJjmER5876mUVErHG421JNOKr2Ef7mhlIz6g+KzEuYu+uGmrGzPssZ5lZ9+X3sg8vwUqmKqkfuEK4IHVl+VOP4wnK8a8CZT8bEYofKRQ/lv/X6ao5AW//8pQLsZ5y3pT2hNZZ9YIh2etCnOBvBnJ4SV626beZAJZq3l3cqGxA230Uo6SgtJxolZMm7yClScm4lE5aWCbkHG7/YkjqBy8CcobdhKfFqRt9G7sDXLL9EbUwk3NqWRxxwRw2X0MaYcp/Ice
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:52:22.6478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc71382-5923-43df-2e72-08dee1bfe4dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934



On 14-07-26 15:32, Nikunj A. Dadhania wrote:
> 
> 
> On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
>> When preparing vmcb02 for nested VMRUN, KVM ORs DR6_ACTIVE_LOW into the
>> guest DR6 to force the fixed bits to 1. DR6_ACTIVE_LOW forces bit 11
>> (DR6_BUS_LOCK) to 1 unconditionally.
> 
> It would help to state what breaks as a result when forcing DR6_BUS_LOCK
> to 1 unconditionally. 

Good point. DR6_BUS_LOCK is active-low (0 = bus lock detected), so forcing
it to 1 would prevent a BLD-capable L2 from ever observing a bus lock across
a nested VMRUN. I'll spell that out in v4.

Thanks.

> 
>>
>> Use kvm_dr6_fixed() instead, which forces DR6_RTM and DR6_BUS_LOCK based on
>> the guest's CPUID. DR6_RTM is a reserved bit on AMD and is thus always set
>> to 1. DR6_BUS_LOCK is left writable once the guest supports Bus Lock
>> Detect.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> 
> Regards
> Nikunj
> 

