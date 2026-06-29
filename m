Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2838E8BA;
	Mon, 29 Jun 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714869; cv=fail; b=jX0e9J2JIXtaYe3vtxRYCqBQnWpek12FU7MOf2Z/pK9Q+fwKfxKEmtda2VJWjjAJ32iqTUXAUTplVf1chYAiRyHJhfHdSe0sBL4von1POVkseXFvUtIi8hMIFyU5kuxxvEycKXNIBj3zLVd9GPyXwiY1ShJqkAuB0EAEOGdPvew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714869; c=relaxed/simple;
	bh=epBF7p8PL4BUsPaMG58QH8lgwyngJ7prtB2YjyJadxw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUpEyqxyxl6/hIvhv7p9vN0O4VdYqfNYvarhp27Pk6MHyGYpieBLTZsyQb96+5SXIG+NXXrmLp8G5r6IQDE29k2bghsgV5juC8UUEZ7+lO+TlD955P9NTh4G2PpmBLD+ljhhbtjqxA3qJMFCSSPLux5rtcwRhj1TM6Q5pLe20vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqH3xyF+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqH3xyF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782714868; x=1814250868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=epBF7p8PL4BUsPaMG58QH8lgwyngJ7prtB2YjyJadxw=;
  b=fqH3xyF+pEQaOgSuR6u0O9VGXE41bjpYb2ulGslpXqwP3AL/WXoTtIGg
   DiYULvBR1Id+A+JrCARLbuiRmFXGyb2FcZqc85wqvCUQkb6avGze8MT+K
   jmjstYrq+4oQEbzZeq769cMldTNml+p2fbwfPLiMLE6/TOt2E9FHHIvrK
   TPqlGga/P+zccxnepNtTyl+FBCKmsmPiKF13KB8wiC28dJVsbsUSYsywL
   WSR5fxpGxlYrBZBhgrJ/do/9Tmxvlurtr/sIJnZv2hy3TMsRrAHCSbMDK
   ThtAltoMurvyEs7fO3Iov6kv5z0sHpJNoDymxWCaWDXwNiGGnxPlb81zq
   w==;
X-CSE-ConnectionGUID: b1ky2yh9R2+jSWqSdedyJQ==
X-CSE-MsgGUID: uu54QSUmRgK7QOLwj8Phvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83271176"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83271176"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 23:34:27 -0700
X-CSE-ConnectionGUID: ednzKgqRT9K/NwO2Sfh4og==
X-CSE-MsgGUID: TaZSIVfWTk+WhExpsQXZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250806280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 23:34:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 28 Jun 2026 23:34:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 28 Jun 2026 23:34:27 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 23:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ1yuhmkJbUUTNqIxO/7tfzSjjP35TCF6WNOnJxVBSrBAnVWYHHs+oedMs635py4hbIcofwskHAhIapwi3W4OMyvzzH2OotuSu+BK+E94bQ8eifn92QN0GrB2e9DZLJE1OBHIqgAaL0cPaX7UVMs7VNCzQASmkbtrAuBVxp5IOveXzIWT95kOdPYj8f0jnBmHAr02teNENJlFXbNoI39lx0S4i4bfeFutM5arU4FUf/CwfS1In028NqtVdLnSex9SSArKYFi1eskys5RZGLvFM3GLakDI/o5JbTX8lds1xvxi8yR0tDhsFWiZeS/eWA+hGS1NVnLaDYP41naHliZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l78Mf2BqlzEPaPMLkbwtHHwLUunG7/+dU2t0QdgSpQ0=;
 b=V9tQwil9j5ooYFlitsBQxKA9NuyiexYUdjsWIl6Pf6PN3wy0Wc0W72g0KsZa0aZGW5y8YiewbQ41J1yL3e5Ul+gqBTB8BFmzE7ffyQVQ6GaeHj5QGXrVrEVnlgMPflCQyvnHHNYhxAMOJPmKzsGHln23gpe7rcLstIolmD8zlcSmS4GG29uNp5ryricNCjP6IdQRkfBkiMGAdhf9P2TrbjWDBgp7aoPHD1Cf2IeXLnBSkDG0SMB79Lk0QUkbgnld0vC4aXPRkwV+gY1+/4O2rbIrYQGZRhcPfjrf5+9cou8fEcjmv220s2Ljju6K4ZrO1a2FD8YyQozHL5hzDCcs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 06:34:25 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 06:34:24 +0000
