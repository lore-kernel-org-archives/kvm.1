Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B2272801;
	Wed, 27 May 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859421; cv=fail; b=cKSlGIkuKnxprazstfWRrQsQMeTA0TsgHW24Ukf04aOfX6EwdwmGfaZr5jwW9blEWCn/qVPwe00LocwqZoJrRJnF7BykNbrVBvSDdmBgHb4AQRSQolUUaE6s4niLauTH63V+vP+HnOgYoe4VmKCKUl2wuoL7bw870vquuZcHAdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859421; c=relaxed/simple;
	bh=E/plLYU5237YfQafR3No3BBUOwkfcN4j45MQjAtAccA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOCuQJ3YokQ2ZX5SUnjrDssQ7J+Ao4+/tj5bCaOWTeBAeV0DCYlRJ4p1FoCGGtXszqc+DjETOYzA4kixGyMVRX5g3sbWcqpEml43v1CndRMR1ExmtBGx7MyL+gpsyE8K2gBfb4DlswLLs9WBVzbq31m3pAk2vr+yax/V84hmrW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFk+I6bN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFk+I6bN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779859419; x=1811395419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E/plLYU5237YfQafR3No3BBUOwkfcN4j45MQjAtAccA=;
  b=dFk+I6bNT7fh51y3v5rZ7fCvR3k83n6yacG4/vUqvxQsxpKx8zju8mhF
   RTSPKqhbFm8cn5s7U/RVjus7BUugApQkQ5PD1E3LjUbg5IffMSXHScJ3T
   ikZmERvI78N+dYe4ykQOezJQpcXONabyuZRlKFU9mTHZ+KHlWD/MTFTyY
   R2sA670xeMykhniiXG9VMSFrPS/TFQXjlDVM2ycxR5fEbIEHvA39hoPqw
   4vCB74TrGpdgIEI5eCKkZ/M7C8Tjo7+C9C6ulz2RsiVw5W1ndTezRLem4
   TvT47AZN9DNSibVTC0Pq4oICAJtEoQ+lZfHy5uoDXqcdzgX5DiJ+Mok8+
   w==;
