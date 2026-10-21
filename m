Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596979;
	b=vvRgVXgwSWBpQMq1yFE0FjH7rymz1GRwtq0xDK8ghASSdjp0LMhV+jO58LwFHrhuFFmy
	 pi58cQCfNFU4RbIhxolczC73vlr4ig28f/GXd3dAyPy+QRDadIRc14EPJovPtuuL5xeAB
	 4v8feK8gYyn5WXoLCkjTMLwIRWTs7uh6VIfSK2s/msh0JP7B5sAWQvAUPQKMaDxj74hXo
	 tC8ddSKTsywcBNWKcGVb5TcdTDkku4H0AWo6xvh/1aS3VA9/z39CgpsQDNkYE/oVmVG5I
	 1l0/UAdzoCKjkkljIByg0yNe8CMUPZ8P/zIx8TenTn9rkgjnt8bTE+5NU8RtNrBtkjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596979;
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
	bh=df9meDFROr+2jHat43CIxW4y0l25VAkiUlBaG58t0Rs=;
	b=lK1tcx2iVwDjR2wBS6pnrOsVNh4VzFhXUOPbOxmiMPJA8jurr939ogoWBghwROiVCvip
	 Y7DbOnEnJyON7nIPyRCKdIzig+1whsEo1JEw4uwjt9xwygAaGg/2MolVbz2yap1EGsqha
	 rDLZpTFCAWvF937youqDCia+V8WZOrwe+jiu/YB1Wv2KrHEdIL+vR/L+77O63zSQy5D44
	 Tk6N5tTuC9lFCu7IVHYLPsfIzf+QGBEYgLkgesorDbItx9ghpFs/9Wlt5eculEfkLaYjI
	 QJZYctzD1Ns0JdxVmasZk/c3LAuexC/PR13Sg1mNpJ2evaDYNVzfgTq5kt3U0hg5hvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MFTunO2f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47587606A31B;
	Wed, 21 Oct 2026 15:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47587606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MFTunO2f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpxupXUduYpKQjH3XWzB/nV+Dus7TTXyNJG0SDrnGMhWxPlWfHagZGQ8vdyucl67vMVctwR03nUS6CPufhwP9gMO5AyEERUI+d+QoW6O9takxa3v32atdtj2TVQkI7alvmJ7Fv4/kzB/uK9iKnjkMhg5cbdZKb1C1XRfc0nuevC8aluBoaeZfX7oeMPO9tVwnp+V8YHSYkOe5L3Cwi4VHdh2XQmeUQ+gr9jCGTpmhA9g/ObU5Uqe17NSWqOrXMVlDYWsbvV5c1Ofh7cGMRBVLt7aMFgG1/31QpYWK3cPsCNBRAI0OLhSO+eiFl28DeLOurl/qjd8blfBV5X+7DqRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df9meDFROr+2jHat43CIxW4y0l25VAkiUlBaG58t0Rs=;
 b=NE9voC1z+gTUrDLxSYat0vUEtEwH0bIpSJubVkJR6a2+AvhVVyGs534ctKJHCe3raGv/8xmaIP67/LlimT4M42ICcqSIrTGKCSJpDvDIXVwXuWCubvMF4z+3Y+cnZ8UpRvIiTLBdlvTpjZ3Bzusaar4ONwVp7sM9K7LrybO/DmTTs0BsR40m1s2sOtUT6AH+PEtDoblcOcv7gNo+xD153fUe8utXJQWLRIF8Yo1EqPreC7OjYV0sLrsZaPSZUchnM0W7SjoTO6vBB6xTqUS5lmWtDjLpvRa5QPivbO3gOqI+wbBSomjZY65MjJlEHiFNvZLz+iYrVq4hO9Cbgh8PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df9meDFROr+2jHat43CIxW4y0l25VAkiUlBaG58t0Rs=;
 b=MFTunO2fVhNogV7/8VUIQDmQQTxiYae4rtUKWMrizNmv7w9vMe8mLyHnN0+MDW0pjZTgdAOQuTlwfExraGfJdBkTAeX7nwh+xqTxdYeCdlmGf0rLrkQJJB3dF+7CdMmRFp9WmLY3/LczMm+bYz71qLai7cUZZIhnanwdHbFwQvI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:36:16 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:36:16 +0000
