Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792725241;
	b=LztvBwU+ZtaV3TuCBc1oBxS7Pe2Mni/2pHVvKqAaaXtM1ifFPUpbw4TmhM+WGdkSHVVL
	 lPU46MkljYdg+p5FTKntOwarJt8vVUlvufSC1zdzpiM5ETJjhFkxBxeTPaudp22QhtWU4
	 KK8ZCbboRm5EYWEjvSRb31YV/Iv6sWucQaMxg/sT/1YW+2FVUPO0LmtmAHAe06/YTr4oG
	 T5Nj3VfK4nb71/EV5YSgQvRbh5j0+MI0B6AhKfXfwuzuzgo2gXYptpjYAyIXalOgozs9Z
	 B6on7gpIRP0yDBlr270jDvl2SZoHS/UZh3wBna+qwAD1vDcsw+6Qb4Kv5j4pd63r40g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725241;
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
	bh=pUl3Jv5gxz56icSIZuYPDAsXM5swbqVfcJEMgx4Y7fc=;
	b=tIvza0EARdYR+S7CF8yidG1onIOycZar3q3z00WF+8ECSL5SW59rCHfGmjOWx87oOI1T
	 dgluIx/xPOI2X/sRBLn/O5zkkKhtC96goHSC3RKzd9x8WqgbfpRnawhUlwON8jNhQPFdG
	 1wNw8D5eXaxE/j+3BRnP7JPDIpOJnuNXC/S+1TZ0ydYuxO90N+etRysjhU/arJ5QujZwo
	 F12JwyTVBQ3C5ZfCrqTDkzWZttz0fQIqJFPCeyI1gBbD5lNeOi5A8f8g0cy4ojXU/DR2R
	 R3GtrotXKv+9Jip644K/xeovRzxtF1xUuZjouKpjTSZjc6JsAn/xp1rdrl2wjT9MjuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lOtvsy1q;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCF606A31E;
	Fri, 23 Oct 2026 03:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDCF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lOtvsy1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792725240; x=1824261240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n8kiyb04g3Qd+TK8NApfI/0+ERp0NCzgKbMPuhUAy2k=;
  b=lOtvsy1q/2HQlawmQf6aYzcrq+BrJ9pD1EGRja/Buev1V99nS/0PeVhK
   TnkLG+Q6VVHNZJCwrdpaV8aJ8B6Law7w1X8P7mY21MCdthkUvEEN4CRDc
   CfbLW1EX88BQwpfWTgXV1+LhrQ5LB260wnZWPJjR07NiJ/XrAA3CsB3uN
   ODTzfhpLTNA1j+64awfHv1YTsFc6SZlNJ5+NAmQjll45VlplFQXI6Hld6
   33+SNuXkUu8+t3d43KsYGATUyhrpgMpwP0ox4NCZYZWkcQGZKa0NoLKKh
   WpsHf7EPcPILFCsYos1yLkBE7sSAXsF0WD8zkC/yGzxmD9fZ8W5HSiGfS
   w==;
