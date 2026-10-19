Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAF3A6F00;
	Mon, 19 Oct 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391783; cv=fail; b=Ix3o0uPk/Bylganq/496t1T02oeSqxgGidf2IPSMMLPDsmTTqNkIcPA82FXZl54zLZLurZzzP7fYWjrdeDrgJ5288IQVjTToEsSrfVgcGVV+Hcb2DgOU44ET9jb4i2bEQg5vktKleDwMmqGxfNwp8tSuLyGETUH77P25pEvnccQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391783; c=relaxed/simple;
	bh=z7/pbKrMk4o4gEGSLRQ4r7Vz/WaWg+nFxdgkV+Ki3qQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTbjQLo3lDmGVq+ejNaQfKdcq8/X8pfqOiWrqJ6HaG66WKVb6+FYbe63jC1/EMkVl9HzvBstb3IkuQaTV4wESvvhj2WiAMWYPBCzQWByWSLpk5H+qL4Hwm3BaU310/We1hItSISo+p4j6LO6uU3Insx5SX6weDbdqYKbCxy/Vqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd+VFTXz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd+VFTXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792391782; x=1823927782;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=z7/pbKrMk4o4gEGSLRQ4r7Vz/WaWg+nFxdgkV+Ki3qQ=;
  b=Sd+VFTXz766apb+uPuxfAGLkbnG1nVn75N1qLihwkF9F9LpbfW279t56
   tqtbPKy5mlIu4YJahMj5WFlR8t6fDvzYQDYQTosYv3iAP86+eE4rJotjp
   9nyyMccC1fuweGZv16HKWhLmmRlEi68dY9agT5Pp22y36CqexARucjPlH
   8vhgj42XXJg26cILD0DJtWfdrPQLtCujsJyB5rOW3YRCvUa2oMlpvtK3a
   zc3K5jJuRfybG/ugYZv3WWXmuvGgt94t2emHX5wt44rSIp0QzdmKsBCSJ
   Z2JEtQVA9Ytz2V2DzOzAPOMPxjjj9QEr9Ot42rJcQr1vz6qKitEzjPtYj
   A==;
X-CSE-ConnectionGUID: 5Ia7A01MQ+ma3YcwERlJiA==
X-CSE-MsgGUID: JdhwOypQSYeDWD/VVPSUUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1067716"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1067716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 23:36:20 -0700
X-CSE-ConnectionGUID: qnWGoc1NQJKgEHgyHyxFhw==
X-CSE-MsgGUID: IAIjQvWmTAufx6Q011BpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2456108"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 23:36:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 23:36:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 23:36:19 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 23:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCNrLSPnBpszc5tp1HVoIHP4mHLt08PV9uG4ew6J+NN98TmQTAkIFX6ypxkNZ8cfsEHIdp9XS4TzFqXE9RddSp927/GcTu2fMqDUJdtYoFX1DdRdOYmEw1X6nR3w0FwqQU0zOeyckrloQTxeJO6Ugn2nj5gJlkOOEaaEbuSEffgeG3IOTjvEHO15Qyu354ffgxiAe2nM7S7/Rp8dHCje0q79wYvO1jh0ZXYKnXrU1R68Q84Kg14hBCoB0+DYtkMjHu0cv+InvhD6Yn0oxNd6y59IrfemWa58dotWTRHuc1107E/6fnUs2/Bu+kc2KOxH/FK3Whw3BxzZflhwAuLn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+95tgW0Ocvr519x2QuXDbz3pmr8xDHAGD/k0jbaI7M=;
 b=qk08auFcThgPRJuteB+Tg7Ax+p/d/X/QQcQzQueCEQXZ/FkijyLcMpoBWPr1I3Bwa7x5HKK4vw7OdSLa7Gcs4QV/WYFXabIaGRrOEuG5I6W4SM04uMLXXIlm1/G/ytIZmYJ6FMgP03GVsdbGUQYsiO7eit7BaMZPNfijQs6o/596o9xaigWnZ165mU+x6eJDn1jgcYVokLyq00YuqQV4N65X/RNsAb9pPOxxfj69lgBq4+yrNWR2++Qgq8I1SLKlqaYNmtljG7IATiGyZNEWhhhEQmLIVaGHkHuv/Dcsc99c3fAyT4q5t0htJHOI/gTArsh3urLbp61EIB2KQnbfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:36:12 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:36:11 +0000
