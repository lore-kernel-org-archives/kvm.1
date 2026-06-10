Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAB285058;
	Wed, 10 Jun 2026 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057712; cv=fail; b=smNbbWbX/AWX4+UpPcnE24/D4TH09T3XFv/cBKZht78ubrHtC8BmHQ+OFlxzVS2LT2TP7TsvJeDgrLAm9xcFVca9znL1vYLqeGrUHG5QdZ36BiXZHhPswAlxmMUfNh6i64rhHWOoUdhpT4K4ZupX1mqm9rxbvq/f5tBoLBJ9Viw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057712; c=relaxed/simple;
	bh=sWOwTXHnqg8rFjjjrkA7moK2EKayIajtnHv5MyMMQ04=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwtG0cYG2mWam3ee5S3QF6GBLyz16uQXtVcBnHrM/ugTil6HZC0bd1h3rIBvi1WqQX+RIs52DQWCdVA+UNGjm3vTqTKu35LdmlxokGOvRpkXMjTXWqG8XjLiuLGw9KAd9524tTYiqc0Fv+7kZGYj/4poKzzf6BZIFkssnzrM35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S84zOBup; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S84zOBup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781057711; x=1812593711;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=sWOwTXHnqg8rFjjjrkA7moK2EKayIajtnHv5MyMMQ04=;
  b=S84zOBupMkbiuR7Tn5G98/C5s/jMBEGQU7dCTo2N+Lt0vtmac444YHSM
   w4ItVddhn+SEZNGo1V5ji0IC1D6B6pXeiIXYCs7O94r0EQOt1eVC9or9K
   utItiKHMWTTlAATmAS0knbwb3BoIgLJdeICVKLQmlZxsVJMKvp4E9KRhl
   hZtRdbmQOC+cO8k9AaZ3tQKw4f3rCQ+3vKtj9PP7PzvKXLc/wuDCUkUZe
   zgnrM1MKeB7GKW4ZqrXWHU5/EPWPcADVqyV6mV3Ek7Mszh5xnw1ARU53W
   tajPyTjIf3fQPYfYT8jIk60+oZf8r4mM76ycDxY0Oqi4QXkoee9Jb0WX8
   Q==;
X-CSE-ConnectionGUID: bCz8v1x2Tf+0Q1Lo2fBgzA==
X-CSE-MsgGUID: 7MGVUkEyTNOp23KDCO4ZFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81691256"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81691256"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 19:15:10 -0700
X-CSE-ConnectionGUID: A3oz7ConS2+vIudCPC4yLw==
X-CSE-MsgGUID: eYoOdzDYQQycYL4ISpGFXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251106209"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 19:15:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 19:15:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 19:15:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 19:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNm6/f7heO63FK0cfOU/65qXz3PbPHd1JOXEUIZbfSLFDJcTke3JUdMuQG/mS/0rP2KnBrWDEN3gkIEiqiwzjxMG7+gQCjzNWk2vGgdTuBNF69zdA9NYxiUt8KJ6WD1zGpjKc2jLWk/xt2kI8fghUBXXT2hWGVCFv0OoGwOMT7WnjpHknGiq2o3Uxqt77uB0TK50cszwCQFOwWyBo5DG7rBSzMgJBJNKV/3dwTmiaoMTM6K+Ser8eAV8UqPgZBjfwhwhK96jxQP7I0+hXSvGG9qYdeBbKue2JRGFWoi+1XkvEJU0G7QmTEybZICXEysjN1XVNfJNxKaf3A+zW3oozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpvOGEIqmaOPal5Pzod1bUodsedjXQFChMFIatRefIs=;
 b=ewUx9BBttCkvwjubjOcxuCpYkHU0WM9pDLAbGUm/pk8KOnTxW3Yd9g87B56dxZm/rlm/cnDVNijlE1CHTjTWft/RsQYgMbdU0/8LricCLQLso+iGRgB+pEVZ9RYCGzELKd1LSjtc2QPkJVVM621fBRmonTdBEZg1tYMwOmiyR2ly+lOb1lZNb310j1GEY25UPvBKa8jqCDlDb+Ycm3HOr6q30Fn6TpuKB51U8Hiv0AblFnsppXoahwWA4DDyRLXHC3yBEhgxbpP0XFsR2TkhjezCF8vcPxZoI8cm7oMm2Cg5uLvbAwpTFAtxR7e9d/LLB5RN8umkCceVAeJ4kcbR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 10 Jun
 2026 02:15:05 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Wed, 10 Jun 2026
 02:15:04 +0000
