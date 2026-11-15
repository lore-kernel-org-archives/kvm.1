Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794775073;
	b=AzhUmJX9eN/N/1ql78XLwSkCNq5n2XWM6ozmaZiwvHnFqscZ2O+H9gl09f9dXQObICAW
	 CcBU9CGabhMWYERgg+d+KE8JeQe9NxbJ3KB2ucTBZJMcEwbdQM+wBVf6ZFY9hjDKM08ge
	 te+gxWwIN0Zx6tiMBEOC9tRz2MMw0YSq/SyuRTOoK/ejGtAZoIFsLIocCsg0MzOqPfUQE
	 NSNped6xeGkmHVVSgjI6LtW1oTL185gKmkdrzSWyzFWPAROZOBHsREQiiZYUA1o4NUBNb
	 QDHJO8XHaCzGNWl7pr46+8Qd+PGPslslqHWmI7Rlmm2Swsg4u3qeiEDvcBNFOvDh+2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775073;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=LVYtYcZxzcbAr+S+l6FuZbx33KjeBYbiAqF4kLtn8DQ=;
	b=dR/HuTG1eBEs+YkYTZTkqg53zbETumJifB0Nu/gK1upiFcyHjJJ4YsqJL+ls7s0+I9Ci
	 CwcgBd9YqC9wv+4SuPX9xb17F6+2Tndwg5v76YsFjPS52p62Un+hAFeFVJ5fZmNUTgH3N
	 budKZ4q+2fteVBvbD21wYmW9qsExVrs0BHxgp8aH1mYKymO4X5r/SkTPquLP0gJBLdQaP
	 8mLT6uG0vP8/MYnbIJGBqp2TY2qd9cWNznQlsXUbgXruFRIn9wTYJ7GRlFX0jMtJXkAU0
	 7SvMjeAbL2KJeOkL3MjGzYfH0+pBQXh0F4IntTQrdHRMZdU0ssrAxRLwAQfeGRe+Uyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="nGd/75zQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.36
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018F606A33D
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E018F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nGd/75zQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlz+Pa3RVT+6OLCF3qHRMvHR6uSl36Zpn6ypXOv+1eAnA3MPPSo8SbQqMGsqGXwfGVv/6UCWVcrqWBw59gltEfufCEASFNYngiG/Fa3dLPuiQrTKZDqgT8kS2XNUjpIUVdd8KNjnJwrGwQofkqewJXAr4eB/XU4rmLXRWHvxbZfJRRIhS1x+XuxosajipRBllpQQLtAdX4BC9graoc2UtFvPKr1Z0GfytPIMMu23KqTW2g5hPk1S5yUCWUzOkOlGkc+AguWgTDCv4QhEPXED0ckr2hS3I7xK93n+dy9xI2OEQe4uk3m3RZvkG4viEDQNbvh7ByaGiVjBey0PtQd2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVYtYcZxzcbAr+S+l6FuZbx33KjeBYbiAqF4kLtn8DQ=;
 b=lQNeg914Bo3cH4ouvR+f3oYkNAZIdMDJPNc6ZaMdDmVgZcvkVDjWwNEDW1h94xSeNFEIQm9MN2L+NaoBHLBAEyb1gul6K4Gkgka/OYdeTfGzjqnQGwDJG3v2gfS7KFP1idkqedVYSt86J5D4TZzGjaPej1CMebVZBsR8Yu4fs6u5iYyRoBFwsyz9oUEZWcsfxtv5tbvGcbDPc2f5r53wk173k1mgEOD6xVS+ft9+zaitu5DEJiQK+BFhNLak+BerEb5MnuBZJ7885rxj71WFwhtlFIVXtU7G2ED/CvP1an4OR+Hen3KrGO1pfP9ToKg1YFIvFY3R3b3IUYQmycT97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVYtYcZxzcbAr+S+l6FuZbx33KjeBYbiAqF4kLtn8DQ=;
 b=nGd/75zQnHgZWwkwvlGU0lR7g9rpyNNztZr4nyouOYKcphj0g8+JjI90r8rrZ9xxvlkTW4xgShTWLkKOLqIdjUA1sboC3ymCc+czEerHIiTeQUIONksom9qagLg0CgoXTlOhjNCi8ezzZTCvAUrCbSf99/NCdPT1LlZq4lQTrrs=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 20:37:46 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::6d) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Sun, 15
 Nov 2026 20:37:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:37:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:37:45 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:37:41 -0600
