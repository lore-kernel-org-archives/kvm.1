Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB92385D67;
	Tue, 16 Jun 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595974; cv=fail; b=plf64d4diep/ny4gexuwtipHmS3zM3QxcEFlhuyz/LvSh7lo7E5koWNy5BA8gWfoRvSpoXydEkFL2nA/A3rNTooOL4okT2P0x0mjKfhig5SvJ7wNybQ5sJh205zX9ZmprBMK1UKnHIX93ei55RxeM4LxyF7Mjw4UdVTyFK0XyXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595974; c=relaxed/simple;
	bh=zayK21Z6sGIUP+mkrZB8/cOdsjIa7FVgH2Hdlb42bXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6pH5GLaH6c8lx+rZBw5WzecjOPwrfCoczLKSv3nCLEa0lau66wpHqavpqOKYa6xW4A2WJ9MWlVfrCIiF/wiQDEjXfHXJhZMEnqYLtvLukMCfU1mYm4inERJP9bACADKEdYPXh965ns5JRuaIs69jyIaHYbE/zjH/Vpd0WTp/zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMiq4vLH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMiq4vLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595974; x=1813131974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zayK21Z6sGIUP+mkrZB8/cOdsjIa7FVgH2Hdlb42bXI=;
  b=YMiq4vLHo+9JA7S7vRsXvEoSSitRVYk/zEOl/7Tfe99y1jVeI9QoSUZU
   ONuJ8NCJxFkiiE3X2I1DLHcuH1zVglqpNbKCKwZJXumX9SDA58xdCzzmI
   DaxxhV9YkR1g37H5h4GJibJFrAHTwz2BxovaMCzUODbczynxLD5az69DC
   IOb19cDl53/2/SSfcpDoKYBJtNz2YsnlrFe2XQZDjJTcpWYeq+AshUO7E
   05CdVJJqx2RwwC60co/BEGKEIUWLRgTaOvIZIAMxwEiSBTsJD78em0J2F
   8qOMTquxbwVh8tXldW9KLGQRBOUU5cEh//i8F9bdFEscooBE5Y3N4WNya
   Q==;
X-CSE-ConnectionGUID: RwSZPq8GQge9gVeQTUd56w==
X-CSE-MsgGUID: WPIX2mV9R3ydFLcSD+aviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82338068"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82338068"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:46:09 -0700
X-CSE-ConnectionGUID: egDoy17uQX+DWvMG/Dr4fg==
X-CSE-MsgGUID: D6igQWZNQ4ypeGBVQ/WUqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="245309687"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:46:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 00:46:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 00:46:07 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 00:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkDXhHgTiHsZEH2l6pKGZ8HLWtKY9zIWnIFq2vzf0yq8OxKR6W1mFpEdIZdHBpnqLMdeyV/xaPNtPSpq78VL+aHloRAHYjYdgTlPGnxKm/QN6xNlraLiBd68UGzjWrsRszb6Ww2lQpDDkdHvx+FbdGNde8WNo7C38lj4a1FBDAVqG95wpAWvvhzonRYjGduib6Pjp9VWUVkq5xl1HCZ6O6hT3cSGtbBzvDs6+6wR47bR/QV3d8apvUbLUUPXlqqz26fVNQQYzDkDKXHWKST8NTuKY5phMjHyka7izJzG3WjoDE8cOmtWq1YujsfY9eGj7YjnZlGdlEWegCFwSkmjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zayK21Z6sGIUP+mkrZB8/cOdsjIa7FVgH2Hdlb42bXI=;
 b=ILvtOkdp41V5ABn+fwqYFRl0XfbWF+q5UmXCitFiYO2eScubHft+5OaJ2He3dsbEzuXGyY9PKl6pPooXluBc5hvW6vdmGn3HNIupvEBvJXuXL/31Qk1jFAKHHYfDSlSkOWvS/AgjRcJm/ZMq19HYCyXB6z5AjHzweTtM9lOPqu9lavfFH66Iw85GQ7lMiRhStUkx0GZyzCLHMHS0Ic3omphStJAqNlA3bKGiCpRxB5bk9zije8UqTb/+P7HouEqleMbfgD4JTgHYWS6sBu9pT4oa/rUdik/Q8Gl8M9hZErxFURWezam16N/MNpHG5RCdiig3nsMJAP3yBgQddVThBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 07:46:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:46:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Topic: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Index: AQHc+sgqXLeuA1RU9kGzdjSHRH7/w7ZAvW0AgAAQmQCAAAQkgIAAAKKA
