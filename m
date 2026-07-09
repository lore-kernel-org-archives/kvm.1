Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BA31B100;
	Thu,  9 Jul 2026 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567098; cv=fail; b=n7ZjS5aDGiE/o12JOtc9d9yXeDDBUAfHtHH756Vob/0utuJlnJdlo1W6lOzwLDljo8g5wFMRCEwPc5knzpdSrTMF/iLoiqeZGX1XF9O+K7oqxGfw7+nKmjD7n+0qWBN43hVYCGb995bYGKMkMDz7XXY2dkoXbR3VnMrWY+5ewhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567098; c=relaxed/simple;
	bh=9EJaRHNlFioHRIJKGJLFGzZKogSzwyZRoMGvHul4vzs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7XgFZUpyW5CRsTSne9d+VCKE95NjgBeBZD8qlxXDYdY9YjK8VpCe5Xj/z7P4/TlHs49/vuomIJWT0fu1l1M66TxF0KX5zM0qRnpyd7FxdyefCvcivElSWpyHI1gAFm/9hpHifi+wZyVr9d8PEv7tf5QOVaOUT+82mVcnlVxzhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bopOsfPE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bopOsfPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783567096; x=1815103096;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=9EJaRHNlFioHRIJKGJLFGzZKogSzwyZRoMGvHul4vzs=;
  b=bopOsfPEgNQ6s/uM3Lo8WHFif+78I+km4L71RdWMWht5DEjGlD6BHXRV
   8HrIf4SK4VcsvsKw+rVTu7RtTZAQaqb1QsnEdG4xQdKzb0dNo7b6ueA+q
   JusRHqNpcO2DimBR8DIa1ayiM6ANpf6EUnZyKPmFvuELjsl/v3kQp3gJ3
   ICvv3T4PKR9jtIn8MxB7puJSfOnLsAPBF/xg/ZLPYiTxNeDt1+oPP2IjZ
   JcKZAnR+HpBXhMtfGAcNA7q6zG/4OhJO+oqSM6pFCSPOOGnZ5It/tz6u0
   /rC/c0cdnSIJsU+0eHbZz/N2PzMvHbiicPJ3Iv6OznOlyQ1OB/TNOMjlf
   Q==;
X-CSE-ConnectionGUID: aizxs12DROCBmwmzOZcPEQ==
X-CSE-MsgGUID: W4Q8ciKCTN2fbQqjp8Z66g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95756412"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95756412"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 20:18:15 -0700
X-CSE-ConnectionGUID: a0GkMKRgQFy0EpotrZ2PgQ==
X-CSE-MsgGUID: 4tGiXFSmReWA/czwJlDTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253977218"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 20:18:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 20:18:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 20:18:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 20:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozs0CnAHJ4agYFZTzQqXkG5HeA3kFBzmK5F1SKG98Jo1PJB4msFUUk641xPViMsLkcML8VVfDI+19p8l6nNHoGDcm1MqS50YY29rC7YEeVszr6otSKd2hkkmXC4zbbqUFYcNZIcu+ZwIfRqm9pQQfy+4Qgd25uJZO2onPeYdVkaq03JXQAxaFP/+T6sL83jOz6vDDUs/1lQ05YFhNnQ18Gm8/+hBrJ40oUBuiKr1ACQp/uXFFmuYzB+thP1WLNj9BBH8aUqQYR55zPOJ3X8+C0k09/nGkxfUU3C5b58dcyodDrqZLKN2cxIKE14YQ0V1w7qpZq2BAoDyJAFXckUCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fZwtt0Wc/Fz0GlAqQWLPSWUQVPGSYkQ/mEf9t3FgZM=;
 b=OktqxbpfUt93lIs7b1r/g55AsCmez5W+7KgOUqLf4Nx0l6tqhiOaeiG6X2W0Eab7E+XILyz+XfBStbotNSXR/a8w8cGmB4wGLYlmL9sH9OCJA8zzsWqZLKeurb8qTyasJePLOHv2Yu/4ck70ilUqrpZ0tjzXXpChkqU/+K2MImaDsdKPh2CBqYZURoNW8DmBEad/ORhF1ekgQu8/YpdQsGmEWMJysnHMnSYrydz422MkwpEMXO68xEpUuwvgiZGu8dKECESxr7lmaqTh+K4yYUrUwVAJ+sdIea+cUvW2/O0HFqgu/LCyaAEoMkAlIv3woMXJBmQkxlDdVc/Krngs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:18:06 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:18:05 +0000
