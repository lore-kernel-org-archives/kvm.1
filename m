Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB33F8881;
	Fri,  4 Sep 2026 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497512; cv=fail; b=mONWAkl7TM9yOeXTSlV99HfE/wsUGuziT5hFhZDuA5X4S7icluSdWSfa4D1HemGnkZ6HlP2SJurOJ3OAqQtP8e0Gg8d+T4jcOSFlVCKBJQYHX3VeeDNRsbMgTAgzTuikcgyyakfB3zgjUxtcLdw97KEloM8zpagarKHoc4xf1tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497512; c=relaxed/simple;
	bh=er0BIlz6YwNCd0GqUJQO9HQ878dFmwaRYPSZhdbwBnM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCACUDQME0Gz88MznlxbNMgHuBv3qNma9eHQzB7FnOMZaJS3PmYxh/4+CzIfk/EjC8Nj/2cK5S52/9nPMlx5V59X6HAMxNBBmjYzmNERT6cyHzjVGEP5jwyRw5JbntwOF7cKrOgz/fPt4ZW4cUt5ITrfto7ID9LNc5+f8r6H6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoyeQUqL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoyeQUqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788497510; x=1820033510;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=er0BIlz6YwNCd0GqUJQO9HQ878dFmwaRYPSZhdbwBnM=;
  b=MoyeQUqLTVBeKpsfsodvffTSccI+9lAMEEr/5OBy7JS2QXaaFygNvG6R
   /w0ipvNgI2UFyh5XRmI0wkfdznIvtTC8zDMN1PhguKnFRCXfqN74/AmYN
   LWxSEPoYD4asooNKt8xXCeZCRpRwJlltpDiaARUe+547qIGP9yyealDPz
   ZkKGc4zvUouFn3bjF/I5N9KLi/VinMmd8tCCRPwvj3ZPOyCinS1BzQ6kD
   OmYu0QPZUfgf26svyX62mi02VZb2MoANfaQj6jV3WxoFEQ11fmFmUrBYY
   sF+OZ/eRXYRyjOIdZLEQlCKhAPX09pExrOCpnc+X1PqVUtWW1nbQ5R0+5
   Q==;
