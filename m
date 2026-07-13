Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3423E7BCC;
	Mon, 13 Jul 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938005; cv=fail; b=kYsPS8yyj5eevIx/kELNDd5taRxG/bxIKLrYfbIF6L0fnSpWIMko+8VfMt3gqC0n3kSzWTauaBcSn4IjIftCrfeepJH6EXTQpDOcZQFgL5VhO5WuxdJQrCUFlda1exQbbjI6vctqTAIpSvqtb+zaGd1JMRVBfIlkignXDa6S/Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938005; c=relaxed/simple;
	bh=T+VXRfzxUi2ygVAh7feP4Jm6Kfp308I6twx11TrJF2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UBB1G37jj7mIdDVT/k3+JcqgYz2a4H/PkLQSuwJUnB0XmVcW0Zrc69LDzA+i26M2vhEEeA34CeTN6ylwFawPzl54CQOdXSsWjkU7Ze41aiXs6hHAYEppciddB0xapC08dkzjOmCdPuK4bgUMJQpe+uHnw+D2Pa7KGXiIULUldm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9tzFhcY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9tzFhcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783938003; x=1815474003;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T+VXRfzxUi2ygVAh7feP4Jm6Kfp308I6twx11TrJF2I=;
  b=f9tzFhcYPg+54hqV5LzOCJnVXyDJno5Xb5zsWu5MdTAlU5wDwzFUJ9Ss
   z3iXeWQ3IvIO9dJJ28iaPwdYvYHHsm/YDvS1oX8AAcROKr1QK9gK7gBky
   X4SQxM/uOTwdDe9mf+mFXLz3FkwFQ6w+E/giK7iRc28XG7vEvJkdiJCTK
   eEk7ucwuJk8jThP3/HA1OuJV2iCOTskBbeET8d1BBnNrmVW2ahayi50jO
   UxxUi1NzEalwEdCuUQVNpQA05R/xA4WU/cUT5LI0eWCYaXd7xDjQLpXG5
   pYNbDlCydXTaOSLJP1iCQy5TjfE2DCTpFLPDOQjWgWWzSbBoziJ7Y9k1p
   w==;
X-CSE-ConnectionGUID: l9Af6eclT4Gvwn6UWLha7Q==
X-CSE-MsgGUID: xBhk2+dFS4SWG+9vq4bwaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84321291"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84321291"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 03:20:02 -0700
X-CSE-ConnectionGUID: SOf/L9/GRGWFeVgugNbicw==
X-CSE-MsgGUID: CgE+imsBSBi05sq++XJmcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253767141"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 03:20:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:20:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 03:20:01 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 03:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/sts5qP4rOcGLT7Pgo81yusKfP+XZfrwOjbPIqyO3kAflZw96xgrWiVQqoiOYcbgEVEyWtwbJVmLXSslrQ71cOMIe8YAV4VY4HuHd3n68m9ymVfaPvxRpK+6A8GDAXzrYkKTlbFE6Vdv22DcnsoBi+JV3QASP8CXcF6w5cHCXCQlO6Bxi1AZHcyqrS41dl0bXMiNmRV9GKRucTMH00ASmymu75D9Hh6Nb17cdrHOunwUtqCRnNFYV1AspF+x7qVx9NG6WCa8ovs15qKBpcPBkYjz30BWPrFhhH+eINPdblS7geUW4GmywEboqwpDFquWnIsXf/VrAjmpqm7jAyrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qpPDQg8hsF9KLtg24jUhGXxMYQ4m7PSpnO6nAE2PVY=;
 b=IodTGMxFoN3ZQmduospidyahL+s4GqLz7WZBvRgGkvtd0gyBzwIql8dzQQHVupLma3R161czfUAZIxTY3MgYfUFduB+9Du1gR0nwtWBaOroRmWANmSC2CD660WQzbpqKluiQBV81bZh2//s/DfLA8K8kblWyxJvRxvI0Eh9Y1Zntd4BJqiEFS5I59lRAOgauoemR2HO0v8dWWNtJ2hgbwHTHGbXJ6uJSZZrpPL79j3sV0CX5RmNoa5C/N1mmWiBSISt2hz+KjmmRX4fJgTL8cgFw7AGDtIOObpvElVY/rG4uuVqDKs6Xq6txp6f0+wfDLhe5ZF9PTDoJGW4ifTHu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by DS3PR11MB9820.namprd11.prod.outlook.com (2603:10b6:8:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:19:59 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 10:19:59 +0000
