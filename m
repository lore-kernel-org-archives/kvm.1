Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2B49CF3E;
	Fri,  9 Oct 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538468; cv=fail; b=qiETW9P795sK3ru9LyjCByY3WUwcJmG+nruNlmHo0CfpnjsnTkjelNVxOkkiv/umqfpMTBsAZQCncxvoO2ogTcqSoY6uH2SHvOb0Ghue0/+Exf2KYKjd4NuQKpoQVEcJcHH1IEdXbFDGZ/pSR2mzIypo4850Ss+0RX5aycIKAl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538468; c=relaxed/simple;
	bh=RSmCLyd4a4h9Hj8b+ucOK7yE6wJnYw0MhVWqZqTYoJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mqgiPcc2oqA7gvgHHc6NLkC4sa/7JFMsYFVl9weM7exuBUWncLXtBP9+AAxDBGYAIH2oh/g2LXL/8M4dQnNY5tOiHAEa+ENY6WPWGbwE12vUTFb/3l5MU9daeWrmBqw25cUWEhSyxoTaPFxEkIkw2RyH7txMihFnPgerc2NG2xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4Ve5Ize; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4Ve5Ize"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791538463; x=1823074463;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=RSmCLyd4a4h9Hj8b+ucOK7yE6wJnYw0MhVWqZqTYoJ4=;
  b=g4Ve5Izez/zRKQ/Zcydc+HQmLLkpziT5NLoLyV8GbOt+VaHsbk7ckZXg
   XZNFiErHuxseWGAmfpawlNrZRkZaB/Vx6OLwVGrI0ccMvDKBEKeVHjWAl
   ZkuNiERsbRVoKoTOhzzI5py+2fiPfOiZoJn8ePm8bffLt7N7R/iQ2YY7Y
   4+76Z4VqdBCHko62Ax8gWBBC3WWYFe6dRuQIbWAPL9POil7kvjBHHRbVJ
   /lm9X+h+cMwt2D7h4CWhH5j3SLUN+1xAjdp7QYlf/3yDKnnStpv2tJ0Iv
   YODG//avJk02wbdqx/vRIEwoDRbhRTDmKujRtitAj77+lQ6KZz9NRzjCy
   w==;
