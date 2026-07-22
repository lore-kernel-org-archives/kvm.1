Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DF2C2363
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757347; cv=fail; b=gFYXk0q2X10FNNYexk28JxZASuMS4RQbpId5c/d/jfskbPamxuCnh17OF87Mf9Y976H2MlJkiomKHSHcSkJZB52eNRsdz8OBs8KFqFbKbY8dzehPzf2VnkDVjrPSVljKwfzkygd0+wnBQVtvpgrBjDhjzZJigS9WbT52aV8jtN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757347; c=relaxed/simple;
	bh=xwVO4anxKtqsgPTgpYyFBHlWgWU/hsA9CfZip1ZkYMA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XEFPsZJfwPvQzovHI1bs/mSKmNEXEvXZJmw2Yg9pD5dGZacRcqZeccCjOX2nHmdNFXkKiHSBAj/bhWWrAqfwkZhbgtmp282xbMryukiXHxODf/ObU22+QeVbVhUtAQ+hZdPkYdM/BF+xl0e9lzW2GNipIA2okZk3RG4v/TG6MZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V31rXQk0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V31rXQk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757346; x=1816293346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwVO4anxKtqsgPTgpYyFBHlWgWU/hsA9CfZip1ZkYMA=;
  b=V31rXQk0oOsXSIN7pgDqO+xnHCeTm34es1+JO6eIiQWKj+c4iyKw+Uj6
   eEjreIEn9LGxNONGpQpsEN4qtZAUysQvF9171NsOLbNh152rWLcmdtHo4
   gGu/Qxo1u2PKZNPxQMLBn5Kcgj+U95jLi8qGQyM2Tu7fPy7M+ae/sfvub
   g6AstHymWjRa0CCTTMtq6qo6yG814L6SL+NRiqIu6v0KsoBWeRrF/IJJb
   UGviv9VTVgNnFXheG42ybnqBCHbaQaJqiIOY3n2+J6aJEFx4t/7n7Pb/K
   tyIy3aH9MvUxfY3TyeNLhAz5rIVsh6iRUSYpBa0J0m0nRbo1ANFrCS4dT
   Q==;
X-CSE-ConnectionGUID: rviuaPOaTHadjMd39XQBFA==
X-CSE-MsgGUID: FX9PM4iKQ426NPCYigPM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102950850"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102950850"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:42 -0700
X-CSE-ConnectionGUID: 9IzpDBykRAOTGAr5SgmCtA==
X-CSE-MsgGUID: DlxYXzw3Tni/BlnVmNgtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256421036"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:41 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlHULyrXEVf3v+S10ELdlE4zllkkIGwCgtFNCeT56cAzJeOtnimPUEom4SF8xsrUYbb+YfhrGgF8VqNHbFfm36ENZgiSuQTrtlHHcWIINsuhCvPcaICPW/NlVd9hPDnI9nNzMgrJLUkJc9qrMPX8Z6cIZn4LZU+3kSQKXVwaVIlH1jrS4tTbVd5ygU/vLX1rzdY3KEHiHe4QVqCRluldzYMBuawGdq7KW3HFImPvUVWbZsqhFi0Vbf4EqiH/A1N3zfn38yeUFL5dMmT5lDoO5Rv6yTsB89JuCYCzIHgSnerloZe3KjsoWf+FL9MRFX8TOAV/b4ogBmFmB9oxDxRWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b05w+ktyK5dmvzagHrMwYW50evYiaikPlvAq60c1jBM=;
 b=GM8N9uZEo49a/o/0yitzI4St1eA5umAKSCZ/tj0Lj95k6MG14pDFJ4+Ep0vsh8e2bcecS4/2QUPU0wEXTt/9sdq7Rth1VqeQ6Hpl6fQqI73JY1nxR7w/2hhfcspuIcLSf6Cm/u6I4kj+T/mbjf6Z0S9oUFkfiXBbLRG6XjXWZ8J9tTY+TjVxuQHjoi2CoYWtTJJqsNpE1nuzcAr92nUg60P6EOqLEbwycI7l+F1387FyTsbnNOZ7DdeQxuol1h0dgNfEhVM47Uv5KxwOj0uxdMZDsn6FbErLhr9s3BFjrr0CbOouS4D+1ciJ5ORQ22HuTsu9TqTcN2sZzXoczN7t5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:39 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:39 +0000
