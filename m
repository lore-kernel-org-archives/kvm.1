Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7200313E03;
	Wed, 15 Apr 2026 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776222090; cv=fail; b=YaePwJ+riWGD2iHzWyYcrWWseZgWpIfSvnEAK5dFdbFMbg/4Iyk5b1fyVheMgBrKcabYvmWUsAdL+kD2dZB0ksvT/FeHRTtf4x/I3G8PDm8nGwBCursKp8pgSuYf2ukK4itd1dHITtHIxlree861T+oKRAr9wAMkX0bpwMv8MIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776222090; c=relaxed/simple;
	bh=bvB1wUHtyQ1sk5t6tdS2NOWdh+LvsiHnxnvCa17O27U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i0KW/NPEwF/6JBlPKJUAOf/l21WtMHyt/ol4ejD4sOGhifhuye66MY1rBtl97HprpbgvN9WpAcaEE68CYXZuOThYJuwbLEXKpYvfRt/z8rmPhaOVbOWp6a8CFGgWo6oNijdOL4MwcxUZr80ARype+kuCdK/tctamIEfqYCqjR4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HplqXr9I; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HplqXr9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776222089; x=1807758089;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bvB1wUHtyQ1sk5t6tdS2NOWdh+LvsiHnxnvCa17O27U=;
  b=HplqXr9IkOFL6F4q0TfaLK2BxaJNZxE4cXfL0nL0qEtck3Kaxrccq+h3
   Et0NCw72SRyR8A+LjISz++WG0HjIq4pZCkG6/0WN/Vf5vuJaeUSamatHE
   Q+fvAG6IRQZFr7UvK18UNn6X8RxUbz/bD3nWH8Tr/Eo+6Ozqyvuyeuyhu
   AjSNZ3b2cLFNR34YJIhcjYPCQxaWF1fybRGCp+aR6JoiiJz9IHKphKl+7
   vy7iMfI4eqSieaQecd5HaSzAevapbV/Zf3TJVZl/kYsOxy/WjSovhoaqX
   G7rsp1n3kZ698+p1PQG4Ps4LCUa1Nlnp10nzRjO/96cXvlfI4olS7/90G
   g==;
X-CSE-ConnectionGUID: z0xshAbwRWGjSxMCprSF4A==
X-CSE-MsgGUID: uZ1A/NkqTu2pRg70MBpxAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94760401"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94760401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 20:01:28 -0700
X-CSE-ConnectionGUID: mHEV9MCmRIe9yTuPdp/qsQ==
X-CSE-MsgGUID: qgRgQbpwTdOQamPT97OfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253485642"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 20:01:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 20:01:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 20:01:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 20:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWwC1cgGk+2jazRRgbg4l04vVhMXzfMx2Q/zPmpK/+dI5BQkvSEI6QtGVTtUK1RgEUjXuNzSCagbteB+2k5YmcUGIGqnk//U0w/u0eCTSPK0/TX3A+1mjfQQt2bJ23OO+tAnXJZ+g4KTkfC1aF+smHkm18VnoSG94mvfTSO7Iv7/XXfUL0V07bdj5qSFAi4cS0jPgbqDwZlHdGsdBAMoeUpZa7umkFUFJfuiJOC5uPkBw9FXuk6SDiCUrUAHK/TWlQmMU8xRVM3Z3Icg2j5HkYy2gfk//NvequUXE7kjhIRSP0un0pOCXFw3c3Fx4a08khCHHJoun35IGwu+B4enpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkVCEmn1t2cJ66rVeOd9dZyij8Wx/a998qiSAKJwO6s=;
 b=jEzGiwlHgzji13ogA4i6sU+tYWlhQwU+pW2bjfuMEUXoL29XDZSP4xjFvhh/Vdough1CmgE8L+pguh2Ya7zsF4j7zHou0XdW6TdRwlriTWSUcI3/DUlh/Ta42pmMY/n9C5vILADAyf/Jb9RNd9sEDI8uAxgkOZxQD+j2nc0NoNfYMR0Mzqv48dddDOE2AWxHC4tctyZYMoQZS7Nic/4Yhwpc8R5ng3F//ZqS2tNWFi5jI8t3V8IFMI+TSKdkMkXknYhsZzqrJhL2faEqfSSXAuHbeUEtyMtpDq+YwyMAwz8VsL8O/XGIyl7Jn6FOTAeCqlriVOc6nWwHhS+YfCWU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:01:16 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:01:16 +0000
