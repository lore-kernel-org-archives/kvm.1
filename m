Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454242086C;
	Tue,  7 Jul 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395945; cv=fail; b=TVrxV6zBlWCKCXcS6AbN2BBwYhoUocOlo8T3ZscjpPAdnPE8+2adbsnFymBE79VJrGnZxAPFwUba4BJBMT7dUBLhA1HmELOglInOs97Tv8IqNivzR2APBfTTCfzjHowdSJTbfyBx6hCU5SrpQOsSedoHpjVGOqCNHFWWEbayWug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395945; c=relaxed/simple;
	bh=E1ep+E0IUDMUelPBIzxUE0hQTiy1u+w8Ix6lGDFoRc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F9FAQrr28nF2k//5Tb1uu8USCzTUTxg+rXFcCx1AWhXvfJFzhJrpnSIbl05ruA+jnGvDgLSaS7sgNr9q2FGQDsEJdFL57VzvVgeKRjpVcIpYNVjL2zdO2qxvT2f1YfepCiIt/dTvlCfuWF6RJngm3YMXl8UfvJlbQbe6hMdQSfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8um8ehD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8um8ehD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783395943; x=1814931943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E1ep+E0IUDMUelPBIzxUE0hQTiy1u+w8Ix6lGDFoRc4=;
  b=B8um8ehD0BnQuiVGrBytX7QlM13vMm4qyXTyiYNXWqth1hPPZ4PErvS4
   q381e1i0HM7RNt/Mj0eDBA5+vZlO2Hp14HfAz2qdz/LWNO9tYVuqoAd33
   t8xE0LyyREh4hDAaQoNWxLyVTjMLFczs4rc8n8ozmO3YMIR4OiWqrtZFG
   QcgiefyleHULMZFyHGpoqaGN50AdtgS6HLPjafPl/FOhfJzOn4elwYdwc
   HLAVBq4oXO2d/eSUyzBfKRnrywHpOU5y2W+r/+M0OpWRh6oJKmxghyrW6
   2ozQhJgtRUgXm6QocztkuDPbg63VFCIgMQYnqjtSJYsaqthcSSVZq+Iwn
   g==;
X-CSE-ConnectionGUID: i9W4I/8qSzSdbym8I4VNYQ==
X-CSE-MsgGUID: tNX5A8Y1Q+CqvBS4U5evUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109578249"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="109578249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:45:40 -0700
X-CSE-ConnectionGUID: JniD6CraRSijNrHTI4oP2g==
X-CSE-MsgGUID: WrMejXU4S9eFEoCFetOdSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="277096867"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:45:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:45:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 20:45:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDTIDMex0NBpWAGDoLhIpnRDsSP80TY6/ZTUkfTmlzYSN+SUBT9kalB5APwpQd9X/85GGlzi/lQJ5OkrOnEnPmv99N1P/fzHLDyG1rT1XM3J8Ol9MJr326gLIHFtjs8fr95dYyN5sLH7kvmM1pjLjjEhSPxNfXpOuZHqS7/jx3vW3o3xFOaS+1YSW6iNFQWElDHqgXTaSq+yyPSNII0z4ON7OX6Ul56C8NZpOz/stxZwzXIwIkMA+AUZF4gI1zwrl5Yd4gaLWibP4mmcB72aRcL2n+FY1ZGczwUf71KrDHTJVTy+hkkMZbgFdvRkAkGP2GeQhc5nQhCbv8XXAaAQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjlPbuZwjB+XXoeHfjC22xPE8EXOjUB8D9f7tDGDGl4=;
 b=E7z6Lk9pk63C004p+nOKHqB+chBLfcnbMZ6mP2XBiPKASNl9bh//18StzsJZEAMliqSnldodEcpX93CT4CcHuTK01/C0rq/IF0lEL8P9+u82NzTbtM1ZrGVuN57qy2vZcLXpJhEyWetYQOCb8d14cEIY9bQwa5qceEztlCwuH9awFO8RgwnNB9vzLeMmfuHVHCSjKePCGt+XEFYXRxumkGLe8ItbnyeVCRCWvSsOalApf5qLbfOCz0GB30DPf7kraYTGxHyi9NDbp2y8mIYP41mVczxW+gBmySyGR6sOS8PfLRgZQuAeNQM7dXRTsSttu16suYJTLmmmaIXymp8oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 03:45:36 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:45:36 +0000
