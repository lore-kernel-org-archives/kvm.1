Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C94416841;
	Fri, 14 Aug 2026 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693060; cv=fail; b=tGFpE2dX+atg2n1Zb2Bgz6TzZRvej7Tt8T4j8C0rYPDV6vzt9wCiAAo9OSyFDR2lNtXP3dnbuxnSkrOzeomTDB8wktTpzh/B0sWdOJadkI7Ed2p+aaQZHds5BQNgN5RNhHpYgy5iQFE+ekbQSSSiW3KIAFxQmJ6v2F3Q4bVNWhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693060; c=relaxed/simple;
	bh=5zdZc7/6+3ReSy8Wl18CITecue9uoDe/SFynbjeQkn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HAT+axeMaBW936N4apvLvrRni6alXVAcCJfUH97nvDbl5aLllW8NGxP0Qt80IyweG55HZ44rgZitqnahtoCRpjX4bJ64fvc8OFILRwldHgLWXPURpgn5JGFmejk6MoDTYugacNz4yjJd5yaCKloH1zgS/42Bn+C1NZxttu4W6q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Po70/W2l; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Po70/W2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786693056; x=1818229056;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5zdZc7/6+3ReSy8Wl18CITecue9uoDe/SFynbjeQkn0=;
  b=Po70/W2lM5tHee14bgs2EHM1ppXlIQzeiRO8qn8mNctH5CAw5AWgkdgh
   EmJZzwJrkn6Jj56ruHyE/vWnejteX8wWzzrMYKzWp7DMlxBzKMJJwgqdl
   ZQDQh168/VSZ0hFflisNdi2v6k/2TdzXOsMmqRrLO8e3pEtiX444zh4Tu
   umeNLbunOPqeseYmUpImRsfkTd6hygTY1tnMPA8+cG+ACV4RDG7fIe2el
   rvzIAGqGhTULMs8Nk699b1WNlgowQYrla5DSfq1uSXIUAff3pVN5q912N
   hODJDR+rxrEwHgv18z/vN+3uQqXVY2oxZr1uqK7yAqfiNJn+b9M/qt72k
   A==;
