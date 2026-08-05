Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E13D1A97;
	Wed,  5 Aug 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918641; cv=fail; b=RJBD0ThOCSRj71LrVKUMoQBI/MK9Mfy9ZGXCVkL0UxOgF/d1u2a1tE9snYGZfdpMz2XoOleuR8iY0nr+HuIDYFdveBi+zn3GDPERC+Hn8F0oE7s+AWr7mbNCHWNo1DtDjlsloKEjn90AEPO3BE9gWnilkQExSQ+UpxnB721T+ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918641; c=relaxed/simple;
	bh=PHvi9RGBVUe1zQfdu2WNK5aaVwik4O47xnaO3pCORPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VrE6UnPdNfLmTJMpoEklYrYYrLH4xx0J/WizP/rzrj0Dl7S91B231vSG3tMkt5pFLdO5bKleuw4YU1pvcFhWMA5neS9ybIJtn5jzO4ACteqkD4GsThVN5GzxHYsbhnWckcL53gVp9X7Mx/gNBUZEpmC8WKbEuNQeB7jzHvP8pFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoLrlqj1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoLrlqj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785918640; x=1817454640;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=PHvi9RGBVUe1zQfdu2WNK5aaVwik4O47xnaO3pCORPA=;
  b=YoLrlqj1b4O8z5f5ESL6D9xv5PLZOx9wc6AJ0L3SEX/5fseR7Qz+aINS
   Ec8W6JoXIen5tR3Q0MHKuZGdZt7b3pCFm9dzHBvqEGqKoKfsrfQT6Bzhm
   blDeCQZTtLoNB/XlSmWrJ1L6GkPvmBm7awxq6Be/Z/U3hA6pu5105a3Hc
   6OhPDW1JcPl48FjrkMjJYjhIJL+6XNiKSTQE3CGZpLVRaJt+A+6nD2tvM
   qqJv8kqAO14aB7QuBM4X+dqma5l8/LH/YMHjOKkubOjryVEe5TWcTus7n
   6eF8wqq7vAgM8oHU/v9Hn31JYSjJfivw2kd95Um18fyEns/ytZpVxuecc
   g==;
X-CSE-ConnectionGUID: OZN34TldQBGRAZ+MmAKuoQ==
X-CSE-MsgGUID: vGHjqBvdRkqNqmx3jL3kAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85611630"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="85611630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:30:39 -0700
X-CSE-ConnectionGUID: O7KZODKCQJaRAeMqV7+9sg==
X-CSE-MsgGUID: faDwNJfKSv+21VpaE8k8nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="257440631"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:30:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 01:30:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 01:30:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 01:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqG4jr0wfvo+w3Wvp2qXdMbcrqN2KbWemYLg62TbIgQpDZvomH2mN5OKijesIE0dWSPNjR8F1tm1qSvsx+IVzt0AywfT7KpDWRv/nkVa14cWjatIShkIoDzNObM1YGl3Ye2HErACwuU6aFXuQjOhViMXFDCPqam9mOJFtXEhekSwKPU085P7uh6E7kPlmGdanihNIGsLfB4m0ZaYZ9xgDt2RKcalFtMclt7pQsiORAJcs7pRien/0G/i7Y3nmWIBwilR6b5WjY1MoNPuxw9MjDjawAI7RliRzKRQIkL9I2uTRJC54aGSz48LLH+fS8qJAio4gtVAWdtzlguG+VTKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiRr2tAImdVbZSQawPRfA9HLV2gTTYrCMo2SHJmnQC4=;
 b=xuiiQGZ/svLv4Dn1tbPKcq3WHRUV61KW8wWwM26+3csKX14rMkJ6hCkuIfNhQoAHvnEYx0Y1Xc2Gv1uObEP/IQAg2HobFyF+1lTzU3IW8Fi10A87boYkD3XdUZGD+IWrCdtgdVC9YcpA4H21gP+nX9qcsl1oDyiPk0Sq6hu6O4bFErDSNqwYd2LO6kyCLE1faJq5sSB29R5Zaq8H85EL8ZxTR+dOIZxLYkn6XElsgt6h0EGkVxm+gMdeMBwhMAO+t3Fv4f5j8tiK/Q4i2yUnEA9R+ZPBYslbmBNrDYyFiPgc8qIazSKRq5sFnX2v1GjsGaQaDLCJEyF0u5euBjdaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 08:30:31 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:30:31 +0000
