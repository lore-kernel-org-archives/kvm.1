Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E146AEF4
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834755; cv=fail; b=YMb6YSTk5sqAaZGTpuj4ADvgZHtksiMcZh4uvJT6FUKqxTmw5zKRmFg5oahgIiNsbp/yxr0i4lZ+j7KTnvqUPPVaqrHMXPLqkwyiRCahS45cyUvDhqTDOGccUWPy7V3oLfJKXoYPLqvZd0FSA8ocsQWQFiZpby/UdiPaSwEECbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834755; c=relaxed/simple;
	bh=GtpXbRjz1ZhzeOMaDIjEd6iGtdLVPmklWR8wnvHvkiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TmYxZaPXzTB0hIq9qho9/k/xNwdAFPX26L2kKy9zURBrYtJCQT/jyZ1mcDIzK+3CEWDdeZoWigJIJmwBIxt76y/tbo9hF3wYIuKsdPHWBb/w9PMFacI9M68e3ZwG7ve92klVRJdS0Tg8F4ErPlPdszEjk3CDQmArg/8ZgEw53Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3/btmwW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3/btmwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782834751; x=1814370751;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GtpXbRjz1ZhzeOMaDIjEd6iGtdLVPmklWR8wnvHvkiw=;
  b=X3/btmwWs+DC2Iit7ISoQmKb8l1eFiwjWu9RvHQcasuJxEA3L8KT4QrF
   1OSPcULopkEQoVWBpW9zc1UzWwDt2qUUKnzwa/aIvVWMS9VLEpgx30yIy
   UB2ZHYqDBC7i0JTa/43MQG8U2xTTAGXP2Pa0LyL8TzdBJEhyGjpHNmiiI
   Ez0+asCf6x0AsiSabROS0zSFoBhm/qSwp7yuHZJ1BYthcgm9f0d+ucQVA
   L++7HWMYq7Js07T6f3ISLSv6eg3JMZf1Ta5KOTyDabjKE4RThVApAWe6Y
   7ewqjCpfwOMFHtmm8ghtvSqrOu8FbyJKOR3jM2PJy2NiNFghDdUNw2hMN
   g==;
