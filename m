Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610735DA67;
	Tue, 11 Aug 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429341; cv=fail; b=rz+icurj1CmNdslZHzwMdc35qYD54L/EIqo/xfByqWer2wfUStmJlflNqPkMVu20clIqjciqvZzUb/+rLLx8Dicst59L8wASnT7epPTzL13mJIw6MLDNcG9sbuRHCqXBRa1labe+KBgbvinFniBWTTRYLdfm9nYh2dLfmWGLqx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429341; c=relaxed/simple;
	bh=Y6si8W18DyRPmzhVILFIR7Rav9EH9BKQJMTeZ3LHfKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NAN8HGTU9uw0DSgDGiiLbswMU005ZHjgNwXn3akVABoIUvaLvUjyWaNHlcPlmLT1WtQUxtOUJ6TNYMNT9A5ENISV8d/EvjvDkgUoLOtP1gV5PROvg7F74rPbKRTOkpB+B8qMF8NPqT8cg1FeTe/A8VG2FEUBzMZ2aIUTS+kgBtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZjWNVo6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZjWNVo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786429340; x=1817965340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y6si8W18DyRPmzhVILFIR7Rav9EH9BKQJMTeZ3LHfKw=;
  b=QZjWNVo6jNwGI1BUjBPBttJLpNTmx3J0Yyoy7DN8FwJvz69rgGR+0Cge
   ueBGMxgI21srsC1404k7N8MXFVMy2+OnFr64t9nxvIBTjhHB8GZSfgUEn
   9b2MibQXwvYjeMHS1I5aVThg4SNH1E9oBDkRBorgN5Bs5/3JNJ3wD/qcn
   hoCCqILx4bb0fFjfHjuB370lJ8uwBfWZYqps5IQFh+GIsTesDR7zeeGSd
   d3oi3YzywQ3WaB4gwNb8CN1+oCS7Wi70DTW82xf7PKB52jtJrj3tM3Aqa
   n2t6VxNSByxuLqcDQ+6IQwTRd5Tu6tRrcNrsHB1XU+sUh9/+U9Hc6oeFz
   A==;
X-CSE-ConnectionGUID: ZJFHOytHR3KlmCg3g5c/CQ==
X-CSE-MsgGUID: ZpBR1A+3Rda2SlN/mY/CxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98312148"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98312148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:22:20 -0700
X-CSE-ConnectionGUID: rbxEtcFYROOClS3j5EQc7w==
X-CSE-MsgGUID: JmEqqY3hSSaaTwGZM17vEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="267096149"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:22:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 23:22:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 23:22:19 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 23:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osUk89bMkA0DM5sdQYmcC/9TO4ZRv5An7Ea8NTdcK+WAUHZakCLrSPh3qWromyDoqC920+ok7l/f6+iiSJEFPAXvFHQNkZYFxkYZ+NcW9/LKabJ2FBPdLUVMF3hZp52uXYHPJckhvxcECoxcrbWLS8d+UPJ0dUNYdJ9pjnyWTjXddsomn3HnzmJvxd2En43kzfT/xBjvMlUm+aVJpMMmqoFYPiA9UNRRXjv8+yOCtOj2x0xBt+nm3CAEhxJaFSZCB1oeU6BRg5oyapN0UQMLlqOIV0lhntauVYLoRfnAevKu4505kZ/xWt0Dhf8i5PhAqtouVokkI5125F0QG/xXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhkEob7Sts3G1CoPSnA0eBfi5pwQoWgZQ5KiJtB+k0k=;
 b=rHjAeNBT8ozc1LRR/J9SVzUinURO6pcHLTbk7mN/hOT2tcSYfaUfIzgS2cvFO3uVXZOxhM4B0yGtuJFaIJyzDLyeHvbN95kFpw9+nVxdhfr+E3vLB4AKciMN/pYof57ZxxAWb7zuRi5wMZuCSv+2jW01TBX9lQ6ymWC7lcGQ2Py8mS8LksUc0QXDVIRveat3aEOwC8corZlaWksapxAjWMamaMssgCEsWKjINgqIJzi+GZKGU1TOb+jv+lW7nZjbz9ebuwbu2vPBsbg2A1oi2sjH4k7nc7DO13LFzSczZ0HuIsPJ6QaPVUHMoMUChNUw9IwWZsG3NkKkCsfWlEamog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:22:15 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:22:15 +0000
