Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648004A3F08;
	Thu, 15 Oct 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057842; cv=fail; b=n5+BT5oQ0IHHP4Ne4scKnzi9F6ln/bpTtyeWNT1TJw8CI6BU1ug+jnFwb6mg8IlIfWGlfIx8ZPDdelCi82qhdC5cSpasYZX/ZkVEDOFuTVwednwlG3sWZbBAE2iWHSBlT6WSi04X4kaJnsbDF8gUdcxalA6OuQ4Oa4LbwnczR5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057842; c=relaxed/simple;
	bh=IUp+f4yqP65ovPVDn6mwzSk9sZ5GlY+RSVLHP/PGLeQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=El7/drlo7NYUmFOxCQTgh2gvCESYgeDELnq7X7Y63tp7xuW0L6i6O1wAhLTsBmtoHtXE9x4IOmE+HRXrUtpjs2HeFYZAzgPbXYCmP47Tncv3+rG86HGig3H9FWuT8e9ywS9OuF7p/eWMPoMT6vzvcsBlaYD1ezLx6oDyKvSu4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qov4N5Xu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qov4N5Xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792057841; x=1823593841;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=IUp+f4yqP65ovPVDn6mwzSk9sZ5GlY+RSVLHP/PGLeQ=;
  b=Qov4N5Xugt7oENDSGq/Qe7ySxROWk0ASWraB4MJcjVu1uPCyr52Y9CNf
   Jf7UIZtPD3rqQMVYJYxum3s0WzLSY1wG3z7TbC+mnuMCUaU1R6S2gV95/
   bnRBsqJisaNchRJ21gDQJBdyhfCA0A0fwtnH59GoUCXg3URemdHTP7GiO
   QOtR9w/o3428xeo20t1Sap/XkNGmfgO0ynXRQmI8oU/jv1suUA4qZmhlD
   4o3vohDLs11FsPnwKj4UwKbx4kGBKnpeqp5TSBjUXW69qzeOv2ZCglC3e
   sxh5KfZm3vqxmWiOfacUoWl/1/JJTmKOtlCMJ4hA72L0cM9dbuk6ZN5Th
   Q==;
