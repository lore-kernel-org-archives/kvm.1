Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C281A683D;
	Sat, 10 Oct 2026 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614501; cv=fail; b=jHxL5sP88Xiokox4TTF0wtru/CTNmJAjCIY7MkiCvz7aRCn/wAbFzCl6/5wa82LlidVPgnLymkaQszVup1/9O6+6MESOVLk2HEcXc7frwB1p48CgS9eyAfdzefjuvGfDCrC8N3P6wI90hi4xq0zRfu7LQP1eBSAuL3WnEytJI+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614501; c=relaxed/simple;
	bh=nE39kfVi38wSUdIIZKJtaS0na3gABEq+N7OUVuBiqFA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKoXIHtl1NIRo5tZxovGxIcmFtWNoWYhYUQFARN1Q0fENJC2V5aWoSSW8ft7K3BiIGxPN2mlTTa3oAaDjPV0hJyGOkD7LLt2jgkPdVcycCOb7ytGiR60ZHK8ROt6BI/xZbjgN2W+mJWTBHJxjdBHCWolX9BrsPrBUo6WccE3esQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUYxz+aq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUYxz+aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791614500; x=1823150500;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=nE39kfVi38wSUdIIZKJtaS0na3gABEq+N7OUVuBiqFA=;
  b=OUYxz+aqGQg79v8N1wR/hYosM37jMrbdFsLzYY/CoG4sb3AGspCd8Glf
   OAHVTmV46zO+qz6R6eKpDdIghoEu3DW2c2Zzwox0k1qnAXrrEf4zNixbm
   5QogovicSFOfBtNCQie3tyZ07OwBZc3fBRv+tOmWfL6oJGVtzPi6fF/sO
   4Zb+ejE4VFoqMfrh+GoQZgFxTZJKr3zBQdu83xkK1Ue7cv+u3PHmtUBKC
   Twwl9VPgPMFwQRZDc2C/M2egbS4JKmCz9sUw7ocqqr7Z82FOe3LiZo9Fa
   1/wj+QZbfaXk50VbAHJJqswZBWvA9Eo6iyvbtGTN2t0GKHs3AHh7EyTNC
   A==;
X-CSE-ConnectionGUID: bl6s0BYRRCu0TH80DPT3iA==
X-CSE-MsgGUID: DFWQLmQpQ5yFRWxn0vcR3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="401713"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="401713"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:41:39 -0700
X-CSE-ConnectionGUID: vkyYxDrfTW6/Prv54yi5wA==
X-CSE-MsgGUID: MausBWvlQFqGNYvkXcIgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="413712"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:41:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:41:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 23:41:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:41:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI+H9fTHcCAM5c+nHvyTTjx5dMQ72lk0l6USpfJxshX8qgP3cwl/Z9OF/D4rFmnR4AQ6q7a/Vky+YwHyvL3JxNbn/8iB4gSSlaa1dndbxllvZwl4CMTfVLRbc3NvXHJCuF3JcMrv7ckaODOQWVe34op10iCEwROsXd8QWfl7eN+o09BNE5RFumT66nVeE8u7DwrBW5dgvkADks8iyBsR4nLBrEmCFiHXSlD8sn/rGyJpdrYmmDLnE/PAEd9CammcCqgHubXVWydXzidIv9EqlUchY9KpCVV1n61CibNqjN9zgmRjmBjJNsqHO9S6UOklkXMLn9QCgsQY9mn98LRHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS2Sup/cFfe/5nVK9HhragO2D6vMf6nOC32RwcchJRs=;
 b=qUO2H7J/Vy+b4L/Mmp6o12vtgxG3DFyj6BOsuWr81PzjzyyoJG0etwMljOPValhuVHgYiP5V9hl3G3Rv0G8FKoFsh96xTIGuftrqyGKV0pcQptbYbP1PxeMORwHpBOerKscr3QhvnIG012WH/aQHHjIJLETr12g+OfxmT57wh74MK1cSJnhFbAl8fqzGjorYL2H/aV8MbaUb9dooxxgdQD5ikUaMjE8z2mlP+0MQoCIJpR+cidFrBT9//lyCR8UHzK7SNgXZrmCeQIvM0U++tgs1yCcexzXLmvICawlbUEJ4zJ1VKiQNiorQpc14y//f12oJkZ1yyoawDYsqwZzx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.35; Sat, 10 Oct 2026 06:41:34 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 06:41:34 +0000
Date: Sat, 10 Oct 2026 14:40:45 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
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
Subject: Re: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for
 vCPU-induced page split
