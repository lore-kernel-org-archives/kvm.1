Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6C368958;
	Tue, 14 Jul 2026 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008471; cv=fail; b=IJGE+47F8+OX9JpAI20dXkzkoaSz3hlgjD1SvVACDfWn/HKa3Zi4y2PJJF/moF8xmnOR/mMqYYL1ogU9DO+dA7+mGKBu2bffjYkRloW1oQWkCC9Q5lMyEB0AML/y4FpAJpanvxo433K8BeLHl4YqLQXgJKPM0cbprT+8J9ap9Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008471; c=relaxed/simple;
	bh=+EcDYyAfZfbjVAUdZ7LHToMKpiveMgBpJxuWFO/0XK8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTslqt+mmZr8+Hq88RjNIUNsN5BUkmSuObXTKgLILqVlPhRZkYzlzjp6TSJuEKQ/eE/rGnjAZjwDJAhtoPaPpOq1Z2d5z+W/SHDBP5ePmNqb3nmGRToFHTsftKw5LEDI5n5y9VflWLTOsbmnrs98we6n3NU24sadVZygbJ3P0NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezVvMEnh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezVvMEnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784008469; x=1815544469;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+EcDYyAfZfbjVAUdZ7LHToMKpiveMgBpJxuWFO/0XK8=;
  b=ezVvMEnhNYS9GeoWGSTiVVhD0hVZuUleTPzoxw83UUN8SW1RHzp0TU/M
   0tVl176Qqojwvgh041Z77f26aAUBjNBVt5X9rr1HOUgo15acvDdDLxtA6
   Ucasiva+R2cdqGB7+ks7n4BTpBLdRlauVpFHGxKl9m6bqDBg/WD4TwDeS
   nUNBrG+riX7QBc8A98mrrbfd0W4sp0YgYltz4bHJ6qs4LRqh5rO3Lmqkm
   9ohk8DNEBLBtAPfpiVscgUhuIgRosukb96GD+ceLX5jn95qgSirGUjbsm
   7CwrRcX7RvCpO8YEOD5Nc1msyU1S4XpcGxge5VBYImr1diDoi701V33Hc
   w==;
X-CSE-ConnectionGUID: xgy+pJWGRAKPTp7EeZHTgg==
X-CSE-MsgGUID: 9NIqLcDCR6m/oknrQ1duJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84817227"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84817227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:54:27 -0700
X-CSE-ConnectionGUID: 6fo8+gSfQ9WlnnrZttIqHg==
X-CSE-MsgGUID: QCxifAiKSPeZwKuTi6cDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="259607693"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:54:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 22:54:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 22:54:25 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 22:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiSOs8Ud/RtujXLcvukmzwDkjUY0J9WdmyW85wVpMt6923A9I0mveGN37OGDkrLDkbVgTv40BWw9FZuJj8mz9Zq8VLkKbVg/g4xVRxI0F2YHks7ng5lLCtjIgTG3HkfE43mg8nfm1RsrPfAQi+ddwcZX+qxSfNv9kg2joYUap45u0UY19SLKc/kokfixWBpfbpFxCZwsHBP+4bw6Dug9eqKze4LffcigXBna1zMyz3qao7Ki0t/pL8wtRyTEasIJPCwsP6vHJC2HtIcREP14kJV88BfUQgWp0Kb1WuWeDCnHDx1CLhnSJFg+q6Yb2dQUuwVgbwSlchiK7k4yaW+brQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD7NDeFrqa4wv+6n8C4PbL2VWt2zIzTjQnRhi7ysh2o=;
 b=vHuldaP3WWaVohWUmzxAsIIEdJVWMofn6y+3hQOLYD0el7J0AqglRTMCWSLL24rwzgtZKriM6F/Tpcvh/h9Q5g6oPuxUzmtD8aF/8QuRupvMMRmzvzwO9Z5qOjIU8VP4vZbACcrANUwPuSyXsyJNVRMvVLdCTkW/seBD85ea8rDyghWfEvhskDo4ffJFUQlpT7USS2Dh7ZVm3gIisjNPqIy/0JkTQMDgGwJqvEkrTzRNSv88YcBjtnJTab+pCUGlH/SqlNxwKtWau9/qAphP4an15llk2tXDvKbYOCVYGZTxRH92RExSOk//gwRBkFGx0Ekvk3S9bmiSpzZDVVuayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ5PPF77D28E3C2.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::837) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 05:54:22 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 05:54:22 +0000
