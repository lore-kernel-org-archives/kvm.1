Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309F4A8A20;
	Wed,  2 Sep 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366150; cv=fail; b=ovWaGEK25VlPmhf2Te7bhlBNzi83dYGrB7T4ZjkUPQkpfM1D2JmAxp78ZmW4vzQH63kcMCYUtR1B4HATpLkq7GndWB0Ld5S9pMJRrXEeqQuB8JLjxkp5jt5ugUPe98hXrfaeX3onGtqLLV5Zv8xEfpl7jDDNkz12IMbov81vCvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366150; c=relaxed/simple;
	bh=FiT/fTw52v81OIkumWNZ1gCn2OsbPS97lGQErATHBuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+cRZ4G94wIShz3Bh6MVB97QJIPDCcaMYKXysJ7Q0/bMdHvF3tW4nZD/eCAt4HocfQMA631j2/I0q8bMNev7E1UkKmI8ZWhLO2Xal1HhZ//my4KYVk56OgTfcMSymO9C++gvF6WFhnJShAwIrxbe79W3CSWTQoY1G2DuOl2bbmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8RAI9/m; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8RAI9/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788366148; x=1819902148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FiT/fTw52v81OIkumWNZ1gCn2OsbPS97lGQErATHBuo=;
  b=n8RAI9/mTVTArRvM80PRNOpTkcymZyV92Qt+AqBwV8bO5f3fYxc081He
   7CvMHbeQVI7aQ1MNOm1lJ30ut32xbqQBKYiPx0mPgwMY8d2rjU8jH9Ken
   TSZB9HnNmoV3naxZl8BmjsYmIMdPIA58WJThLOBFOwxyQMZ3T//RoOI+C
   sXppOSi4eJkEmLJ0Py27iCQf7CEJrLbKtmudEMrHVXWOcmFtWaO1Cixof
   xB4W0hax7p6exGjkZx2W/46k3ThWi8+wtJN1RUEaG5M2185q5rs80Tco4
   XaT/zn7tsL/xve7rDAINcxKaf6BOFucSDfR4FXWc09KXqxgrDfq2G2NqO
   A==;
X-CSE-ConnectionGUID: yI62us5vQfWlDaZDq8I5Sw==
X-CSE-MsgGUID: 5VspBADxQLWwyNdSgNtJog==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92698471"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92698471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:22:28 -0700
X-CSE-ConnectionGUID: HalYA8aCT3S31FodmcQjwg==
X-CSE-MsgGUID: /niGYpSuSmSweSKsLM4Cjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263283351"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:22:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:22:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:22:27 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VweGRE+r58d+hrcnrH4Bh/hmq0gufiTA/Xb0CPxfpM7bHU6ZX95LlIZjxmVeAgFM2TrAzzxB+fGQAMhmO1c+yYkrsUgnAzvX5qpqSgRjdxYjRDLippMHz8HszfVUT8LlQ5WTdIivdCUxlPFJeIyqDO2VVrxr81HR/VG1ZbHNIafVkSQMVhLZHZQqdSMosEvsaqIiObRH84ldjEymkc+1Cz4J+fONMcYoK8llrd58bfk2fZAgetSxchr5FJh56mHyI0qiB8BZCyY8b/fyH6D5khefy9YbSvDc3tsvyRusoe44FbyfZ2O27Sq7vbtghIS1SKcpL8KraT2giqEdxA6eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiT/fTw52v81OIkumWNZ1gCn2OsbPS97lGQErATHBuo=;
 b=ZBjUE1JHxePUpADJbAXl85qLIa/7Q+J0iI/C1ecUSE33P1o0HWsb5hHYHYQowSy7JvVc0sQ7DTec7izobqBHdSHT6xT8C1WbyzGo2bWu+jLtaLGmHQwm/qN3FSz4VrFilZ6/KFQgXuRPfTDk3IymKZCmQ+cM7ZNdbSSX51Y/kLAK5NxMp/bqrYEaUek9vCmeflVioD/nOpuCpPkcqeyrJoYsY3Z+95X/jPa7OyxMj01DfI5ZysLYrG11g8+f4+09gvjAvRn3bPusRY4GjhjIWQRXwbCKQWwqMvhaUssvJqhmoyEyRP44XDfUZIwXmo4NpW/iZbQQ+HMSL3NqoxPycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:22:20 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:22:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAAE6YAgAAAyAA=
