Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA6496D47;
	Thu,  1 Oct 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859745; cv=fail; b=IZfGQnSDqcN+mBzoEFH9t9mTFD18HSnXk55Ec6dEyfzRw1zOPrRrolFwzVVvZXHhIi2BLrNvhzpxPsu8FYmZWovyBJjyFLj1kxa+jcpV7ipqaZL4LjvZsDLludLozi5Mibf8253+Z2+RAzn0jS2+DvaTnMYhJOSXBsymgx0upjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859745; c=relaxed/simple;
	bh=L2kAaGMPU8jWgVl8lDwJScUynRQpygdABZiIie74GPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amr798NBksiZ6KGNw+rdy6hvIwsjZM7E6uM+YN6Afew1wJkF3/2+fI3gtY9B+QyyIwLkysxzGRBQ2l/oiSMsXSbgOtnavAr869kBMBUhPMl6+cB/z+v688idl0QQqAtsdBN6OUSfLDTSvU6xaM+mG7AFmy7T6PKFqNGOnELMTx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjewSbwi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjewSbwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790859743; x=1822395743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L2kAaGMPU8jWgVl8lDwJScUynRQpygdABZiIie74GPU=;
  b=EjewSbwiyprbH+rTLv6OcdwcWpWNsOXWb+g/07LJU0D7Q1HZ6QPCMXNg
   JWz+Srhu7kSFl9gQIy64qzbThUE1H0PIqJ034bJx3w01jlp65KxC15oaN
   /JhBwrPTZo7FaaNpyX7jXd5MjuN1oUtp2C1e5C5rRX/0SKYwRoTyFSUnL
   i0lEkr/LDnPq7/Hzh14ALzMeJZOS/nMygTnQXdp+EGijDN4QOPs4C2vqc
   JkEehQLTWCmH69pcExJ/1/jgXr1J1fT0o+eFZdBTGq/Uh/AFr1oEG1zU2
   B1g+0FgIg66zeuwmvI6+fcd48nQSJ4TZFVwCfdi0QDB7zQPsr9bzt/IMk
   w==;
X-CSE-ConnectionGUID: 5GCOvDeATxqd0kRaKvC9Eg==
X-CSE-MsgGUID: ADa9oom9R0anOxz+ysIQYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102989321"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="102989321"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:02:21 -0700
X-CSE-ConnectionGUID: +znvmi8hSeKBw0DIPZY/jg==
X-CSE-MsgGUID: AIBMw/MHQ7q1ioD2Ez8hsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="275192456"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:02:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 06:02:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 06:02:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 06:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqmAmSWm1qGJ6X0Bkglte5c2gDGNjOp4cCNgjFhNphzaaJ33bJIZfTik/J0ExqvL1KkT+poaxl9IIRmmveFETp3H4OLFFhA2pkTjNINn8XzW2zMzVqIYuPkYzls1F5EYZUdMSqdKIwyzZSAcUHE8fLEAypJJkycbX43REQNcrjgrVqoiw6I2bSMNYmRHvHsfQ169PK7mOBV74xIRIFVSBHvCELiOpLl7KLnTsSXgP62vAdGeA3pZPxp0Zp76L8Vhers9ZMM5MFSl2SZf7pjUE2UAHBQFJyfx87Tvmnqm2wS53eVCrA3N9upqyjNKUaZKISemyofl97wUbJ9TdsFGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwvMgt4AZj0URDAXGb6hjZ16xhOtnnZDX4SZZWIJEm4=;
 b=ICw6Ts+DoFllm9UDlr8CSOFg7I2Q69OgAGQaJtatDMhirp0r9xLyYFDlRMIOE/Krg+vUIQanYfZfuD08RQdGWskmLfOwLO+wHnwGfBzOB2fA41bNgF89OPBVzLgQ+iKutwi/nx0OeSLHhHXMW2KTO98CLDyrtjUCv9cpbWUSd3f2UsUtwkQyx4BRrsXvU6IAbifQCgmTOwZ4tWo3it4eZnowJEBR4rNJi2oFbpx+KexnqhDuYB1Bow35yI6xmap8waj7+oGGtqmxdUG8JWCrPCRLNjkAXs8k8JUuw3d9GkDgorSPZ3zIGu2VW2PXB6T2HJEaMm5q8cHbbDo/dBV+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 13:02:16 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 13:02:15 +0000
Date: Thu, 1 Oct 2026 21:01:56 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Message-ID: <ar5ZxM6Hvgkh-DCS@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-11-chao.gao@intel.com>
 <a96b1ed40648cf049ef374bc57c314e29ee133f6.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a96b1ed40648cf049ef374bc57c314e29ee133f6.camel@intel.com>
