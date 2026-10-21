Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602010;
	b=Bvf/QibUanwBKeF9vzTjj/vXhpud00skKNXuLZKTKmTKZNiCzOWq/qs+kQBqJ+WjiAtp
	 dXRfKH9mky5E5fwmkrkrNWQGrwzzGAPBR3lYKX0cxlyxewduTYo1PCeL5lYkJgStyYJoA
	 Ir5dtDRxxGSmIzh83iu6UFndi47npZAKXK4nwfyVxkty0dsq357bRoeavtJ6+aLXvJkjj
	 B4aIY/QJHLbUSH19As+lDTb9QKri0ZxOBqGeJ0yBN5OFGBUR8qmbqcZsEa5uzerFU1XRN
	 n/xCQZ8JqRQ0cSUi4ILKU49dzRwjpIyHCDmQ4Wa8K8hX0Vu8u+D6dqUQsoxCCvlc/4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602010;
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
	bh=jz2h+fDQpIjsnhUo54g20qmIZjwTYgRPH6a6FRwxN7k=;
	b=NoIInsaXW/sEkJzQtaaIvMa6r1L349y0Qx0zZr6LJ12nZiSy7zS6g7Xz93OFMpuqcFnU
	 ueZSJfmEm8UKr1Bj3KfRgKHukNFZ0wPOoZUBOwnALTb62mGpcT24FBU2g64sLQtrczvy4
	 IYLkakFfmDeRd3IrPuAo6D+4QhuInFsYXz2hC9sK97xp5RQ7f8B/NhTtJDDEjlvoD+pAS
	 sqjRFrfALfZ2KG99qM4dvLUlxqZ2/MALrS7qW/RsWtnsgoPJMgLMsXzbHPfWQoppmHCIm
	 sGFYNAKv8yFOWeMiBFXvLVyq0SMJtCICCxNLlNpeuO6Qvue7+O+9MjDf8JBtuuHQ9fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ten42nts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.59
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF3606A31D;
	Wed, 21 Oct 2026 17:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BF3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ten42nts
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQcIUrEXQhnzYQQ5Uwj9QlLXJmP6R0cl9+pnZoFMfeM6sShf4lBuKW3S8ZkHsKof65iX4zxK4RNL+Lr5ZQVn2xfqOnkBQV7vwg9vmBSQGtISD7969kke+rN/6RFirOlMKPW4Ank9Fy3eQulDExxmq0mewjCt5oSPJAwLrbQsOmxM/5LztoYl/l3mGzTkdmK+Y+TQbFWTmpnCCyUS0qM+JsZCCBCzwer5UXSgNHoCDTs2VMkqvFK2EFgMRYr7Jlu9SnoeaejR89suq4Rrfo7yuiAMbV+LiiXO2D1QbDhyCJBZnbJ4ueDZIzPVCbE4R7XyPl9NqmzqeKSmV49ERicH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz2h+fDQpIjsnhUo54g20qmIZjwTYgRPH6a6FRwxN7k=;
 b=kOh06lt/4ngkYzT9MssXOmTQZ8cFIAAb5BS0aCRkqBRloG/r8z5wjGdy5LAGS9v1EoyVv0jUoOBSF6YseBHhQRs9mAQ1gjCpeVzBis5drXF2llh1kPCJnQc9rBYzeFGw3C8QI4iiDjwQejh0pjs0wXcIyuF55+e2TloyXVdOt/ZYfXmWg/fZ7ajb+xaTSVcun7DRGttXjkKrrX2P6puqY3RnbxsscNjGlo/2DdoNM0wzhzHsiGU+Lgj756M2ILb7HnB4f4RlY8k0LRrTOxNFkpv8agiW4G765iAzxNpDd3nq5vrX0yOInWFO87jljlzyevj3aYrJGP0suXv7SE8B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz2h+fDQpIjsnhUo54g20qmIZjwTYgRPH6a6FRwxN7k=;
 b=Ten42ntsBe0yWcVKmCKF/hivvIx+x62quXOKXFWM2tl/OVrlsWV/vjfAx1tu2AN/15HqxuLV6AN0DoRvgBrKEBiMbuo7+unVeKXRNhGO5pj2Fo7kqgEppBG7LMRfSNodA3JoRma1Uhl9FQaBFUVYm6ALl3U3xR+42OdhZuRTKm4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 17:00:02 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 17:00:01 +0000
