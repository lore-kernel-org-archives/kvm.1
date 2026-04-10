Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E42274650;
	Fri, 10 Apr 2026 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780211; cv=fail; b=CRiP3nFv+nNO0pZQC0xZNGQBkd96Ymh1a2/4Fpwn8DMltd21UkV48f/bZjBq3+wd8PbAs0B+mZRfgf+TUbxNgXY0rjOxau9rlnV67q+coE1BTBHE4dqAjEPXE2Y1kgwklrNn6FTqThtRanWKcBWzSD0U8a6iyUNAZP/uGn8XllM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780211; c=relaxed/simple;
	bh=8/T5ACbVpXVYHtGwvjSq4WhYZgOMyCCouZt/79wsJtQ=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=M23cNdhXmjRn3Ck99z6WFV4GmhXE2fhPXiiIYqi6iwxTF9im67wginIBWNXzOhR6IINU6/C2NZgjBbYERn4MhXZoqw2VjAqnmIbYj77EwejofI0BeHstWsdk3FbZKGu57ZfJlNo8luXXRwOhIUMYvGkgr+7fLZEzasUiHToLokQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9sxWwsh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9sxWwsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775780210; x=1807316210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=8/T5ACbVpXVYHtGwvjSq4WhYZgOMyCCouZt/79wsJtQ=;
  b=e9sxWwshra92ChAwQ29ZJ7YSx3e1hKRbOEUIki1xA/cQDS0quiOiKZq/
   YTKCaNbdYIsUFuvQfVXWrMft9KaWA2Xsb5jx6umvRKmRMBSbKQv16u3Vl
   eFQTuQ0upeNQ1lUN9oD8/csQla0ZQ3B5CJoOvYSzxdro/PFrHvNqOu90I
   rg6xZcolelPQxuoiAlSobsxxWUttd5LLIh6q80utdQKq1nF625qA6Cbi0
   mz2R98mM81sbK9vcFB7X4DA/V37r+5W6PC5I3e94WcIyNt7/dqqEx4slx
   mgnKZWky9Emk0Ikoo1rx3DPv0ZFjlCEj76Ojc5uea6yx20f7+/jb0d5vc
   w==;
X-CSE-ConnectionGUID: oMFbzZniSOGfjeVJlZnG3w==
X-CSE-MsgGUID: NOZbbYAfS7egrtjgfB9ZbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="88180686"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="diff'?scan'208";a="88180686"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 17:16:48 -0700
X-CSE-ConnectionGUID: 9eetr6kSSaSTXKO2t+cJiw==
X-CSE-MsgGUID: zv7rmk7XQ3GPRPFwLTO/hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="diff'?scan'208";a="228811078"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 17:16:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 17:16:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 17:16:44 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 17:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzmufkdBJRgSZXSX6kWughwiUyjgk5+LkrlClZo/c5J74jsXqZLl706S62FVVx6NKSxlne9QOv5nh+OiTGiRzC/P0K3YrSxqZs+m3/QJRRhpeNEavfn5ZYFB9plLFWgN/kic9Hw7usISX7KAHUjKfb7cVQxJ3uONzUexZ5GLuKOzttknM3oaplSNaLEaeplU2sf2zBxY7YQELyeEnW6Q4LYXYw25jGvQVwnBxiQK4rXT+Xq6xQsVh6Rpfr2ZgT8v6CZj/kyOVsJX6GcNN4ARoh7SACxY8/jPj8piEt6lKM0AjdxlZEZAiC89K7BhF8u0vcuZgItPbhJYETq7PwItpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YE3ENNibuYrUiyQ2Twc55ZcngVuUHxufY0mKnkZZfo=;
 b=OeshGnLbpIByFQOoQzx3rxAG47+Aat7/YCq8jBmcCBM6K2KCnNi7niW52zRzVA06S+Zo3nzGbvyE8bmn3oOhgwse/bwHSU1/lTC1KDwDtxWWUYd7GAt4Mi3ZS3BgSdjikLqk6ukdHDbpvKU+MbKaSsv7REpscEUhySeTkoLINycqGpLWxMveCZ35lpGZJbbAFwrbVzvmJTjhrNFptkJF+0rXzlwTATR/DAvBSRz7nqYQZJ3cBCL4E6JXNwOSl3xCSwO+CQ/DkyNE8Zhs0cNB6TFoWR2aDBy7HUsmLomal2fCGfRujZbOR4PRHom+MTMh+2GcRYNuWOg3jr7Si380GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 00:16:41 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 00:16:41 +0000
