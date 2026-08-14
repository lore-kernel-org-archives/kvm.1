Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994643ABD80;
	Fri, 14 Aug 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742302; cv=fail; b=PD+F9RF825540TTevYTbkyN6VQ5bSAkJzus7WjZCCVkXzzyfcfGvKB7cXn8fDlSAbUKzMudHFFr32rl5Q0lpAad0N11tWlw2U+FOZliAiM2OcOdjLTNlcgLTq74oPIgXEDkwnqnRfCDznU8BY3LPZs0+WFBPnOlTnQBBS1CKhbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742302; c=relaxed/simple;
	bh=qGdEzj2ThNhRFIB6q52e9HwX+LuDM9HGXy0pBBtAK24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwyYmfT37wX0ILXkJG6h1D2p4SZcgk9zEhKxDFUt8bYTf1e117gsqFk+RFFFmVCdP+KEQwL4aXOTF/68X4mHcBFGDD9H5NRtISmls/Gu4ULTzaQKg+9x60xie+ZJ5uuff5Xyx09uMGDaXGvijZpeHpomMKUZe1xB1mmhjXHhvdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRRxiqeE; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRRxiqeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786742300; x=1818278300;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qGdEzj2ThNhRFIB6q52e9HwX+LuDM9HGXy0pBBtAK24=;
  b=mRRxiqeE30ZzZc8qGH1qFeMp6/3ND5TXeiLcGMe++kWlx/UbX/OkIUnp
   vOGfrwanWeMBrMFGVytQ8U6nitDW7IyLefDfRjq0Da401QA+1NG1WQmu/
   WBu9host2fZe83JCO2dDjBNNDtAciPi6nrzh84s1aDI11F1aDEKt+P3Dl
   FwH5yiStQhStAxymYM2YqN9ePZIQr2BS+TbZzeiz4Sy9t1z6xjTb4nWhS
   tBkADZuHx1cmPluu08PmvjOo0JATOPBm2gYAjELce/X31WhSw/0/9cr3Y
   jp/TOU6kmWLw8NDYQEK6m1/EzuM3WqT2IiAvW1RxrOhTfgtM7VC21e7xe
   g==;
X-CSE-ConnectionGUID: Mjui8BqYRdSD2uMtjnNRKg==
X-CSE-MsgGUID: BZxUDI+wSFOGZkWJNpJwyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87183863"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87183863"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:18:20 -0700
X-CSE-ConnectionGUID: dDOm4D88RkG68xbFHdHBBw==
X-CSE-MsgGUID: wu2W8gIkTdWh6yZ/sLy4sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="264940970"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:18:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 14:18:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 14:18:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 14:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw2PHFJzc9XVY36mPFFopUvC1HQ794Yjt1Fy/rOV4kfe1pT50mSCqKZVRLlpTejwNxYIkKmfpV+ssIx+3Z4hKtNRINGi/u3IDI188tGTpuYfioSmMTD+XE0fqwcrrykZDsKIf93SJTXJ5EOzXer0OUdqUTiQjXvz8pOlQjAqfzrSNqkvu/dJ6edPt1/hNyyz+EaLQsO9qsMZd1SWljdvKIZwCQ2KZg6/fJc2UfACr5deuM+szPThM2FkQ0VKphrdETpYwbNx6WOajdj7BB1Rc3fC+WiZeM0c6v5tnVbhFClmp5mbfjxBcznIC4ho/gCPh3vLhqBC9bfY/0HSsvlm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sMt+gvjZ0vEz3xGurx5m24n5ykX9k2W0GKoY1ulnjY=;
 b=iZvRLPGd1nWmR5SfwKxCENzzGpfvSwienmVhAk6i67VL7kKiVPL9aDMzc46f2dzkQjm+0Elwz9iKFhUzkuvvHR5nBDP0dzNZCp40f2LOSiwxQHO4WKbMqdHg28F/ToQcTV/vcK4mGfBQBdj53lpBR9VaKDoQthj+AU35VFwkzvSdIdQei9s3cZK+kXTdg886TBFTEZqyxOGl4yvZ0F1oqwrTPiISTV1Yprh6/G5zi66qg2nbcA8MaSwRQRMQtLVQFChCUPMNJDq04W/PEguprJo6z3AKKoytknxA23T2KSNf5POsT4QZOYZe0HS9/fSOnppUMSwNxEQdYxtBkamPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:16 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 21:18:16 +0000
