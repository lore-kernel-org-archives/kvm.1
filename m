Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC63B19C6;
	Thu,  1 Oct 2026 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895774; cv=fail; b=L1BS2YZaYlK1fzqfDsysB5iP3ZH+ebzy0yVOM55jXY7QZpG5PcNSwX8s1Ig7ZL2/mvKfCaLAZwTdQUNj8VAUCjxF5KyQDXmXVpVl/SxbVQ9yppObTqYPLD+HL5qVV1VBlwx4s13BI5eFFnuBowoMGFspaKC5HIXx6EgOOdaLmDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895774; c=relaxed/simple;
	bh=2Z379DPG3ORdujcvg2s6yvODiuXFui3LXGeWMaVXJJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ov+L/iNYui+gakMpno8JbnW+oqM/CHjVyqR1l7RXbgpNxoCXwtMAV0Ln5J8qfu0Fbum6zHvRY/6O+knMAWI3K1bPUTX2fue2V912vYuje85Xhg00gnsWy36JUYZeWPVhTxXuQY9fCOXWFytDm2wxhC8lqNeJp0Ady1l+KZCwz6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdtrRHPq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdtrRHPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790895770; x=1822431770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Z379DPG3ORdujcvg2s6yvODiuXFui3LXGeWMaVXJJM=;
  b=LdtrRHPqISuPqGe+8tUiSQ6qa/4G4pt4V/GWH2oS/5b9EOpig1pcOrd9
   5a6fjQ8Tqe6VUGvBCZ19zpPaF+uVqmXqLt3cWQ5l2tNuebX/cUoHsWYl+
   xKx+qbEHydyykWE/s423cEgwdY2GD/ooISo19MMskfgMuJhW/tDDFDhQd
   6mSNw1RNt3iSkEoJEQdeVUuCMdToA9fIz4HWRaxB0G38JEMSgT3grjxOV
   MzAQucSZCJnmeBk9itk/WQI45aRHEQa0Eiz0qE4kJMBJwV9hF2t0PGX+j
   Q20V+rt7LnJigx0s5Xuncii+Lcc3eEL9Et6e0ZtNz3u+miuBWtmhLj5Kz
   A==;
X-CSE-ConnectionGUID: BAR/itowSAac7NsVq2F40Q==
X-CSE-MsgGUID: iDx3i82iQaa+7WJffW3OVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90527356"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90527356"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:02:48 -0700
X-CSE-ConnectionGUID: ZJ1F9d/DRpiRsNsE0hAfkw==
X-CSE-MsgGUID: IOxOX6qKSWefqSUL78VPbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="134028"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:02:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:02:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 16:02:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl0pty9svfcyjSh1o9YXOEG5NRbmD44ZhB9wNONi34gvJmj5VK2BPvoZd3nWOOpSoPer8rALCfc8/HMO/W8VDFu1lBPXnYMStww5/kHCQGsJJlhj11RJGsJ8xIOwO6Gvpj8rA1/aS5d+73mHtcOXpDMjN47R7e3B2/34boQD1Ic9w3LcT6vh+WmATqGN6JCwabOslKo21dsxLfGotOSdnIfaUyMfpq2xOxx4Gk8i1Sa7uWfw6UxXoqgh0iRztUJOHZewHaxWzgmyJJ7tJcufpOCGzEKZ9vDTbldFTHrpb78JY8SMxRSU+w0OI23HEemq5suCkeaFz8bABXgAj5Yawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z379DPG3ORdujcvg2s6yvODiuXFui3LXGeWMaVXJJM=;
 b=gFOKT2XHuEmdupJSu0r4Zg4s71LfYmyuFbH5Nv9LLkdb+kWSzsw7Lcc8lp/XDajP1yFEwAMkaPr6lYOmU1k71d68R3X61kx4yxQE9E8YUxBaHzo2oSFPMjnJOOApTulolFlRnjSvNmsEjog8HxSIKPNr+JP6/gKD8HdaW8v3vGp1JzJMgeHnpXIRkzHb4N42sz3jKpw32YzRB8sGitKKRxxm2VWKtiNTdHf+M1qL68tOZEwGolIbQtDVmF67g+bJTT1Z4LDL9c/mI4BZgS5vhREbuh4UEI6U8/XFllcqUq1aOfsmOM1S+tbDpH2GAoV4BvRqwUp0shvbVvY5dHr+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 23:02:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 23:02:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Topic: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Index: AQHdTykCb/i0a5FVc0eZkBiALVPvabbpU5eA
