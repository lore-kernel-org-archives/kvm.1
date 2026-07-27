Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651A3F1640
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147239; cv=fail; b=SjI/L2fzRIxXOjkcSyV09ug/k6wJXfQWj/Oo7JYUFv/I0q5DvMkBjCofwdIuue/yiy1+OtX0aQMHyuhb7kckIqa0yeyODlsAwYpgC280tQcLkpa+W2tuwSjl+0u8he6E/P5DEcVakZPaktthuDkZgdpkklPFzsSYyAdemy7rWyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147239; c=relaxed/simple;
	bh=/9P5r0hBJYzvnEr5hgsQBmUAiZRu7fWsT9whoxw87qM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sdgIT+oPV2MAJSWMqhKZXJmR7KCBnbV3Clr2FLTM1KlHUIHFH+NhpmO/w1Ft5zGF5gyf32p99QZz1aAlumEnYIM2DpFuUmqO4G6MCt8E52bLEeWV2dfFTD1tWdB4RobT/uF2Bsbvk5XhghN54EXNfbS6SR0Lhw9aJ1kHJXFqq4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuB8pOWI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuB8pOWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785147236; x=1816683236;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/9P5r0hBJYzvnEr5hgsQBmUAiZRu7fWsT9whoxw87qM=;
  b=NuB8pOWIGItwd8HQwElJVYG+1SKueSLkvjJcoCza2qQbDcDP7TQHlhEv
   1vMFRVXWEx28cgeWpZnggUflgLfp406uNB7IFw4Xlb3qqXk/mzd5lqR2V
   vWqRvtZLBKwuII++3oLuta4xMNUpjTdzGPkbZ00aav1q/t9xcdbs9Vvqm
   bH5dyPSnjLV2VfdoU1Of4ROMAMCAkpypf3Ub3K3aNFx7CeAXTkQsegOsO
   5tm75hA/bnohFFNcKiFF7C2L77RPLMHtE83ezXBcEH8+apsxMPgVTQl/n
   KVtphRuA6NJPDT6jug3AmVx048tBgBcfPqqutKJvZzHxYQo2Ux0qSeXu4
   g==;
X-CSE-ConnectionGUID: rjqzHBGXRAOgUcJhnczt8g==
X-CSE-MsgGUID: a2MYqvS6T96LdeAkEWFjFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="84688253"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="84688253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 03:13:55 -0700
X-CSE-ConnectionGUID: 8qEQufhfS1euZvIQSttS1Q==
X-CSE-MsgGUID: wuxJ+Mf6QcSXOLwZz/EqNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="257588246"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 03:13:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 03:13:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 03:13:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 03:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+ZqUrmsxEH/A+uuxGs6CjyH4T8eLd+QW0FzhdIIhVvLi1AITRq6PHTP+B94lBf24l3+9+pMBBPbAE1OR5/7ZT2sqrEJpv/WMp7DOe+GEGKROALTZe4QACqp+nWhQNXbPiscEuXvjwLn1OtbCjN81RdTnHnf8H1627Ebxzfgh9ujj2Htd8Y3j2XHE3s476rQuDO25ZFahgf4oLobSelY1fv2M5LCA/eOH20blpragHIMq+4voNeof9oHDjpnMcsbPD1OqRBDcxja3cjWEfbOAUUOSUxbtbKGnehTmo7nUY6dNujoLDjOTOA+VogFpgmIl7PdllZetu7S41Uf5CoY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPujGedG0wpaIS60iUHhXcdMe5PE1EalSCL+0OKdOBg=;
 b=gyhF0hzfhx9C3lnlkv5i06/XDUPJQUmEqnG1n477xmc8RD88NsThSSFVVq+n3UcVvFdXETTJY0qP2fhDn1cF2uYbLCLm0MmCNoShhpCqdeP4vOG7CA8e3R3Vc4HmuB2ihF3AIi2OUfNP3MB4mL225I0cg0EFvsMLawaYaiLUs70qX+eJlbe0kzjgO8ODYfSFLFJCMGxYIGapH4vb8MQ5Y3eeycDs6jilaICJNbdSS4RdW3oqcxQmqvac6tdid6asxDuAkY0mckhaCvpqcJIDeSphtl0Hba0jKYnhViG0MxruJl3EL74qCPIgvuDA90pl3JlzGFLIc4Xd7tb9mFvyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:13:52 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:13:52 +0000
