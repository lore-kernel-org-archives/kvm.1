Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0439CD0A;
	Mon, 27 Jul 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177425; cv=fail; b=cYbfo+Kv30QZ1cBc0hN0nLLWkhtLCfQotxXTCKJocuv6NA1F8MyJDTSPlLUcnXzpKZ30oz3eMq5b6Y/fgFVKuWCLexF0XrRG6x7MbcO1Lp42Uz1gHc8hYrbTrLUSoDG8boa3W2m3DhdCJoJ9gDPutbiI1TweixnLyfbS9zW2gHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177425; c=relaxed/simple;
	bh=sbUN63DzmTThp0bWsuaLFv3Q26ECWlFGBxlZy/u0HrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ea6HbNDF3hngXyjU1C+P4I5QlhIelzahH3FS2Zyir+6EBepdJ6DNOLgMbi+343Mfa+YDSgHOU/Is8FkuQsuK60mXq4Yz2Xb72Pz0rQN35/izwJCF/krmkoVXTnK40HjflRHds+cVJYvZHgZrpoXsVrF7IfFDkJLe/8gsFK1m8lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nfbcc5ng; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nfbcc5ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785177424; x=1816713424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sbUN63DzmTThp0bWsuaLFv3Q26ECWlFGBxlZy/u0HrY=;
  b=Nfbcc5ng9x4GfXghjjRBOtXNduozP8EeYLr35wD46dBTbbFyvKX0fjPA
   BpnWGDqx4bmTgFFfWpAeXWXCiWWa3z491Zx83WayR/Uoypl/cRdVBKYpR
   YHhy16hpi2rvl34iniEoDyrjQLtshnd4L97+2AFki+XpLG2YVebsapCnw
   H0QWA9/5AX3XI1xCfCx+IbPRKHZUI3UL9TxLbffMWBqMO8wltaWH/32VN
   eB1aA2EInMtzazOjDuL9ozyGUSbwMYIGDHWsL6vWRGKd65wDV2p8E3Lvp
   Odmp6yGrOAp9VQo9Gx5x11FXT2eYqSI+oqU4GF2o3cJKeWxt0lj85FMlJ
   A==;
X-CSE-ConnectionGUID: En2LWhT7RVSvYajq0Edf1Q==
X-CSE-MsgGUID: SWyW+IBBShi7nkzrwnKHfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85515942"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85515942"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:03 -0700
X-CSE-ConnectionGUID: L7316JoBQyWJP4KWJEFv/A==
X-CSE-MsgGUID: qRtvyIUbQq2O3VqOlMD7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260132611"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:37:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1makV1a5hyEPa/spnKjA2N7SVFZM1fG5zUeZ7GnIUzYXKAbo89TGmKRjVu5VsMtuOX1mfJ+vgL3yBWsb7G4lnAqsfpqHIVGnnnsV8zuVpTRYM4TtRXYKWVU1SwkIt8FrE2YrGyQneGDfPqWf/WHTtGwttlGwsHJG8nLiWay7Tk2sIhvOIZLo4CnXIlHHbXLzzwkfnvtdsOzo1oV1yPWyQTp9fMhDVbQNOpFpnf45BZzWgmBq6DvuTncxIv/RE/LR+NXQCww+7QtmIafXZF3OMSWfgV7UQ887pVJhjEIS65RDllOXbWO/lkTYyQTIXC79HDtVnpUPvTNpQx/qrPGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbUN63DzmTThp0bWsuaLFv3Q26ECWlFGBxlZy/u0HrY=;
 b=Ro35dCEhEG27/S2QdD2PyCzwfeKz+IGOekQH4A/tqwRSX6ljdM5ur+Np47J5xTIEFYBJAwZ6nAGwEtmE7hG7b0z/U2GN+Cwcy3X5OFyMv9My2LlD2sGBi/bXJGfGQXLYBdVWiF3dFyKfrEVoDl0BCoeSHxRWp2bD3iL1+Qmo/vDKLBse1Vww6eFUknGv8f1b0JCvjRUJP2LRjMTc/D5E++8tcbK/tAPVX0/1+hA+mAYOcjNoPEgYR4XJ9aDXElR/9/hAR/KqySeOWevDuQWISsqTVXSsOyuT8O/8LBCCUWm5ZOzoHtjmWFenrRQqCCTmfHzS49kxD2j7nK29wDUZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:36:58 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:36:58 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Topic: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHc/v3/H6yI1AvBKUSJMqGdHr9fi7aB8LmA