Date: Wed, 2 Sep 2026 16:22:20 +0000
Message-ID: <249dcccf2353181f595547d19a07232fded71023.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
	 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
In-Reply-To: <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: cf686f93-cd6c-4b2c-72b6-08df090e5cd6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|38070700021|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: 7Huja3WbQapZ8ztLvE+KC9kX/6qTMaax5QMl6YYWoMoXMiRQQMDvWlouqL77f2I0SFhu2o1/nSKY6/bTBnZx813YAiBVbWhz3S3WAdRG1xqBkYKPFLwlvbXcVpydR6UOGYvYKpOlt7XeTQ0i2SWFsmI/woZjFSZYwMi4KyB+wmpXh0Wjb2Tn1JZ1vbd6xXYoFJuJbonee8UViQ5uacKuNxN2JI2lddLQ1ttSDeH0+/d7Mg8v1ctaUwx1Ecohmp5H7o+eZPBfxVziA21BB62MpHRqvoTTFQ3OkwAAddrgriTUvqDd4dSzgkeJD2hvu/7gsdPPDlvuUuv7kVQnTBorQOmJ9vdWhbKGrxGuLIgZZdqNrrK/YBBjG+G5CVYEhsSIVPO5QQAFBifTdgy/U72sL9RE+Ql+Skk8tKf0dkrGDzJjSV0YnQP543xT9ffM4e8ornDZAddFducoJksSxiPf9o5o9t7UcarZ6b64ZsJ+3Xp6LSC2DYmM+PKIdVu1JUiSP8Qxg8ulWcEMjCQHMb0XxBvRfy7rJG0VrqJqYshuJyIUy8fTFj1ucd05gj3aTb41Gi2iCqsMBycWZgHWr3VqKYYKDpYTnIqcoJnlW0F4+CKGu6nSAqDTPdTDWTO+2QEHGLAqwpTEqQy7EcJfMo7f+zptQhb+TSZVm13GgXAiFDZYhlxji+RdhmmfFNdmm3zze7vFprSeX8J3/Nq/s4xiTxYhrkCr6M1KLjrczjHhAo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(38070700021)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWI5Y043bEhkMEx1dlN4WHYwNHhlRVlJZHNHQ2FhMmxGYkVYTDNqalN2Vmdi?=
 =?utf-8?B?UXB4aHNoL05EY2Y0UlV5ZENvY3VsYnh0MTJDcUZReERnZndQZTFRTVVUaGRn?=
 =?utf-8?B?WEhIWlRVelIxeXlHcTZRRWZPeTdlN2lTSUFaY21rZnJkTVZLQWNGODlodVJP?=
 =?utf-8?B?YmJ0Ulc5MEdZQVE0elFMNkFGSDluQ01ESElFTWErMFFmM1cvOFh0VXFpS00v?=
 =?utf-8?B?VWpENFhKTmFCRXJaRWt6Qmt6R1NtT2UvZlhETUlDbmRqbVVwSnAzWjZXekVx?=
 =?utf-8?B?amhvTFYyUTRXQlRteXc0VXVZN0V1SERldStmQUJ4QUhxcUdjUE9QTnE2cWli?=
 =?utf-8?B?L2s0dTZsK01jT3dyRk9aTmdnRWUwZG1HNnN3ME9DVS9uMktOL3VCenhCaGdT?=
 =?utf-8?B?UTE5ZEM3VlRTTHc5Q1MrS2tHQjEwUk1hZGVpT1Q1c0FmUmN4Sk9lNmFhMzlN?=
 =?utf-8?B?dUdkUUNVa0JpRHpuY0J3b1MvYnZqbktsVmxvM3c1b1FBZmNheWMrWUdsUWxF?=
 =?utf-8?B?WFhTTHhIbG5QYnEyNXBIUVo1VVpWdnpRV0g1WXdRSkxiQVJmeERUUXVOWmtn?=
 =?utf-8?B?UkpneFRXQnhRaTZvcnFZMi9OY003YVJNSFVDTHBINC9ER0t2eFlON0JSdVpk?=
 =?utf-8?B?WUdLM3dFbjNFVlBtckkrSGxmempYVFFjb3JsZG5ieERYQklPQzZQOVRZUi9x?=
 =?utf-8?B?NFlHNTZ3SUZJbWRseHhNY0Jqc3VqdGRHajdkc09YaXhjOXBCeVlmRm5QWDNL?=
 =?utf-8?B?dXFnS1A3RlhUZkVVWmlpS0VnRVZrVzBDVGZVQXRBRlRUZ1hvak0zbERuNjFh?=
 =?utf-8?B?YitNREx1MUo4bG5OTWhocDJsZEtIclRZblRRUTlLQ1JNNG82SHppU2pjY0xw?=
 =?utf-8?B?TU9LVGRtdkVsckxtTk1UcnRITk1HZ1JXWVlmK3JEbTBsa3FLWkdZMUVoZ0pX?=
 =?utf-8?B?cXJVN0lKT01lUHVCbEl1SnozNGF5R2tqN1k0QnN3TTYvM1VyWFBSUXY0UTJI?=
 =?utf-8?B?Z3cwOHNmUkR4YmFGTVVVYSs0ZlhwUktxU0pPWGtibHlEUXQwUEptTzRaV2cw?=
 =?utf-8?B?TGZ3Vi9NMUh3Qk01ckdyM2QvaFRyaENWcWNNLzArVlZhRXk0RXRTY2Fnc2xJ?=
 =?utf-8?B?NFNyWVREZjVZcEhFTHpodVN3M1lGU01Xd29mcmNBYTY3Z1UrL2RjaWJqN0tS?=
 =?utf-8?B?VHFmSVFyc0lGcGxEK2pqMkwyZDY3M3BBblNsTW90ZDhLMzAwU3FLWDZpNzU4?=
 =?utf-8?B?eHUzTGFoalZUaDJzcmlERUtZT0JwMmRJeGhkNWp2STU4dWNSZSt0YVZzVVdL?=
 =?utf-8?B?NXpxWVN5NTB1TlJxajgreVVkN1pkYnIxSE81d1hDQTM5QjJUYktHQ1d2NzVz?=
 =?utf-8?B?WjJ3a3czNjYvSEZibG9YTGN2d0VLRU5CTmJ4bjFUcUxLQW9hQ2hKUGxIdXRi?=
 =?utf-8?B?RjNFZkVBMW03LzFjeXBDSEhVNmZSMGJRVUw4OUVPdHdVVExCRmlFellLS3R0?=
 =?utf-8?B?aGh3bFE1OUcvaTlPd2tDMjhFUTJXM21ueGFJcDVyc09FY2RUb1MxdWJCVVpp?=
 =?utf-8?B?VkRBSVByRkVJT2dhMmQzenM4dWFpckFCYldkR3FEbk9FUG1weFlOZzRodE5a?=
 =?utf-8?B?SHhGYjh0VlN5NWRkL29CMWlGWjEvY2ptTVFPblp2cFBlMzhkL3VJQ2ZRRC96?=
 =?utf-8?B?c21tckpKSUljTGVCNU93MXNTSE5tSFZiSHQ1ZE9wZjVXT3JPb0dyS3BVaUsv?=
 =?utf-8?B?WEpWdEpFWG1lMlJyeEhra1MvcjdSek9mUjdHOTJTc0F0aThya2JtZE1uTzhx?=
 =?utf-8?B?VkJkVTlyRzY2QW9YOFMzdktFQlVMN2llUEtWc21Kd056UGE0K3BzakZWNUhV?=
 =?utf-8?B?am9hWW1BaGRZVDZkTUJlQWp5cXpPY2h2SHRzd0t3RS9RRGxuSXl3YTlCNmsr?=
 =?utf-8?B?Y3ViNWwzbmM0TUpDSXp6NFpiNzZiOXJHTEFYWndkM3lQaVh2Y2R5c2dUTTVF?=
 =?utf-8?B?R0lqbjRaM0ZFSmFRdGtFUEljNjVscElRODZVNnNiMFlaV2MwQ01FUVl0cU1E?=
 =?utf-8?B?RFNWU0wxL2UyaGhscDRoWDJrRkFRTEsrbStpR3M4bU81dGlFRnQyWTBFTnhF?=
 =?utf-8?B?QURvS3FHeC85dVFXNERVQjRIcllnaWpiZUc3MExBd2JzSUdhZzkxUUlTZmFG?=
 =?utf-8?B?SzUwMW41OFh6UXo5aENRUXNTY1h0UG5zQkcwc3d5aFQyQnBOOWNVUHl5L0Jo?=
 =?utf-8?B?d3A1eFBlOGI4YzlGeXJUYnE3elZnMWdyQXNaSUkvQXB1QmQ0ckVNNjcyTkkx?=
 =?utf-8?B?N25KbDBrL21jN0ZwYjkwQlZ2TE5oLzQ2aUFaN25VSDBMczdkUXNJdHhRdy9v?=
 =?utf-8?Q?N8VpQCOlEQH0YCtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F76043F60E7B4945B1E68D3FA693976A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IrgFS8nKV2bwvbhBAHzA/3usJk8R3tSUeQdQbDs+NJK8MgK/8E2CKGfsrvctnDUJFwChPniFaRX0tk1uQR+B+GBMWICGRnlX9aKMCy33hHaZrAnwhhhllWaVstm8N5ELYDlNXjjNbLx9o9kJTrE8JS6b6THLc/YsjcrUOwP2+JKHj1Q7iPQAr4SmwANjKgrbNs7ljQZJkn9ayopGi86ScdGbonUcTRusq/2XOJRz7D4yEm1+jz7AJN9V92VtdxIByGdMvD/f15gleHxw7JM+WPRzODv3sfbgQtpLpjgdtYTPU5eEEUzmUfjVFEjE41ouJIKBQEhfCPfywQs6zoKE9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf686f93-cd6c-4b2c-72b6-08df090e5cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:22:20.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pek765X4jxZzHt/4jfzBvedOzrykhCFOlspelOow8pl16dFNu97Hl7tAKVP6iEu9QIz20Hvstg60qa3/i8lzE/bHrv+O9HrKaFzMvQpUW6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDAwOjE5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
