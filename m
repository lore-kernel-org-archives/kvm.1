Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE9382F31;
	Mon, 30 Mar 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853636; cv=fail; b=FJ4IK329IkLirwmbW4BMGN2Otmn6qxURweM3DbzZEr4Zie7+TEfKEojiT3Wftr6G4N3puvB8rBmEQ0KuV5IL+sPjNRDd9w7ZGIQSlLyx9mwu+qbQJm/gJ4dzr7Fvp6VHuqho9wfBZbhRhFqkEOrSq0t7rwAIJjOo/wR82JYBSvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853636; c=relaxed/simple;
	bh=gyKdwK8RmCERsQwONNRuNiCj/4K/Heg1iO116MDBZQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J+d1aEUcOOyjBrOfREcM9fZ5ni/zfamJ4OndfdI5Dg5XVoaD+lwrW+Qq/VT4VBIP2dZZzPuPdAaWrmaoRJRhSgLfLcOKuQ4bRhDLk7v7IAFExC8MWCEnODKcd4xV/xDUxfEC26TUNM5qHo3oQapBgOUQyerREVqg9ZxcYB52/0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmFP6TGN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmFP6TGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774853634; x=1806389634;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gyKdwK8RmCERsQwONNRuNiCj/4K/Heg1iO116MDBZQo=;
  b=QmFP6TGNTBSm1CPTzlUOMRKEjy3ZQx+c+3z3oMCS1rfcQeIXy2mI2t6P
   goGlnWocvd+O8MW9MvZYYnU6oc27YbR3qPzrGoWhOOaDt5RgsEyPM39W6
   8g6jh0p+jmeb18zu3/E9tx7ckhxIr6RjaAmbpxG/uJF2LI+A0W5ZmaJtX
   8DJVc8NSG8oP2ptu+YLfdj+jW6brOmMgZFf9jmYETq3dGhjtqw+Es092V
   iNZXBCbozJReQ5GmteoX/OF0Jb/D0f64YDagk3t+OLhAPB46SM/xuW9ps
   LhhF9Fa/DXlpw5Sypb8/w+iyP07xBUBGBhT9pMYsFRTAYmeVoOyxh9Hud
   A==;
X-CSE-ConnectionGUID: wDGZF7jhTU2S1fUS+lbjbQ==
X-CSE-MsgGUID: sWptmz6QRzGYtoEd+xMdNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75733358"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75733358"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:53:53 -0700
X-CSE-ConnectionGUID: BqVebccSRmSdudEhA/m/jA==
X-CSE-MsgGUID: iGJK81FXRhazX5DXHK9loQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249009903"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:53:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:53:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:53:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6ASk/rBAv/heUoqjE8J+HUylhFx1N6iRmW2M5Wj2OsQWWzZ7qRBDwGtiloIcw4NxEkumf+kXBZ/B33MKLSDOTtWy0rX9JVX0nMqQrLl2i66XJX5Hp9hVo2PLpevHNu54gcn1JwDJpgiHgk0DMqoqr0xhDMhVz5kTyp100fQ734GLVN7GxL1oo0PxuEJY4T53UGoNIS9IsUSeWLk7B64H933bbcaGMmHC2ESk1hauWaz6sM9MWSCsN+ohi3QgjkWvaOoVurcwi+Ha2SzjkSsfyQJNIza8JPn3kBaHavHqeXxL2lDw2d4LS2YLfOssGCjVwk5yyFKrR+01n1h3y7IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t1nwZcLUXm704YSXkDMrxjqChG8m6Er5He5XhTNhHg=;
 b=IKEtSfZYBPR9j0TfLNsvXL7vOyFxjSWnBLZA879Y8pG+RJ3spwRgcIY6B0TN1OyxC9hfC7Fn/xENKsrOyi4B4wj/mFFTyUx14Db2nc4TXLzN7pE+jm3KIM4nlkqBQOlPzYNhwDi2hjN27xmXIgsP63COTiE734oUk2nXaKlHlh8Gj92QJ9h/bSO6nLHfXm0oh+0vMkHSzpDBz33gHw1rzNJzjOn4i+EodXrwNRhMcLF6pGmNWwO3G+sFkggb/qsxsIukVPeKZ9K7AuZb5gP8C5R9xmxCGwOJoDjDKQ/oFluQTRXb+AbPAk22QxtxBMHjTKwS931peXkvZz2MzzyLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 30 Mar
 2026 06:53:49 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 06:53:49 +0000
