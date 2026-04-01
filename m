Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F1318B85;
	Wed,  1 Apr 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010360; cv=fail; b=RhuEnLur3gl2kIsvuQQ4eHFeL2rqeJikHZqJxadrcd971bH3tQFtpUf/euLwRji2VrsO124kq8Y+QWHQ53DUKwDaZZ+i7iMyHQAAsRoSVzWUz01L3DThCD7OzwNpza7ZFs3TQVdfZsMhjw8FohMBkgoWkXlflGzziCLHOPhYxzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010360; c=relaxed/simple;
	bh=+OrffVsYJSrzeGbmfQCVdb0h3INZngTT9vM6hrw58k8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMoS8dqeQuszBkYHVVm75voSCoRmZUFviUrNdJEOKBEXqoG8mzYtdzciQJ3sTdjpxvxn/bmuMuNSez6HsTrlU5YJnJdLFRkym/Dn2p7rfCuoiG8itoUfTwYNq9MfrBWF42MHIon5qA3nM7C901FOSGU0hDRvLejPRjAzZDLM5X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx7lT01Z; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx7lT01Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775010358; x=1806546358;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+OrffVsYJSrzeGbmfQCVdb0h3INZngTT9vM6hrw58k8=;
  b=cx7lT01ZoqI31mavSYmJ7pDrEbtEjeEU005ggox0AlNExN92hArIZCIE
   YgvLYkw+Z/QIGb/TTGlrWzws7wMFeoHGVRXt6stIOJi6gCvvhoLILPPup
   5AvkCOhaPr5EmftVlDWvgKQnjbDb99yDtJBVRWY8vGEEWXtMptq/f9SHc
   JWvqyTC80NQtsmi1gxf/o4al/lAcqI/wptXuh1b+zyCp4i0Q+NLAdhoQQ
   wj+gXfpD0qGSWtCi4f8w9kd2n9+jhNJr9DhBHynEcUZwfrrK2GobnnB2b
   9G0ETgjKPul3jTIozAgmjhLAcPh3A3BEVQHVxprp3+dzcKpzfii7Xcckq
   g==;
X-CSE-ConnectionGUID: 73MauxihShWGZXZEICMViA==
X-CSE-MsgGUID: jJPAVOLmQ4CNGEFcOXO3fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76099652"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76099652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:25:58 -0700
X-CSE-ConnectionGUID: iDOv5GT6SfWKNMmz+T4yXA==
X-CSE-MsgGUID: KbMmIU2rRd+VoMspWGA2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223655636"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:25:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:25:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 19:25:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAdMvfOZfpMrQsU6D63uxK288bRcLmoWN/sdW/JBOx9VmysyACat75/1+RoIj9MBkMdZVNlcDY7D2qTkI8vbLkkqQSt/a1gxsqkqSm9sGqUjUNtAYw3V0rPEv3awHR9f33YfuWsO7SN1ZqS6PeoYzJhHEqS67xHYfaHgTBDnWJioCRCk1P0teTOrHmrNyGODlpWRJILMrH1kfTJEzZS1TuPt+RHSIp97WhIDxMeNzk42NzRmXeQA2Gk1xlcN61AqYB0hCuTe5HeIlg4si8GR2FlfN75pxX2ZIlq3Kc4AlnFtDeWJjDoPY8Pf/hVr+NM+5A5Xq/EkpiPqXFvtZbLzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKRjmhuI+3zArbGeSc/UBrvE1oxGBOmm2BWEZYQUFtk=;
 b=A4nPYlAfEaj/0agnW7j+ElCsDQz1nVIEe3ZCWArcr19e9VaJVuw6MG6l8RhoslHX9qAyQB5vN7QqOu/OTGnY2pnQSpZyKAOpB1APPnLcsk9qGLdDbQ+r7qBIpY6ljxRYKetpL+FIK0ryHqnsgCvVM1WpE1hQ3o0+xKs2ZDLdkjnPeWJQLZxy3crvNoB01rCodKccD4ZVtFx7hQ2FW6WIAiJfnnWo2BlK7G5PrV5fjhKY4eUOqkS56tNJFBwG1oQB0cKuO3iAsevMpvDEqY6yRI7KR32vKZYBNucIBUkwEaHr1XGgegLU4XranK2HTKOT1CVIlb2azM5+xAZWdFVRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 02:25:52 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 02:25:52 +0000
