Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F397AF2
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833333; cv=fail; b=igLPghxdDJZXdivvJ6SA5XarBnJAju4izV+hlCZUi8w0xsFKanT7nqpfcsj7WcH+XUCjcgRcxM6sOkpvH3mjNNVCQGl/yLzFICMQi6cC2190TSoR11oXhNKV375aCA7mWj4bvgEjE9ywdtI+V2jf+utVRUJGttRU4cRhAOwnPxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833333; c=relaxed/simple;
	bh=ZBuL4MocjncfTdr19bFbqsIST3kZEvEF3aivN1yoG4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=riMe5jR0cJnZ2PIXBwbasP3jhvCDdQv/aHlczcgI6rg2V0JferSq9OeshsnwnMIGfBAEjIGvLpIdhEJyUBNwb79zwGD8+UQGZLmb3KuGaFRgCxOnBH58wdM/J7wEksuUH3vv87iavaVJZuDB+u7VLEGEY4jX9b/yFZDRoEy0K2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imRPqibU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imRPqibU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782833327; x=1814369327;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZBuL4MocjncfTdr19bFbqsIST3kZEvEF3aivN1yoG4k=;
  b=imRPqibUQJh1sEqe2vtPnvC0vICkFzh9UHVwWRVxFHO1XjMoo/167UEt
   pjf7LDc9cLEV/89rJGEEfEUpfEeBs5NqJHHHAd67/I97kXLseSfRILmhq
   X9EF1D3kNks3AqU8vAIcbMkLC+7JKcAXCc4/bJJPOxzOAZPxm0np+Evdg
   58HtAC0hr+MzLLYTdi2VA9bE9nedtReIgnA1A7Q8l07jnr2p7jZKf4rSv
   ecwSS6bpBK5EnmC/btIHOkIaWnd3toKFoyl/MBfn6jNNlI9fhpkChL/bG
   4hDJt0fbfzhiiqjXW+C3mf9x7mWLaV5DQDgwnNSSEjZ6emcofy0TaS26m
   Q==;
X-CSE-ConnectionGUID: kIjeic20SMyOCjWXQQD65g==
X-CSE-MsgGUID: orK1MLhYTeGV6XCm4XRO5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94701372"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94701372"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:28:46 -0700
X-CSE-ConnectionGUID: 04Mym0CNQhCi1U8Q1PMkCA==
X-CSE-MsgGUID: aghUPHfBR6mKqmzA9T+TMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="245949168"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:28:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:28:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 08:28:44 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcKMiRXe7JvCvGx3iA7mYyuDRPVqqF1PQJNvkXAKUrwCQTM2RE61lYwwIAYiAuRDGiZWn6HC0RS8e9TK+AZvfH2tm1XqzuLs8+DqcBn/GZ/8f632+2Mzvy+QfYe2KI0UCYYBfQyLVNfEiavfovjdJ8PQWMJPjsaPKvPzogSfDKtnwKhk7/yXSSW2ldPebkziUqdEf/JZ1sKIX18kLpmnn0MAO0VduHFsgfPNboPkfJ+I71Wmv5Fe6Vvf4lkJxZx/1/FwnDxx3ajzJ8WauYLzhX/N/jjoh4kzv7DG2CSIzypsXeyJclCVZKytPL4xIrBwcH6urSGIneNGxkYKS4UrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh8EX1oCUvfPEDfLGXn8UmiBNKZMfM2CBjxdzUsKLh4=;
 b=vply2Aw7AEXedofoKuySD74JX2hXp9SqJz7OHOsjild0NnfHW+nHuT54RJJN5WBO0+IKn5luJMrSQGqKDOWujnX/s0gF59kYH5pTdFUC2NkLsOIy8eDLqFr3zvcWWLfBTwzgQ6xKf2oBk9fHfhibwMHqnMxBy/1+Cgw08IHJejiRsbNowJYcysm7Gw/8ETIfnmue86hk0/6DK0qvRauuj/HSMSJ40CmGGKOOkt0oXazXNhhl9FoCBCMtdAFMq6HFu1D8V04vMhveg+4vt383gmGwGTzQowZpD5+l2Yzkpb3D7LN6UMFVnwIsGKS/0NSM4Up9omVmP5FpSA+Xx6p0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 15:28:42 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:28:42 +0000
