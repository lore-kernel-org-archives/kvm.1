Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17B1A9F84
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431287; cv=fail; b=SCa5Rr4Xm0KL+iRcRgTzZWXvMpSUsjUzoJzQIp+g/kVa05/rqjHAStdsebAGI2kMxmgNOHkFiyjIuw3nc7xKZ2M8GY7Rinj+hXDDU/bHIdUgvi11sA0yuU1YlYYylKl6qvwU7Nj7brAJGXReQLucth8WY1gMoJvORMC/DRO8lNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431287; c=relaxed/simple;
	bh=AwfnuM1/uSiRlqQpOUIp+ZdVeZs4Ni+TdegsD3CbqPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T93Luk68los+3xqvzHa89kya3BvX7GHsqXkLp0uBsJYSuk8KVcpeOFqRGowUEMPh8YO3GZKibMlZ35gcimbY3nEs2VP+EkNcDC+FWdYsgGQ8hcuZUxvikSI8iZX8VWWjaa3PsuDAOoVlJaU9EgfUH94hJIJeGgF6kGenxez7968=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JG8oV5wW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JG8oV5wW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789431285; x=1820967285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AwfnuM1/uSiRlqQpOUIp+ZdVeZs4Ni+TdegsD3CbqPY=;
  b=JG8oV5wWwxSjcY3pJHKmi5Mprlb5fE1VlsbXFdvqX648kcp9MzY3AsSX
   0W72ZCjjB/ir/a7uUc8Ar/FIbOd7ndkpWX+6V4TDBn1n4ziTtw+wT2Dxo
   OVqoYd4qGkyea3/TgTXRxTVwQlKQ5QGnTJJ+V7ZDB8rVRjzQbJbogEqG0
   REweiyLt6KcnLa4b9FoApXhZ0KD7U9NiCrgUSJDpLLJkk8prg+vGrgTGy
   GYVuFgfYePG1Z+4yAn8MMOOBkFsCYsu9oHPo7z/4GvLeihhHZvyYJ8UGB
   K67hI6+xDFS7u1CJu7TCP1SoU3v/FLeYmGiz5mPaPXOs6KOvZlyT/NzAJ
   w==;
X-CSE-ConnectionGUID: spRVWxNsRjuFyDmPcqzL2A==
X-CSE-MsgGUID: oK0yykstS/uUyy04Yzy39A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115324149"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115324149"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:14:44 -0700
X-CSE-ConnectionGUID: RXBijLQhT4+l/KRMsQuwJA==
X-CSE-MsgGUID: Z48e7SZNTzSfFZTlAMSzJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1183536"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:14:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 17:14:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 17:14:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 17:14:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUG+3NkHaSMo4JEe2A2NUATZNuwlw07WpXHqRqI15CqP90szTCcuWXhkqnnXOZw5aUMj+Nh+icak8gD7dG03p+0RAUheUh+v5Ve/zWRAY80FJtHFXJRds9lf2vQmPBvXvEgcc7CAkzkTFc+oj6W3TIbi2mX0r/5CC1J1b0RhDXijQlRVo6aeC06hupZOD0meKbfdBnfo+lo6wSNFrReWRZm7GxqWFFoo2H+v0nyTorY4TZ4PRduFfa941WxPx1r78NzkEf1LSVOUr0wPOVxIKz6kZrs7/JFYuDXlxyr7qeg0sqibzKd0LMisXBYWe6Kgo4ma4Be4DvLmlfs0i/Zk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEbNu4RYphF0ZgUsKyeNN5JXy+xcg/JJSABGKko/fww=;
 b=OG0giID17osg/NnfgFJR9sUgm+HnqN2xqehYlIRA9WDEYiYWBVLuB5XhtIk3vZBFofa6foN3lHahYJPAVG9CabuxVKp33JGX9M6cQCixDDueg2uFDwGltGICybHQAJfNoU5zIq2o++EHgj8MPWhgaGQgeTXmltiGxrLD0ffbPuxT9AnIa0B1uCDBCNL5KfOED+Ywbg0h96mguJxxWhN8sy0Go5/qZmF9BJbD05J+xsdV1sSFke+k3+omBMZVdykZ9YtO5tEYspXkTkIJnZg3g2pkyJGvLkaQHGP/yjcXWBgzOPKXXLfL18SASMIkWeD3oCkJP5r2RpN7x0E4gO90pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Tue, 15 Sep 2026 00:14:36 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:14:36 +0000
