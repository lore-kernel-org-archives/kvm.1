Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795053328;
	b=etWVEhMoyp4uHzno1xfX6NANBvNt2zSGYKaVTk74AyPKfZwq2v7fcWNXIMymC8vcEUoQ
	 +MsGnariR1PaMkCGQau6GZm8zg+ZBW8Bg62MriZvapoQA6VqnjQk2fYvoPgM3mvIb80UU
	 HcNt12Cr8TAo1CS/LuxULXdsSS/r9bxml/6Dwg4/qdwrFuSTdL8g++EUFEH859up1CCJv
	 ny/UE5xMB761mLQ4ih138WJAaQuUaeAtLkqze3A/XhlNvoQGRO2DcBcCrAACHi1I96JJB
	 2Mtg1fOD4iYkkstoRjxJ0wo2K+OL26JOecK+AguyNI8zFWDldQUnZR4GEdIewLNjSsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053328;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=u55T5nqPr75f5yxM4dxmdRC8JAhJzLpI8vDHm4MECuM=;
	b=zrDMVlueXX2F7UAvKWkkHY2mynXFzJnJCisQdDwVM/a9kj3F0g+U/KRZRRbAtw/bj4e1
	 ijlo7wPeK3nsrFNDXD4T6IOPxEpuc0D5UTGrxW3Z5PxfM3J+yf7KzSvd2Iphn9yQ4735j
	 BXjOqZe01YhKcSonT/dJ6wby7GG29Lnjb3OnBg+6AIDUNSonFfvQPsfU0eY5zAkn7ec4n
	 heosDGAgQdwt44teaKZkQ9FFYcM36T+nxDbG9muzM+BqKVNGDPPNrzGtFOGVbJpbpDkZD
	 f9A4yLqiTDsFizkfKpHWPC+1xTDZEZBXVVv8Xwi84qiLZy7PIIkun4nUzllcZ3qNqyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9xwWM7f;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m4Jhck8y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5F606A33B;
	Thu, 19 Nov 2026 01:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F5F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9xwWM7f;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m4Jhck8y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795053328; x=1826589328;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uVI2UAQoU02JKQGlbkcpSbkWF9jPDTsCr+u3BO+7Glw=;
  b=b9xwWM7flFdyRm4T1Qtzd9+hZbbvVSzyolEwdQugwKfiZKr9Buv8Cpfk
   ziCq2B2JzLm78cyqC4djAFmPJhaXy6IAwUavlSJMNawcP4h0SEgZDgulI
   HD54PBTPqyvn+R2S+YrHDduhokAKJ65txPIRkRhMiU5iwydVwXK7WHKQi
   NqotKwl6h4aXYOUx3i7dIrEYwBjr/hTo6m6j6u8G0oHK7cbkL5UdPtl6Z
   J8sfMqlg5eeRbOh9nybWjZqJD4I9/hyzKAPju0/aiAvf2EnGYodOw3/QB
   OUgkwuAu/I76Vus4dlFL56Kg2uBVIl+XLfmIVj3X9cNx7T/8ibgzewLrE
   w==;