SSBzZWUuIFlvdSBhZGRlZCBwYXRjaCAyIGJlY2F1c2Ugd2l0aG91dCBpdCBRRU1VIGJyZWFrcy4g
V2hpbGUgZm9yDQo+ID4gRVNUL1RNMi9TREJHL1hUUFIvRENBLCBRRU1VIGRvZXNuJ3QgYnJlYWsg
YWZ0ZXIgdGhleSBhcmUgdHVybmVkIHRvDQo+ID4gbm9uLWNvbmZpZ3VyYWJsZS4gUUVNVSBjYW5u
b3QgcmVwcmVzZW50IGFsbCB0aGUgdXNlcnNwYWNlIFZNTS4gSXQgc3RpbGwgaGFzDQo+ID4gdGhl
IHBvdGVudGlhbCB0byBicmVha3Mgb3RoZXIgdXNlcnNwYWNlIFZNTXMuDQo+IA0KPiBJIHRoaW5r
IHRoZSByaXNrIGlzIHByZXR0eSBsb3cuDQo+IEkgYW0gbm90IHN1cmUgaWYgU2VhbiBjb3VsZCBw
cm92aWRlIHNvbWUgaW5zaWdodCBhYm91dCB0aGlzIGluIGdvb2dsZSdzDQo+IHVzZXJzcGFjZSBW
TU0uDQoNCkNhbid0IHdlIGZpeCB0aGUgaXNzdWUgaWYgd2UgYXJlIHdyb25nPw0K
