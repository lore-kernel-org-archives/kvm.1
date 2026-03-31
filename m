Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26C225417;
	Tue, 31 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952063; cv=fail; b=Aa39oIPWp3sBEDqET+3B9keNQANRgLtY/R1L++jj2XQzLCiRskMdFh1YygyiayrhteR5WNJj6u0SELCvhftfwfw3Avy5/Hj5bweAYUxJrcJmMV/yJGex6PIvv+BmMsw6EUCu3M+WUTWQt0dSJEa7XnUofmnp0X8niXD+1K55v44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952063; c=relaxed/simple;
	bh=utHb+t/HLbwE5YlOh7Gi93kRa2IYDfop1ixrdeTd/jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onvuKwGiwuflqaY4B3OfAu0PLED3Jd95mBnh7pv+5/0vSR/O+7sxuDW9Hmqoo70iCMdV8Ist4nsHmb0bgkMOQ5bfa2+kWVXX9cQqRlL32ZJvN1lozz4iWt+LIUNdfl5UOm1GMv0H/Sk7LmSRtuWzAvmbRpKA9GPHpJmUdaHnqwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwN2KNKS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwN2KNKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774952062; x=1806488062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=utHb+t/HLbwE5YlOh7Gi93kRa2IYDfop1ixrdeTd/jU=;
  b=YwN2KNKSKf7gMhlmI/skxa63ima4zbTOD+FcD5OAeb8StTEhnm/uAwOC
   9dpylIu5rBc+SmaSTzASXPkOIjCcg2zYJxf18oAd3yMKOvuvflRlcZfJP
   Ns6cXEKnXyjveZpnzDEWYIxteQf+/MByOXsLT+lNoT9gsR+VBbecxcz99
   93NhFKxWEY9NUQKRiojR2aC5x/qb/r8exxaoMq4+O1pZRVGf8mGbxZXOg
   nPYDN/lzM6YdmY+sZ4KbqkRMxAf5Zl7t8RVjpa+8bdKChZ+zlxYIJscnf
   GDtI2byvvmhG2J6yU+8sELkuAwcz833xvyrwpLwVgjp+0XT80wlnIchbf
   Q==;
