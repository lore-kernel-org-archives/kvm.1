Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB624BBF0;
	Fri, 21 Aug 2026 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289414; cv=fail; b=jFbGu204WdH7C6dOCvLfkiF/T94SYmHrhBEK1HqZkVa407RdpgSKAQmhJad7iL354p9uXZfi7hHje4/FBDLsOdU3I6Pc8e2sAWOmn9i6lRxcmH7reg2on9ptgkuh1do9K478DSD8fSdK1q0Jg4Lz0oYJCxN/cdzwK/lQrVLo0QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289414; c=relaxed/simple;
	bh=3H5k0dmTpHOhuEu4cO/x4WzsOlDqAmq8N9FQyEgF6Fg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pA5rSZBtYma4GRnTsld07cfw977m1Iimcw5cggKQ8hcQm516IDKqnoDCdnCxyGylW4Yu/MGgvsuYQLan8xkW/1qgKMUHlbD3KAqVeCFyP2I8qudO0UvyNnruS4UKq7VbpSqPUMneDEFlUo1o8WAFKjN5IugB64q7vKjs1eIjk7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=No73+gtM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="No73+gtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787289413; x=1818825413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3H5k0dmTpHOhuEu4cO/x4WzsOlDqAmq8N9FQyEgF6Fg=;
  b=No73+gtMRcsZCdfuwOvLOHA4WYUFzXSMkD++WFpLmngTweL1Fr9d7Jsh
   pfdL3MaGRbisLnc6meBV7Jy/nKoFHiEGFRSCyZdmFDSYNcNjlY86bXYHW
   LHfksPR0b5wShVNEoLOfXblYUApzACdIyMIiqXY6MRwuKQwPJ+Z4XodrP
   toNuUV2oC37vX4KBXalBxDs09p9q/jjIINFxyJtsMmgNFXrVh7p9nNsfl
   H1/W/640m0ClYAplr7I1MxCeWHtAibCAIW+1TCTK8YsB311szLO4C0Q6X
   huvFUUbZB13tHK3bOTNdNxdkjhoxcQXKVuaLV+C7SILkQWIhWo1m/FL/z
   w==;
X-CSE-ConnectionGUID: KZ3jLmqVQpuf/1TtHeGF3Q==
X-CSE-MsgGUID: l7eL1xqAR6KF0ecrmOTeBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="90353009"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="90353009"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:16:52 -0700
X-CSE-ConnectionGUID: 4xjG8e2ASnGJ/eO1lCpYsg==
X-CSE-MsgGUID: aw+rEeJDQb2FqorUaXaCgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261956015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:16:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 22:16:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 22:16:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 22:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6SuK77YRVVTYxCPVnXPrd84Zts0La1LJNZJuS9HTh4ICG8wshco7No+CKQUA6gEnbHKSLe3jKvTuvCVRRhP5x5Seo1sCCe6Qf22GMHPlFyspt45Tf3wlY4e8IoUNEKb69heCjWmC0P955Gy/owRNW2Ypa2aDSXq8gFR+2BTMK4yTwM+HnvdQ5+LlccYJa9MD0eN2xhagvJP6NbpaPyZO8RRxU18OmplaQqFRqP4v2nl9WtxjK0a3mIPfElqkp4BVx1HQPu13W7l/Co66ol8uyoXtBHJN8Eq3X5y1Jtb+hRzzDwiwwpl2OgrobPR7wyrnl+yVVxvG3IXsSvnbCQPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cT7QhaQz0ZEGLaCDQOxGuocSJ9aCkcb5C6azhLtNOE=;
 b=ZlfM8YbyXToryQsnnnRbQnXWfUMoY6DIeAXLHeWsSy03PxYJqzAkaaHE4dYefUQbaiorTipZaXTpqcGSO8e9696HWQFLYHVDEyYJuC0oKCLrhvClfZsHrC8TjUZ3Gi/yxD6cJw6T+YVuN1v3s/vjttU8Jy1Z4RO5J37yxIcjguwNV5V7Q/pvQE6zR3q1PkU7Ed+cfXiM8fNfUTBU7/48ypBxLpH4WXf8jK9sU39W56NC1GbjXYTd8SgUUMLO3icHLp0a9OJqyulDyzMYGTb3qCR8H2EB2Mn3QQQnSTUuhRIhb1+vSCtkjgDHBFYFRwzu0bAMHbGcZQXmYH1jXhuL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 05:16:47 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 05:16:47 +0000
