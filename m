Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67725A2DD;
	Tue,  7 Jul 2026 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394660; cv=fail; b=ojeqNemMhOdMZipuOP/AoYYDnjaaSHo9M0z4qGcDXkF/tncFX7iZjvw9NsPrjlJQCxx5rGBsFn0n65ELZSglNiwDySNsejNDOhR5FV9Cv0DL7+rcdHAcDYoXY2smya0YRrslLNJA+DifvoNFgFVFJ84c8yBq8xhgNifJEpVeUYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394660; c=relaxed/simple;
	bh=Eh1kCClHYS8uhQZsKe6OhbupOz3gc1Vu08alPt0/l/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSk90ZnGyDL6de+eSrIuwbg0Okd4NqGQRGHyhba2fEfmK9v9fWa76CDzcx0QT9SG4CeGZoqVT2gOKeILlEl54pAV856Cn52QTXk+/94gCXMUvBOAbd5+UMD/fSVOWU2HBq8UtOP+/b4EbFkuyn5Hp8EMDYqrUv9sJWOIAVeBZhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6SLi7tc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6SLi7tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783394658; x=1814930658;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Eh1kCClHYS8uhQZsKe6OhbupOz3gc1Vu08alPt0/l/E=;
  b=e6SLi7tc2XcjTpAXNlKJqkzGPDjQ1drLqx1feo3qhJQUCF5VJc+ijgEM
   c6Tx5J5YwoKpe5ppx+8r+a6W4MU4ErjZzCXwIMawpIAyqVXi+U1LSVhJ6
   50QnIIwDzTXacm9V2L0XwALwVg69P96nGGeiqJ+36FxBeLvQMCP5s+8jY
   jzwIOFZg6V2NjVqysq2XXqnWHzT7rMwPqT/TrB0PJqsRfzJCyXA0mluuO
   MrSLZ74nYyHKVqR//fJlTMPFuiTntKq2KHMIr5lTgVCc+un0zWrvfLbwJ
   mqJiSaQjEUKwJsZRSDXJTGRNjAmKlshKBd0tLaNycyQhWu4QxLG62WZlp
   A==;
X-CSE-ConnectionGUID: qshjY5RiRyeGBAAlvtkc/A==
X-CSE-MsgGUID: ZR4ykis8RZG+Vq0WXnng3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84084661"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84084661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:24:17 -0700
X-CSE-ConnectionGUID: QuOsVorlQ5O9zSfW4gUMVg==
X-CSE-MsgGUID: pCkzrmSTT+6tLy7YFLQLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="247502893"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:24:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:24:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 20:24:17 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 20:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt1ac5z2e73Rrr9aXWfpvuNR8KWV3GckJNcwH8q+RdBtJNmVpnJ1a7kZ4SmQSFChETzTG4Rp0E9Q0cmo5jESe2NhgDW47kM2SJPWDfGIX0+A+WuvaOTCe3D4di9IzT0QSQo1yFEnNYycNujNSFYBLg1Yq4kytUCYELSl5yVUCu210EZMM/SXZQC/KX8YUdX6n5r7xCOQcR/Gy5oiXjmqVeMZ70ZluS6ywU5Ry1gjQg9nvUDljyIC++3PEyMacFtKKz3cYFfm7iz3m+GJbS/gbe2TGcdNv5Tnan3kFtjfACvNzN+EdMaekluWGVNySIdoqRYvrguZMeNuOXkxySN45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU4FrANhljZJKpLUP1byCmi1+uiyredscncwv9j2otk=;
 b=dWm8AO0yNy+12NzoKaqUty362cvphssIUcMxihDLVnH50WNcnLdTevOJ23eGnZNRCnwPmCyvbc/RISB97z4XxJMeZijWOiemVn1W4hA+IFFiCrizVax1vM26YARNYuxs33nUbE+eEL+iv54DBCSbKyAleK7YDPLJT5jNBTKddoVB8MctJmb/kCsZK4uPlj7Qvl/2lN4x8e06MnN1/SQuUyjIgBgRK+Xb3RdVozF6d4zh599h9zMOdXgnwj88I7D8CyuzVBrFeDYKz+if5iBtVGwtDYrkn8xsOJ0y0ljK+644RtWR7h8tRMNnZmZTSuMJDRHDRNaYPzALWrWJk/5OhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 03:24:13 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 03:24:12 +0000
