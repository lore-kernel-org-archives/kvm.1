Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958E4A090C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775674; cv=fail; b=ZnXZtDCt2wqblF53UoIAWQ+RDRHHwY68buLE9LekTyLGafwEQ9rIyjoeMnYtBOZT2A7zqa8ChMFxL59YuTwE2oOdw8Cqz1HylnIG2hfeMfFdvPPnXTfUhBC7PXm6aEtPgdJdDKMpCIBYSSnSmgSDyA8ga22TvzZE6Ww9JVi+yw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775674; c=relaxed/simple;
	bh=DfaDh4RNrU+uRWKZAcvnoFJU1uxho35PkzaLlEj+fNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ltL/dVL7YXTNvvWQMbHPIao7uLQ+oBDU6XKFvIcHAyewZ4xq5+VItGgjLJ6iSlZ2YKKJNiIPkrsScKTS6JpAq8vnwE6fKjZRlImKSHlt4zir6+rFfat3Zbb0VGg7bWGXTRTrP/ASIfpds3KLOFcfCMpfKlRb26lFnlvxhtmX/Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUr9HqpP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUr9HqpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790775664; x=1822311664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DfaDh4RNrU+uRWKZAcvnoFJU1uxho35PkzaLlEj+fNE=;
  b=OUr9HqpPZGYqPh7neNCGlVPpV6Ab80h2K7igyTYNo2tTziw+oERHDTs/
   Y47Gpb/kkRvSQgh+k38d2lBCx3xpv4/UDaBNrW0rWWudQBPv7pi3e4quB
   Kjl/ytYV4dVQF7oHlweJURJ1kSw/gBlLrEPEvDv663XHl+P5aTYT6C0yM
   wwR1M0VdUC9gRCovoxXTaUmC/o6pwBrgZexyW60y4nJZ0/1YCB9cwVZur
   NEk7R3Zml8+mawCDVtzMK4G6vwaoqU+Rv0UvaK1Gj5XkoCOnkSkv8e/py
   aHfpeZsOtyosDoQniXl0eJ+LE0gDHUXFpE7yj7p1A22m54zhYyuCsjOUh
   Q==;
X-CSE-ConnectionGUID: jh07j66ISRK85BDCgS2UoQ==
X-CSE-MsgGUID: +0vyZh0cQ6+1pFQidmh6Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="113299741"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="113299741"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:40:59 -0700
X-CSE-ConnectionGUID: pSkY1F1pTw6aBrhCywXYMQ==
X-CSE-MsgGUID: cg0HRbx/TNOpfss92t22jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313624325"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:40:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 06:40:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 06:40:59 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 06:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seSBrhzdy/0/SwDJCNwl3WMBJVTkWmwpMCQ8iqz+SfPZJNgFN8/h2Ezt7JQtqBxfoMAN6+k/kjVQGkgYppOMIO7vfo5f9M4F6Laa54aOZopj0oIbAZP9HhiIjDxYePqoJjaLjIMZ/MwW6P5ClkWx3RHdNR3p63Q8JEE0hjUZAqbEz1k/GiGGeJGH54ABxtWLWtJkDh8z1bQsJxvAwqrYyPDZycQi6qbmjzMNa7S04zIg1FHOdBx9Fw+8TN5vJv/VzkFg1n4F4MSFIjaLvkA7s0QI1Mn/g2hgLCh2a8xsQ2yiD1piAblI5wZFUSn3BhRbPW64cC8Wu+RAhM4MlIf53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVcWH8osukxhr3oPRrmga9Sx3bOSNIJxp+uVF4LWsj0=;
 b=SGkFmHIxeV33URB1WQVA9X4aeyPNvno75EpR3tXk+mAYr+4VkRRyJ7fek4E/3RUMsZZfFjhxFReOBvecbB2mupMmLa7vQgNCo/BCONMwdzhn8UOlDLn7kzq5H/V6O7rT8GGSR6aV8kd35VytjdHbuGiRAXqRQ50b7WznPoqouEUSRt8NOcF27tVGWHl121g0Dk9aDaq29c9YMKeFYtEN5XR3zk7zpVWaBaclpHIITOM+1bNMP7hRipD0i4B1PbTB/mHFLXNvcwchPAwUKlGnO6KmEfAeLmj9QrARX4jQGRU3sAhwqNcXdQJ9y76PWvpgaImboSFwTtXAphkjM2Gpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by SA2PR11MB4987.namprd11.prod.outlook.com
 (2603:10b6:806:113::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 13:40:56 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 13:40:56 +0000
Date: Wed, 30 Sep 2026 06:40:39 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] virt: tdx-guest: Make the Quote buffer size
 dynamic
