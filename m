Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73948F015
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886371; cv=fail; b=sY7Wsedb4eW6yOJYHlG45LHipaZsEhmwiMNYwcLrLI+z6jgwBglUcluEEZvJJf9oz8JfoCPlqiDsmtWfhJOpzAvNevpT+Fq3c69ug5MGj9aA6NRPEg3e/2YeqTYAqNkTEZ9sLyKJKyGhP+wdf7w/4EX5HHcaHvuSX23HIvevgMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886371; c=relaxed/simple;
	bh=/Z+JmwmxG/yqEXdXPl8DVNIGDuUzi0l+Bjkifyq+0/A=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LRU6c2Fl0L8vGBakowQV2UJrmwJcMlXWm+FD7+1RsrxwqAiG5hTYKLd6cJSv6sMonpSkNdaMzAarjC2wyiiqrZ07vNaJMC6d64BQHiXeN49ptCmhTUlC3S9R53St4U9YIVJqiyFPLiymQAumFcIK9rdxLtX8e6e+ZMI/Aq76NHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG5xUnwr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG5xUnwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886370; x=1822422370;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Z+JmwmxG/yqEXdXPl8DVNIGDuUzi0l+Bjkifyq+0/A=;
  b=eG5xUnwrBdvUT9FCci/JeRuHY1FuDVH6z/Iuf26BZYzub11oWP5t4QpP
   r4ZgvpJof+Q+M5kVxOKXmvR971zyQwISwO7mZ3eCJFyLI0vQM8kM1TelD
   0koculM3cDN8bgeS1lSNuCBkhihLbt/tzebOmRyjwzVQGQPYjcG+UAjJU
   CYtIiY8of8msyqs8VwTv9VOqh47GQlO3ue/Lt9qKwAzYPS/URXmYmGoFK
   UG14vD7gyq0NHgIRU3JLN4lAHcdIaXG3BIvtyMYg055a7/mDaBdX8b3eM
   UqiqQcIOlIGGibsJ7+Hb/O6LQWJx5s6AS6UKSJO8nDKra5TEsPSGsFdgn
   g==;
X-CSE-ConnectionGUID: QH4uSCX5SoW2T+HB1PXH8Q==
X-CSE-MsgGUID: +AW1IeXxRry3HaasXz4kYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95467222"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95467222"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:26:01 -0700
X-CSE-ConnectionGUID: Tn3nHLjoRQ2XkyMpsaz9lA==
X-CSE-MsgGUID: yXWpcdARQ4yMDRTIaypJoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275637145"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:25:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:25:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:25:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKqoynZG/WIxV3wbWRn4XJFgQYsy73jQiX10jFTREbCIbO/PwkTBfdlfQoBWCbelcdcGXKffbKTPb/qEXHP9zkb+fYD2fYviW+vSx3vS+hRdQul97OBdQsbcxQKgNvBsUm/eq2X8EWJyVBats8XibsP7HyZI/ebojaNXsEcbySdchtlUSSUs04dtKSNNq/qzuZ861s83OXc4h8PH/cf1ge19un0Yv04biMUiXCrXhM9txBR+sTHeBZ78H9MFMhktCdmsLivtzI2Ts7CWy1wvSBEMfIZp5fUB+kXn9+wA4wT1GoxpkHS+bYjX6Vy5DmaVpFlb6TUqUD3EmEt+XLBJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SRwiHZ5HoEXUNGq/Q6I7xpfKz6ZmWQTQbtoBVhL5Kc=;
 b=lc8C/MMI49oYxStkWSUD8cOWfFn6kqCNeqN2jpgIw9J97pgbNh3Yib6v8yFbNs3SjHeC7muzDMVQrHyFNZyE5jSPEkSVWlb0oOOwZXXK5VdzPb/cGcfOp+HJAhCJbbmbHgy3EXS7OkfkCAyROhu1YaQiMDC+DRQY2QrZlw0NxHKqjfVZCU3WEaeI6/SL4LVKjIdU8UGeaCIolYZlHCbjOlee39hWDgfaxL8XmmAkTJ5yqBC01KqIjV9DH09+UVxAuMGYEUn+RDtBg+lfXJcZfq78Mgy5seZJW0mPHOS1KjGqzZQok2l1QNlqNHMsOF7F5ZzHrYZkOkJ0OvB3/MKhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 1 Oct 2026 20:25:20 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:25:19 +0000
