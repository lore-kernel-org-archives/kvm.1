Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FA2773D
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123270; cv=fail; b=FZQqCUBXsM00Ji6AnkVySl8jsymS6GrCJKlHrTEUSieuk7VLcGabRHE/pECy0wDIToGAYwZfmIciVWTG94QlvEtZutgQ8mvwFt0q5njq+LVSn/qcae3EgzwIUgo7Jw6lDE8IkRvLXHgjSQpo42t0s8VNM5XEsBvGhjEC34Ty4+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123270; c=relaxed/simple;
	bh=bPJGybqRFNWz4HO0av0SWMJLtI5nwIhC4zni6ratxfA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L8y3homJGYD5gOvWlVJIJpJ6jcbSoFrZWMZBEHRBqVIi0dEdeF2Bkc4lleqBKFY/cLFjEYGIJukii0otTrm5I/LFj+EZE25rcRJcosBDY1SYcWHlP4ZzQSPeDkIH5cF459ZAVZeWISFzABEXMaSfdwyJuMEIDdYNCcacYUnpHQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxvjORG8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxvjORG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792123269; x=1823659269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bPJGybqRFNWz4HO0av0SWMJLtI5nwIhC4zni6ratxfA=;
  b=KxvjORG8IKR+aVS34h8cs4OtaPhI142Y2MQv5vEtq3Rz9X81RTB2bHLx
   CYUGQpMLAS8fMfR+1A3PYpDEdXj+eXzeVMyEMTA7pf/XqM/yYYqDIeszm
   U/evEsi7t1Vr3PIKhEOnt98mbUg8zKZ4QQUj9d++O+qMveFHGz8VpF4m8
   iCy3GeT6oloHqSAsyZhCjUPzN/2DJzkg+ZRlKG+h3VUMT+FJg5jZjaAr5
   O4q7F/oaGL9UYgHZBgSqHth/RyZLtmvARJmWOIenZno+1sThI1t56RNiZ
   ixTX9ERRTdHsAOz+euEfpf21MhNKs4Kl4holdaOGWm/vOvPNpklBeTZh0
   w==;
X-CSE-ConnectionGUID: HX5L+zW7RaCHQAIQJwLdTQ==
X-CSE-MsgGUID: A+uiprlBT42OfuPUBnSLUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="915292"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="915292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 21:01:08 -0700
X-CSE-ConnectionGUID: Y3LPIRiGRqG6BYmHdz7KpA==
X-CSE-MsgGUID: 2kzYt3HNS9eWwf7MbnVSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1836866"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 21:01:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 21:01:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 21:01:06 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 21:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpQ7XzU+5pgo4iix1c6SNtcSaNAYzMsKa3x4VcKQPR4EVETZvsYp2EiX/Z6kD7CXE6VExhdgVeG38KQ7XdyMH/IFMtBb3FSjvw6kn+ujG2aFhDKcZXqCYyJiskelklH8c9C1jWrSvHdJMasS14PSOH8sW8es+xiM81JnXnfpXQVHgA58MrGnnzVzfLM6SqePBV171vnr20hrcORz+bw0SwK4lGJTj09AtmWHNv9LPlHuzHgyId3r6++X82GB0aCDi5m/vLG0cLeiZA/XzL1cYqbDroVOsTwNNn53BmC3G7nYQlx2hCsYl9rQZ1XSz35gcV7Rafhy3y1HackQ8jpSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpyNYBhKFzgHQ3QcVGf2w7PYFvKya0yYNgB0rjyHkC8=;
 b=ixNtLGfO3WoJ+GTFIMxlH8oBk8pNwRCKDj5l8WD4yJNxt5WVhI+hpy1wIJvZLA5WuB03OZjrj7kbI2vZxVf9+vzMCeYN41RqxmzqDO7dpvQC66Cn/oRj+Mf0iEKAUe306txxbT2I1pHWAFyLae8hakPQuBUASjmKF72t5fHW+Tr1TrJmApJJdkFPVrpKJqR9JZyuZZ3EyF43V3Y4+2i6sHrjJhh2tTcBnjaRzd8+6FGs7LOS79KnVS9EDUl6d/zi59AGOcTVNnILkN9T1TI1+QFQLAZMAd1xSWerkIWHA2MCruSwoLNDwDUlmJhXdX4btsrylHsZwnREwgznrmKu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Fri, 16 Oct 2026 04:01:02 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 04:01:02 +0000
