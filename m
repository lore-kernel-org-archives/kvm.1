Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453640B11E;
	Wed, 22 Jul 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705775; cv=fail; b=LbVahVI0x6QZZsLy1TSIRzvGd+hNFc2M84YrsGVD/P43Dh4hiGyL6GHIaj+Cp2dfqIKUFBoQ0Xu9V5G148cIGRwedhcDCFA+qhPgbeYE0SiKVd1Sqb3NGwm7KF0VH6dsElr6euDix6WCoGnYoTz+7Fhln08vk8K7WH4HYHjFFsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705775; c=relaxed/simple;
	bh=Oq2M8RqPB8uu8GPl7yIVXZcBfGKlZr75JWydwcz2Lvc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQfsSMxtPiiVteOEatt+Y0NJH09BjU2nJnYbECgq4TxHsHlaStZTETdrMiN4oUOOWIFARbxUxG02H2oInBT3rP+kS1YN8PJmxEqjUvTTnNCYgjgalOaw77S78Dex69kKoLSHS8d5f7bTugoxr+pgKbKHXU03oHE+SJJ8W19SLJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6x9jPU0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6x9jPU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784705773; x=1816241773;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Oq2M8RqPB8uu8GPl7yIVXZcBfGKlZr75JWydwcz2Lvc=;
  b=P6x9jPU0lQ6oGZm8MdY0VIhujJUKRNQy5gbkzz3ybURpkgOKDTm7EQxR
   nQjISDeE5clU+/Zrzl1xoi42NGTNXOPhd6H0nnVOayptFR70Ajs+vhSn7
   g0OYw82AlMs2r9cTKFcYAgJ0MAVUwsgsmyb8GRfEzsotz2REe5JA2BG0J
   0JS1KsaXza6nEZhs6g6acThkoK5B3G2fEGzNIdtEYXrNg0MaY0n09djP7
   OX0PG0YngDn6icHtnJVNpz8WDOIEX+dNiVAwvzr741MReCSjMz6HhOcax
   cSMn25d+cW7NDW8vuL7AnNRwAnRBTvJ4pa8W3cMd6N/OJbBVbSSklIVV5
   w==;
X-CSE-ConnectionGUID: 9K3KvSjDRvqFFHK4Nd5Rqg==
X-CSE-MsgGUID: qYgn0NtcTyWGaYKS750nJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110875544"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="110875544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 00:36:11 -0700
X-CSE-ConnectionGUID: a13W3zsnRg+zXQKHghqHQQ==
X-CSE-MsgGUID: Egt4EJmzTaG0X5wY7+GgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="253640266"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 00:36:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:36:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 00:36:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 00:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9IW2Bob7RfxntpwGlhMYL87p71imNs8yeiLs3dpo1xStcfHkNi+Orumik0dhSo+UCl4Iyh1040C2I/Yr+wlj2mms0x3lXSNWybN/LZwhKNWi87OJJJX1nc2RD4UBkS+jT1LszijGU98M5omfFh0afeXzXgPiCcmucMr2M3AudXkn+KKGkSyQ8X46fjolRDKDujOspapt3gjXNCeTkZfhavrEcXlnGVYXfI+/HFjWpsHdqIG/eWH0x17WZw2bAkLfkCOLfQmV3OV07i5A0mNuuZ8053yNVdD98Vm/f6Sea0kSlJQpGyaYNEYeVXNjjCET07Y5qru8hRNx6N4RB/M+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHOupU0PI/AYrGJYpLPT2yjN05QR+M1bffwpQxlv6qk=;
 b=vLK3MqKr9PeznmQHxf3gFFC7DvvdlkJIptkDkYTx09eK6191NI7XT5OjCCwQlu7XdvztQvEAwmYAv9maKuOnIayA/J7qa+A565QbyStdFKgLSYedNs2/koAzU4eqr4R8eGNKkWvUyP7iWjyLsmDZHwiw+LnT2kGw+MtSnnAV98dIaNkIC6c2YK1u1+OOD8CvS2c4sOqew9FJlGEfhsc0Zo+DWAApVyWxrZN3b9ptujfkMF+E7WjLLG9YK7ye+cEqtAz7q8REQFs6PgLcZ+wRyPKVZVDVBG1Jk6S7Lo4E8+zmrvix9iPfUPZ6XMz8A2Ckd5v/Qq09xRySG7VIAC0U6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:36:08 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:36:08 +0000
