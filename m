Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2D199FAB;
	Thu, 27 Aug 2026 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797965; cv=fail; b=ZOtoZJc2mqU4UrjeFOEMDXjoxiuQBanWlhG2nUoDmAItjRoXKXE1gWz6GR7DRpcuqto9WTSHO8MOhvhMNr9XLrhQX+gCS92JyZUbnnRYkzWj2qBFy4QSP9g0hjDiInDH6HDEdkDhwZUVLU3mhzs89bP/0xTTmzSwUcJZZja91bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797965; c=relaxed/simple;
	bh=we9mSpYC6twB/MbCj/dpw1q7J2gmk9Pi0B84hqEeohg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttaPLg2QhQOHQ4GGunte/ZYKtsbfVSJWqmATPL/V85Jd4b36hTu6gI7AEBj1N1f7QH3hciBKVjtP40c1CEfHEobq0RX2FU/4VAIp1GkkMMRS/wwbnPjDl7FMhxlf/kuD2SeXQOFksTrkBQ0ZR6Ho7L0cCXPtsLd5eSEX/+x8hDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsFhnx6P; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsFhnx6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787797963; x=1819333963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=we9mSpYC6twB/MbCj/dpw1q7J2gmk9Pi0B84hqEeohg=;
  b=EsFhnx6PdC5v1EBo0S0zAPYm4lTyj4snpRcGE8I6feaTHVVScDEcWHDT
   RtYP4ifC9QOblPYm7Ye8bc4EWX//FkOR9ti/2Bh9qcQNluwdmhkQlf+FY
   3P3IRMdaxIaPUXw2Tgmqh+VjX0vVniqzTsytSwboqBwlT1L26B8i4KdvY
   F2xNFyGY1lbbdKV1/Wi77F/jiIBM1jT+0g7yRTdD8trmgzUcnvWL+ZIxs
   RfR70oNfqPHqrx9P1Tn3DbpHZYkDoB8QXK47D34aarNBI1b/pj304gM/B
   Vga2u+DgQpS79ysxrexjl2ZIZuXwHuKFmMIstQbc76vpW7LZGuSnHK/kE
   w==;
X-CSE-ConnectionGUID: TAPeAO1WRo+yBeaVwX+bzQ==
X-CSE-MsgGUID: QmcHfn07TwS94dVGuBAfBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="91978098"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="91978098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:32:42 -0700
X-CSE-ConnectionGUID: GLAnq2K6RlKridNQWWvb6g==
X-CSE-MsgGUID: 22wL5VaISWmGvnPeKMZdGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="263978778"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:32:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 19:32:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 19:32:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 19:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZaEo6fxGcP/W5oDdjklFZuYyic9BG2toKRx/kSEox6ptRVr5pgPKoBZv049TLDqrs4ivH9fBpbIwLKZ7lrAGd87jBL7qKG8CDIm3oWvoZAV7BgorCK5gqrgR5T9imcAeRJ1Rbl6hAGbPNp5p0fCXqJmlgbzuFLybpDiPxfIuujotsWuokHVgsgrOq6qn/z3MsfIylSZh3Rx8V1Vdbeu6DLYjUUOf2MUjna3rpKIcw5bZw2VjAGLcLPb7dqquhZUrMMkXgQugsBOIdidSSyOeFXoNPuxOqvhVXyJ3vOXRklPDtkdpLHUiuhit9YHDKZQ0aJF4Kj+ImQcjTy+iB3IgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we9mSpYC6twB/MbCj/dpw1q7J2gmk9Pi0B84hqEeohg=;
 b=ggNWF1NYHhEWT3ZC5J82NV7DCEUhJXBrjyUDIdUVqefOjw+vnzYBGfdlSGFeFsgVP/bhQWTJZ6+UqkVXDwCqnzo8p/BQooM6l5cJrpt5iJ0fXAb9fMlkxzZ6sLQNAOh3MDvZA1uoaSRkV8N/mLk4kF3F2Ti2V9iSTTukglPSlAF34/9rhgbUyTHJa6sawM0p80fXF40BjXLbTfB5XFAGbxVNazI9Wik/mUsH8fW+fq5QxdGyibb1WuIwaM6RW7F2eHIavniqzQ+4YZDswFs7tVolCSK1BoWaWvBsfou571qFv+0gTr9tzHdcWzFSXZaoBDPCspev9Gp9kw+U3ADGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 02:32:32 +0000
