Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713463E1230;
	Tue, 24 Mar 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347536; cv=fail; b=uttc+rTobiW9VeH//7JQI3g7H2CNYOt5gGgutxmOqVkciSuUUi3V+4HsaEteI8nCYzAjgq0CRBhnTjgh6RlCXS3M0vqitJA8XOIsyjx/fXHtzel7btnZskozQnyBxabncxZT0iFMuBLBssH7hLahZgvQyhlC8JZv7CfHzWTLIAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347536; c=relaxed/simple;
	bh=AgZnWSpNv9gvfx6vW7SI8oz91OSUkJPlcrMdKorrsoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7GeUBgz2WP1DBy2khNQ45ko6+TCgbDy99JgRpepL2oWKbR07f84OkbDoHoBonx6NIzwuDLOBA4JlfJyI28fNgDvAPJtudLxHMBMewVHelG6+WL4kB+dltF/znhv+SeATYUHVJxaPgrmXBuf1GQS6bo43W1hVpTqKn4iOWMiFng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWr6MJAO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWr6MJAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774347534; x=1805883534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AgZnWSpNv9gvfx6vW7SI8oz91OSUkJPlcrMdKorrsoY=;
  b=lWr6MJAOOsZLXGcVvIwWk3RVLKL/UaDnDv9mnx4N2Rr7BI3Cat7vVcwy
   JyrtM6oo+iLBQ3tjFFYyvHYn+pT50S0ZySPQepGcEONkWWoWfvC7Sn4Vl
   MgKyP7LbDFLM4L/GqoRgSOOtE8I6bsy7CzNOOmVaP1422U5SXca2Ih/I2
   07jbEZvuVTsO1Ti9JPpFYFEo7EQ4ZoDS/fEWSsk2CR78gOTy6DtwjfDKE
   fUgwhh+/AmqqtuC0PNjXJp+Y7OF0zbBI0W76daUXK6FOCLZjRW3ZA+nGB
   r3YzTkN/sGe1gGWb1GuzjLqrItf5lzw+5a8KAffLs4mtkNGMUIUUbjjKj
   g==;
X-CSE-ConnectionGUID: oO492uyuTDGpJKL4mUgXmw==
X-CSE-MsgGUID: RQ1xO36hQfu+TBawQJS9yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85975800"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85975800"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:18:54 -0700
X-CSE-ConnectionGUID: M/DXOr08S02Rygb0bD7e7Q==
X-CSE-MsgGUID: mXGXWqhAS8WJ49hKDTIPlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247939300"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:18:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:18:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 03:18:53 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 03:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOz+xKcZsfSv91FOgga+uG+4QeApmvtXSQutfnHT3VEOHUPXnLXNxfldfWDWuda7kEPybkI/z2pgqBNbe1Hj//4gA8flFfxDi2ZSyEm12lLi3709PRyS2RgqKHbx1PGTuCO0VnOOiYFflkOjEc1J8BwY+YxMHQFcYcMTKZwDru/iG/hUp1SmK8kc+7Q50yfnGMmnujvTaSg7/wXDPep+CHb0l8nkvlWd7dgUq6WIPjf4W+ZdrOJwsKvFarXMJrK7Fpt+4A1vry0Jhy69RnHh0bqZSE+iF/q2zsENcMeCw/hPqn5oiL7bgsZrqP0ngImzpEaN6EbdLaCxW06BG67FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd7BIw5IX8QvvwQvnnBNtkEIN5Pjr7ptReRSgfhzV08=;
 b=CSJnIC+oHBdhdVvCedBg+s3kng8sYQ/HrcYmKrpqh6JNTNZ8PmHYunttiUMtFvLfBV52RhxYaIPHaGQ3aSSEfyBrGIrbylc0Jnp4Tex0uFdUiSeeTXhMaX2W5b7cfLQfzBTbrAvdbKptG6K0Brt8nqD3aeNNV4DrZFC8CLEQAJec6ctxWd9IbkkxTVaY/ENWpB+GwJyQeLmbeEsmtRx8tK7JIxaXFtzMYe8k5k5v+vg2fdBKBBuCNsFuDVn5IxQSh7UXD/kDbPqGcfSc8EBadUGIChCNZv00pg8YcrpjMUVTpC4EpGUxg/MckRJFWXFLdZRL8Dg7mFpOfST7ywSvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:18:50 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:18:50 +0000
