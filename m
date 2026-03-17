Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148F31B131;
	Tue, 17 Mar 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784568; cv=fail; b=uISlTdERtV29Gkjh8JtG04FFMr6R/WPcmHNtTtN7RZpyBWQUBwdEtBb48P5rR6nbEEMPPqlGhYtiRhCEs8SL1YaTknlaToUNaljsjvQuUESlyHPIVnC4al+KhwjahVCBPBqWoiIlSTWrgOCx5PI87pySa7d0gIIdCHQvyhFZqc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784568; c=relaxed/simple;
	bh=rtgSHSnUHB5b2HA0i4IKcLh6tLYsJ8jhD5IQ2fRe40Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WnyHEXKTqc3v7zyDvLjKoNs2P6RyTyTNu6UKgKrz8JtYqvtE2f/J2QuSqpd2W/wXmDiJWM0WgWuZGkBa1xhrV1TBOyNarUYZ3pT3KLrh/yuqjpzf2NfEmxaj8f/B1qn6tRouJ9Kllt0BXuoGOfzyGtUJcnrO9+c/fMXGR5O+IiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRMryNLP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRMryNLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773784567; x=1805320567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rtgSHSnUHB5b2HA0i4IKcLh6tLYsJ8jhD5IQ2fRe40Y=;
  b=lRMryNLP1XWttao9WWy6vUvsgPBBapv30bKZY9CshaLXUp2mnIdhlvM7
   4LupoJK6eArqdAtWPH1iuSwhj1k+4laHFae52az9l/i6Ssq3kzBYJcIKl
   t/nYPqcbrGkcYYILw/5nixGUCuFA5YKpkPsE7FPPSAYemB3VwRXmQMfbE
   FQS24ihHwoN8moVueIGnMFpPuIewisBaEZj2b4BySKieMILMrV3ps3BaA
   GAhw4OEobulohwthza+S7jD+EprGiGxqbeO+McqjVLSEWy7FISn1h3+3R
   XlYkCIgcaNogdxZlroeILiD2ST+Kst8Kr63YVgjpRzFy+uYu43Ct2vg7y
   Q==;
X-CSE-ConnectionGUID: V3WGpR2/TvGzFK/M+mtwNw==
X-CSE-MsgGUID: 5LWT1eFwSoiCsGwJIAbZVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74719399"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74719399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:56:06 -0700
X-CSE-ConnectionGUID: 2KCcTZ3uRIGQKbJxV86T4Q==
X-CSE-MsgGUID: xlp/m4uYRqeE5Vjmk3ezQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="260298449"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:56:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 14:56:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 14:56:04 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 14:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrEpsebco6KWfZ9EarjAuMeXgnZHy6E2vs+H9BnUG3sWW3LAImBnsXBiFVR30TlzdtpSIge+f/UsINCk/tTu/+gu3ARgxF88wj0DVu9PGr8ixE5LF38wxTTmLRxfe//2kmx3ngmb/7712z3cum2qEoCpGr/FZXLdeqvjvhjj+yLGV3q3SdV1mLwEOT27tb4Bc36S79vV110OFCfBmWJKc5CWSL4OUwr6sHCXpAZ8soGY6ZHpOdspKIChVZbsYw89PPJIA+smj8RAWQmwRHw0l02beD40DMa20s51+m90OkaKjKL9Jzvt0DdfskDbiJVWdRuRu2fnPb8unlOeZCfhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtgSHSnUHB5b2HA0i4IKcLh6tLYsJ8jhD5IQ2fRe40Y=;
 b=jGqWppU2OgZbJZikf2ZnrdroUSRCKwrGPYh8i2zkQZkhuPetuVfOOpoOoRY0sBFmxu6ZByQHGruJnQUDOf9piRxHA20iEKz6v0xz2PKVpi1JgQQSHBe0n3VTPwFmLhsR0Mf3+I3GPiOQb3K9XbQZPSWjJwyzrfjGC/34f1R6KqX3UdryGDSDvHOgKMdxwIcQ3hPxcIIYaVT7oEc5zqFP4+tJdT4jLZks2C1tSacKB1DciDait3KMrvyAg17jg4ussepH/NCyg0rw4SkU+V5MQL9w/jBVvz6vjj5eGxysjCSM7natng4kpo4MpT7e7wdyRlb5CsLyxSOMyl3c6BC92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 21:55:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 21:55:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Verma,
 Vishal L" <vishal.l.verma@intel.com>, "Gao, Chao" <chao.gao@intel.com>
