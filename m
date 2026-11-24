Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551783;
	b=lhjuqqJV6Il96oJu8K08HTvIQG+ktn9AHc9ibsRN9fwOlauXEJ+orushFD5qjaXObfX9
	 HQsIcfyfZNy2sM/58vNgT3P23UMq8aRSoGbkFeKCebrKU+JVxdmeYgLznqGufcbjNqaDx
	 fXWfjeUVehZT9ZEvNY2St86FoGiyULt298LR93fgMBcBWNiTU8mE2VNHm9KfzBbN4egjC
	 xhiZRGY8brlQSRZKGDmc1gY3UvTlmW/3f25P/l13wyJ3n963QRgRz4swfMDRYVcYSc7ka
	 Bn4S23lP/FcxwYRL6s87xIxlcobUi+W+KlyPS+9qkRtBqjridkUea6aopo8McqInvtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551783;
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
	bh=9H9LTlljMvoK9C76b5C29rypnXbgaeFXTpDKEraD+Ww=;
	b=Ea6QuUzwk3w370tPYYTJwth8STca4MJJkcrVZTPQeYbxILcCp2ZYjAolLXX3Tl9g0e1F
	 tQA410gVXIhYUo40Mgm4sce6wWWf6rNwCJSctedIwdHGpF1bFaQgxx208InQyCL9dXGbJ
	 QLE5X0x76c9yKN/TiQ+3e2wie7tcXVhoiLELBnmB52lFHaIgQ2DPuYIk08YDimnWmx/tC
	 0acFAnlZ2gRCyer99UKLE6UZub6qBlYExp7n2FbP0rK29FmIr+TBYyljVzDwNDvghI6OE
	 ZrGNQi8xmqCekIeyOBkiz8wfl8PnREIp2ykj44vnc4ras6oBxgk4t2jpSkB+oy/YALg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXEtKnM1;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dXCBvaK6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B1606A321;
	Tue, 24 Nov 2026 20:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXEtKnM1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dXCBvaK6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795551784; x=1827087784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qsYPbSE5VfbTWQppjdCgM1/5a6DA7/7uirtO+gRyAKE=;
  b=eXEtKnM1Mp0TWMzcRrf5twiOEGxakqpyO26+9iL7MC8WpXgfhLugACJ5
   mw/DuIMg8nk3/lcCVf9kBD2h4oVbj1/jW3+u7f9bi7QFyRB2Zdl468nJG
   8BPJBWHp7C6dOxhu6PHBDBSyL1ki2FojiGUfRyy8xN7eLRvHIvlHk0Gn1
   entjsP0LDxsauAuzy2T8EJT6wGRgC1A7Ngj6rvKPBnUnBWCHz2YhCMv/9
   RgevwL01TQ8W8W0Cl0vciXuIGpiC8kMRs5irDygfUDWQsNbCIBuwnf9gg
   1wKaGzuHpJuht8p3lk74K58d7FjvFt81DkGuYNiT0nswegIr6sdnKxYxY
   w==;
