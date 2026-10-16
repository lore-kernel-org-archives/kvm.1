Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB584CF480;
	Fri, 16 Oct 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177831; cv=fail; b=kQvWuUyPMzTw76i64MwT21lGg7N9qmbnqgIDh6PNfqn3H0slESVLrNo3lKKDTSTkNTWs4TFmFFrPQFBK4ZPKjGwUmWNH6XFkp//4WnukUZpVY8Oim/q1xmviX44UndjjIF7o/X7Wb4fbet1hbBAnX1yQxAR3APapS7155ibjMyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177831; c=relaxed/simple;
	bh=LDTQ6O9iqyU35Zqoz0o2NEEpsH18uWP0j7ZCPL8Oeo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6wrUlAx4mP0z2lqYjQgPPcivmfQ+aZI8BICnaQrNjAGqFRnFPH4OI0V0oH1d8XNx7GK+cQcy20cgIrzbO0dbO1Bq0+mLK8iEQt9Fz4J8MS90GSZha8Q0VFHtmagEuxVTN+qGIJaH2u2199G+H8uwjkzadFqWNFTMdrppGEIbsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oBjxFFKe; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oBjxFFKe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SroybyN4ntJQinD6EgMngVGJQxMse+asmONp1G2xzdNmi2N2sWbzEqZnjXa8U2Qf1uNJlqm4nQ9heWj5YtWADe3f2hhu7GbaKpMpeV65RL0dHrFhlWLy9PruCu4A8uFjXW6YgaD4xy6qt/BsMBc/h/p61o8IunTjNAjYw9ROQ+oYIqsRHm+mkP6nN/n2vx377qwMkSwzUrfcovbjeG0zUN02J/iZOvA/QLdjWvlp5AIt5v6AoqJ78C+CNGP0PEFCqMosvR125zs8JEvjSLTEFtyhsNrxE5Kxl9qJNiO5hr8zqHcYQ/VJm83k363rxFRLiW1U2McnUumEBomFzloWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUeECETb4nQamasCRaoOiUWQRkLne8+9Xp9q5cLlOjA=;
 b=dxa7bmxYCx07x9SkC5+53B3RC7bbnVBF7ZkeSgMBpwSt/Q7XkRHZZyBBhHzMydKnpDqf3PNgbv3rX7VOVjuLZ0yiZ2ijjERWCSHVVsKhgxnAXggn7K7BxTBeYHmBN/camqabqsv1KDQjar7coDvTMjBgXqJVA3bZLKCc8U7H7IfczQTzBtBZxE6UT/sBUEx805SGf+B5EH2d4ZLzQ/y2PeNBYY3f3JTc2b8JPUX7NpWDzZ54IGDtsYnQOXKDhN7qT5GZVhjaQUdkLmZl7RcBs1GQfULDXTjcPvD1pEOLwAv0rnN6mIZJpjV0xQJYBBeMzzCZGkjTLbGPGWETp30RIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUeECETb4nQamasCRaoOiUWQRkLne8+9Xp9q5cLlOjA=;
 b=oBjxFFKeGWl6ZastcKB5avCB8wCvWAtpPp/edE8s7G0ey+c4wg5NHE9H4pSC1OoSaYW7+Am+G6FyEXnin4xoKIOSUx3FwA+iUFu/CfDhTQh3it9M4h8NBrjldjqZzum1BvV+cv70zuVOdOiw0TEOcWjuIWLw9DBMccjmT9vBRiY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH6PR12MB220232.namprd12.prod.outlook.com (2603:10b6:510:3da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:10:26 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 19:10:26 +0000
Message-ID: <f0bb62e7-3044-4248-9f4d-c6a8f23de7b9@amd.com>
Date: Fri, 16 Oct 2026 14:10:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] fs/resctrl: Add interface to display kernel mode
 status
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
 <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
 <7d4770b8-779a-4c7a-b5cd-cd3739172a92@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <7d4770b8-779a-4c7a-b5cd-cd3739172a92@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:d3::20) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH6PR12MB220232:EE_
