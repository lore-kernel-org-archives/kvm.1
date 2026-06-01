Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD41C5F13;
	Mon,  1 Jun 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284880; cv=fail; b=EYb1GWqf3G3vwN3YVtgBDpUPzyJ3nqNFyLN4fzSEaSznxVFm06a4Oa82hauyHpvEosTYBFUT3GCE93atj1TXO3QIy8f/mqwiUycKXTvOyrKzIiQ+13Lw6ucPVo4hhYWkg83Prk/7FvPVkWVN+Fk59RehiPGqI4W0ZCtfU8I1fVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284880; c=relaxed/simple;
	bh=T4e3o8oJ8UhbQ3eQZPRZjvzyT2RwVdxgNMh3JucWJ0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BeMIfy0WEJRQfgF7HN+iwf9OmE8sd1vTIhpAt0mTrCUnrgKSXwCagD8zHqejh9DuPQsXRuU+6Y4WB0BnxpJV2Pmpo+jvitsyo7uQpzlKPNMpQfRvQffrTZqhYi5Vat2YRFUlfdWCVRE47nad3dvbzSusI8tBua4/S8e5WVRxe5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFvZLap9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFvZLap9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780284879; x=1811820879;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=T4e3o8oJ8UhbQ3eQZPRZjvzyT2RwVdxgNMh3JucWJ0g=;
  b=gFvZLap9sX1Gzucjns+jira+tzcuQdhNcoz77gbQuXL1VwXdUhzRXF/d
   4+OW44CMuo1ezfhF5BTzUgKLTw5Am6ZyuF8l5edGW5n9D5y9M2QbG9qWL
   2RG9j1D4HjFchjEV6YerUa15Z9W+EkYhU256KFZLJ3TMoQGSTENUSWxs4
   D54LfDR5mQI9VcCMy922qts/mkLvQmAIgvYMsRHSXfJQU/MOj6YwERDSP
   u8bY4EZroMd/S0pIf6jy7BQrUUDPFt/mCcVpTXvY2O531lH+nCWR5C8R8
   9j5sor9t0Ze7Z5ZGubF1nAQHc37l4fX6r/x/nmBKjJM0tn+z+4jw+SWbK
   Q==;
X-CSE-ConnectionGUID: gAyKgBGwRBiPyazc9zdvag==
X-CSE-MsgGUID: AQqQ5tIVTia7RoGzB96fxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92420167"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="92420167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:34:38 -0700
X-CSE-ConnectionGUID: LY79fzAoSf+Fgqu4ADo8pw==
X-CSE-MsgGUID: lIBj1mqnS8O9BiWphKU0FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="237105280"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 20:34:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:34:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 20:34:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 20:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrF4LKVc6+WIPjd/ysa6jyM6PYJ0X2G/OTUG8UQoathcIeipYGtwYJHSKDm3y5rMCAkobRKRcWn2/QUQO4jvlDHDri18e+8d9PdSTN4XniN9KtEGAf0ZGi/TA7/HuPFQwz8oyAPqTj/IuzDYLceX9rxs+IPwPDWphIpBbAs39I+guWFAvXDV43O+PUniz44ygQmpN8W4UThrQP9hhwrqMS2M2nGGaeEfSAa2voJUPXvE/rLKs1vSFST5g7bgSNxSA8UZq5S+j+CcrUHrJgFiHuq8CXmTB8bStCg0sbZ18OBiJ00+/DJp0Zwz4lH9ROJGa+wYg5iV0G6MDD6lAUlT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9px0dULfpFMk/8KeGCV2qdhO5nWwRqp0jg72IaaJGg=;
 b=YBqBK6aeJcj3USirNhIdkaAsrUbnFAMaLh+5GQmu8eAi4CrvTOLwkn2/QCwanvmnOLjq2XVJmro0TZ9UPeggVDxJzTCwYWHSzIwCEJMa/DFzK6kToSXv9xXb781q56N6w6rQZxYxK7hsLVXBdFYBCupXSjVlllUsx80SzDdMIH8lwmDVVrLFggvleCYz0Lif4okl1Exnd2j8OV8KjZ4iTxrz1mrxAoGvu6EznwUu3XRJ2+NztgEkelHmQkVOfJUzcsNrSmQd6VFwswQ8/pVcsbYxSH3xDTx3TF2dvbdvRHVJzK47yJPUlPhff8e5iBxvAo6PY0aliLYvEMovElYH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 03:34:34 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 03:34:34 +0000
