Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112533;
	b=1//H+SgeTOhvuXSgr2Q1eDXqaIGoyKkXHY17i8NispMatV9njTKx9qOjTu2fYZsr8P25
	 AShC+f3DvM1ru/JS9XjmXwh+NknAD5xKVWGaQ7kwp6S0X2w1MleF9ItZqHwS1rKWBev/a
	 vPz9wjXjH+T0puhEHIkyv58zYUufiGEck8q2vDotcMYvG+9e59bVjs16zP8z1gGfNEPF3
	 F5h96g5qniLqX524bmTO/0kIj81zmqunFceMWmivGmFSxfXC0b0nKpX3XWEF5bNCUkcc6
	 BnPmjgErBz+KBhedEkOJxe5yxK0iEkHbahzv2C9BRSeJAx950TDVOXkLYJaYNEJo8TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112533;
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
	bh=rpC57UUeHTLwVNGOnWr9fS6V/U0ZRoKzX9ISrUH/F/w=;
	b=3rkEQQ3v6kmNEj6RI6lkZRAU9yK4iglw6+T49OnusBhpUKkFk6Z9Ri0zCj6h1TZAtEdc
	 LdiikPR/ZFt1YmGS0dK3Fkb7bDd2UPp2LfXBPLWSXTFXYHSRrYYIwIWRZG3dsUr6NRdoe
	 bxE0IdCTKAbFk2vS0G8sIijYetY5ucj1bw9b3MOJHiNM4HKepDqVsoiXGbb5hsgNdKDfS
	 k9mQ9WwNKd5RJCbW8niOkJpWX+JR6RKEsv/ybi4cPt8P+4p9R1lIYl/4v+rIbIhCo0fli
	 Gp9n04kRKI0H6dmVW6lFOUyjgchGR8uOdyF9OUnNRfqbGSYz45a3+YV67kwYQ3d1SUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NC441k3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.19
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98029606A31D;
	Tue, 27 Oct 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98029606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NC441k3F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlQZhjVtw6mawQIRK2aP11RVneyX0NmSExOVrT/+znNyrHLQYYcS76m7PBm3sxXX1C6BACmobcjuqUkV7RxSdMeLPCoEnoPhCIFnB92u7ZZ/idZbx0/2W/s/BAWMQpllcZKFMvjhB32QrR0ZgC9k/a4sTurVdgUh22pvjoJKuwhHW8HzjxnQD87YMCleiUToTeyHtoFEhZY9z7kBc07klGYoZFKygJ26qHSux7zQtVJuLUG4aUZUfY6a7Eg+qMZDpgaWQXTDqRBQBUNuMF8qeP+fjXkBVl7YmKuUwCgsejzeIGO0Vyy0OybLUh1XQ5pr77DKJGxge7qr0eYKGOGKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpC57UUeHTLwVNGOnWr9fS6V/U0ZRoKzX9ISrUH/F/w=;
 b=gKKVQVv56DJlovQBAo9lSY3AUGuY2cnPXRRCKgnUoyKLWay7EwqFzPRn4aCY4JPjKLep7ppwthPz650qgmP4jXUO4qvA0nmOSQinyE/HQfSxRxs7zYfumLE4vfgJpHi2aQPKFDJeJIzi9PMsdu7IbQ2vwQ6Lte8R4QznskdLSdtJGBXsXxEZaLDijhfzWHO/UhcX5ZS7zgSc1MqQwQZ7P6Zaa8YWUnGPBK4PTiffPeRDJ5PNqF14iODokPvE8SdKJj91jcG7D3DDAh1LTWa7JyWTfYDG8r2xaEMZTpYk2z/defyx2nVW5Tzz9Vm9CgoXHpRXffHpxzzcgpB5NumLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpC57UUeHTLwVNGOnWr9fS6V/U0ZRoKzX9ISrUH/F/w=;
 b=NC441k3FnJNFRnAv9YasBZU9wfTtzEnM8IOInd9gdShaZIjxYxnvL/a0ayXPe246GOK9wNij9NJGPQJl8n1mQVXK2IlN7tDmEZ/ObFUsX+mpdsX27OT8fu1vw0Qmj14/AWaWz8lxgDZVf5DvLxCpwCnzcBXYF0b0XkOtUrqKMIU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:48:47 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:48:47 +0000
