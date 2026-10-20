Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792536047;
	b=fBTXWbwVSLG/MsTcdTf56xq6zAVhg7zYh8ounQuNvH/sqKZConRyrbJzXT3ody8OKrUb
	 m6GTyIyAGUyToxQf2MYcoyYlpLveHBzi/cs897wV2qsl/kdt8Y+o+nMGnovASonumPzOi
	 sInVt310AblGJsM8me63KD77I/cSWSw1CHM3rGzIIX0exPdcJQoy3uEmQefR8F2rcQ3oQ
	 mRCW0aGnt5c3raASQ/Gwi+EG4QSzTKVL5eVSQWXn9I9MlXeOMs9rn6HdCiX8g0hOILNWi
	 Qu2Y4HmoPIgscuOuLPVYlwC/6MDolya9J4YDETyEz068ram0sdcj9MTincyPwLzgDVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536047;
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
	bh=8mczsWQvOYQQl4XsxFFWW00i62Jcr04cpalkveEBTlc=;
	b=MBlEQt1zWmF1YD+4u50mFw+qE3UuJ9uFMIbuFGAaqVjkEOoC6LmYIUo+PrIZQ/n0He0R
	 fxOc56P07Gnn7gh1ssQ1Y9niVSC196HZEXFqGYf1eUx1kKwjExdE3iVSIfc1k2P0DtM/E
	 Ux+ykSzANe0CbhDohk/++Zj9ADbLXAEbpOvleMFUFr2crabQEqnaeyg19L6SYVWS8WQ/+
	 E8RJ6/U6+wMm2yTbns5+kzTZ1AcrN/7PSuJZ6Ii5AA97xJNd9CRy/zety9XHRxMyn9PbO
	 ZdkWQhoaYAEnKCZrFNkMSmjAhusRifL453+mfUj7Qmor/qBwzRKXj+2L4spd914kM0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q6rTptpR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.33
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CE606A319;
	Tue, 20 Oct 2026 22:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 945CE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q6rTptpR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOziGpDIHR+qJzpbB70Jdvgh/4DN/ZJFZlCLZ8cR0kRYYTku3vICEqyF7V9q5EfQseRVwceDJQBRocg9Ole8b4Ag7Z6jpV9ibSbZa3XgsLzOGRTvSSemdASzQa1gOOebzNI34EwqWweq+dJdkK+n6PIe0IqHaMT5vDFFj4RQG9ecgIcFSffh56DS4Ow6ecIJaRTfoxa8P7rJFwod3OMIDCxaZRI4ZJA7cI8RcEjvPtJrDK0GQouha5HUKRyaugEh6/8SNGGv5QO1gu+a8G/SL5FFsbh3uugc7TCZzIXFsCvc85Owj4CnG9v6QmNN0PsKdr4mDenaVs/dZUQTdECKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mczsWQvOYQQl4XsxFFWW00i62Jcr04cpalkveEBTlc=;
 b=ROpvYu+s3u+z+zO7I4LB2FcOE8XqRJRO5/ai1ED6l4dSYzZSkyeG6I1fPMKJYzBFAAjAjUo1WcYyi/eNNq/FAcF368xj13mMMQ5mb4kcOyy2ZI2fHfnv6577S9qzymqk05JjsxxZDrbqBW5U+aAUWB/JIxX3LxmN/lv6kz9KONu3CvWL25Z9mGBtL+HEB2QigLoIGJZQjV6L7OQfSOoEYPQ5zmwxawvt5HU352/dQ/U9lCH+pVHMJ/HrN5N09PyLogogKub9P0ZZVerLOrih23axbW1f2e2yTQvvn/6hOPkd6hKm+jaF/YKTC25+3I2YH89BiMeb+fitM8l7GayQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mczsWQvOYQQl4XsxFFWW00i62Jcr04cpalkveEBTlc=;
 b=Q6rTptpRn1iyQcxYU6qDdIr0uzH6qSPnpjisHRd5Z/wtvxDgKDfj3ap07Vxyq1M4wsp8kBPiiNbwRYSIhX5m/6lVyC4ULAM01UogGOrg1aghzAEaXYkiLHHenjI181Nh1R7KaIpArflawzMwwMNT7HuMbN3BOIVvAaiCGLaazUY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 22:40:39 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 22:40:39 +0000