Date: Mon, 29 Jun 2026 14:33:56 +0800
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
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <akIR1ClnTs1bRsD9@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-4-yilun.xu@linux.intel.com>
X-ClientProxiedBy: KU0P306CA0025.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::8) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: ec55aecd-0ada-4ed3-91aa-08ded5a8761f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: rIK0d02U9+C9biwZAdCRsjcC2K2GP6pteBf4EoWa+tFVYhuUXXC6FZCrJj733KR+RPbZjPxuHO10Es6EYAjmZx0W7expuLvpONXELgKMdaq2QrqfwyLhOloCmIaexeqxWBhm3e5+C7g2rD9B0wnTgOPt8LN8qolYZgDkonZYnBp5xA/KgXQ8Qjm2VUxN2t+vCvxfN78NgMpZX8IOxP21dyNa/uv41xRryV/PPEsKlaGT6jM8oPvKrBaoUOtRD4HZET0cD3WzyKZOtC1VzGn+cG5CaUpgaplXwy3DwUwirvpbdK2sTK0k2Bx+UgUm/nfFuxlip65NSbbNYPTYMuHrVt4i+GZCBvBFuwBn0qHNJoUDRmrrjPRyvfYx02UTT4DqK0ezz6qPWLmGlzulhaOyvdiCKa7vAdQ+zkr7i4kEhVBLawnXEcvf5o5SubEGDzuF+6dAbyLQo6VBohkhnMGXSdC8PuiL8noL/OAdsXI5Cs2+ffyamKP22zOD2h2qp6NapVXo6SqOdl+CuL2lqUHoNvjjJ+SnfpZTBMt+j0ZigfQQr6M9CSlyD/hADOKtlDGrQse6WyLjRCRxrmA38eFwEMxGzdPJ1Y9ztlyuZxcKBsSRH4oRMeMGOoPQoLlknMv2cbb0lB1pBr5qcP4J46CQch/BO246CJsgm7Pj3IDHdnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLhRPIduQU946y3jy4BfAMjpiR1cf7CeYr02txwJ3VD6gb9yyWXncvgv08E+?=
 =?us-ascii?Q?ppXAeykvpoJXBjVlik140w2MoS9DQm3TrFsZZOA/B24GuMnNHX2aMqP8ajHL?=
 =?us-ascii?Q?HpRLeeIgXwZWJwW0ee74+VqiuZMaZ+0c3cJ7szY9XgN48/WZ4h4BpeZFef5V?=
 =?us-ascii?Q?wSmGkug9tCu518yAVXqHvjgPLQAjyJRXStnY2awwIOEh85vagqnAK8zBuRZK?=
 =?us-ascii?Q?Rw1a0B8ca9SGXxRKgyV7aO9oYad6NyO2IuK17uzkv35h+cPU7DA6okixYIjh?=
 =?us-ascii?Q?uVPciwqk2liOo1BIK4+nEyafXvK3Dx4dxOfawhRLJE7aXWPr9+GKgtnFEwS8?=
 =?us-ascii?Q?EiX/kFb7HpZi/LAqfx6L2/HvKeFRJHJPnICWK8GktX9VDy3vlqAIl6Rv1yX4?=
 =?us-ascii?Q?RwXDLiMAqbyAG7fHy5WiCaluQ8AsqTXhnRyEY2hQUkzzrUqoIdeSygR14L/y?=
 =?us-ascii?Q?cES3buF94/cjXa6trN2Ts0uIIf+iXaJmrjTjrRpl054DUDypqL+2yOI/BMLt?=
 =?us-ascii?Q?s5Mu+0yJMRALGR9RZ4nm3EmqKlSHi9+QHDL3DWnZzCwsDbk8KGyEMcZnHcm1?=
 =?us-ascii?Q?H3mwYMW+2Y/pJeSDSIrfQTGMpPa+W0BcSBdwKd3rjRIXWunenkr8/P6awtUO?=
 =?us-ascii?Q?aeRewvzO1I+jco137fK9BZSBGzAcHQaPCdUi0hPeOlWoZ6y76zaosfCxfbO1?=
 =?us-ascii?Q?D+obiw0xG2RDDZMEYolYI/VWxMJFX4ZwL20i0eekijVlV0yF41WmkxDLJu8a?=
 =?us-ascii?Q?BPanlX3irsKMqswfwkD+i5UH35peQkXMD4AYTs+jcn2ikfRGMH5Iid2f4aJg?=
 =?us-ascii?Q?Uwo0zReXvhGDKBOTMAX1sJ3q+6qCbHzCkdct202UULahsGwQ4i6rAMP8wcAB?=
 =?us-ascii?Q?v5x4B4or/76Bk7knCDzJ5v5nuVftMJGUxg+rpvcxz/Iqhkr3t1HL0cfwd+SZ?=
 =?us-ascii?Q?REmMJaGpVl93CwahmHMw53XU7bttx/w8F8/VRo+6iU97jPWlfDXboeDGCbob?=
 =?us-ascii?Q?d6pSxClhoE56TVemRe6IIVJLPE2KLVctrHurI15oSgQR5bfb2flZe8EoW7fw?=
 =?us-ascii?Q?o1v/45KfwS8vKaBB+AzUFxfgm1YbiTWot5WPaH78d9UCC6UjzqVaFuHQ4FKu?=
 =?us-ascii?Q?gMtCJVF75CgpAei8KA0x3J6Wl6qSvFnYcV5UCq+YuPiN54FiKGTVb3w8m5hP?=
 =?us-ascii?Q?DEr+aerFpP4EAOU8sTbhADvI8vKXigwDhxQmrZAq0VrsUZSIJ0q06GBhqbmP?=
 =?us-ascii?Q?toOqc/C6is7Mlyux/Wv+Ykek5iNnDq87GGDUw+ei3uM/8I/UBpOvaGGUMsFl?=
 =?us-ascii?Q?bt5DXFQ9Tkbk+qxCQN8Wied9TVFzNDYT8GcBwzMsY5jfeMqkUER3gABxiEgn?=
 =?us-ascii?Q?7VzY6x/vGwasjgjBsO6zu8GZrqrhFpBJh1axWuR6rU5mSsp1i0saS4xOdzuD?=
 =?us-ascii?Q?fulC5vGAqJN9K/NenM/jQkButyjQiq0KRS6SW6dPI07HIw8GkUH8BVbz7M6l?=
 =?us-ascii?Q?GOMKJr33xjnDCQhF4nzMfgxpeWhwEz4L3NnEOgec/Xv+1aCZZW75nVGZXXdJ?=
 =?us-ascii?Q?z5/YZXMGsPcT2zDDoKzp9tJpeugI+ShccMfcw7BEFalCcpk8HkXD0vf88HAn?=
 =?us-ascii?Q?6SOo3mQOds08fevQhu5ktS86bn5Zaa325FeZKXBDX3TVEwwdvlVJncZHjy/X?=
 =?us-ascii?Q?3rkxnEMn7O/OX1YOobnjJAoPmblGDk6kU5F2y6IxySNQ2RmUlFkJySw+k80E?=
 =?us-ascii?Q?/4qmfnoczA=3D=3D?=