Date: Mon, 27 Jul 2026 18:36:58 +0000
Message-ID: <52e197961cd0c16613b63ed03037f9199307119e.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
In-Reply-To: <20260618081355.3253581-7-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: 0be7d06d-661a-4d5d-a15e-08deec0e0a6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|6133799003|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: HsI/ALuaHP2oD3mKzf/iLifn5lt3NUdUb4gJL/688Q2JvL4N3Qd8a9/4TChe2AsCG3+JrOnDNtynObBfdBwEhzeiA/EutvWt1O96PO6PlpDyQ0TwS0Q5SWJ0FG17SaFJpi/QWeMpcBr33TBnn9KbfXZWEluJY15myqd3AFv/gdTRlEYpt/g1a+IcNJh+ReY4iPegFQSbuablHC1f+s3ih6GPn5oLBPUt4MbSH6W+NVDO1oMGOomsp8pDC2BArSpsiUSKrQxkYZJ6e0zzM83YgwydRpHeV1mmDqE08VhEzWL4MECqC2tsTWafkddiYsdu7zlQUaMtWeibz8+dT9aIX/A+3wGYJ8tSSTZYFWtq03e08DRxcElC/e2Z0x3R5QBjE/76aJ49CSUwuRY2pKNDLJXSec1RfWzosoqBSAgnNtK9FO4HdgqXFnakKdhdBNHX6NCDnThZdVmk9kLDNdJPanpyOBm3BbqFuY3InL3ZVhtApVUzAlDGUgvGXz0CHSQtCHAvLBAHvIoC4glUPg9eaEC9tlkCyaTX4WcCOf6fmHcW6ipt+uqJE266B+5AC8OEQ7viTqs+MFPtLsGSHS4bHH6DdxQ1CMrg2eBhKZQOHllJCouCeImJm1pxaT0QfOryeiidPH5tTGRRhzc/G+SXW8SQOGnQxqGOW4O4x+DK2/aO/HMuxnrEqk7cCMoLhJ0rgMAP0d5YwakSxA3rYgjhgQKHODHwV8zBTnPV2X6SpvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzBTazhlVlVGVkNBanNFTUlQSThUVVNSbVZDQTdHUml2SVFZVHhEK0RRVjBt?=
 =?utf-8?B?dnpoMTMyUWd6bVREUHhCdFYrMVBnT2E1REt0ZEJVSFAxOVQ3SllwcldmWWlQ?=
 =?utf-8?B?ZUhINVF6cVJsak12K2pnL0xCbmhLNXE5ZHlpUEhwekVBZ0Q4UGxWNWlBNDNC?=
 =?utf-8?B?ajNQNWU4K2lqN0pBaWllMy9PM2UxQWtDcXVBZDRtN2lSU21lL2RPTFBxaEpS?=
 =?utf-8?B?UnNGYmFZQlorZC9wRnlDOHdsMmVnMGdvY3AzRkZhL2dzZFVEbGtUYkwwMW1R?=
 =?utf-8?B?alZQNWkrdXZWRnBmMjlUQkU4RzJ1dzZ5N0hibHBoZVcwTHl2dlEwYnY5dGZ2?=
 =?utf-8?B?ZjU2L3FHcEJ5dG5tTEF1RXVkL25zaUlabUx3UXpsTDNIUkEzL2hVbVZEYmJ3?=
 =?utf-8?B?MlF5UWgzMVcvd25CSVpzRTFGVFNZc05GNmh1SXRSMDJIUUptL1F2TDhnRFVJ?=
 =?utf-8?B?aDlocTBJREhtcHUyMlpVdHRWaHhQVzBYbVBQRFZuYmdadzNLRVVjeHVTZy9P?=
 =?utf-8?B?Ny9xR0hnNjlyNHp0K1V0T2MzOTdCWWFFbjQwekdaMnhQeDhUWFpSa2t3UTgx?=
 =?utf-8?B?SHhkTTRNVFZtekhaNzN1VmtkejBHQ1NzL2Nxa2grVVVJa1lwc2pxaVZKQmJ5?=
 =?utf-8?B?eGM0U1ZTbnphNy94ODk5ZTR4WkZXR3RQYmIwSmd2WVkwbHppYkpZTy9QbDk3?=
 =?utf-8?B?OHpJb3VxTjl0c3AwamFRdERYdC83eWczSXZqY29WWFNvdjlocU1YeHp4TDRx?=
 =?utf-8?B?eHhNWHFVRWRTaGNsNVdWYmJTUDZibmVHb2JzV1l0K2dwRHZvdTZqWmk0VGw1?=
 =?utf-8?B?K21sQXBoM1ZCZ3hHcUpGdDN4alVxRUhJMjUzK0lsa0pCTjlBY3RJWkdOMEo4?=
 =?utf-8?B?Z3FzZElhSm85QVlYNWRxOE9rQVd4eUdMMWxsUGh5bkgwa0M5b0pSL2xSczdI?=
 =?utf-8?B?bllPcWdIOW9sc29NK0cxaGdadGgyaTBkd0tVbUJFYkNSVktVRDUzY1RtdE9E?=
 =?utf-8?B?WDBzSDZWNlRPREZYNXA4MnJkWGhselU5ZmFaZFZKaWhOR2h4N2t3aHl6bGpO?=
 =?utf-8?B?OEtvRkJpV0ZxMVdYNzVpVjA1N0h2MDQ3THBtMWFmaGlMdXFWS1FOb1dPeERJ?=
 =?utf-8?B?MjlkcXJiM3F5Q09QUHhxMVJzWTBvcXZUdVBLOEVXWk02bGJVeUE2c3VrcjN5?=
 =?utf-8?B?cEM5UkdTZGp1Z1JXbzhvSDJEaURPcDVvVHptR0I3OUpDSm1xL2lUT2JTdGha?=
 =?utf-8?B?aHlxbld0cmdUY0tOaGlVM29yK0llQ0d3TG5lekQ5ckRuL1JtS2dKTlRNazNt?=
 =?utf-8?B?akpubXp1RVpiRzlpWjhOR29lb3JNWnhMeXFqbUY4NGtCN0V6UkpWWWl0a0Jv?=
 =?utf-8?B?ZHBFU1RjZnNDUVNjdlRTTkdJcHFZeTBJeE1mbGwwOGRoWlFwY1d6Nm9Rb3NW?=
 =?utf-8?B?VUM0WVNrN3EybEIwUHJEZk4xa1VzVTNLWGZacU9TSUM4elE3emRDMDFNNkVx?=
 =?utf-8?B?ajV6UlUvQ09nVW5iZ2JjREtuWFFvQmwyN1UzaFl6RWZ0N2ovZnpXV2NVS21y?=
 =?utf-8?B?L2NJV3FHSzUyVWtVV2dKeTlhZExacksrcVBXZTFlaHd1UGhpNTIyWE56Q01n?=
 =?utf-8?B?TGlYV3FpTGc1akdqQ01kM3hmZVUrajlmS25ZWW5FT2ZYaXprNjg3YnlCQW9i?=
 =?utf-8?B?SXh3UEQyemtqYmM5YlRZVW9YbmlFWEhTeWpla3VYR1F5MmQ5YUl2NnFZcWFm?=
 =?utf-8?B?emFtbUM2bjYyMElPenl2RHlocXdWbnlUbjROZlIxYXNEVGR0bUxndTQzSSt2?=
 =?utf-8?B?TENMVk9ibHU3anI0azFDajZSaXhLOVE1RG84SmdDbnEzZFJvSEVQTDNOeW5M?=
 =?utf-8?B?K09SbEswUkhZelVIYXBEUy9xWm9DaU5yVkNIKzVMd0VCWHgwZWI4ak5ZWWFH?=
 =?utf-8?B?bzJMMTRFWkp4Qm1BTTNTZG5kdGZheHpQeXhDaWszQ2RSVmpjdjRXNDh1SVI3?=
 =?utf-8?B?Wm40ZVd5NlU3TkRucnVsUG5xZkNIazRnemxHSVFFaXNFNUZKbTVHaUlKbWxV?=
 =?utf-8?B?WHBkWUpVa1phWm9ScU1Pd3VIcWVhUTFyV0JqV3dUb0gwaGdVMjdkdUZpNFBH?=
 =?utf-8?B?REpnTXJPM3pJamxUM1JoMTR3a1dKSGY4MnF4clRsVnVzbUozbVB3d05HL3BY?=
 =?utf-8?B?MzRxZTBJdEZrTmVOYm5Qd005eDRIb3hhTFFwYjJhVjJWUTRYZUV6RFlKNSty?=
 =?utf-8?B?ZHM3TTZGOStOOGovbVAwa24zekNGcVUreGFsK05DQWN4YWtCZGJ1QzJBQ3JB?=
 =?utf-8?B?ZmRDRFNMamU1RVRac2xOWUtraWxTVnN5dGFqZnEwTVl0YzBRVTZGbU43cE4w?=
 =?utf-8?Q?+b513zqx+iZADtqc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7635DB707EF4344384FA16893AAFE43C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FW/UWKJvj5GwE4AXg1HqndFqNnS+bM3+JmMvxEoHHMt5YrEIrXGVMsZyfcnu2HKkdb2e6tl7hdzQvRpdH5cpJwtLJb60Lm7WOYzsTv1RZaHmgSWvwAJ708EZ0V8cgXdepmFrjP5VUbJOP75WID8HcekT1rvNaNaQI/el989NeTXH12qxHPV50+TVRX+VozMEZg0B7qe6DJsdmu0iht6XYwkbc4V3kddhDFKZGfWYyf97n2ou4KwdecquqC3UJ/bv1jIqVbubiiT5g/mbbk9da5Ou1A6N+KTy/VxGKNnJnCv4JZhecZAjogYZv2/XxH0zf7X9BfDD4crHbe6CNO3dXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be7d06d-661a-4d5d-a15e-08deec0e0a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:36:58.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPz6c3z4SmBwiyXjzYCd1aSPMbmnSXHd1EPXKq2ufDRdGS0GfMF7UdsX+q5ufJmZj9f7cgYh3eNvnb8g3v0km4B0SI32SHCtdip2ohICPW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