Date: Mon, 6 Jul 2026 20:45:33 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260707034533.GD2169894@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
 <a8441214-1560-498d-ba01-0807502d0e28@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8441214-1560-498d-ba01-0807502d0e28@suse.com>
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 3477f351-8464-45c0-c850-08dedbda3379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9Ewkqv1w3TFthdbcLmfg4Ci7zwt8Qvc87d9WHwYcoUNiOLUlnsve2p6CjxsieT5UFfevRih5TrIh/55okgs7s4NW5Fg7nNuLtYsMP1Poe9nYXpSieLQbiggtVfbc9bVutm1rGH5o9Zg0yBcsNtnOR0nrk+sKJ2KbZeGT88N46WAGozhkH4nwDAqe1PkjVkpl7L1o6GFzgs72zR32jVp+ScYUxM9gKMGnilhEL9b3zRmMRX5QJpqgXpKqgXYroB5km87Iuz1vT468n/zvrbrWHse0ABxnpVO2P4BGuvO9pXDQGJqtbbWUjI1a36l6pVlvN8Qp6lhgCGsh/yP75tFNwEU24PGJuDQMAkxhMD0rIXe6gYnvuCBBd9b2nBCi3Gie7JLYKDtVc7MbA/Jv1MJsW6l6yWJUHnqX7RkVpG3H6sDGV3NCk6WQMnoeectusl++4OR8do/foqArZz+kZgn81HweI/JHr8n2OnOyFL9fsoVEz/E/F7f0K7jAV4sT5+pvs+WszredBgmT9A+T5To02gOZPhpeMZCbnzWqIL8DoefimRHM/yZqmCjoyHFGTRKUG7/5PFoPazXfWjz3x8WnJOX1rJlcm13ppF7uFxvT+w9Ehpj0+UUEnLSReuTCSzvg/WrrcwoabKlHe9n//fVgeJMCU8piXVP/7fhWnm9RlzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1AJCJG9xvSEjbNama7f//MbP6gRmmpogpH8xJmU6A/04v+cXk2q9KBptmH3?=
 =?us-ascii?Q?NaJv7jrhSJeW5K+R0Gid14yDK2gyoA7cY5zaR9azDeNOI+DPS9OdyRql3Xa/?=
 =?us-ascii?Q?TN+YbOi2egmycCvw/Edp4qCrE5iFtxhlQxBN1e3egrYo/9gCR5CwC7dXIK9L?=
 =?us-ascii?Q?5rFI+MljaBcFswX1AMgxWNYx9dwkqc0znf++VhFHDNFt3recTZxRVRZ9KzBl?=
 =?us-ascii?Q?s2Q6/S3gIo9EcKhTZwbEJEbCY/sFSzL7CpW4zSmBlrErW/VDsfKDnrlrwZ3d?=
 =?us-ascii?Q?J2meGyAx+cKVTGxnAjELvSvtbN6PPnAR/hliNjx0Z/2Hm8mB1qo/l+rH8TuI?=
 =?us-ascii?Q?pRzbcp/30xbF8hRpEyMAJRbMdtSW89KZscE6G4BOual02nvUjIiQwnj1TNRP?=
 =?us-ascii?Q?eu8Tf/tGJVcGCtxn7C34BjbCtiQmx9LYmFh388otx0wRwxrocpHuAuEtINsV?=
 =?us-ascii?Q?NOVoxsDW4bD0FInUjJavwtW9vkCsZxxFT9VEny6Pfg8wFj80qrMB2rnpnff3?=
 =?us-ascii?Q?w918TPSker+qzoE8swc9jjwLF4pM62jDE58bZHhZeau1TZ/uVnVtHEUNs8dp?=
 =?us-ascii?Q?t1vxT7K46ubtsdE58X6LZMc49UJ2vOtZsKbmXxihZIqPEg13j94CyKdr4uzq?=
 =?us-ascii?Q?VLI5bR6v7JmG3439MqEuRkrpYH/6JW0uXI71fS52xvTCDPHJfVcJ5l5o+wPw?=
 =?us-ascii?Q?uUHkeCqO5nv9YLigFpDVAV0PiBAIPGBd4/BwtanARg++3yd3D40ghyEwE4gb?=
 =?us-ascii?Q?iY5nckPhjzFUB6BZ5v5G/TnzvqQuvv1DbbawZubhyHdiMxRinPdBPIL15Izs?=
 =?us-ascii?Q?BuEguDqz8Gu3OJ1tGqjvBJ3K54A/4XhfQsgqigK7ONSKQSv3Q5+Zk5FL5bn1?=
 =?us-ascii?Q?DlSoiAmljuKzau+PpGct3zLQd4cYgzlFUpPDP0zGxPxYpMHHeWGXwaPXFtgF?=
 =?us-ascii?Q?+tnetWsL0s4TSm3etkQWIonMxsGIkMGTSyN+UQRhijQSRQFMehOYkiTVyvzS?=
 =?us-ascii?Q?/Sm3F0du2YJfHwcTbvjgePQF56Y+gVeQCw//3PjN90eO3xkOkPy0u5V1z4LH?=
 =?us-ascii?Q?+dXBOmmBvO6JaUAp44s1ZXD2Uy9qnAqswN1CfmM58Xk1ttLpHBZGCROQxwLx?=
 =?us-ascii?Q?Dk0P7jlw+9GyqxAfvFzz01zMgG3ZZB0X7w6nD25bA67JhlYM2d7bAFtqtYpn?=
 =?us-ascii?Q?xq110bpZNnvtlsIgot5wAFCPnit+MIfd3Nt71vyGt68D0P4SFS0HIR2exmVr?=
 =?us-ascii?Q?ZC6glYjos2K90423UjddXTJ+hv2QlykfaTnfc/fA8TCBJhSMv9N59BtOqXH2?=
 =?us-ascii?Q?E6s3Zz8olebEjPK8JABFiU6Nnr/Sf5i+zqiFSWtqVb/vWgbJppJd0y9mMaYY?=
 =?us-ascii?Q?onRV+uGeuhgMJx3Exj//MzZprA40t3L5+m6xeEs2/e+LZAXZWMhoNTmvasr5?=
 =?us-ascii?Q?jEEtnBzCkJChikjiW3/qWaArRWyPHhbe11iCIck9FtjffPbeVfFPK49KqxhC?=
 =?us-ascii?Q?mdpEpHDj762PmJIyan9h8hh03p2fuJ286dfsoi3jgs2TTlwEK5FAo20zmNSw?=
 =?us-ascii?Q?1JMSmRa3KMI5BNX31CV2N+jdKVnkxlL9VBcs8QKA40xh0WGSsfIS+fGORmlQ?=
 =?us-ascii?Q?NJti9sVaZ8yHEaCfXKdzPN+n5Zjf2+9rNw8/EZbLY18ND2zhKDiqUANpMw7k?=
 =?us-ascii?Q?aFMJa372MXAAkx4VmdEgmY3JqGhvDfWxydKnYrnEVyOT21u9HRmrTgL+6Sqw?=
 =?us-ascii?Q?Twxv4Cgigw=3D=3D?=
