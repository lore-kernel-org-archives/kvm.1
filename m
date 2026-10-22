Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792713660;
	b=1b0xzkymIZZokPN6s81lnzLGLeICNQrYXap42ea04LoKu6QbsPVQrptQauIy7yFUpnPG
	 HOVzvupEXG7bja1uEYc6od5VFk3l4HQKIx/ZYSULzuArHCJPZXACPmwGvDW2k4CM8+Dzn
	 YnOrWXyk5X1lY5eTYYZ0NXNk2uIVapLAD4f+biMdSjwqzrjUbPmGOok4vgvxKnHB8i2iK
	 tEYQbRaQFVX5Pbile/izINB5jife0g1Oroeq0YNmKbIhK6kckmHnIsA7SGLCPhH0N/5Si
	 ov6xUySXQcXgPshVSSzhs283eJtsnkpLxuQa+1fSB5YzjnCdP2kgyit95i8j0lgDhZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713660;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=XktfZRydezidkWffbD4T+pmqimCao366R2EL2LbXVRA=;
	b=jxBRjajSN0m2KX2YvhXO0qE4rA6SJ+cqvRROfMliDhcpk76sB5+FMeL0NlcDiKMA1kXs
	 XNEVdG58llQzVFbQ8bieuqa8JUGJEx75pq/hyD19A0cSahgds7b21WZiKFmnHjJG3BD6r
	 cYJ/VUrBaFlmfkj1eiGs0PxYLb7i3RTz6XvH6pSIIsaplt9KuZf67GhWPnkkmBkFXhlXD
	 JWU2gehpruc4koQ2MrLFqO/VXYgRKJDDeYvkNWNutCTXNpSp/qUBIEOYx6q1jjT/0OEfR
	 Y+g1JgTkfWdbITOOn5FMbmgd4xBuomuGsR5gRAJdl6R8Afg8m1Kp8oSfLKc6T9lo/Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KqBUBK9g;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44617606A319;
	Fri, 23 Oct 2026 00:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44617606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KqBUBK9g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792713659; x=1824249659;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NVyAHeRadyGKCFK20Qs9fTRn8t443zVp1z1zvigpZlk=;
  b=KqBUBK9gjTMBz8xRppskhOk7/PNDBYtLxC11dy4bfPF/lWCfJRZ9rXA1
   v7Zgg5z53FmZZUWf418RRS16tAIpq2voK1/2J1ugyu4U0Xrv9YWXFLc40
   W13uhLdM0DdmJG39DFIzBlC+E46Xp1mwXwrBTJAhdAY1YOLOa/owBGsjG
   qQbkdDhLc7iDbVewwS3/cCkkZKqVinQ3age7A3qJhR9E/osClHj2RlwB0
   le7rxsS2BKLHkmCyk4X27ag661q+sNRIW2huNWl3ROeHjYvqYzqtx0kUd
   mb2IbfiR/snJFmJKQwdiBAySd7Yt1gzTsqfyn8YPdTox6VFVtr4xzvLBk
   Q==;
