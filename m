Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280035DA77;
	Wed,  1 Jul 2026 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884264; cv=fail; b=hqEVDREqThUSU+R+0zprFi22+eop98ElMjI9h8l2MvTkub0iGuS1BcL9RzcB6jeC23+7d1XNEzhf4GxZ/HGFydm7PHiSlQdVZoglrvHtiScBhUQfyngTW9UUfXGBFCWZintcmKxRLaqDUvPqRsnMaVI50pV3SB6ehMA+mTSzXBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884264; c=relaxed/simple;
	bh=0KNHwoj7DbnVR5JqH2oIL7C7VJSF9VamTSFh1L3biDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYmCwpUE0XSUIcCpyRmP6rFUWLwR/0HRDuqtK3Zq0WCbFG/ZCueO0uab0zXoOGWvPodJwHzjyi9GQGdSvEvm2f5TEArmHekB5zkZJ2R59H7sKXbLI1f0SC6O/m+n96fB+1ZYBKLSvGUFaL6Kf/eMU4WT5qN+me+M+f99uIG5wA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6JSCdCL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6JSCdCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782884263; x=1814420263;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0KNHwoj7DbnVR5JqH2oIL7C7VJSF9VamTSFh1L3biDY=;
  b=S6JSCdCLMR+MtAp+tvt0o5KpbyDjx2n2J843y0UEeDN0MIyK7IG3IulO
   /dAwzXXjzE4T9Ec6G3+9T78CabAINhi55seCLlSm6J8TFhYf0qGgt6a2Z
   nq6ChaIsPOz6u0kXQs/YbD7/EV1CEP44Z3zmEcbMi79S6XfDAVuVOQ+XI
   QI7ODYNsWamamh+R9B6h8DPNzkIaFF58YKgDts7eTGBAOTQcRnrsjnMWS
   ZeTgkO7W5zyYzdbsul+TikpTBRL4qGouGV9wNvcfr7vNMJfjgtxA8d07g
   icOfiHFqfhl0qrCCCWE6La7yXJeFyDfi7ibyCzwU51GSFn1pEP1LZTCkG
   A==;
