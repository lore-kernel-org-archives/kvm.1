Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2C38CFEE;
	Sun, 14 Jun 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437873; cv=fail; b=n9kl8JgCZhgQDsMnR+709UnHysYkh9ytuCM2ArpU+mq4KLlePLgVhcY+/X6PdBIOXwgjs/T7gkVglXzzJt/7pgUjhGDHm78JD8o2l27NpVhbs+yFR/5OKS3glDDuLnDRH08WAnCyat8HRXVmGqjbfAZudatnE2ZPf2NBuAtBihs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437873; c=relaxed/simple;
	bh=Fc7g8pgQnysETMYRFk6CkGuVlmMhHFieX1NvYiOCZPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8/rlHNpWwZyVjqvpuSwJkGQ/S7mkIINLALrKiHuls48nKfmeOONq5SsNprenlcQb4enXyMEnC5g7qGp2hw4FNG3187sb5FxogoKSkuD8Id/lMlC42l+H2k0AvWSDaarEpE/wISSa9YA11sHpvmnpPYRB0eTRrmUGvURvTXyFTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STcTujvt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STcTujvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781437871; x=1812973871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fc7g8pgQnysETMYRFk6CkGuVlmMhHFieX1NvYiOCZPY=;
  b=STcTujvtwZk4aAkWznpfZEt3CbHr5Erb+4x1fOpsixGBxfXgFzF9YqV7
   SxfNDPJ2IsYv51Mx6l68MwY9GjpCnu+gyDED8F9db11/wrVlkst9Z/AaD
   KKhn+o0/g9XWzyycFBY6nwcC3c9eW9NKERTNI7HA9AAgZ0h3lGLgqGBk6
   JKTI0Ln9X3rxN4fbgkr7qUR8M/PGAZ3SgDjs6HenU3y4WYEpPwiMelAlE
   pBA8ofWpIBzeU1EeQTbb1171hWcwrTPUSUj+k75Mz8ffzsIQ85rYDALeJ
   lhCsWn7BmP9lJcH7YCdTKLMnedlRVGEk9HVbmuMt5czer9sqgNs0NMHUp
   g==;
X-CSE-ConnectionGUID: IFZYiR9WSxyUz/5iUZ/MPQ==
X-CSE-MsgGUID: iHwco9z7QLCbE9CVKjfQ8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="81942768"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="81942768"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:51:11 -0700
X-CSE-ConnectionGUID: ZDHWoI97RZutmNoykwKyZg==
X-CSE-MsgGUID: BCy5cKwfS6GkBFSswNjLtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="246128454"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:51:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:51:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 04:51:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0cfjIL9CvQ+KlEuXs2wOm5iVlw3NS4lSoh4oUTO1IsZJTDt/uvU9NeqZRfzZ7uT6qRrBW+vgRFYdwXmG/VBDhcZ/aCIaoFCljn9a+rM8L0pEiVtjJF/tIt2d7EnyCeDC4e9fW4vefKeOSUnoa1XfTshRSILQL3dJY8p6OVk0PxU3lyh4Z6C70cjkXHIDa8T8XykDJ6JBsqXnGpbeaFjOATsFofpFwKTtvGFWm72qOVUoVrauMnq79x3jxKdxi691SeezDxRj4hZAD34ptKlAeudDEJU7YFvjStO4r9CjKa8rvam7zFKY2qAZaJ3leNKzkq+keqafdT33hzGXcYBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stNaHzuiswAaByMM4HE0WPmiua+mpPIFks5AWY13E20=;
 b=MKpxpMrfO5hsEvTIK6lI7kVzukJJVrZtKYkgCpkhw93uH9QU61ylMdl1LOquDdq+W/6vcJWU6HJCIWAKu/rY9HJORItS+6Uc/b7jxzwLS63puiaBGll2FILSB4B/rewcaujc9vRQFwM2RyjQPttK1rXi5fDeqZbYZ4WrJ7y9VOLdgsb1Rnm1eFzfjA6uTE8iRgum69QTgThXWaA4iXdP9TkqatPstwv6f2lP9tF8lZLLFv0cAsnImlb0bsUx5Vc8nyRXLFdoXXZmXSCkMTP6eNP7CfsiCi38+AqcPvmdf/m7qj3frKl5O53ghhzcvbk7Zff6UU0u5mXzirMmm02xUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Sun, 14 Jun
 2026 11:51:07 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:51:07 +0000
Date: Sun, 14 Jun 2026 04:51:06 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 10/15] x86/tdx: Move and rename Quote request
 structure
