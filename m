Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF9421257;
	Wed, 22 Jul 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747839; cv=fail; b=e0Dh3ztRjf8D1/odpo0tBET1lhO6UZ+Skpm7iqN+zLUqc8istN+3kj4vfN85g8Q0JNtqK02DXR5tnsz1jiB4a6LtJNriyKtsQCku1ThwkUCqdpZ5bSdVJfMtq1aDoNWkRDgeyingrQYKnLWFk2E2qbYcdlcIduFyMscRaKfv4wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747839; c=relaxed/simple;
	bh=CYXOycp32D8cQF5u3rBmRDfWVqFPP+t8Jr1YLxXnsdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GWYGY1VN+R5jCNiyV8ImzUhyMexmNFjtp9iojfpzLj/3mS9db0hzKeZS3/aqdojV3ozzYQhGoAHlPDp6zYCTyW9DhsvhGnl9siZaMguYONIL9VwU/8h9lb5TmH5+NH5N9uopmTREcRMQpNoBwJ7yJIRrI2A5xpQ/m0u7QasoDAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtRp+L5A; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtRp+L5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784747836; x=1816283836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CYXOycp32D8cQF5u3rBmRDfWVqFPP+t8Jr1YLxXnsdU=;
  b=XtRp+L5AVuD9PnryspTMRgsu1ICFG7//NmaOLeGbeG1qeEHEKepR6cP6
   ZJbNx7a/P6ByuKX8ETpvo6B7fII9ysawJ1kA6rKALmHii5FIfmrFRz87U
   OkD2FgaHD+VJ1LTruNNL1dSCUa1mX20+fnshm4pBr7QgY+sxAD5LDGfS1
   Ag++kCRUnQYvkEYQR6JOMpu5ZfqndGnopgqJXWAiVPRQ1AF95+6RiO7Ub
   ykY/csHOk6od5NtgZz5SZu2wYVB4Kyf15PoX3qLs/XroXSeseGzjQ9pap
   2s/lmORq4RwZXNZ4NW87uZoM1bkgJOiC7DPhmDt25SX2xL2iTAniEJbld
   A==;
X-CSE-ConnectionGUID: K2XMinCPQCWpLM/HYg6qYQ==
X-CSE-MsgGUID: gLS2C064Qg+HAi7EVmFqbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96053434"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96053434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:17:14 -0700
X-CSE-ConnectionGUID: DDPIHji0R0SdD7vHVsAT/w==
X-CSE-MsgGUID: hEEDXh0pS2es7Yt9eu01gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="288186374"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:17:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:17:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 12:17:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ5X0H+1uVqysNyLKrwXRquhnFA+znBSNb/5W6hD9sA5kmAhw6NIVLKusWh5O/v7yzAjcymzCy1b7YbelWbagMu3bFSKcCeHs5f8D9nJ7UXqXLUIPmdD4gkNiH3nya5d2A4SFAECHrThU+TD4NWFAewe8s0AcRV3Dut5cqMKBtgLJW7YhymY/mSDySDeMd2JSHpliukc5MRkx/GcV7Mc6mi/lS1gThmG6mhwiQkdwzXaRTUOQNMS9fVeOsfdFktWuS2swVGEgvq2D+oYWKJSjZfZysHDA2WOjrUMCfQdvwtRIvZD1+wP54OQyZJQZpzFG1+2K4rSKw7vXHTAYQXmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYXOycp32D8cQF5u3rBmRDfWVqFPP+t8Jr1YLxXnsdU=;
 b=BCdLzHeBm8jKGN872bV7vElX6bearJQbELO/rfbf6i0Az0uK+Rw8DGKNcutZ6tE2AwlWQSe6lqBWcnSZ8vQ4K/BM0TXo8wSeo87EWjrciNtXtTfi4jbSTjSvvxGG9sPGeG/SPSNRW7OVEEfHr4sNvRLpQFwA0mdoVrlIayY/FNepTjzbBCYwN1XuIhww2h5r6GrpH6lvekP67cB0uO8jAc4Hm80e8MmikE2GG7VDyzlWwCcPL2T2Z1dRF2lj41TlyTdJHMXyMnKaIq/cC2L+UtjxQ1YeZG+F5WhMwJy+SPEkRTBLrJRbevFqaoTveuCwjj4kTTLQ0fpt+cv/dn73dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:17:09 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 19:17:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Wu,
 Binbin" <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZyy64AgAPW3wCAAwm/AIAAHcqAgAAI/ACAAB2fgA==
