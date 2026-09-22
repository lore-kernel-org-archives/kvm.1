Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9B485932;
	Tue, 22 Sep 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101111; cv=fail; b=E/ANdm6o9uW/mOfNojiTEucF6J0J5xpcfiC8PjN1/vX3WfGpyciYIbsxBCwdGnh8LPwhv07FNeL950TPCpnkB3dBfl7/cYrbiQXYhT0FXIxCfVfsDELWMH/qxN3XlyLKeV6MB3oGu+Nfi1+VRfTErVLXZFc1sCnHwp/ubGrSECE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101111; c=relaxed/simple;
	bh=nJXeJ1fk39OVn6Ur1iQ6TP6CfB55If+K+2Dz9ddv2tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dv4ZeXf1ZyYsInnZBMrYpfcfJbEd/8lMXzGEEwAr52OsQ1NwykOJGmOXjvoKfYA2gdqdPKa791ikB6sj3putA/hP2ZUqoQm5lgSZm7R3j1pUYCByiJsJJLvMVlOOr2A4agAIoIZUIJ7JKy6QNWjDHO/EU12tYcyJUj/czeQRcHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfqeSALJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfqeSALJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790101109; x=1821637109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJXeJ1fk39OVn6Ur1iQ6TP6CfB55If+K+2Dz9ddv2tc=;
  b=AfqeSALJlRDX5y0AfObrFShkqvtCtjHCd3V+8vdfFDFmTHySVHVa1ZZE
   1Pj5LAPIioBxS7wyY19xXlAqEDYxJ86ZGFw2sjIBEPks4KUi8TJHMfOo3
   aaFlNB3i0lo3a7FSiwUVXufFY+6QlMWIYDmS5oWx8EK7+0hBh7NEx1ght
   CrZegbID680zMaGwb+MwbAyCKum03r1rNt4TQPLlTEO6uu7LP/2sd07bj
   VzljUHTQSOQ6Rj1V4lCHVhae7C3cMS/VZavkK4NvIjyh1nf7UqC3fLe+7
   CIoOSqEYQDMbC4TYvqPjOQawrkK2MbagcqxRMRvmsF6z88igkOHACvM/M
   w==;
X-CSE-ConnectionGUID: 7T+1Pp6cTnORiO5/ocbOEA==
X-CSE-MsgGUID: jF9vOk0dS6yZoP+1Ofp9Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="94561897"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="94561897"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:18:27 -0700
X-CSE-ConnectionGUID: 1BTAvvgHR3mgCw2Lig4k9g==
X-CSE-MsgGUID: TqNX6m8FTzakfxCmwFldKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271820463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:18:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 11:18:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 11:18:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 11:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNo5YUjEt9ZpJc5wizr3jasQlAO0gKdofeFQ5bdbQJ2zifZm08gPmfz4PhnWeSlvwSvo/h22cy3vI5f3bRqBDNlkhUZaNxWHkhbzHo3M6/pJLBtAYDap5zKF4yK7+EbPWc+Ql0YuAlg7+epwZcCTqwFMupqkJF6/tnrCSomotxfAYCkJPl0QQCB9aB//YUNnT/SMEwt6hWlab9R3Lr3DuDUZ6UcphHjX1iVvpB/1vduJbzvqKsQy2UmOtMppqyPa3I7sm0zmklZlBrLj2+AGJhLDQ9hVR/4IeR3QXzN+K01k3BD/bv4OlI4VJqHtZiM5ts6LR8J6YWQpSwvt3XtFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJXeJ1fk39OVn6Ur1iQ6TP6CfB55If+K+2Dz9ddv2tc=;
 b=GMZ2ZgHIWPRlnSDBTK6C7553w28q3hiRIj5ePEcZB8QbgvzrP9p652iYSwwMz6GXvsb3t93B8c6M0nqtOfDNEPCXEotE32a+q+CixC1x/2ArqUUR4QaerYwMZVgpLGlfQ1nfH1jCPCSPX0MHh2H4Ei2EOEI1WxLEwg2ALozfL4+dnMhDxdZkpQADSs/k886/rBqRmhaZJ8XqbI78Biys33AaoDwD3/d8R39iFmx8cjOUXdMnWker6vpgG3B8LPQvRZiwtYuwrmXw26rYdPGHw7hpYUoeEB1BeZqfOcG2Iq7YQbDAYvUwnEqRRFtZAMp+1s8G49Kabgk2mg7g3P5JVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 18:18:23 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 18:18:23 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Edgecombe, Rick
 P" <rick.p.edgecombe@intel.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Thread-Topic: [PATCH v2 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Thread-Index: AQHdSgLautbTNw8zgUWTW1nFZjVjYLbZcwmAgAADwYCAAXKwAA==
