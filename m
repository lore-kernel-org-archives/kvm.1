Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795461722;
	b=Vm4qGBUMJNlrRODrpJjTRY4es6vZf2lS7k42kAPpoJEKBxI9kPotaeRkaB2nbocu4ZY5
	 SZ8DDzT8yGCQm4K6RcmCkags/rq2n2+cOH/tnPQdyRtJTr9NpZTPoy6d1FE38c2yUxFM2
	 jg+OWVI7IUoY9GXi/DLPfcloydi0/tk0YzuYdMc2+QA3ZHVAMfTjSdAtXQN1ycdpwQhhX
	 31GrRjLIOi0/0bOKdKeBf0yCoV2B9l7zYZlOXiwXOQooVulpPVHvmqmPpLdaG1AX3t/o+
	 CxLw36kGAtVzmxAjX+foAfnKmQsbJjga9Oy61Dfe+LlGrfwTfLWT2TcoaNZBWLXMs1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=IGRmtp8NykASxeVMWbP49wLw7SQdcqYP7IR7WG3o8Q4=;
	b=GHWeW9gHsv9l8mMSAhpbMC7xptvkxY5tbrLAJPYWlLRliIaPEzVhc6zd8QxIwfVHk+YU
	 fVB/fa1B7cn6djVgcVBkDWtf8DNWHxQXjJenhLyRv5uCvdYcqMaY5vFl6TwKZc/5mtFh0
	 IOEzlNmxbLyByKR1+REpIPrEMuCMRnbDNP4Ykm6afVGfhzaU9JoBJS5kmD/z69iYlHlpV
	 UoJhiEY+En7JwXN8q7Z/uQy9hD/8CI8mc8qwTfWrKlai1a3IHPzjLjapbxWwrPvm0MFqm
	 mYgwOK06/rXPWvDdWX29hL/da83TM6L8DWov7sIoKK/lbb6y68BY1fZBRpPeT+kVHpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fkNoL9m4;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VcwiGX9V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808D606A32C;
	Mon, 23 Nov 2026 19:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0808D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fkNoL9m4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VcwiGX9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461723; x=1826997723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IGRmtp8NykASxeVMWbP49wLw7SQdcqYP7IR7WG3o8Q4=;
  b=fkNoL9m42sPut3/uIAH9PAluXgZTptouHqBYf8LPRBmjn9woNqUIBaNK
   zbk2uRdLNtFRYHnbEIWutva6lLxoKQjgVTsVl4O/O/bRGDruZodHVjYJi
   UQSdAaiQ3QmNN4R4sxGXukpasE5TftxSWxmqx5ReqM6P8ZrnwMPmrUfX1
   CFjlu4tc/T/U6b4iUXoBjG+YbO3o7SCMMaPGC+zA1aBVENRKjd9zBh1DM
   GnrNMSieZU8o+9h8mmVBXKrZJIcTG7XB4sfjE/dEbyxhsI4r3l6R4h+sT
   V48ZDQ+KZXF+kx1LwcTjvvm2UANi61VPRwFUT/Yy0/tw5UpGz3J1ppMAq
   Q==;
