Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712C4779AA;
	Thu, 11 Jun 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198211; cv=fail; b=ugkLQfO+DEqQa8IyRUVZV3L6zsy3na8x8m4pRK4/O42ru5ao3t07EmDnl9vA3l1RjFFKopjIbwRGutcrK8zrfWD4ao8+zT2CP+JdJsVLaFYJmcX55v0fugWBj3XDwxC26c4j77W97kxCjBuHXFOYMab0BumWte7Psw9AVvgnDzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198211; c=relaxed/simple;
	bh=GITiUPRsm9npITZVEssmrRhFMABKK7pV349CCXZTFoQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XMXLCeFBHvUI/ZsIAObDxqzZO4HgkwgjUBmgd4vsjsJhMFCmpi/MNfHdc2uCSxHM9PdK8cURLR5bL4rZZGCzso2IhBqE/xM+G1QX4/tGHk7YEx8C3RdXOD4wI1SRJsP8PadHUl9Su9WvzJYghwG3Z7L7vaqOgZ0fc+nxAvCfn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cU72azPq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cU72azPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781198207; x=1812734207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GITiUPRsm9npITZVEssmrRhFMABKK7pV349CCXZTFoQ=;
  b=cU72azPqA0pmWxy1sAWfUs3GQQx1q4+8vP5BsxmakzK6kHdKb9qjAWWS
   IqQAxF+eji4PC8R9/txLw0jcW160reQS8Wt34Oe90sWO3PrwD1aDO4Niu
   DJFtX3oSIWJ28HStlzgwoGJs9CvlUPY/GUiPaGQMNCDfjqDTFeTf7AvOb
   UVVpu6cBIXCQuiB5A1XEbmbqDmwQjxP4qnI5T5LDhlMpnw285hsOCtnbh
   UD4XosWEpYjXIC69zA4izxe7BV4shOWfitwyyDBeHGHvnMSQWHcxvUgW9
   Dm+1VMPkywlUeZW5ZNzAMgnxp4bJBuvLeXSTaEhr58/dw2NFQk2pDvBJI
   A==;
X-CSE-ConnectionGUID: WVJl6rkzRG6mYihlzVZv/w==
X-CSE-MsgGUID: qgyrVohTS+KSX174P2oBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99594689"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99594689"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:16:46 -0700
X-CSE-ConnectionGUID: FlNUnFYfTDiNOlTxR1PIbw==
X-CSE-MsgGUID: WXLOjKvYRxy4/tn6Th4WYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="276735197"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:16:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:16:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 10:16:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqTInOOw1+3NRmh8ZTxtKqtzjRF8g3W4CMIrtjmn6NBhUcr+i8S4KSzm4il0VwlI4XNT4RN8h5+IsLEpNhpUSBdDCi9f9DXkNtLiA1mzFv4IerdnUWQMccQukBFy6DK2U/Xv9FXW7IiF/0KRUxGVdhi2mdG3WSCe0odi5Dtyjkyh2SCvf7q5PHJ4wLtJxQEEMFPcw1CQRnnLRfPdFHDdtdlwc0zVWRRLWgU9UsNAAm3GpIxJAKYDpt9CZP/Nsf0Ni7fvcSUX2QVp4MP109OQ7rReOJ3vFARjCk8IwGIz1plp/6H4ntKl9PPsHhbvWnUMoVo2oaRGdWBhjuhxve4M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kbbt6HHUhdBrrH7K2BEHSabjTzJKReZzGDd0q5ihAo=;
 b=xnkltj4txD0Kb9zRbXqvVqS+YrU1VZcCyrrHcSAEPVaiZra3akXBqVneiExebKLpKk/8v4A3AQ5u/0rUOV/yROeKxaHVRKVyOB+JxhygNus2YNXhu72QL16kvFzhViPNsyiqUDB66at9ortF2or5TD9YzHnQ5wYSL1BNkMFEPVqCxlbmTb9Ur9qUFiZTGi5Xh9Qp8Zrqqr3G04e8Gs//A2Wv1klOIHzKERiyVSMgy4gGDGV9+BdVgKq0zogyiJ+vYQ4OKOiuTzerXuMz2kAxuWD2JX8lKBS1wB5ihw5BoqE1Ul4Wfl2MeowIEkIX3LSYM54J81pproS+nMzldgHlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Thu, 11 Jun
 2026 17:16:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 17:16:43 +0000
