Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B54AD7C0;
	Fri, 11 Sep 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149110; cv=fail; b=DqIfUDol/cdBf6sDn89jyCuDQwPeHJds5cw1GhmIvWkYWwNEdlcXxr89L/vfunfPf7iF6aAtLFKAkMM4zOH+CI2Z1pcTnUo/7ylbv2fkO4KgS2+skJ/Tla+cRxHKh0rknDareRWv7cWNFOudWejFbVOIEgJzbMowrIEjWi7+g6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149110; c=relaxed/simple;
	bh=inwx47VPGU5o/+FWvCB8l8ckrOpsHpXcs+uzJdJQrc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pl1GcGSp+SMHmkRBSZP1MC9JZ9CO+u6ypk4wV6EI5aFoz5ECT1OgNIwLutLRqe283t3dYUpMInVsyUvftFlkZFtsiPVjvzPsg7oqXyBXIoynS2dRrgh8q+ykxS53k7fswGL0T1uDOPCKv+jRuheW/0nFx7175WaCiVjX2HiXj+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oc6h5djj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oc6h5djj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789149099; x=1820685099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=inwx47VPGU5o/+FWvCB8l8ckrOpsHpXcs+uzJdJQrc4=;
  b=Oc6h5djj13MmsEsNn7J29pw0xrPAGu5KiRFGdmv21c5cfHmKS0SZdmP6
   KdirG8wMhsCfqFH5oOFuHdap5IRgguVJuZs3bHybEcw0qaeopCOpvBn2V
   /ncQONmuSUrFmq8zcuZ0WzsTyEtTk08muTkAgGth5knkFJVMOK3OhRzAp
   2DNIIUmH5i9D1ul4ZDFC1yTwiM5NiE70wBbQaerWQvfbqR35KmIGo/Rih
   w9+Qlx373xyUtNcMgktpXumTFTplrMwYi/C+YbTc8nmcmapOSL1EANoEi
   wncx3Dla3UbDNqMHDRV6lKtxtYBnTSHWl2z6HY9otXUjImivskpMQcGrg
   w==;
X-CSE-ConnectionGUID: kRDWgySbQV6f+H+ksisH9w==
X-CSE-MsgGUID: yW1/4je5R6qZf5r9sEpbeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89826580"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89826580"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 10:51:37 -0700
X-CSE-ConnectionGUID: iX8D6XHVTMue+T+H1n+2/Q==
X-CSE-MsgGUID: HjxpHRisSNeTSTnJaUM8nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="368155"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 10:51:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 10:51:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 10:51:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 10:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El2NiOZe/kq1/PvYunf721qUd2fnErMUxzaEdsBcu++gxs7/0WTKfZdNbAVhDMzPKLjg7t55TT5SR9cLIWg8WVRiC6PdKdzJTUrkPVpKn2Hr1qy9iuKzwHFCsnPa9x44g8XN0FEOh5SR6vRqXobs86uv6JBvHd2DbUIdfHNaGDPtHnUAqmru5aY2NpTVAFhC454hmnXXbbaKqT+JKBgmdqwLnSbUMoYuspSyRw7DbYyVn3+e5oX0SLw3UsmNvAW1jU1HQIkHsjF6uAJy/5CmGEKVw5IUIJiyc8dGtdEYneuIhon7RQoVK/OEVoxiXHZAAI5Zqfsw/pehZZrS+ZlBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inwx47VPGU5o/+FWvCB8l8ckrOpsHpXcs+uzJdJQrc4=;
 b=nDOTSKVtIQzFSsURJiT+YhTfYMWLRPlrNCGQUgBit0I+vCx6qb7GQZ2/XmzOu2+IiYzBDlXl4Gf8Ul9yQLPg5g+jPFdxPBQgBN9JvUf1QQAu9TxcaLMKhfGSzeIhx9ZwNSGMREqV/jxiqNEm6fpzMuZVQHrUwwcwgg+x5kFZUeaQHyRnaGo3mFQ+XtfUQCRBEILx+LP4x92Y/ndn+hvbqrPNBZbTo4Ox2hssQqWsW2dCrxt0t32N+eBkqVJBf+t6oWWUGmFR4Cat0r2D/ifeSlofxP3MmirYCOqYeXSTSGNOWIaiTTC4AjnVl8JD2VMUUWiIu1pZXwxicXx+63+aTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:51:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:51:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJIriwy64Eilke8gkXVO7WINbbIRmSAgADp84CAAFBPgIAAC+WAgAAdJwA=
