Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E53E3D80;
	Thu, 26 Mar 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525696; cv=fail; b=GnsMDjTAdSUS4x+4gATOB2ETRWRgyrpzOIXhZgj/o+h4fWtAHZkIlyFDXEKTn9i9xGpb9aZ6umorSNTgXEqfE/euA7E8lgR2QrQu4I/8aTgQZw1JDvc22l1OC25GsT8pppF4Cj77RmBfmNrK7p5YyZnuaGkPkTRuWAF4+5nUMy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525696; c=relaxed/simple;
	bh=YPhnSoox2qzTRfP3ei6pvHZu/r6wnXyshEcBc4pT0No=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUdKzkAQLctMtLdsvLqTXFFmcnR+iD4asW8eAVIUAD6eZkwJISTNEfBppEG1W2QAo/sYTjaLR5Gi+J1OMx+3IYcW4lVRXNs7VcUGNH2o++oGC4PZ5RqCE/SULM8nTF0y5cjnQSMwIOeyPUECBZ+jNY+RfO8Yj3BsawctYbV3JWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RglMF6mj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RglMF6mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525691; x=1806061691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YPhnSoox2qzTRfP3ei6pvHZu/r6wnXyshEcBc4pT0No=;
  b=RglMF6mjLnA8/zBsZTQwRFBdtBh2v75diXw+JlzFq9DfRMQQo5c6HheZ
   4dhWvoroW5m/q2MeGcm+9gjlrHesIkMrLTHgf1l0TzdDKUEGBnXltbbnt
   vn6+l5u6Eju4Zy9YfdA5JmQzDPnJ675rh09/SiDBkW3KuIwk0qjAb7GfU
   tgWvgIoD5r6hDVMsjkE1kpgcFgWW+9yIBxJDwYWcDdbzBi32J93dRq71T
   wGEbcl78v2sYn+OyLSFSGynuVyLoMDYelGuHjkNhON48Wm4m9FpgmzFTC
   m1NDGRErbE4UbcrV4Sx1NRdTEbXhTdkxDngBF65VBAMeGwG7l0C8Bnyla
   A==;
X-CSE-ConnectionGUID: cVDb+5TFQVKiKpkVvb09FQ==
X-CSE-MsgGUID: TUxIJLIXSre/ZTDPJN7Dzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74762736"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74762736"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:48:10 -0700
X-CSE-ConnectionGUID: QjF5zpNsSRypH0psDhh/HA==
X-CSE-MsgGUID: kkvzyYEvTsSU2oYjtlinFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="229429993"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:48:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 04:48:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 04:48:08 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 04:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGSWORPoYjHqYDei6IFXLS43BiMNMggBDJx1H0fNtK4yQOSPt5SpNnCPq2U5/q0OYBGwAypeaGdfws4dKVyuPgCOZN8bpD5M1rwocstreivOAE+GASZ2l6OZCvzVSy6NP3Zl/L23qsgfbvA6RVG8UgEVLKjcKBGh3PKIT0q31F8sZtdRSDyqXjVjt5cVw2VyP46hHY1mVH40x0KYBtLKZ9RIgJ5IoOZaOsNPfTW9F2ePhi8V4SsgvV+ebD2hrLcKTbknl9ric5XqNYnHWNcHmMiWWLEZ/YsvX2GeiF5RBKrSvN58ncKXwdDkfPAXsqRVPSxC9BoEx/ZBU9kvMrAjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JSM5Pj2M/EQIMkO/e46bPG6SNA+x5xcxmPiBkeJYck=;
 b=Q//DgImcIMrLQMNaQqLWd3cVXZ5QNJ0tke9ONco/lJUja7GAv1CCLtqtrSN8wx5fwVaDQSfO3vahdJeQIyrLD5GSubkLb0Ej60m7NbhV9QzKqHeRiWuZoclsNsw/hXyQ60/8vixv4dqMvcSCWdiB99A2rUMx12dKT+EwZw7KvuZckhhKeumodBmeM01qNP1jQZf3/p2YkXFWk5FZPkk9XZj6fOjWsljvpuEPAEWQKaXzvwSH2k8XJ4erkmp7VQ2ytnXKp+KvueZzdTtjGvqkCmrsr6xab1liwil0aYY/d84Fe1dLgkLvoK7SsELtL95LaT02rsjEetsT4OuVIaqovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 11:48:00 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 11:48:00 +0000
