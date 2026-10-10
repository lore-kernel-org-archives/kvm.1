Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D492ECE86;
	Sat, 10 Oct 2026 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614152; cv=fail; b=a8KqKPfn7ElzK0PRMpkU922TTJuaBvAZEmFu9UBWZOPHDuSE4Wio6sdEvIkBW5eHmyYpx7nfetC2EqqI+pE0GMAPW964iegrFGlaAau1eZKzTWsJpeBoa6SXdfcQX9Qv240bDonp5zs5yeTOM06W2mGf+pH1dxDo4xFKSTMPIIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614152; c=relaxed/simple;
	bh=PNqdmunk3PFFzIx7skSFuPePsz1vsA/z6YsB942LnFI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V15X4/6fhaB1DmJ45xpd1cUj0dtmccFiyUr4dPR5KC1hTSPgeZtqrF3cblMoPrW/j31FVy2w+XQF1ohYiZjqkfgtm6FtOEKUo5hoWL45l39DaJfOOUSHnjI44YWqh3slRjCs9uYh8jF3QDl0YZV5qt/yKbwlXZHBQ3gGO4CG3JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZRA+kPh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZRA+kPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791614151; x=1823150151;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=PNqdmunk3PFFzIx7skSFuPePsz1vsA/z6YsB942LnFI=;
  b=JZRA+kPhLzKX4gB9YZ5RmH8/lzQX1ZpIHt8Z81bu6aQvIObo5GJsO055
   oz7ICJ7Y481ze0LgUa8CpSjRAMKEm0x80OcRWdLFBD3rXyrEuagej7zmc
   2Rp0X/A0zw/3afAQKLfCuC0xOPULiV+4/P1+mFGrmNlzbhLrnmASXCnxV
   nCk4dffHwjKEyNgM58dIcs+fgu7FULbjCBB7R3iVHjqyob9TnbjzwRqwr
   2sWlLrRMC3bo6dnD6RL1xtP9Uv562GUi/vbsecj951TBhhMK/OFUsIWbr
   eKDoO+JUTdG+X89JVugJKcAAlgpTnp6b61KdTA+r2LNi3EWc13BznPk1F
   A==;
X-CSE-ConnectionGUID: QHgQreggR9adi/4Y+lqNMA==
X-CSE-MsgGUID: Qh4zdNLFQfadSncP++f+3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="308653"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="308653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:35:50 -0700
X-CSE-ConnectionGUID: 0Ccb8MSCS6eb8tSdumzeLQ==
X-CSE-MsgGUID: cEHHHxMPRYCLia0fIYvXRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="570685"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 23:35:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:35:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 23:35:43 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 23:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuCEG3nVon3DTblkG+laZ8bTer05aXsGdntPwJnYtIJnbAxJPYzop8Fn54re61yqaPevs8DBm+uhJn989NFp0XmEdlvd07mFJv4hD7tJajdo7BY+KDLEbdHrOHXYJi5d6u1WQdaq9rF/Sd1EadURbAThgMDd3E1uGOdkmtiOw7aAnNxW5tmfiOehAtVQBeobNTSdp4Bv4VT0vx/r2QXWqn5zxFSyH09Cx+Qx1fFbjTw9Z8dvbiQoA3LGoo/nPOTKpv60Kl5IZ1zwTFAPXrUX6PL1BSkWQqMxShK4qXTdmUnq0NYbCxq5C5oT4/3LbTqE6jQEm7NbxOE3uOMZIex5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVPGhsUMImcqaFubR5NXHh2ev+ECGJLL4LT0UOXqb7s=;
 b=vohSl51xsDh2nrbVRmrTPupYGB3PoXc1xJkt6IJagn+amS8yiEAoo8Tu1Onov6rfXuVG3NFTbgBTS7XJMw1sHfnB8v1eLBWHOQNp573a7hS6syco4MphzOLhaGXrDrwlRb2zT88VCzjqxypXGMeO7Px9I/ckG7ADArRi83sM1MzdTmg6/kSFjMA5h5wRPnwDkqevwwgjHTDngzbf7zl/SpYQ7WzTjMwAxlFK8cBrgHYN9q0zyIOBN3akVQVuM8ir3VRCJG6CM7RxC6QPNJ2cA9Kdb0a23XfIn7EDnfNcxdyv6phA6rWerNm0RinwxC1PW+NytmDBgOSS8APHPeUaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3243.namprd11.prod.outlook.com (2603:10b6:5:e::19) by
 BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.18; Sat, 10 Oct 2026 06:35:31 +0000
