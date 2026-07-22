Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25F34B437;
	Wed, 22 Jul 2026 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702458; cv=fail; b=Uepxpo/KrfhBUu7mfnEMKxippi3mA9Eww4aKk1NWzJ6MuSxIwKxeDtoRaGxFcVlIMS7oOcPsNZpwNhYrZY6PinEddTMA//DyVzwMypIDGaNEbcIh+D/lQZukOTdLl6XR+RBhjvfpsqmnhn/w3lm5M2eh1TILBtWqIk+0xH3ALx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702458; c=relaxed/simple;
	bh=JulTWr2pOPpIlgzw77KkPPTY6KRFHgO5xoetuCsfGzU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAQgASo+6ik5oUJr5YB1q8pPVcvedOZ9f0cYi6qpyDOL2oHRajhg83t8D4tvALZgR8fSdMU17lOkOwdqoczdrB+ntggqlyEmqL4adgUsUcekcynHT9+Wfpqph9raBo7vqpRFqnHq9Ny1QqMQSmkwGQLVMNaYDIsdN++hyXzYheA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRTfSvak; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRTfSvak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784702457; x=1816238457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JulTWr2pOPpIlgzw77KkPPTY6KRFHgO5xoetuCsfGzU=;
  b=lRTfSvakT/8CzR6J93hOy07Y3yXhk75yp1n01t3Q3O2dCsfAWMsFtaBG
   gGFYZ0ICC14xFGc5xqACAL7WiTdAuqiCss8lEeZBUExbgjZ3+OGfRDjNL
   VV9FkHSX5z+FAG0XKtQoCozAB1aLiFcOdhPDvAE1R9OO46oakscPGVRDM
   f9t+Fi8DilX/92nqu+X/50PmCJfPeUAsTf8tNy8JWPg+gRJJnETtrIN+i
   U7ONfwT6C2AqWfsL+Li4KGaFzjkZTYRzhNkSAKxcQVeJCgSNr+MDIJJbA
   4we3ogVn8Ff4AilkpkKmBPbmCwCI4GtCZwOIYVl7psP1QQ8CX3cpmeInA
   w==;
X-CSE-ConnectionGUID: +F4dzctaRiihaVGCQthGaw==
X-CSE-MsgGUID: GTucD6dtToC4mCTphhnG2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85271585"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85271585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 23:40:57 -0700
X-CSE-ConnectionGUID: GbARQVBzTqqY+9CYqWNgkg==
X-CSE-MsgGUID: jcUZZKj5SuCb47ZHQpvXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="255353104"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 23:40:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:40:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 23:40:46 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w08eGtbc0OmCTzR5IGZEr8jOs/Yyl6pFg/AsFgcH8FHn9AfU9XzHeSgRSbtL/AdSRWyq1MXlIT8lEsaVPJ9czLWCBP9MvM1ojbyuf5zgl5a8Apwi2diyBIdDyTvY3lJLOphxy6/SGylXOQDH5AyKb3Uz1kKCXTxtQ41hIPuwR00a5JiDwjUushsOYzwwjZTnkzQmjfLRuBBkH63Qs8jpYgtHPfhx2ZreWmJHE731HnmkgrkKnLvaXflZwUWRVWkfxTkwibVh9uQxIcP3erhvqSPNuJ83eyovtvF0hikcT0lfDVMsJxAB7Xv4+kGM8zJJ3IjpGx+Mw6EwEYmAOZY9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAfW+yx2XARZ9eUvIK7xyorflAZAWW11XaZve15gX9c=;
 b=RUSHI096zIkLFjxkz35y3pdsbljGp4I8IOTXxlXr5tSR69MB3NmGdkroM0LmKiLlNXqgNNVc8ciMr2wGwEnFndz1KwCy6zGiONlYiRHL8sfU3F/+nbA3qM9sQQi8pXMlD1f4ovvmWTbm0zjjPTnqUWdPqOoDG0b+tynfl1KKjP1twhiLD6XvzKzvDbnHvTIdOjFEhPq5h/ngiRzoksk75SEzgrQriC/yk3G/gbjzWOXdIAniVj+Tngtn7xX51hYCdi8Fde3PXjPKwIph3QPx7+MYhJ+74101Gb9x1f+wI06MlQVmSdTKMKI2vtq07Puhnx+P8a8i0AN0csa705N/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 06:39:43 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 06:39:42 +0000