X-CSE-ConnectionGUID: hI/RPIzLQuS2q5ch490weg==
X-CSE-MsgGUID: j5xa2cZJSDuSVe0p2qeD7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87440446"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="87440446"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 22:37:42 -0700
X-CSE-ConnectionGUID: mR1EAXhsRGy7aIqE7OeHEQ==
X-CSE-MsgGUID: Mp9G7KFMQCCLQt0+6acP6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="282528555"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 22:37:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 22:37:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 22:37:41 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 22:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D60LdlRoVenvGP4ZsMhixPbnQDAa1NqWO+648CapqSCJOWNtfH2wmrOB2TdS9Xcq0BYknNG3aiBd8SplQJaeOiQY50OkgblyiWAZV0BIA+k0csKfXgkSpKgcAeyj3x/U8m7gJU1cN7/meaJI9jmFXRbthBMI+8PB9lcnk771S3SPIjd6EJL7uwEaZotpW8CXuRBZWgegUNbuopNxmtZsI6fM/u6WfCDqlNepE+gPP5MEED/A5SXjgae2hMbd4hOarMNmLI4yHhlh+SWrXailNfRKod6EVrGFxpjJrk3N9PrF19gx1i35T65jvZwu9XWMsx+orEzQ1tAb8MtLU5Jong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=recBmhl2hh7JPrs76CBKBs0nIBb7/gHoiZqz+wg8Kms=;
 b=Y91eQfR/78OJxKT8OhdqansbtvWqaoTlUiwWLVTMbl2i8zZ4R/rwa2q2L+1Ld/5WyIigW+/6+eMyQzko7msFnIv459ROU2dqHedgx3LXaNYdGZUNvNyjm0Qel07EHhj7W3v0dqRNeFi57i1H9Vq2NGeoN/uDmK7QzeKjTkgZK41qDcb4Mnt9zIeYGDmAP1MEbBW5HCGh16ZzC/HT8pNVBiHBObKj3BCO8/Ef0hA0fwNOCeh7rThWeNGS9qGDUN5zBs5th1koVSo2nHUMW3QzMaZjSi/NGgqhDlLNQ3CxYXx7rq0yMFF7c5IaAkIN10Y2Gr6d/8dZ7lKkFeuJ7+Zcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by IA4PR11MB8943.namprd11.prod.outlook.com (2603:10b6:208:569::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 05:37:32 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 05:37:26 +0000
Date: Wed, 1 Jul 2026 13:37:23 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Gao,
 Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <akSnk+cZ+/gN9WYc@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
 <aiGq7XjmMrsqdBY5@thinkstation>
 <aiJhScChLZkH44eB@intel.com>
 <aiK1_q8beMcIEiwO@thinkstation>
 <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
 <aiaQaCzL8o2yLu/2@yzhao56-desk.sh.intel.com>
 <173092378dcc803463b8d2af9f6f3ab6a908f77b.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173092378dcc803463b8d2af9f6f3ab6a908f77b.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0054.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::6)
 To DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7457:EE_|IA4PR11MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: efebb5ce-67dd-45cc-f0e2-08ded732d531
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|22082099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: jlskwydxvWqMZ+XT0TC6nOFl2xyiXTo7A3vwQIVoaCseSfmS322ddzbEAH1/Qo0cZLHw6wfzuIZdRYmU68JQcvUqhT23cT0I9btAMVWGBEy0H4wpxMPVAAnOox71ansv+OV00qsvULSS0AYCXwSXuFbiYns8/KqpuWZx0qzXFcC0jK9AxTu4Ra+tF+4DbEfhq9mI3lNxY4Y4SrE7nyWTwKutcXcdseoyjEcCaWJvWnrSSjWPkjsyZX0Gm0XS/T1QQuIvi0fcR/ymsnch2pWO5EplwKuhKAjMFszfDVxxjxtjUm9+VBVVsOjziL7fGRLn3Fqh7FmggN7uNbpESFEOF3lYahNSMA97ytCkSByKpHjDiyeGQANhgJ48IqY+NZwGa5kzk2GdbcIs8e726cIiprt/0j0exXh97SPDfzJc2VSIYK/FzsGKeu9XVlfedn2uZZ+nSPPp0dcdZOPmb+GRrE5nOvT88FzfHRqvJlYhXL33I+bkbSuSfdyjkj279I6zMfarmtvUU7KFRMq7xXSKQ4DqDf8jlXafs5luYlZNkzB1fDyg+vbwnYDk1MuDo3pTkycHeoMAH94ZNwsBH61XD1p28ScQtN49S1xJw3wvSyI7IjG9Q9D9Xe9wcvjV4j4121vUBNE3ytRuD8YtgF2Hz2ZK5/67lSR557SiZnBPrPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(22082099003)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0hNGECzGM3z7cJLvz9vGXVWil/J7MkjtBfooAwmB2H/bDDRdya2o0BrnQd?=
 =?iso-8859-1?Q?s3nFPT/mIq/knzZiE6N6tpZoTKtHC0aMk+9V9DNiHq3uQQI/f3/kdhRnFc?=
 =?iso-8859-1?Q?DVa/MopnGXlyiRvHKz13xvx/pX7BLutHAvU8gE4gGZ+sJD0dXmsszXwwIw?=
 =?iso-8859-1?Q?jeSU6gI57dVgkQqeVL3UhP33WlXivLrKbXlFaHVvSwEOvbPfYh50FGah3q?=
 =?iso-8859-1?Q?tzYx5aaVc9H17QSWQ0Hd1F3FZucZGNeo1Kf1GJ0SkgyyQcf8xsU9A0iq0v?=
 =?iso-8859-1?Q?qZ3axzMnF7lEGeBJfxqk9J4EmIeUIWgpOotVcPM1BIxt8YkaPAoH9+aaA/?=
 =?iso-8859-1?Q?Pu8s/6JSowB9nSWCGCqO/JN+69uU8MQKbabrmlKGTaIjugfQBNCVUhFUZc?=
 =?iso-8859-1?Q?Pp2SbY78JgW/0CTx52HF7pNsYc3QX6nj/HMduPRxkaxwjBm2MU7ThZVUQj?=
 =?iso-8859-1?Q?iTFcBFUoFsbOuXSSRXLAWvZ0C8gbO5mQVZOKMxwrjfyoUXn9YobyBM1nGT?=
 =?iso-8859-1?Q?HNa0c8bsOyOh2TBEe+tROsEX1++OiSP+hN2O55N1QKwkxXd/h+O6jmMs2m?=
 =?iso-8859-1?Q?JhX5DqDE9cJPFunxIo8FMjqSq3TJ56/OUFk69EmrR3TH6x/W5B0bju19ws?=
 =?iso-8859-1?Q?poTGPRSrZw6A/R4rkg7hVLI4vTtxvXam+LGpIocexfhwTaN5qkEymsaB8U?=
 =?iso-8859-1?Q?Yhn2v5J0sleFGiOrKWv5WCiwECWzgY7bJQrHnDSeEVYn4bwCcWS7593rZi?=
 =?iso-8859-1?Q?syJ8XRp0INK+yUsLqMuhdTws1PnwErgynsdyUDhjLA4y/LXQXTzgHWHlHW?=
 =?iso-8859-1?Q?dLlsKjLqo2mfQ+fDHNVg2fCJCdv3SkEbyM5pWE7bNtOtjXJKV8H/wZMaDk?=
 =?iso-8859-1?Q?T42V4tNtVS68bsYEzNYAzkjtB6HWWDrguDJ9d1ye1mpqb5re2Wd+HgjFF2?=
 =?iso-8859-1?Q?d1HWyNME1FBzmVDqYpwyK3qQ8u3PM34BtgqAv+2OAaCr/ocgsBQ3HMe/et?=
 =?iso-8859-1?Q?W+FHkGei/cAVBlodQslPB4SqmAie4noxhpSvqt/8GvNFF2LunbYy69SJqF?=
 =?iso-8859-1?Q?TJI0YsLktGh0yTO6HXpRdODfZiu1T46H18v7ojHTdjByjU08Y+gomLW7sQ?=
 =?iso-8859-1?Q?+xyk8xxfPPvXfAtsEXKhJs8lYCeuUoZgcMf7XY+v6pv2o1bvDafJW/oUH5?=
 =?iso-8859-1?Q?UEeHqs7vnUDYQM/DHns6ixFtR3WN1lD8j7/hHKoKyymqtfARfBPg4jlF/A?=
 =?iso-8859-1?Q?a8TuoH9mBE7mpi1vlIQvOH+9HcdOe0OApD3tVAWisbvkkiQ29qcw0cLl2d?=
 =?iso-8859-1?Q?Z0hSPJjwE2t1peDh7UfSNT/1uNctwSLfE9pDdkAYeyDyZ6OcOyPXp6JyJL?=
 =?iso-8859-1?Q?wW8PxDgOlXqrRF77+wbr4OKpZkiryCRMMF3pqbw9Qh7POErBLtT6tDshMF?=
 =?iso-8859-1?Q?jNYIbzZRUQaSd/fLiqI6V1aZPsZVnpXnMbu6fzJ8r9jIA/LAe8kFIPU1XK?=
 =?iso-8859-1?Q?ChNnq+Eg4br9O6vqjH8Hgh8YretunBZQlQisuOW4uaW3wsiHU8deWVqw/b?=
 =?iso-8859-1?Q?GTel0h7UGCzeCOqYzD6Gi4n7PbaaH7+O0TgWtxnDT8tngeDERr0+QM1oW4?=
 =?iso-8859-1?Q?c1FybGMpnVjV59eURNEEf3ZpLGuzUZbCIh4TIcb6K1lZ9bcM0bB5FGGGbu?=
 =?iso-8859-1?Q?tanc9LYa09YwiV83rzewKxS+F656WXiPgRq+j6SaDwCh+nS3H33vii+svn?=
 =?iso-8859-1?Q?RI+efFEonVA4jQ4j2d9u91fMY2rEnblwGWqlG6VzBo4lqXJKjkoCY1iQdW?=
 =?iso-8859-1?Q?5Ev2FOY9Xg=3D=3D?=
