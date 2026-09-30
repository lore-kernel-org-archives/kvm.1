Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEF4756C6;
	Wed, 30 Sep 2026 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808744; cv=fail; b=W1g7Uq7hLP2+Vpphy/bsbM5Ck59fl9CP7o+dvJ4apM6h+VmnQEC5t0Hu4BCFBEikncsIrx/BphnLZMeu1CNa70Y2Fj4yAQnnyq3yCpzVWayxa1HT3v7x+wE6/0ugCJerxefeDk56y7reuoMN2IgM4opN4gwCardvlx6Pz/nVhXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808744; c=relaxed/simple;
	bh=4ke0Ie6he1eyf39l1FWGs5PE/itwEHOTQtLCWYjKdDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAPMjHNVaFMPwkP3yCa0+V2YY/QaAtllUuv1T2f+eVBCnfU14VUhjW20BJmHnHGZmcmQoEhEOIJ6a2vJX4pkZoMq20fuH4Z4N3NJ7RBJp1L57yEqBeYeqTBU4MLyJuJWQWbpz7ibnCvP1vCwAZ/1Nzp7S9Gx4NZrqsa9ABRjiek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLTU1lEv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLTU1lEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790808743; x=1822344743;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4ke0Ie6he1eyf39l1FWGs5PE/itwEHOTQtLCWYjKdDw=;
  b=aLTU1lEv7tzzn6WrwPrPlGH3ok6/IyukdvBJhUzpXIps0nM5YSUx9KW5
   S7mG+5zNzCfo6yzXKPlFivA0I2OFDP20lhnu0oi/fMTzHFHJkQjUB+RqC
   2iJBJTfHRFx2l1jXybLvXI2b51sMbNUeCP7lpuwYTq1GiHANdkxm0QNy3
   TobPRsRbwO+aG2RS0u/kBwII3cbCWw4gOidZeqtlpcvKhrv5Km+tFklEK
   MZPfItPghH0su6KnRzY6dLAm7FXRbFM4sv8/y0T36JlurfK8rIgWILvz8
   QtI5kHI1Ub2OWkAh+xDwTs4QsJi8C4enzibG51keVkYxUgeVbHlbeFRVx
   A==;
