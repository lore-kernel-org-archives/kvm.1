Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20231375F79;
	Thu, 12 Mar 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283129; cv=fail; b=l+YnNr1J/TlcHyzvSmjkiurphaHiPMs/Y5nJ/KEPdfqZ4MYwUDij076y34vkTEoEkEoLOJL5jYY5OHsKP51kU9oeSdCVUCdYmGnCf2sTO+efaFWw0kRuOOwSHNp3jLhYLUosw2EUx9mOZ/tFxGuyr5GMy+xXb5UMumnYmYiSMoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283129; c=relaxed/simple;
	bh=EvKBfyZRA5PxUpMgXgL0p/ItGgxSq0iTRzxzsmZbbmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OnLHOcunCzdFEgiblfSbnmSdEN6fG7lk/akUlxAPkurVYoZsTA+rw3MARbTZixBjZPxqMKBeXiTJKlxA4nhDgrhvh7BjPDOotdSg7/igop9Yuttstv1sFnTHnayNGtzyzNugdNxf0fo52pza8jxhhDb7gP8GqUYtPghRyIRl2H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2akrOpN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2akrOpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773283128; x=1804819128;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=EvKBfyZRA5PxUpMgXgL0p/ItGgxSq0iTRzxzsmZbbmQ=;
  b=a2akrOpN3hS79aNpy/3V8u09AeeaVSIhXsjKLPW092maTa4+0H93VuuK
   3amGkNP13JhOTF+zBTv2yh14byP7xIiRgbbmwo/4D5O61CE8CZ/WsUqQl
   8s08uzm7cf1sh+Lv5acfOr5Bus8rfJsHPn/70BKbyMlqogLKYb3YCdKFp
   DuiTqFTrlLk6BZtQHkQBNpByMt2nhSHNGsnioTK7tf36P/HZFejb5au8b
   p5vsE9tYV91LOV4nyVkCYI6wo0Ad9oKYRG99Shfbm3dm+byqunr3xXc6u
   s+S/bksQGDz8WTclf8898Uam3SSniHPBQnPX33XQizjofNXx2tqL43J+4
   w==;
X-CSE-ConnectionGUID: CWjUegFDRTO/LKpZByFEIQ==
X-CSE-MsgGUID: 5XJYl7oNQASSsa6j4yXRRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85843380"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85843380"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:38:47 -0700
X-CSE-ConnectionGUID: 9NATTaX1SsaI40tRvL8zFg==
X-CSE-MsgGUID: OijPn2ZsQzavo41ZVI/6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="218121994"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:38:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:38:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:38:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ/G0yPSlJ9htZF1jjYnp9sXrtSnHucEbzdHUyrZGd7RujZ5snbscUTxVdEKw/GiCMXX8bd4+n8dgyPQR+2sb+sOzb5yi9AErusjmxX8ScJD2cncIJslH4QnAhceHLNjX+3Q+anxj9isnjxpwH8ZYVv5s3zv0uf1X/bCaUffpku8kMDxE3G83k2zXK4ukWPOpzYyZWI0f5c3WpnuNh+sKKyGsZ/s3G4QHEuaddmkyQDLg3NNaY5fn81ZAiHrh/zHPym+MB2jDBb9zksnlDlhkNa6PE26Qq2TqnrHBYPiW9/miQm8J/KFno5zr21E0Y05ThNL0EgK6Xqh0QKTPbiGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abtm8ywaMCJEaoqC3DMRyaRtTu/5EUB9tzLUZe/ckps=;
 b=mL6+wejZ5OhoLiCSDxc4SIlTpXRFYMRoADQ2cwBei3vl2wOxNY51gQXi+rO0f2VeH/etIcx5Vtoo91pJMkaUtgU6uo2dB4gL8lwGXlYXqKhSKcA4m66ZhJ5tEEKonnAe8jYwmsuljpxglBtTTzLGNq2wGVubGhvAX+yi85W7RKdMHsEkeM7wBVM4KRPfm1bp6nE9xEWzbDT0ga5I2cQPluWwXAYwYvV2fifZKYC1quq5kIAgydNRm221fqlJaWOS/PIIG8RDAP+WpBBl8xjk5/w2uiK6BOmxxnMKAEB93hdsWf+D4JQlbCrZMZuXIqliapJet5w0TTICwNMjUJ6adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 02:38:34 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:38:34 +0000
Date: Thu, 12 Mar 2026 10:35:53 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Chao Gao <chao.gao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/24] x86/virt/seamldr: Check update limit before TDX
 Module updates
