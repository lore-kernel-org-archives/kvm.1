Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391420D4FC;
	Wed,  7 Oct 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409940; cv=fail; b=fcjgjPezfeLlZpY4erN6F2GqFkv8yxNoCosrKnKJLSTU6H5lZVH9gDTw76C6BzdQvwozAPx909S/T3O6sN5b5VJqp8pNpBxkZ+sn4WYX9PxSAfwOEL/smV1V7Gtjg4wj2VGw0QHIfr3WeOFATpQGbD+64v61w1HsQVoS/NBXlto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409940; c=relaxed/simple;
	bh=muBs5ORmEd28oW6xwZL7J2T0HfmJPbULvF71cnjOQbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rv1875pZTgy/oX0yDz7AP2ZHYMzjNJguaIaiR97vJNx2oKCzdEL9MJZreXgWbxqZOMr7ZdZVnvKB/69DtjpqTpZY6QU1xB7sEmfocRcVugQFNHmEakLNLEGrVD99iCQ7cEMmdryyYxkmEVn434FyeZUrhloskPPPvsbFV1CBXvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LihAr56L; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LihAr56L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791409938; x=1822945938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=muBs5ORmEd28oW6xwZL7J2T0HfmJPbULvF71cnjOQbE=;
  b=LihAr56LUG39EWLYqUanJZKNEI3RwCABHOWTtvzxh1cQZ7e7QG/IQVXJ
   afNy9eSTB6FUx7QngU6uhFe642UiHr5MM040+Wp2dCIBvm8KlV9QLbhLa
   KYkXLTZaW3WAHm2hIBPc+tAoil+uYURLeyymehI7l44bBtmgxlNYQtk5B
   2alpkrQZvtykE3AhIlHQJ+Kcv+v79gIzqfUxJMZBEG+3KcrOPqwJuRHMj
   0ZX3xwkmXXDgquuUMuDn9kTLieItSZHxYvdky5Tk50mKlfNgkVSSDJN+b
   TL6kpRJZtwhDaIbAf4iDsKnHFlJ/f2G81eWw14kkFEJ8M/M8o2s7uZT7d
   Q==;
