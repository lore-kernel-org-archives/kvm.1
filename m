Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35538B7B3;
	Wed,  1 Apr 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031649; cv=fail; b=UzsmoACahF5D4wL2LMu8fMXtPaJy5HZJbv53ltf99d7yefWwZUCGd/evDld55/XPVUn5j65YjYZe/8Vv3VrydmK5L3+6HrA6MiyYXL1DbHceB6ZZNY6c6HiHCZzWB0xee+eAmxuS0NV5s/lAsdJ01g3njy1OhMmKGW0aO8bt01A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031649; c=relaxed/simple;
	bh=kK3gTW5MlEA3jqh81FaGrsO2zSWGlYVTAqKunpxfhbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KWY2NrqLRpkQiQonz1/W0AijYtdn8pq7B19cXAe6dNZN+LNP/tO6vCEjAQ24KMXQaag0OrFpKmfGe2bRppoJGzI6ef4uEy8Wl14grxFB8jQk7vZaiQILzI4SxJoniBQ+vhmJrkBEYZJenWUNPEyLWAZS34iKTWTCSJgArVWRmt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRnFVm62; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRnFVm62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775031648; x=1806567648;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=kK3gTW5MlEA3jqh81FaGrsO2zSWGlYVTAqKunpxfhbY=;
  b=QRnFVm6229m5omTDl7iUmTr7vghQHOQvQaySEf46Up6CNLSmtE9grcKc
   HHLzrnqQV/0udyWf9E8V0DChhZZWsXUiFn5EOUlRqCcgTl5/lek+/qBIV
   iQia89zX6xFtD0hfMWp2Nqq3OIW/xz8npQYEtfONWNHyQqL13slzg3Pbm
   7AfKI60NjLOX8ewFYmRLpXO0689ZB0f36/QduVXuq+7DBI3H7r4bzS/6J
   cmb+6QUkLIfQ7HBmYxCtxuXlBbNpI5J80DG3lcynVda2JynlHKBt/0aXs
   RqdQMsBz+GEhfUZRMpD2EiXDR4aLrV1KWp18Hcr5qyxbq+WN7fF0UYC4M
   A==;
X-CSE-ConnectionGUID: j6Y9k0gmRxmGHwoJP0ROKQ==
X-CSE-MsgGUID: ZQGrc3YUTwSpvfA723Y6Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78655328"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78655328"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:20:47 -0700
X-CSE-ConnectionGUID: Bn1MS77cQB+MUuX4dH4lYA==
X-CSE-MsgGUID: +Dkaqr/IQpOl0dbB5U6jXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221755256"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:20:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:20:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 01:20:46 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZzwidxoSlOKo+GedkE6Tqd+/pA6t2bMK74hEW0nXRiH/I3chFS458qwDutBHCeLci8micwVRxktGct5aWPPQ7UUoiO+rW4zMUxUjwVKmLCL/LAq1mIe+AZzDcvsj5ArKpn99nr18UeWu/G8ZsXgq5WZBYrQGJ5dEzidRnol1xkI3zuswis3vcHUMI7T+wdaP/RQLJbYewLzCP000kEmRqJijocoIY6NSAshPjIgmVjlp8tH4sOIULRKkkVIT8hVqtuIwOzsfA/8B9GIBnfVq2TLY4WXkX5zYrioE6Fi2Y24uSEz2Zv0YXmnzQs/TDZ+B9TwzqAeQaUtjHnDnAbevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDy0Tpna3aH8pl3P5tbS816Lw2uk7ZKw42++pp5bMJQ=;
 b=OhBSdfIG18B/xm2r0Td490XXIBXExPHcIaFAMYO2sJ3p5UQ2wFzrTl/r5GOtnR7Ms8vDbB8Y8ZpEjBYFjYN/Hz+5RkuG4XXvqEBSTkJ72sSGX9aLeTawTvdkSaLEkIWVxqizg3CDm6KbWyE+w6Kg85/ydMCvle/VjeqN4T9AVnv26Ka1zobcKfyLeHbG6VbPd1eD4GJr8dOYzAB7hCgmgFlgBocrqA6edadJzVJvOE0c2Umiwa9l4OYi9XBhaOR2LzdYrY5b/1zKHrI1V8Hz5nQ7XUYMU6Y/co6DPvO7LcuMB8N4egJOvckyNHY4F8KO0Dng5gSTkxkQ5VlSBx04IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 1 Apr
 2026 08:20:41 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 08:20:41 +0000
