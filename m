Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764D3E7BB6;
	Mon, 18 May 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103173; cv=fail; b=VXUKIgonl9U8WJsvJyLxSIsXtwGB4s3TsxujjwZvoTjvlAp+PorbdgtWta0r81TgbrNqBgkhHUThnYNaHHAql7O2i3IWg1xtoTIv9qPV93A5td/ahTKeuNvDwMMv1Rp5OkwFjwzjGqsNsUFxdd8b0qoG9fmLRjZFBK4LuTMXEBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103173; c=relaxed/simple;
	bh=f2rvtevQ6OzBhv+K5YwmK3FZtSFn6oeBQ1bUJdYf6Fg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S/WjbGK2cNDc3EyCojbVlqUGwT1aJuTk8eBgpOlR6Hsttx2j0EBEtDV/xMigeN/jM1noSpVdv1yD+ASIKc9OQxhD/fyhV5gzizG1xryM6zhRREvhGHL3g7/QOFkVqwgGynSBlCiNDTe/6QHJrhMLuhxEuwC+0u46T7YN5kvhzYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k14S0pek; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k14S0pek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779103162; x=1810639162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f2rvtevQ6OzBhv+K5YwmK3FZtSFn6oeBQ1bUJdYf6Fg=;
  b=k14S0pekqlFFEwxo3MWIiH6mF7u5XHWGOcOY6WEDNC7jzfvYKGIwURR4
   S8ogwPujveMLtC6aspacjyI5S8mgp1r29YuP8eNawF3sjve31+ZERCRZj
   pnxaKNnmPfsdRNoBql7WL6mlqGbUR8NPspkElRS6F5eVmd5eH5Wo3NXRr
   zmslVkaIlp0S21I8zZ+/I75aZJwXPMwgI4upCgNBlYFc571aLwvlIQxvU
   pRG4CHViXqPMy6eSQKv5+nQFzd/SdCN5ZDaYO2UsLEPAEgnTT2wzdGEVj
   CjNc8n77AZg+sPqkL8gFYJbD4H01biX5z/1C79ZLZkTgV7IKxDoNJn+Lp
   g==;
X-CSE-ConnectionGUID: BeSwbgBITuOENjZPCKyjOA==
X-CSE-MsgGUID: 94GUN5slTrO6VRfMl4q72A==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="83805081"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="83805081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:19:18 -0700
X-CSE-ConnectionGUID: CB2s67E3T1+ObinGFThJHA==
X-CSE-MsgGUID: MCr+5FIhTcSRnQIiBxMvbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239654362"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:19:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:19:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 04:19:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4DMthgVmFCopS7GJ3Fwy06SdEjX9JrhEWwWweB2itq+oyWyjXchBQPpsSDULr/pmUPiX8Zvt2KTKzqtjM3kDqovVwh6JwXLCtcQmTIYJ6tw79yqPtL3ReJ6b8+Nr+V38DQxU4+h4p70qnQAhEJ5YTAwhar3cD87XG643wEyn9xwUkhKOWQC3gay4QYzIcHVIorCJa8Ua+7Ia9V01PkKYllt+TY/1IwWG4r0ukQOyKuoohv7YsG10pJD7HW3sHvMFh64VRdffJNsfDjYyjcLVX5JPBJMEa9v/O0T4i73dxstyY2YrYtfIl/JA1CMc/wonK4GQ2wTiL1BGq5YdXVpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7aRck3RG1sOdkuTyiyqZ6VGBjEPmVWnSnFidgBk770=;
 b=HhsSlk1lgE7cs8cUDACJ72EsVvaY8nppyRqsVYOMNoJO+BI8DVABt57J3pHOKnUWaPX0vySlbentxo3ODPb/u+gPAxmIr7aPhMZk1K9qq4bA0EMK/0hiLFYxf1PRrWzZRFhCeUocHUWC9/JT5reE8yV+8ylE+Vsnv23gvRsUJFcz7lIFFVcvBQlFpWuZTOZIo02RYZqKPUNwskOu8h5I8VjAo0u2aundbCY31maNOoG1lkXyA1K3zdMm0dzo7ZeOLlLPFD2F3aHUhlGX70AW99YAHOI7P6I66dttBv22m9CtOBkvrmwh9+2vmye/Sm5CJzAgC/T870ubWkqKw2AHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 11:19:14 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 11:19:14 +0000
Date: Mon, 18 May 2026 19:18:56 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 04/23] coco/tdx-host: Introduce a "tdx_host" device
Message-ID: <agr1oB+IZNCxPuLL@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-5-chao.gao@intel.com>
 <cc35a467-e978-4e3b-a6ba-17a8bde69bd7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc35a467-e978-4e3b-a6ba-17a8bde69bd7@intel.com>
