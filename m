Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8814E56C2;
	Thu, 15 Oct 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056584; cv=fail; b=hQG1w58uVZT+Ins0CmRvomen1AcaD2t4N/il6s/WxVmsCnFej2vht1JFcS1DsJzb1teGn/kZ6EVlklluI/HvRIwlCIozJUlptF7SrIsoMTx7KWle6CYRDsfn9Fto2NVELGF4HAZQXVrXqAbCsfQMPGjEGdX+VzxKCF8gJy0HGWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056584; c=relaxed/simple;
	bh=V8O9inh1LiaqC7xWwkZzJq+x5SDXQCNg4xVxsgKUm6U=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8Bwmc+gxsmCE/t+UVA9hFT9xk8i/hJwgXOezfMKeDTNl2s/lXQmWDAQFR/65wz+JKlmFdsBwfgfQoIu4qIYwb29CM6a5U/7l0X9SNRJp55LsfSiOaYfnNo01gkKAqTVRZUf0GcbhI9b1CJmsD0esnLlWYxCs61rPXoV1YKMc24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhsnyzEs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhsnyzEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792056581; x=1823592581;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=V8O9inh1LiaqC7xWwkZzJq+x5SDXQCNg4xVxsgKUm6U=;
  b=nhsnyzEseF1EK1kG3vrtELu79i+Q0fLXRaQsxNvaZ95CZwk5HEfrVdcD
   uBJh3aka14NGprB6bfWklIbWjjNEksXh6QvF498QH1Cf7KDRtKlDu7tfL
   Q4X6sXxB6WSRzB1OKcFrQpOvmGTUsNJeS+EzyL6DhZ9CvrM8AKrojU1Pf
   f8LKO7ACTw9eDsm0DkmbzybRv/qrJshtHpeN7f9WqjqpzR549wCU7nUEL
   VrVtZEmleHXqtllBhukOngIVIi1hUF/ZYz/plv1fGWrHRppI6Hx1wZuTw
   lkyz5s3Lgj/u6GjP+2Z8UI7IUZocKhnvrzO0KGqPEiy/NZPSoeiCru+xB
   w==;
X-CSE-ConnectionGUID: KJdrZvcCR0yCTFTKefOzTg==
X-CSE-MsgGUID: okMp00iBTD+6aMmB0cgesQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="830431"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="830431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 02:29:40 -0700
X-CSE-ConnectionGUID: MEpQT4+FTqi/bKwuVKQtDQ==
X-CSE-MsgGUID: iSG1PY0YTW+c9DIPvtuKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2011478"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 02:29:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:29:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 02:29:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:29:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBnTyGzz88Z4RXTFgzdZZmNR95SddesxOR9T8LIJy8wERSqIGfNkovT+hPpMCbDPtR0fsXt8tMUNa4GHbEGPLSMq3HkQlhqhk8O7o5bWS6lGmmyBS+hRy2IYB0jEBb4Vfi6P5TgQW5EzKfnkn2tAQ5pJEZKwDPQvWnerhCOcjfEsXs3NP50bMJSPsdigeYsKQeqhxKzJFgHNEBDYaMyrwgSYfZFpqcpdAPhPdyNtMQ80QJvRctq6D2ln8mEGuIetUPJhWCBPJfgd3+zksqz4NO7rh34+W1Odxwvr29Td6c5INCWG/TgVSSi/ffWxHaFpARitmocaPTrfgrSrV44u3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meH60QC5al6E3q4RSXXjM4Oq/nryRqQn4jGr3Bl7XqQ=;
 b=fWtT2ysB46fFksHAkNiQnDGsd3NwnBvSVz8uVSOGZ/eqjavxBcpteaf2LA77ePGGDfCdTNfnCUJQAYzVLJfuJFYJLe8h5TyUThU7wIQscWYCI2QUin8s4winNJH8mR9wbQXOSB39sE3HGR23RvIJRPxDm4P57tAl7gLyk+R5Gdv2Jz3KfFaVqHH0na+1yclcy68ol4atBW7Qzt7Neoe0YqWIqS22zBv7s3oOSm0E69fOnlp19cOhx6bMW8VGI5EQpcoLpzN9AOisrLhrBVunymYjJ94d4Y2kRF/zkToPY+0dop6doSDTTL2Ue3FMmZrnHT5ojYWYQQnQYHM+EctRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 09:29:23 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:29:23 +0000
