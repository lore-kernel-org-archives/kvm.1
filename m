Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE63A8FF7;
	Tue, 19 May 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186296; cv=fail; b=OM+gVbvVG69uBxpoJgnJSGFocbHZf1go1NEyVlPQkJxanE0fLeZixM7yLJdJnFN8kIfLhNoq9LAoS9FxoDveUn0czU2UWoxXGoQ+SIcamxMhM+6+3Y1UVRRmKPRPNMVSu4uoCTKpiM+WAvs0fGTuZRErcJLxB9AJzxUIU8i0LgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186296; c=relaxed/simple;
	bh=n1Xx766sqLCE+5/WOVElGeVp4H+JFjR2oufBbFJXWtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SecQkvup4THLqZBU6rnyte2Qw0uE2hBiK8AtHZqRQM6yg0Vq1GaO8qNj5hc+DRPyKq9DJjl9EPy/816x/oJ4bTKlYEGzwCJOvDKcc1zDQI0arLPSstS6RgcUEla/mZXmTF4+ncZK0wI0b2RCWTefylbI7REs+BmqmNsWhCCVSJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2a3GM3B; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2a3GM3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779186294; x=1810722294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n1Xx766sqLCE+5/WOVElGeVp4H+JFjR2oufBbFJXWtc=;
  b=W2a3GM3BlyUWUE0AdMQ+ptIofZbijN4sKMF9ps5weRbZYORB5ahCZUbs
   puJalXffuZcjEosAU7YRsFCJreC3GSNaw6DegJY51UL1qpXTcWRusFk87
   vrgPJ2lFRnjTHqBGjESo96teMU7z98ibQzHecre57QNdE1YfpEyfjtybS
   je3dwCYT2pWRXTsYDwTpoHyfTP/DlWPdDDP/5cyH/tfwixk6nOFb35qPJ
   FQOYvMRBicd/eiKn25fSJZ/Ns72GkWZ9zxpHvrzWds3zYuay9d4BU+auq
   7XkG8sJGs4SMMmKijrubalITJJFx85qI1Zhezj/r3RlVo1QZOxiDCDM4c
   w==;
X-CSE-ConnectionGUID: ljPyGyrBSX20jYDuTIxrKw==
X-CSE-MsgGUID: cgyUMrWNRASC1HYmg6/gNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="105520318"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="105520318"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:24:54 -0700
X-CSE-ConnectionGUID: SImPdcD8R+2fxYjFmImYsQ==
X-CSE-MsgGUID: LkTt4k4QQmmq3WfP+uS8iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239783560"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:24:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:24:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 03:24:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.53)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfykp1hQaPO/JVbYAxzBlr544C7PwXBLCZoRE6A5c6w9e9Z79UTsNVqSLf2fPrAN4YQz96d/X8D/FKerraGqkOU69swsZ5vaUNnvYZrbgjO/oRkw8s2JBa50qaxEoaEWPV4IXDc4xd4vtDcMrOdTD6aRHmaPGjsxY6Z++MqcGm6Qz2ujibWQP9ZWKAnTNsGqOnLlnalosdoxSW3cPnyf7JeeSLB8hBW2UgS9OHaUszMAYHIS0k+s7NBPdPXZhD8EqAOid2+/LMqA0CuMriLD3Kpi5YNbs/6DpKcQ5/zNqMC1u2XWCLjSgFrIxJWmT5U9yL7nWB+OB9IHJILQh0Azyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtzvHao+eg5NO1URLgrj56TEeglFyDN8tPw2QJXKJYE=;
 b=jFOWC1j/L7+6ZO7L/X1EBjCVqGNWj6RfC7mJudg0nmiZuB+lQQMVlsByJfYBM+0HJODCgy3yokb0MSUhaULfAnXc6vqo/FEDxVizjq42hWWOzlfTUhxgJlss91564uPHl4teoJ9qqrJ0EgyMLiJ5yXjWfNZ5zdLCn4Qpd/d7VMEF2UPe0zwD6pOUqTJouYkfRpkEdjiX1nVeoXmpHKXgIg8XqKq4rLSj848OrS916vNVi5mH01PH9dgYhoEy1E7xmyzCYqFc6ATRzE/w8C78G6/fPSZviKpNskLz6AK6CWOJMxu/IkpjEdV4mac2vKIhb5sOpINwvYHcY6c4LJz3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 10:24:48 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:24:48 +0000