X-Exchange-RoutingPolicyChecked: AcgIsYbQeAWFtCrXIsi8mXCurmiBiw1c7RYGHAbsMZ0WZp6FSVYVYGeaEMz9mmUXHUOADW1BT41hNtw3iaXM0iOztOsrOTTYMp7a3J4J1OMFcaPN3QRyD+tPZuBpUXg+ZR/PQ8ZxQZSHRjGDUZw/IJVl/x2qhAKgYC43OkJ/QSvRpTA8A8nEadjtsmEB8o1rH/SYARkPQ3fR7d+LP8h7CY4VhRpsuMBbMhbkWrLy/dsfUDgfmSQxdEKtGCeU+Az+aPugnZ16iiTChSwyaKv/g1QpmmOZhFhEvKGUA7ny8X+DKAuuabmmp1QPbVxqIs6OR88gOVsi0Z3yXbUtd0cJXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec55aecd-0ada-4ed3-91aa-08ded5a8761f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:34:24.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bGHa79l9iUhnhul0oW79y+1TwnD8bj211BlOSXj2zehvvM0B50l1+puoE1ZBZfpoLA0j4+v9M9Epy/3QdriSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
X-OriginatorOrg: intel.com

>+static __init int init_tdx_module_extensions(void)
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
>+	/* Skip if no feature requires TDX module extensions. */
>+	if (!sysinfo_ext.ext_required)
>+		return 0;

What would happen if the kernel doesn't do this 'ext_required' check
and always does the extension initialization?

If TDH.EXT.INIT returns success when no extension is configured, we
could drop this 'ext_required' from this series entirely.

>+
>+	/* TODO: add the extensions enabling steps here */
>+
>+	return 0;
>+}
