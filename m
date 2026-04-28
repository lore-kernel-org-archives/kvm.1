Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3E3C9EF1;
	Tue, 28 Apr 2026 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407159; cv=fail; b=nOa0j89Cg/W65MGAJA9dpm2aWicu/Qn8NWmcbToK3M1JxuDTESybuLA/zz/Wxadqq/jAUbTvxfEH5u4rrqaDccBnOEzNS/AUyvAkALXPEZEkCaNqjNmj0l9OXI45m8cu8mAcavZDuPyj86QG00pj3ac3Irfupb+INxCyUrdb/CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407159; c=relaxed/simple;
	bh=eEYCn7K3O02SjLLzVasYKWvdCtGs+fdaHqAhKLSdBXk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJTOvm0e0/XmIdNHP/A2joGNgbo3jEETUwHwMoJLKphlhgGPDa9FLb6cTsExoFDEZgZx8MtdzazsB2nGG4MbMhjgyXfdzQieWrdTokHz/NDGlfpT5uK/ZqlbVwxAK71LKXtfx7O3MlaKFAiOxNDtfPGlBP2rm82tNHCAloD3Rg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MACcCcrK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MACcCcrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777407157; x=1808943157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eEYCn7K3O02SjLLzVasYKWvdCtGs+fdaHqAhKLSdBXk=;
  b=MACcCcrKnMZTWb8MchSrkKNWfHMcMNfDSfC1MFNCexxnH62uSzX9rk8E
   dCaIie2w+/NSBQ7ccuMQ1jwuISGHc/mmEF/IXS8BlUzc1/IIwh90dy/Uu
   W5dquDeaXD2vUP3KtACeNMUQFDqVzF+nofPYb7boFj7yTnQgqRmVdLzik
   et62z/aXCbVk/+teeRYg/ef4tbwG4LGs5RcSg7JPft100TFPfNzvAb4xc
   U9ruwbuJN11qLM1bcIlAlEWzSVDIH9vlYRqg+RNDX0pNrFWlHpAfRooRK
   Ysyb014Z+CidphQq6Duh2RHqmwZshuq4V8JkqpNt4b0PB3wElJ9V4BhZZ
   Q==;
X-CSE-ConnectionGUID: vhU61kiWScWH5Z9qkk9LUg==
X-CSE-MsgGUID: Ylren7gZT7OSzdCyZwGAPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78444331"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78444331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 13:12:36 -0700
X-CSE-ConnectionGUID: /u4oltwpSXi7m5937Fyx3Q==
X-CSE-MsgGUID: cZ7wArvBQWmSbEapE0Kxrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257379842"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 13:12:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:12:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 13:12:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ24hwW2ZUYiAHp1FFYr9t9M3ZP/7eF/YCF+CNMqYSkOmZMSbkLfvl00LPMC95HljhCEqtlDGtlwXw7gepR4tvqHZ5Ob6lUhDzQ/q0pfcPIbotTOpub2oedSQgqMmeVN0GH/hRjS9XDvoUOVLWdLM+EJRRhwpWNBV0H1lkKL/oVQXaBkN4eW/Ub6u7fC/vMo48f8IXfWoXxAjgteJnfuQdeAxOD0AKg+ubbshowq/1dOP5vF45P89GbBNkXSX4GbiZz9mmKlz8jj5MEfB5KSuFBrzlrV/JUie6/q8Wt/3lfu8S+fRAxNfhVDBP5of5CnzCVBZmpPm3kNefFS2B8dVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py845oYQROmJ6eVz0O7I0g2t5Tepnqm6bQkAqKY4mWE=;
 b=NCedzia3Qko3ZYerWDuoh8+h4p2Azr0tqqF1P2zc+NOQQNsUs0c28RTpjksK1fcpxjKVyztWkq736yo550oDFTfhdQiAynDgDpR9swrAS8C3fSF6JQ5NXsZtPL0TBocSmr+ZsFc0vyJG/ZQW16IN4SZK+WEj3uaGr0+LbMahx7sRGxQooxlDMQ2RK6xM40HvjibVxk7Zruyja3gvIgFEYP4rAAewoyCdtRu7/m6iuslgq4jHHzt6ues3DINCk+31ubUSSFkqoN5nIZ3FAKls6nvM6vQa4N62OdxAzaTJ6rL9cSWfKyxOSCAEZkiONJGvWW9TVqOlZztzDWrKdxSt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Tue, 28 Apr 2026 20:12:27 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 20:12:27 +0000
