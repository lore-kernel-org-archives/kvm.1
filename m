Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792507580;
	b=SH4A36ZWyBtzteiYfPD1E6+DQsAfcSe8GxjsIYA0rYP7FZem76ADNDmMgJLS6Z7+VfyC
	 3djl2W0igQ8tr0Qbf/6SVVqNPQ4ocK8TPjjkhtqIeTdinMGkLgQrAIOqZC4opigU3HAGF
	 0M8NwY5NQIptwKcrIAT8AnbJCczEC7M+OUIyMNMngQAQC3xC1utWSgjuTZA/wzwDhtjpp
	 8Ik4xOGFCv94cH2LN5c8vgC0qI5MjHLigs8IUCCjKgYYaPiIv/4kaULHSUvgVGsW+2DnT
	 1yMpkqQjfWJobx4eYxRAgqLrkz6KhssabXK5yXH//7F9AAnzzCkEf1tKO60JBu1zq4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507580;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hZ+rp8DZTuYx1R/E3Kb6JrTNjeerHjEkKjHKl7Dv+Yw=;
	b=hx0rsFcB3BtEc9OA2BxkWzBKIL8TAKYknoJSpil7ZrD05uHhKIko4eHvpDWjz7N/RXP0
	 4aqrhtIh8PKfJi2hAwqNqH1tAi9vt0JuEL8sUt00IfD1fabGyeODv6y8bFOepfgN2fzAw
	 5gKFU7dISB76k4DLu301ceS7RMe9YZ74wv2U933089wdO0Y+CS63tUJ5z3SkFa+IA5+PG
	 HQZMdK+eLqG9jSWsizM/T+csS5k9woGV/31d48CkPv3tGHiLaxEexr+IZc7Wt+lpHffnp
	 rsXa/lC3CMNSyGp2AT1IybfslLtc47EUo35cUQSJFKaQ0ev8Uz0a9z4vUny6rVQ5TcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i4fmLzVk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.67
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F13606A325;
	Tue, 20 Oct 2026 14:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F13606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i4fmLzVk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN07TzQJ9HdSjTkB0zlk27mirb7cGO+2tIt+jc9zijmwimBsAXiFghOjW4BdXWpQ12B/ZHiRB/oaOzRlmEQnX97M6Xp84gn0ivFnxE92VUS0HIBvcpd+j9tp+J11fLNZEW/bQCgzqSHtY7x8W3oj/3PT4MCLwW0+KmJ4STecn/gR3ccXdhd4J2ENKEqyhhI7T6UE4vFQDUW1AtlHmyhARjbkn3VmTNqNXO2vLFHbXEz+mQPqLXZ9MGj152zBxR09UOv4OkLR+GkjwM5Px30+Qq2F32p8adsTZIxgExpEh52b+07AG00YiBvc4fYMp7Q+Dhr0vWHy2eSlLcY0UT4YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ+rp8DZTuYx1R/E3Kb6JrTNjeerHjEkKjHKl7Dv+Yw=;
 b=K6Iu9KXJmw4w1qNg47exb9ssi6wGntIXrQGbUFaLghZqUOTpTSzDOBxYrn3KLuNrn7smS3IyGrozOQPyRTi2yis9NguK150BSK7031VVnDeqhB69qkhIqOvk7ofqMfmFt98PIWyGJchxfy+dViFDXJuNjxmuFs9p6QTKuQBDA2qs8u6dqkXUtmUw2OaY0ApAzkkoBNsTGc2rPpZk1tSQFBAPQcYxuno8K2CezB3ah7H0KegJHXJPagBDGn5M4RIvsKkQ05Gmdgog/zSbaezq/p7xJ0ZVa1TbYmAeRIn8cx0OW2sgCNa9rfYkBSuSipUpAfjg4syxnE3Nyg09+Ca4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ+rp8DZTuYx1R/E3Kb6JrTNjeerHjEkKjHKl7Dv+Yw=;
 b=i4fmLzVkZKf9ymIZ8Ez3PQ77vTm3n/QIjSKFaDsonT8fgeb49jgaVlfIm2+hcB6HZ7NKwGVmZc/TyoHLDjhP8gl1JJ3RPISGWMiJHn/GjkgY6g8dEyQI6EBOVPWuEu2huf+ltmM1ktMkbMkHsXlQJHm+Ate4pI+rqcIJs4jHH0A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:46:13 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:46:13 +0000
