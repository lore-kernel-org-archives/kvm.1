Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E434F46F;
	Fri,  8 May 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263591; cv=fail; b=hCD0mrxvvVbD83S6zUYyG44Dw8hESROQYx9kQWDeUXchueG3W8PTkTgAnrNoC6+anR5FcwsKUmhae4ZbYWuMDxZRt9E0wSOFWpo/6cxV1wjYWZNvHnxG2fqKi61LNQ/gwHWwZakDZAAzWjLeuhP3fYIYMpUDyVz+pH+KFEnie9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263591; c=relaxed/simple;
	bh=8TaMnd3N+dfHzylJrxmtownGdOHCDZ001sSBqEC8LBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OO19I/inoTe5Gh7f7WMBGM9NcWW/3zevMo8yT+RuhKz+K/Kw2UXKf6ru1jLiv+VJIcxRhdsfX73vZi9uM3JK1eCgMRer2XVCHaRi9cYHIvghNFfiAAoSRnqnFNThcYItL3SVuPAHwWGLnq7h0tcFvoo9r0TTNapAfKEY32C8ELw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJiByJmw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJiByJmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778263590; x=1809799590;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8TaMnd3N+dfHzylJrxmtownGdOHCDZ001sSBqEC8LBs=;
  b=FJiByJmwU680d4V08HXurbvSg5MFc8Sf31XxOGfqZJuASJudqc8EP5M5
   6wrWTQP3b8GIK31Izy3qTYHvyF60FzVxdvBg2kBKlbO8ml7tXo/A8wKic
   QrTn4O9kYjl4qbgUHh4XTb3a4M+DBzcCB44av/YW3hJKOhxJ3tRS4b+Pf
   89Kdml4IwzD33wi7Oi10L7PpFOlQCdS71Jb6S1EPRfKVdwkL5BAXpk00X
   fJMuVW2WGiupwVwtiPYMNLaz8ER7IiTKvgyuRCrl0ZEIOyHAgvunV/JCJ
   JeRWxudbCo2zhFPx2j+ida1eZixE3A7+Tj3+10W25vFGYJwISqEn6h4gZ
   Q==;
X-CSE-ConnectionGUID: Y8JsVPiaR8GBYG62yHSJaA==
X-CSE-MsgGUID: HokuQ9cHSZakHHChwwkUlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79345029"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79345029"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 11:06:29 -0700
X-CSE-ConnectionGUID: 0xoGELjnRh+l81DF9GmPwA==
X-CSE-MsgGUID: Zcur8qRlQYCwVLST5RM0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="233770366"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 11:06:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 11:06:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 11:06:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 11:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS79GsOGq5J8bOw9G69sPPiMhLCKzx/VRvURqI9ZENfvSdtBDCtexDV9I0ucG6wTFZyk5lXnBWfFjL1kQ4ZyhdW+cEOCXT8ZrrexQHxzw8MhfqcJLeKIUgRtevDyaTmRc/ME3gyNoQgzVz/BfhWNg/gfzPZTWlXwy3ZewT5fPS84c7df/uJXAs1ltMHvyHQk9ljpowm+h3B7qOfmwljZrdu9ZNhWOx8hdyBYyzzeLS+qxFuUrHCVC0E2BpPpvf6BQRMWG0DdYbbvKEGhKWQKyCymaUvg3Wtf5WIYmhAXwSBif7zIPDHd/PJE7m3ZVadHx0vGEldvlqHOp2NAysXRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AmtJLsKduCtPxlcGHkvs7ffXiff/da/xzzqy9qza3U=;
 b=NBAGUcX0sufc04I2PZLvzEW5zC2i3gx4RWU1GjJH+6tOmRjqUyvswhl82YHZnZCQYGafmAPOGvlpP+L/urNbue7LaVnUeizvGnf1g6TkASbYq8L0Am7CCJDfgJuHIxhsQReQIgGLrNBl2DG9WwmQB3dZZHFQKOfjaUYy3GhJefGHcl/U/bstpJlC03nhrPpqACabEjcy4DtWXbadld28ip6yG0BhpzSj55pXBQ7uJh2J38YKrdVSsFx/cp3lX9jljCvxhuSFnXNEndffkig6oGRiHonJNQmccsJiZed4hpjyEVCI5qgNwa8mha3vXJLEDAy5MDioZbt3abpEOG0LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:06:24 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:06:23 +0000