Message-ID: <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
Date: Mon, 14 Sep 2026 17:14:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1> <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: a07fa553-c396-4998-7521-08df12be5311
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|3023799007|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0GxF6BKJN+fyDXfNCok7Gbtm9kReA2kfmPAwuIsnKhwQKlIRgSpeHAEkInEAHzH36oxO+4IF0acxNOyw/nYHfx+LEZUCo5F7Jvnj0yp+Ft0YVXKVJMg8FjyE/uFyjIw8ub2CvDBWneEsMJQyxVfRbiql1JF9w/bAKn2PTK0ONDAw74v+lVFg0HQGW6UR5Z45YmsG7v1hxFyMmzCaXAi9deti2VafkNbCZhEKwX0fxJ0eoM3DRVYJi78nziFLfDymXUobeaQRr3eVackCTtEUgzRWCHBc1AQ38GW3hmzapjVxZOVVaYFRGT7nQbE/B9vVNrP4N4a3zFIyVBbkdJRa4XsAG9I8JBmfjks1jRmauFyDKNUiDpf+E8BiYzWRwFhbzOQSNjlxsJRrgOibHyVC7IlQjG+B3b1I5RghcxcBl6K/oK6i0hJ/jjvVlBLgY9v1AhRlcIsNMtq62LGeGhfy0qPo1LpgRQ2nsaybLZFYgoqlhwx3S3lqhuj6LMoTCipOYx44aPNanKsTkiYGuMUgp5B5SU+W72Q/faY9wpSWcM8a3UuBp6QGNiU6fmZOVnuZdnJca7AhJLcbtF7NnIb8hS/n0bRBsvZ+rxztTtcB11NCeYDvc0qkJyvKg6e7nTE8hcivT4DTeOCPsXXgN0QS51dlvEyJghVZQP6Y98oXPdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3gvYVdTeUtYZmtqT2l2U1hIdUUzMnd0bTVoUWFBVEZoMU9HR2pyOWUvYUxp?=
 =?utf-8?B?L0NmSkhjSlBsVTN2bFdOdWxtSDBWQ3dIQ3U5L0V5TThzL0dRc1R3WVBkK0VQ?=
 =?utf-8?B?OXBBTU1ZT0d5WUZ4c05wejJ4SUxna240aUFaR1hyK3BvUEtlazI4c3NHNnNo?=
 =?utf-8?B?NnpHMGlGc21jRndyNktQV2V6UXZRRy9GT2ZwUDd2M3krbXphVWJQczloSTZw?=
 =?utf-8?B?ODRUTEZoZDJxcVJZS2NLandpYVN4K1BrRE15K2w5dXNTS3MzMmV4Sm9DdkVT?=
 =?utf-8?B?VGVBV09CcFlKcGV3Qi9PQ3MzN2JtaWQ3WlpMa3A2b294Qlp1elFVbEhDSTZw?=
 =?utf-8?B?em1oQVBFaUx1WEYrSXZxd1ZSWG5zT2lrZkJST3lYMlBaYjlCSW93cGZmZGxJ?=
 =?utf-8?B?YWx5eWd1Qjl4TE8valZha0ZYWUl0b0lteklENktHZ0RFMnlaR0hsTG5mRVNn?=
 =?utf-8?B?ZXIyLzlXcE9LWGQ3MDJKZGZFem1qVzQvRUEvbEI0QkkyMEc3QmVraDlxM2Ur?=
 =?utf-8?B?NmFKTFVPcVpvTDVaOG9QUGFXVlh4TFJUR1Y5YlZ3OHdFd2F0Sk9yOFNGK0xm?=
 =?utf-8?B?L05PUjNGakFiT1pURU1OY2JsbnJ4aVBEUy9TSzhnN2pHWEtVQm0rRDljYlMw?=
 =?utf-8?B?TThZZ2NvdkRRb0xFTTJ4T0VRdUI2NlFiVGlhaVdtM0VtODlJSlNqNjdMWXRL?=
 =?utf-8?B?QmNZS2FBQ0hETWpBMTh4a0V3bkV4Y1k3Qk8vSFd4d2RKTm8xbVVrM2VWREM1?=
 =?utf-8?B?ZWxUSVRST0lnUTVvQ1hZTUlOS3Mycjg3dnhWZ0RSQ2IrRTFDNzlZb0V4MS9L?=
 =?utf-8?B?S0xYQjBPQlE5YlluQk43ZW9FV1R5eEVCVHM2V3YxeG8rVTVQbE5qeGZqUDI3?=
 =?utf-8?B?dkkvdU5UTHFBaFlJT0ZsKzlady92ZklnQlFEbE52RDJpd1dnS2lIWXZ2VWt0?=
 =?utf-8?B?WGVTOFJSZVBNVCtDeVZGY3ZnMFRlUGk4bDIzTHBjZ294RVRnNk12a056TSs3?=
 =?utf-8?B?UUtvV2FDbzRKbnF2TXFFdkJwOTBRZk9SWDlObER4QWFLZEQxdVB5YlhBRS9J?=
 =?utf-8?B?K1ZHWDdvQ0wxdXp4ckVyVzdWVHpxQy9XV01EekdLelBtZFZTYWhwb3FKMWpv?=
 =?utf-8?B?Nytua0tYcGRrQ3k4ZUxYd0FZTlBVVVRSd2xOK2laOGtLQmFjTTFreUFGckFG?=
 =?utf-8?B?SDFQdXRnWGJncys2R09XZ3ZrWDIveTFTajdIVlBScUlHakI3aDZwS2p3QnN0?=
 =?utf-8?B?cWhsdTFSVXNMc2dId0xJaWZSallSOWcwcGE4OWhxcEVSVjlGZHRuaFFGeEts?=
 =?utf-8?B?N3g3U3lWZS9EdmR5U2VPdytrdFF6dWIrR1JCVXNvRzk2T2k5Uzd1aEY3SDRK?=
 =?utf-8?B?TU5uYWcvR0lQRnJwR1BVc1NBbUk1UDRyL0VYS0F1T0VaMjF0MzVROHNpT3pG?=
 =?utf-8?B?ZFFNZ3FMekduSE80eTVwR1RuY2pLT3EzcDNSZ2txSEszek1ka0R5RDNaRzNE?=
 =?utf-8?B?N0ZnK2lKZlUrTDBpbjhHaTBNMm16WkpQeUFXOGRPWFNIY0pPdC9wbDJLdFdV?=
 =?utf-8?B?S0JicmpUMzI4T2Qza2E3VFBjQXNtM3VheU5lRGc1UjBBRUZ0aldFSTRGczRJ?=
 =?utf-8?B?WG9zdGFyRko3S2VrcjhMeGU0VDJJRVQ3cmcwbkdYMkRDblhaMzUwS3FhS2Q1?=
 =?utf-8?B?UUtza1d5Q05XajJhWnlpeG5MWGZVY1VlaEYrbENSOUNETFZzdjJVV3NLb1FF?=
 =?utf-8?B?dkVyaTFVR0syTjVIUDRZeGZVSlRKL2FGWlJjcjI1cWEwRG92VUJFTlh2TThh?=
 =?utf-8?B?dnoxd0VsNWpDemkzSjNOdVhsbENVMEUrV214b0lSQ25NSWgyMnIxbTZ0dE9P?=
 =?utf-8?B?aU5aam9OMmc3cDFoS0hOZHpxeWliK0xpQ25JZm9JRXhrOFJYTDlmaU9XVVNK?=
 =?utf-8?B?WGJKa3VUUjJaUlh5OFZhT0EvM0RCWEcxamc2RU1WYlFjYTdPUVdtYS9jSlRC?=
 =?utf-8?B?OWJRVWhnMFVraEp3Zi9QQnZOQkkyTjBRMHhhOTNNaXRjYmxTOTVrYkI5VG8x?=
 =?utf-8?B?Lzhpa0IyR2svRDdrZGdQejhMZ0RaSHlQeWZzamV1UE96emhGNGtXTEoxU0Yr?=
 =?utf-8?B?YzRZb3F0WG9hbmNKOUxlRmVleWRQZDZld0wyUFp4MWErS21YcytwR2VydXp1?=
 =?utf-8?B?Mm85MjJIOWV5dllFSzZpa2krbGl3MmFRRSt2STZTNXRZMHJTK0lLYmhQQXJt?=
 =?utf-8?B?YmRHUG8yQ2Z0N2M2aTUxY2c4SlFrMy9GQitrYTVhT0hEbzQ3ZW1WVDI4SGJ1?=
 =?utf-8?B?Szc5QndwNVkyN05Eb0RkQXlpUzd6TE1rTldkR09neWdyZnAvVVNiUT09?=