X-CSE-ConnectionGUID: 13ZMc1lZQsCfCQ8FFPtqaQ==
X-CSE-MsgGUID: zyO/VQbWSSS70KYf4lq0Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4295978"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4295978"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:23:03 -0800
X-CSE-ConnectionGUID: hOh78IhDQGeeedk4QH6+wg==
X-CSE-MsgGUID: 6KjV6/ibR8mmhmnCp+1Glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11766204"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:23:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:23:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:23:01 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:23:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA+P1VppUJ3rXFMtayqyj6KwmaRxLo6gBZuYrHK7JIcgyA8FuBCz2WaPl6+jYtSCiHmQnioBz7LtjTonijLkft5comLfE+6NJXlZbNQHbQlECWYiYOFsbZKuug60jdjMvCkHY2KS/M8M7oERu3G41Ju/bW0SlT/pgAZKq9yDbdQXjhzby8iY/MZfwsuNHQxYLOpGLa+PRIN65q7iWUtXeDzGulYafKQHjV9LUWOWdzHdMdBDP0cZFN0Sx/MbAMI1UqXKA159bksgDziFZVtqUGIirjFCM6rmfexlKIVmGgJcZfQLSgY4jgSj8L9hqRmXKvvfvjpHXcpxQQ4XBcxTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H9LTlljMvoK9C76b5C29rypnXbgaeFXTpDKEraD+Ww=;
 b=DL2rC+sj7w8iOLKMaSGsCh8BEj8o74UT/7Y6Rw/1Z50jedGV0N1yah7m9jm0MAHKbM/izQzKwHtcvHUP5oo1DIsVX9TmNEvkIXGoyVNocLe9CEiUBKQvx5HBvQ44uzWHt6GkiXexM7JRTUbqWC9iLPE2kuhJz32HzD4ArzrGetr4gdcG+ILvoGyj71r/quZGGD3IP4+K9lzgBJuqWC67EyrPqy6cubEWSeca8Joosu/j52vUz8S9w17gU+Wri7ki9208+AD9yi2jChxEfu1gMAxOk4gux09oPGIhol3ovdDT/frd6NIBveKEFwcVkXN7zmU3V1fw5DNHKuwGyTlovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H9LTlljMvoK9C76b5C29rypnXbgaeFXTpDKEraD+Ww=;
 b=dXCBvaK6LueFOFQ2X/lzxr6eEKDw43USl7rWPxWxogM+PVvqgZfdMu3D28nFqXFErRRJpk0rOyAeAayVhf/RCZUE0BjvkB7nBVCFCbsv0wQ7dbSUcdN04/FAROvUcym7G4sS1ESjTAhlRYHrn2nT+Xoknfm6PPxSafVH2IU0/JI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 20:22:58 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:22:58 +0000
