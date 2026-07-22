Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D817325485
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757323; cv=fail; b=QWthdoP/TZFA5v/MUxGUSPTAnzbBOcpnUIE5zG+r/3XiqdwByRWf71QBpNt7ae33m0IaS5mKzxvjLhXElFnfJydpRWPT77VQVQDp9No/ZngYufdgW/RCUJUbXQyOrDaMwlzwMJIweyfYB1wvJKmdl3N9SbUBXzPV3YYWLC/eZ0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757323; c=relaxed/simple;
	bh=HfbQdNTgPmbRPfnKEAvHXm0XSc852R0lJXWrJqycvrA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dFKLD6VSDxjuCSZY77Doq8+bL3wbh2+8jE3Y+bXdjHTORrHY/fN1XUB3qlAcDxqzN/cnad0G+PoXww+JjOr2umoW7Ywes5dGhD+0fqedmbASKqPdLsafQbKnMljmp9R/CipsjCcRpFnkIXI6rbdsr7jETUJjNL2cDNcexiDoJkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWMk73RT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWMk73RT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757322; x=1816293322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HfbQdNTgPmbRPfnKEAvHXm0XSc852R0lJXWrJqycvrA=;
  b=bWMk73RTcTex9BUCr4URItHVyYDs6n41SDGIxzZvi1dxzD7+wVnYzB7O
   ICjmcOgaPOQrX2dMPPwmn2rR9O0JtMkA273jOfxNmkqv88rVPICSk40lm
   mcoZ3IawIQmJC9e/S5Ndf6EzcYoYzPhkh0eAZUL7F2+ep5vmGq/cLK9Eu
   bT3Ba3QL2rDkgYPkrykZmFLcXgx+FiLMYy0C/ljU//KY3Fv3DR9gtLg35
   6Y2dZu2dXKOPULgMI14Jmhnnh/qjs56Hh2PX74/vNOJBCotAvPn9w9z1y
   qKqdVm27uPSZbPLvzlK4WnKspOgPXkEQRwnC5GYNiUqfK4mxAtvEqJbJC
   Q==;
X-CSE-ConnectionGUID: sFZTXyAmQ1iCR/amy1P3Mw==
X-CSE-MsgGUID: EIjJyLpWTdWBJ0vnbG9MIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102950802"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102950802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:22 -0700
X-CSE-ConnectionGUID: rknPfvHCQb25VtHfP0hgGw==
X-CSE-MsgGUID: vyaaQ/1rQjKgge3RV8H1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256420964"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVdkb1G1M5NCKthSj14SfBr4uTXl8/99gpfQcEZ1XmKDoWhy5fMhXsLJE2jidjOhofzhu/2tlvYW9LKus9glGSelDT9wBSxY01BAoGaq2MspBsY7a7pl/3T3fa+d9RmQNV0NxZtRWpOqVEa7o1iGJhvUeJ6Geas/d42TekIyN5JZHPMlSO2TmgxczCClU+XuxpKewS2V9CTz765jGimjSpCDLRP23PonhKJ0ExghkNNR6yCTOvsHs+nKPGM4OPD1MtxFHwqOCod9yv/iBB+GirfOnKfJYRv/jafOqdw/E3QtLHHw9u2GB1258zpGagTEHcvGcbaocgJmcV2V7MlLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ni/gWuds4m5NQ2dVIzd0oFIzSHhEA1mZ4IInsRBPV4=;
 b=Lb8Lou1TcFNdZnPjsahAVAmqjZEZa1QAHb1itpjSQL0dvp5dgT1YVlpsA2BxeixZ1zpWz+ycSamj8FNT6Xp/8yoJ12NpDyE7mSwwInLpSged+2CBTdOt7jpT15RLRm79SyKsPzmJTHtx34gszJZXyksdOdGFofQD+mXJIv8ESMOgW/6PePc1nQkLm+zm37bw2a0mfBaCr2L9E87VMQSGa0mGXIjG/hOxRyVFxt1hXOVdb5w743VJk/OWEHQAk+iqv6cMXUIcEaAhbynZh3h6A2S4flv+qsLEVhZJYjr/35P6xkzWjYVUlG9ihdBFUxpOxDJJXVyP7feLTK8YufosQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:14 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:14 +0000
