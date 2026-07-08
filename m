Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7311403E83;
	Wed,  8 Jul 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500385; cv=fail; b=QBMNnpv8SlF78sJQHZg9aI+3Tx/z/eYgd0DijIiTbfUyoki4VXfNfgMTm3tucpCaZx53bRrqwzcWWh6uB30Z2vkBm/TbSHGVpZpMZFsbbZh2XEvgmlYH0apKN53K2HcuDYtwbXYJQB4QzzJiTUa8OiE2yYDkb6giEWVZelGZJ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500385; c=relaxed/simple;
	bh=8SKCm8XKBlQmyHz3Y0uKMTsBhiwKXuHh+C0oVJ6t0pc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhS1yE/LbgVGrw9FHkAddKdfcJbmRJcgBUO7CGITANizuWa2WnbFKK4mNwaCXfZvVyAf4+RdEjHKqBrdnbHrOhIgqdrogsi2RcwbZZve5AlegjY/dUEkBivMJUTsg1tG6NjSKc1ZZfBGDoXYhy8MIPlUUzp2znDUB6Jupdaelvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQ8eS9TG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQ8eS9TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783500384; x=1815036384;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=8SKCm8XKBlQmyHz3Y0uKMTsBhiwKXuHh+C0oVJ6t0pc=;
  b=mQ8eS9TG8ZxH/8+FgP9IcxzI1ouzyT/KNqyYoNeIGZPhKm0HGOqJzAc7
   Wngkhm68b2Nj6HSD6XP6vtKIJQ7vevWRIO9ZC0rNBXI/D98c9xhjGXnR1
   5Bt+Qjl2fLKSPHux+2b5vcEs7CiWO1HDczj5r1RbX+6HZl0vnOpswUXlg
   bUyDbhH5+ELkxe+ErTYRdo/5FJfnA5uj+xj8MZaa4lsgQswxmjS1ro3/g
   uRtX8+waXe3ZbScIRaZRRVRJ1kyduKJwMA1YW6Sc1GQJ12uIs5t78NGm7
   KwvFPYPMUhlPFuvMoOUn6aYqX/GTl8ycNPcRGDGtuxOlON9bzvjLoWGj1
   g==;
X-CSE-ConnectionGUID: SPijRx2oS1KW9jwZN73pEg==
X-CSE-MsgGUID: YDGmFVGCQyOUXHoSeQzmdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94801404"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94801404"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:46:23 -0700
X-CSE-ConnectionGUID: sQQZx7wORTGBKtC4Lxd4cw==
X-CSE-MsgGUID: w5SIqp7mQNOZyTTL/DWQ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250242405"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 01:46:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 01:46:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 01:46:22 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 01:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLBm2jScJFM6fj9fdePqziw4ux+CwBRBoNCbarU5xmKb00RexNHbL1yDJFHtVl5aKdB+oncKqlvgVktSGAcAWkzlBV1SuHW4hc6EH3wYKWdLhau8WVOBk0AjtjsPAnm8aU21H0z1/27H1chdMOWV4nmAWGMPiG0ytrAcpbca/aIpB12fcLlRmxOvwV3u4DjFvlQvXqULnYD9llf/wz+2zf0404jt7OkZ4c2IrLjGPKcvEyqAWSjiTrXjkDRphscnD7dXaALKmheA4XCGJ+v7suFrCz13X1PnEZInwmk5/f8Qnc5cnVyj9TLNeMFfqQNw82Ck2T8LvpHmsDguYb5Xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PLNv+4S+JIr86QQwr/5PZW75LCA4F/QRDHoUAOzaVE=;
 b=EmCaLd5NoNsxMrLYNsZwxhCSEbcewvgsge2tjI8k7ycwaSSOEPUIBc0u1LoxrGfChZ13u/9WlmYqWWovjGpamFkSCer8MNTwwdUWczdyeZ+dzT3kRWpw8fTzia84HfS+tYJhzk/+rfbpHvhZyKJG70OJfQ+TYTBfQjbG4FNbxhaqkUuwm50NdMt3GcXXMhSzSnt3Pq/r1JywWeKXM5hTNtXqjrqtRY46CMcBWlyb/JUgwDY+vmeVaztJ07ibPmAtXW1j+W89DfheTIUOCCtFae4y9ef1vKzltT5M8waZxnA2Cu5VfZ9VJnInGG4I46toWACMjHnA6UStKWJ2lzV8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 08:46:13 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 08:46:13 +0000
