Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816B3CB2F0;
	Tue, 14 Apr 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160775; cv=fail; b=Mq6huUOthRpEewferW71/3qpe3HtbTeW2lasXKL1OnACwGVc0ZF5ktQGyPOPmXKrk7WAIHlLGRSsfkadaWdGqAQSKPC2u5Zvop5ciqrG/ekp8EeRkwabGnsZaEXbbx/PC4MJHA/gRWUgd2UQAm00xkjDFigKS2ay0HiHnXgug98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160775; c=relaxed/simple;
	bh=DhVC0uO5K/Qvztl/02ducs5pcl21mWfBlX0BcZ13Hps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h5aswwIb9bE8chofaUa5IO77bB7t59XtQtuSJKPGTRQY2RAXtKvacux6+WXIMTvzXBsTxf35VqalAByCFcyY/CVx4HbmqMc1cn5WAFG4VMUWJqlk3mqogwKetXEedp0kozPZvK1Mp4CcqMxdC6KRE9HIwC3hhUjA3tlpmfmKYa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZFRKO+n; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZFRKO+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160774; x=1807696774;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DhVC0uO5K/Qvztl/02ducs5pcl21mWfBlX0BcZ13Hps=;
  b=FZFRKO+nnGsmAi+C3vOsQC8xysR5LRWcfTzokZYEdXtAeE2Im7dlUf8x
   t3I+ObUNpO5J+8qyRvLB39av+T2G8+TlYGfXLSOiJk8A9BkgnyHgeKUES
   oA41npuM/tcNXvT1JWehj2QAgYrIMLwL22mkXWuHqCDoLQEoTBwpbCZHM
   K38j9joWvtaybw6eQSrV4JiMkjt+DnGicYsc7Y5eMXPwJ+D/USzRfnnMX
   V+AQBJKtwNyeyS+lsLEX0noFqFvmkBOrxzO67ITWQRcl/sAUp40Z5b2DA
   lHHX8skMeKmDYQsM9qpa8jrz2gUcdrTgI9Jfu+nkehHVL6tKGgn1Otw8J
   A==;
X-CSE-ConnectionGUID: y5VI8gzoSOaV0QP+eDDOzQ==
X-CSE-MsgGUID: GmbQfcLQT8m7YdnE8zBzTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="88191638"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88191638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:59:34 -0700
X-CSE-ConnectionGUID: BHKnngKASNK+kXQ1w0Up3A==
X-CSE-MsgGUID: YvQqu02VQt+a3TByludYjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234095019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:59:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:59:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 02:59:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 02:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtthLZIZy95+G3DSuDSDO7uBXMEPs9fIssJW1jGBjjcHOjkE2Ljw+6QyFd7ZfpBczSzjfSScJQ/1O/+p8QG/SQMr6n7v3IRe2a/QOaTqOCYc4SZ+P5ckJ9tK5F/o/V6XGD9S58MVX75dDz8Ohqv1kLtO4BMzSErOLuSll/WcQNe6eRX5bc27THDg//07wzUr6lo5F0MiMuBXsvjc1mIaUuWXEcgfdYDFlTGuEATQTi1RMeS6IJewqQuXn3IX+z2phDwc5ngqhWG+j2Wuhd8Ysbs0NVJeyWe9AmKlRmCGAcfE81rM9T9iF+tynSCNHIbt2BrzuIUgqtRNQfZUX0sXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfhW3hFmiP+BlU78xbE2JAJPvC735tUK0EBxHOezAn8=;
 b=ObZCrap4yY9zckooNl6e0+Z1lc4meg0oCoLBUFrU568OgwyVQXsKaGpnnPtklnCLhNheQTt+KpSNAdlcAWIXCqBUsDdfqcPLK6esT8L7dnBmshdCw+567IUtVOB6j+6V+hhftq6rvqu0fHWlzyOmkzU7vcmnFGNZqSX8Pj2i5N5Y5AUbjNKBX3FAAdN9SWamU8kLScq8n3WzMATt7Sp0939wRz1y5wzni83lOThp5b+ELrtcVSZcnxXXC8eoifyvncfNfM+DxFe3Cv8/GxfqPfFkIP0AgZM8StLSA++4QWHUaxz0t1yKb1LErUFLVF4yex0R9gxeeFlEyCuhHlsjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:59:28 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 09:59:28 +0000