X-Exchange-RoutingPolicyChecked: UtGLFXwIzKBQSsPIyKmtif/JuQNyMmuneu35zba2dpptc/m5+M6RsNeIWQKqmWzXxe/W7NIMCYwj3Z3SLXe9owX2a/8ZFaymvwhvNulx1uxK6ggNXG0DxpJw/KT91u6jEj7zeQDsewBdUIVj/lkhU4UAXCejo4v7RscqB9Jvdn+vAd1C1HfzgB7GAQeBbwDKW1BhlJvY5moDeRMpZ/MNH3LEE8al29C8b0WC205XznmANImgNl8DLiYtDieRTUpnptBsTk3RBVoedTek3C5WZStWj2t/zcSd/cykQzBY3mVpHmtJmqzOruLKg+1vTj7+LDVxlTtC2hrzMKp0eh6vQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: efebb5ce-67dd-45cc-f0e2-08ded732d531
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 05:37:26.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zCnoDd+OMlimoP6D/do5IhZK/le4J1MQGUurEoQxP+jpAoJBTFqtzT+GC2rq51HndQxVnAqitr19VM964NvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8943
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 09:45:24AM +0800, Edgecombe, Rick P wrote:
> Oh! You already did some testing.
> 
> On Mon, 2026-06-08 at 17:50 +0800, Yan Zhao wrote:
> > > How important is this patch? I see "Optimize" but I read "Optional".
> > This patch reduces the number of global pamt_lock acquisitions.
> > 
> > Reference testing data with/without the optimization:
> > (collected on my SPR test machine)
> > 
> > Booting/teardown of 1 TD (8 vcpus/8G memory) per iteration:
> >                 |--------------|-------------|------------|
> >                 |    avg (us)  |   max (us)  |   min (us) | 
> >                 |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
> > ----------------|-------|------|-------|-----|------|-----|
> > __tdx_pamt_get()|   2   |  0   |  578  | 505 |  2   |  0  |
> 
>  ^ it looks like the old version. Is this on a huge page stack? Or just plain
> dynamic PAMT?
It's DPAMT v6 with the huge page stack. But the data was collected with huge
pages disabled.

