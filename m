Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02163377EA9;
	Tue,  7 Jul 2026 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459562; cv=fail; b=o4BT5UUCb32w93K9XydJsN0w9FU/7SAeah2xszg1zp/CDELNRXTIT5PmISiZjOnZ2/zyjz94RmHIVhIcZwJ0xIHXY+CNhbFZS3YZGz2t1S5wCHDp4CkM6fTAAwd5fVwiz0Wb4RI+dgmTqKDjHFLBsczp7dM6A6hre2VV3xoN1mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459562; c=relaxed/simple;
	bh=ufHDRYpawp9sUEMj5uwS4YK5jN312JwkP6i5FZx1MkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LkI5zjZ+bw2w21R78kSYWY+MfWQmZqYh6vRL5pisJgOWFbp8UUommYkzXi6pq8ejkYLbbOr5+s0LKCGvgcuiqlykacq4tKGjY1US++u79gkNFJp9u9XKES1M0CJ9jNIM8PoDjg0h0f0QhA30zGStEMqhcnP9Xy4gp8bT/iBLbGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJZMMSpj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJZMMSpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783459560; x=1814995560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ufHDRYpawp9sUEMj5uwS4YK5jN312JwkP6i5FZx1MkI=;
  b=fJZMMSpjdBluVDXsBofllUcwyJ8Halktmor1YL0jcEKWRBqmPGjIMoqA
   9yfNa0jttxrks7pStX2oZlW1TlIX6E78/txW+y+xx/Gl1X3I/FfDB6BAM
   FrbzsT0rKUyeHU1cUyd5fyzIcipcKgiLKMveo67uCukm01SXpUkP8G2K0
   9JjDYXc8VwmQM61tgwIAvry67iNhQTop/9ZJ7V5ougOYMUQCGC3eX3H1m
   sf/uOg6P6KJdN+SwgvzjdkuTHwxE8yQx8OiKSOILDK+g3AGLaN0xsqqtQ
   LBABp8n4e6bO/xhOOCyoRbgrCYcTqjz+D6nhcVZFOXuZNf/pNM0VoaVP9
   Q==;