Date: Mon, 10 Aug 2026 23:22:13 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "djbw@kernel.org" <djbw@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Huang, Kai" <kai.huang@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260811062213.GB1013044@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
 <bf4d5f6c62cc4298b886e75059990e87e3f3df8f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf4d5f6c62cc4298b886e75059990e87e3f3df8f.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fb1181-9442-4bb7-e18f-08def770e2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O5W6uNRiK8NPTK7wv0ewQpCWkYi3wrIsNIoOSv9otb6EBlIqwU63Bu0kdcygioEUqQyMP4WL23vzur4UnaydC6FTozEpaSZyfTH40YpKzuk1gpaGcQYsOld2ErKOhaW0OesXBoVzc8kuwYpJpt8pxe0Dpkg0b4o5gdBe9KhFDQG/g15bIgWxDQDgKxtCHSlmdO0eXzUW2sMh462ylGxtkWJXrqx/QNKpVdA//Mp9TR940ZnKQw0yzWFzfE73IBUyCVYw95ZnjmWGx3Fmoy3M138d4o5b6G1GmmW8FR8xp4YRP54w9NE+mFI0zamM/yOH6j1YOpx16nQMZO5v6tGzff9tkAXTbWE8cu9OrGx2iu8bO8Iu/SsSLXgkA49xsVtKqgC1nQTgMIEzjqk9L2KYbxh7zjpPiSTS4wDOGTpcWsLnmrncsK1QVUX2sx7lySjAKroRJgnJP/nDtnVid4sTS34ZQnHweEKuNdnSIEU0g7sGS3rWo2ZzIpwMal0CRghkvP4HkEjOtrMRtP955ORGQh2wp+9rmPfDgPkaEwxSJqWyCos1CULY+TqgOyrmLpWtmf90rgBTOwEe0PtdMuwpPQ6I+tK5QviDA+jebTOMLbl6ZGVgHjk3ifyxHqy1wHYEfin4Bn0in9lsUiGqjJnin+xSa1Gt3ipkkivuqDWI8s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jg9yoU54ZDgxoPJdEvyfh6kEkXMvmX77U3TRr6Nb4pEr1cR16Y5Kc1+BJt2+?=
 =?us-ascii?Q?1d+HFW1sIRpHlJOc4rETKsMyEm1zZITFvUI8H39LUGTaRcX9Gek19drkzxt0?=
 =?us-ascii?Q?+u/JpdMGzYjJS49kG/jWb3uj5Ho+viGgDUaBPuOJvLZV1gm1Y5qTS+LSNUCa?=
 =?us-ascii?Q?Yb/gyMMgcZlEDnfTkhtnSzAlxqeSzGf8lANKA5kVSZS8NjWcxa8ksV2W7HzH?=
 =?us-ascii?Q?ErqZs3U+iCHp/VfcV8sPjv3HvEJAkL2EfZ9cdgWD803vli6NebLAbe+gAE5K?=
 =?us-ascii?Q?RRhrUQztRMhLMpVlT1pwThKPm9ZmsLeYKeOPv5ge+Ucxr+wgLIZ2uxQNEL5w?=
 =?us-ascii?Q?USm+UBWk/LT5Ycja+B9pQ8SqzroGBCv3BFlw0x10E/rkCRyQGAzrrS1xtJff?=
 =?us-ascii?Q?Uv64sOP6/ZFmJeVS9RaSPM/2/JJdavOoPE+b+gB2hAEv6LlzSR8oLHbwC6pJ?=
 =?us-ascii?Q?zEERJP6igWq7x5tIrhMGlmpkbeiGI6L/XO3foHz6fIRJTG6sRzcp3w36MkDT?=
 =?us-ascii?Q?vqoOQhxjt6pOxf5R4n/XW3sH1/nMxQvmVf0eYK2Ndbyjmi/juPvdwfhsTaCp?=
 =?us-ascii?Q?dhhSCpJDTci1zWfepkg4LD5++yIzgkN9RHkUQYcgpjkU96q1jvvKJzGEWuQ/?=
 =?us-ascii?Q?9MIxgqsaYiIoeXWdsw67BFTJ/ZvIanuB4i57yuknEEh5a0glbqi+usunN4mW?=
 =?us-ascii?Q?5+FqR3mlzg8eIT7W/5uejWGOZbzG264SyAK0y+I7VknUYOJ/jf4GmudZQh0o?=
 =?us-ascii?Q?g4IaCvq4BEG5p0TqdnOj5mvhivFndAtYSkCqqGhopzJyUrNBJwncFCUviumM?=
 =?us-ascii?Q?5KyCNUFpB/BovgsqNT5MRXE4+i+IwIuqHQOQp50QJHC2HouOxlsxX1hHLOBg?=
 =?us-ascii?Q?KsBhC60lbgpB/SRnJsJ7I/0jkW7YjZhJisMVsKOU0Lwm8rU3/MAbqNXdbPM9?=
 =?us-ascii?Q?d2ll4ZRnooDU/Hl7QDQQAOwSuC1vMMjzlLT5d5hhZpwRu8R/oYXb5FaGD2ms?=
 =?us-ascii?Q?bHIQ8R37rZXIwYzwp3k3GBtrsOEnYe/1MffoF8Wy4aziV44MAh4ac30S4BZ8?=
 =?us-ascii?Q?laX+o9d31zy1f+PPhBsDCV9KwFtqHyvk5Cox75ZQaISv5ZQzFuFYvdwS9YhQ?=
 =?us-ascii?Q?CGux7jQaZFL01Kafzsr3Ova7CpHa/iMZMSbGBdY+mEqmrojlNZM8RgkjInx7?=
 =?us-ascii?Q?tfasI8qnY2B6t1Sfu0ld28fj3d26VAJKDxscEORe7kUBn2H7fc/L9+4+BCup?=
 =?us-ascii?Q?P2mm4Lf0RNuvq/Q2djmph+0n6/IAb4nZpRNfwG8yap3Vlg+TAjtavkcgqeJm?=
 =?us-ascii?Q?hjYK7G1AcLhLQWtb1JlC3fj0+cK6nWCyWONYVwZ2sAbpeQLvY4OQum5Vrhww?=
 =?us-ascii?Q?krUaVvjgGttBS7HXIn1UtDKpL2t/GbIYbiA0ujmEdty/Z5O8yej8Rq+1VsJs?=
 =?us-ascii?Q?AfBSZ7PrAJWaQavp6nTCQA7CIxJLXgW+CgCLSnLerG6SAJLroyZSJfPAvikm?=
 =?us-ascii?Q?qJdx6OuPNR9hzpPBq186j57G+Ixz6Hl+xuFjcLhUlGjFkD7bdqWSTuZxtz7V?=
 =?us-ascii?Q?gaht2c2EV1natZfB8rm0P2LxVZQAfSNrvFf9lcP0bViN1k/45mvImtKp70CM?=
 =?us-ascii?Q?IIE3uzfdk6YhJO5RFTpo+aFsdvHsutdZDNgLoodlHIkyRzF8QWSNWJx9gEpM?=
 =?us-ascii?Q?Coh3B4vajltP3qni6qHOvpWYHw+RWkKwEyzffsIrF/Jbp9TrABF2qv9PIaDo?=
 =?us-ascii?Q?p2T+6CSLQg=3D=3D?=
