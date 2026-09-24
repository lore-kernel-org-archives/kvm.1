Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91D199947
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210677; cv=fail; b=W3IjWz6SWwuMidWdI+yXmrlt+WgpW4/u52xI8335oJplTWOAg4/yz8ZjoPeScmwz2AurBChBWj/SNGQKgpF/Qj5SngeEDceXfemZl+ZG9lGt/0pdFXC3oNwvYGkQQS/tV3C5Ix/eeaN6z2JuqfCD7WoEUqqeaPvS6qhm5E5r1rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210677; c=relaxed/simple;
	bh=O/7ScXkYfJjA/ZqzXeD39IRlHHo0btpwM1IC/NFfghw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VdU/jPMwWvTDTUGV3u9a58bXxzbV1H5/8USHzhE+0/YuPSMdoXe8vvQqlr09xgYndGAxYvs9QRJ19TWRL69+ySHnYWaFI5CU/N9vCvhe6ZrRwhUvCQUb5lURSCeKs0uGMFz7fCEfYmvd5G4KlxCnc5XyR7P9yQ0C6xKxBZ/KeX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtU0uUjw; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtU0uUjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790210676; x=1821746676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O/7ScXkYfJjA/ZqzXeD39IRlHHo0btpwM1IC/NFfghw=;
  b=jtU0uUjw9LdrcRk+MhvJVCd9BQY/CYT/UUA5iNgK6IwJYHtOoM3OLTMk
   0HNVvVf04y/eJmE829bl5+g6YNNBHi0gMMMSrcvC/ch1jm1BeL67rF2ot
   YxihHZMp7GLW6PGu0L3b3JwOTR/lsL1KKCjRRgw8hBuKmBs73oOyXhEEQ
   nD756dt4gBVAEmcJhltreBsKwYzW+BY2HGX8p3ohboTjiW61slAFNdCt/
   DFwIcTXm3aygEviz+pv2gtHLBY08Yq8fFSnJSZDS5oSkrmIMK9iq5CB1C
   G6L5REzlgOTOCoMz3m9+WwF77wAS9XNNUq0VzdkMTQY3ILn6/eOAduwjF
   Q==;
X-CSE-ConnectionGUID: Sw4qTM86RLCvcUPAva8iqw==
X-CSE-MsgGUID: /9wDnw0GRmWjk3QoOVCIHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1463068"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1463068"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 17:44:35 -0700
X-CSE-ConnectionGUID: E2gTiDbQSMuTvWRxpyzpmg==
X-CSE-MsgGUID: sfK3qy8hREew8/47WTFAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="274028234"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 17:44:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 17:44:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 17:44:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 17:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkqrPS6T2345cu+ZtEElGtBgytZa13l1JrruzFer8q3UKmnCm3f+WKUwb6j+So6NH2XPTGD95wNf75oDLtE6RZVr9yKvnpeg92xpBnatet/FteDG6+Ox91CFxh6r1uqOiADtKOgngevHGcddP5A3xGEbgYezlGRoCy6vwDfGFtmbtHpVGq/aVfkXn+W/YSrxY0VZz70bT52lumWnHeTX40oa7mC9DzaDFPOcEuS0e4/Bgj2FxtxFWWH42zWTU9xsWtz5dvqeISeuiH3KwJoQkB8CsoI7uZwESNFwZn8wQqbIZGFdirkUwwtMroMVZxrx4oLaxG4mi6mNfsIu0dXYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/7ScXkYfJjA/ZqzXeD39IRlHHo0btpwM1IC/NFfghw=;
 b=gV/jd+Ya1dzKjSyDk+hLYdBX1uw5aAbiazQ0wr/FZIgYdm3ag2VHFNsO8we3+Ylyyzn3FUdLfKY1NHtlrfjmIaxCotF2OtLatApl77S0sv37NhoWUId7Krg06jqTtAaWMtNgtwBG+F7wJb9voAP8YU3gLrDTIyfn0VSoxtRmmQ590EqBM8cyaXPpwRSjsQcJyZpRtOhGXhj7wav5LmcLQxfVdziBcy96tGNJCHk4bSBbku+USWhkyoXZF2HsKNGSOGgdJUnSn1VGM8iNkCcSCbVt3U2i6rd+gEgjrg6R8O1gVAtgA6xSB6anZBDr0ZQTF5/e3Ti/jXDI0kcmeFux0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 00:44:26 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 00:44:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Fang, Peter"
	<peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafICAACp6AIAAK0aAgACxHQCAAFN8AIAAN/OAgATPvgCAAAGNgIAB5vGAgAFNq4CAAAQXAIAAB1GA