X-ClientProxiedBy: TY4PR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:378::11) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ0PR11MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 41583ef1-d680-4c40-fc3e-08df1fbc37a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|5023799004|56012099006|11063799006|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e0QVPeWoLavN8jp/GceIQU7v4FvuSsFBUNKL6LRAR1Y/FnC5ao0milaI2JYOgLbOi+8OqjwJ16lsDqLAqL/UbEKQvLUAEGdGWyV2PEBUb34W23ZMMvOTfhE196hI2p2gqsdbQP198SCzJKTqZ0BaQzWB6s6tF0rs7BkJm3fbK5JEJ5PBUoqzVWr09PC+2Y3SWjHTLxAA/r4Or733y5CAvS+tCpho0JWm9Arn1cC0ikEQm/NIaSqW8uX6UrCT8h98qOnvOILjDPEjpvX7TCm2UXB3rSQnj6LmIEcFWcBLGlPn7MDrLzW9wHpLzJGAHCaBB3CzGVfSLHUiWa0+bcW0zZZxgbIBO87e2/dn5lS2Ff6NECJ7Jb9CknQyhN8GXDUE0Q7+E/sd5CBj1ylRFNNa+v/2MJ3ka2LQMqWsm7ULjpj5wiYOcvcwalxkHxn4Mw/y3KE2Q+wiAbY8ma7hGnS62RdC1hVVtVb1kABx/z4fnwCOUSO9IQQfJjFsJyiCbS1N/Nvfhk3IyRib3XyBweTELGknlTvJEAnLFSY/Pk/QEW/cT3BjdbTHNp4LSl00YeB38DBLRfCWdoG8kkQJX4YlEam+/fTl3rSG0+uF5b+FHB4on7hZZG/5r2qZUwbnn+94EEwFdk9MYPNZ8XJ1/LHEXABh4zyiChzZ4J9wiqqXEyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(5023799004)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IkRQu9jFWZ5qBoyPBM+SzSdsUiD7XL7ZMv3Lvb5V8g2nXF/H9J//4hN5BM76?=
 =?us-ascii?Q?qPu0kTH0peGXKsExRu0CgFEG+YzEXmxs7zYtmkHpvtE6FjyooNQoIfxaM0wQ?=
 =?us-ascii?Q?TPDgoA6bOcmQnbOLxRFOLB2ljBAUzEQSi+YvA6SwhSJxhjb2KfObAl0DFsSf?=
 =?us-ascii?Q?fdilClkodYPnL/xIYStmYi1k8FaCLKwRVdoTIACH68bYJAkq/GxQ4j6GDuSj?=
 =?us-ascii?Q?RTaMi65qIoOQOSF2f0I/tgzragvQk7rO+3hdApCCNK9wZVdsUYz8aExNifU+?=
 =?us-ascii?Q?ZidM/83JZTrgmPeCqJyCboKrb7PqQSJ1Bp6G7/keh4uT25hmq8k3D0MtYHzM?=
 =?us-ascii?Q?Bik3wycQazczp8+sGzjBPl/h6zEZSr+JDIm1SJ0m/ecGdQ2JYiHNNibTza1U?=
 =?us-ascii?Q?4ERkuKu8/pFnBHi6b1H1rkZL4Beu+JO/QlSZmEHHM2vPEc7rUBHqKY0Yw9yA?=
 =?us-ascii?Q?CfU3KFMDhGJDMJxqngCIrlas9OR8IsTibuLeoEoBd0ZNp2k4x7YmNfZgvA2r?=
 =?us-ascii?Q?r2LK9a/RRVd/+fgVTFhiAivk8bvFFMQVTif5jG2rtmzuXxx7b8mOAq+JXvoL?=
 =?us-ascii?Q?oFZLqpdAn54EtuhWt67ab8QWZY9XjRNZM8pwA9qJLmzl3OJwVk1ZOS6bNgv4?=
 =?us-ascii?Q?gLgq8Qol/RIKAXW4GWe97l6N19xLj1JVqej28NYkMzGYg1Krh2c5CC8sFlf7?=
 =?us-ascii?Q?NqgGS1qtTx6Qvid1r3HNsQrM2wQGZgqnJK7b8FtNg/c32DlTFWPh9ffGWsYS?=
 =?us-ascii?Q?5qiXb8VN26ilp6TR6AGfjWZzp261wi5MJ9KZe4SnZUYCYa0rPVmx1qjO5iB/?=
 =?us-ascii?Q?O453CeQyPcC/zPMpasXLNHj9L/256pl/g24dntKcTav8+Q8o2o03qd321O+K?=
 =?us-ascii?Q?IUK3zX4C8I7EnpaoURuGzT3sdEw/pt5N3EWLo98TmQePuE2ht2JN/Y3u9E/3?=
 =?us-ascii?Q?i4RWt5JnAIzDXcmkZDo6S3xxVeI9UmC3GbsnD7j887ZvTvQ1gCS12ihkoZXK?=
 =?us-ascii?Q?RXr8gT6/epiCACl75c7BOKhUHmYu/olwXKFIMNBztHwO/hkLkc+LAOAzpjOq?=
 =?us-ascii?Q?Q7Q0YpkOifmmP5suWdFyLiNJRn0xHfJB5WVoyNO97hz35eafTu+lNnKE//Y4?=
 =?us-ascii?Q?YXsyOUFO1y4hZCpV3fjDm5AEQ0t/sS69dTQVldGSyHB1t8OvD3RA4hRJENUq?=
 =?us-ascii?Q?QFomMeMz52tLtQcXSly65zDH59cde99ZukLaCMAPExQbLwxaeak5FMquvoch?=
 =?us-ascii?Q?cyyPAqau1aukpeR7pcf+bTtqaSFz82J9cR4TLvVYo0GasmkMAMdxlqoeXIgB?=
 =?us-ascii?Q?ORdd+yRvs2ImgSVACthBHQEa8Q9m/JJtsAkJTNPpane9J/dI0S+jABlrzpaZ?=
 =?us-ascii?Q?M2vAQyHxCS3Oi4LDyYJTBrp5Eof3LhAs8PgaDY4exk2SfU6mgbVZcSEaSCgf?=
 =?us-ascii?Q?SVkk8eVC2KsdSDF1FTHZomuKoX/OzXCIHKibRMA6N6uW02tPt+QS7QA5mrGM?=
 =?us-ascii?Q?pNdClPrksHcKL7XEFGVR+ykbf83RO79DGbMfwNVp/aUBszzyRPNaXt9FITMN?=
 =?us-ascii?Q?7bUv0QM0qqUtzmhVWv0n5ph2/XxfQAC1JKMMS8LoVT1c40g2t1FWp9Ycd/29?=
 =?us-ascii?Q?umP+H9EjjK9t+n6eQQrucIFBc+d6l1+IMIyp/9YaBa6Vf0NJO3XBS3ouhtgo?=
 =?us-ascii?Q?Z2X6tsGRy7QaX4DTHx6L0szkF3JlttW68AgR4yU5t0uQbAlSrAljQ9dJXDel?=
 =?us-ascii?Q?ZlqIZVhy8Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: Oyi+195Ofmway/fcunWTUDy23TFCkky0OrGP2W8xFyKpIVGMSCmrXK26iqfEhcXK08eKP6ii9ozjZb7PuZk/E43qVjZGAA564SrVpGajxkBCveDkS8ZIhBQ2tZghPhd2hYbvftJfa3E50mvKK82XVqBNlTXxOE8zwfEHjIwOxrzGVFmvpiLfPfx5zom8FkQE5lLiduAwxVV1UnY1JmkzlAJXHoPF7FnzCL9M0wlG7NlLcLg+sdLvF4NrabF1rOvHenKgwPmrbAkXnKCQYZD41JI43oeRvM/Vb21tQxcQm1oX8xI7LnWSQlnYvwQgwKF5URy6NSD1vZSRoR9RazG5Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 41583ef1-d680-4c40-fc3e-08df1fbc37a1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:02:15.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liXtR5V8Wck/GSbSE0QyX46w65jE8Sn+OEpqO6VhJi/yf8n7Y2ilB3FivlQTyPDqcOC37XcS2F/uSAnyOCukCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 08:29:53AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-09-29 at 22:38 -0700, Chao Gao wrote:
