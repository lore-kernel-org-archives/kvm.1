Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA033F074E;
	Tue, 14 Apr 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188076; cv=fail; b=l3fNSn8NCGB0ig79udYQQVECbj6671Zv2wzvcQXUOWv+siXslh8+Yj+mcGE2iyxlBT4fUe2cuzJMs8uC/Wl+gN+8l4CltKVGVTSiY6DfKBxsH1mfSqyy4q7D2NiGiE3FJEllCWdJ3y47e6AQFV0FeeGr0mODnMCzpMBcSctaWz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188076; c=relaxed/simple;
	bh=1HVmnlvBuhfQpv5H9xJ6NO4rvrH+qbVLdQLCyZDC4+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJ3vfS2NYgV2acIZxqytwea+K10FA0evaNcMuhfPf8oAmM+iCqLxxcOdihGqAYQ8USLgoRSwbV1NpP9h5jxzOjBNFmBo5gT/bL32vOwfsmbJ58X4paSLZDig8w6Z8phHZ/XCOzW1XsCxVpuaMRu5xc/k3yQZq4wT3BpbeTKE9Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cig1VWon; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cig1VWon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776188075; x=1807724075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1HVmnlvBuhfQpv5H9xJ6NO4rvrH+qbVLdQLCyZDC4+g=;
  b=cig1VWonD7bD3EdIvQr9K+zf44AFdZBiBoUaqVCzIoJ3H3lnLDxT3JwZ
   CF0ZR2POlVDwuk7fCOPioyg086n4CISm33YKiXHT0ZP8oVaoBRcP1LOQ+
   a+0Durnz5zB8ftBqJpc2y8Og9B+aDnS8nuHbFPHUALO4VRS84uskQQZcI
   1CehNcDlWcn2SdscB1TBL/PLYR+Cn2VcY69G2O15Hp6aZmoHocvMQeVaj
   JBCYK6T1/sL1wK4YBv3SfAaCfv+ghKleJTZgvnslu8K6U+NIK+1J/62nM
   /oo5kCgeJ/Igma9cNeUfFi8O/jmAXTvKdh/4n2alfwre+ylQiwDeqkfKS
   w==;
X-CSE-ConnectionGUID: Ktln1EtMSyeW+zh02e2tvg==
X-CSE-MsgGUID: 6nFPs0uLS3GUhxNai2CNcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94555670"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94555670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:34:35 -0700
X-CSE-ConnectionGUID: LltrSS4PQsWTKlfjF7nlWg==
X-CSE-MsgGUID: efDfd3KlTNS51P4VbLxCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223656228"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:34:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:34:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:34:33 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnrmvhYynkskytXMOgSw5LJ3WbPu/K6zTsWzCqfWa8Z9nCHD+cuhqbtHpxPjFO+6ktQcKU0qr7fvY+/yooOwUsNx2VymP76RH7gzuWAREHIDhtR0eb4fhrz/yOHBgU971gNnqv68hSGBUaFNNnSkmAa6JhdzNeHTeM0dXWn4e4VreKvQVHE4WkV2JCO/rzlFP1/eez+764ojNOLcxn0IoxfHpNVyQyiNkbBtvGfJBDVe7sCC300U4OCoy6x+QkhykYQoo6jFEYw7rUssQ1bWsz0qY4dRG64FwmNFSU6S/qFHJp/PFajYfR2HjlNLrSqP5K/H83VyVHdBlWfy6nQLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HVmnlvBuhfQpv5H9xJ6NO4rvrH+qbVLdQLCyZDC4+g=;
 b=KBymQ1p5BdFGBFu9jYse8ME9xsVld9Op3WoR+AIMAYixzN4ysN/zgBx51JaKT/eXbeEDcM7EwQm7Lozr0g0PYhhAOJjRDtjQmj9bKVjYAe7gOpsEWaVpQJAMYNm2G4DU5vDqTYS3C6BSi5MiQ2UMsIDhbNtcuYA/LU4hIfIkHLQ/Hn5SfdfUZ/+7VW0ALzy55bbpjznAvVMXAwfdvR/VlGiJX0KhFCPskii5eyXArpNZaNnyUSo3zHtdLlB6ytoBRuCs1jaN3QtjOuTLk+jM7QXpK85Wzqq8A4IfrJ1EAXTGJ9NhKMnyY5hF1DDHx29octsPqGuqOS+A/zLJk5EVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Tue, 14 Apr
 2026 17:34:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:34:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Topic: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Thread-Index: AQHcwQwBQdKo1xDEBkCS+uvoFa2Ab7XZJN+AgAVGp4CAAHw1gA==
