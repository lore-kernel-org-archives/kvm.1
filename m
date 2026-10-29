Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793232805;
	b=Zc0yl8QyCag1CWLPO5GyGBqmWJpvsd9tKIHkBT211QU/ab18HtPJKMYA9xH0WT3T9IeE
	 Q+9EnM+iGzfd7/7fK/4d01MTm/lmShccc3G+rMh215nsiexN92AJZgqfmzanNRqvuGnkE
	 Q0uf3n6Fjg0SsKw7+6gX4njJki37qYQ+13Mhyhq0iSYjpj5I6i59d2G9FidSJPKTN3rO7
	 BD0JXUUcq+o4jeAUUBxQxKYBhmxKPln3t1/63c9Mmyk7oGVrCLPdFvPnCOHdwl9tZQdzz
	 u0kziP8wZbyW6u1Q4tJQ24pm9V1omeHqKt76UNo+inmNIlJjd10o+0SzlalReSk1gEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232805;
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
	bh=fsydChU2J9aU/N5iigIBB19/An0DLvDvfqlM+6hY070=;
	b=uWndMQUni92TLRN1WOsuSOg/6esHcnWQxu2DHYqtqE4kMdTbhfTb1mbbgXC17EX8oSQ/
	 4tfGUoeM5LgIy7Bez9QBvFzEBivbGziJNwxGAGZyqRNkXAA+Frm9n+8oYWCaf38NS3AMH
	 DPcJFV1qeg4jwVVumsiFJUKo/uVYCI00TiXCkaR0eOG/SWe8aJjTHLnOx5Avt4GSCDnf4
	 2d09RkN/jDsHSOf/HRvF/X1ToEmIkjSNiZmnNlPogZWUlthKkfspe513/58qszf2X4Mt9
	 z/xwzsEaz2e0foJRn1RmYJ2Ek3KwJ/1bHmgXabu4bvqE7N4RJtoX+UPJ37TmorKfoLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iKtEtgZ4;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CD606A31A;
	Thu, 29 Oct 2026 00:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iKtEtgZ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793232803; x=1824768803;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ljy7TMwyPqm9j5HS9KqKIRh//pg5HYuH2U53p0hCzSI=;
  b=iKtEtgZ4jWd0U1XEsev17K6BK4k7V8vJPEvlDd0asTMkDeZd8PzRCD+3
   nSLSVGm6THXGGLsKtJ3xiqvhjJjZzAJnjS2TZkzGxMR1r9XH620HAbFbs
   EmPmYV4MgplSEJd00HymkNBEKfz+9gTcZKcbdflRlb1H5yzRYOX1M5ACD
   5WKuZTNFbxXJyDXKiL0AkWYF+xkuQUu0NNeFGpkcpJrFxU98uefB0b+Hd
   PWwTSYF194UzwFptYhgD6RzsUmfreJIKh8hNDmQdSS9i/gfqEQ5gr+M82
   0Xnayg4VzXVHv2y8hchjR+lEVrAt1JPdmvtv5NmCBHoPV0oSkUUZxjsND
   w==;
