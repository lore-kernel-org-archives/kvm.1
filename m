Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D62C1788;
	Fri, 15 May 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826908; cv=fail; b=hE2VudlE1/rfteaewD+WG8iNbjTVepoNr96Yjla673aKmE3mR6s3yCjEyraQmVbyEeCHlBmMVlnCUkt1pko8AwAP6/FFp/f+6/wX9vkBkt6gpdfAUbvpDDBT6LFW8W7Rqifygc/foto3tyTDnHtcMEDwHNuPbwPcF/RJ9JZOg+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826908; c=relaxed/simple;
	bh=yMIzTDo2Cwik4FPVsKpANyi3xdlDjttGILe4OVMmRA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ods6sUcN/curYSjCCEMoE9ttPf1uiZlYB7+GkNvyYCwUvhGLM3awB4Apy9KoSLKmUyC7Sue53ur42hW/7ujZU5zW57kUM1mUhO0fBN4KaeqezS6UdLyg5qWjgnMK1nldS5joQRVeaXuS/92l3Xa/UpXeeunDM0zsayx0WjUtxjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCcCmt7a; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCcCmt7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778826906; x=1810362906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yMIzTDo2Cwik4FPVsKpANyi3xdlDjttGILe4OVMmRA0=;
  b=BCcCmt7adIMzzDKk1y0IT05yxmKIF3/NKUQaKPnuRKbwBh3fvAlwsrpK
   zXEPaBJO/x1/KbqEpAxUQrjGZs+VH6MDnAGSeLw/m6m46jqe4+qZuhpuE
   WPa5pLtalHrc44tqAIxRJkFkdNaAt4C5RHjS0ky0e5VHWLadKjJfdEhBe
   ER4bzfQ7tWratwZSvvXv8TrH0h1e9BuClUcc/Nbcfz5fPIJ7bCqu9kdWg
   A+S7TXoWFbqcBnLAkrJ91badoypakjtYu6lezJF5RH+aCVmPJX0e+bY7v
   iORVMYlfnyE1Ek43NqBLRJhSf9gGEjPGwxsZIfsrszrKGW64U3N+31m24
   w==;
