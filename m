Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5138330E;
	Thu,  8 Oct 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424423; cv=fail; b=EueiY3M7UJ4oTMPnpdd2A19RpCv5dTkdSNn71YH2lTfXdzuxZBKqQD99gRbj6pC+1m3JgeGx7xW7Wus8GOXcX67+HbyC2Zla5P0bFjTS2H+C8UzvlbpLSK3M2v7hhoqITG3enIm6GpQKXHT1QDOHWB+ze8W+OHx94ySLGfoF5jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424423; c=relaxed/simple;
	bh=2BGawjiLLISj5cmyxYQLKfpP3SeTj6M8vjyKwDWod7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGPw5WjxCgdtRTEAOajUwwjTLHoFKlSY38feu1NJ3oqPsllgmI1Tv0qXMbohTzBF1o/BM23LzclIzAlVTeCYF43QwGDSJWwdMmcZQdhiDLAYzwNi7mik/ARrg/Zh2V++Dv/HK/4YKaahzm7f6uK0J5HPDzqe4/reXOuNfZvQUEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4DuBpq2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4DuBpq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791424421; x=1822960421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2BGawjiLLISj5cmyxYQLKfpP3SeTj6M8vjyKwDWod7Q=;
  b=M4DuBpq2cez65NOPOvDGLijCt9k9aOscaxk72OYSNmRi8T+z4k/HKoaH
   e/jxyED43F/KKTUXvBoLNN1/sd0MQn+dTq7Tht/hmVE4uvhax2ptwWBi7
   EjMMxvQ5S9BVIEoehu3wDGBdPBsiyZ93thhyYBq4JdYXeuCt1mS3NEYGz
   3JI8SyrRxNitDjY3w+fveckB+8M1B9m4z1fb4Qg7a4dQBVORfZls16dHh
   nb4dpZSgSv+/qR+BpvHAfLLFoGGirsgczAxpaXpAM30guILQitX6gQX6l
   w1KaFJLEEvfXt9TIiw0uzwZ7Oew8U1w3uHtrYdGSibStDI0WLFoYF77uk
   w==;
