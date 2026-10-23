Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792720880;
	b=cBI1t8scEuOrfev6sGSioW4qqxD5wak/sMXrVbNFwGqadRf80CgQz9MpjRnYqh4EUr7y
	 PmPYHRgiM/5UJ4KALHPZdQWLbHxR9/eFEzBVjnAdNFM+AHp3+xDz2xCkrXJTcgMYqFknn
	 vnNp9kfebwVehKChb/XU9BfB/9lQq1ZXR32TBtoix+CCMn2tq4EuP/eiwke5jf3nK4Azx
	 wwM4ebNltCZKHizN2E5JLy8ONKjy5hiDFXh1Smd2DKyaSN5NTDVBGOHsP3zJTnO/ztzwy
	 g6vdWjAU+tFT9QM80Q+doyrfh9N4l8waWMf8Z7OxQSC6PK13SpeWwKrChTksmOgQ8QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720880;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=XFOHaAFWx+4BnsCOOqILfrw8drVUSzvbYJbXT0Vh0No=;
	b=XR6lI4AkXFLYGMT9opuK2Bk7HV51Pi7/c0DYATIhdpBuHu9R94/wENFEeBlaYgGGmDdu
	 M8/v42ca83UsEe+DN6zVsYDu6LhSNlCpML0512SHqQNGNYnkxideBR1UlYOQeAfDVec8g
	 Xw7OPGuIxcxw1KQKOTPmFc5gxNiJrW32FhUFZhoDdy6BFLVqq3fuEwk7+NzLbrUdfI0bV
	 kEHCNcnOZZicLriioLimV2ycCCg4/lsYJ54siJkraouQHByWQn9WHh/AhETfyYDX43gS2
	 EGXLjPH3BlQje7TncrUAAOYnCSVcQLptLXg/OVN5TSZhdedKDqyJdNCRzIH/jud39FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pi0EfVbp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B237606A31A;
	Fri, 23 Oct 2026 02:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B237606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pi0EfVbp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792720879; x=1824256879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XFOHaAFWx+4BnsCOOqILfrw8drVUSzvbYJbXT0Vh0No=;
  b=Pi0EfVbpUoWMqZjS2uSVBUOliv+XKMKqIVOiJeiqdrD4tI3N+8rKut3x
   gGsjDT0urZI0Yq8ffoOp9QKlPkTdrxnhdbrqUb/SvQgvXIyvJojRjZ73A
   WIIVqijz8qMBGnvFNTygkdv7+R9/7K+RHSmHFYjdCGWdz8eq62o48r42q
   Ix98ooVtt+IEuLfosIq62r7VAD/Odd3/22Ss1quaQNiRiBKZO3bgK4PJK
   hhQXPjFgoM80LRcwh6KN1NMKDq/1GZBPPV4mhX1MXoOeyfrrLYDiSyeFW
   6CNMCXuGdB+euP9XGYAT9CDbDOV1Is9o7EF0yytfJ2WykhPLPGvNx0D+d
   w==;
