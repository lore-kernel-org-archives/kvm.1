Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514502;
	b=E4WRJAKhLci3R0vsJgzK3Bxx9haJeQ+viIYGNmLwPYhpT57qFHLGDKOHOqJjfDdCkA8C
	 n7KtS7G65ZyXcNqJZqcBgcbFliLoJjQUVjmMnvHRcCgv/NWK0CvcQr0EvIlanDqj5Nloy
	 wMscio4vkpqUtRlGLlR/aEEd82SPrx4P21CDw8+dphHVCiOXEmg97/ziOkB6R9hAQWE5E
	 RoK/ielH2rzcVWbLJTtgpLWubn6KB1gKCep0bfh+k1gj4YHMkzkAq8fWiYsX+TGLwRDvg
	 BqWLGk/+SE6mSStSEhPmkbPTOuC3BHstEySHupSMMG54x88kBq4rKmPHDaJ3IuF79zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514502;
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
	bh=A/a6L5ZWhFngG0hDySABF2+e4+TtXX7Lt2NcRi8PT6w=;
	b=2ZQxCBkBvykBLBgKsj5sEkZKiodkujd30ykK1+cvLQgBZuMC0GZs5bxMsbGKOD7wgCRo
	 XsNvWoJPMTNUHstumNigkcAcN7yMpLWgMrZ8aE8eiYjLQ4opRxK9Pk0F1htzC88n+ELv+
	 J5ejSc7tzLGkkmDptsT3V0Kv/CaPptdKz+b6/4klksHqjDK1IOAQ3LVhuXS/j1LwOHi3j
	 uLu+1h3yG7wHaKFhTD1fb9qFJiuUDBhV+UjJGI35xXNa1KTpShUQ8vRF+0ZSENhWvimKn
	 CsU5JJgMN7hGBefn4zeRX1QM8Qx2k8fNrKx49NvTO4NZ4kNDJdCJsboL+xfog4xM05A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mkMF6ZiG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA75606A31A;
	Tue, 20 Oct 2026 16:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mkMF6ZiG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPlCv63/Qh/ltGI09o/geDwHkFMli/j62N+ADa/yftM5uWIP9t7jdzBT2DRlgQNNtQZYzZtnEqzdbYseSVXK2/E9kOpteLJDCR+N9kLb//0F3zSi+DYLqxw+8kwAp+3dq4fct84jL+lp6k5pfsTSYee7eVwX6BOUrHef1DNv6b2iFiLFRx0jnWjtSDTgz4BUlGFTrgFROhyIeEuF+5M6wGh6vozu1sp9fk1N+iFrd3bTdFA6AqkAuuYMgXdgq4Xud7oIaO1xetI/yE+xmkRmIumIumDjhLF51jU9/A8KJaFDV6tAnGQ0OsB6oR80Cbe/RMScR+tIoo0r78tWfamLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/a6L5ZWhFngG0hDySABF2+e4+TtXX7Lt2NcRi8PT6w=;
 b=OlzfyQz8GaMFvW2QgD73iqmulfUEpqxC/C1Z1Jb/G32cdxDtGiTNRIyQPP0US9Iy2o3q8caxXfU5Bn/sHmDl1Krs6v/kuSDWLe79xDL9sT93mpsTKPDd+EXtZg2nR5CcRYQwmklOZWE/603bWjuAbdRolU5x1h6UsgE92tN8TkBOMBeeKI6Cgn6t9IjSTjoqy49IG/bhIGnj5R/j8o9+yowj6Yn1aOqrkgh5j32J1D8gcjstWLQYQBPRNiyya1T+PybhU9Lbm88UrJS7GS0dWnlooTdbPayeJpCjb6mXQPPOuT1QyGHkCeeKgCxBw/VYxrdyQnm+KsF+A+UZa4BgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/a6L5ZWhFngG0hDySABF2+e4+TtXX7Lt2NcRi8PT6w=;
 b=mkMF6ZiGY6G80ldHLbtAcDOKxnu702sgQRlok5JAKLEK/4htrU0hFC0MTVa1bozwQa7tEIAFClpsRdxm4sKsR0hrMyX4x952aicyBuKQBe53ouxr1Ujlqban06IGW+5JXM8H/hvg63E6voj3suLYsDlDjuKvz5JqAw8CDGF4fKA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by DSVPR12MB999308.namprd12.prod.outlook.com (2603:10b6:8:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:41:35 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:41:35 +0000
Message-ID: <917d4ad6-badf-4e34-98dd-6e05e20b04fa@amd.com>
Date: Tue, 20 Oct 2026 11:41:31 -0500
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
 <592ae38c-3e73-4940-9720-d23f396f83a3@amd.com>
 <e65c5f31-266a-4411-b7d4-873086451065@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <e65c5f31-266a-4411-b7d4-873086451065@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:32::19) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|DSVPR12MB999308:EE_