Message-ID: <9778fb3e-f5f8-4137-be2a-598cd44fc6f4@amd.com>
Date: Tue, 27 Oct 2026 09:48:45 -0500
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
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <0082b675-5749-410c-9fec-9ce9b23b2498@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::6) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: b149758b-dcdc-4878-5f2e-08df34396800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|261026140227099003|11063799006|4143699003|56012099006|261022113327099003|261009223027099003|261021135927099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|10067099003|261026121527099003|22082099003|6133799003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WP0NhAFkjcb3qveW1ekDZK8SHyznm999sBhH8JeCRQ9ohuNWANhLk/G8g8NzJaDLjN014UMwGVogpKG7fPyikCNGcX4SoTY98iecejsi8hciUae8gxkJg1wYr73GSDd+Ueb/6vO/I7yncI+jNr6TxZn0LrIhjo3HIKRoNQcU5Bug/LvNRnGiHocSQJoED8OrD/2qYnZgy30GUCanfd9NeVSv7J4WnIGwWT0C39MVuSBfz5zHHlo1A1zDrhfq2KOQk73NsHEakAhOzLBxpacR+EYL56GoHuNF8lysMCqu4ErAMmxktdyeHBYVYlArLXIR6BIjXtcFWxJaAq1pF+x0Xmj20SZ6j+lFHNpgWrMelzUMGYcbMVeMNqNbPv9GB39KMvcjpZk2HV9F3PTyzDBtcbbroIv+EJWLUUM/vP047e2Ro5Da4KWCD9fzG6l6473pC/TkeRmUu9dZM/MKZ1BFGZL3H2r4w0GNm84DBycyzaJ6GOYgAzPfJD+jBrskTyG1DNgL3uJzYCX/Xypl4H78tQ6OLr5e7bel6uJIuf0gdscfubAgOuzXFwi3vefPUD8BhiWYnW122qPfFrnNGNe+hur2SDsbPwN5+P1faO58ebEFt8x5ANqDVVcH6zZZ05Dl0OQZaX6gb38aYiUWx3XvFVHbsQSCpRp9epeLTjNnYIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261026140227099003)(11063799006)(4143699003)(56012099006)(261022113327099003)(261009223027099003)(261021135927099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(261026121527099003)(22082099003)(6133799003)(18092099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mms5ZTdRTUl3ZGRmbUgwQ0dyaVJ5RDFSQVFiOGxUUUplQ0ZKeXFoZkFsQkla?=
 =?utf-8?B?SXFlVFZLdUcwM2xhR0RoTGNBTUEwY2Y5UENXbGUzUnNyN2Vpc250M2xPTU5J?=
 =?utf-8?B?ZzFhWFVxVm83ajV3N244eGNuamJQZWwwNWxJc3FwY3NvZE92dGZvRkM3a29i?=
 =?utf-8?B?aTFwYlpQcmd0S29iUVUwcUtvOGoyWnNsYmI5SitMSnlmcmtsdGc1ak9hb0tZ?=
 =?utf-8?B?S1NmYnEwTzdnc2hvLzVUclhMZFB2Q1cwQlo2SFU3SlA4c1NFNG4zQlcxeVJV?=
 =?utf-8?B?SjRKc01yZXZhVm5ZazZlK0pRRjdkaFdzTkE2NnNubUFKS28ycW1FWjBuTGJV?=
 =?utf-8?B?cjJrMGNRaFVLZkRsb25RVjV6Y0xGRktCaFN2dkhIV3BuczNqVGd4TGJuT1ZJ?=
 =?utf-8?B?dVlIeWMxbjJFd09KUk00SEY2T0FhSXdVZTgrKzJSZk1HZ29nL2Z3Rnc3YVBB?=
 =?utf-8?B?VWYveXR4S3dObUg4QlRTeUFEcSszdUNPZElGNXpiQUJ2cUx1dG1zaEVJVTMw?=
 =?utf-8?B?dStrSDVwQUNEVWcyeDZucWhJZU13alA1VXlHNjA5dXpHcjhld0MwOVNVWTg5?=
 =?utf-8?B?KzRsZklYOFI0dmQ2d1ZMRWlxM2FaZlM3ZXdGMjgwTHd4a3piaTJQTzRITlBw?=
 =?utf-8?B?K2JXdVl6cHBaU2ROM1MwRExlVW1Bbi9EUE96K2toaFI4RFkzZTZUNlR5UklV?=
 =?utf-8?B?ZFZkUEdNUm1IZGZYcDYvNkdwRGV0dUZXNjgycGtuYkRSTXcxWXBMZU8wYytp?=
 =?utf-8?B?U1FsNEVUUWYyY0w4VEVRbzhYWGhVYXU1ZkZJakFvWEJvYzFDWUh3WDRLSUpW?=
 =?utf-8?B?UFBEY1MwNWcvVTdPQk1JSVhsdmx5cFo3cDcwYldzTW8veXVTWm1pbnJrUUFo?=
 =?utf-8?B?ZHBoaDdSRkZ3dFVwdVo4QTB2azhqSjdQNXdaeXhmSk9DNm9NN0hBRkhJSE9H?=
 =?utf-8?B?WTZpYWJ5KzdFRG9uS2RlRDdsT0ZEVllHSHZYU3I3MHh2MkRJcjI2SHllRk9V?=
 =?utf-8?B?T1JRc3E2WHVQckVTTXZndkJHSjluaGNmL2JaMy93bW91QkdXYlNsWGtBUE42?=
 =?utf-8?B?MEg1OGRVYng5dFZhbDJsdS9BZmxpWFVyakhXK3dMenBzU2UwNGpBM0lLWmJl?=
 =?utf-8?B?MmtjVE5LblVXL1RQSVRiOU9Fd0Z5UDRHZ0ZpQjQ3bEhFd0wyZXlSZ2lWbXpk?=
 =?utf-8?B?dFFDOFRFaGp3OURHei9HUTZUVlpXVVUvSDJST3oyMUxxYm9LUTNyaHJiaytB?=
 =?utf-8?B?emhsZ3dLS0EwcWpZbzRURWp3Y01FUVNpZ2ZRZmt6d1p2RWFkZXR0NGVzMmtp?=
 =?utf-8?B?N3BqMzl4bWRGK3pjOGc1WUphL0VLSWhzaHpvejF6dEpwcHpSTXNtcytxL2Iv?=
 =?utf-8?B?d3V5MDhJVHVlTlVnV3FEcXpQdUh2UDVmbWNVNjZUZ1M1dktFRWgxem1EbU02?=
 =?utf-8?B?aUcxdHRLZnMrZGRpSW1yT1gxT1hpaUpJdisrRnlYVVBsbW1vdCtyMHFXWG1y?=
 =?utf-8?B?VElHS3JkLzBKWmNBU3gxam1YeVk1bGRadHM0ZWsyYzJkbUk4NXEweW14QTVh?=
 =?utf-8?B?YmNvdklzYlVJZTQvQVBRaFZaT093WWRFVFhMdjh1MUplcmpxVmpQaVpIcTlF?=
 =?utf-8?B?UndnYjcvRHF1Yk4zemZNSUpPWUxpa3ZVNG1YcVovUVAwdFhlTys4S2VseStX?=
 =?utf-8?B?MTRSb003R0xkTzZVOWpNY2REL05DcmpVeFd4emZRR1k3WS9oRm5TSGM5WWNB?=
 =?utf-8?B?M291emdFL3NFTTV3T0pxNnJHbFlmaUQ1K09WVzJaR1I1NC82TENMMGgwMFA1?=
 =?utf-8?B?MmtlOWdWRlFMcUtuS25HaUU0MkNFZFB3bFhxOHdlbUxFdm11OHVJcjlwOXZ1?=
 =?utf-8?B?OVhFRUtkajlFM2xaRVB1bUcxUUttNDFDblR6NHZqZ05VWS9tQUdxOXRuSjEz?=
 =?utf-8?B?bFJ4T3ZIdExPYlBtdVJYZGxjSEw5TVhVbkFNTlFod0thVmR3aUlLT2VpYXZR?=
 =?utf-8?B?cjZmQnUrRE1vNFRDdVFVMGh5bERpVnBKaWF0OGQ2LzUyZzlXM21XK1Yxd1Jv?=
 =?utf-8?B?UDl3YVhFdFFZUXZBMGxYKzFkcDlhTjhRb3llbENlMzQ5S3QzcnFUL2VFcXd5?=
 =?utf-8?B?aWlQYjFjUUNGcnZPampGcDdKZWxvTGZuMjFCZWFyVFMyTmlWYXY4MTY4MlhQ?=
 =?utf-8?B?RnViNVNCczhwU3FhWUUrV2NtMDdnbll2Zjl6QkZwaVdHUVdQQzh1MFB6aUhW?=
 =?utf-8?B?UER0NFVCTlNpd25SR2lFWm1Bcjhic1MzMUx5d1BaQ3NSWlBTaXV6b1JsUzZx?=
 =?utf-8?Q?/Buu2dmk91/rnL1WCz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b149758b-dcdc-4878-5f2e-08df34396800
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:48:47.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4u5XZe5zP8yBPrLd20rOK5gkUy3d4NTsBOT841IIZvGhv+IS5wFLffj7wR0yDiI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

Hi Reinette,

Thanks for the review.

On 10/26/26 19:15, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/21/26 4:58 PM, Babu Moger wrote:
>> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
>> It is intended for deployments that need to manage counter assignment
>> on platforms where the number of monitoring groups exceeds the available
>> hardware counters. Hardware counters are scarce on these platforms, so
>> mbm_event mode suits workflows that monitor a subset of groups at a time
>> and rotate assignments as needed.
>>
>> resctrl enables the mbm_event mode by default on hardware that supports
> 
> nit: "resctrl enables" -> "x86 resctrl enables" to highlight this is not the
> resctrl filesystem behavior but the x86 arch driver behavior, which is different
> from the MPAM driver.

Sure.

> 
>> it. This breaks the pqos tool [1], which assumes the historical default
>> mode. It creates 16 or more monitoring groups and uses two counters per
>> group. On a platform with 32 counters per domain, that exhausts the
>> mbm_event counters pool, causing additional groups to read "Unassigned".
>> pqos interprets a non-numeric event read as zero bandwidth and reports 0
>> MB/s for those groups:
>>
>>    $sudo pqos -m all:0-4
>>    CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>       0        0.69         16k       192.0         0.0         0.0
>>       1        0.40          3k         0.0         0.0         0.0
>>       2        0.44          1k        64.0         0.0         0.0
>>       3        0.39          1k        64.0         0.0         0.0
>>       4        0.43          1k         0.0         0.0         0.0
>>
>> Leave mbm_assign_mode in default mode during initialization. Default mode
>> uses one counter per monitoring group. On existing AMD platforms, the
>> default active counters pool is 64 and may be larger on newer hardware.
>> The active counters pool is the number of counters that the hardware can
>> actively track in default mode.
>>
>> Deployments within the active counters pool receive accurate bandwidth
>> measurements in the default mode. Users can create more monitoring groups
>> (for example, 4096 on current hardware) than there are active counters in
>> the pool. Beyond that pool, readings may be misleading or report as
>> "Unavailable", with no user-visible indication.
>>
>> Default mode is still limited once the number of monitoring groups exceeds
>> that active counters pool. After hardware re-allocates a counter, a read
>> may return "Unavailable". pqos still treats "Unavailable" as zero.
>> Successive reads can be a count, "Unavailable", then another count. pqos
>> treats those jumps as wraparound and can report an inconsistent rate:
>>
>>    $sudo pqos -m all:0-4
>>    CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>    0        0.76         60k        32.0         0.0         0.0
>>    1        0.45          1k        32.0         0.0         0.0
>>    2        1.57        107k        64.0         0.0 17592186044184.9
>>    3        1.62        276k      4928.0         3.2         0.5
>>
>> Users that need stable measurements beyond the active counters pool should
>> use mbm_event mode and rotate assignments as needed. Enable it with:
>>
>>    $echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> nit: "$echo mbm_event" -> "# echo mbm_event"
> 

Sure.

>>
>> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
>> Closes: https://github.com/intel/intel-cmt-cat/issues/311
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> Link: https://github.com/intel/intel-cmt-cat # [1]
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst | 101 ++++++++++++++++----------
>>   arch/x86/kernel/cpu/resctrl/monitor.c |   1 -
>>   2 files changed, 63 insertions(+), 39 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index b52795e03303..fc3ced99e3b7 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -354,8 +354,8 @@ with the following files:
>>   	::
>>   
>>   	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> -	  [mbm_event]
>> -	  default
>> +	  [default]
>> +	  mbm_event
>>   
>>   	"mbm_event":
>>   
>> @@ -373,20 +373,35 @@ with the following files:
>>   	Moving to mbm_event counter assignment mode requires users to assign the counters
>>   	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
>>   
>> -	The mode is beneficial for AMD platforms that support more CTRL_MON
>> -	and MON groups than available hardware counters. By default, this
>> -	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
>> -	Monitoring Counters) capability, ensuring counters remain assigned even
>> -	when the corresponding RMID is not actively used by any processor.
>> +	It is intended for deployments that need to manage counter assignment on
>> +	platforms where the number of monitoring groups exceeds the available
>> +	hardware counters. Hardware counters are scarce on these platforms, so
>> +	mbm_event mode suits workflows that monitor a subset of groups at a time and
>> +	rotate assignments as needed. The mbm_event mode ensures counters remain
>> +	assigned even when the corresponding RMID is not actively monitored.
> 
> An assigned counter implies that the RMID,event is monitored. Considering this, the last
> sentence appears to have a contradication:
> 	The mbm_event mode ensures counters remain assigned even when the
> 	corresponding RMID is _not_ actively _monitored_.
> 
> Should "monitored" rather be "used"? This would read:
> 	The mbm_event mode ensures counters remain assigned even when the
> 	corresponding RMID is not actively used.

Yes. Sounds good.

>    >  	"default":
>>   
>>   	In default mode, resctrl assumes there is a hardware counter for each
>> -	event within every CTRL_MON and MON group. On AMD platforms, it is
>> -	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
>> -	events between reads resulting from hardware re-allocating counters. This can
>> -	result in misleading values or display "Unavailable" if no counter is assigned
>> -	to the event.
>> +	event within every CTRL_MON and MON group. This mode is enabled by default.
> 
> Please drop "This mode is enabled by default." since this is general documentation and
> this is not true for MPAM.

Sure.

> 
>> +
>> +	On AMD platforms that support more CTRL_MON and MON groups than hardware
>> +	counters, hardware dynamically shares a smaller pool of counters among
>> +	RMIDs. One counter from this pool is used per monitoring group and counts
>> +	every MBM event of that group's RMID. The size of the pool is not
>> +	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
>> +	much larger. For example, 64 counters in this pool monitor 64 groups.
>> +	Newer hardware may provide a larger pool.
>> +
>> +	While the number of monitoring groups does not exceed that pool, a counter
>> +	stays attached to each RMID and readings remain accurate. Creating more
>> +	groups than the pool can cause hardware to re-allocate those counters
>> +	between successive reads of an event. Bandwidth values may then be
>> +	misleading, or a read may return "Unavailable" if no counter is allocated
>> +	to the RMID. There is no user-visible indication when this begins.
>> +	Users who need stable readings beyond that pool should switch to mbm_event
>> +	mode, if supported, and assign counters to the groups of interest
>> +	(rotating assignments as needed).
> 
> Above are two AMD architecture specific paragraphs inserted in the middle of generic
> documentation. On top of that, the second paragraph does not have any architecture
> specific "markers" and this could be confused as being generic.
> 
> Could this be re-organized to seperate the generic and arch specific documentation?
> This could be done similar to how the io_alloc documentation used "See architecture
> specific notes below." text. The two AMD specific paragraphs can then be linked.

Yes. Looks good. Thanks for the patch.

> 
> For example (changes on top of this patch),
> ---8<---
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index fc3ced99e3b7..f33c06612a77 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -350,7 +350,7 @@ with the following files:
>   "mbm_assign_mode":
>   	The supported counter assignment modes. The enclosed brackets indicate which mode
>   	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
> -	is changed.
> +	is changed. See architecture specific notes below.
>   	::
>   
>   	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> @@ -383,25 +383,7 @@ with the following files:
>   	"default":
>   
>   	In default mode, resctrl assumes there is a hardware counter for each
> -	event within every CTRL_MON and MON group. This mode is enabled by default.
> -
> -	On AMD platforms that support more CTRL_MON and MON groups than hardware
> -	counters, hardware dynamically shares a smaller pool of counters among
> -	RMIDs. One counter from this pool is used per monitoring group and counts
> -	every MBM event of that group's RMID. The size of the pool is not
> -	enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may be
> -	much larger. For example, 64 counters in this pool monitor 64 groups.
> -	Newer hardware may provide a larger pool.
> -
> -	While the number of monitoring groups does not exceed that pool, a counter
> -	stays attached to each RMID and readings remain accurate. Creating more
> -	groups than the pool can cause hardware to re-allocate those counters
> -	between successive reads of an event. Bandwidth values may then be
> -	misleading, or a read may return "Unavailable" if no counter is allocated
> -	to the RMID. There is no user-visible indication when this begins.
> -	Users who need stable readings beyond that pool should switch to mbm_event
> -	mode, if supported, and assign counters to the groups of interest
> -	(rotating assignments as needed).
> +	event within every CTRL_MON and MON group.
>   
>   	* To enable "mbm_event" counter assignment mode:
>   	  ::
> @@ -413,6 +395,24 @@ with the following files:
>   
>   	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>   
> +	In default mode on AMD platforms that support more CTRL_MON and MON groups
> +	than hardware counters, hardware dynamically shares a smaller pool of
> +	counters among RMIDs. One counter from this pool is used per monitoring
> +	group and counts every MBM event of that group's RMID. The size of the pool
> +	is not enumerated to software (unlike "num_mbm_cntrs"), and "num_rmids" may
> +	be much larger. For example, 64 counters in this pool monitor 64 groups.
> +	Newer hardware may provide a larger pool.
> +
> +	On such platforms, while the number of monitoring groups does not exceed
> +	that pool, a counter stays attached to each RMID and readings remain
> +	accurate. Creating more groups than the pool can cause hardware to
> +	re-allocate those counters between successive reads of an event. Bandwidth
> +	values may then be misleading, or a read may return "Unavailable" if no
> +	counter is allocated to the RMID. There is no user-visible indication when
> +	this begins. Users who need stable readings beyond that pool should switch
> +	to mbm_event mode, if supported, and assign counters to the groups of
> +	interest (rotating assignments as needed).
> +
>   "num_mbm_cntrs":
>   	The maximum number of counters (total of available and assigned counters) in
>   	each domain when the system supports mbm_event mode.
> ---8<---
> 
> 
> 
>>   
>>   	* To enable "mbm_event" counter assignment mode:
>>   	  ::
>> @@ -1784,62 +1799,72 @@ View the llc occupancy snapshot::
>>   Examples on working with mbm_assign_mode
>>   ========================================
>>   
>> -a. Check if MBM counter assignment mode is supported.
>> +a. Check if MBM counter assignment mode is supported. The boot mode is "default".
> 
> Same comment as earlier, please drop the "The boot mode is "default"." that
> does not apply to MPAM.

Sure.

> 
>>   ::
>>   
>> -  # mount -t resctrl resctrl /sys/fs/resctrl/
> 
> Since this drops the "mount" command. Should the final "unmount" step be dropped also?

Yes.

> 
>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  [default]
>> +  mbm_event
>> +
>> +The "default" mode is enabled. "mbm_event" is supported but not enabled.
>>   
>> +b. Enable "mbm_event" mode. Switching the mbm_assign_mode may
>> +reset all the MBM counters (and thus all MBM events) of all the resctrl groups.
>> +::
>> +
>> +  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>     [mbm_event]
>>     default
>>   
> 
> The above changes could be merged together under a single step "a" that
> will significantly reduce the churn when considering this is a stable patch.

Yes. We can. But because of auto assign is not enabled on mode switch, 
we still have to touch few steps. Your choice.

> 
>> -The "mbm_event" mode is detected and enabled.
>> -
>> -b. Check how many assignable counters are supported.
>> +c. Check how many assignable counters are supported.
>>   ::
>>   
>>     # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>     0=32;1=32
>>   
>> -c. Check how many assignable counters are available for assignment in each domain.
>> +d. Check how many assignable counters are available for assignment in each domain.
>>   ::
>>   
>>     # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>> -  0=30;1=30
>> +  0=32;1=32
>>   
>> -d. To list the default group's assign states.
>> +e. To list the default group's assign states. Counters are not assigned
>> +automatically. They are unassigned when the mode is switched to "mbm_event".
> 
> I think "Counters are not assigned automatically." contradict mbm_assign_on_mkdir
> that is forced true on the switch. Can it just be dropped? That would just leave:
> 
> 	e. To list the default group's assign states. Counters are unassigned when the mode is switched to "mbm_event".

Yes. Sure.

> 
>>   ::
>>   
>>     # cat /sys/fs/resctrl/mbm_L3_assignments
>> -  mbm_total_bytes:0=e;1=e
>> -  mbm_local_bytes:0=e;1=e
>> +  mbm_total_bytes:0=_;1=_
>> +  mbm_local_bytes:0=_;1=_
>>   
>> -e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
>> +f. To assign the counter associated with the mbm_total_bytes event on domain 0
>> +in exclusive mode.
>>   ::
>>   
>> -  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # echo "mbm_total_bytes:0=e" > /sys/fs/resctrl/mbm_L3_assignments
>>     # cat /sys/fs/resctrl/mbm_L3_assignments
>> -  mbm_total_bytes:0=_;1=e
>> -  mbm_local_bytes:0=e;1=e
>> +  mbm_total_bytes:0=e;1=_
>> +  mbm_local_bytes:0=_;1=_
>>   
>> -f. To unassign the counter associated with the mbm_total_bytes event on all domains.
>> +g. To unassign the counter associated with the mbm_total_bytes event on all domains.
>>   ::
>>   
>>     # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
>> -  # cat /sys/fs/resctrl/mbm_L3_assignment
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>>     mbm_total_bytes:0=_;1=_
>> -  mbm_local_bytes:0=e;1=e
>> +  mbm_local_bytes:0=_;1=_
>>   
>> -g. To assign a counter associated with the mbm_total_bytes event on all domains in
>> -exclusive mode.
>> +h. To assign a counter associated with the mbm_total_bytes and mbm_local_bytes
>> +events on all domains in exclusive mode.
>>   ::
>>   
>>     # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # echo "mbm_local_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>>     # cat /sys/fs/resctrl/mbm_L3_assignments
>>     mbm_total_bytes:0=e;1=e
>>     mbm_local_bytes:0=e;1=e
>>   
>> -h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>> +i. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>>   no change in reading the events with the assignment.
>>   ::
> 
> Could you please remind me if the first read after assignment returns
> "Unavailable" or a valid count?


As far as I have observed, mbm_event mode (ABMC) returns either 0 when 
there is no activity or a valid count. I have not personally encountered 
an Unavailable value. However, the specification allows Unavailable to 
be returned when the count is not available.

> 
>>   
>> @@ -1852,7 +1877,7 @@ no change in reading the events with the assignment.
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>     121212144
>>   
>> -i. Check the event configurations.
>> +j. Check the event configurations.
>>   ::
>>   
>>     # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> @@ -1862,7 +1887,7 @@ i. Check the event configurations.
>>     # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>>     local_reads,local_non_temporal_writes,local_reads_slow_memory
>>   
>> -j. Change the event configuration for mbm_local_bytes.
>> +k. Change the event configuration for mbm_local_bytes.
>>   ::
>>   
>>     # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>> @@ -1871,7 +1896,7 @@ j. Change the event configuration for mbm_local_bytes.
>>     # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>>     local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>>   
>> -k. Now read the local events again. The first read may come back with "Unavailable"
>> +l. Now read the local events again. The first read may come back with "Unavailable"
>>   status. The subsequent read of mbm_local_bytes will display the current value.
>>   ::
>>   
>> @@ -1884,17 +1909,17 @@ status. The subsequent read of mbm_local_bytes will display the current value.
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>     1566565
>>   
>> -l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
>> +m. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
>>   done using the following command. Note that switching the mbm_assign_mode may reset all
>>   the MBM counters (and thus all MBM events) of all the resctrl groups.
>>   ::
>>   
>>     # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> -  mbm_event
>>     [default]
>> +  mbm_event
>>   
>> -m. Unmount the resctrl filesystem.
>> +n. Unmount the resctrl filesystem.
>>   ::
>>   
> 
> As mentioned earlier this is now asymmetric after dropping the "mount" in the first step.
> Should this unmount step be dropped now?

Sure.

Thanks
Babu
