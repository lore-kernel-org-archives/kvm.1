Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5B2236FD;
	Fri, 13 Mar 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389883; cv=fail; b=QSke5AEG7MryjeQ2AD8s2bTTNDrfrd0x3w2ysuiF7bEVReU06ZK1mlAQyVo0Fz7lBt5eo/CBct7xDHS5G7G5MFVLiYauosM3uZvwvOlaqB9CAsiBuoEjCi4RznCeh3pw4bwkfO/cwRKG3OV3/vtYJPK+lKsS8S4EcEvnkVrlue0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389883; c=relaxed/simple;
	bh=X7wIkzimIaKnW90MktSg8EZNEBGRgdcgRqdiaiMM8ww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L68bRW2QIAuIVKgeg3iYZM5j8ujH5e3J8vaZUL9VMT6ifhk2CyZJYWxN6eIv2hOeOuoeRmORH+THvwYLmzcjG8Yh9G256MSXYpABJMKX1R/Y4tvMYSF/LROzhx96lsDuufeQ1xll570NfY0qXO0Kx18COr2Ym6tpwUEyh4Kj3ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGS7M5mc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGS7M5mc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773389881; x=1804925881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X7wIkzimIaKnW90MktSg8EZNEBGRgdcgRqdiaiMM8ww=;
  b=lGS7M5mcdI+TJUILfMSi6n3C2gp/xPptklaY+nL/waMfZ/sfkoHmmc96
   S+VoSKXETuUjPikZ6WB3DMgaudCtfwBUBWu1NDBET8tvmOpIaJSYQWqrr
   cd1QSF8fkiIjkJdigwvNnMFYr435ZLE4B7CjMdD5fEiHmFzOko8EBV82/
   rK7Gu+6qIt6TbN0h0QbDMQeLpXsxvwmtTyv2WrH7qzIm9tuQHHR+XNt5K
   7RExaLm4lBhbu2Ej/WLMST9D50vUhsmuN66NJCc2UxzHwIED4DXB+Eqh7
   rTGUpMwdtMrTMWFiJrh7S5W16NfyXfCvMwVvILPRAxSGhqSwpD+4OQwTG
   Q==;
X-CSE-ConnectionGUID: wvOYKO/lQW6r+cwTrJ0pzw==
X-CSE-MsgGUID: W/ikUouxTJGGFEl6HG8lLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85194926"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="85194926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:17:57 -0700
X-CSE-ConnectionGUID: Rz0waXziT+SlkK1l6f15JQ==
X-CSE-MsgGUID: GdxrYFxJTka5X8tWm1lUVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="225784888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:17:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:17:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 01:17:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKfsIEA6ZASLCWvDg+tFw+K/1uYaKA38gNgK4b6Ht0GVKU8KUBpFDrLSM6KuaYgL/ik1ePah6MQjFn7O2ZILiDoQsYYSPEO2AMUbSGDhyc+1P4g7aGDJrT2+VLnjE0Unk+7tHe7YqtClvcdY9yfLO2pOWWge5DY0o0abt9mbIu4eB1MwoAIJFPl6fl5jxV4wsIwJeUaRRef+SWTR3hkFieljCvDhgVAuv3SDAleRGkFR8e/OEDoMg9yYp7RA4xJKV/quZLy4k3n/J9dYVDY/KM04/HRQWU09m0XvcSao5f++O7rieB33PpaVXT9O9QTo1SYfXIw9AVl7kiSTjYNeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7wIkzimIaKnW90MktSg8EZNEBGRgdcgRqdiaiMM8ww=;
 b=n8PTWQGWlauzLtsvfUNelLEt4TNG8i7IWwAgUABfGFGch8Cv/4L9QTP6mwc9iK/TH+oCcTuUEScZ6CsgV5WjCrjeiFWybflGt9iaFQMZDi7CrGb3HKoq1twreG2UyhQGUEEl7aaqB6vR3mYMlMumMiMp9mLJszo3emLiOx3kN2RBxHIlo/RiM0ry76itZDeB3+47Y0LW9Md1D26CNPfQ6uxvzclG2RLU+lFqHNUDvZARydDmt0MBrME9bSxRmwGc6rKl3Ak58b1lsVLmSvcyiVwPk6WDSYQWESn8TKHipQaItSLIdwKUiodBOHXq+6lMIuKBqIDqmaq1imZYimy+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 08:17:51 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 08:17:51 +0000
Date: Fri, 13 Mar 2026 16:17:39 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 08/24] x86/virt/seamldr: Block TDX Module updates if
 any CPU is offline
