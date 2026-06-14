Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EF204C3B;
	Sun, 14 Jun 2026 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432930; cv=fail; b=nglKnkw67I1Q/oVG+YjJRmqfdW8ElqdhlB/EJm8aRSj7RnqgCPAT337iG1rt2Vc7z/f+U4ffCpU5lOXPKtzq+2rKWkVx4CsbBk0Kp0uMA8TdHvLqJKEIKy3l7uke+gljo7aGGZj+7S1bVlawNVSzzqQ/AltZwWCwIxPpCKrqUMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432930; c=relaxed/simple;
	bh=1fJcM3vQL0/A8F1qfLzAdWI9bFV+N7qKoGA1KTry97I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVyq+hRY2swm9whPeRFVVxhbK3dQpIWFGBFDNtXoIk1/YIJ6LRbm57r6UWw6ACLFtLyhU6HCIXoYxryZGtIorCOfZrIbda68M9k9DxxAyjkTsL3EHw53DQi28GcocUzNXRYkRr5HcXvAvZh0Nh/aXYczs3iafLWWbKbqgmxvYyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL07h6RW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL07h6RW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781432928; x=1812968928;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1fJcM3vQL0/A8F1qfLzAdWI9bFV+N7qKoGA1KTry97I=;
  b=fL07h6RWn4Crtugyg5hkN8KKSFrCyrjOzWqGgB/0WTQFNfkCW0ehNLO/
   ahtF7fz4kVO4bRnSsFTYmkmDSS23wLeBf9PZH+Cze/PoK+MBhxdZ604gl
   nVX/n/+6FrKNEaMc3UdPlTMfTpyvb3rFL6NZsadOjxAp0l2qGVllravbY
   WK3ZMullk6TK6eqoxUTD1tMVxkOjIgb6H0DdwixplNgs3tm225ajmK6Bf
   JQCdo+1b+CkGw/BLf3JXduD71ptmJZgUcKw1axGo0bG20y+jbyey6/xAI
   +Db+LquVsltCKR/sXkcqRS+ujsJqegVY7KfUSuOd5ngU3SsoXZiXTQh3D
   A==;
X-CSE-ConnectionGUID: vb9TWH0xSO+bELwtvaIBzA==
X-CSE-MsgGUID: xM4G/pfoRPSCCg5GGTAtuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="92759245"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="92759245"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 03:28:47 -0700
X-CSE-ConnectionGUID: y5GGRDblSMWoenWvVwE92w==
X-CSE-MsgGUID: kiT9yQ0OSFeP9c0U0UPunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="246326805"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 03:28:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 03:28:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 03:28:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 03:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHpZMKpvtsI98ttK59sH+JCNVhsuLYNY6ZMraH7mdedG41LTgM2dRPQ/zXJE1xJCCMwrs1ZV5lhjN9tojo8NZJDtC5dbhPDyzA3aqisS/IXQFVXhqplgjji60G+kkMkqo2bTE66J/4pgfoQtx2hYXokZfgd1wnJ1dG5EKBRxS1MKl7zrMhB7k7vMun3l2n8OOQbYKHqxRTFo7cvZIGguavoErtUcugzAt/kl7dwdshtmpb9qbH1xacItiKIXlQjTitbhdfGApirRkMkB2WTQc7LzHd9lTR2tlLD91ygfDITqFxYABTQIatgdCvgsc1o6zv7XAMu3SPHRoCcv1qdLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V1hDbHk2MMYzBYTf0qJI+2WAEzg6NhFFqTjIsyS6n8=;
 b=UPTnuCCUHvRq0cIRnMT+KLTT7ZlF8LI9mjRx2MnubGjXpwgTI+wqzNOIlN+KrSi54le4qzTEs8w6sG342dtyrSAh/M2Gz7DxWoe02nWw9qorXzjq11vFEJ6iruLIb3tegagoGz2lqBBbt3hJPX2pgSm6K6kwVbWeeb1spFLiXvcy4Od1dRGkEXH6Uql0cCoOMNc5fA1MgvWj9IiLgS3yqwzLMywBsD5k00wCdDAHdSkqckh6CNWEjtutheKuzJShOJx4748TWq0gnBA8cAKnYnhf7ajXVEpnvCgjJu4Wx4OOMWOBEVTfSNiRX2JptkOPZugOdiEcavi9r8yL/6CniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SAVPR11MB9549.namprd11.prod.outlook.com (2603:10b6:806:4e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Sun, 14 Jun
 2026 10:28:43 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 10:28:43 +0000
Date: Sun, 14 Jun 2026 03:28:40 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "djbw@kernel.org" <djbw@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 07/15] x86/virt/tdx: Prepare Quote buffer during
 extension bringup