Date: Mon, 13 Jul 2026 03:19:54 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 08/17] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Message-ID: <20260713101944.GA3178326@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-9-yilun.xu@linux.intel.com>
 <d13c4073-b248-40ac-aa28-1c0dfc6b9043@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d13c4073-b248-40ac-aa28-1c0dfc6b9043@suse.com>
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|DS3PR11MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: f16a78fd-8c11-44a8-d91b-08dee0c84b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: jll+HG6qnKwz268BY8k7oLcEjq4HsGm4qLbLSAwSXVomkqzb7ROk9DD6+BfCiNpEerAnOelujXedgSBHWDSApBzKk11cLqxBlpj15QlwJsyLLvT7Ug43r7bXX1pav+liX/OdjW4zGcKfncthhPEIQrNK4nAGv4avrsedRQV8TK1M0C0qNSnig6GlIgEMN8rrGpc6Stz3OSoaeD+S8oISKOv/31YQ/xUgY4M56az0BwZbTedKJpjhQpPxFKJbJ8VmgjKX2Ws5TCIJ+LPb9+5ChRelylR6a9Nr40qMTLkSxOJljPzL13SpX/Vkobtd512XYCmC31SDWq6XKB4lqv/clkPlISeeMUj/EE0hYUdqcpF+d2cKQjwtxtiFsZx7qdewbFe6c1hY/f0DUPg6ioFwG1IppNSY6+zq3l6X6w5TQUpgblHWFCznjaqY6aB1Y7j2ZZ+LB0btWCIFxEs235ubNjSI8SatijA1NXUVQbJqDZDQazFoJYOfpO9uzT+gZfaKVu1CrSjfgl/walE7GJWj3uReZzRrbnHI2hp3Lp0A/KiPoh1iEYbDzJHxwGefrkzoQBeoXkYjDnhMBVd/ZD6rSXnGrSQIGno5eUJkFUDnKLKNrLds7tjK0ZhzXZa0EZQiIGqZN2bLeLYNXrmclkz4OEuqMizK85e0D9R2nEooAa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlTZzV5dGJrTW5rVm9jZDRaaU93R0ZVMUpvY1IzajRZdENuN3pQTUlSbWlM?=
 =?utf-8?B?dFVUaTJsdDFBRjQ0TGNYYVZWbmdVSnBmL2tNYWxOcEVmUVQ4WnFEQjhUNjB1?=
 =?utf-8?B?eGtjSUJHV09PNSt5RDhSV3dxQXhIODZxLy8yVkNQRkdDTmxDY1ZKUFIwYkoy?=
 =?utf-8?B?N1I1NzVjTzZhTUp1ZWFKVnpveXlFWUczTzE3SHBkS0EwOHZmcVVQZ2EzWXpB?=
 =?utf-8?B?SEtKMmJDMDYzOFFuYm9RVlF3YWNXUCszNDFFRG94aE9vRjF2QjZONzhIOHpy?=
 =?utf-8?B?SFh6NCtuc1d1Q1dQWnYrWFloZEpLSGswZkNKYjlVN2oxUXlEd2YvM2FEU1VN?=
 =?utf-8?B?Z0JzUVFCNVAzQm5SdGFhSmxod0ZBakF2RjNMK05BU3djb21NbkNTeUJ6MnpH?=
 =?utf-8?B?bkU0NWVIbWlzY2w3eEpFb0pFN2RrZE9nL2N5S1dzTHdzakVMVnFWK1pYT1JH?=
 =?utf-8?B?ZU4xT045SFdvUU85bnplT29ncXU0QXdHRldYTnFXMlRFVGlEY0x5OHY5VEVF?=
 =?utf-8?B?OFdMNSt4MTFYVkVJUk1VTVU0ZlRaMnF5RTNpQ3RNMzR1UVppUG5rOVpFeGlO?=
 =?utf-8?B?bHI1WGdQWFgrd2tOWENBcjRTclRiZlRUOXMrMjlQQkY2QnY2SVRmUHNuUHZX?=
 =?utf-8?B?M01lcjQ2K0VYUkx0ejNEQWQ5b0dqSUFPTGV3RExaK2liVER1cEtianVzdGpC?=
 =?utf-8?B?Y1dUaUVBeHBDeTk4TTZNd3lWOG90SHUxcC9CMjl1YmFGWkpScXVhMkh5Ukl2?=
 =?utf-8?B?REV1dFc2MmpWYzRoV1lnQ3hjZ2lkam9ub3d2ZVc4eUdROUZ0QTR5bVRqNTFB?=
 =?utf-8?B?WTdZMkowQTJBMTZURUhmMDU0SE1BUU9CYjJsU0xYbnRhblFVRm9JQ2phWGt3?=
 =?utf-8?B?Zzg5SjhQQ2ZUaEJwNGJEbXFCcGlkZFZzM2tBZlhPYzZYWkp4ZGovMUIwVGxW?=
 =?utf-8?B?WmpVc213Q05DNU5yUjdTQTI2R1Z0b0R5OGpaRHBkUFRmYkJMY3UxVWNOeGo1?=
 =?utf-8?B?WE9tQ0pjWmZaclgxSG1va2ZDV0VMOVNHUVVZM1diK2dQSjkvbyt3UG1vNlZq?=
 =?utf-8?B?Ym9yS0craWJkRmRUb21hdUZJeUxRYUpoTjVaZWJZd1Y4Mmswb3FkR2Z1Wlkw?=
 =?utf-8?B?Q0FsdCtPUVpTU3BLcEZXRmdsdHhLNlJjL2o0aUtWU1VBbDBtNytWcng1V2I0?=
 =?utf-8?B?RnBOZGRVckpNWlNodWIrcHlkclFiZEE1ai9jTEQzSGZ2a2FlUTZlZGtlWlVk?=
 =?utf-8?B?WXdQakdlZlV0bGZiVVlHbW0zbXZnTG1WOWdvU1M4Nzcxbk15MWVsUGJpRHFr?=
 =?utf-8?B?ZUtRV0ZVWGdNRGd2emlXQmNpQWlqREMyYk93cnluTE9scWhVcW9Vb0VOOXVW?=
 =?utf-8?B?bVllcGp3K00zY0w1Qktab1d5SFJJY0xZcVk4Z1IrblpUTlRxMGp5OUFNWkt1?=
 =?utf-8?B?M09LSlpZa2UyS0kzNTdlM0RuV3ZJdVI5Y1JIdHFHM09ZUzA4SGwxMGU1emh6?=
 =?utf-8?B?djZaK0FmZ04xSWk1S1JPNTNhQ2s0S2RYWXJjcWU0MFFKd0tiUUVoTmhPaGFZ?=
 =?utf-8?B?U1JTTEw4UlRJSURtSHFLQzQ4ckZleG0yR1BSMlN1SGdlbHZ1RGZzdkdpQm9Y?=
 =?utf-8?B?WE1GU3dVQlVEUHFPcEdBNTM2M1d2dlhsQmJrOU80K250TmcvcGVHZm1JejRE?=
 =?utf-8?B?Z3Q0SU1BNjNPUTgvT3c1eTVKcFdhNHZUdVd1bXFBbk05K01xaDVFcndyVkFC?=
 =?utf-8?B?ckdRcVhkVW9YbTJVQ2JVdVFmVkhGLzB5NFJLekZSTHdKYURtNjF5U0V0S1VN?=
 =?utf-8?B?UStWeEJWWW5UTFZjODMxaU1XOTNqaklpT0pzT2FwWVpTMmJQYXYveTluRk1o?=
 =?utf-8?B?eFExTnAySFNjSnlabHhyZm9kQWRSWFBmczVvSUd4L1oyaGNjYmNoR1lDbnow?=
 =?utf-8?B?TmdXanZzK0ZmNkt6cG5pOEl1bmJKbEhOSy9LUnNCS29FOGFkUjdVUk1GQ0Zv?=
 =?utf-8?B?OGtDcUticU5oVXVtZVY1YjVGb1lhaGNOdGRJTnk0RmlNT0grRjlCaXhzUmVn?=
 =?utf-8?B?a2hPYjhwYkVkV25LWkdPdUszWWNBWjJKZks5SWFyNDR2UmN5OXkwaE0zUmJx?=
 =?utf-8?B?ZXlFWWo2ZVhoOW5aam9GZnlQTlhxZmZFaEVzNDZtcStEang2aG5SSC9lWkVm?=
 =?utf-8?B?WHhvaTFsQm9hd3U0THdtMHNRSjhkMExxWnUxc1Q0dFFpRnNETmxmMjVXQXh1?=
 =?utf-8?B?eWpKdmFZeXRpdHRReEJkejM2Q29kUEUvYzQxRWEwUmRUU3lwWmN1Rms3bXFy?=
 =?utf-8?B?QjhPNzJmdlZ0OWJMRHVEWE5HVXFXTDNJcHdVYm5HYnl0Q3dOcDI0QT09?=
