Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20253947A6;
	Fri, 13 Mar 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410078; cv=fail; b=dCOi5ftHhIC8FZ3VMIwZE9BHmr4J8kgYdsgRVUKn4JX5NpUAIVIjyIuIbtM7BeVMtyIDQlQz2pqpKQRfScX2KUgwXYZIm30Awhobr3hKS4dCeO07FNQ0+U2+XFKIFsEsFkU30/sQMAwsBWK5vl6XxyiB41e/8675s+gKtZBiQkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410078; c=relaxed/simple;
	bh=BMzsn2dtq0zcGpKCj38V8jIqxdtSuaYtZq42agxZAEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8/rX66M9qscbO08OQ5Wc6YFYqe+yyC9eBPMFaHiBCZRUR1S8/gpfpGiZjro0J2d4vTRO356PhtFK8CpnpuKMSW9rZsvP9idA1UCeoFU6MRqTpJCpss6R8MvB0SXNIcv7YdfRYP6DG+f+qTo7WCLC55qLr15SFj+aR27tHWO5Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8ohe2hd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8ohe2hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773410075; x=1804946075;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BMzsn2dtq0zcGpKCj38V8jIqxdtSuaYtZq42agxZAEg=;
  b=d8ohe2hd/9ra6aLLcFwdXe+Of5BDVVqHuUiUYs0mUAr+AlMpqzI7bw5K
   40YHrm1//+CXn0BzCxz6UxSeUy/RdgS+0cEk2fs0TbnSXJOsJpcGldZfN
   4ILU7T5FUCNc1VLxs70uLNc1o9vTCthtbl/igDGh1H7SX/00tH2vGn+3t
   tPxAjKvKdrcleHC6XqWhhYm10drck00ALPz1w/goZDbIgAjKEkEiL7KKr
   aCLNJemoXbPldOGamUBWXT5rfraE/hBGm4RzN+bI/2pqJwD9oUkxeKX+R
   DUxWbB/2WbJJBEfjy4TGGbNCk8UWdRk0+cXQpIQ6K9qWbsw8JRw4nQjd2
   w==;
X-CSE-ConnectionGUID: lCtWC9Z8RJaVu/pZS151Uw==
X-CSE-MsgGUID: qI5RNlmHSXi+3SfsCHzh1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74630411"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74630411"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:54:34 -0700
X-CSE-ConnectionGUID: IIs1gJWARoCcrx4gvFmjsA==
X-CSE-MsgGUID: 5m9NLNsmQ82B7oNMuGknwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="220425888"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:54:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:54:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:54:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7KN8lS/LNToIefLJvRlcy5TOczYka2RvNLVbQ+0m/z7wleJK8LcPdrpfeZkP0x7LLL6OZqnp8QqikQaq6sZcc78dRqvoMdCaYODciiZQKfX1In1YeLJg2zG/VQivnKY2g/EHXjQqG9+RppqoUfyRyAzoxevXYmkVQvjrl3lAnfm1Rk0wep2DMty5Snvn5Ww6tZBR4vWqj25cUGhPpjjNIQkPQCm+0cbIVujbyBfEQbO4X7HVi+SFSQ/RJL8prksaf3UjyUkcjA5i8c9YBd9T/dv3WweVZIGVZ2Ke6OKtpp7/E5Eyhdm7OiZWRlPHzmOoGrYJQJnRHv9XKWoIGlBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kEDIdfv1GGS2FoMqqRyAbd1XTiMj2hyou09hn5t2XA=;
 b=hEnjtSHsf9pzTPbZT5iNphcIX0JWwbqz1D2U01A9Bk+MZ2pSLMfH9cQio0wiRPOU70mmcyp1Tdh3dCpCOM80I4VkR0pzFZ07xyITVojl8btV7kvqjwcqhHu3d8760NfIIUgrMzT6PFk+S/sSQX9hlQEt8UMR60Dp8LusSRZKob5iIzeCzuGYGvlYhByzuuyKMV5243w/Ga5bHbEz3pPf4s+ls64GU5LnKsiuE5g6C9/jV1LhQE2vs6LnOlQ84VyD7fJfUG9GCQWDYaYj6sTs9sIIh/CiDrvqa9zluXgFoPdTwcORgX1vo3ISeBuE6pK0GJrigTL7F2JCmOq+Y4qeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 13:54:23 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 13:54:23 +0000
