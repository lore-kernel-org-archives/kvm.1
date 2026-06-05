Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52693FE64E;
	Fri,  5 Jun 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780637172; cv=fail; b=j2ZolfhY0DKPXZxzzvHrMDMcS0XoDdP2+OmexqQAnG2QM7X5T5ATA5KoUDIpw+VaiiXB8sGfge07q9etwi3O0fZoK6VImblwkQtvd25L0LCUV+X7Mbfviw56Xf+B7xAUAxk21rAirHBndeVTTG5yOXQ0f6913OaBhgiKlQqHVjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780637172; c=relaxed/simple;
	bh=CMWIt0rn3l66G0XRJtarE6qCaXPZ9ZujV1Qxahls8E8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lUjeSrrTjM8l9tWwWx4bUTnDC2fI1jbHP5qLC5er+qPcsqyFDKlX2RtVeJWN+YnLxJhUA+0PhvFH8QjOKZh2WWjxtb7BuFlU4U8sVcc0bLjfH7jxRmGzhFc9l/i4TEr5nYCaQ1hC3QzZ/n46JqDFJKyEl+yWniJuGovaZAU7OTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw1fn2Nm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw1fn2Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780637171; x=1812173171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CMWIt0rn3l66G0XRJtarE6qCaXPZ9ZujV1Qxahls8E8=;
  b=Sw1fn2NmfMFQRZq80zGuMmnotxSPSOYFTqci2AsE32ilPWCzDF/LFENL
   fyw6Nz5lbMuEgrVmw60vdqkO/jharLBOeynVqlRSH36j1jyCDVSBBQ3dU
   KOi0CV6PWLGRVUgWoeId/NKsqU/srGkGCAderUwilJ5EpNeznG/HR9uE2
   F89fFUvu1Rcg9YQBcD7Xbv8bt5vC0gBk0mdt6ULjXN1/sUNr0ITgwcYCl
   Ln7KegaYWMqvRxy/FJcuYkPc6lNEc4akyWw35O7cShsKSFp3SiF+7SPrw
   hwiBNocchpIDJveVMSv3LsoZUpKhjPlR6qves3TPMycpN6t0VuAq7TjWI
   Q==;
X-CSE-ConnectionGUID: kroyFQ1ZQBqP0TatTKoe8Q==
X-CSE-MsgGUID: ngqYQ9f2RXGh2TDaSUjNYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81592747"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81592747"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:26:10 -0700
X-CSE-ConnectionGUID: w9j+5Qk2RWeetkepekm+IQ==
X-CSE-MsgGUID: X4MEh/IhSRuPv5H4QOeslA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244866403"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:26:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:26:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 22:26:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsITK7mz7R2o/f4NsYV6kSrYLvE/+BDhuqrxG8jpcjF7fb4n5g3MKU8HUFb2N5CuWNVUfX58OH87wTrI37jBLjOVV5Np2sK77ryPvIFbNW4fJ9Uc08Pb3UWErqTyEPckfklNy9tiq+FSmAJYNUGj58xAhbzjh2yepy+DoCRopGp2SOQSbO7/94I9paOjdvq2AXLh9k2KgrYevZo4qwPUU+S9STzTihP7a044mlU2krz5D7T2PzAWqaWLrUrRUNgAoiWuXUn129ZfexBxF+wMHlWWgbbGMHSHTSqyf37NurZMJ32cXOCblaExSLqOxFLo42Y5Z93AUy43xeeoWhuZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC2EW4IGNsyIyKhJ9Ken7PuWE2v5DyYLVBZ5p8LaQJk=;
 b=ndE/bgLLJiohfbKoqQCO4Pgok/h8NIY6ZmheZweXQ8WnYOiY/xg/95BW+oX8lBpGQ3NnvXWJWiFSQGm3XzbaQ4qYBq5aCotZ/KNz66Et/TTXzGBNqbszP7wSiNyNvOcFO9i94EYvlA9NWYbAzUMcUKrqufif7fJLG7JjVlPVOvALY4rSLikASIU9vCBtxxcvWV4MpHFMFV/vCuUn371BOQA5NXDFWQv7HgXaXVd/6TH2k2+1B75k6ylQRrDL3kkKXoVdKSNbrJ/hIRa5BvXYxPLb23A/OTnl2M7M4P/MuOPjo6ghxvb9k7hNwzR0fOIHEg6kP+J75mgfw9tmXml2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 05:26:06 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 05:26:06 +0000
Date: Fri, 5 Jun 2026 13:25:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <nik.borisov@suse.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <tglx@kernel.org>,
	<vannapurve@google.com>, <x86@kernel.org>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 10/11] x86/virt/tdx: Enable Dynamic PAMT