X-CSE-ConnectionGUID: 81WKLu+STT6vlHwHIM20DQ==
X-CSE-MsgGUID: /hViVh24SFiDq1vFN2pS2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1473061"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1473061"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:13:59 -0700
X-CSE-ConnectionGUID: Puct793RTG+tJ9x5SQ0YOA==
X-CSE-MsgGUID: pTfcSo+6QCqTEe8yfv+fqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3430963"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:14:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:13:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:13:59 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgk9wJZ6z/PyQD2ArKo4QIGvhILGKuCUJvmfHh9NdxJ9MRSHapqePcB7kFbuUzAcRpMoRLUH9T3RifhsVT09sRMVIbHjaLahwV2/gE0q3jGUK97Lj5dhE1TG++B7P/RpvHYW94ri0vJTbwHSBoM58HL1f59/u4mCAonZcDrIN5KV+ENyktm9c8fMfWhCTltjQ8794TUfySNd1BvBTXvSL2eg5oz9Q0LyrBLT87oZHX+pYwNGzrXk0SljX+2bZIug47CjfQZ057PkohTQAvryqLUhPujn7VauG5i+2Nzw2XYgeD4lhp5qowh5sSGZg1H/DBhvUI4R/8ettQEY/WeGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUl3Jv5gxz56icSIZuYPDAsXM5swbqVfcJEMgx4Y7fc=;
 b=uFEKVZ+842L/beTFYMN35KJ7mAcKSD3SS1OQA6aXdQFys1VYSijwRYIOYiCOI6AhTVq6D4q41I/zeTQGzRWISTpaMwyNt1sbywVlerb+rwgPUsWFZ+FJUvl2YA6OqUPsYg/SwND0zO1dYrgpUiGI9/SXCibtquskVA4xGFSdKX9kh/GK6El7IQXp4tIzxo7t5lJoqZnFCWHa4sKFS6ERmDTyBs3Xk2z2TFNH3gSebMyxAOuA3dxhYbjb79pQS2BJ2cq0B6OX1GhByX2Czvy6HzjxO7PNf2/N/9Vs/jGxWyi4ru0gZRlM3gcAzEKoLXF2igbo35AYhF4rrUDIQAu2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DSWPR11MB9558.namprd11.prod.outlook.com (2603:10b6:8:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:13:51 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 03:13:51 +0000
Message-ID: <28ae2f2a-dcf1-4c3e-a797-42e4fb97d0c6@intel.com>
Date: Thu, 22 Oct 2026 20:13:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/28] KVM: VMX: Disable FRED if FRED consistency
 checks fail
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-4-sohil.mehta@intel.com>
 <dcb8571c-47ba-4da8-b5d8-9e7708dd2466@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <dcb8571c-47ba-4da8-b5d8-9e7708dd2466@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DSWPR11MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c23674-d52c-4791-0de0-08df30b3a957
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261022105027099003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FWMbLNYq42pGFUGF7f/L59jN8pH25Pmg+PTWJydwAvYy1FTII4Hv5nLQQydoG4La3OXpEKU/yN0kg4HbNahZ3j/npqmwly5Ka8KbZS3d+JRhrzgd3x/W31QrApEAeFhekoBsVgm35f+BD6E1TIVelSypOTawEaU0TXdHTi78vDYL97YVS42JLsLPSFlgvIu5ofVoj2YHJc+uGzy8rRZJ6Pzx3xycHLttJuP7pf6ZjFfzQU5m3h3bjYW7s7fEHxMCVWjfxKKyqrO0SyDW3Kg/Rz61ox8u/KAC2YLzA1fNQuhaKFsn75CX5df7GUu8XV5fCMr9yVdZzaH7qF/9gwep9hkdQLq3O0yn9lpgSAfGbrDwiLqCMgoHvZtwRgzTmwbl81ft5cGcunStcMtdO6pqPGnvW0e9UCUsjgvKVKbZSE8rzKzNwTHE3zff4hnvJVhG2vTa+5In1EJBlTuTFv6lpxE1njnz+weKdbW+SbxFANi0/9Lycpd2O2QOvCeiHBztTfr4K7rjYR4OtUgCvU9sbEO7xlysszfUnP6y74kB95+nZ1oiyC5gWHmggQGpWUBo2+/hkSKhF4BoDeyFUGXbnHhQdsRbXZp4sRvPhVLVTTe0kq+1vgGfurdWWh2st1QYIHo7j4t6doENdrsqvLgyaANa7NUBlZ8KIdMK8LL8MBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261022105027099003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzY5eFFZVUZZa21TbXRwL1hDVURjMlJ4emsyN0FNQXNwdGNwUDRVR2piL3FU?=
 =?utf-8?B?Mnp4bExLYnJ5Vy84ZUJjeEh3bVBPOUU0Y1ZTQlJZMCtSS1pDRGpKVzJmd3hX?=
 =?utf-8?B?UEtadjY5V09hSmw0QUU2ZndKVVZybGMySWxodjh4VDBSeWJHcWliQmM2aFhF?=
 =?utf-8?B?M09EMlNmYnhQMjh3RHh3MHp0dUNoTlRoNWowNk5ZU3FNTHBMSDVLSDZCNGY1?=
 =?utf-8?B?bkdmMmxmWmI1SlZZR0U3cUQyaXE5Y0JBUzFsbWJCZHlZeXVza243ZTErUjJW?=
 =?utf-8?B?YVIrNXJYZVlIMlVtaEFOTmhvbW1sUzZBcFB0WXV1T1Z3cEpXLzNxb01RdUg4?=
 =?utf-8?B?bzFLWTBUZE9LOU1Ya2U1S0p6YmtHaU5ab0Q1aUJCZlhVMElaWStwR0JqUmZ5?=
 =?utf-8?B?VEk4emlYelZDVUxUQVJvd2c1bmRsQlZSQ1JCRmRBL2dWMDc5WVQwZm5QWWts?=
 =?utf-8?B?UXUwS3B4Wk0vU2p1NGRneXpZVWZxZzRZdklxT0FtN2Qwelh5cXRhTTB4TzJr?=
 =?utf-8?B?ajYzNSsvNFdHdnd1MktYWGszTy9qZEhad2VSaXMvbWkrRmVKZlRPcHVvS0xk?=
 =?utf-8?B?M3ZlVUtmeEtUWnFaMkhJNEE0dXZHU1VRZ3N4ZGtWeCtVbzlEY2J4bmdsMmxF?=
 =?utf-8?B?WEVBeG81c0J1eEtmU3lpRHRXYnd0V204dGE4T1BjZFd2ZjRsd2Yrc0s0RDQv?=
 =?utf-8?B?ZEVVZnREaVM4aTQyNHllQ2c2cG9OYlZLK3A4T2hLSGFTVlZoMlZHUzllcXE5?=
 =?utf-8?B?YlRLUnVFeTREb3Fpa2E1VWV6MTlyejNIN3ZST2N1SEZLb3pjcHBpRXlxbVQ0?=
 =?utf-8?B?a09oOUZhVVBsMW02bytHRFEyOVFvNG11dkh1MDlsSEMzRGo5WlNWQlU3Ui90?=
 =?utf-8?B?cHhHMzNNZndTSmEzc0RXaFF2OWx1M3ovYzZIVXZybTdNcWNTQytCa0FmL09o?=
 =?utf-8?B?NiswUUVWUmRGRlhaWkxldTExWldMN0NQSThmTlZFY09hUFdVLytNSVZsZXpv?=
 =?utf-8?B?bVF2VmFLOTNIcEllVENoOUtMeUhVZDlRR3lHNEx0RkF2akRkS0pLampDcXI5?=
 =?utf-8?B?TlpvR1dLZjc2bG5nVUNzeWplRUpoRkJKa0dzZ3JJU3ZpNTZWU01GRGhCSUVz?=
 =?utf-8?B?NHl2Z0daTHhJc2dweFJiR2Q3dnVrMzFYT0JGa2lvT09nVTY3bngraVJzSFRO?=
 =?utf-8?B?cTFtZjFiZDJ0bFY3Z0Y3UjlmWG8rVnZnZUw5dUhNQ2xPczY0VTV5cUV6U3ZM?=
 =?utf-8?B?T1hKS0N2NHpXVXhXQmUvZldZT2tjaHdyTEdkMHUrQmVmNU1TRTBHVlU3WWVl?=
 =?utf-8?B?VDB1b1lpVEk2amJvMTZIcHVSVzRzTURmRG1YbDc2dHR1RkpjUlNUamZBU3Rn?=
 =?utf-8?B?dk5XMnRhOFozbmZDejF0NTVwZHZLZnNEWEhKU0FxVUNTTHVpNzJRcVV0ZXNE?=
 =?utf-8?B?akxCdncwT1g2UUR6YzNJYWFiVDgvbFZiVzVMSzB0VTl6Q0w2VzZCL2JxVjVT?=
 =?utf-8?B?U0NqWFlxQ0R6b3J6dzB2SEFBdk41d3FBSUQwUkQybEg4NEIrN2Z2UWNVczJs?=
 =?utf-8?B?U2ZDYjl1dWo4WEhXbklpMmhaQytRRllGL2NiK1BhazBrdVJRYlJXUXFrZVZr?=
 =?utf-8?B?WTVnZFlxblliT1J5RTFHWUZiQU9LUU1oa3g1V2lJc29JYjRKM0pWVng1VE9i?=
 =?utf-8?B?QzY2NVFLbHFCOXJuT0IrbFdYNlRYN1kwYTFFRHZwUHNtdDlkOHk5dmJncXkx?=
 =?utf-8?B?WmdYcGJ2RlVKdGxzR0o2d0hEL2E2VytZbXVjUDRROUIrZzQ1L1Z2V2VHWnBJ?=
 =?utf-8?B?c2JUWHhjZnNCQVk5RCtxaGNzRHhNNXkveEtuRjgzLzhjOFFiSm4wS3V3eUJO?=
 =?utf-8?B?NmZPSFVmdis4Z1FNNW1CeDlZdTJhS2IzSUwwc3YwdDI5MjNDNnhGN0UvSlBM?=
 =?utf-8?B?REZtRWx6Qnl1YWJtZmZEMlhRQnJkYnQ2STVQeE1FbTdNaGU0ajJGZzYwNDJL?=
 =?utf-8?B?UjYvQ3luYkVVMGNQQVZZbkpOMHRKaVVsaFpBeEEzRFlUSG52L2hqYzlEMWE3?=
 =?utf-8?B?QWIrc1lmR3AycCtOdTVqSEd6LzJ4dlhpbnE3aTdWTm9lQWVFbGJyRXhlVUpu?=
 =?utf-8?B?RVVBQ0MwWTRDUHhCcWREcmI4cEdTUjM5ZDE4ckNVVlVIdGVsNE45U0dwcGVi?=
 =?utf-8?B?ZVZJdnBKZXpwWUVmNVBXM0Fac0hoYjJNVDlMN1cvRG9jUGhXTGc1NHg5TmU5?=
 =?utf-8?B?MFBLa3Rocld4SUx2ZDIwOUtCMnBTNHpvazNtaG9EQ0FGMGd6M1Q2TnNEUVZv?=
 =?utf-8?B?VDIvN3RyOXh2ZFFGMHlLQnFWS0FNdVBlaG5FUFU2TXQ5bEoveXV0QT09?=