X-CSE-ConnectionGUID: 2TvZNUp5QZGkPTalYCaFVQ==
X-CSE-MsgGUID: p5LKSrSdQMqF92EzuhYauQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4158964"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4158964"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:22:02 -0800
X-CSE-ConnectionGUID: L0Om0LeESCeguFzg9KBmDQ==
X-CSE-MsgGUID: vtI16JPhR3SnIhoBPRTqgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11487862"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:22:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 11:22:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 11:22:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSofb4PuY5tobXdz5ydcXBtc36USt4yKTQGTz4fcf4hl1npIVVn3wBcvCx8+xoeBg9mEcvsD1AlHtQhwc1RM+Kj/XPC6Ap20ZVURLIDq6UpEZLOHL+2czm16dW2oxx3dbADcXdXbJPk3o65G5B19avVGJvf0Kk4fqY2AipLp8VSHlmvkbz+hNoxPMp5FgWLa/VL78f38kRS5P6jGr0xepR4YOcMPlP1GZtGsHWvkXvIpuYDVaAs2bSCU5VZSDuqZ6NwBTp7tmFShpZEJmUz6CbwBWRlLY3sbR3m67BCl956btUg9lNll1bjrdAM990KBb07BQQmYflqZ94j8gZZrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGRmtp8NykASxeVMWbP49wLw7SQdcqYP7IR7WG3o8Q4=;
 b=Zpj4Psphzt6TBfndVYYQ9Z+XJRJPxB1dhh1KAdNvKXfkUGFH50UofurMzy7IiupfvERi+gexzqYWYDGZbTXOe/fmHQqbaxa8WebjrLJ0RDcjBE3+coNUYfNPQH5DOjbeD+NW4Ndw/Ogxvx9q6eCOcc0b01q1l/zRM3Lbsjn6FjKTHzBAn5D0UkHdmTSCcj6JeHQa/Am2Uk7SwVIdFwNo9y6RSkdv5v5K0evYDW+pleozqb2GjrOYn+6gCFNUZ39J1JtJy/46dVAmkwoA6a/BB/QR+sfPPc45pJEdd1utQin33rYFXKyPgtVOFtAOQeMvJ8EJoN9dsxzfPDi6F57njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGRmtp8NykASxeVMWbP49wLw7SQdcqYP7IR7WG3o8Q4=;
 b=VcwiGX9VJrMeEUXmCdIAAUahWNGbmvYSpeMWq4CLVv5z5HdUoTcqS7noCxjPTQvNJx9BAmOtFwA0mYnnH1mr7Tp1okSQ/UvkKUwzfutUIBE3M3ltzyxSMN2DOKrxO4EfTm9wZKk9Wub7+EupUrKvxABqg/3OFqGSkuCUvB7fdUE=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SJ2PR11MB7600.namprd11.prod.outlook.com
 (2603:10b6:a03:4cd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 19:20:11 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 19:20:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Topic: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Thread-Index: AQHdd/pYq2tDAwcl1U6sJtduQEFN/Lc1soOAgACTcICAAM8QgIAEkvaAgABnYgA=
Date: Mon, 23 Nov 2026 19:20:11 +0000
Message-ID: <41dc795ec6611a1998e94d8b422172d1cb588df4.camel@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
	 <20261119074925.3933804-2-chao.gao@intel.com>
	 <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
	 <av-3OatHEGZXmWr0@intel.com>
	 <c5940627-54df-4ce7-86fe-f73520b61791@intel.com>
	 <awQ7Mb0atIOtP1D9@intel.com>
In-Reply-To: <awQ7Mb0atIOtP1D9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SJ2PR11MB7600:EE_
x-ms-office365-filtering-correlation-id: 42392495-d6f2-478c-807d-08df4996cb45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|261022075727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 5tsRX0bavxLcOPWsP6SlKg0JhBnoQnH3iMPJA52qfxW5ZyPohVM0C35PuiPEmAh62OxeQ8qCgeAfXCG8lSAklo7zNXWpJ8i9Gv80VGYHgAgJHJK7PXNyso01tIUQUQNlAu1wahDsAJDPczW20ap61KUWeSLkV/qlQ7cqDqNAAdjtdmrO4rLz+6hWj71zVlunrjF8Kq7v88Rnktgx2xoz5VsFppMpZ4LPCLcoz4gblaEP5QN3it4JSRJUpJ+dyVlLRDo1UYQjMxSTmbPRMdQrKvznR2a8izkNuzMZr9EX1W8AL6o34RJgxZz75XejovrvNVkxxmZETqPTIAlLNSVhHpo7LY1SzeN/Jr56wp9mIV6MrVi1PPMeXrUD7ZuN0kcz0i242bs/r39JF4Fo9TBADMmiczQ8R5elCOveT7z/I3xVOvTvhIdpRvqCASV6KRCmyTdCDXfbNWiYV9YjvW4W45odtW+0Iob0IjbBDJr1QNhjZ6DC1KP525z/qBBorvl4bNqyl3DnCHRP+MjgstLpKsFBmnSARmUk4z9ajiYzXr4lSuGkOMHxdh6i4PHp4RrX0GkUm0TEU8SYH9G11+kbHymVhrZ4p5IibJNbhF7rS3VgAWB5Vq0ut5DNngELEodL/96WFndhYSRGnF1QfUaECPOmlF7n5H4VsVvMBogzFzwDgXqwf6Ewin3NjUBymPJSjNkLt8zx0Ql4EgUSOmO06/u3arTW2DL4DIt+sBZTz5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzlWOVhxZXdmSmxzcjdRRllxb3ZKZ0JrTThwNEJuV04yZlRCU2VlSFh1cVlk?=
 =?utf-8?B?WnBtWVY1SUVlc3hQd1ZSNCs1SklqT0kzRzJVSW9vakxjWHlPUlE2eURwT0hS?=
 =?utf-8?B?TWRlNC93YzI4N3BoWU94OTRPTndLWXJFeWVPeGlpUWtlR1lyVm5KdHNpYmR0?=
 =?utf-8?B?L0ZEVkZSa2VGUmtIMEttSEFEbnV4eHZYM0xBT1BwSTdCejFmS0p1eUdiYlNw?=
 =?utf-8?B?SjBwS0JXQWVIQlFNOGhWVjhxWkt2bjRRbVNRUzBLdmhNMTkzT0lsUEROWlVz?=
 =?utf-8?B?WkVObjB6Y1FpZXMxOGdCc05jOTlqVHFUVTRHQVBxU3hlK2JQYXBiNkNCOEFP?=
 =?utf-8?B?SlBUYUNOeWJ3UndubWxXbXZNU1BHMEd5VGVuQTU3QktYOG9CNERmRWprVk9B?=
 =?utf-8?B?OStNdTdJeFpiRWJXUXF6N3Nuak9JV1lXK3ZkNEFSc3BMeHVaRG1xK0RCeXVZ?=
 =?utf-8?B?Nnd3WlNZSlhBWEVseVg0TmJlaFFUOXlsT2lWOFdsTk9rSXNSQW1FV3FjcUpv?=
 =?utf-8?B?bjdyRHZiTXBKWTVpZC9vNXFlNldOQjZYMEkzeHRjanFpNGo0aDgvRmJVcE12?=
 =?utf-8?B?Y1FpTzNLYUxMdWNxQWpDRlR2dTlyaGgvWDhZRzA4QTNVU0x6NjMrQU1vVVFj?=
 =?utf-8?B?dW9Kdkg2NnA4VW4vRmMxNGVlMkdYVjMxY0gwNG0za3JCeDJoTXNmcUpGSUtT?=
 =?utf-8?B?WHdyTXEwOUNsVlpNUmdabnpGL1NlaC9CeDNnUEI5OTQyMVhnZkhZNWovbkJ4?=
 =?utf-8?B?MEZtY3UzRzZrYzdBNndNeGdROHBJdG9wVE1ncGY4UysySTZXbTUzbHZkMUFQ?=
 =?utf-8?B?c1ozMzl6N2F1Nm5tb3RiZnoxN1djdUplRHR3akZDem9IUExRTmdxY0tGZGZo?=
 =?utf-8?B?SzJFeWlMemkyTTFZZDRweEEwMG4yL2h3Tm1LRjcvWWlncmtKVmJNbU1XaVRx?=
 =?utf-8?B?ZVFGYWVZSFlRTG5pRW5UTkVNVHpKN2ZpbzlUSnR0TGtCL1dqYWt5OXpicVVW?=
 =?utf-8?B?STBYRGhpN1loRmRUVDEyRnA1M0tVblg2UXNBUDZRYWg4ZjUyaHpYZG9QbS9H?=
 =?utf-8?B?OTlaV2Rza3o2Q2gvMlFsbk1ZY056V3RTOGNNUjZoVFpQanlWNUExRVJ0SWVN?=
 =?utf-8?B?QmJFaTBPYWhmZk9GWXFhb2dSMkhILzJaQkl0dDNCbGEvMGIwd1dEb05HSUZr?=
 =?utf-8?B?dnRwcmw5ZGtkOFgvTEUzZkFxUnQ0RnI2UTB3NWYvUjRIc0xhS3BFOWxGTVYr?=
 =?utf-8?B?VnZrTWJPZERReE1OZXdZb1BhUmt6Rm9RWjczQVVvUi91SjllaC9LaUUzZ2dW?=
 =?utf-8?B?Tko3QmgzTEI2R1pmc2NzbFJ4SUpyVlpSd0dPS3pGOS9RU2pINEZValhOTGNE?=
 =?utf-8?B?dzdWck9aZHgzSXBUVytiWW1jcVJMR3JyRDViS2VnaWQzU0U0RjA5Qnp2NGFV?=
 =?utf-8?B?N0lTV25ZQXczYXNnUHJwUitYZlFHRzN3V3ZVaE5SS2ZZeFZaRWlWNVAwTGxM?=
 =?utf-8?B?dVY0elpkeXNhM1QvUm8vWHBJV0p5Qk5qdm94SHRNOXFlUEc5VmpOUFZzVy9m?=
 =?utf-8?B?S3BNTk9XeXkrWUJ4YVpqOEpVUnVhMTBQNWRxdnpjdjVxbnppcGQwUVB5R3NR?=
 =?utf-8?B?VjdiQzBVNGdpd2ZuUzE0d3h0WEJrZTkzY1VhY3hKNnBCeXlucG9MbXMvRGpv?=
 =?utf-8?B?UTN5Vm5mN01jOXp0dUdpMUh5MlV2MUJxMGxNRVRKcnFnZlBwRUE3R0pWWUEz?=
 =?utf-8?B?VnpRelJhY1Vhd0ttTmFiQWYzc1ZHODNCbWkvV3hiSVdEUm9yTEI3RVIwRHFF?=
 =?utf-8?B?OENicUgzUVA5TndNUTMyK2NjMFBwOXM2ODZ3Wis0aUpBMGcvZjNISXhKRVZX?=
 =?utf-8?B?OEExTFpWblNmR3hIMWJJeDZBamdWNjFQRVNnSitQYTVhcTQ3SGNrRXVjUGRJ?=
 =?utf-8?B?ZVVCN3AraHpWTy9Gc3VaeHZEcnRpT0pQeHZiMTl4SjdlVFRybE9kYVYzdytp?=
 =?utf-8?B?VDFHbnlsT3ViNEJENHFydThtb3Z5dXF6VzhRMkl4bmdHeEZKNmpLWDc1bk1I?=
 =?utf-8?B?WXRzKzRvUXdieWNwMFhLb1dnckh6eGpUbUw1aGNMUUE1SU1BdGNzQzNNREJW?=
 =?utf-8?B?TUFuNWxTSGUybW45MHZObnhyNGtvQXNTV2dwbDE1YmErSjFwVHk3My9TNVBE?=
 =?utf-8?B?TzRwdzlGTHVEeVpSY2VnYUcrQmJxVFlhb3NjN2YvY2Z4anZ4M0twUjI4Y2Nz?=
 =?utf-8?B?dmErUEpRcEFZUDFYdGV5QlR4OXNacWRwOHBGYVlGZDcwVnJxQU5oUmpoSitz?=
 =?utf-8?B?S0lrY3B4cWozb1dHOGNrNWFTZDVSR0dPWFk2L3pnTTJ1K1A5UzdwQU8zZnpK?=
 =?utf-8?Q?TueB9gp/6IokofdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FA4CF119D998145899FAA2CE2C9E92F@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: RpVmEkU/d3acx3MfeaEJZxXZHtE1rJVVtZGbZR6oRwk6ufxSOk/DaIE+7rBLQoKXxwfkj/ohyk8dkONLrmR1b5JqeSD+5CIRbsOCC3GBgaB6f4tUVBFmsdxxp9NjaH6xAdFf+V/jB77pq8QqUPMIgZbbXk6eGHVOx/I9NHSfTEuIJs/14JAKEOY9S9NdeWfAwWNvYJ6Vyva7RfCvFkfzDsvbFy6wQdpmuCPGKolfxIu6kLYUiPf+gr1ve1RVd+AhIWehfsfhLsMtHqHvuCGhwTVqUJna0gP0lrMgSqGLo2aj7DsNN3fi3i8vnqX5DmiEdF9jrRrpc+GgY94GyBrrLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42392495-d6f2-478c-807d-08df4996cb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 19:20:11.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dgcOSz/igpYliZwmTSq6PzleFeBuR1xOViZQSBy8TAjvRhGfMXxmmWcao4NArPbCbZE4VYD5xAt0qT9C89S3VGxABNs24DxZrsglyx8TFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTIzIGF0IDIxOjEwICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiBX
aHkgZG9uJ3QgdGhlIGRhdGEgc3RydWN0dXJlcyBsb29rIGxpa2UgdGhpcyBkaXNhZ3JhbT8NCj4g
DQo+IEkgc3RhcnRlZCB3aXRoIGRhdGEgc3RydWN0dXJlcyB0aGF0IGxvb2sgbGlrZSB0aGUgZGlh
Z3JhbS4gVGhyZWUNCj4gc2ltcGxpZmljYXRpb25zIGdvdCBmcm9tIHRoZXJlIHRvIHRoZSBjdXJy
ZW50IGNvZGUuDQo+IA0KPiBGaXJzdCwgbWFrZSB0aGUgcGFnZXMgaW4gdGhlIGRpYWdyYW0gY29u
dGlndW91cy4gVGhlIGRpYWdyYW0gc2hvd3MNCj4gdGhlbSBhcGFydCwgYXMgdGhlIEFCSSBhbGxv
d3MsIGJ1dCB3ZSBkb24ndCBuZWVkIHRvIGFsbG9jYXRlIHRoZW0NCj4gc2VwYXJhdGVseS4gSXQg
Y2FuIGJlIGp1c3QgYSBzaW5nbGUgbGFyZ2Ugc3RydWN0dXJlLCBhbmQgdGhlIGV4aXN0aW5nDQo+
IGFsbG9jYXRpb24gY29kZSBpcyByZXVzZWQgYXMgaXMuDQo+IA0KPiBTZWNvbmQsIHVzZSBhIGZp
eGVkIG51bWJlciBvZiBwYWdlcy4gVGhlIEFCSSBhbGxvd3MgYW55IG51bWJlciBvZg0KPiB0aGVt
LCB0byBzdXBwb3J0IGEgbW9kdWxlIG9mIGFueSBzaXplLiBCdXQgbW9kdWxlcyBhcmUgYWJvdXQg
Mk1CDQo+IHRvZGF5LCBzbyB0aGUgc3RydWN0dXJlIGlzIGp1c3QgMTYgcGFnZXMsIHdoaWNoIGlz
IGVub3VnaCBmb3IgYSBtb2R1bGUNCj4gb2YgYWJvdXQgMzJNQi4gVGhlIG51bWJlciBjYW4gYmUg
cmFpc2VkIGlmIG1vZHVsZXMgb3V0Z3JvdyBpdC4NCj4gDQo+IFRoaXJkLCBkb24ndCBkZWZpbmUg
dGhlIGVudHJpZXMgdGhhdCBwb2ludCB0byB0aGUgbmV4dCBwYWdlDQo+IGV4cGxpY2l0bHkuIFRo
ZXkgYXJlIGFsd2F5cyB0aGUgbGFzdCB1NjQgb2YgYSBwYWdlLiBTbyB0aGUgY29kZSB0aGF0DQo+
IGZpbGxzIGluIHRoZSBzdHJ1Y3R1cmUgY2FuIGxvY2F0ZSB0aGVtIGFzIGl0IGdvZXMuDQo+IA0K
PiBEZWZpbmluZyB0aG9zZSBlbnRyaWVzIGV4cGxpY2l0bHkgd291bGQgbWF0Y2ggdGhlIGRpYWdy
YW0uIEJ1dCB0aGVuDQo+IHRob3NlIGVudHJpZXMgc3BsaXQgdGhlIGxpc3Qgb2YgbW9kdWxlIHBh
Z2UgYWRkcmVzc2VzIGludG8gbXVsdGlwbGUNCj4gbGlzdHMsIG9uZSBwZXIgcGFnZSwgYW5kIHRo
ZSBmaXJzdCBvbmUgaXMgc2hvcnRlciB0aGFuIHRoZSBvdGhlcnMuDQo+IFRoZSBjb2RlIHRoYXQg
ZmlsbHMgdGhlbSBpbiBoYXMgdG8ga2VlcCB0cmFjayBvZiB3aGljaCBsaXN0IGl0IGlzIGluDQo+
IGFuZCBob3cgbG9uZyB0aGF0IGxpc3QgaXMuIFRoYXQgaXMgbW9yZSBjb2RlLg0KDQpIb3cgZG9l
cyBpdCBsb29rIGlmIHlvdSBqdXN0IGhhdmUgdHdvIHZlcnNpb25zIG9mIHRoZSBzdHJ1Y3QgYW5k
IGNhc3Q/IERpZCB5b3UNCnRyeSBpdD8gSG93IG1hbnkgbW9yZSBsaW5lcz8gV2UgZG9uJ3Qgd2Fu
dCB0byBmaWdodCB0byBzYXZlIGEgZmV3IGxpbmVzIG9mIGNvZGUNCmlmIHdlIGVuZCB1cCBuZWVk
aW5nIGxvdHMgb2YgZXhwbGFuYXRpb24gdG8ganVzdGlmeSBpdC4NCg==
