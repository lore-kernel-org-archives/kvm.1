Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFC36C0CB;
	Thu,  2 Apr 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153918; cv=fail; b=OvE2VHg3kZPdf4cpl9MBkhRWTOBrcZYU2zdYUuI5A8Se7/SB9SHHs/JuD4+EcygkUrsZlQCIZF8z5t7JKtiqDslJpFvSnGhZnpxyy4bHNU0Dbm5DELKJaS96EbxmoASSsgjimayzfk9MagZubLHtKXYy5wiRrtEG8tYNkdKk3iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153918; c=relaxed/simple;
	bh=WHfmw3BNXoP9b21Q6Psa8yTAH18sOF0XR9Ca0/htjd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ri53c05nCXzL4ydVZO6OA6CEu4hFxEYhrN4LKBYuSzWil2TvkF7jiVOfxeLQGHWRg0EpOPWOfSOTBihBw3yBQ/TUiqAEXAOmirk5IruVW6fl87w/Ux3MPx0e9QCNk6m7/FGWOZb0oveKRviUadasDQH618jdLYnolLJGuFfnTYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qnol8cjn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qnol8cjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775153917; x=1806689917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WHfmw3BNXoP9b21Q6Psa8yTAH18sOF0XR9Ca0/htjd4=;
  b=Qnol8cjnZWm2JQc8+SdBXgnpSciDBCoJK0Dt1aXgPWU60l2qlxIfdBwe
   KWKmK0QpqHSTzj08LtpIZwo3iPbLxmgtiFnkNUKsfh/3qzI8c+57fJ+S5
   Oh3FySP+hQim2B4N9PeNdJpt5QKtCYGJk8//kYDkFYlt9BYPsQVSQMukQ
   nZNLXAhNHeISDK9mBENcK6x3KbJCVesV2iCVVrxKIwyoHyJjdc9qlcUG0
   wQ69pDdon9CUg0z/nfGUsyNWhxvYptsggWt81z8qel/HGMY1TTHRwxfog
   IR/EU6xnZVvqw0qh506fhydhuFfkyzrpWPzUOEYEo/ngM06gcOnh7eP5x
   Q==;
X-CSE-ConnectionGUID: NM8h8FWGTJyHRQFE9+OT/g==
X-CSE-MsgGUID: DhNT8dDxRDeyyAuDbkAmlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="98834214"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="98834214"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 11:18:36 -0700
X-CSE-ConnectionGUID: ZwnLCNFkS5WBe7TraP21/A==
X-CSE-MsgGUID: 1Yp4QrXNQ22ea7j5PTV7/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226218945"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 11:18:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 11:18:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 11:18:35 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 11:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp4BuqcFsmKDPr1QuPzIuF89LsH4e0aJ4UKu4W0nR2I6qf4Wg7qpmGghb58ZxjwgHIV8njx4I1bbfZOGfoYau5x3yCCHuQYtu/NmvBYqkQQMmweYLcimqatD14Qq9Ih0OP6sJ1MkUl5JUr2OumCo6Kna+a+9gvLBsitzg8pfyv3o4Lol+XI+OHkH7SWFUKseO6kMDrY66wHlEBo5GYYFglfYTkar9gdNQHCi7XlPaJbeTGL096o6NnqAy4wGLvNTXADAlj8l0rLuL72LMLPT/SqhdHFr4uwPD0t2zA1kF/qnfYPlESnAEgnVJD2OoHRkxjKQQRvVOzUPKsUIS+rB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHfmw3BNXoP9b21Q6Psa8yTAH18sOF0XR9Ca0/htjd4=;
 b=OEic8n5nnkT19l82+DicSj8ALG8eils6th1fYY2E4lJ7MWt9OzlJeqxS58tesPeQU7tvNH1lp/1fJY4WTNEi5qWqC451WfcjhOsL/EqcwBFtdTzllxJZBxbMJ0srVNpn3h1uzT4dgyRXelrtCtcUeQQ7Fazr8Tiwi6Vl3EdhoXjf2y8Q8jl1WIIMDaNtMbcSDQUWzJdu3RqcxYECehMptR+fOBoXg4cBRMAMfUfPOO6YsdHkpDImhJMDF18F8sX11cQYhXFnKO5ZLRPDbyYLhz4zyZ9UyF/UxfsHGC28Hh+Gy7HHnvk4gRowrhG0NjqdDMzJgGU89Ry5qysjLJ+51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 18:18:27 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 18:18:27 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] x86/tdx: Move TDX architectural error codes into
 <asm/shared/tdx_errno.h>
