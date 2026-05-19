Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E4314B62;
	Tue, 19 May 2026 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158081; cv=fail; b=I5rX67yp1fmi7ZevomxjnKwcVGwgwBoE4rUDpT91EHM3gfZQ4822uB7mmzu7WUf04y7LO+n+sbAzUZIV+CmMMafNRCoDvnUoMGJcyMq5JV+OeB5V3ntRMaCcMkCbwWW04GvLN6BB2P7JUwCq2h7AMTWc8rBcnfrEdOeBsK8UeY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158081; c=relaxed/simple;
	bh=vRSC3wFigBeEHPjA3UaCc0ji9J7nn675iOjUd2nZ/NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGY0grwGa3gEIyEOGrn8mOoTp/mkWI5kIOHQh+QyWftcIVWfDu16W/ojLJUHX/UgFixzHkQ2UNJ6mfkahZggrnrh2gmfHmFb9PAxftncORf07xLGGah0pas9TAtHPC7AdBAOQL7HpK6fu2Ny7BzSIC8zj8WX7QcUyXFbfedIeVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv2fZ7Uk; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv2fZ7Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779158080; x=1810694080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vRSC3wFigBeEHPjA3UaCc0ji9J7nn675iOjUd2nZ/NA=;
  b=Gv2fZ7Uklum4oeHe51foiIg5LQpr3hei/uoKuWsyqLMpPwhR4x/d6u8a
   LN5NDrl21Db1OcHHI3BdV11nNgYdPpbyxOmDFBcXprFTAM7if02wAaf9e
   ZY+bz9miaSGc3HjNnnZFWrw7QK6dDNUrb2AyzKmIlfnGOAb2sCDxemAZt
   XynTSA6/MTfrrUDQTuavaIKyC+ZGKZ1p433H9xKQb/nOF8A3JiTpCActM
   T305PLVY9JyWm3QxpmeAkMCS8Fs1JeuWbcUAwOpjLops0ANt62vTT7PTv
   XIIuV0X2qE4KBjRAvcauNcARUOmutrodZJfMS92e5yyIekr53Bow2kq4s
   A==;
X-CSE-ConnectionGUID: 8VEkaMDLTBao3Bwm74h4rw==
X-CSE-MsgGUID: 7Xy1uz6+RVOoJaR4kcruGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79877549"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79877549"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:34:39 -0700
X-CSE-ConnectionGUID: K7MLzZEnTmyi1d1Nqh2m5w==
X-CSE-MsgGUID: 7QT8+lW4SKOywzE788gQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244615450"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:34:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 19:34:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 19:34:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 19:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1gRNmD12xcITBTin8++2vjjlQgjYJidhmOf3WXcMApG5bm5qd/lO0BT1ukBVaytFPbWhgj93Gsivj1m7I12Wyw/0yyNr+qPGBuyfLjwdesgGwhDVbceCW30RsozE7cCvTSWYUFvMf+i4OSLrNdMHwkzRnAxzS/sAxY77TjPE5rR9hOILqxJLOK3N0MV5HzEHgtz9kCd8kMKWXipVAsljGzOQi5Sl2DUkAGrU4Newd/+XBpXoJHE9JLxMQKBPGQZJTOUBzoGxaNAdA6avze3X3bls3nxQ8J5Bqqkfrk76iiTadsvUYZ9bgPukuV25Z7DTAyYt0fOg+9QxR8B03KOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRSC3wFigBeEHPjA3UaCc0ji9J7nn675iOjUd2nZ/NA=;
 b=DJm7i6vq0fKl5E2rA7I0FVbFXwizeBlpgHuuuXrnMbQeSLhsDvBNkT4kCa0PSeGaHOEjhvSSP+sNMRWVx529WMCnaKRHMKZACGDrMygcsVm3d5sSkhcitdeiNnm/UFjc+hQZ82kd58vCHXooLJkeHr8fOKDLT+O87E13JGfCZvXkrrOTPlkVhx87K/nwOf+2hrRqfS4WqYuA9Ofl99EfubRcRGKe9UbJ+CAvsf48NisiU50jrWCBRfAxj8kVRwOXXLIEec1e5xJ/mg+gSEjxLaHsEQyxl53ZirSpRHKVj/iJIARgagFYoYBHjRPgSWRwxUogkszW9uvr5OkcJSa9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 02:34:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 02:34:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 13/23] x86/virt/seamldr: Abort updates after a failed
 step