X-MS-Office365-Filtering-Correlation-Id: fd06c684-4739-4094-3ee2-08df2ec90126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|260925022911599003|260925021911599003|260925021311599003|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	s5z92LafmbZzBaboBuhOQJQ67kiro1Ig/XjKXY6ty1csE5zU8RyMqwOWeYL7uDMCWEQwqQEUj47s+Is3PHpCPcBJn/Fdl7Qy9XFDTlaUSSLYz+JxdxboKWqRNoT7frU7e97FXI5ejGxY5oxPD8triViWg7PMImKA4BZcV1B3Vy64lT7YvRGNd00OWd/Yl027BB8lRWW8ETDhbFe5bpfZeMI1NPtTTKL6FB7ojYcaXxPOiy7OlMze5vjlb2kFI0nXyezoSAJIQhPK38ViQ4DH1p6oyR0+shfHEoCly70EyEUiE5JjAb31mV5olSjaP6MxdO6EmAKRASicoM3i37+MJtHbV8CvLH1U3+64/1Zy7DfBE6KiP5JlJP7nLFhPdjhFZL/LDcUEHRnzj1G+YZscd+xYMCgKe7xxA7PM7Ek3IfCTN+9R8YLu3JlyF7CJUWIYQQtOXv7eo03G9BN8uh0zhNyYA8c1P40TGDDXTSxAIYvf5AbhpTGlQO5hv3vkOhgEG6VjlAF/f/9VpKbqeHEPFr3cPU3tU2T7xVWxb6SfmtoVC3CUCYQV4+9HTz0Qok4Umq6JiratmYSg4IQO0ES63PiPneXihF6e9GjlCNgI+6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDNlbU5vd2FoOUszT3VkZlVySUM5ZUpPTjc3QjlaTHVFVTlzNThpWTVublBy?=
 =?utf-8?B?NFRpZ1pPMGJEMmM3OHY1N0VScXlKKzZjUnBqektnK3lmVnFpNWcvcW9HNVNu?=
 =?utf-8?B?UDJ4MlRqak1kR0xDN2hjaGNQTXhDb05wV3dXQ2lvN1kxbmhaNzBaeVRXU0l4?=
 =?utf-8?B?K0tEbDV5WWxtS1VsRHpyV1gzdStFMDJZQlIxdkRrMzJDekNFa0VTMitEOGwy?=
 =?utf-8?B?blhuSEcrVG1rY1RiZnRDMFlPR0lhay9QVjMvQ1pBNUpyWlV4N1R1ZFI1clQz?=
 =?utf-8?B?UjBTQWlzcG5kMzQ1RnBseTdPcGZjLytqa0ptMnNKL0IzNFlJZEdsVXBUTTlO?=
 =?utf-8?B?c3I4SG5YRXBTUnNxQ0pvclZCdXZpY1piczRMWHJTeHh5dE9sK3U3aHBiYm9L?=
 =?utf-8?B?RENzRzcyTWJJMm5FbWN6bnU2bmM1c0dGOUFOZGxVWlJhT2Y3WFZDb2Jlbk9X?=
 =?utf-8?B?STAzakhnUE9TaTA0cmtkRm14dFFaTDd3dHBvbTlZTHFHMUJqSW9IWVNZalBj?=
 =?utf-8?B?bVZESEtuOWlIV2I1RGpydmJjY3ZTaCthQ3pwd2V0cjBYZng5QXJHT1ViWFJD?=
 =?utf-8?B?d2VvL0NGWm9KSG9QYndmbDVjL0tNTGVoQzNWWGZYSjVmVTFSbHdYb2JybDVq?=
 =?utf-8?B?dFhLeEhnQWdrUVZLTXZWRGVhcUdVOWJHWU9YZ3JuNUs0T0Fyc3ZNbFp3Nldj?=
 =?utf-8?B?MlRqWnRZTDZVVmkxOW1KczRoUnBWVUZ4R0tUTmNJNk95MHJMSy9scGF3dTIv?=
 =?utf-8?B?dnFULzJ6cUJWT0hxbXlYdllBOXNtQTVOVU1qYVljMjVDMW1rK2lsemZpRVps?=
 =?utf-8?B?Y2tUblhrTzRhZE0rTkJoVmpnUm0vT0gzWmNuKy9kN1pzc3RsZjltcmRSWjFE?=
 =?utf-8?B?TWFWUnBka1VLZ053OE5OeFdmOFhqaTFyZUl2WDUzdzhFd0hjaDB6SDJ5R1RM?=
 =?utf-8?B?b3JyWllyOERXZVVocmhFNTV5c3o2dHZuUWVZRkVGeXY0MFVhVlBJdTdtcUxL?=
 =?utf-8?B?aDc3ZWRLUjlDbFU4eDJqcXFpYTRsK1pMYmJLdmw2TGp5c3E1aG5WWkpWdm9o?=
 =?utf-8?B?N3h2REdvQ3h3RFBPVlhCSkEwNlE3RGRFaDFZbEpFK0ZyQWd4RkJRSHRGaEVQ?=
 =?utf-8?B?SDFZYjdBbkllSTVjL3hhMXlJZFhTVVZIamFQYVIrSUFkcHQ0Y1RqeEx6ekpL?=
 =?utf-8?B?S0RNNGY1aTNzYjZ0Rml2TnZLUGd3eFZyTkdrYURGWURrUjk2MGcyelZiRENM?=
 =?utf-8?B?QkcyUUlVRjlMUUVIMDRZNVJhM3FncjR4THU4YU9IcGpmWlRQUWdZSW9Nc2Jz?=
 =?utf-8?B?VWRKVFp2cDFPS0t2RXROb3NNVjBpb2szdjlQVWRzcEVaZ3RkVFRGZk9aR1Q3?=
 =?utf-8?B?REFGUXdhM2Noc1JvQjR0ckxzT1IyeU5ib2w3ZEI1ZXNteDBjZDM2VjZ5RW5U?=
 =?utf-8?B?ZXNtWEdpN2FqMVFUVDZkQmpXL2dpSStUWWRldWtPaGRQYVZ1cE54T2hrTG5l?=
 =?utf-8?B?UHNTUSszOWJmMG80Y1hoTms2TGhMMmFmU29Ha0dSdDk1S1FJWnE1clcyMndZ?=
 =?utf-8?B?VTROSnNJKytaWFRMRG00QjhhYjBEOE5DMmlScnFDZ3VHK3IvSjNRaGdSTTYy?=
 =?utf-8?B?TGdBSUhxbDMrL2dyaWdzbUo1RFFLdmpndFp6azltMndyckxvOTlCV1pwb1pK?=
 =?utf-8?B?YmVaNmhvbzVzVmhoUzhEZlF5RFNqanJPY3ZmWm9YWkNmTEFsUW9BUWlkdVpV?=
 =?utf-8?B?RUg1ZWxBZjNNRzFpazhHVWNwVG01QXduUElQV0MrcXdxZEpCd1FjQVdJRDBk?=
 =?utf-8?B?Rm5rcUZkdHNZYVFzRXpjSnExNGdBZ1Z3bzRhK21CZlVRRHFveFFnMGlRb3B6?=
 =?utf-8?B?bU9IcG9mVk1XZU11eHpiS3NGc2ZobkxCb0dPQU1aS2EycSthWG1qa09Kbllt?=
 =?utf-8?B?SFYrWmwrOEo2dzVNUU1SVTVxd1FhMmE1VTdXUGRud3hJL2VmQVEySi9WUXRB?=
 =?utf-8?B?dFAxcVpIbHVNVGpyeENQQmlqMzJLY2RjbXZ2SzhNK3A5TEFKOW44eTc1eFFF?=
 =?utf-8?B?WTNKMDk3OURyMU8vQzVCUGEwWWZjNGhTRXBqSVF0OXkxcVhVNE9YdmN3L3Bx?=
 =?utf-8?B?MEc5Zmgxb3BDRnpPM0RIcDdaN1VRb25sUFFhS2ljS2tnVUtXcU1BL3dNeHFx?=
 =?utf-8?B?eWg3bDAvV1lLMzhySitaRk9HUGFsYVJERzdYallkVTNIVzYzYVBKcW1OaWlW?=
 =?utf-8?B?SHBWQ1dsWmRnbVFuWCt4SFpLU1lVY0lSdzBCNzlvWWJIUTV5TzdHV1hQYTBu?=
 =?utf-8?Q?yNQNQFComlGFkzBAJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd06c684-4739-4094-3ee2-08df2ec90126
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:41:35.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3tstWl8jY02CPNay7G/vmDdHb69Xjf2Rpcz/I7JgUMkQETxGiGfEMNwijpcQz1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999308