Date: Fri, 8 May 2026 20:06:15 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <af4lUnK3yeFOLG_q@wieczorr-mobl1.localdomain>
References: <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
 <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
 <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
 <afyXgQdzdTr_JNXf@wieczorr-mobl1.localdomain>
 <e2c20e1773b9579ea4cea3b26d7eec02671757f8.camel@infradead.org>
 <af3x4nukic9smHdX@wieczorr-mobl1.localdomain>
 <9de74d88b3c1a2693a4758c023e97826d561c133.camel@infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9de74d88b3c1a2693a4758c023e97826d561c133.camel@infradead.org>
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|CO1PR11MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 782aec72-3aa5-4272-d779-08dead2c83d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1VNpWr67h408Ps8JYOWIlOyP5Xs3eOnS35l8JYCaiciXCHfPOqc2W5iQGuaqFY3E4D5PSmZlA5oS2ziYsw0zg02+T7uxO9SU5n4Sc8mlsfdChzeFy/t2fSPXW8kUAVTxxLcFlNWaGEpj0tsBGWy7vPRiini/aIH3DSH6/ddo15XJjvYC7hrlSMMOdsNPs8Rv3OPQyN6UWGeD+L7hZuzPJcE8o0OhJ5AOhCDmnKZ7rCOdDnAj5TJ4GoLCcaUDMLz2vOfVZ+5x3O1l8ZGGYmk11Ab2uvatm4Jd9bmLHZupBbhuCOndP4tFVcOZxPwz6TIaKU0Q9MgNgG4JQ7geB9kM6SLNMfofMXV9WESdKbANAsqb5fKvisx1qEPAc0ZtCCkotkNObIpI/rE4Rc69pgb175Xgm49qYQxJn1X9OmbuDUSiKfJAnMRj9ducvRebdAaq3lbNRl0q9CU2gUXSipzn/c2Qa8Xh/1fpgbwna+11hC46DTkd8conLGaSKhnwc2R0Ru1UYsmS8oQf/6PcqjOOqF8/VuubgwK+9zge5twX+BxIjS6Tx1JmlAIAqWwPTPffuHPfVqc3mWQGk1fv62So6lfO9Id8+ebM4L/97cJuyrSR4J7+2g6NlyaByRwuoAPkQLgoa5fHxBOH7Vr4wJGpNABVzFQGpLtkc92zvCT9ikh/aube4pyiyCIQ8Dg0FiVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZJqTgrYV+AthGvW8hG94gwnCHcvzi6zgTALkeJ51thllfYt44AmLsRjU2o?=
 =?iso-8859-1?Q?rD+Qtio+cB83SBXNuV8Tm4Qji1OMZ8cpNczkbDfo3GIa3zReR36Ab2aMN9?=
 =?iso-8859-1?Q?Use8sIPjUDHmv7I/aTNuyVVAiMcikuQBPb+WKKzuRSF9tVIIxwUorUjAXS?=
 =?iso-8859-1?Q?HSJD6kOaLDj9uON0/9KTgFLqS007eCqhHQTW4fVqodjgHuhhGFl3HZJbaU?=
 =?iso-8859-1?Q?gF8f8cZ3S7TE7pJSqE7CCxL0WhXgSL3Dq7+3+wl7JVKHGtpW31AtphPiHV?=
 =?iso-8859-1?Q?0HF3WJTWkFAMwZYlLfmOAgiY+tpeGEesi+8H9u3T78djg7G+ErV1hIcHJO?=
 =?iso-8859-1?Q?yAZolb3Y1c7L7EOaxiAucK6aNqye1LK+U/P4PyNKZZLd0B4e9qyfWAuh7z?=
 =?iso-8859-1?Q?QSyYPOeg//7yqF0NNpQdcNsk105N9r4PmlC+2cMcwRmPUF2seR9tEUu7gh?=
 =?iso-8859-1?Q?tTxwuOETrhlqEuMVeCXxkQO8M61qrfgpeNKMjqsnJiOttumJQ3Y/vBsN6K?=
 =?iso-8859-1?Q?JqQXkScc0EbtKNKk4Prn+mkf+5ue3Hd+cUrWji99ajHM8ivdjUjXW9Fikq?=
 =?iso-8859-1?Q?Ug2ZvdrnUvs9bglo/v75TJn2da75ha1QurSJJhNbYIr99vKlWvXuZrwnuy?=
 =?iso-8859-1?Q?/x5XUWmri5T4Zwng4h7SmAYux18g0jWFzxkC90AKHPbApFuv3Q8RflRe4f?=
 =?iso-8859-1?Q?km2nCcTv9u/6GnZguim4H7snYzoZ0XoXZJM4vOXN/kO1/kDtbyMvT70J2U?=
 =?iso-8859-1?Q?Qy6eV+LFNT/Ldb+zU+iX6nwCp5odRqc1sXP1WKKF7KfQuNBpq+VS7/1KVN?=
 =?iso-8859-1?Q?SAJv125nCLsNj2eVOeUBevndFknkyMf0yTZwQ+fCP8dZpkWdpq3i43Rf5+?=
 =?iso-8859-1?Q?nzt+PJQ6AKc9L/t13ceCDxdcEOaZtxwoL2+4ENNgXS31Yx8NKv1Er66vUv?=
 =?iso-8859-1?Q?MTgEzEBVzay+XbSZY7c9+3VdCy+CRslF9LjmSbOy+/a9YJfG95slnTtPFG?=
 =?iso-8859-1?Q?c6m0X+mv2qv7r9scKCrwPPh4L0soxAcW1uCGgvpR6PBE3Ch8yZLR/E2E3q?=
 =?iso-8859-1?Q?KQRHuQzLMvm1KS/ou19OKaPEuuWh9hUY/ydBDmXe4R03W9dBhWYypNlqSA?=
 =?iso-8859-1?Q?Fb63tiQvWFMNaazRwTyNL/VUTqQgCrvJsE/kKjl1vJZmZzwsDDQCVgf6Gl?=
 =?iso-8859-1?Q?P+yueG4ujc289cqSVCDz1eITMEo/odgM0lCir5/Dhag03VanrHF4RWjGbr?=
 =?iso-8859-1?Q?b3CMzaYiV2Pw4U2QbbjMPvSuHUvVK0UspWNwUAYCunijriI8lKAHBz6gg9?=
 =?iso-8859-1?Q?8tqiByer4fAi72s0gHPhejJjaP0VhkbOzr3D/N5RwGwo9quGbPGUE2Bk8z?=
 =?iso-8859-1?Q?ikfvNQUF6k3TPcpXODJwdhylphhOoPqjMh9KvW7qUSVb3R7CO+Gir6WuQe?=
 =?iso-8859-1?Q?gRbDNM1S2RldlxLEmBh4UiSAe4uuKUUbNfZ3QjZNXVYVoUL0zwE0FbcJFU?=
 =?iso-8859-1?Q?dAlUNh9kxAz+j6To962U8AYtN8IWLEj+EVkR/vhF7uPo8qfdZVMA7CMwmd?=
 =?iso-8859-1?Q?76k8My594MAAkYcoqsZU8UFEtpAL9nX/NsNrq42Aw4KFZwgt09NPfGI/3m?=
 =?iso-8859-1?Q?7RwPHg5y0d2vhtaI/5EtexqGphEnWNCPsr9O3NmYQhcokJgrHkZ8wq7Qmk?=
 =?iso-8859-1?Q?DKderzR0nHRQNU6srOt6Cs0Ohd8QRKK3ZjEyUa7V12/I78MSHsqh+XxRSD?=
 =?iso-8859-1?Q?9ohyUSv741NY/tX9/Q9I+q0gF9d6mbpEkFXoFI8EOetRZVsiyyB1Nlf1xu?=
 =?iso-8859-1?Q?LF/+dHAHUfgLQXoVUTsQqGjWCmVCR0zXZmu0VjhOPsRX3mlaTVE7?=
