Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA323426D17;
	Mon, 18 May 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108283; cv=fail; b=V6svinCQsu7FLVkqElaVULyDZAWffodq2lp0fdpv9v/1THbv1bqdu+3MNS43F+rVdKG7Vp7/8Y1Lge1rD4hu0bbNmyHlSdTQcaYPNOpisRIj+g4UnWBX4v8JwoYGo6j8WG6jAnNDS1DR5T4NT2JT77FScPurStWC2wDSd8JSSbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108283; c=relaxed/simple;
	bh=k2gimiZtIn/CzO4eX5oSqprs5pEjqIs84BAvsiRPIwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqxY5Ii0KgwYZ1FDyOK0PxkvT8q0Bzh5t1eH0ny/UMn/GII+ffsY3hA/4vVpmwvH0mUZxX6kiYktlINJy/FAHVzgz47P6LgE+nMTYCCSd5Gdp7BaSxs4Lt6ynpG5pRpGjGZj4jAiWn7pt+xKh14rnw7rN2KARZk2LBDJ6penZwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6zROrXX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6zROrXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779108281; x=1810644281;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=k2gimiZtIn/CzO4eX5oSqprs5pEjqIs84BAvsiRPIwE=;
  b=k6zROrXXUjhtqPjY4IvnZjlHxKnW0Pu5Jq4Uvv8WOG3xA8M14AxmDcRN
   dvEYCZLu/VZXTJrjPBN7O66qdU2TNS+MFxtREZWtimYPyWs1Qndp0oVgd
   cVHNxSUlCnKmK5oQq60TYLRwCi9MLthcmqc2+yYMJ+j/k+YotVFcG0EaE
   bwQpzAZXiVYgY16jGI4aUZrIZ13DNkz29VDg9cY5Yr4ewmqwzt16AsPhW
   HDaM4ujY4JJJStj5OuuMryhcBQ6/dVjh+vzrxcEhum49UeiFg71GoTm+P
   qNB7/P7/qctWP4001Xa7k7kRfjCCcqsnEfNv8DIH8BC07eyzh6WWTslKB
   g==;
X-CSE-ConnectionGUID: 806eISc2QFSJi2OKNnh8Yw==
X-CSE-MsgGUID: cWWx3tjiQ2aIWxnfLaxCzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="97527288"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="97527288"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:44:41 -0700
X-CSE-ConnectionGUID: f8S1Ed4WSsqwfjZ8T2Jgxw==
X-CSE-MsgGUID: PdTu5WW0QwOuRuNyYymBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="238419793"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 05:44:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 05:44:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 05:44:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 05:44:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULLV0oquIXHzyjQxYils+sAUZHrRdMkzSe6ph97aKDlrjurGbqIbs1iQ0+JarAQwFGBywZsDtxSLyIAWarZIHQdaa9A5JI+C4EKxDx/44V2IcP6lhte8/ODfVFATqwV6dRPlpSiQ/drBvoeedO/QFF7AkqobjB3BZ0SKEdptiFo5sHr2bREcBPmkl0SK6Ingm1KKFzQW33ijpLFlzr+eRZ/JZx3KVlL8Z9wEfGONCQETYWLFQX6iZKon+Iglaxgz0f6XTHAgehVJTdYFtiJEJBmZVvzvzS26f+PCmC+M2let8Id8FRk6X2LqqIh95jQYnmiqG1947ktLNLYjycTG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exefD5v02ZMLg6Z1O4OzBHBnEMOjNv7TIb3vFox6oGE=;
 b=XbbTGFgOVZxjvlhb37lCoRsChyU5Ft3Uvy16ZIDth7xy7OrCfQGuw4bRf5iMH7Tyrbfry5K7nXzoVuKBI3lazjbiNXhs+ob5hHV3HxjpUeuGzKCqjYRq2hnygBhQ7KtEgg3Tqr4Ck6jG/1aooEbYxU1jkd+l8PaUOuS9Fl1TxVfHMSxWYddijKgMqwDFQh6VeUia9vqfWYroIXXVJbBUqb42fcWrQvJkUIP4ay+NLeV+niSPliO6E5RCjfxZE9V1aHVKW/igmwln+vOXNrXbzDVoOqjrmLx2BmG0X8FGoQZSK3401Nrh1F12foGLQb8Tfr37oAsjW2c3Eeh9oUSmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 12:44:34 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 12:44:34 +0000
Date: Mon, 18 May 2026 20:44:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 09/23] coco/tdx-host: Don't expose P-SEAMLDR
 information on CPUs with erratum