Message-ID: <ar0RVyfvEGykm0_u@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
 <20260930103739.2851980-7-peter.fang@intel.com>
 <20260930104949.8677A1F00893@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930104949.8677A1F00893@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|SA2PR11MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: a37abf25-5c4b-49e9-fe04-08df1ef8741e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|22082099003|10067099003|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Ca9bV+CoiSfv0xE+jvt0bDKDGGMO69bjOVrPwAf5Lax4chrn4AjmB8gYTK8xH0ldd55b4mjMp/4ZltKKztYDFwery8ojMn5Wuwjt1w/AhDteAmW6QbckSBJPb88DEKsbpCHS6uzEM5FAm6L7yUAhrUTSKy/zxrAijjsg0xBlFwHFRRztX0C5NT7E6VlaTogEmktzNxsCp4ioLvsnT0sfSvLdnUoGZjgOuDlua3jc7XbMq4mm+5aTb6UCeg01wrojwCxfP6PmsXNz0DKHLc+5c/A+ll5hlFkoIz4YijwPwGNjxyYcDnnxyGqzAeozvytq46zPZPgEzoN8X3aogH0UTWIgZcBTKdawhdb3gTeOQSTMxDVidF+A5iVCtQQr6o6sLWGrR8peBPcq1iYxy7jwqb9viQcr00KdkdQ92bpdqI3gOkQuNhNGZeTTtknp4aOca1ekEQZkTGSYlJIIFVlYylUCzlllIyBbBKYYVxeftpQJ4OaITQQl4F2TmTBKV3O+NBds7xDAqRXEkKq+XlsbB6Up3yyVU6MqTIlNriIuQmuUXYHhzsWQ1RntksY4N1va9+jo7rqQ8xZ00L8YGsSXIEpeefVDnfPeZJDcq3riCY4inkuu668xUtDYdKEN85AZk0VWLkBPQCx0LKuqoq2O9QNEDJQqKFCzowCx24TLgiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(22082099003)(10067099003)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EF68LfRQbsarPtErLmeTveEt7aw0WTbHxV2FP4C4zRx5uIwgwov3KHQB0YU?=
 =?us-ascii?Q?As/JmUf+/7eAyShV7h7JVGlbX6Fh43806b/0sPOWzuY5zeHMCZIiG5y7rxAD?=
 =?us-ascii?Q?yHuf+Rt4A+ksn2EFyTklMNnB4hI2ehR7Y2uoc90k4kyG0ULs6OTOoZWEtowu?=
 =?us-ascii?Q?VInK+U/31unkIAe5ItMqIcuJKS2KLIhIE6Pnfdi+iC26I8vSRV7kiMkpfvnm?=
 =?us-ascii?Q?gClOerIfbWRKf3QhMMm1cBfbwd4cGWOj3g7nNTLNL9JATwr0vRVkjSKEfZQ0?=
 =?us-ascii?Q?I+veJgkJN8uW9U7dfvFUrmIVzpwXMJqx8Ascl92Buvn7X544sUF29987Y2E1?=
 =?us-ascii?Q?jN2fS/7G/8B/c2oPMbKakVVITIRgfM0Kwzsh+KLTfNl1SyxjwtZrzVSpJmCY?=
 =?us-ascii?Q?fs86NR1dJsA5j27Vw8ETVoHTk0xnXG8G2nqjWyvm+oc5p/iqpOygEGWrUCx1?=
 =?us-ascii?Q?FxZOLbpCD4UJFfe/ZABxSmokyiOA8gtg7ZJLO5MIXDsRPvVCtCRDOSIB/VSl?=
 =?us-ascii?Q?+18B15Qr1qPZhYrLbVX/UjZsRlEapsOXkF+wp9elKEYwhfJpGBkvCZN51+ia?=
 =?us-ascii?Q?Z+oUClulMRm2B+VrijoWd4+ghyxap+avyaO1s1XUJYeRDUVhf0Gfb6mqekmK?=
 =?us-ascii?Q?WVV420pqtZ6LnNDbRMkQPVP9+o9b8Yeb5s8LSm9q+djeX6E6gsABHbSlJzz5?=
 =?us-ascii?Q?2nGDJTy2uoCRk36cMYsq9cqyjeS+Xo3FidVhL5jcXVRtSfMbgSmB/Pn01wt+?=
 =?us-ascii?Q?Ugr11y6bKKzGDXd8LlWzF9Pd9k/thi2tMfP2H2nb7Zk4Qlrlo+oj0rgmb96u?=
 =?us-ascii?Q?leH85TKVnHiLSWaQeCuLBhEfuuBlXEvoEx5YdaWM9bk+ICPrZ0qZA4G0C1bV?=
 =?us-ascii?Q?0Vfi/+JZ7Eklnx7h3R+sO9CNoaSg7Hxqw3yowL+RsItWgzESDi7BMcnasSXy?=
 =?us-ascii?Q?ovKQ4/JE7vXPKJ8kk0+A/hMBYtJwKpD65xHjMwQ9LWoiU9KZwy/KINiZwzm/?=
 =?us-ascii?Q?HNQhoUIqYNMF6lGBj6g03xrHDdqDp90+jDiCSGrljUem+d5w0g24edv589u/?=
 =?us-ascii?Q?YTtP4wah0siE9ipoWeQo0nDOaN2EMWTSYYIW5U2IOpv0Hpk9Bjv+3apw1xYH?=
 =?us-ascii?Q?lU0g1njde6KGk4jS9c2USwe8mCjQUfOC5kDBLx+kLOeMY6Z2ZsGMRB+t4n8E?=
 =?us-ascii?Q?mS3d4URuP3sHFAPKAhCZmggfHfJLm1f7DZLwnTB5Gbt37pyh2x5rcR+HpL8X?=
 =?us-ascii?Q?Y2Ik8FsdO5CpiZsyxuYVJ7GRzY4MG4B0o7vrRMc2d6SDdjzSrkXclU9DMl+B?=
 =?us-ascii?Q?R4bk6A9POLyRCRxantOKZQ/qaaiAvTf0AhJJPaLmB5ZHbpXckAo9zxkEIBWY?=
 =?us-ascii?Q?sMDE56X9ugftzB7/sowNF4cMAvx5cXa+nm+ra4lETfJ8mUOv1rwYI2m7zCUJ?=
 =?us-ascii?Q?LiDZKyWso7ZCkmLPaPO9CkLjDSgQogZQPK1GUyWdn26b61uCLvj32E0lMUn7?=
 =?us-ascii?Q?e6uvBrYNHRXxQm6j9pBgV6CJ1gmNjIjI4RR47nSQTyiri2l9Cd37+aqVtOOh?=
 =?us-ascii?Q?INGnOT7AeO6tZ0EyjONO95AqJZT67jPQ3J5jigHiSFGHkEWdPZWudZTHQNNc?=
 =?us-ascii?Q?DJl8rMOZTsgRB76VEa83Jl3ldBH8BNIF9dvKf4okeYRho0VYFnPi3CL7/qSL?=
 =?us-ascii?Q?7jqhlED3JiidtFR4IXxzZEonVbY4oYdNqg7yBCVk2X1okNMEJVgN0FtDiNcY?=
 =?us-ascii?Q?dttWEt8WPg=3D=3D?=
