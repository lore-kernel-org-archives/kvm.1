Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5204052A2;
	Tue, 15 Sep 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488699; cv=fail; b=DHjQJ0Lvzf7nPgMd0Rb81UvJukqJX87Xg0EYFgjlf13OYpguDtkkHJ3lEIlyIjOntEhg0MbBOkNF58Q13LEzc2JyxVNUK5LuEKyE2u/LOfTiaBp9Ild7VYyYDOb6YQptpTIhCiqLlX9xyZ85aTGpsy4Y1U1m5onJFL9FJJOnKPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488699; c=relaxed/simple;
	bh=ujQwfrZLCDD7oMLAl+VZd7UqTHDk5rekT6sZtRcwKK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyc026rmL12Li+p3oBvgByKG1Zy9Kf+vhz8jUCgjKUwU1HXXAV5IgKYZNvz1MKtLO8tRtG6YlxgURmOLIhafuq71QttOJHuNK7dLdJzK+Li8rpKZ1mVjeCoPiDT0pnF2sUwWNNvxqFqB+oWu+nQ5QyMbxWbdfb8/+b42udXP4L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDCYkMh+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDCYkMh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789488697; x=1821024697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ujQwfrZLCDD7oMLAl+VZd7UqTHDk5rekT6sZtRcwKK4=;
  b=JDCYkMh+VwLDZL6ZzEUA6HTrrKf2zEC4P7RK2YpNYxzbBjPmyf0MoL1G
   lhuswBDLlZ63AGuRxNPAZWzFSTVflist44jNwJdBaSibc6Voz9XHKn/NA
   pXfavMH3U8KlvjiJTAP9VMM/c0tttFAqgyFNGDCVzt4dufxW/XqqXBqof
   coH8a1PcWZhPkX0NmBtdBDInIFQD/qMc3PuST6D7tUCnhvb+7KWgodY+U
   FZiyU5GS8w6+ufPPdomfrlZxRSanAdV0sMgOxy2RsPdC428cNr/kXGDJC
   BHxZQkx+BdJuoHXaEstbsJtMh/smlQqk8UaT1mdfT2OKJ/lrX2+HwIRcq
   w==;
X-CSE-ConnectionGUID: gmnA+MyHSXOhiOBJUxhpHw==
X-CSE-MsgGUID: O+tjdfvASmO6KF/a6aUcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88796731"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88796731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:11:36 -0700
X-CSE-ConnectionGUID: wsRB93ZxT1GjJXepRMYYGQ==
X-CSE-MsgGUID: jYRJV8njSViIsJw1k1U6og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273031209"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:11:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:11:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 09:11:35 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIpC09dSuQcQAS3xyIaN5kST5loqlHXrJM2i+obwdEjiSsuzF/zJ35oqk+k6/iBIwRObSVIR+HcdzEKHdt6iWSXx5vKDhTPKUAkaFctPmY9WvrGk/XTAQW3hcc8LjNlIdWbKYfGNN+eacAOzab06DjOEv/bIc9u6mMLWgjM4fQ0QOQdF1l0ItZ32l3lCfXNSnes7/UIZ2PcdJAmOJ71ONWwmv1eluE5vADK2Urh0TX6UW7b2gDT1zGR3Ch+8B8OCfznAQyTgzcikK8hvuG2QrAZERq05UPib5QunYcee+btMfoVU/9KSAejLjs8uiXp08hMHihqy3wLJ0INN7aSoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujQwfrZLCDD7oMLAl+VZd7UqTHDk5rekT6sZtRcwKK4=;
 b=a4DjqGqFtAy46y+1aectnYP9mmKxhQvSwc9V/6mQ+KtCwsMPGyENJEhPFR87a0GYuz36ldhJlZGc4nX+q+P6CeKcNhz/rOjWUco3EXhUM42Cazd5WswD6SGrip+V6sJK+HpZPNkJva+OQQZ9UaW0b4AFj+CQd4f270tB0qOtqpNy8G9nXuTyyU/yjMV5y7/tKGyYGCJbsddnGnKrOsPg2N1inIIDc4WK9jd/dwCmYKb8oJFl4WbB3YlyAw7HzDIIxdCGtjqogShyzj5ViXn0YYH63UEOBI2DKdEk0ZbhZzO85DwuoCsvy9HIn+RmEdWc7mvUfy4NCMK1l7l9GwWDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:11:31 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:11:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Fang, Peter"
	<peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdRPRpGgpLmgOIuUaxLUBjd8KBF7bPrRqAgAAiuoA=