Date: Thu, 20 Aug 2026 22:16:45 -0700
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
Subject: Re: [PATCH v14 08/22] KVM: selftests: Add TDX boot code
Message-ID: <20260821051645.GC3290799@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-8-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-8-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SN7PR11MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 730fe738-52c1-4da2-8d84-08deff4365af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: itkmDPOO/7R513EwCWSyYUG9HGVxGKfSYWvmj2h+ygO3db14ksC5rqZrmp16MWi3RTem+zKl8jQzSh0eQgOFcZ+kehOKBtTXmQGoFfJyLROfOZSHDddy7g/QXKdAZHhuy9GHm83d1hV9lvPeYbZSvpaH3Dl+rUVcdk4MWVJlGjmnB0KRYgmHKrTglm+6ETDSTKsW5PskPv6pGwmmN1trON9xVAyqEgIpIrfVRnMLBmVONNSi2IINjfModug7yy9etHsUgkq38ueDIb8Fps/2xgUK3RgY8patRydcCzhXH1tfJL99WQEfh+6izZYXUW7NyalWgZLWDUj1vD2Mfs+ixfRkIk8Rxtw0myRTWvjBskF3Dvrd2DTvvCpUgQfjuua0jQtc5+UBGTd45IvykVAMfsFN/Fd7nu7jTaLHoS/FzWN3ALoEm2IPyyRsalNgVh+CJ3yxF+iEyLRL0QFZnFk3Iyl+IC9qqPK+/WZCCXjQq7EvkG1Abgb+M+XaqjRkqoZIvyOwItHBhHhR9bIz7LAnIqYSj3Wnm+scFWzun8r9Bq84IXzhGrpGiJDxLPlIXlE/3j+F5D8VEPEjEvfSPmt8gn5dI8/tUe6zTDZYGD4p8RpC4nXo3FgdWBTexNN/bfqGsPV7MPKAWrZDoXCaHaGkEO9VWMxqlfG+/qCrzO0Y+0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?21l3OBT/r7e00CkTU3PbeGBXh4UAKhmX6ZrEDySs+RrQjKKR3dt46MuAUlr5?=
 =?us-ascii?Q?za8f8vAcvYLms0g72Z9XtqRr2VL6AlATXmd80OdEKkVYqvtmdaJ1D4WRfnOh?=
 =?us-ascii?Q?oMl/lLy40BG9Gpz0SkEINADC+YBJjmTEFSR6uB8Fd/DlWX8fb39q0886kesA?=
 =?us-ascii?Q?H8jtGdAXf6oSNtWxw+qCdJh5/SFWl6Ba7aBgnGb0mnIcLi78mwmXUWeBfubO?=
 =?us-ascii?Q?9jfzr1Vtky1ZDOZaA3eJlCdTecvsTsxA47Se2y7L5BE+aFfKRLMLMm51UACw?=
 =?us-ascii?Q?h0iQ/s2MkMcpbPVfIbwrzTIgnEVWwWqgXQTRoV5CUXOpVslacK/QfPKr5qJG?=
 =?us-ascii?Q?33Qlh68zd0KKWfMoptrW58TRurHuT6Tcep5aHIrJr5VB8R4pid2dGcenJlAb?=
 =?us-ascii?Q?v1IxBsU0v1RWj3FFoB5vqSQZpZJa1EH95br/LSw1edwCBIxl8MdKZrhmDckB?=
 =?us-ascii?Q?2uPoRcdVx0PDKKgcbJwwVXiR7oAFoVEQ0jJMQKDRm0MJE33UbBNztfJUUq3+?=
 =?us-ascii?Q?fhVKSpPJToiPIM6iNIqOdFzmKNvPZGLMnZrOcS25mQr5bgEf8gAo2JR5f2p3?=
 =?us-ascii?Q?UtZpNEGQ0XJ422Ux/ST3CB/diSeKQ3bIVm5wsnQzb8BfySMeyN8SwE2gR4NY?=
 =?us-ascii?Q?ybyS9C/nVH/AgGwhcqod9jDOShf+Rd6RqCLpvVh0FhPnt3dyHkZj2Go6Zlv+?=
 =?us-ascii?Q?8OuvIYILk6zxYWkpQYv/W5DGbp6TLUYaJPSmC8gowE/2wUue7mmJgLJ4CZX/?=
 =?us-ascii?Q?pOCPhaERga4oT1CrRb0hVItJdA/COTZGhrHAP1/NrYTEA/xWnPEOy6yraugC?=
 =?us-ascii?Q?tSoJYk8kC0c2pAzqW5uOgbiQaGHhcnUwGNeq1aLLcIvUrnl9MvUpxsGeCWpi?=
 =?us-ascii?Q?Oxe/1d5nD88SBD889NUyyB/dC7h7AGzxpLOjMKEjdUXo2aLHr0Qnz/tYEtyh?=
 =?us-ascii?Q?3VHhTuXGDvg8un6pETb1xCO3Gz2pLcvRExQ9d7a7GubkgAvLoomHCYb54GRb?=
 =?us-ascii?Q?Kh3jWThgEhSQEd70L/HMgjcMt7xvrbZook+lgT/Qwsb2SGh28SfY269lWpEk?=
 =?us-ascii?Q?FM+9+TIgu1GJxgC0/4PaSq/71lZQdThTCRjHfwH3j7f+rajOqV91ukoQ7uKH?=
 =?us-ascii?Q?7+X0LrGrKwRVMlYNMVm/o/q7ks/sf3RObtjOsX9DUprFITx4NMAZaRX2Ee7k?=
 =?us-ascii?Q?VAUhkekPImruQwiWHNPE+yQqRC9loNDzapAVU7Sta08Es11IWsqrTKj36DjF?=
 =?us-ascii?Q?xvpBQAshMRnjZaRnkcesuWPApHF6zz6pDrfXgZrmVTARhFMycwvKeIqD7Z0N?=
 =?us-ascii?Q?tx1zw/v+PgezncYwUvlcGWkFbhj2rgqff+yuJ85fuIJa6FHYiViU8QaV5E9O?=
 =?us-ascii?Q?VROZLBD0+ZRPxp3H+eiiABOHNvID4irQict6J9/Urftl8rO06eXLQgRP2GtG?=
 =?us-ascii?Q?Eae8JKxw0Ul0CYFaaT4Hw/PbjNYypfZvoo745r3OfmMuGURcw+QQaMwW7PmJ?=
 =?us-ascii?Q?HybKvp/KA5kKNGB9DIhAi6Y3HKR8uLYruA/czovhvunQX051e1+yiD2JMPZf?=
 =?us-ascii?Q?XERWzdJy0IuqVH0oNmB3rLZg5+okxByxG3X0wcI85vy88aKBWj1lBAtMmtfi?=
 =?us-ascii?Q?RY7FFLRKf2QCgqMW3Sl6BWcqxtj5KW5EX94Rb9a6qIKCfb643vv2bc7Uonh3?=
 =?us-ascii?Q?ZM5FXGS+rQz8t0prmR8boUPsJdzlGlssW6f134uKrfaRIKSxnRPPBBlYHcZ4?=
 =?us-ascii?Q?tJTTUXKJFw=3D=3D?=