Date: Mon, 19 Oct 2026 14:35:14 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Message-ID: <atW6Il1yN85IA1Wj@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090808.15484-1-yan.y.zhao@intel.com>
 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
 <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
 <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
 <896585225b67cb215db0ce66dece20ba8fbb919f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <896585225b67cb215db0ce66dece20ba8fbb919f.camel@intel.com>
X-ClientProxiedBy: KU0P306CA0101.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::6) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8a7739-4790-4248-b561-08df2dab43f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iZvR8lL10NpRd0NI7foeNKxi91PpLcPc3SfAxMl1Js5PkkMB3Tatsb8e7XcRMydE33BA8ZZw9jAuLMTTrequhsNE8Zx/SiTKwMNms6S6K1y8BbpOPSYNGraGMwwjpRKpVtFbSzSMVchbKshYxqHsEXUBwU4JzR1ZyGI1FrRJnGv2gQWl/opn1GNGLq7fN5yOd1LGOFCSPdtrkU4maUstgdGF1QkBmPc/AMpP8IT4XQ8crQY7ldbo03+YhAZnEeuVZk1vnvN88cYyCtJVVbfhftPA0RBlyVDcQGVl+QIVkPLvWEBMPB8jYIhhrRmg81rIt454leQ6PzPmOLEmp6e8nCyWhh64k1Ne2A0E1Agwghoz080P7SJ7GYTYHuzgzTQoMntwPD6Q1l4Dm9W7Oon/KZxBdqjxv7Dr9kRyYZZXB7VtlOHA542UuW4AqtOtlIkRFIVoZ0mu+vdvhcrh4F2t3DSIsBfVEFP+3j56V+6GM7PgrsKncx3RAIo3XXgIEUQv9378N8gw3+c8vNqrLv3BIsGJxClKoHSKlk+i/3/oZTvbZU6XqPUNrs1cH61sAm5nI+g5SmQp/t+nYnF1u+uOHdNoBqKRhOqZqcts5VZtegt/1mFBn2+7uCc3DUB0UU4cJcHMrZrjJv/d63Zaibdv9z5ZluUTCh/+HYGrUf+Pb5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQFGEKefJuWI/5joB/+5j7a7EnDRTAetGWMTiY+c1dDFJ24/zrENNOZQZJA/?=
 =?us-ascii?Q?zLAIZ7AA9mJqNGRplWvGWuej0NknP1DREfswhSMPaxJu+hfHjS28m7+F1DJ0?=
 =?us-ascii?Q?MJkvVKd1HekJua3KsK2jOYr6lJ/dfliFazi5LHsS8RnGcvKcYOMfOM/ciZwE?=
 =?us-ascii?Q?T/6Y4DkXhM2TFcqhnSHr2FmXBJ11du/hQSkH181S2ncKXydj43Og6OrhWWHZ?=
 =?us-ascii?Q?tn4HUWKxSSEUy2EJ9kyeKCMLPEwfxc1pPwEa91vO7nHXOQR02wLN7HDMTmoP?=
 =?us-ascii?Q?qutZs5nCIlJ1cNRr9jDWANkiNtpW3vERwfERoG/ECrJg7crU4iQKDjDrX2YG?=
 =?us-ascii?Q?QWlUEKCQ/MhrDhM3jiv23rN0W5s4+5NYuDbend0/dATfY5mncEOfXjKzERsA?=
 =?us-ascii?Q?cLs0J0kU9aBofxBG4o7l+p3QMssXgz7HmILU+/wyzKri2qXT2z4CW608qXmN?=
 =?us-ascii?Q?hbWW/QK9igusnOlhBV3JoAq9cxP0vJurc/aKpM0lf5T521+MRGEiLEvQiRTG?=
 =?us-ascii?Q?OCgG4CqZrOOFEh9xpBTiOAorlooYTbPRL9My6TN7GXNyEthYlbfR8Y9jahnS?=
 =?us-ascii?Q?eoGPnEIcR2bOY93jap+KptO3WLpIeNjKtuMazD+8vd61A+lLdqbSHmIBDa6h?=
 =?us-ascii?Q?WflSbBe4KV7FsF3ShxkocaChMMmzukr5X6rla11WE+iXOlANlzlgaEww5MVi?=
 =?us-ascii?Q?3GiI7QgnNgRgkFSwYjUsvmmmmoBiGAvHGACaYXNj/4FlqfPrQQjWhEDyVVCc?=
 =?us-ascii?Q?AGwSIjJMD4N2bRsFpCwX+I5LF4lDRJVbCwPC6R0FPFP6rghgAoMlXNXptThD?=
 =?us-ascii?Q?eb7JJ5jooj+CqWPVRx6EwdLRS4oEzoZgRK9X3HbA94T6DO0/dnOn64Fsr6Z1?=
 =?us-ascii?Q?e1Uwy6pvMNFM1A93dIBjKum2RBTMP4MCY92RFTtJeC3hRc+S/yo5Ci3++oFu?=
 =?us-ascii?Q?kK0YvqISX8UcaL6hvbB3NINyqpazJ777xpVqeftdVbw+A9SHbEoiEh/Df5Uf?=
 =?us-ascii?Q?zqHFUtHSZFq6jnrZkUlTkhjKWcnTsOA3hEVavZ1tatr40ClsG6Zy+iqu9IGt?=
 =?us-ascii?Q?z2gWVYjIh+krZBzOwFNQ/zo9rTE+DBnF7WTLFlTLScy2m7JpfHm4iJsGrnVj?=
 =?us-ascii?Q?vmPBe1BVxFrFio58E6pB3E7un2QMpmVNpUkeGeGYGQK6NYV6Sag/ha9GAMla?=
 =?us-ascii?Q?6YB9H36SZp2QmBUYH9vL7iqoKKX1ZfVjCLiBvJADtXCcHm9T+Ql/fWQDn7xz?=
 =?us-ascii?Q?zumJIxQG3o+in4gR1Bgi9ZvSB+4moPcWoToaxQNDKuUIUoGDA0MMD48HBLOt?=
 =?us-ascii?Q?gDz9MOWbBtlpNrpvGt6d8Uzi92nQJ3KpPXHKc7Nf9IiKS214XBRe1Z2oP+m+?=
 =?us-ascii?Q?ulkbQw8qQol9qO7nb78fLChroYy3m1C34Y713PzPtnb58xbBY7gosPV94LL+?=
 =?us-ascii?Q?BvOkIBpK9A4UESLqv+D09NskZY5nh5QDervVwE1B6TSUI1iEL77Nfyzc9/g3?=
 =?us-ascii?Q?lqT7hD6VqAkWrSkhM8owpIs1V0Mze6WPKFEpLBgIrRrxCIMZUGT8lQBOFpTa?=
 =?us-ascii?Q?4lJuEvX2q/W0Awa0xJZeU8fvlAZpbK53Draf7G/BPt/fE2/SHtwiP3N8nn/F?=
 =?us-ascii?Q?Dmm1hZtSRRatxxcn9jlBRyy1tcyUHELz7BZWqtgV2Tkf2vt58ReGu4qRTZPy?=
 =?us-ascii?Q?Kig8DXITG/2//wl9qFdTW0ZQdgPKPwYbOUnN9txT4AZ39nsuLl4g7ByudnEg?=
 =?us-ascii?Q?B5uVMrAS/A=3D=3D?=
