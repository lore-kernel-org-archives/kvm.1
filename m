Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BAF38E5FB;
	Mon, 16 Mar 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692846; cv=fail; b=N1OB8WpwaWYPzz1WBPkHwme87KkKSyXULP0CDMFE85x/3cnjkG/AK/vMTgEKtEB1Pd2YA/K0/A3tln+XQFKkRoN1fmwJP3i06vDxNZ34VVbfloyaE++uXZtSgKykoxpcYfRz56CQuN1KNjAiAGT4/t+JT7N6PH/1lbfiXk9+5r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692846; c=relaxed/simple;
	bh=tCnSxqrGM7gNzahv0xoKhvGhwJillQVJvJH0wedGgXI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxVQVuCf78j00P4b/YHhIU08kZniqKJdUkxT1EBjuDU3XZPY/QaP4IvzLo/JrzHT2FIqtxejX0Vi5drj+yUXTTvHF73uHJR35mzxdSMLCWZOZuDUwjmJdbM0l005Z3j2tN9x6xySDBUAoNZj12Tl+YsIN+fU7eIBYwFpZ6ikPqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJ2eD9v4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJ2eD9v4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773692845; x=1805228845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tCnSxqrGM7gNzahv0xoKhvGhwJillQVJvJH0wedGgXI=;
  b=HJ2eD9v44Q4rGYudSKioyGqvUE2s+bwCqFapotiABNKYLL1/GsKbZcJj
   qAL7yYZYPIMrITfAokp3UxPAafU3GeocXJ6KStzCmEG9WAYMs3EsHUnKv
   u0tNh4HXPe7yT1mzHb96LXnk4IZX+aH6Zm3+fKK19WN2cDDz7VAd5D4f8
   CgI5FsHbJEpQZsX6DmW8hF073ZflqghREjpfKas76yrSD9toknkXaKa/E
   S5VDI0hEMn9BYRHLEIRG4LrIgET3MwqrCR5odxpJwQjuLmEHAimyjrkN3
   GO4C9B/wQC4v+4p5fE/scbN8zJPDiP1P1AbXfBgVww04KXZ2AUUkQfRWr
   A==;
X-CSE-ConnectionGUID: 9XQrnYL6TvS++sMQv4KBSg==
X-CSE-MsgGUID: MyNs749kTl+58hOiV2M5ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74834473"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74834473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:27:24 -0700
X-CSE-ConnectionGUID: iZ8EwHFQTme7Ek5St/jFiQ==
X-CSE-MsgGUID: yV29xK1IQ2erfZU5V+aNMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221973350"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:27:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 13:27:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 13:27:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 13:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLgXNuGPsX6k11psmeFYyT3M1d/QQB98ew4BJph6mmgQXLtYDlLN86WrThYBos/IJMVtRliLDkVD7e45pCdEwvvz7E4YfAOzusO1WyjOgY6GVUuSwMGdmXbbiN2Oak533I/fc4pfrJYjxZF1DzMEDkLqW0zmfRc4JCsnKbW5Pi6oqkw4+dbO1cSnp4OtM+z7q8JlnLdK04iC/GobZY6YRBuOKCw651cZTH4YLf6T4+4vcM9UiPc1Te9gtz8ezv2RvoMLHAPcL/YLriTufnXg9WaxNOQXw2KVaPWEh5qQz2ZBbilkaUmBufdebXr/PW6g0tgMXxfO1sXMKBNg8SoPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ugGysM/v6IwDgf3ZutYFEz0txeSwRA7KAII+jtRGzM=;
 b=M3JIrmK6C6AEsIXeKnYM0XocTzZHT+qWAJc19VTfN+96pUcIKL5MySbS29VOM+s034M2IUn2yC3OUq2a07cmt3sc5Ew3T+B/nORwQ83ZHCU9jKyLnpwwgj3EyHkcJoSwsJcfJvkKooPsy9g66qyJ6zw+HorI6gl/CCFdQRxy5Qr3bCwLsR3zBfWN4yPG3YFlb4yQ7q8myvO206l/z/cddQ6MZR93JcZpRwrWctDkiQlMt7EVl0t4MWl4e9HlywvmXxXOWkkYVylvXfUjFszXJM63cn8IV8aENp3QSqfCSoiletRgWVLe4FaNh6c0FS2sIg735+rSd+/BiM58AaZy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.14; Mon, 16 Mar 2026 20:27:21 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 20:27:21 +0000
