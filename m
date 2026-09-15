Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714704A4F15;
	Tue, 15 Sep 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507161; cv=fail; b=AtgAb/pvk8r7p14X+2X6ADTT2xQ94MkUia7DqwbF6WEWUgvu8UmXBOrUp0xH0gQtvjEeEzosMyQDBNTip+aAjNxMa47j0UIDgSsf75iDt5a7aaG4100u1bzmU95PSJeUNJUeyPBd1b+Rr99/VRaUWDnDswV1Eh/p53UEW/3cO40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507161; c=relaxed/simple;
	bh=zATacaI7WbCBKIpp0KDYXIfSVCn+j5zwPFGcoBfpdZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocMMThhzqKh2ImR77iHPb5A0WN4+/s/BgU0prmrRmnQJnuJjCdM3bRKRVbPN/v9LR6XEYR8sVvVRDGoYNNad8AHGLaDSD35WP9kHnTVdtScztFUwxa31S1BDOheKYa/UbbNrcNOJT7xCUGuMPqMyx7UkEMkeY5u5oGjAPckmn7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VErq3SwU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VErq3SwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789507160; x=1821043160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zATacaI7WbCBKIpp0KDYXIfSVCn+j5zwPFGcoBfpdZs=;
  b=VErq3SwUSucNwa74VXrBd++gJTwSUxrcFuGgjTnK8vbPSldpetdOlF7G
   dpftkWsNnf4saBOkMt6PlUr6u6JdCw6g0ucsym6kGQPi7/a6HWnFzr6LX
   Ci628fFjAZeQwqMrpTCaX7WJK/F4Gl+qE8GhLB0ZzUKvQdDi7igO7YAxJ
   BEi7yneI9Zjg7jcplyIS3UEsMisW4pz7FJoUECSj1/brzXo9kFmwMpe7V
   Pz3PwGon7z4WOsUC1MepsCmkPvNtuR8AKceJPnYt2m3bInK4M0T66fpwh
   qmbtW25fUZvTJrpYtOA5qYuw6avwHYCtkJH0adHzSC0Y23uzVLo9QnCOJ
   A==;
X-CSE-ConnectionGUID: gD24Ntv5QFWyPkFyLwxx+w==
X-CSE-MsgGUID: F4aSxO4OTjC1VDKjnUKWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93583753"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93583753"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 14:19:19 -0700
X-CSE-ConnectionGUID: yaE0lvrcTzCwip9cyGILrg==
X-CSE-MsgGUID: YbHCfb48TQKg/Ms4wlOuxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273671642"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 14:19:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 14:19:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 14:19:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 14:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWN1vJON0u9DnquB9PrnPYl68x2rs1hGauWFrHI1OwdnxHrCd4bxzZVRSVDArKoH5n1e3d2KNSooV5tsrLY0Ysw8i/R63Jd9YYgs+fVQSRI3ZSv2lWVQuJT/t1mXRkmpN7527wRo8f3mLIgln5v1ysB8neRhP4go/hSHkv0wFQpAL6XGKywytbRm5IDF2liQF3tvqf7Jggnn3ayF80pQFZT78LwleNiEhjxJFBLA8LRMysAMJYwtiCgc5qnF8Zk5PDya1cuxtrWRJLY5SsN9BbYzuM3p5yFX+2oFdCrPWOiLszDGZx4xSgIscwcZ8kOSNuW+99Ln44o2TZ8qFIBFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zATacaI7WbCBKIpp0KDYXIfSVCn+j5zwPFGcoBfpdZs=;
 b=SFGfXFuT/uCU8uR0aZwI6SPrfSa02+N8nirf6sipJ24SF6QTREq8GKZSK87LAbc97xUo7Mn3FL9DIMwuzn74k11Gq+xvm5yj82qZtMjGsoGSBBWQP4Uj0GhA2fgIpfBulV2HE8xd7GJEcVcxDqOsggwJSvzz4Oduxjx4KHZgFMOZsfqDyaOKuXhwA+2VRPzoLf72f744FPHn+WMSkJ0NTc0W0vPGgijrIpCIYdMWMwAlOtG4cbO31iIjcKF1uzmso+MkNlK99ELTBrYxVZUSWYnIc5NOX1XcDthVlV6aZgpgJdYqovp54o+OS+SJrYygb0w3KBB0lgHG3BJmdkZpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 21:19:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 21:19:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdRPzUAgI3EnvfLEqqhXkejDFLQrbQJb0A
