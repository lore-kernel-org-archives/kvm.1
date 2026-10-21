Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792598044;
	b=ncJg2XBQL4wGgLi+U/guZ1kf1vBqAayDcM06Cz7Ji0wChC8c6vNQXleRhUVyJMYiqhLM
	 fpTyD9Em52kLoUDxVJ0aabG4kB9x38FupRPQU+h9p10WN8a6DqkXzfQl+zJUhX3wIrttw
	 jjohc65SqmC6M4GuSl353FSaxDqvd2+m+jXwmkwcO8rKJg/a9+rIUr31nTXqWQyqFlOy1
	 dxvvcen8jRtY9NMuJhwfChWZJeWIXUMJ3iTRDWN1jN+6qvBOGw4epQ6WZL0VzRithMTQQ
	 KcxPg4tXYX5sNonRqvBx/Oek8p0xtxRnhvN9syZRkh0jsh0v1P4T+gsJrKNtuqPrNLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598044;
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
	bh=d5UE9BK1T+YfsrRPzvrvcrfUvx4D2jT066IRgRDoz4E=;
	b=cLjrQnlvwVhFYkn4qg4GhHsKtw5FqP6eLdjBMjcPe4wyEvT0MZlyzoGgNCdC5asycwNZ
	 TrqIINOYKBzcuw4UgXDXfEjk/3Dinq/UL/tyI+q6oGsjo42ll6Kyaizh6v4VLt9gxXhDY
	 sRBOhaFO/kDAkXf2v+gRjxl68XeMfqdqpPWNpkv80dCYJAcSn84aHFSZ3pmkBrCodrZ+p
	 AulcoGiWqZUL/JWpw9punwVaMAzcznpRb8uoQFVLtJ3gPcM4/kreeHJHgnNCldjY/Mda4
	 edWGgzPKh3HhvE80LNlHZRnxJsHRdCUbX8LlqP7deSoiDyj2xf53zMEKZkzJ9GiMpXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f1GDEqgn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.69
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA38606A32D;
	Wed, 21 Oct 2026 15:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA38606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f1GDEqgn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5pzkW7xDr0yZlC+pZ2kDbG1g0Xsb2PZYpWLv91bJ8xdtrxrAZ5lIlbKb0ib5idmFAIDUJB2FkIhfde7btmlOLYOxKuTERUFrjRftkA7X2quqa6r92jIILnBhqlpTzw6bWgE3w0YFolBoXV2DcK4DuOUKLCv1hz6HW6t3rgNprTD3XSH9TuA7C7joh3PxV2B6k/TX2NxCK25U3dgoRkvPBuS2FRTIgu2ZoK2kok+r8tJeJDF7pyWIQHoZ3Jcvo1G6RkXgiWP6VoKSpp8w90A24Sk6FQGMu2LqfSTpTfM+w3bnVF9iIgJkq0Zxt3qT+gM+QAdy6iCgbkeZvor1k46jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5UE9BK1T+YfsrRPzvrvcrfUvx4D2jT066IRgRDoz4E=;
 b=s0Ki8K0zAngLkZIXHYGRhIM1QymHsPdempxMvtSISSBWYut2PfgWIQj8Wu7aYXJNxSODJtRpwloitOo7YzPFw4/6SpFcTIpgKMGyU+Q55dCPMQyR29NnVSeKH9fORTnyXgno/0B+blA77AksdDuH1axnZnywcZIyTk0HlWrB753e+3aUywPJ5aYxvZxQqM0YwTsmhl+ByRTHGMFYsWh/snmV1dcrmIExBDKuFeDivRvFDnmgMKYIO+1e5qIQU5GrcidRtH3HttuTBaybmWzXD5Svbxuez3Dwtmw1tHrJvwQHvlWh885PtzNim9++oHxHqAGaqIvgJoKlGiHHUHNEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5UE9BK1T+YfsrRPzvrvcrfUvx4D2jT066IRgRDoz4E=;
 b=f1GDEqgnaasZ9K1rutPLJCFACswS+cnL8JE0+i2GsFOWYr+23mLU/rxGz4//MCGIe3/emtp3/QP1e8gdtjQtJbh9b/1NYc2uaivu7wQjwGmYVWQTWByfx7EtNN6oCWxbmPWTRLOBCqMF/uaViaW7xQtHNxg6JyuW7YvVUvxsdGk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:53:57 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:53:57 +0000