Date: Wed, 22 Jul 2026 00:36:06 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260722073606.GI3178326@pedri>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
 <20260721064907.GG3178326@pedri>
 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
 <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH0PR11MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a3e021-49f2-4dce-9f7f-08dee7c3e4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5Xds2Kr0MDIwobQAhOHw7uhBEWdssxh3E5uqqgk/PcYIBMVYTY8LkfGJeIp9AXVcB1mB8Rfhxhtd8PAw9T6Ht79tYSJ8etTmLx7wygdJafQl+8WXfmMngSODw06rp1zIWqv3AykeqzzZ5U62wyB9w4edegeVqvW08oOK6tzONyxDOWQgpPic3ETkqfvTHU1cnmxbRn0W45MyxE28xGH3HV8WrRCnc2tPzP4kIU+rm+qCjQmx+EoopJnB8W33Dki02QIdSOmQvIv4n/pN3YNgewoXK5Pk3ztHDzJnLCB/j3dbWlq3nLAoyl1RpEgXAqv3Cx+Bq6q0bKryfMVMkkgsQhuZe2+M1z9QNqVBk0OOsb7gCdHUREJHxm2Ndilr+AKNlITSlF+FpHuSDk5BXmm6FS7qSVXNkrOC4WhI6ddFLK3gxMI0bPR4mQfzZO2Nh2kAb0SrJ7Iuk+yueIXfcX8p53DNGeBZTLr6ULoBqv76s8DHKlYTQ9LxfpcGCE7bEr0r2qyk/lk1YKElZ9GiWCnfPT6Qwu0C3eb2ChS35QO8TQAvpTsGeM0/jFGuIJWMPX97Z9T0jKb5z1QzBhGTxZMejyqCbF0J5LR8I5LH0088lk21shegHYmPRW6DJIX6rNfpXwA5ZC3nJNl8VigR62hkHteFlIMMg6jPNHRhHq8t4Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllIY0djYU9FMHBLalNPTTZFejZrM1BRN0NJTlRvSEdmUzhNOTdDb3JLeUd4?=
 =?utf-8?B?dGo5Z21nRTZBRVVORzBDUUVyQ3BaTkdMcHVkOTU5Wk9EZXBvU1hpdWlSUzda?=
 =?utf-8?B?MkJIM1RLYno0QTRNMnZMUVpFYTBubzY3b2ljMDM1VHl6L0hPNXpGd3IwQzly?=
 =?utf-8?B?RFRhNktaYnpWMGFvQlc2Z015MHNxZG1PVDVQZFhnNm96Yi9VNzIrV1p2Rkpr?=
 =?utf-8?B?WWw5VE8yalJSaHhxdzd1cFFQTlFDUzM5OE4yZkJPbU5XRXpYdFlvUU9hYytB?=
 =?utf-8?B?NmZGY2pxekc1ZlprZmRXNUhmQyswVUNMSG1hekw2TjJOSmpuNVBzRlRaNEhz?=
 =?utf-8?B?UjNwV0Q1RmRlOFdpV3BBb3RKTjRlcDF4UGRieUwyTStSbTZtNjZkeXBkcUFh?=
 =?utf-8?B?SlJITldURGZuYk5IMTJjbmh5ZkduOVRadVVOMXY4blJoNEFQbnJPVTlXR2pl?=
 =?utf-8?B?TThCYTRqMzFDcXk4M2tPZ2ZvbkdUZmFQTnRQSi9EaVNZMTNmNlUxcWdzeE1o?=
 =?utf-8?B?ZkJrbHZJdjM3elF3bkxJUmdZQlFLQU1PSEFRcEIrRHc4TG9kSy9FY1I2NjdQ?=
 =?utf-8?B?bnB1ZFhXdVozLzF6dGphQS81S2h2QzFROWNxa3N2NnU3Q2ZEa2pWb3EzZ3c5?=
 =?utf-8?B?UWpXUDRRa0JRZjRvTFViR1pMWVlJcWU1WS80UEZ2MXJzeloxUXI0dmlLcmkr?=
 =?utf-8?B?YmpOMjQ4WkpKOWJUVm9naHpRTVBzSnhOWHAzZGFSTHZIaHZ0cGVtR2dGaUJp?=
 =?utf-8?B?dGxOSW9FVkdRUTZ6ZXo2OVBFd0NEbENhOG5EcWdTdkZXM3g0eVB6VEx2ZUJ3?=
 =?utf-8?B?VHhHeUJaaFBvN01Gbm1wRmpPU2paSjQ5TlhJanhEL2tiRG5UZ0VsMFAxdWhZ?=
 =?utf-8?B?NGk2WVlYcHhqemgyR0M1QkwydW1JbDJ2a3o1dU9IL01UdEl0VXBiMTNxSUFV?=
 =?utf-8?B?cmFadURSVENtOS9XcnY5cDVFTWVzdmFEZC82dVFuTjhNWjBnMHo3c0NSblo0?=
 =?utf-8?B?T2FxV2NzN3VSRTZPVUtzSXdGOVJkcXQrbzd6eUR6ZjgvOFpsSDM1ZUZDWTRZ?=
 =?utf-8?B?Vm8za0kyYVpsejczMWRkbUdkMGN2dnVUWDg0NFVJdXl1SWtaRmo4anhISDMx?=
 =?utf-8?B?TnVOV2VXU0YrZjhQc3JlMDVoT0FLY0l2MElKdkJmREtMOUNESXM5eTgvdnFq?=
 =?utf-8?B?eTZ4bmpWelVRVmRuZzFrNlhHTVVscU5IMXFFczEyc2k4OFl3UndTSFVRZWtv?=
 =?utf-8?B?MitwZlc1ZVAwbTJjcFNTaVZ4UW5WajhjbEkrRE02ZTBIS0VGRXpBVTk2M2FB?=
 =?utf-8?B?STU0d1JmZFZvWGo0UkdJYkxCOElSZmV5Uk9HL3VpRGU1NC9ySnhYVUJ1OTBD?=
 =?utf-8?B?Tjl1OTVjZC85YlJwemVKVjVLNzRhRkFONzhqVkc5RVBMb1gwdmpOeXNBQ2ha?=
 =?utf-8?B?ZWtxcUhCWDZuSTBMTGcwa0krRHI2QUZ2RkgrR1JTWVpNa3RxaU4zVHg5OExY?=
 =?utf-8?B?MzB5NGsxaVBBRkR0Z1JESW9qTjg2eDI4dzdQcEh3aEFCUVloZjdnWlV4U1JW?=
 =?utf-8?B?ZnhDUkk2eEdZVXorMWxzUkRMaWlGZ0lkR2N0ejlocElUbDN5aEZrem9ud3Uw?=
 =?utf-8?B?SHVQdXJxZko4STZyRHpUZS9KbFE0aXM5SmJocGx4dE5WQ3B5clI0MGhuWDI4?=
 =?utf-8?B?eFNnbWV6THAwVksrVlRzTUMwc0dsVys2MzZaMHhzSXd1M0ZGd2FTbUM2MzBS?=
 =?utf-8?B?U294K1k1N3VBaDFic2I2dVZpcC9BTDJ4cWZ3VTc1Y3ZBZXpTUlFQV3JQeHFs?=
 =?utf-8?B?L2drcjliaGMzUzFwbXd0RGpHeVNaVU9UQ0FnYWpwNUl2YWRESnprVXhuQkZi?=
 =?utf-8?B?d0JmRk1GbytmNFZQRERUeW9Xei9ISU5EZUJQTFdSakVpVnAxbmwwV3pCcjl0?=
 =?utf-8?B?ME16T0U1K1pscC91L2t2VU91WEIvWTdQRHFidHNNdm5TZWZ4SjE0NkdFaUV1?=
 =?utf-8?B?S0FOeEgvUjBIUDV4My85L2x4Mm5LSXA5SkRocEVYWGpNVXdHWEpxcldFMnhq?=
 =?utf-8?B?dlZhNWRhY0dGYzc5OFRhVEFSb25iQitaYWpZOFF4U1owQ0JSZjhCSm5yMzBS?=
 =?utf-8?B?SkJMSlVJWnpPcDd1aWc1dEF6K3o0TUY0MlJCUzliYjNVS2RieDRFaGh4TXF2?=
 =?utf-8?B?cU8zbm5xWXVFam1ZcFdOcm12eURQSXNGMDVsL2NQdWtFUGI1aEsyVVNCNHg2?=
 =?utf-8?B?UmN5VkhmSEdkOE5vTDRFUHJUSHhVQkIreURaNjA3Q1NzdWpudzVpQkhySlc4?=
 =?utf-8?B?UFpjK2RPSDRYOG5VRlhDb0h1cE5XVmF4MytlV0orUmc2WDRyY2pQUT09?=
