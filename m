Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10545492502;
	Wed, 12 Aug 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574247; cv=fail; b=ZhmicCnaUnonfH0jg7FWloiBmGhC7zFl3lKiyXScDZ90sm3ZoSYhhpp6GxUrfp0RZJQkn8JcAThLw4LLG+B8bjGxe5CcAoXdJaDmsFXQdnVJIVrnfio+i8ZNeoysM4ytiijKISK4Oa1OzX90PVpqu7yv9M03pSZQRTaAzAMXaog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574247; c=relaxed/simple;
	bh=PWBmsz5aox8aak21Yfm07zQd4qA82oZWnrBHi0VI0Ck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1SzLPp6/wsyA1ObpTBJC3g9yvsWCAfSdaR0tMoi/2ND+kGeNyIgMI/yi1j4UA8NTF9BV16Xn4DTZ/Spubmb9e/a/T344jnNYbCKokoeOAalcZNgE3Z82Js7XtwUQZM7VEtHRYIFT2LVA8VabHoFQ+bTUOqWSLgY93V2HKQ45uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkdrD3f7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkdrD3f7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786574245; x=1818110245;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PWBmsz5aox8aak21Yfm07zQd4qA82oZWnrBHi0VI0Ck=;
  b=bkdrD3f7YJXgPfGYBXnMNp7ja80+u770r+5Kz8axKuBl62B/eoR4ALeX
   lHfbQJMD9kejLnIacEMMCuUuUfC3ZyV2PgOUZJX0OpuhBiPZIAc6jBady
   vCnQRpunva5VzmhrHeTwuqCEPOWKL8wkvhX8Jv4UufyuVwkEPMccxzGcn
   mH2z4f8P1v55FJQho23EIwPM7TopxWFopZYyaaXgJAItrEHY37DCu2DOh
   J0f8gQmCLN97vV6cOljOCmhnNXu2dYuxrnmMnU4u1qZX+bQYw9hGneJIa
   vAW1OauAsgJCdBsA4Un8BYxsfrUqYjfZzHntcffDo3+tYoGW3BsFuVNK/
   A==;
X-CSE-ConnectionGUID: RiYVe56JT/qEMUQaHKaOmg==
X-CSE-MsgGUID: LYopII4GQUatWZMdjsZPqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89664864"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="89664864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:37:18 -0700
X-CSE-ConnectionGUID: PUEAdrgARzCnVY9KdoFKsw==
X-CSE-MsgGUID: 6nx+aKZSSnGbxfMnjHFUNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268945078"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:37:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:37:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:37:17 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:37:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlaXjkJkvYI+rx+/x0U3e5rVuMRYfPHcv5pMqhhUYF3cAB6c+YzFlahW6oP/gcBwA2wYsijMF6YDGmmc8lg609kISie4W5I4znjw2i7S0cZ5Jp1cFphevVO9yWweuN/ocLoZaFTKICB117f93juBJvkianWGJfYp9oumEjTp4y+RNZZ8QrWB8k6Rmf5zVrpulKvww7awpgsrZ7RbHP+/Fhy2894YUOL9FqbOpqn9iVV/0ACZhP1WG7uzYdvdcdyzCItSCcuR0gDPq7Ma+0ku7d5tGxer2HX7R4IISmyDmbVQQgst6oRPqz0b1MhPiSHONkByY88flKBhdZ/J4ZwEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03+tmPaatWL0KwsW1I6MFJxh/Rwap/+uWl1RKBv1Zpc=;
 b=yXIWYTYGHdUTAMc3yfjOONiM1ndLXVk9BeCeVDo2cdVqczji1xRZHEJ2gwK0esvR7ipnrGSpzYNZjuMYe9GnK8ziKyIhSGcJq0diooWhhDFERQihkBXXFrJ1UpsFtNbFjxpIzFwL7ULs8RaM6xvH0N1ZNqyPPqIOZEStcirSLmQ3x1xCAzz46QktkK6V2im9Lteuk7d2ZdMZUW3feBaZgCiscihU1jF6xh3kGqdZiThNihjDuQAwm2iTueaXVS65MdGcY64k4Eh/tfiHm2XJMIMKg74WpiKHeGlSTozxtg8pDI2WyFW/O5CrZUQ1c0WjVQnXymIvI+M+qjzhrm01qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21)
 by IA1PR11MB8222.namprd11.prod.outlook.com (2603:10b6:208:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 22:37:10 +0000
Received: from PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0]) by PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 22:37:10 +0000
Date: Wed, 12 Aug 2026 15:37:07 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Message-ID: <20260812223707.GD1013044@pedri>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com>
 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
 <anyiwqi9i0NSv0QW@google.com>
 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
