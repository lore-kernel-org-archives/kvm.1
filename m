Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098842CAFB;
	Mon,  6 Jul 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341098; cv=fail; b=KOl4tmQ3SyxL2vcLOF1Rlv+rxf2U34mB4We8GHmvMhtq8ifYVqh1Cj5+oSpkPA/XuiNGTCsiEpDlndj36TaVZif3jJYUkrvW8DGMdf+lfDs7cik55ZI0ucP9uqamq6vL9UM7Apllqfvsa6DLJWJkEyiJ44OctmxmHHiAb0dO0To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341098; c=relaxed/simple;
	bh=EaxA4Klq1yBmCWQWs0xH+gx8ERx5ZNwSgNxyag0VT04=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hA+R3Zt9nZyV0IM2UJ2JrF17yN0b7Dc+R5h8CWhxvurVo9QRa4U3wfcpyTaUbXMIhFro2/R89PrgHJA2nJtcVhYsToGT2fTUYzk7UlzXKxKpCnoMM/t6PMKXLcMlEUBh51apXH9rrLqewjLsULEzZuRZtNczIEz1xQfK8bnXqSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpYg4Ohc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpYg4Ohc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783341095; x=1814877095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EaxA4Klq1yBmCWQWs0xH+gx8ERx5ZNwSgNxyag0VT04=;
  b=hpYg4Ohc5WYqnhCWMr5FxMD4MtaShOopY2FVuLqtGEmNc2Te+rP/jTTi
   I44r4EEnWxqjo2s804N+uzlicdJ0sSAuhFR9W9cneE13Dcbm8QBQEkQy6
   GFm2ZB5DaNkzVRVui5VPXv84/PwFhVTd1ZURHjNB5YU1IS0Rkf7g6k0OU
   gV+ir2g393VFWu2N4kRPAB15YAcbGlL5oUIgtYVjX5oxDV4X26Hw/Ee6l
   f/5uUXnvB+LmNuDsYwA/rQ2g79FkdHYg1OoiDLOtCpBlH+sB3dfRV7K0W
   bGCoRo0f6qtREDmts2gK5zMhHSDnvfwBuM56FkCNRK6C+2JAvZ1CfbW2l
   g==;
