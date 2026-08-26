Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C33E0C4A;
	Wed, 26 Aug 2026 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787782660; cv=fail; b=YEUt4+eiGCPqHgo3Uhab6nPAOK+K9kkkuAt7H4rH9egwaCHE8aRg5uxT1v8/dmQ2dcZ03w+TFXnioV71NFiB7KC4cUh6EJR79N+IQXf9beD/3rREFvEKDDi0z/rRNz99VWc/YeC5x65veHcEsWy8DBMekJ4Ae7pvT+uyK14fXLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787782660; c=relaxed/simple;
	bh=0qD9vsGSJiUbG7NDdUSE/o6LsUSwjljSQ73GIN4nVG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMMNZI1L9OoqDFBYwc1n4TeKkXS2FkQSjn2oR5/YsQDeVL9Q8LL9uRRzqwkBaHlX0Ka4n3keqGkCCV7C/di2TNslN8dAvrr8GPPM4UYzwnFhbIrzUfDBV4YyRERILjwuFgDyatKSZnlIdLTwU3dwmdpo3ltvIzcD91wqYqN3o8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLSYJzJW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLSYJzJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787782658; x=1819318658;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0qD9vsGSJiUbG7NDdUSE/o6LsUSwjljSQ73GIN4nVG0=;
  b=HLSYJzJWgwPTPck6WG5VvwCPNUiq4BGrmgtGQSViP1upEzLOBA8hldQg
   78uGwmeASGplbVaxfmFaJ6N9wD7KkKJ2pSSpPqEKRxiAgYbYJyEc7AmvV
   ESxnWx5KaXQzzmzysgnlqAUzVnhqZz1fSz3Md23FNizATWTNwXhwH0ATb
   B6UhH7IWHxScoESvqzbfXuOZb2kD/EMxptUc+ud69/vXD0QaBkSDLwoIc
   lBopXHuzkDgRck4rNIZdJPT1mNaKkSA0mnxhJhYRuf0+Ee9J067d7Q0lg
   095gXpbNC+WUa3iA0p4NwZmYtNUd5TaSLhMGYiRrjHDTSP1TMUWhuSM/+
   w==;
X-CSE-ConnectionGUID: 2dbr9HCpTymbTtE1mIlR4w==
X-CSE-MsgGUID: XwSiJPbGT1+vLPLrWZpK/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92137925"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="92137925"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 15:17:37 -0700
X-CSE-ConnectionGUID: HP3qYQwhQGyxXpf1Dvq1MQ==
X-CSE-MsgGUID: CP1BnohaSHinITQ71gHeBw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 15:17:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 15:17:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 15:17:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 15:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UObQoDeijRfTWM3tst/J1WRTJ0jjHM3kWLMrB3MYNdcFhOhRuWyuZ836NafJ5SN1NDu16BQeJ5EBw2roxVjfloX6zIIt/lyi2h2o7TQidopHEVSgM7IQA85hF8kd/mNvzw8Oo0MOPuwuhftRKGeEEo5YJFs7gGQx3t3zBKSf2jOxffGloupujEWpWzL/4WDfSOF4NFMXFuIYEOVO7IH+0sea905arI0Qkl9Rs7ukYy2+f29BzcGwx2T/lnw1wFzQnCHd2z+fHoT7rzQfolgvG4VAgIlr7v0j1bbxpm65t8nj9tf6Qt+E/BWy/9KeUsh3/oinIFOjD4XdBLxEa+NaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVXd5m5BcccHvKc01Zol+IAtvq4Fi3reWNj7R5lZyq4=;
 b=WYT4Gooj1t1+wL1mCR/Qe6DRPZp4CTD1HUOu5b9ywd9WZTmr4TiYY/gQD95/nkaUZQz3t2SkyG5DqkXqorf139UJMmizOgAH86suFE8HbGDnGrKkEFu0SbjD6jQs7aRergd/VdzenjBHIFOGAXa8FclTvXnAKkYVAdy4cjqJll8ckFVEu6DefGo9tytkivtrvHGeoJLZF+QMQB+kqsTFBO9CuF2ZRNBtETOr/vU9QxkYfLDDcJz73+4cgGvqK4wa/vdFhdWU96bDhAo/qqQbmditPK70rRfA7X+kcA68yAkQ2u7LQzHjJF0K0Jtq3zVbHFPY3x0zECEsj3b7yCOcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY2PR11MB387948.namprd11.prod.outlook.com
 (2603:10b6:930:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 22:17:33 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 22:17:33 +0000
Date: Wed, 26 Aug 2026 15:17:30 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 16/22] KVM: selftests: Load per-vCPU guest stack in
 TDX boot parameters
