Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FB1E0DE8;
	Wed, 14 Oct 2026 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961352; cv=fail; b=RVIDI/P8YCi76LO2yiquYQtiWuYFq8+x4HVISAw/lf1/Hu0KLJDI6w7o3Ux2w51xMLrvhCk5AFBat5fvo938jTJoqN2cZDriqCrLV+v19l8x9lGjh/pK7o/wa6o3L4Wiofw5q7H0ibPmTC+pMka6mT8By/r9HFT6DVU6pB8ERPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961352; c=relaxed/simple;
	bh=6THyxvc89ygYdCpf5NN6w6JQ3PsljcvZCGmJstaDaHo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jf7W9bmV+fqo7rmIuN883BGpqs70KTFLabx4DeIBkooLwOldJTSUh2jxMHXFicg412bhovXGgc2Uh18XeRC4WUW+Y3GvaPzC/DYp2bF3tZLSy4+DCMS2dHtSRirf7hqiw66XPRtnEEW3/saS95hV8U24KGWgoMLWO0PSCp9dyqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoJ8EgGS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoJ8EgGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791961351; x=1823497351;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=6THyxvc89ygYdCpf5NN6w6JQ3PsljcvZCGmJstaDaHo=;
  b=CoJ8EgGSOG5U9OxenCKLO20RRItIMnJPHappAPz8OG6bfiS/M17q8WEX
   mH+ilym33cx2wkY9vDShn8+EB4ZkqbV1Ee3srMvks/M5eYB4avzCQUTWS
   6QteeodRbIn+R7LaJJwANxgHJg/T1UR8NwIYzl44+oyfo0nRuCkNE2HHr
   iTFSKQjS0GCuB0eqpMAYECpO3ANvcGkmp8pCBCxO5C6E+HSBMp76q2kMn
   94l4l71AzhuewJNk4pdGMNXHWSBXTfq2MPNKcAqC9rlTUeueW/Zru5X40
   tbQNiFIXGN2Zo1DtJGfhpul/2Q/K2j8Fjs+x6Nw6k6wTrYk8VkCdgNBLO
   g==;
X-CSE-ConnectionGUID: EiQR1LKvQz6TtZBg8S8ROw==
X-CSE-MsgGUID: q83teww6SOCzxhuEAAMhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="590564"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="590564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:02:30 -0700
X-CSE-ConnectionGUID: yADfRevSScGneCJeR/YBzg==
X-CSE-MsgGUID: wVn7g0veS7qUBqVTZBZVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1369277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:02:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 00:02:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 00:02:29 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 00:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqm6hVo3WzYqr5ad91V0K3Ebvw5dnZor/V5PDS79PQSC1eTMAXyMRxLgTO86XfGFLP3Cf9IqlcBqnkHnztxSS8rWPoW60Utc2EvDZWUpAl524VxL7cJTUqvSRaafYtCPqS6HL0JSZwieiSP2ShYbWN9GcRSKvc09ZA3B2HOxVscfX2NaI97LJQYoKMQWvwXk1ejSpjBYJdtlZlXrK+BXaEoLZ1B2aTQ7fLtW7VaNU61WprX76egPnICugq1H2QOPQdZyxkV3kRzHyYunKDMnb/0WAZobutP8ITnR/VJcdH5jHDl8Fmyj44EgCcfKFb5OtXBoA4i29yCLQWWkt0+kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/COseEcF1Mv2Gb+iNy61qLyWq+Qr3WsLg+gGlIV+JEQ=;
 b=OsztwoS62IdvGl9/RIyxkt0UPSRaYWPQmg0iIykgMTHmTMumXoPsH7WdP+PmohugA9djasYaBYzRKg5NvVT7/LdK7YBKaBOqOGXUmCwi0ONbhii9diSCqjYp1PW/JFOaBVeyoCHXuM1rk8+G/sLDlNBhQDxh8m5aP2llLzZywgt4kQaaCZTVofU2yCzRBgCp3dnlgfkdOsHXRLNCii2tzEgc+QjekOxD2X15peBZHpGW3N/fGO6tbwh3BwsXhSivwdgzMYXkvNEzxKDyOTP6WA4IBpnx62+fHnfULpWx7o6sGQRf74QQC5YxHociRLXcke7SERzTpuVGfv3qM56ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Wed, 14 Oct
 2026 07:02:25 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:02:25 +0000
