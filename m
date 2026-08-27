Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5621CA03
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800066; cv=fail; b=e9QYm6iOEX+MJKOqzPLiut5rkOb9orbTeCG6Y5zNaC3w5fF1x9f8FpTJAJ38N2zG/6Xvy6pLj/LwDVoPGpEVbcrFa7V67vzk1kbbFSmuxuYSV4pvZVheQoUSkCq9MHGs3mgQdF8BSsXm2Q9S2rx/dHSQILeQ9cHQgzk93P94BCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800066; c=relaxed/simple;
	bh=cVKXDb2z2A38yNILAhmAJpiHzYHdyOmxFxo/VeatxNI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLOGum2mMs8gf1Gt8Y0iltnUoxE6EtTFyqd2PWA/b8YzqVEhca1lKVgW8nUcus6pz6R80QccMx3u5N30g0lobhvzrnpQn39u8RthJGhvTIr3DUYnVAtltJAQ4hsPAPxdPF8LQ/XWeKObAfAD0EAbO/e5iSGuWzXTUyKFxLfjepQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cxm/ZPdB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxm/ZPdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800065; x=1819336065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cVKXDb2z2A38yNILAhmAJpiHzYHdyOmxFxo/VeatxNI=;
  b=Cxm/ZPdBk9vRWjMZRGaJIxMrRHtKpivvP+EcwDcCFMCcdvmttg1ftweI
   w1dPF3/14pTLyNsgWwTbEPANi/BG5V6Z0+0wrSnPB5b3xscXAZhUy086h
   H3cHuRPnoRn8/hJhsWnATHMxHEENW67L8V272Xh2ngTu/f+N3u6b3gV1R
   DXNWhNw2Kbm5B3+JAuQrcgXzkXHI8iuAk38PPtp5B3D+T3d+wDWbwRAw3
   3Whs0owMKxQyfKqQfyU6HKz/N9+9xjRaWs2zdw7t1Fd6GtQrjE+kDjdNv
   ycdeer6YRfk/7UfC48om0KGl60ThYkP+Sh4gYPJrrtcY8f62IIYUUiYyi
   A==;
