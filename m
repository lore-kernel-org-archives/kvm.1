Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793128351;
	b=sn4uwX3hia0KPh3jqUcygRQYMtbhk9SAn5S+nvHzijCYzbZU3u//oV3r0yIYCvXfDhw4
	 RPlYGh4vNmdXAsb60MuI2z5faH88BEhCPth4X2sS5IPEUA+zmX+EnAJZUP6jpeIsx2Kwi
	 0H+PksUGI+AOrZlbPI1Hz3dwirhsP1BF1CVV/nHJEKNOz5lS+DaWSPMeCmPkTCXjG96AQ
	 sPqjDHGrgjYdTimvDixMTnTG43Tkvn6JOJnduNEfvqNHIaKSTeFfWOwTepRbU0RqifJd4
	 vIWEPsxNa4MBy21typ8CpYQwUzvxze8MSyxkhTHLaKYCtLggfnp1hKPgrQp6jsss1JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128351;
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
	bh=enKULTb73Mts2n5pmRSxAcbrjUxOHIXAJPmyub7JJFY=;
	b=me3p7KWFMwwvLoo/LvyG6yVfR+VIYYY/5sl+YhIt3HC4nvYJ9/Z6eBxEFbW0Z3M9qUk9
	 BtskQw2vnWcgO0oFGeddLBkGTSuqXVOcJslrMqCR0fWbkH+a/0qoaIsBg4eYIPojEeOMd
	 +E/BrSPtQT9Xai2ZRZOq/W3s1NryZmC4JN3Hqf10J+eG+BAWmEXyLRzLkYz3t7V/o1rOk
	 VDLbjEj5XbVwH5By4PdQ6xMUhZ6gbcNz16xMv3ohm/L0hS31yUkQ/w2xbkvc1RuKlhBTB
	 D/2g8XC7+V+yooHeAveq/KFNBxUQDYpyt/9plN7W+T+Fey81aXML91mCDbD7Ikca8jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jk5LgKuW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.0
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3B606A31D;
	Tue, 27 Oct 2026 19:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDC3B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jk5LgKuW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMWjDSCtC/LZUEBxoCJJxL1Etxi/j8oT4U6OzZ9xRlFvQZL/PeNOw22hhCFWJiD/wqMiAldcGVeEd3R3nsxqkS5G9BwB44C9QULlYVwlwXLl9+52hUBba9lgM28DLbyzm3HirvffHBTXrKMLP2ElnFJZPQ7kxmzWZ7aBzEHkIZJDi5ldB0RPe1TNMSvhHiYyfzN8srgzue9ac7a43mQz4EKv1G4TmQkXlnLTi+Yq07riJXqYvNKCQbcEul8Ju4Up7bZE0tDtYo5ZooOKv7weBJ+r45FocwQDWTxjy/oI0GK2huGU2JaiMZN7PyeQwTDpsEpO+XAIerRV4HfoCJtDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enKULTb73Mts2n5pmRSxAcbrjUxOHIXAJPmyub7JJFY=;
 b=Q7O0eRYDtLwHqSOLM9XrABbhiq7Nc9LDP1WDx/qNtrzIKDPSPUTlvwjdBa1koLvkbH/1CN3LnaiK/F8wNT7W21AtTIDFV6sUBgQRvJ5dLFxqtIoII/VY/eTs4FAE91GFDshZsnkTJWLzZT6msxu95c7DqDrfgZhhBMdWMopGtV7I/G0N7zrPURDHGlcrJGFM+RB/nLezAPO0IX1yJ4sYJopAMbCCxH8p61zCj916d/cDMEO+Etf4jGr8V3Dp5O9Ho/Sn53tYTCwQDCbDAk8vXe2dUPd/oMinmQCXfL3D0CpH+ABmJf5hmAs/ShCvlkMdPYLXOEIgTuiYALQx20dirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKULTb73Mts2n5pmRSxAcbrjUxOHIXAJPmyub7JJFY=;
 b=Jk5LgKuWFwFVuw3OWbJeSW49CmZILCRjNXeJlaVoVpKPKdEZMyCEaXXv4DtNgUkaqs2T5J/VVb0lLwrxeSbt5GCkqGmhOZTfoWa0l58vtEtu09UH2bEAfxe6k3s/TM7y8NU4boPPL9DS2gp1BN1vWB5mpW90RuZUhu+Zcsl7dU0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:12:28 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:12:27 +0000
