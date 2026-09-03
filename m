Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673993C13F8;
	Thu,  3 Sep 2026 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415814; cv=fail; b=gMa4cAP1LHa4F5Phk6WLElOdC1h23qOT1xzcyQJgagqA/vDSxwJdCZExd9MjgjV/b0PhWzdKqvSQisDV/VnKf2/Ef5+mhEx6JdOCjXuaj69Lddvso+5F1OZ+a5IVnCaea+56vkocJpOPfGr89uYnm5E6oT51HDFkOogLhnNoYyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415814; c=relaxed/simple;
	bh=OM5t7ZJowekLANdnqttxfEHRybOJdNAlyNduATdXe8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oREg8BqQMcMoibZUV9Wec8ueyAF9i11FbdMfThnwZ6a0zep0LE/Vzbc2okwTAYrGBw3H1hEFMcrcf4C8H/9pIpHB8xRORD/HnxkrIBNl/495XIyZJY2nnjZcS0BZXtGdoNKE/LItaKkTtM3ud8c3q6IOHAxEUpH64xImzzsm0IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmleCCCK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmleCCCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788415813; x=1819951813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OM5t7ZJowekLANdnqttxfEHRybOJdNAlyNduATdXe8k=;
  b=LmleCCCKIFwttn1d8HW7DjVEY9vL7aavIQEX4Y9ypHKlyjXnuE/2p3/k
   0U5bZrYSPwmH7uf8/UjI49po6b0pc6cOSh9m+RzWIThc8tve2/Rkm1BTl
   el1qpmTKbXl+5IEUc4Uzzxv9Fernk2T8lat+NOE0FmFlJxvqzqIjFoq9P
   /WFo+iV1JwPOofc8KTIxtKkbO6T4tCqDHDxXBcm5I/P2FAhQfu9o12fuH
   lKxFGAPaLCJNywQgn/q8GlUhg79TYlHITrKk2T80lhLf73kJzknKr3tTN
   ot9TP5OY7dKcxS9Oy1jPVFSM/Meu/vX2X2GNVNaavAesGwxM7mN6Z50Y7
   g==;
