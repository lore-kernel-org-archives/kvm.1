Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2033281525;
	Fri, 19 Jun 2026 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844037; cv=fail; b=Zzm0lgbd0fuYMFN8S2EIw7EM5aeFwcO0OX3t4nvYTHso9fdpI6B0amsWLS+/ViDyzExNa/oqecsJUydagbR3cuKQMHCQOjCrVjnrJsS64qgfF9aelvh5DfUNx26HLynrFmXJ4EsgpXdn2tOVb/NniBW5OlHMY3CGDmb6V71ZdWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844037; c=relaxed/simple;
	bh=mVa2feDKi3DuYp8m8q/eNwo6U5ZsWl/f80dQZdWO0FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AK0OC1jymjaA4zY9S2AA/Z3ZprNmmdUJMFiFJD0ooP6kb+KHC0Gw/cnVu3UlxYpijtqTgPmUtPUbOdR+qXHAeTB8SWk9f33BSsmLaCFTrc3/uKLydwM5tKY30I5lX4BWAJI0xfQW77FD3UB7vo+97a1Ube+96xM4sYULxN45FmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgFqS7VS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgFqS7VS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781844036; x=1813380036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mVa2feDKi3DuYp8m8q/eNwo6U5ZsWl/f80dQZdWO0FI=;
  b=lgFqS7VSVZnZRMa8IFdN/hlcQFM7Di74F4TpVCLSdk7ZxW/llB0M7nhW
   IKfQlgRkjvpJo06ytu8PuAQ6kIm2ElHHkCcFSEfr/5iXIEpJ4J4O15yvR
   /QU7+HpWB9ennS7lMoqBWOOWmUfpj0BMoLT7G/wMHesP4r29r/w8v8Ixd
   hjCHyS71sv9Dzhl6FA7P+mR4HfEmo3W2X8ppcWEmMvKi6tatzDF13SOrS
   TmzkKbGbPIBe7iETeKxAbBDJS+LRH/Nc7mtdQZrLq1ferjx01218p7E4C
   H2daAdNBlJZHRpv1/PUvq5TUyvqmG8TirrSV/y6Ctluq3wYgMkfdZF+2D
   g==;
X-CSE-ConnectionGUID: KTbqQ70QQV66sXYVpNaLGQ==
X-CSE-MsgGUID: wF/KjaSFSK6ifu0FnRXmbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82571099"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82571099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:40:35 -0700
X-CSE-ConnectionGUID: JmdyU7r7RDyY3ql+78jBIQ==
X-CSE-MsgGUID: P39eVcHZSLGDY1TIXTlARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="246194071"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:40:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:40:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 21:40:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:40:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVYk+980LESI7UZstlu4e8HTj4TmGP2y9PFQjFCaimAoYNuiEgy4Q6oXyZ+oznX5bxOUGT3njRixlmiC75YGNs6Za9MdGYsZFGEuCuAqPzkdGuozRqjQESzMr8YtAWjHEAQCvF+EUGX6o8pBE7PlH6re8n01ak93TLYK1v4j28rKCZEUQGQOGz1bG60tbGx192b1aHlOyUZ9uo6qd0B7TQlgBY4IXdtMzw41hAk7khW/tQOPQPucQHtuxbUf9qDxJA2xOlgEpAhHbaNjhgIiFo1mLmGc3ZGUxPgp0He91aw1gZb6R3WhowIjYtBwQqyiZhnqL5MM0I0QG49kvrJVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVa2feDKi3DuYp8m8q/eNwo6U5ZsWl/f80dQZdWO0FI=;
 b=jrSKldW9qTZn1fhSyaWEGFfFw2g3QuxShjxMW5hvCMJKEylOJz7ShEkN1tJuxdNSQ9atD3zMSnUPRZZwLF30Y5P20EnUcriqg1SA5Wv0cIec6Aq0tt0S1AfSzXP5tSNZhLtaDr1EFIcxExkw25of4AmTnl91Yro02LRW5uIWkMich9SZzyzgJtMJu4fgvLVwjblCpfI6xNU1yCGWrokNjWkeyWWpFxGZwSNwFe+KK3UTfUpXj6QZo5bGyDz48pdsvzNZGowrmCrtFLiVtMs97xkpJFYJneRk8BMsD1DzXgxup4fy5vCP57ogeLrQ/H8nQgAMa5FtvwDkVdn7RmcwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Fri, 19 Jun 2026 04:40:26 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 04:40:26 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Bug the VM, not the host kernel, if KVM
 write-protects upper SPTEs
