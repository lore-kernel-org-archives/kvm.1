Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098633A6B7F;
	Wed, 20 May 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284789; cv=fail; b=K9unIXyi0ztuaaIzyy0JulwpDdNPgcugfpPh29NKbyv/0UEIM2Qos6b1o4zHnMnZXAEQGYGkkK8fzfTz1YMGOK7ADX25U4DEtW6guQl4Q67ZXBXwGDhrsI7nVEMUinuRkyj96q7rztFsBldmNht7bFB/Ni17+RWzbA+/Ka9gZ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284789; c=relaxed/simple;
	bh=dmTQ+GBr3H99yUnKonG0KFPMu5H/1HqUxC4S5JnpdXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNAIKlX67ectRhB1f4Hjp3qARdD3v1LNt9O5DlwKCFRfmlhNHz/SbYnCo6sdmxSHhV7cKdX7M4abNcp7luQILqj1F6h612fR0rpYirir7n1oYy+0MfOBbmOf2RfhUX4G3nxrW+G/c0Gyr5rsv0jC36SR0bCPV2m6F+YIJ4ARRJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuxfU9HI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuxfU9HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284787; x=1810820787;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dmTQ+GBr3H99yUnKonG0KFPMu5H/1HqUxC4S5JnpdXM=;
  b=iuxfU9HIDnlTT5DXZFJywUbKJhmJYl4XlQ2jgocO2QCpwMp3F36sCLOl
   Xz2nX/2qJNMjQKAsjv/ib7iAwRN3K766t8NFjezOMbJP4+RibIz3h0N4a
   zd3G5nUIaW2NTAZkQ00qZxSeTBXYVbxVvMqoFUukSnWb7I7CnhZJ0pvJz
   YCnkwLVyC8I/KccrRiQlygTMRSawQst6t29zN0nqXuyt3S871c6Opn2DL
   vxgW9xEC2kWsUov7tvKhcgmMcrmf8suR23t1aCyLdopEhg7Q7Io2D8IWX
   F8rZXgucHsibYLqmpFfdO7Ff9TngqmfX8mibFe76wf0JBtmWt+rULG7A0
   g==;
X-CSE-ConnectionGUID: 2GLO4vlLRvqWwrZDqvC5pg==
X-CSE-MsgGUID: yi3wNPROTLC+T2naYDJCIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80147498"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80147498"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:46:26 -0700
X-CSE-ConnectionGUID: 6yQMa54KS2eisT2Ib2Spjg==
X-CSE-MsgGUID: Nt1S3seGR+qvdVfAJq3HwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240045093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:46:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:46:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 06:46:25 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 06:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIplY2uqX6vUa0QQtbnkOqmop6MrtnQHLs/axrGWZaKokD10aYlKnbAT94Lv9hdZBeW6SIpRaaLDM8//qlRKL6dDJfTOLd5aGjCbNrJV5UeJjY9KW2XzuY7EdgRvg4HZKBLZsqTEYehukvK5HHCr2SGjRtg9qrxG899I1wZha5qAMmlnRcoVYRJCr+hKjWxaQ7DtZmQDOGb47GE2HmAovAbPZa1Xi5HfNjmcAKL2NQYtEu6flqhOkM1PArAg61apgy9+k8+ucjWMCePXSSezuTOqYGd0KkNEPk3ZWGTBV3ig3/g0piZnE6kfEFRMzUKFM4oO8qALO1ufW02ELIJlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vQ0p+3ZOL4VTI3wfDPq3yxdtllUOXlVi2oeKoyPXSw=;
 b=j6AL7CBVbDgCoWJ770fsalwOAun2uz+vO481AxAgVVYZmTPKaJF0PZP3PfQYiPQ0Z/s7VmIhkBpOZpGUIndo/fK/ZBOOjhU8fqrSkZauqkNKgTB83JtFlplKrLLnLDYdI6huoIcTJMJsfGma9STGNRttaCA+NNVXi0Aju+g5o7xdxssjxEkH6F2/uqJkRqh0GMGSv1KprHMH4FFNIWaEX5DNhw/r0SYXhfYVKRmTNSju9ZENwGC+OcUYkevMuqbmO9x6MO6PgGaJLm4wlWrezSFg6yLStaFsSzu6SJNA5LSwDFgIKHGhc6JCP1CHfAzGrm6FcMjeD034U587OwqTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:46:21 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 13:46:21 +0000