Date: Fri, 13 Mar 2026 21:54:07 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "sagis@google.com"
	<sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Message-ID: <abQW/1Cfxl9TdJ8D@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-12-chao.gao@intel.com>
 <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
 <abLJGel27U8xuU6q@intel.com>
 <aa798a36216fb44969a6abedf96ecf1c7d4e95fe.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa798a36216fb44969a6abedf96ecf1c7d4e95fe.camel@intel.com>
X-ClientProxiedBy: KU0P306CA0094.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5366e0-000c-4ef5-ffbb-08de81080856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ppzGlrBemZ3lbElxtr6vRcNQuX6fHlUfUgiHZ5j5wVSvFR2JVILzGRxXOSaYqem1t9HxyK/yREBVjS8bkc54gOZJFIpVJ561lphbLqnOrW8uezwO776uhc9zdB56uMk0T6PJsjHwzefyhYfBV6604T70EOpjA6+NNd46BKZ4n94DJPONQeU64Lr0CJxUkNhMSZ6RW1V0PaTRMdX6RKpuB478xdaFYwX+3xAlH5WCSgj6nQKYRRosrCEb5uQIRUgJX/N22w4tIkp/4IllKYAB0dgsdodBn8iqLqsaDYHpxY/b3HVh7u7YyhCQlgqzAj8ZvVLHroHiMuYTRZsuh4V/kxn8EY29BJueKk9R7Om6812tKg1pe2LapJ8KdZEzVkILcOBaMVGPq8Sev/sjy+EaaLXyc/tTIXrDEoJ5LFv7mOJWNzQW75pUpNV/jmp/dakIS3N3Q61Hqo67fGvw80haxaJymXFqem44dLtIsOEMUOTosRNajKvliMqCXVoj9PNYEsh1+wVNRah3/yn+9m2MG73KP0TYcs3eoIRLXN14MoQHnsYP7HLKRJbcDdAOfZ+CDNZc5f0Oo72bpAU/tnMM/7WEGqN5SU3NEXGjRS0zMieGz5ms0x0HwzIGHTKdk3fjusnDZl1T70QhM+Bk26FFRK+3CEi+SNBv4p0SGCagAwUfFrIYHtelmN3d4MI15yzU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wDwV6B/YmpzQKt97o5ZYfx84JX+eWmLHo525Eld7p5g3lrRFIw0OsVlldr?=
 =?iso-8859-1?Q?amb1cURgzEI5Jg9KBPuGVPbxLzNvd6enIC9MghV8CZ4Ef0hg9W22cgiPJ6?=
 =?iso-8859-1?Q?vbJVfM/2MYvxmthVccf4nWpRa1vfGe9e6SljfNQt6K7Hx+oJJDgYN1Nfey?=
 =?iso-8859-1?Q?EKFA75WaIgsls/brdPNP7q7fgHR3CuGOXh+nqw1Ze2qtdT3Wbvguo7uZBx?=
 =?iso-8859-1?Q?tgvOmJKcs6cXdLc5TNKMoDfmyCPH97jAHsqBN+HQwePhxn2oXuGP3u/r78?=
 =?iso-8859-1?Q?RlSpKeYsLSSviKqD/kJiRoJw2EmHD9stl0Kr+3sOUGR1ikAc7wWBpMqKAz?=
 =?iso-8859-1?Q?Ptv39upGg4Ji2nF9+/NwxeSZ5Zze9UmSBiGTJylkj7zV1oTKZWMX65pMxS?=
 =?iso-8859-1?Q?K4IdEH7ssw1MnpMiwKfeBoSzSJs6DAx0i8b2B+jDLBMqj9OCKWro09Jbut?=
 =?iso-8859-1?Q?pccDyvki4MOTJ+egKSF0KNM+pHxeBIyJCsRRxv2aFkXn7RYTVIsdMj2AO9?=
 =?iso-8859-1?Q?+5YHsA60aXGCvlEG4fV8KeVFDy+vUI6xtXN3QJVJRdmoQBKPoASZ9+El+h?=
 =?iso-8859-1?Q?mwDh53h2rbuEJi/Ut4uV+nJ/RQwOWf6cDZRLbJKBtQpg70soPCg8+iT7vO?=
 =?iso-8859-1?Q?YhVZUINU7uP42qad0h5MStGco2qrXJVD4zbFtWBR1JZLjhUktu9LSMbqAf?=
 =?iso-8859-1?Q?llym/4N49tYc+qF+l/+TjBm2ARbEHRDGcJoZJgVwPXG9hgDLEUTLeY9/YF?=
 =?iso-8859-1?Q?EeU58Z0NR4kR5CtLVzp3fMFIrt5R5VGaljV1S+bWCX08XBeyyCnQy5oQZn?=
 =?iso-8859-1?Q?1bEVd6AfspRX+4k/veOv0u8NrLKwBXvcNSakgWLf8Dp06XcxT/df8YKMDL?=
 =?iso-8859-1?Q?zsJyIutFJSs6RyRkGQcsKb2sqINztvTw8lc/qh60oMgd3ZP9KitIV7mEE8?=
 =?iso-8859-1?Q?iQE5up4YwG3he2qMFjSX5iezGf9ptaD3tgDV3cIodaA6iDXuMRqvcrjX9G?=
 =?iso-8859-1?Q?ASf+JyaWe9n9J6Vcsj18HWfRDaRs+aZwsdjxxxVdeHvf0ICFhCCXLQ8VRr?=
 =?iso-8859-1?Q?p7Z42zMMZ7Gc/ccqhbxSBE0JKbYt8t4DLQ7COO7yzoi+MsjiIMPdkNIAJq?=
 =?iso-8859-1?Q?ziOwoehB599/KPUuuVWkpRTaukp5KiJy+hQ7vgDGnuaijdzKt89bqwjrTX?=
 =?iso-8859-1?Q?BnVCH5GOvU+V3M4m4ML5v3YoMz7a6DNjMavC6qHgYQRVaNPHbB+PKVX0Vg?=
 =?iso-8859-1?Q?KvmwNXc6MGOttmskZ7dS9ezXbQsWZHhiJ45J5Rb2v347hWoVpb9OlUJeSA?=
 =?iso-8859-1?Q?UIFBmXSETE3KV6mkmTm7315NnI25kXK/M/zFQFDbJDhEbSE07pQzpyiaKs?=
 =?iso-8859-1?Q?OI2q4AIyqXUgJoYg+OMdOZ90ez2CgEe9YzJNtvzhGa4FAxRW17WFuxKgQZ?=
 =?iso-8859-1?Q?huUv/b2cHarDDekmM5RldE2YaGtYWkGKF/dJZKLxwmumRzPGftgk7XWEVF?=
 =?iso-8859-1?Q?ExDmlX5tdP24bQraHMUXDxejo6iGm/cZOhg0xCk2J4TUaEvQmgKSJ+92IU?=
 =?iso-8859-1?Q?2DLFoTWuq0HFIFiapZinOqKyB/c/gCp8bf99snxhDq8oXC9GJwbvos0X14?=
 =?iso-8859-1?Q?3Wu7ZxFe5eMYYnajNUN2nfMh2OtbuabpUSOMHv+FBqNrqIAjr3WJDsBlPl?=
 =?iso-8859-1?Q?UQ9+scGo24TBo3I8a/exZY9Tpdbh3+dzsbNUP8RPFEbxGmDzGrqgpnq7as?=
 =?iso-8859-1?Q?bIWs2J3Qp1fLoUl1zk5ibRGmc9gFK5cB2txxxGqDCOcjx9ebTpq32R5KOW?=
 =?iso-8859-1?Q?WZAP64a/vg=3D=3D?=
