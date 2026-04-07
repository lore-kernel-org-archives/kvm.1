Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31F40DFA9;
	Tue,  7 Apr 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564136; cv=fail; b=kea8Qz2S12jKDDiko4a0A+LT4ZX8l0ht1N54LgUv01TZTK2G/kBIuaa10XewqiNNoNBYKn1S6Nkpby116UtUaH2JQK13DKVbkmx4MWoBsLRxrc1ilPhspmzMIeIHkW+NSnJ4iF8dWXLT0fkKrHTtp/Rvh+LuGtbxtyJIB4shKHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564136; c=relaxed/simple;
	bh=2A+GM2ZonHytVhJfMKmUf/y2OfCcB2IpJwYRknLf4Uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmh712x8Gq0TD8pnJ6azaI4SOj0kaL845yFWPXoj2MHsqg/1yzibEkkladJtJyGEnXhQLLUx1hj1zLSym4sceE4tYp085DPLVY9kJ4LmQq/C4kTG+IRYc9QPAkC3ZVyZ+DQyOnocOG3f6V+AcM/0q+GdwJVx2j5yD/1B1rcDE74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHVDFNsb; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHVDFNsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775564135; x=1807100135;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2A+GM2ZonHytVhJfMKmUf/y2OfCcB2IpJwYRknLf4Uw=;
  b=gHVDFNsb6/AS6ybTEhz0CeYB1zip8fEaMsqNAtApW+B0tdYEtG8pLZmP
   tUT1jg1HoH+50pIVlFni4R9Fzy+gwozuKxQ6mMv5be70ICZgHrZMd1X5o
   /y4VL2vkSOnuyBkOqFGB2NTfu5d461n4G0D3lZiBKHWM/lkO5WQ/LPzKg
   5vSbWP6q2+RnXwAVqIM/WQofyLRm991h2KsnlLs6IQnqZovaIhMGJopu5
   SihzQNUEMteI9iMpz7mHn19Vc783DEI1DRqNzF2pPqw0OWrUoTfbcWmNa
   4zFe8jItykB2vmw4aSGlM/W1GPUAIh0oUJxs15GElL2lWJV9wBj5fiUZD
   g==;
X-CSE-ConnectionGUID: VEQXYVk5SLKc1t626Nw3Uw==
X-CSE-MsgGUID: yyPbZvqnSRmcTWXNAfwHAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75565551"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="75565551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:15:34 -0700
X-CSE-ConnectionGUID: Lt8bgLd/TBOmmUtX+m8HSg==
X-CSE-MsgGUID: CFHi7rcbQFqIGzaQuP2qHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223369197"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:15:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:15:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 05:15:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp5E1cz7OZaJ0qw2m0Xa+VvUnNll1KO/RbB5uWqoPufy1cCc5Qyr3uTrtIeer7mDGIt9VVZBypF9YCjF/YKFWxxux66+u2VuxsswkCA0czo2wBLZ0oAXr42mpae7Xn0sl/Aocf57mXlpiNuvilO1L1s6c0enxc+fnQ4wKwG3C9MbDyxA+28GRHIfTD03hNTx7mdLPQHWOkvNBi0Xhv132DRROm0Lr8lygNwBpHmyrD5lMzl+Za51Z6OGJG2kjmY1Fi9sqa8Arp+zdLLvEbSmJJoaOBCIqeKiGk/HmqSVjB0TyuI5+q+lFmqDttXjo1TEv9y/y4o/rqy2/erp5LpR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfyV94on55Te1Mgl/q1ZUE08HqmdjF4ZgZms8a9Ivis=;
 b=kIGT6B8adVCMK+fu9+2F0dcHd3kyqX1z4R00tszpEeV2zVZ5tU3MOITFAgyx4/MpEZRj5Bbjs0qys3ZTB+ZqiNADNBFCQJhLVOY0h662maM9LIJ4BwO3zyjYJAyM4EUuwWQGLgb53midfJrCBRABi5CGzKq9Yurs0+q6yakcKTtfsKS/gLRHtecbvm0iGvs/ERuWjWoofwswK1QvgzVPXVKMQoZGjbYrEs2UZSxcLkYtwNXO0ajl9vFFcFZm2NOl8MtQr7QkbW3QEI+PWIZk4/Fh+UZRlt2/fSSdxHOXlMi5Og7105ADVt1GdVO7IUHLujo6EnubWQCIRYJcbLboTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 12:15:25 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 12:15:25 +0000