X-CSE-ConnectionGUID: 2eZtP4JhR1yLlstgPmYCDg==
X-CSE-MsgGUID: BRyrAFHWROyva6yvp+GG/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="705216"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="705216"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 02:50:40 -0700
X-CSE-ConnectionGUID: XKk7XzMiQpO8ZwG4BuBVHA==
X-CSE-MsgGUID: Lpp7tRFpSYup5aDd7ITvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1737901"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 02:50:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:50:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 02:50:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8Zgh5FC78cWV4OE87nLNkSjAOYAljbrj7OsbdY6gy72EVTIusUbd666PXxIi6fM3HzsgabbCB3A5dl5Pq4MD1PXql5Yp1Algw7d+31EtDPFXkBrLx/cjbG/7vGNXmKXO/G8m2YEfyI0CXpSOpmNcP2lDE1nvx2zF7wbUo8UI6TKNpHfBVOHbk18u6mydw9Z9f7gPd0XEbNirlrJpoZDZmqqFD++nuVjA2reIjBzIEcLokVpAYyU9my+WkwwC7cvv/KtTo+m6RZjHq9CLkA5KPfMa/bLWTpL9NwjZYJiU4RbAhDHls1/3w5gcdVtKgVjb/rbdXWcWO5H9qR296Cj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDXoyaUnUcchu1eRs7mOHls5i432dhvaldI+7iIDwDo=;
 b=n3EC9mfsP/hvvfx+StWBM60lNSNFmhXDZ0d8cEGMfulAhgX/L1KvrUlb6wzCicslJ3QoeCLu3U7Rp/oN3WQmDbuveLcql0hKapsTppPvqQi03YKay2b5fmCgyPLI4jn7zP5zFa/toIx5aFb+b1BJ0Nq7fL0LFS50ZCAwL1C9BFMMmoFJ84PGVfNlG+cUp4BdIhV1TkHK+Y38sADpNE756VYXyXaKD9JD4nrwfPCg1VpuaGg7TRPwEudUjQn8F24aR069hiR8Lup8gNgL9ANPVh/vF8vvwJwlnUjM693G8D9PP0AqqnsFk0sLqGnkkcw2w41zwQbVThgQ6Pp5y7EnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by BY1PR11MB8128.namprd11.prod.outlook.com (2603:10b6:a03:52c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:50:35 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:50:35 +0000
Date: Thu, 15 Oct 2026 17:49:40 +0800
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
Message-ID: <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090831.15502-1-yan.y.zhao@intel.com>
 <9016c06a883bde489957ffdf7933cbbf6b8e6b03.camel@intel.com>
 <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|BY1PR11MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: d0abc263-600f-4dc5-94ab-08df2aa1c271
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|10067099003|18002099003|4143699003|11063799006|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: 6Lx4Vly3l3sR1qy3QCUKjt94hO1S8pzMtCXftiwxEI1RRnd1t0u4MsDp7PZ6FwDVfrZgsGZyUieqJfDSexfvbLF1JB1Rpdl9fbmUogVe+AO1BdwODGtS1wsgwZaNqxXxlGQHDKxbe5lS8FGHtZd/mHHh2KBSB2hm7rTgx69KfAjjy/4uHR9zf/5uHV+SSjIRfegpbsWgXVnl52XPf8XpQYntgn3oAEV0VkRYWqLfcyp4fEYqwUaMkEOaw+kCiM3daE6RmMJKjiZ054b52cRc26jXg0jrk+mbGlRZMQqRbFN5nm4m5HoieB2Dhqz1zfesd9y+fH5fWJZ+Tx975kFcXcW84JPc+XzuSyUGNdwt1STvSsto2+MqvjiI7aUPThnoM1gZNO3psNPzdSZNVs257tDP/kxns/p6I4MYWDGCkzvnoayKGDEdDd/63WTcheH0JJNtUQtxa6kQYrV4+wmdtVhg585Q9ltEF29rXuG3S7DEqsgYyjeTpexYRY4l2l8VJ5CKxY42rIjoTbQEfGwFSEd2+Eql7m7Fcg5LFWLJ9USylwuQx4Ywg76pvM2TaD9PId/tDR6YHVNsGZNb2btmTn9D9Z4moHc0RFw1z8kVZhlSk1dxlHpCfCpVw/rdLOFMaHAfTkyZgTN/l0S8u5O/YTDnI89L8+R2lPT46XiR5Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PVl1HpiQG2tW5/Yex+ggdpgf+wkuDZ4DVHkG4eVZkj0L1Kf97olqBcjH7uld?=
 =?us-ascii?Q?bmJgoj6/lumWyFpysVsIzjHWmQk5mI5WQXSl38R/Eo/SPfaY3wXKly2V+qH2?=
 =?us-ascii?Q?uIvYidzU1RecE2RXJ5arzjrCnoerT33IdoRk/acLGpOb8Jg+E9TvYIYUoJCx?=
 =?us-ascii?Q?PfPL/kWn1UFOdYESSSFM+8iJmKGIJQqmBkgLxN2gKwRVuS66IwJLEXvZ12hQ?=
 =?us-ascii?Q?9Ip4icjMgZ2OOMc0POIG8srNcfAAVof9kZlXeEt8QSTu6CxLWGuV3a+roiL8?=
 =?us-ascii?Q?u8rZ8NBGGMOSxGXqCLOYUj1meyfH3uplbL3BPBS81/Ueox8jj2Zu8FXYlf1i?=
 =?us-ascii?Q?JdeuF7ty7HQY9UaFGBMgPVCyfc9lQdQssU9GOLDJ1FEZ6ejpQXctGRL7YMum?=
 =?us-ascii?Q?EF/1kmO9y1E+5oAXZ1YzeeTtH1hIzaDlpvKpfa7mHfE+COEinhi5m28+/H8Q?=
 =?us-ascii?Q?vJKLduX2o8sDeAnvl1U9px6bGA2OF40AtYFpmMCm35ZuDe74i8aX2Rdd15EP?=
 =?us-ascii?Q?WpWjxvkZ/tNro7oJUe6+4FFqc6yTBIItowz/gJmY5ibZWgSwvwgU/yaPgb8P?=
 =?us-ascii?Q?xqFJ/g4aP/B1NSBMF2AooApD+n7iyFLX3NZ6Ya9yNh00MXJ72JhuIFAniMIK?=
 =?us-ascii?Q?/B2eDjn1NxHzc9ETB77rFYqJ6/0voGKA3AHrC740/GYykKnJRr682UtWeQdl?=
 =?us-ascii?Q?WQAhwWRZswwtO1i1A56HSt2XeM+yUt8YYgH33mZCxiq1CB6DsAi1QjZsFSPQ?=
 =?us-ascii?Q?WTSzTeUj3rICRRY1/wG3pNdiya2scIc/wstQcYU0glskl3wt2wd1jw3S3BKb?=
 =?us-ascii?Q?ZSfwExX0x1Ny4B7YQNQzmo8HCln7+OajtF9xPCyZ/dbq9o4O+SN9SRCH+oKI?=
 =?us-ascii?Q?1KIJe+EoL6Zn3RfsgTpgl/araWLHmNOjnLVQtpQqtZsIHuUTCpFpgWvm3K3Z?=
 =?us-ascii?Q?yrKiWRAbMcM860FzzcsUOyvlSBv4O+NKv5VrliogK1up6PskLqDdZZEMdCii?=
 =?us-ascii?Q?VFh5Fw1msxxxuUeCjsmYVtukBiGym+55HYjhwFGBT4PRlh6AxKw8+oriDZUb?=
 =?us-ascii?Q?DY3GtHoM19y74HM2rWv9HG1I25Q+evEjpmsLEj+omTs5ExfE2jrE4/BRedcS?=
 =?us-ascii?Q?kmDmLs6YylN80NxcT0aE0nZt5Tjb2CrJPo3gB0do5SLywP4hAeTGURNtOYYU?=
 =?us-ascii?Q?0tdYofxOZM+GLeuwU39iHBzvvb6rbAJ6m0j61G+nJjfNOFWz6cvTK1VBM4c7?=
 =?us-ascii?Q?PakJdWXCe7IN2lI9fnJPXpBtK93p5bdUsS1zkjm+P95hEQauteubIvILMkjS?=
 =?us-ascii?Q?CmwUWKWhLShiWgQtsKFQmsRHC21lP8Sc73Cwz2JosvV7ParZvNKTyCnbfNoE?=
 =?us-ascii?Q?VvVWBZFgu+AVCRvGpQ4SzZhnK5BO2WExW1udFCf/LKjZNmUU1M02F7gZqVMu?=
 =?us-ascii?Q?kVwYf9nplI80gufR2rSmbwUaBLOqwdtjQhR4V//Sd8M+hYvfXUELl6pCDAe1?=
 =?us-ascii?Q?lp5Tx+7vhHFawpMdBPn7jC6JdIzk6vbvxxNXXECU9zMQwMYPHQmSA5nOqjmH?=
 =?us-ascii?Q?VOy93IOBvUyx/4gaH+XCBIOrmq23YRbreFQoMMgrcnoOzMlWAlAXK1gFbrx5?=
 =?us-ascii?Q?leEd/qYmlNPQQ/ILyCl24Kra5YH2Iy/4yUEZVVmLLN9j1tUxE3DuprchOvHl?=
 =?us-ascii?Q?f0WVDl5Bq7ym+pkPoAe38Oj/uR5gPJZMc+zIhYvDsvjPGy/m6oiQNeiRSJGe?=
 =?us-ascii?Q?v4/dJPKKuw=3D=3D?=
X-Exchange-RoutingPolicyChecked: VSIuZXgU/EY1BTgTBozF4Rf6lh61myqiJ+tyQWE7YgX6ifsC6x0Yi4eZ2BcoBHrDz5naC964eyNHfXDF+lAk50TJbuBQZCj/b+LVqOaRZ7yUYfSFX7NIQ5TgCezSitvTM9/2pf/us+/3KUubwitWe7KobvoMWgfHYZhRW+RrYR1XBzy9swiSzbUD5ldin23+t/ofRF4alK837MiBDzdTPzwpITdyXrCtuUcU429z0VJwy5TfT4GmxwJZGdzQxo/svvMhLf2QiMkESPLKBlp+nP32V3/eqCL4rwHy9MBRsqyUZsDyzdiN91U/EwPS5uAKIlv+0Bn+ufBz4HqEIItidQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0abc263-600f-4dc5-94ab-08df2aa1c271
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:50:35.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rh8Bz8/o992wJnIQy6w9gXDsiyXl6PrZ+OOhEl27eYac6u9Y2KdhmTi3rWj7g/fO+fCK+VCEE3pOnSyD9z67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8128
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 05:28:28PM +0800, Yan Zhao wrote:
> On Thu, Oct 15, 2026 at 02:11:51PM +0800, Yan Zhao wrote:
> > > > u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
> > > >                             struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
> > > > {
> > > >         struct tdx_module_args args = {
> > > >                 .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
> > > >                 .rdx = tdx_tdr_pa(td),
> > > >                 .r8 = page_to_phys(new_sept_pt),
> > > >         };
> > > >         atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
> Oh, when DPAMT is not enabled, this line makes it erroneous to access the
> uninitialized dpamt_refcounts.
> 
> > > >         struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> > > >         *ext_err1 = 0;
> > > >         *ext_err2 = 0;
> > > >         u64 ret;
> > > > 
> > > >         if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> > > >                 return TDX_SW_ERROR;
> > > 
> > > Do we need to handle this logically? The below will return some error in any
> So, we need this check and should move tdx_find_dpamt_refcount() after it.
> 
> Would the below version look good to you?
> 
> Changes vs the version in
> https://lore.kernel.org/all/as9OHnM4mceEre%2F2@yzhao56-desk.sh.intel.com:
> - Added WARN_ON_ONCE() for tdx_supports_dynamic_pamt() and moved
>   tdx_find_dpamt_refcount() after checking DPAMT is enabled.
> - Added WARN_ON_ONCE() for DEMOTE SEAMCALL failure.
> - atomic_cmpxchg_release() to atomic_set() and added
>   WARN_ON_ONCE(atomic_read(dpamt_refcount)).
> 
> (I didn't add the warning for alloc_pamt_array(). Will add it if you think the
> justification in
> https://lore.kernel.org/all/atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com makes sense.
> 
> 
> u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
>                             struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
> {
>         struct tdx_module_args args = {
>                 .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
>                 .rdx = tdx_tdr_pa(td),
>                 .r8 = page_to_phys(new_sept_pt),
>         };
>         struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
>         atomic_t *dpamt_refcount;
>         u64 ret;
> 
>         *ext_err1 = 0;
>         *ext_err2 = 0;
> 
>         if (WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo)))
>                 return TDX_SW_ERROR;
> 
>         dpamt_refcount = tdx_find_dpamt_refcount(pfn);
Can move this line after alloc_pamt_array() to mirror the sequence in
tdx_pamt_get().

>         ret = alloc_pamt_array(dpamt_pages, pamt_cache);
>         if (ret)
>                 return TDX_SW_ERROR;
		  return ret;
> 
>         args.r12 = page_to_phys(dpamt_pages[0]),
>         args.r13 = page_to_phys(dpamt_pages[1]),
> 
>         /*
>          * The dpamt_lock is used to avoid contention between the
>          * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
>          */
>         spin_lock(&dpamt_lock);
> 
>         WARN_ON_ONCE(atomic_read(dpamt_refcount));
>
>         ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> 
>         *ext_err1 = args.rcx;
>         *ext_err2 = args.rdx;
> 
>         if (WARN_ON_ONCE(ret != TDX_SUCCESS))
>                 goto out_free;
> 
>         atomic_set(dpamt_refcount, PTRS_PER_PMD);
>         spin_unlock(&dpamt_lock);
> 
>         return TDX_SUCCESS;
> 
> out_free:
>         spin_unlock(&dpamt_lock);
>         reinsert_pamt_array(pamt_cache, dpamt_pages);
> 
>         return ret;
> }
> EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);
> 