X-Exchange-RoutingPolicyChecked: G/nEW6HCQVC7VPil3cEUsUp3lz8CgxhOH9twPDUqs7fnpgRb0jkEbCNFxusWqMBJw3abFu6BFmj4xpSYmjBK+/MvWdRA21Vsjzx/AmKBr01rxHTYj718tfO9pYxdB4udFR5qGVWOl0ZmwxxwQqBp6HGUF7PpiBWHWzU//s3BtW43DZCPCK3M9wJ0uv7vnaN0FOQUV1AeJ7tjz6+gbvGyGi4MAKoaIaRJRTGVp66MonHLQKAWKGqhBEVIBlQlzwSu2Ev18xoJqC8Db89itlKbONw7/cnk4tpdrkZYmvBb8l4ky+s6uUBcTCVQHQJ67d7JPQqLfs89vL+waemv2WowXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c23674-d52c-4791-0de0-08df30b3a957
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:13:50.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxPVR2wzZqiFzoKOiNxaejxsJYGuOTJbZ8GQJNhgKhmiOJHj8ddqQ19TzCNZ4O5F8KoRcE2NFoBKny3nixl44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9558
X-OriginatorOrg: intel.com

On 10/22/2026 3:19 AM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> From: "Xin Li (Intel)" <xin@zytor.com>
>>
>> Do not virtualize FRED if FRED consistency checks fail.
> 
> Nit:
> By code, it only does one check, so it's a bit confusing about "checks"
> at the first glance.
> 

Will fix it.

> 
>>
>> Either on broken hardware, or when run KVM on top of another hypervisor
>> before the underlying hypervisor implements nested FRED correctly.
>>
>> Suggested-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 

Thanks!

>> ---
>> v10:
>>  - Remove the comment about why not check FRED VM-exit controls in
>>    cpu_has_vmx_fred() (Sean).
> 
> Although Sean didn't want it in the comment, but is it acceptable to put
> it in the changelog?
> 

Sure, the commit log is pretty thin. Adding it should be fine.