Thread-Topic: [PATCH v3 1/5] x86/tdx: Move TDX architectural error codes into
 <asm/shared/tdx_errno.h>
Thread-Index: AQHcwmp41vhQvBowXU+f9iNVAjErZLXMDL0AgAAIoAA=
Date: Thu, 2 Apr 2026 18:18:27 +0000
Message-ID: <c11a77a9b7b7f956e16468188ea3e9850b66935f.camel@intel.com>
References: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
		 <20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com>
	 <ac6rtq-n0JNa_Oc0@google.com>
In-Reply-To: <ac6rtq-n0JNa_Oc0@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ0PR11MB6671:EE_
x-ms-office365-filtering-correlation-id: 3ea605c1-608a-4853-8ffe-08de90e43c8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ngZJ1txXEKfkVWSmHH2Cz/ATYn9D5f53VyBAMKJhfqokkGfGHsLW74hSYmJTcdCxcgg1C/4ZVLs78VE3CgqGBX8ZVxuMbMK6EIXxV80CPg/jEKsPW7iMjmQJrq7WAh8Bi5vlLrckseDcxIXLdRg8nHshlrG2ad/jzC0poyriiUnp6NCsu9CVQkRaigmlO0XuRrw+x7Mm/EmSlFdVYbF5I0G+Zs10lwFEVsYUIGHmewkuJm2g9Vcb3QpwRtPy+3jU2s6x+lc21SH+y/3Pb6J8ghEdFgqUTS2lpAuH6tf20/QhFEM3Eo7aHAoDPWesywtqWDgwfrDV9QfoRmmG0LOZRqVc7FxqW58WkTJCcEe/JHVP+7ve8pORNW1hiFcz+QeL1M18bXopOtMNR6epn9wJTINsRR3WrObTfN2IayHZb0tSj3yLhVn3VSdsPa8nSHxu46orMFg9eRsX0LtOTZ7oTZ2JyRVT/1IPZ/B5962vzWOm9basxo3yjJVR5FP83wqf/5KMln1keFTFfiiZ+7Pkje0M/Ma6GvJWD5E4zwO68+TlrRHaOogVSggi+9xwYneENuMqOkaB/mQOcIb1U5163pER3f51918nBtUvKgr5tMXgMqt/VSx59ydyKX7ke8UlWPKXmcVCLD64ai0QrrlYFLbgxATeRM3r1VKK25f1VqfP5VJ2GiM+UN79w5qM1JT36IZC/eORnE9ikMIPh6JD93qEoKhq2DxYl2KxtSsu6dqWIP5plHYggxlWCitSl0OV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdaZzlSdWxsRG4vUjhDOGZ3U2NhdEwyd1RxanpVbEV1MFg0cXBjZXBGREdt?=
 =?utf-8?B?dG5URXJuN1Y1dmJ3VUZWMTVZT09hNGVBamw4ZUo0YlJla0tYeWViZzdIMzhM?=
 =?utf-8?B?L05QVStpV2dPL2NFQlU2ZUkvUExHMytJa2hyQlkzMHlGOTBxSmFkbGZrL0ly?=
 =?utf-8?B?S2R3cUZVaDUvMjQxdGd4MGpjK3owMVB0TkVaOERYcSthMjQrUjJ0T1YxaWpC?=
 =?utf-8?B?RWZwWkRTZGZPdy9UdWRTK0RTUVlKekpibldCZDYwR3VVbE9idUNERmUzMjQw?=
 =?utf-8?B?cHJCcVF4V1N4WWg3ZFdmUUJqRjU4VUg0cjRFV3dHZ2dwRSs5bFRJcTZLZVU3?=
 =?utf-8?B?N2FVQW9QTjFPSndkTHZKTERBd2R0WDdqU0FGUi81ZWtEM21aNkFmVmx6UGp6?=
 =?utf-8?B?ZmgwZnVvR1MzTTdlaXpTQUFJem1LSG1aS0xxWWdJYlpQaXM1YWl4QlpSaTdD?=
 =?utf-8?B?VDY5eC9IempLd2g2YUlKVkl2SFlBL21SV2ZHM040bmVaRFdqTTBIUERXVGcw?=
 =?utf-8?B?L3BKN25RbTFhLzRTMVJWbXBQMDlLaHQrNUV3dnFpOGk3T1REblZPVEt4S0Uz?=
 =?utf-8?B?TUV6eTZ6UkxKQ1lzN09EdVJLaGYvRVBmVm1jY3JrY3U3Q2tCcXNqY3MwcGtt?=
 =?utf-8?B?MnJjazhvdithY0JKUUpGY1JYQ0JVTVNPM200aEUrZ2czRHhZVW5lbENjd3RT?=
 =?utf-8?B?S3pSQVNVU3RkcndLK1MvZ3BQRzVUb3RiWTdoc1pCL2M3ckNYMnoxbnkzOTBV?=
 =?utf-8?B?N0toQ0VMSms2M0N6OWl2bDJBeHJtaFZrUnhsOEUzM2FTc21TNVJPR2lsU3BB?=
 =?utf-8?B?YjcwVkZJM0ZqMDdweHBhQlRuTUdITEVXenVIclpkRTJPMElPS3BXZ0JGUlpI?=
 =?utf-8?B?bVo3R2wwa3RwKyswT1g5NTc4NG5Nam11VkJzQTB1NDNuNGpUdytaUEdacG5z?=
 =?utf-8?B?K0xFOFl5L3ZDOVZHcjhFWHAzcURyeUNITjMyNjdqcU1BM3FJbFJWMUlER1FM?=
 =?utf-8?B?S0ZoQmViandVUCt1Z2RTbUhBTGlkL1lCSkFiN2dmT1VsUmVZcElOZnpRSlRo?=
 =?utf-8?B?OVFFV045S3NjajhKZzhhaWdkQVdjT2hqNFRUSHRuZFFWclFlQ0lTR1NzUFpL?=
 =?utf-8?B?LytPam1WcFpwZ3hLdnZJTm8yc3BNVlJrTHVicTBrdjFwTjZjOW55cm82QkdF?=
 =?utf-8?B?eW8zWVlvRzJzV1RJSmNiUWVPd0l0bk1YWXJWQk03MkdSNVAwWW5mUWdDQW5Q?=
 =?utf-8?B?Z1Q0c29teTd0bmpFc1l2ejhNRnV2UGJCdkZGVll6V0FnUkthSnRtc082RHg5?=
 =?utf-8?B?cVBDVitiZmRVaCtMeVc5R1l2VStTUUh4WGV4Y0hPWU5WL1dhcEdkMUxuME45?=
 =?utf-8?B?Vy93UGFQMFVTUEJkcjJQYllNZS9SblFSS01jaGk2N2tISkZFbUozSEZXWllG?=
 =?utf-8?B?VWx4WlNzQW9LaEJZbS9DZDlORWkrZy9XcWRleGhUWXNJcm43VGc0ZEZZL0tv?=
 =?utf-8?B?QStSN3Y5TlVZRmRBS2l4TTBxZEdNSFY3MldjREdNQmZJMW9JS3ZuOXVWTitN?=
 =?utf-8?B?a1hNWUYrREFDdFFKc1VQYzlXVFFpa0RWU3poVmwxTTFMOGVubjlldlZhMzVU?=
 =?utf-8?B?clR0cWUxZ1BlREVkQXB6ZC9vUUhMUnBDV2pMUWpucktsMlZJL2ZuU21Ca05v?=
 =?utf-8?B?aDFPVVhVaWhIajVHdUdHdU1USmhTQi8xZmhBRzhKRmRhSzk0N24zS1BWUkVU?=
 =?utf-8?B?WlVlL1BvZWlmd21rc1ZPbWFnbVR5OXA4Q1NrdEEwV3VXbnBwcGdNOSthVEN1?=
 =?utf-8?B?b1pOOHZxRkxEYTcxV2tnV1lhclZ2L3RqektKN2xXZmZ2L29ES2NvVzcwVHZn?=
 =?utf-8?B?ZCtFdGl5OGhHRkZ0bkJrTVdjMWlPZi8vRjZhUjJBR3M1NzBkTWcvZGo5dUxz?=
 =?utf-8?B?bDVLMWc4a0puQVhrOVpUTXZzNkJSa09RZU0ydTNka01VZlhoQ0wwQmU1RGhN?=
 =?utf-8?B?Vzk4Q1c3T29SYWdSSGo1a0hMS3dXdHFnOVJqYnJJMVlrR29UdHNqNG9ROVVI?=
 =?utf-8?B?SGN1blkzRnE2TXA5OG9nQ3JyV2NPaHJzczdxZVRzZXJHOEVEaEdaR0h3YXBM?=
 =?utf-8?B?b3ZwbnM2VlV4RTNXbzhnbzcySTQ3d3EzenZOV3l3WWI0S1c0cUtFeG9hNklQ?=
 =?utf-8?B?RmVHTnJpUitUYjdmdW15U0V1QjlFMU5mLzc2cjRaK0t3RkgxR0g0MDdTQXFs?=
 =?utf-8?B?MEk0U3dPVnVXbG1LOGQvdXpVMnZ6MTZmV0VmV3BSNHlDMTZ4RmZaRU1BZWhS?=
 =?utf-8?B?RnRmZ2I3d1FxSmVGaWlZZ3hYRExUNHhqdW9DYXB2d1JKTXFKTzZrM25FWGJi?=
 =?utf-8?Q?2TS/RfZEoQHhCp+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B69CF6F6D11E44AB17D75309850A0F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KEu12eavxlyRDDwgdqek0jo8qZzTVawN6GCZqgTYU7CFCWCYpSmSNTaJXb/+vE8kKsYliJWMZxNtxJL+gy1NdLtP/+XWHeoiabezGLCqyZ1sNz/ElDE54OLa0mVL1c0Snd8j9f14vZ+wSHB3hmxMaGg1K69Xem3IWtCRuK08rP2QZXL4QonlkQzLzISYs9POdg/gyi+Gg4Y0CK27c2WcM4LuMP3v8oHRdpQZol31CKCTMP3l8wT1LpLNAKPTU76DkMnkS8qNZrVahw0GPg3fyvE0vAekxzlEPn9T/GnJyVnl6T3jzuov0SAjQjhQ9efamZrlbz2c/AdvPavnUtwGKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea605c1-608a-4853-8ffe-08de90e43c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:18:27.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdtzOgrsk0JqTUWE5WVQaaedHkGWSy19Jk58xgS03tx2K3XGdn+sdeK0agpcs8vocONaUNLyYFbSNCIYJZqn9LKMw7pLOi8FjfymmmL5+FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDEwOjQ3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIEFwciAwMiwgMjAyNiwgVmlzaGFsIFZlcm1hIHdyb3RlOg0KPiA+IEZy
