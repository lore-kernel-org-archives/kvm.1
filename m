Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D94DDB40;
	Mon, 19 Oct 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407921; cv=fail; b=pjWcSezoChyhDeBVgdRwDilxnUp3wxeZvGkI3PUIgVqEhdsEvFCuM8P0ylafxsLhkiQkeE2YHf4uPD/nO0bS5cLO5VD0UUqKr3kVbKl9zN15/6/fcYAsI7a6jWgplLah8Lhf5r2jxg1fitTpAH0K6ydhpb3LMxR1PEZK1jWCC0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407921; c=relaxed/simple;
	bh=akGKjU8Zj6IEFySpM52wqWvNxxxupPi/5liwSvCUXdk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KhyneCmZzec5r6mLVyYdYGFJC8L7SzCRMiYxZoiJlTw25w/g3lZfkfe5Pf85GYp547OGmkQoltlUoK73iYtZ0WHPY7lCPmHl8pbEEUqxyLzCIZebGRl9mN1xSR1dCBm02M59OWEY4Pp/gj8EEEkrjqZT2FLlrZczMgdDSZpnOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvY+v5qM; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvY+v5qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792407919; x=1823943919;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=akGKjU8Zj6IEFySpM52wqWvNxxxupPi/5liwSvCUXdk=;
  b=QvY+v5qMoI2DMzof+dd7hg1QtrtvW6FSkk2GP6YtrERuHdBKG/De/zpi
   J1Z1olg28OOsXQbq2QdNUPq1XiC0TMzcAikwoDC3MN00W1eMOuDQSjhzj
   TQgFJ7kQU6V6AeXGUjeD2K0DtiLVwXUKBT+2UXDr47/kGGAX+sgXdqTlS
   GmADGwAwkDcE2u04yjgVfZenYlro/bCUT/MU6o8ht+cM+PBDutW3SQxUD
   TmdaI6lRzltciVDoZeboZcGJ2GbMkb64mPqMLmCdZjuta+eT+7LwM6ai9
   gwtPmtUtIvLyaI4TCYkn/nxQl1+KY30M+iszo+YKWSsyKQrVUkpC8dub/
   g==;
X-CSE-ConnectionGUID: qEkcrYirRcuG6H7qjgDtWQ==
X-CSE-MsgGUID: ojMEzOavSS+I6lW7NG93lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1121468"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1121468"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:05:13 -0700
X-CSE-ConnectionGUID: KzEVkCVRTw+573wfGkRchg==
X-CSE-MsgGUID: P97SmXrYSsqAaZkstRHTcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2486544"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:05:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:05:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:05:11 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:05:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaFM0sYoHq5LoqYo9FeAtuQdEeZ0cUV2+iWi1dz/C4E0x+g29Z8drP+suWqmaml9VnAkVB04Ovjb5WBA+w56ddvQiOly+5Vm9K1Me5ESfHEJNRkauFEiApttn5L2JhJGq8JH2HeGU5yL36qWRGSt4r8SrjIDcwq3zdbSaHtXBT59C82OtBmIZLPkGIXvMIZSN+cF7n03Rpu1YxD6AwUgZEZ5+U6LmtzfK10bFMDDqZRBVgfvyrmDkbnKNxlwib684j09xf7Xag55pZBw3yLShKVHn7oZ6in38FqZHmC8BQoH654XC2z+NTJgBm1goRDc4UH7n1D1GsqVBxVCVFRBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2wBgoCKHeVAl/vhSVhtWQfLCtbdBNYvqbqalA+p7d4=;
 b=IYiwAvxaSKWnOIHSmeToMLvznB3mzUL+Oaq5P3//3ON1uqI+UbzbgvIgb8755VTt8lAm/mw1FUQOE2xMP3KZzxqX/jGpvAoWmXonI4AC8XcLjZ6I2U8R+sPe+x3q8/6WKU3Mgxwlu6gaaMyYgJnE2e5nRW/a2w8KGN5GMjRFmrGQHzxriHM1RI0vgT68dRfA0qDJypKhjNJcjoPBW9UQ1B2LE3kfLiJpn2t8M9LZAuLDDKYEoJcGWYx3FnIMrmsREzeqplaYPZJeFH+dbmkNl+ApoWN0PwFTry4/YQRCiZcg7E4FN+M0gk465l920yvn3dUDtvo28Bo+hcnrxUfHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by PHXPR11MB9688.namprd11.prod.outlook.com (2603:10b6:510:3ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 11:05:03 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:05:03 +0000