Date: Mon, 27 Jul 2026 03:13:50 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260727101350.GB482062@pedri>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <20260717215520.76C261F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717215520.76C261F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CO1PR11MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 22014e05-65af-4129-16f2-08deebc7c1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|18002099003|22082099003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: eUZNrIUBsljqLwjYEu7MHzTS9plSabSKNwFYPKQsm9iIbpfaOMVCicednm/qnDQlLRCXTN4PNh5L2Tei3BqNXN0+Iaf+VXDNEX9xArWH/1j9wfZ6hVr8z2rCXGDAvVXx2BJOE6dH15EhZJ6s9S3PQSfUDeqJl5R67WUStlv4OIkRuP5yJbLgsRe4fPziJVdqPJcMCk04EG28BhMk69E/oyNGq1RzWUolGg1pcss0qMVI04zOzdO3b1a+lPAHjqE2YRFVENbK0R56zk+D49hGbaNPkNKs1uQGW3+SVEovoaOew62UoQ/K3Yg2te2xeFHwPBcbhBw2/xuA8phO+GJop8i2zW48ZPjntp/lur6LjN2+mJtmHmKGqPju9PiGZAywbreFKkScAmUV6GjClg8mji0WPBAX+cAUBzGofvy2Q8dx2vLXzdw8+xeT1j6AnZyiBvAqvKxIrhoCl6LfJu2tx+dqcOS7nYtMpzmYIIeu0attz0SzCuBT/DVbM/U0QIPNzpo7Dzw8jc9JHiiq18o7s6+Q+wyMAsRRKc/ji4qKvxuwwn7UXP6IVUmawkoeIghaZnsBJOCYyBWHvppsgrnL8Ks1UrEN4jiYy+EHWnTWFaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBteVU4Zi9WbllUR1IvWTMzVFV5YTJ1LzhwWVFDVGRuSXY2UTN4c0syZi95?=
 =?utf-8?B?Y1R2WHNVMGFoRGpuQnZRWExDVlM4YzJBbUh3dERoNEMybmcrV2d4dGw0cExL?=
 =?utf-8?B?UzYxdkRhMnV1bWxFS1VpMnNrQnY2UHZjMFMyOG5mMCtDLzMzamZsaTErRU5o?=
 =?utf-8?B?SEdheXVzV1cwSlI5RzgwTHowM0d2QjA2bVl3QkJhRmExQWF1VWo5Ym52NTJ6?=
 =?utf-8?B?QmdNeTVrd0w5ZHZLYm1iUDRGT0tYRVdMUXlXZTh1NVN5SUsxRitVZndHeVo5?=
 =?utf-8?B?WDdmS1k1Y2tab3ZMck0vVE12K2NMa0NCOTNia1h0aDkxam5IOFVGa29VQW9n?=
 =?utf-8?B?YjlQaEt2Qk4rS29hUHFzU3krOEhsUm5Va1R6Zk9xaW1ueGJVU1czaStnRE5q?=
 =?utf-8?B?QjVoazVvMnFjWGtJNXJqd0VNTGMzTFEwU1ZTN1R2ZitPczJCb0t4azZUZGM1?=
 =?utf-8?B?Wkk4OXFCYUFJajBqbERlMGtKb3hCVXFpbzVQeE4zUGVyVnBWRzZuTnRnVFRr?=
 =?utf-8?B?VWFqL0Z6V0xoUnFmRzlTdzRBbW1QaWRoUWFxWW43clJxTERqUHhJbk5Dd21P?=
 =?utf-8?B?MDVsOUU4Nm90cTBHVVhwWlVMSHUrbjVSY2hMbGk0K3JFaU9HZWFiNE10YnNh?=
 =?utf-8?B?bmJ4MDhFNXp5L3pTUmJZSmFhd0RqY2w4ZCtDOTQwbk5XWllXRDk2bUJHTU5K?=
 =?utf-8?B?WEMzejJIYVJ3U1hUcHRqSjFYb0dsT2NCeDhNdzVFdFArVEZnK09PRno2ZHA4?=
 =?utf-8?B?S1cySGxDcmFmdndKSDE4WjMxNUZnVEZCNWpkY3pDQWlBdStuaXJEbFhNQVRj?=
 =?utf-8?B?OE5Pb2l5RXRhbWMvTjE2eVMxU2NHQ3NaSFBHK0RiWE53NUs3WEd6UFBQL2ww?=
 =?utf-8?B?K2UrcWw4QXZQeEVJZXM5bjM3N245VWY3ZENob21aSkJUcTFGM0w5dld2ZlMx?=
 =?utf-8?B?NnAzMEZOeis3UWxjWkx6U2FWSDN0bkJYVktzc3BkVWgvK1FaZ1JlT1RBUThx?=
 =?utf-8?B?UzJtMTFhMy9HNUs1NHFFNXUyeVNVL01sTGJoS21VM3pPcVdLQWhnTExCOWJk?=
 =?utf-8?B?WjNiQkxLVTRHdG01RGdFcmtXMVUxQy8rN0orSDNubzhvK2lDR0oxVTYvdTFa?=
 =?utf-8?B?TThvSGpVS0ZkRU8zdUhZQjNtam9BSDJQSnp5LzEyeXJHOHovM29aTDcreFM1?=
 =?utf-8?B?SXNFMlRIZGdqeVoyS2gwR3FVT3FJTVl2ODFVQW1wS2ZpcWI4ZTJERURSaklY?=
 =?utf-8?B?ZkhCWnVUM3F6eGYxYUliQnNrczQ1WFFURXZibGdnY1JTMit6aDhaaWZSVXlK?=
 =?utf-8?B?bjR2TGc4WGY4b1B3SHJpVVR3anIzSWlMNFJXWGZwKzhtR3A2WjQyaitua2FB?=
 =?utf-8?B?b1krYWxyMzlBOEZKc2ZPVjFiblFRMlVMblpCOG9LRTFBMzh4SmhtRmR3QkxY?=
 =?utf-8?B?eE5YV2V3VEV6WHcwdjFwRGxjc1lWQ2ZtUUxjOW5lWTlhTWxVOHRCZE03QjFw?=
 =?utf-8?B?cVdXRjF0eFhEM2p6djRvN1RaWjNxdFVWL2JIVVdWaU9CVThPby9Oc2FDUHlJ?=
 =?utf-8?B?Vm9EQWgxMmlHOVZQSkI5ZWZDQjBBL0ltTTdTeVRhOEF1dDQvQlFaY0RMZWhB?=
 =?utf-8?B?YlFpb3FvU2tteTBiVkNBUS94dUV3NmRqL1ZhckE2Sm9sM3BObVdJYUxaYzJW?=
 =?utf-8?B?SXRCNlMvUU96UFdlY05XM0U0VlFQMXhJSGRNMWkwK1lkSXZTL1VCMnRCTS9K?=
 =?utf-8?B?N2gyMnZiYURvSVBOamlESThoMFowU0xicmFTTzIyNE1HRXU5alVZbVpoenEx?=
 =?utf-8?B?RlV5UmtJMElFeVppMUVyLzQ3MWxGOVR2TzBvbG1uY0hoek01MHZMeWp2Y1BK?=
 =?utf-8?B?U3VBQ2g0bWNhT1kwQzJoQ3N5aDAyU2NDMUw1Uk82aTRDWkV6aHFZcEZtTEZB?=
 =?utf-8?B?ek5RbERjaFQ2NXpkaHFqYmVjWUxiRFQxdzZGeHVGRVRZakFpMkkvNlNqQ2ZI?=
 =?utf-8?B?djhIbGVIajJOclB5QzR4c2Q4K2IwamF0aFNuZ0d1VW96NzBRVUFZMWE0QlV0?=
 =?utf-8?B?a2NZS2s2b28rcm5uNUNCOGllRUxtaEFNcnRqcm9jSDBFUzljTWxtVnJOTzRl?=
 =?utf-8?B?VCtwdjNHM0dWdjMwcytDYndVTUZwV1FDZXBkNjVPTXI4RGxQOHRORSt4bFB6?=
 =?utf-8?B?QmxjVzNuWnd5YzFRdk1RYUdhcysranQ4ZFpVdnJnTzdxZ2puQmdGSFJ1UC9w?=
 =?utf-8?B?c0tnejBzYXRvKzlYNVRBaXRESU1uT09pRk5zcDBMcGdqYkFScWRZbm5MSmRX?=
 =?utf-8?B?eTBjbTlwQXJKQTlvRXRudUdnejZyd2VWV0dzRndQa3p4Wm0xMXl0QT09?=
