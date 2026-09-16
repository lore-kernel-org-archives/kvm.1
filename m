Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D981448E0;
	Wed, 16 Sep 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518887; cv=fail; b=jPLsdTL/j8AiKD9r/8Lye7uBzQvfUuwT5vUKeSF0Mf5gWjVQghgi4rjTbXjF7JrNpychhbtfiXXOkXovGsB6K9DJ/LuLZgucVYoERdiywBSWqKnaQAIj1IMwSacBvgGwEU7HCNF2FdMmQG5lmDHhx1YudYM4CGBMkp6nYcxOXnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518887; c=relaxed/simple;
	bh=2ZdNwQhKQ4EVEFftkTnV5yctCMoybQhtYCha6KwpfJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=njW29AgX0sBxXNuwgvSVHpKh+3i4KRMZnnAWlXOeyl5Gdf2/vq0yy6OHo8DJ5zo+8hOjHOXinItCDMtpwUEEHJkoAXg2afBJOLhuCKLV715K0UUrIFhCRmBVzBoFFlr607sAAgH6f0IFDvA1woQcfx2KrYbJU2TJwf/xH73sNWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVi3DzID; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVi3DzID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789518885; x=1821054885;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2ZdNwQhKQ4EVEFftkTnV5yctCMoybQhtYCha6KwpfJE=;
  b=GVi3DzIDaWNmwc4MQWwHA25JRbeKYeUprpd1jpHKkOXpULfpuUWtFgOZ
   +IwW4ZvRtMkFPST6xNrMVL+rBRx8rtHRc1RJ1tq/m2xeRa3QoUYcN+i6f
   ZJtgxWR6wXNjKI5856+udLvwOO8KpN1nM4OSY8zagWDSIJYkZNr01jIp9
   04x/mPWB0NY96pLrg6mqAgHEtLJKA3Ze9XM+6S1TKIDjQEG4vZpEDGix6
   wOJ2LRDtz4+eUmbYu0QEgSj2matgDAFgtfUMs5lW2hl03GBvmGE1HN0Te
   kFAuHmZlwHuqXH+7Y93feY/U/KYJ5muiZ1q9/pWWw4VUMZdk/5Nnc617Y
   Q==;