X-Exchange-RoutingPolicyChecked: plAZvw2x/SHcUQXXju2QlzEiAO0R7YhUXAS7RYMNnENsfndDdqZcn0UicCKGZXH9KvdZOFQm8cKxkbHxpjZCxcjaiPwq7YPiKyBtDviOkyMPjLLKFCdGolDo4pV11d5eKM5zN4wcOJoIBkUPiaSKUbeeZKALVpEXAMHOueuHmHuZ7eJ8NKsyc4prV5SaD/1NVkLuOZRwbi6CRqbvHjJa/vGA+iG6V29pDlc2nZki+iREjYc2+e6DpmGzVBSQha48lvE0iXSaMNmbIgdE7POlSeATmda0B65Q05/ppukrylah+8lPXcoo/+MooyN+i2qYYOFrESeHI5GtTIHXONaseg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a78fd-8c11-44a8-d91b-08dee0c84b39
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:19:59.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEIfHjwVQ/2aeqdKRui1BvzsSvPNiXSn3P5IVGWWzYxQHrDObjXRXCTzE8nInNe+UsR3RWcm2Bjb26EK61JoBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9820
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 10:52:07AM +0300, Nikolay Borisov wrote:
> 
> 
> On 6/18/26 11:13, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > During TDX attestation, the TDX guest asks the host to generate a
> > signed, verifiable structure (a "Quote"). With the Quoting extension,
> > the TDX module returns the Quote in pages that the host shares via an
> > Extension-SEAMCALL.
> 
> nit: Just say the host provides the pages to the TDX module, no need to
> specify if it's via an ext seamcall or some otherway. One can infer this
> from the code itself.