Date: Wed, 1 Apr 2026 15:41:09 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 11/17] KVM: x86/mmu: Fold set_external_spte_present()
 into its sole caller
Message-ID: <aczMFdW2QrnopWOH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-12-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-12-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SJ2PR11MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7324ac-56aa-4404-1ecb-08de8fc7902b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: NTfgLImiYe0kmw+1w8JUVm40KOUZ1SArJ2XZ430Toyy6BYGu/BEW660Q3FWuWWvzWx7AHRSqDUZMkwO5+chyn9HJoNIgXe/QOjKowVB4wAnGlIjONT1tOr63wnTTfFEcLTp0EWIgZWg0bQvgwK4HxQZlmPjsX69nMepNl99QdgoJd+WlvYRq7Nti+B0KS+B4QGEbz6sUBQG7PRStTLiBogf3cH/IkXRaSrHdZuJy1DaH36Auq8KgSHjJPh7jh3CVEOOnwK1MEel7ryqjH/JCmYrkokuvpAAx8N21SerF9j2Pt3Xgk6b6c5vxL4ywYnXRQzTr8uasjg1uasXREtmq/f6uMU4xjSsMfqeEs+gqYptx0ME8/XENcm+35WmGhM4FT/6rhEIVyac46wpDV59ATmI547iG0lUI7rlR0nKgCrqQqgczpW0gl+AFTKW3YJEOCBSB0od8ldV6tsTbXF25IEPq+xcSfahLQArbowVDthhOrPklVjhT76QBXT0HvAyUFBTUYOnZxTYIcbJZPgI9099yV6/jZKB8Os4QLfktlP2mZ6kPZWDFi5jF0vWES/G09OYv8wneTQMBzL/i1SIRn+RSjAOY5hBnPnPvfPSofZdx4L7jyL0lOzU1xz43US54DgC2ekIZTGZmB1TfpL2wzpFmYCwqxQVOKbJQNRvwbo6xhWVk32/CDNvU/pTSPDft
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJFHcMseQ+RDUIG60s4BOqQVTG9Z3lS75Dza8SfusWo8IaVAZZaw8aZwsTpb?=
 =?us-ascii?Q?oVOAm9qig4UixjHMzocTVa2ERRY0tc5CG1+Gsp2nBoi/l1iQjRDsdnAX2tqn?=
 =?us-ascii?Q?G2RnGT8vAxDIGEoAa2WfeqldO9s2i+WylekogFJ7WzFHSLixLsEXgVMaiPtP?=
 =?us-ascii?Q?ujFinY0ZnH1WqBoq4do9dhiRaOQfoimqa6XZRXds0KancJnoPLxJYAHkNuJx?=
 =?us-ascii?Q?VDe2RbouDGlnWkAVMuRzPds5jnojinHIutAT4RhyN9h+uFY00bzb8QM9xSCj?=
 =?us-ascii?Q?IiPkYiij9XRkM4sf5ZmYK+ZBdfd0JtIi5k7MgWYttp2Hr4rmuL+gkw/Q7PFV?=
 =?us-ascii?Q?gobCOYPKYaH2homvkLgl7DkQQmrOVGvDaxgcu4ppGTbr97PAtW5a/mOsMzhA?=
 =?us-ascii?Q?CirkYUjO58d2R28tZexasAkTvV/jNwKYS3GnXS/odWqK/ZS6z0orPqCH+zF9?=
 =?us-ascii?Q?5l3JxNdRj1cNRFhory6gZ7sXkNftUs03lqWL9tVbmm+AfHBsyPbrcR3n2PIp?=
 =?us-ascii?Q?YJOU2gJTQj4wLKzgK+o6kA2B3DURnHhtylPTR/qEoQEmgXhbPDayQtLwfj1p?=
 =?us-ascii?Q?BXkcI1zDNnG4mlmRfHXZmCtZS2l4XfRdmjZkkzoUsriy3DAnA1QgexNJwocL?=
 =?us-ascii?Q?AfnwwLNrNFOT4d9ukFpNHn26jN4zpBU+XiZF+b9t+w43FSLFAJHh/R5OuJA6?=
 =?us-ascii?Q?gCEZnN4EvkNQzuWAPSzybY3hLj9XwKs24miNM5XDl67hDcj8x6F0PkRdGx7v?=
 =?us-ascii?Q?3baZpHWo9MCO/OO/ycxsf1BWvEQ1ELKwjiXYcPVXJR0VGCRHguYdlhxQZ307?=
 =?us-ascii?Q?+JM+Ts0AsrB8CBHZJrBNyCGXhyekb9jvMS11eWtEF1WMzP5calbJQQ1LEH2q?=
 =?us-ascii?Q?sZxTLCTyR8pXMiIEFeVXfJhfsgQp2EV/pLnJahI33qzQirqnNT5f4h1wUPuC?=
 =?us-ascii?Q?t4o9SZtVGe1YTgWwPi5OO+24kfuGUiOnK1Dr+G9jm11IcPseXtddXcTOs7vg?=
 =?us-ascii?Q?1wegREP+JdmbTn3hLOZQrFd5EHh0Iat1b2xScFuTraSPpwqCi9goZ5L5MckP?=
 =?us-ascii?Q?4/pRfGzWLnCjUHNy9lxa0ZfyTo7IOwpRfIXvTYWIiqmv1Y+X6NYZRX8STJlW?=
 =?us-ascii?Q?6IqinTZKK963gNv8YW+jOwMbMy5LbNVrd4Ig78SrpHW4IsdW0mzpM0dhCubV?=
 =?us-ascii?Q?r1AbHiSothcvMch6Zad2LneGs2lGKaMDHgKERObpPgVMj2IJFc/4Fc14A0Gk?=
 =?us-ascii?Q?wKmN8pA5KgaXGK5iRqK4v11yJ25pIcdAEzxXk4ONhJx3pqO2Q00epgAjGWj3?=
 =?us-ascii?Q?zm+AN/bThzn/6WyJK2mJaDiLBgnwWacai8g1Nlh2NNxq7DwQMqJb5XkedUY6?=
 =?us-ascii?Q?16wph46ySV4UHYEwC//SASAy5iev7CTpceuxpY30ZRbCXpgdK5qXuVD20Ibt?=
 =?us-ascii?Q?eFuJdI/UviYYBtwNYl3Falzr8fM/kqLQFLUr3NloGfw7IYI8F9UGCLhVUlqR?=
 =?us-ascii?Q?5ccH1QWcHqTqjlBkaTrw1pjhXV+HsL3aIS/MvT3bZms0gIk7y87JaHRC4PkQ?=
 =?us-ascii?Q?k2brhRD2WCnbgZpI7qQLGJCVPFMo18T9+TCqnBSkDlDCTjAWg8CvLabTV1dk?=
 =?us-ascii?Q?LMGuYAW1Ey7LP4pujs2oHIe/+ZkO8C+OTmRAwEBMFo0sQoXQtm0SrD3vJrvl?=
 =?us-ascii?Q?1kgBw4q2l/TEb40oWwbwkURJe0newcsPaCao8fGrS1SLkNNvCs0Dp35O2k3P?=
 =?us-ascii?Q?6tgV7yk3GA=3D=3D?=
