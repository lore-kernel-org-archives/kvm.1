Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792851364;
	b=KAC40f5RPwRNnCyjtQKmqqhI0lLlayAtbFe0lmH4xCmPnhfr9TEN/KYwlfuMSG6JL8/H
	 io9K0xZz2aJm0vjzYtojLkTnYlgC+2UlTiiru7ElxERni/3jt+NYPpPeUTybgQ1mq6AgJ
	 ZnDL82ytc7Dtlr74ToNYHjviKclhSpHMW8SvWHxxabzwmVEZu0ihHoXlm+IrdF149lqcE
	 9CrK4f+JWigAMRm2NN9E6nFanh82Qxm/OXKyWKgDupANiwQKQ5gtwIFAkyVoWQgaGUz2H
	 R2BnvpfnTFDQGfBXzXKltvbEujXLbGnNaQEtTKHXtnjgQhR8A1PLPcAK2la48FoK+MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851364;
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
	bh=3++S7KvnRBZxvb6+qUd9N53TnsvSaCxmVASpHdOt91g=;
	b=yj8HlUpykDJM/MVn0WhwLG64jesLDbo0KySyDoJymHXfv6s8GDDaun5pD3nHnMBGXkBd
	 6IdxYmVuV1agDCCtbREJTQXAiVez8AZ7H3pTTbpC/ovo4uTUzyALwk2jsz0/r+YL76RkG
	 KC0OHYoQoyfyDEq+4c5QsuvshkR/7M0domwwi2UFoXtWXixZthwwZNxBot0JZ6NuKo/yD
	 KvsOphSAuK2m/fQEpjl8gksUbnmkrLDDq9VPGxu/3MmDJm1wn16l/vRAFamQlPSljJ/UR
	 3gLYWVkS0Ur+vcbkaZHE1mk/WpUGlusncTBuUcblsKcY5uZauHEpppyYuuthu4jpD/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=es7nHXoM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.51
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD98606A320
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 14:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD98606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=es7nHXoM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS30H384MLPOO0p+BwHpV80mnSH27Z+CSGDz5WIiyTZRvALjZfQQDAolvwegDA+ZsErvatnUXRsOjJ3Td49zyzc8EimkRpczZ4mt7P+9eAqyWKwyPdBEAQiTRgc9gE7gCIkXhlRj02VJMoB3QOXLleZe3ShJGzTaR2ECf6vokp1zNOOQB6f+PI2dw/V5LxOR1JfBCDlFmp3IF12B8kMWdAOuGkBilgLoBRiyyGlcLD0QvNtkPMIwRTP8oTSN00kkIPwRTlPrcAao2KaaLFZsPkJ3biDakF65h2dxNL4ygRjRF4Wc7pz+xbOzAINXGcqu0V6G/DAFwbCobnYKMRgEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3++S7KvnRBZxvb6+qUd9N53TnsvSaCxmVASpHdOt91g=;
 b=X1JTVATnUod21yKmNEXC0mLRX9bqPY9CAcr5iPgESCTQxBrnmWiQhGqg/Tej2XEMkNv5FpoXLewH8hYbD01vi8Uvn+/JgwkJHL3WbOwpg1bSkUWXLtjn7stSPgpzsTkYHhgJpPhChHv2LRYB1atgGgL+7EA/rYXRYesUOt+wiAyPTloKuHCSDIe3hj6o71LHhPtXHoL43HY4rKyyUBOsNgIXq1VhOJj+y66Zslt0K8v+98l65UafSlYatqizjziNU8xboZZatyknOTK4TW+dhNhZfSiU3Nutix5+HTzQdsG4cdX76JR/EQsDxs5/Dk3eJ8FdbAHwBH3VIsTlz5zsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++S7KvnRBZxvb6+qUd9N53TnsvSaCxmVASpHdOt91g=;
 b=es7nHXoMMNtYI0Qx/dZyyXftdUtRIXU+h1N5M1oukTrhJfORBhOmhwvDfeL0SRmsODwnof08HTvE9et6wX223+jzBtyn5MenAZDp+JWWWqwRVT8h+wqIXiFOOmygw13L0hpVqVUCe3IqxsNuDBYggVMp0j3B1GzNrtICjrrkG1Q=