Date: Tue, 15 Sep 2026 21:19:14 +0000
Message-ID: <c373197ce8a8a7238696ce94bcd3dd7ba8be092e.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-5-yilun.xu@linux.intel.com>
In-Reply-To: <20260915102658.713079-5-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH2PR11MB8777:EE_
x-ms-office365-filtering-correlation-id: 181ea81f-1e44-45c6-b4b1-08df136efea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: HgZe43lG3/oMhUg2Cqf9ZGhAeaeCsmip0f/c/Sj3s4dJHjAg5g4/T2x5fx9sLhI8GwHC6XuJZ2qGb2VW+l4b3Jb8GCsW+bUcl0cdPiOn3hQSUC7QeqZ9zWHrWcMCsoa7IhfSOe2GdJ7fFSCE7gIxfiU3WATHopMh986YFKnP2JG0O/HLLXI8HgtX+SA3CgUnTPqqrVI2E7W8qMgOGgXnFCDVwWKb/+XSYm1SHMkMpYgjwqlOPLLA+ZyCRZZz+UR9OmcphFt8zgdbPdgM5orSuLoXMWZFIg3dhAsF5up/CEd7iZGmI38+Zovr9vW40hnFl8Q5iNTuoY2k3q+ip4IiiKRIwkIUpKQMb52/DWoiqMUKkjCDWaw3eSYBazP02ezXxrXbENuq0pM1Nj35MwalpMzk9btRX9X5jCEuDH99JpR0H8BWToaeoNL4aS62IZF+uCegORRLoodpw+N3C4eGOjPc+hltt72D3gu+Ju8/Cx3A2Lcr66vY+wkXqZBqPOoqlCLJ9FinvZhzd6joOu52+P6ScBvZUVut8Y1cGyvTeOoJsRx913XVk9KKZMVANyP5FvFo4e8IL/6jJ5kKu3PSl6ApG8Y+YOKStMNNdoPsPvc8OfJ5Re+1yW+GCl/b0l8Hhi1H6BpHvoF66ds9iVrlrWvJWkPFZUq/ZDQdA70XGXRmfqqDGXbmICwtWc827Q9EcMZ8Zo8CiNpfn33kDeLrzv94L/MAoEeu9q5dFM1Ptds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRyaklob1lSNHBwM01SdElhRFhGS0wybjFXRTBWTHVHdDdsdzE3bU8vUTY1?=
 =?utf-8?B?L2Q4cmEzekJzdWdCNXgvYm01c2ZFMUNBZ3JGTTVaVE5GVk1kNk9LSkhqQWQy?=
 =?utf-8?B?M1c2STg4MzN5L01uUU5hSmowR3NWWEF3c3FxMFUvLzJuUjJEM2lzM3FkWGRL?=
 =?utf-8?B?MWRCSWZXV3VlUlJiUmJOTk9QYVZVQmljN0w1dXNzV3MwOWZkRGVIZEZwd1Bi?=
 =?utf-8?B?RGlUTy9jdHpKVUROc2VxeU9MQ3NsRFdhdERwbXpkZ2xhVm80WkdoVkJiSndj?=
 =?utf-8?B?QUtvc1VrQ3pqUWRrNWFkOWxsa29iV3BvdEJXcHhaMWtMQnVoUnJvMFVvTE9M?=
 =?utf-8?B?clRQSWRzRnRycFlqSE5IMjRaN0FlOHYycnQ1b2tPVmV0VUpmQmVZWVMyT0Jy?=
 =?utf-8?B?QjhrTy9rWTBZWU5XeUg3K3VNU21Pb0tVMzVGNTY2ZXdUaVcyalJCeVJldytt?=
 =?utf-8?B?Y0t1c05lR0xsUlg2dm01cFFxMjFZWmUvK1F4c3A5UXNGUWtXdnMwaEFvSWU1?=
 =?utf-8?B?UFBtanRHQzJHQXJzUzIrbzdNQ3o4WjNVOFJoLy9mWEd5NDZxWjBYVVU3Q3c1?=
 =?utf-8?B?bytHcmFVM0duQjVpYjgyMWduZ21EcXpQYzQ2blhTOXdnVVE5aTQrRk5DWGlh?=
 =?utf-8?B?aWsyQnBQa3g3MW9NU3Rmd05QSkp3ZWhOM2VpaURzbjlLNUQxVTU5M1p0S29p?=
 =?utf-8?B?dDUrTWU2Y3VHdjVHbzRIMWpkVVE3TCtQdTBLbEVFR2IzQmcvaVM1UGR2Z3RK?=
 =?utf-8?B?Q1BIbWVINktmenJyWkxEOGlTalJ3WVAycUJoVnhGN2J5UFZhaThzSFhvMGVE?=
 =?utf-8?B?KzVzRDRGOVViYW43REh3TWUvSFJJL2hjRkRTcHFaeWthK1NXRTN1OFZHbUR1?=
 =?utf-8?B?Nk5JNVN6RUp3RGt0V2JBcDFqbHlRTlE0SnV4NjVvR0h6L0IyQklSSjhacCtk?=
 =?utf-8?B?MHVoOFAwYXFYT1RMSG9NSGJZT0lwOFVEYVdTOWRrbjVwUzY4MEFUV0FRelox?=
 =?utf-8?B?MUtuWjNnRTJiSXpGS0E4ZnM0WkdSQkRvd2FnaGxGNVZDN3U1QXlsSkVEV2Js?=
 =?utf-8?B?U1lvRFVqdUQ0VnFUZE9sWG1DMnVqYSs3NTljd3BxQ0xEZS9QUHhuNysrWUQ3?=
 =?utf-8?B?NHFLTzZsWXcyNnB0ZU9RTDJSaXJYV3lWMTh3amFoa25sb3dsTHl2Uzhvd2lh?=
 =?utf-8?B?Y1lleU0xdUVnOEpvRGNpYytiK2ZHR2NyVUcvRTFzRVFuQnRKRUhPVHpyNExS?=
 =?utf-8?B?V0ZZcjY2L05lTjc5MUJ4MDcwWHMrL0g0ODhRZ1Qyc0lRNmlSSE5lNHpOSmQw?=
 =?utf-8?B?aTNDTTRaL2RacVV2MUJpcW8vb1VCbEw5Y2k1eXY2ZGdKZjNZaWFZNUJXNjhs?=
 =?utf-8?B?ZEs4SzJIa0xQL3BhdDJ4RjdaVXRBVG5pVnJ3Ly9NM3o1anRxeTd4eUVObWI1?=
 =?utf-8?B?SXh3dEhCd01DdmRUSEdOd0I0Vk1kcE82N21KMTJPeXI1NEFTWldOalc0NjQw?=
 =?utf-8?B?dU9rcStPQjVRNlBWV1dIQWtTRmFWV3Y5QjVLTFNXempyMlQ2aTlyeXFBY3RH?=
 =?utf-8?B?YkdhZFV1UlpNRnpHaGNuMzk0ZStDNlphNmRTYVQwSDgwSWJSdG5ybzVHajJy?=
 =?utf-8?B?NytFN21LdHV5eGV1M2E2YVdES0VLd0w2RzNvRzFkUjY0Qk1yUnExeXVxeVg3?=
 =?utf-8?B?N1BRcFBUOW9UV0JpKzhxZmMzYk1JZEU0UnBrNGpUZmU2UmdKT3ExL3VaR1Bu?=
 =?utf-8?B?a3JXeDJLQzJ4eVlKQ2VrR3F2VTBGc3htaE9Icldpek5LZnhLa0pXUW54d0Ja?=
 =?utf-8?B?ZjRlUUFiYnlHQnVqNEhzQzhiQnI4cjVuQWxEN2NGU3Y3c3hXKytmTytnSjBE?=
 =?utf-8?B?REpKRXZaaDRTVzBycy9sQkY0NGNFL0xOcFRMVThwSi94QmsvR1Joemk2UWIw?=
 =?utf-8?B?YW5namRLUThub0VoQzBGVmVnbE9aUUZGSk5KYkdCeVpvNnY4akhudzdYcXpp?=
 =?utf-8?B?TFNkU242ZGloejJyclVDZUpQd3Y4dFZvSHBtL1Rta0FkVEN2cndZeDVDMStR?=
 =?utf-8?B?OEM4MFlBVlVBSWpES1cxdE5TN1pPVDJVU0w2N0FPQmI2RjZtQkloV2VLaVNr?=
 =?utf-8?B?MlQrRGE2dS9KSnNEU0pvUlFUaE9UYlRTMTcxYkxIRldIQlRGV1lYb25DN0NZ?=
 =?utf-8?B?OXR0T3Rzdno4bjhaWW0vcEpEUlpCMjZEcGdCeVRCcXI1OGtaYUV1SFpQU21C?=
 =?utf-8?B?WTF4UGlRb09IM0JtT1g4SnNrR2FnZElUaFNTSmtmOEVoYWtvTzlaQjdWV290?=
 =?utf-8?B?dlQ4U0RGVlMzekx1ZzlKaUgzbDFzU25YdGF1NU94ZVFxQXVYYk1nelVrWlp3?=
 =?utf-8?Q?hta05kJ4w5IDwv/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B9EB0D34129F64AA9FE16F4B92D25DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eQc56NtnuW+nKLNicIrlDp7yUvXUO2MwAnl/xPESzZ9nRw8mVGNHEHto3wbb7sZ2Xftpze5ju8S34g0WBAz951xYBRJS0/V9XL4K25GF1NHeLtAPlCNB/90wEGNlCS+9w2Fb/RGdnAwc8n7l4T7VNsxA8LomuMqmsVWF9/X34Z6RpLzqdvtltpkXa7nAHluUAQYioxAF9o6JfTq1p9dy/9AxjJkY+qstlohCFqXaIqs33edRxcIWC1sVGpkRAEwUzZ7UVSfXCcZAyPXj6wxv6FVNceFNgOd3SjhbIuVXLusTknReu8pjQOz+rD6xdnx6Sj0nze9uH6X3WjX7VwywQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ea81f-1e44-45c6-b4b1-08df136efea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 21:19:14.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Pqcf425dWqKYxiwFNeTpXy/4p73XiuYa4lUns1jV9vKh8hQXPTNMUoknz472MhwqDMvsOSiBMXvghRcj3iZ9i+fQslRbg964foYHCDMny4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8777
