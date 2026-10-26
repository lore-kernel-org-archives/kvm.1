Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793035360;
	b=TK0z5tR+oslEQhPgDIu+67rlC33+DXQZOmgmDPiqzg+uBHmHdRrXsyeOgMUq+gZBmDNI
	 D7dTwGoFZay5yWTFO6rz6+2d79HMhhLmxeZpnwNK5FNvsTUCiG99AfPNFkAPWaLaA3xeN
	 SlAwYRYOh3v8aJw+GkVKmmb7zMJy5gMWPybjPgs3Uc5/ua0ZGrJDvoQ0WNTyxo/xD5qnr
	 J29yJo7YQer/XDWiPEdM4CFXOgTjkent3dpP04VH7oAChiDaKIanwBoQ4JeqH1oY5Eynf
	 NPfPQYbZpjnxSXDjXFBBbeHqmSrQnF+ev0h/uKgmoG15bgg8cU1+kCJla36fsuMplsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035360;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=cZfphz98mjFnRxKTIEi2WexHYD/q2JBBG2Juk5fQ0JA=;
	b=eoYeiQLmmmm5WgdugL2m0TBWX9b38HIoq00QsKXdLMJbJbx5F0/mdBKECt9U3hfdLfFT
	 67ILBYR9g8okvt32ZVYvLhb1qtIrdlyMfDF7in7lRMncZTfbMqbDSlz7WJvM50pK9DbEg
	 wRZr1UaQim8Htcfuj4+j+Lw8HtlPJ7bjCc+SIzU3SWR4Of0TGh5Hkc8HnL9zFraaaU9wE
	 el5qHh1MOVosStfYQPgLQtqcXL8Uv+x7JFfB2T0Lrk5D16CPlW3C1Zf54I6niOjRbxqcm
	 hv7FYcT8ooOPxiYbHju68dt57owTvrfaGInH/7+Lvi1Ea2iZaF1eqJR3XsS4ToJqlig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iai1drqO;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39495606A31D;
	Mon, 26 Oct 2026 17:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39495606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iai1drqO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793035358; x=1824571358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yyvhOnW6YNBE2oQIWTZNdixOXuhPD5NOYAPbpK/7OPA=;
  b=Iai1drqO1oHmZhezrylEpKWJUmBMrLHowr8vITjrbRg303XRae5FWV/t
   IkJ2vF2uW+3HubndEq9NWyha2crJ4j5cNc+0iJEL4Ktu8uwOh760nxkOZ
   HuxATz2Siba87h04HfmyDZXmfy2LtfbIaPNfL9Ta/baw5OxPGQIj6e2DH
   SUCEDtFLwkFyYzxn7gOGpdRYQbUI+297f+5F1glHT2WXboVHaMyfk2VS7
   NjEuzsRoNfG4gSYSFTRxPdAAN2tce6kspP1LBDosdRM8+vqn3skiV3Iyk
   sLkPj8u3vcb1/fhuPiutul0mO3ZKkMUEuR7lHu1yyE9d8fhiq8FNusuUZ
   g==;
X-CSE-ConnectionGUID: xvXWwOimQWWSTk1EQBFnug==
X-CSE-MsgGUID: nfQpnAFJS76H/gvkUcQ/aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1588538"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1588538"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 10:22:37 -0700
X-CSE-ConnectionGUID: 9RNxHy+2RjmczuuZYbfaEQ==
X-CSE-MsgGUID: Ji0WwAXSS56aedBZ5QLbvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6138971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 10:22:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 10:22:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 10:22:35 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 10:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfTCxsAoADV93Loa27IfsNpUDMju2vSBFzvOpZdt1vJ437n5KlrinSOSi5XZmkJTKAvWjj/3EJzOFYmsA+xcIzuenPwV4f76o68tGpIh3ykQPdsP7haBZzJI9mzER9XqrvxvEjr1II8k/OHdaRvKWyjFxiO80bYfX8hy9PGy4zPkHZ+yN3QoJ840G0/R00+DZt3mv39suWlbv3grSWuAHYD8TcAJcy8q3G+Cy9mE6E6skLDHqZ5dZMHT2QCpiDWri2Mct88N0PHcLKUHsZLI0hw2b7NTp8dSLWNqvKFf3uHHkaIOmsumOHdmfvZfkHOem8Gho+5rUBcc88qzk/sXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZfphz98mjFnRxKTIEi2WexHYD/q2JBBG2Juk5fQ0JA=;
 b=xoBMMKI7eWYJ4v8FV1H5vJ1GLGhSKv+vc1yBBYBfTKsYd56mwZUapbb4RfdkjxxwGrAhTohnh2tCQvWm7PvQPBA2vza7Y8LrxyfbT1N2tvmu76E4pwFaJ6BheOEkb5gnLQwnZFgIVOv51asnKFyXX87A8b/xl9tDkZAmstQyxT0KKtQsWuSovxAvq5ovHycIQwRq5Co1vQ2paXDxP0HSa+3eUqLKm52O2ASBEKB6FgcJ3Vgwk6SKeA4G3amjrD/jrZeQnLwxpFGJn49WdAO8eC86YVPpmlhirUsF7F3JKAksoFj20oOf29HQCT69Jk4a6173wA6fjzYL3xtuFrPnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 26 Oct
 2026 17:22:33 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:22:33 +0000
