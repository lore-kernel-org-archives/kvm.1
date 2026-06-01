Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB3390C9F;
	Mon,  1 Jun 2026 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345092; cv=fail; b=KCs8JBTKbk3UczfXwSYj1F/yjyZxacLo7pQgT1fyF+WbI1Jtf6EWBHhv5UeLVn4pPjIBUb4d2oUSblgGFpG6GpkOgag3OqmBrRr8amkVF68N7lMkJ8Kt+81pzT9XEDV1kM7Hwum/1uAFDqs2L6YXRtdaGcPAEsqwivGPDOGlBYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345092; c=relaxed/simple;
	bh=AKADB+AtnGs/06a3Ah+BuXhT2A4CVZKwRYF5SuUuE6o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOy66w2aMzISK3Ae/Q7DyxuURDs+5FMp2Evni4i8a9s8XBFhjakueMYOuoW9siXjYLWVtKkJUa7I82U8G7AlU+Ush327zeNUhpc0Q5YEbWOY0wm6j/C3OnXZH3DUoFineZPBePYSVNlwJ5yN1vCREZ2ntCtILAY18k5qzNtFE50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn5cJ1JL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn5cJ1JL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780345090; x=1811881090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKADB+AtnGs/06a3Ah+BuXhT2A4CVZKwRYF5SuUuE6o=;
  b=Xn5cJ1JLWC4AE4YAf6ZX45+yTntvt1XaOX6v39fofYhK6funzoAA8B8e
   XRL1F5wimRiUnK9/SkC2wQnFuOeBo4gKUHCVnoqc6sFBTLNEpsFY+PCCa
   mKEFfe4WRIrPaHFQOhZF2vIJUCwB7sYw067NDpRocSmw4U0XbCP9LdWr4
   b+eAR8A0aw6FO0bpNvMRyTQXWKsCUJErDoseMoTD5N90IxHi0ImqpVfRY
   olnQp1p2sFPiwB44tQedRERdtj1wbHoJrH3x3J1NUFADIGqj8B1o9fKJL
   eLlgC03cNTw/jDI7OXU3Kq/plmT1WpAEYbXLnRYjpP3bjD3WmlENjZg9y
   w==;