Message-ID: <b42acede-fdbd-490a-a0fd-797bd1b3185b@intel.com>
Date: Thu, 1 Oct 2026 19:58:25 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 08/20] KVM: VMX: Support instruction information
 extension
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-9-chang.seok.bae@intel.com>
 <20260930215234.10E721F000FF@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930215234.10E721F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 594bdd76-2703-4329-9217-08df1ffa1cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|3023799007|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Z+nFI7sNUHcwZEXVRX5zQj14R+kYDTcxTd6cpwas4Ll1meCYp7gUMKsQnP9Q00HtMxXvZb4Y5YWKQFsNIpyEzXwcArL8tAYbSjXYC6sB1ljMcbR7H8Dqr6FvUzEMQXcgRWQGjewgCT3Hg9UOy9yo7+f4i8IIihZGzEeZ0WwZefkwtjc+mmnjO2HV/5fZ03uCdDfkTGXTysaWK8ws/03sWK+H8ecOnLg9qsd2694oKBVttzKATLls3Kxh+yR6GddePHSXWc3VvDESBznX9ehQgdnLdk6Ns2hbaf5B+KoYLsb7KcjjBqVu2SDj9Y6B+841LZRTzqieAf1lHawfiOSoWtD7lPk4mr92yi744SIb5AnChedhrEscheUc8z+CnoHUszHaN4vUmrp/Z8DN4B7tu3dtD6rSyTzCaRkz6rY1SrMJdU/T+bEfKF5MKvR3w8wIOy0r5wM9s3vsadk2wpAo6pRNfnaKNiDzjHqA3T3AA2XOhizh7BCCt3sN/w+GDkt6CeR51qWZj5ILJKh6OgOf63ZTe3KnPyP8ehYnfpYui4J3lTOP0XRNI/ATHW0nWeHL8lMQI3rPfngBnmjooKfxfbij7W0i1MmHx0IGlVWXf0yAJTJpnHsu/hZNy4FfPbjHwoZaBL/VqWk/LUwJN6D0nnCFT4kLWCl5dPYSWiYe+cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVKQnEvV2VYMFVrOHRsN3dhMkNHTEhZaDlzNzBxcUdSTEdGNS80QjAxQ1dk?=
 =?utf-8?B?bUtTaVZHTWxpL3V4UHZNd0wxakdPQ3hPNURXN1JXZnNrcWdQOHJwL0tvMzM3?=
 =?utf-8?B?MUJwd1I0SEZvWVJNa21kK1hkRnE1UnpmVHo3cmFnRktSamJuaTQxTzR0NEcw?=
 =?utf-8?B?NDJDLzE4am9QQUJsSU9KSFQyR1k2Z0g4SlhIZVFFSWI3cTZkaUh3Ykp5UWFH?=
 =?utf-8?B?TnpZRGRuZDlpNTM0eXlpbXBHVlhLWjF2SzhZczc4TG5aSGxaTXlWdWRWVEtz?=
 =?utf-8?B?NFRvNkVrdXlBSHNFQkcrRXBzMThLWklEQmdNbUVyektmQnlMZGQwZWpJeWVO?=
 =?utf-8?B?eFY3WFRsZlU2SEVjSjhHNlNhWDVsNkJGZklxQnNRWXBNcW94eEN3V1FLWUla?=
 =?utf-8?B?clVPOUNHZWFkY3VqUXhiQzdrWGFUNTNBa3Y5dS9XWWJVWmNuc2ZYeTE5MHlD?=
 =?utf-8?B?c2lVWEJiVDA3RDNsMVY0SGR1RkFWSFpvcjhZSVNHUXBnU2YxZWlzWUlReGRi?=
 =?utf-8?B?dW9VWDBtb3NEdnVmcEIxdHlvUWZJSC9hV3Z3VEVXZWhIOEhFaHFuUTYwb201?=
 =?utf-8?B?OVJ5YkZwQ2swK1p5ZktPWThaTWxGZ3pESytJTHRpVkRidGQxc0JoVkxXOHBO?=
 =?utf-8?B?UDZHWWpBOW9la2VVa1hlVHllOUR4eE5QK0w2SGgycUxlNGZPeHpVRnJvMUg2?=
 =?utf-8?B?UzJaNlB5b2FJVUtWM2VZWFRxUEVCS0Y5TDFpZ1ZTZGZ2KysrY0l5bVRIVmx5?=
 =?utf-8?B?bVZ6elZKWnBNSjc0L2owTnFaREp1SEFVSG9VYUYxWW1UdW5KMG9CVW9OdW9W?=
 =?utf-8?B?YXhrdG1kOFJiWHhlT2UxRnRKWjh5VnJrdlU0NnhVcFZVaWhEekpQTVdwSThq?=
 =?utf-8?B?aGZpLzFOZGFUNzAvRXNaR0Z3VVNNNWFwUnNiMzVVWlJ2SGMxaVFYbS9OMVpS?=
 =?utf-8?B?MTlCcU50UHdJZnFRWVVYUVlQUGpvU1kwdFNBc29ZL1F4RGFaRXB2Wm1HS3Jx?=
 =?utf-8?B?MlNsWkZLeEpTYm5EZUhiOFR2R3lCK0lBNHdSZXFqTkR3YnE5NG5EWjUxQVF2?=
 =?utf-8?B?VnIrNlUwRk9VdWs0KzNVM1BBb0wvNk9XQitCSEd4U1lIT0R0V3ZnRC95U3pF?=
 =?utf-8?B?YS9OaWxkOWNFM1E5OU5kc2k5SGVETEFKNFVlY04waU5UeGxTZy9EcHI5MDFa?=
 =?utf-8?B?eGxJd1p4S0hBb0pLU2RjTWc0TkNoeFhOZjdVSHpHaWRLK1BkQ01TWFhXL0pn?=
 =?utf-8?B?QlFqaXJEY2daV2NwSjZIMXEzNlQvdklpblhjWm9LbVdNY3FLZVhvWDVUN09G?=
 =?utf-8?B?TnVQdmp2YkJjQVhYNGJiYWlEUDRlbFlnY1JOeStQRTV3eit1OXNEb3VrSXJz?=
 =?utf-8?B?TkxoeDg1Rno4N3phZWNrMTFyUUp5K1czMkxreXZydXQ5dW4wTDc1NG1ZOUxm?=
 =?utf-8?B?ZGMwekhCNjVQU2dGOU9JYlNNZHFxVFZMa3YrSWxFUjBjSDJDbTFPaDJpWlAr?=
 =?utf-8?B?R3JHeTBhMWVRdUoyelcweFBqMytURDlqUm1MMlNuajJFY3NoQ1YrR2R0aC8x?=
 =?utf-8?B?NFhBK2grNmRkVEY0VnRreVlsYjBKanRHVyt5T2FMdHNLT2FydzQ3MWFRU3pO?=
 =?utf-8?B?WVBUL3Z0V29Ta29lY3JoeGRXTGZnc2g0RlZVMWhiejFVNnlDZ3FhVkxxdnlE?=
 =?utf-8?B?b3ZQWWRNakZVS09COFBYRExSU2VjNUhPaXBjdXNMeUVLQVArcHpGYk4vYWJI?=
 =?utf-8?B?d3pqSEVmT004aWxFaWI4SDNLZ0lOZWRnTmdMOVN2c091dURQc3U1dkNzbGF2?=
 =?utf-8?B?YU83MDFhN1BBM2ZwdWI3NmpFdHVPYjRMK01ub1lYYkYrclZXWWhnK2pWYjF3?=
 =?utf-8?B?RXppM3ZUdnNia0szRDJhVi83VzUyakovUG9JLzRsekVGYUxCai9uY1E3bjVl?=
 =?utf-8?B?OVI0MEtGcUREaURUdVAxUlQ5RlJmcUM4V2hFS2R2d2xJR0QrR2dycXhZV0I0?=
 =?utf-8?B?LzQ2ZEZWMVVvcXZjQnZDN3UxL3BsY0czKy9uSi9DRGd3NGR1MnZmZ09WTXN3?=
 =?utf-8?B?V2JrSCtZM0JKNUR4WEZyZC9vcDMyQndWSkZZTldoWDlRdURmZ05ZcEd2V05H?=
 =?utf-8?B?dG81Zy9ENnBVY0tralZYcExSUjZ4Z3B5VGwxeVJvcUpjT29tVCtOOXhwWmJH?=
 =?utf-8?B?MUhpKzRwKzNQRE5wZERkWERnK0QzNHZUb2hHQU8xRjQvZnhLTjRKVVR3UzJY?=
 =?utf-8?B?RE05OVptV0tkaWxGMlh0NFZkeEFaSmszT2EzZGRPbWJuTVF5SlphY09vNjVQ?=
 =?utf-8?B?bTlhU0tRcXlrbTBTRTBDRDBLYmhVWlA3K2U1R3pxWjdBQllPdGJhZz09?=