Message-ID: <327a68cc-c15f-45fa-ba71-e9e89fc0207e@intel.com>
Date: Wed, 22 Jul 2026 14:55:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] KVM: x86: Reject EVEX-prefixed instructions
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-14-chang.seok.bae@intel.com>
 <20260720181110.C975E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181110.C975E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 48700592-aa39-42be-4a28-08dee83be8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gPvCFj5va3cjnyZJ/2M6BD8bH3WVWaYVHJhBd8/gnYwPLPSeR9+M7HDCpkFTP7q1OZpmdASACsPtiOTPhlKFkz1fj+fNglgzal9/OvviVImTD3VZ10rOKoZunuNWEMNmPUAaLpagp+Ev4fk4L6RTz3Q42swP9nLgV8J3v3bjMd2QlTAUgz4idWGay4i2azqas86WB15qeQAHkGvEUh8qHzzEa8I0aGZfK8gN68uCkBMi7/t5TCFHeEnHQmGgACq+SZtumWumUVu6ZYzRt6s4WK5fEX46ChV+C2HtfjfGDfnF9p00GrvH1lztTPBkVDsi7kLrQT/hZ19d//QKaOgUSqmbt/nZZvEhI1Pk4HqW1biiXLEqk4E53Df7CnVzEIGQXgGBBiuOWZ2vXdqYGNSwAnCjOB4zeucYl8Kb6VjSM+QFb7Vtx199ZzkuV5Sddcu99qv3vkiZoS5wE5NGY9P0A/PV/XN9LYUEflqJQwxj/RDmKWT+Tw+xglXQstAbXy8LgvKshlaU47Ypx8/J8yVTqU/VxQWtV/FaasKJzC3OBtE/sqgfnFEj0YDwmDXLgatkzDT2RVQ2cgrThJqyrpJea2p7nkXj7UK5+tp2KTgC+jrzsvBMCPZMxS9UYob85dQ32H06I3px/2Lvfh8sIqfjDJVfrY2TOx/kfnudVWbro+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0IwTXdhMHRoeTZvNEZ6enNPS1AzbURaNndNVytQdjZNRzF6cGNDSVJhNjht?=
 =?utf-8?B?UDhVbW85SlNjMUJDeHhmcy8xcEszbzhNSUQ1dGRPQW9UMmlwOHNZSU5nUEIv?=
 =?utf-8?B?djE4Uk4wcjlxb3d5ZzhvekVZUkY0RkFXTDBHQ3l0QTF3KzZVYndUVmlGR3RU?=
 =?utf-8?B?dEdyaGljQkVVMWRsWnB5RENhTHVRZkFlNnRaTHYrbHN1ZkF6KzhCT0tHcTNU?=
 =?utf-8?B?WnBtbVJLb0RDS1pQNEVldk41aUs0di84N3k1dkpoay94TUVkeVh6VW9mblBl?=
 =?utf-8?B?MWJzMktJcHpXZzJEMUtHdjJFaTU5VFJiVk5sQ1JxMjB5ZUhva2UyRkNGRk56?=
 =?utf-8?B?QXhyRTdtbThKNm5vN0VPTDdMME5NWVBuUHVEbDVheVZQclBpRDBuRHJxaHFQ?=
 =?utf-8?B?YUdHYzZQSnB6TTRGVTdOcnQySEpLZFdzejI5N0lxLytZMEhTaFU2cXRicWxC?=
 =?utf-8?B?Qng2ODYwNXNoaUNaTFcxUlRHa240ZCtQTE5tZFFqZmJWRW1YUDE4MWpQdEE1?=
 =?utf-8?B?QlR5MGNCWjVjRlBYS1RaWk5Hei9hcmQ2N09nZzRDZ2lkb1JlbWR1ZHl6WWlp?=
 =?utf-8?B?OTVOaDROTmJCcmE4d3kvcmQ3M3MzRUVkQmtjaFdwZytCWkQwTVI2L3I0azZj?=
 =?utf-8?B?ZWJMMUh2OVVlN0pzbWRDOEdXaW5Vd2g1SGlZendyWnlxUkNZaE1NQU1YbTk2?=
 =?utf-8?B?Z1RBN3NzcnM5SWcwUlBaTnUrZnJFSElzZDJSY2wvbE50akhRNUZsVmNTQzFO?=
 =?utf-8?B?YlhUeDN0c1hGZ2h6K2I1dCtyakVWSE82QWw1U1BSZDdqaU8xWXowb2h1V0V1?=
 =?utf-8?B?czhiRkQ5dERRdWFEZUt5YzFGQy8zYVFkUmFYYkM0dEk0QkwzTS9WSkxlQXFx?=
 =?utf-8?B?WHZIUDA3WWlSUUd5eGwzYUkrcDJBUGZ5OU5XQXN1NGhTbTlBZ2RqTGxWcmJ2?=
 =?utf-8?B?bDFJRVBIZk1iZ3FoY1psOE54QmF2WnFKNmlPYkl2S1dBMERjYWVBUjBjVVpp?=
 =?utf-8?B?ZU5SekdlckFKcWhDcTNkRXc5KzI4Q1J5enFQZ2RpbDVGZDd3WG0yM1NVMlZQ?=
 =?utf-8?B?MG9TMHB5VXdqV1RRUzNJcWpVMER3cnNUdXNmVGNhenJBb3FLQXNKcWFwc21y?=
 =?utf-8?B?Y1k0TUcweWQ2UXZMdVd1SXc5WWsxYlpBWHpSWERtMjFqMjVCcUhIU1MxVXhp?=
 =?utf-8?B?NktkSklXSEVSYVlEdzhmcE5qZjZ6UmRSWE5ReXR0UUVnZ1lsUk0zaTU3MERP?=
 =?utf-8?B?dGhDTDc3ejcreEVCQXFUcGsvdUM3U013allvVkZESjNiblNyUkZWVVBsMlNz?=
 =?utf-8?B?WVJRL0kxWk1QWlFhR2FaUGg3L1VFaTV4ZTFkZE15dldNTGVCOXVyRmhrZjZ3?=
 =?utf-8?B?RjhEMXlCUE9EMDgrODBWQjNDZVl2REZkL2xJSG9BYXNobVIvZkorRERHdjRw?=
 =?utf-8?B?N1FMS29mb21ub2I5TXpWNzlGMVpqVGdLQTlKTm02eWJ4VFVZTmtxby9hNXV3?=
 =?utf-8?B?Y3IzVkF2aTE5aGpsNGhIcUUvSVdwMjFTNWhiQXYwdDJOdzRQaUFUTmJmKzlm?=
 =?utf-8?B?eDdGSUkrMmZBdTlwRlVlbURSakpLOEoyRTRUVjRreGZRaVkvYTQ3NFBwZDZs?=
 =?utf-8?B?WllYNExuTVZxU2JSN1ZQcFFRTGZJMkE5NWdEUFd3aVk1WGxGQ1oyV3dzZjNY?=
 =?utf-8?B?RkIwNnMrdTgvSlBaaEJkemMzTzJGa2tXb3FNQ0x4TDlreDNZTmM1TzVrUlVN?=
 =?utf-8?B?R2t0YkdqYjJ2MTdIV1NuQzh2bS9aVUw2WU1uYzdJNlgvaWViUHl6T3lWOEVv?=
 =?utf-8?B?Yndjb0o1OGExZHVqYkpoak5FcGY3MW91WUtrSDhHdEFFYWJ2dTZFV3RCengv?=
 =?utf-8?B?RUZodU85bE9PbTZNbFVNeTVkM3kzYmFpOWNaVDhybkJLMm1xWkxreVVYdk96?=
 =?utf-8?B?UnZ3a0h2aHZJSW9mRWp6UXZIMkE4b3dhVnQySGVmeGxjTmUyL1luaWwranpu?=
 =?utf-8?B?b2NKK0YrY1pKcm1waUdxbG9hVVQxZnIrMTEvVC9lcnRRRFlwSEJlWEZGT1Zw?=
 =?utf-8?B?dTFKY3p4NXlKY1B2M2ZsT0lENXhQUFJFSG1mUlRiZzk3VjQyaW11dWhVemQx?=
 =?utf-8?B?ajNqdm5KZW9JNEwvR2xyZDNGakwvRTBuSDhCZWRzbldwRm85VWJ2cTk2ZTFv?=
 =?utf-8?B?c3dpOGswUk1BQWhvemN2ZlJLdHF2NVNydVBuMnFzSVhlOHc0aEk4d29mV0d4?=
 =?utf-8?B?bkg0NHZnTUJQTzZjVzJlRnpnSE4xNE1TVitCSWpRNTdUUVZxU0hZbTZBeXhE?=
 =?utf-8?B?eTg1eGpDblRXb3NvekJ3TVJscjVVYktiVmlkbC9mNzVDQzVUbkNXQT09?=
