Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8625B0B6;
	Fri, 10 Jul 2026 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651424; cv=fail; b=Mzlo4MFDtF9Ur/maErorTT5EweWUg83dj5t8dNBEizyxifFBnUaJLgwAi9e8uUI7gwFnBQ2JWVkDWeHU1J8s62EqdUDP7Pk7pRajUfFuCGZibV56n6WtpCuZjrrmbzsgy8kXVZ/9qfEO4CcOAluEV0B5MgN0j30gNK9rO6OUlxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651424; c=relaxed/simple;
	bh=z9GqHNbH8K+yvMoPumH1kzl5v9maT1fNZOMwYUVm910=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6AI8RZonqP6ULw7Bwso46vsJ3pOwqlG7EcU73/NUbJKOSG5huzRwujoC7JnroXXp2SLOdgMWrLwd7c0vJB3KS9yA5zhTVSElDgq1x4+VwhQlkY1+RAwzL9kE46pRj3G99I3rBu4PhVwkuzuoVxUdGcgdUV1YdX1GtlF9/EDSNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqrPJVmD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqrPJVmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783651423; x=1815187423;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=z9GqHNbH8K+yvMoPumH1kzl5v9maT1fNZOMwYUVm910=;
  b=VqrPJVmDleyDzxTeFqndIClNo8w5TzGoiGxu1TsqNEaxzAFZSOnU5Jgp
   T83xcHU10wo52b97j+M4cwxqJ/hT8YTkwJfDR8fvlfs1j+jlipcDN6hDb
   vSBtg1D/KkldPeBvc0RKIC0qw2SpEZzIRxs08KxF/hhHEJg3jQDQQ9lzW
   f21KA+/zkpDWG3sewtMlDRfoLJH8dyfhBNX7VK6u1+eh5bhGNBG+yRGpC
   h77vvQ9VfWeDa29vqSfVqPA5u6a1ZxeYBMg3m7mhJ7VP7uOYKQF5bJILL
   ioiB43Lka1KxqZp5iY2ZKguz6C8GVY/QRaiNiPR5K+M2VVP+1PAdFkay5
   g==;
X-CSE-ConnectionGUID: UzGqhUZiQBql2hLr+NTZTw==
X-CSE-MsgGUID: lSt+JUXcTqOn5/uh6PopPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84540496"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84540496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:43:42 -0700
X-CSE-ConnectionGUID: qEsRcRidQRi3buww7LDcSg==
X-CSE-MsgGUID: gPXGymgPTOyFg0rSZRsKAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250343484"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 19:43:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:43:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 19:43:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 19:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDR99waBDmyTzE5TDpGENmC1uZe0ys5+cLfqBOREfnAq003ZxJ0XYAtzICuYckGY9VqRxrf7x/ybU1KN/K0lhUI1qDkYqAUBN+BRCtZSD0Y5nUYPR7OObXUEbLHgE7rPK/M2G/irrSXai3JepXyYMId1+Bjuh7XaOkeMzKVuohdvKKzTOKev81cJ77pXRRACZqduJPY/jkqy4NJLcPlRZ741Co5fuIaSFFa4GfmQYa1t/mAN2hHPoFsKyrbFdnK0q8YrprNJkJ0b79ZHFOpLbJ4e5JVJrbI45nTtFCR2CMCgDw9jOYp5pqjqGrTYI/TuyvLqmk5S3Ae+b500IolYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NI3DtpifWbpyvcQrB/3RJ9ZK44zJYvKz10GD9/C70w=;
 b=vsIQObrbQkzLr7IJgmkTv3BD7N4J4ClKW+Ks4ehxwwA8p8xURr+U6sW9efH7p65m6Xm8WQhaAist7N7ClCkyW8F9GZrtpoB2Emiv/C+sWpVfClfuioEI7m7f/0Z+NknR/xBnbW1ENJFI1YEpjCBmt5Ztix79Pln6MpJ1bZR5IhhOTGEgVsErzUuBXr52wMxUnIVG/SJrqNRNmPuxN2RJ0S+h27lLN7XegQ3oRuyO55FvyNOkIYQs/I6uPbOi0AZZhJ27lSffzWRvpKrsfMCHxlXpg21Ry3OStF3fU5w1KDPa8JLw03gZvAn4y/bVEvVgXal0AvKclTkRYyQY8LOksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 02:43:37 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 02:43:37 +0000
