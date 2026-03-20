Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEB36E495;
	Fri, 20 Mar 2026 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994387; cv=fail; b=bas/VfFheaYj3Ssz3Hhu/DAHk1XZYcvAT2/snaLrAm8Eouk/N9lyUhD48nni+h/32qfozpk5JaJNIkgWZETR4waQG3mx0oqXHq1TE3/tnNr5NC/bPUKEbMjB8baUeU21G0p0ed/xmRXvFLVLGSVVE4rEA5I1fLxXSEtcJcaywWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994387; c=relaxed/simple;
	bh=/yGdVwC3/Oa7WOz5u3mGnbm25rWHZBs6ghOWemmKfTI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBQElWVgjacKNLTxS9liRpeBIWTnNzGUStmLiqrvr3IDhYHVm9w1V36TVexfZiaUbozAKqpDzmEjyE21W0NnfAiCd8QhFQbctSFpqrQqbKj+1FaOWltmR84W1yw85H3s8D6l74MQHOiU2IknIKvrwnkO07tGg0hub2T/YI035aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbFb1ysK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbFb1ysK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994386; x=1805530386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/yGdVwC3/Oa7WOz5u3mGnbm25rWHZBs6ghOWemmKfTI=;
  b=kbFb1ysKNb9Gv9ZWKUuM+vbNxJHkk9SztUtCWU77/W3kgbX3cq7boKQ3
   sdlfAdADqbBcuHfhmGrbmZdc0FCA6b1Qv4j43c9HdBuPcHPaIsb5rCJrK
   UJjpCuutjDCTrlTK6mYHP2/qqlRBkNrydBsKyoDl3/1UPcmJO6hBkXU0c
   w5rXqVEj15ouX7RjGAOXEbE1WDD47TrnJ8N8nH2rRycR28m7gdB0XAHF8
   4XTZoJfkY+Vi0JmrUugorpfjcxmpu5imOufR2ncv4bHwe3TNzI+T5oOAh
   9QIEeL0yXfQwexxeGMNXQVvpsMIbr8GDn4kv27JOSvk5w6t3azCLkbIbf
   w==;
