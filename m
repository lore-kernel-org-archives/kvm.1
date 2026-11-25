Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638598;
	b=rwe9dd5vgT3n7/mM9Ok5yd9Fuqer4a+wfpcgJHswrk/rmMILqFvrocskOYfB7eiG4rEI
	 i55y7tDt5VGy2+YoPB4aMv/HRbhBq+4Tb8hFXdR1yS/Ako2aVnZZBo8HdnaM1ZluTYhkP
	 eC3k0g0pX2oPJJGCnhOTCDonB6AkQBf07UmyE/5tZNy7F6vhxc5+eqMCtYNE/uOmdkrIV
	 J20cShGEVBvqb22eu1oThQgk9SDyzfYMCDHz0UvkgPFe86W0cbm+GpXrf/nfzVEJl7MtJ
	 qsEe8CzFwGAC0SI8cTVXcKmnMjixkHv3N/+qvLryy8AckyfFpCQP6jdnKyWchRYrUmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638598;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=9wWkdyvBd++j7QqvX1GLOfvuAN0d4ZfUz//q7FpdJvs=;
	b=XWRBMXrVUA1YoKBwEUN/IrMt9Muwt7B5MYAwmHhXAbs9jT7NQfBHBEhmGi2sUgbEUK3l
	 251YKWMg9co9GDvd8zOd969JFT9SlwGDHHwwrvuE5AMkMW9JnG6UtL3IpwWR9cwB+Jul8
	 vbg8XJdoqmW40zox9imF5S+xoYG9p8BHaGgxv8gA2GEnLdhA3cCvLs2H8WzqInrt84PGw
	 63y4dv8Xw1i+KzxbkeF41VJGpS5iTvZxoH9ZwroqUhUydQdfbI4izn4vFZwRvMIQkH+ta
	 ZYoZJ+lrPG8dTi845lORYl0RcWFzs4xlacJu3jIqNGg8oJ95PSyYgdvQOUSlkbNxphA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mKhmKIAm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59524606A321;
	Wed, 25 Nov 2026 20:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59524606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mKhmKIAm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUpPzteQ4Q9Mil4usSbosEUTdQYYJhxOR1w2swofVv+SOk00UCr8hOIOfh8kudOOjy4VRL9LrRCZBUp3XC/TKLuNxjFS3Pcq8HW8sEjV9CsVkymEH0al5tLdSXFljvZArA4iK0rw9a6PwlRjDqlwNPjU64dEQA8DSW915q4UL3Rc9QUsLfPqR0GaFqrPjS425YaWoz+h21XH06H/fzZCcR6pVtYQ1HkqA0tFp8gmqM7m5GSdnUhpqT05IJkZje8AYC0MHrpRqs2HqAF/vpbW4P28cfz+OBi/0wUQU0JJWYMvvPKTnYwAB7q1Sat/ETNB5oz2ZA51nvJIod4mvLpHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wWkdyvBd++j7QqvX1GLOfvuAN0d4ZfUz//q7FpdJvs=;
 b=H62gtX3P0x7W4vUwdnckB5rmkZMIay4xP1Pvcr+DRg+YerzY1dnNz2I4mxhumpZujYfJxj3JXl5h835XWHMNfll9Pkw9Pl2Ex3jqlecIUsjpCo2oDXFzCon1TfvBdM1NiRfKA1BNsiqRt3mvjFsPxdbqJCqAEPK8UsLtel8RRBTKQ3d5it/9L32FlS8RW+HORx13/8BVd8jujLLZXXd3SqMZIJTIL6fiSW2SOZVmd3l6hqvHfg5Xd+Ry73qmCBwTnXg7/yvyQVxwVRyOJl2eR2vfylUdE/NXjlLIpb4TGHPerXhdasSYan5swZ2xmyUBWWfGs8ILOuwDc2sukOnPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wWkdyvBd++j7QqvX1GLOfvuAN0d4ZfUz//q7FpdJvs=;
 b=mKhmKIAmmxhWmqDg4quKlRMsOQQk9DLHstT+Bnp+pH/fMy+0LpRRmAmGpUiTB3KPzn062qX2YnycwgsO+ty+O6Q6WOdgJFw/cIYgE5/b0zacDh/drZbdkHCuucR2WUfclC5bJurEkRnY0G1H1CT/pRy2E/a/jNPVglwJ7IlbPzE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::616) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 20:29:51 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 20:29:51 +0000