X-ClientProxiedBy: SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::6) To PH0PR11MB5643.namprd11.prod.outlook.com
 (2603:10b6:510:d5::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:EE_|IA1PR11MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: f77ad159-8681-4cd4-562d-08def8c23ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KbZuMnDx7VjppDHJ+LYrrIkLseUeWTylt4lov9T6UBZVvp9QN08tuzdmCMSlqRYx/kFCDyr7E96IvQwouQyYUj5lm4UgIR6Rj0EZkWwn3+wxTEMEu4RIf2tZWeNYEhkh79NkYmyoJj9hx+Qa9oR7G6gXIXBbmnRfuVV+RBCZ+wSFUqdxtmcoToM1HRGXI8bV0ccBep7nKERPo8z11qXIO/v80xSvjSGrTW7hLgHvFENysEM3QAeKPbNRCvj2dnrLvYUP9s/wa70gqiunYDIEeLaMc9YJk5yL5Dl7di/lk/j0ZHeckRsp5Nxai84wy/mIFr5OOHRFFc1Hhj3WME6QEac7Yv9eW+BVPFVi69kCsbTpSp4fNYO7zQe9bmmZm3svTUBNyBe+aKoUs/hiqWcOmaykd39oTPcMZPpOZ5rRkk4SxHpvNit+xjBmSxMeCTFxVYmaRCEOY7nizVOk0pOwVwuJWwtO5Zo3C/G6V382hwWY9OR+6jqFBqLKJzb5oZ2Ea2RSGYwBnv4Mh8x1snD9A12ZzXhIRtk59t5QEE8B/5mvzvQxmpDZP/amTx/HpBHd0qvW29odzp7ydASLUfFxqJVgAbiHh0zjwAqHBtqnSiHg8SqF59fxTMTSbog5tMsT9YBfwu+4H3JQv8PfKN7k1pWVi/kRK+Lpmm6HFvIYX58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amdrWHlVUmxsZDZ6UGRMTDRCS0ZHSU1WMGwxN3dPclBocEgrNlMwaFdpQ2tM?=
 =?utf-8?B?VDd0NEJPNjVGYXdVanNuUnpnZVhCY3FtODg1SEYxNEc1OXppMXZUOTF4UCs0?=
 =?utf-8?B?UytWeVEvVTlRN1pBWFNpMm5KeVExZ3JLOG04RDFGUC8xdnNTeHhtcWZCL2Fp?=
 =?utf-8?B?ejA2SGtvenZzREhqVGliNWxjNnZDNGFNem1KU0V0clk4Yy9PelpRVjEvdDUv?=
 =?utf-8?B?Njd5dHRrRG1yVXNwYzRLMlFqNCt4eXhMNTQzU1RLaDNTS2t2MmFFdENxcFBh?=
 =?utf-8?B?dlRwMm84ejRPYVZ2SXBOL3YrUGd5T1JKMitjTy9vZENIYUhiYjZSd3EvVUhs?=
 =?utf-8?B?bEZ2NnRqUktQWGhmbXJaSStlT3VFT1BMR1IycnRyWE1VdmttMVhQZGJLVFdM?=
 =?utf-8?B?SWRkR1NaQ1FIb1NlNHN6T00rbFhsQXREQ2N2d3hJeFpJbkRpNGpTVmlJVk1X?=
 =?utf-8?B?TTJxVS9YOG12ZEdLTFNQakhvOXRZUHlQYUxiUnV4b1RhQmFWb3IvcTZoZEJm?=
 =?utf-8?B?bjgzb0RyQzRERWFvNGEyVFRtSmFlb3pyRmNXMGR0Q05UVG8zOFJrRFhwTjZy?=
 =?utf-8?B?QWFzTnZyZW1XWHJrNFBTaHI1MXAwZVp5eEZiQkw3dTZMTzk4eURJSmd1ajB3?=
 =?utf-8?B?Z25aUkFDK3BHQzVLUlI2YU5uaVM4THpXOU9ralJMZXJqZlR6UjlvTEtKQ1NC?=
 =?utf-8?B?V1pSUDVDQWVwWG1vME9oMW1RUE9BVjdqU0NBcVNJSHZZWU1YWkNvS0xKUXNs?=
 =?utf-8?B?SDJnNzlzbVY2aTNtZm15MlpXTnAvUXgyVDN0R0orVGFCZXBINzhQeVU5WlZU?=
 =?utf-8?B?S1F1T2s1ckQrWjdNRFFtSkMxQnFnQzhkSjFqTnpTWDZXM2x0Y1ovQWJyWXps?=
 =?utf-8?B?Slo5dU1oRjlXaU1TRUdMVDcrbjBucGlubWJldWUyTmZwUjYzS1FJVnRqOFll?=
 =?utf-8?B?M1RUaENOS1JSNlVYT1NENHAxSmI2M3dxU2V5U1Y2ZkQ5OGNGRFN3Ymo1a3RM?=
 =?utf-8?B?dDByb0dnbkFqRlMxVGdBMDBFZk80UGk1dmUwMlhoRVhFRktTQldLbUdjd1FD?=
 =?utf-8?B?TDVrakhJUmlmVzN4M29EZ0lRc1ZUSFE0TUdkVy83ZTlRY1duaTBNeUcwR2ZC?=
 =?utf-8?B?UEc1V0IzcS9uYWR0eVZDMFFOMXF4ano5TFI3SkJMZC9wN25Ca21nODA0T045?=
 =?utf-8?B?VWNkWjhQWnZGSjlEQ2QyZlZMUmhGTlNMS3BnRXlETTB1cDNHcyt0d29CRHRS?=
 =?utf-8?B?R1pwS1NsdDBWK1NzUXBrTkpPby9ITS8vdEdpRndVL2tITG5zc0xJOGRzeVpt?=
 =?utf-8?B?bW9pYzgvYlEwNFlmMFRWa0M3a0t1ZFJndTY2UHFqcXNVSU1hOEc0Ulo3c2ln?=
 =?utf-8?B?Z3pyaHRlR2RPWW5LeWxQUEVoSmtYQmpkOW9aNmJESmVlZmNlck4xb2NHZjJm?=
 =?utf-8?B?djlPTGx5Nk9pNTRpbE5xdTlOTGZCS0Zqb1EzWExPUXBTVGNQOENubWk2TVNv?=
 =?utf-8?B?THpKR2ZLZEl2ajRubzBHbXY1aS81ckZ0OGQ5WGo0OW4wQ2RYVDcwWG5HdW5u?=
 =?utf-8?B?NHBqYXFPMU9RMjhqakk0YkdMTVdtbmQvd3pZdFhLR2dxVnVrdy95MnRnZUI4?=
 =?utf-8?B?ekZZajBqTmR6c0N2Z05FUjZvQ0JzNDlYMldFd29veTVpRlBYZmEyR0VKOXk3?=
 =?utf-8?B?N0tvR2hDbnptTys3bnVNWmFXaEozTEJYWTlnSXRndmg2alhQek0yV3gwdVF5?=
 =?utf-8?B?UmkvNDEweG8zN21wUW9NOThvOGt5WlpscjVqLzVLRVRpR2hGbnFSdEU1b1E4?=
 =?utf-8?B?aktKeTJ6ajdGK1BBaXJEZ0dodnVxdUpXamlDYzJ6UU1IMjF6SDExd1MwMDF2?=
 =?utf-8?B?RG0wTlBadnRCZmFPSmlKRmNPQWFBeTBmZUNZcXdNT1VxSTZTdDZGaWo3VUZN?=
 =?utf-8?B?RDVDb3dWcytBUTVqOVlrenpXeXlSdS9VSURhZ0tKcTRWNjNZcnliVHNZM1VX?=
 =?utf-8?B?RTdJTVcwWnZGQUo2bSsyVDdpdnVZOTQ0dTJ5Yk9nbnI2UVMzcEdYM1FjYW03?=
 =?utf-8?B?SGx4RWcrdkpNOXlMcjRMUmNycjRUTnU1Z3hpd0hyRTRIQVpuWkcwL21iMHB1?=
 =?utf-8?B?cjRJT2ZtVEN0VFBRbTdWZElpSThrV0dYSk5PVVlkZU1TMGxaa1YyNGo2UGhD?=
 =?utf-8?B?NFlVWHJvc055L3NGSVc2VFIyQXkxTzlGVEFoaGVJM3NXVFQveHpibVdtRjdG?=
 =?utf-8?B?eG1iVEp2S0ZoWjY1L1Z0eEZtQVRDT29FbWlqN1IvRmVQcjBwcnR3b0ZlVSty?=
 =?utf-8?B?T1UvZGgwTmdTem5OaUtVV0JyRTNDNFpVMHFpWW1sNzZSUk1CTXpudz09?=
X-Exchange-RoutingPolicyChecked: gKBUSS1e9gJqie3F10XcpXAoiSIPWQ+Ke/woqxXAWB5VCguuSpVPCWy+GA4ZHOXiUNEom+ijM9P5kjR6rtctcMdiNNOtNeI06iPaLnhJhTx5ogbAnbROPAfkdEMyeiYuQeFNKydcb31jufMvGUYhfHf5nLVXA3iEPQrKDMmruvxNjGCy82SpLEESgtjmOmRZuusUHfy5+t/O3Rhu75BwYm/9/hbeV3xFnG48tOPSduXKOg78h6uqYoNMn1HhsZZdr5aYRQRHNfkzOGeajDPcwFDYAGX7aTQ+2nFRP1pi8TU6E5VUDmnmHTd6JtouHAcpyvZF4x8bem7jAU7gccqUeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f77ad159-8681-4cd4-562d-08def8c23ef3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:37:10.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Go8s+0HXItSaIjzV/gr7KzxDITysng6f0gpfIw2P2FrABOXo4mu6ajhuyfkUhznSnzmeXno+tfLLoESRrwRhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8222
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 10:22:11AM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-08-12 at 09:43 -0700, Sean Christopherson wrote:
> > > It seems to me that from the overall solution level, the report should never
> > > have had the details in it. It should just be some nonce or some type of
> > > thing that can tie the guest request to the quote that it ends up getting
> > > back. Doesn't it seem weird to get a bunch of details from the TDX module,
> > > then pass them from the guest to host KVM to host userspace then back to the
> > > TDX module... which already had all those details?
> > 
> > Hmm, my mental model of this is that the report contains the "real" payload,
> > i.e. the metadata describing what is running and whatnot, while the quote
> > effectively signs the payload to prove the provenance of the report.  That's
> > why I view the report as TD-specific (what's running) and the quote as
> > platform-specific (provides root of trust).
> 
> Argh. So I think I was not clear enough in the description. And hopefully Peter
> will appear soon and clarify this is all correct, because I'm relaying what he
> explained to me. 
> 
> We think quote *operation* can be platform specific instead of TD specific if we
> want. Meaning the SEAMCALL isn't passed a TDR. But the bits that actually are in
> the resulting quote are TD specific. In other words, at least some of the bits
> in the report end up in the quote too. Those TD specific bits either come from
> the passed in report, or added later during the quote operation based on the TDX
> module's TD knowledge. Because of course the attestation needs to know about the
> TD details.

Yep this is correct.

The TDX module has knowledge of the TD itself (obviously)

So:
  1. Do the SGX thing and still carry all the TD details in the report,
     and feed it back to the TDX module (big report, no TDR needed)

Or:
  2. Stop doing that, and just let the module grab what it needs (small
     report, TDR needed)

> 
> Or I guess... if we wanted to hand the report and quote to the verifier as
> separate payloads. Then... from my basic crypto understanding, it could work
> too. Is that your model? I think it would be a major change at least.

Hmm actually I don't think it would work. Not if the quote is in DICE
format (see below).

> 
> But part of this too, is that "DICE" is an industry standard [0]. Some of the
> existing TDX attestation format is TDX specific, and moving to the standard is
> expected to make the verifier better. So TDX does not have full flexibility in
> choosing which bits go where. There is some. But I'm not sure which.

In the SGX era, a lot of this attestation stuff was Intel proprietary
and that caused a lot of pain. To follow the DICE standard the bits in
the report have specific places to go inside the quote blob. IOW the
DICE quote doesn't just carry the report like an attachment, and so the
two can't be separated (not without breaking the standard in some way).

> 
> I think I mentioned this, but what we experienced internally on this feature is
> that basic questions like "where should the quote uABI live" quickly spiral into
> a lot of TDX arch tradeoffs and legacy complications. I'll take it we should
> prove out (1) a bit more to get better clarity on if there are any snags.
> 
> [0] https://trustedcomputinggroup.org/resource/dice-attestation-architecture/
