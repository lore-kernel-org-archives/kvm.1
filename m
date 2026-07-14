Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B6358367;
	Tue, 14 Jul 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008595; cv=fail; b=e5DvJenXXEYQ9gcen+ubJgzDcoOaFt0Kn5rVeTyFNXSvRM0gt3NkrXtG67kUSkAkpZD+kZBeeOvh3VpeobyIn1RE+QeZmd74YKJxF+ZpjAXMhOGoydc2ZPCq3eKCC8LKIk0w0DbdGlKMkn3ki/zvYRwD5L4RshDt1afwBkR8fQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008595; c=relaxed/simple;
	bh=8FP4RtEzIQRD/qFZByGplh+fiVSIreQSPjRGB3IlYpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PiiIp6GvJ4LdKWc1FuL81cwj86hJ3RXAqMAKjVCOeEetMYcmEJwuSKI5go0tEZ0IlDSo3bdN+Kfl3s2aovVJ7zCbywJXl8oS7h2XfhNu/HWE914V1uQoBEhuKhFXG2VhLuca/iIs3W0wR9xLlJvvwHxOXafIYzKpi9sXviiKRnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isJvTT+R; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isJvTT+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784008595; x=1815544595;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8FP4RtEzIQRD/qFZByGplh+fiVSIreQSPjRGB3IlYpQ=;
  b=isJvTT+RyWqdxfzMCnV8MwEIDHxcIKZ19xUKTaQ/fLWsJehFVt8eEFvX
   KKIk4FBXKhnKvXu84onQa0zxLsYFfxo9VZGS8v40AX0417e0MudNYgPD4
   OeChOHUdZDBx9NXFL5x3yf1tFdRqAxfYu9xCg07obwc5DklHS19nCJrQj
   gY+q8v3zmmHIT5UzheB6MLoFDCl7oKCSFFlJ3pIRf0qQo3E0AMdryIMCC
   I//RKnjzlnYc7My8BwmICi23zS7RK/Uk7I0gxk+OwUXUHgN4XJ7/JTHnJ
   5I6P0JyWXaFlvX9zUy/1JgTQhvKK9/mnzF6w2CTAYBALqTXHqFMDBZPIx
   Q==;
X-CSE-ConnectionGUID: 734fDoWTR22bZ5oqZXg3Sw==
X-CSE-MsgGUID: zRRuL56TTh6KdtuSrmHrdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95771004"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95771004"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:56:34 -0700
X-CSE-ConnectionGUID: GlrghFz5S0CiJJ9pT3Ubsg==
X-CSE-MsgGUID: RGKS21sWQZmetxZLSRxQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="259333535"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:56:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 22:56:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 22:56:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 22:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ1w3p6Ja/OiPv1q1zk6efRjCRhGyx4KBCY2JiPQyZHj/GkUQUM7ivN80EDhhC0ulYp/+9T1FNX+rdTomzJbAffCBMtkkXOkDiWAaoR1tBpWXhIuAvr7EaqdTprjh/Mk6cdxw6STMEcA8VN2DiPXHLvT+HJvqexpRC6e3M2s0XBuMxXJLlw5KEMiK6cFkEitOR37aKqdI7W2giw2TEbDwrxNfOEMFItEsC6m2ifqitVCcq17vGNpsw7SBNheSAc4ZLa+FFA6pkrHTjDsVvoqEJIVAn7oCAlj/eQYAg7de/w/RqN1yPZJvfxRWZ0HX9pDUarhG2t/X4KmSoyy9LxQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oiU73yZer7+PIQEVdusA1YnsVde2Y6OG0/+EVrZGWc=;
 b=CAU/LxHxwayPGve9Rll3ReIOoCl8RjO0j01dTyUeA8HNSVliCdTko4yvRnF1LOBrwoDF11x2l0lDqENHLHtpT17q9dbm/y3i7a1MsRGQeIIiztsjZrsWw0hckjztnrbZZLe359V2+7ZcsFnps2pYGkeFvCMfs+l/4p7+0W1tm3JffPRlB6uihFqR7gWPBSPrE92ZPNvuyuxa0QU/rcczfKNIdtz02ezZSnc7zKKcxhSpq9bMMwuKjWkmyFroIK8ICAOgFsu3vOVMjrArsnTTMVuKeq/oeVDu4MMKsmJv2S5g3wGT8MHLpsGMLt/x5Q9ziYsgTefLMscCJc4SaIWY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ5PPF77D28E3C2.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::837) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 05:56:24 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 05:56:24 +0000