X-CSE-ConnectionGUID: FOQfCQgUSMeNJiUpKM+UqA==
X-CSE-MsgGUID: Qvw2Z913Rsa3g7fNSd85Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1993243"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1993243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 17:13:22 -0700
X-CSE-ConnectionGUID: Pqd0albxRiu8P6G/qyG06w==
X-CSE-MsgGUID: WH58R5BmRh6lAf3O+FbfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4914939"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 17:13:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 17:13:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 17:13:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 17:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxoJQMAITunZovWwLoBkCUeETcfzqtrrh2fM+JVSx9YqGc7D0E0A5eB2aY67P8wUf9k8cSqPrLRddM4D0LpqV0xEzuYFAZF1wV36murqcArf+i4cTbdRbFQndI2tnaLKI5G30i5f1MF2w31tpD4A3ZDiSlAGbKBFgPiqoWrKZSm+eePLS8ueYmXmeknEpWd8y+Fn0Gycwvv+iNQMkrOgPvYiLxmLnVnZccMI53enlwHfAkIl1MQgtSWpy6Ed6Sliw9fkDou3gPyzOproMwsCtoRrNySn74t3c8iiikKNknq+OMH8Ry0StxRPV3wlaD2QlcimWnMBXipSEtgf+yIZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsydChU2J9aU/N5iigIBB19/An0DLvDvfqlM+6hY070=;
 b=UtwhdB7EwDotPl6NxpI6XBxFVYnT6UZdAPtLRzAasdsvr4O+NK3SmayHfjrRjpt9Gqs02uJNGvzp+Tq8QP/aDaXKFliWherX1NkPGmgqt+sfzTMchB4zvpdE96SdbDKFm2a7Kzv23fu3AsckmGEbmY/2d1dxxw7ykd17O1rCTsCmIjVyWbNsMzkeCgtGQH2MYrCTp7iYi/6Am+ktPbMm4tr40btVU/nyQBWSMG2LqWQW21ES6066Z7Q/Xm2O6/9o7ENnMElMHi3gZXTY/iSO/DdnavV+BiTdOsG8f1qyOdNuIn88dpaLG4F3JQ93NwLhKzPGMKWA4WKasezLU2Ryzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 00:13:17 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 00:13:17 +0000