Date: Wed, 22 Jul 2026 19:17:09 +0000
Message-ID: <cd7f50e04695f259323bf460c1300a30bd09d9c9.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20260718061050.E17B01F000E9@smtp.kernel.org>
	 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
	 <amDd1Ip3XTvKSTcb@google.com>
	 <5ef176573157b595d674cfca28923d919e54ad73.camel@intel.com>
	 <amD-WjxP05qKdK-t@google.com>
In-Reply-To: <amD-WjxP05qKdK-t@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB7072:EE_
x-ms-office365-filtering-correlation-id: 9f851a46-1436-4ff6-df2e-08dee825d3c1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|10067099003|4143699003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: nx2f/8dBTmQnhaM5HWvzzoUDB5ESCaiVdBSeYIntjI/jy3OUQc/phdQ6KQKiwsOlsGKVc0j2nuYHDb1dFbXzl/A4pLhBs6u1WFNlfhGHMA0ebmJ99AEilPOrhWFOZ9BEzeNzPWrEIl78Nn9zl6T3TbT4BzX33UzOr4jAbROqJmQ+bx3zSByhpZ3olg16i8XGdkAH3ADbJfbgSWaDVFRf1hH1h87yerN9pd3rm2hZKynuJosEpIdvketT/35m5B0tXWpRVCEyE2kAveZf0tCp89BMiIAwPEm2ZRlDx+6WSQkF0/+F4Efd6rq2abLEge0z4HemRnR2RinCpdsoBElLw+KCvyC/KbO/sFqgvv3jgYrWNj4PCdclMCHD1rB4NJgfTqNqloZq88mgGn2sLw4Mqv3dLCCtoRKqQZ/3BW79d7aOXkP8/AOpCaNn5a0zlDQsDka5kMj23xdYoEaLOwfRXcieVczzVwi23XbvFRMEUaj8c2HbN+ykFFwYYa3HUuHX1jG7PAeQlaKm1n8KPHqG4scyBrZJ1LFxH125Sspx7iTgaVc4q2tVERTe76o9q6Eav8mSRPAFI+NmbK6dAiYUBS/yg9ciSClABNqmcUBvT64/swCJVXCuFRVAvAPY4sGGad+N04vDknDK9uEsUWY0RzRgbZ/ca6GROkQUU1AjrqfNc065UY9CGxPADrzu7Lk3ePDJ+5AZ8PphHHDMm4rtZlyi/YwnZxprAtqteJ3oanE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUFQNmZRaDkvMEdncHc4UnZrSzZtY1dYVlBsKythSmN3bzVPREpJbzdnOVJ3?=
 =?utf-8?B?c1BVaThLdTZXZWU5YmdjdlVLa1lTS0RxZklSNUwwZ0xsUCs1Uk5KTGJtNnRB?=
 =?utf-8?B?aklkMll5T3lITFpOUnJCcEZXbEpWWVdxZlVvSEh0UnV4UmFsR3hMUWM2TmJv?=
 =?utf-8?B?STFFeGNtNnFESUozNFVDbGNNdGZmWHhVY2xIL1VQZXNxTnJUQmRrMkdlMDFo?=
 =?utf-8?B?V0NkZHZ2RHU4aTNEWVZkS1JrS1BBNVFpam9tYVVDSlBvVGVoRk9hbWkxd0RB?=
 =?utf-8?B?RDczQmVqdUJNdnNqbjd0TFdacitKVExkcWhrMmY4Mi9BTzkyVHo5dGVYclN0?=
 =?utf-8?B?VU1BTy8xWHpQWU9pRlQrelVEUFhYMnVZQkpsM1YzQTNJb2VsRDdRU3VYb0Z6?=
 =?utf-8?B?VTZVVURaa04ydFk3OWx4SkorUHFobmRHWjJ3TEhyU0UzMnc4UEgwbkZZODZ6?=
 =?utf-8?B?eUlEeEo2NGdRczNKd0RxSThmSFVkYzFwNkgzeWt1d0tRT2RhVFZkM1JrbGc3?=
 =?utf-8?B?QVFmb0FzanJTQWR6OEJUNHZmNWpNUGhueUNFaVJXeWhXaXNMZUpjaHR3VG4r?=
 =?utf-8?B?YXpXRllsOFk4NG9CM1AyWC81ZHdyQ3JBWEtDb3VSWkY0Z0U5dk1XUGpLNlR2?=
 =?utf-8?B?eUlhWXhBK3ZLYzU4RGZPU095a3NxVnlLNStodTNZL1Mya1BXVGVwUGgwTkdt?=
 =?utf-8?B?R280OTJJbVdyc3NhY1RYQys3QWJ6bzhSYjVHbkFzZkRsd21zOE1TTG0rNjBU?=
 =?utf-8?B?bkFTSWNPTXlRZjBPZ3JieDVTLzRlcGVCSS9lUXZjWWwvK2ZSbWVIWFl4QU9R?=
 =?utf-8?B?eGlMS0ZVN2t4K2lqOFg3NzY5RHp0VnFsNEZ6Nnc5cCthOWt4SkdsN3I5aFpq?=
 =?utf-8?B?anJxV2EwNi9kbDUvK0owU2tqTHAvcUFyRjRZMzY1MzlLUkEzcE9idVdoaE5B?=
 =?utf-8?B?cXZXc3c5d2djaDR6RkUvVDN3VlVUcVQ1Z2hMbS9nQ0FydXZIU0pqS0xXeDBM?=
 =?utf-8?B?VjFGWU9jZVloNGFiVVdSenQ2bU5pZFZRdUJFNW8wSG9aTUF3cFI5MjR5Rmln?=
 =?utf-8?B?RytJUkZ5RDZ0YUZyRzdoSTA1Wk1WTGx5TFFBMFB5SlNJYS9SS0Q5d1NkNGwr?=
 =?utf-8?B?OTNKdHRzUkgrV2daQ3FENVZKRTZDMlNmM2ZMeU43NjUydGZhdXpjU25GbENW?=
 =?utf-8?B?cUVCZTh3Y25uL2hIS2NDV3JKMG9jdmdodTFuTWhMaDR3TkFxNm11cXpBZ1o2?=
 =?utf-8?B?N1lldHMyVTR2SUJud3JXSmtrQ042Wkp1Q0VoajB0bElLSFhhZlBiektmeW0v?=
 =?utf-8?B?V3h3Ni93VmF5THA5bm1QQlMreHN4R09vTkNtZUs1RkszKytGZXNvOXd6VUJm?=
 =?utf-8?B?NVAyMXJYQlB6blUxRS9LdkdSRHlXcDh0b1FlM05oKzZjNHZFYTViUnZoa2I0?=
 =?utf-8?B?TnE2azNEdHJkMjFxREJyZWgzWkI4ZVV0dkhoNnh2em83TVZXbE16ckErdjMz?=
 =?utf-8?B?NzBLSmw3YUFITlhvMHd1RmxyZnNSU0YrbnNHU1YvdmtTcmdxWEE2ZmdENm11?=
 =?utf-8?B?L05QcmNUbXZUR2llaHdmNkJHdWdVQ3lSNzBiRzhQV1lPMnFKUzhVQW9CODMx?=
 =?utf-8?B?Uk1pRzFONlk2bHdaN2E2cGUybmh3TEdxazRudEsxK04ySHJvVDhsTC9HOXpD?=
 =?utf-8?B?YjArZ2ovcTVjUEorTXJCUVVnbUpvWGhrajRZTDB0QVVqWGtHeTNNNEI4Sjg0?=
 =?utf-8?B?bzBJTmZMVUQ2ODlmUkx0MzFHQUl0MHo5SDdlZXUxUVUrM1cxNWJrR0JDRm9E?=
 =?utf-8?B?cDJGR3pGNU5DVzhKejgwTjlXMGZoN3lUWXpDSVplN200V2QxT3FVOEdEZjBF?=
 =?utf-8?B?VUc5UjZzS080NHRoOFc2MFNnTGQ1OUl2TUVKN3F6Y1NGU3pqNjd1aWQzSzJH?=
 =?utf-8?B?MXBaMXhoT0p5QXVnQkdsL0xyOW9VRG5KNGZIb3FLa1NNWTZVM2Z1WGplckRa?=
 =?utf-8?B?ZjJLZlpsNzNYOGZZQmp2cXFQRndaMVlxRjZic1EvaHFITnVmRHozRjFlVmxW?=
 =?utf-8?B?QjZMZDUvb3NkcWtlbHAveGtid2pxY0NrRlo0YWowU1hHRmlpaFJtR0tjUDdK?=
 =?utf-8?B?azBxNnNtbldPd0JOQTEyMzlCRHA0NnYrcVNPMDA5KzNBVTI0NTFtUkE3U21v?=
 =?utf-8?B?QkkxUi9WV1E0YVp3dk1lS2RUVzlTdzU0aHFOK1J0ZXZFRUtpUi8ycnVvVFF2?=
 =?utf-8?B?eFUwMjJtNzZ3TUFBTDNhMlBzWjc3WndpdVRuRkpORkN5bW9yRVg1WDdRNXBp?=
 =?utf-8?B?MEliMzVQSDNaNVR2bEdLbWtMVTlKYXZyM2RXM2JJOUlHTjdRZWh2OXhVWnMr?=
 =?utf-8?Q?V1tfkUpS9BvKpQEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11075A0F9BCB0C429D959B87CDCDD28A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qiBIv4bvi0nWwQmidFzmaiQTRTBUeB5gI9LcHwncMjBbKZELY3zZyd/ugaTyUe2byfCqzHrLgWhhWfMGEXYKxAv9NS6AZOwmDDbDARg1jqwjyviU8jtS4CFSa5F+rnn1jQPD/74HvRgR5ddUpEPDnRjzx3UdnbBI1ukPDlzEvPBeoARxxuCAzupa6ZTsWRBs/0hA2Iwv9+CDrLk2YvXnXvQwyw2poDwn0m26QJ9MBfoMRGlz3Rw0ny48OCDc44yVTzIq33+J79ykT/iiE6grumkSAou/q7t/Fzp/GNXWcksWZmokpo2zEAbDOBrVmKrpNfn3Zs/C8MjHe46Vx4a0kw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f851a46-1436-4ff6-df2e-08dee825d3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 19:17:09.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MThF5GTu7Kq0iqe121BPjxvXNZDH/9zO24GoBY6nPvEst/DH661M6IufHHKHsaWam+ipH2sLINZurxU0cH4iTRPeK+QfK9XTHqJ2Rj2HcCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDEwOjMxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEp1bCAyMiwgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBPbiBXZWQsIDIwMjYtMDctMjIgYXQgMDg6MTIgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24g
