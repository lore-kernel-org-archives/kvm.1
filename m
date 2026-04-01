Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6313630B8;
	Wed,  1 Apr 2026 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013065; cv=fail; b=aK6wRAblwOwB+9SkUBn7ZPbObQqozeEq8jMrMRUdu1j9sOSWrS0x7LiJXlU2TmpMeYtrWyA0zBv+HVTmuQCa8MaIQpRb6gI2MtxXgZVoIXV+TdRMlS7yaMydBBF/lXPmpcpJI9kbtVlZ5t0YueeNoCWOKrTar0KM/lA4D5lgdPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013065; c=relaxed/simple;
	bh=PcxW4f8anwLcuvdbu2Mp5TemNZCZKfPbIM79Z+ieAZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kZk72C9DqZrWokCC4NZ4pQFIYYv8eTotLqId2xWQIRUzae7zeVkZ3bibzXJdke8aBU3D6l6ktxMwiPQ50Wg2bCcNYXgharQvfoO+dVDhCv8hhkh58IdlAl5Y3wylBByVz45xU7ktgPf1UL+hq8+dYAVKEG37JOrPhEB3hMxIamY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgEHqEb7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgEHqEb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775013062; x=1806549062;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PcxW4f8anwLcuvdbu2Mp5TemNZCZKfPbIM79Z+ieAZU=;
  b=DgEHqEb7Cdbpz2JXQoIiQM0Cs9yjz2VxAFoglMpL1AQX5yh8jSq9VJEF
   H/KwWvYgjDDR5zNDM5FHNkLYyXfCfl2hRZP79u6u2o/jxSC3ghdV4sOuj
   QJVZK1fNuG4t82JA97SAawUNQ77ODumhDN+jmAp9oaRKGlSLIJ02b9zVU
   hOoKQZkapGHClztqOIBzcBWdV2pxac7qYbChj6HyXhcCs5bj7vC4DUOz3
   iapxFI9lvMk0/F3OpF81LfSpqwstLkUklUmAvBFW5mOe5dYlAuAhqEQN5
   g+ksLNVNm6gDBVl6ZsYbxdPyL97GaEtEBW6EijCFao4RUiH+SAGzACciI
   A==;
X-CSE-ConnectionGUID: 6cmSaMGtQ5yVajG8Xd2/0A==
X-CSE-MsgGUID: Wb+mi2CnQVKsLlb82L+6Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63592751"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="63592751"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:11:01 -0700
X-CSE-ConnectionGUID: VyVRWkgZQ6eTbFZnFxBSMg==
X-CSE-MsgGUID: Tehl1JFPSTWxpj5tAHkaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249764222"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 20:11:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:11:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 20:11:01 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTk6bAwkhtSHueLx78phx6y/wnC4b5+cmj687cds7wUOk7IYrKO0At8kaDmdIqGytCL9wbQgRQWB+WjJfQaIqsnyz9p0aOxz4qupDmtL5WsCro2fqftq4jRkZ6kWtz0UKS9EFLrifxgDsWDsatWNMipzjzZwmDCo8CYtg4h0CiNPSx01JmVnVDWfFT84aaIIp1E6oMiuQ7GIJ0h6hChVzWHFlInaan7fwXvFi6BcUZ6h+pOwUklZB6lBV9+Ugd89B5Fs6SyZ9Fb8Ofz/ivv1LmIR4lg4smKcrMFOLukimP0O4SGpwNC9/wrlAGyXYtXWLIQAqqjJ//w9ONUKnk4dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCnKGWcBsd2KhEgQxnVrEfnQOQE6fU/nQzMNjKodFJs=;
 b=myBmltQrdkHvzrPiooE4B0hlQjbYjxVGxw6DeC5BJbLiJWAdpjLJeHumi5dADgDQ4f+exzWJmi0qtLrW9CF4/2XHY8Z7PTtDoAY/yfmHEWFNCVZA+G9b2fr/27/Kq4fIgX2JgBe1fESkPS5H/afgKrEzfCPJLJm6ve0NZextOUOl27aBgaLVj4wh43OUXvNfCjY1SDqBNOzMRKdEYtIgAnokuVy8F0x/l+lKhJ4gruREIxNCE8D2dfWBUQrLJ990DcsRJ0cBwtAdEz9pJIcRDykBF0YJ0uG2WDILjg6aB/dNhgivoJkILGwzlj2Ilzy1mH9qRJxHNDdqGKPA1Ho3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 03:10:58 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 03:10:57 +0000
Date: Wed, 1 Apr 2026 11:10:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <acyMqqs6zvXG1LaA@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-8-chao.gao@intel.com>
 <2efa9f58-af65-4e77-9667-f66dc48a61c7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2efa9f58-af65-4e77-9667-f66dc48a61c7@intel.com>