Thread-Topic: [PATCH] KVM: x86/mmu: Bug the VM, not the host kernel, if KVM
 write-protects upper SPTEs
Thread-Index: AQHc/1Uj9CzU6KrFzkyIxD/2pn7TbbZFTNIA
Date: Fri, 19 Jun 2026 04:40:26 +0000
Message-ID: <f4bb68a798408d2147046462ab2cca99f024842b.camel@intel.com>
References: <20260618185641.2022368-1-seanjc@google.com>
In-Reply-To: <20260618185641.2022368-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH8PR11MB6856:EE_
x-ms-office365-filtering-correlation-id: 7501352f-305f-49a3-7bb2-08decdbce21c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: nFQxdGn8hY10jweBPPyDKTgz8nWnCfH7gRrJXvfVIuOLA+a7GPLRet82Q/egyhV+Lvfk3/e1xQIKQlW/E6T7L0Uk9iLv3XtmiFcJyuPYasiOjVjnPjbuULF9ornyVKfJorsWE+t3kwiCJ9kEtTVKTQzGE2t5XYNL/Qu05DWpAVHsM+efdJ92uqSMwCwThGBYNw1tJSTnca5jfzYIEZlcoIXdsINUFhobSp2c/HNzBjjyGkUyU+DYbZprijBbR9A2uAXI+IjdrCR511aQH1xsPoVCIVrkQrhsi3+paiIyLCAIk2YaUJwzSDJM16vdgfJZHb5t7lXwZM/g27wU912UZimWhFftwC4Eg2HEbpFuHmCbGKHCTVUn4ieXUmb6hjHHM7O1WMXXL7O8sjATj6Vvr/2OTHPOgy2pn9n9joXA172Rfhihh0a9WnYBIs4IG6p8KVeLLW3CJO02JskIEPiMF2KDk9FpIUS28bgxrwKWBpMHVfqQHvdyz4mQlM/W1ZAqNALjaDlHir4U85tKOFa7MVQ9zuDHrmQPr3aalZXh4zHuSDXpbXSL8+zAm/X/+HGGty7HYpcVyaoMKzun+BFU3BaWYzThUOzMuxAQtm8UZ8mFJXouUXRlRgjamfiH3+RBJTiMjFkP/eKMvM4yeHbsmG0XIxPehUsAanllWlxBWZJOBhCiQixFeBna3DRdhiTEmSaWULDBsQnZ7fapsJfwzCsoZGgDLT21ck6j1FAl3d0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhrYWg0TndmY0hiK0F4ZExMd21HMXkzcHJrRjcySVoxZHN2MnBYa0dGQzJC?=
 =?utf-8?B?WTI5L2czM0xVK2Z0cy9UNVRFMmt2VlVaWlg3STk4Z21YcDJXOHcyMmdySktW?=
 =?utf-8?B?cTBQYUZHM040c1pheE5KUXQzVG5kaU5ucDZjZXB0SVd4Szg1YlFqUE5DUVdz?=
 =?utf-8?B?dEt1QUpSaTF2WjhqK0dUcEZ4SlRMT3RzeXJoakFpZm5pZXRIdkZXVVN6R3hB?=
 =?utf-8?B?MTZVcUdyb0F6NTlRTmVCcTBsQVhtM29hemJ1SHVBNE5mWWthT1VaVzNIRTRt?=
 =?utf-8?B?bkU2NkJmWjNGK2JUUGFRc1loTHI5N3d0aTFyME5iZDlUZkJIV3BjeHJyVDI3?=
 =?utf-8?B?NVRXamhWWGozanM3eVc1U2hKcklRdE42M1R6OFN3NS94K1I0SmlrcFRmdjhU?=
 =?utf-8?B?di9wQjJwdlBxTUlhUm5NQ281M1F2MHZJc3VJWHlkbkdEeWRsMVYyOUtlWExE?=
 =?utf-8?B?U2ZJUGwySjdFNmJGMCtyeVFpNGRUTzV5ejRHcVdGTHRHVmxTek9HTUo2blE5?=
 =?utf-8?B?RmM3VUR2QVdPRnRWMytGOWZQRURHeUo4ajlaVWlGdk9nTkZrY00rS01HcDJz?=
 =?utf-8?B?ck1yR3lkdTJ1RVZNZnYyaDBvcldCQUtacEszUnRoRGZORjc2QnVvZDNSOFdY?=
 =?utf-8?B?TDFYbzFpeVAvRkN0SVNyYUhQeENiMEdkTnpNSHhQS3BnZjhZVlV6MmNhaGFa?=
 =?utf-8?B?M2hQbndxdWhTUkV4ZkdWWmJOdkNOZVplZUQ0clhMMk5HNW43Yk1aZzlSUG5n?=
 =?utf-8?B?dDQ4SWxkdUJPc3ZnRHcyZ3dEejYrcDJlNFNFbTZGTDdsTWY1Y29sMUFSY1g4?=
 =?utf-8?B?dHZ4OC9WV2hkWVoyaThZbGJkWVFtczNrUVNWL2t0MWFRTkpaZ21SQ1E5ZklX?=
 =?utf-8?B?Y3ZhYm1VeVhkZ05VaVNaS2xPQnROOFlDak01T1RwN3Rsbi8wTTAwVGN3b0tR?=
 =?utf-8?B?aWluKytIcDBzd0dZejZQNUE3dTFBbldxWjBDVVhTdUFsV3l1WU9ndFltOGtp?=
 =?utf-8?B?U3BESkZuNWdUS3JoRVlpajZQR3FCVmlFNjFqS3BuSFpXUmFocGFaZ3R4dG44?=
 =?utf-8?B?R3JFRDVKTWg5OXlZMGI5OUpaaWVpc1VyQm9UbVlVa2l5aS81SGZMaU9nc25m?=
 =?utf-8?B?WXN1Y2RSM0p6Y296blFnOVhHTkE2N1grR242Sk5hYXFhb2UvTWlCTjJnTTY4?=
 =?utf-8?B?dEVHeXZ1a2lvdk9lSC8vL0c1b1ZORVlheERmWWRERzV4TUwwbGtmY2VtYTRK?=
 =?utf-8?B?Q05xNnpIWlUrdVg2VWdiZGQ4UjltMGNhUnkyL1o4TThIVC9aTXI3UnRQZUNY?=
 =?utf-8?B?QktBQ2cwVU42MHR5RXpWNXNnWHpLdWp1cFBIN0lFb3BqL1BWZHVrakxmK2pI?=
 =?utf-8?B?OElEZFVEcmY5aHJ6ZGRzTXhZSlMrcHFJN294TUJVYlNncEYvUit4VzNTNVVu?=
 =?utf-8?B?ZzFLcEV6a0JFOFk5Y3hTNmJDY2ZqSkI0UFBPbWpLdnJwemZOc0lCeUFRalZS?=
 =?utf-8?B?blRPNURqZUI3RHE5NWVhRmFrZTFPQ2ZrMjMrSEdyUm1HdXdIbWRaREV5MWZu?=
 =?utf-8?B?VWVIcTAycVFxNSs1RE9nOTU3Mzh0QmljN2dsWGl5dHowdmdsN3FXWWl2U2pL?=
 =?utf-8?B?RnA1NkRNaWZ2NjRFYWp6UFdwU2IwYkZQS3JYVVgwaGZTd0puYlcrUUNMbS9k?=
 =?utf-8?B?UkRzb1JpOXNROUsxRGtuQ0EzTFFPWEg1S1UyMVlNaWJVclZGUnZmc2JTK1lP?=
 =?utf-8?B?NDFJQThWV0kwM0pHcTZhNkpvUU1QUkx3QXpBSWo2dE5UbWNrZEFZOVJodEFT?=
 =?utf-8?B?NXdoYjF6QmFLcWN3c0J0MzNKT1lKeHhHNkdjSzdOdnczQ0luQmp0dU9DWFlC?=
 =?utf-8?B?Y2RZYU1NUHBuTDUrcWFhOUZyK3lJRDR1WTRqMnVnTWgyblpYS3RXYVdHdTcv?=
 =?utf-8?B?dHZWVmdmM0FHcHN4R2xzRWtoT0F3dlk0V3IrRXB3d0Izalg4VU1YYTYrd0ow?=
 =?utf-8?B?bUQ4TGo4Y3NRaHZaZ2UxeU9jd0x5LzhLakprV3dxb0tHdDJuc0FDdHVQSURt?=
 =?utf-8?B?cS9sN1RrY3NDVXJaM1VoMlVJblR1V0k3bDZsWS9WZXk3OWtoWHFXa0NYZjB4?=
 =?utf-8?B?ajZiVk5mRjZnNUpxNVdjOVlhbERhWEpSTnhKNWpza1VBOVNmSmtYcG5uYnkx?=
 =?utf-8?B?RE0xbTNiSXpUemw4RWVwdFE3V0FNS1d6K3J6TnZNZkcrMXUxbm5uUVBwUE4w?=
 =?utf-8?B?VWRBWm5OUjVFWXdGeE1QZFNkMTI1aUY5YWMxakt4RVpPMjFCNXJ0ZDMzSGN4?=
 =?utf-8?B?Ry9BakI1YTZoM2VpZmlyTUphRVk3cVVYZmc3b3dKU2RRcGUzTFRlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25509C9335038C42B48981125147DE7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EopVvdQDGqh+O+DBVugNvqi5keYEQVqdg74zaLlN0FFU9brw47zLqBY2yYdFkJMZeDXJXUxG/bvmZ2VMMbEIma3mNgusbmT/qhgVf/aZQsB47MEXoOXPtw/dLtdnCZXf/ac7JxnVMtM0RYqdy+f2dzdaAO6v733ate+7/hmAaWSRsc7qI9my+yI1glqV8Ja666Dan4JgdfjEa1qnF5YQzNwUlDLOHi9yo2zUOZPgrRq+/0/XFJNXSSuXWBMRdkkqvn6R/nEwjf/gglht+7A4AVPjBydsLleX6Rk0iCOSXTkwOGe8AOL+YT3hrTvYUy9CChMCoc3ASWYw0tfdsTg/EA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7501352f-305f-49a3-7bb2-08decdbce21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 04:40:26.3864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vg2f4kR/saUoKGdSnAgXPs+pWNxpEUfivK6rlp75cUjUVIwTscNIW3XsgFn9UBydaaOIR+qIGSnu7Ri3IXRUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDExOjU2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXQVJOIGFuZCB0ZXJtaW5hdGUgdGhlIFZNIGlmIEtWTSBhdHRlbXB0cyB0byB3cml0
