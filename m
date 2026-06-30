Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C732B127;
	Tue, 30 Jun 2026 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793338; cv=fail; b=uQrANpoceNX3PsH1b9FVOXe8XtiOu0wGjvjQXN5H/6m++L4HWQw+yt5JgS+iGfFG1Xed/zMbktEHcR8xgY+FvRWxN2WLwfvE2iElgoxI69DTAIDYsmEyM6KC9ifExI+DGeGkFMvpE3dpwjbYHwTPrjVVutTEzqxHCCpHlYgkVs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793338; c=relaxed/simple;
	bh=4fhIzl+0m3HksSzXbhb7q0VfRFzA2SGZ1vwUH4+8/ro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjcG7W8DyN2xoJfPqkCUnSahKI/oSQSACkl9z2A2uK8ShI3ygT+eMCpkje/WBafak9gU7oZ1f4gBjMNSuC/xnQubhqx1Necnq9Pl7b0gdh5gJ6RX+leDjSfOKTHVuMrmOXzwiwNyfvGpO+7NrqevJ4JKN+2lgM+YcJDBd/5uo7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4WUxvIy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4WUxvIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782793336; x=1814329336;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4fhIzl+0m3HksSzXbhb7q0VfRFzA2SGZ1vwUH4+8/ro=;
  b=f4WUxvIyMpuc9KC5tu06pxXKnLDO7gHUE+F+IrqHLOqfk1PJS7lxl8qy
   PkKv/G07frynf/m7kEcF25GF2bvuFlz7VVRiOU/CNwgv6Bo9LffMvAoPq
   XpxAUqrdrhIWBUue5qgjn/Xkc1yHqtYeBSrGT4wogJhAhtXQJ2uK/HtTO
   lEgv35m5vmIb5sKPPB9Na2pOwTu1bU+ougrGUUAq5nAw6Lkkm/gJEh2Aq
   ctZ75DZHhF3/6sIS64OTXXqr4OVjJcbGpyTAbt5Go7BrcgdHoSvnnhS/z
   m9+qJV7ulA5pW41vVIDtWeTEcanjVt+wAHAmWHgzTkB++NxevfLObxfLU
   w==;
X-CSE-ConnectionGUID: lsFdfeJKQH6wZK+S2AWEXg==
X-CSE-MsgGUID: Zand1V6FRB2mXDvHd3GlMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="95005486"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="95005486"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 21:22:16 -0700
X-CSE-ConnectionGUID: XOOXmMNTQC6XexuFf2qEPw==
X-CSE-MsgGUID: tJZyAZTCS8ukEpwLw0ZPtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251092670"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 21:22:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 21:22:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 21:22:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 21:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4xSzVJzx0GqsDq1YopLB3xRB4cnwyFTanECybYF/n88xhajIdL/ETHqpOOWSjlL/ptTxNmwuGYbtvQ7GicFKIjifXnf+6yuuL0h9jeRgPgmfAym7jYnV1eiAlFouxF1d1PRJt1O53rv7zWxvIEipQyh/t0iKe+JDNksReLZyW2TnFr7HCTEqN4vO2JR1aFwncVW1WdomzYzI5nkHB0H8qEe5F3w5t6Axdvl71silbVG0e6gmNULnp8ytvqRjuINbaE+N1Tq25lD0IOsK16gtzL6S/Ygnv7Bi7DQsqr9/8sGVYAZ6L5TH9F0Hiu1RcT+87nUZnRgRmquj2dFLyaiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHgYZb/5i7liWibEHYFQI0cKyLwQ/CLix5B6hU3rTmY=;
 b=Hgeb324eFXt+qXQgbpskFMFkc/dzayRvKX6Xm1bEfo6+icd1jUpY9RzW5A/8/b97T9JLjtK69RmhYzRbLJpjVZ10AKx+JCLGByFQJNEEIwY9MfE1gNk/LG0bGYlb0ptoW9hKq16txEEZFM7ob+BkKNrpL5Hno+bq28LsJ3QbaAQLVT0A6ODQAezl8aDKXFy9YDTaWKftAupGDM0w82QV4xx+JhB/2OZ2BCeW41cmSI0W9UG6Zk0SVknxpBXAIGl4zoIyTzgwjbuV28y7MZIlc2c5jEaDhE9Anx2gXSRmWzFXOC5LcPrOhOohG92aqIhY29QFrcuzVS7LtkPrfBwzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:22:10 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:22:09 +0000
