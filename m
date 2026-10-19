Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431820;
	b=SUiVgt7HRFY9YsxX3V0eOw+TFbfSWl1ksCD7l3yk3K9/QNeguo8qMA7VUGq20f/L8Moy
	 1e5fEvQE2/MKMen7mqV93uXlRm5bFVsZ33BPTLLphACwQZiBAhZGf0DJkU5fE9dsXEckB
	 eJBFRvd00CRFSLsB4iiVP4vROX37G5caw02EqjDsanLQykBprzZdR28fQb6kzJBfi/Kex
	 nPC2K7hc9K8uvweo2M7HSsQGYbCHbrSK/669xlKrTRolxUyHYlCYPMo8HiZvxu05UzYHY
	 YQFrB9sZIYIfuthTFb+m822U9MCwcgmMbC3Ib5CsPLGk4KpuWjNwnhDVZ++iieQKPgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431820;
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
	bh=lXe9q9iouONteK53u2yLZgzB1jv/TexuQqqwDAdXqow=;
	b=f+MwnOD7ZO48xYNisFIRawh8F7tpWgM7LIzzAXvYSmvVGwTVSY+1mPdgHrx5zaOFPp+C
	 p9F1M7h9mU5B5Xv1zTo+C/xbxwyWTgcxwXZ4/J6Rx6LRr3kaYFLbDL6ZPizcigTaDh9Gr
	 5nJCgv1w1W4AO7UKv1zMcYwgP2G4gMVDPGdh6drB+cTUJ2KnnOPt4Z49+Y9+IZEy38Ab0
	 GF5VCp3HCRvKjL3oKzOUZ3LAvRlEjFvpr2FhPjWyt2IHrQNcmiA/aOTN6A3jkGP5M6HsX
	 12NKis4GFHxeskd8pHFADJFB7c1cMHSaKFsVVYJmYuHBALAHjdKC08XvQkfDxdlze6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WSry3rfe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CC606A31D;
	Mon, 19 Oct 2026 17:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WSry3rfe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guPyfVucZLAEbUsKCE1siLXb/CSVI95oJJmREztLrne85ILAht8qs2K/8vru09jnDJk6qjTK6EbCtQFVhoJs+/d5OBwjzB295r+w59XjLOtenotyvgpYcyu/7dHJ/iytrxg8qUulIZ+bNTzQo2YMcCpDNQZkPHg0IA635ZEYM/cfQYuwQsLxcP9gRtWOYIjahHulH4wvu5YEwVT7dBCDiOPXZx6P7q5dxZheR6ER+yQHZaU2O+RgYGgYkt0YeU637BpjQFFhU2FCeLu9ys4lnar77zWK3Kf88vkdZSwLqfD4LhLxaBKcKxcnO0XDponznfkvDwRzbo000OJITWPL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXe9q9iouONteK53u2yLZgzB1jv/TexuQqqwDAdXqow=;
 b=zCDMDAqfqibqDKWT+b+SFikEd/kfNUr3GHIykmXW12e0RcKegWCf+QSUcNi13TZ/sXCd9aDYd3WcnBOYPDDAin4RNdYpJR2xovBfEMWQEx3o47ffUL2FXuu0CE5bgz7tZQ4WJKpqwQFkMIH2bjY04iWgqLp4DKis9dsfR3oQVzmuTdLHxcnFKlddhK8iu7vaXNqBE6aeGiHtXr0PQV1y+qo+f7mWxG/zUFPNhsmIcqQ5Mf05cA42et2fgo1e1CWpxQlOy43jkPAhKKJIripLZg3C5yhrpFF89QNAdD+qNJQYil+7xXpevPVH88iPaHg7KOyobDK5PArawXV8oluPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXe9q9iouONteK53u2yLZgzB1jv/TexuQqqwDAdXqow=;
 b=WSry3rfeEBglATX/ohUif9ERAWKMUZWD6TZ7guf/WWU0agmlx5GSIRXcVwvBT/8pY/cPV56TuAKEmLd31w//0ikX3Cl/rEDfkfiZKYD0GhgUWCI5JUhjbDR2pYhxBET1qieCQqBlTYG76Jq45QANqhStXvYoqaiqA8/yhL+PRPc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:43:37 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:43:37 +0000
