Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE4439F7C;
	Sat, 10 Oct 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624189; cv=fail; b=p7trQIDOiknwXs7Uke6Ze64+li8WkHMJBprBH84NloZlg4Vmn3vCxuWog94I+ECbxZu9FshxUUGdiGVgvfjar2wM+Kwt4Nkc37vkyznHh83+Q5QnPZ+5PXuxKm27ZnUXFsfuuL4vCS7GBnAbWbgtsBDfXtrSxFLji5L+uy9K0sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624189; c=relaxed/simple;
	bh=4WwvZq/Ns4wlF35TXgyoNkOX42vsT3fJKwK4sEp7e5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vGXjET0DNMxNnquxlwP8082nOQ9FPPaQxv6zyCKEvi5UWL7S5h2LmfZF3vDVEfn6WOfybtQYRsS4nUoX5LUc9v3ZxWfsJltM2zCYtIrtWCmEbzvm8Xoc4tOcF2MvqoZAQufSGrAmyEDoNg0+UwLTWQtC/gPPfk9FfdFJJ5TZQ5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrpn0nYu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrpn0nYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791624188; x=1823160188;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=4WwvZq/Ns4wlF35TXgyoNkOX42vsT3fJKwK4sEp7e5I=;
  b=lrpn0nYuAfAVMMnDcgqtEP3br1oIEzmBu13V4w3ufk2mlUBNKXe07dv1
   wJ/eIugnroo7v8IbfsJdAcjm0/+krdMMloibkJtPySXfZfJKJdoB7NXLV
   FJEp84Y/TdCPsZoT8xENLKSHh/julEMeUc2/rsSClqVBDwHUKZKI89mI+
   T76mAcof/5grf+0BCkprTtOFQMOtc2oNT/RAky+ojAIoPn3slbWybHXo3
   vFYJ4pZTDkDv9rHDBCvQJve5xWyeXZHqg3FkDWSq9pNNVIKhCk3iuvfp4
   jtQO5u36+P2ml2Z2p9xKZFDdM5nDfPxD9w83UmtURrmV6j9QGMf2KZ2yu
   g==;
X-CSE-ConnectionGUID: iO1HrNIYToakIB1+AxIftw==
X-CSE-MsgGUID: 13WoiFbhS1iJ5kvyA0LYwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="418433"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="418433"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 02:23:04 -0700
X-CSE-ConnectionGUID: s3o21DTfT1asLWXk2oL/nQ==
X-CSE-MsgGUID: ADIbIQBaRiejRgF/VJcbnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2328404"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 02:23:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 02:23:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 02:23:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 02:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfNbuA6C0TjbJzX0TzHxiit0M7b6jVzVkrbrw3veT5K3cuBL4rbuIT+Hw1e2wz7Nr6UvgQKbspt3AUylqj1YpdQ67/ALE926q/yQmll3rZa9+SLEpHoSquf93bnHzc1WmuS/rmcZehSt4sPzyScqZGZ6CPLHRmQKFsUj0snefogMYiK92Jox88ZhIZSrhTizBEE+2cRiN+dC6ILMElDVyMfLc7ci4I+sXYn9OXKMD0P4VMCyU6Z75NMsWvx0WuM1ihIDjnfMc7i20UuYKVE2R9deQnvZ9say6Chxagj5sCFPJmV1sPMJPZjJkarWGpyudXu7qgPEJazvam9p0lTyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=239n+lS6Kh9kOfeH52nByKi3fJm7/XJQqx62STUsCrY=;
 b=kfcNYg5XWXY0+etN9Nta4oSNMtpZueQQbIKH//tQitL1+uPKZJw2Jb7EJrnIwYx9TewwrKol35RJY3BXRUt3ojs5guxWQyk2oV0VMgnrmmnoBOFvHLAwWPwsHrXABFfBeFxPYBmqw2hY18dwAqixGxV1du2ZG7ltqmgNjgrUwI4NAzZvjt4QaqOnJonTtcp6ZWxHggUcs9kMnJG2Fdr+q2/jJ+iFuYLL/Dm6KhQH627YoqQ7xzKh8e4FKxCyxZIoKXQdyIAmxtJeBd5ngCSZRKpneNdSLzNlErglNs3gfp6Bvoa8Q+YyORvILAm4JWD2qGI13tOmPY0mfoIRFF97ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 09:22:54 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 09:22:53 +0000
Date: Sat, 10 Oct 2026 17:22:02 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
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
Subject: Re: [PATCH v4 03/17] KVM: TDX: Reset private huge pages after S-EPT
 page removal