Date: Wed, 1 Apr 2026 10:25:40 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <acyCJLLGkGr102hz@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-7-chao.gao@intel.com>
 <95126568-3031-4d0a-85c8-d3934b6fec3e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95126568-3031-4d0a-85c8-d3934b6fec3e@intel.com>
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: a32c210d-76f7-440d-b0e4-08de8f95fec0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ++f6DXpuMbLO+OsA7iJ34u35HECFdUkChwnmwvOIP3TY490TwMuthC7t3xVbp7KKlaUzN9TvqIHUeop7Te8osdveCiw/LkWL14CKYfrssNJnH9TU7Rv+5HkKHchdtfaForSMIhqRMCL6lNI6xVl42Jbjzk07xWgWhuvFpMETuQvprpHsjxN15JTwOxzwPARUZKfArcU9NjcNgnRli7x5C3m1iiiZi9qeMzwRv/tMysq4TH+D204h2qyJQAo3HTL6vDjYXsHoUVoVG1SEPYYWRX2M9Y2QaJ6LT6nMgjd2LLMrX0VkIdLCVYMHHy0LdeyRhVlhrp8QoUHLnqh6BI26ZppOVguVU1OgKYYQStacEQNUEh69XCCOlIeBvVzXkPVOePZj5KsRc2DkLUKmcNTU2GtmfTfMdcbHKRId/BOd8YF9CBKEPqG8gVE0usk0PNijXOW6/L7cj6b2iio9lS/d5DgJhSiquhAB9d/WMLO+QQcyWA0lGKYrjT83Yizt41ixBU2Joe0+8dlKagULEBew4dQx/ZesU1eFtoO8Asv9E8N9sUT382y3VR3+ib5M9ac4iKf/esOVuXmsHB3X14fdKtNafpEZ3P47hq4Iwa7L6ebNi789UgCifjAPjy5JJyBBzV+FhxI2/pb9ZgPe1kG1cB8iVeFG1PxKHeZmmKDT448qRRDh/GTuTzV6H9tE9LHFJacd3O4l+JwTzUAOcKNvp6i7l+aNNlsWBAPWwfSHzqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxaM72qLolHaXR3G3H/2yzf/e6eLXOGfOoaBBm3Oz2RjBreoejinYInFUaeb?=
 =?us-ascii?Q?j42rSoolvm/+NW/9/JDAlb3uaaRdJm+5l4q09tdd3HK/qqIgY3H/c9EtWx/z?=
 =?us-ascii?Q?gR+cskHLnwTmS1PGnXUXPsUvXdNY0Cn7C9Ld3pJkl53mTCCaCg1O6KqrdQN9?=
 =?us-ascii?Q?ULMEFuOQh2tnmkSnDCwnuJTzzHQV5bhI92hhmTHJ7lhbUAhSGen4zO83PcX9?=
 =?us-ascii?Q?0mSjil0FMougCgnAYC7JiDNwWPyZt0R9KgYZ11wmHh9c6oADkZKXMBXGJ3Hf?=
 =?us-ascii?Q?8+zQIathRGOHw76i87Osc4jg7Ox1Wq5T+BHb4WpGix8x6sncx63CxPueq5LR?=
 =?us-ascii?Q?qmUcOaLDLXkx9bgZNnXQn/h4O/fqlwp6Jlr2u7nhJrG9MBgDDxccgCQW8PSN?=
 =?us-ascii?Q?YHxqisHbq+GWKY5ABaxPRKmMJCQNOyp/9zkOu7ka5K2K2osJRwtO+2lzf5HC?=
 =?us-ascii?Q?mAVNtcN1j1cSHRgO8Scf5nNpEHGfiiG8jOnzYpeVg6prYtI9xhfo0fs8+dRH?=
 =?us-ascii?Q?1W+bHzAYo0UTNdyuMr37AvR7ZZxeosFD4tVZ5dfMxK/pJJM/YShJIV2UYlAa?=
 =?us-ascii?Q?e/lmQaL9fSd8pWJimby4mTihQQ0U5sdf/Q6rzQwUMGmcYDw7FazbyM8t/bQi?=
 =?us-ascii?Q?pX9utDjuy9vXDuUmAR945nGqRotXBZtaooN+teacqf8mZ8sw6nwQx5dp3xAK?=
 =?us-ascii?Q?z5wtalIj/8ahqMbPc08M8NBhfsqpQPejaWpZXPrrUZFW1dgl+qEKY2r/apWE?=
 =?us-ascii?Q?aRbvMxoOdYjfdaDH9bC7MyzFoq28YVM+yvqCin4K0VcZYMtjo6NIMIN1QwAR?=
 =?us-ascii?Q?NaOWadoLwJc2BkpFkTm+Y1RrR0vw7OZjJpWq9B8vWCPS6q5NJVZJTk6o5cVT?=
 =?us-ascii?Q?hYe0kZBmS6X6IDicQjZWhc4Aeyj9AHSGe45p1PoRSu6yey1/FzP6QyfMrYvH?=
 =?us-ascii?Q?JYMilv+AMktXlrYhRKfPOvR2MR3aDFGm/uXqqtzw9Hlt0h2IjuoHG9zNlv9o?=
 =?us-ascii?Q?2dbpPkdtIA3ICzZn2gIKlzBkbMfAxt5KnSVKgZ9w128r8A3v0bK28eOlF5bE?=
 =?us-ascii?Q?54X6+ULUAnbNqeJowDsJtpwe+lgOIKiHyQGY9Jy+vLbT/MKYDPyIuXiMA/5n?=
 =?us-ascii?Q?XgsVS0wYaDhJxrbjga5BVWd10HldUqd99GMSFbBdj7iQRHDsaDKW8588XQsL?=
 =?us-ascii?Q?WMsZ59UxxbcwYqj2kNKpXsTxOzrr5V8SNW+Tt12hHSgTu1wrBkofLOfeDiKT?=
 =?us-ascii?Q?2puaTT6q5gn984nnYO04PRyBniKyUBxN+o7fXx7XFulQOdAFIC+Kf19rYCTY?=
 =?us-ascii?Q?CKA7nvJ3ffC9FUFmScGYFBxCrc9fNAsci2RzEinNvP1sCpuVM1KCa3N7Aeck?=
 =?us-ascii?Q?jG1IISFIL7pU8K+0n/0CXyoZMZUFYhRuIuRBsFpddFg47V37as0RU8QbTBbH?=
 =?us-ascii?Q?gsHpzNxv3WH572wOldJKIIk8FsEMGEbjKRnmwerMXr3gxuVwypX3ICZyHh5+?=
 =?us-ascii?Q?VgsNmB3d4bUcn/HLN66iGSkBQhMSYEgfLF2mvY3n3e9uUmm8Gml/SI+it/41?=
 =?us-ascii?Q?z08HY/cTBWK2gZ69YLU6lJaKTEsarkvfEBV8wQlWu4yZEfsOkMl3lDgv5Tie?=
 =?us-ascii?Q?YxxY+zYX2tUvVX9l7TRXeSYTqX1NKAZM96TvInPFxxtCKpdHrRr5lvrVq3Rh?=
 =?us-ascii?Q?osRDRtM6JuyYu/FY5Y+LYTgY9grn52f5Yu0gzoKlmM4xs/YzeDSBVFiPSZ5V?=
 =?us-ascii?Q?aqD5YX91tg=3D=3D?=
