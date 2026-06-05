Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCD44D68A;
	Fri,  5 Jun 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642979; cv=fail; b=iH2sBweQP0vzNNuqHPDdDoWgpFeiRjBJFxqy32ZDPLbzks+hyTB8E3mHJD0kGiQqQLefY9r8QxkTxfUvpoIv8Mp8hwguD5Nkoq7WH1jgJh4A+/8CXyrcrL1L3KGGRdW9BH9cX/vbexdj3IeXnN5fXW+WrEn7yA17LSHWK3GGoRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642979; c=relaxed/simple;
	bh=GoYTmJHErgouAPs74MAzHdhpQUjmBbVXGPWvtO72dJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bKsWQ59gBaUXuSQTyV1RI5oDZptzF/8imwo9KpQdn+S44IC4J7J98v/BzZtcfBrw2igOLiUQU0lGXLyZmI7U1BBPuS2pdSGB0RMa4t65TOnv342g/G44YkRrmN1wKNEhYShVtH3Kflczyyi768Nz5A2//orAdtW9ICWZM+bxx9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/oiHvWW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/oiHvWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780642978; x=1812178978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GoYTmJHErgouAPs74MAzHdhpQUjmBbVXGPWvtO72dJw=;
  b=D/oiHvWWfrsSlEbURGi+4Dau8XBM2OncPjv4Ud8dw4XtkEaUydxRFcSt
   wTDpsmVYmlQh0yFRTKr7auifCN8QcZnzrDWoTBmFx8tXYjBfhImHJcHdY
   9ViGo+KDAK1s++v6tT7NOzph57BjMhvgEvr+YSPJoO29ei7AS2t6XZKgb
   oBuIP76WCfVepurNrT2AWkDVtW9UNRTa4AjjYQrzldLVNopgkQH7IY6lO
   D4hpnpsGilKc/3Z5Sp2NurTRpYXMXj6fKIR0+w7sSiYIPKL4PVQ3iG9X+
   Ag2DmY0jch4hOJ+cSCS1y/G3kp54yYrXRcMd+VaZYLxdA1N04d1Fs5oq0
   g==;
