Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA1A470E8A;
	Wed, 22 Jul 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748066; cv=fail; b=QnSb6gbx2ss3ojJL9654Gcouq7t0wsbz11PZkrxVIHBqPgFBhgVkfpIByO/LFudzDT47PcJ7okmafk0+YysBH84GnLbJH/vPMBNKCrN4Udu9l23zeNa5e07eBl3zZ5IFpUi8diAc2Up0mI2JnpBMYrHhibts5yFHUInOI0/SRww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748066; c=relaxed/simple;
	bh=TbVtLztJQhA0p3AdKwoS02sl8OpCuTHEuEgi0GuxyOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rS/mr2COQyRRR63683c+LuqqMg2U+K2r8sv2P0LzV4zyChHwUWeDZuVOgMdbhFWup0AsTu0RRTQcgwcPUCMFnmH0cS99AmRsTgF7yqfUkPZUmWAyP7AX60br/gFsHuYCNgjCoYzE/kdI7JIlroMM5QOqhaebMBzlto3SBY0r5Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlgXLUWD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlgXLUWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784748065; x=1816284065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TbVtLztJQhA0p3AdKwoS02sl8OpCuTHEuEgi0GuxyOg=;
  b=YlgXLUWDazyjW0a6TlANcC1PU1Eai01KIOEchoNKX2pllOGYexbh2WDG
   TNbzQ8OcmdsLDwFRBFo5WKCf/a2C3E4O9ZgiAIpiF+f8sx+iPUJHrsxNX
   WTksnBph8EMqrWVASvIuUmRjIp4m1IN8Pjm0+zfq3Ck4XFQQiOASsP+eM
   Vzqpa/3NKfAbgSbhfgmDPDhE+oMS8GwyrXls+cEHyftK3gNlrwOgaoPaR
   l46sfZqps1nO5oNKavtqjv+j+blbeCK3rjxCmpw8FyzQEEB+alrlQv4yi
   nImjKSJXMP8RN+mpxKezn+GSWLRlqXWSq5MJvKhz3J2j7eLy+/txejswT
   w==;
X-CSE-ConnectionGUID: DFOt+koURoC7Hnsjs6odxQ==
X-CSE-MsgGUID: trBiJRYdSL+tOGXx9K9ZHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96054042"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96054042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:21:04 -0700
X-CSE-ConnectionGUID: mOMcpgCZSP6w5jK2j+Sy8Q==
X-CSE-MsgGUID: hfMh6s7LSQ2vFpuMpHZrmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256393737"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:21:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:21:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 12:21:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyGqkWEOb1m+P2SfddJq/CEa14Z+se5BVsGiMiXT7AEu8u5Sl2sC9kLSx2nEF/LLyTPmHop/y+hCHdn/5KiB9essEONL2EAmHnh0nWdEG0tmsvhlvt/J91bWUbZ04bwbB7B0ILm+bszfJREGNQDEWtIOiJKkM9LnPCoREXGnXJgPDQNR6KLnYwi8YeLsh5mCVGCeuMZ1LdJOxtdKhE9mCwIJVIeBDTkd9nnFDfhwkY/pCWSoPOTdeVfxMArisezoyXe3p4iCliFLX8n1ajvi5wCx8UU6QF/CvJF3lv4BoU7QjpXskfUHcksMj5hXro0aNbvZhoH19j6y42IPqLWw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbVtLztJQhA0p3AdKwoS02sl8OpCuTHEuEgi0GuxyOg=;
 b=VHdsd552KGK3up5vsGz4QBQ0IhSqQvKZ7sL9ROhkNecjGcG+9/f0ur9J+mnPjZhoNsGFMrwA8DJB/h/AVJ1meX9rnFon0tYjvGldeOZbfqyK3LMiJWZWpGcilCwGpTI9j9mhObj0rWBQGCDgrhEEbD/b/wDoOF2lbPGKIDbQH5PYShUSu6T4MGHVAQGvcNqK+jHJD4WujfoFz6wAErk0cYmn0VBlHKO/YgdyQHwqiUFqfykk9BSe07EuH1cSKBu7GJUtpQjBRLEkQ4fuskKCUFC95sx5DkQb0oiE4pFHw+C4b8dPtB+Yat+wFRzsYA1FF2gW7mC5cgV5mlWhzfwfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:20:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 19:20:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZ5lHIAgABdRAA=
