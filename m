Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920E41DDFC;
	Tue, 11 Aug 2026 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488036; cv=fail; b=KFQ0L1Ck0AmqKAYQo/w1EQ20PpveKoHoM4apLUYAQcw5mM7O4zVkZYHBeB64gWtDGmBcI8wlDbVa2ryzeOXVXeNmODBMx+fVvvtL5dQ8oMwTrZheolutU9ed9PQ7WPTZn/lv7lx/5GVMXGskD8q/ZIhy8ktrAbK6khxF0axE/AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488036; c=relaxed/simple;
	bh=VkCGgqRs35Kxb86D3s6ZcJoF3vjzIdZxZRwgvZO1OAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g1uDsQJDCjcmVtPPL+7TWTwQbtwr71L95GxSKIpVmFirdV4n6EynbZLS3Veuv+apS9hEnpn1/drA3VulfBdBhPUJJ1j9b2LnrfSKlAOJr2LM4WrZBHzSWutvSNIC/Z4F4occPdbVRKr5qzWLVrPhZJ26yFYHuWPEfzKRu3ksfYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYRM3Weo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYRM3Weo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786488034; x=1818024034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VkCGgqRs35Kxb86D3s6ZcJoF3vjzIdZxZRwgvZO1OAY=;
  b=ZYRM3WeofJZYmlvPpCCMMkFzEDHWxcjiebKkzlq3gtC6xSfHue1yTCs0
   ju8/FH9yLprzgOWVRQoNmXsEUsbAe88fud0C1vt2jF+isFm1Qah/sHRFf
   d4P5h15ATq0wciKCqMO6Yyn2bm1NjEK/r1TA0I2viOxBC590hJT0GQwmm
   35duwNEc5YVNxu7CUcM8omVnWr9JDro8Vge9bQsJ6hdo5tpXnpXmq1w1H
   B+7uM3653tlZ502BsBT2SfmHcsabWdbIkj5C2ulkfXXeyU9irW0xSLa3n
   FwmsaerZWlM4ZJhRWIkLtiE1X0N3ufOezlrUBzzBOvVy8X6Oq4I+LNqVK
   Q==;
X-CSE-ConnectionGUID: nDwkIg+ASSeSL3TQAYsP+w==
X-CSE-MsgGUID: odb1oROgRBS+C/p5uGa8Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98177762"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98177762"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:40:34 -0700
X-CSE-ConnectionGUID: 8HDi1fqDR2mcFy3P67wBiw==
X-CSE-MsgGUID: Wyiz5uXwRJmGRMC/D1ceDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="267311245"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:40:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 15:40:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 15:40:32 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 15:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCZCgrwWK9iX4f6E2A2/3XqccCs2HAL8raQ244GDoWdkhtBzLmrAj7ekN6GsU8rbJAjQtbbMeLr7eGngTRNzrLUyZOIxgSDr5ne+AIcps+scZtThtRGPe4WmKtu7CZ6F/2BNtIldXKlGb/+pNW7XzURzi/iiIHCQbndWdHXFKESNK/QuWl3M1DgtAQDajjamR6gphWYynUMbh8SI7euA3s+8zGyANbuNy0+8IOKtlPi/1l+PTH+RMz7MLzX4o2RoQVymMGLKMKhlpQzOwQA32TJZV8S7qqqdvB3aISMKaOD1Ss+kOZSVOYxyRCPvQBHg+nQhoDJ2mXdEheI2jZ+3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkCGgqRs35Kxb86D3s6ZcJoF3vjzIdZxZRwgvZO1OAY=;
 b=Gn74L8qyxjMZudmrkk4BBunwAYAmvmIa1pt4Aum4STEqjlm/CEmnPPDp1Fr7FUsQlX8C5sEOdYq0xBrAlYfCRV+dw7OgX1bH/s3fkCOfYJ1q9TCd3NIdr+6blvEK9SqBE73SKc9AuFi1lmwJpVU6x3cJgafrWA00sZoHa2HyVGZcGwtWBMtpQXP7HjZTmbUNwt76iOlH8jUmed0Yx0XFpVwBD9xaVBjuD7HvjoJq55W9O1tHL0/UvG2X4remrD2sun5Kt+7zh+LJCbpF/XrqPyDD0YTPLJMkC7Mn2+vEPHB0zj4dMvDrqGpf5r0bYgxcYgkpqauxa2h7pOBfHOh5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 22:40:27 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 22:40:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgA=
