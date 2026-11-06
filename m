Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793943188;
	b=s7s8WhrADr3liW4AH94j39HIlHuHJABAwuwtOBQNEhVcnFQ7FKJTkG+xehbKQwwBPxWI
	 1Hf6l2uhy02UIpc2w4GwD/NkmYDZjQm2l6l5rkfjce3OlfsTC2P2rIUONAZFVZhshwmGD
	 wdJKb3UL20Dt3QDoJb3M23MnGGMZPCJ3ND8t4i/XQqW7kPpKYluVxbkXZ4Ae3aba3UGsu
	 y287kO8EaDxkAv38tF2hRKWr9j4czX6Y2sBlxaYsyCuoxqeMm1tTck9TU64nMN900BC//
	 O4qWNH+kVrX/Es9xaVYNYfafPkTk2BGOCJqCAokaYkZoDbuGOLPWWg6BjDQe6g6uERQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943188;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=NbMbpipZvYQALvUQaX25nR4/sK933oBO4F2ePsMS6fs=;
	b=DR/xLTngWftfzRmWumE5RP0HjVSPLGMwKCgwh0BpOEDf9M0QAYTtyw4UcljSafWduR8D
	 LXRNhQJ1paVmBupRsJMXnnlUgAvIa2wpFkJXeNqG+BWjcQStpcSfSTVM80m9NisepyBOf
	 O0vnn7C3ADTHQ4dmQGMCK9iXZ+C9WbAd7yl3W631obNw3GcOFisF1hhcfKX69g9D9WGIH
	 03DJJe8ntsuKwJM1AfymlG/2TWY0DTs7v8Qd6y6ziekYmOwZQvbAtqcbTLJjJViy4S2+l
	 /9z6XqoTZrjCzKBOKvAHY+X538z1MxcccApI4fOEIKoGlY0nX6chMdVyGC1YEce5viA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmfwNNe+;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697D606A326;
	Fri,  6 Nov 2026 05:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C697D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmfwNNe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793943185; x=1825479185;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=COnj18lh7rIVLE7VgQMe5rxeJZQbKSCvVvkSI0qJ6TA=;
  b=bmfwNNe+hmnIp1MANe/RAQFQxTGhWXATR/i9mu/BU3ExAwsuSYa66BIU
   Cgrk8hzGy5GCPlCuk7U5oi0rdhtNmU2sVukv/hwv5XvL8Hzmx0qeYSQvF
   QC0RQCkNQkkRSX67mwhWxiWSHDbZZ9kdWXoEAS/e4JmaAhKLOlYm2wEis
   FVvalLFUeo5xSofzLqZ8m2iwDqg/4KYJA89QZgaCrZscRb3l38htQEJnF
   W6UmK6vQqJt//8siNJ8+ixPSC5Ev8Vzsp8PSrji+UESBa1/tKZSjzT2Ys
   Z3+w9OhIdwtciVW3yOsg/9Jw2qzN+qu7GR9wbtvMaBRvqwzHRJjZqlFJv
   w==;
X-CSE-ConnectionGUID: NLNSNeefTya0WlZHwEql6A==
X-CSE-MsgGUID: RnyTeKlDTkS/DWYJIxKXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2639279"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2639279"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:33:03 -0800
X-CSE-ConnectionGUID: /1c8GErOSVO5FRCnH742nw==
X-CSE-MsgGUID: jCWTqY0ERhiOnDugnapJ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7753166"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 21:33:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:33:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 21:33:01 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8h0+jiOl38YJ7C+HssIxTBLGMuHP/UaW3KYFUOTx6kPM+a/DhuPbEMy3ubijaqOx0I4WrY/so4UpPm0eCxuOmyxf/GCs1Um7eLr8IoyzSeIuw+T9Ar/kE49FIgcZh7C2t7l24kDicaMekgJedUVfVKnaxsADqWBtEbJ1ZN46GodacmzRAV4vpchr2ugv5K9Bb/hMEdtbbyTx7soWhpcP1ehMad98YqP3osEBsySxplpbpSLQVJvY2R9ef9g4NVhTkXR7pAFebm5eAGgMjRL7BXfmZX4J271wb3ygWQ5syZnsx7Ci7Zq3HGP+5aKHhFYy5b2FWoAS3C/E+XPuj3XaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbMbpipZvYQALvUQaX25nR4/sK933oBO4F2ePsMS6fs=;
 b=WLowb225sC7sATuJnmQWZ/19CES5LY0fPyfV8DRNNJsPNonBESTwH0IXsAAjiHHd2aY2O2DF0IX3q7VJfoGyA4iwjVFejNR3TaeWQ3dqhtbmyx4IS+6idJlRhOxZ/nJpqU+2V45/yaOqwFo+1SIXgcqsmNdGQ88EuXlA9w30CD4zy+hbD0kMTPRViVJuV566tvP/h71V4PIsIEu5feseaCY417UBmOaFYQlDzgGj/v/AC+IXOREaIWxpOBdVa9TD90Y8XS2dFQTSkoZONkdR4NTjtAfHx9jW+TbpSf7WDBMR6Ir3GAAGLvmqePagkco2DZYsnY78CgKjpuRqj4v5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:32:58 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 05:32:56 +0000
