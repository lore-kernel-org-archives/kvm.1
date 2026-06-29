Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AF3B52F0;
	Mon, 29 Jun 2026 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720780; cv=fail; b=BMo93NEvN9m8n26rcPEsClYjLxPO0mRzb+LFFyt/3VQOxea52ad1Mw5bdQQ5+//FwIL9+R5lX24AG/8ECynqJU7Hi6Fuqd2R9S5J3SASWF+/0rtRVjplEbN8Y5yWFHVk9lN5IEIB5fT8WZk0uCdQtCS8D9DCjEJNGSzdV6GFXno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720780; c=relaxed/simple;
	bh=ekndbhI8pOCl4KT4gojfAoilCA36h/bV7VW8UJHNdQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ydc7wjmQB7u5ah5URQXxRZkLYWJzhbyO9R1KQFWL4hf1wO6JfoqKz8skl9gdbd+9SMN3jaEz29xiNqe2TyMw9lpVhxZKMtZb3G7BqHqazt77CqCvjrZrRUsCrkoIGtV6mQ5/Sz5ElJubD0jqpBhKn+zkoCxh9VTmu4CMQP1luvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZCzbYjN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZCzbYjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782720777; x=1814256777;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ekndbhI8pOCl4KT4gojfAoilCA36h/bV7VW8UJHNdQw=;
  b=kZCzbYjNmCpnS3mquo+quDG6/AnhiT9w5/Syf7/cKuGI6uXxLAru9nLj
   Bz9IdYnhgGHcaowAyaHPfsrp+DRq5owyUG6AMf3ism11u4y6ruOBj+IN7
   eg7MNTbL4HddN1EwCUZDSFLAkKRuzN/Xq6YSJkNYfMMUgggCGgQz3EN53
   k6vr8T7VmIRK+o/A0mQhZA+R6dIqS2xLmoOGj7d60u9bSWwuHdonkey1E
   M+WM7GUESydWRFl4w1gUYnRWy6XksQIGXPf+G89yySJ+ZDAExG+WSIkPN
   0DDehnW0hxLawYf6PX4urRnKkGHFJj8Ejx5g9IyINyOkYEAO5tp+uUJNO
   A==;
X-CSE-ConnectionGUID: 6ttSydX/RZ6Hl2UI++Jetg==
X-CSE-MsgGUID: C8TWD5jXSZGKHxaNSKFLmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83172663"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83172663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:12:56 -0700
X-CSE-ConnectionGUID: maEUHKHoQD6vOyUGmPvJog==
X-CSE-MsgGUID: uPi2m2gTSwCXZJrZCRghsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="255490636"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:12:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:12:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:12:56 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1Zs1f1myw83yPhYVJaZ/svZkMXgPoHFU2zzefQTP3zqmKbfmzFlBLvTz3QUOnwf23goa/W3jgLnZN5V4Al+NVR0awsRDRwnYVC6btlX1bfc1Kbpgykj+Hz+09FJStpa3aSQVzxcyg16rIC6iYP4jicq5L5ad6xNuAbZ0ppkenL9y4otxvcKUuoqQbzjOWM/AMSgsaeNNHNba6TaYY6iPvO9f8ccYa6ljk8W0Dn8S6RtHQavMHSsuAJjn46gAIYYnCC+kkWQXrju/ilaxqGQuGn7nYSIMoilhqgS3k6WQodxF4owG5mMJCAho6Wn1Nq3+8DJgFtRjSrProXsOTCteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNYHv6YQ0E0GBc2KOWQFEtbFHJ9SRpFDqr1DgcdR3bc=;
 b=nR4sMCQanWCtEt72XihzsxRV8GT3p0Sw+r0TT3X79VEz4Vpz0gYCpG5v9QMaM/0OabdRQl9w3cE1Dpneh7jKmrHwqCKLfN8HncQFm6uTU3CYjCwSC9Dym65gM4WhGyjPtoCngkyBlrajzSy16zAC29MCvgGMZw5L+IzdsdasBIYAQi/3iwUQIU5yEcbgYb4+af5ENGRjaEBLY6FXvxjiGCz18ZnX+1zcFagbAOOUkUCOjKoyPCHXMxvPjW5kYqJtDXIwsebFMxno3+Nqa5GOqLxXSJkuRdltm739v1RZ7y3h2k7OXfu7jFiaCFOlnTCOaYDbr8wsPHYTAGRl3l4aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:12:53 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:12:52 +0000
