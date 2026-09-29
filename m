Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3844FD799;
	Tue, 29 Sep 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697819; cv=fail; b=oaWRVS7PyWFPUYDUkdTvPGvgx76v9esGDmvcXHzWxy1UIKbWy+6yrkoMb6xAbpJqex49u9vGHL5SjT+EIQ49WZo0580jsqk4lKs0PD3EI+m9vXqaBnHvE6lIFX+slFoHHUDuDNB/WXqdHkMUkLJ1Su2J5/qY2wxsgGxdDP7VvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697819; c=relaxed/simple;
	bh=1o2qcrbnYw8j0T1nOWn75rJbjzlhgEenCZlkLfwpHmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fb93K3CNTGtoQ8DY+9a5XClnyRy7NIhgYBugS6QbwNOG3SN2SMJuGdzMspG71IPxBdOUdS6+oI95oFwrmUDNMiGNWg9NF33PqHEcqnXIVKIRIfduarMEXKbrYOcjItOSVmspiY0wicWmgWHi7MEkQvfim+rmXjWIFTLZNDntHlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCoXS3LT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCoXS3LT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790697818; x=1822233818;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1o2qcrbnYw8j0T1nOWn75rJbjzlhgEenCZlkLfwpHmE=;
  b=HCoXS3LTmEs6kmbLt1ZnZ5iSNt4h8oRukjNGF2uHK9ubm6rUibdl4mzR
   i1wcRXVEONWNSNSNupIFSWtW1pN6fCuHWDdQRE2K0iTU6oTGAMF4h+GTG
   /wG/FpFoG0Lhz+z21z5Pw9yDTNxGejnuL2ej1/mky/ao3uXswcn0ksTWm
   OoMoR9H9WhMsTW8YsvZkBPZDPuB5Zq5RPCZzYi+3NDPrsSza38lOA+zSu
   jgfnXlfaLyjNMQAViHAX4iIAslP+24E1+tQvbXnz5LZOUAlTZK7lgzd2e
   hlmiYvAcHoR0X+hTFf8x9C8RcLNh8yEyefs1itRT3uKjxu5dZJdDsSJlk
   w==;