X-Exchange-RoutingPolicyChecked: qnEb249u7c1zVHNsSxF1Gsh0tPHBSO+CTT7P3cS2V8TRbDM2TEs2Ip+XpVmUSJjFYwq5cP7vCW7xNU2cwwHXODIEiZWQFFDFYQrhiQGtG3Ol3JQcDnmqyEkhqPtRGLReU48bZrDRFBiW6+Lcf1IBbL9ypdOGQpFxXcZURfL4b3CnzU+dTFgsnVQ7DqPEDPzp/n42UA8xftdJRtZ1AkYdKKmB2sf6ah8wm4dW1owRtzyoipTiSe1j7eHVNXSgairN0i/UP6/dTA/43Z8pzg8TghaZp+OZs/c0ZNUPHyor6Rf7rK+iTjuugwmBQBFvt2AwaqZ5XFhVg+HRhCPiLPT1bA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a32c210d-76f7-440d-b0e4-08de8f95fec0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 02:25:52.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3Os4WjqVWKowxZX5VER1L0Xq1dFWUcoxvLtqk2C8rJa56Wop0hcTvUhdjTPW5y5Ik5gQL933PXxhFE0xadgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 07:58:14AM -0700, Dave Hansen wrote:
>On 3/31/26 05:41, Chao Gao wrote:
>> +/*
>> + * Open-code DEVICE_ATTR_ADMIN_RO to specify a different 'show' function
>> + * for P-SEAMLDR version as version_show() is used for TDX module version.
>> + *
>> + * Admin-only readable as reading these attributes calls into P-SEAMLDR,
>> + * which may have potential performance and system impact.
>> + */
>> +static struct device_attribute dev_attr_seamldr_version =
>> +	__ATTR(version, 0400, seamldr_version_show, NULL);
>> +static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
>
>I don't like that these are really *exactly* the same, except for the
>name but are defined so differently. I see three alternatives that are
>better:
>
>1. Open code *both* so they look the same
>2. Define a macro that both can use that has a seamldr_## prefix
>3. Move the code to a new file to avoid symbol conflicts.
>
>I'd honestly be fine with any of those.
>
>The other option is to just put the module information at the top
>directory so the sysfs name differentiates things.
>
>For real, how many things are going to be in the seamldr directory? If
>it's just two, is it worth having a directory?