b206ICJLaXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29t
Pg0KPiA+IA0KPiA+IFRvZGF5IHRoZXJlIGFyZSB0d28gc2VwYXJhdGUgbG9jYXRpb25zIHdoZXJl
IFREWCBlcnJvciBjb2RlcyBhcmUgZGVmaW5lZDoNCj4gPiANCj4gPiDCoCBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS90ZHguaA0KPiA+IMKgIGFyY2gveDg2L2t2bS92bXgvdGR4X2Vycm5vLmgNCj4gPiAN
Cj4gPiBUaGV5IGhhdmUgc29tZSBvdmVybGFwIHRoYXQgaXMgYWxyZWFkeSBkZWZpbmVkIHNpbWls
YXJseS4gUmVkdWNlIHRoZQ0KPiA+IGR1cGxpY2F0aW9uIGJ5IHVuaWZ5aW5nIHRoZSBhcmNoaXRl
Y3R1cmFsIGVycm9yIGNvZGVzIGF0Og0KPiA+IA0KPiA+IMKgIGFzbS9zaGFyZWQvdGR4X2Vycm5v
LmgNCj4gPiANCj4gPiAuLi5hbmQgdXBkYXRlIHRoZSBoZWFkZXJzIHRoYXQgY29udGFpbmVkIHRo
ZSBkdXBsaWNhdGVkIGRlZmluaXRpb25zIHRvDQo+ID4gaW5jbHVkZSB0aGUgbmV3IHVuaWZpZWQg
aGVhZGVyLg0KPiA+IA0KPiA+ICJhc20vc2hhcmVkIiBpcyB1c2VkIGZvciBzaGFyaW5nIFREWCBj
b2RlIGJldHdlZW4gdGhlIGVhcmx5IGNvbXByZXNzZWQNCj4gPiBjb2RlIGFuZCB0aGUgbm9ybWFs
IGtlcm5lbCBjb2RlLiBXaGlsZSB0aGUgY29tcHJlc3NlZCBjb2RlIGZvciB0aGUgZ3Vlc3QNCj4g
PiBkb2Vzbid0IHVzZSB0aGVzZSBlcnJvciBjb2RlIGhlYWRlciBkZWZpbml0aW9ucyB0b2RheSwg
aXQgZG9lcyBtYWtlIHRoZQ0KPiA+IHR5cGVzIG9mIGNhbGxzIHRoYXQgcmV0dXJuIHRoZSB2YWx1
ZXMgdGhleSBkZWZpbmUuIFNvIHBsYWNlIHRoZSBkZWZpbmVzIGluDQo+ID4gInNoYXJlZCIgbG9j
YXRpb24gc28gdGhhdCBpdCBjYW4sIGJ1dCBsZWF2ZSBzdWNoIGNsZWFudXBzIGZvciBmdXR1cmUN
Cj4gPiBjaGFuZ2VzLg0KPiA+IA0KPiA+IFtSaWNrOiBlbmhhbmNlIGxvZ10NCj4gPiBbVmlzaGFs
OiByZWR1Y2UgdG8gYSBzaW1wbGUgbW92ZSBvZiBhcmNoaXRlY3R1cmFsIGRlZmluZXMgb25seV0N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBs
aW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiANCj4gTml0LCB3aGVuIGNhbGxpbmcgb3V0IG1p
bm9yIGFtZW5kbWVudHMsIElNTyB0aGUgYmx1cmIgaW4gdGhlIHNxdWFyZSBicmFjZXMgc2hvdWxk
DQo+IGJlIGFmdGVyIHRoZSBwcmV2aW91cyBTb0Igc28gdGhhdCB0aGVyZSdzIGEgY2xlYXIsIGNv
bnNpc3RlbnQgY2hhaW4gb2YgaGFuZGxpbmcNCj4gYW5kIG9yZGVyaW5nLsKgIEkuZS4NCj4gDQo+
IMKgIFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxp
bnV4LmludGVsLmNvbT4NCj4gwqAgW1JpY2s6IGVuaGFuY2UgbG9nXQ0KPiDCoCBTaWduZWQtb2Zm
LWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+IMKgIFtW
aXNoYWw6IHJlZHVjZSB0byBhIHNpbXBsZSBtb3ZlIG9mIGFyY2hpdGVjdHVyYWwgZGVmaW5lcyBv
bmx5XQ0KPiDCoCBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGlu
dGVsLmNvbT4NCj4gDQo+IFRoYXQgbWFrZXMgaXQgY2xlYXIgdGhlIEtpcmlsbCBzaWduZWQgb2Zm
IG9uIHNvbWV0aGluZywgdGhlbiBSaWNrIHR3ZWFrZWQgdGhlDQo+IGNoYW5nZWxvZyBhbmQgc2ln
bmVkIG9mZiBvbiBfdGhhdF8sIGFuZCBWaXNoYWwgY2FtZSBhbG9uZyBhbmQgc2ltcGxpZmllZCB0
aGUNCj4gcGF0aC4NCj4gDQpUaGF0IGlzIGluZGVlZCB3aGF0IEknbSB1c2VkIHRvIHNlZWluZy9k
b2luZyBhcyB3ZWxsLCBJIGNoYW5nZWQgaXQgdG8NCnRoaXMgc3R5bGUgYWZ0ZXIgcmUtcmVhZGlu
ZyB0aGUgdGFnIG9yZGVyaW5nIGd1aWRlbGluZXMgaW4gbWFpbnRhaW5lci0NCnRpcC5yc3Q6DQoN
Cmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRhaW5lci10aXAuaHRtbCNvcmRl
cmluZy1vZi1jb21taXQtdGFncw0KDQogICBJZiB0aGUgaGFuZGxlciBtYWRlIG1vZGlmaWNhdGlv
bnMgdG8gdGhlIHBhdGNoIG9yIHRoZSBjaGFuZ2Vsb2csDQogICB0aGVuIHRoaXMgc2hvdWxkIGJl
IG1lbnRpb25lZCBhZnRlciB0aGUgY2hhbmdlbG9nIHRleHQgYW5kIGFib3ZlIGFsbA0KICAgY29t
bWl0IHRhZ3MgaW4gdGhlIGZvbGxvd2luZyBmb3JtYXQ6DQogICANCiAgIC4uLiBjaGFuZ2Vsb2cg
dGV4dCBlbmRzLg0KICAgDQogICBbIGhhbmRsZXI6IFJlcGxhY2VkIGZvbyBieSBiYXIgYW5kIHVw
ZGF0ZWQgY2hhbmdlbG9nIF0NCiAgIA0KICAgRmlyc3QtdGFnOiAuLi4uLg0KICAgDQpBbHRob3Vn
aCBub3cgSSBzZWUgSSBzY3Jld2VkIGV2ZW4gdGhhdCB1cCBzbGlnaHRseSAtIGl0IGNhbGxzIGZv
ciBhIGJsYW5rDQpsaW5lIGFmdGVyIHRoZSBbIC4uLiBdIG5vdGVzLg0K