>> +/*
>> + * Bits 33:32 of a field ID hold the log2 of the metadata field size in
>> + * bytes. See "Metadata Field Identifier" in the Intel TDX Module ABI
>> + * Specification.
>> + */
>> +#define TDX_FIELD_SIZE(field_id)	(1 << (((field_id) >> 32) & 0x3))
>> +
>
>Would it maybe be clearer to just encode the 4 possible cases? I prompted an AI
>with "...maybe the 4 cases could just be encoded instead of the masking and bit
>shifting" and a bit of followup, and it generated:
>
>#define TDX_FIELD_SIZE_MASK	GENMASK_ULL(33, 32)
>
>#define TDX_FIELD_SIZE_CODE(_size)					\
>    ((_size) == 1 ? 0 :						\
>     (_size) == 2 ? BIT_ULL(32) :					\
>     (_size) == 4 ? BIT_ULL(33) :					\
>     (_size) == 8 ? TDX_FIELD_SIZE_MASK :				\
>     ~0ULL)
>
>#define TDX_FIELD_SIZE_CHECK(_field, _type, _member)			\
>    BUILD_BUG_ON_ZERO(((u64)(_field) & TDX_FIELD_SIZE_MASK) !=	\
>              TDX_FIELD_SIZE_CODE(sizeof_field(_type, _member)))
>
>Reverses the format being checked. Looks a bit simpler to me.

The above drops the bit shifts and the 0x3 masking from my one-liner. So, yes,
it is easier to follow. I will switch to this approach unless someone objects.
