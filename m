Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774824;
	b=LkseKNjG7rfPNqZcDJXYzwDsXBGGoeMNyQN98fFhHZWgLsHibAmqp+OF9j9hXBynpI94
	 l5rbpn14h0FUW2xp+LJ5fNabYDyEC3dCV7WG45EFs6TD34rwlggrewEMONrytVstpWxTv
	 /VZAJt5pqkSMAgrZCdKBEWSGePwwA/uI51v7TB3TVMzZCM7fw6Jg697SbcNR3aVjtVZQl
	 9/ddMEKkrtpQzcdC1fhwh6bnyrrDux9UCSKPaBa3KPA6vokbucNvEe1rZkBVH9epPFKl+
	 pKq3b/UIC19D3S4eFnYqLLqX4bzIR96AEPTv00QmWvP6ObKdCPRuYSywC5/39q2bicA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774824;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TjDrlykA4TTJGVZow8ahpHxY2DmChUaT4OIUiCmnLgc=;
	b=h2m38sAyY6ZW22vr0LHlQBdCUhgpfLiqtzsYWOF8fqmalTN+0ycx+5gIqtsaobKbfQ59
	 HdgV2fbeZ6VcTaISq7KamyAHB5a+sDn1jB5SqsKbHWCCDJvUjX2AnapNr0NwgCbXU/1UX
	 HHeKUi/0w5F2ufUBE0z2p97+8JVaXvrj6pTQSO8Po1hVDMa71V24j9OT28ejFPomZBG2m
	 yr8RML/oROCqNlcUI54G8Cutv/WDunqBd9PSmysc6kHXqmQxJusN+fqnXWMhF3MJtlgL5
	 C8ry46ua2Mv54UCqxC1Rm4k7f5mF+pS3vYfhxOCQBFUiJUMRUHyq4qi0VVs84CzjHQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ieHqnps0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.26
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9027606A329
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9027606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ieHqnps0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kmi2O7OnEjgQxIDM9gyUdm/qYql0K5O/B8Jjupk2v8PQMhOAmCLrflTMt+0jZZr9iryU4c4T86G+csiGKbFEcw5ZPD8ZdQ7eEJorus6M5lPhlgKJKsrTb1mnV8IY+sB7ji5ihZhNa6RZ+TTxuhULYn+B95Cz+X7IsS6W7FWH+QQ+lZ6/y6D9PhSV8l/dfBEOiFUNo+8b22RfjQMSA+dl4povLv2jwCIt/bNKKR+RIsOiWBN5Td9KlmtFFXQJQ1JBzd7XMYczpFGiCira/nJf/iJHJ8igp1H6tKBga364fhqC4SO/fOG1c/AjU3nYFWsFJkPJxpCcAMKSwasCRjssYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjDrlykA4TTJGVZow8ahpHxY2DmChUaT4OIUiCmnLgc=;
 b=wNErpHLoaKyzFcqxI4OxYmh6K/5G914K2xYmFZS/037+aAT4IA7KWLOGjt7SBjERL1UiXzYvSVbM45t7qLwnkjKDLfblBu1DfQe8IoGQCPNPOjmP9YwEHFB5DaskYaK0aRqXv/pd5OLdzsVqIwlhP1LOzgHKN31rS16OkUOU8XSIeQ0q8khc+E3W8uZVUe2wLP/5ysZYEOh+c5tRSQVTxylOkIlCjyQSjeEaf/sR1v/gtYWHh58idVM1eiaOsKl9tq4rckBTX7Zdc6IM5t/L9/dZVQ7KjOoTjTj+tJawOhE7Uqfn11ldX5m7pdkkeoWKi7rYZWyASdNf72xDRoKY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjDrlykA4TTJGVZow8ahpHxY2DmChUaT4OIUiCmnLgc=;
 b=ieHqnps0uDOH9y8DNZquLU3XxGyaX5asP2NTLORMcgzH06J1W2owwC5KV/WlmAFKhC04ueS1YuYLhB6iOqc8CeMkgJFWeh+Ijvxq1jdIFLJwkWtwO4ZzZqqmC12AOlBqNP0OaGN6TXTpVwU+9Ey2u6yw+VWdlFSs4Zgm8dBeTfs=