Message-ID: <5f9474ed-bacb-44d5-a0fc-5a29a1e79b60@intel.com>
Date: Thu, 11 Jun 2026 20:16:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/15] x86/tdx: Move and rename Quote request
 structure
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-11-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-11-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::30) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ2PR11MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e8061b-1a99-44c5-a25d-08dec7dd358a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C51CWF1sQa0bjQyn3P4bUHMah/ZyxHyN2MURWC5inm1foPLFL7LtHJtW11mH5bW/5fTwOKDzHfVQo0NuDefvm8aeTrBbFbTJ753mH+OhRPuWfJJQIzKwSaaCty+hTglKwuz3z/zVuhVtrWQSGsKn6UaHDXnpB90lqLeUx0ozdjsSurF/wYbV0seHOjJJhsu6/zh2F1b+wSd1xi2BqAzuLSBJmuFBWIbAPKBXKsYByVnFz6Jo4cNeK7U/lNX6AUDxx2cBVRFjEpGKqcjwsJpv2w8lmiH8RsJWcun+M6bJYmCl6IQR52nrZDLX0WtODEQTwHQ/wAtZPc6sNAKPxpvR6iJd9+LsfpLLQqjgI0I5XvC1xdRa37bk7ZABl3xve9k53NcY+dKcujViNDJWq0t3hJLv6/ZSzXBFlQripIC2LXe1T1czOlLOjPWIkSKvQcsrJnTYfN1KKWgcgLXOWDOxR7kvnbdwcLBe12cENKTT873lD+iGLODeb5FXq//xfzKaF7V8W2AKGkBGpBi061IQTWTKV2QBDhi0bbRJd6Jcz9YP87aHdW2F7Fp/1Z2SKaWhALNyEhDEFaoYZNoU3aSUprAF9iI2icxi31BBWQO2pa79oeQ1cCfEXZIpVryeWyOJAsVqf68neM5/uIdLdeNn0qmZIFhkZGwMu5/OfTLZyUzREDu7xboRPChXK10bS3mm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmo0ODdHTTJhZVQvSHAzS1dOOHEwZi94TGhYbmVBK3BhbmRHL0dHTHRjSFdH?=
 =?utf-8?B?WENnL3Y2bExacWY1NGh0dDgrMnhueGI5cnZGemxIUHlZTDNjR2lNNjNSRjh6?=
 =?utf-8?B?enZ0OVMrckZmbDg3VjNDUFJ5eENFaGxTbksyMDZYa1VHcXk0REYwZ3Voczhk?=
 =?utf-8?B?SjBzNlFITFRQL0NPYmJYM1Fxb0czd1Q4TDBqS08vcWZueWhEV3oxRWJCM085?=
 =?utf-8?B?M2pjWmJGbzNtZE5HZy80alV0MVd2Wkh1U0s5Vjh6cndZWWlrUys4cG5SYytK?=
 =?utf-8?B?QStGUmlkQjFIVEJYUzZRNW1aTlA0MFk4bUVEZlN5Nm5pSnVmNHpQWUdlaWNq?=
 =?utf-8?B?SjFRdGJjN3dhZUxaQlhZY3lsbWlLWitTRzVZVzF6d2l5Z3dFZUc2Ly82S1pU?=
 =?utf-8?B?N0xvRFEreUtqMiszYU16N2JjN1V3REJkUFhRQ0RNSTRYU3dIVTYzcmQyMi9G?=
 =?utf-8?B?MUxsek1pZGQwWWtYazZzaE1ORm0xZ1R2WHhlOEg5c2pVUE5lRnlJVU9uY2Vr?=
 =?utf-8?B?Yk16bEE4N2d2VTdkRXpLdDRiVER6RHBhQnQ3U1ZpMmlZc0lYR1gvc0pKOVRx?=
 =?utf-8?B?V29TbmMzaFp2Yk1qT1gxeXM5TkszUGZVMSsrdXNTSnFKWXVBeHZ4NjlRVXd4?=
 =?utf-8?B?THJ6UC9EK1FmZXBMRHZkTWVHSElRakd5WjhFQktzS0xzQjVoN0llSVR4OUxE?=
 =?utf-8?B?eVM3RlNUdXJXNUx5c1p6MytPbjN2bi9ETXAzZzdrZWVWc00vWXB1WCsyY0Jh?=
 =?utf-8?B?bmFhSlZ6Q0JEVVg3MDBJNFI5Rjhqakh2VWVUNUxPZmZ1Wkh2RW5ZTUI3NmVV?=
 =?utf-8?B?ci9VSmxGQ3lVWmJLeVBaTEpqd29tWlNKVVBRQ25aZStHeUYwTkVPSTVKcjV1?=
 =?utf-8?B?UXk4bGp2UXFpZENTM2h4MG53ZmN3M1dWdXA5QUlVQ3lBZ2YrWnZtOE02VDEr?=
 =?utf-8?B?aFIzNXVvazZhb05SMUhja3diL1hNQlVvYzM0R3FOdWlSMnpXVk5SUWtUR1B4?=
 =?utf-8?B?ZlowSk1CSVBFc0JlZlJLOGRYUDFIaTltL0tHUXpHUE1TeHNFQVNsVzVDRlhQ?=
 =?utf-8?B?UEJDWStaZzN1Qlh3MHRaajRXOTgvYkJWZFo3L0tXZXJsNnU3TEtDdHFzZzVv?=
 =?utf-8?B?empaaTVETFhhTFVjTy9qZWk0dEZvOGdkU1VUcjE0UzVpZkJyd3pjL2E4QW55?=
 =?utf-8?B?cWZJY3Fwd2pObmhIYjRjemx0amZDa2ptWkFIVk00Nk9MTGRtUVVpRGNMN2dG?=
 =?utf-8?B?bEZLemdta21aajFlejRSTFNLMkNwM01GTVZqNmRkbWpaVUxLRmtCR0NsdFlO?=
 =?utf-8?B?Wng2anRia1RiOFB3NXpKb2RIVUVpYmdUSHZwNzVhTk9CMDFzQWJBaFFhUS80?=
 =?utf-8?B?UURDMG1LUVovbEJoVHJtbXV0cnZ5Um5wVGtBcW5acUtuKzQ3elJ2cUFnQ2No?=
 =?utf-8?B?UDZCS2JHUGQ4bGZOMEpPR3VZZmtVOFE4MVVlSXc0Y3ZVeUhaNlJWZ0xrS3lx?=
 =?utf-8?B?YUtxVERKRGJpckhNUjYxc0RKL2txbkRGVTFFQlNpSG9NQVF3SDVxNWVkWUlH?=
 =?utf-8?B?QlE1blpCUlU2aGdIS1ZWSll1eUdxUHRpbE1sQmVVcHNSVCt1aDVobWtVbXN3?=
 =?utf-8?B?RU4wQk5JQmtuS1RoZEpERVRFSk1jQUp6N3djcDRRZjVnRlY1SzRMcFowQUEy?=
 =?utf-8?B?WFhQcm9KZU95TUNubXpXVW1ESU9GUEc3S3FqRjVLR1UvMS9RZDVIeWxBQ3Nm?=
 =?utf-8?B?Qm90aDJZR0JnN1kvdWt3L3RoNzdjYnpXNWEwdXo4eHlUOUNDNEM5WEFRcStQ?=
 =?utf-8?B?N2RNRHdVbjlpVkptcVg5N0IzcEZtZ2oxMmFJWUlLd2VKKzg1eEhDdzJwVGtU?=
 =?utf-8?B?QUNuaFhFR0M4OXZ5NWdHNUg1Zm9CMDNMMERTTjZzaDNQV3R2eThOcUR6dGxa?=
 =?utf-8?B?MWlLN3h3RGs4SnVSaHRiZkVEMEFmK210MUMraEkwRU1kVkYwdjJkcWgyR0Yv?=
 =?utf-8?B?SUF6L2tyRHpBSUxIZ2cwRmtZWUVBVWh5YXBXUnNHeGkvVlIrK01MOXo0TnRH?=
 =?utf-8?B?SWpqaG04R3pCbE1ia2xncDlTNnVuMGx4bE9rTllYczNpRy9wYXJDTkZVUUxW?=
 =?utf-8?B?RW80Z1ErV0MzZ05RR01BcTVDR0lLaElrREREVWM1SjR5Tmo4U0UySmdIV1dN?=
 =?utf-8?B?bVh5S0N6d1ovcmFtcHIrT3RqeklkUklOTm1jcXJNTWJjbmluZWZienBacnpW?=
 =?utf-8?B?aVpvbEhrZ1FOODZRSFgram1mUm9jVG9CdUtERmd1UWlJRjFUQVlUbUFEZ3JD?=
 =?utf-8?B?UkpVMWdRdmVGbFZFcnNIRUxFQVpheG1hZ2pYcWRQVTlpbHc2NGMzYWl4T3dy?=
 =?utf-8?Q?bS3kLG5Ll8A077Rg=3D?=