Message-ID: <d037d08c-ef44-4208-8db3-94dbf6e620f0@amd.com>
Date: Wed, 21 Oct 2026 10:53:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
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
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
 <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
 <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
 <8b10c05f-eb3c-4ce3-8580-1cb034ad4e18@intel.com>
 <c100cb3c-7d48-4bb3-b25b-0fce88de0561@amd.com>
 <61310642-1721-4b61-b9eb-cee60e6f35b9@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <61310642-1721-4b61-b9eb-cee60e6f35b9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::31) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 431acb67-7069-4f0c-7c73-08df2f8b8421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|5023799004|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/nvtOQbRExkRa2EGYMuOMzOAh62HoDLLnqWa2AsKlcei7R97gbfDm1E0ub6kNg5GJ5zr12l0XnnHVKBHI7iKOfHiAggH6HruJM3nocOvkpUzLsSC337fjs3cx0L1inWXjLIv9/hPdpGwtgzqr7V8TGOYuHUd271Nare7fcdYCuti1WurC0EkSXiLU0rIVTGQclAq/+PJ/TFvILaLAFzJF1uGQODG9LmPrua2ruPG3Y40rQXXQpO3mCOCE7RLfjxORZH2P/mUcaQzRrQfwXu7+FeSk/6R7l5T+lh0QizQMjwIwv4tkQcfgXQmr0NdLvjZ9XNmi51XI4Be7KBz1qiTyk8tAeSOPWjoZ9ljekVCOFBFTwHtg+C/W2n/pz6uapqvJoUaXAXMtIPYXW89nSAqg1hPrnIxCuG0pF29FEmGnKy7c3t7J6mDsAX/s6gyBrT/VtsRjWcs3GGzcBLhx6053BX8d3e6zW6fvf6Sw34PaVui6ANoAt8yXwzoFJSsfh4M7d5b+uwDE+J9mqUXXzZ1AgU8DO7nothDWvusoFJs6VNlSL+PddMEWckKoyGFnq8AwBwZ909+YGBrHHshu4ADJufU+1q6bhgmSYlhAFvBfrWl2bUWv6Pz2XsXrOzkyD9ZfpIY31FNSXHoXM67G7PuOfD91ICfEDnMYOWRIC7U0vc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0p4eTRIbUh0eVg2WFFYSS9WdnVwajVXc1cxUmU3SnczTzYwYVRaTUFZSnNM?=
 =?utf-8?B?ZEtCZUJxTzErc1RrWjlqYjZRZjg1OHNxWXUwaHNnU01KUWdIOEVWOGxkbFJY?=
 =?utf-8?B?Nm5OczA4V3E0UUhYNzgrTUlMRDBmaTMrU3ByelNLd1hTVDFFRlVTZGhEVFc1?=
 =?utf-8?B?Tm1XcmRJTUU1dkNsTXdMaVZ3OW9CZ1hNRzBzSXZUWEZQbE8yUlY1eElSMmVT?=
 =?utf-8?B?cnRyckQ0QlZDQVlJV0s4M2RSdEpSaVlDVjBGKzNTdEUxc3F3TTBOekRXd09B?=
 =?utf-8?B?MDVQcHdoQ3BSY1VqSmRKZVNVTTlZNEwrSjhqV05VY2VWdlI2TGEwZXB4TFky?=
 =?utf-8?B?S2dXVy9ieXowVGVDTktGejYxQkN1d0diTVB1VTJBTlJpQU54aWo2VUg1L252?=
 =?utf-8?B?QzdMblA2d1g2V1ZBLzgxRDJPVml1bit5cERxOVJMajBCbkNHNVdkT2hTVXY5?=
 =?utf-8?B?QmJZUUh2b2VUZzJ1Z1pPcGxEdmQxUURYendick1TZzl3ZlhpOW9KR0RyVUNv?=
 =?utf-8?B?ZmJSMzZSZnovTjNTOHdJZlN6NkFXOWFsS0lqYWR5ekdJV21GL3VOMEdjY0hp?=
 =?utf-8?B?b2Q0bzN0c3Nhb25PZHRDMWFqcEoxak1kclJwR01rL2U5cDVHckVGaW81b0c5?=
 =?utf-8?B?VjRPWVMvZmVNWkMvWStRNDUyKzIyK2ZxT0pxTWo3ZitxK0ZWOXI0NHVXUjA4?=
 =?utf-8?B?TE5nWTM3dXp3RVFpWEYrckVDVERxWHFDYTc0djkzOVQwcFFpNE1uaTA3d0dt?=
 =?utf-8?B?L1BBTjBQK3FKclQ5SENCVHBoVUIvK0ZtZHNBYnUvaGRrZTAzd3ZiT2dZM2V5?=
 =?utf-8?B?S0o2c0xWZ2lSNTczb05KVDAwdEM0dElRd2dLUU05MitscmEvVXJpVTRZdlJC?=
 =?utf-8?B?dW55SUpOdlNxWnFQMk5tUmowRlYwalVDbjdPa3E4NnpIYUdZdndYeU1iV1Ur?=
 =?utf-8?B?L2s0N0FETVRSaUQ0a2xRTDhuZERHcHdyYUgxeEttaUdCRkJoajZMellzdXpI?=
 =?utf-8?B?anJBM3AvclNRRng1K0pncldqL3BseWhNSnJ5SG5TcEZwRzF2SjllV1lXRUla?=
 =?utf-8?B?NHNqS21jako5MHgwSzJ4eG82dmw5dlRYTWZYWTFHMlliaVczZVZEWXdpK2hv?=
 =?utf-8?B?c2swR2JxTVFIMzZtNTNXczZYZmlKUGh0TFZnTnM3TVRXY2QzYkgvWUpCem51?=
 =?utf-8?B?OXVRZ3hLQUdiWnltKzBTYkNNRmRjbmxTK0JmT0Z3bjd1SkJGTVYyTGNzNXJN?=
 =?utf-8?B?Q2lPRDFjYkV1emkvUUZ5bVRVc0EwSEdmcFV1R2xCU1VXQTVpNmUvVjcyY1VK?=
 =?utf-8?B?M2l3TUV6cWluS2hTSTlxVkY2UHBWUVN3eTVXRjN1VHFYcXl3UjEyTnZVRFhW?=
 =?utf-8?B?dW8wTitIbVM4V0ZVcmxJbndscjkyNmJvS2RUc1pFUjhsUHBwRGxoZnRBSXE0?=
 =?utf-8?B?bEdqRG0xcGRsNFlKT0NSUTdBditGY01QekhrbURiRktFeWl6ZERqd3pNWWw2?=
 =?utf-8?B?LzhVQlhSZnZTUUR5UU1hajNGQlFkaFdvQ1VwN3BMNUt2eFBwbkZERDMwTURQ?=
 =?utf-8?B?OTdWcnhNYi8xakpZR01JeldvUnJqN3ZZQXdWcDVGcm1pZjNHMVFDVXRXempB?=
 =?utf-8?B?cy9QNE5UWUZGYW96enZjRm9vdzVoUHV1V0dibUZ1eXRhZTMxblJIUDNicEw2?=
 =?utf-8?B?L0hta3JUNm1xSWxpcnRWcUVpcUNyZzZ1SDErcFZRZjdURm9hNUp5Qk9XYVRn?=
 =?utf-8?B?a01ISnJIZ3JkOEJBeTBzVnh5alh4ZVNrTkNJekdMSFhVZGQ0UzZ3TEVvc09u?=
 =?utf-8?B?b2xuRTkxaW5HM2VtTXNZT1dnd3NoWkYyTlAxbnhOelBsNElJQTBoM3BvQkxk?=
 =?utf-8?B?Unh3eDh4RTZkZFNKUk9BMmRPQlMwbzkxVTZNVG10Smh3Q2E4UW1mTUdDeW5Y?=
 =?utf-8?B?eW9KM0dBV3NzL2xsd1BERi9DY1FNYUM3WWI3Yi8wU25IRWl4TkE3SGwvemo4?=
 =?utf-8?B?Z1QyUXJHYVhPRmhaVnVmYno1ZTVNOTlqbWZaTUZEKy9lZXl2VHNEVjhkR2U2?=
 =?utf-8?B?M3IrSzdib1hOUkxFR0FMYW1WcStIc0svelRJckFacTZHcjgxNGEvaVdYQ1dD?=
 =?utf-8?B?b2U4bmJDKzNUaWNUWlhmUnA3RXVvRi9MeEtCTzM3SEIrR3NKYW9mMFVnbUNw?=
 =?utf-8?B?NEZDVWxMUXBWV0NLRTZZZ1BGTkNXVFhpREVDd2lzMFNLREdYNk5hTXYxdzR2?=
 =?utf-8?B?Vmx0NjVEWStzbUx2Yk5XcTN4NTE0eWhNd3h0YUU5QmlBamNMeU1iZGx3Rmo5?=
 =?utf-8?Q?TEVSh4jTmTcItw5nt9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431acb67-7069-4f0c-7c73-08df2f8b8421
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:53:57.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PVrNkNOr4oBJqqgi2CqSx7f3DoCai2Czt+kg9f0yz9LAtuYaLkomjSCfcAt/+NY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D