Date: Wed, 15 Apr 2026 11:01:02 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update failures
Message-ID: <ad7/bkVuxmX+lQhJ@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-23-chao.gao@intel.com>
 <e4cdab7d83bfc1c7fe3b5759a987c71b922585b7.camel@intel.com>
 <ad4WCJdJ2MrGvkWX@intel.com>
 <2b1741f544a395b75ab60617a9023651ca99a9c8.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b1741f544a395b75ab60617a9023651ca99a9c8.camel@intel.com>
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 468acaf8-d0e6-4a03-f5a4-08de9a9b42da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xB1VxDzTAC6Vw5irCt8K/wmDZI4jGHzPtgqHYK5oQDVkEqtt8or6xAWKEOxnIVZX75qDewphS1+SSsQ2txm44uacZcfOVXhF0gwyP5PgLWuElBPme2s4ZQ0Oy2aatFqz7zMXf2dcVdw/2pQ9lM5VhzTvb+sVf7Z3VOMZ1+fuN0/X7lzVF6FyxvbqrkCxn76rbft3NplGP/bEClKBgkYi48Pdvc4+45/C8LU+NYFFASogWuYbdwXxGlxHF9EmONrPt2bfE2Ll6MfGEnTFa8kkNgXAKKgV0F7axMUKjK3kqI1OhJAcxElkbnEa80F09+2yajMtYNHIeKR7nbnVg6wE+BfmYaMZKc2aKTwo3XE8wpymMcHQb3uc94Iuc46k6dgLLpxWzMiiqlvj2BSJX+onLnXts2FiLGsD3FESaoF0SLBmQoRPEuVMNyqHkzgCE9AzZFEj/w4kcCqkckkTpCoqLSIfg2DVTGBt7R6DmT2OAbMEmZsyX5dnHfoLc3x4iQKACysu801bZrR5CEwuXVnQBTivAJ8YGnJ8NNxiGDb/c43EJgW3XCF3frdVMYFq36HRq3uUqLp81g3IHqPOXzIaQ2SrFJj+mwa/OxLd6Fh52WcMHGjHPC98/B4KucZ6nT8sxQglIW//6Q0OB3E+Dg24asp2EpYrha8PtjTgKJsyKVCtW4tU5CopZLcFireJFm63
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BDNRkcEWwiQ4A6y8l+FeLQpoujgdUQXSd5SbJ6nIuIne/AzyDpGVZtvbPcbv?=
 =?us-ascii?Q?D+yl5xllxwgn9H0hqiOEUfS1S5LFc//JQ+FqoWQbjWkiSgDYQ0lt/WV31RVJ?=
 =?us-ascii?Q?jOqnevnytabdx7Qs/ZBooecrwMSB10Jo7iRiHxCaLmoXMg2uq8WpAB1tJJ+Q?=
 =?us-ascii?Q?uybau2P6qIGHO7XRLf7iCF7fVEhQuESzzu4pxaWXqwaYdeQB+AfwDqL+5yqQ?=
 =?us-ascii?Q?DW/YrqSsMk0pHBtaVp3sknyzZB+RU7JkqE8i3A8d12mmLQAd3x9bYA0ktBxM?=
 =?us-ascii?Q?lDINcEAyL/uCCC2PuZ6KbdzpeaJdcJSYTsBWAKCREd/KclIJCrW7VYj4DiIp?=
 =?us-ascii?Q?IG2GBp4VulfHQtOrCAR5Yol5hlkKmQcYsidWNzGaxF3mS9AC3NlncPpr1J5y?=
 =?us-ascii?Q?ADg+Upkzx8Oe7Jt0ZTbMxWb60DvQeQszamHpjtAURjLFa/LoJAsEJPRJZ+TZ?=
 =?us-ascii?Q?ks19nidVn3klweSf6WBllrfGC7z34zVzN4Z5lHFPJ8xsnKrdMElB0MvjpkfZ?=
 =?us-ascii?Q?/MGBJzqOeOqwGwpLayO0Y65aK793mjqpoxW96Mg2msElTSrWEYLb6yLFih9d?=
 =?us-ascii?Q?RvtOyHhDFxhxvUG7wrzL47kj/hhi6mly+alBNHlrYxEYhetfO5nWqm0cHbNc?=
 =?us-ascii?Q?94JYnDUNtTFc0GKo9Z21eNFePW+2vV+cRaJ8AVDAzIET0SMS2WUFnS/utr/7?=
 =?us-ascii?Q?lOIysWsp94s927c7GqzTiupF6t82ghAnX4E5rmpOBJB8ay2uoaunZ2Yz8JXF?=
 =?us-ascii?Q?qzudSLNQpJsqsg4aT5GvJJB4qRhsTbdpG0RTcxxzgqpc7UZ5cxeFMNMlaUis?=
 =?us-ascii?Q?fh+ecZSxbge5bA9OPYwaxXOVbysnMMUIKeFbjIQOlSH2JUmY+UoddTahXXV9?=
 =?us-ascii?Q?EzVVA8uZIQcp1GCwKESzPcbiJEsI9eKh3XRrpVYyd3MWN841+UJa0v2WnXZ9?=
 =?us-ascii?Q?N3eameMJPxf16Kac6Ck+6iAkqza5LLUADnWryA20qD9yABMfV4T6SK5k3MjL?=
 =?us-ascii?Q?c3OKhG1nd0+eXX7GQ1M/V6MbKF+Mir7FNL3dR2OWbxFijy4WxcxoVCSAmRQ9?=
 =?us-ascii?Q?pfcL7Sx6qKeKIUq43/fWVwYeYSCc+VtdsrTSt2INcB1DAVtXTBgNi9Gg2KXR?=
 =?us-ascii?Q?qwmHfMmJTziQNNxuSdcS98aVHfRLy8Ub9RD2U0InfEfL5ka/ACvjJ3z1FQlr?=
 =?us-ascii?Q?sX7fuaUw3EobA019vHk8QU0WOhU2FcNYgnSkpcHOUKDPSETXV07WT0lzhDDr?=
 =?us-ascii?Q?wGmZqj/kc+8BPK7DA8kKnGh9crXw/vfPlY8paROeBxujFZ5PKbAkXRff4rCZ?=
 =?us-ascii?Q?jv77LufJsnMqXNGNeHuEZySrWL13VlRSXIRs1OzfrAb6qo1ZkfhUpHBam0gg?=
 =?us-ascii?Q?axSaOSyyqaPmstq1AkR/127nL2ShB1BKT7MKaL3bwQpOBvgaF9yCxX/8avMo?=
 =?us-ascii?Q?rDNkN1Y11lcL7LxgE3FT+rMfQ9KMaQbM1kDpJ2rFlzCgZ4xrSUNAiNa+R85A?=
 =?us-ascii?Q?YZWhCQzFD4MbPmJdQ0Q1NN5j7rDAEmxFUHUvETdAXdBw8Z27nTEHyXMl5rws?=
 =?us-ascii?Q?n74trbTADtqDFUNQDRVuXig6XYLnIrtH6VNSzHiejlD2Gj+dtHypI6TEJ/hz?=
 =?us-ascii?Q?beOs5JPW9KBNmfeU5t90CRAjQWwUWQQyFRmvo9Ton/1Xj/3Pk6aUzMappSV6?=
 =?us-ascii?Q?1PBImg0jV8OZOVDidHRJBlylToX+XTfvFFOhfsNtV9Mld48xGN5pnW0Ag3im?=
 =?us-ascii?Q?4keiIUt6Jw=3D=3D?=