Message-ID: <dc9f3713-8041-4b54-98c5-4ff262b948c3@amd.com>
Date: Tue, 20 Oct 2026 17:40:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] x86/resctrl: Add PLZA configuration definitions
 and data structures
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de,
 ben.horgan@arm.com
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
 <608876cedf5eece3f8b9297bcf21663a86a6380d.1790867441.git.babu.moger@amd.com>
 <bf4bd727-eac2-48ba-ad85-539a818524d6@intel.com>
 <c557ea83-11aa-4747-b305-93d554d3fbc4@amd.com>
 <dde507b4-6592-4450-80c6-41af64c1796b@intel.com>
 <ae45849d-8260-4a34-a860-51a309dafa29@amd.com>
 <7f14a2b1-2d95-4606-9242-eba62afeb856@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <7f14a2b1-2d95-4606-9242-eba62afeb856@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS1PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:8:456::9) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc32949-5b80-4ff8-e7dd-08df2efb2a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|6133799003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X7wCmYecz93wS5xsdDKh4fHktvzdWLR8d5KFF+uo3snIh8U9R1TzUqrngKqg8ye3Y8D2d5Fsi9QVtBmhu4YGrsPbQutFd1bhttCwiePSxvlSZl2GfB+o/0+P8XVytQzjyfQ8jqwgVxouigSuk7DuFxctwfvmRbKNeXpgEf88X05PI5SHfve53Hl7s7uphk6pBaxL0BMz9T5GK7zAi2yjP5BPH52+RwBGCQkzrh62vWUR/wHmJXjHc0tq1mBBUxKCiYBB7HQ2xf3SSu5j6taJSElVIt96rumdOf9XYLtFtCUBl4tduZmtRgpq1s2HxRI1PnOEmwJKb6dl7ZRlcrf/Dlq6zZWTqc0dG4YjsVrBI7foMdRj1kj1qKfzFYnLRuskbYMgOq+BtJj1+LZHQyULDP+4NjVWnvx10YTsDp6KVI7NOxuvzV4A3mWOuLkAvBtMIWTrE8aFsG3KIYrQw0OzfZUc6V16TNjVPW7tzB+/Bt2SlY0WYp2hdGgi2q5fG3Gx9zuOstXu2ssiRYRJ1l6HH0pTFObrh4rJsnBqQGPXzqdM1NGhAyeGT0Tv2dn++s8grnGMkoWqW/UzjDTK7epnZKoRsDHWeozDqw0JsOYZ6eM8c0lxi9gLUxktIzUwQa1+Yhe1K2bto+Ss21hh/3splBi9MGxSb44uToDQKzdLiMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si8yQXYzM3FZY25WQW9zTFRSbHRMNUFGUjlneXgvVmJUREpqVDNUSnRaR0Vm?=
 =?utf-8?B?WUUwRTM3eVdqd2tCdHAvY0NodFlzYVdQVG5HaE8zKy9jTXJzbnlhNit6Nytu?=
 =?utf-8?B?U05pL3RBaXZ2U3hpd09kOE5Nci9mQWFUc3FWQ0dCa0NZdEVoc29Oc3lvLy9p?=
 =?utf-8?B?bXlPcnQ5QTFlQ1dVc1VkcExzVDQvY0hqTk1SZnc5SnRuTm0wR25qaVFYeW0x?=
 =?utf-8?B?ZkQ4SkIrRGZwUWRSaEI2RElaQjFTdzMxZ3QxRUplWE90SURYWjRXSmVRTDZM?=
 =?utf-8?B?N29SVGEzenZBNGpOU1Y1NTloUTRFQXp3Y1RuV08rMDhJSDZzZXVoL0VzVGk1?=
 =?utf-8?B?N040ZnIwdkViYlA1eXhaOCtmY1A0NlB4ZVEvV2QvNXp0TGVaYlJNNnNsQkpC?=
 =?utf-8?B?ZVo5TW9PZlE2TnBiZDcrUVQ3TnZVejB4cUduODJNZVdyZDdZNlE0ODZ4Yjk4?=
 =?utf-8?B?Z0d1ZHRSeFVGa0ZLaVR1Rk5RSERoMUs2TTJGdEJjYmdQSmMxaDdGTUt4RU9C?=
 =?utf-8?B?K3gvMDR6bGJsOFBNVVJudnpCZHdpM1Qya1JEMXIrZ2ZXWmZpSllpT2JCOUh4?=
 =?utf-8?B?U2ZkdFd0d0ZreFRZN3lJb1RVODlWVTRPRnRaL01FdEtWNFZLczNLVVFrWm5m?=
 =?utf-8?B?ZHV2UXpnVzQrTE02U0JkaytZcWFRczJqN0J0ZTMyNWxpSDBKRlZ3WWNrOE94?=
 =?utf-8?B?WjBCRW82SXZvaE1FOXVKT2Y4M2FXZGczR1Y2MjU3OVZnSzBYZjZrbWYzVW5Z?=
 =?utf-8?B?V2lPV3dWaE9OZVdIOGQ3ODMycncxNFhJb25vZmVvSThERVlaTFR3VS91V3Fs?=
 =?utf-8?B?TEo5b2hLdlJnVXIxeTNaQXZ4ME8wOVEyYXdxVUxreWw5aEdPTVI1WVd5WVRs?=
 =?utf-8?B?d2NKZHJ0S3hxay9wT3Y1MVhHZkd6ZitiWWpOVkY1WmJoWHcvQ2N4WGtXOGM3?=
 =?utf-8?B?ZW85bTFzd0pjREh0MklYT3BNeWxnMVVKRGZkWGJYSU01Zm9DT2pMUFNuY1NE?=
 =?utf-8?B?L1BvZERLWnkwckVSdEd3NFQxNnZycHVGaklucDRna3VTUXBHcXVEWkpzN1dk?=
 =?utf-8?B?czU0NGdJRDBuY0xhaEtpNWpYRCtZT2hlUUh4VnJiRlhPYVlOaGlCQVNGOWhP?=
 =?utf-8?B?b2pGcmlZeWQxWFo1MDZiaGllY0VaN1p3Q2JHZ2o3U09DTTkrdHY3QlBjaCtD?=
 =?utf-8?B?cHo3eUx0TmgzY2IyNTUzY0NMK29pWjFkNnhObnMzNjBwbkZNeUQyWHlMMDB5?=
 =?utf-8?B?emRkWWozRlVJcnFJQ2hUenR1UmhJUXp0MFh3SFJLY3UyUUhXbnFWOFdNUncz?=
 =?utf-8?B?cVgrQ3RzVkpZMTBIUWNzcmJETU1oQ1hEYnEvVnlKZnFyeWk5SlZmejI0aWNQ?=
 =?utf-8?B?UEZnYjZFREZWSjd5UjNVcUdsaVM2OVdBcWhLeVptRUFMUjcrV3NHUVFhUkNO?=
 =?utf-8?B?STJZQlNOSGs3bXFQN1E1K0R3OGFYbVVUanRqSkZSNFdMd1d4czlUT1Y1blVx?=
 =?utf-8?B?c2pKelpZUXZ3bDFWOUhBbEdSbVJLL2RxK09lMFY1aFFJeU5hdi8zYmsyeXkz?=
 =?utf-8?B?bUxsNkJWc1hOSlhRM3BCTTg1VUZlTHJGWmltTEpYWEtmTDh3MElKNjZBWHVE?=
 =?utf-8?B?cmJjaWVXbFdtNEtGSDNNZ01EYkw1WmhNZXhLdUY5TzZUUk5qZXl0dGNvRnlQ?=
 =?utf-8?B?ODJCVk9lbCtWbWs2ZitPc215RlN3NUc3ckdrN3Vrb05XWE43M2sxL2ZJU09u?=
 =?utf-8?B?Rk5ISm85UmMwSXZEVjV3dEIvaW1pMEF5blNpUnR5VlEzeHRRUFZNV1FWZlFv?=
 =?utf-8?B?Zlg1T0xzWlVLMW5ueGw1NnNuSE9Dbmt3K3k3ZldjVXFmdjJMNE1oay9lMnBH?=
 =?utf-8?B?ZDdZUWV5ZXZqS2U4UnVsRUkwUDVXQitqc2pCajdtQmpEOURnY1JoYzBRUkto?=
 =?utf-8?B?SU14YnliZHBzNjNVaGN2VGxvdmJocUowcG9DemZLWFRyT3M1UlVUaFFXZ1hz?=
 =?utf-8?B?OGMyWjVUbXJqN0FPQkdTV1Z5bUJpOTNYcTJacWMrS0puMjlqUUV6Z1pSUnJ5?=
 =?utf-8?B?WmJBRm5UMm5vL0JoR1JiWVpNNGRuK1d4UEM3VDQyVTNTNXFSdEp2UTlVcnNn?=
 =?utf-8?B?cUlJTEgreC9FRTVvZU4wLzBZVTc2dmNoZVllMC9PUjVGaHZEcEZzdFpndkx0?=
 =?utf-8?B?MmFXSlhHUFMyc0tVZFFDeFdHd0k2c09VMGt0NVE1d29tc3JzUllsTWI2NGdW?=
 =?utf-8?B?WFhOUjArSE9DaWR5UFd5MGxQMlhKbGF0QUdTN092NTYwRFlTNGtrNTFhTVJG?=
 =?utf-8?Q?Z8Kkc6MN/OirSpOWPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc32949-5b80-4ff8-e7dd-08df2efb2a6e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 22:40:39.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Ndp0HUSMhs7E9/NAzltjts6ACXgnA+N1Zg558/QoFDa8ui1P5L97jqYaZgVcCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901