Date: Tue, 11 Aug 2026 22:40:27 +0000
Message-ID: <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
In-Reply-To: <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7392:EE_
x-ms-office365-filtering-correlation-id: d8d916aa-b8eb-46f0-2642-08def7f98a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: kWuP+Rza2EMMXlMkS/RDOk3ajg/jvdTxgMP1ThzivHJ8pvpdfr+7J9gKtR2DuRF97UWpYqgW6R/VSMNvF+pHPz+Roj/8DfvqPe2kXvpc3i2D+LZY0PwwHYNWlBxLXhcLjIcAUWuCa+1Sb0aEk8xTpSZr94j7IMVG4gu+cfL7S46DlNCtj6vl+gy0DiedrFlrSyQ2tvmiIdrJpcqkvGr1HFn6Isd7Zh/mxaevi4loCyU+OXpI5McPZB4XeLg+927eQ2/rZT+i6OuF3e+oXq6rk439BSZ776Jiy/znygQkgt/Fr1tHgtuW7GrzInu0Gf3nruOd/rQrYYKYdSvBufGqNDxK4AZugE6GueF2TLizHxryvrC3mgDeJRWTDXzxyouWBLQ5MKKTqZk4uJhzGTa6gXJhW7hsj542FlH7Skc2tlrJprgHbYgzOr4UX1HDGBa8eZwuVbsvL2UvpmgHr/5raL4fOrhySv9NtOxuhrW0Ne9u3iJsDrID+p1sXXoZ1dODSo9bwjDN3ODhml/eTdQQheQFD1CIaIOZ1vWxjPJGLy86nrLBG6pYz27AUpgfaojm76mh8QLrqJ0KiPuKSL/sH8fdhDNfdjG8mcude3mmBk1eARuev0epOrbSHnB0WPKmTiH0IaPSfVGQIoOqb0knTsw6H+1IEBZKkpO68p0rj4HSBEoGqZtAIVHMbidPYgohZNrG23KYVLSViwdwfMi9lOJewLe4IUV2pXutZD4D4CA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJpaHVaZm9uejBENXB3R3RtcFVIRWNVVisvdGEwaytGN1YzcnpJQ1Jmc3Rh?=
 =?utf-8?B?K0lvS0ZlcGVPM3R6QkdBNGQvUEZ1MU1kZXRvcFZiclFCWXU5NlFQZFU1RmUz?=
 =?utf-8?B?d1J3ZENoV29CcXU0UzAwVWtOTDV2cnhoTS9JM0pWSVA5UU91K3RIZCtidEJn?=
 =?utf-8?B?NVNTakU5QkhiUVBTdXZIanhmVGZUMDU5ZCs4bXZ5VTUwMmUxTUVhZTBDR0M5?=
 =?utf-8?B?M05tU2VKMFlLZnMvcGVKTnZQcjFINkVmZUV4WU9DbnRKM3NSamtLTmNNNzdp?=
 =?utf-8?B?WGFVZ1l5RGpRU0NzYmFHTVpPUnIwSXhPT05EbTFOSjNvazZYem1FWFBlNWN2?=
 =?utf-8?B?OG5oKzl2UUw1WWZZS2xSTWYrcFVsbEtabFZTZ0wxV1lDNk9yWjFZQkhzVjJp?=
 =?utf-8?B?b0FiQ0tBRVprSzFZSmJTYWJ1UUtCeklZTXFJcjNtTlp3U3dlemo5TXlEaFJq?=
 =?utf-8?B?eFNzZGEyUWFGc1RteFN0T015T1NPY3dTMWJ2SUxqd0tlWUdrODgzU3VWRWRL?=
 =?utf-8?B?bWxHOHJ1NVZsWi9salpGM204VFlBRm5DQ1gxQStuc0xJU3JpVDlIR0dPeW80?=
 =?utf-8?B?UEhhVzRvaW5yODNxei8vZWJjdHFOUVdsbUxKY1o3M3F3QjJKSFZGR3ExNWt4?=
 =?utf-8?B?MWxiSVBhemZBRlB5dGlTL3pDKzBVZXVCYUkzRFR1WllDUjZYNGlMQkNBdlVJ?=
 =?utf-8?B?dkFJZE5xKzFkQlRnQUkvZGtiTmF2K0J0UG5VK1dFc3FmQ01YVEZzZy9UVzZE?=
 =?utf-8?B?dnkxTzRIT0g1cWtCdTFvTXNPeERkTFRnOUU2dkpidVRhVWk2ZG1xMGRtWHFh?=
 =?utf-8?B?SGtsTUt6OW02QjJseUxJVTUxTlE3cTVLb1RiM1VCQkVNWUprUEJlTGVRTEFC?=
 =?utf-8?B?RlU2SjBXY3c3S1NnR211WEg5MGV1UndZN09Hb0JSUCt4Vjh4dTdKWkF4RXdM?=
 =?utf-8?B?RjJIc0l1VXJCNjl0VE9CSnFUS2M5YzFwbHpscmZyWTRwaGV0bGNPSEt0Zkcr?=
 =?utf-8?B?SWFxQXpVYmk3cDMzMUVGYlJTOElmTXRSQ2J6VHNGY3YyOW8xRk4zZk1yY2M2?=
 =?utf-8?B?SVBGbURTNmZsNHFxd0J4eXdkdTBIN0dqVHdaTWMrNDh0VnlJSk40d3FCaTdG?=
 =?utf-8?B?MUpndXZGT2pJdThtaHZWRSt0WkxHaERUdHI3cmhCakw5Z2JyZU5vazhvZmtW?=
 =?utf-8?B?WnNWWVliYXVRQUZjTkt5T2twMHVIdVBtamRWU0Y0V1NVNXBZcDdScW9sSitK?=
 =?utf-8?B?Mys4RmZ0WFN4K05XSFY3OC9EU3Q4UTVwb05ZZHZxMXRyZkVQampkV0E3dTZ2?=
 =?utf-8?B?Sm05bXRvbDJwb3VDUXk5eWlyM1prTHBodGZkNUhLZ3ZtTUtpb1JYU0h4VCt3?=
 =?utf-8?B?VTJOUWRxZG1xTDBTT0NzR2RiTHBWQVJFamQ5NTFONjhEdFgxOEVyenF3QTdN?=
 =?utf-8?B?SXJkWDdyTTJZZzFSbXNZLy9JNURKYnpDc3VPTEIySjFQMFFNL2NFeERMdjNt?=
 =?utf-8?B?Z2VPRVd0S2pDdzQ4Qk9ibVlPcWdoZE9BRFZMRFdsYXpDODB3VWF3ci9KT1Fh?=
 =?utf-8?B?R2xYZjZ1TTAyNjdORlRDck5jcysrSGJTUmQrTVRLR3ZSZTJVWXJVdTZsQU8w?=
 =?utf-8?B?ZVphRnVhVzNNRXVTQ21VRXFFb2cyVWJJMXpTOHZwWlYzWHpZNkVKU0NURmhm?=
 =?utf-8?B?ZHdmUkZSSlFLVGJxb2N6OXp3dHdkVlVFRFhnUThoZ2w5eS9ibG8xNS9oWENy?=
 =?utf-8?B?RGlkZkJ3bERiSWI1Z2M2ZGdHaVozb1dOblFHNFZFa0hMcC9VUUtOdjhEbWx3?=
 =?utf-8?B?K1pRNjFZZGxGLzZ4SFIxcTl3Ujhwb1RiQlVQV1hRZXdLVkZjdS81OUcxVXZC?=
 =?utf-8?B?N01VL1ZXK1paOElRNVBVOTFKMzRPYmZBY2drOFZhU2N4UHZRbWNORG1pdUox?=
 =?utf-8?B?RlF4N1hVbEh3UnNBOEtuWWNrTFl6bkRaWjdWSU1qYXA5bUZocW03ZTB4M2Vq?=
 =?utf-8?B?OUhPSWtqWTMySW5FNWJLc3pIZ0dYR1ZHbFhEVVA5ZElZaGg4REYrSi85UVRu?=
 =?utf-8?B?aExKSG9lN2dEME5VdTNTMG12L0hKZEZiUjhqMTZBYi9JQ3hEUTVXMENhVjA3?=
 =?utf-8?B?MTNoYXlMbjRsRWh3NXJiak1FSVA2WU9DZEdkVys1c09KVERHWlVFWnNoZmNG?=
 =?utf-8?B?Z28zM3pkN2ExVEFUdFZ5ZUhoWUFyaW1GanVpTElKa2NOUnA2ZTJEcHpId29x?=
 =?utf-8?B?NUhsQmIxV0poL1RvMERBOEdndE1rRngyMVpKZ3ErTnYxejZROTY4L0lEcFNp?=
 =?utf-8?B?Umd6T25pMThneUNubGQ4bE1WdjBXQlZiQ1VpdEtmcUlWcFJ0WjZjdEQ3cVVz?=
 =?utf-8?Q?bIwD6v0uvHlQpASY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <822282FF361EAC4991A0DE7C95D67675@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HhoioXt3P3A2GamX7lvTMrx2+REw8JjCpopPIg4DJsQimr8RFutC6xvg8/h/aRbDF6ZWoL9iPPZOErcQ487tT7fjQRQ+c/83m+W/eWnHRS0cjygdUhxNmTNR4cAEACiL7fkmrHXqZFRR8Af+qzsMwSnnciE6FGzVI71fOYGuxwnAM5sgoIloupeaJ2Grou7VbL7Dwj+2FQv5izYkUA8jkbhY2XorXszxywKpW41T5iUyPODQYAk4e+6js5gM2FjsPXW7oj7aU8LkrbrT0l3RUF8ZrNv8yrsvT311K8+wSg5gxIaUkh6pYby1QfF1hGt5EkKqFNONEZ+xZT1YDnhksg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d916aa-b8eb-46f0-2642-08def7f98a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 22:40:27.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2b4eb96z2SVIMase7TD9H/wJ8VGX8RdV836SWKQ3GGSTCPYPibULIdufyaxDGM0fyx5wZ/tVn/VrMSYc4pec2tGowHY+KSHYfwlbf3amIro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
