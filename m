Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC82EEE6B;
	Fri,  5 Jun 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628195; cv=fail; b=RO6l2tniA6+syznnLFaNjPprJ6v3u77srkOwZdZDGWHPgf51Xx/9QXjItg6dkCvKBLSoOaiiv6RbmKAeEIThrMoM1Buy4lj0HE6lSSmRQ9Lh0hTWmdkxtnO62uk3V9qt+4zUXI0qwh0msG/6QoOLbHNv1A/CwLtVjE6s/OSIGpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628195; c=relaxed/simple;
	bh=UDYsNHBFNNFiZlMhWFZDqQzqc24DAIjvuE8LO7Z62Gw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpfxwBAv/3niwb8CHGmUb64nvzoEMW+G7fPHdJLSrSmg0weF4gBw9792Bq5Kj+KzpXkA0Jhfcthf6Ve7BpsckrfqzQpw3WSpP8Ap0cny8CmvbRD9ZJcxFmWGgLHXfODrDnEE3iZ7bVX1woI3fqZr9F5XP/uOUBb6lssqerMeiVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGziypWW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGziypWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780628188; x=1812164188;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UDYsNHBFNNFiZlMhWFZDqQzqc24DAIjvuE8LO7Z62Gw=;
  b=oGziypWWb8wCuVN521uvBhHD+Cp63Hm6Y/IuY7T94iKTZgZdtV9Ai5vn
   oSecDrOdx1yIk/XleC2ZkzAGYrk2pitkvfHOCyRnsuK7tlY14/nnNJJlG
   YV80l89MQaPgaRGxN6r+923Way11kAW7Acpmpwx9MvOtc97rtyo7UVs76
   usTdUVHhhfcCZV1tdpRH3sXYHCXupiZtliEJnUlFlgML07On8asmb1YHf
   hVZfovsJFta881fDo1yNrgizSXOXMsxeul2/hshQvimF6aND+MfKGh/fs
   w1sVVpGjLssDxaUwVtSZ0T48Tl/U1UyhYQIiCjKPfUQEpcfBWoebxQY5T
   Q==;
X-CSE-ConnectionGUID: IIQ8eR0HQye+SBo34JQCVQ==
X-CSE-MsgGUID: EnR2CXszQ2iUVriVHjSDbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98879770"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="98879770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 19:56:28 -0700
X-CSE-ConnectionGUID: U0H60+2ZQpKIdUoup/uXsQ==
X-CSE-MsgGUID: TkSEM3WMSIG/2ILlBYfqyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244575937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 19:56:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 19:56:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 19:56:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 19:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvWHBm/nf2SL8dN5lht25MKy1fG52yZXZQWmOsZOUpuZWCiBxd8SvzQnsm6fggyHc2nJ7FjDYZkcXsYrtZb6N20GSnXFN3VBJpkzLN+mpusuJSYYFlXsSU4tFvy1nYUIFIw9jj573jZY9xSuvfj50EtpdnOWFZ14GW+pFb/NWNjRxRS5QiLUij/jVmvcG781eNQnElsurelU6pZjlOCnK4U5lkB2C1yDJ6GBP+X9uCVWFFoLtjLS8XGBPCtNdy2vZrljO5D1ytX02bXEqNaCjhf+c64piSL6FAwjIeKNo4kw/R+kMPHifkOfgJd0+F/BLuHy1uasE0aSslRo9hzX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4STy9zGHHkOJvLaS5qR6ZtVvqgVEzbRQhHMfrDGNTc=;
 b=lJT3n1Rm8Z/50jaa3V2R4nGbL6fnegZdBVTkgm06yxi9X6UdoI6TcsZWxIAymt2hb4sq7xTNxS3jtSqx+o3823D9Ox1N1RgM1fhzjogm5flzPxH6MncifvIr/E+LN3cL1p200MtKVFtVGA6Ei7lIAC5V7wi3eaUFu9JZpfVHcfPYgh6QHpfJTi6cyN3qbp4nAYxLTBBQBtqTNC02PVh+IfsEZ1YqxiPbSHj49PCNBHww9+e4Pp7Xun8zPzscTXCtrQ5fhVbGBtChr2vW+zdfR6cDHUoavRgOECYaV830gyiuh2uc0FfLWeeqDNOHxXXXnhzup1qHAXEU8HYbru+niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 02:56:18 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:56:18 +0000
