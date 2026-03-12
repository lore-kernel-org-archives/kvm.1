Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0435B63E;
	Thu, 12 Mar 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324605; cv=fail; b=NIVM49X3s5pnbOehLmGrL8rLm5crvob5ZTVjGJNhnBGd3qoIIog9P79N7XODneUwwAV7ipi+KeVUdw6v2oSUJB6dZSxPmDVEZGhqQI0esFc87q16WtOlyv7uwOBuXZ8j8Q/Aq5cwn9qkv4nGyp08Sp3uWOIDGLg8GyONsQyap3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324605; c=relaxed/simple;
	bh=uZWXXPyJNzK1ZLC6Xlx5i/8KugRe+m0zrKXi+YhiuNc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/wr62Q+8HlQ3FgSwO1k97RdPtmdIjmEUb5fdTSY/jFt4CDzRzgOOAVQqv2wZW0IaZnew6M6MG3Z0clb0jOhEnxukKc8NPH/uHQ+T4pBnEDtmken8+yX0aJsXezSANzSznxw9vdHDk620LgY3acodefkYruohqK+qRbw/FXxAMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3/U0gW9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3/U0gW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773324604; x=1804860604;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uZWXXPyJNzK1ZLC6Xlx5i/8KugRe+m0zrKXi+YhiuNc=;
  b=g3/U0gW9aRN+gva/R9BdTFtrOwRLnqX8+ffG1BWnOu81Q+bMM+vB4Kff
   draQxnNxeFj+w0GAkGktu53THcXHIaOghpVQrU/V1YCfb14MOiMu+ZwLk
   FGIpxDVeZsNPW+raO0r5y0a2pB1Do1qfUAzx95GanDjCEmJG8m8p/p/Fp
   54ltO7W8JjSVCbxx+LsPirKMpcOjZc/lIjpKXwfqr+AXSvaaLaydOeN1x
   5cGGUAVQ2GitNWfM5n2b+CsVWPUTSBY/seJ0BCj3WhEHvVygvc1TYt20L
   BUy+tCU93qTyNK83wfhlwSXfIpyDKLkh1BVB+LEQCWvUlPWqmE78cE2ce
   g==;
X-CSE-ConnectionGUID: BtpkZmi5T/m86BKoGPEuCw==
X-CSE-MsgGUID: H+OmLpeSSYK65eMl+jev/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74458441"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74458441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:10:04 -0700
X-CSE-ConnectionGUID: ag1iKQW5R5SKSj7g6AU5WQ==
X-CSE-MsgGUID: DN8LlOywSIiPSL5h65zPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="224974001"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:10:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:10:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 07:10:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 07:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5/nCkKIcLORRYME0u3CqCzkiJgoHlLyHanD2c9r6HeUQXa/3MzukvwlbFb0AZ9AXLbRtIJfhYEP1q48s+zyHmbZ05OBd/0FrUCO4zv1APMyKZyIyP/b/uREnrvrsXl+cpUCEwInIWj629rbMwKdMCJjCbVZbTXTVUJtdoq7q5xXrtH37pUoHcQvDp+YoLClpkgkIxByzNEXp2eZY/6wJZnYc741I5FoU1go5ubRf/Cvzu//xAMBpdVZp6S00fKFhMVHt67eHNKDxtCxthNUpmKPIV4UkciZ8lumeyI9gjimOf21kRKgagASzh6bGcFFhpy8SIGHRdFWzDDsWJW7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL09jymqnc8PRKSlUKZFI7K+qrEaJw5fxuAYLlN8xXw=;
 b=qMkVBhQRKmutxi/zZ6mUML3hZiSnOrW3yYSBpSmIP7rq1aRaIgtF362eih5fVOU/St3YNPzmst+zhgZBR+L1Xw9z/PscM+0UC57FwxBrsv9izqVw4GJeEfFqqdqp7NQa0D7h0Q9i4nj5wwBW/xQ4/PCGGfUeTC5b1ZikobBeewv4AjI2XM54MKvVxowq27OrZs/j+0nn0sPTPeiWm7xBurSPt8Y61gAwri/UW12t1VaCic6omsLhWjwVz1YAPiB/ricCdg//k+r3N4sf5mE20WyZ91zKh64bnizzRRkDGHpGD5mCasLizCPUALR1998lP23se31odKapI8+gXPePBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA3PR11MB9228.namprd11.prod.outlook.com (2603:10b6:208:57a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 14:09:44 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 14:09:42 +0000
