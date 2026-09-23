Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6740B38C;
	Wed, 23 Sep 2026 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204039; cv=fail; b=ntR+8ON6vfvjRMf44J2wVyN/qiKddJjntCWbqUVHwmzxoPdwOamIZH7UPCgduhfylbbxZEf1U2W3GmZ5MpcRzGuApoe6eArpEPOABYB+nXZpFnQIjZ6jlMzDlURrcO6YjlalJMbBs4lju4j1iVUh4GjP7TayCBX9uAhPqZOSp/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204039; c=relaxed/simple;
	bh=j1GwD7RcB0pIyFuoEwTaFyA109NM+FhZj3367qh1Ivs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BtePvOqBULvfJGephvGh4rqDICqSBYF3URESVYy+1gQ9wxE9oVrOOWy0qo1ihPCmcSkbyH1DGYMj6sHvQXASsTugTASelYo5QUOxGnKRBEy89dEGxXV7nEr/WeuJXBQUAHpk3htwdUdizZS8aN/9A1CtyQLg5yV6zntHxaplE54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAFXEIcX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAFXEIcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790204038; x=1821740038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j1GwD7RcB0pIyFuoEwTaFyA109NM+FhZj3367qh1Ivs=;
  b=NAFXEIcXYRDGBmoo0hN1a3/2WIROlRJ5Kx+11/ILgnKqDl2HA0iIYPNN
   xBA3mU60qIDLs/viAPMXwB/qZbj2uWiwgZkcNPKWUatoAQ16Dh9V+6vPj
   RtmvBSAAWPxpXRzIaMT264KV5KOWP9cE4uU6HCh7FYz+9WHh544D5l7OZ
   rb2adaUcUEYriYm/gL2KzReuiDDG0g6pDO8OeRyKWRnmHVqNNzAFzUpux
   3DX8cHnXj7lVNjsAmcYN4jeWuQGJwfEgZt6f3+0ANmvUrc5qihfUoheRu
   v1xhHzi5vTTZoEP3fTPqKqFYr9I+cwYOM9KjBVdbiJEayJ08nos4kAS3W
   Q==;
X-CSE-ConnectionGUID: rdwHpj/CQhmuyqM7RErsUA==
X-CSE-MsgGUID: f5UZ19IIRsebnnodlWAF7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78506729"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="78506729"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:53:57 -0700
X-CSE-ConnectionGUID: bjAmCKu0RySmsXA3H7sOFQ==
X-CSE-MsgGUID: Y6sSF7Z6TGqX639Qx23Org==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="278549937"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:53:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:53:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:53:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyMaOJq/pBNteRxn/q/McjZ3ca+p4H+PgwdFrigNdQbfZAiV/8N35hRBY1miuxk/F48zzGu3knHC4RZxpMkjyvqRiafRtlaKHbPYz+s7gBMVkTPxt53ej36tCOcL8z35eKCK7O45D+NDQLdKoQVSf1OXnTgxxV+GKV63W+SW9gj64K0MYc1wqc7fifllNuwnsM94R3v4d2e6/NGdDd1ops9JegayxcETEFRssXwWR6RBzABpebJiNh45v9i9ylcLBWj00rAyNOnhinT9NotduduRxXxK0Hcp2BhgAIbYPW9CYUYHbD9PM60Vq+bF03Zewc3IE5geVXL8luNpzFwoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1GwD7RcB0pIyFuoEwTaFyA109NM+FhZj3367qh1Ivs=;
 b=raRbF0zsAgs0tQx6VT70GyEjr5FmONSKRJVqB+FuR0/V28Qza63b+0aWm479yB8TKnq5NQq/iQ6vZ2EkK9ylutlCFRJY6KseyUqT7XogGB4/SiuMpG0R8AzazHZkd6tYo2Jxsur8XDcbfgY5sox7I3MNAAdufQxumIAls4LW5XPAFIBDOOBrG/lljQ5t05VI2S39qtlneGuvYg15LkUOmimgglYTNSqY2Bjz0XSUhtNQcepneShfuEBCPaQn3J/0D03adamvpAQU+zBDBu6EaP71omgCrYEQ89splXt52LDURA+rFCrEhUBXVySjS3TJe7xob/CJd2YnKcp9AmdWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 23 Sep
 2026 22:53:54 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:53:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
