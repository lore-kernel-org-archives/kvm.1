Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50D38F95B;
	Wed,  7 Oct 2026 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416724; cv=fail; b=sSIE96m7elQBHEDzS5bkf5DLxJM+yHsbWR3J7vT5vdtojvjtlmr0ov8PKoqNAYtL5pDJfzdwYVB9KYOiaST0i/4crU73c4t2+sblcrCaLNuPGXmYTTSv4RiGwvo82laMEIuGhOzjE/2EAw2kdFqwZUqNDs6G7FgftOha0drwnE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416724; c=relaxed/simple;
	bh=JHy3BdiHCoMAt2HQOyST+ja8m2cFuvwrWpMe67lai+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ClEiA2SYb+XsRkNKzcl9zTjSWXw5hoDq29+fUBALFKrU+ZnxX4pBat86BXyrjHzUY/zFwuTjb/oFmBz8wGV3ySXLbZqE5o585UwXd5obIquVs2Y+CyEnagZ/ack9OpTPkUGm+cXHxGe6Ef8/vFMhw39SvYDerqyZsRKRD46/g4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iup9yB4g; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iup9yB4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYzGV0lQf6peqQdYw6LQUoQHo4wPquLD1PLKMfH3W1ueq8R22Yz+I2MgjUnxgeXOAm79FZlWbxNsl0zda7SDwp+yVFoiRQHF0hG5Ycz0WdnDQDfIjnwjON1YeogNOyYOvDFM3RwDpKLdtmgwANHpWzNlzhblOa7yL3vuR4I/4NeRSg24ANJz5seIyClyjNhe1PxotUevRACOLGxR44z1gtYh4sJNxQoH/0KkQ2uDWAL3FJogtVdyH5O0zNitmdXrNcvZ5UaNFjAcqTYQcVOgah32dHfrLZeNNEIlvBqTm6vmu+oWjtVvt0Kh6TEL6nYBqQkR7/7t3T+LZauqs56guA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kDd+XIjVcwbHS5+92QmB9fqvS/31RYC6YHWRdSYBF4=;
 b=wa0pnEgeTCVUkGk7iC8ywleIFBhBRGRt0DKPhKU1ilrHIv5lolPnDxDzU8jmGJYXMI3C8WhAJVOTR/nXbsFf4z/pU9Him4DZU/Es2RaV3m1Oc/GHXNG5o2uB+stOkdbOwMqqxUC+EkBOFgqQIJ//brKQhkNTaL9YkWPC+Z9ER+2hn++yu21xM+Ccb3kRJvmJlBwLa4vFeqwwoI/kashye/rTzvc3YRe6XPg1MHX/ywmnhyolqDA6HIegvR/7PTRMW+7vqz+IpJx5FxX50NsemV9ebKEw7xn83G9hpBFIO2A0N5LF9md2rj7S6+tAvLOqt40zDePYM36iDlTEd+M2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kDd+XIjVcwbHS5+92QmB9fqvS/31RYC6YHWRdSYBF4=;
 b=Iup9yB4gCS+j402tbXAtrptfJW+8EQyn1jRYc/9tnDQZhLnp5KrSAHywB0mEg8U80g5TI32jEDsfmYL7uoZEiXUIPC6Ji4JxuGsXbvORmY56vBbVi3k0bHW1V8+N1l8tBElLVbSgr6snaXNK11bBFyNKY37+DNghdKD3rMZ1zkk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 23:45:18 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 23:45:18 +0000