Date: Wed, 8 Jul 2026 16:46:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <ak4OUC9fg6CJ/06Y@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-7-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 857011b5-bd72-4fee-a82e-08dedccd5deb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: To5jtstrIr3sNgwHb0PRFlqhqgGw05Yi8z4s4XD9ok+fx2qZd4bZMOhol7DuYPE3w4VnYo3xSymlIS5hVTRyDUYhvUWIyo8+jBbghpGSDqx174YFD2hAs3oIsaj/hWgLiGgfZsgorv8z2aNaosGOi9QCkSV8CJz0JjKYGyuwQbenkqT0xywLKLEzl8NmJRIyMkIJj2ivhT7QC8RxBM4iTolJ37XQBECjlfh352yUnxM0OOFraQbmQNaBc/kjrsytLagKW42qoCBMMNHleNsbjDhULip+bCNHgyGaAb4qxZgw//HQZv+Lt0gwRpRAgGfVqGVnWvkW8/wqQDX8MLr60zqJW1imFT3rLcdGYWWJpFRIKh7KUxdYx7WkAHwhkF05rFtfUIO0FdjZ1UOumaC+FLVzVrSoTEdzusA4FHMjlhTaBlzm5yaq4hRJVZL8Y5nkaBiUUnNA+z67OXP4HnjjCkJihyHn2O/T3mch4f9h89ZZOU8PGiezV7kusAb4h2934IvyJqDRzrLBHEQjdNu/n/r2K5kBCR0/KiVh8P2Qd4vh4tatLwdedmKefQef7LzDQ7OUZBjq78fI/logKF0uvUE4BBT7nD4wegk02SWHMZfPBlUK/7EYMRtJ8EtYUTWqOIYxPwJ2O3u8ZbnOJwZUyeQLxek6DRDQLcNfAaN0xFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VE7oLWpkDTKAFrf6YskGTFfF8MNgh+GjUGapWInNfIynlE0BQRYvPVeo7udI?=
 =?us-ascii?Q?RG+VSQrvWlO9jgY2Y+UIakr5NgacRy7efndlayootMHcAK/6iEI6DeJiWOic?=
 =?us-ascii?Q?R9BGEktLeB64VrFZ84/Lexfn4/vWqv22KzpRBzb8VbCrlYjHG0VcRYM8b3QZ?=
 =?us-ascii?Q?S2PlQXYmSGUMtzoEzx4V8doAiv5B4YTNvXkvXVVaVH8VZZJLW3CH+7NjacHv?=
 =?us-ascii?Q?M31OjD+o5LSzmJUdlwFlLDD0DqG7QwQ2rKwYRopZcUAo42E1Jc3sS+HXWHbc?=
 =?us-ascii?Q?lPPWHkSgdaHNqsVVvPuUsVZdkt8ak2B4Fy9ruJH8AxtMcqbcL25cAUz4qmBc?=
 =?us-ascii?Q?KZMHpBoTkZnBFZhwg7N/pCy5QZ5Rji/SlXUgT4ua/WqaIiv/2MAUteOG00ir?=
 =?us-ascii?Q?cpB8V1vznZsH8rODgs3E1xVKPomNemxcqVAC9c+wukN/FZ/00nXgkWDLsMc5?=
 =?us-ascii?Q?e/5XDODj5bwVvDUgRPxC5Kgv7z0gkqkLpN/+JblV/svJFnMoCnjp1lHu/Z97?=
 =?us-ascii?Q?FZ7VNTqHhisfUMJEM2wD1RE6MFyWBhqiSbJf3GUwFzIZJEGcKIr3ya4T/Fee?=
 =?us-ascii?Q?fG50EeZisZG6OHbVqQica17rIwAGileklJFyV4fn4nTCZr7Q9ehPOGmARq7U?=
 =?us-ascii?Q?VlZx8Yot2GS+fSYUdBLQCQgNDV729BTZZ1KdUXodXo77MvK09aFg+0zCDCm8?=
 =?us-ascii?Q?fpdglsdPCaPw52Q98zttKU5kq+4RpV/GlFsRGYSuVq8JuTufPErs1pYZx1tq?=
 =?us-ascii?Q?Fcnb6vhwdsWOozZcS2QvyTILhqAbDM2PzrzUdAZ0ydDP70iFrX2pDXsIyzji?=
 =?us-ascii?Q?l2A9ZdbwynR1AsLnUQ6HjMbKifa9BcCfbsL77UtQwp2fV9IrlZqcSlnrGPft?=
 =?us-ascii?Q?Pn3K1D3JTa2vbyiicrhikit5K1PdtLpjOCLtphRcIvL/QqXKXQlWgvEIV75w?=
 =?us-ascii?Q?y5xBMXc7nE01DzuyyWpDET3vq0uM7sD/xSwxTJ+d4ZPDWPykTBac6LXiy4wu?=
 =?us-ascii?Q?0Qt+bz8ek5lg++XCqFUeyfF+Z26ii1XG/6OLWH3RhYK+wsgmhTA7zAxir4YC?=
 =?us-ascii?Q?1hHWbajhCAX7BmRIbfI0mL3cyVhEZDKB6ROvBTVSsQTcfKffCoho3DUnNFoi?=
 =?us-ascii?Q?8YnRX62OmP59iXarOYDTL5Tvrb431ltjME0yq4cNeSC4E4T5X8DqK4ea5DrF?=
 =?us-ascii?Q?cYsbKC/idIXkFePhE/T+ak3X3T8hbepGWLgjH7vAKhncibO5qcxfR/YCQBzy?=
 =?us-ascii?Q?3F0f5ja215vZdDBifD6YmX1Nfu9a7FeUV3yi5w62RAIGBfR8QJdntr53Jdcp?=
 =?us-ascii?Q?uw7xqP/n/MzMtR5AByCrSEE6ccRRoKsbG9FWMVl72D0KgQSJDz3UqrEiLPnQ?=
 =?us-ascii?Q?422Ke83MUYcJXIx0ALM1aXyGChPinvXiJoyidRv+ZPNAelCyj/QNZCjytAuh?=
 =?us-ascii?Q?dBTwixR6I/FA+lusaEmZGgOjAf+oOwfIq44OutTcFj9na076Xqsn6mn10su4?=
 =?us-ascii?Q?iGKQGatZD/ctlanxCqc/Ga+TDsE5CTXUWizvwMNHh/cbGviaEbfjQLYs4znS?=
 =?us-ascii?Q?KghClCFD10yT6nObdUdq4V6ii/x9dNjWK8wry3wHgXcEoVqKD8s0m7LA4/G/?=
 =?us-ascii?Q?RzyXMWdN8EtohHFVL6tD7cfwElRN4xXwVuKDVkzkNTDbqkCgBCaZRAd6KuPB?=
 =?us-ascii?Q?iyAEH35YxxoCPZBHIFaorAI2p1RMnMwZMZUQ+cU99zkifnzKxzOXEfS7lHs7?=
 =?us-ascii?Q?Q59sk1bqZA=3D=3D?=