X-Exchange-RoutingPolicyChecked: iiLN4gR1OGjS+JgjIo7RLcceB5sgpj70EyBK93xdn/6xElToaYwpzBbf4KWhlNTV+ZZfTFybru8vBR1T/n8QmuxHdXjUZvjwroDPeiQheBQYuVSdOlSe27byyyZoCO/Ji0TUz8Aw4FEGOLoMmeOAvVQeq847a/3YN3MoTIhuk0zyUnmVw/Vir2LtMnqH5BKpJAQ0t6KwPEHxj/0iCRRzHE9yKWc2AMZm/SYbHFmw7v2Qk+iCQdis/s2sKccje9GWq3Um1u1o+kIXESRBorSZzTEz4xV4+/FGi05svYIGZQMTC8RjCymyhsZRcWz1XPUwFecD8wRlux2RgBX32rqVAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 730fe738-52c1-4da2-8d84-08deff4365af
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:16:47.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkwbUl/2ZnjX+wepd1OQGIO3CPswgQiOu6rlHFwm9oJSpDmltcOelEgHaztr1qclbNBuG2USmuaV1/jbjT7Maw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:13PM +0000, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Add code to boot a TDX test VM. Since TDX registers are inaccessible to
> KVM, the boot code loads the relevant values from memory into the
> registers before jumping to the guest code.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---

