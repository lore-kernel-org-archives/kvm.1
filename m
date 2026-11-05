Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.93.198.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793860958;
	b=Y4CI7NlVBA6ZkzgibVwBmKnBM4wcntcFlcRmatBp4pHXlTRqtJVxtYQlC+BKIsL15RC7
	 R7tu6qB4uSnr+5fmELEKWH4MH78ma0SGNauNj+xUYrTrH+3e58QDcLHzSnySpTszsmnhM
	 F7ef2A2/QL1BG1qLKERIErwx/nH1v0Kykl5PDb9tgLuQogwjGLVrWKJZwLT6s+7tRs0vB
	 05RgvXjWTjvsM6ABjKVY/F+67fnw8McbD0QqkHxY7f6/jGRpWW22QkzTjoqlteFspV0qD
	 wtQlEI/c8gOnL610a47/gtuT0dEJ16gOPHRTs3fn+UJDKtkdQCJDXsimqQQtdGhTteQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860958;
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
	bh=X+ydjGjrAiMqxRjka6TiWrQ+X5IOxcw3pGdl0+qnv2I=;
	b=nqBY4YQQcGikIGXqAL3T5ZmcnRc7chePGHN9B0lmmVc1Hj/OCoW16pqw2RpYs6bNlCA1
	 jm0hqqjTHun4i7LB6Q08zrx77tESHvcnegc4X6clIRyaPkrTpB3XnrfVp/8ju6wMswC+F
	 4MWAZGtyjl94txjn+Au9IkdtsCOVK8EPKhOp9+A+y8A1bMgPmevs0L9bKSs93FyLFj08w
	 Z+C0ziIEzqpn3oWLgUPf1YyNxcnSWMT4Eexb0v7jHAtgSyyKBTZUfzswfQ7RMz13tEuKs
	 IFue+nIJKmDQcgSfI0DzxbWfrrivaV4i8wmFPkxVycSVQcLxnIBctGW+1vwaJ7cTj+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NWWCJLeJ;
	arc=fail smtp.remote-ip=40.93.198.63
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F8606D83E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 06:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11F8606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NWWCJLeJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlulcvTWz/Csuz5tIiH2rMyrmpi8CLDWrhJFq+G885e94/CLwHM75nby/UrzmGoI2jqiEhVGTw7nLv9cNktxG5eRTyAjO3OJFGc3ui6blaTl4jeSgNvy5c9jAELVslorA8aaEW9ssBoU0tILJsm76pzpyxpaJamrOtyrg3dc+rj1c1lQAcfLIjJS+O1Uq06T9/LULreXujNZlAtqMC2or8B//u+yzObF9OewIvGud44mvdJPUmqXEW7TFONUjAa1ITFEPZ1+uitlILVWuOtFw0bN2NZ4pcnFyq933hYlqOpUSRJxvIZlJUzn/waxzeVGy3FgKDqRM+P60gA5hDJ04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ydjGjrAiMqxRjka6TiWrQ+X5IOxcw3pGdl0+qnv2I=;
 b=vJgMPWcQaIOXZwmZL3sktdtkTSgZnqBVVxEQ3+wiB/OD+1jDMaA/WKpAPJl8OhhjexsMWwV4YLQm7rXBitPEstSNie61qtJktd4KFwGtyLPhXvqDV49r4//X+sxcgsR1BEbut9A9OxIAIr9XQE7Cy869NxxPHi5ry4J9NM6zfI96wowZPNnE/My/pMQovOgBBcJe2kxGgXfYpr6rldFkNfneABddcQdpmAgsxnT0o3w8O9OvEsVmh98VHLhxqYx1aU/GK+K0IjKaMJRUMPaHgyPwWWF8avDbXkFYQ0JKnvG+XN9OQrT4PZEytegrScfCdJ1v6sezKTt6EpkHzQc67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ydjGjrAiMqxRjka6TiWrQ+X5IOxcw3pGdl0+qnv2I=;
 b=NWWCJLeJtj/qF+FLreqKWlCrtwmxbdeo49K35eXWYj+VbbMJzZqIAemb3RtLlr65QI04apXLhmvwRTfLc3mP7fKSv1YMVC7f1Rbjz0Z8uaFdgW06V/OYizZcM+lZZjqlln8kvnMAmOj1nrBYKvTD9oWjzZtnKBYYGcxJpuNjPcA=
