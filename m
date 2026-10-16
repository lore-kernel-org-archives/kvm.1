Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830014DD3B5;
	Fri, 16 Oct 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165878; cv=fail; b=j5dHYGVhBWC3Xm830+mSF1I8C8/ql4jCyLdBxhOiMP1cGe66XytnB7KWsd77udz1tWWO533i1NxxspkhJsWGM9Y+/75V4fpIo+sMivmfqDbmb5xB0nEnL9q1aqPh44BC2qWTE+ktO+tiGpF25D3fU5QkszpSplhFAMwCs5LWCys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165878; c=relaxed/simple;
	bh=xJFS5ZHmrA36UwRimDLWeAxPunwJRIArilrpUPmhWcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OwgbnO/7wjpKTsybtT0u0WO/nO8yDSKH4Oega43OdcWVV1wwdiSor26cnOzc6jfUWIqGX8Gh4Fkin/cVyNPiNENZU9BZTMKQlFiKQwbZ2Wgamx+jWkBlD9gC/f1SLucIhbRycVuaTy24AXNpgY9HcxRTW6W1tgvMPN5OmxH3eTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WbSO8NUF; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WbSO8NUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDi6rCaIXHXEyuzymlFdJJKlA5wHkdbJ6VYHNjuSYDZmZ6sUxbn2snnTiSlxVuiz7fLu5+wxnP0J6k86TWTGjCyfy9ib1vyeSBFQipturuydXwNpHJ1ap2w0/QiIeoPmhRbx3D21TtJPIgBqwat4r+aiyW519TDvDFY/PrETggVoCTecrD/owJqde0PK/OhUGfmg4JnNyl4DwK6NlkhuQw7fcFNm+PSs8HPzym+MY8bhHNQcXG590qgIx5uyV486YBWqqFuBlTGomq6L5g2DUNp+5JYPlbEQnSPVNwrZGtJfBj3FJWK7g2P85jaVEhcLO2cAUTRiGe4wkCGHrUzxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccMvktBl/Wixz9VRLF1EnsnxWwd7e9jNRcVPk1eUWjw=;
 b=Q9svggORrPtWol4RSSlLkTPFrlmTgNT6gMFeDfJMJOdQcv2z6JyHNzD/OKu+EA8th3mQlAblkTDlMYH5ehJa88XgFFXf2DuWeDWPLcD1ofRK4O8ou3Ejm8ojmwu4Hgt+tqzkKvFq0MSwxWH0JqYPIsg2/tmnbz/D+UF5RsV2AGD/S/5WbH7oEYE5zICuERcvQ6fjSSPTUhOF3prj16YJXp901K0FPyv1bBZ/nrfBO1vMDWrvOqiKHFJ4+6I00LzCHZPbCbwu37Kk75Pnjdkbp/Xfm6Cv5+wwWJ3oE5DouubPR4gz5jWzPK/ZPGlWWNdC+48xV2W7bKPmtJgwS6Y6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccMvktBl/Wixz9VRLF1EnsnxWwd7e9jNRcVPk1eUWjw=;
 b=WbSO8NUF0vef4gLGJIF8myOuxEuO8uiayn3HRcOogtmiHMgGhOdzhSZlgKZBsj1uJNsaLcuL9TLOC2AnTaKIVHmDjqQdScs9yh7fQJldGHUpEtt21JERZsmSlKLJeVlb0iLvCT4YPnonYn6FPVXyooSaUASzDohZ52LMa1Ar5DA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:51:10 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:51:10 +0000