X-Exchange-RoutingPolicyChecked: LyDud/auHV55Qxvd9BwGqdRourbYDXENs/Edo2bgBEa8EWz9os3NIz4JGdTOF0Uv198r6mJ11O0EF2/oMmNBy7/uIqxkJ9i2bSg8yo0Wfy/LmYeasUa3YAjkxwEHEtZYsN0GITAYFQLfGoO4wOukAV3E0CCgYeeWFGH0PTToOKHSHfCuQ/aPXM+NcXmxeRA5f7K002KnVr3c54pSP631qsQFLz4QtOWZ6tY2s5P+rmGwSvetjAACOYNWw86rvw9yLtDRsZcfXJBOAaupwFtHCrXmUv1k7bDeHLk4zQGKS6gsJ8d7b00PWlPz0LrG+ojse8hokcIosZi25seJuHUsjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a37abf25-5c4b-49e9-fe04-08df1ef8741e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:40:55.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Igy4rtVN594HXJAtO9ME70R+bWJTH4vUjFGDhFc1wCzgsosCxCL82FI3JgWM5iCSbkMDU7gi29J6rNA5se1lsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 10:49:49AM +0000, sashiko-bot@kernel.org wrote:
> 
> [Severity: High]
> Can this dynamic evaluation cause an out-of-bounds write or buddy allocator
> corruption?
> 
> If tdx_get_max_quote_size() fails transiently during initialization when
> alloc_quote_buf() is called, get_quote_buf_size() will return the default
> size, and alloc_pages_exact() will allocate a buffer of that size.

Hmm, I don't think TDX code usually handles "fails transiently" on
SEAMCALLs/TDCALLs. Like mentioned in [1], if attestation fails the TD is
functionally dead.

[1] https://lore.kernel.org/all/amCv00f5Q6QlztyY@thinkstation/

> 
> If a subsequent userspace request triggers tdx_report_new_locked(), and the
> size query succeeds this time returning a larger size, could the driver write
> past the end of the allocation?
> 
