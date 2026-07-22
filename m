Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899E3B27E1;
	Wed, 22 Jul 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739366; cv=fail; b=gKQ+cK98UaVH3w9dzMu80P4XEHGD4qozoZdeOp40OPJsnT2Nvy0pqMiiJcw2a2ITPAe4TfXtSQA71u6nSwqIkwTmCGQxn3BZ2PNu35cFW2PmAfHxpxG78BEZdwC1H7qVy7e7/53QAlUPXWGB7HC2cERDFnTonpHiGXJZDvdhilo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739366; c=relaxed/simple;
	bh=Ax1MZQFTUuYch4yHbtz7T9mdp0DVjvEVJVBxpzXsMnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cl+djNPh0Alvuc5xt559lPIwf44nn8Ykg8ATg2+oYGD14zJUKg4B7MyqA05GKp6MKLhlhaNSGGw+hHmMMQ8U6hK8hlrXEmQ5aYKxNLGn2DqlmMBQKWe5Ex0XcSXXrFWwvRNRNcVVZ1AnKJXYs1tMzi3suey2HPH9Y1WfzoKtDvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVVu9ByJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVVu9ByJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784739365; x=1816275365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ax1MZQFTUuYch4yHbtz7T9mdp0DVjvEVJVBxpzXsMnU=;
  b=hVVu9ByJbSdzPrJkgZ+KvK2xya8ICy7HTfhlmQSAY/UaQuhh+Y7dRMiP
   5rikHKz1WjXelXCy4SC7VxxZqeQ18tJ+ed8oex9qrE+HECEiDffFBDBKw
   NxpzHaskzG86yq0eLHzhVRzEv5J6WH7ac3dzV3KnIgYT/BsbRLZlBdRlX
   xkdsxU4J9jQzJfGUy5MQa9zu4R4YmwNgsB3Bi/ycOs5yOFWgeP8lApQgp
   DQelESMRDZ2d23Lmxi+t878ppqL6YgGXROI63JsQRB8F5jnSUAX+Z4xP4
   6RKGE+EhaIy8GUfasu0JTybJ7mNDdm3XxN3Oyju5VfnSfE9DNlzaQWHjv
   w==;
X-CSE-ConnectionGUID: TdBGQXPITt+3/4H6EHzdEw==
X-CSE-MsgGUID: IXzmGf4STqWZGU4/D6izbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89201513"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="89201513"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:55:59 -0700
X-CSE-ConnectionGUID: 13Sbt3GGQmaa+uTVNYNciA==
X-CSE-MsgGUID: hP3lzR4wR9q5X2mcPx7jQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="255488492"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:55:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:55:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 09:55:58 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrxrQjSFytVaxykwnel0/eDpphobZ+006J8F6qvXI6ozutT3bH3dnLC94eexgoPcdJQgdiUdpyJHcQ1vLoIldqguFvy5R6SNa8f1XsIdXrJSQoOgkPQEHn0L64DVek66sSyuFkd0vqrWbVBKcz01blaa412xmQEbZJyYGA8D8J4UwkYW+lcrD/G5EPafhLXo/2v0+oThwqswDz4e8Bqk0oasVkMLB9laUfODnBiAkPLtDWOqQGmoyzDM7b6zdZ36rnF3CsdDm51e39Avq+mrg1HHbBKukC3KVeX7vvDPbiNA2LWOuXxWGHRN7EYNoojSmUCKL5DmGqYdimGpYlLWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax1MZQFTUuYch4yHbtz7T9mdp0DVjvEVJVBxpzXsMnU=;
 b=ipxBMY/Ps4NtJ4r4BCVBoIG30Bb2MbUvFx8/jh1yHL9Yiy463BYa5b/4kBXaSbUSKdiz9UXjQphAU06Y9k1J8AlzgalVTr9hDawGjmGnCmUYDenfpT0mNlAyDUq8LCg7SiuGD9dRA1/q6KnmBn3gFU1DPV9v6IoEfyrQ6SOSMajsgQR6ORpU7s22RLuwsr2hI/q7Hn/AEO5Ezme7jM6jSDzTZJoJQjNtr/sR2HW9EB6LRX+rBtS3yIyafaf9aKUyWl4Lv4e5RjChKQzVsgO2KIU4YMGa+qfXPAc21h617Q7kR/e6TbrezE63soWTxZgBrhLg7+qcK3Ig9wfjHfTiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 16:55:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:55:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Wu,
 Binbin" <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"Annapurve, Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZyy64AgAPW3wCAAwm/AIAAHcqA