Date: Wed, 10 Jun 2026 09:34:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Annapurve <vannapurve@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aii/OJdWZYDhn6YS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20251113232229.1698886-1-seanjc@google.com>
 <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <aiDCkz9V2aS5Qcuf@google.com>
 <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
 <aidvQyD6BqbE2_A5@google.com>
 <aifPUFncRYYpURL1@yzhao56-desk.sh.intel.com>
 <aihMgs0Zj4kS7YWv@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aihMgs0Zj4kS7YWv@google.com>
X-ClientProxiedBy: KUZPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:d10:32::7) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: b969dc80-7817-453c-a472-08dec69615be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|4143699003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: s1AwYaNZW4vU+uyOXnnLv2U52dYWUXb+P6L+aDE58cn23vlo5cwy5bV8okHHL7vfjfLBoCepAUyurABdh73y1Oip//S1GAO8UG1QnWnTsR9dQFhgnPBRP94pMmtByoXQ+Ic6OfNr/soI4xjUHZxkZHaQNexedivSC43k1ISE9bur3k+9haSfzOAb/gmeXjXR0J/U25hbYnemr1xJcku8kgo04WZkZR+jdDv8mUpZtSfyL6dvLH8T+fsdoAib+J+NnV4HXTGa5wZhORsE/1vNOvSXvD5QL80Gr7tMTMbNqgsDqd0cez0mc78R1d35C61CyMGDDbvghRnn143EDvJzZ4R1QkGjnYQbmYHyOTXO92MTcCheDEtUJhX3HTgCQkO+27SnDEUAO+N2lCQIEXX8o4/bZWNBt/wnrLO0l0sK9YsffOb8PN0nPN3i48AFBlqJiwdUtEMIYBX1C+DTiEaHYMqsStKtU7mzuCHQqkrn6aXakvMr4CWsWQ3wu66PiJF15w/iyURdUZzy76t5P4iw4VCt5sOWuaCcy3P+KLm4InFpjEgzvj0Q97Fz0pUf3Uyo6zIs0omhDNiTEtHt24o6+flZgOPR2RLSvKihrWMeayuace6xc3oO7q4CdEZqxQwe6ZBKZBQ3GCgcA582/3ubkW/btNADWs3M1KND036p07+KD/5CaD4aXXHLCxwmDPxE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CyHQ63xfb9qlNVr3nChXix3nQ3SSKj/tu7vMpNznCxAMEkdv3jvVQgi2mmFk?=
 =?us-ascii?Q?gFuQh6wD+3bKR/JtizvjKzux4LeLDsQZbG3OPu3bZTGfKeVwtGzkZ3DjuYdg?=
 =?us-ascii?Q?7LFFLfjxeoGEIHBAsQH7jEsgKKhIRW4LKPrM6QqBmqQmjW9QfAIO/YGAOVIR?=
 =?us-ascii?Q?dC/b67SLs++kYe/c+fjrPOLQS3peT0ONkILIdmenS+6m2RfER2D4Fyaw6O4r?=
 =?us-ascii?Q?aljR5hdIN4nnUNpjwnAfJ760b2Doj1ZUP34cbI3CmzKqnE0xszUPjT1afYXJ?=
 =?us-ascii?Q?u5miIB4B708ZecYiqHzI20WgQBVPz7K1BxF3LwuBfvCnuz+MYAOEPT/f5ezQ?=
 =?us-ascii?Q?vj82IqJMEe7MYuW7WH7YlLuAatVgC3Kkx5rzuONfL/XWTJmgwWkWQOa2yfmV?=
 =?us-ascii?Q?l7RPsCCOhpEfXfyZ2QXXaAzGZUyoM17SUWrE8xf+JitIdlSTibCuTTiVqsc1?=
 =?us-ascii?Q?o4pl4zp5d11UuqtI2Zidm+qrcbPdj5R87Et6beFxBOhH8MNN08EfqDD4Zqfp?=
 =?us-ascii?Q?mTO9kE4RjLKnBY4TNzeBUjfCCWJw1z9QQx6ccSepELxHNVjR5doRc06eArEL?=
 =?us-ascii?Q?vAN1ydad+AnkiGmq1NnSCS/xGSbKYWJjDD70NgcrQK4/S3VUOVgA3zdQvHxq?=
 =?us-ascii?Q?rJzRbikXoiF3Zw6j0OM4PVDNAHvWWECR9c1it3w0JHJDutXZHHERDsdxmdAB?=
 =?us-ascii?Q?QISVG1gyl6W0KhjApGyu0DgNTijSDKEUcWxIkUT6QbREYC/nzVs13xqJwKD7?=
 =?us-ascii?Q?VgRSjf3lx0JU9XNNOUEaqeSBDidvx4AgRj1TqUgtwKD2POKX/8BavJ9XLqsQ?=
 =?us-ascii?Q?7LOuwRr6E40sz1OV9whYCMlRmdGNSAOW+A/iD5/qUQ3ugT/ILDBQ4YFxcqM1?=
 =?us-ascii?Q?B9mH8d/P57Psiz40toiplix229b4jzh2SEKoMw8PM2uxx/xsw2UrLStzpem4?=
 =?us-ascii?Q?cXJErW55vJqliQUYGZDxsNo4HS8rddlySShQ4KiyZqLntFNoSECWdqXeyOtT?=
 =?us-ascii?Q?iUeIMT8pkknWNSgapcLmzKOhxUqx7JI1KahMePZlyEEnBkaURDcyMh50o9eO?=
 =?us-ascii?Q?llX1ygNLhk6xt+HoMuZKfsssLrTC4WrxVCFq1droVGkgDo08K1NzZ7BfXyGJ?=
 =?us-ascii?Q?pYi1LvmIO/TEi6Dx56Rm0dHjtCKzNuVZeMEUB/sS9Gz/7RuqmlJyZh8/pF7+?=
 =?us-ascii?Q?zC1bzlPE8i/rFB5XQQ2TAhKuyWCW5x2nOxaxL9B95tihjgyBz367JeHbki1o?=
 =?us-ascii?Q?KT9AMPV6UOKdBM1E1/8MS1blrAmYPVsLPeMI2bqxzbVA8YSxLCdTPZjSoVu8?=
 =?us-ascii?Q?JcLyaZ1QhVuFckYdBIrURql1aiF79fR9fxdPvlX+hTtYaAZFR219R+/RsjUr?=
 =?us-ascii?Q?0HTAfyzHXuonreeS5lfgHOozOvNYies+p+pCpbDLclovYskw4W0wfvn7BVvy?=
 =?us-ascii?Q?yVRfGFkALAXL5Jd9g752OdqaTG/xKI4Jcr1oN/d3CZAB3MPBs0EEXH8wrFcX?=
 =?us-ascii?Q?nXI8UATtVTmT61a5WwMypgkfshCS3ftOtUcHZZsk5kaMzk+GVh6K8o3juVAh?=
 =?us-ascii?Q?bigow+iYm39itDltfg4Q3C7M8A1Fas6ryoBNE6kZZbjaW70q/OAR+JL91r+c?=
 =?us-ascii?Q?cit5pjKh+4cutbhKIM12xtJcx0PbLTEGj21AsDUncQMPvlSucaXGqBSdltq3?=
 =?us-ascii?Q?13TvEoxiQFRzRUJDSHYVCKjhAr2XejXn2uNJBLW3mrTWlJx5AqUySoDKH1Tx?=
 =?us-ascii?Q?vW2F/R+jKw=3D=3D?=