Date: Mon, 29 Jun 2026 21:22:08 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 11/17] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260630042208.GC1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-12-yilun.xu@linux.intel.com>
 <ajzFKBZWpbwefE03@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajzFKBZWpbwefE03@tlindgre-MOBL1>
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH7PR11MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 431b7d4a-3386-431d-2563-08ded65f26f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|3023799007|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OjLeBQrEOtoTlzKXw8yRdNYDpJJyfxu0o0HPLMfEM/TUW4H0d00juUxQx+B3R3Nb1G3WYr7fuFHxkfn4gplYC+khNO06hrQIgpnCaSsOsVFvud9RAiQNXkrAXfIBG3gacsbIyeoatIHXatoSgkpPBNH43zHBI+EZyIQJbJ3Wcegy6Iyl1PLH+vfRao603Dq+3ioBHtoxjQ2RO1NViEVUgOu1zbcvILhkj64xriFy19A4LuvL7S2JlNMZoRTu6cioZ4FYRgXgvlVZPAft0cxeRFyxDjN7lG3Asy8Ofx5LajwlaFORZVsQWu59bO9ZC/GB1VjVsXb50/fGurQWHmnQ9SqEsKrvUn7dUqksIZzn3shwGNCzFRhr6o7KuJ/8ESS3ISj2RZjy1aAcWPFrf1pgrDYUatY251zfXmH9UHtNGDGtBBwkKlBqh2YBJ9AcupE9wBlJyKcO7QtfVPGFCNlMtQrZ0EJ5ahe/05n6n9sLjlbTCa0O92zeBOPdtZAXRbvszQ0fqMMdtT7IjwRUix8TfFsl/XXPvxWhBOqh1hd2qix/n9oZ8twW7D1Br2gyCdkOPQ+QuwuFZeOkwLAK3M3k6vB9jMggVnnVPjbicf9sqeyKFTdtbK3/mIqbSfwWEB8ljxOghsc58j+xQKdsE+fQAFTz2ymAmBn+F7b2gt3p7uY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mElrxWGzXO72vg2TnmpIzmnEuwwTADiCtNT/QUh9teKGCv61W2HhfyOsERVt?=
 =?us-ascii?Q?WA+NWMbpXMbCTTsMUQmncDNXTpKhMa1bqBSHOiBMcOAAkoGSVccqDWL904nh?=
 =?us-ascii?Q?mmYuEVazN3nA0yNE+i03ocZsGTcHJCim/qdIiHpxr70qNKtgTLLL8WyBXWF6?=
 =?us-ascii?Q?lVRhDd2GJ95oZCozId7UoQhiAA80w6S4f92y17A3Wv0quiKdGPiUDy9TcRGz?=
 =?us-ascii?Q?+y9UHKjun+zXXDcMB9Y7wOQic9yORrAregutl1guTfPJGScrtuM3nh2TxUBl?=
 =?us-ascii?Q?MaCDyXdvt/NTJtwIPVWs4yYTtUmcY3SEcsXutx0mjtn/EBvmHHEhfOeDU1Wk?=
 =?us-ascii?Q?H3gL6Xfhu0BKF4Uesb3ljrYIYNkPeJAZIQFEUoPVuJczrUZoodyXENz2cAVV?=
 =?us-ascii?Q?6+oY450PNeRMKlqaF0tc4RElavsnKlIo4aemjPsIbrxNOPhkWuJDeFIusv4K?=
 =?us-ascii?Q?d96BIz5DCs3ftAsr/2NXM5fSvnyiMhK1evzMYlYeiGbbSD1sO6M4mh4c+kFX?=
 =?us-ascii?Q?JvCglIzxdpgZjnbOopuri2kv8Z7eNx5oFCWZpCDSUx7XfM0OvD14IUpuW5Wb?=
 =?us-ascii?Q?nVbpv7UOmmkwYybuLe2fa9YDuWMvbS5nZMJ5tRhmhBBI5C0A3iN4rpgKZE5E?=
 =?us-ascii?Q?WIgifNcqsGM2UzKTnH0ZPjjA4vqJmGeKGi6F/r/ty+lYLUL7owQUXGm9ZYqH?=
 =?us-ascii?Q?kFZjDxrH4+n8LXdtCCFY/N1DxC3uyTidQVNgME1pplYgeSqoriWpVfZDoLPN?=
 =?us-ascii?Q?3dxrVsQnJzRjlxFsyR6VW9Eap0mJMdZ4wrRyf505FEKuq2agbPIYtdBoDS0v?=
 =?us-ascii?Q?Epm3IBAq1/byhsw0RopbNshcy13JijbhUO/C9m+WJHxZC0EsPBMwPTO7xkDb?=
 =?us-ascii?Q?vYn5FfzHwv9Y0eAtI1Rz70pbZskfUBZ+X0jn02ryF1qmpQ+sCTZUuHssULNY?=
 =?us-ascii?Q?NtrxbU1jMzUhq+5p8fenHqV7WkaubmXoOcJXThKLfBku+HU1uxYLJmegK8GO?=
 =?us-ascii?Q?cxNDDSoF+8pocUqxiJGA+LbSVqUFhbk5qXCIZz29ubMXNIGKd2c19vsjNUk5?=
 =?us-ascii?Q?bBzYhsnZwbZFBalXKukuSmEUsq3cIZiYhgSPUty6ZG+ioW2gPfezR0nTZezk?=
 =?us-ascii?Q?dmVCqxCxZi43KG6cbR4DoGevh+/RLQU2vIC+hfg3tnTr+UTlO33vM9UPgEwh?=
 =?us-ascii?Q?UGzsFxkcNd6Gwe7xei78RWofSdKGB2XsNtdcGL7eunZ5N3pnIc5aW+2lep9D?=
 =?us-ascii?Q?/1TmhgxS3LvjVZHj5GhaMVjAyHq75JZ9U0NsKuZaELeTvYgP3/C4tFU1mTkT?=
 =?us-ascii?Q?2qSGfEEu6wfXCdnRWz4qbYqxFXXUT9phlLfDEVLLk+oeytmhUiBKuZlqKCHu?=
 =?us-ascii?Q?92LcQAaOOswyHiXKdh1cZSMFkz9pDdBtVCMAeFBpCEP4WqtpInD9UKu3ihOZ?=
 =?us-ascii?Q?qS157GxWi89gn233QXaK+vSYSm68HpoZTEZvsxHHKyujsww5FZrkNxeg793o?=
 =?us-ascii?Q?b7DCNiYpYyy/atcKSxR46M7ovpZdvTiBQTsJDYAM1mQyYh1FKc/o3MoCWqmy?=
 =?us-ascii?Q?Ac4NEslwlsP33QO/Nl9s9n5yLqP8X4eu57+82tDKYN3XERCaDapkSYMCJmmE?=
 =?us-ascii?Q?pi/S2M5Yw59emJuGrYXue7pdOxu8Tot4G3H0DAlO2V+uBWnObVpNywIrxLn8?=
 =?us-ascii?Q?ljlypExrga4QbUOaZhb+Zf6X05D9oLJb3bB89GBXp8Tq0C+HtAmwBpdy4gQ9?=
 =?us-ascii?Q?2sxnOLuyAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Zu2dxNpMjdqmpjMjUnnCdjpr5ob6HHIq3trvPlAX5/kgzy3LG+D3oCIJGpjW/GjgqN7bE3echDG4NhoGa3vyiwHuIDZAOfgJh14JJuKdHwPSER6EAIeE194cUhkLDisSghNWWyV4wsusP2zyigfjvTAyxkWKipoP83qLYwpimXRdJT8y14nicqx3ySTYLTCG0QEBxgs4MUjvD+kKEbB2BvFvti9qDqdPrR5+4n/9vKmK8/GF1glT2L1FTtPaA5IcFYIRJebWy05iMWO1Vpql/EqWfi8uDHgWd905U895MsOzh+eB0R5K+I1tCx8CJOGAehLL/jbdOGDPIDhgaFxuZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 431b7d4a-3386-431d-2563-08ded65f26f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:22:09.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVblWo5af1nZta2qTORzWar7WfFS/SRCWnheWABk/58BOcOjFqLA15ytANgDB+4Rp9QfML8FD92CXEC0VFBOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 09:05:28AM +0300, Tony Lindgren wrote:
> On Thu, Jun 18, 2026 at 04:13:49PM +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> ...
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
> How about make the pre-generated static tdx_quote a template page that only
> gets read and copied to an allocated bufer here?
> 
> If the tdx_quote template is only read for copying here, seems you're not
> going to need the mutex at all? That is assuming tdx_quote template does
> not change after init.

Hm, actually tdx_quote is an output buffer as well (in the form of a
head pointer: qdata->hpa_entries_pa). Maybe this code needs better
commenting...