X-CSE-ConnectionGUID: ZZpwKpPYTyqrgUPNDk1Onw==
X-CSE-MsgGUID: CTms2QmRRCeSs7G4+CM+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="95055889"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="95055889"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:52:30 -0700
X-CSE-ConnectionGUID: Zbef3C60QWilM8gB4eA61w==
X-CSE-MsgGUID: czdNGLXIS+SGAelynF3pNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254210152"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:52:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:52:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 08:52:29 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAtx20VAguLhZ3eOBEVs62O1DANNDXfuzl/1uCoCTEcLPQOrv89dUpImE42HBDKlFU+q/r+nkKLbzxDBvlbatnd2bXCu4O0jeB1GVQ1HUL1bp4tMGpCC5f7lry+wCqHuTnu7EhpE8e49Z6RIz0xlMK4Y+m7eZFQZ9pH4fhsaIdU6uk4Bk3n6GU62/0Q4f6dPUbeNXuO7KcvHsJnXZNpUFrLF9Wvm3OoDjliMYXWaSfgAjV7sRyzDJl/UkhJl/OzarIU7nI+vafNpwcwq5fUeawM9vhgPj1AjyyyIHIF491QKy7XxcYT/0GFBpXbcICXxIKScUtLQMsG2wV3YTeLjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOwNUqz7Be02YdReBOPt+jqf1SeRNxzWEInrJDiydbY=;
 b=fkyAiyJrXLMadJfhU8jqJvsN7Lpyd2AO3TqJYt7J9A/xc0EB+DozKcrPtbfv/8vAUAkRAEstklK6hXDK/mPJaFoCGoOHGqUxmbKRQx1MxDXPzM/EixOjjlqh7l+Vs19zMbNOYqAGD+l5crRdOV2tEiVeR4ahiHMPV0GenvgfUEEsKlFYj8KMQ69CCA9uy/pdyax4hTPzvJ6dnuWQ3O/Q26s6JsOXMo99ai0RUW46RhSzzhM9NVWHUru2IxICtxaPY+WTd7DXB71IoaHZT7uhoMYpil+yuy1C2M90Pu8HCbFrZXPyA+1RqakbpsWa3M72LPB+08rHWfYR0wgajpZ3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by IA3PR11MB8967.namprd11.prod.outlook.com (2603:10b6:208:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:52:26 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:52:26 +0000
Date: Tue, 30 Jun 2026 08:52:25 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260630155225.GH1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <20260618090310.43E9B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618090310.43E9B1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|IA3PR11MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b3c3e2-5559-4cf0-d0f6-08ded6bf9504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: x+X/+Rn+gInNQFfAeSxFD/YsbYgY8x2XcrKADEYB7pR6MedRRsohIHPiRqWk6reUzNUlahPq7sHj2n6X4s07LsswzNPyb+LPehbPxqMq54NvowfJzfKoF2JEGb0xNTbYz2swoml1PFTfOFTnj/w0rhBsOCg59ajtZzM7Fh+Tls9+5KB6bXJFAtefxyT/PNYWR/IxQURJWJ8f44LD7TYofmOjLTysf5iYoXYpADy5xSR0qd5qU+FIYlGrZ2K+exeBIMDG3wrjFCYGuNDVMZ1uJ71LibTGIloLaGtX8jQCmwkl0Lj35TmNQjl/20rOPN1dKjJFSAe/MWw0l5GVieC1jrSktnaCfwWsM5sgxf07RJd9mai6Pa+hQIL0F6HbU7C0zywBc31Icav1dHfiBenI9yDi5oRo1tSnHfHiO4/5AzAEnzxYkkX+tsif8j+Qifw8AVZwdyvZSt0KeVu4KdE0l1lgssucmTKXL06hB/QMTdyhiwQVpKiGsf5dBUamcmJh0SWbqCxeNxNNCZIbxfpNNtCFK6Kz9E1bnrkvpR1NUv/Spn0LzVDVlAapfYHlwjoN50qTVlJgec/Gsa1BQTzUExg9yTAU83gmd3UT43Z+DdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5lN1BQM3lkQTJYVDF3SHF4dVI3T0d2Mis2OUJhaHYzSG1Tclk0QSs2THIy?=
 =?utf-8?B?V2M4YXIyeTQzaDUyUTI1TThwcDFwa2VLL1RvY25DbStITjFQU3JqS3p5Z1Jx?=
 =?utf-8?B?TGhDN2FKK2VOUUNPRlg0cXhXVGE3d2M0aDFHRmR5NGhpMGRudnBNMlhtbTQ5?=
 =?utf-8?B?VThYUHBxeDFTc2hSTGJvdEl1YmNhbjFPdnlxc2sxN09YUmpUWVplaFZ0aFZG?=
 =?utf-8?B?cEVEOC9zUjlxTkxRaTArNzR1eHFYOVh5My9TZ24waHllaXZMcXhhRUZVM0lO?=
 =?utf-8?B?d05sSHB2Z1I5dkVXZU10cmphMi9tVlBmTTY2SXBVMWdHNHVMNGwvd1Q4ODJ4?=
 =?utf-8?B?R3ZCTXF1QVowNm9NWUYveHE5RkpxVkNIWHd4WUZNVk9WYVhDWjZiV29vN3RK?=
 =?utf-8?B?NFBPREV0a1BlUEJiUGpUR2tWWDZFQ25ZUXNlR2NsbFgwR2JBVmcyZmpwR1p0?=
 =?utf-8?B?M3VXN0U5UXhFV2JLa2dMUFBzUjNXVkVKcGdtZkR4N0pORXZJNHhBUnVFck8v?=
 =?utf-8?B?eGp3ZEtoWWVuem56VGVCQXM2NWpXN1gyRDNEOXUzZkRoUklibXFHK3oyVkNJ?=
 =?utf-8?B?SjNydTE3TFM0Y3BCRitpYTB3cmN5aWYzR0drODd3ajNhTmlDclhpYlhrdUE3?=
 =?utf-8?B?elR3VGIyRTc1T3A4MU5GcjJ4UGY2cldEKzZrN2hxbnJGSG9OWEF6Y2EwV09T?=
 =?utf-8?B?YkZMNzgwVmNmbkZVMFp1TzduRW8rS0hCWGN1TkN3WjJDSDlCTzkrY3hFS2xj?=
 =?utf-8?B?OCs0cjBuWVRFT0VlRWFVeGlvQ3RtdlVQWnhRd1lFVnJLSjRqeUdyQVRxdTdn?=
 =?utf-8?B?aG1EN3dqeWdnaUxrTnBQUG50NXkwaU94Umt2MW9tTG9OelZxdHVrNktiWE15?=
 =?utf-8?B?blBGNGxoOFR3RjRkV1dlUEhYa3U4QzhERXNNTGgrRG1ZWEJFKy9yQnAvMTZt?=
 =?utf-8?B?MmJzeEtpUmlPTnZCZkpqVmhEVGdrMGVCNXRNaHdoeDBDNGdCYWd4Q3BjNkxL?=
 =?utf-8?B?V1hnQkh0TTZlT1N6NWR0eEtnVWlpMTFucnNZZXE3a0RZaHhMMXdvVjNkSUht?=
 =?utf-8?B?VXpKN0JJTk4wL0oxbmZLcjYyak90U0RSeHEwdXZOYkFJejVQUTVram95UzJW?=
 =?utf-8?B?ckdvSUNtd01LNFVHOGRLWUg5aFRlZHVDWXZzTzlNa2lrZHdXRHA4cUFiU083?=
 =?utf-8?B?SUtCaElucG1LZFJRQTRHMUdibFdNZlMvR1hPUmM4Qm5Eak44ak8valRpVUlv?=
 =?utf-8?B?QTRtcEE0RGhUaXNrOG4xL2VxeDJ6andYd0pPYURENktGdEtkd1JmaFdHNDJE?=
 =?utf-8?B?bUZ5TDdhYU5nMUJlV2ROZWhPMlEvNXZsMFVyRWJKN0MvZTErREg4U2UvbzMy?=
 =?utf-8?B?R0lGaGxOMVM4Qm9HcVZXcnQ4NFEwWFZabGFiNncyalNvOEFnRmhtWXU0VXZy?=
 =?utf-8?B?dU5nTU5wT2tFNkRKQ2VPNjRVZVZ3L3B4YWxiamtmbGtSZ0dGeXhhMlFXYXBj?=
 =?utf-8?B?MW9VbVEyaDNQcTVTODV1L0p4OXlQL3p6WWZBdTRJMzZINnNtSnVkM1NubWJK?=
 =?utf-8?B?d3lLdllnaGZnbjlhWGp4SGM3RVUwTFA3UEtIR2ZZV2ZyclIyWTJXcW12WXpx?=
 =?utf-8?B?blRhVnBuYXNWcDRIa2lkVy9ZY0pwdHQ0UUhtQW5tNy9TUXNCWXUvN082bWVC?=
 =?utf-8?B?NXdBOCsyMlArcytRM3pwNGs1WEJ1cHRWMHR2MWVaaWpOV0kzdkZKR2xGMllQ?=
 =?utf-8?B?ZWRrRUErcmlQTG8vUmVvVkFOL3JJc1hTVzY0RDlvaW1ETGlKRVoweWF1c09B?=
 =?utf-8?B?SCtXWGtxSHo2MTczRU10N09LMlZHdDV2U3VsZkprcHF3TkRkdkVCUDA0eE42?=
 =?utf-8?B?Ym5aSmtSUDhaNWw0SzJ4dEhwRFRvMkJ0Ukh4WEFIakxBUk51aTNJdUFIMlV3?=
 =?utf-8?B?SmJCRDdoQXFWaldKRWdSZldsV0FEZUxkVTB4Ymd4V2Z3Nmh6SytlRVdiMVRB?=
 =?utf-8?B?bnJVN3FrejVsZzNuY3lFT2RPbCtDUWt0Si8zOFJNeFJ6SElBOWlUc0JyOVEw?=
 =?utf-8?B?UzBpdTViSW0zdFV5d05CNFB0ams5ckFmK3lKWEpSRTd1cEFWVWl2VDhRNmR1?=
 =?utf-8?B?VDZhaHdCUXVUUHN5b3hPTVg5UzdaUnFGVnRGOWxNeXRrdHpKNldXNStLVmlr?=
 =?utf-8?B?OTRubXBrSTVXeVpBN3d4ZnVWQXpOdFhpQVR2VnhpRGN6U3cvOHNzVks1WVlu?=
 =?utf-8?B?TS9mU2FVU3l1UlBGWExENkhrUmo3QzBia2JUOVpWeHQ0ZWZMVGxnQTNNeDQ5?=
 =?utf-8?B?VmZ6ZGRuQXd6U25wcURJR3MvVXB3bzR1eWFQLzJWZVRLaUNGTU1Vdz09?=
X-Exchange-RoutingPolicyChecked: CnVQKG4kNt/nOaypg7dPnbHVgHwRij8EHEWicr3sYcAvtBj5cLH46Z1r8A5UjlzAYN1a6mKOIkhB0VJAiEwSDgbtzvBXCHrOMrLfQpk37o0ulE+lgBmd9h9cpQOIGwc8vKcm/dtRYyf0SssDDeIBjv9TJN0Vo/+gzqxt1pir92gdAkt2wWLBUyeFZvidmdxnqdmKyfjoNS0xaEIGklphwjORcGtPfGz6q1B6UkW7PiSoEed8WXciMfUg8ZHlv1kbCbzZ/ldabh6XGvLACP6AlmC1aV32uyrNSz6d7KfSwa2ecTBRfel9IzEVSwsbTjl2ZUzYuVjw5mUdQxibUBQdxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b3c3e2-5559-4cf0-d0f6-08ded6bf9504
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:52:26.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RCuWo4W6/w5TRWkEgZfa7Jwz0g1VB5OKtIVUyVs1WClaCVa2KI0DNgZ/gizVjHNRyfZrfEXKOLBdZf5zNOnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8967
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 09:03:09AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] KVM incorrectly returns a hypercall error (TDVMCALL_STATUS_INVALID_OPERAND) when in-kernel quote generation gracefully fails.
> - [High] KVM fails to write the required buffer size back to the guest when the provided GetQuote buffer is too small.
> --
> 
> > +	/* Caller owns the requested quote */
> > +	void *quote_data __free(kvfree) =
> > +		tdx_quote_generate(td, req->data, req->in_len, &req->out_len);
> > +
> > +	if (!quote_data)
> > +		return TDX_QUOTE_STATUS_UNAVAILABLE;
> > +
> > +	if ((size_t)req->out_len + TDX_QUOTE_REQ_HDR_SIZE > total_len)
> > +		return TDX_QUOTE_STATUS_ERROR;
> 
> [Severity: High]
> If the guest-provided buffer is too small, does this early return skip
> writing the required size back to the guest?
> 
> When tdx_quote_generate() fails due to an insufficient buffer, it populates
> req->out_len with the required size. By returning TDX_QUOTE_STATUS_ERROR
> immediately here, it seems we bypass the logic that writes req->out_len back
> to the guest.
> 
> Will this break a guest's ability to dynamically probe the required quote size
> and retry if its initial allocation is too small?