Message-ID: <abImiYEAOH29tq/H@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-10-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212143606.534586-10-chao.gao@intel.com>
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 147c663f-c1fd-495c-6b50-08de7fe074dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 21I4ejauPFN28kC+uddE7hdJB1Zf/CcOTNsneinGAqjlGinukYsxShqbE/k/3sRNsaxHEB2PKTKNG68wpUrj7ZLJVOpxjGU00OMHXmbb7NaYgttOWJUE2Z7FeiwUr+840eeAllSogZ1otg2fwYedkpHHKgmvOrP/4lHhptUuf2x5cNpGGeVn956fRGaBpjIArl1vDNBYs7MMuI9sTVPUF/vBRbw5gVJVpQ2gEjWGwafTiwh51Du1H+jfSpGsQjx5ISB+8fi8RWdgfZ777MPSCHh3HmkdiPt06M6uMlPwn7peAMKmxwt5exe5xo977bklaeI0mAwyC3UIm0uJB8QQTJJKSgjEcP3KbV/g4G5VdNhRSOF9s7mMT6G475JUu5L8PZWWBHu8s34X5ltDwwYAADHEV4/bJf9KpyPTT1e6FCeXaLVq90e3nXX1oNmNEYY15muXs+6pe6a9KxGAeBRqtuRmNwMIt1GVqYrcgpi1QBzCX8n/LW+3qNV+Uoh/795LSfq8q3VpGocpZRXnVePBq9doOArWtuPvabNL9zP4KPanyD5Ge+V8NKy9Lxv7Hif19xqKHGtjMtvhzgd+1gc0vkX/X1XsgC7+YWYuX0AtV5g2YgfZJR29c/3LQXel7JD+g9TRjj13rMm5U8/vVGxx89aPVGcrYJwwNDSfJ25G7ujmCj69wBzMcy2f/80z6TjKyP8oarf89uyxg55Yd6jerHIZbQ4X46SqVAKUl4btxZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKn72Yly5MfA4Yf3vzlXp0q9DE/RCze0moJ63iy5G0HHlF7FNfHbzoqR5Nxv?=
 =?us-ascii?Q?H8R6BnES5d+FuKE4ANWDxUn4S7gzyVKtgt3fxhur/yx0wpslu5h7jnhhUNOU?=
 =?us-ascii?Q?DFgLASaV01NKS117fDk6u+rC9uSFpgO6jfXFJgG6Umgq0ZpOViX1pXf7B3xZ?=
 =?us-ascii?Q?gAVYmJMf+I1RMrrvhUI27uxe4J2807atRd8Ug+Rhss6DzHF/5JSDmmozEoCg?=
 =?us-ascii?Q?+uaK+bITq39DIiEYBH7ZhXhk2wMjxbRCF7vb1kIAtTZLLLiu+oQN/SvrqibF?=
 =?us-ascii?Q?f9+YltY0PLUsXIS1b2lGyo30WD9ioe2lYfVzCbL3v1VwuP0zyUAZPFGXj1Qj?=
 =?us-ascii?Q?wY0gUfozgtutwEGFenH+juhG1zNamvcYoQCocO+aNPpivB2WBtCeebiuYSEn?=
 =?us-ascii?Q?z+OQxLelzps8dbKtmWH+G0gt+0Rq7ZUwhEPQE+zUA9dKOOV3jR0cGFDkYld/?=
 =?us-ascii?Q?aL6CNcAdviE0En1h3NrlLxAsbSjCtNKVi8PUL/wvq89w017bQFef6SGr69JS?=
 =?us-ascii?Q?NiHcUg0I/qQgejbnH92ylve9lNKALnBC8vhko9OrcM1rahRVkm7ECdZuwv/n?=
 =?us-ascii?Q?EXZ8aeCXckJ+pwYCskE1Z/GbIe8VNRyXu/JvnAF5OYumXn/prZvmguFabCeD?=
 =?us-ascii?Q?k3K7F2/c82j7MuZ0K7HA9T7o7dEzY7LlgMc7HEc0qx9I+hAKksYNRmMLeXed?=
 =?us-ascii?Q?HWbFZyasUj0qfyQeMppt3dZH/vQ5p/dgw2kYJMYLofzMyWR3aRJEzzH58p0p?=
 =?us-ascii?Q?RovN8U/Q6RALh+PZfqP1x0Ka4Vz6KCpjpYxSQoe1q5o54rHp07qvZyse6OUc?=
 =?us-ascii?Q?HSOe4N7WQC4aqxtCS4JeGN0yWIBGKXIg/EBGqNwzYQsTeXSmJJ5/gC7x9Kqy?=
 =?us-ascii?Q?KJPZD1kgf9dZbSBBtPJBsTzSDnCXby9nu8TLQ9lmbiZLEx8xyG5tNCmawjS/?=
 =?us-ascii?Q?zrZpfknPLnkbSLPLAleODeKaR2O5ps9uvUtU9DIIvv0NhE0RxlvyTa3z/OCX?=
 =?us-ascii?Q?ynB8WjqypkPXs8ukqlTej2DpNRqvtESRt3qnE4HnEpZKZE67BtpK9aoIq1/O?=
 =?us-ascii?Q?bDWKWdAbdsQwPT7zKAY9VJHKOx3pwaU178K5NtHSX8EkP42aAFnG/3N1D/g2?=
 =?us-ascii?Q?tX2bGPswXQtiDn3akR8PHsEh3cYtSPTFqze8t+7LLpl2B5xsrgj1Q8IjLJ6p?=
 =?us-ascii?Q?kTP2i2goVchgIs1evw8IHzNI8FuGGiUE/RJVmaRiAXz2u3/wIVnXwSw+qyba?=
 =?us-ascii?Q?f9bWhPScqePJ+KKjieFtN9txovpDXv6sBc6UK5CaHGnf3yQgLEbNYZ4lWMkM?=
 =?us-ascii?Q?drt2+8I0rA+nunmh+yHu6RtNlP4PdE97Lp3oJ5O4IpzOffTlim39tKsQvPU6?=
 =?us-ascii?Q?4bqlJ3106yqD2qecwYxSqEXrJCMuMm10ket7L8WmsISETrS95/+YJ7A6iu4/?=
 =?us-ascii?Q?jR3Q2n/2WYX/5Vua/YhGkIS9QXN3LQWTkeg4UWQSQfSrxwQ6G//SoRo7PjqV?=
 =?us-ascii?Q?pyAFDfZtWNoiiTSbBcHlgzna+8opKz19/OlDuJB34wyGkvqOMd8t38UJvk3f?=
 =?us-ascii?Q?FVV8y7HYEdBdY9PoOFqJKoQrPG+5Y4Xm1xPy8/IlmksriIHZuj8HgeR94irB?=
 =?us-ascii?Q?fyYruV9YD9dsHEHcYWyLu0GoMt30k7sGnCRGwM7nffuDRQqtmgZd4pmWC+c/?=
 =?us-ascii?Q?MfMhX4h937Wxr1ubQ2A5cKMoKBvVQAkVZfHK9NdOPA5Vy+HyFCO/tI8WKTiZ?=
 =?us-ascii?Q?IAG22Agxxg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ab9JR4RSykwnMEAW0J0MkvaGPHUYqfiO351P9k+sOnKhl4nHR3wIfAeUURLMxKg8GiheDEeNRokhOvDw1c5p/jDRQEQlXVxrOqY5TmTZ1O7tzwm/QZrm6OiKvu/f/Jsojnbo1lK36bm4XygGbHG9md9SY39z91i2DPpMLL5BvvhOB1VqPSxoG+hWK9c3EiN6Yuy/rAn+lY15wwkSuX/nizBNWFhr0KPlcCR2w9hd7j/4OExalb8fIWVVzLerAKDBuHUgIA5f6NAVbl6DVerT70uWHW7fhhI+RZcpAoEhk/Prj3T44dZqL6B7TLCIRTD0zugRDM5BpGQBxJdr7/7CdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c663f-c1fd-495c-6b50-08de7fe074dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:38:34.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sisfQMI/ZulaU7eY6lLp2HmDE6LhzL2RQFhBe57C2Pm0QaQ8OlGwVENuVIi43foGOHdyka22nrozk65eoCbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 06:35:12AM -0800, Chao Gao wrote:
> TDX maintains a log about each TDX Module which has been loaded. This
> log has a finite size which limits the number of TDX Module updates
> which can be performed.
> 
> After each successful update, the remaining updates reduces by one. Once
> it reaches zero, further updates will fail until next reboot.
> 
> Before updating the TDX Module, verify that the update limit has not been
> exceeded. Otherwise, P-SEAMLDR will detect this violation after the old TDX
> Module is gone and all TDs will be killed.
> 
> Note that userspace should perform this check before updates. Perform this
> check in kernel as well to make the update process more robust.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> ---
>  arch/x86/virt/vmx/tdx/seamldr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 694243f1f220..733b13215691 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -52,6 +52,16 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>   */
>  int seamldr_install_module(const u8 *data, u32 size)
>  {
> +	struct seamldr_info info;
> +	int ret;
> +
> +	ret = seamldr_get_info(&info);
> +	if (ret)
> +		return ret;
> +
> +	if (!info.num_remaining_updates)
> +		return -ENOSPC;
seamldr_install_module() is invoked by tdx_fw_write().
Why don't we put the check of info.num_remaining_updates in tdx_fw_prepare()?

>  	if (WARN_ON_ONCE(!is_vmalloc_addr(data)))
>  		return -EINVAL;
>  
> -- 
> 2.47.3
> 
> 