Date: Tue, 7 Jul 2026 11:24:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Message-ID: <akxxWF5nMbFQWlD3@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
 <akdNPjf3zt6jPX1m@intel.com>
 <6605c80fc676c069bcbb097c77c07b17eb3eb97c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6605c80fc676c069bcbb097c77c07b17eb3eb97c.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: e7755616-dc0c-44ac-2f00-08dedbd73751
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|22082099003|4143699003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XhQhQpDJ4AE+O3QLDW2A7cmw4OfGD/HaOPu/eaMPVnBmNVkPwMzlsuCbN7qvjr62XbdUAIUxq8AzXVjReRa8NvPSbjjT0S4pdgHFzRJtxqfIIjRdzrQX4QJUP2Gq1HlNHthupcgOlAKZE+rK19h09w/MQl1SaXMVMbK7iF19YRfgBL5FPJQMC11+s9z70lTZIU8d3wG5tu9kE1sUXk7t6kbYRNI2U5zs+WTO35p7IkDdsXycXiyk0mI2mEEjYxxMPCQyvFstvNdcNKWaFYxcsR0j96z1rm5EBTpxDzQR34KYA0Wob0SLcYlaAuoJXBHm4IE1l9vdmebSJvZYPIQnUwiprkCa/CSL/ygVoVpAXyHu7OysPt6qKW/pMvN2KYzDtJA9UQocL2V1PPVWaRxoiAHjte35LBns5q/CDGpk/RXPnS1hnkuhEVFdHYttmZYCBD5LP8eI04lA8N5fKXtClBrJcKhliP9LFqiEs5VAYHGD/6r1DuTNEhk1FxS9PaoSZdD/2U4lNSxoEYgfPRnogwvPnB5AzfxBiuCpyk6Z/ZelX9AVCaEmHrxPijMjAZ9EdlIsJJHgfc+PKjGSNOPLrNy5y9W4jlAfSFD9qZvL95Ydg91FrObDf7ievWmQsmuvkqb8giwoD3sOiBJ/9DNLefX6SVOHZFJLGnZAT20E8ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V6/crLAPIhTIBLULKkP6ZDxhrYqo4zkaNJDsc1REyDBywGGNvLwHma9l/lfG?=
 =?us-ascii?Q?VJZqcq/xJpYK9ksnzl1zVx8sEGXEiPo9XrxBvR1tlhB4ml1P4u5G84YMGwtQ?=
 =?us-ascii?Q?jFDrS4x6ewj1bIYdvGopGBscB8iOZmvQiaDwNmhM8oWh2WTtp1jQcXyvVeCc?=
 =?us-ascii?Q?Sh23Q044UZq69NHos4FGFJxjIGGsx1jPvhS7f6cs3weBJiMmkZh3TGhztJGs?=
 =?us-ascii?Q?4Ma181m3eLIi4CpHSpUPuFSGIa3CyfF2pgnTGL0TusUciqliSX0ow0KJumbE?=
 =?us-ascii?Q?lbvM/S9C1/QRmGyOsweeY47wo+sIrLKxXSkWI7j7qXjy2L1fBcw/9oXXT89P?=
 =?us-ascii?Q?woGGkWOetqGACbufFaSmlMcnHk5+iZ7o90LYayVs75fatKkK28qShjTSHWSq?=
 =?us-ascii?Q?+MOFLshfueqJXMN5Ui67uSFSHGzWLIA38UudsFu9m/7t5VHwt9ftKp8fjSf0?=
 =?us-ascii?Q?54QSGp1PI3EMxPWmTBl/LkjPZhh7ZK/D+dtVt2Y2A8Ha6tmqFiXRLwxxjTlO?=
 =?us-ascii?Q?hfWHwTkIJEi0hmIXcIQs7fTgDW3qBu2vmGJ+9YJBRz9LL+iJ2q8d9jngu5oQ?=
 =?us-ascii?Q?LgOHkklBicVXGlFGOqitRtMapS/0+LKIzyeCc0o3crudE4ioj6ZGThiPUOhF?=
 =?us-ascii?Q?GaunQrwdspmgm9FCuPrHFFm+E/Nc2GbhMHZ5PSxZfYNQ7bwovl/OBraUr3R+?=
 =?us-ascii?Q?JzQiK7uxuUPsX89RtzlMS0lsTF0C3YeW58yxZ21z4BCLwWdBmjdCT1hA+sgB?=
 =?us-ascii?Q?7QfZ3JDOCBoVzMobz+8QAhRBazeB5AVdF/LZvmRWu1Ieliw3GyhEvrfyiJNJ?=
 =?us-ascii?Q?FX1BMBxCAxA5aNO2YWa9uUJ1+IoLQO51zgwqhN32kZvEDhVfV4As6iNrD4U4?=
 =?us-ascii?Q?MEwmTAvG5sWz/kigP3dM2tcmOYRwfIdEBUYhktZudKVFw0IRDq33GLb4sgZI?=
 =?us-ascii?Q?hMxCpYt9Kr6MhoKvc3xNENY9vF3ADbzJVoyf/kxYC7wfA8uhtlQVA1HASVrO?=
 =?us-ascii?Q?qqINAjTdCHn2uA5xd4kNzXztLEawhQK0X1Pubbq+K2BvvfHOPalNCcQE/Wk7?=
 =?us-ascii?Q?EiJIiJfZhD/E2GwYvMtjvL+uqcdYWhZiZat877hMfSZpYgO7xcmaqt09J+rv?=
 =?us-ascii?Q?PREE8dK8rB8oecjgpO1e4BS5IUASY6gtS/i2t5pqFjwfUJOOcwe+5MbcSNvy?=
 =?us-ascii?Q?aFge/yZjtYx60ox8ohcHauxoVW2hivUaJKjf8uQ4V3Vr3X5at6cd1kQRvpqC?=
 =?us-ascii?Q?LQLb/VX9sb788lAQFsRkRst1f/RhcuemVvaTZacdHtO4Rrt2gfrK1UHdd3EA?=
 =?us-ascii?Q?VPXtwPtqk7rU26Bu5agrh4XYQzTovTrOvWNjYnQ0Y1SFgJpJAJ1BVkkuYahD?=
 =?us-ascii?Q?90ywYO6fDmd3Vqyi/UXVcnq/J0LfciMX2B/D5+Zc0gdOph5Ik0PqzS8+gbYY?=
 =?us-ascii?Q?5VsNom7YjmYTfcuXylhzzWvFgs7gsPSMNswhdfDFMVJSGincwehi17LoYhsW?=
 =?us-ascii?Q?HbkpcgBzhOfnTWgZUxkJmrs/hOSWS4csxarZUTk0cn4t7viWwXNLIiZNfKsw?=
 =?us-ascii?Q?Vy/8HaEyTXTggAiC5H/Rd4TFnEN6Sfd94j0K8o4LAVMpK6kkqQhnu2+6QWy3?=
 =?us-ascii?Q?R7sMu9ZkoqWbAlNqrv6b4fIn0ykX9oGLB6mnFcBKaEdeok+i+Q4JBjPA+WJF?=
 =?us-ascii?Q?4Aax95P/H/bWr09T2RXCdRkdiJ2I3Y1jWzsFVLw32tpBbPZBpdJ/5W8BPQ/k?=
 =?us-ascii?Q?Y7qgGGxz4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: OOHcVS/K1pCAHOz1ZpnB25iVhfXkR3h9HTB3Qm8QAKgbtPf1InykRBxWoa0O0vzB/VmobcqzaJ1/MFExaUsensnG9ySUd7FPqecYupVdVTcyBJu0sGTbNTYaLdQehVPod9dAsZ9xVGFf69Pi/GncNc3SNOiFqHRQcSvP/24gktT3tyysOnYb7shLUHpEzYRiqzhpsZuED36HE0irfQqdeiN60sFRG/jq0NYvcGkx0ebGx5A2/nIXBk282ysoS/oI/+AnNI4CODsq6malP3oKywASfK694FPw5MODrl8zhM3pehoUR3gK/Sr0ZP9v3qbz+DFX+E449LscFdRLxUVn0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7755616-dc0c-44ac-2f00-08dedbd73751
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:24:12.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpQqo5rKST/AANSY5KQLnJCgAoYflBEDlPpq6MEfSsiFCiy98YxPaLmr90mTKzeqpzjANJ7xce5WhxplUUEqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

On Tue, Jul 07, 2026 at 04:18:25AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-07-03 at 13:48 +0800, Chao Gao wrote:
> > On Mon, May 25, 2026 at 07:35:05PM -0700, Rick Edgecombe wrote:
> > > Since the loop that iterates over it is gone, further simplify the code by
Nit:
The patch is titled "Simplify tdmr_get_pamt_sz()" but the log mainly talks about
removing the loop in tdmr_set_up_pamt().
So, how about renaming the patch to "Simplify setting up pamt calculation for
TDMRs"?

> > > dropping the array of intermediate size and base storage. Just store the
> > > values to their final locations.
> > 
> > > Accept the small complication of having
> > > to clear tdmr->pamt_4k_base in the error path, so that tdmr_do_pamt_func()
> > > will not try to operate on the TDMR struct when attempting to free it.
> > 
> > The clearing of tdmr->pamt_4k_base was dropped, so this section is a bit
> > stale. Apart from this nit,
> 
> Oh, good point.

With those nits fixed,

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