Message-ID: <5135e588-0a73-4d1d-8e1e-7894e8b7089f@amd.com>
Date: Tue, 27 Oct 2026 14:12:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1792627082.git.babu.moger@amd.com>
 <1a8f3900e9e14ec19f5f7204fd64716eb0aa8427.1792627082.git.babu.moger@amd.com>
 <0082b675-5749-410c-9fec-9ce9b23b2498@intel.com>
 <9778fb3e-f5f8-4137-be2a-598cd44fc6f4@amd.com>
 <98597562-0c2c-4b32-a0b0-77777b8076c8@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <98597562-0c2c-4b32-a0b0-77777b8076c8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:59::30) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: d1570457-f1f4-4923-a753-08df345e3d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|4143699003|56012099006|261022075727099003|11063799006|261009223027099003|10067099003|261021121427099003|261022105027099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	MboWlXes7kA+RQ4Qi7JkKh2I8GAsgRS/aSklBY45TDLfkT47gn/ts7auK7iuQKg+RqQ11e5l+sRLkexIAtd6z82URmUgvPn/jCvTDwhtLrjYrNbdS1LsK5zz61U6SOfJ21N/4sPd6kx+OUW4NlaQ2DN163Rbplp1KAZKHtdORL4rX/CBqXxXOAtBg9fNo6v6Ql/BtGgW8ryp6jAC8NKMaGOVHAvHPGezvcSVCyjdcFi/3nL1+daxbFxNt2RwRccfQOZQPoXVWJgscK9lMYfikIzhMy34A7i9FWC6QkUjVEsZv/YHHt9L5NCeZshcrMfg3EphWZSdV5lwqhyGhNTRqU4f0alkdVemkGIJyIUvJVnyfGDRGD+SKG42vvnPZQ19QJV59vfIR4bINXoOPhbqoIH93gzzLaWitKA7V+F1IjExsR7jlvUns1aH9vXYV7crkO7Jc7Biu9H5zfNScLEEk6gpYkDQt9mNreJC0/WwO3ag6GcDmQUbfFPLTeF35hKjwPIwUIjEnL/mkYbrOW90jYY9VRg2UI7njr2hC9p2ZZRl78C6z7YK+/y1YAnYwnn63eAXPbXac3TnYGphtkZ70pE39YbDe896CT+Dd4RVeyJxzYkK+sWgiPvCtJy5qhaJVAAa5m+mGT4dwavngBLB7aS5bU98DdH361IsvHw8k80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(4143699003)(56012099006)(261022075727099003)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(261022105027099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmxsak9VSzhYTmlVeDdiam90V1BhTUIzdVhJazdsYU9lalM4Z2diaEs4SWM5?=
 =?utf-8?B?RmZ2cGZ2a2l3MzJ2SGcrVkdRNlBOVWV4TVFPbnVVVlFmTGQ4S1hhblhQMXBn?=
 =?utf-8?B?eDRnTUppZFpFd3dKZ0N6djQxZVhtV2dkVisza3hocVVKd3V0dzBJS090KzdQ?=
 =?utf-8?B?a1RKRnRZV1M0MHpiYTF1Rk1hanAzZlFsMzdKaWhqSnFPT05FdjhtNXMxbGhO?=
 =?utf-8?B?N29xdEN5R1JZQmRPeDdNeTk0OHBodTJKcWJqLzNRRkcwMzJrVC9tRlZCYjBR?=
 =?utf-8?B?RGxHT2dQbEttQW1Kb2JjSVdKRllBR2xseHFGczN5TjhKVTQybmRpbFZKQ3Ni?=
 =?utf-8?B?ZmtNS3kwTERzOGZhcitsZVpoNVJzaUhBL0dzZjBidHVleHAxbWF5MUFjUGNS?=
 =?utf-8?B?VWhpUXVidm00N1JVQTJ4blBPaXFtN3RjWXJ5bWI0NkM2a29NVjlWcnFMVEJR?=
 =?utf-8?B?a3R4aGRPMlZLdlBPSDBnQk9rT0o2dm9aenU5Wko3VjFhQ3VtVmx6UW9nNmRl?=
 =?utf-8?B?OUM1eUdtVGc1dXNDSGRHYXltajk0L1FNalhLREx2dHRNZGdIcDYybVlzc0kv?=
 =?utf-8?B?SnlKaXczQWZXV1ZWZ1Z5UFFHOHo1QW1YZ2dsanRCNjlMc2YxZFJMcG5RMlhF?=
 =?utf-8?B?c3E5cG9BbWtNQTVaNnlCNkRIY0ZQWURaVk9xZUVFRG5ya0NvRmdaYy9pVEtD?=
 =?utf-8?B?TDZzQ2RMRitRdnlyZjZJUXY1WFluUitVV0pKSmgwbU1UQ0Myak1qVVh0Z3R2?=
 =?utf-8?B?R3Vua09KdTE5TmdFR0QwVU5MREsrRVdWMGlreGIwNWZqTHZaY2g0dzFuQTVJ?=
 =?utf-8?B?STJQTEJtZkNzcTgxYnZRSk0rQVh1NmoyOEJ1bzJGZ0RpN2R1WG5HT1g4c05C?=
 =?utf-8?B?emVmSjE3TUxoQVQzRmFqdnFJYmFjeDFrM1YyOVJyOUZWUmNSRkpmTTl6bHN2?=
 =?utf-8?B?Q3FkNDhNTXFSaDI4VkVFdTdqNTV4NnZjQjh4ZFVZeHR0S0w2dkpMNUEvNmlH?=
 =?utf-8?B?MkVFb3BVYnl0NkNXVFh5RUIzRE5EbTVTdzN0VXRITnhDcHEzR3ZMejhBbHQz?=
 =?utf-8?B?aVZvWXJVQnFlNkFNbnc1U3NtendndkdubGkvbmo4VUVEbkg0WjFWdUNHY3dH?=
 =?utf-8?B?cU1jZUJ5R1lwMG11KzkvNW95UzNMWVBISUlqcmh2V3hSRnF3YUxaUWJNNjFI?=
 =?utf-8?B?bFhtNmlBYTVmajVod0dSWXdUaFBSczNFTWoveE54SThaTnFZbEpRUWkxWGZw?=
 =?utf-8?B?d2ZCa3lCRmEvV2NGV2xVSXJsbWlrVmxVaWxiN0ErZFF2NlM0c0MvN0QyTTEz?=
 =?utf-8?B?Z1BET3pJNlhqSHE2Vkh0WUZMeEpPWkFKSUJ4OUY1TzdUUUFoT0JZbnZTY3dE?=
 =?utf-8?B?WUlmV29pdDIzOU9SekR3V1J2UnJMTTRuSDRsajRETWVGUUdaclhlTWR5bVFX?=
 =?utf-8?B?VnBOL1BOZjZ0Nm1tb3JKRitmdzUzL3QzSGh1eDk3SDBCUFlzYStuK25JczM4?=
 =?utf-8?B?emlmcFFUTGt2QXhTRFhja2xYaW50QmN1RllzVmhnZW5TcnQ1MTZLQUxhSzJD?=
 =?utf-8?B?ZmZlaWJFR1lpL2VMREV2SEpMbTRDcmQ5WU0vM0J6ZGZNbFNUQlJrVGM0ZnFh?=
 =?utf-8?B?NkpQRGlkeDJ6TUdPbkcwNnc4bHdrNnAzSFE1QW9GSGkxZVB4a1d3cjVCM0E4?=
 =?utf-8?B?QW01MXpBODJ6UTloY1lqWXE5TVRHb0FUQjk5WW5lVkNIZ1ZYTzNPS1k4dEp0?=
 =?utf-8?B?RndRK3V6cWt1by9KVENRQnNlUlNNdGtoWnJnMHlCYy9Fbkp0Z3lmVzFyaDZ3?=
 =?utf-8?B?U2plRDNUUmFYRjl0V2x5WFFQMHBBbjJ3WlpZMjI2d3I4bWFWY01EMjRJeW1F?=
 =?utf-8?B?WEpjMXdIMlhiQ1JYVVFzWk0wb3I4VWVISWprNXlIU3dpR2RrYVhhQktQWnF5?=
 =?utf-8?B?ay9TblIwREhlaXl3YTh6UDROYXVEYU43NG9JNGE5Tm8xdFVEb2FMYTZMOUV6?=
 =?utf-8?B?c1RuMVNHSzROVGl3czNMYkt6UEVrUTVST2Q2eE45aEdaOHJUZEZ1d2VXaTN2?=
 =?utf-8?B?WUlINDBkbjNzZ0NWckg4c2ljRFhDOGxLZHdUd0VYcldFS1VrSkNXeExRT3Vu?=
 =?utf-8?B?aVNRNlY4eTBlcjRESHVKSlFNOHpDemtLc0VUNnk3Q2Myek9TRjhxWDc0SWQ3?=
 =?utf-8?B?MXp4YWxSTVV6V1ZsdGhpNW8xSHArMGlHNWZsYk41VEl5WUozcGVEVW5MRHJM?=
 =?utf-8?B?aTFycTJEdkhwSjBUb2NZUmdQTTl4eTVKMlNYc0ptRjE0UFN4c1pDOUFadExT?=
 =?utf-8?Q?pU8TfqCSbntYe/Ie6L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1570457-f1f4-4923-a753-08df345e3d43
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:12:27.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLmZqiUUfbom5t292AVPLCVBbpsH9b51Hqi53LUvOpdCo8oYfUm15/RsOSh4hvWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679

Hi Reinette,

On 10/27/26 11:36, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/27/26 7:48 AM, Babu Moger wrote:
>> On 10/26/26 19:15, Reinette Chatre wrote:
>>> On 10/21/26 4:58 PM, Babu Moger wrote:
> 
> ...
> 
>>>
>>>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>> +  [default]
>>>> +  mbm_event
>>>> +
>>>> +The "default" mode is enabled. "mbm_event" is supported but not enabled.
>>>>    +b. Enable "mbm_event" mode. Switching the mbm_assign_mode may
>>>> +reset all the MBM counters (and thus all MBM events) of all the resctrl groups.
>>>> +::
>>>> +
>>>> +  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>      [mbm_event]
>>>>      default
>>>>    
>>>
>>> The above changes could be merged together under a single step "a" that
>>> will significantly reduce the churn when considering this is a stable patch.
>>
>> Yes. We can. But because of auto assign is not enabled on mode switch, we still have to touch few steps. Your choice.
> 
> Understood. The benefit here is that the patch will only change actual information.
> 
> Specifically, changes like the two below that just updates the letter
> associated with the step:
> 
>>>> -b. Check how many assignable counters are supported.
>>>> +c. Check how many assignable counters are supported.
>>>>    ::
>>>>        # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>>>      0=32;1=32

Yea. This will be dropped.>
> and
> 
>>>>    -c. Check how many assignable counters are available for assignment in each domain.
>>>> +d. Check how many assignable counters are available for assignment in each domain.
>>>>    ::
> 
> will be dropped from the patch. They distract from the core change and do not
> seem appropriate for a patch headed to stable.

Actually, the step (d) will be partially dropped as assignable counters 
changed from 30 to 32 without auto-assignment.

   # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
-  0=30;1=30
+  0=32;1=32


Will send the updated series later this week.

Also, noticed a minor typo:

-  # cat /sys/fs/resctrl/mbm_L3_assignment
+  # cat /sys/fs/resctrl/mbm_L3_assignments


Thanks
Babu


