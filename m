Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36104F7CC5;
	Mon, 28 Sep 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628839; cv=fail; b=MiD9jan3XSSUWy8pHSWEUMIRvulIrX9ElosyxZTEVDejPpTLnL0pYsTOX9K3le9UhPsrj7I/Lq6YI9LagwHBBAzUKJXPvJjeNZ7Wm5ser99vOP4ufpicTvJTPncEjAMs5W+qcDdgPPaecHjV6GFKFrVzuiYmRAiSRR63AhVmk0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628839; c=relaxed/simple;
	bh=4VgIhJp0EpGDeLXsJSUw/SXNQLYjz+CI+TH4hAejeDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSi1a5J9c3EpdtcIU3nc0/DpZgm7pgM92B9FE3+qKylMrMb0/WvfHTGEQxW/ws0AvhPLmIlEAwMsUd6bY5lvqb+n4J2Na5vxKvPGXsCndSb2BJ0UGTbJpxbtV4jQ7YkxXdShQLF2CQlV1vJsCEaOSq3+wgtwZIw9mRpt/wu86zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3/mq/3h; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3/mq/3h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790628837; x=1822164837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4VgIhJp0EpGDeLXsJSUw/SXNQLYjz+CI+TH4hAejeDo=;
  b=k3/mq/3hl4aI+NeWjrplp/qHbLpK6FOCeuHsmPw7846xBOz+v4EMJdCP
   bKRjh5LPuWZdk1nooFTzCX5aC42k5EQkZK/VFG832kK0dkEXoN29laz1r
   31zdQmECNUXUqoROn9oU0BDkkuphz4I1FHn03telCx+lmyqAi91xHAMFL
   quR2yP5/zCmtaxtSvBkWxa0clCco0EmZk1MlR9nxxhwkTnzA9/jULWE42
   gWzHNk1P+6n1ONBE4/25oldvopNz/C99wtSJu1/H/K/SwPYHcYvA0AHa5
   h+SQXpAvcxxM6IZWOEsfFhVhniTvat785gFXzaSEqlBhGti3ukGk/yxxi
   g==;
X-CSE-ConnectionGUID: OZksGz2SQIeAC0/1uxW9LQ==
X-CSE-MsgGUID: xG6o7mExS0mldEuvTfG/aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116866368"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="116866368"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:53:57 -0700
X-CSE-ConnectionGUID: 48HhazFXQVOkpOHFrahR9A==
X-CSE-MsgGUID: cgqS+FrfRFulwImztIZurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273289262"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 13:53:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 13:53:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 13:53:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 13:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8dmFpGCZQInbgvbmamb9UgvsoxvR4G+digsT0VnRbJVoSLxlj8tE3Zr5gIB/oP13Aw4Co6PoxIP9zQl3nBzDnQ2Lcl5/WH5v0+7aclMiTtXRIHGz3uT+IBWzzc/r67BYv3ilYsVtOkWp4lA8sE7e6j+54P938ZtUWclO6r6lMdiy+TrzqE6Xyn9dT6NPoyHwFmh90Rl5MZTGphxYsJHQS3drrXWOkj0VqU6s83kaCe074hRtNe3YRyqYFrYSz0NR8CZnyVmh+S3sNx6txccM9C93GsfQQGATdFjLcYOSGVNmzqiCHlyd0SkFyUDBOSugQHhyLIcQ9SbnJHTw4UBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVZrdHUcFhQc9vlhxrw+pTMOSJztBQGYz7mR9fw1c4Y=;
 b=pjlImXRnOVuSGPJd0oc9MN2TcHG8mzENFLyd5EdESJQJiND1ml+YHM+0uRRMcHfEK3ti9/GdamSl7NWk+HAGWZTZNzOEqIh+DCHQNVuDsm40kyM/O9BRnWNaCK3w1wu92fgATBKKEndfAGVFGjAwsSD4zt7rWX86gduRqJ/PPe9kKrFrq8RAG0pvAUkqUwXlTAA14PHw+HiNUJvW+1gcZ+TN3AyvP+dFA5wbWLeAt1vRCmaCPyoE1gwGIOG/R6KconvwtIEDZiuzqElB7QohBOKyR/sAeGtiqSyHP6Lqp6Fgg9Fi0PrFfKlZH3aVddnnze6AVCAqrS8lIr48sHvBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by IA1PR11MB7753.namprd11.prod.outlook.com
 (2603:10b6:208:421::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 20:53:49 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:53:49 +0000
Date: Mon, 28 Sep 2026 13:53:28 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v5 3/6] virt: tdx-guest: Calculate the Quote buffer size
 safely
