Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027901;
	b=3VcUp5MLL6poGqYoFvcgXPZ64XX5wNkkLX/pMrZazsfai3tILfY6mGLKrmA6U61QTuZV
	 XYMGr8s8alUVeY7OIcRBJ9+Y54YnPkBa0/tkjCAFWavWAJRcHOabEy5Ud6C/q2Fl1smBb
	 +/Pa6rz4PvmfjkbRanebXMBZb7MK2IGmPakTggdJ6qskEX/N0kWL3Oz9T1VezWye5+jnf
	 O/8iFOx9lCtFQI0922CZoBEqtQtn438Rhp5qwHBiGWbCIU1DtC9f+DoVOjJPOGDf0rZQi
	 ycHBZNakMM7sizVIqIx0T5u9GyAsxr2RK9PceGqsncz1axlkDWJMjLHYDyDEny/SD0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027901;
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
	bh=jjPOq12o1WGIIEBcKNbeX8phJUIseGLMwf3K+H+luKU=;
	b=zZD93pHmQzXZFoLRXZr6CV8NR+ES8jJdi9bDCR+XGq574/83ddn4HpgmIdVWSdZDrvAd
	 xRGTwUNWRQJ/J/tBnt6VCEtg1oGwkwvzSETHhoV42/BkcNyb81drtFgcV3CwL/i212A91
	 ISdgKnc0nxZ94dtb3RwV/0Qc7R0HbwOAsm393B9X9QxWW/y+hg/N8ScEHkzb70GTZAQX1
	 DL3XQG6FYrd7ThzVSfvR8nNgX1ZQtuljqtlDs9sbuNxdVQZZQIrRZ8tR6c8+Xu5BMY2KF
	 hqPbASZq/qdOjieTVOEEVpPkiO1QKstnQBDnIm93JIkcNWrU7l+kcng3B5aD+zNgpZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SUIqFgbU;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NyTqc+hc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42215606A320;
	Wed, 18 Nov 2026 18:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42215606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SUIqFgbU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NyTqc+hc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795027901; x=1826563901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jjPOq12o1WGIIEBcKNbeX8phJUIseGLMwf3K+H+luKU=;
  b=SUIqFgbUmoY8Gq5Ob2dHt/fka4m0PT3Gbih7GLCbRDe2Wy2arxKN8sgN
   IFhXz37cYdfIRKmWXwjKbSb+k20O5rJ1Y3gufiWIJMY/v1s/407vZZgGt
   B9MXn8c2OED23vRldcH4aGfLVIZ+X1e8fe1oQdadCDHWt4+ik6I+PXwWL
   jWIPXmPvv0jIRqw5aSEqU7bi18rDVjjT2ru9anmAG9ossajbAF2OQqrcA
   EDubxQ/yX8XX1dg8IUOeXFUNhIsN9gT8BqJbw8t4l0HfgLwAS/yA5/Rk2
   1rJvCej1ZpYUGE+0NjCYw5tTjKMsDb30AJDSHHI23up8Np9c4fT86gvpL
   Q==;