Date: Fri, 10 Jul 2026 10:43:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Message-ID: <alBcVJeDat1+SmB9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
 <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
 <f686c26073761302b699c7374b668c933b0452e8.camel@intel.com>
 <ak8S6MiMkCEgJcP/@yzhao56-desk.sh.intel.com>
 <aa669cd125b9cbbddd9105cfcbade50f130405db.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa669cd125b9cbbddd9105cfcbade50f130405db.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0028.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::8)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bf0b77-bdd2-46a8-5b6d-08dede2d0b05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HLiXSnmqB1r/03VaKGzEAQJmLAPiVEvzPze5Lfbn78QpRij9HwJIo7LIu55IwkMAlgzSoOT298fiLT/b592vkxXwxO6mbJgf5sUO1b6fu+DUKptsShsn0HMfI9345NrNJD/qzorYPt5MlosxXgZZNoFTJmEkbNSVxRN1Vw+RZrmShVZsvS35HJMzioMGpRXKIXnzE8QaaIN7ogOGpPXfa/pFe4ZcNLJnJBAyzjE7ovh+aL9DFhiipIG5HH6knrd3fBTv5lb1q2r2yuv+hhIhikaL3d6jO2zrQR482QPW75NYM9mMt18H4m8ozqLfMCg32/4Hk1YIR8txAHnQ/OOLjbKDS150LhBE2Pgxm3IGifzuHSiNT33fCpT1vtHTEG4b7ORlg23f9stxA2o2f+pf5PvsN+hCsyumoBOXclGYr1exsFQAqBOftC+3YMEMOIoirjfUW7epprNalZcwHV8qTMf+bkOt2IF1NoO+AyIRNZDQS8TN5nh1nCET0QbCs/xEKSiv0qspGj53neN5uZwwBudOe/rkBnMQsMm3A27BidDu+PxlrtTKuVH99JiZ2CVYVis4w3JS/MXdOVk4lGtS2C5eKkAi7u5BgZNxNrW0fOcqLonXohyx53av5SDccX4a2SljZfivuBdtUSa7RN20+XjhsfiX+HFNb/rfri4moAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bw2fPd4SC4QEf+pdk+vuhmBMo5d47NtpiIZ+0boePdsYjGmtbme+veNH1Xvt?=
 =?us-ascii?Q?46zjcgfgiYi1Qqi31g6ZFtY7zni5GXdSowr2q/CFdIIjOZt/C1HKoOQJB+AV?=
 =?us-ascii?Q?1jCggK1Di1JHXgG2xLdFkrtDnRaaHZCi8GLqmUt8Y19HqeBcVAN0lp3ep05p?=
 =?us-ascii?Q?enIKnzGiUx/92bNCLm8mHOQ0bkcuI30gVoW94btBYHGGC7dg2xy7sSn6QPy8?=
 =?us-ascii?Q?saCZS+uK5HDle/qYcO0YNY+Csnp1O6UndkJDAF1CvkgxLcNJZXBUdAjVW247?=
 =?us-ascii?Q?rZuJyLOIIaD4GFQFm6CK6y+vkZGIjPVAo1GffeMQfVM0BPori8bGIjeQ2Tvt?=
 =?us-ascii?Q?LVl0xQLL8Wqx7Ye9HrG5yI+0w+eyugffxJi70mJPcUe/9VRqyEcZE2fpLrBU?=
 =?us-ascii?Q?bnS0OtYqHdhIAa3pOyfl5xHdEhrCLYZvQeARf4MMP25fVy6VxkWc02/QDEFR?=
 =?us-ascii?Q?s/LtTzBx3vg/JCvdHduC6Fu6sy67YrovXk9t0mW2+IQXHTZ3WMTLzlb1l3Pg?=
 =?us-ascii?Q?8cuYLacvAn9vnFi9uohpzpPZ/e313mgZAQ7oMokao/b3AC+iFC+EG5RrDONz?=
 =?us-ascii?Q?XhaYmtN9qsnv+aNB5NJHpDD1wmsJ5NHKwH1eoLsTu29acw7e2ITqsLHDOQjA?=
 =?us-ascii?Q?gn9V2Kg8pEp2VK0LWpHdlFq0R53ihF1NLE5BtBg87PCJfMZyH4oKEW4NWZwo?=
 =?us-ascii?Q?1Ax53OLC5/no9quvlAo6d0TDZZ5GkpHzGTZY/uflwNpmM+m86fKH94qBFclo?=
 =?us-ascii?Q?p1pYdycqqTytac+slaaQSh3JmgE8m7O3/HpS530kfCpk5TrLjj6IEtdsiJjR?=
 =?us-ascii?Q?djGaLOQm8dcXLbOjrDzBrB2pZ3KYSFCrQ/caNY/anwgJncHv3KKSpyQX5zO/?=
 =?us-ascii?Q?W3wWIUugdp4cCvrCnazA8MVFxrUetPuKypDTg4YZJfHnQMkIH8NTEK3wKYBC?=
 =?us-ascii?Q?w8wcxxbzamo84r5eKI5KZQppeGbY+zIBuh2WVCsnOJiUIkbMj/xTanIpd9QQ?=
 =?us-ascii?Q?jUhxrbxTFBCzIXViCXYZhLHpnymaSkAvbdFidGoGWWQSaovbmTMvn8p4S5jF?=
 =?us-ascii?Q?FPueENQhdDEQJhyhauNqhqlxt8Oa6ynPkUWsGeHfjj/rZuld8WxnEZsXaXNb?=
 =?us-ascii?Q?NF0iYpEuQmGUGizRSvZrRaGRfmQ2yhDqjeq82NtSnEbbk5f5oJR0a4xMqCGN?=
 =?us-ascii?Q?a7dqn3jTzy44e71OiIRoThfMH34JKvHfpcQlt3UVEMW6JBySKs9CU6w3J0if?=
 =?us-ascii?Q?O2dqKnS0DIl9H5F5GzOKNWeWHb6OG0R2RZIzSYV6wiT/eQfVUsvuaSvQEcFB?=
 =?us-ascii?Q?hV3zCRCSxwrGZcSF7UOp2Mm/o+UfSsR9z7cDqu57KFvsdBvlbztBEwXM6N0h?=
 =?us-ascii?Q?fZc6fUM/J1jCJ6SP2pgFY8R+bAvc/8vifEZBgiPNZWHsaL0uU5Ls54gdig8v?=
 =?us-ascii?Q?jGiAYT3QcjiQ+/C+kw4pWEuyKVm0Lxde+J0Abokh0slQwQrgmzQxMfetlC0G?=
 =?us-ascii?Q?GVyEotbuVFEW00cua3vEsb8rEXnJ99bQkpVv2K9aakVlf4FQ5FHhSUzbe/og?=
 =?us-ascii?Q?VM+Ffk96Z9F4UV2L5Y6+0LIAGCQF/IeB5JrndaF0S8uynrWhCfXYejyBpQQP?=
 =?us-ascii?Q?VH7SS6t0HUMiIeu3kfV6ODiG6SjIq0Y864niIMVTVUeUV6BS2r4LNyIgbyP9?=
 =?us-ascii?Q?amcQ/E9Nu4xTIdtDHPnJCJ6EjCsKbaDDONQc+kRsp6v5Ab1q4pPdysMHAXBp?=
 =?us-ascii?Q?qg3fvDpUOw=3D=3D?=