[ ... ]

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index bf2282931d49..89cf6c3485be 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -2,9 +2,6 @@
>  #ifndef SELFTEST_TDX_TD_BOOT_H
>  #define SELFTEST_TDX_TD_BOOT_H
>  
> -#include <linux/compiler.h>
> -#include <linux/types.h>
> -
>  /*
>   * Layout for boot section (not to scale)
>   *
> @@ -24,7 +21,19 @@
>   * |                           |
>   * |                           |
>   * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
> + *
> + * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
> + *
> + * + be within the 4GB address space
> + * + provide enough contiguous memory for the struct td_boot_parameters such
> + *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
>   */
> +#define TD_BOOT_PARAMETERS_GPA 0xffff0000
> +
> +#if !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__)

Is the "__ASSEMBLY__" check really needed here? I don't think the
toolchain uses -D__ASSEMBLY__... Also, I think __ASSEMBLY__ is slowly
being removed from the tree [1][2].

[1] https://lore.kernel.org/all/20250310104256.123527-1-thuth@redhat.com/
[2] https://lore.kernel.org/all/20251218182029.166993-1-thuth@redhat.com/

> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
>  
>  /*
>   * The exact memory layout for LGDT or LIDT instructions.
> @@ -63,4 +72,11 @@ struct td_boot_parameters {
>  	struct td_per_vcpu_parameters per_vcpu[];
>  };
>  
> +void td_boot(void);
> +void td_boot_code_end(void);

This looks a bit off to me. td_boot_code_end is just a symbol and not a
function at all. Maybe something like this?

  extern u8 td_boot_code_start[], td_boot_code_end[];


> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
> +#endif /* !defined(__ASSEMBLY__) && !defined(__ASSEMBLER__) */
> +
>  #endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> new file mode 100644
> index 000000000000..bca9a4c3d8f8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "tdx/td_boot.h"
> +#include "tdx/td_boot_offsets.h"
> +#include "processor_asm.h"
> +
> +.code32
> +
> +.globl td_boot
> +td_boot:
> +	/*
> +	 * In this procedure, edi is used as a temporary register.

        Hmm, "mul %esi" clobbers edx as well. Not sure if that needs to
        be called out. Perhaps documenting the registers that need to be
        preserved thoughout this procedure (eax, ebx) is more useful. A
        comment below already mentions that edi is a scratch register.

> +	 * Paging is turned off.
> +	 */
> +	cli
> +
> +	movl $TD_BOOT_PARAMETERS_GPA, %ebx
> +
> +	/*
> +	 * Find the address of struct td_per_vcpu_parameters for this
> +	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
> +	 * struct address into register for indirect addressing.
                               ^^^^^^^^ maybe just say eax?

> +	 */
> +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> +	mul %esi
> +	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
> +	addl %edi, %eax
> +