X-CSE-ConnectionGUID: cVPuxUn7TOGY0SrvbfRN8w==
X-CSE-MsgGUID: R9n3UOPjRliUzHUkFvrDtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="202711"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="202711"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 14:52:17 -0700
X-CSE-ConnectionGUID: xrC6stJQTlW7fckkTRX9GQ==
X-CSE-MsgGUID: nb1bH3BnSausUOn5ANdr8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="1586533"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 14:52:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 14:52:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 14:52:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 14:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqLZolhxufpfCtTsoXhbIh1lhJ13YpPn5WM4U4h2SHJ5bEOpNJHXWkkd3RomVC50ZO0A9UrZUx3QpL4wcA+eH4MAcLh3KaxYVsskJuDpax29QsSocPG4MSS6/U+0C/lRkMI6kcnSf07j8wjvFQvbgk9BR96J4mKBnYuW/gzvaFPjAQ0BODZG+2zNA7DFM8LDOaTezUOl/wnnPzZEGbehRmjYOrSZ2/KJuYhhptq29f6c3iI97P5R6mg5pT/V1ZqGdgRT/9iU3A0cz3C/d4CXPkjG9VRsWJ1hcfCfw7LiBsM1x6MylrWO1YLRXJ2dEmEiKOnKJteTxWh3cqqk9UhcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muBs5ORmEd28oW6xwZL7J2T0HfmJPbULvF71cnjOQbE=;
 b=v/wwH1ZUaPVxvLaFFFu/5EbGY0/e9mjtQm7nXiAfKqzL9GaQ4Tz7dF8hhJShpb0pelbHAD/qBy4KXWBK69eIuXz6UeoVcF6s90g0vB2f1icMQGRnYfb3hI4L8ypJE+pjeh/Z/X++itVpol3ZDfM/9y/0JcPf7eXPVWSkpk0N3Y6aVI+dPkh9d2GaSMnAaUn6Yp0NenBWq4LiTjjK+UMSzLxEZNfxcOolQyZ1OYCk+tYV2SqaCxiC9YncPA03R9Z7RaD8e3fJajCkIMfi1w8rS/oX1J8jrtcVZwW1Vipw5FtrLn73fbIq6S/FD6TmQYCPqRco7pc3A8gqVMQk1METtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 21:52:06 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 21:52:05 +0000
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
Subject: Re: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Thread-Topic: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Thread-Index: AQHdTylM/3bB3XCq10Ki8poMtj4b7rbyrdsA
Date: Wed, 7 Oct 2026 21:52:05 +0000
Message-ID: <90ecae2e769c85d5c32a2d31f004dd007f4f6774.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091021.15583-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091021.15583-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6723:EE_
x-ms-office365-filtering-correlation-id: 49dc3b3a-6970-4657-8c76-08df24bd3a6e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|11063799006|56012099006|22082099003|10067099003|4143699003|5023799004|6133799003|38070700021;
x-microsoft-antispam-message-info: IvAgB9PNu4CVeyx8qqX4iWGrc1p9Vs4n5ql0BnnplK2+XfzZeu/NXKqBsV4jjAU2thb7wLWdvB6jpWqx9lqnTkpp2nFC3Mqty01nmMWHD6Oy63KPDGr6WyLgrIzFOssfcp6P6HTr4pwhcra6SF/T7LlAWKARQkoTICV8btyytT2Dpm07IEVR95Hq5KCf+6ob8W95epCopT4t8liVJosWc7m2ga4qoOujrg7l7vHUc2h8LaHPEJpfgyGmnmIHLqzbxU/s71qXZ1ze3BFZt1beGY/l0vnl4jE6veaI4FfMM10UsrxrRTvNXZCMZGtu6Opfkm2+scd1bNKCg7tCp+Zk81Lnt8XzOO8SpZ7g6jYWQMSCbFNCpqK9ar7xRthrJRFo3ob6Yd7rBajSIbwA05K7NdjIvMqMMDiaMIiJ78cbQLDUkj9Q92EBIoIEFxfFH5jRPj/yTnEs4MvxR/v/WGNxuQxxIz4gEfuN/ue619yZ+8SqA0JvVpo9bRNBFddpBN/PKQ2DW98DemWh/dQTi2DERpvcdqnO/pDkLAgtDMZrfi6XRnbcUf4Hp0JmNCn40ia878Jvr3OSUEtvEHEgRyeqO0HtWKjLrY1F9KRtSk+/mys/lUs0tpfr8MI/I3NNOHipXqvSRLqbtYhsFBJZvZA9yMEUcQzcSj+OtzXTGiNYcoQbZffwQg7nNnI0kwyi6bJMHGshl8HJaiWc1u9XThvFO0b8TQ9kfqIzP7e3b3X8gvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(22082099003)(10067099003)(4143699003)(5023799004)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3d0RjRTNUxKUm9zVzg0TTV0RlhIczJ2c05RYTZxWWNpOEJYU0VETHNmU3pY?=
 =?utf-8?B?RCtXQ0xRenRyR211QlV2bTFpLzJtSHhsTU9DQnVMcFlGcExjb0xpVDgxaGlk?=
 =?utf-8?B?M2luQ05tT0xOUHZFT1Q3bFZFc3ZPaGVFSENGUzV1TVlqZXI3L0pZTi9wU3BV?=
 =?utf-8?B?ZE5yT0RwblgwQnpnSXdVSHBhN3J5SDNBQmh0Q1AvbXFpeTBRdjJPTkZoNFMw?=
 =?utf-8?B?TXVMWGFvK28yNFkwQlB3QVpaSXR3RHFnSjFmajhRd0svdXJKU3NHbTlvWmc4?=
 =?utf-8?B?VmdySUh3dVZjRTc0VGRhUnVqZ2xhWUJ0eHdqVVB3TTRBZDFYbnNJelVCUHRT?=
 =?utf-8?B?Rk9Vd3IxeFVzbVdWeGVIdFpCR2NGekxXQ2ZLTzZOMDdHYkQvK3dkWHA0cHhM?=
 =?utf-8?B?cWYxYml6TTdjMjQ2UWFoUUNFVmVFc3kwd1U4NWcxS0lMSXk2UmZmcUNETkpI?=
 =?utf-8?B?NUFsQjhHS0ZPUnhsV09kSVZtNnlLM2J4RmRzTWpERWQwT1JJT0orczk5ZFln?=
 =?utf-8?B?YXVvNHhXNDlpUXV2WUtmMmI5aDhHYXdhWmI1dWIwOXZpL3VnUTM5RUhqNmx1?=
 =?utf-8?B?cjJtZ3dXVG9OR2x4NDVJbFRsdHd0NDBxQ2hpdTRsOTAxTWJyNXQxNXRQV1Ay?=
 =?utf-8?B?UUlQcFNEc1VBYmFjcVg0eGdUSHhFR0xFWGx5djNJZ1BxaS9ML2hLOVYvK1M3?=
 =?utf-8?B?R1l1NlNMcEE4bHpUV3lsQlBndXIwbmNId2dFcWlFZTY2SDZkbjluUkJZblZN?=
 =?utf-8?B?Z0Z4MHB6eHBqUkVsZ3JKQ2txZUk4bGZDTDVXV1lnTDdVTWRaVnE1cWN0ekp1?=
 =?utf-8?B?RkU0Z3hMYm5odEkyOHNLTHlqeW5DS0tKV3R6UXdWa3o0V1JZdGp0eDNTYktr?=
 =?utf-8?B?UVlKVDZHQ0N5UDBMTHN5elZIdkVRaHRkbjh6TGk5Z1FWWmNDbmJDeGNpbGtU?=
 =?utf-8?B?STJYcUc0V0cwanBhZmIrNFdKOHZBeS83eGtQd242OExoR0djL0N3VmQyM20w?=
 =?utf-8?B?c2RHejhDcmM5elpGRVBpclE1Q3VlaTBjUmZUMDNJd0ViYndnWlVQa1dBY3BX?=
 =?utf-8?B?ZG1pZEM1d0ViRnlBd24yajRCRVYzY3dxYUg2RlpIOG1HemtLdm1MbTJzUk9E?=
 =?utf-8?B?dVdMNW50Tm9Ga05QNTBLU0JKVThTV2FGMkpPcDIxUHNucTdoaG9WOUQzZ1VP?=
 =?utf-8?B?N0NTK291dmNRV1ZQZHRmdUlJa2NaZFFVSlFERzYyWTBxM0hxa0lDZ2NjWC83?=
 =?utf-8?B?WDJHZzFtUGNLbDJCTjRiaVBjNjFWV2NLaVNSNWlCYjE5NVlwcE5OaVZNOURi?=
 =?utf-8?B?RUQ0Uk52VVpLTWVrRUZBeDZ6Y3JxVzgyRDlTNFJ2ZFFDdytoa0svaEMzWmhy?=
 =?utf-8?B?ZXk2OVNaSis1VUppeVM2UWxuanlvQmJQWE80aGE4SExtTzVza2MzUnZpb3F0?=
 =?utf-8?B?bVFzbWZ0QkJicjVmSWd4K08xcVdzMW50ajNGMkZrdERuS2RhaXdxaVBuRnpE?=
 =?utf-8?B?WE5iV0pKcWtTU0tPNHJNaFdWWDc0WjFZQzRPRE5MelE4b3NwdFEwZmJTNk5H?=
 =?utf-8?B?Mk5EVUFmZkpvNHBjTE9Nd293VzBvbnpXQWM4SXkzcEc5aXE3RDB0b1dlY2Mx?=
 =?utf-8?B?MTZCamZObFdEUTBiTlNNZ01BQ3JycVBMdzdwSW4zbENlU3dGM1JqOVo5aDZl?=
 =?utf-8?B?ZUtRZFUrOVY5Y01TU3MrMlpYNVVtY0dDemp6TGV3R0w5Qy9wK3Vyb291cXE4?=
 =?utf-8?B?MzRHV0hUSVJha3UzaUMxN3JlMzJSeHVzR05telVQTFhxVkNEZnVnVldvMllD?=
 =?utf-8?B?ckV6NWxuY0tWZjhSV3VEWGdJTWtmVVRaWUVndWJHMHhHSUVEVFFPazBoUGJL?=
 =?utf-8?B?b2gwaHBJTVdWVkozdG53OEgvYW1yajdOQlZVOEh6dlM1QTQrdGpLZVc5YkJN?=
 =?utf-8?B?emhoUW83VWd0bFphZkhyUE9iMVIyYVVWbStJYXZ4YlpZazlrNnEreXNVdS9X?=
 =?utf-8?B?ZzJJQUl3UWlKTWxGTDFGWFloMDRjT3U3Q2tSSnRLMU92ZHhpL1ZJYjVLUmta?=
 =?utf-8?B?T2lxYlJodTMxaWhXbVRsUElBR2NnL25vMitUbWpSQmgrdHNraG44U0dnTmow?=
 =?utf-8?B?bVE1RCtGSlpnU2l0UXNQckI4cFJRNGhlenI3aDdDcDU3ZzNkSHZNaFRKVExM?=
 =?utf-8?B?Yzh0ZHZ2VVo2R2MxaVdaZ0RBUk8vUUNodjhMNHZWcUdyaE11V1VvOXBscVQv?=
 =?utf-8?B?RVNCMk4yTjlsdlY4OUZjWnRPV3JpeGxVUXhKbS9SQXk4NmZPdFNuQW5peVps?=
 =?utf-8?B?aHZkMUdRelVWbWVkOU5WWGVXdkpPbjYvZW10NngzUDN0T1I3UmxONjJGckVm?=
 =?utf-8?Q?gZGiB1livDi3sTz8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <257709F2B080BE48BF23CB370420397F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xlmU2W7bIqO00/jeviGAugMVTphbSLQmFTA6VrJZgWo+EES9MbE+djv82hhcQ4dh3jR2wdU2dCR/niU7n3K1iFP6Xa2M6qHH15sr6R/dlLSeYLybXFgC2CY6U/NBqQ8GQ2KM1iLQXuYunqclc4IBPl5k5dNfaQjybFPCDzBV0SKkvn9F69mWOkfOFYFGgXvUeSsJ3uVE7eUoqVqEm7zk9I7P3CW9R7Gcnzb7Y6ang+yWCQyedRnW3Wenym9TVFJj97e6F0g9pF2eGmUnyFWWtbRXb3z11oJPVGT3pSy6+ek8z2GVZYk4dZF3e7VuWwxxpJXt21J62g8WRDHjL1MpsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dc3b3a-6970-4657-8c76-08df24bd3a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 21:52:05.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSWg03CdLfIYmhanVazSIQNcdxdwQdkUaHQTy3qpCIWV4KjS9zkPap+k7eZ+B3Nvci3FRb6yd5KYOIW84uEiRPvZpwPyRHAmw2KgiJeisC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gQWRk