Thread-Topic: [RFC PATCH v2 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
Thread-Index: AQHdR3ITSi1I7Rk1vkS/LA8iZTZyhbbczeoA
Date: Wed, 23 Sep 2026 22:53:54 +0000
Message-ID: <d5e465045c9eaf6b0e7636a33e8a77362413e72c.camel@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
	 <20260918132946.76533-9-chao.gao@intel.com>
In-Reply-To: <20260918132946.76533-9-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: 61a5c8b3-10a3-481a-25ad-08df19c58b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003|38070700021|3023799007;
x-microsoft-antispam-message-info: AXj+f7FQ/1vy8LR6GA4Ta5GjC0Ws1KFEMc1D6qolwMei4mVEAKYP5GbtUWSF4tGPQwcumhZ6eotyGFyU7rLUxtVXB5FvwybUjy0wuSEblGfEBukMqeLTFi5xHQjjIulqX1PAbH+tT8w3dE/BnuVPKulwPL5VGV3Dx/h7nYAP6NKdWNHCws1rSQ7kU5/dFq3VXygDWe+nNFJd91IOrspDQ4oeZXNxsudUtpWfCPEny8lxeFWWWWxbh6optO4PAkgnqRzYqc9HHEd2V/Yq0Ato7r+UWTEg8ETGllBlkNLeDBKXLczl8g71HBK9LjsL1ZczdMJ+Y0bo10u7ftY24I7a/SWvg770YTDt0T1Cz6LawFu3vjcIErqzEkrNLJbbIZk1BI3+NsrBfoUfVgkIDoJ2f0qEPtVzb9pSXolkac0jpXnt3QJoM16gy8nzrXT/xKpaq03NQJAUn2/X0SgywW/rN4Yz1EAvywx5rwKIJCQreT5AO71aH9t0WWtL24zNxRVTcOaJ8vfGOrSoGUXw6xsFQWvDEtO32+VatnIXxlvB5FxSVKwu2DqmdgqugooeonDVxrnLP+jkwm3jzxqdOR1i80OaeHpsVLLbkKJNh1vwWHnB7BbCXkvC7CrAzZ/OEIbE3ElT425eJWMDHGG9uVx8ThcagZUFlW8LoMOxp0jg51st1Zw/hPruoT8tYKvZs/yPDdb7AZdNb8sOIS1+2QjC7cg/EatkDBoWv7DKIkT11sM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(38070700021)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm9CdnpvekVlN25zQ3gvZ1VaOVRWeUx0cVhEVC93TExRVnVPaytBNjdhQ0Nj?=
 =?utf-8?B?MFlMTGhPN3BjNzFZeTE4RjhjS3ZkV0xtUGRPbHVQZ0pFNVRta2FBc21WWFhy?=
 =?utf-8?B?TjhxeUhkdHBhSi9JN2dpZDZjQk92UTRBSmY1QWxOQWFQYzlpcitqYmp0RStH?=
 =?utf-8?B?bXJWb2ZGWjVjU3BkdkcySGt0Sm9zSzExZW4xZ3hUdDRtOXRCdkdaWGRSWldh?=
 =?utf-8?B?L1piejBzcVRMMVZoWStvMStRTHlQSjRpUXR5VW1uMDdBQmFHVEhoWVJZNkNa?=
 =?utf-8?B?N29EUTk4R3ZlS0pnVGhiZFNqeWxhbFB6cTR3WWJFRGIzWlI5YWw4RXllS1Rn?=
 =?utf-8?B?RTErWmhHMVVwU3c3aEZScGI5dW1iMitMZ083R1lXVlNhVzBjRE00ditwdlpO?=
 =?utf-8?B?cHBYTVBPZFNXSGp4bTVVRjlKQ2ljMVdTUmJiaW1VUGhBV29aVExjdUhaT0Zt?=
 =?utf-8?B?SjR2U3N0RStPT0oyWklRdWRhbEZJS0x4aUl2aVJRd1lsdHVmaUVndUcwWnl5?=
 =?utf-8?B?VE1nSjlnYUt4RjIzZktUb0NpRzh0T1RYZEpwNFZOQlN4QzgyM25ZQUhIcGhE?=
 =?utf-8?B?K0Vya1YyL1JFVTFWUVdEb3N1dm5EUkpCaUZtOVlaNXlrbmhkSEVqVEVrVjBM?=
 =?utf-8?B?Y3J2RXk0RkI5eUtGUktnSmpIQ1lTdGFCcDJZbHUrMkFlYU5NaExNajU2VEtH?=
 =?utf-8?B?VllBUzBXSXdkUGtoRTN2anhNWGVVeC9Ea3gyTkk2OHUvbGZHMyt0eksxS1o0?=
 =?utf-8?B?T0ZhZExEcWFBYk9BMjlVRGRHMXEwcGNUQW9QU1dQbE1OM3JRNW5ueWgxUTBu?=
 =?utf-8?B?NG90NnpYQVJSMTV5UW8vTUx6Q1lsRlQxSUJ4VVFPUVhiYVZLaFd2dHVZcHEr?=
 =?utf-8?B?dzczd2dZTmg5N0JYdU5jSjFNZ0pjQUFmS0M2cStIVG5uUXBBTG9ydVBoTC8z?=
 =?utf-8?B?SitZNFJiOVNZd0lUcUUwNjBabmkvQXA2ZTZ0SjY0TVNKWFNTT08yQlVaajFP?=
 =?utf-8?B?RDV4VFpKSEJ3M2RPWTJWSWVJNUhqUWpocGhRcUhwS1lLUlJYcytUT3B2RVJr?=
 =?utf-8?B?V0h1VmR4RW1VY3I0Z2xLRjJ0MXBQZjJoRkFQb3lLMHJvbVJ0MFlxUXcwS3c3?=
 =?utf-8?B?OStpVGV5a0xaY2laOGlRY0RURm9RK0JzRFpZTmtTWnY5cTgzRlBKSS85VFBF?=
 =?utf-8?B?ODhFNEhnZFpERkJoTE8vL3pNMEtKRXA1ZSs0a0FoemdtZk1DK0k0T242am9v?=
 =?utf-8?B?Q1JlN0YvVVNyTFVRMzhYcXJsVW5wbmttZ2pzclBncXFxWEdsOFMrYTdJSHQy?=
 =?utf-8?B?TWlaUXYzNUVRMDd5WjNzZWo2L1c5Ym40dlhzWlovQ09tY0RRakw5TDVKKzRW?=
 =?utf-8?B?T2RYd3o4akhON1lKYk1jOGZFZUJyZG1KWXczWnZGWCswTlBTYTVabmJRcnZS?=
 =?utf-8?B?N2pDWFM1R2RpanZaeUlvSU9xRjNTT05HVzg1U3VoSGNZSG03ZldJMm12MHV4?=
 =?utf-8?B?dkhWYjFMSVM3UHJ4MHNrZWxYY2hmc0F6emFkOUk4ZEVwTXh5c0xmbUVDMUFa?=
 =?utf-8?B?dWFwcmprTThMOFVuUHBqQnVhRWdYaTBuNkpDKy84a2VWaWdHbDFqOE9NbXVU?=
 =?utf-8?B?SHNuYmtZekNyNFRIOHRJVDUrT29QNklaendrWk9uZjhaakRzTytDc0lqR3pi?=
 =?utf-8?B?bWQvWDNuY0pNMkJEdk4wR0dublhaSFdIY1piU0Rtd0d5a2pnMWppUFRCZDVV?=
 =?utf-8?B?a04xQ0xZbHl4cVFwdnY0WHVEU0hPbU9kK2Z2U1laYlVzNXYwSmVFNHZoSFRu?=
 =?utf-8?B?ZmhrNHhpdVBMRXE5SS9EV3NrcFpsQ2ZvbzZ2SXFURTA1eGJHUk54SEthVVVa?=
 =?utf-8?B?d2VpOXJiZXpocys0cDdpaVdEUDFqQUFRa2NHN0xYSzR1SllsSWN1MWR2dzdR?=
 =?utf-8?B?emtURi9ZUHNjRUhlLzNUVERiOXZER2taa0d0VmwwZlBuTFRRZVNiVm1jYmM0?=
 =?utf-8?B?MFBvVFh6T2p0b2hCS1kyaTNDOGpTMmtMTHBKY2JubDFyYkswYytGZTZqai9x?=
 =?utf-8?B?Qis0UGFKZEh0QVM5bzB5OGw1SGtZRXpsREFFSGVQVngxUEM0dE1kcXNrUTlC?=
 =?utf-8?B?cnJQUUFzYmdSb3NuelErTUJKUnVFMXg1UHhadHNuL3hIQ2VpdDVrdUdCQ0Jn?=
 =?utf-8?B?czEwVEt3M0U5L0NSNy9JWFNlcFRkb0YxaW5leXJMQW9sWmw4UGVFWUZxN20w?=
 =?utf-8?B?V2V6emVXRVBXQ291MktCc09EL3pPWUtHTDFINzZNbERnUEtlRVI2M0l0WFh6?=
 =?utf-8?B?dWNaMmE2anJyT0tMWkZUV1BlUnBWYUtCMGdQVWthZmd2MkpDQ29TdmlCWlVa?=
 =?utf-8?Q?OXMjijmbfQJwUjIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8DA8545C577114CB7BAE65D49A3E32D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zq3wlAaPbE0mDiA8A3tc7okC29GqE3FuobqPOKpBKHnB/n9cymlgt8bfSqqCmS6dZHvSL6uGDuO9m0+lmEVhBs9sguKaWdQuWRjUZwi32jrnt6MlkYqF5HkPSP5mKq+y5hQv74x5LDCx9Jq8bRHSUf+A0i7XNRJKWTKpwaB4gIwOPnxS5me+jPMFxqIYX2wjVFiKDrDTcvPYsuWor0PmIQHc4hD9LVpYu6abY2r2B17Yosdl1SIvcg94XcAB1Lk8h7hR1u++k1PYC0e8iwiRqVbDtEoL79zJR3NLuCmsAwjWA1mTlqSM0/IPH7FSVSbii73x5jEQCR2B2+rgZSbprw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a5c8b3-10a3-481a-25ad-08df19c58b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 22:53:54.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfHLLj3UIp5MFiUhPZbKsnD97cA88KwJ5rGzJvmFNix4H0WAYqRSFQ5t/BPo3EF5bkntRMxrL3+cBtfLpNlS7S5kkjNT5gSNZIiSItswjWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gdGR4
X2dsb2JhbF9tZXRhZGF0YS5jIGhlbGQgdGhlIHNjcmlwdC1nZW5lcmF0ZWQgbWV0YWRhdGEgcmVh
ZGVycywNCj4gZGVsaWJlcmF0ZWx5IGtlcHQgaW4gdGhlaXIgb3duIGZpbGUgc28gdGhhdCBnZW5l
cmF0ZWQgY29kZSBzdGF5ZWQgc2VwYXJhdGUNCj4gZnJvbSBoYW5kLXdyaXR0ZW4gY29kZS4gSXQg
Y2Fubm90IGJlIGNvbXBpbGVkIG9uIGl0cyBvd24gYmVjYXVzZSBpdCBsYWNrcw0KPiB0aGUgbG93
LWxldmVsIFNFQU1DQUxMIHdyYXBwZXJzLCBzbyB0ZHguYyAjaW5jbHVkZXMgaXQgZGlyZWN0bHku
DQo+IA0KPiBJbmNsdWRpbmcgb25lIEMgZmlsZSBpbnRvIGFub3RoZXIgaXMgdW51c3VhbCwgYW5k
IG5vdyB0aGF0IHRoZSByZWFkZXJzIGFyZQ0KPiBtYWludGFpbmVkIGJ5IGhhbmQgdGhlcmUgaXMg
bm90aGluZyBsZWZ0IHRvIGlzb2xhdGUuIGdldF90ZHhfc3lzX2luZm8oKSBpcw0KPiB0aGUgb25s
eSBmdW5jdGlvbiBzdGlsbCBpbiB0aGUgZmlsZS4NCj4gDQo+IE1vdmUgZ2V0X3RkeF9zeXNfaW5m
bygpIHZlcmJhdGltIGludG8gdGR4LmMgYW5kIGRlbGV0ZQ0KPiB0ZHhfZ2xvYmFsX21ldGFkYXRh
LmMgYWxvbmcgd2l0aCBpdHMgI2luY2x1ZGUuDQo+IA0KPiBBSSB3YXMgdXNlZCB1bmRlciBzdXBl
cnZpc2lvbiB0byByZXZpZXcgY29kZSBhbmQgd29ya3Nob3AgbG9ncy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBSaWNr
IEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