Date: Fri, 5 Jun 2026 10:56:06 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Sean Christopherson <seanjc@google.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <mlevitsk@redhat.com>, <xiaoyao.li@intel.com>,
	<rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>, Yosry Ahmed
	<yosry@kernel.org>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <aiI6xge3Ev3PCpUV@intel.com>
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com>
 <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com>
 <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com>
 <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH0PR11MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: e27df6d1-c29e-4009-b2fc-08dec2ae039d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: cgYJ8dS0PE+pbjVsZq0XHIgyZzPTqVmv6pJuVcVeoWKuJUviR7mLW8XDozr4azULHdImIfpVkefhtD/QAFEAO7DFYiKGhmTgrHrf3kYmMSX2RZrVaunvJdqeQiHSTVIGfWdAXjsjEtXSUWqk5BTS/c8Q3f81a6yhlKXvc9yf5rnglMWHOCEgdwrtfkS+r0mH/ui2gN5a74GBLHeQMHIN4EeqhEKeAcgG6JJYXKgN1TJs2VgG+ACgP/YD6ihMsUWnqTz+5dhNWq5E3Q1RKfSf+BF6nWR5YstULeO+CT++TY+nv8HXT181EX8NNguqDU7vRi0uVnXx+7iI8nnB2jzG4rlLbHPaLaJ74w5WXw12D9JiBWAO+6sw54JuZcYsqQyvoVim/C672UDn0DZt0BfnuJEBKOx0bBRFYtYEVSrffW7GkjUV8kYNGALQtxJNF3x5Bj8nXv02X/JU4KheOk6R+fC8UAtozFJ2lCxRwlFCkpcCsIrUU30tAoEutaLmlHi6+Nq6FOvZ8G9ZmETKpY7f5FzQOJhUigYt5qPEBdmbQTZ2JGIAUOEhCo5QJ1x6ki34VEHHvSu0XVoTULcQTKyvlJbVNq4nXnAUugUe3R4A6eE9M49RP0USXj1+WeKo014bbyl96FeuD7xHLgwCvvZWQJvN5qmwC6/Lkc2fenLGe5fQgo3wUrgUoKMTxUClKpLz2u+gcUWqePW4g+HB2sOMFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tCd3krU0t6bmdrTlBISzE1a08xZVEyOTR0TFBCNUR3Rm1PVlZtVGhMbCts?=
 =?utf-8?B?aURjZnU5K2I3MFViZTJoRWF5VS9SdEpBQkM3Uk1nVHkwM3ZrcUw2My9qMmdn?=
 =?utf-8?B?SnBmMzlLU0s0eWR0aFl5bGJIQjU1cWNvS2RUYnBobU5xdXhzbDlUdDhDY3FZ?=
 =?utf-8?B?TzRxdjZzc3BSbys0clIrVmh0c2NiR3lLTjFFcVErVkw3d3luOXpQUXdnUEdU?=
 =?utf-8?B?bHFUMEowa25odjJPblU5NWlwd2MrOVhYN3oxSElvK29UMmgwS2JCeTNEdUI2?=
 =?utf-8?B?UGRjN2lFOEJPMUgyQ2Z6MWRpNDB3TjNCTmxNSTVPa0ZMZjdHU1VRUWR0akZo?=
 =?utf-8?B?MjhKTVRoWGN3bXBvNVc3QW1MTy9JSitCTnNBZHZqQXIzRWE3QWZqekxrYnZU?=
 =?utf-8?B?QmRyYjhWRDl4VjhUNjBpZjRUNGVlU1VXSXViTDZkYmhaRnFJMnJydU1Vb0px?=
 =?utf-8?B?MkpvNWlZMCtRSE1uVFE0VkwwbUhWV2lHTEVPS0x0cEQ5U3krUy9MdzdaYmIx?=
 =?utf-8?B?MUo4QkhCR2Q2cEg1ZXNpcmFRL3Bzb0xiYzBSQ2JRMERiRHNLT0JoNjl6SDdI?=
 =?utf-8?B?UmVDa1FqWUdzZ1BOcEJzWXpZdm1FMU14My96M2dNSllobWo2RWxHV3JPcEZG?=
 =?utf-8?B?SnF2eWNua3U4OVIzeitScW9WWnQ5SXVnQlA2SWY5VW9uWE1YWUNsQVZvMGpB?=
 =?utf-8?B?OVJ0VU1KZTlXSDNLa1NzQm9zNm9zQWdnNHJvTkNiTndGb2M2TDRldEhGaTFU?=
 =?utf-8?B?VU9xQVRZMit6K0JoRkNxSVN4dTdmQTRwckFhZEt6bHljcXVWR0VNRTVJeUV2?=
 =?utf-8?B?WjZvcjFPM1NFSzA1S2ltV3VJeGRmSGxhU3ZjdWgyT2pNelNVb3hVWVF0d0JL?=
 =?utf-8?B?Rk5LazNqbXpOYjdFSDhYTEJTYW9oMW1PbDlILzlGTGpsall0OFI3SEVDc0Zk?=
 =?utf-8?B?Mm8yOHU3WHZUb0t6aVUwVWVkdnVyckZkeTJUWENYQWdBZ21CNFd6YUQ2bDcy?=
 =?utf-8?B?MURDVzNOUG5XcHczK1VLZlNqQ1I4N3lRb2Zaak1ZckRSZ3plU1AyYjExSFpS?=
 =?utf-8?B?anJiUGhmV0lFY1h2dzJPTGVaTzh2V0VmaUZFTUlvTDNOVi9WWXE5c3Zlbi9W?=
 =?utf-8?B?SWRCdkVlVElaZW1UN1BLUVQ2alVvZVh0bWd1bUtEUVZzUTZhWTNiWkpKUVZa?=
 =?utf-8?B?dWxMa04vWWNoZTkwNXdpRGt2bElQR0JlOVd1cmZETmJpMzVSZXBnQ3hCM2M1?=
 =?utf-8?B?STlZdnpDYThmd0c4Unk4UG9Wek8xMUpQSGxSSk8wc2c4ZkhsYjNnUFpuK1Fa?=
 =?utf-8?B?aUp3VlYzbm9QR0Z3UEZ5UEU2UUNnc0VDZmdLWkU3ZUt0YnUrVDNGSHpRTmpK?=
 =?utf-8?B?b1Zub3NjejYvYjlWclpnNUhZUEVrSjdFeldkKzJqSmwzYzh1b0FRcDI1K3d6?=
 =?utf-8?B?SE9hQjdIZ1EvUUVqeFhESms0dkorcVFIM25KdWZUSVg0M3I2YnEwODhtL0Rm?=
 =?utf-8?B?aXk1S0FlaHlMdmc1Z0E5UUZFNzlnY2pmeFVxL1U4K3lzQ29IbzJocCtlYTBX?=
 =?utf-8?B?dUMvL1Exb1JrSE1seDVvaXdDUG1FTXJ4MDNrQUZZMGhiSTdEMGZ1Q3R1bWNs?=
 =?utf-8?B?Y0dmTDE4UmxGNTNkdHRTWnNIS1RsU0JsdGZBSXZxS2pOSnl2dzkvS1RhMUhD?=
 =?utf-8?B?UXBEZkEra3JsRDdydkZ0aHBFQlRrcE5YYXpzN21uQ0s1ZUZIYWRUSTZVM1JZ?=
 =?utf-8?B?c294endOeGk0cys4aFIvMXRmMjVyRmlGa2J6bDNycDJla2c3L1pseHdRbXZm?=
 =?utf-8?B?S3RrN01kdHJwUFh5QXZBRVU0aTRvaENqcDd4OFVhZUpkK2pwbngrUGp6clh4?=
 =?utf-8?B?ZTFtWUE2RjRJVnJpejkya0ZxSy82TURLeWNuQXc2UlFBYk9ORW1HMEpqUUJp?=
 =?utf-8?B?M1U0aEtRWnFIRGI0U0FwVERIQWhoSU5xSmJQenNhZ1l2L05HZW1FZGVPOU1C?=
 =?utf-8?B?VE51KzRZWVV4ellRdDVZMzdTUlVsTlREZ081VGRnRXhmdDRBdnBqbm92ZXNK?=
 =?utf-8?B?TlVPd012dlVDY3RUVjJIWStHSG1hU0lISzk3eDFzWFc2VDVNVDBwR3RFeVBB?=
 =?utf-8?B?MUVkdkp2Wk8zbTVqK0M2L1FNeXhJNHVMZWg3a09zWUlsOHFIc21kWFJCYjNh?=
 =?utf-8?B?VEVPdDBCRnZwbHBXcU5NZWI3MkFOREhQYzBZN2gvb0ZwQ1AzTjZBdkdUazZq?=
 =?utf-8?B?MldHWmZSY3dFRk9VZFUzZ2VIcy95a25mbStaMWRhYWNuRDliRExRdlFEcStx?=
 =?utf-8?B?OWRNeFJ6cTJBU01nS0tDV1NBT2diVW9pS0xmKzdIYnJzbjVMK3pYUT09?=