Date: Thu, 9 Jul 2026 11:18:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Message-ID: <ak8S6MiMkCEgJcP/@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
 <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
 <f686c26073761302b699c7374b668c933b0452e8.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f686c26073761302b699c7374b668c933b0452e8.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce741b4-4160-4aab-b86c-08dedd68b172
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: occSzztwzN/o+eO4Dks66IwhF5FUL6BJgEgbik9j5j2wL4AFx9rorH+UkEmumuu0XCZk4urNV1liLmk57A8SeCZpVzMQyO+lbnbZcSdAIUiOAJa5uYln4b5V3UskIgUaTychmMvZKEtKXT6sl5cTgn8KpfhAq5Aiyb4CrjPMo4Fp82+hL8MTV4VwPycNSDTPx07FTOF+Q7vQLuqcpSPvtZBnOvm64mWCko3ZSG/bVioBj+0Q73ppyTbeSZLrU/LsNo/IG4TJ0K4tCaR5MIX1741odZf9QWu1cHe8qM/Bia2ojDR0M4sISm7W6HzrHEshCPaW7YlD2qfU5USwpioEndYM0BEkau6JIvvstZDRHEo291RsMGHPahXPhHBxdrepCjew36VZ6fB6Qu8wGCqMySf+aY/MbHckPg7YjybHjK/uYLzZ1FXhYRkE7vlKCJe2axmiuI6r6kKekEuowuUnvnlGACdL6nmTeKHdHEKy8u4e5wydYmL5Mxr2z1xxGcP99vYf6d8XJcDwtnWUagBUA84pbqcEwIfCm6XGukHWTaBJJSY6L6jtbpTN6aWe5UpUvODYwMEL1EJUo00oBi9SfP5gQn1gZbTP899pWgqlCk+u1+WMJ/9j80MKYVsNuJ5voeb83TglYJRYurtmuqordB6uEpaD+rhQ9jeVMS804Qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fP/qPO0UvaH3b8SwAnHFTyYjQMDhd8Au2lSY1dZTmXLtQYWCBlLDyBCycN6/?=
 =?us-ascii?Q?TG6k2K3A7H3OUQb9v14Sa3RFwHFpXQe5OiaHJtUSPUYryxOjPyk1oLbY2vBK?=
 =?us-ascii?Q?A1xIowVYTtdJ/ydPtLW2GXOTP9JU6ew/yAjsUQ8IT6YLmyF41VsyMsobI7tJ?=
 =?us-ascii?Q?ZxmHcpDKs5MOMxirg1xHL9FJQJVDZnsXN6mZOiA6dX8+TPfq3V0d4W+qHoab?=
 =?us-ascii?Q?Z1lencqF5oxelhjnrkAVLsxTTcX+l9ywWQG9N/HexTPbWlW2605IzGg/3eom?=
 =?us-ascii?Q?6cfu335m6r36AgzKPVoiKc75hzWq3/8PN0nD+TZZ1nwpDSK6/DTzxXf/oLLk?=
 =?us-ascii?Q?r/uAMmgbS7bVewDwFvAhXWmN2HbM+dpGkqrNnQ6LdeJexA4mtt+bGvDqgLXK?=
 =?us-ascii?Q?pUaBybVSq5xJSawhIb566YP5e4mjEsEFGJQMjgwIb8ZDCJvBQonApG83v+aS?=
 =?us-ascii?Q?guacnnGaF4R8cJmkHjkPPLUTBvtVwKBGgSV4B5d8IIAlpyaRqS1kTJbXPgeR?=
 =?us-ascii?Q?wVbshVGTcaiDC33ygMjKRWxQ4ijW7/VoUZ0VGtHVaTDH4j1iryrq4pHeO75v?=
 =?us-ascii?Q?TkifWD7RAZ3HeavjTUpUbMNdb8mCP7AISpcLB1HMkNTG78JImdW5ExqIvFIt?=
 =?us-ascii?Q?6gn2of8/VsUQoV9BdbNXNniQcUzHv8LqNLoec4/dIhWgGkJe4Y3RV/DtPW8t?=
 =?us-ascii?Q?V6T17iV7EXm0fO8ijVHthoSUjI/+B9Zl535oXa5VApcmdR9uxKDS4MqDMWeY?=
 =?us-ascii?Q?Y8aQFB13hNRjDyI0N5CHAKYXA6eSO0fCFVKZbR9F41k4sq66sfzhfhFnTrfg?=
 =?us-ascii?Q?XFkrEH75HJI2JhuAd6Qvn8hGeSIBECcyv0gLkHHgh1fX+yDsUzhwLpHoUtTc?=
 =?us-ascii?Q?5+/fNP2HkMdGuJTXoGekr5Y+Lg4p5Y1CVm2xN31COXqm3lgg7KjzSRGUd+h6?=
 =?us-ascii?Q?mwPHC/jKna1MoqTmvrBz6fuljBPYI11JwLgkrD/DYFeN4bMHIGD2mka9CIO8?=
 =?us-ascii?Q?MFF/EX5kxZrfhALTtpkGc7Znt71ya3Xwfaf+NCVx+h6cj+q/kVOvOt0zOeiG?=
 =?us-ascii?Q?0AhbgaAw5D81tuZ9FgwX0PrdoMLM3tGM7Wk5uCZUJFNqpJ6RCrbFvCaTUMd7?=
 =?us-ascii?Q?aXD0x4MRPjEKtxckaPY6/xCOHUvKqsxvytTvlU3FbJRsaTvkdktrnqbfKYOT?=
 =?us-ascii?Q?lLjpB9aMDxG8QETDI7diaHVN1fx578OPbk/pPTSF2sfbl8ULR40s28rz4WzN?=
 =?us-ascii?Q?GOqwNak7PCl0h7fKGqjaKYHvOCFwH9FbetG/wJzT4Rs9niZoZdI09yOjHOye?=
 =?us-ascii?Q?evlCUT77pc2yzOnSHCY2S2G62mgTrVXjuxl7ivHmrQEkRFAVBMEfmqmVcKNs?=
 =?us-ascii?Q?PlnOk0qCCpN7rR2QkadG6gHXgx3M+I218hY6zA/ij3YjNSwzVpzbt500gaNO?=
 =?us-ascii?Q?Q4f8ejHzZ8SDZApIi6f4lTX/dwL9v/vbovojv7tXw2xprwSvYqnCElimtB01?=
 =?us-ascii?Q?u1F6o1DksdIrhj3DuTcixLqgHdbs7hA6wQeOJzKoGf68HT2vRhcugdKAMGON?=
 =?us-ascii?Q?D/fUlI0dEnCuX0z86tsDQnUkGQp+Y4kym/aAt7vNPTVaJsNsM4PNXW4tL7wo?=
 =?us-ascii?Q?ckh1F2Kjjn29xKOtpozxL2TPnNpX3DyX2LrpGKq3m/9KgSCHiC1QvNEktjT8?=
 =?us-ascii?Q?jIb/pahwb0IVbNPz0ZM1Ui7whFsYLphexPN7R3Z6NLlU2D7hWvyXGJzvtVGb?=
 =?us-ascii?Q?hR2PfjBUnw=3D=3D?=
