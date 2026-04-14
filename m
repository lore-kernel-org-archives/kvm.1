Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36D3016FC;
	Tue, 14 Apr 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165674; cv=fail; b=FCX6NMoy7JKbYcAAdk/pTDT2aHEhNKPDTuckwP4JPagh9cxnpRe9JwN24D7bCJlfFYDkBcCtTWLEZR019Vt04kpdtxKgEKfrdPRFzzTw5K3vEjvYtyCH+B15Cdz5EQQ2JHOT6+gxNLeJ3PJbUYdN/n+qQEqeFNFgmh8Ua8lw9Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165674; c=relaxed/simple;
	bh=UQP+o7zDStkWJ7UjggZmcsnxBp/NLm2lN3dHcOKUy7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1i3sX2H85UUUpBo+ywbyc5FjgD5k5DHiSanK3D6GuwY9cQu80Pp3Bhq6MyjxcZ33ODluUaX6kGDMKSkHk3RHCn2AMn8ULNyz0LkreJoRTSIZkNUOXwb1Y+gYOAWfHPO3bdKuCYfHkEOhEa/OexCL89nS788LS8mpO957KSU3Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYO1ws3p; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYO1ws3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776165674; x=1807701674;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UQP+o7zDStkWJ7UjggZmcsnxBp/NLm2lN3dHcOKUy7w=;
  b=DYO1ws3p8cmvZqm5cId5FMASoiIev7AjcPbrif+2T9IL9pnQABwJj4Mc
   Op4UaThFrBuFUMcMhezOeu3DCc32w3fX/U3HebR8cB67JBLMmYEp+hfhq
   IULDTD9cPzF2gY98XXnzvKP4jN+L9gfojGCQr6Lds4ipl+GDHKC6tuuFL
   LreZut692XD7DVgIvpOxWMzAN9Wkd9oB0T1BNzHRLOKlKpEwbOs/y8f2G
   53clBhOz8prEDVk/kQYyZRplCzvEoQ5G2sPww1O6Din1mmk122KpGTEq4
   9Pp3FfsP+ZZKCFvkgKKIdz1SnhMKplfk8iEqTIUSBgwtPFoDvkE+tlRbq
   g==;
X-CSE-ConnectionGUID: xr4e2tzUTEmkN6FUrc4/XQ==
X-CSE-MsgGUID: Ca/isxWhSi2zKucrRfpqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77143534"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77143534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:21:13 -0700
X-CSE-ConnectionGUID: gm0oqXg/Qz60mNzKR3TyXQ==
X-CSE-MsgGUID: Gj4VuS6kReSxS6+6QDk8FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="226892915"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:21:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:21:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:21:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlMf/FLIuVyxGr4kfPUmS0xIoZ01awdhO306Up6gHtHP70zowEIXVnQolpXafqcucVPQvGSdJWVcniPyTtkw5bw5mike/F7+5+6p2Nj1CXjmfcYmFsvQnyWPpPqGaXd5R8bLRgra9NQwuwM8j5X58VTNcq8epC1eJgEWkcl53jIqHPuzfZXzAA3qDASXZ13TTCefvkIywfS+7HufrSxcy9vRyWkGQiZNORt2MAll7ZiiZEgFxr2AKYEjPj050wlxokASyxAaV+UqIValSuKqVMYuGNS2MqMQdc9oZHCIcIbZt475VdGcpgVgagCXMk03GRXtRVHAhiI3KKwJuWzuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juI0Cb8R9goF1uz98joiDOqF+7ieJiCQoABAyT4t/4Y=;
 b=FmZJr/Hz5lyOwYfwnp38zHjkyF0iJjfvWGkUzHK0C4WvWMozuwwFOFA1bGK6ixT/75n5GCLjTc/vsaLAbSR9k2ZrcxZWDJwXTzy5J34SRL3RQeQkjo3JSX4HE8Rp5foibrmMfwtwg+F6oGfxS39YYRJiWqFtiJC1FSq8lWkG1ClwQeF4hfHt2Z3YCltervEz1wKDRgPOMpKWgAT7q29hCzSItezZUnrG3cvFEANvE5AF3I+MvI5iOQYfgRrk38x7xraGBxUw4AXlq6BQyRFpPI5D3yUY3GUrt+YJ06ae8aQwKJbIUp5bzhSjP+igDjptpbGWunitVo8D3CLYg+ktQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:21:09 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:21:09 +0000