Message-ID: <bb109ba9-fbce-4593-8e38-a825a108aff7@amd.com>
Date: Wed, 21 Oct 2026 10:36:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] fs/resctrl: Introduce kmode_cpus/kmode_cpus_list
 per rdtgroup
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
 <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
 <0096fb82-4104-429a-bd69-7f733624c664@intel.com>
 <d7ba6551-adfc-4078-abd7-0f016d7a5dfa@amd.com>
 <5050b433-09ab-42d7-b837-033b192471a6@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <5050b433-09ab-42d7-b837-033b192471a6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:610:33::27) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 17121fd3-0ccc-4e48-8470-08df2f890ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|261009223027099003|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	RIk6/Sqylj01iJBU5RpCZ3ms7Iakoa93hs6lbrs5prapnCRUIBNG2/Fls6l8mXaqeHt8sI7uaEgRtSeW3p7cGX+8zY3IEMcJP2RKrwg3V/tzj9bNDYNTmRjuxCwLdNZafDP8vkA79jLmCYFPFDaydc2DqRiRWVCjkd59kKOK3r15PpeP0d26TGUpjuMD1zS9Tdeh2LhV2fRyk7LCCImp59Kd3CztDkC5sdewmkUxbn2KEERzPlKMXsxP4z1G9DNaO/NDUxz1zIj+S48G1mGlUJqUbevCFVXTEQdCkAt8gpUx3EeUrbPA+o9sxBPIGeJN6y3CDIMZO4l7Om82+VZuDB7Dp/AiPDK9TX0r8Y+dsy5TzcDn1WPf6kE4wDTMkUu4wbSIxABti8KrwL9tB6OjzKy9Nqv3VVKB56aW/uATycPra0o3C+WYB8B8B8mXkQ1sfAMF1TXBX8s4EAgzMxdpUf5rgsqbEAZOd3fv38a8JDC2TVZ4S+5MdqZqvk9EJZrBioDEHeYAn3B2cbCHa4e7zdhRKyr6h942tvDaExNyEBuaBzlmihOFscesSE6U8KgqjSGadIqNmPeEnihFsF1mxXjxusLMf1AYNqjO12FQzZnldigmvq+UvZ2+Iklv5ISL80DoYliCy6zM/fYbg0n1UO6dZF8XBsxlnXbSVxsmPk8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFdLWTVmb0M5R1Q5YUtMSFVaSWRDUHYwUHJPaUpYcTZBS05BUDV5QTU2cFlS?=
 =?utf-8?B?MjEyVk9XTGUrbEw3Y0xsZ2JiVXZ1dzcrSGJPSEpETmJrbldzeGNYOVF2Ylh1?=
 =?utf-8?B?bERsSWVlMjE4d0w5aHp4UkRFbXloa1g2RG5LRHE5aktaQndsRmlLUlM0aW9u?=
 =?utf-8?B?OWtJUVBUK2ZMOFZSazVmclgvN3c1MUtncUF4aDkzaWdDcFNSQldyc0l4MFgr?=
 =?utf-8?B?alJWZFdTRENIdGcrdEV0YlFKQWtkWlZuMWlwc2FOenUvd05xUHdpekZpRlBW?=
 =?utf-8?B?T3NiMVZrSy9jbUhxNm4yREFnMWtDQUdvTGdmS3BLcWZtS3dMN1ljd0hQSjAv?=
 =?utf-8?B?aDBUOFNLZHlWeFd2QlltL2VXV0tEOE1xY1Z2bERUR3pjYVhjYy83MERmc21w?=
 =?utf-8?B?WFZWeXZRWC9uaVNPcTgxdk1CbzMzYlpsb2J1b1kzUVIzY1ptdTRCMUg1OGJK?=
 =?utf-8?B?eGVCcnBkaGVTSm9QUTluWnhUNWN4TUNVTjBZVXNKMVFtSW5VVm9ROS81aUdu?=
 =?utf-8?B?ZG02RzFQdm1FLzJ2bERBY2hDYlJMYlVISVErdkdGUFBYaEFoODgrUHNsOGN0?=
 =?utf-8?B?ZjNDQ3BObHY0eThWeis2aW53RG1hUStHWnlSblJ0K2syR3ZJK3ZwVG9NbHds?=
 =?utf-8?B?cHhsZE56VEl0aDVheHFNVUJSamRZRVNkY0x6TlNWYUdyTkROcFdYUldqRFNE?=
 =?utf-8?B?SkdVTG4ycWdUZEEvK3hzY1hBY3N3UTBZVnkxY1hFRCtRY2FsU3JqMEN6MENl?=
 =?utf-8?B?NFFKVjdkVldFMGFmWGZNK0g1NXJ4MDdySVcrczk1TjlQRnI2Ylh4WENZYmY3?=
 =?utf-8?B?bmFLSHZ3ZXRDbzEwZEx3Q3dZNWhhMHFEZ1czZjF6NXR0VUh4MTNvSjloanpQ?=
 =?utf-8?B?aFYrK2tjNHJUcE15NnY5RWJQYmdROWU5MlI0SUFqZVl4SnBCL1hSKytwL0Iy?=
 =?utf-8?B?UDhRUHh1Y1UyaVVhcmFabng0c1VMa3ZtVnVQVWpoVjlFVHFCTkc4UHJhOVdl?=
 =?utf-8?B?T2M3OFkwaENZdTlZd0lkd0FFNDV6TC8xWUJDRVNvanZsRkJCMVZQZTYzNnRY?=
 =?utf-8?B?a2htckM2QUtBSGk0ZnVUSjBlMWFtVHdaTTlnSGs4eGxLNFRqKzZZcWsrUXI0?=
 =?utf-8?B?Ukt1eGdXWWRad1R3VGtLL3pqNWVXMzlFdTllUXdKVGVuZ3Rsem1YL094Rjkz?=
 =?utf-8?B?V0psb3ViREZuM2gyazdzQlNHQzRzV1RTcEZXYUZaZVJCNktRd1IySGlpRHl4?=
 =?utf-8?B?RGVrUzRXbCtHY1ZtdVI4ZE9tdVlMZWF6eFVFS2FBOU4rQzdQRXF1VU5BYUNh?=
 =?utf-8?B?bDhMZUV2WERyVWxEM2NuTENvU09hSUU3WG1NMXJ3NFZCa1BxL0ZheDk3dmVp?=
 =?utf-8?B?V1B6WTlYRFJvOFhXMjhSbUhNVnJya3Y4RTNCc0p0d3BSYlJlcW5ocVZMZ1lm?=
 =?utf-8?B?dkdlcXU3WjJrM3M1THBGaC9senZia0VKRUVSWmtrclFwUVNISWJXdU9jVGFi?=
 =?utf-8?B?YnpYV2xqVjlwRFBQMFNzQmFnbWVldTNwM3U4ZFdETlYrWkcxMmNISno0YjdJ?=
 =?utf-8?B?eDBya01pRHlPUDNwbk5hblJCN2VtdEg1VTEraVBvYjFLZWpjUHJiRlBhZlVq?=
 =?utf-8?B?Mk14anU4SXBrdGtqWXErVVJtUXRZSVlYYVdOVHNhRXR4b0t5UFAyZTkwMmw2?=
 =?utf-8?B?M0xGazlNWlBJU1BkU3lMUUJQcnFFdDFIbWlhU1BNVGxyRmlNR1piK09Ib1dU?=
 =?utf-8?B?MzR2Qlh3QWdZTjdBRFJZZDBteFMxblRORnd2aTcvaUxNMlJNOUVrMmRLc3JU?=
 =?utf-8?B?RDVFQU56T0tCTkpybDhQVVpWODNCZEJjQzBTSnEzOE1Lb21JWGlzUVhaQjN4?=
 =?utf-8?B?bkJpRFZTdGRWSC9OMkZvRVlMNW90QW9NNi9HRnp0L2dnTDYybGYwRmRXcUNk?=
 =?utf-8?B?em16Q1BtVjVwZ1hVdDhuV2I0SGk4LzlTQzJ2L3phUTY2VUREaXVYVHlCbFdE?=
 =?utf-8?B?d2VRZnFVeE1EOU9XaGh0eWJJMlc5M3hBYWo4SVlzY0ZhVmpoRVlOWHlzNGsr?=
 =?utf-8?B?MjF2K1RkTGNYS3ExNEJHanRLdFBPc1RGOHk0cG1xODI2Q1V3NnlIS3c5bUJC?=
 =?utf-8?B?WTZNbXZkM3ZIdGFiUEV6WDJtNEcwblZtMVpHN3hjMEZpRGtremdNa0N3Zkd0?=
 =?utf-8?B?Uks1aG9oSnRGUWtYMlBTK2pSaFN4SEdCS0YwZ3J3Qk4vZUNLTGVCUkVOdmpQ?=
 =?utf-8?B?NVlIWTgzUVltZU1LRUQrZTFiQVFOSG5NcXJreFJWSnFuZC9pdGpRTVRKVG1T?=
 =?utf-8?Q?Xsb/MsYeZPMRgHHoOf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17121fd3-0ccc-4e48-8470-08df2f890ba4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:36:16.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ragwTvIiBHv59NUOani7KTamoG64yLwqbRSsTg2+2LhJMZ5SKX92WpUEKo4NSWys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202