X-CSE-ConnectionGUID: YJkU9mavRhq3onC9uaOujQ==
X-CSE-MsgGUID: KNaOX6ehTv+NO2FktK6WFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="340237"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="340237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:34:22 -0700
X-CSE-ConnectionGUID: 4zKMep/gRou5GplXxzcHSQ==
X-CSE-MsgGUID: 24okHB7oRg+wv4SJmL/hPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="265888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:34:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:34:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 02:34:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOw8T2lEdvhKf6S4eNBrh5SZUvwDcZ/VecQfhImLgYfayqDkwHKrwNzjGlQoOPNL1tVxCkjlJm9oHRefhKBuall4epOlj44fwQOuEERw4dY7TiwjyIuloSD7m6nwvQheQ2COM16my7gZsm1JLZGhzuJSv2tiBPotorDxWKV7a9qG8HUpoVWwjQU/KgooVzBZxm/zW6gQk6lCv20r/pi9clDZNjALdVizRWeqjve9ovFq40XHS8xV+TlIjOZqkOb838DkN0Pkc5YXgIv2JRh4jc3aIXz+K7NzNR6AKwkZh1smacQiDUUw/3z7fbYjk6BY1VNzBmGNThaeXptJ0TwxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX/6wCbs2IiRbxlvSbG4YsN/DbVMU4cXmKUzjt3j2UQ=;
 b=X1xnkqaMntufgpGbsA/2gJRWESatFH0LBtFOFJLBeQpZgtd7Vixp3PWXF+8LXgIGcgbTkT2zwJKTdHRvzCOWpwZyMBgd0VLKtXpTXcA33+ALo3OaQT8WAFrrcAd2Yi4pILz1tPyvVkLKrsIc9f8KZj6JlXZLfqE5Wp4QC6K8Twi9ElOirBwpS0++uQTR0Nl3rB+zbztMu4xA0brlWCw+NPaBLFH9kJkhgf/nYJCqSlR4jbW4JiM19cNREDg8SIwgzEahhcyw70jP4b04EgDH2wQe6DVnmrqXdvH7NTFKoDL3NMrBztdZp+lK/YVKSNiDvhREMN1DpcxX1uRYVGYm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS4PR11MB086599.namprd11.prod.outlook.com (2603:10b6:8:507::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:34:13 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:34:13 +0000
Date: Fri, 9 Oct 2026 17:33:23 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level
 contained in an EPT violation
Message-ID: <asi04xo+LJWmkkTt@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091116.15647-1-yan.y.zhao@intel.com>
 <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68f139713ee0adcca0d7a3d30e48a9c6cbc1f4d4.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS4PR11MB086599:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e03494-bba6-4610-4334-08df25e87a81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ikJ/Hkl7Qsc0gN/9HhXBORJdX2rV2cRMqD77cM0lQKt3KrGXgT/s7E6prghrjmJ6307CZiAsd7ykIJYrprwy4kMQHLjHbAfgDwtusp5WYBzDpnQIJrz1lbJPqzRfmKvYPN27gt/dmjJzCh8DPfm9IP1+dgEo8vPon39D1ZO2xzoPkbUP4D+MQbUEvoJDbX/efyyhM3WIyQuMmlYyhFx+Idhr41w2qzN56q5hsPoVh1dgsofnDJskKBWpjAUo9zlg6zoHU5lNKFD4Wbvwc3XHFmMgf0j1qzyyXYxH26Egi5BWAbPqNGcwFo/XbuajcitFmgeeiC/Ep4LqC5tzu84Ix00SOEwVKmds6Ayz/9chQEvVV6QekONhYMHEAQCjEsLiKfdT8u2NG0pFplDLoZsQFwIZckbjG32LNnuTJ4/5U7TJAhO0ojYPE4Y0JipSXxYYkor6UbdSGDG9rPVWYLOGDziitBG3KWL0DuVNQ2oswct1P43gCwNXC8mQeRaIE89I5aNYZtx669KnjAspfEL7gobquhdelO3OlU8ma7fd+mEjIx72u8IgqCwKNhAgaDcCQI6TtxGzsCMXlAQv8lr3ogVKgnss9EvK5+SKTvOX2cgO7wTbEw9gCCzHZcWAdfSUSE5j+30DZYzKboUiHVem1zp9R/H0mYMJUz8F8I5YJs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++yCCpnZ2Zsni3vmxIsQFl66QEQVXSJEKnISrOq4mGZ6daEDpsKAGJ/30fK/?=
 =?us-ascii?Q?YNAHXor0Jfg+iLuc+T5uba46R4cQtM81fk1r+w24H1J4EbuVqFsKqilbXa+H?=
 =?us-ascii?Q?h1Gq++vBgaGlgQ1RG3LxzzQN/pVT12eHuBqd8tZWngJWjd4DPF+ZLuixvyy8?=
 =?us-ascii?Q?IBkSgfOj+Q9eN1e66jtHp2K8M5jeoTDziGULjOjiNEpAo6PqwD1Xib1pmKae?=
 =?us-ascii?Q?JTKpN5hD9PUWhGtTcrFdQT3J8Mt36sq3SSp4GV8E7+AJrcIL4gUdBDcAOm1g?=
 =?us-ascii?Q?l6j33X7bzKPsZ5l2NASnjOVW9d4YtkdahsBThn8M56b8ICz5SaRDJLJee4tk?=
 =?us-ascii?Q?ZfEDHsBvvBgeLpKDvWqUB2+iORCzowNTPfgGggRdb3eZdy7/S9HN28XhoGJg?=
 =?us-ascii?Q?YEdkmiixJnG/jeSCa0LI7TDRp6mdJoAclD11fKxGjmAIHL9PNGi6PT53Z2Ou?=
 =?us-ascii?Q?OmuXt/hOlQ+Ma+WPx2t/zdJsmJiwKlFDdGSP3dmzKN0l2nYFxEdMBHJ4mWL3?=
 =?us-ascii?Q?pk4gW0m8f7qKHOMfxwMsWvNo85ex9qwdyqMH/auQ2uePa+sAcS4N0HfNdLJz?=
 =?us-ascii?Q?GDnfcBNK6vWlteSfRO2rrcaxpz84KE6bQASXyjEP4C9HwkDFiDWr+2m6l9k1?=
 =?us-ascii?Q?odDfXztnnb/RdWJydNUeyZGVT2PcMFqiQhqpeNxlrkNQDW6QAxp5F7lJM0wb?=
 =?us-ascii?Q?6iVmOxS+mQuGbs6EUn6H91JvnS7XulfSiBoixo2gBYeq75Zb+u9uvt7cBi3L?=
 =?us-ascii?Q?4YgiwyV+mwaXLwzVuh2KX+8YqGclRUF9S3Y7uxmhJu25H5r/RoVSzxIB7vKO?=
 =?us-ascii?Q?9OTO8ReI4xk933VJjcW6uTM3Kg5nz4rwDGwk11dtHHScXI7g8yhO9vZBx7tM?=
 =?us-ascii?Q?pvTlosp38spigE7xT59ZkNgEMXNyc4Nn49z30TDLwcugPYBg8IEKD2Xqleuq?=
 =?us-ascii?Q?f6pu9VkuQJ41cOWDqg7aD1EMhSXTYFEYkthd6+1tlj6y/nsHrSiWMTTtzpfz?=
 =?us-ascii?Q?ZuCFIa3O4sgQ1GgsQ3MjBSz6hhz53Gch82weFTxPiwmdWuz44WO7WJtEPUZa?=
 =?us-ascii?Q?pjho6ecfyJEqo3a3nZ5AphAM5oM7jk+0USsQYpFpetT/Jsh/wdQ1hJfXperV?=
 =?us-ascii?Q?rFA6aT9Pkc2jFJMZ5LsbDx7Mr9b8dmdGEymz4G2zevZJFFxm9hfRBaZa1ta0?=
 =?us-ascii?Q?RUDaxJSTfxemq7C8YfIO9xQi1OtdwKAVhRpAj6nUymMeo0pGUlkygcaQNaJh?=
 =?us-ascii?Q?D7aqoO0QAc7UKDZyjvfPSgzbdSyIlL7sNFUmFeglcSBQTkn9I+4F+iF+Xr46?=
 =?us-ascii?Q?reeAOjH8soPAtiCLt/yNXpv0oGjvYO9dp92uvAqcutVlB6Y6qQSzcVKhzMim?=
 =?us-ascii?Q?ahF0sjRa9cl/js73ZONAj8sW/OaV5u2oXX0gO6m9tLeq45QfA8KMaGfOg+C7?=
 =?us-ascii?Q?cQSUh3NI1iIx+RCIfJmdpMqlllJFby3f4zsNR4/XAkkDgZWOSlx+omjCcEtp?=
 =?us-ascii?Q?cNmQEX+HbvZuLP9sO8r88yZC19iaPGuPKMTq/6uQx4cO6apceKexDm4n0ti6?=
 =?us-ascii?Q?uMbvtuPMbnFkEQAzuJdz5gzPLJ8bbBoGVXvo0PPlLjoZYlv6eMGW8PNY68lt?=
 =?us-ascii?Q?azZYBfnQwcKD3haxnKLYnjkVWERuz9QwExKlXWOOEcirisQeBIQCykJdm2CZ?=
 =?us-ascii?Q?uga+kCA38bcpV1CFsUExpJjRktta+owQ9f0ysZ5A1H9TQzBP5sZw5ct+V355?=
 =?us-ascii?Q?NhNhkHh3aw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0ulwOJmfegtjQ0duPnW80+mk+t9M3JJnQo40iqoO3yOGri/g/kTA8zgCToGzb0zjAiDmlOLx6q5BusVoOKeTyWToHswWolgmH7KQ848AHncfcUkIXcuQJd9dKB6aMLpZaLGOo+HNZVFVWIFw1lOyCA+6qSKbd8V+7P+YXI6x5xSJOHDqxIstF5ZVZp2n1JXC0sLdoDBLTgaL2f3pIapkFL7v5CI5nzPyfmcWt7jfkOnnL6wywDHK6CiPupepzdAfK8GA60F2lqRswb5KIv67HcggYGXpTODaCI3UC7CPgW4NFr921HHmGImOZPpWxrCFwbCoKYztVe5DxeEzap98WQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e03494-bba6-4610-4334-08df25e87a81
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:34:12.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qwh/GWKcyzknztsttcLDDfYmLTv+ozR0ICBgCIHZxL4IPqnE2GNjQwSCxO/tDircnIBEZ6LUxOEmoW2PlY5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB086599
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 09:05:32AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:11 +0800, Yan Zhao wrote:
> 
> > +
> > +	/*
> > +	 * No TLB flush is required, as the "BLOCK + TRACK + kick off vCPUs"
> > +	 * sequence required by the TDX-Module includes a TLB flush.
> > +	 */
> 
> I think the TLB flush is actually more obvious than the level + 1/2 bits below.
> It is worried about inhibiting 1GB mappings, why?
Hmm, including inhibiting 1GB mappings can make the logic more generic and more
correct in concept. That is, when the guest accept level is 2MB, 1GB mappings
should be inhibited conceptually. This help remove the code dependency on the
assumption that 1GB mappings are impossible with the initial implementation,
given that inhibiting 1GB mappings as well is simple.

> > +	hugepage_set_guest_inhibit(slot, gfn, level + 1);
> > +	if (level == PG_LEVEL_4K)
> > +		hugepage_set_guest_inhibit(slot, gfn, level + 2);
> > +
> > +	return 0;
> > +}
> > +
If you have a strong opinion to drop inhibiting 1GB mappings for now, I can add
the following diff:

@@ -2183,7 +2172,13 @@ static int tdx_handle_guest_accept_ept_violation(struct kvm_vcpu *vcpu, gfn_t gf
                return 0;

        level = tdx_get_ept_violation_level(vcpu);
-       if (level > PG_LEVEL_2M)
+       KVM_BUG_ON(level != PG_LEVEL_2M && level != PG_LEVEL_4K, kvm);
+
+       /*
+        * No need to inhibit 1GB mappings since they are unsupported with
+        * the initial huge page implementation.
+        */
+       if (level == PG_LEVEL_2M)
                return 0;

        if (hugepage_test_guest_inhibit(slot, gfn, level + 1))
@@ -2203,8 +2198,6 @@ static int tdx_handle_guest_accept_ept_violation(struct kvm_vcpu *vcpu, gfn_t gf
         * sequence required by the TDX-Module includes a TLB flush.
         */
        hugepage_set_guest_inhibit(slot, gfn, level + 1);
-       if (level == PG_LEVEL_4K)
-               hugepage_set_guest_inhibit(slot, gfn, level + 2);

        return 0;
 }

