Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A641A8F
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391490; cv=fail; b=Pt2Pje+fm2mZcfAifA0gPTiBKMwBketgbMz3BdKfvW//kgArUK5CZl9caH7PTQmkgDkkd4KzAoKQDJXT3GF0C2WNKgtMxsXF5s3+AA1t1FGjgMSudhvyDBC8w5SWwhQb0OfxYEkdYro4UPPXQGK8aE55/1vk0ePU0fkikgJk/P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391490; c=relaxed/simple;
	bh=g2JCbR9fcLxu3T5H/Hcea0XWfVTqWV2W0A6r7EVpUKc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tYP8Ps1WMuoFN6GCq62w3OoTfy1y/ozmGwOFPm6HAu9HzXfw5YU2tBlTjyPc+dpVxTAcpMp1NBY6bdm24OxmS8U7w0HqQG2X+CNW8ySbMBiet+blxg7b43oA+qTSzfdgLNiqVcodX0fL/GrFHSB5i4Osgj2q+9bZaBKPhm8KFeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GZHi4OjD; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GZHi4OjD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne4mCYKIULu3MMiQS6LF9MymKbFarJF1uPs/6KC55pP5ZEDbR1sjDBUb3lGJSxdfpJk+frfudMsFklmm42Jc1wb1P7ztjTwthF9xg5dU0wK/S7Wd1zi3vJxxkAooVHnsT2HKE3oiFDP61DkS1L255E0i29W7Mi/7mBb9WUjvjb9zPWo3ICyFlCCCi6aavPNv4jBOWpxGEVnP3E8KMrAgyuWmGtmTsU6IaP4tUbx3DHKc44sZBta48llHJI5Ddj97rX2dAYlq56e+5TRm7JAB4jggYCXluvs34btJ06ovP/Zcn5N8ANLuvh/mhcqV3kfdFdQA2WfqiyFcI+YY/gbXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XP6VIzNaBGtGll6pgaz1vS6vUoblQBOBP1sYEhX2xI=;
 b=G+ewSpJ2va4eM1KotowVhnabWegxYXuq58kYA1O3x0i4eUFXvAvxF88QcjzhglhAoIkFiuTnQmyhMgf9YiMq3LvTyrQ5Zklwe9WY3CJoV6CH5NOj0zkD3iADXOgShD7PaCwtQnf7baH9rjbjBXogse6BvTLCApsnxRF5qiRfaZOFQ2SB+t8gdYI3uW0yBzBtFNfIX0IE9++sImEQp2MoD6g5wf8vHlTvtlJw/2f4msGJAJH2fO2zAKpkrGFAv6uwGP600j+qd1/ygGp0hPhnMDiW7/oSFngBZmrnUPotZxeTsD6WqYuvrsm0NpZNkFkO62cP9e8BDfrCjFTjdJm7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XP6VIzNaBGtGll6pgaz1vS6vUoblQBOBP1sYEhX2xI=;
 b=GZHi4OjDkXt9WFRhzgXOUeU2CDX7mqvEdIEoz7HfqIku2z21ccjIhuVhvAEJ3mk49rTtOS93+JMMytwsd0aHqicpjfk66tilLLWATuN2KAVm2sxF7quQubq2VaGzVhzcnvJimb9BfVaeb8ia8729+K44/45U643ngqgZJ/U43ys=