X-CSE-ConnectionGUID: 8hfSm7x4REicR6YKlAU7PA==
X-CSE-MsgGUID: d4Wz4bndQL2m3JwP2ghykw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98964105"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98964105"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:07:45 -0700
X-CSE-ConnectionGUID: H5F5ci5IRRiJxjH5EOuLTQ==
X-CSE-MsgGUID: wR/QkgONRuGUwn05/odP+A==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:07:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 20:07:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 20:07:43 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 20:07:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gen7jY1rOtY3jVtpqTepFqmVE/RfTX42s6kaBV4P9gCa7/j8WMZ18fT+rjk29iIU8K26ltn+1bT4Sq57jH0fIJzz/oYF22m55GAMrnzrthtHV6ehGlMcadhYHSreXqqZmI2054ynDKcP1EXE3kdMkPgduGFnCewMU8PknVHeU7LiTduFCfu+EKp3uWkaTpLROOD5NjDyH4YxPFaIdzU6+atqitd+nbs62ed7glVkGz6FfO/5hB+fqPsGfz2WjwebqhlzEpkX3Omu2UOVNY77PM2lNjg0pC9jwZ6UK9NenhzqJvQM/Gg4LeQPUAoxdN5YfN0LQb9dEuy46lyNEMCMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSl7ZHFUsvm3q4xrESYOJv807MeblMXIVBvi0nqvixI=;
 b=tf5ejDxd3mBz2gjaMXN4X8O/cmKkhUG0NN9TTKBHdTkngNz7j46lasq7IBdk/E7/aFFE7koJw7wCQhy/Kr1hUQAwQ+QP3GhOc1U9ug7PEg8Nb1rufP3eZRUexofze0Z2OGx8Cs3UVdA7Vw9j0JfiEeS4sMLPvU6aJ+QcnLqQX83uNl8Ha4gnD5Hd0qGDQpxI79IKl2PaXdQ+3aH85T1JoPTz542jx4/DUr0Av+EPLSatPoHkNh0q9GVMK5tp4DJYxsRnHhR4WzoLmwbhOhPrmW12YrE5GnWDJ6Ncqnnk2IDcnK/+vD8Sk+ooC+2u7z9mP4akN67eIIhXPuIgOeYJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SA3PR11MB192006.namprd11.prod.outlook.com (2603:10b6:806:52d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 03:07:36 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 03:07:35 +0000
Message-ID: <0a66aeb1-30fd-4223-adae-a01bd77de8e7@intel.com>
Date: Thu, 27 Aug 2026 11:07:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: Add support for LASS
To: Kishen Maloor <kishen.maloor@intel.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <xiaoyao.li@intel.com>, <binbin.wu@linux.intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Language: en-US
From: "Chen, Farrah" <farrah.chen@intel.com>
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To SJ2PR11MB7504.namprd11.prod.outlook.com
 (2603:10b6:a03:4c5::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7494:EE_|SA3PR11MB192006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d33aab9-c5f9-48cb-fd0e-08df03e8572b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yw03bbzBvk/c2wijJr54K3CGKlClM/QIo1h5XEmCHKzqEtGtRjZpybx5MIWozSuNfMtYXTZ2QhnkK+bloLAkbngPaglvtVu7IACIBNMkNV4ExXDIFeLOBzegr0jigx1ThEXaNNPMJIgDSVgA/wzi5vfxxvzZACzlf35nENVD/3ShdYlz2HQi04e7K22TudbXlEms2CB8AWs6trXph6NWhv90QxajnkxV6aNpLcqf1jAKy0gXAkMPEqXbTcNObBqB74QW5tW/3kPlNnw1ZDxdW3zM17A5O8xhN7UGqhWIjkf1tg7erUWawdNSzu+WS7gVrLAfp6LPalzy8exv5/Z1tI/SZdXOV+fpU6XSmBaNpHUgY6WvJDkkNzQ25t/97yn1VFU3Hr5Gwwh9hFGyOngNoutq6Gf5505jAqEnGC4trto/gpilfi8YSAxw2d8CtRekHNkUWS2sNWmQGeuPUdWKPYvmxM7/kki6ToYgq+7sG2ljTjpnt/fN47Pm1WLu+gIH2b5OX4WOLuw9gLAPHScYVKZAL9EgIafJkfesFXULxKEfrVE7E99IYKl1zwWl0hAxlU3gQvjdlIHdztfR+5dAJONPjXhNFHT5IFGEGBXEu8t+9y7J06GgbCcYMlI1e1tvdbnZFD7hM6jJGzogRl10zsbc8rR7Ll0g5YCN76rd1Pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0QwMHRrT1dMMGI3bEt3VytsMGh5bmMySUZOaW5RenA2QW5CZ3BqbVZIQm42?=
 =?utf-8?B?TE5YMUJVWDNEdVAxOUJGQzVOM210TkMrYUlGeUZUdWwyRE1VdDZIUVozeWFh?=
 =?utf-8?B?WG54V016dVZidWs4M0V0SHlvbnJhTnhqZHJEYWUrSDJkbDZhbTdES2dlMTJ0?=
 =?utf-8?B?eVVyVUlpdkJtZ3ZZQm5MWi9IcHpuVlVRVmtFbDBlTFNzM3FYajJERGJVOVgy?=
 =?utf-8?B?OHVJdmNyeVg0cVFnL2RFZTNDS0J6Z253dXZPVVl0ck43MEowS1B1UEQwVWdw?=
 =?utf-8?B?ZjM1eU8rQXFURjNzY1dDbFhHTXpjQmFDdUUxcTN5NFAvd3hjT0pMUVBYNnk2?=
 =?utf-8?B?WXRlOFU5RkgzNDROR0lOSUVDd1ZuUitrb3owRVQvc3hjaDNyOWFpN3hxTGxT?=
 =?utf-8?B?NGpaRFVxUXdPOW9nL0dFWit6VjZtSHI1ZHpuZU10SUlnbE5lNTJ5VHBOMEt6?=
 =?utf-8?B?SGI5R1ZVUENLSE9KZWhxb2s3R3FNNFRSZmJHcEtRNnVCV0k3dGZXWmtwY01B?=
 =?utf-8?B?NGtySVB3L0hHVTNyQ0lrYldsRFRTNms4VUVYNWw1M0NGK3pBZ056bDJMTjBB?=
 =?utf-8?B?d3FKbEpFZ3gwSWZyZlNzSHp0a2F1bnk4RC9ZdUkwSVhCMXlXQlhpYnI4K1pk?=
 =?utf-8?B?THNxM1ZKTUlGeUVxcFU3YVBCNUEwdEF4bG0rSlk3NG9jQ2NpbWZqS0hJRFZP?=
 =?utf-8?B?akpUWkJObWVialhwOVhsZm0xVTh1TUR2Vlo2YUpDTTFFZ1ZSSzZsaEJQS2ZY?=
 =?utf-8?B?V2tGMGFVcktuNUpXbCtaNXdRY2tmUjVKSjJqL1JwRmpPbUJXbmI1Vm1GaHhX?=
 =?utf-8?B?bmJMY3FkdlVUdnVaRGdXSWJJMHV2WVZ3RmpMSlpEaTN4ZEM0M2ZuTjh1TVR3?=
 =?utf-8?B?MXREK1Vqc2NncXRpcDVzaFF5eTFuQzBHSEphK2N4anFFaWRCTThra3lKVzNM?=
 =?utf-8?B?NXE5cVZzdUs2MVpIL04ybllwNXF3YVRUZU5sQkNtT1JqbUh4ZU1pOHNxU3Ry?=
 =?utf-8?B?SnlxM3I1b3Rqb29iaHpVY0c2U25kOUhlU08wdnA1aEhxVEVNZjdBSnM3Y1FC?=
 =?utf-8?B?cG5FMnQ4cU5Eb3pyMjd0RWNVc3BXWnRpS3VYQ0g3ZjRBZ1FnQ2JZdjQ3dDcw?=
 =?utf-8?B?WVlTTHB1QjlrK1BXTDlLWDJCbmRXa2JxSGFwbUhtZTRvYXBWMk1kNEdrSEdP?=
 =?utf-8?B?VzZZWjVITUFrRFlRcFdFQlY5TE9IaU53TVlSZktBbDJlVHkvMzVNQUVsKzE0?=
 =?utf-8?B?Z0dOb3Q3VEc0Z1N4VkVqdlFMeHRvNWgvL2Z3WjYyY0tKR0p1Yndtc0Z6Wjl4?=
 =?utf-8?B?Y3haSFJJZGU2U0srblVjZEFJQzVEVk1iaTEwWXBjWVNiUUFUQXFuemVIK2lS?=
 =?utf-8?B?MTVIVkp3R3RUSmpoc2pYMnYycUthVzQvWS8xV0xBWUdITVBrOVlSVzhPM05R?=
 =?utf-8?B?cm9oT3JZMTJ6Q0owdUpUS3pLU3JZTFVKaHNqR0hJcWE3OGVjaU5kZ202N2N5?=
 =?utf-8?B?SUdUSnUveE9keHliUHRZY3VIWU9kK1pqRmMxamV4SnFhRFpWWVV2d0U5TFlm?=
 =?utf-8?B?UTA3NXdLTlNLNytiZ2FvL1prM1ZpVHJrUEZ1MVFWeERsaklzZ1Z3VjdUdDJo?=
 =?utf-8?B?bWRKa0RGQi9QSUsxdUpkb1NnMXY1WVpEanNzMHo5bENoUzBQblRsM1poSnkr?=
 =?utf-8?B?Rk9ZVE9uZ0FETUIvUDB1dzByV1YvZW4wa1pXa2hJY0NObjFyVTlRS0NPQUJW?=
 =?utf-8?B?aHFaQU1XQlJ1dkozbkIvbDN5aFczaTVrYU80TnhpU2lUK2ZQb0dtUDRBS09V?=
 =?utf-8?B?emZoQ0JFcXlsYnFnSC9hQVZWUmZ3dEdaVGJyN3lVaWlOQ3h2MU9pakp6TU9R?=
 =?utf-8?B?SEJxWWhLZjBUdzVqOWIvbFYyTmZBYkFhUlh4dkVSTHI1cnJTNVYrdnJnQVps?=
 =?utf-8?B?azc4aDlEdlpOMWUxaVE4T0s4QVlKSVFUOW11N2MralZSQ0JSNGdUQ2cyb21B?=
 =?utf-8?B?OUdjNlgzOU11Nkh1OStnZUNFeC9RNkJBM3JWSmp2M0VjZjMvWWw2UU82UFVz?=
 =?utf-8?B?NDVsRVMxbnF5N1JvbkRPQk51VVRHRVdFRkIvY3IzdkV3ODVBdU5nNktTbkJM?=
 =?utf-8?B?ZlJPNGIwR2ZSVE5Mbi9vajBBUUJkWmczeDZaQUNoaWhTMEJXUlZtUTFzSlZx?=
 =?utf-8?B?cGxKVG5CMVI1azBkS2R0SVN4a3UwTS9DQWNrOVBMVTVGTnZRaTlSUGhBajY3?=
 =?utf-8?B?c3pNU3NTZnNNNDk1Zi9scGsxV0xCbnBmNGwvOFgxNDlmd3o1aHRLY1RNdTlF?=
 =?utf-8?B?Q0FaYy8vcXJTQkh3WjBTOFhQQVZ0TmhQS1RFWXZqK2ZxUVdSNTJMdz09?=
X-Exchange-RoutingPolicyChecked: RDE7F6xixh+RlwYhhfcEKudzjRSQmmZz5rJhn+I99b71sGhv+DI5RK8ELSArFgXiZ/aeroRFVICFd//V9okQOTSspaiI5ugA7k4ii9KJJzyi+2SAM88BB5ubWJXHO5Ts6fki6zMuhg6ZLRhjkmjN7PXJAUWsVi8RHFB3Fq9ZNZW7LVsEHc+HE/Ff8OFnwugrL8edTBmR0XHcZAMXdPncaH88+lT9T424wn6LHDIuP5Ybx4WS7Po5Qn+xy6tUVKV5BWBsX3+FJuKFOUJIc3B/OOcKEFQZJw4c11yG6001AFOaVMlygtwTgRwsOcqJW5dDH6xLdz/m766PAZhfwYMbow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d33aab9-c5f9-48cb-fd0e-08df03e8572b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7504.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:07:34.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bWI8WeVf2CrHvrc6rgV0PV70daVSBDlhESuT0aEPWzJj6hlIxtIF5xaUcdUemY9pg63iQY4fqyyHmjzvU5GKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB192006
X-OriginatorOrg: intel.com

On 8/26/2026 11:57 AM, Kishen Maloor wrote:
> This series adds QEMU support for Linear Address Space Separation (LASS) [1],
> an Intel security feature that prevents a class of side-channel attacks
> relying on speculative accesses across the user/kernel boundary. Paging,
> along with SMEP and SMAP, already provides mode-based access protection,
> but enforcing it requires a page walk whose timing can leak the layout of
> kernel memory. LASS applies the equivalent protections during
> linear-address pre-processing: given the usual partitioning of the linear
> address space into a user half (bit 63 clear) and a supervisor half
> (bit 63 set), an access targeting the opposite half is rejected on the
> basis of bit 63 alone, before any page walk.
> 
> This series enumerates the LASS CPUID bit, recognizes CR4.LASS,
> and exposes LASS on the relevant Intel CPU models via new versioned models.
> LASS is not emulated by TCG.
> 
> Exposing LASS to a guest also requires KVM support: KVM must validate
> the CPUID bit and CR4.LASS, and enforce LASS violations in its
> instruction emulator. That enabling is currently under review [2].
> 
I tested this series on Clearwater Forest (CWF), running a KVM guest 
with -cpu host. On the host I applied the KVM LASS enabling series 
referenced as [2] in the cover letter:

https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/

With both series applied, LASS is correctly enumerated in the guest, and 
the LASS functional tests pass with vsyscall=none/xonly/emulate.

Tested-by: Farrah Chen <farrah.chen@intel.com>

