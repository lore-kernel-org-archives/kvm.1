Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9C30DD1B;
	Wed,  2 Sep 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371000; cv=fail; b=jgiGUDlZ5OAdx9f9GrS7zFRv8PxCU54fDFDSYT2kd9w3E7XtftW2oGTmJ70ohK/Y9SPz0QolxVP13xQ0FP/B+auP0ofEDl0cwVOky5NE+gjCZfz0SyySyugH7Ltf98xiRw6NAfwPzSy+qbyqokA4hNQ5wcDCDZzSX6jK/05Ll5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371000; c=relaxed/simple;
	bh=aSj2FrfjcZ7K8SFyJCD1GfKBgaLVPM7QvZwbcgvze1E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmCDH1CNxyR4MYyX/ffjD6g0cZKmStLFJlxUD/hwYaRv70vezoz2oGO97p0WxDHCS3FzKsV3/ATINNDkXHxJ0glYrMX9SM9iKmHJHDDK+RpAWS6tBVEUDteHOITSS7Cc4otZNG3lyOng2YGFg7lw0b3kR6EP9oKHbzgBtvDA4PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg5rjhos; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg5rjhos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788370998; x=1819906998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aSj2FrfjcZ7K8SFyJCD1GfKBgaLVPM7QvZwbcgvze1E=;
  b=Lg5rjhosaHkIJzyZxWS22RBvW6la8i26j2sgsBaI0+tLsw/YRmrN1mBm
   r6OpYeoc9yYfnms2bwGGxG/TZ+/Sr29GBRShQCRmrjRlacG0pDtXllL6w
   s+Vvj1YyH4y3dtvwuo/pIHWa8N3Fgk8mz2E1s/hXlFFTlPr7LnjsfnYD7
   bM9mx6vUXdP7GSSX3NXN/YyyTOdMkuOSvOx4+pKa9cWK+vXiOqRyDpFAG
   pg33AlcU5gebriAP752IcxCfbJlczxlL0O0zZwRS1PRJYdWiKNoeuJcp3
   5Jr6oO4Ye+SfQ79y8o6LyKYzEomfeoLaG2k+5WI5VH9yz2kKpTaVx7+hZ
   g==;
X-CSE-ConnectionGUID: idDkMGzYTZWMYpiXrgrQBA==
X-CSE-MsgGUID: LO8imfMNQBy/yU84RW8TVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100000138"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100000138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:43:17 -0700
X-CSE-ConnectionGUID: XDlUbs0NSJ6qYJaQntRwcg==
X-CSE-MsgGUID: x/SdNNQKQzuG4FyjkjWd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273635616"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:43:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:43:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 10:43:16 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXGgqFa0n4WZ/EcDRI1pMu775Mo0Jh5wPt8ujgkbEX9Q7Ja3ydGLp8W2G4jpB3d/5iiUCW3YAYTxlMN/vUjDrBTfdymhDHxDeUTRwFJGnlh5tpcJpaGNQy5qyxFAV6ixKzRS0B87sDdPU0F5H19bMBKk0suBfWGVkIu+00fDCNf7CnVcoU60CbV6TIeGbfr1rH4lLnS55RCJb6GQVm5OlLI2QfYR61ZLZFfRLoAJWN75ZPZlgRycHeZ9EbDAkz2W0QjXJWTLoef7IQ/wz1+Fp3IDlMKRf+bIj49iLsP6fEjtleskoN/tXf9g8Xsuwf4aFv2H8ecSUQKcvMj4FGm5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iGKexsKBiwjeIdQ3dqjEmCwUOGcekxxlCciwnmIgec=;
 b=YEeTVUWyuxO88PZ3evDLYNnGGoL/GXPDHm7GYGjfRGEqPbFxOAUG3b+BdrptQIrlAFOwLqxODUWVTHl9ub8O7OqZCDWqQhgWDT3CzidRtCi0TzM++LyKgI1FYet9yCN9LRwxkWzAlwPy0gYv5t1n8XWHGuxHz6KLhCJBK90XIhEVtkjM6CK+53JxGCvmXXCAfeyrd5wV+F/Zuw8hnVotgvELKUcv1IjlElDGP0eyPEx5TGjbZuWrkQK7Ef9AgdkeI1HAxOASKVvv9UTMffXCnJepsXhbUtwaw1XiMR41HBPkrl8/QrBAe0yx4SIP4cvVk1/unBEN2sapXH9JXhP9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 17:43:12 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 17:43:12 +0000