Message-ID: <298842df-a86e-4e9e-a867-1cfa6c10fc1e@amd.com>
Date: Tue, 20 Oct 2026 09:46:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/18] fs/resctrl: Introduce
 resctrl_set_kmode_support() to register supported modes
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <50333925a56037a0ea82c49f25e76be6271d299a.1790867441.git.babu.moger@amd.com>
 <0b633c57-2938-42c9-a6ed-863d88d2be63@intel.com>
 <e2bff854-eda3-46c1-9ecc-c1aab1e7b33e@amd.com>
 <e9d9e870-18e8-4e6d-bf24-dd782837a11d@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <e9d9e870-18e8-4e6d-bf24-dd782837a11d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:610:58::11) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8b3660-f0d5-4fbe-6686-08df2eb8e33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RY+/GzuMDl6VUfanusjfu1tjL272fDM9hJoVXzC2QYVE+QWWE/tmyZ1SfAnKqcx26CrSIeJv+MiYPbkPRZiVEtLThBSwLodP3FjGfdY30GAZxG1epl8xHzljLmDryT1JI3v439RnrEgM3dt5DEF2zgl9tx5X+r2gFM5HCjHFW42LLxgv1XIw5MisjbycLwmqsV9xgg0YVTpGbGRoKD0AsZgLgX6l7MF6P2XFojTK3InO+fiNEhE/bMSqyQGfCAgYrSCZbGBeOHDy30RXxPbkuhhGNs8qqDg7aqSPVuXlr12bg6rMM7clgnHgiHtWFAbXvr3aq9K1KzY/HbvQIHGpR3dXnDriBA7iUBMgTjGZ65zZp7v2MfseUCA6Cm8l++w8mLI97W/vw6hPJzYfJsXrR5mPnYAG/o1E0OmA0UKtAvG3Yo0XtxQI3ecUXtBpjtidpLza9IvnDCJMkNuDmfkwMoBJWAtgogRrm1V0opv11hwIo8oHNeYVyaQa22HIOW3i2+yhKCOzAIQvzYD0JnKPTSCEoORfqY3VvK6BQrt8POyEUlMP7pTARuHemrkFUIXM8kutsCOYSerlkt9dVMYsWEXNkz2p7zqD7yZv10mqdDO2T2UzOuID9CAdJ7pINB/ZBOIUXMorLxS3NUU4xIzAExyLSv0SOqp07/3BTt/B3yg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXZCQ2huWGtOT3ZyTExXZjh5dGE1QTYyMkpBZ2FDMUVuR2c5dWxNKzRmSFFZ?=
 =?utf-8?B?bDRmZ2Y2TG5XbVVpSlVNVUkwaWdna05DVUZVcnNlOU1wR0pLQjd1aUM3aVJm?=
 =?utf-8?B?a3BHaUVNdnJwMURJdlBHMVh2WVozUk1pbW93aWNGZThrZVk4bGhhb1pqM29Q?=
 =?utf-8?B?NGVjbEJRUDFUYnovYW5hamRGWU5TdEVVaEJqZ0RNVEY3QndCNEVBTmd3akFX?=
 =?utf-8?B?NXp1NStoZWdUTFV3Q0FaQklQaTJBbWJMNlYzb0g1TmsrTWUxdmMzZGpjbWNE?=
 =?utf-8?B?RnBEYzRPRVdPWDR3ZE5PR1UxTW5iK054SzdiR0NIYi9kYWZ3MHV3Z0xKYUVl?=
 =?utf-8?B?OG12Tm45RzcrcGVtL3VqRlVXZ05ldCtORHNCbEpaL3YxYXNOVTZ1dERqR3J3?=
 =?utf-8?B?K3ljSXJZMXhoTVhhQW1mZDdFVDlWakRqQW84WlVYWkJpbnh0RVgwY2ZyODFB?=
 =?utf-8?B?ZEsyTVdHQVU0NGwrVmt6a01oU20yS3BRUi8wbFZwNnBGWVFQVjJTL0lCdHpE?=
 =?utf-8?B?ZnNOUU1IM3ZyU2xrV2hyY1krTVVHUENpdkdiaFZNNFd3RXAwMHc1RlZlRDIx?=
 =?utf-8?B?KzJtcVBRYXk2UFhJdFYvbTdUZkFkNVVEbnFmaklhblJEZFdHZngyZU9MVUZ1?=
 =?utf-8?B?S3NzbFNmUms2aEp3UUZnRDkxVitiYmluWEV3M2kyTFYvdjYwV1N3ODI0VXJU?=
 =?utf-8?B?RVovMUhvOHVicnFrZDRsL3UxQUZPVGFycGFIRmlOK0ppdk5MQW01aHJMQnpa?=
 =?utf-8?B?NXVQWXRFZ0ZYZE5VTU1KemJodHJpQlhKU1pRdzZWbGVCTk9Vd3NNU2Y1MTNN?=
 =?utf-8?B?eUIvdmF5b2dwN3E4MmtQMEZTZWRZY0NWZFB3SmhhLzl2Y3pvVlYzWnhNVi9v?=
 =?utf-8?B?QkpzWC9pbGMrNEZzYW91dnhPazFJRWJ6VlZQQkM5L0Z2djdMdDMzcnVXZnNU?=
 =?utf-8?B?OG9zeTV0cVJLMThYK2p3RnQvV2E5Tmg4a2owMUFqdFo1YlZjcHE2T05nMVRK?=
 =?utf-8?B?K1dpRFNFODFGdXRyT1lKS1BjZ21wY08rZHVHb3NCSUV4MVdGTVNLVit1dWs5?=
 =?utf-8?B?Z1Y4ZXN6MTkzMnNuVk1zMi92TkdYUGRVcWtmeTNVMjRmY0luTVZxSDZoTWZQ?=
 =?utf-8?B?SURjb1FIL3dCWnhucFpqNUVLNk5XZUlwZUN4RTBUeE5UVkVDRWs4MUliVXRP?=
 =?utf-8?B?NFpyajNCQXNlZm8xdVR0bEZQV3p0RWJmbk5DQ2pCRFBLdWVCbUt3cjkzeE1j?=
 =?utf-8?B?VWtaQzNuWmkzSkllc2NGdWlSRTdYVjQzZXg1a1N4MVBzVEg4b2ZHWHlYQU1m?=
 =?utf-8?B?WXVuU1hhV2JiN0dCaEJvOFlNMGdpcWNWVStSZDh0TElZNXpZeDc2VWJFVHFX?=
 =?utf-8?B?RUNyeitaZzVvZFBRWFV0SFZzTEh0NG9rQ1BSY2hJNEh0RmUyeHNuYWFaZFVE?=
 =?utf-8?B?WXZ6MWFKSzBZNzhzaS94Mms1dlRLZytrUVdQYmd2YThISHltY09Samh6bDZM?=
 =?utf-8?B?WWk2dWJGenBJbzArVmlQTTYwUzlETnVub2lReE00S1M1UkpSTzcrV2Y1WkJ5?=
 =?utf-8?B?bVNEaDFVSE1iQklmOVcyUFozUVB6QnhSeG9pZUMyRzBUYndEQ3lZeU5sRU9n?=
 =?utf-8?B?MUljR0RDZnNVdEdna3lnckMvbmM4SURYV2dIVUJoVnpLM3o3WlZZck5ydlRq?=
 =?utf-8?B?ejVjOHVvb01UQm9weFZsOS9ZVHh4b0tSQ1h4SG1NNGJDVXYwTjFtaUNNdXRh?=
 =?utf-8?B?a1pMak1senl2ZEtER2ZyVWlOYkQ1N08yWm9nSkhIOTdqbzh4NGl3OVRtaCtr?=
 =?utf-8?B?dW1vQmFsd1IvWmlhZU02T0ZYV3EzLytEeUNWVCtrSTNZcXQzd2VoUUE5b2Jy?=
 =?utf-8?B?Zk1qbE4zc01jVmZUVmZJaXlUTVlrYVVTdVdVKzRJaFZxS3EzMUNKcFN3eHhN?=
 =?utf-8?B?ZFlPZVFCN2FyWVF4Ylp6VDFKWFFBSW5GbmtZWnlIVmJ6dEtJOWdoRE1GV1g3?=
 =?utf-8?B?ekhqYnordkhPUXVwc1pOQnZ5WjJFN2MyWFQxdFZYbDdjKzFXOGgwV0xvNGo1?=
 =?utf-8?B?MWFCcGs2emZTNU00aUg1ZUF2eXZWODRZcS8yWU5tMWwzUnpPSDVYT3RQWUZB?=
 =?utf-8?B?WmdCanA4R2JYY2IyT2lOT3RxU084bVk3VjRKb0xPZ2RvVm1keFB0MnlXNXFN?=
 =?utf-8?B?alZQU1N0aTNtRmkvSmpSKzA0KzN5eFpYVC95SVlHMVBsU1VVM0NsbFNLNkI2?=
 =?utf-8?B?VlJ3SEpZdWpQMXVzeVFOQXhBcTFabnRDMm9BRG0vb0NxVGY0dGZMdDNtTGh5?=
 =?utf-8?Q?a/4Ni5kzBHn9ksiXqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b3660-f0d5-4fbe-6686-08df2eb8e33f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:46:13.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90AeMTmQfZjnsTVMrTOVPEMcPddqZVuZuoDs8z7WW88d3wyqMQfRwKKIBnZPvsVz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

Hi Reinette,

On 10/19/26 11:19, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/26 8:27 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 10/15/2026 9:40 AM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> The resctrl subsystem tracks kernel mode configuration. Architectures need
>>>
>>> resctrl tracks nothing at this point. This is preparatory work to enable resctrl
>>> to do so.
>>
>> Yes. That is correct. Hope this looks ok.
>>
>> Architectures may support different kernel modes that need to be
>> exposed to resctrl.
> 
> nit: "need to be exposed to user space via resctrl filesystem."?

Sure.>
>>
>> Add resctrl_set_kmode_support() to allow an architecture to register
>> its supported kernel modes. This is preparatory infrastructure for
>> future kernel mode support in resctrl.
>>
> 
> Looks good, thank you.
>
Thanks,
Babu