X-CSE-ConnectionGUID: WYVxtGdkSZOsZH6+5/AHhw==
X-CSE-MsgGUID: DuthUY0WQmmo5TfG6Lg9Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="82346634"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="82346634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:35:06 -0700
X-CSE-ConnectionGUID: eh4wdnQSSjuc1+iS7emYng==
X-CSE-MsgGUID: QyC/PtZET0+Zc7fCj6z4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="268953171"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:35:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:35:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 23:35:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOUKM7LAEDi+5DcEkLcT3CsxIDFEcMAfY7YUOSUl1WzSGvhYVIBfse9FEu+mtnEJU1KqM3QTVR2WezrSxJ72upWIi4kUMXjuVcR8A0FQiHracD/sSFlB/cUbriwv1CQZ5lM029iSXgf8c3MhY/OAEpQFgSwp0TVsV5sMUiD+5DI4YhtHTOAp6+1axCV96TfZ5YYISVYneRBRs8v5STEEChTu892jwuECwuuKPNTxCAze1QM2FktKbiGFkdio/yWKcaL+oWHHzfuUDDiTWYf5WNgir0RPg0NA5GGYklI5nrpsSePT00JECr33xdbr/M+a7D1BBhyTRx7ktaLUyLSOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMIzTDo2Cwik4FPVsKpANyi3xdlDjttGILe4OVMmRA0=;
 b=jFb2ZHyd0lk4U1g7LgNDFTF2b7s7cEUFp/+rR/fWQGG0xB4+QhMzA8Z45cbSZx2MnC4f8r3uq7WF9vZPzqHqLRxKbQPqm9SrsKSIvy/rHxHLJYF4PaSWvDgViU/q8UoPzh8zDv6cQ3Uyli4JCkvj8neDyMi7fM+Nltk7VkOuSuLQQoqJwpTNE1qdlPzIB3PVOZBIHy39bBfx4Pva9PhxEB7cJqVSvwteOgqmFDI3bEUbjxbtTiEljYSJcD5f6qAS27B9dV/nQsQY3HxNte2kHsxWsK2byxa7WnYRQoaKCE+te6lrHebVyNIY15jmHTMUoCZd9ptj14af5ocmvGcpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by LVUPR11MB9788.namprd11.prod.outlook.com (2603:10b6:408:39b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Fri, 15 May
 2026 06:35:02 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 06:35:02 +0000
Date: Fri, 15 May 2026 14:34:52 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Reinette Chatre <reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <jmattson@google.com>, <mlevitsk@redhat.com>,
	<xiaoyao.li@intel.com>, <rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <aga+jCVUW0d4GufQ@intel.com>
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com>
 <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <agY6JuEJRhwpwlRL@google.com>
X-ClientProxiedBy: TPYP295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::13) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|LVUPR11MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: cab959e0-2ca1-449f-3d87-08deb24c17b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: L8DSCYK22hmi7pSKrfsoR7sNdmfgtcB71Yd+zrQIYg9t+IOKPY2VtXCBmAcHa11DsoC4yQBu5InhPBBEoDNRjWroArqzagkV8d0cfwV3DRvkIveNCUXieICX6BhVRiIM8bAWJmYkOuRNpiPolOLRY6RZHfAI0dKXYm25mGASd4Ze0d/4XEToncEF5y1rj8STxer3pXWeCDdYTn9goVEwufX9lhQTF0r09mvPYohCwcIpN3/h84lC9dn4v3YBenNFzjbaX+CgU1V0VQ3QIywm3VA2Mv5sfqcXxQiHni5AjMVaFJbc2DJ51fBTZ0E29punIdFyWj4in3mIvxSefJXYnM/dmdAbQ2cyrUtUDCaP168wroPhuKo3lqX+7U+loj7jS5mQaMHUxsENsxxeSsIpKqCN9KW2MCi/8Ukfai5kZZ2cqV+NW0MFkZ7qtTeTakJYxA5kNyi0mj1xhKAaCDwdxQs3IIOK5Chh35VO302DROFgyLgGlCP644qcXwqv6EjMdrn0ZDO2wH7gZRsHP0yR16Lg6MNfk6BmMf+qO1pz9lhkl7R2IFW587dAmHi/QC9iFdQhy1+Qh+qBxRTDb4+6yOalRe3gNOkV0bWFpx1dbl8MukO1DcTx+wKM962E4LMEwgHudCbSQqXPpLEOn25ZKRzZHrqu7LbSnXSUaIusHR7Ne2yBRbpv0rNCcwSk0hqc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Cd1e2AXUW4hYC7K64+YsfwJT4yz9IN3MaV5p65XWFw6ibBgtgVracK9/I3B?=
 =?us-ascii?Q?kAhOMltZ8LJRhAuKzUyAu2Y2FVymRK9DoLAJy1QdQ9ZC9xi8d1j9uub9hQCA?=
 =?us-ascii?Q?4DVdc98t8XmR7JZXj6iNBGjB5ivmMMBZoueaQlIljNRFOhTx0AmkaM507T2X?=
 =?us-ascii?Q?jNOWgU9SwRDbz73rWDZ0Yynczr0kLJpC+C1wnPBCbA4Ttqn/mjHONNLRpOf5?=
 =?us-ascii?Q?RDqoMMrhsEa9tS7bWVr45jSGjxWr+R2FvIcK43IpoeobEXcyEaBP0rbiqFYv?=
 =?us-ascii?Q?ydQfxmg8ciZyt81mx7wbPu7wENefnuD94g/+SCtTgqeD5y8shUZSc/Ac8JSK?=
 =?us-ascii?Q?wg25yEscwBfjVd2norDmigT1E6o8M6F2pqllK0KMeR5oRmybivh9zi+jSb79?=
 =?us-ascii?Q?sm9qxk7kulthOJSMTJUH6L2vuZwhY7CzKeb11jv0Jua/i8Ktfh5tZD79K4Xt?=
 =?us-ascii?Q?/ZYah11akvPSZImFOPmac+1WBCCXptx6sFIzqGn14nKcKGn6z0uBc4Xok6ld?=
 =?us-ascii?Q?FOyvUyc0Wls7Mb9tQ0c7xBeRN9HB1HoD5iwpTMzR66+KNK1ewgSha8EE8i3B?=
 =?us-ascii?Q?rAfcJf2DUxGpjRmtnRCsdlV1pIjGFjnOoerpthzso/hNesjO7hOYlWHr05IJ?=
 =?us-ascii?Q?3Hxyw+8RMS+kIDVnVpHT9ye9iN1eREvDftWC/t9EKswebHmraF6Wy7/EJBug?=
 =?us-ascii?Q?dXT//WXOoBrZBuMaYr9xzDd2AGKxHQy+BpTMKDZdc7pzMA+CsREx8B5PZ4Z1?=
 =?us-ascii?Q?tE/BDZ6WqJGf3OGOhCJOT9qO8LIFGVz0gDBQ9kJQBjuiPTcL3/xQ/0KAVJtZ?=
 =?us-ascii?Q?sujbLQdoCQHH2qVNmTuu8kYnCHbjlRPcn0hEnfaqzAkDW+c+d4EBa+moKRBi?=
 =?us-ascii?Q?WuCC0+7W69OI8obAEIWOt4kM+KStmROFrl9kgsqfrLM2fz+2iEyhCNBM3TXu?=
 =?us-ascii?Q?iGMoLO+eQeebuJJaWYD7WvZpBwBhkWSb8OdexwJW+CNknU7xY+qBxbDhfiZ0?=
 =?us-ascii?Q?nGc9tpZHnA9/gR3nrqCMCHwMyvVwRH352zMvt6G+lbKGBxjKjMYFOkUt9WDb?=
 =?us-ascii?Q?td05hy+II2iJizyGcoeIqrxYJ+GxIZJZSbnNzNM8ZFAAq/AXNZ05Y9BdYXxE?=
 =?us-ascii?Q?CSE5qzbbFCGfPuF5J8i/RRQiJVJvVCfVVJyvSdaB/zgd9XevhNPU+21MZ72g?=
 =?us-ascii?Q?4sVzuqch7GNyu+gKJnkaD/4BovR3OQ8X8fSlDVNnW3GGsAyKSsLdYBRxEQxu?=
 =?us-ascii?Q?Un3QtkU6eATHFJP+GRkm2vtnMXpdal80Jq7cUxFubjXa3m3UJHg4Mifd4k6h?=
 =?us-ascii?Q?CqF5l1OxD/JZJS3JLYLWvduDh62ACtoH/GJVJpKJ6ztVLgCmg6Xrd3DuauB4?=
 =?us-ascii?Q?S9BnnitmodP1LkIkK6sztPsRVq15DFRO+gX9fM8GjTsf8D3HgkdziTV9cPRf?=
 =?us-ascii?Q?UmmSdVEmvZNaH6Fag34IktzzPhCsqOhKeAG/vdvmmGBf8M67L/E86WlHoxKe?=
 =?us-ascii?Q?L7s4k11RzxREQsHx52UPCEIQiAPQPZvkSGI03QkTkvqZc5P4eC3f1amxO2Kr?=
 =?us-ascii?Q?DDcSLILfXNRL7XtFpo+W5Glm/mqyOIcV0R5i6RZYApfUN+ZOFoUT9Chv/ohI?=
 =?us-ascii?Q?od6upQXiIgR972MJdFDwFFzv7i+NTdvS7C4maW4HxluAfiEvZ31csRlaf/vR?=
 =?us-ascii?Q?eYahhDch3pDOJEj3Ts+kpbypBO/K4zHEVE+A42quOCLG+ZC3+GaQx/lPB1Xf?=
 =?us-ascii?Q?fa0yuDVWww=3D=3D?=