Message-ID: <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
Date: Mon, 16 Mar 2026 13:27:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, "Nikunj A. Dadhania"
	<nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov
	<bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb1d9e1-b128-4610-e7b2-08de839a6ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Xgwhcsd0tly7tiuRXhZgycu/Hiv0cOkuesdmDGAtpPZ/y8yrcl8crMR0e2KGDDdpO2S3lFD6unYy2CcSjot+xzJYeZ2qjLfScP9ExjxoHExPB6oq6eXfiF8YgUpgcBfHkOGsOpOLfSCeovu2qnm4ftWIB/Ke4Pe2hldXjWtlrj7NIcI1ZZr778C7m4Ks3Hc3jr4b7cOB4M+fDQgZk5ApzgVsWTUL6tcmvbkg8Envdkd6Hsbtatu21U5f+N2+tWQHDpMdmyJ0M4mRlMqy0XTJhKHYduF5B5V+8nECDWfvNPlJNZcbSaEOrkG96F175LaS6OiWTN87WAo3ik7sXIdNVCoLFktvZDUx1pu0kr0hAMzlMPRvPEpe+Ng6WrAlk69WKmx0j/69+J9IFmMr1AxX7JQ+TXruVJZqGP7vT7CZaIxSxIcibQ8qdcPnIn6u5YrIhUsaBuhtqGZ6YldiYy8dldM9sSKySMQt04Sqzbs8BOvrCFsp3sLjkPy/mDGNL2zIxrgRd1N7RuAtN4aYZ23NB4jKpfgNipodJHOvcefmTFUMAaQnkSIxxLIuR/SoXU4ZM7oRYunLys7y8XXywa/EHRgWn+et2L0oPTOhc5Gnd2IjDVfdkMZNjH8MCZOlzNzosapcEoXTk+xTQhnBGhyZrTPIJ/yRC7LJxDE7XbQNLlk9GAsWzbalpn6pwlA5t+PxK7z46YCC2qKsG+6c944TVs6a01jQjMnOIHwTFAIoY1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29MNU96QmgzblcyTHdVQkNDbnI2aDgxVXBwSU1iWldXZEJlOGhWRHp6eENv?=
 =?utf-8?B?VEZWQ0ZJOFNMTXRPZ2IybkE4bG5EakJtYzBSR3ZWYTlSZnJ5M0laMGlyeTVJ?=
 =?utf-8?B?WXVTamJtam1BdkF6SUJwTXZYQWZIOUJVM1I0UklrbHQvTDJCQ0pLbzdRcmJO?=
 =?utf-8?B?UytrOWJwcmdtVkRGbzJha1A1SjBMTEx4L2NjRVBxODM3czBHSDJtRU9TNE9L?=
 =?utf-8?B?ZEorcTZLb2tBRzE4dEtTb0J0QVgzMXZQQjBYYU8zUmxyelhoUWhCSGVJeER0?=
 =?utf-8?B?OHU1K3UxYm9BWGsxZFNYaFhQWkJ2TXRVMHhyMndYU29Yd3hOU0FtRjRMcHY5?=
 =?utf-8?B?RkhFY2MvVlQ5MlQ5VjhCSXJkM2VNa2kxUkp6c1pvTjZiczBuWnRlb1NpNnhR?=
 =?utf-8?B?ank5c3lJRzFOSS9xMEFQdVJ6WVNCKzZsSXRMR21ueUFkTUdSUnY0UExHQWFF?=
 =?utf-8?B?VmxZeU9CcnRMbllVQ1JwRk5rd0RjOHpMY1g0dUw1MnpyRndoVWxhaHp1cCtm?=
 =?utf-8?B?U0FIQ0FKVW95MlY3R2xBYTJ2VGVBZlAzUkYrdk1lUlh1WDh6bVorWGxoa0hX?=
 =?utf-8?B?REllRUJmRlN5WklNTDBrcmdvbCtjeXRzUEVOR3hEVHdsS2o1LzE2VUplZ3dO?=
 =?utf-8?B?eWltMldTQ0gvMWwxQ1ptM1cxYUFRb0ZldkFYbTMvUnBJSGphNzFqb0NUb2tT?=
 =?utf-8?B?bFFOazFFdWVGQ0xwZU5UV2FPZlJON1Z5YVJsV0ZxYk1CeFMyRVpWOHdaWGN3?=
 =?utf-8?B?QTNaN1FMR0lKV2VGTXIxQndjcHlmZHZqNVplQXJTYXFrQlNMcjVWNWh2MklL?=
 =?utf-8?B?Mnh2anN4My91RDQ4SkRTYUo0bnJPRG10TnJobnpOeFZ2WXg3cFZOdzRFb1hC?=
 =?utf-8?B?ZllCRTNQWmhEOFhGMVBjR05KbTNxa0xaeDhUaktqZ1ZXenZrc2tUYy9EL25q?=
 =?utf-8?B?NUpXRHJTeTdVbmlDanJkeTkwY3ZIQVBJWXZUM0hJYkt3S3pwQkRnQnZpYU4x?=
 =?utf-8?B?QWViZUVDV0xGejJpWEE1NGxHQzZsUW9lT2Z4WHBVeENBV0JyaE5pNHFueGlN?=
 =?utf-8?B?VC8vQjVFZGw5bkM0QktGNXYxR0Q4K3cxaHp3MzdpbWkvcXJpNUhGMTZta1FL?=
 =?utf-8?B?K0YzMk0vdVlidUs4YnhRa0d4b0FaN2tOWGNjWlRnWmRvZlQxdmNQM21STUF6?=
 =?utf-8?B?Q0FLOUtkNDBGNmpTVUQ3VVZNdHlodU9YQ2hCUDdQQXZ4dFlpQXk3L1dOL21B?=
 =?utf-8?B?YkQ0ZS9vMWI1d1pPakFLc1lMWkZwdmpTcWU2OFNSOXdPTVZxazR5OHNta3Ba?=
 =?utf-8?B?c29XRzhBUDZGMWMwV1Z3VzQ1TndHVyt3dUNGbkN6OEdQUzJGbVh4NjA1SUdH?=
 =?utf-8?B?cXVJRW9Ga0tsNVVKNVA4WWFUa2xoeVdrY3VldWlXS29WNmV0Rnh6Lyt2U3hL?=
 =?utf-8?B?bXhwWnBWRXlJVjFxYXV2SjlKcVQ3L0ZPdmU1dXZMRit2b1g2S1lEVG5KZDhX?=
 =?utf-8?B?MUJKMUZNZGcyZ3hweXNURzJ2VEJRall6dWphTUxZampPQ1JBc2t5QmszRVlP?=
 =?utf-8?B?bXdzV3VSNllTaXZ6bGZZb2NaOGt5QXFYT0s2enRVak1ERlRxYkdlY0JPcjBh?=
 =?utf-8?B?REZacXg0NFdiVU9KTkloQWhzTkJaNXluaEtEM1A3eXVWQmpDazJYWjUrc29a?=
 =?utf-8?B?NGVkaG5lNTVQUkN5YTlDbm83UzhWUmhqN1Z3ekJ0Q0NPTHk1RDFLOE9STWNr?=
 =?utf-8?B?dXBZbEFWVGI3U1RaZzRVNktvSDVSRnBSY3hFTjV4V3VFWUFVRzc1ZnR3SS8v?=
 =?utf-8?B?TFo3T0k0SkFFWXdyVHcya0crcDJzVGhwQUtYTytpaGs0bkcwSnovMktTdkNP?=
 =?utf-8?B?b3YvRU5IM0VxZ2VwWlMrMEl6ckVkSmJkajNxRmNiK0FwZ1h3Z2hqRmlmdWdT?=
 =?utf-8?B?bnROR1FMdjBIaWFoWVVTNTA2YTlEcW8xOTFUWU40K2c2WG52TXEvQ0RLSWcv?=
 =?utf-8?B?b2hCVUhONEZKYjhiQlVhMDVYWWYwS2U2K0lPaHJOTFF5SlErT1c2ZDRRSTgx?=
 =?utf-8?B?bHFES2Y1QzB5YnBCYlErUEJRckcwNm9udWs4a1d4RytFenZIU0JvbHVFdE1K?=
 =?utf-8?B?SkVrR0RVcGlFWEQzS2FScUhaMmZkTGdMdzlCalJFRXJ6KzRIL1U5aXIyYnpn?=
 =?utf-8?B?Q2VjWmhyUTJCRTJHTXF6VmJrL051cHZKZWFvaGorVlpQclo2SkdleFJlWmFv?=
 =?utf-8?B?Q3djSFBLanJZMTZudU9RR0xmTmk2VTU1K1RPWG83alVBWkZDNXlrUWlOOUMy?=
 =?utf-8?B?T2hhMEdUVWdOSEc3MWVlbklpQkZDZ3FHQW42eE9aNHF6S1diSnlYdz09?=