Message-ID: <20260826221730.GB33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-16-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-16-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY2PR11MB387948:EE_
X-MS-Office365-Filtering-Correlation-Id: f789a71e-459f-4917-d306-08df03bfd3a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|6133799003|3023799007|22082099003|10067099003|56012099006|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: MO5AOrbQHcBrnBXTW5XU5beHAAaI0MWaFNRj+jPKlFdl6afg4E2H+CDAxChrQXXUyRfl0W3wN5vdgII9r4gidCCTGNDT0DU/uBiE5tmmXEL+pO7Qs9qqu01tn7MJD3UktlMH01QBf/wjcPAlD3IPHzMj/Gdr7GoJq1uVgNr+iozqV7EZohOrDOmjiJ1OE958DVwEvotLHxtTfoAuvltk+WhCw5BbqGuu9hnx6H3iFfFnLAkVoY9qhZDPxECuqFx70zv8z+FIwwdWgzUt/nQ9qNOynDH/tim5zTAQrxOUj+ekB7gNicL4BryfCVigkJR0Du4v3164ptwwX3bYbqAmmvNCSUacckFgB3MWNpbtREtBS0ZHi83E51la/8e3/He8/4OJWnNlvYg+2P/h5T1kkaMuLROCw84oT0iEIfqA/n+SaBs7nKe+VUpoT3pycmzUuS6vjejlu+UrkkkfNAoeLFAgw4xL1RWLlgVRvH4x33mmlm1sOwcyS89tOTTY73JKR93/Kihnh8Sm1kapbPvFRTXg1fjpaaPJ6pna8NHQ2E8KFgMuV2QI6muDZwR7brCxkLz09XMs//pZ4aJTPWjR54ALpz7z+D8RLKGgltJrcjIN1KwV5sQPhoXDXCASTifhs4w5O0j9VZ+GjwWbSdqGkcR+5lsYK2s3Prf57BBPZF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxkKClSydc4Fdxu18FFN6YWa01nCx9jFLrHV8FmK/xzmfbncrP1SipLvQ/3o?=
 =?us-ascii?Q?1kLAHhlguWCQ7kaPwI5Tqqi3Z+QH9cmXG0dOHUfEJzfATfbw0gC9tdhbEkqp?=
 =?us-ascii?Q?GeoA+h8+mzVqufR7KU5Qx1TItLiEclhOZRxgCsBuI9DZC7UJKGbEzCfkRH/Y?=
 =?us-ascii?Q?Ub5RqOQP6VH9B8B4PcMS1OaqyW7Fhdw75DyHejpsuNxO4H1Qff79gp+YWywS?=
 =?us-ascii?Q?ZnzIgMAHK/WlOaeLWEEKDGC5i9Ll8A3vsOIbA14ziVhjP6z/MBNV6PKydnBL?=
 =?us-ascii?Q?A3ZSoi4Vz2/3syi3UxdvB+jwIclVFzfTd/t/iU1rt4O2i+pSZsnRnzfffG+0?=
 =?us-ascii?Q?+6DckRmAWIszaVXsGEo6WIVx7ldwhDZ+mcNRjLyTCixXQhYtgj9pcZbt8xXE?=
 =?us-ascii?Q?w+YBQWeYonO4SZaCWtgiUE8K5GCcfgO0w5sBwuF3GLqU8c1kg4soqJyYqbDh?=
 =?us-ascii?Q?s8uUU0AIoTIQNeqzXbx0NP+RZDH05y/vqcLxXhyW9PEXg9D2wmbj5hqI0YDi?=
 =?us-ascii?Q?edpLCQ5fUZZ6J8ZhMKTM6bqpEMSiOE5npkVMcglmxVJLcz+vx3sQ3+s6EvMV?=
 =?us-ascii?Q?cdBO+DXJGC+fQ52625sYzGB93WoBFAMLhTIuaZtw8R2LrD515sKbLkEEapZr?=
 =?us-ascii?Q?IBecxcmOH+qv7Fi5ru4WcVFoH/cnuOfoCyZ0F2zO5DLI4JCMYrl771PqVT4Y?=
 =?us-ascii?Q?7gEgUvBWd+ehOEKDg6vHWuVHI5a2YDsGbNeF2ZyX4BtEsYFtPOZwfYWIEYME?=
 =?us-ascii?Q?QnTOlDyHkxWWxSZcC0JATpqMXsKX+R/aR4X29xlVzPF1ZJuUBXdREUETgAnx?=
 =?us-ascii?Q?9FtXx+hprdvosoAbU5G2DFw5gKVA6gQPrrTO/Y31P/xFRFucd8J11YlW0X+Y?=
 =?us-ascii?Q?FbNwkdkG/3g/1NsFDXVcvLlAkJVA78bwU4cZ1+I/f2NFWKxEXYJ3qhGUf5Wi?=
 =?us-ascii?Q?lfss05bKbUgtZNFL3u4uxRweBVvpv5ojuJ93TLy4wPmnJIkO2x1Cnfu5as4f?=
 =?us-ascii?Q?tBmwhGPgp42VRriIOvr6Gll/UAn639Gq9NGwv231O4ns7IRJrhXLr+usrfgm?=
 =?us-ascii?Q?Xr82c2e8zQa4NYyu/PNI7+Ntwrce7mkILvSD1qm7gVa09VTjSgI658Luyv7F?=
 =?us-ascii?Q?wrLxpnqemvrN3dXik5+jRQ8m+3ntitXgmt7bDUztRzBVq9t2KVjLytCeuGV2?=
 =?us-ascii?Q?k/FWL28sTgMJPWo/o3+t3H4dmQaIhqWFzwoIDVXNBVFlLuX5D3h4Of+t/xIX?=
 =?us-ascii?Q?oLUJ1K3zy/2zNRWtagTGDMYeDQiyE0NbSSCs8103D0ySKU5HN9qngneNLk+5?=
 =?us-ascii?Q?m1BAJAX6i718pjOYtyQBviKJ8lGJbEd6JE+eTE50Uh+SG6K6q6tUIlIWZD6F?=
 =?us-ascii?Q?03y575gGx6uZCBKR24TG6iyOSSDBkNWaFvaJyM9Ro3xr4a1bmLwtrmJDvK9q?=
 =?us-ascii?Q?kbmALmCmJ9XasJhCzTWovwxkFdKmWQU3zOLixzn+X2Bv+306ehCjZVFXedso?=
 =?us-ascii?Q?KK7ITgm9hnpEySazFTV2vPugWXSSulcCq5TMMz1g+FRt7JcMea5LgYH0wZFF?=
 =?us-ascii?Q?YNQGCJk7gK1mb3HYoqJwGFCJvsrz+Lnl3wZ4Attsi1eMxcD5LfqGvkfTpXWI?=
 =?us-ascii?Q?9Yg+k8KkZPJKSCpWkJPCumeVjfnyjvktNDUW8/wX3VV2rHlYerW53ARgbOp7?=
 =?us-ascii?Q?SmvlLScQ5cwP4Lay/U6Xa5ZRkI9hJpggB9LgNrsX9jICMKxmh4PyJZsT9pyK?=
 =?us-ascii?Q?HmaxwxiMoA=3D=3D?=