X-CSE-ConnectionGUID: hDl5BOMiQ8KlsPcZifHwkQ==
X-CSE-MsgGUID: UjTN9YzrR9KWZ4qcaU/5Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3909063"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3909063"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:55:28 -0800
X-CSE-ConnectionGUID: XRR7v1OSQR+t16IXcU9/bg==
X-CSE-MsgGUID: EfJhduSNSFqABJFW+f+6Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10549076"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 17:55:28 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:55:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 17:55:26 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 17:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIeWI8i1hvJ5+q6HT+SVwXIuYzgAESW6M1G7kCmmv22Uo+lfvaQqjivUJrZyBVVzyrF1hid4chUC7AszM16W7QrL6T5soYlpl+vZs342y3CXQQYoAdMInIE0h5pICIu0j+MZvWIRtzxiq+7Cp5ixFfjXfF8H42SRQybwk4EazYkWysl36Xs404AwFe8OVKivVA7wLmNOk9nS4LiiWLlpAyHavYduKjBQuuYkKWqtfp/BGo8O07phI7bmgDmYY/FBCMvfNWBJHZZzXPhJeLi+qd1/8/tLJmpb/CGGdKsXzsjluY+Hk+vad6BkGLr//fFf7SGngcwrb//W+KMLDpM3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u55T5nqPr75f5yxM4dxmdRC8JAhJzLpI8vDHm4MECuM=;
 b=xd3bY+c8Se/OJAR1n4OBmc0N4HotlWDRdbQtkfyZt4gHZ5fZIyMl0MuTW0h+juXMenONfh/rjD33diF16T100MS5tugHPU9rXhNaiPYqNRmLTDVCwRtHtTesZtfqXfCuX1+mJbhm2MgjWVCC54M6ZyOXaGkWVFAk4FslKItYT8nzQ1X0OI7lXytHKDax/BD2EPnVJU8+KNV5bO0FUBigM9YSWCMTCCo6PAg7Q1YPpMo5QYFyxdV8LxqUvGzd0U9Hh8AL1gHX6wJvx30ztwswytu1mKR5oy5eZ0uTxVzOzsrCOGio0mQgq+VmrtxedpHVgI0Sz/daSrXmGqd8rifFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u55T5nqPr75f5yxM4dxmdRC8JAhJzLpI8vDHm4MECuM=;
 b=m4Jhck8yMT+4fsbYV2NwL+6t6crdEEPlxNcVSQYWubGIAwsf8kn7vKh5DU0JLFj5jrwWNe/SzA/oiO9NsZ+H86B81qkJeMkndzilKgcU/X3nU+kb8+Cm4NFOrNJBzhDS8G54jLkqen9II7xfg+1/IrmBpnVRkDRhEz1M9TgouYA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by DS3PR11MB020596.namprd11.prod.outlook.com
 (2603:10b6:8:43a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:55:24 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 01:55:24 +0000
Message-ID: <28474044-d65c-49ec-99a4-b5ac5248c598@intel.com>
Date: Wed, 18 Nov 2026 17:55:23 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v9 12/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
 <20261117180310.921701-13-chang.seok.bae@intel.com>
 <CALMp9eQBQnitBu0ybMz7uidz1KLvMUi6GChyrp=45Qw1j=1i=g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eQBQnitBu0ybMz7uidz1KLvMUi6GChyrp=45Qw1j=1i=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11)
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
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|DS3PR11MB020596:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de21d57-2da2-44d5-7d0e-08df45e02d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|261009223027099003|18002099003|11063799006|4143699003|56012099006|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6URmfNuAVa2csJNN2nbPEaugA4yBKQBpHRy916FDgLmWL5PB4Urrp9KNlbHrgyde8jRwd7VhQ44qfIvS1hy54lXtb6bJeqQ6cTDwkH2QW71GPTxxBENabZ6p/Cl0sgD7uFVeTqTtkCtalvA1lpCfUIEVZNkuGAC2V6UYcVcEyaGG3fMrfDn/ntQVLgM6EiEW/z3IQx6OZqRqttL5MHPoanNz8qUSfM+OgQ5Qm94qs4eYy2+JwY49UmnGvDWVupe2/HqNfcDJrraDZ82fEm3b6u7PdoKODt7ZxXpmxYrGp8wUrQjabuJI6bfF2cM6LTzGQu/Ud7KxWKj8a10VyQqYDL1bj8Pf81UAbw4ds4fypUOTrkEpXtEX0R2Xul03fAOS1fBjV2XfzNOwFUZXl7Ff6IIiggDPfiAUmjI3kD+/hAccbZvizBM6Dei+lSV/MjLZ4kV37v0Zuxo7fGU7OIqdoLyYfuvOqV/qYRoosutKty2uYjguPcreBUbBU7HEIt7sZ4HwwFdeOyXb1cO3zyJh1qiaROXcVHwao5IBeL84atqL1RoT+9vQvG5N6OpJdFPi2R+ysUkRDu9gYDs1q4gcUBGXwVgN/fBsvDwpuBnKMEQB45pNYFZhIpBDrqHRWwhztQsOMydOzcDbUDQ9GmIDyf1M6iIIFskm4ZjrKn+gZLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZxeVBEK1oxbVNPaVA5RXF6TXRWRzFnWkJqUEEwZk10ZmYzZDlmNVVOUkw5?=
 =?utf-8?B?OTkzSDdTbjJtTTFpeDhFdEYvWG55K0hCR2lGTk5kSy9DWVZjVmVRU09iNHFF?=
 =?utf-8?B?WHFWamFjWnY4U2RIZXQwbzM4M2ZoWjZNb0JvQ2xUZ3YvNXlYUW5CNG5NUElX?=
 =?utf-8?B?S0x6c3phR0FrTkdZZWhYeVZ4bURTZDFET0ZBendDSC9hRVVRSHF4MndObDVo?=
 =?utf-8?B?YTFpc1BUVUtpQmdVV0FURXhQMXFlREtkd0NzYy84S1VUWFRaQUZoRGhtVGVV?=
 =?utf-8?B?UUcyZ2d5eWEreUI5d0xVeUQyRm1MWTFCR2luT1dJeEVTaElNSk1HamEzYXN1?=
 =?utf-8?B?MU02MkF6RDcyOWt6Nkd3TTNrVW01NnR3SlVtSlh3cG5IUTVQd0RwWHB6VWc2?=
 =?utf-8?B?MUVXUVlsVWRrY21GTDNxeUFKRzgrZmJ4TDhSYWphcEpydnRwOEcxTWQwREpa?=
 =?utf-8?B?d21iQUFpL0dCMnJhM2xyNUpxbGR3T0Vpa2tNc05jbDROdmlhR2RtOU05VHZv?=
 =?utf-8?B?Z2tGb0JONnNCeVdvT2x5V25LR1B2SWFzQTUxcENoSS9tVEY0ZnRncW8rYlpM?=
 =?utf-8?B?ZG5sbzhUMmdkS3Z3MUZWWTJZdkhwdEM5bFY5Y0VSeFZVcmRFQXdTdHgyUlBk?=
 =?utf-8?B?UnlDeDZJTW52Y0VKVm5xN1JrdjM1WnI0dWhCY29KeTJ1THg0NU5PN29lZzAw?=
 =?utf-8?B?dVNlZkdYMlIvUnJzUVBicWtIdFNqUjArcFRDbjhUSENzNURlNXVEcHpNUzl5?=
 =?utf-8?B?MU9wNWg0YW52TXlkOUV1SE9NOVN1VGowako4SjlNSmZLb0VFSmtZdS80UGlk?=
 =?utf-8?B?TDhMMzFvTWxrQUNybUhUL2ZmZzVaL3JYRUxPTDhnRjhKZjJDaU55WS9YN0lN?=
 =?utf-8?B?YkMvUVNDd1Z1R3UxMHlUNWlIT2Yyb0JQNUtzNWNZS1Y0SDFxYStQWHdpSnpO?=
 =?utf-8?B?TzlHZkJYWTNwV0psTmlFUldkS2o1SVhhK0k1YXNEa2V3WTQvWTh1d1hVOEdD?=
 =?utf-8?B?T0Y5S0wyWnVhYURoT0ZyTnlZUUZrc2M1SEQwaTFOVksrY1lMZjdwUzVXNW1a?=
 =?utf-8?B?VkhaTmJsU3U1enZacklwUi9EUTZhM0d6ZjFHRXIwRFkvVEtVNTRUOERSSmZ2?=
 =?utf-8?B?NUtYS09FVGhWQ3BFSFF0SlJkQmthY0Z0VFZQWVgwbkZrNEZySEVsTTJUUDlM?=
 =?utf-8?B?SzU5Y0tQS2tqWWluZzFHZnltT0g4bUNaRXRIQVBXTkRMLzlMQWtqRXZqWFM1?=
 =?utf-8?B?Ym1kMGx5OUc0Vno4SFNXUEs3NlN2ZHlqU0t1MUU5L0FQTHVMV3VGQ3Z4WXlG?=
 =?utf-8?B?OVIxYTJKQ1NxbVpuc3N4bDdBZGhRZ3V3UUlMS2hjQUtCY1dvaFlXejBTUC9Q?=
 =?utf-8?B?WUVPczJVRE93aGFVK016clBOQ3BmN2NXYWprWmlOcGptQUZ2R1dJb3lFOE5y?=
 =?utf-8?B?TUFRbkljUlFoN0c3YXZMejZNNGFtaUV1bFdIRFVSN0FQbFFnWkd5RHlSQzFx?=
 =?utf-8?B?Ym9HeVo4bGdxRU5OSzVZQkxpc3RwY2JlSFlSbFp0ZFFCczB5dUJySXBCZWNE?=
 =?utf-8?B?SnhqTU11ZzJkRWlWM3lPNjI2K2lBcVIzeHFGUTd0Sm5ocnpkaGpyWW03eTdS?=
 =?utf-8?B?WE1sdVFlQXhoYVF4eG80NmpoTEZKYWU0SHVuK0U4dVVtZlB2RE5HUTMzSURz?=
 =?utf-8?B?eXBRV0xENUoyNjdwb1RMSFVPdDV4UDBNa0JnWUdmajlWL3FkN0Jpc3E4M29G?=
 =?utf-8?B?aVVDOHVvSmhZS2NGdnhBc09QQVdFNDNvVXhvNlFoYXJvVFF6N0t0NjBlSE8w?=
 =?utf-8?B?YzYydDNxOVVuZTd0RWtZTUtCVU1aTVlRQzZoNWNoWDcvYkgwQjhtQzZ5b1FW?=
 =?utf-8?B?NjMvK0cxVVVKcHpJeTFxNzhLYWNONHcrWDhkR1J1RjFDMVpKWWNNS2N1YkI3?=
 =?utf-8?B?V1c0Q1dDMnJXWGduTVlGdDFyVHgwR1Ivdk5INU1Cd2QrUzdDbVNwS3FqbnR6?=
 =?utf-8?B?WUc5MzkrV1QvRHptRFI2WDZtM3kyeS9IMFNGMHNRcm04Z1hpTlFOYTlwSjlx?=
 =?utf-8?B?Z1QxNDBlVWh1TVNGdGxjd2pNTzczalFhN3psVHc3ekN4M2lkMlNDRVViL2l0?=
 =?utf-8?B?d2JMY0dJSlhRa1dVOHIxdExSRnFBRkExNGhZNTh1c1VxelM1OE1rUjd3SE9N?=
 =?utf-8?B?K0lhYmFkUlhWK0lKMVBLcWFzWitiUVRzVG5SL21mcFVhY3FFUStqYXNrQzFH?=
 =?utf-8?B?ZnJMMTBmWldiblRJenBNL2w5ZGhxWlpCalBxU004ZTR2SGJiY3FobG11T1RJ?=
 =?utf-8?B?Wm40ekJya3g5L0VXdFEzT1NUUU1YQS81emV0UnFNTCtZT0kwYXMydz09?=