Message-ID: <72a59726-46cd-4e52-bd75-3ec63df35da8@intel.com>
Date: Thu, 15 Oct 2026 21:00:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>,
	<mathias.brossard@arm.com>
References: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1> <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
 <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
 <arN20-sGytS6BlZc@tlindgre-MOBL1>
 <b6afcf8b-5cde-4c70-93fc-86127d1884e1@intel.com>
 <arTOBQXhqcVVSyr7@tlindgre-MOBL1> <asdgy2sGInTGZn59@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <asdgy2sGInTGZn59@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|PH0PR11MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3658be-1c99-462b-cdbd-08df2b3a17ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: faJvmYjacnbpfJTKK1Jc7QltroEqpoiwXI3HUjtZa3n+Ki3hoMzhgODyqmjGaw5oILamzAVP/OJhki8j+f5K1l2gpGI+a/eSYHINSz9SUVMk0G3rI7SQ4LN85MjZKINh4e415SWKs6oiqnj9/9Pvl2lcRNkazlqIyjSS015XNV+PXMgcxCz14/XdY3P7hlyL4KSRGrbeQ6HnxUh8OvMD/fPIJLh95TpKT+rA3ML0v10Y9UTXRE+mVC5emSVOnpbu3Y9URkfwZxdFTPbrCPI7ilV7PCSnXwT2z3LUqs/S7fgDhcVYX8Rvci+pfIFMpdUmYxUrJVJ60rVztx41jLTdz3/zZfekJ4zC1Lw1FqD7DUhRoSshhpV/lYJMYrjA9VxBt6/m4cOkELtzXFxmhsFTUbLqYG/hL2By8WK4j/Xke9Svwp/ajyfpGGG/J0Pvp5m5N2VJWDPM42szEdOfQMMyfP3Eo6+tP3tKWl0ZL4LXNYJYwDOdaGe7L+GR3g6uemOJ1L1QqiS2tATWcp4z7yEChPKrtKA4aI6RN8PvjBlZD9EESITxo8M1dMr6uJ6qGzRPOLSuGUsl8AQQofT1ThBQoYtt3SVSpgR2ASIF6OqHNj0OH+ilpDDI6jXJkw1sqpFmne3XHNvXfiGguE5ouvAz11pvu31yvnx7BuD0LHfiXGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFuTkpSb3NMSWFQSmtuRlVXSUk2SmRpUGZGSGZ1WVhuVlVXSlViUTZHSUU3?=
 =?utf-8?B?UzdWS29NdXZPa2hiZi9NNXJaQ0M4N0paS2k4TWpUdnFuYWZrUldFK1F3Vk45?=
 =?utf-8?B?Q2FPWmtObUdhVklaK0NnWkRpVFpKMFZOL1lrc1JEUnhMbDQ3aEtkYmp2TjdU?=
 =?utf-8?B?THE3VmpsSE5xRGVreFhDMzkzUVZzdWFUemhiZWhRM3lSYkFxMG4xNUovZXJX?=
 =?utf-8?B?eXBNMjkwU205MlhaTXpoK2tUYjFnZ28zOWpBTVkxRCtJM3BQNnhuR1FlOU1p?=
 =?utf-8?B?a3ZBNE9xWnAvckpueUgxa0N4dW5Lak9BZW8xM1ZyZUh1RmdCaTg5RndoLzJn?=
 =?utf-8?B?Nm1mcnE5aVFpRU5wSUlKTVg3Z0g2dFN2eEt3MHArN2NqNDUrTmFLdVFMcnh6?=
 =?utf-8?B?Y2JtSFQ1ejFMVksxRUYrNTJDSGo3VEVlL2lnNWtYdGF6cXVmWXl0YUNtMzRI?=
 =?utf-8?B?MWg3d0pva0RzTHVkZk9ScllpdFNVRGIrbzJBc0xlUkNub3hXQlZqemFXSjJC?=
 =?utf-8?B?Y0NLYXA4QWtaRFdWOVdlMi9ibUQvYUJsOHRob3VBaUd5ckpZOVp5LytTTFBP?=
 =?utf-8?B?Qm5LVWVwL3M3RytRZlpieXloVEtnV2o2cGQvcjBoUHRzTit0V0swTDFybFhz?=
 =?utf-8?B?eDJiLytmTGZYVGd6VGdqaE1EeHhxdVVUTHFkZ2VHK1dmWmdDMDZ1NVlYcFlh?=
 =?utf-8?B?VE5sZk5QdHpQUHhiUDNGbk9RdHl4ODlmK3I4dWFVbzRpdlBTL281azE1aGZD?=
 =?utf-8?B?R3A5cmt3b2l2em54RGpNcDV0cjAvS1pmWDJkaU9JKzhmRVlSQmtoQklRU0dU?=
 =?utf-8?B?eWs1d0VpdUhzQ3FGTzQwUHRBTGx5cGVod094RTFaSWpkS0VwRktqZmYwZC9F?=
 =?utf-8?B?TFBFWDQxcUxFalBGc2htNEJiMlEvMlB4NDJQMVNRdFVUKzRod1N0SFBOd1cr?=
 =?utf-8?B?UE5VWTJqazdQckc4U2VhZGxSR3UzNi9BRXVDeFhKQ2hGTnM1TlovanJOT2tG?=
 =?utf-8?B?TUNjcGhaVnhQakdlZlVBVzlVK254cFNBNWZHS01mcG05NldUL00wbFdocTF2?=
 =?utf-8?B?WG0xWkxhNTd0VUZwOXpubnZEb3owUkJ1ZGJmZkxMSk11eGtHN3krRnV2MXlr?=
 =?utf-8?B?c0ZPeHRjZ3hGM1haaEVsVTBjbzdRdW8rdlBFUUxac09jOTkrelBDaTJBRzV6?=
 =?utf-8?B?WWxzc0paVjllc1RVaDBYWEJ4SmFYTkdVckVtRElsZGx1WWp1QWpaazAzY2do?=
 =?utf-8?B?MDNPYmFDcnUzTG1HNm52dk84MDNDSXZ3ejlWL0M5L0Nib0JMTGNsaFhBZEJp?=
 =?utf-8?B?MW8xWjhVOHkrQmNmU2o4UGJSei9RWG43YmxoemsrM1FUOXlSb21xYU5FNVll?=
 =?utf-8?B?bXlmNEdTVlN1UlFtK0JjS0hDTWgwOWV4K05VSHFqODNra1BFNStVNEozZE83?=
 =?utf-8?B?YTlrOVNtSllURHVuQW5hdXBDQ0ZRN0k1NWFsUXMvdnRsWnQrZytSN2p2RkFp?=
 =?utf-8?B?UGdIczUxaGdKUk9KeTNRK28rdVN2NVZTSlN1U3RkT2ZmaHFhVUtBdU03Wkpu?=
 =?utf-8?B?TWdVWmV3R0REQklIZlNhRGQ3blF5OUh5Y2w0cDl5cUdKcnZ6dWhadlVqMzk5?=
 =?utf-8?B?aVlGZHVuSlFjcEhpdGJQRHB5WlVldTVQSjNpMWNMeWFrc3I2R05LRWRkSHZx?=
 =?utf-8?B?Y1J6U2pVY2xNSmpYOFBEQWUxNERnaE5MQWtOU3hhNWVYV1hTUjVibTRyUkFG?=
 =?utf-8?B?cnlsNnBOMjlxQ0FWS0FPelZzNlRPbGFkZHZKYysrV1Z0anhyMHlKV0ZuU3lm?=
 =?utf-8?B?a2lmZEdMUVdkK3VmVHlBNGIwNHlZVHRqVWp4WjdiUS85WWNiTW5hb2NTS3Zk?=
 =?utf-8?B?RW0yQzltK2ZuTjBJMVFBenZCa3krRW8wUURScTNsaU40QnExTGUzdDMrY3BM?=
 =?utf-8?B?N2xVRTMxdkh2M29xZDdidTNrcU8zTW51ZEZoT09xQ05WOVI4Z0E1MjRVK1Bv?=
 =?utf-8?B?TXFFdUhiOEJ1NU5maWtNM0x4c3JCcFBSc0FkdWRtR1cvWU9XME9GL1lWbjZH?=
 =?utf-8?B?YWVTdnN3dG5KckVsdTRvaEQ0ZnEzQXI2Y0lhSWo5MWRWM1RDL0NHY0h4emd3?=
 =?utf-8?B?TndtZkRZZStnLzM5elZUNHowWDd5MW9kQ0FmaEhzREwrdGJQZU0xODN5cGtD?=
 =?utf-8?B?TG8xMC9qOHlUYURCWktGNjZ6QjZmcTNBZWFTUEw1Y0N6bkpqYVR2cUhTa2lk?=
 =?utf-8?B?TlRrRm9VMUlzMkFZZFRrUUtERTJEVEgrNTd1NDd0U1pZTU1YWmlwZEwwQXV1?=
 =?utf-8?B?bklLSUYrWG9uNjAzMlp6cXFYLzl0RHNWOVJ0L0lDdDhQZDY1bUtGZz09?=