Message-ID: <asnd7finuPqxXcUG@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091005.15567-1-yan.y.zhao@intel.com>
 <76157e3dcff065d444d83a9c5e7a924967fecc87.camel@intel.com>
 <asndHcWpIMAObuz4@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asndHcWpIMAObuz4@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: ff81aa03-77a6-46e6-1ab4-08df269986d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|6133799003|10067099003|18002099003|22082099003|261009223027099003|921020|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 8KUxHDuafXwVuPta4K9DEEdIzgeBzz7y1h0d9lwFoHctMlcxrKxYdfdjKYQjBt7k9p6bUAlAKsB3I9VrmL8u6QQpfr7RXXwY+ZB94T+9wTgJ7nPmMj5OJ3zF4VYqE6VVs1jL7Nc6JfLhfUmgWFVdtUPHpObpJfTI+8qWqtf61SicjjBxNYYM4ApSCVUIqJhlmc6ZIdgjBrlm5xvP02vA6nrYOJmYVa9QISW3sPdepHqBnVkALEPACVB4LuQI5fv41bpWDlOLzrqbZN6EVVCitUAAb83RLYUzJTXwE+OJbMJArX7IF6abSRuEoA7qy8qfNmgLqMELewNvl1yAYQ1ujpFJKjc2L6z4L0CpjiWdWLyUKcNMxnUpTW4gEwCFeZWrAEldxmO00pPyQgzpMTKSBnGFanzpi0Au8DIfbWoumMPu4/5PEH6mt8bMRWkKclvr9DQsfmJz4WToANql1yhMzELobdsXg4YGLagP1v/CoPmtuwtlGZB9yS2xTNmU0KIZHuG1GctnpNIdkRb77dlC53jTN2pAvARUG5I0rkrHBuJcK7wb0L2sJ8QnXxdVbqaG5bzh4+2BfvwbP57FfAZy6vAmVGKL89/BusKa6Ut2BZl8SCM+mTF9moFV+MctiY/R4hTII1veq7Q9YodJlZqdDi0C3SChAUAKkVbPcx5F4VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AbZle1Kl3NHOYwozjSmXbPv+WWcJkckhBoHIaItBsQNz9K2UQ5RXpe4eOUOH?=
 =?us-ascii?Q?vk7eBL7nPSJ1y0WTWtdHprlYXU6KMD5gpt1+EI1VPkHKTuzHt0cH0A1+r8+O?=
 =?us-ascii?Q?oiGmH18lPhKFF+dMqT3M1AbIoJsXWOkrZjFl72gVyIT5SFyVFCjQ5F55wbWD?=
 =?us-ascii?Q?fB6tUnt3gio6p2NjczFMo4gEhP2QsLT+6b6TA32Q2S4pu3d99FonK8AXYhKx?=
 =?us-ascii?Q?XdGTO8wpJC1A486RqKLa+KsxTM9OgbiBXdulu4ejetU/x95C3EvKRy/Dw+/M?=
 =?us-ascii?Q?rCDt/dfRz5wFZgfa8QwA/786TWNPRHQAoqhtKLVDnXEmDreTiBx9a0NkmnI1?=
 =?us-ascii?Q?mySK4SMdqcYC7OfFqJmuZSyzM5I/axQgp2eA39Y+aRH0SzGNRdh3zBttyJUb?=
 =?us-ascii?Q?b/GlXMtxxiuOzkK8whSVVNXTUbPtqyjZB1xLfE5m8NY7GI8Zp9bZgbVdIAT/?=
 =?us-ascii?Q?f02ns6H5cQ9d1RMys1T3qxi0xpj2HjdrMJsiKbrTkxWXHMYFpAapASLVvPxJ?=
 =?us-ascii?Q?iYxuEG9dRX9CHAFmL9fHlnImlsnpNT1r+CdAP9PSF9tT+pMQgZV6vGxAlVBD?=
 =?us-ascii?Q?mqNDWznj3YDN1XlPtScwRFdh3Me78cW+05H6Txe+Wt5NakGcZK4ZGsYyKr5I?=
 =?us-ascii?Q?SUV4vvCub01Wt4kmMjbZmvIg98nwUb8YiYV8x2R+mc17RNUtmZeeNfKn3bky?=
 =?us-ascii?Q?f6E+OmPA11ZxtwxDGQC1UbhJsO6fr9DvupwgM+91hZ4alc/t/fwubfyd+ly7?=
 =?us-ascii?Q?SjHbP3vpv+Py5B5jZd/LMYc6kFGoZhVDOsZaAtg2J+RJ/udHCkw7LroY/5q4?=
 =?us-ascii?Q?gnKZPl0FsQUIIong8OD3ND+ZSZvjQiysAlwYPdyF8p3lbHOZPp9fjl9WPkNu?=
 =?us-ascii?Q?1DzoLJpk50bHI1stgsnGUZQiPrCvxoZxQZ8+4K+9r3Wp5M9hccZO4NVvhFoR?=
 =?us-ascii?Q?DelZMKVSoNLWv9oigSCZ6lDPGS55yW6Q0jmVPQVtKjpBZBmWgFnSfeFpVrqI?=
 =?us-ascii?Q?sf2oJnGf/Zzb97HaCDfIjSfLbVoJo+DWc30PqDV+N1d9yF7O1TFBdNvgky5X?=
 =?us-ascii?Q?dFZiJKh5+vDOSYvO2VYkMD9cbMok9SwTULNC7rugpjDzPgVRp5XNZFo0dddp?=
 =?us-ascii?Q?8zMda/hVNRccZkH+uubHa1bwYm8KegVJyKeoreVJtXTfyZEPagFqaCbXyz55?=
 =?us-ascii?Q?0InYiYV4kz1fnliY0CAy07JFb+tgfFJKCQTtb04rbZtfyTj/08IcDm3LRfTn?=
 =?us-ascii?Q?V9ZYck+oCeQTojKmgMoM7/sQ38KU+0RSlviFRcVbhDXwm+XulvamnVhMIS0q?=
 =?us-ascii?Q?v1PLiIsjW6Tc32BiboazJoHRIlbdJm8UO3DwOLdcv3SqvmoIR9B4Z9W3TVtg?=
 =?us-ascii?Q?lecGQsGICMAngewQTCc17jYTG794n0YxSXSZs6AuaAIawwCvCmUDsO3kZz+l?=
 =?us-ascii?Q?DQRMXbuQLQcDiXhK37HK0d9lEG9uGYV3+GY6wgSuMWtpcX9GIEr6Vd+dd4Sx?=
 =?us-ascii?Q?lLoMp+SwrmVjdXYurnVEVMotq0nTl5osiecbCH3S2UYvkgVWAnFUaLkoxJTL?=
 =?us-ascii?Q?qYf1b/lWroG6Kh/3RUooxEHvagomZyD/leOHUyPq0dRm0TO0grxIB2FnDgOG?=
 =?us-ascii?Q?PRzDwb4atoSkxI9wZZ2BhGvBtdMfmzrrKoon6CyizU9gxwFcauIWZyZ6f/9F?=
 =?us-ascii?Q?Xl6V1RCLjKnGJGgOeZA+RSY0M/NTyj1+vkb2JerVHEOypJVOdm6sGPmxdKEg?=
 =?us-ascii?Q?K4NLSRKMvQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: vOA1Z4F/htXId91UxHoDvyQeL8nk8RsJGhPrbJzjdIs9hI6/wFnncxsDx9FF+PclzbamE3s8CGnk7+OdsMRLW9rDYc4wuKjIa2uIrqSsJldGgSLj546YMv9ZrSsnBcKfOAdc3dbZ7h4HQIdKb/GpnHVKUwYYiouQnjYT3ZGPpqWE3IDU1+idGvZCBT5qNySccoNqaD1QpQxyiif9Q09dzh7Kv8bgcHFFKes2YWSQXPi8ftzPR2Ko1tq60+seY8IePZybMcDVFJi8e4OTC085IjetZSH97TWbdqbvTJZKHYeZi0/Qz00g1pt23suvnKvdUctsa1Fk3OADbdt4LypIVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff81aa03-77a6-46e6-1ab4-08df269986d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 06:41:34.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3HWZKBSJYXZB2i+LEqCD3W7eZLR+uBwCoB8J5jmj8tmvtrAiNsUZHm6mm4CS5Z4a5xSh36gG+JTzGJ3wzC6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com