Date: Tue, 19 May 2026 18:24:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Shahar, Sagi"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Message-ID: <agw6Y5QTWNfvR+QV@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-3-chao.gao@intel.com>
 <c7d64460-d03c-4198-9320-8afceafcecb5@intel.com>
 <agrFTv8Lr3HeNM6P@intel.com>
 <68e91c7ae1d10bdff73dd178d0e4ee48eaf1cfe1.camel@intel.com>
 <60dfac5273fa3bd5b5d31dbe6b8f32a60d329a78.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60dfac5273fa3bd5b5d31dbe6b8f32a60d329a78.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DM3PR11MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 59155e90-91f7-424b-28ab-08deb590dac8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: yPnqjrbqlhGuzLTs2k5uy9B63Ag2r5vr2dFBevT2LsInRg8kgE91Tic2+Hjy7GqyCHhFQ9HzcbdZbrP8pk0WH8MspNA8FNcQziX/gszikitDWJ1uL7rxVyIkMxLA88LOoQ8abysrATLgfPCPRDNFcNOkL9ZRzqNxrJ0bfdVb2T9fNE6Mmi1g/aXC5Eq0DkyXPOHUpd5NjnkOKfSXHU1OsS+cscwsfdbxpoJGJfiIKLqGibEa8dEz1+7eZNqMDm9MZQUe61WhnxvRWEpbYnj3PLfHOlu2cckjwmjAS3mx1pmSKKvNe2Ktvz+iwrDwcOtPvk2Ef2unDkGCekxWa4aQeSWKwIjaWGG0Qb3RBAtKFSkVUEUvD4ZmthiHL5UwV+TZJeuN0UQpIStIv2e7rdqUY2SA1DcNwsOqtqvikmFCjkLlb/1/F7+QVOYgKs43dTCHZblgQ6P+IHuMoEaPqj0s5vl4SdlUKuM8ZDX+Kord+efPbrtncWxd3Q7BPs1zw50BomYFLjycD5DjGTW0koP6O3DKJBJjHZbRzlln+HFn+8IqkPRorssOfXXOKOuPV15XeeJsd3Na4L2svpb6UEqgh1R+79a5LBR2yuvxVOcIYn+V8iVSt+B/PxvzIWcabVUWzpNIhofGlVLAxlylAtH6tPQnj1cbd71Bfdmw0xs0c8WIB6tM/e6ghHmr7lgb9vyC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttgn7o4ROlli8Fn5A5SgM7ud0P55n5veKcZPp0itsEcHwBq8USvLMqNNvwhQ?=
 =?us-ascii?Q?w5gE0JQyT1fmaa1Srj30/UNlc620Iq2YZYE93jVh6F/RvHV1IfhLMpRAeY06?=
 =?us-ascii?Q?Ey2Zo/3VchzjyCTDt4eoVNv69cIGrhCdXheVt0lTP0gdQgp99o6yTSlkhQXT?=
 =?us-ascii?Q?GqFnYSICQvfxK0cdCq56oX/oAYjAlH3TLvD/W4rScjQtBY0eryPkRd9hzq7P?=
 =?us-ascii?Q?0Z+KF0SL0Aq5WA5HI5p1bc5omxna5Lw7GJYXd8pFj2CTqqDhg7UM/TC0xE26?=
 =?us-ascii?Q?AhrOAD/t8pyq/BzBY+keDq5M8lz6lzB7eQweeeoNPPx4EL5r2lx0r2AoGs73?=
 =?us-ascii?Q?Ze3P/lAeubKzYu+ij/dOZMq0tvDw2I9rOusEvgS5G4Ghb13SXqeD1dH6v6L6?=
 =?us-ascii?Q?9xdHrwbdnXVsifEJUbgGlUg4YPgz39ZkkcYeHzR4TYvl68QvEhziWsEg0oWt?=
 =?us-ascii?Q?00gvXYWuzupGP8BRK1UnL+APBMO7C2fTguzT3Iwyl24cYYLICi8HJoJG4z+B?=
 =?us-ascii?Q?s6Czm/rqn3dXOW1cCH+HxSu8/rvz0w4rOEVvq7WsflYv4MJIzWpUN7wseikK?=
 =?us-ascii?Q?bhvdJlKTNQVj2ERHe30tJPBdtwDAOXlmEav8GEo6F1GZMWdR+g8ngS1C4Y14?=
 =?us-ascii?Q?lBUb5r339X+tF6QYRyWxzrE2uFiysJH77YEPNokpyNHhRVcjPz/EGtq/O/Or?=
 =?us-ascii?Q?e1Jmbjp2EsLHalSRlwD9QVVhTkzuCo9ff3jzbMBLHDaNYRKGFTslTgm6nF6E?=
 =?us-ascii?Q?w96wjP+0By40CtdW6knA/iruBGUl+MU3oQWi40+9zGxow+saHF/o1g3C1DwX?=
 =?us-ascii?Q?xZOjGmX2FM/5f9eoudUpiJoVoqNZP7gB/51IkBLg+mX8Ow2bD3Pc07qviyL9?=
 =?us-ascii?Q?AvI6r6Uit//0QJXJ8Z74144jesZAm1ODqyAPsvrA/YHUDFqFbJmVL+TP9l+M?=
 =?us-ascii?Q?Ii8I/IkgcF3GbuapdyuJ9g+GfvWdZRMmOd5YP0BL+0Q7FGQanAjQsUuL1205?=
 =?us-ascii?Q?qURSlbyyhVwEJEil1T2+jz+Bg6uoPbCrGqWtnrt9iVPrVvG8ZBNHrcUAliNP?=
 =?us-ascii?Q?1vI0l0sAzx+4Ia77ykKU3xNrc7caUGQPxA2IpnvhRpggZ9K2Xqkws5P4Gry/?=
 =?us-ascii?Q?hojlNrLtsrOV31IRekcNoV1GGYEgjARGz2ngiVoFzvjrBvAkGt5/yOnTDEHt?=
 =?us-ascii?Q?hSatnAAWym9qYpMDhBkT2w1PLkgXF57mvksJAKcmO7HJrnjgLdUCW/EZPPYP?=
 =?us-ascii?Q?fMZlGh/Y4OFsICiCvrHDt4f1dZ8yEYpZIYK8DFR0i9Lk7acNKWrIXo083UcD?=
 =?us-ascii?Q?cwA25EGjcm6xzbEQ7R/zW7jtCTIXgyOxBjQeX62ULaIqJ+7joD1ojF1F1Nui?=
 =?us-ascii?Q?fEiunWMEEszXDzsnSFhsGh+7Y624RWWdSSu5gVmrQxHsorXsQf2E5779Sz0U?=
 =?us-ascii?Q?F3aLv7XQdhKFuk1Vo8eKsNloxQ3KGy88XT57kG2BLtFvld2mJUIjrjkaFbym?=
 =?us-ascii?Q?d8+ZxNhe9hJyTI5IGMo9rs7KOjYBrdMAvvHbgUB10AmvC0PG3DantqUslbk4?=
 =?us-ascii?Q?2A9n2H+wJ2a0ZZprpmBwt96bXFcKD4WdoJUGoVInw49gJSWFHJ1rq/n6ekEh?=
 =?us-ascii?Q?n1HmKLXt8JqPGad/MVEyX5RbtJTfLxGO1Nb5j/tNLbPrdM7VEcaBOOBbI7lX?=
 =?us-ascii?Q?Xlni/+pyTqj5ak6AL1ndVzprsEiJJw8kiQqEZPWpQqob5SpKU2F1pNxMYYWu?=
 =?us-ascii?Q?wTzUIuz+pA=3D=3D?=
