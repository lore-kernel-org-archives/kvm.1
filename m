Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF53876DE;
	Sat, 10 Oct 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618172; cv=fail; b=p/KTMreZ/3AmfF6Zct2671xNlJuSJuVDtZA2BEs+RXnN0FV9uWyVEGvXQ+H7Zp5B7MHejzA0hz77tZ+VDWIiJJwgob2lSdtKLW50YH1RGN7uOgPoMJawTFgojOz6tLpiRlWcEhrjwmEFJgM7MRniTTPVlaUK1KJmi//GBddY3Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618172; c=relaxed/simple;
	bh=zrGplkbfIatmQeYXNf7Q54q9lyxU+fM9nndfyMhZVvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8oWQtBJuCH/zmB8Dk4MTKPNW+bJ2CbmeN2HvQYeSS6/rajE/GhDXL+wXku5f8HsZ5dfPPWpTu80LUrvMT7SfBFZaXilRzEcXN1sP4/x8gLIeLopSQ+RYPojWU5ZM38Eb7H8P2qGBvF02dN7sJqZ/3rVBEklVB1pX5hQ5JGZV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq5RaxxQ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq5RaxxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791618168; x=1823154168;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=zrGplkbfIatmQeYXNf7Q54q9lyxU+fM9nndfyMhZVvY=;
  b=Vq5RaxxQXz6VqKjBcC7xZn0YQgQP3ZuIkw4hOoG1naQOLl74UdardxGH
   7hTuocwEPh7osRTbJSRW9BQiQLVYvz2eFlZ9vmYaV7a3eItM1eJvK8CV5
   grNe1G6MDjYUtMARK45v6gzrpbyQNzgSfgDTN/pOZljKIc4G5NK8XX5MY
   aOLGx/Chkfd0L2EqIApoUdAToWUaDTzoDBOblZkH9GfQZIrcZ0JkXHC7Z
   DMXgpmXFd07mIWjSYZMVUQ0ZyqC7oFXDJKUrIqPO+CJSIQRNGPt4Ejmpd
   DQCjBFKIPXpxCQgpL86ShcjFFJSdqWe1Gv6EdiUq/nnRi8dTt5uwTmIYs
   Q==;
X-CSE-ConnectionGUID: D5kN+tT2RXO6Q0gkIRZ/vQ==
X-CSE-MsgGUID: /jkg7iZGSq26X9VwY2ARLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="519815"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="519815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:42:47 -0700
X-CSE-ConnectionGUID: 8NZ8eWBcTPeVokBCRYbVfQ==
X-CSE-MsgGUID: 7s5IMtCzSRuIYJgDyda04w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="945080"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 00:42:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 00:42:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 00:42:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 00:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxpdCxPczAtwpE+fRCU51U77GTt4sGa3C66z0L09don9VByQek0xyVV5oSPc4sWOuq5jJUP9SgsKqGY00tn+XW0YZl/Al30+JoOsurv4hGgXSe3WlmWldDBXIjYJVQNDL9ZlqcCsi8Cy/513ck/5P3TL5gSaoeuxpkv+exUYJjU54BOIeiOmGPhzF/3nngWVcxHHO0mB4Kc2VEIqBRqKVA7a0+KlYMK6MlDJfc6ttDbeoMYob7eHwT1YXmuS05N1nU9zOTGIWIHtynfOgJ36WOHbZVHL+TCP/uCoCjaC8txryk+fNJd/vUWURB0CFiZOoEMbkkif6yuo6pBSFZ7AKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukMdyBlzC3MKJzb/49kF2Zhqip1GeurxQg5MULSGFc0=;
 b=Hl/N52ar/zA5vyBztnqMdTU8aPSGKvdy/EsGPDEvgkC6JvFwo9cXTSONzaqF/Rscd9SpSzbk/Jy8+fBlaFJ5scMcqMhHnvnOAWBrlorSIs2brY//xdLQWeN7NOptobMUC7Fc8EZ9bVIa94o0JY4ZY1kE3hcAdbzp9dB/3ZzyGTJ4nQrYaWmApz1+fV0I56+Vv2kp7BpHNjKdUnYNFqZ3bm+6lanDc8FhoZSOYyciYoQiiVLz9rE87oIszlENLcCiUzc9FdVr+kkcaKCdr8cyitXgKc4HYgwMgtXAFN3RcX8q63R6HjwO9L8Qw/aE7EGFYAs2uh34qzU85tLFXa/iJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 07:42:37 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 07:42:36 +0000