Message-ID: <agsJpjZU0kbsY3oy@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-10-chao.gao@intel.com>
 <f1057429-4918-4b02-ae17-9bd6cc38a3c1@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1057429-4918-4b02-ae17-9bd6cc38a3c1@intel.com>
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cceabc-d35e-4b83-f55a-08deb4db36cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|4143699003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PClzmolQavy9JUfIGazkJ9InwlNZ0ylI0h1sgb7PHcZaytE8sMsjEO2jW7togJBYu+w7sCSMMYyZ3RjkJrFcDYhowdoIcojAX6auAWXjunTl+5XIPl0Wr7SQMBoVPbYqTh5BOx4pBVqRJL06PjQSA/gcl0kl+ZTsi6nYYgXnoE8eM+DKElR99RDq9UK8ZsiICqmR99XvgtYpntpLV9xUsj1ZYUJtLOzWms/Ud/2pW5JvbwI8VF7HSCMab47osa+kTbjrSukVtv8HtZRwc+J8UxTG+sTQ4owIsEbxBhGKs77XoklqK6lMizBdAn/LGV6bnOJJZ1upOBcz1rd0wJA5xG6ijzFOFF/MJW8/4tZzoSL/UiwgDAe/mK3Sh8GeyS72yGpy8hmHpVwVJDYeeZOIWeq3PQhVz1pF9nM6ah5vhE0OuW8E6UMw7QWfYoA0FDVge0XbR1KKiM+mnwDnsgVXaOUDE0yNiQRCt5Qnpv65MeOoGqYuNjHYJW6E0MIrR2n1kKyW+yqBvYn4/W9AbdaJM7M0uA0Ol3LmfkSlcjPrJcvgYwlZyjuig4+Du9QAzTYoKumTytMlP8Fl5VulysJKOial3YwZeOtf+AAajgqesBxZSfMnsq0QIPPWfK/mr5ml34Am8BlR3HV+k/9XBYxHIiv93SmFWcXVtK1LDgDlN0QKSHk1y/Ug2Yf6YKWlB+Zf/r+s4fg3PJDjf/En+kfLiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(4143699003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8AcOXW21OyMJy2knGQVdL4vucKU+NkhcQbmAnFURG/JTE4ntlDwyEcgoJ0?=
 =?iso-8859-1?Q?3NDnp4oQ8Fa34BYSmDlvzKr9Sutl9DyLHCebgyJqI+r1NBDPKPS413UZK5?=
 =?iso-8859-1?Q?jqBeYK1J4z7cHFdCBSlU3n6YivVmISzY5fjhdjWxNvNKSNFbBTQPMEq8nk?=
 =?iso-8859-1?Q?ZX1GsV2sOKJAnLg5OVpse6hjOgfmWXEQ2QHJFWhK+BtX2QwWwE1R1Xt/8S?=
 =?iso-8859-1?Q?XpKEdjFvFF/Icev5qqzHbjvPe6aIVoLJcXhNqRetzgVTC0W+fUPCympHLQ?=
 =?iso-8859-1?Q?gchc1PMPI6FZDSeOZh1QE3F2/CgJLScB59WtRvURfs553+LSkwmWBUMDJp?=
 =?iso-8859-1?Q?4vweuje0Bh8tXXwX7c/QaVGjZHfwk58E5J8MrUO6gpsvndjkW+YVJJkWfl?=
 =?iso-8859-1?Q?xasxJmMNTU1UaLsVYWbl4rHw18mkDQpcDENmBQaQcde2JSQ/h9gyulwFFF?=
 =?iso-8859-1?Q?aaFaGqYw6lsvKOaSI0xHL9wPRxlYxAQFrCUFzfbUZ4WaK4TX1tGUCJW8jb?=
 =?iso-8859-1?Q?5urUL2lt14SrrF6KQTCKrl6HConCHlLJZBchczagycK63B2e+ZM7yvwOfG?=
 =?iso-8859-1?Q?/djKFFwCxfDmk+ZichVFpwW5346tI5nO6JyOajYqWBlQY/ZldYYhOTI8c1?=
 =?iso-8859-1?Q?rKmERQrrc4x6IRBEoA+Y02DouueASM8vvZ85TSWM8aa3l4yGRT5l8OGWWT?=
 =?iso-8859-1?Q?36F/FntyWcCHPAUcHl5WerkW/JB+ws42jv/NFubp/VLQ6IrhicHiLZJjFk?=
 =?iso-8859-1?Q?NOWFatx9vIursnf23BzLPul+HQLWowf8sMWV6NWeXWvy4hhE2ntT0Gv3ij?=
 =?iso-8859-1?Q?XLZCd11W43UrTkd/UiReBkb5anQi/4zbd96r4eoXPWjDeofvIVkKt+QYLB?=
 =?iso-8859-1?Q?gTyir/z+FADZ7+1vA9Gg94mVQ+uGQNLXZtow80FuG4OkFAx4hk3cuXhyLr?=
 =?iso-8859-1?Q?kPm7DvFFPukPb7kUn5vsbIh6KyFm+B2jsMR0849T19EQZ1ZOJYFrTAj1Yi?=
 =?iso-8859-1?Q?Yf534oBsgP+562SV7hIiTDdc8NKjXWGUOyUFDjA+HEtpas4cLjRvaRqExY?=
 =?iso-8859-1?Q?FrIqbenddQpDpJ6Ev56ZBrn+S0AjQA4+5/H2pJmfClygh3Nk2s9Dwdy9hN?=
 =?iso-8859-1?Q?pBeiBFQ5mDEAYWRUM5SN6wGHN+lbhiM748Aeu1nDIEbwcc85kcCDr51xaI?=
 =?iso-8859-1?Q?La/kM3h273VPmdiBsnmDiRlYy22S4oK7cUGnOkPHVpfcEyo1PnoZejCNFr?=
 =?iso-8859-1?Q?puFBFNjY/X6UHlEAY9E34nFyI61UdEpekjiddGWU6RngCn+rQn3pw477Gq?=
 =?iso-8859-1?Q?p+2P6j0ACz9ktaUexP9Fu0hvbDJktVxZFf39V/R2eFzA/jxeh+mE1gmZaQ?=
 =?iso-8859-1?Q?NuMe+nqVXAtvUQ3xPzvNiHm5fobvslJL30zIqzcbjPhJJZ0EGACbgs+LNo?=
 =?iso-8859-1?Q?VWJJcB0l4gqSx5kjBV66cHfBvJM5Xn57mn5HIxInfVVLxj3YFE0s8zpaRZ?=
 =?iso-8859-1?Q?PE+gwoBQbvSbFB4lrGMbNShPBHGIgcVcpgkPKKehHal8O5EqBL12ygHpsp?=
 =?iso-8859-1?Q?JyJpkKxzHkKl97cs7u4RavL5yVGk/E6oeH/0HZ+sdNaAJry9jTeYjmbU8V?=
 =?iso-8859-1?Q?PY2sHRMipVX1JylC2HL1h2Ot4MkmUayMN04Zpc1eyqlzPuLXVwMUZ3fOGR?=
 =?iso-8859-1?Q?e5TQMrIe34NwKvdd2m6IRXt9da3kdOd96g1wHZve59vd+GOvuPTliBmXeO?=
 =?iso-8859-1?Q?XBZXPvsivYOqQH0hj/77+keb7Pif92rhDbiftsS6Ck3BoZC+LhjCkh0f6O?=
 =?iso-8859-1?Q?vyzfTiYcPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: imP02u91LbD/PRhIeOhue9gsLHXUzHl1iGe4pKD8JGiHnDBYrg9p4cwo9FOZGb1cuRQZuokbfa3ABiIQpDhcYvOdECc/xUom5BjfaP8W3Fcrs53QiH/2ntNEktuLERP+bMJ+lWAxuVb4zdSrLCHxPuCXJEYTsx+b31QOD66BdNfb/Ebv3+0061Uf2r5TvXiQUl7IY5b1VwTVDDQmcmkVcgO9FqmxpHJ+0Nr/e4n3vGWR+QucPC2xZj5svPr5frNSsfhMNTEfkoEHEQNgYH1aG281V2Yr5ONLe7eUGp3TOGyjqdqm7RZ3mQBrCPl00oVIz4ecpO25TmGo5ycaWE2grw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cceabc-d35e-4b83-f55a-08deb4db36cb
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:44:34.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kar3mnm8BK7y+HAhMrWqnqT+9b52JojxSgMyZz8NYXIaISoU7P564uQ02jHtyxmiZveNoe5+TxW6I6Vg3FPJVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 10:26:19AM -0700, Dave Hansen wrote:
>On 5/13/26 08:09, Chao Gao wrote:
>> Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
>> Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:
>
>2021, eh?

The TDX ISA document has not been updated since then; the May 2021
edition is still the latest revision. See:

https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html
