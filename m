Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DF248893;
	Thu, 15 Oct 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105941; cv=fail; b=BFTwId1kXMDocNMMFgNYgeZ/WOkHpwhK144XCExm3+HbnP3YCGSrphJ5kkN5Bo86ScfaceGAZYZbK5uBMFjFRMEPAxSzczga5wh8wA+9h45UH2g8ttFnn0/16l3i7h6A1Wz1YTigVo1n8YCPvC0ZME8VSLP8d86wed8ITn8ixnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105941; c=relaxed/simple;
	bh=bndWDNaKv/lJh5XmxXBmuDCC90/KqivbID8ZjQbpXsQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjGA7rB4zhdImJuQDkT3mGGrvfW0+FFnnYzoA64WfeiFAWRmJET9OFFPIFr56GdluKfyu9O7Cfl6Ov/MGabjDkoEPnyHBiFzXo1063kvJB9PcMxADHTQLAMSeeQHHsujGq+ke2TZwIOlKMxCyPD3whRG/YOincZwTH5TX1L0CRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DG3IsZex; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DG3IsZex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRHjpCs9qauU2wo7TWOH8Wkj95HNecKjueHp/FA7aQfz5GCh6GKNKbSqx59AYXv6fpCliaOE4vm6hpVfPWPs0WEkn8koQBmo3OqGvX6l4OQnJ8pxKogLUyugzNvdZCCqmt32aZolnNZVQwqiwZyIdRw9npGIDqA+B4XXWrIae+1qi+3nA7vfGI2FPYcqzqMey5Qe5DaYJkE8UtVhD1UfHy4epU6LbkcCJjPijktLZDJ9tfl1LpDXNRfjhhwmQIsZBY9zpMb4e509h4a6zjGroDHuNv/8VK1pkPrPxAV0H9WMc9/VLWwwpIL3L/A1SU02z+oEmBopR6BASRLFRJI3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUSY5x1WdhFvXGZduMIieoNBuPbgLBKslN5KWX/dwP8=;
 b=YDmYESZIEB0JbCx5s81U0qjWSwVMy4XQvLkVC5fQTLLqhCBK3/ME/XhNte6scMEyy6YAfndT+LgIFDVlxIQJuFBdv5wwFgFlycCucD8TLs02fd2C/l88DYndYGW8zwGuwwtSSAd8hHZk+smyZxO3qPzfNwE9kujhTqYjkeQA8fnBFbBWyvYZuAVfGcHsLUu/VgIx+wNUmvnKr7mwu6h/fObEJvT40fEANtF2EGzlifphpG1hw5o3qqXZKmUjnXMoLyBq1aIIgSemOiDcIWuUHcq0ksskhE+H1bFUBShOczX1EwZG/cWUWAJQUovc0l7PueifOlRL8/PMzdONdlhFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUSY5x1WdhFvXGZduMIieoNBuPbgLBKslN5KWX/dwP8=;
 b=DG3IsZexi1nMO6e5SSnuohhS7CBEPWnOVdEkIZJQTIKAQ8SKMYfCnsIPwd3+Qa7LMCvryZaTXGqI/LDEitWE70hpurP8ZMrQPuYfbrclRI9DLkeKb8fPlOOqStmzvApQphBNrTBPNFaSZmS9UREXiT/EsBgOI8ujHf2K4NosrFw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 23:12:15 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:12:15 +0000
Message-ID: <7ec256a8-9e03-47c8-9fe4-d080a9069228@amd.com>
Date: Thu, 15 Oct 2026 18:12:05 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v6 05/18] x86,arm,fs/resctrl: Introduce architecture hook
 to program global kernel mode
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
 <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
 <b0a15b3a-06ac-4320-8198-78f8dcc5c74e@intel.com>
