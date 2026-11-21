Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795226762;
	b=p0WneEyenHSOb3aG1EJe4ckJgrbniMCTqua7xHdneLoJXk1zIR0n6Ua5ZTTatq4J3Q4S
	 2g2KndjNZb/5kTG6T7UQ1utYxwIAOorQAwG4FutpxVqwC+jiM/UC1LhSVR3Hx5gMGKrR7
	 ykhVsvJYJ1gEDb4wpVaNuLCl47qNv1GC+6vR4M+jJUsnF9kkLK6GH+eo8Yai6x4dVUJQV
	 zoKDdMiWJnJzR17yoJJYW3/dgZOBRDhirl6U+B5YMsQv/VFoEYfRN8ZaJj+wTjd67PjeN
	 mqQ7ViMZDoZjJvrJz5hTTPo0IiqCbfaynU7C/LG5ztZofh5Dzt6SJTzDIe6kmm+pIhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226762;
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
	bh=dC1Xqs3WJBrbEcxiSPoscq+rxo0Yr7nO1e57TwcN/64=;
	b=4oPmGeyzTuy4kMgWVzk8METYiuYm70o55IbfPslkPorhmoxoe83sgCcJnCNMUEO403mq
	 SIAYlxMuhRcQnxoOBxMSnp9umz3Fg6JnAtiIoVG+7kBzQSJHBj45ZfE7hRbB+hDpJKuQY
	 9qq3kk2AxmR9XhSY8VvVKzDYACPwxLZ3qlnpW9SMWnQwKe7cwvHI/g/qW54Jx8RSPl02w
	 vYFTX55L17mjuOk5fhEyuYAjQet3mo5GurX+9NjLeYMTCA9/siYZEYi9CcMclxBfYok9W
	 W97Gcv6GO8Li08bnCJcYfsR+HNLVf/qF582S2tskMfDNmiyz0QQNLcvoa2d8t1XEydw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SdHdD11Q;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lXw8AdQI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D0606A6B8;
	Sat, 21 Nov 2026 02:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B9D0606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SdHdD11Q;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lXw8AdQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795226761; x=1826762761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dC1Xqs3WJBrbEcxiSPoscq+rxo0Yr7nO1e57TwcN/64=;
  b=SdHdD11QsU3s0BdT21qExiIQ82BgkJsbalZUaEVO6d8D3e1p+14j9o5E
   T7qivSHkRR3z4mzugDSgqq9QvP4yCK88ZSk7ZK4wrs3hal7UEnNsRCZOG
   mVnxcOl2Fy31D4yTTtEoPs8FeJJlJ0NfS/RzuYke/wsawtTMqMAffZoID
   dWvRqTppyCT6F7VwLpIKcISMmf5kIG+RA3svvUPa1MH2OSNATLu6hQX8a
   6EdRaxyhviyWR5sOJV6VT4UiSSUZQ0VmwGLj7hQWMgeba26w2oDu1nQaq
   yXpajNapYmdYw0JbkZswE87JPcQP0yqFscnIfah1BEjBF0MQbWmzKSh4a
   w==;