Hi Reinette,

On 10/19/26 17:01, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/19/26 10:43 AM, Babu Moger wrote:
>> On 10/15/26 10:49, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>>> Prevent mode changes for a resource group that backs the active kernel
>>>> mode. Also prevent mode changes to the parent control group of a backing
>>>> monitor group, and prevent a backing monitor group from being moved to a
>>>> different parent. These restrictions ensure that the active kernel-mode
>>>> association remains valid and consistent.
>>>
>>> "These restrictions ensure that the active kernel-mode association remains
>>> valid and consistent." could this be more specific?
>>>
>>> This patch does two things:
>>> - prevent user from switching the mode of the resource group backing the
>>>     global per-CPU kernel mode. Why? The reason for this is never given and
>>>     there is only a hint in the *code* of the *next* patch that requires the
>>>     resource group to be shareable. The next changelog does not mention
>>>     this requirement either.
>>>     This is important to highlight since a resource group backing the global
>>>     kernel mode would have all its resource allocations shared by kernel work
>>>     done on behalf of *all* tasks. This makes it a clear requirement for this
>>>     group to be shareable and for its mode to never change.
>>>     This highlights that there is an ordering issue with the patches since this
>>>     series establishes the requirement after it enforces the requirement.
>>
>> This check is only exercised when userspace attempts to activate the kernel mode, which is introduced in the next patch.  I can merge this change in the next patch.
> 
> The next patch is already quite large. I would instead suggest that the
> changelog of next patch includes why a resource group backing the global
> kernel mode is required to be shareable. This patch can then follow after
> that to ensure that the mode of a resource group backing kernel mode cannot
> change.