Message-ID: <asoDuoern9crESAS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090845.15518-1-yan.y.zhao@intel.com>
 <b132f782d73a13b137b6892d1a3b80360f676776.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b132f782d73a13b137b6892d1a3b80360f676776.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0011.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::6)
 To DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|SN7PR11MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3154b518-bcad-4bcd-78c6-08df26b00f97
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|22082099003|18002099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ytfbvX2AKKM2jRntIqyxVKMbxFu8X5IKmJBj8zFvlruLsUPOP4o4dpCUDDlwNgGIEV8MlHqLlcFwS2gkd4Fm6hC8DNcn2+lva2rKqq2yGkkFj8X1i/GmjqP2Q2pvNELiFcG3pLUQ73fjKE0DyF4vmOB8eQpHLhErI5xam5pLWw5UuplqPPqaonpX7a6Zxp5XyE+8rZjFRFfpI86Fb6EwcEjrnIz58z+VA/nwVwuuOVlFjqQ55RVoduk2IwtE9nEkDz7OpbDHIB0NwQUFdLjqopZot/AOQuyw+t1e2Jhjih7tHmY5oN42d7Y1UsGG0cpTIu3rOPKbLCL7fjCyATkw/O+WJlCgL6U+OOf2kwXHlVCDQPurLr88hpGFlLKa6mKxSToDfpmYsuvy+3iOyRBMizBKX9CYSPQlmWx6x/1nK7rB0LHw82Z8kVw8q01WumMvWtcSY0TbiLvs4h5rzQph2F5oMGBslp70JA4NqRYgNH1JzbiuxMa1yeV4rjXbUPp4GZyCcR6KLP+G99qhdGPU7uxy8i4CNeXdeJLptOlCdWf7ukKMhmQLKhfOgFyBdaG/s/2GGx5zW5da990sZfW9IHs1ulUG3rh8oIOgt2wOOFkFES8AdcEmTkeopTvw2p3NQlXA5D8o7+FUYnMO1AAQrxDMTu37pvrPcie9ox6cSKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6FJMq+c+bdq5KxP+xbxMCQEwTN5BOs/37bQ//Jf24N/9CrSPZtLguLNA4jT?=
 =?us-ascii?Q?zMQe9LWutIWsS7quCsh4vu9hIU/e4oJfhV4VFcVnH+KW68xD4rBh+3bFqQCS?=
 =?us-ascii?Q?xeNG+IaFJaQ/qL0zuDJ5/TvSzTu5cDCMb3vsNdG1WK5xs/FwSAYNVZjZQYOH?=
 =?us-ascii?Q?N57dUk/Z03hG/fPpwBSRWV3J0xIpzEKBHOtK5qa/dD5HpvHgZB23az5hu7NJ?=
 =?us-ascii?Q?PGqx21nix4wMvHkA3oa6kNatYiBLIFKlGyGv6C7vUWB+hBQJiL5ZCAj95zHB?=
 =?us-ascii?Q?Xo0MtmRiZ75e9dZ/suIUpiReBe1B3WEiuZVnEcpTwueaU9sVD+1FPzxNjByN?=
 =?us-ascii?Q?QN8sV3iqYc4YVNK5YGTdMeXFc/OrKl6avUYRIs/dI/9dXkR2vx+66PKlEyts?=
 =?us-ascii?Q?4z7aOhJe9C/ToxmaERQJq5CQDk15Xnf6bFW5uqE41COGDEhTscRQKw7pDaTQ?=
 =?us-ascii?Q?ibZVjhTBJddalbwXGEuRK+NiKyHh5/sN9YnPo/zBdA1849ww+ygCAN8oLLjS?=
 =?us-ascii?Q?PRtjNsJ9n7xOkZb8+6NS7U+VPwfieQPCMx6mh11jEQV9//TXy+dqASzqfi7o?=
 =?us-ascii?Q?MMAE/N3+M6Uak5alIrYv1IfJ0cpoAS6fVJI6l+tyXQwLLJd+KXqYZM/Ga2/t?=
 =?us-ascii?Q?34zCJkC5xF4TdAb1TmX+fDEJOUQPOOOP7rcatjFtKZZh+L9utS1Mk0pj/R6T?=
 =?us-ascii?Q?hy0hF63RjDASgNHYItLI2gl65X42Zni+1m6uvUg7gK8yRpteVHlxw6gZGvOd?=
 =?us-ascii?Q?1pwcXn0SSMCmDOL73i8yQyKB2gQJpn/c3FYGvxtZeMJdHqMktnyiL/2UeqVP?=
 =?us-ascii?Q?J21uFPO6TTTLW23zw9AXaUA4NTSwQE6+wn3bckmyOSczIqUkb37F7Iwn8SeF?=
 =?us-ascii?Q?Um0aquAczLgmzHqO7kodxvrZECU/85g7qdYFYp6vmqG62j1NaS5l1/+1/uyo?=
 =?us-ascii?Q?AtW6I6udC2bCLYwWxL9ADoF0PZ+/rYXcQNcy1K5y9IOVKhohiRiCcM+TNbyB?=
 =?us-ascii?Q?6lqg5zEVQDwAQoNu4T4JvIPN/JomjIwhvu2pLszlTqCY9aCMx/AFn5VaMdEd?=
 =?us-ascii?Q?6m66synNDx1oa/u0fbUOoqPtZD50iPQZ3xPnnNM1rMX+fs9mb4knyXArJtJm?=
 =?us-ascii?Q?iLSMAygz4nBF1KjyV8Rgu5RLq61+rL/mn1xkZgRwXRgPrI7uoNX89DItPkdd?=
 =?us-ascii?Q?+Fx+s4POveh70RHQCvXTBzKQUZZdV8LHX14qU0CegFM1we1QDdC3biBSrefn?=
 =?us-ascii?Q?hHoWc31Z012m6ZacxGoiovHonvSbtxQnmGp8oS4YPRwlhZCUEE/cGA/Yb2BE?=
 =?us-ascii?Q?J6DXbfhSDlIwgSnskZ6qsUlB1qJOCgz29zgz4pqEdS4bwPwG5ulvGInYIJjv?=
 =?us-ascii?Q?8+IrLDEPk5+kqGSBUrmYCpkumfTlRtZbvIWIF0///QM3izHgxu2p3HirRupb?=
 =?us-ascii?Q?CyJFESPcE1/emQUC1HIGar6JiZ7c8bbk5Cw0kkA53arxE0+9mEeD+bCl8Lt2?=
 =?us-ascii?Q?drEJY0QWmnDhfDunXIoWKPCBf5VGab9dkCHqXkP0ZbJsJZ4c9iQlJgxlCtlv?=
 =?us-ascii?Q?DyUzx5JUgkHG9MlhJqNnPZ7xILLm57RTAl4hNRKxbV7Nzyqmije5PpRNuiFx?=
 =?us-ascii?Q?55MiEylzFKXS10nlEK9S/IHQmunTEff/jpfiNK0NPVwuAYyJiPjM6RLYgdzX?=
 =?us-ascii?Q?bHDysbA1P7MvYTAhWdTLZKu9HyI+fb6/7uIdplxyGoff9cqsSvWBoSAKxrWd?=
 =?us-ascii?Q?twcANhjhEQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3d1vqRv8i2+h2Eg69bjFPgSOMUOsGdlBS6iixNIQmQfrp12mf49raltYEA/81NaeDjeqszuWApk5P74fQ46z2sTa7+MmZmHI9qZ/CPHrA7/8/ZOTt3zb53JlPj8MwqB9x8GmCv0QWt+H8Mi0/FGYjkuqt+ak8g+yJOporNkM4JnaFec/EHrOUCJFktgRsLgOwjp7E+vobKDdYvzq8s5FcCHhZg8p2wOKWp0JmP9THMiXbmzPJQT58laIR2xaOvsqvFf55exzTpziOnKz16sCeaGzlrSh8GJ3gSYFK+h8wwgY90dXKiJBmMdH9TUqk9c+IXuwxovICNp+ESYVfAOu9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3154b518-bcad-4bcd-78c6-08df26b00f97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 09:22:53.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz4WjZ10dE/LQ4VbtWAUAzPFzvOXJ7nb2ABVyyUP4AQI/R9G+UD2kRexfgle7fFX9guSePkMWx3iqoHFp93QUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com