Message-ID: <20260614115106.GB3417767@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-11-yilun.xu@linux.intel.com>
 <6a2c9e7570dd_9b855100eb@djbw-dev.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6a2c9e7570dd_9b855100eb@djbw-dev.notmuch>
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH0PR11MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 460e607b-a699-4219-46ea-08deca0b388b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nlSkQUWbO7uKrKpfbM0wyCkcruGkLBEyj9AXG+3aKE9MK6qGmnyUQBwlVltx4LVWgH/KyyEL/hZjiszHgiFACt0bKGna04mQvvDBKsmYlHGEuWAsmkNjkJBydsnlnPcqv0ZloSbrIoOF974QhrCyM+BuayHoXhhn6zYKxgNjtdxMSpTAbMiD+vNncr5ls4b+izJgLbp849LOQ7goq98OcbHyUMETrRqrD7XhqLb/0soz2pFOmTrDH79ZMrT4yROGdDBPyzY46S8kFb0fNRAclC2N4qQ/X2myUy8aoXehbe5UQYd5gThY+EitaJddCIYzvuCWY3RlCF1oPWJL/0WLXTZs21RoIgvMKBGfna/M2ic/msSl7ftazSkIoaz5IX4uea0yJXaIHWTJOvyngpou618ZN8Rh1BMf0rpiuS5hVssYt+CEVXbUJn8+SFZZfmC/jK4ecdRT6l07MbRgeF4BJXfj5dbZeHfCUdYOJr5lb7GV51fE4TsiMxDZkksx9iihAYo8knuAbIy+Y6zqoIOaMbFDJnm7PuVB/yNa1ajCEBCs5vpU145qjgAc0uTUYVa3z6qbiWHG9zyTy/8TInB9CyxPbyDfNdt7ZjcE1igFILj0ueLFH/yARBSIVjn2x+tYR0PvW4rgjRio91Uj4po9lS+j1t5YzZWepnijzO3eFaTBDhMFT6sK5gKIK+GI7yyR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zm54IP0JINAyabVn7LcY9r/6v0d2qZ04x72BAbeAPltWR3kOQfFqmFItSfxB?=
 =?us-ascii?Q?YEfMCjQF+hbZDBIhA+Ri+rfuk9wcggJSKbKTsT+uN1JBcZKKLE+8pagYTDt3?=
 =?us-ascii?Q?dLTn1V84WO0KO/Vs/Kp3nNw0laGbyuPqJ3cKPJBvcSoAfiUl8CWyPlTfwQVq?=
 =?us-ascii?Q?jI/4Zxi8M8bwC/dt7v+ZXnbYLH3iCEsbQxX0H2cyGRr3mqm1IoSyzjUCYBwU?=
 =?us-ascii?Q?DWXifeuk5vKHViwA96Vctdqanb02e8tJFu3psZtyYoLDINdUqzM31z5zmHEN?=
 =?us-ascii?Q?NZT7v4pD0PE8n+to7CZ/uAUBJ5r+nmolgs0oj0kCDpAotkknKZbWfYInj0Tu?=
 =?us-ascii?Q?IqMOdYqQcyxNH3QTa3Za0bk4dTNhvMWHmDS97SKz8yukhEP628ajNbhRHwOR?=
 =?us-ascii?Q?cC6EBo5GB2rD2bkn9u+I2k7aVQNHoM23bquoQE4Q3uG1Mtv+1UU2S+8pssRJ?=
 =?us-ascii?Q?ququ53zbGNUQSXqUiLMXNs72Hee4Lq92vojSTDNiuSWA6lGbNFWPYmDtSfx2?=
 =?us-ascii?Q?KvWvCvvX6BsBpqMCtMwvmb297fLzKp70f62j7BCXQIOZeJ16EGLtM8/WjvFj?=
 =?us-ascii?Q?WNZjQQpXKzIWD6EXc1ndqoUAirn18dH9jGvOWSXtYzzK2nM8J01sLBJYde8y?=
 =?us-ascii?Q?AJh1eaymymYhkGueDo3xD6wcY54qnl1Whcfm4DUwn1CRSrQISCohsH4KgL4x?=
 =?us-ascii?Q?60Ynkbj48OtZqs1P4n+bE0/OVSE/aE14DXjsIM3FklS1+52H23uQGPzZrWqd?=
 =?us-ascii?Q?/KKqv5sqhyh2ZGNGpmLZLqn7bg7xJFXq1FaV1kbSV2wpiAcoBseAAVcTP8Q1?=
 =?us-ascii?Q?y+f6x5QNcEsycVDzVa2srN+3PdS9lO/ptNTFhT1HI55OktMXULy+hEboZ9AQ?=
 =?us-ascii?Q?bvfZJnvknXp6O3RAVsmfX8tNQn5mNDkK9+Dss6ZP9v3qX65Vnv4QTjkfenm7?=
 =?us-ascii?Q?+YetKkRwzkEFcVAkWpRu5+ebkUBRuFW5d6KACr0tHaYTZ2tnHykeHpA+AllQ?=
 =?us-ascii?Q?eLM1iPVMbcJnjl6vP7adQmxt8gOEnztDBhZqWG/skeNi3klcSnNHsPzW5yvm?=
 =?us-ascii?Q?fE7lDZ0y/3gDH5g+fm5dnlM4p2j+KUHKpKNZnNWidErYg+xXcaLltJmSgpXc?=
 =?us-ascii?Q?4o6rh/V95MzwsObdQuh1X9VgpHrQmDOmu4ScwqWngMT2D3X3K1ooWHG81+09?=
 =?us-ascii?Q?aGt7UkvPBlMri2gnU6tjGc7GcDpR4cBlTX9JuFFVcIZpah7+4iPjejs0MBNj?=
 =?us-ascii?Q?fqpwSnE0qMENHggFEofVZeJQD8RKxUld5uU7dEniYdpbBmnV1DFqOxAvIuWr?=
 =?us-ascii?Q?OUpJFTDsw8HPvMRQ5Ea0PIrhXjQ1WFMNYQycB4zLcJSZmo/Tb/8cvV2DSzdN?=
 =?us-ascii?Q?uC8ASAdEPQTLB0zkhXy/I+78rOWkzIFNvubljm3p8T2+Yb1Pqa1m5cXPnJvp?=
 =?us-ascii?Q?x9SI4uoH+ZJqehK6VCVeJuA/ol7Tleb+qsXbJJ7yXYZn8z+k5yKWU5nwPnBF?=
 =?us-ascii?Q?WYdY6pt4qe/my21CHlTm7kPl5NTE7Wb0Ssp1MMTqzfQl7NPTtZdOyIE6gY58?=
 =?us-ascii?Q?d3t71hsrNZFHgJ7MnWnb4McXvr9ywAnHgSfV7qRT5Rp2bK/DSUjQE/WDMQzS?=
 =?us-ascii?Q?CKvjnXek3SU1PlFHUIzXn4+sJCfb9iTORsoYkgPgGrlTazzyAdHp8984QBju?=
 =?us-ascii?Q?d97+s6j7/W/LaxkkohWtTEpTp9qRrE+AMEoxJ4vNoAurvKYXo5gvnKonWoDI?=
 =?us-ascii?Q?adCDRkb/+w=3D=3D?=