Date: Thu, 12 Mar 2026 22:09:29 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny,
 Ira" <ira.weiny@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "sagis@google.com" <sagis@google.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Message-ID: <abLJGel27U8xuU6q@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-12-chao.gao@intel.com>
 <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA3PR11MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: a006aef5-1dc2-4e51-a30a-08de80410157
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RGmLtL6O5Vc2COEJGMaWtmGxpVYQo1RatpUD1FIo7YfP04neTbHsDWhpH0a+icisXxpHaWRHvlbBPnLAhvdj5Q/MaGHIQfmiizVH0iVRlcWBdqu2Rzi3EXI3t1S+pGAXxcqd1YUokB/1+pMnRwm3yNDjPghndPA//7kmeBX/dvK0MewhFEE0dv0FZfNJpFWRcCTdBCM7kwwb3LwVU1sBqjJBXScNc2ArRkqnZNTEfboE9izVFQxUXRBkIjuMcpTfOaohBZ0UJaM73X1w5Kk0iuKL/EJykuLeyqn8cNBSWl6JtKBioNFA2d/Bi6z/EzWyhEaQBkhQHm5OzeUXlNCljGxPGJFRa5ZZmisxq4ApUf1tC5iBAiFRyPDO9vop02H3WW5QLx++1W76HjjdBgtNFefxXjDi6VMy0AFFPQhFTX9XmYvWTlZjMQ6qLcM7r+WE0aE0C7ZE+ToD+FPKk1jJCa20eCH+0T0nXiKRvcOEA0LRV0R9liHzWsXXRTzOPwU613neJwEKMMebqEgVWJD6/UDzGSzBOaE9UDBYNmyxqO6jbiDPzrHXx1JOaZsJmLHPsE+ubmnfIlT9J3jbx0rRuPJWpG4nIr3qCtYWAF0ioXz0e73gKqpfY7I3J2Y0QDparf9MKSOBEzL5xLB+0tpt7uy9mszxAC6JSxVdz+a8pxKvjmrsq00wz5gg2+bhMvZk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3iwDsrhmFdtHZGPEOViP8jObiYTJGcus+8RPpaMCPW80XRPMnzdza2LoHF?=
 =?iso-8859-1?Q?9EJvjRvugdBDoXBrjTrF25i55yCi0Ked24KOiyDt37MfMQQvofGfWVxG+O?=
 =?iso-8859-1?Q?0P+QBIR4i+nO4Kv6Gx2gBKFt79sd+iqk7/1wsG3PmxPA8YSxQVdZi/uYwN?=
 =?iso-8859-1?Q?Q14X0QantDObNy5E7+SOrFG+TPr/daKkDmJd+bLCWW7BEcibGJM7d8LSDC?=
 =?iso-8859-1?Q?OcOKsvefjb6YqRuPXQy45+k9k130WMg88PsOqWmF9kLkRmpA4/2dYBrUkf?=
 =?iso-8859-1?Q?aG8AFj1SY6oNVD6SnUI8KXc+p1KBQL8WYhs8wn/xAmu3xZLtwyjEe3D+oh?=
 =?iso-8859-1?Q?8HW5MaTxYI9anROijCDPU1a6oUQwgntszW5Q0/ooRL4ykXgo73yECS28mq?=
 =?iso-8859-1?Q?JSVlQDpj2kuJizqAsSlIuPqJlZvaM2BeNLt+tV3x4RwPB+eHGYsskSPKSJ?=
 =?iso-8859-1?Q?CwPoTGf90we8fvrm82ywXNxMnHlQzTKPer2ZqKgK35yPal/rCskLKPwIp6?=
 =?iso-8859-1?Q?3eUvm4Dt1AhmCvX3srTuM2zYpOuz+ci1i1SEYEKT3TpmEL1LN9fpf9HG6i?=
 =?iso-8859-1?Q?FsE5IqhgPr5ZD03Bej8Msb9IEXU10XQB0ze9CbVGBbRu3Yoo2fHgVeL0KA?=
 =?iso-8859-1?Q?Ef8p60vUtktA92TtTrtHTDPATXrLtbNLHMxqmuzQlyu2IBNScl7VLRwV9X?=
 =?iso-8859-1?Q?MLQu5pnMJP4sYN6lDb1RUCQSpmYiWKuwYpgVDqoFfZGjiZnsy4HzGkcyRc?=
 =?iso-8859-1?Q?zMjhbwtV+gH9EuBq1gD7mETlaoK2Fry+yzD6DdJ0qnbrzg83KbBvPlcGBw?=
 =?iso-8859-1?Q?MMfHJy6QFi3ScFj0EIHeBcnHo+5t4r9Uko8MfB5+IlLPcej5CMaQBec8JS?=
 =?iso-8859-1?Q?C+c+w+3iDI4Zp+vdZATNszEY8mNddIiljJeVzbWXMlnpbkvRBzAv9PK8Md?=
 =?iso-8859-1?Q?R6lxq3sqZCt6b4MRvm/cuK+v42qDQuc+SoGDueaS7Ar3/DAIWoReXdxgL0?=
 =?iso-8859-1?Q?tJY5rErjScLt3LJ4YarXnBhbj1fkW6IdYSJo8mkOofT5mepFqYy5uQp2lA?=
 =?iso-8859-1?Q?oL5vYrQQ2S39hEmjv1K+/LgpQpiUONITBRNUM/mzjTFw+BMvudbCNWcr6l?=
 =?iso-8859-1?Q?YF8mhNQTMwxfyrQ+ZqhkScNqXoCO33VZlpedo22jGgZ/QNSIbf4jQK3uYN?=
 =?iso-8859-1?Q?tme/JK73rz+4C4Yw8kYvAjSMAqOO5Abyxmbz0dyfs7cvPHTzst9kalqIiA?=
 =?iso-8859-1?Q?sQndk2g3Vps8wmm/uAkdwzlFGP5ar0C5TCglgp2W5r+L0HQgA28JiUFs1u?=
 =?iso-8859-1?Q?Sjz63j/w9hfmSdhn6FQsCmGoyQqJVBuCMOtYvb/54Ol1JKlIob1nK9rGNE?=
 =?iso-8859-1?Q?I2oau8i4azTyidGAx/bufukbrHt2WdLs8lMhtYuNWVz1FZEY6zxoUY8zpE?=
 =?iso-8859-1?Q?EA0jbJtBwqDeIxpz+9rtQiAp61JEFcKNb/0MHXGTj/BlUsx4wxn35qpJse?=
 =?iso-8859-1?Q?sidxrluUVhRBR+VfrbNPfetC1B3yIq6vUxjil21sL1s/8oTx9r0zigfeZL?=
 =?iso-8859-1?Q?6k9DIQdLdoa9pixz4SCQOtPxJoeiZPpkYVa6av4DM30r1GPy4WrvoeKpuX?=
 =?iso-8859-1?Q?kFANAzHteVSNnJyFg2Csm8wHhw0xaoB0kY0BDo4Oe9ALHVkJPwUyYVnT45?=
 =?iso-8859-1?Q?8X/LZzoREw0T9oqQ6mBI1BVdjTVS4Hd0p6KcHmZz+ZO8eIEpI/ONCyUb5e?=
 =?iso-8859-1?Q?PZfxsW4L8krHrq8Fv5yYnvmlc/XK9QYN7W9pJX1LdWOR2xqNnFmuZFl6yy?=
 =?iso-8859-1?Q?PRhywGo9vQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: mvtWWPWdad61Qle08AqxeFXPlNY8SiCjHYmxJyzCy0uZQnYKPl44ceARpW2ili0whoOciiWKSBKpfse+z31chVLxuqPZdJilINiJXM5Hsy/upYr1oVDNuBGbIdwrEM/gmM4oIWAYNaJcsIesGmxPpdqDvJCZ+l9n6mOvE3H89JHWVyzWKpR6RMKfWz/fYSBoaZNsgXZWUJ8VtYYkeRuH5BNoNzLwtWdjreFRgReG8zTmf9ltn0BH7YrQxqK5ouQbI1t91nm17OTeg7O4UsYXyRaKS0ek5ZSoSHWbFcs93Hq+mksk329rrmGhtHOoxzLw2+js6IJZ6skoAcjLrR5UBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a006aef5-1dc2-4e51-a30a-08de80410157
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:09:41.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiJdBPdSfg7MLJ+kWTz36DpQY23FN/k8QNnPLkb/aW9/u3IEa9U9D4UY0bP0frdXZ/djuOh11nBtGytMU7P6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9228
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 10:00:20AM +0800, Edgecombe, Rick P wrote:
>On Thu, 2026-02-12 at 06:35 -0800, Chao Gao wrote:
>> TDX Module updates require careful synchronization with other TDX
>> operations on the host. During updates, only update-related SEAMCALLs are
>> permitted; all other SEAMCALLs must be blocked.
>> 
>> However, SEAMCALLs can be invoked from different contexts (normal and IRQ
>> context) and run in parallel across CPUs. And, all TD vCPUs must remain
>> out of guest mode during updates.
>> 
>
>Above it says only update-related SEAMCALLs are permitted. Does that not already
>exclude SEAMCALLs that might allow entering the TD?