Message-ID: <fd01143e-6c2c-415b-a5d8-8c0e16a61baa@intel.com>
Date: Wed, 22 Jul 2026 14:55:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/20] KVM: x86: selftests: Add APX state and ABI test
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-20-chang.seok.bae@intel.com>
 <20260720181756.2190A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181756.2190A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8c1b48-207f-475f-0a7a-08dee83bf7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: sPLPl/lDabNGe3fEnpUBd2+pIfLrAAgQefD3Z04ukPBp1bbEygY4BAOwUzv6d1cwpO0kNPqDx2C8OtNMbUWal1FsGmnuwQLF8KYnAFlejYU9WUfhtQmZESeXjVJk/iE3g5RiG/xgBZrin5t4T5Gomvyw20CMkZatpO0tPZ7jED4a1U+gL7/Vh1hN3qrLCth+2dLC4klhlmNyNGBWFKfLV/xwJJhZQErp+FaPLc/3snRSWoooFmKBO0rwwUZd8hOEgJ7n+5ELtegWPeezASGxi892RtH1/tpS9HfSpTGwh5FNp6AlV1rAuaireDp2CNPVaMyQ2X+/mC6pOhb4Qi4GmT1nM4eoRW9lRf6/b54UFIoX83R65GQh4/SYQFD+Up8l3FigV5goUx45zi8Le2xiNrS73M4NFmFt4H41mmID+4y+uFBmNjK+2f3rdEujpzWv1EHNu60Nb4WZRD+O6GbgY+zOpx97G2aaXI2DwdZULEipYqt2hKKfaCWm0ppkiHqHzEoeWB3V16SD+DFaGCCRTqHJuamoqJgBs4idPtRkp4YMHlgwYNSl3S95/jZPwsBQ5TndSGlxzLDjTnLpZGG5nIuknXfZRhOIrR8FTQRyNbS+PZfql0ONmzBC5J5kazCk3LcRHFEMdEsNvLPBUXtRxvCmQepdfDtcf8MZd4jbZnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkE5WUpIdTRsZHIxQ0NpdHdCM3RKN1IwS284ZkZvWGtYVFlUZGx6dHJMMjVX?=
 =?utf-8?B?TExvUlJqck5GOGZ4bVhNb0R0UmRJTnV6NWplOTJHaUVyUzNlWDYxRG1EME9v?=
 =?utf-8?B?YmZtTXZ2VGhINnFRTmhSVk1PQ3J5a3hwVmNHT3ZrM3IyM3FyRXJJaHNYSHk3?=
 =?utf-8?B?TUtyUTdrK001Nko5MGJ6WTRrYzY5U1ZPNnBtQ0xISzFoZE9YQTBoSlF0WDky?=
 =?utf-8?B?WUEvZ1ppS3YzWVBoMG45dHprVHBQSHAxK0pFMFhEdXAzSHNycUJoL2ZRd2Yr?=
 =?utf-8?B?bWpEQVN6b2c2Z0hrTzJsSmhCd29oOVBVQnRybllZYmd1MkVTMkF5cmI0bHRs?=
 =?utf-8?B?ZXFJTjM2Ym1sVmd5cXgzNGR2UW1nekVHV1IzbTVGN050a1BFdnFYbVdHdHZY?=
 =?utf-8?B?SURTM25xeW9wS2xER2swUWNNMktYQjZxOUoyakU5R3dwZUNwd25wcCtxdktp?=
 =?utf-8?B?U2FwM1F3QktKclRHNi9zbm50d2lMbkdmcVhoZzgwbjI1Z2FsblpZZm9ETy9t?=
 =?utf-8?B?OFRubXdYN3oxWG00N3ZnblFjQnF2VWp3YTROUUVjQTZNbzFZWmJ6L0hEMEJy?=
 =?utf-8?B?Skc1YXN1elZYTGprTFFjQ1hoMDdCaEVXTFZyL2FNNXBFSlJ3bzN5Uit6a3U5?=
 =?utf-8?B?QW9pUEFzNk8wTGc1cUg3cThPdFoydnd3aWxpSEluV3UxREVXbUh1YVRPVTZH?=
 =?utf-8?B?L2J1MHJrV0dRVlQxV1ZKc0pSc0pDMEszNzNoa1hhMnZuWWtjV01Xb1Rzb3dr?=
 =?utf-8?B?Z0tQSkw0ZjAwZVovdlFpb0xTNkpkUVQxZk8ybnRDd0s3aEJJTG45NUtZMVg5?=
 =?utf-8?B?dGxBOUJFdWZhVVdDWnMvRjV0aVU3SXZyeWRMQWRzMlFaR1ZhT1MxUFA2NXRy?=
 =?utf-8?B?ay9UUE1LbnVuU0F4b014QTFKa2pvOCtWOFArYkhoV2ZqYjc5UVo5bDZUL0dQ?=
 =?utf-8?B?NWczVlVOYlpIS0E3R2NSb1VrZXZWMlhtYWRGMFZZWEdrUUhabHMvZ0l6NzBR?=
 =?utf-8?B?YTBGVm1hYVEySzNPYXZ1Y3lYeFM2M20zaFZQT3ZJbWFwN05wbjJCSG5zSmts?=
 =?utf-8?B?K3NickYwS3ExYTRnYzhrVmZUcXdiSGNsTFgzVkw3bS82V0dOV211MU12QWlN?=
 =?utf-8?B?MFdJZ0RMMW5ZbS9QdzgxMHpMektoaWJLemMvQUsxR2tDNklCbEp1VzhyaFI1?=
 =?utf-8?B?UDNUS3lnd1JJUTZ2L3dvZWR3dm1GTkFLTm5QQ2dXU2pVSURsTUhlSDVVV1JN?=
 =?utf-8?B?REo0UURWZDkvQzZ2QVVUUTI2SGdPN0t6QjE2VjRIcm5kVUkyVUhqQWFxdDcy?=
 =?utf-8?B?V3VCWUs2cHhvOEgxQkUrTjZGcXh6U0RzcXlCVXE1WWVWdGVQcHkvSHJOQzB3?=
 =?utf-8?B?OUhJVnNMY1ZRcmkwTC90ZklNY3pmWG1UK2tTR1Q4NzFySUw0R0RUTitpVEF3?=
 =?utf-8?B?cFJqOWlyb2JYQ2FyaVZGbDN4dG9DTVBrNllsUmpjSk1NOUVNL3dhOE45ZUJ5?=
 =?utf-8?B?aFk0YUdlUW5YVU5BTGszVzRWRUVuQXRad1JVQ0xZTUtXU3N0ZS9XaVFQK2Y4?=
 =?utf-8?B?TlFtK0FzQzAxQzkzS0tuNnVhOWdqdzUyRWNXTlhlRHVqemJMU2dudnI5VW9D?=
 =?utf-8?B?Tkw5WTdDRThhK3N4LzNXQldsV2YwQmxhdlhscXF2N2pGYWlGZWtMRTY5b1NO?=
 =?utf-8?B?dnJXMEdDaVRYVGFtelVDZWIyR2MwdVJkOVVWb2YrUXRQNDZXci9JWFh1TVBC?=
 =?utf-8?B?aS9mWFV5SGVhT3NuRmdIcGxiTTRlakRRRUF2TnNoKzRzNFJ0WGxMemQ2NXBh?=
 =?utf-8?B?aTdWaGtjckJncGtiZnlMUzFDa2lsSmdZZHFPanpuZVBiZ0lyaWROK1FNdmxz?=
 =?utf-8?B?ajZhVkR4NXVBTmk5RExLWkxoNHhRV1U3MGRhTmV4blJ5c0pYVm1ybFhPRDli?=
 =?utf-8?B?SFZzS2tRM1gwTUZXeExZRUpZSmFkRFN5cElwaXlaUFBIcjlCb0tTOVkxbVpQ?=
 =?utf-8?B?MFkrdDJycVprYTNsZ1JhUkNDdHR1YXh2ek9XRlI5L0VSZEdMZk9jODZ5ZVZ1?=
 =?utf-8?B?UmxFYitHV0lwbGhkTGkyZG40bU1VZE1JSU1RanVtaUIzMmcwQmVTWDBoTmJK?=
 =?utf-8?B?N24xaVBITjQvdzY0RFRSeGxLMHJNZ1dGdlpVVDFZZEhBRDlpVDd6c1JqWW00?=
 =?utf-8?B?aDVTWkFaM2U2V2NsMTB5c1RxWkhpYmIxSC9GTGdhd24xazBnVU1WVnFFQnFs?=
 =?utf-8?B?S0FWaUFzeVVGRjR1bVJWdDFGeksvOUovSGdRWmJIOTlENS9VaDlocjlPWjQ4?=
 =?utf-8?B?YkFOYVVvenRhMjhrR0EvNldCZW1tNzJtTWNNc2JuK2JCNXVJL2Yvdz09?=