X-Exchange-RoutingPolicyChecked: phZXHEUY/mFOtiEm3jFAIK/kZeZMlHi5bohPoIvTVufhAwvGCRgjoVHxAI/y+jtGWfHM8RTTrswqSmyy0VX9EIXAGvWZUX4OQzIdmCTNtRGrErL7IPFLqWTSt3Sj8UREcoq9WLmX3YUiFFyeR4Sm3lLulIbQZgxKGEUGTsKMW96rlcNhvJLoloykJ4CtbFAq2yngOO0zlSKe+g2zk2TUpzYVwKMm9kK0zGVwO0Ri4p4RQx6CD5tQnC0t8v9boizsdpfxAxf5JbKdiOdZ1e8aEBSciUYoAfBfhmkSq33n+a/HjaezqcGZIHITM+J+r8oadigmTTUrDm4tT4quqKKd8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a3e021-49f2-4dce-9f7f-08dee7c3e4e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:36:08.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG95wlNZXdjp7okvmTGzjT7UnSHCpNisVJCWYNdkfYsXKU31htnOGuwbi0vBs6zm/0oSj9Rq40wphatPGZR4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 09:43:57AM -0700, Edgecombe, Rick P wrote:
> On Tue, 2026-07-21 at 06:48 -0700, Dave Hansen wrote:
> > > > The host may be untrusted, but it's also a critical part of the system.
> > > > Are we sure we want to be completely quiet?
> > > > 
> > > > I used to see little dmesg warnings about TCP window shenanigans from
> > > > random systems on the Internet. Maybe that's not how we do things today,
> > > > but if a random dude on the Internet can spew one line to dmesg, is it
> > > > that crazy that a bad VMM be able to spew a warning?
> > > 
> > > That makes sense... I actually argued with AI about this but it kept
> > > saying this is kind of like DoSing the guest.
> 
> A guest DOSing another guest is relevant, but the host DOSing the guest is not a
> threat model we should or even can care about. If userspace or the kernel
> decides to kill the guest, that is its prerogative. At most it's a functional
> bug and not a security one.