Received: from BY3PR10CA0019.namprd10.prod.outlook.com (2603:10b6:a03:255::24)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Sun, 15 Nov 2026 20:33:39 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::ad) by BY3PR10CA0019.outlook.office365.com
 (2603:10b6:a03:255::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 20:33:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:33:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:33:38 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:33:38 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:33:34 -0600
Message-ID: <3ff9ea37-f70f-41a2-be3a-0af2c68c48b3@amd.com>
Date: Mon, 16 Nov 2026 02:03:28 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] KVM: SVM: Add support for AMD LBR Extension v2
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <CALMp9eRS8Pg1E76yeFYd5Cq6O9EGcj3LMLV4X6-54ozFamsNsA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eRS8Pg1E76yeFYd5Cq6O9EGcj3LMLV4X6-54ozFamsNsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b42560a-6d0c-4b0e-415f-08df4357bb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|10067099003|4143699003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4YgOJONTuYdLtn1eRkdqdLE1uOPJcgh7T5O5bA1VEgqdUKM2f6jOTg9WCTBCA5QZXU560NUEOdUfi6cri5Z1ldupOmVIDPYMR7SUG8FbUHqGVLWdPSrYuXUwzbcuGw+Hv0RzyN6Krcqn820ORekd0ouIz+9xmlPp8S8pKJ39pLrXWRycXrDd3TON89Ra28IqkSZSDAb35C7SOciEIXCY2xGKP5DTTAZUjFh1Tv6tq/Uq3oiB2D0F58v2gpy4N7alyEX8cxHG96bG3xTjA9BN5MbwW7k+9GbebH6tgLIUYXq3kng9z8eiX8l8rrPXFHDFYPt8yUp+rsXLkzmUdjgLZBK/zA43BxXCMPili/arNGBWnFLRYwjZBcoR4JpgdXkX0bOnzJYhpJ/5P57H8jIQzhZji+rAJF+DSk9j1oIlpoL7zaylyaO8ZMuD/JGbdALYr9p6IUjzMbhhBZF95453Aw5hntFvD2mbpU/HuyaaN3EM2RJ0lfakaKuyG8y4YRKNUt/Tmz93Jd0aV8Q2jet9em4+BZ9av/GgwNW47rN8THgn158dlb0k/AGCNScdkKZYF4B7M6ZmOe54Hv3x/LB/tegGWvMP90oEpqm0LI3kqvVhBkn0tK6C0VxJyNnp02ZFTRnTIL5ba6n2t0IHtikfrm1uIr6KmmHieVUZwQuxR/VLQKkqAnLvXJAdLHKFv9MImLwowgkymk2N5szP7CXMBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zy1Z/s0bcvCEFaq/NUajScw/rNWuVGxBFfNOKZU827SoKOHoaVOsq1bmpu3vlC9Fjl6YxA3XVDXTQ9Y7c2Y28hi9QmgPiNxh/BusFutVuNIAzspIwHGfdWbVds5QOv90uyQ0yZhyM7KIceCO4xGn0H8K5d0aOAZwEpxj3qh2fXidbDn1qM930YWdyxA7wPyqwzL30PhUHeTLHrI9/sYICWawA0DW0lTFjpOvkogHwjd7Yj3+7cqpisetDtvuumCQG7IWz2k77HPm8YwopH7IWwm3AZjLgM1oczeThRdssG0iTJWcHFdaVn5Fqm7Y0a27GBo6q22wvUI6xf3FwaRGtv8GlOr2VN0GAjIYfKzQL6LIpjKWCL1AA9oznYXsE9SbtUQtM3MsbaZQ6U8G5naVuUBXWVg4xaTRxpMX5/LpGZ8bR5cYR62kzkRNIW5OHXn4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:33:39.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b42560a-6d0c-4b0e-415f-08df4357bb25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022



On 21-10-26 00:53, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:06 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> This series adds SVM support for virtualizing AMD's Last Branch Record
>> Extension Version 2 (LbrExtV2) in KVM.
>>
>> Background
>> ----------
>> LbrExtV2, introduced on Zen 4, is a branch sampling facility. It records
>> the last taken branches in a 16-entry stack of dedicated MSRs:
>>   * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
>>   * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
>>   * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs
>>
>> AMD hardware extends the VMCB save area with fields for these MSRs. When
>> V_LBR (VMCB.MISC_CTL2.LBR_VIRTUALIZATION_ENABLE) is set, the CPU saves
>> and restores the guest's LbrExtV2 state on VMRUN/#VMEXIT. Thus, the
>> guest can use LBRv2 without interception.
> 
> Only DebugExtnCtl is actually swapped. APM vol. 2 (rev. 3.45), section
> 15.23.1, says:
> 
>> VMRUN only restores the guest state and #VMEXIT only saves the guest state of the LastBranchStackFromIp, LastBranchStackToIp and LastBranchStackSelect MSRs.
> 
> That is, the host's LBR stack and LBR_SELECT are simply lost on VMRUN,
> and the CPU doesn't put them back on #VMEXIT.
> 
> Isn't this already a problem today, before this series?
> 
> At the base commit, KVM sets V_LBR whenever the guest sets
> DEBUGCTL.LBR or DEBUGCTL.BUS_LOCK_DETECT, for vmcb02 whenever L1 sets
> V_LBR in vmcb12, and for all SEV-ES and SNP guests.
> 
> Since KVM knows nothing (yet) about the LBR stack fields in the VMCB,
> they are all zero. So, on Zen4 and later, a VMRUN with V_LBR set wipes
> out the LBR stack of an active host perf session and clears
> LBR_SELECT. DebugExtnCtl *is* restored on #VMEXIT, so the host resumes
> recording, but with no history and no hardware branch filter until
> perf next gets around to calling amd_pmu_lbr_enable_all().
> 
> AFAICT, this series doesn't address that issue.

For the new LBRv2 support, my understanding is that the mediated PMU
restores the host state. KVM exposes LbrExtV2 only with the mediated
PMU. After each #VMEXIT, perf_put_guest_context() schedules the host PMU
context in again. For an active host LBR event, this runs
amd_pmu_lbr_enable_all(), which writes LBR_SELECT and sets LBRV2EN
again. Thus, the host filter is back, and the host LBR stack starts
empty, as after a host context switch.

Is this correct, or am I missing something here?