Message-ID: <aiJd4XTToKX20j/R@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-11-rick.p.edgecombe@intel.com>
 <aiGyIQvudD5ZF3lf@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aiGyIQvudD5ZF3lf@thinkstation>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcd93a3-c5ae-4a76-4583-08dec2c2f188
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: YLG5vR2iJXwGhtWPxwrhOWAxWtnGb5Vxqt4RTblFR08Qf+wEh3ebEWerncWSKlLud18F49BuOE3JOaaRo7jQPNoUeJP5qrYrinCvdVEFvtxOku6D1NhlTFIrIo6+9NxWpytLcIbnhPydv1od4LbZ1160dNrXW/Ppvd4AahXrUnZeObd83/NKa3XWgq4gQOkSMKiLkVB2yjneg9xD4eM31ESLQ8vwItkJE76FHt4DglJNWUDNs5poaZICsGoScAWPnjHgtuh7iGwzeeqhsrEvjz5nevxyzlJOB0BQKtI9BET66hodrDP01wJbJTk+UxxwlN3hHJmCI+qWKCwUSm77zbpDa54WRsNNGxgTOOqWMzHOEw4VArv7agdz1iPJwBvv5PTih0lOI8ewv+mt1LHj7vRx+ukP+1XeXeNYb39V4/iTeTGZU4sJOoxX/WUboXGpQiKbGY13HCCD/XBU3kPt0l2uKDh83T/K03rNHkpeg/J9pEj/D9Amic0JhcBnHSvA11CqBVU5lW8pn8F6qoSMEiKZevWTh3n4+Mu+GVFYDhQZLlrOonoDJopITJBtB7mwhixKox4CHqKWF9a7QepQljr/JaB0qNMsy5W1gWACeD1i9wJtYvV5VkQXKI+aAHVcI6xfrozGwg17BupWq+JA2SIKX7rUJ/dnJhKU4odqGCQ63TV0E54HOqZkLQ6mX47P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkciPSGz9o89HdXvo4iOgdJfjTEC7Invqzs+58wUz3UHhZ5Y8rwgkmhG6IWB?=
 =?us-ascii?Q?pv9z+8CZDfM3V1UgTkB/lE5pRIjz0EtrCJmwiQMvsNgt96477Wzdt+/acSlp?=
 =?us-ascii?Q?Tr4m6Utek69O6maW794wKFT5w2paR9MyWQnjjZRkMFg5MNmtVqaFfAcsMb17?=
 =?us-ascii?Q?16y2C6Aipo0Zrjgh4dQzIuA87s8NxV/bfxVuI5qm15WYzzsWwH2Syn6QbieP?=
 =?us-ascii?Q?g7xlC2nHQqSjI1opr0RU3sXoaqzeYI7Va0o0LUW7c8jCDEAQYt1sNXaZ5/tp?=
 =?us-ascii?Q?NU9+9KLQ4UqQdWlRjlWSPPmoy1DuGkRH5e52lrnUbHMtiNahyj43vlfcjFxh?=
 =?us-ascii?Q?vnnqHN+TpVTOAx4RglOfU/T3ciA9YU8qQN3UzhbQpHWVf85bHIHPfRuZeXP6?=
 =?us-ascii?Q?14S5WziOcDPIjmZ4smWyCvdVuC+5cNXZ/wYNFrapEZGOcXty0ZMrE9/lF+dT?=
 =?us-ascii?Q?jFSaUBWXr5Lvio23+PKhGZbLpIzPJ55KeGCGWrwp7xAMwaxOlp49nBJ907WP?=
 =?us-ascii?Q?ZunafCbSa8eRrNht3qsVB2kTQg+lcJkZ3NSsDzMT+PoHIw5pghMoWH83mOuU?=
 =?us-ascii?Q?jXd4S1Sj4Wop7WYLumuwamCNGbPtTqMsaGP2I1zMqLRlGXeaun1Sjr2izs7j?=
 =?us-ascii?Q?ILTu87WMU7ltP8iPDM2XCi2uB55zCLnbwPzEbSmWmZPyJkSbJnU6X+dGh6DU?=
 =?us-ascii?Q?pCwqNdbq4Ki8bzvhqUUWIi9BuDWxMYvfcl44p89d9jMlRukL78LDkdpb3nH/?=
 =?us-ascii?Q?kdY7k6FzgnW89uWfgYb4SbwGPNzm3ygYqktXeXdSsX3PXbrqld8kZ4UL0GRi?=
 =?us-ascii?Q?7fAkHTZ+yUCsTlOPGsHchMISJ5r7stAfiqK/G44JT7HxGizG7aKhET0bQf2v?=
 =?us-ascii?Q?stN4/hyZ6g8JPs6QqhgyXqXN/pfh/vzQRTM6cw62n3vOoW10TnqEEhr2znll?=
 =?us-ascii?Q?YkxQ7V0/Y/xNnCrkZF+1G2JMT5f0L0JVLzK2osEQOiW9lwp0tX7zUfZLPSNO?=
 =?us-ascii?Q?uldEkyjdEtUjK9k24f2Kg3mL7Ig9C5wyt24Ei6YZJ8jVc5wJoA5nUob5R5BT?=
 =?us-ascii?Q?Hhq52HsN9jpdRIMkXjxSMlB/ShjEgsrrZQ6EaYpzMqs9d4a+q78gWqL4W5pG?=
 =?us-ascii?Q?A4osoVyQYN3fTv/RBgipzEvMO5uAj6vJagLUWG5iCYV6u4hJluz+rpHNva1e?=
 =?us-ascii?Q?a8zejx2G7GKispeCqpD/enajGYo07MaNmatlTtY+s+qabJFiN7jxopygnINH?=
 =?us-ascii?Q?CGS8iXEoxNUqR5koQ5kDv/a+Dr8PFUSgqyJ6tF+24MWxhg34iHlr9XAEcat2?=
 =?us-ascii?Q?gOdvfFbXP0EyXvxvysriawU2HIJMq9EGDsBFRrahzbcA+/uiOkAWvQjkrYeP?=
 =?us-ascii?Q?QJBOqMKXmNVeUALo4W0cCaufEprNIJuKguFmv6N0ziAKRsOk8ddfmOmnMJYQ?=
 =?us-ascii?Q?/G+FOxB/4UA/SC/MA73lNtbHEoeAT0gAwch6I+wWRkLDTXrbzzul4GXwLgRc?=
 =?us-ascii?Q?wKLSAnJvTRH9jnToCHVIkuHa0B4CRd2OvlDwZjrV40wLBrSpz1rdTIDrhtj1?=
 =?us-ascii?Q?ScoH8q9i83YedN0lGD7YgB5yuYtd+/DLhAsr/oA5+y34N1H5kpVdO0SYM4zD?=
 =?us-ascii?Q?NPh6+zVf1PDC+9S1V5FaZBk/+FzPuplWu1GTEo4QG0YlPPbp1XEOXtApr7Zt?=
 =?us-ascii?Q?FJrVREfEVo7bRlU1PJRfgv0tV056FMc96rhFzkk9h6GQGCeZ6fqFGAO63ulV?=
 =?us-ascii?Q?A7e6lzqh1A=3D=3D?=