X-Exchange-RoutingPolicyChecked: QWVC23iCF3EqK/3x659fkNhz7YVAGcJeoR27mMbuyWG2hNrZU0JLTj/Zl2R9AGCT5xzesCJWKeQMOx5NeDYwkIMcMIDCxFFNiFr5rGfa5bZhB2nThQSLyY1L9vEoHdzC4mbgNFLThBhfUp6ROu7M81PSsVJqY+z9MellqaIXL8wYmKm/kTeSdd7ajLCdU2bpcHTKbWN8wSF+9pvsl5yi0yRIknNI5LznAx4II5TzvCJz7M0D6ja10asgNPg1bPCGAh3M84CsK1TxRVoivWsWEgc1CXtni8MDl7mVTzWINdi4GuoXea/yRo5phLeeOQHGFv6U9sglqr7XfxNr5zQwOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5366e0-000c-4ef5-ffbb-08de81080856
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:54:23.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFUr+iVsWtkyFViQwEQzGhS6cV5j5d8ueiCaxkBWmYSTNEBeW/nkWiWu+NFqFEo10/hBqMuQHEU9PUE/S6Qmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com

>> > > 
>> > > The TDX Module update process consists of several steps as described in
>> > > Intel® Trust Domain Extensions (Intel® TDX) Module Base Architecture
>> > > Specification, Revision 348549-007, Chapter 4.5 "TD-Preserving TDX Module
>> > > Update"
>> > > 
>> > >   - shut down the old module
>> > >   - install the new module
>> > >   - global and per-CPU initialization
>> > >   - restore state information
>> > > 
>> > > Some steps must execute on a single CPU, others must run serially across
>> > > all CPUs, and some can run concurrently on all CPUs. There are also
>> > > ordering requirements between steps, so all CPUs must work in a step-locked
>> > > manner.
>> > 
>> > Does the fact that they can run on other CPUs add any synchronization
>> > requirements? If not I'd leave it off.
>> 
>> I'm not sure I understand the concern.
>> 
>> Lockstep synchronization is needed specifically because we have both multiple
>> CPUs and multiple steps.
>> 
>> If updates only required a single CPU, stop_machine() would be sufficient.
>
>The last part "some can run concurrently on all CPUs", how does it affect the
>design? They can run concurrently, but don't have to... So it's a non-
>requirement?
>
>It seems the main argument here is, this thing has lots of complex ordering
>requirements. So we do it lockstep as a simple pattern to bring sanity. It's a
>fine fuzzy argument I think. The way you list the types of requirements all
>specifically has me trying to find the connection between each requirement and
>lockstep. That is where I get lost. If the reader doesn't need to do the work of
>understanding, don't ask them. And if they do, it probably needs to be clearer.