Date: Tue, 21 Jul 2026 23:39:41 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260722063941.GH3178326@pedri>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
 <20260721064907.GG3178326@pedri>
 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|MN6PR11MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daa9d88-4333-4c26-05e0-08dee7bc0301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +dB1el/AXh/KJHxzauXPXSUDfjN7a0LOnXGyOy12DTv31hV8HDJF5mo2A1QJ6GJTsOSONhw2oKupx1WDO8CK/fj7dUEJMpNXn+kchUjsZUdshpGkhdPjjljck6a7pbWGeYnY+yXULXt/FlSd6nAo0HYyA1cVlyZKdrMQf/v26S5ErtpXUYC6HJDyfJmj3iC1j7jtuzr4ursaPpmAv8Z6FwO4xJkNMRHqqRup3FifaY/mzPuteFlk/Ed/l/ErJLz6yp6sfFkOPW+va1W0dt0CilMNZqE8uX/EI2tAcnPp61c8+4x2qbOlVzWd/nr+YFEbLzhyiDA8jGfKEQXkDGwtl08zI1X6KGyeEo9IWkdhgChvNC6hBePdO8UFpqHnAHvT0GX0Fs14/gdUYnaUPTA/ScfFSdpaisZw2fUnLrauI60Ifq3cIoAEPzxxT3Exzqdoy5Fs6AeyVBzFXNBbtg2JkNB/XgLbWe4qrMQBij/4K93X+qtPfluCHYCenjGVUPwZ5S3VkhYgzfjwSacCPNBNfAhjXu4uaIauQBqxerLP6mNfUhwwJ6mm87fVANC/h5Vw9lYW9irawOlLOawl9TpyWe0F8UlH5qOi9momFIAEOu00QtW4YzzeR53LXy9imFmLluTKBxCijayMfVtJU3oj1gvSGCPLlDQJZRGleq0CBZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOWSVEH/bZfAEtdQS9dyTtfZJj9qE7VgqOl9LTS0Cu5zhoxVYCKorTznWYiG?=
 =?us-ascii?Q?ggnAnNuDn10FfsiHinUKoMNQu2JUe5tiwPuTGoodMPWXz72iPATI1uWnTOrh?=
 =?us-ascii?Q?CYpAmhPT2z41IgWRSQ01z/PmpxKqoTfGR6ylte6paQYML1C/h19lKtqfhHk5?=
 =?us-ascii?Q?X3xdwcLRwwzcPdGnZwpLPJcTEIXSOuVluS44aEEKMbs9wKYLJT/pp6uBQjt0?=
 =?us-ascii?Q?mHFpK4CdokT+TyjwpJQwrc48+2BbjZslrR92/L086xTvNcWx9og8VUN1XYb/?=
 =?us-ascii?Q?SCyYwKcUXy6fsv91hAnBXMHaQwRzKBzAkbOCgJmCTicmTtA2M/ns30Jvmwhk?=
 =?us-ascii?Q?eszwPJ8bLbmPJF4ye+lCEyXU4zONVKhPxtTZ8AHOkbl7LjLuQ7Pzoh+VmoRf?=
 =?us-ascii?Q?An68TocgByT5vEJAgk+Kefk+ODPeTMk5Dd8r5v+oHlasSw/HV1NtUajBZ6EU?=
 =?us-ascii?Q?XrBeI1Q2GoxmjyS/emPO0ztTuCkYmEGcS80lrBcn6lpn2kEpO/YgNOED4EYh?=
 =?us-ascii?Q?Y8WBzyJcljHI4oLNXk68T3UP/joRnoxZmnUCr/UlGMqknRgGv13iLjdWRLBU?=
 =?us-ascii?Q?y1dN0yJOkIVGM2a8a/Fc7zB7MXkC/rqu/9IJXtIYjkUJpEUxMSoRo9kJhUsj?=
 =?us-ascii?Q?hj1XHM8/CmpyF+KxEBVxzyv3ozefleTArobu/qJSXqvYsX7iHUNnc61rzHx3?=
 =?us-ascii?Q?/TfznM976AjlkY+t6zmX/9Z82Bj8T50LRLXM0iIOWEiy7gwctYNSgwSiJOi+?=
 =?us-ascii?Q?IHNzVU93v5utoFDF9HLlr1uI29ixQhzNqfs41qBjXb2jb+a6uIkqtNQO2upu?=
 =?us-ascii?Q?zIdGnAa8WqsdauZ1iYcEztpTiixd+eG6KTsULkFbpfC1F6PmYpVZZWfcl5Kf?=
 =?us-ascii?Q?pQSvKeZ1DZX3PqgOp/gGrbPuUjkdOGlXPJ5pykzpwJDAL2E2h3PiTI+acNGA?=
 =?us-ascii?Q?YgO1aNvBxlwGdtOad2fKMG598oO20uHHKBpE63OoG1SFZVGuiWKm1CKjCzMU?=
 =?us-ascii?Q?vaWP8TY15vgoQRiAagW/cl23+w0ySus2RGTjOsmWp/Sb9n5g8PUGhPpkO07X?=
 =?us-ascii?Q?fbgSebzPLgcPAkiKKXicnosRtOlc1V1fVvnzyXizuEwYp8mSLUFda1Fr5+/q?=
 =?us-ascii?Q?IdUNjulB6w/7S1ebUvpEWtjXA80uZu79g9yzSSNMBqUivfuBDlDzsMqTph6x?=
 =?us-ascii?Q?O+koh+ufVN8CRX4j1IjCjEw8whf8YD1rH0hsV2YHvvxYwqR4kjs3AT//97fz?=
 =?us-ascii?Q?Bx9i5de6T5PSLvUP5tf3M6XrGenhzJ2A8OQz3Euh8Nq6AhcJgqkYhgfy19pQ?=
 =?us-ascii?Q?Q4rZTLRwXuFI9/cxgRGoYrgKLQeM2y+mlg0GCe4rl6YrSXKU10hkSWvxw2JI?=
 =?us-ascii?Q?m+eogHRgURVsnkMmYXLKiVdr5OSlsFPZQqBdLD4TPL20y3zsdFO7062OP+EQ?=
 =?us-ascii?Q?RAv98XLgL7MmmgkGytiRtPPV//R4aeeYN7YUumKD0YZhVG5iDQMo0GbpLA0n?=
 =?us-ascii?Q?CBUFV0vX/poJsCpc34ysaDHxaZFGBUL40vSHcQ1SCMzb8vjJzc2ftZOdj3IU?=
 =?us-ascii?Q?VqmaRpnB0wsziwCKEjj0QoircNlEXUlOf3/G5PHa+Y/vRw+WNQOS49hFbNV8?=
 =?us-ascii?Q?hDgujt9CbG+Rk+XM4UF9zAiKHnshiuIz9G2DVJIajTHT1d/BdhNxsyzulRiw?=
 =?us-ascii?Q?VZhuNwzwPhiMJURInBenjaDrKlwo6DybWhz9kyWuEO1GWPZ5IpTXidGBsBv7?=
 =?us-ascii?Q?NcNHaHT4wg=3D=3D?=