Message-ID: <592ae38c-3e73-4940-9720-d23f396f83a3@amd.com>
Date: Mon, 19 Oct 2026 12:43:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/18] fs/resctrl: Reject mode changes for groups
 backing kernel mode
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
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
 <d0392cc08e4bf28998a4815943525a0461003801.1790867441.git.babu.moger@amd.com>
 <bf296951-e4bf-41f9-b12d-3c20930cbd21@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <bf296951-e4bf-41f9-b12d-3c20930cbd21@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:610:57::38) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1259b-d440-4bd9-1a8f-08df2e0880e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|18002099003|22082099003|10067099003|3023799007|260925022911599003|11063799006|4143699003|260925021311599003|260925021911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vuhaAgHEl/u6KaoO4Yibw24Mrgz6Qf4Oe9kZdl0pJFbLA0btkfnxWR0UUFs8HqvYrLyeKilV/67Y/uwBmfHx8/WyzJcfXLyB7jMT5S1jcIievriCJ5vVpqFV6SuihHz/0V/Bod9ST4KVQe/YkLepdKGGVmB65Y67l4nU6jL/f1KmnK3OjWfgnV9WX2hg9KMgkycKe4cRziW0rAL2DbuTpy31BO+DZ3n9E5jOf8g0ycNPy3PEbFR0umaDnpT+vE6V+4GM9LYHOykz3KwMvtT6KGuEeyo6G1lh6/h3UENn/rIaS07MY8BWb3Yb0bA54XkiJlDV0SA5+Nu7YNw8W/k8Yun/zfbFoF2auX9mIsFVTnatHwhgeC9BxBGufT8HESJfrYwiDCSsXCNvhRliDP1hfJYCQlFMbbXS3/7FAHebQFXbaU5P7uQf+lvIA9l88ZW5kbF7aWw+IzaptJztGywkAH4hy4jwRPghY59LQdoHPgRKts/e5CchMnW9WW8utsLdgDw0tiBAAI3EiQ7/Uf5HO2Jd+sYJbtG29CI928gJSmqv3QLh8Hn7NqsygaQpnKbmFnVkrAMhBXWn0QjeE0Lixj7BFGA8VKyYuO++9ArQ564=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(3023799007)(260925022911599003)(11063799006)(4143699003)(260925021311599003)(260925021911599003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRmcHhSS3RvemwyRzVoUlMxMjMzZ1ZnNmUyNW9LK1IyQzFWRWYrRUJMSXRI?=
 =?utf-8?B?MlpnMSsvaEpNRFJYWUQ5RTFZcDRaL1RGRHFyM3RtKzMzaUtLa3lSbmIzaFdS?=
 =?utf-8?B?Zm8veHFESkJKMXZPZ09wNldheXJmY2Q5QmtPKzNlZ080aU9jU3JyZmREcENY?=
 =?utf-8?B?UXBPT2VZYWRya0ZyNDBwVmdFT2pLaWNNZlcyNXQ0cUtNUkNqWTQ4cTBXNEZ1?=
 =?utf-8?B?b3NTL1Y3YTB4dkY3Sy96S1VJZElQTTJrQ3RQZ0t1aHVacGhzRkE1OGxCYVBa?=
 =?utf-8?B?dEU5RTBiL3JtbUVhU2FjbUN3UXIrOUIxS3dBNjlWN01OZkVNS091bWRzRE9C?=
 =?utf-8?B?elFleCtOb3YzK2gwY2g1R0JVd3N5Q2xqcTRrMzV6MVJvSEhYOTNTMjZYYlBO?=
 =?utf-8?B?WDRMcHZFZkhEREZJNktNMjZGbDFBRVhsOXdaL0pPaFZNNWUrRTdQNnA4aUV2?=
 =?utf-8?B?N1VRc2VGZFR6TlR1ODVZYXVwQjRNZktET1I4bElDUlp0c1JSK05BeWZlMlNh?=
 =?utf-8?B?VURMNFA2RFB5eXVBWElLNnBCQ2RKYkVTdDc5WXhiQUQreTZ6NDhoOGw4NXZi?=
 =?utf-8?B?NlFiRzVKYnBnbkVSSC9CTGZIY2k4TE5BRHVaVzNGNUNLeWIzaktlRkJBRGt6?=
 =?utf-8?B?ZlFCZWk4ZmR5SmFVUXNCeTM4RmQwaHJkVE5Rc1ppTUZkajdYNm1uYmFSNDJI?=
 =?utf-8?B?c0VSZnBsU3hlbi9WYUpjZytTUHFoS1Fab0NzbTRmWERYZXpaKzBqYnNlVlB0?=
 =?utf-8?B?K2daOXBZelpKZjdEMGhhRWNoNG5FdDI2eVJLUTg5ODhMU1o1KzNVMjc3QXpi?=
 =?utf-8?B?UmRqRGd3cW9FNVJLQjgzczZ0dUFUelQ5L09CTnNBZjBFeEFwWWVVK1M4VSs2?=
 =?utf-8?B?a0hMR0xRbzBBL3V4OVRNZi9NTnBueThSZThuZ3JsVmNYNU9MaENsYUlVaWp6?=
 =?utf-8?B?Q1JHQ2hpdFNsMGNjOTRDbktpbkZLOG55N3BhaW1vRWc4VVdxWW1MM2NJdmZa?=
 =?utf-8?B?Z1Nsc2t3N1ZXTHdidUgxM3RKcFl6ZHJ2L0lyUUo0Rk5RcG5GaFJoMmZTMURl?=
 =?utf-8?B?VkpoczlZOU9CRm95N0ZrNUVDcjVTZG1qSlVDYkRLK0tia3lXUWdzRE0wQm4z?=
 =?utf-8?B?cGZObElyVGo0UmlHSmV6c0FKSnFTLzIydmc2VFpBRWsvMUs5cE9aQUs0WkRG?=
 =?utf-8?B?aWZ6THRpK0pYTGtkVkR5TVdwS2lPbkM2VVAvTmhZRGR6SzRtYmFybUpTWTFQ?=
 =?utf-8?B?TFZLUHppaGVqNGQwV3ExL2JDd0QyNkZLTjZsYi91a0lhaWhseVhIVUd3eGcr?=
 =?utf-8?B?WU5NZHh6RkYyK3Q5UEc4VWxOeEM2VzVybzl3Rzhudm43d1RGYXdZdmdyUWpv?=
 =?utf-8?B?eUFMb3FxMGkxd0lZblh3WUI5WERHcG9YbUg0UDltSzVXMk5ieEhucjRkWnl4?=
 =?utf-8?B?YlBmN2RQRk8zQldNaXdHbWRyQS9jd2UwY1F3Tmxtd0hKcGNGWTBOUndrcWNv?=
 =?utf-8?B?emRJMFcvbG9rWHFkZ2s5bnBaMmtlLzVaZGZxRlBQbjV2a2JueUdsSUNjclJi?=
 =?utf-8?B?WGJnWGQzWjRHMWVnMW5HUVhnbWFYRk5wUEZ5MXg1TzJna2ROQVdHaE1YZ2Fp?=
 =?utf-8?B?dy8vejVPOU1pdHMvN0RjZ1ZDNHcvY0RhY0xLbFBETjB2T0pUa1NVQmVwejh4?=
 =?utf-8?B?enFxNWpoTkJsYnczQTVRclQ3OVZrdTdqUXNwaWtpeXJIdGljSGFKay94NU5m?=
 =?utf-8?B?emtEVE5sZ0w1RG5ZeXdiZk9VaGdOemp1M1dZZTVSUmRUb3dzNi8yTWszNi9E?=
 =?utf-8?B?YUJiOWNsSnpzaTN1UnRybzFKRURHMjJBN2Uxdkd0S08wcWs4MGk0bUlCMzV2?=
 =?utf-8?B?RmJKdW1WcUJFNVhGaDNRRW54TGRmd0lWOUFBblF2a3BJUXdEb2svOGJlS3FE?=
 =?utf-8?B?SzNNYzArdms4QUxDYmpvTnpuQUk2clprbWZCcitYOXhvZURiczJucTJvQmcv?=
 =?utf-8?B?aDFjZlY2bk1oZmNtMXhyNFh4cXhrWis5eFkzVDI3RU0ydVp5dWZnUFp0M1dI?=
 =?utf-8?B?OERvVzEwV2NNbHFxMjkwaFdMekN5MStycUh5cVNsSlNWdFJvdEM3WkFya2Vh?=
 =?utf-8?B?YXhXZVhWeXdWbmlpdFM0Lzd5c3BmWndkeE8yZkJnNjNQSFlGV3VSZTd4OVlt?=
 =?utf-8?B?Z2h4c1UvUC9qZ0NseGp5M3NBSFh5VTFPN2lyVDRydklxVTBoaVE1bFdNMUht?=
 =?utf-8?B?WDYzZ2E3M2JmV2kybXR0bi9mOXZSeTNicEJhN1RLTzU1TExKYjRCWWF3S3VQ?=
 =?utf-8?Q?OZaSREGX6p33YJVlWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1259b-d440-4bd9-1a8f-08df2e0880e5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:43:36.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGLfgm9awrfd9G//fTrUPESND2nWWMgd55KgPLlVqMupTwFmieGsOyHOsKYnyJTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439

Hi Reinette,

On 10/15/26 10:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode can be backed by only one
>> resource group at a time. The active kernel-mode association depends on
>> the group's mode and, for a monitor group, its parent control group.
> 
> I am not able to parse above. The second sentence is difficult to decipher.
> Apart from this it also assumes reader is familiar with how a group can
> back the global kernel mode but this is behavior that does not exist here.

Ack. Will re-write the changelog.

>> Prevent mode changes for a resource group that backs the active kernel
>> mode. Also prevent mode changes to the parent control group of a backing
>> monitor group, and prevent a backing monitor group from being moved to a
>> different parent. These restrictions ensure that the active kernel-mode
>> association remains valid and consistent.
> 
> "These restrictions ensure that the active kernel-mode association remains
> valid and consistent." could this be more specific?
> 
> This patch does two things:
> - prevent user from switching the mode of the resource group backing the
>    global per-CPU kernel mode. Why? The reason for this is never given and
>    there is only a hint in the *code* of the *next* patch that requires the
>    resource group to be shareable. The next changelog does not mention
>    this requirement either.
>    This is important to highlight since a resource group backing the global
>    kernel mode would have all its resource allocations shared by kernel work
>    done on behalf of *all* tasks. This makes it a clear requirement for this
>    group to be shareable and for its mode to never change.
>    This highlights that there is an ordering issue with the patches since this
>    series establishes the requirement after it enforces the requirement.

This check is only exercised when userspace attempts to activate the 
kernel mode, which is introduced in the next patch.  I can merge this 
change in the next patch.

> - prevent a monitor group backing global kernel mode from being moved to
>    another control group. Why should this be prevented? Could the global
>    kernel mode not just be reconfigured, just like when user space
>    provides it a new group? This is a design decision that is never motivated.

[1] There is no specific reason for preventing it. I just did not 
consider it a use case. Also, changing the parent of a backing monitor 
group affects both groups because the kernel resource allocation is 
moved from one group to another.

If there is a valid use case for supporting this, we could allow it and 
update the kernel mode association accordingly. What do you think?

> 
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: New patch to fix sashiko feedback.
>>      https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com
>> ---
>>   fs/resctrl/internal.h |  2 ++
>>   fs/resctrl/rdtgroup.c | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 6b8d14c4bd83..84238e9e8e15 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -462,6 +462,8 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>   void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
>>   			     bool show);
>>   
>> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp);
> 
> Does not look like this is needed, can this function just be static within fs/resctrl/rdtgroup.c?