X-Exchange-RoutingPolicyChecked: S9tGWd61GW16bPdoTUqPt/Z+NtXfRRGPT88JXB3ok0E0d6i4ykik3VDC5HW3t1x17nLzkL6z29k1dKuncZ1B2yJjnE4jK3yKgPoPgWk+AbOBK2LF5jG+wbalapg+RCp5so25hob1F1Oqen0dVCwvkRI8aXI7qU7/RzAjbhtueqSsYeqpGD/KwyFFE8GBVlZtGUOJsyLvGQV2xA991BYcLzxFkdL9G3t22T8xuReBfs6UhtA/gJTbOpLbHgwaMam5UIhz+8sZkHM4VGq1CupAhfI+yxelbSUU4e2l71F9/39F0hLuojAFCAZnN0awQAaWDIfTtLJ8n1jLie0lmMcE3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3658be-1c99-462b-cdbd-08df2b3a17ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:01:02.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liZrcdRi8vBDAXDmyvi/mHpNGP2mDLLHaPHVT0tk1+wfNPGstP3+hFOz0Ib+Tgg4lVnOMXlB2PwZGBc7JJxreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com

On 10/8/26 2:22 AM, Tony Lindgren wrote:
> On Thu, Sep 24, 2026 at 10:15:17AM +0300, Tony Lindgren wrote:
>> On Wed, Sep 23, 2026 at 10:34:14PM -0700, Kishen Maloor wrote:
>>> On 9/22/26 11:50 PM, Tony Lindgren wrote:
> ...
> Based on the ARM CCA live migration presentation at LPC by Mathias
> Brossard, we now have a user for a separate metadata buffer. Adding
> Mathias to Cc.
> 
> Page 8 of the presentation at [0] below lists it under feedback. And see
> also page 10 for feedback.
> 
> Probably best to make the buffer a userspace array with an arch specific
> define for the number of buffers. So far looks like two buffers for ARM,
> and one might be enough for x86.

I'm not sure -- I think we need to first understand the issue here.

TDX also exports separate content (encrypted pages) and metadata (GPA
lists, MACs). The UAPI refers to an array of page-sized buffers, but the
QEMU and KVM backends for a platform can decide and agree on how
everything is laid out within them.

In the TDX case, the UAPI caller (QEMU) doesn't need to inspect the
blobs returned by the kernel (from the TDX module), but if it did,
QEMU's TDX backend could be given the know-how to find what it needs.

Mathias, is there something in CCA's case that a single array of buffers
with a backend-defined layout can't handle?

> Looks like we should have a separate SETUP command to query the buffer
> sizes for cmd, memory and vCPU transfers.

I think we agreed to return the maximum buffer size (in pages) that a
vendor implementation ever needs (across all its calls) through
KVM_CAP_LIVE_MIGRATION. That gives userspace a single reference, so it
allocates those buffers once and reuses them across calls.

Mathias, does this model hold for CCA? Could KVM_CAP_LIVE_MIGRATION for
CCA calculate and return a single max buffer size that suffices for the
whole migration?