X-CSE-ConnectionGUID: lWZVUY0/TMSdDUlGLChSSQ==
X-CSE-MsgGUID: 3fELNHf5R229Cdx6QoDP8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1489829"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1489829"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 17:00:59 -0700
X-CSE-ConnectionGUID: db23N3RPRgOaRsrHUGbZ4A==
X-CSE-MsgGUID: lGtQGWCUQVW8MpJO4kBIWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="5320449"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 17:00:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 17:00:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 17:00:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 17:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGdfRSLIcC7dgvGQHaC4hQmjFbeVtcFGjPMxvHxXAHMFjowdqASZEVWp8pf4E/NUFrLivKjL9n+R6gmv+HyvUji3HpdrkOd4oSyep2vhm6eTmTYf69rLNDfOtSOT+NJkWIHEMG9pF03Rl8l0z+tLD7cnuPkzgt5WARLE9krqh+t4C/ItWQN0qGf2ImzAW5T9WKzBgnrvLjDIDuj97jv77fYCVLZCAbA84KlpZFe0fMQ+MWT11nUKWq6BDcHhjlDedMoQIkZUqAzrFUcf5dyaIAezpO96exrfJKb0K55DRw4wyIYZztVZZ2a37xWw+mpZxiERYoM89u8134pWWBcDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C22H48PFMCA8754bZ7Gi1nFvW+k+g//9/tBK+M4qPbc=;
 b=BqZK/wRFMRhYjow+csr6GUV8GFCNE9tOJHxoOMEusLKt+eqaynpt/y66yNzBqVJV8JqkK4ZTFtCJgIzz3imnOBVTJCaVuDB5Uk15a6QhjEFM/Ol0XShpAXbZbal5NLlBXvgfJZh3n03p3ds0drepvOt9ebuBvcSEhIj1r0HjfYIoIExFkXm/4gmlb2JQZt1aCjgDaq7avHfqL3nP1fRaSZ/dU5N4kZ7c2KUT+JmfowA/HVtT7c/PmkaMCHn2C69P2GD8R9vZFM1/9RwB5J3/wc3BnAH+FL7im6fYXORc3QStD+Ggtprz+2Uu1yRj7/vFGEbru/Ro0IaUeOKYeyG+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DSWPR11MB9692.namprd11.prod.outlook.com (2603:10b6:8:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 00:00:51 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 00:00:51 +0000
Date: Fri, 23 Oct 2026 07:59:53 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atqjeaPTXmCfiQmo@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
 <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
 <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55ccf641218c6553b2f43f4394b92c23bd8b5d98.camel@intel.com>
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DSWPR11MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e27ceca-4b9c-4a15-c441-08df3098b32b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|261021121427099003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: xTgeNey/iXbj2hkMFRxWqF6fptP00+KLGgrRc546XGLN9bElcYH2oH1yGOnR4iYTf//Epy9dCrytcuMoGzq0/sPqIDmaXuRRs6o6YmU1dHeIH5tGJnUt7YjYL4oMi9oBZuZg6y3dcDFePUUkbqiH6q4919aBLBkoE5oeEyGCLmqlkhVQ/YRWN5cdkE+SyPjYP8rJ0KV4qNLSe9sw8I0vgWjvvLW4K/fsDkPbUiNT/8q01cleYIeQRUykqv/hk0VcsJBB9lPzKgfju4bewnETEB5Rpy/qASvQO4Hhw2vDDOT3htczAcVKGAiFi1WiXz55+mAIAdDsHCTVXdhADfpngORQucl4Hn5X7B/cacSidPahVNpRgQCONPnPWO63XKlQlRv7b/mNuDagwfBtBDUow+8xIJjj3cXPuuzSNAEhMw7aiy20ujOM1eci1wAeo3h1oxpMCxO7ror6a5FFi7wp2YWKlhF8YVyIImkXhm9Kwfi2PQahFsQA3IQmVfljQ+v4b17OoAvgR3fqi7q3aYKLyok6gkPA2xfqohWIeqR8IvlMWq+q5iBi+1yslgr4nxSP3JW0UFykwauLOWXmn/3F2E1p7r7Mo6yst5Vr0FcyT7y8S5cDanOgHTMAjS9Hw4nm8sKOHZVVNWDbc3UPgpmpoUCel7leL9E6JBXmUeNcgNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(261021121427099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QUhJstW5L4AIj3ToQAduicQm18plYeAc14TYPfLEOJSDaO5nnIlinlD4JP?=
 =?iso-8859-1?Q?91hS9Nikx/1pUZaZJkT5Lz2KAs7LqnFEhRYixOHXP+379HaYaSE/vSGoQc?=
 =?iso-8859-1?Q?BmfDul7ltx6HO77Jdr/QIE4TyBeSNGoVJcIEfQ2hq6t0tBQ2oESoPAZzr+?=
 =?iso-8859-1?Q?o5kSHR0WwZFrPwMDlSwvAbmCfbwiSn71cLPZSB3l2OVBUr4K+RNEnvbVlH?=
 =?iso-8859-1?Q?cl/4iNCrJkOV3LruHNmC8K9k5IWmpT3HbZzOFsZ56ptHundO9toxW/x88a?=
 =?iso-8859-1?Q?X3TQWEQS1PvrgcX2L2p0nvRWmn9xRl/Rrt4dechjc5eoB/pj8MMnaoZui5?=
 =?iso-8859-1?Q?AH5zld7s5KJuYHpf0CdD8JJ/z32zv37J71Kqb70Feou2WPj0r2p5AqRN2+?=
 =?iso-8859-1?Q?pG+13BvS7c10nyoVB/bqTCzNf3f/nS2iSbNgw9SkECm3YCD0p22dMqvgYL?=
 =?iso-8859-1?Q?qAsY5bTJil7O6gB5PYlMSLfQmLUYRaEz7rWEM7XW+wI2l2fPgNvagw8c5D?=
 =?iso-8859-1?Q?5HqGIU44KVCSjDW5M7zTUQWrOtTBI6WMWk4g8IeL0CJjkOm/Dq2r5Pt4K1?=
 =?iso-8859-1?Q?bHMzL0cAv+P37e6Ec6j9mKwBbT8Zcvl68e7AGdKBM0RG60L9c/UdaUfBKZ?=
 =?iso-8859-1?Q?L5EKo79f8mcVry05I15Ebx8Wnks7e+vVsU//C06DT1b/NC9lIL8Dpd0yn6?=
 =?iso-8859-1?Q?FSc2u8/3wLywxbLIXmf2uRvHOIAOd+HkbwzgACfasiOo3+IqPUUoWbDELl?=
 =?iso-8859-1?Q?rQxyPtiHY0apMJPsvkH5qw0TxRRViHbk468hAWJJthlYk5MbsYHvN2DnTj?=
 =?iso-8859-1?Q?DxskNyAAvhH6XM7a/PjMP0HkSRIGAJhV/qoaE07dZcfNGX2C2qck46DwZT?=
 =?iso-8859-1?Q?BBnSSffUykJpIGwW0MvYmdPfLeO0cNl0WFbg44v3cjhkKKHWYI3B6P1jYY?=
 =?iso-8859-1?Q?FU+Fm/5iTMsbiiGcBbX3QtPnP9iFB66e/gz68qo9gfjLbdTs7IVpHLTy9X?=
 =?iso-8859-1?Q?GvjSl7KA6OjMgDITHKcsyZ/2GOMa1wyF8K83BYULcSJ+4rFCkzR6rMu6xf?=
 =?iso-8859-1?Q?DeYdRijYpdMCa1uR0q/Jxipg3wF70hgADjJV1A8obMC8X6aW1haxsTzbi/?=
 =?iso-8859-1?Q?5KzXLxEBf+mxmEYgqOgN/ECyXkv1LYL1fyR4er1hE8SEgaHVZkl3jr69F5?=
 =?iso-8859-1?Q?L9YsxbG3LPHuGp9f8/5iKq4OwzqMSgmL4mVFytzzKFVsdW8m06f0H0KEAY?=
 =?iso-8859-1?Q?8QucnW37s5VpicLbuvKWc4ZuN5VlY5JiqmdHuFHt0VP8+ggjy9XFgKVQVG?=
 =?iso-8859-1?Q?iOq/oe+CYTl1bhmIXmInYDjFG/98Lz0T2kir2Sa/IanLonH4XRrhXKg/kl?=
 =?iso-8859-1?Q?Evz/VhVnvJikGEg+5GvSfO4Oc0AH/dZM+q3TK5wXR+lsoQUU8pefn/Jb0Y?=
 =?iso-8859-1?Q?UKs7zfHWBN1O3ZpRtKqtzKpIFUhL8tUjNoMnDM9SmELq6pO9MJgLZWILu+?=
 =?iso-8859-1?Q?8Wx/G7UIjNp7p+ajd8u40SbgDv33OW+HjKSznECSbMaDWZELyvMfIzgSlY?=
 =?iso-8859-1?Q?oXSCzgUYT560WoVFIwSQSEMKkrn28Qg42aDtVIDvkps1fDeC/9Czb6YgZX?=
 =?iso-8859-1?Q?dVFh0XDB0QigRmzexOINNc+ynpDGSB/JZRXhgota9ufUiED6FODFgDYjrU?=
 =?iso-8859-1?Q?Wj//ZtDKy6EpsUK42QwNA5gHEFxSoWgMStRobAPDWRCvKvBa/CMCJGF1dM?=
 =?iso-8859-1?Q?6mqTTv0s1Ot8bgpYz5FAn5hHcg3gnO6ReQbh+CkEEoVptTBCVOupIHGH7a?=
 =?iso-8859-1?Q?Fwaz0r3u5g=3D=3D?=
X-Exchange-RoutingPolicyChecked: Q31Ycx2vy3msvs348S9jQdnBHn74JkW+3kwOGQF0j/12fhMoBC9gyqPNFpmk7haSMhRNgPOGyojvGy2n3FVXtHLocR7kD+eWfo1sw1ES+fRx34IVH33oXsfswzDta901MN0ICPA9gScVYQQWNwr1krxjBEm9o/vN+JzLnVmWHqcHZkh2DYOSt4rZU21/EukTFW7P9SxHgFTwiKiKtvr9ZB9jn14d0W9KUw32EuiG92jBjRfw+LIpKdtXBtwad5O8Hl7gAMtwQTeNhjpAxmkLjbfQ3z799SJHiguyFI/nb9Y3gQuwa4vUiOtcO+upsYsLBxlkQodur6UzNZJ8aaQvqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27ceca-4b9c-4a15-c441-08df3098b32b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 00:00:51.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA1D08odmpwuUat+XUTWM5vaWjG89gHsu2ibhNM/CAGfBhiaRhlsN1tkYnQ0qlD6/mfsp9bclC9xZTuhe3N+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9692
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 11:56:47PM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-10-22 at 15:24 +0800, Yan Zhao wrote:
> > static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu
> > *vcpu,
> >                                          bool with_root_spt, int min_nr_spts)
> > {
> >         struct tdx_pamt_cache *pamt_cache;
> >         int dpamt_pairs = min_nr_spts;
> > 
> >         pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
> >         if (!pamt_cache)
> >                 return -EIO;
> > 
> >         /* DPAMT page pair for the root SPT has already been installed */
> >         if (with_root_spt)
> >                 dpamt_pairs -= 1;
> > 
> >         /* +1 pair for 4KB guest private page */
> >         dpamt_pairs += 1;
> > 
> >         return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
> > }
> 
> Yes this looks much clearer than even the upstream code. Do you have any better
> ideas than "4KB guest private page" though? Because in the split case it is
> actually for 512 guest private pages. We should put an artful comment to explain
> both cases while not making it look like something that has a better solution.
> Because I'm thinking there isn't one.

What about a comment like
	/*
         * +1 pair to account for mapping a new 4KB guest page or splitting a
         * 2MB guest page into 512 4KB pages.
         */
?

> > In the fault path, mmu_topup_memory_caches() calls:
> > r = kvm_x86_call(topup_external_cache)(vcpu->kvm, vcpu, true,
> > PT64_ROOT_MAX_LEVEL);
> > 
> > In the split path, tdp_mmu_alloc_sp_for_split() calls:
> > kvm_x86_call(topup_external_cache)(kvm, kvm_get_running_vcpu(), false, 1);
> 