d3JvdGU6DQo+ID4gDQo+IEl0J3MgYWxyZWFkeSB0aGVyZToNCg0KRG9oLCB5ZXAuDQoNCj4gPiBP
ay4gSXMgdGhlcmUgc29tZXRoaW5nIHdlIGNhbiBhZGQgdG8gY29ubmVjdCB0aGUgc2xvdHMgbG9j
ayB0byB0aGUgcm9vdCBmcmVlaW5nPw0KPiA+IExpa2UgbWF5YmUgYSBoZWxwZXIgdG8gZW5jb2Rl
IHRoYXQgcnVsZT8gT3IgYmV0dGVyIHRvIG5vdCB3cmFwIHRoZSBkZWxpY2F0ZQ0KPiA+IGRldGFp
bHM/IEEgY29tbWVudCBpbnN0ZWFkLi4uDQo+IA0KPiBZYSwgYSBjb21tZW50Lg0KPiANCj4gTE9M
LCBoaWxhcmlvdXMuICBJIGp1c3QgZGlzY292ZXJlZCBhIChub3QgZnVsbHkgZnVuY3Rpb25hbCkg
cGF0Y2ggc2l0dGluZyBpbiBvbmUNCj4gb2YgbXkgbWFueSBicmFuY2hlcyB0aGF0IGFkZHMgdGhl
IGlzX3BhZ2VfZmF1bHRfc3RhbGUoKSBjaGVjaywgd2l0aCB0aGlzIGFzIHRoZQ0KPiBjaGFuZ2Vs
b2c6DQo+IA0KPiAgICAgS1ZNOiB4ODYvbW11OiBFbnN1cmUgcGFnZSBmYXVsdCBpc24ndCBzdGFs
ZS9vYnNvbGV0ZSB3aGVuIG1hcHBpbmcgcHJpdmF0ZSBQRk4NCj4gICAgIA0KPiAgICAgQWRkIGEg
c2FuaXR5IGNoZWNrIGluIHRoZSBoZWxwZXIgdXNlZCB0byBtYXAgcHJpdmF0ZSBwYWdlcyBpbnRv
IGEgVERYIGd1ZXN0DQo+ICAgICB0byBlbnN1cmUgS1ZNIGlzbid0IGF0dGVtcHRpbmcgdG8gbWFw
IG1lbW9yeSBpbnRvIGFuIGludmFsaWQvb2Jzb2xldGUgcm9vdC4NCj4gICAgIEl0IF9zaG91bGRf
IGJlIGltcG9zc2libGUgZm9yIHRoZSByb290IHRvIGJlIGludmFsaWQsIGFzIHRoZSBvbmx5IGZs
b3cgdGhhdA0KPiAgICAgbWFya3MgVERQIE1NVSByb290cyBhcyBpbnZhbGlkIGlzICJmYXN0IGFs
bCB6YXAiLCBhbmQgZG9pbmcgYSAiZmFzdCB6YXAiIGlzDQo+ICAgICBtdXR1YWxseSBleGNsdXNp
dmUgd2l0aCBwb3B1bGF0aW5nIFREWCBtZW1vcnkgdGhhbmtzIHRvIHNsb3RzX2xvY2sgKHRoaXMg
aXMNCj4gICAgIGFsc28gd2h5IEtWTSBkb2Vzbid0IHJldHJ5IGt2bV9tbXVfcmVsb2FkKCkpLg0K
PiAgICAgDQo+ICAgICBOb3RlLCBLVk0gd2lsbCBhbHJlYWR5IFdBUk4gb24gYW4gaW52YWxpZCBy
b290IGlmIENPTkZJR19LVk1fUFJPVkVfTU1VPXksDQo+ICAgICBidXQgdGhlIGNoZWNrIGlzIGlu
ZXhwZW5zaXZlIGNvbXBhcmVkIHRvIHRoZSBjb3N0IG9mIHBvcHVsYXRpbmcgbWVtb3J5IGludG8N
Cj4gICAgIGEgVERYIGd1ZXN0LCBhbmQgbm90IGhhdmluZyBhIGlzX3BhZ2VfZmF1bHRfc3RhbGUo
KSBjaGVjayBfbG9va3NfIHdyb25nLg0KPiANCj4gSSdsbCBtdW5nZSB0aGF0IGludG8gYSBtaW5p
LXNlcmllcyB0byBhZGQgdGhlIHNhbml0eSBjaGVja3MuICBObyBuZWVkIHRvIGhvbGQNCj4gdGhl
IEQtUEFNVCBzZXJpZXMsIEkgc2VlIHRoaXMgYXMgb3J0aG9nb25hbCBoYXJkZW5pbmcuICBJJ20g
bGVhbmluZyB0b3dhcmRzIHRoZQ0KPiAiaGF2ZSBvdXIgY2FrZSBhbmQgZWF0IGl0IHRvbyIgb3B0
aW9uIGFzIHRoZSBmaW5hbCByZXN0aW5nIHN0YXRlOg0KDQpTb3VuZHMgZ29vZCB0byBtZSwgdGhh
bmtzLiBJIHRoaW5rIFlhbiB3YXMgd29ya2luZyBvbiBhIHBhdGNoLCBidXQgaGFkbid0DQpmaW5p
c2hlZCBpdC4NCg0KPiANCj4gICAgICAgICBkbyB7DQo+ICAgICAgICAgICAgICAgICBpZiAoc2ln
bmFsX3BlbmRpbmcoY3VycmVudCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVFI7DQo+IA0KPiAgICAgICAgICAgICAgICAgaWYgKGt2bV90ZXN0X3JlcXVlc3QoS1ZNX1JF
UV9WTV9ERUFELCB2Y3B1KSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87
DQo+IA0KPiAgICAgICAgICAgICAgICAgciA9IGt2bV9tbXVfcmVsb2FkKHZjcHUpOw0KPiAgICAg
ICAgICAgICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0K
DQpJJ20gb2sgZWl0aGVyIHdheSwgYnV0IEknZCB0aGluayB0byBtYWtlIHRoZSBidWdzIGVhc2ll
ciB0byBzdXJmYWNlIHJhdGhlciB0aGFuDQpoYW5kbGUgdGhlbS4gSXQgc2VlbXMgYXQgb2RkcyB3
aXRoIGhvdyB3ZSBkaXNjdXNzZWQgS1ZNX0JVR19PTigpIGluIHRoZSBwYXN0LiBBDQpyZWFkZXIg
bWF5IGdldCB0aGUgaW1wcmVzc2lvbiB0aGF0IGt2bV9tbXVfcmVsb2FkKCkgaW5zaWRlIHRoZSBy
ZXRyeSBpcw0KcmVxdWlyZWQuDQoNCkhtbSwgZG9lcyB0aGUgbmV3IHBhcmFkaWdtIG9mIEFJIGZp
bmRpbmcgYW5jaWVudCBsdXJraW5nIGJ1Z3MgdGlsdCB0aGUNCnNhZmV0eS9taW5pbWFsaXNtIGJh
bGFuY2U/DQoNCj4gDQo+ICAgICAgICAgICAgICAgICByID0gbW11X3RvcHVwX21lbW9yeV9jYWNo
ZXModmNwdSwgZmFsc2UpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByOw0KPiANCj4gICAgICAgICAgICAgICAgIGNvbmRfcmVzY2hl
ZCgpOw0KPiANCj4gICAgICAgICAgICAgICAgIGd1YXJkKHJlYWRfbG9jaykoJmt2bS0+bW11X2xv
Y2spOw0KPiANCj4gCQkvKiBDb21tZW50IGdvZXMgaGVyZS4gKi8NCj4gICAgICAgICAgICAgICAg
IFdBUk5fT05fT05DRShrdm1fdGVzdF9yZXF1ZXN0KEtWTV9SRVFfTU1VX0ZSRUVfT0JTT0xFVEVf
Uk9PVFMsIHZjcHUpKTsNCj4gDQo+ICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAg
ICAgICogU25hcHNob3QgdGhlIGludmFsaWRhdGlvbiBzZXF1ZW5jZSBjb3VudGVyIGFmdGVyIGFj
cXVpcmluZw0KPiAgICAgICAgICAgICAgICAgICogbW11X2xvY2ssIGFzIGd1ZXN0X21lbWZkIGd1
YXJhbnRlZXMgdGhlIHZhbGlkaXR5IG9mIHRoZSBwZm4sDQo+ICAgICAgICAgICAgICAgICAgKiBp
LmUuIGFueSBjb25jdXJyZW50IGludmFsaWRhdGlvbnMgYXJlIGd1YXJhbnRlZWQgdG8gYmUNCj4g
ICAgICAgICAgICAgICAgICAqIGlycmVsZXZhbnQuDQo+ICAgICAgICAgICAgICAgICAgKi8NCj4g
ICAgICAgICAgICAgICAgIGZhdWx0Lm1tdV9zZXEgPSB2Y3B1LT5rdm0tPm1tdV9pbnZhbGlkYXRl
X3NlcTsNCj4gICAgICAgICAgICAgICAgIGlmIChpc19wYWdlX2ZhdWx0X3N0YWxlKHZjcHUsICZm
YXVsdCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gICAgICAg
ICAgICAgICAgIHIgPSBrdm1fdGRwX21tdV9tYXAodmNwdSwgJmZhdWx0KTsNCj4gICAgICAgICB9
IHdoaWxlIChyID09IFJFVF9QRl9SRVRSWSk7DQoNCg==