Date: Tue, 22 Sep 2026 18:18:23 +0000
Message-ID: <94ea99fc4ba332a07530ced72284c2193aaedecd.camel@intel.com>
References: <20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com>
		 <20260921-b4-tdx_earlyprintk_tdcalls-v2-2-ad1fde3f25fd@intel.com>
		 <12013d91-b945-40b9-a6e0-a025460eab72@intel.com>
	 <58df7c2c57f2e00b0322216ec56196781023ce62.camel@intel.com>
In-Reply-To: <58df7c2c57f2e00b0322216ec56196781023ce62.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|SJ0PR11MB6718:EE_
x-ms-office365-filtering-correlation-id: d48a3840-4125-402c-df2b-08df18d5e384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|3023799007|11063799006|5023799004|56012099006|22082099003|10067099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info: qqPWXJj2ko37aa+OutSf2K3Ej4FnunsBDO3ai/L1oblKY4D2rju+vLmien/M64+IK4SBc3ngzFUh4aGjuOmTTtSzHAjCcqDxF9DTlZmUswsIIl05gqT2jWnKnX7UjvBY6fakPmUSBXt3xH6L5Dsjno6j44KU0QKFveW+hmloA8xvcJI7zIYCMZYtaqntg6J7xCm81rw0IIZdYWJouU7GJ0BCHbD9izZ9ulv17TqHrJVLeoLK6F2mO/AVk7bld5/ag9FYwUBPkOFtwQGpOdfKaKHJd8jZQJyCkHEYqv+qQsE9qaXoNuTanutL1rbk0di49tOUAy7H+wjA0ODhsc2OTJYFmD6+N0Lg1MfNHqnkJmr6POCsWbjd0r62hb3/c13a+jzzWqGJbwlpfQIgiE3ESbAn7EIVwKOlrHcx14x/y6axGNM/RWDBa+4Ka8BGEiGSjXO3TdH5ablW3tcdn3AhHkZYGB4P2By1E37M+HLNaB1pFm/SCKV2s2mhAAhLSZOcMFcn79ftqDk2Nb6vNhRABuf9vZu18oJBqTZNpL5UoJt8Nx9e2fu633N+FONECogdcSwfRfuN3UoxO2iGujJd0fc4wL7+Tot35qtC8cgtcTRnP/G8wFbZZbp1IP3lrbMqhSwESfmAWe6m3qmGxswE93638lc1gbJyvt2SLdjYG3TbSWOStVxdLK2dYli9Vmd9J6UBZbIppIgZ+iZpAkOqeBULPr1yLj7IF/dSbfgaX3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(3023799007)(11063799006)(5023799004)(56012099006)(22082099003)(10067099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGNFOVBrSHRSckc5MmFEaDY4dW5lZ1F5ajlFdWkxQ25aQVZOSzIyMU9XNXE1?=
 =?utf-8?B?NjdQNmhmeU5rcW1iczBXamZlVWxOUmdybUFyRGtEN2RML1I2OHVxQjg5MGZu?=
 =?utf-8?B?SExhRkxMQ2w1K0txNjJiSmNsbUlWRFQ2dk5DOWdRSHhXZEx1WWdjS3VzT3gv?=
 =?utf-8?B?bklTQlJvVHBoR3ZyZTRDVnI4bVgwSjJnNW4vdkR5SUhJU3dBYnhYa2dSQWRj?=
 =?utf-8?B?Z0tLb3FyQVlzeTVvYU4vamhwb2hyNUpueW02R3BxOHU4K0RiTi9oVE96bjJ0?=
 =?utf-8?B?R2MwMVgzQ2Q1Z1hNTlgyamcvbkc1c1BWUDVjZlpBS2orVHZicksxN2U0RjFp?=
 =?utf-8?B?aDBITFhOS1pjb1FNb0ZiNzc4a01oVlRCNG5KNVNPT3VicUlINSs5aUpEWFE4?=
 =?utf-8?B?cTJuL1k0SzBOb3crRlhrdkRqRGNrN2hSM2JGNHh5WDhRbzhtVTJweDFya2pE?=
 =?utf-8?B?YlFya0ZWTTEvcXZZTzFkWEZsS3pibVhUTzJETEszMlZ0K3BXcTA5SVpYck5V?=
 =?utf-8?B?UDlqZjdSbllWT1V3YXNVMjZCZ2I3cll5R0ZOaTBnVnFoODUzMFkrTW1hY2dn?=
 =?utf-8?B?VGdTYkZVZHRGbEs2cDI1cjd4cTBsMmtjcitpRUx4QUdlWUl3SW9KMmt0S3R4?=
 =?utf-8?B?SlcwWU1HVC9IVUQ5MHFUWFE0Y0luelV5aDBBMnd5eDlwN0M1d05yNTE3c3FL?=
 =?utf-8?B?cXlHb2dITU9oWGZRb1Y3dERkS0lvT2pET0lDTlhqQjJtS280Z01PQzZkV1dG?=
 =?utf-8?B?bEU4UHRvTE1rRmlzTm1mYmozVUtST2ZvSVZCa3hBKzJjNGZiOWg4bXd4K1FO?=
 =?utf-8?B?OWNka0NrUnhvTG1RaHdSVjA5cS9talJHb3Jtd1J2V1JRWm42T2lvTzd5S3g4?=
 =?utf-8?B?d1AwM00xQUQ4blRrbGREME5idVB3K3BucC9Fc3RUOGN3cloxalZudDBSNERE?=
 =?utf-8?B?WG1rOHY4WFk5KzNaNytqcHF0L3dJRmxVeDdBT05wdVRTNTQ4b211OVY3S0Ft?=
 =?utf-8?B?U3h0T1dmenhtY0lCdjJYVnNLaWFlN0tycmxnNGZqamgyaEV4b2lyWDlBVVpX?=
 =?utf-8?B?cEtGZm54ak5tdUFqQVpVVzdUemZQc0tZZkdPQXY5bUNEcUNqdVNHeVh1djBG?=
 =?utf-8?B?Sy9CQlNubFFPVFZzMmN2VGpGdmxhVTF4RWVRUHVOSFBtbEpTc3VOVzgxSWxR?=
 =?utf-8?B?NkJkYkt4MTFVK01IbFhiaGxDK3ptc1Rlc1p0dVpDa1Bjdk0vVkVjQU03Y0hZ?=
 =?utf-8?B?bHcxK2dUWjdYMFk4M3VpM1o1enZxemR5bkk3L2pENThYcnlFNDExbC9EZzFw?=
 =?utf-8?B?cnhJNnp4ZzNOQWFOOHN5SFJ2YlhYQTJYaktJQmFNb0gxMTRrNXl3dTVSS21o?=
 =?utf-8?B?Q2VtenlzNW51R2dONmxkOU9jUFJxa2M3Tmlnbi85alpDcnQvT2RwRE05U0ZC?=
 =?utf-8?B?SGNYRk5IUlpDQUYwTEpuMWJBV2JBVy9LbVZYc3NBMUFIbDJ6a2FoUndkYmtj?=
 =?utf-8?B?ckVCLzJ0OWZLVHV4ek5YTXFvbTluM3BLT083cStaNG9CU1AzcVgzS0tNT0xo?=
 =?utf-8?B?VWlibWZROEpxWUVQdWpxeGlaczU2UGhRdlV5TmxWN0lnY2dpQ3ZodE9BNGl5?=
 =?utf-8?B?MTdhanpaOEVPUXhtamtCd0VwWHBobjlRaFE0cFZqZmNzTGNrUlV2UkNLbWlI?=
 =?utf-8?B?NmhTa3AxSHIvN05RRHNjdFU1V25zU0E4eUJrc3FpeEVidndRZVZTNnY2c0Ry?=
 =?utf-8?B?cWNCQzlOdDRrNThaQzdlOGFCRGx3WmN2SUc1MTlYcVhyaFVHeFBOT3c0Qmc1?=
 =?utf-8?B?bXB3UW9CR3VXaldQZWExVUNhbTlzMkVsOEhMNjA5NFVDR01UVUNDZHFtMFJ3?=
 =?utf-8?B?V2hucnUxS09XMVYyOXA4cm1lTnhTa1JOaHF2OHVUaEtVYXZDOFN0ZnY1cnQ5?=
 =?utf-8?B?ZEJ3cDI1Tzc4LzV1ZHgwZWlnb3AxL0dZN0JjZ2s5VEh4a3VxYnN6Znh6THl5?=
 =?utf-8?B?dnFOdXpPdmMvNHFVdlZhTWVOM3Y2azJxamtXc2dSZjl5MGJBcE5WaytUbzdM?=
 =?utf-8?B?ZkxKQkY2SnI4cy9WTHI0M2JSblhnWVpjQUpYTlZLVHNKcFArNmlMbkk0dkNZ?=
 =?utf-8?B?YWpPakJnNGlLcmNvSC9TSFJHT2t0MVcyZkdQS2ZwT2pCTHdtd2h2d0o3K1pW?=
 =?utf-8?B?WHdFZTFBY3lJNGtrVDYzYklueHVMZjk2aGNlZlphaHpLQmVNUGhRYmZtdjBP?=
 =?utf-8?B?bzgwbjRvTUoxWUdDV2NHY3FVQWhabTU2cEo0R0lpOCtXbzRtYzFoOGw5eFVY?=
 =?utf-8?B?dUwrTGgwb1lmSHRkbWY2YTB6N3Y4TGRqdWpWSUhYajdjUGoyRWI5UkZqMjk5?=
 =?utf-8?Q?ilI7KsxNnR0Kra9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AA8AF286944C4EA2136A15DCFD2E3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ak71MsvoRI+KSh7MuOWQS4dn/dbMDBZzrMmYWD9kjxErjP9VXxKq1PpdFwO7BI3BickYF0RVPhw0fklcMTdwOQB9UfosbpD3OZiUjRYni73dgSUsVzgzCyFsAvU0zx7Uk9Ikc8T0ItSUjv5YxLZCEkVhIV4Mh0O2FKTMMlvHlL2ODVHkKR9muiVYf2d26U1jCa/btZFiIRiDDN/dlL8VN7zixTGdng9WIVoYryvXQkVDbVDfHb+NgMwOqUkl1s0K+YnyjPzKMAoW5AQunvMoIsN8veCh/B3O3n3lbsFvDJSeca0o1hRr9fycvidGXoST7K4kz43cOItMG/r3KchMHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48a3840-4125-402c-df2b-08df18d5e384
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 18:18:23.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVBp4xCba2fuWIM9niaLkOQ5Pd0O78nfttZIFyhvHJMiim1s1SD3+31mRfQJSUwt98R60bhaE+6yNWR7HtZv4B2Nf7cmyECV3+Lbl6ZPask=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDIwOjExICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNi0wOS0yMSBhdCAxMjo1OCAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6
DQo+ID4gT24gOS8yMS8yNiAxMjo1MiwgVmlzaGFsIFZlcm1hIHdyb3RlOg0KPiA+ID4gKwkJCWVh
cmx5cHJpbnRrPXRkeFssdHR5U25bLGJhdWRyYXRlXV0NCj4gPiANCj4gPiBJc24ndCBrZWVwaW5n
IHN1cHBvcnQgZm9yIHR0eVNuIGFuZCBiYXVkcmF0ZSBraW5kYSBzaWxseT8gSXQgY29zdHMgYSBm
ZXcNCj4gPiBsaW5lcyBvZiBjb2RlIGF0IGxlYXN0Lg0KPiANCj4gSSBrZXB0IGl0IGJlY2F1c2Ug
dWx0aW1hdGVseSB3ZSBjYWxsIGVhcmx5X3NlcmlhbF9pbml0KCkgdG8gc2V0IHRoZQ0KPiAnc2Vy
aWFsIHBvcnQnIHVwIC0gbWFpbmx5IHNlbGVjdCB3aGljaCBhZGRyZXNzIHdlIHdhbnQgdG8gdXNl
LiBUaGUgYmF1ZA0KPiByYXRlIHBhcnNpbmcgdGFncyBhbG9uZyBiZWNhdXNlIHRoYXQncyBqdXN0
IGhvdyB0aGUgaGVscGVyIGlzIHNldCB1cC4NCj4gDQo+IEkgdGhpbmsgdHR5U04gcGFyc2luZyBj
YW4gc3RpbGwgYmUgdXNlZnVsPyBUaGUgZ3Vlc3QgY291bGQgYmUgc2V0IHVwDQo+IHdpdGggbXVs
dGlwbGUgc2VyaWFsIGRldmljZXMgYW5kIHNvbWVvbmUgY291bGQgY2hvb3NlIHRvIHJlZGlyZWN0
DQo+IGVhcmx5cHJpbnRrIG91dHB1dCB0byBzYXkgdHR5UzEsIGFuZCB0aGF0IHdvdWxkIHdvcmsu
DQoNCkhpIERhdmUsDQoNCkFzIGEgdGhvdWdodCBleGVyY2lzZSwgSSBjaGFuZ2VkIHRoaXMgdG8g
anVzdCB1c2UgdHR5UzAgd2hpY2ggaXMgdGhlDQpkZWZpbmVkIGRlZmF1bHQsIGFuZCB0aGF0IGNo
YW5nZXMgdGhlIHNldHVwIGh1bmtzIHRvIGxvb2sgbGlrZSBiZWxvdw0KKG5vdCB0aG9yb3VnaGx5
IHRlc3RlZCBvciBhbnl0aGluZyB5ZXQpLiBXb3VsZCB5b3UgcHJlZmVyIHRoaXMgaW5zdGVhZD8N
Cg0KLS0tDQoNCkBAIC0xOTYsNiArMjE1LDI0IEBAIHN0YXRpYyBfX2luaXQgdm9pZCBlYXJseV9z
ZXJpYWxfaW5pdChjaGFyICpzKQ0KICAgICAgICBlYXJseV9zZXJpYWxfaHdfaW5pdChkaXZpc29y
KTsNCiB9DQogDQorI2lmZGVmIENPTkZJR19JTlRFTF9URFhfR1VFU1QNCisvKg0KKyAqICJlYXJs
eXByaW50az10ZHgiIHRha2VzIG5vIG9wdGlvbnMuIEEgVERYIGd1ZXN0IGhhcyBubyBmaXJtd2Fy
ZSB0YWJsZXMgdG8NCisgKiBkaXNjb3ZlciBhIFVBUlQgZnJvbSBhbmQgdGhlIFZNTSBwcmVzZW50
cyBDT00xLCBzbyB0aGVyZSBpcyBub3RoaW5nIGZvciBhDQorICogcG9ydCBvciBhIGJhdWQgcmF0
ZSBhcmd1bWVudCB0byB1c2VmdWxseSBzZWxlY3QuIExlYXZlIGVhcmx5X3NlcmlhbF9iYXNlIGF0
DQorICogaXRzIGRlZmF1bHQgYW5kIHVzZSB0aGUgc2FtZSByYXRlICJlYXJseXByaW50az1zZXJp
YWwiIHdvdWxkIHBpY2suDQorICovDQorc3RhdGljIF9faW5pdCB2b2lkIGVhcmx5X3NlcmlhbF90
ZHhfaW5pdCh2b2lkKQ0KK3sNCisgICAgICAgaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZF
QVRVUkVfVERYX0dVRVNUKSkgew0KKyAgICAgICAgICAgICAgIHN0YXRpY19jYWxsX3VwZGF0ZShz
ZXJpYWxfaW4sIHRkeF9zZXJpYWxfaW4pOw0KKyAgICAgICAgICAgICAgIHN0YXRpY19jYWxsX3Vw
ZGF0ZShzZXJpYWxfb3V0LCB0ZHhfc2VyaWFsX291dCk7DQorICAgICAgIH0NCisNCisgICAgICAg
ZWFybHlfc2VyaWFsX2h3X2luaXQoQkFTRV9CQVVEIC8gREVGQVVMVF9CQVVEKTsNCit9DQorI2Vu
ZGlmIC8qIENPTkZJR19JTlRFTF9URFhfR1VFU1QgKi8NCisNCiBzdGF0aWMgX19ub2VuZGJyIHZv
aWQgbWVtMzJfc2VyaWFsX291dCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBvZmZzZXQsIGludCB2
YWx1ZSkNCiB7DQogICAgICAgIHUzMiBfX2lvbWVtICp2YWRkciA9ICh1MzIgX19pb21lbSAqKWFk
ZHI7DQpAQCAtNDE0LDYgKzQ1MSwxMyBAQCBzdGF0aWMgaW50IF9faW5pdCBzZXR1cF9lYXJseV9w
cmludGsoY2hhciAqYnVmKQ0KICAgICAgICAgICAgICAgICAgICAgICAgZWFybHlfc2VyaWFsX2lu
aXQoYnVmICsgNCk7DQogICAgICAgICAgICAgICAgICAgICAgICBlYXJseV9jb25zb2xlX3JlZ2lz
dGVyKCZlYXJseV9zZXJpYWxfY29uc29sZSwga2VlcCk7DQogICAgICAgICAgICAgICAgfQ0KKyNp
ZmRlZiBDT05GSUdfSU5URUxfVERYX0dVRVNUDQorICAgICAgICAgICAgICAgaWYgKCFzdHJuY21w
KGJ1ZiwgInRkeCIsIDMpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBlYXJseV9zZXJpYWxf
dGR4X2luaXQoKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGVhcmx5X2NvbnNvbGVfcmVnaXN0
ZXIoJmVhcmx5X3NlcmlhbF9jb25zb2xlLCBrZWVwKTsNCisgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KKyAgICAgICAgICAgICAgIH0NCisjZW5kaWYNCiAjaWZkZWYgQ09ORklHX1BDSQ0K
ICAgICAgICAgICAgICAgIGlmICghc3RybmNtcChidWYsICJwY2lzZXJpYWwiLCA5KSkgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgYnVmICs9IDk7IC8qIEtlZXAgZnJvbSBtYXRjaCB0aGUgYWJv
dmUgInBjaXNlcmlhbCIgKi8NCg==