X-OriginatorOrg: intel.com

SGV5IEtpcnlsLA0KDQpPbiBUdWUsIDIwMjYtMDktMTUgYXQgMTg6MjYgKzA4MDAsIFh1IFlpbHVu
IHdyb3RlOg0KPiBBbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byB1c2UgYSBsb29wIHRoYXQg
Z2l2ZXMgbWVtb3J5IG9uIGEgbWVtb3J5DQo+IGVycm9yIGNvZGUgLSBURFhfRVhUX01FTU9SWV9Q
T09MX1JFUVVJUkVELCBhZGQgb25lIHBhZ2UgcGVyIGl0ZXJhdGlvbg0KPiB1bnRpbCBUREguRVhU
LklOSVQgc3VjY2VlZHMuIFNvbWV0aGluZyBsaWtlOg0KPiANCj4gCWRvIHsNCj4gCQlyZXQgPSB0
ZGhfc3lzX2luaXQoKTsNCj4gCQlpZiAocmV0ID09IFREWF9FWFRfTUVNT1JZX1BPT0xfUkVRVUlS
RUQpDQo+IAkJCXRkaF9leHRfbWVtX2FkZCgpOyAvL3NpbmdsZSBwYWdlDQo+IAl9IHdoaWxlIChy
ZXQgPT0gVERYX0VYVF9NRU1PUllfUE9PTF9SRVFVSVJFRCk7DQo+IA0KPiBUaGlzIGFwcHJvYWNo
IGlzIHNsaWdodGx5IHNpbXBsZXIgYXMgd2UgZG9uJ3QgaGF2ZSB0byBxdWVyeSB0aGUgbW9kdWxl
DQo+IGZvciB0aGUgdG90YWwgbWVtb3J5LCBubyBtZW1vcnkgcHJlLWFsbG9jYXRpb24gb3Igc2Vn
bWVudGF0aW9uIG1hdGguDQo+IEJ1dCBhbGxvY2F0aW5nIGEgc2luZ2xlIDRLIHBhZ2UgcGVyIGl0
ZXJhdGlvbiBtYXkgY2F1c2UgcGVybWFuZW50IG1lbW9yeQ0KPiBmcmFnbWVudGF0aW9uLg0KDQpT
byB0aGlzIGlzIGRlZmluaXRlbHkgYSBiYWQgdGhpbmcgdG8gZG8/IEV2ZW4gaWYgdGhpcyBpcyBy
dW5uaW5nIGF0IGJvb3QgYmVmb3JlDQptdWNoIGZyYWdtZW50YXRpb24gY291bGQgaGF2ZSBoYXBw
ZW5lZD8gRG9uJ3QgZWFybHkgYm9vdCBhbGxvY2F0aW9ucyB0ZW5kIHRvIGJlDQptb3JlIHBoeXNp
Y2FsbHkgY29udGlndW91cz8NCg==
