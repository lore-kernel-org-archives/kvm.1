Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2C34B661;
	Thu, 12 Mar 2026 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305323; cv=fail; b=oeED4z0N06EsUBs9U/nbd/m28LUm/YPqI9wnyWLhqIfZTygiUF0lpCeDxY1VKYJ1fL/fe9dhMSpljZy0G7uFmT8YsrFBUoQdMGYGT0Q0+OKkjOxpUW/Vhq9Bn9MCYL01i1RytOFGtD9vpSgfcNG7ut/Eyn9xfslOWnuCrNxFvgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305323; c=relaxed/simple;
	bh=jhaev2+LzrramRelVXsnOPoAdYYu+HcMYEp4eQOn5qI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BmbVdOltxMlUQwnUR1GfpzdIwscDkJikGDFHqbQ5GXb25Md6DWww/hn4ZZ8bf4I12KiJ1+YxSzIQQL0uCIDrJ/eT15fdT4RoDa5V/+1LfoQaQOVqei9Ot+FtnjbuJTtUr2C+tSKUR1pPzbQxF6wRFA9Zg2VwGlMpRtJJOkBdCQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX6Qukyp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX6Qukyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773305322; x=1804841322;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jhaev2+LzrramRelVXsnOPoAdYYu+HcMYEp4eQOn5qI=;
  b=hX6QukypZCQqkaFGxt0krKoHJk523xXw5nqPhUxtQte1p31i8rWPefh/
   S3w7dybRX1aIH//qI8bmlY0kBmUwPBuUOem+7ZD7AiM7zqKD6PMj47u00
   /l/E6JVXe4LlvxkXFZaAaG+17YBaDip7sm3lzZ7xkW0p6rUoaKHAGFzDd
   RlvJ0NsjqBpmfWc+ezP1QfD8Afs7TTs952MWfqK8NRUOPctwEwAcERRm7
   ChW1OZjBfyXmuzNF/heh37HXjwsmYANh7XoV2Kfs/pBk2yFMky8ZCuaXP
   /hrQgA2HPZiaoSfWz+Oqgv0eWXss72Xg67m1dTDIF6ya40Dkr8LAuFcjB
   Q==;