Date: Tue, 14 Apr 2026 17:59:16 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <ad4P9HZEOnC3wUH3@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-11-chao.gao@intel.com>
 <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0045.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: ce61ecb2-644c-471d-e65d-08de9a0c845e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pw+GstTs2q7wL55Org9VTYyq4RiGOuwflKASS5XpqBj0QN4D88XRWzSVhTtgGX7PzwiqUPypJ84Ze1Oa9gzhoBN1jMX+qVemXgqVdsITN7y1mGMEtdxv9qd+mr6T/szUybX6BYie6/XdkuP7DjrUCFv6yws+2gv2nWUyQD9KCuqx+8/GVttXXj/lwn5u82dCf/MYzO8QI536lFfurL4gumPehxzjchvRqWs+cy/GOzM8dTOnlsX9naUOntHotQDS964VzgUP6X0cTGvg5q//30qyUqHwV4TrXq4+S7WXUI5CW2t+MU3VxMgExgZCTp4wDB6vud2FmarALN72lAOLifUcVb1KZ5i9j9ZHJ2h6mGBXQwaLuKTwragCXkTOsVKaMKuidtkouHctcuTCNTJ7Fdu+fvvEiLI6olqiTFJxwXd8ETanF/cnFoaew0tofDxzSYj503fqWwurLa+oc9wZyd8LlsH/HHsBeN9VZAFTmWJdzhxN7OUmnYYhxH8N3GfGQJ5Mm8VlHD5v/vQJdHbUPZU+Pu1iJ92cBLUMGvxAaBQok3YJH7PDrrk/Rgf1s8M5nfS6CnME1j+3KcuXvrT97DeldiNVLokLUVN58SiV5zVtSlsdxMx5R7vo6jVxJaJlRLjhqQxDD0ipft4M2cGrEHAERKOgvPnuyAWA0J3UD2K/URNQakNGN/z7fEvMzXjgPBl9+NwPhzZ2sCEZb28akbW2wlwPCThhaSLMlQlkvEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRvUVBpTERTUmdyU0N6SkJHaDdDd1MwTHlYeGdNY0NtNGJSZGY1dHc5dGdR?=
 =?utf-8?B?L0J3Y2ZJRlRPY3JBR01WdVRnWjkvOURPcTViWktBWUp4NGRUOUI4MkFpVE9p?=
 =?utf-8?B?UkZCcGU2QmdXaHRyZHJZK3NrMXhYbEF6NTdoUkxaMHFMQmRFdmlNTHBZQW1I?=
 =?utf-8?B?Qm1qMURuSzQrakRYRGgrbmYySERVajVoQ1RwSWU5Q2NHZVJKQzBxdUFSS1dj?=
 =?utf-8?B?eGUvVjgvSWhULzF1VVhUVStINjdEc2loR1Y2ZDhmQjkxRFNHWFBGRVM2RWF1?=
 =?utf-8?B?RmpremRoRHFidHpsdEtZODE1L2cvaDdaSWZ4UUdLd2hiV3V6aEJDQlNvU0wy?=
 =?utf-8?B?ZXc5QTVMTzBoQUkvRmx6ZDdBbnZqNlNUeFRIMTREVXVxbmZUc2lGcGRjV1lX?=
 =?utf-8?B?dHY3MDhzcStsakY5UzU0MVVCNmhlWDJmQlYzVUx4dmFQOTFtd1M0VlNkVHpq?=
 =?utf-8?B?UGZQajdCSGhpOHQ1Q0ZueTlnTmZQY2FiOThLdCtFcGRLR1NMb0YwS0EvVFph?=
 =?utf-8?B?NDhjaWlCcmRod0NQWVBNbngwa05SOXVaNE1KcGhPbWJLOHp5SmsxbS9hbko1?=
 =?utf-8?B?K2syMWQ0Y1pBZFIxWW54WTZkWXpWbE1rY3lGOXB0K25KbWxFUG1KNFdUbDU4?=
 =?utf-8?B?czQzRmlMeGpiSklNTk1NN2dEdXJLU1BVUndjMUdQTC9jRHlGYTIxR0ZPU2Nv?=
 =?utf-8?B?bTM5UTU2Ujd0N3RBNmJiWGpRbGt1NzZXQTNyRmhqNlNock9PdjZDVTljYmVr?=
 =?utf-8?B?NzQ1aXNkNTBGWXA5MW1JRGZUK2dZNENMN3l4eGYrd0xNZ0cxc3l2V0JPTDBj?=
 =?utf-8?B?dG0wR2V3d3RReEtJZEVlMzI2VzZYVlI3MWRaYXBGbFVkQU1sb2xXWG1IVWNo?=
 =?utf-8?B?TWw0VFQvbHU5OUs4aEJLaTJIY2VyZkx3MzBveEdRYk8zTnZZd2s5ekwya2lu?=
 =?utf-8?B?aHdwVGpteWtma0RzNTU1VW4wYzdtUmVYeXFRSWh4bjd6Wm5XNC9Ba2FlWHRl?=
 =?utf-8?B?aHkwK0RHVUhtblJjU0lHY29OSlRWNE1pOXV6MUJHUDJETHRkQ1huVWkvbFdK?=
 =?utf-8?B?dHlzUVc1UWw2K3cwWGpuaUovQXVRZzYvaTlIM1pUV2RDQ2tsa1BmdFNnazMw?=
 =?utf-8?B?QkJPSm5icG5IaXZnNEg5TUJCeEo2b3dOd3lTb3IxYm5nd01RaGN3T1pJYXBw?=
 =?utf-8?B?MjJmeXBLTnp5bmNkb1JHMDJIUWdMMkY1MFkxVXM3MW9nV3QySU92UWZETWpX?=
 =?utf-8?B?S1pEeThndWFaclpXcXM5OHZ5VHdRaFIyT09TSVRtcGJWbzQ5bFVJWS9DQ0tE?=
 =?utf-8?B?TmNmNTA2djA3UDdDRzBId29MYnBRV2V2U3RwSGxuZXh3VjVQTlcwZjV1ZEo1?=
 =?utf-8?B?NHVFTDNIOG5IUjFMZUVLZHZSeDVxMVFFMmtBZTl0QVNOTnpOWHlnc3RPN2dh?=
 =?utf-8?B?WXpNekV0STNFeElGZlo1bG90K3ZTV1NPNEVEd2t1UmFuRUpCUDVCZnNhUVpF?=
 =?utf-8?B?S2ZnaXRDWk5leTArR2hSaTFrNVUyUzhodnA0dzVuSUNOSlM4L2tuQ0RxVEdM?=
 =?utf-8?B?clV4Tno5TDFqSm1YMWtjMlBJeTR5VGNBWXArVWE5cTdFVEFjR1FacVVMUjNt?=
 =?utf-8?B?MGVXaS8wanl1UDhlbGtOUlZZQ3dEbEx4MnIxdjZjU3d3QWNWNTlsRlZXSWVz?=
 =?utf-8?B?Nm9aMlpwZEtnWDZ5OXZJT0EvVjVaQVBmbjJxMGlOOHhNSTJwREtxU2txSHNm?=
 =?utf-8?B?c0wyNFRObk9ISktWQkZTUk0vVm5DaDVFSnNzSzAxb1UwaXBhTTVyT1IvY2k2?=
 =?utf-8?B?ZXhYQlZRNXhaZ1lkSytzQU9xVGE0NlZSZ0FkMWY4UHdHTUlRckg3T01aSmlT?=
 =?utf-8?B?ZXVzNk9ydzBrT0JxUUtlMVpXKzhZWHJZbisvektneDZiZFVFamN6Q2s3emRV?=
 =?utf-8?B?OXRvSWdJZUFOL29reG8rYkovc0RwekpDRnBDcDdVL2I5ZEIxSitJR2g3Tmlv?=
 =?utf-8?B?UTQ1blJQYXlWU3htM2FwWWNRbGlLZXRudDRzcldrcWtERWVLN0tHdXNTdTFX?=
 =?utf-8?B?VWRkYUZWenRRSXhkdEs3TjBycU5odDhHTzlmVEgzeUtVdHNucnRiS2Z6NjFs?=
 =?utf-8?B?SlVsd004NWVKTHhwMjFQdXhlN3RLR2JoMS9lb0dSYTJ1Um1TWTNYeTBQeXVE?=
 =?utf-8?B?SE52aXNWZzFvdjFGTWhHTUczb0twK2VkMXJydStyUlFITEZvYUd4ay93cnhN?=
 =?utf-8?B?eFVWKzcvckt3K1lMNDQ1MzlSdC9rVU0yZ3Q3dzZmaCtWSEZDRjRMRzNqQnhj?=
 =?utf-8?B?M2ZoOGVOUk5yMGpFeXFGdTVGNmlKcVdsdWE5bndvZGwwN2dObEkvUT09?=