Date: Wed, 20 May 2026 21:46:03 +0800
From: Chao Gao <chao.gao@intel.com>
To: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-doc@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 00/25] Runtime TDX module update support
Message-ID: <ag27G4Ntb77BOwze@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DM4PR11MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d0d0f8-2707-4fa6-b639-08deb6762d09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DReQQIf5wD2wfc+XSwzmXB+u5ydvfSpsJxU7X06JYXWhUcRnOYWU1SsrNYyqmWcTq4a5iBoMQLHcU2LWnNH/LVKWIVEOahHTRtb5eUMYOg7AagTwofX3ZkkxHlakGppdx58/rd+qdvyvr/uLe3yaKgfwiGra01enhQ74wkoSssqI1dSObiGvEdGpapopNCZMsK77ri35GFdCdqamoxus/3T3xeA5rrC8TFYoSjcqgSiHFzg2FjHOm05EhBPM3Q6MgNtVGvkT5yDBXi/WcGjJI5tq4ufw4JQcz7PAIy7iEOn+a9TI9mdSqaJ/H1uqQNnm5/ubCwoSlsTVfvO8VOYbMDwrPZZhfAt5bxsXCCJZlZ0mmIV01WDTPiPYr335zd9WwOL7PpHyr5klxF2EhMjpYvMiRqE2VaSQt2z7ndPPolQEIJOPnY6ZP6S4LhG5aDb8bmxqLq+Wb+A7oHUPXQTliUS+SrUuh3N3liZSdiNL0AtofeOxsJAKDY9m1/mKhkUDp4T0BcVYf8lb/aOH0/1/pmnZtL7/fTh5q3r+eOpQw0raN1yR7Rmsc6VagebYo7zEDedfcdpdOgzhCFIkUdiEEM60xILqAyi19/1dvHh33xQnbAhlKtWkfQ7Ru/l4EJfSI22ihw2R+R0H4tFPFViVabFBPDdh9lkDZ5564EitfYsYtSSB1gemq8+mEePUVdF+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWFaT2RpMzJBZHdsajQyKzROUlFwckVWc0ttT1l0Rk15Z25VaWJpZnhJT2pN?=
 =?utf-8?B?TUVyeSt4RVcvTExTZnVmZVl0ZXB1Mlg0cDBZd3ZhRENzMW90MmR2OXk4aHdh?=
 =?utf-8?B?VE9BSnF3UFdzd1Q4NXNKSlRPblFLSG5BZ21OcWNRVkdPT09vbXFCRXNkb3ox?=
 =?utf-8?B?S0xuTFJUWlMyL0NYaHJaNUs1d0FIUzNPeCtaNVBTdWZKenIxL2MrWFB2d3lw?=
 =?utf-8?B?SVlVOGh0VUg5NkFtL2c1NWswMDhBWGswVWhyTGY5TSsxU2NoNkdjbEpXQWU4?=
 =?utf-8?B?YjJCcGdHcW8xRE85YS9JKy9KVUFYeTJtZ2YwNTNQc3E3UHpEVHdLSzdNM3hh?=
 =?utf-8?B?KzNjVERUNzlIL3dtOG5YOGNSazFWY2tDcTVKT25uaGxmcTJRLzlaMWVHTVEw?=
 =?utf-8?B?NVRWTmJZakJVOVduRFh1WXY0THVLMjFjNDhkQjJVMi9qUkdxRnZ6Y2NlWHdr?=
 =?utf-8?B?UXBUc2JjNkhJNHhaZXJGbjRoK2JrSGd0bjBTYm0zY2Zhd2tjUG5rckZpU09w?=
 =?utf-8?B?SmdSL1RRd2RMZFRTS01qNDgwNTljSjg1c1JyT2crODlmNncrNkFiM3ZNZzlQ?=
 =?utf-8?B?V1ZGN1lGYlU2MDJkYVFlN2hwSFNCbVFwaVllNWhOcUNFVVcxZ3MrOE1WWFZD?=
 =?utf-8?B?M1doSmlZVWtHcnlpeXRhejJDZ2RhSkJRUCtnUkhZeXI1WFZHYU5HUldVcmM2?=
 =?utf-8?B?Mk5LZjU0aU9SVytoUnBkMnd6TWc4ek1SRFJMdU9BektVU1dmN3hlZ2Vhazl4?=
 =?utf-8?B?QU9JZHMxMGd4RjR1UlcrTkxMVk81dEZyLzdtbkFjSGsyWXJmUTFralA4MUsy?=
 =?utf-8?B?WVdWbjNFVzYwV0dob2pRQklland5ZUJzaDc3eU4xa1dON3JaSVN1akYrcUg0?=
 =?utf-8?B?YjlhSElnckFWUm41V1hnL0Z3enB4QXRKLzJVRXh2UEpMZ1BHOUE4WFhvMVNF?=
 =?utf-8?B?QnhjZWtVeVlNWSthSGNiM01HRTViVmU0Znhac002cGRvZTlMcUc4YXNqV0Fa?=
 =?utf-8?B?U1U4MHE4L1VGMXdzMEN6cUUyYjZvRnJKNkhOeGQyWS9ucHcybGNQeTBQeXJY?=
 =?utf-8?B?RzkwYVdQU3EvdTJheVEzMU10alVuaUNDUXdudi9uWnkwTzRiSk05bjNlQlBr?=
 =?utf-8?B?d1Q2dmFmSlo5ZFdSN1BheFI2dVZKaWd4V0ovNktIb3NUZWROSkYvekVHSFor?=
 =?utf-8?B?ZkhzQ3dmMmYwNnNoUkduWTB6eFhEdU5XYWpXVTdQb0dBTTdCUzJSdUxnSHcy?=
 =?utf-8?B?dkwxanJYcWZoUkVyQlJqV1l6Yk9rT0l1S1lhRy9hQ28vVTNNV01QT1d4aEpC?=
 =?utf-8?B?dmI3dUNOa1czbXBTSEY3L0VmWUtrazhrNktrYjlDQmp3UEVFTUxvM0xlTDds?=
 =?utf-8?B?MjN2VDEyT0N1VWtGYmVmcmJYbkZabzZlZWV3NEJJd0xRaU0zL3M0aXpsMG9L?=
 =?utf-8?B?QUJKYlJmZ0x6cWdCZFpsdkNBd0JJdVBtV2Q3LzkveGtWR3RHTFN1NmZjQlZC?=
 =?utf-8?B?Z2RUVytuZmg4SWRLQTJqTXBKSkJIaDRNK2E3N1JlSHNWYXFEaTd3VjJ3MVFE?=
 =?utf-8?B?Z2t0YVNhMHd2T2RlV1A0YmxoOTlQNktxdUZsK1J4TllBUGVyZVowOE1rTVRn?=
 =?utf-8?B?eTNwbUw5TFZONFdsMmx0V0VxSk5wVzcxc2pEM3FJQ0xkejR0Sno1YWkrNXox?=
 =?utf-8?B?Zk05SDU4YzZHTmhyR1pqYi94UTRoKzYyUnZyckJFT08razBlRWdCVnd4d3pV?=
 =?utf-8?B?RzBXVTNMaFY4eFZHSTE1VEVINXZyaUl2eGxLTGlIWk56WDg5bEpZUC9DYTl0?=
 =?utf-8?B?Y0pqd0tUT3RyTHpEcUlDWXBqV0plbW1reDdIdk11UFpTTUIydDhIaE5NcW8r?=
 =?utf-8?B?UU8xU3N1cGQ1RHlDdGpRSzhIaHBLMmRpRDJDc0tQUjZGMitGaVhkRHN2NExU?=
 =?utf-8?B?cXozM0JQNUNnbjQ4RGF0enlYZFZCc01MdlVNUTgwemxOWllhaEtGTVpidmt1?=
 =?utf-8?B?N1UwYklFemZQNFB1ODlwZkpEYTFGYitObE1mMkhMd1N5aXVjTFRTMmlOdHFY?=
 =?utf-8?B?bWhBaVJRZTA2bWV5YzRsVlp0cVhWc2hQeGdOZzZrdVozckpwTGVnYk9rcWxp?=
 =?utf-8?B?eU0wS213WUdzMjBBRUJrN3YzVi84VUQrcHdrdEx2dUFIMjB5ODRiNlh6eHNs?=
 =?utf-8?B?WWlMeWpoM0lkWEVtUzE0dXBGbGd6RURhenovVlZuTWpMek91dkZxQ0doYjhX?=
 =?utf-8?B?NEx0NjJia0ZtdzY5cGVzc1NaUExhTm5vaVVBSFJhcGwvdXdtSVRZKzdGMkFN?=
 =?utf-8?B?L2VYZXVTUjFjZnVpc2xXNnh3cG1pLzhLeVFrZFhkcXc3YTU2OG1PUT09?=