X-CSE-ConnectionGUID: Hg2/Zi1uTYe/H/CVLi2OqA==
X-CSE-MsgGUID: XcDII4kRQ7yijyiUlxjrOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4029372"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4029372"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:06:00 -0800
X-CSE-ConnectionGUID: h+MUir4YQjazXdSuldQRwg==
X-CSE-MsgGUID: bH9c+hGZS7i7C3nDIefL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="10916050"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:05:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:05:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 18:05:59 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpj/vMPrjGguTVjIE2QkZY18g8200HgIVGVgdx0Xqd5wLccLrP4Z9dGhHwedlZtf1ejRKd1JD4uczh1jwH38NkmKMtRz0RBdgEkY6XZJst043P/tggnb5HmE23nPro6HpoANIwkxklqEEoMMOjexUERLfjwNTzw/4w2ZJ51WcEe0QGdFY8Y1phMOpRDvLVPtiAkJwZoy1ubH231pmF3/ONqDhhkT7Fue7iHFQ41hdcmoHEZtM1wZ3Z8s4GC0RAqxkF7ulJFDkKF7IP6+bzqjKmtW/L+HQkbz/LH/76CE7NMnOEslBCE9ZJVILL33FzoXdw+UMF5Gde5a+Hzxqgmhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC1Xqs3WJBrbEcxiSPoscq+rxo0Yr7nO1e57TwcN/64=;
 b=Mi3rSctRZknceg9PGGUhg1Yf12iWOkhOOzG/AWGLJwS9D7mZG7j99GWf4Pexay9LEzT56KUM+Jnae+GSEzInocZcVz3cZ2PwwSYWizUHvl2WU0ZcqSplotCeqV1KW11N+DfYIT4MWpvFDREa/09XcxHAyxQj8mB7M7ggFi5gxohToh8N2b7/LspwWfFaqixcxG+R9CVAWVSER9witfp3VMUliTZXZPyXqapY5lbRrfC8DA0N6OQId0WEr5gHirL2itQPWbxSeJyGVVdNLIMhlDQOe/lhmQJ45UJPkDfjtZX085j/C/KcEmWfLyvnpzG8kdEOE1eviWePG5QecNJVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC1Xqs3WJBrbEcxiSPoscq+rxo0Yr7nO1e57TwcN/64=;
 b=lXw8AdQIyURdTvi2cC/DclJMeiZqpVguk6h27gb0WL4yQUGED2IQtXSv8lFFa2695TKZi2LkQsyNIlmV/drfBqIZIb8sotHFTXzNIc+2L9aGhpO/zQINsQNIHv3iqGc1Ardq1m+qqnE0n5vPsHf1ue2IiANNImKUag0j50+5tis=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DS4PPF10012BF96.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 02:05:50 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 02:05:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kas@kernel.org" <kas@kernel.org>
Subject: Re: [RFC PATCH 1/7] coco/tdx-host: Create metadata for an SPDM
 session
Thread-Topic: [RFC PATCH 1/7] coco/tdx-host: Create metadata for an SPDM
 session
Thread-Index: AQHddbsGPKCntc8FE0a1hxKXs98ferc3zjGA
Date: Sat, 21 Nov 2026 02:05:50 +0000
Message-ID: <ae111331c1b71ffdc1875ae25f8079e7c4bebd69.camel@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
	 <20261116111037.3478844-2-chao.gao@intel.com>