X-Exchange-RoutingPolicyChecked: YO0WmmsulnlvXrDHoLnkGtwTd5COgR/OIASxXsHK9UCvZoYcZTH7J8M35C3y2oNqo6oapt1TkKTg0X//3q9NleoOP3fGfglJbzCHIW7DkBmCy4Us7eW6fWhDCFZjCL2lw5cB1sqNDrU5FLTr2M/4n7+r16ZpLhFGbz7ewrGV39Ebc15ITW3wq5ccC+XGNefjru6Mmko9C2fZW/Bye4zynY7KqelWWDRujUMbXHUH0AgzqyWgldv37Zo0wm5P2oxrpT/FRPnjej4Xw1ScuSDCNwAcdUZnK+A1zz5CxeJVLgIKXp01UDdhjXozCO42ebdSvQ2jT+nKxObeyC0qvqOcpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cab959e0-2ca1-449f-3d87-08deb24c17b4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:35:01.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKTS5Ds1eoHeB33uSkfe8jfvUJ7lQFxlp/EYjPx339hrd9VIJCFZTj72PBgsyXA8ZjpSl8EZje0dA3IjGcUhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9788
X-OriginatorOrg: intel.com

>> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large Timer Values
>
>I assume the same erratum applies to previous generations as well?

Yes.