X-Exchange-RoutingPolicyChecked: ZGHDv3eIAUiqmDryYoAayoDFAtrnMADR7DsAhsYJyckcagVPqGOTOILYj+FLNq+6C+zKkP4pRwbs58S3ZtYGvKZae5L/6GHvxh7Dok+eW7zQ8OgoIyDVcvYczqjlEiP7MQ20AuYFXPpKnQmFIx8TuHuiFJlO9WHg3ImS+dDLwhytEzqw0DXYoZg6YRhy2YImwpXXKGIZuXA/uskxLMJFQC1tFEMxoifE7eDzXI1mvhxL6tTde3qdZlG+VVED1yYhPMAhFlUQcaQ00ZYkBGDh+DjQX7p2XDbZFIN2EjwfLuC6Rf34g/pRcGX0rsEW0DilzVE1FoqgbKr5HeJaEp0bMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8c1b48-207f-475f-0a7a-08dee83bf7e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:39.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khqk6M6HJuFnzZ+0mXhlNYSivk7JUvVMKyjccG3TMc1dzbO0d/F4ZSZPShz2anzAbfT4J/ZnRDWvy/MP9ZiY89gLhz9n8znltccOi1/J8sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

On 7/20/2026 11:17 AM, sashiko-bot@kernel.org wrote:
>>   
>> +static inline unsigned long read_egpr(int reg)
>> +{
>> +	unsigned long data = 0;
>> +
>> +	/* mov %r16..%r31, %rax */
>> +	switch (reg) {
>> +	case 16:
>> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=a"(data));
> 
> [Severity: Medium]
> Since this inline assembly has an output operand but lacks the volatile
> qualifier, can the compiler optimize away or cache the EGPR reads?
> 
> When compiled with optimizations, GCC might treat this as a pure function and
> reuse the initially cached values across GUEST_SYNC barriers. If userspace
> updates the EGPRs in test_userspace_update(), will the guest compare against
> stale cached values instead of emitting instructions to re-read the hardware
> registers, causing the test to spuriously fail?
Without -mapxf, the compiler shouldn't include EGPRs in the optimization 
options I think.

Thanks,
Chang