Message-ID: <345e3647-5bdf-4cd4-828d-bd28e0b66cac@amd.com>
Date: Wed, 21 Oct 2026 11:59:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU
 kernel mode group files
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
 <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
 <c600a240-ed11-4e31-b3c3-779f01175f28@intel.com>
 <e1753b90-f22e-4708-8c2e-0e1d2e0f46dc@amd.com>
 <91e0e000-7e37-4e49-95cd-76062097fb79@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <91e0e000-7e37-4e49-95cd-76062097fb79@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::7) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: d28cf12c-ea1b-4739-766d-08df2f94bea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|261021121427099002|4143699003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uY9H3eXmzz8AsgefUbdsjjQqmG5m+7Mde6/2mJXfIE6UohE84zHzauzIefRkaT7U0Hds61LhNUjjCpFyOePh4k0vac+xItBSvL0oLm3NdCjKoJmqHGd+/hUbss/256pgQWSg/GUIII3Lc/LUE1BG4wx9vUrzf4sxOEy6Tn7PXofmcPGZW1kisjpU8ZTVwEa7KS8bYcOx4I0LtRfQMn0QYFxRqCNg6LUdXnsvSRSD5d/xTKkgDD7DklJGwTGRwxhuT48FJC5+ozXFI6Q+hNUzM8042MAlp7zC1VHQOStsAnIEpMJ2h2QxNeAsX98lBew3jEFLq0px6Zqq77l9VuPBO1cylVqkWDuluXYV3E0RxaBHZTxKJbx1gWFqdUz3CO57mOwt7S1CZm+inTuMVlzcKfHOrPwxsMfsoYUVZR7To6h96FOWJSiPFhJ0ZZmhOjtIWO0gwckIy+NmCY3Wu9YUhPYrgndUVNtnSVbNN9yAKJR+dh+dRUT63ztDLe9/fPN8+VjrNuxqNL4u7w1WYxzp06qiL1i637lnt57bufUUn5PDdFeLlDtp0cSd2yaefly0NN0CZT+PQay8t6vA3vVlmQ4qiCEZ0gr615cCdFMIUAlUKLiJDiJIN7hm1QPfqYAnsOP/bYjsLqiHIDpabrcXAAsWPFxqfD8ZBM6owM92zgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261021121427099002)(4143699003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXJzZEtCL0NBZm5JSC9ZSUE1dFdFTW92dGlMaHZlbGtCMFBPWnJSWDBVbDFh?=
 =?utf-8?B?emg3MHQ0MWpKUXUwYnNXNlBNWDllTG55U0RPWGtla3dDVW81blRaazFOaDh4?=
 =?utf-8?B?TW5GSjQvYk1JcmlNVDRYN0NhakE5ZXVNQ2J1cUFqbmhEL2VEdGxlcWVJRzla?=
 =?utf-8?B?a2JQcXQyZkRvc09aYkxEc1gwY0E2NUNud1IzdlpTRFFYNTlabU4rLzBmOGJa?=
 =?utf-8?B?Q0xiUit6RjVUMUhQMkdiMDhodGlzT0ZiS2wxK3VrRUVPc3A1SWJ2VWJoaS9V?=
 =?utf-8?B?Nkd4VXhEaUxrNEtHSE5QRUNmR3JqK25FRVhZc0p6ZHA0TC9xaFh4R0FNWDZ1?=
 =?utf-8?B?VGc2YXhUMHVieDJHR29JajMvUjVwdWd1bVV2Z2paQWRjZ2NGSFZZQlUvOXVJ?=
 =?utf-8?B?cTF1dkwvMG1YMWg2NmJ5K1ZuUWNGVHQ3WjdQdjYzMUhibFNObGIwMlNVWHhU?=
 =?utf-8?B?bUtNby9jSzJXdHFPbW5JS3FHNkNQYzdCUFI4WXorWUVlbmRqeWtlYlpkaXlj?=
 =?utf-8?B?UzdQUjRFaytuc3phM0FYTlNsUTlFa0dlbUZRN3EyNFk4VzcrREFidHF1Qzhi?=
 =?utf-8?B?NnlVbGduMHp1TklyK2NyOGI2K2krYTN0cUZLdjlxdks4M3E5RFBoK2NVWVRF?=
 =?utf-8?B?NXZMM3hHMmk4S2FySmgvNnBkdzlOakFqZHZEeWxXY1kxR2loK1NtMlBuYlBQ?=
 =?utf-8?B?VzRHZG1kSEJ6czk2d2Mva3Z3WjVNWUo3R1oweTJtdWt6RTlVbU41c09kc2xD?=
 =?utf-8?B?MUNINVBYZUU5RDVJYTlqbVZQZ3I3aEorZ1E5K1RTbHhyMWlLakwyUU1xdjdL?=
 =?utf-8?B?UjVIZjJZK0czQi9uY1JQUVBkRzBTblA1UU45Y01tZmdURndiVkM5V2srUUw3?=
 =?utf-8?B?OVZpbEUrK08vVDJyTnkrVWV0OFFiR21mSXA1Qm4xeHlwLzZnR3JaQnM1ZVkr?=
 =?utf-8?B?V3JJMUFqU0J0aHdOaWlpSWhaZUp3MkdHWW13alhCc2tsTVpod0E2KzZDSHho?=
 =?utf-8?B?NFJuOWc2M1M2aE1HT3QxUnhSS0hkTjNjT1VMUWxVb3M4U0x5QS9GelhKN2dP?=
 =?utf-8?B?bmpRWTd6bVNTUG94WkFoZGhjK3NRMzJpT3lLSS94MGh3TVNVV29sN01ZQkhO?=
 =?utf-8?B?bGtDdTREVW9vSVlrUjhjL1NrVmpGaHRxVFhnYitERnNKQUltZWNjUGg1TFFo?=
 =?utf-8?B?aUo3bW9pcHJET3QrcFhwQWRhUjhRbWltRkdwbmVRNThKQlRGQnk2Wm9CMUQw?=
 =?utf-8?B?bmNDRm45QjNxYXJwbzBxRmtYZ21MVXF4V2Nha0JhUkVhU3Z5NlZUdjdpd2Ux?=
 =?utf-8?B?blQ1Mm1GS1ArTWd5QnNoU1VrRjRoSUxOd284NTk5N25qbjU5MkxzdXErNEhQ?=
 =?utf-8?B?Rng0dk1aZml0TGxCRmIwZ3p1bSthVWFwMnFQTm1wSmprTzJyaHhrby9iSTlU?=
 =?utf-8?B?SzVxaXV3RmFuUk5uYkpzR0wxekpJS2Jhcnlac29IckVPQUM4Ny92N01ra3Zv?=
 =?utf-8?B?SEtPdmZDMFdaVGljK3lhTEFNRmFEZGFKeUpTMXZad3QwR2ZaaWZLNkZzQ0F2?=
 =?utf-8?B?Y1czeDF1UEFmcy83ZWR4QmlTWlgvTzZKTFhHa2JmdS95VzArcGNKSUEvZUdt?=
 =?utf-8?B?OEFJYUd6YzF3ZDlEcTBWazl2MGRLK3hxYmRZcis5OVBsbVhEMUdrb09VWkQv?=
 =?utf-8?B?UmZtTGxPZFppSk1pMVpsMGFrWE9vMWhTY2VLQ1RrU3BYelF6emEwNjV5cDdl?=
 =?utf-8?B?RTlRUjBPWHRkbGgwZG00NlNFa1E0KzY0UDJxdGNud1RsME5rZjU4WFN3WmZJ?=
 =?utf-8?B?TXBxak5SVVNkcXZyL2s5VGp1WXltWE1RNTNFWWRmWjFYb2VUR1JIQWdKenZn?=
 =?utf-8?B?SXhWTnJxTEEza2pBQnBBUlEzU0pJV2kxQXZIMEY0b3B0a3VDOFdUdTc1R2Yv?=
 =?utf-8?B?WGtrblZTblBTZ3ppbjd6WXNhMEhYRlNTOHlicFF1Ti9EM1NnREt2elNVVnk4?=
 =?utf-8?B?ekNrRmMzNHdtK013aEN4MTJ0TEN5RVlQUTVYcjEvZy9zRWFqT2V3T055UGZQ?=
 =?utf-8?B?M2pIb28yUXR1VFdtVzdkRHBkVG1rTVRCODUzUjV6NkxzaUZVcDVsMDY4T3ln?=
 =?utf-8?B?M0hMUGM0cHQ0SmJmc1FPMml5YzdmZG1pVW5TdXN1TUhDNG0ycUlleXFXQ0xQ?=
 =?utf-8?B?YXViT1N3d2ZTVCsvR1ZxN1doTU1JcHJKMjJoYnBkV0NpV1VIcXFNSXByaS9m?=
 =?utf-8?B?TkRsaXNRZmZUVjNQR1l5WnVjTG1GaVE4Wkd1WkhidHV0SHdMTlR1ZzdVK1hF?=
 =?utf-8?Q?ded0sJMCS9SqK2hyn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28cf12c-ea1b-4739-766d-08df2f94bea3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:00:01.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/G75DEK1X7Flzz/sFixbakcpzF4zwLIWRMjWuiDRhxP1dAuCE578Vc4McIK/oMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

Hi Reinette,

On 10/19/26 17:00, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/19/26 9:31 AM, Babu Moger wrote:
>> Hi Reinette,
>>
>> On 10/15/26 10:46, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> The kmode_cpus and kmode_cpus_list files are specific to the
>>>> RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
>>>> hidden state when an rdtgroup is created.
>>>>
>>>> Introduce resctrl_kmode_global_files_show() to manage the visibility of
>>>> these files based on whether the global per-CPU kernel mode is enabled or
>>>> disabled.
>>>
>>> This does not sound right and does not match the patch. The visibility of files
>>> is per group, not globally whether the mode is enabled or not, right?
>>>
>>> It is ok to have cryptic changelogs when changes are small and simple but these
>>> changes are not small and simple.
>>
>> "The kmode_cpus and kmode_cpus_list files are specific to the RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a hidden state when an rdtgroup is created.
> 
> Could the context please help the reader a bit more? Some items that could help:
> - *why* are these files specific to global per-CPU kernel mode? (mention that it is used by user space
>     to do the per-CPU enable/disable of the mode)
> - *why* is it created in a hidden state? (mention that a resource group can only be assigned
>    to the global per-CPU kernel mode after it has been created via a separate resctrl file)
> 

Sure. Will add that.

>>> Introduce resctrl_kmode_global_files_show() to manage the visibility
>> of these files based on whether a resource group backs the global
> 
> hmmm ... resctrl_kmode_global_files_show() does not actually do any
> checks to ensure the resource group backs the global per-CPU kernel mode.
> 

Yes. Will fix this.

> 
>> per-CPU kernel mode. Hide the files when the group is no longer
>> associated with the mode.
> Could the patches be organized so that this becomes a symmetrical change
> that highlights when files become visible and when they become invisible to support
> the description within this changelog?

I didn't quite understand this comment. Could you please elaborate?

Thanks,
Babu