X-Exchange-RoutingPolicyChecked: IsBlC+SHQrvb7Iln2IZipusS6/O7S/3gvFwb4MGwVvNbKQZLVFpZTxExizlFGDKzc22rS8vv5Y0vI+uZEnJcJaKXwYaOmkyyi3XDFDcEqic43T6ia76xHgtYonGVRsd05uVncF5AgAoAb1mNywu6oqCWAEygrKAsCcfX91z8L2vI7gox/D9SVI5tzp+8C4+9GgUKs54L4LsSH7WaESO3I1mk7kxFnxC/IBgpPqIhBTzn43DTRH6TGcXIXjhE7jWg01n/qKdHY8pjZmLGOvAmjhpq7BvLrnSuiRkZCORqRFX9R3kvGHAfx33zdM3LbqHrEYpQJhsPVD9/072NdlMYPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48700592-aa39-42be-4a28-08dee83be8d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:14.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JpfUThnk8Or/y3WFyHHDCHzieW9OTj8E+hehrrqEFMpOQzTHkjbdu9jFnPRZJ8tBcMsRfeXx+r8gb4D0H3p4dD1nA3BSyGJAD8WXchhWUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:11 AM, sashiko-bot@kernel.org wrote:
>>   
>> +	/* EVEX-prefixed instructions are not implemented */
>> +	if (ctxt->opcode_len == 1 && ctxt->b == 0x62 &&
>> +	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0))
>> +		opcode.flags = NotImpl;
> 
> [Severity: Low]
> Does this evaluate stale data in ctxt->modrm?
> 
> When a 32-bit guest executes an instruction starting with 0x62 in
> x86_decode_insn(), opcode_table[0x62] yields NotImpl, which lacks the ModRM
> flag. Because the ModRM flag is missing, insn_fetch() is bypassed.
> 
> Since the EVEX check doesn't short-circuit in 32-bit mode, it will evaluate
> whatever stale data remains in ctxt->modrm from a prior emulation on that
> context.
> 
> Because opcode.flags is already initialized to NotImpl by the table lookup,
> is this check entirely redundant?
Even if it is not be the most optimized form, I still think it keeps the 
logic straightforward.

Thank,
Chang