X-Exchange-RoutingPolicyChecked: PZaAMjyZ1/Yr0Mxpw62j4uoryfM42RgGQZNV6vg3bo7cz2fmAjK2XsZFy6JDBZp3msto8YzREa7uueivLdhW2RLf0aK7yCtXgM0DbV3EWylPflwRkw0s7uoPmWKkakXfeAvB1Hc3fWF6gJykxdlg9gFGzwl0pywWGU9RjOHOX/bQsoK4rP53jAFLe/q8FJAT96446rvBUZmZ2F75KsQsnd/Gl1q3kK9jzGOvyUbn6/S87l6CM+Z5Ei06te+TMfmfWOktSvh+9SOd1/mwFszQp8p+TmLL45tqbnIAZGzeyXl16a8QpdpJVAZIl4jhbZZbUn6wz2dFhO5lNwIa/wEyHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fb1181-9442-4bb7-e18f-08def770e2cf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 06:22:15.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uh/BJXVYuLW/V2igctXyAB42Xi1W1JjXdpmgmlCF1xvJ1gtAdi2AUu2ew1U8bw4kPPnMP6wz5PLwHUfPgxe1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 04:43:05PM -0700, Edgecombe, Rick P wrote:
> 
> Kai, Peter and I just had an offlist chat about what internal TDX locks
> TDH.QUOTE.GET takes.
> 
> The next version of this series needs to come with an analysis of which ones it
> contends with and how unhandleable BUSY error codes are avoided with kernel side
> locking.
> 
> On initial investigation the callers may need to hold
> tdx_acquire_vm_state_locks() to avoid contention around TDR lock. TDH.QUOTE.GET
> also takes "TDCS.OP_STATE" as exclusive, where TDH.MEM.PAGE.REMOVE takes it for

Quick update: this was a mistake in the "Intel TDX Module
Extension for Quoting" documentation. TDH.QUOTE.GET should take
"TDCS.OP_STATE" as shared. It will be fixed in the next version.

> shared.

