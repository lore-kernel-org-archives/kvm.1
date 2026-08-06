Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5F3803E1;
	Thu,  6 Aug 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047153; cv=fail; b=soD4G/uu3Rv/R6tNUtzOQS0quaXAEi97GrM5qF7XFEkYbTdosNLVSwXkTGSDI299CRerpd7o9HKSjE4AbOiWgADa4Fo47EbSe4fysNo39tdLhX+1pmrIJPRcDlObAIqpG657qOInp34kkB9RU99YgbYSpkrQxtH2x+U5o3NHEJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047153; c=relaxed/simple;
	bh=o3Yv+0trGrhJqcaaaURDlOUAZZi5l7k8utJN/7nwInk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N46KO0W+TRpASuEFYoXF0ExLZ6hM4m9WH4nWYNWsQtbpShnkGngaoyIt27ErtL9QCy+XdXCwIuw0X5mS1rv2jgu7Ov5JGvBPxpCiZA2ZRi96og7zKX5WoC9JNv0miJZBBc6QS3mUVDyoXBk1EXkiDMSXn0m6j0yTbn8LqJ+IK/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KO0mQ539; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KO0mQ539"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIlVO5Vnrd4wcMHGyNCSt8dyHEVjqOk8xAJ4VR6qIbz8qJSmXXHPD/Xooelp6bsoiT9CJ4zLUNYwbV083ihAZ7WTU36bfo/189DrBIdoLASjajCGwScivRn3DzWfWG/N3TSi3yPxgtCbJ3fjFJrT4SR2eHrD663ONF7oJid2AeK4+X7GKOyOLhKVjrSG1sfRMI7ijsh+7K6p8rqaC4G01vOyl7F0XY0sW4ou5yOtSu/8wyoCEZK/8jrJ4Dou4CLnFs27xAsaCNaLSb9XeifGahSWcE3golB2+5sxu5fWAjwcZfzoy+COEch6ESpYEYmAbcg6cwQ/brCJjmqygAPpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/IanVjsoJggUlzFbIk87j1puHqWtSkSDzcBf+lf7Wo=;
 b=XG6aJEmm0iIVUh9eu+Hq0FX9iqdbqP1O8bI2TvBERXgtEPefSZ7uDeja6F0J7AFay2Sc2KNU6vhk6YoFvImDEZnuu364bGz5kYnIHAbBHGeVzfjrseDHO+qwueCBox8iDOMG982CG5kQ6bfZvpu16LbruxQhQV1/rHCBgXViNcSqDc14eWfjB8+tRn9dvuESc00Qa8js/4GLF4pnBxsN0U94Z+Ou/wzZsr3hxrOyM8S/680MehgOA5W94xjDA4vTRDySGKLEM2CGpB2gHdkG8zCCwhTT9yopMyk8jJGsZpBZDfW22i+eTWg4hI9L4nzEqA0ZZ6amInNEDJcTxnqOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/IanVjsoJggUlzFbIk87j1puHqWtSkSDzcBf+lf7Wo=;
 b=KO0mQ539311PevXHyJZt8bB1NorVx+Wpte8jqkxErhu04vCa7rnekj69j66S/Y1upcOU0Jx8MBZVQ7AsWNcjZeu+QLGcMM2AgTkgZefc2cbame45zWPlk/biBfNWyAvM+r4OFHXaZgQusFPO/oI77244eUl4PwEjxN2EoXeDPiE=
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:12:20 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:12:19 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 15:12:18 -0500
Message-ID: <9e5183be-1f31-4f6a-8b91-0f9a92590241@amd.com>
Date: Thu, 6 Aug 2026 15:12:12 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] x86/bugs: Only log missing retpoline when it's
 actually the missing mitigation
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
 <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
 <65d82937-113d-405b-9399-b70973e84c50@amd.com>
 <20260805224907.GDanO942iYDbai1kFx@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260805224907.GDanO942iYDbai1kFx@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 35415ab7-2aba-460d-e508-08def3f704e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	tOuz27TOJV6BhgWcTYDkfWP7wU4N++cVEZgThw5k+eIE5/9Xs974pUidRKOTXLuzVHhwOUw7m3J0BgrJ++501HhPedYiyxhI+D4XQjjsN8cg4XR5DmNyuW+GBMZytAJkqH1t++HAHwAjnhgWg7kRK/tdKHZrHuhrroQja9rii9fjvO5PkhyNkeCRLDXNMT0A+mfWf118RyZHbc7ltfmJEM9LKCFwbmEUfiSxTlEs3b9l5IipAXC2dyjzcXnCfM2Kej//0Kd2CO0vPqMT5dXrewOgNc1se1guZSw8WUDvYEq4jiUd1UYvXpVzww5d8lujU/3HOy/y/i5nswZG6g8boFOLfmnxz/TPDW6oKmr4XTg99kEq3FmT0VLb5EHMz3KsV85XJRmavbLvBQ13qWRzgCpW74HMoPdEmLFKe7hbtA0grVa7/+vb1vdPFQvtyglyftiC9SDvZXj8yjLCk4l805lFSGWM9IwNVwBzbaCxwx4kZUiohPqPTzW9Zd72UoBGMMotaA/T7mOqidliTrE8EA/KNMupQ3c81osY7iJhwlz1DxOl3dqJXYRKadLijs1RTYcz3e9RK+fD5n3Q0ZA1FOLRE8kpRPRdcbpL8bdJhhrVOYnnQbHVSUN/f4Hen67ONpkkyd7HS4LKJKWjpKzTy27bpY3eKYeHcjqQjrrthUUsjU6ntOvoOHR6plihpmuunqlVwSsf8NYSbr+F8m4aTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PNsFpoNiut5SAOga6IiU81rveIDF4Jv2WSKQxP7jYOgVdQ+6KnN2SMUdamhcqIti2fRMKgvziJR/pEmc8A2uFNxhmnmqv8l7wtdMeoQcqZCmgDx1NfYDykZfg2VfvKdtg+h2c6XOn8XikKY2dwfMpfynTSGgxzZN7qEoUh1NToR2G+H1+yDxbLUvBE9siXbUGVR94AnXxLdLBL/nTEH4a7U/ZRChLkcTuang23+SUVkz1tpxleF1atR+IqoDGp6uDQG85hxjgk2JKs9ToNkusTsNWWJQSX7COmmhx7tz65X2A0CEnkQkz63kX0M0sJiFWGenhx42xGe1SJreEBdLCKkQRdiSMfCalTB/B9kwt9Tb8aR5vZhM6/uX+swEiLJhWSTZKliBSrc4giaPqi8n1hnmk4XJQm1qod//twgHeXl7RLCdZTSiI+mkaY71cK1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:12:19.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35415ab7-2aba-460d-e508-08def3f704e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On 8/5/26 5:49 PM, Borislav Petkov wrote:
> On Wed, Aug 05, 2026 at 09:51:11AM -0500, Kim Phillips wrote:
>> This patch corrects code that already cares about RETPOLINE=n kernels, but
>> it's also useful if you know all the target systems for a RETPOLINE=n config have
>> alternatives to RETPOLINE, such as {,e,Auto}IBRS.  This will become more and more
>> true as time goes by.
> Why would more and more configs become relevant which disable
> CONFIG_MITIGATION_RETPOLINE?
>
> What is the compelling use case which warrants to have this in the upstream
> kernel?
If by 'this' you mean this patch, it's because it fixes a bug with 
RETPOLINE=n kernels that sashiko found when reviewing the rest of the 
patches in the series.

If by 'this' you mean RETPOLINE=n configurability in general, this patch 
isn't adding or removing that.

Thanks,

Kim