X-Exchange-RoutingPolicyChecked: jAI9jDtAo3uGb51oREZzQESOSV3YM1I7bzEb1OzHXxQXdfDEryQKtgLzYXDa9opnnbz18Rtl5dZQFi0KKrvorRgwtmZ5PZgvzScNu9P0uF5yrPh87rHVb4hxYoiO0bFWVCW6V4ZxjrIQvlw/92XbNs4B1g87e+6CJhtLg48vOqD2iPkkn4kUq5dIaGnqLWylWGX1c9Tq3TNTrVNp9Jkv9uL3/Lg1OydAJtG0BixOuHVbW2odmHGH/Bu4L65Uh8PceSa9Twbxvf7VVmF05WQ8ISCEwoUK3Dov59QcRF4jZom9FP1/iWTWEXvngwJ27etn/oktYYwSbAFa619zHxmOlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3477f351-8464-45c0-c850-08dedbda3379
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:45:35.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v//pfJhKzNIEhbmqTh6PJ0MziZccS1VYwlCD008bK59sVhs2Asi3vN+56ued9JzdVAunrSmf3NHgfji4rx/0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 02:46:16PM +0300, Nikolay Borisov wrote:
> 
> 
> > @@ -1228,6 +1230,86 @@ bool tdx_quote_enabled(void)
> >   }
> >   EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
> > +#define QUOTE_ID_MASK		GENMASK_U64(47, 32)
> > +
> > +static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
> > +			 u64 hpa_list_pa, u64 total_len, u64 *quote_len)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = tdx_tdr_pa(td),
> > +		/* Don't bother specifying the quote id */
> > +		.rdx = QUOTE_ID_MASK & (u64)-1,
> 
> This is simply equal to QUOTE_ID_MASK, so why not create a special value
> meaning "ANY QUOTE" i.e
> 
> #define QUOTE_ID_MASK ....
> #define ANY_QUOTE QUOTE_ID_MASK
> 
> or some such .