Date: Tue, 24 Mar 2026 18:18:41 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Sean
 Christopherson" <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <acJlAXJHcxdIqe6v@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CH0PR11MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 5135db7e-9685-4392-bc4e-08de898ebe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GqnnIdX3Emnoi+E0Cv/SYDvUeXY/FikYGLw4b9UQjv/yCyKjy+ezZza37YTKPYXg0KG0oeT06tJ7lWwy3v4VoOfVIubMeh/sRiryODUC0pYZWP6mdPyBcj5oYhNs1TBC0fZ3pUAEg819zNgNnhknRpqa9bGtVlYE1wfdjLMZDYzGxoHwnyfeZ6LU2IVas0SI28EMkj/N4aSzqZAnCnvNATbUh0SqZHdh/rP0R/dv9FvglIcOsLKORLW3+/XBHiVgdiLnU3pofueAY7H4DWWnSDAhNHwcxiNoQ1FXaYMv+XKZt6FPsGwZhLX+w3rMS2Eu8kx9idSv4O8ygDrCDZP7epi/Pw1H0u35wu1d1moDiX3Tkj9XU1TSOrBN/PHdu8zr9bPWeNfea/KPbKrzkgsfXYU4Vn0AtIqI3+twRBVzNGzRSWxgXVPR5alCCbvqI5VV/6gniQmWBSapZi/zC8F8pEdi9Ymk4o/exHfS3hetY9yW8oGQ6QE+CqvfGr+0HM3dxQZoPCHm+P6iOj4cgQgJUXLdpsXp3GfRPpIdnXCWNnsiuQ/ElF0776RKZtUpkOKK1nxOlDmYSUP6DZc1D6ne4snhhOvFZuMqljFLudN98IqvyUAWXrA2+gBTcIg8DlYuF7FoojPbanw7TaIdgM8udpwnZpxc4k8H9FEATGoTIjtsqfdE5Y3RLwi801k/QnM6//Ansm36rdvvid/P1WU8aPblxJYRoarBF8tdYyEKNpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ih4ZWDGiYpIJn10L7RFh0bikRAvUVcFPQDjUb1AbR0EhQ2I0qYIyj6UPQf1c?=
 =?us-ascii?Q?Gd5tmdlAeA/xiPK+SWkqSNXID+EJhd3n52YmVFjQwhpSKI6Fet5SpIpf51+v?=
 =?us-ascii?Q?bI3/zN+VzUpPuxUUW8YddxULWwzfBGGK2GPQOzoFukHm6/lRU6XEiI6fQ7Zx?=
 =?us-ascii?Q?lvUhQr4fH1gH3jk8ISGJEvtdbFhsT8NFIW7NZvZpwQs5V1xg8Yre4YIZ483V?=
 =?us-ascii?Q?7RyRF7SBpeSitOigDz3wXXuGPCuyyG5UmH2qTsaR5t9e9BAH0aoLcJSjXYEZ?=
 =?us-ascii?Q?PE7hPsQ9L7WD4g7ot3gEx0SFIqDIHvpufUhYkCQZ81gWK/tAhT+skzzgj2gO?=
 =?us-ascii?Q?FpmI56ktnFcfOql9AkpYMAJWi18DX62ggLfzCaspLAdpXCOqzdpOldmV2LnU?=
 =?us-ascii?Q?Cf1BC8CXmq8pIeP+Pc3DW5R40CmLPihFYObTkQw1uDdCzC8pCaA6b9fj+R07?=
 =?us-ascii?Q?du0CMA6wcKieYBNnRbmzbTALzZ6DwdmsFqvCfPzzmmiOl/qGYc+NzXN7R4i/?=
 =?us-ascii?Q?fo+zCimNZguSMYgP+oija+HRge4FakNA3uPIsGMvXG5Zp6vOs6yV6u/re12R?=
 =?us-ascii?Q?YwRWxc29fCF2W65RpuZ544+YNEThVMh1ZE47X/ZVNAJk7ESHn09zb7zEdGw5?=
 =?us-ascii?Q?4HWM6uQMeTkx1wFd4b5kXlbjtWRh5fGh/ORhsXe5TpG9Gko366DKx+yEWPLs?=
 =?us-ascii?Q?inPkIARm2xboiVT+WjjYA092nKVTXQmrZ05J9HeCMLrA2ZWRux8i+stMkJDn?=
 =?us-ascii?Q?tFsb3/e3YPZ3tI3Pj142WowySHIBSUyl66AnwMRCdpcDwdi9hRoKT0r1fcrr?=
 =?us-ascii?Q?zEegdSfOyRMK5VGZPnTYiAnGgeg2JKJD1VXzUgwN0q20ThlcleWwPdecMFSj?=
 =?us-ascii?Q?3I6C9VqAu9T/fzwXN98fAEZoaBFlvwvUK2i8ohvVS/htMNG0e9bpZYrH2jaO?=
 =?us-ascii?Q?1Y0EfkFLOjo2E8JgLePyGK7cOkOFSuVkQoWyZtCBVlLcI6HNQlBSVDRYHb1q?=
 =?us-ascii?Q?AWdI63tnglYajvRO3M1a277pnygtzbhc1nZOEqZpxlUaxaCoJSzjQbSmm8qM?=
 =?us-ascii?Q?2myEMqOhW0a/xN3Xgb/fJFLmiPVSC2wqp67f3Cfx8/ggLp+GiY+UKQhvBIpn?=
 =?us-ascii?Q?WoqJsQGn0HCWZHPaM5V7c5iI2p8VbQ11wOgDxui23XEa1dnqjP0jB3iaVmEo?=
 =?us-ascii?Q?vEudXNW5E3zuc5UyT6RZQOEIOn27AB0p0LI7m3QwJcRPTts8FdpQOaYQs0MT?=
 =?us-ascii?Q?1JpIUJRsUNCrMzFJDoh3AvZVlLVbD9O8yYnIkc+tLb3pdKDF37p0rAyAu0/i?=
 =?us-ascii?Q?O01FvxsPHpyqMm3eNC9dOKmBjlRA93MhMuSpr+UZ/IbFAPWtP/ThC2yEWlyJ?=
 =?us-ascii?Q?lQ6sOdxOzF3GuI4Um1hr/nDQTGuF8vyVQ+atHtPUhoI8/rjtpaKq0P5EYNq8?=
 =?us-ascii?Q?kJDLYUVywD/p3Qf5iDB/9gCW7CCwJ7Cuno6MPkA1yzsPme7Shjq06QcrKhq/?=
 =?us-ascii?Q?ySvKldcallSgdAYBABj4CS22xymlfvh2Qi9Uc+dL2Vfc8cdzVyrX9DYfE7a8?=
 =?us-ascii?Q?BM7EvxN4yW1x3WZasJEhzjuLtCzwy8XV99lDiL0bDXdppi1Mqym5NKyfz4w6?=
 =?us-ascii?Q?+Ay5PtDay0MbqgCorcuiDWVJ3q1KKnsj9hiOT11XDMlhC02ZwGieoSUEMwAJ?=
 =?us-ascii?Q?v2TLijGYvrp9UUvUdpyb9RhuNXMJmu4oK0CnCaQ4791R9xCPA2o0QQ2NkMwF?=
 =?us-ascii?Q?uh10odyQ5Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: wLBSY9i9zgBKSj9E6AH2cWjXY6LFGvkiBjVWNKjwwbC+//pmzfTxwFnkIQY97cff8QEO8QEAV/K64dcK1mfFjoR7SLz0ZUEs7GxPXtXXVaNmQiSPsMZMe4vX4ToQ/88UHgKvrW6dVDHhSFSnwdEktoGPqMRZou2Gc31gEDkvGIrgs8mL48eS45i8fpNQB4NNrq8dfH65Sj792eJqYzSr1u540Q5ukC+kwr3yRzJ/nL9ogRWSmMrneEeJh4XTD9SujGMWNR7gP3fLewpJ/n3Ppk73ga+Ih2UnowOvBqga5a0kfdV057m7ddVlK3RUieLPdIB3+T2x3Xc7ntR18NnoXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5135db7e-9685-4392-bc4e-08de898ebe1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:18:50.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYRx9d5BKQmF5+eiAI047GotAzelqPuKW+Vvr7+yK1FMT0Uke0pOPLGrWXsA0XFpTfDt6aAH+P4Sch9dAeQwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com

