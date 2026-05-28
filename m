Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8D13DDA4;
	Thu, 28 May 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003939; cv=fail; b=pGICxJYGJNEHU1lSHZwuESMFhB4Kw/pP5UN43PvxqkCQr/5pD2kV/nsAgySCdRFbcR2ARcbiq4XGH4DXphy410JkQVTeiHA/Kx8AQvlogGWTvQggsDW76KNX50/I1Bk7pYjjzRBUm+HirEdXGMxL1nVdIKyx2b83+LVeBXloMXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003939; c=relaxed/simple;
	bh=MuXs41Rg8AH4H0NNHLw7CjQVoBz9bVwaGXgyQBIg5MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujaGq1c4im3BEOkxtHPOhinOjfxe2rs1xU9bDF1GmeKmaOSZCukt9Ii1Oj9Mxvt+lNJRWq1RECgUGanlItHhDfSExrwtbqsMvbqB86wlu6crxpvTgBkNtLhpvHqnXWkKo5x2mOo3qbLr+2kokSHbe/3Z/9zUXh19qgBBT+SPH/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRbdtW3p; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRbdtW3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780003938; x=1811539938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MuXs41Rg8AH4H0NNHLw7CjQVoBz9bVwaGXgyQBIg5MU=;
  b=JRbdtW3pLkyv85FATqfpsecyxXMtP4a+3DEdNQSzz8u5mpwEh1X+/KZS
   dXELkfS/8Y/gE6La46ON/xopTS8K9xlV04yQ6ITWP9S6w58O+Xix/RZg9
   LtLydm6fxNz6HBVkmkSH/+qAGwX3K2tpNRo7NbLLR9ztPG0O/R8bx3E/H
   9x4DqOttfrFMSKXr7Sj/kLLvlgpu6Zr6mtAIfUBgesNbajxJMoQJJMUKy
   yc8DZ79VTNvibl0ucnVzvTj7ttuvOb8NacaOtJwb8DF3NqMth4QdlH9Ar
   WlVFASa/tBs9AGMaY0RSAjIS2AAmtJQX+D5ez3f8fFy+2fW+R8RZpFDNy
   A==;
X-CSE-ConnectionGUID: 5ohsBXPDSxGhTXT4i4DABQ==
X-CSE-MsgGUID: ClD7DYz5ShiAB6i9B/jWIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106307720"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="106307720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:32:17 -0700
X-CSE-ConnectionGUID: fg8I0Ia+TMiazQrfz9CLzg==
X-CSE-MsgGUID: 2GTeZqvnS/Kq3FxYB5OEew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="242819017"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:32:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:32:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:32:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.48)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCnK+6BEp8PmfYRw314YMOh+LiKopZTezt1L6Qn4+UqjDsy0L8qUpWQuayjP0kSAYtlYVDxRxRZsaPukmadzp2di6MmuZCjdnBMa8KBmJWcIZVwh3r3xgrRTpltnngQ+pIpvQE83cgmkEpgIYNVjp+2WeynJd3Rt5RMvxF2DDjy6Jxjqc4/zHfZTVGQMHLlbd9M6k9ldrj3+qEttd3O5owt/tPWIv0LI2WXr/HRk5T/AuKkH0O05a2LAbQTvzCHMbBJj49ht7Q9O5hx4k5M+VE0PzsKd7TwPP7dfycYtP4As+540lOxkYW/KJKNPNUJRd1aVvnBAfdaqw0nfuX5ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuXs41Rg8AH4H0NNHLw7CjQVoBz9bVwaGXgyQBIg5MU=;
 b=h2LxaR3eX4MQu3Ps+TVMH+vmGMJeIzRPPqUAXHfqz7GPg3OHYJj7R3u6NYrz/P5NxekMvZeGqVw/Y9P5eXiqY9PA2+W9V72sTtFYGF590yIQ3pK1GFq9geYbJ2IGgerMxNq02upoP96lkykJnKodIlo0gsw8+A5CzW5ueex3Fe0oLwfBvHCqIoFTBZcrOv++tecQ5FReRYzh6AYPMBDOGSvXGZgP6PlHmnqeslDycgLmcs5jwRnUwa9vDJDXVTCj/FJJRmdcjGMigMapBDe56mqrNZkayc53mY40cBP6fqM3RhGU8ThjD0WXv8Ih695/L+PPgnhA8pED1dP4G0GTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 21:32:09 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:32:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Thread-Topic: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