X-MS-Office365-Filtering-Correlation-Id: 77487157-f4dc-4f45-7a9f-08df2bb922cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|8126099003|22082099003|18002099003|3023799007|4143699003|5023799004|11063799006|10067099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	lHd9kD9uNaMDk4+3NXjOO6Ft9tfC/1sPmDVSG1yyhofMg4azWFn9tSUjhWX7+L4fcYBhTXxTsw35SiPSSF2MD5cCGuzyrRubXaMiDU0dIWVM4euU7sx+cfPz/XaGzt9n6mYzpvPuKEUkwuR9htLvQgfHVluSku5khcBId2r5JRN/5tfL79WCv4SsjziPPgJ2PSr29SzQsyKbZ85VzhZlhy6lHeTgIY3E1XSG7FMBMqeFX69doRgjrGKLgYsGZBIqWMBQ5mlCSE6iG+sC1MSE6C3rX6ynTjQFAJrdTCXKD8JULfYyU8RrwvXvWSn+bSrPyK9mNqXuQXD5lmFw1SBoSEzneMvrh/2tl9wp2spUdPxKco4/22R5hSThH0qASPNjQDEksph+sYH/noVDekJeMyyDf1SLpvesC7jJ8vnwP/oSD2S7AFMk7QdfgdDG1tgfx+dTEdqXnqYZNcDtJYJxaFI3i71CKW4fpt4TmzigHM0E62MdJ3PgDoesdiVzSIiQMXXLbUwPTrourmaPpj093ehn9d9An/KaLbKZQVYA/LDlSiEUw7Y7yucCMa0creH/7OwCu8wYcDHC6o8cfWBfnibQdMv6iJKpraIqpgef1W5XyIGQNYQvKLChuyB3c2DRI55BG+7ofuKZAyfdfOOVJGL6qaleuWgJwu3eAoo6VpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(8126099003)(22082099003)(18002099003)(3023799007)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGNOT0hWL0RoTnZxNUpmZ2JaYm5kYXpEMlc3V0U5TU5nRWxjNGNMM2JWdHkr?=
 =?utf-8?B?WStJZFJZcXNBV2lmVDFtZWpMWi9oWlZkaCtmVUJNWmozbWJ3b0g0a1plcFEz?=
 =?utf-8?B?cHhiakZQTEZDdTdTdjJ4WVliUnhrL0RDSDFyUG9vWXgveE5SUUxRT0ZDeGh0?=
 =?utf-8?B?eWJ4eTBrWm1JREx3dEZXV1Q2SHRib0ZZT011bEhnblFmdTBRWDloaXhwd0dy?=
 =?utf-8?B?V3VUMzJLVEJZbC9OSWJidUZQRElFcFdJbGNKdFh4dmVoSWd5d3Z5cGk5T3pj?=
 =?utf-8?B?YUFxaW5zV2ZkeVcvdFAyeWc0L0pRMmdtODZtNlpvRGF1Vm9ZeUZFYWh1WXJT?=
 =?utf-8?B?a3YvT0cxMmliWFluVGtuQk03S1NHTWs2OFgvcUxGSkRpdmliaXpBdUtwZmx3?=
 =?utf-8?B?TlpqSUlFelpVRFhWRU9PRVhSWFVOS09ROTVOZ0pqbXlvbllFN3p1bGtqU05E?=
 =?utf-8?B?SmUzRDhrbXh1ZWlVRVduVnJ0NlFjRlI5TExQYkVNR2lMS3VpM21GenNNVHg1?=
 =?utf-8?B?eGxCaTJvYWxVZjNLUVBza3J0YnVGcFdFNUNUVmM3b0ZMYVpCM1ZFbDd1VzI3?=
 =?utf-8?B?QkpZa0F1NmlLeUFwZG9iZTFBcE5sU1VuWE9ZQmZQRTFIbjZBMXJpeko2ek5B?=
 =?utf-8?B?eVM4YTdGZjVHY3EwZWk4c2Z3Y2RhRU1ncml5ZDFRUlZ2V05XSk5FK1pwTzQ3?=
 =?utf-8?B?QXNQdkdmYmUzTVFQd1BpYVFyWS9BODBHYnk2ajd4RWp6R2Vndzk3UHhxWm1F?=
 =?utf-8?B?TnhTaEdyZUkrUmlXTWRjN2JIV0J2UEFoSW5pUmhHMjNVZ2ZFVm1EZTN0UTgr?=
 =?utf-8?B?c1Q0bE1Nb1czQWZoeTNjZURHK0hqamZZUVRPemR0cmtNczNVV3IwcUdmRDdw?=
 =?utf-8?B?OXkxMkdicHRRcTFiNHZtbll4VGc0dFo2UTdMRW9QMUx2enhiNkhyUVAwd1Rh?=
 =?utf-8?B?Rm1EN1lZcFpLYTBTK2FtMEEwemhaZ25lVUR5YjR6M3dEa1VPM2dEUXRoVTVY?=
 =?utf-8?B?R1lCOVRIaG0wOHVkVFV0elVqQ01aZ2JBNTNJVC81T3ZkZTRxNWRhZEdXbDBj?=
 =?utf-8?B?blBPdWJWNWRsemg0eGVoR2o0M2cvRno1ckpobGdTTldUczc1K2xGaHhnem9x?=
 =?utf-8?B?ellqd0YxdUpJS1MwZmIvYVlvV1NEaEx3OEJXeUwvK3hxM0s0RTN5ajlEcWI2?=
 =?utf-8?B?Qk96MnZmRXN5TE94WXY3ZzdLWGVXVFZXcHpEdU56R21KYXlPSUtTc1lMWjBI?=
 =?utf-8?B?Z3NRaXZiMG5TS2hOTHFNUHhBVW15eEhMeVRqeWc4ZW52VnlCVVZrbmhUeHJE?=
 =?utf-8?B?bS9TUUVhcFNOYmFwUjBNdFRTbW9WeGhqNU5WeWUrM0E2eTAzckxWSmFDRU9P?=
 =?utf-8?B?RjBLdHpOOVRmUDUzcXlsS3BEQnNWVm1VaGx1bis0M09kOEZHc0FPQmtxa01I?=
 =?utf-8?B?bWR6OUlRQTl4U1ZxRTA1MlliVjgyNzNlY0NHMTdzbkk4SzJBQ3Z4N1c3T3cw?=
 =?utf-8?B?VTB5RURsWU1BV0ZGWXdhaTFYN0toby9aeVVRTWJ2SlE3M3U3QmhCMms4TG54?=
 =?utf-8?B?aHVJMkFkS1R5YTZVYjA5ODhPcUNyWmRnaDNvbmE1YlNiYjVKclhDbXFHR2Jr?=
 =?utf-8?B?Yjg2dEdTLzhDeW1Wbms4aG5nYWRFUG1PVFQyMTRNVS9MSlI0MGZJVVJueUVw?=
 =?utf-8?B?eEk0dGQ5ZFZiNkY0ckIyVW5GQjRveUUxSG44ZklvTUtyQzRDbjBrb0NNaTEr?=
 =?utf-8?B?NGxZdHR1RGV5NDc0UXZZVFR3M003K3RVTFFmbFY1amJWclFpaFFkQjJUaFBT?=
 =?utf-8?B?ZFZwZGt1dVVFa0JSNEg3cnI1eXRMekU4Rm5ONWRXZlpsd2cwMGJDVFh2MGhY?=
 =?utf-8?B?L0t6VnBGWGkra2lZSXIyME9hVm8wOHBsVVZQNHQ4RGNsMm5CcGUwczRRN052?=
 =?utf-8?B?WnM3bi9KTmkvZzZzeVZBLzZsbDZNenpjSTRZMC9jc2JIei92WXR2TjdYVXQ0?=
 =?utf-8?B?VTU5bUFnZ01TbENheDdjRGRoOXIwSFJxTnNHaURPRDdqSkFUdHdwVlBsVnNV?=
 =?utf-8?B?QjllZWp1YllVL3NlWjFzRkgvSzJBUU0vTmlhZkJzRVZyMGg5aHpEM3EvY2ZQ?=
 =?utf-8?B?MXp6eUxpS0lIWDhGNFhLc0NrOWQwTEs2TG5rVHc1UkF3eXFtblJ1d2NkRzVj?=
 =?utf-8?B?cXJNVDRsQnF4N3p4SXp6eDVSazVCV3RKRitTMlZHMDF3U1o3dC8zay9nT2hZ?=
 =?utf-8?B?N3VOU2xJbGR3RmltamF6aXpqYWh1N1pWeDF1c3NTV05pWWdoOVBSRHYrZkxx?=
 =?utf-8?Q?4V4loYj7x7tqSDLR6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77487157-f4dc-4f45-7a9f-08df2bb922cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:10:26.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BSs0OcZ/hrIkZFRk5Vli6JtGDNdsNcllUQuRnJ8l7jJyUa3vTggSqQ0Mtl+H+YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB220232

