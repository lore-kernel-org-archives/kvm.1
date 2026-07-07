Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA932EEE82;
	Tue,  7 Jul 2026 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400684; cv=fail; b=ffopjGos8u41qZLZfNtZEjlU3SZdpn2UUyBMNBmQyByJRuECdwuC0qDoqNvJbj0Aw6CUOiSst6S72tgYVCNJJMeCno0rLTjXAIGwLjklJdHBjP7Co55w4/RNQcWvKVFedZLjGfmRq7Y2bmYewvmYqQWbb8XWBi3E6KZtkpyrZ88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400684; c=relaxed/simple;
	bh=Mc6TpZy8JwTiF+x5XRhKzNjUW0igyjvrij4ZCjEmRNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ochXipfa2kedHqmB6r5kIYtBgyOk/2UZrSp7L3Vy8q+XagJRX7pV5xt1p57SENAravZgJXpWP8PE5xxyubYu3innBCwOPMTv3GZZxbRhurigChG3JQB0bjQmIk6LMjY4oRZXtU9SyP+vuzrLh5hkMLz/HIhoElMEid9Ya+Iqu14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwKeQodn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwKeQodn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783400684; x=1814936684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mc6TpZy8JwTiF+x5XRhKzNjUW0igyjvrij4ZCjEmRNE=;
  b=PwKeQodnlxEPwfYTJnVpQD4ZBXW2J6xWGUhYjpAfWcLnTK9STuuZNzzU
   MxJU+w/2wBBtALYyX6vVHcRCrXjmX4ePxJO4ny0z7kw08XhDd3dqLlc08
   gXcL7lBhNxlgl1ps9csAdnw/fE9Pif7IND956TWtuoPbxFffC9R8NHBEd
   Xh0uBT3M5ACnh21h6TY8oRc9bjQIWsse4VY7y6FyK8RQVVh02vCILrF7B
   w8w/ZnUTiR/69jYswxeo/Q3Dh6XW4UQ4NmkVSjEpFYiXr4UKyHuz1qngL
   qMZL0bBTHPL2coZladuyr2gtRiwhGvDzjV10mBTankS2aHYYOElF4PBxM
   Q==;
X-CSE-ConnectionGUID: Q2CxE/6OTSGHfynAZftRTA==
X-CSE-MsgGUID: SYTV0KoHQoezyXS7H9KA9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83148723"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83148723"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:04:43 -0700
X-CSE-ConnectionGUID: H6aAOZGaTbi+TWzjy3GXJQ==
X-CSE-MsgGUID: itb5P8f1QXeRrXIVDu1STQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="292066396"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:04:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:04:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 22:04:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiNHn4h2VVOc9ucJVsfKiIioK/1m5+Q8pAxtA4IJs7SY4Fb4V5Fmu06s5/8pk4M+RR+a23OhqkOvbM7XYRqqtuD8kt88aZXX0rq3gfOxQGq2/oKv6dVr/4jSf/y4UkpgiO1OLIhMeiAJP5oYzPE64VAlD7STjBwZ691XS5le5A1popFIP93wOOH4mPK0SAxPiKRVC++iknFP9LzH2DoromxzCInhtrCuVQ+FWKmbOQzaSpsGw/t2tV5z4RnGuSnv10279Rj1diBdVZdB0s0vUFqfNfcIcEXkrwQ6R//hvLQx8PWvDNfIcBzjAubST5e3WQyIDvyWyiPYzVdK6+mCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrDlUNRTiEZT5vjG5jjrwei+E2SYNT2apRePBmCx8GI=;
 b=rTFaQPTZo1wb6RuvVg2aA/o3py3n6GhP244qjeAx0nupQrROLUDtGCW3oAhHXMwCaURcVuOSz7g2U8kNfWR5/6IEF/SMmzCgzRhtqy0Gz1SG0cZtYj07FebE7G9bt/WGYxt0So8l7fZflSfakuC0NXqNkXmKdFJmWz9PUiL8PqSiBTizvHyRKYQCvPZLISk6LdFtyvFmFSNyiDs1lFcaN6SNz6aYqzUQtdNGF3QUSS6K1p62QOP9gKkvSs2MHcQnJgYwvgqMph2bPv/SCTPqX9GWQ5FridrODmJLsgcjNbCf/BYtv2Y2xta8XIQxRPvfuBR7/5+kFEUb/knT9syoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 05:04:34 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:04:34 +0000