X-Exchange-RoutingPolicyChecked: dUwUvbwSK7X/GEDm37A+pbSSnGuhhyiQmxqDbFpyqpzlOWaYjA3Ylup6tEHu437OPfCqHGGP1QScP7EPL4aWxyLHR5YoHGJ6OqDGfQC0t7VcZuuxv3UVPOA2FtQzCmfKbYCBK73McUXOojZUaA+gBzMjlwVwbYwCp2VQndxHv+uAZxDBvZXvJGxroTPDxP30DW4PROdcVCIUQHTTvN/+d1xPFA9y2xvzz+0crt2OMFI8yvoD7yXkeR6ALvz3Ku4s2lIwz7q5DjmI0DnnzsrD+t60iEpOvFOl+yMAcY3d4tPtibmcROI6PDsi/WWqB9HI2KdPYjYrWo8tsvNljL9tzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb1d9e1-b128-4610-e7b2-08de839a6ce0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:27:21.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3yVFohT7Rv/rqZY7uF5At29oCuY1J1rfmNBwsIDxdVg/TnGXkSHAqiaGL5fyNQTiwTeuljMqDdJ7ByuH1OaIJW4Jt1gjEg5mH4Yvs8KDx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com

On 3/12/2026 7:20 AM, Dave Hansen wrote:
> On 3/12/26 07:08, Nikunj A. Dadhania wrote:
>> 1) Back-porting complexity: The current issue affects kernels (6.9+)
>>     where SEV-SNP guests fail to boot with FRED enabled. A simpler fix would
>>     be easier to backport and verify across stable branches.
> 
> The simplest fix is to disable FRED on those kernels, fwiw.

In addition to this,

On SEV systems, early exceptions appear to be expected in practice while 
CR4.FSGSBASE=0. So, at the moment, it also looks safe and simple to 
disable the feature until when those entry paths are adjusted to 
tolerate that case.

Currently, those entry paths are patched to use FSGSBASE instructions 
regardless of the CR4 setting. That inflexibility appears to make it 
broken in the first place. I’d take a look and come back with something 
reviewable.