Message-ID: <c87d863b-e053-416f-bae2-6960b4b9d0fb@intel.com>
Date: Tue, 28 Apr 2026 13:12:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] KVM: VMX: Macrofy 64-bit GPR swapping in
 __vmx_vcpu_run()
To: Paolo Bonzini <pbonzini@redhat.com>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chao.gao@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
 <20260428050111.39323-2-chang.seok.bae@intel.com>
 <6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe36392-1500-4256-dee4-08dea56277ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 01iAw5UvdQwsab70rwLP6CaBSdSSGTfcnIscmS6GQEYecCMYHOqA9ZX0/5vBoLggGWlOivqhEQpzqymc4GxoSnHpV8xYqTarA/8ogIFwuFHWNVfCFOxEd56bFc0fUBDWabPxED6CotxI+83LxfX0jJDhkZW/v0r9OB1pZ7WMJRIalVwvZ3GeD6DPqhAlS5Oaeb1x181ah/kK9pihzqkjMav0GwtClcxRqpBgPduODargh3kzfkaqmwfi5ymWBzN3saJ3FE9HWDNT0vx7fVf7iyffCA5V9qXIdQcnP1ELd4nbx+v7UGnT7P/jy9GAEKnzu2WJARBoGXoXojpanRP5wEXKKYtXJAuYaMOsVdbzyUnzj3t0LRLv/7rSRZ06kkDp0prfpb/AymST5+LGXdf7QEQLUqA2BwhwmQcz5Py/CTF2cXcGQBppkF5fSYsLnrpiASk9BQ8gKrJJM2aP3quUJC0ovFA2E/w2llBn4cKIf2CptPdpN52NFfelbeDb1XoM49T3XH0CVlGtwgtIj9wATN0e/QtQvsCdswgUBaI/xjPegf0SUd2uxWh3H5zFj2ZaRzpuikoXCSbd5Q9+0y+ln5qE5w0dHyzYAkeBY+hFfMpjYEgY7EkPfoHsg2W/mK7th35xqrHs5D0Li5lqoFAsWfGN0TWl46NY7qHPnBPpg1yfYPjkrv6/Js7UuQiCfifNR7gq/7Y4G+FpCAU6gYQGV0iU8ZKfCeimB+XTApfUNcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZ0TzRWazJPYUM3MHFhMjB6UUJLTnlUb21EQlU2UU1PYjlDTS91eWw5ZnNl?=
 =?utf-8?B?Q1FHVTEwQlNDRS9BUnJtaGFOMVNMN2V1SGpPM1dTRXFhZTdCR0VOK3dkc0hy?=
 =?utf-8?B?bGdiNnhYRG0vMFQ2TjVQeUJROHByMzVYTDFVczZmS1lnck9GUnU1N0xjWVVG?=
 =?utf-8?B?Y1pubm16aXlyRk1tQzQ2RFluUzRST0M0ZnhNSTUzRmlOWjlUcXFWNXlCR2NY?=
 =?utf-8?B?Q2ttcThBOFRkUE4wWWxXWXZoRnhzNzF1MmZrZ3VNNjFrZlF3WTRxamtVaXpC?=
 =?utf-8?B?MHVnVXlHdnh6bTA1OTZsWlIxbFQ2NmM4TmU0SXloUGtCVUNzV2ZoQzkrNGor?=
 =?utf-8?B?ckM4aytVemlsWGlhSUtBSm5EbkcyWGdDVGlPZ2dXV3A2OC9jaWpLZnFyMTBG?=
 =?utf-8?B?K014aXVYd1lod3YrREErVktnaHRmUTRTcnNYcVZ3VGpITWxqSFdseWcycGhn?=
 =?utf-8?B?U25hTkE2R1lvNEVodUdmdmdWenNJQ1JwbFdpS0YweEdYOWdVU3Z2YWU5Nm02?=
 =?utf-8?B?TklSQXpvMk10ZkY1OGhjYXlDd20vSkNtelRQVldFTXZhcUE2dGJLMXQ2YjVI?=
 =?utf-8?B?UG5HZkgyMmVJQmJzL016SEpQbEtLL2RjK2czL0M1S2pPRjNxaU9NWG5pT3Ny?=
 =?utf-8?B?U2lTK2J3dk1DdWQ1d21TaXgwaGtxYlBMV0FXMGpOc1lZcUJ4TzZiNm94ZEt3?=
 =?utf-8?B?MmxoNWlBc1RFdEZKdTV2RmEwaDZ1VWZIOG05RWRsQjNsR3RXM1k1cVlzbXBy?=
 =?utf-8?B?STE2ZlIrZU5KR3NURW5zOGN3c2ovdDZtY3dKQUVidjhBbUFicVZvQnpyNmd6?=
 =?utf-8?B?T0loR3hRL0RrMnY1NFFkR2JFVGhwTTE1WnNXZ0hxTEVGV3BLT1h5VTM0cVdU?=
 =?utf-8?B?RDZ3VzhMOVY4YXhhTzBXaFZiUE1sQnZYZk5oeEhHaUUwT0ErR285VDlDM2I4?=
 =?utf-8?B?aTdTZCtzckxBOFRXNWw3MGg0a0lwSkhiVFhoMUI4dGtDdHpPMzlvbTh2MjI2?=
 =?utf-8?B?UkxjbVFqUWpmUFEyaWdwTWN5Y25XZWt3d0hRK1lTbkFwRU5lcVJ1Zlo2bXZN?=
 =?utf-8?B?TEF1a1k5Y3hOZEhLTTNUZnBTRnBIRElHWnJpRnBORnF1bk1IQjZPQklCK2xv?=
 =?utf-8?B?RWJTeHljQkFncWhkcjNnRndIZ2REUXUzSDkwSS9wK0NUaUdiRFRDN3dPcmJq?=
 =?utf-8?B?dGk1YVlSalZvYTJlVmZQTDJNbTl6Yk5ISFhBQmpodk9HTWJZNWc5aHVuYWt0?=
 =?utf-8?B?US8vTXplUEd6eU00SjhFelFXMFVocXIyNFhiMi9XeGljaFcwREtVRnB2V2ti?=
 =?utf-8?B?cUdsNTZTeHdBZitzdVIwaURRMUlKVzh4dXZQdDR2ZmJ2SGR3SWFvdFpuaFRl?=
 =?utf-8?B?NEQ1WXh5RUVaZ3VWRUh5bFZ1di8xQVliYzdCaVg2MzV6T25rY0FMNlhsV0da?=
 =?utf-8?B?bjhrZ1lNUkVCd1ZTWGhLb3hZVmdNRCtQamR3dURHZHQ1d2JOSFVVVEovZ3U5?=
 =?utf-8?B?cUtrWVVoWW41L0phdFhCT3plQUNBNWJRSkFGeTl1WmZGRk9iZHQ0U3J5ZnZs?=
 =?utf-8?B?aHBjYzVWYk9FSWViR0kwdkFEZVk3VVo2Wk9OWit1UWtZVG9EcWxCenppTEto?=
 =?utf-8?B?d1VaTFlGbDE1ZVN5U3JrR2pLWHpCT09MN1lkanBYWnVSOVpkZFBuQ0hrMmg2?=
 =?utf-8?B?QVhJMEpkQmFhSHhlM0ZrczdWdGdGdklOeWhDUi9VOElpWTh0eDdSV3Frd1Jx?=
 =?utf-8?B?T0FLWC9ISWpPcFFUaExYZGFBR0I3Z2xjR2tMZDl5NUlDakVNK3RHN0x2dUtL?=
 =?utf-8?B?bzZHazFqdWEvczUyc21UVDZaVnhMbXI4cndLMnJHWExmQ1luVVIwZmROMDJL?=
 =?utf-8?B?Yk84a1RuNHY1NjcwZ0lRN2xkNktqUUN5NERVdktDQW1BTTlmamRnRDhOdllq?=
 =?utf-8?B?UFFmQ0s0LytHSGh6c2dpQTBKN25uWTJORDB2cmJWOXBybXQ3cVdNdVc1b2Zy?=
 =?utf-8?B?bTZHdmJhblZmZ0VXTWV6Y1lLbDRqMFZYVEJjZlFMZGJ1WkdpcUhzMmN3TnhH?=
 =?utf-8?B?alRIeG95U0hONEs2R2hWakZhdkxvTmpPclhZQXFyODl1K2lpVkNhYWl0SFdG?=
 =?utf-8?B?alFKUysxL0F3R3VnbWlLWUxrdFVCbC9HYzNKb2tNNURCWU1yR0lvci9pd3J0?=
 =?utf-8?B?ZlpDR1ovemdzcnI4d1Bxa3AvWWRxdW4ydGkyaGJOb2liZUluN1RlY1pmSUxU?=
 =?utf-8?B?aURJVWw3NUtkMVRuTklIcXQ4WTdocitPSGxTbUZmNWhqcm96UVNsRTJkNDJl?=
 =?utf-8?B?QXhHdTQxR1dqdWVPZ2hieURsdXlJSktqcWNtYzI2am9naG1tZHc4T01sLzJk?=
 =?utf-8?Q?zC5eWnq1N+ihCAbg=3D?=