Date: Wed, 22 Jul 2026 16:55:42 +0000
Message-ID: <5ef176573157b595d674cfca28923d919e54ad73.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20260718061050.E17B01F000E9@smtp.kernel.org>
	 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
	 <amDd1Ip3XTvKSTcb@google.com>
In-Reply-To: <amDd1Ip3XTvKSTcb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9206:EE_
x-ms-office365-filtering-correlation-id: 10530b39-df5c-403f-c273-08dee8121109
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: oUDysGG654cDXiI9+4q5SeD09jck29eCogwoHbCPg5/Nniiny37Bz1kRMpE6OaOWJPSc2WjM8ZBTBdx7EyTciEgPc2LNPmaIuSMM9x4dWqcEkJMtOuA+xDN2yQ0vG2s1rFzGRNQpiZpEiuS78nuX5yRkn/PEb+qxuBXRPNeBMXd5AJwkQDkIQMTJxioQT+RZbu1bxOtzScXp3F6QizC8NQ6iDZ+BnGlnSgDjkPhadJ6JoB2dTVVh8hUOC4+7iRfqyLCS45eVEuabp6K2HsL33CtlXLGulGkTlqAB8YF+cHpSSW/fNzKqLR8l4gOyhdCR4Y5CRDpFdwyi8PV+/6edC8qhORozbpeKN+sIbXMvayWSi+yNxTLBs7Gs7pEoZgOjGP7yvxYgFHfyJbRe+bBA6NrQhHm1F6bpE4lscpRajvqNTAEN4rhDXciL3TbRWYJe8OPB6ad0bKJLo+0R6QuhB4GP9XB/JmITHNcGe6QGyK/3uhtI0KSH/CohBQ8XPfvCNjIBX6DY8Tnis3AtCOGMrDJkF6DIH0oXQb+xbXAQX/FWI6XJIuzZf8O2f4VXvxV9buyXe50tn0nxR3hpROVV3yyymHFylDjDZtZGWXaRIt7OEcCeqfcQg0CuFtFrH8NHUw6mxT9qcbyn+BIf1F+2wRGhNrueCIu4AhxjOQeKka8NpaXo7jNCCE4ACRxaUtX68jVn03fD9rRzSYoSDSlJw8jhN9h/ZKFO0cQzuvvqkE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjdXRU5jUkZCQ0pJaHhyV1RwYTRNeUFaSEFQRmVuQzVLby9xSUppZmwydXBN?=
 =?utf-8?B?a2lCdnhXRjJyRmVMaEErL2dDQVVjaEdTOHh2OS92MGV3SmdwaG9LeFVmR2sz?=
 =?utf-8?B?cDNRcTBMNERtWlRBckQ0T1VyV1dKUnRCTFdPUDVhT3VmVHUwNzNLL0FzQU1h?=
 =?utf-8?B?ZVNEcVl5ZmwyUXFENnZGMFZFN0NLS2VveE9Dc1NNNmFWYkhDUVBOZTRuZ0RT?=
 =?utf-8?B?ZmxSazIycTg2YXJhdmt0T3VWenA4NEpsT25wSytWUXJyeC9tY1RJVWorOXNF?=
 =?utf-8?B?S201dFJNdXNKKzV4ZXhCYmRNMmlvbU9XNjhBS2RNeUxlbnJIK01kNGp4WkZw?=
 =?utf-8?B?SUJ1b05XV2c4WWViTmZnSTVmUVNIOUlpZEVsbVo0Z2U4U0RTU3JsSDVZcUQ4?=
 =?utf-8?B?bkp0NVhtZUpsN0NHZkkxN1B3aUhhalVHeGtTbDdkbjJrRlJtV0NWaTN2WFNz?=
 =?utf-8?B?YmEvbzFvcGp3R0dpenRFZytmZDREK3Buc0dPWFltTXR6c29IVHZMWGxwaE1q?=
 =?utf-8?B?TzJVNHROdmM1aEs1UGRvU3Jlb1Z2MTU0UXduVkptS3JSNkxLQ2w3STNzcHF0?=
 =?utf-8?B?Q1NqcExveWlWdGhpT0dRV2RhZnZnTUYzZXJId3pVY2N1VVZwWW5palBnMlQw?=
 =?utf-8?B?b3MvdSsrL05YRTVCbXlWSk1QVy9reGx2Q05hcHJiMjFEV1VORGxGdnJrVkVX?=
 =?utf-8?B?RU9BZXNTaGlNdjhGbGhWZG1nY2RUMEt2NStVVTZTV01MODVXYlIvQnVyeGEw?=
 =?utf-8?B?ekpEYkZCcThNYmRlZmFHRW5leXRTdWtQNjFFR2Z4NU8za1hhNVFVRTdKVFM3?=
 =?utf-8?B?dHhER05XcVUyaFNXL0NLSi8zVEo0enBtanVTVnZZa05zN3VxOFZHRlpReTd1?=
 =?utf-8?B?QlVOaEF0cmhYNDVWZWRaclYxbDA4MG5jT3luYlNibVg5dG1meGREd1ZwQ3lj?=
 =?utf-8?B?RmJvZkZUVm9SZ1FTZlBLVG8zNFlkSHBDSmpkWW9ZejNWaXVFaE1naUhlT0I3?=
 =?utf-8?B?QkhBMXNPNTU4VjlOaDJSd0xiRU9OS0Z0QWt5dDVaZmwwb01QcjNUbG4yREdJ?=
 =?utf-8?B?U1JEQmNBaitoUHBETzJyOVQ5MTlrbzlTVjFIcHQ1MUNOSlJ4NmYxcVpVRytE?=
 =?utf-8?B?b0xaVERHWTFLaTM2NHNRSDlza1NsQUtNNnhIajJ4b0F6T1lFTmhaak1HQm01?=
 =?utf-8?B?Z004ZGVKeEFBOVhwZGY0eXRhd1BCdkRXOUFHd0EvT0JieU84bXJESDI3c1FS?=
 =?utf-8?B?Q3J3VE9kMUhvTzAybVB3MmNsQ0dXTjBHaHhlVWlNY0NMTHBJMVZHVnhRbVR6?=
 =?utf-8?B?L25NQVdScEZ3NzhpOGdPcVZYTWNlUWxmS2JsUlE0OFN4VXgwOE5oYk1CaGw4?=
 =?utf-8?B?RXF6Z0VXV3VHYTV5QkY5Mkx3Rm1kbDV4MDA4SFlFK3BCVnl0aXZwQjRUeGpK?=
 =?utf-8?B?NzE2KzhFNUxRQUZ6RDZ3N0JuQVBKcjExU3hzc2tlc2FUM2FNVTlTMFJ6RlpZ?=
 =?utf-8?B?Y2JLWkk4ZTgxc3RWM1F4ZXlqeW5NSnIrN0JuUUJjNFdzQXUrUWlUd3F2MU5H?=
 =?utf-8?B?dEhNUnFVUlc2ZVVUdXJPaDAxaG1ZcGNyNVZkSEp1bUpXS3dTL3JBdW80b2Rk?=
 =?utf-8?B?RjF0K1RPWm4yUGo2aytWRGdTaTdSWE11Y04xMzJYWGRlMW5BdWdtcEMyQ2gv?=
 =?utf-8?B?K3lVSXRLdjVIL3grRm1RS1M3VC83a2kzVGE2bnN4SnFBM1RWUXI2amdLcUpm?=
 =?utf-8?B?ZDFaTTJYT3ptZWpKSUVxQlZaUnFLWEJybE5vZmZWN3psRTRScFRWQThKSnU3?=
 =?utf-8?B?NEdOWTZrby8xckRCVHBXOFBNNnZhZ0VZU0EybHBmcmlJVFRLTnpTWkxEMVQ2?=
 =?utf-8?B?b2ZyNWw3bnBIY0lGVThjZnNnNHVpbldNRlI5NnZ6aEk2MXlHdkY1VnltWFFu?=
 =?utf-8?B?bHYrNmpUcXlCR3I2bnpnaHcwWElwcHFiVG5mek02QkxrWTUxQ0lOR0pIZytx?=
 =?utf-8?B?VDl4WC9odElUOEdWeUd3Y2QrdVdWaUxPSXRtMGpnYXpvWWU2Rll5Zkg4aGQx?=
 =?utf-8?B?QWdncnozYmM1MVZ3R0doYlUxSzlUL1hkU1AvYVVwb0xleUdOTzYzbFVHTXdQ?=
 =?utf-8?B?NTZhWlVCcXEwT0dsUTJvTXpwbmVxaWpSYVpRUlhyNElzN3JHT2J4c2tmMWFw?=
 =?utf-8?B?cDgxSW4rRzVlbEx0emFYV3gyeUEwM3BBVmpVMkNaWGFWRWdVN2hzdWZZTEVT?=
 =?utf-8?B?cVdHNVU3NnpyaWFWb2VRNVFrZkdDYVp1U1dNR3BkSG12MkxHaEhYbFhrL29l?=
 =?utf-8?B?bUJ2NTIwNEJjcWR4M2NKN2RiK0tQSTUrMU14MmZFenBuNG5YQ3N4dTBmK2Rr?=
 =?utf-8?Q?03vHAlH3WaWiJQNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E14347AE36FE0A488C31758C6F38B809@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ndmgvK2lpygXZudn94EWvjietMxYCGIFnTA3Quur/MgEh8bmedjvgydf5crAMOPkzT15VkR0LX4Hliuitj6CT83ZNE2htLT1HC0pccnH8wjLO9DzK7p4X7E9lMmdFeOhZi+BSldz1ulgyNESoqe52dfsRjjMOSi4VyuTdOFrpE6ZuR0bk3iS2lHXx/EKNirNOZBE+giXGS/bKi9VO0+4zZtktaI5CubTI5+BNKXtIYqCZaZ7FE7hIhTDtYE53Lmx27Qo3duLrA3tTvi+Y9VpfveB5bNp/yKSjV+96iA5pm/q4dggoLswLMis/oj7vZCFDrlueJeR1c8WuB8zQesdbg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10530b39-df5c-403f-c273-08dee8121109
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 16:55:42.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLA8HyRIQldkIYHZ0VHJa9NUoPJ4DmiUk++Yy+zCCq2LT+IHlgcDT4VGe5C8vrJylQdS6ijZ0GO+mZ5U2yt5La1tRk8DJjq/KUKXpWrVass=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDA4OjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBIbW0sIHllYWgsIEkgdGhpbmsgSSBhZ3JlZS7CoCBTdXBlciBkdXBlciB0ZWNobmlj
YWxseSwgdGhhdCdzIGEgZml4IGZvciBhbg0KPiBleGlzdGluZyBmbGF3LsKgIEJlY2F1c2UgdmVy
eSwgdmVyeSwgVkVSWSB0aGVvcmV0aWNhbGx5LCB0aGUgY2FjaGUgb2YgcGFnZQ0KPiB0YWJsZSBw
YWdlcyBjb3VsZCBiZSBleGhhdXN0ZWQuwqAgRS5nLiBpZiBzb21lIG90aGVyIHRhc2sgbWFuYWdl
ZCB0byBmcmVlIG5vbi0NCj4gbGVhZiBwYWdlIHRhYmxlcyB3aGlsZSBtbXVfbG9jayB3YXMgZHJv
cHBlZCwgdGh1cyBmb3JjaW5nDQo+IGt2bV90ZHBfbW11X21hcF9wcml2YXRlX3BmbigpIHRvIGFs
bG9jYXRlIGZyb20gaXRzIGNhY2hlIG92ZXIgYW5kIG92ZXIuwqAgSW4NCj4gcHJhY3RpY2UsIHRo
YXQncyBsaWtlbHkgaW1wb3NzaWJsZSB0aGFua3MgdG8gaG9sZGluZyBzbG90c19sb2NrLCBidXQg
Z2l2ZW4NCj4gdGhhdCAoYSkgcmV0cnkgc2hvdWxkIGJlIHJhcmUgYW5kIChiKSBrdm1fbW11X3Rv
cHVwX21lbW9yeV9jYWNoZSgpDQo+IGlzIGJhc2ljYWxseSBmcmVlIGlmIG5vIHdvcmsgbmVlZHMg
dG8gYmUgZG9uZSwgSSBkb24ndCBzZWUgYW55IHJlYXNvbiB0byBkbw0KPiB0b3B1cCBvdXRzaWRl
IG9mIHRoZSByZXRyeSBsb29wLg0KPiANCj4gVGhlIG90aGVyIHRoaW5nIHdlIHNob3VsZCBhZGRy
ZXNzIGlzIHRoZSBjYWxsIHRvIGt2bV9tbXVfcmVsb2FkKCkuwqAgTGlrZSBjYWNoZQ0KPiBleGhh
dXN0aW9uLCBpdCAqc2hvdWxkKiBiZSBpbXBvc3NpYmxlIGZvciB0aGUgcm9vdCB0byBiZQ0KPiBp
bnZhbGlkYXRlZC9vYnNvbGV0ZWQsIHRoYW5rcyB0byBob2xkaW5nIHNsb3RzIGxvY2suwqAgQnV0
IGFzIGV2aWRlbmNlZCBieSB0aGUNCj4gcmFzaCBvZiByZWNlbnQgc2hhZG93IE1NVSBidWdzLCB3
ZSBkb24ndCBhbHdheXMgZ2V0IHRoaW5ncyBwZXJmZWN0LCBhbmQgbGFjaw0KPiBvZiBkZWZlbnNl
LWluLWRlcHRoIGNhbiBiZSAqZXh0cmVtZWx5KiBwYWluZnVsLg0KDQpTaG91bGQgd2UgYXNzZXJ0
IHRoYXQgd2UgYXJlIGhvbGRpbmcgc2xvdHMgbG9jayB0aGVuPyBPdGhlcndpc2UgdGhlIHJlYXNv
biBmb3INCnRoZSB3YXJuaW5ncyB3b3VsZCBiZSBjb25mdXNpbmcuIFRvIG1lIGF0IGxlYXN0Lg0K
DQo+IA0KPiBJIGRvbid0IHRoaW5rIEkgd2FudCB0byBqdXN0IG1vdmUga3ZtX21tdV9yZWxvYWQo
KSBpbnRvIHRoZSBsb29wLCBiZWNhdXNlIEtWTQ0KPiBzaG91bGQgcHJvdmlkZSBzdHJvbmdlciBn
dWFyYW50ZWVzIHdpdGggcmVzcGVjdCB0byB0aGUgdmFsaWRpdHkgb2YgdGhlIGxvb3AsDQo+IHZl
cnN1cyB0aGUgcG9wdWxhdGlvbiBvZiB0aGUgY2FjaGVzLsKgIEkuZS4gSSB3YW50IHRvIFdBUk4g
aWYgdGhlIHJvb3QgYmVjb21lcw0KPiBvYnNvbGV0ZSBhZnRlciB0aGUgaW5pdGlhbCByZWxvYWQu
wqAgQW5kIG1vcmUgaW1wb3J0YW50bHksIEtWTSByZWFsbHkgc2hvdWxkDQo+IGNoZWNrIHRoZSB2
YWxpZGl0eSBvZiB0aGUgcm9vdCBhZnRlciBhY3F1aXJpbmcgbW11X2xvY2suDQo+IA0KPiBXZSBj
YW4ndCBzaW1wbHkgY2FsbCBpc19wYWdlX2ZhdWx0X3N0YWxlKCksIGJlY2F1c2UgbW11X2ludmFs
aWRhdGVfcmV0cnlfZ2ZuKCkNCj4gaXMgaW5oZXJlbnRseSBmdXp6eSwgaS5lLiBjb3VsZCBnZXQg
ZmFsc2UgcG9zaXRpdmVzLCBldmVuIHRob3VnaCB0aGUgcGZuDQo+IHByb3ZpZGVkIGJ5IGd1ZXN0
X21lbWZkIGlzIGd1YXJhbnRlZWQgdG8gYmUgdmFsaWQuwqAgRS5nLiBpZiBzaGFyZWQgZ2Zucw0K
PiBzdXJyb3VuZGluZyB0aGUgdG8tYmUtbWFwcGVkIGdmbiBhcmUgY29uY3VycmVudGx5IGludmFs
aWRhdGVkLg0KPiANCj4gU28sIHRoaXM/DQo+IA0KPiAJciA9IGt2bV9tbXVfcmVsb2FkKHZjcHUp
Ow0KPiAJaWYgKHIpDQo+IAkJcmV0dXJuIHI7DQo+IA0KPiAJZG8gew0KPiAJCWlmIChzaWduYWxf
cGVuZGluZyhjdXJyZW50KSkNCj4gCQkJcmV0dXJuIC1FSU5UUjsNCj4gDQo+IAkJaWYgKGt2bV90
ZXN0X3JlcXVlc3QoS1ZNX1JFUV9WTV9ERUFELCB2Y3B1KSkNCj4gCQkJcmV0dXJuIC1FSU87DQo+
IA0KPiAJCXIgPSBtbXVfdG9wdXBfbWVtb3J5X2NhY2hlcyh2Y3B1LCBmYWxzZSk7DQo+IAkJaWYg
KHIpDQo+IAkJCXJldHVybiByOw0KPiANCj4gCQljb25kX3Jlc2NoZWQoKTsNCj4gCQ0KPiAJCWd1
YXJkKHJlYWRfbG9jaykoJmt2bS0+bW11X2xvY2spOw0KPiANCj4gCQlpZg0KPiAoV0FSTl9PTl9P
TkNFKGt2bV90ZXN0X3JlcXVlc3QoS1ZNX1JFUV9NTVVfRlJFRV9PQlNPTEVURV9ST09UUywgdmNw
dSkpKQ0KPiAJCQlyZXR1cm4gLUVJTzsNCj4gDQo+IAkJciA9IGt2bV90ZHBfbW11X21hcCh2Y3B1
LCAmZmF1bHQpOw0KPiAJfSB3aGlsZSAociA9PSBSRVRfUEZfUkVUUlkpOw0KPiANCg0KT2suIElz
IHRoZXJlIHNvbWV0aGluZyB3ZSBjYW4gYWRkIHRvIGNvbm5lY3QgdGhlIHNsb3RzIGxvY2sgdG8g
dGhlIHJvb3QgZnJlZWluZz8NCkxpa2UgbWF5YmUgYSBoZWxwZXIgdG8gZW5jb2RlIHRoYXQgcnVs
ZT8gT3IgYmV0dGVyIHRvIG5vdCB3cmFwIHRoZSBkZWxpY2F0ZQ0KZGV0YWlscz8gQSBjb21tZW50
IGluc3RlYWQuLi4NCg==