Content-Type: multipart/mixed;
	boundary="------------392wUdL0UxixLCnvD3r7V5rq"
Message-ID: <26b5789b-ecd0-4448-a03f-fbee195f8e99@intel.com>
Date: Thu, 9 Apr 2026 17:16:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with
 RESTORE_HOST_SPEC_CTRL_BODY
To: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <seanjc@google.com>
References: <20260408182213.522713-1-pbonzini@redhat.com>
 <20260408182213.522713-8-pbonzini@redhat.com>
 <3a97a7d0-2bd7-4908-8028-2b6c83b9be3b@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <3a97a7d0-2bd7-4908-8028-2b6c83b9be3b@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: ced4764c-1422-41b5-9ba6-08de9696708a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|6049299003|366016|1800799024|22082099003|56012099003|18002099003|4053099003;
X-Microsoft-Antispam-Message-Info: ypd0dTvZAhouXzFxr1sPsZ5sreXVpww4MAyfu0ex6d1EKguc80EXHV+4zTOcUzch1V/sbWWa2r5Rg03cTb+pjAIYFqYG15L/L0Mj6I/Jt0iDZQR6ygtdYKcqvotjbZwa8Pmjhfb5GTQ9VysfqsbCsdsZoRUBrZ/pBVyGqjaN5JHOp01vXKRZiHLgWqHW21gDwmtq4pbbJAUQgpNk2rVJ1M+KDn6mAo57AbrsCVk7Sl2GJOOe+MPRIt+/Mk6hXqKCoxT12BcoC2B3kegT8RZSRWUfzmRCwr2zEDH2CAMR9GRoXNQcWlW4NVIXYXmw49UOO9aVR3CwD4hfMmIYVlUBMXxzkKDCxcfxif/S8CsA9alRx8Q1wNiaedgvSgue5YEQZXwfxRn48jhuNXYLa1BX3FqY/CMbvtBY0Zpo7XSstFik7sWbRcjqtEXcgUMHbULWL/fP9jSF6kLctGnH+J970FoRHx426xt6Zlbjh8VSKRXE5ctcZtXOSUjJvFLT/S6/TqA0RggoCbEWZqTrUMJLBb+kJ+4mLtsOCFQwQmBlg/n0UyOOnRqKyYs664mhMDtEUryWJrHl2TtepFPpSK0W/OwEEfeME85SnJ7ZxuVnemHwxTuou0J8XaRW0nITJcaGcORHO7u4S3YMyy+J50VHj+EvlfB5IiWd4Ahh6xJ41KJMtF7HjPTY2bv7k1ntDsuJRUIS/pQFLCnyge7/OGK1mHrFsGwEWrxdco998OoO4+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUVHNGJLQmxML3MrRG5IYUhlSGRJaTRPZHJlbWl0bWoyRUNkMzc3L244RFJU?=
 =?utf-8?B?b2JIUy9TN05zMk1XcmloN3kyWnkvRWJDelFLOVhXQmRBTUJCd25MNEdLVjFB?=
 =?utf-8?B?N2dJK2JNaVN0bjk0Y1ViTWNTWEg0T20zOHRYYlh4T0czQXlzeERKbElRNXM4?=
 =?utf-8?B?V3lDenozWW95WVBmVHpDWWhManVxL0xydEVncVpYb2ZBOUl1b0NFUmQrTmxG?=
 =?utf-8?B?TXZ0NWp2RVZ5RDFMVnZnL3VlaFJwUHRjQ1VkWW0vS1BNVzYwNkxiZk5kcUN6?=
 =?utf-8?B?YmROSXZJS01UQVJwRFRnZENVbjhGYmlISWFlNFFVOW5xcDc4R3B3MWZ0MUI0?=
 =?utf-8?B?SUtpNytsVjc4L1NIQlkzZE01dm5HNDcwNzhKVjArTlhvT05TcHlQbmJuazdG?=
 =?utf-8?B?S0lJMDlOK3BYY1NXTzNhLzNSUTIxY2ZOYTl6SThlWjd3aDcwU21Ga1FPN09U?=
 =?utf-8?B?ZW55QThZbWFoTEFnZjM1SnVPWDdwR1BSR25xeVA5NzVLS1IyOG1KZHJJUllK?=
 =?utf-8?B?bXM4NEgrSWVDTTNCRmJ6SW9ZUVVaeVl0SnFLRUovVWIvWHkrYjZRK0w1VjdK?=
 =?utf-8?B?eXVUQ1VJYldTT1h3QlRzVkF5b0k1bStvUm1RSkJNZ2xoKytLOHVSbG40TVdR?=
 =?utf-8?B?SmFrQmtaWkpJeXN4b0ZPQVBSQzNPazNCdEIrQ3p3OExzS1BwMG1LNzZzR0Ri?=
 =?utf-8?B?K05ISDg3WVZwa040ajJsT3JROVVKeityTHZvWnk4VThzRHJFTHlDdFk3clFy?=
 =?utf-8?B?NnA4RzllRWxjS256TDZMTFZ1ZTZlQzZnR0UwRUZaYjExUGJNcVBKSytxYTlv?=
 =?utf-8?B?Y0Zabit1VHJsTTF5d1g3ODI2L2hhTmxhZ3BrNGgvSm1xdTZzY0ZCcWdCV0tv?=
 =?utf-8?B?WlVkaTNhY0l0MlpVcjd1ajRZRFl4bVJzZGxJVXNtWDVZdjlza00wU3pabEFQ?=
 =?utf-8?B?UjRWcWhMa1N2TGxqVFBva2RQRHhXQWtvRytHSzNVSk5IRklRYmo0ZFhwNlpp?=
 =?utf-8?B?QlpUeGRMdkFOb05yY05TdWttY3pmc2VhMG1acnlYT3ZDWkhyejQvTE44NzlN?=
 =?utf-8?B?a29iNFFVMHJ4bW1MNGtXY05xeXRZTEo4ZjB1WVV6RVZIbVh3OTIvejVCM1pQ?=
 =?utf-8?B?RFJ1SXprU1RlRitUeC9abm0zOStxYlYyRDY1UUllaURuaWI5dnFhZ1kzd3Mv?=
 =?utf-8?B?Z1AyelFteWJPK1pOSzRhU0hCZUh0Wm1IRTJublIzSjRMajRXQmMrUDVaTmc3?=
 =?utf-8?B?bFZISTVUMFNqQVJJNHJpdnhPVlgyOUZSM1JIOE1KdGlZMHlobHlJVzVWVno2?=
 =?utf-8?B?VDdiUTU2TGkyejlMT3Bwc2lFTXNpN1hiWTh6aEd5eE9wbCs5YWZ4MnV4bHpB?=
 =?utf-8?B?TGZXZ3hZVGwwMmNwd3lXWm9iT2hMT0tYanhNS2lRTk1IeWxCYnRTUWo5ampG?=
 =?utf-8?B?eXM1NURJOUJQRE91UmV1UTd3RW5DNlNDNjJWdHdpZFFiNjdodVJuUXpEVjdZ?=
 =?utf-8?B?TitrZHA2TnhmUkw4QnM3eE5rN0xudExXTDg2M0Qvb0dkTHpoZTRXLzlKcFI2?=
 =?utf-8?B?b1cvdkptMVNheEwrMks5N3Jtb2VuSjBvTmh6NkxpQSt0VnN1MzlIT1FQZTh5?=
 =?utf-8?B?R0Z6ZElPUGJZZUlnVkYyNGFTSjF4UkFjVkdiaElCSUdDWGR4em5jS3NhM3JL?=
 =?utf-8?B?Z3hVN2pmZ1BEU0VDeDFCK0lQM3ZuT1Nhb1p5MUpyRTJ1R0FHQnFGSjA5Ulpw?=
 =?utf-8?B?Rkwzd0xQTENUMjc1UFhyWll0SUpGVnZSRUtwTHR5VVdVZVZwT1VkZ0RKWkJE?=
 =?utf-8?B?MGdzRlJnWnF1ejhSOWJiNk5uMWhZeTVrL2dDU1J2RkVtak1rKzA3WnQrNFcx?=
 =?utf-8?B?YTJqVVJXb0xwY2V6N3RqanI3Unk2TytwaHVnYzM2VnpESnRDSXBGUHBFM3Za?=
 =?utf-8?B?cEVaeEtxbHM3VDZ6c2JDcWFwakptT2RKeTBWek95OEsyQTdTVThWd3hTY01q?=
 =?utf-8?B?MWZYN25sNy8waHZ4dGVyaGlreThwZHpoK2xPaWJSVkNpYXpORmxRNGFsbGc2?=
 =?utf-8?B?aS9GSXBZSHJHTlAvV0FBV004c1k2VXlKY3dZRm1SZWFVTHU0aXVDZXRSV1pn?=
 =?utf-8?B?aSs1YXNUMVQ5SkIxOSs2dFhCM3NyQnNZOTg5RTRLLzdDWWdiUGdhdWt6TzJX?=
 =?utf-8?B?KzNkbVMrZ3J5dlFQbDJDZzZXVXJEODBaZUJZams5NDNBNk5wNUJ2Z0d0VDR2?=
 =?utf-8?B?dHBYaHhRamlwdGhKZEFwN05YVU9sUVpLeWdSL2k1cVZ6T3dNYURKUldmUTJT?=
 =?utf-8?B?bnZpaUNYcTk2TndrYjh5WU9QUC94MjdMRkd3dkJsalgwMTl5Uk1DQT09?=
