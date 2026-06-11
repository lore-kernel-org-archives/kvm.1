Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29D2D3EF2;
	Thu, 11 Jun 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194889; cv=fail; b=i44cZIyG5hRLY3Nsr3/jSnzN+4/UaYkytwT0QEL3uWgGxWgqyMTit0Pr6P0qb4WJ4cBwUYnIA5m059jb8Bgo/2JfDrj8FuvzGZltAPKqGSwHvWMQ4cORHcNPg6wQaPVC4wtSSEYJaQH8FZ7qQjy5UHSILgaSilrhchXx5GLB5f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194889; c=relaxed/simple;
	bh=zzbU2Sht1tObfrF+gS3lJvWN/299F6kZwY+jC2mB18E=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MVfUbcZyUIbfwgMf3nU6q1i13mYZ7aOKMCTgcKVELmGDP/I6MZdWXRnEFUyPhKcTHRcTKe6ulqsgcEC7/4zBeOWcP7mLtxwLpUXxLefhdb9DR2GOcWfTfdaR40CtvBTxUuNX+iWNVmuQUdcwCV+tR2M50CuXtf0s22Gwhopuy0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myE0GzhG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myE0GzhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194888; x=1812730888;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzbU2Sht1tObfrF+gS3lJvWN/299F6kZwY+jC2mB18E=;
  b=myE0GzhGXbH+9DIHfrjehQ9sSg3uE4WZwjOmaPgZOzE2lCJNOLOR0jyX
   3peKIM37f82ORz6Zb+1eFAicp4Iyb3C/WgSiZecgJEaKKZf5udGbCxGbH
   n1VdMvFdPljQnUfejN4Sk8Sy1EAhfJqa0jZELCjSyVaMqElV5xutPEF6w
   82B+LosqCpjRDih3YA3qtOFN9HWs0ihGTXavXe2JzZYN9pCMWa+LUV24/
   Q+xtKir5AggwbvAQkT0KvmIUyg7J4HR2TDmJnA2FCd5yoF0P1WOs0jf3M
   d5Aq7LTkW0iIAJijjkKZ1Xj3Siexne1h4Ozvytmm63xLPZEW+RCjLskD/
   g==;
