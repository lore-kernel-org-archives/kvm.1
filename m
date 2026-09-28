Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738C3803E8;
	Mon, 28 Sep 2026 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619831; cv=fail; b=F3pl9CAyI/Ml8f+ebIu9RZ+jeQt/YK2EJz+pPbKNygkwTasQUP8ti86IvHCaIUchkDCOZg91HJ3c/DA7ap5sgDX+95mVsJdqO7cfG5gafrvIpem8vV33wHl8bQ7bASdRoMGRfZgt1eutaDkP6V7fn5w5s/Q6wvRePkW52RJ78PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619831; c=relaxed/simple;
	bh=PtukrGRxvmwGDW9l+x2GD7utIb3vc58PpwzJAqm3H+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThoGp7eJYlraNaXpUob0Bzn+tJm5yOKVosHYBAv/g/Me7D2rgW7DRESQYyLEaHp0nGmwc0nxMKe7SGuOfc/YMsqTAGa9elXeYSdL/AsOaYzeflDA9M+8+CnF2H8PUH9GTLFAwpTVBtlmvZcgwy4VTP4Kmo7c8DnJqSR8Sfemhsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHAVp88T; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHAVp88T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790619831; x=1822155831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PtukrGRxvmwGDW9l+x2GD7utIb3vc58PpwzJAqm3H+Q=;
  b=cHAVp88TDD3Gx+hoIzhiyDIOfqjYcEfHCQji9nEvJBgWMHHEwhMRonqP
   3HcKojPwF1BpUcqYaxGu2mYVNBeG1U+QNzMuGcX5JkadGOebhAKPaVXG8
   SvfPoCbB79a5JCcqZ6cPVONLkjD5CNQ1vHMO+fcUGEi7JrKH5xtlXhJJK
   Sz2YWi3QeP1v29EkOxJ9bL5mbNB63GGJVrV4Xi2Mb2SRRLmkOls2k8ejm
   07YQp2x3N2No4DaCg7d693zzHF+7IQ9Bd/xS/dItzseK7pHZ2WYBiF5ir
   dpfO2Fxq+JgRnZ4+6EcMFOPx/v8fL9FyzwOWtJY4TiBci8QX2MwY9mbXn
   g==;
X-CSE-ConnectionGUID: JpZ52pGaQ6qHdrfDRwKmYw==
X-CSE-MsgGUID: GG1GuuL2THup3wt7HpmVIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90194385"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90194385"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:23:50 -0700
X-CSE-ConnectionGUID: dfdsKwWvSf+v7PgCtyanPQ==
X-CSE-MsgGUID: PGb+kN9dRyO4OtJykjegew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="273736473"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:23:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:23:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 11:23:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlK9SqhvX5F73c5U/nnKtVxAmTKlv/Ic7j2+V1E6v1QrbAx9k5lcSQTIBZLLGuCOrqubRjj7mWaZ+Mxrlo1BUuNYdAoia31fz52Ayqi/L8wz131pdNQOMiqfLDUdfJRnX0wih692wskB6YQQDdcaLXUwDOg6jKQkVYSW5de3U8xjKsXYtUYhiaFkoScw18DW9Ug+T1YsLF3JNZBpkr4CyUIsiD4tR36IkdrR/WH22f4ycyKRP6kFrvvFTKdIsrQvylmo1jUhOOnP2hsAf7aZk6Qxep+rAt6gw2eDlPopXpVAe5ArP4lDVe/RAs3oaqgTTZdx6rpXsShzHwT/PR9gGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtukrGRxvmwGDW9l+x2GD7utIb3vc58PpwzJAqm3H+Q=;
 b=zDfwtrTvc61Gdla6vAbidCmi52gBTt8n6Uf9/oY7trZ4CctJhMH4UkMamZZGFOQIXy3A3J2kVoFaXgTRo2JqYtBzedqDF3u39sphtzz2lss4zCx3JZwWjrv9/EPeYZY5Sigis85YeUVwySiI3dTpXswJznr+PKNYx5MfaRNZbMQKUgdA0/0AAMpBCYW3D9vvf2Ol0oj0bcBWBTp2/TjVvaKMlZ5cwHnoS07ET5aQROUiWQvK8uzXCn3pU6RB65dUx4hyA6Jfct7P3/OEwkQRrCr5bgFKtiZRlL6sAL+cnVx/ny5YJnCEojR/XlOe6UQhnm5+Ol/TP2a4uXfHjdvpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 18:23:44 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 18:23:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote buffer
 size