Date: Wed, 5 Aug 2026 15:49:46 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, =?iso-8859-1?Q?J=F6rg_R=F6del?=
	<joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine
 .gmem_prepare()+.gmem_invalidate() into .gmem_convert()
Message-ID: <anLrGmbZwgWnNUkp@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com>
 <al_BAjCNRQUvuX2c@google.com>
 <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com>
 <amJhzgyQMVNVD1S3@google.com>
 <amLLoRkCCaK1EHuM@yzhao56-desk.sh.intel.com>
 <CAEvNRgGhzjA07-0jwJNLbg6tBN9EJYXpSeGJsfBvs8Hc1Sv3GA@mail.gmail.com>
 <amOrvxQQd5D17F9-@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amOrvxQQd5D17F9-@google.com>
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|DM4PR11MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca5c4ac-d481-4e22-fb99-08def2cbd000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|5023799004|11063799006|56012099006|22082099003|4133799003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: b4ZsjfPZM2wunIpxu+wlzr+Pusbvo0at8CNBZb+dwEQGda9GPbfddoDV4uZGDAl3oTwxGbrj98hHemS4Ux4CmiIqrKHu9p6WCNAjUVQJYxPsWkazQoHJ6njxNVApRFlK93Yxie2NBcjuMG+9TutmV74ijFgnGjuWjjhVGsD/9Q9FhjWKKHkTzP9hxNRnigV9qLBwgLG1bLJIijtqTf/4XuKsu5sRubbihwqLAmVpcLXqyD/yu79HLD1UYJDTWGbKcfYgHLpNU6t/XHZlDxu3d56nCxUX4JiBJAMPEQEdWo5V47gjH3Ne96egEEt5aIPdl+sHxxivFH8Mg7kU06cehPK6gzK+CtMqYcRjzBaj6IRtNk07tI6TsQO9YlHGGHBN2OHFZYzneBi1Vw3o1rjGPDN8+Oi3r7TRgZgapWRc29Sl+T/YlVWjC0U1/Oud/qQoXPCvKCYG8WzKKsoLlSUSMpNW3umX51nM6/MjiW7w5JOdtd7MPONPPWAlyMTuHK2a9Bex8zJdoT2KdKFasJMaFDhwGkLrOW4ZsS/lUEE7r3ZrO7m2Vk0l95GHq+gh3antVsP2cwC/NC8v3RZqXVJHGCVZATo3Jnkm8AFIysBqwHTtCbodlP2zERIE69LQTDFhO3BC+962nsuT+OaolQ7p/txDdFix4u6Q5dSdE/3CoHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(4133799003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRyoiSl/iMX92WSmLjZFvBGGOXN+LfgFSgiuBO6KCVR2ExpsEMbxK3ybGGSv?=
 =?us-ascii?Q?Q4zi6Qlvwi3+tOAGXhqr5pepKodpjE7xK4lwYyeNI3qd8zIwr7AvqmGrYuYZ?=
 =?us-ascii?Q?iB8Gt5ZCzxZqOJEC4I5edUkKoIQA2LpDTy//3/1McGZkgfiH1wecIGniJyM6?=
 =?us-ascii?Q?22gnoSB7C77tcMJXOEdJZiFyODKOiXlelMF/ZB7xwe3G+Bv69CylvXh1VVO7?=
 =?us-ascii?Q?un3bCIG/VtqmB9u5ItwjFFy1wiDo3HAr5t/Bpw2jS4DDajfJYuhueBbCbb8+?=
 =?us-ascii?Q?Q33kBG2l2efiEU/vnfEmJgHWG2g2TNXYaAZH8QP2u7gfvg7BQKa04ZcuEr8Q?=
 =?us-ascii?Q?FDeJ4KsDOkAs2s+oFIPFoIF4SDQdr1p9vuaAPVf5p2azGcsjJ03xmalvU8rB?=
 =?us-ascii?Q?P0WB2NdxFna7SxvJVuvdwCF8XIoHzyemzUef999F+nNGOirzNzUFhNbfPzAT?=
 =?us-ascii?Q?wfl1jSFwGNMrmLfjlBvwB+N5FdEONl7pgCnCUvWEt9J2wAS37UoseoKlrpze?=
 =?us-ascii?Q?P8lZNOHpBi1/RMYWsDxiYyDS09cFHqbfnGFhdmt9c1XiGIq6K8F/kPxbyu7t?=
 =?us-ascii?Q?OEd15QxW6CeFl3dGzHRXlsIBJiK8+50ysA6TErAZxo/XdttX1eCztcq9rMrz?=
 =?us-ascii?Q?dQbIIMK/dUeFTba+WOSszhvApJHPUuyYn757LXZSi4YFdBw+5h++RuNmHGY7?=
 =?us-ascii?Q?G6AfpO4vElVnFt/txSEdMBucN3RO/CG1UNHQUdEE9iHo86nxOOwpg+Uarzqi?=
 =?us-ascii?Q?Vd26S/lQO6cwIqKu1n29/PzEBB0M6Vs6AnIdsED5sxftWcIUwZL+PdzHu29h?=
 =?us-ascii?Q?+gWZpE2R9pmyFz2x/upSH7NDaOiTRYZx7EX721xuuKwrsRM6rgMGANvpDQNv?=
 =?us-ascii?Q?+SUBqV+XCyloSf5raoVMkX0GmmPCq+kK/bBh1eSb0UXnoLGOMC553U+6AsOx?=
 =?us-ascii?Q?v5N3uZkgufhFTfT64KveK7YJEwDVemviSIWPy4Y0Z71Vrm9obzIfjOainEzN?=
 =?us-ascii?Q?AxQ/zlNDONe+6RUirAmunHPVNxwjjvufcW/1Naesa2sKp1t3A8WSlUJKuCUG?=
 =?us-ascii?Q?1D8o5Lj3WJrDPM7sSUvTLKEdqw1wJhbjLA2z2cltUxB2P8e6NquO9yJE24rf?=
 =?us-ascii?Q?r56qsABFvifGVVS2KxnBjOoBujQePC0fgBILAUi0iJFd3bUVKxGVuiRFGN5G?=
 =?us-ascii?Q?GsXyyaJoGkqFqx+4EMwK2x48UeiT97HRyLauKINAo7e2C/gffMOQ2iWYFFkl?=
 =?us-ascii?Q?INnLQ82g99DBvRnjWKp+RH8kX1EqTPV5Leo9YigpdTQGMcmD0B/yifYAtOjf?=
 =?us-ascii?Q?cCSzwxyZcUbHpYk7mstDSSYUEAud4zBkd8q5zC5S/M79GL1Xqmo0S/Kxa1/p?=
 =?us-ascii?Q?eJxEf7OY3vbBddE4X7pSqPQIgpwLdQVM8y5DXVnRRpopZ6fOQI9fB4IIPOhN?=
 =?us-ascii?Q?3SoG8WBXZcRSKNwXE+9gYP0I9y40ux2sTTs1/wFzI7W54jHeo8y8edB9Jn1K?=
 =?us-ascii?Q?bcF1IW9+8E4NHHWwrNnhIWYc0vHAik2ustOctaCBc7VBA2yHe0ep6nMJ9zl8?=
 =?us-ascii?Q?29YvoLnY1sMQel1WiYg22mVFV0a5FnR1JsMlidzs6SYTomzkYruLpckxs6lz?=
 =?us-ascii?Q?H0U2X5ovvL5+cnZ1Iuf3YQeNEfv7PWNXiPIXj5P0r7CXjxT54i38dGvVX16j?=
 =?us-ascii?Q?iV9HFW+3XKrobKmk+y4Qw77V0m8gDn0GdhrM6m6rTP7ii9vu3Rp8cHZ7opYI?=
 =?us-ascii?Q?wzc9VK0nTg=3D=3D?=
X-Exchange-RoutingPolicyChecked: K3wlYCApG2NU6XMr8gRypxGnRa/UHgAG7EC1gXr+yjvK5eItscjp6vtPF7/dwJEISdCLSxp/JSJIPAI8jrBziY/HG5fZ7e3w9XpAYAbi4Fq7DkODtVFpR0k6RJD+uQSaJ7yk8/fNd8kye3EK9zky36zvD4Vr0aNRGOkAG5V4AEox6kmDRsE3WC1Lrl2aweyySYHU9D8wVhW9ePYSVgRJYeSZH0Jswt2d8NQlRmbeSpf9eqeBMCgRm8+DFQ7pYw6abTDR8UWVUGebZtPVO8JlVDIK9EQV8HkIFtX48me+Wy438bBqRfDeIjF5sDCns6sCbOHkwP0RY1d/BJZQnKtCMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca5c4ac-d481-4e22-fb99-08def2cbd000
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:30:31.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffwwee13J4GeWs1MQMjXA9xpNp1xW8zDzQaV4QNMUOzjPACo2wyGd/aA5WSHSiW4a99lwqR91GCfGipO3MTn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
X-OriginatorOrg: intel.com

On Fri, Jul 24, 2026 at 11:15:27AM -0700, Sean Christopherson wrote:
> On Fri, Jul 24, 2026, Ackerley Tng wrote:
> > Yan Zhao <yan.y.zhao@intel.com> writes:
> > 
> > > On Thu, Jul 23, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> > >> On Wed, Jul 22, 2026, Yan Zhao wrote:
> > >> > On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
> > >> > > > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
> > >> > > > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
> > >> > > > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
> > >> > > > convert may not be shared after the punch hole. Is it acceptable?
> > >> > > > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
> > >> > >
> > >> > > Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
> > >> > > hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
> > >> > > this implementation for x86:
> > >> > >
> > >> > > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > >> > > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > >> > > 				kvm_pfn_t nr_pages, int max_order)
> > >> > > 	{
> > >> > > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
> > >> > > 	}
> > >> > > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
> > >> > > 				bool to_private)
> > >> > > 	{
> > >> > > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > >> > > 		return 0;
> > >> > > 	}
> > >> > For TDX huge pages, if we want to trigger private huge page splitting before
> > >> > converting to shared, should we invoke the hooks like this?
> > >> >
> > >> > __kvm_gmem_set_attributes(to shared)
> > >> > 	|->kvm_arch_gmem_make_shared
> > >> > 		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
> > >> >
> > >> > But TDX needs kvm pointer, and splitting pages may fail.
> > >>
> > >> Ya, but those are very solvable problems.  They just don't need to be addressed
> > >> today, because SNP is the only user of the conversion APIs.
> > > Ok. I'm ok with the change for today's usages. My concern is regarding future
> > > TDX huge page support, as I am currently preparing TDX huge page v4. :)
> > >
> > > Sorry for the confusion -- I should have stated my intention more clearly.
> > >
> > > Previously, for TDX huge pages, you suggested introducing .gmem_convert() to
> > > trigger splitting before zapping S-EPT.
> > > With this new direction, should TDX huge pages instead leverage the
> > > .gmem_make_shared() op for that purpose?
> > >
> > > If so, should we introduce a CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP guard around the
> > > .gmem_make_shared() invocation to serve TDX's splitting purpose, in order to
> > > keep the two use cases (SNP and TDX) clearly separated?
> > >
> > 
> > Another thing we need to figure out is the ordering... You mentioned
> > that the S-EPT splitting can fail, and I remember you were suggesting
> > that we merge the S-EPTs back on error, something like that?
> > 
> > We'd have to figure out either a point-of-no-return, or some rollback
I think you were referring to the previous issue in hugetlb-based gmem, where
(a) splitting the backend huge folios was performed before (b) zapping secondary
MMU mappings. I previously addressed the issue in patch [1] by performing (b)
first, and then invoking S-EPT splitting before (b).

While Vishal noted in [3] that performing (a) before (b) could prevent
unnecessary zapping of private mappings, S-EPT splitting (the prezap phase) is
still better placed before (a) to avoid the need to rollback and merge backend
folios in the error path, given that S-EPT splitting may fail due to memory
allocation failure.

This is why I think splitting S-EPT deserves a separate .gmem_prezap() callback
rather than reusing .gmem_make_shared().

[1] https://github.com/intel-staging/tdx/commit/a8aedac2df44e29247773db3444bc65f7100daa1
[2] https://lore.kernel.org/all/20260106102250.25194-1-yan.y.zhao@intel.com/
[3] https://lore.kernel.org/all/CAGtprH-eEUzHDUB0CK2V162HHqvE8kT3bAacb6d3xDYJPwBiYA@mail.gmail.com/
> > mechanism anyway, so that kind of depends on conversions and the
> > guest_memfd hugepage series. Probably good to defer this discussion to
> > later, when we have more certainty of how it looks like. :)
> 
> +1.  Even with my series, I'm getting a wee bit too far into trying to predict
> the future.
Ok. Then I'll first have the TDX huge pages register to .gmem_prezap() (instead
of .gmem_convert() or .gmem_make_shared()).
We can discuss the naming later.