Date: Mon, 30 Mar 2026 14:14:15 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: KUZPR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:d10:33::8) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: ba600082-7d2e-49c3-36cb-08de8e2918b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: euLKqGPxeYItitp5qr1wuA/Ekksg63RxeX36e//5ADwwhtj36/5RCGMNbaHzWgV5Q2SL76bMGK2a6pP+Xhmk1kpcHpOSen3fqW4TAdlNYF3srb/DGW+H17WiG3vrCPMcIySuv+TZ3tskKIGu/djJl4RUzHLHzb9AYlF4n3f7iLCfM+eTKfgB4lHCXqyUNoP2mVcyMHPFKUpDD3qPt1EuZL0wNoMrGMP+GoAg5sjUAySYWhxszIaUnmYOl7kNRpJxn/rwUFb6nbpsqtsuwiAZ28NUNBxraLbCEAunf1zHofl5NH5vpcirupUVE2OaPZIahPaK2UWoe2mzkPpqqncqyWS/IKdFGQ7sp3olp+TooQwmVqKq/BTeBNmgeNKhU/gGzT13Flyaak4hRhDVdUqCLYqF5rJgVV7p9gHH96/8BEyqGYpeEisX6dWVxAQ20l5zzTufOITfgqzUpgP6ZN7VMLWUk5mow5m6DTnMSEfYI7tUAszBhPrIFvZlsvvAaoDmM4BLJDC5alQGsPCrgl/PbSztS7i7o9xbOILESS/aSX5qcWNJ4y0ySs+Wch2oXIArM26veR+pPlVlXz7cWtLHJ1WK6LmsFre4moDYtI2X6QdKx72X/8zdM6zenVb9oxaKikrtFxwMYIO0oOyesZshVJ0k7/BdOOlABH06pkxHRQ1/Y2myrwA4iyDdOgVo4TYhHzw4sBjLdu6N/FP3OPF4+0B/MOfWW55qjcL7I8DEGnWJxartB+suuTJ+1OAmH9qV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpjbUxWWFhHSlM5cVhydVR1M1VKRHFXTVArUGRGaURzemRjbzJ6R3FqblpP?=
 =?utf-8?B?M3dCK1g5OU8rajU3YlQxQytuTkUyakNlc2hBKytGZm9oMnVuZ2ZBYlltQWZ4?=
 =?utf-8?B?UU0zSkxmdWEvWFVVTEJyZFVXb3MzWm1XODJTcDgxVGRHRVFhWDdIemthUUtx?=
 =?utf-8?B?Y2pBLzlsQXlGelFwazlKZnNIWnpzN2ZwdjZwTXFFTFpKRHBscnBuQkdyWTBq?=
 =?utf-8?B?RlVPYjJMVDdhbFpWMnVHUWY4cmhQYjA1UldCUUhXYVZObFRzc1p2aHd5SFFV?=
 =?utf-8?B?Yk54cUFTRVBMcU5MTC82cDRUQjhJNW1ZYnlsaUt1NXdNZzNWcTV2eUQ0SVM5?=
 =?utf-8?B?NEhJNVhVWDlYNDRvUDZvbEg1YXA2OVZhdkE1L1V2a2ZhNXdqeXhrR2I1bzFM?=
 =?utf-8?B?NlY0RGV5UUFRRkNwVW9BSnhjZjlqbFRVVTZ5dVluMHBhUzFrRTBTOCs5ZDE2?=
 =?utf-8?B?b2JTY09oMW1KaENnZmJMR1NBOTBrUHhqNk1uRkl4VWxlVHJtaW1Wa1RXaExH?=
 =?utf-8?B?V3RhYUMxT2x2TVZSRFRidFJubG1qbW5VUWF4SXRaRWJKUFk0NTVXODlXQ28v?=
 =?utf-8?B?YVUzSWllVy82UjBENXZpUy9xSlZteGU3TlE3RW05Q3c1VXMvMDRSZ1FDNDE3?=
 =?utf-8?B?QkQ1ZWt1cWQ0RTNiMXNrQ0UrYXBndkY2V0kreVhoVEdYK3VKMWhBM1k4eW5s?=
 =?utf-8?B?SzZrd2xwNWxXQ01FTWcrc21XSUhSOGF5UHVYcCtQQ2lTNDh3enBDZUZ6a2Rw?=
 =?utf-8?B?LzdXNVVJWTdaV0FjbW5xSUlPSWhmODNBclNRSUQ3M3lROWs1VmRkMUtCUkRV?=
 =?utf-8?B?T0tXL21DS0xmV1lTL2RTZjJyb0R2eUpUMlgvVmlnajRYQ2l6aVc0WUViOXkw?=
 =?utf-8?B?YjZQL2drSGR3aXIzYUhnMU5iNXpQV2hKNTQzY1NYTWphRFBVMWw1TjVTYkdn?=
 =?utf-8?B?bWRvRHVEcWdYbmd0UEE1MmRqRmo4V3ZUeXlRdC95NnA3eTZWYUVoRmdvZDJQ?=
 =?utf-8?B?OHY2S3NaSDg4ZHJmaExXYyt0NnZkRG93V2xRT1VtZUEydVMwMDJDS203T1VU?=
 =?utf-8?B?dzZSTGdJYlhUY1lIRUpLN2l0QjBwUTVDZVVNaVA3QU9kR2tnWEFhbnpKRk8y?=
 =?utf-8?B?azlkaVZwZkZaeWdod0MwSjlJZ0NtRW1sSDdRNXRGTUpxd04zby9oZkhibGxz?=
 =?utf-8?B?end4YUFsdDlsWjhmTmFzNGRCYWNRa1Yxa1dTZzJtNXh3alZHTnZWTG9lRFJz?=
 =?utf-8?B?SERic1AwTGdmTStGcEZHMnlIVmNQZU1Zdlg5T1Z6aG1sQzFjNS9iTk1GRENP?=
 =?utf-8?B?Z3pkWUF6WGdtTjZnNzNWN0JwMlVvaElsWUpGY1h2ZVo2VW5jRDN0WVkxbHZh?=
 =?utf-8?B?cS9SZ2F1OUtrTGY3Q2pOQzl6VmxFcmtnVklXdDIzV3B0M1pTZGpkcm5DKzc0?=
 =?utf-8?B?M2JyM0NhdDJaV3dKQWtPYStxSmxMNjZETldyMlN3M2lzb0VGUHdGWUlpN0pl?=
 =?utf-8?B?ZXUwaVZxamtjeTZIMUc1SHlid1NPMmtDdUh2MThRa0tkVytGWS9TQTUxWTVT?=
 =?utf-8?B?V2wzekQrTEJ6Y2I0Q29DWFdPaHQ5eis5MDlORDZxQ0ttdHFselRiSjVLb1BM?=
 =?utf-8?B?Rk1kWjBsalNndE03dFVpWGFOOWlXcS9ZbmxmS2UxbWg5aUZKckcxWGRBRkJr?=
 =?utf-8?B?QzFDc0RrS0dkQm5RTU50WEQvRmZ4ZHZ2N3JTZlNuakxFNE1ZOGZyUC8vYjFi?=
 =?utf-8?B?OFJYeFRRREtuS093Y241cGJpWVR5M05rZEVDQko2Z2c1cGowY3U5Q0hFSkk1?=
 =?utf-8?B?MU14bERXNjZKbHErMXBSZUVoY1UwTEhDcGUxUVlVT09sc0tDU0FXRFlHNTBT?=
 =?utf-8?B?ZGtsazY4cVRyMjVRdmoycHRjd2VMRHNQeElvYnJkZXowcG9acU1TR2FiSzVF?=
 =?utf-8?B?SlhLb3JJaVBYb0g2cmJONWRqWUdZeU9RZ2N3eEZBazNLcWp2QkcveHpqUVI1?=
 =?utf-8?B?aWZHSGdwZkFZbGtPem4wOFhqV3Q0RWlaNXRWck1HSVU4OExMaGw3V1Fmd0o1?=
 =?utf-8?B?UENIODlLSEw4SEdYN211bEo4VWU3MWo4dWY3bk5wOFBjWmdkS1ZiMzJBdXYy?=
 =?utf-8?B?SFZ2V0o4UWNBN1JudEk5K0FVUXN0elhmb1Mvc0tjS2ZiL3k4dlEyNGRsWEdT?=
 =?utf-8?B?NlorVHZpK29KQTFqSHlkRFFqZ3diU2NzUjhIZWRVNmdUUFdzWkw5UFJ3bUJp?=
 =?utf-8?B?UzBpd0YvVnlzb2RTUTc3YU9mYVAyOGZUVEIvYmV2UnRMQkVVNVpFVXR0bFRP?=
 =?utf-8?B?Z2xFWXJyYTVwVSswR2tlTGVTYnNhL2hzZ2xIbXY5V0FFZzREUEV0Zz09?=