Hi Reinette,

On 10/15/2026 10:16 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Resctrl kernel modes control how allocation and monitoring associations
> 
> "allocation and monitoring associations" - unclear what this refers to at this point.
> 

Hmm.. Not sure what other alternative.

>> are applied in kernel mode relative to user mode.
>>
>> Add info/kernel_mode to expose the supported and active kernel modes via
>> the resctrl filesystem. Supported modes are listed one per line, with the
> 
> (needs imperative)
> 
Sure.

>> active mode enclosed in square brackets.
>>
>> Document the interface in Documentation/filesystems/resctrl.rst.
> 
> Above sentence is not necessary, it is obvious from the patch.

Sure.

A resctrl kernel mode enables kernel work to use different allocation
and monitoring associations than the originating user task.

Add info/kernel_mode to expose the supported and active kernel modes
through the resctrl filesystem. List supported modes one per line, with
the active mode enclosed in square brackets.



> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst |  48 +++++++++++++
>>   fs/resctrl/rdtgroup.c                 | 100 ++++++++++++++++++++++++++
>>   2 files changed, 148 insertions(+)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 73bf89d0ac83..73ccbb9594f5 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -527,6 +527,54 @@ conveyed in the error returns from file operations. E.g.
>>   	# cat info/last_cmd_status
>>   	mask f7 has non-consecutive 1-bits
>>   
>> +"kernel_mode":
>> +	In the top level of the "info" directory, "kernel_mode" lists the
> 
> Note that just above this addition the documentation reads: "Finally, in the
> top level of the "info" directory there is a file named "last_cmd_status"."
> This addition thus creates a contradiction by adding another file after the
> "Finally". Could you please rework that portion of the documentation to
> have an introduction for the files in the top level info directory and make
> it clear how there are two files in this directory, similar to how the other
> directories are documented?

