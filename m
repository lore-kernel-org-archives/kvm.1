Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE2327C09;
	Wed, 14 Oct 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941601; cv=fail; b=JTFqcAVDcPpJXEEEtWQ6KohHLG5F4A8RrRXp4G9Ui60Z8twkVF21GZiweLMihIRriKyEovIO/1hs5L4CPZF02I2MqhLCGOgMQjtDCJZGA9hv7gRrrj0CCs+dzgmbfO1yyutLZmJ8dvTeEFnR0w1Gy5UGLkUbnNp96fApM4dB0As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941601; c=relaxed/simple;
	bh=NspFBGuVwZLcmrGyn/Ak6DPB1vHdBUsNa+Zb74RGceE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LR2uJs9S6R5u102QTSOVCrKIf5sN7Nm0vUYemOm7rbyuUAwAAiYzFn9R/vR1pAjaZidebzS5cYRdmbCcMu22PUUxURebiVg61fGSGK3oR8cPDjIrDZDcIdZ3uekm6I0y9nwBrOdzf6BOGdsGRUMF5QlXfx3bSWVTEZjydSC5VXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6ze02lA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6ze02lA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791941598; x=1823477598;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NspFBGuVwZLcmrGyn/Ak6DPB1vHdBUsNa+Zb74RGceE=;
  b=Q6ze02lAxrqX0zADG8GFIly6FV5x1vV0nhYfIKd0M8OBAUDO24Kec7s/
   JGLPTFWDj3JlCyDUOdvLEM+evAMXNHd4eL50y2pQtSu3byNzrnPhbsshH
   XRSN1HtzKu5on1K4IjKediEswE6OdNJ9DTs3s43jryF0JE6Q8XKm0Jc4C
   U+DE0koJN/vYZGqjmfxdTPAlJOVgJRHizwHAr1OO6eMKUMMnAneWrWGh8
   mQlHgQ0IBAXpR0r66OoB91n++VKSOiyI2ZD5DzHFdfTtuIFEOTsEosjz2
   yRKuPlyQYM2rV7zkc9cIh50bv4M+c/ULhMYJQlyPbDGUYtMgMI41mjeoX
   w==;
X-CSE-ConnectionGUID: tdL3PdfsSeugZ4Uw5msy8A==
X-CSE-MsgGUID: LXsWcu9WSVGVSOn/BsXfKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="670723"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="670723"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:33:18 -0700
X-CSE-ConnectionGUID: TIA7ZuJNTv6/qJ9WrW0Eog==
X-CSE-MsgGUID: qeEuDT0pQTa1Z//uSjuuHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1402206"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:33:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 18:33:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 18:33:17 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 18:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taleGzU2ao/ZCjeB/+B6P5vshSUimIT9VfkKMNZUoxVvpYEVTgzHTWUazhoGX4xo8VF+KGo//S5lMz6Z4yJduKacG3C6b+9B5k96M8GrHZOcye3zQo82ocN8SueVa+86fYvW/+dztCWhcaM0AQqoxq2ZVQWTm1FMhEIZUEAluYpnziFhPx/Pp9QL+CJbv0b1iCKtF15BYVydZzQ9OOn1cXxD4G1UKrk+tRASg2UJoPMNPAqSDMd+oBDY+mFGDITbOtC/pWcMq8Pd1C1yo/MQugHlX55WllhQ+FyUUEjWbNUdCOTKvjmtN57KbvvSO1mqCDhYj4YVp4KTuYBrwb2d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROpI5hrf18HQCIjc4HqYiaOX8zeqMlSxygh9xKpFFnY=;
 b=uLRwM/UVfg0mN0nhNBeNc97ZsiZaJpJSORxAjhMNr4ohGkD3fAWqMu593lDZ7xbaUcDJQWaupF5E8yTZmhkofo7Bp7hkwgOcAb5k0FUVNMDDE7iIDIQ6uSLzj/EqTebD9i5/eB5um/Ealk4vQglBkhdoeL2kOehaylfnp9cCVL/M/rsSwe2EV95IgSenvYqplfKFn+5rSLaMiCDsAuynJCAwYK3kd0aJaaNdb+AKSiuVmuMvXqdAnuicYS9ue/JMaWfPce02fct6vbiRvWWCm+5DMXDcbuqo4ABOjUe0h77Iv9UWdLgD2k2MQVigtyLJLMhfbQw1ZKS1wo69XzXVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 01:33:14 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:33:13 +0000