X-ClientProxiedBy: KU0P306CA0029.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::12) To LV8PR11MB8680.namprd11.prod.outlook.com
 (2603:10b6:408:208::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ0PR11MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df2e9eb-cfd8-4e6d-7b41-08de8f9c4ae4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: E/gmTx0XXYarNid1RLupPyF8zx4JvnQa0J5JteTXS07scq1MzohLoE+iXj+5RI5HFhpWJlwg5TBA0w0Ymc2oXS8dyGT07d0Rkch1x3DIgY8oECpAVfFT8HaxsWTfGDj5UlQm4UoPMyE2JZU9oPL7QER1ChJet4zjJ57UkwGXyS4qQrb8cF1SPPvH4oj0HNkMvQGlh8WaKnqfNytkxqwbGML1FRRNca91hNesHRMa0lq0VmtcAUcNrgU1phC60Nn26IbtGghP8aM2FzFIUXZaBVInG+AQTlu3j6Dxmo/+291cSYWQ0nci49ObvqtxwJdWnzCo9LX6ZjOen5jhcisFKmgO5ffAGr+BiYear3oq60sKnD/eKYZ//iEkMqdVCEVtkjmTNGKCHXfAInwtkJMbNZ3/EbG3JptZpgbRBwbAFUVcCQAEp/ENszu502n+YOhWMMYtfqNnXuu7LPxUd60K07cmq2WY4DW0A5DgewD9B45i11xsvT2TwHQYWeLnomnJvV61RIYZWRFEGJE/YRYbqlhb/3wUNCd66CRoNtovnDme9pb0sPYbXpCWKz2m9f7DO7M4wtUg0zJyYZLQWMnBr9zg6VJhjl/MbDNoLgTvp9GB9+j4EAWjm35hPwTuFduYwPTIyLefhM4IIsFGMYEuZ9AmwVdY1ZFjkNmSQH36rQ3Ld5XWXEKb2dmX73Ow8KlJoyGkQ8OH1mnqtVG/BuMAMc4mYJiEoQobsk7PbL8rnbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4gGbiWfvI6HYJ03CTuqOTkEPKbX7I1WN1HO6mwGhH36YjpmoQhQW87Qrwl8?=
 =?us-ascii?Q?BoAG4uK+Alxd7EuYXpEJFTm0xAOsFjza3J/EimnwmcYyEtabyUSVgBXf1w90?=
 =?us-ascii?Q?ovTZzViBJDKx5jGDPLLfWJmVKmVwRpZLNTh0LBxO+HtwvW4BXdPjdde8hILC?=
 =?us-ascii?Q?dUB/V4WDWsXRE87Fw5b3foVu53zgeXNkz+kmpAIx2dCR64/bmWr1iLHUO4Eu?=
 =?us-ascii?Q?M5Nuk27pcqvMgHIP48K6nqvo649idY9OxZ4NGgRb1BE7MTrq41JV2f2k59Hl?=
 =?us-ascii?Q?2N8ETA3PSMMp7uFIVgeL/5eF6Vb/tkI11yx0hHXe5TPFURZiNlCJQE+yhSLP?=
 =?us-ascii?Q?S5ob/3BiGND9JmDulCrna/GqTQ0j6JrmOKd9VOp/TVVO9F99So32tUF6GLXq?=
 =?us-ascii?Q?X0rl00P6AL7C7zSdQUe24uMrv0CH83P4nfanVNYuCnFqMo6Q/MytxFi8O7V3?=
 =?us-ascii?Q?6YIL31dJwx8Im7zLdoyMtV6F2uWMlJcT1pIvNQWKJKKPJa9+dKPdEXHdeiZw?=
 =?us-ascii?Q?THvpzvg6tFEJ2h0QySoHYxhjFIs5xMnS3AbW+fBwKlXt8+94DauRwuiexe9q?=
 =?us-ascii?Q?ZKVuhKKW0wXx5rMqLcKAihcGchd5xJfuc7HZWkuLqI2QsepGP63z/zhLAAW5?=
 =?us-ascii?Q?re7kqO5+vNUOl31PzoEfWfCz3WZQMolgRz98C1fSFTQ3oP9PrvVk+Gc1fldD?=
 =?us-ascii?Q?YsnFO/ESbx1tUuAlZX7r8TNeKxgnvkMgkIS8TsJpAYFItUcJlIWKDXq5uFg3?=
 =?us-ascii?Q?oTxG/f/nQ4GMneaHZINeeAeiEJHqKVP6cMR9WB9JfUnPteIb1tIj8mbDZ/0G?=
 =?us-ascii?Q?HVo1jiLTwuk69vgY3potJWveEarXaAeEtYWuv7c7DSmo2MzDkTAPvuSlXE//?=
 =?us-ascii?Q?e4tbmGJTEHwRBB8117VqKC5kZnjd22tV0mIIaAnBl8Y4irOrPTusTC8qlFDA?=
 =?us-ascii?Q?EyK+1YF57vDcP+rTuFXG8Gas4hhLP/O3+3FzHdONy/qnDcI+/7peTQDZd1Rc?=
 =?us-ascii?Q?umRcCFI7hWh7ltbZkyVJMXQgPCZvET4s9yrgkhk02uplvFiAULlUeNlbxaG9?=
 =?us-ascii?Q?S5/P+t7lRbZ/LOvgZmHiluNBbGYJNSpoM7W2AjPXd1C5SEAKmzMPxJtEie0u?=
 =?us-ascii?Q?Bdgy6sCQKXf3yTGuisEhtzhgvfYY6QPif4AN5hh6arXaeXXEcXmfUd8TGvRZ?=
 =?us-ascii?Q?9Ugiv4m9IINm6nOla5aRKqgEPxXEzC2bu9POE13xvxoeYD39LjyTl5zRjCJT?=
 =?us-ascii?Q?J0DCjl4G1gctI0OXbcnZZulyaN6Mh2EqvDYs7HmtVuPg0YmkoQoXdltTrXOt?=
 =?us-ascii?Q?ml2Sm7u+pguiSekbxHovkXRxr3Odk1a7nJX6mx4e3LmDf82AgsmH4yEWS5HP?=
 =?us-ascii?Q?S+Ud4gYHT6vXKnz+WsiSxAICDvGq82JdcThQ4ni8C7ki5Jhu1YoE6d8Idyst?=
 =?us-ascii?Q?x/DBsDWq6iEn0tdQXpXOCrkYgzbm4Rw8wqNmbw/E412J0oHE7DGf/6OIHdKr?=
 =?us-ascii?Q?KfHpgn9q1wYLWTycuYxHKIL9V9OdiGuxHfCTne0QPv0F6Wcn0ZNtklRAm76l?=
 =?us-ascii?Q?cVbLvjZ9oCuDghIBeQFTn5NHXbO40djiqHYM/LTf7qBOxtI4MtouK5LALHiD?=
 =?us-ascii?Q?wopasC/a9fFNNIParg3YbFhbDRikYoLmoyyRC8JQc7syf6kX5AJorDTWWJ96?=
 =?us-ascii?Q?9z/2kts6AAQyGrGAP8SQ+youbjvEbZVV40eJ+EbmnlxVElKylu9s7JUQpg1k?=
 =?us-ascii?Q?fCAWEZOyrA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QMZgEv3pBjJzrjfNeh4R+BGtl05u3QC9/VwX/mUq2sWiTR1pknY/C//pTO3cBf30crFToBp1EybN/voLWTbRMBukAMj7WWeMRpMNs+/OUnQA7Zklbf4GrIxtbna4n0lXOUFXrJcQM05U56bBUGzIP2OOybjCik4T+5S9Wp1mYGVtuAk2XnBk67thaje6aUShMc+VxDrTKrTxSBZxM3rLBact5klhXRe7s2I7QXzb+52bi07JdnCY6/zmZ6UYkydSayPUB6zO+iDxFh8SBvj66XpMaieinToMr6y6aONfVHUSp8E4e17RZI+teOOrrMGC7aU5eKttG9Ietie8AICQSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df2e9eb-cfd8-4e6d-7b41-08de8f9c4ae4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8680.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 03:10:57.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIweaYgcNvTLPPEo4PYYwFlivvtwMCOgP99nWiC5geRm8c0DhtmeHYxNbFMSIUSTdomETp8hz+6je1Lk/hOL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 08:04:19AM -0700, Dave Hansen wrote:
>On 3/31/26 05:41, Chao Gao wrote:
>> +static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
>> +				       u32 offset, u32 size, u32 *written)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * tdx_fw_write() always processes all data on the first call with
>> +	 * offset == 0. Since it never returns partial success (it either
>> +	 * succeeds completely or fails), there is no subsequent call with
>> +	 * non-zero offsets.
>> +	 */
>> +	WARN_ON_ONCE(offset);
>
>How would this non-zero offset be triggered? Wouldn't it take a bug in
>the firmware upload code?

Yes, a bug in firmware upload code or tdx_fw_write() returns partial success.

>If so, why bother? It's not like something bad
>happens here.

the comment and WARN() was added to explain why @offset isn't used at all
in this function. But if you feel this detail is obvious or doesn't help
readability, let's drop it.