X-Exchange-RoutingPolicyChecked: XQj9e5orvFQ7bnFFDgK4M/Q7aJZoVM6YB2zSNeu0e8CYaareLKbUKmNZ7AU5SdUoDfFq52BBQ9ZGHZfl05hZKsEVwJ93On8yukWysaV2yR7lQ2COe/iGUFbMgQ43FiF/dREtI8zdRAe+pg7jTSMHcvgHAw88jCZG1cDIg1lAAT72Iy+Ju3bbZKKBSpVZaJJ9JWS1P78M6/4KN85dRNZ0ieIZ80SayDBBYtFo6Fkqk2YhhB08TciSdGpIwP0g8iekGos/ywdxJ2lPtGLsCIp6mIxzWD7DLsEnz7QH6nOd1fRdbl4zgrgK0DwB/pE6w1AeNIwaErdrEKe2RTCGjZ/UnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22014e05-65af-4129-16f2-08deebc7c1d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:13:51.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+T6adATdgEmATseJWB7vKQj11ianBeEx6/cp9go2GEKeVRGgiLM/DDj5edL8feEubr2wX6QE9xi6cfUDuJs9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:55:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Premature exposure of the misc device allows a Use-After-Free (UAF) on the module initialization error path if `alloc_quote_buf()` fails.
> --
> 
> > @@ -417,7 +442,7 @@ static int __init tdx_guest_init(void)
> >  	if (ret)
> >  		goto deinit_mr;
> >  
> > -	quote_data = alloc_quote_buf();
> > +	quote_data = alloc_quote_buf(&quote_data_len);
> 
> [Severity: High]
> This is a pre-existing issue, but this patch makes it significantly more
> likely to trigger by introducing a large contiguous memory allocation (up to
> 4MB) that can easily fail on fragmented systems.
> 
> Can this lead to a Use-After-Free on the initialization error path?
> 
> If misc_register(&tdx_misc_dev) (called just before this hunk) succeeds, 
> the /dev/tdx_guest device is immediately exposed to userspace. A userspace 
> process can open it and call ioctl(TDX_CMD_GET_REPORT0), entering
> tdx_do_report() which uses tdx_report_buf.
> 
> If alloc_quote_buf() then fails, the error path calls misc_deregister() and 
> tdx_mr_deinit(). 
>     
> tdx_mr_deinit() executes:
> 
>     kfree(tdx_report_buf);
>     
> This freeing happens without acquiring mr_lock, meaning it can race with the 
> ongoing ioctl. Could the concurrent ioctl in tdx_do_report() then access the 
> freed tdx_report_buf?
> 
> Should misc_register() be moved to the end of tdx_guest_init() after all
> resource allocations succeed?

Good catch... I think this race could happen. /dev/tdx_guest is
considered a legacy interface now but this needs to be fixed. I'll add
it to the cleanup list.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717214349.4075994-1-peter.fang@intel.com?part=2