Thread-Topic: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Thread-Index: AQHdTzGrpyv2GJzwpkGpI0tjfVPUWLbkTpaA
Date: Mon, 28 Sep 2026 18:23:42 +0000
Message-ID: <27febde6bbd1142222f0a21db4e5180e0bd3261c.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-5-peter.fang@intel.com>
In-Reply-To: <20260928100913.2265687-5-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW5PR11MB5883:EE_
x-ms-office365-filtering-correlation-id: 93d244ba-3caa-4542-7ec0-08df1d8da099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: AC7Erw0so4wjRw6lWD9PZ9xZqE+yDKaaaqThaDSJQa5FaXMZBCRGhUmZec/x/Dv82Qq0uSWZiVvrlsJ9cNAvm/xlrV7O5Ru2s8pHTs2YfWLHZPpSMEBYNXM8kDZqgRaCQLJ3Fic15k0rqQu7nLvAIe6mtohJrRE3WGQALaLwbPgU7B33F+MRq6PQXv+Q1Rr9cG8OsDNiFfPtGJX1D3RIAftXnKyX7N9mmn9tfYr8hpZzsz7j7Xyfw2AbJpzP4DtrYOkk771URhJ4Vi8i2MlW6RwXMId3tUSMqVek1qt/acgvGIzfXkWBJAUTtfQuFB438YQ9dPxdgshVF+nShGwWmwevITOeyVvjfhiTnNCtWGxYerJtURqkP38VIwf+vZEL62PbDIYvhLR+/yg75lLlOi7n1/fHqNnMQuLPbgLg4IK+LWSe/so1cK13QTUQwwFggNkD2+UrMReESnn+3suv3uUbi1alOIDqLyZNvMiQRyOh8BOUwj+OCjp/p4WAhVcxrj+5bYbc1b6Zshj1VRpRdKPUkWH5Dq4Nd5TXWCngI0uuJQ1vNbaHWfUr1e+BYWycOgd4wUJBjcxmwzWSnUom9gn5HYh+HsqTCI9AIiFMY8oyX4rVfOJuL+xEg3VT7EbgRHBMwGwS1pZOEIWVZmQ0azP6JR5c7eqX2zcVdfIFYHZJAi6lSY44BdlBekTGafARjBpEKUQSs6oVHVp58ljfp+rxN399G1dWOX6aQGwyP0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG5ibTRQL09YVDIrK1NiRk9LR0FvV1gyUCtsb3NUakxYY3hxM3Z1RlVhcDJG?=
 =?utf-8?B?NENZTlBrZC9TMTdEVHJEL1Z4RHVDSnlZa21OTzNFY0RZMk1PNkZsaXpiVWUy?=
 =?utf-8?B?YitxeDZRNWd4bGxrRVhsL0swdXR3b1Y5L2h6anVBZ1FKZWcvK1JNbWtPNDUx?=
 =?utf-8?B?YTVQSXZQUDJMSk9TVmZwaWVIQ3FjemkxbU0wU3dOWEtPOFQ2TmFsK0RwaDdl?=
 =?utf-8?B?dlljdWQ0QkQ3SFovaTNWTFBEdWJqOUdQSGhZTVNqR2FmU1FBajV0UEwvYVlG?=
 =?utf-8?B?bnN5WTZBTXg2cEdjaTJGdE9LNTNQOFhjQ0RaZFlwL0pTeGN0WU5XUzhYb0dT?=
 =?utf-8?B?b1NjcWk0cll1RjBpcUhSUjFMekpQbmFvK3BBb1FZUXovYUVIeXNEUm4zK3JR?=
 =?utf-8?B?Wm0veHJuMFg4VnQ0cEYwQi91cEJuUGlEMG5hcWg2Q01kcWRXSm11TTZaZnNy?=
 =?utf-8?B?cHdCdkRxenZ6QjI4TE5YTFlTUkhuZ1c5YXdQM2NyRnV2aXd0TTM2eWp5M25V?=
 =?utf-8?B?OEEvTVhkNkxqMVhPZnpsTmx1eXdqNHNOalY0WnVPOTY1cEF0bUh0Rmw4SHpk?=
 =?utf-8?B?azZ1NytaU2dMemF6VUJmemI4VSs2YVFYdGgwTitrMDdkeVZwUVRBdWkwb0Vo?=
 =?utf-8?B?V2E1NitSQWxKMnQwTFJBaXoxZ0UvdUZ3N3RYMyswR2hVUVlIelgxRzhqSlZz?=
 =?utf-8?B?UUhxRzMrazFjcURoZ1hqZ3MrUDZNOUtyVXkraXlOQVQ0cE85Q0R5bTRVVmVv?=
 =?utf-8?B?N1kzWmpnSjdVdjRmK3B2VHBpQnNwcEQwU2pNaU85SEFrRG5pdWZMeExDaTlo?=
 =?utf-8?B?dGNsR1ZZaXp6VXp3QStTNmJIVEU5eUtLNXQ2ZnFGZTNOWFQvY1FkVzVCZklx?=
 =?utf-8?B?RklOeTMzUUNEUlZObG15QnA0R2JDT1dITmttdjg2Zm84QTI2OXMzZXNVaEtr?=
 =?utf-8?B?N1AvbEVETE9sSCtkaVlmTG5jRS9UMmV3MVB0eXZUVkFNeFpUWnhhd3B2SXpy?=
 =?utf-8?B?RWswanUxNjFndytTVXZCTnUzcDhTUk0wRWZNeDRRZnJJY0t5NU1TK0dLT3Zy?=
 =?utf-8?B?Vy81WllkVFRvSWc5UjZob3dyZ1RWMEQwSmZIczBEUFU3NS9LWjNuNkNyMnZJ?=
 =?utf-8?B?SUZOYlBrc0Y2YmdPMDRWMXU5UXRhQ01qZi8zeTErWjZWWGRzdG9WanlRZmN4?=
 =?utf-8?B?Q2tMZFI3aFNqQnZ0bFBDajBvV0tmRUxaYTJzdkU1MjdHM0FwQ2VIWVdsSXB4?=
 =?utf-8?B?ZzR4amZsYnFlL2VXVFVRcXVtVUE0d1o2b1VoYXBFNTRRZDV5ZHJidWswZEtK?=
 =?utf-8?B?bG5yRVFjWCtFcW1LcXpOVlhzTW5SYnBmUE1kZ0lzK2U5aHFzeGk1bGhxL1pP?=
 =?utf-8?B?MTZGekViQVE5aUFnUDQ0RFJWOFJqZU5rNnNaTzlKY1dmbzdYaVFlTkZPYU9t?=
 =?utf-8?B?dUdGVmFXNUxpWE9TUG5rLzdxd2JIdm1keU1UZ3p6YkgwV1ptSkRpd09ya0Fh?=
 =?utf-8?B?U2hFT21XKzk4MGxTSDNHNnFpK0ZKVE1EOXpwYWVpYlJnV3E2Y2lHRE0yK0FF?=
 =?utf-8?B?d0JuRGhQL0lvMjR6UXZrY1poc2Z5VzlZNGNTK094enNrcVoxekErMXJlSXVU?=
 =?utf-8?B?cVdrTE1KczVoTmZFYXp6YzFHMEFQZllKWnN5U3htZDJFOTFDYTJublc5bDU3?=
 =?utf-8?B?R1lXcU85U1d2Zml1UjhEMVVuQlRpRXBKb1doVGpYczI3VjM0U2RwTFA4Vit0?=
 =?utf-8?B?Tm5iUmZLVG1xN1J6RHNxZmk0YnNGQW1JdW00U2llZUxGWncxbzZYZlRJcGhq?=
 =?utf-8?B?bmZNcGZ3eURXZzRYM0trV0EwdjR6MFNueGlCaGw4TUJWYzdaRW5oU0pYWDl3?=
 =?utf-8?B?ajdCZk0xeDZRYVVWMHR6OXB5SXhxSjRMNjg1OFc1aHpFWEp2TEZPMnVCMEND?=
 =?utf-8?B?MWtsdUZsc2RVb2VKdkl4ZDArZ1ZNQTJkcllGZHZvT09JWXFoOHB1Z2k1bEh6?=
 =?utf-8?B?TERYckVhcE1BRWhEVzIwaFFUc3h2RVM2NkJnd1E4Qk15Vlh3VXVIREk5REl3?=
 =?utf-8?B?SG5FUzI3bkY0azlnQkNnbDRhb1VDYmZ2NDhrWEJyUnI5bGxvV09sNytFZnhk?=
 =?utf-8?B?UjVHVVV3OTltbThrZGNkMGNweElJZ3BNWjhYall3djdaVG9oYTBna1BuSzZO?=
 =?utf-8?B?RDZ2WDN0L2hXMkwxa0FIOHVEK3NrN0oxdFMvVmU1eXMzK2VJcXEySVhJMjRz?=
 =?utf-8?B?NlphSzRFUk1GTUVReUZGaXUrVEtkRWNvVHlxTjAyKzdqYkJROWoyUzVjWmRB?=
 =?utf-8?B?aHhRcDN4MlMrbFJGTHFDUU1mUHBoLzhVZjVKSzNtM3ZBNmFRWjgvTjkyRVow?=
 =?utf-8?Q?JN4zltIZZldd7UXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71AB6F5214BB84FAD6DDBE9969CBD65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: adflb63h6cQ0Oyk8+blmVpMhz0ClbTeaFPbV/Eo9daVWNNlzk9jjsV9Fe+mLjgknSOO3IQGvPgHfL8qGwf2GnQs1VjPO3H5ZFdupKeuhD6WR+CuhXFWG+4XxaYMZPuyWRwKafpKzZ2/VTtiSSvK5UvZ6S+T5YAfXte+iQ2pqLe/uk6gfdFFuQC5+XKCXcf/LGa1ksADEaAdXCmx9/kpac74ARUAfY5z4+BunCYhJMu/FtKQCB5xvg65yxdmxb6w/cNuClW2i3x5h62uBkChhD0Xh1G/topB/vinA8csKdXycQsjjxavws+jDm69yMg+fV/fTv6RXAyAOdTqvcxbuJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d244ba-3caa-4542-7ec0-08df1d8da099
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 18:23:42.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ar3Wtq3t6pwMO+LYo5uDtE9icx2VUzr9fzIFjTl9/EbTVCxQ2RQfWEWIMne4hBgvcD5LwjTz+gzDVABV8B20fjsy6QkjyitgPbOWA1Sbxxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDAzOjA4IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiAr
c3RhdGljIHNpemVfdCBnZXRfcXVvdGVfYnVmX3NpemUodm9pZCkNCj4gK3sNCj4gKwlzdGF0aWMg
c2l6ZV90IHF1b3RlX2J1Zl9zaXplOw0KPiArDQo+ICsJaWYgKHF1b3RlX2J1Zl9zaXplKQ0KPiAr
CQlyZXR1cm4gcXVvdGVfYnVmX3NpemU7DQo+ICsNCj4gKwlxdW90ZV9idWZfc2l6ZSA9IFBBR0Vf
QUxJR04oVERYX0RFRkFVTFRfUVVPVEVfU0laRSk7DQo+ICsNCj4gKwlyZXR1cm4gcXVvdGVfYnVm
X3NpemU7DQo+ICt9DQo+ICsNCg0KVGhpcyBtYWtlcyBubyBzZW5zZSwgYXQgdGhlIHBvaW50IG9m
IHRoaXMgcGF0Y2guIEl0IGxhemlseSBzZXRzIGEgZ2xvYmFsIHRvIGENCmNvbnN0YW50IHZhbHVl
LiBGdW5jdGlvbiBzY29wZWQgc3RhdGljIGlzIGFsc28gd2VpcmQuDQoNCkkgdGhpbmsgeW91IGFy
ZSBkb2luZyBpdCB0aGlzIHdheSBzbyB0aGF0IGxhdGVyIHlvdSBjYW4gcGx1ZyBpbiB0aGUgZHlu
YW1pYw0KcmVhZC4gQnV0IGxhdGVyIGl0IHN0aWxsIGRvZXNuJ3QgbWFrZSBzZW5zZSB3aHkgdG8g
bGF6aWx5IGZldGNoIGl0LiBXaHkgbm90IGp1c3QNCnJlYWQgaXQgaW4gdGhlIHRkeF9ndWVzdF9p
bml0KCkgdG8gYSBnbG9iYWw/IElmIHRoZSByZWFkIGZhaWxzLCBzZXQgdG8NClREWF9ERUZBVUxU
X1FVT1RFX1NJWkUuIFRoZW4geW91IGFyZSBkb25lLiBBbGwgY2FsbGVycyBvZiB0ZHhfZ3Vlc3Rf
aW5pdCgpIGp1c3QNCnJlZmVyIHRvIHRoZSBnbG9iYWwuIFdoeSBub3Q/DQo=