Subject: Re: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcrc5S5plCcsB6A0WZ+ibcqtEcs7WxGrsAgACdmwCAANJEAIAAy3UA
Date: Tue, 17 Mar 2026 21:55:59 +0000
Message-ID: <cdac9b8a5e9ca9052db59afeadd8278d837b8f33.camel@intel.com>
References: <20260307010358.819645-1-rick.p.edgecombe@intel.com>
	 <20260307010358.819645-4-rick.p.edgecombe@intel.com>
	 <abftAJkiU3Q24wYQ@thinkstation>
	 <ac341cedf0e387f2ba5cf3fc9d2ad5fcaa2ec3c8.camel@intel.com>
	 <abkdNQnvgJWmaKWk@thinkstation>
In-Reply-To: <abkdNQnvgJWmaKWk@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7621:EE_
x-ms-office365-filtering-correlation-id: 97a98ad1-eaf1-4da9-7551-08de846ff95c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: TPrzLOy07o1ECXF8ZZpjfCW+l8BzGXCZsCprvRdgowNUcLnYSAC66qc5OrrUI2Ek8HirqIgrASJOVKtF6GbTuPX8NaFvTUHoG2ReFyHsx6Rr4FoSWwmbs603KSWTBObGxokF5/eh0q7DGv0dJUULEmjU26Ys9FxABGsXu9JqaiZKCb6B5AZLk6l/WtpXFy3VG6R8jMLNMMPckwCF2sdCm1lXF4FtYE34WdETZ6weWq2IHR219JiXcBm9blQbbMwr5X1RZ9y1LuU5VVkNVyM2uGn4cwL3bQ63YrPCQUHQEEYnaMDZnkvuoQ9wbS7pm1c+wB7dGKJC6k148My1y+idok1ZycDC76aQORAUQBcBrfnxaCW9R1iPrjAgzGRMXoYZu580nqDucGp+yBCtfvIQTv0mEai/YQwsgUtDCIpMg1GfquhxIHh4v3CRhtKdYDLe9xI2ulDvZKXIPV1RYEcPzLPrYav2mdfGHRxz9Ag0Eq6nnIuS021omEXsojaEqtLcAOWDd930xxUPHNM5JPEBFji+1rxRQWpavX5RCplkS7CRjVM7iwAEpwjJiYS9OQpVapKzHKSEkHsYspvlDlR+D28iYM3Ln29vE7FUAZ4bGE/Vxfe6kANtODdGHPM1HhPuVoyvBlWWnPPYstj4dPdCf3Oz+0isgjrxsW1iIxnmAWWafbyI7rHcr76ju6bnDrGP/yTHUGh3YKtpXZy0glcosfE7NwfX2Hc8rcjkTU9eaOWF47A2+tlvO8+/nrh3uIPtkX9O54eioBc3ob6KeEmH3MymX8XQD4W5mv49tfTbTj8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0JCNEVUaEEwZnVRa3ZwZS9DNUpyZHV5Rmk2L0tsc0xqWUlBQlExaFVhWTJI?=
 =?utf-8?B?S1U2MjVPV3E4RkxJM25PSmt0Vkc5Z2FCMld1Wko3NHRmQ2wrSy8yN2FLMTVY?=
 =?utf-8?B?TXNKeVJtRzExc3VCN2thOGt1c3J0QjNkTDFuMFZycWlRRHVtSWYxSEVkRW9n?=
 =?utf-8?B?OW5oemlCTXgvcEwrL3VaeVIzb2ZuOUVsSUREY1JTbWNVU3JaYVg2VVh6V3lT?=
 =?utf-8?B?ZGpTa1BwbUtBdkR5dnFXcUF0WEZrRDNhUHd2bU5HQUtZc0NvcXdTVzFKbVJ1?=
 =?utf-8?B?T09iQXNlOTB5TUZDd0RyOXZUb1FLZmt2ekdxSG9Ybk5iN2dZcXpvWTJtTEQ1?=
 =?utf-8?B?aE1wcFB0WGhNZFZmNklrL0xaa0c3cnNnWEpkSzVoczZSekQyTE9QYk9MNFBq?=
 =?utf-8?B?RmlHT1VrNERxVDVvNjM0S2xCK0paVlBFMXZMQTVhenE3MWk2dXcwbjRCNU1R?=
 =?utf-8?B?VU5yOEYzWEg2eHJZNllyYm9aZkx5NGJXV1pOc3N3R1pRMmg3Qlh0UjdVMnRj?=
 =?utf-8?B?em1QeUh6TkN4N0VDSVBMZkNOakpVZERrN2RWeXgycThTRWJPYjRzOTJxbFJP?=
 =?utf-8?B?amVwWENicDBBbDlVdlF3aG1IaE41VW5pSWI3WVZDUXhPZ0JkV3Y4SE10eXVM?=
 =?utf-8?B?NlRUS1ZKR3VLdU44d0tZbTIxeUNOWWQ4aFRjQU9VU1ZjSHN1UmhNbnNOZDNC?=
 =?utf-8?B?aWxaeXcyT1AzcVM5dlpQbDdLZ2ZDbUpXbHBtWVY0c2NrRHk0TXIveC81bGpy?=
 =?utf-8?B?TTBFNVlWdFVlenBIRkVJc2J3blVWTkNXYVppY3ZNRlhxVGMxTW5YZlhBTW9n?=
 =?utf-8?B?TGNQQmMxRkgxdm5ZMG1tZHJnaksxMHJwLzNhSWpmdkNiNGRtTmdEa293L3R3?=
 =?utf-8?B?UC9WUzIzd3oraCtnSTRjV2ZrMkNNL1FOWndyQWlCckduaGliNmhnMUdJeGR6?=
 =?utf-8?B?WlFIQkFVSjgranFNUUw3TEI3TFNWaEJzYTlTOEJzb1pkZmhnR1VHa243czhy?=
 =?utf-8?B?WXZqNlNRMGd4K0IveVNSdjNJakc4OERGWUVKR3FNWFVhcjZkQ0xzajFzdDUx?=
 =?utf-8?B?M05wZEFBbExFVkt1MmY5aWNwSFViYjRORzZCOUJpYTl0Y1JpMVo1YXVZcTBk?=
 =?utf-8?B?RHB6NTQ1K0k0SmZvWVlIQjBIeTFUWFloaFB5bStVMklVOU11NWFRQzRRNWpF?=
 =?utf-8?B?MEk1QUhWb3NlTG51WHQ5N1RvdGxra2NWZFFLZFRKS0NXNVNGNU9VcVd3OEZk?=
 =?utf-8?B?SlQ3NTQ5K1o1OHZEMm1qdExzMVpWamJBRkhBMVJ1dGgwdEF1bjVScCtzMTM2?=
 =?utf-8?B?cUVuOEQzK0xXdkdLZWo2L2ZHUFVXMURJYWw4clg2RzJEZlExTVljOERBa3pa?=
 =?utf-8?B?YVZiVmY3TjQwME1mQ1R3WE9aOVJzSVR0cU9vYVFQMWx4M1lmR01JWlltWis1?=
 =?utf-8?B?YSsrSWx5UHcyV1ZUUDZoYXg5dlBDdXhmcTBydlhXc3ZFMkxxZUtOM2M5Qldx?=
 =?utf-8?B?Sk40QVQ4V2kwby9KSVh6SklyVHNKOUgvZWhlMlRiMHg0SWRwTDBIblhrMGYr?=
 =?utf-8?B?WTdFWnNjMncwNzc2bWZzVWdndXdKMktDMWs3R05iSndLZURQazc0R3dIVklk?=
 =?utf-8?B?K0tBZzZld2RUalhHd29KQ21ZOTUyWlZKZ0hYaFhHcXFtSWMvbExzamlBRzNP?=
 =?utf-8?B?aGk3WCsyTEtqL1R3VlgvTHVYNC9zSE0rak51K2N5YnYza0RpVHRTS09SQWZG?=
 =?utf-8?B?YW9OKzhuK0kwdGo2S0c1WGhrdCtmZnVNQTBsUjBRL2kwZnlYclZ5eE1mTjFD?=
 =?utf-8?B?L044emJBbi94VktsNUZDUXp2cWlpR1VBNEhib0tEOFE1b3BHaU9icVc5VFR2?=
 =?utf-8?B?QWI4L2tBOWh4eVU3bXlaVlJBcXNMQnEwcVR3TitOUXNoTUJnNGF6UjBTa253?=
 =?utf-8?B?MkRxMGhOSURVSloxdUgzTmpURi9Fc251NU5CZ3FmdC93R2M2MnI3blFuZzBq?=
 =?utf-8?B?OHV5UTRkUnlKN0lmL2NiaHJGdzJOck43bkN4UWJ2UitJbWlsSzhLSkZURFFT?=
 =?utf-8?B?bkdPcjhMcGlQUDZXSkd5RWhINHBGWExSVWpKTE9NQkxTWW1abVhCM0NLaGlD?=
 =?utf-8?B?QkdjcGkwSG9JdUJBUEdaUy93aEd2UUlveHlzaFRnLzRMMjVOOVplbEthcmNL?=
 =?utf-8?B?dTRkbEVyVnhDRlZFVStoSUxXeUlzTG1BMld2UDhwN3h4VzV5R2E1ZW1iSEVs?=
 =?utf-8?B?cERtZlB2NHZRQVpyT1NtNkNscHpNZllOK2tEeEtkQk5oVS9EbDNCWGZianBE?=
 =?utf-8?B?VEdJL2QvaHppVUxEYzJEZmFKOFdEMitveUx6NnlHYnRiUER0NkRCMjBqUjF1?=
 =?utf-8?Q?SleqwdwJE6wbZbvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08DAD3D074CE5D4CAE37425E77535106@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5RncABYh0pen4if/ctRe/6G2Zx8zfY1HvTgc6E2SoRAd/ADwL5cQhfI+n0jXqFq9DD0lQu5x2YhFC6JrdPAig5oV6dnXxiacwZJ5Mpqckd3I2L4ND8M+8+aGLUrA0ORefhVakWT9Fl28CX3gDNlazXpILWoSeCi65Qi4ZgpakfrKNOuMCiYGMjHEu42qA3pl/IlGy8SAO+LWB3f6FL3UBHw67dS5+nkQQ/Z6o7NLUfajy5Skcf6NyGUUjmHf+2KcIu9ZS5K89WYh+PcabOJblt+G5dn3Z0kgn58BMZ9FDLol0dx0OBlJNte7JtqGu346aifcmMWJ3J8JtURKnSkng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a98ad1-eaf1-4da9-7551-08de846ff95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 21:55:59.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC72nVRack2AyX3CsmGNVQLO8oeK2eF4kELeW3EtqN+ixgbSMAwHUuB/95eQp5+nJRVsNPYXXFT5asEKgXUF1Cs1qvewMjV22uVLKZ/NWsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7621
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDA5OjQ3ICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ICBXZSBkZWJhdGVkIGNoZWNraW5nIHRoZSBmZWF0dXJlIGJpdCBiZWZvcmUgYWxsb3dpbmcg
a2V4ZWMsIGJ1dCBkZWNpZGVkIGl0IHdhcw0KPiA+IHNpbXBsZXIgdG8ganVzdCBibGluZGx5IGNh
bGwgYW5kIGlnbm9yZSB0aGUgZXJyb3JzLiBUaGUgcmVhc29uaW5nIHdhcyB0aGF0IHRoaXMNCj4g
PiBpcyBhbHJlYWR5IGEgc29tZXdoYXQgZXhvdGljIHNjZW5hcmlvIGJlaW5nIGFkZHJlc3NlZCwg
YW5kIGZ1dHVyZSBtb2R1bGVzIHdpbGwNCj4gPiBoYXZlIHRoZSBmZWF0dXJlLiBTbyBtYWludGFp
bmluZyBhIGNoZWNrIGZvciB0aGUgZmVhdHVyZSBiaXQgb25seSBoZWxwcyBhIGxpdHRsZQ0KPiA+
IGJpdCwgZm9yIGEgc2hvcnQgdGltZS4gQW5kIHRoZW4gb25seSBpZiB0aGUgdXNlciB3b3VsZCBy
YXRoZXIgaGF2ZSBrZXhlYyBibG9ja2VkDQo+ID4gdGhhbiBhdHRlbXB0IGl0LiBEbyB5b3UgdGhp
bmsgaXQgaXMgd29ydGggaXQ/DQo+IA0KPiBObywgSSBzZWUgdmVyeSBsaW1pdGVkIHJlYXNvbiB0
byBzdXBwb3J0IHN0YWxlIFREWCBtb2R1bGVzLiBVc2VycyBhcmUNCj4gZXhwZWN0ZWQgdG8ga2Vl
cCB0aGUgbW9kdWxlIHVwLXRvLWRhdGUsIHNvIHNraXBwaW5nIGVudW1lcmF0aW9uIHNob3VsZA0K
PiBiZSBva2F5LiBCdXQgaXQgZGVzZXJ2ZXMgZXhwbGFuYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIG9yIGEgY29tbWVudC4NCg0KT2suDQoNCj4gDQo+ID4gPiANCj4gPiA+IFNpbGVudGx5IGln
bm9yZSBhbnkgb3RoZXIgZXJyb3JzPw0KPiA+IA0KPiA+IERvIHlvdSB0aGluayBpdCdzIHdvcnRo
IGEgd2Fybj8gVGhlcmUgYXJlIGEgY291cGxlIG90aGVyIGNvbnNpZGVyYXRpb25zLg0KPiA+IMKg
wqAgLSBLYWkgYnJvdWdodCB1cCBvZmZsaW5lIHRoYXQgd2Ugc2hvdWxkIGhhbmRsZSBURFhfU1lT
X0JVU1kgaGVyZSB0b28uDQo+ID4gwqDCoCAtIFByZXZpb3VzIGtleGVjIHBhdGNoZXMgaGFkIHRy
b3VibGUgc29sdmluZyByYWNlcyBhcm91bmQgdGR4IGVuYWJsaW5nLiBTbyB3ZQ0KPiA+IGhhdmUg
dG8gaGFuZGxlIHRoZSBzZWFtY2FsbCBmYWlsdXJlcy4NCj4gPiANCj4gPiBTbyB3ZSBoYXZlIHRv
IGV4Y2x1ZGUgYSBmZXcgZGlmZmVyZW50IGVycm9ycyBpbiBkaWZmZXJlbnQgd2F5cy4gQW5kIHRo
ZW4gdGhlDQo+ID4gd2FybiB3b3J0aHkgZXJyb3IgY29kZXMgZWl0aGVyIGRvbid0IGltcGFjdCBh
bnl0aGluZywgb3IgdGhlIG5ldyBrZXJuZWwgd2lsbA0KPiA+IGZhaWwgdG8gaW5pdGlhbGl6ZSB0
aGUgVERYIG1vZHVsZSBhbmQgZ2l2ZSBub3RpY2UgdGhlcmUuDQo+IA0KPiBUaGUgZGVsYXllZCBl
cnJvciBpcyBoYXJkZXIgdG8gZGVidWcuIEl0IGNhbiBiZSB1c2VmdWwgdG8gbGVhdmUgYQ0KPiBi
cmVhZGNydW1icy4NCg0KT2ssIHdlIGNhbiBwYXJzZSB0aGUgZXJyb3JzLg0KDQo+IA0KPiBBbHNv
LCBkbyB3ZSB3YW50IHRvIG1ha2UgdHJ5X2luaXRfbW9kdWxlX2dsb2JhbCgpIHJldHVybiBmYWls
dXJlIGFmdGVyDQo+IHRkeF9zeXNfZGlzYWJsZSgpPyBJIGd1ZXNzLCBUREhfU1lTX0xQX0lOSVQg
d2lsbCBmYWlsIGFueXdheSwgc28gaXQNCj4gc2hvdWxkbid0IG1hdHRlci4NCg0KWWVhLCBhIHNp
ZGUgZWZmZWN0IG9mIFRESC5TWVMuRElTQUJMRSBpcyB0aGF0IGl0IGJsb2NrcyBvdGhlciBzZWFt
Y2FsbHMgd2hpbGUgaXQNCmlzIGV4ZWN1dGluZy4gSSBndWVzcyB0aGUgc2NlbmFyaW8gaGVyZSBp
cyBURFggaW5pdCByYWNpbmcgd2l0aCBrZXhlYy4NCg0KQnV0IGluIGdlbmVyYWwgaWYgVERYIGlz
IGRpc2FibGVkIHdoaWxlIGFueSBURFggc3R1ZmYgaXMgcnVubmluZywgdGhlIHNlYW1jYWxscw0K
d2lsbCBiZSBzdXJwcmlzZWQuIFRoaXMgaXMgbm90IGZ1bGx5IHJlbGF0ZWQgdG8gVERILlNZUy5E
SVNBQkxFLCBiZWNhdXNlIFZNWE9GRg0Kd2lsbCBhbHNvIGNhdXNlIHNpbWlsYXIgU0VBTUNBTEwg
ZmFpbHVyZXMuIEVhY2ggU0VBTUNBTEwgcGF0aCB3b3VsZCBuZWVkIHRvDQpoYW5kbGUgdGhlIHJ1
ZyBwdWxsLiBBbmQgcHJvYmFibHkgd2UgbmVlZCB0byBiYWxhbmNlIGhhcm1sZXNzIG5vaXNlIGFn
YWluc3QgdGhlDQpjb2RlIGl0IHRha2VzIHRvIGJlIHF1aWV0ZXIuDQoNCnRyeV9pbml0X21vZHVs
ZV9nbG9iYWwoKSBpcyBkaWZmZXJlbnQgaW4gdGhhdCBpdCdzIGtlcm5lbCBzaWRlIGNvZGUgdGhh
dCBnZXRzDQpjb25mdXNlZCwgYnV0IEknbSBub3Qgc3VyZSBob3cgaXQgY291bGQgYmUgaGFuZGxl
ZCBpbiBhIG5vbi1yYWN5IHdheSBlaXRoZXIuDQpTby4uLiBJJ2QgdGhpbmsgdG8gbGVhdmUgaXQu
IE1heWJlIHdoYXQgd2UgcmVhbGx5IG5lZWQgaXMgYSBiaWcgYmxvY2sgY29tbWVudA0KYWJvdXQg
VERYIGVuYWJsZS9kaXNhYmxlIGxpZmVjeWNsZSBxdWlya3MuDQo=