I replaced it with just GENMASK_U64(47, 32) in the v2 series and added a
comment explaining it. QUOTE_ID_MASK isn't really needed since we don't
use any other Quote ID for this SEAMCALL. Hope this is clearer:

        struct tdx_module_args args = {
                .rcx = tdx_tdr_pa(td),
                /* [47:32] QUOTE_ID: All-1s selects the default quote format */
                .rdx = GENMASK_U64(47, 32),
                .r8 = in_data_pa,
                .r9 = in_data_len,
                .r10 = hpa_entries_pa,
                .r11 = total_len,
        };


> 
> > +		.r8 = in_data_pa,
> > +		.r9 = in_data_len,
> > +		.r10 = hpa_list_pa,
> > +		.r11 = total_len,
> > +	};
> > +	u64 r;
> > +
> > +	do {
> > +		r = seamcall_ret(TDH_QUOTE_GET, &args);
> > +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> 
> 
> nit: This pattern seems to repeat a lot, might be worth it to consider
> introducing a wrapper similar to existing sc_retry?

I think Yilun gave some reasoning behind this in a separate reply:

https://lore.kernel.org/linux-coco/akaKmEZnTY4FO2gY@yilunxu-OptiPlex-7050/


> > +void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
> > +			 u32 *quote_len)
> > +{
> > +	void *quote_dup = NULL;
> > +	u64 r, out_len;
> > +
> > +	if (!tdx_quote_enabled())
> > +		return NULL;
> > +
> > +	/* TDH.QUOTE.GET expects the input data to fit in a page */
> > +	if (in_data_len > PAGE_SIZE)
> > +		return NULL;
> > +
> > +	mutex_lock(&tdx_quote_lock);
> > +
> > +	/*
> > +	 * Use the first page of the quote buffer for input data. The buffer
> > +	 * must be at least one page in size. @in_data may not be page-aligned,
> > +	 * but TDH.QUOTE.GET expects page-aligned addresses.
> > +	 */
> > +	memcpy(quote_data.buf, in_data, (size_t)in_data_len);
> 
> Perhaps you can use min(PAGE_SIZE, in_data_len) and that way you can
> eliminate the in_data_len check above and copy up-to PAGE_SIZE data, if the
> data is longer - you will copy PAGE_SIZE which will likely result in error
> on generating the quote?

Oh that's an interesting idea. I'm going to change the implementation in
the upcoming v3 series and I'll see if using min() works. Thanks for the
suggestion.

> 
