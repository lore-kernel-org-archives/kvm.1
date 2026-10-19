Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792447232;
	b=jzSzka1mjT45tU8qBCKpF5eHB66hXqt/yul+42eKu8Q4UZ2uENv6SeA/kD6bQQud6Y/x
	 fdpGJ+nB5RYgrt2a7rh39LsSBFxS+HHw5ZaMBzaXu95/WqRP6ED2tr0PDiyks3MGDpJzm
	 v2iPg9+08OOcjp9159GWFXJnl4S8A6QUBMEeP5cdt1s3/0yQ6rPEuoJdO3ah3KdqF0srp
	 bZm4mFnndAxGa62KzmXi0m+N7lwQT95KcCNQvf8eGmdWKovTKDOgiAq+j/qXQgem2DJ59
	 W2n8WVSVamPeLq+gxud9ig5mxCEv2kdOsDINTHF+MwiQ1lOH3cwsK8xMTN5evSF/2jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=HCOsBD5MRAyp3gwjTdPrtmO76JEY5Lm3dt30DRHuGus=;
	b=iuVZBOOr1+3Lf2tiBOLoxpgVmv69JKnE4vtCNKlmT5W6VQ1GCmvyglHUVZh2G7kUMtJE
	 cKUQPyLi5XLCw35fz8E2gQCDNhQmxO6Ea1/xbanP782sL8j2itjeGaJdotv94fWvv3fuY
	 B+C0lq2BQZ9ITWXgCYy/yjWyT/iovqShjz3rFiSQ+YJ/MpFq4WZ1DDo9pNU3FyrW7odnW
	 oslq74hxxkrihZuWTN/V+a+7S8D8CvgdtyzBxDybBWtY3yMuvy0yyWFtQUSjZ/otqHJXK
	 jWfJ5L+3QsQnKAbMMsgEc5Y+D1qVVsvpxlfooQ3x6FlkztTOleS6d+QRJillIUTBDMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDCQC2xr;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C6606A319;
	Mon, 19 Oct 2026 22:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F7C6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FDCQC2xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792447231; x=1823983231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ge6cWS2Z/+qkY9l9aeekOiX70bPSSs4eID+IxmDCw8M=;
  b=FDCQC2xr8HnYwbx94at93yFsT25MhLw/hnUeOUza9yuXJ60zQNPxdG3p
   s+EGwrG1TdsuQgybUSjNuRRqAVK4gbGRthiK0xgsNo6x/VIj/aDBrgNn9
   K1eI3hqmuKFHOaW2rdXeW18PG4uK7MmWXo7bEFeAbVRBfDS7Dv4NSRuhJ
   L2NLrDhm6YgKx+D4k2ag7DiAMIo416P3iHORRI7itSnbYzryMUMiY5eSs
   yi6xO9CRH4lPLJyrZe4+XXixFGU2muSi/hcILXrQduGLRvHiwSO40AF/i
   6aK+k4LMbbH6bK2tSQtEjcymtzhl1T9APBFYzaEMf3sxKEPXm2W4x2ezl
   g==;
X-CSE-ConnectionGUID: UGezFk36QeGr2p/t/mL5Zw==
X-CSE-MsgGUID: 7V8B4uhNSfuynbIWTpoLWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1035154"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1035154"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:00:30 -0700
X-CSE-ConnectionGUID: H9NS3HY5Ql2XJDenq5nh/w==
X-CSE-MsgGUID: uBptsEDERqSA8HXhUtmbCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4467855"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 15:00:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:00:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 15:00:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 15:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajiGFqzFGmonnWDgNhkDpbw0RqOWVpLVbWApBBdspsknOv3V0jVKHI7rpWRvhx3LhlI8ewSwIAutrr/IsBuNWWKSqXNFS9dM4ofwaMJ+IUR01/hwi7i/gg/6dvY9WoNQ8b/m/jVWpWG+1G6HFbewTNPoC0aUAQYQ+vE8FNAU33zG7lO2Dh7rGDy+oET3nrPDDx7lEQ/C+4MdOG1EJ/stuZM5W+2dYFUIobtOe034Si0Q0pVJPuPOFdy8WeVKyd5iVBNPADM9ymFg1y73sB+PiZEmgaQqc8XH2JNPqq9qPFCnFeRgCF8TFRx45xZhOcpzTGtvGIrCiyvXQhszqGQO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCOsBD5MRAyp3gwjTdPrtmO76JEY5Lm3dt30DRHuGus=;
 b=jbmDlKvpGf/zo6MMyFixg5fKRJZ6SF0a4gbbt+pjgwNUqWoqiLO4d0W5AWg9+54h7WpjgiCcN/EJXQXaKqsS8Gwz6OWomZ306fyDnKX/rR7DTjaDVQbMzrb2ZCdnFdKfMhWV1pgpZp8DDN/rmKKg2DH2ITq5m0I9PbQcfHCUenLQCyWAOIRPDPbhrZZxqde4KJsLaR6a/OtYWyeyONr2VNRlOBoe5vWWo+haUpL5QtRIRFmK+hq8APNIczA5vRr+EtH538akv4uCG2yMCmAhnYrJOsylRfJQlsQkVQgZEscd7KsOlCst8Cam7yTKjo/Q9UWI3kDbQspwjAjt896xpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:00:23 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:00:22 +0000
