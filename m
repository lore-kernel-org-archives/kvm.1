Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924F36A022;
	Thu, 11 Jun 2026 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206624; cv=fail; b=kBTi04urfP/wIiz9hyVQVRfFbiTL7otuVaGnpRcEccd2PffpvyZpP2A29TgoGtVwXK7WPyEq5X5ZP7qR04mocsJmWICfTb9p1nlfw0VaZXzItQ5ad22tvfVKeB+B14m37G/Kza5bHcb/MmlRUu4eOnKG3ahv0qLRCUlKICmTTvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206624; c=relaxed/simple;
	bh=xPoAQw6U7zkaG/TWYgjltOSdL33L444xAa6Iksq7FsQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVE3lWxDOYebINEph06MJteWRieYSWq+XhO8R+VY7Kg6IcM3C8nr5BBm699FK51Jm5fjbsdq0+SsoEafNlVuWUaSFxm1vuuV22Y5f62S9t/QDJ45Mup9aR5VRr6kO5ejIEMdN5tdVJswvGqxUDJSzezk1Z1PYjx4RCVFlk1Kf2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuETov/V; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuETov/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781206622; x=1812742622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xPoAQw6U7zkaG/TWYgjltOSdL33L444xAa6Iksq7FsQ=;
  b=UuETov/Vgk0UB3yh+QIQbDS51IBhtujZZnNXacceVJ/GZacVT5V0BqDE
   a5enQPLhWL7Ku+6fmBjf4TkyPmfIohUEewhDNGi8wPn3NKtuoTNTRFTT6
   98xwAUSa3eI6FsOWap2iVGduMpXhNP/Ca0xGxMdNzMffHBLDvXmaajZ/t
   /BCftu0yxXVSW4SRTOmvr8GxyWBVRazivs9dA/22zuaO1uZBygjPUt/Ae
   wWvhdE+M+vLezuPqq/chMXEeyF4RLZqYD/OBDGMmLYz09eXoG1vU4IeBY
   yBaTPdIR9Vo6fuPNsWNG2Es3GOlX8Vn/2To7Xy4K7fl1OqrJxKPVv+ZGX
   w==;