Date: Thu, 26 Mar 2026 19:47:46 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Message-ID: <acUc4i3akRmekbFl@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-10-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326084448.29947-10-chao.gao@intel.com>
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM6PR11MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc74016-9a69-4868-ab2e-08de8b2d8790
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: M47STcAsfyoGBxht+GRH/9oDnL6zzURdTpn+hR+gwxDsJQRSsR6vCVSssdb/GL8qvw5eWK1Xz9b3K2OkZcBEjSqjYETFMxhhGVVhxv1JzHdZTUgKyF9sculaSQBShj+CqQSPZNb62kTm66v7lrnGudGalKSXeekUXr2eA0j5YKo6E4E2rUcPhRhXBX3L2ekSjRS23X/yU9LRvPBB7v0xrp9EBK6X+PHMnVyRrmgitpZZrlGy7R0IA3wIk5b/dtz2m5zSM8+ZN/ULuK42wgOVINmNsSNMnoF+Cp0CsRspclgVUZPgpDqc24vkMjSbVhKWvYDsEHAy1KaQ1zUfsd6GeLhzcGVJBNZNZDX1RnhA/zFsZF784GPlRoRAtZTSiJLy0IvqwO1DW2bD1MVMXV+RyQuVIE62A17E4KqW/9/A+QfRIhZTZrhe5297Q+zUDKczcST6WDMdqVclNPeQ2RAzue3T04pTPM3ktlrmKgLi6Nbm9kXVDSp7Jmww0ogFZJm4UvHYsDJN0p127MOWzqomZghjmfJBMU0O7frrXf43IKS/77Z+I742uTpcA6b6vtVzrWdhWU9aK+X5MzYpf0xnW+kq93lWJbUojFOYc+qbWMu13X3NqdSyZ6kOGe/J9892oL2dqSxAjVwfBav216twFnzX6yobvX6Jl3F7Eo8sRQHGqAht7LSoXsKKzVZcQ+8w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ik6PQ0gTTvBI8j+04HkYLXwJtCmDkLEG6CoXmlSfvXXdlKMGqGBC/Agje0Ay?=
 =?us-ascii?Q?8Nshb/35fTK+P+fx6aXwH8dgAZmE8sewcNd3mIcgt7mBd8p3kQCgEAX+t3QA?=
 =?us-ascii?Q?tQ7G7J5wdv3RhBL3oeGTZlDggw4OR3n0z3QxQaotuz/wZ2nKgCYsmWefJZZf?=
 =?us-ascii?Q?yHf+tt2EbeEjEIG3iDwiyOobFmq27KM9goz57GJATKcIlg0iQuWxam0jQjGO?=
 =?us-ascii?Q?hmkZjfaB43qU/3ZmrCExHwtkcoKEJ0lgeVX1E3iwTwpWRS7VorL4RYqU7Evj?=
 =?us-ascii?Q?9QRqT/fNjK8oeNm4f8a/0S+xTFDw1sxjCPhlLZL6BfDj9+PIRHKZg2brng9E?=
 =?us-ascii?Q?M5TaDOKrcxsiRW77JvpH6QnFZGp+1y4JcU8S3m3Efzo0NcepSe1C51zzbKMY?=
 =?us-ascii?Q?OjSMMMohphl4iSEN+ZLZSGDP/FZvnEeanUciTXNWqUO7JDEft2ignkjpDR8a?=
 =?us-ascii?Q?axtvENrf+Gkv0NHtoY2MKF0q/yoxryLrQEZfEwSk6a9s+jtEDQWkNeNo6yIM?=
 =?us-ascii?Q?mJcEr9YL/XUloBuVnR589meqSl/HujeeoYHDFjXQ4To8uJBnyerlORhBVBG6?=
 =?us-ascii?Q?lzKhnXUV2UXIv4jSBIw/KjLxsNVOC4ERmF12jcmRTm2/alQTAWpAHGBhtpku?=
 =?us-ascii?Q?WW9fgjr6nXPXS+YuCB7wAu0wXGf/Fg5dY0vwFB8OWyBDz2YuADNi4Ya8nhht?=
 =?us-ascii?Q?8dkXCTXf9y5II6H7Qx+b7BMSzdTU+7B/h1aL87tQlxj94i4aIx5nWcIfkJhA?=
 =?us-ascii?Q?AGoGo3psWuwcMn+Cdl21S3npbLhl/S22wfIleCu8pKhJZU1yD3uXjeJKj+bX?=
 =?us-ascii?Q?SFUWmpgup/Xob5ur+0pEJrNCXNx1DbsnVNmAgyM1evbx7Q92VBoGzpdqNPcL?=
 =?us-ascii?Q?A/fZ1vYgZ0KzyFtHsb0Ly/jje/JyGvZAKexMB0PCAr+s09vBj0Mq4nswdL25?=
 =?us-ascii?Q?dnczfwOgH5rsHyQxab+dOSyYrCPZ3CK76cXoBDm+rj7B2sXrL0XEmzcWf9oZ?=
 =?us-ascii?Q?ONE6AH336JnwLQngG9sSIhcMb+LWXFl7HtFtChMbfhqsvLdLmX73D7+FJ6aq?=
 =?us-ascii?Q?DNmrLtAU1vwbxyybq2/VHyZJwDWwTBKts77Fg+QDiGHAoEQ9fe3Q8HbpbrXM?=
 =?us-ascii?Q?p1BGx/CelHgWmPJgACYLOA97rlrGQUlYH2y3zaF97X8AByu+Uj1aQhPoUf3m?=
 =?us-ascii?Q?eGMHesQ13v94BoFruqNnbh/Luffaov6r+Ak26rIzypOBMYNUjXh3erANjd5E?=
 =?us-ascii?Q?sIgVzg0n9n3XT15bqJwHTG0poDTGiFHvGFYDXCrG7cLAs8avJ/ZP2e9WPxPx?=
 =?us-ascii?Q?v7XgfZJMvgzXwdYrq2vh76oUu1wHGSr9J9KKxJpycMDrZyUo8mXpMwb2yRop?=
 =?us-ascii?Q?fkC56NcPOrinolMFbElggBsQ2mu+gOBuHeQix6pUkuEEVCqcC96nIJ0ww9BB?=
 =?us-ascii?Q?fVUzEjmc0CCSIDh7l9rAJcR7SdrLUvpaiEN/egjRFzbKPc8q1jJfohRTTrj2?=
 =?us-ascii?Q?z/biQgMyS55gkaYKLoMeHSHQHL/B6uhbUWmtMeL6ziDmQjAN9HvY1KasOtVK?=
 =?us-ascii?Q?M5MiDtVEYsGGCXflf93Dk22Ma7Gyb/BK01ptwAwhM1UvvJTDA4QN5xypiXuE?=
 =?us-ascii?Q?Wau/xdwN1JUiyoRNtm0Jvo3WxHmUrEsoggx/3Aj0d9Rbx2yWpsf/bv0ZFTOb?=
 =?us-ascii?Q?ihoECeqVATimFoG8SWXbHqOkNf61Qi+qv7QnUaTDu9kMHPfRf8WNebngLHHP?=
 =?us-ascii?Q?6gba1FN/tg=3D=3D?=
