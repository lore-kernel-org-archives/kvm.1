Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796137268A;
	Mon, 16 Mar 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652026; cv=fail; b=k3FxXZ9xW7hShpS+UlTbod3ODwEnZbwGdh0mEbvgUXbJmk5WpkKGtMh2eXJuk9QgHAVZBjg1w7SsxwbXPaHABhcAxjzm9I9k55IRO3f8QRkJf+FXKViN6HRR10hwtcI87euIC/P/WHvc6nyaQSBqwRu3BaMYEANNs05+1Jq5qQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652026; c=relaxed/simple;
	bh=gSZ+1GcIUdP4rm+G7j3QhiSolTnRQXBv87v+xgVgQt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDDMXnbxw20CC9WCJiXzHCDJmi0+hDU+wKtQ3nyu6EUEijhgVymnmybcntpN7b1ib/fjReymZynO1MTHSd0heCGwJ8ou3M/R0yhffJ77PuZjLDguvIO8Cg6/NubZ5LsXjbPglNbxqeK4Mpoghk/t3dgHUQM1WWKBtIB5ssZCuyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TezdgO3k; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TezdgO3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773652025; x=1805188025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gSZ+1GcIUdP4rm+G7j3QhiSolTnRQXBv87v+xgVgQt4=;
  b=TezdgO3kekyv7LPgeAuymKgziKJls03VDw3ygHFkjFqWVAUSvlnw/hrw
   fEO/yTXLxB+X8Ih91szES2czFuTdqNU+N0eg+QTCfZuiZ/BY/K1NrJR/N
   ZtwwZFDQxQNms/GxTYxzgIRMojoGPrC5V6SIPmi+iaoMIRSRUWr0YNqFW
   ED9BznHuiuaxuqycTeY/O5jYxikPs3k2CIpkCGirqjHjwuT7WVkrHsMD9
   qxQuvIb35VWDe3NtiplKK8JVFW/52guPRmGTtZKd5t0nA8tcwIbLRgbaD
   zZryT2Lz28Cq7SSJTkbN2gb1xw11j2iQvLPVEVTk8DSV3iK84NINYonnh
   A==;
X-CSE-ConnectionGUID: 3/+oSqQ9TzGuH/UHKHO8aw==
X-CSE-MsgGUID: Fl7B9Y2ET6m5bMh2FnLgGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74849127"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74849127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:07:04 -0700
X-CSE-ConnectionGUID: zng6GygKQCmROZHB82dFlQ==
X-CSE-MsgGUID: MTyVpw3nQ06zOm1GBn+9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226846419"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:07:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 02:07:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 02:07:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 02:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+zW1oQNXEXqL1V6hmgpi0xjxNVPqz98RRwdLiG/9SsUK6uPOKKxO6U+aSOuYVxIyUEibDoEWToCC+5t6F+HiWG4XCZv8yPi0b5xdT9RlRDQiuWq2bVzDlmYv+Y6khzuVg2hw/eAnIiTQJ8wYtOnIX/xWdrFC6EwMCKNTudw8NJo4cakuYDwfi57JQOz7PrltrSofftXJl4rq5MUXc/73IB2XBgg4PF7m6imd3df5CocnPKLI4grJVw3QxmIxTFHIsDg0TjGF79P5Qe0fhJdqoSAX3u7FwPyTgwrCFp8ygT0P1G0dmcxdBgsGKpL0gyECOy7LifZn5NsXcCyxovBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSZ+1GcIUdP4rm+G7j3QhiSolTnRQXBv87v+xgVgQt4=;
 b=fVAojDjYdsRAmPgrEb+x8uog/0Xq1KvD6DVufdy/Woq7YJYAZEWWd7H6fvaU69dsVsCxhhrgGS/rXrNXJ0RVPSarwSbF1xUgi66d+9BRotK8dL7RiKl0CX2WaJsS2p0Sqkor8uDfvyoN94vcZqYuiGYztODU9lHKzO0vg6oHSre9gA9LsVG9RVnoFKT45ScN+6D95EnoNbmlkECLzj4YXmNa/0+AqcFx8BtiIgsU2wTXxkmyfmV5Pq49xMSltRHxOa4D2g7v0BnGL1hkh4gDdYLHTnOEDp01u6fRvVlb47CZCsBV2/2ywAjWWcPSE8JWafrQWfIltqmvqsIbfymAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.13; Mon, 16 Mar 2026 09:06:49 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 09:06:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Topic: [PATCH v5 12/22] x86/virt/tdx: Reset software states during TDX
 module shutdown