X-Exchange-RoutingPolicyChecked: QpXS0E7vx8S25dcs/SSSSPv66+FN7n6iB5xyVsgs99M5dXNaQYbAApnkSkkkQ7mwjX+bxWjuhXDqeu2kPONIZeofdR7+lm/sr3ZJrJGtd/m0fRW47rF6oFn3//5/xn03dKZhoe3vTb1XDqbIKxR/aRxH+KosnLSs3wPL5ZQ9kz1WvT7e+QQ5NML+OskNjWFpGar9NH4gA7iwssYUIRNi1TtrFobFtIW/qflCk5l/JuqfwlwTKhfaqh34nDzUCSZ7bq7gAk4rm8iXLW7A/dl3YLQ5EkaCjxCJKPferfFIiAptxYiiCkf+orVU/fnhbZVeQAXmnvekvDGkWVTr/4mynQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a07fa553-c396-4998-7521-08df12be5311
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 00:14:35.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJf3i9oBC3tPK+ffAa+ZpDOEu6pp+jcGNRhUkk1J7x6tz1VgbxewuJaBtzTIhFY9g2M75kbAcZDrQ4eGou4qHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com

On 9/10/26 9:23 PM, Tony Lindgren wrote:
> On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
>> On 9/9/26 11:33 PM, Tony Lindgren wrote:
>>> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
>>> ...
>>>>
>>>> As mentioned above, that is a destination launch time directive that we needn't
>>>> conflate with a migration/transfer session role.
>>>
>>> It's still the same role though. Yes we can set it on init, but would
>>> be nice to have some generic way to do it for qemu -incoming.
>>
>> I'd separate these.
>>
>> On the role: it seems we agree on recording roles per-session. My only point
>> then is that a VM created through the delayed_init flow doesn't additionally
>> need a destination role recorded for it if SETUP will assert one when the
>> migration is kicked off.
>>
>> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
>> A generic mechanism would make sense to me if the flag were consumed by generic
>> KVM code, but that isn't the case here. Userspace has to make a
>> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
>> on that call. So I'm not sure what a generic version would add, unless you have
>> something else in mind.
> 
> So we could add a SETUP subcommand SET_ROLE or SET_INCOMING.
It might be better to pass the role as a parameter of the SETUP call
rather than a separate SET_ROLE call.
A separate SET_ROLE would bring its own ordering rules relative to the
other SETUP sub-commands. 

The specific role (src or dst) still needs someplace to go, and flags is
already the sub-command selector. An option is to carve out room in
the __u32 reserved field to carry a role argument, something
like 0=unset, 1=src, 2=dest so KVM can verify that a role was indeed set.
It could further be written into a generic KVM struct (kvm_arch or kvm) which
could be queried on KVM_TRANSFER_MEMORY, etc. to identify the relevant
callback.