Date: Mon, 29 Jun 2026 16:12:40 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <akIo+E5hfQL7C30E@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-7-yilun.xu@linux.intel.com>
X-ClientProxiedBy: SI3PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:295::14) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|SJ0PR11MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: b33d7732-dce7-4f18-0e0f-08ded5b637af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PSZh3qaZp4C4AvsRfgxNrKJRP/Ry0yEZaUFeW2Bi8d6+kky3fMaXz96NZ2W120OqE22wPhsFAO4I8TIu9hWjvEmQPJOb32IXtaerhToyf1GYp3YWfgSQ4zDsdjVWpfqOvTN2r/5oytXvOEIT+wZip1aPizsIxcQOliJrmdzFP6v5AsXseaNTgsg7nsR9yxnGrTgEUSPWBpLmsWVzHZrI8Uy20RwOu7kccJw7IqlIduDCS0PbmML9F5JQCUlOW7hsFr7vIUmxMC3se+/u1iBrGgbZE1wi5Ig40YZaO/lWioYVKbKOabcWFTDNPnruFGJu3O8UAG7hCvPobC/jApMOEXZWPFSeZ5LkKGIDbX9wEFv8TSiXK6x0TCludUHVSdO4jMRZSyTtPZDAKYtLatVF7bC8ml2zYfvAsUSfaZMlnL26HNn8LB+z3fcTWLMgxl6KwwvWhJyPBrYJ90LzufsYvS1WSAPk/mGJqC2U4JvkOW0iflxjrACeAr1T9G3F5pjQkTEbPAhZElBrjKHp1aOJplWRtDP+286TSV9mcgpPY3juIguLg/Urx8LpCiOnFY9jNQGd4y1DJIUdRnCqjmkAN+4GlJtgoQhyeA/oXIo3dpE/zYAL9woS4WXO4nF4AfIIjsiKJiFLXzlaBCft9qeM2feWAs1z0V9mgwae8RsqE9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYtYSAjaCBdEeAgsA2xkzafc1Oy5Bx6eDqIeXRj+LQxnKrKbGoFJi6UyUk54?=
 =?us-ascii?Q?BbyCgiba5CfFrPP4IerSYI9VsBWWjS9oGNf60M8vs+dCyqubGRW2n4SL9GGj?=
 =?us-ascii?Q?FjYk+dd1LsLuQvhPHZ+Jw+I1GOE8gPrztsMeMc1rypcjy/QtRrqEM3efrtHd?=
 =?us-ascii?Q?IhQhfrXDfRDtIIICcHSSRuqmqAu4OYfQt8/LGOuqClCAVKuMbeWahuje5ult?=
 =?us-ascii?Q?9VJIqczoTEwz80M+LhHLcktsh8/oK88Y5grjpMjhgcOw3qfOfOW24wo+gPbu?=
 =?us-ascii?Q?Z6IpbqgXhtp0hEtpuJ+V2QEKEVTO09ASxMUzoxUCuLGLaPzOLaqh46VhiMIl?=
 =?us-ascii?Q?ekUTw8PZUXsFea7bfhCxFqsu0zsfdyl7RFBmoLFKOWkfiEbQ3uDm/aRuQcDI?=
 =?us-ascii?Q?bXZE/UBMloHKhnJ0uu0mfQK/gZirzVL83/HSkRfSIUc7AHrh5tTYYH7GUek2?=
 =?us-ascii?Q?i8JSVJ8n6vzOBd+o976E8iLU2TySh/ytkAF2pKQbxMaLlIfLvEyR7nNNIhlj?=
 =?us-ascii?Q?tiA2Qa/Ci6+Iu3/dBCF3r1AEcbjnEZ9mD7jT8ot8aonz8vBPTiHdYWkBAy0n?=
 =?us-ascii?Q?cIZApNPoXHrmYufJtfVw+zphN2/YDpgo990W23/jovbsu8X3P2WiWoqYcRw5?=
 =?us-ascii?Q?8G6dE2hl91D8qNZCogA/8Id3U6OkNrVdS54r0+5gweQdiNEkAuCoPv//KLJX?=
 =?us-ascii?Q?qm1hWkZsbaJC7utbyHnzU9zP2ZgzS9YT+fDRDw4s7gMPL0NQjnQPrpf5U7At?=
 =?us-ascii?Q?QF3kmrgNHN0s07iMkxELWdUP8A6XGy6sW3lfdHXmXNXSE5Pq/98r5DP5Kbl7?=
 =?us-ascii?Q?gtQJZkwHGXz/UhpFcUBvgBM9gaQOtx3pz34dZkGRn31XzvR6SipI1zWEMTd3?=
 =?us-ascii?Q?0lwyqcHLCHdVqTwJFnD/3WWD1nLfU1CPkcleIL81cPjgqZtYMqBLc8LiJGDb?=
 =?us-ascii?Q?MMliN9mKvi3IkYln7uwDUiKYz3grLA5aBnUjbw5XfieWdArU3DvoHvhuVUGw?=
 =?us-ascii?Q?56N0+TrtQGtPjxAqxWTJHRbEuW3pRqipdL2JEFz4HCE55q/jkAFBAnxd8jZK?=
 =?us-ascii?Q?xZnBX50rCyVIQIqkZEFUlD9TwqAjH19SDIeEdbyW3dT+JC2ERWop0zXx3nJ5?=
 =?us-ascii?Q?dIlaf/zOz/abn6I2TP0kwz9LojadYPkw15SCL5gSyH5nNLsfknWYsjUQ09z4?=
 =?us-ascii?Q?SgkMkhwc18r38/ugDDSyOoIF9WCEnHbMdSHalseqvcp0UaPDR4xLRLyJcjyJ?=
 =?us-ascii?Q?LivXhlpEj9k8wucBeNwvOB5IQ3ep30dxXN4IYJcxLJVhlB2O08d1JwfSbfeW?=
 =?us-ascii?Q?b4Nc2GVrvfltc6zpVPImQqRiBwSRh3S0qLl6/dlc8zshDwDLei1KdJJMHe52?=
 =?us-ascii?Q?WfTLncEl5/LiRKTDhx/YYUWPJ7xpgnil90tkTFx5lyDqALh5G78eDBzKDi1z?=
 =?us-ascii?Q?5irHn5eKM7Z7aoCH14P7pgck1IH1bn7TiHUNpW1/ep8J0/KBvez1aYMtuBN8?=
 =?us-ascii?Q?UhkOrGHZsqBuQpo9Ps9jhya16XCVLLG5GFsU2ME39C/QE8D9Lbx76iu+hF5Y?=
 =?us-ascii?Q?WYuS7H1KXl+DYgmItnr5i/sVDCQN0S+eBeMe+og5m4kZZJ35FNrF2HHrVPuZ?=
 =?us-ascii?Q?1VM0AaVW7FzqiLYthd+MwR4WzA1UpCQkGOlXeysUDEEhApx+ckY0QcTnyAs2?=
 =?us-ascii?Q?4o+efuQxFjsvOwAhEOyHN8M+/nyT0WllXqJHtAMMDeMlfecgCW/ti7mXGehY?=
 =?us-ascii?Q?J9yIk8jKsg=3D=3D?=