Message-ID: <20d0feae-9aa0-43cf-8357-fcdf617a5a97@intel.com>
Date: Mon, 26 Oct 2026 10:22:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: Xin Li <xin@zytor.com>, <kvm@vger.kernel.org>, <x86@kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
 <9467c7b6-d797-4462-bee1-1406bb8469cd@zytor.com>
 <at96Aex_dl8-yUk6@google.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <at96Aex_dl8-yUk6@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 35be7fe1-cffa-4960-ba48-08df3385b8b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026140227099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZwbAgZPw6x1ueZmcM0nl13Eyr9Bp0Z7sBsbxARTRPsXpzVb5Ab8PCcZpK/bcl2zlUhsQAbhVgvrcjBxzQU0ERd9Xv+APyysussCAprEMyjAaCZXqbb9UYaFF+LB6Katn/Vf2HoL6LbJu1Tw8X0ao5uvGuicMTI/J7Oh2WxhswmryY/QdoWbMxRoIWm5OfsT4sQWbVEsWBplBoymoHcTNZnKXi5ldjGaKJ9SljJSGBW+3JCjFuvUFJI1R/ndso79WO5sPuDAtE1fsr7PzcGu44SS6B0Zk4fEVLztyJk5Jh86BQsRodJnL+pInaZq0LovzlfL1WFeyLWU5KwL4Vc77uMzSAyJrbGwXmtFd3Ib4P8pbK3hrvZnhNbObZLNTXdvrDF9eo1OGm6trHBOag8shm62QlyWyCXPlPEGd8FtOqlUDakUUyTAhtUjxpJL1GMBAtFT6bCljdc6eAJ+tnP3igP2azPoQbgCul9mnUfmglWvL1nycCLUTcOzPheQgWYxNeDKtTVPfnWJ027iWK6k/TY1V0TacxJ98HVcRaLW3fFSavoGAJRrhdjEK5C6Yscp4mXOtaUwWdgZAkwJxDOjIn8l24DJRq6lb5aavH+EdNngoCAvxeonN8CfnS7j7bsYudNnU84YxCGt0POXAZqFbPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026140227099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2d3T2MyNXpEcXZXY1h4MWUwdzNIeG9RckxzSFdDSFpZTUk4b3ZMOXNja2xG?=
 =?utf-8?B?dzdEVm9keUppU29uZXNodFBWbUVXTWIyYk91WVk5YTBSSHFVMFJsTEk4YzFz?=
 =?utf-8?B?dnRvNFFpZVhHb25pZCtydFFuczRSMG4vZXlLd0kxL2NrdFg5T1VmTW96YVN6?=
 =?utf-8?B?U1Y0VUlzanJ5dnZVVWJBMFpTV1gyWUZ4WW41L0M3TjRzU1F3Q1VBcSt4bDZ5?=
 =?utf-8?B?TEo0SVNXTHhkd1BNaFJUVnFCbDVvSE5vS0wyNUlJV0thd3VCWmlqaW5YSk1Q?=
 =?utf-8?B?MjNmQUdaMk1Cb0F6L0NWcCtuaGRkeEt5TzZvV2Uxb1B0ejBORXZpZVpLd2Ja?=
 =?utf-8?B?cDczVnZ1WHEvNUJXM2dnb2NkM3hmbWJQZEVJSHM0ZGMvUEt5Y2dKalFPWVR1?=
 =?utf-8?B?YVdZcFd5M0JYbzF6UWFPZVk3NnFkdmNEd0RTMnRhcHVMaEVaSVJzR29CUkVZ?=
 =?utf-8?B?SzR0L1JBc3JaZXhtRCtXemlJWjNpV3ljWnR0RkU0cG5rMWNjNXZxUDdOS0I3?=
 =?utf-8?B?ZjJWbDd0NHFmcDY1TnVQR0E2WDdOcjl3eW5hUGIrQUM4NS84ZjRLdFlxRndO?=
 =?utf-8?B?aUJxWXUyeTk0N0Nhbit1a1gxaHpDMFBMcmtzMC9yMm5paWNnbU5ZTzBZc1ZG?=
 =?utf-8?B?NW9RWjUzdkdoMVdJRDEzRFFOM1hocTl5eDhNZit4QU1XK05WTGpESlZSdURU?=
 =?utf-8?B?MFZEL3l5N2hHUHM5bGtCc3hpRG9HbUxBbFptbFJxU0dqTU5VNEFDRUJQa3BK?=
 =?utf-8?B?REMzMW5pWTBweFIvcEszYzV0TTdxWkdLWXd6Qm5mMnJLYkxBRG82alpVaTdO?=
 =?utf-8?B?dFlrTytsV0U2VEhSYmVsdjFjR1RERjVMVzVnangwYmRkVE9iVmNmcnRSdmlr?=
 =?utf-8?B?SGdCYzlXRGxNZHBFTUZJaTZZUVl6QWh0MXlEYXRTT0hEbnhNSVVaOEllQzYw?=
 =?utf-8?B?RUJWV1BvZDRlVElJb0NkSzVvY29aVnN0aWlIYUQ1UUF6MVhFdkpZcmV6T0oz?=
 =?utf-8?B?N1pqVWt2a1lxTkFONUJQNFhnWmNwS3VLdWtJR2RLNWJxTmN5WlZ1VXY4aFJQ?=
 =?utf-8?B?Y1lPWU9lNGhLbEZSQ2hsd0o2bmc3V2IwK1kreE5wZlIxZ2RGeUg4ZDVwM1pZ?=
 =?utf-8?B?cERSbGJicXJDblB2VWdHbzhPLzczR3hSSm51ZW93Y0MxcEJJS2R6b1AzdmpC?=
 =?utf-8?B?TnlvQmczZ01wdmhHTllMYW5Ic25zNEJnM2ZRZ3U0K3I5WWl3eTRuSllQWkhh?=
 =?utf-8?B?UHlkaW8yS1p5b25PS3RQdzRLZnNvVGJpYWp0NnBGRUpFaDB5c05yRFdQdFhI?=
 =?utf-8?B?WHJTU0wrbGh1eHNDOGNZTFh5bDJVN21YTDBtb1RwempibGVLb2xzL3dqRFVi?=
 =?utf-8?B?aEUxcFZwK2lrMDhoUmkybGxxMCtVNDlkbEdLQXFESUlXV2JDdm0ya3hJcHAv?=
 =?utf-8?B?TzRWUzMyTitVaEFSNDd2ck81c3NhRldNaFAwQmNpRnEyRXVUaXNPNnZpZytj?=
 =?utf-8?B?aUUrL01BQk5xbVMxdzlIaldJdWpnbHMrMUVTYVRXNjkrTHZBYWdGV0ppUUhv?=
 =?utf-8?B?a0xleVhGSGtvVGd4akI4TWtONEt1N3hUNHBMUEpjckFVN1FtaWtjTFRtdjkz?=
 =?utf-8?B?SU1mT2lDcmUramFTcHJYL3daWTRyMUg3OTVOSmZPd1hZY0VsTUpQcnBua1Av?=
 =?utf-8?B?Vm1ra0RuUUJHczIwaldHQmZqR0FNSzc0Y254NzUydkpKSzk0TTBlOWRFUVg2?=
 =?utf-8?B?RkNVY1IrdUd5akx3YWMzNERFL09kUmIzelBEdUtOSTZ6cldWNjMxUC9YT3kv?=
 =?utf-8?B?V2szZS9nTzNyMUJJbFBHbVFlNEJ1cEtORkpxYnBPWU9PQzBkaXlSVnZkRldT?=
 =?utf-8?B?SDFPWFVOQVdkUzBBUWE0eHdOc3Q5alJVTlhSSnVCak9oWGdmMmxIOEFWNkhW?=
 =?utf-8?B?Qzk0Q1ExR1RJS1VsamVKWUo1WDFJeittWVpYVzQ2YWROSFc2UEZPUDdjaTRs?=
 =?utf-8?B?ZGhpd2RVSDNoMVpYcVVld2NkaGpsVFRpcUtORkEzNEFIeWNhaG9KMS9nZ1pq?=
 =?utf-8?B?VHNXUktGZUNvNXBnTXpsWU5EOVRHRnBlVmZ3Z0hyWjZjcmVJaG84dElsMEFh?=
 =?utf-8?B?TjlkQzlOOEtIMjBPMlJ0T0ZURVRMbGtXWm51ZXVjSlZTRTAwa09mUm12Z0E5?=
 =?utf-8?B?UFBmSE85Y2VYTnROUzN3UityYjVFWnprS2JUMzNURFZSMG50aDhnT1NxbWR4?=
 =?utf-8?B?NEViQmJTMHBZUEFvUERhbFRTS3h3Z1JJVFc5cUpsRXBQblFUeDZ1elk1R3ZX?=
 =?utf-8?B?YkxCRkdKMGdLK2lkTHR0QU9GcHBFNTJjeW9vMXR0UHNHS3hSUmQrUT09?=