X-CSE-ConnectionGUID: g65JlxdnSi24yc/5lrffKw==
X-CSE-MsgGUID: 0pk1V4gZR3+dqou4YUV//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92226010"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="92226010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 13:18:09 -0700
X-CSE-ConnectionGUID: gd8njM/6Rcm+aiyD7DyFCQ==
X-CSE-MsgGUID: nhfVPeWbSUyD+EvFVoij5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239261968"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 13:18:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 13:18:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 13:18:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 13:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfNHSGLd6Eg4t4f/JFcRAnY/NNStIfNn4fLy7ENOQqLkGmcGu7+68U7F4KTc4kn2UlC1Eg/w+3maKeT25VUWiqivVdybetdXAtfz0l9HVJel+lMmlqBRf4UUEAOcAjUArlu5k+dJ2KZgJqFyZTocevpR5NzsBoy5jkIOHQ+GWt3KJ8jh6t/4rVMsdNhM1bKuqDM+Fq/232PhXanEhKcyixZLeR/OZOYxUloOQMQ85ZDCmOE0mtcNtq1hXTDEgkG+5nnwMBwL42Fdjiucg1ytkPeBxozd0yWH76ZTSKeDx3zyOZ+xmOjyVmRmKvjtZJG7ZBSdhn0xgM9n4UXhmvV7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5xKk5/17gqdor5HRfARICyDOsImm/nYQqyJk1xgUYM=;
 b=CH5ba245AzvPE8Gq/CRLxgry9KPhtbB0N9hAlptf/Zu8PW8YQZTF06JjtHQysC4KjXU9LRvf3uyThhWRg6K65drrmnNwmoK9TzYe8ksXEFIYaVtn3ScMBTyNlHSMvyOkSu3XcanzIpv5qqiI5kmtHVo1nzn+32k9vAOKdvc9NhyC8989t6HY9xLDMyNHUOLpydyLgjL7mNvoVyB5Qw2+86HipyUTab6ncMgaBH1E2gX8tgRDYooaR9m2nVC8usQJ/lxaqbYuWtSmDHv7OZNz8TBkInx5EsgpEm6frcfG4XDigmfF7E8LJTOUcA+m51q1HIw37jwy6ryYBMSMaUUdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by LVXPR11MB9777.namprd11.prod.outlook.com (2603:10b6:408:387::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:18:06 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 20:18:06 +0000
Message-ID: <9e6107a9-71b1-4764-96f7-2d8e68060173@intel.com>
Date: Mon, 1 Jun 2026 13:17:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <kas@kernel.org>, <djbw@kernel.org>, <rick.p.edgecombe@intel.com>,
	<x86@kernel.org>, <peter.fang@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
 <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
 <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
 <7fdc27cc-22a8-4442-9c9b-4bace9ee0d23@intel.com>
 <ah1SnuEHuFeX873m@yilunxu-OptiPlex-7050>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ah1SnuEHuFeX873m@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|LVXPR11MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 366678c4-ed7d-42e5-4bdb-08dec01ae3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: cvZogHPJjZ0OWbhPGFpVNaLqYfhdyPlCWhdzy5+64vmgncOcle/hwBUxyFjlgT3wi1rVB3hdiN8VLpgVzLE7IzvJTyUqz10U0tBeG5GQ4+Z+Ihs6bedP2yYmDfstcnEToDlK4E14ictbO8Xbgx9obMZrhNZhVAih2tH9uxQdusUPsTcY4r3vrrPJf3FIDX/lbBFU4AJoyAIt3zCoPEbAqMfPvujj+bt0jM+ACmvGuNwnLiOZlgar+osd90GTBsuOwI1A4fmtjN7lKRv9V7B0CClGCczTSv0C+J8338B8M96Gpx8YtN+1g/17J4WYlFeKySkM3FEWC/FA4wW1PT4n9nazwTJOYcAKeXCBkdnyDhUPBlZcKGWEJXpfwikoMRzOj2opZgxdCRbW0uT7P8v1ENG11s7/pLXAAOCDxjjS98iwIpouQPn1ynWsHqRm+dE2TcHT9PSATzE1L278b5SpXerf7u9lI6MVjPAFoAIduIapm3+AxbKeirNuYhzs3V+O0aJk4MFk4TXQfPz43rE6ikbRRJGD7SqvyMKP0HAKQHRmurF0dCGfKrflWb+lWnHhckROyJdgpgjrFVzAHQUtU/xz0PwYk7zgg+/pNRzHYTPKWlc54NJgnE+U2YIWCSxm9T42Hf7CBfvxPVg/dSv+a/VavppPt5ZnVHhw8Ko/3xs2kQnnj1wqYXCWBeHZ8QA/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJIekZXcENJSVVrdy9EZStCWDNDeHdXVTAwQ3NGWVllWFhPSVBWOFR6eXNk?=
 =?utf-8?B?am5pajBzL0ZGOFZ3YzN5RGNCdWVLNnJPQVFyc0w1bHQ2N0UwWDNzSWFxNnBB?=
 =?utf-8?B?WUZEYjVkVzkvVWpadENpK0FiRUNvU0hMQjVVWEUwVjdPMlBEeVFaNVpNeWgz?=
 =?utf-8?B?cjE0RVdxR001elhhQnNyakpLdVhTRHRpNXZXa1VWZ3FGaFZtZEllaytqbE96?=
 =?utf-8?B?QmhKdTJWOXludkxFS0lPdkhZdTd0S2poWUdhdTQxNDY2eWxGMnMyMlZGOWQv?=
 =?utf-8?B?OW11a0FzQW5tZHhZU3BldVBjQ29xdzNUWU5CY01IQjQ2YTE5SWsrdTB1OXgx?=
 =?utf-8?B?cHFVSFYrclFtVFZYenB2QWYrWTI2S3JzMXc1WDlrUlhvTklwUFNMTVJEMW9a?=
 =?utf-8?B?ekJtVnNmSjBzdVlCY3RwRVdYczhXajErdHpkOG9kNWJXd3lCQmFNU2lWNzNk?=
 =?utf-8?B?MnRmRm01aXBBWFc2WTB5UWNJMVFMRWJ6b3NHYWlnRE5Wb1dPMUdaQ0x4Zmk5?=
 =?utf-8?B?dzhJWXhJcG1ldFVkZDhncEd4amEvQzUvSWRtY0d1MmRMbGdhMzl5Ny84cHZr?=
 =?utf-8?B?M0VST1RuMVJVb2RWS1hQak04NGE1ZStBbzZTY1RmSWZpbzRwSnh0dkZPS0NQ?=
 =?utf-8?B?T0hsMDhRWXJ5S2JuNlBuTFVJa2cxZG10ZmQ5VzdkKzllN2oyRitDODlMZ2FS?=
 =?utf-8?B?V3pPbEgxcVI5a1NyR0ZEWVNqZUNTY3MxZjV2TmxMbXFJY1RJakljeXowRDh1?=
 =?utf-8?B?RUZ5UEpqNDNsb2s0RkgybTVYVHhUaElyZW1yNVJhM0dwekxOWjRUczhxcDEx?=
 =?utf-8?B?T05xMVpwUFR0M1c0ODBkZFJxREpsdnlDSXlCQm1BcDFMemx0WFRHUXo1WTZS?=
 =?utf-8?B?WFZ0enNseWxneHZDeHo2N3FNOUZ6M3dpaGlGb24vQVVyWmlVVU9IN002VThz?=
 =?utf-8?B?MXFGa1h3T0t2QjdDRVU3TGhTRDBUUE40bnJjNzFKN05IbDdIdXlLSDU5cXI2?=
 =?utf-8?B?VGpEc0pUemtrT3p6YlpIZk1iM2V0eVc4SFM5cStQVk1HK2hiZGxHNkE1b25V?=
 =?utf-8?B?R2NGNGp2OHFZd2NKZEdWMlJxWXpEOFRkbUQ1c2tubUEya0hKU1Z4UmJ6NkM2?=
 =?utf-8?B?M2F2RUdmK3ZOdWRjR1lPclJGaUROMVo5RXdsaVJ5a1lOZVArMmdZN0FIdWpk?=
 =?utf-8?B?eDk0UDR4NnRUUUJzdVVjSHBpK2lnUTZyOWx0TkNleWw2eERsTDZPTUx6TXB2?=
 =?utf-8?B?RFlsNGVQcFhBQ29jK01mNHp6NHA4NFRuNzdrOHB1U1dicGI2TDliZExwM3cx?=
 =?utf-8?B?Zm5ma3g5NWttdlJHV2pqYlJZVDFmZXFtN0dxTFhLamJxOTJDM3BrQ1VmTjRQ?=
 =?utf-8?B?a0VZT2k0cFdnbXMrN1Vhd054WmpsRTBTTlV1aGwzYjdRem5TYlpKNWlKcTFN?=
 =?utf-8?B?bnFFVUdzbnJBd2VIUTh2UXQ0VGp3RHdiVG5xZ0F1QlN0RDBNUkhCMFdBcS9s?=
 =?utf-8?B?SmZFZHpNMFZDWllBRmt3OVh0OWNSKy9RdW8rb0EraE04M2hPU0l5YVFxRmJF?=
 =?utf-8?B?aUR6TzhYcWIyWlpWMmlkV0ZjR0FSajdXdzJhcU9PaU9tRE8xTnMwL05NbTlP?=
 =?utf-8?B?UUxSZEtuMjFWYy83Q21vVjlmRFFuZ2k0aEtLdHNCVnVncjBOajBkSFRCeTFj?=
 =?utf-8?B?MFU4YUs5ZFQzbXp6dUFFTm80dnhzekpWNXhmanFCazhRVXY3aVJWS2RMdDJD?=
 =?utf-8?B?S2NFTWhhcjJvVnNDTTYyV1B0S01oQVpoYWMzcEFnLzVjYW9sUmpmTkZqL1cx?=
 =?utf-8?B?b01CWTZJVkRPemlNS2xTNStuRjBqVW1Jdk1QZU5HYmhPRVc0VC9DaGhqemIw?=
 =?utf-8?B?K1BIQ2hSOXNVc0pRbjRXZ1JnbExabWZ3V21pNDdkMHo5ejN5Z1ExME4vcWd2?=
 =?utf-8?B?SUFHSXUrell0b2VJVDc5OG93c0lwMFZHZkdhV0VKM0VaR2JaVmwzSVJvbWk2?=
 =?utf-8?B?RTFjZG9PWmE1dlVXZU00QnFLR0hXUVFvZFpZQ3JtUmRud2REUVRpZ0lnMHhM?=
 =?utf-8?B?MzlZYXM2dDVoaWNHVmlxeG5uUHhjK1ZuZEQrSnE3SC83MXFtNnYya1I1cGo5?=
 =?utf-8?B?amxUb1pFdWIwWjhvZzQ2YUVhd01hSUF3a1lnRHBscWhoSW1LTFNrYUZUdXlZ?=
 =?utf-8?B?bkM1Y3R3M3FNQXhiTHlpeDBEYVRDVHBCRGxhc1hobWNMeHc4bHVBaWsrMEZC?=
 =?utf-8?B?Qk1Na3c0TFRxazFvRk5YdERmYkdVclpXVldRUllvd2s4V0g3ZWRxR2pkTkhS?=
 =?utf-8?B?emdZbWJTbWNTTlRFNWVPNTZhbXdrRENyVE1rTnNSeEtSYm9TZW9FUT09?=
X-Exchange-RoutingPolicyChecked: NMxRRgH2B4HlhbkP1mTnVfoVKhO+MpZqNOQsIxLFddWV55kYlkjnRfyQZclzeJWvaUHLTXAkm34MbXPq7d35BoButbOy7Rz0/DTZ+1Z8E+3qyH0PV5lMTtqPnnn5pwLbbeA6Uml1YgkQu4doqO7a58q2oCN8kGGJumtKrCtXPaFWBqQwwFpZMevk1moxXDBDHtGO53gXFXhZeJMhQbr/SyVDco23D6NeLYclEY/OZ1VcMNehZ3YIzhaSCQkOdJcTlmm8+aZHhus4T1x2p1eD23dYPNjzmdfBrGl3RLjgIp35vsSR2kkFA+yfeGUuftYhIifo6IEsDNbi6TCRC6CJMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 366678c4-ed7d-42e5-4bdb-08dec01ae3eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:18:06.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAPEwVloicVNb9ALqkj0XqWScovx02GGUksU7wkBS2rTF/w+M3Tbwptsvqqu/bWoK3NBe0S0WkbnQJXmZWNp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9777
X-OriginatorOrg: intel.com


>>
>> Let's say a future platform has a lot more features and needs
>> significantly more memory. Wouldn't loading a legacy kernel with this
>> default policy lead to excessive wastage?
> 
> A legacy kernel won't consume Extensions memory. The Extensions memory
> is only required by TDX module when add-ons features are explicitly
> configured via TDH.SYS.CONFIG [1]. 

So, the TDX module will only report memory_pool_required_pages for
add-on features that have been configured by the kernel? This would be
good to clarify in the cover letter.

> For legacy kernel, no add-on features configured so no memory
> consumption.
> 

I was referring to the first kernel that has support for one TDX
extension. I am mainly trying to ensure that a kernel with support for
one TDX extension only consumes memory for that feature (even when it is
loaded on a hardware platform that supports multiple TDX extensions).

> But yes, if the features grow rapidly out of expectation, may need new
> options to switch something off. I think if we discuss later when the
> need actually arises.
> 

