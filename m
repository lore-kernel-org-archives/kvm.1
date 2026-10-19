Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC31C8604;
	Mon, 19 Oct 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375239; cv=fail; b=Eq44W2slPlmMZEiLcZ1W8x+iuE+aSp8QZIac+jGQ8twDj0AUxYttKy2+eubHHcn2JFGsFsiDhLYxcK1Ke85IV67CHfOkaOPq2XRGStDGsp4lpVw7d+AO9yNUZDsBFdlmSsMRVps9t69vUgR/xh3ufU7US4yq/NcnQ24LswGdAAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375239; c=relaxed/simple;
	bh=Rny2UVcfbwMt1cxenm59XB/x0MC4m6xxdy2Xuu60Xzg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m35mtyb2RL3oYIv7g/gZrTlTfNZNthSFFT47Ggc9GfSwHYpI+QOXe1kloGOafbC0yGZ40d5kJCGqb+NZ6ZiVL2UN4H8hMjVoxmPISNY6to3QAiLClGPN9Cliqq/075vdCQhFnenviBzsMUclVWx5p+SfdaTRtCO88azbalikVYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHylOPnM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHylOPnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792375238; x=1823911238;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Rny2UVcfbwMt1cxenm59XB/x0MC4m6xxdy2Xuu60Xzg=;
  b=QHylOPnMquC+yYkRN8JjO6WX9zYBcwTl7oYePbglxQ/xJ7JwEb8VGUxn
   a3PFowuecLCe4a3iX81elK7c5xb09mCIyXqSCEFG7oyOv16aTvMOsV4lr
   GWjhtwpbZnktkstsnMUUg8nU31RSfs+gpuiGxAVJMa6PMjEwnlt/2payL
   vzDKhQb8WcfaGprfMNSnBApUKM9JKbJQYLpsZib0af2m8TDNfyzR1ILIq
   A7HFBwebhDwAJLLtLNmS9qVybrQeGHGTTeJsxzrnReeWmj5+UrOWiR06L
   Z5rdht8W1/Mq+JLt1HVps0L9hgx5L8L6Qf+sHUhYUz0Of8QvoOqFTa6Y0
   A==;
X-CSE-ConnectionGUID: Oqo+MwLbT3Knw+LDuCJBcg==
X-CSE-MsgGUID: eGk2fFbnTfyUvTg5Z8Xi3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1077439"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1077439"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 19:00:38 -0700
X-CSE-ConnectionGUID: Fv6mD3MWREe4Vl6+2QndkA==
X-CSE-MsgGUID: 4tERhbGET1SL0z79QG/fFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="4165163"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 19:00:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 19:00:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 19:00:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 19:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8peb/W6Ue3UK0FMXuSVgWJ5ch18jpBLQ61PFadhFOi5d6t+1BLjuzE1ueNSSrJGFqEWybBe4d9GyAaQGJiqkmPXIVh+zz3arbIyYzRlO5x/eTbkau7HLco+sYVUcM5WBC1fImQeYFsvueApyBGOEBw7mD+LtrNgzrW4ouWxO7EVAPln0JYyYfamgYTGgR+pgn/6AsWWi57Tsg5/ktW2vMRLUDUy/IfzhvVFvFiy32hdWSPh4hCma7btBUH4R6NWzrjeiW2R2aH9Vn6sAFB3Hiwv1Vsrih2Zd++4xMVlm0L75iNcgpISXccodxS2F3DLKH1yXQ/PhsXO2+p7YODanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZImBO6MHXyJX5Hm/oVtCZhx1rVh15yYFe621EQD6W08=;
 b=AYXK8UqRwrLcfL9SvI15c5xGgDRpNkSHlCyb9kuSojkNTEeDN4nhECWe22kNSFIP9NDbPa5YtsMAMa5dJS7MoAKaWQ//m1iyWBTJ4g/sj9VWxRa+fwzA/8np9FtPnbo0m6qXmEAA0au1YZ+iFi7C167IeY0puq7GWZiz5YYdWqiul1PBSSZwS5bjSs6ADbsq5LsF8f6c/8vdxMfdEBkRXeRtGXzaI2tUKM2aZfRyeprKaf2fpu/TRYwUqzvjfxSQS4s4NkaumQEvTGCVljvIpdGxLzWlIVZwAsCvx11GlNvAvc+AptUqhdpAB4RjAhMZQpHCnA/4g15SAUooD1U8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:00:26 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:00:26 +0000