Message-ID: <20260614102840.GF3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-8-yilun.xu@linux.intel.com>
 <1a4d1126d6fe86e94fa8e1de6764656853e61106.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a4d1126d6fe86e94fa8e1de6764656853e61106.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SAVPR11MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9c7dfe-a615-4da0-7997-08dec9ffb4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|5023799004|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lHCy9sHMnbxRsk+u3VN2VYu8RdqaZP2QrXdpewjo7dLr3ZIWl635sZXO2KGqwcY9RB1W7A2TY+hLEaReI7giMMrojQHMAcd5jhrkOdS66Gxdw3CtS8BUsG1/ydzeWxtEoufa7JsGsD2Jfj89AOvakpPvVUHY33t9ae8qiPwOFAEJkSp4ctbU5ER/nb6SqR6xyVKa7C4Fsya4IJlmX3M7DY1uDuRqJQI80IX9xsWDMwsZEgt64yhIfdJmoIlF+q/627qOfP7iJKtmHeH41M0aQ6+9SFEI7/ZYydnBwB9lszOb2HslhCVAGC+Qs5eoiFTjA9bdiq+hDdmc1x+NA85pgSs7wryAUSqikfUNEyKGQB3ezL62kc/eSz1yASf4cQjiRBkpb5U1hpLPTBdV/6JjzaJrQLKPMgJaPvwUw+iw0WUT+dMr4aL8Bk1En19MffWtscvvHwwbpyrKViA8c/rlelb4aKP8gDTKYZImG7gcU3OOJ0Svbi8VB4PAx9WWKQjpB1uyzjil4opMUJsPTuCsrSb8obWh0FrD0CKLTn9KDCZvAbQLxjFQ5MfHmakrP442ehUdrI8A+XclYwFESX4BsOXjXUoCup3GXgyQGO7eLtCTI1XzMnEYRjsdS2+kStIQGgHsT+Sg4+UFTZHlFhc5/wikRn73d1CoHJNvBw6aBIgsYLNcjs19a7clCUYoXUlF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WkHn5x0GYgpEhAvass8AMVugh/0fRZ8I/1OWrgo+74j1R0jr48vdpVPIUo3?=
 =?us-ascii?Q?VjlkbH/WSZZHPLR6SyxYayNewzfI+0tUZ2gK5INORM/fYWXOZDgWsCobGzO/?=
 =?us-ascii?Q?0gBPcuQdKq5em0z+pknRCVFGIQiUOhZDjGqayLtyylFHaX30wB5h8WhulXp2?=
 =?us-ascii?Q?yQPvVJBBr9mVNs194fsnF2tUHlECoiZs6Y5fEVS9xL0fHr2m0ztuRoK9tlaw?=
 =?us-ascii?Q?tLF3VtNierOAOBA3cA85V22EYCgr+2V6fwX5baTa+ho8FiALGLfjrmrWRot0?=
 =?us-ascii?Q?Rfc5J0gMQFH5YgytZCqaeeDbknHbP89lhkz9HHY2yDctl1eCVZvIAGUaC+pw?=
 =?us-ascii?Q?DAMwvHxXQdt+9qM9Jav4EqiaebiUk6Yy4pwfzk26fch+iYo4CoSH4bspdvwA?=
 =?us-ascii?Q?6EcJQEDnX998VPJGy5HeVHl5Ws/1iABt93M4/SYHw5eQnXCDQIVon1vPW3bg?=
 =?us-ascii?Q?mDbb0WSkzNqxHLRns5j4f0mUNbVhhiDX0DqeaBle6KTG55DhUgqmEjYNDNE0?=
 =?us-ascii?Q?Q28GSdNGi6j5xOu+t4gvrXyHAuv/0jTonNjCB3spvFbwvOBWGcwZGsyNdaTJ?=
 =?us-ascii?Q?Zakye5aebWbTYPyO6rkBXjsx8XtnDMbrKBuNFsPx2ujvNAt34RcCL+Gebqj2?=
 =?us-ascii?Q?bswmvUuRUmTqv9gttvQLbsDD4gbX33b3EAJipNOGURZOgsY5g3z80ZHzGl9V?=
 =?us-ascii?Q?Cid1LO7GYZ8eaLDkfuM2KWnXXXtzGjuCTmIOAW6GPCxt2smbT5zrYGAOOBSy?=
 =?us-ascii?Q?NJyVT6YW85tl4zEfVIx3UpzyYo+HZaRWZDcZAReXTmzihtvweTt0N1ZF3Kyd?=
 =?us-ascii?Q?tZU7GKPbz48e37qHqpPbZ8W0uNSyI3AGHSPme2YPLBa+dnnyWirJAay7KjCe?=
 =?us-ascii?Q?Sivhqx06PYxI8patJEj/7lKyac5epQpN56blXP6JMgi0VgMVaObdceA+gfZj?=
 =?us-ascii?Q?QF7+KZKSy+c99labO/2sKSCBryC2H37/XCwmTBMmm0/GBnyqNMNtQTgNQauT?=
 =?us-ascii?Q?Xx/NkXX0Wh8D31WUitntTvF5WuUuESg8BnKgerDBR2kdAVc63sEDzlXDT/9/?=
 =?us-ascii?Q?tRl/7hRK30+NQ8oON8P7a1zuo4DRgNFm38DIr5lxkPBhrkcK1sfUUlk/8bRu?=
 =?us-ascii?Q?4xjsOr+Z6iqc+YbOUp57bPQZubgPOyv2kmmXJMpUEbY6E+hrimGVsDpP5SdA?=
 =?us-ascii?Q?+XvpQg1e+VAYXE8EkxOWynsg6nnGtTMt2halHzr6frtK9qIj63lIULXAzD9C?=
 =?us-ascii?Q?1KxkzZfmyxtFxNX+oB4EGZsRuBdKY+Mwla2QGaLskg6lSNok6fhyVB7JjFQe?=
 =?us-ascii?Q?X4E3M5PQ8x7tR9mIEeplfOK6fF+CxWaDVyu9u9ePt7dXUGQ0hOBvLoM9w/Q2?=
 =?us-ascii?Q?FW7CQAVBMs1bsS1EqnJTfaJPIgwQ/SEEhz7uMYvERrUMxN2VLUL1c8b5mSQF?=
 =?us-ascii?Q?oKo1L8Mj9E0sjYZEi4Mhlx0SMiyRDbnyKjvJXRbUMX+of1eVjDA7Ps0K8nHM?=
 =?us-ascii?Q?Xl5cqsC6A1m5gNdJ6AB/LJngbznzScaTkNjuotyrKiQZFnoQhVVoj/KVrlv8?=
 =?us-ascii?Q?cMBr+GkqeTM599u/XHfWc1Y0tZXgMZoyfNu2Ii58YSDgDv6MHUSMgR6AojfD?=
 =?us-ascii?Q?rllJ6pjpyzzhmt4j/r6teXdNNfk2PHtNqRmWVyBYlPbmsRUflsiwrT5dJSyj?=
 =?us-ascii?Q?J1OpBD86FfgdE46QYbmp2H+ApDyHDYW38BEHFyFm1kG8QFOIhGlsuabKLJHY?=
 =?us-ascii?Q?YN88oPhhLw=3D=3D?=