X-Exchange-RoutingPolicyChecked: S16JOGpJ/QaQN0DYpGH7MP+qi1m5RW7tTJEiRuPIaH09bhzaefbUGmMf24VrnxVtkJDM3IgLwZt3Nk38XwVbArIieNqx8bx2mZPTmSmJ2Sue9mEqFcA9FHTjQRXaczZ6A21nCrPv36OzT+3CpKT0/aM1HyyvPQ54/ljLLRa9ahVaEv7HYdWb7IDPQu3yBvgXDyjVwZNsAtvPCPW8zSIRfOoVlaZfe6C+Up+9AyYbHuFClA7jt/m4zPbJ58CwC+mdBLC569GPCkECyE6zUg6NQHuNJrpFOEfU2WOyEigxhQVzYHo+G1rm0qTRi7Gxz+d8UhlZkmHBP0rrYGAp+uaqbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e27df6d1-c29e-4009-b2fc-08dec2ae039d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:56:18.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGR24V0WWj+PuD2UFimfY7rlUiHsNlN2pR51E9QSfmoqn0hQQln8R0sZZw2RX/KJehR+IiOZbiE4Oa4HgMvdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 02:59:45PM -0700, Jim Mattson wrote:
>?
>
>On Thu, Jun 4, 2026 at 12:58 PM Sean Christopherson <seanjc@google.com> wrote:
>>
>> On Wed, Jun 03, 2026, Jim Mattson wrote:
>> > On Thu, May 14, 2026 at 11:35 PM Chao Gao <chao.gao@intel.com> wrote:
>> > >
>> > > >> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large Timer Values
>> > > >
>> > > >I assume the same erratum applies to previous generations as well?
>> > >
>> > > Yes.
>> >
>> > This test still fails on our SKX, CLX, and ICX systems.
>> >
>> > Sean,
>> >
>> > Were you thinking of enforcing a cap on delta_tsc in vmx_set_hv_timer()?
>>
>> Heh, to be honest, I wasn't thinking of a whole lot of nothing.  Falling back to
>> hrtimers does seem like the easiest solution.
>
>I think vmx_set_hv_timer() should return -EINVAL for values impacted
>by this erratum. However, the only documented issue is for EMR, and we
>have not observed the problem on EMR. That's unsettling.