Date: Mon, 19 Oct 2026 19:04:06 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
 <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|PHXPR11MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: a20d6185-84d5-41b5-39f2-08df2dd0d354
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: PaKrF0oVyyq5e4OJ+5RWoOZbCJ342KOX0rx7OM9imtLX6WOJ0GW1hzdY2wPlb+I62AUp8lHasNNCc2gAHM0AnrJiJe9Sn3UK/002Z3KuP3LV7APmyj9nd9IhggfDnPwL+wIMYZ0AwF435F1i16qG7jqaCCug9uq/99SPrpFWJXex/jKS9yNbUzetooP2Ctwp5hTurC73woSrK5sV2fhPo1H23DqBocQPbIaLSt2rOOmteECoUmokRMAZnxhiPq7DwG2LHpkqFHOjO/CtpZdFFB7mcuTeVhJEVhnOOTx5S3FucJ5eJiqD2OiwbLDwkqoKNAuYSgi9+EhfaFW40HbRxlL0n8cPoOS22P526Zcu5i2Jy1K2fOgPH+BE2KMZW5gim91dh/SNAb5Yc7WLbfP+/I37wASDQDSUJVKe8EGHZEV6BqmKyi7udGy5HIzMO/C1OYBRJMTodFNWsEgPJGd8IotatvcAfQEPwQXxNtz7T6uwqiuOre4kmHp4/KHcDnNppT0kXk5TKFYZLvso67yOy0rtCtJVifHpmbMtoZxSGrYZVlTwCjzyl3lVf6TLDIdAFH/zMWt36lgX25FtfQEGx0GeLy+Sg9xqdGYnCR9c2lfJ0ZHqcUz94NlE8+OpORpV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Mdizw9F21xbX9tgEXa5g3FIirTS+5ZCYYI3Shh68HICAZRsZPOZV9xnKdQ?=
 =?iso-8859-1?Q?FoX95Rf2yXjzIoBcMf6br8VOn0GNdHKU/5hpfi3yAyf5mq/JE8Lj3zcEOe?=
 =?iso-8859-1?Q?Nhu2nGn6ub/FKR3qknxOENRy5EGTfBKHXy7NUQsyfTkWPZmPQQsmfDTDJF?=
 =?iso-8859-1?Q?xENFYeLNIQN/BrmcATQG1b8OH+letvkvSl7yMTsvBdHh00SPviYAF2dtBB?=
 =?iso-8859-1?Q?VDNXyGpCL8Lie7F4vSRxQwiJ1gFqfC4S8jjstqx5KsyVQQUqSAgrMjRQ84?=
 =?iso-8859-1?Q?u4o0M+ij9/aDNO3+uTsgpMszGwBFkDY2x9CFc88dQSP+Gy8uHh5+YjkYJy?=
 =?iso-8859-1?Q?0DzFNOtZie77MhBNXKuU8ImkkbRfn+8lxdkGOfzTwfG78wumKgvxQ2VV0M?=
 =?iso-8859-1?Q?AgRhZly/ZdzBG0hF7tHCDuCkCnNecwnxaTiZacwVjVkjIuD4v3sWRm0npg?=
 =?iso-8859-1?Q?O7Qgqw3H414N+EepOmnlfhdHSCYgVMZE13kvdV7rWTHwSxjCjr9Lo42q2z?=
 =?iso-8859-1?Q?dCX4YEBYSXe7WORNbOB3keFCA41cohVbnIPiM2c09mLadgb/LAWklzkxPR?=
 =?iso-8859-1?Q?E3aKJ1W7olvCn9aOhz9xcy1rvC6FNEpAmbPnR6XBPRzDUF0BcUaW7AWQ0N?=
 =?iso-8859-1?Q?EybI3F+/m3y2JvlFOqYsRmOIkHA2/bPnbfuXlkVz0CAyRt0PYtkx1mKF0W?=
 =?iso-8859-1?Q?eykP2SaUxP/+L9dk5slqWOhpr3i/T74SFqBU6Uu3CKncHhuOh7GRWlwjO3?=
 =?iso-8859-1?Q?SFwBXd81zHgUe/DnnxRZJq7eKG7hsy6kDyp/hI+JhzLcST96e2RSHISy2E?=
 =?iso-8859-1?Q?IFJ2Xu7VIc7NyDnGTa8GzMczlILUDWnyhOQYqP+XpLjPDxeneAAd15IDor?=
 =?iso-8859-1?Q?aIUUevtDZNoq8IJomFKvAyNaJehXPKO0Z2Rt1K8Vc50EeJAL+FwlWUU7i8?=
 =?iso-8859-1?Q?JK4KKkrGYxw1lvXUhUIRsGh+Lxbwp07gmFvTpx7SHO9ldsY+gpo47t0ta7?=
 =?iso-8859-1?Q?nFsBQ7GOdkFN7yHWnNT8DKo4wM9ouGxe5wLrm8KabwOzyZdEAUvzR9qVaa?=
 =?iso-8859-1?Q?SsfC9ikRGnmaOtKR+1OrFAOIJH7TzsFB3hFNUhimfZr23gG2xMtZOa/SJT?=
 =?iso-8859-1?Q?kMvQGXPjj5QantZVm6G6OgTkvd5frKhEPm/H04aZLlpoPyCK6JG6ELQx+Y?=
 =?iso-8859-1?Q?kZ38tQQO2uF2WWjvWcrFihtKWmae5HWN+xJcE/elnfA7iETGuOx+Ih2wLs?=
 =?iso-8859-1?Q?sdk/DfU5/BoeTcpDRPYCbxs5AG+KJ+JBnQ6gI0okJogHN4IftucQcjt/Uh?=
 =?iso-8859-1?Q?bqln+ULyzLNbDJJJiql8uESPXIOfQqmK6AgdIuuiSve3065mbr+Lv8EtSJ?=
 =?iso-8859-1?Q?9KzUMdkmwtRA71p6X6wV43/1V68+zH2rWk0qMp6vwF8nydXrA73d6HMKfo?=
 =?iso-8859-1?Q?g5IICxaQFQsR+3PP9LHD5Gw1ZRcxV8H05fYR/255UkJp/90wMCCCLjBA9b?=
 =?iso-8859-1?Q?UuyIKvZfxDdKGHT4AmERFmhjol8wK4zIWACqGF+gI4E4Uho/aJlCWdggwk?=
 =?iso-8859-1?Q?ZmXX9iOGZ1pCOJBcySr8Bp94cfVfIhXuxt7WVRpgKdnqYnZUHHEC8l2l3u?=
 =?iso-8859-1?Q?MW+TzQfJBGC+b2YeXfVUdaL4Xw8Ids9VHVJ/yUV727RUWr10A9Ej+EZDM5?=
 =?iso-8859-1?Q?l7+GzBnl4cRaDxlL7yQardHDOYjILMjJX/WGVmanOioqkDSEMymLhhBqYG?=
 =?iso-8859-1?Q?ajeJ/+AYHE+vj8ND/F40oWLY00KIriPMOEUu1IhloTD6U5nEKMLXi1Rmxh?=
 =?iso-8859-1?Q?GAkQWsfzXQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: g8BJpXoRhhxqpJxoqJrotQQA/iOKIz7tDWWEvZ59PfLCkmAMvDu11AT2jSKh+yROz90JoUYL0i/NqGGrmYyw0ETQFRR7cUrHhGgySMkwSS09kA/qcda4o4QZ6FnBOf+UNH4u9Txm2O3E1l78UBdhU/owURsh7XU3llzadbdYDjdw06uzo/OlT23zatEQ/fo0kt4A5ed9WeCh97ATVcs+8+MTUhj+M4cCT+BWkMlDan2zgTauLcj5t1uqzsAn7Y0hV92dYVyg6YnL79PTXTdTliYaRXPnkv9g1uOaKwHGuIgBRmN047hgGzv8Q+ZF2LquwtY1shTSPmerlkyoS/raJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a20d6185-84d5-41b5-39f2-08df2dd0d354
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:05:03.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ/2xaXgi4o+pT4FuxC7R7KepFVDmIKtJrvoFXXA52Lyz28+3qvV66CII45+A7VAaw5GGaMuDRRAJmA3OMC5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9688
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 02:30:49AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-10-15 at 17:49 +0800, Yan Zhao wrote:
> > > u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn,
> > > struct page *new_sept_pt,
> > >                              struct tdx_pamt_cache *pamt_cache, u64
> > > *ext_err1, u64 *ext_err2)
> > > {
> > >          struct tdx_module_args args = {
> > >                  .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
> > >                  .rdx = tdx_tdr_pa(td),
> > >                  .r8 = page_to_phys(new_sept_pt),
> > >          };
> > >          struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> > >          atomic_t *dpamt_refcount;
> > >          u64 ret;
> > > 
> > >          *ext_err1 = 0;
> > >          *ext_err2 = 0;
> > > 
> > >          if (WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo)))
> > >                  return TDX_SW_ERROR;
> 
> Why did it change back? Based on the "mirror the other code for error handling
> level", I guess there could be an argument for conditional.
> 
> Hmm, the other checks are about making the code work transparently work whether
> PAMT is enabled or not. But this one is about handling code calling the function
> incorrectly (since we don't support huge pages without dpamt). So I think I'd
> still recommend what I suggested last time of no conditional return. With a
> comment like you had. I also don't see anything blowing up too badly if the
> warning is triggered.
My concern is that without bailing out when DPAMT is not enabled, invoking
tdx_find_dpamt_refcount() would cause a NULL pointer dereference.

Or could I re-introduce the "dpamt" bool? This would allow huge pages to be
supported even when DPAMT is not enabled (with no other places needing to
change). The only downside is that it would introduce 3 additional 'if'
comparisons:

u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
                            struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
{
        struct tdx_module_args args = {
                .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
                .rdx = tdx_tdr_pa(td),
                .r8 = page_to_phys(new_sept_pt),
        };
        bool dpamt = tdx_supports_dynamic_pamt(&tdx_sysinfo);
        struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
        atomic_t *dpamt_refcount;
        u64 ret;

        *ext_err1 = 0;
        *ext_err2 = 0;

        if (dpamt) {
                dpamt_refcount = tdx_find_dpamt_refcount(pfn);

                ret = alloc_pamt_array(dpamt_pages, pamt_cache);
                if (ret)
                        return TDX_SW_ERROR;

                args.r12 = page_to_phys(dpamt_pages[0]);
                args.r13 = page_to_phys(dpamt_pages[1]);

                /*
                 * The dpamt_lock is used to avoid contention between the
                 * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
                 */
                spin_lock(&dpamt_lock);

                WARN_ON_ONCE(atomic_read(dpamt_refcount));
        }

	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);

        *ext_err1 = args.rcx;
        *ext_err2 = args.rdx;

        if (WARN_ON_ONCE(ret != TDX_SUCCESS))
                goto out_free;

        if (dpamt) {
                atomic_set(dpamt_refcount, PTRS_PER_PMD);
                spin_unlock(&dpamt_lock);
        }

        return TDX_SUCCESS;

out_free:
        if (dpamt) {
                spin_unlock(&dpamt_lock);
                free_pamt_array(pamt_cache, dpamt_pages);
        }
        return ret;
}
EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);