X-CSE-ConnectionGUID: EremD0vNQJSqNW64ocqh8w==
X-CSE-MsgGUID: 2rJ3gWTJQduuZZ1Odot0mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91574229"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="91574229"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:52:22 -0700
X-CSE-ConnectionGUID: 73rjJg4yQfOvAQYGmh1G9A==
X-CSE-MsgGUID: 8SiBv9VYSf6HL5bpRwkRpg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:52:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:52:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:52:21 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynPBA74rk+4KOVaK3+pQ3N9YkucsVy2rbmeSN7ibYwle23IPG4qEoUBzjZog+g/n5Gb4KU0UrAfLiWVz05rP/v+i3EFgq5p8x4CBvKeh0w9oEhP6gu2hbDdPXY5kXPi1ZDuDy6JcACTfm/HpfyYZgS4GWnfBIZ0K6GqwnUez6dac/GzPgqalOZLBl3dMBPRcwRNhEniEMnSWakdq+89wvEBRlKGN465BUa+F2nCEf4v47WZfkxahk5s6Cqx2mVerdF9H1bqxaNAOmwCwG/yy6rgV3d4KOWoq7rn2Rgu3Xq8R5wcgpsYs4IkuEiags1z7ng6VS1SdbJlxZyB+Ql94og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO4NVY7Zz3wAvw7uNJiOk0xOmSASbWH9D35Q23dteEg=;
 b=p0b1NhGODQTlEFEYoG3dtLuyLaICLkmukanLfNR9GvUg58DbHLIt7e5/4EkiiCFNnQKk9/lSeDlCKz1Occ3BpILbgFKhJR7j7GnGUv6Scg0A3XhHAUG2QPmYQ8QN1o3jjvAdMFI8Bjn2Emq6LUL76kFCh+JbuuH7apsFTjRXsQOyLDH7fpf9JviosIJGFi0lI/eyz4919epqbwDkfbZ8OhRHl0pIXnkNIEIqcPLOHcxcEpErkjg4sCIwTyg8DKo9vrA0vzA2dxAyCrSb4ozGXPthnyjAxgbIwPZWxeELJZ3Kmgnh7iWPHVWLPh3Rxn6JNPN/nSkMUMfXASVT6XF6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MW4PR11MB6570.namprd11.prod.outlook.com
 (2603:10b6:303:1e3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 22:52:17 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 22:52:17 +0000
Date: Wed, 30 Sep 2026 15:52:15 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Message-ID: <ar2Sn1ZiDQdygPPn@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
 <20260930103739.2851980-5-peter.fang@intel.com>
 <007f5865912a9fb40c0e3a1ca9b7bb36d8af9794.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007f5865912a9fb40c0e3a1ca9b7bb36d8af9794.camel@intel.com>
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MW4PR11MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef90161-aa02-40e9-eb8a-08df1f457a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|4143699003|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vsGN6D7f8UiU3IKuTup5ri2dtGJfa48jzj5UwoxIO7nHqfV16a0urpYFagntDipSi+CF3K60hI1+YICjRzg6TNM47oge0HEcJZdqUTwf0Z/prDvi1QoNPXrPzjv2kb1b3ok5dSkRxeXjYmCxs+Wl82LhZA2cChAK5b8bJzRlkWB99eDDMNabpsIM1qZb1CtpuXODDPFuWzCq6MnEtuDlDBScnoRg7s4MFtPjqh8nXjc/kg2AwYx3hRji/vnH1Yzi4F2rGKYKpfWYSkCitYg/yOcHTgGZJODOb6kDT1YA0qVNdqIDowzWm2SI8SyfitgorjYp42gB0dDnIMfsEA8ssvQL2A8p+BOlSKurrFpE7cKvkrQXusc8UeK0PJAbJ9IIv01ffIMWuAH6EM/pE3pClYqn9mFo6XobJdPLcctYnK9tFEokYt42+LltJ7eC85g+iWsH9hIlsRsDmWNHkAVP99uvpxVznsYV0RGDRd5X33GoHPKOnPqTuhgqU476Sll8s8ETRMKV77SHw8HNdbsBm5S8jmx26kDmHq9IIGlYqifHGSyhYsRYyGJvzigcq9z+5ZEX9vrKu7Km7MF/I+h0D4yO7NsucUT307QimDYY55BXMo5Ag2w+TPS19wmUXzajvTQlkkfGsEWj9rFrOkAs3hPfE5wVV/TvuaJ7rSJEjug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUcxdU5CS08xMXJESTVCd1pxL2E1MGRDWnN0Y1h4My9XdGNQZnk1eEVuNk9l?=
 =?utf-8?B?ZG1zY0x6MStVSUdvZ1oxNVFWN0pFM1hqQ1JmSzRtSkREMzVLcUNZYUF1Vk5k?=
 =?utf-8?B?d3V2TU55d1ExRHVQTnBzNGpNNEVUMEhuTEduaURueXUwOFpLaUtwUzdiTDh4?=
 =?utf-8?B?bWt4YW5tQ1VhdHN4SGFUU2FxWUpwT2x4SUZMZWhVUzUrcVhyV2VuVS9Sd2J5?=
 =?utf-8?B?dmgvNlJEUm9EN3M3Rlg0bFR3cjNRNllmSE1OYmFxSWw4ZUJBNmYzcEd5NVdw?=
 =?utf-8?B?enIvVjFNOThUSExOS25yQUxjaEhPMS8yU0FYamlBdkxBYUNjM3k5eXlBSUpz?=
 =?utf-8?B?Tk1qa3k1VkdFY2d3Rjd4cUJRaTQ1dTJvU252cVNCUWtsK3lXRDA4cm5Od2xi?=
 =?utf-8?B?RzRkRGp5VmlhcVFRdTA1WDYyRGdvczFSZDdkUDE4STQvVWhVUThsaGpMMXIz?=
 =?utf-8?B?K1k3ZlZGd3JsUHVuVko0dnVMdGxRa3VvZjdTUkZlcEV2U082OHVTQy9aUFAx?=
 =?utf-8?B?eTQ0MjM3THAxK2o2cTY1ZkJZVVlSMmpqWU9LRFQ2S3FVc2pDMzZDOEtxVVBM?=
 =?utf-8?B?eFU4V0dENk1zYjI2V2N1TldjcWc1ZjNkeGllVWhCTWpwalJwRTdzbHpYY3Js?=
 =?utf-8?B?cDNtUkZ2dXgvRWJYb3RBb1NGVnRTMnVQcFVFSzNoTXpLT1VwQlpuYzIwcEt6?=
 =?utf-8?B?TjY0ZXJieGRTamIyRHJod3BNK1NFVExka3lMckR2QVkvVzNKYTNoTmtPU0tr?=
 =?utf-8?B?RXBObUlXc0JGbEFxRGVtdFg4dUZxRS9SZ2NBcUlYMHREaXUvUEF3bVN5Mk95?=
 =?utf-8?B?K0dCanN1LytTcmI4ejJIL3o1QjRJTW5BdUNFVHhnNVpRV1c0NEhaNTNZZU40?=
 =?utf-8?B?by9vcy9vMkw1NGtEVGJPOURzcTNaOWVtdk1CQ0JPS1gzZUduNU5uYWlWcVUz?=
 =?utf-8?B?dzVEZDVpc29EQ29MTlJOeitvYVNWOTJFZ1ZmN25SN2ZWdElqRzFpRGdJZnJU?=
 =?utf-8?B?K3pIOTdpdDc0T0V1dkRqQ0NVTC9ZV2pldEhiZUp6emhndWJwem5obkxvTHdF?=
 =?utf-8?B?ZVRJRWwrMW1MaExBSlR4VDZrUkpxc0VJUStOd2cvZW1obnEvTUJyOEtYSXBC?=
 =?utf-8?B?b0lGbHhqREU2NW0xbVNSaTR6MGpmazBCQll2aVd5Nlg3RThBdFpGK3RoNXJ6?=
 =?utf-8?B?MGkwcEJXSUhGdVRIL3FrTkpTbFk5VFpOTFAzeUZtemh5WE91eWdYNDV2azYz?=
 =?utf-8?B?WnVmR0RZcE1DMnkwQkFZOTltQk14V3NTbTZhZmg1L0FlTEhJVmM4NnJUSUtM?=
 =?utf-8?B?N3VVRS9mbklzWkQvQmdFOHE2QzgzbGpDTnJGNnJSN2p4OFdnejM2Vmh2T2pV?=
 =?utf-8?B?bkJ2Zk1aTUZKejhnbmQ2SmtNZHlmNUxVMmIzSUcwNCtxL0c4UkZXcG9UUXht?=
 =?utf-8?B?dzludkMvMXJlQlYvdWpMRUw1NVFpbGZwWFdnUjBjWnhmdjdmenF2eHQ1d0d5?=
 =?utf-8?B?Sk1BYjBTZEZUaGQwdnU4cXdEbW96MlVLVFhkRnVYNkxWOXBXMmdidzJ2T3dC?=
 =?utf-8?B?cXozbWFZK3JyRXl2bVM3ZDJWNytJRE43Qms4TEpWN1lLSlZHMjhLVzFyaThm?=
 =?utf-8?B?OXlXWWZLL2xDa3kxUG96Y2YybHQxS0VsNTZkWHdoOEk2Q0cwbS8zaFlSYkJ6?=
 =?utf-8?B?cnZrZmVSUkVocldCWXpQN0VJSG9BOGlvem9SZXNrRWtrdnI4a1U4ZWtGWGFs?=
 =?utf-8?B?RVArMTVHNFh3bVZVMXhrdzRoVkJWZ1kzVXhFc0E1MEhGNFJXN2x4L2F5Um1F?=
 =?utf-8?B?OXIrUlczaTBuNjdPSzlaZkU2RithVnZHN09iNzhpQTBmM3pWZ2QwSHRWN0Iy?=
 =?utf-8?B?K1poQVhwSmU2YXdpUG1qcjVQNkRHRXJFTVhxRHd6bWdDWXVuVEhKSEV0ck9q?=
 =?utf-8?B?SUtRY2V4czV5K3gvSWhoMzJZd1FBRUcyVkZOTzNrczcvZGMrQmFtN05GWUQ3?=
 =?utf-8?B?KzJuMzF1WVV5cG42TmVRZE9JV1QwdlR0RStOM3p4dElTNDM3YSs3aUN3aUw1?=
 =?utf-8?B?RHdlT3IrNzBRY1RQWGYwbzZIUkQyMDg5L2FESm1BSE13NDVCY2k2UXNWZHAv?=
 =?utf-8?B?WmM3c2dwMk94N2lOWVRObzZIWHNHOUpUb2E3Z2hhNGVLTjdjTms1ZFFNaGNu?=
 =?utf-8?B?NEhaOFJTWXdnRDg4TFpleWVjVElkNGErMUZGSnVqL2xudHhEZjBsdGx0WVhm?=
 =?utf-8?B?WncxV3J0cXhQWFhBcXZuMzQvRXUxcjgvaExhRGlxWkxHWWozUXNid2liRXNY?=
 =?utf-8?B?REtiak9OYTNVNHc2UVdnY3FjWDc5YVhFSTFTWnh6ZHY2RiszdXl6Zz09?=
X-Exchange-RoutingPolicyChecked: Mz44xxBwY3qH0S6MlkzIFiKMZ0L8rnFQYrHRkMiLmcQkZwtd8eXfonB8VqAJk8oHMyfkPrPcPQPTqNfePJEUnikbneTy2p3eXwUM8I1QYezu6Hq2ZufYwhW+8KMen0vfzOaJo3zNL0jgt82IAo8pRxOFJA+NiNUCp9s1rz1xbESY5Y2nmSOCG2zN8NAfbberWoUQfbZ3RFRCNxpzYmNf5R336fe5O9P9DQrZ8gn2quKSxp74ZtpWM5vtvmiaxzOhRFtcFJsh1ZgGb+U4iIeY0U4PRhYcFX8Bc/4e9PBhKBSPCIW2FGQXvuKe5AQy9uLSj34BrglsGx4NlaNyf7PBMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef90161-aa02-40e9-eb8a-08df1f457a27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:52:17.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQlT/rKWbZVDksJdgm1ThxalTCAO7eWL9bEI1JYQ8urC7tSKqZHd0XjT+UMq9T4PJyspYIcS93xFfXGC1E34nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 03:14:14PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-09-30 at 03:30 -0700, Peter Fang wrote:
> > +
> >  static void free_quote_buf(struct tdx_quote_buf *buf)
> >  {
> > -	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> > -	unsigned int count = len >> PAGE_SHIFT;
> > +	size_t alloc_size = PAGE_ALIGN(get_quote_buf_size());
> > +	unsigned int count;
> > +
> > +	count = alloc_size >> PAGE_SHIFT;
> 
> Why change the count to be set outside of the declarations here and below?

Ah good catch... It was previously in my tree:

        size_t alloc_size = get_quote_buf_size();
        unsigned int count = alloc_size >> PAGE_SHIFT;

But with PAGE_ALIGN() added it keeps the reverse fir tree order. I'll
fix it up. Thanks.

> 
> >  
> > @@ -266,6 +276,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
> >  {
> >  	u8 *buf;
> >  	struct tsm_report_desc *desc = &report->desc;
> > +	size_t quote_buf_size = get_quote_buf_size();
> 
> This local var is a performance optimization? Or a line shortener?

Both I think. Calling get_quote_buf_size() 3 times in this function felt
a bit much. Should I drop this?

> 
> > @@ -292,7 +303,7 @@ static int tdx_report_new_locked(struct tsm_report *report)
> >  	if (ret)
> >  		return ret;
> >  
> > -	err = tdx_hcall_get_quote(quote_buf, GET_QUOTE_BUF_SIZE);
> > +	err = tdx_hcall_get_quote(quote_buf, PAGE_ALIGN(quote_buf_size));
> 
> The point of leaving page alignment to the callers was to not churn the existing
> code in this patch. But this caller is getting changed anyway for some reason. 
> 
> In patch 6, it changes to the dynamic buffer, which might not be page aligned.
> But what if len passed through the GHCI call is not page aligned? Does it cause
> a problem? Oh! GHCI docs say "R13 - Size of shared GPA. The size must be 4KB-
> aligned."

Yes, and it's documented in tdx_hcall_get_quote() as well.

> 
> So it needs new alignment only because of the dynamic buffer, and to fulfill the
> GHCI spec. Or otherwise I guess you could claim that the page alignment is added
> here because it was always required and now it's too hard to see that any
> possible size is already aligned. I think it's weak. I'd put it in patch 6 and

I think my original intent was to make sure all the PAGE_ALIGN()'s
appear in the same patch. For example in alloc_quote_buf() and
free_quote_buf() it's easier to see PAGE_ALIGN() is needed by the
'count'. I thought about adding a comment above the
tdx_hcall_get_quote() call... But that function is already pretty well
documented.

There's an existing inconsistency in the driver. In alloc_quote_buf()
and free_quote_buf() the size is PAGE_ALIGN()'d despite
GET_QUOTE_BUF_SIZE being 128K. But in tdx_report_new_locked() it skips
the PAGE_ALIGN() when calling tdx_hcall_get_quote().

I'm ok moving this to patch 6. I'm a bit concerned it would make patch 6
look like doing two things at once, because Dave asked for the feature
itself to be contained in a single patch. Do you still think putting it
here is too weak?

> explain why it is now needed at that point.
> 