Date: Tue, 7 Apr 2026 20:15:10 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 16/22] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Message-ID: <adT1Tkz+/ysSZ1Ua@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-17-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331124214.117808-17-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MN2PR11MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa027a4-ed4c-4e96-0570-08de949f5922
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4GnRxhtiFZsfZjgegWbZkzn0k3pO+uGoaB5trDFDCoqT2LOi4zMKb61BIR6V+jBg0kEwHq/wkWTJefluXz0OqhqJUuFrGvgx0/8uueJRR/vG70bKbwwollugkvWugLGzrPpb3tFildIhLFg/V5XtAWEW83j6LfylD8NeqpX5sHWUE5le0G0tHUNP0YB0NCLUvVmw+1eTKuvnxaBY9/8Ol64e4JuKvwNDkHDASn7mv7GhXtuOwwSmptOYO7613EU+ayaFhDVJc1fgVD7lM60CiGt4QE46kbqNeTj5WjBubOSpH5ngmwPIg7mYHx/WJl61o5jjWxl2dlVBZ6if83MQfTCErw1vCmF23Rkkhlt88tHL5JS50GCqZwZoTrslnt+rjrn8mi3zRbqmFIdaCaJaPfAsWlAOWXYfDd3uLs0BYfQcGzcBxUpZ9s1IR22/nswf8uFKmQlXwwbOXq8xOqWrrrARvWcStQW7ugSjYB2SYFRRFQSdtAC0jfEw9k/35Cw9XTo5QFw6AG4mQuyjzvBbbvAi6VcF5nk/lOsotkgvH/4VN+uWI8jdOyQx2RdssDt0xZSiTOZ3N0CQVUXp61E0QT8RoaMDBv4mOlHaka/UX2Y+QnQYpJvh4sRSmM40ZIGJerqJKBzJq8rKQkKOBdyUYOefWCbTMGmZZjeUgd7cL3IdAvqDfp6bO6XJ3NpFpbwSTNtlJgIxLUeYA0dJLCm9zFXzaGmqOZxgPupRrMKPZSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fkTFzgWJY6MlJ32w3+CAPUe4qHo62bOFbxXlN5GLJOl5oXhHsERWkJoWqKk?=
 =?us-ascii?Q?4GJBDtTUrnP0p51x7xjFa30m6qUyl56JzbT9jjyvlWVg7c4DT/ppx9Bxq1X3?=
 =?us-ascii?Q?pNsQaXzoLv8CKDi0KY0a92PSKgj7PMj581pVHCJs/NaG3usdyzXwLA2gtg/f?=
 =?us-ascii?Q?cmT186gsJoEyJPuByJjU+biqSaSVR9kgVz7xCiR51oBL0qXWU/IdvpMOkQCZ?=
 =?us-ascii?Q?AKsty7UPvBpGbR2jTvJLfYRlgBvvu2jnpip5EkG1Hq7w30OKoPhrx1rgwqWh?=
 =?us-ascii?Q?VN2W727dYs6bTzFlu48uw0NFam+pSnxGJFkRAHvKAspXzCLBKKWuZlop+dbE?=
 =?us-ascii?Q?dAKZ44+A4Pdv1sUVv3KE/bQgB9V+3d6wRJhM16dVbuQHEuWExegrQ9R7F1yU?=
 =?us-ascii?Q?o6Kin6TTOfQ9ij52llRz8UHffIS7evPRn8lVfX+mxbLj0Q5jzpHOOUI/mE0z?=
 =?us-ascii?Q?zH6iLTgJOQk+g/G6Kt9m9J+l/MpSIh9Hzq4TEPbv4IViueu+rT1ea/v18MBZ?=
 =?us-ascii?Q?nUeZU0GH5bgW31r3zwX+fWuxo/GYPwrtO3+67Lr5uAu9CfCcswp7haROxWWx?=
 =?us-ascii?Q?RDDK1H8LJPtN87K9gPHLqZJe6FwaEt0JFxSw7ragTfvzvagCms0aSMlVkNxy?=
 =?us-ascii?Q?giaLe0RZBs9JA1UV2TmGSyWA2iuhYU7cYGPUIHKwBN3AHxv65lEVIUH20+w1?=
 =?us-ascii?Q?3ywIcZm/wq2Akwc2XzKjknjVrVEDu0TJIZSukjbQNBsrsksSzFyoZceeM2It?=
 =?us-ascii?Q?zaxz1G6uOt02AUx2pH2OWtwDdmJ5bqxFToRfl0aG4uaz3m6CzNI1561i710Q?=
 =?us-ascii?Q?EMdGqBcUi7OiCuQJtqGXgpZSrcZEse+Tb9GMxPCemPGp5cE2UXcx0gB7FEyF?=
 =?us-ascii?Q?Q7+Vp/uTwJqU1cm/FjZlGlw6v9IMABsm2I/6BD+uHylOpye/I7BCaY1yP5cO?=
 =?us-ascii?Q?JPCSUoXoAdm4o8LOqLc2GSeubTCF+LBcbzw+HX4y0NI1NiXvaScnc5hqoFM+?=
 =?us-ascii?Q?UZM4/MqQ0r1UHvdBR7drWQxQDJfSktAttbubaMf8jW4ufRi1Lu8x0rl4nHKE?=
 =?us-ascii?Q?Pf6cLlnbncDJzRTnov7Bh/xyNvGX+aGwb51P1yAk0SrFhbzvVrvyKVyr/19T?=
 =?us-ascii?Q?Kqjzto0EdaNESLwhOKoPRqvqIDeDhI0PWIgiIRVl78QqfC2xKhpG8d15D3sr?=
 =?us-ascii?Q?cCWzgRytZLLINDFp63arR3Sngr6mIaUahNvmyDy9AxREdEEdBDWICZScS6c+?=
 =?us-ascii?Q?2SZcTcnEKk6liSiF2DIwk15SDfeje1fdxCWT6tw2SpFQsvgA1WCBBIxMursZ?=
 =?us-ascii?Q?RmGozScdmYrFz0ELklstdq8HL2B9x/NwwCw6XCLpMbdePmGtfOLuZK9ILzWt?=
 =?us-ascii?Q?AbEt8I02jUhms367HeHW1hp5TD0ilbuPsWNiZfJ81OWzxzHl23ibY20Y8qWo?=
 =?us-ascii?Q?7NX7jJ67Z2Ww58OHOs4QjnbNAFP1rvXkCsMEsCv1xynAXUugOH1lWqnWeW9N?=
 =?us-ascii?Q?SG/bd14bz+qFJ6GdNY2yEb1Cq/bN8EoPemPXzs7rlAtD0KgQyHtxyLvXBYaR?=
 =?us-ascii?Q?3/nXY1zbirvU+At1TmybJoIhUIoe7X0+mkVKR+YEQB+jvygxt60LqlM4yFN3?=
 =?us-ascii?Q?PLm9lMFkJGR36fDLi7hziIX1fyqHWo3Eqyh//8xXGrAKwWoAIApgRxKCsnQe?=
 =?us-ascii?Q?KXfP6PXhRZI2yTonT/p3uHVJ/cT15JU1FqcFEgWwtRlZmYlHMhVV2lhp2pxH?=
 =?us-ascii?Q?IEPX9DBFWg=3D=3D?=
