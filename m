Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EF31ED7C;
	Wed,  8 Apr 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689643; cv=fail; b=uQAbQt0IW0aJO4KWkXZD3KMf95ltVUdvXpnD4IW791ord7sci7mVaBWFVtW387wlEusXfACW2rLhuoM4ByEj8qcvHFov1HRvFsEXm1ubMC0IishORfLTlEGMImwgPJOGJpF6a82sep4KW48LdUwPU/LkubXoqXMi6DpyAReFnXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689643; c=relaxed/simple;
	bh=Mawv0L7zbrl7kynkFRFspOYC/j4hqQy66mBGJgeEWtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUpLcJ5Zok4X8mNZiTtDpXO+AIAYn1z5KK3CAxb3jp+lu7hmVkkU1fElaw/UshrO5JJqR8KqbPWlSDF1xRSmXTDNLW3v92jTTLJhaEV0NQWywg6f/1iec8TVal2/B1xe66ooKqto/OFjcC+KUz/Kk2LzqtSxn0V5Z6Ym47ENUqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5alOyuhi; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5alOyuhi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAbJZsLTBjIeJdQQHUei68i6lgbQhSNx+GkjE/8Im1CG/VCZjs0Y9ZqVOR0HYTZv0SpCPOjEtZ4A83pU8H85kyj4tTm80mQq9W9PyE6yakM8E/fet7kX9FFCIRZs3PPCbU92dRL8W5K+XPGT7gM35NR/INWxXzNVA8kxP4Zo5LNC+hOIHky2WqapfzXKPLpUdg8UhzrF90Q7KFYMooF0+uKySfRG8eBe0zyxx27/rznkPjg2UBZlD3fT+7E7lf1qEwUKz434ZB8LX9h/iw6jDFUw83zefS5U4Tr4igLDKGMHaBoy+LsdkALA+vt5FoUmKdRjhp1PcKxgP/DI/lhRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypFM6r8Cvu+6fzxw+FQKkBN4Jyx8WBHIIU1sPl2lE/0=;
 b=gZc/jA8sbocnrXc/6GGqJM/kTcDdesfei3kDlMwja+meoVDC4QkFbbtwWuPl+vwMfX7MBEbvZJxP4BPWq4p2/kiJ9QObMxed7DuW3SRauF/OKSovPaObuWlLCDVAcMwpldXVkWj0xfbSLZ/gvQ+nWcEq965YFpnp13H/dcTnSanTCCKUMCWarNHLGjO3YVsyp/Zb0pq4uiEi3BkXrZ45WXlM/lqK3/sBJHXLWXUyWiT6z4zwWjEATz92Z+gboT9345w+La5pZUgjkGYnvUddOxLoh0FFLqKrIHebNdvLdFaypIz32zEZNjUabNPbsUy+o0L5SgCeynVxXx+6h7JyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypFM6r8Cvu+6fzxw+FQKkBN4Jyx8WBHIIU1sPl2lE/0=;
 b=5alOyuhivVw5WhwhuNS28N61mEVxx2C+0JHdVHDt0gTc+/Ib5ZLVNTLwRIu3D8mwU5Yi32OVPWEmW76iiqwuxOlfvICbLpEeVsf1S9eEv+SW85kVnyVcNWZKXBWBhIdvgFuhIMoulalLUIL2H2ScIZUbCwhlpCuEZwyVd3CMM9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ1PR12MB6195.namprd12.prod.outlook.com
 (2603:10b6:a03:457::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 23:07:17 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 23:07:15 +0000
Message-ID: <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
Date: Wed, 8 Apr 2026 18:07:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>, "elver@google.com" <elver@google.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "safinaskar@gmail.com" <safinaskar@gmail.com>,
 "fvdl@google.com" <fvdl@google.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com"
 <tiala@microsoft.com>, "chang.seok.bae@intel.com"
 <chang.seok.bae@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eranian@google.com" <eranian@google.com>,
 "peternewman@google.com" <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <72297351-2954-4318-81b6-7de409e5552c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:610:b0::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efcb0b3-1570-47b0-1a6e-08de95c3935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	+No5/M6QweMoP5G7z3OVSzPV4C8w6SMCPEPk3N3+bU2u1T6/cHMT6GQsEcjtOiM+VnPJ/T259abPyFxzhonStA2eEwTMwf7+yGcR5rEb6lzQL0xthpC4qN3OG6SIYAOteaGDVEKY7EG3G6XEdxsAVBZLemXTxknUhgGW2eJwDkQZWJT0SPLwv5VZiY8uItrv2jEBg44kuLNGHakBw9s+uJW/3VxvPra1NEJW/+X1hGDkxleP83+bIaUj1SUtF60AR+V9gAtDguLLPFuJtH3fARexFqncNmtD6UPUA2bXwW3Ij44sqibgHEej+5sNTScUcwKUmJi3BZwxN8SpNN0vQmN8VCkZtU+zlSQInQm5NB8GE4gvr7yXPSOGpDMwP0d6uzy1zKBfTJUd/PumNF7PribLhGw4WyjHZKHz3xRX4sdAU2iH5T+T+WrcZZmLNZ7tDHFlH644okxw3V7iAq0MAw2ASpYBk+dQ3mJyKrmj38X9bZCF8q18sIeMHIAOLXqsVZKKUlAgVVdLMpbx7l91tAR3yj1iehQKJCmua7fd13pBuo19LSik6SBuH+Pg56iM1PL2zo3vqo+69t2ZbxeoRpjoLqaPu1OLHJp+UNwnn6yziL/DKR4XsQqLeEwKpXF1tIC935CqhacSHRVA5VkBZn/tk6haKnZ0VjWG7aup3Tfc7jUEtWtfcnI4NYAlbmhrmHNXHabS4liNH04jslmm8YlhtD5tVZylSUBajM90Pwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHA2RXVacHl2RXlCeDhzNFNxcklGQ1hvejNZS3F3QlJYZVYvUGZnZUVSd1la?=
 =?utf-8?B?aG9TNTBXcEZoS01Eb2pCTnpadlVFcGZLZFRDbWtjYTNHZ1N0ZUF5MjFLZEVW?=
 =?utf-8?B?bHRWeUwxOEI4V2ZTNzBHMnFkRksxckNWb3FzMHpCR25XMllCbWdPcTJhMjFw?=
 =?utf-8?B?bjUzVlNSTU45TVgxakFOQXMxeHpLbFF5Yk5hb0tpM2tvbEZNUnUxdjRMOTFr?=
 =?utf-8?B?MUs2V2tRQnc4VktDTExBL3lzbmFlSndPQ0p6UlF0bkJMcGx5aHBYTmh6NFFa?=
 =?utf-8?B?aCtlaWtrbXdXMTNXSkVra1F0dkZWdWxja0l6eTZ5SWtxVHRteHp6YnV5bkto?=
 =?utf-8?B?K08xQlhzMzFJMnFvV3pmTnJmbHRhWVIvUkdsaGcrUG9MamxNWHNXVTUyOHE2?=
 =?utf-8?B?M2lCVDc5M0thQ2NCN1BLSFBjdExYS3R5ZWRRbEllRXhXYjkwM1NSWGhmU3kr?=
 =?utf-8?B?UUs1Z1RsS21lZVVMUi94Y2ZaejdCc2htRGVTd3plNnk3bWxhZHBOZTNjYi9C?=
 =?utf-8?B?ei92eVMvQUFtQzZ6V0JFNE9kV2pseEIwRStnamJkK0k0a0VRdURQM3ZycVJa?=
 =?utf-8?B?bmw2MHYyYjFUOFBHbWlaL0YvL0JGSFNTaGZOTjZDd2xNOUYvSGd2RWM3cEY1?=
 =?utf-8?B?M1dCMnl6MFRLby9mQU5GK0doNExTVVVvL0ZwWkxHMXdFc2pBMURxbCtSRWVC?=
 =?utf-8?B?b0V0WDBnbnJPbVByYkhTYjdkVU53ZDl4Z3huSTNVemJ6aTFCeVQwUW5TVHIy?=
 =?utf-8?B?ZnNTb0xuOWhVcjVQUTlhaHkyeEozUEkzazNLR1p5WEd5dGtRcVlGU29TU3Yr?=
 =?utf-8?B?OUlnYnU3YnV6WXZGdnk5UEJSVFN2ZG5IYllzMDVxN1RpYzhuRlp5cDl4UnhR?=
 =?utf-8?B?clZuMGdnSDVKekVRY3ZUcmpoOGtuM0Z4UFgvMXQ1Y2dMZE81R0YreGl5dHF1?=
 =?utf-8?B?TXQvcEpzQ3AweWNLU1FzRTRmSmhlUWVRVTlheENkdG1RQlR4VUN5VWpqakZp?=
 =?utf-8?B?WmhGalJhbis1YXhvWlFKT0pVY2VMUzk0Q2UyRWlaeUZndTJTc2U2Zm9KYUR0?=
 =?utf-8?B?N21VUjNLRlNYVUhRZWxMWU5tLzZuVVcrekNKNWFNRFgzUzcxM2FHOGNjZnpR?=
 =?utf-8?B?eDBFNUV1K1NmOHp0WEFVUkU3dy84SEFGQkRTL0JRd3JDSXUrRTNUUDVEeGJS?=
 =?utf-8?B?c3I1d2ZBMVozdWV1b1VjQzRBdzRrcmpWa2N0c3FQRFNyYVVEUWk2b2JYanBy?=
 =?utf-8?B?V21MTFVCYTk3KzdSbE1uK0d5OWtxWW9tcVJiQnV5a3NQTlg2WFdMYVRwVlpu?=
 =?utf-8?B?QUlvN2FDUFBMZ0Jua1J5YjZMaTg1YWpMUnJ1KzkxWUcvWEJMRmVQd3RPdnhw?=
 =?utf-8?B?Tm9xRVdFdVVsQVY4M0FJcXM1dU1JZTJYb3d6M25ybUkrNTRmbjZjY2JmVm5I?=
 =?utf-8?B?cituQVhpZEpmd3FTYnZpNzJIZjd5TUVtd1VyOWN4dGZza25tQmdMbHp6VEZo?=
 =?utf-8?B?VE9KejlrUGJkTXVzVFVJb0lNS3c2Ymp2WW54NjFEU09xclFCVVFpL21wTWJC?=
 =?utf-8?B?bGlNNHFIbG84Y2grak1NNFFYcHRoVnAzSnAzUDlNc3NXUDlRaWNERG5vWGR1?=
 =?utf-8?B?WTFvQlJsTmVjR0d2ZS9UM2tDWEhHMzU5UHpPZ1BQMU5RaXZSTkVOejBrYjBn?=
 =?utf-8?B?SkhNOUM5RTVnN1VGaFdwWERONk04VDBJK1UvTHlJTUFUZWE0NUJ6bmlvVXhK?=
 =?utf-8?B?MFJyV0lPeXlTa1pDWlB1Nk1yYlBlWWdOV2trbzY3SE9aQjVMaG9PSGlGaXNT?=
 =?utf-8?B?RHJLMjB5b0RXTGdmcnJ4eEh4UEEzS2ozTk1QNEgwM1JwMEVjWEFBQjd4RXpH?=
 =?utf-8?B?cm9jQlZXa1ZyUGdBeWxoWGgwQ2pIZ2tMQmhpZjFxUlNXTVhpTW9JTFlxU3VU?=
 =?utf-8?B?bzN4UC9xUlBNM1R0b1V4a2l2UVc5YUhDcE15VFhtYjdEa1pQZExPandWK1JS?=
 =?utf-8?B?RGVsclhQbmVDK3grU1U4Z2hzUFhqV2dobWxaTlFMQUhTZU5aUktYc3paWWtQ?=
 =?utf-8?B?am5pNE5JOWV6ZUgzbm56bjVkKzFwMU5DQTJZdDBZMW81ZHZ2RVEzaFpyaTBX?=
 =?utf-8?B?ejRGQ0JzWUx3SmpFQXM5QjBjQjRUUzBvTmZ2aVQ5M2lweGRZbDdFVytwT0FB?=
 =?utf-8?B?ZllpcUhoUkhTOWxGU3NpTERZOFRJUjNocStXSUVjZEd6WVF4ZDFkM3hqZmRm?=
 =?utf-8?B?L08rUEFLTlpHOUpNRzB3MTdjbXFNRGtsWkRrWHFmbVhNSUFxRUhnMEdQdzdV?=
 =?utf-8?Q?vdyO6Qz8CTRB8mmkE2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efcb0b3-1570-47b0-1a6e-08de95c3935e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 23:07:15.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHChcMtEPFaFaTiw1NjDQbuzNmI6KJ+MDE9bkRw7EbmKiz8bafZIm2Y24cMdXtdX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

Hi Reinette,

On 4/8/2026 4:24 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/8/26 1:45 PM, Babu Moger wrote:
>> On 4/7/26 23:45, Reinette Chatre wrote:
>>> On 4/7/26 6:01 PM, Babu Moger wrote:
> 
>>>> That said, I’m open to not having a dedicated group if we can still support all the features that PLZA provides without it.
>>>
>>> I find that enabling user space to share CLOSID/RMID between user space
>>> and kernel space to indeed support what PLZA provides. I think I am missing
>>> something here since below proposal again attempts to isolate a resource group
>>> (CLOSID) for kernel work.
>>
>> No. I dont want to isolate a group just for PLZA. All I am saying
>> is, we should provide option to create a dedicated group if the user
>> wants to do it.
> I agree. I do not see resctrl needing to do anything to accomplish this though. If
> the user wants a group dedicated to kernel mode/PLZA then all that is needed is for the
> user not to assign any tasks to this group, either via changes to the group's tasks file
> or via the group's cpus/cpus_list files.
> 
>>>>
>>>> The mode can simply be determined on a per-group basis. We can
>>>> introduce two new files—kernel_mode_cpus and
>>>> kernel_mode_cpus_list—within each resctrl group when kmode (or
>>>> PLZA) is supported.
>>>
>>> I think having these files in every resource group is confusing since user can only interact
>>> with these files in one resource group for current PLZA. Why not *just* have the files in the
>>> resource group that matches the group in info/kernel_mode_assignment?
>>
>> The default group can also serve as the PLZA group.
>>
>> #cat info/kernel_mode_assignment
>> //
>>
>> At this point, the (kmode_cpus / kmode_cpus_list) files will exist in the default group:
>>
>> Then user changes the PLZA group to "test".
>>
>> #echo "test//" > info/kernel_mode_assignment
>>
>> At this point, we expect the files "(kmode_cpus/kmode_cpus_list)" to be visible in "test//" group.
>>
>> One open question is whether we should remove the visibility of these files from the default group. It’s unclear if we can safely do this dynamically.
>>
>> An alternative approach would be to always keep the files present, but allow access to them only for groups that are listed in "info/kernel_mode_assignment".
> 
> The files appearing/disappearing is just how the user experiences the resctrl fs interface.
> Within resctrl the files could indeed always exist but resctrl can use the kernfs_show()
> API to show/hide them as needed. Similar to resctrl_bmec_files_show() that you created.
> Allowing/removing access becomes complicated because user space can always do a chmod
> to change permissions that resctrl would need to handle.
> 
> I do not know if there are sharp corners here when thinking about strange scenarios where
> user opens a file before resctrl changes visibility or permissions and then user space
> interacts with the file. This may be worthwhile to test to matter which mechanism is used.
> 
>>>> Files and behavior:
>>>> - cpus / cpus_list:
>>>>
>>>> CPUs listed here use the same allocation for both user and kernel space.
>>>
>>> Both user and kernel space?
>>
>> As it stands today, the CPU list is written to MSR_PQR_ASSOC, resulting in the same allocation for both user and kernel within a given CLOS.
>>
>> Kernel-mode allocation changes only if specific CPUs are included in the kmode_cpus list.
> 
> ack.
> 
>>>> There is no change to the current semantics of these files.
>>>> If these files are empty, the group effectively becomes a PLZA-dedicated group.
>>>
>>> I do not see it this way. If the cpu/cpus_list files are empty then it means that the
>>> tasks in the group will use their own CLOSID/RMID for user space allocation and
>>> monitoring. What allocations/monitoring is used by tasks when in kernel mode depends
>>> on whether the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
>>> file. If the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
>>> file then it will inherit whatever the PQR_PLZA setting of that CPU which is the allocation
>>> associated with the resource group to which that kernel_mode_cpus/kernel_mode_cpuslist belongs.
>>> If the CPU the task is running on cannot be found in kernel_mode_cpus/kernel_mode_cpuslist
>>> then its kernel work will inherit its user space allocations and monitoring.
>>>
>>
>> Yes. that is correct. I think our understanding is correct, but our implementation ideas are different it seems.
> 
> While we have been sharing different ideas I have tried to be clear on *why* I made
> certain choices and attempted to provide specific feedback to your ideas. If you find
> your plan to be better then please respond to my feedback about it to help me understand
> why that may be the better solution. If you find your solution is better then could you please
> describe it with detail? At this time I do not have a clear understanding of what you propose.
> 
> ...
>>
>> Let me make sure I understand what you mentioned earlier. Copied the text below from the thread for the context:
>>
>> https://lore.kernel.org/lkml/3305c18e-9e50-4df0-b9f1-c61028628967@intel.com/
>> =====================================================================
>>
>> Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
>> specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
>> mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
>> "kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".
>>
>> In summary, I think this can be simplified by introducing just two new files in info/ that enables the
>> user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
>> global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu.
>> global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
>> global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.
>>
>> The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
>> "kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
>> it will be all online CPUs. The resource group can continue to be used to manage allocations of and
>> monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.
>>
>> A user wanting just "global" settings will get just that when writing the group to
>> info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
>> info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
>> files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
>> expected to inherit both CLOSID and RMID from user space for all kernel work.
>>
>> ======================================================================
>>
>> Let me try to get few clarification on things here.
>>
>> # cat info/kernel_mode
>>    [inherit_ctrl_and_mon]
>>    global_assign_ctrl_inherit_mon_per_cpu
>>    global_assign_ctrl_assign_mon_per_cpu
>>
>> My understanding of "inherit_ctrl_and_mon" is that the kernel
>> inherits both the CLOS and the RMID from user space. Basically both
>> user and kernel uses same CLOSID and RMID. This reflects the current
>> behavior (without PLZA) correct? This would correspond to the
> 
> Correct.
> 
>> default group when resctrl is mounted.
> 
>>
>> The modes "global_assign_ctrl_inherit_mon_per_cpu" and "global_assign_ctrl_assign_mon_per_cpu" represent the actual PLZA modes.
>>
>> Both of these modes introduce new files kernel_mode_cpus/ and kernel_mode_cpus_list in the resctrl group.
> 
> Right. To be specific when the user changes the mode to either "global_assign_ctrl_inherit_mon_per_cpu" or
> "global_assign_ctrl_assign_mon_per_cpu" the new files will be created in the default resource group with
> associated setting applied globally at that time.

If, at that point, "info/kernel_mode_assignment" points to // (the 
default group), is that correct?

And if "info/kernel_mode_assignment" points to a different group (for 
example, test//), then the kernel_mode_cpus/ and kernel_mode_cpus_list 
files will be created only under the test// group. Is that correct?

Thanks
Babu