Date: Mon, 19 Oct 2026 09:59:24 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"tabba@google.com" <tabba@google.com>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
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
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|SA1PR11MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 742d57c2-ec98-4c27-2c19-08df2d84be52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3NZH6QsBtsevhJFT3pLtsxGbXDEO00wa22exrBA0IfAe+ENa6xfAOQ8UKY48YEh4jctPmLldl6AjoFlfLjLLP4EwRpyL+aZsrjYPTOFj+GbB27xXlEDbeQ4VNIQs9h2gCzqshJRUuiFKHAvhuD7Yh1bclrl44tmvLRACtZSbV7VpiYpDq92P+8C6FVehBBXSXAnSzvgyIdVYHuVW/Ded4eh4NUZTCfyYbknsZD7wueGZwZEgHCRf1nplovoUsuDxmqzs9Usp/Z4IlF5FrVndrlh9e8aZ/7rxpFrJY2Qy/xyR5rMt5XJgGtBABwbiIOkcSodZkx38xBtqcgi/cbtoCYDUr+5wFuPxinomqIZ37uRcKSsUoo9gOw+8uW31FhbHVnjCQGfTOgxEb/dsmn1oDnouEZHCTKm5q8R0WYOZ9JgUqCAK6CbdkhTxDyyyhYRLNDjmB5wdj09fp1a+UN7nKiCdHQQZNCPKqCXWvjDhs1dMTGCgQfjZeTGMxVyYieyWMsq3HLyAP0tld3JEKmHKJdY13VoDOWro4aRcnpOnVuN//S+HCQJnbfEVN7R1KS5pcBFDPQnnwVlPDHorRotlHvTzcsSx7+2PrU98+RWqZDIOnlMGJiqGILEccAUnukBXvbiTqNFtazxC6orhA2/FOB0hWfx7IoTKJ8a2bkXpgqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzD6QKSgcKTEHa3+eRqxqQOgqQkiwTGlko7d0+UcRhmJ2slDJsDhhyQrf0Hi?=
 =?us-ascii?Q?lTwQCrV1iilULFJ3PVJyoP49djNEcVhKh1m8JO62EtH74j/hZDhcMzRc4kE8?=
 =?us-ascii?Q?oJm0TnKs8fmK8TdYxw5x7JIDFGciajTXdSFUDBuszj1rbL9+Z9fOhmrINzK6?=
 =?us-ascii?Q?JGKGuUsLC/Ad7s2LPNJt5hVjmpGqA5NKcfbXNuTyXB9l7ErH1jrE42OJNrfY?=
 =?us-ascii?Q?kGkmWAUSYl84BNDwJWPuDr24RH3vGfLTuscFXlp2zdgJ1i+m9qtHdGThbFl6?=
 =?us-ascii?Q?n/oD8XeMgx3bMc4b0CGct//UMjkNZZi3e0ASThN6aAysXLkhc9sesur2aRim?=
 =?us-ascii?Q?4emK9cyByBfbkX+VdX2nz7MtHi7oQprfENynbTVFdVSMUmqSs/ACJ3YcgI5r?=
 =?us-ascii?Q?hzSQOGO7wUJiR3wdGX31VVJ9DX63a5lwJzk5wGVsxnB7JvE0sS124wsU+eIW?=
 =?us-ascii?Q?uzCFATQ5KQ7PUXmNmmX3tWlKP3wKaQDiCh+YKr7Sn8zomu/FR6Tc8/+5lXu/?=
 =?us-ascii?Q?u2G2ARuqnz98QtFJdnUQ++UmNJks4Wcrg8S7dWuFAf3oStGN6oGAysWgQtKh?=
 =?us-ascii?Q?jPa47Gn7bXMv2h85vukViAUC3Kl0zoGg/n6/tktZS/+Np2e0mOklLZNJuaFW?=
 =?us-ascii?Q?qHzqVIHnimDhquQFYBhrXigaz5xNa1RIdRoxLn/rxCyO0Tnz/GIcpYcAruoJ?=
 =?us-ascii?Q?8/BTyqX8ZrsmS2Oz2OckamXd/pe5KcjPdSSLlaSxFzqPtYiu2+ib17PUq5xi?=
 =?us-ascii?Q?OLPeW1WdkPGjIRWwP7BNsYrJ1qoaSgWM7kI0pqLk1F+nOtDVCqi5aEJKoMua?=
 =?us-ascii?Q?RCShtFMTk1+azw4w/dH3d/aHaeM1QFV+CPFFRLaj4wBcoCcUbA1fJ//eGPnP?=
 =?us-ascii?Q?xLl8RD+3N50VEY/CIrtDzj5dORZBG/SEZ1JVKVrLPhQ/zY2J4jFX4eLBqN8S?=
 =?us-ascii?Q?gh0B4KtUKjZhpXy8+kyk9PrAbZ3gzeY45uQKGq0dD+COXdD3zbHNIamM5s2t?=
 =?us-ascii?Q?U+YR3gsnnQJxTJt1PhcH6EFqC1iwVHe1E8AcUmf5qn+JdzeM9e/pw6orQlFz?=
 =?us-ascii?Q?2wwU4wvZ0k8o5If0sMfuhfcbA1qhn5L8h9HCwf4Rwj47igDsebAL3GYa8DRS?=
 =?us-ascii?Q?iYWU4YUfniuo60aa2zUqs9HdJAoJUhB0QO7FYbeR5HWCxr9D+3geIY231tGt?=
 =?us-ascii?Q?l9S6SV34iHiSWFggyHJdpbJt8U/pAgnbem5HzLt1QA1VKgXcVBXMFCfYqrnV?=
 =?us-ascii?Q?/ttDkbqoXZA7kB8hmroL0/yNAs9elT5ADuekzC9T/cAylK/qr8IhC7z5Hih+?=
 =?us-ascii?Q?b+7Z/Idc0zAATqTCGSsoRqIwVWdiEUP6PNVfcuY/FxRRg/FN7qioFyWx2j50?=
 =?us-ascii?Q?qJvkX8tFynlNZFCtLJFsNjlbgIPkD8U6Qp/yqVY/maH4P3YkDEPY9pxMrKCN?=
 =?us-ascii?Q?Tr98P6pM+gtAvZXo75NiFQLH0MaQBfK/dftm6GfJwOQ82MILn752xqRVMH7L?=
 =?us-ascii?Q?DO2Cjr7FXJJiyjxHG9tGCY7/SmwFwARQclM702QP+Bre/p0NiSlC5M5Ix1OM?=
 =?us-ascii?Q?XJAtG8VPF5gCC4xQoXwbQI27DmBRMpXP/Z0HVllmt+Cvz79X7DVrPKCegKbU?=
 =?us-ascii?Q?QkKLSS2mEH3HQrdNIPJ7YD78mBA6QUge6hOiHrIkx/TrWyqU+vUI2OhkG1vH?=
 =?us-ascii?Q?ukAtLoGsqe16W69lh2xi6acbYwqoqhPMdaNUpM5MTSxfRk4zUVxXl2RlrTZU?=
 =?us-ascii?Q?qriuD/NTiA=3D=3D?=