Message-ID: <4b7b991c-75c3-41cf-9aa2-913049a263c2@intel.com>
Date: Wed, 28 Oct 2026 17:13:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/28] KVM: VMX: Initialize VMCS FRED fields
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-8-sohil.mehta@intel.com>
 <d742f446-4632-4d15-a6ca-9d0ba144b223@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <d742f446-4632-4d15-a6ca-9d0ba144b223@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|CY8PR11MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: d06663c3-16d1-49c3-795e-08df35516e68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|4143699003|11063799006|56012099006|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NiqAk0Nj5m9SvQPzfydIdGtCuljJFrhS24X1CwMfD81q4DDpaC+gALHS/5IDqrp5eyeDswvxcwNHDgakAVhL6c7LJ7MDa1AC9waR22r0APKUmlCvwZ3IbHlYBKuVNTr0c+tzPpfusabwYZUAmuFf7Ag68oDLsk/fTjXj/3DYqpQV8BU3BA8LZbzROmUl0EyjoSS3aSJU6fLK0cohtFrPY3S2pY0TxL+2SjrG6u7dJKjJdYj2Wq2ImmwlTwCugps59i7wnl0v4m6QJquoVB5dBGvWx4vS2Sx8r8tLnJ24p8065IqPmy7Xk6uXOw7QNIAJIcLxyb/Gt3zPZqbTraPei++BjJgD6X2MGiMTIBQLGc5uVUuyLyluPJbaUdy2/Zi1JDz2t+zyibvlJTbGDbw+do0eL9kMl6s3X+38TcspACKwn4xyacwYxpMI70iU84LHFKTtGtyCvCguG2U8RW4iegefQtPnLYjSjS2De+daHmrNo1F+w9J9/Y7JFIQmCHnlHZBUcnYm0yQRxX3VZmnDxjNLRdbchW/1Z+smTQhlOQ+W9QdQ4z/iJUr/MJRe/rKZeqr5OmR0XyIbZWc5Bm36l+le1U1348ceYR0r+QR/qivJnNIJGL2CueaiHdCNXtJBH5UXSBaht8/mSgYJBE73iwUXO+15b8fCPwDqFlfS0P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUIyZlN2OGgyOHY3NW5hcWxUcE9rQkRpNCtBSWRBUnQvVVRRYU0yRzc5NzVm?=
 =?utf-8?B?UTlNaWhhWmxMbDAxNXVBMGpuOG8vNm9YM2MvUTYveUgrRzR2d21pVWZXQWds?=
 =?utf-8?B?eXliNFloS0ozY3ZYN0JpdnVRSklPdjFsdVc4dVc4b05SaktyZTc0OHBSN1NO?=
 =?utf-8?B?blJVTXp3UHdtL0FnM1JES2czQ3FKbHlqZmF2RlFTNTJBSnJOZmRPZExGY2ow?=
 =?utf-8?B?TDJxWWNXeFlQUFRwMDBxMTA0ckppYW9TemxwSUtML2UxRytFdGFMUi8vcTdz?=
 =?utf-8?B?YnlOeExLaEFuaSsvWHVGYVNHS2J3SHRsYU1pUitaTGNnY2Mvcko3UmdhZWo2?=
 =?utf-8?B?WURWNGVTUjRBb3hvMFpEV2UvdUV0S2pVaXozMHppTGFGTWRvUVVzQUNIZmQz?=
 =?utf-8?B?cGFUWDRjdnNtV3ZlUGZ1QjErL3FzRUI2T0dFd09ZVkNYbHIybUhVdE5TOTVw?=
 =?utf-8?B?cjZLQjJHMU96NlgxQm9xclRDUEQrTHhqa1pPa1VRMEdYVUlLTVU5K3ZaV2VH?=
 =?utf-8?B?QjErSXU2VzdGUThRRXhhSzdzTHh6aEN5RExYTEZCbnhEaWI2NHZuRk52WTdF?=
 =?utf-8?B?a1VtT3I5cjBCeWtuVjVwRFBHUXpiclJHcDFIcklKSmF4amlxd1R1NHNjMHpE?=
 =?utf-8?B?NzRVN1JuZGlINmRTT0QzMGpsQVR2Wk1iVFJWckNsb0pJVkc4ejJaVzBYR2dX?=
 =?utf-8?B?aDBGR2szTEtsWllhQUVqWVRNZnNNNjkxbkg1eEdDd1lKd2ZyNWZ3VTBVSURu?=
 =?utf-8?B?SDVDWXlCYWRpYk9SVkE2ZEdRNXRWVFA4NHVhNHBDOHJ2MXJyNUVpK2VCYnND?=
 =?utf-8?B?R1Z2VGVSL2NGYVBrcXJVZUgybXhTaFhYaHF4UmpaZGMvZkMvbWJMTE5keFQv?=
 =?utf-8?B?SUw0eDBwR2Z2QWk4R21JWHpJbzJ3UitFeVgrOGFhVVJVQ0d6d3pYYVdkVFJH?=
 =?utf-8?B?UFk1SEtxN0tCY1VEbVRraTJGZ0JMbitoRlJYeWJDV2dkODJOTHg4YmFCaGo0?=
 =?utf-8?B?QmNVWW5YS1V6YXJ1bUNSR2V3OEhJK2hlS09FM3plWS9laUdvaGltdUpzQVlQ?=
 =?utf-8?B?a2FIb3M4Y2R1a2p1dDZNUnFMRG9QRFR4UjRRQmtzUHdUOWc3UWRDSE53bTR6?=
 =?utf-8?B?WVhiSlpnQ1hNanUzbXIyQmQ4dkFNQTZ1aXM2ZkVHa3BzOERWVEpucVFjNmQ5?=
 =?utf-8?B?NVVLTS81aHdkbHkxdzBHNXFjRXJ1a1lGVnBpcmI0VnJtb1N6M1pwSE80Zk5t?=
 =?utf-8?B?RVRjVlMrWkQ2cFdxU1ROREttLy9mWEk2bW9UOVhFVHR1dk90bnNKdG5Gd3Nn?=
 =?utf-8?B?ams1TEFqZXJvSzF6T0VEcngwTDVpSGZ3SnNtTmJydjhqTUlJMzF3OTJiSlhS?=
 =?utf-8?B?OFppZGQwdGRnUTZBLzhETDd2cUFJb2dyUFM5eGhKZzRXZmtYd3JnUUx2c1ZC?=
 =?utf-8?B?M0kzTUxXZ2xTQno3RkgyWWZ0MGtJTjBCZkpxd1p4K0g1aDllekZmN1M4ZWZj?=
 =?utf-8?B?ek9uVktNYU53QzZnVEd1RjZsZ1MwYVZNMDFpK2ljOW9jbjRKMmc1T2RYcCt6?=
 =?utf-8?B?dzFOVm5XOUVjSWJzb0FlUjJjWnM2SXFBVk1VemVSWEVlNXE3Q04vUmJlZWZM?=
 =?utf-8?B?MFl0dHJqZnJmUFZrRGswYWwxclVIQ0toN1FZaDFna0lOQS90RHBTdjMrOFQx?=
 =?utf-8?B?TnpJbTQyQlRQMlV2UDY4M2pmdGpieTAvUW1McllSRHY2ZmFrNWoxMzBoK2NY?=
 =?utf-8?B?Z3p0aG1NazBwMzhINEt4dmd1RFJZa2Qwcm43KzdwYTA0ek9obHhmejZZZ2dF?=
 =?utf-8?B?UnV2QzUxd2gyc3EybVFONEVCTSthSndwM2hMOG1EMjFBS25ybDV6T05sZ0NF?=
 =?utf-8?B?ekFWVmVJcC9XVTlIRnVFekdpamh3bktDWWRlVVdCZjNQY25ORjNsNkFOY1No?=
 =?utf-8?B?YzJZUmowUzFKNEQ0QW90eVhhNnJVMytWSmtlaG1vVEQzaUtyZEZscU1TU1Zk?=
 =?utf-8?B?QjJvNlJ3Z0xCNkptUTJGYUJDcmhwUzhxM1hIZDdIOW9TZXBCRXdpQ1hpYXBn?=
 =?utf-8?B?ZkwvVExsYzk0V1djdEhXR3FJU3F2SVdUVkJrdW9vTnBLQ2VIcnJyR1FYbXN3?=
 =?utf-8?B?cjVSR0gvcGdnc1ZGSjRqME5QcmlyRFpSaTk5dkE4enNNcDAwSlo3OXAwUVNS?=
 =?utf-8?B?SlNnSEI3N1dzUDFPV1BnNUcvNTZ0Rm1OemJIRTIwVHN2akI1aGNWNlNuVXg1?=
 =?utf-8?B?ODkzdTBTeXlyMWUxUXpWUk16ZFRVWWlkNW56Uk1SQWVWeDFGaFVXNTZ2OU1J?=
 =?utf-8?B?L01wM0NUbHd1NTMwcDVRS0VFcjhMb1FjL2ZmREJTcE5Na2ZldXV6dz09?=