Date: Fri, 14 Aug 2026 14:18:14 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
Message-ID: <20260814211814.GG1013044@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
 <0706f7fc02ac17d292ada97443ca40a806c0582c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0706f7fc02ac17d292ada97443ca40a806c0582c.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA0PR11MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: a78ac6d6-2051-4043-df01-08defa498e43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|56012099006|6133799003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JoAN4K1cHxqGqOiTAHRaYda9RKa1CXGXTxNH/LOE2lSStA4RYW184K8gqlgT+vF7pkS1TjsBemBdX88Lrv6jm/7ECaQP3GCZUemuuwXaQkv/YiuWFjQ9qRc/3jyJzXpcfQqyvDi/Aj2UABAwLfYuucS0pTtIroh+8L6vLo2QlyhljzG1NFDTBHLb7mFwvSJcbDEm0adhSMlZ4p/ZNghUlJ6q4EwiNE2yq4bN3VCRNIfdY6ZdQ+D0YF54whQW16izcWyVb/FRv1iZGHkQVpmYm5qiD8cB3pryM7lak1NXqyuf9tHIlY3MeRzn3HfBglASV3ozDnudAJqdXOCdKN2lwVW/7zwLVTb56wN+/tCUQg+YT27gG3u0OAeuMv3EtmTOu8uCx1yNeW++7qkTVFTNGidsewn8gl0SxrCBQmnngcdjVm27bkLGlib+fJGaqr9g69D6B7K5bdlP6y9eQ0m5IKsfQhBPHnOdLj13Eed70EQrD0Z95Hums6pj0Iw9U4XSOw/4Bv0PfY2n2mvFJb+HGSTMPe5+JGlzgwrHvfpjO2KVQJNv7WGcsZSSy6Wh4ZwxsKNDuD6QOHYZa3f7pgbTzpL6P+NYZimDE9vRQ0RvoP/PtwK7XSyjjceRBuEEYcUa1VrcY721LgtNufwnnkBWHPCQtSoWtQuhVLPbCANYfPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASHZyDtsCi066oW1YhSBMG9R69Yvp2Snwp5L2G129mEvo3WE+AxbnaGNbwAB?=
 =?us-ascii?Q?kG9xBJw+MCNdX2Qj7yiZhDnl6LJb2StGHetSJ1COdbVPx93l8HRACxu6sPSR?=
 =?us-ascii?Q?yEQK/sz8Lp7xrMpxrn96MQSCR1PINdFQAIAluKT1hBBZhn2jgTkGoxCkWG6Z?=
 =?us-ascii?Q?AixYpc3EJOBdFmHkhk3zLLIZfZ/10pci9QcJGyltWa5bgoVDkwXE2kWwS+jX?=
 =?us-ascii?Q?4S99ihtpOG6OcQbYdNDv/3jJKLAms9ae1vON8jGu5zdYbuyIsVKXrjF7NFs8?=
 =?us-ascii?Q?ch43AW/v1Hh6Jgbkw4VWJcTRTDcbvT5msMCYDmvW8yvbxRO7mTO7udv0Lr9Q?=
 =?us-ascii?Q?wfcdGSRuQ+iP9ARvbw8PDpUAVQHiFAmkt71mVoVm0/bbGHNtTVUBdnpIx03G?=
 =?us-ascii?Q?2XWooKAiqnvHfwmvqJeZ89dMfkhlX7IGTW142D7PuNxImJ1LzpcNkuPt+1b/?=
 =?us-ascii?Q?TNf8+RoHCnv/MXQzNKT0cLLmT4r9H5U7lfOKvLhtui7mocdvTPnXY4mA0A96?=
 =?us-ascii?Q?r8BnHM8nn994b7LUSOJEU4eJBInDTezdwKp3Nnhu3sWJccLVaQ9vs/zZebO+?=
 =?us-ascii?Q?ziHlbBxf3VW8Zpv8JRJMfLpUhdIi1SSKKlrjXH1obqmX74nO4pAf2PmcF+iz?=
 =?us-ascii?Q?XU9LWzl3E6pwZHsTwI+UXsExmF8urmcGzQ7O2q0hZptAZqaiLj24eAIZNhIv?=
 =?us-ascii?Q?uCxwS40YYg4tWebncB18GOgW2pQqqZbW0VwwTYsPEqfsWCVhSrOPP8ucnJI3?=
 =?us-ascii?Q?0fBGpx3+1kMxx6uyt97gCOSQd4CiGYIlgP0VIWn9wHfOWkRZRGOz54BTGb8X?=
 =?us-ascii?Q?S7qpcv14oP/6kX4ylUX3IiYC9zqfOCq/HBna05FwSfwQVGo9ycyebfi6KK7K?=
 =?us-ascii?Q?aRs+eVjoVbxjgG2w8xxRuY+W0qGWd20nDdcunLKCfthqOyXrz5eocGfMSVpJ?=
 =?us-ascii?Q?1YXikOzPJXwK6pQgStzBJB8bh+wcj1RBBqfgq75E8PvVwPXWM71PPAvnbzMl?=
 =?us-ascii?Q?6frdzTgX0zzIknJhRWGAaC5qB2jLwt6lKu7046t49+ZTyZ1j7Vo4ynw5r4Ew?=
 =?us-ascii?Q?wjwv9Hp2FwWZu8I5c+38BDJTMHRT7LMtS3H87RO4ppZUfzJ2noRARijNtikC?=
 =?us-ascii?Q?Ykau7Lq2vFHUkB+lbZyQCmLneunOvDPx2+8sLsPe80R2ofubYbYNxgq3WEJe?=
 =?us-ascii?Q?rXoKMPXXYtECRR7ceRP7uHzP1YRqsiZXHy2sTUPLN/G1sSYUQBkfKBrsO3NY?=
 =?us-ascii?Q?qH4NKr4HlzyLfOr5skKdhw/T+qg87ZRiZSEYm06wrclw6R9Jp8Hss1Gx3k8L?=
 =?us-ascii?Q?yBIdvglI/vSaDeDmyBr0WhdKNqnsdykq7prYeTwWVYfifb/WcPmzy3Qo/emA?=
 =?us-ascii?Q?l8zw7qgybu/SHdmEPeOCtGBiyvFxgazJXOlGz9NUgUsRJELdD1UcRQSHdS9x?=
 =?us-ascii?Q?xK9Da2Zj8PrXOTAjXPaRzpmbxWDvo78VMK5YJgwZ3AvX+LCwGKaNAFP4gD7e?=
 =?us-ascii?Q?zz0BYE6YKYS7M8hUydYQZlTbZjFTjNKzpAqpNoktnH7fv9crplaGEYWnM3lK?=
 =?us-ascii?Q?cKa6veEXEoVTkeQn1MyqK1JISNoMGaFnKAqTnfuVIxG5rLAZYPIsHKkkQ8D7?=
 =?us-ascii?Q?1k333A/Cb1e68O8LWA7mTixVv2FP4Ntkvw8NSFcnXa8lCuwymUJBf83kh5Zj?=
 =?us-ascii?Q?6Rjs61fMf8PMZ297FCSLBWYYM4RS4CKtFmhqdMpGo3NsJ7CTvOsc/xSnR8WA?=
 =?us-ascii?Q?jUMD7Bx9Qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: URs82fmzYONVKaN4oepJ6+CX5l6RGcowzKtJ3hE/EnlAzYlUNt+8OH85Gi2vT7bz3xmZU4H7t5O5BLeKfgy1w52OKqgLck16gb5WjjpwRDCXIZxfv09lyK1DlcEcHeGSRAV4cHQsa/ycD0wHairrj9eumDuVQD3i6YBfUvBKXbu0m4tQ/y8PB3ayZtpg8js8ee6eOeWcVe0kkGD9yctml3eUBYByx/trSGK2iO5qoTIqcYWzSJoRaDcgYd6d4qu/ZRuQwALnDFlv9FOoePFfB0WtJ04GKEK0wZz+72W0WuQ0eHI3mYuA41s5L9AIKUgYzx0KvgMr/KeJEqSwMBYPfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ac6d6-2051-4043-df01-08defa498e43
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:16.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQW9HFMaJfPPEOQ8ATNuSzkkejc7RYGWDQfoPpn27kP60W7byOnsW4qkRghUteH87U7/KJYkSPmLi607iB/sKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com

On Thu, Aug 13, 2026 at 04:41:07PM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-07-22 at 23:13 +0000, Lisa Wang wrote:
> > From: Sagi Shahar <sagis@google.com>
> > 
> > Add tdx_init_vm() to handle the mandatory VM-level initialization
> > sequence required for Intel TDX.
> > 
> > For TDX, the guest's CPUID configuration must be "sealed" during
> > KVM_TDX_INIT_VM before any vCPUs are created. This is necessary because
> > the TDX hardware directly virtualizes CPUID and includes the
> > configuration in the guest's initial security measurement.
> 
> "TDX hardware" should be TDX module. But I'm not sure what it is trying to say
> about directly virtualizes.
> 
> Also, it is not accurate to say that the CPUID configuration is included in the
> measurement? Is that right Peter? It's not in the report, but is it in the
> measurement?

CPUID is not in the report or the TDX module's measurement. TD
attributes and XFAM are in both the report and initial measurement, and
some of the bits in there are related to CPUID (e.g. ATTRIBUTES.PKS or
XFAM.MAXPA_VIRT). Probably better to make a distinction between these
things.

> 
> Or maybe it doesn't really need to be in the log anyway.
> 
> > 
