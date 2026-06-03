Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE446AEFC;
	Wed,  3 Jun 2026 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487639; cv=fail; b=PCSaMGpWfFRKNdVKHyioVxlEntknCUauJCkTlNQLhPzinipSMeuIUToCIxtEaVZjjQrToa9yZHHArpn8oVjy+bD4QaLoVWn/zmw7Mrp4Al3wAPEVCuEAORo3dYqIuQCNuSLBa+3Y8o3ll00HrepEkizYICGY1EYDlPjZ2rtSG+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487639; c=relaxed/simple;
	bh=QXlOt8WKvttgLLGjoC+VcgaWKFEPkTjkF+Lor+xx/yA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxvbLCXZm+J6PN57kBrqU4tK0EgjJSk3vRDoMaJ13inYte63biCqrvuvtpjCZ49GtUa8eyQMdZKF0w304r0MWJRF8eoPbZEl8g6OOMG5JQMuzjStIUgnaRs/OYOIhlG2FqH3vV+xLZ1SIQNucQFs9UKsTQeCYfVJX5JBC7twqgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTETszrI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTETszrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487638; x=1812023638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QXlOt8WKvttgLLGjoC+VcgaWKFEPkTjkF+Lor+xx/yA=;
  b=TTETszrIcASO8BSOtm0NhiQWS/JehKauCcWF2+uCgR0dmIrabCckd1Nw
   xDuTWsxYL13qJZRXJDng8m5gmmUT8qyilq5TAvG68QYy0Zs+m/DeNkes0
   4NmlDvJfQhPGSYv59gTtvkQRpKaA04KCgFQ0ZvIqkHrhfql1O2NJ5lLhQ
   DkgQzUPLvFYKyh6pTmrvi17f7UMe3ME4L8KkEi059g/cG9PopcwMhifU8
   xNcuz7O2jvLgfC2MxHV6zXWe9pen8IpDtDmrAjxEM7TR7y9ryqeG2r3Ef
   xHAms5e/la5d6qOg3ULwr5y87SlqxKtIfN1x71x7WIkS9wzg02zBXjujI
   Q==;
X-CSE-ConnectionGUID: Z77hlTHbQhuMle4w9O3AFQ==
X-CSE-MsgGUID: CPUvGEA8QweMfSS2XDJ2sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68832818"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="68832818"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:53:57 -0700
X-CSE-ConnectionGUID: JhQ7TwmgRlyuyLXjTvPV3g==
X-CSE-MsgGUID: rk/AzoQSQqOGKJJO259veg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244323561"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:53:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:53:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:53:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcRnI6IqNSRVa1g0pMI218QM9wJEHFv0rrj9PsEXwjq5G9Yi0hvQXL0KKwv/Ej/OehDmwG9ajEuTz5Vfz7EAaQ3HRdycPnRazGHOi9APrMBE8sP1+PW70qvKBzBJgXemC+Pj5obAgzgW+jNHzU7iYdRhKlixVTIHzWe2exH6OAui1WxdNF7tF2DOyeYgs1aty/oyjW/OoAEnuiDxzXPRAqmdSzlHRTt6E+MM4qnRenXCcUUpw6glGOuCzTnogy3VJTx5hsw6vGKowM/ft91u3BW6u3CziAS2cUCKmfyZ7AVScdEuSvqsqkIluhBQRKm2w/DUSOpRrQOyZKTqOxJ+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXlOt8WKvttgLLGjoC+VcgaWKFEPkTjkF+Lor+xx/yA=;
 b=CAfVU2Ge0bv30I8aQmhh9ghnMV2B8TfJJy/oEDReSQUnNPvMI4ac0u/jCvISExTW1T/eYDCjce2gflZ0HkXnUzavhU1eMyu3AYCipsBDMpeT84bJx+iTeIxy0yNHt7LXWr2Q+lFipD7xhBi+NtHF/kynjcA3cb1MQ5nyzPooRThGecUs/Zhb05P7TULNizuKPcBznpCVK/zFbxjU7C3J5n76jRDXzBHd31sX2UrLkg3m9PN64LDeSZiZBwXh021mgdkcfoJfVfKqHE8tSLi5jzon89GM3v7y1Hz8FRR3IuQ4tjxDK65WLrWpCK58efVBl7XqesAuz2Hyw/Cm3aC6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:53:48 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:53:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