Date: Sat, 10 Oct 2026 15:41:41 +0800
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
Subject: Re: [PATCH v4 05/17] KVM: x86/tdp_mmu: Alloc external_spt page for
 mirror page table splitting
Message-ID: <asnsNc2carZF/vum@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090946.15551-1-yan.y.zhao@intel.com>
 <0e0b2da671574f0f3e776312557794c2e7553e83.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e0b2da671574f0f3e776312557794c2e7553e83.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|SJ1PR11MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: f8611aa0-8028-4faf-0425-08df26a20a80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|11063799006|261009223027099003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vv9K1YXDXqWKQTLu48Q4cbX2FGnq40+c/Sm8yMSUkXhgavOsaWNkOtkCjPKrhr1jlZcRrxjBHPdOn08dLPSoYI/c97biQqc3O5gupLcVtvlEJ0sZhC/5M1HCBCFJ9UxPjSUB20tjKmPx9nYx886rMyCKBf2FmUm4Onj4rUIAbm3H0ovOYSWt+l5dNvg9tCVblnYcUuoUF2nTlPuPwJ79mdG325W3yw7quirGpF8gw4UPk45j5MM/nDnEwoaIN2WhGP7pnbiLdQnbpJSMdpEPqK3bnm7sKmCBhrdd6hDAgNUaSzKzJiTprS6VwVM+8eMhOPGf6uGAdEARNtVFFUqqV7tBNiYtMj0ntUmQZROP9kUzg/shLAW/KWv/ih8r1ilyqEJm/p5jbKkBC7P2MkQBH9KTLQgQF1Lsfst+/MB3KqNTRJuffsqJ9IbZunk3claP3qwY/FumHXVRUk2bxVTFGGUs0CQ1bQVUWZjeGAvmKHn+RuGLkIr/K8r4MURNcnBiU4XLgds1Li+mnL9I6FOz/+hpC6F44z5JG4sxv1/FijVe/y/cL5GORtBj3BV3ITMLVf7ieLNS0ASGyKXJNKxdmtXA17URpkHXwN9reofq9igScMP4PjS9e8fR5yJNwIhnKkVitf39gay4qzD4GfbBanzDtvWqUIxwhDR6Wxd5JFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(261009223027099003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XwG9on0DxTFbXI+7t0eIDqWTfIJ4AlLXUqdnLaE/22DKVuvLpgBv5o5vtLNe?=
 =?us-ascii?Q?oieuAm+kP1SM0q7kJ0PR5VjqcN9lqRfEmDKTmATGkh8lJbaDp6CC+KvvvKjR?=
 =?us-ascii?Q?utcTD2pzUoJ41NFPmB5EvCCC1SVXg0wN4/TTH5jL9B5gk0xYThGJcaPmRgEr?=
 =?us-ascii?Q?V/UWNXoo1jwJ7wXQkEPyNVjsSyISwPpSfbPHO/ob33i/87h7k/a80FnGp4++?=
 =?us-ascii?Q?YhugrUEuBN5uTCfst5DR9KtMcnyatMahg3tBtOz6D2pw4NAUUGzN9LkB1oLs?=
 =?us-ascii?Q?CP80u1+fWJu3mu1SoqHtoZFRrFN1QC3Jz11csuxoWUn6zBnZ39lavhwjTgFm?=
 =?us-ascii?Q?QRjtwyVyQLiidaxoCOlj/1pM95iRbxpvj7n9TvkTlKxgcZPP70vjs69nIOCb?=
 =?us-ascii?Q?gujt/+4cJqOP/ACQqcHoZF2RImQEH/L1gI174V+XpdQswOOAqU6jcFeD+6y/?=
 =?us-ascii?Q?THWL9bw0+562aeIZh9CRfTO/zLRr+PqPocwwOG7P2qIpEBT5GEplcpqy3mVq?=
 =?us-ascii?Q?iccKYjSFsR8dRyc7DEuA+Ze0XbmvP0y8FJrbOoxxD6n2U9jvf51P+JgagbVX?=
 =?us-ascii?Q?yd3dsGX4ijbV3Iv0gkY66Z9f1kTZ7b1YOmoazTkvaxTd4s5bfd9e7THZ90vt?=
 =?us-ascii?Q?+ky0/YYU+2vvbQvLhxjE2xdkhv9JG+iNb6a/PoaDTb4PSfnj+RRBw8R6tb8e?=
 =?us-ascii?Q?SYyqAFhl4rC7iLt8knS5vGibJUtk0TmvX9WppVC3UWDRr10YhOO0WC8qg1f6?=
 =?us-ascii?Q?7KpFE8gZHlmpjrLYQ0F2WhYB0edrP/Lad0PR9lPnuqT/sGYXEYetJnHuxz5s?=
 =?us-ascii?Q?eViTkiAGvOYjtHnO68i6MsvTxvBiVlQzWqLU9rbQH22BdhueJPnsTyYB3Ue6?=
 =?us-ascii?Q?jS/eJENv9QxVrcBXuikBQ9TwOKsfOSp5AQUJM57wqEz9ooX1va4RnRccwL9p?=
 =?us-ascii?Q?5jr65SM+mOEoMNmdWKzlT8nAg8rtsI6me6dyKK5Qk+jus6fMOBHEYJgFRDOt?=
 =?us-ascii?Q?Dk0CpxGT6QupSkhmif7f0Ur5IOmm/5haF1AEE2vxdiY5H2tI6h2j6GbM6kGZ?=
 =?us-ascii?Q?Q73FCqkBszmAc9lq/savhsLH42X3SMhrDMUvJ5bD/lGhvwOLIQxStJaJvjNV?=
 =?us-ascii?Q?60QDkMFWO24cb14csVE44oivOdly9fa4LZNm3g9NfRbYs+vT7zSWea+bYAOy?=
 =?us-ascii?Q?rzJKaJxcbzI4+p5CnnHOrKLe12x/FYk9+l8VaooAR4NKTGC+pCTA3pPfIhaE?=
 =?us-ascii?Q?xwwoMXj74jfFY3G4xMqudAxhJFDv/jzZWVm7HW39jhh508xU22R4kR9iBHZH?=
 =?us-ascii?Q?BUFAXZGZgM6RAOZtIeNNSKTNwRH/92PniihNZCv4HAnCcikrMffr7TRrKtdE?=
 =?us-ascii?Q?GuYneabS7DThrO1MQRStlYyaqXVo+OryWk3kuaAcr8PV5G380AqOgSe/98XQ?=
 =?us-ascii?Q?G7XYfYOsas/NF6gU5c8ODCkaJbTmVh9ZbFLRFKtUQaAprBetAICoE0fhxNto?=
 =?us-ascii?Q?9gn6uuReYdhnQsPXJLpesFLJzpqiCEL+SxfHKhr9xL0JcXTKIKdeBU+o4/LQ?=
 =?us-ascii?Q?APYuTMRsKu0rJlLwnZYdiX1enDRnsC2EFGOudlblfPkSBFx5kPu4QDMd8UnY?=
 =?us-ascii?Q?n+YGfwx3X9Q3I54LGrXHlYDEKbKDfXICIUfldV0TuPbxyl052n9EMBV7lNum?=
 =?us-ascii?Q?GckF01BKMs4LzJRNNtaRNLX2hGh5zcjfNIAHnPDFh2fBxmCGy5wmWHzl+E+I?=
 =?us-ascii?Q?8LWFvw9ZAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: SgUXVOg/q3bdtgaZukGYmGi7CiocCc8rHMpIMHVXw0DdEsDmESTctWB1bhHtuk2cvxJzX5+05THoZ09uwbk4xagP9muur/bQKXE24v5wUfa/CTdegn8HwdgizbmiX58fBKlE3U4/7nbvPZqhjyZkIUv/2PBFXTnPLnqY8v1f9sCyIcG4P0XUR1ztdYhg3NUlXwgAg5W/gwADg+7GyJZ5Zbb7KE5BQ/AHjlO/Xry9DqvTk/ECH6IyvhoSYj65RH+P+xVQzbqqX/18tBcElFoLX7DsuNGdpM5HlkDkshLGa6UNUUWR4NauvyJM1SGCbAmc0pVXWDIrxxYTn8mX8VK4sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8611aa0-8028-4faf-0425-08df26a20a80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3245.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:42:36.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFP6L9xTrKmhNgz85nu6bFQBiOdLTkySa8fSMjF/DAzkFspVDVspEm3lhc05i247dFuI2sSiz8S934iU8pow9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com

On Wed, Oct 07, 2026 at 08:33:27AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 17:09 +0800, Yan Zhao wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > Enhance tdp_mmu_alloc_sp_for_split() to allocate a page table page for the
> > external page table in preparation for splitting the mirror page table.
> > 
> > When the mirror page table is split in tdp_mmu_split_huge_page(), the
> > corresponding external page table also needs to be split. Therefore,
> > allocate external_spt in tdp_mmu_alloc_sp_for_split() to prepare for the
> > splitting.
> > 
> > The external_spt will be gifted to the TDX module and mapped as a page
> > table page in the S-EPT during splitting. Since the TDX module will
> > initialize the page content in the DEMOTE SEAMCALL, there is no need to
> > zero external_spt.
> > 
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > [sean: use __get_free_page(), let is_mirror_root be const and called once]
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> > v4:
> > - "bool mirror" --> "bool is_mirror_sp". (Sean)
> > - Use __get_free_page() instead of get_zeroed_page(). (Sean)
> > - let is_mirror_root be const and called once. (Sean)
> > 
> > v3:
> > - Removed unnecessary declaration of tdp_mmu_alloc_sp_for_split(). (Kai)
> > - Fixed a typo in the patch log. (Kai)
> > 
> > RFC v2:
> > - NO change.
> > 
> > RFC v1:
> > - Rebased and simplified the code.
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 001449142d32..f3311317a63a 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -1466,7 +1466,7 @@ bool kvm_tdp_mmu_wrprot_slot(struct kvm *kvm,
> >  	return spte_set;
> >  }
> >  
> > -static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(void)
> > +static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(bool is_mirror_sp)
> >  {
> >  	struct kvm_mmu_page *sp;
> >  
> > @@ -1480,6 +1480,15 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(void)
> >  		return NULL;
> >  	}
> >  
> > +	if (is_mirror_sp) {
> > +		sp->external_spt = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> > +		if (!sp->external_spt) {
> > +			free_page((unsigned long)sp->spt);
> > +			kmem_cache_free(mmu_page_header_cache, sp);
> > +			return NULL;
> > +		}
> > +	}
> > +
> >  	return sp;
> >  }
> >  
> > @@ -1527,6 +1536,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
> >  					 gfn_t start, gfn_t end,
> >  					 int target_level, bool shared)
> >  {
> > +	const bool is_mirror_root = is_mirror_sp(root);
> 
> Nit:
> 
> is_mirror_root and is_mirror_sp(root) almost even read the same. And the local
> var is only every used once even at the end of this series. I wonder about just
> having tdp_mmu_alloc_sp_for_split(is_mirror_sp(root)), or even just passing the
LGTM since is_mirror_sp() is a "static inline" function.

> root in.
 
> Otherwise:
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> >  	struct kvm_mmu_page *sp = NULL;
> >  	struct tdp_iter iter;
> >  
> > @@ -1559,7 +1569,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
> >  			else
> >  				write_unlock(&kvm->mmu_lock);
> >  
> > -			sp = tdp_mmu_alloc_sp_for_split();
> > +			sp = tdp_mmu_alloc_sp_for_split(is_mirror_root);
> >  
> >  			if (shared)
> >  				read_lock(&kvm->mmu_lock);
> 
