Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E83DCD8E;
	Mon, 20 Jul 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541850; cv=fail; b=uAuTewxPdLHxXpr5FaHIODQNFxxDX/+KSrZenoiW8aH93AvXqjtiEa2n8qM4ihAEOfLK1QQUTZI/Y/uVdI3SFU2UnAeDmb8CI0IYteY+O4URTt6ihyfre/Xrqaf5m4KGbNUdsMyFtKPVvobYtrJRmo3ya85o1SuXjJKtOWMIbwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541850; c=relaxed/simple;
	bh=jsRSa83BThFscdE6UYSDSIk9oA5DDCW+PTFUh6sh8G8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BoCsf5DdTKRjeNveoEN0WDoIJlw5Q4VAa64GM4Izh8mHFZghammtsfKV6BcCo1Fx+L1hthhNX8jYU0x2GCV5vIf8+Bf2AbaQr6gqB3sAUUdOBp6FYvcYWr/BkTZImDs3346MskenAANED+I2Vj8hGIkw+wFd9iSrnl+DhWLtyGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVBWVmxi; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVBWVmxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784541847; x=1816077847;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jsRSa83BThFscdE6UYSDSIk9oA5DDCW+PTFUh6sh8G8=;
  b=EVBWVmxi7QmkD7Q0EKIbJPDdLN9EVjovhe/tddkmZyHh1iulTYQYOyU8
   VsqmfaM5bWKG0sQzVebKop8RdL+sdLn3E7SvvkWl+ir4xfBHtmJREhyDj
   AnTcc/6SMjEV05K5PTx12Z5EwgC0ZPZgRLW3/bxcUvd/NO6FiV/6x/E11
   TuKxU8o0FS04hHGoEIPmyebP+QvS8dAERLKlBr6olHJRTYsK4DFei1alJ
   Rs3nvs6HlrPyuAghtXdZWeHSg9JvYF1H7JXkgHqQsZuBqJ/fKuzJnMbeh
   qYEf0OT035QhzGDaYAZ7SY7B7CCmXPGHWnAakHutwtG5vc9JdQqU1PGtT
   w==;
X-CSE-ConnectionGUID: xytI3emVT4CV5LUqnrLdkQ==
X-CSE-MsgGUID: IG7JYGEyT3aaFvJ5DcBAeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85319178"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85319178"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:04:02 -0700
X-CSE-ConnectionGUID: yJrRsoDyR323DzxoozkQCw==
X-CSE-MsgGUID: Gh8XcEqFSaKRT03arRYNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261702454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:04:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:04:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 03:04:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 03:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj1cFQ1wO5i1MdF0YWBGjsvuur2Cpie76HDEAdu0ij97xTPV7o+5r1D0zwgWXk1BFYDOQ3H4bJFc0ilcfc+S5hVhJn2sluhgcRZswWmsEMb6/rAGM/oPyngGK8OSjc3HLYoLqjnKgxWUR01IKndXeChAQRAV8gtC2WIkDzxISMfwR7ynvH9E1QY0lNaR/yEHgDiaxmPpEUqTgPi898QXazfp1ziBEfmQOStA9KB+6mJSVGVqUCFzLd43JpnXTvDC5w+fqYf4Mm6jXm0QASbcnrc3oNVfVuaKw7uH2XKJ0oG7nk+F4p5neL5gY6B3wWPmwbnnrwx+RlzBzqmqw3IQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDcoBgA+8boHzoW4tFdtaRWv8RyljAyOQUt1isIAF0E=;
 b=R2IfOXBLhe2lhFdvW+GK23OocwQ91UD1izB+zZN46pjwrIG0Xh3b2uevjSenFkYpNr5qNOsOAd+w8LtEuh71KW9T+JoFF2aluKl+tACow8FaUhbgzioUNDr2UUfYNMP97FmX+P/l1ew/nMT3CPEsBZUyF1lUpr85tmuCchrD0+huHg5UhOVcRsBsVq50Xmy41fz6E/ncDiUExoNjigHKtO3tPBehvUEoxW88oizJm7TkGoA23iPQtYGeOETgzA2BpDWafytbzJHP0Bxq2aU77JOC4ox+zkgOFxDzBVTmUMXPnkrMBfx7x3gnB7W+X09r2j9JaDeZ/AMbc2q+epgukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:03:58 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 10:03:58 +0000
