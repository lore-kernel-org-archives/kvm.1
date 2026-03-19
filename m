Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689337BE96;
	Thu, 19 Mar 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912960; cv=fail; b=aY9vbK6HzNmTgt3727IbRgq9z79c79iYa6mJl8ZbJ18hm4tjfqEVH1R8c5LtuuPidSbzkSoKGv9nJ0NiMJ5FOn2Jtoz8KO/GeWo/ijjORtdDTbMxX7C3cbVAHYjokrYodQHKNHL+otEzfykC24/WeYRFohq6eVQHPW3DRaqzqH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912960; c=relaxed/simple;
	bh=/l4QsMaWqBNxo9QnQYsnTKCWl0P8PbokUvG/Bfo+sIs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1Ixo2zdgw8WbQAVBLAOrCcOHOldPhbkbqQugEizGcDfXyIO05Aqlk8mKFz5nW20w9+GOtK54TvVDy5KpnyMzxYU4YnOWSws85f6kQo90dAu4U6HpUpRjwJpAI6uVFbTA9UgKqgkTjtpC2U/1y3Vq1cVGbxVuWP4AY9bYKsiekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/+oMa6n; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/+oMa6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773912958; x=1805448958;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=/l4QsMaWqBNxo9QnQYsnTKCWl0P8PbokUvG/Bfo+sIs=;
  b=e/+oMa6nTcFLbPqS55NpBL9KtCA13A+esKj6Md+BKO4hECIr6A+YyTkI
   Ct5zKQ+FbuGtlIjImO+Xw1LKso92vIUNCj4EfjT5GfMagEgrcXj+yOto8
   0WZCouRuvfciY76ckRpjsWEiEX3qaFhkkTY1LeUXfM66ghD8GPvftG/3L
   eXO+499MuhzRjOo0VZOKbngds/ZgT43YTstpdcWI0gHvYCy1SHwBiMIEg
   KJb9FrHDuxAHkjssCNNFOEA3DoWJMjV0Z2Awz2C+I+0Esj0XveJa0K9bL
   s5jioltidGxu9VVG+tKYhAzPCodML6j48D93a3YX8xjlBtJkJoHb5nqki
   Q==;
X-CSE-ConnectionGUID: E94R8pQgSBu41GN5ta7Z0w==
X-CSE-MsgGUID: CifdqAvTQ3ut3u6Y5zsqqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75164435"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75164435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:35:58 -0700
X-CSE-ConnectionGUID: +bayd/EFSCy2f8b+kJpNWQ==
X-CSE-MsgGUID: gouaWUOgRJ61ze/VajqaHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="253388042"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:35:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:35:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:35:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH0oZvc3jYRmnulH6HmXkXZD+xOVJvgOYmp4thJ5xI/dLXJpccE8zP1Q+8H07Aaiuy/U8YHaRMCuzcTRP/EQZ3Qm0K8C+SG+VQJgeeAEuHRhNk8U9rgzxdIYMw1aHX/vi83xfpJjA3gKJLr26KqdIdW+1SrrzQVJIEXsFm5wFVLp+aSQayF+GU8IRWXseZfAq9vH2cZpyssmXIgTzDVuqvEvAY9nT/AKkxWgFPDB5AbuJFx5z67WaAcc/9Z99FpU4zdLqWg146kAXZY4hXZ35I23vb+w5tYr96tHXyH/dVVuoqGRr5bSMt5BOjD7xRBDJD0ZAZzu+EMjZQEQW5oe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1gpQZP/Lb67qqY4LxgAtoxIgazHR1GRJGvsb6K92TA=;
 b=FfLC5AUPFJP0PpKaNn//6ov/1kluUtGILpXOziTpn9vUznTPeECBvwB2VK9aVd6a1wQhyH5gaBVdrPrB7Q/R3+F5Wp/N9suzbpYDwevu3c7tBNF5ayzLfLhNEl7OCS1BjGbF/tvRIq2ZmertVKgow/H1ErtYzh1OTt4yUSBVvnOOWl/DbQHkfxzYHrDq8VJLjnAwrHyALYqMtnkVrnJli2Otrea8KnrVopSfHxL6ewTvuZlBOm4bOvo3pN7GC/DEvJ6vWlEl7IcWmsKbK0zVNQ4bcAj3MCETEqbWfXHn/5KgOWt4J5QOheTkx0XkL4WOaDjlP00MVzt7SunwgFsv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:35:46 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 09:35:46 +0000
