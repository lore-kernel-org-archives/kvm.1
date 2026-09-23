Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64734331EBC;
	Wed, 23 Sep 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125769; cv=fail; b=J62adxhpVTXahPbmB6XZ3pTrOxpjx5lvoQDPN938a5CwHVirIGW1z8f1KXet1UwW1AAYIGYXthAuckFQiXjzOPS4rAKpAbrOlnrPl47eKXV1DfuY3dXdU5SV/4Uwjp5X2W1/EQd5z06Iby70krsaAmr51Q51srjvoNUKDJTVg4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125769; c=relaxed/simple;
	bh=Jz9QkQXxGkcjdW67qibSeRHLHGVTo8OIczu48fQV5Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1E0TS5S2TG7duKxx1YTvdpP9jXkAXKr7C4QBdUyUc99fEzES+OI6LtIXzbVDFyVT/TEOb/+FIVarI/LLG6Smb89RfifDacULn8Hu563yaPMrRGcYPdLZd7cZeVjV5azInh7NReXbD90a9foIWBao2IQnaS2z07UKQQcKIxAvjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jzrc9J25; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzrc9J25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790125765; x=1821661765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jz9QkQXxGkcjdW67qibSeRHLHGVTo8OIczu48fQV5Ss=;
  b=Jzrc9J25qSRwEAkFDvg5NCVqx2PakXSQ2pUqd4hsrbBrPldaiuBl8psq
   LTSCwhxsko3ehWNTDeKbyWHeZanWW6whUkMb6M8izqSEmDr5vrD0Z17jV
   pu3HQkWSWdwVStgAEJGQ12mLG7qpbUtmt83XSBaa3j/LDB+pKcUKCClWr
   9r2VwLcK0yvWJ63rb+c5sJBAG5lPFqa7PBHvn9jXe9r4OH8DI5OYMKmWR
   +9BBpeHIBcXLi12m2OD2FyWArSzHAuTHmCOdMdd69hzpNgu8Axa7q1GWr
   3PvpbH2O5LY4hYXd5ZR/G6Wld5am6/Rdya7Vm4S9RD2AryCuM91efRsxo
   A==;
X-CSE-ConnectionGUID: HmQ/EMzDSDyuYsYffODjCQ==
X-CSE-MsgGUID: UG/cw9jmSHWVFoGLYqNA6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89699525"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="89699525"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 18:09:24 -0700
X-CSE-ConnectionGUID: +EBjTunESFenBhMynaAfSA==
X-CSE-MsgGUID: FM/E0/RATRyBjAwxlATG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4666502"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 18:09:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 18:09:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 18:09:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 18:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDsaHOmhQzalG4TnGWiS4x0PCXtwpVpZwPaIBUU84gcfZ3w+pcPtJ1UQlpIE3bYTAkYdctqtCk2sKYbahPyErQEx37J7hZvdZtIR1sJOvwveU9widD8MCUuArY2vf2zUjAv2dfBeKPZnkemM+/yGPXcF3oPIVxOu/E5ZFcpYTYGBoAukkqrTgAYHNaH0ryrkxaYcxYCHn3f+Y8BHxeKbqrloEIZL7R6Z/F3GlanSdjVSqCjdeEJJI5Tvr7Izxup31eAe3mYdS6QTCQ01UC6PMGmNikG6m/FlJDA9Qrvp2dzeNZtdnD2XVaPZPbKlUKVuyUr5KrorHJDaXc1HYOGS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz9QkQXxGkcjdW67qibSeRHLHGVTo8OIczu48fQV5Ss=;
 b=shPTjNNReINb6wfkaADjDa8e2zk4KqSG/hEJa3z1rw2LsqpZaD7dTmCf/ucHadJU2lWtnIOiWSHuCnxCwMjKyQGo3rDqlHtotx/ogO4TunaQRCahwAOCO3stryrItVXKkJg8osm7lBFUg97NEpZRbWvNEzngBKtcGUI4gcyVrZpiMU6Y1fiSgltG1IC5rg+oGFoYdygh1tsOZ1ZGe//UScHlayS7UxloQmtyjfcDj43gN6IfII2pIIRSzqNijQkyNQWVofnYzQeoloYC+iTPXkaPa9v17qxcrXSK66ipxUliJ1En2ZCwpqrMOpQTU/ESPdEE34ALNkO5iUtw7uF6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV4PPF9BE730F55.namprd11.prod.outlook.com (2603:10b6:40f:fc02::22a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 01:09:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 01:09:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdRnUxZ7ir+OFvoU2rBazg3q+3u7bbUJEAgAADgoCAAAiJAIAAA3OAgAADVAA=