IHN1cHBvcnQgZm9yIHNwbGl0dGluZywgYS5rLmEuIGRlbW90aW5nLCBhIDJNQiBTLUVQVCBsZWFm
IG1hcHBpbmcgdG8gNTEyDQo+IHNtYWxsZXIgNEtCIGxlYWYgbWFwcGluZ3MuICBBcyBwZXIgdGhl
IFREWCBtb2R1bGUgcnVsZXMsIGZpcnN0IGludm9rZQ0KPiBNRU0uUkFOR0UuQkxPQ0sgdG8gcHV0
IHRoZSBodWdlIFMtRVBUIGxlYWYgZW50cnkgaW50byBhIHNwbGl0dGFibGUgc3RhdGUsDQo+IHRo
ZW4gZG8gTUVNLlRSQUNLIGFuZCBraWNrIGFsbCB2Q1BVcyBvdXRzaWRlIG9mIGd1ZXN0IG1vZGUg
dG8gZmx1c2ggVExCcywNCj4gYW5kIGZpbmFsbHkgZG8gTUVNLlBBR0UuREVNT1RFIHRvIGRlbW90
ZS9zcGxpdCB0aGUgaHVnZSBTLUVQVCBsZWFmIG1hcHBpbmcuDQo+IA0KPiBBc3NlcnQgdGhlIG1t
dV9sb2NrIGlzIGhlbGQgZm9yIHdyaXRlLCBhcyB0aGUgQkxPQ0sgPT4gVFJBQ0sgPT4gREVNT1RF
DQo+IHNlcXVlbmNlIG5lZWRzIHRvIGJlICJhdG9taWMiIHRvIGd1YXJhbnRlZSBzdWNjZXNzIChh
bmQgYmVjYXVzZSBtbXVfbG9jaw0KPiBtdXN0IGJlIGhlbGQgZm9yIHdyaXRlIHRvIHVzZSB0ZGhf
ZG9fbm9fdmNwdXMoKSkuDQo+IA0KPiBOb3RlLCBldmVuIHdpdGgga3ZtLT5tbXVfbG9jayBoZWxk
IGZvciB3cml0ZSwgdGRoX21lbV9wYWdlX2RlbW90ZSgpIG1heQ0KPiBjb250ZW5kIHdpdGggdGRo
X3ZwX2VudGVyKCkgYW5kIHBvdGVudGlhbGx5IHdpdGggdGhlIGd1ZXN0J3MgUy1FUFQgZW50cnkN
Cj4gb3BlcmF0aW9ucy4gIFRoZXJlZm9yZSwgd3JhcCB0aGUgY2FsbCB3aXRoIHRkaF9kb19ub192
Y3B1cygpIHRvIGtpY2sgb3RoZXINCj4gdkNQVXMgb3V0IG9mIHRoZSBndWVzdCBhbmQgcHJldmVu
dCB0ZGhfdnBfZW50ZXIoKSB0byBlbnN1cmUgc3VjY2Vzcy4NCj4gDQo+IEludm9rZSB0ZHhfcGFt
dF9nZXQoKSBiZWZvcmUgaW52b2tpbmcgdGRoX21lbV9wYWdlX2RlbW90ZSgpIHNvIHRoYXQgRFBB
TVQNCj4gcGFnZXMgZm9yIHRoZSBuZXcgUy1FUFQgcGFnZSB0YWJsZSBwYWdlIGFyZSBpbnN0YWxs
ZWQgYmVmb3JlIHRoZSBERU1PVEUNCj4gU0VBTUNBTEwgd2hlbiBEUEFNVCBpcyBlbmFibGVkLiBE
UEFNVCBwYWdlcyBmb3IgdGhlIGd1ZXN0IG1lbW9yeSBtdXN0IGJlDQo+IGluc3RhbGxlZCBpbnNp
ZGUgdGhlIERFTU9URSBTRUFNQ0FMTCwgc2luY2UgaXQgaXMgaW1wb3NzaWJsZSB0byBkbyBzbw0K
PiBiZWZvcmUgYSBzdWNjZXNzZnVsIGRlbW90aW9uLg0KPiANCj4gSW5zdGVhZCBvZiBhbGxvY2F0
aW5nIGFuZCBmcmVlaW5nIERQQU1UIHBhZ2VzIGZvciBndWVzdCBwYWdlcyBvbiB0aGUgS1ZNDQo+
IHNpZGUsIHBhc3MgcGFtdF9jYWNoZSB0byB0ZGhfbWVtX3BhZ2VfZGVtb3RlKCkgYW5kIGxldCBp
dCBkcmF3IERQQU1UIHBhZ2VzDQo+IGZyb20gcGFtdF9jYWNoZSBiZWZvcmUgdGhlIERFTU9URSBT
RUFNQ0FMTC4gVGhpcyBwcmV2ZW50cyBLVk0gZnJvbSBoYXZpbmcNCj4gdG8gbWFuYWdlIERQQU1U
IHBhZ2VzIGRpcmVjdGx5IHZpYSBhbGxvY19wYW10X2FycmF5KCkgYW5kDQo+IGZyZWVfcGFtdF9h
cnJheSgpLCBvciBoYXZpbmcga25vd2xlZGdlIG9mIERQQU1ULXNwZWNpZmljIGRldGFpbHMgc3Vj
aCBhcw0KPiBURFhfRFBBTVRfRU5UUllfUEFHRV9DTlQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBY
aWFveWFvIExpIDx4aWFveWFvLmxpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSXNha3Ug
WWFtYWhhdGEgPGlzYWt1LnlhbWFoYXRhQGludGVsLmNvbT4NCg0KVGhlIFNPQiBzZWVtcyB3cm9u
Zy4gWW91IGFyZSB0aGUgdGhlIGxpc3RlZCBhdXRob3IsIGJ1dCB0aGVzZSBkb24ndCBoYXZlIGEg
Q28tDQpkZXZlbG9wZWQtYnkgdGFnLg0KDQo+IFtzZWFuOiB3aXJlIHVwIHZpYSBvcCBzZXRfZXh0
ZXJuYWxfc3B0ZSgpLCBtZXJnZSBpbiBEUEFNVC1yZWxhdGVkIGNvZGUsDQo+ICBtYXNzYWdlIGNo
YW5nZWxvZ10NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdv
b2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNv
bT4NCj4gLS0tDQo+IHY0Og0KPiAtIEhvb2tlZCB0ZHhfc2VwdF9zcGxpdF9sZWFmX3NwdGUoKSBp
biB4ODYgb3Agc2V0X2V4dGVybmFsX3NwdGUoKSBpbnN0ZWFkDQo+ICAgb2YgaW4geDg2IG9wIHNw
bGl0X2V4dGVybmFsX3NwdGUoKSB3aGljaCB3YXMgbm8gbG9uZ2VyIGludHJvZHVjZWQgaW4gdjQu
DQo+ICAgKFNlYW4pLg0KPiAtIFJlbmFtZWQgdGR4X3NlcHRfc3BsaXRfcHJpdmF0ZV9zcHRlKCkg
LS0+IHRkeF9zZXB0X3NwbGl0X2xlYWZfc3B0ZSgpLg0KPiAtIE1lcmdlZCBpbiBEUEFNVC1yZWxh
dGVkIGNvZGUgKGkuZS4sIHBhc3NpbmcgdG9fdGR4KHZjcHUpLT5wYW10X2NhY2hlIHRvDQo+ICAg
dGRoX21lbV9wYWdlX2RlbW90ZSgpLiAoU2VhbikuDQo+IC0gQXNzZXJ0IG5ld19zcHRlIGlzIG5v
bi1sZWFmLiAoWWFuKQ0KPiANCj4gdjM6DQo+IC0gUmViYXNlZCBvbiB0b3Agb2YgU2VhbidzIGNs
ZWFudXAgc2VyaWVzLg0KPiAtIENhbGwgb3V0IFVOQkxPQ0sgaXMgbm90IHJlcXVpcmVkIGFmdGVy
IERFTU9URS4gKEthaSkNCj4gLSB0ZHhfc2VwdF9zcGxpdF9wcml2YXRlX3NwdCgpIC0tPiB0ZHhf
c2VwdF9zcGxpdF9wcml2YXRlX3NwdGUoKS4NCj4gDQo+IFJGQyB2MjoNCj4gLSBTcGxpdCBvdXQg
dGhlIGNvZGUgdG8gaGFuZGxlIHRoZSBlcnJvciBURFhfSU5URVJSVVBURURfUkVTVEFSVEFCTEUu
DQo+IC0gUmViYXNlZCB0byA2LjE2LjAtcmM2ICh0aGUgd2F5IG9mIGRlZmluaW5nIFREWCBob29r
IGNoYW5nZXMpLg0KPiANCj4gUkZDIHYxOg0KPiAtIFNwbGl0IHBhdGNoIGZvciBleGNsdXNpdmUg
bW11X2xvY2sgb25seSwNCj4gLSBJbnZva2UgdGR4X3NlcHRfemFwX3ByaXZhdGVfc3B0ZSgpIGFu
ZCB0ZHhfdHJhY2soKSBmb3Igc3BsaXR0aW5nLg0KPiAtIEhhbmRsZWQgYnVzeSBlcnJvciBvZiB0
ZGhfbWVtX3BhZ2VfZGVtb3RlKCkgYnkga2lja2luZyBvZmYgdkNQVXMuDQo+IC0tLQ0KPiAgYXJj
aC94ODYva3ZtL3ZteC90ZHguYyB8IDY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJjaC94
ODYva3ZtL3ZteC90ZHguYw0KPiBpbmRleCAzZGNkZGYxYjQ4YzUuLjMxODZjNDgwOGNhZSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0v
dm14L3RkeC5jDQo+IEBAIC0xODczLDExICsxODczLDc0IEBAIHN0YXRpYyBpbnQgdGR4X3NlcHRf
cmVtb3ZlX2xlYWZfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiArLyoNCj4gKyAqIFNwbGl0IGEgaHVnZSBtYXBwaW5nIGludG8gc21h
bGxlciBtYXBwaW5ncyBhdCBhIGxvd2VyIGxldmVsLiAgQ3VycmVudGx5IG9ubHkNCj4gKyAqIHN1
cHBvcnRzIHNwbGl0dGluZyAyTUIgbWFwcGluZ3MgKEtWTSBkb2Vzbid0IHlldCBzdXBwb3J0IDFH
QiBtYXBwaW5ncyBmb3IgVERYDQo+ICsgKiBndWVzdHMpLg0KPiArICoNCj4gKyAqIEludm9rZSAi
QkxPQ0sgKyBUUkFDSyArIGtpY2sgb2ZmIHZDUFVzIChpbnNpZGUgdGR4X3RyYWNrKCkpIiBzaW5j
ZSB0aGUgVERYDQo+ICsgKiBtb2R1bGUgZG9lcyBub3QgeWV0IHN1cHBvcnQgdGhlIE5PTi1CTE9D
S0lORy1SRVNJWkUgZmVhdHVyZSBmb3IgREVNT1RFLg0KPiArICoNCj4gKyAqIE5vIFVOQkxPQ0sg
aXMgbmVlZGVkIGFmdGVyIGEgc3VjY2Vzc2Z1bCBERU1PVEUuDQo+ICsgKg0KPiArICogVW5kZXIg
d3JpdGUgbW11X2xvY2ssIGtpY2sgb2ZmIGFsbCB2Q1BVcyBhbmQgZGlzYWxsb3cgdkNQVXMgZnJv
bSBlbnRlcmluZyB0bw0KPiArICogZW5zdXJlIERFTU9URSB3aWxsIHN1Y2NlZWQgb24gdGhlIHNl
Y29uZCBpbnZvY2F0aW9uIGlmIHRoZSBmaXJzdCBpbnZvY2F0aW9uDQo+ICsgKiByZXR1cm5zIEJV
U1kuDQoNCkhvdyBhYm91dCBwdXR0aW5nIHRoZXNlIGluIHRoZSBmdW5jdGlvbiBpbnN0ZWFkIG9m
IHVwIGhlcmU/DQoNCj4gKyAqLw0KPiArc3RhdGljIGludCB0ZHhfc2VwdF9zcGxpdF9sZWFmX3Nw
dGUoc3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm4sIHU2NCBvbGRfc3B0ZSwNCj4gKwkJCQkgICAg
dTY0IG5ld19zcHRlLCBlbnVtIHBnX2xldmVsIGxldmVsKQ0KPiArew0KPiArCXN0cnVjdCBrdm1f
dmNwdSAqdmNwdSA9IGt2bV9nZXRfcnVubmluZ192Y3B1KCk7DQo+ICsJc3RydWN0IGt2bV90ZHgg
Kmt2bV90ZHggPSB0b19rdm1fdGR4KGt2bSk7DQo+ICsJZ3BhX3QgZ3BhID0gZ2ZuX3RvX2dwYShn
Zm4pOw0KPiArCXU2NCBlcnIsIGVudHJ5LCBsZXZlbF9zdGF0ZTsNCj4gKwlzdHJ1Y3QgcGFnZSAq
c2VwdF9wdDsNCj4gKwlpbnQgcjsNCj4gKw0KPiArCWxvY2tkZXBfYXNzZXJ0X2hlbGRfd3JpdGUo
Jmt2bS0+bW11X2xvY2spOw0KPiArDQo+ICsJaWYgKEtWTV9CVUdfT04oIWlzX2xhc3Rfc3B0ZShv
bGRfc3B0ZSwgbGV2ZWwpIHx8IGlzX2xhc3Rfc3B0ZShuZXdfc3B0ZSwgbGV2ZWwpLCBrdm0pKQ0K
PiArCQlyZXR1cm4gLUVJTzsNCj4gKw0KPiArCXNlcHRfcHQgPSB0ZHhfc3B0ZV90b19zZXB0X3B0
KGt2bSwgZ2ZuLCBuZXdfc3B0ZSwgbGV2ZWwpOw0KPiArCWlmICghc2VwdF9wdCkNCj4gKwkJcmV0
dXJuIC1FSU87DQo+ICsNCj4gKwlpZiAoS1ZNX0JVR19PTighdmNwdSB8fCB2Y3B1LT5rdm0gIT0g
a3ZtLCBrdm0pKQ0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKw0KPiArCXIgPSB0ZHhfcGFtdF9nZXQo
cGFnZV90b19wZm4oc2VwdF9wdCksIFBHX0xFVkVMXzRLLCAmdG9fdGR4KHZjcHUpLT5wYW10X2Nh
Y2hlKTsNCj4gKwlpZiAoS1ZNX0JVR19PTihyLCBrdm0pKQ0KPiArCQlyZXR1cm4gcjsNCj4gKw0K
PiArCWVyciA9IHRkaF9kb19ub192Y3B1cyh0ZGhfbWVtX3JhbmdlX2Jsb2NrLCBrdm0sICZrdm1f
dGR4LT50ZCwgZ3BhLA0KPiArCQkJICAgICAgbGV2ZWwsICZlbnRyeSwgJmxldmVsX3N0YXRlKTsN
Cj4gKwlpZiAoVERYX0JVR19PTl8yKGVyciwgVERIX01FTV9SQU5HRV9CTE9DSywgZW50cnksIGxl
dmVsX3N0YXRlLCBrdm0pKSB7DQo+ICsJCXIgPSAtRUlPOw0KPiArCQlnb3RvIGVycjsNCj4gKwl9
DQo+ICsNCj4gKwl0ZHhfdHJhY2soa3ZtKTsNCj4gKwllcnIgPSB0ZGhfZG9fbm9fdmNwdXModGRo
X21lbV9wYWdlX2RlbW90ZSwga3ZtLCAma3ZtX3RkeC0+dGQsIGdwYSwNCj4gKwkJCSAgICAgIGxl
dmVsLCBzcHRlX3RvX3BmbihvbGRfc3B0ZSksIHNlcHRfcHQsDQo+ICsJCQkgICAgICAmdG9fdGR4
KHZjcHUpLT5wYW10X2NhY2hlLCAmZW50cnksICZsZXZlbF9zdGF0ZSk7DQo+ICsJaWYgKFREWF9C
VUdfT05fMihlcnIsIFRESF9NRU1fUEFHRV9ERU1PVEUsIGVudHJ5LCBsZXZlbF9zdGF0ZSwga3Zt
KSkgew0KPiArCQlyID0gLUVJTzsNCg0KTm90IHRyeWluZyB0byByb2xsYmFjayB3aXRoIGFuIHVu
bG9jayBpbiB0aGlzIGNhc2Ugc2VlbXMgbGlrZSB0aGUgcmlnaHQgY2FsbCwNCmJ1dCBjYW4gd2Ug
aGF2ZSBhIGNvbW1lbnQganVzdGlmaWNhdGlvbj8NCg0KPiArCQlnb3RvIGVycjsNCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK2VycjoNCj4gKwl0ZHhfcGFtdF9wdXQocGFnZV90b19wZm4o
c2VwdF9wdCksIFBHX0xFVkVMXzRLKTsNCj4gKwlyZXR1cm4gcjsNCj4gK30NCj4gKw0KPiAgLyoN
Cj4gICAqIEhhbmRsZSBjaGFuZ2VzIGZvcg0KPiAgICogKDEpIGxlYWYgU1BURXMgZnJvbSBub24t
cHJlc2VudCB0byBwcmVzZW50DQo+ICAgKiAoMikgbm9uLWxlYWYgU1BURXMgZnJvbSBub24tcHJl
c2VudCB0byBwcmVzZW50DQo+ICAgKiAoMykgbGVhZiBTUFRFcyBmcm9tIHByZXNlbnQgdG8gbm9u
LXByZXNlbnQNCj4gKyAqICg0KSBwcmVzZW50IGxlYWYgU1BURXMgdG8gcHJlc2VudCBub24tbGVh
ZiBTUFRFcyAoc3BsaXR0aW5nKQ0KPiAgICoNCj4gICAqIC0gKDEpIGFuZCAoMikgbXVzdCBiZSB1
bmRlciBzaGFyZWQgbW11X2xvY2suIElmICgxKSBhbmQgKDIpIGFyZSB1bmRlcg0KPiAgICogICBl
eGNsdXNpdmUgbW11X2xvY2sgKGN1cnJlbnRseSBpbXBvc3NpYmxlKSwgY29udGVudGlvbiBlcnJv
cnMgbWF5IGxlYWQgdG8NCj4gQEAgLTE4ODgsMTMgKzE5NTEsMTcgQEAgc3RhdGljIGludCB0ZHhf
c2VwdF9yZW1vdmVfbGVhZl9zcHRlKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuLA0KPiAgICog
ICAoY3VycmVudGx5IGltcG9zc2libGUpLCB3YXJuaW5ncyB3aWxsIGJlIGdlbmVyYXRlZCBkdWUg
dG8NCj4gICAqICAgbG9ja2RlcF9hc3NlcnRfaGVsZF93cml0ZSgpIG9yIFREWF9CVUdfT04oKSBj
YXVzZWQgYnkgY29uY3VycmVudCBCTE9DSywNCj4gICAqICAgVFJBQ0ssIFJFTU9WRS4NCj4gLSAq
IC0gUHJvbW90aW9uL2RlbW90aW9uIGlzIG5vdCB5ZXQgc3VwcG9ydGVkLg0KPiArICogLSAoNCkg
bXVzdCBiZSB1bmRlciB3cml0ZSBtbXVfbG9jayBjdXJyZW50bHkuDQoNCkN1cnJlbnRseT8NCg0K
PiArICogLSBQcm9tb3Rpb24gaXMgbm90IHlldCBzdXBwb3J0ZWQuDQoNCkFuZCB3ZSBhcmUgbm90
IHRyeWluZyB0byBzdXBwb3J0IGl0LCByaWdodD8NCg0KQ2FuIHdlIG5vdCBtYWtlIHRoaXMgaW1w
bHkgc29tZSByb2FkbWFwIG9mIGVuaGFuY2VtZW50cyB0aGF0IG1heSBuZXZlciBoYXBwZW4NCmZv
ciBhIGxvbmcgdGltZSBpZiBldmVyPw0KDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgdGR4X3NlcHRf
c2V0X3ByaXZhdGVfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwgdTY0IG9sZF9zcHRl
LA0KPiAgCQkJCSAgICAgdTY0IG5ld19zcHRlLCBlbnVtIHBnX2xldmVsIGxldmVsKQ0KPiAgew0K
PiAgCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmt2bS0+bW11X2xvY2spOw0KPiAgDQo+ICsJaWYgKGlz
X3NoYWRvd19wcmVzZW50X3B0ZShvbGRfc3B0ZSkgJiYgaXNfc2hhZG93X3ByZXNlbnRfcHRlKG5l
d19zcHRlKSkNCj4gKwkJcmV0dXJuIHRkeF9zZXB0X3NwbGl0X2xlYWZfc3B0ZShrdm0sIGdmbiwg
b2xkX3NwdGUsIG5ld19zcHRlLCBsZXZlbCk7DQo+ICsNCj4gIAlpZiAoaXNfc2hhZG93X3ByZXNl
bnRfcHRlKG9sZF9zcHRlKSkNCj4gIAkJcmV0dXJuIHRkeF9zZXB0X3JlbW92ZV9sZWFmX3NwdGUo
a3ZtLCBnZm4sIGxldmVsLCBvbGRfc3B0ZSk7DQo+ICANCg0KRXhjZXB0IGZvciB0aG9zZSBzbWFs
bCBjb21tZW50cywgb3ZlcmFsbCBsb29rcyBnb29kIHRvIG1lLg0KDQo=