X-Exchange-RoutingPolicyChecked: sYyzChUh09w3186VH+qm1sEWwusoX5iXY9eJF4FQzD/h+zvGsT9JWompNb+iNlPBN8Yp7UmqoZJjgXMfmTkii9FOKGV6cLiQevn5sxnKMSvVlQBhjGlJmJoU5nn4WVJGKWJNyv6agWGRkUlbWz3oKpci+aJs7qlR/pxpinET4fU45MJ6M40/vYvjLvqmGAn45bOnB+C4SZn0bKjAYcqbbxKukblm2CSZtaluqNsS6rdT0splx2CVFieNqp+3LjT7Vk/kM+l/ocEKhqHA0K6IAOjm1ZLHx01YVZAHkhuIW3NnxTe0cky1laTmT6A4z6f7LlcKwtu6WH4ClXic5Ebgkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 594bdd76-2703-4329-9217-08df1ffa1cb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:25:19.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wNx5sUssjsJm27JMsrng2TUGM4d0l2KEy5bRg1APe0wMpHLeJBgxg5c0yChORRV4EusHXN8+55JC1K5EQKfP+/7tH9HV0cQMD4ZTKh24Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
X-OriginatorOrg: intel.com

On 9/30/2026 2:52 PM, sashiko-bot@kernel.org wrote:
> 
>>   static inline u64 vmx_get_instr_info(void)
>>   {
>> -	return vmcs_read32(VMX_INSTRUCTION_INFO);
>> +	return vmx_instr_info_extended() ? vmcs_read64(EXTENDED_INSTRUCTION_INFO) :
>> +					   vmcs_read32(VMX_INSTRUCTION_INFO);
>>   }
> 
> [Severity: High]
> Is a new eVMCS mapping required here?

As noted in my previous response:
https://lore.kernel.org/kvm/916eca60-f19d-43b2-96b2-b63943b3f3c5@intel.com/

   That's a Hyper-V specific integration question, which should be
   addressed separately with another enabling series.

Thanks,
Chang