Returning TDX_QUOTE_STATUS_ERROR immediately should be ok. The guest is
expected to get the required size from a TD metadata field, not from the
returned out_len here.

> 
> > +
> > +	if (!write_quote_to_guest(vcpu, quote_data, req->out_len, req_gpa))
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	return TDX_QUOTE_STATUS_SUCCESS;
> > +}
> 
> [ ... ]
> 
> > +	qerr = get_quote_kernel(vcpu, first_page, (gpa_t)gpa, size);
> > +
> > +	if (write_quote_status_to_guest(vcpu, qerr, (gpa_t)gpa) &&
> > +	    qerr == TDX_QUOTE_STATUS_SUCCESS)
> > +		err = TDVMCALL_STATUS_SUCCESS;
> 
> [Severity: High]
> Should the hypercall return SUCCESS even if the quote generation itself
> failed gracefully?
> 
> If get_quote_kernel() encounters a quote service error (like
> TDX_QUOTE_STATUS_UNAVAILABLE), this condition prevents err from being updated
> to TDVMCALL_STATUS_SUCCESS. As a result, the hypercall returns the
> initialized value TDVMCALL_STATUS_INVALID_OPERAND in R10.
> 
> Since the hypercall arguments were structurally valid and we successfully
> wrote the error status into the shared memory buffer, shouldn't the hypercall
> return SUCCESS to let the guest parse the actual quote status?

Good point. The hypercall should return TDVMCALL_STATUS_SUCCESS on
TDX_QUOTE_STATUS_UNAVAILABLE. I'll fix this in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260618081355.3253581-1-yilun.xu@linux.intel.com?part=16
> 