X-CSE-ConnectionGUID: BHiJwG4oShSjrOoPXxeZew==
X-CSE-MsgGUID: S1OmVsH3THeNX4yii2c5OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90188336"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90188336"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:03:37 -0700
X-CSE-ConnectionGUID: vnMj58urSdGSubIuaoT9kA==
X-CSE-MsgGUID: gNs/69yqRhiBbOhxmSDyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274017440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:03:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:03:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:03:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsLGj+NlZixYA1tMFOmWiF3usvnkaalVAQ18l/BFNqdQfFOhWVE+NmKr5p/JyilKO9zl/z5erA+QOpjUFcuy3kBvf7qfS2SmX1U7FXjA1kPsrqoHm7mpXQGHaoE//fdOerHFr/ctY3Nj3B/eYY84g913EM/m4AiWfd2/cbr54GYIHCTdYzLJ7fVbtPu5NvEoft13KLBMA6BoFmRAYsw6iT2UiiGfRTN3wLyrtn61e8XF4+jEstKtFHaGrqj1/EFRulD1NGQ517qA/EOmx4mI5JIcNmhD3Uwv5/rUAnCI5oh70LOR1ILBYhz2K9Ifgo+1FfgZUjn6+ZxuO3WWYdZCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsq/ZUDsxxFCeF6HfgXlI7GqREt7YwCrJyrWnXUwq7Y=;
 b=NNjw8/My6zGuBYVN0H7XZTwqfrpSH8KziykPpXA1cw+U1LppvLTGrk96aqknuwCCc4XY0EX2vLcdgfryt5vzMxxBxOmvS9h3bXdT86uNgsqyYYxjTQG9qckeLNHQ8I4r6xTwdwj5SAFQj/2MAp2WRJLlrV0ieGIov3UvatiZIqDfDlZGS2Xn3TlXoSRVs395DVOO8oPmKO1pgrU+Oo1DRvCpZMtoqcYGb7yqXWalkafCXC2wSS3QbqJAL3cEimiWJKBLZeYEH/s0uNB2R8zHlzMIax3QB6u+BMSK+7zxAAnFUNJBRzepz2tQzdYXx5jiV5P/Tb9fIE2Cx7sMqmxH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MN2PR11MB4662.namprd11.prod.outlook.com
 (2603:10b6:208:263::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:03:31 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 16:03:31 +0000
Date: Tue, 29 Sep 2026 09:03:28 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Message-ID: <arvhUJFd7M6FQoHQ@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-5-peter.fang@intel.com>
 <0c6bc71f-53fb-4240-83a3-c52d090044d3@intel.com>
 <42975a72efc3a0f96200c065cb86970e8f452625.camel@intel.com>
 <aruTt9Y-AexP4NsI@intel.com>
 <1d20a787ac6c51e923c96b18a8c44fe8e7dd6d0d.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d20a787ac6c51e923c96b18a8c44fe8e7dd6d0d.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MN2PR11MB4662:EE_
X-MS-Office365-Filtering-Correlation-Id: 93832675-2773-47d9-dc2f-08df1e43350b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mySq2rzN9+hscPgw6OXiLwxlBcnHTKVAhjDbsG4O/SdM1vDIDys0vrlCj4sPwgpUhjbYqPE7NbIpSGyN+XvZM4GRVXXT2WmagLamq+GRK4R+X/XKQ39VZ6YhiPa6nnhOzt9KRWANSWsNfwr5DzP3c5B5ZY2PBYI6cfsBdw+Yfhbahnj657joFSSIln5ZGTHPjizrq07Acs/Z8Tk7gN8Y9q98B0fsfovyntyln/m5t/PFJqKK19TOJSMrGtdy+uoSlJhcr+VxRUMV0vtXfqJYIBFlNxXRuKA/EyaU6kFemC8k5JR95J6u2SRgIb1YVqa7hKoN3pzOE/Sejl09dCJVtKFrqxKkpWNtjJhOsbfgXfTkuZsJo7yDI5BXDi7+ejkXUaqWfexyjQIKz0lusSEMkpdkmCF0dpwfyGoJutYFgaybKqcXNNDE5u6kiCOgysz/9DbPpjxzSQpbV9Fg/n0A30WxcULNgR+fM2QRC6iWh4INeHYCvkmObYgtyHzM2YP0iijVotdUuKEfojY2CQ6AmzN2cH5bcrhXODfQTVttn/pTW/KlQt9VZqahrUbd21b9ESTqgAwlAEmF7/wbGDgEZN60ZiyULa5KdT8Qipeh6fMLaxUjzrXtCedhVNEAQMVosgp2RakWRNkuI+RmqjP0mMkPFJ90o2LspXmBLnL3FK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gj8MDzkEt+539rEzvQ8wFhWWDDhRWKz8FfpkPVRHy+KXdZMUwNNGNCdOIRNF?=
 =?us-ascii?Q?aDRbIEU3lrrtHXk7gTz3xf2K7Rgk1el1nQyvoEkImKkEFWUnuGH+9LZawco2?=
 =?us-ascii?Q?sASYnysJm9o06ul+ZQPqMHH4DlACyLBfaL5mCPuIrK6nosbAHuJFbxS0wjJ/?=
 =?us-ascii?Q?NJKIBsP4NDMVLQs+pWQC6bod1xO01llOcVt6TO3g8h/HvxGQ/cQV0VmqgupK?=
 =?us-ascii?Q?/DcByI2Xqvnpw88TWkNuLvl34MHIIRYt9N/arVGbw/SkDv+qfsUBY2iLEoG+?=
 =?us-ascii?Q?ZJGc20P12sqegGLecAhL0pQWq+LoaWH+/yBhlb/WAekFNUoZQdHA5HU5F0ua?=
 =?us-ascii?Q?trpt8oGcngaPeN+qfqY3ChV/fMhsffb0iL07hWlFYyr0HLEVFmdQrBml4qzZ?=
 =?us-ascii?Q?I4iiYAss3SbarHL208ML2dpuUFKggfjQ8bIJJUapGvi45ezHI/X4FKxV777g?=
 =?us-ascii?Q?m81O4kZKhakB10GwYaOBKw6Q5HLUI2CvTTUGchrdaiebqgvD/9BQOPKZuZfz?=
 =?us-ascii?Q?sxs8EFaerPc7LXJmUJAuhueD1APYT+b7k1DWax7tsTDheIv/tvaR4RmhTpA3?=
 =?us-ascii?Q?KnisvCuF1ozSKBrw8EcN9lWswqQZI5P+zDLmsaqRtDO2uU4XceV+CD76vd1y?=
 =?us-ascii?Q?veCqsJJyRhQGguhXoWooLHf+Vv++StbvtSKx1mX5Dnl83K+iyYKpnk+r592L?=
 =?us-ascii?Q?q71fM2piQlfn7xyHwqI6tigK48zC+R37FK6sg8MdUvFok3ErSSzwn0mu+nYp?=
 =?us-ascii?Q?S0zODsXcMHEZM6xis+mZiKscPO257pKc+wAL3HjMFJL71/lbK9qdO31Lv/JZ?=
 =?us-ascii?Q?C6iDDCGMbI9JsCCkyXpe4GFHpVgGa9Zjhooal2Q0E+jU2s2YRnjzp06UJDCm?=
 =?us-ascii?Q?yy+yGyxnS7KXyG7mQQvEdcCeg9S8IcOjWkL8urwcifeGHnmHo5QNmpeP9l4N?=
 =?us-ascii?Q?FN+BjNXGPioagY4vBTkKUmbMr5Te0IGCfUSdWqteb/s1oXWdOstZG2vJE9+v?=
 =?us-ascii?Q?nK7M/NhQl5MqOuwAoFfYyq/3yAFID4jI8EevEN+uJLBo2DzMgQgyzKiBFoqh?=
 =?us-ascii?Q?Eh4bHFANSaGvnKsQuAf94ubLjqoUfURlZxjrnzW1PUzhCOeQIF9y6xZnUdTf?=
 =?us-ascii?Q?vRu9wMrpsPdN1zLDLyCEit1w/S8hmHRnnkOUvjPHm77q/cWoYtSZuwdbgYns?=
 =?us-ascii?Q?Vg8C3Z6rFmfz6O3PDlCR8g5Ee7uQ2uLqhPaqZ1W92ERQRKAy8Yi+NTgHrdWR?=
 =?us-ascii?Q?GZPVgegAeC0eQxFrWChchitZM8zIdP037uLKs+JBSOWsAYuGw/Si9/rUG3dZ?=
 =?us-ascii?Q?tXyQGz7GOCPijNJrKAkRCWe+TmOWyQzNmUzC5aoy97lADf5aGrEbMQtQ0bnD?=
 =?us-ascii?Q?NsrTC3HzivGMh2LIoRmwqGd8SDRTYw9E9u++6Sc0ZCRB2F5q5frPFqal5MwG?=
 =?us-ascii?Q?OsnpoVEmLzWahDoy8C/DH51jxTKdFip92+6oUQ6pEAxwsBrhoJOcaCcGQ9b+?=
 =?us-ascii?Q?pD75Ane68Aos6/nwfqIrzkKmErKJGXcbZ4rs/lXt4H0H2XbSlGnkNb0B/Af1?=
 =?us-ascii?Q?UTV3CBAGg3d04aYpXD8J5/f7U9gTKWTe5jMlkozETKWRSBi+GuUQ0f4K8v+g?=
 =?us-ascii?Q?cQHKSPgmXpKkgFAiSAqLZ9Bokc4IscatRYSpXoM2kfEFXwtNtmS40MPWy5OQ?=
 =?us-ascii?Q?CcMhfU41y4fH5JTyZxy5u8CCEJ+1aHSEHaaLJSlW3pKo5IPDkDoyECYzF5b+?=
 =?us-ascii?Q?oBvr353+/Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: IZzv1RpgWJVxj4lKwd0Q91aXPcDv0ba4p61+mk6G5x9tC9F638PQq+M/zxepUUjf2BdbujDrZTALVTaWHvntTgUDUwB/EqBWMWg9qlcALxCaYHi4If0XEgfCB9T/v6aeXWKncCEdA7pkH6nLxgxGduesk969wXTk28kZF/IGHvUZEjUId+fjwkUz6bR0V3bv3mq5qD8TqXzxV8CLUQ+2LlgJQ+ahnwkJCDqwsDsB/L6w8eue2WEK7cF2/Q/w2yuxQ4IWgDHHlb4f1iqS3EO2VpeURWJsvc/uhL20zguWjHdnlC1RggAChPdREPBAWpaoDoWnOZHhTraMs4mtzQHcfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93832675-2773-47d9-dc2f-08df1e43350b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:03:31.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goen+AWNMS2+LZsrIZR/Z1HlCORGFx5Xunj30nZRcChdjLa7s0KEbAfZTnKfcC41AR7Ap+Hb9X6wvGBjsitsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 08:45:35AM -0700, Edgecombe, Rick P wrote:
> On Tue, 2026-09-29 at 03:32 -0700, Peter Fang wrote:
> > On Mon, Sep 28, 2026 at 12:13:12PM -0700, Edgecombe, Rick P wrote:
> > > On Mon, 2026-09-28 at 09:13 -0700, Dave Hansen wrote:
> > > > Please explain the goal of this function. Why is it doing what it is
> > > > doing? This should also explain why it is page-aligning and caching
> > > > things.
> > > 
> > > I'm not sure it actually needs to be. It shortens the math in the places
> > > where it needs to calculate the pages. And then in tdx_report_new_locked()
> > > it skips zeroing the whole buffer (not sure why to zero the buffer actually.
> > > Seems it
> > 
> > I talked to the TDX security folks and this seems to be a hygiene thing.
> 
> ???

I was also confused about the zeroing in tdx_report_new_locked(), so I
asked around and the answer was "it's good practice to zero the buffer
before use". So I don't think there was a security reason behind this
zeroing.

> 
> > Skipping the zeroing shouldn't pose a security risk.
> 
> It is allocated __GFP_ZERO so today the whole thing already gets zeroed before
> being set shared. After that it is a shared buffer and host can read/write it as
> much as they want.

Agreed.