X-CSE-ConnectionGUID: bfE3+ujqSq6uJNyjD3YezA==
X-CSE-MsgGUID: e1u7tCeSSFO4Nh2fMDWSCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77453478"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77453478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:34:44 -0700
X-CSE-ConnectionGUID: L4Y7bG9QQHiiQzXJf74t1Q==
X-CSE-MsgGUID: sZLHJswQROi4Uc11ccjmbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="266960776"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:34:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:34:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:34:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/MbzmWFllfBDmyUIAHuFy6meeBqCyuTD8rzskn6zPlCvm7ASlOzqGTbdPE5Ac9M5MaMTn516zjr5SIhDXSP/wqTg4yb5vqwt8mo9whvjKNWAFoIU/++ycA6XBVUUABcKnyyFYN1am4ZVEmjbCisGwwcZfvqrS3B4dAV3aasP+c1yNcRZlf67xiK4N1EaUOPmBangbytf2YakkYmjHWopa4hIfzUZp+2TDYKuRorCUB5uAYjcUrSk7iUCgZjFoYUtXTXEIo1M8QgUqtZfCEUtboR2J5L+tOFyPRhmb0/5uKR+24OeIflvbdfvehR5shbD5yx6oHafsP49900qdZAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiIqSFq54EbAQRVswoL7VDcdVo6REYOVih8/U1h/dJ0=;
 b=cmThYwRGg3x6ho7/9qrxEtr9SKs5LI2er8x5u40yQWqrHqaYN7BLXRCbljE1g7rc4Fg2uIxLJpXypWMhAGl2i3TE87gT2ch0AChsDzJAjvrdd06WQ4V9YHjjBNclZ5mVqNkeowDwWg+dl34fEXCcztRweiKNxPCgzCL2kfvzgTbByld7SilB1tJkxeBdXKcvNGbsC0+u8zITBEk4oczVvotBfG6K1+BMBIgJnB0+Y8aRO831v2gcokVNEkcQWnWS05/ZjGJQwRf2lSGtD4ZhZmXlhtjNIFEYIaPYUp1ydhD0oN4MTUdLzRs4kxTMHxEZrWVLp7BI/FTkE6ZMD4rlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SN7PR11MB6725.namprd11.prod.outlook.com
 (2603:10b6:806:267::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 00:34:39 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 00:34:39 +0000
Date: Tue, 15 Sep 2026 17:34:37 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <aqnkHUg3o890LYFM@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <aqlRETiO58SWjFLF@google.com>
 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
 <aqnO6spgsfN1UsMU@intel.com>
 <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 368a68b1-3347-40b8-abbe-08df138a4af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FoJqkDmD+7oVhhXwi5RSMw8u7T2i0AXdeFt6/xNDDZFOesKfUkNsiyqCWESHpWONUkJngUmUdSrxbXpqxkPw0BQxK1S/fvgDwoC6Lz8SEO0vAQjS0t+aRDTt3Od2uX8SHE7cnAOyovYMUGsXBjz3qmtAPNldADoCoXUOQHYjF+ASza8FpSd3vlUyw/XzXcHJOwpBCMQiE6bf3jOfedlGY78A5s2RBmqzBxMCQReGKJ+8OTiGY+R5svkt9ryTIfZzsjBRjIVj6N80jomtaICeBv+eB659bDaF4/IfSXVjFXXhJZI7lzueZPn08gw9klIv3SzU29UqGNUIPUWchCCzMwljSelokB5TAJ4Rn2DF0kO81BBc+2c+Lwvz5H+pJGHHl7zRIEBnHfdy34hd8mtRXAMp7Y2PM14y+a8VNfo0yX7erJyPQeO9uXk/KUdPYAAhtFJknKk/rSWKgH1Ea1N+7cIOeMlg2d9zr2H2lQqXw47eshMQUzxT8v5eGR6MBK9SKb3YLnsC9rs6nHPUayxfkpFxyO8rDVqc8d1V6AuEJS9zhWWX9eD4FhQIjekHrxIXMmz8O32YBNV6A/QOQVAPECXCQg+QNuvjL3QFrtZnww977qp8RK48AmZj9XS4/jMcH/iZvVthIvQeA6guoWT7RfMHDmW/TdHGJQ+ygNmFTwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xBWlVaODRQc3Y5YkF2UkZ3YkEzS2VRa1F2d0k0ckhNZ3RMRTN2VysvS2Rt?=
 =?utf-8?B?ZFZObHBTTTZnMWE0ZWNMNEtZYlprbkZUZlFlRzhaa0xPSjVCQ3o0TnZSOUFp?=
 =?utf-8?B?emEwOEF1VWNCb1d4MmRvMVlWamVFZnhGYzFCVkJIZ3k0ajdzWjN5YXMwcjFk?=
 =?utf-8?B?akJqdGZOYW9maHI0ODhjOXZ0YjlGSzlIckthTzdFekZDd2RvQnNKbTd3MHd4?=
 =?utf-8?B?NVd1VDluM3oydnNuSE41SVFVaXE2bC85YWtzdmVKVWpIenBreWZGQ0lwZTk4?=
 =?utf-8?B?ZW1OOFdTK2hMRk9lRjY5b0RjN0pvU2lIcjRKOTY4REhHM2p5WTJOYmNBZHpx?=
 =?utf-8?B?VlNreWc1SVBLSVkzeW5SRlNWUUFqeXpEc3RlNmNFR2RnUEoxTGM0QlhuNjZl?=
 =?utf-8?B?OWx4eTd6YmF0eHVKbWJ6MDFOWU4xQUVYcG9hU2psS3N4djVXc1Q1cjhhVEky?=
 =?utf-8?B?VGN0aTMwREVBRWNjRkZuZElGb2w2RlMvUGp3MDIvVXJMallCSEJrdWNYVHhN?=
 =?utf-8?B?b0hvZHQzY24wd1hBUXBVMUlGYmVVWFYycGN3eE1ndjVNOW9CRW96bHNuVlZz?=
 =?utf-8?B?NmQ4dWVzRG1pL2Z3UnozS1JDa3hOZ2NHM2VWaWJ1ZlZ4VGxpVTJlZE1qN0VB?=
 =?utf-8?B?VkNTbzFsSEluNitNRmNLOWRtWnViUVg4QWhweUtucS9QUE5VWEp1bHpEYmZs?=
 =?utf-8?B?Rkhkd3hGTmJWTmFTcTBDVFBJWEpyV2xXZkhFZXJXZmQ3a2kySDJMcUJ4TGxh?=
 =?utf-8?B?TGh4TDRYdG5Obi85Uy85bXEzVlBxOFI5OUJkc3Uyc3VYUzZ2NkZlMnlsMFFQ?=
 =?utf-8?B?QU5tVnhQRU1PWEozL2t6YkpVSnkwL3lkNEpjdzBGRmswbmhCTkpIRnR1dzNi?=
 =?utf-8?B?UnNNWkQ3M3kwMDZoZWh1NTRuMmRQTkpjc1NLR1ZselZ4RmdOUGo3TDZqOHEz?=
 =?utf-8?B?aUdpSDZWdTN5TVoybG1aQlpUZlRWNXE2R1hnaExDRlFjeklGZVBNRlN4SFIv?=
 =?utf-8?B?dEZyUTg3M2FFdzFVcS9FVXFOalF5VmdpZm1sRm5RUmhSME14NXliNWtNMWkv?=
 =?utf-8?B?TWxHMjU2L3ViSVV6TFRMWkhFYjZaYzFPRXdOeTNydlJOcEY2eTZ2UlkvbUh4?=
 =?utf-8?B?d0FKeFZPaERCS2M5T2pmMEE2QS8ydmlUZ0NZSGpWZ2k3OTRHZFRnZktBT1hw?=
 =?utf-8?B?UCtOQlVBREJISDRuTUE4MGFUOTZ6S1NOZ3Z4Tng2MjdibGt6RnZwQkVZVnJ3?=
 =?utf-8?B?WDlhcWVHTU9INFdLWmtLWUlGZnoxcUd4a0pTdG1xblJXN2NMaEFqQWhFcEsz?=
 =?utf-8?B?aGFzRThXM2M1Q1ZJWVNTRDZKWGZMb0VaQS9XR2VFT0FkRStkdUNaYmFqMlA1?=
 =?utf-8?B?Y0VJVndpNzRKNUtnTS9jcUVMZDJVa2NwblMwblhINHU3d2dKR0lvdjMxNDdX?=
 =?utf-8?B?aVl5Wlp1QVJmaHdYS2hYWUY1Qjkya05Jb0taeEgzcWxpSDZINTQ3Z3pnMFhQ?=
 =?utf-8?B?MzZFcXR6RmtnV2M3ZTBpYWgvaGx6d2hLVEVPUHVVQmFGVVZtMVdyWXFzalA0?=
 =?utf-8?B?RFN0TlhDTEQrVjRjSXhYemxJc1NoSWJ2YmVHcWJ0VUlqQkJWZWxtYSs5Rzha?=
 =?utf-8?B?cHh3enR5ZEtLS0FZWFhDRk1UV3pSUXB3Z0ZNa2pFamVLeTltbmx5MXJiMFA1?=
 =?utf-8?B?dGNFaHk1dWpiaUJIY0ZMUDdwc3BscmJRZGdmTk0ydTNHcktXMWlRUDdSZUZa?=
 =?utf-8?B?THZUbExEZ0ErNnlGQVFnSDZvTisrMUxhb3NKZWtNamUxNWRGRzRmS0s2ajcy?=
 =?utf-8?B?ZHVvbU1IMzdtUjVYOUFRR2VTaHpxRUdmTXpCbU42a0ZXbDc3TXFMdnRTSWFC?=
 =?utf-8?B?L0RkcnhhKzA0YmtsbGRHei9yd2VCL25qR1NaSEZRQUJNVDN6R0NyWDA1VkFP?=
 =?utf-8?B?S3NWRElZMTBUSlNBYWdsWWxySEROcENrRHBjZUxGVkhpUHdvMVBZc3lmMnVa?=
 =?utf-8?B?QVY5QisyN2pxQ1ZPcDlLUjBjUHBUNExIZlgzQXpNenpyK3lrVE1uYlB4bk9P?=
 =?utf-8?B?am9mcUZHaThvSkVrZVJZUlhyZkh4MktJZ0pHZ0F0K1hNYTd6MmtjVjlQSnkr?=
 =?utf-8?B?bElxVzhKSGR3Y0FHdXIwNHJxRkVqdVZ4WjF6b0R0YzF2Y2xLaUZzMzBMU3RU?=
 =?utf-8?B?VDFrSEhtbnpUalZhUFZlTXg0UklGbThqN2VOTzYxQXBDVk1zbEJhZDAzc253?=
 =?utf-8?B?aUNVVUIrVGJnMllsdVFwMjl0bjk2Y2RSbkFMdnJ0WGNuWE5QVGU1clFTZm14?=
 =?utf-8?B?UHJ0K3JpRkxvaUdMM0R0clFhM2VsL3JJenVERlp6TDhhNWcxWEk0QT09?=
X-Exchange-RoutingPolicyChecked: pICRoiqNvHCqtzEncUf0uoUVWsKYdlUGnZmZo5DCuJjNV1xxAGJ/EHnv98VVqRDHHwbFh/MLXo/7g8pgVITprwQor5GhZiBigw3CXHeaM9Kj6ibk2XcWF0Iyl2UPM/O8wihfnvhp4ngJXCeYRYzXBJE2iMc6i2tkBWH/2ojnkJrp4oDRXwGHUmVKQu4R2GPCYkTx4794dhAp9Fnqd1UeMuu9URYVqx+IVIKhJGmsLdh0v6o5MsDDDXWVy4nqVEB8UUUAmW/Z8sgtL0wfCNTm/Ie0YKsRu93V/VVd8jLhJzNSl4eksrAqFm/xjwFk9N90YGX74O1UPuOmZHxynVU1IQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 368a68b1-3347-40b8-abbe-08df138a4af6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:34:39.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcmbadW25oGh3wfhhVblPdH3DddGhC8AT8PubGeyXbksr1Dsgnrki9rsS7jYneU3jHYUpXpMM90UJbaOAT+e0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 05:06:14PM -0700, Edgecombe, Rick P wrote:
> On Tue, 2026-09-15 at 16:04 -0700, Peter Fang wrote:
> > Just to be extra clear... Patch 4 added this:
> > 
> >         if (quote_size)
> >                 /* The reported size does not include the buffer header */
> >                 len = TDX_QUOTE_BUF_LEN(quote_size);
> > 
> > And it is about adding the GHCI header to the buffer size. So if there
> > is a design change and this header is no longer needed, this line could
> > become redundant. The macro might cause the driver to allocate more
> > memory than needed (up to one page), so things should still work and we
> > could fix this up later.
> 
> So this series uses a new ability to query the max size of the quote. This size
> applies to SGX quotes too.
> 
> Depending on the DICE design, the guest quoting code may need to change. Maybe
> heavily. These changes could touch LOC in this series as well as other TDX guest
> quoting code. But the code is still correct and useful based on non-DICE
> existing quoting.
> 
> Is it all correct?

Yes. If a new TDX module decides to report this field on a non-DICE
platform, this code still works [1]. And quotes in the DICE world will
continue to get larger. This metadata reporting is useful regardless of
how DICE is implemented in the end. I wanted to be upfront about what
the potential impact may be if the guest did DICE differently. The guest
would still need this reported size from the TDX module.

[1] https://lore.kernel.org/kvm/apsxN4jYe3G3meNz@intel.com/