Thread-Index: AQHctIP+QgonfM6NE0ygNTGLoWRFtrWw32MA
Date: Mon, 16 Mar 2026 09:06:49 +0000
Message-ID: <996e42a31101bb90575e7b2b6f33b3bd607b5e6e.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-13-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-13-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SN7PR11MB7975:EE_
x-ms-office365-filtering-correlation-id: 386e7aba-39a6-497e-8547-08de833b5b6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tTsSjj6/0GdGJlLj0s1/0jUc2Xp6p5jKB0DrXRN32aXhyuEMu67PubK4AmtGlsvDPVMoKNmLtyAuffbzaS+Lc8cn/lmfBXxc3uwmpbMYLfMx5BGzOHhztvYjtZWLZSKxEQhWDbLg8OSwZFbhF5spsOacbK3RbUO/jXT/a8ohnf6ZhZ2F9ye7aE1XtLxz/WzJNf57BAT+8VmciyulG3TDago4KfEinYnXJ2kz9R1hF2OxLwht1FRdARo7EfIO62X1h7wc7t5ZWAguKBod6wnOC/uvPn08LFxmjWZy1hqIiN5iSc+J7rZCm4s8z4XgbMxtuRhVHIsJWrjFT1CaE0NlRsTO48Zok+0Tq7r5h3NGg/WKaAKrxQdlvBisj8q1OX9b+rJAfcw/g48um09cAKgp2tjLsYOskpcEuaHTpAc5FIY2BF6PR6SoWkfY+GIkGOoG9CcG5zXdWp/HhRT95KJ2cC0XnyVrI+0UGRV/nmagVNddCFh0jL3wYMqL3n/e0n7zND5Sr49yiwmiV0V0STjGqxYgSSrb2S7r5cExg4Aref69DprRiJ/rj3HLDNUv0YbN5BbtqBDnQmKe5abnVkxmjn8Ob3OzxBZkfM4LoN6dBkSCCkp+fViC7Yekx1KBr3FIJvM3fgYSuppcp8r0zmna+Vz9NJ9+5LZpoYhXZRlqndydzSm3fZt6A9awi0Lu/l1jxLb1OQ+utwNAGvyMxU/+2zt0tgkH+IeeSYVTfFcFdMDYYktlKFiTkR/Y0Y0QOvEoqF5fxbxEVncTTzqnWQKb92btBj5AKmTMJUC99KxXr5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akhQVUsrQXdqWlNUQVQxRDFtV1NGbGNPQ21KR1dRUEJ4Vm5TR2FzRjFNKzBO?=
 =?utf-8?B?dmdNU1pOWTJlRnNoT2NZOE9Fcks1eTFYQSs4dDFNNTcvZFhpUnlWS25xcDM1?=
 =?utf-8?B?a1RIQUxmazJ0b05PSkVsNkt1cGlzc2xQeG1xYWI0UFhJY0ZTcko3WG82T0ds?=
 =?utf-8?B?MGt0Rlc3RHNFSUhsU1pLSEZpY0I5bXpJV2g0TkZSSHcyaks1eDY1RlFxaXRz?=
 =?utf-8?B?aXk5UEZQSlg0bnBDWlM4TTVBSWVkNDF4bE9nRUlBaXlGY0RuS3NJbGdmT2dn?=
 =?utf-8?B?OW9NVVI3ZS9FMjhnNThHeGwvWE5DenMxKzFFVEhDSDdrOThJcmpkUlFDbFB4?=
 =?utf-8?B?L3RhSERjOGg3NWJZMUhLTmFJVlFDaE1GSDhWWlhOV1ltV0RpZkN4VStjTmhI?=
 =?utf-8?B?Vm9VU2crdlJEb1NHMjRmVk0vaEpYMlNReGxTVmZyV3VhKzdNTTVXc3lsS21T?=
 =?utf-8?B?elNZNHVNNjdxekNDQk4wTjBWL0N5SWk5TWJZVTl4U3UxeHNZVms1eHpnMWRC?=
 =?utf-8?B?djNoRVVpZTRpWURVRmNUdldvV05ZRjdJdXVEcndnUW5ZY0hlSytUSEd3ZmtU?=
 =?utf-8?B?WTdDY1g1aitJVWpRcm9qM2ErdFdodVNXMjVKS2JlL1BRR3dXU0thSFRSU2Qz?=
 =?utf-8?B?SzF1Mjc1dHFGbm5uUzZrcVpLNVBHQ1JLVW96b3lrZkNqcUFWN0FUWUkwbEgw?=
 =?utf-8?B?Wk5ZQ3UvOExvVGpPMGRyVlE0ZGVEK25RSmhsdUdTTGU2UVpEWmZpVUlNKzJR?=
 =?utf-8?B?bGt4RUt6MTlleWc4aEJlakxzQnFyeDFHUlo5N0duSHVheTBlRDhva1NYUzlU?=
 =?utf-8?B?UVB5c29jOVhQMElEQkVrQTJudEFZWDY0Q2N6NkZneG5rRzE4em1HdVQxSzBG?=
 =?utf-8?B?emR6QzM1RCtRTENTVGVKU1YzRkhBZ2xwVG1zandxRE82dHJQcUc1YTcwVVhJ?=
 =?utf-8?B?YWJNYU5qRFllRGY5Qk9ja0tqY1RYM09VMHNPK1kzdTZ0ZWYrWnVXc3M3ZVRz?=
 =?utf-8?B?NU5rWXJaQjRFeit3NnV6Z1RHdS9xejBTSXNNNktxcTR4elArd0lWeHM3bHFi?=
 =?utf-8?B?dHE0T0h6L1hIL0tuN3hXcjRWTit0bjczUk1NaWVxbVJxaGZwczNDVFZaVWMw?=
 =?utf-8?B?c1dKRG4vNzlFQldxamVnVjRaS2YyWndsbVlMN2ZVOUtXOVNkRFduU1VsSkh4?=
 =?utf-8?B?SVpYc21TYzM1S3hISkJBaktHRzhIaWVWRVc4cWNSNExDZFZsM1krek9udDZp?=
 =?utf-8?B?L0wrWUpmcFVmaVk2Uys5Z0VoRmJUZnRNb2RWTjZWbm1tOU0rUFJ2cURLWHcx?=
 =?utf-8?B?MElDNWtsNmpMVDR4WW9ocDVxWlY2WHErR1R3Q3pHNnY5OUFlenlCeEtHTDlV?=
 =?utf-8?B?ditxZjVsemZ1RDY2MWdLQjN2QzJrRElMLzF3TWtrQ29yams0YjQ5RWZmUFQ5?=
 =?utf-8?B?MTNsY2dyU2JlaEcwV1U5S2luYlEySDNGSGFGcEVISDFPeGlXMzBTZlNrZGxy?=
 =?utf-8?B?bG56d2NPQkg1TUdCY1pQUGhKWklMbFo0UXZTb1NocTRjMUZBelBnTXpueDk3?=
 =?utf-8?B?V1V4SzNpNldBUGw0ek45d2Y2VEVlaEUvVXBIbFR4R1dQTHNxSms4UWFUdzUw?=
 =?utf-8?B?MXg2cHlIVjJyL3dwL0lKa0xNNXlyT3lnYm5DM1oyL2F6M21DRmxtc21DdUVP?=
 =?utf-8?B?VFpmR3hwbitaMEhUVGNVZ05FT2ZvM0ZqMGYwUzhjcVV1WGt2dml0cUdYRElh?=
 =?utf-8?B?eisyZDQ2QU1ILzdoSWF5QVVMcHErU0h6T0pFcWQxZU9pV0IrRVBIZ3Z3NHM4?=
 =?utf-8?B?VU1OQTlWRHNYRjdQRThKcEJjNmo3cmt2OUo4alBVMEdkRndzQ01FR0F6NEJJ?=
 =?utf-8?B?dGl1Zk94WVhVMTJtSkw3WXd6dDNkYnhCQWNwMEM2VU02UUF5cGdPUnFLL0RM?=
 =?utf-8?B?WVBkYk1vUTZYaGVnUVhPUHVrVDA1d0NyaFZ2Sy9aOHNFNEtnQXJjVEdVaDFC?=
 =?utf-8?B?QjJacGVMdEtweFFGcTdycFhJNlFOM1RiNEdBT2hSWGY5SER0UFN4ajgxZHBL?=
 =?utf-8?B?eitPZXJEb1VpSmdLYWx0b2hBVzBOUDVSTGlJYXNyU1c5dHEweXdEY09WS3pj?=
 =?utf-8?B?ZmFnQjRCUDFtdi9iYi9aZVEvUTJLekxWZi9hYVZpcXQrdUk3amNsNHdzNEJn?=
 =?utf-8?B?VDVTZUoxeTg5NFVRRS9SdC9JZ0Q1SU1vRE1MZGFTZW84RDNDNWFpQTFqWnNo?=
 =?utf-8?B?K1paa0VrSUZ4U0p4TUtKTWRhdjJzTDNVRFEwL3JKb0RZUXpMNlJqMXhEdGVD?=
 =?utf-8?B?bTg1Qk91WHVKa0RxRnEzMHNtYnNrZW1HWG54NGRZR2Evam9kMzlHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E664941D9996F4FB2CE1B3555F4D1E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WbuJIwadcofa8pcnVVE9bqV1I3HNDLP9G5KyqYyLuzBuCBOnFiLujvw/St2cxD+mQRiegP/T7+cgFJPdpycQGHQmvXAV/e4SPn2K9/GM8IbW/AKcYJsOTEYpycbFFGpXufjSAuynPsruh6k6YLPtkfUoxHfOHCT0ycvusFnmjD1W3ZKokerpusbqGbOvINFGy3YkAAeCo/lf59toznTwrPK/wC6kPy0bNHFCMOh9CPNBuiq0/yjQCnA84Ypv6iGmw2LYZTIL1BQV1pR7LjvqSFohUvttcbPSuKzn63k+03lhVst3/m8uaw6cZtqNej9Hvu2UAsHU1q+BnV9zwPz0Pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e7aba-39a6-497e-8547-08de833b5b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 09:06:49.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGJ3n5a/esmkkqXVXA5DGHXf227e1pv4VDG1NxvZOSnAI/+EAX+Ns4rtgVW7uf+fkfnNxN/Ax9tw7Wd+uWypaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com