Message-ID: <c662df85-4431-4303-9865-4189d186a94c@intel.com>
Date: Tue, 24 Nov 2026 12:22:54 -0800
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
 <2b83b21b-7d4f-4431-bee5-70660bd12629@intel.com>
 <1712c0cd-747b-4dce-8231-0c8d75225648@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <1712c0cd-747b-4dce-8231-0c8d75225648@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::16) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8c6520-eff6-4c9b-818f-08df4a68babe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|56012099006|4143699003|261021121427099003|11063799006|261102130727099003|261026121527099003|261026140227099003|261022105027099003|261102123227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: Vubce3BThPmLXZnHRB/c8Msya3CdIhJ+M94/OinYjoatzOURxTkDUtokYpWGQ5tW9RUzrqeLRzw6gRFk8FvLuUCqOS1PhOxDQR0utcWN5JOkJBaCasJzXnLVdVTltZF4+0or7S9v6SiLsYql3OjgQPOgMbynKy4TXj/fWAH8x1lOUn2fiXsurfNvDwu3m6DX8KohcdEk1k/fmZlFpdm7FVBNhQUmoucMz+AKlKXDU3hKJmRbHEpQvqoS68o+7nCc2FUOFk5SDh6Ba/2JLhIzZFy44/kgBF6xlKICwQBv+KfDAq6kQfX4DUP9M+FosSp2fMLaX9eoGWsgsm35otugwy4j/BzU9vHKWUeCnZRNaehhG3Ugl6M55Vm30GY7iM+HPRhHSTCrCw/d43GfGJoMyq0AUlpBYOCbzbSe1gl3Rj8fVBoNcRL/io4WqwSE8MOpWwe9uslqFJauhnUqar6oOfgKnnicsSaG35Prwmth7kWS4Fair+dz4d/9Stj+B0KYybJD90ZeBkR2HXduhQgt8/TJJ1wJRtJ+1nbW4bEXZQMSA9yddWQA8PmLWCeSOLnKwFJ8RPlXQAwhCW7r2ujBzEe2KdzZDOd5Gv3EamucePbr+zB2xfwNGn9FA5in/8+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(261021121427099003)(11063799006)(261102130727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJQUDhTWSt6WVZheEJ5b3FSTks5RndwbWZwQ2ZETjVjeDR5T2ZDb1V6Qndn?=
 =?utf-8?B?RldESzNoZGJzbUI4ZTM3dzZrNEtVcjZJQjRKeXl2amFzUzNnK0xvTzZueTlF?=
 =?utf-8?B?RGVsbS9rRmNzQjVIV0ZCT2hKTTZ1cU9jQ3FIdWhqU1RTb2dIcDBDck9xcG5k?=
 =?utf-8?B?YkpNYnBETVdaQk9oZUxtS0ttTHMxbjQ1cTF6TG90b0IwK0doaFNYNE9WKzcw?=
 =?utf-8?B?MmhlRGdkZGdRWHlZTFJhalA3ckcybytQMVFBTUVXemc3WHJySHRyN2R4M2Vy?=
 =?utf-8?B?bGxkRmVOSzZ3L3NLR0phMXlzV09STklyODFDTkpSem9mZXRMN0g0QmpwOG04?=
 =?utf-8?B?YUwzdGVJNDFhQXNGQ0ZGS25lTllvb250MDE4RUxJdFVYSFZRbHR6d0xzdFpU?=
 =?utf-8?B?Rk5XanZTTS9sOWQ2WkJ5bUR4a2lRelo1Tk0valRNTnF6UFdIZy9Ba2VGT3hN?=
 =?utf-8?B?MUROeFNOenI5L1BuYkpyb1lVUXhqZm9CSjVTWFBWa3c4SytGYnZoTHRMZGlR?=
 =?utf-8?B?SEc4WW5iMWJqcUJFNjFydzQ2YkxaeTI0WFVpNDNVM3V3TDF5LzBYNDJoOVpG?=
 =?utf-8?B?Y1hHKzRmUzM2NC9oQVNXUm5zeTZLR0dXUmVFSk5UNXhwNHBCSlN5TXRuOUdj?=
 =?utf-8?B?QTc2TlkvaDJITVNjMTJ4VEhWdjEyeEE1V0M2NTl2WFA5cGFWNmhLdWNRblBt?=
 =?utf-8?B?Z25PWDRrWng5SW11SmlacEpkdHJTbHlQQnN4SFZRSEZrYngrOGJ4Z2dXeHRB?=
 =?utf-8?B?UnZDVnFQTCtwYXdWRWQrVUtKbXkycHI2RlFoT21FeFNxMklmV0lNL3liTVhq?=
 =?utf-8?B?eWFFblBEZ21CTDhuRDljT1ZvR1FMRzBYNFdJWjBnZlF4d0hPR09ZMk9lbzBt?=
 =?utf-8?B?NTRaVWhRUS8rdnYwRDN4T3RpVDNUREdjMW16VXNYZFZiVHFoTVp0SkJhdzZl?=
 =?utf-8?B?NnJrOTlKY1E4WXAwekJxQzZHeXZvWGRuTXdDdWI1QmlMY2VPdThCRDNHR2hH?=
 =?utf-8?B?a0RGQ3hiT0loUE9GNWMyRHM3QVRvNFp2KzE5WFl0V2RWR25wT2R4cXZ4M09H?=
 =?utf-8?B?QjFvTTRSZWZlVmM4QnplMVhnR1d6dGVZWmdod05Kb1d1aDhHcGlUdlQwWjhq?=
 =?utf-8?B?U1dqR252b3cvekYzSVhkMzU5R0hJQUdUVi9NZ3U1ZlcxSjA2aTQyN1dEYWJC?=
 =?utf-8?B?dGhhVC8yU0ZMRmwrYmlwdzNLaHhVUzNUWHJKRjB2Vmp2N2tkNjZNMFowZXJv?=
 =?utf-8?B?UWdQWkJQc0pqUzNmVUdMUy9YdThoWmhRSFRMMXlQY1lISkRJdTBSekg4eGNr?=
 =?utf-8?B?YlFmRUMyTHB1akhsUlpEWWE1R1loWnpXbUhJWHlvSjU3K2RhQXNiaXMzWG5s?=
 =?utf-8?B?NFl4UGQvQjdiSVNzTlU3U0lYNmQwZUtrOHdPejZYcE5jMHovTGhpZWlEMmY3?=
 =?utf-8?B?WGhKVmNjZVFuS3NCcmNuL2JIMGhnNzVieDFRU0NkYWdWenBQa2lEMnZoUzM4?=
 =?utf-8?B?ZXdQK0ZEbFFzTDJON0RsTDludm9pME9rUDlwVUN4S1RBSzh1dUtYN1lXN05l?=
 =?utf-8?B?K0hGQVRUN0lNRU93RmFiVnR0TmJQMXdHVm5oMjVkZXZXa1FudktLN3cwWWov?=
 =?utf-8?B?OTFLYzhvZlJrK1RsV2hZYWlrNXp4L2N0b3NudVNiajhCK1RxRUZ6WW4xVlE1?=
 =?utf-8?B?TUxDYXFQa2kxQ3ZsZzNnNkJBUDcwcldnR0NqWHBqZGQ1REdDM215TXhRSVV4?=
 =?utf-8?B?ZDVDVTFHOEJ1WnM5ay82ajJvQlJKMzJQM1JacGszY1pxbEZtYWdBdlc4OTdP?=
 =?utf-8?B?clN5dFJOc1pJWkdRaXNscTVmUFd6Q0ZqaS8wR1pGY0s3SjNBejh0S21MYml2?=
 =?utf-8?B?dzZpRWtuQnpIYWt4dGFDbHBTR1U4Z3Q2RUNKajU1Qk0xYmZLRjZNbUx5bENT?=
 =?utf-8?B?KzFuSDZTMUlkTDEvODl5NWtCZjJZWWYxeC9MbHc0RzNuRkRrYzRqaHY5elFs?=
 =?utf-8?B?VFByZWNmLzJiVGs0UlgvaDI3Z0lGVWVYWnRHRFFPRnpIZHpoNUhoeEU4SEVF?=
 =?utf-8?B?eEUzSTFmd2o2a2pNVXN2RG8vY1REdTVya2EvcnZtQW00NVFJMVhkYzZ0RHRE?=
 =?utf-8?B?WU00eWxPUGhYdnpCQ0RMbEF6NGlyc3IvZFNFVElQVDVSUnNHRTR5VzRYU3U1?=
 =?utf-8?B?b3NmdlNvWm5JS3IrbFJmZWZhSmlmbTN5NVlvSU1mQUpzaUJCaDY1bkZaclp3?=
 =?utf-8?B?SFhqYXBOTlNNSENqWm9jQjRLWlhMTWtvY3VTa2ZsU2wvMzdwNmxGZFZQbE42?=
 =?utf-8?B?YTE1UXlLZlpKcGxFOWhMM2tjS3d5em5uRlZPZ2REaFlXNzRUeHdlZz09?=
X-Exchange-RoutingPolicyChecked: kDA/DUs+/FU1hD7lgf788k8EX0hJBZJTVxIjqTRU/CRWPslHlCsqZBOK6Y3eoJAyJ+vGEI/VAKQrTQ20uQGuSt00RKSEsIHwHJTM5KIIS7njIJCY7+eJkgqHwniyI4ykUkY9oyMHhrui5oQoDI2a4fw43naRGbAgI5BlNNIOMjtX57ZHF7vcSNJ42Kjqth7uDOvAc4MtVfhRdMrfIugFLBOiT6zm6BywpjkKw0dCxgAtnXmI5JQZ/iLlL1d6jVlfHAfKL3i5MWFyzVw9F7yNmtDHPXlhlWHznJ896IPeJ9mTfnRI7PK/oJZFkLZbzm5nD0fxUv62nSJ1FPjD3yu33w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c6520-eff6-4c9b-818f-08df4a68babe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:22:58.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2CgnA6aM0H9AD7RuFw80jHHOfylHX0YggTpPfSXmk4WawgrvJUcrxDEvI9H5/jlukdkAg1E57Avy2PYD6lpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
X-OriginatorOrg: intel.com

On 11/24/2026 9:13 AM, Dave Hansen wrote:
> On 11/24/26 09:00, Sohil Mehta wrote:
>> My primary motivation with this patch was only to get an ACK from the
>> x86 side. I believe you may have missed my note under the '---' section.
> 
> Sohil,
> 
> Please just reframe this patch as an x86 cleanup patch. The new comments
> actually do explain a thing or two. Then, the FRED/KVM patch can add the
> export as a one-liner.
> 
> The cleanup can be merged now if you do it that way.

Thanks! Posted the cleanup patch at
https://lore.kernel.org/lkml/20261124200659.471685-1-sohil.mehta@intel.com/