X-Exchange-RoutingPolicyChecked: oGCoA6rMhWbWoOubYBvOPzT5doOsMEr1qASW3UepiP10B4TR+VwOMR9IHqoB/cqEuZgEklMuo10gVWrG8kI5mspVKR5A/miVPSF7f2d4EPiX7a+gwzw5JLE6tuUT1VFpy1DqIJPofRmT6d3Q1Q4NytHrB4D7UC0ObnIhxPabEYTyd7qJcV73y5lPQFGR+w/m9I0aYNHgnArOb7sTO0/yjEX0pEYYfuSSK45i+MbIkVCWwGAEK7l48imQXeDBUeNYY7cK7r8Y6/v5clO96CH4IRFkcsZIxgOkOaPeDjqvUaQh+zeejggaMwPdxddATcPF7BvplJ4HsOsOoAvtCNHjjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ced4764c-1422-41b5-9ba6-08de9696708a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:16:41.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPzJZSFLBo5ZewtL/Sj6BJPkOquYbkVFjTHg2glEWUGAJ9P6+ldqmShDT0iWgi1pJdyR2wK+JR2ZhkSTnPlLZwq0PRaS6nIFNCUqogo3F3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

--------------392wUdL0UxixLCnvD3r7V5rq
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/2026 2:48 PM, Paolo Bonzini wrote:
> On 4/8/26 20:22, Paolo Bonzini wrote:
>>
>>   #ifdef CONFIG_X86_64
>>       mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
>>       cmp \guest_spec_ctrl, %rdx
>> -    je \label
>> +    ALTERNATIVE "", __stringify(je \label), X86_FEATURE_KERNEL_IBRS
> 
> Actually the other way round:
> 
>          ALTERNATIVE __stringify(je \label), "", X86_FEATURE_KERNEL_IBRS