Date: Tue, 30 Jun 2026 08:28:40 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 11/17] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260630152840.GG1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-12-yilun.xu@linux.intel.com>
 <20260618084940.C48821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618084940.C48821F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|MW4PR11MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 287885fc-b0c0-426e-367b-08ded6bc43e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 75EtoeEQ85VGELnbDOclglC4beNjw+Wrnt9DULD+pafdr43LseooFnFnKIQaRNiVEQDvn3gRdU6dGRx8ZDWserICCXBTJ13HFd5jcjAKT2frF4C4Z+kRqZKfnpVd496Z6xO8QqCcAv2ndt3hNA6nt1XO3rwDl1oehye6WMb5DjCQcgOrXz4YaNZ+4Y8zLLv0ZxuRr5weBtpfiZ+UeCA+xtbPsjKSGC3DCOK6BBBENpcRwXSNkKa5DjKWxjSTleEXi7LVr2dmM+yOIh0ole93sU58Ol7PEHZISWgSJUF6trsnH94B8YmvHiju790yCZRowwJpb3EWWNNpkFWhuEVG7YSmgLksXtmIhiIjElT7ttwQpXtB9l4JIxAMSgUpXtP3Fe1R7Ur3LapfO6ZujnXhhmnndH2p9w+BJq9ONMhfit53XAINCPxfqKQOVwZXzkkGwKh88Ch45KhQ0TLo0uDBaR6wRY+Liv9twJV4PfvvshJ97Tq85/w1fA8UNfbJRWjCfeOHUtpjFOe6vEEplLtoHYtt1EIxs4a/FKGJRtoks2ReYVM6tcMExfOkeGJP3BIO1ljT2JBXAvWo4j2MH6OplYrasqsJ839NwU8SqRvyGNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FjRS90Z2ZNbXZQSmp6a0FJY2I1WldiTkJGRlk5a3d5OEllR3JqdXErMHNi?=
 =?utf-8?B?eDV4QzJLcjNBanlqK09MdHFpcDMrLzVyQTVpSUlCbWhWc1NsM2FUejd2K0xa?=
 =?utf-8?B?MThSM1RabWRpWURtS050dmQ5dlVQVDlLUE9GM0NyUEltSVFWSmJVektwZkcr?=
 =?utf-8?B?bmZoRnFOSlF4ajMwNEwxYTB3bFpBcGFpcTJjUmNaRm10OHhjVUw0YUVlK2Zh?=
 =?utf-8?B?aWJ0Y2lCMHRlcHNSZjNBaHZRK1BXaWZMOXhrYWtOVkZRU3FJYUMvWXRNWHhF?=
 =?utf-8?B?RjNtOGpKbVVGZFQ1KzdsczY0TXRFYlJ3WFpWY1k4Mjkvd1dCR0dhY1JETzhm?=
 =?utf-8?B?VmhyZGFCNitKa2NzdTBRSmxVZ0ljN1c2eTNMeUYvdHp0MFBGSjNVRzVnUVBF?=
 =?utf-8?B?NThPVHk0dDJXZDBnNmkrVXIrR0lmRXhNSEl2OFZGWEtVbXBNRkJucXF4aHR0?=
 =?utf-8?B?bU9OQk9HTjcyOHBuaitxZEt0c2Jhb0NZQVg5N2d2U2MvZStjR1gyYVVGUlRB?=
 =?utf-8?B?Z0JNaXJYRDNYRUI1YTRWOFBxQ0YxSWtuUGJsektOTnJNQ1djTzliMkhSK3ZD?=
 =?utf-8?B?Z3FiNzgxc3phOE56Ulpva3pHOWdOS3JkeHlVOE8xeFA2cjBqaDh6NTZiQXkv?=
 =?utf-8?B?RFdnMjlYdXRQUFV6M3k5eWVoTSt0L0hnU2sybjVPY2czOXVNSG9XWWRRMVF2?=
 =?utf-8?B?UGtwNVlRR1p5b0dXd2pyRlM1V3pMSStBQm4wS2J2c2U4bHlJaXZmOGtnb2c2?=
 =?utf-8?B?RW1zaHpLZXJBTXVvTkJxZzhRS0t2T2RQMzVhazYwQVk3dWM5N3dMcENLZ0dX?=
 =?utf-8?B?ZHhQOWp4cGdjVVdTZFBrOUFHdXpEeWl3b0htSm42SkhnRHpUVGNzRWhFNVlu?=
 =?utf-8?B?YnU0K1Rtc1NidVMzQUMxcjBER0tPYXVWR0RvemtkRVVBV0ErdnNyYlVURTJt?=
 =?utf-8?B?dXRIMmZhQ2xoSW9PcXU3NTY5cTA4Q21CVkZLQzQ3ZjFrcDlBd1hKL0pWc29D?=
 =?utf-8?B?UEFjenUwSUt1Vyt6c09Za1Zxc3dNem5RQ0N6aWI3OW5kcFI5TlV6RGxCclJX?=
 =?utf-8?B?RnhrWlI3Z2dUV3VvdEZvSnBoV0ljcDVsVVNkQXBXLzhlUWNZeW5nS0RaVHkr?=
 =?utf-8?B?aDFwcm5FVElZNVJWVUZtUHlOZHlXamJCRkl2V3BvTUZxeUhHSFM2VDBmRGgv?=
 =?utf-8?B?eTZKaFp6WldqeDVRQU4vaGhydXFYVkFIWmRhUit3cE1Peno2OVVqUVVncnlu?=
 =?utf-8?B?U2xnaXhGOHZTUzFIMFlOQ3VkbTdNYWRNcmx6N3A2ZzJyNFR0cEJkUW9Xa0pk?=
 =?utf-8?B?aElWeWNKVTNtR0F4V0FtQTUyWnhKNEM3aFQybGxsMWxxK0JBQmlDNE9IcmZh?=
 =?utf-8?B?SlI4dUlkWHpENUI3bW1XVkVBVUEzRnNiWnVubnkreUdDZzl1Qyt4Zmx5bkRY?=
 =?utf-8?B?VEIwK2x2ZERBMms1Z2w3cS9nL1V3dkFoc3BkS3AvbktyUzgxTDY0eGZSZzJz?=
 =?utf-8?B?amtWQ1hhNG55a0JRMnVVZ3R2OGdhK2ZmVUJVb0pxaVkvSzFMYitxdmREdFYz?=
 =?utf-8?B?ME9MY0pxa25LSHRxd0pDNXZEZk41azNKRnRXNlNWZDVBdFhxS3BZRG5PRFhK?=
 =?utf-8?B?K214R0RiZW9lQmVZUGJUSno5QUxaOG1pWlRVTm5lMm4wM3RsQUdjR3hnS0l6?=
 =?utf-8?B?L252cnRPYTNHcE5KL0ZKbFVISENNbG1KL2t1TEZzR0hhWTFUeGRGQkJ2c0Uz?=
 =?utf-8?B?MUVWYXNsM2loR0hFd2c1OFFKTjRaWTdPVW5VakhsKzlSQzNJMTRBVEw4bUJT?=
 =?utf-8?B?am5LeENYZTNkSEVsL1hGZDRkYWkzcFRySnJRN3dYNnZUTFprdW5laFVha2ll?=
 =?utf-8?B?QUxCaWViUDBUSXBhVGlOVUs2L0h4S05jcFBPUVU2ZWNXNVdvSno5M2FWcWRH?=
 =?utf-8?B?dU9hSmZqeWF1TE8zOG4xZi85L3RMc2tjSzFxOWQvUXhPQ1RPMzBrSWs5bXgw?=
 =?utf-8?B?SzZtVTZzczQyWWEwcTM4YmV6Y05xQU80STRKYW80UytvZHY0WWlCMldyaWVv?=
 =?utf-8?B?L1ovM0xQMHhGNW0ybE9EUHMweW1UcWZ3RXFNRDkxNzd4STYvRitzektRN2wr?=
 =?utf-8?B?NGl6WndHb3JhM01zbXBDRkNIb3BsTEJESzU3WEJqUUFwUEZoUWRmR2JrQUdB?=
 =?utf-8?B?MHJLR1Jtc0E4aEdkeXNEVGk1eDFwWlkrVUo3TjNkY3NUT2l6TENvM0pFQndR?=
 =?utf-8?B?VS95N3VGYmEvN0FpR2czY3JLaUpXdlZwSDl3MWY2Ymx3YTVRVVZYRVI3Ym1r?=
 =?utf-8?B?ekpQaGpiNCtjZmt2ek1jK2Q2TXNiYXlraFg5aVVNbGFHYTl6NU1SQT09?=