Message-ID: <fca1c9b5-b895-48a2-8c01-84cd7668d10c@amd.com>
Date: Wed, 7 Oct 2026 18:45:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1790976400.git.babu.moger@amd.com>
 <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
 <4afdd80e-45cd-4d42-b871-fb25e1fd5fa9@intel.com>
 <d40a16dd-2e3f-49b4-a36e-33b0ca8adf3f@amd.com>
 <a174730e-147e-4b7b-a8f8-e62f5709fef1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a174730e-147e-4b7b-a8f8-e62f5709fef1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:806:22::33) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fa195f-bf68-495d-efd8-08df24cd0afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kpB0tYrGWn1ZGotMA5NvFPwzeBiNV1YUwZldRFDmXdMa5jwgh7AYxPHpwNWLjvMhM9Uxy9XEv/lv2uV0oXVdBZjmbyy0vgBxf3b+30ibFLyBAeKqlqzsnABMLH/gRQKL23TLS4dBBWXmzGU4SVHHr2TG1h1KUtwbdrzgHomi3bNHM30PPRD/DiUoeKJ/bxfFLlN+bXbdoANgVD6fId9nCvEzHEygDtjmPt+3OGhpjoQi57ETVTvjqhUMWX3KYbT9E/C3yaYM5iCyo7cE7U7MXZM5wEuPSyP2/o+UNkMafJYpQ4F9FB0U0cZFBEXWK7121XAgpDxQCWN2BCycHs8V5sdqrBwqIDW0EShIfkEu6CKYsr7yz4vz7OlDkDJy2FC5Fg1ZtmFDtLHrqjh3sa7+cYR0E+DWTnfCooiX9ZyRhlGD0jHkDHiJutQBcKqaA/pFgwY1PGUIaEHbQHnyovwpKJMwpXin7BIFDnp6Y3CN7PMOcv0gqsGpVUKNHsAA746Q+SvAPWc0XDBgkJJ+Gl2DHcKixdHPKZg9SK53gbdZ0za5ZOBKzvIaqofsYoqcdnmI7QL7HDjVy45X8i8mYnUowmYf1WCtZWGzJ/x1WMEGG3TAceRBWwumPFznfJal9djbAHv9HUNGlrcidkwOmxSj5LMA0kiq/SpwL0oUw0TPk/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck5TV2NaTnB1THRQKzdSb3ZkWGZCN0g0VW5mWkxOSC81VlVOSEpyYk5FeXRE?=
 =?utf-8?B?eE0yVnBoZExZb0FsaWRGN3ptTER1MFl2dFFsWVllRDFMVUQ3SXIreXFJYndO?=
 =?utf-8?B?b1oyRG1IR1lYdG5EZzUrWnZIK29MS0EweXM5Kzg0OHMxNFNhbXl3a0x6L3hF?=
 =?utf-8?B?b3k1NGNZOUl2cG5RNXpCL1lvdWRYa0J4d2RhVTc5TTFJYnRGMEV1NGE2RWgz?=
 =?utf-8?B?NVhYbFJ0TjZBeW82UHdyOWVuT05kLzhmV09EaXlaWDIzeEs2YzRsVHlHR0RW?=
 =?utf-8?B?cnlwb1JjSUhVUlJVVFN4Vy9HNkhlMXYraWVQWEhsVkZ1UkV4cVBtNFo5cEFL?=
 =?utf-8?B?Uk1waEdVU0JLZmlKR0t5bndxR05QY0RBSHhGdHM5UHhIWGNvdm92WDlQS1hJ?=
 =?utf-8?B?dnhqenpOQ1Y1TlVuWVBzKzZ4M2xWdkVubm1ZL3g2azFZZ08zTWNORnpGU2ts?=
 =?utf-8?B?V1N2emRjK3pZZDlpVUVxUWI5NytWMDBzc2ZIdFg5L1M3UWgrc0tjRGtPSVRI?=
 =?utf-8?B?a0I4anMyd0FJUGxNYjFqVUxHS0U5bVRwam9mZTRDY0h0Rlo4aGUwdGNIU3Jx?=
 =?utf-8?B?V3p5bG91RkNta2YzdGNrV3N6SzgxZUZTMVZSYy9NVENFRXdvbUliVmlsUXBW?=
 =?utf-8?B?TjlZR1BrL3l0RVdpeHByK2t3bnptbldqVDN3RGxNRm41OEVIeENsRkVrdTV4?=
 =?utf-8?B?NEQ0SkpVUEZOMFhpaG93RWVIYUQ0dk1FY0xGUUkrTzRpWG12blh0Yi9RQm9G?=
 =?utf-8?B?Z2loRVpBenQwTTUySXpzdGxzTnBtVXJJc1I0QlRFNmtXMHFZZzZON0tzaXpz?=
 =?utf-8?B?RElTUFZDaitoWUJzRlFpMFBqbFh2Ulk5K09YaWJES2syZEFySU5KYnRnLzhz?=
 =?utf-8?B?NUV3R1JyZmJidWFCY3ZMcE8vRHN0SXpwZUJqUnFNMGs0eldmb0U3U1VFczFX?=
 =?utf-8?B?TjlYc0NyZ0FYTjE2MGxZNGNBYmp3NHRCV0o4TlFFWEhEMFAyRmhPc25rYWs4?=
 =?utf-8?B?MFFxNE52cE5CRXVKMzRmL1dRN25EOGdwbEZ1MmNKaHIwOHZtZHdCRnphdGdJ?=
 =?utf-8?B?bE5OTVNzL3M5eXN4ODBHeSswU2Y0eUdQclFOeFR3TzNWb2pYbW0wdUUzR29l?=
 =?utf-8?B?QktVQU5TUTQxMWl2M2tVK2FsMllFWmFHTHBIZEV3TS81OEFVdnFrR01qeE9T?=
 =?utf-8?B?SzJxVUlic0U2a09LS2V2aXJuVytMNFZCVktFcGNNV29ud2FYOXRkNnFrYWkv?=
 =?utf-8?B?N0tTa0wzaVRYYjVIbmMySDRTMHg5aGNnVVdkdHUraVEyS2tpMkR6RENwTG41?=
 =?utf-8?B?MXRMVnMzL2FiN1dCNmtlaGlZa2VvSS9sbHNHcHdVc1BSQmJVb296M01mc3hM?=
 =?utf-8?B?cEVHNXVLMXVPSlZNWGYyajQyZERRc3V5d0VMU0o4emxLZHdTVTB1VWNOY3Mz?=
 =?utf-8?B?UHhtWDhzRmxHNTA0SnFuSFNKbHM5Z3NrZnJodWNiYjlkZkFHVkl6S3hjNlhv?=
 =?utf-8?B?enZzTlhIS1V5VmZSdDlnMy9IUmhScmVYbWRnTkFHMWhWdjFId29LTHJYV3cz?=
 =?utf-8?B?a1BwdmpMZHVkbzBSRXl4cS81VU5SR1lkdU5Iekx4MVg3WFpIZXU3ckFmdEdm?=
 =?utf-8?B?WDR2Q01RVVNnMDFBTU94WDBwN3ZZc2pBbmI2dTZEVFFwanpWQk13c3RCWTEr?=
 =?utf-8?B?eFIraGcwSzlta1lEL2xwQnVpejZZc1BCZm83OVpURUpyNlNZdVRYOEpwVWxh?=
 =?utf-8?B?aDhXOEpvbDNjU2lLZWlBckRsbHhzZ1RjNlVMRVBmZFQ5N2IyMDFFVTdVMVA2?=
 =?utf-8?B?TkFXcDRVZjE5SzdhWThmUHJRNzZiVVlWY1NJU2k5OFk2Wi9YOW9vNVVCVGJS?=
 =?utf-8?B?amdyazZXZldaUGowV2kzNStmd1Jta2dHRk1OSWVHaHFlR2lpWjNwV3ZnbGR4?=
 =?utf-8?B?MVVMRDFCRWw0S1FyZUIxNDM1VFBxZGZpbS9uNi92VEY4MzVEWlcxNkxodWNF?=
 =?utf-8?B?Z01wUng1ZFNja3l1QmNkeFl3TXE1QU80dU9FVzZGajdHUm9SQW5pWEJoOGM3?=
 =?utf-8?B?bTROZU9lekg0Ti9tbXlFaHpqM0E5eUhTdTNDM0pjRVNZNXdaL2FKbCtOckNr?=
 =?utf-8?B?OC9HVkV5K1VjR05tbnRvWDlwYVBOQ1NZaEQ3Mk9KZUhiUFJkYldjUlRyL25w?=
 =?utf-8?B?Z0svUmRjT0F2WlVMU0VtTUJsOHpVYTNJaU0yMktSNlRuQlFObVNkM1NramFt?=
 =?utf-8?B?dUxvenorZG5YUGVmMmtUMUVOM2J5cnA0dzAwNTNSbitoVVA2WmVERFVWc0pw?=
 =?utf-8?Q?3nKA5J+AHiLsHZZECL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fa195f-bf68-495d-efd8-08df24cd0afd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 23:45:18.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3k7DiWMeCb7NeNBQor+WddiK3mDMALabF3ShdQhv1lWATSUkIA/5bQ2StaMuMt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

Hi Reinette,

On 10/7/2026 5:21 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/7/26 11:16 AM, Babu Moger wrote:
>> How about this?
>>
>> /*
>>   * rdtgroup_assign_cntrs() - Assign counters to MBM events.
>>   *
>>   * Each group can accommodate two counters per domain: one for the total
>>   * event and one for the local event. Assignments may fail due to the limited
>>   * number of counters. However, it is not necessary to return failure.
> 
> This drops the original motivation for why an error is not returned, leaving
> the claim that "it is not necessary" to return a failure without an explanation
> why.
> 
> An example that adds a motivation:
> 
>   /*
>    * rdtgroup_assign_cntrs() - Assign counters to enabled MBM events of a
>    *                         resource group
>    *
>    * Each group can accommodate two counters per domain: one for the total
>    * event and one for the local event. Assignments may fail due to the limited
>    * number of counters.
>    *
>    * Intended to be called in auto assignment scenarios ("mbm_assign_on_mkdir"
>    * enabled in "mbm_event" counter assignment mode) where counter assignment is
>    * not required to succeed. Thus no failure is returned. Users can modify the
>    * counter assignments afterwards if needed.
>    */
> 

Sounds good.
Thanks,
Babu