X-Exchange-RoutingPolicyChecked: Yo1mmxqOaqYL37RpHurIiPJ3daB8aFJsxymJ+g4TJyhrHR1UaJRvnLm+onE0Ry6Q8Zd67idiIQsEaqMjIG4tbDtKSKbdQZyvliMMHxPtniq9XdYzHQPX4S3nBdMUWCCHH7ieS7zh82A9gfxpFtPQRnhXLQK/jg7K2wYN+ZhbeE/vcUhEZzHG9sHlvRPHOoCpAU74TxHxRG57knAga71cZLoL1S2Z7YHxO3PSD5t9zJSDo3s6V8CgZa7D1MDM8wB22kxse5eAHWPjnJ0xdDPTu3I2aaVXQz2O3JijxwVNAm22gorkN3Gp8wbwuuGxWTwOOGXO8j4cJtFgt67pHb0oVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba600082-7d2e-49c3-36cb-08de8e2918b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 06:53:49.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP6+yd6R26CCzv2/7io4PIhEqtt2xmZo9WdiuK5WY+b7yIK8FqkQgX+JpMPjmX3tq7E8Jg3Ngs3PVetVCwhXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:11PM -0700, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Centralize the updates to present external PTEs to the
> handle_changed_spte() function.
> 
> When setting a PTE to present in the mirror page tables, the update needs
> to propagate to the external page tables (in TDX parlance the S-EPT).
> Today this is handled by special mirror page tables branching in
> __tdp_mmu_set_spte_atomic(), which is the only place where present PTEs
> are set for TDX.
> 
> This keeps things running, but is a bit hacked on. The hook for setting
> present leaf PTEs are added only where TDX happens to need them. For
> example, TDX does not support any of the operations that use the
> non-atomic variant, tdp_mmu_set_spte() to set present PTEs. Since the hook
> is missing there, it is very hard to understand the code from a non-TDX
> lens. If the reader doesn’t know the TDX specifics it could look like the
> external update is missing.
> 
> In addition to being confusing, it also litters the TDP MMU with
> "external" update callbacks. This is especially unfortunate because there
> is already a central place to react to TDP updates, handle_changed_spte().
> 
> Begin the process of moving towards a model where all mirror page table
> updates are forwarded to TDX code where the TDX specific logic can live
> with a more proper separation of concerns. Do this by teaching
> handle_changed_spte() how to return error codes, such that it can
> propagate the failures that may come from TDX external page table updates.
> 
> Atomic mirror page table updates need to be done in a special way to
> prevent concurrent updates to the mirror page table while the external
> page table is updated. The mirror page table is set to the frozen PTE
> value while the external version is updates. This frozen PTE dance is
"is updates" --> "is updating"?