X-Exchange-RoutingPolicyChecked: btBTIi9NhhxwgnGiYhsp8C0yWBbARhCfm314h/WMJUbspgx7Aa/j6IBRP6r3jYO6KYnqWdIuWsb/H3YGgSfUlCcNBWBzpeUw2ONvutWUxAApXzyovSH6YZ/S/SDdmrMt6Nh7tpZpwQWWxnBBQUTRj5I8KjkHocxKN5oFKmVms5dvdhfcK7rJksd9AjgagyRnoPEisRXbY/y/dVF8LzlpCo32juGh04Czz1HlXWjZgNAMzrer3CpuOAyt53qYirv+dcJ4lpjdnR/WEgoq9VQMVOryQufFZMdKhS7XmBzcuGctqEBhGkTWdoqMYBecqdrvbpQMOw4+x/8t07nFhCJKQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7324ac-56aa-4404-1ecb-08de8fc7902b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:20:41.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PTkR2+vMCCbovkWBL6Yfs8863wWmQEDS8lLzaUWCd9sADvEcqHPAW7xw9fNh39AZWpAnGIO4AwsXc/9c0wYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:15PM -0700, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Fold set_external_spte_present() into __tdp_mmu_set_spte_atomic() as all
> the other functionality besides calling the op. It now is a single line
> helper that is called once.
Ack to the sashiko review comment:

"This isn't a bug, but the commit message says the function is folded into
__tdp_mmu_set_spte_atomic(), whereas the code actually folds it into
__handle_changed_spte(). Should the commit message be updated to reflect
the correct function name?
Additionally, the phrase "as all the other functionality besides calling
the op." appears to be missing a verb or is incomplete. Could this sentence
be clarified?" [1].


[1] https://sashiko.dev/#/patchset/20260327201421.2824383-1-rick.p.edgecombe%40intel.com