Message-ID: <5acdbdc5-0c9e-4db8-a21c-fa011ba0bd57@amd.com>
Date: Wed, 25 Nov 2026 14:29:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: Borislav Petkov <bp@alien8.de>
Cc: nikunj@amd.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 thomas.lendacky@amd.com, Srikanth.Aithal@amd.com, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
 <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
 <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com>
 <20261125041925.GCawZhzVbU3ngXnt5c@fat_crate.local>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20261125041925.GCawZhzVbU3ngXnt5c@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
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
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d85869-1c4e-4ec0-3287-08df4b32db68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|3023799007|261022075727099003|56012099006|11063799006|4143699003|261028144727099003|261026121527099003|261021135927099003|261021121427099003|261102123227099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UgK494RaByJ6BA90RDmkjphE8kVtirfOj6KO6G+XalIwyvgpENa9InzvuWvxH1+XqWX1PFomGyxYWojohkX4CoAC8cTwoPADZR/YGLugVh+Ax0OENcF686Azyo+7uWND89fUDH38ZgAhHYPy7a/BywVRNSK5A5+kECI2/D6wZ+h6xySbh0wgIBKweyPzpg7caRmGHrzDsl9oNtzvUfuq+7jmj2zu+GwR8ZthAG3D/jJL2NL2fCpALfINpxgqroQ99vdoSiAHcy1zo6APW3MCqUZGQ4MOK1AFv5/1U/hQlSfDJHXjcdpQa3DNatS6eOd0Vz1W/xQNwPSeKkdoo+Z6XtWwrCZQ3Y8mgeoUgVrkWbcfDt4aGF9SgU4g+BJcl/2Vm9iP3EulU9aM7DNpyiMh/UHD60znhZ8tqm0DPoqSmZ+53835d6kW9ZACDzICIxUlh4wUzXvx09HHYVzRIVSqY5vo3YvnEmO9Kxah9uSAvv9yMSEFvOy0wE+Cx2D3khrxP7OxDAwuJtnUqAVtI+oYZbFZPnGiZQD9891AhizpMqwfeyJ1EFVRLJbwC7JVVknxn6SAW2DAwnTKBI1+eLZSrWutejWAEcJXoiwYmJS7kEJs6o6B6F68Fdm+Sqr9Nyl0J9PKFX5HwpAuWTitAlduVECAE0y1DDkQHgp+yNJdaCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(261022075727099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026121527099003)(261021135927099003)(261021121427099003)(261102123227099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRacUhYVDFHTkM1TnNQWjI3WjgvSzNOV0tjT2piU3FnaTUxMjZLZUk3dGhs?=
 =?utf-8?B?ZlRZbkZjbFFIVVdkSFhnNjUrMHVwbWVrVGRzUjZIRU9LT2JQSmZ0UURnWTAv?=
 =?utf-8?B?N3ZndVpSTjRvYk9LQWVrUEJEYWdGaTJKOXhpL1RVQ0pWMUFqa1BITGRNeFFS?=
 =?utf-8?B?VGRkYjRjQjJYMVppZlFqL1JPSFF2ZGJoamMrMDk5QkJKazVXZTM5MkZRSXVR?=
 =?utf-8?B?VEx6TzJZUE1JRXdpWmw5UjVnWUpUb1NPa3NxeU9jb0ZweW5HZkpWNUpvY29K?=
 =?utf-8?B?bjJ0Z0NHaG5GL1YySUFPMDR5M29IVWdIdnZYMllUUXU3RU80aGxZMUJ6Y0NF?=
 =?utf-8?B?SytENUcwRnl5L05PdFUxSFEwYlQvSkptNG9DazJZNFZaOHltWUV2bE9URExt?=
 =?utf-8?B?UE84cUlOdHVWMElyT1VtRGVVc1hGLzhsZy9xWkN2aXpIMlFhSU92NS92RGJU?=
 =?utf-8?B?NExRaGU4NDUrYTJnSm4vZVVYT3E1SXh0UU9hVFZLb3ZJR2w5elI2WUR0Um8v?=
 =?utf-8?B?QzQvMUxEUVVzYlM5YWxwWU0zWmQ3bDVWN2kzakdUdnN3d1Z2TmZkaWZBRzdE?=
 =?utf-8?B?RTVvcUJjNXE4akdPWHJ0eXljUm1OMjNWQ3dUbDQzVUlNb2d2VytZNlBHNzFa?=
 =?utf-8?B?L2VNT2JPQWJQZ2ZSTTJEOUdkV0hoMnJuRFh0b1R2WFpSaE5NeHQ2V3RvVTJZ?=
 =?utf-8?B?bHJpa29SdWRLQ3JiMnpBODlZRnJxYll0NHE3STc1OExubVpENDFDdkxZMklO?=
 =?utf-8?B?L1o1SEZZbkRZSW5IcEhtMzV3UEt0M1JZMzdLQnIwQVBYS3pNcFcxSUFqTW8r?=
 =?utf-8?B?Qnd6S3FoNTVyeHlxemFCUk91WVVjcU03NmxIc1BjNTJuRXNlc09WeVpYcU1k?=
 =?utf-8?B?RmtSR0U1UnFBSk9zd2QwV0lUZDJJTmpSTFhhNlR3WjV6bGhtaXMyUEw4SXZV?=
 =?utf-8?B?dkxMby85a3VnSG9HU3Vzd2ZsdU9PdFBSS2tVZEt3Q092TzFpaFZxUHpmZ0xV?=
 =?utf-8?B?bGoramcvNyszQlhVaWZWUTRNYWgxU3JxbjJURUp4cnpYckJkWTcrRjlGU0E5?=
 =?utf-8?B?dU9mQ21pb2JvVENJQklqL3p1Mkl5WU9vV0Z3UG1mRHE1aHdLNHJ3VnZsMmVY?=
 =?utf-8?B?V0QwNGE0dDZXQVFhYzRNYUtUR3VPcHh3OVhMbGRVMTk3eU5WR09FOTRxc3pu?=
 =?utf-8?B?bm1KRjY5UDVVQVhPeUJsM25YK2Nmdlp5NE5hKzEvVjR0Sjg4ekhzemVXYVRE?=
 =?utf-8?B?R3FpQ3gyTy9XUVcrV3kwN2JiNnllUDJDSUJOLzlKMTRLRUdTbExuNnZ3R2JP?=
 =?utf-8?B?NU1GcTBjakhuRmlTa1BiUjhhWjdINkpZNTJpK0JaOVA1eDRnRldseGllSlpy?=
 =?utf-8?B?b0d4VkFpVEFaWVF1ZGpwR0RMWHlvc012TStTUEZ1YndaUVhPaUZyaGh1RnlL?=
 =?utf-8?B?UmpIT3U4bzVKV0ZpbUdJU3J6by9vcDU4aWF2NzJVbWJCYXVGNTJRRjBmMnZ0?=
 =?utf-8?B?b2RZK0E2ckpJazZHajFKVVdjOVo2WHYxOHp4cU5uV3AvaXBzdExTRXRCSWZZ?=
 =?utf-8?B?SmY1cjV1NTIwcVptbnR3SkJBOGRYTkpwRC9iM01GMHJuMm1ZNCtTT1ZkU05C?=
 =?utf-8?B?VmhFK3NqdHR4YWlaTlNTTnBBc2poUWFzZ29xN3JFRmxrVmRIb1ZmMzRYaDEx?=
 =?utf-8?B?VW1sWW5tcFJDTWgrMDlCVGNjODRUZDg4bVVkV0NkQkFhKzFTbkhkbnJVK2s1?=
 =?utf-8?B?cGQxVVVWbldDRk5lQmlNd01DTzJmNzgvV2NYQmFWQkF3R2VjSWpMSDhIZTg2?=
 =?utf-8?B?eGJyaWhJbUJlZDFMTWVjcHRuOFhiTGFZV3lUQ0phbXRTYU1WY1R3UXhKWHV3?=
 =?utf-8?B?andHdnloV2FSS1FsakVzZG9oVHVMVktjTHVwSWpncFdVVjlTT3plSDFCakxm?=
 =?utf-8?B?UElDN1RUai9EaW9aYTlBQ2k1RVR6ODhJenR6YU5Ic1JSUUlhN2FnOGlEdUYy?=
 =?utf-8?B?VnNSVmdsdUdHS1FIcUkvZDhVZjdDVzQ1NS9YTjEvZEhyL1J1dHM1VEZQaUVF?=
 =?utf-8?B?dm1xLzBuWlZMWDlyT3hWa2tWdXJ5M2pVY0s4Q1hBQ3Q3R1VmY3JHMkJtT3Ny?=
 =?utf-8?B?YzlCOFlPTzhYazVTWU1xUG9KcWZGL0VVUGNyZUM2c1VRU0MzRGpwS1dhWllO?=
 =?utf-8?B?SHhxQTJQMXhiRXNIaURNbUJSWi9BTk5PVEZsM1F1QkNLL3I4bnpJK3VHbmk0?=
 =?utf-8?B?ZmdhWXVTb09uUWlDZUVUaUQ3ZnlWUHBFTjVXWHI1QzBEVU50U3dDSjNsekkz?=
 =?utf-8?B?OUk0MXdOY05VVTlid01Wc2NhS0xqamJDb3hmdks5L3BURmswMXQyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d85869-1c4e-4ec0-3287-08df4b32db68
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:29:51.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5wBj6vq9EnnQSWHG8yHiSkGZPhPZbhI4IO3tnPCIBwAgFuRqHpi6Qw2s/way8qTvzlw8mFl1kgQZ0G9MIZv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1

Hello Boris,

On 11/24/2026 10:19 PM, Borislav Petkov wrote:
> On Mon, Nov 23, 2026 at 06:22:09PM -0600, Kalra, Ashish wrote:
>> On the "bogus VMGEXIT": before Nikunj's change, __sev_get_ghcb() returned
>> the per-CPU GHCB, which snp_kexec_finish() had already converted back to
>> private. The host mapped that GPA, read ciphertext (exit code 0) and
>> returned GHCB_ERR_MISSING_INPUT, but couldn't write the result into the
>> private page, so the guest saw its own stale contents, treated the call as
>> successful and moved on. The DR7 write was simply dropped. It worked by
>> accident.
> 
> Oh lovely.
> 
>> As for using do_vc_no_ghcb(): the GHCB MSR protocol requests are meant for
>> specific guest-initiated operations (protocol negotiation, GHCB
>> registration, page state changes, termination, etc.). The only one that
>> corresponds to an intercepted instruction is CPUID, which is why
>> do_vc_no_ghcb() handles only the CPUID exit code and terminates the guest
>> for anything else. There's no MSR-protocol equivalent of a DR7 write, so the
>> no-GHCB #VC handler can't handle it.
> 
> Well, can you fashion something with VMEXIT_DR7_WRITE and a dummy GHCB MSR request
> to the HV which is innocuous, just so that it can satisfy the flow?
> 

We could issue a harmless MSR-protocol request and then skip the instruction, but the request wouldn't carry anything about the DR7 write. The hypervisor would end up in exactly the same state as if we just skipped it, so it would be an extra exit that doesn't actually communicate anything.

So how about doing it in the #VC handler: once the GHCBs have been torn down, route the #VC to a GHCB-less path that decodes and skips DR7 accesses, completing them locally, and the kexec then proceeds normally. This is safe: without DebugSwap, KVM intercepts DR7 accesses and only tracks the value, it can't load it into the encrypted VMSA, and the kexec'ed kernel writes DR7 again in cpu_init() anyway. Any other #VC in that window, which can't be completed without the hypervisor, would terminate the guest with a specific reason code instead of dereferencing a NULL GHCB, so it gets caught explicitly rather than silently skipped.

Thanks,
Ashish