X-CSE-ConnectionGUID: iurmsQytScCUTT3bnTcXHg==
X-CSE-MsgGUID: AP7hsjGHRZi1gSYS5nEq2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88907827"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88907827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:10:12 -0700
X-CSE-ConnectionGUID: s+bRRrrISUeTHjqrUArbMw==
X-CSE-MsgGUID: vT5W2N0wTY2Ti4zSvNreDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307822765"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:10:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:10:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 23:10:11 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 23:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDZmCXizNLLVR4sJwam1lK4ubYRcGlwsFn7Ja/8V+t7MD0tTyYBvcpo4UXLsqPGyQqAMPaTFJJEF/kMI2DxOnoll2+KMYqTr8fcVX/v+hMk6cX7jMkr5UlGg/TJM+d4O+R9epj2PfCTlEZK7MPc2jJN+KetFdqFfkvlQqn4CkpEY+WVnloPWuN4PGstQvej+60mS+olod8Jhyc4o7iu//lVOkhHOPs6JRD8zicBLcD68kL6AVZNLcAvkGxnd4lLCymEWejblY7W1+QrRhdgpzcPxCXCE+ncgtAKkQ+fs1ET7T6rAMjy0N9bhMb5LpeRadKt8hrtqz4cWttAjmpmn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwMJN8ybAyqXhWF1y72RvQczCk43c1xwMQ9hYRt6Vic=;
 b=P9cbgO6j0jDjRuSEItKNBvkaDwGFuZ98jrKA4kzNUioDOErRUbkm8L6JNJACVzhZb/d/TjSJrq+hkXgIwh+yvp/6SKXiLLrd5OZlXsCF1PTu3h0qgzFed+JFD4D9l5O32HiDFklVen+Krs32/0rtJnBAF8AhNxJS3Iz61Mukb8nR5aK2J9fvpl/vnYNemL09VkHinItMfuMG3PrmaF8Be4lr78kWGZp8KcpngsBeE4dEE1Zd5Av4aheaPmQ2QFeA29DlN05xGE6l18RVSnC3ikMy3TRF50oV+t+xuV4L2sYO2tMqzdYvQqe8wvkT+5wR2WbgzacErszZSPp1v6rAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 DS4PR11MB967382.namprd11.prod.outlook.com (2603:10b6:8:50d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:10:02 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:10:02 +0000
Message-ID: <0c2881c6-3352-486d-be59-e6350fda9ad7@intel.com>
Date: Wed, 2 Sep 2026 23:10:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
To: Binbin Wu <binbin.wu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>, <chao.gao@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-3-binbin.wu@linux.intel.com>
 <73beeef9-3ecf-49fc-87e3-6fa30f8f56d3@intel.com>
 <d47c8cc6-242b-4ebf-89f2-0909abdaadd5@linux.intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <d47c8cc6-242b-4ebf-89f2-0909abdaadd5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|DS4PR11MB967382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aef4d89-05ec-4d1f-e850-08df0981fdf5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: i5BnnTfmSLl4AAmY04pcDX4j1ANfaYk831um35dr7z9YXSTdUrpI3I8w0cHLwlNVlbrSjwYnjuktpW9SHGfMVsTcZQWeUO+IGixDZiX/j/6KCgZvMxgUQ7X95b4FukRjNYKGoyeQxcRMLy/bfKCQGFwn/m3MhufiZ1wijAMsa9ZXk+BtwaNsdA3ywhEUA93pMGw+QFniFeJH5RPNPvrleaa46zXvyAFCy5symYCSso+5WoMWRzE8H0G5Jbvq5y3+YXAPa0/eK0WNBSC1SyOiofmyz+1RhVmjE2bz2Bauv8rvyH7MEYUzFwAuv/jYdNeKDZ0u8JYR3pnKuYgIziB5FsgwWJTdEBPDUXkDkEs6ZIiFoKIJS+eXybZ8EAT1lDPWjzjNIRZd9jL/Z7Cf+ymKXD/FffOrOcUjmcdOPdewemvvdWJJsh/sfE3IMFqjkewcdRWZ1Mmrs0f1+2aG8SmzJtP/9dPE7Zr0X+v2Of/b3PcbQjOThjr4JpYjT5dY/DM2YpN9P0iMNxjwLnQJjNkHjDdweq48iiSmLdHxecGtJtahgKOj6GY6gb8M3z4Bf58ytwl4K8UYvFE+N7k8Hpt81DHVba103wWwIG4W91IfmI7hPbGlrdaENBuCQuR825miuL46RiEasCnPY63H9d1h9vUIoW1hRQQTOwdt52eJLR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZVWWZPVFl2VjRqTlpucFh0OWhBSEZINlhFdFJqVU1wZTJHRUhHWFExVkZ2?=
 =?utf-8?B?NU14TzhPYXpPdTFNQ25sQnkxZ0FXSFN0NjMwMHcvRDFGdDJtMFNxeWtaeDBr?=
 =?utf-8?B?K3NCRk5tKzBkYWpPQWdjbi92dnVNVWI2ckI3YkdyWCtFS1pXL08rdzMxOGZa?=
 =?utf-8?B?M25vVm9Xb1pWZlNpMHU5SDVPK1p4c3Q5anAzb29ZUHU2QXRaSXppc1dWSThT?=
 =?utf-8?B?ZFhLZ0pSK0VBOUh6M25mMk5DWkpYQW5BWlBkOVY5RDBka0ErNGxYQnZwOU96?=
 =?utf-8?B?N3l3UUpER2wrUXE1RXdEa0MrYWs3ZzFQUmhUbkZXd1h6YTFMS29OWDY0cThL?=
 =?utf-8?B?WTdWK0hBanpPbU9zQ1ZXaGV1SWxLUFNZTFVFby9tZVFxcFE0QzR2NlcrT1VO?=
 =?utf-8?B?ejZ0bWhRNS9KLzN2cE9xSnlEd3ZJTjFBL2d2Zm9ZL2w2ZU1oWkNIL0hSRW1r?=
 =?utf-8?B?SVpnSlFCeHJsT0djVVduNTY3M0NxTE5OVDAzZ1cyZUlvM0NCTExqaFo5YWcy?=
 =?utf-8?B?MzlUR2FBT2JIWmZqbllqL1hBU3IzU0V0TjhqYlBjbzFiTjZnMlR4OG13dUJX?=
 =?utf-8?B?bk9QQVVyNU8xdFE3NkQwM1FmSGZZaEl2ZW1YZGU5VFBtQTB1RVQwMnpIM3Mr?=
 =?utf-8?B?THVsN1N6eFdZVHMvTFA5N3BDeENUYnhSY0pJaFg1VnFkOTZ3T09SU3EyNVhM?=
 =?utf-8?B?YXRNT0xwelhucTZocXVRa0JzQzNiZUR0TEQrQjY0c1hvZ1lOdnpIcWJ1c3Jo?=
 =?utf-8?B?bHVFSmpsaVZsMFgvRStFR0JRZXlMT3h2RG14M09JWExuNDNUWGpZMEV4SHpN?=
 =?utf-8?B?Z1l5VlpST0RuK0JZeHRLT1RrVUpRZDVKaFZvR1FzcFZxUm1nV3M5T0dhaG1R?=
 =?utf-8?B?UlhvVHY3Y2MvdjByNkdNVEdkZ3VBMm9yekJVaU9IbVZFeGlPQndBekhRdVpz?=
 =?utf-8?B?STBRL0pGeHh6ZlY5RjRCYk5PM1dBcTAvMUVUNVUyaXpmZ3BtRkFtdU9ZUkh6?=
 =?utf-8?B?UnlDUjhiVGpXdEJ2OVUyMWVhUk02QSt5L0dGZFo0NTcwOXEzSTlwVnJaMGp5?=
 =?utf-8?B?VTNxZWxBMTEzb0NUWVFzV2FaRkJ3R0hreDUyaFUxMGhRcFZMVzYrTFRvRzkr?=
 =?utf-8?B?T2RLbm9tU0l1NVZ6QmkzZTl3VzRCcWtQdDVWTCtRTG00UlA0TEc4anZjWlg5?=
 =?utf-8?B?LzlETzd3NEpBazQrTTExSldLbFhobmNYQmFvQXdjdnFkcVN2eDgrRXJNaUJz?=
 =?utf-8?B?MXM5UUs4TUcvcWdTUXg0UlIzaGkvaHROUndmVzNRRHBTSEJZb1VpTlEzb01k?=
 =?utf-8?B?eWEvSHhZMzdOYTF0cFhESHBMc3RaWENORENyaEdJdkNiRE82a2JFUmlWK0pK?=
 =?utf-8?B?MmhHWERwY1NHS0hGY2ZZZGExTUwzdXRKZzdNZCthZGFJT3NzUndoMVptaVFv?=
 =?utf-8?B?RG5GRWhRdjc4dm84aHhKWUNUb2g0ek5kNzhuR2pXeTFKV3lrTDFDbGZIK3FE?=
 =?utf-8?B?NlpiOEg4eDNYdDVtSXB5aFlOWlhmd0dEelZpNDVrSTlsWjByYnNubW9OOHl2?=
 =?utf-8?B?ckpQS05YNVF5blV1MzZRN1hwSHlDS3JDcWJteXZWMFpPeHZvd0JNckh4VFpE?=
 =?utf-8?B?YW1WSlNocExBbG90S1lZWDlocnlteXZPN2NwMkRTTHkrSUptRDFuRnMwT0dK?=
 =?utf-8?B?c3RuWkVadWcreEtDekZOZkZJb3J4S1hQT2VncERXbEJ5a2toMnR0eGpkSE5M?=
 =?utf-8?B?aHlabnhDYU0wWnQzRytGQjZlTEhMYUVoZFV0YTYrZnIrRTZ4a1Nia00xMmFj?=
 =?utf-8?B?WEFnUzN6Zlg2azF3TGlMNjgycUp5N2RLaUpIMWJBNmJXajA3VE9NdWl5TVUv?=
 =?utf-8?B?WEtvODZFcjZzQ3UzZ3RuVjI2bUZsR0NlbytKN1F2eGFCYXIxWFg0ZGN3aVJE?=
 =?utf-8?B?OGtGQno5Y25KQzVIdldpb1g4c09teWhoLzZJSEhlWExkUU9yZzFTRXdBTlBv?=
 =?utf-8?B?OWxlekdyMzBTbWRjcmxKOWViRWdkQnNFOUIzQ3BDdDFiK0tJTkw2NzNOUWJP?=
 =?utf-8?B?Vys4YkZ1MVdXd3NxL0dYTXl1MEU5amYwYzdUZDdwcjE3OWlhdjRFbTZuS01P?=
 =?utf-8?B?OVBaQlAzSUMzWEhBeW1ySFJlK0M0NitEY1gyTVUwOFBwRlltbXJQcDJmeFpj?=
 =?utf-8?B?Q291cVVReU5qUnhsQUVKb2d4WlFJS1h6R0VoVGEwa0VFWnJmYWkxWXluU200?=
 =?utf-8?B?ZXkvOTRJVTBBeTBINGpmQnI4NFI1MTdtOHlGdm5DNlNqTHdrKzNNRlkyYzlB?=
 =?utf-8?B?bUpVWW1US3BOSkNza3lQelpoOVM5NUcxdEhTdS9LTFZHd3VONVFYQT09?=
X-Exchange-RoutingPolicyChecked: DOEUaZ8zil7jga45R0phNPYMTXG3XwjaSDdlaGNDUD922nPV254fxcDfVVjpzRHqRwKfbN3v9nENBFMNtHy27RzvmNzqMPLLOlGTMKB2P0b38pXpVfn3VudkDXk6Wiz7aGi2f3U8SI/A/fOz8Q+8tfYWsJMi9mhPf+3opENPnGhN1+vWjSst/mLAOBLMKAtPbfmvyDaqng2TUqXPu0t7fTVAQ3cYN2tQcmVNGMJd93gj7/wwC6h/Tx094mAHmmvCj45SixSm0djnb2N+UJ4ruHczPPRjNOG6b94Qi+6YCPKn4cVCFgzPqPoUzkjGxrdWZscWSLVOLn0+KPQskjRQKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aef4d89-05ec-4d1f-e850-08df0981fdf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:10:02.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctd34Q8ASv5nks07BIzgG2YKPT2yFKNkgMYZ7qsv7C2thfSfY44yHlHQRy5IZ8iDumilZHik0fdpLXxVmYL4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB967382
X-OriginatorOrg: intel.com

On 9/2/26 7:22 PM, Binbin Wu wrote:
> On 9/3/2026 1:43 AM, Kishen Maloor wrote:
>> On 8/26/26 8:18 PM, Binbin Wu wrote:
> ...
> 
> Actually this is the #VE reduction on fixed-1 bit, which changes a previous fixed-1
> bit to directly configurable.
> There are several cases of this category, i.e. MCA/MCE/MTRR/CORE_CAPABILITIES.
> However, CORE_CAPABILITIES is the only case that KVM doesn't support for non-TDX
> VMs
> I will add these info to the change log.


The cover letter highlights the deprecation case, but it sounds like
you hit this now due to #VE reduction. Is further #VE reduction expected?
If this is altogether rare, then yeah, added measures aren't necessary.