Date: Wed, 14 Oct 2026 15:01:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>, <tabba@google.com>,
	<ackerleytng@google.com>, <michael.roth@amd.com>, <david@kernel.org>,
	<vannapurve@google.com>, <sagis@google.com>, <vbabka@suse.cz>,
	<thomas.lendacky@amd.com>, <nik.borisov@suse.com>, <pgonda@google.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <francescolavra.fl@gmail.com>,
	<jgross@suse.com>, <xiaoyao.li@intel.com>, <kai.huang@intel.com>,
	<binbin.wu@linux.intel.com>, <chao.p.peng@intel.com>, <chao.gao@intel.com>,
	<farrah.chen@intel.com>
Subject: Re: [PATCH v4 15/17] [GMEM-DEPENDENT] KVM: guest_memfd: Add a
 pre-zap hook .gmem_prezap()
Message-ID: <as8orBS6JEafZcbq@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091212.15711-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928091212.15711-1-yan.y.zhao@intel.com>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 425034f0-5cc3-4343-e37d-08df29c11965
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: MU9UkXnlh7cr8qmAFUsU7aTst2Qw8ESLCYJItBTjFMEgY31vVhPrRTk5Dh6j/HZA8FM9ZTCDAUZp+RqL3zEKXEHeGj6CjrHVvPFjxMpUDpWVIcFzQUHKJKm+zMVF1uRz+qT3s9SunAxFnlvIwAfsfqVTfD18MFE3cTDhNGB6a+bi0e2D2lzyFvafPYAvZnifNofw4RAln7zhWT1mVDaj07fSBkx+mJbQ+TF/itRQKhzq0e9IOX+cff6rE22BJNV55Zbyvkr0zTpqv0fNHwijm0qoFEpBPtDgBMS8CEZPVtIBMEnVC0JaaF6XIZrkdGqQhcUjAI4J/C3aPiUjCXi9ZNO2pBffhq97z85tNQ+uBwpF9E8htmZ60yr0qtC7JnV2/nWjIkF4uASUag6aoyMIf5jSy0G3onQudqBDea5XzLW0cv18YEFSh+5DEfd6tLYXgSjgLQJtcESvJOrs9Eg7nRl9c3z0alliVQGoGywJJSqPgV1ZwpbpMULT+dt0MLYyvN/Vh39TaWYcwvELMV2p/RpK4WB2LDEbFJvWx5YJUQVX4eQAKmfxQHeT1l93eKR5/YJ7GSH3UJag0P2+8cTevYk9sCftwslcUmo6fdimz+wHdEEVuZjDNN8LtPbX+ngS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udQWFPSCoqW/ftAjpZpU715AShIl9MVM5mnpj+iqRjmbg8b8SpwLvxojp+VF?=
 =?us-ascii?Q?5nQtN8qCgORRPGz175Ipi2IdlBAG0xyTFbyrLQlTscOhJDF0aAG2wyZ6oktO?=
 =?us-ascii?Q?AzsFpjSUg9eRbMfMK3I6mLRNd2AMlJm2RlkDbLeihMpwFJkL4c6qLKtUneVw?=
 =?us-ascii?Q?jSs8YO1NpGny7F5Fo0TGgyncrgcRTKg4ZIWtZ3q8yOKTd2vRLmOJPWvrcf25?=
 =?us-ascii?Q?r2QLWzvFLPgZu4uIQ4GQeBsb7uNzQAL7TZzVV+J/vhfrN2QKYy/zbZcAKPqg?=
 =?us-ascii?Q?QPwQw8BnXKTKm7lwKlrVI7o/DSJzg486GIQ0Ibl4rXfSuGikZOUEoScYhZ7R?=
 =?us-ascii?Q?0T+q9+4AXBGbBGQAQwhlXPZouxyoWJzPheaAMTXV1cqL9fo+UBaA1B73a0Kb?=
 =?us-ascii?Q?8tEe8GC1X8mPLx003Ib46H9+bnRGjL9aatY5x8zb8UrF8/LD4K2NONOiLytL?=
 =?us-ascii?Q?Y/h73TZCSR0DGpGlu9h5LcrtL+GHME5bjKcPvvuGa68xyJzDHC84osUdJhB7?=
 =?us-ascii?Q?b8qgJ+FTXiq9fX6uHagAjNYVcIBGzliHzZvc28b97RgR3l/iZVvHn/F3m7I2?=
 =?us-ascii?Q?PflLJK3t+48nnvBNIgo+Nmq+56+RvFuNjW7oC+LNCLJtAc7pXe83O4tNKZhX?=
 =?us-ascii?Q?ArNoCmx5PN0mo6hdQy7+nby4kID9O5qC43fdSU9LmwJAHiYSKi4QUuqYA86J?=
 =?us-ascii?Q?Om+JUPScd3+7scFDVf1kLPGVz3TaVbUnR+aCOJlFvk35uOBbkZHgO9Ewqepb?=
 =?us-ascii?Q?8WBlzGOmkQKogkKBys04vNVSNkpvchExQmKS/i3T1gKoBr1N5K68X/sdDAOU?=
 =?us-ascii?Q?DCJsMnUuLd+HyJpZ2frXKGF2EbEjbEb75k3f0oFvzKCVOF7AUJDhZhtitTJE?=
 =?us-ascii?Q?9ko4hCj0L/f6doRnBT5tJT2lpZip7M5YMayJCUdcBdObfh8q3cbA9Z0+otoK?=
 =?us-ascii?Q?5ca9HNHGJz1a4Df+hpOSr0xJIRoqsJDsARgFFn5ljVvy5JYv5zfgAp/UyC9j?=
 =?us-ascii?Q?e+lXCypGpi+DI6OLFSBvEVjdJz/ur9F6XyBr5+/CrSyGmJaS/ZqCnM3zmPAG?=
 =?us-ascii?Q?x7vLha7IB+bexG2CrF5WgodZ1+yPAte5sEwFWthcBDN5Bww1uUVFRbV+KUo2?=
 =?us-ascii?Q?cYpu4TdkpHD8sBpGpB3TO+fDG8uvbeD6QEj6P3vsE6EAvHFn52aIAlkzRYgt?=
 =?us-ascii?Q?oDwyx90uHHGMWagWqv1C5zv8J+fWxWNVpwI+uhQwpKsrxrbpMR1t/AKKSvbP?=
 =?us-ascii?Q?06nem+ASRUBis8mPz5n3EX92cRXAM7M6P8vM/BLMT3PjZiF3o8cq4EgEI98C?=
 =?us-ascii?Q?FV1WgjLF0v6gJCHlDDtnl13wJBgzQc4wKA+r0QsFz9Sdvl5zWihS6nBwSB2o?=
 =?us-ascii?Q?PsqMIOdmuLZI/YUG+OvzznY52nGRyn58PE6cfBOXuroLnymuue2rp3M6zuCc?=
 =?us-ascii?Q?oId6eL2xyYhCAkZ3+OX+8HcaVVDyRsj5AHcfQ0MGF8tf+tGKosGzm20F53/4?=
 =?us-ascii?Q?3+Cbw9Fq4nzNRHhpkZGN6N9CdSCrAHB4h5QqBXd9REhFW/4Agqmkunq8R5lc?=
 =?us-ascii?Q?RMbXMtbcRrJjf4rT0nc5YAnjwiwXdyGzCWEcv+K/1OO2qCh/lo+XrP3MNmnn?=
 =?us-ascii?Q?L1deNU1F+YCWAuorv17sSXVX3TKEndT9qArWKpk+8MV/vghIE3AC0wiiyhN6?=
 =?us-ascii?Q?c0LjUlRojCxqCu6zcf3B2AOO/SOK+RolSSNFNfB9dNZPccZ9tmSo9qYFCfQK?=
 =?us-ascii?Q?vKiEPPDLLQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: b/x4V6qkQS2QGO+SNXF+3ag8rkVCeNYAoGR2iY7elmGRVT0cfLbJcQCBE8geWBRiaT3e1wTJYIGm1gHQaSoK0bwWLbenqHozgg7UXxsbS0ay8FwDVrc+1Fy0/SMkmPKS/YcpjIpvyqmbKeH9H5rs+ovrSkAM4CQEFkQ0sMTcYwodBhHHgHWVdNMbwKB7I5ml5qt/RNqMf70YeFkRHS1olvJr2zM32AqLMD/7Y6by244X2etQtUFG4vyYmnOvpAzU6kVjNV0bqGwO+FKZpLT/KNvGjF5dUw9nONfNaREx0OB7RegIHngfINZm+0d1fb7BF7D4Fi3284nWZ+DW2Nk52A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 425034f0-5cc3-4343-e37d-08df29c11965
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:02:24.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f3WawWEbeBbz8tCfAlxXWJ/HZsULnV7BDHNnz4lpjGUVE8RlOcDByvQk0avO07ntAzJ8mPTER233k5jM8gcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 05:12:12PM +0800, Yan Zhao wrote:
> From: Sean Christopherson <seanjc@google.com>
... 
> Not-Yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
Part of this patch is taken from Sean's patch [1], and another part is split out
from Sean's [2]. I renamed the op name to .gmem_prezap(), defined it as
safe-without-rollback in the op comment, and had it invoked by
__kvm_gmem_set_attributes() after rebasing.
Since I wasn't sure my changes would look good to Sean, I used the Not-Yet tag.