On Sat, Oct 10, 2026 at 02:37:17PM +0800, Yan Zhao wrote:
> On Wed, Oct 07, 2026 at 11:45:48PM +0800, Edgecombe, Rick P wrote:
> > On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > > 
> > > Extend the TDP MMU to allocate Dynamic PAMT backing pages (DPAMT pages) for
> > > vCPU-induced huge page splits in mirror roots when DPAMT is enabled.
> > > 
> > > Leverage the .topup_external_cache() interface to topup the DPAMT cache
> > > when allocating a new child page table for splitting. The DPAMT cache is
> > > currently a per-vCPU thread-local list. When a vCPU-induced page split
> > > occurs, DPAMT pages can be drawn locklessly from the list.
> > > 
> > > Pass min_nr_spts as 1 to .topup_external_cache(), indicating there's one
> > > new S-EPT page table page. So, tdx_topup_external_pamt_cache() will
> > > allocate DPAMT page pairs for both the newly added S-EPT page table page
> > > and the demoted guest private page.
> > > 
> > > tdp_mmu_alloc_sp_for_split() is currently not reachable from a non-vCPU
> > > context for mirror roots, since dirty page tracking is not yet allowed on
> > > mirror roots. So, simply add a WARN if tdx_topup_external_pamt_cache() is
> > > invoked under a non-vCPU context.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > ---
> > > v4: new patch.
> > 
> > New? It is essentially this with a new log, right?
> > https://lore.kernel.org/kvm/20260129011517.3545883-39-seanjc@google.com/#t
> Ha, "new patch" is relative to v3.
> It's indeed introduced by Sean from the DPAMT combined v5.
Let me add a Link to Sean's original post in the next version.

> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > 
> > 
> > 