X-Exchange-RoutingPolicyChecked: YlYQ/+mveDUAg1Y8Pn2ZsmllDjiCsIeOqE6d0Rc5a/LvuXZ0If7YqFbkHvAKkgKA5HbyM4qD3VpSw6tWE0i1RbXT45Mijio7j20JQ3cL3SMcuj9HfZA7UuLJI7et0pYv9fyBovMnYHxQBdaHHJSlfrMm6YRUWjjQQmmM19C3eHEGHMfgyjzeXENUdfNEsj/h+RFX7Im8aB8NXGAkgg9Z1xguBM61vRrZMfVrplaslfp8mxjMZj1VOe2EDnqB9CdMkRnSXpReV510jGyOGLjom9VNBzeoyWbroPrzCQi3Kr+BQo/06N+EvGfnzUVW1oEKNx2lT6qzF3sN9kLgV7FzCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 782aec72-3aa5-4272-d779-08dead2c83d7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:06:23.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqWlKq28t+oNQwJZ0YSKwoYiyJTPjz0aWmMM0ZLKrqXjLlLtsVtgAEKI/BlBsEVWSRXREywtGVI/9A9PcL4Gap/CVd/mPng2N3V9iqxwe+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com

On 2026-05-08 at 15:46:41 +0100, David Woodhouse wrote:
>On Fri, 2026-05-08 at 16:25 +0200, Maciej Wieczor-Retman wrote:
>> 
>> Just tested it and now it works fine :)
>
>Great, thanks. Including the __attribute__((used)) part?

Yeah, I didn't have to modify anything aside from commenting out the ICEBP part
for the test to pass.

>> (aside from the ICEBP thing of course but that's on the kernel side)
>
>Well yes, that was kind of the point in generating the selftest.
>
>I don't have access to hardware right now, but I can do test driven
>development by proxy... :)

Anytime :b

-- 
Kind regards
Maciej Wieczór-Retman