Date: Tue, 16 Jun 2026 07:46:05 +0000
Message-ID: <b6721d022187966290f8ea04766ffb1268407ca1.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-19-seanjc@google.com>
	 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
	 <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
	 <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com>
In-Reply-To: <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: c59fb162-ffe0-4b51-e864-08decb7b521c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ERJRCvv6EeWBEVKLV7EEk+NSXlgxAY6NubhSwKAX1Q8SrkqUZme5OeLgnD0kxnqwwDLCk7KbGt3xoA4eMYZTpGJGnSlu2zmIa7vnlefgaEE2k77tY8ZeitwOaYDNbRi10qQiCh4Y3G53lE2yzDfJZueCEq/MOCMSZ7K7DhocBeOYjG3FZ6QezyTF+YF7YoVmqjs1BwrSI21aNCme5FwhaanvVDQseI/BCRcRa95GJAbFndmlrDVMysb7m8C2LHFcfXl+c3l+AChL4AJLDfvxRl/d19rDMjT3GU90wo+nGviidDUpstkVH6llugIpBuSJ7Ms1dZKIuPjBoZs0xmSSvHy9QoZjfDtbP3yQg32jrpRO6if9mSpW/Dad4NEFoF6EUun7w9ei0kAXGDAHpdj5GJ4isdWec2E1LFxbqX/IEzyCyJSMqZriqBP6guHHrWhRCmAC3ckp0KmNRH0YFx0dPAgca62D/jQQTHYAVh19m8U7u6mdFjE56nxHSFMj+aJG9pH/jPObQHztDxM8031efZJuo7rqP38rUYigMN3zzRCVGhiLq/N3juddREtwpopGJo6HAxjSqnVgbZegGznggBVRNhVNHuDbO3FPSlm9NvaDExcKpwOxj61d+s5dU30tzXVoR2/Z5q1klIWr1bpZS2KMY/QhPwqMoA0Lk5XHuzFJlGsdANlSyum5q9U4Z+3KmM8sUYSVz6jDvzAhfzI8bqLcSaHc6HHp7xNoZFen64tzYVvIkyYRF3KBvGKaySgZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJCeDUrenk5YkQyaEdpR2VKMXRtQi9ZR0VOc0xvQW83elpURzE0SjdWdlc0?=
 =?utf-8?B?RmYrQVVsQmhBMDdMbTk2elVWV2J3U20rU2lhQy9QSTlremVGRlhpMklQbnZZ?=
 =?utf-8?B?eHVqdUhmb1d1QkhZRUJ5ZU9sejVLb0JQUHZwazQ3clpzWmxSNFZMS3BkN0ZJ?=
 =?utf-8?B?WTFJTEt6T0ZqODVZMU5JOWVsV20xeDFSZk1aYm0vNC9YSXpMVTkvK2JsY2I0?=
 =?utf-8?B?eTFpckVBNVFieU0xNm1OMVB6c0NkMnZTTGUveEpmL1N3My9QT2ZDN2crZERP?=
 =?utf-8?B?MWp3TXlPQ0dNVGhOeXFvU0hGazg2YTZ3WW1KNmdzVGFyUFJPR21ReCtqNGdi?=
 =?utf-8?B?b1hpZU1kUjRaWWFGVFN0MXhhVHlad1lrVkRYQlMvMUFMZUxQUU5QUER4eHRO?=
 =?utf-8?B?UW5OY01weGw5KyszOTduSjFSRDBPZHpVZmZsU041VmQySlMrWjZNMEREL1Q5?=
 =?utf-8?B?aERvRTdxdmtsSHpVYjJBWUJSQTM3Q0J0MC9IRGpOWUxjcTFGd3ptdnZjc3FC?=
 =?utf-8?B?NWhmQTQxTTk2eFlOZ0hxSkR3aW9PNWxsRmZNTC9aN081Vno2T3JJNzVpQlhX?=
 =?utf-8?B?S2tBUTN6U2hUNS9JdjE2TEhKVTJvMGx0Q2xLRzJVQmNvcTduZ2JYa0VOemVS?=
 =?utf-8?B?TWtQS3pSamdMUmI4dW13ZmNZZzdycWRsSU1qeSs0cE1WSUF0eUZERkJ4RGJy?=
 =?utf-8?B?M3NuSXgrRVFWL0VLQTB3NlZVWTNnVlRRVWViRXJSNFdjdzc4SjhOQ2l2UXJl?=
 =?utf-8?B?bGZYbmdVUUEyNm5iY0dNL1ZNMnlWU21iQVhzbHVwTmxsV3lGZUM5TVM0ZmFG?=
 =?utf-8?B?MnU4V241UitEeVk4d3g5NWY4bjBka3UxZjUzcGRncFp5bGxXWnpTcTcxeTdi?=
 =?utf-8?B?VkFrWFJrMWordFRkd1Q3UWxBTVkzbmxNZ0pvR0QwcVM4b3gxcFM2VnRUemRQ?=
 =?utf-8?B?YVZZUmYyOEdOTUJWcDZnTlh4ZXlvemJ1dEhIRWV6TEowSHAwelBWZkN6ZnJI?=
 =?utf-8?B?NERuVDFSN2ZldEQ0NUVFRnNKb1RmMUtVaHVlNVJxcUlTREdEbFNSUzZINDFv?=
 =?utf-8?B?NXdxbUd4a295aEtQSkxKUHFjRERRQUM3d2p3MVFCU2VFck1rcVdISVpwVlp2?=
 =?utf-8?B?RllTVlNXZHB5VnMyRnRTeC9GbDlXdWFZS2hJM1M4aUkyWGdtQW1RMGQwTENu?=
 =?utf-8?B?OHllTkwxNVRYTnVqSy9PZ25iRGx1ZU45U2JSSGQ0d0J6RjdkNGJ6YnAxanVp?=
 =?utf-8?B?U29vYXF1c1lNaHBDMUxUTWZyck9zOGhCcTd5WXNVcDdxVjFxYlV0VnJaKzZI?=
 =?utf-8?B?eFZzVzRUdG51cVdKMmc0ZTY5YW8zS21jdnNORmtLU3pWbm9TNE0yYWRsTHE2?=
 =?utf-8?B?cU1hZUdjbmM3NjY5dDhLaWl0YWJnbkRDTW5zZjNEMU1WZTE2QjZNYUpodWVk?=
 =?utf-8?B?amZZVFk2SGdPdEpUcWh5dUZVSm9wUHlxazNoQUg1Z1ZuNk9COWo2cmNDUDZM?=
 =?utf-8?B?NWJWUnAxbGdDRTRQb2xUOUFJNlE2WFdCcjZyRDUrOS9xdVdXeHR0WFZXclIr?=
 =?utf-8?B?bHJhZlRwanZlOHB2OGdpRVlVZlBsYUcvVThkRFZ5S3k0YnlQY3JHUytvd1JV?=
 =?utf-8?B?RE94WGwzSnpUc1hFbTlvYXFJUmhlaCtJTDdUVWFXR2xEZHBTenVpaUEwU0Jt?=
 =?utf-8?B?L0krdHVuUjV1dGNmYU5DN3Z4SnMvUjAxdWFURzNrcXJqR2Q3Ulc1a1VydHBH?=
 =?utf-8?B?ekQweW8wSDExQmxMVGFGT2YzQU83QzlFcWRnUldxdW4xNUNrbjczYjhLZUl3?=
 =?utf-8?B?VWxVUVBlWkcrVERBOFZsTlVDMWhqWVVRMnp1eWRLOVMwQTNlYkVxQjlhSkta?=
 =?utf-8?B?Q2JqRi96SW5MUGQvOHJvTDBVMzJ3dkxZc28rUFhCV0lMdjN2WEh6TGw2aDQw?=
 =?utf-8?B?aXVVbDgwTzdqOWsybnFKTXZ2U01FNklnVjBlTlp5OHRjTlFGSnoxemJiOVVS?=
 =?utf-8?B?NGJZTzVrWjZzUExEWjdTNjNCemw3bzkrVmtLNUUzSHNjSDFsdzN0M2x2U2tO?=
 =?utf-8?B?VHgrckpuTDRKTVh3NDZNaHJwbkp0aFdtT3lYcDJqS04xbVVDb1dHREMzeFZ6?=
 =?utf-8?B?bUFyQ2xWNGJjQlRqbzA3VWIwa0FLMjBzVDhYLzJ1VVdMamxQY1pFekVVZ1Er?=
 =?utf-8?B?TnRGK01sSk1IK2V5NXpydWIvR0UycjRZVlU1Z3lWbkVLNElzeU5zWDBGUjEv?=
 =?utf-8?B?OFh2YW51MkRVcktsZUM2OVB3SmMrWVN0SDJGWExsOE01cng4MU1HNnlMdkM2?=
 =?utf-8?B?NDBYcXVIQWNiZzBGWGN5Y2xiTTBSQkFkdm0ra240bkRKaXRwTWNEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D34054B4F15C4EBDA45CF7CD3A0329@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dmNoy5tNHwLNhaRYWIlI0syMaWTwQiniHiqmx8cO7lXPAtQfPZGqtLDKnkEG5KtdZjIGVQA82/4tJK9wAJ30JgnhoQ/mUdRgex0e02uNKzwrJhdBz9c+Oi3qRIzTNpD8QigYp+2QjJ+rPD96Q/IhuEYTMlXe8KMIH7ZRnh9ySvIhHXPoQpu6ZqqhyoR0zRfpDkbsVr7sZ+elrYUzxAienVdzyFM0PexQG4V6u3Utrmdh1FZTxoU5nHF057NtYQXCZ1Yt1kCggT09CerAXn3FruS/LyPDNjaeRFw60Pkw0apmdVqnH/yDxB7D6Fijh4HzKxkAsUfXNeNBDY3Y/dO5Gg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59fb162-ffe0-4b51-e864-08decb7b521c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 07:46:05.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSinG8NN+JPay0reNuSkvfZ9c5v3rXXmWqE8519U9vx5PEXLSyzYBeFPTx/Xx5mbpCgWxJ3dqZeKkVFt79q7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDE1OjQzICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
SG93ZXZlciwgZG9lcyBtb3ZpbmcgdGhlIHN0cnVjdHVyZSBkZWZpbml0aW9uIHRvICJtc3JzLmgi
IGZpeCB0aGUgcHJvYmxlbT8NCj4gDQo+IFllcywgaXQgZG9lcy4NCj4gDQo+IFNpbWlsYXIgaXNz
dWUgZm9yIHN0cnVjdCBrdm1feDg2X3BtdV9ldmVudF9maWx0ZXIgYWxzbyBjb3VsZCBiZSByZXNv
bHZlZA0KPiBieSBtb3ZpbmcgdGhlIHN0cnVjdHVyZSBkZWZpbml0aW9uIHRvICJwbXUuaCINCg0K
VGhhbmtzIGZvciBjb25maXJtaW5nLiAgSSB0aGluayB3ZSBzaG91bGQgZG8gdGhpcy4NCg==