Hi Reinette,

On 10/20/2026 4:47 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/20/26 11:02 AM, Babu Moger wrote:
>> On 10/19/26 11:16, Reinette Chatre wrote:
>>> On 10/15/26 4:07 PM, Babu Moger wrote:
>>>> On 10/15/26 09:22, Reinette Chatre wrote:
>>>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>>>> Privilege Level Zero Association (PLZA) enables the kernel to switch to
>>>>>> a different CLOSID and/or RMID than those used in user mode when entering
>>>>>> kernel mode. CLOSID and RMID selection are independent and can be
>>>>>> configured separately.
>>>>>
>>>>> That CLOSID and RMID are independent on x86 is clear to me. That they can be
>>>>> configured separately is not clear to me in this context. What does this
>>>>> "separate configuration" refer to? Looking at the later patches kernel
>>>>> mode allocation and monitoring associations are always configured together
>>>>> and written to same MSR at the same time?
>>>>
>>>>
>>>> Good point. Its confusing.  What I meant is that allocation (CLOSID)
>>>> and monitoring (RMID) associations are independent PLZA features and
>>>> can be enabled independently in hardware. For example, a platform
>>>> may enable kernel mode CLOSID association without enabling kernel
>>>> mode RMID association, or vice versa.
>>>>
>>>> Yes. The kernel interface configures both together because they are carried in the same IA32_PQR_ASSOC MSR update.
>>>>
>>>> How about?
>>>>
>>>> Privilege Level Zero Association (PLZA) enables the kernel to use a
>>>> different CLOSID and/or RMID in kernel mode than in user mode.
>>>> Allocation (CLOSID) and monitoring (RMID) associations are
>>>> independent PLZA features and may be enabled independently by
>>>> hardware.
>>>
>>> Which CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid) and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid)
>>> is used in kernel mode is different from whether the CLOSID (MSR_IA32_PQR_PLZA_ASSOC.closid_en)
>>> and/or RMID (MSR_IA32_PQR_PLZA_ASSOC.rmid_en) is used in kernel mode.
>>>
>>> This series uses the high level "allocation and monitoring association" term
>>> interchangeably for both of these meanings and doing so causes confusion.
>>>
>>> Please pick specific terms to refer to the CLOSID/RMID assigned to kernel mode vs
>>> whether the CLOSID/RMID assignment is enabled and use it throughout the series.
>>>
>>
>> Another attempt to capture all the details:
>>
>> "Privilege Level Zero Association (PLZA) enables the kernel to use a
>> different CLOSID and/or RMID than those used in user mode when
>> executing in kernel mode. CLOSID and RMID selection can be
>> configured independently.
> 
> First sentence already contains "and/or" so I think the last sentence can just
> be dropped.
> 