Date: Mon, 13 Jul 2026 22:56:23 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <20260714055623.GC3178326@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <680a2be7-5a10-448d-8552-cb9ef64b6be7@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <680a2be7-5a10-448d-8552-cb9ef64b6be7@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ5PPF77D28E3C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 597e3bfd-e74d-4fae-a36e-08dee16ca336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: et9HopNYFi96eh3/45BkGzu3Y6ox4ynhyDk/E9fpyCOOtlUu3/R+j0+aE65y3haFwMWknVEP6mLD56MvUNaXbwVCznGo32aVNaEu5J82QzD5z6dzQQYbcY/0OvJG2t6JMi/oKZIXVDIdEhXOK0oRBi+AtiA405yjV3+Zn/lch/GpiDwUn262e8oHWfw0k61x8H9YtsFPmRC3Kv+TLZtL53MlGi9VEnLk4BBN9wPNvSpDXwD+m9aXqnu8+2g/kIdQcm1AIe6b73T6/sW3beDZaz4qbCmhZWdxWcckxF4en4r3KeouSKW7XumVv23kh3nLndLEYVhjYak3RdW0hg8g/ULWcyyAPgb5ynnp+Fs3x8XKNSzPjhDb16eRICqII0AgSONWG9oVFDpTrRDlqla0mPoV+GxeLkf92ZV0hkxUfr/w9a3vVH9gzCV4CqPIZ5ehpbIY4R9aIVWjY858euHTeZfo0Jdy3L47ZDrhouoHKWp+O8tcuUgtEHy02U191pGKEFmtWLWsZeIiHV9xwndyv3InED9uVh3wycNzIG/8/+eUZknNoukWC0VzUcdU9gYLpCpmzZLumSwMZ9A9dODr+4Q+6MTaloH1ZXd4wIzoSFheThRSY4CjBIEWo1e9rcJg9j6UUB6T+MXvjiShmk8TH7U+0BI6Boyp1NiH3stBfiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2y5yZgFU07pU67vOIp/aDWd/rYPFXPELd2NmUWY+3inHqz2KqZZdLjyOVJg?=
 =?us-ascii?Q?QvEVwA7BlDyqqRIkAzBE6d4t8atC5JfO8ie/JRNjoJLgJ/m0KCgoVKmgE7Ka?=
 =?us-ascii?Q?obfq58TRCahSGg86/Y/M5fIu9nRPLDA5JnBW/CgLqBWkPSFrDY0cvcccvBLZ?=
 =?us-ascii?Q?2YMvwUBgk8rTWKHP8Y1yuWvkGt/REd308NTv5dBY9p1dQtW0RXFAnF39H2V7?=
 =?us-ascii?Q?BLzhO45m2OnyWHE0uso1OAu1VHFXzbRc4spFOm9zCCrdyYI6s8pg0HxlwlPo?=
 =?us-ascii?Q?jLSqw49pEPjl8zuCC0ruTONaez6zaQ200lAQs1AP4sWp+23gCqFon2f936Pl?=
 =?us-ascii?Q?1FzveyWdepISGXReQXyYDhHQSRZUuISa2XFu4H7BUQmbSxG205iqbwL5tKbY?=
 =?us-ascii?Q?FdNdRXhjvSbvDjnmkjYIUFIbzyhf/wNSCieOVF9P95BYJd+J2ydw1zASQLxt?=
 =?us-ascii?Q?krLld1s+12ilqY35Yd2wtkjpM1T6edAW6TXAncICbi9S5KmUwB6qqmI0xULb?=
 =?us-ascii?Q?pGxF4hQDNvYoCxzlfAm0yW8ULlxN0eUwHehEo/71nYWK0NMeNv6Duy4Q6lcE?=
 =?us-ascii?Q?jqwOFnZAUNSsqWHjQube2v1MOzpM7FpMz5KjWKFg6G5Jd8/GPeFX/TUphBVu?=
 =?us-ascii?Q?tdfbU3CmHq4hxct5EOiIEpkpo4eDpnd2H7wHnHgoLmleESXjJo1GH+AaHetT?=
 =?us-ascii?Q?TryJfAVY0iud3BoFk4MCC4BNHEbYQanD/ptxSH/r0JTfvhghSIfPNROOBBCF?=
 =?us-ascii?Q?FNq+dL3yj+KOEaYQJRZz/OXiKC7DOASSK1mI4sx8xk2zhtSAKFMBPeCvvTND?=
 =?us-ascii?Q?POxafAPJTAx0V0HQpngDCEhyoxowH2X3Q9k0zdMLhMfPvUJJozQTDzqYo+nD?=
 =?us-ascii?Q?F63a2WkEvQ3GSKNdOTFVDngtALghCAcXRilDbZ+hudcHhR2MN8nlB37J7WTB?=
 =?us-ascii?Q?QRuVk5TfmgIcE1hQVNIpXxaFCUI9lIurh9/r9sqjd52frYBV2RFReQikta/B?=
 =?us-ascii?Q?LtxOHMqQY8mp69W7m7ogPnNNs32K4SewjxcmBwllG4cImFJZacny8ddk512T?=
 =?us-ascii?Q?FGS4ctd7Wrr4exKfpJtl5+/T2suYRR6yHKSktY68LwTFq30wb4PhfE3HQ6VH?=
 =?us-ascii?Q?P9DodbN5XfVa6v60dqfGNQjo464uwzh7StVy/D/oLWjwyByhO8gZ4ho+SFPf?=
 =?us-ascii?Q?FeW4wu7Bmfggl4qAYDOO5Gexnyumh1jo5Tad6hzhCLq2SiuM3lMTQ/3SdYK+?=
 =?us-ascii?Q?p1sZfMS72v9tWE2uZeWuPsSgR1kb4RX5v6uLPDpHZdaVVgf0o9PUQ0kbL2P5?=
 =?us-ascii?Q?ccQbSI12VDly5ySZWE7oHUW9C0msf92N/cSn9P9EnR9m/xcwRnDAWhSuDoq4?=
 =?us-ascii?Q?7f3HuwCn0aFGpPAkU9QkmmnecKrQOU9R2YMXqp7e4Dn3vorUlQNFQh70qcrq?=
 =?us-ascii?Q?2zATVdSCrLKkd50s2b7BEt5JZQb8v5w7IxRfPIHYYyZvlN3H1R105lAwmmqb?=
 =?us-ascii?Q?oUbwZjJAfIu2mxj4/Auq7bFxKS741P78I6LNH1jZXTZvKo91e3Moi4fk8Mny?=
 =?us-ascii?Q?1i5Ge1ML1mnYi4P/yGVH6rhhl1Q37OqsK1itsdIflqjE+t8qlAQgwxPOo/gO?=
 =?us-ascii?Q?XMZ91El1tw6HQ9LMTds8pYqfi/tRdDorNh0voj2/PNI+odAM58HVqVQKRLP8?=
 =?us-ascii?Q?T2WoSxLQ0broEcPbpRNwr+QQnF/z3o6EKJivICBAbputjWNa2/LiIZYgKuUF?=
 =?us-ascii?Q?r5JlzbAifA=3D=3D?=