Thread-Topic: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
Thread-Index: AQHc77nAZrZH9HlOikmYqq5csgG58rYsv9AA
Date: Wed, 3 Jun 2026 11:53:48 +0000
Message-ID: <7cdb577ca10fe7cb7eab76bbddeae759c98777ea.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-20-seanjc@google.com>
In-Reply-To: <20260529222223.870923-20-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH0PR11MB5902:EE_
x-ms-office365-filtering-correlation-id: cb3551f6-47c7-4ef2-ff2d-08dec166c5e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|4143699003|11063799006|18002099003|56012099006|22082099003;
x-microsoft-antispam-message-info: 9t4znxpUCsVDd4K25LXX5NS8IIq4ZMfqxQpxjpou3wB9vB21LdtlgM8S7eFAL1fk+xRtHh3u8M1J26E1niyhhfMBepnT4phE4viWCU0k/UR1VSc//xnudg9oebxQLsGbcBiF6luVCR8jSHlIeg+OpOJ18l6F4BJFsjH13npzOHtoGvsgrkIuib6+9o3sl0z+311+EqaA+jCBAHsJr5prIhGezhUGgcSNfgiP/GKKesG1q5I2l+a+4a2B3q3Q7UH4p/g6gb2KHduaPUinzjrLuBzsLsS4qYo7oViajiLFykypl72DO5K5WfwxzIZXSpwkCIBIEhrs1I3ShuBvtkk/qq515y2EPTSHKgaUnCOFYMvYsNnEhkppIYIwOSlHQL9ELchcevzrHaqCj4W0owaAGEvfIBMudSkuG3mRo2WxCYWhEUvbc1ct2QnG5EaXd66cshKp05UMFwCIDnNFVkmtWCu24WfM8OpW4eKLph4hqVrSu3xGfoBtwMZOBoxie0Jta2ynXjDpMfU7p/m1QpQOHrt+1+ToAI6jBVSZaZW4crLLqG+CANXlOgkb7sOf3pbdFt7qPtliwwmrCvTYF7D5xpeAS+jGJ5smCgzhziTZVBwf7Sbaat3kwvYMiJJozsO815h2PlIqUYNqvyM+vCvhaYOM6dSU1iKiFjKIfuPp0lG980s6Fp67iq1PeClFc8AsKU0Y0Gml2pZm2i29sJSy7I8Q4YiJgYMSg1SACNwXwpij9HgXhsQjDX1lsHbHvRWY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(4143699003)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0ZJNm55cnMyTVVYY3pkbHZiNVZnWlg1VW1ERGdCZDJ3TTFHN0U4QmxHU1dn?=
 =?utf-8?B?UDVRczBHM0J2dnJLcjlsSzlTMVZJbE1tL284OW05N0tVeGpzR1BoUDZoSG90?=
 =?utf-8?B?NU1iRmJrT2RxZ21maytRUlo1OGlsTy84NVpmVjBOVVlYZ1lFT2h5b1BsbHVL?=
 =?utf-8?B?ei9jWHJmZnZCWlhxYkNDTWlmSEE1MGRua2NZQ3IreEJMUXRNTTg1V1RQSTd1?=
 =?utf-8?B?aWJTVlArNDRLSVlySTd3YmdWWUFoeCt2elk2OVRhUVdIMzlTY0grblU2ZzJ5?=
 =?utf-8?B?MlpPa3hhVllyYWJaODdhdVlPTUhVODdNV0ZUc3VxVDVvWWhhMWZyTXZmUUdQ?=
 =?utf-8?B?VVFCb05BUHJpSnNWeG5IL2pRelBNd1MrbmJvUm9ETHFLUVBvVTBkK0NkY0dn?=
 =?utf-8?B?MXZzZW43MkJ3WTRST3JWcDZJUEtmQmxxcEJGU2c3bDlhMTZtME50UWpoQ2I3?=
 =?utf-8?B?WnhuRFk1TmJHNHd4YWx0Nk1rdWlqbWV6ZC9ObGw0L01HOHByem9ONW9PNEJE?=
 =?utf-8?B?aHZIMWtLUkhWL290R25LZElGeVB3YkhKTVErWlphd0tBTWhtbU41VHJQNG12?=
 =?utf-8?B?d1lKS2dxbTM4b0N5NlpYWmp4KzBHaU14RGZDNjR4SnlHUmFNY3ZmTEg3cW9s?=
 =?utf-8?B?WGFkWFpmcWVFcW9vcGlPaXBwQ2RVU0pWbGxIb0VsQ0FoamRYRW01Z0tjOUdJ?=
 =?utf-8?B?dXVQZSttZHd5V1ZmM3VzejEyN1Ztc1Fvd2RVcFQ0TFVQMUFFWkhxR3kzVmE0?=
 =?utf-8?B?OHVRWk1zN2UvK1VqcTlUdFFTcitiaTdsTWF5SW0wWk96bUpvNzVpK1BPNlRs?=
 =?utf-8?B?NFA1aU9tL2RYVDFIVGVpdVVST0JTbWJtampzcGhGMDJFbXh3L3NPbFY0Qitv?=
 =?utf-8?B?N1luYVU1VGVGTXY1YVpNNm5heHM4dmFrQkJFeGVtVDZpUnJsVkYvUDFFQ0RV?=
 =?utf-8?B?QmVEQStQa1RpN1JIcUh2S1UrTFhRaHZsdmlUYTBlRUJIUzRJY3pBRFZ3eXNx?=
 =?utf-8?B?YnN4b0FBdzgzN3VsdU1DTUoxMzZsU3N5c3JUMGJUMy9JZlc3T01keEVyTnBS?=
 =?utf-8?B?d2txSFlYSkxNaUVtbU05KzZpR1l1TThXTkYxeXgzc21CQjZLSFJiMXRWV2dY?=
 =?utf-8?B?dFBIaVBzV2ZNd3VtVkxad2hDeHo0MktEVzJWaU1wQXhFYVR2emV1WGVJTk11?=
 =?utf-8?B?MmlVd2NlaXhHY2NySWVTaTZSdG1vM0lFaXQ4R05yVEYya1RTWm9qTXNmbmh0?=
 =?utf-8?B?c1FzdzhhTWh6Z294QmRGbk1QWmZyRVk5dmVwVCtEOG9WTjNYd3pSRTIybmFO?=
 =?utf-8?B?dVhMY1VhOHZ4MHRvd0xWSEpuODJWYU5DWjlaalJGaHJ1TTFBQ0ZXbzRtVkZn?=
 =?utf-8?B?YVFWTXhlbnlMNW40S0pXTTV5QmszYzRXekFaVlRpbE1nMDZ4RDB4TDBkSmYw?=
 =?utf-8?B?MG54Mjd2cFNURm1ZaU1remtacUlTQjhvZlJ6U0RRVUZRNVlOYnZxZ1dpVE13?=
 =?utf-8?B?QjVPeDFQMENkY0puc09nU1hMYUZ1Ymg5VkZ6VnRWSVVDUll0WWorNUxzTFZ2?=
 =?utf-8?B?WTVONm8yM0lkSVVmdkNZZjZ3K3JrdVNPSFVsbXZtMkJqZ2p1amxFbUl6c1NO?=
 =?utf-8?B?THV4TllpSWFiSzc3MzBoZWhZOU5mcFBwZ0hFSzNvUlJmSGkrRmsxMW1pV29r?=
 =?utf-8?B?WkFyWVFINUdTdzNQdTl6RjRsNTNDYWNPUXY2TzhxVTkyUFllU0NjeDJjSVdM?=
 =?utf-8?B?M3B4OTMxaGRaaXdrdm5xVDBISWFYejc1RVhPMzMxSHM2WTZ0TmZCU3Jnanhh?=
 =?utf-8?B?SlJsTVVzRlRTZlk1RUZFWC9WRHAvK28yVXRKSDBLY0xobzVmWC9GYk51T1B3?=
 =?utf-8?B?b1hqU2NoWnNJSzdvQUZpRi8xWWpiajVDTGd0QUp6U3lXdHJka0FXdnpqRzd5?=
 =?utf-8?B?UTR1aVp6Z0ZURTVNMkFPQ0tTWG9KVTdnUlRwL0VpZ3E0WUJJN2NXSzNJbm5S?=
 =?utf-8?B?MHlYUUR5c1c5UEZnSGVRdDY4bG1HbXBMeUtpRk9uZVZ6amV0QUU0WG5VZTFX?=
 =?utf-8?B?K0U2WnJBU3hDanFURE56bm02a3AzQy9JbTlwREhCSVlCSFZOTkJzZitHZmox?=
 =?utf-8?B?eHJaRjhXZ2VCMVoxV0ttbXBCSWhubnB4S0lnQ3RrbXJRYVM4SFdweXd1Tk02?=
 =?utf-8?B?S0hCZEVHN1NSS0N3ZmxLdGtvcVRDTzJybGRXc3RibEZ6Rm1Pb1lSdnZIRHhI?=
 =?utf-8?B?aDRZTEljOGFrRUVNdUJ3cEJudTNRUHEzSVp6VXk2dHJsWHBqSVFlRWFoSzlO?=
 =?utf-8?B?eW53OVE0R1g2S1ZhRWNRN2hCWXFjcGJiSGlPSThyakl0dDJ1a2JNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC62ABFB4854046AB7361D370DCA86C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nUhAZU+M49okEbdhhwKj2q7B8QJ+JsIYuBeC09HL+Pj++ML/ijWOi0Gh50ep17g7i9iZYpX1jH82XWCFTo+w2f7T/3VE8iMjdYJvoP+HAmfGY4pdntUNfbTIR7NNBqnQLY1khBKba6Bm+A3+XAu+xFRWetJvmkmhCRp34Y/GBuC2YjzhwF60U9Nn6l6Z0eEiIONGuDjegYywvAxiXNBSWSCdUuCDYfM/Fqeb98JphadWLUziIubB5OkpNvBMt5M+OGMyNcpqT641/pvqQmtSaZlT5P1MM3vHw18n4OP9s5KKIfRjyuBOM8621ak+PG3zoKqbZdsMJBOYCWEwfRwBQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3551f6-47c7-4ef2-ff2d-08dec166c5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:53:48.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAWA4vwrwWGgf/lVmZGCd82fNPGRtfFs0VTzpjl2fiU/ug6BdMYyhsWvNoAgYWJQ05JKJ2PAg/T/uwXyo3nXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJbnZlcnQgdGhlIGluY2x1ZGUgb3JkZXJpbmcgYmV0d2VlbiB4ODYuaCBhbmQgbW11
LmgsIHNvIHRoYXQgeDg2LmggaXMgdGhlDQo+ICJ0b3AtbGV2ZWwiIGluY2x1ZGUgZm9yIEtWTSB4
ODYuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2
aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