X-Exchange-RoutingPolicyChecked: qs3sghOH8eHwD7hSuK0N90uHjN056VTbdNG2lyemSLIe6ZpaongxPFpy1oseTwxmmoinpBNknSj7/sEO9o7jUckLk2MerF//YkrbUxEceCNGFHTO/r7wmXkM+LOk/qg4w2/l/f36N1yYpBz0HuMir04h1SwSIak3/OWF4oryXepAA1C6JHlEKjrb6fJQaMkShyUZOCh2FhY6KhZGZY+bZlkz/sAIAptlOWEFeeHU8JIH47bFTo0NxUA2GQYREjZ1fxZ+TrkuSnZu8nzYjxBTPIbkG9DLT0kglfsVK83oxB5Anns9rtPWvoGDMyThTbd4oNYx7sNeglXlS6HAnAjLEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 287885fc-b0c0-426e-367b-08ded6bc43e2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:28:41.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBTTLs+TNaft3wxE296SkQ4bM3IPd1QPqSwDtmphhGxVz+W9rc6uK840aGrDKdgV/ddXazP0U+F1EisRFV5F9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 08:49:40AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] tdx_quote_generate() uses an uninterruptible mutex lock for a guest-triggered hardware operation, creating a potential host-level denial of service.
> --
> 
> > +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
> > +			 u32 *quote_len)
> > +{
> > +	struct tdx_quote_data *qdata = &tdx_quote;
> > +	void *quote_dup = NULL;
> > +	u64 r, out_len;
> > +
> > +	if (!tdx_quote_enabled())
> > +		return NULL;
> > +
> > +	mutex_lock(&tdx_quote_lock);
> 
> [Severity: High]
> Since this path can be triggered by a guest, could using an uninterruptible
> mutex_lock() here lead to a host-level denial of service?
> 
> If a guest rapidly requests quotes from multiple vCPUs, it could monopolize
> the global tdx_quote_lock. Other vCPU threads waiting for the lock would
> block in an uninterruptible sleep (D state). If an administrator attempts
> to kill the waiting VMs, the threads will not respond to fatal signals until
> they acquire the lock.
> 
> Would it be safer to use mutex_lock_killable() here to allow fatal signals
> to interrupt the wait and permit VM teardown?

This is a good idea, but I think graceful teardown can be addressed
later.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618081355.3253581-1-yilun.xu@linux.intel.com?part=11
> 