X-Exchange-RoutingPolicyChecked: JsL7OwVZO5UHDvHAoQS48nWDFzExs60xHj/VAS76Po2NYW8maaWvFjpXv6uftjIoOToguKdm0UE36ytu/GmNLtDVYcFXTyT84PAFrsQ+45RfOCx+z+BZooRFNDNK/NQE/WdHqFeTA0qzzfaClOUY1tuF9N4tiV9D755aJmv0zN1T/A+hLc77443pkfQvPqtXNH8525mJQZO1WkFUlWnOoisqCzzjUelamlqSEQPqhrR794FJzTWg7mJ1+j/MYuLesk292fodx5C6Ye43z78vqraMkYeEBTM4Ao1CkcsWCiVWKBIoXH2mlRXR9lPucZFQy/moZGBmslVOKW7UtKDkCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59155e90-91f7-424b-28ab-08deb590dac8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:24:48.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rd2J7R2TKQH9gOh55H0ZZFlQnZe2iJjemw+fPYza1CfuqFUHmi4esj51ScQVfywegP23yqkdw9dUOcII9yDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8714
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 09:59:02AM +0800, Edgecombe, Rick P wrote:
>On Mon, 2026-05-18 at 09:57 -0700, Rick Edgecombe wrote:
>> On Mon, 2026-05-18 at 15:52 +0800, Chao Gao wrote:
>> > On Fri, May 15, 2026 at 09:15:47AM -0700, Dave Hansen wrote:
>> > > On 5/13/26 08:09, Chao Gao wrote:
>> > > > This prepares for TDX module update [1] and Dynamic PAMT [2] support. Both
>> > > > add new TDX_FEATURES0 capability bits, and both need those capabilities to
>> > > > be queried from code outside arch/x86/virt. The corresponding feature-query
>> > > > helpers therefore need to live in the public asm/tdx.h header, so move the
>> > > > existing bit definitions there first.
>> > > 
>> > > Please don't add unnecessary changelog cruft. If you need this move for
>> > > this series, that's enough.
>> > 
>> > Sure. Will remove "Dynamic PAMT" stuff from the changelog.
>> 
>> I think it should not link to old versions of this series to explain the
>> preparation. That is very confusing. We can just explain what will come in the
>> later patches of *this* series. I'll circle back and propose some verbiage.
>
>How about?
>
>Future changes will add support for new TDX features exposed as TDX_FEATURES0
>bits. The presence of these features will need to be checked outside of
>arch/x86/virt. So the feature query helpers, and the TDX_FEATURES0 defines they
>reference, will need to live in the widely accessible asm/tdx.h helper. Move the
>existing TDX_FEATURES0 to asm/tdx.h so that they can all be kept together.

Yes. This looks much clearer.

Thanks for helping me on this.