X-Exchange-RoutingPolicyChecked: K9FGiZ9zdEtHztvAf91L92h2R8TIkgm2WqvNGxzYpWtfhYWQVryXxdz66YH6Kl5ZnEZBL3PgLPkohhelbd64fFLdVp/SeXXMY3pRF5b8gyYArMvebF1enderHpw7bZ5QPJoOvA6QZesp5u8eY+wZ1I6UGSEb7XFmJB5HBA/NxQhkFNycR1BmUp/N9fCJBHF+rXDzdkKO/Xfk/eGTHfanhZJtMfXMDbF1c+VqNDjRS3fh0pBhpyq7Krh5GsAGdqwPpDwwlNxbst/hDhsGSBg3Hk2hg7AtYwe6WZG9aylKlI7bThDbRmonbUPNU6fVf8eKp3U8bprGAD+SGmgMAXO0+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc74016-9a69-4868-ab2e-08de8b2d8790
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:47:59.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awCKfJjFi4DKcQZG5VBp3rDjHZR+2AYUOjLp3G9S3u2TPZP7ifF9uMDO63XB6eoiq/OmJzk2vIgmGfE9mvAfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com

>+static void set_target_state(enum module_update_state state)
>+{
>+	/* Reset ack counter. */
>+	update_data.thread_ack = num_online_cpus();

...

>+static void ack_state(void)
>+{
>+	guard(raw_spinlock)(&update_data.lock);
>+	update_data.thread_ack--;
>+	if (!update_data.thread_ack)
>+		set_target_state(update_data.state + 1);
>+}
>+
>+/*
>+ * See multi_cpu_stop() from where this multi-cpu state-machine was
>+ * adopted, and the rationale for touch_nmi_watchdog().
>+ */
>+static int do_seamldr_install_module(void *seamldr_params)
>+{
>+	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
>+	int ret = 0;
>+
>+	do {
>+		/* Chill out and re-read update_data. */
>+		cpu_relax();
>+		newstate = READ_ONCE(update_data.state);
>+
>+		if (newstate != curstate) {
>+			curstate = newstate;
>+			switch (curstate) {
>+			/* TODO: add the update steps. */
>+			default:
>+				break;
>+			}
>+
>+			ack_state();
>+		} else {
>+			touch_nmi_watchdog();
>+			rcu_momentary_eqs();
>+		}
>+	} while (curstate != MODULE_UPDATE_DONE);
>+
>+	return ret;
>+}
>+
> DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
> 	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
> 
>@@ -197,7 +270,7 @@ int seamldr_install_module(const u8 *data, u32 size)
> 	if (IS_ERR(params))
> 		return PTR_ERR(params);
> 
>-	/* TODO: Update TDX module here */
>-	return 0;
>+	set_target_state(MODULE_UPDATE_START + 1);
>+	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);

I'm reviewing feedback from sashiko:

https://sashiko.dev/#/patchset/20260326084448.29947-1-chao.gao%40intel.com

It identifies a valid race between CPU hotplug and state machine management. If
a CPU goes offline after set_target_state() but before stop_machine(),
thread_ack never reaches zero, causing all CPUs to spin indefinitely with
interrupts disabled.

The fix is: acquire cpus_read_lock() before set_target_state() and use
stop_machine_cpuslocked(). i.e.,

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index ed6a092b11e2..6f9d80a3a76f 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -270,7 +270,8 @@ int seamldr_install_module(const u8 *data, u32 size)
	if (IS_ERR(params))
		return PTR_ERR(params);
 
+	guard(cpus_read_lock)();
	set_target_state(MODULE_UPDATE_START + 1);
-	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);
+	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
