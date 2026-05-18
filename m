Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28130481FD6;
	Mon, 18 May 2026 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113766; cv=fail; b=Whyb3TDh+p+0m9etgkU7YABizftgslJfoZf6AsOIXsJ+++7cy8tDyI1FQDgxilMYRwNiiOlkxCvG+mSszno0pUhgVFlMCojoRWTKsQBHdatp8lub0GWgonpEw8SjCwhreHpQXcP3qlChfjadP0HPzADhZadv0P+1Mv8TgwqTkGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113766; c=relaxed/simple;
	bh=+q/6ZbD6p7Tn/pvcF8NR7RLkVnggyDTjwtBLAqQHyj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xb7d9ZeJtMFdC3PnmL2ZBzdUC/5BBRb5HZkHeY4kKn3I3RI4oszIY6kcE7nI84LN3JvF6bJZ7w/Sfpo480fWzxaYM30cJZaXnveGT9mQFFQav7AkzH7t0wr9ey+yano6lkEMzxgmI7iDPkJLKdRkLKe3JLsAJuK0FvnGZmhpOYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2H8HD+d; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2H8HD+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779113765; x=1810649765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+q/6ZbD6p7Tn/pvcF8NR7RLkVnggyDTjwtBLAqQHyj4=;
  b=l2H8HD+dYRfL/CQHJxiYvHJRaWPbLH2QdhkYWwvv4/nL597zmwdGQIS5
   tdYCnZkEDVPpSf6B6RcSvUIaqlp8Ji7y+IpZAaGDVU7VOJfB9vKblrEFx
   rpQVg88XEb1ZbeuNJwbrshlNtFpslLxAIpeaGwofLPapQvuLKf8nrswoy
   lIR4pxZv5a2+HAK/D893U96fpvmf1oJZ1PCjN9EZh9nuJRNZj0leiuHXa
   wxf4Fc2Rmqx9RZYxEavF0pb0QaZ0JDKzjFViIYHgCZr+cZyj4uv6/Ajr2
   vmpKpMe69BAkONZE5Htxh4xgjWob6IKS//glDw3A4c6c021qnceucc6sy
   g==;
X-CSE-ConnectionGUID: Bxu6QZYfQQmJN/+/uAKpbA==
X-CSE-MsgGUID: r7q6rL/PSRSoUJr0Mo3PFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80086648"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="80086648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:16:04 -0700
X-CSE-ConnectionGUID: M0yJLpHcRUGugJlxREIsNw==
X-CSE-MsgGUID: 0RuNcu3MQyauey89DHtiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="241249330"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:16:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 07:16:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 07:16:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 07:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K73NqG53BhuS4Q6Vpz5GXT5P1G3H72aKfoS3TDaJr0siOJp4bzzJBkS+vgb5B7j1KtqQOVFgHlXK0lKPFh67uI9yDe3Hw0D9b6/tHFxRGmfsn4lKxgiW7N59g8LuZnHNHhPq4CQZ1swUzD4j7TZ6PAF0NXfoh5kbwfan7gRr+a4kz5WwDDQLisOz+Z189/hG8scpnGxEmsd2bfaDLjSr2sVlVAtK5UYksrnv3DbjaxOJ4ZyKrIGFjjK2d6Zvrq0GkB+q6syl883a29ResIzsBilkssAtKsUnCANq48dphyOeA5EE+yUhDUMiw3tEgWj10+rRC5+ZpSL+LLHSnBbryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIjcdbIyduV4LAKa3dDEfvIHHr9ql7Ul8auSBidZRRQ=;
 b=TJob2VK9zaBQVglQGNvCb+/KsP4FF+GVXhBaOeJE/NPJ8kXN6qb3eL0Y48Tkmp4T3v4JxT1R0cXyj2BmXrFTAzxPlNDVzMGIeQQs9wh7gDLtgeM5u3sxo3rILzL19aTCSQVbtplU1n3jnPa9n7RQSxHpFdqWkevXsVUwyBAQsSfyoopGcntTyfBn5zxOnKRSvnNgrSv2ClUWNmhfgdALr2+ASbBzQAkT55fzzavX5LgBBKT6pV1uSA5LpEij71dQVnfkxt+WPV1dVCjH9OnezM/iRXF1RH/Z9m/MaRWhzYxt+uGz1j7WxftQRQkIrof+AvEHvgSV21JW/hg7LlmHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:15:57 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 14:15:56 +0000