X-CSE-ConnectionGUID: CHVzJI86SvuuuofXILFa2g==
X-CSE-MsgGUID: 4llrozIXTk2TVn+e9DOHSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90947953"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="90947953"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 00:37:32 -0700
X-CSE-ConnectionGUID: b5X5jNGMRQeIA3o09vm1XQ==
X-CSE-MsgGUID: p1Y2qboiTmawyREsoA2HKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="266145245"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 00:37:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 00:37:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 00:37:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 00:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8x3FjEYwGCIkcvYFZKmmp/iM/c6fMEeMKFGYV2cHQcSDCNRMVzf+uvD8YMyeyylAenbwtiOIn1/tJaGcgnrwR3vUu1GSqN6phOOOx17QyjpUoAbbeFDEYuK1rYJizBgDy2tNtfRJHTtRSRJOdXOajFRz0v38P0K45C2HSMsfb+7KD0kztFCnbXq6obD+pQKp9JTxoI2rEY/Xy2I9ghYu5tj2HTW7Mm8vLE7ljkvFEKoIldKaAkk8tBJQCiqhoMYN2mxoOMryu3uLhjVqSsvxOUOwbKfzCqWoqZraDTwqtV+RgnHtzuUKC8/kYtZ16OZAbZIybgjvYVae0EqhJ6YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MflCouq265n/r3ds3aV5PS6vaqAN7CiTLgoGtDpqUE=;
 b=BG/6l61spruejVqjTnZ16qk5zYObkhqYxgwwzR+5STr2948/o0L5HqayuZjOHaZ0JH6nonUW2fhXnihUlUYOmDc2x+OIZA1jVG8xDItVLesLd2z5j/mUHLayXOdZ3quXj+nWMqrF2DC8b1RNIZFvcdvklCcUI81NGhXRxeOCKM+XBnZCcZnuHzD3HwSCM3wmcvKBawHLXTiiccoKijbIm7u9A/UX1xtxbhPOmnb/jhO5ButzMtf4/e0Nck027LLvPXGeoNrKWRodhwpVYJ2S3zjPf9gbf2x7ZhvIQmY+sxPbJznoKS1YExfp3mcZ2L6XonJwc40jxlsWMUTYZ5RmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA1PR11MB8374.namprd11.prod.outlook.com (2603:10b6:806:385::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 07:37:25 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:37:25 +0000
Date: Fri, 14 Aug 2026 00:37:23 -0700
From: Peter Fang <peter.fang@intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <20260814073723.GF1013044@pedri>
References: <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
 <anyiwqi9i0NSv0QW@google.com>
 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
 <20260812223707.GD1013044@pedri>
 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
 <anz9b6CDkhr5D5RG@google.com>
 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
 <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
 <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA1PR11MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: a47591b3-0c15-4bfe-c3fa-08def9d6e247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: GwSbMokpobT0xAO+xLswH8TO3yBWl9HfUFo+KiQKOeGyNSUW4K4hnoe0LmJ/HiIvkG4suajVmDjo+J7Yj7f1RVcVedOkvlAdWPcxpLmQ1EDmOQI3T1rCT4GQhehRru+T9VJlLyLTAdriUw7r+FHRiblx3bQCDxXGOM30rITyIuf0Ttz/jaHzbuFE1uyGaQJ6HLSZKPW6ooA9H4dafOhVUGVoMClPVWjhdL68rYBeyXkLN/CF380r/kxukuIFItcSwaa4rIYXPLQFR2JSDcmlwLUm0K/4ZRSPEHuO/vwcQlu2Ev6wnSIKi1lNpO6PsRjO4L8TNZX3UtHscwZd593eAZsGMde0VYyGoE8T8ib0lhiCfn9XANt9zoMBkCY1zv/YYAEmSmYqJWKRMlJ+wz0drzla7J4NmBbf2EUmncctypqgNIqLhoXyFc6MDScGLc2iz+dKmB4bnF4r+scrjw4J1+l5meazpq3K4a00EPDUtvlFQFHL6izE5XTJWFk95PwqL64v0Fe7ymR3oik8azW3twacl8IPkoqt7GY0yNwqKKee/BXG7wZ6fuSk+DoBvN4E9jXXyV8hFbNw4JwC+9zUK+gG/GAa0HNGBhzX1Aa3Jh3P48cMADnBlhVn/W+bihoti2QIuvunpRoL5rwR5NxH/Nm5B2avy1za7SWjJBikBsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStmSUtkMUNURWorSnQ3T2tSNmV0V2QxaWN3ZkxVN1Q2WnBrRFhYVVVJMDNk?=
 =?utf-8?B?anJsbXlacUluU1BnZTF2VFBPZC9paWNISlZYTTNVM0F5bmRuWk0rb1dPN1h3?=
 =?utf-8?B?WFRiSzQ0WXY0Q0UzOTlqNXM0QzUxRTZKZG1pNi9oN0JhVDhsTUJlOVhWdFJJ?=
 =?utf-8?B?aWZGK3QyVEdlZTBVMFhQWFdlUnp6azcxNUxhSm53Y3RvM3JlZkl5SWdnaHh3?=
 =?utf-8?B?QnlNbXJVMnQ2NmxvekNISG1oM1VOL1pRcFZBUW9RY2phOTJxQkRoTFhORmNx?=
 =?utf-8?B?cTNsVjRVOEZ4UnVhS3JJQjc1RXhPenMzajFiU3Uzak1oTmQ2QTQvOTZFWmVU?=
 =?utf-8?B?K3g4NVI5NXRpTFpJUlU5Z1RYVmtRRFFNVXhDK2hqTzJtbkRVbHBsY2E4clR0?=
 =?utf-8?B?NHpab01zcThsM1ZTWlc4cDA2Wm1YcXJsWkZXd3M5S2JPcjliTUJLempRRUd3?=
 =?utf-8?B?ZWpJU0pqLzhDTGdWaDF5anhCVGhsNGN4czlDRlVoQXcxQUhMTTZzVFl1L09P?=
 =?utf-8?B?MTVpdThhQkFDWXcvbHJIOWR3TG9BZGJtay9EVzZYdVdLM01mU01LQ3hacnRN?=
 =?utf-8?B?aVBSS3NaVy9QdHRGUEFyVEk2dUdZNytvK1hFU2ZwcW5BNlUrd0V1QWkvRlVL?=
 =?utf-8?B?amw0ZDlnY3BOREZZbmZ2djRUOEJxM1VxdXpLVnhrckp4NTdNQ21GeEtSMmdu?=
 =?utf-8?B?akJmNnZ4Vk5EOHQ0WDFNSmZ2NGRPd2xVek9hZTVvakFxSktMbkkrVmo2VlVR?=
 =?utf-8?B?UFpCQ1BzbXhTT1NFeUFYUncyQlJsRjVlVUtuTTkveHBLSTVuYk1zWHcwN3Zp?=
 =?utf-8?B?S3NaQVFudlQxRFNHanM0Rm1OZGJFU0g4RUtYWHBKaFlkRzl4d2wzcUNRc0Fa?=
 =?utf-8?B?UnRBRUM4YTVxYnVaR1gxYXZrU3pnUU5GS1pBbjMyZjVVTU03VEI0SlY4Y2li?=
 =?utf-8?B?K1NSZ0dvaU5wSGFjaDFNaDBtUXVTOXgrMHgzeG5zbSt3YjBsbUhGSHd0TDhv?=
 =?utf-8?B?NFF2Z21rakZ4RnVQQXVORXYxc0k2MFliQ1BJdk1XckZGb3U5WTM3ZEZrbUJW?=
 =?utf-8?B?Rm5PTFQ1QXd1TTVVZVcwK08yeU16SktmK1dpK1doTW5rYk9oMGN5a2loc1ZD?=
 =?utf-8?B?eGE2bm1HYVlodmpJZjQzL3h5bGordG93YlB3NlljeDdMa0lCczVqYmwxcWd6?=
 =?utf-8?B?Yk1mcXRFRThlUGlWQ21EanIxWEkzcDVVbjB1TWZzeVc2RGdkK3gyd0F1NVE4?=
 =?utf-8?B?cDVUdkZXcXVoU1lSeE5oT20vTmhGRGhVcXZsWXZlZVZlVzlYQUdsT0k0Sjli?=
 =?utf-8?B?RURQNmRGaTBmQjlhMFRSTXVrVEtBa2dsbE9BRXJBTENQNkdObmJKMXFYdEJq?=
 =?utf-8?B?S25WL3JzTVlZRjhxdlBRWFZiMiswSHlzTFdyNUNmckxvYUF5SEl4YVRDTXB6?=
 =?utf-8?B?SUVQRktvdjluUzYzVG40d090cnY5d0pFT2M4cGpTUytaUDZuakk3QmR2bUZ0?=
 =?utf-8?B?SVJlTWh5cXVKcjA5THY3YUsxa2NiL21uOWY2TXJ5eHErbG85c0JQWkZTNUQz?=
 =?utf-8?B?Tkp3aG1SdVlTa29YTDVJQjRDREIySE92bFlGUGdCcitPUk9KRktpR3FIcGRh?=
 =?utf-8?B?eHlyUzZ3OU0yYVE0eVhjeHF0ZGVLU0dTM21DOFJsZDB6TmNKRHRNdmRwNFNU?=
 =?utf-8?B?bXp5MHBBcEUxcklBSGc5ZFJOMlZ0bS9MNk1IVFZNaDRkTURyTFlXa1I3S0pC?=
 =?utf-8?B?WWYrK2QyNlMzRjJIcHl1eGFXa1pjSFVXMkVSME5jbkhOTU85cERQbWVGbE9P?=
 =?utf-8?B?anhkeDJnUTVCVFNUU2NJS2pBZ2JUOTdOL2RpWHYvaE5GZWUwdXV4Q2NueWY5?=
 =?utf-8?B?NFNHUmc1Z1RRQVMvYnpnWmM0VTJSa3h4RS9YY1h1Wm9hVzliUlFsUkY3Y2Za?=
 =?utf-8?B?RkxVRit2cHVTM1JPbThSNUtvelQ4REdUSGVXK0Vic0lFQnVINzU2L3BDOGFt?=
 =?utf-8?B?eVlhNHFEeEVIaHpVTGw5K2g3RmZZcVVhcTZaOTJ0NUNQYkVvcGVVK2trSTNF?=
 =?utf-8?B?MmhvTVljOVEwb3kzV2MyWFFyeU14em11N3BWUkJFWkU0NWxiYks4NEptWXla?=
 =?utf-8?B?eVpVNUhyMkhvUXRwemFQdFQ4UnpRYWw2QnFtRWU3R2pWV1gwMXpLN3JDd2NT?=
 =?utf-8?B?MGtrVlBla01yOUk2RjFXZktUR0FIMTJlemZVakI1bDMzUUxsWkNzcnFIYjdu?=
 =?utf-8?B?TnVVaGUzSDVlZ2I2Um40cjQ2SmE4ZmxOTE1jYlNyU1Q5OFl4clF3RUhmakll?=
 =?utf-8?B?VnROSzRvQXJEQW9LZ1YyNUVPNUtvYnRpTXAvK25jNllYVndrNTNsUT09?=
X-Exchange-RoutingPolicyChecked: pbnKCetxKt84uaSsSeiH9nVqlDNkPWUNJN8hXl3gPqrL6CG4/ZHGyvaf1RBETDhxVA5o2KWfWSDJwGmDDB1QtC/6kzOC77meDlV7W/VUyfCnqCQqr/WnlVPVNkWkQXOSuhj7bhnghONVwDrEmtbJLAxZ/t1585SojrX4Y0bYS+qshMmOKDCYzReW7/oUUUy7NKfZjCYp9on/b8VycXtmIUiirgBpkzKHI4KfSUC2p/23As1fsoBXScU3UwtrqaLxk8dG1UA0sUJM5KX9sj95YtYzOO3dQipZlsQRPa5m4c5R33Rzf0TyuPOE4heSdIuawAJ4X3n5ij6YmVPH/N23Bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a47591b3-0c15-4bfe-c3fa-08def9d6e247
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:37:25.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M5wTnyXHX597USIw1qssDp0aCPV9sndRpoc8PcDY/nsjyESmneRYCI/wdgoY4hCf0zIJe/Qtp8+EB0FTzCVRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8374
X-OriginatorOrg: intel.com

On Fri, Aug 14, 2026 at 08:45:55AM +0300, Artem Bityutskiy wrote:
> On Thu, 2026-08-13 at 20:14 +0000, Edgecombe, Rick P wrote:
> > > 3. Why freezing TD report size
> > > 
> > > Linux supports 1024-byte TD reports via the `TDX_CMD_GET_REPORT0`
> > > ioctl. It is already full, no more TD evidence fits, and changing TD
> > > report size would require a new ioctl.
> > > 
> > > Also, as I understand it, based on TDX feature requests from customers,
> > > there may be a need to increase TD report size more often and more
> > > significantly than one would expect.
> > > 
> > > Therefore, for DICE-based attestation the TDX module adds new TD
> > > evidence in the quote instead of expanding the TD report.
> > > 
> > > Is this the cleanest approach? Maybe not. 
> > > 
> > 
> > I was thinking the cleanest, time-travel facilitated, approach would be to have
> > the "report" really just be a replay protection thing and not include any TD
> > details. Then the quote could add everything it needed in the final format
> > location. So no re-verifying and shuffling things between formats. But since
> > that didn't work for SGX based attestation, the report has extra stuff due to
> > legacy. But from Linux's POV, going forward we can consider the report as really
> > an oversized replay protection blob and forget about the TD details in it. Isn't
> > it a pretty clean separation of concerns? And for Linux (guest), the benefit
> > shows up in not having to increase TD report size since it has really only one
> > job.
> 
> Replay attack protection is a binding value between the remote party
> and the final quote. It must sit in final quote. It only needs to exist
> in the TD report because of the 2-flow design.
> 
> But why DICE-based attestation uses 2-flow design? Could TD run a
> TDCALL[TDG.GET.QUOTE2] or something directly. No concept of TD report
> would be needed. That would be my current vision of "cleanest".

Yeah, Rick talked about this a bit in an earlier thread [1].

[1] https://lore.kernel.org/kvm/23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com/

> 
> But the approach that was taken is to minimize software changes. Within
> that tradeoff, keeping the 2-step flow, preserving the TD report format
> and size absolutely intact, and adding the extra information in the
> quote is arguably a clean practical path.
> 
> Is this the cleanest in some absolute sense? No.
> Is it acceptable? I would say yes.
> 