X-ClientProxiedBy: KL1PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::34) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 494a9128-2929-4c1b-6719-08deb4cf4ad7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: O7zXXNudXR5ddaBLETEs6OVadyir7IqmZx4++z/B2X2nHwAlfY4twjVEokuKR1lq32LA5SjFmBODXeaEFnfmkKaC8LmCacDSa5lSuKXwIMg0kuEXzPyjuZzW7r9BrvjwuD+KJbbviRJK195a+CiLwGst+OrOxzHJQ1DD+wIMBStNttIAPmyJ3Fw8KWlWeRSVNha2CehGNbzexZ9FgZvON8WhoEQOhNv58BG8/Ld8uhPKMgxcjVPVObHBTAkgbQHCmCacMDGdfpLQGad7JuLG+0XZvqXj8vTF48uxqqBulgOIPMicz2CT15cbyyPQxW8Smb+slRDVDrgfA4OEcEhZtYz6NC/0yOCdpVX2riEHq4ewziW6AouP6uQ4CHWyM0BkyrdJynRnYdr1zZlcxsoSMNtFL/MBZYy7MBljUWShYWBgDMwnXYAugVtsqIy3jatt5pTY23zNbwfdxGLaGmctp+0H4L+TMIW/aBLzEuQDEfHZ3YD4kUbDGhghWqPc7m5d0D6nEPLRysdHTiUiX1F1kPrsTj9VbWNgLE3XC0T0vYhEBmaWwbsHW7yDgQ1SaMTTvC5FPELi9YN+md/btEKE/iSY0AHNJ2Hf0qJmXBMiUDaGdUEryNxNRmejfWD3hifODPuH5XB+nJpKBIB5REgPShccGjYGyUXOT9RTqa2hxmq0Zkt3ieSoahZb28zD5zmdszNY1Q3cmzYJ4ruiKHsabw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9za8LDUwMMU1Pkilsy9iXUQByml63+rXCWudITAMOJlergj9yQ3uefF57Kc?=
 =?us-ascii?Q?EeyB+bDobxPQa2Lk/XRgh2T75cMB35HK0AUvZr/hlYSt+kofAfptJOqbxSzu?=
 =?us-ascii?Q?q9FSVFzcalYoYO01gy/TEW5x0ZD74yggD+wWYjp8SEMCJpFg4mV12zXPkFN/?=
 =?us-ascii?Q?Ms8xzMtdWZj4FmMMn9tE1SiAApHyIkLJ7rde/4hefTD3uGvBil1cLHwH/95m?=
 =?us-ascii?Q?yVkwz66Vz2HKAyLZp7q7sDHo4wWeq55wTpRkwFU+YwXuxoZh0c1tNV/5l4en?=
 =?us-ascii?Q?9Fg4yW6N1nWkrYdiDxyLQOwgWUKE0rKx9T6VIiYKw47MHVFLQy0gjIH/6yAb?=
 =?us-ascii?Q?COud2JuGQlr+xH6fiOBWwNCWv2ZJb4pfZeFEJ+4jQ3yDtkWcAop46rS3NkQT?=
 =?us-ascii?Q?GdnfxEIE3ERDE2Ts/J7nF/obnlD+SPI/MxkzbzRbG/ooITjWKML9QT54m1Dd?=
 =?us-ascii?Q?pti4ZZh+2tbWkddp77NI4bdGdibVtHH/zJp26wFelhcTu1drtnBHlQIlDbQW?=
 =?us-ascii?Q?fCe+3VRMTVs5W651N+ziK0Y9ZXs5DFRWB2mWHLf7g8T6ASyfI+5WjoqyyuYn?=
 =?us-ascii?Q?TVsEiVLg8lU8TDOeG6FtU64+/Twru5PtQc6aKHwLB6rCE0OvDtiMd1KFz3ru?=
 =?us-ascii?Q?5UQWcS9sldBfCTnlyQ2VUmGBMj5otb0lsfeAB+dh5sPYNzYVFfQJ3l05zud1?=
 =?us-ascii?Q?aiWP1ONBpmod7SHXZWkaoZDfUKJtJOETQoQplALqYW37A7AhhpJrltAxwUYf?=
 =?us-ascii?Q?7WBAWx3Uuy9c1jACypxPyq9kJb50s8ZT0k5I5JyfAINnpJJkmYwbWN/qmakq?=
 =?us-ascii?Q?n7t530nm7sN81Pl+3yYU1Jx8fw2XGZ1/WqhKLKnHXtYK8YvRTBQwASFcmIZm?=
 =?us-ascii?Q?OVQ5ZW2H+ub30Q/YkZNAHfiz1qPNpidbH0JcjBn7StuwBe+5Fnoi3Ux82VgF?=
 =?us-ascii?Q?57/QsyrnnKX6nhnpgueTgj/xWTi8p68MfE6qXtfySXmar0KlNIxUctzo6AGx?=
 =?us-ascii?Q?3sOcQy90r7PRxYIvfya1DL9l5Cn87x2nTRPuLd0+oqbG/VGx5r0W19Ip4laK?=
 =?us-ascii?Q?xf3Gd6IYKs+BPI51bRyXq6yyoOviauP9nAQCHhvJm6fEIY9XbY7kgpJf3McP?=
 =?us-ascii?Q?4OSLsPKRUfbtcByvVEbiTvGOVLXwCUaRUe2CJrt1zPixPLYjZSdyHT94a2Gf?=
 =?us-ascii?Q?qwuzqBjOJEMHYk+DKwpsxhAgPhwKvEiGQ36P8IG9yPErtcRTQlZNMoeGQ0yZ?=
 =?us-ascii?Q?mkB/lNktc3U6hdudXJkNy0A7z+43xKzd9SiXljbGQiqHUGYcNPWhJqUcg7Ak?=
 =?us-ascii?Q?NJnrzmoOihBt1ssYM7JfAjZmu14s8LVBiNBE1aDCsoWPHuvUFfgEcGoQcAC+?=
 =?us-ascii?Q?09mh5wP0E5IiJzOYzHLZQfX+eN+ZYTN1EVas3BUG4/hXhADe1W8QLesECxav?=
 =?us-ascii?Q?/tYBAW2YRh0x8qblulKFBHSsfytnneYURbi6+8gbKw8CEKwzvmpWbwJUbKyu?=
 =?us-ascii?Q?RFGUDl7MnKIIjg5nJ+X4VcW1CGmo2qTLLniYiK46AQ7Qpt+U6fLcpAGyB8zL?=
 =?us-ascii?Q?nb77UdWgyoPI31CwAkeObPUjFeZDsclLYvmoKziMcF8Tfzul1xmJNnTl5KeT?=
 =?us-ascii?Q?eOF9v1JymMI5InlvHP5bcm6zb070qxrGJEqltuzfUN21Ba6OjGUiEhcgh7m/?=
 =?us-ascii?Q?bYoJVImWPFLYJpA4oT9UxS11hbrSBS0MxP0+NpcXFr8mmAnUp0DCmBYfZkJ+?=
 =?us-ascii?Q?tolyYJR6hw=3D=3D?=