Date: Mon, 13 Jul 2026 22:54:21 -0700
From: Peter Fang <peter.fang@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Kiryl Shutsemau <kas@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <20260714055421.GB3178326@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <aiv8mrJDgs_e8eLq@thinkstation>
 <a95a286c-5fa9-47f7-8a9a-4ecf3aafdfee@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a95a286c-5fa9-47f7-8a9a-4ecf3aafdfee@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ5PPF77D28E3C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b84c5b-2371-4681-0c92-08dee16c5a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tU7JHXW2zRZjVAYdrxiSTNg6stSmbqnYx14k4BKn6qw410FnwtfuxAmk6DNhBhfLFRrwuGnqRNIng8ADNSoF4dMSPF2rVHTWIRLmrPybDnvjd80HP06+h5hijNcgmyWrrfbEVOP1iiTCvSOu6+wEQcfcC9Xb9TFZ8JdpVJIH2j7GOj+5j9OCr4teLtu59nZiQ1GGarnncdSyp0gmXOcDZatsoRt2L0Y/SAes8jw/xgTY0Imwyy4EzbQX1ezlV3ED/0bepeEEOjlQzyvwBYO9W74KttoXBJtDxXt2ugwqj/cTptK77mHlPlXT054WLyuCZuvPKjgx0O1YQFH/k1uQT1j/hBp7UZN+yH93MTE3RQNtcEwSVh8el+S63i6M3KOEEgjHX2xa8CMsrGd2518cxktmb6IWfrGr8yTGAZThuwVDxTurJDQILe9ZkocDvPQ3BBKZ33fadNfmFwC+i2NP4ulxwKZuiLi9rjPn6aklun1Eu+OO68y8B0QWNY/+5Rwrdj8McIm/vGGvwtI7ypoM79fg+lTVFvMZYAKkJ4WV0vVVzUFLig5gE9t5Z6VSlK32XYq1mffU/MeEj1DFVQdjel6xLI9y2vJnf6YzmSt+vkz6JTBmfQL7P26ycEcixIq4FZ7rNrkLf6phTv1ZGZ7HSUT0R9eXuWslocXvsOVJk2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGR5S005Vll2UmQ1TGZjUmdPcjdkOENHdUxmT2FUaWpid2R1L1dhZEFSMjB1?=
 =?utf-8?B?MnpEa1ExMHBWNGYyUGM1RjFseWhiQTVtVnlKYjBENFcvNTh2VGpTRXlBTEgy?=
 =?utf-8?B?aWZYZHhYV2hzV0Uzbk1PbkhGKzVmeTNIRkFtbzdDMmcyL05xRWxzOWZtUjRF?=
 =?utf-8?B?K3pFVndzVXNSWXlTdjlibVB1YTRKTlg2WElXaW5IM3FYT1g1T0xKSWVLYkhs?=
 =?utf-8?B?NC9LVUZnZ2RMQm1tb0xMU2M5eW9BdExNWHBCUThqTFRodEZPMGxKKzhNdStI?=
 =?utf-8?B?TGo4YWVZVStRZUtVUWJtV1MraHdCb3dTb3R2SXBOS25HWDNHbXFCYjI0UkdZ?=
 =?utf-8?B?Ni9qUTRIaDRDTHJjazVRTHpneVJ1U2M4L25yUitFQlVGaU9RdG9SRTJrS2JF?=
 =?utf-8?B?bnVGZUlzeWg0ZTl1bjNpanpqN3dka0E0QXZWU0JNZTBtdjAvcWszT3NWVkRE?=
 =?utf-8?B?OCt5QTJmTWZUa1VIZWlKb05uME5MNzVYSHR6TWptQ1RPUmZaRmo3Vi9pSm1m?=
 =?utf-8?B?VzZUaWtTUVZ6NmZaaFdRbVJvaDE0cTIzNmh2ZHFVU2gxY2Y2eU9POS9XdVc5?=
 =?utf-8?B?QStOdGcyd3ZEWUZrbnV1YkpNSlhmSnZUZ0h5NWp6bHFlSVp6RnJHRVhFSW9Q?=
 =?utf-8?B?bG5pSE1teXJ0VVVZWHN6WEdKL3JVdTlFQmNaaHlDN2luTHl3cTVncVlBdCt5?=
 =?utf-8?B?NDVDRmFza2Y5dWIxdlIrVWUzUlgrTGRWZUxVNlBaZnVUUnpWMVpEVTRmZjQx?=
 =?utf-8?B?SGtFRFp2TDQzS09MekpLTXJSY2ZURVRPc0w2YUJBRVRuaGtPa0lDYXB3MklV?=
 =?utf-8?B?ZHJKUnRkejRyRzZKL2I1bFhVQk52Z1U2YVFFVUNxcndrYkEya1BnTWgyUzBu?=
 =?utf-8?B?M3lTbFhDNUhqN3M4RnlvbzFzVGlnZm9HYzBBSmhRQWpSaGQ5b3FLcXBVSTRY?=
 =?utf-8?B?VEEzem9nK3czc3RpOTkyc25wbitTOEI4bDIvNDlFMkI2NmZyNjlOZVZQU0ta?=
 =?utf-8?B?SnRURFlPcm5XVjVLd3BhUUI0S1IzY1FXa1ZicnVoeVVKRFFHcXV0ZVBmUlJi?=
 =?utf-8?B?QWFXUWNRdUswSVhORjFGUzAvUGxlVG9aUFNLNEhIMWtTa0V0eTQ5VGpyeWJK?=
 =?utf-8?B?aXBLL2V6eUYwL05XRWFpSEZhdWZyZDFMKzlwY09DMXFWZW9qOTZGdmFTbjhK?=
 =?utf-8?B?eG1XRXFjcWlpNU1USHVkVkNmNkhiVzJUWm5WSkFuS1pmaEk5b2RPNERoUjNy?=
 =?utf-8?B?MzN4dDdUSFh0RmxjUlQrdCsvUlBkYktlNlE2YmsvY3hkc0ZXRFljL2ZOWFNU?=
 =?utf-8?B?MjFyQTAvbWhaa25CazBwMzZWdlBCNXVDdnRaZDdRWUZUM1RUK296d2ZKM2lM?=
 =?utf-8?B?WkJqMDVTQ0hVODVBTWlPM1ViTlVVOG4rVmxTdWZvdVBUMFR2Y1V4TFVXa0Iv?=
 =?utf-8?B?bDd5dVBDbk9XWkhqbGJCR2pZL0MwVkIvWGFyaURxMnZaeDNTNTVsbmFOSzBN?=
 =?utf-8?B?ZkI3clRMNTVoVEVjSm5TaWFBUmR5RTBtdk8rbFBJQ2djUTZLbzFlY1FCaVB1?=
 =?utf-8?B?Q2FxK3J5bzRySWlmMmhJcUNseURlS1BSS01pNE0yUHpYMnJ4alZOaUQzdTBZ?=
 =?utf-8?B?U0dxU0J6U2xjQ1F4K09nTGRhY25tUnozNDFXOGRCK0NzYUhrSFZsMGtDOXFG?=
 =?utf-8?B?ajV5TXMxWTl2OG5tYkJHamxZWG80YVVkQWgwT21neXpIcU9laUhlUGU0S1Jr?=
 =?utf-8?B?MUFBN3ZoUlZJUXptN3hFekxINWJaY2FNSk5xM1Yyb0Z0T0Z6VDNrNUQvTVhi?=
 =?utf-8?B?Zm5GTHYrUmVsOWpUOUMxSjV6UWxESFNSRHMzcCt1ZHpzVkREbkJCTVZMa3BX?=
 =?utf-8?B?Mkdqa1kraythbmJwYUl6V1dsdStvUnUxelRQWnRtTEVGZkxjWndCSG9TRjV1?=
 =?utf-8?B?YzhMNnRsS2tEWVhSOEY1SXYyVHBjMmpPUTFnUmxSdS8wSWN1YUtvRUU0Vldo?=
 =?utf-8?B?dE0yQVZkY3FuekVyUGVTcDJRZG9WMWNobG15SjJUWGpYS3Y1bUVTYzV5NW1r?=
 =?utf-8?B?OHVSdVF4UHc3N0txOGg0Y0lMUXRCM2NQQzVtV2MvaWRsVzZ6ZWN3SVJQcVBX?=
 =?utf-8?B?d3kvais3UmxWK2dIMXhTM2x5RHMyYlRWQUhzem5wcUNXdmRNOXdFenExQlR2?=
 =?utf-8?B?clBFd0xyY21EWTBkeXp0bVV5MXdFWThPUExzRFVTL05YcHcrRlgyWXAyRUV3?=
 =?utf-8?B?akIrV2pQU2c2a1Z1djhnUm5YbzRTUU1zTHlCYjRLeVR3cnNXRS92TFo0STNp?=
 =?utf-8?B?dlJRRTZpNmdvRE0zd292M1hJZXZJRWFBSDBZREh0aXVIc2NWQ01KQT09?=
