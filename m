Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795541091;
	b=uPmhCIUiC9VD3l6q/EAtaTBOMpQXw+LZRx6im5R8ETHw3fnsO6ukcKDir688EWMNy0PU
	 +ZFI4ptmO0Y/DbPOwf/cSYmpW40dkxL4z2whi8Z+s9Y2wkb6OEX8gs9unFCFfNoRB6Cmb
	 hFbM4GLEghGKadELuF1sPYyAFA4z+twLf/Ao4yGOAqiB5XtvwVeY2DSTv19cHuIQ3T2MO
	 BT2GXr17pSFpxUL8HAw5R+h4+YWlP7hoOl1MlKqP/OTLph8NQnFHcC7yPz6w4GXyGDms/
	 5r0+pAPDxLLXZeSE/r0gUvIppoeiDJUx2uiRKNvrgYziNk75Bq1gU2mCCeNDiVgtmSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541091;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=2KcfSPoMdWB+3/t33F4urwRWiqXlhucbLtGBeb1FQCg=;
	b=IRGnAaRqq0Q8aHVYTI9LA2lKSA3tjRS5qVpiT6FZ/AtzocIeU7K0/rPO2itrexdFYzNe
	 7qfWqjM7o3aN/GkR0onKOQ+aqFKpy/Um6tkIOIM50OdAc6I8DVYyYGV9DDFD1evee9zq8
	 TsOUE/8xSzG9MXHSkS34UUB5cboZAqm0V1lX85zANm2gCUBssof8dC6K9gLwSJJqJ25of
	 XYTdEWcpRjk2NRqg/be296J2y2krLgIpo815f8BQhYeNofmu2mPWGj8Jf+/lvdlY7smql
	 cl4gdU2KxlChl6JW1dHUax7C8E0MqRegwd6qdyV22jKXvYHb51MG797x9KZKYyl3W1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kajdRNHF;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AjIH7ZAy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0B606A31E;
	Tue, 24 Nov 2026 17:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A0B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kajdRNHF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AjIH7ZAy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795541091; x=1827077091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0X9psQQYWQbnx7k/gn1+e2IamRzxKtuM7pvOfVpl/xQ=;
  b=kajdRNHF4SHrmt3tZM9fs/KxSnWlLG0SqNh1pwUwAVmPhzNkwqzJIT3f
   iETcz/CMMAlmZrnyIFc2Ybtk9lOG7NRZdXIoURdW7j28LZ4GsqlsjOi3/
   /EJwPXjNEIbb8qlY81kcBqTi3XQTO/TlVWTitHJtkXSBlPXfPdSH4N6PQ
   OUZSFzPFDjARViDMU+JkSMs4u1eDhF6pWcGxlibXU5b8rosJEdZ4Aj9J4
   L+nMzPEa3/NQxu8SyNWhd2/uXk2AzAoohYxDgScb0AumW8uKrJQpYwDCp
   D71MriBSn5NDudRzIHNxoRWqLPWtmKy2NZMHyUbXbmOUyCWomRKoNOc9T
   A==;