Message-ID: <91e0e000-7e37-4e49-95cd-76062097fb79@intel.com>
Date: Mon, 19 Oct 2026 15:00:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU
 kernel mode group files
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
 <c600a240-ed11-4e31-b3c3-779f01175f28@intel.com>
 <e1753b90-f22e-4708-8c2e-0e1d2e0f46dc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e1753b90-f22e-4708-8c2e-0e1d2e0f46dc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ0PR11MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b2d378-06fd-418c-81c5-08df2e2c5f85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NOI2r8b4muyuDZfj4Sz/4AqDdTD/9ic7u1TlvW1rap41BPByKmDCZUJnhqoGdaf9PyNocqrsbYo/RgKnfYAAjwaCnVLcJH28UUEGODtp+Iaa3QKosPBbpVnFVjwFgIcVCfwe0L7wwk8Kcpy3hoMJcIAww7ErM7mBQoS5f59f+3sw4SZ60fQg4GBfBYSB/3qQlst/Gt4OyDaixar+oy3SPA0tUVk7+v/6JQrshh+Nv1Pz9dPa/IzwQT2u+mKToAjAYqZxzrCCIat+83eaNhXYATPEUM6Lc/bB6p62HPLlbk2PZgUVjwVxRe3cw6JEm3Nq0Y52g1zZmYvil9q+e0mjAbfYZnJGF7PsgOYXACs+lutn5f6mhwujV1DfNoMB6v8Z+hS+FILLKnCh1wGlNafcHFWGWZKd6XEFfYfXRSk8AK1Cc/CwvK3wZ0iBYLEz0+k9MznfVvZeAiG//vaw0u3pWw3oAlaK/KcYd5HrNlDgM4unOUeo1KJ9RDLoHrTlUZWbBla2KCoVX17gBtlqIwGBjVy7gHe7uWogAH+yKJt6ppe/5Gty0cia5aTjxL8egP+tGljZi8YO2BcRHSVzRcmZfEPtwsvyr+uGejWyX8YRba2EylyluCaQrrUGVtYyEqiWqauwBCwAK8HS7fi05EaTwMZNlVClHKY5mOMTEUIZa8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtRYzlMT2FVL3NJemE4bDNlT3Z0cXc2cDhCeUtlQ3MwSnVSYTc3N1JUdXlI?=
 =?utf-8?B?cHdjZXV0c2lRZVl1R29YbVBreEhSdVhBMkc2UXRMblJtTFRXcEdxcEZtQnhP?=
 =?utf-8?B?aTBtMHN3VHFSTVJnK0ZSTk9xd0FuQlIwRkhLNlc4aFg2c21OUVlCYWlqNlZp?=
 =?utf-8?B?YXpZL1Erc29leWNGZk9LeC9Ta1FBK3AwUjEvQTk5Z2ViQVBqL3pzZWRlUkRN?=
 =?utf-8?B?R0hNMU1YZHVzUXZDc2RWVmt3YTJNTjNMT2NUR1U3bGZEWFdhTE9JNy9tQStN?=
 =?utf-8?B?MkdUOW9CMDlHNE5ySTcxT2NJdFpOdGRoMExqRXA2ajkwSFRxYXBEL3lVZjJJ?=
 =?utf-8?B?VUFnYmQxZkxaL2ZrNURPY3ZlYWErQStqRC9WNE5JL0F5SG1MRWFIWnJQUVdW?=
 =?utf-8?B?MWQwMXhDZGtaVVRLSHBjZE11Q0dtUGthK0J4bGZ4bU5NOUswUDRTOGgvVUVz?=
 =?utf-8?B?K3RtK1JBT2F1L2xOaGZFM0xUQTY3VWxOOGV4Um9pNXhXcnd4RzFqM3NFRDgx?=
 =?utf-8?B?cjNjLy8vbXhWemlXM0laLzQ1clpId2ZVV2NNN2k0a3RXYTJjR3VzK2VSQlRw?=
 =?utf-8?B?d3F4ODdTNnBWWWg3ZWxVUGx0b056dHVoV2Jkclg5aWVCemx0SXVwcVNuVUc0?=
 =?utf-8?B?RkwvZXFLMi9oQkg1am96UG45TzFCaW9SQzBlK0JUSWJDT0xhTStvM0V5dUJI?=
 =?utf-8?B?NDlhckJLTlpSN3RSMHBRUjl2Vk5CdkJON3BucHJWQS9MZ283VkszbTQxc3Vr?=
 =?utf-8?B?QXJPM1V5RythNmtkSUhuWGZxdFIzZHV2eDI1Z0sxeTk5WnhiOGJzejlNdWlj?=
 =?utf-8?B?TXRCWG5jclFnUnN2U2Y5RWZCMVlQVzVldVZJWlN3ZmlEUlVFSlNPVHVDSUsy?=
 =?utf-8?B?bkNlTEMwTEQ0U0dZclZvTmQ4VXJENXlPWWh2aHEwT1NWTUl2ME1ZUmVVbm5M?=
 =?utf-8?B?Wkd4aTRiTWc0a1NzbEpYNmhxVXhSc3h3Tk96blFZd1RNT0NIMnNiTFk5cnkw?=
 =?utf-8?B?WGM1cVhPdUlhTVF6QUw4S1Q3dUEzalJuTkVkU3pUVU5GRFJHUHZmdWlRT3Vw?=
 =?utf-8?B?c2NMMGhUSlkwbWFsdUt2QTVzOFRtaHA4SmhPVGNKb3R0WVlGYVlybEo2Z2RB?=
 =?utf-8?B?MWY0aFJ4eTZmWWZ1MDNaa1Y5UlFtcmlMU0M2K3NMbmEwNUFwUnc2bUd0M2Vw?=
 =?utf-8?B?Qno0MXNScWJrT05JTkQrUFk4Rmp3Z05JU2REOWxUUkJaWUh0UEtMK3lWYXp2?=
 =?utf-8?B?dDBEL0xKbG1lTkE3eGYvSnMyd21iT1NZM1ZqVDBQd1NJL1dLd29vVmhldjEw?=
 =?utf-8?B?VENva2dUMUpkS0pYbTkxZXRLWURpRDlvUEFkMFU4UEU4R3NYdjlEUVMzUkJj?=
 =?utf-8?B?ZVRvRkdsdlpmeVo4bW4xbEltUmt3c01sdjBuTWZOR3Q4OFlQSTlqcmlkbzBN?=
 =?utf-8?B?Vk5zdjg4Vk41amFCR2lZYlpnM09LU0xlUURxbDFhTWxCTE9LdU1HY1NmU01x?=
 =?utf-8?B?NjFUTythZkNQMm5uaU9qM0QvcXc3VHJzQnVyZEovUnRqOGI0VkVLQWdUQUlW?=
 =?utf-8?B?Y0lBZjJ2MzdZbSsySWxWUVQzd0I0YldKUTRlN3FNMHNQcU0yRjUwUHRuaWNJ?=
 =?utf-8?B?VVhFNEpkVXVqNHBiVDFaN2JYc0RpbEczN0xiUnFKRFJLY0JYVmkwdktMQlFh?=
 =?utf-8?B?aDYzVUZISy9kZ1ZXSlhJaGkvMVdMT2Q1MnlKcUhPM0UvdGZZZktCeFZUVFJK?=
 =?utf-8?B?TkEwSDBDNDlweWlhdjAyOG1tNmgycEViQk11L0ZSWnV3VHBvalFWejNuRVlX?=
 =?utf-8?B?cWZYQjhYSlhJa1Q0OWsvc0VtUTZCZFlDTkxvMEk0ZU9MbDBwbnZsOG4zSlJ0?=
 =?utf-8?B?UnYzVjR6K2JtNHJsakkvdEJZL2lRNzZ1RmhuNitqU3pEY3d0ZEFtVDJxbUZD?=
 =?utf-8?B?Q0kyc2w2OVdvNmNZN1lTMmhXZENoY0VwaDFwekQ4TkRDMHZ5NVVtM09DT3Z1?=
 =?utf-8?B?ZUFtRGtLM053cW1QT244TS9XbldJTUFUbG9EOWMwTXJVbnY3cjFITlppd1RD?=
 =?utf-8?B?WWhNVFFWakU3RmR2N3pVdE43V3VkcmRJeXVMdXY5cVZnbUJ3QU5IWWhyMGps?=
 =?utf-8?B?UHNVZ28wRW5IV1hHaTZzdjhPZXBIN1VjcTY5akRBNnZ1VlNhKzdYY2JhcXRL?=
 =?utf-8?B?bTc2UmFsTGtrWHFXWTVFejdaMDJxT0d1TkhoTmFwL2hzeXhVTVBoUUlFaEtp?=
 =?utf-8?B?ZlVvbUJXdC94a29mYmpCRTljZ0tTcDhmZjcyOGwxM0poM2N6Sm5jQlowZU1L?=
 =?utf-8?B?RExvSXZzRnB4a2ZURE04NGEwUnVPWWtkNGFCWkxiSFQ5UkJLNStoYzRFOWE2?=
 =?utf-8?Q?4+GZIouoPoEm2FCg=3D?=