Date: Wed, 22 Jul 2026 19:20:53 +0000
Message-ID: <4ad035a82ee10dc4645e26a4bd1daf40786a743a.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
In-Reply-To: <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB6418:EE_
x-ms-office365-filtering-correlation-id: 865815a6-b8ef-44a3-100f-08dee82658fd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|921020|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: MfXUgyDTtrjvsb6PE8HQwSPsgcN2V7GcvGYuUyVJ8+FCfeHJS3cfL5lGZPzAda4XtSLcbkdrFDIXUkb9ChhihNGxlqWMtkyf9LRJU1oRKrR872dflYaj88Ilosxl5FSbneEKkHlgJeJS+sV5FK4K9MJaaP8bu7tVfMl0ZHYcgZ80O5dPy10POvP6YpZRyAxJ2A+M6qUvlQERtXMGMXg6DReKOoGv3cRJ6JekncoH9xq7EoNBHODj4opiVBnDxVMM/LalhSmD9fcIZav/ejzpJDKWqHfr5RDJB1aThbMvunOGzY75JokJbhp5OqaghC/fuWonwFgJD5f1MqUjeU36shEPh8ZmVD4+AGJl0eQP9txrVBWmQfl3E0bqxVGpBaqg2mXiDcodsMTfcUzHenWXtgy27hYxwFbSBF+n/PCoR4jQSPIxfG28h2bjLRGJAhQGQwq5oKVG9fQPwYVCY846KMm037zOSx/zceB1SjzUG0M3P0dsNoj8G2toI+rLOOCvMH+EZSa9ga0yD2H+Iy4JijMvtZeS5HMd9Zi0tLBPzJH8SNFUxvkTGb5BF/AvlbCMul7BLQVZkwLCEHwnfBIbUwKV7E8DXOdT40FcMxxqmrL6e3/lsGbaHuYeOiW3va3Mw1RARAlXPF8Pol2/QCJmfY3D/9jtoeNtJY8XlQHrBjfb/svSHvvEzYCGQ0DwhTBpCV+JyvH3/KWwY+eQWZQsdSiyKBozpP4JcjEWkv2b6VPBPYxj2sZDu2EHwtvGSuQX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(921020)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1JoWnB6ZGxCT01mT25pbWxtREVZSWtJd0RHQnAwVDcvbVg5Y3VMZkRER1M3?=
 =?utf-8?B?U20zaUEzVE5qSUtMWk02V29WSHN0cHljYVcvMlNZUjBMV1FmbmEvUS8yK3Fz?=
 =?utf-8?B?VFhVanhhZ1lqQ1BGTjIyam5BeDBMVEhiQkt6bUFaOUVIMFVQbk5HY0o5bUZB?=
 =?utf-8?B?YVBOdm52VFMybk5SeVZDMjdDbTFKWXBPbE5PVTN0aWRHU3hpeEVISGhCMlJG?=
 =?utf-8?B?d3BLWjJqcXdGODMxNldLempYVW8xMllzZEpTRkxqUkxUWkNhNmVUUXBHMVZL?=
 =?utf-8?B?Vkttc2J4WUl0OEE4UnZWSUhBT0ROWXM0dVhvQWFtOG80azUxTVpvNE1kTDRV?=
 =?utf-8?B?NzJBMGpiS1dWTnJiV1BldkxmZmVZMXNNa1JTVkl5L1g5eXVZWVF1Q3l4NWFa?=
 =?utf-8?B?TW1MelJJL2hXOXBwMzFYbWxYTUtrOVpPTFczNWxkZE1mV1dlQnlpWFJQK0w5?=
 =?utf-8?B?djdiS3VnS08xMVc0SzBNbzlYUUxnNEZWS2twT0VnSmFWR1ZGVTQzT3NMSjYv?=
 =?utf-8?B?aEx1eTVZRDlWL2lJVkJNUENRZDJzMzFxRWUwaXZua3ZjQ1NOZ1dFWnhadXo3?=
 =?utf-8?B?NmdxMHFwcy9vak83TVZjdlBIWE1yOGJJc3BRdGd2Y0U3enN5U3c5NkRxSDBh?=
 =?utf-8?B?WmVUZEVWbFdGVm4wMHZRaG5FSEYwdDFWb3NPb0lxdEdyaFJQRnEvSzZvUjNj?=
 =?utf-8?B?N1NOakxsSHBPNnV1RHoyWVE5d3RJYUNVdzZsR01RUEJxZFhlSkpBVitwcFFU?=
 =?utf-8?B?NVB1VUNUZi9rK1MyUm5zM2NwT3hOMUxYcm96SjQwVTVQSVRhSm1pVlorSGpN?=
 =?utf-8?B?S0w0T0xKVFV1ZGlDSnFNSElnaXB0VXluZ3pySGVZeEEyaXR0dGM3bVphTk1O?=
 =?utf-8?B?Z1BOam5kOG4yTnR5ZWNPWFlRZ2pOcFFVTlIxbVpqd2tMQmJVUHZCUHZ6bmVq?=
 =?utf-8?B?aHpaL2JCTmJHUFJadm5sUDFEZVRmRjMvK1oxTGk3Q2lJNFhVNG51azFNTm51?=
 =?utf-8?B?azRZeDlBZ0Franl1SXVDRHJteGl1czRoMHM0bUR1RW8zSENydCtEU2JvN2k5?=
 =?utf-8?B?VXN6Ni9veERjN0Y4SEFuVVk5RHE4THppVUpmcmZsOWpnMUdKcFVIMnZDZXlN?=
 =?utf-8?B?ZFZ1aFdUczBWaXp0eUh4YTZ2eUkxWDYwS1U2Q2xUc2IyN3lTR1dOR0FZNGFu?=
 =?utf-8?B?TVFIc0pId3ZSUHp4OVRZUGswZ1pUcXZXaHZ0OVEzYnl3NSs4TWZLbjgzUDRM?=
 =?utf-8?B?VTZiQUtTUHpTSkNCK1BWVWNOeVp3dVNJNHhEUnRaNVRIamlCUkhUN3NSekdI?=
 =?utf-8?B?amk0UnlZVTQ5SWN1dHV3b2JCcHowN0FHOEhhWHR2TlptbVJPZTNxejZPZDhD?=
 =?utf-8?B?VGJZUzZhd3p3UjhVeDlLMk9GM3RYL1JMU2ppZzFMaHlybXlXQ2Y5U2hST0Va?=
 =?utf-8?B?QlJCVDZDSEdtRllsUXArRGcvbjFBK2JUWU5MRjdRSWlWNFljSGxOS0JQWFdZ?=
 =?utf-8?B?dlZtTlFtWlFCajUwaktyNzJvMTBROHNQQ1h4MGxpZzhHaDRJZENGNmp3YUgy?=
 =?utf-8?B?K1R0WmM0R0NsSTI5RmVMejdESVlONDRHWGJmeFNWcmpOd0R1TDJOQ05RK1Fq?=
 =?utf-8?B?NmJORnY4NVZTVEE4VC9BMFBiSkUvMk5PZjRnR0tmYjk1bCtUclJtZGRCanhy?=
 =?utf-8?B?VDlrdEdBK09TUnRUUlpvNjR2aEd1R2QwTEtXSGZWNS9oNzVDQjErSm5BNUJx?=
 =?utf-8?B?WWYvM1NwOEJRcVFtVThMbzRKZ2tSMDlnNzBUOG83RDVxck1YWStWYndWU3Rh?=
 =?utf-8?B?ak5RL0QxT1RsM1BPcXVhdWpvUWNSYTNKMUEvTmVsb0lqYmd1QTZDMEU2S0lh?=
 =?utf-8?B?d0NCc3RPWlJ0YnpwK3hGUlNvTmpNendUWXJHUE1PYytvMGdXSGN6WXk2ME03?=
 =?utf-8?B?Z0Y4Y1Vrc2lJcHM4MVdXTVEybDlCZlUrYWl2Y1dmNkZuTWtXMG1vbFo2MlNl?=
 =?utf-8?B?UGJ0VUh0dzJBcEZpajNPckFhM0tLam9vU3ZoWTcwQ01SMkNoTFZ1aVpKUGJa?=
 =?utf-8?B?UVkwbkdCSzAvWTZBMmVnN2trRldKVEFhVmdTVFduOG5Tc01BSkFlaTIwd3R1?=
 =?utf-8?B?dXMrbC9pUEhuYjM4ZGlYS0w1aVA0THFVb1RKaVlMSWl0UWdESExDc3kwVjZB?=
 =?utf-8?B?ak1aNzIyc1VYa3BTZkdlSmgyZm5YWitkMEZoa1JWOUNOUnR2bG1IZ283b2Rw?=
 =?utf-8?B?WTZyeWc1M1JkYjR3V25LV3FDNUlFUUNQUmJzWXpQVDUxZloxMVJ1djUzanlv?=
 =?utf-8?B?TU5LR0UweTVMOTUxNHBDSmorV2IzTGltTzRPZ1V5cnVLbFpwSUhFSWFBTnMw?=
 =?utf-8?Q?HRSpurmBc5hSVQEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AF53FCE1C3BA4419FDBD6A8EB566DEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EnnwUqD9mC1BEBTmWxGRk6uCTB9i0T0/QpuuEWp2dUClTAoaAfvXnQhUiTN24mgtpYZh60oNKcxpN0qeHvBb+68GoP47lbREyTDEUAiGfyyGlsYP8WIlslGZZC2zWstbx7NXz04VI4fDTUsaaHlXCS8fzswXzf0WRdLQ292nC5Q2lgAlgYi/Ulo3Bfa2FUsjzb+grYJW+gq7dtDH4m04Os1XsU74gqgaUNNbkZ+OXwh0TtnrpkBdKXAq8naC8vdU3MNCii8gw46ClRjmyCZwzwsTb73K3wUyrHOHAe0Vhg1tU5hzdlCnzRlDBRSd6ES2t1rZQqDagHyqNv3EKXsl3g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865815a6-b8ef-44a3-100f-08dee82658fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 19:20:53.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3OWo8XyEWhdX19Lo67nE8ZArVbklkJ0jctLTwIQZkmFqBBNuYLTtvpP5lu0fGJ4aNFvujrnVXArdnpmSTNEiRH8S0jR4MUpxWPxBxF/iRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDE2OjQ2ICswMzAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6
