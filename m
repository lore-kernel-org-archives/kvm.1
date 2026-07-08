Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AC3B47EE;
	Wed,  8 Jul 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476624; cv=fail; b=LKhGV2l6hrHEtEXCpaFiL0pQBlpH+MoaGYsWB3UZzegKc0BObFle8Lera/cvnOpTqnOydz2kNPAATeRnMBzrTup5PxmAXbu+GEn0VcXSHoMJJoiryYMFXwzgFf1aMr5kkF1fkWVEAKd8nc5nGwk1z4l1gO6GzXkO75MayHKfGaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476624; c=relaxed/simple;
	bh=xoSAOgTJbwY2P2Mh8rifel/4JaTvzqgtdcUEy/fKX2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYs7OP+9guHFpwYn9eQsKvYIIuOyfsrXx4nQY97xvXRCfJC8n2VdzuSOV9VJsr7KYlG96yX10j/1NZvPHV3sUEFoqgjKjjBOwH05CrhkL3FZbq3NtV8i4/I4rVOfbky/aR4QT1nJZKciCiP1D9RQS2pcc4przFe+AmxmRDsTaJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDpv560n; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDpv560n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476623; x=1815012623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xoSAOgTJbwY2P2Mh8rifel/4JaTvzqgtdcUEy/fKX2o=;
  b=WDpv560npTQSkDSAE3j5ZuFI6AxE3+Nu3VJ7RbIiDg5oc5/8v0H2w12V
   /+v5ie6b3iTUpx9h9li2YzgosnfRPky14Dh0ePJjt9cvVh9TFpuAhiRv/
   wZHhhGO3DkDitZssneSOO59a4x5yvCErmz96Dwc8qF5/5MMYdSw1iJGmI
   JQ5f3jHOVlJLeNNLIZ9XG+/GxuJbYVjcODlsQOwyE/ZwBPfgqwB3U+j4B
   CkdeP6eHmVAynU5+9Ui+ov2sJjdjXvkpADDs4rZl36Zv3d4d2zuhC8zX+
   Z8kauvza4eYDwv7tj5TqtvQCGMdI2Ylj423ek12AHXJ09AApz+oVF0wO8
   Q==;
X-CSE-ConnectionGUID: hffD2bVKQKe7rBiQ4ItmMA==
X-CSE-MsgGUID: JODYc3fwSyeUGLzJOwpSEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94739028"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94739028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:10:22 -0700
X-CSE-ConnectionGUID: jOTdz1jeSJCkxaVo5ECLYw==
X-CSE-MsgGUID: JzOy40+0RyCVLKxi0XwIag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258034080"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:10:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:10:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:10:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJOo+hIwh5CrHiFf4ii/iG8MRmscJpKCIXUU8f8MQmhjmDyzhfW3wud4JOnR8+sJEDmTizisajjfl5aoEBOTIc15tCDv5lDE8dCw1cu4zb2A/4k52eDmtvUuX7QDjiNEAmJ+Q5yzFN0ykwfhUXnafh4aq8zhAN94kOg10HNNHM2Ku1j2YaXmTKEi8C4IMVnpfcQh/ImIYCZ2Tlmrg9TB7hY3tkIbYl9RxOVg8LCQYAUFt9SLcFPUCuSm0mL1pM/DCtmEUfVcloMvHd+8kRP80rez+XM+JVXFNl9v7bRZlA8qx8YpFmFfSRWnwIwSEcIomMnwqZuG/dlfGv46XUZPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoSAOgTJbwY2P2Mh8rifel/4JaTvzqgtdcUEy/fKX2o=;
 b=n7gk4T4dHL2Q5GCH6ypwxt9ivCzUFUfFaV/iJmVqSfaQ8p2/8DPyfhO8I0FcNu5UySw4qQA3gtGx7kUbbDB6pN6OI+Fb/7YNfftLaLpKW91McTmBcMPXLGFXG1b0KLCLAzd2RN5hYpY+Gpj2hdchgrJz6XFWYBn+X+wQvdBLEcI46+yXzaeyK1myUSJKEh4LSQUqHkmRxy7MOgcHi1Cd92UZTPsR5doZoeZO0Ch8D6KFlVZb7J/pWVIAmmos/vlk9E/UwUHAofQOE35b/TQgt3xMGjcpoOElVSqhjiNVyVhLIGQLUXb+8zcsjnN/lBuhykSqRTDVfA6pFLtorNxJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 02:10:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 02:10:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHc7LhSIZlCRlcQpE6fbqoCJ0ANmLZjDbSAgAAVzgCAAADYgA==