Received: from SJ0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:a03:3a0::13)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:31:24 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4a) by SJ0PR03CA0248.outlook.office365.com
 (2603:10b6:a03:3a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:31:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:31:23 +0000
Received: from [10.85.34.241] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:31:14 -0500
Message-ID: <543e1d66-9eb4-4dc4-a136-0723d7717c27@amd.com>
Date: Mon, 19 Oct 2026 12:01:12 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v5 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI
 wakeup when IRTE[IsRun] = 0
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-5-sarunkod@amd.com> <sashiko-outbox-172378@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-172378@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c2f770-ec0a-4f1f-25a0-08df2daa986e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	20eMdxltDhJXVh2qwzaTHhmdNCgV8ZOCQEqOqQl3sHRlu/q1YrxlSSBnxpXf5D/BQh0NFqPG5ieZyb/vXU8Bpx2LfjTVyWY/0pRdy7l0P7ON08jiAsiltKP+u4W8Js/COwYfab2iGi7rmzk+mpyRsPYK/l447MpuCIuEZIskSukZ0TXio3dbuan8MsTU+EnFAwfPQaH5EXi4YRVVfAWBhUxBZKW/N26NLrTyf5XzytWlCbh/lOChM49Ng9i/Zp1kgasG2qtGLb3alqwXIegqHKGlAgTas47K52cL2runXiodCBJ9spCmW1uRvQYijzAQEGsScyKjb29jWBUvMRHJsCMrv0yyz6O8X49t2/QUHGlsl5eZQMKmin6cGftTJfNEGH0XmYCPJzocdCRFQA7tge8k1Aw5mAP7EYtm4gEnrUsl1f1o5vDtqBOeCPW/r+vnttfWhS7T+dVhUjG5G5izgHDYax9hMF+Ma2kg2D+HbcnVEEEJVJ11c17kR0PhmeK+PFSOAv8eD4G7PM7qwACt19S/bD3e3tRcD1cmn34dri7tisZhtdrzGq3QD61CVIOxUCVNY03USdWbURGgGsvEDhrSSvR/nb9e0U/eq3eyeGmHti8dE1xFMxkj+Xxt2hZGcXeaqL6Z0h44PW84fHIjaMKP/DFYt0IVxD8glmScuhoxtyL7kknO1432MOVrQmcrirlSLHsjILPg6/wBav2+2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M5Iw+ukw5TcI8vv2AD1twvPI8Vp7ofucCNnNMz6fdjwMyjiM6TNQOXRW/Llv6CdNOQi6XqN2fOZEXNo1ECangvH1A9qAJZad50ZpxaTiP840PS95pud/J2JuIsu3fcpgMssgAdMidfv0rO1w8k3rDNKRaQOsDtrZKpgosTXnlegeIlCuJYlesdhkeQsbY/ryNPYmNZnl6jlEC0eDEObqFaHa7bHTTt8+xR3j3sivOO6j1VV5UbkYStra0jBaSgMOSuXOiXo4hE5G5G85FpkZIRyYiI4va+bBMXBkyzfaaJ5EROmYF240tenBXx8yH31FFqwiy58Rv7PHrueuQt89Ymob8Xo0MELBNcRhGBp1r/mo/QebYAmxBu6zy+H7RKH/ArVUH+bC3FLovHxP9eVeT0d20uTyqZ5BrJciwXkDAQ0l17pIkRi8E6UEPsPxdO1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:31:23.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c2f770-ec0a-4f1f-25a0-08df2daa986e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763



On 10/15/2026 12:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] iommu/amd: stale gappi_dis hardware flag in IRTE when is_running=true
> --
> 
> commit fed3ee87aa05f53cbc2ccd8dd9c45c2a8ad8bb44
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
> 
> This commit enables programming the IRTE for Guest APIC Physical Processor
> Interrupt (GAPPI) wakeup when a vCPU is not running. It allows suppressing
> these interrupts using the IRTE[GAPPIDis] bit when KVM does not request a
> wakeup interrupt.
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c0eec32ee3cb6..7ceb6bf508f03 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -4004,8 +4004,18 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
>>  		entry->lo.fields_vapic.is_run = true;
>>  		entry->lo.fields_vapic.ga_log_intr = false;
> 
> [Severity: Low]
> When a vCPU transitions to the running state, ga_log_intr is explicitly
> cleared here. Does gappi_dis also need to be cleared?
> 
> If a vCPU transitions to is_running=false with wakeup_intr=false, 
> gappi_dis can be set to 1 in the newly added else branch below. When the 
> vCPU transitions back to is_running=true, this code path is taken, but it 
> leaves the gappi_dis bit stale.
> 
> Could this cause unintended interrupt suppression or hardware state mismatches 
> if the IOMMU hardware evaluates the bit unexpectedly?
> 

The gappi_dis bit is evaluated only when is_run is false and is
otherwise ignored, hence it is safe to not assign gappi_dis=1 when vCPU
transitions to running state.

Thanks
Sairaj

>>  	} else {
>> -		entry->lo.fields_vapic.is_run = false;
>> -		entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
>> +		if (amd_iommu_gappi) {
>> +			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
>> +						check_feature2(FEATURE_GAPPIDISSUP);
>> +			entry->lo.fields_vapic.is_run = false;
>> +			entry->lo.fields_vapic.destination =
>> +						APICID_TO_IRTE_DEST_LO(apicid);
>> +			entry->hi.fields.destination =
>> +						APICID_TO_IRTE_DEST_HI(apicid);
>> +		} else {
>> +			entry->lo.fields_vapic.is_run = false;
>> +			entry->lo.fields_vapic.ga_log_intr = wakeup_intr;
>> +		}
>>  	}
>>  }
> 