X-CSE-ConnectionGUID: oYRscYWVSSq9JPXiQja05A==
X-CSE-MsgGUID: nJ5eewegSLWZkUVqw4A01w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101541760"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101541760"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 14:25:59 -0700
X-CSE-ConnectionGUID: DUKNHXzIQzicIiGVi5a1mg==
X-CSE-MsgGUID: nTpFIxK7TnuSINfHJFyE0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251439993"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 14:25:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 14:25:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 14:25:59 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 14:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hha2CBk2x+t9Xln7qnaPZR2D9Uqe0DYHa/C/+DaQ+9lVOPlTlSwL8u+xjiLBD0p+tApnqpcWsF/reF6G81JKBsSJPazxH5jII8UjUq1vlvkGN3mt6FsRL/JVPbpsXVJV9rh60GKCorQzqvty8DlmvmwsqgX4xNYsAeSEyvmxOVW9z8OlZ559aEey8F3ZS1XSDMtDpM8rOzp7zNH2rACglfM1Peqoha9urrT73UnaV8QpAGNmAUGFs0gTla0Zi3g6eHGN+Qa3kNG0Ez/bOeADKyKGQhMi2I4zT8ZFjd4zkibiTOGyMveMPb9XVhSJtCpOTjTh10xXwH7nzVdtYB2RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufHDRYpawp9sUEMj5uwS4YK5jN312JwkP6i5FZx1MkI=;
 b=JGEpj30/9bRgbnYVYtvHBt5Tw3e7QDz1+6wwe9q6rc6irgZmfrCiVARR0QfYQF9oj33Keu4iDgOZ5fFRseZ36uOFHwNVYixuRgdaO/TnRnBhrFw33gUxY/dstRJ1c65xC4xKWT694rQS+mS7VLZ/uX03OJwu55J5RT1NwOatMtRUWj1Umk1ZkCi1OmOcg3smNRsaPphMFs+gh2RGEXXUaDO+AyIr/xtnTa0lWuipD7DihXE+oYyjDgqQjNG1GDsj1EHk+Vky5F9fTW1zz9McKrcGdpT5lSBG6liv74rO0Fa3yGtFMgunkHqLWClbd8exxf1I+ixLqPMSB5pIK4zClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB6867.namprd11.prod.outlook.com (2603:10b6:930:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 21:25:52 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 21:25:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHc7LhSIZlCRlcQpE6fbqoCJ0ANmLZhsJiAgAEkVoA=
Date: Tue, 7 Jul 2026 21:25:52 +0000
Message-ID: <c4776c3e05147af1c8ed44596f65f62022d13bdb.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
	 <akx5pdOgoaGzsw/u@yzhao56-desk.sh.intel.com>
In-Reply-To: <akx5pdOgoaGzsw/u@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB6867:EE_
x-ms-office365-filtering-correlation-id: 84332cb9-e165-4133-8c89-08dedc6e52d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|4143699003|18002099003|56012099006|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: okp2zqBw0Ok20Nh4wW6drSymnalT14lQ95unYwoHNGB6npiJOPv0Trez4cvJP1zWt03KhbfFjjQwHhcoWwPTlAVura+hfk91esFGcMlY3+wrqDLdqbhf0EIse/I59DtrITZJ8c70IdLAFD25RkuwMJzhUxiJMa0TiouKXKuNtsYLOxJqlLe421pNVjhJoNndyBVNXdjX2zMLaO1dgciF/3EysJkJQBPMBPtFc074EirIVLPybaRdXaT8WkypyaZWatqPVxe3biv7wFYLKvz2+I+5ZLXgzJaiwd4KDUnroyg6cDOmAZ4JLC5MX3XAq7FnVZsx7ChJGsdYuvuO/FyFoffy0tTqaxXT/VGz36CsV3wCPadahJ18ARM+aVWmiqLNt/sokqOyjw/Zzu/Hgq03w6j+ZIaGdHftZDZR2MPB/a+ULK0HPMgL4xTjZzS0txnLTMpQAL/ynJGnuImeY/BuYIb0XvG8NXkcYbw6I3HZtJCOOgRfuso0VXlugnY8FNFY4Ojli6+7xSyG7HFLff5uFk5aaAVZBbBEfalPTQTYz5CAZKS2CeBZAD5yAkqJcSjEmHBUjnaSCpMamEGbI4joRhEEtgZ/wbPz43ZOhRbznkizwD4MYBxku4xVuSRcFgmSWbUY9gDCTgYqMh9zSZouN4r1VaX0Y0sQZ1mCvIfHZYfxifB4KlAUJSyw7qVbtCyjjB8ej/eJtMVqhocXpTDHEqhuSMDlmR8+8JJoBYwtALs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(4143699003)(18002099003)(56012099006)(22082099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEttaWJQaFIyMHFKRUJsRGsxbUxVMk85Q1lrY2dNeVBObk1ITHp3TzY1Y2dl?=
 =?utf-8?B?NmlNTHRxV213VFB2a3Z1UmNBTXp3UjBTV1FMN1Q1TCt1RDE5YkpFYlFGS2x0?=
 =?utf-8?B?S3JIOWRCOFVvZ2Uwb1pOMmh2ajU1Y2FQRGdZdWd4OXdYRnlvQkRqeGxLVjNs?=
 =?utf-8?B?bDVVNThpMEVaWG12Q3NWMFdaZWgzOTN6SmV0NU5ZTXBjTGtNWUV3Y3BOdWpK?=
 =?utf-8?B?cDlWL0xmZGtldjBjV2VFWDVUMGFaZWZ2L3VZWVljZ3BKQzdWYUpFVjZOalp2?=
 =?utf-8?B?Q3ZhRmE3UjJqMnRLSlVaNjBOMGJNa2RzOTRjZnFrMTdidFlsZmptTStDaWto?=
 =?utf-8?B?eFhlTktwTE4yRldjUnR4OGMzL1k2Y1dRVjFmamNkSjRNWUpYQ2dISkVsQU1D?=
 =?utf-8?B?Tm5zaEhDam91TEgwVkxQbUF1UkwwWTYyVmoxL1dMSE9XQVQ1NE1jazFHcjNF?=
 =?utf-8?B?bE96WUd1VzdEaUxnTU9oeGR2ZFM4bDZMNVhvOTVvc3kwTmhmVW9XVXdvV2d6?=
 =?utf-8?B?WmQ5NlE4VVVKRnRUV01JM21STFhRNUkwT0gwODRtMnFlMmMyNk1keEYvejlj?=
 =?utf-8?B?OHdlUUNXZThDNHhtOVFkcDcwTHN2RkZVYUVvckk0bE5YSnB3bkNZTlNpWDZO?=
 =?utf-8?B?cmpEWG1ZRzJCQnliQlNIUkRwTGF6MzBZellQRnFTb2NBSUZxdHVKY1owV0U4?=
 =?utf-8?B?QzhsNi9VVFRwTkIvTExhajZ1UE9BeVZkYU1MTGtDMDlpLytuKzk5RG5CVHI5?=
 =?utf-8?B?aVFnMWY4V09EZTM2TGoxdm4wQnFVd1cyQXhqK3VVMDJVak9UalU3L2dwREF6?=
 =?utf-8?B?cmJIT1MzNlpnS2MwTnJ5aWdTM2M2dXhhZHcyVmZ4UWUvbWNWL3owTlFnTVJv?=
 =?utf-8?B?TG5ONk8zTzZ0eW90VytRQWJTS3cyVDNBNFhjSU9RWWgzRWIvKytMQzk1SFBv?=
 =?utf-8?B?SUpzNERwY29MclgrM2U0ZHF3TElJQ05FVUlQUkpOQlA3V2paVTZpVXJySzVr?=
 =?utf-8?B?VndpYWRKK1BQZnlEQktiZUdTa2tjU1pNN3c5aytGalRrZjZYUTZ5VFBsNFdt?=
 =?utf-8?B?RHYrRjRISjR5cWFCWXJpZHFEdG9vZFNuL1FUWkhNQlEvT2JBWEpMa1B0amNy?=
 =?utf-8?B?ZmgrcU1BWVY0cTB2QUdkNy9GN2pBMnJuQXdNRHlBRlJ4Z1EyUWVwZXJvN3ZP?=
 =?utf-8?B?cCt1TzM2TzA0RjRKNnJHbS81TWk4NXF1WjNyTEs3VnJ0TGY3bE0reWsyOUZH?=
 =?utf-8?B?TDJaUGgrd3JZT011WUorem5BakNyQkRiU01Wc1FKaVM4UGo3U1pta01Dd1ZC?=
 =?utf-8?B?bkR5aUNzTjhBSERhdFJGb2xIZCtiaVRTVWJJRnpTVXY0cWZsTmd2dHYrTHVL?=
 =?utf-8?B?QlB0dzRwY0Y0aGQyVEJndXB5eHNmMWdLWUhVYUt6TUc0M0tpMEJpcmZpVjlq?=
 =?utf-8?B?QnFmMkNzM2s5dFJTeVZLRVYydm12ZVkvRGI1cjAyNzVnaGllY09nMExJTFhh?=
 =?utf-8?B?TnNtUkFwMnI5T3pqeTdhVXlUUWEvSGR5OWljVEdyZ2RTV2Z0UzFYamNzcGcw?=
 =?utf-8?B?ZkVKa05tT3dqZm1tTW9mK3JocGlZUmVPWGR1RThWVE4yRHYzL08vblBhbHc5?=
 =?utf-8?B?U1E1VW9pYTNOOGxtUHJPd2M1eDhMZTVaKzRRNnNkaWJFMU5UZWo4YmNYVy9w?=
 =?utf-8?B?NjVkVjZLb1ViVnByajFpdlVzR2tCQ3NjUEg5NEVHdkJiV0lUNDNUSDhGMTlE?=
 =?utf-8?B?R2xaaHZ3OXNNSHBPY0VqaE1tQ0IyNTk5KzBaNTUzOXMwdS9XVE0zSEFNcWFN?=
 =?utf-8?B?a3phWnMwZlQ5SGlramdzNGdGbVVmV2YvMkhGSWZJcHdRYVk1Q2ZmL1VSemhU?=
 =?utf-8?B?SVRHY1BOaWJUNUVyL282OWcxenFxK2QzS3M4ejA2T3pETlc2dW1penJScXFq?=
 =?utf-8?B?N3BwQjgySFpuNkFaMzZ0SWhJemJQY2dVWGZqWkhFM3VyVUxQeGdQdEFrc201?=
 =?utf-8?B?OEFlUXhmSlB6Z1hxR0kxWU1ENzBoUVdzV3UxTXVCT2I5TEdiZWtoSUcwb25Y?=
 =?utf-8?B?NVNaSmhOQWh0Z2diV2dkNVY2QkdFQk5XYi9VQjB1SlBYRURJd3pPckZPY0lP?=
 =?utf-8?B?QW5uQzBuZ2I1YUZGWjFNSGVwYXY1Z1hvcCs2Z0FVV1M2eTFqUnNNdTNHUGdj?=
 =?utf-8?B?SENpVkV0c1B6aWZrQ1JoaUdGMjQ5STYvK093eVp1M2RDZEdUaDBNSEc5UStG?=
 =?utf-8?B?ZFFvZXNOTk1tSmVIclZTYnJTUXgvTyt0Z1dGT2Zxb2xLRlUwL0E1N05hcHZ0?=
 =?utf-8?B?U1NyZ1ZjL2JCUFN1Tm9NeTQrWEU5OEE1NENabG5vUmpwZ005T3czK0FMRzdH?=
 =?utf-8?Q?VirXFX+SYnsakItU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <617F56C2966576468DF109EDF6EFABD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iG+U+FMRl8zd2/SMftLEE+ljV4rzosv9p2aCSo1z9Gt3aWj0f1AGMwW3U28d6VeMj7zU+XwN2K3noxS3BDsX7LWxheY0ApDKp++pbUY2vFUUd1mwiQTS+GcfkF32zN6P5F74o6VIj5ADCVnnpkx8QLor+Fzyw8is5DiCpDdSS2Po1Q4YEik6gtTs098jdWsAqGEfS2kJY3ADPILHWkYkoRxYzVNtnDJuN+Xy6Uzo2nROuxLyIBjXalnzIZo8LB3kOzP0fgD9PQgmBxFombjqBLsUe/MubNA5NUKwQ4DrZiFYYz2sOauMbI+823ccJRQBlFYcEZeDwDmmzeUY3yVLyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84332cb9-e165-4133-8c89-08dedc6e52d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 21:25:52.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +v7K097GbSCwjGrHBKCiucNUSt5MPoe1O7JqkwoMxutEjKstpq4KhATbL3FBphcI5mARggVO/CWSBrHTQoTepFp3+ze/lYZkoYzKvZg3T7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6867
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDExOjU5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MDZQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KGNv
bnN0IHN0cnVjdCB0ZHhfc3lzX2luZm8gKnN5c2luZm8pDQo+ID4gK3sNCj4gPiArCXJldHVybiBm
YWxzZTsgLyogVG8gYmUgZW5hYmxlZCB3aGVuIGtlcm5lbCBpcyByZWFkeSAqLw0KPiA+ICt9DQo+
ID4gKw0KPiBOaXQ6DQo+IFdvdWxkIHRoZSBmb2xsb3dpbmcgc3R5bGUgYmUgYmV0dGVyLCB0aG91
Z2ggdGhlIGNvbW1lbnQgd2lsbCBzb29uIGJlIHJlbW92ZWQ/DQo+IA0KPiBzdGF0aWMgaW5saW5l
IGJvb2wgdGR4X3N1cHBvcnRzX2R5bmFtaWNfcGFtdChjb25zdCBzdHJ1Y3QgdGR4X3N5c19pbmZv
ICpzeXNpbmZvKQ0KPiB7DQo+IAkgLyogVG8gYmUgZW5hYmxlZCB3aGVuIGtlcm5lbCBpcyByZWFk
eSAqLw0KPiAJcmV0dXJuIGZhbHNlOw0KPiB9DQo+IA0KPiBSZXZpZXdlZC1ieTogWWFuIFpoYW8g
PHlhbi55LnpoYW9AaW50ZWwuY29tPg0KDQpTdXJlLg0K