DQo+IEBAIC0xMTc5LDYgKzExNzksNyBAQCBFWFBPUlRfU1lNQk9MX0ZPUl9LVk0odGR4X2VuYWJs
ZSk7DQo+ICBpbnQgdGR4X21vZHVsZV9zaHV0ZG93bih2b2lkKQ0KPiAgew0KPiAgCXN0cnVjdCB0
ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0KPiArCWludCByZXQsIGNwdTsNCj4gIA0KPiAgCS8q
DQo+ICAJICogU2h1dCBkb3duIHRoZSBURFggbW9kdWxlIGFuZCBwcmVwYXJlIGhhbmRvZmYgZGF0
YSBmb3IgdGhlIG5leHQNCj4gQEAgLTExODgsNyArMTE4OSwyMiBAQCBpbnQgdGR4X21vZHVsZV9z
aHV0ZG93bih2b2lkKQ0KPiAgCSAqIG1vZHVsZXMgYXMgbmV3IG1vZHVsZXMgbGlrZWx5IGhhdmUg
aGlnaGVyIGhhbmRvZmYgdmVyc2lvbi4NCj4gIAkgKi8NCj4gIAlhcmdzLnJjeCA9IHRkeF9zeXNp
bmZvLmhhbmRvZmYubW9kdWxlX2h2Ow0KPiAtCXJldHVybiBzZWFtY2FsbF9wcmVycihUREhfU1lT
X1NIVVRET1dOLCAmYXJncyk7DQo+ICsJcmV0ID0gc2VhbWNhbGxfcHJlcnIoVERIX1NZU19TSFVU
RE9XTiwgJmFyZ3MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwl0
ZHhfbW9kdWxlX3N0YXR1cyA9IFREWF9NT0RVTEVfVU5JTklUSUFMSVpFRDsNCj4gKwlzeXNpbml0
X2RvbmUgPSBmYWxzZTsNCj4gKwlzeXNpbml0X3JldCA9IDA7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IEJ5IHJlYWNoaW5nIGhlcmUgQ1BVSFAgaXMgZGlzYWJsZWQgYW5kIGFsbCBwcmVzZW50IENQVXMN
Cj4gKwkgKiBhcmUgb25saW5lLiBJdCdzIHNhZmUgdG8ganVzdCBsb29wIGFsbCBvbmxpbmUgQ1BV
cyBhbmQNCj4gKwkgKiByZXNldCB0aGUgcGVyLWNwdSBmbGFnLg0KPiArCSAqLw0KPiArCWZvcl9l
YWNoX29ubGluZV9jcHUoY3B1KQ0KPiArCQlwZXJfY3B1KHRkeF9scF9pbml0aWFsaXplZCwgY3B1
KSA9IGZhbHNlOw0KDQpTaW5jZSB5b3UgaGF2ZSByZW1vdmVkIHRoZSByZXF1aXJlbWVudCB0aGF0
IFAtU0VBTUxEUi5JTlNUQUxMIG11c3QgYmUgZG9uZQ0Kb24gYWxsIENQVXMsIGFuZCByZW1vdmVk
IHRoZSByZWxldmFudCBwYXRjaCwgdGhlICJhbGwgcHJlc2VudCBDUFVzIGFyZQ0Kb25saW5lIiBw
YXJ0IGlzbid0IGNvcnJlY3QgYW55bW9yZS4NCg0KQW5kIHVzaW5nIGZvcl9lYWNoX29ubGluZV9j
cHUoKSBpc24ndCBlbm91Z2ggc2luY2UgdGhpcyBkb2Vzbid0IHJlc2V0IHRoZQ0KdGR4X2xwX2lu
aXRpYWxpemVkIGZvciBvZmZsaW5lIENQVXMuDQoNCk9uZSB3YXkgaXMgdG8ganVzdCB1c2UgZm9y
X2VhY2hfcG9zc2libGVfY3B1KCkgaGVyZSBzbyB0ZHhfbHBfaW5pdGlhbGl6ZWQNCmZvciBhbGwg
Q1BVcyBhcmUgcmVzZXQuICBTaW5jZSB0aGUgIkNQVUhQIGlzIGRpc2FibGVkIiBwYXJ0IGlzIHN0
aWxsIGNvcnJlY3QNCkFGQUlDVCAoc2luY2Ugc3RvcF9tYWNoaW5lKCkgZGlzYWJsZXMgQ1BVSFAg
aW50ZXJuYWxseSBkdXJpbmcgdGhlDQpvcGVyYXRpb24pLCByZXNldHRpbmcgdGR4X2xwX2luaXRp
YWxpemVkIGZvciBvZmZsaW5lIENQVXMgd29uJ3QgcmFjZSB3aXRoDQpDUFVIUC4NCg0KQW5kIGFz
c3VtaW5nIHRoaXMgc2VyaWVzIHdpbGwgYmUgYXBwbGllZCBhZnRlciBTZWFuJ3MgVk1YT04gc2Vy
aWVzLCB3ZSB3aWxsDQpoYXZlIGEgVERYLXNwZWNpZmljIENQVUhQIGNhbGxiYWNrIHRkeF9vbmxp
bmVfY3B1KCkgaW4gVERYIHg4NiBjb3JlIHRvIGRvDQp0ZHhfY3B1X2VuYWJsZSgpLCB3aGljaCB3
aWxsIHRoZW4gZW5hYmxlIFREWCBhZ2FpbiBvbiB0aGUgbmV3LW9ubGluZSBDUFUuDQoNCkJ0dywg
dy9vIFNlYW4ncyBWTVhPTiBzZXJpZXMsIGN1cnJlbnRseSBvbmx5IEtWTSBwcm92aWRlcyB0aGUg
VERYLXNwZWNpZmljDQpDUFVIUCBjYWxsYmFjay4gIFNvIGl0IHNlZW1zIGlmIG1vZHVsZSB1cGRh
dGUgaXMgZG9uZSB3aGVuIEtWTSBpcyBub3QNCmxvYWRlZCwgdGhlcmUgd2lsbCBiZSBubyBURFgt
c3BlY2lmaWMgQ1BVSFAgY2FsbGJhY2sgdG8gcmUtZW5hYmxlIFREWCBmb3INCnRoZSBuZXctb25s
aW5lIENQVS4gIFRoaXMgbWVhbnMgYW55IFNFQU1DQUxMIG9uIHRoYXQgQ1BVIHdpbGwgZmFpbCBi
ZWZvcmUNCktWTSBtb2R1bGUgaXMgbG9hZGVkIGFnYWluICh3aGljaCB3aWxsIHRoZW4gcmUtcmVn
aXN0ZXIgdGhlIFREWC1zcGVjaWZpYw0KQ1BVSFAgYW5kIHJ1biB0ZHhfY3B1X2VuYWJsZSgpIGZv
ciBhbGwgb25saW5lIENQVXMpLiANCg0KQnV0IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGNvbnNp
ZGVyIHRoaXMgY2FzZS4NCg0KDQo=