X-Exchange-RoutingPolicyChecked: I4yO7euU9VL9ip9xhNSelnHa4q0blvGNPdYgKHxp7PKL0XBCH3LcjWPxSM8mbq7B7COhnWgl56JfbWqZDqU74McIk0VF1DG0vGR7oeBECVA8qxS5v7zNNO9+kuNwQBX22YLRf/wMyNNqJ01pTHoLjqjCbeIAB9g2tOZ0zVvYEF8dksuytFSWM4QjF2cV0OywUSycXUhp6djotddTuINn1i1KKXi4v40/xCjUxdP0wNjVjq4r4s/9fhBWSypOqgjfPUXGWYfXuPRdrgIoKnpkiq5YI6pFUTqZlj5XF6OkuRrFRjfnpJmOMKICre2olkDw6EciYedqqxOpwiqdoZlIVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce741b4-4160-4aab-b86c-08dedd68b172
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:18:05.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O81/E4iRbDtj2BpBoNe5A2c2c7sNlnEH86Ui/jeN+s6nF732A2T5Lo2KljAMI2fN1u9MqJEijizv5YiQjgYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 09:12:31AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-07-08 at 17:13 +0800, Yan Zhao wrote:
> > On Mon, May 25, 2026 at 07:35:11PM -0700, Rick Edgecombe wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > Use control page helpers for allocating and freeing TD control structures,
> > > such these operations can work for Dynamic PAMT.
> > > 
> > > The TDX module tracks some state for each page of physical memory that it
> > > might use. It calls this state the PAMT. It includes separate state for
> > Nit: It records this state in the PAMT ?
> 
> The text is trying to describe what PAMT is, so I'm not sure about this one.
Ok.
To me, PAMT stands for physical address metadata table, and the metadata the
table tracks is the "state" of a page.
Feel free to ignore the nit though :)

> > > each page size a physical page could be utilized at within the TDX module
> > > (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> > > allocated dynamically. So the kernel must install PAMT backing for each 4KB
> > How about
> > "..., only the backend to hold the 4KB page size state is allocated
> > dynamically" ?
> 
> How about:
> In Dynamic PAMT, only the 4KB page size backing is allocated dynamically.
LGTM.

> > > page before gifting it to the TDX module, and tear it down after the page
> > > is reclaimed.
> > How about
> > "So the kernel must check whether it is necessary to install/remove PAMT
> > backing for each 4KB page, and do so when necessary before gifting the page
> > to the TDX module or after it is reclaimed." ?
> 
> The checking part is true, but is it needed to understand this patch? I think it
> just needs a background of what is happening. How about:
> 
> So the kernel must install PAMT backing for any 4KB page being gifting to the
> TDX module, and tear down the backing when the associated gifted pages are
> reclaimed.
Hmm. I'm not sure if it would be confusing for people without sufficient
background, because the kernel only needs to install PAMT backing before the
gifting the first 4KB page.

How about:
So the kernel must ensure PAMT backing installed for any 4KB page being gifting
to the TDX module, and tear down the backing when all associated gifted pages
are reclaimed.