Message-ID: <efcdac63-8422-4a60-9ea2-da790e1f0846@intel.com>
Date: Thu, 5 Nov 2026 21:32:53 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 01/20] KVM: x86: Extend VCPU registers for EGPRs
To: Jim Mattson <jmattson@google.com>, "Chang S. Bae"
	<chang.seok.bae@intel.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <zhao1.liu@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-2-chang.seok.bae@intel.com>
 <CALMp9eTMteQ7WpPv++Ds_LZY_1MydqtwHy=7zsUEgrfRempbeA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eTMteQ7WpPv++Ds_LZY_1MydqtwHy=7zsUEgrfRempbeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c92126-6ffc-4b9d-a82a-08df3bc76951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|11063799006|4143699003|261009223027099003|261021123027099003|56012099006|261021121427099003|261028144727099003|261022105027099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: AhBslmlrSV+r5FVrw8jF8scaNyrVUAQqReu/6xjRQHKwpyEfDjd8lzjtUsyqkpF8eGbqZT6Bg3/0TOGSGIfClRz3Pm7lfxvJ9+r4RImPhdzo+TaZkGHyiAmeZ/WyypAJ+jgLTyLOroA69+3+x3n6HNy0kZB57Nsd6QhcxxoVTKyoh/G+efk+h5qFWWl4gq1lSdMb2bwanbv/S3cxEB5FigAKJ6g6WKfsEG9E2ISN2lVPqCF+PYSBCbTaCW8NBy2fQa3EnTpdRwfN+dLWbSS84ZG2LRP4A/u5sq75DurwBZNbnPa+CEgDaNWRmP3kESIsKZpsALT+mBzwMpZmFZtmv5gEyxq+B3NKfVmTTQLkjoL4Wqm4Ss0YY9x59pqzIGgDo4nzq2pEpm3JYuVehRCQqViMNOgQQtJkq8e89eidHyaA0THNjgVJooIEpDzttuXa6NBssRqCylGRP0qgr6CD0FsEIxj6ufHbLCEd2X6CdQd1sgFOm7d532Pi71ULNK5BNn4WNYvEZCdfLtrz526EIGxNVl2CxsELbDSo6/+KN9+l2oBDq6YDE2548IbO1BRyNh8BK+9PAEhXDsAa71COpLKaPllvFLy0JyIaMJQvFZxq+zW66yZP63k4cJn3bc9Cjyay/ELYZ9UUpHLyHuWAm/3rXNmVsfKMijRvUcVNS3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(11063799006)(4143699003)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBBekNNc1QyZjBKNSt5N2V5UXFRUlhvd0ZYOGIzY244bG52cFZLZ2xNYlJN?=
 =?utf-8?B?TnJtZkUwYjdxeG4ydnYyaFNDT290bGNQUjVnVDZpQkdyQ1lDSDhYRko0a0U2?=
 =?utf-8?B?dmw2bE9EWHVBQkorbXhGdjBQc01OMkxHbmFmbG51MkdIYjJ6REZxWnZlMzhp?=
 =?utf-8?B?WnhlOThkYXNFSGhIUWQzM2NXQjFmZHZ5Q3BsOVBvRzI1K2pFOExtT3huTVhm?=
 =?utf-8?B?NUM5aWNjdVQ3Q2Mxd1F2UnhTbGpQVGhXTjA1QzZPY2d3cmtwbTErRXVuVEVz?=
 =?utf-8?B?ZHhNa0Y5OTZQcGxuYkhueGwvbXJUWGNoVUNuRGxJLzJGcnlKcVNHdWNqUjNw?=
 =?utf-8?B?QkNWaUlBZEVNQzVMM1JjVVBqQURGdksxZXRPWVp0cm9KUjlycmhOdDgrSjFR?=
 =?utf-8?B?Ri94ZzBDNkJjeFBBakcrZ3VGUDF3T3VQdUxPS3FqQkdmalhpTk1vVG9HUTNo?=
 =?utf-8?B?Q0xpRmpTWVlRSk8wSEFQa3ZlaEtnSHd6ZmtUTWR4NllyUjBIaDI0RU1TNDcw?=
 =?utf-8?B?eStSeFJhZFhMWXRseDVGZ0VLc0Fwd0NYTDhnZmU0UGhwWWVJQW9ROUVSQ3Nt?=
 =?utf-8?B?V1EydktaVUZsUEhqVkpNZitjVitBZmJ6bHNPR3NVbitzVW41dVF2ZTE3N215?=
 =?utf-8?B?SzdvVzVxYTdpcVU2cTBOTmdxeTQyZnRIdXRId1JLTWdPTHJrT0JBQUpQb3dF?=
 =?utf-8?B?M1RGaE8rQkJzZWhLb2M0ODBVbWtOYTY0amcybTRWMEdzMUtDams0S3ltbjlG?=
 =?utf-8?B?ajNDcEtCNEl0L2tDanFaTFkwU2doY3NPOFhHTSt6dUNsdE10YkZyYjRMM2No?=
 =?utf-8?B?UmRlZUFCRVN6YTVzTTNVaWttTDU3cDdEQXRVYUhmamhOL3JQTkJlYTJrMmpT?=
 =?utf-8?B?V2IwbGovL1kxQUNQY3ZlOURHWVk5Q1VySC82WjY1UjFuY1JWaUhKNmdYdGNa?=
 =?utf-8?B?dDdYM3NhRVhoVDhod3RvVnZ1U2pxQ3hzWVJ5UE4xVU5tSUlQU2lFb2FtMkQz?=
 =?utf-8?B?aCsralRMdzd2aGJHdG1zaTRSaTFrbndzUnFKenN0UndJSzRtQ2d1eGxpT2pL?=
 =?utf-8?B?SlRiVlJjenNuSUExZy9GbDFiZ3MrQmwvY3VLTFRXL3NJck5BNUdoUExRZVJI?=
 =?utf-8?B?MFZFb3A0SUF2YnZiYUR4YUxpQnIwS2wwUzEwTUh5UFVkNkVIblRabHd1MkMr?=
 =?utf-8?B?SnRNblM4NUl2cFBZdDRWYTNhN21wTDNEcm1XWWFXTVBjekJZbUo4T0YyY01n?=
 =?utf-8?B?RlNJcDIyb0pPWjRIazNEdXdYNUdGR1k4Vk9vcFpvaldjTHIweUsvaVlQeFNh?=
 =?utf-8?B?c096YWNIcEtlSTBEVWFaaE51OWUxZld0UjlrQ21GVG00eUVMemIrZG0yTXV2?=
 =?utf-8?B?TkFsT2ZSZ2ltb0w3dEVPZVVnY1FSSWJGR3BCa1JMc3A4RDVJTkI5akF2MjR0?=
 =?utf-8?B?VkhsNmpmVlQxOE9YZy82NGVNQ0p4Zld3cDU1RFRuajFINlhEQ0xXUkFIWDQw?=
 =?utf-8?B?NnZNZkJLaCt6bXNqaTBnbE1ldWRGa3ZURlVZU1craGVDMXAzZUU0b0x2NTFQ?=
 =?utf-8?B?Qmh2M2NjK0pJc2dQeGRiQWRFVG55aUJDYm1sV2crblpLOGFGOVlHNlZEZk5r?=
 =?utf-8?B?OFAvNmZka202NjBqMUZoY01URlRUMHByREZVQWZqWXB3Ylc3TVVVbVRJa1Uv?=
 =?utf-8?B?VFFnVXJrdU51THVWMS9kcTh6UGx3SXVPMUg0bFZuWnNFQ0JFYUt0dndYaVlv?=
 =?utf-8?B?b1A2V0hhTldDWmhXR1I5NElLTC9DYmtteTR5cllPSldlRDRYOFZQaUxlVytO?=
 =?utf-8?B?cjJ2blo3bG9zbE5ZS05tTnF6NTJWclNvUHF2ODFXd2tOaUk1eVRSd09VcWxL?=
 =?utf-8?B?ZklEZG9Gb3VWQk9nTGFiNnZzbXBnR25HZnZwV0tWT2l2OWJzcnRpSHY3MnVH?=
 =?utf-8?B?cUdUM2Z6NDNxMVFlL0I5YWNycitQc0IvNjJwZUlyYW5ablYzMm9IbHduTzZQ?=
 =?utf-8?B?d3Y4S3lUUGhFQlNzYmN6akp4UkdNbUxoZ1ZFRXNlMnFTV1dnME91QmlVcFZ5?=
 =?utf-8?B?Qk5McjBkVVNYVEQyWkpvZWZjTFZKc2pwWUlIQk0vaHdXOGNjdjBUYk9aK1F0?=
 =?utf-8?B?UExrYklTU1hXam9vTFl1V3dXbFM0ckRsRE9jdXd1enZwVnpSaW1SMEZUVFZF?=
 =?utf-8?B?MTU0U0ZMbk1oVktiRGkwbzVGQnkrTktTL2cyUkR4eXlnWVRiMktFK3M5WDkw?=
 =?utf-8?B?Z0N2T0IxcTVGMnhwMGV0VDd5R25QaTJUL2J0VjBDUFd6Z3g1eXRZTlpJTFVO?=
 =?utf-8?B?Q2tXSGFkVHZobkxRNWRub29TUGVMZmZpSjR0RUpSOWtJVldXZ3QrUT09?=