Date: Mon, 6 Jul 2026 22:04:33 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260707050433.GF2169894@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
 <b5d0a554-4d2e-4338-918e-1251e697a309@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5d0a554-4d2e-4338-918e-1251e697a309@suse.com>
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f49ae6-6faa-43e9-3570-08dedbe53c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|56012099006|11063799006|4143699003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: fW5JzqDWIWkE+Is+OAREkpGhPgXfgb5x4nYk2ISf+bWzIxAjQqEDg91nRo3Rhuq56GhCWgun3MvND+e1CZJ15LzwtXFjdDt4V2icg4KjjfP1SK+hyX+3ZRuC122yYqZRNq6QIgiCahYOPUnu8ZDmNTLEwxeXeasKZUGuHd7b/20EyH2+OHpGI467E4I/tuSA3PXeh56Nv0FKN7ztE0I1KOI1+DWma/UEZZKIUHUrhzIydGbKyoacFkpIKH2xsNS5Byy9OsTQsJowUoASnhKglMrPvoRM1sL3njwHNtjUMQ/yS51MpL6pAJ1WvRgW4fuKlDmBr3eRG1sYCiFqaCEqDctjzsEBhp8CIZkyRiteEVVZ4CzOKzN8K8I1/n5aDZircczvDw/M6XNiyRF7lW5LovQPZBaNvnLax8JeCRdT1QMJmU6qBDbOMnnR+MUshQ7NKjy4/1WfwAmjk0m9aWqfLb6lelLmOUwPCC+gKmbeVJG9B7xqK8dZbOUVHnKVi45hwRXIN1GgFTPrjtPAoNF3MYCevvHrYM5sXTh23wtd+b5YephF9Au3AV75xliEdWYgWPWpqo/RVY66jGkEWH3mKeNDkBlK4GF6bx2GL0MxLsGDnNfpq6zQgTjN5J17P6u8VUu8Bcdz1t0X9e8xuRhr+4Pzz4ne/4RmsqrWcm37aXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIgiVi9oa3mV0LdK6gyfZCn7B56psK1lXBSc5+jZ5HI1kmLkmJGRUmLPyiT0?=
 =?us-ascii?Q?JhbeiJSaiUljXou78IlGsyidz5nSnajxn2qO3Tq1W+FmFXrtkAGI/6qKrgYj?=
 =?us-ascii?Q?ioSKALbCqoCF8Dk8BgdrbfVq1ZVcYrEd1TLTdYVVdpC0j25kDetBLotb5l1o?=
 =?us-ascii?Q?+wW6zHsHbsGjv9NyhbaaenynCAH3c7Xbtk1I3e3lOV19eMQan+/52GiOQrC/?=
 =?us-ascii?Q?dOHMccJB+7xvihOu7fx6yNffJl33xeIhz0pMp4DnqKiCI7Q5fpIM64ixex1l?=
 =?us-ascii?Q?L8rg6W6lvD/8r84a4ft8bLP6iaycPbOPy3avmzOB0OvvXgYqUN9W8SscOsPA?=
 =?us-ascii?Q?KttIj6RWjPs0wX0/dWahohYWz5Si+YjhNUaUwWxQrgEOXBZsb6cVJx+AQwMg?=
 =?us-ascii?Q?7eR3RvUnZcWamTFZe9EWtM1hXCW3NQHMAiVEYzg3QJyktK2ZiBJ3qUi2BOs8?=
 =?us-ascii?Q?FXzsiACK6fyiLZkel6jF5NP9chRBeXlBx4sYu2X1zXKxAp3HjKjPWG0SYBbj?=
 =?us-ascii?Q?K6aspOYIiuzXEdRbrd4XArYPd41wBIWyuyWYLUuqNMS52iTEnqRHbVNIfCC7?=
 =?us-ascii?Q?MLnFFynUj6fJNtfEsac7TeBdcHbxGZQa7qrf+mTnVETrq4z/cfk3s3j216zp?=
 =?us-ascii?Q?gJz4abT8WecW90slgcs3tokl+uUmNylMj9ZUbuYbg+Jxnho1+Bkd4rtrkFsd?=
 =?us-ascii?Q?q2LuyeUnsqkCraf2lHFE1k/ZAbKQMhfTEojK3eFf9Sp6XjtL14HShpr4PTtw?=
 =?us-ascii?Q?KbX5fTyk5oJ0p3SK1zjuyPrvKkdafFVsJa2jn1TYdfOwMpc8AFhY0XPZ3miG?=
 =?us-ascii?Q?PJtfiKCAoGeGfJNNH8ZVHchhdE+MQz8cS5SqByJ6E+6omJLiSKapG/uvnW4P?=
 =?us-ascii?Q?Sqp8GWThEYWVMRtr4HZWVJ+HVYAB8slvJb5hQgnf/e+bHErvdYozMAoOsIR7?=
 =?us-ascii?Q?mnSTQkqC9CWo+FQW1ghIN7LhOXHjJ7Rk/a3EHlTwXt1TvGmeSczObtY8Rq6w?=
 =?us-ascii?Q?6g74cpety4FZJwJsDTjVH5EPAbuKNMTHW6f4EGJgYU8GYXYF3/uoicGqAqmy?=
 =?us-ascii?Q?pQVnx5AKKDdVg5oTxgXTnjTwlqLcRgnFTrHwi6vAzAnVoGSGQZYRwnDwPqhi?=
 =?us-ascii?Q?PGg0bSEiaq2ixrO1SO7yC2hmd+gSEJQqZB963NMbe9oUDOBOwYR1oLHiQR58?=
 =?us-ascii?Q?VOprOgfSOe85BtTTihfjKOZ3z6OzyatTpTjFZBDz19GhvAPKUbUb77I+XgQW?=
 =?us-ascii?Q?JZo/Gj644HwQr5pSBSEj5uRcWH09U0QrY0SnEBUinvac8XM4aWsd04VxoqWk?=
 =?us-ascii?Q?TsZpK0m+OCe0wQGD2MBSoETfwDE7Kvn/DUI5k7if3H5LydUdjjW/DUw8Q1jL?=
 =?us-ascii?Q?4vugywQBHKw82xxQ6eis30WTITGfrUL4LMY9Km6dwozCNbkd5SqfPI0s1KOX?=
 =?us-ascii?Q?jNzNZctcKGtXF0TBctbZfPVNBO4eZpLMoeiXPQa/LpjXRtTha8kLqLfco4QO?=
 =?us-ascii?Q?6ZZvynOFoG85a7NRtKvvrnDg4PbBerqC6Kv2GsW0bVfxybtOJ1gt66sjAMF2?=
 =?us-ascii?Q?tb8VWAg3W+pjpit8s4o/C/HTTmM7ZA7K05XncuyN6h/98Os3K1fRVcHQoIDf?=
 =?us-ascii?Q?qPVyX1V5A7OnBRRoBjpO7IkSto/8qtz0VxH2KNX+24DcmRaUil2cZmW84qXR?=
 =?us-ascii?Q?6ANN8R3hS4hjcIvF+uoHks9KvGWDUxaiyUH4Hr7KXIQVbqfh4bO9AqdK8glQ?=
 =?us-ascii?Q?J9Rj7+KNSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Rxps9T8SLrgoFbRngPKcraiMSUlYPJdWTPz7YyJvWoS7PLIEqiSNGuw3yixxCvimpukyVdOlwGmAzenk4aKoSX3EVVJU8Qf+AFV7i52KchPg4umTPl7hSIeGwNV++WkoMmER+uMRZs5S7pH2cQeWI6V+GDzYA7TXPCPpG9CWvx++r6e7T7zVFfTwE+mNFI8A/NTU6TFBmLt3+RcTyawRragKShL2EJquCg6lA7SCV0aVzLEk20wgaKBV+KeyaO7sB1z2BYy7p4fg0prCWER/KdieEt1JH1N+KUss9VLiADp+75RBJiSPQA8zH7oJb55qveK3FWsROahIBt4muVE6eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f49ae6-6faa-43e9-3570-08dedbe53c70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:04:34.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhgl6q1IEiA5fNehGAbCJ1WNejPdEsecfFKlV0RjLGudM7wtXMbkEmlzltqH2IjtcnXuOG7bdyhtnJcIDN7Gww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

On Thu, Jul 02, 2026 at 06:26:27PM +0300, Nikolay Borisov wrote:
> 
> 
> On 5/22/26 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Provide an in-kernel path for TDX Quote generation when handling
> > TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.
> > 
> > Use the core TDX API when the TDX Quoting extension is available. For
> > simplicity, each KVM guest checks for availability only once during
> > initialization. KVM does not handle Quoting service disruptions.
> 
> I think calling this in-kernel quote generation vs user-spcae quote
> generation is misleading. Rather the distinction is : quote via the vmm or a
> quote generated by the tdx module/tdx extension. I think this should be the
> level at which the distinction is made.
> 
> 
> i.e tdx_get_quote_vmm vs tdx_get_quote_ext or some along those lines.

Makes sense. I can update the naming. Thanks.

> 
> 
> <snip>
