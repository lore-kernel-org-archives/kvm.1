Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98C519914;
	Tue, 22 Sep 2026 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113044; cv=fail; b=blNv+OQECjr92yWb+7FWo1D8PKAsWORITA32F88aiGwkx20n5S5aqFZx/MS9oR01EFnfsFgh77fk/I9nludqx6pCQOAFuscNSoQhw4dQOtxKpvG2uUl/FkFHj48je15xohkE0d2wSB9xdEzGsq7kv/iAFC2C8uZxjKNBp8ql1Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113044; c=relaxed/simple;
	bh=2smY8qChSHOuQwzM6k078CefeC6di0G4QLKCzwdkXYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FoyXkGGsRioAB/B/DSishZFbSg0QrpnIDjVkxgKLrg+eHKr/ZSDOIUd4F5XRM1Se9JEgPmyjUSxMBPbEiNnvlpgGg4FvAiHKJVPa+Zh+BspGSFCCFVJJ5QOP9N1+4AsJmmv3ULUxLSWSLi6SIEetVEe0mKO1dIHv+61Y7n+8f7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1Ifg3p4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1Ifg3p4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790113039; x=1821649039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2smY8qChSHOuQwzM6k078CefeC6di0G4QLKCzwdkXYw=;
  b=G1Ifg3p4QMEqfrVLjseA/NEEe0LGSym9sohRhHaU37ZbBxQw+fHhA4md
   GrFs/kVmNIJ1k+feoogOBHJ5gav1y//re42fNm0D7uk3QExR7B/2loIOV
   hZWni2GDreQe6zQKxl+sFJ8MZXuQrHvjgZ+scduejxSVBIIePGroe1zy+
   KskIyWEzsmc1tLk1UZr1aCY2+jOVFvwXx5RHACBeJxJPfmv/uSDM8yfMp
   QWZMeJ+FgK8OBINZc+QfC6oXRduseWTF8tRD+iKukYgYxd4WKX+RuBjlA
   QuslveqXKtBMLEoQwGTyklRPLDbze+QBkNoPL6D+Qq+7p22THJ11YuulK
   g==;
X-CSE-ConnectionGUID: Uvoj+jEER3moxl9ob6yktw==
X-CSE-MsgGUID: O23rvo3mTfmHGGGpqrMhew==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101423001"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101423001"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:37:09 -0700
X-CSE-ConnectionGUID: lmTbLOUnT/us2KIp4iI6ZQ==
X-CSE-MsgGUID: qEcCovBST7eCqBA6Y2jqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="271891821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:37:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:37:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 14:37:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng194rlWweaggd7Em5VT/KK1LEif1LTb93u5QgT0nbqkXlG64Ch5SWDl6HGxuHHdli9q3LS+NW1T0P/amgFndXl6yc6RVt8UW7Ae3j+HsJ0vjg2dspLSbyoG4YWk+KUXj6bcAZSj84JVXjGCmv9SylsLCzsn/a4W9UYEttl/7kMrPqEPQJovB5vw62kQ2jgLK9t3qlkEdW34KNs5pvRldGNhEKHqjg/GBAZSB9tvnaLEtaDD/g5xAFGIDGqC93PJvECuJsEN8Pjm/H2L9loHEMmzBHoKTqmRp2ETy7XppHz92a2+ARgqk4uh1RFFGJC3SOSIM0RbsrC7frprZfTXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdxtQFDeMclCLxcpAZzFU4bFUX7fLooEsbQNoUkFjnc=;
 b=dlAaghwdjIT3nEiEMeV9IrV3QBhfKrunKpKGMjWraMutU6XphYg6g/huuJ40gK17Yr9nISXaXQlQ8slZN9IlKNXqUNcjEPPbaYyt7vAlVoXAcVnr1Ldo4/ZLiz/lW8AhiyYMddVxClICkhzSXeBViATiuy0iPpUQSZaMQhXrZOSMWJjUsEfixXsobdP8q7Or0iGTI5RsnYCkU2SrPDLf65agbPzGl9Sk44e1LO28GaF1ZzClHbugR6UYT62+9WW06bBRLPlm03KUv7ADUjpYU5IfkMyV6Dyuh9t/X1Uh2sEIMRpp83x0KcAAyMyA8VO6c0r/W+l4DQOrcocMETLTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS4PPF706C623D2.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 21:37:00 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:37:00 +0000