X-CSE-ConnectionGUID: p+MWmyqASc+Btr1eyfye4Q==
X-CSE-MsgGUID: RCXC7Ya/QRqyu+/93BGhOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80530924"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80530924"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:23:39 -0700
X-CSE-ConnectionGUID: fqP5Kze/TgKmQoj7ZO6bFg==
X-CSE-MsgGUID: TcEKpyIUT7O4+Z5G/mv41Q==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:23:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:23:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 22:23:38 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ4ZtEVqbiQYBqN5/fX9b0kq2lU218atZSvq9iSoI/ZfTD1ilr5CRX6B4tsu1pbF81gkZntyhs1z3KJEgOnuautMhwHxV1vbDt0y0+zdipJGIWIh+ToH5VC1aw5QCMJ+cFpWzJOIoc887E/OfKSqENgm7U8Sbr3rWCJv1HxjHcO5XlgJW8mDS1CK125DU4RJWBP2DiTWFv9Qc9CKlG96I2Vq2E7GLy2INLfCa4ThYdc8/iqZqLpmfS9azqiVuJBtaLqioGckFHdjmj83MSYhF8cLinPCVaqOQkodQPUTBVBK+P/os52tzy5MArWbSEmqxM4n+aIEirQWZARFUfOp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0feH+pT6qIql6qWZRgC3JZvo2/38diiOwmX1XmAV/T0=;
 b=RtJ49mD7jdoHSVpkRiAK7Cw1UUTRT+cAyj9m9PRhkyPrUu12nM3a/pQEyzLYEs9xLY5jyAvzdPZpY/DxRqEbxfReQFGlJwiCiFoJIMsKhlcjNjzqLppxtEsr/l+0HIEJzYN8ps/5Nwt7K1pkKlJIXoDkiViL/IyyiPwP3BCojUMX857DISZ3M4sLbVR7WwZTIU9oNfhM2fId3YMHvmRs9hYriBQ6QuWahJ0icBl/0sJupZjNizh3MOVCtsFmORtnzXzX5tqrV2iDAxUVX+oTiYqiMpaMDe9r9Q0Nb9K9ZL9Jmj1Im5+f96UrKAqqwwpabaWmt+9o1MMicQ+dVw+n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by LVUPR11MB9568.namprd11.prod.outlook.com (2603:10b6:408:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 05:23:32 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 05:23:32 +0000
Message-ID: <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
Date: Tue, 26 May 2026 22:23:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|LVUPR11MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: d1934988-332e-4394-dbe8-08debbb01806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|5023799004|11063799006|6133799003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 63BWrEN95j1sbPiDO33ZSYp8E1pcV+uQOtYOxSpEuKldQNXwMTVe4mIMhaXMvR9luspFwOPG/cuIX227OOs5YTewm0Pnpcr/ceWGnK8YcbUgUI3pt3JUl4j5vhQx9+VewiBqp/rbtjTO3RU1LGvw3xOFksP+rtAotD8tUJQmvthmrJSQjhmGhk6Ib5Qpq/Sw/554SiBjXP7Vf1b6Gr2NA0xP+FSK0s+ZMvZoahFaRP6nfW8081UjPYeE2z+qiTH5yN/Vy09WpToF+OC5zZzxTmmhc2LZCXNfaOx4jj+MEHRZGG24ZPRtpupgXKUC9DITK/4hzzw5d72SgrajglEhnauQlWnPppyaooIyv/x7yAlFVeyqJ3vOZkk9e87np089m5fsf0yZjAg0M78UNYuEjx4mvUe0PbIjrt/RtbXgbbw73BZc/VXMfzsQ0z7ji/49bvbEud/Ym7dDNyVnzkKCUGq0fy7vzQo4zdSATomzgaW+FMaSEFh37tY997K34pMNJ1QPlE2KUebuJ286SQC0hKKQ5IQYvq5W1Lgd08e6NRm+Hd1hDGlaAdwU5gt1oxdVK4szXjsMEBUje6zb2cokeiOwcbeA4uMbby+qcFKxX2HDHC4jUGAdu8n7LmM+hSg6HxcEjXL5kllsZVLma9l5m+vOqeHkpBxxCDq1ZtVnrx6T+Od/qUMwZ41sEpU0CaHf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9rakZ2NDdkdi93a2p3VUhMbTZ5MXZCWUFrWitpczlWZnlSZVhNeGUzQW1r?=
 =?utf-8?B?eTQ4MCtQNU8rRmNNMGhHaUNoam5hNzR6L2FpUjAwWFRkQlhLWVNhbWNWcjRF?=
 =?utf-8?B?WWdKOXoxNTdiS1NjMHZncVlkQ0xKYTBRbzdmN0kvbmpXdk5MZ3owZ28zRmp2?=
 =?utf-8?B?T1Ixc1g4TnVUYUZUVjFZb0ltRVRtUS92V1hQVGNjRDc5V0dRK1ZzRU1QSlVt?=
 =?utf-8?B?d2htNkVablE4VWMzOUt6MlNEVTE2TEtFR0o3NVRlMjg4empOZlBGbmJ2bGh2?=
 =?utf-8?B?TkgzOHNNYW1VYmVncTM0QUFpY2lVdmdDS2hFTWZpQVNMN3RhVUIxN051MlNF?=
 =?utf-8?B?Y2Y2WTI3RGxEOFA3UXZ0M2l3Qml2a3FUdEtqcUJLVVBqN0I0WVdHbnJ2bVpH?=
 =?utf-8?B?UGJMN3h3S2EySFBjckVXQ3V4NUozV1pPZWRVRlpEUU5iR0RWb01xQkptZHIz?=
 =?utf-8?B?Y1VuRVduNEhXZzVvWDZNbGIyZXBMaldGTDU4UE9Ydk1ZSmI2UkZjNzFUaUFK?=
 =?utf-8?B?a3ltQXVodElQMU5rdDNHdHg5Q3M3LzNDbTMvdkJBZkx1SGc0TkltN3R5QWpa?=
 =?utf-8?B?ZDM1cm41bTl3aXNVQXdrNlJLL0R5NnhyS293akM0VUlOd3BQbHc5WVQyRUZ5?=
 =?utf-8?B?dkRTdXY2KzZDQTdYL0lqN25JbGxRY0dvdXpiQnFvZkhoL1A0Y1kvaGhmYm5i?=
 =?utf-8?B?dWlXM2wrTHhMQkRnS2doRGgzbVo0MjRORERDZk5QTmxHYmVXLytzaWh5TkdJ?=
 =?utf-8?B?dGk2WU14RmM0UWx0T1hLcDA5NVdYU2U0cEcyQk0vdmFTUTZYa3pxY1VJSlRn?=
 =?utf-8?B?YnFsSkQwendydzVPdTFCY3RoU1podjhpbVJ4b2RpK25mU1RkYW90Q2k3dWFZ?=
 =?utf-8?B?cEdna2l5a3JaK1Z3bjNkd3B3VDczdzZia2xtc0w2aXluNndvZWFwSVdNbGFp?=
 =?utf-8?B?aTNvbFNOc1lIcG1KWUJIdkdwVEFkU3BXdG8wcmZHVTZoYVZaMmRPUXozRUpn?=
 =?utf-8?B?NFFpeDhsQ1JLbEduSmhmYXRvMDI5RFN0Y3E5bVRma3NxOHpqMlhqMGhjL0lu?=
 =?utf-8?B?TlQ1eVNwZ1BQK1c0NUw2V2xDaWg3OXlRUDh2bGhJV29RQTVZZ2MvaHIvVDBn?=
 =?utf-8?B?ZndjVldqbm05Y1hkWklUWHRxSVREM2NrMmh5b2dVZi9Md2puTzRLeUpiVUl2?=
 =?utf-8?B?Yk85WDV0NWo0WmFJY3pnUGw0ZXBVSlhXV1ZiMGRoSUFsb2xNenhaUUs5RU9C?=
 =?utf-8?B?SjFMWTBMWWhhMjhadnhjd0piMmE0T1k2OVFmVFpmTFhPOTYzeU1sK01RRkpo?=
 =?utf-8?B?cWtxdFgyaC9hbDl6RUR0aXkvWm1XTVNJMmZvcWxRMmdpcTRkTHZPb2JrRGVZ?=
 =?utf-8?B?N3I3UG5lV2dHQXZvY2pldHdQekpLOWptZFFRQVJTVkVUNUVWME1IMlhXYlIz?=
 =?utf-8?B?cHlQbCs1azVlbjlqRXN2SmkyaU45SDk3UXRoN2J5RjNZZmphbWZBTWRjUDdY?=
 =?utf-8?B?eEJqdkJ4Qlk2U2VFWGFEb2h5Y3NrV2FUY0RkbDE0VmF6OHFIYXZOUEJ0K1Z5?=
 =?utf-8?B?Tkdvd1M0Z1ZvT0g0Uzg0bENUdjZUanVPV2p4UEZIazBWSE9lUnFkSE1xYmph?=
 =?utf-8?B?dFdjRWJHRmhLVGE2cTI4MllhYi9WV1NKb2ZNbzY5V0dST1ZnY0FPSG5WWEta?=
 =?utf-8?B?WGd2V0J4MW1XekZnK21qR3kyODd3SFROZTdHbHZrZWRGWUFVYzdFME1Va09Q?=
 =?utf-8?B?dmdncFNpTXZyWUorcU5oclJGczVDYlUzMGNUWDdHSVdMZnBHQUhTOE9oM0tm?=
 =?utf-8?B?RytLUXlsdU9qQnEzYndlbmVKU3R4YlJFVXZTSkpBM3IydzBKaWFjOGJQZDhG?=
 =?utf-8?B?bU1rMkUyRHptOVN0RjgzdFI5M21NZmVIYkwvN0hvQ3dKOUZpTjI0c0JtL1BP?=
 =?utf-8?B?cVdZcTZqTjhEWFliT2FuajFOQS9FVm1FSEJiaHJwSTBUNmNqczBPeHBXQ0VS?=
 =?utf-8?B?SE1SVlNpbjJIcnc3OEFvQXlqNTRDanVSQXlhL2l2U2JQaGNNZ2t6b0ZVM0JI?=
 =?utf-8?B?cW83TE9iU1lkRmJKVjVIZVFlSWkwZE13dTNBNStwYXZ3aWQwVnREYUVNZWpu?=
 =?utf-8?B?NXMzcDgyZ0xaTGZ6VkZVUFplQjJCQmE0Tklid0NxVGxXWW9LK1lkQmp4Qzl6?=
 =?utf-8?B?eWVQK3hSM0w0MjdoNU1XcDNjaGtaaC9RaHFmMGtVeGNMQitGd1cyUWo3SlhT?=
 =?utf-8?B?SDdVY0RGSFp0NC82N24zMllJWTNYcHMxZ0VwdHZPdE1hVmdRajlUNVFHM3BL?=
 =?utf-8?B?K2FnVTBlWlFqNEhHdWpwSHViZHZVVkYrQmZNRUpGdCtnamdyUE5vdz09?=
X-Exchange-RoutingPolicyChecked: PcJl5McKiBRf/HoFOBLnElcKAnWDlcEOqz8WxVOutkZJ/4wdAX95SbASmriFYn8WmFymz8Lufhez0CGFWJwjrHZNyyHXd1eMjgklxtZ1CKFE0KP6guxPaKPF9IXfSvn9o+doY515SbDviUlB4AGepAiwqG5ZqAx9tBjKs1mVerjVUnjzYz++9t/hskWaC0pfvJx6A+rsg61zhZdEFfB62lsErpvxME/5+je8QhrkEmHdiz1fCFaldJim6a2TlB4uAQnQOOmSRRUAqeQXpbL1hmO5rM7agAtzEIirkI+uw/Ms924WNNJHzxYxTjCrp5A4YNHZrYTDGBtkxSnJEUfT/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1934988-332e-4394-dbe8-08debbb01806
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:23:32.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Osu9Jp1GIeYW6VcW2MDUUQgAnU9/IptKKGEN20xuv0hLJN218rOeQNKpX9fpYzmSMHxji7jzxyFNVQIdJppWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9568
X-OriginatorOrg: intel.com

Hello,

On 5/21/2026 8:41 PM, Xu Yilun wrote:

> The first 4 patches will eventually need an ack by an x86 maintainer, so
> please review with that in mind.
> 

I am looking at this from an x86 reviewer perspective with limited prior
TDX knowledge.

> == Overview ==
> 
> TDX Module introduces the "TDX Module Extensions" to support long
> running / hard-irq preemptible flows inside. This makes TDX Module
> capable of handling complex tasks through "Extension SEAMCALLs".

Can we explain a bit more about why these extensions are needed or what
would happen if the kernel didn't enable them? I ran the series through
an LLM for my curiosity. I think something on the below lines might be a
good addition for the cover letter itself.

(Please verify)

The TDX module's normal SEAMCALLs are designed to be short,
non-preemptible operations. However, some newer features (like
DICE-based TDX Quoting) require complex, potentially long-running
computations that can't complete within the tight constraints of a
single non-preemptible SEAMCALL.

The "TDX Module Extensions" solve this by introducing "Extension
SEAMCALLs" — a new class of SEAMCALLs that are:

* Long-running — they may take significant time to complete (e.g.,
cryptographic operations for attestation/quoting).

* Hard-IRQ preemptible — they can be interrupted by hardware interrupts
and later resumed, so they don't monopolize the CPU or cause
unacceptable interrupt latency.

Without this mechanism, complex operations like generating DICE
attestation quotes would either block interrupts for too long
(unacceptable for a host kernel) or wouldn't be possible inside the TDX
module at all. The Extensions give the TDX module a way to handle these
heavyweight tasks while remaining cooperative with the host's
interrupt/scheduling model.

> 
> TDX Module allows some add-on features to use the Extension. 

s/Module/module throughout the series.

The existing kernel code predominantly uses the lower case TDX "module".


> The first feature to use Extensions is DICE-based TDX Quoting [1].
> DICE is an industry-standard, certificate-backed attestation
> framework that layers evidence through a chain of certificates.
> 
> This series adds infrastructure to enable the Extensions and then
> implement DICE-based TDX Quoting.
> 
> The Extensions consumes relatively large amount of memory (~50MB). So it
> is designed to be off by default. It must be enabled after basic TDX
> Module initialization and when add-on features require it. To enable
> the Extensions, host first adds extra memory to TDX Module via a
> SEAMCALL (TDH.EXT.MEM.ADD), then uses another SEAMCALL (TDH.EXT.INIT) to
> initialize Extensions, and then some add-on features, e.g. DICE, could
> use Extension SEAMCALLs for work. Note that host can never get the added
> memory back.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.
> 

I think enabling it by default on TDX platforms (with the module
extension) might make sense. But the explanation here is slightly
confusing.

You said earlier that "The Extensions consumes relatively large amount
of memory (~50MB)" so they must be off by default. Later you say that
"..the saving are little .."

Are you saying that the dynamic enabling of the extensions is not worth
it or the dynamic allocation of the memory needed to support them?

In addition, could you briefly describe the complexity we are trading off?

> This series has 2 distinct parts:
> 
>   Patches  1-4:  TDX Module Extensions enabling
>   Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.
> 