Date: Wed, 23 Sep 2026 01:09:16 +0000
Message-ID: <5168e058946a61f3be1cdb13f886dd632739d312.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-2-binbin.wu@linux.intel.com>
	 <a8ce5d830a04d99ec47cdc727e1761bd4031d544.camel@intel.com>
	 <5ff81fc4-d144-4b2b-8375-d2f63e0dd618@linux.intel.com>
	 <419b23f264af219da3be93a9d246b5401bbbaf13.camel@intel.com>
	 <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
In-Reply-To: <a436a059-b003-4e84-bd11-014bf2f17e97@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV4PPF9BE730F55:EE_
x-ms-office365-filtering-correlation-id: 1968e0ea-b7a8-4529-9f08-08df190f4a38
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: mFWWI63VuqM1QI+uoQemJ5IcAB3NqR6wwQD3vXY2F7raiq6wq+4DjeITNvNdE/hPHhx1XZkb1SVC1TskYwbnUnL3cC6Xz9DIaDReufKqg20Ool2M+xOnsN2w5RpJHs+v9LOgkgFEuml5OCsZy+DwndcjND5E/u9PatnIWQ75Ib5sxrv1fvYgACv/bG9yM873OxBXLEQYORPEDw3rahnYpdpK50aZA05plIGkmSceA60Mkpi5/a2DsETlGoP2d5loGnUPfRAK0BNWs7ed1iBVCSWI9NWviU3RJHE/owaFxh3Mhk3zHoandB7t27JmSh1m104zqnJBhh7JjF6U27Sv09sPDpG9F+u+JHUyE1GZJAu0H8CmjN5cvs7/G1Slrn6RlmhJXG36w8WgHclMeK/SFVQI90pDkf8CrBVXycbUn01A8j07/p90B6odKMJC1dOId1rVix3faWLU9QH3mhMJGzMX0dx9jP5xz2P9MCygJMedE4qN2QWWwaMj2JSpYO9c0ybHur2Lrs5K12993ZmgfcSgZC4+5ckL1uWtt9AzkYsl5xdpRgsyWDhoysZ25WjkrueK2vqMzvd1AE9jiXTEDpSMDAmEvbUf/AMYewMv/ebVivoI3P1gEb+vXym9fjsjhHORP6wpS/BFdu0diX74ViGdyUFf0sTKApgVSixWm9evi+y0lwBNatZxfgXd/SlRjRSzdL0zgoDGNR61MmSNSVmO6za8BFhIg/Aw87PCGuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUk4YzRWVWh3WVdNU2JsVERPMXhrUGVtMFVyT0xMdnlHVG8rT3B6bDJmNHJH?=
 =?utf-8?B?amFkeThhLzBidzhSN0laOFZhNnBFeGEweENiMDU3aWZqZTJINW50ZUwweCti?=
 =?utf-8?B?NXQvNTVoZkdNQVBNMDhoK3FsUy91N3UxUVpoVXhiZHU4VkZZa0R4SnZVWCts?=
 =?utf-8?B?bDUyenR5aW1MdlRBU2hmYThWK0QxSlJQMGVjOHJ0L1ZFenQrOWVJMmY0cC9x?=
 =?utf-8?B?WmxlL3lrc21uSWNvalN1bEpmSTdYTFU2elRxb2g1eE5Mc0FLeUNzajB5bjFs?=
 =?utf-8?B?N0hhVDVPNzA1Njh3dDMzYk5lajF4UXJNRy9Qd0Y4aTdwbGRobVlBMUdEaDAw?=
 =?utf-8?B?c1JVYWRVby9qTFAwWUlxM1VWR3l2RWFTWVU0bjlvTVNIL1kvTGdKd2FMN3Qy?=
 =?utf-8?B?elBSaGFsN3pXek1JVnFqUXVRY3AxczZESXpDS3J4VExBSDJxbFlram9WdHp6?=
 =?utf-8?B?M0x4T1V2cnMrcDZFVmgvRnRSOFc2c3hTTGxodFhHZ3NVZU5VSnJvZFJkOG55?=
 =?utf-8?B?UkRWVG5HQlpQcFpBUzZPcjdGcEtJYUNrNElMaWZHQno0cVhtUU9DRnhMRTRr?=
 =?utf-8?B?N2gwd2Z1UnVqV2xQcHV2MTBvbzlzNDNzOU1Uc0pWUXBpbEV6ZkxZK09jbU5l?=
 =?utf-8?B?c0kwZ21CYTBucU5HeXZzRVVMbmNxZG01bmtOOU1kbC9YTGZ4b0xZTktKWUdp?=
 =?utf-8?B?UmJIQ29BckVGMzNQVDd1ZXlmRjdSK3J0alBHaVlBRGZ3ejNoRE1id3p0cjU2?=
 =?utf-8?B?OTFSK3E3dmZBbzJMVmF5WDJoQ3Mxa3pJTG1SNlVMVUs3ZUtFdS9tbUN0cGkw?=
 =?utf-8?B?ajJ6OE5zUEpNUDJlei9WZlVJcUlPcEVWY3hwMC9ieERwbzFsUVBEZnBrMkJh?=
 =?utf-8?B?cG1UK0xjMU54V2Nrb0pSTkJYd2lpc3VTUisvcERlcFBlMmIrOGV1cXY0Q0RC?=
 =?utf-8?B?d09maVhVeU5wVEJMSkplVGFmbGJEQ2JJc05qei9zMkxrSTNJdFRPQTE0dEJS?=
 =?utf-8?B?ZHI4djBXOGlqN2ZpTmwzc1ptclQzZVl4SytmSWFLUWd0cmlkcDBqTlp5d2p0?=
 =?utf-8?B?cTFSMmhDemZjWUpmUmNscXZoayt4NW9CRFRGbmw4QjhxMFd1aWh4RzVjUlc0?=
 =?utf-8?B?UlFqQS9KU2RZditwV3g0NDlnNUlkNlV2OExJdS80SmtrNytubmY1SGFvR040?=
 =?utf-8?B?MWs5M1k5RHdlOXZnOGhFb2ZpOHVLYzdvUnRySWlhbldlUnhlVE9oaDhlaHZh?=
 =?utf-8?B?OGVkNHU4SGtLQ3g4cVNyYmpVSzRYRWdwWjRQQkt5aHFQQjE0STBPeHlNOTN4?=
 =?utf-8?B?WVhCWmtkYUJ0N0hMcU1mZ2huS1ZTTk1IQlVIN3JlSTNST3pyN2Q4bzIrYWIr?=
 =?utf-8?B?eGh5d0s1YmdVTWxLa0RxSXZHOFB2ekdvc0xQT1FmVG9lREE5eGM4SnJhZmJO?=
 =?utf-8?B?dFllWk9yd1NveVU2djFRNStsR2V4dlRvRVhiNmlsT2pMckt3cTNHNjlSeUZC?=
 =?utf-8?B?U1kwWnJuQVdxT3Jickh0bkZTYlY3ZVZQR04rTXlXWmZuVTY4cXY0bjg5OHhv?=
 =?utf-8?B?UjVTQ2lrMS9sOFluRjJ2KzJML3QwUW9JaTV1S2tqbElmRHRHWjFldDFUdlN2?=
 =?utf-8?B?THJvb2tvT1E5c0cxUklSaFNPK05ka1p0S0FaakhoQXNiVlJCOXJieG9TYUlJ?=
 =?utf-8?B?NjNRNFJ2V2pyTG9MdTUxWFdRMjNIN0Q1dXhjRThjT0JUd1QyVlVwNkFNSnZn?=
 =?utf-8?B?bnhIeXF3cUYvdzFucTZkVFdNbkpWYm1JMjE5TVUvNGpLYWlnNjhrYS96ci9q?=
 =?utf-8?B?NStMNlVyR3JsQXJPbWhyRWFvRUF0NjM2bFlwR0tkTjlydWxEUkkxVVZCWWJo?=
 =?utf-8?B?KzZ4ejVWMnlPSXBQRStlMEtqcHBpdmVmV0lWblpUK1RnM1l1a3JHS1h2d0dW?=
 =?utf-8?B?OW1xQXl6dVRFWmxVOUlERGxldzd2T3ZLQ1VPQ3Q2ZkJsaXlQa214WWdmM1k1?=
 =?utf-8?B?NWt1aW5mQ0thdE80dktTMkdHZkloanlZcmxwc3lpK2NObjh6NjJZQUQyYVhz?=
 =?utf-8?B?YllEbi9IYW1NeHc0YnBHNTFwYXozMnJ5Vm9hMWpicnV2VDhCbkVSNG9xc05X?=
 =?utf-8?B?YmtZcS9IaGtjamh5UmF6OFpYdEJKVlZUNFcyVjh2VWludnhaRC9YZ3hwa3Mw?=
 =?utf-8?B?SHl5VkVCTnE5RGZReTB5TExwYWs2c080VDA1ckxWelN0OTh2ZVY1aTdaWUh1?=
 =?utf-8?B?c3M1b3IvM1hQTUdweW5wek9tV3A1NW5aaHQyQVhjMG1aOEFXaURZT2s3WHZ5?=
 =?utf-8?B?YVNQVTFPQ0NaYUpFSWZEYWtrZnpLZUw3NHBKNDhhWFgxRkJIVkVJVHIvbDZQ?=
 =?utf-8?Q?6a6FTCANhzimkRMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A162800F679C6448A401C7CB139E4799@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bdUNyciCFwZcjxJvv1Yenbu3OsPSRA4+BPq5DispRIuKuDAh8RGWkvcaRplnCI5PRUuCuDFahWCQAa+xw1H9HQvh6emcFhVB7zcZLqvoZ5W58hTnndLKLhCto2Qx5GMIJCbddPUZhd0zbd3M0oRKrggKKuxzty5LhNJTBSqyLH22YFcbJpyyzfWlpUfOzjQ2nlp45LEovR2U8S8ic82u76kAmX87goldBM2UNdFBDzPv5tsvsQX+AS7bDhQqLsdoHooN504XfY2N12mPuy5MZt5s/DLku+30lGRNTbeJN/mhreVynpw2Z/6C8WVy5k3PNgHaX7e66zuKriTBrJgGrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1968e0ea-b7a8-4529-9f08-08df190f4a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 01:09:16.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2tyBQ6DmcCikCkxR0Mcp6i8+urSPyEn9Cb8AOdjWRSgJJ1O1rbNY+vQJelQAteWizrvIKB6Lynahl36hORewMJr4MCqXdVFiFKpr1KWGk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF9BE730F55
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDA4OjU3ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
QnV0IGRpcmVjdGx5IGNvbmZpZ3VyYWJsZSBiaXRzIGRvbid0IGhhdmUgYW55IGRpcmVjdCBjb25u
dGlvbiB0byB0ZGNhbGwNCj4gPiBxdWVyaWVkIGJpdHMuIFVzZXJzcGFjZSBjYW4gc3RpbGwgc2V0
IHRob3NlIHRvIHdoYXRldmVyIGl0IHdhbnRzIHJlZ2FyZGxlc3MNCj4gPiBvZiB0aGUgYWxsb3cg
bGlzdC4gDQo+IA0KPiBJIGRpZG4ndCBxdWl0ZSBnZXQgdGhpcy4NCg0KVkUgYml0cyBkb24ndCBx
dWVyeSB0aGUgZGlyZWN0bHkgY29uZmlndXJhYmxlIGJpdHMgaW4gYW55IGNhc2UgdW5sZXNzIHVz
ZXJzcGFjZQ0Kc2V0cyBpdCB1cCB0aGF0IHdheS4gU28gdGhleSBhcmUgbm90IGludm9sdmVkIGlu
IHRoZSBwcm9ibGVtIHdlIGFyZSB0cnlpbmcgdG8NCmZpeCBoZXJlLg0KDQo+IA0KPiA+IA0KPiA+
IFNvIHRoZSBhcmd1bWVudCBpcyBiYXNpY2FsbHkgdGhlcmUgaXMgbm90IGV4cGVjdGVkIHRvIGJl
IGFueSByZWFzb24gdG8gYWxsb3cNCj4gPiB0aGVtLCBzbyBzYXZlIHRoZSBjb2RlIGluIHRoZSBh
bGxvdyBsaXN0LiBJdCdzIGEgInRoZXJlIGlzIG5vIHBvaW50IiByZWFzb24uDQo+ID4gTWFrZXMg
c2Vuc2UsIGJ1dCBJIGNvdWxkbid0IGdldCB0aGF0IGZyb20gZXhwbGFuYXRpb24uDQo+IA0KPiBJ
IHRoaW5rICJub3QganVzdCBzYXZlIHRoZSBjb2RlIj8NCj4gT25lIGFyZ3VtZW50IGlzIHRoYXQg
aWYgdGhlc2UgYml0cyBhcmUgcmVwb3J0ZWQgYXMgYWxsb3dlZCB0byB1c2Vyc3BhY2UgYW5kDQo+
IHVzZXJzcGFjZSBlbmFibGVkIHRoZW0gZHVyaW5nIGluaXQsIGFuZCB0aGUgZ3Vlc3QgZG9lc24n
dCBvcHQtaW4gdGhlICNWRQ0KPiByZWR1Y3Rpb24gKEtWTSBkb2Vzbid0IGtub3cgdGhlIHJlYWwg
c2V0dGluZyksIGl0IHdvdWxkIGNhdXNlIHByb2JsZW0gaW4gdGhlDQo+IGd1ZXN0Lg0KDQpVc2Vy
c3BhY2UgaXMgYWxsb3dlZCB0byBjYXVzZSBwcm9ibGVtcyB0byB0aGUgZ3Vlc3QuIFdlIHNob3Vs
ZG4ndCB0cnkgdG8gcHJldmVudA0KaXQuIEJ1dCBoZXJlLCBJIHRoaW5rIHdlIGFyZSBzYXZpbmcg
bGluZXMgb2YgYWxsb3dsaXN0IGluIHByZXZlbnRpbmcgaXQuIFNvIHRoZQ0KcmVhc29uIGlzIHRv
IGhhdmUgbGVzcyBhbGxvdyBsaXN0IGxpbmVzLCBub3QgdG8gaGVscCB1c2Vyc3BhY2UuIEFuZCB0
aGF0IGlzDQp3b3J0aCBpdCBJTU8uDQoNCg==