X-Exchange-RoutingPolicyChecked: I2uw2acY3P7TxOeQ4YTLtI0ze72owR6hryaYFSJzEU/OIsyONRaopPw2pTMH1tAU209yAH++PmyMmBBkV+t8QfH6bwyQDY111/U5Vjx1Hmq/8ak98kDIJ/kYBEM8L8zZ/53zZeK292fhrYH8UUgpDHbMhnL/RjyKV9Sh5yJT7nSC+bXzLlVyBoq6AQPSwfebIchdXURvCAZY34tHW+vNVytmMleY+DekaQUEJt0PQ+w8W5Aa44i1tnVcqXfShGmlAbdl7W1jeE+IJHw3VPiIBh0G1SkSSbGlzHABz0fQpv0+mTtT4ufvQF9heSGKLY8zTTcPfOm6Jc8NlBx+RsrEIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 597e3bfd-e74d-4fae-a36e-08dee16ca336
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:56:24.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uv0d2dJb3ZYilSEnQnfCtTFIY1pN86LODq/N+ql0zThD0COVlyTlnXCkFZDzsbuKKM/btWG9sTDQQotF9BvCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77D28E3C2
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 09:01:38AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 6/12/2026 4:08 AM, Peter Fang wrote:
> > TDX attestation blob ("TD Quote") sizes can grow with newer
> > cryptographic schemes, so guests can no longer rely on a fixed-size
> > buffer for the Quote.
> > 
> > Newer TDX modules report the maximum TD Quote size via a TD-scope
> > metadata field. Add a helper to query it instead of exposing tdg_vm_rd()
> > directly, as it can read arbitrary metadata fields.
> > 
> > Thanks to Xu Yilun for suggesting this.
> 
> I'm not sure what the original suggestion was. Perhaps a link to the discussion
> (or Xu Yilun's email) would be helpful for context.

It was an internal discussion. I can add that to the changelog.

> 
> > 
> > Assisted-by: Claude:claude-opus-4-7
> > Assisted-by: GitHub Copilot:gpt-5.4
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 

Thanks Sathya!