Those SEAMCALLs would return errors, and TDs would be killed if those errors
aren't handled properly.

One may argue that we can handle errors and retry after updates. But this just
provides a new form of synchronization, which is not as clean as the
well-defined synchronization provided by the kernel.

>
>>  No single lock primitive can satisfy
>> all these synchronization requirements, so stop_machine() is used as the
>> only well-understood mechanism that can meet them all.
>> 
>> The TDX Module update process consists of several steps as described in
>> Intel® Trust Domain Extensions (Intel® TDX) Module Base Architecture
>> Specification, Revision 348549-007, Chapter 4.5 "TD-Preserving TDX Module
>> Update"
>> 
>>   - shut down the old module
>>   - install the new module
>>   - global and per-CPU initialization
>>   - restore state information
>> 
>> Some steps must execute on a single CPU, others must run serially across
>> all CPUs, and some can run concurrently on all CPUs. There are also
>> ordering requirements between steps, so all CPUs must work in a step-locked
>> manner.
>
>Does the fact that they can run on other CPUs add any synchronization
>requirements? If not I'd leave it off.

I'm not sure I understand the concern.

Lockstep synchronization is needed specifically because we have both multiple
CPUs and multiple steps.

If updates only required a single CPU, stop_machine() would be sufficient.

>
>> 
>> In summary, TDX Module updates create two requirements:
>
>The stop_machine() part seems more like a solution then a requirement.
>
>> 
>> 1. The entire update process must use stop_machine() to synchronize with
>>    other TDX workloads
>> 2. Update steps must be performed in a step-locked manner
>> 
>> To prepare for implementing concrete TDX Module update steps, establish
>> the framework by mimicking multi_cpu_stop(), which is a good example of
>> performing a multi-step task in step-locked manner.
>> 
>
>Offline Chao pointed that Paul suggested this after considering refactoring out
>the common code. I think it might still be worth mentioning why you can't use
>multi_cpu_stop() directly. I guess there are some differences. what are they.

