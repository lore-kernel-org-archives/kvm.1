Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795506850;
	b=1CDz0Xgz3Ee/GTaHaWA/Y3NcpxseuX//WVTUOjrmgz6RKtuUQSd8lo/IPFs2Oc63xXVX
	 7TIgpqAXzgGIdhNMEO9c4WA0r8bD93yB0Eq91bg7uxt7gtTGamtVAXgyUNTWUOR2LMD8K
	 kv6Y3UI6uoeG2gY1raTlgQgAM4LzqUgpgFlTimx9tPyqvI/0Pkq9GMBCedJ9/zNhxAKkb
	 T9vpJaO+vQbpji49j+2sorwRu7LbMovYSVEw1BDd9U/dBV0jA0Zcz7Uofn89OYMHJcWsH
	 fO88s42PyOnXUJtrhSP6R6XGtk/ed3zAfaheCHxf14qBvE7waTdxB6ESGWYLbch4qEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506850;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=rJorgWhM8PtRLu7N70Y1qHPSdyjLyxFDogsP1+OQpQk=;
	b=AOiyT0CF3cc/++PoKWePR/lZYZOVU4EYa7MwNwA4NJP0V3YT7SPQAskRqQ1+NSyQQRDI
	 CPD+mpp1YRpBf15FrtKIkeL62f6KibjoRMy584HJt5BxBBcBWOyHp/W3GezYGNqN1eQYt
	 TH7cG9lRkhaI25fvxZbvDgPi8OCkvD+wYbhBahLXnQZN55dv5wikXNBNq+TMzgQTQN1NH
	 Ttm7cy17p18N+7tTsT7tN60NoBB2bU0Yub8OUoIzc7ObCqQ21/xx3gnHFS3np5FQ8WejW
	 CN46rx2bXEHwh/XOfPqD7llHMS1DrEk2HU0UGwGqyk7MjUmaUAtE0/oi3qVp4rnerMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXgRSo7c;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UoTCr6Aq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BD606A31E;
	Tue, 24 Nov 2026 07:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 163BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jXgRSo7c;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UoTCr6Aq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795506850; x=1827042850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJorgWhM8PtRLu7N70Y1qHPSdyjLyxFDogsP1+OQpQk=;
  b=jXgRSo7cSzjm2xFSC6WohWaXwFaQ0G/bSq7CG1DgIkrnrbZhLwJ1jQGy
   5XnTmxY0zqsIwvKpkSJAGAfgedIz7psSCO+QQRAHHwGX5CvS8ImrbaCUH
   7MTW3O/lluRxoLi4Ij6yvGT9k6cjViKCIU6bvksWzKub84FbT7SOuA0YT
   8gktD9vSMgiQNNzbVUh50CSz8dOpWiElAPYqZYhGjDlf2df0gy14fyGVv
   OiCxTJgCKQ/dVoIwDLxwYjvfkdIyVeP4HYUE3xwSaNKHIc4pGs4+1ZVYT
   F3zq+PifUTmMaxUaJhq7omNTpuTPsqJFCs4r3D2O2jmSXj6K2V2wLKoyP
   g==;