On Wed, Oct 07, 2026 at 08:06:29AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:08 +0800, Yan Zhao wrote:
> > "Resetting" TDX pages is a workaround for the TDX_PW_MCE erratum. Once a
> > leaf SPTE can map to a huge page in the S-EPT, the entire huge physical
> > range, rather than just the first 4KB, needs to be reset before the host
> > can reuse it.
> 
> Code looks good and simple enough, but the log is a tiny bit rough. Probably add
> about TDX_PW_MCE needing to reset any private memory in a special way, and make
> it clearer that TDX huge pages will be enabled in upcoming changes. And is not
> supported today (so this is not a bug fix).
Thanks for the suggestion.

What about:
"
On TDX_PW_MCE erratum platforms, a partial write (with KeyID 0) to a TDX
private memory cacheline will silently "poison" the line. A subsequent read
triggers a machine check.

On such platforms, "resetting" TDX private pages by invoking MOVDIR64B on
the previous TDX private memory before returning them to the host is
required to avoid potential machine checks.

Before introducing huge page support, the reset size is forced to 4KB when
removing a private leaf mapping. To prepare for the upcoming changes to
allow mapping and unmapping private memory as a huge page, update the reset
size to the actual mapping size to support resetting the entire huge page
range.
"

> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  arch/x86/kvm/vmx/tdx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 410c149bf776..11792a490330 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1865,7 +1865,7 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
> >  	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
> >  		return -EIO;
> >  
> > -	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
> > +	tdx_quirk_reset_paddr(PFN_PHYS(pfn), KVM_HPAGE_SIZE(level));
> >  	tdx_pamt_put(pfn, level);
> >  	return 0;
> >  }
> 