X-Exchange-RoutingPolicyChecked: JMpu1iVKODGZ6sIG3JAYzAYFmUt35QCblDvy2V5YRGVM2FXn5CMfQsUcNzLjtTANQ9hG/TZlE9Pg1YqxRDJSWaMNqoiB+rkRB5o7IpwkWVFzEHIuDcFv9xxcuXWQUDNoE14b3mngcYUaTLskmcThFo3ctNbyQ/fGRxl31vqiAGmGpIIa0nPUD9YZaruhEmyVA73gHl4clbj0oDbMs1EuLuhAttqA/0V5xeqrKd8lUZkCUfWr75H+tUzVFZdg0g/RccHDKrw2wlSO20hg//ndHpDhKh+k/iqsUTNBllYgFitimyRSWhI53ptgrtH1aGfsdzv0O+LMfT2ztt/ZxI370A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daa9d88-4333-4c26-05e0-08dee7bc0301
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:39:42.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufi6Gjf282QiRoxQOCAKCTL/oNRY2qd2+hhUspX0bGZ0hM3NLQWLX+AKtfYVEbfUU/ChbC/FpcV5dQbFRtaEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8102
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 06:48:24AM -0700, Dave Hansen wrote:
> On 7/20/26 23:49, Peter Fang wrote:
> ...
> >> This is all talking about post-quantum-crypto and all that fancy stuff.
> >>
> >> Isn't the important part here that the old TDX module ABI had static
> >> quote sizes and now they're dynamic? Now, the reason it changed is all
> >> the fancy stuff.
> >>
> >> But the ABI changed. Right?
> > 
> > Ah yes... I should call out that the size of
> > /sys/kernel/config/tsm/report/$name/outblob will no longer be fixed.
> > I'll update this. Thanks.
> 
> No. I mean the TDX Module ABI changed.
> 
> That's why we need new kernel patches.

Ah sorry I misunderstood. I'll make that clear in the changelog. Thanks.