In-Reply-To: <20261116111037.3478844-2-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DS4PPF10012BF96:EE_
x-ms-office365-filtering-correlation-id: cf5adf17-dde8-4843-66ef-08df4773f71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|261022113327099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: T8p6yf9wdFZdldxe6FuwbEmLkz4/L6v4bOULrgPw0vQwNN4B+8gFeiqdl/hlnoamzeJARX+MrvkYAB/rddcoS38ZxeD2BZh8uVhhcROiy9HgB+0QLwXC6f7UZfO4dQuTksYLTfs+hk3NNl0dHG3D9VZEsSdN4hdYSmvcWh6+uO/haxAyaBhwZ+wkn0pjfPiBAIa7pulWxsHwyS1CAMN/7QUOyXWOOjaqvnhlgcZLXb+yMWALBMttIFaEo5JB2WwmnGjBWo0/EPhfpLs9jbL0zHtwIMrjToPlmKXfEG0ZAXEsp//NmcXQqGIIiHsxxcfTRJtk4T1p8HjWwpxaCBmkODTWPnJUZdjNEPz5ox0WSnb0VstIr1ObqauV6nFC+5Wa0rIp+uFPp+I3aMxCjfuWmHbGtBewqsyqcB/D5DABFmVgHhEpZTCIECAz6ngbAW/HhjeHCZq3RNSuhFr9ylTGlI12yYhJjWDfbq49pWqGCiG57UU8zD5QX9CdY3IToGsL51s5VfWcLE6L9t02QjMcxNIrd+pdKAuPxzvZYSjg3SbbJyeIJ5nLtxkUMOOEZbaTnNCBGSHfMStAvSiV9R+q3sKbDh5m6wher4oNaN3FxYymf+u0Qmx+zCaysGcsNv5WB7shJcw59WD5nM250r0IoaB1F+cbmdFKlVSWhheZBqO+o9HVP31PlpgMEWn2g3KGmSLEOwcWwHsbstYZQsqoAFmvynk2c5LNAVHIgrcpoHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(261022113327099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXlvcnl4ZjZ2ZEIwMVQzNmdDUmFVYXRsb2c2N2lianJYSE5DV0lWNEJvclo5?=
 =?utf-8?B?YXBDRTVwTlVZS1BNbndSTWtGUHphZ1FGdWRRdmtvTTBWQjJuZm8wUHVBM2ZF?=
 =?utf-8?B?WTVmUjVxMm5MM081d0JBNXlqSHE5UnZWSHFqNXdGMWZlQVdYNzhKNG1WU2Qy?=
 =?utf-8?B?c0FBRzUrUXNzUDk2Sjd2TTNZVTJBd0ZYY2ZPdGRST2VRNUFweTlibWhHcmhH?=
 =?utf-8?B?UlJvOWp3dGRkQVo3TUJDNlhNK2tsQm9laWFiSkxvNkI5bmhSV0RMaUI3ZVBT?=
 =?utf-8?B?OFc0MkpBbldSeXF0VDFoMWdCeU5YVUx2NnVad2FvNm4yeVBwOVVZcEtNTUgr?=
 =?utf-8?B?ZmNCRlJmRVRpb3FHcUQwbS9ySVRDSHM3RGRPNll6Y09MaUtSalhBcEFKMk5B?=
 =?utf-8?B?OTgwdVN6MTl6TmhRaHc4alFodWVMdXZSbjFMenBMN1oxK3B4OVZEM3BrYUkw?=
 =?utf-8?B?TkNPS0VCRXBBL0NpZk1JNmx6aTk3R3FNT1g1YURTbzVRbDRya2VmZkNtYWpo?=
 =?utf-8?B?ZS91WmFNV2dTTGhhY3NCZThJT2Q0eHNETHhaR3pSZG5YR2xHVC9keStHenAv?=
 =?utf-8?B?YkpoY0RWdDBMVjIxcFV5dUU2dEVPYlAvSjdBTGJMV1RGOUU1bUJ4eFBndUtm?=
 =?utf-8?B?dGNKSXJYNU13TXR3dmNRTURzTzE3ZjVkS2E5TVgwMzk5NXZEaWNBR0RFUENW?=
 =?utf-8?B?VkE5LytWbTZIYU9XbHBQN0VBNmVXN2ZkcmdFRnMrekZIVG1kRzJWcmI1VmNT?=
 =?utf-8?B?ZG1JZi9IeEkybkJGTDF1SDZFRmlJYVdGbkQ2QzBiVVpON1hxZjdZL0ViSjNF?=
 =?utf-8?B?U3REZmRIdXI0ZEsrVk5CVGtRakU5N2tyZnIzbTNrbjFSRlcyN1lieGNZcHQ5?=
 =?utf-8?B?UG9UZDZOc1pEVE1LZG9ZMjIrd2tpVDBJR1hIZEgzUTNOQnEvcVFHTkR2bCs3?=
 =?utf-8?B?TlFPNHY4ZmFobGhVOFkrWnlKb29jbzh5TFRnSVFCZEJuc2RRc2VNSFc3NVV0?=
 =?utf-8?B?L0dnNHNzd1BVeHppTmdsblpGQjZzR1BwSDhSbVhhNTVMK21MU2J3VU1LZE9L?=
 =?utf-8?B?bm9xUGlJNVFWWk5WUldhRFR3ZWswdmk3c3hOWG91MEkwWmRxSVcwdmVkNy9s?=
 =?utf-8?B?ckt3ZitmTEJSa0Z3bzRJV090TlhqNTJVK1RGZ2pUTG5JclovTzl5OW5oZS83?=
 =?utf-8?B?UTJ1Z3FzZXFLZHp2REZnSWN4MlMvTXI5TzhuMFgxT3A3dE52ajFnT2gvbzJI?=
 =?utf-8?B?dGxqSlI1bEV1cmVKUVJMWWNrdTA1NGcyYXVnRERmVVRPR1ZwRTVzb2RWd25M?=
 =?utf-8?B?cGZlMHZiMmFzLzFSMU8xcjhwRXV6Y2hteXVlN1l1bzFLMkloaUVld1FmMDZ6?=
 =?utf-8?B?SkJhUWZlZWtrMWJiK3N0SEhjTmJaVUZkWjBWR1lkSC9MN3F5T3BKNHo2VVdO?=
 =?utf-8?B?c1FTYUJIRDloS21rS2M0TGRUNk1WOWVvV2dVVWdUdjVaTVJnY3BWeHR5Nzlz?=
 =?utf-8?B?bWlISVNCMVNNQlBQSUZpbDlXN1NOVjBOaFNCZkwyVWdGVmZuNk5SR1llTWZO?=
 =?utf-8?B?aVR4dmNnVGFhSUY5WlljbDZLUjk1WmF0K2FWY0xTZ0VSekJGc1JSNXJCRndM?=
 =?utf-8?B?bElqNmEzR3Z6eVgzempKS3BQcEFIOUEzMUk1cHNVYXJzTVJWU3dEcEZSTU1l?=
 =?utf-8?B?VkVjK2RQcW1kWmJ3dXljTFhuU1QvRmZmaXo5NUIzcWEwbHQ4ejJ2OUNzb1F3?=
 =?utf-8?B?b2ltRWVvdVMwd0tMbFl2VzdjVkZhbHRJQnRmVnJKS1M4bGszcUFpKzV2WTdP?=
 =?utf-8?B?TUR0eTk4RE8waDd3dkJvOHR5cFgzamJFUzl0eXB4SkoySERCT3pRQ3p4SmNF?=
 =?utf-8?B?NXZNVlpnOFR5YjBUV3E0NVJ2czFzY2hmL1NtbTkzdmJDM2dndjJHNEVjaVlp?=
 =?utf-8?B?U0haTEk3R3hyaHNJWXR5RDQ4Z1pybzMyQ3kwVk5tcnh0SGtGa2lNTGdaTDhM?=
 =?utf-8?B?ck9FWEZXVU9uMUpjam1pc1lyTlJDbHdGTE5kcyttTHJaUkNCR2lEdlJNbGVJ?=
 =?utf-8?B?T0EwbTlueG81L2pJWTU5VFhUVUNlTHMwcmdtTGRGa3FWYWpZS29ub3VZeHFh?=
 =?utf-8?B?MUxNL2Q3ZGM0RlBSTWd3Ti9wd3pKSlVnaWczVjZEWHlyTVRhM2Fqa0s0UUww?=
 =?utf-8?B?UXc4VVM3UXIvOTVYcldQSVNOdmI2UThqblVOU2h3Si90VCtqWmNVUUlObkhw?=
 =?utf-8?B?MXp2S3FxSHp3ZE1rZlNiL292am14L1pWV1JZYkYraVp1aTBCdHpidmVwYnZp?=
 =?utf-8?B?UThDOXVTWFNqSW9RTXQxaUMyc1I5eHFlcVFCM0YramtrTndCZTJMRnF4emdY?=
 =?utf-8?Q?AnZoxmBrf8+yfefk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <008EA47CD7643045A59C675FF15C52AD@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: BM/3n8OXOXKb7aMHS5GSxNEjnVA+7U7G9Qst+wEdmMNzA/deYlwqjXIQ5kANrEqEOzyIRVsT79I1hkJrZMt/CnuXRo5oDcK1QsD8V6TQMC88V5tPU8XILSyzwe+v0wYPWSMpcP2UH9fdCkINsoFPPY599BDDskFiVHX7VpRj/sCQfpYJaAUv8Kbfv1DhZppc2L2vKDnd+CkhL3zYj+xW2Gostvw2BK3/B5PsOTdmQWSZ95mAt4TKW0P4/6b3jv25dik6INfEtpxjFlUpZt1st5qG46Kqmr1aV8BM8Gl6dpBHQ/awhTsmbw6SBLG7wXoDMbpIOsRwEATA4Rv/gKu3qQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5adf17-dde8-4843-66ef-08df4773f71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2026 02:05:50.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NimvRAALy6xRD1sk7VPHB2v79P7lkM24YWhIVZ4ouAdXSfJA0F2KgX9v1VuXjB0THKZ0ky9vtsd8eXUKe2Z/wgYH2JMIl/dWTDHTjodR5J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF10012BF96
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTE2IGF0IDAzOjEwIC0wODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgdGFsa3MgdG8gdGhlIGRldmljZSBvdmVyIGEgU2VjdXJpdHkgUHJvdG9jb2wg
YW5kIERhdGENCj4gTW9kZWwgKFNQRE0pIHNlc3Npb24uIEl0IG5lZWRzIGhvc3QgbWVtb3J5IGZv
ciBlYWNoIHNlc3Npb24ncyBtZXRhZGF0YSwNCj4gYW5kIHJlcG9ydHMgdGhlIG51bWJlciBvZiBw
YWdlcyByZXF1aXJlZCBpbiBpdHMgZ2xvYmFsIG1ldGFkYXRhLg0KDQpTaW5jZSB3ZSB1c3VhbGx5
IHRhbGsgYWJvdXQgbWV0YWRhdGEgYW5kIG1lYW4gdGhlIGdsb2JhbCBtZXRhZGF0YSwgd2Ugd2ls
bA0KcHJvYmFibHkgbmVlZCB0byBleHBsYWluIHdoYXQgc2Vzc2lvbiBtZXRhZGF0YSBpcy4gSXMg
aXQganVzdCBkYXRhPw0KDQo+IA0KPiBXaGVuIHNldHRpbmcgdXAgYW4gU1BETSBzZXNzaW9uLCBh
bGxvY2F0ZSB0aGUgbWVtb3J5IGFuZCBoYW5kIGl0IHRvIHRoZQ0KPiBURFggbW9kdWxlIHdpdGgg
VERILlNQRE0uQ1JFQVRFLiBLZWVwIHRoZSByZXR1cm5lZCBzZXNzaW9uIElEIGZvciBsYXRlcg0K
PiBTRUFNQ0FMTHMuDQo+IA0KDQpUaGlzIGlzIGdldHRpbmcgdG8gYmUgYSBwcmV0dHkgZmFtaWxp
YXIgY29uY2VwdC4gVERYIG5lZWRzIHBlci1zb21ldGhpbmcgc2NvcGVkDQptZW1vcnkuIEdpdmUg
aXQgdG8gdGhlIFREWCBtb2R1bGUgcGVyIHNvbWUgc2VhbWNhbGwuIENhbiB3ZSBtYWtlIGl0IHNv
dW5kcw0KZXNwZWNpYWxseSBvcmRpbmFyeSBhbmQgdGhlbiBqdXN0IGNhbGwgb3V0IGFueSB0aGlu
ZyB0aGF0IGlzIGRpZmZlcmVudD8NCg0KPiAgV2hlbiB0ZWFyaW5nIHRoZSBzZXNzaW9uIGRvd24s
IHJlY2xhaW0gdGhlIG1lbW9yeSB3aXRoDQo+IFRESC5TUERNLkRFTEVURS4gSWYgdGhhdCBmYWls
cywgbGVhayB0aGUgbWVtb3J5LCBhcyB0aGUgVERYIG1vZHVsZSBtYXkNCj4gc3RpbGwgYmUgdXNp
bmcgaXQuDQoNCldoZW4gd291bGQgaXQgZmFpbD8NCg0KPiANCj4gQmFzZWQgb24gd29yayBieSBZ
aWx1biBhbmQgWmhlbnpob25nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8u
Z2FvQGludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFs
X21ldGFkYXRhLmggIHwgICAxICsNCj4gIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFs
X21ldGFkYXRhLmMgfCAgIDYgKysNCj4gIGRyaXZlcnMvdmlydC9jb2NvL3RkeC1ob3N0L21haW4u
YyAgICAgICAgICAgfCAxMDQgKysrKysrKysrKysrKysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGR4X2dsb2JhbF9tZXRhZGF0YS5oDQo+IGluZGV4IGU1ZTU0MTU5YWQzNi4uNTM3
ZTg3MmVlYjBlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHhfZ2xvYmFs
X21ldGFkYXRhLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4X2dsb2JhbF9tZXRh
ZGF0YS5oDQo+IEBAIC01Miw2ICs1Miw3IEBAIHN0cnVjdCB0ZHhfc3lzX2luZm9fZXh0IHsNCj4g
IH07DQo+ICANCj4gIHN0cnVjdCB0ZHhfc3lzX2luZm9fY29ubmVjdCB7DQo+ICsJdTE2IHNwZG1f
bXRfcGFnZV9jb3VudDsNCj4gIAl1MTYgaW9tbXVfbXRfcGFnZV9jb3VudDsNCj4gIH07DQo+ICAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRh
LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4X2dsb2JhbF9tZXRhZGF0YS5jDQo+IGluZGV4
IDliNDZmMzRjYjQ2OS4uZjIwZTAyOWYyNDBiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4X2dsb2JhbF9tZXRhZGF0YS5jDQo+ICsrKyBiL2FyY2gveDg2L3ZpcnQvdm14
L3RkeC90ZHhfZ2xvYmFsX21ldGFkYXRhLmMNCj4gQEAgLTE0NCw2ICsxNDQsMTIgQEAgc3RhdGlj
IF9faW5pdCBpbnQgZ2V0X3RkeF9zeXNfaW5mb19jb25uZWN0KHN0cnVjdCB0ZHhfc3lzX2luZm9f
Y29ubmVjdCAqc3lzaW5mb18NCj4gIAlpbnQgcmV0Ow0KPiAgCXU2NCB2YWw7DQo+ICANCj4gKwly
ZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDMwMDAwMDAxMDAwMDAwMDIsICZ2YWwpOw0K
PiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlzeXNpbmZvX2Nvbm5lY3Qt
PnNwZG1fbXRfcGFnZV9jb3VudCA9IHZhbDsNCj4gKw0KDQpXZSdsbCBob3BlZnVsbHkgc2VlIHRo
aXMgaHVuayBnZXQgdXBkYXRlZCBvbmNlIHRoZSBtZXRhZGF0YSBjbGVhbnVwIHNlcmllcw0KbGFu
ZHMuDQoNCj4gIAlyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDMwMDAwMDAxMDAwMDAw
MDMsICZ2YWwpOw0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnQvY29jby90ZHgtaG9zdC9tYWluLmMgYi9kcml2ZXJzL3ZpcnQvY29jby90
ZHgtaG9zdC9tYWluLmMNCj4gaW5kZXggYTgxNWRiZTUxMjdhLi45MTllNzdhZTIzMjYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdmlydC9jb2NvL3RkeC1ob3N0L21haW4uYw0KPiArKysgYi9kcml2
ZXJzL3ZpcnQvY29jby90ZHgtaG9zdC9tYWluLmMNCj4gQEAgLTUsNiArNSw3IEBADQo+ICAgKiBD
b3B5cmlnaHQgKEMpIDIwMjUgSW50ZWwgQ29ycG9yYXRpb24NCj4gICAqLw0KPiAgDQo+ICsjaW5j
bHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kZXZpY2UvZmF1eC5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQo+IEBAIC0yNiw4ICsyNywzMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVf
aWQgdGR4X2hvc3RfaWRzW10gPSB7DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRSh4ODZj
cHUsIHRkeF9ob3N0X2lkcyk7DQo+ICANCj4gKyNkZWZpbmUgVERJU1BfRlVOQ19JRAkJR0VOTUFT
SygxNSwgMCkNCj4gKyNkZWZpbmUgVERJU1BfRlVOQ19JRF9TRUdNRU5UCQlHRU5NQVNLKDIzLCAx
NikNCj4gKyNkZWZpbmUgVERJU1BfRlVOQ19JRF9TRUdfVkFMSUQJCUJJVCgyNCkNCj4gKw0KPiAr
c3RhdGljIGlubGluZSB1MzIgdGRpc3BfZnVuY19pZChzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4g
K3sNCj4gKwl1MzIgZnVuY19pZDsNCj4gKw0KPiArCWZ1bmNfaWQgPSBGSUVMRF9QUkVQKFRESVNQ
X0ZVTkNfSURfU0VHTUVOVCwgcGNpX2RvbWFpbl9ucihwZGV2LT5idXMpKTsNCj4gKwlpZiAoZnVu
Y19pZCkNCj4gKwkJZnVuY19pZCB8PSBURElTUF9GVU5DX0lEX1NFR19WQUxJRDsNCj4gKwlmdW5j
X2lkIHw9IEZJRUxEX1BSRVAoVERJU1BfRlVOQ19JRCwNCj4gKwkJCSAgICAgIFBDSV9ERVZJRChw
ZGV2LT5idXMtPm51bWJlciwgcGRldi0+ZGV2Zm4pKTsNCj4gKw0KPiArCXJldHVybiBmdW5jX2lk
Ow0KPiArfQ0KDQpJcyB0aGlzIFRESVNQIHNwZWNpZmljIGVuY29kaW5nIG9yIGEgVERYLVRESVNQ
IHNwZWNpZmljIGVuY29kaW5nPyBJIHRoaW5rIFRESVNQLg0KVGhlcmUgaXNuJ3QgYSBtb3JlIGdl
bmVyYWwgcGxhY2UgdG8gcHV0IGl0Pw0KDQo+ICsNCj4gIHN0cnVjdCB0ZHhfdHNtX2xpbmsgew0K
PiAgCXN0cnVjdCBwY2lfdHNtX3BmMCBwY2k7DQo+ICsJdTMyIGZ1bmNfaWQ7DQo+ICsNCj4gKwl1
NjQgc3BkbV9pZDsNCj4gKwl1bnNpZ25lZCBpbnQgc3BkbV9tdF9ucl9wYWdlczsNCj4gKwl2b2lk
ICpzcGRtX210Ow0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIHN0cnVjdCB0ZHhfdHNtX2xpbmsgKnRv
X3RkeF90c21fbGluayhzdHJ1Y3QgcGNpX3RzbSAqdHNtKQ0KPiBAQCAtMzUsMjEgKzU4LDk3IEBA
IHN0YXRpYyBzdHJ1Y3QgdGR4X3RzbV9saW5rICp0b190ZHhfdHNtX2xpbmsoc3RydWN0IHBjaV90
c20gKnRzbSkNCj4gIAlyZXR1cm4gY29udGFpbmVyX29mKHRzbSwgc3RydWN0IHRkeF90c21fbGlu
aywgcGNpLmJhc2VfdHNtKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCB0ZHhfc3BkbV9jcmVh
dGUoc3RydWN0IHRkeF90c21fbGluayAqdGxpbmspDQo+ICt7DQo+ICsJY29uc3Qgc3RydWN0IHRk
eF9zeXNfaW5mbyAqdGR4X3N5c2luZm8gPSB0ZHhfZ2V0X3N5c2luZm8oKTsNCj4gKwlzdHJ1Y3Qg
dGR4X2hwYV9saXN0X2luZm8gaW5mbzsNCj4gKwl1bnNpZ25lZCBpbnQgbnJfcGFnZXM7DQo+ICsJ
dTY0IHNwZG1faWQsIHNyZXQ7DQo+ICsJdm9pZCAqc3BkbV9tdDsNCj4gKwlpbnQgcmV0Ow0KPiAr
DQo+ICsJaWYgKCF0ZHhfc3lzaW5mbykNCj4gKwkJcmV0dXJuIC1FTlhJTzsNCj4gKw0KPiArCW5y
X3BhZ2VzID0gdGR4X3N5c2luZm8tPnRkeF9jb25uZWN0LnNwZG1fbXRfcGFnZV9jb3VudDsNCj4g
Kw0KPiArCXNwZG1fbXQgPSBhbGxvY19wYWdlc19leGFjdChucl9wYWdlcyAqIFBBR0VfU0laRSwN
Cj4gKwkJCQkgICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOw0KDQpXaHkgemVybz8NCg0KPiAr
CWlmICghc3BkbV9tdCkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlyZXQgPSB0ZHhf
aHBhX2xpc3RfaW5mb19zZXR1cCgmaW5mbywgc3BkbV9tdCwgbnJfcGFnZXMpOw0KPiArCWlmIChy
ZXQpDQo+ICsJCWdvdG8gb3V0X2ZyZWVfc3BkbV9tdDsNCj4gKw0KPiArCXNyZXQgPSB0ZGhfc3Bk
bV9jcmVhdGUodGxpbmstPmZ1bmNfaWQsICZpbmZvLCAmc3BkbV9pZCk7DQo+ICsNCj4gKwl0ZHhf
aHBhX2xpc3RfaW5mb19mcmVlKCZpbmZvKTsNCj4gKw0KPiArCWlmIChzcmV0KSB7DQo+ICsJCXJl
dCA9IC1FSU87DQo+ICsJCWdvdG8gb3V0X2ZyZWVfc3BkbV9tdDsNCj4gKwl9DQo+ICsNCj4gKwl0
bGluay0+c3BkbV9pZCA9IHNwZG1faWQ7DQo+ICsJdGxpbmstPnNwZG1fbXQgPSBzcGRtX210Ow0K
PiArCXRsaW5rLT5zcGRtX210X25yX3BhZ2VzID0gbnJfcGFnZXM7DQo+ICsJcmV0dXJuIDA7DQo+
ICsNCj4gK291dF9mcmVlX3NwZG1fbXQ6DQo+ICsJZnJlZV9wYWdlc19leGFjdChzcGRtX210LCBu
cl9wYWdlcyAqIFBBR0VfU0laRSk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIHZvaWQgdGR4X3NwZG1fZGVsZXRlKHN0cnVjdCB0ZHhfdHNtX2xpbmsgKnRsaW5rKQ0KPiAr
ew0KPiArCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdGxpbmstPnBjaS5iYXNlX3RzbS5wZGV2Ow0K
PiArCXU2NCBzcmV0Ow0KPiArDQo+ICsJc3JldCA9IHRkaF9zcGRtX2RlbGV0ZSh0bGluay0+c3Bk
bV9pZCk7DQo+ICsJaWYgKHNyZXQpIHsNCj4gKwkJLyogbGVhayB0aGUgbWV0YWRhdGEgcGFnZXMg
Ki8NCj4gKwkJcGNpX2VycihwZGV2LCAiZmFpbCB0byBkZWxldGUgc3BkbSAweCVsbHhcbiIsIHNy
ZXQpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJZnJlZV9wYWdlc19leGFjdCh0bGlu
ay0+c3BkbV9tdCwgdGxpbmstPnNwZG1fbXRfbnJfcGFnZXMgKiBQQUdFX1NJWkUpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgaW50IHRkeF9zcGRtX3Nlc3Npb25fc2V0dXAoc3RydWN0IHRkeF90c21f
bGluayAqdGxpbmspDQo+ICt7DQo+ICsJcmV0dXJuIHRkeF9zcGRtX2NyZWF0ZSh0bGluayk7DQoN
CkhtbSwgaXRzIG5vdCBjbGVhciBmcm9tIHRoaXMgcGF0Y2ggd2h5IHdlIHdvdWxkIG5lZWQgc28g
bWFueSBsZXZlbHMgb2Ygd3JhcHBlcg0KZm9yIHRoZSBzZXR1cC90ZWFyZG93biBzZWFtY2FsbC4g
QnV0IGl0IGdyb3dzIGluIGxhdGVyIHBhdGNoZXMuIEJ1dCBpdCBsb29rcw0Kd2VpcmQgaW4gdGhp
cyBwYXRjaCBhbmQgd2lsbCBwcm9iYWJseSB0aHJvdyBvZmYgdGhlIHRpcCByZXZpZXcuDQoNCj4g
K30NCj4gKw0KPiArc3RhdGljIHZvaWQgdGR4X3NwZG1fc2Vzc2lvbl90ZWFyZG93bihzdHJ1Y3Qg
dGR4X3RzbV9saW5rICp0bGluaykNCj4gK3sNCj4gKwl0ZHhfc3BkbV9kZWxldGUodGxpbmspOw0K
PiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHRkeF90c21fbGlua19jb25uZWN0KHN0cnVjdCBwY2lf
ZGV2ICpwZGV2KQ0KPiAgew0KPiArCXN0cnVjdCB0ZHhfdHNtX2xpbmsgKnRsaW5rID0gdG9fdGR4
X3RzbV9saW5rKHBkZXYtPnRzbSk7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9IHRkeF9p
b21tdV9nZXQocGRldik7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAt
CS8qIFRESVNQIGNvbm5lY3QgaXMgbm90IGltcGxlbWVudGVkIHlldC4gKi8NCj4gKwlyZXQgPSB0
ZHhfc3BkbV9zZXNzaW9uX3NldHVwKHRsaW5rKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIG91
dF9pb21tdV9wdXQ7DQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK291dF9pb21tdV9wdXQ6DQo+ICAJ
dGR4X2lvbW11X3B1dChwZGV2KTsNCj4gLQlyZXR1cm4gLUVOWElPOw0KPiArCXJldHVybiByZXQ7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIHRkeF90c21fbGlua19kaXNjb25uZWN0KHN0cnVj
dCBwY2lfZGV2ICpwZGV2KQ0KPiAgew0KPiArCXN0cnVjdCB0ZHhfdHNtX2xpbmsgKnRsaW5rID0g
dG9fdGR4X3RzbV9saW5rKHBkZXYtPnRzbSk7DQo+ICsNCj4gKwl0ZHhfc3BkbV9zZXNzaW9uX3Rl
YXJkb3duKHRsaW5rKTsNCj4gIAl0ZHhfaW9tbXVfcHV0KHBkZXYpOw0KPiAgfQ0KPiAgDQo+IEBA
IC02Niw2ICsxNjUsNyBAQCBzdGF0aWMgc3RydWN0IHBjaV90c20gKnRkeF90c21fbGlua19wZjBf
cHJvYmUoc3RydWN0IHRzbV9kZXYgKnRzbV9kZXYsDQo+ICAJaWYgKHJjKQ0KPiAgCQlyZXR1cm4g
TlVMTDsNCj4gIA0KPiArCXRsaW5rLT5mdW5jX2lkID0gdGRpc3BfZnVuY19pZChwZGV2KTsNCg0K
V2h5IGlzIHRoaXMgaGVyZSBpbnN0ZWFkIG9mIHRkeF9zcGRtX2NyZWF0ZSgpPw0KDQo+ICAJcmV0
dXJuICZub19mcmVlX3B0cih0bGluayktPnBjaS5iYXNlX3RzbTsNCj4gIH0NCj4gIA0KDQo=