On Mon, Mar 23, 2026 at 02:59:06PM -0600, Vishal Verma wrote:
>Some early TDX-capable platforms have an erratum where a partial write
>to TDX private memory can cause a machine check on a subsequent read.
>On these platforms, kexec and kdump have been disabled in these cases,
>because the old kernel cannot safely hand off TDX state to the new
>kernel. Later TDX modules support the TDH.SYS.DISABLE SEAMCALL, which
>provides a way to cleanly disable TDX and allow kexec to proceed.
>
>The new SEAMCALL has an enumeration bit, but that is ignored. It is
>expected that users will be using the latest TDX module, and the failure
>mode for running the missing SEAMCALL on an older module is not fatal.
>
>This can be a long running operation, and the time needed largely
>depends on the amount of memory that has been allocated to TDs. If all
>TDs have been destroyed prior to the sys_disable call, then it is fast,
>with only needing to override the TDX module memory.
>
>After the SEAMCALL completes, the TDX module is disabled and all memory
>resources allocated to TDX are freed and reset. The next kernel can then
>re-initialize the TDX module from scratch via the normal TDX bring-up
>sequence.
>
>The SEAMCALL can return two different error codes that expect a retry.
> - TDX_INTERRUPTED_RESUMABLE can be returned in the case of a host
>   interrupt. However, it will not return until it makes some forward
>   progress, so we can expect to complete even in the case of interrupt
>   storms.
> - TDX_SYS_BUSY will be returned on contention with other TDH.SYS.*
>   SEAMCALLs, however a side effect of TDH.SYS.DISABLE is that it will
>   block other SEAMCALLs once it gets going. So this contention will be
>   short lived.
>
>So loop infinitely on either of these error codes, until success or other
>error.
>
>Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
