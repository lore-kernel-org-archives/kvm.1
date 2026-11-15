Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794775039;
	b=U9HI4nWyCbRRn3OGiyoK21W2AFQl09xmoIGSVjtRqsfogXUcISRKwbeaf1e78LryjpZi
	 4imjNfHIHU9bkuCAYTLTtmYhVc661CPts9CIWPBa0GmPoODa/PkdqKo7xdELIY0He86Zc
	 gGRDqjwSnkG9X/aZvjEbd3zJdWhYplEbNEPkCgAO+ZV0p7mwOHGRzWKoWD3ednGQ+oYdq
	 NTC6T1FU6xfLvsFJGE2T9L4NUJzAUp3arZBgBmvmeorJPSpWnCpa5Yj8hPjmTyH45N5qf
	 1i6Ps6yGzi3nYgwka3DTY6V2lVABU7RN1UKKzi9J9K3t5grx4bUWaBB/p9P+gAuCbUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775039;
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
	bh=3ieBNkzW6R4j8NMQVD9K8xpQAaWidLCAnKpFkeBCsuQ=;
	b=RPFJHJ+NJPF/QmsUAP7nQrk15iAvutlGFBpIBx9FijNOxHbhFG70+R2gliTx3apnwWpb
	 qot66MDGCKsVdJmV8wUU0XOf95D/WLNx0UmpCmf/n+1LfxNFChfoYQnvLqKa5LpQZjv0N
	 KamzGRxc3NBCblJJz1XwsFcG79HfEeQvYgmtjNHx/RcNxjQ1e0ghFpD/tJqoafyCKlbIn
	 r6J2yhgwVaYopVfwRWMHX4sGxElUrOlPZ/5zUVnwRyzcFJL2Ik6ODXd+VK6WOCma1XYS1
	 8RSlYsU8hDeTFOE//kRJMUgjtrS48sheb+3o0h0aTXcOyFAV/tP5+gdeU/yq7BGj7Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ri9gCStY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0A606A32F
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C0A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ri9gCStY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBXNvo97Az+tw2wMZA0nBsq3AUiUSyo3H32btBJTMacuBFjdCq+6DbgTsE43To5h/yu5Q9f8j4EkAl8XcpPkZNnDnmTg33ZhqDNLbHuXfXcZVyp3h0KmEflK1fRKCfoMa7e7dOrUCwQWxyxMQPE6kAzs8JUbnr1GKqx8P/exiMNSUJ/c1qczD33CsnN3evxFlRufI/0I7FJMzEBTtYNBtNi/21UBs6vfAqKV/gJf9FdY7IGd56/+miZD8GCzKslNUl9vq6E0SqGieMNzStOa5Er2Z0OEd4WKPtQ6zgETtPLKG/5gW9+DdT9XVaVzrc7x1l7syMU7/RP+7o1SOlzHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ieBNkzW6R4j8NMQVD9K8xpQAaWidLCAnKpFkeBCsuQ=;
 b=ATz0K/DcBVWkX/rbhLd9jGYQb72aEdRJK6RF+rZEE1lz78b0MyQ/PKgGZ98uBqe99dgeyMx8h93i39rMwPpS0j7UUfE+AWNmgZBU1jXsBCVQ2JTZeubpsxF2RIaQJBOqAuaaQAt1Etq0Rl7shBISnKTdbo3y96p0bI6kouagUzLejnRG9amJm3pG5ycbopX2pUPmmgAG+yPqviE/Fpb1Jndcfiba6rCLa+ql+/y4h6sIWiw1hEGxqGcmutfgYeYS+KnMMcalYRvm2Qo+Eyal7cX+b0QzuEekn4qi7PB+TVrOBEYJCAHm/y++kUUW/8wxsu4mJxqtmQ6K2RdIIk+Ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ieBNkzW6R4j8NMQVD9K8xpQAaWidLCAnKpFkeBCsuQ=;
 b=ri9gCStYbPGDU71YeBf5WrvL+Zm2psmj2OtRwltDjivyaMAixBoB5vh3GIfK9cSQKacx41DnM9ctJJWrOlMz+elfPbkEGut3sOjoAZWu2m0qg23HuBCnkFI0fSA7KmITiVAiIi4fX7lO+0o3eIEKTyokoc3uJG+Rp8vUqFs9Qco=