Content-Language: en-US
In-Reply-To: <b0a15b3a-06ac-4320-8198-78f8dcc5c74e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: f618f2e9-b8db-44f0-bb86-08df2b11c04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HYADzSRcxBMzVp3o17AzG6dzHjVPbeV6VcRUsqu3rMxC5CvWB+V8f9xeLbicn4RYAHD7nG3drbxdRC429J6tyf8j1fHZ9a31EWSnK8ICCB+ltrQKKWezPUWuXAkHx2o3RgEsDXis0+IKYM9BSsvIzEzv8T3FY+KFx4ffWxoj+IOV+yAlGTFhndoU1X4znSoOzt9UHqhqs5tdXx0XjoOpPyl4muInN+MWMugDV4jOoIBUNgpB7rSQ+bP5Hca+5UYvRz/RVN9SbIBTob/jt7v7kE+p+fT35qKPkwBg1J6Z3NZ4U5gB4oAvc9Y8fLLjPb0oYdlxCRDn3F3Or+IIxq2DbxJfORHQh3daiV/jFb06GV5kgoFC+hmfxyKRTExCx9aR4YeLU7LfXJZwia9SqkscaCuCNmV7pLr3HqJiqM52lJzK5C/hVDxchWX2ZSTud3B1lY9Vhs72Gm3Rk+SXpEkWJAGo4YztlfOkwRm6se4WSJpaXfCrvXUWXTnS27B6himBy5mOs0qt63fzoh0jOdtx3RVHlWQCq3uPxlKkG4O+/LK6N4YkTZHYMc5ln456x3mwfj/h77O8MF2TwahVWPMz0HBdpSRrBkL2NhXSz93EhTBHgiow5y7woIi+8r93y8aSm32110ZAuPK/ayYvlC1L7av+PSYekCU0hIYgpYYm5I8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y29sQ1FHQldnQWJOa0p2bVNjcHpkdUYreUpuVkdiMVExWDJuelRjWXFsVEdG?=
 =?utf-8?B?S0wwS1dpdTkxOXRWbUhicnFCYVZvS1dYSjkvUVR5d2tzOWtxbDgvZzJFN0hv?=
 =?utf-8?B?RU1NMmJmMlA5dWRmZi84b2pOSkJNUkJrdEhZTEc4MWdYNlM4Z09wQTIzY0py?=
 =?utf-8?B?dFMxTTVUZVNyRC9nZHkwVG43alNhRTNFVWNYZHRDMFBKcXp0c3dmTHdHSm1j?=
 =?utf-8?B?d1IzZzEyZzVaOU1ZYXo4M3ZaWXpEN2Y4ckNnV2l4cGV0b1dxVEdvSTdQbndF?=
 =?utf-8?B?N3ZwKzdCaEEwY0xwMlVDcHUzdTIzU2F1RjlxVzBPQm9CRVo4OUlYdVdPTWkw?=
 =?utf-8?B?WmViVUlOby9sSmlOZ04wcWQ5c0JKZUVmdVlrT0RReXpPSk1DNUp2WHdYdExq?=
 =?utf-8?B?OG96dDA4Uzh3NDF6a3FsM3hUYmdFWFdSaFRneVdoSFdwWjZpSitLSndVME9w?=
 =?utf-8?B?d2hjSkFxc01wTVUzN2NPOHh6L0RFOUoxdkRvUHdURlJsa3NITWlmbGZJU0Uw?=
 =?utf-8?B?K01mMGFNb2FabXpwNitUTGh6SnVvOXV1dXl6VWZmMHZMdVkwRm5jdTUreGt6?=
 =?utf-8?B?eGl4citlSnd3OW01TUpTSUlNMjEzaU5uMEl3K0xXWWExNFpoZW1yQ1l0VUp0?=
 =?utf-8?B?a3NHcWc1YjNjcDh1VFVlSkRGRmJIUDFZU2VYQlRLeGpCK2owcFM5emRlcXV2?=
 =?utf-8?B?dEs5QlcycDAwUEx6QmN1dE9MS09zMWNrRlM5d2ZjKzFTOVZYaHB5OUVtYkNk?=
 =?utf-8?B?NWlPL3dhY1AvdDR2T1NEOUZVSDV2bUxmUm9wSEZEdTlsRms5Tm9mdVVLdjl2?=
 =?utf-8?B?bmkyN0VZWFQvaHBaZmc5L2lZdmhsWmdsRDhsY1JWSVNGYjVlUU5YdHYvZUhp?=
 =?utf-8?B?eUlKL0FjUC90aHRzZGM3UEg2b2xmSW16MmEyUnF2M0xHUEozeGpLVnZaRnNz?=
 =?utf-8?B?eTd2R29OYkU3di9Sc2hNbS92TG9Ham9TeTJnOFhUdTFjSThhS1pVQW1oSi9M?=
 =?utf-8?B?MVN5MGxWT1JSa0JuQ3ZqQ1IzM2RvQzM5K3MvODBvL2ttRjNVeUE3OVFQcStN?=
 =?utf-8?B?dy9pVzFlZDloZVdxOGhVaXBYOWVNZmhZVjJ5R0daNlJjVndnTXZGSE1IVTlZ?=
 =?utf-8?B?OGxOLzVydXJ4MlkwMjY3eGEzQUV0Mm1zU0VBM2tvSzRRUFhvQkl2UUp0b0pG?=
 =?utf-8?B?WDIvK2ZhWTQ3ckVMd3paMlBHTCszb1dPdlgxUTRqQWpTRXdRbXRweFlsampD?=
 =?utf-8?B?TTF5ZDFlenhJQnlLSkw5NnlVeGZnMUlzTzlJVGtHWXBsaTJhZXB5eDkzRzBt?=
 =?utf-8?B?bjluVUVoSWtpSUlJMHRVQm1BWG90VEcyNHAyVlBrUWZQYlpKRUZMNCtURDZv?=
 =?utf-8?B?SWpiYVYxUWZGUmp4ak0xdGdKVFdZY1BrSTJyc3U2RWJ3VWp5dTR2UENhNU9G?=
 =?utf-8?B?VjNuRjRkS3UxMkpBdEt6cHBRMmdVYngzS2toRWY3bWVucDlMZFVVUEZONWwy?=
 =?utf-8?B?dmdHcHI0aHZHd3IvcGNoWFlUaHVRaUczaFArM2ROR3hGaktldmRSRStvTVp1?=
 =?utf-8?B?S1EvRkNHVkVUSG8rNjdBYld5T0JCYUJnL2NiczB1dXRFRUZsRUNXc294K0RT?=
 =?utf-8?B?cDBFQzJhWm5JSDFyU1BqeFhSK05MYVFXS3pFQ3kxRmhYL3BFUXh6RXMxakxa?=
 =?utf-8?B?MVY2dG9jYThvbnRidjJtYUdla1NGV0dyOTVuL0dEU3hBRkJEdGtYUkpicEd2?=
 =?utf-8?B?L2V6Mm9maGtBVjdPRUkyZXB5dzRqb2pQRTNWcDFXcFE5dXUrL2NQaW81eGdm?=
 =?utf-8?B?TEMrRFhMeFRmMkVSUU1MZkdCNUtFREQ1UDBITi93NXhYbkkxWitmcFdtMHo2?=
 =?utf-8?B?L3pHZWpZOFhjd0F0WjBrSlNObzl4MEh0YmNEczR6TkhSS3loNEhqWWYraG0y?=
 =?utf-8?B?dVYyc1N2dE9DekhtcjZDajBIdFVZOUxaODk3MkQzQ01tck5INUc0cUM1amd4?=
 =?utf-8?B?MUVlc3EzR1B2RDJuNGdMbTZlRTNGQXZleTFWUjdSV0VYajZYYUVaYjNsVGFr?=
 =?utf-8?B?QmFxZnN1L0pRc3J3QytkTkdiVGJpb240UngzczBQbUtiSGd0TkdhbHB0a3NE?=
 =?utf-8?B?UGZhc0tmTkhYMGlkbGZOb2xKa1Y4RExRTVdCRHBvMG93cjRNN1V1OERJd0xQ?=
 =?utf-8?B?RzZBR0h1dy90dmhFTTJ0NVMxWUY3NEVHWFAxQnFFY3Y3cnp1MlpFWHVhcVVv?=
 =?utf-8?B?aWlWT1kxVFJpV0toc0lKL0t2bXI1SkRDSjlKR3k2RzVrYUxNWXRFSkpKZkJq?=
 =?utf-8?Q?7J79VBycLkSBjHCTxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f618f2e9-b8db-44f0-bb86-08df2b11c04d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:12:15.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vIcs6wH87llCcSUGklJeOioaW0HOyr/abkC7+J8rophOYEbNHlGM24dhGRbpeio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561