X-Exchange-RoutingPolicyChecked: julO3JcAOeONtejSawY/5zNGbcwdZDZW7adpSmCMFNUOwf0/ZWE8hw49oKuvsIDABgFghVvX4GWSwQVrWUlsHNR4F8kIZV/1SOeYzzY9f1GothGCDR8d9RL6y2UQBYMhgJ0st9Yw5JzEeX683RlGB05FeCaO9k4/s0/5kBH09Ru1oDRwuaedHrVZ/8iHqDnAR1Q/dqXnNhW+2Elw2yAojNjIu6gONtuebq27fnxv7vjUtRqunsGU9YABBeh9WCgvonVnLBE4XWx8WszgNgumhO5yBEO3qMo5vErAo/ree5ttL0nv5QqhFoPJm8vvp73uV0Rq0B8MwDH0ZNuj3Ax20g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce61ecb2-644c-471d-e65d-08de9a0c845e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:59:28.6589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA8VZ02GBzv2iD5Jnl7o/jv4QQGI1tHGkWc3DhrIddMz08AzOfDg6ofOU9D2TcxRBfp4JM4uS026+H8NfmVvdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com

On Sat, Apr 11, 2026 at 09:26:58AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> The TDX module update process has multiple steps, each of which may
>> encounter failures.
>> 
>> The current state machine of updates proceeds to the next step regardless
>> of errors. But continuing updates when errors occur midway is pointless.
>
>This kind of begs the question of how much it matters if some pointless work
>happens in error condition during a rare operation. I'm thinking at this point,
>aha!, do we need this?
>
>> 
>> Abort the update by setting a flag to indicate that a CPU has encountered
>> an error, forcing all CPUs to exit the execution loop. Note that failing
>> CPUs do not acknowledge the current step. This keeps all other CPUs waiting
>> in the current step (since advancing to the next step requires all CPUs to
>> acknowledge the current step) until they detect the fault flag and exit the
>> loop.
>
>So is the point of the patch to prevent the operation from getting stuck? Or
>saving the user experiencing a failed update a little time?

Good question.

The main point is correctness, not saving time.

If shutdown fails midway, the update is still recoverable — TDs can continue
running. But if we proceed to seamldr.install anyway, it becomes destructive.
Aborting early on shutdown failure preserves recoverability (this is needed to
handle races between updates and TD build/migration).

If seamldr.install itself fails, it's already destructive, so aborting early
there just saves time. But using the same abort mechanism for both keeps the
error handling uniform.