X-Exchange-RoutingPolicyChecked: UrdYWMjqysOJU8N4+xB/Z4gHNhKrVKnePjcJHEUR5NtMswCjoZ2JEPEL/cPqF0DkhhBHz2s82804C99Jtp2E6W+YSHSINaVnfQURbxZpMvFtgNkGEXM0vY2pdj8CQ/O/fgVWtc6/BfLjhkFx1ORt3ok0jLb+l2DvJWCSGymZGoDdZX9dy3eLXua3+dpwvMf1z7PAQr+42lGsNBkWnIKCb6sNxnAfKQ8f4bZSjeuNv2CxQ+T7f/zocuQ4Abbk9dkDqY8U41H6S79cmke0r9fHoLCqxtMLf0xV9BiLmb9cbMNqgYALiS+I50d9tviMPRZXWJUENLCzQhLgAajgtoma+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b969dc80-7817-453c-a472-08dec69615be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 02:15:04.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6Hg0mZbhDI4NhS71lZY+Rbx0ZGoHo5WYFxsCwR43bWbuZOFa97JnE2yfWliFi9H9EjCAa1Jp7NY2+102fyzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com

On Tue, Jun 09, 2026 at 10:25:22AM -0700, Sean Christopherson wrote:
> On Tue, Jun 09, 2026, Yan Zhao wrote:
> > On Mon, Jun 08, 2026 at 06:41:23PM -0700, Sean Christopherson wrote:
> > > On Fri, Jun 05, 2026, Yan Zhao wrote:
> > > In kvm_gmem_get_pfn(), because slots_lock isn't held, this could happen if
> > > kvm_set_memory_region() didn't synchronize_srcu().
> > >  
> > >   CPU0                                    CPU1
> > >   kvm_gmem_get_pfn()                     
> > >     f = X (from slot->gmem.file)
> > > 
> > >                                           kvm_gmem_release())
> > >                                             slot->gmem.file = NULL
> > > 
> > >
> > >                                           kvm_set_memory_region()
> > >                                             slot deleted
> > >
> > >                                           kvm_set_memory_region()
> > >                                             slot created
> > >                                             slot->gmem.file = f (alloc the same object)
> > > 
> > >   get_file_active()
> > >     file = f
> > >     file_reloaded = f
> > >   <KVM does weird things with an old memslot+file> 
> > > 
> > > Obviously KVM would be wildly broken for other reasons, but just saying
> > > get_file_active() takes care of everything is misleading because it only handles
> > > reallocation of the object, it doesn't guarantee a reference to the correct file
> > > was obtained.
> > Ok. Thanks for the explanation. I get your point now.
> > 
> > My previous confusion came from the fact that if kvm_set_memory_region() does
> > not wait for all users of the slot being deleted to exit the SRCU read critical
> > section before committing the slot deletion, KVM would be wildly broken
> > regardless of whether gmem is released.
> > 
> > > E.g. AFAICT, users of get_mm_exe_file() don't care if they race with
> > > replace_mm_exe_file(), they only care that they have a reference to a live file.
> > > 
> > > KVM on the other hand cares that kvm_gmem_get_pfn() gets the exact file that is
> > > associated with its memslot point.
> > If slot->gmem.file can be set back to a non-null value without the memslot first
> > being deleted, synchronize_srcu() in release() isn't required, right?
> > 
> >   CPU0                                    CPU1
> >   kvm_gmem_get_pfn()                     
> >     f = X (from slot->gmem.file)
> > 
> >                                           kvm_gmem_release())
> >                                             slot->gmem.file = NULL
> > 
> >                                            kvm_set_memory_region()
> >                                              slot->gmem.file = f (alloc the same object)
> >  
> >    get_file_active()
> >      file = f
> >      file_reloaded = f
> > 
> >    <KVM proceeds here should be fine with slot + new file> 
> 
> Not really?  There are no guarantees that the old slot and new slot have the same
> GPA range and the same gfn=>gmem bindings.  E.g. __kvm_gmem_get_pfn() could get
> invoked with an out-of-range index, or worse could provide the wrong pfn due to
> computing .
Ah, Ok.
 
> It's kind of an impossible question to answer though, because it's sooo far down
> a hypothetical path where a KVM bug basically means all bets are off.
Ok. Thanks :)