X-Exchange-RoutingPolicyChecked: oXx0Dje6OKFV/b0gRkGznzKrCDrrtm4srFKewXznnc0JDmWCmcD8Fxq7ixvDtGCVy9QWYv+1T/l0GSDGtF0qs0zzseI6zTcRP7E6hyIoq96ll5WGc5lCAP8qTm4WEOeVhmPTcraxco1hV1mFgj15vwMI7M9g32HMn6CJeaGheVQAlns3RkdqlNT87iJUC3mCkN3ETcFWSGJ14V8cX9O7cxNjqXY4DFRvG07N2UQ3xOerSnvWFIv2GJkSuSPBEebnXRZsbJEmKOjoGOqPrtjLYqLiwNWh0ySZ7wdPWVEt0SeBc9jaeLV9dOoJCgBdCDFvcjQWPuZBrZEj4yRIWt8hqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e8061b-1a99-44c5-a25d-08dec7dd358a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:16:43.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liifCE9bpIr6wAu3aBLZbXnRFmMjWgWUSEhc/7CjfKnb+WOV7zbW+NCZgXc2h/l5FR12MM/u2D5+jm1LMSO43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7648
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> struct tdx_quote_buf is currently used only by the guest, but the Quote
> buffer format will also be needed by the host for in-kernel Quote
> generation. Move the definition to tdx.h so it can be shared by both.
> 
> Rename the struct to tdx_quote_req to better reflect its purpose.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
> -static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> +static int wait_for_quote_completion(struct tdx_quote_req *quote_buf, u32 timeout)

Seems inconsistent to rename the struct but not the variable names

>  {
>  	int i = 0;

Please note, the timeout condition in wait_for_quote_completion() is
broken, in that the final value of i is timeout + 1 not timeout.
Since you are in the same area, that needs fixing that too.

>  
> @@ -269,7 +250,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
>  static int tdx_report_new_locked(struct tsm_report *report, void *data)
>  {
>  	u8 *buf;
> -	struct tdx_quote_buf *quote_buf = quote_data;
> +	struct tdx_quote_req *quote_buf = quote_data;
>  	struct tsm_report_desc *desc = &report->desc;
>  	u32 out_len;
>  	int ret;