Yes. The only issue is the build dependency. Since the function is 
declared static, it needs a caller in the same patch. One option is to 
merge this change with the next patch, which is where the function is 
first used.

> 
>> +
>>   int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
>>   
>>   int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 98451b417fe3..dcf9f26540d6 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1738,6 +1738,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>>   	return true;
>>   }
>>   
>> +/* True when @rdtgrp or one of its monitor groups backs the kernel mode. */
>> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdtgroup *child;
>> +
>> +	if (!resctrl_kmode.rdtgrp)
>> +		return false;
>> +
>> +	if (resctrl_kmode.rdtgrp == rdtgrp)
>> +		return true;
>> +
>> +	if (rdtgrp->type != RDTCTRL_GROUP)
>> +		return false;
>> +
>> +	list_for_each_entry(child, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>> +		if (child == resctrl_kmode.rdtgrp)
>> +			return true;
>> +
>> +	return false;
>> +}
>> +
>>   /*
>>    * rdtgroup_mode_write - Modify the resource group's mode
>>    */
>> @@ -1778,6 +1799,12 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>   		goto out;
>>   	}
>>   
>> +	if (rdtgroup_has_kmode_global(rdtgrp)) {
>> +		rdt_last_cmd_puts("Cannot change mode for kernel-mode assigned group\n");
> 
> The messages to user space also switch back and forth between kernel mode and kernel-mode.

Will change to  "kernel mode".

> 
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>>   	if (!strcmp(buf, "shareable")) {
>>   		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>   			ret = rdtgroup_locksetup_exit(rdtgrp);
>> @@ -4697,6 +4724,14 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>>   		goto out;
>>   	}
>>   
>> +	/* Reject moving to different parent if group backs kernel-mode */
> 
> Comment states the obvious. Could it instead state *why* this is rejected?

Same reason as in [1].

Thanks
Babu