ZS1wcm90ZWN0IG5vbi1sZWFmIFNQVEVzDQo+IGluc3RlYWQgb2YgYnVnZ2luZyB0aGUgaG9zdCBr
ZXJuZWwsIGFzIHRoZXJlIGlzIG5vIHJlYXNvbiB0byBicmluZyBkb3duIHRoZQ0KPiBlbnRpcmUg
aG9zdC4gIEV2ZW4gdGVybWluaW5hdGluZyB0aGUgVk0gaXMgbGlrZWx5IG92ZXJraWxsLCBidXQg
aW4gdGhlb3J5IGENCj4gbWlzc2VkIHdyaXRlIGNvdWxkIGNvcnJ1cHQgZ3Vlc3QgbWVtb3J5LCBz
byBwbGF5IGl0IHNhZmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KSSB3b25kZXJlZCBhIGJpdCB3aGV0aGVyIHRoZSBCVUdf
T04oKSB3YXMgZm9yIGNoZWNraW5nICJub24tbGVhZiBTUFRFcyIuICBJLmUuLA0KbWF5YmUgIndy
aXRlLXByb3RlY3QgdGhlIGxldmVsIHdoaWNoIGNhbm5vdCBoYXZlIGFueSBsZWFmIFNQVEUiIHJl
ZmxlY3RzIGJldHRlciwNCmJ1dCBwZXJoYXBzIHRoZXkgYXJlIHRoZSBzYW1lIHRoaW5nLg0KDQpS
ZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