Received: from BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de]) by BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:32:32 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 3/8] KVM: VMX: Disallowing using to_vmx() in common VT
 code
Thread-Topic: [PATCH v2 3/8] KVM: VMX: Disallowing using to_vmx() in common VT
 code
Thread-Index: AQHdNX43WolXk57rVEq2WT3RI0BYSLaxLZwA
Date: Thu, 27 Aug 2026 02:32:32 +0000
Message-ID: <bce0ed51854d9d404023543baf23b89f4327e198.camel@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
	 <20260826171246.777729-4-seanjc@google.com>
In-Reply-To: <20260826171246.777729-4-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5302:EE_|PH0PR11MB4983:EE_
x-ms-office365-filtering-correlation-id: bbb67578-8afb-4996-b573-08df03e3729e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: VQYuBdKo0SwgVKXc6RVSbk/2mgIoCh7ADWNYQA+uPHGk7b+vxsZXWJP0RfpzZpqNt0wlxFkXkrLtnXhJG5CVDof/KX441jf5EN+cpHS+T4QjBngbSzZ4nN1DudfIdphCyg1g/cAu8yZ+dJn+KVf68o8M0eXgKIj9fTwzgt0I5U7IkNgXUAWsoVkqWHiC/0Fg2WIHqtkjJHJ7xs83UxO3Vh6fSmOUOIc6yFguoDGQzWWB7JGSV7VJtiQ9mSxBm02+oSSmp5O9C+38MkeiWF7i4f6UzOTvhG3fFVlKG66iiPs8rtDPd3I7u7+AuvOI+f5d2JO6mp0Y2GhRe9AR8M7IFNjCB9Do2YBxyx6I3/jWjC6lvriXQg7RNZgbcuu6xIfxdNHblazGvX2t3ivQh+HVOFjoZqLUXnm7djs/oZxS6IsRbygZ1JhXJev6u1tREHnY6SctrddS9TiNWjjHPWyEumqjXiyxhVoSg+/6kGfunMO/6QJ8pBB7F0kNJpwjtuMnMcgUpGi7WPgCzB3dpLESk5YKyIyvuQ+/gZVUxGueElH2nDfGiHw+z+yTj0fZ40Dg2HkHu5rJ2Tk4TUtsrsAgMP13QudClrj8DrORxbAt442LaKiUMqRSxqzjqhSC6ji8z+I2b770YXN9Ywc2mpcuLZrwW7SmVRx13hdh7clfuAECFBBSxYEalqiJRGCHVnOsg1/D2HEM/6cSTcjTR5ioII+HbcNDhPz+sOYjTE4/yrs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5302.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnBVSlhMTkhNdUFMNTBZMmNGdDlnRlpVSGVUWFozUGtQZGpnOWtBRFVzZ05z?=
 =?utf-8?B?dFRGVjdkRFBWR1hUMHlnU0gzS2JsWEc0ZFgwZ0tScGp3c1pPdXNwckNEMjhR?=
 =?utf-8?B?N1FzTjFNQWVPWlFhTnc3Yi9HVUY3aUlzSk1Zbk1DdkM2TnZLZ2NaSkEveTJ6?=
 =?utf-8?B?cHZmaFI0Rjd2MENHbTdQbVpRK2ZMelFsYnZWVTJROFZMSFFUMGtxYk53QTg5?=
 =?utf-8?B?R2VQK0laSjkvS1JGN0tYUUQwWnZUNjJYWThpWW1XaUV4MktkUXlZT053OHVq?=
 =?utf-8?B?dUlMY0pkTk9zZ0ZhQUNzT2t4Nk5ieExsNHlBWG5FcE93clU3TFBoZnFtS2VT?=
 =?utf-8?B?Yk5UNFhabEtKbC9oWlZ2bHcyWFFaV2Rhb0srbXM0RlBLVzZJTFN3bGNKWkpB?=
 =?utf-8?B?Q3c2a0VBTjlPdmI1U2ZwbWo2cHUzOE0yZU5ndzlMWmd4UDRtaW82R0F6M3Nz?=
 =?utf-8?B?MERjTkNPN0FIUUtqbGgzbzJUWWFwb2F3ZGIxVHp0bFpNSTFsWmJsQzJjdEVi?=
 =?utf-8?B?WVc0SmltNzlLWW1IVGR3bEFHZ1NWNXBZY1lPN3RibjdnN2V2b1h6b2VSQUQ1?=
 =?utf-8?B?OVVJQ3RHK2xib1FKRjVtaDgyQlFOTC9wS3B1SisrQXczQXJyTU5TaEpKa3Zz?=
 =?utf-8?B?SEdYeWRDaEo4NGNJZ2VUT3FsZXV5RWpVZ0hmMG10dUdwT0dtWUNKUDdFdyto?=
 =?utf-8?B?eGt4NjJBcWJET3lXN0liamJ3Vk83Z25MQld1cG5FM001NzRaWGsycWdCK245?=
 =?utf-8?B?M3psYTZUbkVwUU9lNktISHpGY3Vic1FTYkoxcDFMUmNWYkp4ZWwyS1J0V3Vw?=
 =?utf-8?B?Ty8zZldrWXRwNTBac20yVlNQR2orWkNNUHUva1dTUm1UMTlhVXpnYlNRSjM3?=
 =?utf-8?B?aEpKYmtoRXFyK2gwOVJnc2dNbnUwaFYvNW1nUXFUSmxaZE5MdkZzYWpNNDdS?=
 =?utf-8?B?VnVsOXRuOEtXbmhhYWcwYzNZUlplR0U3bHdHeDkycWpzOXJzUEE1Mkl6ZmFV?=
 =?utf-8?B?emtDTWtaS240VTBoVlNLNEdEMUxyd21mNUl1MDFNUzdZbFJnd0JCMDFJT3Jr?=
 =?utf-8?B?UUdFNERFd0dJZzZJTFdsa2VkOHczczhzYkVrQkpZQ0U5NFIrdWJjQll5dSto?=
 =?utf-8?B?WXVZQUVOSjdhb09wWW5ZeWhKZVVmTjRyMEdlenRqTm1pUUxmeVNpUTNObGtk?=
 =?utf-8?B?ZTJhbmpmcXBqeHdXVnQ0VDVpbkQwODZxZWV3ZzlpODhNR2Njb2RMT001RUhN?=
 =?utf-8?B?NmpmcFpBcFZMcXorOVUyaXRmWm9Ha25neDNUMXVwTWVuNS9vcllTdHdRcjJ5?=
 =?utf-8?B?dXc3RGVGaVVxY3VwVDYwRjdHQXg2enp1T0VWbGZ0UEVXaFhCMlJ5Qnl4MFov?=
 =?utf-8?B?UGU2dWpEaWlGeVZGQWlkUWdmQzRCc0ZMaEJOaWRReitTUEMrMmhjb3JJTExJ?=
 =?utf-8?B?T3dJK1h6ZTNJN2EySDlRWm5YdjR2RVVWYVpJQlQ5cjFsaHpPZmFTR2gvL2h1?=
 =?utf-8?B?Q1IxbkN4VEt3cGhrMHVpVEQveVM2bnN6eUxOMkR6UGdYenJuYVVsZnAybFo2?=
 =?utf-8?B?Y2wwbnNTRDJyOUpHVkZxM3VEVi9EdUl4MDAvWFFvRi9hMEtTemwySjkzUzNm?=
 =?utf-8?B?RWxnaXNCN0IvYlNRb05RZEVlbHFwcS90OHdDSWRRUmoybFgyTXJHTHZlQVJ3?=
 =?utf-8?B?Sy9yWndxSHN5b2ZRNFNvdWthRnlHOXhPYjFSeERJOUVDU000NWJzMGZFSmZG?=
 =?utf-8?B?dEwwSXJvK1B0N093clYwZi9qOWwzcUJTcnFjR1FxcEdWMDJhL05nRG9OSkxz?=
 =?utf-8?B?eFdaYkVCQW1pNGV4QWJrL0k4OVFDTFM5cWdOYWJZekZiU3VwejJ6QkU0SmM1?=
 =?utf-8?B?WlZoRTYwMjM4emNCbVN6bUJESUM2Rlcybms0UXhOcVc0amtYNmR1TUlyYlRt?=
 =?utf-8?B?aGlmekpQM25kTkkyWUdTUjhCVnlxZHZpY2Z3S0QvSFppMzR1blhiQVFKQTlt?=
 =?utf-8?B?d3RzV0ZYU21GdGpKejBWalByajRabjZQZDROd0lJK0dIRDBFNTJiSW80d01C?=
 =?utf-8?B?RTk2dnhneGtlMDV6Mld5SWczOUM1T3ZXZjdCMXBMaDBvRmxFSXJOZGRuNVdv?=
 =?utf-8?B?UXNLQUNiZzFkMEFOd1RVWFN1bE9NTGxaY255VlAwbWxzekFTd0JvL29nZDhu?=
 =?utf-8?B?czExTU9QM25ObW5zMUUrYWdDdktaa2VtWUkrc0xHOG1xMDRsODFJemdkVno2?=
 =?utf-8?B?QXNxUjBxQVA3b1AxYi9MY1dsVCtYY2U0ZFplMlR6STI2VXN6WlloUzZsSXMy?=
 =?utf-8?B?eGtGWkZoSTAwbnU3WDZtUFpEWXpnN01vRkZGSmhUNCtULy9VTXJDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC0414F2611E6C46B4385540145EA6B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ypS7dgaswcG0MsOf+LSQlN8QYdtHgjou8PE/83WxMIQC1N+b7VKTwzG771ifQQc0aWAZ+uILAlRYglY6f/2wtZA3GYnAq+BjoUYRPU3i4o/Je9RkzBHLNBlSGz65FqQyVDug3X/AwFHreejRwjQwoM3qrTOc/tNTiNx1vm+M0jUC6UuM8cZichW1Pt9vlzJ32JASBFCsgpn0JR+FMSkh9vtniu/mOa00y3hw6DCtHne8DCO20Mhzvjty5fAYyUc8EpMDR06VFOJtOAthHUjl9Q+TIn/knvwdNmjXhm4fovVUCvVcCVjWib9pVL1BSJlFmFqop+60r1yl7v2mqTATIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb67578-8afb-4996-b573-08df03e3729e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:32:32.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThWmen69VXWPuJoYZTeZQ4oR5ZnPupBr+WDVWZi/sRhPI860a7tfxwHz8pByefYtiQNyiq9l/Rd6t0SrO8siRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDEwOjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBQb2lzb24gdG9fdm14KCkgaW4gbWFpbi5jIGFuZCBwb3N0ZWRfaW50ci5jIHNvIHRo
YXQgYXR0ZW1wdGluZyB0byBpbnRlcnByZXQNCj4gdGhlIHZDUFUgYXMgYSBWTVggdkNQVSB3aWxs
IGZhaWwgYXQgY29tcGlsZSB0aW1lLCBhcyBvcHBvc2VkIHRvIGZhaWxpbmcgYXQNCj4gcnVudGlt
ZSwgb3Igd29yc2UgY29ycnVwdGluZyBzdGF0ZSB3aXRob3V0IG91dHJpZ2h0IGZhaWxpbmcuDQo+
IA0KPiBOb3RlLCB0b190ZHgoKSBpcyBidXJpZWQgaW4gdGR4LmMsIGkuZS4gaXNuJ3QgYnJvYWRs
eSByZWFjaGFibGUsIGFuZCBzbw0KPiBkb2Vzbid0IG5lZWQgdGhlIHNhbWUgdHJlYXRtZW50IGFz
IHRvX3ZteCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+DQo+IA0KDQpOaXQ6IGFzIEJpbmJpbiBtZW50aW9uZWQgaW4gdjE6DQoN
CiJEaXNhbGxvd2luZyIgLT4gIkRpc2FsbG93IiBpbiBzaG9ydC1sb2cuDQo=
