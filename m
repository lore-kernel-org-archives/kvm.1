Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827252FE074;
	Wed, 14 Oct 2026 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956231; cv=fail; b=uLNAfH2pFd88/rcCuQUqFhJB/FVbebz7POrMlN1LAH2tx9VbBpp3zcPQIMP+WhQqKb2PMKqqz+n+nUFynJRydxEXasGrlMNhBsv5IcFeZINE0lYVHPGwNB4gBaqoWCzsxM7w4/QPC3PlpoyQ9AILPQrqKOQ2pVHxdABZNp/mCq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956231; c=relaxed/simple;
	bh=YMaweJgoMkSZdRIix3ldFY0SUdOOBVsZY0uRVbtLiPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oO/aQh/tpyqKVsEYD9NI7uvyasMomnp4ahl+90To6pZIa1lIyUxe8W2nCpGNFw5wDAjrU2ODzOrRLIlC6kgl5TBkTjkO5moq+ozH1hT2M8Vxf1pnOZBWC/evWEiDYpBfGiaMT07Burz+gnObengQKqubH1pa4/Mil0kbllMN/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTvpUZLR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTvpUZLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791956229; x=1823492229;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YMaweJgoMkSZdRIix3ldFY0SUdOOBVsZY0uRVbtLiPM=;
  b=iTvpUZLRk3fzNnvrCicCh6oJe93c8MZDStUqa764swtFU9SkfwoZf1ha
   mN2i6d9kDKGGJ59SgY84fCgMk/cCXIxugQcVttXX+tXChYq7OZNPcxAWe
   lVS5JkYBhPdUsrzLBpmkpTPFz+1q/E/BDsIzY2i4s8srHwcWNqT/ek1qD
   vQ26sCc7fLXOedxdAnDU08AlAmwAlKIK1naOEaafjJij4rmkgcm3qk80L
   3sVezyKJkMmCB2ex5wmHVYTeEe02ZwzLKYtFFfV9KYH37OhZDvSBlaNyr
   iDgjjQo3EJkNFSDXgTM81l6sg2NkaALlEsVBTKhCCRvR/DStiItrwlXAZ
   Q==;
X-CSE-ConnectionGUID: 2DCL6Ta7TjCGiWOgVxDzNQ==
X-CSE-MsgGUID: cD+40AnISXm7tXaK0njvxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="584164"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="584164"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:37:09 -0700
X-CSE-ConnectionGUID: FLeS3HxVQGaGrDTgTsHSzw==
X-CSE-MsgGUID: ZjuQZw1WRbaIQ8t8rken1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="3185532"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 22:37:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:37:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 22:37:07 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 22:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMk7gOxPIFL2Bp16wFhgVUC364OfeuGZkCfTMFTNmZReD7EJN5BX/HDpKcrVEYIW2+dldXcSq4rmfO2UinuzUDLB6Og7aRj1cY9fDo6ndF7McjE8hHe85lqt526dIzSdb9Hpv9vPPR5pI2CooQPk2M/mZn33hq3iN31olV6UGZNa912ZF8S5mOXUxV8MX0U4eoM+DPFox5f9WpJNXgU8Of3Nw6LcUWCXZkK82isMnx7XHfAOdeVwQhNFHMgKZ+Ekgs91+2HnpXXoqmkywdwsuVIIazSRK+tcxoA/oII2CZBYUVYgiGEQplp8f79dEoAMWOukl+9A9BJfDlVqJXJyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAOhCL/z/+OY5XE+Rn91ja2sWpd5tevd1pZW4BKe0lM=;
 b=Lr1YiyGyyGLPGe7lwsfBG+4SX5YAPdsSi5gYa65dYQxS/etvsfTeUC937bPnR+acR1VckbrJtAaGWWR++c2n5uvOdyKhzDMAHJaWQdMhkgDB+YHCf6GtsdwOc5X2uBYsOOCflEpNY4uBVPw2DdpA47jlWFhdr6pOsSYEDC2CieguCU6ERx74B2tSfEuWW7f6oYfTqrL8xVhS10LwR9TqmfACOHlfavjzllAnouDGBMxQsF8tG8utp74p6WPgF5MlQnicP9ROAExP06KBa3A3/7q0lwBEvHGG421wwHf8eJjV+yMmElpG6LZrKN5q1Ibjbe+UQ7vFiF7H79O/26a7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3245.namprd11.prod.outlook.com (2603:10b6:805:be::32)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 05:37:00 +0000