Date: Mon, 1 Jun 2026 10:54:23 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<kai.huang@intel.com>, <binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 00/15] TDX MMU refactors
Message-ID: <ahz0XyhZXW54Kl9J@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
 <178009463332.880339.13655251210288710814.b4-ty@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178009463332.880339.13655251210288710814.b4-ty@google.com>
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c2470-0199-44d2-35e3-08debf8eb2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3xXulnpFeueeRfgL9PrsbLIhWzJ6Ts37sZMLfxvJzpk6/ZNrWUXyxVBarbT1+sc6Ukx2cnMCNirVOBlJLYloG0EF3vN1o4heYO81f+1QfM5I0iHogspMJ8imkemjr9HSWKDSwbpIB83o94qBYnzzeTh2j06gX3Gjs+4i2iVq3N/GFkSicLxQrhqvyjhAPibBEsmTpYxEXUaklgsHHhJ0M9jQT3BS6uk4uYAh+IEnhkB8sKzasvvtYPiT2Wr2NQSxIkm9wPCnFwQFUVl6RiY3u7bzMJRATQQa3Bj1TyI2TXRr0XtWX+bCg75RoISsy87tCzoIStMDWH9p0jPI1XpIvLm20wUA83hZaH/JW++Blwetc1NgkuugGI3xFy52Wz4YIFPP6Q+wlNha2lrHsQLzoCHFPJpJ00SD1rAPTFXhOMnNtHpz0XjcjovkSEJ0+QJMHEGCujO8V99kTRT3mzpAVF3Bmzps0B4hQh5pcW92wq5YVQpvBk2d+DK+wzdBe5fDimtUhoBX6VVf4EqjU8b4GE9tp54D+9RHsnQvmhWVEauZ/4E5hVU67Mo48NHNCWkT6tEqqa6hjI+bk1MAZHrWb23ou31sLCUkq+z/IushecZ5Nst+tCBhTzOLL8abnkM0XXhEp9iqeggGgsvBmotnewE4lEgfndDJxAgrDbTfcDG37DiPPWpvHEev0k3gFVET
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flu7BMCxzC/CydXpMCqSMUt5zmcFHYG2ebDC7tphHETbbaaIb6mD2tPmLWW9?=
 =?us-ascii?Q?sSp7hyB4RVORsfBgPVy7DpuDTRuHDY70hsJme/F3oN7o60ifRUziOHQUBZ9Q?=
 =?us-ascii?Q?XehuchVoTY7VTiAecY94wIil8gA3h/eaAEMI5No6TsI0ajYNkXWIwodbJ7Bl?=
 =?us-ascii?Q?hF6XUmSp+5LNOs30sT+44BQDVL0zSD39x90AgldByMIak9mc1KC+oEcCEYCM?=
 =?us-ascii?Q?eeQQwnyzLwO8R3whf+DClCsO4ENrB5SOY1BZMhZT/BM5NZJJvks/nd2d8wi4?=
 =?us-ascii?Q?pTZn7QjVXCdIf54fRB4pXxs9EHssuE5CEm3u9+m7G9QvpX1GkFjg5Zrsw0Ku?=
 =?us-ascii?Q?etGzVP/YKgVWhZggpTqEQ7Q3VR4KUvagscz1AHlssP1z+Ezvi6BIBDATx2CW?=
 =?us-ascii?Q?yK3qliDnQAY96P5i7IxvRf+t4Y3CA7xBT9iOWghVin8Ojg1OifVIz9tcXtJW?=
 =?us-ascii?Q?FrjKcnuCNHsjAGMGBe3K7KirvkeEQMshBTATy8nHTyu/J+//alUbRw6+ia7w?=
 =?us-ascii?Q?YrdvNbMnfqG95shTikoz9XbJBYgbAiqhp62FeqLuZrtRAx/T0bCC25ciZTct?=
 =?us-ascii?Q?uwG0SDUpbJoxtiZ1eS8/tVKutiWO85hSjiDZtWsUVET8eJStITwg2Z16buS2?=
 =?us-ascii?Q?3SC21Wn+yGOMAdsJHXyx8VpOdffQNQdeRt+Zr1QRYblI8UYv0Kl/J58HIS7M?=
 =?us-ascii?Q?Ua3PLPuxiU0HWRtEqsb/RwEdNjcI3cB4YZzAIn6nIP5XX3jQAsALMfLVxIbZ?=
 =?us-ascii?Q?6/Cbb2P6ureC0kyuJkPAuPp+ImwqAzCFvH/uyg7rHcNmp1ZwBSgDsgW/0fSw?=
 =?us-ascii?Q?9BmqHNn39Gxy6F081IFU3YrUghXlxH3bBi2RKPIwP3+dQDIM+ftnTTGXmS1l?=
 =?us-ascii?Q?21Y9sEitaa7jxEX5EMrjoByCJRL9LabPumTD/ppwdoWMSPfQU29b8aMoS62K?=
 =?us-ascii?Q?dkseLtoeqljKl6D++oN7Adok3dgSKFsQmsA8RmRYwzZQ8g7jZ3QokqE64bMl?=
 =?us-ascii?Q?luCzQ+xIuGR1lfU0/4Rwj2ZEUlnbARQEO0mw4REAL0kroRkcX7JUtIKFwINB?=
 =?us-ascii?Q?NJfXszpawNxiAypN3Pp4KxrWduYZKp/ld4Pyj3R38FykGJsr8xSl/ijut7Xj?=
 =?us-ascii?Q?PDuRFFkLBQipRQatz2HGyZwBW81Rva2WV4z/AsJ0phNn34PjkCS3G8OsSGod?=
 =?us-ascii?Q?55OYFWLBrJKsXRDretlnUcj+U6s0BITskVU/oAGppL+frzL0jZSddmu40PXc?=
 =?us-ascii?Q?i7KAIux4jcqBQygjwIid5t+Mj1CBq+gbRNs9hWnXaA70edKSJ5GD2ixEnXrA?=
 =?us-ascii?Q?gjBqsJ5DzijksZjTn4VXAQoGdRp1ysPY+kqOPUQXzUyylPE/aLp9bq4rYh84?=
 =?us-ascii?Q?wG7nsmUJkDhHakddvywS7fRlaqrrR/EaghaFqWv1egLgh8/6f9rGYN9g4/jT?=
 =?us-ascii?Q?zr8Ep+12yna51B/EXHeJqAa67QJZ3WSNft98p4g5KF4DAdHlDSDyHhhpPIoN?=
 =?us-ascii?Q?4u25UpCqEE+42wtywGz1iw817jeJRZfAc7Yi4cs/Y34PouS0uGSoNkR6OJ0X?=
 =?us-ascii?Q?JEZEHghWB8mFk8u74367lzcaY0Yj5JKbvVh5u+ms2hIKvJ3maiDBjllLFQRd?=
 =?us-ascii?Q?cpbVwcXVpagR5ADtWUQ6avM1HC074NzIEXDvGVRKb5/Ognmd1aItH+tI1Xb+?=
 =?us-ascii?Q?t/FymrrrFuHIrGJn4cHb+zwgjl4a4+qTceYR3joYZkofAHeuvQx6jiyLsnO6?=
 =?us-ascii?Q?6U6DhUDz8w=3D=3D?=