Date: Tue, 22 Sep 2026 14:36:57 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <arL0-a122DV5fCER@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-4-peter.fang@intel.com>
 <620e7e38-4287-431c-8285-575c84aa1f6a@intel.com>
 <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
 <arKtJxNMYHYSfXuO@intel.com>
 <1bb206f7-3951-4579-b3b2-dcdbe3ce06a9@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bb206f7-3951-4579-b3b2-dcdbe3ce06a9@intel.com>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS4PPF706C623D2:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d669f4-799a-47b7-593c-08df18f1a2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DMLn5RMX+xA1cm8KzAfpM8WeWr7RaOsHZAa3t+B975CfA90JWzPNMFbUVlpqHHWFGRUm/e4MSi/1GGeJUnzqg7sPfz0fJVcN3Nd+Z0aJpadGiQ6MeKrYmwSyjtDWb1bKc3Lc0fv1X0cpAo0+6Nbr8XQrwhhFHh2eWRwyCCuts9Mfv6ONI1R1fc/avympmZyGMLKNJIqZGC1pMeiq29WYmPnAMSuPc9Hm2G1bwdHBaiH5v52OFnxqD3p+xl7ZpN9dzVBZNBBqwvXtDvtdYNxF/xKjGN4aQSGXPuU8Q16z/ztFeTPpyFVauPqHoOkK5XHOkNig6jsjhrpxd7ZELAbjqKNQ97msTsHhfccM3k+6/vFzW5q/9kwN/Limql1sUJOWC0hXb3cNzvfJ0EjOZv4s31eTTPKQpq8uBZzJtU9SAurC2Mu2zzHnZpmggIdWbbHh031VCqyEhN6oN4nHGkgeWxzw6smbDdLA6Myk7c642nnLCNHWqyrL8UGMZ3dDyQ51H+lAWEdig+e/4CZp+TLgUp10UQO0I6c4qRocrkA7zJj+wsm2ixhCG0r4p2m+1G+MuHvhNw4u7qe4gJ7JGw9w4WIqk1Tl/Y76d3J39VA1Mudp7jHw6vx3ajw1+px0IL2Xmr0IAB9oBTXoiX0xLA8++0YGzE15dyJa4mpGVg4/JM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NVQJTrx8z8bI/+dtuHXtyOObCNTjNCgxByu9Mhy+t2MNGJ6Ell8Ge0Sz8v4k?=
 =?us-ascii?Q?hOyFtCDs7qjhgj/PER2aO9s1yMwOVtW7mud1GvVbzTcp9YHiqJaqoG/NJEoG?=
 =?us-ascii?Q?svpifykQMjXIYPfkOwCOezjIYakQ23E0uZeKJxOK/cU5CLqKPItFg5PN6cuv?=
 =?us-ascii?Q?zUcDBquydjEfnKSd1t+FBz4y4DuSYzKWWa6+G0ZO/cRUCYd5BPpa2/JWM+Ba?=
 =?us-ascii?Q?xl/Gg+p0JxY4379nGC2B8dIC4V+6nJdzzZWnjyrlbp6uTrqmFZ7TRRMK3ESp?=
 =?us-ascii?Q?R5aJjpQ8e4+9v+kA2YkTuzeYR+VtB6t2E8GOoHQw7qpTdeWxnKLuFFoULTzD?=
 =?us-ascii?Q?LqN7qLwLY3ElPbROehLCwJDPW+bUJ9jJQSaAKdz8KC5Hw12RSlAtRox3Qv6d?=
 =?us-ascii?Q?9EuLVnhTVQwW/kXGC63utNGpS7HQW31FdcZynMCc2GWFqMaWMA/TC46N/Ic2?=
 =?us-ascii?Q?YKeISvf7jG+5OaEqotQbsuDIODTSfaFEM6Ii5MtcNkSnLo33y+Nx/0VM36/6?=
 =?us-ascii?Q?HdTaJaxa2jpKjwDPY3h+YF0wiuf2t7CeuwATStvrVtbiEtwazWxQgiqgO0a9?=
 =?us-ascii?Q?KTjF0IJJtATmyCZv5lWlCkrIqu2grW5Zz7mtRlq9fuFzPfwKSPhGoPaSdXFl?=
 =?us-ascii?Q?eMAZvphiMFZ+XV9GtnmAwPodR+R99zTommhaICx0PjwYnRv7mmsyBYzsS2/x?=
 =?us-ascii?Q?dsHpIOyNmTElm9lnGSr4rFKy4C1Eb/z4FtKV02JsAtvA9q7AvQzABbrOtyk8?=
 =?us-ascii?Q?rwou6DJ1unO5/8JWXfUj0pxQY8AwrFOfJl4/VktgyldfVqPBCE5N/2aiCaGi?=
 =?us-ascii?Q?QSvnqhivbrLGRPpSzKVjD4TkKfrwsdpWDvZ6FIydihwwlwP9p/S8UUsHaO7/?=
 =?us-ascii?Q?Zt970Ptn/mLxn1gOkWk6kCNFnE050BicsyU8iyT9jT0yT9+CiaTvHhkOEk3Z?=
 =?us-ascii?Q?pOyAi5bd3s4gurFf2PJNqjO+2KJYOFyW0wJtCCO3jTuQdFwzxyXDs6JQ2Km+?=
 =?us-ascii?Q?tEPXiDcGuZNyS9Lfbzyuk4PYZYspJI/XXbZjTdf8v6K1J636yQkAXjzV/uL7?=
 =?us-ascii?Q?jAZLzWIUMEqksSk9ZYwlVYPxF//344yFljr7AnVAEC2MqHDxY3OlR2j+Ub4b?=
 =?us-ascii?Q?1RjXUQQ7YHOoDwlkZoZkkTchh8ygNQwI3umE7MndijiLBNPjbPfRQ8zXoJYW?=
 =?us-ascii?Q?l3tk4AUBx61rHQ+JEySVhuqiVlnJfHk54fQY8o2r7APobIbASUbOCLoZ6MyF?=
 =?us-ascii?Q?pIY+tkUL1icZj7ipAuYdzNSgM6qw2ti1X5YiY66K9Zr8ITO87UIkXaskmUVs?=
 =?us-ascii?Q?BvqSQr2UZDPC3VWl2YU/KdOf+foIoK22h3LrQCHN4MWXcSAV93nQyTW3dC/1?=
 =?us-ascii?Q?nQOqjrHDj08TLCIQF09FF+YIldgBwTU6NolcE59vFk2+VZKB/7AOj967Gi0C?=
 =?us-ascii?Q?tGOclKGmAWQynROwCQYumjaoo0aH9PchbkQfi21IsEESVc38ic7Oa4nuivOP?=
 =?us-ascii?Q?kdz/5siqV+xaY8hOTfq+vrkVveUbXrIcNDndtPPM4IyTkNfIoTaKoB/BWEzo?=
 =?us-ascii?Q?LAJdShnMB+RJQk/TU0K42jVmmAZdOOgVFYGIcxJQc7acA0GkHf+xOVB0f5e4?=
 =?us-ascii?Q?RGgwYhN8W1rVBwNjxsgx4kuLKlkQDPgudldNM36ZsFf8ilIBOa/BBsg8qJcl?=
 =?us-ascii?Q?leDb85T/4ylysEmoZ94Fg4KIDCC8IqykDjsX/tKUjWF+Eydg1GiYKN+8yO2g?=
 =?us-ascii?Q?ya47ZhLgSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3ww2nyu+bry4SxowdYRff1bpRpgHsvk7LarjQuRRpt+V6niKcGkUNVMz0JNM0oH9XB/IaX2T2dXJHvhj0Doe9jZCIBuLIPO3Ff7KoBzCL/Lug2jbkMvMTlzAvjVSLGQrfx6Hgcr7mQ/086YXLg/4NoY4jNeo+ry9ybseP30tn1cxLdrzYhmC2pTn/vBI8Aeyw6x7Q/kVqZYXaKZKmwVgFuYXa5RTvyTa3aKnczsDhnMIf1dGAukmJNnCvbmpME362C0nJbV3KkxCMlobohujfgOqucY3q1QLD+CeJzSXFqbhPzBioHxGLH4Gqnjzxi/DUkPdyBpTv4GqSjB90tv6sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d669f4-799a-47b7-593c-08df18f1a2b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 21:37:00.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rk2pWlD5ZqJcSgRta7lihGNIJdASgou5tuWupu78ULKLFyBa/vIYjx0KD9yDdv8a6/mDLAe+y5/OXqYc/9fIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF706C623D2
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 10:34:02AM -0700, Dave Hansen wrote:
> On 9/22/26 09:30, Peter Fang wrote:
> > The pointer to this buffer is "void *quote_data" which probably needs a
> > better name too.
> 
> Yes, please.
> 
> Also, does it really not have a type?

This exact issue was discussed in v3 [1]. Binbin had the same confusion.
I suggested changing it to "struct tdx_quote_buf *quote_buf". I think
that should work better overall.

I didn't include it in v4 because it needed to resolve a few
type-related wrinkles. I wasn't sure if it needed to be in this series.
I can certainly include it in the next version if you'd like.

[1] https://lore.kernel.org/all/8d20d04a-3503-42d5-8aa0-90b96aca2fe4@linux.intel.com/