X-CSE-ConnectionGUID: HJoJU6xWTEeKSe8UoRAFjA==
X-CSE-MsgGUID: X/dGHyRtQ12P6fdPurfVxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3748134"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3748134"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:51:40 -0800
X-CSE-ConnectionGUID: 8OvV5SbBTGKjAq2bfZ6Uzg==
X-CSE-MsgGUID: x7MPtCN5SGWKClLrIjduMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10490636"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:51:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:51:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:51:38 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:51:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6fgYlzjt9TNvUTO27jlUwCLJrcw4KkxYmn1+E8PlueFSddJr8fYrTHyaEESl2dv41XdCJSGLmRWRHyCWd8UBfs/P3UQy33P+BCAbWgZ+X7akFh7N3EOjYW5NdA7n0fkAsXYWqJW3QV64OYAena8FZJE0wEJxRci+tPMr7BeRdewrIpwjPfQhBVRzkXVHeKST6kqTyvdQUbwWmXguv9kylsiAySNtRiOpjinPi8oT//699C1BzjJk21kSnlWmACJJR8qokj5p3ONHWoWyd84fMwoZRI4ibjfiuLK3cHphSu0jtDEN5vzI+dPyY3IKS1Q1ioQL31RlYLLNKy2LkGO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjPOq12o1WGIIEBcKNbeX8phJUIseGLMwf3K+H+luKU=;
 b=uNrY7vNmpJGT4aVCHrnqAINT4Q8uhB962pi1ueQMTMHFrJbe1+R9R+ly7G0HbuPpus24ZWe6LhP/Iudp8aJyO7DZl2GfcK5wXjr0/s+Jqq0Vtbw7Ve5o0qN15e4E5P1u4cz2BiJYpAobyeHw6Y0YyVuDwHTEXlf1hmxUMYohAS6ZHiUg0aGZu031Squ1kXRvYuzpU2346aqVwfTbqTVa4pj7zomBueVUxfFHAd2B/CvXcoGnhqPRcOGUlJpWEc0ScgGkAiWsHGGHU/YbKwU3phpdp8s8q7rvzO+zcHoWq7RxIGu+5TbmAU1r+IM+BhqpCFPWeHW0YUFQoRmiHnKArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjPOq12o1WGIIEBcKNbeX8phJUIseGLMwf3K+H+luKU=;
 b=NyTqc+hcQmFL9S9gcJAJgDiWW65fm2snou39A79zp5j3D6qQMtcAnkiRgWkenRllekl2M6E9PoK7opy8WFrhPoiSVPPn8qBLJidblCGa1peGWV+ciHbMJxHT18sp06iNgWB7t73Tjl6KzYDbqyl+52lvcSuWB2yEKbZL96eZ/Ow=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS4PPFDBB3A2AD4.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:51:30 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:51:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v5 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Topic: [PATCH v5 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Index: AQHdcZC7NZy6UFpkEEeeXJmLKEhvTrc0OIyA
Date: Wed, 18 Nov 2026 18:51:30 +0000
Message-ID: <cbc0c92dba00c04fc538f40795c00f94c53d5bcf.camel@intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
	 <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS4PPFDBB3A2AD4:EE_
x-ms-office365-filtering-correlation-id: 31704ff8-76f3-4374-f050-08df45a4f545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|261022075727099003|261021123027099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: XJvMqYrtmaKzf8mYQHbu1AfbrEmQfAfI0ar0fAZKNCBGoGAIdqzBJCT5+shTtw7svsclEoniY/FCBegweEbNfoi87cbP1o2nPY2cv1GZob1R1xfgZSadctCOis9Ur+XCfS/DWpvlcxJ6Bqarlv9yYf4BjfNgeREmJE3rd/v2nTDt3wLzt6pY+iDykxVu2arh0idfXS7Qfj7vqjfA2xmgLvKgAzbRlCMbu/BSNSvIasGMj+jb039gVv9gxCAErZ1Fdt3ukgzfjecbx8lxBb0eW+paajQFHTfsZCdYBbGMpA04zh2UgPsKcNfccC4ZuuPDtZW/6oa4vTiJm59hakKJBEOSnYAcsuZdfIw4fNoHyRORZvlU74O+hEqn7nnbi5aDWaOAQLTal9ozdl11POTbLoxJ9NoCq8PvS6JWn5PvHyLpK6UhMdT3GQxT2XSO7iturqyqS8R0C/recynZM4Ua7h3VeiX1dy9zbcUaG5CkYKIkBeWXhqkGzqiK8sefLY34YyVBAo2N0TxDDIh90L20+nUIyA49rwJ4GUr49LYP+/lTteAMZN3cQkMkaRodislLwpwYwi7i7Z6Mk5gHuGYl9S1pzUoWklTkH73Mkbbg0daGZ6rU+NKNi2/wZg7pyGfIW0l8x2zTwRVJrUkrXbPEumKujXfmwzMQwHL6NEeddqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1d5WGoxaUpBaWprVzBvMEF2RkNUZjU3WjF5dHI2bVZyeGxOUm1YQ2xiYWpM?=
 =?utf-8?B?Z015Zm5XYnJCZCtadGl6QkNZK1hlaU8vTmc2U3hramo2N3E0OFBXYy9EUlpN?=
 =?utf-8?B?S0hkeDN0UjJKR2p2VThHVi9GNEM2eFBkSnZEWlVzem5iTzJHMXJVWnRNMmIz?=
 =?utf-8?B?MmdzZDdrMjJQL1AybFVDS1I3NWE0cURlR3EvZ094Y3c3NlV5NWRna01laDFp?=
 =?utf-8?B?V1YwMnozL3ROQ0FmUmlmVmx4cDFnTlZNOEUyR2xCVjkwYnBEaUtVTjhNWlBh?=
 =?utf-8?B?bFNpbEY1bzhRL3lzeWRxYlFoQVEyOTk0WE1TTnc1RVBNa0JYa2JOYXZaU0dS?=
 =?utf-8?B?TklFTmIzMGdQYlBJeUQyeTZDbDBuV2RQUGxpSDhLKytZVEE0K3ZFNyt6WGYr?=
 =?utf-8?B?bHFhY1hLS0Y3TlF3NUY0SGVMT05yZnNhZkQ1VHQ4dDhMeUxpU2ZkcW1JcE96?=
 =?utf-8?B?d01ET1N4bkg4VktENW9RWGEreGxXTU9vbDBQL0FWekd3WnhEd3VjQXpBdTlq?=
 =?utf-8?B?MGczZTc0WEZmVGFRazNvU2dEWnY1bisrMnhEcVhGV2xUd3RrMHZEc2Y4L2tE?=
 =?utf-8?B?VklabVNFR0RQNHZhbjFwQ2p6S3FyQXVGengvSytNOTN2OFpzaGEzZ04xOVJz?=
 =?utf-8?B?SEZnN1NkWlFBT2ZZeGdVd3p2VmV0MjVvYkk4c2RJc0twZ2JpWGp4SkV2VWdC?=
 =?utf-8?B?Q0NDSGNDS3RQWk5TREVydnByeEgxM0Fxd1IwZUFDazM5cW84ck9va0FQU1VY?=
 =?utf-8?B?VjBIQjhLUkpKNnhGTDhieXR1YXRUbEtCSXBpUWliYTdnN1ZCQkF4YmEzemZv?=
 =?utf-8?B?QnR1eFQxK3FJdTJFa29VcFA2ZEdhUHNkNFRCbG1uTzZwckxVdFhvUGNCWGlF?=
 =?utf-8?B?RlZrNStEZS9OMml2TGM5OGt6ZmY1YVlBY2tORGt2blh4U0xYc2ZKTHE5Smdn?=
 =?utf-8?B?MXczY2VrVHFxNEVSUTYwK3FacXFUUDdDNlkyMUJNMDJ5VTd5eUdQKzJrTUdx?=
 =?utf-8?B?QnRhV0o4U0NOZjRPQmNhdzEvb1VwTmJUNVNDL0NtdURPd2tsblV4T1ZRQ2N0?=
 =?utf-8?B?eVloVWhKWG90OExZSGwvS1FqNGl3WlMrYWx2VFRQamlXaGVrQWlHT1FnSHB0?=
 =?utf-8?B?RmVJcGp3Y0NQalhiSTFhUlViVG5uWjZGWENmNi9hZ21VcVg1b2RMejJzRFYz?=
 =?utf-8?B?SUgxNW5CVzE0eXFtNzRBM0RqeGVObDg2RFUzdjhaamJmZ1gwYkJMWVc5WE1X?=
 =?utf-8?B?NjBkTVMxZDBZWkZsQmx2RHZiTnQ1WU5LbVFjeUF2Z3BCdHNKOUxoVjZrSXRl?=
 =?utf-8?B?NmdHWlRmbnJjQ0lnOEtyTFlUNDJ5VStCOEtURXJwRS9jOHJNcXU5KzFXWS9G?=
 =?utf-8?B?Q05YV3B6WUF3OUsvWWZWWGlVSENrc2hwSVVORmhYRExzQVJ5R2M3YmJxdm0x?=
 =?utf-8?B?bHBHTEF0LzJHRUlkQngzaXNGVTZ4NWttZE4vTzcySnd0UHd4Q0JUNEYvTlcy?=
 =?utf-8?B?NFR0M3lQZW0zcVJWUjJFcHozOGYrZzUwOVBab0JUcXROS1ljWVIyRWZWSFUz?=
 =?utf-8?B?dlFFNjI1SUJGazkyRVZUVzQ2cms2RDRCWjdwaVZOUkFHaHV5czgwYnM1empn?=
 =?utf-8?B?UTAzNkJXdFh6bm1BT2h6NnhIcGpLS2h1QmhLTEZRdC91QlhSZ0F0d1h4MFR3?=
 =?utf-8?B?ZzdrY1oyWnJCamEzb0h0UllTT01CQUY4L2liV2x1M3hwRXk4YnpaUkM1TVBO?=
 =?utf-8?B?TTdubjMrMHBCOFQycHlQTkpRaU0yK3p6dkVRY01VdmI1cEJjWTBQYjVNOXFR?=
 =?utf-8?B?UU9JTWc0WnR5ZmwvaHRUcGlrOGs1SUNVMlZkS0ovNVF4T251ZFJkZHZ3ZktT?=
 =?utf-8?B?R3gvZkZCOERLdkNxOTF4K0JySVB3blZZb3BrT2pULytPL2hwdDUrRlZ2c0dz?=
 =?utf-8?B?YmZYb2pVRmN6OUZtUG81a1JIdSszVTN1bjRaK2RsSWxreUpsZTd1MjNFZ1g3?=
 =?utf-8?B?UWdlVGhZNDJvTHNKNnlUaERIaGlWQlJ3OGJ2OFo1Y3IxT1E1ZndXL1FYcGhQ?=
 =?utf-8?B?WEhjRlkvQW9HT3RrUlFxVVdMa04rT3dxdWp6amxQRlNuNm44QzNDMEM5dHdo?=
 =?utf-8?B?bXdUOVhHbjlaL2locXNuYjdnSVJrckg2K2YrUHBDRG1QSHFBeFc5VzU4WDFK?=
 =?utf-8?B?bUNndjFZL0tjTmk2dXoxdm9GUno5aVJXRmNXWGJWcEYxdlJ5NmNjNTlxRVgr?=
 =?utf-8?B?Si9LWXJGNEs2ZHJmSG5Sc1lvUTFEcGZhd1Y3TFlTaUF1NkxRMU40Nk1sa3pN?=
 =?utf-8?B?TFkvRkZMNjRPdzN6U2ZxS08xc1ZRekFDRk5zNnF2VmkybUFGRng4Z1FETXQ5?=
 =?utf-8?Q?YAL/RzId0YUhypSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24BC5B556BA2BE49AAE5B32EDA3BB604@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: JyCxiC7Q+5KAotSKRu8gpFDsfgbIMXb5qjZTAq75S6K1G2Caq3iuzf2morP9kFKCBGlwj7cRbwOEO7CF2Z3GQ14Ex4K2b//rkvGnUWZSpdamr/rSXpa/hhzERBleXQqND6REv5nxwYDTpH/0VxZILO3ID+FUFF8Wa99OF3feaFVfx+XPtN6DCGcvxFLz8AiAdPPDu5USV1thcIVjFLY8JDKR4uTJHfhom5EG6tGqqSNOlkfipaK+In+wgs8yhfUWZw+JnFcLBtDvPl78r3h9utIzgr/jiUt2c8t0xWiHEqsNrsErZhVovqUE5j/9+HFZibVP9LbvWlqCXJcKWMwfcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31704ff8-76f3-4374-f050-08df45a4f545
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:51:30.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKXpFO56XZ3Z4CfXP4O9UMGDrjm8KyZtibAnNTBdxdC1BABuIvMhTtcCaafTigrgcYEe7+DB6ZV2eaC2aPgViZAJcA3cnwY2VuINdL4by6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDBB3A2AD4
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTExIGF0IDExOjQ4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVERI
LlNZUy5DT05GSUcgaXMgY3VycmVudGx5IG5vdCB3cmFwcGVkIGluIGEgU0VBTUNBTEwgd3JhcHBl
ciBiZWNhdXNlIGl0DQo+IGlzIG5vdCBleHBvc2VkIHRvIGV4dGVybmFsIGNhbGxlcnMgKHN1Y2gg
YXMgS1ZNKSwgYWxzbyBiZWNhdXNlIHRoZQ0KPiBsZXZlbCBvZiBURFggQUJJIGRldGFpbHMgbmVl
ZGVkIHRvIHBlcmZvcm0gdGhlIGNhbGwgaXMgbG93IGVub3VnaCB0bw0KPiBmbG93IHdlbGwgd2l0
aCB0aGUgY2FsbGluZyBjb2RlLg0KPiANCj4gQnV0IGFzIG1vcmUgY29uZmlndXJhdGlvbnMgYXJl
IGJlaW5nIGFkZGVkIHRvIHRoaXMgU0VBTUNBTEwgbGVhZiwgbW9yZQ0KPiBBQkkgZGV0YWlscyBh
cmUgbGVha2VkIGludG8gdGhlIHN1cnJvdW5kaW5nIGNhbGxlciBjb2RlLCB3aGljaCBkZWNyZWFz
ZXMNCj4gdGhlIHJlYWRhYmlsaXR5IG9mIHRoZSBjYWxsZXIgbG9naWMuIFRoZSBmaXJzdCBjYXNl
IGlzIHRoYXQgdGhlIER5bmFtaWMNCj4gUEFNVCAoRFBBTVQpIGNoYW5nZSBbMV0gdHdlYWtzIHRo
ZSBSOCBhcmd1bWVudCBiYXNlZCBvbiB3aGV0aGVyIERQQU1UIGlzDQo+IHN1cHBvcnRlZCBieSB0
aGUgbG9hZGVkIFREWCBtb2R1bGUuDQo+IA0KPiBBIGZvbGxvdy11cCBjYXNlIGNvbWVzIGFzIHRo
ZSBURFggYXJjaGl0ZWN0dXJlIGhhcyBldm9sdmVkIHRoZSBBQkkgdG8NCj4gaW50cm9kdWNlIG5l
dyBsZWFmIHZlcnNpb25zLiBUaGUgaG9zdCBtdXN0IHNlbGVjdCB0aGUgdmVyc2lvbiB0byBjYWxs
DQo+IGJhc2VkIG9uIHdoYXQgbmV3IGZlYXR1cmVzIGFyZSBzdXBwb3J0ZWQgYnkgdGhlIGxvYWRl
ZCBURFggbW9kdWxlLg0KDQpJdCBpcyBub3QgdG90YWxseSBjbGVhciB0byBtZSB3aGF0IGEgbGVh
ZiB2ZXJzaW9uIGlzIGhlcmUuIExpa2UgaXMgaXQgYSBuZXcgbGVhZg0Kb3IgKGFzIGl0IGFjdHVh
bGx5IGlzKSBhIG5ldyB2YXJpYW50IG9mIGEgc2luZ2xlIGxlYWYuDQoNCj4gDQo+IEJlZm9yZSB0
aGUgdmVyc2lvbiBzZWxlY3Rpb24gbWFrZXMgdGhlIGNhbGxlciBsb2dpYyBldmVuIG1lc3NpZXIs
IG1vdmUNCj4gdGhlIHJlZ2lzdGVyIEFCSSBvcGVyYXRpb25zIGludG8gYSB3cmFwcGVyLg0KPiAN
Cj4gVGhlIG9yaWdpbmFsIGNoYW5nZWxvZyB3YXMgd3JpdHRlbiBieSBoYW5kLiBBSSB3YXMgdXNl
ZCB0byBoZWxwIGNvcnJlY3QNCj4gZ3JhbW1hdGljYWwgZXJyb3JzIGFuZCBwb2xpc2ggaW5kaXZp
ZHVhbCBzZW50ZW5jZXMgZm9yIGJldHRlcg0KPiByZWFkYWJpbGl0eS4NCg0KTG9va3MgZ29vZCBv
dmVyYWxsLCBidXQgd2VyZW4ndCB3ZSBnb2luZyB0byBkcm9wIHRoZSBBSSBibHVyYj8gT2ggb29w
cyB0aGF0IHdhcw0KYSBjb21tZW50IG9uIGEgZGlmZmVyZW50IHNlcmllczoNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMDNjZGM3NzQtN2ZlZi00ZDBiLTgyZjctMTI2Mjg4NjM2ZjNkQGlu
dGVsLmNvbS8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4
LmludGVsLmNvbT4NCj4gTGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYw
OTA0MjE1ODQxLjMwMzA3MC0xMC1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCj4gwqAjIFsx
XQ0KPiAtLS0NCj4gdjU6DQo+IMKgLSBEcm9wIHRoZSB0ZG1yX2luZm9fcGFfYXJyYXkgc3R1ZmYg
KERhdmUpDQo+IMKgLSBTaW1wbGlmeSB0aGUgY2hhbmdlbG9nIChEYXZlKQ0KPiDCoC0gUmVtb3Zl
IGFsbCBSZXZpZXdlZC1ieSB0YWdzIGR1ZSB0byBjb2RlIGNoYW5nZQ0KPiDCoC0gQmV0dGVyIGNs
YXJpZnkgdGhlIEFJIHVzYWdlDQo+IA0KPiB2NDoNCj4gwqAtIEN1dCB0aGUgcmVkdW5kYW50IG9w
ZW5pbmcgd29yZHMgaW4gdGhlIDFzdCBwYXJhZ3JhcGggKFJpY2spDQo+IMKgLSBDb2xsZWN0IFJl
dmlld2VkLWJ5IHRhZ3MNCj4gDQo+IHYzOg0KPiDCoC0gc2l6ZW9mKHRkbXJfcGFfYXJyYXktPnBo
eXNbMF0pIGluc3RlYWQgb2Ygc2l6ZW9mKHU2NCkgKFJpY2spDQo+IMKgLSBSZS1waHJhc2UgdGhl
IGNvZGUgY29tbWVudHMgZm9yIHN0cnVjdCB0ZG1yX2luZm9fcGFfYXJyYXkgKFRvbnkpDQo+IMKg
LSBSZWZhY3RvciB0aGUgY2hhbmdlbG9nDQo+IMKgLSBDb2xsZWN0IFJldmlld2VkLWJ5IHRhZ3MN
Cj4gDQo+IHYyOg0KPiDCoC0gUmVtb3ZlIFRESC5TWVMuVVBEQVRFIHdyYXBwZXIgKERhdmUgJiBS
aWNrKQ0KPiDCoC0gVGFsayBhYm91dCB0aGUgaGFuZGxpbmcgb2YgaW4tbWVtb3J5IEFCSXMgZm9y
IFNFQU1DQUxMIHdyYXBwZXJzDQo+IMKgwqAgKFJpY2spDQo+IMKgLSBSZWZhY3RvciB0aGUgZW50
aXJlIGNoYW5nZWxvZyBhY2NvcmRpbmcgdG8gUmljaydzIHN1Z2dlc3Rpb24gKFJpY2spDQo+IMKg
LSBBZGQgY29kZSBjb21tZW50IGZvciBzdHJ1Y3QgdGRtcl9pbmZvX3BhX2FycmF5IChBSSBuaXRw
aWNrZXIpDQo+IMKgLSBVc2Uga2VybmVsIGRhdGEgdHlwZSBmb3IgbnJfdGRtcl9wYSBwYXJhbWV0
ZXIgKEFJIG5pdHBpY2tlcikNCj4gDQo+IHYxOg0KPiDCoC0gVGhpcyBwYXRjaCBpcyBzcGxpdCBv
dXQgZnJvbSB0aGUgbGFzdCBzZXJpZXMgKFJpY2spDQo+IC0tLQ0KPiDCoGFyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYyB8IDMwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmMNCj4gaW5kZXggOTZjZWQwNDk0YjY4Li5jN2JkMGIwMTc4NmQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTEwMzMsMTAgKzEwMzMsMjYgQEAgc3RhdGljIF9faW5pdCBp
bnQgY29uc3RydWN0X3RkbXJzKHN0cnVjdCBsaXN0X2hlYWQNCj4gKnRtYl9saXN0LA0KPiDCoA0K
PiDCoCNkZWZpbmUgVERYX1NZU19DT05GSUdfRFlOQU1JQ19QQU1UCUJJVCgxNikNCj4gwqANCj4g
K3N0YXRpYyBfX2luaXQgaW50IHRkeF9zeXNfY29uZmlnKHU2NCAqdGRtcl9wYV9hcnJheSwgdW5z
aWduZWQgaW50IG5yX3RkbXJfcGEsDQo+ICsJCQkJIHU2NCBnbG9iYWxfa2V5aWQpDQo+ICt7DQo+
ICsJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0gew0KPiArCQkucmN4ID0gX19wYSh0ZG1y
X3BhX2FycmF5KSwNCj4gKwkJLnJkeCA9IG5yX3RkbXJfcGEsDQo+ICsJCS5yOCA9IGdsb2JhbF9r
ZXlpZCwNCj4gKwl9Ow0KPiArDQo+ICsJaWYgKHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoJnRk
eF9zeXNpbmZvKSkgew0KPiArCQlwcl9pbmZvKCJFbmFibGUgRHluYW1pYyBQQU1UXG4iKTsNCj4g
KwkJYXJncy5yOCB8PSBURFhfU1lTX0NPTkZJR19EWU5BTUlDX1BBTVQ7DQo+ICsJfQ0KPiArDQo+
ICsJcmV0dXJuIHNlYW1jYWxsX3ByZXJyKFRESF9TWVNfQ09ORklHLCAmYXJncyk7DQo+ICt9DQo+
ICsNCj4gwqBzdGF0aWMgX19pbml0IGludCBjb25maWdfdGR4X21vZHVsZShzdHJ1Y3QgdGRtcl9p
bmZvX2xpc3QgKnRkbXJfbGlzdCwNCj4gwqAJCQkJwqDCoMKgIHU2NCBnbG9iYWxfa2V5aWQpDQo+
IMKgew0KPiAtCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0KPiDCoAl1NjQgKnRk
bXJfcGFfYXJyYXk7DQo+IMKgCXNpemVfdCBhcnJheV9zejsNCj4gwqAJaW50IGksIHJldDsNCj4g
QEAgLTEwNTgsMTYgKzEwNzQsOCBAQCBzdGF0aWMgX19pbml0IGludCBjb25maWdfdGR4X21vZHVs
ZShzdHJ1Y3QNCj4gdGRtcl9pbmZvX2xpc3QgKnRkbXJfbGlzdCwNCj4gwqAJZm9yIChpID0gMDsg
aSA8IHRkbXJfbGlzdC0+bnJfY29uc3VtZWRfdGRtcnM7IGkrKykNCj4gwqAJCXRkbXJfcGFfYXJy
YXlbaV0gPSBfX3BhKHRkbXJfZW50cnkodGRtcl9saXN0LCBpKSk7DQo+IMKgDQo+IC0JYXJncy5y
Y3ggPSBfX3BhKHRkbXJfcGFfYXJyYXkpOw0KPiAtCWFyZ3MucmR4ID0gdGRtcl9saXN0LT5ucl9j
b25zdW1lZF90ZG1yczsNCj4gLQlhcmdzLnI4ID0gZ2xvYmFsX2tleWlkOw0KPiAtDQo+IC0JaWYg
KHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoJnRkeF9zeXNpbmZvKSkgew0KPiAtCQlwcl9pbmZv
KCJFbmFibGUgRHluYW1pYyBQQU1UXG4iKTsNCj4gLQkJYXJncy5yOCB8PSBURFhfU1lTX0NPTkZJ
R19EWU5BTUlDX1BBTVQ7DQo+IC0JfQ0KPiAtDQo+IC0JcmV0ID0gc2VhbWNhbGxfcHJlcnIoVERI
X1NZU19DT05GSUcsICZhcmdzKTsNCj4gKwlyZXQgPSB0ZHhfc3lzX2NvbmZpZyh0ZG1yX3BhX2Fy
cmF5LCB0ZG1yX2xpc3QtPm5yX2NvbnN1bWVkX3RkbXJzLA0KPiArCQkJwqDCoMKgwqAgZ2xvYmFs
X2tleWlkKTsNCj4gwqANCj4gwqAJLyogRnJlZSB0aGUgYXJyYXkgYXMgaXQgaXMgbm90IHJlcXVp
cmVkIGFueW1vcmUuICovDQo+IMKgCWtmcmVlKHRkbXJfcGFfYXJyYXkpOw0KPiANCg0K