Rick reminded me that using a tag in this way is not appropriate. Since both [1]
and [2] carry Sean's SoB, I'll update the tags and changelog parts to:


Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>                                   
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com [1]
Link: https://lore.kernel.org/all/aXt_L6QKB9CSTZcW@google.com [2]
Link: https://lore.kernel.org/all/anLrGmbZwgWnNUkp@yzhao56-desk.sh.intel.com [3]
---
v4:
1. Split the parts of introducing .gmem_convert() and updating
   kvm_arch_gmem_convert() from the patch in link [2] and merged them
   into patch [1]. (Yan)
2. Renamed .gmem_convert() in [1] to .gmem_prezap() as previously noted in
   [3] (Yan)
3. Used attr_filter for private/shared info. (Yan)
4. Added a comment for .gmem_prezap() noting that the hook is allowed to
   fail and must be safe without any rollback in the event of an error.
   (Yan).
5. Rebased gmem in-place conversion series and invoke .gmem_prezap() in
   kvm_gmem_set_attributes(). (Yan)

> [Yan: Renamed to .gmem_prezap(), used attr_filter for private/shared info]
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
> - Rebased to gmem in-place conversion v13.
> - Renamed .gmem_convert() in [1] to .gmem_prezap() as previously noted in
>   [2].
> - Added a comment for .gmem_prezap() noting that the hook is allowed to
>   fail and must be safe without any rollback in the event of an error.(Yan)
> 
> [1] https://lore.kernel.org/all/20260129011517.3545883-44-seanjc@google.com
> [2] https://lore.kernel.org/all/anLrGmbZwgWnNUkp@yzhao56-desk.sh.intel.com
