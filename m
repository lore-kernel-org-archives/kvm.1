Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E240A920;
	Sat, 10 Oct 2026 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611038; cv=fail; b=gORQ0GaOD/vIZq2G3MprFJVscbrXSLmZZJhlIWtvGvWBXqutegor+xccqJfj6IekLiTtm0KuL0OW5/BdApE7i2xJnZ8scx3Ldspsr3z9DdkJHGxYmI9yXNgPRaJgFwIUx53Rx7VO6UyZieTruJxct75TClwEVGqfJvuNF+pZYlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611038; c=relaxed/simple;
	bh=oHXaaczwYM+AQzf4K3ZoJ56jONjq47iI+Esi+nCq3Kg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXzBAOYZbtNDniTK82WTKrmlMtRLcYk+/2L2MCcoRO17RsbLM+1IihpTtHtRVynNossJu/Il9AyZMPzOeNu235bU0gmdOsfSdmf5AliFwydEWPj68nLTP1W0QyJOE/kSWDM2l5IJuVf2hEr6tsNregDRLW/1lLn24M6/PiYrO7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZJthLby; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZJthLby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791611036; x=1823147036;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=oHXaaczwYM+AQzf4K3ZoJ56jONjq47iI+Esi+nCq3Kg=;
  b=OZJthLbyd0CePsCHRu8AreC2BsDF2ha69AYFgLWaAgVgk3DuPMcO/hDq
   RDY9QpMFboo3O1Mdz7G7Te04ysRVNTidgeul8pxJrrJnCLdUXrBiFt2vW
   DbmcFFqUWVogo0nr+OYlM5tsYhyVdc0of+h29qTQ1eN8GCKjawbAtg6lJ
   mKvz/Q+jwVzGoDHIgAv/LC5NZh8OMl6qKgGK18ECgmHJVlLnyyCaQ+Con
   4k86AtJTIWBCOeZA8COpKR8m9PQV3j2Kqh/WnGxq+oj4t4Av00KP7+LSA
   3Bok8mooHVNvIwmW96ugSE8EWCFOsT141Tyc1l/Aiqo0faLCzit9cMhbQ
   Q==;