Sure. Will do. Probably separate patch to change "last_cmd_status".

> 
>> +	kernel modes supported by the system, one per line, with the active
>> +	mode enclosed in square brackets. A kernel mode determines the
>> +	allocation and monitoring associations when a task switches from
> 
> Would user space know what "allocation and monitoring associations" means?
> 

Will add a line about association means.

>> +	user mode to kernel mode.
>> +
>> +	Possible kernel modes are:
>> +
>> +	"inherit_user":
>> +		Kernel mode work uses the allocation and monitoring associations
>> +		of the user-space task on whose behalf it runs.
>> +
>> +	"global_enable_per_cpu":
>> +		Kernel mode work uses the allocation and/or monitoring
>> +		association of a backing CTRL_MON or MON group. The mode can
>> +		be activated or deactivated per CPU. The line contains group=
> 
> Having a global "activate"/"deactivate" as well as a per CPU "activate"/"deactivate"
> is confusing. The series switches between language here but I find other places
> that refer to the global "activate"/"deactivate" and then per CPU "enable"/"disable"
> to be easier to follow. Doing so will match the text of the "kmode_cpus" file that
> reads "The association is enabled on CPUs added to the mask and disabled on CPUs
> removed".

Sure.

> 
>> +		and whichever of ctrl= and mon= the platform supports::
>> +
>> +		  global_enable_per_cpu:ctrl=<assign|inherit>;mon=<assign|inherit>;group=<CTRL_MON>/<MON>/
>> +
>> +		"ctrl":
>> +			"assign" if kernel mode work uses the allocation
>> +			association of the resource group named by "group",
>> +			"inherit" if it uses the allocation association of
>> +			the user-space task. Present only on systems that
>> +			support allocation.
> 
> ok - this is already late in the series but this seems to make it clear that
> "allocation association" means the portions of resources allocated to this group.
> Thus the earlier " enum kmode_state - Control or monitoring association" is wrong?

I think, it should be " enum kmode_state - Allocation or monitoring 
association"

> 
>> +		"mon":
>> +			"assign" if kernel mode work uses the monitoring
>> +			association of the resource group named by "group",
>> +			"inherit" if it uses the monitoring association of
>> +			the user-space task. Present only on systems that
>> +			support monitoring.
>> +		"group":
>> +			Path of the resource group, relative to the resctrl
>> +			mount point. A CTRL_MON group is shown as <CTRL_MON>//,
> 
> Shouldn't it just be <CTRL_MON>/ ?

Or We can say "<CTRL_MON>/<MON>/" to be generic for both cases.

"The group is shown as  "<CTRL_MON>/<MON>/".


> 
>> +			a MON group as <CTRL_MON>/<MON>/.
>> +
>> +		When the mode is not active, the parameters are the defaults
>> +		used if it is activated without new values.
> 
> "parameters are the defaults" seems to conflate two things: (a) the
> supported parameters, and (2) the default values of those supported
> parameters.
> 

When the mode is not active, the output shows the supported parameters
and their default values, which are used if the mode is activated
without new values.