Message-ID: <efe71c1b-00c4-46e3-8cfe-31020f6ff74d@amd.com>
Date: Fri, 16 Oct 2026 10:50:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/18] x86/resctrl: Register
 RESCTRL_GLOBAL_ENABLE_PER_CPU when PLZA is available
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
 <05717f15f11f9e11f6b2a2737f4ed2f01fd9733b.1790867441.git.babu.moger@amd.com>
 <b3f44e74-dbb6-428d-a746-618b7288df5c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b3f44e74-dbb6-428d-a746-618b7288df5c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:510:23d::26) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c22056-bfa6-4217-6a63-08df2b9d4c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JX+dWmYpT30X0ncrY7OBxKUvUabZ/jTwgNJAFRqjoibkQAmCxreoVFIDWH3nwcsrirdfxM2wtx2zxRDDI+Ej4UjDG/ezN5wkXSG0xU0ppU/iKYWfxQJMRUfe4C3giteKmyw/ATDN57KxByRHWuaOOAWx5XuENSCqdyKV0o8Cip+Yx2WBHwzH5NRhTWTOHYTMHNW9enAe1gjVIAsS5WK9ygqz90K8relC9iyB8WukwLvlnhN1JFtO+SHg8eYLbtCR2zUezBjvHd0nQrdpwvcOikDbIXQPLRmhkRqbhgPg3ohKC67yqSOGLlNhrQ4DhFPjs5DrUpitknJWetE8cDt6idg23kdDN2J3HFmW/1YcX1IRabotXrnsFQMKRSNm1eNJ9ylcOKa8ZcZIxa7U9/PCzpIK/FHBrN9n67k7N/5uadaPk4a4TDtt0WbgoDEmCx6qWeOKmvAo8KD0hF9tc2ZCwkkHz2V/t4BI+WZT3d1AK+Ki+CUe/qEL5PcLsfHViqowtDrkcD8b37D7yag+5669Kt0/gOSkp8j/GRHpoA5FGDutY4BwGTfCt4ASi1GinCKXIpIrbxCO17cR0py1WppjrH/wTXaZQzcORkrQvnxALDpQyoEBjRcRkzmRzV4Z/GFULD+5p3ywnQxKZNkQFxKhJEWQu2W7nfCZGyjBBUFJ0J0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0RtWU4yQjh4d3NHNTBLeVkrVUkrMjk0UTE0NTJUYjNyT21nNkF5em9EcjFv?=
 =?utf-8?B?d3htTndJSXJsbytZaHdGYy9YNXlIZ1VnUG5tNkMrNVpIYTcvNTB5NzZzS3I2?=
 =?utf-8?B?NU5iS1hEOFJKdTdpK1lSN2lRY0lxcWtEQk9oSC9mTW96NEdzU1J6ZVA0c1VD?=
 =?utf-8?B?TDNIRlJzSmZxNnZSWVhoTmtEeElzRmp5ZFlKOHlOSkJHWGF4S3gxM2RhOTVz?=
 =?utf-8?B?M1lxei9EZzBUNmYrUmV3YnllWVpteWFwOFFDSnJEdm8yam94UTlra0RiZmV5?=
 =?utf-8?B?Q1pjdWxCeDc5VGJxYW10U0phK2V1NWRTU1J3WmZWbzNieGU2T0lkR2k5V1l1?=
 =?utf-8?B?a3duQU9lMmNRY3IwSWUweUlVM200aHJpK3JmcTVsYWVxL25ldXIwUlVVbnFC?=
 =?utf-8?B?UEFzeCszUU5vQUZWanJIU2Y5Q3ZwTFA3dDBhNkdReko2TW4rRGFweXdFWi9P?=
 =?utf-8?B?Snh5Vi9UbDg1dDJ1cTFzMGEzYlJ5V3Y0YWFPem9nOG54ZTBMTlg5Rm1iRWV0?=
 =?utf-8?B?RFFSUXVjeW1zaWFwdlJjUGI4ejIyVmo1ZDIzU3dKckVBdVk3OFVGaXlreEU4?=
 =?utf-8?B?L3YzOXdGcTQydTVwSk9LRzdROVlScHJOZ2tlRXFIOGpQTnE1OTZSOHFKN3hw?=
 =?utf-8?B?T3hiTmQ1UlEyOURLVDBPb21uR2hCWUlES3B6eS9CaXZuaHJsSFNBSUhrdy9s?=
 =?utf-8?B?bU1BeWQrdlFyZXZnNGtiY2orUnJXZ0ZkaWxIa1lVRUdSSWQyby92TllrRlF0?=
 =?utf-8?B?cHl6UWk0ZTNwSzlpWFRMYmZIdXcyZmZMbnlSOW9CTzFTMzdSWVBxWmVJSWh6?=
 =?utf-8?B?QWxpMExrNEc2eDZ5eXNHUmJtUm1GRzlqVXM2eE9lSWpKaXIrUVhwV2RBdktP?=
 =?utf-8?B?TFAzeW1USW80ZXJpWk5ZTDBTc2JTY1d2QVJBWDR4TTVCQlNIR091NExPUFJr?=
 =?utf-8?B?aUV0MkVyeXNtS0wwTXlFajZsMVZhRFNRa0FpRWxwcU5ZaUtyMGdBdnZhMUIy?=
 =?utf-8?B?ckVwbm9GcHhGZy9IZnlSeDRwK0J0ZzVuck5taGo3aklnQlFSazdYeS91Y3Jo?=
 =?utf-8?B?YVNVallveFZpREFvNHlsdEJkTkFmdEJZdU1ReVBQNVF2Q0ljT09kN1JDbi9P?=
 =?utf-8?B?ZEFoQ0lPM1Y5bDV1VEZtNkdxY20wY3RNNWVRU3JtWnI4OUpWT3ZlYmhKUnJH?=
 =?utf-8?B?RFpwNkFkQUxDSkExMXl2S0RkTWVvUDc3Z3RuV0NFUEI5aHJrK1RGNEhZdUZ5?=
 =?utf-8?B?SDMxd3FCY2ZPQXFuK0VYbFpzVkJDTGZ4WFYwMDU5NkxQMFZCZytKcHR0aHRC?=
 =?utf-8?B?c2ZrcERIZ25Kb0hscEw0UEVmK29CejVveEtBc3E5VEh0MUQzaGIzTW1oZEMz?=
 =?utf-8?B?ZzlENk1kR2JrdzJNYUNBVXdFZ1lOVlB4ZXVqSmdSRTQzSmRwOXRWZzFoMVEz?=
 =?utf-8?B?Zlcybm5kcTl5bE5nSUx6KzhXRythQldlOVYzM3J3d21saWYrVkM1ZHY4eEEw?=
 =?utf-8?B?NlZYaTIvOFZzWnlCeC9DZEFmc2gwNEZ4bTlVSDJLMzdzYkpKSEpHcXJDekZD?=
 =?utf-8?B?a3NYUEJUUGxQY280ZEFnTklSeUNJeDBCS2VMZW4rcG5MTW92TUVSVzZSd3Rx?=
 =?utf-8?B?QjJUcXhDWlE2MTl1aTBhMzN4ODJZeVJzcTQwdU1ERTdFMVpHTlZUY0w1RVlS?=
 =?utf-8?B?ZDY0OVVubVhLRGtBdTI4R0Nnc01ITmoycXBWV0VVcnFVUGV2UUJwSEVTYUoz?=
 =?utf-8?B?dnJDVE14OGx4UTJaNFlXZmYzb3lyWTlwRkVoOWVFc1B2b0k4N2JvV0J4VzVF?=
 =?utf-8?B?eWZQa0UwY1BXSDZXaWlmMXl2dy9hUmVxTlNJajF2TGhPNXFKY1N0enRicEtF?=
 =?utf-8?B?SGV5TzBtRVpsZ0txNzNiOFBralJPQUN5NnJJMDJpaGRPakZRWTlSN0szTXVu?=
 =?utf-8?B?K0xMbFR6UTZjZHNpV3I4RkFuMXQ5MkIwclhCK3hxWTRaeFVSOHBObmxQR3k4?=
 =?utf-8?B?VkEvOEIxYy85SzQwczM3dlZkM3lpa0kxRCtiM24zYkFyQytVYjU3aVhUVnVZ?=
 =?utf-8?B?NUtlbndsOUp1U0syWnhKZjFBTHBJMTVBOWJOaVMrS2p5ZVhlNEtnc0NMR1JJ?=
 =?utf-8?B?ZXJwUnpZQ0JycDVCUmNNRU1xU3RtZk92MmpvUWV6S1ZaZ0tSYk9yUVQvRnBw?=
 =?utf-8?B?eXpGT2p3Qmgxekl2MVJndXhtbE96UG41WGRVdUtxUWw0bnZQdnd2WDVIdU02?=
 =?utf-8?B?d3BxYVV4N0U2OG12bThCYVB3U29HMXRRam9pWU1ZMWxWb2FKWVhZUUxudlJO?=
 =?utf-8?Q?X1jn1+bpjhkyoJ1ay9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c22056-bfa6-4217-6a63-08df2b9d4c95
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:51:10.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJAXRJksiQRERWyG+n/Pb78Rmj9smXvjNAEC9cLkWVWQMZhfd3woDyFmNX35JO0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

Hi Reinette,

On 10/15/2026 9:46 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> PLZA (Privilege Level Zero Association) provides the global per-CPU kernel
>> mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allowing kernel work to use allocation
>> and monitoring associations that differ from user tasks.
>>
>> Add x86 support for this kernel mode and make it available through the
> 
> nit: This patch does not add any support, it just registers the mode
> with resctrl fs (as the subject already indicates). Didn't patch #5 already
> claim to add support?

Yes. Will change it to:

PLZA (Privilege Level Zero Association) provides the global per-CPU
kernel mode, RESCTRL_GLOBAL_ENABLE_PER_CPU, allowing kernel work to use
allocation and monitoring associations that differ from user tasks.

Register the PLZA kernel mode with the resctrl kernel mode
infrastructure so it can be exposed through the resctrl filesystem.


Thanks
Babu