Date: Mon, 20 Jul 2026 18:03:44 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Sean Christopherson <seanjc@google.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <mlevitsk@redhat.com>, <xiaoyao.li@intel.com>,
	<rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>, Yosry Ahmed
	<yosry@kernel.org>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <al3ygBbMHq2ltdYN@intel.com>
References: <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com>
 <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com>
 <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com>
 <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
 <aiJlAhqnU0lwOAcG@intel.com>
 <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To CH2PR11MB4456.namprd11.prod.outlook.com
 (2603:10b6:610:48::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|CO1PR11MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f97cea9-b083-4d14-4699-08dee64635fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BWCwfTgq4Mu9SSa7otUx7bRCNNY2ZKtyXSeWHfl3+MfNHRIDP8GXu2zPpYJPl7Yfh+yLPEoTv6P4S+SBrcrKVm0KabJJ23JjaKizXIj1FuIbPNWhJY5znL+QtxXig6qIDpRIXRagwr4zKgmjcddgJyWC2uBrKYs8lQfoKnICD1LcdvFV/F1cxIj2/kS9qREjkkuAwZ0Ts6GteY832NyCuF3JXvjTYcbkEk1DZD99FoI7vGeJFdHIVG9FaxRo1T3f+UDq70r4chDrMgg77zGAczBTR/tShKn04EKqv4Ayaw2bnBD3NvKz6kRT8j2oHA6THwfv2H98Og6syijwfqTOFXUg/d0iCd+wjrtKMk4yj+iN8EDEpQPeInaUMv5mcN59QyQrsEfLFiet24wTeCYWKdsy8+MV2cvqpUWazRXvIpPC4eSGuOhi7dG8sVzEjd1dOn7LHif7nU3wxmtIWVfs46cZkBsqN9cyWZE0UErXB/zUPW0WrJaoF0tle+r/vuFV0qQRh7nrp8amt1nsnW/m6JZa/yZWW0QWJxr7bB/d4mcJniAemyM0a84DktxHyTLco8umE6unKEKv0N30eh0i8qnUhpB2Ksx/wcx30MAcenVNQnpW58FO82wsbczE/5Xum83eaXOM4yBBUW0wL+W91S+NSppRc+GXTdSrSvk6L/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUx6VDVWeVFHeWlKWC9Kb1VFMnlpWExIMGJ1OVVJUzdGc3JjYVlNajN0YzVR?=
 =?utf-8?B?cXZnc25CVWxGYjY3c3k0anNHeEJmY0N3SU8zcEphbXRRVklaSHBOMWtLSGVi?=
 =?utf-8?B?VzJ1L0Q3ekREZDhIcWlkL25wTDNNdHRQNWJJR3NYTmxsZW54dWFOYlZGTUE3?=
 =?utf-8?B?aTJZa1ZJT1hCZ09WbHNUS2sxUnhpVUJiWU1qdEhXOXFGMTJDQ2Q2OGpSZC9U?=
 =?utf-8?B?b0dKUjRXZjV2Wm9JM0g0NGtZZlZQaUx3TEc3Z2V3NVg1dERCSlNYc0trV3gx?=
 =?utf-8?B?U01XNE1lQk9JenY0V2tSL25wUGlDV2gzZEJidStxTmdxVVoybXpiWlhuNksw?=
 =?utf-8?B?eG9qV3VMSmI2TWpYVllabW90cG1kOXFMZWFWZXlUOU5HUHBDQytLM3ZzZW5M?=
 =?utf-8?B?c2VyRUlVRjF1QlFFRkJ6Z0g2UHRGUzVxNm9jOXhESlI4SEhIVXZnQU9RNDNK?=
 =?utf-8?B?QzVCNWlsWVdySkVQa2d1OFRWNGU1WmxQTS9OTUhGOW1JbUJ0RGZQaHpiVkVa?=
 =?utf-8?B?RllFZzRORUZkUUgzNXlQcVBrREpXbE5HOEo5NzUvNk5aclFETjNRUmxBSk9x?=
 =?utf-8?B?YVVISHN3N0RiLzROWnc5ZXlIZktaS3V0ZThvUkhZTGxManM1U0lLN1A1OFJu?=
 =?utf-8?B?TW84MmVDMFFpMlFZeGs2czU3MTRKaDhiVkZlRTc1Y1laZHVtc1ljU0V1VkJj?=
 =?utf-8?B?TURGdS9ITnpuMVNESnVYRlNyMW1kaEkzV3A5SWYycklOdEVZVDlCSjR4bnU4?=
 =?utf-8?B?RnZOOE5TaFdlakZxL0dYdjhiMWppRGZKN0ppdDRCTEhJUC9pYjl5V1pLMHFi?=
 =?utf-8?B?SVU1OXJQYlo4QkpSUmpFV3lPcHU0Q3JYZHEzK1RYUElSTEVJNGtFMmxnYThJ?=
 =?utf-8?B?dSsvdW4xRkFDYWFhaHBWU05SaWdEYjhyN0pWOHdpaVJqUlhjdlZESUw2ZXJS?=
 =?utf-8?B?NlFGMWVTZlpZeHZsbkx4L2NhR0lPZkJSOFFscE80TXlsVitKT0FVdURaOG0z?=
 =?utf-8?B?Y1dST285TEsxNzE2c3RPTUVmcUhMOWNGUzhTZXJKOXl1TVc3bUp5T0lDZ0w4?=
 =?utf-8?B?VW41TEZvcld6VHZXVy9XNVljL0QwREtva1dWY2xZYitTeFJidjNhZS9Oc0Na?=
 =?utf-8?B?aTR2MW5nYjFybFVlaVFOY0lPMDltZXJSTUQ2c2RHSU81b1dMeXRkMU5jU2o3?=
 =?utf-8?B?R3pOdm9LYUdMRkdsWCtBNWVHczViRmpwOUVmeWlla3FlNmZJMzB6b0VkWlM0?=
 =?utf-8?B?eSsxbnhIZXVkYjZ6MjhMYXE2cGxBK280eWtKU1Q3Z0lSNUhjYWNTYytUdXhG?=
 =?utf-8?B?NlJnbzhTRTBsRjN2ZkNWQXMyS3E1K0dvSHliSGhISDN4SVdtdnM1WU5paUNU?=
 =?utf-8?B?R2VEK1Jwd25WT0VWZjdIMXNuL0RxYkZ4OTNIVjNYQmhNZTBEOXVuaW5mTktC?=
 =?utf-8?B?MThFSXE4TU11ZHBqV0JFaCtSOWRjSzlyNVVaYnA2dkxNV2UxQ1BVOWxERzlx?=
 =?utf-8?B?V3RPazBCYis5UXc5REtOOWpZM0w5bVBkenBpcVNEWHl6NDJmTDFCaDZRU0ZI?=
 =?utf-8?B?cDFRb3QrcnBhNW1VOC9oV2dCNThHbUUzOHJzLytORkluSlpGdlk5ZWRVQ1dn?=
 =?utf-8?B?VkZRWVFWZm5CdldiVU1xVm1xa1l4aXJRUnRTbGxoRTROUGVla012VHFZNkUv?=
 =?utf-8?B?NDdwU0RtS2JJUUg5YUdVWnpNNTJneHdKQkoyclZ4TXV4SmpOUzAyZWZGeU1M?=
 =?utf-8?B?dXRMNGRyaVcwUUx0d3ZmcHpLZnlKSXJoM3hEV1RrQzBoTjVMcWJKbEVwSlZQ?=
 =?utf-8?B?aHpnOThrdndGUVdIZmFKWkJaYk9yRWV6cnNwa1VzK2tIOWp5cHc3U2YrYTNO?=
 =?utf-8?B?NjVNelRSNmQ1L2NlUWE4am16Tk9qWFdxL2diL1BXbUpwTnpJZXExUzZPMFFa?=
 =?utf-8?B?Q3Z1NElIc1R2WTRMWXVESGM2QUtqWHpYMXVJRG10NnFoQzB4MWV4dFdtWWFH?=
 =?utf-8?B?QTRrenFDQTZjUmRLSEdnRWlJSTNKU25EZFFIMit5VVdvNkY4amhGd3FmaURh?=
 =?utf-8?B?SG9QTnJVYmc4cXBvdkw1QTdsQjZ5cXlQNENrOStiRGxxU3o4aFlsdDNMeVlG?=
 =?utf-8?B?MDBsTHN5Mi9QOGZtQnRPMWhyRmRON2o3THhMQWtyMmtUbzJVUjlBOTFqcnVI?=
 =?utf-8?B?ZVErQ3VRNDN3d0hDZk96WHJnaWU4OE93U1d2YnR3UlBVeXJXK1l1WE4ySW1o?=
 =?utf-8?B?QkhkbDZybkgvMUlDa1pVRU5ZV2RBYmQwTGtCdW8vTC95UUhXZDh5YTBFdy9W?=
 =?utf-8?B?bXNXazhDYVRtQjlRYkIwcHp3V0NrY1pYVi90YVE3MEtncXM3T0hZQT09?=
X-Exchange-RoutingPolicyChecked: Pekr9sMGpRfrsRFLmHqJAUYDMUHa/yIiSHHY4FTXLmhdkBJ8DNPci52R2YzJnaCGsG6v1GQva66D/7YIWlstQ2RkPKtqNVRGq4GBXpu9jeYgrTtSOqTja6jJALO8fU8LO8WS/nZxZI395s1JYzOmYgUuP40Vm22IpCcfWQjE1NE3h9INjn1DbYjghBObKFsae4+NniKZE0CaEeXdCUr7mFjr2rmLjgAgvn1+bj1kf9DxVpR1Tlc+xCNZJY3TCqoz6jl+rBNW8JIDl8T3/TnpFn6FHG0Glv9X6NWstwN6mJlOrT5oHaLAtFw4eZyCdj20enY3QNVlV4GY1c9mV4qgLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f97cea9-b083-4d14-4699-08dee64635fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:03:57.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSCOj9k6DQbQiQ8+20PvsUbeI+KjCNrWPO57QL8XqhM/cd5uhdKA7VllSgAbeu0BjPxWs7+ZYVOWs4pUQltjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 03:51:56PM -0700, Jim Mattson wrote:
>On Thu, Jun 4, 2026 at 10:56 PM Chao Gao <chao.gao@intel.com> wrote:
>>
>> On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
>...
>> >With respect to EMR, you wrote previously, "A mitigation for this
>> >erratum is for software to program the VMX preemption timer for values
>> >below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
>> >
>> >My question is whether the exponent, 25, is a fixed value for all
>> >CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
>> >saying that the exponent may depend on IA32_VMX_MISC[4:0].
>>
>> Let me double-check this with the internal team and get back to you.
>
>Have you discovered anything?

I just got the final answer:

2^25*M/N is the max value of VMX preemption timer for _all_ affected
processors.  Our expectation is that for processors that have different
value it will have the issue fixed (VMX preemption timer will implement
full 32-bit). Use of 2^25*M/N will still be fine.

where M is CPUID.15H:EBX[31:0] and N is CPUID.15H:EAX[31:0].