Message-ID: <98cd8156-9fbc-4ca9-9de6-7d7b96be90e3@amd.com>
Date: Mon, 16 Nov 2026 02:07:40 +0530
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
Subject: Re: [PATCH v2 12/12] KVM: x86: Use SCATTERED_F() for PERFMON_V2
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-13-shivansh.dhiman@amd.com>
 <CALMp9eR-Vym2SkG=v-bY=sq1+MBd-=u4VqNZt12OmqmO5AX+3g@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eR-Vym2SkG=v-bY=sq1+MBd-=u4VqNZt12OmqmO5AX+3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: eae47a8a-9f20-4666-d6d1-08df43584e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AsKVTJ+rCUCBG+8or/7docaTljm8eQRA1+ZC1+OROoJrBaeWd3m9n+mI+jYqDvUMFZUOwm94tEP81s6UNIdcZorXvOz6V3nWvZKLGZo9QdoCE3Vjo+pJaPbtQTiV73TKtuslTKSa05dYd2B4XllChxWblDyTFNjL2eXcDzGp0OADR0iY68K1uHgvc/Wci9plUg3XTFLzFCQttAHNvgxXFcP0sewL5QiHPv3lt1/XQUls140d31YraIQ/LLLWayZ2XQv2az/A7qomnoeEhyo3wuS8q0CnCTWQ1YHIqblnPH9V023Z10Urpm1Nn0E76ZhVwjIikvTnWYOFWBMUq8Q3PCKcjnX6TEKfZaOk63/9OiJ8VMV0hg7fSNfL4m0F6TzEBcL9nAWcb6/dMRhE23HYPb3SB/tRXbGRZdwoFKmjXfngfuwq6IdhSFMuXnZTNu9gXDpKf/2yuXxoIjPGARAnxc1aZrAm5EtU5w0eGH7WKEKP3SQWz0aNCB1gmGbpN1RIqF7DuFdX2SNxLfYsWrDhyjrQ+w8tVhASrPT1wLCQWsMXr5wEfiD4LypX3dDmgpkIZGYbGZIbxdBDYvLX4daVAYqt4GwAobkZot7C2ydu5ik2qJD32cx9tTuLFVAIFuBVYaI/RCQBwGXQbi2D+ckpE8k8kv206tPq6sdo0N0gaQsRlnL/ZCPs7MeZF1clW6ESA/hs2ozty3D1nWvBgDZdaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CH2cO0WRMnU86L7U1VU3TRfsEm26RmPy5WXvwzMhYPrZcOF+RXNTyoH3XbRSEMGvRkc6Kn/0zXeVaj0uXvcYUtfeMKwS+4w/gke7vr6Aj0+KtA6DPZIUMG1A+WPo0ZKTdI3iA7xs2GZGHdk2A+tLCpGk4BwG/3ZuKB0B8BU8u+CdsH8H71HR7i8Vsd8BZqOLLZSNJloKrmiKiZaZjtW5Um2XvsMk1++VpbG2L07Osp4R1Tg2/lw5tx6sSMufEea+hJngQdugHnOkjeAqvCEQROL0ioTIynI0PrZ07yOJ/jl2kNX3LWijxf9oLU8y/ayIYu0OIXeJI1OB9jOcYaKvQ0qV+WO2MTUnGEHTwNWLPbFejxoC8hc8HS9+qRSHzRr3qxhUd44UIFhIrJITCrroLOmP3a24gTpAUQEG4lrzHLwb9dujcKeYf6eVTv6T3Nb5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:37:46.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae47a8a-9f20-4666-d6d1-08df43584e79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201



On 22-10-26 05:26, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:09 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> PERFMON_V2 is a scattered feature, so enumerate it with SCATTERED_F()
>> instead of F(). No functional change intended.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thanks for reviewing the series.