> currently done in __tdp_mmu_set_spte_atomic(). Hoist it up a level so that
> the external update in handle_changed_spte() can be done while the PTE is
> frozen.
> 
> Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
> Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Based on a diff by Sean Chrisopherson]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 150 ++++++++++++++++++++++---------------
>  1 file changed, 88 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 338957bc5109..db16e81b9701 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -320,9 +320,9 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
>  	}
>  }
>  
> -static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
> -				u64 old_spte, u64 new_spte, int level,
> -				bool shared);
> +static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				gfn_t gfn, u64 old_spte, u64 new_spte,
> +				int level, bool shared);
>  
>  static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
>  {
> @@ -471,8 +471,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
>  			old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte,
>  							  FROZEN_SPTE, level);
>  		}
> -		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn,
> -				    old_spte, FROZEN_SPTE, level, shared);
> +		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
>  
>  		if (is_mirror_sp(sp)) {
>  			KVM_BUG_ON(shared, kvm);
> @@ -508,22 +507,15 @@ static void *get_external_spt(gfn_t gfn, u64 new_spte, int level)
>  	return NULL;
>  }
>  
> -static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
> -						 gfn_t gfn, u64 *old_spte,
> -						 u64 new_spte, int level)
> +static int __must_check set_external_spte_present(struct kvm *kvm,
> +						  gfn_t gfn, u64 old_spte,
> +						  u64 new_spte, int level)
>  {
>  	bool is_present = is_shadow_present_pte(new_spte);
>  	bool is_leaf = is_present && is_last_spte(new_spte, level);
>  	int ret = 0;
>  
>  	lockdep_assert_held(&kvm->mmu_lock);
> -	/*
> -	 * We need to lock out other updates to the SPTE until the external
> -	 * page table has been modified. Use FROZEN_SPTE similar to
> -	 * the zapping case.
> -	 */
> -	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
> -		return -EBUSY;
>  
>  	/*
>  	 * Use different call to either set up middle level
> @@ -537,17 +529,13 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
>  		KVM_BUG_ON(!external_spt, kvm);
>  		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
>  	}
> -	if (ret)
> -		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
> -	else
> -		__kvm_tdp_mmu_write_spte(sptep, new_spte);
>  	return ret;
>  }
>  
>  /**
> - * handle_changed_spte - handle bookkeeping associated with an SPTE change
> + * __handle_changed_spte - handle bookkeeping associated with an SPTE change
>   * @kvm: kvm instance
> - * @as_id: the address space of the paging structure the SPTE was a part of
> + * @sp: the page table in which the SPTE resides
>   * @gfn: the base GFN that was mapped by the SPTE
>   * @old_spte: The value of the SPTE before the change
>   * @new_spte: The value of the SPTE after the change
> @@ -560,15 +548,17 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
>   * dirty logging updates are handled in common code, not here (see make_spte()
>   * and fast_pf_fix_direct_spte()).
>   */
> -static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
> -				u64 old_spte, u64 new_spte, int level,
> -				bool shared)
> +static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				 gfn_t gfn, u64 old_spte, u64 new_spte,
> +				 int level, bool shared)
>  {
>  	bool was_present = is_shadow_present_pte(old_spte);
>  	bool is_present = is_shadow_present_pte(new_spte);
>  	bool was_leaf = was_present && is_last_spte(old_spte, level);
>  	bool is_leaf = is_present && is_last_spte(new_spte, level);
>  	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
> +	int as_id = kvm_mmu_page_as_id(sp);
> +	int r;
>  
>  	WARN_ON_ONCE(level > PT64_ROOT_MAX_LEVEL);
>  	WARN_ON_ONCE(level < PG_LEVEL_4K);
> @@ -598,9 +588,7 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  	}
>  
>  	if (old_spte == new_spte)
> -		return;
> -
> -	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
> +		return 0;
>  
>  	if (is_leaf)
>  		check_spte_writable_invariants(new_spte);
> @@ -627,21 +615,41 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  			       "a temporary frozen SPTE.\n"
>  			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
>  			       as_id, gfn, old_spte, new_spte, level);
> -		return;
> +		return 0;
>  	}
>  
> -	if (is_leaf != was_leaf)
> -		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
> -
>  	/*
>  	 * Recursively handle child PTs if the change removed a subtree from
>  	 * the paging structure.  Note the WARN on the PFN changing without the
>  	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
>  	 * pages are kernel allocations and should never be migrated.
> +	 *
> +	 * When modifying leaf entries in mirrored page tables, propagate all
> +	 * changes to the external SPTE.
>  	 */
>  	if (was_present && !was_leaf &&
> -	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
> +	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
>  		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
> +	} else if (is_mirror_sp(sp) && is_present) {
> +		r = set_external_spte_present(kvm, gfn, old_spte, new_spte, level);
> +		if (r)
> +			return r;
> +	}
> +
> +	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
> +
> +	if (is_leaf != was_leaf)
> +		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
> +
> +	return 0;
> +}
> +
> +static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				gfn_t gfn, u64 old_spte, u64 new_spte,
> +				int level, bool shared)
> +{
> +	KVM_BUG_ON(__handle_changed_spte(kvm, sp, gfn, old_spte, new_spte,
> +					 level, shared), kvm);
>  }
>  
>  static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
> @@ -657,32 +665,14 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
>  
>  	/*
> -	 * FROZEN_SPTE is a temporary state and should never be set via higher
> -	 * level helpers.
> +	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
> +	 * does not hold the mmu_lock.  On failure, i.e. if a different logical
> +	 * CPU modified the SPTE, try_cmpxchg64() updates iter->old_spte with
> +	 * the current value, so the caller operates on fresh data, e.g. if it
> +	 * retries tdp_mmu_set_spte_atomic()
>  	 */
> -	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> -
> -	if (is_mirror_sptep(iter->sptep)) {
> -		int ret;
> -
> -		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
> -						&iter->old_spte, new_spte, iter->level);
> -		if (ret)
> -			return ret;
> -	} else {
> -		u64 *sptep = rcu_dereference(iter->sptep);
> -
> -		/*
> -		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs
> -		 * and does not hold the mmu_lock.  On failure, i.e. if a
> -		 * different logical CPU modified the SPTE, try_cmpxchg64()
> -		 * updates iter->old_spte with the current value, so the caller
> -		 * operates on fresh data, e.g. if it retries
> -		 * tdp_mmu_set_spte_atomic()
> -		 */
> -		if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
> -			return -EBUSY;
> -	}
> +	if (!try_cmpxchg64(rcu_dereference(iter->sptep), &iter->old_spte, new_spte))
> +		return -EBUSY;
>  
>  	return 0;
>  }
> @@ -708,18 +698,49 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  						       struct tdp_iter *iter,
>  						       u64 new_spte)
>  {
> +	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
>  	int ret;
>  
>  	lockdep_assert_held_read(&kvm->mmu_lock);
>  
> -	ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> +	/* KVM should never freeze SPTEs using higher level APIs. */
"higher level API" is ambiguous. e.g. kvm_tdp_mmu_write_spte_atomic() allows
new_spte to be FROZEN_SPTE.

What about just "callers of tdp_mmu_set_spte_atomic() should not freeze SPTEs
directly"?

> +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> +
> +	/*
> +	 * Temporarily freeze the SPTE until the external PTE operation has
> +	 * completed (unless the new SPTE itself will be frozen), e.g. so that
> +	 * concurrent faults don't attempt to install a child PTE in the
> +	 * external page table before the parent PTE has been written, or try
> +	 * to re-install a page table before the old one was removed.
> +	 */
> +	if (is_mirror_sptep(iter->sptep))
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> +	else
> +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
>  	if (ret)
>  		return ret;
>  
> -	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
> -			    new_spte, iter->level, true);
> +	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> +				    new_spte, iter->level, true);