Date: Tue, 14 Apr 2026 17:34:16 +0000
Message-ID: <7dc1a69516a3f5778c32f551620ea7f6f74e1d64.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-12-chao.gao@intel.com>
	 <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
	 <ad4SZdlybWkLtLEm@intel.com>
In-Reply-To: <ad4SZdlybWkLtLEm@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: f121674b-d166-4dbb-910b-08de9a4c0d30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: tKbeRSJ4vyklyduimo1bevNCk8joXTn6FCGqmYvjK9D0Tzj+Ay22T/Tsg08uINVStdN0sne+pcAJTVT5VRC3w4NLm8iZlZMhHuCq2ZiO6J6mfWOqaVpKTBKPHNnZNnAkopIo7A+/VI6VE+Boac8aYN7HXGAz1ist208L7f72S4l79FF19E+NPd8Pi6UWl2PeAt1r6X1NUXOqRWxa34v3v7GxnrxYluVa1c2VVzCtuaeP6WjAWuIWgi6+hJKTDnxfmtUiFirLySUNEOVa8f1bCKFPacMO0+Je7OynMHk7fz7DtuNWQvEhtzzWt59xV1CllaXAmcSUtr0kaJs8pscXfwx/AH33dWrcbYo9fuSoOaPjf8FRuJAY8SwE+WsK4/8EawWKXFTcGWMJDB+jxnAWLf5VznB1II3QPcDTUnhbNyXxlaPzexw5FPI4HG9y2QMxIr4kx+Uxr032Ux4EBs5icjpQK501+jHE1pA5clWVZWYEQtGfoNOJb5vagt+1PMFvrfOOSTtSIB2d0W5e+a79bCIbvlBJbr/qIt1pMrBATFE+QmRQDIQ/bubh+Lt6W2u+I8J4iS0bvEAKjc1rZfxRxWG7cMBjROfm771oAAAcPR8pPDdOMO8TwlYfiGHWnjnUd+s7Kl9q8qLkGrRAcoBBTdSaRZ9z0emA5CRy6gOxhfC+APb13ZYlf5ZAU5yqzx8tXCfsWYv/9qC5pUlexjLPPvAiepxg6ED8szVVR28Cqo+S2skhbmeiQhfYmqzepZoYjZ88mgJ436VwzHqY34AQ+zu7vYeySWhyMBA3K7wj18c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXpERDBBTHRIc0x5dU9VQlpuMVNXSnFDNnA0d3I2bW9ZbVhMUjU2a3Iwbzdi?=
 =?utf-8?B?U2d1dU1UT3JFakd0Uk9yK1M0ZWp0QTE2V1ZZdDRtZUY3bjlEQy9wTERONkVR?=
 =?utf-8?B?eld3UGU2ZFRTTFdVOXBMejVyTm9UZ084bHppQ0VNWmlwN1grMjBnS0VLRkx5?=
 =?utf-8?B?UnlpQ3FjNnFTZ3Vxei9lVUEwQVlKRlQwMEptd0V4dlF2S2R4cTNFMXhxR0Zq?=
 =?utf-8?B?UEF1RFdHOFpOYWNJZnNOenVIVnI2cVJZZnc4OG0vR0dFT3hRVkFhRWZkaDNo?=
 =?utf-8?B?QlhaeEs4ZnhqbVY2cHE5Y1ljSXBQUlhaUnFSQ1ordyt4R0NPM25GR2tHcXBa?=
 =?utf-8?B?YWEzUUJibmYybFBIR2RZWjVuVDlNOHBvR2xJQkxpVWNUOUgzMElyM1BtV2Jx?=
 =?utf-8?B?VmFhUWRQYnpJM3Vvang2WS9DVTQ3R0FZNFVHS3lEYTduNmxjVUh0aEs2Y2JF?=
 =?utf-8?B?OHFvUGczT2I2RmdFSmdJRFBuZlVJcHVwZDlFd0l1eFFNYmR0QjdodmNSQXo4?=
 =?utf-8?B?dzJ0ODBxNWpoWGhPZWxoV2pmWlhDZmVyTER6OTNxRFZSTC9MaEI0RVpEdmRM?=
 =?utf-8?B?aSttV1drcDdYTEsrYmxFeWVxYmRkVDN1OEFOSG5QdWhzalhxeUdkRVp6T0dG?=
 =?utf-8?B?SUtWaEYrMTJmbDM2V2s5WkxzakhRSDdnVUhlVVdVSUJ0Qk1aUWVuN2kyR0ti?=
 =?utf-8?B?ZEgxanNDTUlGYWdxbEdOSFpNcVhCRkpLYk5HUEtxNWF5NVdxOFVKcnU2VzBU?=
 =?utf-8?B?TzhkRlF2c0QvY1ZsbVY1MEMxdTZXQ3pjdFNKZ3B6MXhwNHd2NFVHcXNRN3dY?=
 =?utf-8?B?cHlraGxPdWdpR1cxQW84TVlROUs5MXFjSTZTdmhnQ1V5OW5sM3FlVEx0MjU2?=
 =?utf-8?B?TGs5QWw0bTJabkdvRCtibGh3dFk3NWw5RElPNy8xSHNucWFrR1U3WkZSZXlQ?=
 =?utf-8?B?eXRqZ0xVaERld0UzTWlRRkw3QU5yVG1ZZ0ZkUXVjcGZaNGg0V2pmc3UxR1k1?=
 =?utf-8?B?RkNsajJpcERmb0NCU2hEbU92ektXMkdvOEhyRXJoMmR0R0pEK0RIK2hMTUQ3?=
 =?utf-8?B?UmlmQXVycEJLcWUyWFlPenQ0ZXdqaHZWL0hsdnVWSVlKRExhQkJkN2x6cTE5?=
 =?utf-8?B?eVN5VE5teURxYi9UYWdpbDdCS01zRXFYZnMxT2g0UllBNithVmdxR3dmOGJT?=
 =?utf-8?B?UUhXZG5aS1ZxZDdTRndQRGllVzhBdlNUSlJqSFcwaFNSQVdjVE1nRjVvaVVY?=
 =?utf-8?B?TXQ5aDBhbU9Pb2FrZzFqY3NVWmIveVlKcTdwL1JpSTRWaWRjdk9rckJ2UDU5?=
 =?utf-8?B?dUlpMVpIbTV5czNKMjBHRUxMb0dlZXM4OGpXcGdqbGk1MDlyK2ZHdDYwcVNp?=
 =?utf-8?B?RVp3MzZxL2NHczdHVEhxRWJlTkxyOFlRY1lyNXAzYnMrQ3FaOTZKbDhJNVB1?=
 =?utf-8?B?OHJ3YlpTaE9BKzZySmJSR0dJQzhPWkxBYW96bDZvbHB2MkEwRW9lVkZWbXJo?=
 =?utf-8?B?andGMHFBa0Ewd2Y4enJ2OHZHYjU1Q3FCb3A4OHFMYjY5K2tPcWU3YTJVZWlL?=
 =?utf-8?B?WDFsT2Y2UUFQNTJiY0JyWERjaUcyVld1dGtBdmNkVFRJcFRWUFNFZlJTSFd5?=
 =?utf-8?B?c3FPbDNNajcxVldHKy9BWVdveW9XNnNYek5SaHBsOWFGaGMrME9CVjB2akVD?=
 =?utf-8?B?QUEzY0FWRnU0eUtsWHVwVzJEdnBQVFhPbnZrK0toZVBYRGorMml0ZEZweDNJ?=
 =?utf-8?B?b1kxM0Y1bTFkZzR0ZDg2akRNKzZ1aHg0SDE0TXpTN1NOQ2c0dFFUK3RUdGlD?=
 =?utf-8?B?NG0wODVFQm94THd5bVRzanNzaE9GanlpVG5tbDNRcFpIbHdVVElOb2ZPNEU1?=
 =?utf-8?B?SlFhMzU1eDZ1Ny9PaWV6MVpJbDhCN3Zpb2pvNUhIeldXaHZyV0dwaHFHV1FD?=
 =?utf-8?B?NENMelRXdFFRM3lVWXN0KzlaMFRuQ254R2NhVFdod3llbWNCdFpSelhCdGtt?=
 =?utf-8?B?TnlVOXdLQjFZUG1xMTFGNGJMNktLMVRVZUg5RGUxMFhFNXdNWFQrV3dzUkFL?=
 =?utf-8?B?dFNUSVdoYy9ZTU9BVzM3VlBxYVR2dHdIMUVheXhEL0NYd1VvSDNxdzhhSjd6?=
 =?utf-8?B?aTcwKzNucjZKZmtuUG9RQkpTTVhxVzFNbXN6TXczT05pUVNvM2pOU0NTVTQx?=
 =?utf-8?B?WHhCRk94VWFKbXZpSDR4T01vOS9ZVmN6Qnh1OUQ4OXZuVjR4ZFozU1FtN3pS?=
 =?utf-8?B?cmdwWTdEYTF6citCbWVNV3ZTNXVIQ3EvTWQxMWFHMllhallUTUZ0TmN5T0I3?=
 =?utf-8?B?bjNNbEJtYnlOcDRCQXhheVlyMkxEYmxiYW9wQkd4d2xOZUhIR012cGF2YTB3?=
 =?utf-8?Q?yNNlUnWjue4irONQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89618FC1722F594CBCF8C913E5B89D27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WHdjIurtM6hPEu4ovEsAU/HUtsCT867nb7sfy3e4TOnGZJlD45b2Zc3c1nXvv4/AG/8scZj7R21wv588ZX4c8xP/dj72Etuz48ppDV3phr0zx4GBvsGVUUHxKbQc3M1SzCapKFIEjIvJCoId1jJg1opyQ1TfHHjFuZIE3ydssj7vIekldxYQz0wWN4QL3L2xaRv+wKRfQs0mvlwx+pgO5VnGPvpdndGPnuU0jKBQd7yyHzwm9qH58kEjwqLHtOsRTDWYPrmMd/qXZFYwkNRJEHYCUGacLWCP4rQYh7wjgdQMxdztGtE/h3AFSteA7ZJnX1c/MeWhu7Ur4WQOC/D18g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f121674b-d166-4dbb-910b-08de9a4c0d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:34:16.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHeKkyy6D7wST5qukzEsE0y2PSxRO3X5t6GBB2P+HFYGtEzyCw39T6LEQIapHs4mUE0ovAh9y+OALXQhfJs0vJ2Uak076FOWSYzjmO9EIIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE4OjA5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gUmV0
cmlldmUgdGhlIG1vZHVsZSdzIGhhbmRvZmYgdmVyc2lvbiBmcm9tIFREWCBnbG9iYWwgbWV0YWRh
dGEgYW5kIGFkZCBhbg0KPiB1cGRhdGUgc3RlcCB0byBzaHV0IGRvd24gdGhlIG1vZHVsZS4gTW9k
dWxlIHNodXRkb3duIGhhcyBnbG9iYWwgZWZmZWN0LCBzbw0KPiBpdCBvbmx5IG5lZWRzIHRvIHJ1
biBvbiBvbmUgQ1BVLg0KDQpTdXJlLg0K