Hi Reinette,

On 10/19/26 11:34, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/26 2:33 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>>
>> On 10/15/2026 10:31 AM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode allows tasks to use different
>>>> allocation and monitoring associations when transitioning from user mode to
>>>
>>> Could "different allocation and monitoring associations" just be "different
>>> CLOSID and RMID" (in places where this is what it refers to)? Being specific
>>> and consistent with terms would make this so much easier to understand.
>>
>> I avoided using CLOSID and RMID terms in filesystem specific code. If you are ok with that then I will use these terms.
> 
> Why?
> 
> Internally resctrl filesystem has a CLOSID assigned to a control group, RMID
> assigned to a monitor group. When a user assigns a resource group to the global
> kernel mode the kernel mode is implicitly assigned a CLOSID and/or RMID. These are
> all part of the resctrl filesystem design. What is the benefit to avoid these specific
> terms when explaining the implementation details?
> 
> An important distinction is that in this feature the CLOSID and RMID values originate
> from a CTRL_MON or MON group assigned by user space. Any architecture where there is a
> dependency between CLOSID and RMID will already have accounted for that during the
> creation of the resource group. This is something that should be clear from the context
> when referring to CLOSID and RMID.

That helps. Thanks for the explanation.

> 
> The resctrl fs code even uses CLOSID and RMID in the API used to interact with the
> architecture:
> 	void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
> 						 u32 closid, bool assign_ctrl,
> 						 u32 rmid, bool assign_mon,
> 						 bool enable);
> 
> The only place where we should avoid using CLOSID and RMID is in anything
> exposed to user space since CLOSID and RMID has different meanings on different
> architectures.

Yeah, I need to come up with some generic terminology for this interface 
in resctrl.rst. I'll try to address it in the next revision.

Thanks,
Babu