Date: Wed, 8 Jul 2026 02:10:08 +0000
Message-ID: <818e0de368588836810718106e3b592323aaa0f1.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
	 <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
	 <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
In-Reply-To: <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7011:EE_
x-ms-office365-filtering-correlation-id: bf5d8e38-4571-4204-335d-08dedc9608b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: p+D+jHlsVCDhtdPW4ovoKKuK8ApRrz6gK9IXo7PTWNV01WnMQo1YU2tTIf3rgoz533UGACk+DlkspU9fWC35sWwixNOr+YMrKaiN3exTwRS/EsWGTwAShsWg8SYoL/MWqszMn0i2oSp7PEBov7r1rgW4igeIMbo+lxqwhrj8rq+UbtGVgIcdIUMFtXBEsYGfVW8/N8d8v69C1ZDrbvO8qhmaHPxqxrYbbAZesLvNx7IiOowzMtxHFtDFAQ8+objw2tbAUyQZzQ4JW9F8tbddopz/aC637eyS0mKQOmtjqkFxWmZGACiZy916+vf9XDxmg0VnMj70urf/RXYi8i/CffKNqHf2fJb0uFTo5ITj4oZFDD1wy27qL1KCVPSQqyJMs00TQatxZ3qbpJndoncsxi8dE1Ahysv0N13zH/v3BJuUpPdSKeFTBeIAqjSxjr1gK4JuAlPAhlhD1tOm3FIEdG8hFhznimMnsqaCfp4ZwPa6/p3XX9Vlas+PLErAqUwt96awKmtalhUWGVuC1kM+fi23KGwuYhfVnggnATq4boFeWGsZElW2jjUXzpsQ23oum1HZn83A29041E8Y98NJQC24NeZSecO6SFq3WRio6p8LIQr5yzvb/Ms/6etqTyFkmHhh2FJupnNVj9+vMYMcZQwAu8vJmwq2RnvLsBGX13D8aWdMTddPBGsc6zP7gIlyrZ8baTohHaVynevh/MvpwDOnheSwvCqV7oxw2VCygRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emEzNGdTbncxamxyeHFMSlJLVllPZEs5VlFYVlpQL0wrZkdhaWpheWNyRW5L?=
 =?utf-8?B?em1TSS95SFZHWFJ1cVB6dGxpYng1SXJ5V3NjeTNlQUZSLysraVkzRVhoMjhj?=
 =?utf-8?B?Rk1id2d0NExhWXdDRHNWeFZCTzk1d2xodnJHRmdMNmdoSkk0ZGxPVndJWkdv?=
 =?utf-8?B?Skk1ZUU1WVBPWWwxK0pEUWlkMnJJTGczck9nT0E2c3JrdU5NRHpYT05aQjJS?=
 =?utf-8?B?S1o0ZWdRbjIraTd6UkFEU3ZZMFdQNHN3TDBrVlYzeFkxZVR2WWxscUI0SjNS?=
 =?utf-8?B?TzlyZWRxTHFSK2ZXUG9vNlhaNUkweGpHb3JyNTNITmdhZ2tjMzJSNytQVldw?=
 =?utf-8?B?S2J5aVdMUll1Y0s2T3pvZlNPbnJPNzU2NVFGUEM4TTAyNCsyYkRCRnpPd1dr?=
 =?utf-8?B?K28wRmRhWnZUdFg1UG5QbldhNVlRYWFoUjY4Tlp0UG0wYTcva2tsK3pXUTBW?=
 =?utf-8?B?dEMxN1ZDKzlSU0VXYkhWbklQdS9LY2psK0RIbDZ1c1pBeEJRVHVpdTdDOFJD?=
 =?utf-8?B?UzgvMUVvd21jdzdIbEdqRWtycUNQZ081QmVmanAxS3NjYS9IbjdGRGZrOFJm?=
 =?utf-8?B?V01oNWZTcEFlK29keVhUNEZYRzhrbEpSQUlWUkRMRjVMQWxRVmpRNm1lZm1u?=
 =?utf-8?B?UWFINXhSNFNONDVyMnF2dkN1MjdES3ZFRGtRMnpMRDR4bHR4aEVVTlZiNkto?=
 =?utf-8?B?cmp3Q0s2WVcrUkhvaFhYeWw5ZmJFcWpiUkY2Y2dUNHhUQWdvWFYxQnN1S0xF?=
 =?utf-8?B?dDBjWUZ5R3ZpbkpkVzhyUWlaSExXWTJMamFua3VESm5hMmdHWVB5UE1FeDIz?=
 =?utf-8?B?c0xrZHFVKy92RDhxWkxQdVVpdU1RQk0yZG1QenVmYU1OTHBZUFdwRFN6YitC?=
 =?utf-8?B?T3FEdXMrdlBLZ2lsNW9NaFJrUlErclAvQWtuVnE2SVFpcS90UGgvNmNjK2Ji?=
 =?utf-8?B?enh0UXM3M0dmZGNYNWVmS0pYaWorUFRGSVl2QlNPTW1Xdk1ENDZBR2poOXA0?=
 =?utf-8?B?UCthWGtwdmtvbU1pcFdOYXFQWmpyaGN1c2F6RFp1dnRjbUFWR01vaU1TN21W?=
 =?utf-8?B?QjVuR0toZjU1NklFZE9vNlVqRDRxRVk2VUJIMVV1SE9VR1lnMU9odUt1N25D?=
 =?utf-8?B?MUlyOFRLZm95WUNNbGxwNEkwSEp0a09wWUhIYlhpV2hySllmY2QwcUpkczBh?=
 =?utf-8?B?VkY0TklvamZlU2Y1SnZaeWNySC9HZUd5UzFJMTM0NUJFa2duYmJRbXRYblhJ?=
 =?utf-8?B?MUZKM2JGOEJ5TVE0aXRvVE5KZVNVUmZyNDJwbzh0b1pDNHB1YzNkSVFRNDhE?=
 =?utf-8?B?d3ZvK29pSkdjUWJRek5uQjBPNHI0bjJnais2bWpvWjIrMzBRZlB6UnBwMDFJ?=
 =?utf-8?B?M0xrQU9jQjFrQkMxVTdvcDgwWU1lL0ZNNW1KZHFMV0dqZXNDbHRMSkdyTlpo?=
 =?utf-8?B?ZmxSUHZraWUrNDlTZEh5anNLZXdPaWNhbHZwaktZSHk4ckV1WGRXeExOZDlz?=
 =?utf-8?B?K1UzK0tYTHA0emFRM2VBRjNYSS9tSEJXcXZzYksrYURLc0xXWmM3VXp2YXVm?=
 =?utf-8?B?Zlp4dTVLaU0zZENxUlBpZnFuSCtHa2RGQTVWY01zeVp3K3FQU0JOekNmaVhK?=
 =?utf-8?B?NTNEdnNvSWxROVBBbGhsVXRsTml1OTZlbkxZVnRlMCtqNi9obG5WbXZVSGRX?=
 =?utf-8?B?V3o5M29FSERwL0I1QzhOV1Fwdk5VclczcVA2bGxINFp1WjhaVGhvQk1SK21B?=
 =?utf-8?B?N3hrN2Y0QkpJTkJrSmlxUmo1YmpHSmJ0alNDZG9TbGxwODhublpJUzBmdW5R?=
 =?utf-8?B?R2tRdDZlZTJMLzVCR0pOMnB6Y0xSa2ZmVU9QV01TZHlJR1VMWUhnaDBpek9j?=
 =?utf-8?B?RzFxQ2FqQkJFc1pVZlpvY0Y5KzF6OEtFVkdGWGtSZnFtTE5STHAvTmM2NkxJ?=
 =?utf-8?B?S0pEdnNJb2tacnhBYXZMY0tJRnZRMXc3WUJERVF6VTkxeGM4SXVEME9Bek52?=
 =?utf-8?B?U1RPY3Yyekw3K0NmK21nVjBDaVhEdlZibURtckwyZytYOVA5NC9SVXRsZ2kw?=
 =?utf-8?B?WS95WTdMcGQ0eHdNN2pLaTIrSjBGbUUzck1mcE1JV09DUnhBdUJKY2FBTWZ2?=
 =?utf-8?B?dFRuWVl5N2dWMU9Ka2NOenFhMTduSVliUWlrZVRXWkRaYTZJK25Kd0diNklQ?=
 =?utf-8?B?dEFnQ1psZzExTkRpZXg1NUJIUDN5YUhMYlhCSUZZdTVoNnBFeFlSZ3RIa2xs?=
 =?utf-8?B?azRTY0k1SU50eFVOYlQ2K25wdERmei8yU1MzaXBFR3kxd3hFcE92QjZwZWxY?=
 =?utf-8?B?elk1TmxQQzBneEZTTVExeS9qbnQzRHhGeTZOdDFOL1h3cEg1MnhPVVJSa0ts?=
 =?utf-8?Q?geCWFD19INv8EDoo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE2BD9F4B47AFE4490D70A034106B8B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dlbW5Dm2AZAmW2Kkhi2CL5TFHWnTHYKGE7rctVc9vcAZHRLnZDnQIxf07PsUqFs7Wl2yAMFnA0Qg4Bw/Cw0BWjxoHShApEGbn8LaTE2X2eo5zmB6/bpV3E6PpPBpMwqUpnYpuxzlwxmYDf5Iw+P3taZ1SURAVK9axCSFaYawc16Ph4KKrix3dFy6QYLyuM3HZX+126h+h2Bfe5f5wKf8NwhRFiDaPl+BBQiTfw/W4emW2wwsGsWsJ1MAoWjjYs+8twJT68OjuDNv1p/PI9ZGrcxWBkpyEFB8QRzFZnl+InyWGKPy99bsgOITX6eNxhgtYNlKav1KPXaB7/mHdWcPGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d8e38-4571-4204-335d-08dedc9608b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 02:10:08.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hW+DbklcpWrEGENdYMFqccaI48VbPvfmhvSMNC8M/OYMDY/adV+YjY2Q0uO6zm/Yn4VJbsRuN1RijALq93Lxh9CY2GU/hPIb420jQG7JfFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDE5OjA3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiBJIHRoaW5rIHlvdSBjYW4gYXZvaWQgdGhlIGNvbW1lbnQgYWx0b2dldGhlciBpbiB0aGF0