Received: from DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1]) by DM6PR11MB3243.namprd11.prod.outlook.com
 ([fe80::6c83:d3c:7952:3ee1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 06:35:31 +0000
Date: Sat, 10 Oct 2026 14:34:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Message-ID: <asncgdZbLRuPAEhu@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091021.15583-1-yan.y.zhao@intel.com>
 <90ecae2e769c85d5c32a2d31f004dd007f4f6774.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90ecae2e769c85d5c32a2d31f004dd007f4f6774.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DM6PR11MB3243.namprd11.prod.outlook.com
 (2603:10b6:5:e::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3243:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fa66b7-d7e0-4a44-ec08-08df2698ae6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|261009223027099003|11063799006|5023799004|56012099006|4143699003|260925021911599003|260925021311599003|260925022911599003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: L8Kr1+HQWpeeonU1R8jUyXcg3CSZbbmilJVXkMhqvQA0sUmQuJBrgbRTI2l2Dr8dk4YjjenjTWMqg7OkE0iLwY2V3Y1jVl8liKaTHF7hxOluad6q1IXJkJgVkq2qskFpKjzLXVgDE1unR9lgBhN+eRbYzVI0r1QT/acb8SEQUT6nJOAYPhJ37mdJ5bwZUYxSfBhVixAXo14aS1t67cDGVqvInSNKy8hKKnXxnZRtZ7Wn1aITDjFeF2o16KZRFXxuBF/0sYCeKgbBfB1RWKmL2sTeHyTtPlYo89t2uvpPM+HY2heDEyiEAw6nMRShV7e+dqf2QhwutbIXH1tVAOtCUIXPn7gxO8WjZsRRfPmPKTFQ0lozoDWJ6P30LOWdQjCt8rpHDZVYszYsRw12Um3A7ksz7BIPiX3aZOomXVEwx4Q06yRa0i6XdljIiasllZv1BO28N03MgxD0K0t+bFJHbI9AiQa9vVu+NhF+KIj8liug6anNVyewkBtrGL4vwDeyszAxjNASIB3CjQMbCZaL927Cq49uRhLjKDoKEBQ59FmCe7BK/asiW9rnN5Iei/yrmB4wb2/mEeMEEw9Amvhy8PGDa+LA6kcLVhsCyY3kuzSSyAkCfWdpxagQxC4Ek3f0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fp32QQrvmggE4rPQEUSjGEPDcKyb84juCHP7XVzATfqfDO81f6U4MJrc/Coj?=
 =?us-ascii?Q?5bLXWDdRmE3egQR1IVVpTyP7nOwZtl3BH8h8Y2eX2joymBKvnjL6PtRw0rzQ?=
 =?us-ascii?Q?GhYH+B8pv0fdDSWPRlE8Z0yVaLrcVsOyqjAad2p2pRCMoEoI+6jIV8GudI54?=
 =?us-ascii?Q?4eRAG8fir4j8g7gHyKrtmeQ8o67k/ISXG/B9hU4HSea4WgNB3MOc40IvFycT?=
 =?us-ascii?Q?dUN4XNVm5+T84wCBJLl86cEkGJIu/tAyfych3PkDtrG69R4T/BVMqo/uSRIG?=
 =?us-ascii?Q?QvvTNsctvyLrq4Ats85marEBswRNs9Vc44W6AJ1qmlQGrxE9JP0tSJQ4LKEQ?=
 =?us-ascii?Q?mH71F9HE94EhmJDHtAdoTgkj+Wz74rL556urOuBj47SLMHzStBekCSD7jleQ?=
 =?us-ascii?Q?nFV6CMDznr9eFvz3uXd1DFVZIg5gwQzctiAnZGE0Zpx3+0jgmHBpWWBdYL2c?=
 =?us-ascii?Q?lw/OENsZJQM2ssLjTNj/LrBJlCl9zjLA1nFnIEkMe0JEkQUtU2mnEsL8UfXC?=
 =?us-ascii?Q?xUVxNgUUk5gP+Bj/eSp4tKVm/wtvJJPtXxvDT8nCgn6MuZLjEW1Q0WaGFLpj?=
 =?us-ascii?Q?nYmOCZIvZIq5upWpvij1dX4bcUlwlooISNOBUOp7pEhiVCLcLaQpmjZy2zF5?=
 =?us-ascii?Q?ZPi/AsGP0w4DuM7gvYFdtInC8KDvqJF47pujrJ8owIzVMi4gXWcKo2Rx7Uic?=
 =?us-ascii?Q?dljPngnoXyfdEleEXeN29uB1JU87AGb6S3Bd4tlDJVHwSUEL2Gn13UjBJjdt?=
 =?us-ascii?Q?i4Lfbr128cPezO4GO7O0GTSXXmCpdsyggJDqbJHcyT9eLjj4ve7NQAHlbKby?=
 =?us-ascii?Q?FrKrBitN6/mET1N7mGlTLFNIKOzSRyjnIHmZr1jJTEpVPiUfaC27gfEMFr5E?=
 =?us-ascii?Q?xPIgtFSrDTxbw+/q0yJUKWZqX76z7eag0nqFNRG3pjuh6bYGHFJIbwTqJOft?=
 =?us-ascii?Q?VfACL86/PQNIfy7qmC3p5SWTbsbV6Z/hoj1keBoConQP7zKxGMHce/XAG3pP?=
 =?us-ascii?Q?1aDBLa9Kz7+DZo/PCfZcA5VwMdiUI35tc7QrH1F1viBRdT+5sp4srv5kWPdJ?=
 =?us-ascii?Q?PhUdtf2Wbz9NxG+JmwKNQaUBy7zQSQI5O4j2zd8EGWY6mvHJZup3v0TNJ3kX?=
 =?us-ascii?Q?sutoTmBTebsYfWNO81sL0XbjMjuWkVuqNXAJgYq51a8McN5nIYHDD2fmK7vN?=
 =?us-ascii?Q?mYMXX8PDxvTgFKj1QQntRQcXRe27iB+vQ591e+q9Ky/gNlrsLSK4iJAnXzDm?=
 =?us-ascii?Q?oS58Bf1fakifxrmdLbLp5cOex0TM0UVJ1R6MHuBIf8zf1ReSPbs2+OYUVnqb?=
 =?us-ascii?Q?lMcDC7do/Oii05qK0PHzpoiBIj/Vpyzyq7tFT1k5GzuIIdsK6tSS6MEIQf4o?=
 =?us-ascii?Q?PZBLozUycw+Lz23T70ch5GfUvzDgDcZAGk24w562h+e3UZ4u7kn2lfQIxEL9?=
 =?us-ascii?Q?YqrqS0UslNPRhX1jkel/mx+HAPmysTvxCcJy2dQX+KXK7PR0DAs3EQ9kyXdS?=
 =?us-ascii?Q?N6QBXni4ul9WcKDBSJoFUG2/2cX2CL3oI3MkOXuooBNLuNjq45vdkks0sK3I?=
 =?us-ascii?Q?5EadsffTRq5HSVUOLnWNu3R0BFQRZQpC4K55pCiTlJ/xay3vqZNLlhEKBB9T?=
 =?us-ascii?Q?QOflbQRy1LwYPt3EHgKfbmixnEkm0HDBAnAfx8AqmRuiuw/+6xIvtifKNrFO?=
 =?us-ascii?Q?X1yXEEA+siLWaZqjc74aAoSshUguLicnc7Tf6r9A5yEnDGrXtkxqAkMY2Vve?=
 =?us-ascii?Q?uEOAudLsnw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ebTb6BX4YKEYVeUI5lZCEDnTLtavZtmiNB7QnAj9+Y9648CQrdavrR/HLMYII/UeTNTUdWvrttU+nTAog24RjPvAVtwpVMM42DcdkbxK5z+G0yn2KvX8To6e0nb5hn+/DFCv+zaMLcIJ0d7OjX8Z8NPpE6Ax7NplQTHvy4TcFI9988mYbVtFZjgWDrQUKilyvuRXqREWm/fxkDGJpdM3iisqrXh3fSlTm6OtINzvOieTmQtsy0CcjRk793vQeo6OntXn1WffQ0BjiV/H25yJ9z8ftXDGZ9LmBvqCWHiXO6fsvHMKOW1nvzfCIZ11473vADmzhFcNCLwq846YTdQTrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fa66b7-d7e0-4a44-ec08-08df2698ae6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 06:35:31.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztOHZanYwznEADzD/sQJWs9zV0b0r3K5UYCuA3vq1Vo4rvcDHAo+p/PwDg5QGyikbZZi/CHkl4Xa7M/Iram1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 05:52:05AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:10 +0800, Yan Zhao wrote:
> > Add support for splitting, a.k.a. demoting, a 2MB S-EPT leaf mapping to 512
> > smaller 4KB leaf mappings.  As per the TDX module rules, first invoke
> > MEM.RANGE.BLOCK to put the huge S-EPT leaf entry into a splittable state,
> > then do MEM.TRACK and kick all vCPUs outside of guest mode to flush TLBs,
> > and finally do MEM.PAGE.DEMOTE to demote/split the huge S-EPT leaf mapping.
> > 
> > Assert the mmu_lock is held for write, as the BLOCK => TRACK => DEMOTE
> > sequence needs to be "atomic" to guarantee success (and because mmu_lock
> > must be held for write to use tdh_do_no_vcpus()).
> > 
> > Note, even with kvm->mmu_lock held for write, tdh_mem_page_demote() may
> > contend with tdh_vp_enter() and potentially with the guest's S-EPT entry
> > operations.  Therefore, wrap the call with tdh_do_no_vcpus() to kick other
> > vCPUs out of the guest and prevent tdh_vp_enter() to ensure success.
> > 
> > Invoke tdx_pamt_get() before invoking tdh_mem_page_demote() so that DPAMT
> > pages for the new S-EPT page table page are installed before the DEMOTE
> > SEAMCALL when DPAMT is enabled. DPAMT pages for the guest memory must be
> > installed inside the DEMOTE SEAMCALL, since it is impossible to do so
> > before a successful demotion.
> > 
> > Instead of allocating and freeing DPAMT pages for guest pages on the KVM
> > side, pass pamt_cache to tdh_mem_page_demote() and let it draw DPAMT pages
> > from pamt_cache before the DEMOTE SEAMCALL. This prevents KVM from having
> > to manage DPAMT pages directly via alloc_pamt_array() and
> > free_pamt_array(), or having knowledge of DPAMT-specific details such as
> > TDX_DPAMT_ENTRY_PAGE_CNT.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> The SOB seems wrong. You are the the listed author, but these don't have a Co-
> developed-by tag.
The current implementation has been substantially reworked from the original one
https://lore.kernel.org/all/b387dcfc499d2f17e448cd4574115d1fd2437921.1708933624.git.isaku.yamahata@intel.com/

Should I use Originally-by tag?

> > [sean: wire up via op set_external_spte(), merge in DPAMT-related code,
> >  massage changelog]
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> > v4:
> > - Hooked tdx_sept_split_leaf_spte() in x86 op set_external_spte() instead
> >   of in x86 op split_external_spte() which was no longer introduced in v4.
> >   (Sean).
> > - Renamed tdx_sept_split_private_spte() --> tdx_sept_split_leaf_spte().
> > - Merged in DPAMT-related code (i.e., passing to_tdx(vcpu)->pamt_cache to
> >   tdh_mem_page_demote(). (Sean).
> > - Assert new_spte is non-leaf. (Yan)
> > 
> > v3:
> > - Rebased on top of Sean's cleanup series.
> > - Call out UNBLOCK is not required after DEMOTE. (Kai)
> > - tdx_sept_split_private_spt() --> tdx_sept_split_private_spte().
> > 
> > RFC v2:
> > - Split out the code to handle the error TDX_INTERRUPTED_RESTARTABLE.
> > - Rebased to 6.16.0-rc6 (the way of defining TDX hook changes).
> > 
> > RFC v1:
> > - Split patch for exclusive mmu_lock only,
> > - Invoke tdx_sept_zap_private_spte() and tdx_track() for splitting.
> > - Handled busy error of tdh_mem_page_demote() by kicking off vCPUs.
> > ---
> >  arch/x86/kvm/vmx/tdx.c | 69 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 3dcddf1b48c5..3186c4808cae 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1873,11 +1873,74 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Split a huge mapping into smaller mappings at a lower level.  Currently only
> > + * supports splitting 2MB mappings (KVM doesn't yet support 1GB mappings for TDX
> > + * guests).
> > + *
> > + * Invoke "BLOCK + TRACK + kick off vCPUs (inside tdx_track())" since the TDX
> > + * module does not yet support the NON-BLOCKING-RESIZE feature for DEMOTE.
> > + *
> > + * No UNBLOCK is needed after a successful DEMOTE.
> > + *
> > + * Under write mmu_lock, kick off all vCPUs and disallow vCPUs from entering to
> > + * ensure DEMOTE will succeed on the second invocation if the first invocation
> > + * returns BUSY.
> 
> How about putting these in the function instead of up here?
Sounds good.

> > + */
> > +static int tdx_sept_split_leaf_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
> > +				    u64 new_spte, enum pg_level level)
> > +{
> > +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> > +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> > +	gpa_t gpa = gfn_to_gpa(gfn);
> > +	u64 err, entry, level_state;
> > +	struct page *sept_pt;
> > +	int r;
> > +
> > +	lockdep_assert_held_write(&kvm->mmu_lock);
> > +
> > +	if (KVM_BUG_ON(!is_last_spte(old_spte, level) || is_last_spte(new_spte, level), kvm))
> > +		return -EIO;
> > +
> > +	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
> > +	if (!sept_pt)
> > +		return -EIO;
> > +
> > +	if (KVM_BUG_ON(!vcpu || vcpu->kvm != kvm, kvm))
> > +		return -EIO;
> > +
> > +	r = tdx_pamt_get(page_to_pfn(sept_pt), PG_LEVEL_4K, &to_tdx(vcpu)->pamt_cache);
> > +	if (KVM_BUG_ON(r, kvm))
> > +		return r;
> > +
> > +	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
> > +			      level, &entry, &level_state);
> > +	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm)) {
> > +		r = -EIO;
> > +		goto err;
> > +	}
> > +
> > +	tdx_track(kvm);
> > +	err = tdh_do_no_vcpus(tdh_mem_page_demote, kvm, &kvm_tdx->td, gpa,
> > +			      level, spte_to_pfn(old_spte), sept_pt,
> > +			      &to_tdx(vcpu)->pamt_cache, &entry, &level_state);
> > +	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_DEMOTE, entry, level_state, kvm)) {
> > +		r = -EIO;
> 
> Not trying to rollback with an unlock in this case seems like the right call,
> but can we have a comment justification?
Makes sense.

What about:
"Something severe went wrong. The VM is going to die.
 No need to unblock, which could potentially fail as well." 

> > +		goto err;
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	tdx_pamt_put(page_to_pfn(sept_pt), PG_LEVEL_4K);
> > +	return r;
> > +}
> > +
> >  /*
> >   * Handle changes for
> >   * (1) leaf SPTEs from non-present to present
> >   * (2) non-leaf SPTEs from non-present to present
> >   * (3) leaf SPTEs from present to non-present
> > + * (4) present leaf SPTEs to present non-leaf SPTEs (splitting)
> >   *
> >   * - (1) and (2) must be under shared mmu_lock. If (1) and (2) are under
> >   *   exclusive mmu_lock (currently impossible), contention errors may lead to
> > @@ -1888,13 +1951,17 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
> >   *   (currently impossible), warnings will be generated due to
> >   *   lockdep_assert_held_write() or TDX_BUG_ON() caused by concurrent BLOCK,
> >   *   TRACK, REMOVE.
> > - * - Promotion/demotion is not yet supported.
> > + * - (4) must be under write mmu_lock currently.
> 
> Currently?
> 
> > + * - Promotion is not yet supported.
> 
> And we are not trying to support it, right?
> 
> Can we not make this imply some roadmap of enhancements that may never happen
> for a long time if ever?
Ok. Let me correct them to:

- (4) must be under write mmu_lock.
- Promotion is not supported

> >   */
> >  static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
> >  				     u64 new_spte, enum pg_level level)
> >  {
> >  	lockdep_assert_held(&kvm->mmu_lock);
> >  
> > +	if (is_shadow_present_pte(old_spte) && is_shadow_present_pte(new_spte))
> > +		return tdx_sept_split_leaf_spte(kvm, gfn, old_spte, new_spte, level);
> > +
> >  	if (is_shadow_present_pte(old_spte))
> >  		return tdx_sept_remove_leaf_spte(kvm, gfn, level, old_spte);
> >  
> 
> Except for those small comments, overall looks good to me.
Thanks for the detailed review!