X-Exchange-RoutingPolicyChecked: JO6qYdubqkoYKcafKbKdCHozd26LgZyojj3h9Q8FBq5zCE+qEXHWoyHBeALXGiHkupcJ1jBDQNjG3JlAXb1E/yiYS8Xz/zA7d4iu/vMMDHbEgeSuj56nfHFpGu+pVkQUZppzBXN2ZrCAJHIOGpySkQcTgEcIN0ujqfdxIi0FuyVjxddNn71fEwMrSppcOWhYF7wKfirX/su6yPaY5KdA8Mqw99YTlNZ8j0IVANKbtpmBZ1Bv8MkjVI05yv60jTfyY8uFe8e2Sjib0dmk42kAHZLbDRG3+gb3/qtnLrZPiDfpdkJXuK0A2Vq+J5QJ6HUeWopJW98Hh7mLJhF6xACylg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa027a4-ed4c-4e96-0570-08de949f5922
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:15:25.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cq3bs1qAIzIg0ogBvXfHEjNVEeaqhgQ3QwdlNn+TGdyeqOkYaQFtDSl7yKrVaT987NbWDNZ25CGbl1cX0g2x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com

>+int tdx_module_post_update(struct tdx_sys_info *info)
>+{
>+	struct tdx_sys_info_version *old, *new;
>+	int ret;
>+
>+	/* Shouldn't fail as the update has succeeded. */
>+	ret = get_tdx_sys_info(info);
>+	if (WARN_ONCE(ret, "version retrieval failed after update, replace the TDX module\n"))
>+		return ret;

Dave's comment on another patch applies here too: don't preemptively handle
errors that never occur. The custom error message is unnecessary, and
propagating the error isn't worth it. Will simplify it to:

	/* Shouldn't fail as the update has succeeded. */
	WARN_ON_ONCE(get_tdx_sys_info(info));

>+
>+	old = &tdx_sysinfo.version;
>+	new = &info->version;
>+	pr_info("version " TDX_VERSION_FMT " -> " TDX_VERSION_FMT "\n",
>+		old->major_version, old->minor_version, old->update_version,
>+		new->major_version, new->minor_version, new->update_version);
>+
>+	/*
>+	 * Blindly refreshing the entire tdx_sysinfo could disrupt running
>+	 * software, as it may subtly rely on the previous state unless
>+	 * proven otherwise.
>+	 *
>+	 * Only refresh update_version and handoff version. They don't
>+	 * affect TDX functionality. Major/minor versions do not change
>+	 * across updates, so no refresh is needed.
>+	 */
>+	tdx_sysinfo.version.update_version	= info->version.update_version;
>+	tdx_sysinfo.handoff			= info->handoff;
>+
>+	if (!memcmp(&tdx_sysinfo, info, sizeof(*info)))
>+		return 0;
>+
>+	pr_info("TDX module features have changed after updates, but might not take effect.\n");
>+	pr_info("Please consider updating your BIOS to install the TDX module.\n");
>+	return 0;
>+}