> 
> > __tdx_pamt_put()|   0   |  0   |  563  | 496 |  0   |  0  |
> > ----------------|--------------|-------------|------------|
> > 
> > Boot/teardown of 5 TDs (each TD: 8 vcpus/8G memory) concurrently:
> >                 |--------------|-------------|------------|
> >                 |    avg (us)  |   max (us)  |   min (us) | 
> >                 |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
> > ----------------|-------|------|-------|-----|------|-----|
> > __tdx_pamt_get()|  15   |  0   |  1723 | 1386|  2   |  0  |
> > __tdx_pamt_put()|   0   |  0   |   562 |  733|  0   |  0  |
> > ----------------|--------------|-------------|------------|
> 
> 
> Did you record total time, or number of invocations that we could use to turn
> this into some more real world impact?
Below data was collected on SPR, averaged over 3 runs (huge pages disabled):

Bootup+teardown of 1 TD (8 vcpus/8G memory):

                |--------------|-------------|------------|
                |    avg (us)  |   #cnt      | total (us) | 
                |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
----------------|-------|------|-------|-----|------|-----|
__tdx_pamt_get()|   2   |  0   |  706k |704k |2025k | 51k |
__tdx_pamt_put()|   0   |  0   |  706k |704k | 130k | 34k |
----------------|--------------|-------------|------------|


Bootup+teardown of 5 TDs (each TD: 8 vcpus/8G memory) concurrently:
                |--------------|-------------|------------|
                |    avg (us)  |   #cnt      | total (us) | 
                |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
----------------|-------|------|-------|-----|------|-----|
__tdx_pamt_get()|  15   |  0   | 3431k |3420k|55517k|334k |
__tdx_pamt_put()|   0   |  0   | 3431k |3420k| 2066k|137k |
----------------|--------------|-------------|------------|