To be clear, Paul didn't actually suggest this approach. His feedback indicated
he wasn't concerned about duplicating some of multi_cpu_stop()'s code, i.e., no
need to refactor out some common code.

https://lore.kernel.org/all/a7affba9-0cea-4493-b868-392158b59d83@paulmck-laptop/#t

We can't use multi_cpu_stop() directly because it only provides lockstep
execution for its own infrastructure, not for the function it runs. If we
passed a function that performs steps A, B, and C to multi_cpu_stop(), there's
no guarantee that all CPUs complete step A before any CPU begins step B.

>
>>  Specifically, use a
>> global state machine to control each CPU's work and require all CPUs to
>> acknowledge completion before proceeding to the next step.
>
>Maybe add a bit more about the reasoning for requiring the other steps to ack.
>Tie it back to the lockstep part.
>

Ok. How about:

Specifically, add a global state machine where each state represents a step in
the above update flow. The state advances only after all CPUs acknowledge
completing their work in the current state. This acknowledgment mechanism is
what ensures lockstep execution.

<snip>

>> +static int do_seamldr_install_module(void *params)
>> +{
>> +	enum tdp_state newstate, curstate = TDP_START;
>> +	int ret = 0;
>> +
>> +	do {
>> +		/* Chill out and re-read tdp_data */
>> +		cpu_relax();
>> +		newstate = READ_ONCE(tdp_data.state);
>> +
>> +		if (newstate != curstate) {
>> +			curstate = newstate;
>> +			switch (curstate) {
>
>Maybe a little comment here like "todo add the steps".

Sure.