Received: from SN6PR11MB3245.namprd11.prod.outlook.com
 ([fe80::9a60:375d:1803:4312]) by SN6PR11MB3245.namprd11.prod.outlook.com
 ([fe80::9a60:375d:1803:4312%2]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 05:36:59 +0000
Date: Wed, 14 Oct 2026 13:36:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928091035.15599-1-yan.y.zhao@intel.com>
 <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
 <e126bda86263fc4d6af53112eec01a95da48570f.camel@intel.com>
 <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
X-ClientProxiedBy: PS2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:300:5a::23) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3245:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e52f0ab-eaa4-4193-1eb3-08df29b529cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261009223027099003|10067099003|4143699003|5023799004|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ePHGlkKXasARdEi/ImlPaSacGsrwtcE5JulTKnmcPnPJ8v1Ukll4khA7aUqPVaZjdccLuthNDtErlVe6ssCDAA09LdzduSwr5KyYMRgRSasNE2Vdk1lJtUbQNQYiVZEWhZOYtj9QNh/DqK9MUmpEv3Y782g3QzvMVKAQ98LNli/sbJn8LRovRl90p7W1p3vreOw1TaCac8wSxvS6zwHXMbPkx3esGiy9S4h6k8B1frMnwUpi4Yk3RzkXgWc18b0fFUx4FYlwePGVvS6tQXZWpQKd0ClIN591LS/RSajfRnuphL4imPznI8slfSu2F/JWs3iPucSyeK6VjmHPuPhRxPahCx1pPXw7gqW7prGF1ZFc7YEkCtHQ5AwIpIlGVEIhDId9Mez7ht+YQ9SxqCQMVYbPcRUdqQErQbmTTjutMz+35lvQcy0KYeYu+P4zbTE0G7YZB/L626SXHX317gOXnO3JY9+WDePlmOcDZR1Q2eUpgaRITPypSjcDzetNUTs8ZQhDZT+Fdu+rMJ4NFQLVUKI7yfIE9Kmbz34nBTgoKb0R7Ps7rPlvzgFwEBhOR+xnYFcpr+fK2QoepxYVJZdKPqPSX/6+C48n9NHw7dsyHIED3uj3KdO4JSVWrI3/EnBn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3245.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261009223027099003)(10067099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jIM0Etq4qMxhNJXD1BgJ8+74Rkzc65ja3uyuP3AlaEVNBYqilVLKDSn9MG?=
 =?iso-8859-1?Q?rO6GU7dlnJ4Y68FafOvvrP2+UA2XXYyGXNtfSMTnQZD5D/H/v5bKSudQgU?=
 =?iso-8859-1?Q?6IiHFtpkmZQ1sAPZiE8JkI+kbaCowseDgy2pbdclz4ZICjqQhOteyOLS08?=
 =?iso-8859-1?Q?lFyMSIrMSJ4xHKX7D/HU0uRsaWy7ip9R8sNMbBNpSNeZS+ItIJ84X3gX5K?=
 =?iso-8859-1?Q?KBBuu5+oZxRIIruZc/Mieim+w5GpcVhHrzHKtgMdsXtwNvx8VIq3FvrHG/?=
 =?iso-8859-1?Q?b/hpFliHK/rbQbCYJLGEko//a8j9bguJIzAefLoSZ02kWqoPHeyQJdA6Wy?=
 =?iso-8859-1?Q?L1opmYYJHmZMVmXRGG+cnZ8EXIbSzaRiUFCq7zfi3wLtGXTjauZ5XMqCJg?=
 =?iso-8859-1?Q?ejgzPmPi23SOEcv4TrvFNlqIQ3sZ1/GXLKCutg95mJ51ejnQMmJqXQ8B/D?=
 =?iso-8859-1?Q?ezOw0qjSXpzL/XW4kd/dLBpqZaTXHD4QwjQ7+DwlAdxl0f/8ITDmf2H0lX?=
 =?iso-8859-1?Q?Z44MHVKmSKCV7kbwJ5v8CqZ7rDzKxwOnU8zj+OYKls0xi6fQcPUOl/Zpc5?=
 =?iso-8859-1?Q?TwftfwWI2ecWXFC+R891HBVKGfKbAtuFhwO8JBBwB4nkNGG6sh6w5bCj0n?=
 =?iso-8859-1?Q?LU1qVrFwL1aQciQdR+9R05W271hH0uogL2MxrFDpXXwwJaOV3AUONhNR+l?=
 =?iso-8859-1?Q?mM3Ockx2Tmwfme2efGWGNbFfPoCLfWZo2967XosTg0xg18tfP7vJ2017xV?=
 =?iso-8859-1?Q?2zeXtXTzUQt072kT8y+gugFyG5i4qNX7laRQZzS0ztmKeHxyE3DWvn+AnJ?=
 =?iso-8859-1?Q?dIsEUgg10b2Q9PhOqX32KcQwUwhNyXwgVRQR/aCGI2+Tlwrw69T9YD6FzX?=
 =?iso-8859-1?Q?ycLREgHHNHNVYp84TyRDqfddkSUAw0bXvCCpHWcqQjlJrYu1jlTK332nQj?=
 =?iso-8859-1?Q?FIxSzJMxtuw2WOW8NWd50kQDfrEKOb9SEIgK79Ao19ZVPcGT5c/BaFhi+0?=
 =?iso-8859-1?Q?uGZYc6DzzO/IjpDmLXM/fndqwfGoWiG1FHrQnNhSr+dxcRSu7MsW6hnkiV?=
 =?iso-8859-1?Q?z66KE+UBrOHjGrA4Nz9pcPOz59NRmKGcjdThSj/2D55rcBESam5I9wWURH?=
 =?iso-8859-1?Q?Zrv1nb1sjCufdn0PJRXA2qKoSCSVzv84cm5v5KZpgma9icQnXjDfmIWNpM?=
 =?iso-8859-1?Q?mRGaTU9HQqgGxq+tdjr/8/KObwdPDBcnMQxaxltyRVRr+FboQyG5j2e+ks?=
 =?iso-8859-1?Q?/1JIUXn31zuLcsHhyl8cgUx7f+HubeTGd2bsIvEZ12UaKKzUQ22DCflMq3?=
 =?iso-8859-1?Q?RRL1+a7KVlaw5/3+0Pu5Q9n6dvXJPU8hkzYVWWnUyNObSLVZSd9n55IjT3?=
 =?iso-8859-1?Q?STloYMnAA3al4u8LqFWEnClQoOW7jH2n0e4/sO2A/P5/OZ1hOQnSrKB022?=
 =?iso-8859-1?Q?59SV6yjy4cKrlrPPMZoXFQ1iOz3pmeiIWGR6H9q4crM35YMFh698sWPnDC?=
 =?iso-8859-1?Q?qRTxdJrR/54wOc47hjthhEUAjsKqivJK/hY4HhK2lxkN5aS6t65ad7dPxo?=
 =?iso-8859-1?Q?iKKzNlhjorcPiCJJUMTUmTx1n/xEmQaa3+wDueA1dA7UZhmpyrhxveARg3?=
 =?iso-8859-1?Q?nZB62yZXp288xKZwBHpVvXJBy5ivNX6pdnkgfLrCa37OBfQaaqukondBcl?=
 =?iso-8859-1?Q?YZ3eNUBGTCiHVMId6+jia0qpeLpcV+R+bQgNL28KZIj88Hmtpxj9YhdY0x?=
 =?iso-8859-1?Q?JtLJc7WQPMT0I2IsNb7TvlBZpVWWWyTEnOJcyTwwSrpsmsnpgESnPOJJXx?=
 =?iso-8859-1?Q?dXctc7N6yw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0g/zTCZ35zmy8ZUIDEDrYmVoWpemqV1HFyNmWn302YvMMIrMmWj8kE2en8zK6thlGAK8ZxyRPfimu03xgdtf1uSnQF7hsqTA5X62gC12okena17x1vGY21TvRF5cUoLeSnhCVkQZlIro0K0WxSB7sbfhfnbt6UocRY8CH02QBxQ9D5TGQxDgyYkunq0NmA5cgW/yUWeuNs/wRcjJYwMCix7ugU8/8U7FkadLTBYB/UEuQFz0es++4jf9ekKfoK/LympLLAVe+XLIf1rIgkxohqDrqGAZzLBXnv0euPSoGjbjgaWNjsekN9ddvhUu+ss09WHFHFQh9tTV5016pRnUFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52f0ab-eaa4-4193-1eb3-08df29b529cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:36:59.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4OuvdqRghgpBax4puTiU3aM3vKyrM5XFqAai9ZoCKKZ9tVlkZo6kA5/pm1LrElBn7vY1WyubtgfFU5j/it9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 12:36:13AM +0800, Edgecombe, Rick P wrote:
> On Sat, 2026-10-10 at 13:13 +0800, Yan Zhao wrote:
> > > For fault:
> > > topup(true, true, PT64_ROOT_MAX_LEVEL - 1)
> > > 
> > > For split:
> > > topup(false, false, 1)
> > Hmm, having the caller perform the -1 calculation gives me some hesitation.
> > The meaning of nr_extra_spts is not straightforward, though it seems to mean
> > the number of spts excluding the root.
> 
> It means "extra" beyond the root. How about:
> 
> int topup(bool root_spt, int nr_extra_spts, bool private_page)
> 
> The idea is to tell external infra what the fault handler might do. It might add
> a root, it might add a private leaf and it may need extra spts beyond the root.
> These are all concepts known to mirror EPT and also has all the info needed for
> the calculation on the TDX side, and also doesn't assume anything about TDX
> implementation from the mirror side. There is extra info passed, that is not
> needed. But the gain is that the code on both sides and calculation are self
> documenting.
It seems strange to me to have nr_extra_spts if root_spt is false, in which case
nr_extra_spts are all the spts the caller wants to topup for, so why call them
extra?

Also, is there a case where "private_page" is false? I can't find one...
Specifically for the "split" case (patch 6,
https://lore.kernel.org/all/20260928091005.15567-1-yan.y.zhao@intel.com/) where
.topup_external_cache() is invoked in tdp_mmu_alloc_sp_for_split(), how does the
caller (tdp_mmu_alloc_sp_for_split()) know whether private_page should be true
or false without TDX's specific knowledge?

So, I propose dropping the private_page argument and renaming root_spt to
has_root_spt. i.e., either:

(1) int topup(bool has_root_spt, int nr_spts);

or

(2) int topup(bool has_root_spt, int nonroot_spts);

I prefer (1), as it gives the caller the freedom to always pass
PT64_ROOT_MAX_LEVEL even for 4-level VMs. Additionally, has_root_spt in topup()
in (2) would be useless.

int topup(bool has_root_spt, int nonroot_spts)
{
 	add_to_cache(nonroot_spts + 1);
}

> > private_page arg should be unnecessary, since the split path also needs to
> > allocate DPAMT pages for the guest private page.
> > 
> > > Why have root as a separate arg even though it is never used? Because it
> > > makes
> > > the logic make sense from code KVM.
> > What about:
> > 
> > int topup(bool has_root, int nr_spts)
> > {
> >  	add_to_cache(nr_spts + (has_root ? -1 : 0) + 1);
> > }
> 
> "(has_root ? -1 : 0) + 1)" is going to need a comment. So I was suggesting just
> to make it obvious in the code.
like this?

int topup(bool has_root, int nr_spts)
{
	int pairs = nr_spts;

	/* the one for root has been allocated */
	if (has_root)
		pairs -= 1;

	/* for guest private page */
	pairs += 1;

 	add_to_cache(pairs);
}

> > For fault:
> > topup(true, PT64_ROOT_MAX_LEVEL)
> > 
> > For split:
> > topup(false, 1)
> > 
> > > > Besides, I actually introduced a separate cache and op for split in v3,
> > > > https://lore.kernel.org/all/20260106102345.25261-1-yan.y.zhao@intel.com.
> > > > Sean merged the cache/op for split with the cache/op for fault in
> > > > DPAMT+Hugepage v5.
> > > 
> > > Yea, but he didn't have any big assumptions in it like this. It was way
> > > simpler.
> > Since the re-insertion solution looks good to you, it should be not be too
> > complex now :)
> > 
> > Given that the fault path theoretically also needs to address the root-only -1
> > calculation issue, having split and fault share the same op seems reasonable?
> 