ok.

>>
>> The kernel mode CLOSID and RMID are specified by
>> MSR_IA32_PQR_PLZA_ASSOC.closid and MSR_IA32_PQR_PLZA_ASSOC.rmid,
>> respectively. plza_en activates the PLZA operation, while closid_en
>> and rmid_en independently control whether the corresponding kernel
>> mode CLOSID or RMID is used.
> 
> Please aim to provide higher level description than what can be seen
> from the patch.
> 

Ack.

>>
>> Make the register and its field layout available so kernel mode
>> allocation (CLOSID) and monitoring (RMID) selection can be
>> configured independently."
> 
> Apologies but I really do not understand why the "independently"
> distinction is needed since these values are always programmed together.

No problem. This looks good.

> 
> Here is an attempt, but it is written without knowing which terms you have
> picked to stick with:
> 
>    x86/resctrl: Add PLZA MSR definition and field layout
> 
>    Privilege Level Zero Association (PLZA) enables a CPU to use a different
>    CLOSID and/or RMID when executing in kernel mode than those used in user
>    mode.
> 
>    PLZA is programmed per CPU through MSR_IA32_PQR_PLZA_ASSOC, which contains
>    the kernel mode CLOSID and RMID, an enable bit for each, and a bit that
>    enables PLZA on the CPU. All fields except the PLZA enable bit must be
>    programmed identically on every CPU in a domain.
> 
>    Make the register and its field layout available in preparation for resctrl
>    support of kernel mode allocation and monitoring.
> 

thanks
Babu