Date: Thu, 19 Mar 2026 16:56:17 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <isaku.yamahata@intel.com>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <abu6MVdXar3MmTdF@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
 <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
 <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To DS0PR11MB7457.namprd11.prod.outlook.com
 (2603:10b6:8:140::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SJ1PR11MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c5a792-d2c9-4a20-8d41-08de859ae4f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j5Pvrkw3Zg5D7lrE4B9BggDA4ugTOIiyqv/AhsS98XcWQ2XZzGrQeJqeGv0B9NdOjr5mtgiOKwhwi92E3Mg4FwjphThp7YebN7CTcia81SSfYnV2I58KFuGNoAxwXHDRQzRcCuOG7j+7/lxBgOhVEQUsWPGM2gmX/R3Kfihe3HLwGRU1hr/FAD3IL/YE+yujAIaII1x89YSR8uJWX9rgrLtyto9cRICgtodGA7c3JH6fUBFHIXNiwNWI3NUzk5GkUdOSeZNzZi9oqac3VBWKcjqLfrVpTwc9hmAEXh+dJ3wLOegAAD8w/HeGUb8D7v5EtGlotuws4cqwqufJTGLKzbwfzY9NQ7l8Qw1sGf2Porco+emT5///IiZeTFMm5IU7vLEwmL5SBXcM6hDw36pOoypz5r9e3zAU5BfzMLakpDcXzd9DAoAqBS5t08Es41ua7akKLOvNkRVHAyIJPGjXW5yGmLRARub0JQCUCSCcH8MFm27ZN97Og/D1Mkk9EVmCW5VJf9gCQ6NS8rTsBFxGFzaw8TT5PRNgxS45p7SmMECjtvIlnovI4BomtU5TNdPXL4itFOlvBdrUZO7AVQYOQl4hgHPk6DFsIxBh9FFUy+dX8xvoXFKsWb4/tiETT7MLHedVA2y9f7pX+aD+ZlQ8/tYfrWxpAWzSQnmuj0OBNOtS5RIjgnSlWgDeO1SxNWo5igkb8RPpmnSCdnYt3CNsyep5atkEiwp4uve2lQDMGTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8iB2aRpg4xpnMcPfI1aX0/LklT0BiJjEXFvY0d6d0G02QKGSrw+FyDy5S9Z?=
 =?us-ascii?Q?Gf3R8+sBtFGEhucMsSn3cXDc136gn4R/Zm81NwgfVc75e7MKlXs369ud03tP?=
 =?us-ascii?Q?LKbzPFGEMVZUbn7ATeCHGT5NE+JHBf5E8g+DuQ73q7uLAl1BPGga8r9HDN8e?=
 =?us-ascii?Q?ufpHUv6oeq3eUj/qsyUv4yK+vL8Qd6KaLnOyM0qvGVhiV4DUlHzKTEXLEE5d?=
 =?us-ascii?Q?IEM/0UChn7aci2vsHR+Mi21GI1WsLEoLxYsZYbvOnnSBFRCzo9qCh/7+F6Iy?=
 =?us-ascii?Q?9famYKYFxojMCBU5I1rkVsMzVDOgIq+bgcaCMJOJo0OXYmZZIdSn9FD3TUr1?=
 =?us-ascii?Q?U+X28agKNHPdjekpFNngTp0FlvI1WHwzOCulrUsOyiv9qX9uBgkaUc5MJmto?=
 =?us-ascii?Q?fCRb5Q1XzILfwrzPWS/ETnepfBQT67YTWicldARubJnR/b7UIvcQHbjYYpvY?=
 =?us-ascii?Q?RVmAAlxnW+c5OpXv04lPUJ/+xlI0VRQ7xitqMuZc3/TB29PLW0B62MINvprS?=
 =?us-ascii?Q?ErvvZOTlJZe2UaXXys8FAMk/CqYN/FloUWGK2hw3YYJG5XPB2hAcRN9Y0V8i?=
 =?us-ascii?Q?4NdMkrZPpan9r437hHB88rkUdpsI/KhTeapNljPtbjh6dza06h7aemCLuRck?=
 =?us-ascii?Q?OfKH37OXFtMGZ9ldN7C3oae22WHx5wpHs5nFAkv7jTbFJZlH08RoSK+wmoiE?=
 =?us-ascii?Q?hzQoOzNK3ax+5mpXFfT3OGTaV0UF1pCh3Z/N7bgUeMF7BRqUcjEt0Nxjk1Ap?=
 =?us-ascii?Q?7mWkhCSljwCc6tnbLXOQ3WSys61wSiw2JyJAUSF+kbfhA1+KdxK5/oyLMPOp?=
 =?us-ascii?Q?UDF3MLMBDx8fDOoPNQLpkkbFO7muq/VqrE5g+bpXiWoSTRWO2XPLlvGr0ECS?=
 =?us-ascii?Q?R1A9A13txMj0Ev46lsDcBATmWmV7uA+Rnxq3nYHePQsKQXMb4fCD+ZWDNZM1?=
 =?us-ascii?Q?uHs4kwE50GA4NUsgjflQ9ekM8n3Iu/djfVx20zs9nlce9ObMm47TRQTtVhRy?=
 =?us-ascii?Q?NxST6ehtplIh00FqJRqVpGWKm2HL3v7iMac6D9ihOrUkgDxhBwKs9cKXs+3W?=
 =?us-ascii?Q?tVQSaSaJray96zcIaXbK2MR3qZqsO7a2Z7P1OHuuCXR+HgqYlK3TKelrTmHr?=
 =?us-ascii?Q?IgeincAgBcvaqF3kFadR7sQBE/k6dP8s/iBaJQ0Cu/jZjz2OPAUNn+D+psaI?=
 =?us-ascii?Q?k+mRZXb19NYzCtUOsChwbKcp3Dm7PHnW21dNAj6iwZMHho8vTBKlzY14wgt3?=
 =?us-ascii?Q?CAiKqSGJ7rLlbLbDRy6U7TNx1KVIyKGAY4s4Jg7iR0TTAaQqGG8FMTtFxHhi?=
 =?us-ascii?Q?gdj3lSaFHjgPC4e6igzSt5mTbjGexYElf/KeWX6769OkUS2/1xuMuvEZrCUY?=
 =?us-ascii?Q?BY8sMEs4CXf5pJC/IcnHx0Xb1/pxqLsnDszTPIaiSBWFdn8nv7tAfruWpGQH?=
 =?us-ascii?Q?q/rG4dD4IjSsnoZIgZdj6UoWi2GFrwqV1H0ILMpumrJX+Ra1ynwLur6LvWh5?=
 =?us-ascii?Q?CxosMvhbAvnnoA0R4RmgwPfFOKjTGKBJ2pL+GzHlwOFmgw2JtxctbCh+pIMY?=
 =?us-ascii?Q?C5CUNzuduwOT7oV5rdI42XC49i0qD9IwQ2BFOz/W4+rrVymzCDASn3mBErRL?=
 =?us-ascii?Q?6TN2wtubDMYmKG9i8fJLVHsubH5mrzOICeuj5TKG0tpb0tHctVkZcpfOEah/?=
 =?us-ascii?Q?+hJB8cZ0/FauPn919eKEyeYjj88WmQRYu0sSRmyOvAHXpHasVlEX+/64HtHy?=
 =?us-ascii?Q?n2Tv2QIN+A=3D=3D?=
X-Exchange-RoutingPolicyChecked: PxaLv0/wg3Eitrlog8iPvKfsoQkgPWFEZQesJ1QWP9Y+F8eWaXugsMDOOGMJhkVgHPJIira3zgeP7VLisZ2LkCTe48+ZiRfR9wb9yA0AX6pPydJ/135Gcb4PB7p28UXBnQEW3hjtsExofcugRFZ9tCf4b611KykQ1GeajJzhWrOQnoqbuXwjCm9BZ9w9AfAS+/Wo/1B+uvlTzCSheY1V/VN6OyFQtXhIjwPlR//4DpwGmUI4L1F3NW3N2lc6nL8bEiCm6KWtxXcQH2xOCPp04ux59qdRdnscKjm1ZlDVRRf6fycvGvTkP5mBsbt1Cwv4npf8Jm+FA3Dao8ncNB+1wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c5a792-d2c9-4a20-8d41-08de859ae4f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:35:45.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBrdy7PG9AkgjP+8h0GLcg0GHXvk8agM17K44h/s4CcOJZ/vPdbEakcLcR97J5YwVr/NIX9YTDa8Rmv26vtiIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 04:56:10PM +0800, Xiaoyao Li wrote:
> On 3/19/2026 2:45 PM, Yan Zhao wrote:
> > On Thu, Mar 19, 2026 at 11:20:48AM +0800, Xiaoyao Li wrote:
> > > On 3/19/2026 8:58 AM, Yan Zhao wrote:
> > > > From: Sean Christopherson <seanjc@google.com>
> [...]
> > > > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > > > index a9dd75190c67..2f9d07ad1a9a 100644
> > > > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > > > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > > > @@ -730,9 +730,9 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
> > > >    	mb();
> > > >    }
> > > > -void tdx_quirk_reset_page(struct page *page)
> > > > +void tdx_quirk_reset_page(kvm_pfn_t pfn)
> > > 
> > > So why keep the function tdx_quirk_reset_page() but expect passing in the
> > > kvm_pfn_t? It looks werid that the name indicates to reset a page but what
> > > gets passed in is a pfn.
> > I thought about introducing tdx_quirk_reset_pfn(). But considering
> > tdx_quirk_reset_pfn() has to be an exported API, I'm reluctant to do that.
> > 
> > Given that even with tdx_quirk_reset_pfn(), it still expects TDX convertible
> > RAM, I think having tdx_quirk_reset_page() to take pfn is still acceptable.
> > 
> > We just don't want KVM to do pfn --> struct page --> pfn conversions.
> 
> Only tdx_sept_remove_private_spte() is doing such conversions. While
> tdx_reclaim_page() and tdx_reclaim_td_control_pages() already have the
> struct page natively.
Unlike requiring KVM to call pfn_to_page() before invoking guest private memory
related APIs, Having tdx_reclaim_page() and tdx_reclaim_td_control_pages() to
call page_to_pfn() does not impose unnecessary assumptions of how KVM allocates
memory. So, I think it's fine for them to invoke tdx_quirk_reset_page() which
takes PFN as input.

> So why not considering option 2?
> 
>   2. keep tdx_quirk_reset_page() as-is for the cases of
>      tdx_reclaim_page() and tdx_reclaim_td_control_pages() that have the
>      struct page. But only change tdx_sept_remove_private_spte() to use
>      tdx_quirk_reset_paddr() directly.
> 
> It will need export tdx_quirk_reset_paddr() for KVM. I think it will be OK?
I don't think it's necessary. But if we have to export an extra API, IMHO,
tdx_quirk_reset_pfn() is better than tdx_quirk_reset_paddr(). Otherwise,
why not only expose tdx_quirk_reset_paddr()?