Sure. Will move after patch 16.

> 
>>
>>> - prevent a monitor group backing global kernel mode from being moved to
>>>     another control group. Why should this be prevented? Could the global
>>>     kernel mode not just be reconfigured, just like when user space
>>>     provides it a new group? This is a design decision that is never motivated.
>>
>> [1] There is no specific reason for preventing it. I just did not
>> consider it a use case. Also, changing the parent of a backing
>> monitor group affects both groups because the kernel resource
>> allocation is moved from one group to another.
>>
>> If there is a valid use case for supporting this, we could allow it
>> and update the kernel mode association accordingly. What do you
>> think?
> 
> Up to you, but please make these design decisions explicit. Do not hide them
> behind hand waving like "These restrictions ensure that the active kernel-mode
> association remains valid and consistent.". If you choose to delay this support
> until your customers ask for it then please change the message to something
> that highlights this. For example, "Cannot move a group that backs kernel mode"
> can be something like "Moving the MON group that backs global_enable_per_cpu kernel
> mode is not supported."
> 

Ok. Sure.


>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v6: New patch to fix sashiko feedback.
>>>>       https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com
>>>> ---
>>>>    fs/resctrl/internal.h |  2 ++
>>>>    fs/resctrl/rdtgroup.c | 35 +++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>>>> index 6b8d14c4bd83..84238e9e8e15 100644
>>>> --- a/fs/resctrl/internal.h
>>>> +++ b/fs/resctrl/internal.h
>>>> @@ -462,6 +462,8 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>>>>    void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
>>>>                     bool show);
>>>>    +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp);
>>>
>>> Does not look like this is needed, can this function just be static within fs/resctrl/rdtgroup.c?
>>
>>
>> Yes. The only issue is the build dependency. Since the function is
>> declared static, it needs a caller in the same patch. One option is
>> to merge this change with the next patch, which is where the
>> function is first used.
> 
> There is a caller in this patch, no?