X-Exchange-RoutingPolicyChecked: J28NkmBScBlFx7e8TW6HG2V2wf3CbODQRbAA7VXw/P9y/+vO6KDcXG1tt2e491zDdt+ra4Mmp+OgLdiQylm2dZDDcBKRkbX8aHRCW8E0taK/M3o+bTvJrdSGMsu84fRtYGVSjhg6JKjORk3b935SEmig6Xyi9qSi1LrOiF0b1ff+96BztUXqvf3/n0u8H8KQV8QtsXDKeZTepga52nnM4keQ2GhNXWOyzaFAPh3Lrr7EvTp4Iiqs30DhATQtDrWZ4P1MQ0QO6imHxESl/m1IihvVC4uFG8Ck92BplNW7JkB1Nq8gYckTrYepqEN+nhg3gVm/sqQWYSb0e8JiiLG7fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2d378-06fd-418c-81c5-08df2e2c5f85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:00:22.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xybqx8MhuwxOWQBDCg/80fpVO+CqkX6owYCCBh+nHWjlFls4Y8jx1QAk66eCTAevm+XoKYyWXyGtD925JdtjjhR2IDlioS3FjLtUnvDrY3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: intel.com

Hi Babu,

On 10/19/26 9:31 AM, Babu Moger wrote:
> Hi Reinette,
> 
> On 10/15/26 10:46, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/1/26 8:10 AM, Babu Moger wrote:
>>> The kmode_cpus and kmode_cpus_list files are specific to the
>>> RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
>>> hidden state when an rdtgroup is created.
>>>
>>> Introduce resctrl_kmode_global_files_show() to manage the visibility of
>>> these files based on whether the global per-CPU kernel mode is enabled or
>>> disabled.
>>
>> This does not sound right and does not match the patch. The visibility of files
>> is per group, not globally whether the mode is enabled or not, right?
>>
>> It is ok to have cryptic changelogs when changes are small and simple but these
>> changes are not small and simple.
> 
> "The kmode_cpus and kmode_cpus_list files are specific to the RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a hidden state when an rdtgroup is created.

Could the context please help the reader a bit more? Some items that could help:
- *why* are these files specific to global per-CPU kernel mode? (mention that it is used by user space
   to do the per-CPU enable/disable of the mode)
- *why* is it created in a hidden state? (mention that a resource group can only be assigned
  to the global per-CPU kernel mode after it has been created via a separate resctrl file)

> > Introduce resctrl_kmode_global_files_show() to manage the visibility
> of these files based on whether a resource group backs the global

hmmm ... resctrl_kmode_global_files_show() does not actually do any
checks to ensure the resource group backs the global per-CPU kernel mode.


> per-CPU kernel mode. Hide the files when the group is no longer
> associated with the mode.
Could the patches be organized so that this becomes a symmetrical change
that highlights when files become visible and when they become invisible to support
the description within this changelog?

> 
> This avoids exposing kernel mode configuration files in resource groups where they do not apply."
> 

Reinette