X-Exchange-RoutingPolicyChecked: VcnvtcMR8WvgImRntaJKJYATc32+PodvPw87hx9rrdsLGJ6z2CE3c+1U6S21oytrG3IckahbNoCNu8m3ZVv6RoHzVl0Ju+SV1yGENgdREJ+ODQTWRSzRXKKKkF6sKklir5rSxwRlGMkFblk7M8fA6PoKQP+hMWfHHmHcKlAQYGLwtT7rh/5vqMxSV2qTvABpsJdln+v0r47aj0VAt2GjNtjRXDvAFEbzgVmmBeBHSTnLNjjAsKvks0tiAEjLDHNpzLNVUR7FWVONFwqVU9VsXZp+PN8qovs8V+WCy22BzDWojMYMQZa7fDb1HvaILzKQkCCmiSR37aw5QEYdKhoe4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f789a71e-459f-4917-d306-08df03bfd3a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:17:33.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwRMsH1pWidyPj0LycXKZnPIvXyhHKMtm5py7lTNSD4oFTYqPMJEImXTkxtooJ5VJxNnZJUtgMjB++qMUppFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB387948
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:21PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Allocate a guest stack for each vCPU and record the GVA in the TDX boot
> parameters region to allow proper vCPU initialization.
> 
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
>  tools/testing/selftests/kvm/lib/x86/processor.c        |  2 ++
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 10 ++++++++++
>  3 files changed, 13 insertions(+)
> 

[ ... ]

>  
> +void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params =
> +		&params->per_vcpu[vcpu->id];
> +
> +	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);

Just flagging that there is a subtle truncation here. The TDX boot code
sets esp in 32-bit mode so it has the same visibility constraint as CR3,
which has an explicit check ("vm->mmu.pgd < (1ULL << 32)").

> +}
> +
>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	static struct kvm_tdx_capabilities *tdx_cap;
> 
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