Date: Mon, 18 May 2026 22:15:38 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <agsfCsvcILh3Vg7a@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-12-chao.gao@intel.com>
 <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d7fff5a-53a5-439e-9ff8-dcbd97f473cd@intel.com>
X-ClientProxiedBy: KL1PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::18) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d087dc-cde3-4580-a01a-08deb4e7fa50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pIm2jJCT/ob0K1KPoFss+pE6pzHenXlZYora1aPN9E3ZflFxkGH7d+B+530dmaD3qZqYU+pSOJI5ooKYA+r2ONc50HKOZZ4gpEQAaWgM3JxgIugX/C4/bpESR4pC+QvIfhPapiMo6lnkgmYOirk2kAXt2JlCHlo3U5w0Xs3upDiKgmfVhu0IMzbE36yDUukudNqrvw3ZVId19Mi0AH4erpoH81okkvHyZsoQaUEqeVgodHhnWXACxr50YPvHi3t2H/Q0QlvRDqlhreoKLLCnfCwe9+8MSEFTKJh9a3bvAkP3tHjE3mKsjI0mbg4ESW1uulRA9qYtEdO7ayzzUbMsfPM4RHy6fi1itb+UDKPfL5n5ZbRmilDktSrhjsbzrjjJPNXI+rfAjitcgnQAX9yNIJXcj7IqFJcI4EU07PdoVKcM1s7XI6BDiXaYlxqgwHlvBjlk8nJtFBNPQr0GL6aIs6G2ey/Z1MJE8J0CYuGVHyEcnrflyhwtpxHk5P4bN9dSPoLKoTm+TjFO0AamLmXHB29+89RmhWsoK5UjHVJyTLJiFN/lej09elN7SqNJi+vDwiipP802hDpakQ4gI2m8Rx7aPYgjCQ5DAA4AyRHaERbTMjft5oBBLGIqGB4GothlbBp0k7sofY5mE5fU9l8DkS2yQRIOCTlLxZ0LGD6XKLFKV2PxFbnrcxgreM9gS/Na
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efGbQk5BokeXaqD3UOjkrYLoMXDDCvdyxQd0GKKEhkl2IJufzXU1USzITWKU?=
 =?us-ascii?Q?AxYZREGDRwQx5w6C6vINTocq7rkiahl6x5i7/KasZ25XpABfvY6iAy44yG9H?=
 =?us-ascii?Q?Z/9oUDC6kCGft1mJlMNaGHgdVQ8jgk0S+3txmkh36nrc8AT/TcnePqXHcZ7a?=
 =?us-ascii?Q?m9QBavLthIalkVUPfX+LB2gxfgfbH9Cx1i35h0d7YxyXZ42AAe04WKxVXbQK?=
 =?us-ascii?Q?Iknra2L0HQrjRLP5QWDTDpAjYrkXV/nUFmR+gSSuGlGp3O6RCgjbMbSuHCEX?=
 =?us-ascii?Q?7v37ECPX7/oKqyR6kmz/xIiIZlbBd/bLgEyNNli+p0vl2Dl8gxhyt6SCu30G?=
 =?us-ascii?Q?TCkSbdtVjC+QjnKYAtEdHuknQaxuYQ+2go9Z1rR5xZAWUoPb6IDNCtly2Mdn?=
 =?us-ascii?Q?+KN0PixQIgxSdyvUsS47vd3vFvZnZHNT552L3gDiEADC0uqcwnzmnM4P42fk?=
 =?us-ascii?Q?s3vb6nMgsG0TO8w2E36zyHultM3eoNBm9//8t66vyvwNySu/fan05jQiTYAh?=
 =?us-ascii?Q?IeF4UqMq7dTEy/0C5pKQNPVK/k1j3dbt2gINhXTeMPEByfB1lAtYH1A6YMXt?=
 =?us-ascii?Q?ATLaNqBAYuHbgGxcKJBoioWzGTmoVQIm+32di98JmFdpuUmANabfwNuiRuxj?=
 =?us-ascii?Q?bzbG0fiwnIZ/FegRRbxdq+Hc2inv6TUHri27E3Wh/WaxlAIvcdH03mBiJ84M?=
 =?us-ascii?Q?o2Q8mIuCF/l/NDgOvG3PhF8/Si8Lsc4Nb6UJA8tELL4uuxQlRl+7apxI6h/0?=
 =?us-ascii?Q?tseYlziLVMC1n59ncM6qdAcTX0Bhg8ltmT0cz4vE+jA3FqDRqmlBZnjmkn9P?=
 =?us-ascii?Q?bada2dcs39pi1k26yN3HWUFv090ly+CXC6Kwee1reMkSV9RMfgVj5m+CM37M?=
 =?us-ascii?Q?+izoJEjy8A+TAOOg0I5onGjp6YN8JjXnqF6r1h3W1se7V9Ug6PG/Rrbm3bIh?=
 =?us-ascii?Q?p1u+yShqoLhFZI50zk4ffzlvoqaqyY63GfdwzgdxoSGWKjOh0TnvzYu6c4BV?=
 =?us-ascii?Q?pT0dfYVaHZ0Z+e9r2kYp2pvEP71ZmJ76GI3xRJha2xlf5VOTsu6mDq1JFWER?=
 =?us-ascii?Q?NbWNzMxkexmuJw+P3kfQmgVggl4krAcFPYwlWrtoDmSiajO6Lz8fyRcX8iko?=
 =?us-ascii?Q?LaGydj95IlNzc9qcDdZslHULun586XaFiM4D+cUeDM/pTfQYIQB7uMUZcuZ1?=
 =?us-ascii?Q?g3Ie+eVlF5EHXEEEHgSfhiTsIVBZbqXxXLeoxNcdBnPC2hroQbAu7udD5/Sp?=
 =?us-ascii?Q?X9Avrf30o2BhzjJeTevno6M9TRSE2ZNiaZjA4p5hMPzELHQe2AozOSm3yOAD?=
 =?us-ascii?Q?RF9lL2Xoq1/Ep8GnmcAIGlfg4ZyuXp+PmXTw/EN4e1ApYdP1iFh5mGEfVMTn?=
 =?us-ascii?Q?fkbfO50QWknvmpI0f/YetTJXIJ6KTfgsDI+xPhIBf3A4BpIItbxR/d8dcoFe?=
 =?us-ascii?Q?o9QRaKiHUUXxp7tdx5blUa+URW7a3pZ1AHdSTLKYJpiruiF1YzNw1N+xf2dO?=
 =?us-ascii?Q?qi0mUavl59QqfpgNZZ3ZRKsRC9jL8lBCVHPzB13EHa3yg0TENNWPX2y0Mfod?=
 =?us-ascii?Q?EscpvUXUoCavuGM3BfqtfxN20V13YkeJHEgrV0XgrsBhfsedEpWdi6NYsstj?=
 =?us-ascii?Q?IoqlAV7UhGHU3aQpwU5kgFjTDPquR1CPTW5fDXxmi8vXuS1qGJuqcUuZOW89?=
 =?us-ascii?Q?PI+LyLeP3Y9BFgigNDxkafN7VXkia6pkhWqIVyTWcF2TyrvrVMnjomIYtwWw?=
 =?us-ascii?Q?6OVtkNskWg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hCFljUEwRAW+9QNkHJt1w1hEpCRGJHjIH1eb1Y10ye+giJvhtchGkvPbc8Y2pdsLHt07cCMyNvKE4b4NC5ANxTRC+wzwdEGu0ZYx/xORK4nD99lf/8y75DwECodfR93av60LMVnCewdR+8lP0N26T17RK93mBRxDH4APDiQB8sfLB+lZpkbk2+svE68EOuJXLMKLF08mTMqWBe6jw/wx6Gs2xzMmr/I1s/EWXXU0/XxkF7dSWBhgKZS1RI64tPudni3bpOGhz0BduRlv4q0guKmbYO1nqyWCdxVkCoJ7b+H/4o/RdvWljnpBWaFtmT5MNxtyWmUyxatG3yE7lkqi2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d087dc-cde3-4580-a01a-08deb4e7fa50
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:15:56.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XOgBXthCxT+QRJHX6T25QzmyowpaU7r5ddfKUYBPPjF4CntQ9dSdLLKLiZX6yVFA2FNNpKvBvI/Hdqs1lL9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com