Hi Reinette,

On 10/15/2026 9:30 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> There is no reference in upstream resctrl but during discussions around
> the "multiple controls" support we settled on a new subject prefix of
> "arm,x86,fs/resctrl" for patches that touch all these parts.

Sure.

> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> RESCTRL_GLOBAL_ENABLE_PER_CPU mode enables kernel work to use different
>> allocation and monitoring associations than the originating user task.
>>
>> The mode is enabled independently on each CPU, so the filesystem must
>> program hardware when the mode is activated, when CPUs are added or
>> removed, and when it is deactivated. Allocation and monitoring associations
>> can be done independently, so the architecture callback takes separate
>> control and monitoring options.
> 
> Going back and forth through this series a couple of times all these
> usages of "allocation and monitoring associations" in different contexts
> become a blur and at this point I do not know what it means at all.

May be removing the text in some places might help. In this patch, the 
last line may not required.

> 
>>
>> Add resctrl_arch_configure_kmode_global() with an x86 PLZA implementation
>> and an empty MPAM stub for ARM systems that do not support this mode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 38 +++++++++++++++++++++++
>>   drivers/resctrl/mpam_resctrl.c            |  7 +++++
>>   include/linux/resctrl.h                   | 37 ++++++++++++++++++++++
>>   3 files changed, 82 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 62044489b052..a343dc0c71c5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -137,3 +137,41 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
>>   
>>   	return 0;
>>   }
>> +
>> +static void resctrl_kmode_set_one_amd(void *arg)
>> +{
>> +	union msr_pqr_plza_assoc *plza = arg;
>> +
>> +	wrmsrq(MSR_IA32_PQR_PLZA_ASSOC, plza->full);
>> +}
>> +
>> +/*
>> + * resctrl_arch_configure_kmode_global - Program Privilege Level Zero
>> + *					 Association (PLZA).
>> + * @cpu_mask:	CPUs whose PLZA MSR should be updated.
>> + * @closid:	CLOSID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
>> + *		written; required even when @assign_ctrl is false.
>> + * @assign_ctrl: Whether PLZA should program the kernel-mode CLOSID.
> 
> At this point the series seems to switch terms from the "kernel mode" in
> previous patches to "kernel-mode" here. Could this all be consistently
> "kernel mode"?

Sure.

> 
> On a similar note, the series switches between "global kernel mode" (like
> in this subject) and "global per-CPU kernel mode" (like in patch #14
> subject).

Lets say "global per-CPU kernel mode" consistently when referring to 
RESCTRL_GLOBAL_ENABLE_PER_CPU.

> 
>> + * @rmid:	RMID programmed into MSR_IA32_PQR_PLZA_ASSOC. Always
>> + *		written; required even when @assign_mon is false.
>> + * @assign_mon:	Whether PLZA should program the kernel-mode RMID.
>> + * @enable:	Whether PLZA should program the kernel-mode association.
>> + *
>> + * Program PLZA on @cpu_mask for %RESCTRL_GLOBAL_ENABLE_PER_CPU. See
>> + * union msr_pqr_plza_assoc for the hardware field meanings.
>> + */
>> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
>> +					 u32 closid, bool assign_ctrl,
>> +					 u32 rmid, bool assign_mon,
>> +					 bool enable)
>> +{
>> +	union msr_pqr_plza_assoc plza = { 0 };
>> +
>> +	plza.split.rmid = rmid;
>> +	plza.split.rmid_en = assign_mon;
>> +	plza.split.closid = closid;
>> +	plza.split.closid_en = assign_ctrl;
>> +	plza.split.plza_en = enable;
>> +
>> +	on_each_cpu_mask(cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
>> +}
>> diff --git a/drivers/resctrl/mpam_resctrl.c b/drivers/resctrl/mpam_resctrl.c
>> index f2c651e9f6ea..0c8594e98526 100644
>> --- a/drivers/resctrl/mpam_resctrl.c
>> +++ b/drivers/resctrl/mpam_resctrl.c
>> @@ -139,6 +139,13 @@ bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
>>   	return false;
>>   }
>>   
>> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
>> +					 u32 closid, bool assign_ctrl,
>> +					 u32 rmid, bool assign_mon,
>> +					 bool enable)
>> +{
>> +}
>> +
>>   void resctrl_arch_pre_mount(void)
>>   {
>>   }
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f6adff7f4e1f..dcb0beb847b6 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -752,6 +752,43 @@ enum resctrl_kernel_mode {
>>   
>>   #define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)
>>   
>> +/**
>> + * resctrl_arch_configure_kmode_global() - Program RESCTRL_GLOBAL_ENABLE_PER_CPU
>> + *
>> + * @cpu_mask:	CPUs whose kernel-mode association should be updated.
> 
> This could be made more specific about being online CPUs. For example,
> 	@cpu_mask: Online CPUs on which to update the association.

Sure.

> 
>> + * @closid:	CLOSID that matches the RMID to program kernel mode. Depending
>> + *		on the architecture, the counter may match traffic of both
>> + *		@closid and @rmid, or @rmid only. Always provided; a valid
>> + *		CLOSID is required even when @assign_ctrl is false.
> 
> Above description seems to be a concatenation of different texts. The "counter" text
> seems to be copied from resctrl_arch_rmid_read() and does not seem relevant here.
> The "CLOSID is required" is copied from the x86 arch helper where it is indeed
> required - but this does not apply to resctrl fs?

Ack.

> 
> How about something like:
> 	@closid: CLOSID of the resource group backing %RESCTRL_GLOBAL_ENABLE_PER_CPU mode.
> 		 Always provided, even when @assign_ctrl is false.
> 

Sure.

> 
>> + * @assign_ctrl: true to assign @closid for kernel mode; false to inherit
>> + *		association from the user-space task.
>> + * @rmid:	RMID to program the kernel mode. Some architectures may use
>> + *		CLOSID/RMID separately, others will consider them together.
>> + *		Always provided; a valid RMID is required even when
>> + *		@assign_mon is false.
> 
> (similar comment as for @closid)

Sure.

> 
>> + * @assign_mon:	true to assign @rmid for kernel mode; false to inherit
>> + *		monitoring association from the user-space task.
>> + * @enable:	true to enable kernel mode association on CPUs in @cpu_mask;
>> + *		false to disable kernel mode.
> 
> "false to disable kernel mode" does not seem to capture all that is required
> from architecture. When considering resctrl_kmode_switch(), @enable being false
> is only thing resctrl fs does to put CPUs into RESCTRL_INHERIT_USER mode? So when
> @enable is false the architecture should disable %RESCTRL_GLOBAL_ENABLE_PER_CPU
> *and* enable %RESCTRL_INHERIT_USER?

Yes. Will update.
> 
>> + *
>> + * This callback programs %RESCTRL_GLOBAL_ENABLE_PER_CPU. It is called in
>> + * the following scenarios:
>> + * - If the mode is active when user space changes the configuration, it is
>> + *   first called to deactivate the mode on all CPUs where it is active.
>> + * - When user space activates the mode, it is called with cpu_online_mask.
>> + * - When user space adds a CPU to the active mode.
>> + * - When user space removes a CPU from the active mode.
> 
> This attempt at listing all callsites is proving problematic since it is
> already out of date by the end of the series. I would thus suggest to drop
> listing the individual call sites and instead focus on writing a clear
> contract. Consider, for example, something like (but please verify, especially
> for accuracy and correct terms, do not just copy&paste):

):

> 
> 	An association starts when %RESCTRL_GLOBAL_ENABLE_PER_CPU is activated
> 	and ends when the mode is deactivated or user space changes the backing
> 	resource group, @assign_ctrl or @assign_mon. Every call for one
> 	association provides the same @closid, @assign_ctrl, @rmid and
> 	@assign_mon; only @cpu_mask and @enable differ between calls. Before an
> 	association ends, it is disabled on every CPU where it is enabled.
> 

Looks good with minor change.

The callback programs %RESCTRL_GLOBAL_ENABLE_PER_CPU. An association 
starts when %RESCTRL_GLOBAL_ENABLE_PER_CPU is activated and ends when 
the mode is deactivated or userspace changes the backing resource group, 
@assign_ctrl, or @assign_mon. Each call for a given association uses the 
same @closid, @assign_ctrl, @rmid, and @assign_mon; only @cpu_mask and 
@enable differ. Before an association ends, it is disabled on every CPU 
where it is enabled.

Thanks
Babu