IGNhc2UuDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0IHJlbW92ZXMgdGhlIG5lZWQgZm9yIGEgY29t
bWVudC4gVGhlIHBvaW50IGlzIGlmDQo+IHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoKSBpcyBu
b3Qgc3VwcG9ydGVkLiBUaGUgY29tbWVudCBzaG91bGQgYmUgbW9yZSBhYm91dA0KPiAid2h5Iiwg
dGhhbiB3aGF0IHRoZSBjb2RlIGRvZXMsIHJpZ2h0Pw0KPiANCj4gSG93IGFib3V0Og0KPiANCj4g
CWlmIChyZXQpDQo+IAkJcmV0dXJuIHJldDsNCj4gDQo+IAkvKg0KPiAJICogVGhlIGtlcm5lbCBz
dXBwb3J0cyB1c2luZyBURFggd2l0aG91dCBEeW5hbWljIFBBTVQsIHNvDQo+IAkgKiBhdm9pZCBy
ZXBvcnRpbmcgZmFpbHVyZSBpZiBpdCdzIG5vdCBzdXBwb3J0ZWQuDQo+IAkgKi8NCj4gCWlmICh0
ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KHN5c2luZm8pKQ0KPiAJCXJldCA9IGdldF90ZHhfc3lz
X2luZm9fdGRtcl9kcGFtdCgmc3lzaW5mby0+dGRtcik7DQo+IA0KPiAJcmV0dXJuIHJldDsNCg0K
QWN0dWFsbHkgdGhpcyByZWFsbHkgc3RhbmRzIG91dCBmcm9tIHRoZSBhdXRvZ2VuZXJhdGVkIGNv
ZGUgbm93LCBob3cgYWJvdXQ6DQoNCgkvKg0KCSAqIFRoZSBrZXJuZWwgc3VwcG9ydHMgdXNpbmcg
VERYIHdpdGhvdXQgRHluYW1pYyBQQU1ULCBzbw0KCSAqIGF2b2lkIHJlcG9ydGluZyBmYWlsdXJl
IGlmIGl0J3Mgbm90IHN1cHBvcnRlZC4NCgkgKi8NCglpZiAoIXJldCAmJiB0ZHhfc3VwcG9ydHNf
ZHluYW1pY19wYW10KHN5c2luZm8pKQ0KCQlyZXQgPSBnZXRfdGR4X3N5c19pbmZvX3RkbXJfZHBh
bXQoJnN5c2luZm8tPnRkbXIpOw0KDQpJdCB3aHktaWZ5cyB0aGUgY29tbWVudCBtb3JlLCBidXQg
b25seSBnZW50bHkgbW92ZXMgZnJvbSB0aGUgYXV0by1nZW5lcmF0ZWQNCnBhdHRlcm5zLg0K