X-CSE-ConnectionGUID: p1SvipluTMK3g0v9863JCg==
X-CSE-MsgGUID: ctLM5sEeRF+59t/P/dHW/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83842479"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83842479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 05:31:34 -0700
X-CSE-ConnectionGUID: ewt8BZI5QwWQ3OpT6p2gXQ==
X-CSE-MsgGUID: u9h8BQCmSgipEp7d8WDC2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="258605050"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 05:31:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 05:31:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 05:31:34 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 05:31:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BntBuSBPU/9FC9acCGtKy/95h8TLatq3reZj6VJ81A+n4FAv5+3GQty+iDUuHPk9YbcZvrTH2xlVEOYqIZMICQ0mxOpWOUtT6nOeY0giZKfIt+Q2008Hj5vjxqvWvBF3FgRq2DM9/MgpY9QthrUuLOp6LJAKCxKXlLEh+LnIcfTgHFD8HPt7retVB3Nd682P8UchXQ/wyKeLl4CoD/esRFTqrOrzJS35xA3sddUloayoe00twoipuhJUFeZUDXoCzFHCdfF2WARlgnCDhWCuzfwqz/FZ8jxmz2o7iA3T4Ny0Rcl2ewIbJHF2KS4DPe4a4sp+pmmwS13GPVnOyAk30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pulOmPF7K57/tpvfqz3fRgUJe8C3SPYHht74pz1U+v4=;
 b=KsuXFaW8qUHvKrnF/hvcwjB3kij2wv58npo3O/jmVIyVtdxgiu/AVTvDtKxuiwV2KK/VYA6vJMLtny6ULI0YNI9NeM9whtkhhvww7YiFsQPr+sDzzd15DpENniPODWMLhBRwhqmeumEBFwlEhTriR1ocIL4Qh2sMFpbPYrs6T5TrxI+EE5tkHpktXBJMZptPR9YufZJbxdltFpdUOZZfgMudxqbEnO+6prrVlUoFV5ROky9mxJZBXVsDwIgNlCLfXSqKm724KlRy5b+mObPvgPnmj7y8Ajey+fXVpnneMGDUig/vwrTKGApHeDllU6+PpFOrvA7LqOarmT8OLVwoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH0PR11MB9773.namprd11.prod.outlook.com (2603:10b6:510:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 12:31:32 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 12:31:31 +0000
Date: Mon, 6 Jul 2026 20:31:14 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Message-ID: <akugEqMk29Q9DJUY@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-4-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KU0P306CA0017.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::11) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH0PR11MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d70645-0390-406a-0cd8-08dedb5a81f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 4/GfDWUNwhcFrZXDhzjPFR+8PR1M9srGxz1oV2Et/HPb4GHAUhoIXSuz34VWEYxHeifBT8/HRlFdotRusRqz1vwYrJyDcdAujCbKY0tJLCXx5MpIA9Hj4AIThfpAslWLgQUYrVb2MnOdUSWe/DaQmdL6Dg5prTaFHEWhax9xNkzy+9EkQ9uMvsAHBNw2uhbPmJmR4GZkytnleyRnu+vwxxMJDcdx8XnPGU6TOViC/UNgMQ5vYIvrk2vmn61cYq9R5jX97si7jeSdxN1J5k8yNcOGEXq/3AAsmmR+D3Ta/aIrwnv9u9e5Iqy3HAAzFES4d9oIEKDZ0Euw2zJ3G1IR3MZumc2/XpfF+pEqY2wTjILugDGuhZZ/vlWGyKBqbT2XQnDnRkECEtGxL4Gw1JtQKFGhvu93tSgDRamMYVw/9yAX133hPa7Eub/zVJzn7WZmtdjx1Ro+5Jne5DeTqaNVGMYmlqtX82TW6Rfc2PAlPOcI2bjG4eaUwpj03mcJkXMDeOAS+RhXgTCAbl5EGaUTncuBM1kJyqnbWXQATIf2aTcIxnsPRpveWDYYNDpSFI3lFUuVBodyHDNzhV4KxHZxsPrC39f5CUIPWK7bldXTktt/uLqv6ajxO0Pv548uPg6Wzh8X6tffHbnalb0UVusEfXQuzDYu+l8jhRyTc1DTilA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGPKlcDEvFRCroxNk6tImD2OgdFc2hU84RAiEAsDx64sy3+a3A21CCR/sBZ5?=
 =?us-ascii?Q?qAhLQm9alcPooF0mLk4+/vcHMRC35+rYoKb+zh5u2C2iKJZK2Y+eprc1yRfe?=
 =?us-ascii?Q?lo6P3tAY8giur82s5ZB+C7u1PoG6jazm/fxPdCFOwNsKtN/lOpZiQaQ4LQip?=
 =?us-ascii?Q?es5Gsw8JrssrQsHkhHMWi+//mQ1ujhU2+KT11uE76yU9UzfwqziIzgy0p44D?=
 =?us-ascii?Q?X9/nMr0+cwkPUN62NDlaeGMzWX0jCrlyhcI8ZuB2wYoyFF1yTLlO7/HcVwBm?=
 =?us-ascii?Q?DSmqygkrE17rc8Yp8At8ObwbM8eoDn0tVh70bD+JrFSizISGjcYeM/P7RnmX?=
 =?us-ascii?Q?DV16YRzh4hDa/qeMvXZU/F4mTs6woTrhhxUirck8RMl95kJzgnclgKUrvksc?=
 =?us-ascii?Q?U+DZ4p/odWjV/ZE65FIL/8q49/JlBlsn4IcpWGtYrm1xXLynsU+crZ7YjYqS?=
 =?us-ascii?Q?9tpC0yEUJ8wPxYweY1knpUVj7tn4Xz4YHex/Pc+s7wvaD2B2CbEtKKxJ42Lg?=
 =?us-ascii?Q?1b2mcFnvDyA5R3Wax1pnn0kHJQjXidIbdGpLkcLl4Owzk4LHzVLA2xuXj8mE?=
 =?us-ascii?Q?GkbeKhxO8bXGbZSlrYFu84e/oeoda82IcDvoH21MT5fA6k6xx96lRaOheQTx?=
 =?us-ascii?Q?EBe/B9Z2otRZeWdyhIwcvDad78eNnj73HiXumPD40WjPmRA3huP9Din86guK?=
 =?us-ascii?Q?c60fJpt2XmM47KWwByKiN/n0+V8stcOiql/uRU2D8jgTx//tMaf7yYPHKvzJ?=
 =?us-ascii?Q?FBvBlBgVAx0fFwaCyiNjlQrYkn1QZDDh9zMQ0H9BVL2dnyUMKsT+yVta4ulm?=
 =?us-ascii?Q?R+2QmHELfF9nbVwVzdFmeLfaaFqYh/Us6lx3QpenpZTlJJ1wHlaVvf/HiFmL?=
 =?us-ascii?Q?y5FgSsjQIOxGqSWG5IbLPctVTnvqFYJ5ev8PitOHnxvGztVrKkIpPB7bL28A?=
 =?us-ascii?Q?0LRvBSwS0UcasFpjG1BnG2eduBgnM6GLpJY80mHx2FUNpitTohZo4vPwmoTi?=
 =?us-ascii?Q?c5u6dXAIEmrlfzb4e1Tr+k/IccY+k7ZqXl6k+gvzgiSB74afKoSlo1856pGw?=
 =?us-ascii?Q?3MR77hs5iIC75jKblFyMMGDlic7yRzWcRD5rrLUKfEm3q9TzV0C0f96u8cgk?=
 =?us-ascii?Q?CPBDvyVYA2LHKcgr98meQbMu1BZEvrhoRI8uOS3WkXf3bRFku2O1RETLhHTQ?=
 =?us-ascii?Q?zs25XL3Bz5hjNJq1gKaY4bJqTtn+trzfYHUrppLFuOdjAKJhDHwbOp5Ztoam?=
 =?us-ascii?Q?v1ylr8vsVJOyCDYvDTSJC2BQrxYNl7DCxqkuNkPNhq6XTIZols1ln2C5xFc3?=
 =?us-ascii?Q?JCdltyd+UvpiQ45Ian0PAsjmfyD/LFybB3ylT36J//pcISWn2HyJhw0QDglB?=
 =?us-ascii?Q?aESsM6IIGqHqTHB9HakWp7449CixFgUoljzeKAjrTnXPYMOhIsZ5GYO1NUg5?=
 =?us-ascii?Q?bmiVr75LuOXJtvYerhia3n7bev5tWfHgdJNWQ3JKl7zCPby96ClQn/hT7Ldb?=
 =?us-ascii?Q?RdC+JV92D2RwWLVrn8tElPBOXpks20u4DvKf2W9ccYKzgs4UgjPaFdU4yLp3?=
 =?us-ascii?Q?0aQHGDynUNaPhH/oQiRlo+MOQUgICBYg9HaTpsr+N2PUkbilo9pumbgwvNmx?=
 =?us-ascii?Q?jiGuUOL8tX5VZK51lp0esnqB7xXrvZ6DrAsGNlfg23XHhCmqQLlUMBa6ztat?=
 =?us-ascii?Q?2hl7iPhsE5LmsJacUK5TCr0JrASmk5G6f0pLO62txDl9Fsq1ev/5G3rSW6q2?=
 =?us-ascii?Q?WZBsCSh+Xg=3D=3D?=