X-CSE-ConnectionGUID: Tjgx++wkS8uLyXUNvptcFA==
X-CSE-MsgGUID: 8++cfroLT2ylf7HaLvrsnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4382387"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4382387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:05:22 -0800
X-CSE-ConnectionGUID: fGc4FI28SRWq4dYsKMpSog==
X-CSE-MsgGUID: noDnvM1JT52jTUhGiUIX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12063537"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:00:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 09:00:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 09:00:51 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 09:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqpqFPqaBcbL8FEhSn6eTlpwjJuboHNAwtDs9hW6uoNnPIvuC+WP4yBFpOss0Cy+pcAsdz/Lnt8nGKVJwFBNPsP9Zs5BecYAzrQz9cRB25UwEmcqzcgq1/Fz2ZDZiNcCiTbj4FYRj1JEljOfRyakuLex8uygbk1s+c64XCHWVmEETLCVn3uW43ovDvLyYjGLsK6q4uQSiP+2Mw7OQhlrD7UZJi1RqBLe155nyzAJxfTYqU3+JPH+BG8EUyB6xRGtBsxMFOUBPV4ByrKIOfPCszgJaAreYBFo7gLsyaO3KNJWHyGxz+k6bMe9k6Otyr88EUTuZiYGNOBiz/hxMHytOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KcfSPoMdWB+3/t33F4urwRWiqXlhucbLtGBeb1FQCg=;
 b=Ia1DGAESPkursNuk42Ep0+GZkaX9oBy3sAIIj1oUd6+W9YVMQCZTSLEn+9i+HSgfOVhCbTc6uYzh0+KgWYGPC+crs81Qi7tLViOnW2jpt75UO2uALgcaCvXNr9epO7wBJ1u9VOTv6JslWEIsfgfaHOuHAToxnj+4jEulh+/WlstXePk6/QmgfVYqROUdcOlZEH6KHT7ZQ4gEPLpEfm4bwApzSihPE9Lou383Zql2bWxf8rOEuFUsZ9inE3RKywq6pzYJSD6PR7kEoiWXzV/FhzqMDAw1l4XAI/7tgRHTJcU/a5KKc4cTcgaPYMCBKFmpw6LzKsdu4AR1qZO0nbzALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KcfSPoMdWB+3/t33F4urwRWiqXlhucbLtGBeb1FQCg=;
 b=AjIH7ZAyc611JE6u+BB26+M5fAn/vQktecXNR9E6Mi7rK++f+mQz4Y7uGVET+tGWGO5CYFhEbRQiMD05AXrjGb0F2NJmA56W9gqxmWJfQNmmGWdTuRXdqN7mP8VfZX0c5pMb3F7AN3xPSRI5cmruIVlR/TJ0AWFdxSKLs7F96ZY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by PH0PR11MB9773.namprd11.prod.outlook.com (2603:10b6:510:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 17:00:49 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 17:00:49 +0000
Message-ID: <2b83b21b-7d4f-4431-bee5-70660bd12629@intel.com>
Date: Tue, 24 Nov 2026 09:00:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Add this_cpu_fred_sp() and export it for KVM
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Chang S . Bae" <chang.seok.bae@intel.com>, "Chao
 Gao" <chao.gao@intel.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261124015840.2673975-1-sohil.mehta@intel.com>
 <a4b33822-25a6-450f-a2cd-5931d015f484@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <a4b33822-25a6-450f-a2cd-5931d015f484@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|PH0PR11MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: deb159d9-61e2-476e-14c3-08df4a4c7da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|261028144727099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: yIXFxWENKjJYGoWy13IB5RWQeQ1aaiwI449ME/53V+4p3GUe6DaLX/dmD+IJ2nEpkdE1uTN+oKr4vNgxvZQ3CgNtAfXgblxMqJijhdz5CySZTHBgMTtxGQepaHXckvp6ZrDmbq3jewntuS7mIuxWHxDyVIErjOY46KeTwZnBi5J0ZYTm00jWrkQL3ncklsivuRU5uxQ8bL3yruUD0uI8BFG4vQKvaBPbTjmzfgP5e+81pcPXD2BeZR2QyAbf2xqQ60vRxHHknLPRKooTnRflfTDizc+0ctgshI0Mgu6YlkK+Mj43Rh0hN81zzXBUzhHbf4jFvrLgp8yvHs8+kSuvGSXFyo437bT94uLa6mfJtbXUsFy9nqEj4RlkekzaVL16309BT1TosBhX5y4iw/7p49mS9a8zYmjngOEd4NdTHlLzPi/tesgTCtPU/AyLQepWqi7urxaMvQicxArRH6ByP9RTmGKluCSH5WP/ZKObXUu+8BC+MInd+r+38+bPbSay2rR4m6pWpbdNoeSxmhA9C+Y4xEQw9btz/bvyY4x/ujWnEXpuvPg350W7hBwPrwRarn0EqMS8hlNDFGwKGoraZA7h5xA7DAabV6Eq2WLnw/5KOLS2RJJ/71SAcpX0gZFpFXXVzvK7VWS6RM4rzNXsWIRoOWuaZfKFE3PxfpGsVWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(261028144727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBxUlBtTG5IRWUySXdGRE1GQ2lZVGR5eUpZMCs1ZzVUY2xYMG1iUUVra013?=
 =?utf-8?B?R05RazV6dDJFQTJicWtSZllhSTZYbnRFUytJNmJSYk1GS004M1V0N0NjMThj?=
 =?utf-8?B?Wnc1RTRvSWhBVFN1OHV3UDhWVXNHY2w1K3kyUVdjcjBtTDRIVXVqYnk1OG11?=
 =?utf-8?B?aURjYlpCWWFuSTZ3RkJHd2svNWRqRm5SeGpwbUd1UUVWK2NlMGE0ZC84dS9H?=
 =?utf-8?B?REdhY1d2UllzaUJ3N2F1RGxRVzB4T2RjWXpZUERkMG50YUQrT21FUktaR1px?=
 =?utf-8?B?QUY1LzQ5Zk4rVkZIM2t4ZU9TVVpzMFAxeGhFWFZ0d1Ftb0xKdVgzUnVVYWx3?=
 =?utf-8?B?QjNxVVUwZktlZkNMRFRlMzUxa3VabWFDbWVVMUhtc01Nb0tkaEptRTRCbUx4?=
 =?utf-8?B?SGdDRE9qVlpxdFJYcGNiMzZQeEt3bVB4MnlkWDJSSVV6YnFmQW5qOEVndXhw?=
 =?utf-8?B?ZlNFeVNaNkpwdndwSmRucW54RGNNN3NqZ1U2Z3JpamIzdlV3cGZEVFNQd2Er?=
 =?utf-8?B?aTNmckZ0bkFWQjR1M01aQXhla2NJeEhwbGIrOXFYZEtiZVF0aExTYktjcXNX?=
 =?utf-8?B?YWZjcWxmVXI4dmVndXJWRzgxZnB6NVpGTS9YR1hueG91ZlRuN3NISnFxOWFr?=
 =?utf-8?B?VC9LMjlhOE5IRnFzWkh3WFdzK2JXaHlMUmhSWXpnMnJJS1ZseVdyUUhMaG5C?=
 =?utf-8?B?TXhobTc5ZU43NlZ2Yk42bURNdEJIaXZKcVRBUWwzaG5pL29Vc29DVWpXbDZm?=
 =?utf-8?B?a20yUWFYYnZvRlJrRUhVeXdweXBvbVZ1TUs5aUdmMTFmZTREWE1zWURPUWZy?=
 =?utf-8?B?a3E3YW1BM3gwbmVJamhvR2dXWEF0ak43K0VPTGFRZy9XZG1QR0pqZThSbytM?=
 =?utf-8?B?MEFSUHRCZTdzK2RuMEs1a3gxU2NLSmk5RUhvQndoQ01nR2Z6M3VJQkJVejgw?=
 =?utf-8?B?c1BRQStReU00VWlQS2hOWlN1bVhOdk80V3ZVNmg1WkcwdkVtcXU0b0FSbVRw?=
 =?utf-8?B?cjdoLzk1YzkvdmszTXJWSWpVNXRPL1pKQnVCb1hDbnZCdTlrbUQzOTJDaGVa?=
 =?utf-8?B?cEo4aWdRbmpVTS91MnBMQXRaMG5tQlZhNnB5Qml5dENSV0l0bFFodmdRRlQx?=
 =?utf-8?B?UHBrS3N3K0dqWDJEZlpvUmdTQW0yMXY3NTFmTGJFMmJaN3Z3L0h1Y05Cc2JN?=
 =?utf-8?B?TFhpUkpuekxXcXQ4bXZubHFDWHlQRUk5L1ZIWDFBZXBRbEJHVU5VN1ZpYU5V?=
 =?utf-8?B?T3BHSjJiVlZVK2V2UU10WXpjamRTbVBBdTBrSEw4M0M3S3R5R2ZUdkEvU3p3?=
 =?utf-8?B?ME5maEJOWnRwclp6QVkrTmJOdU1GK0RnWWN3Q1N6bUozVkdtKzFvclJGMlNZ?=
 =?utf-8?B?cmhpZGNpY0FnNTZjbC82T3dUSi9FaUgvd3poRVNuWURFeGh4ZkNhR0o3Z2M1?=
 =?utf-8?B?T3RqdHBVTTh5KzN4dWxMaUlmdm15SklGVzk4cVJBUVpqUXJUWXR5clBlRUFZ?=
 =?utf-8?B?V1RYMDRqL05HNUVLWFNQTDRSbVFOZlNkWFF4VVJxQUZieDR3d3hhSmtzU3Qy?=
 =?utf-8?B?NjdSSENJU2ZLSDhad1I2WkxuRVRpK01WL1Qyc3V1NVB5SGNPKy9takVwYU9v?=
 =?utf-8?B?cVYvOFB5MFZrcDhrU0FyRXVUVWJBaXUzWkx5TlgwbnlEY0pYaEl1eXRvTFFS?=
 =?utf-8?B?R3ZCUjRndkU3ZUhWcm45NVJtSFdXYVhQMUVEYi9FV2pIZC85NFV3YytOY3Ra?=
 =?utf-8?B?SU9xTzFSR0lzUVVVUmcwVUxGZmYrM05OOUNEYWRuV0w2YW9iTkxEaVdTK2ZJ?=
 =?utf-8?B?L3JKWjJENUN0MnZXV2RpS2ZDWEdrekZPTWVkYW95bDB3ajRQQnVmMjR5eEFW?=
 =?utf-8?B?YzBZMDF1MVJNaXMyUmpDbjRsTHNZNU91bkJaVExpMTEwKy9jMDM3N0hLbnBr?=
 =?utf-8?B?VGdUUWVCT1hlQnZCRW1mNmZ0RHcydUxIYW1VYndiRjhrUTVLaVQ2YUVKR1BY?=
 =?utf-8?B?VmpzelJvUTcwUGlrZGRpY3kva25TUU9xNXo1MGhvRFpoZ0VHVzNQTkF6V0po?=
 =?utf-8?B?cHhDczljVkNJVGVZVGo0djNWMk5UeDVSNnpXU1Q2cE5wVjBDVG4va2hML1Va?=
 =?utf-8?B?bHFPZ296alN4SUhkUkszNjBtZWpQbWcwMnB0RnFuSTFvdXVuc1UzRldMdi9D?=
 =?utf-8?B?ODRla3NFT1JSaXpTUHNQNlRzQzlDbzRZbFQ3TmZETDdjOHcyTVN0WDZFRTcz?=
 =?utf-8?B?MFFuYzBFNHdCdmF4d1crb3JtRlhtdThHNFg4bUttdmYvUmdQOElLTW1iY0NX?=
 =?utf-8?B?UUhxejE1Mm1sQkwxWkxRVXFzTG1vcTFTczVBeTBKaUpCb2ZkU0haUT09?=
X-Exchange-RoutingPolicyChecked: Pv/fPSZeRGOjiUy3BmAtEAvsyB4+Lw/RqN4FpaIC8JXKa1OR31pgPo23WL9Bsa/5l9rXckce8pTF0hD7mM852FC77cQJTnHr+qvyxfZgxUxh9YYW7PMiWyUEcmMO2i+8yIToi/k32DiifADF1M0cFJGA2eJ5Q4vNC5fvFth7WE4Er3wQH0NyK2H8kmWJ235ytROXht5g4/4GBoifccrCKyiWvKc0h0UEIYVlxNL9UnSz65zkKvXuDq5mrR5vezFa42Um892htmX8frRdMK21f9KEORVJPZZTb4nSjHhDmHVSVG4CRzuP0Z8VXr1vFnaAc/NTGZTohkkxperKQlpDUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: deb159d9-61e2-476e-14c3-08df4a4c7da7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:00:49.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOeNWKWIjzC1H8wmpedDLqTJuD/8yOLvMPjzyZjmeLZ5GxDDesYiKU9VwZpQOcThelXEj690z5OINLFqnojidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9773
X-OriginatorOrg: intel.com

On 11/24/2026 7:52 AM, Dave Hansen wrote:
> Sohil,
> 
> We can take cleanups that both make sense for non-KVM FRED code and are
> _described_ that way. We can't add dead code, or take things that have
> changelogs for code that's not in the tree.
> 
> In other words, please write a changelog and send code that has nothing
> immediate to do with KVM. If that's not possible for a given patch,
> that's a pretty good clue it's not a cleanup and can't be merged early.
> 
> Anything going in early has to stand on its own, please.

Hi Dave,

My primary motivation with this patch was only to get an ACK from the
x86 side. I believe you may have missed my note under the '---' section.
Maybe I should have included a small cover letter.

"... I am posting this separately because the patch has a minor
dependency on the ESTACK_ prefix patch merged in tip today. The main
goal is to collect acks from the x86 maintainers.

The first exported user for the helper is going to be in the FRED KVM
series, so I assume this would likely be merged via the KVM tree ..."

This patch only exists due to KVM and should be merged with the FRED KVM
series. It is the last remaining core x86 patch, so I just wanted to
make it easier for you to review it (instead of the scanning through the
large KVM series).