Date: Tue, 14 Apr 2026 19:20:54 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <ad4jFpCYbW5laTbr@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-7-chao.gao@intel.com>
 <fbcce1bd98ff8a7ff106f7583e3b576b170358cf.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbcce1bd98ff8a7ff106f7583e3b576b170358cf.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccf4ad4-7dc7-4814-f68f-08de9a17ed39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gO0EK24ln7m5A26c6BClfQdOHuobOwgMWfsYQRvsVHQCCD/1LnLvA99YozoHfWW9VBAP4vWFXrHJAV5+PpaoG8Q+WFVV03L+Qc8d8Cl8QhHcSnaepRBv75+wIQ514K/eNrcZsFGscHnGA6UI8CohvWTL8mMoKd7895sV0Ww3QK1Cl3/vCAm0cuwgkUU9eEz6yqMBkNnzc7sOqj1x9/7V0i4IILkmQ+fjnqUpOF5hDN42bZd6snLX7QmbWge9W8MARmz8iUFhDygRIaPMI8qaz794pFXm7gpvwNWZgFT8w+aEARr+D64USXKl6agjLA1yE9kW5H7RRPQb3wsO5qgGXz0bcLax55aHWVCcPY/Il9Re3tlgtVo88Ym1lr1TSbcHnY8ZWxP4YE2hs0Fit8cywlZn4lx6iJbSd34i8+qP/HOJMH9Kq2aH179Zl0Zlx0kynlVYD3bKiJZ9pqgeDf4esXlCahHsm9TvO/mUco0syF61vCfmhj/RbS5yhvm2ndVF3D2G8UqVLv+U+W+OagToU/EdJrco8tAi/pXHHgashfwBmF3vKL6VbVJqo0W+BRs/ShjfsjBwq5A4MkUUW4u+rDOEErbYuELRCmbv4OvJRmu6O6wD1ta27J59b2+kAVRE/5yBbdHuHWgm4HpQnBzUn9KPMRTofA+NdZ+wgRiLkHpVfd7LlkW1G9V+Ay+sdgB5xRXqc3W6sPJrM4jyYl8k31eCUgI/hAAx0GLjOEa5/8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZoEq7xna2uTx1hKyVRbh9/60EZDm2mgkHP5FwmhlsHNlqSicOmOVLUXhdV?=
 =?iso-8859-1?Q?kI4oUs0F343neOX6loDDrE6BvpdEjqWbtJZ/i6muKoa2unt8vb7dXwXHnS?=
 =?iso-8859-1?Q?QlDBVqIsS3s7mOC2IuJLk1yElYny3IJNVqIJxyEhy1Br/1TTi7pBqrNLpU?=
 =?iso-8859-1?Q?VzhCOod/1GX7kxqtW5Srd076qbTMQTNjdWxEXs1xuZj7Lu/7jJNm6ULfMw?=
 =?iso-8859-1?Q?oqW34HRen+1FXyb67plBK1figaJp/WnhiezlRPvcvV53NqJQhalboDaQN4?=
 =?iso-8859-1?Q?lIP71JDDBQgVKZOcg+jpVHgHv6qcLbhG33zugAUPznUCdfxiFJ/w+4uQR0?=
 =?iso-8859-1?Q?z2Mh35QMXvABQuDBOIUib+5WQ19rpjb/divQ0qRw9+Jy2+9mTU+6W9w1Y/?=
 =?iso-8859-1?Q?nU7WR0KX8VrSRNo9Ap2UZZcIG9/QK/HU3bBYNRwTlnsQI4ej3VWFwS+2Fu?=
 =?iso-8859-1?Q?QPf7SjB4sSIeC1Pl8KjkcwuAS6aVl/hb+dekPO2VRiZc8L2cFPRZYjaqC3?=
 =?iso-8859-1?Q?lRB349l9a1TMp+ZD0mI5rs/R7TBeI+dWZaBbTrgy/aLtlgSVlXB3rK5HyC?=
 =?iso-8859-1?Q?Sd+cNcgRQo6/pDtLsZ1X84hCXE57Z8DQa0DwUY35ZElif2mBykraVW7U/n?=
 =?iso-8859-1?Q?FocYspUE2Tku9Teydr1ZE1zv2jWFnX0nbls6zM9jdl/6xe1IeyORJ7RZxI?=
 =?iso-8859-1?Q?XjgKjHQ2LUrULJHhOyMnLso2yDnl6rDDUxcrfhWYBiCgXBGVdqIqrs9dFq?=
 =?iso-8859-1?Q?SAD7WktxHX/bQd3+GKYpXA0zpc+CAOV8DbNFc7gwN+HH6pQayLjAP5x2F0?=
 =?iso-8859-1?Q?+ftCKLzq72Ph564bIlweWyKJ3yzt70R2bLFxCk+7GgALYoltI65QkT9Z/x?=
 =?iso-8859-1?Q?zagia3khMKu6LVcCyzA3ngJVtTO6HsAhYGzmm5ZcNGXEQia2DB5e3V81ov?=
 =?iso-8859-1?Q?YZ1aPwVOdevavWhCloZ6xCTozUh68w/xJUA/UbuKdNfF5LEovZ6XQA5IX0?=
 =?iso-8859-1?Q?Zc8MzyZGBpDl9RITO81WjE7gA88+cs/mD93bTzjc2bDKP45OzGffzwBG3f?=
 =?iso-8859-1?Q?MOnoFEkDMUuhPxpanrcPv/eGcoVk7nO+1IGUCaDwphy4NOtXCQnfaQt50L?=
 =?iso-8859-1?Q?nfFpTDCbrlBLvUQ6Ecbqoh7ZJwvQOXc8h7HtBmFAj0C2A0vmSwxLyM4x7R?=
 =?iso-8859-1?Q?Ltx1aRUAACvsE1vPUexbWhDZ6+sErlaTuzzVgz/Eh+VHNP9jAIffW+0D2O?=
 =?iso-8859-1?Q?8Ot0Zjof3xQa4CH50XHJAU84qI3wE8IJPunqKBiZ3Yklstfxrh1rlSA2eA?=
 =?iso-8859-1?Q?wTAaZ5o01fwl2AC5QYA7lVXQG2rbJ3igOiKiPb2+C5ePh//JToTgmFMFSi?=
 =?iso-8859-1?Q?Y8TqWaFbvbOR6s0cIX4vzqDXcewEc8fQ6XP6gCX75Qd3PmwVGZVk1wYEb4?=
 =?iso-8859-1?Q?cHc36/jdiFfzKi6H/HhAFw2VgrWrZOrk1vh3pFsG4qpFioltpdSm61WoSu?=
 =?iso-8859-1?Q?3LBkWBtykzwJyl5y079LYSjs880oScuNjCF3/9ZduwUu69gHIQKmlrlD/p?=
 =?iso-8859-1?Q?s/9gCI+R3jA7tH5O+xNkvboUBBMXvQgb/T6LG62yXjSAL/pa9RFrLFRi+j?=
 =?iso-8859-1?Q?k8Ul3bz+euECu2w2F/vV6GAAE8YvKcb+t1pakn8Gna5MbaP2a8l1QV8ZiU?=
 =?iso-8859-1?Q?snlFSHkrmGMozDVyNEA/g6nVhZy9353F5/PBHSzzlTg+lDJtBJRBSHQnBr?=
 =?iso-8859-1?Q?oYwM0EAaH92XTsDF8m1cBHHeXZ+tJlJYp0+Qpyls1l/JrGs4CoEoQLdj6S?=
 =?iso-8859-1?Q?bzOAjDfQ3Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: pATPPckgGKeRcFFRmAHq/P2bD4YG2bfs6NSsgwUPThRndiA6iqNS1R/H+tQBY23p8i4fwQoIQItlw67fi5VibMmL/o/VToFLTg133kSYJMr6ud6MvK1fvfpqodt/hghyKFl18lsH3bOXHiJ7HZgk+jFj01WinovyZDq/9euiNuY4/Lat4lxpE0bcgrcn0QIDhQGUKzmvBbcW1R0KIoG4zU24m0/BU9gbylq73eP04uRZ5FPvCM/k3PXvoco+lStpqtI5uq3Lwv7FQcX9WboybxFxjhHEg0XgFKLN3CVHANws9lR9zQBg3mSO+D7EeEM45E0UyM3+B4NYMsMxa9YyLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccf4ad4-7dc7-4814-f68f-08de9a17ed39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:21:09.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HC5rkBuxQcwBKofj7ONORdbldfap+AdeP4V+RV2N+Y7iQ9vIEPEi82qhmhY52XFWzzBBVKlA/Ih0z/x2+CCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