X-Exchange-RoutingPolicyChecked: og5912EJBTRwnIFCcjQgh1l8N4tiSjeWeLeBuvhq3oxCnWDGy15q7hfO1F0dF5RQS9LUtleLdgdvZ6CiM1/2Uig7vVbiBuHkyxeo5s2q8asQwIwd4TuLwOyMTi6pAdNPAZ8HQmMWxdTsiGtfWdu2AgYtIHE55ACZBVaO43wCzkAa8NmkM5Y8iLpsZ097EZhvRwcr7f22ixg76BiRQt8kJB1wEj5pUXxZ2e7TcerGlrcs/BK1cxbogO7RC/f3scdghsurz8OgqWUrQ7gTcZoNLaJV1Qu9KKxaB0xr0b1t/NFjNlESN7sj7K1ZMH/Q2qhr/Ob5z1/PJr6VjLTW2M4+5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d70645-0390-406a-0cd8-08dedb5a81f7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:31:31.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmbJA/596M6+MQNtMP1EkCpdLL03mCb3Afv+lTCgoe/WLLfbWC6B5PLqOEEIOpYMdqWgX1gj542Uz7bX+NyRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9773
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:07PM -0700, Rick Edgecombe wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>Add helpers to use when allocating or preparing pages that are handed to
>the TDX-Module for use as control/S-EPT pages, and thus need Dynamic PAMT

For the whole series: s/TDX-Module/TDX module, to match the existing
convention.

>+/*
>+ * Calculate the arg needed for operating on the DPAMT backing for
>+ * a given 4KB page.
>+ */
>+static u64 pamt_2mb_arg(kvm_pfn_t pfn)
>+{
>+	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);

The changelog and the comment don't explain why the pfn is aligned down to a
2MB boundary. And ...

>+
>+	return hpa_2mb | TDX_PS_2M;
>+}
>+
>+/* Add PAMT backing for the given page. */

... this adds PAMT backing for the whole 2MB region containing the given page,
not just the given page itself. Is it worth clarifying in the comment?

<snip>

>+/*
>+ * Return a page that can be gifted to the TDX-Module for use as a "control"
>+ * page, i.e. pages that are used for control and S-EPT structures for a given
>+ * TDX guest, and bound to said guest's HKID and thus obtain TDX protections,
>+ * including PAMT tracking.
>+ */

IIUC, S-EPT structures are not allocated through this helper. Why mention it?

>+struct page *tdx_alloc_control_page(void)
>+{
>+	struct page *page;
>+
>+	page = alloc_page(GFP_KERNEL_ACCOUNT);
>+	if (!page)
>+		return NULL;
>+
>+	if (tdx_pamt_get(page_to_pfn(page))) {
>+		__free_page(page);
>+		return NULL;
>+	}
>+
>+	return page;
>+}
>+EXPORT_SYMBOL_FOR_KVM(tdx_alloc_control_page);
>+
>+/*
>+ * Free a page that was gifted to the TDX-Module for use as a control/S-EPT
>+ * page. After this, the page is no longer protected by TDX.
>+ */

Ditto.

>+void tdx_free_control_page(struct page *page)
>+{
>+	if (!page)
>+		return;
>+
>+	tdx_pamt_put(page_to_pfn(page));
>+	__free_page(page);
>+}
>+EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);

With above nits fixed,

Reviewed-by: Chao Gao <chao.gao@intel.com>