X-Exchange-RoutingPolicyChecked: vk08wu1ErcT93SahGDSQRM60/4L6/svgbWHAm7nfb+8GuQK3W+cygNuZcBBrlVikfPp0syD5FWpAjw/34pAtYt10nsNp99fWIYZYCzS/4kRYMBEOhxDAtBMHPIQTaaaW+REwtjNNeAO49WCiBzxz1rZ63Tkf893Md8fui/J2hg6TlLpXHZyHPTEU1rpp4qbo9BI4fS29OHpMwoZKn57OZHo54I5pVke7PAuNltr2QCaW7Cnaqr46P+dnKLqHGbb9h7lxMd0bKEW0Xz2Owd9Ktj+HK82DNjAZ9aWfrAhEayez6feM2Y+wBQ0YIdL1BYHuFlcTk+r7OYz79aLP0/4zzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c92126-6ffc-4b9d-a82a-08df3bc76951
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:32:56.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwqmItKNnJfSseiso2+2mxGLO0yAIIpWtKvyI4afXjboH4XfPPUc+YgB8mBJ/NDzTYXf5kg4gRPce86aW4Z5byp7KZhEwwxYDOjNiQIEKK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

On 11/5/26 15:42, Jim Mattson wrote:
> 
> In kvm_vcpu_reset(), KVM unconditionally zeroes the entire vcpu->arch.regs
> array on both RESET and INIT:
> 
>      /* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
>      memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
> 
> However, according to the Intel APX Architecture Specification (rev. 9.0),
> section 3.1.4.1.1 and Table 3.7, R16-R31 are unchanged on INIT:
> 
>    The main difference between EGPRs and legacy GPRs, is that EGPRs are not
>    enabled by default (specifically XCR0-enabled) in 64-bit mode, and their
>    INIT behavior is XMM-like; in that EGPRs and many other XSAVE-enabled
>    register states are un-changed on INIT events as shown in Table 3.7.
> 
> By extending NR_VCPU_GENERAL_PURPOSE_REGS to include VCPU_REGS_R16 through
> VCPU_REGS_R31 without updating kvm_vcpu_reset(), KVM will erroneously zero
> R16-R31 when init_event is true.

Appreciate the review!

This was overlooked since switched away from XSAVE to the VCPU cache. 
Initially, I thought okay to keep along with other XSTATEs:

   The specification deliberately scopes out some areas. For example,
   Sections 3.1.4.4.2–7 note that initialization and reset behaviors
   follow existing XSTATE conventions.

Yes, you're right. The reset needs to be adjusted.

Thanks,
Chang