Got it. I'll keep it simple:

  The TDX Module update process consists of several steps as described in
  Intel® Trust Domain Extensions (Intel® TDX) Module Base Architecture
  Specification, Revision 348549-007, Chapter 4.5 "TD-Preserving TDX Module
  Update"
  
    - shut down the old module
    - install the new module
    - global and per-CPU initialization
    - restore state information
  
  There are ordering requirements between steps which mandate lockstep
  synchronization across all CPUs.

Or the step details might be irrelevant. Perhaps:

  TDX module update consists of several steps. Ordering requirements between
  steps mandate lockstep synchronization across all CPUs.

>> > > 1. The entire update process must use stop_machine() to synchronize with
>> > >    other TDX workloads
>> > > 2. Update steps must be performed in a step-locked manner
>> > > 
>> > > To prepare for implementing concrete TDX Module update steps, establish
>> > > the framework by mimicking multi_cpu_stop(), which is a good example of
>> > > performing a multi-step task in step-locked manner.
>> > > 
>> > 
>> > Offline Chao pointed that Paul suggested this after considering refactoring out
>> > the common code. I think it might still be worth mentioning why you can't use
>> > multi_cpu_stop() directly. I guess there are some differences. what are they.
>> 
>> To be clear, Paul didn't actually suggest this approach. His feedback indicated
>> he wasn't concerned about duplicating some of multi_cpu_stop()'s code, i.e., no
>> need to refactor out some common code.
>
>Right, sorry for oversimplifying.
>
>> 
>> https://lore.kernel.org/all/a7affba9-0cea-4493-b868-392158b59d83@paulmck-laptop/#t
>> 
>> We can't use multi_cpu_stop() directly because it only provides lockstep
>> execution for its own infrastructure, not for the function it runs. If we
>> passed a function that performs steps A, B, and C to multi_cpu_stop(), there's
>> no guarantee that all CPUs complete step A before any CPU begins step B.
>
>If it could be said more concisely, it seems relevant.

How about:

multi_cpu_stop() executes in lockstep but doesn't synchronize steps within the
callback function it takes. So, implement one based on its pattern.