Could you clarify what tests you ran?

I am using the reproducer from Yuan:
https://lore.kernel.org/kvm/20240708055559.rl4w5xfhj3uru6j2@yy-desk-7060/

I write -1 to the VMX preemption timer, do VM-Enter, and have the guest
execute VMCALL to force a VM-Exit. On VM-Exit, we read back the preemption
timer. The delta should be very small; otherwise, the platform likely has the
same issue.

I tested several platforms, including EMR. The results are consistent with the
erratum, i.e., I observed premature VMX preemption-timer VM-Exits, and the
documented limit did not trigger premature VMX preemption-timer VM-Exits in my
testing.

>
>Chao:
>
>1) Should we just assume that all Intel CPUs are affected?

I think that is reasonable unless we have explicit evidence to exclude specific
parts.

>
>2) Is there any compelling reason not to simplify the limit to 2^25?

We can use 2^25 as a conservative bound, but it is much lower than necessary.
The current bound comes from theoretical analysis and was validated on multiple
platforms.

>
>3) Is it just coincidence that 25 + IA32_VMX_MISC[4:0] (on EMR) == 32,
>or should the limit be calculated as 32 - IA32_VMX_MISC[4:0]?

My understanding is that hardware scales the preemption-timer value and
converts it to a 32-bit core crystal clock counter, rather than directly
using a 32-bit TSC delta. IA32_VMX_MISC[4:0] likely participates in that
calculation.