Thread-Topic: [PATCH v9 13/23] x86/virt/seamldr: Abort updates after a failed
 step
Thread-Index: AQHc4urcPxPAR/q3M0quD13A0+/bo7YUqi8A
Date: Tue, 19 May 2026 02:34:31 +0000
Message-ID: <c0c5edb3cf4dfeee986a478aa3db886aa8d5db38.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-14-chao.gao@intel.com>
In-Reply-To: <20260513151045.1420990-14-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB9880:EE_
x-ms-office365-filtering-correlation-id: 8db5ce65-0b6c-4821-5997-08deb54f2848
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|11063799003|56012099003|4143699003|22082099003|38070700021;
x-microsoft-antispam-message-info: 84IGZ2tB2IzI301tnuxjVM/OV+iJGiNN7oJJLErRZvcvp1fghH2ty+CZXQmHwM1GAu9GZddQdyVVkrhXM1r3DvMqMOVAOHRzRvjdYyKNzBPXEabrQ1EUF12yJTg0GFEiLu7dGamsf6ZqHlYoFDjG83hYl0vPRvOt2/WitlUFiS1iZ5Dno5T591evUv3G/iV63Dz2lKj3hx6SSX1U8QwJ4Rg7ideGuc20HEpFLkLRV229xGZw/mx57lf2//lse6oW2yvm0y4msx26ZxqJMiJpryF75Am0hoe7VRnggYMJeqZ3Y+4rcs7a9eP3twWA5pEYMqFtYxepty1tV48HPwEUN12wBWaenTC7BB6qdZNr0/5VYdfhD7uhWQ8nuCAQVNSa40bhpuonWdv1h/if8a04Inf2pl3TcPW9tsPglOyf+BfMLL01qMTiNcNzD3/Lg83b1jFFAr+KNt6xacYRa8/s4SYQm9DVKWBpd7BcSDagZ5fq/LRfH+AQFOK6yN5jA3mfKlFWJ0Cnb4lJ3NDtpt6/+uWGjtpEV0/K2XNpj8oRA5icehp37lIUpE9n0ODSY0sHGRIFu3/TDpN/sUf4CqypaChmHh1waVWQW6wWETzmXi0ybKYmjfakt+eUCIdprYUE5zha9P7WzYNlaI03oyo0fVuOcDAediF8Wz/ZP1ohAY/KnU6bkBU82dW8FFPSt2QX0sWSYr2Qr9ki6Ftn5P6o3shdlU2ElmXYngDy6eKffQ1hQiLgDTEckl0g6zI/TsGo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(11063799003)(56012099003)(4143699003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1FQVUV3bTNNRklUMnk2ODgrWTF4MUs5azI0VGlMVzBmQklMdE9aK1htckVn?=
 =?utf-8?B?MTlFYWNheDNuWFdzYlh6M0F1MnFLMGs2ZzJKcGZFNFpkaEo4TE14SVNNWFVE?=
 =?utf-8?B?Z3dYeThPak1MQVd2cXRvSGg4dUhaVVdGZzd1UWVic2J4K3pMVU9Wa0RIc01Z?=
 =?utf-8?B?Ym5TekNPdldwTzVPTGRidU8wejV6aTFEbXRmSEJwY2V2RXZsUmVvc2UxRjFP?=
 =?utf-8?B?OXU4YUlFVFhCT2Z1cnI0bExSdithWjZ6aW9tMk9mVnJ6MHNCU0NMd3cvZkY3?=
 =?utf-8?B?WEo2T2V1T1lGTVhlMHF6SG5qbzFqNFFvdFdDUFBINUE2QkxhcXF5ZndQdGRP?=
 =?utf-8?B?WDNQVFZncEM5Y1B6MmRJelRraEpmQTh3eVZGaVh6cWwva2JDY2lnbUltQThT?=
 =?utf-8?B?Y3hpTTBsVkZRWlRnaEZaSHkreTlKVDRwZ3dqMmZIb3lUUlBabU0vQ3E5d0dO?=
 =?utf-8?B?M01zQncxZHEwZ3BqeVFzYk00eHVMVC9LWVBBd2U4VytjVHpab1BsV1Z6N0pH?=
 =?utf-8?B?L3ZwMlVjZlk3bmV0V3hsNXFnN1g4YlcvMVZydERaT1gxNStuYXd2N2djSk5U?=
 =?utf-8?B?d244aXNZVXVKTHpwYm5uUEErV3VBNTNCVWxEN0dzdVZsVXdVK1RwOUFNTDJT?=
 =?utf-8?B?d09rVU1nV0M4TTgrN0FIVmZJdnBGT0VKa2xhVjFiVFpjMVhPVDd6MUd2SnBj?=
 =?utf-8?B?ZU01ZEE5eEdDdVQvNVczRWRmQ0pVcEhNdHZzRnU3SEg3TXptREQ4N2YvUnpt?=
 =?utf-8?B?TlZIb1dXeVp1aDJHaUZQSkN0MlJkVzkyTWo2a3FQQUJWUUdNNG1vTkI0Z3RG?=
 =?utf-8?B?RVFsbGVpOGFZVm5RY24wNkF5c203UVlLS09KOGh4OEVuRDlXd1Vkc1FjTEFI?=
 =?utf-8?B?Q3JHTU9oUnBQYW0wdkNNcG1CR1FMQmZCTkpGVFZTREhmV0h4SkhTUFNMWFlZ?=
 =?utf-8?B?a3hMQnQ0S1NNVytWdWNHdUNQK2RNelRVUloyZ2RKZEVuUUJSWE50aWw5dEsy?=
 =?utf-8?B?b1ZMZUY5TDVKTmdGSmF0NS8rNk1wUlNkOGtyaDRjbDhSVWhlb2U2eGc3QlYv?=
 =?utf-8?B?anV2N1dkT3M2NmdhTVNXT2ZMUlpuRUVuWUFtcHExZjQreFlpMDAva1BwSEta?=
 =?utf-8?B?N2ZxSk5WVkhzcTNJd3ZoZjhTNllQcEVmVHdQY3pwTXJaelptaytlZ05iei9l?=
 =?utf-8?B?clVHK2JlS0tBcmdZMnpsQk90WXZQaHd2SG9wRG01N3FDWitUQ3ZCTmNldzlI?=
 =?utf-8?B?bEFjL2lKcXZwU3NOak1tY3BLV2dnaU9yc2Y1TXFlV1RZQnFFckpvdFpwVWR3?=
 =?utf-8?B?bEVDRXVtS1N2d09tVm9QWXlxNkg0b0V1ekFFZE04dVkydVpyOHBmZnBQUzRI?=
 =?utf-8?B?SHRISzdIdG5QSkRsM2VCakVpNzczVmJYVkRDeWcyKzhxNkVyOEZ1U0ZzOXpW?=
 =?utf-8?B?UEJ1WXR6MnByK1hGSUc2ZWwrUy9SWTR6akRlSHYyQnZSa2pEbUpGNUdKNGhM?=
 =?utf-8?B?R01KM1RtbXhOczdVSktFQVY1V3YvMFNVOE9tbEh4a3lTZjdRTU1hYXliWTFh?=
 =?utf-8?B?QWJIbWtMbjZXQ0xCY205ZGtvNjRhTmtYdzFqMXFFQU1zdGxzVVFaTVF3ZnB3?=
 =?utf-8?B?TXpIQSt5Y2RJY1ZFQkZCNE9TMm15YTREaDVaSkJKM2JyUGpiM2p6ODFHbHox?=
 =?utf-8?B?M0xqVGpoQTJqdElRTTNBcTl1RFZaRzNCbEJ2Y1BPT3Y4T0hOQmRaNVNUV0c5?=
 =?utf-8?B?NnFreXhSSDJnV2RVRnVZWTNteVNnVzMwbEU0NlYvMVlSbWR2cDlnRzhBS2w5?=
 =?utf-8?B?dFo3K1RNcWVxTlh0ZFc1dy9SQUcramM4UW4xcnpRVmZwT2x1U3ZqaEczQjg2?=
 =?utf-8?B?WUpESlhNYkpDSm4xZERRa0FYV1B3Tm1RdldaOXVsWXhuSEpENFVKMnBXMjZy?=
 =?utf-8?B?Tzk4NDl1M094Uk5Vb0lsSGJzcngxNW1HRXV0WFRld0xDdjFEaHN2M1J0dzBh?=
 =?utf-8?B?ZFhhWndJUEw2QzJxV3RITjRDYllQYytTalE1dUFKMmJOaGR2TkNnaVZRTDlh?=
 =?utf-8?B?YXJocGh3OW1FV1ZRMTRjTjBLRm1GNlhoVUdxK05SaWhYbnRBUDNUZ1YvYys3?=
 =?utf-8?B?VFRoTEJNcUlQR0VBT0JKKzV5K0dnck5OVHJ1MnAreXdjU3pXTDlzYWhEZjQx?=
 =?utf-8?B?bFFnenFxVy80VUFXcjI5Zkp2NDl0SUozNXZuL01QbzZDQjJMWmZHRzZEQUZH?=
 =?utf-8?B?V2JHRGRaQUFaQ3pRcHBVdjV4Y0ZiRDJJMFNsK1pFYVhBa3czZHBiTjl4eWtQ?=
 =?utf-8?B?MFhLaVppaTNlcmtpVkxGcENjMzVOM2s1WFlQVXF4UXZ3ZDNEOXZsTkx0Z0dn?=
 =?utf-8?Q?Uq05w1qoJAGB1nRs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EDB695EA0DAAD418F637C235B91ABF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gj5KXd8B54sdqNEj1bE0y3DiKZB/IbkQzDrC21PKT2GDTiR+r18MBdkK3BNhmruRnmhrVE8Kl22T6ENrXuYX22CLkdBjfxzVUdMzUm9vLP8ILC4eT+Y4omhQFRiGT36Gj/Yp4ddukbv0zR9vtw/d/cW20RmUoppT2bk7WrR2RJyyCTOUizpJAtfp7EjMn6ERQEWaQLc81BLlEmAb2+WHT/xYwtVfeYwdYrpCl3hJ8qGgDR7VWtQFJbLuXR2BYSCALKtuN2VuCsG29QZ4Qsuj8nSIf0g5nCmF8wWYkR04eknoPR0BcHk059MR0KVRmbv2L7sewuhNpHRzr/DUdeCyDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db5ce65-0b6c-4821-5997-08deb54f2848
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 02:34:31.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OX+yhhrcVJLtuFod5fdaUFiI4/FENx+nEzt9jMVSCqisUse3AWW25ex/A5iZ4A/5NDk1Xjag+OSU9ev5O3vNrVTSa0OaAkBlU8fyQr5Er5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA1LTEzIGF0IDA4OjA5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQSBU
RFggbW9kdWxlIHVwZGF0ZSBpcyBhIG11bHRpLXN0ZXAgcHJvY2VzcywgYW5kIGFueSBzdGVwIGNh
biBmYWlsLg0KPiANCj4gVGhlIGN1cnJlbnQgdXBkYXRlIGZsb3cgY29udGludWVzIHRvIGxhdGVy
IHN0ZXBzIGFmdGVyIGFuIGVycm9yLg0KPiBDb250aW51aW5nIGFmdGVyIGEgZmFpbHVyZSBjYW4g
bGVhdmUgdGhlIFREWCBtb2R1bGUgaW4gYW4gdW5yZWNvdmVyYWJsZQ0KPiBzdGF0ZS4NCg0KSSBn
ZXQgd2hhdCB5b3UgYXJlIHNheWluZyBoZXJlLCBidXQgImNvbnRpbnVpbmciIHZzICJsZWF2aW5n
IiBpcyBhIHRpbnkgYml0DQpjb25mdXNpbmcgdG8gbWUuIE1heWJlOiBDb250aW51aW5nIHdpdGgg
c3Vic2VxdWVudCB1cGRhdGUgc3RlcHMgYWZ0ZXIgYSBmYWlsdXJlDQpjYW4gY2F1c2UgdGhlIFRE
WCBtb2R1bGUgdG8gZW50ZXIgYW4gdW5yZWNvdmVyYWJsZSBzdGF0ZT8NCg0KPiANCj4gT25lIGZh
aWx1cmUgY2FzZSBtdXN0IHJlbWFpbiByZWNvdmVyYWJsZTogdXBkYXRlIGNvbnRlbnRpb24gd2l0
aCBhbiBvbmdvaW5nDQo+IFREIGJ1aWxkLiBUaGUgYWdyZWVkIGtlcm5lbCBiZWhhdmlvciBmb3Ig
dGhpcyBjYXNlIFsxXSBpcyB0byBmYWlsIHRoZQ0KPiB1cGRhdGUgd2l0aCAtRUJVU1kgc28gdXNl
cnNwYWNlIGNhbiByZXRyeSBsYXRlci4NCg0KVGhlIGxpbmsgdG8gdGhlIGRpc2N1c3Npb24gaXMg
bmljZSwgYnV0IHRoZSBleHBsYW5hdGlvbiBvZiBqdXN0IHRoYXQgdGhlcmUgd2FzDQphbiBhZ3Jl
ZW1lbnQgaXMgbm90IHNheWluZyBtdWNoLiBCdXQgdGhlIHJlYXNvbmluZyBhcm91bmQgQVZPSURf
Q09NUEFUX1NFTlNJVElWRQ0KKmlzKiBoYW5kbGVkIGluIGxhdGVyIHBhdGNoLiBTbyBjYW4gd2Ug
c2F5IGZ1dHVyZSBjaGFuZ2VzIHdpbGwgd2FudCB0byByZXR1cm4NCmVycm9ycyB0byB1c2Vyc3Bh
Y2UgZm9yIGNlcnRhaW4gdXBkYXRlIGZhaWx1cmVzPyBUaGVuIHdlIGNhbiBkaXNjdXNzIHRoZQ0K
c3BlY2lmaWNzIHdoZW4gY29kZSBpcyBhY3R1YWwgZXJyb3IgaXMgYWRkZWQ/DQoNCkFuZCB3aHkg
dGFsayBhYm91dCBFQlVTWSBzcGVjaWZpY2FsbHk/IEl0IGlzIG5vdCBpbiB0aGlzIHBhdGNoLiBT
dGFsZSBsb2c/IA0KDQo+IA0KPiBBYm9ydCB0aGUgdXBkYXRlIG9uIGFueSBmYWlsdXJlLiBUaGlz
IGFsc28gbWFrZXMgdGhlIFRELWJ1aWxkIGNvbnRlbnRpb24NCj4gY2FzZSByZWNvdmVyYWJsZSwg
YmVjYXVzZSB0aGF0IGZhaWx1cmUgb2NjdXJzIGJlZm9yZSBhbnkgVERYIG1vZHVsZSBzdGF0ZQ0K
PiBpcyBjaGFuZ2VkLsKgDQo+IA0KDQpPaCwgbWF5YmUgSSBkaWRuJ3QgZ2V0IHdoYXQgeW91IG1l
YW50IGFib3ZlIGFjdHVhbGx5LiBUaGUgY29udGVudGlvbiBjYXNlIGlzDQpvbmx5IHJlY292ZXJh
YmxlIGJlY2F1c2Ugd2UgZGV0ZWN0IGl0IGF0IHRoZSBmaXJzdCBzdGVwPyBEb2VzICJDb250aW51
aW5nIGFmdGVyDQphIGZhaWx1cmUgY2FuIGxlYXZlIHRoZSBURFggbW9kdWxlIGluIGFuIHVucmVj
b3ZlcmFibGUiIHJlYWxseSBtZWFuIHRoYXQgYW55DQpmYWlsdXJlIGFmdGVyIHRoZSBmaXJzdCBz
dGVwIGlzIHVucmVjb3ZlcmFibGU/IE9yIGNhbiB3ZSBwdXQgaXQgaW4gc29tZSBvdGhlcg0KbW9y
ZSBzcGVjaWZpYyB0ZXJtcyBsaWtlIHRoYXQuIFRlcm1zIHdoaWNoIGFyZSBtb3JlIHNwZWNpZmlj
IGJ1dCBzdGlsbCBub3QNCm92ZXJseSBjb21wbGV4IGRlc2NyaXB0aW9uIG9mIFREWCBtb2R1bGUg
dXBkYXRlIGZsb3dzPw0KDQo+IEFwcGx5IHRoZSBzYW1lIHJ1bGUgdG8gYWxsIGVycm9ycyBpbnN0
ZWFkIG9mIHNwZWNpYWwtY2FzaW5nDQo+IC1FQlVTWS4NCg0KSXQgc2VlbXMgbGlrZSBhY3R1YWxs
eSBpdCBpcyBub3Qgc3BlY2lhbCBjYXNlZC4uLj8gVGhlIGVycm9yIHJldHVybmVkIGlzDQp3aGF0
ZXZlciBpcyByZXR1cm5lZCBmcm9tIHRoZSBzdGVwLg0KDQo+IA0KPiBUcmFjayBwZXItc3RlcCBm
YWlsdXJlcywgc3RvcCB0aGUgdXBkYXRlIGxvb3Agb25jZSBhIGZhaWx1cmUgaXMgb2JzZXJ2ZWQs
DQo+IGFuZCBkbyBub3QgYWR2YW5jZSB0aGUgc3RhdGUgbWFjaGluZSB0byB0aGUgbmV4dCBzdGVw
Lg0KDQpIbW0sIHNvIHRoaXMgaXMgYWN0dWFsbHkgYSBidW5jaCBvZiBnZW5lcmljIGhhbmRsaW5n
IGZvciBlYWNoIHN0ZXAsIHRoYXQgcmVhbGx5DQpvbmx5IHdvcmtzIGZvciB0aGUgZmlyc3Qgb25l
PyBJcyB0aGUgZ2VuZXJpYyBoYW5kbGluZyByZWFsbHkgbmVlZGVkPw0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogWHUg
WWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTGlu
ZGdyZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2lyeWwgU2h1dHNl
bWF1IChNZXRhKSA8a2FzQGtlcm5lbC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWNvY28vYVFGbU9aQ2R3NjR6MTRjSkBnb29nbGUuY29tLyAjIFsxXQ0KPiAtLS0N
Cj4gdjk6DQo+ICAgLSBBdm9pZCBuZXN0ZWQgaWYvZWxzZSBieSBkZWZlcnJpbmcgZmFpbHVyZSBh
Y2NvdW50aW5nIHRvIGFja19zdGF0ZSgpLg0KPiAgIC0gUmVkdWNlIGluZGVudGF0aW9uIG9mIHRo
ZSBtYWluIGZsb3cuDQo+ICAgLSBDb252ZXJ0IHRoZSBmYWlsZWQgZmxhZyBpbnRvIGEgY291bnRl
ci4gVGhpcyBhdm9pZHMgYSBjb25kaXRpb25hbA0KPiAgICAgdXBkYXRlIG9mIHRoZSBmbGFnOyB0
aGUgY291bnRlciBjYW4gc2ltcGx5IGFjY3VtdWxhdGUgZmFpbHVyZXMuDQo+IC0tLQ0KPiAgYXJj
aC94ODYvdmlydC92bXgvdGR4L3NlYW1sZHIuYyB8IDExICsrKysrKystLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvc2VhbWxkci5jDQo+IGluZGV4IDdiZWZlNGEwOGYzMy4uNDhmZTcxMzE5ZmVhIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvc2VhbWxkci5jDQo+ICsrKyBiL2FyY2gveDg2
L3ZpcnQvdm14L3RkeC9zZWFtbGRyLmMNCj4gQEAgLTE3MCw2ICsxNzAsNyBAQCBlbnVtIG1vZHVs
ZV91cGRhdGVfc3RhdGUgew0KPiAgc3RhdGljIHN0cnVjdCB1cGRhdGVfY3RybCB7DQo+ICAJZW51
bSBtb2R1bGVfdXBkYXRlX3N0YXRlIHN0YXRlOw0KPiAgCWludCBudW1fYWNrOw0KPiArCWludCBu
dW1fZmFpbGVkOw0KDQpXYXMgdGhlcmUgcGFzdCBkaXNjdXNzaW9uIG9uIHdoeSBpdCBrZWVwcyBh
IGZhaWxlZCBjb3VudD8gQWxsIHdlIG5lZWQgdG8ga25vdyBpcw0KaWYgYW55dGhpbmcgZmFpbGVk
IHJpZ2h0PyBTbyBhIGJvb2wgaXMgZmluZSB0b28/DQoNCj4gIAkvKg0KPiAgCSAqIFByb3RlY3Qg
dXBkYXRlX2N0cmwuIFJhdyBzcGlubG9jayBhcyBpdCB3aWxsIGJlIGFjcXVpcmVkIGZyb20NCj4g
IAkgKiBpbnRlcnJ1cHQtZGlzYWJsZWQgY29udGV4dHMuDQo+IEBAIC0xODcsMTIgKzE4OCwxMyBA
QCBzdGF0aWMgdm9pZCBfX3NldF90YXJnZXRfc3RhdGUoc3RydWN0IHVwZGF0ZV9jdHJsICpjdHJs
LA0KPiAgfQ0KPiAgDQo+ICAvKiBMYXN0IG9uZSB0byBhY2sgYSBzdGF0ZSBtb3ZlcyB0byB0aGUg
bmV4dCBzdGF0ZS4gKi8NCj4gLXN0YXRpYyB2b2lkIGFja19zdGF0ZShzdHJ1Y3QgdXBkYXRlX2N0
cmwgKmN0cmwpDQo+ICtzdGF0aWMgdm9pZCBhY2tfc3RhdGUoc3RydWN0IHVwZGF0ZV9jdHJsICpj
dHJsLCBpbnQgcmVzdWx0KQ0KPiAgew0KPiAgCXJhd19zcGluX2xvY2soJmN0cmwtPmxvY2spOw0K
PiAgDQo+ICsJY3RybC0+bnVtX2ZhaWxlZCArPSAhIXJlc3VsdDsNCj4gIAljdHJsLT5udW1fYWNr
Kys7DQo+IC0JaWYgKGN0cmwtPm51bV9hY2sgPT0gbnVtX29ubGluZV9jcHVzKCkpDQo+ICsJaWYg
KGN0cmwtPm51bV9hY2sgPT0gbnVtX29ubGluZV9jcHVzKCkgJiYgIWN0cmwtPm51bV9mYWlsZWQp
DQo+ICAJCV9fc2V0X3RhcmdldF9zdGF0ZShjdHJsLCBjdHJsLT5zdGF0ZSArIDEpOw0KPiAgDQo+
ICAJcmF3X3NwaW5fdW5sb2NrKCZjdHJsLT5sb2NrKTsNCj4gQEAgLTIwMiw2ICsyMDQsNyBAQCBz
dGF0aWMgdm9pZCBpbml0X3N0YXRlKHN0cnVjdCB1cGRhdGVfY3RybCAqY3RybCkNCj4gIHsNCj4g
IAlyYXdfc3Bpbl9sb2NrX2luaXQoJmN0cmwtPmxvY2spOw0KPiAgCV9fc2V0X3RhcmdldF9zdGF0
ZShjdHJsLCBNT0RVTEVfVVBEQVRFX1NUQVJUICsgMSk7DQo+ICsJY3RybC0+bnVtX2ZhaWxlZCA9
IDA7DQo+ICB9DQo+ICANCj4gIC8qDQo+IEBAIC0yMjgsOCArMjMxLDggQEAgc3RhdGljIGludCBk
b19zZWFtbGRyX2luc3RhbGxfbW9kdWxlKHZvaWQgKnNlYW1sZHJfcGFyYW1zKQ0KPiAgCQkJYnJl
YWs7DQo+ICAJCX0NCj4gIA0KPiAtCQlhY2tfc3RhdGUoJnVwZGF0ZV9jdHJsKTsNCj4gLQl9IHdo
aWxlIChjdXJzdGF0ZSAhPSBNT0RVTEVfVVBEQVRFX0RPTkUpOw0KPiArCQlhY2tfc3RhdGUoJnVw
ZGF0ZV9jdHJsLCByZXQpOw0KPiArCX0gd2hpbGUgKGN1cnN0YXRlICE9IE1PRFVMRV9VUERBVEVf
RE9ORSAmJiAhUkVBRF9PTkNFKHVwZGF0ZV9jdHJsLm51bV9mYWlsZWQpKTsNCj4gIA0KPiAgCXJl
dHVybiByZXQ7DQo+ICB9DQoNCg==