X-Exchange-RoutingPolicyChecked: HTcZkJTH1wwjPyyLWqVQyG+x4L7meZrf9snsJ35VdYVEy/lXkCij15J4V6L5suF1NtmV6FT49ZNv9/ROBPKnX0tAwwKbFOJ8iLiD8d1qfxPLSE454cAO7i4aO6Xyl6Nu739vFTYNulbc5rp/15DlLRUy0HQVwjBrUEGfVel29nxCfuUFesH+Dnx8mxf0DOvMVzb7y+AWegetr/vDR0ClaEY7EQRT2dFx4TuYxGSjPSNtUgu/Tq2wOd9sfEwdnzZ9KjJVUjIx0ra88VqXHh2/Fcnfhdm3WWNc5lFKD49CC0H+IVE6BZqYSzs9YqohAsFmzsNXfRAGofSAacbn/kP2yA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 460e607b-a699-4219-46ea-08deca0b388b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:51:07.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVlG+AL0X1PMCWvY8Zk7USmv8kL0aA2Iy4QTeKQSMjHSgwj9LFAq9eJTONS7z0KLOHQW9QavNUdEtRD+1TiXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 05:04:05PM -0700, Dan Williams (nvidia) wrote:
> >  }
> >  #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
> >  
> > +#if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_KVM_INTEL_TDX)
> > +/* struct tdx_quote_req: Format of Quote request message.
> > + * @version: Quote format version, filled by TD.
> > + * @status: Status code of Quote request, filled by VMM.
> > + * @in_len: Length of TDREPORT, filled by TD.
> > + * @out_len: Length of Quote data, filled by VMM.
> > + * @data: Quote data on output or TDREPORT on input.
> > + *
> > + * More details of Quote request message can be found in TDX
> > + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> > + * section titled "TDG.VP.VMCALL<GetQuote>"
> > + */
> > +struct tdx_quote_req {
> > +	u64 version;
> > +	u64 status;
> > +	u32 in_len;
> > +	u32 out_len;
> > +	u8 data[];
> > +};
> > +#endif /* CONFIG_INTEL_TDX_GUEST || CONFIG_KVM_INTEL_TDX */
> 
> Drop the ifdef guards.
> 
> There is no cost to allowing a data structure to be defined
> unconditionally. Usually the ifdef guards are to prevent compilation
> errors when symbols do not resolve.
> 
> Otherwise looks ok.
> 
> Reviewed-by: Dan Williams <djbw@kernel.org>

Will do, thanks for the review Dan!