Date: Fri, 11 Sep 2026 17:51:29 +0000
Message-ID: <0c7c383697e781ddb4cc86213d75819532ee05b0.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
	 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
	 <aqPTIyi--7f2Fzxm@thinkstation>
	 <93b41dce8d7a9b4f28bfed2a51f919eebec9b7f5.camel@intel.com>
	 <aqQmNeXQv05SK86g@thinkstation>
In-Reply-To: <aqQmNeXQv05SK86g@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: 5948b268-e881-46f9-4614-08df102d4f27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: aCSi8h4YVijcOPkXfTIeOeHGPw9Njm0S16+4m+pw37qODOeJXYOTLgxn0rbpFstJ0VFjKV76SBnAC4eF0PwVYJe3imQsBRwMu0Lfw9aY35vySrMXtEld7kg7ZmRfVbQJJi2tfT+XoVmPUYME/Byl44kijjPNXocAVJz4UvfhqvimZMcieCZPIB4vbyZDyR1H/HQbqIZ31Ue3RfRnGqoagitz84x9lw+k2yWa0IoYbCohxAWA2yoXatFnHm0htApcYhIv/qKgB306hkeT8Fi8m5feoDGKC7IXa3/eNe1ZiHIpzBc44scnRqg2nmGvU1wY060og78p5atoP+dsQ8q/PIDfTr9uTfnzZyo6lrGbUKnXsfN4X0+Sa0z/uWVrbWaJ3dgLabrtkIEwlc9DOIi7IRldoRaM12liHS5+1+LHGPpf1Wghqrtt4iSsTIyp8IPEn89zZy0RHt6HMPKf5RKPXuf9MAJt+wYVyeh1splJhOsruixj27ovAXR21c7Bw8ZcJNGi4d8gh66lVJpP9R664pxL2TqNxfMiY9Z0ziFpCLxzk01NdW2N3h6W446JHtKq7nr03Nxg456bvcxeheeIa1pbESRFQHsSUFShNcSuT679CsnsXuzi7dSSIkWUu2vO2n+SOrGvvqlB80gKWS0KxbZKh5iIhoEy5KIPTr+G+pTV4hOMSnZwTaYvrswqXgdTRlL6wABVzWu7rkx4a+ikMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnljQ2VUdHgwR2lHUHFPeTFyQ1BrNVNkWHlFSjJrQ3NzRE5laFdSQXpnK0lK?=
 =?utf-8?B?b3JlcW1nN0h5NTR5SG1kTlN4ODhzbnZIVW5wNzZ0b21JRlE0dzFZdmRsL0th?=
 =?utf-8?B?cjhpa1VZRktXWnlKdFgzZDU1RklFcUtkbjVQWElSZWFYYlcxV0FNdVR1ZVJs?=
 =?utf-8?B?OE9kTGNENkVKSThqSk95bllCKzV3MjZTQm9KWklINjFhZTFFbUkrUmxBaXFH?=
 =?utf-8?B?MEVITURrTTQzbmZzVjJkT2RQNVV5SUNvdm9QanNjMk5nY2tVN2x6M1R1d2xl?=
 =?utf-8?B?TnlhQnVvTkR0aGZMVGVSTFVNK0U1a29BcnF6T0NCUmRObnd1ZG9MbDMvMmVT?=
 =?utf-8?B?Z3IrQnpad2J4UzA2QW5xZWVISXdzK0VTS0hYeURGQnFkajR6aCs0eHYvTmQx?=
 =?utf-8?B?K0J3L0Y1VGtVa0xsbFRPTWNVbm9QaUF5eUJzYW1ZVzlMNjhwUWhZVm96M20r?=
 =?utf-8?B?U1pDTTBBM1NJUnBiNzBqdUY2VEIyREwySXNPYW43dkdOU0daeU81VlJScE10?=
 =?utf-8?B?L1BBcmVoUDJiN1BxczBiUVpPQUx3dnlaY3cxTlVBRytzN0tUb3JPbFZnL0c4?=
 =?utf-8?B?eVBEY2xVL2NKeGlFeUNkbittMmNhNGpucmtWTDBnRFZ2bUJtZ0U2eU9JQkdw?=
 =?utf-8?B?My92QWh0Q3NsckNNUGFFbHNLMDAxandubm9mNCtBckd6aDVVYjBGS1ZxK3Jk?=
 =?utf-8?B?S3V5Qmc2QnpYMTZHS3ByMGxseVFFWWVPWDBEK25pcDNxVDd4V3UvUDBGenhj?=
 =?utf-8?B?RUxmQVpGWWFQTG9VUkdDTFI3ZW9JSWlDUmRJUllHSkErQm84YXo3R2JGSzRx?=
 =?utf-8?B?dSs1cHNrTWJMUWtkcDZrTWhxZVRHSDdmNnNxcGVjK21DcTQ2d21GeGhCaHE4?=
 =?utf-8?B?NHdDL2JHWnZHcWd3azJCUTVrTjZqS0p0NFBhZE1BYUcweUZoSlR5RTNKOTdX?=
 =?utf-8?B?eUZMMTJxcWx3bHdtUFpaZDRnMTY3NEVQR1dJaFF5Y3ovN0FrM0wzVWNBL1BC?=
 =?utf-8?B?M0FENEhsb3N6ZUVyS1Q3aGVGd3pqMVlzY3A2dENjcWFGeGx1SzZUS01rbVFZ?=
 =?utf-8?B?ZW00VU5iRnA1cUswSm9FcHFCWVdDd24xcC9qY04rN0piUkV5bDY2OEZVVFg5?=
 =?utf-8?B?c0VXVGJyTG9JdnpkNFRvU2x1NWFpbi9MVmlrRDNTcnl2Y3VaalRzRld6clRt?=
 =?utf-8?B?RXVpbXQxSDNTRjRXTjZadk9DMDVUdHp4NEpqMnorU0hMcURqY0JseVNILzRM?=
 =?utf-8?B?bmkvaTBBajZEYjJSeEJremZHV2ZhNTBmb25VMHlGWm5Zczd0OThacTdNaUlB?=
 =?utf-8?B?NEdneXNmRDM2TjdMcWJyemZUSFhQSUJWaUlJMzNiOXZwU1UrYSt3TlVpSnBN?=
 =?utf-8?B?dnhINk1Sc3gyTG03TlZPdnJnKzNESnRER1Q1czRxTGE3aVdTU1lNZ3B0V3dF?=
 =?utf-8?B?NW1hL1hPWE1TQmtoN3cweUVoK2pKZGx1WktjV3F2NlRFdVRtam9vYytRRFVq?=
 =?utf-8?B?V25ZdGFNeE1ZTGFJcVlEMWxFbDd1MGFneDFUYUIvOXh1K2pxdDlrWnMyaUZ5?=
 =?utf-8?B?dlM0WmNQQWhWNS9vYVRnMng5S3U1VXJEcUhFZzdIUGZzUUlkbU9lcnZuYlQ0?=
 =?utf-8?B?SExwdjZ5cVRJV3hzb0FSN0d5ZWZVWHF6c0VBY2Z5c0l4Q09LVS9yWUJ6cEFl?=
 =?utf-8?B?Mk5YY2c5dm9qbmI3eVJWM013akRmSFVjQmc5VlhLZzdJV3FJRU85VHc1M3Z3?=
 =?utf-8?B?b1gwVWtnZEdUSk55S1F3a0Z4SU5tRlRCNWFMcFdVMWphMnNUVlgxMGtLY2dN?=
 =?utf-8?B?OHBrd2loWGlNWVk3d3FWR0kwY2lGZHBHZ3lDS3Fxb1RBYTg2NFZKSE05ODZ1?=
 =?utf-8?B?UEM4anVmcVdlaWRmUWdRZXpiWGVyZzU0VU14MDBDL3l2SjVITHoyUWlJVnd5?=
 =?utf-8?B?ZTJhem1tazJ5WU5XYS9LcnhKLzh6MURyMkdWbnZESXF1dGFSLzR4MnBhTnNE?=
 =?utf-8?B?NDVxWWNJQWRqRS9aSXZCaDdqaXRiQjlRVGRodXY0OWRnaXpyQkNiMk9mNUpr?=
 =?utf-8?B?Z25zQ0w4ZTBZZkRHaWkwUCtYL1JMdHFsTDEvZzgyT2dLNUFkRWowOW5NL1V3?=
 =?utf-8?B?ZGw4cmxNSldCN1NXdjZsUVBqUWMycE5OSVdHWmNRbEYzcjhtUitWV204M2Iz?=
 =?utf-8?B?eWxmbmhta3NJVDBKL3dqcWJPTWNZREE1YisvVWxrTWlDbDJ5NFFVbXA1Y2Jv?=
 =?utf-8?B?SzJXZ1lqR0JSRjJ3TkJhWEpzQmRjV2RtRFlPcDRPOHNzR1BkOFFFanFBNXcr?=
 =?utf-8?B?UXpTVUtFRDVvSUlDbWRzVEpETXcvcHZFU2dzUHBRcm5QMjB6a0pueE14OVVM?=
 =?utf-8?Q?wXWvU9IT/8n0+snk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE273D6452945A4C80C010690E78E75B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GT9Ce5tvQqj3UTnTsaklrVpHp4GMbMF2KbgzFErOoxoSSzp1WgC58WJGjKKf4qBqUZdGpB7fXH/wvsDNW+d6jnythmDoO1YbvLLZMAzKusZOWOD0f2PK1XnbTMwlZjuhJq7Qf2Wxs9udQvvJw9A8jlk+hTC8yt9waAlUMXyCHT9uc0KcPr2YBxWoRY+WBa5OOUWwSW24CFEAaiS5jAB5sQThhbe6ULwNkjoTOgQSWHSIwzMx5vEzTO2Zr0DF1cDx/TzBGeZ6t8Y1X3TaKc5/YGPFxJz6slwUaitky3bp2GLtWJSERBK6GAy8oppdz3YcMSipUnL53jdBPZnDx9yt4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5948b268-e881-46f9-4614-08df102d4f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 17:51:29.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pfBUsaTG9wypqWszIVzdEBTIu0OEPrEI8+1Hfo4Icti448qwRsuVzyzmCe5LAjimj+03wgt64AJlQlOKMOj9zpu8BzRe2dGjl5l9K97oDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTExIGF0IDE3OjA3ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+ID4gSXMgQk9PVF9LQkQgc29tZXRoaW5nIHRoYXQgeW91IHRoaW5rIGNvdWxkIGJlIGhpdCBm