X-Exchange-RoutingPolicyChecked: XcSsG+x1L/LpVqOGeDZdfEIE7UaH8jo94DqdCoImwvwVPK7M/yz2pDOlGZbb1idCOIuOB1SgIjwtnevG45F+zNJkeFskqQAVQc7HZgv2XpYzDv8ljl/aIWjjVb38ctuTYRa92I7rrqM6ArcR61++KiU7yEF8NtXT4K1k6SQPqpZUdAY/9FCJ8iOVveL94/wDDywzXnONoxnO7uf45TnQk9TXFVDXCT2psVxlvgyXNlKEMImfGJjL18nrA60+vrbeWp1O/zMVJ+SXqbkk7bSmnEP17Jy9x8vx4LIvk/pBGjzhdaH9QdPWihsZQWONEvzwjAUDOgVeiKvUOKYT5cd1gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35be7fe1-cffa-4960-ba48-08df3385b8b0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:22:33.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ai3nQwW/p+K7qts6sqbeCUGhvsP6VZBpJrvzaKqzcOPx8oEcesxkATSkmV/Pv2OVKGajSgSL/1wyOEP6mIHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com

On 10/26/2026 9:04 AM, Sean Christopherson wrote:

> And we'd want to keep the optimizations to elide writes when vCPUs are using the
> same value(s).  So, compile tested only...
> 

Will test this out on real hardware with the MSR_STAR change below.

>  
> +static bool kvm_is_msr_used_in_host(u32 msr)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_FRED))
> +		return true;
> +
> +	switch (msr) {
> +	case MSR_STAR:

AFAIU, MSR_STAR is still used with FRED so it shouldn't be included
here. The Spec says in section 4.4:

IA32_STAR:
- Existing use: this MSR is used by the existing operation of SYSCALL
and SYSRET.
- FRED use: FRED event delivery loads the CS and SS selectors with
values derived from IA32_STAR[47:32] (see Section 5.3). ERETU uses the
value of IA32_STAR[63:48] to determine how to load the CS and SS
registers (see Section 6.2.1).

It is expected that operating systems will set IA32_STAR[33:32] to 00B
and IA32_STAR[49:48] to 11B.

Likewise, the kernel also writes to MSR_STAR during syscall_init() and
it has a comment saying: "Except the IA32_STAR MSR, there is NO need to
setup SYSCALL and SYSENTER MSRs for FRED, .."


> +	case MSR_LSTAR:
> +	case MSR_CSTAR:
> +	case MSR_SYSCALL_MASK:
> +		return false;
> +	default:
> +		break;
> +	}
> +	return true;
> +}
> +