X-Exchange-RoutingPolicyChecked: U6e6lYnHcq5qxKoRIbLPpLHPwlK+/JHGf5OL+fBtqhgvgevDrr/IAXLmS5jNvmWxXfKRR/vvncVNUGhTPfPHxyBBzkeq53BnNFKgMpGerOZAEIIrqSqy62/u4AbEyRvQOwWFkowPKR7OHMrEIjYLoBt2I7AXw/xkl8S+tzJN+fghLIZ3SXN+NLTUhu36tY9W4BeWEvbiYn+Fkbta3ZVnh6AUuh+qChMyjGxU2dC+BwbSGZ3sAC0cb9o9REALYWsPm7AVKNdBwbrgMXcKI5fUMMnd39wS4sC+6tOv3WJVFI0blv/DF/FGbGEYG9MnbYTe98rl7GPW2pYdnl0n9om3nA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 468acaf8-d0e6-4a03-f5a4-08de9a9b42da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:01:16.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a02/34+Yjv9V2F40D5yqreM3z1hSNGtFkL/bOFJEUs6+8VZPaUFxahx+NcYvdsaszhfpONYAMvsyI1Vx9n6LXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

On Wed, Apr 15, 2026 at 01:39:07AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-04-14 at 18:25 +0800, Chao Gao wrote:
>> On Tue, Apr 14, 2026 at 04:04:05AM +0800, Edgecombe, Rick P wrote:
>> > On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> > > Currently, there is no way to restore a TDX module from shutdown state to
>> > > running state. This means if errors occur after a successful module
>> > > shutdown, they are unrecoverable since the old module is gone but the new
>> > > module isn't installed. All subsequent SEAMCALLs to the TDX module will
>> > > fail, so TDs will be killed due to SEAMCALL failures.
>> > > 
>> > > Log a message to clarify that SEAMCALL errors are expected in this
>> > > scenario. This ensures that after update failures, the first message in
>> > > dmesg explains the situation rather than showing confusing call traces from
>> > > various code paths.
>> > 
>> > Why is this patch at the end? Is it not valid initial behavior?
>> 
>> It's not strictly required for the update to function. It just improves
>> debuggability by explaining expected SEAMCALL errors after a failure.
>> 
>> I placed it last so maintainers can easily drop it if they consider it
>> non-essential, similar to the guidance in *.
>> 
>> *: https://lore.kernel.org/kvm/63082cd1-15ab-4aaf-83ad-f72d94b9bb8e@intel.com/
>
>Dave says:
>   If you don't need it to "turn the lights on", I say kick it out.
>   
>To me that says to drop non critical pieces. Not put it last with no explanation
>that it is optional...

Sure. Will drop this patch.