Date: Wed, 14 Oct 2026 09:32:25 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2 0/3] KVM: TDX: Syntehsize SHUTDOWN on unhandled EPT
 Violation
Message-ID: <as7bqemBwT1o/Zk9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260930001127.3170009-1-seanjc@google.com>
 <3c0ee89f560b0235f293b32019327186785aa795.camel@intel.com>
 <arxd78Pn6WWL6TGq@google.com>
 <asdOF41hqDpycXKU@yzhao56-desk.sh.intel.com>
 <aslVXBSovWuAsNtN@google.com>
 <asmjItCkW74Z6AV1@yzhao56-desk.sh.intel.com>
 <aszdjZCNWdIiXniC@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aszdjZCNWdIiXniC@google.com>
X-ClientProxiedBy: PUZP153CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::8) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4f05f2-dc9e-48a3-361d-08df29931d15
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003|6133799003|20046099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6RoXZ1atUybqncymyGASh/z1gKgJWhu3BQgcaNE0cCxnNIQ7W9JOY5hRkpSCobyk0BUsx4cga+1tV8Leor/5fewWhsfJAJyUnv+NF5SkZjxG/yVKnJa1TkohjoB7XL+vxmQSkMEiRiFYfURD41MQWz37x+yNv/FSQZLYqRcildRWoZUA/2NM9yukrLBdfynoQwmGbJuRrp23TD5fR5ajQ49Z9ph1iLAM6MI0w7kaG5WZl9omkK5HzE5vgkbhlVMZp6SaM3qCLxc0incv0R+E/8fgxfK3exJq8fR1wBuVojnd46+npT50B1dpJDfHlQ5UA4Pr6pFR4b3MjXJ6j6vE3O8z1bMvswQClvped4Q1YKoxduzi60SST9VRNKv/5NOPkNV9TSyLxlv+DYu7jNxcvNJ2cUjucU/5t+nqJXkAdg0wKwXV0WMWMuY8yyxJ6FBgJTOUNduD3LVUIthGkGizVUI00oVGoBRb3AN55NjvwD6Id8uT4x9qPdUaIZUumwetD5047TPxA7mN0aFDYVguQjM6iibVsLi6HVmBrlqUTGFqi82BE082LaflE+JWBEELDFP5P9HVIY8IOPqlQHTv5q57mbvnYMyeEUFgLSk8JTzPk2RtHkZcoiPt81nBw9i0a0WN3Atk1Azmx7t+WdbTGNizRDKhF8Se/AQNw6xL/Nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(20046099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NmI4OuBN7zi1JJV+UFzquX+gYxGLDNKd/6ZlH7YQxpJOpX5Qu+Y00av1bm?=
 =?iso-8859-1?Q?xxTC+ZScS3p4LEXxFQwcbcHW2UOCJNE5/05daSwzyrhUT8cUMbS5Q2fj/0?=
 =?iso-8859-1?Q?K7CVrIOQ28/1xrBRw4sv24aMGjAH71jfdXWZGuRC7Jz01mx1ZyJKrhJKod?=
 =?iso-8859-1?Q?tTmnvrJG6oYuPmYSGN9/zHxMjHbeAx+R7wQoBlHsCnA8rq6ltIeiF5Y3c1?=
 =?iso-8859-1?Q?5PAxkseIKSuPTel1rzWU4NCXzSdt7qguRiCBB5KcCN2ALzyg5hU4Q6B6Le?=
 =?iso-8859-1?Q?3bXzi3FS3HZsM/IxrmQfNcnuUbOnb+PnJ8Asa764cMwDs9i9LUqby1nJrS?=
 =?iso-8859-1?Q?5zZPSBObx7OW08yCb17jLXg1Mt9D2wyDGIvx5qGSwOjsltHnhcGccGCE3u?=
 =?iso-8859-1?Q?m2/WDWxgHpnro47MepTBIRVySCJ2APdVase+TYAx+nuzpCuT5/RkNu+zWm?=
 =?iso-8859-1?Q?+YKeIStUMmyTLK+rCogZsVx5wRxRi/rCUBgYPbgc1wRJE2LTlDoUulkz/C?=
 =?iso-8859-1?Q?Hb4mlcbY979r+b8NQQ7bKZYPe8lCDFwpMFKUcXMkC3HaNVzB/MCppAxQRJ?=
 =?iso-8859-1?Q?TkUyWzswtLgshxEDYHKm3x9ZwdSVvdZyusTvh868p6GyHJBuOl1KNTe1k4?=
 =?iso-8859-1?Q?nQMKHJn3ioeM9AwzjbBvBVlKq5QKNdU+DqBq1HV5jjN7p9AftiAAwTF0T+?=
 =?iso-8859-1?Q?rpE764zpLHjD0uHF8jD5t8CgPmH+fIZUAT+auy7TfZR1i9Z+W86MdIAISs?=
 =?iso-8859-1?Q?tFpvL0y+/PMQzGf9m1E7HiVX4Z5hBk2hdV36WdCRw9/vIt3X4ziSQDUvXV?=
 =?iso-8859-1?Q?Sus6LR48AvaGwyHHsDUQbExKhAswqlUeBxNg7uQtmuvySUXI0hBQZCx+AA?=
 =?iso-8859-1?Q?KWUUmEAZE+6C8SjuKysnGSOg+s1oQ88l87TMCu2U75acVDPDwpQH+5ofY4?=
 =?iso-8859-1?Q?M/h09VcFAAY10h/eD6IgM56wd5QpkqQbRGgTXzBEM2bx579b3O1yWtNCsX?=
 =?iso-8859-1?Q?M7m0R58EMRfaf3XBhCGMdEu/+OhH9UczxfK3mxrjk/nZpp4gfAKls47+jO?=
 =?iso-8859-1?Q?hzr3NtLjUw+HoEyKMLpg0N6LPJSihf+1B+4JCYbbAnmyKfE7m6Mw7RB6Xh?=
 =?iso-8859-1?Q?DsjdeRKwi6jTB4wGfzuuGDZYoCfzUjKkrPtgqVW94awMcG2NtloCkm9O0U?=
 =?iso-8859-1?Q?bewbmQeao3HrH8/EFlf0jLYx2rhX7Jnzo08LKpmdmmzwNJWQwrbp9qfzst?=
 =?iso-8859-1?Q?yDCWRWVH8S3+Ba3z+QJpmtIpMcu259wdlkG/m52B042P4t7L1rJpIutkGJ?=
 =?iso-8859-1?Q?7O+U6nIG0W34RcI4ugnnsYxBbi3dStMIAdF8P94xdPz6iEtf4kTxzhOMmo?=
 =?iso-8859-1?Q?m1kaPlR5d5lJQAgYcRgoYOkcC9ZdL2dmyW1eD0TYVtS//3zfTRWV9VOrZK?=
 =?iso-8859-1?Q?0vw2DMFHY7QaSA7b1ZiELsYfeG/aRK/i2sC5c7YVqrd8HrSOvfUWu1c2Sl?=
 =?iso-8859-1?Q?jpDEuQ3+VyyF7fmQn53iMB9s3YKAAFEqOV82ldfQg+aLu1/XZjZivJZJCs?=
 =?iso-8859-1?Q?KXx7R2kn0u2UqLvi0oAR7evvFe5y00hMrdD+Qn4WlAiak/KCZO5hhpK774?=
 =?iso-8859-1?Q?CXCIlVxA38f+VIIMfS7fdvIsJUDWbGYv5BZQm7oQr/DlH9JM3jxqM8zh5T?=
 =?iso-8859-1?Q?LBiHEBupX9b9mQsbGjv9fsIM47cDD1M1dCMhnfDskBQEpjiJAVW6IWejvw?=
 =?iso-8859-1?Q?mUcRIC0wCy+RabzXyETzhlx0Svg9xqbcIwH44+Id06ZlxC0s6krEtjMFCW?=
 =?iso-8859-1?Q?i7g2cO8tgQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tosh2gsOPtYoVBMprcoIlIzsvaIJzUmw+E9MWKYTyv75xZfDIS84EP4CUFi3XDtHpDquN4ArRjKAqDIHLMuEELQA6WJUWghJmNcQIaNzajOPb5KjYyXSexxwvpOgaCn6Dhofeh96G/HZpzO1oYeHkQx6Ohmif2vfrTEW7wRcl59lR4DlbfpaHH0Sake/OGVnibmJSkDji5+cMteP/6qgb/KbrXXlmbqLpaWOcaerUegXU+mhp4cvJPsyrvEJ5iQv0piqWa8zcAdtzqKDiy4IKn7tgXcgrG4G+ueliyHpB1wpHjsnDGtdURLOdkGXzJhJSEEe0E5fH7EUSeCLG2iQlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4f05f2-dc9e-48a3-361d-08df29931d15
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:33:13.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHUlAXwA6FUCXMmdsvVWk2nWZ355UjvGlsXtQPwbppwJQoPhTlz2sLCVf8tRCeGS426iiJoA3oh7OyzkkDCsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com

On Mon, Oct 12, 2026 at 06:15:57AM -0700, Sean Christopherson wrote:
> On Sat, Oct 10, 2026, Yan Zhao wrote:
> > On Fri, Oct 09, 2026 at 01:58:04PM -0700, Sean Christopherson wrote:
> > > On Thu, Oct 08, 2026, Yan Zhao wrote:
> > > > On Tue, Sep 29, 2026 at 05:55:11PM -0700, Sean Christopherson wrote:
> > > > > On Wed, Sep 30, 2026, Rick P Edgecombe wrote:
> > > > > > On Tue, 2026-09-29 at 17:11 -0700, Sean Christopherson wrote:
> > > > > > > Signal SHUTDOWN instead of -EIO if the guest accesses an unaccepted page and
> > > > > > > has disabled EPT Violation #VEs on such accesses.  Returning -EIO is all but
> > > > > > > guaranteed to mislead the VMM into thinking KVM (or the VMM) messed up, and
> > > > > > > will likely result in the VM being terminated instead of rebooted.
> > > > Hmm, it's by design in my previous implementation to terminate a VM when the
> > > > guest accesses an unaccepted page and has disabled EPT Violation #VEs on such
> > > > accesses, according to the TDX module spec:
> > > > 
> > > > "This happens if the TD is configured to TD-exit (instead of a #VE) on an EPT
> > > >  violation due to accessing a PENDING page. It normally indicates an error
> > > >  condition; the host VMM may decide to tear the TD down."
> > > > 
> > > > So, for the initial implementation, we chose to invoke kvm_vm_dead() and print
> > > > out the exact reason as a hint to the system admin.
> > > 
> > > kvm_vm_dead() should only be used when KVM *needs* to prevent userspace from
> > > running the VM.
> > Ok. But my previous intention was to kill the VM regardless of whether the
> > userspace handles KVM_EXIT_SHUTDOWN or not.
> > Did I use it correctly?
> 
> No.  Returning -EIO kills not only what KVM sees as the VM, it often kills what
> the end user, i.e. the customer in our case, see as the VM.
Ah. I see.
I didn't realize it was seen a bug. I thought it was something we could improve
later by returning KVM_EXIT* instead.

> > I'm asking because you added the Fixes tag and "Cc: stable@vger.kernel.org" for
> > patches 1/2 as well.
> > 
> > > > (Previously, reboot was also not supported for a TDX guest).
> > > 
> > > But QEMU isn't KVM.  While QEMU is the de facto reference VMM, it's important to
> > > keep in mind that it's not the only VMM (and that's not just about Google's VMM,
> > > there are plenty of other non-QEMU VMMs that are used in production environments).
> > Hmm. That was the reason for me to choose forcefully killing the VM inside KVM,
> > since for the initial implementation, I didn't want to bother updating every
> > VMM :)
> 
> Why would any VMM need to be updated?  VMMs already need to handle KVM_EXIT_SHUTDOWN
> for TDX VMs.
Hmm. I knew QEMU handles KVM_EXIT_SHUTDOWN, but I wasn't sure if every VMM does.
So, a brute-force way was chosen :)