Thread-Index: AQHc6aBAhCkiw1wDskK79eURNs6/ibYj/52A
Date: Thu, 28 May 2026 21:32:08 +0000
Message-ID: <280fdea480922ad843e738b14f0b32cd977734a3.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA2PR11MB5161:EE_
x-ms-office365-filtering-correlation-id: d58baa7a-b45a-43e9-72cd-08debd009256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|4143699003|56012099006|18002099003|11063799006|5023799004|6133799003|22082099003;
x-microsoft-antispam-message-info: ADqPPtV/cvLD4lG9YTlmTNvY851O6AU3yf5651CNPohAXImOFya67k/86yfCueAZZv8miC2BRiA3coOxjL6k19/XYXHvmwRDzoxVnYN0+8raAHPZe79BqRZeyf4ZgfxMEEojXtp2cIm54lhQueaIaTYlW9SjTE8zy2ImpJzDMZmIn6xCpmadavNUZSU/EPRnsc0dFMYOwCFUW4TNfscvYTV5fDyxGV9QztsrGXpl1XzEXyrsZfPMr9OB9AkoeKdtt2DDhb7ObgyiNM3+59wbu5GJtBvvso9EEByAB27xaV7Ql4qspBQRisCDxWQI6kW3FZrw8gez14ClQXYru8tjix8EnONkQXnLaX2yYn8tDugwwOgthJt0w8FLzb6X2ZTJFwLgw6XWV7EVxUHQX4Kl/I3/cU2or9UeFp5iqn2dHPmJdl6gyWzsJBB/fZyYeg1LFbTZIxo3Ha42mw+BoQgiKrIhO6H5/R6ed8Jju/7KvZ0+4dZCmXJ3JyuRwi47oogd/6VXj4F5XOYw45xvDD8EkyYKpJWHMfcE/qrhUPbXANXJVSQzRVZo7SteWSW9WKdVKoH28LFpxP/FnOHkl1Irlq7b09O3gMEwbUzKrwmTndAHZY1olokbhxJI2MhWTa9QH53fH0HjoNH1qIm7/aJ4NYq+S59AIbzMqTd7ZQW71Sp0/qCgJnI7AtU/14/woltUIgJuSKlL2ss5clZPoFLLBjdkZQ2bZpRuv14dui+73HioAdfPvotdLScyEKdhPOKO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(4143699003)(56012099006)(18002099003)(11063799006)(5023799004)(6133799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVSMnV0Nnc3bTQ1WlNPRjhKb2tBVUo2bE9CcTlmbUFRZnJobm1Uc2NlNHB6?=
 =?utf-8?B?MkF0T1l3NVZlSHNlY280Wko2dHh1amZWZjNyOERtelI0cmRiUlpRdXN2UU5K?=
 =?utf-8?B?K2lYbmJ4RnNTOTd1WGJqR0JWWEJjS3NnTm1DaTVMZUNXd1B1eUprVHU1bGhK?=
 =?utf-8?B?OVo0SzVsY3BUZDI1bW53QXIrUWkyZG1JOHBkcTJSVUhuMWdOVk9FTDZmUDhn?=
 =?utf-8?B?b0xUQ2RYQlNlU2Nremp1TytSNmh6cTAyR1luK2ptS0RLRDFFbFlMT0xGck5R?=
 =?utf-8?B?MlJ3L3JSNzdNVktMaE1IeUI2QlNYU2U3UUNDWkFaUHhVZUIwUTIxYlJPZVNJ?=
 =?utf-8?B?amxLLzBCK0liZ05XZlNPalpObFVJNVZmSDQrZFFCd0N0T3VqNEpxUkU1Y3Q1?=
 =?utf-8?B?UmVGSEthajJsaFIrekFDT3NYRDZ3aFhqaWJQcGJsdmxNd1B5d3JJbWQ0TmJY?=
 =?utf-8?B?Z1pseklrVnZ4TGlsbjNINk9UN0grU0ZEc0ZEbXRFcjFHTmFIU2J0OUhZRGRy?=
 =?utf-8?B?WjE5RzZYcnBhRWpqVFN3dzd6R3Nwdm5ybzh1Z28rMCtFSTR5bFBHT05uM1dP?=
 =?utf-8?B?eHAxSStuR3AreGlSS0hwM3FOSnJwUmhFajFDVHlyZU1oMWlrR2tpSTVWenN5?=
 =?utf-8?B?YVdEd3M5a0VBSHMvd2F0N2xKOXNDRE9OUE9ncVVteDZaTHFEajVzVUNERGRU?=
 =?utf-8?B?cDBtdWNIRjdKOUdySzl5ZVdNTjY2SjBzbFY4MTcvb25EWCtZeXVWQ1hvSHJX?=
 =?utf-8?B?S2o5WFhnT2t5R2hUcjRuMWVyR1BCSWIxOXZxNXFQVlNtU1o5UVVyVS9jdEpQ?=
 =?utf-8?B?ajB6OHYvdllha3NJajUzYStTclgwNUpjZVpEcUNJR3k0TDUrcGwxUXJvV0ww?=
 =?utf-8?B?VVJCY3BWazNBVDNGWmlPWUVYMmFQRUVReWFkSE1NKzhEaitKWnN4Tkl2Ui9y?=
 =?utf-8?B?bGdsbkt2Rk52T1ZGMHBUb1FPRUFBRFBIVExwQjlXVFM3U0ZjMnlTZzVteDlt?=
 =?utf-8?B?cDJCcHF1K1JKK3NIbkhtVHB3NWc5UTVITmZVNEJjZy9LVjNBTTVQUFhObURi?=
 =?utf-8?B?S2RtU01qcTJ5dGx2Qk4xTGs2S3A3VmU4ODJwSFZKQWRYTFBBbnJFQkJsOE4y?=
 =?utf-8?B?cDZ1ZnVFckZoaXlVNXBiVWYrNjJHeGhaK0p1UHdyZ2pkWjhoTDRRQjc0QTVB?=
 =?utf-8?B?c1dpd1lyYmdyOXA4dEZxRjdLUjhWUEo4Z0kvREd1bUZnNDVnTVRGQjB6VDBY?=
 =?utf-8?B?UWpGNlZoSkJnZ3F6VzkzdWZaSWorN0VQVVVMMmxBbWdQaUcrUHNmaE90eGNB?=
 =?utf-8?B?SVhrZmRWYjA3Y1krS1FLL1V4cDdVZG9RVTN4eDl6ZWo1aXdSME9sRENRSlZQ?=
 =?utf-8?B?a0t6bWJOZEFjSVNRT29RVjc3UFdkc1E4Zk9qTVRSN3g2aDhuQzBmNnJMbVc5?=
 =?utf-8?B?Slp0SjlRdnJNR1cxeFhic0xBYnhGT0Z5WDNxcXExRnhjbDlGNDh0OE5xT2Vv?=
 =?utf-8?B?ZlpBV3FMWFQyNXNhT09FRzhrOFdSYjZPOENBVnJUQm83TmRUVUpCVTF3ZFcr?=
 =?utf-8?B?QnUrakRZQWtQc3FPUzlKQlFuRTVvWUUvMmFaKzVxRFpkbmpZZXo0bElqTXlF?=
 =?utf-8?B?Uk4yV2lHUy81OGIwYVZER0Q1YUl3NHFIbHBiUkt6TDNnelNuL3JIdkl2R1Uw?=
 =?utf-8?B?Q1BFQ0dnYkJJZzFzRlNHOUlNYUlnOGl1NytWaXdqUXYvQlhMQVNXTXlkOHVK?=
 =?utf-8?B?a2hDcjBXMmxSd3FZemJ4d0lXS3pYKzdOWXhJZkJqOUZnTW91S2VnN05TbW9U?=
 =?utf-8?B?bXJWbFV2NGhSY1ZEdUhSVEp1Yis4Z3d0aG05cFFNSnY0Wlhyc3g4azk3S2lm?=
 =?utf-8?B?VzNlOHlTOEpUSHE4Q3g0Z2RhWXVMckFLZ1dtUGp0REVrTW9xTEh0RU1GT2Ex?=
 =?utf-8?B?djhwV1NlWEpOOUUwbng3OEhkTGEvdVhVRzd0V0sxelVuakgzNUQxOVVkVVpn?=
 =?utf-8?B?TTUvS2lnMUpmR0VCVENLaGFWcU1NZkhCZlZYTW02MVdHMFVKRTV1cEMwYWNJ?=
 =?utf-8?B?TG5zaEY5WGpmVlovT3pQdlZsVnlEOE5FY3hsY3BuVStsOG10TjlrQzVEMk1s?=
 =?utf-8?B?endhUzFPQTUzTVZLc1FuR1o3OXBnd1ltVjRaTGJHUksxWG5WL2JpcDFwK0lw?=
 =?utf-8?B?bWRrSzNsSEF3MmFKakw3dFJiaUFacXN4aW1mMHp4MFZrb21VRnIzcVgrL0sw?=
 =?utf-8?B?SUhDNmxUZ3R6R0Rib2dRaVk3a25UNnB3MmRGN1VsbFhnc0RmSm5jUlI3NStT?=
 =?utf-8?B?WkdlaFN1eXcxOXB2U1BVZWNkK3FNckI5Y0t0SjNIK0lVdDNxMGRuSSs5UGRk?=
 =?utf-8?Q?kPIygyPgb5Yo6hTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47A6EFD22CDD64EB5C9B3DF2E26CA67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hGkM4Z+29ABRg1TSa4CB6r/lRzWZSIMERx5gyxyj2LZ0XSq6iBS7u7ACdpmtmZN5zbgWSxZK6AEZeZhTt6hzHYvXVRGMf+gtNv5o76/2WZHDG4ezT3OkvoLJ607ULWw9KMAc4FNEp3VEcx/ZRQEByZm51lp2rkkS+4HeL6sN6laxZ63zJkUSt1t1Ke8+X+mfVn9YbUySIyDFeAgf5mx7WUdTZLkewZZjoz+arhWOJq88IJTlYvbDiqr31JIWnCodC1ZY2xzC7xpGTCczdhTLbkwVs2Ke1X/Qt1cyKudswCpigL0iW2rMqOCdbUFfIYsbXLDmE2ul8nbXwG0kCeUTFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58baa7a-b45a-43e9-72cd-08debd009256
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:32:08.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ynf0egKLi3yKGkbtVfCTekVSJDa3TIuRpMx40yu9Np73UjBzx4MuLoeHD7CNZSYl2DUYogsRTY+dZd7EFs6ZPeN4SPrly22AvzoYdqprads=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVGhl
IGRldGFpbGVkIGluaXRpYWxpemF0aW9uIGZsb3cgZm9yIFREWCBNb2R1bGUgRXh0ZW5zaW9ucyBo
YXMgYmVlbg0KPiBmdWxseSBpbXBsZW1lbnRlZC4NCj4gDQoNCkknbSBub3Qgc3VyZSB3aGF0IHRo
aXMgbWVhbnMgZXhhY3RseS4gV2h5ICJkZXRhaWxlZCIuIElzIHRoYXQgaW1wb3J0YW50Pw0KDQo+
ICBFbmFibGUgdGhlIGZsb3cgYWZ0ZXIgYmFzaWMgVERYIE1vZHVsZQ0KPiBpbml0aWFsaXphdGlv
bi4NCj4gDQo+IFRoZW9yZXRpY2FsbHksIHRoZSBFeHRlbnNpb25zIGRvZXNuJ3QgbmVlZCB0byBi
ZSBlbmFibGVkIHJpZ2h0IGFmdGVyDQo+IGJhc2ljIFREWCBpbml0aWFsaXphdGlvbi4gSXQgY291
bGQgYmUgZW5hYmxlZCByaWdodCBiZWZvcmUgdGhlIGZpcnN0DQo+IEV4dGVuc2lvbiBTRUFNQ0FM
TCBpcyBpc3N1ZWQuIFRoYXQgd291bGQgc2F2ZSBvciBwb3N0cG9uZSBtZW1vcnkgdXNhZ2UuDQo+
IEJ1dCBpdCBpc24ndCB3b3J0aCB0aGUgY29tcGxleGl0eSwgdGhlIG5lZWRzIGZvciB0aGUgRXh0
ZW5zaW9ucyBhcmUgdmFzdA0KPiBidXQgdGhlIHNhdmluZ3MgYXJlIGxpdHRsZSBmb3IgYSB0eXBp
Y2FsIFREWCBjYXBhYmxlIHN5c3RlbSAoYWJvdXQNCj4gMC4wMDElIG9mIG1lbW9yeSkuIFNvIHRo
ZSBMaW51eCBkZWNpc2lvbiBpcyB0byBqdXN0IGVuYWJsZSBpdCBhbG9uZyB3aXRoDQo+IHRoZSBi
YXNpYyBURFguDQoNClRoZSBMaW51eCBkZWNpc2lvbiBpcyB3aGF0ZXZlciB0aGlzIHBhdGNoIHR1
cm5zIG91dCB0byBiZSBhZnRlciBjb21tdW5pdHkNCnJldmlldy4gU28gZm9yIHRoZSBwYXRjaCBs
b2cgd2UganVzdCBuZWVkIHRvIGp1c3RpZnkgd2h5IGl0J3MgYSBnb29kIGlkZWEsIG5vdA0Kbm90
IG1ha2UgYW4gYXJndW1lbnQgdG8gZGVmZXIgdG8gYXV0aG9yaXR5Lg0KDQo+IA0KPiBOb3RlIHRo
YXQgdGhlIEV4dGVuc2lvbnMgaW5pdGlhbGl6YXRpb24gZmxvdyB3aWxsIHN0aWxsIG5vdCBzdGFy
dCBpZiBubw0KPiBhZGQtb24gZmVhdHVyZXMgcmVxdWlyZSBFeHRlbnNpb25zLiBUaGUgZW5hYmxp
bmcgb2YgYWRkLW9uIGZlYXR1cmVzIHdpbGwNCj4gYmUgaW4gbGF0ZXIgcGF0Y2hlcy4gVW50aWwg
dGhlbiwgdGhlIHN5c3RlbSBoYXNuJ3QgY29uc3VtZWQgZXh0cmEgbWVtb3J5Lg0KDQpIbW0sIHRo
aXMgcGF0Y2ggcmVhZHMgbGlrZSB3ZSBhcmUgZmluYWxseSBkb2luZyB0aGUgaW5pdGlhbGl6YXRp
b24gdXAgdW50aWwgdGhpcw0KcG9pbnQuIFRoZW4gaXQgdHVybnMgb3V0IHdlIGRvbid0IGFjdHVh
bGx5IGxpZ2h0IHVwIHRoZSBuZXcgY29kZSB5ZXQuLi4gDQoNCkEgbG90IG9mIHRoaXMgZGlmZiBp
cyBhZGRpbmcgX19pbml0IHRvIHRoZSBmdW5jdGlvbiBhZGRlZCBpbiB0aGUgZWFybGllcg0KcGF0
Y2hlcy4gRG8gd2UgbmVlZCB0byBkbyB0aGlzPyBXaHkgbm90IGFkZCB0aGVtIGFzIF9faW5pdCBp
biB0aGUgb3JpZ2luYWwNCnBhdGNoZXM/DQoNCg0KSSB0aGluayB3ZSBtYXliZSB3YW50IHRvIHNh
eSBpbnN0ZWFkIHRoYXQgd2UgYXJlIHNldHRpbmcgdXAgdG8gZW5hYmxlIGV4dGVuc2lvbnMNCmF0
IFREWCBtb2R1bGUgaW5pdCB0aW1lLCBhbmQgZG8gdGhlIGV4cGxhbmF0aW9uIG9mIHdoeS4gVGhl
biB3aXRob3V0IHRoZSBfX2luaXQNCnN0dWZmLCB0aGUgcGF0Y2ggaXMganVzdCBhYm91dCB0aGUg
aW5pdCB0aW1lIGRlY2lzaW9uLiBXaGljaCBzZWVtcyBhYm91dCByaWdodA0Kc2l6ZWQuDQo=