X-Exchange-RoutingPolicyChecked: bmFWoqRKMNhg22l92/P0TNsnUxMb4pj+hTscWveA5EUQy2atmK5NSD8pB+MjnPKRrGBOoSp7pVmDTAshKW3CsOmZxYVTrWA8zx4R/OfMMf1qOfaHVyZrbaMxEqkVpvxQajr7n0y1TbQH3j88N/InopBTAZAmOts3zNdlxGvoaoNMVTwYDaQNg0j9jRFCbMTHbrvWuiG0LQgGzQ1DKQAcKac9Vs1MTHCUoNoODODQZD5XmmjLHWAJELAl+gMeDgcSU4D8kZI5O2iAr++CZOaxllyeJtaJyeUclzF/z4PDLO8AEKd51EZBKTDV8RJkiBL78MlKB8o9kJo5+PBYHp4wqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcd93a3-c5ae-4a76-4583-08dec2c2f188
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 05:26:06.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/Rl1WRptBwWPBsfBNV7f7ZUoeCCzfFe0vJM0g94yfAxVrzukAjMCKxP/Q/gQXfU5tTlMUDw3D/rz6eS+mGlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 06:14:17PM +0100, Kiryl Shutsemau wrote:
>On Mon, May 25, 2026 at 07:35:14PM -0700, Rick Edgecombe wrote:
>> @@ -152,7 +156,12 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
>>  
>>  static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
>>  {
>> -	return false; /* To be enabled when kernel is ready */
>> +	/*
>> +	 * The TDX Module's internal Dynamic PAMT tree structure can't
>> +	 * handle physical addresses with more than 48 bits.
>> +	 */
>> +	return sysinfo->features.tdx_features0 & TDX_FEATURES0_DYNAMIC_PAMT &&
>> +	       boot_cpu_data.x86_phys_bits <= 48;
>
>Should we warn for >48?

Maybe we should drop this check. If the TDX module cannot handle that case,
advertising TDX_FEATURES0_DYNAMIC_PAMT is a bug and should be fixed by the
module.