Message-ID: <73beeef9-3ecf-49fc-87e3-6fa30f8f56d3@intel.com>
Date: Wed, 2 Sep 2026 10:43:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: Binbin Wu <binbin.wu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>, <chao.gao@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-3-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260827031837.2863609-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c75483-4a07-4fe4-b071-08df0919a897
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gk16Sk9XwJD0stKGO/I2oz7EaSKulEjwmoF8nAQr4j0wDpwOOEvvtcwgXoz+gKsx9sTBtGapQfl9V7MRsgdtFyk2i8iLHtJBTsG+a4IdnLWm0B/vjgeuFeJYaeQD4eNiahzrVWuhF3CV6XGSBhUDeomfmL8ETcNkG/plccTXsQtQwRLcITcgVlICu9SYSdjm4K9QwFr93DxqSGwzvqKuPR6u/hm2ycsVSbULBB4gYu+GayQcm9iB8iNRIIoPg1HlZn+gb6IRTz65R71mc7ZGzH54gYxpivhsgnovLZMB99NicpHs4Jbez1oA9CfcypQVQDsp5/YpLNNX/AcyCTjm05mI43zhKM65/80Uvj9MoZ3CFcFedXfYVFinor0Btez+9yPD+r/Ps7WN3nJuTDOfxxMolybWmVvV2u5hu/o5hnp18IWqkYmD6Dg4oQkn4TBgIAm+ZCEFHiVzBb2NxLndlT5osl2wLG0EoPH3o6Wt7oslmY95t3zwamT2GhZ4sdP7n7IC1UUny2HTXfjxhGvI85XYZ7KY7tQ4KIrYYZAdTS5fyEUlE2aBJglltnOIDHiAFJfnEo5fbSd4mPu7rg9hcH61iyzGuiB1nDkczVvQDU/VL3YDwkLxNcrZYrqcnAyBOk1nVCF32LFqyLgB3Rlh2JTAG08wrz/tZYgW/RIChnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFGKytQYWhyT0QzN0VsYndtU3g5cWcvdC9UT1NaN1hnZFJpN3p0d3lMU2JS?=
 =?utf-8?B?MTVwVHhWbzlmczB2dVVmWmJYT1lwSlVNWWVYcE9uMTJQZkdIVjQ0VjV2eDJL?=
 =?utf-8?B?R0gzcDNYc1dEVm9yOVlFUll0SW5RYTV0bDg1OElkWjZpTUlPZzNpNzcxcHJN?=
 =?utf-8?B?S2U5TXdwem52dTYwTTNVTVovYjA4N3pXamdycFJZV2dCQ2krc2ZXekhlN0ty?=
 =?utf-8?B?amFpVXhsNGpTbkswL01nUG0ySVBvdzEzR3BBN1NYZ1JFNnNqeDVLQnUvVGR2?=
 =?utf-8?B?SmlpL0FKMXFuOGJycEhKOXJVN2dOSnJOeEJZYkdZVDE2TFh4eHo3VlBFQ1Nz?=
 =?utf-8?B?YW5JVlVhWk5BZ0FLQ1pHWWt0WGg0dEVBcDZCTmw5QUszYmkraVBLYXVqRnRP?=
 =?utf-8?B?bHJ0dzF5akFaa0hXZEdwWXJuYU56ZVpGZElWTGE5c0s1S2NRK1RWdkZ4aGp5?=
 =?utf-8?B?c2twV05GL0tLYmppNnJFR0NYeDZjR0JiZStHNlVWaVpKWkFldmc3cW1DK1lz?=
 =?utf-8?B?azhsbXhRQ3RpR1IrTi9kT1NGdkpBdXlvdDdzcjhkbkszSUhQUW5zUHYvZ2dW?=
 =?utf-8?B?eWduWTdPZFBKYlRGdUNaWTdVYnZKQ2xRRWVybXhNcTlkZFpRMExQaUxqRU9n?=
 =?utf-8?B?ZSs0d0ZlRDVMNC9tMVNWaFNxTjMya2NrdG1KeEdsdHkvemxKWWZjWmpVOVdi?=
 =?utf-8?B?Y0JUTDc1Z3RJZzc2N3R6WU1adlNveEhLbE9vUGpGbjYvMm04d1YvbHlueUwx?=
 =?utf-8?B?elY4RWZPRHBwTG9iNnpuM1haRW5Od0licllhSXJKM2V4RUw2VWpxZjUzTEgy?=
 =?utf-8?B?OXpNcnNQNWRYUmYrVHY5QUJUaWZPR1BvbUNiKzZZZlk4VHhPMVJNK25XQUFs?=
 =?utf-8?B?UDlLR3BxZGpjZzRtVmtCTWEremkzUlIzRUNuSmNCRXB5VzVKRDNra2NuRDhv?=
 =?utf-8?B?SHBXNGlsMmRrYmpYVXNvNHlpVzhuTmM5U2prckg4c1dPZVFWVWcvblhpTCta?=
 =?utf-8?B?aCtsQlUwb0N0ZmZDYzhZT0dhNkRRdUxPRzlBR1dRMzllWnZxVW96dkJ0L3N4?=
 =?utf-8?B?OUo3d2lCS2U0eUhidjZZeXhVUWJYdnRlaGtOU1prTkJFNnZMamYwcmxlay9Z?=
 =?utf-8?B?cC9BRE1xd0hSeWJmVlowQkdxRjhuamRmWnRsNm5lV0NTSXh5WWNNT1JhT0tC?=
 =?utf-8?B?RlhtMXQ2RHRic3luc1poZENab1pLL3g1RTUzUUJ3aHRVTGk0VGRUek5JcUU4?=
 =?utf-8?B?U2hxdFJrMUpZZU80Vnh3SnhDSm02NzF5VmJDL3ZEZTZpdFNFeFlYSUR0OCtu?=
 =?utf-8?B?L05kalZTeE9FYXRoem1wWUJSbWVUZGw1YkF5MzB3ZDhGUkdOY3E4TDUvTjI4?=
 =?utf-8?B?VDVqeExnQ3FrYXJvZU9pUm9ZZkxPbWVybDlWcjBjeTNEWG1BaFBsYXA2SzVS?=
 =?utf-8?B?L3ZjZkhrRlBycmRDNGNvOXA0UUcrbUhFY25ES2VnS250dnBGelFwdUloQTJM?=
 =?utf-8?B?OEdJWHpUWExiazJUbjVOb2x2R2cwUWVnNmtaSVhkcmxSRU83TjBUSTdmVzRK?=
 =?utf-8?B?YXZqcUFQSGhQMkZMU0dsb2JUUkFiU2NUVnFMN0xHVUg4enNQVjRQYXZxNmxC?=
 =?utf-8?B?ZDJUeUxRMUs1d3U0YytZdk5jSTh0K3Q5OHJxeGF2eCtBeFpZcGhkcmNqSDFC?=
 =?utf-8?B?UFBwb1RPUWFreUpqNm1HOEpGNkxHQ2Q2ejJtcElmTmw5V2lhWkNzZUZOVWpp?=
 =?utf-8?B?aE5ub3ZabDNzeitFLzZxWEhWYjhvRXVGa05IYWdCc0g0bENibnB6YzVPai84?=
 =?utf-8?B?bXBEN0owcGJrRXhIK2Q1L1pNV0tNU0xSUmxSUW11YTBXWnd0QmdIZFlHK0VS?=
 =?utf-8?B?OE1WQWhVNjFwT0cydDhROGdLV0pLbmZVZUo5bVNRRkxRZTdtVGdOQlVLUG9J?=
 =?utf-8?B?RXc2WS8vSXFDeS9GK2RwSjB0WkdUREFIMTQ0YzI0SkhiUXZIL0M2SisxK0Nn?=
 =?utf-8?B?YWFQN2hkZGNRamcyMUNQYlBIMVJSeG5zelRQL2xWbm16dnNmaWo0V2MwdTJX?=
 =?utf-8?B?ais3Y2dPMmJjeFpaSjdUcGsvcHExMWlvWUV3V2xnYVNFM1pSRTdrUUlNR1Nx?=
 =?utf-8?B?VXhtTlJETFhQNUdlMDZPTjJObFdyRVp1TWQzS0hXRHQ1eDVWSHB1TU1pblh2?=
 =?utf-8?B?SXhDSkZaN3VsK0FQYnV2YmxyN0pGTER5ZVVtVHlhVGRFMitEY1BsZnRFVjEw?=
 =?utf-8?B?Zmt0elBNN3NHVmtTWlUwVjBNZm8yNzRPSWhjWGJwblgzcGYrL1RHWW90NkJS?=
 =?utf-8?B?cW5Hd2VySUhOUjZPNUpXR3JRN3pDVnh5dmtBY084WU15WTBXYVMyUT09?=