X-Exchange-RoutingPolicyChecked: aKtc6JccqR/XEFmPV0M+7Z8psMnWS5bau96dP6jK++U/qHdyLEpHDYATRV7Czalle1Ci7+jdHKiaKnv+wmeUQoHX3GQDAtdVbFyTb288javU7PU+Lojk6TiI2EtQM5r8S3KqcqjOdo73fBcAV2jokosHPezHUjeUWCLzEfSo1i04gMkcS6iEX1P9OnWyFIGLf04wLXGh4NMak9ULx0HQ33qnTGxWdHmkzehBdKuYZfcBthQUVBkMYoxm4P8nmFiik5daoUEV7XBOW+MoAynhSB/x5JPX2bZkC/iS905jt5EU1IN7pgB/OeujCp9XtGTMcx2/+LLeg5nYDlruukN50g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c7dfe-a615-4da0-7997-08dec9ffb4a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 10:28:42.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no852xSPcEapnxgk4Pud14QhPOD5QzscpWhUpo1Stq6bge4ijIOxT6Fo3zYlEtjKfmHgOXA8G38BNpvFtQeyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9549
X-OriginatorOrg: intel.com

On Thu, May 28, 2026 at 03:30:36PM -0700, Edgecombe, Rick P wrote:
> On Fri, 2026-05-22 at 11:41 +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > The host uses a Quote buffer to communicate with the TDX module when
> > generating Quotes.
> > 
> 
> Can this be put in common terms. This is going to mean nothing to someone
> reading this that doesn't already know the feature.

I'll add more background in common terms here.

> 
> >  Because the Quote buffer is shared with TDX guests,
> 
> Why capitalize "Quote"?

This is again the balance between using common terms vs TDX language. In
general, TDX docs capitalize terms a lot. TDX attestation docs always
refer to the attestation blob as "Quotes".

I mainly went with "Quotes" in the logs because that term has already
been used everywhere in the tdx-guest code/logs (see tdx-guest.c). So I
wanted to preserve some consistency at least in the logs. In the added
host code and prints, I'm starting to just use "quotes" because that
seems to be the more common convention in the TDX host code. I'm happy
to make adjustments if this doesn't make sense.