Q2hhbywNCg0KT24gVGh1LCAyMDI2LTA2LTE4IGF0IDE2OjEzICswODAwLCBYdSBZaWx1biB3cm90
ZToNCj4gK3N0YXRpYyBpbnQgdXBkYXRlX3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lkKQ0KPiAr
ew0KPiArCXN0cnVjdCB0ZHhfc3lzX2luZm9fZXh0IHN5c2luZm9fZXh0Ow0KPiArCWludCByZXQ7
DQo+ICsNCj4gKwlpZiAoISh0ZHhfc3lzaW5mby5mZWF0dXJlcy50ZHhfZmVhdHVyZXMwICYgVERY
X0ZFQVRVUkVTMF9FWFQpKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXJldCA9IGdldF90ZHhf
c3lzX2luZm9fZXh0KCZzeXNpbmZvX2V4dCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJl
dDsNCj4gKw0KPiArCWlmICghc3lzaW5mb19leHQuZXh0X3JlcXVpcmVkKQ0KPiArCQlyZXR1cm4g
MDsNCj4gKw0KPiArCWlmIChzeXNpbmZvX2V4dC5tZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdlcykN
Cj4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwlyZXR1cm4gdGR4X2V4dF9pbml0KCk7DQo+
ICt9DQo+ICsNCg0KVGhlc2UgdXBkYXRlIGFuZCBpbml0IGZ1bmN0aW9ucyBhcmUgbG9va2luZyB2
ZXJ5IHNpbWlsYXIsIGFueSBpZGVhIGhvdyB0aGUgY291bGQNCmJlIGNvbWJpbmVkPw0KDQpzdGF0
aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lkKQ0Kew0KCXN0cnVj
dCB0ZHhfc3lzX2luZm9fZXh0IHN5c2luZm9fZXh0Ow0KCWludCByZXQ7DQoNCglpZiAoISh0ZHhf
c3lzaW5mby5mZWF0dXJlcy50ZHhfZmVhdHVyZXMwICYgVERYX0ZFQVRVUkVTMF9FWFQpKQ0KCQly
ZXR1cm4gMDsNCg0KCXJldCA9IGdldF90ZHhfc3lzX2luZm9fZXh0KCZzeXNpbmZvX2V4dCk7DQoJ
aWYgKHJldCkNCgkJcmV0dXJuIHJldDsNCg0KCS8qIFNraXAgaWYgbm8gZmVhdHVyZSByZXF1aXJl
cyBURFggbW9kdWxlIGV4dGVuc2lvbnMuICovDQoJaWYgKCFzeXNpbmZvX2V4dC5leHRfcmVxdWly
ZWQpDQoJCXJldHVybiAwOw0KDQoJcmV0ID0gdGR4X2V4dF9tZW1fc2V0dXAoc3lzaW5mb19leHQu
bWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMpOw0KCWlmIChyZXQpDQoJCXJldHVybiByZXQ7DQoN
CglyZXR1cm4gdGR4X2V4dF9pbml0KCk7DQp9DQo=