X-Exchange-RoutingPolicyChecked: VZr+uhMYdXtzigc8Jp6Y5vKmdP9M/RnRsdqVK1cVH8UQIKO7HvJAitwEYRU6HNF0w6TyMC+nXzrkUj2EbJcYXHkUsp3YtvBRLP7YvPPIK/tpXG9tOusJl+3oczuN6IxbXOzHpQ6hwgvuyqw9VO3+AzfmakxIi5FVa/0REzzcGJ2IpIHTWk9nflVc+bgDZ+t7sX8DaJXGGxIGyaBd13X6pYCXy2J4gsEIH9VYq6ZW1iEpdhaZP+qB3RkRG6rSkBbgMRHjmzwhUbF8ruI7nA2fTcn4sJgbSUzqZXhYflaj88dmkb7Hn5q0cxiGI7aVkycdqedIrDFwWhlRfnKhgoriPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bf0b77-bdd2-46a8-5b6d-08dede2d0b05
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 02:43:37.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0ouaP5f2gJCG9CUekQH07C7gbXKSAM9mP8nYAoN5/N1ta9TjO0D6d1xtpYqERWC4aG+5yqFiz921fQrf2P3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 09:04:57AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-07-09 at 11:18 +0800, Yan Zhao wrote:
> > > > > page before gifting it to the TDX module, and tear it down after the
> > > > > page is reclaimed.
> > > > How about
> > > > "So the kernel must check whether it is necessary to install/remove PAMT
> > > > backing for each 4KB page, and do so when necessary before gifting the
> > > > page to the TDX module or after it is reclaimed." ?
> > > 
> > > The checking part is true, but is it needed to understand this patch? I
> > > think it just needs a background of what is happening. How about:
> > > 
> > > So the kernel must install PAMT backing for any 4KB page being gifting to
> > > the TDX module, and tear down the backing when the associated gifted pages
> > > are reclaimed.
> > Hmm. I'm not sure if it would be confusing for people without sufficient
> > background, because the kernel only needs to install PAMT backing before the
> > gifting the first 4KB page.
> > 
> > How about:
> > So the kernel must ensure PAMT backing installed for any 4KB page being
> > gifting to the TDX module, and tear down the backing when all associated
> > gifted pages are reclaimed.
> I see how it's better. I added a few missed word tweaks and ended up with:
> 
> So the kernel must ensure PAMT backing is installed for any 4KB page being
> gifting to the TDX module, and must tear down the backing when all associated
> gifted pages are reclaimed.
It's better! Thanks!