Date: Tue, 15 Sep 2026 16:11:31 +0000
Message-ID: <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
	 <aqlRETiO58SWjFLF@google.com>
In-Reply-To: <aqlRETiO58SWjFLF@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB9614:EE_
x-ms-office365-filtering-correlation-id: 26ca73a9-7ebf-47c6-3ffc-08df13440173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: oS1I1+m8xeZ+Lkhnq8m6LnZmHugtj/tJmgbVZ8YucwDXzFIMMSIWKhxP0pXCWbhpCd57IDLNbPhfhUZ53vKZl5/an2pBYdsqwGyXSBYXBl92Cs8X6PJAvTtW7qUirmXyM0Y4DCbz7ezNSxIUuldnbtQQKQvThlGlFTZ8DXfvyRMYBHJA/WgXl6Fv/aPRwHmbLqkZsn8KGyKTteHcz9YXeqZu9aKOx6ph02v3kLzxc1Nc9yzwqiULmFrOTTHq1P4ZBK4Pc/N3TypwtY6abcFY9Nwqwli/KIEIsYw/wVefipOlsgmcJzgMTJhf8cNP7mWk91NXRtyBv6IRG1+wBfQ2o2CvLPk2IVVI57+fumPFOOA+YnHPqR5448TiJWsXrPx/anleoe9YCuR2/nZ0Hl54Uw5pYH3W+nz32Q92bc+e0P2je7f/ly3kk8dgUvzeQO8pQwflZVXLyTuBA9qaelAVlNqHZLfLhjFlpoji76d+l/QhccUx9FjjPvGsqRwMJCYQH/IdQV58RF9u0PQWpU/SQiq7CgYKb525OhRfonVTj0pCzjs9/52GI/vXsSvK3eXqtq4Y8NoIT6CX2e3UfBjQUYjosPT/iXnGWyC0zZ80nxEssHxFekncrK1F54u5xjhSBveWPLJij0I0o/qp7xXMYsQ5zN73GlCc5Basq5yoDinOwif+m6bjEs4VJb81G3+jag+L554q7WZUYRHlEFxhzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFAxUlNxOVlOQjNWMnZMamtrSndUYlEyd0N4dDNqc1VuUnVUYUJ3SlFrNUlU?=
 =?utf-8?B?a21OYjErY3NaWUJ2Kzk4VlZPM3hVeXJLVENYNWFld3Vudnk5SHdvNXlWWXQ4?=
 =?utf-8?B?dkdSZEIzWlh4dWNEbEpkYXQyRExNa0hpZFJ1anR6MGVORk9udVFJOUQxUXRL?=
 =?utf-8?B?cXlTTmMzNEtTWFFqaGJ4Mm4zTnFnUm9CWHZiQU94czhaOGZPaitmS2xic0tl?=
 =?utf-8?B?ZkNPU25EVktlM2tkWkdmajVZOTJ5MW9NN2ttbGZjSFZPc2hnMWdYaGNjeFhH?=
 =?utf-8?B?UXUzM1ZVM2lSMVZiV3owMWdMZjEwZWJOclZVZTlRUmFJSUJSOTVaT2xTTXZ2?=
 =?utf-8?B?aHZ0Ty9MemlhZnFIZ2UwMkd5NnVhVnFGRm80cDlaV2ZRbVd3ZTdTTTRvd3Rr?=
 =?utf-8?B?dmZGVm14N1Y1VGZoS3A3aTFUWU9kZDRva1dFMlBvVXlMMHRZakh5cS9NZlZV?=
 =?utf-8?B?VFZjQzI0M0YxTnlvcDdoeFJYYTdlN0VpaWFvZDZpSC9oWStJRzZJY2VtYVh2?=
 =?utf-8?B?MDl6V0Z1OTRncEl1Z0d4R01oSjdOS1ZQWDQ3d0lsRXpFTHhDU0FKMUhINThK?=
 =?utf-8?B?TDhFTjZWZ1psZ1MzM0hQTUF3UGovYmsvV1oxbjFkOGNVaEZSYzFKd2FDTUZq?=
 =?utf-8?B?dnBlNi9SNytrNVdPOXJEQ2R6NkpXRUxHRWNEbVc2NDk4ZThYV0NwZHJrZzI5?=
 =?utf-8?B?WFBSeGVZSjlpVGNMaFUwT1p1NnkyWlFnWHVFL0FoMmp4WXgvZ1JHZm1nVktu?=
 =?utf-8?B?bkgrbld0cVkyK0NXZDBjN3ZFRy9QSVJnYkdoYjRsdkdkb2tmZm56V0FLYTJQ?=
 =?utf-8?B?QzhkUWU3b3Fnc2N0Z2dhL0hZM04vcXBwY1NPb1I5YWRXU1UxaVpwN20rbFA2?=
 =?utf-8?B?bWVPOHZRQWZJdDE1MVVyTHV2UW5YcnhEazZ2eEIxQjdoeTQ2bXdTb0hnSjdl?=
 =?utf-8?B?cXJRU3RpU2lTRHpCcHFhc2xUVkdkanRzSytjQTEweFJsTis1S3JyMlM0VGtM?=
 =?utf-8?B?Tm4xM0J0NGlvSkhWYmtheHh4RjBmMmlITFRFUDgveUtwMW45amVwMmdKSThD?=
 =?utf-8?B?eGZuNXppNjBHZ2FnQ3JTeVhTSmxlcUNhYjVlWVY4WTl5RkJNUjk0ZHFaYUVm?=
 =?utf-8?B?SFRUWjNHSnBidFhKdFIrVjBYR3pEcG9QeTFFRGNrelV5THVoZy9XeDN0cEl4?=
 =?utf-8?B?S3Jad2xWbDVsOHNNQktDSmY1R0NwRFRIMWJqcFhWd2RPSGwvWHhldGdRNUVn?=
 =?utf-8?B?bndsZDREd2ZVbVR4cVRxWEhleWE0dmo4NlNNZEtvN00yYW9TWnRqRHFJYVVG?=
 =?utf-8?B?Qnl2bFRrdjhjUmhYN0VEZE1YbVMwZTdmQm5lQWJqSGdFd214STEvczdSRGY1?=
 =?utf-8?B?NjBRaVYweldabjY3aW9sV2Q2d1A3dGVoeThYMnF3Nzdad2RnRzNSUnh4TDRM?=
 =?utf-8?B?SEtiaXVibUtoQkdnZG9DVFhyaFFMZ0w1Tk10Q2xEbytnQnNuQ0tnRGcwQnkw?=
 =?utf-8?B?Q2VLZ1dBQ2ZKM09Ba3NCa2pNYzQybjNlUkE4WjdtUlI0a0QycklOTkNyeDh4?=
 =?utf-8?B?QlFJNUFRMDVwY0hnM2lxQ0F1M1NKMU1rekZZY2tCQWoyWVAydUptYnhsK3FS?=
 =?utf-8?B?RUMxTFErcmlrT3VNRmpxTGliZThtamliWVZBK3N3eExGajhsNUs4VUZLdkpu?=
 =?utf-8?B?WU9kdGY2SUN3MGQ5SThtUW9adkJoUEk5YW5PdGJHa0N1STk0elBOUU83aFda?=
 =?utf-8?B?aUp3dnVHTnR4dUtFcVBoM1JXbFdyNTBEbnRvOVROOXJnZ1VLaHordVM4aFVD?=
 =?utf-8?B?MUt0bTExY0dXWUhkZjk2elQyR0xrc2VobUt4dXlBSUlzWjdML2JQd2JRcnpB?=
 =?utf-8?B?ZTRicUgwSHEzUnA3eXhZcnY5cGxWWDJZYllWMEhIeTlIYTkzS09uVWNmYWtn?=
 =?utf-8?B?VGxGa25LYVZvcjFrSHM0TDZpcVhkUDVvR1VFV2tBUWtUOWp4OFFXNFlxdFJF?=
 =?utf-8?B?QTdIT0VuMmp4QVA4RkJvR1dvdkxXTVFmcmJEOUNLMXpoeGJibndRcjlaOFZF?=
 =?utf-8?B?NmUzSWxwaWFUMUxuRU5pWkdzMnd4UFl2azI2UmxUVm1HWUk2L1lRWjNWdGYv?=
 =?utf-8?B?U0VvdHFPZFNpa2d1ME5VMUdkU3EreTBpTWZMNXpOeWdhV09zUTZVQkd1V0ZI?=
 =?utf-8?B?RDJnS3FOWkNjRmZUWWF1eEtnQ2dZR3o0QiswRW9BaVdCTWxFdTM5UEl4OGNK?=
 =?utf-8?B?RHpSbnlHVTBBc2cyeThWdHhQQVNSVTBlWkNqdjZFMFBGazRoVGJ0cW1LMC9q?=
 =?utf-8?B?V0NRQksrYTdSNTgzSjNQZ1pqTG5UeHBtWURrZk5qSWVWelBUd2NpZjdIUHBD?=
 =?utf-8?Q?Ulh3zWDPfApkNy3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF234FFAAA90024989EF650D2307532A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QgB7fFt6TFgTE0+AiHE0mNdsQnA9MCQjeaAsLouwtImp5r4DTAvxMmcKAcQ0aBQvJN0aHOmNQ0Ik1YocPv3UU4bGoyBrr/x8CKmmsM83zM2xoOQHxoUqC/PhNARHbMDXNXQdn9sCiKhuAhtgoz/kf09eE1Jgvzupjt0xrPM95mhzf8hHSFXhmR64jhFwQvukBoacVz0aMpP+pmO4B4hapZNYWPm977ITHEG3cURn+/tL/rR6hQEGKoiHVVlBEPw8DZL8nu5u+oXf4CH4KvCCIAytRwDVX91AP7Iptm/SKMEqQnULsp1W2ARHz3lioRqnbHldcYcZ3U83GoPwU0YHVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ca73a9-7ebf-47c6-3ffc-08df13440173
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 16:11:31.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XAiB00VunhkKnLeukiHmcqr846alI8TeOlnhayWUlfCnMflgBQqc5293ZJ09oVavki5PatYdXp3r7ZLz//LQnCcfXxhC9+Koijl5LnvyAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDA3OjA3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBXaGVyZSBpcyB0aGUgYnJlYWtkb3duIG9mIHdoeSAiZ2VuZXJhdGluZyBxdW90ZXMg
ZW50aXJlbHkgd2l0aGluIHRoZSBURFgtDQo+IE1vZHVsZSBpcyB0b28gY29tcGxleCIgSSB3YXMg
cHJvbWlzZWQ/DQoNClNldmVyYWwgb2YgdXMgaGF2ZSBiZWVuIGludmVzdGlnYXRpbmcgdGhpcy4g
SXQgdHVybnMgb3V0IHRoZXJlIHdhcyBhIGRpc2N1c3Npb24NCmluIHRoZSBwYXN0IHdoZXJlIHNl
dmVyYWwgY29tcGxleCBidXQgc29sdmFibGUgcHJvYmxlbXMgd2VyZSBkaXNjdXNzZWQuIER1cmlu
Zw0KdGhlIGRpc2N1c3Npb24sIGEgbGFyZ2VyIHByb2JsZW0gd2FzIGlkZW50aWZpZWQuIEJ1dCwg
YW5kIHlvdSBtaWdodCBmaW5kIHRoaXMNCmZ1bm55IGdpdmVuIHlvdXIgcHJlZmVyZW5jZSBmb3Ig
cmVjb3JkaW5nIGV2ZXJ5dGhpbmcgb24gdGhlIGxpc3QsIHRoZSBsYXJnZXINCnByb2JsZW0gdGhh
dCBnb3QgaWRlbnRpZmllZCB3YXMgbm90IHdyaXR0ZW4gZG93bi4gV2UndmUgYmVlbiB1bmFibGUg
dG8gcmVwcm9kdWNlDQppdCwgc28gd2UncmUgY3VycmVudGx5IHdyaXRpbmcgdXAgd2hhdCB3ZSBo
YXZlLg0KDQpBbmQgaW4gY2FzZSB0aGVyZSBpcyBhbnkgY29uZnVzaW9uLCB0aGlzIHNlcmllcyBo
ZXJlIGlzIG9ydGhvZ29uYWwgdG8gdGhlIFRERw0KZ2V0IHF1b3RlIHF1ZXN0aW9uLiBUaGUgYnVm
ZmVyIG5lZWRzIHRvIGJlIGV4cGFuZGVkIGZvciBQUUMgc3R1ZmYgaW4gYW55IGNhc2UuDQo=