X-Exchange-RoutingPolicyChecked: Lk0UYivHZ+o5xmHpeQtbAE/sSWJJUs9ByHBnfMqHIHxBtpwKussSFajARGagrtAQ/65BvVQuUWnfseziFFPq0dSmJ0kcdQ/VfClfVWCURS4T0F+Me71cPAhWy+8fkpIDg++b509lsG8Qj80WOUtA3EQuSRtPBeR1haazwAKe8CIT7wDvV/dCRW/zzkPCLyEKjxX5Ssn+Kiyr5h1Bf5r9/fMjABEQtL5aZM/FmnYO44S5mWhThHEuaNqFg1qTiqJkEmbg7PO9/kVes2YoSdZ/dFKbm8s5CiCRq9EWZ522e0qgxqiwfb5QpQAUpqtF2p8/I4beTh0Ga4JYWzE/Y/xVRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d06663c3-16d1-49c3-795e-08df35516e68
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 00:13:17.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdUqDKcFuwLut3Q9GVKdIgL5lBZqe+Br2PEwGKEQ/kwb8F6NlFhtxYJqXe2ihMhfUP4lHR6qIERInokJhfYu8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com


>> +		if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
> 
> Nit:
> I was wondering why cpu_feature_enabled(X86_FEATURE_FRED) was needed for a while.
> Sorry I missed the version history :(
> 
> This seems to be the first time this cpu_feature_enabled() && kvm_cpu_cap_has() combination is used,
> maybe have a mention in the changelog?
> 
Sure will add a line or two in the changelog. It is mainly to patch out
when FRED isn't supported.