Date: Thu, 1 Oct 2026 23:02:40 +0000
Message-ID: <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090808.15484-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928090808.15484-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB8121:EE_
x-ms-office365-filtering-correlation-id: 12be7608-11be-4393-770d-08df20101834
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|38070700021|6133799003|56012099006|10067099003|4143699003|5023799004|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: BejNYfhkD+LdW7M9XwyJOTxhg5ilbyFhTvz0LyL/+4sfTOnV60PTKcUlCw3oWNHaLxnh0zI3Mlj230nfDi3NlfAr8iuhdpaCzTKhS5oabbyKQ7yKzAvcgLiUFjiFIu1aQ3S4FeLJrVSD1PvXfh42RjrGDcaxOjauV4GXuFSnF0fjDlTJMAGw6vgR/WiqOWDLjQ2ToZzbRRXZm0/rRRRTcwTk+dEbi1wORfO0cxAGnRf6/p7fb203WjDYAkQ7mDyiEZ6nRHVHBUjJIa2DUQ2t3HVbcbkNuecHPnpRpfc2AfJbziJX/PoyufS+d4UlUL8+for90TjKTh3FmS07aKjZ4P00Jw5QxV8kPHIYEfA+9TCjKFibjeV6Yynor1lx+5bzUx44WbiwDJ5KvOMjdffUkVKPNTfqPVZLMtWXdeabCom1u8LnHJ8HWn3E5MtbTW7pabp0EwAOG9iQuhAibtvDFz8p0xo3y022QT1q1L5W1oZuBvUdAtttDJgWBs8hOvbpzUJmoVNLNJU81rEQGT92WE1cLdRDLS45gEjw7pFl0XGTE5SuwmT9BqkrTYphLkW/Ql3aSDNZ6J4Ua+B5/vVZ8zWVXujPWEz+4gu0ZfUgp6il4ISn1Nf7ftBVvf3BxQODPo7FxFvAd2Pt9h1VBaD29NvEflrcXbgR87ZmXot+z8GySMaJq/82JygUv9sjxBSQJpEKy9baI9mrBjP1JVxhPzBPGWXcMMq6Y5EU59+reM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vy83c1JuWFRnWlZWbms3UEVzNW1tNWE1SVA4OXRIOFNybm1adTkyQW5VMitS?=
 =?utf-8?B?UFZFcHh0RFdiWkh1Ly85eVcyWlBoSzd2Z3AzRVhtYld5TVlzcGlMNi9SaGZp?=
 =?utf-8?B?NmJBeDByZFdWMWRJVDl0VVAxQUhEaHlmTElNUXlFVWMvd1VLdWxtNXF5bkNY?=
 =?utf-8?B?VnFkVmZtUUE4cVVEbmtlbUdJMWUwMzEwNG9FTCtRbnFwTUdzVnRyYmtCWExp?=
 =?utf-8?B?WWdJMitGZzV6aW5OWko1WFVTYnhTWjZnL1pzbUN1M1RPMWlkY1JJK2tERk9I?=
 =?utf-8?B?OUlZc3pYU3I1OG81VThzSTRocWwwWTBrUFhxL0J2SjI3NHhPMVkwUEhMRWFC?=
 =?utf-8?B?QkIyKzBQVElQWXlUQlN5SkJRVUZiNXRoQU1JZEpzZnNqVDVSUG1jaUdPM2Mz?=
 =?utf-8?B?TGdSa2lBMnFhT0xJenBhL24ycEdqMG5mTERYVDg0NUFjbXRIVE1HVDJDNjFv?=
 =?utf-8?B?WTJ5dGxWcXRRaHYva3NXaC9BaFlqM3JnQ3hpY3RuZmNMdTFrQ0kwb3N0Kzdt?=
 =?utf-8?B?QkprbkozV3lhY3l2dDhkajErSXdwRGdyV3F6YVphcmkrME5pV1dyaXJjWE81?=
 =?utf-8?B?am5jVGgwMjh4YTBQOEFmSG5QYWxxOTFUeGplNVczV3ZhOEhJOHBZcWhNMkZR?=
 =?utf-8?B?L1QzYnc1ZDUyRGRtOXQ0Zy84ZzBJSDRPdEhNVkR0dklVR045Zk1sTkJlWEhT?=
 =?utf-8?B?MWcyajBYckJMTUZGQjZ2WkxneXZ4WWhHY3FoTXlQTmd6aFVDWnMrNTFWOFlM?=
 =?utf-8?B?MDBMQlQ3WjY4d3dESERuL0grZlhWcnRjY2FHZzJscXdsQllFdS82ZXkvb1lT?=
 =?utf-8?B?b055QUd3RkFWTkJaZUtMN3dLV2d5WlpsN21sM2R2MWdGYmJIeXlsY3E0bDZp?=
 =?utf-8?B?WE0rNFJZWWhmUjkzb1JSOFh3NDZ6L0R4b3E2VlloeXhpd093TkdIWmJYc3hw?=
 =?utf-8?B?cmM2K2JvNmlWZ2UrdTZIbDJLL3Z1N1ZuRExiT2JsN3liVmxkS0NmbWRvcmpD?=
 =?utf-8?B?MlV1REROT1gya3FxZ2NoL3NudGwrMkZjU2c1d1MvNjFucllGOHBJRFlURjZK?=
 =?utf-8?B?TWNtcHhadXpnTFB2Ty9WOHpxRzdBLzNjQ0d3ek04bFFNM0d3cyt1ZEFSei9X?=
 =?utf-8?B?VUdLQmk1eTk2OEppMXVEUE1tNm9MQm9hckhuWVBGbWNaeEdLZ0lDWHlSMGJF?=
 =?utf-8?B?dzRKMnRLN2hSVExIQVU4T0x4eW0xblRNWDArNG15Q3JYTHo0SDRCVWZKWWxa?=
 =?utf-8?B?c3dSNmpOZ09rVm8yZlFxbzBQdmo2S2V2KzJQMTlsSnZRTTFqYmRUM0FWRy9S?=
 =?utf-8?B?Y3JRUWFWY3N2dFlmN3BRVStvcWh5T2hPZTZzQWQ2bjVnZFFGM0t1c0JHbUFa?=
 =?utf-8?B?dWRSRVEvNUdXc3B3NVNaQkRMV0pCcHJKZmRPOW4zSUdTNGJJRjRMMmRtNVVt?=
 =?utf-8?B?c1JNUjA3Ujc3bk54UHovVGE2dnJaM0l6dkxyalViZFpoR2tFYm5HRXJSTlB4?=
 =?utf-8?B?c2lacldUVy9WbjR3bjRmRUw1NzBFbndJTCtzSEV4SWIzNTVKdTBwamlFYmdz?=
 =?utf-8?B?TUNHK3NsYVNjaUpKMUo2Qk5laUl1YlJhaFRWRFBHaGY1cXNxTlgvSHBtZWw0?=
 =?utf-8?B?MzNRRWpJa1JZR3hOdWJ5WDYzNnR6WTd6WnBqQ1p2OTY0SWx5eE9TamlMUm81?=
 =?utf-8?B?R0RzU1NUNlBmM1NoQXo1OEpRc2llWXRiajJWVURoL0EyMGRoUVljdHB5NDVn?=
 =?utf-8?B?cEFiWVhTTjVwRmprU3JrSXVIUlFkSHlvWFdpUUNUcThINHd6WnNZRk5HKzlH?=
 =?utf-8?B?dVJ4TTRzcWEzZjFOYjVyKzg5WTJSdEhwRjI5Q2QwQmM4Z0czRWVFOFdKc2ln?=
 =?utf-8?B?dE8weGlvTk9yZHhHeEZVNDV0VzZpM1J6cUx5YjBoSllNZlJQd2Jmc1JJMmNs?=
 =?utf-8?B?VXN3SjhVNE1UOUF3Qkt0U1JZRm1NNkcyWnk4elhnUHp1NWt3YlJaTE5SZmI4?=
 =?utf-8?B?MXhGOWpLTksyS2xCMWtzV2llTkpOcTU0aFhXUnlUUlpla0t0Z3d5N29OcU1Z?=
 =?utf-8?B?MjFvMmtBZmlWK0pFSlpVNTB6aERDaVVGalVwbHYxOWtwVWc4UEE0bTFaRHlm?=
 =?utf-8?B?VHBoMWk2TUlRQ3ZzdEh6R1dLeFlFaWJDakI0bVZuWXlzcjB3VU5PZVBnYWxq?=
 =?utf-8?B?anlYelZ3UFY0cDhJSFhIWXp4U2ExcVdIaVdZTTBCNHovMWxWYm5ZZGNuQXU4?=
 =?utf-8?B?Vm9uZDdVbkNjQVoyMHIxMzlQUnMraDNid1VyQ3VaZU5WZXE3T21NN1BrVURC?=
 =?utf-8?B?U3dOYzNYU1g5ZG1EdkdCTkgrTU9zNWdPUWFjYmNnWjNlNVk5b3lNWCtrU2R2?=
 =?utf-8?Q?myiqY6R3wZ6zBg6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9D2B4F00D2A3A469EFE803E265B92FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lTOtAzjKLy+h6HsXqNvnOtmcKxD7ZJ6Bg1W8zVuSr17t/EXZZOx2blwepUFEb0glPGHwttaHmAEkDYUOaoYJG5TKIipAutlVjWGNz1ez7TWbrMSZJ2plqcfjGJC6Aq2paEfO+hEJMjMYdMTbmO8wal862RvNUJV5cLgIJduNl4534e/ILxfakwRccZdQ1IjbYkdU2qfdx3bIJhI5/O0wpsfPDUk2C+GIqq+7J6m+tu8FuHUdhPAoDbefHERQ8swupTAWQjlFDvIlfs7Nq5ZsdhLDvq3jGMQ72XM9LjG1ANXNyohNSeuLfpzNytBLW0l2uQepJqOrQz08YVcpATNyPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12be7608-11be-4393-770d-08df20101834
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:02:40.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJ6cvUZkHizaySToaHrmopqB0svwgEFTo55Ri7IMnQ5JQjj844FrQj4uRWUkRFm0bWD1SkvPZMTvjy0/0HWPcR+lydbeLe3WNL3qASYJJMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8121
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjA4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgdXNlcyBQQU1UIHRvIHRyYWNrIG1ldGFkYXRhIGZvciBldmVyeSBwaHlzaWNh
bCBwYWdlICh3aXRoaW4NCj4gVERNUikgYWNyb3NzIHRocmVlIGxldmVsczogMUdCLCAyTUIsIGFu
ZCA0S0IuIFRoZSBWTU0gaXMgcmVzcG9uc2libGUgZm9yDQo+IHByb3ZpZGluZyBiYWNraW5nIHBh
Z2VzIGZvciB0aGUgUEFNVC4gV2l0aG91dCBEeW5hbWljIFBBTVQgKERQQU1UKSwgYWxsDQo+IFBB
TVQgYmFja2luZyBwYWdlcyBhcmUgYWxsb2NhdGVkIHN0YXRpY2FsbHkgYXQgc3lzdGVtIGJvb3Qg
dGltZS4gV2l0aCBEUEFNVA0KPiBlbmFibGVkLCBQQU1UIGJhY2tpbmcgcGFnZXMgdHJhY2tpbmcg
cGh5c2ljYWwgcGFnZXMgYXQgdGhlIDRLQiBsZXZlbA0KPiAocmVmZXJyZWQgdG8gYXMgRFBBTVQg
cGFnZXMpIGFyZSBkeW5hbWljYWxseSBpbnN0YWxsZWQgYW5kIHVuaW5zdGFsbGVkIGF0DQo+IHJ1
bnRpbWUuDQo+IA0KPiBDdXJyZW50bHksIHRoZSBWTU0gaW52b2tlcyB0ZHhfcGFtdF9nZXQoKS90
ZHhfcGFtdF9wdXQoKSB0byBpbnN0YWxsIGFuZA0KPiB1bmluc3RhbGwgRFBBTVQgcGFnZXMgdW5k
ZXIgdGhlIGFzc3VtcHRpb24gdGhhdCBhbGwgcGh5c2ljYWwgcGFnZXMgYXJlDQo+IHRyYWNrZWQg
YXQgNEtCIGxldmVsLiAgSG93ZXZlciwgd2hlbiBhIGd1ZXN0IHBhZ2UgaXMgbWFwcGVkIGFzIGEg
aHVnZSBwYWdlDQo+IGluIHRoZSBTLUVQVCwgdGhlIFREWCBtb2R1bGUgdHJhY2tzIGl0IGRpcmVj
dGx5IGF0IHRoZSBodWdlIHBhZ2UgbGV2ZWwsDQo+IG1lYW5pbmcgaW5zdGFsbGF0aW9uIGFuZCB1
bmluc3RhbGxhdGlvbiBvZiBEUEFNVCBwYWdlcyBmb3IgaHVnZSBwYWdlcyBpcw0KPiBuZWl0aGVy
IG5lZWRlZCBub3IgYXBwbGljYWJsZS4NCj4gDQo+IEFkZCBhICJsZXZlbCIgcGFyYW1ldGVyIHRv
IHRkeF9wYW10X2dldCgpL3RkeF9wYW10X3B1dCgpIHNvIHRoZSBoZWxwZXJzDQo+IGNhbiBza2lw
IERQQU1UIHBhZ2UgaW5zdGFsbGF0aW9uIGFuZCB1bmluc3RhbGxhdGlvbiBmb3IgaHVnZSBwYWdl
cy4NCg0KSSBndWVzcyB0aGlzIG1lYW5zIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRvIGdldC9wdXQg
YXQgdGhlIHJpZ2h0IGxldmVsIHRoYXQgdGhlDQpURFggbW9kdWxlIGlzIHVzaW5nIGl0IGFzLiBG
b3IgZXhhbXBsZSBpbiB0aGlzIGltcGxlbWVudGF0aW9uLCBpZiBhIGh1Z2UgcGFnZQ0KZ2V0cyBk
ZW1vdGVkLCB3ZSBjYW4ndCBjYWxsIHRoZW0gbGlrZSB0aGlzOg0KMS4gdGR4X3BhbXRfZ2V0KGh1
Z2VfcGZuLCBQR19MRVZFTF8yTUIpDQoyLiBkZW1vdGUoaHVnZV9wZm4pDQozLiB0ZHhfcGFtdF9w
dXQoaHVnZV9wZm4sIFBHX0xFVkVMXzJNQikNCg0KU28gaXQgaXMgdXAgdG8gdGhlIGNhbGxlciB0
byByZWFzb24gYWJvdXQgd2hhdCB0aGUgbWFwcGluZyBsZXZlbCBpcy4NCg0KV2hpY2ggbWFrZXMg
bWUgd29uZGVyIHdoYXQgaXMgdGhlIHBvaW50IG9mIHBhc3NpbmcgbGV2ZWw/IFRoZSBjYWxsZXIg
aGFzIHRvDQpyZWFzb24gYWJvdXQgd2hhdCBsZXZlbCB0aGUgVERYIG1vZHVsZSBpcyB1c2luZyB0
aGUgbWVtb3J5IGF0LiBUaGUNCnBhbXRfZ2V0L3B1dCgpIGhhdmUgdG8gdGFrZSB0aGVpciBiZXN0
IGd1ZXNzIGF0IHRoZSBhbWJpZ3VpdHkuIEZvciBleGFtcGxlIGxpbmUNCjMgYWJvdmUgY291bGQg
YWN0dWFsbHkgZnJlZSB0aGUgUEFNVCwgYnV0IGl0IGNhbid0IGtub3cgdG8gZG8gdGhhdC4gVW5s
ZXNzIHdlDQphZGRlZCBzb21lIGludGVybmFsIHRyYWNraW5nLCBidXQgaXQgc2VlbXMgdG9vIG11
Y2guDQoNClRoZXJlIGFyZSBvbmx5IHRocmVlIHBsYWNlcyB3aGVyZSBhIG5vbi00S0IgbGV2ZWwg
aXMgcGFzc2VkIHRvIGdldC9wdXQuIFdlIGNvdWxkDQphbHRlcm5hdGl2ZWx5IGRyb3AgdGhpcyBw
YXRjaCBhbmQgaGF2ZSBLVk0gZGVjaWRlIHdoZXRoZXIgdG8gY2FsbCBnZXQvcHV0IG9yDQpub3Qu
IFNpbmNlIGl0IGlzIGFjdHVhbGx5IHRoZSBvbmx5IHRoaW5nIHRoYXQga25vd3MgdGhlIHJpZ2h0
IHBhZ2Ugc2l6ZS4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCj4gDQo+IFREIGNvbnRyb2wgcGFn
ZXMgKGluY2x1ZGluZyBTLUVQVCBwYWdlIHRhYmxlIHBhZ2VzKSBhcmUgbWFuYWdlZCBieSB0aGUg
VERYDQo+IG1vZHVsZSBhdCB0aGUgNEtCIGxldmVsLiBUaGVyZWZvcmUsIHBhc3MgUEdfTEVWRUxf
NEsgdG8NCj4gdGR4X3BhbXRfZ2V0KCkvdGR4X3BhbXRfcHV0KCkgZm9yIHRob3NlIHBhZ2VzLg0K
PiANCj4gVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiBlYXJsaWVyIHdvcmsgZnJvbSBLaXJ5bCBTaHV0
c2VtYXUuDQo+IFNpZ25lZC1vZmYtYnk6IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4N
Cj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaCAgfCAgNCArKy0tDQo+ICBhcmNo
L3g4Ni9rdm0vdm14L3RkeC5jICAgICAgfCAxNCArKysrKysrKystLS0tLQ0KPiAgYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jIHwgMTIgKysrKysrLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4g
aW5kZXggNDhlZmQzZWFjMzc1Li5lMjc5MGFjMmM1MjEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RkeC5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5oDQo+
IEBAIC0xMzUsOCArMTM1LDggQEAgc3RhdGljIGlubGluZSB2b2lkIHRkeF9pbml0X3BhbXRfY2Fj
aGUoc3RydWN0IHRkeF9wYW10X2NhY2hlICpjYWNoZSkNCj4gIA0KPiAgdm9pZCB0ZHhfZnJlZV9w
YW10X2NhY2hlKHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSAqY2FjaGUpOw0KPiAgaW50IHRkeF90b3B1
cF9wYW10X2NhY2hlKHN0cnVjdCB0ZHhfcGFtdF9jYWNoZSAqY2FjaGUsIHVuc2lnbmVkIGxvbmcg
bnBhZ2VzKTsNCj4gLWludCB0ZHhfcGFtdF9nZXQoa3ZtX3Bmbl90IHBmbiwgc3RydWN0IHRkeF9w
YW10X2NhY2hlICpjYWNoZSk7DQo+IC12b2lkIHRkeF9wYW10X3B1dChrdm1fcGZuX3QgcGZuKTsN
Cj4gK2ludCB0ZHhfcGFtdF9nZXQoa3ZtX3Bmbl90IHBmbiwgZW51bSBwZ19sZXZlbCBsZXZlbCwg
c3RydWN0IHRkeF9wYW10X2NhY2hlICpjYWNoZSk7DQo+ICt2b2lkIHRkeF9wYW10X3B1dChrdm1f
cGZuX3QgcGZuLCBlbnVtIHBnX2xldmVsIGxldmVsKTsNCj4gIA0KPiAgaW50IHRkeF9ndWVzdF9r
ZXlpZF9hbGxvYyh2b2lkKTsNCj4gIHUzMiB0ZHhfZ2V0X25yX2d1ZXN0X2tleWlkcyh2b2lkKTsN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMgYi9hcmNoL3g4Ni9rdm0vdm14
L3RkeC5jDQo+IGluZGV4IDFmMGRiYTMyMjY0MC4uNDEwYzE0OWJmNzc2IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMN
Cj4gQEAgLTE3MTAsMTQgKzE3MTAsMTggQEAgc3RhdGljIGludCB0ZHhfc2VwdF9tYXBfbm9ubGVh
Zl9zcHRlKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuLA0KPiAgCWlmICghc2VwdF9wdCkNCj4g
IAkJcmV0dXJuIC1FSU87DQo+ICANCj4gLQlyZXQgPSB0ZHhfcGFtdF9nZXQocGFnZV90b19wZm4o
c2VwdF9wdCksICZ0b190ZHgodmNwdSktPnBhbXRfY2FjaGUpOw0KPiArCS8qDQo+ICsJICogQW4g
Uy1FUFQgcGFnZSB0YWJsZSBwYWdlIGlzIHRyYWNrZWQgYnkgdGhlIFREWCBtb2R1bGUgYXQgNEtC
IGxldmVsLA0KPiArCSAqIHNvIHBhc3MgNEtCIGluc3RlYWQgb2YgdGhlIHRhcmdldCBTLUVQVCBs
ZXZlbC4NCj4gKwkgKi8NCj4gKwlyZXQgPSB0ZHhfcGFtdF9nZXQocGFnZV90b19wZm4oc2VwdF9w
dCksIFBHX0xFVkVMXzRLLCAmdG9fdGR4KHZjcHUpLT5wYW10X2NhY2hlKTsNCj4gIAlpZiAoS1ZN
X0JVR19PTihyZXQsIGt2bSkpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gIAllcnIgPSB0ZGhf
bWVtX3NlcHRfYWRkKCZ0b19rdm1fdGR4KGt2bSktPnRkLCBncGEsIGxldmVsLCBzZXB0X3B0LA0K
PiAgCQkJICAgICAgICZlbnRyeSwgJmxldmVsX3N0YXRlKTsNCj4gIAlpZiAoZXJyKQ0KPiAtCQl0
ZHhfcGFtdF9wdXQocGFnZV90b19wZm4oc2VwdF9wdCkpOw0KPiArCQl0ZHhfcGFtdF9wdXQocGFn
ZV90b19wZm4oc2VwdF9wdCksIFBHX0xFVkVMXzRLKTsNCj4gIA0KPiAgCWlmICh1bmxpa2VseSh0
ZHhfb3BlcmFuZF9idXN5KGVycikpKQ0KPiAgCQlyZXR1cm4gLUVCVVNZOw0KPiBAQCAtMTc0NSw3
ICsxNzQ5LDcgQEAgc3RhdGljIGludCB0ZHhfc2VwdF9tYXBfbGVhZl9zcHRlKHN0cnVjdCBrdm0g
Kmt2bSwgZ2ZuX3QgZ2ZuLCBlbnVtIHBnX2xldmVsIGxldmUNCj4gIA0KPiAgCVdBUk5fT05fT05D
RSgobmV3X3NwdGUgJiBWTVhfRVBUX1JXWF9NQVNLKSAhPSBWTVhfRVBUX1JXWF9NQVNLKTsNCj4g
IA0KPiAtCXJldCA9IHRkeF9wYW10X2dldChwZm4sICZ0b190ZHgodmNwdSktPnBhbXRfY2FjaGUp
Ow0KPiArCXJldCA9IHRkeF9wYW10X2dldChwZm4sIGxldmVsLCAmdG9fdGR4KHZjcHUpLT5wYW10
X2NhY2hlKTsNCj4gIAlpZiAoS1ZNX0JVR19PTihyZXQsIGt2bSkpDQo+ICAJCXJldHVybiByZXQ7
DQo+ICANCj4gQEAgLTE3NjcsNyArMTc3MSw3IEBAIHN0YXRpYyBpbnQgdGR4X3NlcHRfbWFwX2xl
YWZfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwgZW51bSBwZ19sZXZlbCBsZXZlDQo+
ICAJCXJldCA9IHRkeF9tZW1fcGFnZV9hZGQoa3ZtLCBnZm4sIGxldmVsLCBwZm4pOw0KPiAgDQo+
ICAJaWYgKHJldCkNCj4gLQkJdGR4X3BhbXRfcHV0KHBmbik7DQo+ICsJCXRkeF9wYW10X3B1dChw
Zm4sIGxldmVsKTsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IEBAIC0xODYyLDcgKzE4
NjYsNyBAQCBzdGF0aWMgaW50IHRkeF9zZXB0X3JlbW92ZV9sZWFmX3NwdGUoc3RydWN0IGt2bSAq
a3ZtLCBnZm5fdCBnZm4sDQo+ICAJCXJldHVybiAtRUlPOw0KPiAgDQo+ICAJdGR4X3F1aXJrX3Jl
c2V0X3BhZGRyKFBGTl9QSFlTKHBmbiksIFBBR0VfU0laRSk7DQo+IC0JdGR4X3BhbXRfcHV0KHBm
bik7DQo+ICsJdGR4X3BhbXRfcHV0KHBmbiwgbGV2ZWwpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiAgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggMzMyNTM4NjllMmZkLi40M2Y4MTNhZmM1YjEg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTIxMTIsMTQgKzIxMTIsMTQgQEAgc3RhdGlj
IHU2NCB0ZGhfcGh5bWVtX3BhbXRfcmVtb3ZlKGt2bV9wZm5fdCBwZm4sIHN0cnVjdCBwYWdlICoq
cGFtdF9wYWdlcykNCj4gIHN0YXRpYyBERUZJTkVfU1BJTkxPQ0soZHBhbXRfbG9jayk7DQo+ICAN
Cj4gIC8qIEJ1bXAgRFBBTVQgcmVmY291bnQgZm9yIHRoZSBnaXZlbiBwZm4gYW5kIGFsbG9jYXRl
IERQQU1UIGJhY2tpbmcgaWYgbmVlZGVkLiAqLw0KPiAtaW50IHRkeF9wYW10X2dldChrdm1fcGZu
X3QgcGZuLCBzdHJ1Y3QgdGR4X3BhbXRfY2FjaGUgKmNhY2hlKQ0KPiAraW50IHRkeF9wYW10X2dl
dChrdm1fcGZuX3QgcGZuLCBlbnVtIHBnX2xldmVsIGxldmVsLCBzdHJ1Y3QgdGR4X3BhbXRfY2Fj
aGUgKmNhY2hlKQ0KPiAgew0KPiAgCXN0cnVjdCBwYWdlICpwYW10X3BhZ2VzW1REWF9EUEFNVF9F
TlRSWV9QQUdFX0NOVF07DQo+ICAJYXRvbWljX3QgKmRwYW10X3JlZmNvdW50Ow0KPiAgCXU2NCB0
ZHhfc3RhdHVzOw0KPiAgCWludCByZXQ7DQo+ICANCj4gLQlpZiAoIXRkeF9zdXBwb3J0c19keW5h
bWljX3BhbXQoJnRkeF9zeXNpbmZvKSkNCj4gKwlpZiAoIXRkeF9zdXBwb3J0c19keW5hbWljX3Bh
bXQoJnRkeF9zeXNpbmZvKSB8fCBsZXZlbCAhPSBQR19MRVZFTF80SykNCj4gIAkJcmV0dXJuIDA7
DQo+ICANCj4gIAlyZXQgPSBhbGxvY19wYW10X2FycmF5KHBhbXRfcGFnZXMsIGNhY2hlKTsNCj4g
QEAgLTIxNTcsMTMgKzIxNTcsMTMgQEAgaW50IHRkeF9wYW10X2dldChrdm1fcGZuX3QgcGZuLCBz
dHJ1Y3QgdGR4X3BhbXRfY2FjaGUgKmNhY2hlKQ0KPiAgRVhQT1JUX1NZTUJPTF9GT1JfS1ZNKHRk
eF9wYW10X2dldCk7DQo+ICANCj4gIC8qIERyb3AgRFBBTVQgcmVmY291bnQgZm9yIHRoZSBnaXZl
biBwZm4gYW5kIGZyZWUgRFBBTVQgYmFja2luZyBpZiBuZWVkZWQuICovDQo+IC12b2lkIHRkeF9w
YW10X3B1dChrdm1fcGZuX3QgcGZuKQ0KPiArdm9pZCB0ZHhfcGFtdF9wdXQoa3ZtX3Bmbl90IHBm
biwgZW51bSBwZ19sZXZlbCBsZXZlbCkNCj4gIHsNCj4gIAlzdHJ1Y3QgcGFnZSAqcGFtdF9wYWdl
c1tURFhfRFBBTVRfRU5UUllfUEFHRV9DTlRdID0ge307DQo+ICAJYXRvbWljX3QgKmRwYW10X3Jl
ZmNvdW50Ow0KPiAgCXU2NCB0ZHhfc3RhdHVzOw0KPiAgDQo+IC0JaWYgKCF0ZHhfc3VwcG9ydHNf
ZHluYW1pY19wYW10KCZ0ZHhfc3lzaW5mbykpDQo+ICsJaWYgKCF0ZHhfc3VwcG9ydHNfZHluYW1p
Y19wYW10KCZ0ZHhfc3lzaW5mbykgfHwgbGV2ZWwgIT0gUEdfTEVWRUxfNEspDQo+ICAJCXJldHVy
bjsNCj4gIA0KPiAgCWRwYW10X3JlZmNvdW50ID0gdGR4X2ZpbmRfZHBhbXRfcmVmY291bnQocGZu
KTsNCj4gQEAgLTIyNDMsNyArMjI0Myw3IEBAIHN0cnVjdCBwYWdlICp0ZHhfYWxsb2NfY29udHJv
bF9wYWdlKHZvaWQpDQo+ICAJaWYgKCFwYWdlKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiAt
CWlmICh0ZHhfcGFtdF9nZXQocGFnZV90b19wZm4ocGFnZSksIE5VTEwpKSB7DQo+ICsJaWYgKHRk
eF9wYW10X2dldChwYWdlX3RvX3BmbihwYWdlKSwgUEdfTEVWRUxfNEssIE5VTEwpKSB7DQo+ICAJ
CV9fZnJlZV9wYWdlKHBhZ2UpOw0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIAl9DQo+IEBAIC0yMjYx
LDcgKzIyNjEsNyBAQCB2b2lkIHRkeF9mcmVlX2NvbnRyb2xfcGFnZShzdHJ1Y3QgcGFnZSAqcGFn
ZSkNCj4gIAlpZiAoIXBhZ2UpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCXRkeF9wYW10X3B1dChw
YWdlX3RvX3BmbihwYWdlKSk7DQo+ICsJdGR4X3BhbXRfcHV0KHBhZ2VfdG9fcGZuKHBhZ2UpLCBQ
R19MRVZFTF80Syk7DQo+ICAJX19mcmVlX3BhZ2UocGFnZSk7DQo+ICB9DQo+ICBFWFBPUlRfU1lN
Qk9MX0ZPUl9LVk0odGR4X2ZyZWVfY29udHJvbF9wYWdlKTsNCg0K