Also, that CMP appears unnecessary with X86_FEATURE_KERNEL_IBRS. Maybe 
something like the attached diff is possible.

Thanks,
CHang


--------------392wUdL0UxixLCnvD3r7V5rq
Content-Type: text/plain; charset="UTF-8"; name="vmenter.diff"
Content-Disposition: attachment; filename="vmenter.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bWVudGVyLmggYi9hcmNoL3g4Ni9rdm0vdm1lbnRl
ci5oCmluZGV4IGUxN2FlZGMzNzE4Ny4uYzY3ZWM1NmQ1MTEwIDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9rdm0vdm1lbnRlci5oCisrKyBiL2FyY2gveDg2L2t2bS92bWVudGVyLmgKQEAgLTU0LDIwICs1
NCwyMyBAQAogCS8qIE5vdyByZXN0b3JlIHRoZSBob3N0IHZhbHVlIG9mIHRoZSBNU1IgaWYgZGlm
ZmVyZW50IGZyb20gdGhlIGd1ZXN0J3MuICAqLwogI2lmZGVmIENPTkZJR19YODZfNjQKIAltb3Yg
UEVSX0NQVV9WQVIoeDg2X3NwZWNfY3RybF9jdXJyZW50KSwgJXJkeAorCUFMVEVSTkFUSVZFICIi
LCBfX3N0cmluZ2lmeShqbXAgOTk5ZiksIFg4Nl9GRUFUVVJFX0tFUk5FTF9JQlJTCiAJY21wIFxn
dWVzdF9zcGVjX2N0cmwsICVyZHgKLQlBTFRFUk5BVElWRSBfX3N0cmluZ2lmeShqZSBcbGFiZWwp
LCAiIiwgWDg2X0ZFQVRVUkVfS0VSTkVMX0lCUlMKKwlqZSBcbGFiZWwKIAltb3ZsICVlZHgsICVl
YXgKIAlzaHIgJDMyLCAlcmR4CiAjZWxzZQogCW1vdiBQRVJfQ1BVX1ZBUih4ODZfc3BlY19jdHJs
X2N1cnJlbnQpLCAlZWF4CisJbW92IFBFUl9DUFVfVkFSKHg4Nl9zcGVjX2N0cmxfY3VycmVudCAr
IDQpLCAlZWR4CisJQUxURVJOQVRJVkUgIiIsIF9fc3RyaW5naWZ5KGptcCA5OTlmKSwgWDg2X0ZF
QVRVUkVfS0VSTkVMX0lCUlMKIAltb3YgXGd1ZXN0X3NwZWNfY3RybCwgJWVzaQogCXhvciAlZWF4
LCAlZXNpCi0JbW92IFBFUl9DUFVfVkFSKHg4Nl9zcGVjX2N0cmxfY3VycmVudCArIDQpLCAlZWR4
CiAJbW92IDQgKyBcZ3Vlc3Rfc3BlY19jdHJsLCAlZWRpCiAJeG9yICVlZHgsICVlZGkKIAlvciAl
ZWRpLCAlZXNpCi0JQUxURVJOQVRJVkUgX19zdHJpbmdpZnkoamUgXGxhYmVsKSwgIiIsIFg4Nl9G
RUFUVVJFX0tFUk5FTF9JQlJTCisJamUgXGxhYmVsCiAjZW5kaWYKKzk5OToKIAl3cm1zcgogLmVu
ZG0K

--------------392wUdL0UxixLCnvD3r7V5rq--