Hmm good point. So maybe treat this more like a bug than an attack. Then
the direction is clearer.

I went back to my debate with AI and found what spooked me:

        "Letting untrusted input reach a WARN is a well-known
        anti-pattern precisely because of panic_on_warn — it's why
        syzkaller treats any WARN as a bug."
                -> but this is more of a bug than an untrusted input

        "'Fail hard to defend against the attacking host' buys you zero
        additional protection, while adding log-spam and a
        benign-misconfig panic vector."
                -> but there is also no point in limping along

> 
> But... doesn't this size come from the TDX module? In which case there is no
> hope of defense from anything.

Yes it's directly from the TDX module. So maybe it's more of a question
of how loud this failure should be. There is already a:

        pr_err("Failed to allocate Quote buffer\n");

... later if buffer allocation fails, so the user will see something in
dmesg. But maybe it's too subtle...

> 
> > >  But thinking about it
> > > more, tainting the guest is probably the right thing to do... At least
> > > the guest sees a big splat about why attestation is failing. I'll remove
> > > the __GFP_NOWARN. Thanks.
> > 
> > This does seem like the kind of high-level TDX policy that we all need
> > to be aligned on and probably document somewhere. The basic question is
> > whether a TDX guest should be quiet or verbose in the face of host
> > malfunction or malfeasance.
> > 
> > Kirill and Rick, what do you think?
> 
> We discussed something similar around the set_memory_en/decrypted() failures.
> But that was around whether to panic or just warn. Not be silent. If the host is
> mucking around, I think security conscious guests would want to know, and even
> have the option to pass panic_on_warn. So yea I think we should assume the
> default TDX user is security conscious. "Warn on untrusted host weird behavior"
> seems like a good policy.

Sounds good to me. Thanks for providing more background.

> 
> BUT, is this number coming from the untrusted host or the TDX module? I cant
> find TDCS_QUOTE_MAX_SIZE in the docs. If it is coming from the TDX module then
> we are not talking about security considerations at all. It's just a functional
> "do you want to know if things are failing". Not sure why this one would be
> special in that regard. If we think it will fail so often that we don't want a
> warning, then we probably need another solution.

Another consideration I had at the time was that this happens before
attestation. And not being able to do attestation felt like a big enough
red flag (I'm assuming something in the guest would scream). So that led
me to think that perhaps a warn would be too noisy. But I'm good with
following the TDX policy and just warn.

I think this tilts the scale towards keeping the warn. Let me know if
anyone thinks otherwise. Thanks for the discussion!