My bad.

> 
>   
>>>
>>>> +
>>>>    int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
>>>>      int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
>>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>>> index 98451b417fe3..dcf9f26540d6 100644
>>>> --- a/fs/resctrl/rdtgroup.c
>>>> +++ b/fs/resctrl/rdtgroup.c
>>>> @@ -1738,6 +1738,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>>>>        return true;
>>>>    }
>>>>    +/* True when @rdtgrp or one of its monitor groups backs the kernel mode. */
>>>> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp)
>>>> +{
>>>> +    struct rdtgroup *child;
>>>> +
>>>> +    if (!resctrl_kmode.rdtgrp)
>>>> +        return false;
>>>> +
>>>> +    if (resctrl_kmode.rdtgrp == rdtgrp)
>>>> +        return true;
>>>> +
>>>> +    if (rdtgrp->type != RDTCTRL_GROUP)
>>>> +        return false;
>>>> +
>>>> +    list_for_each_entry(child, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>>>> +        if (child == resctrl_kmode.rdtgrp)
>>>> +            return true;
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>>    /*
>>>>     * rdtgroup_mode_write - Modify the resource group's mode
>>>>     */
>>>> @@ -1778,6 +1799,12 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>>>            goto out;
>>>>        }
>>>>    +    if (rdtgroup_has_kmode_global(rdtgrp)) {
> 
> Above calls rdtgroup_has_kmode_global().

You are right. This can be static.

> 
>>>> +        rdt_last_cmd_puts("Cannot change mode for kernel-mode assigned group\n");
>>>
>>> The messages to user space also switch back and forth between kernel mode and kernel-mode.
>>
>> Will change to  "kernel mode".
>>
>>>
>>>> +        ret = -EINVAL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>>        if (!strcmp(buf, "shareable")) {
>>>>            if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>>>                ret = rdtgroup_locksetup_exit(rdtgrp);
>>>> @@ -4697,6 +4724,14 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>>>>            goto out;
>>>>        }
>>>>    +    /* Reject moving to different parent if group backs kernel-mode */
>>>
>>> Comment states the obvious. Could it instead state *why* this is rejected?
>>
>> Same reason as in [1].
> 
> ok ... but could the comment be changed to reflect this design choice instead
> of stating what is obvious just by looking at the code?

Sure. Will do.
Thanks
Babu