X-Exchange-RoutingPolicyChecked: lLKkcEfXq4Av90kRgZmaPsHZ6+V7flCM+DXOZPQ7qfq8vA/QGBQeYAZo/TKXSAnVLuSq2b5ijwL1QmbI9r6jgDuY8iVDYl+TdH5T6tTl0B3xqZdBQ1YMtALGOwI/NYJkYoDmNNv+5GxniH20fa48Vv/uYRg73lPuMN6FtGfFjBOW3rzHw0v0gtOMv6Ir+0sdsD9VYsZY/CQ6DmaHMjIZus3P/Ts9TYCs9qwfVMkfLCfrwsKCgdgFzeWXuFxfDE7tgrJrs5GKQPRleWzFnI183BcfB4xzoXL4/YiL0HUA9Xa1L7VhXn947SM9pAoyehzHe+W7bJQImPbe+/x3SNxOMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c2470-0199-44d2-35e3-08debf8eb2f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 03:34:34.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjJkVUYkJKgjKKLFwPArdiKFja+cyTPBuCPMhKRSEKucozG/+dtTL9IGr6B8SjZpqdRD84aXqGAl3jbkCGUqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com

On Fri, May 29, 2026 at 03:47:50PM -0700, Sean Christopherson wrote:
> On Sat, 09 May 2026 15:52:01 +0800, Yan Zhao wrote:
> > This is v2 of the TDX MMU refactor series, based on Rick's v1 [1], which
> > was extracted from the discussion on Sean's DPAMT/Huge page combined series
> > [0].
> > 
> > v2 is rebased onto v7.1.0-rc2 and the v2 struct page to PFN conversion
> > series. v1's first 4 cleanup patches are dropped from v2 and kept in the
> > base (see "Base" section for details). The full stack is available at [6].
> > 
> > [...]
> 
> Applied to kvm-x86 mmu, thanks!  I gave a Rick and Yan a few Co-developed-by
> attributions where they went waaaaay beyond just tweaking some of my patches
> (or diffs).
> 
> Please take a look at the result.  Based on the lack of bot complaints, I think
> I got the important stuff right?
LGTM. Thank you, Sean! 