X-CSE-ConnectionGUID: YA5XuG8RQfaS6uKimW5Y6w==
X-CSE-MsgGUID: GcSpz0TeR5ylsGkVPhH5AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85475927"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85475927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:48:41 -0700
X-CSE-ConnectionGUID: lhdRrekfS521nUPF853u8Q==
X-CSE-MsgGUID: n3smzeZtRqW8kzUX0MCISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220018231"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:48:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 01:48:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 01:48:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 01:48:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w42GlqFovj1vWMIhc7hNLB9Hx+oB3ySiL2vlSymDVgt0p6TzjD9JyCPjGvpv83LFf0QKKjLCzmB/hb8fLVArBsAYwP7uQjbsjhxFB7BzzLSVipuSClApWiT3icH1XFbJeDW3cIR1an2I0t7XG4JvLHIPWXm+C+g4rf/I9jYNXE2w5Vx023usKMBKU3vQ6Vb60hnJYb73RtcnnEt4lUXs1HmtW4x65Aiu7cmk2PmwGFqm1F7W8C9Ez5dg19OH4S6iWbYgSWPhHLrCSPxCx2WIHRqWAx/5YaPrIZPzFUHfjQ9Rw/IjnWWBCF3lEKra2CpbKAcg1MWeGKpwPvsn+nDRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PN+Klofcv5a79FNapcGp7UjW1ewa1yqLoLazgpY/y8=;
 b=u7QfX2u0OLJnZakV53a5HzUVN5JRqtafBh5Ekc/24DRas3VCY+U0WqYGPx4fUBRpVOzC3l0vi6y+z/sYuHcrQB4c0tn5YjAOIuo5r9Sif3s/7VAwlCAngT+c1GniSc5zHS+9w3McYNLEV4sAQ+J3UPrbE7v7ih6raTWBsrQaVYLi9VfOjSM86/Y5LzMqc0EP1Q05xNkFbLWbrt7G9j7TeaYJoC7rwLGedyOTymjwxK5pkbslfXjrGiCgiVl7k7t+w/qZ/hKg/HXROxEJYikOBnkG5eljVJbAsiyLt9Pe8QJo5373GmE7NjBxe/JPsRBy8iWM12jI6beHFoszyc5oHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB6558.namprd11.prod.outlook.com (2603:10b6:806:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:48:31 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 08:48:31 +0000
Date: Thu, 12 Mar 2026 16:48:16 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"sagis@google.com" <sagis@google.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Message-ID: <abJ90EMUnEAy763n@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-25-chao.gao@intel.com>
 <abFlCkNd7tqaUyAP@intel.com>
 <d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 212f5a47-6b77-40fb-688e-08de801422ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: epzxH3OEGGQ9oYnv/WatkxVDdjAd4ADTkO+rA3mkQYd2WmJwlW0Xx4aoL3+2AYBM9Kw8JYwGbylg5rxdE5dgAmbZ5VC788A3KcLWcLinoWxxxzMydewRGANqi5QXN5/irqHNwxgGtnODhd35q17AyDVXx03uG5DpQkFD9QQuOsUJ6VerYebtJ5GYiklGPIpG02KlYYgkS09GR6tngu64c4r8oU7mP129ufmRV3SNQ+AlNsoGgxCX69Wmqcmg+f9DvkCBnlCCLyuBQeI1D9+99Ze8scJImjRxhO5KF/Lhwp4oI0Vb+/Ht1886eRSuiVKib+jrpBJjK/W/+d4ETxPNKPJANZWgBsyfdF/mJf9K6Gg4fPu176k6vANvWB6xAfiwDfDX7vI40ZIHG1HuUTQQTepsPv32CawrMkOnvfyHxG3f+QOwq5hS1YXeSVcR/kLdQfdiPxUq+tcfpe5bq18O4sJ8r8TwV7R+ZGlzRBd92hXkPcEIFaw82MuwzVkl4DVjZkMJA0FysYD++PR1wZWoaJwJBVwykscz5kHwm6D901YFK4oKUBpGXzcUnhdz+JRAwDlz9++dYrceXBWnE9fXamvBNFVwT8FughtT67jETLFtMsFw+13R68rmaM4XkXeaoeZueeqEsGO5bXiCi8GQx++d1x+lJlmNFrRteVafdSzIV7l2rGSsvIR/yzRVfOcwUdNxP/gRsl4u5ViEfRAGJ3G66FyqE6qg6ST+Vsn7XUnjeuobj0BwLi4j7WCPEkj+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QFPRvEJnkyX/0aTJsclUButcj/K+u8Rtkb0VS2J8Inh0W+0e07Mlhuk++h?=
 =?iso-8859-1?Q?+TFqhTs1Ftz08gol1EzsccGqQ8+YYKw3RsXCtXRrE9UUEY6l/BoJPTWFDw?=
 =?iso-8859-1?Q?XKLwV0SiFvryqn4NEhSEDT5N0aqsB+6MRnWcFrUo+KgjNLhRh87vxj1iL1?=
 =?iso-8859-1?Q?0wJtQcvq8RWeN9nzgKgDZvqEkSupeWrgW+YTnx4NgCAKzfZRKV8CPiLEmK?=
 =?iso-8859-1?Q?ucElumt64Ghcm7H0UCVJj4TC0NF7hg1BqRKZMp9pGFBJSjq4TCn7pQeGAu?=
 =?iso-8859-1?Q?TyT5opV2YDUMW/MDIdzQBdGr/YuCz4sK3QEF8u35+e3+RHwX6GXsyIFeDM?=
 =?iso-8859-1?Q?RZzjoEj2DOyXMGU8qQmAiczxI4VFYIVRzJ5qm8CSq/RPPRCI1Vt4x79M1I?=
 =?iso-8859-1?Q?+zf5J9b6Ix0ubV11klRjl00gIFo+qWICn3lXwEzXUS9KfNy508TYQK5Ze6?=
 =?iso-8859-1?Q?wJhPY5uYDPvIhyFTCO+ZM4BLjyo0W3x9MF4mxoY7UlvKcPhtShbxV+jlss?=
 =?iso-8859-1?Q?rAf94YyP3drKggqMvUWtRCR0R8V3a1DdrX2Z515qrlpL3JNkO2TZr+c6SM?=
 =?iso-8859-1?Q?7hhbi3zgSVTCJpeCsuA7gOAhaa6whjLyEle9uRyhuI+ANyc+GdP54yYx/O?=
 =?iso-8859-1?Q?IJOIEc6tbivlhpWD0x3MIPNo7E9hSSZ/EoVFKTUxlra9K8GwbIMqnyMWDY?=
 =?iso-8859-1?Q?V5QwxtisoJ1k2pKm2ZS0+pLrQh/2ki+2pTyimokD5LI+hQA8oJe5IQ8EEF?=
 =?iso-8859-1?Q?PcPL4+L9QKW1KK1T7n14o9hjTL7Obc1gyxfuxHIJ5smYe7eNJtbYn/ZJKd?=
 =?iso-8859-1?Q?r4+m3DEAZ8BhL0XQqTvLRqS2m/d0LZ/reQANzzEadywxx+hEHnxVNCdWti?=
 =?iso-8859-1?Q?JF8gswEs3/yObZqVeKB6pRK84YUPdZGV2uu76pZNQCe24VpggltNcgap3C?=
 =?iso-8859-1?Q?L609/yWTeXA+LGKzXV/z4pxLhml6V8lYBcw2xBgVcLknKFxE7Cr/XzAq5R?=
 =?iso-8859-1?Q?oOJtA1vBr7/07OzRpMcw7z6ZWHV9eqOnsgj/LWWC7f70fkp4gJ2r+suYXH?=
 =?iso-8859-1?Q?USxyypa0VVv7aUZk6wjG6bz0E+PMcPMwvIbMjE3ZvSZkT0JHVtZa+2J/U/?=
 =?iso-8859-1?Q?ZqlnChehXqV3vLQAeySavNMGMoPsS4bbc3f8l4BcOJmsR/MJIve/mN7RC7?=
 =?iso-8859-1?Q?cefwwD50Ojl1ndrZOeJMdMcTbM3+SsFZGFisREmwsOBwSbGg0ZzsQDREGM?=
 =?iso-8859-1?Q?/3F2wNesXp9pmwkjXzxThRDZT+hmm1GxZwUIj+R6zu7oRAvy5fIDw5Cm1W?=
 =?iso-8859-1?Q?6pPoCmzGIcEHdyV7UjNFNveeKPK1O1BtYKCG5495Gb1jSlgMufWKim9o6x?=
 =?iso-8859-1?Q?MjStRcDwW1EFUT2mDvUvv0fLWQd6NHYkF9XdEMZnrb3/4AERr8M9usJBNF?=
 =?iso-8859-1?Q?gB9gPEjISuohpEr5+ZPEXY68G0E57wWK5Fbwhw6LtpfVSU0uUgOKTv7QP7?=
 =?iso-8859-1?Q?j0jhsVJDx1WVBiarLWF/BzV0gxVLMp2IGKFGkUou2eih0tEaEnPa30uRqq?=
 =?iso-8859-1?Q?dYNrFw2/d25vI5ugDzfUD4q/IXRM0GZpJ8FTGwwuVry2gjkrd7drdSpElO?=
 =?iso-8859-1?Q?fZT3XaAg1hL7xdImXotU3nBirBjgVRsPb2vvtokKMENlK8S3V+dyv8efK5?=
 =?iso-8859-1?Q?yx8wkxgRZpLsSwnat+VVnvgq2EL2CALUZ7hw2wgl6FyyCrzqdaQgtEDMdl?=
 =?iso-8859-1?Q?RuWOJ7fZ236Qd3GGjr95lboyRyYify34VccegHaEg6te3CniW8RIDODO2m?=
 =?iso-8859-1?Q?LZ3iMWjqKg=3D=3D?=
X-Exchange-RoutingPolicyChecked: gmTd/Ajswy7mKb3L1xIia6PofHHTiWJ2tvBwi3YR/BPJmm0O0SGsOGaUZd+LFGzCd8dZTVb0JeC6u8jUUn4bvqOGCY/CAUny3rZSU6P0O38TDmCexCuHBEn9Jh4DiJwiNAxCvv2Om8rk1V5V4ncKUTKsFvQaOLXarAdVQdSDkx98BWaDUlTXlJ9fSIDM8zFmrIVYi++1ykzu37a1KT0oCnls5bPKZN3xsUxF6mv5sm5PvrH9jP9FdeCuoUkOBoAb+TG+/YE4kJWwF7srMbjPeqn8xjV/jFGhYWrpXex0tm9P6SEsjfYb1JzLZoSzJexce9RQyuslXyI2klqq6yUzKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 212f5a47-6b77-40fb-688e-08de801422ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:48:31.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z17lAz+HRLQyNdet/HHNKKxrNOxocoSiMpR4FiQR+k5BlJVpuv7TLeI7luhf0Rm1jqsZNMzVFUax6zj89LNbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6558
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 06:06:22AM +0800, Huang, Kai wrote:
>
>>  static const struct x86_cpu_id tdx_host_ids[] = {
>> 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
>> @@ -175,6 +177,7 @@ static int seamldr_init(struct device *dev)
>>  {
>> 	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
>> 	struct fw_upload *tdx_fwl;
>> +	u64 basic_msr;
>>  
>> 	if (WARN_ON_ONCE(!tdx_sysinfo))
>> 		return -EIO;
>> @@ -182,6 +185,15 @@ static int seamldr_init(struct device *dev)
>> 	if (!tdx_supports_runtime_update(tdx_sysinfo))
>> 		return 0;
>>  
>> +	/*
>> +	 * Some TDX-capable CPUs have an erratum where the current VMCS may
>> +	 * be cleared after calling into P-SEAMLDR. Ensure no such erratum
>> +	 * exists before exposing any P-SEAMLDR functions.
>> +	 */
>> +	rdmsrq(MSR_IA32_VMX_BASIC, basic_msr);
>> +	if (!(basic_msr & VMX_BASIC_PRESERVE_CURRENT_VMCS))
>> +		return 0;
>> +
>
>IIUC this silently disables runtime update and user won't be able to have
>any clue to tell what went wrong (while the user can see the module supports
>this feature and apparently the kernel should support it)?

I'll add some logging.

>
>Since we already have a X86_BUG_TDX_PW_MCE which is detected during kernel
>boot in tdx_init(), shouldn't we just follow so that the user can at least
>see the CPU has this erratum?
>
>Another advantage is, if in the future some other kernel code needs to know
>this erratum, it can just consult this flag.

Thanks!

I didn't do that because I wasn't sure if adding a bug bit was justified
without another use case (i.e., this is a one-off check).

But I agree that following the X86_BUG_TDX_PW_MCE is better in consistency
and extensibility. So, here is the refined patch:


From 46e89a50803d6568eb60bd8ec866ac3fd9f6e6da Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Tue, 10 Mar 2026 18:49:41 -0700
Subject: [PATCH] coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with
 erratum
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:

  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
  instruction.

Clearing the current VMCS behind KVM's back will break KVM.

This erratum is not present when IA32_VMX_BASIC[60] is set. Add a CPU
bug bit for this erratum and refuse to expose P-SEAMLDR features (e.g.,
TDX module updates) on affected CPUs. Also, emit a message to clarify
why P-SEAMLDR features are disabled for affected CPUs.

== Alternatives ==
Two workarounds were considered but both were rejected:

1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ugly
   assembly code [1] and doesn't play well with #MCE or #NMI if they
   need to use the current VMCS.

2. Move KVM's VMCS tracking logic to the TDX core code, which would break
   the boundary between KVM and the TDX core code [2].

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]
---
 arch/x86/include/asm/cpufeatures.h    |  1 +
 arch/x86/include/asm/vmx.h            |  1 +
 arch/x86/virt/vmx/tdx/tdx.c           | 12 ++++++++++++
 drivers/virt/coco/tdx-host/tdx-host.c |  5 +++++
 4 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c3b53beb1300..dab518122946 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -570,4 +570,5 @@
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
+#define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET may clear the current VMCS */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index c85c50019523..a467b681e62d 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -135,6 +135,7 @@
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 #define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
+#define VMX_BASIC_NO_SEAMRET_INVD_VMCS		BIT_ULL(60)
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2caedc985fbd..06c8f957a6db 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -39,6 +39,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
+#include <asm/vmx.h>
 
 #include "seamcall_internal.h"
 #include "tdx.h"
@@ -1453,6 +1454,8 @@ static struct notifier_block tdx_memory_nb = {
 
 static void __init check_tdx_erratum(void)
 {
+	u64 basic_msr;
+
	/*
	 * These CPUs have an erratum.  A partial write from non-TD
	 * software (e.g. via MOVNTI variants or UC/WC mapping) to TDX
@@ -1464,6 +1467,15 @@ static void __init check_tdx_erratum(void)
	case INTEL_EMERALDRAPIDS_X:
		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
	}
+
+	/*
+	 * Some TDX-capable CPUs have an erratum where the current VMCS may
+	 * be cleared after calling into P-SEAMLDR. Ensure no such erratum
+	 * exists before exposing any P-SEAMLDR functions.
+	 */
+	rdmsrq(MSR_IA32_VMX_BASIC, basic_msr);
+	if (!(basic_msr & VMX_BASIC_NO_SEAMRET_INVD_VMCS))
+		setup_force_cpu_bug(X86_BUG_SEAMRET_INVD_VMCS);
 }
 
 void __init tdx_init(void)
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 891cc6a083e0..7e9496e215f6 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -182,6 +182,11 @@ static int seamldr_init(struct device *dev)
	if (!tdx_supports_runtime_update(tdx_sysinfo))
		return 0;
 
+	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS)) {
+		pr_info("Cannot talk with P-SEAMLDR due to seamret_invd_vmcs bug\n");
+		return 0;
+	}
+
	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
					   &tdx_fw_ops, NULL);
	if (IS_ERR(tdx_fwl))
-- 
2.47.3


>
>And btw,
>
>Which code base was this patch generated?  If I read correctly, in this
>series seamldr_init() is a void function but doesn't return anything.

This patch is based on a new version. Yilun suggested changing seamldr_init()
to return an error:

https://lore.kernel.org/kvm/aaEP8CbLCc69U45Z@yilunxu-OptiPlex-7050/