X-Exchange-RoutingPolicyChecked: HPANAtGgEbV9l9z597l41VgT0lftmQGR1SnXIajNsZz5zTZAgexteU3/QggK9qni4xnblZ+0y/wA/jM8AMZ+KREWefbx5Nhr/3UrhEOtGDXv0CJ3k9+XRUl0ppoRTg71RsVm9H85qmRBiUmYPBmDhO5VIPL/EtrAgObqwB3qiIBHhwdpS22RRmHUOfdni24Bqsz+Mn2b3LN/neZLrSaeE7HXFxCQu3RAS25V4SMJzumOOECrq1PMeKWHcj+Ru1kvaD+Gz1gks4kb7wpFE0qtWFmhpW/rbsFN3FiMZZZkrCMxkPUgf8GFAmUPGHqKos0hbO+eZnw0SxR9+tsPJ13tdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de21d57-2da2-44d5-7d0e-08df45e02d64
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 01:55:24.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jqJjIWnhpOkJ6UyHAZIgrmcIEvcZZJVejEpzrE6FfAfCsv7z8XlioDXDrQrCu89fRJqWcfnZCptvjGtcvwD5u9db80s2sUTMysrgCzGCNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB020596
X-OriginatorOrg: intel.com

On 11/18/2026 3:02 PM, Jim Mattson wrote:
> 
>>   static void __decode_register_operand(struct x86_emulate_ctxt *ctxt,
>>                                        struct operand *op, int reg)
>>   {
>>          if ((ctxt->d & Avx) && ctxt->op_bytes == 32) {
>> +               reg &= 0xf;
> 
> Thanks. That takes care of the BUG() in _kvm_read_sse_reg(). However,
> you didn't respond to the other half of that comment on v8:
> 
>    Similarly, em_mov_rm_sreg() and em_mov_sreg_rm() use ctxt->modrm_reg
>    directly without masking off REX.R / REX2.R3 and REX2.R4, so setting
>    R3=1 or R4=1 on opcode 0x8C or 0x8E will erroneously inject #UD.
> 
> Per Section 3.1.2.1 ("REX2 Prefix") of the Intel APX Architecture
> Specification (rev. 9.0):
> 
>    Furthermore, if ModRM.Reg addresses a segment register, both REX2.R4
>    and REX2.R3 are ignored.

Bah...thanks for the catch (again)! I suppose masking should've been
there since REX as well.

With the changelog,
     "... Also, ignore the high-order register index bits when accessing
     vector registers (XMM and YMM) or segment registers."

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c6e11f551438..2b649d15d5f5 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3359,6 +3359,9 @@ static int em_store_sreg(struct x86_emulate_ctxt 
*ctxt, int segment)

  static int em_mov_rm_sreg(struct x86_emulate_ctxt *ctxt)
  {
+       /* Ignore higher register index bits from REX/REX2: */
+       ctxt->modrm_reg &= 7;
+
         if (ctxt->modrm_reg > VCPU_SREG_GS)
                 return emulate_ud(ctxt);

@@ -3369,6 +3372,9 @@ static int em_mov_sreg_rm(struct x86_emulate_ctxt 
*ctxt)
  {
         u16 sel = ctxt->src.val;

+       /* Ignore higher register index bits from REX/REX2: */
+       ctxt->modrm_reg &= 7;
+
         if (ctxt->modrm_reg == VCPU_SREG_CS || ctxt->modrm_reg > 
VCPU_SREG_GS)
                 return emulate_ud(ctxt);