X-CSE-ConnectionGUID: 8RL+DMYuRvSb1wJpZTnckg==
X-CSE-MsgGUID: 6sHFLrrhTPGxJGY/azYB4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93141340"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93141340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:37:01 -0700
X-CSE-ConnectionGUID: IljoLMMuQCyYZAdDm+Z8SQ==
X-CSE-MsgGUID: L+qVjVOzT4SwNy6bg3ECrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="248476152"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:37:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 12:37:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 12:37:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 12:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVcGJS3ZZ8uuyckLOUaoftUzuDFaaBuyTYYjawTQ0yuV0WXgo3NT2opLVpsNDsCySY9CUKglaMSFxIt+vnINmO/8HzzQAjYueMtPKr+FXsCgiAvJBepZNjY6ZL15P+dliCZgSuBjkPrb+XWTi3/sYyD6/u24UdtXcsVxeHowRsSj6X+/bpA82pKi+2nwbR64csBWVE8KBx/ag6wtiIIA/rDODmCWD5xTq7GoEjad0+ENu4EOHCiEQyMKbMUXdYDhWTeru+DHNHgrH9szXNFg/wIupl/sv6fSdk7r+Fqw1f9kNa/N4wheeZn6PoHZd+3n7cpRvhYjvOpgmH0iw51ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZXSA+V9ii//mmhVi1io+OqoLflKNHozMQVxdNQgcq8=;
 b=PxXaddtYG/+mvzksjve1mm3q8ba1kxiKiM+5gIwy01Lt43afYYHf5y/Y5sGz2sdIexc0lYMGZQKynC8PKDjm4B/QEoNZ4dfm8f7NSb9OqK0xzIyfGL0keIy1gbTjAhToAHJqN9dqmOMT8iy1qaGJk+KFCvlLg3f9LjIhWyJ++/w5RwPmPNRD5lx64UMdYtiGC+MCrsm21YM5RVasLQIUwTH+ZLvKBOIezlYtebyXMsGrP/M6/BAzzKY0zzMNCzGxH3W8UhED6V3LlGVBti693nuQ+f9wzJS58U07ZSsexvhnmk4xYYoRZvl1U25WcNdvclNFXEYsdtkoermSMyg/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8939.namprd11.prod.outlook.com (2603:10b6:208:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 19:36:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:36:58 +0000
Message-ID: <7090f4af-3a6d-40fd-82ab-0ba6272534dd@intel.com>
Date: Thu, 11 Jun 2026 22:36:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/15] KVM: TDX: Support event-notify interrupts only
 with userspace quoting
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-14-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-14-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0208.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d32a34-e8f8-4e28-a0ed-08dec7f0cd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|3023799007|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PoBeUemKtRHokGBpCqYdcoUlndWFhfP9bVm8IbZS6okLSzPiv0TOeMtdn8aAQdhFBRsdnhh2P3DAAKuFppCXX2VgXdgOEir86iw79nI4XN3ZUMDN/JKJWgbw1l8807vmrwLgHeHDJEvt6K/tFU+PgPXJvOR7JMN6JTj6GT9l7ULGZXfLTFjXaCwUY7+bSVzcYb/R2w1Jea348UhcTN9yvzXvtcf7bCCmvdEMyqAbCqSRiGbkHrc3z1crerdrMjEJRnOo1ICtjNGLwsBtS1U5QX5k12XxmUbV0Y2yJn6/4yLO3Pid1t6b/YvgB4lhDf50r/4rnuB0Qv54FqZ8lX4xhXWJ3s/akoeCtPEbD10mXJbiZIGfIVIjv7MJmu3Bpyoo6lj+npUUFBXXRZR0s6yWEbqxkzwZ9wSdnah7tS4dhL5fjEZU6Z/NC1R7P52ICSXzSBfTQSlFk57Fhi0lrQpV5Rmc76fvD4b4euHPFjSJkxbLp9VG797TMCUiWtaHF7UE+JfctCQw5NqCo5yMZiqrP5YsU6iUQyO0e1I+U3JH6PMR+gvtrVCnSyF97Sc/l3mEsuKlO8/lQrNQHZuZ49+7mYJWHdaANYlq5xFNAXf0r5xAuOzjL7bVEUmPrZBRY/TUPYfPMkBeahCJjaaM/fXeF+F2ZDnXWfSfCDxvtDIDotDVSb3jQ5+wIpVG2gWg+lzR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(3023799007)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNYQllwYU1IcWVYRUpTQlZSb3dNcUhRb2dRY0NkY2llUGFYYXlidVJYUmlh?=
 =?utf-8?B?K3JJaC9INmdwRmpmb3hkU0Z4Q3ZOQ28yVkx2R2dUTlVSZTZyMFNtUnUzWnVH?=
 =?utf-8?B?RFc2dXIwSmM4bjBrT09Fb1ZYWFdicXVOeWNkUGxrVFFkeDN5bjE3WVVqck9l?=
 =?utf-8?B?V2ZlNTkvMmkvVlN3MXF1eEU2Z3JNSmlrQUk2bit4M1F6SGpmdzhEVnhUWlRI?=
 =?utf-8?B?UmZaVVRhdDJ0eWE1MXFxZ1loRW11SEo5bGk5RFVTOHFSZHQ5d3AyRDhuSVZw?=
 =?utf-8?B?N0U4c2FOZEtOQTF2Y0YvOVFRRUREY1JjUFhlYk50VzJRZk42QjR4c001TDFl?=
 =?utf-8?B?L3pmVDRxRmdKMnJ4TnJRTEZlRTJZN1kvODBDMDZpL2NLWkI0dGRpbVZnZG5y?=
 =?utf-8?B?NDBMd05GTDdua2xNcnlGeHNhREJ0K0hvZ2Qyc2djbmdSNEF1OWtqZXRTcUJj?=
 =?utf-8?B?MjhFUWh2c1Vwb1JjeURsTi8rdkUzSFB5UkJZdmRqSUNtUFBSRFZSREtBSk8y?=
 =?utf-8?B?SlNDaXp3TjBjbWorejhEakFTek9kbFVCbmFhSDduOFdjUDZURVE0VXY2YkhY?=
 =?utf-8?B?RmxFQlk4MEd2U1B0dTQ5cHhya2VQSytNSDJoZ0FvNm1wOGtpSWpUU3l4Vm9l?=
 =?utf-8?B?VVFQOHU5cG1CTlJuMmU4VkkyRkRjWkFrSURBZGlmV0tESVl4VlZkM3VUSzRN?=
 =?utf-8?B?L1pIQ1RHcktFTDRIYmpBazJQSlNBdnhhZmJhMTZrMWUzRXArTGp4bVoxTkd4?=
 =?utf-8?B?TlcvTmQrN2g0TFpiQ1UvZ1JuQ3FSSXZOQ3lmcjB3Ty9VbnhuOElLTzltMDNp?=
 =?utf-8?B?dFUzUUVVTnNKcHJoNGdXRFhjOXY3UlFVTHhHSXltYkI4MnBqZW5OcTVYQkFw?=
 =?utf-8?B?UWxFZTN6bExxVUQ1M3ZXQ0MybysrMEx3RytrSFBlUktPVzBWcHlKcjRSbENl?=
 =?utf-8?B?a0cyc2RoWU5NTVBnV01zaTNHMGRzUVNTUDI4VGYxUWZKTmcyc1RTQmQvSHF6?=
 =?utf-8?B?NVcyVWNZN0RlZlcxMUxyYlZEb1hUZ3E4Z2lUUkExOFhIUDdWZHhJeUFZc1dT?=
 =?utf-8?B?M1B3QjlyUWNmRUR2OVhjTXVZcCtDZGE2Vzg0YjN1MVN3K09nenByNE1FRU5G?=
 =?utf-8?B?elhGZVpvTkx4T1JSa2FhM2tCVkNHQjZPZUtPK0J1V3BZQU4vTk9ySVhuRkJj?=
 =?utf-8?B?ZlZpVlBjelBxRCt5NjlueUUzOVF2c3pqdGZmamxzWDVQNFQ3MWdkOCtSOXdF?=
 =?utf-8?B?cTNaMzJDc0pMS3Yva1MzdUxpbWRudXVya2tlV2xaZGMrM2twMHZDQlJWbU85?=
 =?utf-8?B?bDVoblpteE0vaC9vaWdTVmpSeGcwUXZHZjZrZnhUU3dRRTgzTmxQaDQxU3dE?=
 =?utf-8?B?M2V4WW5GTktiemp6SGpNNnU2emM4alI3ZHYxVU5WWHFoUlg2MTRrMGFyVllw?=
 =?utf-8?B?ZGJvV05PNG11QWpKNzFmK3JLeVZrVjlveWROOUhIeFhYM3ltNWJOa3N2OHBy?=
 =?utf-8?B?SzI4K0dYM3BVWkV1NmFiR1Nyc1JJNGZGL0thcld4dHhPcUY4Y2xpTlFJZnlV?=
 =?utf-8?B?Tis1ZDZpSDZ3Mm1qb0FncmdkeFFmUjBUSWUwNlF0MDBkb2s0Zit6c0R2QUto?=
 =?utf-8?B?Vmd2cFBVa0xhVW93ckw1V3JuYlUwUEtSSDR1SXE0SzlyOW1HaThRanJCcW1z?=
 =?utf-8?B?K2pKdlBnc01GNzRmYmJocCt6REZQcG5qTTlWSFBveCtEUDJqT3U5ajFuTmNR?=
 =?utf-8?B?Q1VYS0xjYUwvQ0pmdTNhUitDZnVLM0dSeHllVXhSWU5BVk4ra3RBQ1l6ZDRl?=
 =?utf-8?B?R1FYUWc3RkJiZnhTdzRFRnVJckJaUDlidzhJOTFPK0FFUE1lV3NQeEp1U2RI?=
 =?utf-8?B?QURYREhveFRnd2FLOWF6REc0aG1tM29ZQXg5R3ZZOVNraEluM2s3RHc1MkRQ?=
 =?utf-8?B?QzlHdjVLVWlJZExnL2Fkb21uWXpYNUtzNU9Za0Y1V2tVOHdpZmJ4ZDFWdGJu?=
 =?utf-8?B?T2hrVkJYNW5zcFBzSE5OWGxnalBoMWd4dzB2UWp3RjhaekF3RyszbStXYVVN?=
 =?utf-8?B?dU1zQk5oSGgwcnJMVmJCMnRRWUZtZEhIZmJpaGp6WVRvM1dMUGtueVY5d1R0?=
 =?utf-8?B?L3JUSzV0WXl3b3p4bUs0aVd6U2ZQTFZnNlRrTmYweGtxQjdBcElNM21INXFV?=
 =?utf-8?B?aDZCMll1TWFNRHBSQkM3NXZxK0Z2Um5scnZhVWMwZVAyQmo2Z1hDNlFINm83?=
 =?utf-8?B?bnVtRTQwdEIySjhWbWVNajJKZTlub2prL1c4cVJKa0JGMXRGVmNRTHFBZkM5?=
 =?utf-8?B?YlhKNU05YWo3OEFvSjUyaWtQYXpGTzdqM3FvUnNGRWNaVWhLeThtdnAvQitY?=
 =?utf-8?Q?qTcYLtLx4AUhHAHI=3D?=