Received: from PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::7)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 20:37:14 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::c) by PH8P220CA0035.outlook.office365.com
 (2603:10b6:510:348::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 20:37:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 15 Nov 2026 20:37:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:37:13 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:37:08 -0600
Message-ID: <4b8f7476-8ea1-4ffb-81f9-2fba24799fe2@amd.com>
Date: Mon, 16 Nov 2026 02:07:07 +0530
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
Subject: Re: [PATCH v2 06/12] perf/x86: Expose the LBR stack depth via
 x86_pmu_capability
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-7-shivansh.dhiman@amd.com>
 <CALMp9eS3WAZ1LZt-s432qqxkrj6p+RNrS=aym3fx5rnR13tKAw@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eS3WAZ1LZt-s432qqxkrj6p+RNrS=aym3fx5rnR13tKAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: fa615a74-2b45-4751-9691-08df43583b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SzTAh38aviwWJAKLQtvoeXJx9nuQEry8Nje97ovXAiwhxfPrCC4C2U2JsSwiorY+nas0IqOkbyd756p9UxeFgk+dCSK7Qd7BytUOLHGuFB2iqPtCYZPL9eoRoTCFJp/nizDOjiFhuq6cuslVTpdlRcD4sDF0fEs5lyfUAhUdcAOIfwTxnLSnazDYYrT3DOTUfaw3UyZCC2J8L2dyX6DyjL79D3/fZih0RGTPwBPUkNGpN/AO4ZjjT84w+d/MlftnIFVK3YxvWJ0o/pmJLDSgdkPoULDzYcWAf7m8LtRQapEP3YvrEaj6HYai0GIUpRzBPtemhtnQmbQB31W2JXPX83AeEY09Lk6uM23b8vfw2lTysn8x26QElCBOCGDyMY0wQuCAHAbPDShgChifIp66fsMm0UCb2BVqPDIipFeYhPB/P/xUFB8MCsrZTk7IbZnReUyzOEhtlMVui8a7RlL2CCHpjdlXYh2BQAVUqtnq3Q6VBa0t2ksCbV3YQLdntA0yqDxGc6PgZTBAkA8t59MvKT71v+iPI+fZ7SkVT6z/J/mYu9Zh6PSNUlaPiRyhGc5wbWggXxGYxc0qqntsoaqtctzhg/NftYWkNDz89Qth6wKG+oO0jvKGg90t8+F0FAIjCDIasnHP2bPFdjdiaEgG2ZZvDpyENT+v8G78uHxkO72R6LvAIThMi50dh/67mrKzFsnSCNVPqkFYv4zsknChpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	byuT3wR9K4vGrV9HYsof3G2k0OR8D4tVhjMAuVDC05WCSJkIAPQZen0nKDadoPuQ40bbBptSGqBcNs5sZRmyXx5TAgZNsffcj60QdQh7ASxWkppWrdPMNNtZ7TCy9k6iWZb0MEC2eJcNiQB7nX4WqKi/A9bGF4/0fhq5mbiM10Op9iWX9nKUTSEYbW/RYT1cr2ORL4Gq9bZcLs5c6tMiRv9xdkpgdV0Dms8CqIw374RKS+tjVZ8kZQnPdA2WnjFe2TFOD82DKHyyxLM3zBBfyCO3OiBt60iUPVAIedskBoM+m/QyY7EmhB4byA7/sbDKazwnUErDg3mnqt+l1xhMlWmRKbW7/MTDjJCw2y6fImIjB/B5e11VJvFAkE1VCjdxULMG17usTmDg2zhr6npuHxBMnNTtLLn5jYCFn4HDralD/Dj/GYyqV1ROjky6eBqw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:37:13.7905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa615a74-2b45-4751-9691-08df43583b2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281



On 22-10-26 05:14, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:07 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> From: Sandipan Das <sandipan.das@amd.com>
>>
>> Report the host's LBR stack depth in x86_pmu_capability, so that KVM can
>> advertise the depth the hardware actually supports rather than assuming
>> a value.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thank you Jim. :)