X-Exchange-RoutingPolicyChecked: g04ofs0f2fWpqSWFxbhSl/v1FnY1B2mlcCNVgDfjdDykAsQHsyrSjHjfNyqxU3F7ZGko3GIJu+qeU4PitRs6sUobmN0S5af+Vbc6NSjQWDCitRA2QKIZ7AnvZ9uKiirXOF86thFeeET74Ig8FuxyCZ/FXcekn1k7vfrhUA1r27w4Ls2+1euUtUeQrecf6aPET0xWJa9m7GPsZ+LmFa+n96uIyw356PCSd8OpBaBExqYdWIazqiXo2Iw5npuk4NNWQyOKXFy3azDP12TisV1jbYL5g/uCXDGmcZgKShOrqre5uzRH8Ti1swbq/nk5c/Ios+ozxmD3ZK0JtPfZc9GDWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8a7739-4790-4248-b561-08df2dab43f2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:36:11.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XHAtOSeTw+CCL3h4vZ4tg0iRYf+J4p50dvgCU9+HsA0efQLFdrCSQGp+GREJu1gao6XcWRLaA6v+D3SHBMPFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 02:11:45AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-10-15 at 11:41 +0800, Yan Zhao wrote:
> > On Tue, Oct 13, 2026 at 07:18:15AM +0800, Edgecombe, Rick P wrote:
> > > On Sat, 2026-10-10 at 18:18 +0800, Yan Zhao wrote:
> > > > On Fri, Oct 02, 2026 at 07:02:40AM +0800, Edgecombe, Rick P wrote:
> > > > > On Mon, 2026-09-28 at 17:08 +0800, Yan Zhao wrote:
> > > > > > The TDX module uses PAMT to track metadata for every physical page (within
> > > > > > TDMR) across three levels: 1GB, 2MB, and 4KB. The VMM is responsible for
> > > > > > providing backing pages for the PAMT. Without Dynamic PAMT (DPAMT), all
> > > > > > PAMT backing pages are allocated statically at system boot time. With DPAMT
> > > > > > enabled, PAMT backing pages tracking physical pages at the 4KB level
> > > > > > (referred to as DPAMT pages) are dynamically installed and uninstalled at
> > > > > > runtime.
> > > > > > 
> > > > > > Currently, the VMM invokes tdx_pamt_get()/tdx_pamt_put() to install and
> > > > > > uninstall DPAMT pages under the assumption that all physical pages are
> > > > > > tracked at 4KB level.  However, when a guest page is mapped as a huge page
> > > > > > in the S-EPT, the TDX module tracks it directly at the huge page level,
> > > > > > meaning installation and uninstallation of DPAMT pages for huge pages is
> > > > > > neither needed nor applicable.
> > > > > > 
> > > > > > Add a "level" parameter to tdx_pamt_get()/tdx_pamt_put() so the helpers
> > > > > > can skip DPAMT page installation and uninstallation for huge pages.
> > > > > 
> > > > > I guess this means we need to make sure to get/put at the right level that the
> > > > > TDX module is using it as. For example in this implementation, if a huge page
> > > > > gets demoted, we can't call them like this:
> > > > > 1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
> > > > > 2. demote(huge_pfn)
> > > > > 3. tdx_pamt_put(huge_pfn, PG_LEVEL_2MB)
> > > > Actually, calling in this way is fine, since steps 1 & 3 are effectively no-ops.
> > > > However, we can't call them like below.
> > > 
> > > But step 2 incremented the refcounts. Then step 3 skips the decrement.
> > > So don't you need?
> > > 1. tdx_pamt_get(huge_pfn, PG_LEVEL_2MB)
> > > 2. demote(huge_pfn)
> > > 3. for (int i...) tdx_pamt_put(huge_pfn+i, PG_LEVEL_4KB);
> > Oh, what I mean is there's no need for tdx_sept_split_leaf_spte() to invoke
> > either 1 or 3. It only needs to invoke 2, though it doesn't break anything if
> > tdx_sept_split_leaf_spte() incorrectly invokes
> > tdx_pamt_{get/put}(huge_pfn, PG_LEVEL_2MB).
> > 
> > tdx_pamt_put(pfn, PG_LEVEL_4KB) for each 4K page is done in
> > tdx_sept_remove_leaf_spte().
> > 
> > See more in the below contract.
> > 
> > > > In DPAMT combined v5, Sean moved the level checking from KVM to
> > > > tdx_pamt_{get/put}() [2].
> > > > However, Sean's version introduced __tdx_pamt_{get/put}() for invocations where
> > > > 4KB size is enforced.
> > > > 
> > > > During our internal review, you said:
> > > > "Can you also justify why to have two functions instead of page LEVEL_4K in a
> > > > few places?"
> > > > 
> > > > So, compared to passing level to tdx_pamt_{get/put}() while introducing
> > > > __tdx_pamt_{get/put}() for the always-4KB invocations, I updated the patch to
> > > > drop __tdx_pamt_{get/put}(), having KVM pass 4KB directly in the always-4KB
> > > > invocations.
> > > > 
> > > > I'm actually ok with any of these approaches. It seems they all require the
> > > > caller to know about the right level size and whether to invoke PAMT get/put.
> > > 
> > > Yea. That is kind of the problem. The caller needs to understand the impact of
> > > the mapping level. The level arg isn't able wrap everything within the helpers.
> > > So how the get/put helpers handle it is internal details that caller needs to
> > > know. So there is abstraction leakage I think.
> > > 
> > > So probably the most important thing is that it is clear how to use it. Then
> > > whatever is the simplest code. It might be Kiryl's implementation. What do you
> > > think?
> > Hmm, I don't see checking level in KVM is better or simpler than passing the
> > mapping level to tdx_pamt_{get/put}(). KVM still needs to know
> > tdx_sept_split_leaf_spte() can't invoke tdx_pamt_get() for guest pages.
> > 
> > So, what about explaining the contract as a comment to tdx_pamt_{get/put}()?
> > That is:
> > 
> > (1) KVM needs to invoke tdx_pamt_get() before it maps a new page (guest page or
> >     page table page).
> > 
> >     So, KVM needs to invoke tdx_pamt_get() in tdx_sept_map_leaf_spte() for
> >     guest pages, and tdx_sept_map_nonleaf_spte() for page table pages, and
> >     tdx_sept_split_leaf_spte() needs to invoke tdx_pamt_get() for the page table
> >     page.
> >     However, tdx_sept_split_leaf_spte() doesn't need to invoke tdx_pamt_get()
> >     for the guest page since the page has already been mapped.
> > 
> > (2) KVM needs to invoke tdx_pamt_put() after it unmaps a page (guest page or page
> >     table page.
> > 
> >     So, KVM invokes tdx_pamt_put() in tdx_sept_remove_leaf_spte() and
> >     tdx_free_control_page() in tdx_sept_free_private_spt().
> >     It also needs to invoke tdx_pamt_put() when it fails to map a page.
> > 
> > With the contract, it seems to be simpler for KVM to pass the level to
> > tdx_pamt_{get/put}() ?
> > The dpamt refcount adjustment are invisible to KVM.
> > 
> > Do you think the contract is clear?
> 
> No, it doesn't seem clear. It's not clear which combination of args will update
> the refcount or mapping level for different scenarios. The above seems to just
> say what recipes will work, which only makes sense since you know all the
> internal details. It doesn't describe a clear contact.
> 
> I think it is like - Pamt has a level, and three operations manipulate it. The
> pamt level needs to match what TDX will map the page at.
> 
> The pamt get/put infra keeps refcounts for 4KB level page use. They may change
> the mapping level, but they always update the refcount which is an explicit 4KB
> level thing. So to me it makes much more sense if they stay 4KB level
> operations.
>
> Then the contract is simply:
> 
>    There are only two possible mapping levels: 2MB and 4KB. There is a refcount
>    for each 2MB aligned range. The mapping level will be 4KB when there is any
>    refcount for 2MB aligned range.
>    
>    tdx_pamt_get() increments the refcount
>    tdx_pamt_put() decrements the refcount
I think refcounts should not appear in the contract. What is meaningful to KVM
is not the refcount adjustment, but preparing and unpreparing PAMT pages for the
physical page KVM wants to install/uninstall.

Whenever KVM invokes tdx_pamt_get(), it wants to ensure DPAMT pages are
installed before installing a physical page; when KVM invokes tdx_pamt_put(), it
wants to ensure DPAMT pages can be torn down correctly after uninstalling a
physical page. So, perhaps a more accurate naming for
tdx_pamt_get()/tdx_pamt_put() would be tdx_pamt_prepare()/tdx_pamt_unprepare()?

The refcounts are internal implementation details of tdx_pamt_{get/put}() and
are hidden from KVM. It is tdx_pamt_{get/put}() that decides to use per-2MB
refcounts to track the invocation count, and ensures that PAMT pages are
(un)installed only once for each 2MB range.

The contract is therefore simple for KVM:
whenever KVM installs/uninstalls a physical page, invoke tdx_pamt_{get/put}()
and specify the physical range by providing the level.

>    tdh_mem_page_demote() increments the refcount for each 4KB page
Since tdh_mem_page_demote() only splits the mapping level of an already
installed physical page (without removing any physical page), KVM does not need
to invoke tdx_pamt_{get/put}() for the guest private page. As refcounts are
hidden from KVM, KVM is unaware of the underlying refcount adjustment for the
split huge page.

On the other hand, since tdh_mem_page_demote() will install a new page table
page, KVM needs to invoke tdx_pamt_get() at level 4KB to prepare for the new
page table page (which is 4KB) before invoking tdh_mem_page_demote().

>    The mapping level will be determined by the refcount after each operation is
>    complete.
> 
> If you want to pass the level, somehow it has to be clear how the refcount and
> mapping level will be adjusted for each combination of operations.
When a level is passed to tdx_pamt_{get/put}(), it indicates that KVM wants to
prepare/unprepare PAMT pages for a physical page at the specified level.