X-CSE-ConnectionGUID: oGOdLWp8RQGjm1EMRpb5+Q==
X-CSE-MsgGUID: MZnwhSY/QrWqSjru2qIBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="63512986"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="63512986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:14:21 -0700
X-CSE-ConnectionGUID: D5NZCMV9Q22NyWipnM+bcw==
X-CSE-MsgGUID: ruQg1aYAROCLa9DA9QE8zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231255926"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:14:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:14:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:14:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:14:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1nyIo0qr145n6jJ8E+BZXerczrYg3rmpkLlmQpY/jhCAhjJywG4QKfClA23BXQ5kY2mZ/Fr3gtLVfcw4OANrfMDCUlZDcDusRyvbWGG3FXzrydbSXFYB0DqOKS0V7YXZrjWhuMv0/fLDvs5x/bAi4oJJY6g0va3515fRETanlpgeBcpM6sAfrVo5/f1wIXLLRtxHCYWGHxKT12tzqISyFZiQQe07mihFihl/AJ+m+coQl54OKyDsSe26+dwsGIVI2ULPIoVxZb21maM4/PwM3n7U7SW5Zc0fQQigHQ3UTlq05pYfeGqRuY9iEtQa/i9cb4Cbg3wI4FgbEc1SOlSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utHb+t/HLbwE5YlOh7Gi93kRa2IYDfop1ixrdeTd/jU=;
 b=P8RI4WXa12XuFo7eZ+MaGuFHjKKl8EEu5E7hdsNEKDpekAovyHipNoCm4lNjl+02NTHD+uuKT7HiSNs/vo05ikeDucyTmwSx6JXE58j8O9itPnZ4xqbKrCyQLHpYJPMd56ys9AhTugRlnYMmxKBcbjKHT7xoScH2oQe2xoT5dlxalkay54E8/WtUQiCs4YowN7lgmpMkS+pxZBkQd1h69ZCl7B5Bezs2U3oLaoovlRKhCfzA/cp+CvrcmzzOYM+h0W3EZ7ikWHVdB74gg88zPik22hYcZ4bWmboddn3TNRFPzlHYSjs/Yw6ygxT0obiwXp3RpXLl6zBj8RougFo1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB9636.namprd11.prod.outlook.com (2603:10b6:806:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:14:17 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:14:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on
 mirror SPTE "fails"
Thread-Topic: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64
 on mirror SPTE "fails"
Thread-Index: AQHcviZZFnrZqGY3+0mCqCraMGJG57XIaneA///3jwCAAAvogP//9aYAgAAOXwA=
Date: Tue, 31 Mar 2026 10:14:17 +0000
Message-ID: <86a7eaafca7e908020afe2377002ea5f2550d3ce.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
	 <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
	 <acuRGgIEeXZ6ng0h@yzhao56-desk.sh.intel.com>
	 <9d1078b85571e7400905217622b5aaf2ebd6eb84.camel@intel.com>
	 <acuSaMAI1FAPIgII@yzhao56-desk.sh.intel.com>
In-Reply-To: <acuSaMAI1FAPIgII@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB9636:EE_
x-ms-office365-filtering-correlation-id: 8fd75ab8-a4e8-49d5-8b11-08de8f0e443e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: /WKDX9s9WN0MsxvWpe+Hs2Ygt6LV4KAQ75uf0NC7mTB8xveRt7FjPefTa6zTOGVrqr46K7peVeNZ4/EFIhm+K4K8j7/WTBp7SyAhmkZvyBK+pBKKNXa3eNkoFKbMaJ51TxKyHznWGL2/DpG+SQYM68glQQF44E8O+n7JseCioXa3vOP7nrtffpOSAM+v0/0s8M9aQhIs5AueWfNI6HyH6O5T7RyKdpta6krgKo/3g/LuLZcf8SswYemM+eCLBsjyWSKFjycJDVh0SrJXJNP4PA31SpoUDYqpz7QuRmVxPTbo0IZKx+NcZBr608fYECJE7Yc9FtjjkX6afZ7q5KnE7oLgxROnID+0iBxaB9oSKPIXeFFW/5P5i9MET5Zf2bIGH/vQWL3HAbfWBE6cNFTQZw79/1ncxKoS4/q98xRmRwWES4fP+Ho3V6JNgT0PXG8w9pgFf8w2tIZHpFWKjquVsNHjkGatRX54pr4+rBT4M5PsYLr8jY/XB94MzQLkG+y7STRBnuEb5/v9O6EtxhrilkbjrSJKRE0ECu2uXMKEfhR/co7E52oEB8oQdk626/r2WC2BAWOV5IKC5w31U7Pfc2lve8LnkXtW6FfeAG3XSjlkX3zNKJKp87iv07cBz/NR0BwRnGZQM6lF4ePkDmCnpsIIPRBRoU+/fcd39CQYEavAinmdts6aRcG8wyPy2NfBdrhtzdplczbNqP4I6EAvRTjhZZ/Z3hocZ2XJpyoYKwI5yvgvfFGrdFdYXjCI2tpYrUy4LWW9bc3lRrlq6g5jv7iKRVOZWziaVaR/Ybn6fgE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHBFbjQraXVwK0ZNZElpaUtsWUhMVys2WVdFSnFDdnFYbit2RHJFdUI1U0Na?=
 =?utf-8?B?MVZJT09rYzNnNUJnbXBYN3N6RHFMZWVDUThnYTF2a3kyZ004Z0VvU2k1cnRR?=
 =?utf-8?B?Q3paci9IZkxKVjR0VWVINW5mN3RRQWxUNlVvaUJoWmxISXR6Q3FmcWkwZTcz?=
 =?utf-8?B?U2F6QUo1V2srVjJ6SStFODFwbzZGQ3huUmlnMTJNaXFCY21YQW13M1lwTkw2?=
 =?utf-8?B?cmFHMDVxdXk1TUNuSXUzdys4S2lmZnhFK1BvaWl4UUZCMStEVkZPbTBBOGdr?=
 =?utf-8?B?MnJPTktVemRBbWZhUkRON0pYVUNDYjcyREVsK3d0SlRDc2d1c0ZuSXo4bnFS?=
 =?utf-8?B?eXhCZXc0ZUtKdVpma2xVS0ZyZEpXSElhdEFaME53UEJ6TGE2c01JSUdsZDRF?=
 =?utf-8?B?Y0pPL0RGeTZOdkVuWVJ3UGsxUk5MK3dYVFBENzk1ZGFBakJjZ2hoMmdzOUJy?=
 =?utf-8?B?ek05V3M4RFQ1TzVoc3VwcTJaRVZvQTg1blVncmI0YTRSb3pCU3MraWpWaXMx?=
 =?utf-8?B?Ny9VYTg4WndpTUhyT2lQdjdVQ2RiQTFDemNySS9yaXpONlptY3RtQW10RWY4?=
 =?utf-8?B?QXlYUW8yWkhuYkI5d0lFTHd1YkM1bUdZUmdWOUVVVzZpWUF5SzRKSFh3eUVT?=
 =?utf-8?B?S2hjU3J2Z25lNlF0eG05RGlZc1FCS0RXUk9ud0orM1d4M3N2K0ExZGN5dlh2?=
 =?utf-8?B?QVpkNkhqd1BkNmRONE5QamJna2l1WUtWTVAyQmY0dnpyRFd3VGRNU1ZHeWtO?=
 =?utf-8?B?R0NQajJRR1hkeGluYjA2QklicGJrRkhvbXp2TmJGa3JTdEpXbysxS1dwdy9m?=
 =?utf-8?B?RUpBSHQrZnhZZW55QnowQ2R3aExFaDFyYkNnN2Z3eFB3bnJZeTNWVVdCZUF1?=
 =?utf-8?B?anMyY0FnMERyK3JTT25SWS9SZ2pGMjF0ckFjTGdaZXM2ZkFTNmNqQTZHYnBz?=
 =?utf-8?B?b1cyVkxnZ0RZMXNGYVoyNHpHdW1EeUoxdXI3LzFFd0xCNENObm5sOUN1azYw?=
 =?utf-8?B?OFRQWnZiWTI1aitmRHJ3Y0thQk5LaC9kUzVXL01WWWtldktoc0hCSzFxeEMr?=
 =?utf-8?B?VTNmSTIzNk8yamRvc1ZMS2pmR0ZWZWhiRnlTYTVlV0I0NCttMS80OGYxMlV0?=
 =?utf-8?B?NDUvSkthbjcwSjZrV25zc3MyZUNxUkNVNUs5UGhQV0RzZ2M0RUo3aW5ZcFdY?=
 =?utf-8?B?NWhWRk8yMmJDOG5rb2lKdElZNkc5Y3BSVDJGVGxkMkdsT0trYnJOUEw5RVNr?=
 =?utf-8?B?bWF2WHU3Y2l2SGJ2QmJCbVhNeE1qZ1J6a00vLzJjYW16TVJPZjlmellrcWxa?=
 =?utf-8?B?aGtmbkNXSHlSenJNTzZqcnVJVS81OXA3Y3lpTUVGVWdPKzNCbzlJQW1WMTFS?=
 =?utf-8?B?bWV2K3dHZ1JWdFhxcUczYlNjVys0Y1F6Ry9jaVhpUmNYWUtUaEg0YUxTUXdh?=
 =?utf-8?B?a0tCdFJrQ2JxZ01tSythUmI3WUFrLzEzQVdpb3hHbjJ5cDZyMll3dmE5cTVu?=
 =?utf-8?B?akNpazBqS3IrcG5zNWdVdHlSK2daUm83ekVibFRUa290Mk81anFrTUV2bGNp?=
 =?utf-8?B?T0JyL3hydHZoTUhTL3ovaEhVbUlaVG5aM0haOEV1c1JlOFRtbXFpRWs5YUZQ?=
 =?utf-8?B?VW54UlErdnVjWU1VMWRZTGlBQUt6ZUxQbkxDeHU2QjJRcWJTcWYxN0thTXFY?=
 =?utf-8?B?QzBNalZhSTJsdDZTb3NNVFhhMTd6K3U5R2pBY0NJN1VoeTVWc0NYMGNhVE5u?=
 =?utf-8?B?dXJWWmVvNDEwOCtnMUJvZlBJenhkNGVpcWRwMDgyVkJPdWhWc1ZmbllUSTZh?=
 =?utf-8?B?bldaVWhpVGk1WkJTRzhBT3dlcW9GNUZOVDQ5VmJVSFptd0RudWVCV2FvTlBp?=
 =?utf-8?B?T0w1a0Zsdm1TR2NnTE9VMnNiS0g1OUQrcmJzNjJNSk4zWWsvK3FLeUl1SlVh?=
 =?utf-8?B?RjNZYlBPSUZyVnV4Zm8yRXJvRUJmUTJnM3lBUjYyU3E0QzlEanU4UURTSkFa?=
 =?utf-8?B?b0JtT24vRk91T090eGtjdjYyYmtMbkYrRzBwY0lVSEZCUlBiU2VFVlRNN3NO?=
 =?utf-8?B?QWp5RWlTOGVOSDNWUlpiNkF3L2d2TU9YeFR0NWVmMDAxNE1haWZzSHlGbzJt?=
 =?utf-8?B?aU1LOFNXZ0tPTUpnMUcrREk0d3BYTFZ6WGNpUDhpTlMxcmV3blp4VGpheDg4?=
 =?utf-8?B?TittSzhJMkZ2djNWWGhHSkg0Ukd5OVR0QUptMmRLMDg0eEQvQUI2L3RpKzFr?=
 =?utf-8?B?ODZqeHVybWxPMFRmWWYrZGptVDJsSldhbmVLcXR4Q3JPQWE2UlVFSnVaWjd2?=
 =?utf-8?B?WGs0bE9zc1hEQUpaQkJjT09iRlhYZDNOWGxHL0NEbWljSDBrbnplQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7410A22AC20A2947B7E2D26103D6D77A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W6aMxnLWn//4pDJL3nDxnyNzSo514KidoeVcS73SlgLyCqw2fbSNQlUlLeVtCLR/1vslanBn64kbQ0ITR9cC1VEMZcydVrdZXSyzgsMpCP7EvGYmneL0m2BG37D1iR466EaSwydQmVLzsHSMmFQ1LWPSMkXiPtbQZawAacAsCHoVdJoG8eu+DM3aStOUYCuWSbvqPuq1TcWVedokped3JaX9U3jqn/feGEDVeEELJ74/QmCaHmlLG2iWOwkU8akK95nXFPuJ2e6al6UEURJzqAmO1JtkAXayF1TXVAmgrqbnDDOANiKNwbxvqdlkIGOhKwPNpLR02Tue1phrl/vFCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd75ab8-a4e8-49d5-8b11-08de8f0e443e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:14:17.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DIAc6nlv89n96s0vTRKhESw1faQgehQKM7Bh+C9Gzcy9C+QmbtWDxa0F6KahCCcMcLcjcdswqf6rNi6F/6Jgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9636
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDE3OjIyICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VHVlLCBNYXIgMzEsIDIwMjYgYXQgMDU6NTk6NTRQTSArMDgwMCwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKCkgaGFzIGEg
V0FSTigpIGF0IHRoZSBiZWdpbm5pbmcgdG8gY2hlY2sgdGhlDQo+ID4gPiA+IGl0ZXItPm9sZF9z
cHRlIGlzbid0IGEgZnJvemVuIFNQVEU6DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgIFdBUk5f
T05fT05DRShpdGVyLT55aWVsZGVkIHx8IGlzX2Zyb3plbl9zcHRlKGl0ZXItPm9sZF9zcHRlKSk7
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlua2luZyBtb3JlLCBJIF90aGlua18gdGhpcyBwYXRjaCBj
b3VsZCBwb3RlbnRpYWxseSB0cmlnZ2VyIHRoaXMgV0FSTklORw0KPiA+ID4gPiBkdWUgdG8gbm93
IHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoKSB3aWxsIHNldCBpdGVyLT5vbGRfc3B0ZSB0bw0K
PiA+ID4gPiBGUk9aRU5fU1BURSB3aGVuIHRyeV9jbXB4Y2hnNjQoKSBmYWlscy4NCj4gPiA+ID4g
DQo+ID4gPiA+IENvbnNpZGVyIHRoZXJlIGFyZSAzIHZDUFVzIHRyeWluZyB0byBhY2NlcHQgdGhl
IHNhbWUgR0ZOLCBhbmQgdGhleSBhbGwgcmVhY2gNCj4gPiA+ID4gX190ZHBfbW11X3NldF9zcHRl
X2F0b21pYygpIHNpbXVsdGFuZW91c2x5LiAgQXNzdW1pbmcgdkNQVTEgZG9lcyB0aGXCoA0KPiA+
ID4gPiANCj4gPiA+ID4gCWlmICghdHJ5X2NtcHhjaGc2NChyY3VfZGVyZWZlcmVuY2Uoc3B0ZXAp
LCBvbGRfc3B0ZSwgRlJPWkVOX1NQVEUpKQ0KPiA+ID4gPiAgCQlyZXR1cm4gLUVCVVNZOw0KPiA+
ID4gPiANCj4gPiA+ID4gLi4gc3VjY2Vzc2Z1bGx5IGluIHNldF9leHRlcm5hbF9zcHRlX3ByZXNl
bnQoKSwgdGhlbiB2Q1BVMiB3aWxsIGZhaWwgb24gdGhlDQo+ID4gPiA+IHRyeV9jbXB4Y2hnNjQo
KSwgYnV0IHRoaXMgd2lsbCBjYXVzZSBpdGVyLT5vbGRfc3B0ZSB0byBiZSB1cGRhdGVkIHRvDQo+
ID4gPiA+IEZST1pFTl9TUFRFLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlbiB3aGVuIHZDUFUzIGVu
dGVycyBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKCksIEFGQUlDVCB0aGUgV0FSTklORyB3aWxs
DQo+ID4gPiA+IGJlIHRyaWdnZXJlZCBkdWUgdG8gaXNfZnJvemVuX3NwdGUoaXRlci0+b2xkX3Nw
dGUpIHdpbGwgbm93IHJldHVybiB0cnVlLg0KPiA+ID4gDQo+ID4gPiBUaGUgZmFpbGVkIGNhbGxl
ciBuZWVkcyB0byBjaGVjayAiaWYgKGlzX2Zyb3plbl9zcHRlKGl0ZXIub2xkX3NwdGUpKSIgYmVm
b3JlDQo+ID4gPiByZXRyeWluZywgYXMgaW4ga3ZtX3RkcF9tbXVfbWFwKCk/DQo+ID4gDQo+ID4g
SXQncyBwb3NzaWJsZSB0aGUgdkNQVTMgaXMgYWxyZWFkeSBhYm91dCB0byBnbyBpbnRvDQo+ID4g
X190ZHBfbW11X3NldF9zcHRlX2F0b21pYygpIHdoZW4gaXRlci5vbGRfc3B0ZSBiZWNvbWVzIEZS
T1pFTl9TUFRFLg0KPiBIbW0sIGRpZmZlcmVudCB2Q1BVJ3MgJml0ZXIgc2hvdWxkbid0IGxvY2F0
ZSBhdCB0aGUgc2FtZSBtZW1vcnksIHdoZXJlIGl0ZXIgaXMgYQ0KPiBsb2NhbCB2YXJpYWJsZS4N
Cg0KQWggcmlnaHQuICBJIG1pc3NlZCB0aGF0IDotKQ0K