X-CSE-ConnectionGUID: 6D7Y2g3MRcmACGRzRaedOQ==
X-CSE-MsgGUID: s2UdQYP6Tbyk9rLRGu4wpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86438275"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86438275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:13:05 -0700
X-CSE-ConnectionGUID: m8MX7USmTAiqxW9ugoncPw==
X-CSE-MsgGUID: gCoD2eO3TEG4Tr8MFa0Kdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220579727"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:13:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:13:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:13:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d83PHeimlztYM4lVYzGU1Uj4i6zdtxSg5jYedYjCaJWLwMw2LdqtSIaCWd4PyjH9zxwhwm+t3Jrz8kczn2Tey3OglYvZOhWd/OOfJa4KtAawbQcQ8FUQbmnTtLuXpHr3xLgY46vyHSfEZaXZweLBaIY5/2IqCgPYQGpU1FugMtOWzhRGbXlCEdEs6Ix+LtKfzWyTBCxz85xEoSNaxarGqB9pHF1Y8H8WcFIO4U2u00K6epzWY7zrG+NTHglnVl42tyiDEL++wgzAemFUPYtglnj5YeRA52BLZe2/q9QttOjK4me2isJ30fnM9iRi5AOEuUId5IhBqH6WepLTwDaKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIeXN9suBoXsD/37ocURW4hJNV5OXWArpxkFkhFl1go=;
 b=hSEf7FWm+G6rZTGUUvoT+CDXIVpyVmMqX9xtMlVq0jmffp8E8vRDhJUl0rT43Jbjx0E0wUA5hw5aaCV7HKIeQ62I76GjKoxIFMo9yvw5uUqlJGVIIRUrlzDEAL7YmA3Z1VFbUwm9ey0Isz6f/HPpN6iYv4Zfs7ZBCMXmoB11G8aWzH5g+mt+R4qpbxwEWFvbv9WkeiErzC8WyASYq1RsWXvSYaS6bI1GlCV1iXNyeg5TFDn/6O9zQIb6HS1oBr1Gva0rXddFwGP5ZD6ABEVk0D7FxqmlRlZLY+VAOAr2ZKJ1VwnVKrH2FxlZVZ8eUXEpv6ypdXV0d44+Dk6yEQ2LZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB8668.namprd11.prod.outlook.com (2603:10b6:8:1b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 08:13:01 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:13:00 +0000
Date: Fri, 20 Mar 2026 16:12:49 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <ab0BgT0MHXukge2p@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-11-chao.gao@intel.com>
 <abv3Jxn5QPFGjq9g@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abv3Jxn5QPFGjq9g@thinkstation>
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fdecbf-6c85-4774-b3c6-08de865880ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IKk7Q38KQDm0I4jBc8/I3saYfdrUbslLJPSGViF65e6Y9l9Luwvdlk955l7F9yEqLI4gI9uDkEImW6KsJvPG8R5D5qDetUiyoO/+KPfmsbaG5AK+tO26gbzwTzfrQMqcMeWtuQVvmfQdFhGYUKZf44aAusW4hB4wOAHBch1QS1CE+emu/jWF4AQMUpgr5CF2XS3zrYMw1rw/gHR0J13RTnhw9JP8wQ1kS9xpgaQTXfeR8TbvvoFWsc+riAxnFGeRcwGVL42fHGzn3W37hN9OuRYmiQKEN9Mt124jbNu80w1tI5DzDNNPrEUKIGhvTp80bbkgKAJbqh7z38UgHn7K2UHyRpMb0PI+Gb8YWd/0/DLRUpj5W+/1TWHJRQHu63ksYaA6VSwTrJT4hivSA4v3/i2XZPBvsOvSpQfzJYs0v8BA/Yyn/fOhcTDH686AXjXXYvAspawpcTgp3Z4pWFLD4zF19ttC0vwCPaHub3Ib/wlmA4hn9VhIXHIeL66BihsWDC4wBF8YpxcZ3GouaMf6hd2Qi8XrpuWP1Ol6r1DtPKl5fADwFaxIzNdhtNR88hy4d0ewQubN5iGeiuL6NIUoWEJfWKdjTpVtf1HhT0g2CvuCfk/I+8zqSRBLQrt83WNbNEoLpZ3bZqYra21lxa4nJMSIMGg76u+6lAlEdSz1qYxw7QmeN4WxYtUV2WNzk3kGfjaxvdHq/Fd/+DHIyWOt7hAoCm8JqHxQ0/ikJjFkrPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0S11KZoTgiZ2NobQ4QsyzlKknzkJKCxrYf2+tqAf5y2oi31YL/1E3CKyfxdU?=
 =?us-ascii?Q?UmdKm9cyNAocgSeJDebDgvU0KjcDKFzAWYATBLnqn7oj2IfwE6hQw5lI4QPl?=
 =?us-ascii?Q?cMGGrfvNenrnS36zMh8QOW7zewZTnNs+YPhSfpQeM6T2uxJUxowAK7za18Ke?=
 =?us-ascii?Q?hQBhMKtbapH8kBGUtckWLCxmtpRhnKdfZNWHuoXd6oUnUBpRXpaboqHAbMSn?=
 =?us-ascii?Q?+TqXsT7naaob83Z9YEjfLeS1ws7yyxQeN/A3iACa+sJEk21SJErpXM2oC/hh?=
 =?us-ascii?Q?D2gyBhx3/WFi5SLNJSzv8rWS5fTIZ4VUTsOl+IJPKiaxDT0k/IPfarPKf26s?=
 =?us-ascii?Q?Sxc4vJlrp8EKOufskG7AkgRcXES6pCji0BS6+Fj7MKYe6c4Sg0SgTDxL8Rvl?=
 =?us-ascii?Q?05iKXovfZBHDC/yp2o7ljmc72mXkyydg79YaHRS6O06byEk2OGyAP64dIFy8?=
 =?us-ascii?Q?TehBN6ToPy6QHgpAvTHXzKlG7rxypCNxcgIYSLjbsn67afTU4TWdpadqRS1z?=
 =?us-ascii?Q?mN47S5c8oNtBcLCTZ7oV/COT6wFxZHDGsXempIys6xqNqia2OKBEbAD0BGAJ?=
 =?us-ascii?Q?6lUjVTKKm0bkUVx6C1bqttoqqfaXE02hkvN/Cxfxd/bYsrAHyozjL2PLnGMN?=
 =?us-ascii?Q?/Lp4sumULjKIpNVbl0LigHA4zOuW/Ob55eTEekVAv2wHtMpb9vLWjN9/F5RW?=
 =?us-ascii?Q?fFisLBmozq2s4AWXuO40BzQ/UPg3eXJWBTsfI3M0RtdCbpwUnBXkpuiUbwaf?=
 =?us-ascii?Q?igL3iLnCJty6qetSV/INMkta+yI1SHGNOi0CPxi6yfBkK2MOpn7ovOGaI4Ib?=
 =?us-ascii?Q?gmtxbI3ic+8VcxmNthc9K7goyq8lpX3J4+S6nbn1L+a4T1nwLa8DGW0UvPak?=
 =?us-ascii?Q?OltmtJQSfMkpYQ1WDZU6mDbgXEcK9oWUjzfmu+8UkxhommuSXQVw0KnQOTWn?=
 =?us-ascii?Q?h5Zqg+bE3OWigTzU5aWyNeI/VdUNekPQpaSzekarH62pajYhX3UmD5xKZlBY?=
 =?us-ascii?Q?AtcNGdSWX6Y8Kv+nIovZuJL6EAlbHzwjK+jO9DPld4zEExQdJkVJswroPTTA?=
 =?us-ascii?Q?hNe22Gk1ZwzDyHF9j/GexuAyNJqgeikI/EZWp2va/cYLvh4ebQQMduxDGkrN?=
 =?us-ascii?Q?ysRem3pgoRHXAFcpD6oKclnIGVtBwc0dn10HSdc5gtK9JxELdEg+XE+p/Qkn?=
 =?us-ascii?Q?1pJOE/q9nCKH0h5CUk+o1sUFv+p0YWizSVpqGDN7R+qD6he/kFXY0Y6PnNQN?=
 =?us-ascii?Q?Fc3QTaoEW1/mMe6IC2aeLZSgbbpt/3TLNmSzA9FAWLXyIv/RPA54y0/gucZf?=
 =?us-ascii?Q?og+9nTs4Ir1vwzc+E3tcUmU2rpkKKeACXwIduNJUJjuUy0YeZFviPN+vA3eo?=
 =?us-ascii?Q?Q2cJz5B6n4TK7a4ncGz4iEytIo17oicsGbNADX+ea57/cnyFmL73V70N2B6H?=
 =?us-ascii?Q?QqTfF44vCqodPtX7DRCf0dCXNTI+jipZ2xWWoai1xXoxG4RMUB7jBGjnCHIy?=
 =?us-ascii?Q?RPm5B6eopGuIwQNtqE7D5FUTGQI6+s4MYO01NOsSGDfoZA76CBV0tlJIiPvh?=
 =?us-ascii?Q?GImTWupCxzHmQNrjB3M0uicencHMkayLDdNIhBLhgPesr6B7n8D+k3D4Xv9F?=
 =?us-ascii?Q?nMQ9tAS2vyWzkd6O/lStYQxM62tEsRlTuD/pAoPOL+LbQbSNzG2pWdXwmFBh?=
 =?us-ascii?Q?ZrSadb5/XN56HoVRsaC40zaYpkdttD/l4+WKsSC01e1BX2iaQyiC694njdtI?=
 =?us-ascii?Q?izCS3ReysA=3D=3D?=
X-Exchange-RoutingPolicyChecked: N9BUkQJwuNbik3+FQq/Ktvv0HrPoCnTxlovDtHsm1dgiLtIx+At6EK+IHG8J1Sni9vDXRIo/n0UtqTCcUaDEhNSK5Z9d+DAL6T1wa/efuq0uA72LyjNGvzTk++y2G5ow3OGdku1OHwsWR6kJ+pJYHDmwZZF69aYC4ppeRkYOjsqgDTGzSi388QTQp9kJ611JW+rKn9sMk/UFeRJ0iryqKJirV4TU/LOkoOqIudElEKrRUHKFFzMBYQiEdlu1j/yy6S7Ivm9bwDo7mMmT+eDqT2laMV31LMSEjGV02VgLJXBTyBGNK5E/BYirPYtHSTGlDJArCGb+qzac/9eQrmxFgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fdecbf-6c85-4774-b3c6-08de865880ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:13:00.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRz0c5TBKLaR2l83wfLIXMWHArwz14HWMryxP7gKPYxc14YflNDcXnZcaQzuXzmDbjTgWobePEiKUS8TjyzLsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8668
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 01:19:35PM +0000, Kiryl Shutsemau wrote:
>On Sun, Mar 15, 2026 at 06:58:30AM -0700, Chao Gao wrote:
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index 978fcca92128..e195703398e7 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -190,6 +190,7 @@ enum module_update_state {
>>  static struct {
>>  	enum module_update_state state;
>>  	int thread_ack;
>> +	int failed;
>
>bool is enough, right?

Yes.

>
>>  	/*
>>  	 * Protect update_data. Raw spinlock as it will be acquired from
>>  	 * interrupt-disabled contexts.
>> @@ -237,12 +238,17 @@ static int do_seamldr_install_module(void *seamldr_params)
>>  				break;
>>  			}
>>  
>> -			ack_state();
>> +			if (ret) {
>> +				scoped_guard(raw_spinlock, &update_data.lock)
>> +					update_data.failed++;
>
>I don't see a reason in spin lock here. Just WRITE_ONCE() would work
>fine.

Sure. Will use a bool and WRITE_ONCE() here.