Received: from DS7P220CA0109.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::6) by
 PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sat, 24 Oct
 2026 14:15:58 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:8:25d:cafe::3f) by DS7P220CA0109.outlook.office365.com
 (2603:10b6:8:25d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.20 via Frontend Transport; Sat,
 24 Oct 2026 14:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sat, 24 Oct 2026 14:15:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 24 Oct
 2026 09:15:57 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sat, 24 Oct 2026 09:15:53 -0500
Message-ID: <31211f5a-0a21-4f47-8b18-a1d03126b057@amd.com>
Date: Sat, 24 Oct 2026 19:45:51 +0530
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
Subject: Re: [PATCH v2 02/12] KVM: SVM: Add the LbrExtV2 CPUID feature bit
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-3-shivansh.dhiman@amd.com>
 <CALMp9eRJcoGe0PUUvC_S=i8vMbB0xw=LhCvwAYWwA1eqW-kEWA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eRJcoGe0PUUvC_S=i8vMbB0xw=LhCvwAYWwA1eqW-kEWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e87dc9-f367-4e94-8414-08df31d952f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|22082099003|18002099003|13003099007|10067099003|4143699003|11063799006|261009223027099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dTEJLhJh7wKzb6YebIpkVcDsQidVm0m4iudRVU1YHURXlycYpmAUrrHnwMZTyUPkSIPqRX2Nm9/KEDVCLvKTQRGMd55p7lnIISqRMlGsKgSeafUMVnO9LvP//L4vYdzajD9J2MKxHOKI55Q7UIHpMbgNJUeH9DYZC2Xhadz7uHBeYPMqi2e4+UE3i/IUWBi5/CD7Ox57pYUt6sXi35pI8suMORQ5KemoFEfdzOag/f8GFFq7rF0PYKQ3zJJyvZC/i23h86ndyZ2pyvQyHjQSxBG1aRO+Z8hnq/Ku7MrgIg1OBsxisBSfcvb4Qc4p0IDGE5xG3E/wu334lAsbBo7Nr6WQIgUgbqUNRkJYgtks/bUcrB7Txjf158MjI2HYn0hmfrd3D+J5CBu44/xU1S2E0epsS2tzsxsYkM68yyO+Wgf/wYsvpABnDBgYPEEL/42f/0ZJBmseIPiChvN7q+yfIRjf7RZsRD0aSDWHOpE9AmDnAnPUavEQKWvYI6ZBJAvVVVhpoB97qEzXISv+JzmjlfHZFez8SRuO74jLzZntfmZPxn2KLatxBAZozNrLIJWClxfW5NWdxXRBH8lmJbpIXfCyvYD33edYvLbgv+VxlOtEBzAhgB8MRgatD59eQyS7HBDPHUUOXtiRGwwtl5/3jsw54VWZrsAKhHOskEIPy7ovJMOH1pe3+VB1MxdwQvemWm7PvRb0N9LnJvA4Quzqew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(18002099003)(13003099007)(10067099003)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xgVJMtsPHrV3aaYF6MbT3Tv3nW6jtVNkC0VUCUJb7azOuaeldw5WnYXIFJmzPL06vkVlj40dizZOta1iOjMhSfh4yyD6BID9yFt0aXFB1bq9fNOvdLaWe6V/wlUTv9uDxcIYsdToqDTHuIRUZdL+8UYydZsffyk05IxKE4M4/0La4k/KhCFRxi532w0eFp/rCkdDWcpfo8rKQVtZm/HxUubqwLX/hkFFPISRsJyXxN/w8/HLfJ2t3MhH+fIpalEQfaswMYf7TsxVBoUFQc8HOc/7fMTNlx2oneDMTJK4OuSqGd2b3i8n0f4ZBxwl3Mk5f/kQV8hWur+KBRMyRmQdNSZ87lquufOtio7TmSRlpSmob5mG9+ukxT/SBzDTWrCU/2R5ZJEFsYpuq3LIYN7mJ6I/X1qqEr57f9DPH8s8xuJCTj8RDvpa685rKNe9qRbr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:15:57.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e87dc9-f367-4e94-8414-08df31d952f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823



On 20-10-26 03:45, Jim Mattson wrote:
> [You don't often get email from jmattson@google.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, Oct 19, 2026 at 2:06 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> From: Sandipan Das <sandipan.das@amd.com>
>>
>> Define the LbrExtV2 KVM feature (CPUID 0x80000022.EAX[1]), so that KVM
>> can track it in guest CPUID and advertise it to userspace.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thank you for the Reviewed-by tag.