X-CSE-ConnectionGUID: K486jJIOQgeXw0AKk+FMdQ==
X-CSE-MsgGUID: FOmyEjaxQgmaVtgPwXe7iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81220352"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81220352"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:02:56 -0700
X-CSE-ConnectionGUID: SGu/6LYGQeisNeLgCeQ3ew==
X-CSE-MsgGUID: m2TDIvtIS2GIr05WhxDGZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="242281248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:02:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:02:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:02:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0Zp80H3wt6ByIrPCZNsaBkbWtSytqg1uXJWjfzTjnT8NxxLsrk28RbWP2dUce4V7c/ujJCxUJftZssnm5VdX9LmdKjFABEcgByF3WHGUTCRWU7Kh7tVeWQ7OG/MbH6wcjyv1bbp6dL1MAbdyM899RPSxxiFVvw00DvS1jXr5sa0e6sviFqWdqWHOAZ6K0bIYXPGowzZbdmZay3U00xF4VyA5ZctVUaSLaPEcXGGiwOCWRd5DQ8V+J7t09eD+fzjsUK16ytSpy34kYFvpTCMuXyKmHooY/NXOXnY+P28ZAqE3CnhjR3p/ILBUK1Fn8Khth/ppCNvY1ikfO2HmUApNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoYTmJHErgouAPs74MAzHdhpQUjmBbVXGPWvtO72dJw=;
 b=ynb2IPKaYrHzoQQsX2WvIOB97VsVXmztLTT3WWuOBgbS09KTlEK6XrvINVmWhMOsViZrKnoc7rxNLraRZtC6TlGtF947rDkyzi4LEhd8onceV5X2/BdvIHgeH0/9zOuW0HdwrBEaMgnd3GUm4LNZLJU8I2lrdPw6PbQZ+rM9hJyMhdE78EgvtkoAVJPozI8587T2rE6g8JIKQUdlilRReoNap1GOVXWZdkXDZFf443mvpElRkguQ2Gh32HSJ0rONsX0L9tSg8SeMx3ejqjcUHJ/X9CPGT++zR9LDsUIrvnjYNOT8iFWvxTNDT1ojudi89WIYIxdl4aHwV3hTlu8ykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA7PR11MB9594.namprd11.prod.outlook.com (2603:10b6:806:4cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:02:41 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:02:40 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Topic: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Index: AQHc77nLxoh5kHwb2kaKk0hzQ9PktbYvkyIA
Date: Fri, 5 Jun 2026 07:02:40 +0000
Message-ID: <9c3172cffce937e57312f9e8c4c7ae50ea8842cb.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-32-seanjc@google.com>
In-Reply-To: <20260529222223.870923-32-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA7PR11MB9594:EE_
x-ms-office365-filtering-correlation-id: 220ea118-3a96-4d87-2982-08dec2d06f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: mH8tIgxfpG2752BFyVZ3ZvW534dhDhnIdUvMbQeAnNm3U+S3NT+mjo1qbO8pHNjODWYxbqpLJpEHTV3DO+tcBKScnsDhIBZbrmyPAN1qKvRqNItMgHvtENH3ZoEMdCS2oAxGnC73SOEOfl/yR27l18QGYCSFxnK/O6t6aYqMrUJ3vMIRBEdv9JDAqdAMfgzsMA1LB2pFgvp2BnONGOhDpn4h+AMrb9J1+WDGV6ro7Uh6Lc8lGjMakr4OmZsPkrsW0dfFBvXIO0qKZw/rRMvXc+GfBuIh8INWiuH9Mnf5Lrk7FQHqQB0Wt+jpDGVtauIeHdf9o523a7YehmqlBlr1OzYVawsrEh57WhfetA6JpZZ4qOCD4ZanUFgL03YcnruPIj5Y2LdvTf3gOleFjYbYrTLMb5kDob25034BqVUdHs/55qIoiLw18Ysa+B+o8BIUR/SMUdowt57Q2tsvnarIY4Sehp7Xft1zhq2cJsr4tlbXsqkGoHeoEdFbINzpmGxz4gub8fHjSPTCm7y+p3dYpYjrmgZAD1Z+p3r4/uPpipNeOVPNQhPGxXuy1zKacYDb+l3E66BEheCFm+pMKZM/2AcfaY2I/kZEwK/R7wsT8Z28Op2NK1V/WKGkFBvyIjbJe5ddU88cQeDY/aD7nZ/t3uqdW3YTbYNNb9ETNMg0IttM8drVzYgvJ+pe9TDWLF6wdIQN4Ou2V2x1319ksq0mTZRMdzUjzec49/tHXujZUPLT37tZ/2LaqtgspL5OmHgy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N09SWlk1eXg1WDlKdDBELzQ5NlpNM0ZDRVdKZDNDRjVqZm53bkJLV3N4QXVY?=
 =?utf-8?B?VWc5d1NzN0xtVVd3SW9IVlhWVWxwRFIvOTFWbUhIUlZ3Z3M3ZTdLWE0zNXZG?=
 =?utf-8?B?Z25qU3NrV2JPWk8wY3dxQkRZYitFNTlyM2pRTTRramdqSlMvZ0dJQmp3K0pM?=
 =?utf-8?B?c1RCV2JmM1NQQjZpZmo5WVdDM1k4MGZJeGY5RDN5Sk45Zzk4aHU1NlZsVndh?=
 =?utf-8?B?bWpxaXJoamRjOE1XaTUzdjJDOW1laExILzVSSytNN0g1dXJONTJDMnRTMHVv?=
 =?utf-8?B?enpMRlVIRXlDSGIrK3pMUGp3YnhMdjhRNzFPbzh0c3VpYW9WbnhEQ2svOUZH?=
 =?utf-8?B?ZTM5QVN0VEVCbXI2UEhyYVpVTUdMa3dEeUVUL1NpVlRnNDZDV04xWXZpaVJj?=
 =?utf-8?B?Sk04RFdtdTRkQUFLT21NQklXbWhTWmJpdHFqWnVnWHFXQ0N4Q3VzeVFOMDJ1?=
 =?utf-8?B?K2pkY3ZKakI5T2pQaXBxSFVjUzN0Rm5neDd1TWpYWHdaSVBzUFBYRzBqUVE3?=
 =?utf-8?B?K2xMVTVJMHhzQW1UNGJqSzJIeTlDS0hKNVVPazU0VVdjRWk5bFY2UytLWlpi?=
 =?utf-8?B?Wk93ODhTNmdQOVBuaVJKOUcweTZrMUhHTEsvU01UZ0VXVlhIenY0MVVZV1ho?=
 =?utf-8?B?cGh0ajB6S3BUOHFaYjcwWnUzN25nSEwwOWUwTDB1WE5iRGZteVN0KzhyYy84?=
 =?utf-8?B?amlIZG5FekFCMmNNMU9WVnBpbSttM2Zhdmc1K20zdWtJNHU0UExZTlpmcHFR?=
 =?utf-8?B?QTFxUnVmYU9xYVV5dkpLSWtSVU1mdlZBQlVCVk9FQklkK3YrM3RkcDBGakc2?=
 =?utf-8?B?bHBrTXFjWkhVY3ZxODJoWjl3elZJeXhibUhOWkVLeFlMNzNPZHAxNjM2NjdJ?=
 =?utf-8?B?UjdxbVpLdnJSWjNiZVFOTFB1RjlqUnRSU0pxY2VpdjhWUHlxb0tSL1A3amFI?=
 =?utf-8?B?NTB1Ky9idWlLZ09LQ29ybkJodlZ3c3A0U0RCT05YZk8vM3FrVTUvazhha3Vr?=
 =?utf-8?B?NW5Mc3k1SU5jcERnZWFEUjdvY0JVdmhGaE1oWlUvdUZKZWlULzhnMjMvOGxj?=
 =?utf-8?B?RThwamdTZS9QTit1T1BiUmluZDQ2L2p3aU0wWS9mNWZMYVhNV0RlcTRLSGhB?=
 =?utf-8?B?eXg1emFWQVcvNTNWSW9ucHAxQ1NIM0ZvWTNBZVAwVVdNdVNZNEQyRUlJUkFs?=
 =?utf-8?B?MTVEMnBuMzc1Q0tFV0R2OEsxTTVsS055dlBXbUFMTTkwQUxaYlFvKzBVNVIv?=
 =?utf-8?B?T2NKdjJCbTFvR01HZUhHNWg1LzQwMDZFSkpicHVpV0dnY3crZmpiNS9XUHIr?=
 =?utf-8?B?ZTkxRGpSaTlVRkZia0F2eHJpRm1wZjMzUkZiL21mTkp1WkZxSXNyczkzNHJy?=
 =?utf-8?B?L1diMHRMaEIwRHBENFN2M1d1Y0kxTmpneGZEcXl1NE9xaDhMYW1nOWV6cDZn?=
 =?utf-8?B?VzA2TThTYmpTM3VPVEg2akljTFV4NnNua29OM0xzTWs0bWtzdmhZa0YxSW5Z?=
 =?utf-8?B?TW1iOTJXekh2TVlpVjhwUWlXbDY4bEp3d0tJamI2SnkxeGRkTUNEQ0hISTZC?=
 =?utf-8?B?NFMyMDBiYjhNRzJkZVFETDJjSzdhQ2JobDRER3JsT2kxSEVsTnVFWWs3aXBS?=
 =?utf-8?B?VE84am9rVHd3NTdYVnFsUldWL24yRDJ5Ym1LRHpkTGJoTGlJVTl0VUVNRSsr?=
 =?utf-8?B?Rnh2d1A5T3RIOUxIMWswZjV0alV6ajVvWitGSWhQMWFqODNXcmtPVWhIMXRi?=
 =?utf-8?B?QnpwK1JXanBDRFpFQnhpZVpTdDhHM2I0ZmZ0V1RFNVNPZDRuTTVUTENjQW9o?=
 =?utf-8?B?clpUTHZlL1I1d2thdzlRVzdnTkdOM3d0NGhJa3hUKzdEUVZvekh6UWRCK3Zl?=
 =?utf-8?B?VS9pQjFvTGNiNEhwYUhPaGd6SjFHQUhoNTRCVnFYZGZKSE9QNHBqOW5LREtD?=
 =?utf-8?B?U2JWU2pDNUZSOHU4TStaL1ZRcnNELzYvWld6a3hnUERrK3BCVXVIQ2J1WjF4?=
 =?utf-8?B?WGFsRnIvelUvb2Q4S2lIYjRuMWJEZGNGMURPQTlSck54TWVWZk1ESzdRQ0tD?=
 =?utf-8?B?Q3lDdWRrK3FZeE5lak1mWFF4WkpRc2JYbFNYL0QvampidjNSTFlhNUZGWlhx?=
 =?utf-8?B?SXgvQU1Od3RrcTlNM0hOVDB5SkFBekp3bUZlbEc1QlF3VFlOMzZ6OGZQWUVv?=
 =?utf-8?B?Q0tZbENYMzRNek9Yc1FIMDFRWEc5bUVpbHZrc2doZ3Z2VEhONGZpL3JaRkds?=
 =?utf-8?B?OWM0M1FKTEJwVlIxNitTT0haMk9GL1pqNnYyN1B4Q2EwNW5FRmF6YW5tbndK?=
 =?utf-8?B?cW16WUdyL2t6ZHVuaTVCYmNkNHBBSXlDVnozK2UySmZuR2ZxWFRydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44662C306144494393FE873DEE5C2788@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PqbUBgamMQmdBfAHAywpT5VB4DFpnqVa8tJJYwlF1ejfgfghsYCp8n3mMMA7M3Q1K49oxShJ/Ksq2GwC48xOrqF09vHmQxh2sAM80tic08v3Sg7QJM7gPfV2ykb9AqBd2/6re08YM9n2iWpV7Y3NBFJPdcjFGk5435Hq3zk6bIbBFA6EjVX73pJY1T6zQaH2AoLtgRMoohcKzejdmynPd2FWmx5wxB1c+mZOXJ4Odg9Zn9Qk/KO2wMQgwo09c/o3SEPaGC4gc2Xvuf2d8I5oNox+MAYV0+0nSsAxABvQO8bUlF/n+B+y8mD+U/rqae+8y6b1PiR5ZEwq/A2z1yStWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220ea118-3a96-4d87-2982-08dec2d06f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:02:40.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRrHe6iyQDgeWsXXmSnQywqqJQDWmPO5FKGCP5+4EzBYWzyBGckhU092bZym3j7GUPq1qH5ZOYahr36YlbTEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9594
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIGEgcGlsZSBvZiBNTVUgaGVscGVyIGRlY2xhcmF0aW9ucyBpbnRvIG1tdS5o
LCBhcyB0aGV5IGFyZSB2ZXJ5IG11Y2gNCj4gS1ZNIHg4NiBpbnRlcm5hbCBBUElzIGFuZCBub3Qg
aW50ZW5kZWQgdG8gYmUgZXhwb3NlZCB0byBhcmNoLW5ldXRyYWwgS1ZNLA0KPiBhbmQgY2VydGFp
bmx5IG5vdCB0byB0aGUgYnJvYWRlciBrZXJuZWwuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0K