Message-ID: <abPII1J1CgWKyTBd@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-9-chao.gao@intel.com>
 <7b3babcd-0b09-4d36-b713-3e55ded1696d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b3babcd-0b09-4d36-b713-3e55ded1696d@intel.com>
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW6PR11MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4469feb8-55fa-441d-3854-08de80d904bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zyJYy5vYBDX7an3gMgk7Nd84boCeBvsuaF207D4XRl1YsA+WF68Wr6Ni5eSFDOn3td3WeyW3lupfxDzvJJ0UXH0/L4Z8AozRB1k2wHTbgH7WJJ/Rgkq6TbrLavW73iAJZqC16O/pkycbbOtMQ5Jj+URkaZYZNFCId2dabv8Zrsj4rsETBXocS6U17cVtXQjx8MSCk3CPKQvKPTu/zUswyIKeZ/RwhXnqptjPCcXepQkP7ZBC1n7dMxE+n6808guHiewmHLVbW46tTflK2NK6cPfzVwIjwiMAoacj1Lc1WIq53j86OgK2GxUvFoG9T6NjeNSpiblSUgWjeOfSeQzw8SeMOcgaMeHoHpFR0sl9aaiwyCrl4X/sQ87E25RkBTteJfSAxobdYdrBsYAR0XGoIElwzLSPuTs9UW1Cg9kQT0egF06X5CI/+v24RYnC0iUOjoiv1CntH578qCVywGJRCo4kWe+nWszwSfQK8z8Oy7eY0j82us/I2tkHIuBGIsRN45NGlWxQnIG3Bnrb6t9lh6JCnYna2V5UIqXsrAoZUFsBk1ub9dLW1bgiobtv/hPBLqq/SuzaTPtjEGrPDkD9i8ml/EGBgKwDePgDeVhJV9hvt8dJPuUKcHs8IGM1SdhSMzZHvJS0r/CpvlVcZFX358A1UKJJa2Qak59Hgsa3MkX6lOOg+4c2gU4Z1Cb6ZIzT1peE5WOC7MnRxAEEvTROhCzM5+XdD1IFzgj/oZGMrYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrpa1rKXCU3j5Iq9jHHRySd7fttMfoj7wC6buPsYvo1f7NzUnu3YWYxYvRf5?=
 =?us-ascii?Q?03xXMtYUjL65riTCDEm74yQKqE6hIXFPda9qmHOebhREFrOdyYdEwkm5LUmy?=
 =?us-ascii?Q?Hd/7nK0nfusVCTAKE0/DeGoRFWV3qXnIry9OtLTBHF+tYmstK0ll9iJ4uA9q?=
 =?us-ascii?Q?DWtN7MoWxfDSXjp4MjYyj7kJrtori7gITsgh8Yk4fMrlH4CFDWpATz91X1Vq?=
 =?us-ascii?Q?nC8NIsZDNFzDkXpK7UV0FH8gP2yB0JjmeJkvjOt2OlU7kuWzY8iO7Yn5SkkJ?=
 =?us-ascii?Q?CC1nTFkprdp1DvDl4ja7LDb2dHdQ23oFDLcWQswbt0jzJy1b7r4xnWnN2p9F?=
 =?us-ascii?Q?RwNfK5m8WPerfd+CzG0OySWrxOqnWfyOvQchLSMBOBF7I4PBWlKkJMYboWNu?=
 =?us-ascii?Q?lcnsvci6yNYFGvQRTM+DLxJSBFbvGYVG8M+8dTXLu08rxYapCHlGBxsjOs5I?=
 =?us-ascii?Q?RIpKHF7IcR70JShjuCpsLcfpsCO1vDXAZ7ilUMS/xIUHCmlDSFpdQT/h25uX?=
 =?us-ascii?Q?3DWFXbj45lttT+zC3kIX0zqqqpXWtO5Yuy0NKLklmxEhnFlZvlE40QWYwVQW?=
 =?us-ascii?Q?EXZ42hpKMR/gZ6/j4h7ocm0M+lqpePXqVuom9z1a7kLaeZD0AlVzQEpW+Dg1?=
 =?us-ascii?Q?62IkM6GydLIM0TpHUUyf2mbj5qqw18la6GD01euCY2Q2dzbykHmwwhhxALRb?=
 =?us-ascii?Q?rhNmtN9Rdzzc3KeIP/3ukzM6AoWPdTTJx3qvbhbdvWhbpWYC/DzTFzLiK2cb?=
 =?us-ascii?Q?/u+H/edkQyXDkF8KliFGuRLnDqnpq93vNiF/mbVKYdNyaogeVhShhdR7XoWN?=
 =?us-ascii?Q?k39IPvGUCYQru1lGswZc12yJ/s1R7oWGE31y+dxEvAflOauqn2Q9VYoPCBR+?=
 =?us-ascii?Q?GqaSbPaUn67gimSSDTCvkr595pMbEax0p3SBRQ9TfMrgSMn7MZa+00Yf5a1B?=
 =?us-ascii?Q?PKfJd74T6w5lhuJ17pBSYiYosUq3OblmQ/qySPkSqcP1tqzoVDMzSfeyN0YD?=
 =?us-ascii?Q?ojm2dYmlRLSev6GYjyjIwDA054Pe3a5e7TCa+BXFiRYcULXfjBBsAy6nwXGL?=
 =?us-ascii?Q?+SHmmcpkR4JzBZOw8gMZujf82ChxGgOc/+9Fy63/2gVD4ozt74BQAmPXIiuq?=
 =?us-ascii?Q?Y9P0fPGgs8rAVMj244SLcQLW9WrsfaHSNc3ajw9KHwSziGyxg408d+nOWYA2?=
 =?us-ascii?Q?LI/kqyu6c/+lvyhRIY/1aR3/m4yxev8/Ghaksnml8k9l5rlHEzLFXbABgaoE?=
 =?us-ascii?Q?JPgwy98VwcPXhgKcr/EOd5S98l1nHITi3qAjyhQaSCcUUGUr5Er7B5RxiSXz?=
 =?us-ascii?Q?T3mLJLJnDu5kQH33zmb/rpUU0+XzgkiynunbIMLGSB1FqIwqT/18G4ksOg84?=
 =?us-ascii?Q?y4gXnXQXsXrEsUi/1PPxEZkmi8oik/k8taO3/7rJsWcdDKp5JHrEPCSmPGcp?=
 =?us-ascii?Q?kacVQknloZ+vAvBXJr8SYo5/cYfQBguC5P2rX5zY4hW3esn7JvH7uw6qGgU4?=
 =?us-ascii?Q?VRieOLt8H2K8kDMdr784/6u2j0d0LRixGpm+NweuLd8Hbs3kfEFUqEmUlrD6?=
 =?us-ascii?Q?fftUxxACrToBF4WGnh0jChddOjgqILUYLYDYoL647ypngXV9UsZYZkdV7pKw?=
 =?us-ascii?Q?izOH7CaWJg5ipE3T9+T3AQ5IBS+5aW16aWZB6lDo3FqEq3kio8B9GhncNmiF?=
 =?us-ascii?Q?Z3C4t24ONalCQnNYpWwHVFUw1Mh/hiFHwhN02y/MZ2G7an73KX1Mo5pl3CC1?=
 =?us-ascii?Q?+3boDgcLMQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ceVQBaBrJwZ+ApbnmBpeI5jcdp2BuPsMyiM3JjQX7yV1tXbzuWmPM2RVKeNuYEg8vl48J6sii5uxpA+7Fl6IFe8+NMYkwvLj9OiLUo+sgDBWQ+21NbecygCaMBRNOzde3dkhZ6hMyDj9zhL/7mpPKxx/mOz8sZrryGkhKXOdeR/v1orT3etGiZ+a2wqHpLve2igx+dxJOYF21CVtcqlc5KrI0FrV98/7FhX3yNIrcM9eLugGGO1dx2/7v9IX8Vqkc00BsEcBhrDjZKLBdHJafn8k7xO7ckSKiRJniwCDMWgbTgW0Xjd/midcOKKP2PVH8LD3VHeGmxkDqE8TFAWm3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4469feb8-55fa-441d-3854-08de80d904bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:17:51.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sItXWogM+zRcHwyfeo6fhA8E7loKLqmyMOWo2ex50AWzkXTdoVkMTOYI9LEfyMTLZbs71DVEw8wEC66ijPPoKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 01:20:27PM -0700, Dave Hansen wrote:
>On 2/12/26 06:35, Chao Gao wrote:
>> P-SEAMLDR requires every CPU to call SEAMLDR.INSTALL during updates. So,
>> every CPU should be online during updates.
>
>Gah, how did another one of these creep in? We've already fixed like a
>half dozen of these.
>
>There needs to be a *LONG* justification why there is no other choice
>here. There are very good reasons to leave CPUs offline forever.

I will drop this patch.

For the record:

This patch was added in v2 after testing revealed that module updates with offline
CPUs would fail and kill all TDs. I attempted to provide graceful handling in the
kernel.

But "all-CPUs-online" is a temporary TDX module limitation that will be
resolved in future releases.

So, adding kernel complexity for this isn't warranted. Admins can verify all
CPUs are online before updating. This is consistent with how this series
already expects users to do compatibility verification.