X-Exchange-RoutingPolicyChecked: MmaPIqz92DUgXGWl+vqS7yGQ9ej9ZYmRWgR5iXlmMDy7Fa2Wu1GwIWx4UiRrYwM5gzo03tOGpu1EBlcm3yHrWdYJh0YqFzFuQDFhoHFXWXU1UpWeAkaZD7pLmIREgaRdH1Y0XI/rY8y8XKl90qDwBPoAqpEcj1afxUHZoP1mofSPuuj7qgmGaOXhLQuDvlr2uXJs9e1FCv+82VcUJSRs+/e1fgq6tknS5K+vQiX/I8hjxrMI8mroS3y/Gk/t4q4x/9v5SC1d/vTe6VNmzxXzDgX58/4sUX1tmjGTNE1vexqMSgyO9yyF8u4TIIes4Kryk1Dq4h9XwS3CD5x8hA8NBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b33d7732-dce7-4f18-0e0f-08ded5b637af
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:12:52.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 115DoHB/PRrjHaaMCk7F+uBagLnJlWE6L5rw7DC96K7Wd1pzg++hGkL/Kam7RkKhQ3VBotUL4Jk1biW0LuFrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
X-OriginatorOrg: intel.com

>+/*
>+ * Mostly the same flow as init_tdx_module_extensions(), but rejects adding
>+ * more memory.
>+ */
>+static int update_tdx_module_extensions(void)
>+{
>+	struct tdx_sys_info_ext sysinfo_ext;
>+	int ret;
>+
>+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
>+		return 0;
>+
>+	ret = get_tdx_sys_info_ext(&sysinfo_ext);
>+	if (ret)
>+		return ret;
>+
>+	if (!sysinfo_ext.ext_required)
>+		return 0;
>+
>+	if (sysinfo_ext.memory_pool_required_pages)
>+		return -EFAULT;

Will tdx_ext_init() return an error if more memory is needed?

If yes, we can leave this check to the module. And with ext_required
removed (per my earlier comment), this function simplifies to:

int update_tdx_module_extensions(void)
{
	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
		return 0;

	return tdx_ext_init();
}

>+
>+	return tdx_ext_init();
>+}
>+
> static __init int init_tdx_module(void)
> {
> 	int ret;
>@@ -1498,6 +1523,10 @@ int tdx_module_run_update(void)
> 	 */
> 	WARN_ON_ONCE(ret);
> 
>+	ret = update_tdx_module_extensions();
>+	if (ret)
>+		return ret;
>+
> 	tdx_module_state.initialized = true;
> 	return 0;
> }
>diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
>index 720cdaf76492..84364da89649 100644
>--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
>+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
>@@ -132,7 +132,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
> 	return ret;
> }
> 
>-static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
>+static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> {
> 	int ret;
> 	u64 val;
>-- 
>2.25.1
>