X-Exchange-RoutingPolicyChecked: J/D1r5M6EMA4m9ToZa18FlKhb+ZQvksBH7bfUUKnsSnbhvlGbTd12fwGK6ni3qnB1D2w0gn2LvacVqWjLOhltGTv/5OkJO/o3ytbFMxRQfdPgfh6j4tf1gZYKZr+4UDOC9Eyb7v4T4VJ4rOcWCNx0m2C92OrtTzs7nY+JaDSaidwbVYFms39R8TOmPlXFbphZwbGYWl8vyBhJvs1/BWAt0yJ/zYRLmbZ53D53LuQ95xxlnaychUvdhecGAVc90Pv9nY7Dc99MNlYtn4GK6fIy+7wutgY0q5fOByLJ6yFSXhxVWZJh2NGyWtak5luKmHuxnSloD8Aqcqy8bELrAHyVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 494a9128-2929-4c1b-6719-08deb4cf4ad7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:19:14.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1/KMVWJRTuNlZPJ+IbAplymW5ncKRjlFCEQlM/Q6rx+qkUPsbG0BRPLYW805NQhOKnb6HXQLgEd5nEhibYtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 09:21:36AM -0700, Dave Hansen wrote:
>On 5/13/26 08:09, Chao Gao wrote:
>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>
>This SoB chain at _least_ needs a note. It looks quite bizarre.

I will add a note.

This patch was originally written by me and then substantially revised
by Yilun, hence his Co-developed-by and Signed-off-by.

Then Dan made additional cleanups on top of Yilun's version and was the first
to post it at:

https://lore.kernel.org/all/20250919142237.418648-2-dan.j.williams@intel.com/

The current version is based on that posted patch, which is why the SoB
chain is unusual.

>
>> +config TDX_HOST_SERVICES
>> +	tristate "TDX Host Services Driver"
>> +	depends on INTEL_TDX_HOST
>> +	default m
>> +	help
>> +	  Enable access to TDX host services like module update and
>> +	  extensions (e.g. TDX Connect).
>> +
>> +	  Say y or m if enabling support for confidential virtual machine
>> +	  support (CONFIG_INTEL_TDX_HOST). The module is called tdx_host.ko.
>
>In what world will anyone ever set INTEL_TDX_HOST=y, but turn this off?

No, I do not think disabling TDX_HOST_SERVICES while INTEL_TDX_HOST=y makes
sense.

>Is this even worth a Kconfig prompt?
>
>I guess we need it for the module or built in choice. But otherwise it
>seems a bit silly.

Yes. it is for the module vs built-in choice.