X-Exchange-RoutingPolicyChecked: a3Wf+Zql9bSLeBXzaNS93RcA7DFIkPlCI1q7nVldsBjyHWk8VWypEe+3IEr2uP8c8Z9RySlk+6xiX6dapeNFgC6J/oii8KmNg/qmx3MuMe7ueEo1ckRYgr18EPlmgQskDYdt/eosBcLGONVb+vCINMBJLHx8cKb4myy6j2ONG6h/6tmepqgMiMa2GR0agMmi1b+s9sVRbNvmrSeQaVxlzp255UFOnG/BKrvkfriBR6ghVuBC0iOhNmKLo4vLfsTCYgBTRR783HFs+FHHxIXQcV/lvMvVScWhOWG7NgMY9YQmQ8fMT++LnNSQzVOS+9xlPX4dP/jqDxHsq5RNIbWuvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b84c5b-2371-4681-0c92-08dee16c5a60
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:54:22.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwyhUvc+f/Kt/RSXcNIzgWAkxUmwnTsIOwEDsPCrjvBUkydYVwgM349+JBDoIaHZwdSDG/vlxC2jRLyHwCZO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77D28E3C2
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 10:38:40AM +0800, Binbin Wu wrote:
> On 6/12/2026 8:36 PM, Kiryl Shutsemau wrote:
> >>  
> >> +/**
> >> + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> >> + *
> >> + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> >> + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
> >> + * modules do not support this field and return an error.
> >> + *
> >> + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> >> + */
> >> +u32 tdx_get_max_quote_size(void)
> >> +{
> >> +	u64 val, ret;
> >> +
> >> +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> >> +
> >> +	return ret ? 0 : (u32)val;
> > 
> > Cast is redundant.
> 
> I thought in Linux kernel, the explicit cast is often preferred?
> E.g. as documentation of the metadata field’s width here?

Hm... I asked AI to find some patterns in arch/x86, and looks
like the explicit cast is more common... Kiryl are you okay with me
keeping the cast?

> 