> 
> > prepare the required metadata during Quoting extension bringup.
> 
> What does prepare the required metadata mean?

That's a poor choice of word on my part. I'll rephrase it in the next
revision. I mainly just wanted to convey "prepare struct quote_data".

> 
> How does it being shared with TDX guest suggest this? Just that TDX guests will
> need them? Is the reason just that only one is needed, so do it during global
> init? 

Yes, that's exactly it. I'll make it clearer.

> 
> > +static struct quote_data {
> > +	void *buf;
> > +	u64 buf_len;
> > +	u64 *hpa_list;
> > +	phys_addr_t hpa_list_pa;
> > +} quote_data;
> 
> Hmm, I think this should separate the type and variable declaration. It's not a
> common pattern. I don't think there is an official rule.

Sure, I'll fix this.

> 
> > +	qlist = vmalloc_array(qlist_npages, PAGE_SIZE);
> > +	if (!qlist) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> 
> Just return ENOMEM here. vfree() doesn't do any work if passed NULL, but it's
> weird flow.

Will do.

> 
> > +	}
> > +
> > +	/*
> > +	 * Make sure unfilled entries are always -1, which means NULL in TDX.
> 
> Huh?

I'll add more explanation here (see below).

> 
> > +	 * Only the last page needs to be filled. All the other pages will be
> > +	 * fully populated.
> > +	 */
> > +	memset((u8 *)qlist + (qlist_npages - 1) * PAGE_SIZE, 0xff, PAGE_SIZE);
> 
> What are the entries? And what is a -1 in u8? Or is it supposed to be u64?
> Please make this a lot clearer.

Yeah I was trying to create all-1 u64 entries. This is pretty
under-commented. I'll redo the comments.

> 
> > +	/* Populate HPA_LINKED_LIST as per TDX ABI spec */
> > +	for (i = 0, j = 0; j < nr_pages; i++) {
> > +		if ((i % HPAS_PER_PAGE) == HPAS_PER_PAGE - 1) {
> > +			/*
> > +			 * The last entry always points to the next page. The
> > +			 * address of the following entry must be on next page's
> > +			 * boundary.
> > +			 */
> 
> Can you maybe just explain this format that you are building in like one
> sentence at the beginning of the function? "The quote buffer is passed to the
> tdx module in a format that like... (some common terms that have no TDX
> jargon)."

Will do. This part is pretty under-commented as well.

> 
> > +	qdata->buf = qbuf;
> > +	qdata->buf_len = (u64)nr_pages * PAGE_SIZE;
> > +	qdata->hpa_list = qlist;
> > +
> > +	pfn = vmalloc_to_pfn(qlist);
> 
> Do we need a vmalloc_to_pa() helper? Maybe put it in terms of tdx format. Like
> vmalloc_pfn_to_tdxpa() and keep it here? The tdx update stuff does this a bunch
> too.

That's a really good idea. I'll do that.

> 
> > +	qdata->hpa_list_pa = PFN_PHYS(pfn);
> > +
> > +	return 0;
> > +
> > +out_err:
> > +	vfree(qlist);
> > +
> > +	return err;
> 
> It only returns -ENOMEM, so do we need the err var?

Good point. I think I had some other errors that I later removed. I'll
just return -ENOMEM directly here.

> 
> > +}
> > +
> >  static void tdx_quote_init(void)
> >  {
> >  	struct tdx_module_args args = {};
> > +	unsigned int nr_quote_pages;
> >  	u64 r;
> >  
> >  	do {
> > @@ -1218,7 +1295,13 @@ static void tdx_quote_init(void)
> >  		return;
> >  
> >  	/* Quoting metadata is valid only after initialization */
> > -	get_tdx_sys_info_quote(&tdx_sysinfo.quote);
> > +	if (get_tdx_sys_info_quote(&tdx_sysinfo.quote))
> > +		return;
> 
> How come this patch gets error handling? Why is it needed now when it wasn't
> before?

Previously, get_tdx_sys_info_quote() just happened to be the last
statement in tdx_quote_init() so getting an error didn't require an
early return. tdx_quote_init() wasn't doing much at the time. But now
the code can't see a valid max_quote_size if get_tdx_sys_info_quote()
fails.

> 
> > +
> > +	nr_quote_pages = PAGE_ALIGN(tdx_sysinfo.quote.max_quote_size) /
> > +			 PAGE_SIZE;
> > +	if (tdx_quote_create_buf(nr_quote_pages, &quote_data))
> > +		pr_err("Failed to create quote buffer\n");
> 
> Err... what happens in ENOMEM scenario? NULL pointer later?

Yes. struct quote_data remains uninitialized so it will have NULL
pointers. All the added APIs will take this into account so there won't
be NULL pointer accesses.

> 
> >  }
> >  
> >  /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
> 