>> +#define TDX_IMAGE_VERSION_2		0x200
>> +
>> +struct tdx_image_header {
>> +	u16	version; // This ABI is always 0x200
>
>That comment reads strangely in here. Did I ask you to write that?

I copied that from the example you suggested for this structure in v8. But
yes, it does read awkwardly here, so I will drop it.

>
>> +	u16	checksum;
>> +	u8	signature[8];
>> +	u32	sigstruct_nr_pages;
>> +	u32	module_nr_pages;
>> +	u8	reserved[4076];
>> +} __packed;
>> +
>> +#define HEADER_SIZE sizeof(struct tdx_image_header)
>> +static_assert(HEADER_SIZE == 4096);
>> +
>> +/* Intel TDX module update ABI structure. aka. "TDX module blob". */
>> +struct tdx_image {
>> +	struct tdx_image_header header;
>> +	u8 payload[]; // Contains sigstruct pages followed by module pages
>> +};
>> +
>> +static void populate_pa_list(u64 *pa_list, u32 max_entries, const u8 *start, u32 nr_pages)
>
>The naming in there is painful. How about:
>
>populate_pa_list(u64 *pa_list, u32 pa_list_len,
>		 const u8 *vmalloc_addr, u32 vmalloc_len_pages)

Sure.

>
>> +{
>> +	int i;
>> +
>> +	nr_pages = MIN(nr_pages, max_entries);
>
>This seems wonky. Should it really be silently suppressing things if
>either the allocation or source is too small? I get not wanting to
>overflow, but this seems strange.

Ok. I'll add explicit bounds checks and drop the MIN().

>
>> +	for (i = 0; i < nr_pages; i++) {
>> +		pa_list[i] = vmalloc_to_pfn(start) << PAGE_SHIFT;
>> +		start += PAGE_SIZE;
>> +	}
>
>At the point that you modify 'start', it's not 'start' any more. Use
>another variable. This would do, for instance:
>
>	for (i = 0; i < nr_pages; i++) {
>		unsigned long offset = i * PAGE_SIZE;
>
>		pa_list[i] = vmalloc_to_pfn(&start[offset]);
>	}

Good point.

>
>
>> +static void populate_seamldr_params(struct seamldr_params *params,
>> +				    const u8 *sig, u32 sig_nr_pages,
>> +				    const u8 *mod, u32 mod_nr_pages)
>> +{
>> +	params->version			= 0;
>> +	params->scenario		= SEAMLDR_SCENARIO_UPDATE;
>> +	params->module_nr_pages		= mod_nr_pages;
>> +
>> +	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_MAX_NR_SIG_PAGES,
>> +			 sig, sig_nr_pages);
>> +	populate_pa_list(params->module_pages_pa_list, SEAMLDR_MAX_NR_MODULE_PAGES,
>> +			 mod, mod_nr_pages);
>> +}
>
>Yes, this is starting to look OK. Nit: vertically align the "*_PAGES" args:
>
>
>	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_...,
>			 sig, sig_nr_pages);
>	populate_pa_list(params->module_pages_pa_list,    SEAMLDR_...,
>			 mod, mod_nr_pages);
>
>
>> +static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
>> +{
>> +	const struct tdx_image *image		= (const void *)data;
>> +	const struct tdx_image_header *header	= &image->header;
>> +
>> +	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
>> +	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
>> +
>> +	u8 *header_start	= (u8 *)header;
>> +	u8 *header_end		= header_start + HEADER_SIZE;
>> +
>> +	u8 *sigstruct_start	= header_end;
>> +	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
>> +
>> +	u8 *module_start	= sigstruct_end;
>> +
>> +	/* Check the calculated payload size against the data size. */
>> +	if (HEADER_SIZE + sigstruct_len + module_len != size)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Don't care about user passing the wrong file, but protect
>> +	 * kernel ABI by preventing accepting garbage.
>> +	 */
>
>How does this "protect kernel ABI"?

"Protect kernel ABI" was imprecise here. The intent is to reject
obviously malformed headers.

If the kernel accepts garbage in header fields today, userspace can come
to rely on that behavior. Later, the kernel may start validating those
fields more strictly or assign meaning to fields that were previously
reserved. Rejecting the same image then could be seen as a kernel
regression.

I'll simplify the comment to:

	/* Reject obviously malformed image headers. */