>> +
>> +	Example of a system that supports allocation and monitoring, with
>> +	default mode inherit_user::
>> +
>> +	  # cat info/kernel_mode
>> +	  [inherit_user]
>> +	  global_enable_per_cpu:ctrl=assign;mon=assign;group=//
>> +
>>   Resource alloc and monitor groups
>>   =================================
>>   
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 75b81d07a247..e82709d64a00 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -993,6 +993,99 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +/* Names used in info/kernel_mode; indexed by enum resctrl_kernel_mode */
>> +static const char * const resctrl_kmode_str[] = {
>> +	[RESCTRL_INHERIT_USER]		= "inherit_user",
>> +	[RESCTRL_GLOBAL_ENABLE_PER_CPU]	= "global_enable_per_cpu"
>> +};
>> +
>> +static_assert(ARRAY_SIZE(resctrl_kmode_str) == RESCTRL_NUM_KERNEL_MODES);
>> +
>> +static const char *resctrl_kmode_state_str(enum kmode_state state)
>> +{
>> +	return state == KMODE_ASSIGN ? "assign" : "inherit";
>> +}
>> +
>> +static void resctrl_kmode_group_path(struct rdtgroup *rdtgrp,
>> +				     const char **ctrl, const char **mon)
>> +{
>> +	*ctrl = "";
>> +	*mon = "";
>> +
>> +	if (rdtgrp->type == RDTMON_GROUP) {
>> +		*ctrl = rdt_kn_name(rdtgrp->mon.parent->kn);
>> +		*mon = rdt_kn_name(rdtgrp->kn);
>> +	} else {
>> +		*ctrl = rdt_kn_name(rdtgrp->kn);
>> +	}
>> +}
>> +
>> +/**
>> + * resctrl_kernel_mode_show() - Display supported and active kernel modes
>> + * @of:		kernfs open file
>> + * @seq:	output seq_file
>> + * @v:		unused
>> + *
>> + * Lists one line per mode and brackets the active mode. inherit_user
>> + * has no parameters. global_enable_per_cpu prints ctrl= only when
>> + * allocation is supported and mon= only when monitoring is supported,
>> + * then group=.
>> + *
>> + * Return: 0 on success, or -ENOENT on error.
>> + */
>> +static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
>> +				    struct seq_file *seq, void *v)
>> +{
>> +	const char *ctrl_grp, *mon_grp;
>> +	enum resctrl_kernel_mode mode;
>> +	bool active;
>> +	char sep;
>> +
>> +	if (!info_kn_lock(of->kn))
>> +		return -ENOENT;
>> +
>> +	for (mode = 0; mode < RESCTRL_NUM_KERNEL_MODES; mode++) {
>> +		if (!test_bit(mode, resctrl_kmode.kmode_sup))
>> +			continue;
>> +
>> +		active = resctrl_kmode.kmode_cur == mode;
>> +
>> +		seq_printf(seq, active ? "[%s" : "%s", resctrl_kmode_str[mode]);
>> +
>> +		if (mode == RESCTRL_GLOBAL_ENABLE_PER_CPU) {
>> +			ctrl_grp = "";
>> +			mon_grp = "";
>> +			if (active) {
>> +				if (resctrl_kmode.rdtgrp)
>> +					resctrl_kmode_group_path(resctrl_kmode.rdtgrp,
>> +								 &ctrl_grp, &mon_grp);
>> +				else
>> +					pr_warn("%s active without a resource group\n",
>> +						resctrl_kmode_str[mode]);
>> +			}
>> +
>> +			sep = ':';
>> +			if (resctrl_arch_alloc_capable()) {
>> +				seq_printf(seq, "%cctrl=%s", sep,
>> +					   resctrl_kmode_state_str(resctrl_kmode.ctrl));
>> +				sep = ';';
>> +			}
>> +			if (resctrl_arch_mon_capable()) {
>> +				seq_printf(seq, "%cmon=%s", sep,
>> +					   resctrl_kmode_state_str(resctrl_kmode.mon));
>> +				sep = ';';
>> +			}
>> +			seq_printf(seq, "%cgroup=%s/%s/", sep, ctrl_grp, mon_grp);
> 
> Looks like this will print a monitoring group on a system that does not support
> monitoring? I understand that the monitoring group will be the empty string in this
> scenario but in resctrl that has meaning of "default monitoring group" so printing
> this when monitoring is not supported is unexpected.
> 

Ok. If monitoring not supported it will be "CTRL_MON/" (Example 
group=ctrl1/") and then default group is "/".

Is that what you are suggesting?


> I also do not expect the monitoring group to be displayed if "mon=inherit" since
> that presents a contradiction with stating that "monitoring group is inherited"
> while printing a monitoring group.

Yes. We should not display "mon=inherit" when monitoring in not 
supported. Will check on this.

Thanks
Babu