What do you think?

> > >          dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> > Can move this line after alloc_pamt_array() to mirror the sequence in
> > tdx_pamt_get().
> 
> The less that stands out as having to think about, the better.
> 
> > 
> > >          ret = alloc_pamt_array(dpamt_pages, pamt_cache);
> > >          if (ret)
Does the justification for WARN_ON_ONCE() on alloc_pamt_array() failure that I
provided in https://lore.kernel.org/all/atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com
look good to you?

Could you share your thoughts on it?

> > >                  return TDX_SW_ERROR;
> > 		  return ret;
> > > 
> > >          args.r12 = page_to_phys(dpamt_pages[0]),
> > >          args.r13 = page_to_phys(dpamt_pages[1]),
> > > 
> > >          /*
> > >           * The dpamt_lock is used to avoid contention between the
> > >           * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
> > >           */
> > >          spin_lock(&dpamt_lock);
> > > 
> > >          WARN_ON_ONCE(atomic_read(dpamt_refcount));
> > > 
> > >          ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> > > 
> > >          *ext_err1 = args.rcx;
> > >          *ext_err2 = args.rdx;
> > > 
> > >          if (WARN_ON_ONCE(ret != TDX_SUCCESS))
> > >                  goto out_free;
> > > 
> > >          atomic_set(dpamt_refcount, PTRS_PER_PMD);
> > >          spin_unlock(&dpamt_lock);
> > > 
> > >          return TDX_SUCCESS;
> > > 
> > > out_free:
> > >          spin_unlock(&dpamt_lock);
> > >          reinsert_pamt_array(pamt_cache, dpamt_pages);
> 
> Is "reinsert" the right name here? It is just adding them to the cache and
> resetting them. So why not just adjust free_pamt_array() to take a cache arg
> instead of adding another function? In tdx_pamt_put() pass NULL so the pages go
> back to the page allocator. Might need a prep patch. Would have to test.
Will do.

> This patch will end up getting stripped down the minimum we need for this
> series. Any new functions or extra code will get scrutiny.
I agree!
(my only concern is the risk of NULL pointer dereference).

> > >          return ret;
> > > }
> > > EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);
> 
> Otherwise looks better to me.
Thanks!