X-Exchange-RoutingPolicyChecked: I7oGNkagJ+X1oWzxj4IGkn4+lkqipFeZ1rFaHDpjCOVrlJdmJbjUPS12vrlIeWoIZF+y1HpafNjPO3rEWa48TBsgkflzXxHLMAe8zgcZxmgaGxifDCT6rGw7E5AUbP55IOEfTHPUzAwHTKK40fL67jgPdnRsC62uzEB33sjoaZUwWCwNpWL/KfPW+XSin+Y4zHq8/YvUrEeRm0BosK2UPbuno2hGaROQzJ56+ATblCDMjJVJm+9CCHDMb9yMgvi1W+L5nHP2Lp+DFMIxeLB+kaBI10aMtUQ6JOgVK6aiaaEcj93ItNglN7kcqWLzrwuTBEVsb91ohywu0+cRxczURA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 857011b5-bd72-4fee-a82e-08dedccd5deb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:46:13.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svz+gAKsv8vx/wdWP6j2gkxa2Spa1xJAyAp6r99j1j6gUeeyfxhl4T3+DdTLS0ezNwUyjWFCB1rA3E0cFeAYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:10PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The Dynamic PAMT get/put helpers use a global spinlock to serialize all
> refcount updates and SEAMCALL invocations. This gives correct behavior for
> concurrent callers, but leads to contention. It is especially bad from the
> KVM side, which is designed to allow faulting in EPT under a shared lock.
> With the global spinlock, not only is the lock an exclusive one, but it is
> for all TDs instead of just a single one.
> 
> But taking the global lock each time is actually unnecessary. Only the 0->1
> and 1->0 refcount transitions actually need the lock (to pair with
> SEAMCALLs that actually add and remove with the Dynamic PAMT pages). The
> common case of incrementing or decrementing a non-zero refcount can be
> done locklessly.
> 
> So create a fast and slow path. Check the refcount outside the lock and
> only take it for the slowpath (0->1 and 1->0 transitions).
> 
> On the put side make the refcount adjustment and lock taking atomic so if
> a 'get' happens between them, it doesn't cause the Dynamic PAMT to be
> freed incorrectly. On the get side there is no technique for doing the
> refcount adjustment and lock atomically, so check the refcount again
> inside the lock.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
The optimization LGTM.