X-Exchange-RoutingPolicyChecked: pPv/Whxmv+6Lf3seuAyb8aBwMrjM2u3BSH/xYtEB9/ZE6sLDvwBa3dmP9ah+8KzjIKE1pjxlJ+q3paqwhwRTKKTW/LEFTRTtDNBj6fKKgekv4TSLstOlJsZ6EkNXS1yPCxlNppmMaO8VkgDMM2pSUBlO1Ie5fCMo9Nul/Kj+nQzLxjnAL0UdArud3uInc4iuof3aNf6i7mCWGDTF1cxZpSKClCmkE/2yxxjfpxAFf4zIPN+a1CtQqcc4e6S4zN2L+QepFe8NxMzlLYpbzMqgK80u4CwWPHyKiwYA0ZVReLocgwLdEmjj3Smubmr67kH6y+c5FoaYsdjrr17wL2h2Pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d0d0f8-2707-4fa6-b639-08deb6762d09
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:46:21.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a1x81dfkMArRv9+y6rFkYMRW9nzyJM/O8vzAM6pN0g/vQisPJ6BTZytuaFg3pzEiZTn4ZI5aajIIrtwm0btmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

On Wed, May 20, 2026 at 06:38:03AM -0700, Chao Gao wrote:
>Hi Dave & Rick,
>
>Thanks for your thorough review of v9. This v10 addresses the issues you
>pointed out. The main changes in this version are polishing changelogs
>and variable renames to improve readability. Specifically:
> 
>   - Patches 1-2 (new): Split the original "Consolidate TDX global
>     initialization states" into two steps — first move the statics to
>     file scope, then clarify the result-caching logic in
>     try_init_module_global().
>   - Patch 6: Removed user-facing Kconfig help text for TDX_HOST_SERVICES
>     (now a silent tristate auto-selected by INTEL_TDX_HOST).
>   - Patch 13: Renamed "size" to "data_len" in seamldr_install_module()
>     and init_seamldr_params(); renamed "HEADER_SIZE" to
>     "TDX_IMAGE_HEADER_SIZE"; renamed "primary" to "is_lead_cpu" in the
>     update state machine.
>   - Patch 13: Added early data_len validation and explicit bounds checks
>     on sigstruct_nr_pages/module_nr_pages against SEAMLDR_MAX_NR_*
>     limits, removing the implicit clamping in populate_pa_list().
>   - Patch 22: Fixed BIT(16) -> BIT_ULL(16) for
>     TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE.
>   - Patch 22: Removed unused TDX_FEATURES0_UPDATE_COMPAT definition.
>   - Various patches: Shortened sysfs ABI descriptions, tightened
>     comments across seamldr.h and seamldr.c, and minor style fixes
>     (return 0 -> return false, unfolded conditionals)