X-CSE-ConnectionGUID: Vz8VPPuVTO+Cr1Ua2FGmbQ==
X-CSE-MsgGUID: 8mkoGDmmSzydIs3y7pYikQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="294490"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="294490"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:43:56 -0700
X-CSE-ConnectionGUID: X5uAH20ZSK+UXFE8dfxuag==
X-CSE-MsgGUID: vlPaJx0UQXOBCAP8Y9jXpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="794916"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:43:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:43:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 22:43:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 22:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeeS6KVf1mHDsxcDUJdApf3kmZjhAUzkShhrw4FA31dA5BkJ70SpuBmJLJa8iWXoatY5XE9mKqrYTDY0tnAO7Pei1EJl0nBKrDXMcw9K8txksgoI2nZIRF8DR26sdi5jrixQq1RqQF1tNSMhbrStufS6dK+yzwdByDgbqZ97dtfvXjJ5JePFH3tyKAtgkhUh7FXIgHW1dDZn8QdyZ2yd1znWmrzK5I7K+r00+6lh/hNX+SKyHfgU/AYhDyevwNQQL7JmzEbNE5rAm3gvDqmPhGw1BnGPIxv1jTgux0XP2VO02O94bZkT0iUgNZ6gYf8Rfr3kbP+7jx4vn2YO5I0fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0GoOvwgGlobH6yVUZ1uz94yis3PW1I+HiUkr3qY7Iw=;
 b=oxp59bwo6O596MmAhipSwTZj8ziZFSaAYTppo4j+NvnGOazAdinH02r/fOO0OK80EFLNAxFMdgL6YmvyhvDnMu4TcIR2PC+VyWTuzOx21TFAQ11ziuMMcQx8LSW/EmaudeOJKCs0zvqxSLhCIK6BohFhGlUfIq5BZGa7C96eUFsGp6dDtaurY0U/IiENgQMfjAM3YujIhnyapgvxTjQcpJx37Guuka/KAGtShCqMPudU2c2z+zCjfSMScYmeXPY0TBiGGHepy+OWnwjipIInjhHLRPu+9rLDLbj8Uf4lDWXH/JdtGEQmJ9QSxJGk7Y82s8CPRljUisH7XNkhNnjAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 DM3PPF10DD61CAD.namprd11.prod.outlook.com (2603:10b6:f:fc00::f08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 05:43:48 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 05:43:48 +0000
Date: Sat, 10 Oct 2026 13:42:55 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Message-ID: <asnQX6O+tPwK+7wl@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091116.15647-1-yan.y.zhao@intel.com>
 <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
 <asi04xo+LJWmkkTt@yzhao56-desk.sh.intel.com>
 <83419a720277e370a2bb96f283272d8ad0adc3f9.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83419a720277e370a2bb96f283272d8ad0adc3f9.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|DM3PPF10DD61CAD:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c93f74c-24a3-4c94-cdb9-08df2691734d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|10067099003|22082099003|18002099003|3023799007|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zhJ2YygYqfxA2WG+qgPi3uyyKCGU88t8nznOgfeeVwAsiYezjNkCzB8/hfNNGorfy7nMzeO5WmAFfdsMOoMIJj8St8fQIiWBogP7RvqXpc0i+wFxspgZcm6ZF75GUJlgmWCYPJrYhcaCkAOXPgh85YTBkY6oqVRJWHV/tD5Id9zgA537pEgRzymfsbfnNqZXWVjOqqq8ThMI+QIVSSmWz/9LJ/8we3dcsqQ0CohfgrI/jMHitUNNvDkV2hIpFKF/euZi+eEG0NZsry+oHU/nJNNSKweKBQ4xvfwdl7XIDKfPVZNtmJfTV9G6zxo4KvEr5GkQS+5TZkI8lEdA2TAt5umXY9YkJqNX3pMuJRdNCRrJWYVf15XZbdsToUVdLk1qHTFX8zLq3ZMGG4wezaf72tVllHnlpH9ZgjpGkYUT31k8TCHSDjOq5LFU4RBdsSamMGieCKOO05xFOO21+9q1CCL6zTGXDWd0hkGkN0S1J7ahHUBWiE8erJGikLbeNxZJAHv1n6mVF9rBsUaLQGz9+gFotaWLcZQPxf7sNIFqeCt0GqWgL/Kc+5KZHgwQq495pRUhloijMCr1TSW/TM6AfJFiF/TcmHLWgR9hT+Z88YfCxsdj4DCv80X5ZLfLtCgzdaofXO35BPkjyWiL9PVKNGJ4ujixIo9JtsCivvXxjGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zhR1px6txcN6yq86P7KVLfSeiET8SOznGZgbTFt1hEYsbMEhcVPlJqdq7tr?=
 =?us-ascii?Q?NHBl7TXmq9dRG+WFT5aJiYBhp2FItUmZHd+b0fFn/bhTi30WaTlgpcPxUU81?=
 =?us-ascii?Q?hxanT27X8rF6xEtqhXCtlJpTnr60DZhY6GAyVD9Mp/xLm4PmxeZ7i1N0Q9nq?=
 =?us-ascii?Q?ASBipqpX+gPrWlp6vkudFVnUAc3aju6jKzEyJhQsLyw/Kyft8BhFemDUcg+K?=
 =?us-ascii?Q?qgMc4ezficO2QWFE7jo+yz+vGNh/yYeZ6qeiDG3FsEoB1szWdnCah/C/CwW7?=
 =?us-ascii?Q?Tucc/chDQH847CmgQlEMy2YYKiAQvopNXfhJ3FyzH5njvpDq6G0DDFMvGoWV?=
 =?us-ascii?Q?SdxlknzdbEGpTc8KNPg51RAiXWq9NTgMGxf9fD+yKVTHSwoE4+R2uoWYTO7g?=
 =?us-ascii?Q?Bp1K2u3ntvM0bsCxWgk7ElqEK2xNYDfm5riZYu8SjWVHekOAalUVbs4LbZkj?=
 =?us-ascii?Q?7yc2jM2WAxfuxzPBcPfS8rZnxxT6zrWb/eQ6M8WWMKpkoX7BAMCXIkHmCh/f?=
 =?us-ascii?Q?eV4T7YZmQkHaeFbhc0WLozLPilpIWMoUSKG2tzvoxeP5BF68fT1FYZsAaR6N?=
 =?us-ascii?Q?dHVvmeJ5hCeD/QVI94leDzfft1Upuk2wBL92VymplaAG1jBtmYcg94JEuBjM?=
 =?us-ascii?Q?HTjS2eKmhv6JvydV4G1Sc042S6ZmbIUzBQ/jWebTESqhze2ZVNz1gbeblZIy?=
 =?us-ascii?Q?9WxsX0hub2xXTfr0yU+BV+onbwSC9N4nFK0a20SoLv2cY3vAlXZjK8NdCRhf?=
 =?us-ascii?Q?7Oa8X75Tc/tyszSXWsU2LZxE6vQM+XeBzgSmiQaYVV/sw7MLKu35DNgxNPA5?=
 =?us-ascii?Q?bJuEML0g+XKSygklbOUvRHbYdtR0CuAcJk9bmKlBGHWCCx3c/9kVY+tEbH8j?=
 =?us-ascii?Q?/h32vPKY+C+fsZQwQcGfqRqDMYuqLuZZYSBpdEMGLohduYeBOoc4Dhe2arsj?=
 =?us-ascii?Q?XmsFNr3EKeSidXHBmkGbgLgFaBVDvxH1ykDqKMv6iQKpFosxWskX2ag+1ycC?=
 =?us-ascii?Q?//TGkPkSmX6/6lemj9OsTQ5PN5AAMWbJwu/JvvLYd4XtjcElYA3ry3bzf+zA?=
 =?us-ascii?Q?6zq7YHnv/q/Oos+U8SZFQLWKaB4ZM6jldGS/SIgdpRZxIX34R2bp68ae4p2E?=
 =?us-ascii?Q?5/Wul4QX9ZWu8beJvU42Xr0u3kfPR+qSfzLIgbf3beN++2By9s1I2Cc9kQ9s?=
 =?us-ascii?Q?uUMOM1hFPx+2vmeWsDKtDxIdiLFSOgvp2F40V3O1BrC3+9z0fx8erkN1DX5/?=
 =?us-ascii?Q?zqL/wjl8DuazbrKT9kGZf624gMzZECxvT/s0TRZ7F1uleHdPoJS0zyM/KbTf?=
 =?us-ascii?Q?rNJsSgLTGos5UkicD69CkC9z2nbGT655t63o8dVvnk7WRlxep2m0YJehVNjL?=
 =?us-ascii?Q?6yFln+6/S1c48dIGFxI5offxrzgGbgqJQKpX1lbCwRo3bxaXUYGT/b/a9YPd?=
 =?us-ascii?Q?qiJD79kgbvJYXs7LQifbmoh2WBY4suZHhOfbISOEcADUIitV0Ed5BKxUxCGw?=
 =?us-ascii?Q?iJ8RLcWHVXQ/siEfex0XFhwhHhZKvYvUOAB2+gdBVftRpuWqLxnoWdCTaIdg?=
 =?us-ascii?Q?Qw16dl8OQzOEM+mQwiIqPcssTwoxdT8O6vYADTdm4F8cB8Cbkjd9yuSPErm+?=
 =?us-ascii?Q?g1BBmNnfUQemqrpVIKcitiw95oiI3MbnIfQqJGylICkscXrjTpYGy6D16Z0p?=
 =?us-ascii?Q?KMM5jL+NOy4YWOVwblBrQhfgDDYRjQTpc9OLiumlbrIuNCmlcnGUxIPXVxha?=
 =?us-ascii?Q?YpNyHtCl0Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: h7mMWiV9iWEcTt878TB1SeAu8+sgiUvuRo9YQK5sb4Vc6r+qZ2frCirvIlPXk9vP+5qlnOQNyMtXwmX3HFrwBIH13oE1t3H+yjJn6sLCRbm3SxSRm4OOP1yJGC+rSKMjoFvnl7puURku+c3u0WME/Sl6YFALmqmDDFpmjeJ2lujyun/4p4mTTs0Ab00SMgQr5ggbpGuRUWw84BYS+3yin0GTTxpsEZyDf8pfU/hunHcjMOu0dE5MuuUQMnO4PRLHVrljtTky8q3ETxzU7+/KqlBiDojaRCsGL70w0EeqPUoK7L6d1x8foimMC8XRbkwOvvRQ7gmOsX49tpM7+85rag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c93f74c-24a3-4c94-cdb9-08df2691734d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 05:43:47.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb2gQrUF7AG7niMkGKbWOnTRiTib8bpKLsirFa7uaEfLhke6tjVZbEB3CoY6tzBoYHQWSlUWIi77ngesaWuGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF10DD61CAD
X-OriginatorOrg: intel.com

On Sat, Oct 10, 2026 at 06:00:01AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-10-09 at 17:33 +0800, Yan Zhao wrote:
> > On Thu, Oct 08, 2026 at 09:05:32AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2026-09-28 at 17:11 +0800, Yan Zhao wrote:
> > > 
> > > > +
> > > > +	/*
> > > > +	 * No TLB flush is required, as the "BLOCK + TRACK + kick off vCPUs"
> > > > +	 * sequence required by the TDX-Module includes a TLB flush.
> > > > +	 */
> > > 
> > > I think the TLB flush is actually more obvious than the level + 1/2 bits below.
> > > It is worried about inhibiting 1GB mappings, why?
> > Hmm, including inhibiting 1GB mappings can make the logic more generic and more
> > correct in concept. That is, when the guest accept level is 2MB, 1GB mappings
> > should be inhibited conceptually. This help remove the code dependency on the
> > assumption that 1GB mappings are impossible with the initial implementation,
> > given that inhibiting 1GB mappings as well is simple.
> 
> I strongly think the code or comments should not prep for 1GB S-EPT pages or
> promotion. Warning if 1GB S-EPT pages is tried is good. But I don't see how
> silently handling this particular corner of huge pages helps anything.
Hmm. I didn't realize inhibiting 1GB S-EPT pages would be regarded as a prep for
1GB S-EPT pages enabling or promotion.

> If/when we get to 1GB mappings the code could have evolved at that point. So
> introducing code or comments now will add constraints on other work that is
> done. We don't want to think about it.
I'll drop the 1GB inhibition if it causes confusion for the reader.

> > > > +	hugepage_set_guest_inhibit(slot, gfn, level + 1);
> > > > +	if (level == PG_LEVEL_4K)
> > > > +		hugepage_set_guest_inhibit(slot, gfn, level + 2);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > If you have a strong opinion to drop inhibiting 1GB mappings for now, I can add
> > the following diff:
> > 
> > @@ -2183,7 +2172,13 @@ static int tdx_handle_guest_accept_ept_violation(struct kvm_vcpu *vcpu, gfn_t gf
> >                 return 0;
> > 
> >         level = tdx_get_ept_violation_level(vcpu);
> > -       if (level > PG_LEVEL_2M)
> > +       KVM_BUG_ON(level != PG_LEVEL_2M && level != PG_LEVEL_4K, kvm);
> > +
> > +       /*
> > +        * No need to inhibit 1GB mappings since they are unsupported with
> > +        * the initial huge page implementation.
> 
> This also implies 1GB is coming...
What about simply commenting as
"No need to inhibit 1GB mappings since they are unsupported." ?

> > +        */
> > +       if (level == PG_LEVEL_2M)
> >                 return 0;
> > 
> >         if (hugepage_test_guest_inhibit(slot, gfn, level + 1))
> > @@ -2203,8 +2198,6 @@ static int tdx_handle_guest_accept_ept_violation(struct kvm_vcpu *vcpu, gfn_t gf
> >          * sequence required by the TDX-Module includes a TLB flush.
> >          */
> >         hugepage_set_guest_inhibit(slot, gfn, level + 1);
> > -       if (level == PG_LEVEL_4K)
> > -               hugepage_set_guest_inhibit(slot, gfn, level + 2);
> > 
> >         return 0;
> >  }
> > 
> 
> There are a lot of possible things that are not handled if a 1GB mapping sneaks
> through.
> 
> Why not KVM_BUG_ON() if something tries to map 1GB in the appropriate
> tdx_sept_set_private_spte() sub functions. tdx_sept_split_leaf_spte() should be
> covered already, but not tdx_sept_map_leaf_spte() looks like.
Hmm, there's an implicit KVM_BUG_ON() inside tdx_sept_map_leaf_spte() about the
mapping level: both tdx_mem_page_aug() and tdx_mem_page_add() return error if
the mapping level is 1GB.