What about adding a comment for the tricky part for the mirror page table:
while new_spte is set to FROZEN_SPTE in the above __tdp_mmu_set_spte_atomic()
for freezing the mirror page table, the original new_spte from the caller of
tdp_mmu_set_spte_atomic() is passed to __handle_changed_spte() in order to
properly update statistics and propagate to the external page table.

> -	return 0;
> +	/*
> +	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
> +	 * restore the old SPTE so that the SPTE isn't frozen in perpetuity,
> +	 * otherwise set the mirror SPTE to the new desired value.
> +	 */
> +	if (is_mirror_sptep(iter->sptep)) {
> +		if (ret)
> +			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
> +		else
> +			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
> +	} else {
> +		/*
> +		 * Bug the VM if handling the change failed, as failure is only
> +		 * allowed if KVM couldn't update the external SPTE.
> +		 */
> +		KVM_BUG_ON(ret, kvm);
> +	}
> +	return ret;
>  }
>  
>  /*
> @@ -738,6 +759,8 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
>  			    u64 old_spte, u64 new_spte, gfn_t gfn, int level)
>  {
> +	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(sptep));
> +
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  
>  	/*
> @@ -751,7 +774,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
>  
>  	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
>  
> -	handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
> +	handle_changed_spte(kvm, sp, gfn, old_spte, new_spte, level, false);
>  
>  	/*
>  	 * Users that do non-atomic setting of PTEs don't operate on mirror
> @@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm, struct tdp_iter *iter)
>  {
>  	u64 new_spte;
>  
> +	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
> +		return;
> +
Add a comment for why mirror page table is not expected here?

And do we need a similar WARN_ON_ONCE() in kvm_tdp_mmu_clear_dirty_pt_masked()
or clear_dirty_pt_masked()?

>  	if (spte_ad_enabled(iter->old_spte)) {
>  		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
>  								shadow_accessed_mask);
> -- 
> 2.53.0
> 