X-Exchange-RoutingPolicyChecked: wkr7b/OlLF08EXuTAWs8XWfSLIlOEpYzjJiOKmDV30f67gpCbbiv0SxkqRLwwFurBRPDxPik4CgePUX3NSaT3ZYZ25Z7m0ySESqjdX1vKK+otH30g0Yrj6Iq55C8m4HOz5meTy24Dt4RcATKdgW1e3VQ1oUj0CXssNbz+bQF++eJHPFSMGJil+53rwkyuolm25NK6jprwvUu6ckKhs3ZUOWgWV9IeaknKa0nkPEQ17NlPXMtJTOud+d3E4PXFIvL0POp4kzYu4G3azY1RqQPJtCi8iNK/T94+hyC+wdpITRcuYDA//FXx8n36dou6/Lj0htjKzacxtEbUYfnsL6ILQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe36392-1500-4256-dee4-08dea56277ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 20:12:27.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 774YRuBbdWJk3QQz7GXLSwLbJydmFd6effqRHiRnRy6xATKSFV+dC8407C6S92gqBNZ5un6zxAUbvueuBS4SIxH4eiWaV8OsnmpY3hpJOsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com

On 4/28/2026 2:03 AM, Paolo Bonzini wrote:
> 
> I would also consider using inst.h's name-to-index conversion:
> 
> .macro LOAD_GPRS src:req, regs_ofs:req, regs:vararg
> .irp reg, \regs
> #ifdef CONFIG_X86_64
>      R64_NUM reg_num \reg
> #else
>      R32_NUM reg_num \reg
> #endif
>      .if \reg_num <> REG_NUM_INVALID
>      mov (\regs_ofs + \reg_num * WORD_SIZE)(%_ASM_DI), \reg
>      .else
>      .err invalid register \reg
>      .endif
> .endr
> .endm
Yup! Also, looks like still needs the REG_TYPE macro:

.macro LOAD_REGS src:req, regs_ofs:req, regs:vararg
.irp reg, \regs
	REG_TYPE reg_type \reg
	.if reg_type == REG_TYPE_R64
	R64_NUM reg_num \reg
	.else
	R32_NUM reg_num \reg
	.endif
	.if reg_num <> REG_NUM_INVALID
	mov (\regs_ofs + reg_num * WORD_SIZE)(\src), \reg
	.else
	.err invalid register \reg
	.endif
.endr
.endm

Thanks,
Chang