X-CSE-ConnectionGUID: SXRlvQtRSQ6SDQJkxFyZ7Q==
X-CSE-MsgGUID: VRj5itz2Sha9A04XPYS7ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4316493"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4316493"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:54:09 -0800
X-CSE-ConnectionGUID: trTQu3JQRkOk2vEBYiwJNA==
X-CSE-MsgGUID: wC7o86ZlRXSjlH9lKd84nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="12086242"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:54:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 23:54:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 23:54:08 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 23:54:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNKQeF6cMR2mmOjVEjWcDUMSotHGL8JPm1LptwHSlyvXfnXombiF5FMb55R+T2h/U/AJeEw06E5jBEs+HPkF9fuGDz6ClEQXoTlmVF55Qc/xYT4pH/cfF290ZQCD2JJfoj+NuXXysVtfUunSYUa+HUsgXEr4V3g+nizLgP4gJ2M6+wkiIn2NvQqWz94grh1abSMc7+kg+6uKEUaNiAP1NXtcrjWQ1ZEUdoI+JVef8QWm4StuaLNYW9epo07yIGgC/tNaAaTb3YgvxXqxFhSPbfFxe/TO7RGShkPFwlpvlGM7q2lJZ5/kF7+OKYie42dXZ9ADlxacvbWEIWL/sPZp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJorgWhM8PtRLu7N70Y1qHPSdyjLyxFDogsP1+OQpQk=;
 b=ZElxsw1lCO4pLYj2J8PRX922xkLcpFGqdnLadVeA4ZWaEv23C5ENR1LaYMoy/D62UO9YI2f81LDXoWyOvTI2vogw5tcvJ1/0+VIy9FpKvn2B4QK0Hzz5ChyZ1Ewk3qELvNU1fuLgA7kh0qFQzX3NzUnADxJVmNP9jWzQbY2UP4Rfr9FQjTyte57/7SwAqtDfIbFbpnywsCQQalWFpxRTN24Dxj2PHBNeO8959orTZlw8lCAd5IxWvj3JbN5Mqo8YrXkMNSFIu/kCcMcd2QgwtWmM7X4zyg2l9Du8xXtt5JdZQi7vMOHhC24cYY7C+hDcV9/jVCqZPS4Jy3tL8YoDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJorgWhM8PtRLu7N70Y1qHPSdyjLyxFDogsP1+OQpQk=;
 b=UoTCr6Aqp/i9Q/V9gbuivsxDc6lMkflZ3HYYSmoLMwcSKcODCEtq12Pi0Jhs6nAosrOpRzSYH0+UZgsLt7ufc4OE3WuJlI5xIIrPZiYl7+O4HPA2P2NSGozWG/kdRMmLCzcitVFjq0oUELuqCwDgZzZnTOrvXeJyju1jK3jwvEg=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB524689.namprd11.prod.outlook.com (2603:10b6:208:61f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 07:54:01 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:54:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kiryl Shutsemau <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: RE: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdcZDG3khky0SM70e1NKLidpN8fLc87DTQ
Date: Tue, 24 Nov 2026 07:54:00 +0000
Message-ID: <CO1PR11MB48354ED95F53409835B9F49B8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB524689:EE_
x-ms-office365-filtering-correlation-id: 5fa72eda-9016-40e8-dca5-08df4a0019f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|6133799003|22082099003|4143699003|11063799006|56012099006|261022075727099003|261028144727099003|261021135927099003|10067099003|261021121427099003|261102123227099003|261102124527099003|38070700021|261022105027099003|261026140227099003;
x-microsoft-antispam-message-info: mFP9tJZypYn5AXvhvBNuhxOVclAdXM7GmOrndTtXE1IRREng/NX5QG5GNtTXPfbVzS77ej2us6mVla3MH02BPJ5koJUdALA+diCE0D4DG3iQrq1CnHSSePfthQowrpX7pDn2TY6lJx+9G5KB+ZQ2t/DLEbPwWWP9xv8syla6UJ8kuzvUNhGGH02kR052GWB4Qq1Y0hZSYP7fAdZcdApzCBN8II5CmtMyd00DU9Ruj3BhdtE9KiGrtTF6EhBisVk8pfuOcfDmW2bHxm/9FdhaSeS9FdW/2BFNMngu218sDFEyxJ3M2bMip+t575LtSlMuGiB0An1/UnVgMC0ignPcaiEvRqEVkZ/4EoBe2DUSYxEFuLQ8iAoY9Ej9JvimIVYI5mYgbkMI/lSrjxI7ouBk8lRzop1ksrea3cdm2uDksKCXxGg7Hg89Ibsc97c6dqZkP41uR6wfFiscYo3JGasI+7S2e5spVHEYpXJTyB9cp70L20DK9S3D3rBkCMN45w32A38yrGmZDKD5ON13JCFrIJXcO/jtcrIxfQu0swtBJ9rsTse5351TlzYcIft5uuIg0909SeQma1mY+StYH2Tdu0gC0Zph8OSQAJzMM0Nms0bbzAoYiUdnJcuHKUCTwwotbyduynyFvlJV2+TxwP8jvQNaVzukJ7fu1X36U4DqBZSzloQNoJ3c7Y2wNJAe9aopEsWx+iDlcaSv5cGISWheFZSGDqdAlBkB+euNCA8NYFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(6133799003)(22082099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(261021135927099003)(10067099003)(261021121427099003)(261102123227099003)(261102124527099003)(38070700021)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGRKeFJMaElzSDJKMS9DZmZySUMvZWJWcjRYMXNobFIzRXJTckpEeU5jMFZq?=
 =?utf-8?B?MW80dUFCejFWNlgyYTVJTk5ZN3RSeXJvd1M2TXdpdEhaZFB0dURsNDhSMHlV?=
 =?utf-8?B?ek9jdlVVU2ZucHY3SVNzUklyUERISDl4QTNtN1FTdW1wUHF1QWNqcGw3ZHFM?=
 =?utf-8?B?aDdXalVLS2FzMXduRTE1TUQ0allJQXYvYWRDYkFVdXI4aHFtM0lWL3NBU3Fh?=
 =?utf-8?B?N1dXUDNiM25NRy9YWERXTWdQdlR1a0dESHFuM0JxQU93RHRIQ1BDOUZmUXV5?=
 =?utf-8?B?eHdEQ3VPN0FrbFQ3UFpWcWhEcG8zUldMRTBLZFJ2Yy8zRlhRd2piT20wSmZk?=
 =?utf-8?B?ZTM4RmNWNDAvK0NiWkNMTEgzdWFwVFBIRHRoNGZENktISjFOTUEwQitZSDNa?=
 =?utf-8?B?ODE2aUIyaGpmSWxGWmU4SzFMb2lDTktoL2VzQi9IK2pRNFduaDNQMzhyVWFj?=
 =?utf-8?B?cTZITlRsUUVDeDNKbjMxZnFpOGVQQlJlcjJPelBQditJNnk4OTA3UENTNVcz?=
 =?utf-8?B?ZXFxNEtIbFlYd1BwYXRWZnlWRFdHK1ZJSW5XS01DeWFRempjUkR2WmV2d0FN?=
 =?utf-8?B?eUh4cm1KdmhIa1pYc1ZiOFphNHhNTHZqVmJSU2VxN2VHOS9Wb3Q2WGpmMzhF?=
 =?utf-8?B?eHhCRURVVFhRVkVNZXIyOTV5ZEJoamJFOVpYaTZiY09SSkloVEg1TmVWTDRB?=
 =?utf-8?B?VVhZanhpaEpNaGwwSElIeHl2KzV3V2U5d0tIQ29vZDNPbUZ5WnE1QjR4TkhZ?=
 =?utf-8?B?cXBDbi80Z05tMVFoVjRUN1VNTUcxejdncjQybWViS05yOHd1azNoQm5PSmtO?=
 =?utf-8?B?TkV6KzZHY2xjNGF0MFVMR09hQTJ5enRMN09kZUJzbU5zV1RRV0UrZmhCTjdu?=
 =?utf-8?B?S0c2dU5KdzAxaHdvbXNnNU1JL3pmdlN3QWJydmc3Sks1U0pDUjREUlFrUWdY?=
 =?utf-8?B?c2lpMk1zQ0M4a21SczFJSlE2ZEpNNklsUEwrZUFmSGJ6ZUhzd1hraXZwaE9k?=
 =?utf-8?B?MUh3cjYwZ1k2cTZaWkp2dmhQdkxRV3F2UW9DblBMWUtFVXU1ejUwWE5FWE1r?=
 =?utf-8?B?R1VwV3hhYVlVR0Z4MDBlNDd3QkhJUEtOOG40WVpMeDZoZVlTM3hjU21SbGkx?=
 =?utf-8?B?Y2ZkSGh4cmJGck5hWDRjaG5mMWkyMmZpejM3TXRGa1Mzemd1N29BcXBxNkgw?=
 =?utf-8?B?RWVsRjdERnBPRlBYOGovNUMzWnRVN2tXL2IwZHlkUUlCNnVHelcvMGIvenlM?=
 =?utf-8?B?MDNOUnZuUElNdlFvQk5nYTNKVzFLQTBHZzBEUjFrNVJheXYyMUhlZGIyTkdR?=
 =?utf-8?B?ZkVXWVpJenUvTHJ1L00xdnh5Q0QxRGtlUGtxajRMbzM3WnZURFQzY3JoMmdl?=
 =?utf-8?B?VkVEN2FoRy9kRFpHb2NwSk40RmxDMTVKMWdRanJSYkgzZlprSTdocEsrMGJ3?=
 =?utf-8?B?a0E5dDM0M096eFJKRjZaR1hJc3UvcnYrYW5tRFVDeVFQRHpDU3BqdldwZFps?=
 =?utf-8?B?N3ljUjlzaXFkU2MxekhZMTNGVllidDFqeGtENDJycFFpems5T1ErclladU0r?=
 =?utf-8?B?TkNSU2VwUnR1ZVkybWdQS2pOeHAvTjJtMGZKSWRIZ1psbXJ3T3RuTHZzZlFy?=
 =?utf-8?B?Njc3dG42ZGtjR04yd2JHYldUUHRabVQ0ZGt0bXRBb3JodW9MZ0dtTzFHN1Uv?=
 =?utf-8?B?THNkcUxUbys5WVJuUHMrWk9qZEh2dDhvQkIvaEk0WjA5YVlLQk1rNWFGdEVG?=
 =?utf-8?B?TkRqY2ZmNFJHMTFQWnRBd29mY085Vk93aWxWSGkzWUt4QU83N0Q1T1VDZVFG?=
 =?utf-8?B?bFlic2ZnQ0QzMHpKcVBwd3NXRXJWeE04dzdNY0ZlSFhNZHVnUnBtc1hrTmlx?=
 =?utf-8?B?UkJJZkk3cUhxbFQ1WUJFZGswRTdQQUNxKzZsTzNWSHc1L3RFUitYRTQ4d1VC?=
 =?utf-8?B?Mmh2bzF4UVVXNnY3eUlyQ3RRNEMxR2l0Nmpvamp6eGJQK0dTeUt4VGl4T0RJ?=
 =?utf-8?B?Zy8rYkc1TzB5a0lYdURMeVpyNXVHMXBKb0FtQWV4ak9WMUxPNmF2OTR4UzZY?=
 =?utf-8?B?clVkaGpxV1FDK2hueThDNnpkRWF4bjRud0VPRmdBbkRQV0RYNXFmSlh2N0Ro?=
 =?utf-8?B?N3E5VWpRaUllSWtxakg1UUtVRVFiVTcxV25zajdCZDNZZ1ZQUjR4OG1CVlZl?=
 =?utf-8?B?bDJ3Skx6NnFyZUtPcmFSMnRkcVNiVkl6cTRHeW5sQlRPeUJqWVR2K1NIdUdq?=
 =?utf-8?B?K0c1eGhpNTNaTVJMWDUwZC84RzU3ZVRzbjVTSTROUHRrbFEvWjRNVGNOL2Z6?=
 =?utf-8?B?Q0hkKytKM3VIdGJNUkxaajg0azVYbUp3azg2K1pmb0dmL211OXJJUT09?=
Content-Type: text/plain; charset="utf-8"
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
X-Exchange-RoutingPolicyChecked: ZQPvEqmVN+ZLIySBNEeOYNKy9fiV6/u/Beo8b4N2lHzPHmZ7LkUhcYOVpfWCx8Wtci/4T01ri6BjrqnYsd2VMsLsrNHl3hHRkYa1C0lBpJ/Q4getMWntDE6TsO5wNO75c/UHB8kH1ldaJjbgkbBZAUISHQt6qQBcLjChfFc+WcXKdH0y/Snq0Of4zBuGoAvQ1hNhlmdIGUsdQlOdM2v2kLlDONeZrat1K3jKZKU6BpwdYruuZgAEqJGflfP6SO+RkfTBoK/MXHL9h9cjzeJpzugtREoS2eU7S/tklYwoXrPXflpsvhd2qIzLxipVDjiVL9bMObyfJaU4nMwfQEGS9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa72eda-9016-40e8-dca5-08df4a0019f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 07:54:00.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lps3hCD5omQE6K9THGI32OPzTzTMzQDaYp4CI++P/x2Fjk0TKAZ5CqRp+WXDx3nWVS7gu86uHziMtTF5sT8dsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB524689
X-OriginatorOrg: intel.com

PiBGcm9tOiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI2IDExOjQ5IEFNDQo+IA0KPiBURFggbW9kdWxlIGV4dGVu
c2lvbnMgbmVlZCBtZW1vcnkgZm9yIHRoZWlyIGV4ZWN1dGlvbiBlbnZpcm9ubWVudCB0bw0KPiBz
ZXJ2ZSBTRUFNQ0FMTCBsZWFmcy4gVGhlIFREWCBhcmNoaXRlY3R1cmUgaW1wbGVtZW50cyB0aGUg
ZXh0ZW5zaW9ucw0KPiBpbiBzdWNoIGEgd2F5IHRoYXQgdGhleSB1c2UgdGhlIG1lbW9yeSBvdXRz
aWRlIG9mIFNFQU0gcmFuZ2UsIHNvIHRoZQ0KPiBrZXJuZWwgc2hvdWxkIGFkZCB0aGUgbWVtb3J5
IHVwZnJvbnQgYXQgaW5pdGlhbGl6YXRpb24gdGltZS4NCg0KVGhlIGNvdmVyIGxldHRlciBzYXlz
Og0KDQogICAgVERYIHByb3ZpZGVzIGEgc2VwYXJhdGUgU0VBTUNBTEwgZXhlY3V0aW9uICplbnZp
cm9ubWVudCogLSB0aGUgVERYDQogICAgbW9kdWxlIGV4dGVuc2lvbnMgLSBmb3IgdGhvc2Ugb3Bl
cmF0aW9ucy4NCg0KU28gdGhlIFREWCBtb2R1bGUgZXh0ZW5zaW9ucyBpcyBhbiBlbnZpcm9ubWVu
dCwgdG8gc3VwcG9ydCBvcGVyYXRpb25zDQpvZiB2YXJpb3VzIGFkZC1vbiBmZWF0dXJlcy4NCg0K
SGVyZSAiVERYIG1vZHVsZSBleHRlbnNpb25zIG5lZWQgbWVtb3J5IGZvciAqdGhlaXIqIGV4ZWN1
dGlvbg0KZW52aXJvbm1lbnQiIC0gJ3RoZWlyJyBzZWVtIHRvIGluZGljYXRlIHRoYXQgdGhlIGV4
dGVuc2lvbnMgaXRzZWxmIGlzIG5vdA0KYW4gZW52aXJvbm1lbnQuIHNvdW5kcyBsaWtlIHJlZmVy
cmluZyB0byB0aGUgYWRkLW9uIGZlYXR1cmVzIGluc3RlYWQuDQoNCmxhdGVyIGluIHBhdGNoNToN
Cg0KICAgIE5vdGUgdGhhdCBUREguRVhULklOSVQgYnVpbGRzIGFsbCBjb25maWd1cmVkIGV4dGVu
c2lvbnMuIFRoZSBTRUFNQ0FMTA0KICAgIGxlYWYgZmFpbHMgaWYgYW55IGV4dGVuc2lvbiBmYWls
cyB0byBpbml0aWFsaXplLi4uIElmIGEgbmljZS10by1oYXZlIGV4dGVuc2lvbg0KICAgIGFwcGVh
cnMgaW4gdGhlIGZ1dHVyZSwgdGhpcyBjYW4gYmUgcmV2aXNpdGVkLg0KDQpUaGlzIHJlYWRzIG1v
cmUgbGlrZSAnZXh0ZW5zaW9uJyA9PSAnYWRkLW9uIGZlYXR1cmUnLg0KDQpDb3VsZCB5b3UgY2xh
cmlmeSBpdCBhbmQgbWFrZSBpdCBjb25zaXN0ZW50IGluIHRoaXMgc2VyaWVzPw0K