Good question. There are two for this series, and I don't expect there will be
more soon.

The only reason to have a separate directory is that P-SEAMLDR is a different
component from the TDX module. But I think that's a bit weak. By renaming the
attribute to seamldr_version instead of version, there's no symbol conflict.

I will apply this incremental change:

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index f7221f2e5fec..1ace37b7f0e9 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -5,14 +5,14 @@ Description:	(RO) Report the version of the loaded TDX module. The TDX module
		"y" is the minor version and "z" is the update version. Versions
		are used for bug reporting, TDX module updates etc.
 
-What:		/sys/devices/faux/tdx_host/seamldr/version
+What:		/sys/devices/faux/tdx_host/seamldr_version
 Contact:	linux-coco@lists.linux.dev
 Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
		loader version is formatted as x.y.z, where "x" is the major
		version, "y" is the minor version and "z" is the update version.
		Versions are used for bug reporting and compatibility checks.
 
-What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
+What:		/sys/devices/faux/tdx_host/num_remaining_updates
 Contact:	linux-coco@lists.linux.dev
 Description:	(RO) Report the number of remaining updates. TDX maintains a
		log about each TDX module that has been loaded. This log has
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 5a672126f372..cd84108094cf 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -75,15 +75,7 @@ static ssize_t num_remaining_updates_show(struct device *dev,
	return sysfs_emit(buf, "%u\n", info.num_remaining_updates);
 }
 
-/*
- * Open-code DEVICE_ATTR_ADMIN_RO to specify a different 'show' function
- * for P-SEAMLDR version as version_show() is used for TDX module version.
- *
- * Admin-only readable as reading these attributes calls into P-SEAMLDR,
- * which may have potential performance and system impact.
- */
-static struct device_attribute dev_attr_seamldr_version =
-	__ATTR(version, 0400, seamldr_version_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(seamldr_version);
 static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
 
 static struct attribute *seamldr_attrs[] = {
@@ -105,7 +97,6 @@ static bool seamldr_group_visible(struct kobject *kobj)
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(seamldr);
 
 static const struct attribute_group seamldr_group = {
-	.name = "seamldr",
	.attrs = seamldr_attrs,
	.is_visible = SYSFS_GROUP_VISIBLE(seamldr),
 };