DQo+ID4gK3N0YXRpYyBpbnQgdGR4X3RvcHVwX2V4dGVybmFsX3BhbXRfY2FjaGUoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBpbnQNCj4gPiBtaW5fbnJfc3B0cykNCj4gPiArew0KPiA+ICsJLyoNCj4g
PiArCSAqIERvbid0IGNvdmVyIHRoZSByb290IFNQVCwgYnV0IGNvdmVyIGEgcG9zc2libGUgNEtC
IHByaXZhdGUNCj4gPiArCSAqIHBhZ2UgaW4gYWRkaXRpb24gdG8gdGhlIFNQVHMuIFNvIC0xIHRv
IGV4Y2x1ZGUgdGhlIHJvb3QNCj4gPiArCSAqIFNQVCwgYW5kICsxIGZvciB0aGUgZ3Vlc3QgcGFn
ZSBjYW5jZWwgb3V0Lg0KPiA+ICsJICovDQo+IA0KPiBUaGF0IGNvbW1lbnQgaGVyZSBkb2Vzbid0
IHNlZW0gdG8gY29ycmVzcG9uZCB0byB0aGUgY29kZSBpbiBhbnl3YXkuIA0KPiBUaGVyZSBhcmUg
bm8gKy0xIGFkanVzdG1lbnRzLg0KDQpUaGUgKzEgYW5kIC0xIGNhbmNlbCBlYWNoIG90aGVyIG91
dC4gSG1tLCBob3cgYWJvdXQ6DQoJLyoNCgkgKiBEb24ndCBjb3ZlciB0aGUgcm9vdCBTUFQsIGJ1
dCBjb3ZlciBhIHBvc3NpYmxlIDRLQiBwcml2YXRlDQoJICogcGFnZSBpbiBhZGRpdGlvbiB0byB0
aGUgU1BUcy4gVGhlIC0xIHRvIGV4Y2x1ZGUgdGhlIHJvb3QNCgkgKiBTUFQgYW5kICsxIGZvciB0
aGUgZ3Vlc3QgcGFnZSBjYW5jZWwgZWFjaCBvdGhlciBvdXQuIFNvDQoJICogbWFrZSBubyBhZGp1
c3RtZW50cy4NCgkgKi8NCg0KQW5kIHRoYW5rcyBmb3IgdGhlIFJCIHRhZ3MhDQoNCj4gPiArCXJl
dHVybiB0ZHhfdG9wdXBfcGFtdF9jYWNoZSgmdG9fdGR4KHZjcHUpLT5wYW10X2NhY2hlLA0KPiA+
IG1pbl9ucl9zcHRzKTsNCg0K