X-CSE-ConnectionGUID: 00y6eQtXQM2+bcD9nCA+Gw==
X-CSE-MsgGUID: lFSKp+xyT4CT3Bt//EK/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82205791"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82205791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:21:28 -0700
X-CSE-ConnectionGUID: ueYGL4GVRy6cZceYbsbMLQ==
X-CSE-MsgGUID: q1uVhVVSTUKO4Gncb3STBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246608048"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:21:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:21:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 09:21:27 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnlqfttCgpg8CKE49O2uZ1Ur3srUk5laEyoSh7Sn9stg1fGkMkIViWP0MxVSYeZjzKKtmUQ1cmjpGrd24cXm/vnS5iOeV+BOhhMGM127QCZIyKaEI184GJ8cATCogiyCyEL55W4fdDxj/hr2G357w4Irl7b8qaPfbrUu/6slByHIk2MJn3jQZWK1ewQZjFyNnk0x+SrPzwHAeez5XNY8Alpas0Ug2CV1FWj96yJXWlWgvTHqwB0vnLkQo4T6BhP3HZNUtnNDtKwuDD/JG6rZRCM0iSejYq3yPL3D5ZypXy3u2QtwS06kpKlKwZBNQdHC3Ci6Vy4sGseE8W3iz0EGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb4zt/dyZ1293hiq/jq93Luvgokx8q0b7y5WsxyTAiM=;
 b=ridQ9LJVlmLtxrhYWQgRxdSGcyQuB9syCtgaE4Lk6HlU9p7ywyq7N8+Liu8Zrl30tBTK2GSQ/G8yYYWH/vaiVU+VJkzghNZSiKEdWJcT17tlTaLnkso9mSYmAsoxcfNpx5+U+Y2wbJz1g0jM37e8ZR0CzYVKElxyqGGWSFLJAq2mcIJr0BZcs3Wvi/a6Pl5FpYZ0KwzqwtGmZXj/5k3PvZA6cbBWAByYtGIlpxv3sYqnkAbKz4Gn9AB9LCkq94Pxn5Fe5DcPPgbS2VdJsMeWbBoVn0q7yzvRIS8KIbYhZDI0xZ+V0nTDycqn5CwZlzv8A/27v8rYl6qrCvCibepAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB9528.namprd11.prod.outlook.com (2603:10b6:806:4c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:21:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 16:21:24 +0000
Message-ID: <0f4ee112-59c6-49b0-8d0b-886f32ec410a@intel.com>
Date: Thu, 11 Jun 2026 19:21:17 +0300
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 05/15] x86/virt/tdx: Move tdx_tdr_pa() up in the file
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-6-yilun.xu@linux.intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-6-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0244.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 870a9f0d-b3bc-4032-b1ee-08dec7d57abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OwSYtq1rvU/qDhsZvFa6W/e9KMe4yQ1QTANl32yp6QXuOFIhKfwyOdG1Ufeesji2tVXqu/qLetFAe5HcwuWR8fqehP7qdMV/JjQtpCD8VQ3qSa+7DPT8y3X8djzrIF0Kry/pzRHzbKoSTrcle1Tc8Zqg0rz0I7BtkrOzxeOSWKbXFVwTX2zrm2YHfB9CK5erkpKjPm67nMIZRYQi7zSmucaR6yCXcUBEyRqHp0RSLv5mPHZqGPlQZsdc8ffTQH28oWm8fIS7ra7bdC0E3A/zbDtv7Nmn4oBTKsJCVE/NjIYCO6e/gQCz+6Qz2+1IlyzDRlqgsfVF7Q7zMESByC7B+jpqizc+g/beJxxFoSt12kDOuTAWPSEEW8kF6epR1AeDOsQyl58+X/1ivkTX7UoxpO+VJ4gwW55Nl8N+BBmDwnyrjpgTETnX7DVpY7TT03XY5XDC5nEblkpH238HV/wqbyeO7Q50LbZqAvBAVqpzo+I1x3dKSL6izlTC7WXnaye/2UWZaKwOrks4uRYEz2fWXxExBZDJMQoCIoXVTUkuqs3YjGsKZ5E7JS15VacIlYwnNddNt8vHqEmf5Qd/yuFo/lBvDWaumv3fSPaOPd6HdkCm9A/pg2/MCnSbMTVAlVS27frmgJ71IpxJr4NkHBDuRO4D7ZW8eLXqykGP9402QbD3D74JYJ7IIhXhDSIJ8e8X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitySlN6ZnhGczRGNkJydDdUcUFIUWxzV1AxdytmTS9aS0hYb2c3L05vRWF6?=
 =?utf-8?B?Sm54WlI3dTVud3l0ZlpYb056ZHArLzF2TFVNczFzZDQ0dXU0RXloQ3V6YkNk?=
 =?utf-8?B?L24rYnhsditzK1hTZHhQc004SXkvUmRkRjE1cG4zbllaL1JJK2lhbWRpQVU3?=
 =?utf-8?B?clBFcHBpQXE1RVNVeFlJTzRaaEdmSkI1Y0JtaWwvNUdxdG10YjMrVWUvT2Rr?=
 =?utf-8?B?WFNZUE1Wd2FCS1dheDRLc1NYOFEzcTlnME1YUzUycHFLYlFwL0VDdzZHTG82?=
 =?utf-8?B?cmRDSDRMSEpsRUZqaGtpQUsrdWl1MEpkYUZGLzc1TGF2U2xDU2xYYW9NeG9y?=
 =?utf-8?B?TC9FeTBoSVViMXJQSU4vODc4V0J6dU1nTzNyRUpxa3NMUmdaOGRCUWlwUnNK?=
 =?utf-8?B?aTZMYmRObENpMXhld0tpeUM1ZTVYSGM3SUtvNXFKSU5wT2NQQzVka0xXUnZF?=
 =?utf-8?B?WGZxbUNTYXg2TmlBM1J5S2hyOTZHNzJyNnEzWmZWaXVvNVJnTnBQSU9XZTVk?=
 =?utf-8?B?OVBGTlM4Uk94VHlyaFVKMittTDdtdnlnb1hBL2d3eUFNVTVET1FQSGVudUU2?=
 =?utf-8?B?Um5LQ1RyaEZ4MWhKTGVPdGxrUHVPK0o0K1VsdnVwODBJNExJOHkxNysycUZP?=
 =?utf-8?B?cW91T0RsbzQ5c3RpUHUvWHo3dXI3d2pHSVJ0djczQ3BNL1ZrM3V3cXdIbUtI?=
 =?utf-8?B?akFkaFJ6djNNMGlQditpOFdFajVFN2lvaUI3UmJDSlVIcU5kbTVoTVNpREZC?=
 =?utf-8?B?MUZjWFg0dndRTlNSUTIrbTZKOTBoeFliVGhsOFp0QTlpcGNTdnNiUmRueG5z?=
 =?utf-8?B?Y1FRRXdpNmdDMkxPVHJKT2ZQK0tZcVg3ZkVybmFqeWJic2xSeXV1RmlZeU40?=
 =?utf-8?B?Ty9lZWpZZGhSNXlIenNmSURJdldqdmtLMVg4emNtM1VFOHorZnFZMWxUWFVq?=
 =?utf-8?B?Rlh5Q05URlVEVjJiUW1mZjlhSGtNYnRJSXU5MjRDQ1J4MUVPOG52WG5MYVdV?=
 =?utf-8?B?aUNTcEZ3eGVkSXJGbU52OGVHOFV1c0ZGN3JSU0JJUDEvRHMyeXM0TFdjcjBE?=
 =?utf-8?B?ZGRZZDFHbTNLc09ieHYyNml6YXg1dXJabTJpQk1pWVp2c0QwdTRQMzlBUE1W?=
 =?utf-8?B?d3J6c1dkYXM4ZDBWU09DbGJrUjU0RHJNMjNJaXZVcE5VNlFmcWx6S2dyR1BV?=
 =?utf-8?B?ZXlCNW45ZVdoMUJGOGJOb0p6M0VGeGN5aWNrVWFTWTl6ZlVzM3ZGWXV4WTY1?=
 =?utf-8?B?SzM4T2FudHR3NUhRYUNYaklyUkFRTGVFNUN4VTVmcWpqbXowUk1iSUV3L3Ez?=
 =?utf-8?B?U2JkMlFhMlliR3g1UjRoUmYzcDBzeGVEWTE3SkFWNUxlRERVY2EybW5kRndi?=
 =?utf-8?B?amRqcDR0YnllUElWZ0toMWF1YzNUQ1hkcnBJYlFaSjdaQ0M0SXdHTUZxSGxI?=
 =?utf-8?B?d1dMQ2VOdEFmVjM1SGtyNmVvU1RWd0RlU3FxdTZJVEtaYzMyZmx1cW5rZ3Bv?=
 =?utf-8?B?RjlSRFd0c3FEdUNSSFZ0Y2o5a0JCSGFMeWRGZjFqR2NxODNuM3BWYnVKSEtB?=
 =?utf-8?B?cDBpMW8wRVRjTXNqWUZ0aUJDNnFCbXFkUWJjbTBYejRXcFk5S0ZHaFVkc2Jy?=
 =?utf-8?B?RXIyMU5icVdtczUvd0dzczllM1I5VXpEQU1xc2xXdmFiczNPaHFtbXZoQUg0?=
 =?utf-8?B?bXlER2FHNU56ZVhON1UwTDV5Wm9mdThOaWhwdHVhek5sdDdTN0F6MXAzTk5p?=
 =?utf-8?B?ZEdFOU56Z0taN08xdmEzVWVIaDFuN29LNklSS1NzbDd1bHBGVDNLZlZOK0hT?=
 =?utf-8?B?T0xzMktzKzZUcytuaDBRSmZGSE03b0gwSE1zQ1c1eFNWazV0TGllQk1USXVy?=
 =?utf-8?B?ckRIeXVabnFWTWVabGdSMmVwMmlmUmtvdVROOWFkSnhYNDFZRXQycExTYUt4?=
 =?utf-8?B?eXlWNDVtdmhCNzVMQ1I0eldZeUhRWHE2bjJ1UkVXTDRmdDIvS3VnUXVHUlFH?=
 =?utf-8?B?QTc0Qjg1dXVMY3YvK0dla014TVR0WHpqMHdGNm53MERWcHdvQmQyWi9lczJX?=
 =?utf-8?B?WUkwS3FRbnRPQzRxZ1BVR2w1UUwvNnJUNFRyaGZGSXloUUZXei9sbmVtdzRl?=
 =?utf-8?B?eWlQRFJRdHVzZGhzUDVtNEdrdWdORHFhMTZtR2RQUGhrcHF2SDFOOHZTSHJW?=
 =?utf-8?B?bEVoUUkxQjZzVXp2QWFmQS9UYjJOQUExQmFjaUNZd3B0VlJWOTdsSVl2RGZm?=
 =?utf-8?B?K0U3R0k1NVpZRDVxa0VRdjR5cCs3SGI2WG9vbzkvZXNmUGdGY09abXo2WGV4?=
 =?utf-8?B?bVZ5bkl1OS9QQ01nVzJ2SHl5RWg2NHNHTCt5VXdpSm9rbGR6K2t2VU52YlM4?=
 =?utf-8?Q?LVp6JeZS70KG/+uM=3D?=
X-Exchange-RoutingPolicyChecked: jV4rxLXAdNAHpSRbwsneHAK2f3EMmfy/E6HhjZ0UNy13Lw7s64b3GnBdMVgGoZUc8FrwdkPJRkVqIl8XS9iP0cT/JgMzA62ECFXP2vWU3uAXkbyxQW67vHD/b51tBKGdw8TbvoBuosJRL97RE/ND0F3jfxZJ2QxNDVNIfhBV4+zH4tRAAVP38g8YYYzRXnexT2j6cxOiQo1tB/12Uj04j2z7se0qinpRymAWUsiIRXIe0kwA9u+7V0MvCcpA1vJ3HIoC543ueukYZpzyFI1BXeENso5RybkRzAYYPPMOeFXI/unIkcZqdAF7zf51xrdo2GQE2m+cZGlWQsdBn43GKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 870a9f0d-b3bc-4032-b1ee-08dec7d57abf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:21:23.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVuhF5u5c9bfEjeZEvh+9Jl3bn5Uwjm6kd1CWC1LUTkyFeXngN/pk1CEyfEMZchmMikzUwARF5hYteVYGtBQDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9528
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Move the tdx_tdr_pa() in preparation for upcoming changes to use them

them -> it