Date: Thu, 15 Oct 2026 17:28:28 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Du, Fan"
	<fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tabba@google.com" <tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"david@kernel.org" <david@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
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
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: d1aa396e-bf3a-4429-cf7c-08df2a9ecc3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|56012099006|921020|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LjtKbFrIS7jdKHRKXmwuq0rd7OpOjZ982gj9Qf4qqq212Ai0pUw+ru0JOHbu6QFmYKeGNdluW5jWB/a+auETaJey3CGICzTeQrb4zwgQmmx4jQyDWYX40XhK0g/+q1mDyRACUSjJb4dY19xhPxIdLpmIuYjH60gTkYW4rl2A+P5O9ivgeo9SFE9VzR2VANwBqRdYIrfGFRmF6xtMPM0Vg4WJzrHnngtlK5gd21+KiuFrG7HWiNOibYknwogVG7yjLfp0x+xIZxLzcgY5RyRRuMUbtukC5/hXR63Dtdb7kNfwKn7s4u74QNp8kkpaIy+qBY+sDi1UxsnZAKSZSjJqZ+z1lo0q7kjgZaARVOUBtuaKr91OqUFCVgoE2Veis+k6GrKYpDKuqk2XRD3+DlxZWGU28/4txOzD7LLwkLBPngnN6ingvGP/ZK0t1Xp8yWI725jPEgZ57fCNgMWVjIcg8nLzbvwQX8xu6t8Aav36PF009sdTe5eWJjlsGll+U/EX+K+QASAqXlcnIvOWyEUNc1gXxZM7xHlFjsEWLwZwrNUgYGpPB/ELSg7JAXspsX/LPeXI2bGoqS0zGIyYHYYqRy3e6fKaNy+XlkY55mWAC4H5A5g3Fel0C1uiP6r5uwfXQCAvLR5AJRhABjakPGhpuwU8ANpCzA05DXH2uuEwobI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(56012099006)(921020)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygJv/dYytkWlCC6tFKHe6DmR9xrs77F27k6fA9bJVjELNNRjytq1ZCiI6P2/?=
 =?us-ascii?Q?J2OyrF2LdWHKIuoWKCmsOBDYzAHp92UWRNsVvrRn5sVinoqbpW4Z/ZQT99o+?=
 =?us-ascii?Q?vMUTYdSb/6ZpM9cpBQ8kMsSZtG1i+ZfVVOB+vhIoTCJnN/z6xvfbrt4ChYmq?=
 =?us-ascii?Q?Ee11PZOg+xzdNjcv4hwFQnl3SpXbLoxBzpbolkheAZmtukYqfXhdXcOj6BeD?=
 =?us-ascii?Q?8s5LbKtISs7h5uc27itDgzLDyFxodCUWp8JtBJI8524l9qDCtMkx5RPtqn+z?=
 =?us-ascii?Q?paeE2JJ1SnGxDD0iZriwEAVeYzK6I+TQi5ZjE8GxLLfvtEP8v8Qfv9fr92MG?=
 =?us-ascii?Q?mccQkS/E1QdozLaW3ZPzpdzbbGJUscGwfhjTQs62uFjG6sUMnQB9WmuFupB6?=
 =?us-ascii?Q?Cumxr0+/N7sZqZA05f9q8im87J5KbmDVLFh9mvOGPDF9W6iFvH+IoiSV6ckF?=
 =?us-ascii?Q?xG6saSZ7Ywm/KvlpCt+PTuHiG0OLtD21b67itciueKwrDCzsfEtw0O35GuQC?=
 =?us-ascii?Q?B/glZuIQxxBvjozdNOlLwdfksbwuYxHcqHGCLeYWE8epElCwiGz7V9rGyrht?=
 =?us-ascii?Q?1MN0ZpHXsBnw2jZMDOFKaKFECHEh9hvtfTimkVGejd63zdyaePflLWQMTfPr?=
 =?us-ascii?Q?Bvh1rzpwmZ/d6rW/RUkr/71BqXPsvpZx/YMcOsa1AOFfoNWycnBGTpglU5xG?=
 =?us-ascii?Q?594WyJqLfZFXfl0pJhdP080/Kbtt+gYcWGWe1qxl4/MCp/hJA0PraPvaKipx?=
 =?us-ascii?Q?J8i32s+/co3I2m8dcJzwomakFAE8i/k8d7TTf/kzE/sgE2waK3qVvVOewVhG?=
 =?us-ascii?Q?8r4RR0614ARDoUe36TEkKV0RrZt7cTQk+c7WfeK+4T6oFSlJ3pTFEAvdEOcl?=
 =?us-ascii?Q?bH5H/4SCsX8/LDSnba+I8Tyw78zyMuLM7JLXBi2/3YwbG0/OwRaqo12vvmsf?=
 =?us-ascii?Q?6d9Rp88PWwtpL/9cC1El8NnTukYuspm9Z+mDv9h/3ZaWsX67YKn/eYHwKIwj?=
 =?us-ascii?Q?mEz3vg0P9tiX7mmZE5VJCVid1XJCe+0W7qfiRZIyzhdSW7aajAEeGbueNxuF?=
 =?us-ascii?Q?KGDNWTnDlQNjoPQPwi6Oj+clsMREZf1oOfdz1cSbTVuARz+umQ23b3PJy6qi?=
 =?us-ascii?Q?tnj+8L1obqxd0gq+fy5x6mZ0e2aGWycjB6T/ePF5uVSuGxZTRis+gpnBmYaW?=
 =?us-ascii?Q?SiBqkBKNL6/2qohbhF+aFYBV3tWBnDZ/kypG0M5V5HJDIYtEiBPRzeKY3UUh?=
 =?us-ascii?Q?VXmlBE1dVsuNHsgr0XDR0msDMU2pfhJ0z+kVXWNghcap3zZ9/OiOj4HaP2/u?=
 =?us-ascii?Q?vJhCODNhGK3ag82NaiWRpa93Gw5/fX0C7Lw5v5OUuu7zHwZa0+bVyGP1eJG4?=
 =?us-ascii?Q?40Lb4HEUVf3JjeqVjKIoI5nKy8uIh3zFymxZZ/9zm7fAcioBjvUfzlfwFN+l?=
 =?us-ascii?Q?6Nzng1/k+iimEvyRcJgY51NShSxOuBkenMZyasa4D1IXuOzmQ7rwYI31CrHE?=
 =?us-ascii?Q?ULX84Enju3o1fU9Ha8FJnVsaey7EK82Pi2JgvWMu9aFvWg4wIL85N7uC2sly?=
 =?us-ascii?Q?ToA5jDeTqzDTaF4+cITdHQRk4GU2cfPchJTQY+/OeKLDv0NJvJHgGi9+tmEx?=
 =?us-ascii?Q?BBs3bJAMi/LqJOnAhnEGgZujcwXnQyc01H0+VrIxd/m8+6KDgq/CTp08CvfX?=
 =?us-ascii?Q?EpMNtECuLaLTzyFDYcfhfKJ7qBwu70MZpHaPUbvQseIO2u8hBzlpmI8IVAdz?=
 =?us-ascii?Q?E+MPuVeV2Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: AdKch6kO50l1Kwwf0tOBgrYscjgt5wgiO5Y4HFI2K8aP9crxH6A5khtz9MBfyM6Sp/jrICKhbnwUwzwM/t9iSOSyOBV6NKYsysS/89g2+HiaGD1YhZcy0kflPbdhO1ZCgb3pvi+vlyS89THeWERiOzwrNJu6MXIlEQGBhKVD5qfkmQpHicnoAuR/CZzLWqXSuWyZCLdarPXmb5nTA9PW0jqoeF/DEZnTKewUnBGRciEl58KefUKnsED8voipt72CvNR35CYvgtjrfY9xeWE8BcgN4RuC6PWJIXJh6Eflc7Mj/vQq3yJYKmpJKnu/WjXd3tjVYAKB1EDHxgTF4lzRhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aa396e-bf3a-4429-cf7c-08df2a9ecc3e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:29:23.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iscSyLVSTuwtL/vxL2s2UibUCLya7B0eBQn8r/VJWZjbvcUxVYnW+VczVPtVnB8MbkFGi3SBzafXLdJe4q/dJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 02:11:51PM +0800, Yan Zhao wrote:
> > > u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
> > >                             struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
> > > {
> > >         struct tdx_module_args args = {
> > >                 .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
> > >                 .rdx = tdx_tdr_pa(td),
> > >                 .r8 = page_to_phys(new_sept_pt),
> > >         };
> > >         atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
Oh, when DPAMT is not enabled, this line makes it erroneous to access the
uninitialized dpamt_refcounts.

> > >         struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> > >         *ext_err1 = 0;
> > >         *ext_err2 = 0;
> > >         u64 ret;
> > > 
> > >         if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> > >                 return TDX_SW_ERROR;
> > 
> > Do we need to handle this logically? The below will return some error in any
So, we need this check and should move tdx_find_dpamt_refcount() after it.

Would the below version look good to you?

Changes vs the version in
https://lore.kernel.org/all/as9OHnM4mceEre%2F2@yzhao56-desk.sh.intel.com:
- Added WARN_ON_ONCE() for tdx_supports_dynamic_pamt() and moved
  tdx_find_dpamt_refcount() after checking DPAMT is enabled.
- Added WARN_ON_ONCE() for DEMOTE SEAMCALL failure.
- atomic_cmpxchg_release() to atomic_set() and added
  WARN_ON_ONCE(atomic_read(dpamt_refcount)).

(I didn't add the warning for alloc_pamt_array(). Will add it if you think the
justification in
https://lore.kernel.org/all/atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com makes sense.


u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
                            struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
{
        struct tdx_module_args args = {
                .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
                .rdx = tdx_tdr_pa(td),
                .r8 = page_to_phys(new_sept_pt),
        };
        struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
        atomic_t *dpamt_refcount;
        u64 ret;

        *ext_err1 = 0;
        *ext_err2 = 0;

        if (WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo)))
                return TDX_SW_ERROR;

        dpamt_refcount = tdx_find_dpamt_refcount(pfn);

        ret = alloc_pamt_array(dpamt_pages, pamt_cache);
        if (ret)
                return TDX_SW_ERROR;

        args.r12 = page_to_phys(dpamt_pages[0]),
        args.r13 = page_to_phys(dpamt_pages[1]),

        /*
         * The dpamt_lock is used to avoid contention between the
         * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
         */
        spin_lock(&dpamt_lock);

        WARN_ON_ONCE(atomic_read(dpamt_refcount));

        ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);

        *ext_err1 = args.rcx;
        *ext_err2 = args.rdx;

        if (WARN_ON_ONCE(ret != TDX_SUCCESS))
                goto out_free;

        atomic_set(dpamt_refcount, PTRS_PER_PMD);
        spin_unlock(&dpamt_lock);

        return TDX_SUCCESS;

out_free:
        spin_unlock(&dpamt_lock);
        reinsert_pamt_array(pamt_cache, dpamt_pages);

        return ret;
}
EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);