Message-ID: <arrTyM42WnUUSgR7@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-4-peter.fang@intel.com>
 <1753d73f-7464-4476-9fb7-c0a12157a6ab@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1753d73f-7464-4476-9fb7-c0a12157a6ab@intel.com>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f37808-0c84-4b96-f3ed-08df1da29890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QDE21yWamtCnVPJjVmggHAk5mD/7ZsaXPuyefJtPiEXqGp/NqaXDx1fVnG6mY9VmI6kTUDKf13+3nxVRVPb66YetuFxbGiSbZpJxU7jEq8PLnlFJj5QHTdy8PXjJkJkF6hE3SZrs+KPvB2M6gfLIWh1kO0LQU1kiHv1PUdycpM3kH6CHMZdGRZaWFIPCM0TACi4oYuYWp+7IMKZO3YQMyneF96c7gSD5kiqAj8BROaI/ZXMeaPkct6pAKBwCfhQj8WQX5D5GUciygVL63YQ/U66vAePdTRChfhmoZbhuMiRmLW/y4BkLKzZ+UsYQI+2jvpaOrJuiUPVi4j5RI28wTXcIuxwwXOSi/mbAKuFiQFc4W7pDz/T/gKpN3jQhQMh7L2k9I2842M+IXcCmPAxGaBm1e7NGckvfz3MRPkbuIoocIbB4feL9BEtoMKsFy377sCpfAX/lzfrImYHafIL94dDkH7OdTPljwotPkzkLDT/mC1AWU6qTpc6WbjYjWqP6rscSKnUz456PKJQosdl4GVPTh/Nf1zq0t3CN94lmIGJHb4W97cMeccoootfJmQJ9t7OPnP2jSs1ti7XSyK6QIZI8dGMQlIWcuAJI119b8o6N2nYiyjswyLI5/g97uY3oM0b1YXOuCBvSbiWk3OAp5p8hu7keU2N6GuNu3/ne37I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDb8v+0GCgkSeGt0Rz6/MRypp7SMaGLsPSJ8lG4siLY6MVg0MadZ1NZ1xRwC?=
 =?us-ascii?Q?/nW0vTztdvOLOq8AI3gHExlCJN3uuj/L/kL04BZBV/pSGRouzCeGf6Sh7jzv?=
 =?us-ascii?Q?c/svxIne7AEeXN1Nlj2k9R4tMfQ0EU5KEbgkyXx328EbXFfpRzvCkMUugHWD?=
 =?us-ascii?Q?cHYd9arZnqeEfRWUdqRQwxOR9Oen6UD02Aoeo9CU94z4OD9YT/iI54NT0Fg3?=
 =?us-ascii?Q?iicgVdzrxzCEKWBv866BtJ9xqFEQf60T3AQMCgm0W7w5XBh51eqyDRVpz3Q8?=
 =?us-ascii?Q?FyU1cLOUCsClPmw5NBcLNqqWdgfUBucoGEbb7IB/otBnkIO76QoeuS9T4FBD?=
 =?us-ascii?Q?Dh1fO0LPeP0RdZ2ijjfV7M0eNU6ZqzgQszsL00rZsTNJGOJoT0bj4kgOkQM0?=
 =?us-ascii?Q?ays4Zsl/WSJuamqkvGm1YnWKSQ4w8kw42IBSXUFVTjWG9AIqzOL1swE0ns3U?=
 =?us-ascii?Q?tRlt5XFWYH1D9ioI9LML17ABITfo/HNOr1/jU2sxTzk+TD1t4mApkY+UYbUa?=
 =?us-ascii?Q?itEpF99psCu0XLuDnfCdUASFjJe1z6Ego0FY56hFsxcO0d2AKtjSG4APaS2F?=
 =?us-ascii?Q?xUZ2FR5tiPiLfTI0XZhYsr80oMYFemLkdmDVtKkWJoxMD/LVht+Go8VtIktu?=
 =?us-ascii?Q?K3RIqhRbbe3FpCQ1Igjl1C/wpNTw9BLluxJgxFp7WlRvRHIAc0xMgNiuiySI?=
 =?us-ascii?Q?lbrdyRwlAWl8sOa47S4GgKKapn0ckPFpsIheFhE4TQQmPaMiJgngQPqZAecv?=
 =?us-ascii?Q?9L5sL6r05T7M0Pr+u9oUZMQzYyMY+SbpX00MSSMsfcVMlzok3ef2NFVmWxVs?=
 =?us-ascii?Q?QAbugKPm1NrsYZMqUMgfoeVwCkqsjhNTePxhALt7g3+oQccPOF5EZBV2oC8o?=
 =?us-ascii?Q?C7wXwSI0/yqRlp8ym6ED+/THTbGyyZovfEKwJkfZ7OSuGuvV2raGpJA9+5hK?=
 =?us-ascii?Q?KLoebbeo7TSDWvV6m4ByJlon3fHd+PAKpEujZNQpAueyJNKgIUTtEwlGB13S?=
 =?us-ascii?Q?d8sHzM0bH3IZvcYfJI0qJr1uEZCFpTiV8nUdL1h/jZhMZkrtbPrCSXa7AH70?=
 =?us-ascii?Q?0OoFupX92crneoywKdC8JGm+Hq7/7+xVhrbVAawRj89Mx9RlJVr2cQgtQAb1?=
 =?us-ascii?Q?8cYKa/G+kkp4aBMR2hFC8030Xh5MoyzIXATY/83gGKk8V0y4BAefYKYMc431?=
 =?us-ascii?Q?UUXcXjdLJRyVA3XEF80DaQVUAbRo8bzvOqEOLLZzxkuE7H41li9rYQu2WR7N?=
 =?us-ascii?Q?tMOlTYFbHQlxXE42Jm3pNS0mJugTOe/WxTx5rY2uHoALyx+TaoMmldrTjXjA?=
 =?us-ascii?Q?ncHOqPyb815VUePZWhDoBUQH6XAv257RydzTzr4jz5H2+5xU49o29q6rTEfu?=
 =?us-ascii?Q?btnoQtbWgEAY9/m3hQrtwqAWyHajA+Z/jhJhQYMTB36oAge5k1PMxzSQKO8z?=
 =?us-ascii?Q?Js7y0CNU+ar8fL2HnI9dWPLGm3rguBT6BC1CnjlOYSqjpxkFnVBFX9pZru8G?=
 =?us-ascii?Q?D6Ppwj3bdHo39oKCw+/y05HCpSBorCMgBWryVLs1j4YP4YYCAuyESgqB1+e2?=
 =?us-ascii?Q?j1Gfk4gPq17ukHJojYii6IHf8xmCQ/XyFU5YXUkPLvDlZ+x3rX+dYMV5Yj4s?=
 =?us-ascii?Q?uAgVwoYmVwIIEYRPr4CcSOJE7QkoLn10DqDa+z5FoDfHfHuSJPtI0hLvSjV3?=
 =?us-ascii?Q?szgUdT/vN9Ah4hWwk76pkEPr4AkrdZHr+Rak2qy3xHxI4k/vfFDUAYsea9V/?=
 =?us-ascii?Q?XlGSZ5zV7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: Jbf4S8xH/oc5V3Ru+5Wwh/E2frjAGTRZ2U4K0LK2yz0D3yhP7MpXtzbKvWW0sz9J2T4y8vc7OJZzLMldVz2O+orZkqbRuo1GsUVoho6RWSgA6CQAuR0cIOcHkW6v/9uk8Ey70EHV7XkEoaGUOy8Apd7/+lELTW7VcOtMB2CvRjhR2rZ6XF2+5N+hMO1AqHhRWuYCsjLjt4gwMpBmJFqLFwAEODHoxNUwfcfm/Y2okA40RkkSPNVHgMTGnrz954ilHJydHPR+YHxo2LG/1VNvHcssRXJf3MLex3Jh/xheUbe5i4o/wPemO9qOiyyn0CoWkge2CmizpheYEjlggvjl0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f37808-0c84-4b96-f3ed-08df1da29890
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:53:49.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqHtT6s4Q36cWP00CwgjOZSsGv3k8Rd5lGQQwk8ddh35cVe+Zx/CkrChfeYkn8GVj04YzZpWBlank5UaNEhBFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 08:50:10AM -0700, Dave Hansen wrote:
> On 9/28/26 03:08, Peter Fang wrote:
> > -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> > +#define TDX_QUOTE_TOTAL_SIZE(n)		struct_size_t(struct tdx_quote_buf, data, n)
> >  
> >  /* struct tdx_quote_buf: Format of Quote request buffer.
> >   * @version: Quote format version, filled by TD.
> > @@ -314,7 +314,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
> >  
> >  	out_len = READ_ONCE(quote_buf->out_len);
> >  
> > -	if (out_len > TDX_QUOTE_MAX_LEN)
> > +	if (TDX_QUOTE_TOTAL_SIZE(out_len) > GET_QUOTE_BUF_SIZE)
> >  		return -EFBIG;
> 
> Gah, this is awful. There are two different literal "data" things:
> 
> 	1. The function argument: void *data
> 	2. The flexible array member: tdx_quote_buf->data[]
> 
> Worse, I think the function argument isn't even used, despite being
> passed through at least one level of static, file-local TDX calls.
> 
> It becomes a *total* liability since there are so many "data" names
> being tossed around.
> 
> I just committed this:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/tdx&id=d48b2d347105436365280a3697a265aa4d37e96c
> 
> Any reason not to keep it?

Thanks Dave! Your change makes perfect sense to me. I totally agree.
There are so many uses of "data" in this driver.

Dave actually suggested offline removing TDX_QUOTE_TOTAL_SIZE()
altogether because it really doesn't add much value, forces the reader
to look for the macro def, and doesn't even reduce LOC. So the next
version won't have this macro anymore. That also reduces one line of
code which is a small win.