Date: Thu, 24 Sep 2026 00:44:26 +0000
Message-ID: <3ae12b120c7aa2ca56e46bb9a5b2a7b7fc501131.camel@intel.com>
References: <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
	 <aqyAED5ZK48eEZtq@google.com>
	 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
	 <aq048KmPN5WPQ4sQ@google.com>
	 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
	 <aq2t5wJGLtsltMza@google.com> <arG3KvaVqWCDAyM9@intel.com>
	 <12541025-6579-4baf-911d-dcf1453b3e27@intel.com>
	 <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
	 <CAGtprH8syQUQf9PjPe8o6rBFSg+01k=Hb4cvvn3TqED3uWb+yQ@mail.gmail.com>
	 <arRsRkn1V8A3xUE5@google.com>
In-Reply-To: <arRsRkn1V8A3xUE5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4541:EE_
x-ms-office365-filtering-correlation-id: a75931d3-0dfc-4ddf-b5fe-08df19d4fc2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 0XpBQ3OAL1MD5aQ56RIQJcJbffpqzemxiaNdxa71NyWyyN/xXulmKDa7WYW7pJO611LvSm09mxjwfGr/HP8fnhQR6ErsgtrZaASDFOmQZGdVu7gVKsBmLYDuZ/DNh8x5f8RclLPVNMKwTCnxlgSBviq2rqIn7PpPF4Sidx0YlV+roORmuwSeu9DUzjwvlDBp5duau+kLOUcwGesFdErtmKNHBzyraqIrijq6qyhsnlKob5BMKYv5r4M0GqETaWU9QjgHwMrriEwILQtBKywDInhF2J4JSf2K5XE6zeSPMvnQzx89OJncKDA0HnCgUlZXxXTMenVh+9MwXB7GGpvZFKTBzfmjocmRiCKX4WvbL8hOIQtTBn+Mxjb8rPKi6t2AZGli9Id5kAYIH8/x+7zG87FlCjevwY5KbqCqcksqVUxonMpSC7rng02C35agzXN40/9vUlG1Q2234aq6gI8/jR+Eysf616siqbBPOf302GJ07zOMamfx1hCLpwFHSEMJ2XU7YcHaDPMXVGrQSSXHLNxKaOFmgp4fJ16Xw/Z6Lx2/EyX5FR5EH2GVSLV1+yE1+3iVl9XXrRfXuHxcksJFUzrSaSdaYCwtFXaK7/cAdItGzRAHTNF7rVF7cl0S3XIIfAC/sJNvm9N64CZnSbUV+lkVaVjm3S6vbdTk0HfnKKnWJegZuOzOdUGuQt2skuvJLv5PXhetuaJnhFMkS8zGjfwLF5MSwnDDi/VmzsmDeZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJ4cU1jWDd0TmkzL3dsY3hDQkZvamN6TFZQck1rMWRLaGQ4NWlYbFQ4N1dV?=
 =?utf-8?B?RHJkUUEyN1ZvTU9TUEdubkhWbUlUNTFmdDNVSk5jMllMVmNCVnVuYW9TZEF5?=
 =?utf-8?B?RlF2ZlpBTFZMZ2pUb21sUzJVMmxDMno2aUNINEVkWDFBVkJ1THhSSlROaHU1?=
 =?utf-8?B?dkptdFpsNHFKdUpFVWpPdG0zbFd1T21KUlpyOUVVRERzeFRFZDFubHBVSDA0?=
 =?utf-8?B?S0d1aFcwUHE0a0dnOHhOQkcrZWVQbzlEMisybEpTa2hpR0lWSWpPbEtScnpk?=
 =?utf-8?B?dm95RzZ6RzFEZ3JjWXNqUmw5ZnZQcllFTEplMCt6TmkrWXFSQkttV3pBaXdh?=
 =?utf-8?B?amZ6Q1hUR3N5YTlyNE1hMThSTkFtVXp2bTdEeHo4M1J5a3pKRVd2T2NRK3gz?=
 =?utf-8?B?WEFEQ1dOUEgxZC9BYVFwOXo1dkxRYllQSHM2dWlrNGNpNGhHVmF0Mk5EV04z?=
 =?utf-8?B?ZkxZVDBLOFY1UFkwbWcrM2xYNU93QVRoZTBwUnVZYnJBTmZRL09SeXVTNGlN?=
 =?utf-8?B?ZFZvM25HdDZjTFhYRU9VYmk0MHFTaWVGMTlpMDc0RS9zRFowd3cxTjBuakJj?=
 =?utf-8?B?dEQ1SlRwTXptajBVRFdveVl6dFp4Q1RmZDZjVEZORFRTc3hlQiswYWxhWXFR?=
 =?utf-8?B?ek12Qm1xVE5mQzJIMzdDR2JFYU9HamhXN2ZTdzlJc3BJdVljTTlGNEU4L3hJ?=
 =?utf-8?B?NXJuU2lvdTkvQ2E4WDZCMHZIaXMwS1pmQmhVcDc2R0treUZhZ29pcEJKK1RZ?=
 =?utf-8?B?Sm5oS2c5cTRqWUwrR1VtamZwSmE2NThCeHJ0UUkrMXZVNUNRdlhQQUlxWlUr?=
 =?utf-8?B?WTdnbWYvclpDMjdubFVuZzNFS0tvL3lxSmlicGU4Rm5PSTlvRDZVYVFOVDd1?=
 =?utf-8?B?RkhkRWdURDI3NVJJazRzRW9vUlRITngxcldLdmFpQWxONVNiTlgycEg5NVRM?=
 =?utf-8?B?M243V2pzaEdPWWJpTVRqV3hRRDFpbFhqLzVZbDVzb0U4Z2IrenRvanVsSk1F?=
 =?utf-8?B?OThKdDNwQWR5bm11RDVpSmhTNGhCWEhTN0pnZVdpa3VWOFpDV0xrbzdvQjd4?=
 =?utf-8?B?SDlRYlJpRVNTcEFiR0x0SlFpWlI5SWhtSHBZaGRpcEk4dm9ZcmRrWnF4UjJE?=
 =?utf-8?B?Q3JPdS84Kzd4Y2ZBRm1uQVlUQjVFMCtEallSK1JPM1p0RUgwbUpURXhHd3Rx?=
 =?utf-8?B?dHByL042ZkhXbVY5UGswTVFIM2FpTzY5djZvSXIvTUhKbTVNaDUzL0pWMmo0?=
 =?utf-8?B?dmZ5RjhsUHNNblRFZExmTkN2bnYxck0yaFlkS05keEJ3SlNWN3IxWmJJeHBp?=
 =?utf-8?B?T3hEVmVuVmg1L29aazdIaUszWFJEVm9JWjZjZlhJV0N0bG9qTEo1RThvazVa?=
 =?utf-8?B?YlFpV3Z0YXlsZ29vbGxsdmxNQnIwbmxMK01jWG1mbXJtb1k1NVBaTmJsVWdn?=
 =?utf-8?B?ZlVJWndwOTFGUEFLWWR2dklFekIzd0UrWStrcmk1SWExT25hdzd4anZJU2F3?=
 =?utf-8?B?RXRPVnIwTEJKOHl0ME5HSUJYeUtJV1NCUHlVaVpUaGh1clNRQjBxd0tFZmEx?=
 =?utf-8?B?QldiRjZmeUxQV3hKM2M2SHF5a0dBZjJnOXQvS0tma1I3QmMvalczMi9MRXlB?=
 =?utf-8?B?UHFOaVJUZnR4TllSQ3BmeDJTVlhJOWkyM3RpQzBOQ3lnTjlZYi83aHdoTm8w?=
 =?utf-8?B?a3FjaWlHZVNSRDA1aFpicE90NkxxU2xVaWRkTEtrYnYwZ1QzMkI2SDJRQTIv?=
 =?utf-8?B?dHVMbzQwbFhPd2wyeWZLWno0R0VhcGl5WHlkK05BKzk5VnJQTUhKTjNGWHY1?=
 =?utf-8?B?SG1zeEc2SnpaeTg5dTBPbWJqQXhtR2d6djkrVDlGMXl6ZStTb3ZuM0NpdVlF?=
 =?utf-8?B?YjQyOUFBSHZtZjQxT0tONzcxakxpVWM3MTltMFg3cTErSmE1aStJVkc5SXlI?=
 =?utf-8?B?REU3TTVBdGtBQU1YVndPR0ZRUUp4WnQvQVZ5d05hZGNLT0xHSUxRTjFCR044?=
 =?utf-8?B?YUNaYVpWV1pZL0dnY1ozUWhzbFkva1pVQm1XVmJCVkpiMmJIc1VHVkg1NVpq?=
 =?utf-8?B?SkJZbmMxUlZ2WlQwMjJwd0dNOU5LU2RYc0l2K3hFYWFvZm5qSTFqVW1Idm1i?=
 =?utf-8?B?TlRub2xkd0dBcGI3QVZXcGE2UDFZaThqVDR2Vm1nRXBVbGQzVjE5OGJGcFhl?=
 =?utf-8?B?R0lHNG9tbWtpN2tIQUZUZjdNb1U1WkFhWWVzMDg2empqVlZVc0c4YlBITlhX?=
 =?utf-8?B?c1U0cERXUTRaN0F4ZUU5dHZQaFM5MWx3S3h3bVZvTmpQVmRaeFBtbndLbFVh?=
 =?utf-8?B?eXhnQ2FFUFpHZTUrZ1JQclBsR2VNMExMRFp4VzJBcVNuVEsvL01IVkpEYzUz?=
 =?utf-8?Q?CvFR1qGQf53bpvqE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA9BE918A32CEB4B953488E8CCFF1875@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wu2eHzdqzhsILpm2MJWE6hRWt0qzVBRasap/YH6iPG1l9A6sON4EPTn3ira0A+qqRY0Eo/5i4WDFOShHnFTO4c+0qMFE8cnSP8SaLPBLoI3AzJcdyUNvwXVSaa9PFQBjpfBP5GqJiCHnRxNU6jwxqxuF8XSel5f2ziBSU/oOn4Eo7PAbPkeywVNArpZEHLxsdPdwCFS0Eiwtb7xsesOCm5xs/r9xgwOkmz2UyvfP6onz7nN30nJGoqOdaBTxDgks83FXCiv/isvOAOBcoPyb0/aXQbPUtpZuB1JRl/gnec5wJNHBuO5j1tQgcfIn+4h04zmoHqwNSSEazftDtlBFgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75931d3-0dfc-4ddf-b5fe-08df19d4fc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 00:44:26.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inAOjectjJOQ+JjmGB+IQXbo/Yc+BncFcuuxnd+Wc7YqgXOxOfvVMUW2xtEGVoe2ZzRVw6TRIHHwG/PhVz+JmpbAVI2kFIeZGhV+IdRahok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE3OjE4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBGcm9tIGFuIHVwc3RyZWFtIHBlcnNwZWN0aXZlLCBJIHRoaW5rIHdlIGRvbid0IGNh