X-Exchange-RoutingPolicyChecked: seqN9Hc3O/iwGx+nenEjzoPSr1ftPsG6QM1YYI8HJX5+vGiNVHxY7AA7nvjZaGhWeCIAGsvwyJfiBGFDY1uZStdQf2MIz57rSq2F/oK6+fEbi/8RJHmpWOeywO45Q/I9BEAMricYS1PE8aOalhdUDeQn0E924iz9nStpDQEa/ySVe+cn/4mW8EkdhopspASJMLb4pQHVwQqrflTcG3a2T2+U1ay61hCTAqT3/LQqjTix9JkipDRc5MhwqHtnCIuQJYpcw3AaLGOg2MveND/zqcDmP9kfIu1kCPE6wpkC6vFfNyIq/cUEiy6HHLUtR7EXHE9sn70L3Gy/5XSqnR0ynw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d57c2-ec98-4c27-2c19-08df2d84be52
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 02:00:26.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97ahP5bO9q0MiKTdhrbSZeowBqQURJXCja54DCgQH29+hi1faB+y+Taew/o+hsQPksQD0cn/iFwiG+F4PbQq5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 01:21:14AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-10-15 at 12:47 +0800, Yan Zhao wrote:
> > > The point of spelling it all out was to make the contact clear and the
> > > implementation doesn't have to assume anything about the callers.
> > Hmm, but it's hard for the caller to know if private_page is true.
> > We should avoid leaking TDX specific knowledge to KVM MMU, right?
> 
> Wait, why won't the caller won't know if it might map a new private page? This
> is basically to cover the +1 part of the "+ 1 -1" in the calculation. I was
> thinking to set it to true for normal ept violation (like an accept) and false
> for split.
In TDX's .topup_external_cache() hook, tdx_topup_external_pamt_cache() always
needs to allocate DPAMT pages for guest private pages, even for the split case.

However, from KVM MMU's perspective, it is unnatural to specify "private_page"
as true when tdp_mmu_alloc_sp_for_split() is preparing the mid-level page table
page.

So, I think we should keep the current convention of just specifying
min_nr_spts, and let the TDX-specific tdx_topup_external_pamt_cache() account
for the +1 part for guest private pages, which is invisible and should not be
exposed to KVM MMU.

So, what about

topup(bool with_root_spt, int min_nr_spts) ?