X-Exchange-RoutingPolicyChecked: OzfjPE+o03SFtO4LZhZ5TFwzGXzCWOXIDHca5fpGmcfubxWXLk1xSnlpLr6K5PjCDcD+F+R+a5zHWM1R+p9/g1TeJ3pklLH0DujgzzVpiJhPMR28bV5R78WEBGU+l7/EIkfp+zlSU2yHcNxUF7S5vx05Pba4viAGBAdcXaTswhgNyOG1lLtesqnRivufdp+/PfUycH6MvBEpdD+uZP3esl9YYARjk+yKSl5dsyOZ7iivhoTYHT87n/lc2OLmNuiV0ebHStEohZ/JInp2I1W/5o1vbfPS1f6ZIGPE2+NaQWAWzUkVMHAb0eCeEZtnEyTS7TyiuAaKWTFzIuMPSuX57A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c75483-4a07-4fe4-b071-08df0919a897
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 17:43:11.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKMq9xkIT1IiURYpNUrTZq/UCpcM9/srgu9Gv1vfypKrfA+8fx5K1A3VUBIYuc8sFhh+jhIYxM/ew00h8OFbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com

On 8/26/26 8:18 PM, Binbin Wu wrote:
> Reporting CORE_CAPABILITIES as configurable keeps userspace able to enable
> the bit across the fixed-1 => configurable transition, and lets userspace
> infer that the bit is no longer fixed-1 so it can adjust its expectations.
> ...
> @@ -147,6 +147,12 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
> +		/*
> +		 * KVM does not support MSR_IA32_CORE_CAPS, but older TDX specs
> +		 * define this bit as fixed-1.  Report it as configurable so
> +		 * userspace can know the feature is no longer a fixed-1 bit.
> +		 */
> +		TDX_CFG_EXTRA_F(CORE_CAPABILITIES),

Would a mask of the bits that are fixed-1 across the modules KVM supports today
be worth carrying, or adding to the allowed set?
I assume it would be hardcoded, just as the allowed list is.

If a module update later made one of them configurable, userspace would keep the
ability to set it -- something it has today with the denylist. And since such
bits are already enabled in every TD running now, continuing to accept them 
can't turn on anything that isn't already on.

A bit that becomes fixed-1 in the future and configurable after a subsequent
module update would still need a patch to the mask, just as this patch does.
Is CORE_CAPABILITIES the only fixed-1 case so far?

