Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CE3D0921;
	Tue, 26 May 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785888; cv=fail; b=Awv0udgAWNeM7EqI2KwoGvw5ttRwghvXeRfk+0ThG8Zvj5E7ca81gUPidyiuPejvw1kC2TN5etjgR2zyQQYD5dJ06bkiLOsy9iGscZgStDWZ3jxWtwhcipTc7Rx9SShtpRGoe3XlX5I8ndM7SGaS+wvf4IRB40RRreqJ7UF9hAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785888; c=relaxed/simple;
	bh=1ZpkK/qfTbipnhdw3zzEJnucah4jPUiMPDRZh00c59k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tls3coerOdlY2NzfIDe3BxDDqR+MGS2FIJKQGhk7V+vRfTzExBAgKxLJy5hQzo5IqfqitZmR0cBuS4FBcb78qEhLbq7qWbgAtt13IMH6Dxpnn1IdbHBUjjII9vJvWh7j/XK6OzC5Kg+ihKBGpDGJT1ZI3gfrrRgXhZsvqXvqDXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0B3L922; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0B3L922"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779785885; x=1811321885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1ZpkK/qfTbipnhdw3zzEJnucah4jPUiMPDRZh00c59k=;
  b=V0B3L922IFdU7fKiKnlEq7M/ScVDl/BEw9vW7qlF3bg0hAnO5PETSQiz
   NXhoAMJrMwG8xWUDx+iAu+5IicZ8pryqIfCBrogHWWCbqzic/8TW0iR1j
   n1KBPp09CPnQUNOC/M/9+6+/QMFOKKqr7tf9tLC25EPwHfreJ/jM5YvZ2
   Ge2e7ObMpTzbtx7298HbXDWU97L5+KAi3Yq73JIiNljGTGRy/2wu3fePH
   nbc+PLr+8seyNLIIVrR9aC7DuuFeFt7XA6EwdDcnivK0g2kCpd9o5LLHr
   uEPkvhvxJ26eToUaS38NwEQ6+u7JibESHS4n7Wj0/bcuKAd38BP6LbIcF
   w==;