X-CSE-ConnectionGUID: 0V3Lg0ySRI+goUyq8bt+/g==
X-CSE-MsgGUID: ty358zoVSxSMUDTYRAqP7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="199898"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="199898"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:53:40 -0700
X-CSE-ConnectionGUID: F2Qeb9S4TtOZpwepUr2cAw==
X-CSE-MsgGUID: vPN0T51+SjiYDDKF7nN6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="205464"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:53:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:53:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 18:53:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 18:53:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMR7p5yzW3sp7zvmH1VmIDGQY4pEbFdo65dq5OOSW9/9YrlQ8iMJKtswitFNBocv54njTYAE40kvGsvoFU649W6oDC+NxpvX3S66pS1D9/Kg0bnxofPNvcP5CrjH4GznXVFnptt9yO/XhDnqWtUUbRjGNg2VfJ3RLZUcIrB/SWEBDoQukia+w5RX/M1YcRYxMnaRATQ31ucmy/X14h/FpX1tbkqVxxP/MJ/1tiF11+GeTCex4vrPl4NJDpCB6lRcUxj5BwcvP3Z8G08+m5gPqfsABA/fo0U/voyYyIxW4QGqwDIF5iVdx+1wL8cksDXNm0gYxBLD12SA//G+7rVlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpadpzY8PeHEb1D5Op9ceR7DPlRpRcSmLmw5/TY4oOY=;
 b=sVWeiUUXDYyRf6J1JKC79FlKkc8DlxvK946wrZgMnl4g1A4C7BudnDT75Fqam1EG/y3/Z9HZh4fm7Xrj1GoWbLOkP4K7dU8zhfUJRQk+cZfGenDsXBo56r9vBJQkLg68tbT9XUF1jUHaTUZrPPJ61DzBUbcW5uWEbQ1u25l2fTzLNjKg6WjsSFhsREvlmEOhZp4QcTe9KWMr8RLStkh2UyQSWHnaspUr9dD6+f/id/QwprHlBDXvhBuAS3m2b0Ftjy2uX57uJVMG5L1JgaJ0cniwd6r8SGngsp8Bg7cJX9Z/l9lzrZGAsojIh6jK4Y79EhfBatXoqNhWAfAhevWM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV3PR11MB8553.namprd11.prod.outlook.com (2603:10b6:408:1b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 01:53:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 01:53:19 +0000
Date: Wed, 7 Oct 2026 18:53:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: use assign_bit() where applicable
Message-ID: <asb3hGpSWVQk93cX@aschofie-mobl2.lan>
References: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
 <arsNUfVv0NhKZ6zT@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arsNUfVv0NhKZ6zT@google.com>
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV3PR11MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: d8be2c7c-a67c-4a5e-55d0-08df24deed52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0pumXAjz2N7gHAKS+LRsLFhykqmoR5ruI6f71cozH8SP75ojri3l0ku25rclDWnfQaXznIbDy3BE2Agx2PhBw0L74qCSOT4BHFbk0QfcKJ4P1eg6pcD84tjSaefO/iz5eW3mcjnFv0T+OqUuZaJ1mXd+u+86gmxrLA6xnJfY53AbOOodP/mmhxrBGv27ox1wyxTNUlhmB3aoBWhNYxU2k4yfPeAD6aUeauKbgwCf3U9LeIuiNKxdWXuD6DuZzWZ7OEM6JTGv9TRaiToyHwtw4/nHGef0EfloRSUi5fcuuVC+VvErUhq3iby6NHkM5mJAnMTS6rWlv0kIDrld98w1sYx1pMRexG+eZyYlTxJw1xHrv5LPP35I/MZO5DRmjYAMvk4KA8H5UnlAxCZvziemx8BTzXDnDJYHQhzeJGxWaD1IhwRmoRhINiy+7RfNwuRIgVNBe+ymHNcZ0eFSI+XF/pwYVL4cC3jKeotcc60Jqz+zw8BCPcwVmzDdjh8eDG2XFwLjn2WlcxqFtsBu5se9+uGdOLLeWoDEQHCKevcUlo+lfdB9DQYj5n4HfdHlI2WNQkHy4NKslzB1Ss1m9xmZBuv6FqkdlaFbOFv9TXbVRe5YqfVzjdtuN+iI5rL+RwKfz5+5hKE/0sX98Etdx4AHajeszHd4AJgBVxqeYHMCEuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqr3m/4NjtpJtFSS9dRF0NbInC8hoUxDIzO1TX+SQdalom1k4DsvIPkZyNJh?=
 =?us-ascii?Q?QV6Y5rLqPg/ZTIEYYPSTRZ9DuGpM7JtCfOnJkaIG7QE+AAWUZYzs8StGEl7C?=
 =?us-ascii?Q?BskPS6qXJ9tKBYOL0iDmQQANumdUoJGCYo0cRnhZzCH+zPM4Z0HZJuhKHbPE?=
 =?us-ascii?Q?kO2w6UIW0RXFIrVmn8oyVUn28dC+AmWrx+YxviFiYBrnlAFqJJsorCOg2DKX?=
 =?us-ascii?Q?HBpXXVjjfJMrtSIOmog8s06vLQdHyZqITNAYyVxJiraEea6reG7Gb/Pc5KMi?=
 =?us-ascii?Q?sO/Z6v2VFV2Xk2iqdpirPAwj/yv+43OXMY/iAlk8hFU5tZ1IXRZCOquPsiUN?=
 =?us-ascii?Q?OeVYU7yYLmwy+W4BLnrguf7SWczSda3mwPSncPF+sMvrF8V+Z70ojmQ4v5m9?=
 =?us-ascii?Q?V2SxMKioNox7D2YggWqM6BIb+8JBFhQ+03TLozezm7c3ftUubkmUHaPzWFcV?=
 =?us-ascii?Q?uNWGcWdHdboayyP5Qg0EHYg3HH+OgpV0lbb2lgtNa8FEr3grZ+DTXZaPoHEr?=
 =?us-ascii?Q?Jh1rxY1m3GodrC6pk7cxfLsPXhvNO1UOPjvrSlV7cSknl9FYhMQCYoUY/IY8?=
 =?us-ascii?Q?4SWPaBEirfmbVGLTpoSNrO5Dk6MriooycMc6XWrWB9KrF4j2xwczDNEZ2PXl?=
 =?us-ascii?Q?1ZdYbL5gq245EukiFZ3JlP/Wk7Bda3qrMh9F6Q/R+WMZTSzeKjQ1Z57kycSt?=
 =?us-ascii?Q?kTc5WOstNIG/lPppRaZpn2jUdYNef8X4PvdMk6qdma2m944HIAqtSoSIjy8v?=
 =?us-ascii?Q?8Q3L8rfyC6fcOLnAQDvIPfQVv+GPBIf+exsClyU5vJiKtD+oacEvcqOdQfMT?=
 =?us-ascii?Q?Jv8wAZxU+fJlXN3xvWmOvF1ETzHXne8+QTTU26DJNnM6dzQMiJQlf0giiLOK?=
 =?us-ascii?Q?JDCEEhqywfnCMevFXoEVkYg/qG5OGp6iZShOdLItqeCuAa+Xw+fQLLHoIsQs?=
 =?us-ascii?Q?M8SlPtFFkNnpDf+gftllRVljUu5cJOUOsVCjTgVH0hIShW9UiMWAfHa9BnVH?=
 =?us-ascii?Q?1rA3IgdFndzuPkS7j3kMUyx2z3taUhY6H7YmnMv1mxotif4dVTWU3pQAkYRW?=
 =?us-ascii?Q?uRbKeblA+pgJ75sIz7gGZLyXtLE/mlL1ZHdK+np/TpOGchl2xIe2cvqUFExt?=
 =?us-ascii?Q?KkJgFSF2nfGrzPYavnyw/A+ikWVDhUsQOW62hysw0la42uNwkBrD+m0CAfdW?=
 =?us-ascii?Q?DEBAU/IgvnGYc+wJ1acDKwag+HTU9YaEAaZU3eNAjhiZ5/vjBvITgMOVKuJp?=
 =?us-ascii?Q?7JMzAL0i6thRwArb0kjsg6aHaPPEjzgtKstxQRk6WJC1ea+zv9/VuZWz1sAt?=
 =?us-ascii?Q?Mft0+RhYM0pZYscjuhFJhqLhMsKWCV0RWhuqN5Uu2wSRA56UNT1VUYEX43GV?=
 =?us-ascii?Q?uFtJ8Kz4ivFOCQ/5oLmFRIDz6/SQOF13KgGv1RxynolOFhBxj2/sxO18KqAH?=
 =?us-ascii?Q?mikrfCvdbKikwZHZ4/idzAYkteVnomW1Z5pqgNKTNhC0V/nj9Jmpt4vKMjum?=
 =?us-ascii?Q?CIVLuIXFE4GwiyPADTcNIsDWi5cw2sptJDfeGiZTxlCUlSLoht5RoQdX1eH8?=
 =?us-ascii?Q?+qqCc4eeGkKGPzGpAnRtiA5yc2+47euJ11maKg92DhDPAA+Hu1teS1t6XyvS?=
 =?us-ascii?Q?k8VFWAUnLSXmdF1XwhFK2dem3VSeOOYSnd8Qth835rJoxivGURtbh25kKCVH?=
 =?us-ascii?Q?SIvC4DJVZ7FGnSdYUMHzHtKcb1dkUknwMbK7CbYMDKZkg0bFqUVsC2LnF/ig?=
 =?us-ascii?Q?YI5678/RtOzLV3Ip8MZotZnS4VBTkSI=3D?=
X-Exchange-RoutingPolicyChecked: dBkJ+WfR8Bvzd8e9wntVGetjJitY3O1Cqhl8rgkb1h2ew3IvbwF6ev0qV1R5AoeQ3vDxrpU/Tt/WGokDgFyVY1vbzOGCF606fAn9ZV4ahyEMJzysbCnluCGtmn0Ul5HGWpnK3YQ4l69iG55PDBF2ZdBpNTZiLcAnQYOi1sgtRdUeZ4ZNwbMcnlQi8amJsaAc/GLyLs2c28OFrxzXPucy7OXsh6II8ZxeYODBkfpbKLCjMTk0+f392YnneAPty/aTfUg0yXt/LBoSKlHoGQhNFS5OQmy2kSnAa4eeKDCX0d0ixpDYbKFe2QteWcRKR7fXnBCMq0F56tRA6K9UBK7KMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be2c7c-a67c-4a5e-55d0-08df24deed52
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 01:53:19.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: digpAyVB0dlMZCtbKOhISUaMe4Kuo5QLR00bNRnXbDM+zUzy0fOXzrRfLW6AfDdQsBtw6eOYa+UPLp9PdfW7i+ow4elZXAT5BCH7yRmbmB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8553
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 05:58:57PM -0700, Sean Christopherson wrote:
> On Sun, Sep 20, 2026, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Convert open-coded if/else with set_bit/clear_bit and their
> > non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> > API.
> 
> ...
> 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/x86/kvm/hyperv.c  | 12 ++++--------
> >  arch/x86/kvm/svm/pmu.c |  6 ++----
> >  arch/x86/kvm/x86.c     | 11 +++--------
> >  3 files changed, 9 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 8d2669d8ef34..c131d9a3c550 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -114,17 +114,13 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> >  	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> >  		return;
> >  
> > -	if (synic_has_vector_connected(synic, vector))
> > -		__set_bit(vector, synic->vec_bitmap);
> > -	else
> > -		__clear_bit(vector, synic->vec_bitmap);
> > +	__assign_bit(vector, synic->vec_bitmap,
> > +		     synic_has_vector_connected(synic, vector));
> >  
> >  	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> >  
> > -	if (synic_has_vector_auto_eoi(synic, vector))
> > -		__set_bit(vector, synic->auto_eoi_bitmap);
> > -	else
> > -		__clear_bit(vector, synic->auto_eoi_bitmap);
> > +	__assign_bit(vector, synic->auto_eoi_bitmap,
> > +		     synic_has_vector_auto_eoi(synic, vector));
> 
> Am I the only one that finds the assign_bit() code signficantly harder to follow?
> Maybe it's just that I haven't seen assign_bit() much, but I've come back to this
> patch several times, and I've had the same reaction every time.  IMO, this is a
> solution looking for a problem.


A place for me to pile on, hopefully constructively. :)

I looked at the DAX patch doing same initially and set it aside. After a few
review tags came in, I took a closer look and decided to NAK it.

A few things contributed to that decision.

These patches were sent individually, all with "where applicable" in the subject,
but without explaining why the conversion was appropriate in each case. That leaves
reviewers to establish the justification for the change, rather than evaluate the
justification provided by the author.

I would have preferred to see these as a series, so reviewers could see the scope of
the proposed conversions and discuss the approach as a whole.

Looking through the history of assign_bit(), I found that it was introduced for a
specific use case, then later moved into bitops.h when someone else had a need for it.
I didn't find any indication that the existing if/else pattern was considered
problematic or that there was an intent to replace it more broadly.

In the DAX case, the conversion /drivers/dax/super.c` didn't appear to simplify the code
or make the intent any clearer.

I'm not opposed to using `assign_bit()` where it improves the code, but I don't think the
existence of a helper is, by itself, sufficient justification for converting existing code.
I'd rather see these conversions motivated by a concrete improvement than by the
opportunity to replace an open-coded pattern.

-- Alison