X-Exchange-RoutingPolicyChecked: owOPPnvhyzESqsFklN+Ie+o7L7rxA6j/NZQbDSIyoANFjc/GDYaXW7454P5SKHIc7MOnoHQ+78uXNpR+AgQcxAZwTmRjKuCeDhxvfa5MUlUYgQJLSWj3GhJNkLAkj5PELSawUA5aq4jYnPLoPWW3JHav0Nk4AExmxDNEs45bSrsNIHMa9s+6d69+jsU4KTIjFzn2NttSZAzXtTn3JM68TTzMejdHCvzs0gS05rxgiU5dN+cPWRwqy5P3+oE0/eLTnu0CFZ1GKmnyiyKd7sS63TJL67IybMg54oj1UJs/1vChHAw9tsiI+sMbOnMFOX8SW99xqmZi0c27ac8HPP1o/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d32a34-e8f8-4e28-a0ed-08dec7f0cd0a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:36:58.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FvriYUA5Q37Obkty6zC8l7ZUCgaHtB2+baV8FkWXSW8GVkVi95auPXl8jkqAV+JkqYECdhE+PcK5mYiKkKgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8939
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Tie userspace SetupEventNotifyInterrupt support to userspace Quote
> generation. Delivering event-notify interrupts via userspace breaks if
> KVM never exits to userspace in the first place.