cm9tIGEgVERYIGd1ZXN0Pw0KPiANCj4gSXQgaXMgdGhlIGZpcnN0IGZhbGxiYWNrIGZyb20gZGVm
YXVsdCBCT09UX0FDUEkgZmFpbHVyZS4gQnV0IGl0IGlzIGp1c3QNCj4gYW4gZXhhbXBsZSBvZiBw
b3J0IEkvTyBJIGZvdW5kLg0KPiANCj4gPiA+IENvdWxkIHlvdSBjaGVjayBpZiB0aGUgcGF0Y2gg
Y2hhbmdlcyBwYW5pYygpIGJlaGF2aW91ciBpbiB0aGUgd2luZG93DQo+ID4gPiBiZWZvcmUgaWR0
X3NldHVwX2Vhcmx5X3RyYXBzKCk/DQo+ID4gDQo+ID4gQ2FuIHlvdSBkZXNjcmliZSBtb3JlIHdo
YXQgeW91IGFyZSBpbWFnaW5pbmc/IHBhbmljKCkgZG9pbmcgZWFybHkgcHJpbnRrIG9yDQo+ID4g
c29tZSBvdGhlciBwb3J0IGlvPyBXb25kZXJpbmcgaWYgeW91IGhhdmUgc29tZSBtb3JlIHNwZWNp
ZmljIGh1bmNoLg0KPiANCj4gSSBkb24ndCBzZWUgcGFuaWMoKSB0cmlnZ2VyaW5nIGVhcmx5IHBy
aW50aywgYnV0IEkgc2VlIHBvdGVudGlhbCBwYXRoIHRvDQo+IG90aGVyIHBvcnQgSS9PIGFzIHBv
aW50ZWQgYWJvdmUuDQo+IA0KPiBJIGhhdmUgdmFndWUgcmVjb2xsZWN0aW9uIHRoYXQgSSB0cmll
ZCB0byByZW1vdmUgaXQgYmVmb3JlLCBidXQNCj4gc29tZXRoaW5nIHN0b3BwZWQgbWUuDQoNClll
YSwgdGhlIHJpc2sgaXMgdGhhdCBzb21lIG90aGVyIHVzYWdlIGlzIHJlbHlpbmcgb24gdGhpcywg
ZXZlbiB0aG91Z2ggdGhlDQpjb21tZW50IGluIHRoZSBoYW5kbGVyIHNheXMgIkludGVuZGVkIG9u
bHkgZm9yIGVhcmx5cHJpbnRrIi4NCg0KV2hlbiBkb2luZyB0aGUgaW5pdGlhbCBURFggZ3Vlc3Qg
d29yaywgZGlkIHlvdSBndXlzIGNvbnNpZGVyIHRyeWluZyB0byB1c2Ugc29tZQ0KYWx0ZXJuYXRp
dmVzIG1hZ2ljIHRvIHJlZGlyZWN0ICNWRSBjYXVzaW5nIHRoaW5ncyB0byB0aGUgdGR2bWNhbGwg
aGVscGVycz8gSQ0KZ3Vlc3MgaXQgZG9lc24ndCBoZWxwIHRoZSBlYXJseSBib290IGNhc2UuDQo=