Good point. Thanks for the simplification.

> 
> > 
> > The SEAMCALL accepts the host buffer pages as a linked list of 4KB
> > "HPA_LINKED_LIST" nodes. Each entry holds the physical address of a 4KB
> > data page, except for the last entry, which points to the next node. The
> > TDX module reports the required Quote buffer size through a global
> > metadata field. See [1] for details.
> 
> That HPA_LINKED_LIST is basically a linked list of arrays, each node into
> the linked list being the array, and each entry of that array being the HPA
> witht he last being a pointer to the next HPA_LINKED_LIST, so in a way a 2
> level data structure. Can you be more explicit and just say something along
> the lines of :
> 
> "SEAMCALL accepts host buffer pages arranged in a custom data structure,
> consisting of nodes containing HPAs, arranged linearly, and each node is
> linked to the next one via the last entry"

Oh this is much easier to read. Thanks for the suggestion! I can
incorporate this.

> 
> > +
> > +#define HPAS_PER_NODE			(PAGE_SIZE / sizeof(u64))
> > +
> > +/*
> > + * Pass the quote buffer to the TDX module as an HPA linked list, where each
> > + * node holds 4KB page HPAs and the last entry points to the next node.
> > + */
> > +static __init int tdx_quote_create_buf(unsigned int npages,
> > +				       struct tdx_quote_data *qdata)
> > +{
> > +	unsigned int nnodes;
> > +	u64 *hpas;
> > +	void *qbuf;
> > +	int i, j;
> > +
> > +	if (!npages)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Each node holds up to (HPAS_PER_NODE - 1) 4KB page HPAs.
> > +	 * The last entry of the node points to the next node.
> > +	 */
> > +	nnodes = DIV_ROUND_UP(npages, HPAS_PER_NODE - 1);
> nit: It's somewhat arbitrary but num_nodes seems more explicit, saving 3
> chars is not worth it.

Sure, I can make this change.

> > +
> > +	hpas = vmalloc_array(nnodes, PAGE_SIZE);
> 
> hpas is basically the starting node, so name it "nodes". Also I'm slightly
> confused why you use vmalloc to allocate a contiguous address space when the
> nodes are linked in a list? I.e you keep referring to list in the changelog
> and the code seems to be working in an array chunks?

Hmm. I used the vmalloc family because I wanted to keep using hpas[i]
without switching to the next node's va. It felt a bit simpler to just
keep doing "i++". Maybe that actually hurts readability? I can replace
that part of the for loop with something like:

        if (i == HPAS_PER_NODE - 1) {
                next_node = kmalloc(PAGE_SIZE, GFP_KERNEL);
                hpas[i] = virt_to_phys(next_node);
                hpas = next_node;
                i = 0;
        }

And "hpas[i]" feels a bit closer to what the code does than "nodes[i]"?
It's filling this page with a bunch of HPAs.

> 
> > +	if (!hpas)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * ~0ULL is the list terminator for HPA_LINKED_LIST.
> > +	 *
> > +	 * Pre-fill the last node with 0xff bytes so that unused entries are
> > +	 * terminators. Overwrite populated entries later.
> > +	 */
> > +	memset((u8 *)hpas + (nnodes - 1) * PAGE_SIZE, 0xff, PAGE_SIZE);
> > +
> > +	qbuf = vcalloc(npages, PAGE_SIZE);
> > +	if (!qbuf)
> > +		goto out_nomem;
> 
> 'qbuf' is rather arbitrary here. You simply pre-allocate a bunch of pages
> which you then initialize into the nodes. Can't this allocation be moved
> inside the loop itself, of course it will increase the number of allocs
> happening but this is during initialization so it's not performance
> critical, yes?

I see your point. It’s a bit subtle here. In patch 11, there is a
kvmemdup() that depends on this qbuf being virtually contiguous. Based
on feedback from other folks, I think I might change this and use
runtime quote buffers allocated with kmalloc(). That would also avoid
the TLB flushing penalty of vfree(). The free path would be a bit more
complicated, but that should be okay.

> 
> > +
> > +	/* Populate the linked list */
> > +	for (i = 0, j = 0; j < npages; i++) {
> 
> nit: This feedback was given before, but both variables can be defined in
> this loop.

Great suggestion. I can do that. Thanks.

> 
> 