Received: from PH8P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::9)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 06:42:31 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:2d9:cafe::68) by PH8P220CA0037.outlook.office365.com
 (2603:10b6:510:2d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 06:42:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 06:42:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 00:42:30 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 00:42:24 -0600
Message-ID: <cc34f113-d67c-4c9d-875b-5f44ccc5c5ab@amd.com>
Date: Thu, 5 Nov 2026 12:12:18 +0530
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
Subject: Re: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-8-shivansh.dhiman@amd.com>
 <CALMp9eQmOcq0Edb6Txfe1NPASbY=3u=NSkQrVAbtqtecr6WWqA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eQmOcq0Edb6Txfe1NPASbY=3u=NSkQrVAbtqtecr6WWqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: cc339cb6-c2e4-489c-a4f7-08df3b07f712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|7416014|1800799024|82310400026|4143699003|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e0mWMSyDCV+Y0yA5j8wmNI4HhrbIh8xlZp61nRATAapvXfhkucIAX0bkqeWHBmUweVPWjDu0pEExyIWwewYojQFAFz/029lC7Uzw86WSuN07WdtMUayjXxphhtc0+BvuvrGPvXi5OdOcT7Upde0TlwcM8DBGL077uOR+kgX/LSEgNDitewq3BY+HhvqoYzo040WEe2bF8rBs+d2eBKwAgFJOxd5ywQfzcCaCK8bGL7OnFl+DsmfT1nedZkXNdoz4bvBCldV9+gPI/LXVjYeHMCDKbP1MIsuCT5LIL0nAmpwMlogBoQQTCN1ZrNWaWSdzypII9DOXdlpV7fo1iv2/BMgtqOryhpzyh3cnyTbxe2CctT3G/aeY4KOwjSUfcf7LQK71I9vfc2+qPoi1WPf50YcBBWgIaYpPMSNfa60Y44c7AyXp6cy7rzexCwwAiW2YMdBOM2CaVbzJeqUAA59AwiQT7+MvTg0b2DBUqBLV7m9nZ1cwdApsllfxkWosEb2b8N/tMVc+xyTMHvQb7JwYiAJQslLii+niGty7TZxq8axyOKjMz8UufrnhcePq0cdhKlAFQFMrUs4nYiuAB8v5t3EmswhDaP/8qKxe+AQvQ8wSCj9i2EfShsvyp3mE2Pw9ls3eAvmZ4d92iRhfMnfnIuQXlzA79dzGyJ3miZCv0QqUZruV+80mkIqMajUBwWzgsJpSerSghEW0Q2KwLTmdtw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(7416014)(1800799024)(82310400026)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aKU48CH1RUPOoKn+pppG8+tHHZTFpjdkm3UoeObv8QdxqMtbAqtVdinB0sjgcvdL0VOpS11NryNd+w/C5k0LXTqw0ppYBpGYsuqiJtsScKHIbHjmAXOuHFbSe4DsMfrL/t2ZDvM9NMSUGJohRJCLqkyqJKs3vV7SaL0bOmyqg9P2itb//aZjTi8tN7EWaQEPqJLR5O+Ff+QGVyZpkABvTMp70iE/+V6F0D8KCYTUK2YZMc9aXIv6mhXgtrI+koOFrSjKVJbyZTDjLVYDWGstsUCKF2r8KRKO/NHNRWDJNnfn22YnBjh7coZY4gW9+Bz1HMC+2xK25bGg7aTQyRNWCUYsHnyVo4nnQzWuDIUqEos5UUN7WWXhXUhfnwmtY7PI20spp/KBhCBH4GSgGublKzGAzxJV51aIlJnmFjlUK3JjTYIUMl0XyvnPXtxei6xp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:42:30.5071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc339cb6-c2e4-489c-a4f7-08df3b07f712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917



On 22-10-26 05:19, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:08 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Now that LBRv2 is fully virtualized, advertise it and report the LBR
>> stack depth in CPUID. Gate the advertisement on LBR virtualization, the
>> mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never exposes a
>> configuration it cannot faithfully virtualize.
>>
>> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
> 
> In addition to what Sashiko said, I think this needs to come after
> patch 08/12. Ortherwise, we can hit the KVM_BUG_ON(is_sev_es_guest) in
> __svm_disable_lbrv().

Makes sense. In next version, I will put this patch after the SEV-ES
patch. Thanks.

-Shivansh