Hi Reinette,

On 10/20/26 17:00, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/20/26 12:10 PM, Babu Moger wrote:
>> On 10/19/26 11:22, Reinette Chatre wrote:
>>> On 10/16/26 1:53 PM, Moger, Babu wrote:
>>>> On 10/15/2026 10:27 AM, Reinette Chatre wrote:
>>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>>> Some per-group resctrl files are only meaningful once a resource group
>>>>>> has an active kernel mode association.
>>>>>
>>>>> Could this elaborate more about how the files depend on the kernel mode
>>>>> and why they may not always be meaningful?
>>>>>
>>>>>>
>>>>>> Creating them only at activation would complicate group setup and
>>>>>
>>>>> Why would it complicate group setup and teardown? I think it would
>>>>> rather complicate mode activation and de-activation but since there is
>>>>> no detail about how this will complicate group setup it is difficult to
>>>>> compare. It is difficult to reason about a patch when the motivation is
>>>>> vague.
>>>>>
>>>>>> teardown, while exposing them on every group would show empty files
>>>>>
>>>>> "show empty files" - technically these files, as they are implemented,
>>>>> will not be empty but return errors
>>>>>
>>>>>> with no clear purpose.
>>>>>>
>>>>>> Add a hidden property to struct rftype to hide files at creation.
>>>>>
>>>>> Missing a "why".
>>>>> This can append to describe how this adds the foundational support in
>>>>> preparation for features to restore visibility when the feature's files
>>>>> need to be exposed to user space.
>>>>>
>>>>
>>>> Will rephrase the whole changelog:
>>>>
>>>> "Some per-group resctrl files are only applicable to resource groups
>>>> with an active kernel mode association. Accessing these files before a
>>>> kernel mode association is established would result in errors and does
>>>> not provide useful information.
>>>
>>> What does "and does not provide useful information" refer to? Does this
>>> mean that the errors are not useful?
>>
>> Hmm..  One more attempt:
>>
>> "Some per-group resctrl files are only applicable when a resource group has an active kernel mode association. Exposing these files before the mode is activated is not useful because they have no meaningful information to provide, while reporting errors on access offers little value. Dynamically creating and removing the files as associations are activated and deactivated would add complexity to the mode management path.
>>
>> Add a hidden property to struct rftype so the files can be created with the resource group and exposed only when applicable.
>>
>> This provides the infrastructure needed to control file visibility for future kernel-mode-specific resctrl interfaces."
>>
> I still find this motivation vague as it seems to aim to be generic when it requires to
> be specific since it is needed by the global per-CPU kernel mode support. Consider,
> for example, in comparison a changelog below that is specific to the problem that needs to
> be solved and why. Again this is an example that does not take into account the consistent
> terms that you aim to use in next version:
> 
>    fs/resctrl: Add support for hidden resource group files
> 
>    A resctrl file is visible to user space as soon as its resource group
>    directory is activated. A file can only be hidden after it has been created,
>    as is done for the info directory's BMEC event configuration files.
> 
>    In the global_enable_per_cpu kernel mode, kernel work running on CPUs where
>    the mode is active is allocated resources and/or monitored as part of a single
>    backing resource group. The files needed to display and modify the CPUs on
>    which this kernel mode is active are only meaningful in that group. Visible in
>    every resource group, the files would return errors when accessed in any group
>    other than the one backing the active kernel mode. Creating the files when the
>    kernel mode is activated, and removing them when it is deactivated, would add
>    failure paths to kernel mode activation that showing and hiding existing files
>    does not have.
> 
>    Allow a resource group file to be marked as hidden so that it is hidden when
>    created, before its directory is activated, and is never visible to user space
>    until resctrl restores its visibility. This provides the foundation in
>    preparation for kernel mode support that shows the kmode_cpus and
>    kmode_cpus_list files only in the resource group backing the active kernel
>    mode.
> 
Looks good.
Thanks,
Babu