X-OriginatorOrg: intel.com

U2VhbiwgRGF2ZSzCoEtpcnlsLA0KDQpJbiBQVUNLIHdlIHRhbGtlZCBhYm91dCBob3cgdGhlIFRE
IHNjb3BlZCBxdW90ZSBvcGVyYXRpb24gYXZvaWRzIGNoYW5nZXMgDQppbiB0aGUgZ3Vlc3QuIEJ1
dCB0aGlzIHNlcmllcyBpcyBhY3R1YWxseSBjaGFuZ2luZyB0aGUgZ3Vlc3QsIHNvIGlzIA0Kc29t
ZXdoYXQgYXQgb2RkcyB0byB0aGF0IGFzc2VydGlvbi4gSXQgdHVybnMgb3V0IHRoZXJlIGFyZSBz
b21lIHRyYWRlb2ZmcyANCmhlcmUgdGhhdCBhbHNvIGNvbm5lY3QgdG8gVERYIG1pZ3JhdGlvbiB1
QVBJLiBQbGVhc2Ugc2VlIGJlbG93IGZvciBhbiANCmV4cGxhbmF0aW9uIGFuZCByZWNvbW1lbmRl
ZCBjb3Vyc2Ugb2YgYWN0aW9uLg0KDQpBcyBhIGdlbnRsZSByZWNhbGwgaGVscGVyLi4uIFRoZSBn
ZW5lcmFsIGF0dGVzdGF0aW9uIGZsb3cgY29udmVydHMgYSANCnJlcG9ydCB0byBhIHF1b3RlLCB3
aGljaCB0aGVuIGdldHMgY2hlY2tlZCBieSBhIHZlcmlmaWVyLiBUaGUgcmVwb3J0IGlzIA0KbGlr
ZSBhIHNuYXBzaG90IG9mIHRoZSBndWVzdCBhbmQgaXRzIGVudmlyb25tZW50LiBUaGUgcXVvdGUg
aXMgYSBzaWduZWQgDQp2ZXJzaW9uIG9mIHRoZSByZXBvcnQgcGx1cyBoYXJkd2FyZSBjZXJ0cy4g
SXQncyBzaWduZWQgd2l0aCBhIGhhcmR3YXJlIGtleSANCmFuZCBjYW4gdXNlIGRpZmZlcmVudCBr
aW5kcyBvZiBjcnlwdG8uDQoNClRoZXNlIHBpZWNlcyBhcmUgZXZvbHZpbmcgdG8gaGFuZGxlIGEg
ZmV3IHByb2JsZW1zIGF0IG9uY2U6DQotIFRoZSBzdHVmZiB0aGF0IG5lZWRzIHRvIGJlIGF0dGVz
dGVkIGlzIGdyb3dpbmcuIEJhc2ljYWxseSBtb3JlIHBsYXRmb3JtIA0KICBkZXRhaWxzIGFuZCBk
ZXZpY2VzIGFyZSBnZXR0aW5nIGFkZGVkIHRvIHRoZSBibG9icy4NCi0gVGhlIGNyeXB0byBzdHVm
ZiBpcyBncm93aW5nLiBUaGUgcG9zdCBxdWFudHVtIGNyeXB0byBzdHVmZiBpcyBsYXJnZSwgDQog
IGV0Yy4gVGhhdCBzdHVmZiBsaXZlcyBpbiB0aGUgcXVvdGUuDQotIE1pZ3JhdGlvbiB3YW50cyBh
IHF1b3RlIHRoYXQgaXMgcGxhdGZvcm0gc3BlY2lmaWMgYW5kIG5vdCBURCBzcGVjaWZpYy4NCg0K
QmVjYXVzZSB0aGUgcGxhdGZvcm0gZGV0YWlscyBhcmUgZ3Jvd2luZywgdGhleSBuZWVkIHRvIGVp
dGhlciBnbyBpbnRvIGEgDQpsYXJnZXIgcmVwb3J0IG9yIGFkZGVkIGxhdGVyIHZpYSBhIFREIHNj
b3BlZCBxdW90ZS4gQnV0IHRoZSBwb3N0IHF1YW50dW0gDQpjcnlwdG8gc3R1ZmYgaXMgZ29pbmcg
dG8gYmxvYXQgdGhlIHF1b3RlIGVpdGhlciB3YXkuDQoNCklmIHRoZSByZXBvcnQgZ3Jvd3MgdG8g
aW5jbHVkZSBhbGwgdGhlIFREIHNwZWNpZmljIGRldGFpbHMsIHRoZW4gdGhlIFFVT1RFIA0Kc2Vh
bWNhbGwgY2FuIGJlIHBsYXRmb3JtIHNjb3BlZCBiZWNhdXNlIGFsbCB0aGUgZGV0YWlscyB0aGF0
IGl0IG5lZWRzIGFyZSANCnBhc3NlZCBpbiBhcyBhcmdzLg0KDQpCdXQgaWYgaXQgaXMgVEQgc2Nv
cGVkLCB0aGUgcmVwb3J0IGNhbiBzdGF5IHRoZSBzYW1lIHNpemUgYW5kIHRoZSBleHRyYSANCmRl
dGFpbHMgY2FuIGp1c3QgYmUgYWRkZWQgZHVyaW5nIHRoZSBxdW90ZSBvcGVyYXRpb24uIEZvciBt
aWdyYXRpb24sIGl0IA0Kb25seSBuZWVkcyBhIHBsYXRmb3JtIHNjb3BlZCBxdW90ZS4gSWYgdGhl
cmUgYXJlIGV4dHJhIGRldGFpbHMgYWJvdXQgYSANCnNwZWNpZmljIFRELCB0aGUgbWlncmF0aW9u
IHN0dWZmIGNhbiBiZSBmaW5lIHRvIGp1c3QgaWdub3JlIHRoZW0uIChpLmUuIGl0IA0KY2FuIGdl
dCB3aGF0IGl0IG5lZWRzIGZyb20gVEQgc2NvcGVkIHF1b3RlcyBvciBwbGF0Zm9ybSBzY29wZWQg
cXVvdGVzKS4NCg0KVGhlIGN1cnJlbnQgUVVPVEUgc2VhbWNhbGwgc3VwcG9ydHMgYm90aDogcGxh
dGZvcm0gc2NvcGVkIGFuZCBURCBzY29wZWQgDQpvcGVyYXRpb25zLiBCdXQgc2luY2Ugd2UgY291
bGQgZ2V0IGJ5IHdpdGggZWl0aGVyIG9ubHkgYSBwbGF0Zm9ybSBvciBURCANCnNjb3BlZCBzZWFt
Y2FsbCBmb3IgYm90aCBvcGVyYXRpb25zLCB3ZSBjb3VsZCByZWR1Y2UgdGhlIGtlcm5lbCdzIHVB
UElzLCANCm9yIGNoYW5nZSB0aGUgQVBJJ3MgbG9jYXRpb24uIFBlciByZWNlbnQgZGlzY3Vzc2lv
biwgU2VhbiBzZWVzIFREIHNjb3BlZCANCkFQSXMgbGl2aW5nIGluIEtWTSBhbmQgcGxhdGZvcm0g
c2NvcGVkIHRoaW5ncyBsaXZpbmcgaW4gdGhlIGhvc3QgDQpkcml2ZXIvdGlwLiBTbyBhbGwgdGhh
dCBsZWF2ZXMgdXMgd2l0aCBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQogfE5vcm1hbCBxdW90ZSAg
ICB8TWlncmF0aW9uIHF1b3RlIHxSZXBvcnQgc2l6ZXxRdW90ZSBzaXplfHVBUEkgbG9jYXRpb24g
IHwNCi18LS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0t
LS0tLS18LS0tLS0tLS0tLS0tLS0tfA0KMXxQbGF0Zm9ybSBzY29wZWQgfFBsYXRmb3JtIHNjb3Bl
ZCB8R3Jvd3MgICAgICB8R3Jvd3MgICAgIHxURFggaG9zdCBkcml2ZXJ8DQoyfFREIHNjb3BlZCAg
ICAgICB8VEQgc2NvcGVkICAgICAgIHxGaXhlZCAgICAgIHxHcm93cyAgICAgfEtWTSAgICAgICAg
ICAgIHwNCjN8VEQgc2NvcGVkICAgICAgIHxQbGF0Zm9ybSBzY29wZWQgfEZpeGVkICAgICAgfEdy
b3dzICAgICB8Qm90aCAgICAgICAgICAgfA0KDQoNCkknbSB0aGlua2luZyB3ZSBzaG91bGQgcHJv
Y2VlZCB3aXRoIDIgYmVjYXVzZSBvbmx5IHRoZSBxdW90ZSBzaXplIGNoYW5nZXMuIA0KU28gbGVz
cyBndWVzdCBjaGFuZ2VzIG92ZXIgdGltZS4gMyBpcyBub3QgcmVhbGx5IGEgZGlzYXN0ZXIgZWl0
aGVyLCBidXQgd2UgDQpzaG91bGRuJ3QgbmVlZCAyIHVBQklzLiBGb3IgMSwgZnJvbSBlYXJseSBk
aXNjdXNzaW9uIGl0IHNlZW1zIGl0IGNhbiBiZSANCm1hZGUgdG8gd29yayBidXQgc291bmRzIGxp
a2UgaXQgd2lsbCByZXF1aXJlIHNvbWUgbW9yZSBleHRlbnNpdmUgY2hhbmdlcyANCnRvIHRoZSBU
RFggYXR0ZXN0YXRpb24gc3R1ZmYuIFNvIHByb2JhYmx5IG5lZWRzIGEgYml0IG1vcmUgaW52ZXN0
aWdhdGlvbiANCmJlZm9yZSB3ZSBjYW4gc2F5IGl0IHdvbid0IGRpc3R1cmIgc29tZSBvdGhlciBW
TU0gdmVuZG9yLCBldGMuDQo=