FYI, below is the diff between v9 and v10:

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index 9e08db231da1..5f18ac972468 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -1,16 +1,14 @@
 What:		/sys/devices/faux/tdx_host/version
 Contact:	linux-coco@lists.linux.dev
-Description:	(RO) Report the version of the loaded TDX module. The TDX module
-		version is formatted as x.y.z, where "x" is the major version,
-		"y" is the minor version and "z" is the update version. Versions
-		are used for bug reporting, TDX module updates etc.
+Description:	(RO) Report the version of the loaded TDX module.
+		Formatted as "major.minor.update". Used by TDX module
+		update tooling. Example: "1.2.03".
 
 What:		/sys/devices/faux/tdx_host/seamldr_version
 Contact:	linux-coco@lists.linux.dev
-Description:	(RO) Report the version of the loaded P-SEAMLDR. The P-SEAMLDR
-		version is formatted as x.y.z, where "x" is the major version,
-		"y" is the minor version and "z" is the update version. Versions
-		are used for bug reporting and compatibility checks.
+Description:	(RO) Report the version of the loaded P-SEAMLDR.
+		Formatted as a TDX module version. Used by TDX module
+		update tooling.
 
 What:		/sys/devices/faux/tdx_host/num_remaining_updates
 Contact:	linux-coco@lists.linux.dev
diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
index ac6f80f7208b..43084e2daa2d 100644
--- a/arch/x86/include/asm/seamldr.h
+++ b/arch/x86/include/asm/seamldr.h
@@ -5,11 +5,10 @@
 #include <linux/types.h>
 
 /*
- * This is called the "SEAMLDR_INFO" data structure and is defined
- * in "SEAM Loader (SEAMLDR) Interface Specification".
+ * This is the "SEAMLDR_INFO" data structure defined in the
+ * "SEAM Loader (SEAMLDR) Interface Specification".
  *
- * The SEAMLDR.INFO documentation requires this to be aligned to a
- * 256-byte boundary.
+ * Must be aligned to a 256-byte boundary.
  */
 struct seamldr_info {
	u32	version;
@@ -32,6 +31,6 @@ struct seamldr_info {
 static_assert(sizeof(struct seamldr_info) == 256);
 
 int seamldr_get_info(struct seamldr_info *seamldr_info);
-int seamldr_install_module(const u8 *data, u32 size);
+int seamldr_install_module(const u8 *data, u32 data_len);
 
 #endif /* _ASM_X86_SEAMLDR_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ac042b369843..c848483d815f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,7 +36,6 @@
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
-#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 6a39c9e3ef7d..ff95d8dd1162 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -32,10 +32,12 @@
 #define SEAMLDR_SCENARIO_UPDATE		1
 
 /*
- * This is called the "SEAMLDR_PARAMS" data structure and is defined
- * in "SEAM Loader (SEAMLDR) Interface Specification".
+ * This is the "SEAMLDR_PARAMS" data structure defined in the
+ * "SEAM Loader (SEAMLDR) Interface Specification".
  *
- * It describes the TDX module that will be installed.
+ * It is the in-memory ABI that the kernel passes to the P-SEAMLDR
+ * to update the TDX module. It breaks the TDX module image up in
+ * page-size pieces.
  */
 struct seamldr_params {
	u32	version;
@@ -87,7 +89,7 @@ static int seamldr_install(const struct seamldr_params *params)
 #define TDX_IMAGE_VERSION_2		0x200
 
 struct tdx_image_header {
-	u16	version; // This ABI is always 0x200
+	u16	version;
	u16	checksum;
	u8	signature[8];
	u32	sigstruct_nr_pages;
@@ -95,23 +97,28 @@ struct tdx_image_header {
	u8	reserved[4076];
 } __packed;
 
-#define HEADER_SIZE sizeof(struct tdx_image_header)
-static_assert(HEADER_SIZE == 4096);
+#define TDX_IMAGE_HEADER_SIZE sizeof(struct tdx_image_header)
+static_assert(TDX_IMAGE_HEADER_SIZE == 4096);
 
-/* Intel TDX module update ABI structure. aka. "TDX module blob". */
+/*
+ * Intel TDX module update ABI structure. aka. "TDX module blob".
+ *
+ * @payload contains sigstruct pages followed by module pages.
+ */
 struct tdx_image {
	struct tdx_image_header header;
-	u8 payload[]; // Contains sigstruct pages followed by module pages
+	u8 payload[];
 };
 
-static void populate_pa_list(u64 *pa_list, u32 max_entries, const u8 *start, u32 nr_pages)
+static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
 {
	int i;
 
-	nr_pages = MIN(nr_pages, max_entries);
-	for (i = 0; i < nr_pages; i++) {
-		pa_list[i] = vmalloc_to_pfn(start) << PAGE_SHIFT;
-		start += PAGE_SIZE;
+	for (i = 0; i < vmalloc_len_pages; i++) {
+		unsigned long offset = i * PAGE_SIZE;
+		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
+
+		pa_list[i] = pfn << PAGE_SHIFT;
	}
 }
 
@@ -123,39 +130,43 @@ static void populate_seamldr_params(struct seamldr_params *params,
	params->scenario		= SEAMLDR_SCENARIO_UPDATE;
	params->module_nr_pages		= mod_nr_pages;
 
-	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_MAX_NR_SIG_PAGES,
-			 sig, sig_nr_pages);
-	populate_pa_list(params->module_pages_pa_list, SEAMLDR_MAX_NR_MODULE_PAGES,
-			 mod, mod_nr_pages);
+	populate_pa_list(params->sigstruct_pages_pa_list, sig, sig_nr_pages);
+	populate_pa_list(params->module_pages_pa_list, mod, mod_nr_pages);
 }
 
-static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
+/*
+ * @image points to a vmalloc()'d 'struct tdx_image'. Transform
+ * it into @params which is the P-SEAMLDR ABI format.
+ */
+static int init_seamldr_params(struct seamldr_params *params,
+			       const struct tdx_image *image,
+			       u32 image_len)
 {
-	const struct tdx_image *image		= (const void *)data;
	const struct tdx_image_header *header	= &image->header;
 
	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
 
	u8 *header_start	= (u8 *)header;
-	u8 *header_end		= header_start + HEADER_SIZE;
+	u8 *header_end		= header_start + TDX_IMAGE_HEADER_SIZE;
 
	u8 *sigstruct_start	= header_end;
	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
 
	u8 *module_start	= sigstruct_end;
 
-	/* Check the calculated payload size against the data size. */
-	if (HEADER_SIZE + sigstruct_len + module_len != size)
+	/* Check the calculated payload size against the image size. */
+	if (TDX_IMAGE_HEADER_SIZE + sigstruct_len + module_len != image_len)
		return -EINVAL;
 
-	/*
-	 * Don't care about user passing the wrong file, but protect
-	 * kernel ABI by preventing accepting garbage.
-	 */
+	/* Reject unsupported tdx_image ABI versions. */
	if (header->version != TDX_IMAGE_VERSION_2)
		return -EINVAL;
 
+	if (header->sigstruct_nr_pages > SEAMLDR_MAX_NR_SIG_PAGES ||
+	    header->module_nr_pages > SEAMLDR_MAX_NR_MODULE_PAGES)
+		return -EINVAL;
+
	if (memcmp(header->signature, "TDX-BLOB", sizeof(header->signature)))
		return -EINVAL;
 
@@ -163,7 +174,7 @@ static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u3
		return -EINVAL;
 
	populate_seamldr_params(params, sigstruct_start, header->sigstruct_nr_pages,
-				module_start, header->module_nr_pages);
+					module_start,    header->module_nr_pages);
	return 0;
 }
 
@@ -230,14 +241,14 @@ static int do_seamldr_install_module(void *seamldr_params)
 {
	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
	int cpu = smp_processor_id();
-	bool primary;
+	bool is_lead_cpu;
	int ret = 0;
 
	/*
-	 * Use CPU 0 to execute update steps that must run exactly once.
-	 * Note CPU 0 is always online.
+	 * Some steps must be run on exactly one CPU. Pick a "lead" CPU to
+	 * execute those steps. Use CPU 0 because it is always online.
	 */
-	primary = cpu == 0;
+	is_lead_cpu = cpu == 0;
 
	do {
		newstate = READ_ONCE(update_ctrl.state);
@@ -250,7 +261,7 @@ static int do_seamldr_install_module(void *seamldr_params)
		curstate = newstate;
		switch (curstate) {
		case MODULE_UPDATE_SHUTDOWN:
-			if (primary)
+			if (is_lead_cpu)
				ret = tdx_module_shutdown();
			break;
		case MODULE_UPDATE_CPU_INSTALL:
@@ -260,7 +271,7 @@ static int do_seamldr_install_module(void *seamldr_params)
			ret = tdx_cpu_enable();
			break;
		case MODULE_UPDATE_RUN_UPDATE:
-			if (primary)
+			if (is_lead_cpu)
				ret = tdx_module_run_update();
			break;
		default:
@@ -276,20 +287,27 @@ static int do_seamldr_install_module(void *seamldr_params)
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module image.
- * @size: Size of the TDX module image.
+ * @data_len: Size of the TDX module image.
  *
  * Returns 0 on success, negative error code on failure.
  */
-int seamldr_install_module(const u8 *data, u32 size)
+int seamldr_install_module(const u8 *data, u32 data_len)
 {
	struct seamldr_params *params;
+	const struct tdx_image *image;
	int ret;
 
+	if (data_len < TDX_IMAGE_HEADER_SIZE)
+		return -EINVAL;
+
+	image = (const struct tdx_image *)data;
+
	params = kzalloc_obj(*params);
	if (!params)
		return -ENOMEM;
 
-	ret = init_seamldr_params(params, data, size);
+	/* Populate 'params' from 'image'. */
+	ret = init_seamldr_params(params, image, data_len);
	if (ret)
		goto out;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2ab6f6efe6d1..0c5660c9ab45 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -69,6 +69,8 @@ static LIST_HEAD(tdx_memlist);
 
 static struct tdx_sys_info tdx_sysinfo;
 
+static DEFINE_RAW_SPINLOCK(sysinit_lock);
+
 /*
  * Do the module global initialization once and return its result.
  * It can be done on any cpu, and from task or IRQ context.
@@ -76,29 +78,34 @@ static struct tdx_sys_info tdx_sysinfo;
 static int try_init_module_global(void)
 {
	struct tdx_module_args args = {};
-	static DEFINE_RAW_SPINLOCK(sysinit_lock);
+	int ret;
 
	raw_spin_lock(&sysinit_lock);
 
-	if (tdx_module_state.sysinit_done)
+	/* Return the "cached" return code. */
+	if (tdx_module_state.sysinit_done) {
+		ret = tdx_module_state.sysinit_ret;
		goto out;
+	}
 
	/* RCX is module attributes and all bits are reserved */
	args.rcx = 0;
-	tdx_module_state.sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	ret = seamcall_prerr(TDH_SYS_INIT, &args);
 
	/*
	 * The first SEAMCALL also detects the TDX module, thus
	 * it can fail due to the TDX module is not loaded.
	 * Dump message to let the user know.
	 */
-	if (tdx_module_state.sysinit_ret == -ENODEV)
+	if (ret == -ENODEV)
		pr_err("module not loaded\n");
 
+	/* Save the return code for later callers. */
	tdx_module_state.sysinit_done = true;
+	tdx_module_state.sysinit_ret = ret;
 out:
	raw_spin_unlock(&sysinit_lock);
-	return tdx_module_state.sysinit_ret;
+	return ret;
 }
 
 /**
@@ -1267,7 +1274,7 @@ static __init int tdx_enable(void)
 }
 subsys_initcall(tdx_enable);
 
-#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT_ULL(16)
 
 int tdx_module_shutdown(void)
 {
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index ca600a39d97b..57d0c01a4357 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -1,12 +1,6 @@
 config TDX_HOST_SERVICES
-	tristate "TDX Host Services Driver"
+	tristate
	depends on INTEL_TDX_HOST
	select FW_LOADER
	select FW_UPLOAD
	default m
-	help
-	  Enable access to TDX host services like module update and
-	  extensions (e.g. TDX Connect).
-
-	  Say y or m if enabling support for confidential virtual machine
-	  support (CONFIG_INTEL_TDX_HOST). The module is called tdx_host.ko.
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index ad116e56aa1a..291464490fe0 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -76,6 +76,10 @@ static ssize_t num_remaining_updates_show(struct device *dev,
	return sysfs_emit(buf, "%u\n", info.num_remaining_updates);
 }
 
+/*
+ * These attributes are intended for managing TDX module updates. Reading
+ * them issues a slow, serialized P-SEAMLDR query, so keep them admin-only.
+ */
 static DEVICE_ATTR_ADMIN_RO(seamldr_version);
 static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
 
@@ -90,7 +94,10 @@ static bool supports_runtime_update(void)
	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
 
	if (!sysinfo)
-		return 0;
+		return false;
+
+	if (!tdx_supports_runtime_update(sysinfo))
+		return false;
 
	/*
	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
@@ -98,14 +105,17 @@ static bool supports_runtime_update(void)
	 * present before exposing P-SEAMLDR features.
	 */
	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
-		return 0;
+		return false;
 
-	return tdx_supports_runtime_update(sysinfo);
+	return true;
 }
 
 static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
-	return supports_runtime_update() ? attr->mode : 0;
+	if (!supports_runtime_update())
+		return 0;
+
+	return attr->mode;
 }
 
 static const struct attribute_group seamldr_group = {
@@ -120,20 +130,20 @@ static const struct attribute_group *tdx_host_groups[] = {
 };
 
 static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
-					 const u8 *data, u32 size)
+					 const u8 *data, u32 data_len)
 {
	return FW_UPLOAD_ERR_NONE;
 }
 
 static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
-				       u32 offset, u32 size, u32 *written)
+				       u32 offset, u32 data_len, u32 *written)
 {
	int ret;
 
-	ret = seamldr_install_module(data, size);
+	ret = seamldr_install_module(data, data_len);
	switch (ret) {
	case 0:
-		*written = size;
+		*written = data_len;
		return FW_UPLOAD_ERR_NONE;
	case -EBUSY:
		return FW_UPLOAD_ERR_BUSY;