Breaks how exactly?

Seems like a TDX guest has no way to know whether the VMM will use
the Event Notify Interrupt anyway, so it cannot rely upon it, so
it should already handle the case when the interrupt does not fire.

> 
> No known guest currently requires event-notify interrupt support, so
> defer adding in-kernel support for now. Linux TDX guests use polling
> only.

If no guest is using it, then why does it need special treatment?

> 
> Update the KVM API Documentation to reflect the change.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  Documentation/virt/kvm/api.rst |  8 +++++++-
>  arch/x86/kvm/vmx/tdx.c         | 20 +++++++++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..8a02745a36ee 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
>     queued successfully, the TDX guest can poll the status field in the
>     shared-memory area to check whether the Quote generation is completed or
>     not. When completed, the generated Quote is returned via the same buffer.
> +   If the host kernel generates Quotes through the TDX Quoting service provided
> +   by the TDX module, KVM processes the GetQuote request and it will not appear
> +   in userspace.

There is an Attestation section in Documentation/virt/kvm/x86/intel-tdx.rst
that could be updated too.

> +                  KVM only supports version 1 of the GetQuote request.

Is that relevant here?

>  
>   * ``TDVMCALL_GET_TD_VM_CALL_INFO``: the guest has requested the support
>     status of TDVMCALLs.  The output values for the given leaf should be
> @@ -7342,7 +7345,10 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
>     field of the union.
>  
>   * ``TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT``: the guest has requested to
> -   set up a notification interrupt for vector ``vector``.
> +   set up a notification interrupt for vector ``vector``.  Since this TDVMCALL
> +   is used to optimize ``TDVMCALL_GET_QUOTE``, KVM disables this support in
> +   userspace VMM if ``TDVMCALL_GET_QUOTE`` is completely handled in the kernel.
> +   KVM may add kernel support for this in the future.

Is that really necessary?

>  
>  KVM may add support for more values in the future that may cause a userspace
>  exit, even without calls to ``KVM_ENABLE_CAP`` or similar.  In this case,