X-CSE-ConnectionGUID: eybAUFTpRFyfDtyhzDJ8Ew==
X-CSE-MsgGUID: oATzWxRoRM2p3nJHZBIeIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80565202"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80565202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 01:58:04 -0700
X-CSE-ConnectionGUID: DO1hkvhjQrSPfraha1RRxg==
X-CSE-MsgGUID: +gCy0oC3R4qdjPg6qdqMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="279982680"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 01:58:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 01:58:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 01:58:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 01:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTzJvGWeU0bUG78RlHwjANtNNezJEn2rlc4uV4I+pFswNlNwyl0i62eJXIy6k4rX9+e2o2VjpeGM91zfNQ5Uko/3BYQTHSy6bZFsJVJEGNObAhtGyzkB8QCekkBFdI/RTD2bTPQ+vv7ZmwgUnbZD9N0sF+3zMm459ZhWKSrDGbJmv5xPp8NKZXrRTJMf+FVsKesYObbPRhRQE1UgqNCJydzQ8R5Wy71ymufNU1S81puB/X4KAb4yAyGK4Tb4jlNUUuGS8uIpNsdcICAig96xEQ4ElmjvfB1km3OlNHfT/XRb/8y/jm1+0CXTIUALClGMNuJRFsPoWdRUCq8sxsrxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQkzxB3j7g8bRRfHYRo98+vinK9qsLzUGJxVVcrKFxs=;
 b=VXEL32ZH3w1NEo8BdsN2tlMKBVbBC2UYMbHzlHjmjZbzqtO9fhymyMk0UA9ImZuTjxsmH9Gq6kWCPXP/6EpE2lCKyLhB+3YaGr+XlDO+WJPOZ35t00J0Ts7x0oiaLOfK8FdY2rKDQ5nCRkEHyCw1uN39w4xMqel+KsR1CgTfE+jwtpG/Am5wugfavJY5qYHR/EzpB3ddv1ktJgRgdYprscKsvA1rmNh6LfMxC1vqVMpG/LVu9pO+nBx7RT2/SJ5ZQ/en/o3p1sIlRduCHVM+plak8+ydyVvvhFpK/cIxZzefqjPNZ/pKu/KkqkzEr7Zqsv7zh+FrSWFr4trgJiskVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by EAYPR11MB9587.namprd11.prod.outlook.com (2603:10b6:303:2bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 08:57:57 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:57:57 +0000
Date: Tue, 26 May 2026 16:57:42 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <ahVghgNAe4JrmlQH@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-7-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|EAYPR11MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: b245e31a-b218-4cb2-330c-08debb04e159
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|4143699003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: N4hDgXrLmvwE0N7F0JcrX9EeEym1nrc1iyys2/8bw9mUTxjl1ah2VuDKFvyhbaFshqYgMx+YL7fEkfEaEejq60qyMmem+VDFnsIC0NqXlaPGZlNM7DAYDvS+o/Q1ldwNQFr+gcOoNeUrf3d2eu7aT5BVXsbah8e8RQ42YJoB3bYmDHdVZIMLCokMl0bmhlINH5ZK2RhoX4/7V8tWdZZI6AikpYQwKIoS0WcKzcAgL4hleWtDN/qN3QO7uhC2Bjg1j4BY+wImWGTXD+zkIXKn/39WHZnQuqaex+UHrAPOcWvUD3v3YLkr1FJ0eg8dUnmldEDh8sisQTC5ZiXhQaYnseAntKEItqzijQ+CWPNYtut3ogVbhxAmlHQMIUBTSTX5Vp8q7+wHQ6QsD2Ju8Z9bwon77KLbkMc/lmS4fVWnY2BGFkHDfueX31NhX7PHL8WUtFJT9suoOPbNcSI3hbM1JjmrLpwq5bOiVtkyetxCHJIUcugo3hTwkyXYayOn4rvN9aa2dQPVMmObcKJLURUB5uQZ3w/Idkmq3XiJN0rmxAR706nsUbFwkTQMhoweOPtGwcUyC3O7gPD0PrykznteLaDhNJOlgsCfmbndnM6hzfBljnwzA9xPe8pfxVfwmS/gwl0zPun2y+484dtJ2f8D5w3tuxszN2306hC/nE/oreEwy5UvVRh5TLojKaN4IROu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oe349+ePvcjRkIlC9DBv7rNi77mrfL/iuGdHqh3HfVb+X8gUiFcNIR2xvNa3?=
 =?us-ascii?Q?0hOvzzjUK3P4HvJxk1Q/7ZIKUe+ynLp7d8zOgU9hyqaqG1+GUpenS1b4rl8b?=
 =?us-ascii?Q?yp7Stro5A9XSYFHLybYbmKcA75We07V3KceViQpTt9OsUfPhweu5hspLvDG3?=
 =?us-ascii?Q?hMqHZbV+hTmQ2qT1Do6SvfU8HqmnUwfsOyFm2D1u+/LWcMOzel3uC11s856F?=
 =?us-ascii?Q?CPKMtWOgdmbLTNyIYK9YIKNx7+wNdi+jAAqY4h5/J+B5dfsppCiIzkLJTWy5?=
 =?us-ascii?Q?L7ZMVcW71yOFF3FEDkzHgIlpi1XxWriJ8FXmAMiu3UHYvKuNPdNYITFBpBWP?=
 =?us-ascii?Q?DvolCKsQOitGchp73kZM1MQPDQ33sqFtH/MZomXm7EBdTXDYMkC4LfWnlBDD?=
 =?us-ascii?Q?+KTwlszW53hDqVU0Gj1KL1ezZpe6hjjeaugcrRxOgnnlja15LAYwnq0J/1N6?=
 =?us-ascii?Q?kv/REhv2EFPFg6MHt94sL5bNjShoRXqEf8Eg03J3OjUaBf1ZPU0F/TxbJ8Iz?=
 =?us-ascii?Q?ke705pgiJ2Qiv9q4c856tcc5Pzpi8+a59boaAejFKAl1kMKddMi9VoMTIQDG?=
 =?us-ascii?Q?gn6D41lZwW3JJw8JRMSrFuZlxzyJJkU2BONO6f7/x/DNbMw3is5XVLFxr9Gy?=
 =?us-ascii?Q?hoGiVOz0b3MXzaR76qSQ/yo93xuT0EVd7a+aGtDjxX/mhd7ZgvknJo6+Emcj?=
 =?us-ascii?Q?Pxp5h4ln3C4nnu5IxyBd7DW8hw9B+InlIPvkTqEFYBsnBA9Cl0vohA/DJ4nT?=
 =?us-ascii?Q?U6XrXnrjNReil7PMIfdV/82ryitIq2zXHF/1s5YFyjG/VeC5cGcHbSyiEiNw?=
 =?us-ascii?Q?IjtuYPkBUmqkZ1yve+T/2RPGySncnc9trxDS1SdqYU253ErWxNvzTkvAF/ZY?=
 =?us-ascii?Q?aNHX295rxJV/FS+7++Sh6m5JPcAiUUcjsqOebALFPP3pYqnkNZrVnHDtFg60?=
 =?us-ascii?Q?CmF8GcP4PCSc4CoAgfnv4VdBpo7/0H44v8Bb0rTXVozFQmEpba9eY5SUMBSH?=
 =?us-ascii?Q?qHSV+a3tBQ1//lJLtT9JhmFT6lAuC5+NELOBaw03suL400Ab/pnlJlPxx7U6?=
 =?us-ascii?Q?hHJrs9YttCoDk/OfKlNgSPMSm6sn8deyrI3sBdwc104VhjX94WciDnt7ZxZG?=
 =?us-ascii?Q?B5pP6IL/uB9659kJ9zVmo05Dp34MPWoAA8mOQhGSx2vE9TOsW8LwWeEUDuPn?=
 =?us-ascii?Q?WsIC3h3RJPVvCZE8VXujRRVvCoayeReySQrSimqC/LZ6rrYHIbz50Du1lgu7?=
 =?us-ascii?Q?Dk0jAkBXzJ32tDNC5Zs7WOQiKM0yyEdwrbQ20qLgssncYX2HzoliQGQy1YOs?=
 =?us-ascii?Q?6Z1mdWPm25z1zkuCjufHd9bUuSMKJCTM+Z9AGdJ6nFjoXHSknXnzxrun31KY?=
 =?us-ascii?Q?+pd2h4Wknf0U9ck0q7Ibr+u7atum70/9jxRko+EklA9Z3BbZlYvQ91O4ytdu?=
 =?us-ascii?Q?YH4iPrbXNKcw5OYP0WJY1G0MfJveMWG8RYS/XtVieXwTSkT9ct5PBUCEJNEF?=
 =?us-ascii?Q?6M34qsV4VbfHDHG9dAwd+zq/WDUbBGRy0MdMBxpcwn463Dk+RwRwcgP9Ghr5?=
 =?us-ascii?Q?cfOrpq5AZ7YQQtIWFdkgRyfMNXfhMEu9iOvioS6eDi6p3ZwIbAZVUJl40OGb?=
 =?us-ascii?Q?WMAnhOmvqN7l9I/M5B5p8viXmJP4Ty02fNnRovCBymnxZRVv04DI2ApvaoX2?=
 =?us-ascii?Q?fcWePx49ELmR0HVEgJ7y2E3nrncPC9G5BNMa5qp206lDu36MOITf/WxC695I?=
 =?us-ascii?Q?P7+O8GAdgQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: I7QaBMLitKX07RrlmcVrGTvg7SlRDqnPP5vmADDp2g9Ve3uUO+dUBofrWC3veRtjtIyBxSjC9GBzM0QaWnwv3Tf8xXZpEkkjGZeOVEagTyNOUbzSPS1eXmH/Eky+zbE5xoD4DT41f3jBbMHr5d8xKBsgkiAv1pHhvqDRI7FhG77ufq9Q0ogsFS1NYebHYTd6IIoDI3c+vVhup6X5leJK4HuF8L06w9o94dH1KWaage8wElRqbcB2YDq+Du+34hFNbkbgI192vsJwNthSjjAH0OeTUCKZgeMU22yJQyle9NnEmun8mvSH6Y7o4OJMIJmwYITzHKgxowqGHTQNkof3Gw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b245e31a-b218-4cb2-330c-08debb04e159
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:57:57.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKl4k3IXFMN1f0aluwI3RFAWbwx3C2wpOs9+FH4lgwUyFwKVWoa+tZICgH7tpg6VGKO1Pt+uxHU0ONAmCWAEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9587
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:10PM -0700, Rick Edgecombe wrote:
>@@ -2057,32 +2057,50 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
> 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> 		return 0;
> 
>+	pamt_refcount = tdx_find_pamt_refcount(pfn);
>+
>+	/*
>+	 * If the pamt page is already added (i.e. refcount >= 1),
>+	 * then just increment the refcount.
>+	 */
>+	if (atomic_inc_not_zero(pamt_refcount))
>+		return 0;
>+
> 	ret = alloc_pamt_array(pamt_pages);
> 	if (ret)
> 		return ret;
> 
>-	pamt_refcount = tdx_find_pamt_refcount(pfn);
>+	spin_lock(&pamt_lock);
> 
>-	scoped_guard(spinlock, &pamt_lock) {

This converts the scoped_guard() added by the previous patch to
explicit lock/unlock and goto. It would reduce code churn if the
previous patch used that form directly.

>-		/*
>-		 * If the pamt page is already added (i.e. refcount >= 1),
>-		 * then just increment the refcount.
>-		 */
>-		if (atomic_read(pamt_refcount)) {
>-			atomic_inc(pamt_refcount);
>-			goto out_free;
>-		}
>-
>-		/* Try to add the pamt page and take the refcount 0->1. */
>-		tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
>-		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
>-			ret = -EIO;
>-			goto out_free;
>-		}
>-
>-		atomic_set(pamt_refcount, 1);
>+	/*
>+	 * Unlike tdx_pamt_put() which uses atomic_dec_and_lock() to
>+	 * atomically handle the 1->0 transition, the get side has no
>+	 * equivalent combined primitive for 0->1. Recheck under the
>+	 * lock since another get may have already done the 0->1
>+	 * transition after both saw atomic_inc_not_zero() fail.
>+	 */
>+	if (atomic_read(pamt_refcount)) {
>+		atomic_inc(pamt_refcount);
>+		spin_unlock(&pamt_lock);
>+		goto out_free;
> 	}
> 
>+	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
>+	if (tdx_status == TDX_SUCCESS) {
>+		/*
>+		 * The refcount is zero, and this locked path is the
>+		 * only way to increase it from 0->1.
>+		 */
>+		atomic_set(pamt_refcount, 1);
>+	} else {
>+		WARN_ON_ONCE(1);
>+		ret = -EIO;
>+		spin_unlock(&pamt_lock);
>+		goto out_free;
>+	}
>+
>+	spin_unlock(&pamt_lock);
>+
> 	return 0;
> out_free:
> 	free_pamt_array(pamt_pages);
>@@ -2104,32 +2122,34 @@ static void tdx_pamt_put(kvm_pfn_t pfn)
> 
> 	pamt_refcount = tdx_find_pamt_refcount(pfn);
> 
>-	scoped_guard(spinlock, &pamt_lock) {

Ditto

>+	/*
>+	 * If there is more than 1 reference on the pamt page, don't
>+	 * remove it yet. Just decrement the refcount.
>+	 */
>+	if (!atomic_dec_and_lock(pamt_refcount, &pamt_lock))
>+		return;
>+
>+	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
>+
>+	/*
>+	 * Don't free pamt_pages as it could hold garbage when
>+	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
>+	 * there is no risk of data corruption, but do yell loudly as
>+	 * failure indicates a kernel bug, memory is being leaked, and
>+	 * the dangling PAMT entry may cause future operations to fail.
>+	 */
>+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
> 		/*
>-		 * If the there are more than 1 references on the pamt page,
>-		 * don't remove it yet. Just decrement the refcount.
>+		 * atomic_dec_and_lock() already decremented it to 0,
>+		 * but the PAMT entry still exists since REMOVE failed.
> 		 */
>-		if (atomic_read(pamt_refcount) > 1) {
>-			atomic_dec(pamt_refcount);
>-			return;
>-		}
>-
>-		/* Try to remove the pamt page and take the refcount 1->0. */
>-		tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
>-
>-		/*
>-		 * Don't free pamt_pages as it could hold garbage when
>-		 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
>-		 * there is no risk of data corruption, but do yell loudly as
>-		 * failure indicates a kernel bug, memory is being leaked, and
>-		 * the dangling PAMT entry may cause future operations to fail.
>-		 */
>-		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
>-			return;
>-
>-		atomic_set(pamt_refcount, 0);
>+		atomic_set(pamt_refcount, 1);
>+		spin_unlock(&pamt_lock);
>+		return;
> 	}
> 
>+	spin_unlock(&pamt_lock);
>+
> 	free_pamt_array(pamt_pages);
> }
> 
>-- 
>2.54.0
>