On Tue, Apr 14, 2026 at 03:08:33AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> TDX module updates require userspace to select the appropriate module
>> to load. Expose necessary information to facilitate this decision. Two
>> values are needed:
>> 
>> - P-SEAMLDR version: for compatibility checks between TDX module and
>> 		     P-SEAMLDR
>> - num_remaining_updates: indicates how many updates can be performed
>
>Can you explain how all of these overlap?
> - TDX module supports module update
> - SEAMLDR supports NUM_REMAINING_UPDATES info
> - SEAMLDR supports VERSION info
>
>If the TDX module supports module update, do we know the SEAMLDR supports this
>other stuff somehow? It might be worth a comment the reasoning.

VERSION and NUM_REMAINING_UPDATES are always available for any P-SEAMLDR. They
don't depend on TDX module's update support.

>
>> 
>> Expose them as tdx-host device attributes. Make seamldr attributes
>> visible only when the update feature is supported, as that's their sole
>> purpose.
>> 
>> Unconditional exposure is also problematic because reading them
>> triggers P-SEAMLDR calls that break KVM on CPUs with a specific erratum
>> (to be enumerated and handled in a later patch).
>
>Since this is later handled with the errata check, what is the point being made
>here?

I will drop it. Dave also questioned mentioning the erratum here.