X-CSE-ConnectionGUID: 5byN7ruMT2ydFnfxeB47Aw==
X-CSE-MsgGUID: gncwYwt3Q1KcFULzDXZZuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100154057"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100154057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 21:51:49 -0700
X-CSE-ConnectionGUID: +ZeGaWo3Q3ujHjckr6Gt1A==
X-CSE-MsgGUID: wrn+GnMAR9urMEyWUJcqPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266252207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 21:51:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:51:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 21:51:48 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WouTOEMKgrVe2X8xrBMCXLrNV4j+1gxBJKAPY9L8h/27xopBq3tQ2tVjA/NFbo4eJKs4mYeFcIbnt+zP4k1S7h1IlhS6Vw5gPRoaBtOv19u3pnjMWMLMnfbw6aLN3LnTsz9PW0mEMDDnAivoc60stxfCVy1Ah15/n6z2rqqqme21T3nWUlfz7GGbREXD8g9+2kror6hCBaj5BVdmhLD+s7A70E3ZhHa1IiTS0aSeMaEj+20y93oynijCyf7C91yGOhZ2zmCuZBITt0tW5YxnEAkUyioOuCekLOslRNqwZ/yFV4zJeaCZ4P8oFT5yCgVDheAnog8E2GaU1MGFgGNL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB4TMAv80zsGvhZJZyr9DEIS0eUYRYEzHz86L8zQ+is=;
 b=Vx6TA7yZ2+MggCu7IaWjN/NaCNk51ixVgSm1DF3GhMj90huWcOHLs7s5ul7Lb4bLmzSws9WzWXTbjfrOK1Dl0P3egdAMPCJ4Xw1OETusfYYW9SFpfT+cjUiGSGS5x9Gvx29f+ZhH3hbQgJIVTuyU1EV50Axvq1nf35I6r7N9yCKjn/7wJpMQCK9YFksHXS1kvyK28r8Frmg92KvHFWrpImVx681olLOekySm4/WTgV96ar6DQa+/Q5x/Ql7YEr8iKTMBnOfL+pMxAqfADaxeC/+51M2E7szUPkM+iB7P3jY6Enq1HOnAjMawYnWYdKVt70o3Kbl3hBTxS2aSmBp48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DSWPR11MB9872.namprd11.prod.outlook.com
 (2603:10b6:8:4e2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 04:51:46 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 04:51:46 +0000
Date: Thu, 3 Sep 2026 21:51:44 -0700
From: Peter Fang <peter.fang@intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <appOYC2I83fgWyth@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <apkUQL5KJ7JQqtpY@tlindgre-MOBL1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apkUQL5KJ7JQqtpY@tlindgre-MOBL1>
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DSWPR11MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: d2495194-8f37-484d-f83f-08df0a40391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: UBKyOISUVvTKW9IhA//xGQR9K/xIxTf6uENcJIiz6xD4YWxrq6tMa7xMVitrQteTU7eIT1h90EA0I+Z3paVeubX8OXiffWjgKO69QfN09oh2mGVErXaRPEbGfDXoI3gZQZUZsT/0Kpvl/IE32be3QH2ZYe2YHnYXR8dEbdg590Am+qBkf5Gtm25O7l4EYswD14jFhjOYdRf1f9+Ks+lbMlHT5xU/UPDjCRuf21XG07RZXH7+K9U6J/IM4JRLFgi3cUiWboJSq84x49EYhmOckn7aruVayTGZWxnHdcFMHaYNppafwy8y6JIVnFPBGWlNCq22L2SpOlEesIRJGXd5I4/7GwaYd4jm6ZktBk9yGrr31DEC23vifEP0dpPLDxWNdE4iVU4zpEgMXcKrtT2vHfHwCF+PZqIJeQX0DXEvGpqb98dPlVy0PkBaKGZ3eH8rhA9dY2p0/6Y8BclcDhJMMp79duEhglpdJUy+gKa542L2dld4ULz5xVGWvJlzj0bK3Rd6AJ2jntlBiV9Xv5evO2+nfIL2Oryuw4vAEkEJlIy3JBGlIoJucDPjREr0xkaNJuhHyU36Z5NKFa8BE938/Zn78lCK9qvoa/Xyd9kIgEPdVK/m+g2PaMsBfQ/D6R/Dy7MeQlmrZFRewv9vi+IB8Qu5ftnvfUG2dQVpW/Htrq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgTHWmumAln6yjgmN7D1G+Z5wekWOPinrel3294KpwopGsDDy/LHr94f0IzR?=
 =?us-ascii?Q?p8moNX8FU29BuXMWQo7vQR4r9x10NL1+m0xDmyPbaZQ9pQ+xa9kIBhJFKU/i?=
 =?us-ascii?Q?wHEk5Y1o3coqAYDoNvgo4m/erEHEmpU1vRL1OKJmnS2CtHkvx/qLeIt72zqV?=
 =?us-ascii?Q?pSxnKzAtfmq5N4Y+oVLuq9KHfJSy1mVJ6iQJqpgxsGxAnFQE/dMUWvtM3pqf?=
 =?us-ascii?Q?+zTToNvI0D8/4BRY0nKaiEc9zcVeTRj8QPCz92R5oesqmQ+gAPfW5BMuU1yG?=
 =?us-ascii?Q?QGQun3gifBbGG5lPM29wvwiK4U6WZd1jla11Z3AFQajyKqtiED8s/QaDyC9i?=
 =?us-ascii?Q?KbfopUX/LE44mKG/r/iC91XKEnxME2YNNUA0Goajkgk4QrZPNppiXNp21xqQ?=
 =?us-ascii?Q?wPy6mgXLPhvwXVrC09M3zpwhQqYWoHcJqdC8KHzFfJ0MmdI8g6VsHqEGRZQs?=
 =?us-ascii?Q?fMlHRf9OFsL/00Duklbb53la6W0XdPXBJSRJ5jCZNTROPIwz6CAlX2ePgz18?=
 =?us-ascii?Q?trpOdP8poSFjaklCBiotRJpwKqpIu5Xzf247SunWIn6dUHVz1fce1uOIDriG?=
 =?us-ascii?Q?GNrsfUCnZEj44vJvz+deNU1W4soDqDeObPYqlYFX9Omqi2YguNUR/oTJy8ze?=
 =?us-ascii?Q?8tr99ufF13v1MHv1Xy6xjsnTeo0HbzzI9Wu9shqfGiAWicIxTYeJsm6XBzQR?=
 =?us-ascii?Q?1vgy/TSHNm2LsNCy5N8emqSHG90FN5ffobMTGvc4oszftGDIYm54a1tZen6D?=
 =?us-ascii?Q?BJY7bnSQxGVaw6qe2O8MonFepl2neevQDkdBq0R7n7KMQmr1LavrtT9fkohc?=
 =?us-ascii?Q?AsI5sgXNSe95762Hf/zhCWE+RilVumwF3JPNicy7pETkRGKPwJBWuN3ZJASn?=
 =?us-ascii?Q?Wr/hz7fU3H68gblKFCWkEgXSrT1mgDQMR0hBx2JIHHxmvmfXnC01gGf7KBSG?=
 =?us-ascii?Q?rk1PMJoi0SNbqS6aT7kLaK8ybpyAbwxWfLvOrdHuKdFB1rVlnmYbvlFHHEk+?=
 =?us-ascii?Q?cC59/tSdEd16TDV5XJ3WDRIRxE6hzRr2eTtMEsveka7tIus9aius8YHaA8Qy?=
 =?us-ascii?Q?EZGP9Eez24IAmzshXUBuVL/w1fZxrv2moiUnTbO0PzND3CHrapSPphSkOAmG?=
 =?us-ascii?Q?/+/F6rbtwVIqPGnr6t0ZMmeqlpLHO2f0tpF1a32sL6ABjsHFSq8Tfnvwree9?=
 =?us-ascii?Q?SaatMxM6dl8xwaZA6jvWJukVRij1vyWEgSOcN2Mm7YlC6B2hlvGhjeXaVYCH?=
 =?us-ascii?Q?r1tz6Z/DpkWz2Ge7qoRo1N3o4XY4erdQRa2ruKWABLGixN3G1hdBDPld9+8I?=
 =?us-ascii?Q?vuspKr3TMSlVL0OwkpBoDH8ymTT41s8bEglLh30W0g4RQNYEhO2AxfTkPl5k?=
 =?us-ascii?Q?yLyrAe+rDIs16cu2EWz9TuURQ7iCk+brwHCgmbwUUfmG62F5rwH8OnHDxgBX?=
 =?us-ascii?Q?DmSGep8cpzY8UeQb1DYJ+QuX7bRrLxDHPe11bVpC4yLmmoD3YBaAFPjWdWqg?=
 =?us-ascii?Q?vRyhYVmSwZdeZx0FkuNK/cfk/mZ54371Tb4hf5OT6Z0pO9J+8iQBzlO0rDHR?=
 =?us-ascii?Q?Ag9hTXV9iK3tDLupNU7Leewy+RKpSAt47oZj3pdSiX6EyFZhax3BTrDezEhZ?=
 =?us-ascii?Q?lnpC4OERbV5+/dfRF5WMsAOjngMU0Cn3Y9n0WESILIhDay6BQXrRxVi/LdCB?=
 =?us-ascii?Q?Tufwxz3YnO1+LmFvohilOaNvFE9B3BLCLNmD7GBI3QruONtzVxOLhzwv9km6?=
 =?us-ascii?Q?jav3lEASHA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1xJr+uDWibEnwvImL0QMzFK0vswaK/jaqlqEgPySP4NM7kQpvoutnGpzc2DmDDMt93QMSP6LDuPcexK2jgdjAU1ROlT5NSR8chLhUnREb/Y7zu36JHPj6Oz94qNxtGLypYvhpxGXRZbSmzWAVHnvIj4+l7JtTVDirgTPWBCp+FpN1ZaaEiWEPvrzh1OM/G3llzqAtxXx4PY/g12erMtX3H4mC4CBO33ViqaM2utMR7sJzA2ux2T66EamZeMPgdPf964vHEbLxXUdbaiNdcBlbwcDM8Nx72olGQ2VLB7M/MvXlH1mZCJ76+w/I/7H6UItCWWgr6b6hA+rOFFtTUO2Pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2495194-8f37-484d-f83f-08df0a40391a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:51:46.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oumvO7v7nIOUcwdjA5Lup45UW3NBRCWKUXTSYqtPR02YDsKgOTzF3HKpm0VW2zdwaDwLB3eh9tOrVG6qwFhesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9872
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 09:31:28AM +0300, Tony Lindgren wrote:
> On Wed, Jul 29, 2026 at 05:29:33AM -0700, Peter Fang wrote:
> > In preparation for dynamic Quote buffer sizes, replace the fixed size
> > constant with a variable.
> > 
> > The size is currently a constant sprinkled across several places. Store
> > it in a variable and have all the users read it from there.
> ...
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -417,7 +416,8 @@ static int __init tdx_guest_init(void)
> >  	if (ret)
> >  		goto deinit_mr;
> >  
> > -	quote_data = alloc_quote_buf();
> > +	quote_data_len = GET_QUOTE_BUF_SIZE;
> > +	quote_data = alloc_quote_buf(quote_data_len);
> >  	if (!quote_data) {
> >  		pr_err("Failed to allocate Quote buffer\n");
> >  		ret = -ENOMEM;
> 
> I assume the quote_data_len does not need to change after init because
> of a TDX module update. So:
> 
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Yep true. Thanks Tony!