X-CSE-ConnectionGUID: jf4Hhrf1S0CaTyMvojJPYg==
X-CSE-MsgGUID: ClNJAoddSFG5W+mVwNtDdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1382796"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1382796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:01:18 -0700
X-CSE-ConnectionGUID: 3l4kJLv/R0mWx1hyKXpnuA==
X-CSE-MsgGUID: vMwNaY3tTj2o+gjrhnQIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3991066"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 19:01:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:01:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 19:01:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 19:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUO5oaR+DNUcIx0Dcd9/C2XvLC8Yh9hS0lEBGxAbb/8laJzJrodRS4jO/p5g5PpbcYbQlNSicyggOX552+VZ0FWDiu8GmYlDToc3hzLd0IwezFLzrt7p7uOcLn7sSwFeVMe1WiOKx6mbkH2pss1Uusijq2haoFyCzYv8sPOLYcuUzuGwDXe6omo0TuE23dtBopXLzvnAXvqIT0tl5HKBN7GU6uOs5wGNTVCADcjrGlaGCCNnhZhxxl16IPJ+4FwNM9ddCjNHtf9CvSRPoHFKGiKAKqpi5umRRG9JLgyXhQjHi26LCYRV+jFs3VabLElzxxwwcS2UtNcBChz3LfY63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFOHaAFWx+4BnsCOOqILfrw8drVUSzvbYJbXT0Vh0No=;
 b=zRtEcqNeUP2kpe1q0iT6TmCcXnmVuczxnyGY/IkRE7zC9/mt6F8Gj2C9DDg6tG8W73sMEq38zLxdj87DOxRxnKQ3F068kOaoaBbDj2Bz6EgG7UTJ3sxxdQ3E6yGgSMcRYukU2EHNrDyHhJrpz9Q3lEjZBadJLswp4ohbQSLa0zVqJY9lkPNGPEbE9UmPBNrmOrEs/AWvCcv/awtvqH3znZoCKW7ymy+q1qSB68WXQ8VK3rhc60n/6Sh0+VeB5Wun+8Fw8eJ1G5y0/L14fo+Hi4a3IWDyWMEgVx7QjJM5qiG7g5LLx3ZMkMol6OdeNoN5RRyVNjxZBG1dQxe5NRiEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SJ2PR11MB8297.namprd11.prod.outlook.com
 (2603:10b6:a03:539::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 02:01:13 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:01:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "changyuanl@google.com" <changyuanl@google.com>
Subject: Re: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
Thread-Topic: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
Thread-Index: AQHdYmiRF0WilxtwJEaPaKwHY3ykwLcKVemAgAAKBwA=
Date: Fri, 23 Oct 2026 02:01:13 +0000
Message-ID: <982b006a692379d0fb9f6ad39bd8dee807d25a61.camel@intel.com>
References: <20261022210134.612848-1-seanjc@google.com>
	 <16fe7eac87e2b29fbf353b05916c4a92033f8079.camel@intel.com>
In-Reply-To: <16fe7eac87e2b29fbf353b05916c4a92033f8079.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SJ2PR11MB8297:EE_
x-ms-office365-filtering-correlation-id: 0d75ace5-0c56-460e-490c-08df30a98417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: /DOgLDhn3P17NmQQLFfjZHGZ4xHTJ1ijFAORe/3jnSas3W8dKtJUAfBpqvVmiSmYUC7Imvwh2Uyq9YRtKi+b7XsvEUTylUXK5u1a7muih2FRTr/cPflEXbzuovJXQzGL+CaNHFQIbmsY/Dn2OZ6ukk571N8VuaszWG1lUB61PHLH8HDJNQIOkoLVBS6HroEhlWnYntlBOxfyu+3Fl7r/X4HyT4W8uf8WUIhJEU7TupVcqhOyMkOrRuSvGU38qg3BFPsBfo0jdPTH9XsrCLGeXiLRcgTT7Jl2QKPopYTLMg/ehV17qXiJ+mJk4Hl0l0XBs7Qt+J4Nu5W8KatmS0uGGjv8V7Sd3MMerYZlt1/V2i3p+s9ziaYTS/jZLdHt5rl0JDqP5j80yr9W9rNDNSjzBfpYEGLdjEw0g2Lqz4MLbjIaGzzMmBwXZaJCbsX+QPa766JtOkwSsY/WXpgLD7IJX+vCIwAOe+rVqJ37NaC29SSTWM65a4HcpHxuSa9a2pobdWF2BRHbWuGyOSQ6XMBex5cnaRWV95s/TXNoyG5OVU/1GUalHnag+IgVz7SHR8GHxipqB3Tk+CDH4ro3LfTFJRLKtoKu/ftrWxsq4lxjZ8vuW3krzPaxq0JKsVUmwtAGx3Z3NVYYlokebRQlgMgJnRwUC5vMZ1oe9lK2Zi7cuJ2fbQY+xIkeIQDAq+T/uw9MUg9Gw2HhNnF+Bk+iDBFcPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnZZVksxT215b2F6RVVSSG5naDhic3grbW1xZlBUeEtPOEJWdkpWQVorYndK?=
 =?utf-8?B?a2t6M09XZHZSczZacVdlV1FTakNvRFVuaEcrS2w1dG5FWDd2eUNDaUtPNFpL?=
 =?utf-8?B?dG5qRk9STitPNGxMdzNuaDliM2NUa2RpMFZKRjRmeTFKc2lScmYwV3lKeXN3?=
 =?utf-8?B?c1JSMmlmM3BWaWQvQnNDWHpZVWFqZDh4K3JuMU1kd05haHA3RXR4bE9PSHJO?=
 =?utf-8?B?dDRHV3AxOVZ6b2gwc3JCOTR4ekZQb0tmR29aVzZPQVF1Y1ZnUUVYWXJTTnlk?=
 =?utf-8?B?VVpCejRHNVl0a0c1V0xUMS9hbzg1cmhNL1Q3ZGhTOHYyU2g0eHE1SnJDS1ZK?=
 =?utf-8?B?a0NJYjZiRW5EcW05MWFWeGVJSjBsbnVkMjJOc3ZRNTRsSmJzakx2b1U3L203?=
 =?utf-8?B?UzVtVXhwSUVPdVhrVGxhWVNqdW5NalBUNWw1T2xvMkdaNDhZT3NpTEtBSi9R?=
 =?utf-8?B?MFZiWlo4UTZvY3doTjNBRHhBZjI5NStLRmlySjFiWk1hc2tmVURZSE1ra0VT?=
 =?utf-8?B?aElweE9IQ0xvVVpnZm5laU1OY1dwRUxxK3ZJZTJkT0RwWHdFeXFjMGlmYkdv?=
 =?utf-8?B?SFRvSEV5d0YzT1ZOTGwzRnlkTnk1OUJXemhSblBsdmtnRlRIOWMvNjJxOEdG?=
 =?utf-8?B?WDNVVjUydHJsdTVnNGp1bVhYVDhubkJJUVdzQVArOWl1RUpNOTJsTFExdHNC?=
 =?utf-8?B?b2dFcDRqamJubWh6dFRYVDNwd0UxaVl5c1lMVU9KVWNuSE9MdmlsZHZ1blAy?=
 =?utf-8?B?N2JqOEw5NzUzQmRxakloajFzU3lJWE1tSUtaV01GZE5GaE9WSG9GNkZpeUlE?=
 =?utf-8?B?N1B2c25qM2Z3STU4Y0tJOGZtWm1KVHFGcTRzeERrc1duSmY4MTRzY2twWlBo?=
 =?utf-8?B?Z0EyeHpOL1pnYjRIV3F0Q240NWZvRms1d0VuUHhURllITzc3bkVWcHE0dWNM?=
 =?utf-8?B?TU04TTdET0REdmV2R3JHaHV4eDI2d1d2T3U3VW9ncjJNdUhtMWtFOWZvbGpw?=
 =?utf-8?B?emE4RnhGRHJmMjhndThjUGRXSnhYeXovWmttQllLSEhuU1lSMjRoczNrS1hk?=
 =?utf-8?B?VmdWR0c5UXhpWUVTZ0MyaDdscFN4c1FhY3drT0F0VmhFN29hcjFvYnVXQkdx?=
 =?utf-8?B?QlRMR3dFTmp3U0h6aHpkSndOL0h2NkQxTXJZRDN6aTNIbmsvOVM3K3JSajh4?=
 =?utf-8?B?UzU4K2RhZWpnME9aaDhYcDlQeTc0WHZKTHQxMDc2NmdRdmUrVUhlOU1oa1JC?=
 =?utf-8?B?UTFPTUZ3ZUd5bmkzdEExUjE0WlNjSisrQWxxc2FsSkJUZE5iMFd0VGcyMnpF?=
 =?utf-8?B?NjI2aEtWMllQNnFMd1ZtTnlZZzJvNnhYa2tvR0pwWUZ1elEzeEdCUmVhOC9I?=
 =?utf-8?B?MFJUdU9wKzlIcjNEUUh3bUJGdzNTdG5OdHczaEtTWEFDSmNoaEc0YjVzMU94?=
 =?utf-8?B?NExDVWxtbisyYmJxYjJNcEIydVprUmpOTDBFbU93Vy9JK3A2WkFmd0Q5YjR3?=
 =?utf-8?B?d2pETy9jTkhwUE9vK1hKWVR1ak9QVW5LVk5FV2xLTC9kd2xxeVdsQjNaOWlU?=
 =?utf-8?B?V1JPQWVpY0pvZ3VFRk1oa1lKc0lCK3dDWFMrMGhXSzBnZmlhM0xVSFdiNVB2?=
 =?utf-8?B?eTVGbUYxbVA2bzZURHpEYzdIQTBId1ZhZVRsR3dtdC9yQWJlaThhWW9Uc2hq?=
 =?utf-8?B?UnRMYVpyLzZ5aXdsS3F3LzlNRnhBV0MzdklKQXFCVkRIWXFjTkduSExWZG4y?=
 =?utf-8?B?ZHgwT0FwMGhhQlA0WkRqTXFYajRYTHBjRStmUWxCbGwwY2Vod2x4N0hsK0R2?=
 =?utf-8?B?UTJta1BJUEl4YU1KQzNRSVdybVYrZ0E4SHFFSjNpalVKWUhqTkQ4dUFVT3ht?=
 =?utf-8?B?WTdEVmdDMkFxekdybmhDbFZuY2FJbzZERGhYbWFSd0RJempZa1kzWGNpUVlP?=
 =?utf-8?B?OC82MTM0QTBIZ3BscUZmdnE1eTJVQnZFRlBCaE9pQms5bXl1UFNtUlNiMER5?=
 =?utf-8?B?VzBkNzhJaTh0NmJnM3Uzc3dBa0lJMTNWanJZTkRtR3JpSnlpU0xQNllONGE3?=
 =?utf-8?B?VjZnZjllUktrUnZVaFA2dVBrNTlqbytibDRzYVR6YTZ6ZU4wN0lmaGV6ZVlT?=
 =?utf-8?B?TFBaUU52VXJPTCtnMWJWTTJ3eUk3VVluNXBQc3ZWRGR2cEtRNW10Qk1TSnk0?=
 =?utf-8?B?UmhuSGpuay9UUStIYU5XUTZUNmhXenhJd3R4M013a1pzM3lXa0lsN05VS1Ns?=
 =?utf-8?B?QVRJVEtidWtnQnprWnp6eG1Kd01ZMlQ0UkNkQkVMYVBJbmp3NzlaUGgxQ3NF?=
 =?utf-8?B?VFd3dFo3azVMS0EvUU52cDVXQzJab2pMekJxd2tzcjRRY2JJKzBrL0NzZk9I?=
 =?utf-8?Q?2ebKx4ifWreT68bo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F18CFBE746D104FA4D5B9EE67676DBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UA4R3g4zx/b/jbYI4+6aG9co4rUiHh3S6zD927dy9mYc2HQKhMYH6RHkMIT7WiCICVj6xGjUdS17UXjByPolJwwxstWTgzTyr0cGK6DyxgpHzYb7RVfXu4gWQ/CbS0p/BnDqGjm5nO9QUbMkoj37gHo4/HWJfJdlxjyNjsL3QMtL4V0gp5vFHtpkeu0PzoYVh16c6nwd5YG1tIhW9dQbczAmQR2ll0pDrjKmUfteiej+gu9guqqLm507xtgnVsiY75pjI1kaeO4VXH15LT0TcT5W/euyOMGaM/4eDG60m/J9RCUOrqw04LSGCBAz/nYjrRkj28+ZUiUIRnXwhjFNbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d75ace5-0c56-460e-490c-08df30a98417
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:01:13.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXehKx/IAuI4/PAaIKJ630SftrAb5OCwJJ4MNR2zsGv2lFzdXuBncdXLvfixVcAiPeWcrPiRkfk1ZWYj/xV4Uj9qNF3jSMLaS3kojhEWW6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE4OjI1IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gUmFuIGl0IHRocm91Z2ggb3VyIGF1dG9tYXRlZCB0ZXN0czoNCj4gDQo+IFRlc3RlZC1ieTog
UmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KDQpBbmQ6DQoNClJl
dmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