cmU/wqAgT3IgcmF0aGVyLCB3ZSAqc2hvdWxkbid0Kg0KPiBoYXZlIHRvIGNhcmUgYmV5b25kIGxl
dHRpbmcgdGhlIGFkbWluIGZsaXAgYSBURFggTW9kdWxlIHN3aXRjaC7CoCBJJ20gYS1vayBsZXR0
aW5nDQo+IGVuZCB1c2VycyBvcHQtaW4gdG8gdWx0cmEtcGFyYW5vaWQgbW9kZSwgd2l0aCBhIHBp
bGUgb2YgZGlzY2xhaW1lcnMgYXJvdW5kIHRoZQ0KPiBzaG9ydGNvbWluZ3MgYW5kIHRyYWRlb2Zm
cyBpbnZvbHZlZC7CoCBJLmUuIEkgZG9uJ3QgcmVhbGx5IGNhcmUgaG93IHRoZSBxdW90ZSBpcw0K
PiBnZW5lcmF0ZWQsIEkganVzdCBkb24ndCB3YW50IHRvIGNhcnJ5IGFueSBrZXJuZWwvS1ZNIGNv
ZGUgdG8gbWFrZSBpdCBsZXNzIHBhaW5mdWwNCj4gKGFuZCBpdCBzaG91bGQgYWJzb2x1dGVseSBi
ZSBvcHQtaW4pLg0KDQpJIHRoaW5rIHRoZSBkaXJlY3Rpb24gaXMgdG8gYmFzaWNhbGx5IHB1bnQg
b24gTGludXggUzNNIGRlc2lnbiBmb3IgdGhlIGluaXRpYWwNCnVwc3RyZWFtIGltcGxlbWVudGF0
aW9uLiBCdXQgYmFzZWQgb24gdG9kYXksIEkgdGhpbmsgd2Ugd291bGQgaGF2ZSBzZXZlcmFsDQpv
cHRpb25zLiBUaGlzIGlzIGdvb2QgdGhpbmcgdG8gZG8gZm9yIG5vdyBJIHRoaW5rLCBiZWNhdXNl
IHRoZSBURFggYXJjaCBzaWRlIG9mDQpTM00gYmFzZWQgYXR0ZXN0YXRpb24gaXMgc3RpbGwgZnV6
enkuDQoNClRoYW5rcyBhbGwgZm9yIGFsbCB0aGUgYXR0ZW50aW9uIGluIGhlbHBpbmcgY2xvc2Ug
b3V0IGEgZGlyZWN0aW9uIQ0KDQoNCg0K
